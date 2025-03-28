// Console input and output.
// Input is from the keyboard or serial port.
// Output is written to the screen and serial port.

#include "types.h"
#include "defs.h"
#include "param.h"
#include "traps.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "fs.h"
#include "file.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"

#define INPUT_BUF 128
#define HISTORY_BUF 12

struct
{
  char buf[INPUT_BUF];
  char history[HISTORY_BUF][INPUT_BUF];
  int last_line_count;
  int history_line;
  uint r; 
  uint w;
  uint e;
  int newline_pos;
  int end_pos;
  int current_pos;
  int is_press_ctrl_s;
  int index_of_ctrl_s;
} input;

#define C(x) ((x) - '@') // Control-x

#define ALL_OUTPUT 0
#define DEVICE_SCREEN 1
#define HOST_TERMINAL 2

static char selected_buffer[INPUT_BUF];
static char reversed_buffer[INPUT_BUF];
uint select_in;
uint select_e;

void putc(int c, int output);
static void consputc(int);
static void cgaputc(int c);
static int panicked = 0;

static struct {
  struct spinlock lock;
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    x = -xx;
  else
    x = xx;

  i = 0;
  do{
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);

  if(sign)
    buf[i++] = '-';

  while(--i >= 0)
    consputc(buf[i]);
}
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
  if(locking)
    acquire(&cons.lock);

  if (fmt == 0)
    panic("null fmt");

  argp = (uint*)(void*)(&fmt + 1);

  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){

    if(c != '%'){
      consputc(c);
      continue;
    }

    c = fmt[++i] & 0xff;

    if(c == 0)
      break;

    switch(c){
    case 'd':
      printint(*argp++, 10, 1);
      break;
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
      break;
    case 's':
      if((s = (char*)*argp++) == 0)
        s = "(null)";
      for(; *s; s++)
        consputc(*s);
      break;
    case '%':
      consputc('%');
      break;
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
      consputc(c);
      break;
    }
  }

  if(locking)
    release(&cons.lock);
}

void write_repeated(int count, int character, int output)
{
  for (int i = 0; i < count; i++)
    putc(character, output);
}

void putc(int c, int output)
{
  if (output == ALL_OUTPUT)
    consputc(c);
  else if (output == DEVICE_SCREEN)
    cgaputc(c);
}

void print_row_index(int index)
{
  write_repeated(3, ' ', ALL_OUTPUT);
  printint(index, 10, 0);
  write_repeated(2, ' ', ALL_OUTPUT);
}

void print_str_without_buffering(char *str, int output)
{
  for (int i = 0; i < INPUT_BUF; i++)
  {
    if (str[i] == '\0')
      return;
    putc(str[i], output);
  }
}

void show_last_five_commands()
{
  int count = 5;
  if (count > input.last_line_count)
    count = input.last_line_count;
  
  putc('\n', ALL_OUTPUT);
  for (int i = 0; i <= count; i++)
  {
    print_row_index(i);
    print_str_without_buffering(input.history[i], ALL_OUTPUT);
    putc('\n', ALL_OUTPUT);
  }
  putc('$', ALL_OUTPUT);
  putc(' ', ALL_OUTPUT);
}

int should_exclude_from_history(char *cmd) {
  return cmd[0] == '!';
}

void handle_tab_completion() {
  char current_input[INPUT_BUF];
  int current_len = 0;
  
  for (int i = input.w; i < input.e; i++) {
    current_input[current_len++] = input.buf[i % INPUT_BUF];
  }
  current_input[current_len] = '\0';
  
  if (current_len == 0)
    return;
  
  char *match = 0;
  for (int i = 0; i < input.last_line_count; i++) {
    if (strncmp(input.history[i], current_input, current_len) == 0) {
      match = input.history[i];
      break;
    }
  }
  
  if (match == 0)
    return;
  
  int match_len = strlen(match);
  for (int i = current_len; i < match_len; i++) {
    input.buf[input.e++ % INPUT_BUF] = match[i];
    consputc(match[i]);
    select_e = input.e;
  }
}

void
panic(char *s)
{
  int i;
  uint pcs[10];

  cli();
  cons.locking = 0;
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
  cprintf(s);
  cprintf("\n");
  getcallerpcs(&s, pcs);
  for(i=0; i<10; i++)
    cprintf(" %p", pcs[i]);
  panicked = 1; // freeze other CPU
  for(;;)
    ;
}

//PAGEBREAK: 50
#define BACKSPACE 0x100
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory
static int attribute = 0x0700;
static int stat = 0 ;

static void
cgaputc(int c)
{
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
  pos = inb(CRTPORT+1) << 8;
  outb(CRTPORT, 15);
  pos |= inb(CRTPORT+1);

  if(c == '\n'){
      pos += 80 - pos % 80;  // Move to the next line.
  }
  else if(c == BACKSPACE){
    if(pos > 0) --pos;
  } else {
    crt[pos++] = (c&0xff) | attribute;
  }

  if(pos < 0 || pos > 25*80)
    panic("pos under/overflow");

  if((pos/80) >= 24){  // Scroll up.
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
    pos -= 80;
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
  }

  outb(CRTPORT, 14);
  outb(CRTPORT+1, pos>>8);
  outb(CRTPORT, 15);
  outb(CRTPORT+1, pos);
  crt[pos] = ' ' | 0x0700;

}

void consputc(int c)
{
  if (c == '\5') {
    // input.e-- ;
    if (!stat) {
      stat = 1 ;
      attribute = 0x7100 ;
    } else {
      stat = 0 ;
      attribute = 0x0700;
    }
    return;
  }
  
  if (panicked) {
    cli();
    for (;;) ;
  }

  if (c == BACKSPACE) {
    uartputc('\b');
    uartputc(' ');
    uartputc('\b');
    cgaputc(c);
  } else {
    uartputc(c);
    cgaputc(c);
  }
}

#define C(x)  ((x)-'@')  // Control-x 
static char selected_buffer[INPUT_BUF];
static char reversed_buffer[INPUT_BUF];
uint select_in ;
uint select_e ;
int copy_mode = 0 ;

void reverse_buff(){
  for (int i = 0; i < select_in; i++)
  {
    reversed_buffer[i] = selected_buffer[select_in-1-i];
  }
  reversed_buffer[select_in] = '\0';
  
}

void store_command_in_history() {
  if (input.e > input.w) {
    char current_cmd[INPUT_BUF];
    int cmd_len = 0;
    
    for (int i = input.w; i < input.e && input.buf[i % INPUT_BUF] != '\n'; i++) {
      current_cmd[cmd_len++] = input.buf[i % INPUT_BUF];
    }
    current_cmd[cmd_len] = '\0';
    
    if (should_exclude_from_history(current_cmd))
      return;
    
    for (int i = HISTORY_BUF-1; i > 0; i--) {
      memmove(input.history[i], input.history[i-1], INPUT_BUF);
    }
  
    int j = 0;
    for (int i = input.w; i < input.e && input.buf[i % INPUT_BUF] != '\n'; i++) {
      input.history[0][j++] = input.buf[i % INPUT_BUF];
    }
    input.history[0][j] = '\0';

    if (input.last_line_count < HISTORY_BUF)
      input.last_line_count++;
  }
}

void consoleintr(int (*getc)(void)) {
  int c, doprocdump = 0;

  acquire(&cons.lock);

  while ((c = getc()) >= 0) {
    switch (c) {
      case C('P'):  // Process listing.
        doprocdump = 1;
        break;

      case C('U'):  // Kill line.
        while (input.e != input.w && input.buf[(input.e) % INPUT_BUF] != '\n') {
          input.e--;
          select_e = input.e ;
          consputc(BACKSPACE);
        }
        break;

      // case C('H'): case '\x7f':  // Backspace
      //   if (input.e != input.w) {
      //     input.e--;
      //     select_e = input.e ;
      //     consputc(BACKSPACE);
      //   }
      //   break;

      //TO DO: Task 4
      case C('H'):
        show_last_five_commands();
        break;

      case '\t':  // Tab key for completion
        handle_tab_completion();
        break;

      case 0xE04B:  // Left Arrow Key
        if (input.e > input.w && select_e > input.w) {
          select_e--;
          if (copy_mode){
            selected_buffer[select_in++] = input.buf[select_e % INPUT_BUF];
          }
        }
        break;

      case C('C'):
        if (!copy_mode)
        {
          copy_mode = 1 ;
          select_in = 0 ;
        } else {
          copy_mode = 0;
          reverse_buff();
        }
        break;
      
      case C('V'):
        int i=0;
        while(reversed_buffer[i] != '\0'){
          input.buf[input.e++ % INPUT_BUF] = reversed_buffer[i];
          consputc(reversed_buffer[i]);
          select_e = input.e ;
          i++;
        }
        break;
      
      case C('E'):
        if (!stat) {
          stat = 1 ;
          attribute = 0x7100 ;
        } else {
          stat = 0 ;
          attribute = 0x0700;
        }
        break;

      default:
        if (c != 0 && input.e - input.r < INPUT_BUF) {
          c = (c == '\r') ? '\n' : c;
          input.buf[input.e++ % INPUT_BUF] = c;
          consputc(c);
          select_e = input.e ;

          if (c == '\n' || c == C('D') || input.e == input.r + INPUT_BUF) {
            if (c == '\n') {
              store_command_in_history();
            }
            input.w = input.e;
            wakeup(&input.r);
          }
        }
        break;
    }
  }

  release(&cons.lock);
  if (doprocdump) {
    procdump();  // Now call procdump() without holding cons.lock
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
  uint target;
  int c;

  iunlock(ip);
  target = n;
  acquire(&cons.lock);

  while(n > 0){

    while(input.r == input.w){

      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);

    }

    c = input.buf[input.r++ % INPUT_BUF];

    if(c == C('D')){  // EOF
      if(n < target){
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
      }
      break;
    }
    *dst++ = c;
    --n;
    if(c == '\n')
      break;
  }
  
  release(&cons.lock);
  ilock(ip);

  return target - n;
}

int
consolewrite(struct inode *ip, char *buf, int n)
{
  int i;

  iunlock(ip);
  acquire(&cons.lock);
  for(i = 0; i < n; i++){
    consputc(buf[i] & 0xff);
  }
  release(&cons.lock);
  ilock(ip);

  return n;
}

void
consoleinit(void)
{
  initlock(&cons.lock, "console");

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
}

