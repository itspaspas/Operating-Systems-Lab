
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 b0 10 00       	mov    $0x10b000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc f0 99 11 80       	mov    $0x801199f0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 30 3e 10 80       	mov    $0x80103e30,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb 54 c5 10 80       	mov    $0x8010c554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 e0 86 10 80       	push   $0x801086e0
80100051:	68 20 c5 10 80       	push   $0x8010c520
80100056:	e8 75 51 00 00       	call   801051d0 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c 0c 11 80       	mov    $0x80110c1c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c 0c 11 80 1c 	movl   $0x80110c1c,0x80110c6c
8010006a:	0c 11 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 0c 11 80 1c 	movl   $0x80110c1c,0x80110c70
80100074:	0c 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
    b->next = bcache.head.next;
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
    b->prev = &bcache.head;
8010008b:	c7 43 50 1c 0c 11 80 	movl   $0x80110c1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 e7 86 10 80       	push   $0x801086e7
80100097:	50                   	push   %eax
80100098:	e8 03 50 00 00       	call   801050a0 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 0c 11 80       	mov    0x80110c70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 0c 11 80    	mov    %ebx,0x80110c70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 09 11 80    	cmp    $0x801109c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
  }
}
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave
801000c2:	c3                   	ret
801000c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801000ca:	00 
801000cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 20 c5 10 80       	push   $0x8010c520
801000e4:	e8 d7 52 00 00       	call   801053c0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 0c 11 80    	mov    0x80110c70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c 0c 11 80    	cmp    $0x80110c1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c 0c 11 80    	cmp    $0x80110c1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d 6c 0c 11 80    	mov    0x80110c6c,%ebx
80100126:	81 fb 1c 0c 11 80    	cmp    $0x80110c1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c 0c 11 80    	cmp    $0x80110c1c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 c5 10 80       	push   $0x8010c520
80100162:	e8 f9 51 00 00       	call   80105360 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 6e 4f 00 00       	call   801050e0 <acquiresleep>
      return b;
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
    iderw(b);
  }
  return b;
}
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iderw(b);
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 2f 2f 00 00       	call   801030c0 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
}
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret
  panic("bget: no buffers");
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 ee 86 10 80       	push   $0x801086ee
801001a6:	e8 f5 01 00 00       	call   801003a0 <panic>
801001ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801001b0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 bd 4f 00 00       	call   80105180 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave
  iderw(b);
801001d4:	e9 e7 2e 00 00       	jmp    801030c0 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 ff 86 10 80       	push   $0x801086ff
801001e1:	e8 ba 01 00 00       	call   801003a0 <panic>
801001e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801001ed:	00 
801001ee:	66 90                	xchg   %ax,%ax

801001f0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 7c 4f 00 00       	call   80105180 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 63                	je     8010026e <brelse+0x7e>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 2c 4f 00 00       	call   80105140 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010021b:	e8 a0 51 00 00       	call   801053c0 <acquire>
  b->refcnt--;
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100223:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2c                	jne    8010025c <brelse+0x6c>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100230:	8b 53 54             	mov    0x54(%ebx),%edx
80100233:	8b 43 50             	mov    0x50(%ebx),%eax
80100236:	89 42 50             	mov    %eax,0x50(%edx)
    b->prev->next = b->next;
80100239:	8b 53 54             	mov    0x54(%ebx),%edx
8010023c:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
8010023f:	a1 70 0c 11 80       	mov    0x80110c70,%eax
    b->prev = &bcache.head;
80100244:	c7 43 50 1c 0c 11 80 	movl   $0x80110c1c,0x50(%ebx)
    b->next = bcache.head.next;
8010024b:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
8010024e:	a1 70 0c 11 80       	mov    0x80110c70,%eax
80100253:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100256:	89 1d 70 0c 11 80    	mov    %ebx,0x80110c70
  }
  
  release(&bcache.lock);
8010025c:	c7 45 08 20 c5 10 80 	movl   $0x8010c520,0x8(%ebp)
}
80100263:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100266:	5b                   	pop    %ebx
80100267:	5e                   	pop    %esi
80100268:	5d                   	pop    %ebp
  release(&bcache.lock);
80100269:	e9 f2 50 00 00       	jmp    80105360 <release>
    panic("brelse");
8010026e:	83 ec 0c             	sub    $0xc,%esp
80100271:	68 06 87 10 80       	push   $0x80108706
80100276:	e8 25 01 00 00       	call   801003a0 <panic>
8010027b:	66 90                	xchg   %ax,%ax
8010027d:	66 90                	xchg   %ax,%ax
8010027f:	90                   	nop

80100280 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100280:	55                   	push   %ebp
80100281:	89 e5                	mov    %esp,%ebp
80100283:	57                   	push   %edi
80100284:	56                   	push   %esi
80100285:	53                   	push   %ebx
80100286:	83 ec 18             	sub    $0x18,%esp
80100289:	8b 5d 10             	mov    0x10(%ebp),%ebx
8010028c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010028f:	ff 75 08             	push   0x8(%ebp)
  target = n;
80100292:	89 df                	mov    %ebx,%edi
  iunlock(ip);
80100294:	e8 d7 23 00 00       	call   80102670 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 60 15 11 80 	movl   $0x80111560,(%esp)
801002a0:	e8 1b 51 00 00       	call   801053c0 <acquire>

  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>

    while(input.r == input.w){
801002b0:	a1 28 15 11 80       	mov    0x80111528,%eax
801002b5:	39 05 2c 15 11 80    	cmp    %eax,0x8011152c
801002bb:	74 25                	je     801002e2 <consoleread+0x62>
801002bd:	eb 59                	jmp    80100318 <consoleread+0x98>
801002bf:	90                   	nop
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002c0:	83 ec 08             	sub    $0x8,%esp
801002c3:	68 60 15 11 80       	push   $0x80111560
801002c8:	68 28 15 11 80       	push   $0x80111528
801002cd:	e8 6e 4b 00 00       	call   80104e40 <sleep>
    while(input.r == input.w){
801002d2:	a1 28 15 11 80       	mov    0x80111528,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 2c 15 11 80    	cmp    0x8011152c,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 89 44 00 00       	call   80104770 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 60 15 11 80       	push   $0x80111560
801002f6:	e8 65 50 00 00       	call   80105360 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 8c 22 00 00       	call   80102590 <ilock>
        return -1;
80100304:	83 c4 10             	add    $0x10,%esp
  
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
80100307:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
8010030a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010030f:	5b                   	pop    %ebx
80100310:	5e                   	pop    %esi
80100311:	5f                   	pop    %edi
80100312:	5d                   	pop    %ebp
80100313:	c3                   	ret
80100314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100318:	8d 50 01             	lea    0x1(%eax),%edx
8010031b:	89 15 28 15 11 80    	mov    %edx,0x80111528
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a a0 0e 11 80 	movsbl -0x7feef160(%edx),%ecx
    if(c == C('D')){  // EOF
8010032d:	80 f9 04             	cmp    $0x4,%cl
80100330:	74 37                	je     80100369 <consoleread+0xe9>
    *dst++ = c;
80100332:	83 c6 01             	add    $0x1,%esi
    --n;
80100335:	83 eb 01             	sub    $0x1,%ebx
    *dst++ = c;
80100338:	88 4e ff             	mov    %cl,-0x1(%esi)
    if(c == '\n')
8010033b:	83 f9 0a             	cmp    $0xa,%ecx
8010033e:	0f 85 64 ff ff ff    	jne    801002a8 <consoleread+0x28>
  release(&cons.lock);
80100344:	83 ec 0c             	sub    $0xc,%esp
80100347:	68 60 15 11 80       	push   $0x80111560
8010034c:	e8 0f 50 00 00       	call   80105360 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 36 22 00 00       	call   80102590 <ilock>
  return target - n;
8010035a:	89 f8                	mov    %edi,%eax
8010035c:	83 c4 10             	add    $0x10,%esp
}
8010035f:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return target - n;
80100362:	29 d8                	sub    %ebx,%eax
}
80100364:	5b                   	pop    %ebx
80100365:	5e                   	pop    %esi
80100366:	5f                   	pop    %edi
80100367:	5d                   	pop    %ebp
80100368:	c3                   	ret
      if(n < target){
80100369:	39 fb                	cmp    %edi,%ebx
8010036b:	73 d7                	jae    80100344 <consoleread+0xc4>
        input.r--;
8010036d:	a3 28 15 11 80       	mov    %eax,0x80111528
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010037b:	00 
8010037c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100380 <should_exclude_from_history>:
int should_exclude_from_history(char *cmd) {
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
  return cmd[0] == '!';
80100383:	8b 45 08             	mov    0x8(%ebp),%eax
}
80100386:	5d                   	pop    %ebp
  return cmd[0] == '!';
80100387:	80 38 21             	cmpb   $0x21,(%eax)
8010038a:	0f 94 c0             	sete   %al
8010038d:	0f b6 c0             	movzbl %al,%eax
}
80100390:	c3                   	ret
80100391:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100398:	00 
80100399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801003a0 <panic>:
{
801003a0:	55                   	push   %ebp
801003a1:	89 e5                	mov    %esp,%ebp
801003a3:	56                   	push   %esi
801003a4:	53                   	push   %ebx
801003a5:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
801003a8:	fa                   	cli
  cons.locking = 0;
801003a9:	c7 05 94 15 11 80 00 	movl   $0x0,0x80111594
801003b0:	00 00 00 
  getcallerpcs(&s, pcs);
801003b3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003b6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003b9:	e8 12 33 00 00       	call   801036d0 <lapicid>
801003be:	83 ec 08             	sub    $0x8,%esp
801003c1:	50                   	push   %eax
801003c2:	68 0d 87 10 80       	push   $0x8010870d
801003c7:	e8 74 08 00 00       	call   80100c40 <cprintf>
  cprintf(s);
801003cc:	58                   	pop    %eax
801003cd:	ff 75 08             	push   0x8(%ebp)
801003d0:	e8 6b 08 00 00       	call   80100c40 <cprintf>
  cprintf("\n");
801003d5:	c7 04 24 5b 8c 10 80 	movl   $0x80108c5b,(%esp)
801003dc:	e8 5f 08 00 00       	call   80100c40 <cprintf>
  getcallerpcs(&s, pcs);
801003e1:	8d 45 08             	lea    0x8(%ebp),%eax
801003e4:	5a                   	pop    %edx
801003e5:	59                   	pop    %ecx
801003e6:	53                   	push   %ebx
801003e7:	50                   	push   %eax
801003e8:	e8 03 4e 00 00       	call   801051f0 <getcallerpcs>
  for(i=0; i<10; i++)
801003ed:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003f0:	83 ec 08             	sub    $0x8,%esp
801003f3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003f5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003f8:	68 21 87 10 80       	push   $0x80108721
801003fd:	e8 3e 08 00 00       	call   80100c40 <cprintf>
  for(i=0; i<10; i++)
80100402:	83 c4 10             	add    $0x10,%esp
80100405:	39 f3                	cmp    %esi,%ebx
80100407:	75 e7                	jne    801003f0 <panic+0x50>
  panicked = 1; // freeze other CPU
80100409:	c7 05 98 15 11 80 01 	movl   $0x1,0x80111598
80100410:	00 00 00 
  for(;;)
80100413:	eb fe                	jmp    80100413 <panic+0x73>
80100415:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010041c:	00 
8010041d:	8d 76 00             	lea    0x0(%esi),%esi

80100420 <cgaputc>:
{
80100420:	55                   	push   %ebp
80100421:	89 c1                	mov    %eax,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100423:	b8 0e 00 00 00       	mov    $0xe,%eax
80100428:	89 e5                	mov    %esp,%ebp
8010042a:	57                   	push   %edi
8010042b:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100430:	56                   	push   %esi
80100431:	89 fa                	mov    %edi,%edx
80100433:	53                   	push   %ebx
80100434:	83 ec 1c             	sub    $0x1c,%esp
80100437:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100438:	be d5 03 00 00       	mov    $0x3d5,%esi
8010043d:	89 f2                	mov    %esi,%edx
8010043f:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100440:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100443:	89 fa                	mov    %edi,%edx
80100445:	b8 0f 00 00 00       	mov    $0xf,%eax
8010044a:	c1 e3 08             	shl    $0x8,%ebx
8010044d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044e:	89 f2                	mov    %esi,%edx
80100450:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100451:	0f b6 c0             	movzbl %al,%eax
80100454:	09 d8                	or     %ebx,%eax
  if(c == '\n'){
80100456:	83 f9 0a             	cmp    $0xa,%ecx
80100459:	0f 84 99 00 00 00    	je     801004f8 <cgaputc+0xd8>
  else if(c == BACKSPACE){
8010045f:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
80100465:	74 79                	je     801004e0 <cgaputc+0xc0>
    crt[pos++] = (c&0xff) | attribute;
80100467:	0f b6 c9             	movzbl %cl,%ecx
8010046a:	66 0b 0d 00 a0 10 80 	or     0x8010a000,%cx
80100471:	8d 58 01             	lea    0x1(%eax),%ebx
80100474:	66 89 8c 00 00 80 0b 	mov    %cx,-0x7ff48000(%eax,%eax,1)
8010047b:	80 
  if(pos < 0 || pos > 25*80)
8010047c:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
80100482:	0f 8f ca 00 00 00    	jg     80100552 <cgaputc+0x132>
  if((pos/80) >= 24){  // Scroll up.
80100488:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
8010048e:	0f 8f 7c 00 00 00    	jg     80100510 <cgaputc+0xf0>
  outb(CRTPORT+1, pos>>8);
80100494:	0f b6 c7             	movzbl %bh,%eax
  outb(CRTPORT+1, pos);
80100497:	89 df                	mov    %ebx,%edi
  crt[pos] = ' ' | 0x0700;
80100499:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
  outb(CRTPORT+1, pos>>8);
801004a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004a3:	bb d4 03 00 00       	mov    $0x3d4,%ebx
801004a8:	b8 0e 00 00 00       	mov    $0xe,%eax
801004ad:	89 da                	mov    %ebx,%edx
801004af:	ee                   	out    %al,(%dx)
801004b0:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
801004b5:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
801004b9:	89 ca                	mov    %ecx,%edx
801004bb:	ee                   	out    %al,(%dx)
801004bc:	b8 0f 00 00 00       	mov    $0xf,%eax
801004c1:	89 da                	mov    %ebx,%edx
801004c3:	ee                   	out    %al,(%dx)
801004c4:	89 f8                	mov    %edi,%eax
801004c6:	89 ca                	mov    %ecx,%edx
801004c8:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004c9:	b8 20 07 00 00       	mov    $0x720,%eax
801004ce:	66 89 06             	mov    %ax,(%esi)
}
801004d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004d4:	5b                   	pop    %ebx
801004d5:	5e                   	pop    %esi
801004d6:	5f                   	pop    %edi
801004d7:	5d                   	pop    %ebp
801004d8:	c3                   	ret
801004d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(pos > 0) --pos;
801004e0:	8d 58 ff             	lea    -0x1(%eax),%ebx
801004e3:	85 c0                	test   %eax,%eax
801004e5:	75 95                	jne    8010047c <cgaputc+0x5c>
801004e7:	c6 45 e4 00          	movb   $0x0,-0x1c(%ebp)
801004eb:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004f0:	31 ff                	xor    %edi,%edi
801004f2:	eb af                	jmp    801004a3 <cgaputc+0x83>
801004f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      pos += 80 - pos % 80;  // Move to the next line.
801004f8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004fd:	f7 e2                	mul    %edx
801004ff:	c1 ea 06             	shr    $0x6,%edx
80100502:	8d 04 92             	lea    (%edx,%edx,4),%eax
80100505:	c1 e0 04             	shl    $0x4,%eax
80100508:	8d 58 50             	lea    0x50(%eax),%ebx
8010050b:	e9 6c ff ff ff       	jmp    8010047c <cgaputc+0x5c>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100510:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100513:	8d 7b b0             	lea    -0x50(%ebx),%edi
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100516:	8d b4 1b 60 7f 0b 80 	lea    -0x7ff480a0(%ebx,%ebx,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010051d:	68 60 0e 00 00       	push   $0xe60
80100522:	68 a0 80 0b 80       	push   $0x800b80a0
80100527:	68 00 80 0b 80       	push   $0x800b8000
8010052c:	e8 1f 50 00 00       	call   80105550 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100531:	b8 80 07 00 00       	mov    $0x780,%eax
80100536:	83 c4 0c             	add    $0xc,%esp
80100539:	29 f8                	sub    %edi,%eax
8010053b:	01 c0                	add    %eax,%eax
8010053d:	50                   	push   %eax
8010053e:	6a 00                	push   $0x0
80100540:	56                   	push   %esi
80100541:	e8 7a 4f 00 00       	call   801054c0 <memset>
  outb(CRTPORT+1, pos);
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	c6 45 e4 07          	movb   $0x7,-0x1c(%ebp)
8010054d:	e9 51 ff ff ff       	jmp    801004a3 <cgaputc+0x83>
    panic("pos under/overflow");
80100552:	83 ec 0c             	sub    $0xc,%esp
80100555:	68 25 87 10 80       	push   $0x80108725
8010055a:	e8 41 fe ff ff       	call   801003a0 <panic>
8010055f:	90                   	nop

80100560 <consputc>:
  if (c == '\5') {
80100560:	83 f8 05             	cmp    $0x5,%eax
80100563:	74 3b                	je     801005a0 <consputc+0x40>
  if (panicked) {
80100565:	8b 15 98 15 11 80    	mov    0x80111598,%edx
8010056b:	85 d2                	test   %edx,%edx
8010056d:	75 27                	jne    80100596 <consputc+0x36>
{
8010056f:	55                   	push   %ebp
80100570:	89 e5                	mov    %esp,%ebp
80100572:	53                   	push   %ebx
80100573:	89 c3                	mov    %eax,%ebx
80100575:	83 ec 04             	sub    $0x4,%esp
  if (c == BACKSPACE) {
80100578:	3d 00 01 00 00       	cmp    $0x100,%eax
8010057d:	74 55                	je     801005d4 <consputc+0x74>
    uartputc(c);
8010057f:	83 ec 0c             	sub    $0xc,%esp
80100582:	50                   	push   %eax
80100583:	e8 a8 6c 00 00       	call   80107230 <uartputc>
    cgaputc(c);
80100588:	83 c4 10             	add    $0x10,%esp
8010058b:	89 d8                	mov    %ebx,%eax
}
8010058d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100590:	c9                   	leave
    cgaputc(c);
80100591:	e9 8a fe ff ff       	jmp    80100420 <cgaputc>
  asm volatile("cli");
80100596:	fa                   	cli
    for (;;) ;
80100597:	eb fe                	jmp    80100597 <consputc+0x37>
80100599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (!stat) {
801005a0:	8b 0d 48 15 11 80    	mov    0x80111548,%ecx
801005a6:	85 c9                	test   %ecx,%ecx
801005a8:	75 15                	jne    801005bf <consputc+0x5f>
      stat = 1 ;
801005aa:	c7 05 48 15 11 80 01 	movl   $0x1,0x80111548
801005b1:	00 00 00 
      attribute = 0x7100 ;
801005b4:	c7 05 00 a0 10 80 00 	movl   $0x7100,0x8010a000
801005bb:	71 00 00 
801005be:	c3                   	ret
      stat = 0 ;
801005bf:	c7 05 48 15 11 80 00 	movl   $0x0,0x80111548
801005c6:	00 00 00 
      attribute = 0x0700;
801005c9:	c7 05 00 a0 10 80 00 	movl   $0x700,0x8010a000
801005d0:	07 00 00 
801005d3:	c3                   	ret
    uartputc('\b');
801005d4:	83 ec 0c             	sub    $0xc,%esp
801005d7:	6a 08                	push   $0x8
801005d9:	e8 52 6c 00 00       	call   80107230 <uartputc>
    uartputc(' ');
801005de:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801005e5:	e8 46 6c 00 00       	call   80107230 <uartputc>
    uartputc('\b');
801005ea:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801005f1:	e8 3a 6c 00 00       	call   80107230 <uartputc>
}
801005f6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    cgaputc(c);
801005f9:	83 c4 10             	add    $0x10,%esp
801005fc:	b8 00 01 00 00       	mov    $0x100,%eax
}
80100601:	c9                   	leave
    cgaputc(c);
80100602:	e9 19 fe ff ff       	jmp    80100420 <cgaputc>
80100607:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010060e:	00 
8010060f:	90                   	nop

80100610 <printint>:
{
80100610:	55                   	push   %ebp
80100611:	89 e5                	mov    %esp,%ebp
80100613:	57                   	push   %edi
80100614:	56                   	push   %esi
80100615:	53                   	push   %ebx
80100616:	89 d3                	mov    %edx,%ebx
80100618:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010061b:	85 c0                	test   %eax,%eax
8010061d:	79 05                	jns    80100624 <printint+0x14>
8010061f:	83 e1 01             	and    $0x1,%ecx
80100622:	75 64                	jne    80100688 <printint+0x78>
    x = xx;
80100624:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
8010062b:	89 c1                	mov    %eax,%ecx
  i = 0;
8010062d:	31 f6                	xor    %esi,%esi
8010062f:	90                   	nop
    buf[i++] = digits[x % base];
80100630:	89 c8                	mov    %ecx,%eax
80100632:	31 d2                	xor    %edx,%edx
80100634:	89 f7                	mov    %esi,%edi
80100636:	f7 f3                	div    %ebx
80100638:	8d 76 01             	lea    0x1(%esi),%esi
8010063b:	0f b6 92 fc 8c 10 80 	movzbl -0x7fef7304(%edx),%edx
80100642:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
80100646:	89 ca                	mov    %ecx,%edx
80100648:	89 c1                	mov    %eax,%ecx
8010064a:	39 da                	cmp    %ebx,%edx
8010064c:	73 e2                	jae    80100630 <printint+0x20>
  if(sign)
8010064e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100651:	85 c0                	test   %eax,%eax
80100653:	74 07                	je     8010065c <printint+0x4c>
    buf[i++] = '-';
80100655:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
  while(--i >= 0)
8010065a:	89 f7                	mov    %esi,%edi
8010065c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
8010065f:	01 df                	add    %ebx,%edi
80100661:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    consputc(buf[i]);
80100668:	0f be 07             	movsbl (%edi),%eax
8010066b:	e8 f0 fe ff ff       	call   80100560 <consputc>
  while(--i >= 0)
80100670:	89 f8                	mov    %edi,%eax
80100672:	83 ef 01             	sub    $0x1,%edi
80100675:	39 d8                	cmp    %ebx,%eax
80100677:	75 ef                	jne    80100668 <printint+0x58>
}
80100679:	83 c4 2c             	add    $0x2c,%esp
8010067c:	5b                   	pop    %ebx
8010067d:	5e                   	pop    %esi
8010067e:	5f                   	pop    %edi
8010067f:	5d                   	pop    %ebp
80100680:	c3                   	ret
80100681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
80100688:	f7 d8                	neg    %eax
  if(sign && (sign = xx < 0))
8010068a:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    x = -xx;
80100691:	89 c1                	mov    %eax,%ecx
80100693:	eb 98                	jmp    8010062d <printint+0x1d>
80100695:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010069c:	00 
8010069d:	8d 76 00             	lea    0x0(%esi),%esi

801006a0 <handle_tab_completion>:
void handle_tab_completion() {
801006a0:	55                   	push   %ebp
801006a1:	89 e5                	mov    %esp,%ebp
801006a3:	57                   	push   %edi
801006a4:	56                   	push   %esi
801006a5:	53                   	push   %ebx
801006a6:	81 ec 8c 00 00 00    	sub    $0x8c,%esp
  for (int i = input.w; i < input.e; i++) {
801006ac:	8b 15 2c 15 11 80    	mov    0x8011152c,%edx
801006b2:	8b 35 30 15 11 80    	mov    0x80111530,%esi
801006b8:	39 f2                	cmp    %esi,%edx
801006ba:	0f 83 bd 00 00 00    	jae    8010077d <handle_tab_completion+0xdd>
    current_input[current_len++] = input.buf[i % INPUT_BUF];
801006c0:	8d bd 68 ff ff ff    	lea    -0x98(%ebp),%edi
801006c6:	89 d0                	mov    %edx,%eax
801006c8:	29 d7                	sub    %edx,%edi
801006ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801006d0:	89 c3                	mov    %eax,%ebx
801006d2:	c1 fb 1f             	sar    $0x1f,%ebx
801006d5:	c1 eb 19             	shr    $0x19,%ebx
801006d8:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
801006db:	83 e1 7f             	and    $0x7f,%ecx
801006de:	29 d9                	sub    %ebx,%ecx
801006e0:	0f b6 89 a0 0e 11 80 	movzbl -0x7feef160(%ecx),%ecx
801006e7:	88 0c 07             	mov    %cl,(%edi,%eax,1)
  for (int i = input.w; i < input.e; i++) {
801006ea:	83 c0 01             	add    $0x1,%eax
801006ed:	39 f0                	cmp    %esi,%eax
801006ef:	75 df                	jne    801006d0 <handle_tab_completion+0x30>
801006f1:	29 d0                	sub    %edx,%eax
  current_input[current_len] = '\0';
801006f3:	c6 84 05 68 ff ff ff 	movb   $0x0,-0x98(%ebp,%eax,1)
801006fa:	00 
801006fb:	89 c6                	mov    %eax,%esi
  for (int i = 0; i < input.last_line_count; i++) {
801006fd:	a1 20 15 11 80       	mov    0x80111520,%eax
80100702:	85 c0                	test   %eax,%eax
80100704:	7e 77                	jle    8010077d <handle_tab_completion+0xdd>
80100706:	bf 20 0f 11 80       	mov    $0x80110f20,%edi
8010070b:	31 db                	xor    %ebx,%ebx
8010070d:	eb 0f                	jmp    8010071e <handle_tab_completion+0x7e>
8010070f:	90                   	nop
80100710:	83 c3 01             	add    $0x1,%ebx
80100713:	83 ef 80             	sub    $0xffffff80,%edi
80100716:	39 1d 20 15 11 80    	cmp    %ebx,0x80111520
8010071c:	7e 5f                	jle    8010077d <handle_tab_completion+0xdd>
    if (strncmp(input.history[i], current_input, current_len) == 0) {
8010071e:	83 ec 04             	sub    $0x4,%esp
80100721:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80100727:	56                   	push   %esi
80100728:	50                   	push   %eax
80100729:	57                   	push   %edi
8010072a:	e8 91 4e 00 00       	call   801055c0 <strncmp>
8010072f:	83 c4 10             	add    $0x10,%esp
80100732:	85 c0                	test   %eax,%eax
80100734:	75 da                	jne    80100710 <handle_tab_completion+0x70>
  int match_len = strlen(match);
80100736:	83 ec 0c             	sub    $0xc,%esp
80100739:	57                   	push   %edi
8010073a:	e8 71 4f 00 00       	call   801056b0 <strlen>
  for (int i = current_len; i < match_len; i++) {
8010073f:	83 c4 10             	add    $0x10,%esp
80100742:	39 c6                	cmp    %eax,%esi
80100744:	7d 37                	jge    8010077d <handle_tab_completion+0xdd>
    input.buf[input.e++ % INPUT_BUF] = match[i];
80100746:	8b 15 30 15 11 80    	mov    0x80111530,%edx
8010074c:	01 fe                	add    %edi,%esi
8010074e:	01 c7                	add    %eax,%edi
80100750:	8d 42 01             	lea    0x1(%edx),%eax
80100753:	83 e2 7f             	and    $0x7f,%edx
  for (int i = current_len; i < match_len; i++) {
80100756:	83 c6 01             	add    $0x1,%esi
    input.buf[input.e++ % INPUT_BUF] = match[i];
80100759:	a3 30 15 11 80       	mov    %eax,0x80111530
8010075e:	0f be 46 ff          	movsbl -0x1(%esi),%eax
80100762:	88 82 a0 0e 11 80    	mov    %al,-0x7feef160(%edx)
    consputc(match[i]);
80100768:	e8 f3 fd ff ff       	call   80100560 <consputc>
    select_e = input.e;
8010076d:	8b 15 30 15 11 80    	mov    0x80111530,%edx
80100773:	89 15 84 0e 11 80    	mov    %edx,0x80110e84
  for (int i = current_len; i < match_len; i++) {
80100779:	39 f7                	cmp    %esi,%edi
8010077b:	75 d3                	jne    80100750 <handle_tab_completion+0xb0>
}
8010077d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100780:	5b                   	pop    %ebx
80100781:	5e                   	pop    %esi
80100782:	5f                   	pop    %edi
80100783:	5d                   	pop    %ebp
80100784:	c3                   	ret
80100785:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010078c:	00 
8010078d:	8d 76 00             	lea    0x0(%esi),%esi

80100790 <putc>:
{
80100790:	55                   	push   %ebp
80100791:	89 e5                	mov    %esp,%ebp
80100793:	8b 45 0c             	mov    0xc(%ebp),%eax
80100796:	8b 55 08             	mov    0x8(%ebp),%edx
  if (output == ALL_OUTPUT)
80100799:	85 c0                	test   %eax,%eax
8010079b:	74 0b                	je     801007a8 <putc+0x18>
  else if (output == DEVICE_SCREEN)
8010079d:	83 f8 01             	cmp    $0x1,%eax
801007a0:	74 0e                	je     801007b0 <putc+0x20>
}
801007a2:	5d                   	pop    %ebp
801007a3:	c3                   	ret
801007a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    consputc(c);
801007a8:	89 d0                	mov    %edx,%eax
}
801007aa:	5d                   	pop    %ebp
    consputc(c);
801007ab:	e9 b0 fd ff ff       	jmp    80100560 <consputc>
    cgaputc(c);
801007b0:	89 d0                	mov    %edx,%eax
}
801007b2:	5d                   	pop    %ebp
    cgaputc(c);
801007b3:	e9 68 fc ff ff       	jmp    80100420 <cgaputc>
801007b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801007bf:	00 

801007c0 <print_str_without_buffering>:
{
801007c0:	55                   	push   %ebp
801007c1:	89 e5                	mov    %esp,%ebp
801007c3:	56                   	push   %esi
801007c4:	53                   	push   %ebx
801007c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801007c8:	8b 55 0c             	mov    0xc(%ebp),%edx
    if (str[i] == '\0')
801007cb:	0f be 03             	movsbl (%ebx),%eax
801007ce:	84 c0                	test   %al,%al
801007d0:	74 21                	je     801007f3 <print_str_without_buffering+0x33>
801007d2:	8d b3 80 00 00 00    	lea    0x80(%ebx),%esi
  if (output == ALL_OUTPUT)
801007d8:	85 d2                	test   %edx,%edx
801007da:	75 24                	jne    80100800 <print_str_without_buffering+0x40>
801007dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    consputc(c);
801007e0:	e8 7b fd ff ff       	call   80100560 <consputc>
  for (int i = 0; i < INPUT_BUF; i++)
801007e5:	83 c3 01             	add    $0x1,%ebx
801007e8:	39 f3                	cmp    %esi,%ebx
801007ea:	74 07                	je     801007f3 <print_str_without_buffering+0x33>
    if (str[i] == '\0')
801007ec:	0f be 03             	movsbl (%ebx),%eax
801007ef:	84 c0                	test   %al,%al
801007f1:	75 ed                	jne    801007e0 <print_str_without_buffering+0x20>
}
801007f3:	5b                   	pop    %ebx
801007f4:	5e                   	pop    %esi
801007f5:	5d                   	pop    %ebp
801007f6:	c3                   	ret
801007f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801007fe:	00 
801007ff:	90                   	nop
  else if (output == DEVICE_SCREEN)
80100800:	83 fa 01             	cmp    $0x1,%edx
80100803:	74 13                	je     80100818 <print_str_without_buffering+0x58>
  for (int i = 0; i < INPUT_BUF; i++)
80100805:	83 c3 01             	add    $0x1,%ebx
80100808:	39 de                	cmp    %ebx,%esi
8010080a:	74 e7                	je     801007f3 <print_str_without_buffering+0x33>
    if (str[i] == '\0')
8010080c:	0f be 03             	movsbl (%ebx),%eax
8010080f:	84 c0                	test   %al,%al
80100811:	74 e0                	je     801007f3 <print_str_without_buffering+0x33>
  else if (output == DEVICE_SCREEN)
80100813:	83 fa 01             	cmp    $0x1,%edx
80100816:	75 ed                	jne    80100805 <print_str_without_buffering+0x45>
    cgaputc(c);
80100818:	e8 03 fc ff ff       	call   80100420 <cgaputc>
  for (int i = 0; i < INPUT_BUF; i++)
8010081d:	83 c3 01             	add    $0x1,%ebx
80100820:	39 de                	cmp    %ebx,%esi
80100822:	74 cf                	je     801007f3 <print_str_without_buffering+0x33>
    if (str[i] == '\0')
80100824:	0f be 03             	movsbl (%ebx),%eax
80100827:	84 c0                	test   %al,%al
80100829:	75 ed                	jne    80100818 <print_str_without_buffering+0x58>
}
8010082b:	5b                   	pop    %ebx
8010082c:	5e                   	pop    %esi
8010082d:	5d                   	pop    %ebp
8010082e:	c3                   	ret
8010082f:	90                   	nop

80100830 <print_row_index>:
{
80100830:	55                   	push   %ebp
80100831:	89 e5                	mov    %esp,%ebp
80100833:	56                   	push   %esi
80100834:	53                   	push   %ebx
80100835:	8b 75 08             	mov    0x8(%ebp),%esi
80100838:	bb 03 00 00 00       	mov    $0x3,%ebx
  if (panicked) {
8010083d:	8b 0d 98 15 11 80    	mov    0x80111598,%ecx
80100843:	85 c9                	test   %ecx,%ecx
80100845:	74 09                	je     80100850 <print_row_index+0x20>
80100847:	fa                   	cli
    for (;;) ;
80100848:	eb fe                	jmp    80100848 <print_row_index+0x18>
8010084a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    uartputc(c);
80100850:	83 ec 0c             	sub    $0xc,%esp
80100853:	6a 20                	push   $0x20
80100855:	e8 d6 69 00 00       	call   80107230 <uartputc>
    cgaputc(c);
8010085a:	b8 20 00 00 00       	mov    $0x20,%eax
8010085f:	e8 bc fb ff ff       	call   80100420 <cgaputc>
  for (int i = 0; i < count; i++)
80100864:	83 c4 10             	add    $0x10,%esp
80100867:	83 eb 01             	sub    $0x1,%ebx
8010086a:	75 d1                	jne    8010083d <print_row_index+0xd>
  printint(index, 10, 0);
8010086c:	ba 0a 00 00 00       	mov    $0xa,%edx
80100871:	31 c9                	xor    %ecx,%ecx
80100873:	89 f0                	mov    %esi,%eax
80100875:	e8 96 fd ff ff       	call   80100610 <printint>
  if (panicked) {
8010087a:	8b 15 98 15 11 80    	mov    0x80111598,%edx
80100880:	85 d2                	test   %edx,%edx
80100882:	75 3d                	jne    801008c1 <print_row_index+0x91>
    uartputc(c);
80100884:	83 ec 0c             	sub    $0xc,%esp
80100887:	6a 20                	push   $0x20
80100889:	e8 a2 69 00 00       	call   80107230 <uartputc>
    cgaputc(c);
8010088e:	b8 20 00 00 00       	mov    $0x20,%eax
80100893:	e8 88 fb ff ff       	call   80100420 <cgaputc>
  if (panicked) {
80100898:	a1 98 15 11 80       	mov    0x80111598,%eax
8010089d:	83 c4 10             	add    $0x10,%esp
801008a0:	85 c0                	test   %eax,%eax
801008a2:	75 1d                	jne    801008c1 <print_row_index+0x91>
    uartputc(c);
801008a4:	83 ec 0c             	sub    $0xc,%esp
801008a7:	6a 20                	push   $0x20
801008a9:	e8 82 69 00 00       	call   80107230 <uartputc>
    cgaputc(c);
801008ae:	83 c4 10             	add    $0x10,%esp
}
801008b1:	8d 65 f8             	lea    -0x8(%ebp),%esp
    cgaputc(c);
801008b4:	b8 20 00 00 00       	mov    $0x20,%eax
}
801008b9:	5b                   	pop    %ebx
801008ba:	5e                   	pop    %esi
801008bb:	5d                   	pop    %ebp
    cgaputc(c);
801008bc:	e9 5f fb ff ff       	jmp    80100420 <cgaputc>
801008c1:	fa                   	cli
    for (;;) ;
801008c2:	eb fe                	jmp    801008c2 <print_row_index+0x92>
801008c4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801008cb:	00 
801008cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801008d0 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
801008d0:	55                   	push   %ebp
801008d1:	89 e5                	mov    %esp,%ebp
801008d3:	57                   	push   %edi
801008d4:	56                   	push   %esi
801008d5:	53                   	push   %ebx
801008d6:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
801008d9:	ff 75 08             	push   0x8(%ebp)
801008dc:	e8 8f 1d 00 00       	call   80102670 <iunlock>
  acquire(&cons.lock);
801008e1:	c7 04 24 60 15 11 80 	movl   $0x80111560,(%esp)
801008e8:	e8 d3 4a 00 00       	call   801053c0 <acquire>
  for(i = 0; i < n; i++){
801008ed:	8b 5d 10             	mov    0x10(%ebp),%ebx
801008f0:	83 c4 10             	add    $0x10,%esp
801008f3:	85 db                	test   %ebx,%ebx
801008f5:	7e 3b                	jle    80100932 <consolewrite+0x62>
801008f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801008fa:	8b 7d 10             	mov    0x10(%ebp),%edi
801008fd:	01 df                	add    %ebx,%edi
    consputc(buf[i] & 0xff);
801008ff:	0f b6 33             	movzbl (%ebx),%esi
  if (c == '\5') {
80100902:	83 fe 05             	cmp    $0x5,%esi
80100905:	74 4c                	je     80100953 <consolewrite+0x83>
  if (panicked) {
80100907:	8b 15 98 15 11 80    	mov    0x80111598,%edx
8010090d:	85 d2                	test   %edx,%edx
8010090f:	74 07                	je     80100918 <consolewrite+0x48>
80100911:	fa                   	cli
    for (;;) ;
80100912:	eb fe                	jmp    80100912 <consolewrite+0x42>
80100914:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartputc(c);
80100918:	83 ec 0c             	sub    $0xc,%esp
8010091b:	56                   	push   %esi
8010091c:	e8 0f 69 00 00       	call   80107230 <uartputc>
    cgaputc(c);
80100921:	89 f0                	mov    %esi,%eax
80100923:	e8 f8 fa ff ff       	call   80100420 <cgaputc>
80100928:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
8010092b:	83 c3 01             	add    $0x1,%ebx
8010092e:	39 fb                	cmp    %edi,%ebx
80100930:	75 cd                	jne    801008ff <consolewrite+0x2f>
  }
  release(&cons.lock);
80100932:	83 ec 0c             	sub    $0xc,%esp
80100935:	68 60 15 11 80       	push   $0x80111560
8010093a:	e8 21 4a 00 00       	call   80105360 <release>
  ilock(ip);
8010093f:	58                   	pop    %eax
80100940:	ff 75 08             	push   0x8(%ebp)
80100943:	e8 48 1c 00 00       	call   80102590 <ilock>

  return n;
}
80100948:	8b 45 10             	mov    0x10(%ebp),%eax
8010094b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010094e:	5b                   	pop    %ebx
8010094f:	5e                   	pop    %esi
80100950:	5f                   	pop    %edi
80100951:	5d                   	pop    %ebp
80100952:	c3                   	ret
    if (!stat) {
80100953:	8b 0d 48 15 11 80    	mov    0x80111548,%ecx
80100959:	85 c9                	test   %ecx,%ecx
8010095b:	75 16                	jne    80100973 <consolewrite+0xa3>
      stat = 1 ;
8010095d:	c7 05 48 15 11 80 01 	movl   $0x1,0x80111548
80100964:	00 00 00 
      attribute = 0x7100 ;
80100967:	c7 05 00 a0 10 80 00 	movl   $0x7100,0x8010a000
8010096e:	71 00 00 
80100971:	eb b8                	jmp    8010092b <consolewrite+0x5b>
      stat = 0 ;
80100973:	c7 05 48 15 11 80 00 	movl   $0x0,0x80111548
8010097a:	00 00 00 
      attribute = 0x0700;
8010097d:	c7 05 00 a0 10 80 00 	movl   $0x700,0x8010a000
80100984:	07 00 00 
80100987:	eb a2                	jmp    8010092b <consolewrite+0x5b>
80100989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100990 <write_repeated>:
{
80100990:	55                   	push   %ebp
80100991:	89 e5                	mov    %esp,%ebp
80100993:	57                   	push   %edi
80100994:	56                   	push   %esi
80100995:	53                   	push   %ebx
80100996:	83 ec 0c             	sub    $0xc,%esp
80100999:	8b 7d 08             	mov    0x8(%ebp),%edi
8010099c:	8b 75 10             	mov    0x10(%ebp),%esi
  for (int i = 0; i < count; i++)
8010099f:	85 ff                	test   %edi,%edi
801009a1:	7e 47                	jle    801009ea <write_repeated+0x5a>
  if (output == ALL_OUTPUT)
801009a3:	85 f6                	test   %esi,%esi
801009a5:	0f 85 93 00 00 00    	jne    80100a3e <write_repeated+0xae>
  if (c == '\5') {
801009ab:	83 7d 0c 05          	cmpl   $0x5,0xc(%ebp)
801009af:	74 5c                	je     80100a0d <write_repeated+0x7d>
  if (panicked) {
801009b1:	a1 98 15 11 80       	mov    0x80111598,%eax
801009b6:	85 c0                	test   %eax,%eax
801009b8:	74 06                	je     801009c0 <write_repeated+0x30>
801009ba:	fa                   	cli
    for (;;) ;
801009bb:	eb fe                	jmp    801009bb <write_repeated+0x2b>
801009bd:	8d 76 00             	lea    0x0(%esi),%esi
  if (c == BACKSPACE) {
801009c0:	81 7d 0c 00 01 00 00 	cmpl   $0x100,0xc(%ebp)
801009c7:	0f 84 aa 00 00 00    	je     80100a77 <write_repeated+0xe7>
    uartputc(c);
801009cd:	83 ec 0c             	sub    $0xc,%esp
801009d0:	ff 75 0c             	push   0xc(%ebp)
801009d3:	e8 58 68 00 00       	call   80107230 <uartputc>
    cgaputc(c);
801009d8:	8b 45 0c             	mov    0xc(%ebp),%eax
801009db:	e8 40 fa ff ff       	call   80100420 <cgaputc>
  for (int i = 0; i < count; i++)
801009e0:	83 c6 01             	add    $0x1,%esi
801009e3:	83 c4 10             	add    $0x10,%esp
801009e6:	39 f7                	cmp    %esi,%edi
801009e8:	75 c7                	jne    801009b1 <write_repeated+0x21>
}
801009ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801009ed:	5b                   	pop    %ebx
801009ee:	5e                   	pop    %esi
801009ef:	5f                   	pop    %edi
801009f0:	5d                   	pop    %ebp
801009f1:	c3                   	ret
      stat = 0 ;
801009f2:	c7 05 48 15 11 80 00 	movl   $0x0,0x80111548
801009f9:	00 00 00 
  for (int i = 0; i < count; i++)
801009fc:	83 c6 01             	add    $0x1,%esi
      attribute = 0x0700;
801009ff:	c7 05 00 a0 10 80 00 	movl   $0x700,0x8010a000
80100a06:	07 00 00 
  for (int i = 0; i < count; i++)
80100a09:	39 f7                	cmp    %esi,%edi
80100a0b:	74 dd                	je     801009ea <write_repeated+0x5a>
    if (!stat) {
80100a0d:	8b 15 48 15 11 80    	mov    0x80111548,%edx
80100a13:	85 d2                	test   %edx,%edx
80100a15:	75 db                	jne    801009f2 <write_repeated+0x62>
      stat = 1 ;
80100a17:	c7 05 48 15 11 80 01 	movl   $0x1,0x80111548
80100a1e:	00 00 00 
  for (int i = 0; i < count; i++)
80100a21:	83 c6 01             	add    $0x1,%esi
      attribute = 0x7100 ;
80100a24:	c7 05 00 a0 10 80 00 	movl   $0x7100,0x8010a000
80100a2b:	71 00 00 
  for (int i = 0; i < count; i++)
80100a2e:	39 f7                	cmp    %esi,%edi
80100a30:	74 b8                	je     801009ea <write_repeated+0x5a>
    if (!stat) {
80100a32:	8b 15 48 15 11 80    	mov    0x80111548,%edx
80100a38:	85 d2                	test   %edx,%edx
80100a3a:	75 b6                	jne    801009f2 <write_repeated+0x62>
80100a3c:	eb d9                	jmp    80100a17 <write_repeated+0x87>
80100a3e:	31 db                	xor    %ebx,%ebx
  else if (output == DEVICE_SCREEN)
80100a40:	83 fe 01             	cmp    $0x1,%esi
80100a43:	74 0f                	je     80100a54 <write_repeated+0xc4>
80100a45:	8d 76 00             	lea    0x0(%esi),%esi
  for (int i = 0; i < count; i++)
80100a48:	83 c3 01             	add    $0x1,%ebx
80100a4b:	39 df                	cmp    %ebx,%edi
80100a4d:	74 9b                	je     801009ea <write_repeated+0x5a>
  else if (output == DEVICE_SCREEN)
80100a4f:	83 fe 01             	cmp    $0x1,%esi
80100a52:	75 f4                	jne    80100a48 <write_repeated+0xb8>
    cgaputc(c);
80100a54:	8b 45 0c             	mov    0xc(%ebp),%eax
  for (int i = 0; i < count; i++)
80100a57:	83 c3 01             	add    $0x1,%ebx
    cgaputc(c);
80100a5a:	e8 c1 f9 ff ff       	call   80100420 <cgaputc>
  for (int i = 0; i < count; i++)
80100a5f:	39 df                	cmp    %ebx,%edi
80100a61:	74 87                	je     801009ea <write_repeated+0x5a>
    cgaputc(c);
80100a63:	8b 45 0c             	mov    0xc(%ebp),%eax
  for (int i = 0; i < count; i++)
80100a66:	83 c3 01             	add    $0x1,%ebx
    cgaputc(c);
80100a69:	e8 b2 f9 ff ff       	call   80100420 <cgaputc>
  for (int i = 0; i < count; i++)
80100a6e:	39 df                	cmp    %ebx,%edi
80100a70:	75 e2                	jne    80100a54 <write_repeated+0xc4>
80100a72:	e9 73 ff ff ff       	jmp    801009ea <write_repeated+0x5a>
    uartputc('\b');
80100a77:	83 ec 0c             	sub    $0xc,%esp
80100a7a:	6a 08                	push   $0x8
80100a7c:	e8 af 67 00 00       	call   80107230 <uartputc>
    uartputc(' ');
80100a81:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100a88:	e8 a3 67 00 00       	call   80107230 <uartputc>
    uartputc('\b');
80100a8d:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100a94:	e8 97 67 00 00       	call   80107230 <uartputc>
    cgaputc(c);
80100a99:	b8 00 01 00 00       	mov    $0x100,%eax
80100a9e:	e9 38 ff ff ff       	jmp    801009db <write_repeated+0x4b>
80100aa3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100aaa:	00 
80100aab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100ab0 <show_last_five_commands>:
{
80100ab0:	55                   	push   %ebp
80100ab1:	89 e5                	mov    %esp,%ebp
80100ab3:	57                   	push   %edi
80100ab4:	56                   	push   %esi
80100ab5:	53                   	push   %ebx
80100ab6:	83 ec 1c             	sub    $0x1c,%esp
  if (panicked) {
80100ab9:	8b 35 98 15 11 80    	mov    0x80111598,%esi
  if (count > input.last_line_count)
80100abf:	8b 1d 20 15 11 80    	mov    0x80111520,%ebx
  if (panicked) {
80100ac5:	85 f6                	test   %esi,%esi
80100ac7:	74 07                	je     80100ad0 <show_last_five_commands+0x20>
80100ac9:	fa                   	cli
    for (;;) ;
80100aca:	eb fe                	jmp    80100aca <show_last_five_commands+0x1a>
80100acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartputc(c);
80100ad0:	83 ec 0c             	sub    $0xc,%esp
80100ad3:	6a 0a                	push   $0xa
80100ad5:	e8 56 67 00 00       	call   80107230 <uartputc>
    cgaputc(c);
80100ada:	b8 0a 00 00 00       	mov    $0xa,%eax
80100adf:	e8 3c f9 ff ff       	call   80100420 <cgaputc>
  for (int i = 0; i <= count; i++)
80100ae4:	83 c4 10             	add    $0x10,%esp
80100ae7:	85 db                	test   %ebx,%ebx
80100ae9:	0f 88 ec 00 00 00    	js     80100bdb <show_last_five_commands+0x12b>
  if (count > input.last_line_count)
80100aef:	b8 05 00 00 00       	mov    $0x5,%eax
80100af4:	bf 20 0f 11 80       	mov    $0x80110f20,%edi
80100af9:	39 c3                	cmp    %eax,%ebx
80100afb:	0f 4e c3             	cmovle %ebx,%eax
80100afe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
{
80100b01:	bb 03 00 00 00       	mov    $0x3,%ebx
  if (panicked) {
80100b06:	a1 98 15 11 80       	mov    0x80111598,%eax
80100b0b:	85 c0                	test   %eax,%eax
80100b0d:	74 09                	je     80100b18 <show_last_five_commands+0x68>
80100b0f:	fa                   	cli
    for (;;) ;
80100b10:	eb fe                	jmp    80100b10 <show_last_five_commands+0x60>
80100b12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    uartputc(c);
80100b18:	83 ec 0c             	sub    $0xc,%esp
80100b1b:	6a 20                	push   $0x20
80100b1d:	e8 0e 67 00 00       	call   80107230 <uartputc>
    cgaputc(c);
80100b22:	b8 20 00 00 00       	mov    $0x20,%eax
80100b27:	e8 f4 f8 ff ff       	call   80100420 <cgaputc>
  for (int i = 0; i < count; i++)
80100b2c:	83 c4 10             	add    $0x10,%esp
80100b2f:	83 eb 01             	sub    $0x1,%ebx
80100b32:	75 d2                	jne    80100b06 <show_last_five_commands+0x56>
  printint(index, 10, 0);
80100b34:	89 f0                	mov    %esi,%eax
80100b36:	31 c9                	xor    %ecx,%ecx
80100b38:	ba 0a 00 00 00       	mov    $0xa,%edx
80100b3d:	e8 ce fa ff ff       	call   80100610 <printint>
  if (panicked) {
80100b42:	a1 98 15 11 80       	mov    0x80111598,%eax
80100b47:	85 c0                	test   %eax,%eax
80100b49:	0f 85 c1 00 00 00    	jne    80100c10 <show_last_five_commands+0x160>
    uartputc(c);
80100b4f:	83 ec 0c             	sub    $0xc,%esp
80100b52:	6a 20                	push   $0x20
80100b54:	e8 d7 66 00 00       	call   80107230 <uartputc>
    cgaputc(c);
80100b59:	b8 20 00 00 00       	mov    $0x20,%eax
80100b5e:	e8 bd f8 ff ff       	call   80100420 <cgaputc>
  if (panicked) {
80100b63:	8b 1d 98 15 11 80    	mov    0x80111598,%ebx
80100b69:	83 c4 10             	add    $0x10,%esp
80100b6c:	85 db                	test   %ebx,%ebx
80100b6e:	0f 85 9c 00 00 00    	jne    80100c10 <show_last_five_commands+0x160>
    uartputc(c);
80100b74:	83 ec 0c             	sub    $0xc,%esp
    cgaputc(c);
80100b77:	89 fb                	mov    %edi,%ebx
80100b79:	8d bf 80 00 00 00    	lea    0x80(%edi),%edi
    uartputc(c);
80100b7f:	6a 20                	push   $0x20
80100b81:	e8 aa 66 00 00       	call   80107230 <uartputc>
    cgaputc(c);
80100b86:	b8 20 00 00 00       	mov    $0x20,%eax
80100b8b:	e8 90 f8 ff ff       	call   80100420 <cgaputc>
80100b90:	83 c4 10             	add    $0x10,%esp
80100b93:	eb 0c                	jmp    80100ba1 <show_last_five_commands+0xf1>
    consputc(c);
80100b95:	e8 c6 f9 ff ff       	call   80100560 <consputc>
  for (int i = 0; i < INPUT_BUF; i++)
80100b9a:	83 c3 01             	add    $0x1,%ebx
80100b9d:	39 fb                	cmp    %edi,%ebx
80100b9f:	74 07                	je     80100ba8 <show_last_five_commands+0xf8>
    if (str[i] == '\0')
80100ba1:	0f be 03             	movsbl (%ebx),%eax
80100ba4:	84 c0                	test   %al,%al
80100ba6:	75 ed                	jne    80100b95 <show_last_five_commands+0xe5>
  if (panicked) {
80100ba8:	8b 0d 98 15 11 80    	mov    0x80111598,%ecx
80100bae:	85 c9                	test   %ecx,%ecx
80100bb0:	74 06                	je     80100bb8 <show_last_five_commands+0x108>
80100bb2:	fa                   	cli
    for (;;) ;
80100bb3:	eb fe                	jmp    80100bb3 <show_last_five_commands+0x103>
80100bb5:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(c);
80100bb8:	83 ec 0c             	sub    $0xc,%esp
  for (int i = 0; i <= count; i++)
80100bbb:	83 c6 01             	add    $0x1,%esi
    uartputc(c);
80100bbe:	6a 0a                	push   $0xa
80100bc0:	e8 6b 66 00 00       	call   80107230 <uartputc>
    cgaputc(c);
80100bc5:	b8 0a 00 00 00       	mov    $0xa,%eax
80100bca:	e8 51 f8 ff ff       	call   80100420 <cgaputc>
  for (int i = 0; i <= count; i++)
80100bcf:	83 c4 10             	add    $0x10,%esp
80100bd2:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80100bd5:	0f 8d 26 ff ff ff    	jge    80100b01 <show_last_five_commands+0x51>
  if (panicked) {
80100bdb:	8b 15 98 15 11 80    	mov    0x80111598,%edx
80100be1:	85 d2                	test   %edx,%edx
80100be3:	75 33                	jne    80100c18 <show_last_five_commands+0x168>
    uartputc(c);
80100be5:	83 ec 0c             	sub    $0xc,%esp
80100be8:	6a 24                	push   $0x24
80100bea:	e8 41 66 00 00       	call   80107230 <uartputc>
    cgaputc(c);
80100bef:	b8 24 00 00 00       	mov    $0x24,%eax
80100bf4:	e8 27 f8 ff ff       	call   80100420 <cgaputc>
  if (panicked) {
80100bf9:	a1 98 15 11 80       	mov    0x80111598,%eax
80100bfe:	83 c4 10             	add    $0x10,%esp
80100c01:	85 c0                	test   %eax,%eax
80100c03:	74 1b                	je     80100c20 <show_last_five_commands+0x170>
80100c05:	fa                   	cli
    for (;;) ;
80100c06:	eb fe                	jmp    80100c06 <show_last_five_commands+0x156>
80100c08:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100c0f:	00 
80100c10:	fa                   	cli
80100c11:	eb fe                	jmp    80100c11 <show_last_five_commands+0x161>
80100c13:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100c18:	fa                   	cli
80100c19:	eb fe                	jmp    80100c19 <show_last_five_commands+0x169>
80100c1b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    uartputc(c);
80100c20:	83 ec 0c             	sub    $0xc,%esp
80100c23:	6a 20                	push   $0x20
80100c25:	e8 06 66 00 00       	call   80107230 <uartputc>
    cgaputc(c);
80100c2a:	83 c4 10             	add    $0x10,%esp
}
80100c2d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    cgaputc(c);
80100c30:	b8 20 00 00 00       	mov    $0x20,%eax
}
80100c35:	5b                   	pop    %ebx
80100c36:	5e                   	pop    %esi
80100c37:	5f                   	pop    %edi
80100c38:	5d                   	pop    %ebp
    cgaputc(c);
80100c39:	e9 e2 f7 ff ff       	jmp    80100420 <cgaputc>
80100c3e:	66 90                	xchg   %ax,%ax

80100c40 <cprintf>:
{
80100c40:	55                   	push   %ebp
80100c41:	89 e5                	mov    %esp,%ebp
80100c43:	57                   	push   %edi
80100c44:	56                   	push   %esi
80100c45:	53                   	push   %ebx
80100c46:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100c49:	8b 3d 94 15 11 80    	mov    0x80111594,%edi
  if (fmt == 0)
80100c4f:	8b 75 08             	mov    0x8(%ebp),%esi
  if(locking)
80100c52:	85 ff                	test   %edi,%edi
80100c54:	0f 85 76 01 00 00    	jne    80100dd0 <cprintf+0x190>
  if (fmt == 0)
80100c5a:	85 f6                	test   %esi,%esi
80100c5c:	0f 84 a5 01 00 00    	je     80100e07 <cprintf+0x1c7>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100c62:	0f b6 06             	movzbl (%esi),%eax
80100c65:	85 c0                	test   %eax,%eax
80100c67:	74 5d                	je     80100cc6 <cprintf+0x86>
80100c69:	89 7d e0             	mov    %edi,-0x20(%ebp)
  argp = (uint*)(void*)(&fmt + 1);
80100c6c:	8d 55 0c             	lea    0xc(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100c6f:	31 db                	xor    %ebx,%ebx
    if(c != '%'){
80100c71:	83 f8 25             	cmp    $0x25,%eax
80100c74:	75 5a                	jne    80100cd0 <cprintf+0x90>
    c = fmt[++i] & 0xff;
80100c76:	83 c3 01             	add    $0x1,%ebx
80100c79:	0f b6 3c 1e          	movzbl (%esi,%ebx,1),%edi
    if(c == 0)
80100c7d:	85 ff                	test   %edi,%edi
80100c7f:	74 3a                	je     80100cbb <cprintf+0x7b>
    switch(c){
80100c81:	83 ff 70             	cmp    $0x70,%edi
80100c84:	74 7a                	je     80100d00 <cprintf+0xc0>
80100c86:	7f 58                	jg     80100ce0 <cprintf+0xa0>
80100c88:	83 ff 25             	cmp    $0x25,%edi
80100c8b:	0f 84 c7 00 00 00    	je     80100d58 <cprintf+0x118>
80100c91:	83 ff 64             	cmp    $0x64,%edi
80100c94:	75 54                	jne    80100cea <cprintf+0xaa>
      printint(*argp++, 10, 1);
80100c96:	8b 02                	mov    (%edx),%eax
80100c98:	8d 7a 04             	lea    0x4(%edx),%edi
80100c9b:	b9 01 00 00 00       	mov    $0x1,%ecx
80100ca0:	ba 0a 00 00 00       	mov    $0xa,%edx
80100ca5:	e8 66 f9 ff ff       	call   80100610 <printint>
80100caa:	89 fa                	mov    %edi,%edx
80100cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100cb0:	83 c3 01             	add    $0x1,%ebx
80100cb3:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
80100cb7:	85 c0                	test   %eax,%eax
80100cb9:	75 b6                	jne    80100c71 <cprintf+0x31>
80100cbb:	8b 7d e0             	mov    -0x20(%ebp),%edi
  if(locking)
80100cbe:	85 ff                	test   %edi,%edi
80100cc0:	0f 85 29 01 00 00    	jne    80100def <cprintf+0x1af>
}
80100cc6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100cc9:	5b                   	pop    %ebx
80100cca:	5e                   	pop    %esi
80100ccb:	5f                   	pop    %edi
80100ccc:	5d                   	pop    %ebp
80100ccd:	c3                   	ret
80100cce:	66 90                	xchg   %ax,%ax
80100cd0:	89 55 e4             	mov    %edx,-0x1c(%ebp)
      consputc(c);
80100cd3:	e8 88 f8 ff ff       	call   80100560 <consputc>
      continue;
80100cd8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100cdb:	eb d3                	jmp    80100cb0 <cprintf+0x70>
80100cdd:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
80100ce0:	83 ff 73             	cmp    $0x73,%edi
80100ce3:	74 33                	je     80100d18 <cprintf+0xd8>
80100ce5:	83 ff 78             	cmp    $0x78,%edi
80100ce8:	74 16                	je     80100d00 <cprintf+0xc0>
  if (panicked) {
80100cea:	a1 98 15 11 80       	mov    0x80111598,%eax
80100cef:	85 c0                	test   %eax,%eax
80100cf1:	0f 84 a9 00 00 00    	je     80100da0 <cprintf+0x160>
80100cf7:	fa                   	cli
    for (;;) ;
80100cf8:	eb fe                	jmp    80100cf8 <cprintf+0xb8>
80100cfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      printint(*argp++, 16, 0);
80100d00:	8b 02                	mov    (%edx),%eax
80100d02:	8d 7a 04             	lea    0x4(%edx),%edi
80100d05:	31 c9                	xor    %ecx,%ecx
80100d07:	ba 10 00 00 00       	mov    $0x10,%edx
80100d0c:	e8 ff f8 ff ff       	call   80100610 <printint>
80100d11:	89 fa                	mov    %edi,%edx
      break;
80100d13:	eb 9b                	jmp    80100cb0 <cprintf+0x70>
80100d15:	8d 76 00             	lea    0x0(%esi),%esi
      if((s = (char*)*argp++) == 0)
80100d18:	8b 3a                	mov    (%edx),%edi
80100d1a:	8d 4a 04             	lea    0x4(%edx),%ecx
80100d1d:	85 ff                	test   %edi,%edi
80100d1f:	75 69                	jne    80100d8a <cprintf+0x14a>
        s = "(null)";
80100d21:	bf 38 87 10 80       	mov    $0x80108738,%edi
80100d26:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100d29:	b8 28 00 00 00       	mov    $0x28,%eax
80100d2e:	89 fb                	mov    %edi,%ebx
80100d30:	89 cf                	mov    %ecx,%edi
80100d32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        consputc(*s);
80100d38:	e8 23 f8 ff ff       	call   80100560 <consputc>
      for(; *s; s++)
80100d3d:	0f be 43 01          	movsbl 0x1(%ebx),%eax
80100d41:	83 c3 01             	add    $0x1,%ebx
80100d44:	84 c0                	test   %al,%al
80100d46:	75 f0                	jne    80100d38 <cprintf+0xf8>
      if((s = (char*)*argp++) == 0)
80100d48:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80100d4b:	89 fa                	mov    %edi,%edx
80100d4d:	e9 5e ff ff ff       	jmp    80100cb0 <cprintf+0x70>
80100d52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if (panicked) {
80100d58:	8b 0d 98 15 11 80    	mov    0x80111598,%ecx
80100d5e:	85 c9                	test   %ecx,%ecx
80100d60:	74 06                	je     80100d68 <cprintf+0x128>
80100d62:	fa                   	cli
    for (;;) ;
80100d63:	eb fe                	jmp    80100d63 <cprintf+0x123>
80100d65:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(c);
80100d68:	83 ec 0c             	sub    $0xc,%esp
80100d6b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100d6e:	6a 25                	push   $0x25
80100d70:	e8 bb 64 00 00       	call   80107230 <uartputc>
    cgaputc(c);
80100d75:	b8 25 00 00 00       	mov    $0x25,%eax
80100d7a:	e8 a1 f6 ff ff       	call   80100420 <cgaputc>
      break;
80100d7f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    cgaputc(c);
80100d82:	83 c4 10             	add    $0x10,%esp
80100d85:	e9 26 ff ff ff       	jmp    80100cb0 <cprintf+0x70>
      for(; *s; s++)
80100d8a:	0f be 07             	movsbl (%edi),%eax
      if((s = (char*)*argp++) == 0)
80100d8d:	89 ca                	mov    %ecx,%edx
      for(; *s; s++)
80100d8f:	84 c0                	test   %al,%al
80100d91:	0f 84 19 ff ff ff    	je     80100cb0 <cprintf+0x70>
80100d97:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100d9a:	89 fb                	mov    %edi,%ebx
80100d9c:	89 cf                	mov    %ecx,%edi
80100d9e:	eb 98                	jmp    80100d38 <cprintf+0xf8>
    uartputc(c);
80100da0:	83 ec 0c             	sub    $0xc,%esp
80100da3:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80100da6:	6a 25                	push   $0x25
80100da8:	e8 83 64 00 00       	call   80107230 <uartputc>
    cgaputc(c);
80100dad:	b8 25 00 00 00       	mov    $0x25,%eax
80100db2:	e8 69 f6 ff ff       	call   80100420 <cgaputc>
      consputc(c);
80100db7:	89 f8                	mov    %edi,%eax
80100db9:	e8 a2 f7 ff ff       	call   80100560 <consputc>
      break;
80100dbe:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80100dc1:	83 c4 10             	add    $0x10,%esp
80100dc4:	e9 e7 fe ff ff       	jmp    80100cb0 <cprintf+0x70>
80100dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
80100dd0:	83 ec 0c             	sub    $0xc,%esp
80100dd3:	68 60 15 11 80       	push   $0x80111560
80100dd8:	e8 e3 45 00 00       	call   801053c0 <acquire>
  if (fmt == 0)
80100ddd:	83 c4 10             	add    $0x10,%esp
80100de0:	85 f6                	test   %esi,%esi
80100de2:	74 23                	je     80100e07 <cprintf+0x1c7>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100de4:	0f b6 06             	movzbl (%esi),%eax
80100de7:	85 c0                	test   %eax,%eax
80100de9:	0f 85 7a fe ff ff    	jne    80100c69 <cprintf+0x29>
    release(&cons.lock);
80100def:	83 ec 0c             	sub    $0xc,%esp
80100df2:	68 60 15 11 80       	push   $0x80111560
80100df7:	e8 64 45 00 00       	call   80105360 <release>
80100dfc:	83 c4 10             	add    $0x10,%esp
}
80100dff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e02:	5b                   	pop    %ebx
80100e03:	5e                   	pop    %esi
80100e04:	5f                   	pop    %edi
80100e05:	5d                   	pop    %ebp
80100e06:	c3                   	ret
    panic("null fmt");
80100e07:	83 ec 0c             	sub    $0xc,%esp
80100e0a:	68 3f 87 10 80       	push   $0x8010873f
80100e0f:	e8 8c f5 ff ff       	call   801003a0 <panic>
80100e14:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100e1b:	00 
80100e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100e20 <reverse_buff>:
  for (int i = 0; i < select_in; i++)
80100e20:	8b 0d 88 0e 11 80    	mov    0x80110e88,%ecx
80100e26:	85 c9                	test   %ecx,%ecx
80100e28:	74 3e                	je     80100e68 <reverse_buff+0x48>
void reverse_buff(){
80100e2a:	55                   	push   %ebp
80100e2b:	31 c0                	xor    %eax,%eax
80100e2d:	89 e5                	mov    %esp,%ebp
80100e2f:	53                   	push   %ebx
80100e30:	8d 99 20 16 11 80    	lea    -0x7feee9e0(%ecx),%ebx
80100e36:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100e3d:	00 
80100e3e:	66 90                	xchg   %ax,%ax
    reversed_buffer[i] = selected_buffer[select_in-1-i];
80100e40:	89 c2                	mov    %eax,%edx
  for (int i = 0; i < select_in; i++)
80100e42:	83 c0 01             	add    $0x1,%eax
    reversed_buffer[i] = selected_buffer[select_in-1-i];
80100e45:	f7 da                	neg    %edx
80100e47:	0f b6 54 13 ff       	movzbl -0x1(%ebx,%edx,1),%edx
80100e4c:	88 90 9f 15 11 80    	mov    %dl,-0x7feeea61(%eax)
  for (int i = 0; i < select_in; i++)
80100e52:	39 c8                	cmp    %ecx,%eax
80100e54:	75 ea                	jne    80100e40 <reverse_buff+0x20>
  reversed_buffer[select_in] = '\0';
80100e56:	c6 81 a0 15 11 80 00 	movb   $0x0,-0x7feeea60(%ecx)
}
80100e5d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e60:	c9                   	leave
80100e61:	c3                   	ret
80100e62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  reversed_buffer[select_in] = '\0';
80100e68:	c6 81 a0 15 11 80 00 	movb   $0x0,-0x7feeea60(%ecx)
80100e6f:	c3                   	ret

80100e70 <store_command_in_history>:
void store_command_in_history() {
80100e70:	55                   	push   %ebp
80100e71:	89 e5                	mov    %esp,%ebp
80100e73:	56                   	push   %esi
80100e74:	53                   	push   %ebx
    int cmd_len = 0;
80100e75:	31 db                	xor    %ebx,%ebx
void store_command_in_history() {
80100e77:	83 c4 80             	add    $0xffffff80,%esp
  if (input.e > input.w) {
80100e7a:	8b 35 30 15 11 80    	mov    0x80111530,%esi
80100e80:	8b 15 2c 15 11 80    	mov    0x8011152c,%edx
80100e86:	39 f2                	cmp    %esi,%edx
80100e88:	72 1f                	jb     80100ea9 <store_command_in_history+0x39>
}
80100e8a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100e8d:	5b                   	pop    %ebx
80100e8e:	5e                   	pop    %esi
80100e8f:	5d                   	pop    %ebp
80100e90:	c3                   	ret
80100e91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      current_cmd[cmd_len++] = input.buf[i % INPUT_BUF];
80100e98:	83 c3 01             	add    $0x1,%ebx
    for (int i = input.w; i < input.e && input.buf[i % INPUT_BUF] != '\n'; i++) {
80100e9b:	83 c2 01             	add    $0x1,%edx
      current_cmd[cmd_len++] = input.buf[i % INPUT_BUF];
80100e9e:	88 84 1d 77 ff ff ff 	mov    %al,-0x89(%ebp,%ebx,1)
    for (int i = input.w; i < input.e && input.buf[i % INPUT_BUF] != '\n'; i++) {
80100ea5:	39 f2                	cmp    %esi,%edx
80100ea7:	73 1b                	jae    80100ec4 <store_command_in_history+0x54>
80100ea9:	89 d1                	mov    %edx,%ecx
80100eab:	c1 f9 1f             	sar    $0x1f,%ecx
80100eae:	c1 e9 19             	shr    $0x19,%ecx
80100eb1:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
80100eb4:	83 e0 7f             	and    $0x7f,%eax
80100eb7:	29 c8                	sub    %ecx,%eax
80100eb9:	0f b6 80 a0 0e 11 80 	movzbl -0x7feef160(%eax),%eax
80100ec0:	3c 0a                	cmp    $0xa,%al
80100ec2:	75 d4                	jne    80100e98 <store_command_in_history+0x28>
    current_cmd[cmd_len] = '\0';
80100ec4:	c6 84 1d 78 ff ff ff 	movb   $0x0,-0x88(%ebp,%ebx,1)
80100ecb:	00 
    if (should_exclude_from_history(current_cmd))
80100ecc:	80 bd 78 ff ff ff 21 	cmpb   $0x21,-0x88(%ebp)
80100ed3:	bb a0 14 11 80       	mov    $0x801114a0,%ebx
80100ed8:	74 b0                	je     80100e8a <store_command_in_history+0x1a>
80100eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      memmove(input.history[i], input.history[i-1], INPUT_BUF);
80100ee0:	83 ec 04             	sub    $0x4,%esp
80100ee3:	89 d8                	mov    %ebx,%eax
80100ee5:	83 c3 80             	add    $0xffffff80,%ebx
80100ee8:	68 80 00 00 00       	push   $0x80
80100eed:	53                   	push   %ebx
80100eee:	50                   	push   %eax
80100eef:	e8 5c 46 00 00       	call   80105550 <memmove>
    for (int i = HISTORY_BUF-1; i > 0; i--) {
80100ef4:	83 c4 10             	add    $0x10,%esp
80100ef7:	81 fb 20 0f 11 80    	cmp    $0x80110f20,%ebx
80100efd:	75 e1                	jne    80100ee0 <store_command_in_history+0x70>
    for (int i = input.w; i < input.e && input.buf[i % INPUT_BUF] != '\n'; i++) {
80100eff:	8b 15 2c 15 11 80    	mov    0x8011152c,%edx
80100f05:	8b 35 30 15 11 80    	mov    0x80111530,%esi
    int j = 0;
80100f0b:	31 db                	xor    %ebx,%ebx
    for (int i = input.w; i < input.e && input.buf[i % INPUT_BUF] != '\n'; i++) {
80100f0d:	39 f2                	cmp    %esi,%edx
80100f0f:	72 17                	jb     80100f28 <store_command_in_history+0xb8>
80100f11:	eb 30                	jmp    80100f43 <store_command_in_history+0xd3>
80100f13:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100f18:	83 c2 01             	add    $0x1,%edx
      input.history[0][j++] = input.buf[i % INPUT_BUF];
80100f1b:	83 c3 01             	add    $0x1,%ebx
80100f1e:	88 83 1f 0f 11 80    	mov    %al,-0x7feef0e1(%ebx)
    for (int i = input.w; i < input.e && input.buf[i % INPUT_BUF] != '\n'; i++) {
80100f24:	39 f2                	cmp    %esi,%edx
80100f26:	73 1b                	jae    80100f43 <store_command_in_history+0xd3>
80100f28:	89 d1                	mov    %edx,%ecx
80100f2a:	c1 f9 1f             	sar    $0x1f,%ecx
80100f2d:	c1 e9 19             	shr    $0x19,%ecx
80100f30:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
80100f33:	83 e0 7f             	and    $0x7f,%eax
80100f36:	29 c8                	sub    %ecx,%eax
80100f38:	0f b6 80 a0 0e 11 80 	movzbl -0x7feef160(%eax),%eax
80100f3f:	3c 0a                	cmp    $0xa,%al
80100f41:	75 d5                	jne    80100f18 <store_command_in_history+0xa8>
    if (input.last_line_count < HISTORY_BUF)
80100f43:	a1 20 15 11 80       	mov    0x80111520,%eax
    input.history[0][j] = '\0';
80100f48:	c6 83 20 0f 11 80 00 	movb   $0x0,-0x7feef0e0(%ebx)
    if (input.last_line_count < HISTORY_BUF)
80100f4f:	83 f8 0b             	cmp    $0xb,%eax
80100f52:	0f 8f 32 ff ff ff    	jg     80100e8a <store_command_in_history+0x1a>
      input.last_line_count++;
80100f58:	83 c0 01             	add    $0x1,%eax
80100f5b:	a3 20 15 11 80       	mov    %eax,0x80111520
}
80100f60:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100f63:	5b                   	pop    %ebx
80100f64:	5e                   	pop    %esi
80100f65:	5d                   	pop    %ebp
80100f66:	c3                   	ret
80100f67:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100f6e:	00 
80100f6f:	90                   	nop

80100f70 <consoleintr>:
void consoleintr(int (*getc)(void)) {
80100f70:	55                   	push   %ebp
80100f71:	89 e5                	mov    %esp,%ebp
80100f73:	57                   	push   %edi
  int c, doprocdump = 0;
80100f74:	31 ff                	xor    %edi,%edi
void consoleintr(int (*getc)(void)) {
80100f76:	56                   	push   %esi
80100f77:	53                   	push   %ebx
80100f78:	83 ec 18             	sub    $0x18,%esp
80100f7b:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&cons.lock);
80100f7e:	68 60 15 11 80       	push   $0x80111560
80100f83:	e8 38 44 00 00       	call   801053c0 <acquire>
  while ((c = getc()) >= 0) {
80100f88:	83 c4 10             	add    $0x10,%esp
80100f8b:	ff d6                	call   *%esi
80100f8d:	89 c3                	mov    %eax,%ebx
80100f8f:	85 c0                	test   %eax,%eax
80100f91:	0f 88 c9 00 00 00    	js     80101060 <consoleintr+0xf0>
    switch (c) {
80100f97:	83 fb 16             	cmp    $0x16,%ebx
80100f9a:	0f 8f 40 01 00 00    	jg     801010e0 <consoleintr+0x170>
80100fa0:	83 fb 02             	cmp    $0x2,%ebx
80100fa3:	0f 8e 9f 01 00 00    	jle    80101148 <consoleintr+0x1d8>
80100fa9:	8d 43 fd             	lea    -0x3(%ebx),%eax
80100fac:	83 f8 13             	cmp    $0x13,%eax
80100faf:	0f 87 93 01 00 00    	ja     80101148 <consoleintr+0x1d8>
80100fb5:	ff 24 85 ac 8c 10 80 	jmp    *-0x7fef7354(,%eax,4)
        while(reversed_buffer[i] != '\0'){
80100fbc:	0f b6 15 a0 15 11 80 	movzbl 0x801115a0,%edx
        while (input.e != input.w && input.buf[(input.e) % INPUT_BUF] != '\n') {
80100fc3:	a1 30 15 11 80       	mov    0x80111530,%eax
        int i=0;
80100fc8:	31 db                	xor    %ebx,%ebx
        while(reversed_buffer[i] != '\0'){
80100fca:	84 d2                	test   %dl,%dl
80100fcc:	74 bd                	je     80100f8b <consoleintr+0x1b>
80100fce:	66 90                	xchg   %ax,%ax
          input.buf[input.e++ % INPUT_BUF] = reversed_buffer[i];
80100fd0:	8d 48 01             	lea    0x1(%eax),%ecx
80100fd3:	83 e0 7f             	and    $0x7f,%eax
          i++;
80100fd6:	83 c3 01             	add    $0x1,%ebx
          input.buf[input.e++ % INPUT_BUF] = reversed_buffer[i];
80100fd9:	88 90 a0 0e 11 80    	mov    %dl,-0x7feef160(%eax)
          consputc(reversed_buffer[i]);
80100fdf:	0f be c2             	movsbl %dl,%eax
          input.buf[input.e++ % INPUT_BUF] = reversed_buffer[i];
80100fe2:	89 0d 30 15 11 80    	mov    %ecx,0x80111530
          consputc(reversed_buffer[i]);
80100fe8:	e8 73 f5 ff ff       	call   80100560 <consputc>
          select_e = input.e ;
80100fed:	a1 30 15 11 80       	mov    0x80111530,%eax
        while(reversed_buffer[i] != '\0'){
80100ff2:	0f b6 93 a0 15 11 80 	movzbl -0x7feeea60(%ebx),%edx
          select_e = input.e ;
80100ff9:	a3 84 0e 11 80       	mov    %eax,0x80110e84
        while(reversed_buffer[i] != '\0'){
80100ffe:	84 d2                	test   %dl,%dl
80101000:	75 ce                	jne    80100fd0 <consoleintr+0x60>
80101002:	eb 87                	jmp    80100f8b <consoleintr+0x1b>
        while (input.e != input.w && input.buf[(input.e) % INPUT_BUF] != '\n') {
80101004:	a1 30 15 11 80       	mov    0x80111530,%eax
80101009:	3b 05 2c 15 11 80    	cmp    0x8011152c,%eax
8010100f:	0f 84 76 ff ff ff    	je     80100f8b <consoleintr+0x1b>
80101015:	89 c2                	mov    %eax,%edx
80101017:	83 e2 7f             	and    $0x7f,%edx
8010101a:	80 ba a0 0e 11 80 0a 	cmpb   $0xa,-0x7feef160(%edx)
80101021:	0f 84 64 ff ff ff    	je     80100f8b <consoleintr+0x1b>
  if (panicked) {
80101027:	8b 1d 98 15 11 80    	mov    0x80111598,%ebx
          input.e--;
8010102d:	83 e8 01             	sub    $0x1,%eax
80101030:	a3 30 15 11 80       	mov    %eax,0x80111530
          select_e = input.e ;
80101035:	a3 84 0e 11 80       	mov    %eax,0x80110e84
  if (panicked) {
8010103a:	85 db                	test   %ebx,%ebx
8010103c:	0f 84 78 01 00 00    	je     801011ba <consoleintr+0x24a>
80101042:	fa                   	cli
    for (;;) ;
80101043:	eb fe                	jmp    80101043 <consoleintr+0xd3>
80101045:	8d 76 00             	lea    0x0(%esi),%esi
        handle_tab_completion();
80101048:	e8 53 f6 ff ff       	call   801006a0 <handle_tab_completion>
  while ((c = getc()) >= 0) {
8010104d:	ff d6                	call   *%esi
8010104f:	89 c3                	mov    %eax,%ebx
80101051:	85 c0                	test   %eax,%eax
80101053:	0f 89 3e ff ff ff    	jns    80100f97 <consoleintr+0x27>
80101059:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80101060:	83 ec 0c             	sub    $0xc,%esp
80101063:	68 60 15 11 80       	push   $0x80111560
80101068:	e8 f3 42 00 00       	call   80105360 <release>
  if (doprocdump) {
8010106d:	83 c4 10             	add    $0x10,%esp
80101070:	85 ff                	test   %edi,%edi
80101072:	0f 85 0b 02 00 00    	jne    80101283 <consoleintr+0x313>
}
80101078:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010107b:	5b                   	pop    %ebx
8010107c:	5e                   	pop    %esi
8010107d:	5f                   	pop    %edi
8010107e:	5d                   	pop    %ebp
8010107f:	c3                   	ret
        show_last_five_commands();
80101080:	e8 2b fa ff ff       	call   80100ab0 <show_last_five_commands>
        break;
80101085:	e9 01 ff ff ff       	jmp    80100f8b <consoleintr+0x1b>
        if (!stat) {
8010108a:	a1 48 15 11 80       	mov    0x80111548,%eax
8010108f:	85 c0                	test   %eax,%eax
80101091:	0f 85 69 01 00 00    	jne    80101200 <consoleintr+0x290>
          stat = 1 ;
80101097:	c7 05 48 15 11 80 01 	movl   $0x1,0x80111548
8010109e:	00 00 00 
          attribute = 0x7100 ;
801010a1:	c7 05 00 a0 10 80 00 	movl   $0x7100,0x8010a000
801010a8:	71 00 00 
801010ab:	e9 db fe ff ff       	jmp    80100f8b <consoleintr+0x1b>
        if (!copy_mode)
801010b0:	8b 15 80 0e 11 80    	mov    0x80110e80,%edx
801010b6:	85 d2                	test   %edx,%edx
801010b8:	0f 85 d1 01 00 00    	jne    8010128f <consoleintr+0x31f>
          copy_mode = 1 ;
801010be:	c7 05 80 0e 11 80 01 	movl   $0x1,0x80110e80
801010c5:	00 00 00 
          select_in = 0 ;
801010c8:	c7 05 88 0e 11 80 00 	movl   $0x0,0x80110e88
801010cf:	00 00 00 
801010d2:	e9 b4 fe ff ff       	jmp    80100f8b <consoleintr+0x1b>
801010d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801010de:	00 
801010df:	90                   	nop
    switch (c) {
801010e0:	81 fb 4b e0 00 00    	cmp    $0xe04b,%ebx
801010e6:	0f 85 37 01 00 00    	jne    80101223 <consoleintr+0x2b3>
        if (input.e > input.w && select_e > input.w) {
801010ec:	a1 2c 15 11 80       	mov    0x8011152c,%eax
801010f1:	3b 05 30 15 11 80    	cmp    0x80111530,%eax
801010f7:	0f 83 8e fe ff ff    	jae    80100f8b <consoleintr+0x1b>
801010fd:	8b 15 84 0e 11 80    	mov    0x80110e84,%edx
80101103:	39 d0                	cmp    %edx,%eax
80101105:	0f 83 80 fe ff ff    	jae    80100f8b <consoleintr+0x1b>
          if (copy_mode){
8010110b:	8b 0d 80 0e 11 80    	mov    0x80110e80,%ecx
          select_e--;
80101111:	83 ea 01             	sub    $0x1,%edx
80101114:	89 15 84 0e 11 80    	mov    %edx,0x80110e84
          if (copy_mode){
8010111a:	85 c9                	test   %ecx,%ecx
8010111c:	0f 84 69 fe ff ff    	je     80100f8b <consoleintr+0x1b>
            selected_buffer[select_in++] = input.buf[select_e % INPUT_BUF];
80101122:	a1 88 0e 11 80       	mov    0x80110e88,%eax
80101127:	83 e2 7f             	and    $0x7f,%edx
8010112a:	0f b6 92 a0 0e 11 80 	movzbl -0x7feef160(%edx),%edx
80101131:	8d 48 01             	lea    0x1(%eax),%ecx
80101134:	89 0d 88 0e 11 80    	mov    %ecx,0x80110e88
8010113a:	88 90 20 16 11 80    	mov    %dl,-0x7feee9e0(%eax)
80101140:	e9 46 fe ff ff       	jmp    80100f8b <consoleintr+0x1b>
80101145:	8d 76 00             	lea    0x0(%esi),%esi
        if (c != 0 && input.e - input.r < INPUT_BUF) {
80101148:	85 db                	test   %ebx,%ebx
8010114a:	0f 84 3b fe ff ff    	je     80100f8b <consoleintr+0x1b>
80101150:	a1 30 15 11 80       	mov    0x80111530,%eax
80101155:	89 c2                	mov    %eax,%edx
80101157:	2b 15 28 15 11 80    	sub    0x80111528,%edx
8010115d:	83 fa 7f             	cmp    $0x7f,%edx
80101160:	0f 87 25 fe ff ff    	ja     80100f8b <consoleintr+0x1b>
          input.buf[input.e++ % INPUT_BUF] = c;
80101166:	8d 50 01             	lea    0x1(%eax),%edx
80101169:	83 e0 7f             	and    $0x7f,%eax
          c = (c == '\r') ? '\n' : c;
8010116c:	83 fb 0d             	cmp    $0xd,%ebx
8010116f:	0f 85 ca 00 00 00    	jne    8010123f <consoleintr+0x2cf>
          input.buf[input.e++ % INPUT_BUF] = c;
80101175:	c6 80 a0 0e 11 80 0a 	movb   $0xa,-0x7feef160(%eax)
          consputc(c);
8010117c:	b8 0a 00 00 00       	mov    $0xa,%eax
          input.buf[input.e++ % INPUT_BUF] = c;
80101181:	89 15 30 15 11 80    	mov    %edx,0x80111530
          consputc(c);
80101187:	e8 d4 f3 ff ff       	call   80100560 <consputc>
          select_e = input.e ;
8010118c:	a1 30 15 11 80       	mov    0x80111530,%eax
80101191:	a3 84 0e 11 80       	mov    %eax,0x80110e84
              store_command_in_history();
80101196:	e8 d5 fc ff ff       	call   80100e70 <store_command_in_history>
            input.w = input.e;
8010119b:	a1 30 15 11 80       	mov    0x80111530,%eax
            wakeup(&input.r);
801011a0:	83 ec 0c             	sub    $0xc,%esp
            input.w = input.e;
801011a3:	a3 2c 15 11 80       	mov    %eax,0x8011152c
            wakeup(&input.r);
801011a8:	68 28 15 11 80       	push   $0x80111528
801011ad:	e8 4e 3d 00 00       	call   80104f00 <wakeup>
801011b2:	83 c4 10             	add    $0x10,%esp
801011b5:	e9 d1 fd ff ff       	jmp    80100f8b <consoleintr+0x1b>
    uartputc('\b');
801011ba:	83 ec 0c             	sub    $0xc,%esp
801011bd:	6a 08                	push   $0x8
801011bf:	e8 6c 60 00 00       	call   80107230 <uartputc>
    uartputc(' ');
801011c4:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801011cb:	e8 60 60 00 00       	call   80107230 <uartputc>
    uartputc('\b');
801011d0:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801011d7:	e8 54 60 00 00       	call   80107230 <uartputc>
    cgaputc(c);
801011dc:	b8 00 01 00 00       	mov    $0x100,%eax
801011e1:	e8 3a f2 ff ff       	call   80100420 <cgaputc>
        while (input.e != input.w && input.buf[(input.e) % INPUT_BUF] != '\n') {
801011e6:	a1 30 15 11 80       	mov    0x80111530,%eax
801011eb:	83 c4 10             	add    $0x10,%esp
801011ee:	3b 05 2c 15 11 80    	cmp    0x8011152c,%eax
801011f4:	0f 85 1b fe ff ff    	jne    80101015 <consoleintr+0xa5>
801011fa:	e9 8c fd ff ff       	jmp    80100f8b <consoleintr+0x1b>
801011ff:	90                   	nop
          stat = 0 ;
80101200:	c7 05 48 15 11 80 00 	movl   $0x0,0x80111548
80101207:	00 00 00 
          attribute = 0x0700;
8010120a:	c7 05 00 a0 10 80 00 	movl   $0x700,0x8010a000
80101211:	07 00 00 
80101214:	e9 72 fd ff ff       	jmp    80100f8b <consoleintr+0x1b>
    switch (c) {
80101219:	bf 01 00 00 00       	mov    $0x1,%edi
8010121e:	e9 68 fd ff ff       	jmp    80100f8b <consoleintr+0x1b>
        if (c != 0 && input.e - input.r < INPUT_BUF) {
80101223:	a1 30 15 11 80       	mov    0x80111530,%eax
80101228:	89 c2                	mov    %eax,%edx
8010122a:	2b 15 28 15 11 80    	sub    0x80111528,%edx
80101230:	83 fa 7f             	cmp    $0x7f,%edx
80101233:	0f 87 52 fd ff ff    	ja     80100f8b <consoleintr+0x1b>
          input.buf[input.e++ % INPUT_BUF] = c;
80101239:	8d 50 01             	lea    0x1(%eax),%edx
8010123c:	83 e0 7f             	and    $0x7f,%eax
8010123f:	88 98 a0 0e 11 80    	mov    %bl,-0x7feef160(%eax)
          consputc(c);
80101245:	89 d8                	mov    %ebx,%eax
          input.buf[input.e++ % INPUT_BUF] = c;
80101247:	89 15 30 15 11 80    	mov    %edx,0x80111530
          consputc(c);
8010124d:	e8 0e f3 ff ff       	call   80100560 <consputc>
          select_e = input.e ;
80101252:	a1 30 15 11 80       	mov    0x80111530,%eax
80101257:	a3 84 0e 11 80       	mov    %eax,0x80110e84
          if (c == '\n' || c == C('D') || input.e == input.r + INPUT_BUF) {
8010125c:	83 fb 0a             	cmp    $0xa,%ebx
8010125f:	0f 84 31 ff ff ff    	je     80101196 <consoleintr+0x226>
80101265:	83 fb 04             	cmp    $0x4,%ebx
80101268:	74 68                	je     801012d2 <consoleintr+0x362>
8010126a:	8b 0d 28 15 11 80    	mov    0x80111528,%ecx
80101270:	8d 91 80 00 00 00    	lea    0x80(%ecx),%edx
80101276:	39 d0                	cmp    %edx,%eax
80101278:	0f 85 0d fd ff ff    	jne    80100f8b <consoleintr+0x1b>
8010127e:	e9 1d ff ff ff       	jmp    801011a0 <consoleintr+0x230>
}
80101283:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101286:	5b                   	pop    %ebx
80101287:	5e                   	pop    %esi
80101288:	5f                   	pop    %edi
80101289:	5d                   	pop    %ebp
    procdump();  // Now call procdump() without holding cons.lock
8010128a:	e9 51 3d 00 00       	jmp    80104fe0 <procdump>
  for (int i = 0; i < select_in; i++)
8010128f:	8b 0d 88 0e 11 80    	mov    0x80110e88,%ecx
80101295:	31 c0                	xor    %eax,%eax
          copy_mode = 0;
80101297:	c7 05 80 0e 11 80 00 	movl   $0x0,0x80110e80
8010129e:	00 00 00 
  for (int i = 0; i < select_in; i++)
801012a1:	8d 99 20 16 11 80    	lea    -0x7feee9e0(%ecx),%ebx
801012a7:	85 c9                	test   %ecx,%ecx
801012a9:	74 1b                	je     801012c6 <consoleintr+0x356>
801012ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    reversed_buffer[i] = selected_buffer[select_in-1-i];
801012b0:	89 c2                	mov    %eax,%edx
  for (int i = 0; i < select_in; i++)
801012b2:	83 c0 01             	add    $0x1,%eax
    reversed_buffer[i] = selected_buffer[select_in-1-i];
801012b5:	f7 da                	neg    %edx
801012b7:	0f b6 54 13 ff       	movzbl -0x1(%ebx,%edx,1),%edx
801012bc:	88 90 9f 15 11 80    	mov    %dl,-0x7feeea61(%eax)
  for (int i = 0; i < select_in; i++)
801012c2:	39 c8                	cmp    %ecx,%eax
801012c4:	75 ea                	jne    801012b0 <consoleintr+0x340>
  reversed_buffer[select_in] = '\0';
801012c6:	c6 81 a0 15 11 80 00 	movb   $0x0,-0x7feeea60(%ecx)
}
801012cd:	e9 b9 fc ff ff       	jmp    80100f8b <consoleintr+0x1b>
            if (c == '\n') {
801012d2:	83 fb 0a             	cmp    $0xa,%ebx
801012d5:	0f 85 c5 fe ff ff    	jne    801011a0 <consoleintr+0x230>
801012db:	e9 b6 fe ff ff       	jmp    80101196 <consoleintr+0x226>

801012e0 <consoleinit>:

void
consoleinit(void)
{
801012e0:	55                   	push   %ebp
801012e1:	89 e5                	mov    %esp,%ebp
801012e3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801012e6:	68 48 87 10 80       	push   $0x80108748
801012eb:	68 60 15 11 80       	push   $0x80111560
801012f0:	e8 db 3e 00 00       	call   801051d0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801012f5:	58                   	pop    %eax
801012f6:	5a                   	pop    %edx
801012f7:	6a 00                	push   $0x0
801012f9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801012fb:	c7 05 4c 20 11 80 d0 	movl   $0x801008d0,0x8011204c
80101302:	08 10 80 
  devsw[CONSOLE].read = consoleread;
80101305:	c7 05 48 20 11 80 80 	movl   $0x80100280,0x80112048
8010130c:	02 10 80 
  cons.locking = 1;
8010130f:	c7 05 94 15 11 80 01 	movl   $0x1,0x80111594
80101316:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80101319:	e8 32 1f 00 00       	call   80103250 <ioapicenable>
}
8010131e:	83 c4 10             	add    $0x10,%esp
80101321:	c9                   	leave
80101322:	c3                   	ret
80101323:	66 90                	xchg   %ax,%ax
80101325:	66 90                	xchg   %ax,%ax
80101327:	66 90                	xchg   %ax,%ax
80101329:	66 90                	xchg   %ax,%ax
8010132b:	66 90                	xchg   %ax,%ax
8010132d:	66 90                	xchg   %ax,%ax
8010132f:	90                   	nop

80101330 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80101330:	55                   	push   %ebp
80101331:	89 e5                	mov    %esp,%ebp
80101333:	57                   	push   %edi
80101334:	56                   	push   %esi
80101335:	53                   	push   %ebx
80101336:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
8010133c:	e8 2f 34 00 00       	call   80104770 <myproc>
80101341:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80101347:	e8 f4 27 00 00       	call   80103b40 <begin_op>

  if((ip = namei(path)) == 0){
8010134c:	83 ec 0c             	sub    $0xc,%esp
8010134f:	ff 75 08             	push   0x8(%ebp)
80101352:	e8 19 1b 00 00       	call   80102e70 <namei>
80101357:	83 c4 10             	add    $0x10,%esp
8010135a:	85 c0                	test   %eax,%eax
8010135c:	0f 84 30 03 00 00    	je     80101692 <exec+0x362>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80101362:	83 ec 0c             	sub    $0xc,%esp
80101365:	89 c7                	mov    %eax,%edi
80101367:	50                   	push   %eax
80101368:	e8 23 12 00 00       	call   80102590 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
8010136d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80101373:	6a 34                	push   $0x34
80101375:	6a 00                	push   $0x0
80101377:	50                   	push   %eax
80101378:	57                   	push   %edi
80101379:	e8 22 15 00 00       	call   801028a0 <readi>
8010137e:	83 c4 20             	add    $0x20,%esp
80101381:	83 f8 34             	cmp    $0x34,%eax
80101384:	0f 85 01 01 00 00    	jne    8010148b <exec+0x15b>
    goto bad;
  if(elf.magic != ELF_MAGIC)
8010138a:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80101391:	45 4c 46 
80101394:	0f 85 f1 00 00 00    	jne    8010148b <exec+0x15b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
8010139a:	e8 01 70 00 00       	call   801083a0 <setupkvm>
8010139f:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
801013a5:	85 c0                	test   %eax,%eax
801013a7:	0f 84 de 00 00 00    	je     8010148b <exec+0x15b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801013ad:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
801013b4:	00 
801013b5:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
801013bb:	0f 84 a1 02 00 00    	je     80101662 <exec+0x332>
  sz = 0;
801013c1:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
801013c8:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
801013cb:	31 db                	xor    %ebx,%ebx
801013cd:	e9 8c 00 00 00       	jmp    8010145e <exec+0x12e>
801013d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
801013d8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
801013df:	75 6c                	jne    8010144d <exec+0x11d>
      continue;
    if(ph.memsz < ph.filesz)
801013e1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
801013e7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
801013ed:	0f 82 87 00 00 00    	jb     8010147a <exec+0x14a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
801013f3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
801013f9:	72 7f                	jb     8010147a <exec+0x14a>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
801013fb:	83 ec 04             	sub    $0x4,%esp
801013fe:	50                   	push   %eax
801013ff:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80101405:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
8010140b:	e8 c0 6d 00 00       	call   801081d0 <allocuvm>
80101410:	83 c4 10             	add    $0x10,%esp
80101413:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101419:	85 c0                	test   %eax,%eax
8010141b:	74 5d                	je     8010147a <exec+0x14a>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
8010141d:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80101423:	a9 ff 0f 00 00       	test   $0xfff,%eax
80101428:	75 50                	jne    8010147a <exec+0x14a>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
8010142a:	83 ec 0c             	sub    $0xc,%esp
8010142d:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80101433:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80101439:	57                   	push   %edi
8010143a:	50                   	push   %eax
8010143b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101441:	e8 ba 6c 00 00       	call   80108100 <loaduvm>
80101446:	83 c4 20             	add    $0x20,%esp
80101449:	85 c0                	test   %eax,%eax
8010144b:	78 2d                	js     8010147a <exec+0x14a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
8010144d:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80101454:	83 c3 01             	add    $0x1,%ebx
80101457:	83 c6 20             	add    $0x20,%esi
8010145a:	39 d8                	cmp    %ebx,%eax
8010145c:	7e 52                	jle    801014b0 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
8010145e:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80101464:	6a 20                	push   $0x20
80101466:	56                   	push   %esi
80101467:	50                   	push   %eax
80101468:	57                   	push   %edi
80101469:	e8 32 14 00 00       	call   801028a0 <readi>
8010146e:	83 c4 10             	add    $0x10,%esp
80101471:	83 f8 20             	cmp    $0x20,%eax
80101474:	0f 84 5e ff ff ff    	je     801013d8 <exec+0xa8>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
8010147a:	83 ec 0c             	sub    $0xc,%esp
8010147d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101483:	e8 98 6e 00 00       	call   80108320 <freevm>
  if(ip){
80101488:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010148b:	83 ec 0c             	sub    $0xc,%esp
8010148e:	57                   	push   %edi
8010148f:	e8 8c 13 00 00       	call   80102820 <iunlockput>
    end_op();
80101494:	e8 17 27 00 00       	call   80103bb0 <end_op>
80101499:	83 c4 10             	add    $0x10,%esp
    return -1;
8010149c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return -1;
}
801014a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014a4:	5b                   	pop    %ebx
801014a5:	5e                   	pop    %esi
801014a6:	5f                   	pop    %edi
801014a7:	5d                   	pop    %ebp
801014a8:	c3                   	ret
801014a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sz = PGROUNDUP(sz);
801014b0:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
801014b6:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
801014bc:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
801014c2:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
801014c8:	83 ec 0c             	sub    $0xc,%esp
801014cb:	57                   	push   %edi
801014cc:	e8 4f 13 00 00       	call   80102820 <iunlockput>
  end_op();
801014d1:	e8 da 26 00 00       	call   80103bb0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
801014d6:	83 c4 0c             	add    $0xc,%esp
801014d9:	53                   	push   %ebx
801014da:	56                   	push   %esi
801014db:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
801014e1:	56                   	push   %esi
801014e2:	e8 e9 6c 00 00       	call   801081d0 <allocuvm>
801014e7:	83 c4 10             	add    $0x10,%esp
801014ea:	89 c7                	mov    %eax,%edi
801014ec:	85 c0                	test   %eax,%eax
801014ee:	0f 84 86 00 00 00    	je     8010157a <exec+0x24a>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
801014f4:	83 ec 08             	sub    $0x8,%esp
801014f7:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  sp = sz;
801014fd:	89 fb                	mov    %edi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
801014ff:	50                   	push   %eax
80101500:	56                   	push   %esi
  for(argc = 0; argv[argc]; argc++) {
80101501:	31 f6                	xor    %esi,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80101503:	e8 38 6f 00 00       	call   80108440 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80101508:	8b 45 0c             	mov    0xc(%ebp),%eax
8010150b:	83 c4 10             	add    $0x10,%esp
8010150e:	8b 10                	mov    (%eax),%edx
80101510:	85 d2                	test   %edx,%edx
80101512:	0f 84 56 01 00 00    	je     8010166e <exec+0x33e>
80101518:	89 bd f0 fe ff ff    	mov    %edi,-0x110(%ebp)
8010151e:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101521:	eb 23                	jmp    80101546 <exec+0x216>
80101523:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80101528:	8d 46 01             	lea    0x1(%esi),%eax
    ustack[3+argc] = sp;
8010152b:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
80101532:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80101538:	8b 14 87             	mov    (%edi,%eax,4),%edx
8010153b:	85 d2                	test   %edx,%edx
8010153d:	74 51                	je     80101590 <exec+0x260>
    if(argc >= MAXARG)
8010153f:	83 f8 20             	cmp    $0x20,%eax
80101542:	74 36                	je     8010157a <exec+0x24a>
80101544:	89 c6                	mov    %eax,%esi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101546:	83 ec 0c             	sub    $0xc,%esp
80101549:	52                   	push   %edx
8010154a:	e8 61 41 00 00       	call   801056b0 <strlen>
8010154f:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101551:	58                   	pop    %eax
80101552:	ff 34 b7             	push   (%edi,%esi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101555:	83 eb 01             	sub    $0x1,%ebx
80101558:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
8010155b:	e8 50 41 00 00       	call   801056b0 <strlen>
80101560:	83 c0 01             	add    $0x1,%eax
80101563:	50                   	push   %eax
80101564:	ff 34 b7             	push   (%edi,%esi,4)
80101567:	53                   	push   %ebx
80101568:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
8010156e:	e8 9d 70 00 00       	call   80108610 <copyout>
80101573:	83 c4 20             	add    $0x20,%esp
80101576:	85 c0                	test   %eax,%eax
80101578:	79 ae                	jns    80101528 <exec+0x1f8>
    freevm(pgdir);
8010157a:	83 ec 0c             	sub    $0xc,%esp
8010157d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101583:	e8 98 6d 00 00       	call   80108320 <freevm>
80101588:	83 c4 10             	add    $0x10,%esp
8010158b:	e9 0c ff ff ff       	jmp    8010149c <exec+0x16c>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80101590:	8d 14 b5 08 00 00 00 	lea    0x8(,%esi,4),%edx
  ustack[3+argc] = 0;
80101597:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
8010159d:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
801015a3:	8d 46 04             	lea    0x4(%esi),%eax
  sp -= (3+argc+1) * 4;
801015a6:	8d 72 0c             	lea    0xc(%edx),%esi
  ustack[3+argc] = 0;
801015a9:	c7 84 85 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%eax,4)
801015b0:	00 00 00 00 
  ustack[1] = argc;
801015b4:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  ustack[0] = 0xffffffff;  // fake return PC
801015ba:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
801015c1:	ff ff ff 
  ustack[1] = argc;
801015c4:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801015ca:	89 d8                	mov    %ebx,%eax
  sp -= (3+argc+1) * 4;
801015cc:	29 f3                	sub    %esi,%ebx
  ustack[2] = sp - (argc+1)*4;  // argv pointer
801015ce:	29 d0                	sub    %edx,%eax
801015d0:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
801015d6:	56                   	push   %esi
801015d7:	51                   	push   %ecx
801015d8:	53                   	push   %ebx
801015d9:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801015df:	e8 2c 70 00 00       	call   80108610 <copyout>
801015e4:	83 c4 10             	add    $0x10,%esp
801015e7:	85 c0                	test   %eax,%eax
801015e9:	78 8f                	js     8010157a <exec+0x24a>
  for(last=s=path; *s; s++)
801015eb:	8b 45 08             	mov    0x8(%ebp),%eax
801015ee:	8b 55 08             	mov    0x8(%ebp),%edx
801015f1:	0f b6 00             	movzbl (%eax),%eax
801015f4:	84 c0                	test   %al,%al
801015f6:	74 17                	je     8010160f <exec+0x2df>
801015f8:	89 d1                	mov    %edx,%ecx
801015fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      last = s+1;
80101600:	83 c1 01             	add    $0x1,%ecx
80101603:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80101605:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80101608:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
8010160b:	84 c0                	test   %al,%al
8010160d:	75 f1                	jne    80101600 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
8010160f:	83 ec 04             	sub    $0x4,%esp
80101612:	6a 10                	push   $0x10
80101614:	52                   	push   %edx
80101615:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
8010161b:	8d 46 6c             	lea    0x6c(%esi),%eax
8010161e:	50                   	push   %eax
8010161f:	e8 4c 40 00 00       	call   80105670 <safestrcpy>
  curproc->pgdir = pgdir;
80101624:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
8010162a:	89 f0                	mov    %esi,%eax
8010162c:	8b 76 04             	mov    0x4(%esi),%esi
  curproc->sz = sz;
8010162f:	89 38                	mov    %edi,(%eax)
  curproc->pgdir = pgdir;
80101631:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80101634:	89 c1                	mov    %eax,%ecx
80101636:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
8010163c:	8b 40 18             	mov    0x18(%eax),%eax
8010163f:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80101642:	8b 41 18             	mov    0x18(%ecx),%eax
80101645:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80101648:	89 0c 24             	mov    %ecx,(%esp)
8010164b:	e8 20 69 00 00       	call   80107f70 <switchuvm>
  freevm(oldpgdir);
80101650:	89 34 24             	mov    %esi,(%esp)
80101653:	e8 c8 6c 00 00       	call   80108320 <freevm>
  return 0;
80101658:	83 c4 10             	add    $0x10,%esp
8010165b:	31 c0                	xor    %eax,%eax
8010165d:	e9 3f fe ff ff       	jmp    801014a1 <exec+0x171>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101662:	bb 00 20 00 00       	mov    $0x2000,%ebx
80101667:	31 f6                	xor    %esi,%esi
80101669:	e9 5a fe ff ff       	jmp    801014c8 <exec+0x198>
  for(argc = 0; argv[argc]; argc++) {
8010166e:	be 10 00 00 00       	mov    $0x10,%esi
80101673:	ba 04 00 00 00       	mov    $0x4,%edx
80101678:	b8 03 00 00 00       	mov    $0x3,%eax
8010167d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80101684:	00 00 00 
80101687:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
8010168d:	e9 17 ff ff ff       	jmp    801015a9 <exec+0x279>
    end_op();
80101692:	e8 19 25 00 00       	call   80103bb0 <end_op>
    cprintf("exec: fail\n");
80101697:	83 ec 0c             	sub    $0xc,%esp
8010169a:	68 50 87 10 80       	push   $0x80108750
8010169f:	e8 9c f5 ff ff       	call   80100c40 <cprintf>
    return -1;
801016a4:	83 c4 10             	add    $0x10,%esp
801016a7:	e9 f0 fd ff ff       	jmp    8010149c <exec+0x16c>
801016ac:	66 90                	xchg   %ax,%ax
801016ae:	66 90                	xchg   %ax,%ax

801016b0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
801016b0:	55                   	push   %ebp
801016b1:	89 e5                	mov    %esp,%ebp
801016b3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
801016b6:	68 5c 87 10 80       	push   $0x8010875c
801016bb:	68 a0 16 11 80       	push   $0x801116a0
801016c0:	e8 0b 3b 00 00       	call   801051d0 <initlock>
}
801016c5:	83 c4 10             	add    $0x10,%esp
801016c8:	c9                   	leave
801016c9:	c3                   	ret
801016ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801016d0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
801016d0:	55                   	push   %ebp
801016d1:	89 e5                	mov    %esp,%ebp
801016d3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801016d4:	bb d4 16 11 80       	mov    $0x801116d4,%ebx
{
801016d9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
801016dc:	68 a0 16 11 80       	push   $0x801116a0
801016e1:	e8 da 3c 00 00       	call   801053c0 <acquire>
801016e6:	83 c4 10             	add    $0x10,%esp
801016e9:	eb 10                	jmp    801016fb <filealloc+0x2b>
801016eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801016f0:	83 c3 18             	add    $0x18,%ebx
801016f3:	81 fb 34 20 11 80    	cmp    $0x80112034,%ebx
801016f9:	74 25                	je     80101720 <filealloc+0x50>
    if(f->ref == 0){
801016fb:	8b 43 04             	mov    0x4(%ebx),%eax
801016fe:	85 c0                	test   %eax,%eax
80101700:	75 ee                	jne    801016f0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80101702:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80101705:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
8010170c:	68 a0 16 11 80       	push   $0x801116a0
80101711:	e8 4a 3c 00 00       	call   80105360 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80101716:	89 d8                	mov    %ebx,%eax
      return f;
80101718:	83 c4 10             	add    $0x10,%esp
}
8010171b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010171e:	c9                   	leave
8010171f:	c3                   	ret
  release(&ftable.lock);
80101720:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101723:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80101725:	68 a0 16 11 80       	push   $0x801116a0
8010172a:	e8 31 3c 00 00       	call   80105360 <release>
}
8010172f:	89 d8                	mov    %ebx,%eax
  return 0;
80101731:	83 c4 10             	add    $0x10,%esp
}
80101734:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101737:	c9                   	leave
80101738:	c3                   	ret
80101739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101740 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101740:	55                   	push   %ebp
80101741:	89 e5                	mov    %esp,%ebp
80101743:	53                   	push   %ebx
80101744:	83 ec 10             	sub    $0x10,%esp
80101747:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
8010174a:	68 a0 16 11 80       	push   $0x801116a0
8010174f:	e8 6c 3c 00 00       	call   801053c0 <acquire>
  if(f->ref < 1)
80101754:	8b 43 04             	mov    0x4(%ebx),%eax
80101757:	83 c4 10             	add    $0x10,%esp
8010175a:	85 c0                	test   %eax,%eax
8010175c:	7e 1a                	jle    80101778 <filedup+0x38>
    panic("filedup");
  f->ref++;
8010175e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101761:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101764:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101767:	68 a0 16 11 80       	push   $0x801116a0
8010176c:	e8 ef 3b 00 00       	call   80105360 <release>
  return f;
}
80101771:	89 d8                	mov    %ebx,%eax
80101773:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101776:	c9                   	leave
80101777:	c3                   	ret
    panic("filedup");
80101778:	83 ec 0c             	sub    $0xc,%esp
8010177b:	68 63 87 10 80       	push   $0x80108763
80101780:	e8 1b ec ff ff       	call   801003a0 <panic>
80101785:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010178c:	00 
8010178d:	8d 76 00             	lea    0x0(%esi),%esi

80101790 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101790:	55                   	push   %ebp
80101791:	89 e5                	mov    %esp,%ebp
80101793:	57                   	push   %edi
80101794:	56                   	push   %esi
80101795:	53                   	push   %ebx
80101796:	83 ec 28             	sub    $0x28,%esp
80101799:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
8010179c:	68 a0 16 11 80       	push   $0x801116a0
801017a1:	e8 1a 3c 00 00       	call   801053c0 <acquire>
  if(f->ref < 1)
801017a6:	8b 53 04             	mov    0x4(%ebx),%edx
801017a9:	83 c4 10             	add    $0x10,%esp
801017ac:	85 d2                	test   %edx,%edx
801017ae:	0f 8e a5 00 00 00    	jle    80101859 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
801017b4:	83 ea 01             	sub    $0x1,%edx
801017b7:	89 53 04             	mov    %edx,0x4(%ebx)
801017ba:	75 44                	jne    80101800 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
801017bc:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
801017c0:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
801017c3:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
801017c5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
801017cb:	8b 73 0c             	mov    0xc(%ebx),%esi
801017ce:	88 45 e7             	mov    %al,-0x19(%ebp)
801017d1:	8b 43 10             	mov    0x10(%ebx),%eax
801017d4:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
801017d7:	68 a0 16 11 80       	push   $0x801116a0
801017dc:	e8 7f 3b 00 00       	call   80105360 <release>

  if(ff.type == FD_PIPE)
801017e1:	83 c4 10             	add    $0x10,%esp
801017e4:	83 ff 01             	cmp    $0x1,%edi
801017e7:	74 57                	je     80101840 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
801017e9:	83 ff 02             	cmp    $0x2,%edi
801017ec:	74 2a                	je     80101818 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
801017ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017f1:	5b                   	pop    %ebx
801017f2:	5e                   	pop    %esi
801017f3:	5f                   	pop    %edi
801017f4:	5d                   	pop    %ebp
801017f5:	c3                   	ret
801017f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801017fd:	00 
801017fe:	66 90                	xchg   %ax,%ax
    release(&ftable.lock);
80101800:	c7 45 08 a0 16 11 80 	movl   $0x801116a0,0x8(%ebp)
}
80101807:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010180a:	5b                   	pop    %ebx
8010180b:	5e                   	pop    %esi
8010180c:	5f                   	pop    %edi
8010180d:	5d                   	pop    %ebp
    release(&ftable.lock);
8010180e:	e9 4d 3b 00 00       	jmp    80105360 <release>
80101813:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    begin_op();
80101818:	e8 23 23 00 00       	call   80103b40 <begin_op>
    iput(ff.ip);
8010181d:	83 ec 0c             	sub    $0xc,%esp
80101820:	ff 75 e0             	push   -0x20(%ebp)
80101823:	e8 98 0e 00 00       	call   801026c0 <iput>
    end_op();
80101828:	83 c4 10             	add    $0x10,%esp
}
8010182b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010182e:	5b                   	pop    %ebx
8010182f:	5e                   	pop    %esi
80101830:	5f                   	pop    %edi
80101831:	5d                   	pop    %ebp
    end_op();
80101832:	e9 79 23 00 00       	jmp    80103bb0 <end_op>
80101837:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010183e:	00 
8010183f:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
80101840:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101844:	83 ec 08             	sub    $0x8,%esp
80101847:	53                   	push   %ebx
80101848:	56                   	push   %esi
80101849:	e8 b2 2a 00 00       	call   80104300 <pipeclose>
8010184e:	83 c4 10             	add    $0x10,%esp
}
80101851:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101854:	5b                   	pop    %ebx
80101855:	5e                   	pop    %esi
80101856:	5f                   	pop    %edi
80101857:	5d                   	pop    %ebp
80101858:	c3                   	ret
    panic("fileclose");
80101859:	83 ec 0c             	sub    $0xc,%esp
8010185c:	68 6b 87 10 80       	push   $0x8010876b
80101861:	e8 3a eb ff ff       	call   801003a0 <panic>
80101866:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010186d:	00 
8010186e:	66 90                	xchg   %ax,%ax

80101870 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101870:	55                   	push   %ebp
80101871:	89 e5                	mov    %esp,%ebp
80101873:	53                   	push   %ebx
80101874:	83 ec 04             	sub    $0x4,%esp
80101877:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010187a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010187d:	75 31                	jne    801018b0 <filestat+0x40>
    ilock(f->ip);
8010187f:	83 ec 0c             	sub    $0xc,%esp
80101882:	ff 73 10             	push   0x10(%ebx)
80101885:	e8 06 0d 00 00       	call   80102590 <ilock>
    stati(f->ip, st);
8010188a:	58                   	pop    %eax
8010188b:	5a                   	pop    %edx
8010188c:	ff 75 0c             	push   0xc(%ebp)
8010188f:	ff 73 10             	push   0x10(%ebx)
80101892:	e8 d9 0f 00 00       	call   80102870 <stati>
    iunlock(f->ip);
80101897:	59                   	pop    %ecx
80101898:	ff 73 10             	push   0x10(%ebx)
8010189b:	e8 d0 0d 00 00       	call   80102670 <iunlock>
    return 0;
  }
  return -1;
}
801018a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
801018a3:	83 c4 10             	add    $0x10,%esp
801018a6:	31 c0                	xor    %eax,%eax
}
801018a8:	c9                   	leave
801018a9:	c3                   	ret
801018aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801018b0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801018b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801018b8:	c9                   	leave
801018b9:	c3                   	ret
801018ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801018c0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801018c0:	55                   	push   %ebp
801018c1:	89 e5                	mov    %esp,%ebp
801018c3:	57                   	push   %edi
801018c4:	56                   	push   %esi
801018c5:	53                   	push   %ebx
801018c6:	83 ec 0c             	sub    $0xc,%esp
801018c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801018cc:	8b 75 0c             	mov    0xc(%ebp),%esi
801018cf:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
801018d2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801018d6:	74 60                	je     80101938 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
801018d8:	8b 03                	mov    (%ebx),%eax
801018da:	83 f8 01             	cmp    $0x1,%eax
801018dd:	74 41                	je     80101920 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
801018df:	83 f8 02             	cmp    $0x2,%eax
801018e2:	75 5b                	jne    8010193f <fileread+0x7f>
    ilock(f->ip);
801018e4:	83 ec 0c             	sub    $0xc,%esp
801018e7:	ff 73 10             	push   0x10(%ebx)
801018ea:	e8 a1 0c 00 00       	call   80102590 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801018ef:	57                   	push   %edi
801018f0:	ff 73 14             	push   0x14(%ebx)
801018f3:	56                   	push   %esi
801018f4:	ff 73 10             	push   0x10(%ebx)
801018f7:	e8 a4 0f 00 00       	call   801028a0 <readi>
801018fc:	83 c4 20             	add    $0x20,%esp
801018ff:	89 c6                	mov    %eax,%esi
80101901:	85 c0                	test   %eax,%eax
80101903:	7e 03                	jle    80101908 <fileread+0x48>
      f->off += r;
80101905:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101908:	83 ec 0c             	sub    $0xc,%esp
8010190b:	ff 73 10             	push   0x10(%ebx)
8010190e:	e8 5d 0d 00 00       	call   80102670 <iunlock>
    return r;
80101913:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101916:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101919:	89 f0                	mov    %esi,%eax
8010191b:	5b                   	pop    %ebx
8010191c:	5e                   	pop    %esi
8010191d:	5f                   	pop    %edi
8010191e:	5d                   	pop    %ebp
8010191f:	c3                   	ret
    return piperead(f->pipe, addr, n);
80101920:	8b 43 0c             	mov    0xc(%ebx),%eax
80101923:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101926:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101929:	5b                   	pop    %ebx
8010192a:	5e                   	pop    %esi
8010192b:	5f                   	pop    %edi
8010192c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010192d:	e9 8e 2b 00 00       	jmp    801044c0 <piperead>
80101932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101938:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010193d:	eb d7                	jmp    80101916 <fileread+0x56>
  panic("fileread");
8010193f:	83 ec 0c             	sub    $0xc,%esp
80101942:	68 75 87 10 80       	push   $0x80108775
80101947:	e8 54 ea ff ff       	call   801003a0 <panic>
8010194c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101950 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101950:	55                   	push   %ebp
80101951:	89 e5                	mov    %esp,%ebp
80101953:	57                   	push   %edi
80101954:	56                   	push   %esi
80101955:	53                   	push   %ebx
80101956:	83 ec 1c             	sub    $0x1c,%esp
80101959:	8b 45 0c             	mov    0xc(%ebp),%eax
8010195c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010195f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101962:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101965:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
80101969:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010196c:	0f 84 bb 00 00 00    	je     80101a2d <filewrite+0xdd>
    return -1;
  if(f->type == FD_PIPE)
80101972:	8b 03                	mov    (%ebx),%eax
80101974:	83 f8 01             	cmp    $0x1,%eax
80101977:	0f 84 bf 00 00 00    	je     80101a3c <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010197d:	83 f8 02             	cmp    $0x2,%eax
80101980:	0f 85 c8 00 00 00    	jne    80101a4e <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101986:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101989:	31 f6                	xor    %esi,%esi
    while(i < n){
8010198b:	85 c0                	test   %eax,%eax
8010198d:	7f 30                	jg     801019bf <filewrite+0x6f>
8010198f:	e9 94 00 00 00       	jmp    80101a28 <filewrite+0xd8>
80101994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101998:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
8010199b:	83 ec 0c             	sub    $0xc,%esp
        f->off += r;
8010199e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801019a1:	ff 73 10             	push   0x10(%ebx)
801019a4:	e8 c7 0c 00 00       	call   80102670 <iunlock>
      end_op();
801019a9:	e8 02 22 00 00       	call   80103bb0 <end_op>

      if(r < 0)
        break;
      if(r != n1)
801019ae:	8b 45 e0             	mov    -0x20(%ebp),%eax
801019b1:	83 c4 10             	add    $0x10,%esp
801019b4:	39 c7                	cmp    %eax,%edi
801019b6:	75 5c                	jne    80101a14 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
801019b8:	01 fe                	add    %edi,%esi
    while(i < n){
801019ba:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801019bd:	7e 69                	jle    80101a28 <filewrite+0xd8>
      int n1 = n - i;
801019bf:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      if(n1 > max)
801019c2:	b8 00 06 00 00       	mov    $0x600,%eax
      int n1 = n - i;
801019c7:	29 f7                	sub    %esi,%edi
      if(n1 > max)
801019c9:	39 c7                	cmp    %eax,%edi
801019cb:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
801019ce:	e8 6d 21 00 00       	call   80103b40 <begin_op>
      ilock(f->ip);
801019d3:	83 ec 0c             	sub    $0xc,%esp
801019d6:	ff 73 10             	push   0x10(%ebx)
801019d9:	e8 b2 0b 00 00       	call   80102590 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801019de:	57                   	push   %edi
801019df:	ff 73 14             	push   0x14(%ebx)
801019e2:	8b 45 dc             	mov    -0x24(%ebp),%eax
801019e5:	01 f0                	add    %esi,%eax
801019e7:	50                   	push   %eax
801019e8:	ff 73 10             	push   0x10(%ebx)
801019eb:	e8 b0 0f 00 00       	call   801029a0 <writei>
801019f0:	83 c4 20             	add    $0x20,%esp
801019f3:	85 c0                	test   %eax,%eax
801019f5:	7f a1                	jg     80101998 <filewrite+0x48>
801019f7:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801019fa:	83 ec 0c             	sub    $0xc,%esp
801019fd:	ff 73 10             	push   0x10(%ebx)
80101a00:	e8 6b 0c 00 00       	call   80102670 <iunlock>
      end_op();
80101a05:	e8 a6 21 00 00       	call   80103bb0 <end_op>
      if(r < 0)
80101a0a:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101a0d:	83 c4 10             	add    $0x10,%esp
80101a10:	85 c0                	test   %eax,%eax
80101a12:	75 14                	jne    80101a28 <filewrite+0xd8>
        panic("short filewrite");
80101a14:	83 ec 0c             	sub    $0xc,%esp
80101a17:	68 7e 87 10 80       	push   $0x8010877e
80101a1c:	e8 7f e9 ff ff       	call   801003a0 <panic>
80101a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80101a28:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80101a2b:	74 05                	je     80101a32 <filewrite+0xe2>
80101a2d:	be ff ff ff ff       	mov    $0xffffffff,%esi
  }
  panic("filewrite");
}
80101a32:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a35:	89 f0                	mov    %esi,%eax
80101a37:	5b                   	pop    %ebx
80101a38:	5e                   	pop    %esi
80101a39:	5f                   	pop    %edi
80101a3a:	5d                   	pop    %ebp
80101a3b:	c3                   	ret
    return pipewrite(f->pipe, addr, n);
80101a3c:	8b 43 0c             	mov    0xc(%ebx),%eax
80101a3f:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101a42:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a45:	5b                   	pop    %ebx
80101a46:	5e                   	pop    %esi
80101a47:	5f                   	pop    %edi
80101a48:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101a49:	e9 52 29 00 00       	jmp    801043a0 <pipewrite>
  panic("filewrite");
80101a4e:	83 ec 0c             	sub    $0xc,%esp
80101a51:	68 84 87 10 80       	push   $0x80108784
80101a56:	e8 45 e9 ff ff       	call   801003a0 <panic>
80101a5b:	66 90                	xchg   %ax,%ax
80101a5d:	66 90                	xchg   %ax,%ax
80101a5f:	90                   	nop

80101a60 <userinit_extra>:
int global_log_index = 0;
struct spinlock user_lock;

void
userinit_extra(void)
{
80101a60:	55                   	push   %ebp
80101a61:	89 e5                	mov    %esp,%ebp
80101a63:	83 ec 10             	sub    $0x10,%esp
  initlock(&user_lock, "user");
80101a66:	68 8e 87 10 80       	push   $0x8010878e
80101a6b:	68 a0 20 11 80       	push   $0x801120a0
80101a70:	e8 5b 37 00 00       	call   801051d0 <initlock>
  
  for(int i = 0; i < MAX_USERS; i++) {
80101a75:	ba 24 3b 11 80       	mov    $0x80113b24,%edx
80101a7a:	83 c4 10             	add    $0x10,%esp
80101a7d:	31 c0                	xor    %eax,%eax
80101a7f:	90                   	nop
    users[i].valid = 0;
    log_indices[i] = 0;
80101a80:	c7 04 85 c0 21 11 80 	movl   $0x0,-0x7feede40(,%eax,4)
80101a87:	00 00 00 00 
  for(int i = 0; i < MAX_USERS; i++) {
80101a8b:	83 c0 01             	add    $0x1,%eax
80101a8e:	83 c2 28             	add    $0x28,%edx
    users[i].valid = 0;
80101a91:	c7 42 d8 00 00 00 00 	movl   $0x0,-0x28(%edx)
  for(int i = 0; i < MAX_USERS; i++) {
80101a98:	83 f8 10             	cmp    $0x10,%eax
80101a9b:	75 e3                	jne    80101a80 <userinit_extra+0x20>
  }
}
80101a9d:	c9                   	leave
80101a9e:	c3                   	ret
80101a9f:	90                   	nop

80101aa0 <find_user>:

// Check if a user ID exists
int
find_user(int user_id)
{
80101aa0:	55                   	push   %ebp
80101aa1:	b8 00 3b 11 80       	mov    $0x80113b00,%eax
  for(int i = 0; i < MAX_USERS; i++) {
80101aa6:	31 d2                	xor    %edx,%edx
{
80101aa8:	89 e5                	mov    %esp,%ebp
80101aaa:	8b 4d 08             	mov    0x8(%ebp),%ecx
80101aad:	8d 76 00             	lea    0x0(%esi),%esi
    if(users[i].valid && users[i].user_id == user_id)
80101ab0:	83 78 24 00          	cmpl   $0x0,0x24(%eax)
80101ab4:	74 04                	je     80101aba <find_user+0x1a>
80101ab6:	39 08                	cmp    %ecx,(%eax)
80101ab8:	74 10                	je     80101aca <find_user+0x2a>
  for(int i = 0; i < MAX_USERS; i++) {
80101aba:	83 c2 01             	add    $0x1,%edx
80101abd:	83 c0 28             	add    $0x28,%eax
80101ac0:	83 fa 10             	cmp    $0x10,%edx
80101ac3:	75 eb                	jne    80101ab0 <find_user+0x10>
      return i;
  }
  return -1;
80101ac5:	ba ff ff ff ff       	mov    $0xffffffff,%edx
}
80101aca:	89 d0                	mov    %edx,%eax
80101acc:	5d                   	pop    %ebp
80101acd:	c3                   	ret
80101ace:	66 90                	xchg   %ax,%ax

80101ad0 <make_user>:

// Add a new user to the system
int
make_user(int user_id, const char* password)
{
80101ad0:	55                   	push   %ebp
80101ad1:	89 e5                	mov    %esp,%ebp
80101ad3:	57                   	push   %edi
80101ad4:	56                   	push   %esi
80101ad5:	53                   	push   %ebx
80101ad6:	83 ec 28             	sub    $0x28,%esp
80101ad9:	8b 7d 08             	mov    0x8(%ebp),%edi
  int i;
  
  acquire(&user_lock);
80101adc:	68 a0 20 11 80       	push   $0x801120a0
80101ae1:	e8 da 38 00 00       	call   801053c0 <acquire>
  for(int i = 0; i < MAX_USERS; i++) {
80101ae6:	b8 00 3b 11 80       	mov    $0x80113b00,%eax
80101aeb:	83 c4 10             	add    $0x10,%esp
80101aee:	31 d2                	xor    %edx,%edx
    if(users[i].valid && users[i].user_id == user_id)
80101af0:	8b 48 24             	mov    0x24(%eax),%ecx
80101af3:	85 c9                	test   %ecx,%ecx
80101af5:	74 04                	je     80101afb <make_user+0x2b>
80101af7:	3b 38                	cmp    (%eax),%edi
80101af9:	74 26                	je     80101b21 <make_user+0x51>
  for(int i = 0; i < MAX_USERS; i++) {
80101afb:	83 c2 01             	add    $0x1,%edx
80101afe:	83 c0 28             	add    $0x28,%eax
80101b01:	83 fa 10             	cmp    $0x10,%edx
80101b04:	75 ea                	jne    80101af0 <make_user+0x20>
80101b06:	b8 24 3b 11 80       	mov    $0x80113b24,%eax
    release(&user_lock);
    return -1;
  }
  
  // Find empty slot
  for(i = 0; i < MAX_USERS; i++) {
80101b0b:	31 db                	xor    %ebx,%ebx
80101b0d:	8d 76 00             	lea    0x0(%esi),%esi
    if(users[i].valid == 0)
80101b10:	8b 30                	mov    (%eax),%esi
80101b12:	85 f6                	test   %esi,%esi
80101b14:	74 2a                	je     80101b40 <make_user+0x70>
  for(i = 0; i < MAX_USERS; i++) {
80101b16:	83 c3 01             	add    $0x1,%ebx
80101b19:	83 c0 28             	add    $0x28,%eax
80101b1c:	83 fb 10             	cmp    $0x10,%ebx
80101b1f:	75 ef                	jne    80101b10 <make_user+0x40>
    release(&user_lock);
80101b21:	83 ec 0c             	sub    $0xc,%esp
    return -1;
80101b24:	be ff ff ff ff       	mov    $0xffffffff,%esi
    release(&user_lock);
80101b29:	68 a0 20 11 80       	push   $0x801120a0
80101b2e:	e8 2d 38 00 00       	call   80105360 <release>
    return -1;
80101b33:	83 c4 10             	add    $0x10,%esp
80101b36:	eb 58                	jmp    80101b90 <make_user+0xc0>
80101b38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101b3f:	00 
    release(&user_lock);
    return -1;
  }
  
  // Create the new user
  users[i].user_id = user_id;
80101b40:	8d 04 9b             	lea    (%ebx,%ebx,4),%eax
  strncpy(users[i].password, password, MAX_PASSWORD_LEN-1);
80101b43:	83 ec 04             	sub    $0x4,%esp
  users[i].user_id = user_id;
80101b46:	c1 e0 03             	shl    $0x3,%eax
80101b49:	89 b8 00 3b 11 80    	mov    %edi,-0x7feec500(%eax)
80101b4f:	8d 90 00 3b 11 80    	lea    -0x7feec500(%eax),%edx
  strncpy(users[i].password, password, MAX_PASSWORD_LEN-1);
80101b55:	05 04 3b 11 80       	add    $0x80113b04,%eax
  users[i].user_id = user_id;
80101b5a:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  strncpy(users[i].password, password, MAX_PASSWORD_LEN-1);
80101b5d:	6a 1f                	push   $0x1f
80101b5f:	ff 75 0c             	push   0xc(%ebp)
80101b62:	50                   	push   %eax
80101b63:	e8 a8 3a 00 00       	call   80105610 <strncpy>
  users[i].password[MAX_PASSWORD_LEN-1] = '\0';
80101b68:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  users[i].valid = 1;
  log_indices[i] = 0;
80101b6b:	c7 04 9d c0 21 11 80 	movl   $0x0,-0x7feede40(,%ebx,4)
80101b72:	00 00 00 00 
  users[i].password[MAX_PASSWORD_LEN-1] = '\0';
80101b76:	c6 42 23 00          	movb   $0x0,0x23(%edx)
  users[i].valid = 1;
80101b7a:	c7 42 24 01 00 00 00 	movl   $0x1,0x24(%edx)
  
  release(&user_lock);
80101b81:	c7 04 24 a0 20 11 80 	movl   $0x801120a0,(%esp)
80101b88:	e8 d3 37 00 00       	call   80105360 <release>
  return 0;
80101b8d:	83 c4 10             	add    $0x10,%esp
}
80101b90:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b93:	89 f0                	mov    %esi,%eax
80101b95:	5b                   	pop    %ebx
80101b96:	5e                   	pop    %esi
80101b97:	5f                   	pop    %edi
80101b98:	5d                   	pop    %ebp
80101b99:	c3                   	ret
80101b9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101ba0 <login_user>:

// Login a user
int
login_user(int user_id, const char* password)
{
80101ba0:	55                   	push   %ebp
80101ba1:	89 e5                	mov    %esp,%ebp
80101ba3:	57                   	push   %edi
80101ba4:	56                   	push   %esi
80101ba5:	53                   	push   %ebx
80101ba6:	83 ec 0c             	sub    $0xc,%esp
80101ba9:	8b 75 08             	mov    0x8(%ebp),%esi
  struct proc *p = myproc();
80101bac:	e8 bf 2b 00 00       	call   80104770 <myproc>
  int user_index;
  
  acquire(&user_lock);
80101bb1:	83 ec 0c             	sub    $0xc,%esp
80101bb4:	68 a0 20 11 80       	push   $0x801120a0
  struct proc *p = myproc();
80101bb9:	89 c3                	mov    %eax,%ebx
  acquire(&user_lock);
80101bbb:	e8 00 38 00 00       	call   801053c0 <acquire>
  for(int i = 0; i < MAX_USERS; i++) {
80101bc0:	b8 00 3b 11 80       	mov    $0x80113b00,%eax
80101bc5:	83 c4 10             	add    $0x10,%esp
80101bc8:	31 d2                	xor    %edx,%edx
80101bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(users[i].valid && users[i].user_id == user_id)
80101bd0:	8b 48 24             	mov    0x24(%eax),%ecx
80101bd3:	85 c9                	test   %ecx,%ecx
80101bd5:	74 04                	je     80101bdb <login_user+0x3b>
80101bd7:	3b 30                	cmp    (%eax),%esi
80101bd9:	74 25                	je     80101c00 <login_user+0x60>
  for(int i = 0; i < MAX_USERS; i++) {
80101bdb:	83 c2 01             	add    $0x1,%edx
80101bde:	83 c0 28             	add    $0x28,%eax
80101be1:	83 fa 10             	cmp    $0x10,%edx
80101be4:	75 ea                	jne    80101bd0 <login_user+0x30>
  
  // Find the user
  user_index = find_user(user_id);
  if(user_index < 0) {
    release(&user_lock);
80101be6:	83 ec 0c             	sub    $0xc,%esp
    return -1;
80101be9:	bf ff ff ff ff       	mov    $0xffffffff,%edi
    release(&user_lock);
80101bee:	68 a0 20 11 80       	push   $0x801120a0
80101bf3:	e8 68 37 00 00       	call   80105360 <release>
    return -1;
80101bf8:	83 c4 10             	add    $0x10,%esp
80101bfb:	eb 3d                	jmp    80101c3a <login_user+0x9a>
80101bfd:	8d 76 00             	lea    0x0(%esi),%esi
  }
  
  // Check password
  if(strncmp(users[user_index].password, password, MAX_PASSWORD_LEN) != 0) {
80101c00:	8d 04 92             	lea    (%edx,%edx,4),%eax
80101c03:	83 ec 04             	sub    $0x4,%esp
80101c06:	8d 04 c5 04 3b 11 80 	lea    -0x7feec4fc(,%eax,8),%eax
80101c0d:	6a 20                	push   $0x20
80101c0f:	ff 75 0c             	push   0xc(%ebp)
80101c12:	50                   	push   %eax
80101c13:	e8 a8 39 00 00       	call   801055c0 <strncmp>
80101c18:	83 c4 10             	add    $0x10,%esp
80101c1b:	89 c7                	mov    %eax,%edi
80101c1d:	85 c0                	test   %eax,%eax
80101c1f:	75 c5                	jne    80101be6 <login_user+0x46>
    release(&user_lock);
    return -1;
  }
  
  // Only allow login if not already logged in
  if(p->logged_in_user != -1) {
80101c21:	83 7b 7c ff          	cmpl   $0xffffffff,0x7c(%ebx)
80101c25:	75 bf                	jne    80101be6 <login_user+0x46>
  }
  
  // Login the user
  p->logged_in_user = user_id;
  
  release(&user_lock);
80101c27:	83 ec 0c             	sub    $0xc,%esp
  p->logged_in_user = user_id;
80101c2a:	89 73 7c             	mov    %esi,0x7c(%ebx)
  release(&user_lock);
80101c2d:	68 a0 20 11 80       	push   $0x801120a0
80101c32:	e8 29 37 00 00       	call   80105360 <release>
  return 0;
80101c37:	83 c4 10             	add    $0x10,%esp
}
80101c3a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c3d:	89 f8                	mov    %edi,%eax
80101c3f:	5b                   	pop    %ebx
80101c40:	5e                   	pop    %esi
80101c41:	5f                   	pop    %edi
80101c42:	5d                   	pop    %ebp
80101c43:	c3                   	ret
80101c44:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101c4b:	00 
80101c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101c50 <logout_user>:

// Logout current user
int
logout_user(void)
{
80101c50:	55                   	push   %ebp
80101c51:	89 e5                	mov    %esp,%ebp
80101c53:	53                   	push   %ebx
80101c54:	83 ec 14             	sub    $0x14,%esp
  struct proc *p = myproc();
80101c57:	e8 14 2b 00 00       	call   80104770 <myproc>
  
  acquire(&user_lock);
80101c5c:	83 ec 0c             	sub    $0xc,%esp
80101c5f:	68 a0 20 11 80       	push   $0x801120a0
  struct proc *p = myproc();
80101c64:	89 c3                	mov    %eax,%ebx
  acquire(&user_lock);
80101c66:	e8 55 37 00 00       	call   801053c0 <acquire>
  
  // Check if a user is logged in
  if(p->logged_in_user == -1) {
80101c6b:	8b 43 7c             	mov    0x7c(%ebx),%eax
80101c6e:	83 c4 10             	add    $0x10,%esp
80101c71:	83 f8 ff             	cmp    $0xffffffff,%eax
80101c74:	74 1e                	je     80101c94 <logout_user+0x44>
  }
  
  // Logout
  p->logged_in_user = -1;
  
  release(&user_lock);
80101c76:	83 ec 0c             	sub    $0xc,%esp
  p->logged_in_user = -1;
80101c79:	c7 43 7c ff ff ff ff 	movl   $0xffffffff,0x7c(%ebx)
  release(&user_lock);
80101c80:	68 a0 20 11 80       	push   $0x801120a0
80101c85:	e8 d6 36 00 00       	call   80105360 <release>
  return 0;
80101c8a:	83 c4 10             	add    $0x10,%esp
80101c8d:	31 c0                	xor    %eax,%eax
}
80101c8f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101c92:	c9                   	leave
80101c93:	c3                   	ret
    release(&user_lock);
80101c94:	83 ec 0c             	sub    $0xc,%esp
80101c97:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c9a:	68 a0 20 11 80       	push   $0x801120a0
80101c9f:	e8 bc 36 00 00       	call   80105360 <release>
    return -1;
80101ca4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101ca7:	83 c4 10             	add    $0x10,%esp
80101caa:	eb e3                	jmp    80101c8f <logout_user+0x3f>
80101cac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101cb0 <log_syscall>:

// Log a system call
void
log_syscall(int num)
{
80101cb0:	55                   	push   %ebp
80101cb1:	89 e5                	mov    %esp,%ebp
80101cb3:	56                   	push   %esi
80101cb4:	53                   	push   %ebx
80101cb5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p = myproc();
80101cb8:	e8 b3 2a 00 00       	call   80104770 <myproc>
  int user_index;
  
  acquire(&user_lock);
80101cbd:	83 ec 0c             	sub    $0xc,%esp
80101cc0:	68 a0 20 11 80       	push   $0x801120a0
  struct proc *p = myproc();
80101cc5:	89 c6                	mov    %eax,%esi
  acquire(&user_lock);
80101cc7:	e8 f4 36 00 00       	call   801053c0 <acquire>
  
  if(p->logged_in_user != -1) {
80101ccc:	8b 56 7c             	mov    0x7c(%esi),%edx
80101ccf:	83 c4 10             	add    $0x10,%esp
80101cd2:	83 fa ff             	cmp    $0xffffffff,%edx
80101cd5:	74 1e                	je     80101cf5 <log_syscall+0x45>
80101cd7:	b8 00 3b 11 80       	mov    $0x80113b00,%eax
  for(int i = 0; i < MAX_USERS; i++) {
80101cdc:	31 c9                	xor    %ecx,%ecx
80101cde:	66 90                	xchg   %ax,%ax
    if(users[i].valid && users[i].user_id == user_id)
80101ce0:	83 78 24 00          	cmpl   $0x0,0x24(%eax)
80101ce4:	74 04                	je     80101cea <log_syscall+0x3a>
80101ce6:	3b 10                	cmp    (%eax),%edx
80101ce8:	74 4e                	je     80101d38 <log_syscall+0x88>
  for(int i = 0; i < MAX_USERS; i++) {
80101cea:	83 c1 01             	add    $0x1,%ecx
80101ced:	83 c0 28             	add    $0x28,%eax
80101cf0:	83 f9 10             	cmp    $0x10,%ecx
80101cf3:	75 eb                	jne    80101ce0 <log_syscall+0x30>
      log_indices[user_index] = (log_indices[user_index] + 1) % MAX_LOG_ENTRIES;
    }
  }
  
  // Always log to global log
  global_log[global_log_index] = num;
80101cf5:	8b 0d d4 20 11 80    	mov    0x801120d4,%ecx
  global_log_index = (global_log_index + 1) % MAX_LOG_ENTRIES;
80101cfb:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
  
  release(&user_lock);
80101d00:	c7 45 08 a0 20 11 80 	movl   $0x801120a0,0x8(%ebp)
  global_log[global_log_index] = num;
80101d07:	89 1c 8d e0 20 11 80 	mov    %ebx,-0x7feedf20(,%ecx,4)
  global_log_index = (global_log_index + 1) % MAX_LOG_ENTRIES;
80101d0e:	83 c1 01             	add    $0x1,%ecx
80101d11:	f7 e9                	imul   %ecx
80101d13:	89 c8                	mov    %ecx,%eax
80101d15:	c1 f8 1f             	sar    $0x1f,%eax
80101d18:	c1 fa 04             	sar    $0x4,%edx
80101d1b:	29 c2                	sub    %eax,%edx
80101d1d:	6b d2 32             	imul   $0x32,%edx,%edx
80101d20:	29 d1                	sub    %edx,%ecx
80101d22:	89 0d d4 20 11 80    	mov    %ecx,0x801120d4
}
80101d28:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101d2b:	5b                   	pop    %ebx
80101d2c:	5e                   	pop    %esi
80101d2d:	5d                   	pop    %ebp
  release(&user_lock);
80101d2e:	e9 2d 36 00 00       	jmp    80105360 <release>
80101d33:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      syscall_logs[user_index][log_indices[user_index]].syscall_num = num;
80101d38:	6b c1 32             	imul   $0x32,%ecx,%eax
80101d3b:	8b 14 8d c0 21 11 80 	mov    -0x7feede40(,%ecx,4),%edx
80101d42:	01 d0                	add    %edx,%eax
80101d44:	89 1c c5 00 22 11 80 	mov    %ebx,-0x7feede00(,%eax,8)
      syscall_logs[user_index][log_indices[user_index]].pid = p->pid;
80101d4b:	8b 76 10             	mov    0x10(%esi),%esi
80101d4e:	89 34 c5 04 22 11 80 	mov    %esi,-0x7feeddfc(,%eax,8)
      log_indices[user_index] = (log_indices[user_index] + 1) % MAX_LOG_ENTRIES;
80101d55:	8d 72 01             	lea    0x1(%edx),%esi
80101d58:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
80101d5d:	f7 ee                	imul   %esi
80101d5f:	89 f0                	mov    %esi,%eax
80101d61:	c1 f8 1f             	sar    $0x1f,%eax
80101d64:	c1 fa 04             	sar    $0x4,%edx
80101d67:	29 c2                	sub    %eax,%edx
80101d69:	6b c2 32             	imul   $0x32,%edx,%eax
80101d6c:	29 c6                	sub    %eax,%esi
80101d6e:	89 34 8d c0 21 11 80 	mov    %esi,-0x7feede40(,%ecx,4)
80101d75:	e9 7b ff ff ff       	jmp    80101cf5 <log_syscall+0x45>
80101d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101d80 <get_log>:

// Get system call logs
int
get_log(void)
{
80101d80:	55                   	push   %ebp
80101d81:	89 e5                	mov    %esp,%ebp
80101d83:	57                   	push   %edi
80101d84:	56                   	push   %esi
80101d85:	53                   	push   %ebx
80101d86:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p = myproc();
80101d89:	e8 e2 29 00 00       	call   80104770 <myproc>
  int user_index;
  int i;
  
  acquire(&user_lock);
80101d8e:	83 ec 0c             	sub    $0xc,%esp
80101d91:	68 a0 20 11 80       	push   $0x801120a0
  struct proc *p = myproc();
80101d96:	89 c3                	mov    %eax,%ebx
  acquire(&user_lock);
80101d98:	e8 23 36 00 00       	call   801053c0 <acquire>
  
  if(p->logged_in_user != -1) {
80101d9d:	8b 53 7c             	mov    0x7c(%ebx),%edx
80101da0:	83 c4 10             	add    $0x10,%esp
80101da3:	83 fa ff             	cmp    $0xffffffff,%edx
80101da6:	0f 84 ac 00 00 00    	je     80101e58 <get_log+0xd8>
80101dac:	b8 00 3b 11 80       	mov    $0x80113b00,%eax
  for(int i = 0; i < MAX_USERS; i++) {
80101db1:	31 ff                	xor    %edi,%edi
80101db3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(users[i].valid && users[i].user_id == user_id)
80101db8:	8b 48 24             	mov    0x24(%eax),%ecx
80101dbb:	85 c9                	test   %ecx,%ecx
80101dbd:	74 04                	je     80101dc3 <get_log+0x43>
80101dbf:	3b 10                	cmp    (%eax),%edx
80101dc1:	74 25                	je     80101de8 <get_log+0x68>
  for(int i = 0; i < MAX_USERS; i++) {
80101dc3:	83 c7 01             	add    $0x1,%edi
80101dc6:	83 c0 28             	add    $0x28,%eax
80101dc9:	83 ff 10             	cmp    $0x10,%edi
80101dcc:	75 ea                	jne    80101db8 <get_log+0x38>
        cprintf("SysCall: %d\n", global_log[idx]);
      }
    }
  }
  
  release(&user_lock);
80101dce:	83 ec 0c             	sub    $0xc,%esp
80101dd1:	68 a0 20 11 80       	push   $0x801120a0
80101dd6:	e8 85 35 00 00       	call   80105360 <release>
  return 0;
}
80101ddb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dde:	31 c0                	xor    %eax,%eax
80101de0:	5b                   	pop    %ebx
80101de1:	5e                   	pop    %esi
80101de2:	5f                   	pop    %edi
80101de3:	5d                   	pop    %ebp
80101de4:	c3                   	ret
80101de5:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("System call log for user %d:\n", p->logged_in_user);
80101de8:	83 ec 08             	sub    $0x8,%esp
        if(syscall_logs[user_index][idx].pid != 0) {
80101deb:	6b f7 32             	imul   $0x32,%edi,%esi
      for(i = 0; i < MAX_LOG_ENTRIES; i++) {
80101dee:	31 db                	xor    %ebx,%ebx
      cprintf("System call log for user %d:\n", p->logged_in_user);
80101df0:	52                   	push   %edx
80101df1:	68 cf 87 10 80       	push   $0x801087cf
80101df6:	e8 45 ee ff ff       	call   80100c40 <cprintf>
80101dfb:	83 c4 10             	add    $0x10,%esp
80101dfe:	eb 08                	jmp    80101e08 <get_log+0x88>
      for(i = 0; i < MAX_LOG_ENTRIES; i++) {
80101e00:	83 c3 01             	add    $0x1,%ebx
80101e03:	83 fb 32             	cmp    $0x32,%ebx
80101e06:	74 c6                	je     80101dce <get_log+0x4e>
        int idx = (log_indices[user_index] - i - 1 + MAX_LOG_ENTRIES) % MAX_LOG_ENTRIES;
80101e08:	8b 0c bd c0 21 11 80 	mov    -0x7feede40(,%edi,4),%ecx
80101e0f:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
80101e14:	29 d9                	sub    %ebx,%ecx
80101e16:	83 c1 31             	add    $0x31,%ecx
80101e19:	f7 e9                	imul   %ecx
80101e1b:	89 c8                	mov    %ecx,%eax
80101e1d:	c1 f8 1f             	sar    $0x1f,%eax
80101e20:	c1 fa 04             	sar    $0x4,%edx
80101e23:	29 c2                	sub    %eax,%edx
80101e25:	6b c2 32             	imul   $0x32,%edx,%eax
80101e28:	29 c1                	sub    %eax,%ecx
80101e2a:	89 ca                	mov    %ecx,%edx
        if(syscall_logs[user_index][idx].pid != 0) {
80101e2c:	01 f2                	add    %esi,%edx
80101e2e:	8b 04 d5 04 22 11 80 	mov    -0x7feeddfc(,%edx,8),%eax
80101e35:	85 c0                	test   %eax,%eax
80101e37:	74 c7                	je     80101e00 <get_log+0x80>
          cprintf("SysCall: %d, PID: %d\n", 
80101e39:	83 ec 04             	sub    $0x4,%esp
80101e3c:	50                   	push   %eax
80101e3d:	ff 34 d5 00 22 11 80 	push   -0x7feede00(,%edx,8)
80101e44:	68 93 87 10 80       	push   $0x80108793
80101e49:	e8 f2 ed ff ff       	call   80100c40 <cprintf>
80101e4e:	83 c4 10             	add    $0x10,%esp
80101e51:	eb ad                	jmp    80101e00 <get_log+0x80>
80101e53:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    cprintf("Global system call log:\n");
80101e58:	83 ec 0c             	sub    $0xc,%esp
    for(i = 0; i < MAX_LOG_ENTRIES; i++) {
80101e5b:	31 db                	xor    %ebx,%ebx
      int idx = (global_log_index - i - 1 + MAX_LOG_ENTRIES) % MAX_LOG_ENTRIES;
80101e5d:	be 1f 85 eb 51       	mov    $0x51eb851f,%esi
    cprintf("Global system call log:\n");
80101e62:	68 a9 87 10 80       	push   $0x801087a9
80101e67:	e8 d4 ed ff ff       	call   80100c40 <cprintf>
80101e6c:	83 c4 10             	add    $0x10,%esp
80101e6f:	eb 13                	jmp    80101e84 <get_log+0x104>
80101e71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(i = 0; i < MAX_LOG_ENTRIES; i++) {
80101e78:	83 c3 01             	add    $0x1,%ebx
80101e7b:	83 fb 32             	cmp    $0x32,%ebx
80101e7e:	0f 84 4a ff ff ff    	je     80101dce <get_log+0x4e>
      int idx = (global_log_index - i - 1 + MAX_LOG_ENTRIES) % MAX_LOG_ENTRIES;
80101e84:	8b 0d d4 20 11 80    	mov    0x801120d4,%ecx
80101e8a:	29 d9                	sub    %ebx,%ecx
80101e8c:	83 c1 31             	add    $0x31,%ecx
80101e8f:	89 c8                	mov    %ecx,%eax
80101e91:	f7 ee                	imul   %esi
80101e93:	89 c8                	mov    %ecx,%eax
80101e95:	c1 f8 1f             	sar    $0x1f,%eax
80101e98:	c1 fa 04             	sar    $0x4,%edx
80101e9b:	29 c2                	sub    %eax,%edx
80101e9d:	6b d2 32             	imul   $0x32,%edx,%edx
80101ea0:	29 d1                	sub    %edx,%ecx
      if(global_log[idx] != 0) {
80101ea2:	8b 04 8d e0 20 11 80 	mov    -0x7feedf20(,%ecx,4),%eax
80101ea9:	85 c0                	test   %eax,%eax
80101eab:	74 cb                	je     80101e78 <get_log+0xf8>
        cprintf("SysCall: %d\n", global_log[idx]);
80101ead:	83 ec 08             	sub    $0x8,%esp
80101eb0:	50                   	push   %eax
80101eb1:	68 c2 87 10 80       	push   $0x801087c2
80101eb6:	e8 85 ed ff ff       	call   80100c40 <cprintf>
80101ebb:	83 c4 10             	add    $0x10,%esp
80101ebe:	eb b8                	jmp    80101e78 <get_log+0xf8>

80101ec0 <sys_make_user>:


int
sys_make_user(void)
{
80101ec0:	55                   	push   %ebp
80101ec1:	89 e5                	mov    %esp,%ebp
80101ec3:	83 ec 20             	sub    $0x20,%esp
  int user_id;
  char *password;

  if(argint(0, &user_id) < 0)
80101ec6:	8d 45 f0             	lea    -0x10(%ebp),%eax
80101ec9:	50                   	push   %eax
80101eca:	6a 00                	push   $0x0
80101ecc:	e8 9f 38 00 00       	call   80105770 <argint>
80101ed1:	83 c4 10             	add    $0x10,%esp
80101ed4:	85 c0                	test   %eax,%eax
80101ed6:	78 28                	js     80101f00 <sys_make_user+0x40>
    return -1;
  if(argstr(1, &password) < 0)
80101ed8:	83 ec 08             	sub    $0x8,%esp
80101edb:	8d 45 f4             	lea    -0xc(%ebp),%eax
80101ede:	50                   	push   %eax
80101edf:	6a 01                	push   $0x1
80101ee1:	e8 4a 39 00 00       	call   80105830 <argstr>
80101ee6:	83 c4 10             	add    $0x10,%esp
80101ee9:	85 c0                	test   %eax,%eax
80101eeb:	78 13                	js     80101f00 <sys_make_user+0x40>
    return -1;
  
  return make_user(user_id, password);
80101eed:	83 ec 08             	sub    $0x8,%esp
80101ef0:	ff 75 f4             	push   -0xc(%ebp)
80101ef3:	ff 75 f0             	push   -0x10(%ebp)
80101ef6:	e8 d5 fb ff ff       	call   80101ad0 <make_user>
80101efb:	83 c4 10             	add    $0x10,%esp
}
80101efe:	c9                   	leave
80101eff:	c3                   	ret
80101f00:	c9                   	leave
    return -1;
80101f01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101f06:	c3                   	ret
80101f07:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101f0e:	00 
80101f0f:	90                   	nop

80101f10 <sys_login>:

int
sys_login(void)
{
80101f10:	55                   	push   %ebp
80101f11:	89 e5                	mov    %esp,%ebp
80101f13:	83 ec 20             	sub    $0x20,%esp
  int user_id;
  char *password;

  if(argint(0, &user_id) < 0)
80101f16:	8d 45 f0             	lea    -0x10(%ebp),%eax
80101f19:	50                   	push   %eax
80101f1a:	6a 00                	push   $0x0
80101f1c:	e8 4f 38 00 00       	call   80105770 <argint>
80101f21:	83 c4 10             	add    $0x10,%esp
80101f24:	85 c0                	test   %eax,%eax
80101f26:	78 28                	js     80101f50 <sys_login+0x40>
    return -1;
  if(argstr(1, &password) < 0)
80101f28:	83 ec 08             	sub    $0x8,%esp
80101f2b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80101f2e:	50                   	push   %eax
80101f2f:	6a 01                	push   $0x1
80101f31:	e8 fa 38 00 00       	call   80105830 <argstr>
80101f36:	83 c4 10             	add    $0x10,%esp
80101f39:	85 c0                	test   %eax,%eax
80101f3b:	78 13                	js     80101f50 <sys_login+0x40>
    return -1;
  
  return login_user(user_id, password);
80101f3d:	83 ec 08             	sub    $0x8,%esp
80101f40:	ff 75 f4             	push   -0xc(%ebp)
80101f43:	ff 75 f0             	push   -0x10(%ebp)
80101f46:	e8 55 fc ff ff       	call   80101ba0 <login_user>
80101f4b:	83 c4 10             	add    $0x10,%esp
}
80101f4e:	c9                   	leave
80101f4f:	c3                   	ret
80101f50:	c9                   	leave
    return -1;
80101f51:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101f56:	c3                   	ret
80101f57:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101f5e:	00 
80101f5f:	90                   	nop

80101f60 <sys_logout>:

int
sys_logout(void)
{
80101f60:	55                   	push   %ebp
80101f61:	89 e5                	mov    %esp,%ebp
80101f63:	53                   	push   %ebx
80101f64:	83 ec 14             	sub    $0x14,%esp
  struct proc *p = myproc();
80101f67:	e8 04 28 00 00       	call   80104770 <myproc>
  acquire(&user_lock);
80101f6c:	83 ec 0c             	sub    $0xc,%esp
80101f6f:	68 a0 20 11 80       	push   $0x801120a0
  struct proc *p = myproc();
80101f74:	89 c3                	mov    %eax,%ebx
  acquire(&user_lock);
80101f76:	e8 45 34 00 00       	call   801053c0 <acquire>
  if(p->logged_in_user == -1) {
80101f7b:	8b 43 7c             	mov    0x7c(%ebx),%eax
80101f7e:	83 c4 10             	add    $0x10,%esp
80101f81:	83 f8 ff             	cmp    $0xffffffff,%eax
80101f84:	74 1e                	je     80101fa4 <sys_logout+0x44>
  release(&user_lock);
80101f86:	83 ec 0c             	sub    $0xc,%esp
  p->logged_in_user = -1;
80101f89:	c7 43 7c ff ff ff ff 	movl   $0xffffffff,0x7c(%ebx)
  release(&user_lock);
80101f90:	68 a0 20 11 80       	push   $0x801120a0
80101f95:	e8 c6 33 00 00       	call   80105360 <release>
  return 0;
80101f9a:	83 c4 10             	add    $0x10,%esp
80101f9d:	31 c0                	xor    %eax,%eax
  return logout_user();
}
80101f9f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101fa2:	c9                   	leave
80101fa3:	c3                   	ret
    release(&user_lock);
80101fa4:	83 ec 0c             	sub    $0xc,%esp
80101fa7:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101faa:	68 a0 20 11 80       	push   $0x801120a0
80101faf:	e8 ac 33 00 00       	call   80105360 <release>
    return -1;
80101fb4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101fb7:	83 c4 10             	add    $0x10,%esp
80101fba:	eb e3                	jmp    80101f9f <sys_logout+0x3f>
80101fbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101fc0 <sys_get_log>:

int
sys_get_log(void)
{
  return get_log();
80101fc0:	e9 bb fd ff ff       	jmp    80101d80 <get_log>
80101fc5:	66 90                	xchg   %ax,%ax
80101fc7:	66 90                	xchg   %ax,%ax
80101fc9:	66 90                	xchg   %ax,%ax
80101fcb:	66 90                	xchg   %ax,%ax
80101fcd:	66 90                	xchg   %ax,%ax
80101fcf:	90                   	nop

80101fd0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101fd0:	55                   	push   %ebp
80101fd1:	89 e5                	mov    %esp,%ebp
80101fd3:	57                   	push   %edi
80101fd4:	56                   	push   %esi
80101fd5:	53                   	push   %ebx
80101fd6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101fd9:	8b 0d d4 59 11 80    	mov    0x801159d4,%ecx
{
80101fdf:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101fe2:	85 c9                	test   %ecx,%ecx
80101fe4:	0f 84 8c 00 00 00    	je     80102076 <balloc+0xa6>
80101fea:	31 ff                	xor    %edi,%edi
    bp = bread(dev, BBLOCK(b, sb));
80101fec:	89 f8                	mov    %edi,%eax
80101fee:	83 ec 08             	sub    $0x8,%esp
80101ff1:	89 fe                	mov    %edi,%esi
80101ff3:	c1 f8 0c             	sar    $0xc,%eax
80101ff6:	03 05 ec 59 11 80    	add    0x801159ec,%eax
80101ffc:	50                   	push   %eax
80101ffd:	ff 75 dc             	push   -0x24(%ebp)
80102000:	e8 cb e0 ff ff       	call   801000d0 <bread>
80102005:	83 c4 10             	add    $0x10,%esp
80102008:	89 7d d8             	mov    %edi,-0x28(%ebp)
8010200b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010200e:	a1 d4 59 11 80       	mov    0x801159d4,%eax
80102013:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102016:	31 c0                	xor    %eax,%eax
80102018:	eb 32                	jmp    8010204c <balloc+0x7c>
8010201a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80102020:	89 c1                	mov    %eax,%ecx
80102022:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80102027:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      m = 1 << (bi % 8);
8010202a:	83 e1 07             	and    $0x7,%ecx
8010202d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010202f:	89 c1                	mov    %eax,%ecx
80102031:	c1 f9 03             	sar    $0x3,%ecx
80102034:	0f b6 7c 0f 5c       	movzbl 0x5c(%edi,%ecx,1),%edi
80102039:	89 fa                	mov    %edi,%edx
8010203b:	85 df                	test   %ebx,%edi
8010203d:	74 49                	je     80102088 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010203f:	83 c0 01             	add    $0x1,%eax
80102042:	83 c6 01             	add    $0x1,%esi
80102045:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010204a:	74 07                	je     80102053 <balloc+0x83>
8010204c:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010204f:	39 d6                	cmp    %edx,%esi
80102051:	72 cd                	jb     80102020 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80102053:	8b 7d d8             	mov    -0x28(%ebp),%edi
80102056:	83 ec 0c             	sub    $0xc,%esp
80102059:	ff 75 e4             	push   -0x1c(%ebp)
  for(b = 0; b < sb.size; b += BPB){
8010205c:	81 c7 00 10 00 00    	add    $0x1000,%edi
    brelse(bp);
80102062:	e8 89 e1 ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
80102067:	83 c4 10             	add    $0x10,%esp
8010206a:	3b 3d d4 59 11 80    	cmp    0x801159d4,%edi
80102070:	0f 82 76 ff ff ff    	jb     80101fec <balloc+0x1c>
  }
  panic("balloc: out of blocks");
80102076:	83 ec 0c             	sub    $0xc,%esp
80102079:	68 ed 87 10 80       	push   $0x801087ed
8010207e:	e8 1d e3 ff ff       	call   801003a0 <panic>
80102083:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
80102088:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
8010208b:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
8010208e:	09 da                	or     %ebx,%edx
80102090:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
80102094:	57                   	push   %edi
80102095:	e8 86 1c 00 00       	call   80103d20 <log_write>
        brelse(bp);
8010209a:	89 3c 24             	mov    %edi,(%esp)
8010209d:	e8 4e e1 ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
801020a2:	58                   	pop    %eax
801020a3:	5a                   	pop    %edx
801020a4:	56                   	push   %esi
801020a5:	ff 75 dc             	push   -0x24(%ebp)
801020a8:	e8 23 e0 ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
801020ad:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
801020b0:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801020b2:	8d 40 5c             	lea    0x5c(%eax),%eax
801020b5:	68 00 02 00 00       	push   $0x200
801020ba:	6a 00                	push   $0x0
801020bc:	50                   	push   %eax
801020bd:	e8 fe 33 00 00       	call   801054c0 <memset>
  log_write(bp);
801020c2:	89 1c 24             	mov    %ebx,(%esp)
801020c5:	e8 56 1c 00 00       	call   80103d20 <log_write>
  brelse(bp);
801020ca:	89 1c 24             	mov    %ebx,(%esp)
801020cd:	e8 1e e1 ff ff       	call   801001f0 <brelse>
}
801020d2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020d5:	89 f0                	mov    %esi,%eax
801020d7:	5b                   	pop    %ebx
801020d8:	5e                   	pop    %esi
801020d9:	5f                   	pop    %edi
801020da:	5d                   	pop    %ebp
801020db:	c3                   	ret
801020dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801020e0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801020e0:	55                   	push   %ebp
801020e1:	89 e5                	mov    %esp,%ebp
801020e3:	57                   	push   %edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801020e4:	31 ff                	xor    %edi,%edi
{
801020e6:	56                   	push   %esi
801020e7:	89 c6                	mov    %eax,%esi
801020e9:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801020ea:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
{
801020ef:	83 ec 28             	sub    $0x28,%esp
801020f2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801020f5:	68 80 3d 11 80       	push   $0x80113d80
801020fa:	e8 c1 32 00 00       	call   801053c0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801020ff:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80102102:	83 c4 10             	add    $0x10,%esp
80102105:	eb 1b                	jmp    80102122 <iget+0x42>
80102107:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010210e:	00 
8010210f:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80102110:	39 33                	cmp    %esi,(%ebx)
80102112:	74 6c                	je     80102180 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80102114:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010211a:	81 fb d4 59 11 80    	cmp    $0x801159d4,%ebx
80102120:	74 26                	je     80102148 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80102122:	8b 43 08             	mov    0x8(%ebx),%eax
80102125:	85 c0                	test   %eax,%eax
80102127:	7f e7                	jg     80102110 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80102129:	85 ff                	test   %edi,%edi
8010212b:	75 e7                	jne    80102114 <iget+0x34>
8010212d:	85 c0                	test   %eax,%eax
8010212f:	75 76                	jne    801021a7 <iget+0xc7>
      empty = ip;
80102131:	89 df                	mov    %ebx,%edi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80102133:	81 c3 90 00 00 00    	add    $0x90,%ebx
80102139:	81 fb d4 59 11 80    	cmp    $0x801159d4,%ebx
8010213f:	75 e1                	jne    80102122 <iget+0x42>
80102141:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80102148:	85 ff                	test   %edi,%edi
8010214a:	74 79                	je     801021c5 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010214c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010214f:	89 37                	mov    %esi,(%edi)
  ip->inum = inum;
80102151:	89 57 04             	mov    %edx,0x4(%edi)
  ip->ref = 1;
80102154:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
  ip->valid = 0;
8010215b:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
  release(&icache.lock);
80102162:	68 80 3d 11 80       	push   $0x80113d80
80102167:	e8 f4 31 00 00       	call   80105360 <release>

  return ip;
8010216c:	83 c4 10             	add    $0x10,%esp
}
8010216f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102172:	89 f8                	mov    %edi,%eax
80102174:	5b                   	pop    %ebx
80102175:	5e                   	pop    %esi
80102176:	5f                   	pop    %edi
80102177:	5d                   	pop    %ebp
80102178:	c3                   	ret
80102179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80102180:	39 53 04             	cmp    %edx,0x4(%ebx)
80102183:	75 8f                	jne    80102114 <iget+0x34>
      ip->ref++;
80102185:	83 c0 01             	add    $0x1,%eax
      release(&icache.lock);
80102188:	83 ec 0c             	sub    $0xc,%esp
      return ip;
8010218b:	89 df                	mov    %ebx,%edi
      ip->ref++;
8010218d:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80102190:	68 80 3d 11 80       	push   $0x80113d80
80102195:	e8 c6 31 00 00       	call   80105360 <release>
      return ip;
8010219a:	83 c4 10             	add    $0x10,%esp
}
8010219d:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021a0:	89 f8                	mov    %edi,%eax
801021a2:	5b                   	pop    %ebx
801021a3:	5e                   	pop    %esi
801021a4:	5f                   	pop    %edi
801021a5:	5d                   	pop    %ebp
801021a6:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801021a7:	81 c3 90 00 00 00    	add    $0x90,%ebx
801021ad:	81 fb d4 59 11 80    	cmp    $0x801159d4,%ebx
801021b3:	74 10                	je     801021c5 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801021b5:	8b 43 08             	mov    0x8(%ebx),%eax
801021b8:	85 c0                	test   %eax,%eax
801021ba:	0f 8f 50 ff ff ff    	jg     80102110 <iget+0x30>
801021c0:	e9 68 ff ff ff       	jmp    8010212d <iget+0x4d>
    panic("iget: no inodes");
801021c5:	83 ec 0c             	sub    $0xc,%esp
801021c8:	68 03 88 10 80       	push   $0x80108803
801021cd:	e8 ce e1 ff ff       	call   801003a0 <panic>
801021d2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801021d9:	00 
801021da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801021e0 <bfree>:
{
801021e0:	55                   	push   %ebp
801021e1:	89 c1                	mov    %eax,%ecx
  bp = bread(dev, BBLOCK(b, sb));
801021e3:	89 d0                	mov    %edx,%eax
801021e5:	c1 e8 0c             	shr    $0xc,%eax
{
801021e8:	89 e5                	mov    %esp,%ebp
801021ea:	56                   	push   %esi
801021eb:	53                   	push   %ebx
  bp = bread(dev, BBLOCK(b, sb));
801021ec:	03 05 ec 59 11 80    	add    0x801159ec,%eax
{
801021f2:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
801021f4:	83 ec 08             	sub    $0x8,%esp
801021f7:	50                   	push   %eax
801021f8:	51                   	push   %ecx
801021f9:	e8 d2 de ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
801021fe:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80102200:	c1 fb 03             	sar    $0x3,%ebx
80102203:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80102206:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80102208:	83 e1 07             	and    $0x7,%ecx
8010220b:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
80102210:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
80102216:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80102218:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
8010221d:	85 c1                	test   %eax,%ecx
8010221f:	74 23                	je     80102244 <bfree+0x64>
  bp->data[bi/8] &= ~m;
80102221:	f7 d0                	not    %eax
  log_write(bp);
80102223:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80102226:	21 c8                	and    %ecx,%eax
80102228:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010222c:	56                   	push   %esi
8010222d:	e8 ee 1a 00 00       	call   80103d20 <log_write>
  brelse(bp);
80102232:	89 34 24             	mov    %esi,(%esp)
80102235:	e8 b6 df ff ff       	call   801001f0 <brelse>
}
8010223a:	83 c4 10             	add    $0x10,%esp
8010223d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102240:	5b                   	pop    %ebx
80102241:	5e                   	pop    %esi
80102242:	5d                   	pop    %ebp
80102243:	c3                   	ret
    panic("freeing free block");
80102244:	83 ec 0c             	sub    $0xc,%esp
80102247:	68 13 88 10 80       	push   $0x80108813
8010224c:	e8 4f e1 ff ff       	call   801003a0 <panic>
80102251:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102258:	00 
80102259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102260 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80102260:	55                   	push   %ebp
80102261:	89 e5                	mov    %esp,%ebp
80102263:	57                   	push   %edi
80102264:	56                   	push   %esi
80102265:	89 c6                	mov    %eax,%esi
80102267:	53                   	push   %ebx
80102268:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010226b:	83 fa 0b             	cmp    $0xb,%edx
8010226e:	0f 86 8c 00 00 00    	jbe    80102300 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80102274:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80102277:	83 fb 7f             	cmp    $0x7f,%ebx
8010227a:	0f 87 a2 00 00 00    	ja     80102322 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80102280:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80102286:	85 c0                	test   %eax,%eax
80102288:	74 5e                	je     801022e8 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010228a:	83 ec 08             	sub    $0x8,%esp
8010228d:	50                   	push   %eax
8010228e:	ff 36                	push   (%esi)
80102290:	e8 3b de ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80102295:	83 c4 10             	add    $0x10,%esp
80102298:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010229c:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
8010229e:	8b 3b                	mov    (%ebx),%edi
801022a0:	85 ff                	test   %edi,%edi
801022a2:	74 1c                	je     801022c0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801022a4:	83 ec 0c             	sub    $0xc,%esp
801022a7:	52                   	push   %edx
801022a8:	e8 43 df ff ff       	call   801001f0 <brelse>
801022ad:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
801022b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022b3:	89 f8                	mov    %edi,%eax
801022b5:	5b                   	pop    %ebx
801022b6:	5e                   	pop    %esi
801022b7:	5f                   	pop    %edi
801022b8:	5d                   	pop    %ebp
801022b9:	c3                   	ret
801022ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801022c0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
801022c3:	8b 06                	mov    (%esi),%eax
801022c5:	e8 06 fd ff ff       	call   80101fd0 <balloc>
      log_write(bp);
801022ca:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801022cd:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801022d0:	89 03                	mov    %eax,(%ebx)
801022d2:	89 c7                	mov    %eax,%edi
      log_write(bp);
801022d4:	52                   	push   %edx
801022d5:	e8 46 1a 00 00       	call   80103d20 <log_write>
801022da:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801022dd:	83 c4 10             	add    $0x10,%esp
801022e0:	eb c2                	jmp    801022a4 <bmap+0x44>
801022e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801022e8:	8b 06                	mov    (%esi),%eax
801022ea:	e8 e1 fc ff ff       	call   80101fd0 <balloc>
801022ef:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801022f5:	eb 93                	jmp    8010228a <bmap+0x2a>
801022f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801022fe:	00 
801022ff:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
80102300:	8d 5a 14             	lea    0x14(%edx),%ebx
80102303:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80102307:	85 ff                	test   %edi,%edi
80102309:	75 a5                	jne    801022b0 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010230b:	8b 00                	mov    (%eax),%eax
8010230d:	e8 be fc ff ff       	call   80101fd0 <balloc>
80102312:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80102316:	89 c7                	mov    %eax,%edi
}
80102318:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010231b:	5b                   	pop    %ebx
8010231c:	89 f8                	mov    %edi,%eax
8010231e:	5e                   	pop    %esi
8010231f:	5f                   	pop    %edi
80102320:	5d                   	pop    %ebp
80102321:	c3                   	ret
  panic("bmap: out of range");
80102322:	83 ec 0c             	sub    $0xc,%esp
80102325:	68 26 88 10 80       	push   $0x80108826
8010232a:	e8 71 e0 ff ff       	call   801003a0 <panic>
8010232f:	90                   	nop

80102330 <readsb>:
{
80102330:	55                   	push   %ebp
80102331:	89 e5                	mov    %esp,%ebp
80102333:	56                   	push   %esi
80102334:	53                   	push   %ebx
80102335:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80102338:	83 ec 08             	sub    $0x8,%esp
8010233b:	6a 01                	push   $0x1
8010233d:	ff 75 08             	push   0x8(%ebp)
80102340:	e8 8b dd ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80102345:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80102348:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010234a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010234d:	6a 1c                	push   $0x1c
8010234f:	50                   	push   %eax
80102350:	56                   	push   %esi
80102351:	e8 fa 31 00 00       	call   80105550 <memmove>
  brelse(bp);
80102356:	83 c4 10             	add    $0x10,%esp
80102359:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010235c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010235f:	5b                   	pop    %ebx
80102360:	5e                   	pop    %esi
80102361:	5d                   	pop    %ebp
  brelse(bp);
80102362:	e9 89 de ff ff       	jmp    801001f0 <brelse>
80102367:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010236e:	00 
8010236f:	90                   	nop

80102370 <iinit>:
{
80102370:	55                   	push   %ebp
80102371:	89 e5                	mov    %esp,%ebp
80102373:	53                   	push   %ebx
80102374:	bb c0 3d 11 80       	mov    $0x80113dc0,%ebx
80102379:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010237c:	68 39 88 10 80       	push   $0x80108839
80102381:	68 80 3d 11 80       	push   $0x80113d80
80102386:	e8 45 2e 00 00       	call   801051d0 <initlock>
  for(i = 0; i < NINODE; i++) {
8010238b:	83 c4 10             	add    $0x10,%esp
8010238e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80102390:	83 ec 08             	sub    $0x8,%esp
80102393:	68 40 88 10 80       	push   $0x80108840
80102398:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80102399:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
8010239f:	e8 fc 2c 00 00       	call   801050a0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801023a4:	83 c4 10             	add    $0x10,%esp
801023a7:	81 fb e0 59 11 80    	cmp    $0x801159e0,%ebx
801023ad:	75 e1                	jne    80102390 <iinit+0x20>
  bp = bread(dev, 1);
801023af:	83 ec 08             	sub    $0x8,%esp
801023b2:	6a 01                	push   $0x1
801023b4:	ff 75 08             	push   0x8(%ebp)
801023b7:	e8 14 dd ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801023bc:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801023bf:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801023c1:	8d 40 5c             	lea    0x5c(%eax),%eax
801023c4:	6a 1c                	push   $0x1c
801023c6:	50                   	push   %eax
801023c7:	68 d4 59 11 80       	push   $0x801159d4
801023cc:	e8 7f 31 00 00       	call   80105550 <memmove>
  brelse(bp);
801023d1:	89 1c 24             	mov    %ebx,(%esp)
801023d4:	e8 17 de ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801023d9:	ff 35 ec 59 11 80    	push   0x801159ec
801023df:	ff 35 e8 59 11 80    	push   0x801159e8
801023e5:	ff 35 e4 59 11 80    	push   0x801159e4
801023eb:	ff 35 e0 59 11 80    	push   0x801159e0
801023f1:	ff 35 dc 59 11 80    	push   0x801159dc
801023f7:	ff 35 d8 59 11 80    	push   0x801159d8
801023fd:	ff 35 d4 59 11 80    	push   0x801159d4
80102403:	68 10 8d 10 80       	push   $0x80108d10
80102408:	e8 33 e8 ff ff       	call   80100c40 <cprintf>
}
8010240d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102410:	83 c4 30             	add    $0x30,%esp
80102413:	c9                   	leave
80102414:	c3                   	ret
80102415:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010241c:	00 
8010241d:	8d 76 00             	lea    0x0(%esi),%esi

80102420 <ialloc>:
{
80102420:	55                   	push   %ebp
80102421:	89 e5                	mov    %esp,%ebp
80102423:	57                   	push   %edi
80102424:	56                   	push   %esi
80102425:	53                   	push   %ebx
80102426:	83 ec 1c             	sub    $0x1c,%esp
80102429:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010242c:	83 3d dc 59 11 80 01 	cmpl   $0x1,0x801159dc
{
80102433:	8b 75 08             	mov    0x8(%ebp),%esi
80102436:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80102439:	0f 86 91 00 00 00    	jbe    801024d0 <ialloc+0xb0>
8010243f:	bf 01 00 00 00       	mov    $0x1,%edi
80102444:	eb 21                	jmp    80102467 <ialloc+0x47>
80102446:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010244d:	00 
8010244e:	66 90                	xchg   %ax,%ax
    brelse(bp);
80102450:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80102453:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80102456:	53                   	push   %ebx
80102457:	e8 94 dd ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010245c:	83 c4 10             	add    $0x10,%esp
8010245f:	3b 3d dc 59 11 80    	cmp    0x801159dc,%edi
80102465:	73 69                	jae    801024d0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80102467:	89 f8                	mov    %edi,%eax
80102469:	83 ec 08             	sub    $0x8,%esp
8010246c:	c1 e8 03             	shr    $0x3,%eax
8010246f:	03 05 e8 59 11 80    	add    0x801159e8,%eax
80102475:	50                   	push   %eax
80102476:	56                   	push   %esi
80102477:	e8 54 dc ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010247c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010247f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80102481:	89 f8                	mov    %edi,%eax
80102483:	83 e0 07             	and    $0x7,%eax
80102486:	c1 e0 06             	shl    $0x6,%eax
80102489:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010248d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80102491:	75 bd                	jne    80102450 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80102493:	83 ec 04             	sub    $0x4,%esp
80102496:	6a 40                	push   $0x40
80102498:	6a 00                	push   $0x0
8010249a:	51                   	push   %ecx
8010249b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010249e:	e8 1d 30 00 00       	call   801054c0 <memset>
      dip->type = type;
801024a3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801024a7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801024aa:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801024ad:	89 1c 24             	mov    %ebx,(%esp)
801024b0:	e8 6b 18 00 00       	call   80103d20 <log_write>
      brelse(bp);
801024b5:	89 1c 24             	mov    %ebx,(%esp)
801024b8:	e8 33 dd ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
801024bd:	83 c4 10             	add    $0x10,%esp
}
801024c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801024c3:	89 fa                	mov    %edi,%edx
}
801024c5:	5b                   	pop    %ebx
      return iget(dev, inum);
801024c6:	89 f0                	mov    %esi,%eax
}
801024c8:	5e                   	pop    %esi
801024c9:	5f                   	pop    %edi
801024ca:	5d                   	pop    %ebp
      return iget(dev, inum);
801024cb:	e9 10 fc ff ff       	jmp    801020e0 <iget>
  panic("ialloc: no inodes");
801024d0:	83 ec 0c             	sub    $0xc,%esp
801024d3:	68 46 88 10 80       	push   $0x80108846
801024d8:	e8 c3 de ff ff       	call   801003a0 <panic>
801024dd:	8d 76 00             	lea    0x0(%esi),%esi

801024e0 <iupdate>:
{
801024e0:	55                   	push   %ebp
801024e1:	89 e5                	mov    %esp,%ebp
801024e3:	56                   	push   %esi
801024e4:	53                   	push   %ebx
801024e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801024e8:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801024eb:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801024ee:	83 ec 08             	sub    $0x8,%esp
801024f1:	c1 e8 03             	shr    $0x3,%eax
801024f4:	03 05 e8 59 11 80    	add    0x801159e8,%eax
801024fa:	50                   	push   %eax
801024fb:	ff 73 a4             	push   -0x5c(%ebx)
801024fe:	e8 cd db ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80102503:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80102507:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010250a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010250c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010250f:	83 e0 07             	and    $0x7,%eax
80102512:	c1 e0 06             	shl    $0x6,%eax
80102515:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80102519:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010251c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80102520:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80102523:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80102527:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010252b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010252f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80102533:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80102537:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010253a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010253d:	6a 34                	push   $0x34
8010253f:	53                   	push   %ebx
80102540:	50                   	push   %eax
80102541:	e8 0a 30 00 00       	call   80105550 <memmove>
  log_write(bp);
80102546:	89 34 24             	mov    %esi,(%esp)
80102549:	e8 d2 17 00 00       	call   80103d20 <log_write>
  brelse(bp);
8010254e:	83 c4 10             	add    $0x10,%esp
80102551:	89 75 08             	mov    %esi,0x8(%ebp)
}
80102554:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102557:	5b                   	pop    %ebx
80102558:	5e                   	pop    %esi
80102559:	5d                   	pop    %ebp
  brelse(bp);
8010255a:	e9 91 dc ff ff       	jmp    801001f0 <brelse>
8010255f:	90                   	nop

80102560 <idup>:
{
80102560:	55                   	push   %ebp
80102561:	89 e5                	mov    %esp,%ebp
80102563:	53                   	push   %ebx
80102564:	83 ec 10             	sub    $0x10,%esp
80102567:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010256a:	68 80 3d 11 80       	push   $0x80113d80
8010256f:	e8 4c 2e 00 00       	call   801053c0 <acquire>
  ip->ref++;
80102574:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80102578:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
8010257f:	e8 dc 2d 00 00       	call   80105360 <release>
}
80102584:	89 d8                	mov    %ebx,%eax
80102586:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102589:	c9                   	leave
8010258a:	c3                   	ret
8010258b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102590 <ilock>:
{
80102590:	55                   	push   %ebp
80102591:	89 e5                	mov    %esp,%ebp
80102593:	56                   	push   %esi
80102594:	53                   	push   %ebx
80102595:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80102598:	85 db                	test   %ebx,%ebx
8010259a:	0f 84 b7 00 00 00    	je     80102657 <ilock+0xc7>
801025a0:	8b 53 08             	mov    0x8(%ebx),%edx
801025a3:	85 d2                	test   %edx,%edx
801025a5:	0f 8e ac 00 00 00    	jle    80102657 <ilock+0xc7>
  acquiresleep(&ip->lock);
801025ab:	83 ec 0c             	sub    $0xc,%esp
801025ae:	8d 43 0c             	lea    0xc(%ebx),%eax
801025b1:	50                   	push   %eax
801025b2:	e8 29 2b 00 00       	call   801050e0 <acquiresleep>
  if(ip->valid == 0){
801025b7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801025ba:	83 c4 10             	add    $0x10,%esp
801025bd:	85 c0                	test   %eax,%eax
801025bf:	74 0f                	je     801025d0 <ilock+0x40>
}
801025c1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025c4:	5b                   	pop    %ebx
801025c5:	5e                   	pop    %esi
801025c6:	5d                   	pop    %ebp
801025c7:	c3                   	ret
801025c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801025cf:	00 
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801025d0:	8b 43 04             	mov    0x4(%ebx),%eax
801025d3:	83 ec 08             	sub    $0x8,%esp
801025d6:	c1 e8 03             	shr    $0x3,%eax
801025d9:	03 05 e8 59 11 80    	add    0x801159e8,%eax
801025df:	50                   	push   %eax
801025e0:	ff 33                	push   (%ebx)
801025e2:	e8 e9 da ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801025e7:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801025ea:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801025ec:	8b 43 04             	mov    0x4(%ebx),%eax
801025ef:	83 e0 07             	and    $0x7,%eax
801025f2:	c1 e0 06             	shl    $0x6,%eax
801025f5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801025f9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801025fc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801025ff:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80102603:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80102607:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010260b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010260f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80102613:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80102617:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010261b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010261e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80102621:	6a 34                	push   $0x34
80102623:	50                   	push   %eax
80102624:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102627:	50                   	push   %eax
80102628:	e8 23 2f 00 00       	call   80105550 <memmove>
    brelse(bp);
8010262d:	89 34 24             	mov    %esi,(%esp)
80102630:	e8 bb db ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80102635:	83 c4 10             	add    $0x10,%esp
80102638:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010263d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80102644:	0f 85 77 ff ff ff    	jne    801025c1 <ilock+0x31>
      panic("ilock: no type");
8010264a:	83 ec 0c             	sub    $0xc,%esp
8010264d:	68 5e 88 10 80       	push   $0x8010885e
80102652:	e8 49 dd ff ff       	call   801003a0 <panic>
    panic("ilock");
80102657:	83 ec 0c             	sub    $0xc,%esp
8010265a:	68 58 88 10 80       	push   $0x80108858
8010265f:	e8 3c dd ff ff       	call   801003a0 <panic>
80102664:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010266b:	00 
8010266c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102670 <iunlock>:
{
80102670:	55                   	push   %ebp
80102671:	89 e5                	mov    %esp,%ebp
80102673:	56                   	push   %esi
80102674:	53                   	push   %ebx
80102675:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102678:	85 db                	test   %ebx,%ebx
8010267a:	74 28                	je     801026a4 <iunlock+0x34>
8010267c:	83 ec 0c             	sub    $0xc,%esp
8010267f:	8d 73 0c             	lea    0xc(%ebx),%esi
80102682:	56                   	push   %esi
80102683:	e8 f8 2a 00 00       	call   80105180 <holdingsleep>
80102688:	83 c4 10             	add    $0x10,%esp
8010268b:	85 c0                	test   %eax,%eax
8010268d:	74 15                	je     801026a4 <iunlock+0x34>
8010268f:	8b 43 08             	mov    0x8(%ebx),%eax
80102692:	85 c0                	test   %eax,%eax
80102694:	7e 0e                	jle    801026a4 <iunlock+0x34>
  releasesleep(&ip->lock);
80102696:	89 75 08             	mov    %esi,0x8(%ebp)
}
80102699:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010269c:	5b                   	pop    %ebx
8010269d:	5e                   	pop    %esi
8010269e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010269f:	e9 9c 2a 00 00       	jmp    80105140 <releasesleep>
    panic("iunlock");
801026a4:	83 ec 0c             	sub    $0xc,%esp
801026a7:	68 6d 88 10 80       	push   $0x8010886d
801026ac:	e8 ef dc ff ff       	call   801003a0 <panic>
801026b1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801026b8:	00 
801026b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801026c0 <iput>:
{
801026c0:	55                   	push   %ebp
801026c1:	89 e5                	mov    %esp,%ebp
801026c3:	57                   	push   %edi
801026c4:	56                   	push   %esi
801026c5:	53                   	push   %ebx
801026c6:	83 ec 28             	sub    $0x28,%esp
801026c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801026cc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801026cf:	57                   	push   %edi
801026d0:	e8 0b 2a 00 00       	call   801050e0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801026d5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801026d8:	83 c4 10             	add    $0x10,%esp
801026db:	85 d2                	test   %edx,%edx
801026dd:	74 07                	je     801026e6 <iput+0x26>
801026df:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801026e4:	74 32                	je     80102718 <iput+0x58>
  releasesleep(&ip->lock);
801026e6:	83 ec 0c             	sub    $0xc,%esp
801026e9:	57                   	push   %edi
801026ea:	e8 51 2a 00 00       	call   80105140 <releasesleep>
  acquire(&icache.lock);
801026ef:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
801026f6:	e8 c5 2c 00 00       	call   801053c0 <acquire>
  ip->ref--;
801026fb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801026ff:	83 c4 10             	add    $0x10,%esp
80102702:	c7 45 08 80 3d 11 80 	movl   $0x80113d80,0x8(%ebp)
}
80102709:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010270c:	5b                   	pop    %ebx
8010270d:	5e                   	pop    %esi
8010270e:	5f                   	pop    %edi
8010270f:	5d                   	pop    %ebp
  release(&icache.lock);
80102710:	e9 4b 2c 00 00       	jmp    80105360 <release>
80102715:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80102718:	83 ec 0c             	sub    $0xc,%esp
8010271b:	68 80 3d 11 80       	push   $0x80113d80
80102720:	e8 9b 2c 00 00       	call   801053c0 <acquire>
    int r = ip->ref;
80102725:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80102728:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
8010272f:	e8 2c 2c 00 00       	call   80105360 <release>
    if(r == 1){
80102734:	83 c4 10             	add    $0x10,%esp
80102737:	83 fe 01             	cmp    $0x1,%esi
8010273a:	75 aa                	jne    801026e6 <iput+0x26>
8010273c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80102742:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80102745:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102748:	89 df                	mov    %ebx,%edi
8010274a:	89 cb                	mov    %ecx,%ebx
8010274c:	eb 09                	jmp    80102757 <iput+0x97>
8010274e:	66 90                	xchg   %ax,%ax
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80102750:	83 c6 04             	add    $0x4,%esi
80102753:	39 de                	cmp    %ebx,%esi
80102755:	74 19                	je     80102770 <iput+0xb0>
    if(ip->addrs[i]){
80102757:	8b 16                	mov    (%esi),%edx
80102759:	85 d2                	test   %edx,%edx
8010275b:	74 f3                	je     80102750 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010275d:	8b 07                	mov    (%edi),%eax
8010275f:	e8 7c fa ff ff       	call   801021e0 <bfree>
      ip->addrs[i] = 0;
80102764:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010276a:	eb e4                	jmp    80102750 <iput+0x90>
8010276c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80102770:	89 fb                	mov    %edi,%ebx
80102772:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80102775:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
8010277b:	85 c0                	test   %eax,%eax
8010277d:	75 2d                	jne    801027ac <iput+0xec>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010277f:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80102782:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80102789:	53                   	push   %ebx
8010278a:	e8 51 fd ff ff       	call   801024e0 <iupdate>
      ip->type = 0;
8010278f:	31 c0                	xor    %eax,%eax
80102791:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80102795:	89 1c 24             	mov    %ebx,(%esp)
80102798:	e8 43 fd ff ff       	call   801024e0 <iupdate>
      ip->valid = 0;
8010279d:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801027a4:	83 c4 10             	add    $0x10,%esp
801027a7:	e9 3a ff ff ff       	jmp    801026e6 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801027ac:	83 ec 08             	sub    $0x8,%esp
801027af:	50                   	push   %eax
801027b0:	ff 33                	push   (%ebx)
801027b2:	e8 19 d9 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
801027b7:	83 c4 10             	add    $0x10,%esp
801027ba:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801027bd:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801027c3:	89 45 e0             	mov    %eax,-0x20(%ebp)
801027c6:	8d 70 5c             	lea    0x5c(%eax),%esi
801027c9:	89 cf                	mov    %ecx,%edi
801027cb:	eb 0a                	jmp    801027d7 <iput+0x117>
801027cd:	8d 76 00             	lea    0x0(%esi),%esi
801027d0:	83 c6 04             	add    $0x4,%esi
801027d3:	39 fe                	cmp    %edi,%esi
801027d5:	74 0f                	je     801027e6 <iput+0x126>
      if(a[j])
801027d7:	8b 16                	mov    (%esi),%edx
801027d9:	85 d2                	test   %edx,%edx
801027db:	74 f3                	je     801027d0 <iput+0x110>
        bfree(ip->dev, a[j]);
801027dd:	8b 03                	mov    (%ebx),%eax
801027df:	e8 fc f9 ff ff       	call   801021e0 <bfree>
801027e4:	eb ea                	jmp    801027d0 <iput+0x110>
    brelse(bp);
801027e6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801027e9:	83 ec 0c             	sub    $0xc,%esp
801027ec:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801027ef:	50                   	push   %eax
801027f0:	e8 fb d9 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801027f5:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
801027fb:	8b 03                	mov    (%ebx),%eax
801027fd:	e8 de f9 ff ff       	call   801021e0 <bfree>
    ip->addrs[NDIRECT] = 0;
80102802:	83 c4 10             	add    $0x10,%esp
80102805:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
8010280c:	00 00 00 
8010280f:	e9 6b ff ff ff       	jmp    8010277f <iput+0xbf>
80102814:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010281b:	00 
8010281c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102820 <iunlockput>:
{
80102820:	55                   	push   %ebp
80102821:	89 e5                	mov    %esp,%ebp
80102823:	56                   	push   %esi
80102824:	53                   	push   %ebx
80102825:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102828:	85 db                	test   %ebx,%ebx
8010282a:	74 34                	je     80102860 <iunlockput+0x40>
8010282c:	83 ec 0c             	sub    $0xc,%esp
8010282f:	8d 73 0c             	lea    0xc(%ebx),%esi
80102832:	56                   	push   %esi
80102833:	e8 48 29 00 00       	call   80105180 <holdingsleep>
80102838:	83 c4 10             	add    $0x10,%esp
8010283b:	85 c0                	test   %eax,%eax
8010283d:	74 21                	je     80102860 <iunlockput+0x40>
8010283f:	8b 43 08             	mov    0x8(%ebx),%eax
80102842:	85 c0                	test   %eax,%eax
80102844:	7e 1a                	jle    80102860 <iunlockput+0x40>
  releasesleep(&ip->lock);
80102846:	83 ec 0c             	sub    $0xc,%esp
80102849:	56                   	push   %esi
8010284a:	e8 f1 28 00 00       	call   80105140 <releasesleep>
  iput(ip);
8010284f:	83 c4 10             	add    $0x10,%esp
80102852:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80102855:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102858:	5b                   	pop    %ebx
80102859:	5e                   	pop    %esi
8010285a:	5d                   	pop    %ebp
  iput(ip);
8010285b:	e9 60 fe ff ff       	jmp    801026c0 <iput>
    panic("iunlock");
80102860:	83 ec 0c             	sub    $0xc,%esp
80102863:	68 6d 88 10 80       	push   $0x8010886d
80102868:	e8 33 db ff ff       	call   801003a0 <panic>
8010286d:	8d 76 00             	lea    0x0(%esi),%esi

80102870 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80102870:	55                   	push   %ebp
80102871:	89 e5                	mov    %esp,%ebp
80102873:	8b 55 08             	mov    0x8(%ebp),%edx
80102876:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80102879:	8b 0a                	mov    (%edx),%ecx
8010287b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010287e:	8b 4a 04             	mov    0x4(%edx),%ecx
80102881:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80102884:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80102888:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010288b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010288f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80102893:	8b 52 58             	mov    0x58(%edx),%edx
80102896:	89 50 10             	mov    %edx,0x10(%eax)
}
80102899:	5d                   	pop    %ebp
8010289a:	c3                   	ret
8010289b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801028a0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801028a0:	55                   	push   %ebp
801028a1:	89 e5                	mov    %esp,%ebp
801028a3:	57                   	push   %edi
801028a4:	56                   	push   %esi
801028a5:	53                   	push   %ebx
801028a6:	83 ec 1c             	sub    $0x1c,%esp
801028a9:	8b 75 08             	mov    0x8(%ebp),%esi
801028ac:	8b 45 0c             	mov    0xc(%ebp),%eax
801028af:	8b 7d 10             	mov    0x10(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801028b2:	66 83 7e 50 03       	cmpw   $0x3,0x50(%esi)
{
801028b7:	89 45 e0             	mov    %eax,-0x20(%ebp)
801028ba:	89 75 d8             	mov    %esi,-0x28(%ebp)
801028bd:	8b 45 14             	mov    0x14(%ebp),%eax
  if(ip->type == T_DEV){
801028c0:	0f 84 aa 00 00 00    	je     80102970 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801028c6:	8b 75 d8             	mov    -0x28(%ebp),%esi
801028c9:	8b 56 58             	mov    0x58(%esi),%edx
801028cc:	39 fa                	cmp    %edi,%edx
801028ce:	0f 82 bd 00 00 00    	jb     80102991 <readi+0xf1>
801028d4:	89 f9                	mov    %edi,%ecx
801028d6:	31 db                	xor    %ebx,%ebx
801028d8:	01 c1                	add    %eax,%ecx
801028da:	0f 92 c3             	setb   %bl
801028dd:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801028e0:	0f 82 ab 00 00 00    	jb     80102991 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801028e6:	89 d3                	mov    %edx,%ebx
801028e8:	29 fb                	sub    %edi,%ebx
801028ea:	39 ca                	cmp    %ecx,%edx
801028ec:	0f 42 c3             	cmovb  %ebx,%eax

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801028ef:	85 c0                	test   %eax,%eax
801028f1:	74 73                	je     80102966 <readi+0xc6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
801028f3:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801028f6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801028f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102900:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80102903:	89 fa                	mov    %edi,%edx
80102905:	c1 ea 09             	shr    $0x9,%edx
80102908:	89 d8                	mov    %ebx,%eax
8010290a:	e8 51 f9 ff ff       	call   80102260 <bmap>
8010290f:	83 ec 08             	sub    $0x8,%esp
80102912:	50                   	push   %eax
80102913:	ff 33                	push   (%ebx)
80102915:	e8 b6 d7 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
8010291a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010291d:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102922:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80102924:	89 f8                	mov    %edi,%eax
80102926:	25 ff 01 00 00       	and    $0x1ff,%eax
8010292b:	29 f3                	sub    %esi,%ebx
8010292d:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
8010292f:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102933:	39 d9                	cmp    %ebx,%ecx
80102935:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80102938:	83 c4 0c             	add    $0xc,%esp
8010293b:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010293c:	01 de                	add    %ebx,%esi
8010293e:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80102940:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102943:	50                   	push   %eax
80102944:	ff 75 e0             	push   -0x20(%ebp)
80102947:	e8 04 2c 00 00       	call   80105550 <memmove>
    brelse(bp);
8010294c:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010294f:	89 14 24             	mov    %edx,(%esp)
80102952:	e8 99 d8 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102957:	01 5d e0             	add    %ebx,-0x20(%ebp)
8010295a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010295d:	83 c4 10             	add    $0x10,%esp
80102960:	39 de                	cmp    %ebx,%esi
80102962:	72 9c                	jb     80102900 <readi+0x60>
80102964:	89 d8                	mov    %ebx,%eax
  }
  return n;
}
80102966:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102969:	5b                   	pop    %ebx
8010296a:	5e                   	pop    %esi
8010296b:	5f                   	pop    %edi
8010296c:	5d                   	pop    %ebp
8010296d:	c3                   	ret
8010296e:	66 90                	xchg   %ax,%ax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80102970:	0f bf 56 52          	movswl 0x52(%esi),%edx
80102974:	66 83 fa 09          	cmp    $0x9,%dx
80102978:	77 17                	ja     80102991 <readi+0xf1>
8010297a:	8b 14 d5 40 20 11 80 	mov    -0x7feedfc0(,%edx,8),%edx
80102981:	85 d2                	test   %edx,%edx
80102983:	74 0c                	je     80102991 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80102985:	89 45 10             	mov    %eax,0x10(%ebp)
}
80102988:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010298b:	5b                   	pop    %ebx
8010298c:	5e                   	pop    %esi
8010298d:	5f                   	pop    %edi
8010298e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
8010298f:	ff e2                	jmp    *%edx
      return -1;
80102991:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102996:	eb ce                	jmp    80102966 <readi+0xc6>
80102998:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010299f:	00 

801029a0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
801029a0:	55                   	push   %ebp
801029a1:	89 e5                	mov    %esp,%ebp
801029a3:	57                   	push   %edi
801029a4:	56                   	push   %esi
801029a5:	53                   	push   %ebx
801029a6:	83 ec 1c             	sub    $0x1c,%esp
801029a9:	8b 45 08             	mov    0x8(%ebp),%eax
801029ac:	8b 7d 0c             	mov    0xc(%ebp),%edi
801029af:	8b 75 14             	mov    0x14(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801029b2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
801029b7:	89 7d dc             	mov    %edi,-0x24(%ebp)
801029ba:	89 75 e0             	mov    %esi,-0x20(%ebp)
801029bd:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(ip->type == T_DEV){
801029c0:	0f 84 ba 00 00 00    	je     80102a80 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
801029c6:	39 78 58             	cmp    %edi,0x58(%eax)
801029c9:	0f 82 ea 00 00 00    	jb     80102ab9 <writei+0x119>
    return -1;
  if(off + n > MAXFILE*BSIZE)
801029cf:	8b 75 e0             	mov    -0x20(%ebp),%esi
801029d2:	89 f2                	mov    %esi,%edx
801029d4:	01 fa                	add    %edi,%edx
801029d6:	0f 82 dd 00 00 00    	jb     80102ab9 <writei+0x119>
801029dc:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
801029e2:	0f 87 d1 00 00 00    	ja     80102ab9 <writei+0x119>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
801029e8:	85 f6                	test   %esi,%esi
801029ea:	0f 84 85 00 00 00    	je     80102a75 <writei+0xd5>
801029f0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
801029f7:	89 45 d8             	mov    %eax,-0x28(%ebp)
801029fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102a00:	8b 75 d8             	mov    -0x28(%ebp),%esi
80102a03:	89 fa                	mov    %edi,%edx
80102a05:	c1 ea 09             	shr    $0x9,%edx
80102a08:	89 f0                	mov    %esi,%eax
80102a0a:	e8 51 f8 ff ff       	call   80102260 <bmap>
80102a0f:	83 ec 08             	sub    $0x8,%esp
80102a12:	50                   	push   %eax
80102a13:	ff 36                	push   (%esi)
80102a15:	e8 b6 d6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80102a1a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102a1d:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80102a20:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102a25:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80102a27:	89 f8                	mov    %edi,%eax
80102a29:	25 ff 01 00 00       	and    $0x1ff,%eax
80102a2e:	29 d3                	sub    %edx,%ebx
80102a30:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80102a32:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102a36:	39 d9                	cmp    %ebx,%ecx
80102a38:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80102a3b:	83 c4 0c             	add    $0xc,%esp
80102a3e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102a3f:	01 df                	add    %ebx,%edi
    memmove(bp->data + off%BSIZE, src, m);
80102a41:	ff 75 dc             	push   -0x24(%ebp)
80102a44:	50                   	push   %eax
80102a45:	e8 06 2b 00 00       	call   80105550 <memmove>
    log_write(bp);
80102a4a:	89 34 24             	mov    %esi,(%esp)
80102a4d:	e8 ce 12 00 00       	call   80103d20 <log_write>
    brelse(bp);
80102a52:	89 34 24             	mov    %esi,(%esp)
80102a55:	e8 96 d7 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102a5a:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80102a5d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102a60:	83 c4 10             	add    $0x10,%esp
80102a63:	01 5d dc             	add    %ebx,-0x24(%ebp)
80102a66:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80102a69:	39 d8                	cmp    %ebx,%eax
80102a6b:	72 93                	jb     80102a00 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80102a6d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102a70:	39 78 58             	cmp    %edi,0x58(%eax)
80102a73:	72 33                	jb     80102aa8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80102a75:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80102a78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a7b:	5b                   	pop    %ebx
80102a7c:	5e                   	pop    %esi
80102a7d:	5f                   	pop    %edi
80102a7e:	5d                   	pop    %ebp
80102a7f:	c3                   	ret
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102a80:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102a84:	66 83 f8 09          	cmp    $0x9,%ax
80102a88:	77 2f                	ja     80102ab9 <writei+0x119>
80102a8a:	8b 04 c5 44 20 11 80 	mov    -0x7feedfbc(,%eax,8),%eax
80102a91:	85 c0                	test   %eax,%eax
80102a93:	74 24                	je     80102ab9 <writei+0x119>
    return devsw[ip->major].write(ip, src, n);
80102a95:	89 75 10             	mov    %esi,0x10(%ebp)
}
80102a98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a9b:	5b                   	pop    %ebx
80102a9c:	5e                   	pop    %esi
80102a9d:	5f                   	pop    %edi
80102a9e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80102a9f:	ff e0                	jmp    *%eax
80102aa1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iupdate(ip);
80102aa8:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80102aab:	89 78 58             	mov    %edi,0x58(%eax)
    iupdate(ip);
80102aae:	50                   	push   %eax
80102aaf:	e8 2c fa ff ff       	call   801024e0 <iupdate>
80102ab4:	83 c4 10             	add    $0x10,%esp
80102ab7:	eb bc                	jmp    80102a75 <writei+0xd5>
      return -1;
80102ab9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102abe:	eb b8                	jmp    80102a78 <writei+0xd8>

80102ac0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102ac0:	55                   	push   %ebp
80102ac1:	89 e5                	mov    %esp,%ebp
80102ac3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80102ac6:	6a 0e                	push   $0xe
80102ac8:	ff 75 0c             	push   0xc(%ebp)
80102acb:	ff 75 08             	push   0x8(%ebp)
80102ace:	e8 ed 2a 00 00       	call   801055c0 <strncmp>
}
80102ad3:	c9                   	leave
80102ad4:	c3                   	ret
80102ad5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102adc:	00 
80102add:	8d 76 00             	lea    0x0(%esi),%esi

80102ae0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102ae0:	55                   	push   %ebp
80102ae1:	89 e5                	mov    %esp,%ebp
80102ae3:	57                   	push   %edi
80102ae4:	56                   	push   %esi
80102ae5:	53                   	push   %ebx
80102ae6:	83 ec 1c             	sub    $0x1c,%esp
80102ae9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80102aec:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102af1:	0f 85 85 00 00 00    	jne    80102b7c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102af7:	8b 53 58             	mov    0x58(%ebx),%edx
80102afa:	31 ff                	xor    %edi,%edi
80102afc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102aff:	85 d2                	test   %edx,%edx
80102b01:	74 3e                	je     80102b41 <dirlookup+0x61>
80102b03:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102b08:	6a 10                	push   $0x10
80102b0a:	57                   	push   %edi
80102b0b:	56                   	push   %esi
80102b0c:	53                   	push   %ebx
80102b0d:	e8 8e fd ff ff       	call   801028a0 <readi>
80102b12:	83 c4 10             	add    $0x10,%esp
80102b15:	83 f8 10             	cmp    $0x10,%eax
80102b18:	75 55                	jne    80102b6f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80102b1a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102b1f:	74 18                	je     80102b39 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80102b21:	83 ec 04             	sub    $0x4,%esp
80102b24:	8d 45 da             	lea    -0x26(%ebp),%eax
80102b27:	6a 0e                	push   $0xe
80102b29:	50                   	push   %eax
80102b2a:	ff 75 0c             	push   0xc(%ebp)
80102b2d:	e8 8e 2a 00 00       	call   801055c0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80102b32:	83 c4 10             	add    $0x10,%esp
80102b35:	85 c0                	test   %eax,%eax
80102b37:	74 17                	je     80102b50 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102b39:	83 c7 10             	add    $0x10,%edi
80102b3c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102b3f:	72 c7                	jb     80102b08 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80102b41:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80102b44:	31 c0                	xor    %eax,%eax
}
80102b46:	5b                   	pop    %ebx
80102b47:	5e                   	pop    %esi
80102b48:	5f                   	pop    %edi
80102b49:	5d                   	pop    %ebp
80102b4a:	c3                   	ret
80102b4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(poff)
80102b50:	8b 45 10             	mov    0x10(%ebp),%eax
80102b53:	85 c0                	test   %eax,%eax
80102b55:	74 05                	je     80102b5c <dirlookup+0x7c>
        *poff = off;
80102b57:	8b 45 10             	mov    0x10(%ebp),%eax
80102b5a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80102b5c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80102b60:	8b 03                	mov    (%ebx),%eax
80102b62:	e8 79 f5 ff ff       	call   801020e0 <iget>
}
80102b67:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b6a:	5b                   	pop    %ebx
80102b6b:	5e                   	pop    %esi
80102b6c:	5f                   	pop    %edi
80102b6d:	5d                   	pop    %ebp
80102b6e:	c3                   	ret
      panic("dirlookup read");
80102b6f:	83 ec 0c             	sub    $0xc,%esp
80102b72:	68 87 88 10 80       	push   $0x80108887
80102b77:	e8 24 d8 ff ff       	call   801003a0 <panic>
    panic("dirlookup not DIR");
80102b7c:	83 ec 0c             	sub    $0xc,%esp
80102b7f:	68 75 88 10 80       	push   $0x80108875
80102b84:	e8 17 d8 ff ff       	call   801003a0 <panic>
80102b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102b90 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102b90:	55                   	push   %ebp
80102b91:	89 e5                	mov    %esp,%ebp
80102b93:	57                   	push   %edi
80102b94:	56                   	push   %esi
80102b95:	53                   	push   %ebx
80102b96:	89 c3                	mov    %eax,%ebx
80102b98:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80102b9b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80102b9e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102ba1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80102ba4:	0f 84 9e 01 00 00    	je     80102d48 <namex+0x1b8>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80102baa:	e8 c1 1b 00 00       	call   80104770 <myproc>
  acquire(&icache.lock);
80102baf:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80102bb2:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80102bb5:	68 80 3d 11 80       	push   $0x80113d80
80102bba:	e8 01 28 00 00       	call   801053c0 <acquire>
  ip->ref++;
80102bbf:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102bc3:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80102bca:	e8 91 27 00 00       	call   80105360 <release>
80102bcf:	83 c4 10             	add    $0x10,%esp
80102bd2:	eb 07                	jmp    80102bdb <namex+0x4b>
80102bd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102bd8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80102bdb:	0f b6 03             	movzbl (%ebx),%eax
80102bde:	3c 2f                	cmp    $0x2f,%al
80102be0:	74 f6                	je     80102bd8 <namex+0x48>
  if(*path == 0)
80102be2:	84 c0                	test   %al,%al
80102be4:	0f 84 06 01 00 00    	je     80102cf0 <namex+0x160>
  while(*path != '/' && *path != 0)
80102bea:	0f b6 03             	movzbl (%ebx),%eax
80102bed:	84 c0                	test   %al,%al
80102bef:	0f 84 10 01 00 00    	je     80102d05 <namex+0x175>
80102bf5:	89 df                	mov    %ebx,%edi
80102bf7:	3c 2f                	cmp    $0x2f,%al
80102bf9:	0f 84 06 01 00 00    	je     80102d05 <namex+0x175>
80102bff:	90                   	nop
80102c00:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80102c04:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80102c07:	3c 2f                	cmp    $0x2f,%al
80102c09:	74 04                	je     80102c0f <namex+0x7f>
80102c0b:	84 c0                	test   %al,%al
80102c0d:	75 f1                	jne    80102c00 <namex+0x70>
  len = path - s;
80102c0f:	89 f8                	mov    %edi,%eax
80102c11:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80102c13:	83 f8 0d             	cmp    $0xd,%eax
80102c16:	0f 8e ac 00 00 00    	jle    80102cc8 <namex+0x138>
    memmove(name, s, DIRSIZ);
80102c1c:	83 ec 04             	sub    $0x4,%esp
80102c1f:	6a 0e                	push   $0xe
80102c21:	53                   	push   %ebx
80102c22:	89 fb                	mov    %edi,%ebx
80102c24:	ff 75 e4             	push   -0x1c(%ebp)
80102c27:	e8 24 29 00 00       	call   80105550 <memmove>
80102c2c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80102c2f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80102c32:	75 0c                	jne    80102c40 <namex+0xb0>
80102c34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102c38:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80102c3b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80102c3e:	74 f8                	je     80102c38 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80102c40:	83 ec 0c             	sub    $0xc,%esp
80102c43:	56                   	push   %esi
80102c44:	e8 47 f9 ff ff       	call   80102590 <ilock>
    if(ip->type != T_DIR){
80102c49:	83 c4 10             	add    $0x10,%esp
80102c4c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102c51:	0f 85 b7 00 00 00    	jne    80102d0e <namex+0x17e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80102c57:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102c5a:	85 c0                	test   %eax,%eax
80102c5c:	74 09                	je     80102c67 <namex+0xd7>
80102c5e:	80 3b 00             	cmpb   $0x0,(%ebx)
80102c61:	0f 84 f7 00 00 00    	je     80102d5e <namex+0x1ce>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102c67:	83 ec 04             	sub    $0x4,%esp
80102c6a:	6a 00                	push   $0x0
80102c6c:	ff 75 e4             	push   -0x1c(%ebp)
80102c6f:	56                   	push   %esi
80102c70:	e8 6b fe ff ff       	call   80102ae0 <dirlookup>
80102c75:	83 c4 10             	add    $0x10,%esp
80102c78:	89 c7                	mov    %eax,%edi
80102c7a:	85 c0                	test   %eax,%eax
80102c7c:	0f 84 8c 00 00 00    	je     80102d0e <namex+0x17e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102c82:	83 ec 0c             	sub    $0xc,%esp
80102c85:	8d 4e 0c             	lea    0xc(%esi),%ecx
80102c88:	51                   	push   %ecx
80102c89:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80102c8c:	e8 ef 24 00 00       	call   80105180 <holdingsleep>
80102c91:	83 c4 10             	add    $0x10,%esp
80102c94:	85 c0                	test   %eax,%eax
80102c96:	0f 84 02 01 00 00    	je     80102d9e <namex+0x20e>
80102c9c:	8b 56 08             	mov    0x8(%esi),%edx
80102c9f:	85 d2                	test   %edx,%edx
80102ca1:	0f 8e f7 00 00 00    	jle    80102d9e <namex+0x20e>
  releasesleep(&ip->lock);
80102ca7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80102caa:	83 ec 0c             	sub    $0xc,%esp
80102cad:	51                   	push   %ecx
80102cae:	e8 8d 24 00 00       	call   80105140 <releasesleep>
  iput(ip);
80102cb3:	89 34 24             	mov    %esi,(%esp)
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80102cb6:	89 fe                	mov    %edi,%esi
  iput(ip);
80102cb8:	e8 03 fa ff ff       	call   801026c0 <iput>
80102cbd:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80102cc0:	e9 16 ff ff ff       	jmp    80102bdb <namex+0x4b>
80102cc5:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80102cc8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102ccb:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    memmove(name, s, len);
80102cce:	83 ec 04             	sub    $0x4,%esp
80102cd1:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80102cd4:	50                   	push   %eax
80102cd5:	53                   	push   %ebx
    name[len] = 0;
80102cd6:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80102cd8:	ff 75 e4             	push   -0x1c(%ebp)
80102cdb:	e8 70 28 00 00       	call   80105550 <memmove>
    name[len] = 0;
80102ce0:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80102ce3:	83 c4 10             	add    $0x10,%esp
80102ce6:	c6 01 00             	movb   $0x0,(%ecx)
80102ce9:	e9 41 ff ff ff       	jmp    80102c2f <namex+0x9f>
80102cee:	66 90                	xchg   %ax,%ax
  }
  if(nameiparent){
80102cf0:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102cf3:	85 c0                	test   %eax,%eax
80102cf5:	0f 85 93 00 00 00    	jne    80102d8e <namex+0x1fe>
    iput(ip);
    return 0;
  }
  return ip;
}
80102cfb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102cfe:	89 f0                	mov    %esi,%eax
80102d00:	5b                   	pop    %ebx
80102d01:	5e                   	pop    %esi
80102d02:	5f                   	pop    %edi
80102d03:	5d                   	pop    %ebp
80102d04:	c3                   	ret
  while(*path != '/' && *path != 0)
80102d05:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102d08:	89 df                	mov    %ebx,%edi
80102d0a:	31 c0                	xor    %eax,%eax
80102d0c:	eb c0                	jmp    80102cce <namex+0x13e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102d0e:	83 ec 0c             	sub    $0xc,%esp
80102d11:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102d14:	53                   	push   %ebx
80102d15:	e8 66 24 00 00       	call   80105180 <holdingsleep>
80102d1a:	83 c4 10             	add    $0x10,%esp
80102d1d:	85 c0                	test   %eax,%eax
80102d1f:	74 7d                	je     80102d9e <namex+0x20e>
80102d21:	8b 4e 08             	mov    0x8(%esi),%ecx
80102d24:	85 c9                	test   %ecx,%ecx
80102d26:	7e 76                	jle    80102d9e <namex+0x20e>
  releasesleep(&ip->lock);
80102d28:	83 ec 0c             	sub    $0xc,%esp
80102d2b:	53                   	push   %ebx
80102d2c:	e8 0f 24 00 00       	call   80105140 <releasesleep>
  iput(ip);
80102d31:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102d34:	31 f6                	xor    %esi,%esi
  iput(ip);
80102d36:	e8 85 f9 ff ff       	call   801026c0 <iput>
      return 0;
80102d3b:	83 c4 10             	add    $0x10,%esp
}
80102d3e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d41:	89 f0                	mov    %esi,%eax
80102d43:	5b                   	pop    %ebx
80102d44:	5e                   	pop    %esi
80102d45:	5f                   	pop    %edi
80102d46:	5d                   	pop    %ebp
80102d47:	c3                   	ret
    ip = iget(ROOTDEV, ROOTINO);
80102d48:	ba 01 00 00 00       	mov    $0x1,%edx
80102d4d:	b8 01 00 00 00       	mov    $0x1,%eax
80102d52:	e8 89 f3 ff ff       	call   801020e0 <iget>
80102d57:	89 c6                	mov    %eax,%esi
80102d59:	e9 7d fe ff ff       	jmp    80102bdb <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102d5e:	83 ec 0c             	sub    $0xc,%esp
80102d61:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102d64:	53                   	push   %ebx
80102d65:	e8 16 24 00 00       	call   80105180 <holdingsleep>
80102d6a:	83 c4 10             	add    $0x10,%esp
80102d6d:	85 c0                	test   %eax,%eax
80102d6f:	74 2d                	je     80102d9e <namex+0x20e>
80102d71:	8b 7e 08             	mov    0x8(%esi),%edi
80102d74:	85 ff                	test   %edi,%edi
80102d76:	7e 26                	jle    80102d9e <namex+0x20e>
  releasesleep(&ip->lock);
80102d78:	83 ec 0c             	sub    $0xc,%esp
80102d7b:	53                   	push   %ebx
80102d7c:	e8 bf 23 00 00       	call   80105140 <releasesleep>
}
80102d81:	83 c4 10             	add    $0x10,%esp
}
80102d84:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d87:	89 f0                	mov    %esi,%eax
80102d89:	5b                   	pop    %ebx
80102d8a:	5e                   	pop    %esi
80102d8b:	5f                   	pop    %edi
80102d8c:	5d                   	pop    %ebp
80102d8d:	c3                   	ret
    iput(ip);
80102d8e:	83 ec 0c             	sub    $0xc,%esp
80102d91:	56                   	push   %esi
      return 0;
80102d92:	31 f6                	xor    %esi,%esi
    iput(ip);
80102d94:	e8 27 f9 ff ff       	call   801026c0 <iput>
    return 0;
80102d99:	83 c4 10             	add    $0x10,%esp
80102d9c:	eb a0                	jmp    80102d3e <namex+0x1ae>
    panic("iunlock");
80102d9e:	83 ec 0c             	sub    $0xc,%esp
80102da1:	68 6d 88 10 80       	push   $0x8010886d
80102da6:	e8 f5 d5 ff ff       	call   801003a0 <panic>
80102dab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102db0 <dirlink>:
{
80102db0:	55                   	push   %ebp
80102db1:	89 e5                	mov    %esp,%ebp
80102db3:	57                   	push   %edi
80102db4:	56                   	push   %esi
80102db5:	53                   	push   %ebx
80102db6:	83 ec 20             	sub    $0x20,%esp
80102db9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80102dbc:	6a 00                	push   $0x0
80102dbe:	ff 75 0c             	push   0xc(%ebp)
80102dc1:	53                   	push   %ebx
80102dc2:	e8 19 fd ff ff       	call   80102ae0 <dirlookup>
80102dc7:	83 c4 10             	add    $0x10,%esp
80102dca:	85 c0                	test   %eax,%eax
80102dcc:	75 67                	jne    80102e35 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102dce:	8b 7b 58             	mov    0x58(%ebx),%edi
80102dd1:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102dd4:	85 ff                	test   %edi,%edi
80102dd6:	74 29                	je     80102e01 <dirlink+0x51>
80102dd8:	31 ff                	xor    %edi,%edi
80102dda:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102ddd:	eb 09                	jmp    80102de8 <dirlink+0x38>
80102ddf:	90                   	nop
80102de0:	83 c7 10             	add    $0x10,%edi
80102de3:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102de6:	73 19                	jae    80102e01 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102de8:	6a 10                	push   $0x10
80102dea:	57                   	push   %edi
80102deb:	56                   	push   %esi
80102dec:	53                   	push   %ebx
80102ded:	e8 ae fa ff ff       	call   801028a0 <readi>
80102df2:	83 c4 10             	add    $0x10,%esp
80102df5:	83 f8 10             	cmp    $0x10,%eax
80102df8:	75 4e                	jne    80102e48 <dirlink+0x98>
    if(de.inum == 0)
80102dfa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102dff:	75 df                	jne    80102de0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102e01:	83 ec 04             	sub    $0x4,%esp
80102e04:	8d 45 da             	lea    -0x26(%ebp),%eax
80102e07:	6a 0e                	push   $0xe
80102e09:	ff 75 0c             	push   0xc(%ebp)
80102e0c:	50                   	push   %eax
80102e0d:	e8 fe 27 00 00       	call   80105610 <strncpy>
  de.inum = inum;
80102e12:	8b 45 10             	mov    0x10(%ebp),%eax
80102e15:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102e19:	6a 10                	push   $0x10
80102e1b:	57                   	push   %edi
80102e1c:	56                   	push   %esi
80102e1d:	53                   	push   %ebx
80102e1e:	e8 7d fb ff ff       	call   801029a0 <writei>
80102e23:	83 c4 20             	add    $0x20,%esp
80102e26:	83 f8 10             	cmp    $0x10,%eax
80102e29:	75 2a                	jne    80102e55 <dirlink+0xa5>
  return 0;
80102e2b:	31 c0                	xor    %eax,%eax
}
80102e2d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e30:	5b                   	pop    %ebx
80102e31:	5e                   	pop    %esi
80102e32:	5f                   	pop    %edi
80102e33:	5d                   	pop    %ebp
80102e34:	c3                   	ret
    iput(ip);
80102e35:	83 ec 0c             	sub    $0xc,%esp
80102e38:	50                   	push   %eax
80102e39:	e8 82 f8 ff ff       	call   801026c0 <iput>
    return -1;
80102e3e:	83 c4 10             	add    $0x10,%esp
80102e41:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102e46:	eb e5                	jmp    80102e2d <dirlink+0x7d>
      panic("dirlink read");
80102e48:	83 ec 0c             	sub    $0xc,%esp
80102e4b:	68 96 88 10 80       	push   $0x80108896
80102e50:	e8 4b d5 ff ff       	call   801003a0 <panic>
    panic("dirlink");
80102e55:	83 ec 0c             	sub    $0xc,%esp
80102e58:	68 f7 8a 10 80       	push   $0x80108af7
80102e5d:	e8 3e d5 ff ff       	call   801003a0 <panic>
80102e62:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e69:	00 
80102e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102e70 <namei>:

struct inode*
namei(char *path)
{
80102e70:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102e71:	31 d2                	xor    %edx,%edx
{
80102e73:	89 e5                	mov    %esp,%ebp
80102e75:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102e78:	8b 45 08             	mov    0x8(%ebp),%eax
80102e7b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102e7e:	e8 0d fd ff ff       	call   80102b90 <namex>
}
80102e83:	c9                   	leave
80102e84:	c3                   	ret
80102e85:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e8c:	00 
80102e8d:	8d 76 00             	lea    0x0(%esi),%esi

80102e90 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102e90:	55                   	push   %ebp
  return namex(path, 1, name);
80102e91:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102e96:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102e98:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102e9b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102e9e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80102e9f:	e9 ec fc ff ff       	jmp    80102b90 <namex>
80102ea4:	66 90                	xchg   %ax,%ax
80102ea6:	66 90                	xchg   %ax,%ax
80102ea8:	66 90                	xchg   %ax,%ax
80102eaa:	66 90                	xchg   %ax,%ax
80102eac:	66 90                	xchg   %ax,%ax
80102eae:	66 90                	xchg   %ax,%ax

80102eb0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102eb0:	55                   	push   %ebp
80102eb1:	89 e5                	mov    %esp,%ebp
80102eb3:	57                   	push   %edi
80102eb4:	56                   	push   %esi
80102eb5:	53                   	push   %ebx
80102eb6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102eb9:	85 c0                	test   %eax,%eax
80102ebb:	0f 84 b4 00 00 00    	je     80102f75 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102ec1:	8b 70 08             	mov    0x8(%eax),%esi
80102ec4:	89 c3                	mov    %eax,%ebx
80102ec6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
80102ecc:	0f 87 96 00 00 00    	ja     80102f68 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ed2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102ed7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102ede:	00 
80102edf:	90                   	nop
80102ee0:	89 ca                	mov    %ecx,%edx
80102ee2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102ee3:	83 e0 c0             	and    $0xffffffc0,%eax
80102ee6:	3c 40                	cmp    $0x40,%al
80102ee8:	75 f6                	jne    80102ee0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102eea:	31 ff                	xor    %edi,%edi
80102eec:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102ef1:	89 f8                	mov    %edi,%eax
80102ef3:	ee                   	out    %al,(%dx)
80102ef4:	b8 01 00 00 00       	mov    $0x1,%eax
80102ef9:	ba f2 01 00 00       	mov    $0x1f2,%edx
80102efe:	ee                   	out    %al,(%dx)
80102eff:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102f04:	89 f0                	mov    %esi,%eax
80102f06:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102f07:	89 f0                	mov    %esi,%eax
80102f09:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102f0e:	c1 f8 08             	sar    $0x8,%eax
80102f11:	ee                   	out    %al,(%dx)
80102f12:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102f17:	89 f8                	mov    %edi,%eax
80102f19:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102f1a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
80102f1e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102f23:	c1 e0 04             	shl    $0x4,%eax
80102f26:	83 e0 10             	and    $0x10,%eax
80102f29:	83 c8 e0             	or     $0xffffffe0,%eax
80102f2c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80102f2d:	f6 03 04             	testb  $0x4,(%ebx)
80102f30:	75 16                	jne    80102f48 <idestart+0x98>
80102f32:	b8 20 00 00 00       	mov    $0x20,%eax
80102f37:	89 ca                	mov    %ecx,%edx
80102f39:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102f3a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f3d:	5b                   	pop    %ebx
80102f3e:	5e                   	pop    %esi
80102f3f:	5f                   	pop    %edi
80102f40:	5d                   	pop    %ebp
80102f41:	c3                   	ret
80102f42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102f48:	b8 30 00 00 00       	mov    $0x30,%eax
80102f4d:	89 ca                	mov    %ecx,%edx
80102f4f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102f50:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102f55:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102f58:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102f5d:	fc                   	cld
80102f5e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102f60:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f63:	5b                   	pop    %ebx
80102f64:	5e                   	pop    %esi
80102f65:	5f                   	pop    %edi
80102f66:	5d                   	pop    %ebp
80102f67:	c3                   	ret
    panic("incorrect blockno");
80102f68:	83 ec 0c             	sub    $0xc,%esp
80102f6b:	68 ac 88 10 80       	push   $0x801088ac
80102f70:	e8 2b d4 ff ff       	call   801003a0 <panic>
    panic("idestart");
80102f75:	83 ec 0c             	sub    $0xc,%esp
80102f78:	68 a3 88 10 80       	push   $0x801088a3
80102f7d:	e8 1e d4 ff ff       	call   801003a0 <panic>
80102f82:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f89:	00 
80102f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102f90 <ideinit>:
{
80102f90:	55                   	push   %ebp
80102f91:	89 e5                	mov    %esp,%ebp
80102f93:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102f96:	68 be 88 10 80       	push   $0x801088be
80102f9b:	68 20 5a 11 80       	push   $0x80115a20
80102fa0:	e8 2b 22 00 00       	call   801051d0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102fa5:	58                   	pop    %eax
80102fa6:	a1 a4 5b 11 80       	mov    0x80115ba4,%eax
80102fab:	5a                   	pop    %edx
80102fac:	83 e8 01             	sub    $0x1,%eax
80102faf:	50                   	push   %eax
80102fb0:	6a 0e                	push   $0xe
80102fb2:	e8 99 02 00 00       	call   80103250 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102fb7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fba:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102fbf:	90                   	nop
80102fc0:	89 ca                	mov    %ecx,%edx
80102fc2:	ec                   	in     (%dx),%al
80102fc3:	83 e0 c0             	and    $0xffffffc0,%eax
80102fc6:	3c 40                	cmp    $0x40,%al
80102fc8:	75 f6                	jne    80102fc0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fca:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102fcf:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102fd4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fd5:	89 ca                	mov    %ecx,%edx
80102fd7:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102fd8:	84 c0                	test   %al,%al
80102fda:	75 1e                	jne    80102ffa <ideinit+0x6a>
80102fdc:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80102fe1:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102fe6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102fed:	00 
80102fee:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
80102ff0:	83 e9 01             	sub    $0x1,%ecx
80102ff3:	74 0f                	je     80103004 <ideinit+0x74>
80102ff5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102ff6:	84 c0                	test   %al,%al
80102ff8:	74 f6                	je     80102ff0 <ideinit+0x60>
      havedisk1 = 1;
80102ffa:	c7 05 00 5a 11 80 01 	movl   $0x1,0x80115a00
80103001:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103004:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80103009:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010300e:	ee                   	out    %al,(%dx)
}
8010300f:	c9                   	leave
80103010:	c3                   	ret
80103011:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103018:	00 
80103019:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103020 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80103020:	55                   	push   %ebp
80103021:	89 e5                	mov    %esp,%ebp
80103023:	57                   	push   %edi
80103024:	56                   	push   %esi
80103025:	53                   	push   %ebx
80103026:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80103029:	68 20 5a 11 80       	push   $0x80115a20
8010302e:	e8 8d 23 00 00       	call   801053c0 <acquire>

  if((b = idequeue) == 0){
80103033:	8b 1d 04 5a 11 80    	mov    0x80115a04,%ebx
80103039:	83 c4 10             	add    $0x10,%esp
8010303c:	85 db                	test   %ebx,%ebx
8010303e:	74 63                	je     801030a3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80103040:	8b 43 58             	mov    0x58(%ebx),%eax
80103043:	a3 04 5a 11 80       	mov    %eax,0x80115a04

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80103048:	8b 33                	mov    (%ebx),%esi
8010304a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80103050:	75 2f                	jne    80103081 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103052:	ba f7 01 00 00       	mov    $0x1f7,%edx
80103057:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010305e:	00 
8010305f:	90                   	nop
80103060:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80103061:	89 c1                	mov    %eax,%ecx
80103063:	83 e1 c0             	and    $0xffffffc0,%ecx
80103066:	80 f9 40             	cmp    $0x40,%cl
80103069:	75 f5                	jne    80103060 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010306b:	a8 21                	test   $0x21,%al
8010306d:	75 12                	jne    80103081 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010306f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80103072:	b9 80 00 00 00       	mov    $0x80,%ecx
80103077:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010307c:	fc                   	cld
8010307d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010307f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80103081:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80103084:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80103087:	83 ce 02             	or     $0x2,%esi
8010308a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010308c:	53                   	push   %ebx
8010308d:	e8 6e 1e 00 00       	call   80104f00 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80103092:	a1 04 5a 11 80       	mov    0x80115a04,%eax
80103097:	83 c4 10             	add    $0x10,%esp
8010309a:	85 c0                	test   %eax,%eax
8010309c:	74 05                	je     801030a3 <ideintr+0x83>
    idestart(idequeue);
8010309e:	e8 0d fe ff ff       	call   80102eb0 <idestart>
    release(&idelock);
801030a3:	83 ec 0c             	sub    $0xc,%esp
801030a6:	68 20 5a 11 80       	push   $0x80115a20
801030ab:	e8 b0 22 00 00       	call   80105360 <release>

  release(&idelock);
}
801030b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030b3:	5b                   	pop    %ebx
801030b4:	5e                   	pop    %esi
801030b5:	5f                   	pop    %edi
801030b6:	5d                   	pop    %ebp
801030b7:	c3                   	ret
801030b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801030bf:	00 

801030c0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801030c0:	55                   	push   %ebp
801030c1:	89 e5                	mov    %esp,%ebp
801030c3:	53                   	push   %ebx
801030c4:	83 ec 10             	sub    $0x10,%esp
801030c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801030ca:	8d 43 0c             	lea    0xc(%ebx),%eax
801030cd:	50                   	push   %eax
801030ce:	e8 ad 20 00 00       	call   80105180 <holdingsleep>
801030d3:	83 c4 10             	add    $0x10,%esp
801030d6:	85 c0                	test   %eax,%eax
801030d8:	0f 84 c3 00 00 00    	je     801031a1 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801030de:	8b 03                	mov    (%ebx),%eax
801030e0:	83 e0 06             	and    $0x6,%eax
801030e3:	83 f8 02             	cmp    $0x2,%eax
801030e6:	0f 84 a8 00 00 00    	je     80103194 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801030ec:	8b 53 04             	mov    0x4(%ebx),%edx
801030ef:	85 d2                	test   %edx,%edx
801030f1:	74 0d                	je     80103100 <iderw+0x40>
801030f3:	a1 00 5a 11 80       	mov    0x80115a00,%eax
801030f8:	85 c0                	test   %eax,%eax
801030fa:	0f 84 87 00 00 00    	je     80103187 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80103100:	83 ec 0c             	sub    $0xc,%esp
80103103:	68 20 5a 11 80       	push   $0x80115a20
80103108:	e8 b3 22 00 00       	call   801053c0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010310d:	a1 04 5a 11 80       	mov    0x80115a04,%eax
  b->qnext = 0;
80103112:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80103119:	83 c4 10             	add    $0x10,%esp
8010311c:	85 c0                	test   %eax,%eax
8010311e:	74 60                	je     80103180 <iderw+0xc0>
80103120:	89 c2                	mov    %eax,%edx
80103122:	8b 40 58             	mov    0x58(%eax),%eax
80103125:	85 c0                	test   %eax,%eax
80103127:	75 f7                	jne    80103120 <iderw+0x60>
80103129:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010312c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010312e:	39 1d 04 5a 11 80    	cmp    %ebx,0x80115a04
80103134:	74 3a                	je     80103170 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80103136:	8b 03                	mov    (%ebx),%eax
80103138:	83 e0 06             	and    $0x6,%eax
8010313b:	83 f8 02             	cmp    $0x2,%eax
8010313e:	74 1b                	je     8010315b <iderw+0x9b>
    sleep(b, &idelock);
80103140:	83 ec 08             	sub    $0x8,%esp
80103143:	68 20 5a 11 80       	push   $0x80115a20
80103148:	53                   	push   %ebx
80103149:	e8 f2 1c 00 00       	call   80104e40 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010314e:	8b 03                	mov    (%ebx),%eax
80103150:	83 c4 10             	add    $0x10,%esp
80103153:	83 e0 06             	and    $0x6,%eax
80103156:	83 f8 02             	cmp    $0x2,%eax
80103159:	75 e5                	jne    80103140 <iderw+0x80>
  }


  release(&idelock);
8010315b:	c7 45 08 20 5a 11 80 	movl   $0x80115a20,0x8(%ebp)
}
80103162:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103165:	c9                   	leave
  release(&idelock);
80103166:	e9 f5 21 00 00       	jmp    80105360 <release>
8010316b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    idestart(b);
80103170:	89 d8                	mov    %ebx,%eax
80103172:	e8 39 fd ff ff       	call   80102eb0 <idestart>
80103177:	eb bd                	jmp    80103136 <iderw+0x76>
80103179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80103180:	ba 04 5a 11 80       	mov    $0x80115a04,%edx
80103185:	eb a5                	jmp    8010312c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80103187:	83 ec 0c             	sub    $0xc,%esp
8010318a:	68 ed 88 10 80       	push   $0x801088ed
8010318f:	e8 0c d2 ff ff       	call   801003a0 <panic>
    panic("iderw: nothing to do");
80103194:	83 ec 0c             	sub    $0xc,%esp
80103197:	68 d8 88 10 80       	push   $0x801088d8
8010319c:	e8 ff d1 ff ff       	call   801003a0 <panic>
    panic("iderw: buf not locked");
801031a1:	83 ec 0c             	sub    $0xc,%esp
801031a4:	68 c2 88 10 80       	push   $0x801088c2
801031a9:	e8 f2 d1 ff ff       	call   801003a0 <panic>
801031ae:	66 90                	xchg   %ax,%ax

801031b0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801031b0:	55                   	push   %ebp
801031b1:	89 e5                	mov    %esp,%ebp
801031b3:	56                   	push   %esi
801031b4:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801031b5:	c7 05 54 5a 11 80 00 	movl   $0xfec00000,0x80115a54
801031bc:	00 c0 fe 
  ioapic->reg = reg;
801031bf:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801031c6:	00 00 00 
  return ioapic->data;
801031c9:	8b 15 54 5a 11 80    	mov    0x80115a54,%edx
801031cf:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
801031d2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801031d8:	8b 1d 54 5a 11 80    	mov    0x80115a54,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801031de:	0f b6 15 a0 5b 11 80 	movzbl 0x80115ba0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801031e5:	c1 ee 10             	shr    $0x10,%esi
801031e8:	89 f0                	mov    %esi,%eax
801031ea:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
801031ed:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
801031f0:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801031f3:	39 c2                	cmp    %eax,%edx
801031f5:	74 16                	je     8010320d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801031f7:	83 ec 0c             	sub    $0xc,%esp
801031fa:	68 64 8d 10 80       	push   $0x80108d64
801031ff:	e8 3c da ff ff       	call   80100c40 <cprintf>
  ioapic->reg = reg;
80103204:	8b 1d 54 5a 11 80    	mov    0x80115a54,%ebx
8010320a:	83 c4 10             	add    $0x10,%esp
{
8010320d:	ba 10 00 00 00       	mov    $0x10,%edx
80103212:	31 c0                	xor    %eax,%eax
80103214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapic->reg = reg;
80103218:	89 13                	mov    %edx,(%ebx)
8010321a:	8d 48 20             	lea    0x20(%eax),%ecx
  ioapic->data = data;
8010321d:	8b 1d 54 5a 11 80    	mov    0x80115a54,%ebx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80103223:	83 c0 01             	add    $0x1,%eax
80103226:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  ioapic->data = data;
8010322c:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
8010322f:	8d 4a 01             	lea    0x1(%edx),%ecx
  for(i = 0; i <= maxintr; i++){
80103232:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
80103235:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
80103237:	8b 1d 54 5a 11 80    	mov    0x80115a54,%ebx
8010323d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
80103244:	39 c6                	cmp    %eax,%esi
80103246:	7d d0                	jge    80103218 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80103248:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010324b:	5b                   	pop    %ebx
8010324c:	5e                   	pop    %esi
8010324d:	5d                   	pop    %ebp
8010324e:	c3                   	ret
8010324f:	90                   	nop

80103250 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80103250:	55                   	push   %ebp
  ioapic->reg = reg;
80103251:	8b 0d 54 5a 11 80    	mov    0x80115a54,%ecx
{
80103257:	89 e5                	mov    %esp,%ebp
80103259:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010325c:	8d 50 20             	lea    0x20(%eax),%edx
8010325f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80103263:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80103265:	8b 0d 54 5a 11 80    	mov    0x80115a54,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010326b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010326e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80103271:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80103274:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80103276:	a1 54 5a 11 80       	mov    0x80115a54,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010327b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010327e:	89 50 10             	mov    %edx,0x10(%eax)
}
80103281:	5d                   	pop    %ebp
80103282:	c3                   	ret
80103283:	66 90                	xchg   %ax,%ax
80103285:	66 90                	xchg   %ax,%ax
80103287:	66 90                	xchg   %ax,%ax
80103289:	66 90                	xchg   %ax,%ax
8010328b:	66 90                	xchg   %ax,%ax
8010328d:	66 90                	xchg   %ax,%ax
8010328f:	90                   	nop

80103290 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80103290:	55                   	push   %ebp
80103291:	89 e5                	mov    %esp,%ebp
80103293:	53                   	push   %ebx
80103294:	83 ec 04             	sub    $0x4,%esp
80103297:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010329a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801032a0:	75 76                	jne    80103318 <kfree+0x88>
801032a2:	81 fb f0 99 11 80    	cmp    $0x801199f0,%ebx
801032a8:	72 6e                	jb     80103318 <kfree+0x88>
801032aa:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801032b0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801032b5:	77 61                	ja     80103318 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801032b7:	83 ec 04             	sub    $0x4,%esp
801032ba:	68 00 10 00 00       	push   $0x1000
801032bf:	6a 01                	push   $0x1
801032c1:	53                   	push   %ebx
801032c2:	e8 f9 21 00 00       	call   801054c0 <memset>

  if(kmem.use_lock)
801032c7:	8b 15 94 5a 11 80    	mov    0x80115a94,%edx
801032cd:	83 c4 10             	add    $0x10,%esp
801032d0:	85 d2                	test   %edx,%edx
801032d2:	75 1c                	jne    801032f0 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801032d4:	a1 98 5a 11 80       	mov    0x80115a98,%eax
801032d9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801032db:	a1 94 5a 11 80       	mov    0x80115a94,%eax
  kmem.freelist = r;
801032e0:	89 1d 98 5a 11 80    	mov    %ebx,0x80115a98
  if(kmem.use_lock)
801032e6:	85 c0                	test   %eax,%eax
801032e8:	75 1e                	jne    80103308 <kfree+0x78>
    release(&kmem.lock);
}
801032ea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801032ed:	c9                   	leave
801032ee:	c3                   	ret
801032ef:	90                   	nop
    acquire(&kmem.lock);
801032f0:	83 ec 0c             	sub    $0xc,%esp
801032f3:	68 60 5a 11 80       	push   $0x80115a60
801032f8:	e8 c3 20 00 00       	call   801053c0 <acquire>
801032fd:	83 c4 10             	add    $0x10,%esp
80103300:	eb d2                	jmp    801032d4 <kfree+0x44>
80103302:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80103308:	c7 45 08 60 5a 11 80 	movl   $0x80115a60,0x8(%ebp)
}
8010330f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103312:	c9                   	leave
    release(&kmem.lock);
80103313:	e9 48 20 00 00       	jmp    80105360 <release>
    panic("kfree");
80103318:	83 ec 0c             	sub    $0xc,%esp
8010331b:	68 0b 89 10 80       	push   $0x8010890b
80103320:	e8 7b d0 ff ff       	call   801003a0 <panic>
80103325:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010332c:	00 
8010332d:	8d 76 00             	lea    0x0(%esi),%esi

80103330 <freerange>:
{
80103330:	55                   	push   %ebp
80103331:	89 e5                	mov    %esp,%ebp
80103333:	56                   	push   %esi
80103334:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80103335:	8b 45 08             	mov    0x8(%ebp),%eax
{
80103338:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010333b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103341:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103347:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010334d:	39 de                	cmp    %ebx,%esi
8010334f:	72 23                	jb     80103374 <freerange+0x44>
80103351:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80103358:	83 ec 0c             	sub    $0xc,%esp
8010335b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103361:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80103367:	50                   	push   %eax
80103368:	e8 23 ff ff ff       	call   80103290 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010336d:	83 c4 10             	add    $0x10,%esp
80103370:	39 de                	cmp    %ebx,%esi
80103372:	73 e4                	jae    80103358 <freerange+0x28>
}
80103374:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103377:	5b                   	pop    %ebx
80103378:	5e                   	pop    %esi
80103379:	5d                   	pop    %ebp
8010337a:	c3                   	ret
8010337b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103380 <kinit2>:
{
80103380:	55                   	push   %ebp
80103381:	89 e5                	mov    %esp,%ebp
80103383:	56                   	push   %esi
80103384:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80103385:	8b 45 08             	mov    0x8(%ebp),%eax
{
80103388:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010338b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103391:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103397:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010339d:	39 de                	cmp    %ebx,%esi
8010339f:	72 23                	jb     801033c4 <kinit2+0x44>
801033a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801033a8:	83 ec 0c             	sub    $0xc,%esp
801033ab:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801033b1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801033b7:	50                   	push   %eax
801033b8:	e8 d3 fe ff ff       	call   80103290 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801033bd:	83 c4 10             	add    $0x10,%esp
801033c0:	39 de                	cmp    %ebx,%esi
801033c2:	73 e4                	jae    801033a8 <kinit2+0x28>
  kmem.use_lock = 1;
801033c4:	c7 05 94 5a 11 80 01 	movl   $0x1,0x80115a94
801033cb:	00 00 00 
}
801033ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033d1:	5b                   	pop    %ebx
801033d2:	5e                   	pop    %esi
801033d3:	5d                   	pop    %ebp
801033d4:	c3                   	ret
801033d5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801033dc:	00 
801033dd:	8d 76 00             	lea    0x0(%esi),%esi

801033e0 <kinit1>:
{
801033e0:	55                   	push   %ebp
801033e1:	89 e5                	mov    %esp,%ebp
801033e3:	56                   	push   %esi
801033e4:	53                   	push   %ebx
801033e5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801033e8:	83 ec 08             	sub    $0x8,%esp
801033eb:	68 11 89 10 80       	push   $0x80108911
801033f0:	68 60 5a 11 80       	push   $0x80115a60
801033f5:	e8 d6 1d 00 00       	call   801051d0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801033fa:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801033fd:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80103400:	c7 05 94 5a 11 80 00 	movl   $0x0,0x80115a94
80103407:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010340a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103410:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103416:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010341c:	39 de                	cmp    %ebx,%esi
8010341e:	72 1c                	jb     8010343c <kinit1+0x5c>
    kfree(p);
80103420:	83 ec 0c             	sub    $0xc,%esp
80103423:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103429:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010342f:	50                   	push   %eax
80103430:	e8 5b fe ff ff       	call   80103290 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103435:	83 c4 10             	add    $0x10,%esp
80103438:	39 de                	cmp    %ebx,%esi
8010343a:	73 e4                	jae    80103420 <kinit1+0x40>
}
8010343c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010343f:	5b                   	pop    %ebx
80103440:	5e                   	pop    %esi
80103441:	5d                   	pop    %ebp
80103442:	c3                   	ret
80103443:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010344a:	00 
8010344b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103450 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80103450:	55                   	push   %ebp
80103451:	89 e5                	mov    %esp,%ebp
80103453:	53                   	push   %ebx
80103454:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80103457:	a1 94 5a 11 80       	mov    0x80115a94,%eax
8010345c:	85 c0                	test   %eax,%eax
8010345e:	75 20                	jne    80103480 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
80103460:	8b 1d 98 5a 11 80    	mov    0x80115a98,%ebx
  if(r)
80103466:	85 db                	test   %ebx,%ebx
80103468:	74 07                	je     80103471 <kalloc+0x21>
    kmem.freelist = r->next;
8010346a:	8b 03                	mov    (%ebx),%eax
8010346c:	a3 98 5a 11 80       	mov    %eax,0x80115a98
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80103471:	89 d8                	mov    %ebx,%eax
80103473:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103476:	c9                   	leave
80103477:	c3                   	ret
80103478:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010347f:	00 
    acquire(&kmem.lock);
80103480:	83 ec 0c             	sub    $0xc,%esp
80103483:	68 60 5a 11 80       	push   $0x80115a60
80103488:	e8 33 1f 00 00       	call   801053c0 <acquire>
  r = kmem.freelist;
8010348d:	8b 1d 98 5a 11 80    	mov    0x80115a98,%ebx
  if(kmem.use_lock)
80103493:	a1 94 5a 11 80       	mov    0x80115a94,%eax
  if(r)
80103498:	83 c4 10             	add    $0x10,%esp
8010349b:	85 db                	test   %ebx,%ebx
8010349d:	74 08                	je     801034a7 <kalloc+0x57>
    kmem.freelist = r->next;
8010349f:	8b 13                	mov    (%ebx),%edx
801034a1:	89 15 98 5a 11 80    	mov    %edx,0x80115a98
  if(kmem.use_lock)
801034a7:	85 c0                	test   %eax,%eax
801034a9:	74 c6                	je     80103471 <kalloc+0x21>
    release(&kmem.lock);
801034ab:	83 ec 0c             	sub    $0xc,%esp
801034ae:	68 60 5a 11 80       	push   $0x80115a60
801034b3:	e8 a8 1e 00 00       	call   80105360 <release>
}
801034b8:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
801034ba:	83 c4 10             	add    $0x10,%esp
}
801034bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801034c0:	c9                   	leave
801034c1:	c3                   	ret
801034c2:	66 90                	xchg   %ax,%ax
801034c4:	66 90                	xchg   %ax,%ax
801034c6:	66 90                	xchg   %ax,%ax
801034c8:	66 90                	xchg   %ax,%ax
801034ca:	66 90                	xchg   %ax,%ax
801034cc:	66 90                	xchg   %ax,%ax
801034ce:	66 90                	xchg   %ax,%ax

801034d0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801034d0:	ba 64 00 00 00       	mov    $0x64,%edx
801034d5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if ((st & KBS_DIB) == 0)
801034d6:	a8 01                	test   $0x1,%al
801034d8:	0f 84 d2 00 00 00    	je     801035b0 <kbdgetc+0xe0>
int kbdgetc(void) {
801034de:	55                   	push   %ebp
801034df:	ba 60 00 00 00       	mov    $0x60,%edx
801034e4:	89 e5                	mov    %esp,%ebp
801034e6:	53                   	push   %ebx
801034e7:	ec                   	in     (%dx),%al
    return -1;

  data = inb(KBDATAP);

  if (data == 0xE0) {   // Special key prefix
    shift |= E0ESC;
801034e8:	8b 1d 9c 5a 11 80    	mov    0x80115a9c,%ebx
  data = inb(KBDATAP);
801034ee:	0f b6 c8             	movzbl %al,%ecx
  if (data == 0xE0) {   // Special key prefix
801034f1:	3c e0                	cmp    $0xe0,%al
801034f3:	74 5b                	je     80103550 <kbdgetc+0x80>
    return 0;
  } else if (data & 0x80) { 
    data = (shift & E0ESC) ? data : (data & 0x7F);
801034f5:	89 da                	mov    %ebx,%edx
801034f7:	83 e2 40             	and    $0x40,%edx
  } else if (data & 0x80) { 
801034fa:	84 c0                	test   %al,%al
801034fc:	78 62                	js     80103560 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if (shift & E0ESC) {
801034fe:	85 d2                	test   %edx,%edx
80103500:	74 0c                	je     8010350e <kbdgetc+0x3e>
    switch (data) {
80103502:	83 f9 4b             	cmp    $0x4b,%ecx
80103505:	0f 84 95 00 00 00    	je     801035a0 <kbdgetc+0xd0>
      case 0x4B:
        return KEY_LEFT;
    }
    shift &= ~E0ESC;
8010350b:	83 e3 bf             	and    $0xffffffbf,%ebx
  }

  shift |= shiftcode[data];
8010350e:	0f b6 91 c0 8f 10 80 	movzbl -0x7fef7040(%ecx),%edx
  shift ^= togglecode[data];
80103515:	0f b6 81 c0 8e 10 80 	movzbl -0x7fef7140(%ecx),%eax
  shift |= shiftcode[data];
8010351c:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
8010351e:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
80103520:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
80103522:	89 15 9c 5a 11 80    	mov    %edx,0x80115a9c
  c = charcode[shift & (CTL | SHIFT)][data];
80103528:	83 e0 03             	and    $0x3,%eax

  if (shift & CAPSLOCK) {
8010352b:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010352e:	8b 04 85 a0 8e 10 80 	mov    -0x7fef7160(,%eax,4),%eax
80103535:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if (shift & CAPSLOCK) {
80103539:	74 0b                	je     80103546 <kbdgetc+0x76>
    if ('a' <= c && c <= 'z')
8010353b:	8d 50 9f             	lea    -0x61(%eax),%edx
8010353e:	83 fa 19             	cmp    $0x19,%edx
80103541:	77 45                	ja     80103588 <kbdgetc+0xb8>
      c += 'A' - 'a';
80103543:	83 e8 20             	sub    $0x20,%eax
    else if ('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  
  return c;
}
80103546:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103549:	c9                   	leave
8010354a:	c3                   	ret
8010354b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
80103550:	83 cb 40             	or     $0x40,%ebx
    return 0;
80103553:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80103555:	89 1d 9c 5a 11 80    	mov    %ebx,0x80115a9c
}
8010355b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010355e:	c9                   	leave
8010355f:	c3                   	ret
    data = (shift & E0ESC) ? data : (data & 0x7F);
80103560:	83 e0 7f             	and    $0x7f,%eax
80103563:	85 d2                	test   %edx,%edx
80103565:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80103568:	0f b6 81 c0 8f 10 80 	movzbl -0x7fef7040(%ecx),%eax
8010356f:	83 c8 40             	or     $0x40,%eax
80103572:	0f b6 c0             	movzbl %al,%eax
80103575:	f7 d0                	not    %eax
80103577:	21 d8                	and    %ebx,%eax
80103579:	a3 9c 5a 11 80       	mov    %eax,0x80115a9c
    return 0;
8010357e:	31 c0                	xor    %eax,%eax
80103580:	eb d9                	jmp    8010355b <kbdgetc+0x8b>
80103582:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if ('A' <= c && c <= 'Z')
80103588:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010358b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010358e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103591:	c9                   	leave
      c += 'a' - 'A';
80103592:	83 f9 1a             	cmp    $0x1a,%ecx
80103595:	0f 42 c2             	cmovb  %edx,%eax
}
80103598:	c3                   	ret
80103599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return KEY_LEFT;
801035a0:	b8 4b e0 00 00       	mov    $0xe04b,%eax
801035a5:	eb 9f                	jmp    80103546 <kbdgetc+0x76>
801035a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801035ae:	00 
801035af:	90                   	nop
    return -1;
801035b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801035b5:	c3                   	ret
801035b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801035bd:	00 
801035be:	66 90                	xchg   %ax,%ax

801035c0 <kbdintr>:

void kbdintr(void) {
801035c0:	55                   	push   %ebp
801035c1:	89 e5                	mov    %esp,%ebp
801035c3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801035c6:	68 d0 34 10 80       	push   $0x801034d0
801035cb:	e8 a0 d9 ff ff       	call   80100f70 <consoleintr>
}
801035d0:	83 c4 10             	add    $0x10,%esp
801035d3:	c9                   	leave
801035d4:	c3                   	ret
801035d5:	66 90                	xchg   %ax,%ax
801035d7:	66 90                	xchg   %ax,%ax
801035d9:	66 90                	xchg   %ax,%ax
801035db:	66 90                	xchg   %ax,%ax
801035dd:	66 90                	xchg   %ax,%ax
801035df:	90                   	nop

801035e0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801035e0:	a1 a0 5a 11 80       	mov    0x80115aa0,%eax
801035e5:	85 c0                	test   %eax,%eax
801035e7:	0f 84 c3 00 00 00    	je     801036b0 <lapicinit+0xd0>
  lapic[index] = value;
801035ed:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801035f4:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801035f7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801035fa:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80103601:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103604:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103607:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010360e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80103611:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103614:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010361b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010361e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103621:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80103628:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010362b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010362e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80103635:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80103638:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010363b:	8b 50 30             	mov    0x30(%eax),%edx
8010363e:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
80103644:	75 72                	jne    801036b8 <lapicinit+0xd8>
  lapic[index] = value;
80103646:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
8010364d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103650:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103653:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010365a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010365d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103660:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80103667:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010366a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010366d:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103674:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103677:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010367a:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80103681:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103684:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103687:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
8010368e:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80103691:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80103694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103698:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010369e:	80 e6 10             	and    $0x10,%dh
801036a1:	75 f5                	jne    80103698 <lapicinit+0xb8>
  lapic[index] = value;
801036a3:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801036aa:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801036ad:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801036b0:	c3                   	ret
801036b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
801036b8:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801036bf:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801036c2:	8b 50 20             	mov    0x20(%eax),%edx
}
801036c5:	e9 7c ff ff ff       	jmp    80103646 <lapicinit+0x66>
801036ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801036d0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801036d0:	a1 a0 5a 11 80       	mov    0x80115aa0,%eax
801036d5:	85 c0                	test   %eax,%eax
801036d7:	74 07                	je     801036e0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
801036d9:	8b 40 20             	mov    0x20(%eax),%eax
801036dc:	c1 e8 18             	shr    $0x18,%eax
801036df:	c3                   	ret
    return 0;
801036e0:	31 c0                	xor    %eax,%eax
}
801036e2:	c3                   	ret
801036e3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801036ea:	00 
801036eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801036f0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801036f0:	a1 a0 5a 11 80       	mov    0x80115aa0,%eax
801036f5:	85 c0                	test   %eax,%eax
801036f7:	74 0d                	je     80103706 <lapiceoi+0x16>
  lapic[index] = value;
801036f9:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103700:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103703:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80103706:	c3                   	ret
80103707:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010370e:	00 
8010370f:	90                   	nop

80103710 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80103710:	c3                   	ret
80103711:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103718:	00 
80103719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103720 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80103720:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103721:	b8 0f 00 00 00       	mov    $0xf,%eax
80103726:	ba 70 00 00 00       	mov    $0x70,%edx
8010372b:	89 e5                	mov    %esp,%ebp
8010372d:	53                   	push   %ebx
8010372e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103731:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103734:	ee                   	out    %al,(%dx)
80103735:	b8 0a 00 00 00       	mov    $0xa,%eax
8010373a:	ba 71 00 00 00       	mov    $0x71,%edx
8010373f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80103740:	31 c0                	xor    %eax,%eax
  lapic[index] = value;
80103742:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80103745:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010374b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010374d:	c1 e9 0c             	shr    $0xc,%ecx
  lapic[index] = value;
80103750:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80103752:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80103755:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80103758:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010375e:	a1 a0 5a 11 80       	mov    0x80115aa0,%eax
80103763:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103769:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010376c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80103773:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103776:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103779:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80103780:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103783:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103786:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010378c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010378f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103795:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103798:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010379e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801037a1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801037a7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
801037aa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037ad:	c9                   	leave
801037ae:	c3                   	ret
801037af:	90                   	nop

801037b0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801037b0:	55                   	push   %ebp
801037b1:	b8 0b 00 00 00       	mov    $0xb,%eax
801037b6:	ba 70 00 00 00       	mov    $0x70,%edx
801037bb:	89 e5                	mov    %esp,%ebp
801037bd:	57                   	push   %edi
801037be:	56                   	push   %esi
801037bf:	53                   	push   %ebx
801037c0:	83 ec 4c             	sub    $0x4c,%esp
801037c3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801037c4:	ba 71 00 00 00       	mov    $0x71,%edx
801037c9:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
801037ca:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801037cd:	bf 70 00 00 00       	mov    $0x70,%edi
801037d2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801037d5:	8d 76 00             	lea    0x0(%esi),%esi
801037d8:	31 c0                	xor    %eax,%eax
801037da:	89 fa                	mov    %edi,%edx
801037dc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801037dd:	b9 71 00 00 00       	mov    $0x71,%ecx
801037e2:	89 ca                	mov    %ecx,%edx
801037e4:	ec                   	in     (%dx),%al
801037e5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801037e8:	89 fa                	mov    %edi,%edx
801037ea:	b8 02 00 00 00       	mov    $0x2,%eax
801037ef:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801037f0:	89 ca                	mov    %ecx,%edx
801037f2:	ec                   	in     (%dx),%al
801037f3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801037f6:	89 fa                	mov    %edi,%edx
801037f8:	b8 04 00 00 00       	mov    $0x4,%eax
801037fd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801037fe:	89 ca                	mov    %ecx,%edx
80103800:	ec                   	in     (%dx),%al
80103801:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103804:	89 fa                	mov    %edi,%edx
80103806:	b8 07 00 00 00       	mov    $0x7,%eax
8010380b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010380c:	89 ca                	mov    %ecx,%edx
8010380e:	ec                   	in     (%dx),%al
8010380f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103812:	89 fa                	mov    %edi,%edx
80103814:	b8 08 00 00 00       	mov    $0x8,%eax
80103819:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010381a:	89 ca                	mov    %ecx,%edx
8010381c:	ec                   	in     (%dx),%al
8010381d:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010381f:	89 fa                	mov    %edi,%edx
80103821:	b8 09 00 00 00       	mov    $0x9,%eax
80103826:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103827:	89 ca                	mov    %ecx,%edx
80103829:	ec                   	in     (%dx),%al
8010382a:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010382d:	89 fa                	mov    %edi,%edx
8010382f:	b8 0a 00 00 00       	mov    $0xa,%eax
80103834:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103835:	89 ca                	mov    %ecx,%edx
80103837:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80103838:	84 c0                	test   %al,%al
8010383a:	78 9c                	js     801037d8 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010383c:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80103840:	89 f2                	mov    %esi,%edx
80103842:	89 5d cc             	mov    %ebx,-0x34(%ebp)
80103845:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103848:	89 fa                	mov    %edi,%edx
8010384a:	89 45 b8             	mov    %eax,-0x48(%ebp)
8010384d:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80103851:	89 75 c8             	mov    %esi,-0x38(%ebp)
80103854:	89 45 bc             	mov    %eax,-0x44(%ebp)
80103857:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010385b:	89 45 c0             	mov    %eax,-0x40(%ebp)
8010385e:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80103862:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80103865:	31 c0                	xor    %eax,%eax
80103867:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103868:	89 ca                	mov    %ecx,%edx
8010386a:	ec                   	in     (%dx),%al
8010386b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010386e:	89 fa                	mov    %edi,%edx
80103870:	89 45 d0             	mov    %eax,-0x30(%ebp)
80103873:	b8 02 00 00 00       	mov    $0x2,%eax
80103878:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103879:	89 ca                	mov    %ecx,%edx
8010387b:	ec                   	in     (%dx),%al
8010387c:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010387f:	89 fa                	mov    %edi,%edx
80103881:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80103884:	b8 04 00 00 00       	mov    $0x4,%eax
80103889:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010388a:	89 ca                	mov    %ecx,%edx
8010388c:	ec                   	in     (%dx),%al
8010388d:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103890:	89 fa                	mov    %edi,%edx
80103892:	89 45 d8             	mov    %eax,-0x28(%ebp)
80103895:	b8 07 00 00 00       	mov    $0x7,%eax
8010389a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010389b:	89 ca                	mov    %ecx,%edx
8010389d:	ec                   	in     (%dx),%al
8010389e:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801038a1:	89 fa                	mov    %edi,%edx
801038a3:	89 45 dc             	mov    %eax,-0x24(%ebp)
801038a6:	b8 08 00 00 00       	mov    $0x8,%eax
801038ab:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801038ac:	89 ca                	mov    %ecx,%edx
801038ae:	ec                   	in     (%dx),%al
801038af:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801038b2:	89 fa                	mov    %edi,%edx
801038b4:	89 45 e0             	mov    %eax,-0x20(%ebp)
801038b7:	b8 09 00 00 00       	mov    $0x9,%eax
801038bc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801038bd:	89 ca                	mov    %ecx,%edx
801038bf:	ec                   	in     (%dx),%al
801038c0:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801038c3:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
801038c6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801038c9:	8d 45 d0             	lea    -0x30(%ebp),%eax
801038cc:	6a 18                	push   $0x18
801038ce:	50                   	push   %eax
801038cf:	8d 45 b8             	lea    -0x48(%ebp),%eax
801038d2:	50                   	push   %eax
801038d3:	e8 28 1c 00 00       	call   80105500 <memcmp>
801038d8:	83 c4 10             	add    $0x10,%esp
801038db:	85 c0                	test   %eax,%eax
801038dd:	0f 85 f5 fe ff ff    	jne    801037d8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
801038e3:	0f b6 75 b3          	movzbl -0x4d(%ebp),%esi
801038e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801038ea:	89 f0                	mov    %esi,%eax
801038ec:	84 c0                	test   %al,%al
801038ee:	75 78                	jne    80103968 <cmostime+0x1b8>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
801038f0:	8b 45 b8             	mov    -0x48(%ebp),%eax
801038f3:	89 c2                	mov    %eax,%edx
801038f5:	83 e0 0f             	and    $0xf,%eax
801038f8:	c1 ea 04             	shr    $0x4,%edx
801038fb:	8d 14 92             	lea    (%edx,%edx,4),%edx
801038fe:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103901:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80103904:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103907:	89 c2                	mov    %eax,%edx
80103909:	83 e0 0f             	and    $0xf,%eax
8010390c:	c1 ea 04             	shr    $0x4,%edx
8010390f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103912:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103915:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80103918:	8b 45 c0             	mov    -0x40(%ebp),%eax
8010391b:	89 c2                	mov    %eax,%edx
8010391d:	83 e0 0f             	and    $0xf,%eax
80103920:	c1 ea 04             	shr    $0x4,%edx
80103923:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103926:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103929:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
8010392c:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010392f:	89 c2                	mov    %eax,%edx
80103931:	83 e0 0f             	and    $0xf,%eax
80103934:	c1 ea 04             	shr    $0x4,%edx
80103937:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010393a:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010393d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80103940:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103943:	89 c2                	mov    %eax,%edx
80103945:	83 e0 0f             	and    $0xf,%eax
80103948:	c1 ea 04             	shr    $0x4,%edx
8010394b:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010394e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103951:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80103954:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103957:	89 c2                	mov    %eax,%edx
80103959:	83 e0 0f             	and    $0xf,%eax
8010395c:	c1 ea 04             	shr    $0x4,%edx
8010395f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103962:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103965:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80103968:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010396b:	89 03                	mov    %eax,(%ebx)
8010396d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103970:	89 43 04             	mov    %eax,0x4(%ebx)
80103973:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103976:	89 43 08             	mov    %eax,0x8(%ebx)
80103979:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010397c:	89 43 0c             	mov    %eax,0xc(%ebx)
8010397f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103982:	89 43 10             	mov    %eax,0x10(%ebx)
80103985:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103988:	89 43 14             	mov    %eax,0x14(%ebx)
  r->year += 2000;
8010398b:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
80103992:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103995:	5b                   	pop    %ebx
80103996:	5e                   	pop    %esi
80103997:	5f                   	pop    %edi
80103998:	5d                   	pop    %ebp
80103999:	c3                   	ret
8010399a:	66 90                	xchg   %ax,%ax
8010399c:	66 90                	xchg   %ax,%ax
8010399e:	66 90                	xchg   %ax,%ax

801039a0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801039a0:	8b 0d 08 5b 11 80    	mov    0x80115b08,%ecx
801039a6:	85 c9                	test   %ecx,%ecx
801039a8:	0f 8e 8a 00 00 00    	jle    80103a38 <install_trans+0x98>
{
801039ae:	55                   	push   %ebp
801039af:	89 e5                	mov    %esp,%ebp
801039b1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
801039b2:	31 ff                	xor    %edi,%edi
{
801039b4:	56                   	push   %esi
801039b5:	53                   	push   %ebx
801039b6:	83 ec 0c             	sub    $0xc,%esp
801039b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801039c0:	a1 f4 5a 11 80       	mov    0x80115af4,%eax
801039c5:	83 ec 08             	sub    $0x8,%esp
801039c8:	01 f8                	add    %edi,%eax
801039ca:	83 c0 01             	add    $0x1,%eax
801039cd:	50                   	push   %eax
801039ce:	ff 35 04 5b 11 80    	push   0x80115b04
801039d4:	e8 f7 c6 ff ff       	call   801000d0 <bread>
801039d9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801039db:	58                   	pop    %eax
801039dc:	5a                   	pop    %edx
801039dd:	ff 34 bd 0c 5b 11 80 	push   -0x7feea4f4(,%edi,4)
801039e4:	ff 35 04 5b 11 80    	push   0x80115b04
  for (tail = 0; tail < log.lh.n; tail++) {
801039ea:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801039ed:	e8 de c6 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801039f2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801039f5:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801039f7:	8d 46 5c             	lea    0x5c(%esi),%eax
801039fa:	68 00 02 00 00       	push   $0x200
801039ff:	50                   	push   %eax
80103a00:	8d 43 5c             	lea    0x5c(%ebx),%eax
80103a03:	50                   	push   %eax
80103a04:	e8 47 1b 00 00       	call   80105550 <memmove>
    bwrite(dbuf);  // write dst to disk
80103a09:	89 1c 24             	mov    %ebx,(%esp)
80103a0c:	e8 9f c7 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80103a11:	89 34 24             	mov    %esi,(%esp)
80103a14:	e8 d7 c7 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80103a19:	89 1c 24             	mov    %ebx,(%esp)
80103a1c:	e8 cf c7 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103a21:	83 c4 10             	add    $0x10,%esp
80103a24:	39 3d 08 5b 11 80    	cmp    %edi,0x80115b08
80103a2a:	7f 94                	jg     801039c0 <install_trans+0x20>
  }
}
80103a2c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a2f:	5b                   	pop    %ebx
80103a30:	5e                   	pop    %esi
80103a31:	5f                   	pop    %edi
80103a32:	5d                   	pop    %ebp
80103a33:	c3                   	ret
80103a34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103a38:	c3                   	ret
80103a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103a40 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103a40:	55                   	push   %ebp
80103a41:	89 e5                	mov    %esp,%ebp
80103a43:	53                   	push   %ebx
80103a44:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80103a47:	ff 35 f4 5a 11 80    	push   0x80115af4
80103a4d:	ff 35 04 5b 11 80    	push   0x80115b04
80103a53:	e8 78 c6 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103a58:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80103a5b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80103a5d:	a1 08 5b 11 80       	mov    0x80115b08,%eax
80103a62:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80103a65:	85 c0                	test   %eax,%eax
80103a67:	7e 19                	jle    80103a82 <write_head+0x42>
80103a69:	31 d2                	xor    %edx,%edx
80103a6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80103a70:	8b 0c 95 0c 5b 11 80 	mov    -0x7feea4f4(,%edx,4),%ecx
80103a77:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80103a7b:	83 c2 01             	add    $0x1,%edx
80103a7e:	39 d0                	cmp    %edx,%eax
80103a80:	75 ee                	jne    80103a70 <write_head+0x30>
  }
  bwrite(buf);
80103a82:	83 ec 0c             	sub    $0xc,%esp
80103a85:	53                   	push   %ebx
80103a86:	e8 25 c7 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80103a8b:	89 1c 24             	mov    %ebx,(%esp)
80103a8e:	e8 5d c7 ff ff       	call   801001f0 <brelse>
}
80103a93:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a96:	83 c4 10             	add    $0x10,%esp
80103a99:	c9                   	leave
80103a9a:	c3                   	ret
80103a9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103aa0 <initlog>:
{
80103aa0:	55                   	push   %ebp
80103aa1:	89 e5                	mov    %esp,%ebp
80103aa3:	53                   	push   %ebx
80103aa4:	83 ec 2c             	sub    $0x2c,%esp
80103aa7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80103aaa:	68 16 89 10 80       	push   $0x80108916
80103aaf:	68 c0 5a 11 80       	push   $0x80115ac0
80103ab4:	e8 17 17 00 00       	call   801051d0 <initlock>
  readsb(dev, &sb);
80103ab9:	58                   	pop    %eax
80103aba:	8d 45 dc             	lea    -0x24(%ebp),%eax
80103abd:	5a                   	pop    %edx
80103abe:	50                   	push   %eax
80103abf:	53                   	push   %ebx
80103ac0:	e8 6b e8 ff ff       	call   80102330 <readsb>
  log.start = sb.logstart;
80103ac5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80103ac8:	59                   	pop    %ecx
  log.dev = dev;
80103ac9:	89 1d 04 5b 11 80    	mov    %ebx,0x80115b04
  log.size = sb.nlog;
80103acf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80103ad2:	a3 f4 5a 11 80       	mov    %eax,0x80115af4
  log.size = sb.nlog;
80103ad7:	89 15 f8 5a 11 80    	mov    %edx,0x80115af8
  struct buf *buf = bread(log.dev, log.start);
80103add:	5a                   	pop    %edx
80103ade:	50                   	push   %eax
80103adf:	53                   	push   %ebx
80103ae0:	e8 eb c5 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80103ae5:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80103ae8:	8b 58 5c             	mov    0x5c(%eax),%ebx
80103aeb:	89 1d 08 5b 11 80    	mov    %ebx,0x80115b08
  for (i = 0; i < log.lh.n; i++) {
80103af1:	85 db                	test   %ebx,%ebx
80103af3:	7e 1d                	jle    80103b12 <initlog+0x72>
80103af5:	31 d2                	xor    %edx,%edx
80103af7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103afe:	00 
80103aff:	90                   	nop
    log.lh.block[i] = lh->block[i];
80103b00:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80103b04:	89 0c 95 0c 5b 11 80 	mov    %ecx,-0x7feea4f4(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80103b0b:	83 c2 01             	add    $0x1,%edx
80103b0e:	39 d3                	cmp    %edx,%ebx
80103b10:	75 ee                	jne    80103b00 <initlog+0x60>
  brelse(buf);
80103b12:	83 ec 0c             	sub    $0xc,%esp
80103b15:	50                   	push   %eax
80103b16:	e8 d5 c6 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80103b1b:	e8 80 fe ff ff       	call   801039a0 <install_trans>
  log.lh.n = 0;
80103b20:	c7 05 08 5b 11 80 00 	movl   $0x0,0x80115b08
80103b27:	00 00 00 
  write_head(); // clear the log
80103b2a:	e8 11 ff ff ff       	call   80103a40 <write_head>
}
80103b2f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b32:	83 c4 10             	add    $0x10,%esp
80103b35:	c9                   	leave
80103b36:	c3                   	ret
80103b37:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103b3e:	00 
80103b3f:	90                   	nop

80103b40 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103b40:	55                   	push   %ebp
80103b41:	89 e5                	mov    %esp,%ebp
80103b43:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80103b46:	68 c0 5a 11 80       	push   $0x80115ac0
80103b4b:	e8 70 18 00 00       	call   801053c0 <acquire>
80103b50:	83 c4 10             	add    $0x10,%esp
80103b53:	eb 18                	jmp    80103b6d <begin_op+0x2d>
80103b55:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103b58:	83 ec 08             	sub    $0x8,%esp
80103b5b:	68 c0 5a 11 80       	push   $0x80115ac0
80103b60:	68 c0 5a 11 80       	push   $0x80115ac0
80103b65:	e8 d6 12 00 00       	call   80104e40 <sleep>
80103b6a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80103b6d:	a1 00 5b 11 80       	mov    0x80115b00,%eax
80103b72:	85 c0                	test   %eax,%eax
80103b74:	75 e2                	jne    80103b58 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103b76:	a1 fc 5a 11 80       	mov    0x80115afc,%eax
80103b7b:	8b 15 08 5b 11 80    	mov    0x80115b08,%edx
80103b81:	83 c0 01             	add    $0x1,%eax
80103b84:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103b87:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80103b8a:	83 fa 1e             	cmp    $0x1e,%edx
80103b8d:	7f c9                	jg     80103b58 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80103b8f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80103b92:	a3 fc 5a 11 80       	mov    %eax,0x80115afc
      release(&log.lock);
80103b97:	68 c0 5a 11 80       	push   $0x80115ac0
80103b9c:	e8 bf 17 00 00       	call   80105360 <release>
      break;
    }
  }
}
80103ba1:	83 c4 10             	add    $0x10,%esp
80103ba4:	c9                   	leave
80103ba5:	c3                   	ret
80103ba6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103bad:	00 
80103bae:	66 90                	xchg   %ax,%ax

80103bb0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103bb0:	55                   	push   %ebp
80103bb1:	89 e5                	mov    %esp,%ebp
80103bb3:	57                   	push   %edi
80103bb4:	56                   	push   %esi
80103bb5:	53                   	push   %ebx
80103bb6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103bb9:	68 c0 5a 11 80       	push   $0x80115ac0
80103bbe:	e8 fd 17 00 00       	call   801053c0 <acquire>
  log.outstanding -= 1;
80103bc3:	a1 fc 5a 11 80       	mov    0x80115afc,%eax
  if(log.committing)
80103bc8:	8b 35 00 5b 11 80    	mov    0x80115b00,%esi
80103bce:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103bd1:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103bd4:	89 1d fc 5a 11 80    	mov    %ebx,0x80115afc
  if(log.committing)
80103bda:	85 f6                	test   %esi,%esi
80103bdc:	0f 85 22 01 00 00    	jne    80103d04 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80103be2:	85 db                	test   %ebx,%ebx
80103be4:	0f 85 f6 00 00 00    	jne    80103ce0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80103bea:	c7 05 00 5b 11 80 01 	movl   $0x1,0x80115b00
80103bf1:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80103bf4:	83 ec 0c             	sub    $0xc,%esp
80103bf7:	68 c0 5a 11 80       	push   $0x80115ac0
80103bfc:	e8 5f 17 00 00       	call   80105360 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103c01:	8b 0d 08 5b 11 80    	mov    0x80115b08,%ecx
80103c07:	83 c4 10             	add    $0x10,%esp
80103c0a:	85 c9                	test   %ecx,%ecx
80103c0c:	7f 42                	jg     80103c50 <end_op+0xa0>
    acquire(&log.lock);
80103c0e:	83 ec 0c             	sub    $0xc,%esp
80103c11:	68 c0 5a 11 80       	push   $0x80115ac0
80103c16:	e8 a5 17 00 00       	call   801053c0 <acquire>
    log.committing = 0;
80103c1b:	c7 05 00 5b 11 80 00 	movl   $0x0,0x80115b00
80103c22:	00 00 00 
    wakeup(&log);
80103c25:	c7 04 24 c0 5a 11 80 	movl   $0x80115ac0,(%esp)
80103c2c:	e8 cf 12 00 00       	call   80104f00 <wakeup>
    release(&log.lock);
80103c31:	c7 04 24 c0 5a 11 80 	movl   $0x80115ac0,(%esp)
80103c38:	e8 23 17 00 00       	call   80105360 <release>
80103c3d:	83 c4 10             	add    $0x10,%esp
}
80103c40:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c43:	5b                   	pop    %ebx
80103c44:	5e                   	pop    %esi
80103c45:	5f                   	pop    %edi
80103c46:	5d                   	pop    %ebp
80103c47:	c3                   	ret
80103c48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103c4f:	00 
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103c50:	a1 f4 5a 11 80       	mov    0x80115af4,%eax
80103c55:	83 ec 08             	sub    $0x8,%esp
80103c58:	01 d8                	add    %ebx,%eax
80103c5a:	83 c0 01             	add    $0x1,%eax
80103c5d:	50                   	push   %eax
80103c5e:	ff 35 04 5b 11 80    	push   0x80115b04
80103c64:	e8 67 c4 ff ff       	call   801000d0 <bread>
80103c69:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103c6b:	58                   	pop    %eax
80103c6c:	5a                   	pop    %edx
80103c6d:	ff 34 9d 0c 5b 11 80 	push   -0x7feea4f4(,%ebx,4)
80103c74:	ff 35 04 5b 11 80    	push   0x80115b04
  for (tail = 0; tail < log.lh.n; tail++) {
80103c7a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103c7d:	e8 4e c4 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103c82:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103c85:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103c87:	8d 40 5c             	lea    0x5c(%eax),%eax
80103c8a:	68 00 02 00 00       	push   $0x200
80103c8f:	50                   	push   %eax
80103c90:	8d 46 5c             	lea    0x5c(%esi),%eax
80103c93:	50                   	push   %eax
80103c94:	e8 b7 18 00 00       	call   80105550 <memmove>
    bwrite(to);  // write the log
80103c99:	89 34 24             	mov    %esi,(%esp)
80103c9c:	e8 0f c5 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103ca1:	89 3c 24             	mov    %edi,(%esp)
80103ca4:	e8 47 c5 ff ff       	call   801001f0 <brelse>
    brelse(to);
80103ca9:	89 34 24             	mov    %esi,(%esp)
80103cac:	e8 3f c5 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103cb1:	83 c4 10             	add    $0x10,%esp
80103cb4:	3b 1d 08 5b 11 80    	cmp    0x80115b08,%ebx
80103cba:	7c 94                	jl     80103c50 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80103cbc:	e8 7f fd ff ff       	call   80103a40 <write_head>
    install_trans(); // Now install writes to home locations
80103cc1:	e8 da fc ff ff       	call   801039a0 <install_trans>
    log.lh.n = 0;
80103cc6:	c7 05 08 5b 11 80 00 	movl   $0x0,0x80115b08
80103ccd:	00 00 00 
    write_head();    // Erase the transaction from the log
80103cd0:	e8 6b fd ff ff       	call   80103a40 <write_head>
80103cd5:	e9 34 ff ff ff       	jmp    80103c0e <end_op+0x5e>
80103cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80103ce0:	83 ec 0c             	sub    $0xc,%esp
80103ce3:	68 c0 5a 11 80       	push   $0x80115ac0
80103ce8:	e8 13 12 00 00       	call   80104f00 <wakeup>
  release(&log.lock);
80103ced:	c7 04 24 c0 5a 11 80 	movl   $0x80115ac0,(%esp)
80103cf4:	e8 67 16 00 00       	call   80105360 <release>
80103cf9:	83 c4 10             	add    $0x10,%esp
}
80103cfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103cff:	5b                   	pop    %ebx
80103d00:	5e                   	pop    %esi
80103d01:	5f                   	pop    %edi
80103d02:	5d                   	pop    %ebp
80103d03:	c3                   	ret
    panic("log.committing");
80103d04:	83 ec 0c             	sub    $0xc,%esp
80103d07:	68 1a 89 10 80       	push   $0x8010891a
80103d0c:	e8 8f c6 ff ff       	call   801003a0 <panic>
80103d11:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103d18:	00 
80103d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103d20 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103d20:	55                   	push   %ebp
80103d21:	89 e5                	mov    %esp,%ebp
80103d23:	53                   	push   %ebx
80103d24:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103d27:	8b 15 08 5b 11 80    	mov    0x80115b08,%edx
{
80103d2d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103d30:	83 fa 1d             	cmp    $0x1d,%edx
80103d33:	7f 7d                	jg     80103db2 <log_write+0x92>
80103d35:	a1 f8 5a 11 80       	mov    0x80115af8,%eax
80103d3a:	83 e8 01             	sub    $0x1,%eax
80103d3d:	39 c2                	cmp    %eax,%edx
80103d3f:	7d 71                	jge    80103db2 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103d41:	a1 fc 5a 11 80       	mov    0x80115afc,%eax
80103d46:	85 c0                	test   %eax,%eax
80103d48:	7e 75                	jle    80103dbf <log_write+0x9f>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103d4a:	83 ec 0c             	sub    $0xc,%esp
80103d4d:	68 c0 5a 11 80       	push   $0x80115ac0
80103d52:	e8 69 16 00 00       	call   801053c0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103d57:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80103d5a:	83 c4 10             	add    $0x10,%esp
80103d5d:	31 c0                	xor    %eax,%eax
80103d5f:	8b 15 08 5b 11 80    	mov    0x80115b08,%edx
80103d65:	85 d2                	test   %edx,%edx
80103d67:	7f 0e                	jg     80103d77 <log_write+0x57>
80103d69:	eb 15                	jmp    80103d80 <log_write+0x60>
80103d6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103d70:	83 c0 01             	add    $0x1,%eax
80103d73:	39 c2                	cmp    %eax,%edx
80103d75:	74 29                	je     80103da0 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103d77:	39 0c 85 0c 5b 11 80 	cmp    %ecx,-0x7feea4f4(,%eax,4)
80103d7e:	75 f0                	jne    80103d70 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80103d80:	89 0c 85 0c 5b 11 80 	mov    %ecx,-0x7feea4f4(,%eax,4)
  if (i == log.lh.n)
80103d87:	39 c2                	cmp    %eax,%edx
80103d89:	74 1c                	je     80103da7 <log_write+0x87>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103d8b:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80103d8e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80103d91:	c7 45 08 c0 5a 11 80 	movl   $0x80115ac0,0x8(%ebp)
}
80103d98:	c9                   	leave
  release(&log.lock);
80103d99:	e9 c2 15 00 00       	jmp    80105360 <release>
80103d9e:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno;
80103da0:	89 0c 95 0c 5b 11 80 	mov    %ecx,-0x7feea4f4(,%edx,4)
    log.lh.n++;
80103da7:	83 c2 01             	add    $0x1,%edx
80103daa:	89 15 08 5b 11 80    	mov    %edx,0x80115b08
80103db0:	eb d9                	jmp    80103d8b <log_write+0x6b>
    panic("too big a transaction");
80103db2:	83 ec 0c             	sub    $0xc,%esp
80103db5:	68 29 89 10 80       	push   $0x80108929
80103dba:	e8 e1 c5 ff ff       	call   801003a0 <panic>
    panic("log_write outside of trans");
80103dbf:	83 ec 0c             	sub    $0xc,%esp
80103dc2:	68 3f 89 10 80       	push   $0x8010893f
80103dc7:	e8 d4 c5 ff ff       	call   801003a0 <panic>
80103dcc:	66 90                	xchg   %ax,%ax
80103dce:	66 90                	xchg   %ax,%ax

80103dd0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103dd0:	55                   	push   %ebp
80103dd1:	89 e5                	mov    %esp,%ebp
80103dd3:	53                   	push   %ebx
80103dd4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103dd7:	e8 74 09 00 00       	call   80104750 <cpuid>
80103ddc:	89 c3                	mov    %eax,%ebx
80103dde:	e8 6d 09 00 00       	call   80104750 <cpuid>
80103de3:	83 ec 04             	sub    $0x4,%esp
80103de6:	53                   	push   %ebx
80103de7:	50                   	push   %eax
80103de8:	68 5a 89 10 80       	push   $0x8010895a
80103ded:	e8 4e ce ff ff       	call   80100c40 <cprintf>
  idtinit();       // load idt register
80103df2:	e8 69 30 00 00       	call   80106e60 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103df7:	e8 f4 08 00 00       	call   801046f0 <mycpu>
80103dfc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103dfe:	b8 01 00 00 00       	mov    $0x1,%eax
80103e03:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80103e0a:	e8 21 0c 00 00       	call   80104a30 <scheduler>
80103e0f:	90                   	nop

80103e10 <mpenter>:
{
80103e10:	55                   	push   %ebp
80103e11:	89 e5                	mov    %esp,%ebp
80103e13:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103e16:	e8 45 41 00 00       	call   80107f60 <switchkvm>
  seginit();
80103e1b:	e8 b0 40 00 00       	call   80107ed0 <seginit>
  lapicinit();
80103e20:	e8 bb f7 ff ff       	call   801035e0 <lapicinit>
  mpmain();
80103e25:	e8 a6 ff ff ff       	call   80103dd0 <mpmain>
80103e2a:	66 90                	xchg   %ax,%ax
80103e2c:	66 90                	xchg   %ax,%ax
80103e2e:	66 90                	xchg   %ax,%ax

80103e30 <main>:
{
80103e30:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103e34:	83 e4 f0             	and    $0xfffffff0,%esp
80103e37:	ff 71 fc             	push   -0x4(%ecx)
80103e3a:	55                   	push   %ebp
80103e3b:	89 e5                	mov    %esp,%ebp
80103e3d:	53                   	push   %ebx
80103e3e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103e3f:	83 ec 08             	sub    $0x8,%esp
80103e42:	68 00 00 40 80       	push   $0x80400000
80103e47:	68 f0 99 11 80       	push   $0x801199f0
80103e4c:	e8 8f f5 ff ff       	call   801033e0 <kinit1>
  kvmalloc();      // kernel page table
80103e51:	e8 ca 45 00 00       	call   80108420 <kvmalloc>
  mpinit();        // detect other processors
80103e56:	e8 85 01 00 00       	call   80103fe0 <mpinit>
  lapicinit();     // interrupt controller
80103e5b:	e8 80 f7 ff ff       	call   801035e0 <lapicinit>
  seginit();       // segment descriptors
80103e60:	e8 6b 40 00 00       	call   80107ed0 <seginit>
  picinit();       // disable pic
80103e65:	e8 86 03 00 00       	call   801041f0 <picinit>
  ioapicinit();    // another interrupt controller
80103e6a:	e8 41 f3 ff ff       	call   801031b0 <ioapicinit>
  consoleinit();   // console hardware
80103e6f:	e8 6c d4 ff ff       	call   801012e0 <consoleinit>
  uartinit();      // serial port
80103e74:	e8 c7 32 00 00       	call   80107140 <uartinit>
  pinit();         // process table
80103e79:	e8 52 08 00 00       	call   801046d0 <pinit>
  tvinit();        // trap vectors
80103e7e:	e8 5d 2f 00 00       	call   80106de0 <tvinit>
  binit();         // buffer cache
80103e83:	e8 b8 c1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103e88:	e8 23 d8 ff ff       	call   801016b0 <fileinit>
  ideinit();       // disk 
80103e8d:	e8 fe f0 ff ff       	call   80102f90 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103e92:	83 c4 0c             	add    $0xc,%esp
80103e95:	68 8a 00 00 00       	push   $0x8a
80103e9a:	68 8c c4 10 80       	push   $0x8010c48c
80103e9f:	68 00 70 00 80       	push   $0x80007000
80103ea4:	e8 a7 16 00 00       	call   80105550 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103ea9:	83 c4 10             	add    $0x10,%esp
80103eac:	69 05 a4 5b 11 80 b0 	imul   $0xb0,0x80115ba4,%eax
80103eb3:	00 00 00 
80103eb6:	05 c0 5b 11 80       	add    $0x80115bc0,%eax
80103ebb:	3d c0 5b 11 80       	cmp    $0x80115bc0,%eax
80103ec0:	76 7e                	jbe    80103f40 <main+0x110>
80103ec2:	bb c0 5b 11 80       	mov    $0x80115bc0,%ebx
80103ec7:	eb 20                	jmp    80103ee9 <main+0xb9>
80103ec9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ed0:	69 05 a4 5b 11 80 b0 	imul   $0xb0,0x80115ba4,%eax
80103ed7:	00 00 00 
80103eda:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103ee0:	05 c0 5b 11 80       	add    $0x80115bc0,%eax
80103ee5:	39 c3                	cmp    %eax,%ebx
80103ee7:	73 57                	jae    80103f40 <main+0x110>
    if(c == mycpu())  // We've started already.
80103ee9:	e8 02 08 00 00       	call   801046f0 <mycpu>
80103eee:	39 c3                	cmp    %eax,%ebx
80103ef0:	74 de                	je     80103ed0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103ef2:	e8 59 f5 ff ff       	call   80103450 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103ef7:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
80103efa:	c7 05 f8 6f 00 80 10 	movl   $0x80103e10,0x80006ff8
80103f01:	3e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103f04:	c7 05 f4 6f 00 80 00 	movl   $0x10b000,0x80006ff4
80103f0b:	b0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103f0e:	05 00 10 00 00       	add    $0x1000,%eax
80103f13:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103f18:	0f b6 03             	movzbl (%ebx),%eax
80103f1b:	68 00 70 00 00       	push   $0x7000
80103f20:	50                   	push   %eax
80103f21:	e8 fa f7 ff ff       	call   80103720 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103f26:	83 c4 10             	add    $0x10,%esp
80103f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f30:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103f36:	85 c0                	test   %eax,%eax
80103f38:	74 f6                	je     80103f30 <main+0x100>
80103f3a:	eb 94                	jmp    80103ed0 <main+0xa0>
80103f3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103f40:	83 ec 08             	sub    $0x8,%esp
80103f43:	68 00 00 00 8e       	push   $0x8e000000
80103f48:	68 00 00 40 80       	push   $0x80400000
80103f4d:	e8 2e f4 ff ff       	call   80103380 <kinit2>
  userinit();      // first user process
80103f52:	e8 49 08 00 00       	call   801047a0 <userinit>
  mpmain();        // finish this processor's setup
80103f57:	e8 74 fe ff ff       	call   80103dd0 <mpmain>
80103f5c:	66 90                	xchg   %ax,%ax
80103f5e:	66 90                	xchg   %ax,%ax

80103f60 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103f60:	55                   	push   %ebp
80103f61:	89 e5                	mov    %esp,%ebp
80103f63:	57                   	push   %edi
80103f64:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103f65:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80103f6b:	53                   	push   %ebx
  e = addr+len;
80103f6c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80103f6f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103f72:	39 de                	cmp    %ebx,%esi
80103f74:	72 10                	jb     80103f86 <mpsearch1+0x26>
80103f76:	eb 50                	jmp    80103fc8 <mpsearch1+0x68>
80103f78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f7f:	00 
80103f80:	89 fe                	mov    %edi,%esi
80103f82:	39 df                	cmp    %ebx,%edi
80103f84:	73 42                	jae    80103fc8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103f86:	83 ec 04             	sub    $0x4,%esp
80103f89:	8d 7e 10             	lea    0x10(%esi),%edi
80103f8c:	6a 04                	push   $0x4
80103f8e:	68 6e 89 10 80       	push   $0x8010896e
80103f93:	56                   	push   %esi
80103f94:	e8 67 15 00 00       	call   80105500 <memcmp>
80103f99:	83 c4 10             	add    $0x10,%esp
80103f9c:	85 c0                	test   %eax,%eax
80103f9e:	75 e0                	jne    80103f80 <mpsearch1+0x20>
80103fa0:	89 f2                	mov    %esi,%edx
80103fa2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103fa8:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103fab:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103fae:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103fb0:	39 fa                	cmp    %edi,%edx
80103fb2:	75 f4                	jne    80103fa8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103fb4:	84 c0                	test   %al,%al
80103fb6:	75 c8                	jne    80103f80 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103fb8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103fbb:	89 f0                	mov    %esi,%eax
80103fbd:	5b                   	pop    %ebx
80103fbe:	5e                   	pop    %esi
80103fbf:	5f                   	pop    %edi
80103fc0:	5d                   	pop    %ebp
80103fc1:	c3                   	ret
80103fc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103fc8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103fcb:	31 f6                	xor    %esi,%esi
}
80103fcd:	5b                   	pop    %ebx
80103fce:	89 f0                	mov    %esi,%eax
80103fd0:	5e                   	pop    %esi
80103fd1:	5f                   	pop    %edi
80103fd2:	5d                   	pop    %ebp
80103fd3:	c3                   	ret
80103fd4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103fdb:	00 
80103fdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103fe0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103fe0:	55                   	push   %ebp
80103fe1:	89 e5                	mov    %esp,%ebp
80103fe3:	57                   	push   %edi
80103fe4:	56                   	push   %esi
80103fe5:	53                   	push   %ebx
80103fe6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103fe9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103ff0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103ff7:	c1 e0 08             	shl    $0x8,%eax
80103ffa:	09 d0                	or     %edx,%eax
80103ffc:	c1 e0 04             	shl    $0x4,%eax
80103fff:	75 1b                	jne    8010401c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80104001:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80104008:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010400f:	c1 e0 08             	shl    $0x8,%eax
80104012:	09 d0                	or     %edx,%eax
80104014:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80104017:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010401c:	ba 00 04 00 00       	mov    $0x400,%edx
80104021:	e8 3a ff ff ff       	call   80103f60 <mpsearch1>
80104026:	89 c3                	mov    %eax,%ebx
80104028:	85 c0                	test   %eax,%eax
8010402a:	0f 84 58 01 00 00    	je     80104188 <mpinit+0x1a8>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80104030:	8b 73 04             	mov    0x4(%ebx),%esi
80104033:	85 f6                	test   %esi,%esi
80104035:	0f 84 3d 01 00 00    	je     80104178 <mpinit+0x198>
  if(memcmp(conf, "PCMP", 4) != 0)
8010403b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010403e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80104044:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80104047:	6a 04                	push   $0x4
80104049:	68 73 89 10 80       	push   $0x80108973
8010404e:	50                   	push   %eax
8010404f:	e8 ac 14 00 00       	call   80105500 <memcmp>
80104054:	83 c4 10             	add    $0x10,%esp
80104057:	85 c0                	test   %eax,%eax
80104059:	0f 85 19 01 00 00    	jne    80104178 <mpinit+0x198>
  if(conf->version != 1 && conf->version != 4)
8010405f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80104066:	3c 01                	cmp    $0x1,%al
80104068:	74 08                	je     80104072 <mpinit+0x92>
8010406a:	3c 04                	cmp    $0x4,%al
8010406c:	0f 85 06 01 00 00    	jne    80104178 <mpinit+0x198>
  if(sum((uchar*)conf, conf->length) != 0)
80104072:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80104079:	66 85 d2             	test   %dx,%dx
8010407c:	74 22                	je     801040a0 <mpinit+0xc0>
8010407e:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80104081:	89 f0                	mov    %esi,%eax
  sum = 0;
80104083:	31 d2                	xor    %edx,%edx
80104085:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80104088:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
8010408f:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80104092:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80104094:	39 f8                	cmp    %edi,%eax
80104096:	75 f0                	jne    80104088 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80104098:	84 d2                	test   %dl,%dl
8010409a:	0f 85 d8 00 00 00    	jne    80104178 <mpinit+0x198>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801040a0:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801040a6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801040a9:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  lapic = (uint*)conf->lapicaddr;
801040ac:	a3 a0 5a 11 80       	mov    %eax,0x80115aa0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801040b1:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
801040b8:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
801040be:	01 d7                	add    %edx,%edi
801040c0:	89 fa                	mov    %edi,%edx
  ismp = 1;
801040c2:	bf 01 00 00 00       	mov    $0x1,%edi
801040c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801040ce:	00 
801040cf:	90                   	nop
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801040d0:	39 d0                	cmp    %edx,%eax
801040d2:	73 19                	jae    801040ed <mpinit+0x10d>
    switch(*p){
801040d4:	0f b6 08             	movzbl (%eax),%ecx
801040d7:	80 f9 02             	cmp    $0x2,%cl
801040da:	0f 84 80 00 00 00    	je     80104160 <mpinit+0x180>
801040e0:	77 6e                	ja     80104150 <mpinit+0x170>
801040e2:	84 c9                	test   %cl,%cl
801040e4:	74 3a                	je     80104120 <mpinit+0x140>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801040e6:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801040e9:	39 d0                	cmp    %edx,%eax
801040eb:	72 e7                	jb     801040d4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801040ed:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801040f0:	85 ff                	test   %edi,%edi
801040f2:	0f 84 dd 00 00 00    	je     801041d5 <mpinit+0x1f5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801040f8:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
801040fc:	74 15                	je     80104113 <mpinit+0x133>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801040fe:	b8 70 00 00 00       	mov    $0x70,%eax
80104103:	ba 22 00 00 00       	mov    $0x22,%edx
80104108:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80104109:	ba 23 00 00 00       	mov    $0x23,%edx
8010410e:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
8010410f:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80104112:	ee                   	out    %al,(%dx)
  }
}
80104113:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104116:	5b                   	pop    %ebx
80104117:	5e                   	pop    %esi
80104118:	5f                   	pop    %edi
80104119:	5d                   	pop    %ebp
8010411a:	c3                   	ret
8010411b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
80104120:	8b 0d a4 5b 11 80    	mov    0x80115ba4,%ecx
80104126:	83 f9 07             	cmp    $0x7,%ecx
80104129:	7f 19                	jg     80104144 <mpinit+0x164>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010412b:	69 f1 b0 00 00 00    	imul   $0xb0,%ecx,%esi
80104131:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80104135:	83 c1 01             	add    $0x1,%ecx
80104138:	89 0d a4 5b 11 80    	mov    %ecx,0x80115ba4
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010413e:	88 9e c0 5b 11 80    	mov    %bl,-0x7feea440(%esi)
      p += sizeof(struct mpproc);
80104144:	83 c0 14             	add    $0x14,%eax
      continue;
80104147:	eb 87                	jmp    801040d0 <mpinit+0xf0>
80104149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(*p){
80104150:	83 e9 03             	sub    $0x3,%ecx
80104153:	80 f9 01             	cmp    $0x1,%cl
80104156:	76 8e                	jbe    801040e6 <mpinit+0x106>
80104158:	31 ff                	xor    %edi,%edi
8010415a:	e9 71 ff ff ff       	jmp    801040d0 <mpinit+0xf0>
8010415f:	90                   	nop
      ioapicid = ioapic->apicno;
80104160:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80104164:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80104167:	88 0d a0 5b 11 80    	mov    %cl,0x80115ba0
      continue;
8010416d:	e9 5e ff ff ff       	jmp    801040d0 <mpinit+0xf0>
80104172:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80104178:	83 ec 0c             	sub    $0xc,%esp
8010417b:	68 78 89 10 80       	push   $0x80108978
80104180:	e8 1b c2 ff ff       	call   801003a0 <panic>
80104185:	8d 76 00             	lea    0x0(%esi),%esi
{
80104188:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
8010418d:	eb 0b                	jmp    8010419a <mpinit+0x1ba>
8010418f:	90                   	nop
  for(p = addr; p < e; p += sizeof(struct mp))
80104190:	89 f3                	mov    %esi,%ebx
80104192:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80104198:	74 de                	je     80104178 <mpinit+0x198>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010419a:	83 ec 04             	sub    $0x4,%esp
8010419d:	8d 73 10             	lea    0x10(%ebx),%esi
801041a0:	6a 04                	push   $0x4
801041a2:	68 6e 89 10 80       	push   $0x8010896e
801041a7:	53                   	push   %ebx
801041a8:	e8 53 13 00 00       	call   80105500 <memcmp>
801041ad:	83 c4 10             	add    $0x10,%esp
801041b0:	85 c0                	test   %eax,%eax
801041b2:	75 dc                	jne    80104190 <mpinit+0x1b0>
801041b4:	89 da                	mov    %ebx,%edx
801041b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801041bd:	00 
801041be:	66 90                	xchg   %ax,%ax
    sum += addr[i];
801041c0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801041c3:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801041c6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801041c8:	39 d6                	cmp    %edx,%esi
801041ca:	75 f4                	jne    801041c0 <mpinit+0x1e0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801041cc:	84 c0                	test   %al,%al
801041ce:	75 c0                	jne    80104190 <mpinit+0x1b0>
801041d0:	e9 5b fe ff ff       	jmp    80104030 <mpinit+0x50>
    panic("Didn't find a suitable machine");
801041d5:	83 ec 0c             	sub    $0xc,%esp
801041d8:	68 98 8d 10 80       	push   $0x80108d98
801041dd:	e8 be c1 ff ff       	call   801003a0 <panic>
801041e2:	66 90                	xchg   %ax,%ax
801041e4:	66 90                	xchg   %ax,%ax
801041e6:	66 90                	xchg   %ax,%ax
801041e8:	66 90                	xchg   %ax,%ax
801041ea:	66 90                	xchg   %ax,%ax
801041ec:	66 90                	xchg   %ax,%ax
801041ee:	66 90                	xchg   %ax,%ax

801041f0 <picinit>:
801041f0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801041f5:	ba 21 00 00 00       	mov    $0x21,%edx
801041fa:	ee                   	out    %al,(%dx)
801041fb:	ba a1 00 00 00       	mov    $0xa1,%edx
80104200:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80104201:	c3                   	ret
80104202:	66 90                	xchg   %ax,%ax
80104204:	66 90                	xchg   %ax,%ax
80104206:	66 90                	xchg   %ax,%ax
80104208:	66 90                	xchg   %ax,%ax
8010420a:	66 90                	xchg   %ax,%ax
8010420c:	66 90                	xchg   %ax,%ax
8010420e:	66 90                	xchg   %ax,%ax

80104210 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80104210:	55                   	push   %ebp
80104211:	89 e5                	mov    %esp,%ebp
80104213:	57                   	push   %edi
80104214:	56                   	push   %esi
80104215:	53                   	push   %ebx
80104216:	83 ec 0c             	sub    $0xc,%esp
80104219:	8b 75 08             	mov    0x8(%ebp),%esi
8010421c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010421f:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80104225:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010422b:	e8 a0 d4 ff ff       	call   801016d0 <filealloc>
80104230:	89 06                	mov    %eax,(%esi)
80104232:	85 c0                	test   %eax,%eax
80104234:	0f 84 a5 00 00 00    	je     801042df <pipealloc+0xcf>
8010423a:	e8 91 d4 ff ff       	call   801016d0 <filealloc>
8010423f:	89 07                	mov    %eax,(%edi)
80104241:	85 c0                	test   %eax,%eax
80104243:	0f 84 84 00 00 00    	je     801042cd <pipealloc+0xbd>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80104249:	e8 02 f2 ff ff       	call   80103450 <kalloc>
8010424e:	89 c3                	mov    %eax,%ebx
80104250:	85 c0                	test   %eax,%eax
80104252:	0f 84 a0 00 00 00    	je     801042f8 <pipealloc+0xe8>
    goto bad;
  p->readopen = 1;
80104258:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010425f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80104262:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80104265:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010426c:	00 00 00 
  p->nwrite = 0;
8010426f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80104276:	00 00 00 
  p->nread = 0;
80104279:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80104280:	00 00 00 
  initlock(&p->lock, "pipe");
80104283:	68 90 89 10 80       	push   $0x80108990
80104288:	50                   	push   %eax
80104289:	e8 42 0f 00 00       	call   801051d0 <initlock>
  (*f0)->type = FD_PIPE;
8010428e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80104290:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80104293:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80104299:	8b 06                	mov    (%esi),%eax
8010429b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010429f:	8b 06                	mov    (%esi),%eax
801042a1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801042a5:	8b 06                	mov    (%esi),%eax
801042a7:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
801042aa:	8b 07                	mov    (%edi),%eax
801042ac:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801042b2:	8b 07                	mov    (%edi),%eax
801042b4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801042b8:	8b 07                	mov    (%edi),%eax
801042ba:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801042be:	8b 07                	mov    (%edi),%eax
801042c0:	89 58 0c             	mov    %ebx,0xc(%eax)
  return 0;
801042c3:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801042c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801042c8:	5b                   	pop    %ebx
801042c9:	5e                   	pop    %esi
801042ca:	5f                   	pop    %edi
801042cb:	5d                   	pop    %ebp
801042cc:	c3                   	ret
  if(*f0)
801042cd:	8b 06                	mov    (%esi),%eax
801042cf:	85 c0                	test   %eax,%eax
801042d1:	74 1e                	je     801042f1 <pipealloc+0xe1>
    fileclose(*f0);
801042d3:	83 ec 0c             	sub    $0xc,%esp
801042d6:	50                   	push   %eax
801042d7:	e8 b4 d4 ff ff       	call   80101790 <fileclose>
801042dc:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801042df:	8b 07                	mov    (%edi),%eax
801042e1:	85 c0                	test   %eax,%eax
801042e3:	74 0c                	je     801042f1 <pipealloc+0xe1>
    fileclose(*f1);
801042e5:	83 ec 0c             	sub    $0xc,%esp
801042e8:	50                   	push   %eax
801042e9:	e8 a2 d4 ff ff       	call   80101790 <fileclose>
801042ee:	83 c4 10             	add    $0x10,%esp
  return -1;
801042f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801042f6:	eb cd                	jmp    801042c5 <pipealloc+0xb5>
  if(*f0)
801042f8:	8b 06                	mov    (%esi),%eax
801042fa:	85 c0                	test   %eax,%eax
801042fc:	75 d5                	jne    801042d3 <pipealloc+0xc3>
801042fe:	eb df                	jmp    801042df <pipealloc+0xcf>

80104300 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80104300:	55                   	push   %ebp
80104301:	89 e5                	mov    %esp,%ebp
80104303:	56                   	push   %esi
80104304:	53                   	push   %ebx
80104305:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104308:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010430b:	83 ec 0c             	sub    $0xc,%esp
8010430e:	53                   	push   %ebx
8010430f:	e8 ac 10 00 00       	call   801053c0 <acquire>
  if(writable){
80104314:	83 c4 10             	add    $0x10,%esp
80104317:	85 f6                	test   %esi,%esi
80104319:	74 65                	je     80104380 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010431b:	83 ec 0c             	sub    $0xc,%esp
8010431e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80104324:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010432b:	00 00 00 
    wakeup(&p->nread);
8010432e:	50                   	push   %eax
8010432f:	e8 cc 0b 00 00       	call   80104f00 <wakeup>
80104334:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80104337:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010433d:	85 d2                	test   %edx,%edx
8010433f:	75 0a                	jne    8010434b <pipeclose+0x4b>
80104341:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80104347:	85 c0                	test   %eax,%eax
80104349:	74 15                	je     80104360 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010434b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010434e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104351:	5b                   	pop    %ebx
80104352:	5e                   	pop    %esi
80104353:	5d                   	pop    %ebp
    release(&p->lock);
80104354:	e9 07 10 00 00       	jmp    80105360 <release>
80104359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80104360:	83 ec 0c             	sub    $0xc,%esp
80104363:	53                   	push   %ebx
80104364:	e8 f7 0f 00 00       	call   80105360 <release>
    kfree((char*)p);
80104369:	83 c4 10             	add    $0x10,%esp
8010436c:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010436f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104372:	5b                   	pop    %ebx
80104373:	5e                   	pop    %esi
80104374:	5d                   	pop    %ebp
    kfree((char*)p);
80104375:	e9 16 ef ff ff       	jmp    80103290 <kfree>
8010437a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80104380:	83 ec 0c             	sub    $0xc,%esp
80104383:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80104389:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80104390:	00 00 00 
    wakeup(&p->nwrite);
80104393:	50                   	push   %eax
80104394:	e8 67 0b 00 00       	call   80104f00 <wakeup>
80104399:	83 c4 10             	add    $0x10,%esp
8010439c:	eb 99                	jmp    80104337 <pipeclose+0x37>
8010439e:	66 90                	xchg   %ax,%ax

801043a0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	57                   	push   %edi
801043a4:	56                   	push   %esi
801043a5:	53                   	push   %ebx
801043a6:	83 ec 28             	sub    $0x28,%esp
801043a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801043ac:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
801043af:	53                   	push   %ebx
801043b0:	e8 0b 10 00 00       	call   801053c0 <acquire>
  for(i = 0; i < n; i++){
801043b5:	83 c4 10             	add    $0x10,%esp
801043b8:	85 ff                	test   %edi,%edi
801043ba:	0f 8e ce 00 00 00    	jle    8010448e <pipewrite+0xee>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801043c0:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801043c6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801043c9:	89 7d 10             	mov    %edi,0x10(%ebp)
801043cc:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801043cf:	8d 34 39             	lea    (%ecx,%edi,1),%esi
801043d2:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801043d5:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801043db:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801043e1:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801043e7:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
801043ed:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
801043f0:	0f 85 b6 00 00 00    	jne    801044ac <pipewrite+0x10c>
801043f6:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801043f9:	eb 3b                	jmp    80104436 <pipewrite+0x96>
801043fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80104400:	e8 6b 03 00 00       	call   80104770 <myproc>
80104405:	8b 48 24             	mov    0x24(%eax),%ecx
80104408:	85 c9                	test   %ecx,%ecx
8010440a:	75 34                	jne    80104440 <pipewrite+0xa0>
      wakeup(&p->nread);
8010440c:	83 ec 0c             	sub    $0xc,%esp
8010440f:	56                   	push   %esi
80104410:	e8 eb 0a 00 00       	call   80104f00 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80104415:	58                   	pop    %eax
80104416:	5a                   	pop    %edx
80104417:	53                   	push   %ebx
80104418:	57                   	push   %edi
80104419:	e8 22 0a 00 00       	call   80104e40 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010441e:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80104424:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010442a:	83 c4 10             	add    $0x10,%esp
8010442d:	05 00 02 00 00       	add    $0x200,%eax
80104432:	39 c2                	cmp    %eax,%edx
80104434:	75 2a                	jne    80104460 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
80104436:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010443c:	85 c0                	test   %eax,%eax
8010443e:	75 c0                	jne    80104400 <pipewrite+0x60>
        release(&p->lock);
80104440:	83 ec 0c             	sub    $0xc,%esp
80104443:	53                   	push   %ebx
80104444:	e8 17 0f 00 00       	call   80105360 <release>
        return -1;
80104449:	83 c4 10             	add    $0x10,%esp
8010444c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80104451:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104454:	5b                   	pop    %ebx
80104455:	5e                   	pop    %esi
80104456:	5f                   	pop    %edi
80104457:	5d                   	pop    %ebp
80104458:	c3                   	ret
80104459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104460:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104463:	8d 42 01             	lea    0x1(%edx),%eax
80104466:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  for(i = 0; i < n; i++){
8010446c:	83 c1 01             	add    $0x1,%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010446f:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80104475:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104478:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
8010447c:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80104480:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104483:	39 c1                	cmp    %eax,%ecx
80104485:	0f 85 50 ff ff ff    	jne    801043db <pipewrite+0x3b>
8010448b:	8b 7d 10             	mov    0x10(%ebp),%edi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
8010448e:	83 ec 0c             	sub    $0xc,%esp
80104491:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80104497:	50                   	push   %eax
80104498:	e8 63 0a 00 00       	call   80104f00 <wakeup>
  release(&p->lock);
8010449d:	89 1c 24             	mov    %ebx,(%esp)
801044a0:	e8 bb 0e 00 00       	call   80105360 <release>
  return n;
801044a5:	83 c4 10             	add    $0x10,%esp
801044a8:	89 f8                	mov    %edi,%eax
801044aa:	eb a5                	jmp    80104451 <pipewrite+0xb1>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801044ac:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801044af:	eb b2                	jmp    80104463 <pipewrite+0xc3>
801044b1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801044b8:	00 
801044b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801044c0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801044c0:	55                   	push   %ebp
801044c1:	89 e5                	mov    %esp,%ebp
801044c3:	57                   	push   %edi
801044c4:	56                   	push   %esi
801044c5:	53                   	push   %ebx
801044c6:	83 ec 18             	sub    $0x18,%esp
801044c9:	8b 75 08             	mov    0x8(%ebp),%esi
801044cc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801044cf:	56                   	push   %esi
801044d0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801044d6:	e8 e5 0e 00 00       	call   801053c0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801044db:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801044e1:	83 c4 10             	add    $0x10,%esp
801044e4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801044ea:	74 2f                	je     8010451b <piperead+0x5b>
801044ec:	eb 37                	jmp    80104525 <piperead+0x65>
801044ee:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
801044f0:	e8 7b 02 00 00       	call   80104770 <myproc>
801044f5:	8b 40 24             	mov    0x24(%eax),%eax
801044f8:	85 c0                	test   %eax,%eax
801044fa:	0f 85 80 00 00 00    	jne    80104580 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80104500:	83 ec 08             	sub    $0x8,%esp
80104503:	56                   	push   %esi
80104504:	53                   	push   %ebx
80104505:	e8 36 09 00 00       	call   80104e40 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010450a:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80104510:	83 c4 10             	add    $0x10,%esp
80104513:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80104519:	75 0a                	jne    80104525 <piperead+0x65>
8010451b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80104521:	85 d2                	test   %edx,%edx
80104523:	75 cb                	jne    801044f0 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104525:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104528:	31 db                	xor    %ebx,%ebx
8010452a:	85 c9                	test   %ecx,%ecx
8010452c:	7f 26                	jg     80104554 <piperead+0x94>
8010452e:	eb 2c                	jmp    8010455c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104530:	8d 48 01             	lea    0x1(%eax),%ecx
80104533:	25 ff 01 00 00       	and    $0x1ff,%eax
80104538:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010453e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80104543:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104546:	83 c3 01             	add    $0x1,%ebx
80104549:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010454c:	74 0e                	je     8010455c <piperead+0x9c>
8010454e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
    if(p->nread == p->nwrite)
80104554:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010455a:	75 d4                	jne    80104530 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010455c:	83 ec 0c             	sub    $0xc,%esp
8010455f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80104565:	50                   	push   %eax
80104566:	e8 95 09 00 00       	call   80104f00 <wakeup>
  release(&p->lock);
8010456b:	89 34 24             	mov    %esi,(%esp)
8010456e:	e8 ed 0d 00 00       	call   80105360 <release>
  return i;
80104573:	83 c4 10             	add    $0x10,%esp
}
80104576:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104579:	89 d8                	mov    %ebx,%eax
8010457b:	5b                   	pop    %ebx
8010457c:	5e                   	pop    %esi
8010457d:	5f                   	pop    %edi
8010457e:	5d                   	pop    %ebp
8010457f:	c3                   	ret
      release(&p->lock);
80104580:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104583:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80104588:	56                   	push   %esi
80104589:	e8 d2 0d 00 00       	call   80105360 <release>
      return -1;
8010458e:	83 c4 10             	add    $0x10,%esp
}
80104591:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104594:	89 d8                	mov    %ebx,%eax
80104596:	5b                   	pop    %ebx
80104597:	5e                   	pop    %esi
80104598:	5f                   	pop    %edi
80104599:	5d                   	pop    %ebp
8010459a:	c3                   	ret
8010459b:	66 90                	xchg   %ax,%ax
8010459d:	66 90                	xchg   %ax,%ax
8010459f:	90                   	nop

801045a0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801045a0:	55                   	push   %ebp
801045a1:	89 e5                	mov    %esp,%ebp
801045a3:	53                   	push   %ebx
  char *sp;
  

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801045a4:	bb 74 61 11 80       	mov    $0x80116174,%ebx
{
801045a9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801045ac:	68 40 61 11 80       	push   $0x80116140
801045b1:	e8 0a 0e 00 00       	call   801053c0 <acquire>
801045b6:	83 c4 10             	add    $0x10,%esp
801045b9:	eb 14                	jmp    801045cf <allocproc+0x2f>
801045bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801045c0:	83 eb 80             	sub    $0xffffff80,%ebx
801045c3:	81 fb 74 81 11 80    	cmp    $0x80118174,%ebx
801045c9:	0f 84 81 00 00 00    	je     80104650 <allocproc+0xb0>
    if(p->state == UNUSED)
801045cf:	8b 43 0c             	mov    0xc(%ebx),%eax
801045d2:	85 c0                	test   %eax,%eax
801045d4:	75 ea                	jne    801045c0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801045d6:	a1 04 c0 10 80       	mov    0x8010c004,%eax
  p->logged_in_user = -1;

  release(&ptable.lock);
801045db:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801045de:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->logged_in_user = -1;
801045e5:	c7 43 7c ff ff ff ff 	movl   $0xffffffff,0x7c(%ebx)
  p->pid = nextpid++;
801045ec:	89 43 10             	mov    %eax,0x10(%ebx)
801045ef:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
801045f2:	68 40 61 11 80       	push   $0x80116140
  p->pid = nextpid++;
801045f7:	89 15 04 c0 10 80    	mov    %edx,0x8010c004
  release(&ptable.lock);
801045fd:	e8 5e 0d 00 00       	call   80105360 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80104602:	e8 49 ee ff ff       	call   80103450 <kalloc>
80104607:	83 c4 10             	add    $0x10,%esp
8010460a:	89 43 08             	mov    %eax,0x8(%ebx)
8010460d:	85 c0                	test   %eax,%eax
8010460f:	74 58                	je     80104669 <allocproc+0xc9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80104611:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80104617:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010461a:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
8010461f:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80104622:	c7 40 14 cf 6d 10 80 	movl   $0x80106dcf,0x14(%eax)
  p->context = (struct context*)sp;
80104629:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
8010462c:	6a 14                	push   $0x14
8010462e:	6a 00                	push   $0x0
80104630:	50                   	push   %eax
80104631:	e8 8a 0e 00 00       	call   801054c0 <memset>
  p->context->eip = (uint)forkret;
80104636:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80104639:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
8010463c:	c7 40 10 80 46 10 80 	movl   $0x80104680,0x10(%eax)
}
80104643:	89 d8                	mov    %ebx,%eax
80104645:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104648:	c9                   	leave
80104649:	c3                   	ret
8010464a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104650:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80104653:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80104655:	68 40 61 11 80       	push   $0x80116140
8010465a:	e8 01 0d 00 00       	call   80105360 <release>
  return 0;
8010465f:	83 c4 10             	add    $0x10,%esp
}
80104662:	89 d8                	mov    %ebx,%eax
80104664:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104667:	c9                   	leave
80104668:	c3                   	ret
    p->state = UNUSED;
80104669:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
80104670:	31 db                	xor    %ebx,%ebx
80104672:	eb ee                	jmp    80104662 <allocproc+0xc2>
80104674:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010467b:	00 
8010467c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104680 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80104680:	55                   	push   %ebp
80104681:	89 e5                	mov    %esp,%ebp
80104683:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80104686:	68 40 61 11 80       	push   $0x80116140
8010468b:	e8 d0 0c 00 00       	call   80105360 <release>

  if (first) {
80104690:	a1 00 c0 10 80       	mov    0x8010c000,%eax
80104695:	83 c4 10             	add    $0x10,%esp
80104698:	85 c0                	test   %eax,%eax
8010469a:	75 04                	jne    801046a0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010469c:	c9                   	leave
8010469d:	c3                   	ret
8010469e:	66 90                	xchg   %ax,%ax
    first = 0;
801046a0:	c7 05 00 c0 10 80 00 	movl   $0x0,0x8010c000
801046a7:	00 00 00 
    iinit(ROOTDEV);
801046aa:	83 ec 0c             	sub    $0xc,%esp
801046ad:	6a 01                	push   $0x1
801046af:	e8 bc dc ff ff       	call   80102370 <iinit>
    initlog(ROOTDEV);
801046b4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801046bb:	e8 e0 f3 ff ff       	call   80103aa0 <initlog>
}
801046c0:	83 c4 10             	add    $0x10,%esp
801046c3:	c9                   	leave
801046c4:	c3                   	ret
801046c5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801046cc:	00 
801046cd:	8d 76 00             	lea    0x0(%esi),%esi

801046d0 <pinit>:
{
801046d0:	55                   	push   %ebp
801046d1:	89 e5                	mov    %esp,%ebp
801046d3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801046d6:	68 95 89 10 80       	push   $0x80108995
801046db:	68 40 61 11 80       	push   $0x80116140
801046e0:	e8 eb 0a 00 00       	call   801051d0 <initlock>
}
801046e5:	83 c4 10             	add    $0x10,%esp
801046e8:	c9                   	leave
801046e9:	c3                   	ret
801046ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801046f0 <mycpu>:
{
801046f0:	55                   	push   %ebp
801046f1:	89 e5                	mov    %esp,%ebp
801046f3:	56                   	push   %esi
801046f4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801046f5:	9c                   	pushf
801046f6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801046f7:	f6 c4 02             	test   $0x2,%ah
801046fa:	75 46                	jne    80104742 <mycpu+0x52>
  apicid = lapicid();
801046fc:	e8 cf ef ff ff       	call   801036d0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80104701:	8b 35 a4 5b 11 80    	mov    0x80115ba4,%esi
80104707:	85 f6                	test   %esi,%esi
80104709:	7e 2a                	jle    80104735 <mycpu+0x45>
8010470b:	31 d2                	xor    %edx,%edx
8010470d:	eb 08                	jmp    80104717 <mycpu+0x27>
8010470f:	90                   	nop
80104710:	83 c2 01             	add    $0x1,%edx
80104713:	39 f2                	cmp    %esi,%edx
80104715:	74 1e                	je     80104735 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80104717:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
8010471d:	0f b6 99 c0 5b 11 80 	movzbl -0x7feea440(%ecx),%ebx
80104724:	39 c3                	cmp    %eax,%ebx
80104726:	75 e8                	jne    80104710 <mycpu+0x20>
}
80104728:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
8010472b:	8d 81 c0 5b 11 80    	lea    -0x7feea440(%ecx),%eax
}
80104731:	5b                   	pop    %ebx
80104732:	5e                   	pop    %esi
80104733:	5d                   	pop    %ebp
80104734:	c3                   	ret
  panic("unknown apicid\n");
80104735:	83 ec 0c             	sub    $0xc,%esp
80104738:	68 9c 89 10 80       	push   $0x8010899c
8010473d:	e8 5e bc ff ff       	call   801003a0 <panic>
    panic("mycpu called with interrupts enabled\n");
80104742:	83 ec 0c             	sub    $0xc,%esp
80104745:	68 b8 8d 10 80       	push   $0x80108db8
8010474a:	e8 51 bc ff ff       	call   801003a0 <panic>
8010474f:	90                   	nop

80104750 <cpuid>:
cpuid() {
80104750:	55                   	push   %ebp
80104751:	89 e5                	mov    %esp,%ebp
80104753:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80104756:	e8 95 ff ff ff       	call   801046f0 <mycpu>
}
8010475b:	c9                   	leave
  return mycpu()-cpus;
8010475c:	2d c0 5b 11 80       	sub    $0x80115bc0,%eax
80104761:	c1 f8 04             	sar    $0x4,%eax
80104764:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010476a:	c3                   	ret
8010476b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104770 <myproc>:
myproc(void) {
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
80104773:	53                   	push   %ebx
80104774:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104777:	e8 f4 0a 00 00       	call   80105270 <pushcli>
  c = mycpu();
8010477c:	e8 6f ff ff ff       	call   801046f0 <mycpu>
  p = c->proc;
80104781:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104787:	e8 34 0b 00 00       	call   801052c0 <popcli>
}
8010478c:	89 d8                	mov    %ebx,%eax
8010478e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104791:	c9                   	leave
80104792:	c3                   	ret
80104793:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010479a:	00 
8010479b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801047a0 <userinit>:
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	53                   	push   %ebx
801047a4:	83 ec 10             	sub    $0x10,%esp
  cprintf("hehe");
801047a7:	68 ac 89 10 80       	push   $0x801089ac
801047ac:	e8 8f c4 ff ff       	call   80100c40 <cprintf>
  p = allocproc();
801047b1:	e8 ea fd ff ff       	call   801045a0 <allocproc>
801047b6:	89 c3                	mov    %eax,%ebx
  initproc = p;
801047b8:	a3 74 81 11 80       	mov    %eax,0x80118174
  if((p->pgdir = setupkvm()) == 0)
801047bd:	e8 de 3b 00 00       	call   801083a0 <setupkvm>
801047c2:	83 c4 10             	add    $0x10,%esp
801047c5:	89 43 04             	mov    %eax,0x4(%ebx)
801047c8:	85 c0                	test   %eax,%eax
801047ca:	0f 84 c1 00 00 00    	je     80104891 <userinit+0xf1>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801047d0:	83 ec 04             	sub    $0x4,%esp
801047d3:	68 2c 00 00 00       	push   $0x2c
801047d8:	68 60 c4 10 80       	push   $0x8010c460
801047dd:	50                   	push   %eax
801047de:	e8 9d 38 00 00       	call   80108080 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801047e3:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801047e6:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801047ec:	6a 4c                	push   $0x4c
801047ee:	6a 00                	push   $0x0
801047f0:	ff 73 18             	push   0x18(%ebx)
801047f3:	e8 c8 0c 00 00       	call   801054c0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801047f8:	8b 43 18             	mov    0x18(%ebx),%eax
801047fb:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104800:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104803:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80104808:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010480c:	8b 43 18             	mov    0x18(%ebx),%eax
8010480f:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80104813:	8b 43 18             	mov    0x18(%ebx),%eax
80104816:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010481a:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
8010481e:	8b 43 18             	mov    0x18(%ebx),%eax
80104821:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104825:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80104829:	8b 43 18             	mov    0x18(%ebx),%eax
8010482c:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104833:	8b 43 18             	mov    0x18(%ebx),%eax
80104836:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
8010483d:	8b 43 18             	mov    0x18(%ebx),%eax
80104840:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104847:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010484a:	6a 10                	push   $0x10
8010484c:	68 ca 89 10 80       	push   $0x801089ca
80104851:	50                   	push   %eax
80104852:	e8 19 0e 00 00       	call   80105670 <safestrcpy>
  p->cwd = namei("/");
80104857:	c7 04 24 d3 89 10 80 	movl   $0x801089d3,(%esp)
8010485e:	e8 0d e6 ff ff       	call   80102e70 <namei>
80104863:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80104866:	c7 04 24 40 61 11 80 	movl   $0x80116140,(%esp)
8010486d:	e8 4e 0b 00 00       	call   801053c0 <acquire>
  p->state = RUNNABLE;
80104872:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80104879:	c7 04 24 40 61 11 80 	movl   $0x80116140,(%esp)
80104880:	e8 db 0a 00 00       	call   80105360 <release>
}
80104885:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  userinit_extra();
80104888:	83 c4 10             	add    $0x10,%esp
}
8010488b:	c9                   	leave
  userinit_extra();
8010488c:	e9 cf d1 ff ff       	jmp    80101a60 <userinit_extra>
    panic("userinit: out of memory?");
80104891:	83 ec 0c             	sub    $0xc,%esp
80104894:	68 b1 89 10 80       	push   $0x801089b1
80104899:	e8 02 bb ff ff       	call   801003a0 <panic>
8010489e:	66 90                	xchg   %ax,%ax

801048a0 <growproc>:
{
801048a0:	55                   	push   %ebp
801048a1:	89 e5                	mov    %esp,%ebp
801048a3:	56                   	push   %esi
801048a4:	53                   	push   %ebx
801048a5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801048a8:	e8 c3 09 00 00       	call   80105270 <pushcli>
  c = mycpu();
801048ad:	e8 3e fe ff ff       	call   801046f0 <mycpu>
  p = c->proc;
801048b2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801048b8:	e8 03 0a 00 00       	call   801052c0 <popcli>
  sz = curproc->sz;
801048bd:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
801048bf:	85 f6                	test   %esi,%esi
801048c1:	7f 1d                	jg     801048e0 <growproc+0x40>
  } else if(n < 0){
801048c3:	75 3b                	jne    80104900 <growproc+0x60>
  switchuvm(curproc);
801048c5:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
801048c8:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801048ca:	53                   	push   %ebx
801048cb:	e8 a0 36 00 00       	call   80107f70 <switchuvm>
  return 0;
801048d0:	83 c4 10             	add    $0x10,%esp
801048d3:	31 c0                	xor    %eax,%eax
}
801048d5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048d8:	5b                   	pop    %ebx
801048d9:	5e                   	pop    %esi
801048da:	5d                   	pop    %ebp
801048db:	c3                   	ret
801048dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801048e0:	83 ec 04             	sub    $0x4,%esp
801048e3:	01 c6                	add    %eax,%esi
801048e5:	56                   	push   %esi
801048e6:	50                   	push   %eax
801048e7:	ff 73 04             	push   0x4(%ebx)
801048ea:	e8 e1 38 00 00       	call   801081d0 <allocuvm>
801048ef:	83 c4 10             	add    $0x10,%esp
801048f2:	85 c0                	test   %eax,%eax
801048f4:	75 cf                	jne    801048c5 <growproc+0x25>
      return -1;
801048f6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801048fb:	eb d8                	jmp    801048d5 <growproc+0x35>
801048fd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104900:	83 ec 04             	sub    $0x4,%esp
80104903:	01 c6                	add    %eax,%esi
80104905:	56                   	push   %esi
80104906:	50                   	push   %eax
80104907:	ff 73 04             	push   0x4(%ebx)
8010490a:	e8 e1 39 00 00       	call   801082f0 <deallocuvm>
8010490f:	83 c4 10             	add    $0x10,%esp
80104912:	85 c0                	test   %eax,%eax
80104914:	75 af                	jne    801048c5 <growproc+0x25>
80104916:	eb de                	jmp    801048f6 <growproc+0x56>
80104918:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010491f:	00 

80104920 <fork>:
{
80104920:	55                   	push   %ebp
80104921:	89 e5                	mov    %esp,%ebp
80104923:	57                   	push   %edi
80104924:	56                   	push   %esi
80104925:	53                   	push   %ebx
80104926:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104929:	e8 42 09 00 00       	call   80105270 <pushcli>
  c = mycpu();
8010492e:	e8 bd fd ff ff       	call   801046f0 <mycpu>
  p = c->proc;
80104933:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104939:	e8 82 09 00 00       	call   801052c0 <popcli>
  if((np = allocproc()) == 0){
8010493e:	e8 5d fc ff ff       	call   801045a0 <allocproc>
80104943:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104946:	85 c0                	test   %eax,%eax
80104948:	0f 84 d6 00 00 00    	je     80104a24 <fork+0x104>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
8010494e:	83 ec 08             	sub    $0x8,%esp
80104951:	ff 33                	push   (%ebx)
80104953:	89 c7                	mov    %eax,%edi
80104955:	ff 73 04             	push   0x4(%ebx)
80104958:	e8 33 3b 00 00       	call   80108490 <copyuvm>
8010495d:	83 c4 10             	add    $0x10,%esp
80104960:	89 47 04             	mov    %eax,0x4(%edi)
80104963:	85 c0                	test   %eax,%eax
80104965:	0f 84 9a 00 00 00    	je     80104a05 <fork+0xe5>
  np->sz = curproc->sz;
8010496b:	8b 03                	mov    (%ebx),%eax
8010496d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104970:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80104972:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80104975:	89 c8                	mov    %ecx,%eax
80104977:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
8010497a:	b9 13 00 00 00       	mov    $0x13,%ecx
8010497f:	8b 73 18             	mov    0x18(%ebx),%esi
80104982:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80104984:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80104986:	8b 40 18             	mov    0x18(%eax),%eax
80104989:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80104990:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80104994:	85 c0                	test   %eax,%eax
80104996:	74 13                	je     801049ab <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104998:	83 ec 0c             	sub    $0xc,%esp
8010499b:	50                   	push   %eax
8010499c:	e8 9f cd ff ff       	call   80101740 <filedup>
801049a1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801049a4:	83 c4 10             	add    $0x10,%esp
801049a7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
801049ab:	83 c6 01             	add    $0x1,%esi
801049ae:	83 fe 10             	cmp    $0x10,%esi
801049b1:	75 dd                	jne    80104990 <fork+0x70>
  np->cwd = idup(curproc->cwd);
801049b3:	83 ec 0c             	sub    $0xc,%esp
801049b6:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801049b9:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
801049bc:	e8 9f db ff ff       	call   80102560 <idup>
801049c1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801049c4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
801049c7:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801049ca:	8d 47 6c             	lea    0x6c(%edi),%eax
801049cd:	6a 10                	push   $0x10
801049cf:	53                   	push   %ebx
801049d0:	50                   	push   %eax
801049d1:	e8 9a 0c 00 00       	call   80105670 <safestrcpy>
  pid = np->pid;
801049d6:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
801049d9:	c7 04 24 40 61 11 80 	movl   $0x80116140,(%esp)
801049e0:	e8 db 09 00 00       	call   801053c0 <acquire>
  np->state = RUNNABLE;
801049e5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
801049ec:	c7 04 24 40 61 11 80 	movl   $0x80116140,(%esp)
801049f3:	e8 68 09 00 00       	call   80105360 <release>
  return pid;
801049f8:	83 c4 10             	add    $0x10,%esp
}
801049fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801049fe:	89 d8                	mov    %ebx,%eax
80104a00:	5b                   	pop    %ebx
80104a01:	5e                   	pop    %esi
80104a02:	5f                   	pop    %edi
80104a03:	5d                   	pop    %ebp
80104a04:	c3                   	ret
    kfree(np->kstack);
80104a05:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80104a08:	83 ec 0c             	sub    $0xc,%esp
80104a0b:	ff 73 08             	push   0x8(%ebx)
80104a0e:	e8 7d e8 ff ff       	call   80103290 <kfree>
    np->kstack = 0;
80104a13:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80104a1a:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80104a1d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80104a24:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104a29:	eb d0                	jmp    801049fb <fork+0xdb>
80104a2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104a30 <scheduler>:
{
80104a30:	55                   	push   %ebp
80104a31:	89 e5                	mov    %esp,%ebp
80104a33:	57                   	push   %edi
80104a34:	56                   	push   %esi
80104a35:	53                   	push   %ebx
80104a36:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80104a39:	e8 b2 fc ff ff       	call   801046f0 <mycpu>
  c->proc = 0;
80104a3e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104a45:	00 00 00 
  struct cpu *c = mycpu();
80104a48:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80104a4a:	8d 78 04             	lea    0x4(%eax),%edi
80104a4d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80104a50:	fb                   	sti
    acquire(&ptable.lock);
80104a51:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a54:	bb 74 61 11 80       	mov    $0x80116174,%ebx
    acquire(&ptable.lock);
80104a59:	68 40 61 11 80       	push   $0x80116140
80104a5e:	e8 5d 09 00 00       	call   801053c0 <acquire>
80104a63:	83 c4 10             	add    $0x10,%esp
80104a66:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a6d:	00 
80104a6e:	66 90                	xchg   %ax,%ax
      if(p->state != RUNNABLE)
80104a70:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104a74:	75 33                	jne    80104aa9 <scheduler+0x79>
      switchuvm(p);
80104a76:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80104a79:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80104a7f:	53                   	push   %ebx
80104a80:	e8 eb 34 00 00       	call   80107f70 <switchuvm>
      swtch(&(c->scheduler), p->context);
80104a85:	58                   	pop    %eax
80104a86:	5a                   	pop    %edx
80104a87:	ff 73 1c             	push   0x1c(%ebx)
80104a8a:	57                   	push   %edi
      p->state = RUNNING;
80104a8b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80104a92:	e8 34 0c 00 00       	call   801056cb <swtch>
      switchkvm();
80104a97:	e8 c4 34 00 00       	call   80107f60 <switchkvm>
      c->proc = 0;
80104a9c:	83 c4 10             	add    $0x10,%esp
80104a9f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104aa6:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104aa9:	83 eb 80             	sub    $0xffffff80,%ebx
80104aac:	81 fb 74 81 11 80    	cmp    $0x80118174,%ebx
80104ab2:	75 bc                	jne    80104a70 <scheduler+0x40>
    release(&ptable.lock);
80104ab4:	83 ec 0c             	sub    $0xc,%esp
80104ab7:	68 40 61 11 80       	push   $0x80116140
80104abc:	e8 9f 08 00 00       	call   80105360 <release>
    sti();
80104ac1:	83 c4 10             	add    $0x10,%esp
80104ac4:	eb 8a                	jmp    80104a50 <scheduler+0x20>
80104ac6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104acd:	00 
80104ace:	66 90                	xchg   %ax,%ax

80104ad0 <sched>:
{
80104ad0:	55                   	push   %ebp
80104ad1:	89 e5                	mov    %esp,%ebp
80104ad3:	56                   	push   %esi
80104ad4:	53                   	push   %ebx
  pushcli();
80104ad5:	e8 96 07 00 00       	call   80105270 <pushcli>
  c = mycpu();
80104ada:	e8 11 fc ff ff       	call   801046f0 <mycpu>
  p = c->proc;
80104adf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104ae5:	e8 d6 07 00 00       	call   801052c0 <popcli>
  if(!holding(&ptable.lock))
80104aea:	83 ec 0c             	sub    $0xc,%esp
80104aed:	68 40 61 11 80       	push   $0x80116140
80104af2:	e8 29 08 00 00       	call   80105320 <holding>
80104af7:	83 c4 10             	add    $0x10,%esp
80104afa:	85 c0                	test   %eax,%eax
80104afc:	74 4f                	je     80104b4d <sched+0x7d>
  if(mycpu()->ncli != 1)
80104afe:	e8 ed fb ff ff       	call   801046f0 <mycpu>
80104b03:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80104b0a:	75 68                	jne    80104b74 <sched+0xa4>
  if(p->state == RUNNING)
80104b0c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104b10:	74 55                	je     80104b67 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104b12:	9c                   	pushf
80104b13:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104b14:	f6 c4 02             	test   $0x2,%ah
80104b17:	75 41                	jne    80104b5a <sched+0x8a>
  intena = mycpu()->intena;
80104b19:	e8 d2 fb ff ff       	call   801046f0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80104b1e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104b21:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104b27:	e8 c4 fb ff ff       	call   801046f0 <mycpu>
80104b2c:	83 ec 08             	sub    $0x8,%esp
80104b2f:	ff 70 04             	push   0x4(%eax)
80104b32:	53                   	push   %ebx
80104b33:	e8 93 0b 00 00       	call   801056cb <swtch>
  mycpu()->intena = intena;
80104b38:	e8 b3 fb ff ff       	call   801046f0 <mycpu>
}
80104b3d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104b40:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104b46:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b49:	5b                   	pop    %ebx
80104b4a:	5e                   	pop    %esi
80104b4b:	5d                   	pop    %ebp
80104b4c:	c3                   	ret
    panic("sched ptable.lock");
80104b4d:	83 ec 0c             	sub    $0xc,%esp
80104b50:	68 d5 89 10 80       	push   $0x801089d5
80104b55:	e8 46 b8 ff ff       	call   801003a0 <panic>
    panic("sched interruptible");
80104b5a:	83 ec 0c             	sub    $0xc,%esp
80104b5d:	68 01 8a 10 80       	push   $0x80108a01
80104b62:	e8 39 b8 ff ff       	call   801003a0 <panic>
    panic("sched running");
80104b67:	83 ec 0c             	sub    $0xc,%esp
80104b6a:	68 f3 89 10 80       	push   $0x801089f3
80104b6f:	e8 2c b8 ff ff       	call   801003a0 <panic>
    panic("sched locks");
80104b74:	83 ec 0c             	sub    $0xc,%esp
80104b77:	68 e7 89 10 80       	push   $0x801089e7
80104b7c:	e8 1f b8 ff ff       	call   801003a0 <panic>
80104b81:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b88:	00 
80104b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104b90 <exit>:
{
80104b90:	55                   	push   %ebp
80104b91:	89 e5                	mov    %esp,%ebp
80104b93:	57                   	push   %edi
80104b94:	56                   	push   %esi
80104b95:	53                   	push   %ebx
80104b96:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80104b99:	e8 d2 fb ff ff       	call   80104770 <myproc>
  if(curproc == initproc)
80104b9e:	39 05 74 81 11 80    	cmp    %eax,0x80118174
80104ba4:	0f 84 fd 00 00 00    	je     80104ca7 <exit+0x117>
80104baa:	89 c3                	mov    %eax,%ebx
80104bac:	8d 70 28             	lea    0x28(%eax),%esi
80104baf:	8d 78 68             	lea    0x68(%eax),%edi
80104bb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80104bb8:	8b 06                	mov    (%esi),%eax
80104bba:	85 c0                	test   %eax,%eax
80104bbc:	74 12                	je     80104bd0 <exit+0x40>
      fileclose(curproc->ofile[fd]);
80104bbe:	83 ec 0c             	sub    $0xc,%esp
80104bc1:	50                   	push   %eax
80104bc2:	e8 c9 cb ff ff       	call   80101790 <fileclose>
      curproc->ofile[fd] = 0;
80104bc7:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80104bcd:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104bd0:	83 c6 04             	add    $0x4,%esi
80104bd3:	39 f7                	cmp    %esi,%edi
80104bd5:	75 e1                	jne    80104bb8 <exit+0x28>
  begin_op();
80104bd7:	e8 64 ef ff ff       	call   80103b40 <begin_op>
  iput(curproc->cwd);
80104bdc:	83 ec 0c             	sub    $0xc,%esp
80104bdf:	ff 73 68             	push   0x68(%ebx)
80104be2:	e8 d9 da ff ff       	call   801026c0 <iput>
  end_op();
80104be7:	e8 c4 ef ff ff       	call   80103bb0 <end_op>
  curproc->cwd = 0;
80104bec:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80104bf3:	c7 04 24 40 61 11 80 	movl   $0x80116140,(%esp)
80104bfa:	e8 c1 07 00 00       	call   801053c0 <acquire>
  wakeup1(curproc->parent);
80104bff:	8b 53 14             	mov    0x14(%ebx),%edx
80104c02:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c05:	b8 74 61 11 80       	mov    $0x80116174,%eax
80104c0a:	eb 0e                	jmp    80104c1a <exit+0x8a>
80104c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c10:	83 e8 80             	sub    $0xffffff80,%eax
80104c13:	3d 74 81 11 80       	cmp    $0x80118174,%eax
80104c18:	74 1c                	je     80104c36 <exit+0xa6>
    if(p->state == SLEEPING && p->chan == chan)
80104c1a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104c1e:	75 f0                	jne    80104c10 <exit+0x80>
80104c20:	3b 50 20             	cmp    0x20(%eax),%edx
80104c23:	75 eb                	jne    80104c10 <exit+0x80>
      p->state = RUNNABLE;
80104c25:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c2c:	83 e8 80             	sub    $0xffffff80,%eax
80104c2f:	3d 74 81 11 80       	cmp    $0x80118174,%eax
80104c34:	75 e4                	jne    80104c1a <exit+0x8a>
      p->parent = initproc;
80104c36:	8b 0d 74 81 11 80    	mov    0x80118174,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c3c:	ba 74 61 11 80       	mov    $0x80116174,%edx
80104c41:	eb 10                	jmp    80104c53 <exit+0xc3>
80104c43:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c48:	83 ea 80             	sub    $0xffffff80,%edx
80104c4b:	81 fa 74 81 11 80    	cmp    $0x80118174,%edx
80104c51:	74 3b                	je     80104c8e <exit+0xfe>
    if(p->parent == curproc){
80104c53:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104c56:	75 f0                	jne    80104c48 <exit+0xb8>
      if(p->state == ZOMBIE)
80104c58:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104c5c:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80104c5f:	75 e7                	jne    80104c48 <exit+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c61:	b8 74 61 11 80       	mov    $0x80116174,%eax
80104c66:	eb 12                	jmp    80104c7a <exit+0xea>
80104c68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c6f:	00 
80104c70:	83 e8 80             	sub    $0xffffff80,%eax
80104c73:	3d 74 81 11 80       	cmp    $0x80118174,%eax
80104c78:	74 ce                	je     80104c48 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
80104c7a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104c7e:	75 f0                	jne    80104c70 <exit+0xe0>
80104c80:	3b 48 20             	cmp    0x20(%eax),%ecx
80104c83:	75 eb                	jne    80104c70 <exit+0xe0>
      p->state = RUNNABLE;
80104c85:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104c8c:	eb e2                	jmp    80104c70 <exit+0xe0>
  curproc->state = ZOMBIE;
80104c8e:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80104c95:	e8 36 fe ff ff       	call   80104ad0 <sched>
  panic("zombie exit");
80104c9a:	83 ec 0c             	sub    $0xc,%esp
80104c9d:	68 22 8a 10 80       	push   $0x80108a22
80104ca2:	e8 f9 b6 ff ff       	call   801003a0 <panic>
    panic("init exiting");
80104ca7:	83 ec 0c             	sub    $0xc,%esp
80104caa:	68 15 8a 10 80       	push   $0x80108a15
80104caf:	e8 ec b6 ff ff       	call   801003a0 <panic>
80104cb4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104cbb:	00 
80104cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104cc0 <wait>:
{
80104cc0:	55                   	push   %ebp
80104cc1:	89 e5                	mov    %esp,%ebp
80104cc3:	56                   	push   %esi
80104cc4:	53                   	push   %ebx
  pushcli();
80104cc5:	e8 a6 05 00 00       	call   80105270 <pushcli>
  c = mycpu();
80104cca:	e8 21 fa ff ff       	call   801046f0 <mycpu>
  p = c->proc;
80104ccf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104cd5:	e8 e6 05 00 00       	call   801052c0 <popcli>
  acquire(&ptable.lock);
80104cda:	83 ec 0c             	sub    $0xc,%esp
80104cdd:	68 40 61 11 80       	push   $0x80116140
80104ce2:	e8 d9 06 00 00       	call   801053c0 <acquire>
80104ce7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80104cea:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104cec:	bb 74 61 11 80       	mov    $0x80116174,%ebx
80104cf1:	eb 10                	jmp    80104d03 <wait+0x43>
80104cf3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104cf8:	83 eb 80             	sub    $0xffffff80,%ebx
80104cfb:	81 fb 74 81 11 80    	cmp    $0x80118174,%ebx
80104d01:	74 1b                	je     80104d1e <wait+0x5e>
      if(p->parent != curproc)
80104d03:	39 73 14             	cmp    %esi,0x14(%ebx)
80104d06:	75 f0                	jne    80104cf8 <wait+0x38>
      if(p->state == ZOMBIE){
80104d08:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104d0c:	74 62                	je     80104d70 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d0e:	83 eb 80             	sub    $0xffffff80,%ebx
      havekids = 1;
80104d11:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d16:	81 fb 74 81 11 80    	cmp    $0x80118174,%ebx
80104d1c:	75 e5                	jne    80104d03 <wait+0x43>
    if(!havekids || curproc->killed){
80104d1e:	85 c0                	test   %eax,%eax
80104d20:	0f 84 a0 00 00 00    	je     80104dc6 <wait+0x106>
80104d26:	8b 46 24             	mov    0x24(%esi),%eax
80104d29:	85 c0                	test   %eax,%eax
80104d2b:	0f 85 95 00 00 00    	jne    80104dc6 <wait+0x106>
  pushcli();
80104d31:	e8 3a 05 00 00       	call   80105270 <pushcli>
  c = mycpu();
80104d36:	e8 b5 f9 ff ff       	call   801046f0 <mycpu>
  p = c->proc;
80104d3b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104d41:	e8 7a 05 00 00       	call   801052c0 <popcli>
  if(p == 0)
80104d46:	85 db                	test   %ebx,%ebx
80104d48:	0f 84 8f 00 00 00    	je     80104ddd <wait+0x11d>
  p->chan = chan;
80104d4e:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104d51:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104d58:	e8 73 fd ff ff       	call   80104ad0 <sched>
  p->chan = 0;
80104d5d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104d64:	eb 84                	jmp    80104cea <wait+0x2a>
80104d66:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d6d:	00 
80104d6e:	66 90                	xchg   %ax,%ax
        kfree(p->kstack);
80104d70:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104d73:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104d76:	ff 73 08             	push   0x8(%ebx)
80104d79:	e8 12 e5 ff ff       	call   80103290 <kfree>
        p->kstack = 0;
80104d7e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104d85:	5a                   	pop    %edx
80104d86:	ff 73 04             	push   0x4(%ebx)
80104d89:	e8 92 35 00 00       	call   80108320 <freevm>
        p->pid = 0;
80104d8e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104d95:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104d9c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104da0:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104da7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104dae:	c7 04 24 40 61 11 80 	movl   $0x80116140,(%esp)
80104db5:	e8 a6 05 00 00       	call   80105360 <release>
        return pid;
80104dba:	83 c4 10             	add    $0x10,%esp
}
80104dbd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104dc0:	89 f0                	mov    %esi,%eax
80104dc2:	5b                   	pop    %ebx
80104dc3:	5e                   	pop    %esi
80104dc4:	5d                   	pop    %ebp
80104dc5:	c3                   	ret
      release(&ptable.lock);
80104dc6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104dc9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104dce:	68 40 61 11 80       	push   $0x80116140
80104dd3:	e8 88 05 00 00       	call   80105360 <release>
      return -1;
80104dd8:	83 c4 10             	add    $0x10,%esp
80104ddb:	eb e0                	jmp    80104dbd <wait+0xfd>
    panic("sleep");
80104ddd:	83 ec 0c             	sub    $0xc,%esp
80104de0:	68 2e 8a 10 80       	push   $0x80108a2e
80104de5:	e8 b6 b5 ff ff       	call   801003a0 <panic>
80104dea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104df0 <yield>:
{
80104df0:	55                   	push   %ebp
80104df1:	89 e5                	mov    %esp,%ebp
80104df3:	53                   	push   %ebx
80104df4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104df7:	68 40 61 11 80       	push   $0x80116140
80104dfc:	e8 bf 05 00 00       	call   801053c0 <acquire>
  pushcli();
80104e01:	e8 6a 04 00 00       	call   80105270 <pushcli>
  c = mycpu();
80104e06:	e8 e5 f8 ff ff       	call   801046f0 <mycpu>
  p = c->proc;
80104e0b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104e11:	e8 aa 04 00 00       	call   801052c0 <popcli>
  myproc()->state = RUNNABLE;
80104e16:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80104e1d:	e8 ae fc ff ff       	call   80104ad0 <sched>
  release(&ptable.lock);
80104e22:	c7 04 24 40 61 11 80 	movl   $0x80116140,(%esp)
80104e29:	e8 32 05 00 00       	call   80105360 <release>
}
80104e2e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e31:	83 c4 10             	add    $0x10,%esp
80104e34:	c9                   	leave
80104e35:	c3                   	ret
80104e36:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e3d:	00 
80104e3e:	66 90                	xchg   %ax,%ax

80104e40 <sleep>:
{
80104e40:	55                   	push   %ebp
80104e41:	89 e5                	mov    %esp,%ebp
80104e43:	57                   	push   %edi
80104e44:	56                   	push   %esi
80104e45:	53                   	push   %ebx
80104e46:	83 ec 0c             	sub    $0xc,%esp
80104e49:	8b 7d 08             	mov    0x8(%ebp),%edi
80104e4c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80104e4f:	e8 1c 04 00 00       	call   80105270 <pushcli>
  c = mycpu();
80104e54:	e8 97 f8 ff ff       	call   801046f0 <mycpu>
  p = c->proc;
80104e59:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104e5f:	e8 5c 04 00 00       	call   801052c0 <popcli>
  if(p == 0)
80104e64:	85 db                	test   %ebx,%ebx
80104e66:	0f 84 87 00 00 00    	je     80104ef3 <sleep+0xb3>
  if(lk == 0)
80104e6c:	85 f6                	test   %esi,%esi
80104e6e:	74 76                	je     80104ee6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104e70:	81 fe 40 61 11 80    	cmp    $0x80116140,%esi
80104e76:	74 50                	je     80104ec8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104e78:	83 ec 0c             	sub    $0xc,%esp
80104e7b:	68 40 61 11 80       	push   $0x80116140
80104e80:	e8 3b 05 00 00       	call   801053c0 <acquire>
    release(lk);
80104e85:	89 34 24             	mov    %esi,(%esp)
80104e88:	e8 d3 04 00 00       	call   80105360 <release>
  p->chan = chan;
80104e8d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104e90:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104e97:	e8 34 fc ff ff       	call   80104ad0 <sched>
  p->chan = 0;
80104e9c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104ea3:	c7 04 24 40 61 11 80 	movl   $0x80116140,(%esp)
80104eaa:	e8 b1 04 00 00       	call   80105360 <release>
    acquire(lk);
80104eaf:	83 c4 10             	add    $0x10,%esp
80104eb2:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104eb5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104eb8:	5b                   	pop    %ebx
80104eb9:	5e                   	pop    %esi
80104eba:	5f                   	pop    %edi
80104ebb:	5d                   	pop    %ebp
    acquire(lk);
80104ebc:	e9 ff 04 00 00       	jmp    801053c0 <acquire>
80104ec1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104ec8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104ecb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104ed2:	e8 f9 fb ff ff       	call   80104ad0 <sched>
  p->chan = 0;
80104ed7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104ede:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ee1:	5b                   	pop    %ebx
80104ee2:	5e                   	pop    %esi
80104ee3:	5f                   	pop    %edi
80104ee4:	5d                   	pop    %ebp
80104ee5:	c3                   	ret
    panic("sleep without lk");
80104ee6:	83 ec 0c             	sub    $0xc,%esp
80104ee9:	68 34 8a 10 80       	push   $0x80108a34
80104eee:	e8 ad b4 ff ff       	call   801003a0 <panic>
    panic("sleep");
80104ef3:	83 ec 0c             	sub    $0xc,%esp
80104ef6:	68 2e 8a 10 80       	push   $0x80108a2e
80104efb:	e8 a0 b4 ff ff       	call   801003a0 <panic>

80104f00 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104f00:	55                   	push   %ebp
80104f01:	89 e5                	mov    %esp,%ebp
80104f03:	53                   	push   %ebx
80104f04:	83 ec 10             	sub    $0x10,%esp
80104f07:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80104f0a:	68 40 61 11 80       	push   $0x80116140
80104f0f:	e8 ac 04 00 00       	call   801053c0 <acquire>
80104f14:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104f17:	b8 74 61 11 80       	mov    $0x80116174,%eax
80104f1c:	eb 0c                	jmp    80104f2a <wakeup+0x2a>
80104f1e:	66 90                	xchg   %ax,%ax
80104f20:	83 e8 80             	sub    $0xffffff80,%eax
80104f23:	3d 74 81 11 80       	cmp    $0x80118174,%eax
80104f28:	74 1c                	je     80104f46 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
80104f2a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104f2e:	75 f0                	jne    80104f20 <wakeup+0x20>
80104f30:	3b 58 20             	cmp    0x20(%eax),%ebx
80104f33:	75 eb                	jne    80104f20 <wakeup+0x20>
      p->state = RUNNABLE;
80104f35:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104f3c:	83 e8 80             	sub    $0xffffff80,%eax
80104f3f:	3d 74 81 11 80       	cmp    $0x80118174,%eax
80104f44:	75 e4                	jne    80104f2a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104f46:	c7 45 08 40 61 11 80 	movl   $0x80116140,0x8(%ebp)
}
80104f4d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f50:	c9                   	leave
  release(&ptable.lock);
80104f51:	e9 0a 04 00 00       	jmp    80105360 <release>
80104f56:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f5d:	00 
80104f5e:	66 90                	xchg   %ax,%ax

80104f60 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104f60:	55                   	push   %ebp
80104f61:	89 e5                	mov    %esp,%ebp
80104f63:	53                   	push   %ebx
80104f64:	83 ec 10             	sub    $0x10,%esp
80104f67:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80104f6a:	68 40 61 11 80       	push   $0x80116140
80104f6f:	e8 4c 04 00 00       	call   801053c0 <acquire>
80104f74:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104f77:	b8 74 61 11 80       	mov    $0x80116174,%eax
80104f7c:	eb 0c                	jmp    80104f8a <kill+0x2a>
80104f7e:	66 90                	xchg   %ax,%ax
80104f80:	83 e8 80             	sub    $0xffffff80,%eax
80104f83:	3d 74 81 11 80       	cmp    $0x80118174,%eax
80104f88:	74 36                	je     80104fc0 <kill+0x60>
    if(p->pid == pid){
80104f8a:	39 58 10             	cmp    %ebx,0x10(%eax)
80104f8d:	75 f1                	jne    80104f80 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104f8f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104f93:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
80104f9a:	75 07                	jne    80104fa3 <kill+0x43>
        p->state = RUNNABLE;
80104f9c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104fa3:	83 ec 0c             	sub    $0xc,%esp
80104fa6:	68 40 61 11 80       	push   $0x80116140
80104fab:	e8 b0 03 00 00       	call   80105360 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104fb0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104fb3:	83 c4 10             	add    $0x10,%esp
80104fb6:	31 c0                	xor    %eax,%eax
}
80104fb8:	c9                   	leave
80104fb9:	c3                   	ret
80104fba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104fc0:	83 ec 0c             	sub    $0xc,%esp
80104fc3:	68 40 61 11 80       	push   $0x80116140
80104fc8:	e8 93 03 00 00       	call   80105360 <release>
}
80104fcd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104fd0:	83 c4 10             	add    $0x10,%esp
80104fd3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104fd8:	c9                   	leave
80104fd9:	c3                   	ret
80104fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104fe0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104fe0:	55                   	push   %ebp
80104fe1:	89 e5                	mov    %esp,%ebp
80104fe3:	57                   	push   %edi
80104fe4:	56                   	push   %esi
80104fe5:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104fe8:	53                   	push   %ebx
80104fe9:	bb e0 61 11 80       	mov    $0x801161e0,%ebx
80104fee:	83 ec 3c             	sub    $0x3c,%esp
80104ff1:	eb 24                	jmp    80105017 <procdump+0x37>
80104ff3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104ff8:	83 ec 0c             	sub    $0xc,%esp
80104ffb:	68 5b 8c 10 80       	push   $0x80108c5b
80105000:	e8 3b bc ff ff       	call   80100c40 <cprintf>
80105005:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105008:	83 eb 80             	sub    $0xffffff80,%ebx
8010500b:	81 fb e0 81 11 80    	cmp    $0x801181e0,%ebx
80105011:	0f 84 81 00 00 00    	je     80105098 <procdump+0xb8>
    if(p->state == UNUSED)
80105017:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010501a:	85 c0                	test   %eax,%eax
8010501c:	74 ea                	je     80105008 <procdump+0x28>
      state = "???";
8010501e:	ba 45 8a 10 80       	mov    $0x80108a45,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80105023:	83 f8 05             	cmp    $0x5,%eax
80105026:	77 11                	ja     80105039 <procdump+0x59>
80105028:	8b 14 85 c0 90 10 80 	mov    -0x7fef6f40(,%eax,4),%edx
      state = "???";
8010502f:	b8 45 8a 10 80       	mov    $0x80108a45,%eax
80105034:	85 d2                	test   %edx,%edx
80105036:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80105039:	53                   	push   %ebx
8010503a:	52                   	push   %edx
8010503b:	ff 73 a4             	push   -0x5c(%ebx)
8010503e:	68 49 8a 10 80       	push   $0x80108a49
80105043:	e8 f8 bb ff ff       	call   80100c40 <cprintf>
    if(p->state == SLEEPING){
80105048:	83 c4 10             	add    $0x10,%esp
8010504b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010504f:	75 a7                	jne    80104ff8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80105051:	83 ec 08             	sub    $0x8,%esp
80105054:	8d 45 c0             	lea    -0x40(%ebp),%eax
80105057:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010505a:	50                   	push   %eax
8010505b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010505e:	8b 40 0c             	mov    0xc(%eax),%eax
80105061:	83 c0 08             	add    $0x8,%eax
80105064:	50                   	push   %eax
80105065:	e8 86 01 00 00       	call   801051f0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010506a:	83 c4 10             	add    $0x10,%esp
8010506d:	8d 76 00             	lea    0x0(%esi),%esi
80105070:	8b 17                	mov    (%edi),%edx
80105072:	85 d2                	test   %edx,%edx
80105074:	74 82                	je     80104ff8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80105076:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80105079:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010507c:	52                   	push   %edx
8010507d:	68 21 87 10 80       	push   $0x80108721
80105082:	e8 b9 bb ff ff       	call   80100c40 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80105087:	83 c4 10             	add    $0x10,%esp
8010508a:	39 f7                	cmp    %esi,%edi
8010508c:	75 e2                	jne    80105070 <procdump+0x90>
8010508e:	e9 65 ff ff ff       	jmp    80104ff8 <procdump+0x18>
80105093:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  }
}
80105098:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010509b:	5b                   	pop    %ebx
8010509c:	5e                   	pop    %esi
8010509d:	5f                   	pop    %edi
8010509e:	5d                   	pop    %ebp
8010509f:	c3                   	ret

801050a0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801050a0:	55                   	push   %ebp
801050a1:	89 e5                	mov    %esp,%ebp
801050a3:	53                   	push   %ebx
801050a4:	83 ec 0c             	sub    $0xc,%esp
801050a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801050aa:	68 7c 8a 10 80       	push   $0x80108a7c
801050af:	8d 43 04             	lea    0x4(%ebx),%eax
801050b2:	50                   	push   %eax
801050b3:	e8 18 01 00 00       	call   801051d0 <initlock>
  lk->name = name;
801050b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801050bb:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801050c1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801050c4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801050cb:	89 43 38             	mov    %eax,0x38(%ebx)
}
801050ce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801050d1:	c9                   	leave
801050d2:	c3                   	ret
801050d3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801050da:	00 
801050db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801050e0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801050e0:	55                   	push   %ebp
801050e1:	89 e5                	mov    %esp,%ebp
801050e3:	56                   	push   %esi
801050e4:	53                   	push   %ebx
801050e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801050e8:	8d 73 04             	lea    0x4(%ebx),%esi
801050eb:	83 ec 0c             	sub    $0xc,%esp
801050ee:	56                   	push   %esi
801050ef:	e8 cc 02 00 00       	call   801053c0 <acquire>
  while (lk->locked) {
801050f4:	8b 13                	mov    (%ebx),%edx
801050f6:	83 c4 10             	add    $0x10,%esp
801050f9:	85 d2                	test   %edx,%edx
801050fb:	74 16                	je     80105113 <acquiresleep+0x33>
801050fd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80105100:	83 ec 08             	sub    $0x8,%esp
80105103:	56                   	push   %esi
80105104:	53                   	push   %ebx
80105105:	e8 36 fd ff ff       	call   80104e40 <sleep>
  while (lk->locked) {
8010510a:	8b 03                	mov    (%ebx),%eax
8010510c:	83 c4 10             	add    $0x10,%esp
8010510f:	85 c0                	test   %eax,%eax
80105111:	75 ed                	jne    80105100 <acquiresleep+0x20>
  }
  lk->locked = 1;
80105113:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80105119:	e8 52 f6 ff ff       	call   80104770 <myproc>
8010511e:	8b 40 10             	mov    0x10(%eax),%eax
80105121:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80105124:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105127:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010512a:	5b                   	pop    %ebx
8010512b:	5e                   	pop    %esi
8010512c:	5d                   	pop    %ebp
  release(&lk->lk);
8010512d:	e9 2e 02 00 00       	jmp    80105360 <release>
80105132:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105139:	00 
8010513a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105140 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80105140:	55                   	push   %ebp
80105141:	89 e5                	mov    %esp,%ebp
80105143:	56                   	push   %esi
80105144:	53                   	push   %ebx
80105145:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105148:	8d 73 04             	lea    0x4(%ebx),%esi
8010514b:	83 ec 0c             	sub    $0xc,%esp
8010514e:	56                   	push   %esi
8010514f:	e8 6c 02 00 00       	call   801053c0 <acquire>
  lk->locked = 0;
80105154:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010515a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80105161:	89 1c 24             	mov    %ebx,(%esp)
80105164:	e8 97 fd ff ff       	call   80104f00 <wakeup>
  release(&lk->lk);
80105169:	83 c4 10             	add    $0x10,%esp
8010516c:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010516f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105172:	5b                   	pop    %ebx
80105173:	5e                   	pop    %esi
80105174:	5d                   	pop    %ebp
  release(&lk->lk);
80105175:	e9 e6 01 00 00       	jmp    80105360 <release>
8010517a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105180 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80105180:	55                   	push   %ebp
80105181:	89 e5                	mov    %esp,%ebp
80105183:	57                   	push   %edi
80105184:	31 ff                	xor    %edi,%edi
80105186:	56                   	push   %esi
80105187:	53                   	push   %ebx
80105188:	83 ec 18             	sub    $0x18,%esp
8010518b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010518e:	8d 73 04             	lea    0x4(%ebx),%esi
80105191:	56                   	push   %esi
80105192:	e8 29 02 00 00       	call   801053c0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80105197:	8b 03                	mov    (%ebx),%eax
80105199:	83 c4 10             	add    $0x10,%esp
8010519c:	85 c0                	test   %eax,%eax
8010519e:	75 18                	jne    801051b8 <holdingsleep+0x38>
  release(&lk->lk);
801051a0:	83 ec 0c             	sub    $0xc,%esp
801051a3:	56                   	push   %esi
801051a4:	e8 b7 01 00 00       	call   80105360 <release>
  return r;
}
801051a9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051ac:	89 f8                	mov    %edi,%eax
801051ae:	5b                   	pop    %ebx
801051af:	5e                   	pop    %esi
801051b0:	5f                   	pop    %edi
801051b1:	5d                   	pop    %ebp
801051b2:	c3                   	ret
801051b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
801051b8:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801051bb:	e8 b0 f5 ff ff       	call   80104770 <myproc>
801051c0:	39 58 10             	cmp    %ebx,0x10(%eax)
801051c3:	0f 94 c0             	sete   %al
801051c6:	0f b6 c0             	movzbl %al,%eax
801051c9:	89 c7                	mov    %eax,%edi
801051cb:	eb d3                	jmp    801051a0 <holdingsleep+0x20>
801051cd:	66 90                	xchg   %ax,%ax
801051cf:	90                   	nop

801051d0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801051d0:	55                   	push   %ebp
801051d1:	89 e5                	mov    %esp,%ebp
801051d3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801051d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801051d9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801051df:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801051e2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801051e9:	5d                   	pop    %ebp
801051ea:	c3                   	ret
801051eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801051f0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801051f0:	55                   	push   %ebp
801051f1:	89 e5                	mov    %esp,%ebp
801051f3:	53                   	push   %ebx
801051f4:	8b 45 08             	mov    0x8(%ebp),%eax
801051f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801051fa:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801051fd:	05 f8 ff ff 7f       	add    $0x7ffffff8,%eax
80105202:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
  for(i = 0; i < 10; i++){
80105207:	b8 00 00 00 00       	mov    $0x0,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
8010520c:	76 10                	jbe    8010521e <getcallerpcs+0x2e>
8010520e:	eb 28                	jmp    80105238 <getcallerpcs+0x48>
80105210:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80105216:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010521c:	77 1a                	ja     80105238 <getcallerpcs+0x48>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010521e:	8b 5a 04             	mov    0x4(%edx),%ebx
80105221:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80105224:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80105227:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80105229:	83 f8 0a             	cmp    $0xa,%eax
8010522c:	75 e2                	jne    80105210 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010522e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105231:	c9                   	leave
80105232:	c3                   	ret
80105233:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105238:	8d 04 81             	lea    (%ecx,%eax,4),%eax
8010523b:	83 c1 28             	add    $0x28,%ecx
8010523e:	89 ca                	mov    %ecx,%edx
80105240:	29 c2                	sub    %eax,%edx
80105242:	83 e2 04             	and    $0x4,%edx
80105245:	74 11                	je     80105258 <getcallerpcs+0x68>
    pcs[i] = 0;
80105247:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
8010524d:	83 c0 04             	add    $0x4,%eax
80105250:	39 c1                	cmp    %eax,%ecx
80105252:	74 da                	je     8010522e <getcallerpcs+0x3e>
80105254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
80105258:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
8010525e:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80105261:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80105268:	39 c1                	cmp    %eax,%ecx
8010526a:	75 ec                	jne    80105258 <getcallerpcs+0x68>
8010526c:	eb c0                	jmp    8010522e <getcallerpcs+0x3e>
8010526e:	66 90                	xchg   %ax,%ax

80105270 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105270:	55                   	push   %ebp
80105271:	89 e5                	mov    %esp,%ebp
80105273:	53                   	push   %ebx
80105274:	83 ec 04             	sub    $0x4,%esp
80105277:	9c                   	pushf
80105278:	5b                   	pop    %ebx
  asm volatile("cli");
80105279:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010527a:	e8 71 f4 ff ff       	call   801046f0 <mycpu>
8010527f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105285:	85 c0                	test   %eax,%eax
80105287:	74 17                	je     801052a0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80105289:	e8 62 f4 ff ff       	call   801046f0 <mycpu>
8010528e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80105295:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105298:	c9                   	leave
80105299:	c3                   	ret
8010529a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
801052a0:	e8 4b f4 ff ff       	call   801046f0 <mycpu>
801052a5:	81 e3 00 02 00 00    	and    $0x200,%ebx
801052ab:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
801052b1:	eb d6                	jmp    80105289 <pushcli+0x19>
801052b3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801052ba:	00 
801052bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801052c0 <popcli>:

void
popcli(void)
{
801052c0:	55                   	push   %ebp
801052c1:	89 e5                	mov    %esp,%ebp
801052c3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801052c6:	9c                   	pushf
801052c7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801052c8:	f6 c4 02             	test   $0x2,%ah
801052cb:	75 35                	jne    80105302 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801052cd:	e8 1e f4 ff ff       	call   801046f0 <mycpu>
801052d2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801052d9:	78 34                	js     8010530f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801052db:	e8 10 f4 ff ff       	call   801046f0 <mycpu>
801052e0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801052e6:	85 d2                	test   %edx,%edx
801052e8:	74 06                	je     801052f0 <popcli+0x30>
    sti();
}
801052ea:	c9                   	leave
801052eb:	c3                   	ret
801052ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801052f0:	e8 fb f3 ff ff       	call   801046f0 <mycpu>
801052f5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801052fb:	85 c0                	test   %eax,%eax
801052fd:	74 eb                	je     801052ea <popcli+0x2a>
  asm volatile("sti");
801052ff:	fb                   	sti
}
80105300:	c9                   	leave
80105301:	c3                   	ret
    panic("popcli - interruptible");
80105302:	83 ec 0c             	sub    $0xc,%esp
80105305:	68 87 8a 10 80       	push   $0x80108a87
8010530a:	e8 91 b0 ff ff       	call   801003a0 <panic>
    panic("popcli");
8010530f:	83 ec 0c             	sub    $0xc,%esp
80105312:	68 9e 8a 10 80       	push   $0x80108a9e
80105317:	e8 84 b0 ff ff       	call   801003a0 <panic>
8010531c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105320 <holding>:
{
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	56                   	push   %esi
80105324:	53                   	push   %ebx
80105325:	8b 75 08             	mov    0x8(%ebp),%esi
80105328:	31 db                	xor    %ebx,%ebx
  pushcli();
8010532a:	e8 41 ff ff ff       	call   80105270 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010532f:	8b 06                	mov    (%esi),%eax
80105331:	85 c0                	test   %eax,%eax
80105333:	75 0b                	jne    80105340 <holding+0x20>
  popcli();
80105335:	e8 86 ff ff ff       	call   801052c0 <popcli>
}
8010533a:	89 d8                	mov    %ebx,%eax
8010533c:	5b                   	pop    %ebx
8010533d:	5e                   	pop    %esi
8010533e:	5d                   	pop    %ebp
8010533f:	c3                   	ret
  r = lock->locked && lock->cpu == mycpu();
80105340:	8b 5e 08             	mov    0x8(%esi),%ebx
80105343:	e8 a8 f3 ff ff       	call   801046f0 <mycpu>
80105348:	39 c3                	cmp    %eax,%ebx
8010534a:	0f 94 c3             	sete   %bl
  popcli();
8010534d:	e8 6e ff ff ff       	call   801052c0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80105352:	0f b6 db             	movzbl %bl,%ebx
}
80105355:	89 d8                	mov    %ebx,%eax
80105357:	5b                   	pop    %ebx
80105358:	5e                   	pop    %esi
80105359:	5d                   	pop    %ebp
8010535a:	c3                   	ret
8010535b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105360 <release>:
{
80105360:	55                   	push   %ebp
80105361:	89 e5                	mov    %esp,%ebp
80105363:	56                   	push   %esi
80105364:	53                   	push   %ebx
80105365:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80105368:	e8 03 ff ff ff       	call   80105270 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010536d:	8b 03                	mov    (%ebx),%eax
8010536f:	85 c0                	test   %eax,%eax
80105371:	75 15                	jne    80105388 <release+0x28>
  popcli();
80105373:	e8 48 ff ff ff       	call   801052c0 <popcli>
    panic("release");
80105378:	83 ec 0c             	sub    $0xc,%esp
8010537b:	68 a5 8a 10 80       	push   $0x80108aa5
80105380:	e8 1b b0 ff ff       	call   801003a0 <panic>
80105385:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80105388:	8b 73 08             	mov    0x8(%ebx),%esi
8010538b:	e8 60 f3 ff ff       	call   801046f0 <mycpu>
80105390:	39 c6                	cmp    %eax,%esi
80105392:	75 df                	jne    80105373 <release+0x13>
  popcli();
80105394:	e8 27 ff ff ff       	call   801052c0 <popcli>
  lk->pcs[0] = 0;
80105399:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801053a0:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801053a7:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801053ac:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801053b2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801053b5:	5b                   	pop    %ebx
801053b6:	5e                   	pop    %esi
801053b7:	5d                   	pop    %ebp
  popcli();
801053b8:	e9 03 ff ff ff       	jmp    801052c0 <popcli>
801053bd:	8d 76 00             	lea    0x0(%esi),%esi

801053c0 <acquire>:
{
801053c0:	55                   	push   %ebp
801053c1:	89 e5                	mov    %esp,%ebp
801053c3:	53                   	push   %ebx
801053c4:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801053c7:	e8 a4 fe ff ff       	call   80105270 <pushcli>
  if(holding(lk))
801053cc:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801053cf:	e8 9c fe ff ff       	call   80105270 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801053d4:	8b 03                	mov    (%ebx),%eax
801053d6:	85 c0                	test   %eax,%eax
801053d8:	0f 85 b2 00 00 00    	jne    80105490 <acquire+0xd0>
  popcli();
801053de:	e8 dd fe ff ff       	call   801052c0 <popcli>
  asm volatile("lock; xchgl %0, %1" :
801053e3:	b9 01 00 00 00       	mov    $0x1,%ecx
801053e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801053ef:	00 
  while(xchg(&lk->locked, 1) != 0)
801053f0:	8b 55 08             	mov    0x8(%ebp),%edx
801053f3:	89 c8                	mov    %ecx,%eax
801053f5:	f0 87 02             	lock xchg %eax,(%edx)
801053f8:	85 c0                	test   %eax,%eax
801053fa:	75 f4                	jne    801053f0 <acquire+0x30>
  __sync_synchronize();
801053fc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80105401:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105404:	e8 e7 f2 ff ff       	call   801046f0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80105409:	8b 4d 08             	mov    0x8(%ebp),%ecx
  for(i = 0; i < 10; i++){
8010540c:	31 d2                	xor    %edx,%edx
  lk->cpu = mycpu();
8010540e:	89 43 08             	mov    %eax,0x8(%ebx)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105411:	8d 85 00 00 00 80    	lea    -0x80000000(%ebp),%eax
80105417:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
8010541c:	77 32                	ja     80105450 <acquire+0x90>
  ebp = (uint*)v - 2;
8010541e:	89 e8                	mov    %ebp,%eax
80105420:	eb 14                	jmp    80105436 <acquire+0x76>
80105422:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105428:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
8010542e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80105434:	77 1a                	ja     80105450 <acquire+0x90>
    pcs[i] = ebp[1];     // saved %eip
80105436:	8b 58 04             	mov    0x4(%eax),%ebx
80105439:	89 5c 91 0c          	mov    %ebx,0xc(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
8010543d:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105440:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105442:	83 fa 0a             	cmp    $0xa,%edx
80105445:	75 e1                	jne    80105428 <acquire+0x68>
}
80105447:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010544a:	c9                   	leave
8010544b:	c3                   	ret
8010544c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105450:	8d 44 91 0c          	lea    0xc(%ecx,%edx,4),%eax
80105454:	83 c1 34             	add    $0x34,%ecx
80105457:	89 ca                	mov    %ecx,%edx
80105459:	29 c2                	sub    %eax,%edx
8010545b:	83 e2 04             	and    $0x4,%edx
8010545e:	74 10                	je     80105470 <acquire+0xb0>
    pcs[i] = 0;
80105460:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105466:	83 c0 04             	add    $0x4,%eax
80105469:	39 c1                	cmp    %eax,%ecx
8010546b:	74 da                	je     80105447 <acquire+0x87>
8010546d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80105470:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105476:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80105479:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80105480:	39 c1                	cmp    %eax,%ecx
80105482:	75 ec                	jne    80105470 <acquire+0xb0>
80105484:	eb c1                	jmp    80105447 <acquire+0x87>
80105486:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010548d:	00 
8010548e:	66 90                	xchg   %ax,%ax
  r = lock->locked && lock->cpu == mycpu();
80105490:	8b 5b 08             	mov    0x8(%ebx),%ebx
80105493:	e8 58 f2 ff ff       	call   801046f0 <mycpu>
80105498:	39 c3                	cmp    %eax,%ebx
8010549a:	0f 85 3e ff ff ff    	jne    801053de <acquire+0x1e>
  popcli();
801054a0:	e8 1b fe ff ff       	call   801052c0 <popcli>
    panic("acquire");
801054a5:	83 ec 0c             	sub    $0xc,%esp
801054a8:	68 ad 8a 10 80       	push   $0x80108aad
801054ad:	e8 ee ae ff ff       	call   801003a0 <panic>
801054b2:	66 90                	xchg   %ax,%ax
801054b4:	66 90                	xchg   %ax,%ax
801054b6:	66 90                	xchg   %ax,%ax
801054b8:	66 90                	xchg   %ax,%ax
801054ba:	66 90                	xchg   %ax,%ax
801054bc:	66 90                	xchg   %ax,%ax
801054be:	66 90                	xchg   %ax,%ax

801054c0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801054c0:	55                   	push   %ebp
801054c1:	89 e5                	mov    %esp,%ebp
801054c3:	57                   	push   %edi
801054c4:	8b 55 08             	mov    0x8(%ebp),%edx
801054c7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801054ca:	89 d0                	mov    %edx,%eax
801054cc:	09 c8                	or     %ecx,%eax
801054ce:	a8 03                	test   $0x3,%al
801054d0:	75 1e                	jne    801054f0 <memset+0x30>
    c &= 0xFF;
801054d2:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801054d6:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
801054d9:	89 d7                	mov    %edx,%edi
801054db:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
801054e1:	fc                   	cld
801054e2:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
801054e4:	8b 7d fc             	mov    -0x4(%ebp),%edi
801054e7:	89 d0                	mov    %edx,%eax
801054e9:	c9                   	leave
801054ea:	c3                   	ret
801054eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
801054f0:	8b 45 0c             	mov    0xc(%ebp),%eax
801054f3:	89 d7                	mov    %edx,%edi
801054f5:	fc                   	cld
801054f6:	f3 aa                	rep stos %al,%es:(%edi)
801054f8:	8b 7d fc             	mov    -0x4(%ebp),%edi
801054fb:	89 d0                	mov    %edx,%eax
801054fd:	c9                   	leave
801054fe:	c3                   	ret
801054ff:	90                   	nop

80105500 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105500:	55                   	push   %ebp
80105501:	89 e5                	mov    %esp,%ebp
80105503:	56                   	push   %esi
80105504:	8b 75 10             	mov    0x10(%ebp),%esi
80105507:	8b 45 08             	mov    0x8(%ebp),%eax
8010550a:	53                   	push   %ebx
8010550b:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010550e:	85 f6                	test   %esi,%esi
80105510:	74 2e                	je     80105540 <memcmp+0x40>
80105512:	01 c6                	add    %eax,%esi
80105514:	eb 14                	jmp    8010552a <memcmp+0x2a>
80105516:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010551d:	00 
8010551e:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80105520:	83 c0 01             	add    $0x1,%eax
80105523:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80105526:	39 f0                	cmp    %esi,%eax
80105528:	74 16                	je     80105540 <memcmp+0x40>
    if(*s1 != *s2)
8010552a:	0f b6 08             	movzbl (%eax),%ecx
8010552d:	0f b6 1a             	movzbl (%edx),%ebx
80105530:	38 d9                	cmp    %bl,%cl
80105532:	74 ec                	je     80105520 <memcmp+0x20>
      return *s1 - *s2;
80105534:	0f b6 c1             	movzbl %cl,%eax
80105537:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80105539:	5b                   	pop    %ebx
8010553a:	5e                   	pop    %esi
8010553b:	5d                   	pop    %ebp
8010553c:	c3                   	ret
8010553d:	8d 76 00             	lea    0x0(%esi),%esi
80105540:	5b                   	pop    %ebx
  return 0;
80105541:	31 c0                	xor    %eax,%eax
}
80105543:	5e                   	pop    %esi
80105544:	5d                   	pop    %ebp
80105545:	c3                   	ret
80105546:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010554d:	00 
8010554e:	66 90                	xchg   %ax,%ax

80105550 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105550:	55                   	push   %ebp
80105551:	89 e5                	mov    %esp,%ebp
80105553:	57                   	push   %edi
80105554:	8b 55 08             	mov    0x8(%ebp),%edx
80105557:	8b 45 10             	mov    0x10(%ebp),%eax
8010555a:	56                   	push   %esi
8010555b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010555e:	39 d6                	cmp    %edx,%esi
80105560:	73 26                	jae    80105588 <memmove+0x38>
80105562:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80105565:	39 ca                	cmp    %ecx,%edx
80105567:	73 1f                	jae    80105588 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80105569:	85 c0                	test   %eax,%eax
8010556b:	74 0f                	je     8010557c <memmove+0x2c>
8010556d:	83 e8 01             	sub    $0x1,%eax
      *--d = *--s;
80105570:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80105574:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80105577:	83 e8 01             	sub    $0x1,%eax
8010557a:	73 f4                	jae    80105570 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010557c:	5e                   	pop    %esi
8010557d:	89 d0                	mov    %edx,%eax
8010557f:	5f                   	pop    %edi
80105580:	5d                   	pop    %ebp
80105581:	c3                   	ret
80105582:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80105588:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
8010558b:	89 d7                	mov    %edx,%edi
8010558d:	85 c0                	test   %eax,%eax
8010558f:	74 eb                	je     8010557c <memmove+0x2c>
80105591:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80105598:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80105599:	39 ce                	cmp    %ecx,%esi
8010559b:	75 fb                	jne    80105598 <memmove+0x48>
}
8010559d:	5e                   	pop    %esi
8010559e:	89 d0                	mov    %edx,%eax
801055a0:	5f                   	pop    %edi
801055a1:	5d                   	pop    %ebp
801055a2:	c3                   	ret
801055a3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801055aa:	00 
801055ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801055b0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
801055b0:	eb 9e                	jmp    80105550 <memmove>
801055b2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801055b9:	00 
801055ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801055c0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
801055c0:	55                   	push   %ebp
801055c1:	89 e5                	mov    %esp,%ebp
801055c3:	53                   	push   %ebx
801055c4:	8b 55 10             	mov    0x10(%ebp),%edx
801055c7:	8b 45 08             	mov    0x8(%ebp),%eax
801055ca:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
801055cd:	85 d2                	test   %edx,%edx
801055cf:	75 16                	jne    801055e7 <strncmp+0x27>
801055d1:	eb 2d                	jmp    80105600 <strncmp+0x40>
801055d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801055d8:	3a 19                	cmp    (%ecx),%bl
801055da:	75 12                	jne    801055ee <strncmp+0x2e>
    n--, p++, q++;
801055dc:	83 c0 01             	add    $0x1,%eax
801055df:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801055e2:	83 ea 01             	sub    $0x1,%edx
801055e5:	74 19                	je     80105600 <strncmp+0x40>
801055e7:	0f b6 18             	movzbl (%eax),%ebx
801055ea:	84 db                	test   %bl,%bl
801055ec:	75 ea                	jne    801055d8 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
801055ee:	0f b6 00             	movzbl (%eax),%eax
801055f1:	0f b6 11             	movzbl (%ecx),%edx
}
801055f4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801055f7:	c9                   	leave
  return (uchar)*p - (uchar)*q;
801055f8:	29 d0                	sub    %edx,%eax
}
801055fa:	c3                   	ret
801055fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105600:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80105603:	31 c0                	xor    %eax,%eax
}
80105605:	c9                   	leave
80105606:	c3                   	ret
80105607:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010560e:	00 
8010560f:	90                   	nop

80105610 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105610:	55                   	push   %ebp
80105611:	89 e5                	mov    %esp,%ebp
80105613:	57                   	push   %edi
80105614:	56                   	push   %esi
80105615:	8b 75 08             	mov    0x8(%ebp),%esi
80105618:	53                   	push   %ebx
80105619:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010561c:	89 f0                	mov    %esi,%eax
8010561e:	eb 15                	jmp    80105635 <strncpy+0x25>
80105620:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80105624:	8b 7d 0c             	mov    0xc(%ebp),%edi
80105627:	83 c0 01             	add    $0x1,%eax
8010562a:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
8010562e:	88 48 ff             	mov    %cl,-0x1(%eax)
80105631:	84 c9                	test   %cl,%cl
80105633:	74 13                	je     80105648 <strncpy+0x38>
80105635:	89 d3                	mov    %edx,%ebx
80105637:	83 ea 01             	sub    $0x1,%edx
8010563a:	85 db                	test   %ebx,%ebx
8010563c:	7f e2                	jg     80105620 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
8010563e:	5b                   	pop    %ebx
8010563f:	89 f0                	mov    %esi,%eax
80105641:	5e                   	pop    %esi
80105642:	5f                   	pop    %edi
80105643:	5d                   	pop    %ebp
80105644:	c3                   	ret
80105645:	8d 76 00             	lea    0x0(%esi),%esi
  while(n-- > 0)
80105648:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
8010564b:	83 e9 01             	sub    $0x1,%ecx
8010564e:	85 d2                	test   %edx,%edx
80105650:	74 ec                	je     8010563e <strncpy+0x2e>
80105652:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *s++ = 0;
80105658:	83 c0 01             	add    $0x1,%eax
8010565b:	89 ca                	mov    %ecx,%edx
8010565d:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
80105661:	29 c2                	sub    %eax,%edx
80105663:	85 d2                	test   %edx,%edx
80105665:	7f f1                	jg     80105658 <strncpy+0x48>
}
80105667:	5b                   	pop    %ebx
80105668:	89 f0                	mov    %esi,%eax
8010566a:	5e                   	pop    %esi
8010566b:	5f                   	pop    %edi
8010566c:	5d                   	pop    %ebp
8010566d:	c3                   	ret
8010566e:	66 90                	xchg   %ax,%ax

80105670 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105670:	55                   	push   %ebp
80105671:	89 e5                	mov    %esp,%ebp
80105673:	56                   	push   %esi
80105674:	8b 55 10             	mov    0x10(%ebp),%edx
80105677:	8b 75 08             	mov    0x8(%ebp),%esi
8010567a:	53                   	push   %ebx
8010567b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
8010567e:	85 d2                	test   %edx,%edx
80105680:	7e 25                	jle    801056a7 <safestrcpy+0x37>
80105682:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80105686:	89 f2                	mov    %esi,%edx
80105688:	eb 16                	jmp    801056a0 <safestrcpy+0x30>
8010568a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80105690:	0f b6 08             	movzbl (%eax),%ecx
80105693:	83 c0 01             	add    $0x1,%eax
80105696:	83 c2 01             	add    $0x1,%edx
80105699:	88 4a ff             	mov    %cl,-0x1(%edx)
8010569c:	84 c9                	test   %cl,%cl
8010569e:	74 04                	je     801056a4 <safestrcpy+0x34>
801056a0:	39 d8                	cmp    %ebx,%eax
801056a2:	75 ec                	jne    80105690 <safestrcpy+0x20>
    ;
  *s = 0;
801056a4:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
801056a7:	89 f0                	mov    %esi,%eax
801056a9:	5b                   	pop    %ebx
801056aa:	5e                   	pop    %esi
801056ab:	5d                   	pop    %ebp
801056ac:	c3                   	ret
801056ad:	8d 76 00             	lea    0x0(%esi),%esi

801056b0 <strlen>:

int
strlen(const char *s)
{
801056b0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801056b1:	31 c0                	xor    %eax,%eax
{
801056b3:	89 e5                	mov    %esp,%ebp
801056b5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
801056b8:	80 3a 00             	cmpb   $0x0,(%edx)
801056bb:	74 0c                	je     801056c9 <strlen+0x19>
801056bd:	8d 76 00             	lea    0x0(%esi),%esi
801056c0:	83 c0 01             	add    $0x1,%eax
801056c3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801056c7:	75 f7                	jne    801056c0 <strlen+0x10>
    ;
  return n;
}
801056c9:	5d                   	pop    %ebp
801056ca:	c3                   	ret

801056cb <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801056cb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801056cf:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801056d3:	55                   	push   %ebp
  pushl %ebx
801056d4:	53                   	push   %ebx
  pushl %esi
801056d5:	56                   	push   %esi
  pushl %edi
801056d6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801056d7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801056d9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801056db:	5f                   	pop    %edi
  popl %esi
801056dc:	5e                   	pop    %esi
  popl %ebx
801056dd:	5b                   	pop    %ebx
  popl %ebp
801056de:	5d                   	pop    %ebp
  ret
801056df:	c3                   	ret

801056e0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
801056e0:	55                   	push   %ebp
801056e1:	89 e5                	mov    %esp,%ebp
801056e3:	53                   	push   %ebx
801056e4:	83 ec 04             	sub    $0x4,%esp
801056e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
801056ea:	e8 81 f0 ff ff       	call   80104770 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
801056ef:	8b 00                	mov    (%eax),%eax
801056f1:	39 c3                	cmp    %eax,%ebx
801056f3:	73 1b                	jae    80105710 <fetchint+0x30>
801056f5:	8d 53 04             	lea    0x4(%ebx),%edx
801056f8:	39 d0                	cmp    %edx,%eax
801056fa:	72 14                	jb     80105710 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801056fc:	8b 45 0c             	mov    0xc(%ebp),%eax
801056ff:	8b 13                	mov    (%ebx),%edx
80105701:	89 10                	mov    %edx,(%eax)
  return 0;
80105703:	31 c0                	xor    %eax,%eax
}
80105705:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105708:	c9                   	leave
80105709:	c3                   	ret
8010570a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105710:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105715:	eb ee                	jmp    80105705 <fetchint+0x25>
80105717:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010571e:	00 
8010571f:	90                   	nop

80105720 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105720:	55                   	push   %ebp
80105721:	89 e5                	mov    %esp,%ebp
80105723:	53                   	push   %ebx
80105724:	83 ec 04             	sub    $0x4,%esp
80105727:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010572a:	e8 41 f0 ff ff       	call   80104770 <myproc>

  if(addr >= curproc->sz)
8010572f:	3b 18                	cmp    (%eax),%ebx
80105731:	73 2d                	jae    80105760 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80105733:	8b 55 0c             	mov    0xc(%ebp),%edx
80105736:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80105738:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010573a:	39 d3                	cmp    %edx,%ebx
8010573c:	73 22                	jae    80105760 <fetchstr+0x40>
8010573e:	89 d8                	mov    %ebx,%eax
80105740:	eb 0d                	jmp    8010574f <fetchstr+0x2f>
80105742:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105748:	83 c0 01             	add    $0x1,%eax
8010574b:	39 d0                	cmp    %edx,%eax
8010574d:	73 11                	jae    80105760 <fetchstr+0x40>
    if(*s == 0)
8010574f:	80 38 00             	cmpb   $0x0,(%eax)
80105752:	75 f4                	jne    80105748 <fetchstr+0x28>
      return s - *pp;
80105754:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80105756:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105759:	c9                   	leave
8010575a:	c3                   	ret
8010575b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105760:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80105763:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105768:	c9                   	leave
80105769:	c3                   	ret
8010576a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105770 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105770:	55                   	push   %ebp
80105771:	89 e5                	mov    %esp,%ebp
80105773:	56                   	push   %esi
80105774:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105775:	e8 f6 ef ff ff       	call   80104770 <myproc>
8010577a:	8b 55 08             	mov    0x8(%ebp),%edx
8010577d:	8b 40 18             	mov    0x18(%eax),%eax
80105780:	8b 40 44             	mov    0x44(%eax),%eax
80105783:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105786:	e8 e5 ef ff ff       	call   80104770 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010578b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010578e:	8b 00                	mov    (%eax),%eax
80105790:	39 c6                	cmp    %eax,%esi
80105792:	73 1c                	jae    801057b0 <argint+0x40>
80105794:	8d 53 08             	lea    0x8(%ebx),%edx
80105797:	39 d0                	cmp    %edx,%eax
80105799:	72 15                	jb     801057b0 <argint+0x40>
  *ip = *(int*)(addr);
8010579b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010579e:	8b 53 04             	mov    0x4(%ebx),%edx
801057a1:	89 10                	mov    %edx,(%eax)
  return 0;
801057a3:	31 c0                	xor    %eax,%eax
}
801057a5:	5b                   	pop    %ebx
801057a6:	5e                   	pop    %esi
801057a7:	5d                   	pop    %ebp
801057a8:	c3                   	ret
801057a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801057b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801057b5:	eb ee                	jmp    801057a5 <argint+0x35>
801057b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801057be:	00 
801057bf:	90                   	nop

801057c0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
801057c3:	57                   	push   %edi
801057c4:	56                   	push   %esi
801057c5:	53                   	push   %ebx
801057c6:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
801057c9:	e8 a2 ef ff ff       	call   80104770 <myproc>
801057ce:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801057d0:	e8 9b ef ff ff       	call   80104770 <myproc>
801057d5:	8b 55 08             	mov    0x8(%ebp),%edx
801057d8:	8b 40 18             	mov    0x18(%eax),%eax
801057db:	8b 40 44             	mov    0x44(%eax),%eax
801057de:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801057e1:	e8 8a ef ff ff       	call   80104770 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801057e6:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801057e9:	8b 00                	mov    (%eax),%eax
801057eb:	39 c7                	cmp    %eax,%edi
801057ed:	73 31                	jae    80105820 <argptr+0x60>
801057ef:	8d 4b 08             	lea    0x8(%ebx),%ecx
801057f2:	39 c8                	cmp    %ecx,%eax
801057f4:	72 2a                	jb     80105820 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801057f6:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
801057f9:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
801057fc:	85 d2                	test   %edx,%edx
801057fe:	78 20                	js     80105820 <argptr+0x60>
80105800:	8b 16                	mov    (%esi),%edx
80105802:	39 d0                	cmp    %edx,%eax
80105804:	73 1a                	jae    80105820 <argptr+0x60>
80105806:	8b 5d 10             	mov    0x10(%ebp),%ebx
80105809:	01 c3                	add    %eax,%ebx
8010580b:	39 da                	cmp    %ebx,%edx
8010580d:	72 11                	jb     80105820 <argptr+0x60>
    return -1;
  *pp = (char*)i;
8010580f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105812:	89 02                	mov    %eax,(%edx)
  return 0;
80105814:	31 c0                	xor    %eax,%eax
}
80105816:	83 c4 0c             	add    $0xc,%esp
80105819:	5b                   	pop    %ebx
8010581a:	5e                   	pop    %esi
8010581b:	5f                   	pop    %edi
8010581c:	5d                   	pop    %ebp
8010581d:	c3                   	ret
8010581e:	66 90                	xchg   %ax,%ax
    return -1;
80105820:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105825:	eb ef                	jmp    80105816 <argptr+0x56>
80105827:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010582e:	00 
8010582f:	90                   	nop

80105830 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105830:	55                   	push   %ebp
80105831:	89 e5                	mov    %esp,%ebp
80105833:	56                   	push   %esi
80105834:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105835:	e8 36 ef ff ff       	call   80104770 <myproc>
8010583a:	8b 55 08             	mov    0x8(%ebp),%edx
8010583d:	8b 40 18             	mov    0x18(%eax),%eax
80105840:	8b 40 44             	mov    0x44(%eax),%eax
80105843:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105846:	e8 25 ef ff ff       	call   80104770 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010584b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010584e:	8b 00                	mov    (%eax),%eax
80105850:	39 c6                	cmp    %eax,%esi
80105852:	73 44                	jae    80105898 <argstr+0x68>
80105854:	8d 53 08             	lea    0x8(%ebx),%edx
80105857:	39 d0                	cmp    %edx,%eax
80105859:	72 3d                	jb     80105898 <argstr+0x68>
  *ip = *(int*)(addr);
8010585b:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
8010585e:	e8 0d ef ff ff       	call   80104770 <myproc>
  if(addr >= curproc->sz)
80105863:	3b 18                	cmp    (%eax),%ebx
80105865:	73 31                	jae    80105898 <argstr+0x68>
  *pp = (char*)addr;
80105867:	8b 55 0c             	mov    0xc(%ebp),%edx
8010586a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
8010586c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010586e:	39 d3                	cmp    %edx,%ebx
80105870:	73 26                	jae    80105898 <argstr+0x68>
80105872:	89 d8                	mov    %ebx,%eax
80105874:	eb 11                	jmp    80105887 <argstr+0x57>
80105876:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010587d:	00 
8010587e:	66 90                	xchg   %ax,%ax
80105880:	83 c0 01             	add    $0x1,%eax
80105883:	39 d0                	cmp    %edx,%eax
80105885:	73 11                	jae    80105898 <argstr+0x68>
    if(*s == 0)
80105887:	80 38 00             	cmpb   $0x0,(%eax)
8010588a:	75 f4                	jne    80105880 <argstr+0x50>
      return s - *pp;
8010588c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
8010588e:	5b                   	pop    %ebx
8010588f:	5e                   	pop    %esi
80105890:	5d                   	pop    %ebp
80105891:	c3                   	ret
80105892:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105898:	5b                   	pop    %ebx
    return -1;
80105899:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010589e:	5e                   	pop    %esi
8010589f:	5d                   	pop    %ebp
801058a0:	c3                   	ret
801058a1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801058a8:	00 
801058a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801058b0 <syscall>:
[SYS_getcmostime] sys_getcmostime,
};

void
syscall(void)
{
801058b0:	55                   	push   %ebp
801058b1:	89 e5                	mov    %esp,%ebp
801058b3:	56                   	push   %esi
801058b4:	53                   	push   %ebx
  int num;
  struct proc *curproc = myproc();
801058b5:	e8 b6 ee ff ff       	call   80104770 <myproc>
801058ba:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
801058bc:	8b 40 18             	mov    0x18(%eax),%eax
801058bf:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801058c2:	8d 50 ff             	lea    -0x1(%eax),%edx
801058c5:	83 fa 1b             	cmp    $0x1b,%edx
801058c8:	77 2e                	ja     801058f8 <syscall+0x48>
801058ca:	8b 34 85 e0 90 10 80 	mov    -0x7fef6f20(,%eax,4),%esi
801058d1:	85 f6                	test   %esi,%esi
801058d3:	74 23                	je     801058f8 <syscall+0x48>
    
    // Ive added this line which logs each systemcall:
    log_syscall(num);
801058d5:	83 ec 0c             	sub    $0xc,%esp
801058d8:	50                   	push   %eax
801058d9:	e8 d2 c3 ff ff       	call   80101cb0 <log_syscall>

    curproc->tf->eax = syscalls[num]();
801058de:	ff d6                	call   *%esi
801058e0:	83 c4 10             	add    $0x10,%esp
801058e3:	89 c2                	mov    %eax,%edx
801058e5:	8b 43 18             	mov    0x18(%ebx),%eax
801058e8:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
801058eb:	8d 65 f8             	lea    -0x8(%ebp),%esp
801058ee:	5b                   	pop    %ebx
801058ef:	5e                   	pop    %esi
801058f0:	5d                   	pop    %ebp
801058f1:	c3                   	ret
801058f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
801058f8:	50                   	push   %eax
            curproc->pid, curproc->name, num);
801058f9:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
801058fc:	50                   	push   %eax
801058fd:	ff 73 10             	push   0x10(%ebx)
80105900:	68 b5 8a 10 80       	push   $0x80108ab5
80105905:	e8 36 b3 ff ff       	call   80100c40 <cprintf>
    curproc->tf->eax = -1;
8010590a:	8b 43 18             	mov    0x18(%ebx),%eax
8010590d:	83 c4 10             	add    $0x10,%esp
80105910:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80105917:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010591a:	5b                   	pop    %ebx
8010591b:	5e                   	pop    %esi
8010591c:	5d                   	pop    %ebp
8010591d:	c3                   	ret
8010591e:	66 90                	xchg   %ax,%ax

80105920 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105920:	55                   	push   %ebp
80105921:	89 e5                	mov    %esp,%ebp
80105923:	57                   	push   %edi
80105924:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105925:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80105928:	53                   	push   %ebx
80105929:	83 ec 34             	sub    $0x34,%esp
8010592c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010592f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105932:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80105935:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105938:	57                   	push   %edi
80105939:	50                   	push   %eax
8010593a:	e8 51 d5 ff ff       	call   80102e90 <nameiparent>
8010593f:	83 c4 10             	add    $0x10,%esp
80105942:	85 c0                	test   %eax,%eax
80105944:	74 5e                	je     801059a4 <create+0x84>
    return 0;
  ilock(dp);
80105946:	83 ec 0c             	sub    $0xc,%esp
80105949:	89 c3                	mov    %eax,%ebx
8010594b:	50                   	push   %eax
8010594c:	e8 3f cc ff ff       	call   80102590 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80105951:	83 c4 0c             	add    $0xc,%esp
80105954:	6a 00                	push   $0x0
80105956:	57                   	push   %edi
80105957:	53                   	push   %ebx
80105958:	e8 83 d1 ff ff       	call   80102ae0 <dirlookup>
8010595d:	83 c4 10             	add    $0x10,%esp
80105960:	89 c6                	mov    %eax,%esi
80105962:	85 c0                	test   %eax,%eax
80105964:	74 4a                	je     801059b0 <create+0x90>
    iunlockput(dp);
80105966:	83 ec 0c             	sub    $0xc,%esp
80105969:	53                   	push   %ebx
8010596a:	e8 b1 ce ff ff       	call   80102820 <iunlockput>
    ilock(ip);
8010596f:	89 34 24             	mov    %esi,(%esp)
80105972:	e8 19 cc ff ff       	call   80102590 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80105977:	83 c4 10             	add    $0x10,%esp
8010597a:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
8010597f:	75 17                	jne    80105998 <create+0x78>
80105981:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80105986:	75 10                	jne    80105998 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80105988:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010598b:	89 f0                	mov    %esi,%eax
8010598d:	5b                   	pop    %ebx
8010598e:	5e                   	pop    %esi
8010598f:	5f                   	pop    %edi
80105990:	5d                   	pop    %ebp
80105991:	c3                   	ret
80105992:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80105998:	83 ec 0c             	sub    $0xc,%esp
8010599b:	56                   	push   %esi
8010599c:	e8 7f ce ff ff       	call   80102820 <iunlockput>
    return 0;
801059a1:	83 c4 10             	add    $0x10,%esp
}
801059a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801059a7:	31 f6                	xor    %esi,%esi
}
801059a9:	5b                   	pop    %ebx
801059aa:	89 f0                	mov    %esi,%eax
801059ac:	5e                   	pop    %esi
801059ad:	5f                   	pop    %edi
801059ae:	5d                   	pop    %ebp
801059af:	c3                   	ret
  if((ip = ialloc(dp->dev, type)) == 0)
801059b0:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
801059b4:	83 ec 08             	sub    $0x8,%esp
801059b7:	50                   	push   %eax
801059b8:	ff 33                	push   (%ebx)
801059ba:	e8 61 ca ff ff       	call   80102420 <ialloc>
801059bf:	83 c4 10             	add    $0x10,%esp
801059c2:	89 c6                	mov    %eax,%esi
801059c4:	85 c0                	test   %eax,%eax
801059c6:	0f 84 bc 00 00 00    	je     80105a88 <create+0x168>
  ilock(ip);
801059cc:	83 ec 0c             	sub    $0xc,%esp
801059cf:	50                   	push   %eax
801059d0:	e8 bb cb ff ff       	call   80102590 <ilock>
  ip->major = major;
801059d5:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
801059d9:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
801059dd:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
801059e1:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
801059e5:	b8 01 00 00 00       	mov    $0x1,%eax
801059ea:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
801059ee:	89 34 24             	mov    %esi,(%esp)
801059f1:	e8 ea ca ff ff       	call   801024e0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
801059f6:	83 c4 10             	add    $0x10,%esp
801059f9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
801059fe:	74 30                	je     80105a30 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
80105a00:	83 ec 04             	sub    $0x4,%esp
80105a03:	ff 76 04             	push   0x4(%esi)
80105a06:	57                   	push   %edi
80105a07:	53                   	push   %ebx
80105a08:	e8 a3 d3 ff ff       	call   80102db0 <dirlink>
80105a0d:	83 c4 10             	add    $0x10,%esp
80105a10:	85 c0                	test   %eax,%eax
80105a12:	78 67                	js     80105a7b <create+0x15b>
  iunlockput(dp);
80105a14:	83 ec 0c             	sub    $0xc,%esp
80105a17:	53                   	push   %ebx
80105a18:	e8 03 ce ff ff       	call   80102820 <iunlockput>
  return ip;
80105a1d:	83 c4 10             	add    $0x10,%esp
}
80105a20:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a23:	89 f0                	mov    %esi,%eax
80105a25:	5b                   	pop    %ebx
80105a26:	5e                   	pop    %esi
80105a27:	5f                   	pop    %edi
80105a28:	5d                   	pop    %ebp
80105a29:	c3                   	ret
80105a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80105a30:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80105a33:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105a38:	53                   	push   %ebx
80105a39:	e8 a2 ca ff ff       	call   801024e0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105a3e:	83 c4 0c             	add    $0xc,%esp
80105a41:	ff 76 04             	push   0x4(%esi)
80105a44:	68 ed 8a 10 80       	push   $0x80108aed
80105a49:	56                   	push   %esi
80105a4a:	e8 61 d3 ff ff       	call   80102db0 <dirlink>
80105a4f:	83 c4 10             	add    $0x10,%esp
80105a52:	85 c0                	test   %eax,%eax
80105a54:	78 18                	js     80105a6e <create+0x14e>
80105a56:	83 ec 04             	sub    $0x4,%esp
80105a59:	ff 73 04             	push   0x4(%ebx)
80105a5c:	68 ec 8a 10 80       	push   $0x80108aec
80105a61:	56                   	push   %esi
80105a62:	e8 49 d3 ff ff       	call   80102db0 <dirlink>
80105a67:	83 c4 10             	add    $0x10,%esp
80105a6a:	85 c0                	test   %eax,%eax
80105a6c:	79 92                	jns    80105a00 <create+0xe0>
      panic("create dots");
80105a6e:	83 ec 0c             	sub    $0xc,%esp
80105a71:	68 e0 8a 10 80       	push   $0x80108ae0
80105a76:	e8 25 a9 ff ff       	call   801003a0 <panic>
    panic("create: dirlink");
80105a7b:	83 ec 0c             	sub    $0xc,%esp
80105a7e:	68 ef 8a 10 80       	push   $0x80108aef
80105a83:	e8 18 a9 ff ff       	call   801003a0 <panic>
    panic("create: ialloc");
80105a88:	83 ec 0c             	sub    $0xc,%esp
80105a8b:	68 d1 8a 10 80       	push   $0x80108ad1
80105a90:	e8 0b a9 ff ff       	call   801003a0 <panic>
80105a95:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a9c:	00 
80105a9d:	8d 76 00             	lea    0x0(%esi),%esi

80105aa0 <sys_dup>:
{
80105aa0:	55                   	push   %ebp
80105aa1:	89 e5                	mov    %esp,%ebp
80105aa3:	56                   	push   %esi
80105aa4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105aa5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105aa8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105aab:	50                   	push   %eax
80105aac:	6a 00                	push   $0x0
80105aae:	e8 bd fc ff ff       	call   80105770 <argint>
80105ab3:	83 c4 10             	add    $0x10,%esp
80105ab6:	85 c0                	test   %eax,%eax
80105ab8:	78 36                	js     80105af0 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105aba:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105abe:	77 30                	ja     80105af0 <sys_dup+0x50>
80105ac0:	e8 ab ec ff ff       	call   80104770 <myproc>
80105ac5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105ac8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105acc:	85 f6                	test   %esi,%esi
80105ace:	74 20                	je     80105af0 <sys_dup+0x50>
  struct proc *curproc = myproc();
80105ad0:	e8 9b ec ff ff       	call   80104770 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105ad5:	31 db                	xor    %ebx,%ebx
80105ad7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105ade:	00 
80105adf:	90                   	nop
    if(curproc->ofile[fd] == 0){
80105ae0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105ae4:	85 d2                	test   %edx,%edx
80105ae6:	74 18                	je     80105b00 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80105ae8:	83 c3 01             	add    $0x1,%ebx
80105aeb:	83 fb 10             	cmp    $0x10,%ebx
80105aee:	75 f0                	jne    80105ae0 <sys_dup+0x40>
}
80105af0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80105af3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105af8:	89 d8                	mov    %ebx,%eax
80105afa:	5b                   	pop    %ebx
80105afb:	5e                   	pop    %esi
80105afc:	5d                   	pop    %ebp
80105afd:	c3                   	ret
80105afe:	66 90                	xchg   %ax,%ax
  filedup(f);
80105b00:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105b03:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105b07:	56                   	push   %esi
80105b08:	e8 33 bc ff ff       	call   80101740 <filedup>
  return fd;
80105b0d:	83 c4 10             	add    $0x10,%esp
}
80105b10:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105b13:	89 d8                	mov    %ebx,%eax
80105b15:	5b                   	pop    %ebx
80105b16:	5e                   	pop    %esi
80105b17:	5d                   	pop    %ebp
80105b18:	c3                   	ret
80105b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105b20 <sys_read>:
{
80105b20:	55                   	push   %ebp
80105b21:	89 e5                	mov    %esp,%ebp
80105b23:	56                   	push   %esi
80105b24:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105b25:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105b28:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105b2b:	53                   	push   %ebx
80105b2c:	6a 00                	push   $0x0
80105b2e:	e8 3d fc ff ff       	call   80105770 <argint>
80105b33:	83 c4 10             	add    $0x10,%esp
80105b36:	85 c0                	test   %eax,%eax
80105b38:	78 5e                	js     80105b98 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105b3a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105b3e:	77 58                	ja     80105b98 <sys_read+0x78>
80105b40:	e8 2b ec ff ff       	call   80104770 <myproc>
80105b45:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105b48:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105b4c:	85 f6                	test   %esi,%esi
80105b4e:	74 48                	je     80105b98 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105b50:	83 ec 08             	sub    $0x8,%esp
80105b53:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105b56:	50                   	push   %eax
80105b57:	6a 02                	push   $0x2
80105b59:	e8 12 fc ff ff       	call   80105770 <argint>
80105b5e:	83 c4 10             	add    $0x10,%esp
80105b61:	85 c0                	test   %eax,%eax
80105b63:	78 33                	js     80105b98 <sys_read+0x78>
80105b65:	83 ec 04             	sub    $0x4,%esp
80105b68:	ff 75 f0             	push   -0x10(%ebp)
80105b6b:	53                   	push   %ebx
80105b6c:	6a 01                	push   $0x1
80105b6e:	e8 4d fc ff ff       	call   801057c0 <argptr>
80105b73:	83 c4 10             	add    $0x10,%esp
80105b76:	85 c0                	test   %eax,%eax
80105b78:	78 1e                	js     80105b98 <sys_read+0x78>
  return fileread(f, p, n);
80105b7a:	83 ec 04             	sub    $0x4,%esp
80105b7d:	ff 75 f0             	push   -0x10(%ebp)
80105b80:	ff 75 f4             	push   -0xc(%ebp)
80105b83:	56                   	push   %esi
80105b84:	e8 37 bd ff ff       	call   801018c0 <fileread>
80105b89:	83 c4 10             	add    $0x10,%esp
}
80105b8c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105b8f:	5b                   	pop    %ebx
80105b90:	5e                   	pop    %esi
80105b91:	5d                   	pop    %ebp
80105b92:	c3                   	ret
80105b93:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80105b98:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105b9d:	eb ed                	jmp    80105b8c <sys_read+0x6c>
80105b9f:	90                   	nop

80105ba0 <sys_write>:
{
80105ba0:	55                   	push   %ebp
80105ba1:	89 e5                	mov    %esp,%ebp
80105ba3:	56                   	push   %esi
80105ba4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105ba5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105ba8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105bab:	53                   	push   %ebx
80105bac:	6a 00                	push   $0x0
80105bae:	e8 bd fb ff ff       	call   80105770 <argint>
80105bb3:	83 c4 10             	add    $0x10,%esp
80105bb6:	85 c0                	test   %eax,%eax
80105bb8:	78 5e                	js     80105c18 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105bba:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105bbe:	77 58                	ja     80105c18 <sys_write+0x78>
80105bc0:	e8 ab eb ff ff       	call   80104770 <myproc>
80105bc5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105bc8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105bcc:	85 f6                	test   %esi,%esi
80105bce:	74 48                	je     80105c18 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105bd0:	83 ec 08             	sub    $0x8,%esp
80105bd3:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105bd6:	50                   	push   %eax
80105bd7:	6a 02                	push   $0x2
80105bd9:	e8 92 fb ff ff       	call   80105770 <argint>
80105bde:	83 c4 10             	add    $0x10,%esp
80105be1:	85 c0                	test   %eax,%eax
80105be3:	78 33                	js     80105c18 <sys_write+0x78>
80105be5:	83 ec 04             	sub    $0x4,%esp
80105be8:	ff 75 f0             	push   -0x10(%ebp)
80105beb:	53                   	push   %ebx
80105bec:	6a 01                	push   $0x1
80105bee:	e8 cd fb ff ff       	call   801057c0 <argptr>
80105bf3:	83 c4 10             	add    $0x10,%esp
80105bf6:	85 c0                	test   %eax,%eax
80105bf8:	78 1e                	js     80105c18 <sys_write+0x78>
  return filewrite(f, p, n);
80105bfa:	83 ec 04             	sub    $0x4,%esp
80105bfd:	ff 75 f0             	push   -0x10(%ebp)
80105c00:	ff 75 f4             	push   -0xc(%ebp)
80105c03:	56                   	push   %esi
80105c04:	e8 47 bd ff ff       	call   80101950 <filewrite>
80105c09:	83 c4 10             	add    $0x10,%esp
}
80105c0c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105c0f:	5b                   	pop    %ebx
80105c10:	5e                   	pop    %esi
80105c11:	5d                   	pop    %ebp
80105c12:	c3                   	ret
80105c13:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80105c18:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c1d:	eb ed                	jmp    80105c0c <sys_write+0x6c>
80105c1f:	90                   	nop

80105c20 <sys_close>:
{
80105c20:	55                   	push   %ebp
80105c21:	89 e5                	mov    %esp,%ebp
80105c23:	56                   	push   %esi
80105c24:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105c25:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105c28:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105c2b:	50                   	push   %eax
80105c2c:	6a 00                	push   $0x0
80105c2e:	e8 3d fb ff ff       	call   80105770 <argint>
80105c33:	83 c4 10             	add    $0x10,%esp
80105c36:	85 c0                	test   %eax,%eax
80105c38:	78 3e                	js     80105c78 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105c3a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105c3e:	77 38                	ja     80105c78 <sys_close+0x58>
80105c40:	e8 2b eb ff ff       	call   80104770 <myproc>
80105c45:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105c48:	8d 5a 08             	lea    0x8(%edx),%ebx
80105c4b:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
80105c4f:	85 f6                	test   %esi,%esi
80105c51:	74 25                	je     80105c78 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80105c53:	e8 18 eb ff ff       	call   80104770 <myproc>
  fileclose(f);
80105c58:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105c5b:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80105c62:	00 
  fileclose(f);
80105c63:	56                   	push   %esi
80105c64:	e8 27 bb ff ff       	call   80101790 <fileclose>
  return 0;
80105c69:	83 c4 10             	add    $0x10,%esp
80105c6c:	31 c0                	xor    %eax,%eax
}
80105c6e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105c71:	5b                   	pop    %ebx
80105c72:	5e                   	pop    %esi
80105c73:	5d                   	pop    %ebp
80105c74:	c3                   	ret
80105c75:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105c78:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c7d:	eb ef                	jmp    80105c6e <sys_close+0x4e>
80105c7f:	90                   	nop

80105c80 <sys_fstat>:
{
80105c80:	55                   	push   %ebp
80105c81:	89 e5                	mov    %esp,%ebp
80105c83:	56                   	push   %esi
80105c84:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105c85:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105c88:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105c8b:	53                   	push   %ebx
80105c8c:	6a 00                	push   $0x0
80105c8e:	e8 dd fa ff ff       	call   80105770 <argint>
80105c93:	83 c4 10             	add    $0x10,%esp
80105c96:	85 c0                	test   %eax,%eax
80105c98:	78 46                	js     80105ce0 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105c9a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105c9e:	77 40                	ja     80105ce0 <sys_fstat+0x60>
80105ca0:	e8 cb ea ff ff       	call   80104770 <myproc>
80105ca5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105ca8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105cac:	85 f6                	test   %esi,%esi
80105cae:	74 30                	je     80105ce0 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105cb0:	83 ec 04             	sub    $0x4,%esp
80105cb3:	6a 14                	push   $0x14
80105cb5:	53                   	push   %ebx
80105cb6:	6a 01                	push   $0x1
80105cb8:	e8 03 fb ff ff       	call   801057c0 <argptr>
80105cbd:	83 c4 10             	add    $0x10,%esp
80105cc0:	85 c0                	test   %eax,%eax
80105cc2:	78 1c                	js     80105ce0 <sys_fstat+0x60>
  return filestat(f, st);
80105cc4:	83 ec 08             	sub    $0x8,%esp
80105cc7:	ff 75 f4             	push   -0xc(%ebp)
80105cca:	56                   	push   %esi
80105ccb:	e8 a0 bb ff ff       	call   80101870 <filestat>
80105cd0:	83 c4 10             	add    $0x10,%esp
}
80105cd3:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105cd6:	5b                   	pop    %ebx
80105cd7:	5e                   	pop    %esi
80105cd8:	5d                   	pop    %ebp
80105cd9:	c3                   	ret
80105cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105ce0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ce5:	eb ec                	jmp    80105cd3 <sys_fstat+0x53>
80105ce7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105cee:	00 
80105cef:	90                   	nop

80105cf0 <sys_link>:
{
80105cf0:	55                   	push   %ebp
80105cf1:	89 e5                	mov    %esp,%ebp
80105cf3:	57                   	push   %edi
80105cf4:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105cf5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105cf8:	53                   	push   %ebx
80105cf9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105cfc:	50                   	push   %eax
80105cfd:	6a 00                	push   $0x0
80105cff:	e8 2c fb ff ff       	call   80105830 <argstr>
80105d04:	83 c4 10             	add    $0x10,%esp
80105d07:	85 c0                	test   %eax,%eax
80105d09:	0f 88 fb 00 00 00    	js     80105e0a <sys_link+0x11a>
80105d0f:	83 ec 08             	sub    $0x8,%esp
80105d12:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105d15:	50                   	push   %eax
80105d16:	6a 01                	push   $0x1
80105d18:	e8 13 fb ff ff       	call   80105830 <argstr>
80105d1d:	83 c4 10             	add    $0x10,%esp
80105d20:	85 c0                	test   %eax,%eax
80105d22:	0f 88 e2 00 00 00    	js     80105e0a <sys_link+0x11a>
  begin_op();
80105d28:	e8 13 de ff ff       	call   80103b40 <begin_op>
  if((ip = namei(old)) == 0){
80105d2d:	83 ec 0c             	sub    $0xc,%esp
80105d30:	ff 75 d4             	push   -0x2c(%ebp)
80105d33:	e8 38 d1 ff ff       	call   80102e70 <namei>
80105d38:	83 c4 10             	add    $0x10,%esp
80105d3b:	89 c3                	mov    %eax,%ebx
80105d3d:	85 c0                	test   %eax,%eax
80105d3f:	0f 84 df 00 00 00    	je     80105e24 <sys_link+0x134>
  ilock(ip);
80105d45:	83 ec 0c             	sub    $0xc,%esp
80105d48:	50                   	push   %eax
80105d49:	e8 42 c8 ff ff       	call   80102590 <ilock>
  if(ip->type == T_DIR){
80105d4e:	83 c4 10             	add    $0x10,%esp
80105d51:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105d56:	0f 84 b5 00 00 00    	je     80105e11 <sys_link+0x121>
  iupdate(ip);
80105d5c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80105d5f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105d64:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105d67:	53                   	push   %ebx
80105d68:	e8 73 c7 ff ff       	call   801024e0 <iupdate>
  iunlock(ip);
80105d6d:	89 1c 24             	mov    %ebx,(%esp)
80105d70:	e8 fb c8 ff ff       	call   80102670 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105d75:	58                   	pop    %eax
80105d76:	5a                   	pop    %edx
80105d77:	57                   	push   %edi
80105d78:	ff 75 d0             	push   -0x30(%ebp)
80105d7b:	e8 10 d1 ff ff       	call   80102e90 <nameiparent>
80105d80:	83 c4 10             	add    $0x10,%esp
80105d83:	89 c6                	mov    %eax,%esi
80105d85:	85 c0                	test   %eax,%eax
80105d87:	74 5b                	je     80105de4 <sys_link+0xf4>
  ilock(dp);
80105d89:	83 ec 0c             	sub    $0xc,%esp
80105d8c:	50                   	push   %eax
80105d8d:	e8 fe c7 ff ff       	call   80102590 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105d92:	8b 03                	mov    (%ebx),%eax
80105d94:	83 c4 10             	add    $0x10,%esp
80105d97:	39 06                	cmp    %eax,(%esi)
80105d99:	75 3d                	jne    80105dd8 <sys_link+0xe8>
80105d9b:	83 ec 04             	sub    $0x4,%esp
80105d9e:	ff 73 04             	push   0x4(%ebx)
80105da1:	57                   	push   %edi
80105da2:	56                   	push   %esi
80105da3:	e8 08 d0 ff ff       	call   80102db0 <dirlink>
80105da8:	83 c4 10             	add    $0x10,%esp
80105dab:	85 c0                	test   %eax,%eax
80105dad:	78 29                	js     80105dd8 <sys_link+0xe8>
  iunlockput(dp);
80105daf:	83 ec 0c             	sub    $0xc,%esp
80105db2:	56                   	push   %esi
80105db3:	e8 68 ca ff ff       	call   80102820 <iunlockput>
  iput(ip);
80105db8:	89 1c 24             	mov    %ebx,(%esp)
80105dbb:	e8 00 c9 ff ff       	call   801026c0 <iput>
  end_op();
80105dc0:	e8 eb dd ff ff       	call   80103bb0 <end_op>
  return 0;
80105dc5:	83 c4 10             	add    $0x10,%esp
80105dc8:	31 c0                	xor    %eax,%eax
}
80105dca:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105dcd:	5b                   	pop    %ebx
80105dce:	5e                   	pop    %esi
80105dcf:	5f                   	pop    %edi
80105dd0:	5d                   	pop    %ebp
80105dd1:	c3                   	ret
80105dd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105dd8:	83 ec 0c             	sub    $0xc,%esp
80105ddb:	56                   	push   %esi
80105ddc:	e8 3f ca ff ff       	call   80102820 <iunlockput>
    goto bad;
80105de1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105de4:	83 ec 0c             	sub    $0xc,%esp
80105de7:	53                   	push   %ebx
80105de8:	e8 a3 c7 ff ff       	call   80102590 <ilock>
  ip->nlink--;
80105ded:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105df2:	89 1c 24             	mov    %ebx,(%esp)
80105df5:	e8 e6 c6 ff ff       	call   801024e0 <iupdate>
  iunlockput(ip);
80105dfa:	89 1c 24             	mov    %ebx,(%esp)
80105dfd:	e8 1e ca ff ff       	call   80102820 <iunlockput>
  end_op();
80105e02:	e8 a9 dd ff ff       	call   80103bb0 <end_op>
  return -1;
80105e07:	83 c4 10             	add    $0x10,%esp
    return -1;
80105e0a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e0f:	eb b9                	jmp    80105dca <sys_link+0xda>
    iunlockput(ip);
80105e11:	83 ec 0c             	sub    $0xc,%esp
80105e14:	53                   	push   %ebx
80105e15:	e8 06 ca ff ff       	call   80102820 <iunlockput>
    end_op();
80105e1a:	e8 91 dd ff ff       	call   80103bb0 <end_op>
    return -1;
80105e1f:	83 c4 10             	add    $0x10,%esp
80105e22:	eb e6                	jmp    80105e0a <sys_link+0x11a>
    end_op();
80105e24:	e8 87 dd ff ff       	call   80103bb0 <end_op>
    return -1;
80105e29:	eb df                	jmp    80105e0a <sys_link+0x11a>
80105e2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105e30 <sys_unlink>:
{
80105e30:	55                   	push   %ebp
80105e31:	89 e5                	mov    %esp,%ebp
80105e33:	57                   	push   %edi
80105e34:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105e35:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105e38:	53                   	push   %ebx
80105e39:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80105e3c:	50                   	push   %eax
80105e3d:	6a 00                	push   $0x0
80105e3f:	e8 ec f9 ff ff       	call   80105830 <argstr>
80105e44:	83 c4 10             	add    $0x10,%esp
80105e47:	85 c0                	test   %eax,%eax
80105e49:	0f 88 54 01 00 00    	js     80105fa3 <sys_unlink+0x173>
  begin_op();
80105e4f:	e8 ec dc ff ff       	call   80103b40 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105e54:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105e57:	83 ec 08             	sub    $0x8,%esp
80105e5a:	53                   	push   %ebx
80105e5b:	ff 75 c0             	push   -0x40(%ebp)
80105e5e:	e8 2d d0 ff ff       	call   80102e90 <nameiparent>
80105e63:	83 c4 10             	add    $0x10,%esp
80105e66:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105e69:	85 c0                	test   %eax,%eax
80105e6b:	0f 84 58 01 00 00    	je     80105fc9 <sys_unlink+0x199>
  ilock(dp);
80105e71:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105e74:	83 ec 0c             	sub    $0xc,%esp
80105e77:	57                   	push   %edi
80105e78:	e8 13 c7 ff ff       	call   80102590 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105e7d:	58                   	pop    %eax
80105e7e:	5a                   	pop    %edx
80105e7f:	68 ed 8a 10 80       	push   $0x80108aed
80105e84:	53                   	push   %ebx
80105e85:	e8 36 cc ff ff       	call   80102ac0 <namecmp>
80105e8a:	83 c4 10             	add    $0x10,%esp
80105e8d:	85 c0                	test   %eax,%eax
80105e8f:	0f 84 fb 00 00 00    	je     80105f90 <sys_unlink+0x160>
80105e95:	83 ec 08             	sub    $0x8,%esp
80105e98:	68 ec 8a 10 80       	push   $0x80108aec
80105e9d:	53                   	push   %ebx
80105e9e:	e8 1d cc ff ff       	call   80102ac0 <namecmp>
80105ea3:	83 c4 10             	add    $0x10,%esp
80105ea6:	85 c0                	test   %eax,%eax
80105ea8:	0f 84 e2 00 00 00    	je     80105f90 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105eae:	83 ec 04             	sub    $0x4,%esp
80105eb1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105eb4:	50                   	push   %eax
80105eb5:	53                   	push   %ebx
80105eb6:	57                   	push   %edi
80105eb7:	e8 24 cc ff ff       	call   80102ae0 <dirlookup>
80105ebc:	83 c4 10             	add    $0x10,%esp
80105ebf:	89 c3                	mov    %eax,%ebx
80105ec1:	85 c0                	test   %eax,%eax
80105ec3:	0f 84 c7 00 00 00    	je     80105f90 <sys_unlink+0x160>
  ilock(ip);
80105ec9:	83 ec 0c             	sub    $0xc,%esp
80105ecc:	50                   	push   %eax
80105ecd:	e8 be c6 ff ff       	call   80102590 <ilock>
  if(ip->nlink < 1)
80105ed2:	83 c4 10             	add    $0x10,%esp
80105ed5:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105eda:	0f 8e 0a 01 00 00    	jle    80105fea <sys_unlink+0x1ba>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105ee0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105ee5:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105ee8:	74 66                	je     80105f50 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105eea:	83 ec 04             	sub    $0x4,%esp
80105eed:	6a 10                	push   $0x10
80105eef:	6a 00                	push   $0x0
80105ef1:	57                   	push   %edi
80105ef2:	e8 c9 f5 ff ff       	call   801054c0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105ef7:	6a 10                	push   $0x10
80105ef9:	ff 75 c4             	push   -0x3c(%ebp)
80105efc:	57                   	push   %edi
80105efd:	ff 75 b4             	push   -0x4c(%ebp)
80105f00:	e8 9b ca ff ff       	call   801029a0 <writei>
80105f05:	83 c4 20             	add    $0x20,%esp
80105f08:	83 f8 10             	cmp    $0x10,%eax
80105f0b:	0f 85 cc 00 00 00    	jne    80105fdd <sys_unlink+0x1ad>
  if(ip->type == T_DIR){
80105f11:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105f16:	0f 84 94 00 00 00    	je     80105fb0 <sys_unlink+0x180>
  iunlockput(dp);
80105f1c:	83 ec 0c             	sub    $0xc,%esp
80105f1f:	ff 75 b4             	push   -0x4c(%ebp)
80105f22:	e8 f9 c8 ff ff       	call   80102820 <iunlockput>
  ip->nlink--;
80105f27:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105f2c:	89 1c 24             	mov    %ebx,(%esp)
80105f2f:	e8 ac c5 ff ff       	call   801024e0 <iupdate>
  iunlockput(ip);
80105f34:	89 1c 24             	mov    %ebx,(%esp)
80105f37:	e8 e4 c8 ff ff       	call   80102820 <iunlockput>
  end_op();
80105f3c:	e8 6f dc ff ff       	call   80103bb0 <end_op>
  return 0;
80105f41:	83 c4 10             	add    $0x10,%esp
80105f44:	31 c0                	xor    %eax,%eax
}
80105f46:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f49:	5b                   	pop    %ebx
80105f4a:	5e                   	pop    %esi
80105f4b:	5f                   	pop    %edi
80105f4c:	5d                   	pop    %ebp
80105f4d:	c3                   	ret
80105f4e:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105f50:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105f54:	76 94                	jbe    80105eea <sys_unlink+0xba>
80105f56:	be 20 00 00 00       	mov    $0x20,%esi
80105f5b:	eb 0b                	jmp    80105f68 <sys_unlink+0x138>
80105f5d:	8d 76 00             	lea    0x0(%esi),%esi
80105f60:	83 c6 10             	add    $0x10,%esi
80105f63:	3b 73 58             	cmp    0x58(%ebx),%esi
80105f66:	73 82                	jae    80105eea <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105f68:	6a 10                	push   $0x10
80105f6a:	56                   	push   %esi
80105f6b:	57                   	push   %edi
80105f6c:	53                   	push   %ebx
80105f6d:	e8 2e c9 ff ff       	call   801028a0 <readi>
80105f72:	83 c4 10             	add    $0x10,%esp
80105f75:	83 f8 10             	cmp    $0x10,%eax
80105f78:	75 56                	jne    80105fd0 <sys_unlink+0x1a0>
    if(de.inum != 0)
80105f7a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105f7f:	74 df                	je     80105f60 <sys_unlink+0x130>
    iunlockput(ip);
80105f81:	83 ec 0c             	sub    $0xc,%esp
80105f84:	53                   	push   %ebx
80105f85:	e8 96 c8 ff ff       	call   80102820 <iunlockput>
    goto bad;
80105f8a:	83 c4 10             	add    $0x10,%esp
80105f8d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105f90:	83 ec 0c             	sub    $0xc,%esp
80105f93:	ff 75 b4             	push   -0x4c(%ebp)
80105f96:	e8 85 c8 ff ff       	call   80102820 <iunlockput>
  end_op();
80105f9b:	e8 10 dc ff ff       	call   80103bb0 <end_op>
  return -1;
80105fa0:	83 c4 10             	add    $0x10,%esp
    return -1;
80105fa3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fa8:	eb 9c                	jmp    80105f46 <sys_unlink+0x116>
80105faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105fb0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105fb3:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105fb6:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105fbb:	50                   	push   %eax
80105fbc:	e8 1f c5 ff ff       	call   801024e0 <iupdate>
80105fc1:	83 c4 10             	add    $0x10,%esp
80105fc4:	e9 53 ff ff ff       	jmp    80105f1c <sys_unlink+0xec>
    end_op();
80105fc9:	e8 e2 db ff ff       	call   80103bb0 <end_op>
    return -1;
80105fce:	eb d3                	jmp    80105fa3 <sys_unlink+0x173>
      panic("isdirempty: readi");
80105fd0:	83 ec 0c             	sub    $0xc,%esp
80105fd3:	68 11 8b 10 80       	push   $0x80108b11
80105fd8:	e8 c3 a3 ff ff       	call   801003a0 <panic>
    panic("unlink: writei");
80105fdd:	83 ec 0c             	sub    $0xc,%esp
80105fe0:	68 23 8b 10 80       	push   $0x80108b23
80105fe5:	e8 b6 a3 ff ff       	call   801003a0 <panic>
    panic("unlink: nlink < 1");
80105fea:	83 ec 0c             	sub    $0xc,%esp
80105fed:	68 ff 8a 10 80       	push   $0x80108aff
80105ff2:	e8 a9 a3 ff ff       	call   801003a0 <panic>
80105ff7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105ffe:	00 
80105fff:	90                   	nop

80106000 <sys_open>:

int
sys_open(void)
{
80106000:	55                   	push   %ebp
80106001:	89 e5                	mov    %esp,%ebp
80106003:	57                   	push   %edi
80106004:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106005:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80106008:	53                   	push   %ebx
80106009:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010600c:	50                   	push   %eax
8010600d:	6a 00                	push   $0x0
8010600f:	e8 1c f8 ff ff       	call   80105830 <argstr>
80106014:	83 c4 10             	add    $0x10,%esp
80106017:	85 c0                	test   %eax,%eax
80106019:	0f 88 8e 00 00 00    	js     801060ad <sys_open+0xad>
8010601f:	83 ec 08             	sub    $0x8,%esp
80106022:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106025:	50                   	push   %eax
80106026:	6a 01                	push   $0x1
80106028:	e8 43 f7 ff ff       	call   80105770 <argint>
8010602d:	83 c4 10             	add    $0x10,%esp
80106030:	85 c0                	test   %eax,%eax
80106032:	78 79                	js     801060ad <sys_open+0xad>
    return -1;

  begin_op();
80106034:	e8 07 db ff ff       	call   80103b40 <begin_op>

  if(omode & O_CREATE){
80106039:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
8010603d:	75 79                	jne    801060b8 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010603f:	83 ec 0c             	sub    $0xc,%esp
80106042:	ff 75 e0             	push   -0x20(%ebp)
80106045:	e8 26 ce ff ff       	call   80102e70 <namei>
8010604a:	83 c4 10             	add    $0x10,%esp
8010604d:	89 c6                	mov    %eax,%esi
8010604f:	85 c0                	test   %eax,%eax
80106051:	0f 84 7e 00 00 00    	je     801060d5 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80106057:	83 ec 0c             	sub    $0xc,%esp
8010605a:	50                   	push   %eax
8010605b:	e8 30 c5 ff ff       	call   80102590 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80106060:	83 c4 10             	add    $0x10,%esp
80106063:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80106068:	0f 84 ba 00 00 00    	je     80106128 <sys_open+0x128>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010606e:	e8 5d b6 ff ff       	call   801016d0 <filealloc>
80106073:	89 c7                	mov    %eax,%edi
80106075:	85 c0                	test   %eax,%eax
80106077:	74 23                	je     8010609c <sys_open+0x9c>
  struct proc *curproc = myproc();
80106079:	e8 f2 e6 ff ff       	call   80104770 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010607e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80106080:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80106084:	85 d2                	test   %edx,%edx
80106086:	74 58                	je     801060e0 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
80106088:	83 c3 01             	add    $0x1,%ebx
8010608b:	83 fb 10             	cmp    $0x10,%ebx
8010608e:	75 f0                	jne    80106080 <sys_open+0x80>
    if(f)
      fileclose(f);
80106090:	83 ec 0c             	sub    $0xc,%esp
80106093:	57                   	push   %edi
80106094:	e8 f7 b6 ff ff       	call   80101790 <fileclose>
80106099:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010609c:	83 ec 0c             	sub    $0xc,%esp
8010609f:	56                   	push   %esi
801060a0:	e8 7b c7 ff ff       	call   80102820 <iunlockput>
    end_op();
801060a5:	e8 06 db ff ff       	call   80103bb0 <end_op>
    return -1;
801060aa:	83 c4 10             	add    $0x10,%esp
    return -1;
801060ad:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801060b2:	eb 65                	jmp    80106119 <sys_open+0x119>
801060b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
801060b8:	83 ec 0c             	sub    $0xc,%esp
801060bb:	31 c9                	xor    %ecx,%ecx
801060bd:	ba 02 00 00 00       	mov    $0x2,%edx
801060c2:	6a 00                	push   $0x0
801060c4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801060c7:	e8 54 f8 ff ff       	call   80105920 <create>
    if(ip == 0){
801060cc:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
801060cf:	89 c6                	mov    %eax,%esi
    if(ip == 0){
801060d1:	85 c0                	test   %eax,%eax
801060d3:	75 99                	jne    8010606e <sys_open+0x6e>
      end_op();
801060d5:	e8 d6 da ff ff       	call   80103bb0 <end_op>
      return -1;
801060da:	eb d1                	jmp    801060ad <sys_open+0xad>
801060dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
801060e0:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801060e3:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
801060e7:	56                   	push   %esi
801060e8:	e8 83 c5 ff ff       	call   80102670 <iunlock>
  end_op();
801060ed:	e8 be da ff ff       	call   80103bb0 <end_op>

  f->type = FD_INODE;
801060f2:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801060f8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801060fb:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801060fe:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80106101:	89 d0                	mov    %edx,%eax
  f->off = 0;
80106103:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010610a:	f7 d0                	not    %eax
8010610c:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010610f:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80106112:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106115:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80106119:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010611c:	89 d8                	mov    %ebx,%eax
8010611e:	5b                   	pop    %ebx
8010611f:	5e                   	pop    %esi
80106120:	5f                   	pop    %edi
80106121:	5d                   	pop    %ebp
80106122:	c3                   	ret
80106123:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80106128:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010612b:	85 c9                	test   %ecx,%ecx
8010612d:	0f 84 3b ff ff ff    	je     8010606e <sys_open+0x6e>
80106133:	e9 64 ff ff ff       	jmp    8010609c <sys_open+0x9c>
80106138:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010613f:	00 

80106140 <sys_mkdir>:

int
sys_mkdir(void)
{
80106140:	55                   	push   %ebp
80106141:	89 e5                	mov    %esp,%ebp
80106143:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106146:	e8 f5 d9 ff ff       	call   80103b40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010614b:	83 ec 08             	sub    $0x8,%esp
8010614e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106151:	50                   	push   %eax
80106152:	6a 00                	push   $0x0
80106154:	e8 d7 f6 ff ff       	call   80105830 <argstr>
80106159:	83 c4 10             	add    $0x10,%esp
8010615c:	85 c0                	test   %eax,%eax
8010615e:	78 30                	js     80106190 <sys_mkdir+0x50>
80106160:	83 ec 0c             	sub    $0xc,%esp
80106163:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106166:	31 c9                	xor    %ecx,%ecx
80106168:	ba 01 00 00 00       	mov    $0x1,%edx
8010616d:	6a 00                	push   $0x0
8010616f:	e8 ac f7 ff ff       	call   80105920 <create>
80106174:	83 c4 10             	add    $0x10,%esp
80106177:	85 c0                	test   %eax,%eax
80106179:	74 15                	je     80106190 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010617b:	83 ec 0c             	sub    $0xc,%esp
8010617e:	50                   	push   %eax
8010617f:	e8 9c c6 ff ff       	call   80102820 <iunlockput>
  end_op();
80106184:	e8 27 da ff ff       	call   80103bb0 <end_op>
  return 0;
80106189:	83 c4 10             	add    $0x10,%esp
8010618c:	31 c0                	xor    %eax,%eax
}
8010618e:	c9                   	leave
8010618f:	c3                   	ret
    end_op();
80106190:	e8 1b da ff ff       	call   80103bb0 <end_op>
    return -1;
80106195:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010619a:	c9                   	leave
8010619b:	c3                   	ret
8010619c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801061a0 <sys_mknod>:

int
sys_mknod(void)
{
801061a0:	55                   	push   %ebp
801061a1:	89 e5                	mov    %esp,%ebp
801061a3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801061a6:	e8 95 d9 ff ff       	call   80103b40 <begin_op>
  if((argstr(0, &path)) < 0 ||
801061ab:	83 ec 08             	sub    $0x8,%esp
801061ae:	8d 45 ec             	lea    -0x14(%ebp),%eax
801061b1:	50                   	push   %eax
801061b2:	6a 00                	push   $0x0
801061b4:	e8 77 f6 ff ff       	call   80105830 <argstr>
801061b9:	83 c4 10             	add    $0x10,%esp
801061bc:	85 c0                	test   %eax,%eax
801061be:	78 60                	js     80106220 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801061c0:	83 ec 08             	sub    $0x8,%esp
801061c3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801061c6:	50                   	push   %eax
801061c7:	6a 01                	push   $0x1
801061c9:	e8 a2 f5 ff ff       	call   80105770 <argint>
  if((argstr(0, &path)) < 0 ||
801061ce:	83 c4 10             	add    $0x10,%esp
801061d1:	85 c0                	test   %eax,%eax
801061d3:	78 4b                	js     80106220 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
801061d5:	83 ec 08             	sub    $0x8,%esp
801061d8:	8d 45 f4             	lea    -0xc(%ebp),%eax
801061db:	50                   	push   %eax
801061dc:	6a 02                	push   $0x2
801061de:	e8 8d f5 ff ff       	call   80105770 <argint>
     argint(1, &major) < 0 ||
801061e3:	83 c4 10             	add    $0x10,%esp
801061e6:	85 c0                	test   %eax,%eax
801061e8:	78 36                	js     80106220 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801061ea:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801061ee:	83 ec 0c             	sub    $0xc,%esp
801061f1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801061f5:	ba 03 00 00 00       	mov    $0x3,%edx
801061fa:	50                   	push   %eax
801061fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801061fe:	e8 1d f7 ff ff       	call   80105920 <create>
     argint(2, &minor) < 0 ||
80106203:	83 c4 10             	add    $0x10,%esp
80106206:	85 c0                	test   %eax,%eax
80106208:	74 16                	je     80106220 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010620a:	83 ec 0c             	sub    $0xc,%esp
8010620d:	50                   	push   %eax
8010620e:	e8 0d c6 ff ff       	call   80102820 <iunlockput>
  end_op();
80106213:	e8 98 d9 ff ff       	call   80103bb0 <end_op>
  return 0;
80106218:	83 c4 10             	add    $0x10,%esp
8010621b:	31 c0                	xor    %eax,%eax
}
8010621d:	c9                   	leave
8010621e:	c3                   	ret
8010621f:	90                   	nop
    end_op();
80106220:	e8 8b d9 ff ff       	call   80103bb0 <end_op>
    return -1;
80106225:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010622a:	c9                   	leave
8010622b:	c3                   	ret
8010622c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106230 <sys_chdir>:

int
sys_chdir(void)
{
80106230:	55                   	push   %ebp
80106231:	89 e5                	mov    %esp,%ebp
80106233:	56                   	push   %esi
80106234:	53                   	push   %ebx
80106235:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106238:	e8 33 e5 ff ff       	call   80104770 <myproc>
8010623d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010623f:	e8 fc d8 ff ff       	call   80103b40 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106244:	83 ec 08             	sub    $0x8,%esp
80106247:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010624a:	50                   	push   %eax
8010624b:	6a 00                	push   $0x0
8010624d:	e8 de f5 ff ff       	call   80105830 <argstr>
80106252:	83 c4 10             	add    $0x10,%esp
80106255:	85 c0                	test   %eax,%eax
80106257:	78 77                	js     801062d0 <sys_chdir+0xa0>
80106259:	83 ec 0c             	sub    $0xc,%esp
8010625c:	ff 75 f4             	push   -0xc(%ebp)
8010625f:	e8 0c cc ff ff       	call   80102e70 <namei>
80106264:	83 c4 10             	add    $0x10,%esp
80106267:	89 c3                	mov    %eax,%ebx
80106269:	85 c0                	test   %eax,%eax
8010626b:	74 63                	je     801062d0 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010626d:	83 ec 0c             	sub    $0xc,%esp
80106270:	50                   	push   %eax
80106271:	e8 1a c3 ff ff       	call   80102590 <ilock>
  if(ip->type != T_DIR){
80106276:	83 c4 10             	add    $0x10,%esp
80106279:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010627e:	75 30                	jne    801062b0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80106280:	83 ec 0c             	sub    $0xc,%esp
80106283:	53                   	push   %ebx
80106284:	e8 e7 c3 ff ff       	call   80102670 <iunlock>
  iput(curproc->cwd);
80106289:	58                   	pop    %eax
8010628a:	ff 76 68             	push   0x68(%esi)
8010628d:	e8 2e c4 ff ff       	call   801026c0 <iput>
  end_op();
80106292:	e8 19 d9 ff ff       	call   80103bb0 <end_op>
  curproc->cwd = ip;
80106297:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010629a:	83 c4 10             	add    $0x10,%esp
8010629d:	31 c0                	xor    %eax,%eax
}
8010629f:	8d 65 f8             	lea    -0x8(%ebp),%esp
801062a2:	5b                   	pop    %ebx
801062a3:	5e                   	pop    %esi
801062a4:	5d                   	pop    %ebp
801062a5:	c3                   	ret
801062a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801062ad:	00 
801062ae:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
801062b0:	83 ec 0c             	sub    $0xc,%esp
801062b3:	53                   	push   %ebx
801062b4:	e8 67 c5 ff ff       	call   80102820 <iunlockput>
    end_op();
801062b9:	e8 f2 d8 ff ff       	call   80103bb0 <end_op>
    return -1;
801062be:	83 c4 10             	add    $0x10,%esp
    return -1;
801062c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062c6:	eb d7                	jmp    8010629f <sys_chdir+0x6f>
801062c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801062cf:	00 
    end_op();
801062d0:	e8 db d8 ff ff       	call   80103bb0 <end_op>
    return -1;
801062d5:	eb ea                	jmp    801062c1 <sys_chdir+0x91>
801062d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801062de:	00 
801062df:	90                   	nop

801062e0 <sys_exec>:

int
sys_exec(void)
{
801062e0:	55                   	push   %ebp
801062e1:	89 e5                	mov    %esp,%ebp
801062e3:	57                   	push   %edi
801062e4:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801062e5:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801062eb:	53                   	push   %ebx
801062ec:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801062f2:	50                   	push   %eax
801062f3:	6a 00                	push   $0x0
801062f5:	e8 36 f5 ff ff       	call   80105830 <argstr>
801062fa:	83 c4 10             	add    $0x10,%esp
801062fd:	85 c0                	test   %eax,%eax
801062ff:	0f 88 87 00 00 00    	js     8010638c <sys_exec+0xac>
80106305:	83 ec 08             	sub    $0x8,%esp
80106308:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010630e:	50                   	push   %eax
8010630f:	6a 01                	push   $0x1
80106311:	e8 5a f4 ff ff       	call   80105770 <argint>
80106316:	83 c4 10             	add    $0x10,%esp
80106319:	85 c0                	test   %eax,%eax
8010631b:	78 6f                	js     8010638c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010631d:	83 ec 04             	sub    $0x4,%esp
80106320:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80106326:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106328:	68 80 00 00 00       	push   $0x80
8010632d:	6a 00                	push   $0x0
8010632f:	56                   	push   %esi
80106330:	e8 8b f1 ff ff       	call   801054c0 <memset>
80106335:	83 c4 10             	add    $0x10,%esp
80106338:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010633f:	00 
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106340:	83 ec 08             	sub    $0x8,%esp
80106343:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80106349:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80106350:	50                   	push   %eax
80106351:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106357:	01 f8                	add    %edi,%eax
80106359:	50                   	push   %eax
8010635a:	e8 81 f3 ff ff       	call   801056e0 <fetchint>
8010635f:	83 c4 10             	add    $0x10,%esp
80106362:	85 c0                	test   %eax,%eax
80106364:	78 26                	js     8010638c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80106366:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010636c:	85 c0                	test   %eax,%eax
8010636e:	74 30                	je     801063a0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80106370:	83 ec 08             	sub    $0x8,%esp
80106373:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80106376:	52                   	push   %edx
80106377:	50                   	push   %eax
80106378:	e8 a3 f3 ff ff       	call   80105720 <fetchstr>
8010637d:	83 c4 10             	add    $0x10,%esp
80106380:	85 c0                	test   %eax,%eax
80106382:	78 08                	js     8010638c <sys_exec+0xac>
  for(i=0;; i++){
80106384:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80106387:	83 fb 20             	cmp    $0x20,%ebx
8010638a:	75 b4                	jne    80106340 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010638c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010638f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106394:	5b                   	pop    %ebx
80106395:	5e                   	pop    %esi
80106396:	5f                   	pop    %edi
80106397:	5d                   	pop    %ebp
80106398:	c3                   	ret
80106399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
801063a0:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801063a7:	00 00 00 00 
  return exec(path, argv);
801063ab:	83 ec 08             	sub    $0x8,%esp
801063ae:	56                   	push   %esi
801063af:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
801063b5:	e8 76 af ff ff       	call   80101330 <exec>
801063ba:	83 c4 10             	add    $0x10,%esp
}
801063bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801063c0:	5b                   	pop    %ebx
801063c1:	5e                   	pop    %esi
801063c2:	5f                   	pop    %edi
801063c3:	5d                   	pop    %ebp
801063c4:	c3                   	ret
801063c5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801063cc:	00 
801063cd:	8d 76 00             	lea    0x0(%esi),%esi

801063d0 <sys_pipe>:

int
sys_pipe(void)
{
801063d0:	55                   	push   %ebp
801063d1:	89 e5                	mov    %esp,%ebp
801063d3:	57                   	push   %edi
801063d4:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801063d5:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
801063d8:	53                   	push   %ebx
801063d9:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801063dc:	6a 08                	push   $0x8
801063de:	50                   	push   %eax
801063df:	6a 00                	push   $0x0
801063e1:	e8 da f3 ff ff       	call   801057c0 <argptr>
801063e6:	83 c4 10             	add    $0x10,%esp
801063e9:	85 c0                	test   %eax,%eax
801063eb:	0f 88 8b 00 00 00    	js     8010647c <sys_pipe+0xac>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801063f1:	83 ec 08             	sub    $0x8,%esp
801063f4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801063f7:	50                   	push   %eax
801063f8:	8d 45 e0             	lea    -0x20(%ebp),%eax
801063fb:	50                   	push   %eax
801063fc:	e8 0f de ff ff       	call   80104210 <pipealloc>
80106401:	83 c4 10             	add    $0x10,%esp
80106404:	85 c0                	test   %eax,%eax
80106406:	78 74                	js     8010647c <sys_pipe+0xac>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106408:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010640b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010640d:	e8 5e e3 ff ff       	call   80104770 <myproc>
    if(curproc->ofile[fd] == 0){
80106412:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80106416:	85 f6                	test   %esi,%esi
80106418:	74 16                	je     80106430 <sys_pipe+0x60>
8010641a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106420:	83 c3 01             	add    $0x1,%ebx
80106423:	83 fb 10             	cmp    $0x10,%ebx
80106426:	74 3d                	je     80106465 <sys_pipe+0x95>
    if(curproc->ofile[fd] == 0){
80106428:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010642c:	85 f6                	test   %esi,%esi
8010642e:	75 f0                	jne    80106420 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80106430:	8d 73 08             	lea    0x8(%ebx),%esi
80106433:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106437:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010643a:	e8 31 e3 ff ff       	call   80104770 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010643f:	31 d2                	xor    %edx,%edx
80106441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80106448:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
8010644c:	85 c9                	test   %ecx,%ecx
8010644e:	74 38                	je     80106488 <sys_pipe+0xb8>
  for(fd = 0; fd < NOFILE; fd++){
80106450:	83 c2 01             	add    $0x1,%edx
80106453:	83 fa 10             	cmp    $0x10,%edx
80106456:	75 f0                	jne    80106448 <sys_pipe+0x78>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80106458:	e8 13 e3 ff ff       	call   80104770 <myproc>
8010645d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80106464:	00 
    fileclose(rf);
80106465:	83 ec 0c             	sub    $0xc,%esp
80106468:	ff 75 e0             	push   -0x20(%ebp)
8010646b:	e8 20 b3 ff ff       	call   80101790 <fileclose>
    fileclose(wf);
80106470:	58                   	pop    %eax
80106471:	ff 75 e4             	push   -0x1c(%ebp)
80106474:	e8 17 b3 ff ff       	call   80101790 <fileclose>
    return -1;
80106479:	83 c4 10             	add    $0x10,%esp
    return -1;
8010647c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106481:	eb 16                	jmp    80106499 <sys_pipe+0xc9>
80106483:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80106488:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
8010648c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010648f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80106491:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106494:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80106497:	31 c0                	xor    %eax,%eax
}
80106499:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010649c:	5b                   	pop    %ebx
8010649d:	5e                   	pop    %esi
8010649e:	5f                   	pop    %edi
8010649f:	5d                   	pop    %ebp
801064a0:	c3                   	ret
801064a1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801064a8:	00 
801064a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801064b0 <sys_diff>:

int
sys_diff(void)
{
801064b0:	55                   	push   %ebp
801064b1:	89 e5                	mov    %esp,%ebp
801064b3:	57                   	push   %edi
801064b4:	56                   	push   %esi
  struct inode *ip1, *ip2;
  char buf1[512], buf2[512];
  int line, diff_found;
  
  // Get the two file names as arguments
  if(argstr(0, &file1) < 0 || argstr(1, &file2) < 0)
801064b5:	8d 85 e0 fb ff ff    	lea    -0x420(%ebp),%eax
{
801064bb:	53                   	push   %ebx
801064bc:	81 ec 44 04 00 00    	sub    $0x444,%esp
  if(argstr(0, &file1) < 0 || argstr(1, &file2) < 0)
801064c2:	50                   	push   %eax
801064c3:	6a 00                	push   $0x0
801064c5:	e8 66 f3 ff ff       	call   80105830 <argstr>
801064ca:	83 c4 10             	add    $0x10,%esp
801064cd:	85 c0                	test   %eax,%eax
801064cf:	0f 88 ea 02 00 00    	js     801067bf <sys_diff+0x30f>
801064d5:	83 ec 08             	sub    $0x8,%esp
801064d8:	8d 85 e4 fb ff ff    	lea    -0x41c(%ebp),%eax
801064de:	50                   	push   %eax
801064df:	6a 01                	push   $0x1
801064e1:	e8 4a f3 ff ff       	call   80105830 <argstr>
801064e6:	83 c4 10             	add    $0x10,%esp
801064e9:	85 c0                	test   %eax,%eax
801064eb:	0f 88 ce 02 00 00    	js     801067bf <sys_diff+0x30f>
    return -1;
  
  // Open the first file
  begin_op();
801064f1:	e8 4a d6 ff ff       	call   80103b40 <begin_op>
  if((ip1 = namei(file1)) == 0){
801064f6:	83 ec 0c             	sub    $0xc,%esp
801064f9:	ff b5 e0 fb ff ff    	push   -0x420(%ebp)
801064ff:	e8 6c c9 ff ff       	call   80102e70 <namei>
80106504:	83 c4 10             	add    $0x10,%esp
80106507:	89 c3                	mov    %eax,%ebx
80106509:	85 c0                	test   %eax,%eax
8010650b:	0f 84 26 05 00 00    	je     80106a37 <sys_diff+0x587>
    end_op();
    cprintf("diff: cannot open %s\n", file1);
    return -1;
  }
  
  ilock(ip1);
80106511:	83 ec 0c             	sub    $0xc,%esp
80106514:	50                   	push   %eax
80106515:	e8 76 c0 ff ff       	call   80102590 <ilock>
  if(ip1->type == T_DIR){
8010651a:	83 c4 10             	add    $0x10,%esp
8010651d:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106522:	0f 84 70 04 00 00    	je     80106998 <sys_diff+0x4e8>
    iunlockput(ip1);
    end_op();
    cprintf("diff: %s is a directory\n", file1);
    return -1;
  }
  iunlock(ip1);
80106528:	83 ec 0c             	sub    $0xc,%esp
8010652b:	53                   	push   %ebx
8010652c:	e8 3f c1 ff ff       	call   80102670 <iunlock>
  
  if((f1 = filealloc()) == 0){
80106531:	e8 9a b1 ff ff       	call   801016d0 <filealloc>
80106536:	83 c4 10             	add    $0x10,%esp
80106539:	89 85 bc fb ff ff    	mov    %eax,-0x444(%ebp)
8010653f:	85 c0                	test   %eax,%eax
80106541:	0f 84 da 04 00 00    	je     80106a21 <sys_diff+0x571>
    end_op();
    return -1;
  }
  
  // Initialize the first file
  f1->type = FD_INODE;
80106547:	8b 85 bc fb ff ff    	mov    -0x444(%ebp),%eax
  f1->off = 0;
  f1->readable = 1;
  f1->writable = 0;
  
  // Open the second file
  if((ip2 = namei(file2)) == 0){
8010654d:	83 ec 0c             	sub    $0xc,%esp
  f1->ip = ip1;
80106550:	89 58 10             	mov    %ebx,0x10(%eax)
  f1->readable = 1;
80106553:	0f b7 1d 54 91 10 80 	movzwl 0x80109154,%ebx
  f1->type = FD_INODE;
8010655a:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f1->off = 0;
80106560:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f1->readable = 1;
80106567:	66 89 58 08          	mov    %bx,0x8(%eax)
  if((ip2 = namei(file2)) == 0){
8010656b:	ff b5 e4 fb ff ff    	push   -0x41c(%ebp)
80106571:	e8 fa c8 ff ff       	call   80102e70 <namei>
80106576:	83 c4 10             	add    $0x10,%esp
80106579:	89 c6                	mov    %eax,%esi
8010657b:	85 c0                	test   %eax,%eax
8010657d:	0f 84 71 04 00 00    	je     801069f4 <sys_diff+0x544>
    end_op();
    cprintf("diff: cannot open %s\n", file2);
    return -1;
  }
  
  ilock(ip2);
80106583:	83 ec 0c             	sub    $0xc,%esp
80106586:	50                   	push   %eax
80106587:	e8 04 c0 ff ff       	call   80102590 <ilock>
  if(ip2->type == T_DIR){
8010658c:	83 c4 10             	add    $0x10,%esp
8010658f:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80106594:	0f 84 26 04 00 00    	je     801069c0 <sys_diff+0x510>
    fileclose(f1);
    end_op();
    cprintf("diff: %s is a directory\n", file2);
    return -1;
  }
  iunlock(ip2);
8010659a:	83 ec 0c             	sub    $0xc,%esp
8010659d:	56                   	push   %esi
8010659e:	e8 cd c0 ff ff       	call   80102670 <iunlock>
  
  if((f2 = filealloc()) == 0){
801065a3:	e8 28 b1 ff ff       	call   801016d0 <filealloc>
801065a8:	83 c4 10             	add    $0x10,%esp
801065ab:	89 85 d4 fb ff ff    	mov    %eax,-0x42c(%ebp)
801065b1:	85 c0                	test   %eax,%eax
801065b3:	0f 84 9e 04 00 00    	je     80106a57 <sys_diff+0x5a7>
    end_op();
    return -1;
  }
  
  // Initialize the second file
  f2->type = FD_INODE;
801065b9:	8b 85 d4 fb ff ff    	mov    -0x42c(%ebp),%eax
801065bf:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f2->ip = ip2;
801065c5:	89 70 10             	mov    %esi,0x10(%eax)
  f2->off = 0;
801065c8:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f2->readable = 1;
801065cf:	66 89 58 08          	mov    %bx,0x8(%eax)
  f2->writable = 0;
  
  end_op();
801065d3:	e8 d8 d5 ff ff       	call   80103bb0 <end_op>
  // Compare the files line by line
  line = 1;
  diff_found = 0;
  char *p1, *p2;
  int i1, i2;
  int eof1 = 0, eof2 = 0;
801065d8:	c7 85 cc fb ff ff 00 	movl   $0x0,-0x434(%ebp)
801065df:	00 00 00 
801065e2:	c7 85 d0 fb ff ff 00 	movl   $0x0,-0x430(%ebp)
801065e9:	00 00 00 
  diff_found = 0;
801065ec:	c7 85 b8 fb ff ff 00 	movl   $0x0,-0x448(%ebp)
801065f3:	00 00 00 
  line = 1;
801065f6:	c7 85 c4 fb ff ff 01 	movl   $0x1,-0x43c(%ebp)
801065fd:	00 00 00 
  while(!eof1 || !eof2){
    // Read a line from the first file
    p1 = buf1;
    i1 = 0;
    
    if(!eof1){
80106600:	8b 85 d0 fb ff ff    	mov    -0x430(%ebp),%eax
80106606:	85 c0                	test   %eax,%eax
80106608:	74 56                	je     80106660 <sys_diff+0x1b0>
    
    // Read a line from the second file
    p2 = buf2;
    i2 = 0;
    
    if(!eof2){
8010660a:	8b 85 cc fb ff ff    	mov    -0x434(%ebp),%eax
80106610:	85 c0                	test   %eax,%eax
80106612:	0f 84 38 02 00 00    	je     80106850 <sys_diff+0x3a0>
    
    line++;
  }
  
  // If one file has more content than the other
  if(eof1 && !eof2){
80106618:	b8 01 00 00 00       	mov    $0x1,%eax
    diff_found = 1;
    cprintf("File %s has more lines\n", file2);
  } else if(!eof1 && eof2){
8010661d:	8b 95 cc fb ff ff    	mov    -0x434(%ebp),%edx
80106623:	83 f2 01             	xor    $0x1,%edx
80106626:	85 c2                	test   %eax,%edx
80106628:	0f 85 f1 02 00 00    	jne    8010691f <sys_diff+0x46f>
    diff_found = 1;
    cprintf("File %s has more lines\n", file1);
  }
  
  // Close the files
  fileclose(f1);
8010662e:	83 ec 0c             	sub    $0xc,%esp
80106631:	ff b5 bc fb ff ff    	push   -0x444(%ebp)
80106637:	e8 54 b1 ff ff       	call   80101790 <fileclose>
  fileclose(f2);
8010663c:	58                   	pop    %eax
8010663d:	ff b5 d4 fb ff ff    	push   -0x42c(%ebp)
80106643:	e8 48 b1 ff ff       	call   80101790 <fileclose>
  
  return diff_found ? -1 : 0;
80106648:	8b 85 b8 fb ff ff    	mov    -0x448(%ebp),%eax
8010664e:	83 c4 10             	add    $0x10,%esp
80106651:	f7 d8                	neg    %eax
}
80106653:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106656:	5b                   	pop    %ebx
80106657:	5e                   	pop    %esi
80106658:	5f                   	pop    %edi
80106659:	5d                   	pop    %ebp
8010665a:	c3                   	ret
8010665b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80106660:	8b b5 bc fb ff ff    	mov    -0x444(%ebp),%esi
    i1 = 0;
80106666:	31 ff                	xor    %edi,%edi
80106668:	eb 25                	jmp    8010668f <sys_diff+0x1df>
8010666a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if(*p1 == '\n'){
80106670:	80 bc 3d e8 fb ff ff 	cmpb   $0xa,-0x418(%ebp,%edi,1)
80106677:	0a 
          i1++;
80106678:	8d 5f 01             	lea    0x1(%edi),%ebx
        if(*p1 == '\n'){
8010667b:	0f 84 3f 02 00 00    	je     801068c0 <sys_diff+0x410>
      while(i1 < sizeof(buf1) - 1){
80106681:	81 fb ff 01 00 00    	cmp    $0x1ff,%ebx
80106687:	0f 84 b5 02 00 00    	je     80106942 <sys_diff+0x492>
8010668d:	89 df                	mov    %ebx,%edi
        if(fileread(f1, p1, 1) != 1){
8010668f:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
80106695:	83 ec 04             	sub    $0x4,%esp
80106698:	01 f8                	add    %edi,%eax
8010669a:	6a 01                	push   $0x1
8010669c:	50                   	push   %eax
8010669d:	56                   	push   %esi
8010669e:	e8 1d b2 ff ff       	call   801018c0 <fileread>
801066a3:	83 c4 10             	add    $0x10,%esp
801066a6:	83 f8 01             	cmp    $0x1,%eax
801066a9:	74 c5                	je     80106670 <sys_diff+0x1c0>
    if(!eof2){
801066ab:	8b 8d cc fb ff ff    	mov    -0x434(%ebp),%ecx
801066b1:	85 c9                	test   %ecx,%ecx
801066b3:	0f 84 87 01 00 00    	je     80106840 <sys_diff+0x390>
801066b9:	8b 95 cc fb ff ff    	mov    -0x434(%ebp),%edx
801066bf:	89 f8                	mov    %edi,%eax
      i2 = 0;
801066c1:	31 db                	xor    %ebx,%ebx
801066c3:	89 95 d0 fb ff ff    	mov    %edx,-0x430(%ebp)
    if(i1 == 0 && i2 == 0)
801066c9:	85 c0                	test   %eax,%eax
801066cb:	0f 84 b6 02 00 00    	je     80106987 <sys_diff+0x4d7>
801066d1:	c7 85 c0 fb ff ff 00 	movl   $0x0,-0x440(%ebp)
801066d8:	00 00 00 
801066db:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
801066e1:	c7 85 cc fb ff ff 01 	movl   $0x1,-0x434(%ebp)
801066e8:	00 00 00 
    if(i1 != i2 || memcmp(buf1, buf2, i1 < i2 ? i1 : i2) != 0){
801066eb:	8b 85 d0 fb ff ff    	mov    -0x430(%ebp),%eax
801066f1:	8b 8d c0 fb ff ff    	mov    -0x440(%ebp),%ecx
801066f7:	83 f0 01             	xor    $0x1,%eax
801066fa:	09 c1                	or     %eax,%ecx
801066fc:	89 8d c8 fb ff ff    	mov    %ecx,-0x438(%ebp)
80106702:	39 df                	cmp    %ebx,%edi
80106704:	0f 84 e6 00 00 00    	je     801067f0 <sys_diff+0x340>
      cprintf("Line %d: files differ\n", line);
8010670a:	83 ec 08             	sub    $0x8,%esp
8010670d:	ff b5 c4 fb ff ff    	push   -0x43c(%ebp)
80106713:	68 61 8b 10 80       	push   $0x80108b61
80106718:	e8 23 a5 ff ff       	call   80100c40 <cprintf>
      buf1[i1] = '\0';
8010671d:	c6 84 3d e8 fb ff ff 	movb   $0x0,-0x418(%ebp,%edi,1)
80106724:	00 
      buf2[i2] = '\0';
80106725:	c6 84 1d e8 fd ff ff 	movb   $0x0,-0x218(%ebp,%ebx,1)
8010672c:	00 
      cprintf("< %s", buf1);
8010672d:	58                   	pop    %eax
8010672e:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
80106734:	5a                   	pop    %edx
80106735:	50                   	push   %eax
80106736:	68 78 8b 10 80       	push   $0x80108b78
8010673b:	e8 00 a5 ff ff       	call   80100c40 <cprintf>
      if(i1 > 0 && buf1[i1-1] != '\n')
80106740:	83 c4 10             	add    $0x10,%esp
80106743:	85 ff                	test   %edi,%edi
80106745:	0f 85 cd 00 00 00    	jne    80106818 <sys_diff+0x368>
      cprintf("> %s", buf2);
8010674b:	83 ec 08             	sub    $0x8,%esp
8010674e:	56                   	push   %esi
8010674f:	68 7d 8b 10 80       	push   $0x80108b7d
80106754:	e8 e7 a4 ff ff       	call   80100c40 <cprintf>
      if(i2 > 0 && buf2[i2-1] != '\n')
80106759:	83 c4 10             	add    $0x10,%esp
8010675c:	85 db                	test   %ebx,%ebx
8010675e:	75 70                	jne    801067d0 <sys_diff+0x320>
      diff_found = 1;
80106760:	c7 85 b8 fb ff ff 01 	movl   $0x1,-0x448(%ebp)
80106767:	00 00 00 
  while(!eof1 || !eof2){
8010676a:	8b 9d c8 fb ff ff    	mov    -0x438(%ebp),%ebx
    line++;
80106770:	83 85 c4 fb ff ff 01 	addl   $0x1,-0x43c(%ebp)
  while(!eof1 || !eof2){
80106777:	85 db                	test   %ebx,%ebx
80106779:	0f 85 81 fe ff ff    	jne    80106600 <sys_diff+0x150>
  if(eof1 && !eof2){
8010677f:	8b 95 c0 fb ff ff    	mov    -0x440(%ebp),%edx
80106785:	85 95 d0 fb ff ff    	test   %edx,-0x430(%ebp)
8010678b:	0f 84 e9 02 00 00    	je     80106a7a <sys_diff+0x5ca>
    cprintf("File %s has more lines\n", file2);
80106791:	83 ec 08             	sub    $0x8,%esp
80106794:	ff b5 e4 fb ff ff    	push   -0x41c(%ebp)
    cprintf("File %s has more lines\n", file1);
8010679a:	68 82 8b 10 80       	push   $0x80108b82
8010679f:	e8 9c a4 ff ff       	call   80100c40 <cprintf>
  fileclose(f1);
801067a4:	5a                   	pop    %edx
801067a5:	ff b5 bc fb ff ff    	push   -0x444(%ebp)
801067ab:	e8 e0 af ff ff       	call   80101790 <fileclose>
  fileclose(f2);
801067b0:	59                   	pop    %ecx
801067b1:	ff b5 d4 fb ff ff    	push   -0x42c(%ebp)
801067b7:	e8 d4 af ff ff       	call   80101790 <fileclose>
801067bc:	83 c4 10             	add    $0x10,%esp
    return -1;
801067bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801067c4:	e9 8a fe ff ff       	jmp    80106653 <sys_diff+0x1a3>
801067c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(i2 > 0 && buf2[i2-1] != '\n')
801067d0:	80 bc 1d e7 fd ff ff 	cmpb   $0xa,-0x219(%ebp,%ebx,1)
801067d7:	0a 
801067d8:	74 86                	je     80106760 <sys_diff+0x2b0>
        cprintf("\n");
801067da:	83 ec 0c             	sub    $0xc,%esp
801067dd:	68 5b 8c 10 80       	push   $0x80108c5b
801067e2:	e8 59 a4 ff ff       	call   80100c40 <cprintf>
801067e7:	83 c4 10             	add    $0x10,%esp
801067ea:	e9 71 ff ff ff       	jmp    80106760 <sys_diff+0x2b0>
801067ef:	90                   	nop
    if(i1 != i2 || memcmp(buf1, buf2, i1 < i2 ? i1 : i2) != 0){
801067f0:	83 ec 04             	sub    $0x4,%esp
801067f3:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
801067f9:	57                   	push   %edi
801067fa:	56                   	push   %esi
801067fb:	50                   	push   %eax
801067fc:	e8 ff ec ff ff       	call   80105500 <memcmp>
80106801:	83 c4 10             	add    $0x10,%esp
80106804:	85 c0                	test   %eax,%eax
80106806:	0f 85 fe fe ff ff    	jne    8010670a <sys_diff+0x25a>
8010680c:	e9 59 ff ff ff       	jmp    8010676a <sys_diff+0x2ba>
80106811:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(i1 > 0 && buf1[i1-1] != '\n')
80106818:	83 ef 01             	sub    $0x1,%edi
8010681b:	80 bc 3d e8 fb ff ff 	cmpb   $0xa,-0x418(%ebp,%edi,1)
80106822:	0a 
80106823:	0f 84 22 ff ff ff    	je     8010674b <sys_diff+0x29b>
        cprintf("\n");
80106829:	83 ec 0c             	sub    $0xc,%esp
8010682c:	68 5b 8c 10 80       	push   $0x80108c5b
80106831:	e8 0a a4 ff ff       	call   80100c40 <cprintf>
80106836:	83 c4 10             	add    $0x10,%esp
80106839:	e9 0d ff ff ff       	jmp    8010674b <sys_diff+0x29b>
8010683e:	66 90                	xchg   %ax,%ax
80106840:	89 bd cc fb ff ff    	mov    %edi,-0x434(%ebp)
80106846:	c7 85 d0 fb ff ff 01 	movl   $0x1,-0x430(%ebp)
8010684d:	00 00 00 
    i2 = 0;
80106850:	31 db                	xor    %ebx,%ebx
80106852:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
80106858:	eb 17                	jmp    80106871 <sys_diff+0x3c1>
8010685a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          i2++;
80106860:	83 c3 01             	add    $0x1,%ebx
        if(*p2 == '\n'){
80106863:	80 3c 3e 0a          	cmpb   $0xa,(%esi,%edi,1)
80106867:	74 37                	je     801068a0 <sys_diff+0x3f0>
      while(i2 < sizeof(buf2) - 1){
80106869:	81 fb ff 01 00 00    	cmp    $0x1ff,%ebx
8010686f:	74 2f                	je     801068a0 <sys_diff+0x3f0>
        if(fileread(f2, p2, 1) != 1){
80106871:	83 ec 04             	sub    $0x4,%esp
80106874:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
80106877:	89 df                	mov    %ebx,%edi
80106879:	6a 01                	push   $0x1
8010687b:	50                   	push   %eax
8010687c:	ff b5 d4 fb ff ff    	push   -0x42c(%ebp)
80106882:	e8 39 b0 ff ff       	call   801018c0 <fileread>
80106887:	83 c4 10             	add    $0x10,%esp
8010688a:	83 f8 01             	cmp    $0x1,%eax
8010688d:	74 d1                	je     80106860 <sys_diff+0x3b0>
    if(i1 == 0 && i2 == 0)
8010688f:	8b bd cc fb ff ff    	mov    -0x434(%ebp),%edi
80106895:	89 f8                	mov    %edi,%eax
80106897:	09 d8                	or     %ebx,%eax
80106899:	e9 2b fe ff ff       	jmp    801066c9 <sys_diff+0x219>
8010689e:	66 90                	xchg   %ax,%ax
801068a0:	8b bd cc fb ff ff    	mov    -0x434(%ebp),%edi
801068a6:	89 85 c0 fb ff ff    	mov    %eax,-0x440(%ebp)
801068ac:	c7 85 cc fb ff ff 00 	movl   $0x0,-0x434(%ebp)
801068b3:	00 00 00 
801068b6:	e9 30 fe ff ff       	jmp    801066eb <sys_diff+0x23b>
801068bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(!eof2){
801068c0:	8b b5 cc fb ff ff    	mov    -0x434(%ebp),%esi
801068c6:	85 f6                	test   %esi,%esi
801068c8:	74 63                	je     8010692d <sys_diff+0x47d>
      cprintf("Line %d: files differ\n", line);
801068ca:	83 ec 08             	sub    $0x8,%esp
801068cd:	ff b5 c4 fb ff ff    	push   -0x43c(%ebp)
801068d3:	68 61 8b 10 80       	push   $0x80108b61
801068d8:	e8 63 a3 ff ff       	call   80100c40 <cprintf>
      buf1[i1] = '\0';
801068dd:	c6 84 1d e8 fb ff ff 	movb   $0x0,-0x418(%ebp,%ebx,1)
801068e4:	00 
      buf2[i2] = '\0';
801068e5:	c6 85 e8 fd ff ff 00 	movb   $0x0,-0x218(%ebp)
      cprintf("< %s", buf1);
801068ec:	5b                   	pop    %ebx
      i2 = 0;
801068ed:	31 db                	xor    %ebx,%ebx
      cprintf("< %s", buf1);
801068ef:	58                   	pop    %eax
801068f0:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
801068f6:	50                   	push   %eax
801068f7:	68 78 8b 10 80       	push   $0x80108b78
801068fc:	e8 3f a3 ff ff       	call   80100c40 <cprintf>
80106901:	83 c4 10             	add    $0x10,%esp
80106904:	89 b5 c8 fb ff ff    	mov    %esi,-0x438(%ebp)
8010690a:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
80106910:	c7 85 c0 fb ff ff 00 	movl   $0x0,-0x440(%ebp)
80106917:	00 00 00 
8010691a:	e9 fc fe ff ff       	jmp    8010681b <sys_diff+0x36b>
    cprintf("File %s has more lines\n", file1);
8010691f:	83 ec 08             	sub    $0x8,%esp
80106922:	ff b5 e0 fb ff ff    	push   -0x420(%ebp)
80106928:	e9 6d fe ff ff       	jmp    8010679a <sys_diff+0x2ea>
    if(!eof2){
8010692d:	c7 85 d0 fb ff ff 00 	movl   $0x0,-0x430(%ebp)
80106934:	00 00 00 
          i1++;
80106937:	89 9d cc fb ff ff    	mov    %ebx,-0x434(%ebp)
8010693d:	e9 0e ff ff ff       	jmp    80106850 <sys_diff+0x3a0>
    if(!eof2){
80106942:	8b 85 cc fb ff ff    	mov    -0x434(%ebp),%eax
80106948:	85 c0                	test   %eax,%eax
8010694a:	74 22                	je     8010696e <sys_diff+0x4be>
8010694c:	89 85 c8 fb ff ff    	mov    %eax,-0x438(%ebp)
      i2 = 0;
80106952:	31 db                	xor    %ebx,%ebx
    if(!eof2){
80106954:	bf ff 01 00 00       	mov    $0x1ff,%edi
80106959:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
8010695f:	c7 85 c0 fb ff ff 00 	movl   $0x0,-0x440(%ebp)
80106966:	00 00 00 
80106969:	e9 9c fd ff ff       	jmp    8010670a <sys_diff+0x25a>
8010696e:	c7 85 d0 fb ff ff 00 	movl   $0x0,-0x430(%ebp)
80106975:	00 00 00 
80106978:	c7 85 cc fb ff ff ff 	movl   $0x1ff,-0x434(%ebp)
8010697f:	01 00 00 
80106982:	e9 c9 fe ff ff       	jmp    80106850 <sys_diff+0x3a0>
80106987:	8b 85 d0 fb ff ff    	mov    -0x430(%ebp),%eax
8010698d:	89 85 cc fb ff ff    	mov    %eax,-0x434(%ebp)
80106993:	e9 80 fc ff ff       	jmp    80106618 <sys_diff+0x168>
    iunlockput(ip1);
80106998:	83 ec 0c             	sub    $0xc,%esp
8010699b:	53                   	push   %ebx
8010699c:	e8 7f be ff ff       	call   80102820 <iunlockput>
    end_op();
801069a1:	e8 0a d2 ff ff       	call   80103bb0 <end_op>
    cprintf("diff: %s is a directory\n", file1);
801069a6:	5e                   	pop    %esi
801069a7:	5f                   	pop    %edi
801069a8:	ff b5 e0 fb ff ff    	push   -0x420(%ebp)
801069ae:	68 48 8b 10 80       	push   $0x80108b48
801069b3:	e8 88 a2 ff ff       	call   80100c40 <cprintf>
    return -1;
801069b8:	83 c4 10             	add    $0x10,%esp
801069bb:	e9 ff fd ff ff       	jmp    801067bf <sys_diff+0x30f>
    iunlockput(ip2);
801069c0:	83 ec 0c             	sub    $0xc,%esp
801069c3:	56                   	push   %esi
801069c4:	e8 57 be ff ff       	call   80102820 <iunlockput>
    fileclose(f1);
801069c9:	58                   	pop    %eax
801069ca:	ff b5 bc fb ff ff    	push   -0x444(%ebp)
801069d0:	e8 bb ad ff ff       	call   80101790 <fileclose>
    end_op();
801069d5:	e8 d6 d1 ff ff       	call   80103bb0 <end_op>
    cprintf("diff: %s is a directory\n", file2);
801069da:	58                   	pop    %eax
801069db:	5a                   	pop    %edx
801069dc:	ff b5 e4 fb ff ff    	push   -0x41c(%ebp)
801069e2:	68 48 8b 10 80       	push   $0x80108b48
801069e7:	e8 54 a2 ff ff       	call   80100c40 <cprintf>
    return -1;
801069ec:	83 c4 10             	add    $0x10,%esp
801069ef:	e9 cb fd ff ff       	jmp    801067bf <sys_diff+0x30f>
    fileclose(f1);
801069f4:	83 ec 0c             	sub    $0xc,%esp
801069f7:	ff b5 bc fb ff ff    	push   -0x444(%ebp)
801069fd:	e8 8e ad ff ff       	call   80101790 <fileclose>
    end_op();
80106a02:	e8 a9 d1 ff ff       	call   80103bb0 <end_op>
    cprintf("diff: cannot open %s\n", file2);
80106a07:	59                   	pop    %ecx
80106a08:	5b                   	pop    %ebx
80106a09:	ff b5 e4 fb ff ff    	push   -0x41c(%ebp)
80106a0f:	68 32 8b 10 80       	push   $0x80108b32
80106a14:	e8 27 a2 ff ff       	call   80100c40 <cprintf>
    return -1;
80106a19:	83 c4 10             	add    $0x10,%esp
80106a1c:	e9 9e fd ff ff       	jmp    801067bf <sys_diff+0x30f>
    iput(ip1);
80106a21:	83 ec 0c             	sub    $0xc,%esp
80106a24:	53                   	push   %ebx
80106a25:	e8 96 bc ff ff       	call   801026c0 <iput>
    end_op();
80106a2a:	e8 81 d1 ff ff       	call   80103bb0 <end_op>
    return -1;
80106a2f:	83 c4 10             	add    $0x10,%esp
80106a32:	e9 88 fd ff ff       	jmp    801067bf <sys_diff+0x30f>
    end_op();
80106a37:	e8 74 d1 ff ff       	call   80103bb0 <end_op>
    cprintf("diff: cannot open %s\n", file1);
80106a3c:	83 ec 08             	sub    $0x8,%esp
80106a3f:	ff b5 e0 fb ff ff    	push   -0x420(%ebp)
80106a45:	68 32 8b 10 80       	push   $0x80108b32
80106a4a:	e8 f1 a1 ff ff       	call   80100c40 <cprintf>
    return -1;
80106a4f:	83 c4 10             	add    $0x10,%esp
80106a52:	e9 68 fd ff ff       	jmp    801067bf <sys_diff+0x30f>
    fileclose(f1);
80106a57:	83 ec 0c             	sub    $0xc,%esp
80106a5a:	ff b5 bc fb ff ff    	push   -0x444(%ebp)
80106a60:	e8 2b ad ff ff       	call   80101790 <fileclose>
    iput(ip2);
80106a65:	89 34 24             	mov    %esi,(%esp)
80106a68:	e8 53 bc ff ff       	call   801026c0 <iput>
    end_op();
80106a6d:	e8 3e d1 ff ff       	call   80103bb0 <end_op>
    return -1;
80106a72:	83 c4 10             	add    $0x10,%esp
80106a75:	e9 45 fd ff ff       	jmp    801067bf <sys_diff+0x30f>
80106a7a:	8b 95 d0 fb ff ff    	mov    -0x430(%ebp),%edx
80106a80:	8b 85 cc fb ff ff    	mov    -0x434(%ebp),%eax
80106a86:	89 95 cc fb ff ff    	mov    %edx,-0x434(%ebp)
80106a8c:	e9 8c fb ff ff       	jmp    8010661d <sys_diff+0x16d>
80106a91:	66 90                	xchg   %ax,%ax
80106a93:	66 90                	xchg   %ax,%ax
80106a95:	66 90                	xchg   %ax,%ax
80106a97:	66 90                	xchg   %ax,%ax
80106a99:	66 90                	xchg   %ax,%ax
80106a9b:	66 90                	xchg   %ax,%ax
80106a9d:	66 90                	xchg   %ax,%ax
80106a9f:	90                   	nop

80106aa0 <sys_fork>:
} ptable;

int
sys_fork(void)
{
  return fork();
80106aa0:	e9 7b de ff ff       	jmp    80104920 <fork>
80106aa5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106aac:	00 
80106aad:	8d 76 00             	lea    0x0(%esi),%esi

80106ab0 <sys_exit>:
}

int
sys_exit(void)
{
80106ab0:	55                   	push   %ebp
80106ab1:	89 e5                	mov    %esp,%ebp
80106ab3:	83 ec 08             	sub    $0x8,%esp
  exit();
80106ab6:	e8 d5 e0 ff ff       	call   80104b90 <exit>
  return 0;  // not reached
}
80106abb:	31 c0                	xor    %eax,%eax
80106abd:	c9                   	leave
80106abe:	c3                   	ret
80106abf:	90                   	nop

80106ac0 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80106ac0:	e9 fb e1 ff ff       	jmp    80104cc0 <wait>
80106ac5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106acc:	00 
80106acd:	8d 76 00             	lea    0x0(%esi),%esi

80106ad0 <sys_kill>:
}

int
sys_kill(void)
{
80106ad0:	55                   	push   %ebp
80106ad1:	89 e5                	mov    %esp,%ebp
80106ad3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106ad6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106ad9:	50                   	push   %eax
80106ada:	6a 00                	push   $0x0
80106adc:	e8 8f ec ff ff       	call   80105770 <argint>
80106ae1:	83 c4 10             	add    $0x10,%esp
80106ae4:	85 c0                	test   %eax,%eax
80106ae6:	78 18                	js     80106b00 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106ae8:	83 ec 0c             	sub    $0xc,%esp
80106aeb:	ff 75 f4             	push   -0xc(%ebp)
80106aee:	e8 6d e4 ff ff       	call   80104f60 <kill>
80106af3:	83 c4 10             	add    $0x10,%esp
}
80106af6:	c9                   	leave
80106af7:	c3                   	ret
80106af8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106aff:	00 
80106b00:	c9                   	leave
    return -1;
80106b01:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b06:	c3                   	ret
80106b07:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106b0e:	00 
80106b0f:	90                   	nop

80106b10 <sys_getpid>:

int
sys_getpid(void)
{
80106b10:	55                   	push   %ebp
80106b11:	89 e5                	mov    %esp,%ebp
80106b13:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106b16:	e8 55 dc ff ff       	call   80104770 <myproc>
80106b1b:	8b 40 10             	mov    0x10(%eax),%eax
}
80106b1e:	c9                   	leave
80106b1f:	c3                   	ret

80106b20 <sys_sbrk>:

int
sys_sbrk(void)
{
80106b20:	55                   	push   %ebp
80106b21:	89 e5                	mov    %esp,%ebp
80106b23:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106b24:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106b27:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80106b2a:	50                   	push   %eax
80106b2b:	6a 00                	push   $0x0
80106b2d:	e8 3e ec ff ff       	call   80105770 <argint>
80106b32:	83 c4 10             	add    $0x10,%esp
80106b35:	85 c0                	test   %eax,%eax
80106b37:	78 27                	js     80106b60 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106b39:	e8 32 dc ff ff       	call   80104770 <myproc>
  if(growproc(n) < 0)
80106b3e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80106b41:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106b43:	ff 75 f4             	push   -0xc(%ebp)
80106b46:	e8 55 dd ff ff       	call   801048a0 <growproc>
80106b4b:	83 c4 10             	add    $0x10,%esp
80106b4e:	85 c0                	test   %eax,%eax
80106b50:	78 0e                	js     80106b60 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106b52:	89 d8                	mov    %ebx,%eax
80106b54:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106b57:	c9                   	leave
80106b58:	c3                   	ret
80106b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106b60:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106b65:	eb eb                	jmp    80106b52 <sys_sbrk+0x32>
80106b67:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106b6e:	00 
80106b6f:	90                   	nop

80106b70 <sys_sleep>:

int
sys_sleep(void)
{
80106b70:	55                   	push   %ebp
80106b71:	89 e5                	mov    %esp,%ebp
80106b73:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106b74:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106b77:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80106b7a:	50                   	push   %eax
80106b7b:	6a 00                	push   $0x0
80106b7d:	e8 ee eb ff ff       	call   80105770 <argint>
80106b82:	83 c4 10             	add    $0x10,%esp
80106b85:	85 c0                	test   %eax,%eax
80106b87:	78 64                	js     80106bed <sys_sleep+0x7d>
    return -1;
  acquire(&tickslock);
80106b89:	83 ec 0c             	sub    $0xc,%esp
80106b8c:	68 a0 81 11 80       	push   $0x801181a0
80106b91:	e8 2a e8 ff ff       	call   801053c0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106b96:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80106b99:	8b 1d 80 81 11 80    	mov    0x80118180,%ebx
  while(ticks - ticks0 < n){
80106b9f:	83 c4 10             	add    $0x10,%esp
80106ba2:	85 d2                	test   %edx,%edx
80106ba4:	75 2b                	jne    80106bd1 <sys_sleep+0x61>
80106ba6:	eb 58                	jmp    80106c00 <sys_sleep+0x90>
80106ba8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106baf:	00 
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106bb0:	83 ec 08             	sub    $0x8,%esp
80106bb3:	68 a0 81 11 80       	push   $0x801181a0
80106bb8:	68 80 81 11 80       	push   $0x80118180
80106bbd:	e8 7e e2 ff ff       	call   80104e40 <sleep>
  while(ticks - ticks0 < n){
80106bc2:	a1 80 81 11 80       	mov    0x80118180,%eax
80106bc7:	83 c4 10             	add    $0x10,%esp
80106bca:	29 d8                	sub    %ebx,%eax
80106bcc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80106bcf:	73 2f                	jae    80106c00 <sys_sleep+0x90>
    if(myproc()->killed){
80106bd1:	e8 9a db ff ff       	call   80104770 <myproc>
80106bd6:	8b 40 24             	mov    0x24(%eax),%eax
80106bd9:	85 c0                	test   %eax,%eax
80106bdb:	74 d3                	je     80106bb0 <sys_sleep+0x40>
      release(&tickslock);
80106bdd:	83 ec 0c             	sub    $0xc,%esp
80106be0:	68 a0 81 11 80       	push   $0x801181a0
80106be5:	e8 76 e7 ff ff       	call   80105360 <release>
      return -1;
80106bea:	83 c4 10             	add    $0x10,%esp
  }
  release(&tickslock);
  return 0;
}
80106bed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80106bf0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106bf5:	c9                   	leave
80106bf6:	c3                   	ret
80106bf7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106bfe:	00 
80106bff:	90                   	nop
  release(&tickslock);
80106c00:	83 ec 0c             	sub    $0xc,%esp
80106c03:	68 a0 81 11 80       	push   $0x801181a0
80106c08:	e8 53 e7 ff ff       	call   80105360 <release>
}
80106c0d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return 0;
80106c10:	83 c4 10             	add    $0x10,%esp
80106c13:	31 c0                	xor    %eax,%eax
}
80106c15:	c9                   	leave
80106c16:	c3                   	ret
80106c17:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106c1e:	00 
80106c1f:	90                   	nop

80106c20 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106c20:	55                   	push   %ebp
80106c21:	89 e5                	mov    %esp,%ebp
80106c23:	53                   	push   %ebx
80106c24:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80106c27:	68 a0 81 11 80       	push   $0x801181a0
80106c2c:	e8 8f e7 ff ff       	call   801053c0 <acquire>
  xticks = ticks;
80106c31:	8b 1d 80 81 11 80    	mov    0x80118180,%ebx
  release(&tickslock);
80106c37:	c7 04 24 a0 81 11 80 	movl   $0x801181a0,(%esp)
80106c3e:	e8 1d e7 ff ff       	call   80105360 <release>
  return xticks;
}
80106c43:	89 d8                	mov    %ebx,%eax
80106c45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106c48:	c9                   	leave
80106c49:	c3                   	ret
80106c4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106c50 <sys_set_sleep>:

int
sys_set_sleep(void)
{
80106c50:	55                   	push   %ebp
80106c51:	89 e5                	mov    %esp,%ebp
80106c53:	56                   	push   %esi
80106c54:	53                   	push   %ebx
80106c55:	83 ec 10             	sub    $0x10,%esp
  int n;
  uint ticks0;
  struct proc *p = myproc();
80106c58:	e8 13 db ff ff       	call   80104770 <myproc>
  
  if(argint(0, &n) < 0)
80106c5d:	83 ec 08             	sub    $0x8,%esp
  struct proc *p = myproc();
80106c60:	89 c3                	mov    %eax,%ebx
  if(argint(0, &n) < 0)
80106c62:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106c65:	50                   	push   %eax
80106c66:	6a 00                	push   $0x0
80106c68:	e8 03 eb ff ff       	call   80105770 <argint>
80106c6d:	83 c4 10             	add    $0x10,%esp
80106c70:	85 c0                	test   %eax,%eax
80106c72:	0f 88 be 00 00 00    	js     80106d36 <sys_set_sleep+0xe6>
    return -1;
  
  acquire(&tickslock);
80106c78:	83 ec 0c             	sub    $0xc,%esp
80106c7b:	68 a0 81 11 80       	push   $0x801181a0
80106c80:	e8 3b e7 ff ff       	call   801053c0 <acquire>
  ticks0 = ticks;
  
  while(ticks - ticks0 < n){
80106c85:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80106c88:	8b 35 80 81 11 80    	mov    0x80118180,%esi
  while(ticks - ticks0 < n){
80106c8e:	83 c4 10             	add    $0x10,%esp
80106c91:	85 d2                	test   %edx,%edx
80106c93:	0f 85 82 00 00 00    	jne    80106d1b <sys_set_sleep+0xcb>
80106c99:	e9 c6 00 00 00       	jmp    80106d64 <sys_set_sleep+0x114>
80106c9e:	66 90                	xchg   %ax,%ax
      release(&tickslock);
      return -1;
    }
    
    // We need to release tickslock before acquiring ptable.lock to avoid deadlock
    release(&tickslock);
80106ca0:	83 ec 0c             	sub    $0xc,%esp
80106ca3:	68 a0 81 11 80       	push   $0x801181a0
80106ca8:	e8 b3 e6 ff ff       	call   80105360 <release>
    
    // Acquire ptable.lock before changing process state
    acquire(&ptable.lock);
80106cad:	c7 04 24 40 61 11 80 	movl   $0x80116140,(%esp)
80106cb4:	e8 07 e7 ff ff       	call   801053c0 <acquire>
    
    // Check if we need to sleep again - reacquire tickslock to check
    acquire(&tickslock);
80106cb9:	c7 04 24 a0 81 11 80 	movl   $0x801181a0,(%esp)
80106cc0:	e8 fb e6 ff ff       	call   801053c0 <acquire>
    if(ticks - ticks0 >= n){
80106cc5:	a1 80 81 11 80       	mov    0x80118180,%eax
80106cca:	83 c4 10             	add    $0x10,%esp
80106ccd:	29 f0                	sub    %esi,%eax
80106ccf:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80106cd2:	73 74                	jae    80106d48 <sys_set_sleep+0xf8>
    // Mark process as sleeping on ticks
    p->chan = &ticks;
    p->state = SLEEPING;
    
    // Release tickslock before calling scheduler
    release(&tickslock);
80106cd4:	83 ec 0c             	sub    $0xc,%esp
    p->chan = &ticks;
80106cd7:	c7 43 20 80 81 11 80 	movl   $0x80118180,0x20(%ebx)
    p->state = SLEEPING;
80106cde:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
    release(&tickslock);
80106ce5:	68 a0 81 11 80       	push   $0x801181a0
80106cea:	e8 71 e6 ff ff       	call   80105360 <release>
    
    // Now we only hold ptable.lock as required by sched()
    sched();
80106cef:	e8 dc dd ff ff       	call   80104ad0 <sched>
    
    // When we return from scheduler, we need to reacquire tickslock
    acquire(&tickslock);
80106cf4:	c7 04 24 a0 81 11 80 	movl   $0x801181a0,(%esp)
80106cfb:	e8 c0 e6 ff ff       	call   801053c0 <acquire>
    
    // Release ptable.lock since we're done with it
    release(&ptable.lock);
80106d00:	c7 04 24 40 61 11 80 	movl   $0x80116140,(%esp)
80106d07:	e8 54 e6 ff ff       	call   80105360 <release>
  while(ticks - ticks0 < n){
80106d0c:	a1 80 81 11 80       	mov    0x80118180,%eax
80106d11:	83 c4 10             	add    $0x10,%esp
80106d14:	29 f0                	sub    %esi,%eax
80106d16:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80106d19:	73 49                	jae    80106d64 <sys_set_sleep+0x114>
    if(p->killed){
80106d1b:	8b 43 24             	mov    0x24(%ebx),%eax
80106d1e:	85 c0                	test   %eax,%eax
80106d20:	0f 84 7a ff ff ff    	je     80106ca0 <sys_set_sleep+0x50>
      release(&tickslock);
80106d26:	83 ec 0c             	sub    $0xc,%esp
80106d29:	68 a0 81 11 80       	push   $0x801181a0
80106d2e:	e8 2d e6 ff ff       	call   80105360 <release>
      return -1;
80106d33:	83 c4 10             	add    $0x10,%esp
  }
  
  release(&tickslock);
  return 0;
}
80106d36:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80106d39:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106d3e:	5b                   	pop    %ebx
80106d3f:	5e                   	pop    %esi
80106d40:	5d                   	pop    %ebp
80106d41:	c3                   	ret
80106d42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      release(&tickslock);
80106d48:	83 ec 0c             	sub    $0xc,%esp
80106d4b:	68 a0 81 11 80       	push   $0x801181a0
80106d50:	e8 0b e6 ff ff       	call   80105360 <release>
      release(&ptable.lock);
80106d55:	c7 04 24 40 61 11 80 	movl   $0x80116140,(%esp)
80106d5c:	e8 ff e5 ff ff       	call   80105360 <release>
      break;
80106d61:	83 c4 10             	add    $0x10,%esp
  release(&tickslock);
80106d64:	83 ec 0c             	sub    $0xc,%esp
80106d67:	68 a0 81 11 80       	push   $0x801181a0
80106d6c:	e8 ef e5 ff ff       	call   80105360 <release>
  return 0;
80106d71:	83 c4 10             	add    $0x10,%esp
}
80106d74:	8d 65 f8             	lea    -0x8(%ebp),%esp
  return 0;
80106d77:	31 c0                	xor    %eax,%eax
}
80106d79:	5b                   	pop    %ebx
80106d7a:	5e                   	pop    %esi
80106d7b:	5d                   	pop    %ebp
80106d7c:	c3                   	ret
80106d7d:	8d 76 00             	lea    0x0(%esi),%esi

80106d80 <sys_getcmostime>:

int
sys_getcmostime(void)
{
80106d80:	55                   	push   %ebp
80106d81:	89 e5                	mov    %esp,%ebp
80106d83:	83 ec 1c             	sub    $0x1c,%esp
  struct rtcdate *r;
  
  if(argptr(0, (char**)&r, sizeof(*r)) < 0)
80106d86:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106d89:	6a 18                	push   $0x18
80106d8b:	50                   	push   %eax
80106d8c:	6a 00                	push   $0x0
80106d8e:	e8 2d ea ff ff       	call   801057c0 <argptr>
80106d93:	83 c4 10             	add    $0x10,%esp
80106d96:	85 c0                	test   %eax,%eax
80106d98:	78 16                	js     80106db0 <sys_getcmostime+0x30>
    return -1;
  
  cmostime(r);
80106d9a:	83 ec 0c             	sub    $0xc,%esp
80106d9d:	ff 75 f4             	push   -0xc(%ebp)
80106da0:	e8 0b ca ff ff       	call   801037b0 <cmostime>
  return 0;
80106da5:	83 c4 10             	add    $0x10,%esp
80106da8:	31 c0                	xor    %eax,%eax
}
80106daa:	c9                   	leave
80106dab:	c3                   	ret
80106dac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106db0:	c9                   	leave
    return -1;
80106db1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106db6:	c3                   	ret

80106db7 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106db7:	1e                   	push   %ds
  pushl %es
80106db8:	06                   	push   %es
  pushl %fs
80106db9:	0f a0                	push   %fs
  pushl %gs
80106dbb:	0f a8                	push   %gs
  pushal
80106dbd:	60                   	pusha
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106dbe:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106dc2:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106dc4:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106dc6:	54                   	push   %esp
  call trap
80106dc7:	e8 c4 00 00 00       	call   80106e90 <trap>
  addl $4, %esp
80106dcc:	83 c4 04             	add    $0x4,%esp

80106dcf <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106dcf:	61                   	popa
  popl %gs
80106dd0:	0f a9                	pop    %gs
  popl %fs
80106dd2:	0f a1                	pop    %fs
  popl %es
80106dd4:	07                   	pop    %es
  popl %ds
80106dd5:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106dd6:	83 c4 08             	add    $0x8,%esp
  iret
80106dd9:	cf                   	iret
80106dda:	66 90                	xchg   %ax,%ax
80106ddc:	66 90                	xchg   %ax,%ax
80106dde:	66 90                	xchg   %ax,%ax

80106de0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106de0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106de1:	31 c0                	xor    %eax,%eax
{
80106de3:	89 e5                	mov    %esp,%ebp
80106de5:	83 ec 08             	sub    $0x8,%esp
80106de8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106def:	00 
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106df0:	8b 14 85 08 c0 10 80 	mov    -0x7fef3ff8(,%eax,4),%edx
80106df7:	c7 04 c5 e2 81 11 80 	movl   $0x8e000008,-0x7fee7e1e(,%eax,8)
80106dfe:	08 00 00 8e 
80106e02:	66 89 14 c5 e0 81 11 	mov    %dx,-0x7fee7e20(,%eax,8)
80106e09:	80 
80106e0a:	c1 ea 10             	shr    $0x10,%edx
80106e0d:	66 89 14 c5 e6 81 11 	mov    %dx,-0x7fee7e1a(,%eax,8)
80106e14:	80 
  for(i = 0; i < 256; i++)
80106e15:	83 c0 01             	add    $0x1,%eax
80106e18:	3d 00 01 00 00       	cmp    $0x100,%eax
80106e1d:	75 d1                	jne    80106df0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80106e1f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106e22:	a1 08 c1 10 80       	mov    0x8010c108,%eax
80106e27:	c7 05 e2 83 11 80 08 	movl   $0xef000008,0x801183e2
80106e2e:	00 00 ef 
  initlock(&tickslock, "time");
80106e31:	68 9a 8b 10 80       	push   $0x80108b9a
80106e36:	68 a0 81 11 80       	push   $0x801181a0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106e3b:	66 a3 e0 83 11 80    	mov    %ax,0x801183e0
80106e41:	c1 e8 10             	shr    $0x10,%eax
80106e44:	66 a3 e6 83 11 80    	mov    %ax,0x801183e6
  initlock(&tickslock, "time");
80106e4a:	e8 81 e3 ff ff       	call   801051d0 <initlock>
}
80106e4f:	83 c4 10             	add    $0x10,%esp
80106e52:	c9                   	leave
80106e53:	c3                   	ret
80106e54:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106e5b:	00 
80106e5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106e60 <idtinit>:

void
idtinit(void)
{
80106e60:	55                   	push   %ebp
  pd[0] = size-1;
80106e61:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106e66:	89 e5                	mov    %esp,%ebp
80106e68:	83 ec 10             	sub    $0x10,%esp
80106e6b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106e6f:	b8 e0 81 11 80       	mov    $0x801181e0,%eax
80106e74:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106e78:	c1 e8 10             	shr    $0x10,%eax
80106e7b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80106e7f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106e82:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106e85:	c9                   	leave
80106e86:	c3                   	ret
80106e87:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106e8e:	00 
80106e8f:	90                   	nop

80106e90 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106e90:	55                   	push   %ebp
80106e91:	89 e5                	mov    %esp,%ebp
80106e93:	57                   	push   %edi
80106e94:	56                   	push   %esi
80106e95:	53                   	push   %ebx
80106e96:	83 ec 1c             	sub    $0x1c,%esp
80106e99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80106e9c:	8b 43 30             	mov    0x30(%ebx),%eax
80106e9f:	83 f8 40             	cmp    $0x40,%eax
80106ea2:	0f 84 58 01 00 00    	je     80107000 <trap+0x170>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106ea8:	83 e8 20             	sub    $0x20,%eax
80106eab:	83 f8 1f             	cmp    $0x1f,%eax
80106eae:	0f 87 7c 00 00 00    	ja     80106f30 <trap+0xa0>
80106eb4:	ff 24 85 58 91 10 80 	jmp    *-0x7fef6ea8(,%eax,4)
80106ebb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106ec0:	e8 5b c1 ff ff       	call   80103020 <ideintr>
    lapiceoi();
80106ec5:	e8 26 c8 ff ff       	call   801036f0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106eca:	e8 a1 d8 ff ff       	call   80104770 <myproc>
80106ecf:	85 c0                	test   %eax,%eax
80106ed1:	74 1a                	je     80106eed <trap+0x5d>
80106ed3:	e8 98 d8 ff ff       	call   80104770 <myproc>
80106ed8:	8b 50 24             	mov    0x24(%eax),%edx
80106edb:	85 d2                	test   %edx,%edx
80106edd:	74 0e                	je     80106eed <trap+0x5d>
80106edf:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106ee3:	f7 d0                	not    %eax
80106ee5:	a8 03                	test   $0x3,%al
80106ee7:	0f 84 db 01 00 00    	je     801070c8 <trap+0x238>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106eed:	e8 7e d8 ff ff       	call   80104770 <myproc>
80106ef2:	85 c0                	test   %eax,%eax
80106ef4:	74 0f                	je     80106f05 <trap+0x75>
80106ef6:	e8 75 d8 ff ff       	call   80104770 <myproc>
80106efb:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106eff:	0f 84 ab 00 00 00    	je     80106fb0 <trap+0x120>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106f05:	e8 66 d8 ff ff       	call   80104770 <myproc>
80106f0a:	85 c0                	test   %eax,%eax
80106f0c:	74 1a                	je     80106f28 <trap+0x98>
80106f0e:	e8 5d d8 ff ff       	call   80104770 <myproc>
80106f13:	8b 40 24             	mov    0x24(%eax),%eax
80106f16:	85 c0                	test   %eax,%eax
80106f18:	74 0e                	je     80106f28 <trap+0x98>
80106f1a:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106f1e:	f7 d0                	not    %eax
80106f20:	a8 03                	test   $0x3,%al
80106f22:	0f 84 05 01 00 00    	je     8010702d <trap+0x19d>
    exit();
}
80106f28:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f2b:	5b                   	pop    %ebx
80106f2c:	5e                   	pop    %esi
80106f2d:	5f                   	pop    %edi
80106f2e:	5d                   	pop    %ebp
80106f2f:	c3                   	ret
    if(myproc() == 0 || (tf->cs&3) == 0){
80106f30:	e8 3b d8 ff ff       	call   80104770 <myproc>
80106f35:	8b 7b 38             	mov    0x38(%ebx),%edi
80106f38:	85 c0                	test   %eax,%eax
80106f3a:	0f 84 a2 01 00 00    	je     801070e2 <trap+0x252>
80106f40:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106f44:	0f 84 98 01 00 00    	je     801070e2 <trap+0x252>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106f4a:	0f 20 d1             	mov    %cr2,%ecx
80106f4d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106f50:	e8 fb d7 ff ff       	call   80104750 <cpuid>
80106f55:	8b 73 30             	mov    0x30(%ebx),%esi
80106f58:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106f5b:	8b 43 34             	mov    0x34(%ebx),%eax
80106f5e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80106f61:	e8 0a d8 ff ff       	call   80104770 <myproc>
80106f66:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106f69:	e8 02 d8 ff ff       	call   80104770 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106f6e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106f71:	51                   	push   %ecx
80106f72:	57                   	push   %edi
80106f73:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106f76:	52                   	push   %edx
80106f77:	ff 75 e4             	push   -0x1c(%ebp)
80106f7a:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80106f7b:	8b 75 e0             	mov    -0x20(%ebp),%esi
80106f7e:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106f81:	56                   	push   %esi
80106f82:	ff 70 10             	push   0x10(%eax)
80106f85:	68 38 8e 10 80       	push   $0x80108e38
80106f8a:	e8 b1 9c ff ff       	call   80100c40 <cprintf>
    myproc()->killed = 1;
80106f8f:	83 c4 20             	add    $0x20,%esp
80106f92:	e8 d9 d7 ff ff       	call   80104770 <myproc>
80106f97:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106f9e:	e8 cd d7 ff ff       	call   80104770 <myproc>
80106fa3:	85 c0                	test   %eax,%eax
80106fa5:	0f 85 28 ff ff ff    	jne    80106ed3 <trap+0x43>
80106fab:	e9 3d ff ff ff       	jmp    80106eed <trap+0x5d>
  if(myproc() && myproc()->state == RUNNING &&
80106fb0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106fb4:	0f 85 4b ff ff ff    	jne    80106f05 <trap+0x75>
    yield();
80106fba:	e8 31 de ff ff       	call   80104df0 <yield>
80106fbf:	e9 41 ff ff ff       	jmp    80106f05 <trap+0x75>
80106fc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106fc8:	8b 7b 38             	mov    0x38(%ebx),%edi
80106fcb:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80106fcf:	e8 7c d7 ff ff       	call   80104750 <cpuid>
80106fd4:	57                   	push   %edi
80106fd5:	56                   	push   %esi
80106fd6:	50                   	push   %eax
80106fd7:	68 e0 8d 10 80       	push   $0x80108de0
80106fdc:	e8 5f 9c ff ff       	call   80100c40 <cprintf>
    lapiceoi();
80106fe1:	e8 0a c7 ff ff       	call   801036f0 <lapiceoi>
    break;
80106fe6:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106fe9:	e8 82 d7 ff ff       	call   80104770 <myproc>
80106fee:	85 c0                	test   %eax,%eax
80106ff0:	0f 85 dd fe ff ff    	jne    80106ed3 <trap+0x43>
80106ff6:	e9 f2 fe ff ff       	jmp    80106eed <trap+0x5d>
80106ffb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80107000:	e8 6b d7 ff ff       	call   80104770 <myproc>
80107005:	8b 70 24             	mov    0x24(%eax),%esi
80107008:	85 f6                	test   %esi,%esi
8010700a:	0f 85 c8 00 00 00    	jne    801070d8 <trap+0x248>
    myproc()->tf = tf;
80107010:	e8 5b d7 ff ff       	call   80104770 <myproc>
80107015:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80107018:	e8 93 e8 ff ff       	call   801058b0 <syscall>
    if(myproc()->killed)
8010701d:	e8 4e d7 ff ff       	call   80104770 <myproc>
80107022:	8b 48 24             	mov    0x24(%eax),%ecx
80107025:	85 c9                	test   %ecx,%ecx
80107027:	0f 84 fb fe ff ff    	je     80106f28 <trap+0x98>
}
8010702d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107030:	5b                   	pop    %ebx
80107031:	5e                   	pop    %esi
80107032:	5f                   	pop    %edi
80107033:	5d                   	pop    %ebp
      exit();
80107034:	e9 57 db ff ff       	jmp    80104b90 <exit>
80107039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80107040:	e8 4b 02 00 00       	call   80107290 <uartintr>
    lapiceoi();
80107045:	e8 a6 c6 ff ff       	call   801036f0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010704a:	e8 21 d7 ff ff       	call   80104770 <myproc>
8010704f:	85 c0                	test   %eax,%eax
80107051:	0f 85 7c fe ff ff    	jne    80106ed3 <trap+0x43>
80107057:	e9 91 fe ff ff       	jmp    80106eed <trap+0x5d>
8010705c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80107060:	e8 5b c5 ff ff       	call   801035c0 <kbdintr>
    lapiceoi();
80107065:	e8 86 c6 ff ff       	call   801036f0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010706a:	e8 01 d7 ff ff       	call   80104770 <myproc>
8010706f:	85 c0                	test   %eax,%eax
80107071:	0f 85 5c fe ff ff    	jne    80106ed3 <trap+0x43>
80107077:	e9 71 fe ff ff       	jmp    80106eed <trap+0x5d>
8010707c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80107080:	e8 cb d6 ff ff       	call   80104750 <cpuid>
80107085:	85 c0                	test   %eax,%eax
80107087:	0f 85 38 fe ff ff    	jne    80106ec5 <trap+0x35>
      acquire(&tickslock);
8010708d:	83 ec 0c             	sub    $0xc,%esp
80107090:	68 a0 81 11 80       	push   $0x801181a0
80107095:	e8 26 e3 ff ff       	call   801053c0 <acquire>
      ticks++;
8010709a:	83 05 80 81 11 80 01 	addl   $0x1,0x80118180
      wakeup(&ticks);
801070a1:	c7 04 24 80 81 11 80 	movl   $0x80118180,(%esp)
801070a8:	e8 53 de ff ff       	call   80104f00 <wakeup>
      release(&tickslock);
801070ad:	c7 04 24 a0 81 11 80 	movl   $0x801181a0,(%esp)
801070b4:	e8 a7 e2 ff ff       	call   80105360 <release>
801070b9:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
801070bc:	e9 04 fe ff ff       	jmp    80106ec5 <trap+0x35>
801070c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
801070c8:	e8 c3 da ff ff       	call   80104b90 <exit>
801070cd:	e9 1b fe ff ff       	jmp    80106eed <trap+0x5d>
801070d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
801070d8:	e8 b3 da ff ff       	call   80104b90 <exit>
801070dd:	e9 2e ff ff ff       	jmp    80107010 <trap+0x180>
801070e2:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801070e5:	e8 66 d6 ff ff       	call   80104750 <cpuid>
801070ea:	83 ec 0c             	sub    $0xc,%esp
801070ed:	56                   	push   %esi
801070ee:	57                   	push   %edi
801070ef:	50                   	push   %eax
801070f0:	ff 73 30             	push   0x30(%ebx)
801070f3:	68 04 8e 10 80       	push   $0x80108e04
801070f8:	e8 43 9b ff ff       	call   80100c40 <cprintf>
      panic("trap");
801070fd:	83 c4 14             	add    $0x14,%esp
80107100:	68 9f 8b 10 80       	push   $0x80108b9f
80107105:	e8 96 92 ff ff       	call   801003a0 <panic>
8010710a:	66 90                	xchg   %ax,%ax
8010710c:	66 90                	xchg   %ax,%ax
8010710e:	66 90                	xchg   %ax,%ax

80107110 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80107110:	a1 e0 89 11 80       	mov    0x801189e0,%eax
80107115:	85 c0                	test   %eax,%eax
80107117:	74 17                	je     80107130 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80107119:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010711e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010711f:	a8 01                	test   $0x1,%al
80107121:	74 0d                	je     80107130 <uartgetc+0x20>
80107123:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107128:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80107129:	0f b6 c0             	movzbl %al,%eax
8010712c:	c3                   	ret
8010712d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80107130:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107135:	c3                   	ret
80107136:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010713d:	00 
8010713e:	66 90                	xchg   %ax,%ax

80107140 <uartinit>:
{
80107140:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107141:	31 c9                	xor    %ecx,%ecx
80107143:	89 c8                	mov    %ecx,%eax
80107145:	89 e5                	mov    %esp,%ebp
80107147:	57                   	push   %edi
80107148:	bf fa 03 00 00       	mov    $0x3fa,%edi
8010714d:	56                   	push   %esi
8010714e:	89 fa                	mov    %edi,%edx
80107150:	53                   	push   %ebx
80107151:	83 ec 1c             	sub    $0x1c,%esp
80107154:	ee                   	out    %al,(%dx)
80107155:	be fb 03 00 00       	mov    $0x3fb,%esi
8010715a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010715f:	89 f2                	mov    %esi,%edx
80107161:	ee                   	out    %al,(%dx)
80107162:	b8 0c 00 00 00       	mov    $0xc,%eax
80107167:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010716c:	ee                   	out    %al,(%dx)
8010716d:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80107172:	89 c8                	mov    %ecx,%eax
80107174:	89 da                	mov    %ebx,%edx
80107176:	ee                   	out    %al,(%dx)
80107177:	b8 03 00 00 00       	mov    $0x3,%eax
8010717c:	89 f2                	mov    %esi,%edx
8010717e:	ee                   	out    %al,(%dx)
8010717f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80107184:	89 c8                	mov    %ecx,%eax
80107186:	ee                   	out    %al,(%dx)
80107187:	b8 01 00 00 00       	mov    $0x1,%eax
8010718c:	89 da                	mov    %ebx,%edx
8010718e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010718f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80107194:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80107195:	3c ff                	cmp    $0xff,%al
80107197:	0f 84 7c 00 00 00    	je     80107219 <uartinit+0xd9>
  uart = 1;
8010719d:	c7 05 e0 89 11 80 01 	movl   $0x1,0x801189e0
801071a4:	00 00 00 
801071a7:	89 fa                	mov    %edi,%edx
801071a9:	ec                   	in     (%dx),%al
801071aa:	ba f8 03 00 00       	mov    $0x3f8,%edx
801071af:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801071b0:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
801071b3:	bf a4 8b 10 80       	mov    $0x80108ba4,%edi
801071b8:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
801071bd:	6a 00                	push   $0x0
801071bf:	6a 04                	push   $0x4
801071c1:	e8 8a c0 ff ff       	call   80103250 <ioapicenable>
801071c6:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
801071c9:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
801071cd:	8d 76 00             	lea    0x0(%esi),%esi
  if(!uart)
801071d0:	a1 e0 89 11 80       	mov    0x801189e0,%eax
801071d5:	85 c0                	test   %eax,%eax
801071d7:	74 32                	je     8010720b <uartinit+0xcb>
801071d9:	89 f2                	mov    %esi,%edx
801071db:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801071dc:	a8 20                	test   $0x20,%al
801071de:	75 21                	jne    80107201 <uartinit+0xc1>
801071e0:	bb 80 00 00 00       	mov    $0x80,%ebx
801071e5:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
801071e8:	83 ec 0c             	sub    $0xc,%esp
801071eb:	6a 0a                	push   $0xa
801071ed:	e8 1e c5 ff ff       	call   80103710 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801071f2:	83 c4 10             	add    $0x10,%esp
801071f5:	83 eb 01             	sub    $0x1,%ebx
801071f8:	74 07                	je     80107201 <uartinit+0xc1>
801071fa:	89 f2                	mov    %esi,%edx
801071fc:	ec                   	in     (%dx),%al
801071fd:	a8 20                	test   $0x20,%al
801071ff:	74 e7                	je     801071e8 <uartinit+0xa8>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107201:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107206:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010720a:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
8010720b:	0f b6 47 01          	movzbl 0x1(%edi),%eax
8010720f:	83 c7 01             	add    $0x1,%edi
80107212:	88 45 e7             	mov    %al,-0x19(%ebp)
80107215:	84 c0                	test   %al,%al
80107217:	75 b7                	jne    801071d0 <uartinit+0x90>
}
80107219:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010721c:	5b                   	pop    %ebx
8010721d:	5e                   	pop    %esi
8010721e:	5f                   	pop    %edi
8010721f:	5d                   	pop    %ebp
80107220:	c3                   	ret
80107221:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107228:	00 
80107229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107230 <uartputc>:
  if(!uart)
80107230:	a1 e0 89 11 80       	mov    0x801189e0,%eax
80107235:	85 c0                	test   %eax,%eax
80107237:	74 4f                	je     80107288 <uartputc+0x58>
{
80107239:	55                   	push   %ebp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010723a:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010723f:	89 e5                	mov    %esp,%ebp
80107241:	56                   	push   %esi
80107242:	53                   	push   %ebx
80107243:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80107244:	a8 20                	test   $0x20,%al
80107246:	75 29                	jne    80107271 <uartputc+0x41>
80107248:	bb 80 00 00 00       	mov    $0x80,%ebx
8010724d:	be fd 03 00 00       	mov    $0x3fd,%esi
80107252:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80107258:	83 ec 0c             	sub    $0xc,%esp
8010725b:	6a 0a                	push   $0xa
8010725d:	e8 ae c4 ff ff       	call   80103710 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80107262:	83 c4 10             	add    $0x10,%esp
80107265:	83 eb 01             	sub    $0x1,%ebx
80107268:	74 07                	je     80107271 <uartputc+0x41>
8010726a:	89 f2                	mov    %esi,%edx
8010726c:	ec                   	in     (%dx),%al
8010726d:	a8 20                	test   $0x20,%al
8010726f:	74 e7                	je     80107258 <uartputc+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107271:	8b 45 08             	mov    0x8(%ebp),%eax
80107274:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107279:	ee                   	out    %al,(%dx)
}
8010727a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010727d:	5b                   	pop    %ebx
8010727e:	5e                   	pop    %esi
8010727f:	5d                   	pop    %ebp
80107280:	c3                   	ret
80107281:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107288:	c3                   	ret
80107289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107290 <uartintr>:

void
uartintr(void)
{
80107290:	55                   	push   %ebp
80107291:	89 e5                	mov    %esp,%ebp
80107293:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80107296:	68 10 71 10 80       	push   $0x80107110
8010729b:	e8 d0 9c ff ff       	call   80100f70 <consoleintr>
}
801072a0:	83 c4 10             	add    $0x10,%esp
801072a3:	c9                   	leave
801072a4:	c3                   	ret

801072a5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801072a5:	6a 00                	push   $0x0
  pushl $0
801072a7:	6a 00                	push   $0x0
  jmp alltraps
801072a9:	e9 09 fb ff ff       	jmp    80106db7 <alltraps>

801072ae <vector1>:
.globl vector1
vector1:
  pushl $0
801072ae:	6a 00                	push   $0x0
  pushl $1
801072b0:	6a 01                	push   $0x1
  jmp alltraps
801072b2:	e9 00 fb ff ff       	jmp    80106db7 <alltraps>

801072b7 <vector2>:
.globl vector2
vector2:
  pushl $0
801072b7:	6a 00                	push   $0x0
  pushl $2
801072b9:	6a 02                	push   $0x2
  jmp alltraps
801072bb:	e9 f7 fa ff ff       	jmp    80106db7 <alltraps>

801072c0 <vector3>:
.globl vector3
vector3:
  pushl $0
801072c0:	6a 00                	push   $0x0
  pushl $3
801072c2:	6a 03                	push   $0x3
  jmp alltraps
801072c4:	e9 ee fa ff ff       	jmp    80106db7 <alltraps>

801072c9 <vector4>:
.globl vector4
vector4:
  pushl $0
801072c9:	6a 00                	push   $0x0
  pushl $4
801072cb:	6a 04                	push   $0x4
  jmp alltraps
801072cd:	e9 e5 fa ff ff       	jmp    80106db7 <alltraps>

801072d2 <vector5>:
.globl vector5
vector5:
  pushl $0
801072d2:	6a 00                	push   $0x0
  pushl $5
801072d4:	6a 05                	push   $0x5
  jmp alltraps
801072d6:	e9 dc fa ff ff       	jmp    80106db7 <alltraps>

801072db <vector6>:
.globl vector6
vector6:
  pushl $0
801072db:	6a 00                	push   $0x0
  pushl $6
801072dd:	6a 06                	push   $0x6
  jmp alltraps
801072df:	e9 d3 fa ff ff       	jmp    80106db7 <alltraps>

801072e4 <vector7>:
.globl vector7
vector7:
  pushl $0
801072e4:	6a 00                	push   $0x0
  pushl $7
801072e6:	6a 07                	push   $0x7
  jmp alltraps
801072e8:	e9 ca fa ff ff       	jmp    80106db7 <alltraps>

801072ed <vector8>:
.globl vector8
vector8:
  pushl $8
801072ed:	6a 08                	push   $0x8
  jmp alltraps
801072ef:	e9 c3 fa ff ff       	jmp    80106db7 <alltraps>

801072f4 <vector9>:
.globl vector9
vector9:
  pushl $0
801072f4:	6a 00                	push   $0x0
  pushl $9
801072f6:	6a 09                	push   $0x9
  jmp alltraps
801072f8:	e9 ba fa ff ff       	jmp    80106db7 <alltraps>

801072fd <vector10>:
.globl vector10
vector10:
  pushl $10
801072fd:	6a 0a                	push   $0xa
  jmp alltraps
801072ff:	e9 b3 fa ff ff       	jmp    80106db7 <alltraps>

80107304 <vector11>:
.globl vector11
vector11:
  pushl $11
80107304:	6a 0b                	push   $0xb
  jmp alltraps
80107306:	e9 ac fa ff ff       	jmp    80106db7 <alltraps>

8010730b <vector12>:
.globl vector12
vector12:
  pushl $12
8010730b:	6a 0c                	push   $0xc
  jmp alltraps
8010730d:	e9 a5 fa ff ff       	jmp    80106db7 <alltraps>

80107312 <vector13>:
.globl vector13
vector13:
  pushl $13
80107312:	6a 0d                	push   $0xd
  jmp alltraps
80107314:	e9 9e fa ff ff       	jmp    80106db7 <alltraps>

80107319 <vector14>:
.globl vector14
vector14:
  pushl $14
80107319:	6a 0e                	push   $0xe
  jmp alltraps
8010731b:	e9 97 fa ff ff       	jmp    80106db7 <alltraps>

80107320 <vector15>:
.globl vector15
vector15:
  pushl $0
80107320:	6a 00                	push   $0x0
  pushl $15
80107322:	6a 0f                	push   $0xf
  jmp alltraps
80107324:	e9 8e fa ff ff       	jmp    80106db7 <alltraps>

80107329 <vector16>:
.globl vector16
vector16:
  pushl $0
80107329:	6a 00                	push   $0x0
  pushl $16
8010732b:	6a 10                	push   $0x10
  jmp alltraps
8010732d:	e9 85 fa ff ff       	jmp    80106db7 <alltraps>

80107332 <vector17>:
.globl vector17
vector17:
  pushl $17
80107332:	6a 11                	push   $0x11
  jmp alltraps
80107334:	e9 7e fa ff ff       	jmp    80106db7 <alltraps>

80107339 <vector18>:
.globl vector18
vector18:
  pushl $0
80107339:	6a 00                	push   $0x0
  pushl $18
8010733b:	6a 12                	push   $0x12
  jmp alltraps
8010733d:	e9 75 fa ff ff       	jmp    80106db7 <alltraps>

80107342 <vector19>:
.globl vector19
vector19:
  pushl $0
80107342:	6a 00                	push   $0x0
  pushl $19
80107344:	6a 13                	push   $0x13
  jmp alltraps
80107346:	e9 6c fa ff ff       	jmp    80106db7 <alltraps>

8010734b <vector20>:
.globl vector20
vector20:
  pushl $0
8010734b:	6a 00                	push   $0x0
  pushl $20
8010734d:	6a 14                	push   $0x14
  jmp alltraps
8010734f:	e9 63 fa ff ff       	jmp    80106db7 <alltraps>

80107354 <vector21>:
.globl vector21
vector21:
  pushl $0
80107354:	6a 00                	push   $0x0
  pushl $21
80107356:	6a 15                	push   $0x15
  jmp alltraps
80107358:	e9 5a fa ff ff       	jmp    80106db7 <alltraps>

8010735d <vector22>:
.globl vector22
vector22:
  pushl $0
8010735d:	6a 00                	push   $0x0
  pushl $22
8010735f:	6a 16                	push   $0x16
  jmp alltraps
80107361:	e9 51 fa ff ff       	jmp    80106db7 <alltraps>

80107366 <vector23>:
.globl vector23
vector23:
  pushl $0
80107366:	6a 00                	push   $0x0
  pushl $23
80107368:	6a 17                	push   $0x17
  jmp alltraps
8010736a:	e9 48 fa ff ff       	jmp    80106db7 <alltraps>

8010736f <vector24>:
.globl vector24
vector24:
  pushl $0
8010736f:	6a 00                	push   $0x0
  pushl $24
80107371:	6a 18                	push   $0x18
  jmp alltraps
80107373:	e9 3f fa ff ff       	jmp    80106db7 <alltraps>

80107378 <vector25>:
.globl vector25
vector25:
  pushl $0
80107378:	6a 00                	push   $0x0
  pushl $25
8010737a:	6a 19                	push   $0x19
  jmp alltraps
8010737c:	e9 36 fa ff ff       	jmp    80106db7 <alltraps>

80107381 <vector26>:
.globl vector26
vector26:
  pushl $0
80107381:	6a 00                	push   $0x0
  pushl $26
80107383:	6a 1a                	push   $0x1a
  jmp alltraps
80107385:	e9 2d fa ff ff       	jmp    80106db7 <alltraps>

8010738a <vector27>:
.globl vector27
vector27:
  pushl $0
8010738a:	6a 00                	push   $0x0
  pushl $27
8010738c:	6a 1b                	push   $0x1b
  jmp alltraps
8010738e:	e9 24 fa ff ff       	jmp    80106db7 <alltraps>

80107393 <vector28>:
.globl vector28
vector28:
  pushl $0
80107393:	6a 00                	push   $0x0
  pushl $28
80107395:	6a 1c                	push   $0x1c
  jmp alltraps
80107397:	e9 1b fa ff ff       	jmp    80106db7 <alltraps>

8010739c <vector29>:
.globl vector29
vector29:
  pushl $0
8010739c:	6a 00                	push   $0x0
  pushl $29
8010739e:	6a 1d                	push   $0x1d
  jmp alltraps
801073a0:	e9 12 fa ff ff       	jmp    80106db7 <alltraps>

801073a5 <vector30>:
.globl vector30
vector30:
  pushl $0
801073a5:	6a 00                	push   $0x0
  pushl $30
801073a7:	6a 1e                	push   $0x1e
  jmp alltraps
801073a9:	e9 09 fa ff ff       	jmp    80106db7 <alltraps>

801073ae <vector31>:
.globl vector31
vector31:
  pushl $0
801073ae:	6a 00                	push   $0x0
  pushl $31
801073b0:	6a 1f                	push   $0x1f
  jmp alltraps
801073b2:	e9 00 fa ff ff       	jmp    80106db7 <alltraps>

801073b7 <vector32>:
.globl vector32
vector32:
  pushl $0
801073b7:	6a 00                	push   $0x0
  pushl $32
801073b9:	6a 20                	push   $0x20
  jmp alltraps
801073bb:	e9 f7 f9 ff ff       	jmp    80106db7 <alltraps>

801073c0 <vector33>:
.globl vector33
vector33:
  pushl $0
801073c0:	6a 00                	push   $0x0
  pushl $33
801073c2:	6a 21                	push   $0x21
  jmp alltraps
801073c4:	e9 ee f9 ff ff       	jmp    80106db7 <alltraps>

801073c9 <vector34>:
.globl vector34
vector34:
  pushl $0
801073c9:	6a 00                	push   $0x0
  pushl $34
801073cb:	6a 22                	push   $0x22
  jmp alltraps
801073cd:	e9 e5 f9 ff ff       	jmp    80106db7 <alltraps>

801073d2 <vector35>:
.globl vector35
vector35:
  pushl $0
801073d2:	6a 00                	push   $0x0
  pushl $35
801073d4:	6a 23                	push   $0x23
  jmp alltraps
801073d6:	e9 dc f9 ff ff       	jmp    80106db7 <alltraps>

801073db <vector36>:
.globl vector36
vector36:
  pushl $0
801073db:	6a 00                	push   $0x0
  pushl $36
801073dd:	6a 24                	push   $0x24
  jmp alltraps
801073df:	e9 d3 f9 ff ff       	jmp    80106db7 <alltraps>

801073e4 <vector37>:
.globl vector37
vector37:
  pushl $0
801073e4:	6a 00                	push   $0x0
  pushl $37
801073e6:	6a 25                	push   $0x25
  jmp alltraps
801073e8:	e9 ca f9 ff ff       	jmp    80106db7 <alltraps>

801073ed <vector38>:
.globl vector38
vector38:
  pushl $0
801073ed:	6a 00                	push   $0x0
  pushl $38
801073ef:	6a 26                	push   $0x26
  jmp alltraps
801073f1:	e9 c1 f9 ff ff       	jmp    80106db7 <alltraps>

801073f6 <vector39>:
.globl vector39
vector39:
  pushl $0
801073f6:	6a 00                	push   $0x0
  pushl $39
801073f8:	6a 27                	push   $0x27
  jmp alltraps
801073fa:	e9 b8 f9 ff ff       	jmp    80106db7 <alltraps>

801073ff <vector40>:
.globl vector40
vector40:
  pushl $0
801073ff:	6a 00                	push   $0x0
  pushl $40
80107401:	6a 28                	push   $0x28
  jmp alltraps
80107403:	e9 af f9 ff ff       	jmp    80106db7 <alltraps>

80107408 <vector41>:
.globl vector41
vector41:
  pushl $0
80107408:	6a 00                	push   $0x0
  pushl $41
8010740a:	6a 29                	push   $0x29
  jmp alltraps
8010740c:	e9 a6 f9 ff ff       	jmp    80106db7 <alltraps>

80107411 <vector42>:
.globl vector42
vector42:
  pushl $0
80107411:	6a 00                	push   $0x0
  pushl $42
80107413:	6a 2a                	push   $0x2a
  jmp alltraps
80107415:	e9 9d f9 ff ff       	jmp    80106db7 <alltraps>

8010741a <vector43>:
.globl vector43
vector43:
  pushl $0
8010741a:	6a 00                	push   $0x0
  pushl $43
8010741c:	6a 2b                	push   $0x2b
  jmp alltraps
8010741e:	e9 94 f9 ff ff       	jmp    80106db7 <alltraps>

80107423 <vector44>:
.globl vector44
vector44:
  pushl $0
80107423:	6a 00                	push   $0x0
  pushl $44
80107425:	6a 2c                	push   $0x2c
  jmp alltraps
80107427:	e9 8b f9 ff ff       	jmp    80106db7 <alltraps>

8010742c <vector45>:
.globl vector45
vector45:
  pushl $0
8010742c:	6a 00                	push   $0x0
  pushl $45
8010742e:	6a 2d                	push   $0x2d
  jmp alltraps
80107430:	e9 82 f9 ff ff       	jmp    80106db7 <alltraps>

80107435 <vector46>:
.globl vector46
vector46:
  pushl $0
80107435:	6a 00                	push   $0x0
  pushl $46
80107437:	6a 2e                	push   $0x2e
  jmp alltraps
80107439:	e9 79 f9 ff ff       	jmp    80106db7 <alltraps>

8010743e <vector47>:
.globl vector47
vector47:
  pushl $0
8010743e:	6a 00                	push   $0x0
  pushl $47
80107440:	6a 2f                	push   $0x2f
  jmp alltraps
80107442:	e9 70 f9 ff ff       	jmp    80106db7 <alltraps>

80107447 <vector48>:
.globl vector48
vector48:
  pushl $0
80107447:	6a 00                	push   $0x0
  pushl $48
80107449:	6a 30                	push   $0x30
  jmp alltraps
8010744b:	e9 67 f9 ff ff       	jmp    80106db7 <alltraps>

80107450 <vector49>:
.globl vector49
vector49:
  pushl $0
80107450:	6a 00                	push   $0x0
  pushl $49
80107452:	6a 31                	push   $0x31
  jmp alltraps
80107454:	e9 5e f9 ff ff       	jmp    80106db7 <alltraps>

80107459 <vector50>:
.globl vector50
vector50:
  pushl $0
80107459:	6a 00                	push   $0x0
  pushl $50
8010745b:	6a 32                	push   $0x32
  jmp alltraps
8010745d:	e9 55 f9 ff ff       	jmp    80106db7 <alltraps>

80107462 <vector51>:
.globl vector51
vector51:
  pushl $0
80107462:	6a 00                	push   $0x0
  pushl $51
80107464:	6a 33                	push   $0x33
  jmp alltraps
80107466:	e9 4c f9 ff ff       	jmp    80106db7 <alltraps>

8010746b <vector52>:
.globl vector52
vector52:
  pushl $0
8010746b:	6a 00                	push   $0x0
  pushl $52
8010746d:	6a 34                	push   $0x34
  jmp alltraps
8010746f:	e9 43 f9 ff ff       	jmp    80106db7 <alltraps>

80107474 <vector53>:
.globl vector53
vector53:
  pushl $0
80107474:	6a 00                	push   $0x0
  pushl $53
80107476:	6a 35                	push   $0x35
  jmp alltraps
80107478:	e9 3a f9 ff ff       	jmp    80106db7 <alltraps>

8010747d <vector54>:
.globl vector54
vector54:
  pushl $0
8010747d:	6a 00                	push   $0x0
  pushl $54
8010747f:	6a 36                	push   $0x36
  jmp alltraps
80107481:	e9 31 f9 ff ff       	jmp    80106db7 <alltraps>

80107486 <vector55>:
.globl vector55
vector55:
  pushl $0
80107486:	6a 00                	push   $0x0
  pushl $55
80107488:	6a 37                	push   $0x37
  jmp alltraps
8010748a:	e9 28 f9 ff ff       	jmp    80106db7 <alltraps>

8010748f <vector56>:
.globl vector56
vector56:
  pushl $0
8010748f:	6a 00                	push   $0x0
  pushl $56
80107491:	6a 38                	push   $0x38
  jmp alltraps
80107493:	e9 1f f9 ff ff       	jmp    80106db7 <alltraps>

80107498 <vector57>:
.globl vector57
vector57:
  pushl $0
80107498:	6a 00                	push   $0x0
  pushl $57
8010749a:	6a 39                	push   $0x39
  jmp alltraps
8010749c:	e9 16 f9 ff ff       	jmp    80106db7 <alltraps>

801074a1 <vector58>:
.globl vector58
vector58:
  pushl $0
801074a1:	6a 00                	push   $0x0
  pushl $58
801074a3:	6a 3a                	push   $0x3a
  jmp alltraps
801074a5:	e9 0d f9 ff ff       	jmp    80106db7 <alltraps>

801074aa <vector59>:
.globl vector59
vector59:
  pushl $0
801074aa:	6a 00                	push   $0x0
  pushl $59
801074ac:	6a 3b                	push   $0x3b
  jmp alltraps
801074ae:	e9 04 f9 ff ff       	jmp    80106db7 <alltraps>

801074b3 <vector60>:
.globl vector60
vector60:
  pushl $0
801074b3:	6a 00                	push   $0x0
  pushl $60
801074b5:	6a 3c                	push   $0x3c
  jmp alltraps
801074b7:	e9 fb f8 ff ff       	jmp    80106db7 <alltraps>

801074bc <vector61>:
.globl vector61
vector61:
  pushl $0
801074bc:	6a 00                	push   $0x0
  pushl $61
801074be:	6a 3d                	push   $0x3d
  jmp alltraps
801074c0:	e9 f2 f8 ff ff       	jmp    80106db7 <alltraps>

801074c5 <vector62>:
.globl vector62
vector62:
  pushl $0
801074c5:	6a 00                	push   $0x0
  pushl $62
801074c7:	6a 3e                	push   $0x3e
  jmp alltraps
801074c9:	e9 e9 f8 ff ff       	jmp    80106db7 <alltraps>

801074ce <vector63>:
.globl vector63
vector63:
  pushl $0
801074ce:	6a 00                	push   $0x0
  pushl $63
801074d0:	6a 3f                	push   $0x3f
  jmp alltraps
801074d2:	e9 e0 f8 ff ff       	jmp    80106db7 <alltraps>

801074d7 <vector64>:
.globl vector64
vector64:
  pushl $0
801074d7:	6a 00                	push   $0x0
  pushl $64
801074d9:	6a 40                	push   $0x40
  jmp alltraps
801074db:	e9 d7 f8 ff ff       	jmp    80106db7 <alltraps>

801074e0 <vector65>:
.globl vector65
vector65:
  pushl $0
801074e0:	6a 00                	push   $0x0
  pushl $65
801074e2:	6a 41                	push   $0x41
  jmp alltraps
801074e4:	e9 ce f8 ff ff       	jmp    80106db7 <alltraps>

801074e9 <vector66>:
.globl vector66
vector66:
  pushl $0
801074e9:	6a 00                	push   $0x0
  pushl $66
801074eb:	6a 42                	push   $0x42
  jmp alltraps
801074ed:	e9 c5 f8 ff ff       	jmp    80106db7 <alltraps>

801074f2 <vector67>:
.globl vector67
vector67:
  pushl $0
801074f2:	6a 00                	push   $0x0
  pushl $67
801074f4:	6a 43                	push   $0x43
  jmp alltraps
801074f6:	e9 bc f8 ff ff       	jmp    80106db7 <alltraps>

801074fb <vector68>:
.globl vector68
vector68:
  pushl $0
801074fb:	6a 00                	push   $0x0
  pushl $68
801074fd:	6a 44                	push   $0x44
  jmp alltraps
801074ff:	e9 b3 f8 ff ff       	jmp    80106db7 <alltraps>

80107504 <vector69>:
.globl vector69
vector69:
  pushl $0
80107504:	6a 00                	push   $0x0
  pushl $69
80107506:	6a 45                	push   $0x45
  jmp alltraps
80107508:	e9 aa f8 ff ff       	jmp    80106db7 <alltraps>

8010750d <vector70>:
.globl vector70
vector70:
  pushl $0
8010750d:	6a 00                	push   $0x0
  pushl $70
8010750f:	6a 46                	push   $0x46
  jmp alltraps
80107511:	e9 a1 f8 ff ff       	jmp    80106db7 <alltraps>

80107516 <vector71>:
.globl vector71
vector71:
  pushl $0
80107516:	6a 00                	push   $0x0
  pushl $71
80107518:	6a 47                	push   $0x47
  jmp alltraps
8010751a:	e9 98 f8 ff ff       	jmp    80106db7 <alltraps>

8010751f <vector72>:
.globl vector72
vector72:
  pushl $0
8010751f:	6a 00                	push   $0x0
  pushl $72
80107521:	6a 48                	push   $0x48
  jmp alltraps
80107523:	e9 8f f8 ff ff       	jmp    80106db7 <alltraps>

80107528 <vector73>:
.globl vector73
vector73:
  pushl $0
80107528:	6a 00                	push   $0x0
  pushl $73
8010752a:	6a 49                	push   $0x49
  jmp alltraps
8010752c:	e9 86 f8 ff ff       	jmp    80106db7 <alltraps>

80107531 <vector74>:
.globl vector74
vector74:
  pushl $0
80107531:	6a 00                	push   $0x0
  pushl $74
80107533:	6a 4a                	push   $0x4a
  jmp alltraps
80107535:	e9 7d f8 ff ff       	jmp    80106db7 <alltraps>

8010753a <vector75>:
.globl vector75
vector75:
  pushl $0
8010753a:	6a 00                	push   $0x0
  pushl $75
8010753c:	6a 4b                	push   $0x4b
  jmp alltraps
8010753e:	e9 74 f8 ff ff       	jmp    80106db7 <alltraps>

80107543 <vector76>:
.globl vector76
vector76:
  pushl $0
80107543:	6a 00                	push   $0x0
  pushl $76
80107545:	6a 4c                	push   $0x4c
  jmp alltraps
80107547:	e9 6b f8 ff ff       	jmp    80106db7 <alltraps>

8010754c <vector77>:
.globl vector77
vector77:
  pushl $0
8010754c:	6a 00                	push   $0x0
  pushl $77
8010754e:	6a 4d                	push   $0x4d
  jmp alltraps
80107550:	e9 62 f8 ff ff       	jmp    80106db7 <alltraps>

80107555 <vector78>:
.globl vector78
vector78:
  pushl $0
80107555:	6a 00                	push   $0x0
  pushl $78
80107557:	6a 4e                	push   $0x4e
  jmp alltraps
80107559:	e9 59 f8 ff ff       	jmp    80106db7 <alltraps>

8010755e <vector79>:
.globl vector79
vector79:
  pushl $0
8010755e:	6a 00                	push   $0x0
  pushl $79
80107560:	6a 4f                	push   $0x4f
  jmp alltraps
80107562:	e9 50 f8 ff ff       	jmp    80106db7 <alltraps>

80107567 <vector80>:
.globl vector80
vector80:
  pushl $0
80107567:	6a 00                	push   $0x0
  pushl $80
80107569:	6a 50                	push   $0x50
  jmp alltraps
8010756b:	e9 47 f8 ff ff       	jmp    80106db7 <alltraps>

80107570 <vector81>:
.globl vector81
vector81:
  pushl $0
80107570:	6a 00                	push   $0x0
  pushl $81
80107572:	6a 51                	push   $0x51
  jmp alltraps
80107574:	e9 3e f8 ff ff       	jmp    80106db7 <alltraps>

80107579 <vector82>:
.globl vector82
vector82:
  pushl $0
80107579:	6a 00                	push   $0x0
  pushl $82
8010757b:	6a 52                	push   $0x52
  jmp alltraps
8010757d:	e9 35 f8 ff ff       	jmp    80106db7 <alltraps>

80107582 <vector83>:
.globl vector83
vector83:
  pushl $0
80107582:	6a 00                	push   $0x0
  pushl $83
80107584:	6a 53                	push   $0x53
  jmp alltraps
80107586:	e9 2c f8 ff ff       	jmp    80106db7 <alltraps>

8010758b <vector84>:
.globl vector84
vector84:
  pushl $0
8010758b:	6a 00                	push   $0x0
  pushl $84
8010758d:	6a 54                	push   $0x54
  jmp alltraps
8010758f:	e9 23 f8 ff ff       	jmp    80106db7 <alltraps>

80107594 <vector85>:
.globl vector85
vector85:
  pushl $0
80107594:	6a 00                	push   $0x0
  pushl $85
80107596:	6a 55                	push   $0x55
  jmp alltraps
80107598:	e9 1a f8 ff ff       	jmp    80106db7 <alltraps>

8010759d <vector86>:
.globl vector86
vector86:
  pushl $0
8010759d:	6a 00                	push   $0x0
  pushl $86
8010759f:	6a 56                	push   $0x56
  jmp alltraps
801075a1:	e9 11 f8 ff ff       	jmp    80106db7 <alltraps>

801075a6 <vector87>:
.globl vector87
vector87:
  pushl $0
801075a6:	6a 00                	push   $0x0
  pushl $87
801075a8:	6a 57                	push   $0x57
  jmp alltraps
801075aa:	e9 08 f8 ff ff       	jmp    80106db7 <alltraps>

801075af <vector88>:
.globl vector88
vector88:
  pushl $0
801075af:	6a 00                	push   $0x0
  pushl $88
801075b1:	6a 58                	push   $0x58
  jmp alltraps
801075b3:	e9 ff f7 ff ff       	jmp    80106db7 <alltraps>

801075b8 <vector89>:
.globl vector89
vector89:
  pushl $0
801075b8:	6a 00                	push   $0x0
  pushl $89
801075ba:	6a 59                	push   $0x59
  jmp alltraps
801075bc:	e9 f6 f7 ff ff       	jmp    80106db7 <alltraps>

801075c1 <vector90>:
.globl vector90
vector90:
  pushl $0
801075c1:	6a 00                	push   $0x0
  pushl $90
801075c3:	6a 5a                	push   $0x5a
  jmp alltraps
801075c5:	e9 ed f7 ff ff       	jmp    80106db7 <alltraps>

801075ca <vector91>:
.globl vector91
vector91:
  pushl $0
801075ca:	6a 00                	push   $0x0
  pushl $91
801075cc:	6a 5b                	push   $0x5b
  jmp alltraps
801075ce:	e9 e4 f7 ff ff       	jmp    80106db7 <alltraps>

801075d3 <vector92>:
.globl vector92
vector92:
  pushl $0
801075d3:	6a 00                	push   $0x0
  pushl $92
801075d5:	6a 5c                	push   $0x5c
  jmp alltraps
801075d7:	e9 db f7 ff ff       	jmp    80106db7 <alltraps>

801075dc <vector93>:
.globl vector93
vector93:
  pushl $0
801075dc:	6a 00                	push   $0x0
  pushl $93
801075de:	6a 5d                	push   $0x5d
  jmp alltraps
801075e0:	e9 d2 f7 ff ff       	jmp    80106db7 <alltraps>

801075e5 <vector94>:
.globl vector94
vector94:
  pushl $0
801075e5:	6a 00                	push   $0x0
  pushl $94
801075e7:	6a 5e                	push   $0x5e
  jmp alltraps
801075e9:	e9 c9 f7 ff ff       	jmp    80106db7 <alltraps>

801075ee <vector95>:
.globl vector95
vector95:
  pushl $0
801075ee:	6a 00                	push   $0x0
  pushl $95
801075f0:	6a 5f                	push   $0x5f
  jmp alltraps
801075f2:	e9 c0 f7 ff ff       	jmp    80106db7 <alltraps>

801075f7 <vector96>:
.globl vector96
vector96:
  pushl $0
801075f7:	6a 00                	push   $0x0
  pushl $96
801075f9:	6a 60                	push   $0x60
  jmp alltraps
801075fb:	e9 b7 f7 ff ff       	jmp    80106db7 <alltraps>

80107600 <vector97>:
.globl vector97
vector97:
  pushl $0
80107600:	6a 00                	push   $0x0
  pushl $97
80107602:	6a 61                	push   $0x61
  jmp alltraps
80107604:	e9 ae f7 ff ff       	jmp    80106db7 <alltraps>

80107609 <vector98>:
.globl vector98
vector98:
  pushl $0
80107609:	6a 00                	push   $0x0
  pushl $98
8010760b:	6a 62                	push   $0x62
  jmp alltraps
8010760d:	e9 a5 f7 ff ff       	jmp    80106db7 <alltraps>

80107612 <vector99>:
.globl vector99
vector99:
  pushl $0
80107612:	6a 00                	push   $0x0
  pushl $99
80107614:	6a 63                	push   $0x63
  jmp alltraps
80107616:	e9 9c f7 ff ff       	jmp    80106db7 <alltraps>

8010761b <vector100>:
.globl vector100
vector100:
  pushl $0
8010761b:	6a 00                	push   $0x0
  pushl $100
8010761d:	6a 64                	push   $0x64
  jmp alltraps
8010761f:	e9 93 f7 ff ff       	jmp    80106db7 <alltraps>

80107624 <vector101>:
.globl vector101
vector101:
  pushl $0
80107624:	6a 00                	push   $0x0
  pushl $101
80107626:	6a 65                	push   $0x65
  jmp alltraps
80107628:	e9 8a f7 ff ff       	jmp    80106db7 <alltraps>

8010762d <vector102>:
.globl vector102
vector102:
  pushl $0
8010762d:	6a 00                	push   $0x0
  pushl $102
8010762f:	6a 66                	push   $0x66
  jmp alltraps
80107631:	e9 81 f7 ff ff       	jmp    80106db7 <alltraps>

80107636 <vector103>:
.globl vector103
vector103:
  pushl $0
80107636:	6a 00                	push   $0x0
  pushl $103
80107638:	6a 67                	push   $0x67
  jmp alltraps
8010763a:	e9 78 f7 ff ff       	jmp    80106db7 <alltraps>

8010763f <vector104>:
.globl vector104
vector104:
  pushl $0
8010763f:	6a 00                	push   $0x0
  pushl $104
80107641:	6a 68                	push   $0x68
  jmp alltraps
80107643:	e9 6f f7 ff ff       	jmp    80106db7 <alltraps>

80107648 <vector105>:
.globl vector105
vector105:
  pushl $0
80107648:	6a 00                	push   $0x0
  pushl $105
8010764a:	6a 69                	push   $0x69
  jmp alltraps
8010764c:	e9 66 f7 ff ff       	jmp    80106db7 <alltraps>

80107651 <vector106>:
.globl vector106
vector106:
  pushl $0
80107651:	6a 00                	push   $0x0
  pushl $106
80107653:	6a 6a                	push   $0x6a
  jmp alltraps
80107655:	e9 5d f7 ff ff       	jmp    80106db7 <alltraps>

8010765a <vector107>:
.globl vector107
vector107:
  pushl $0
8010765a:	6a 00                	push   $0x0
  pushl $107
8010765c:	6a 6b                	push   $0x6b
  jmp alltraps
8010765e:	e9 54 f7 ff ff       	jmp    80106db7 <alltraps>

80107663 <vector108>:
.globl vector108
vector108:
  pushl $0
80107663:	6a 00                	push   $0x0
  pushl $108
80107665:	6a 6c                	push   $0x6c
  jmp alltraps
80107667:	e9 4b f7 ff ff       	jmp    80106db7 <alltraps>

8010766c <vector109>:
.globl vector109
vector109:
  pushl $0
8010766c:	6a 00                	push   $0x0
  pushl $109
8010766e:	6a 6d                	push   $0x6d
  jmp alltraps
80107670:	e9 42 f7 ff ff       	jmp    80106db7 <alltraps>

80107675 <vector110>:
.globl vector110
vector110:
  pushl $0
80107675:	6a 00                	push   $0x0
  pushl $110
80107677:	6a 6e                	push   $0x6e
  jmp alltraps
80107679:	e9 39 f7 ff ff       	jmp    80106db7 <alltraps>

8010767e <vector111>:
.globl vector111
vector111:
  pushl $0
8010767e:	6a 00                	push   $0x0
  pushl $111
80107680:	6a 6f                	push   $0x6f
  jmp alltraps
80107682:	e9 30 f7 ff ff       	jmp    80106db7 <alltraps>

80107687 <vector112>:
.globl vector112
vector112:
  pushl $0
80107687:	6a 00                	push   $0x0
  pushl $112
80107689:	6a 70                	push   $0x70
  jmp alltraps
8010768b:	e9 27 f7 ff ff       	jmp    80106db7 <alltraps>

80107690 <vector113>:
.globl vector113
vector113:
  pushl $0
80107690:	6a 00                	push   $0x0
  pushl $113
80107692:	6a 71                	push   $0x71
  jmp alltraps
80107694:	e9 1e f7 ff ff       	jmp    80106db7 <alltraps>

80107699 <vector114>:
.globl vector114
vector114:
  pushl $0
80107699:	6a 00                	push   $0x0
  pushl $114
8010769b:	6a 72                	push   $0x72
  jmp alltraps
8010769d:	e9 15 f7 ff ff       	jmp    80106db7 <alltraps>

801076a2 <vector115>:
.globl vector115
vector115:
  pushl $0
801076a2:	6a 00                	push   $0x0
  pushl $115
801076a4:	6a 73                	push   $0x73
  jmp alltraps
801076a6:	e9 0c f7 ff ff       	jmp    80106db7 <alltraps>

801076ab <vector116>:
.globl vector116
vector116:
  pushl $0
801076ab:	6a 00                	push   $0x0
  pushl $116
801076ad:	6a 74                	push   $0x74
  jmp alltraps
801076af:	e9 03 f7 ff ff       	jmp    80106db7 <alltraps>

801076b4 <vector117>:
.globl vector117
vector117:
  pushl $0
801076b4:	6a 00                	push   $0x0
  pushl $117
801076b6:	6a 75                	push   $0x75
  jmp alltraps
801076b8:	e9 fa f6 ff ff       	jmp    80106db7 <alltraps>

801076bd <vector118>:
.globl vector118
vector118:
  pushl $0
801076bd:	6a 00                	push   $0x0
  pushl $118
801076bf:	6a 76                	push   $0x76
  jmp alltraps
801076c1:	e9 f1 f6 ff ff       	jmp    80106db7 <alltraps>

801076c6 <vector119>:
.globl vector119
vector119:
  pushl $0
801076c6:	6a 00                	push   $0x0
  pushl $119
801076c8:	6a 77                	push   $0x77
  jmp alltraps
801076ca:	e9 e8 f6 ff ff       	jmp    80106db7 <alltraps>

801076cf <vector120>:
.globl vector120
vector120:
  pushl $0
801076cf:	6a 00                	push   $0x0
  pushl $120
801076d1:	6a 78                	push   $0x78
  jmp alltraps
801076d3:	e9 df f6 ff ff       	jmp    80106db7 <alltraps>

801076d8 <vector121>:
.globl vector121
vector121:
  pushl $0
801076d8:	6a 00                	push   $0x0
  pushl $121
801076da:	6a 79                	push   $0x79
  jmp alltraps
801076dc:	e9 d6 f6 ff ff       	jmp    80106db7 <alltraps>

801076e1 <vector122>:
.globl vector122
vector122:
  pushl $0
801076e1:	6a 00                	push   $0x0
  pushl $122
801076e3:	6a 7a                	push   $0x7a
  jmp alltraps
801076e5:	e9 cd f6 ff ff       	jmp    80106db7 <alltraps>

801076ea <vector123>:
.globl vector123
vector123:
  pushl $0
801076ea:	6a 00                	push   $0x0
  pushl $123
801076ec:	6a 7b                	push   $0x7b
  jmp alltraps
801076ee:	e9 c4 f6 ff ff       	jmp    80106db7 <alltraps>

801076f3 <vector124>:
.globl vector124
vector124:
  pushl $0
801076f3:	6a 00                	push   $0x0
  pushl $124
801076f5:	6a 7c                	push   $0x7c
  jmp alltraps
801076f7:	e9 bb f6 ff ff       	jmp    80106db7 <alltraps>

801076fc <vector125>:
.globl vector125
vector125:
  pushl $0
801076fc:	6a 00                	push   $0x0
  pushl $125
801076fe:	6a 7d                	push   $0x7d
  jmp alltraps
80107700:	e9 b2 f6 ff ff       	jmp    80106db7 <alltraps>

80107705 <vector126>:
.globl vector126
vector126:
  pushl $0
80107705:	6a 00                	push   $0x0
  pushl $126
80107707:	6a 7e                	push   $0x7e
  jmp alltraps
80107709:	e9 a9 f6 ff ff       	jmp    80106db7 <alltraps>

8010770e <vector127>:
.globl vector127
vector127:
  pushl $0
8010770e:	6a 00                	push   $0x0
  pushl $127
80107710:	6a 7f                	push   $0x7f
  jmp alltraps
80107712:	e9 a0 f6 ff ff       	jmp    80106db7 <alltraps>

80107717 <vector128>:
.globl vector128
vector128:
  pushl $0
80107717:	6a 00                	push   $0x0
  pushl $128
80107719:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010771e:	e9 94 f6 ff ff       	jmp    80106db7 <alltraps>

80107723 <vector129>:
.globl vector129
vector129:
  pushl $0
80107723:	6a 00                	push   $0x0
  pushl $129
80107725:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010772a:	e9 88 f6 ff ff       	jmp    80106db7 <alltraps>

8010772f <vector130>:
.globl vector130
vector130:
  pushl $0
8010772f:	6a 00                	push   $0x0
  pushl $130
80107731:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80107736:	e9 7c f6 ff ff       	jmp    80106db7 <alltraps>

8010773b <vector131>:
.globl vector131
vector131:
  pushl $0
8010773b:	6a 00                	push   $0x0
  pushl $131
8010773d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80107742:	e9 70 f6 ff ff       	jmp    80106db7 <alltraps>

80107747 <vector132>:
.globl vector132
vector132:
  pushl $0
80107747:	6a 00                	push   $0x0
  pushl $132
80107749:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010774e:	e9 64 f6 ff ff       	jmp    80106db7 <alltraps>

80107753 <vector133>:
.globl vector133
vector133:
  pushl $0
80107753:	6a 00                	push   $0x0
  pushl $133
80107755:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010775a:	e9 58 f6 ff ff       	jmp    80106db7 <alltraps>

8010775f <vector134>:
.globl vector134
vector134:
  pushl $0
8010775f:	6a 00                	push   $0x0
  pushl $134
80107761:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107766:	e9 4c f6 ff ff       	jmp    80106db7 <alltraps>

8010776b <vector135>:
.globl vector135
vector135:
  pushl $0
8010776b:	6a 00                	push   $0x0
  pushl $135
8010776d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107772:	e9 40 f6 ff ff       	jmp    80106db7 <alltraps>

80107777 <vector136>:
.globl vector136
vector136:
  pushl $0
80107777:	6a 00                	push   $0x0
  pushl $136
80107779:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010777e:	e9 34 f6 ff ff       	jmp    80106db7 <alltraps>

80107783 <vector137>:
.globl vector137
vector137:
  pushl $0
80107783:	6a 00                	push   $0x0
  pushl $137
80107785:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010778a:	e9 28 f6 ff ff       	jmp    80106db7 <alltraps>

8010778f <vector138>:
.globl vector138
vector138:
  pushl $0
8010778f:	6a 00                	push   $0x0
  pushl $138
80107791:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80107796:	e9 1c f6 ff ff       	jmp    80106db7 <alltraps>

8010779b <vector139>:
.globl vector139
vector139:
  pushl $0
8010779b:	6a 00                	push   $0x0
  pushl $139
8010779d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801077a2:	e9 10 f6 ff ff       	jmp    80106db7 <alltraps>

801077a7 <vector140>:
.globl vector140
vector140:
  pushl $0
801077a7:	6a 00                	push   $0x0
  pushl $140
801077a9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801077ae:	e9 04 f6 ff ff       	jmp    80106db7 <alltraps>

801077b3 <vector141>:
.globl vector141
vector141:
  pushl $0
801077b3:	6a 00                	push   $0x0
  pushl $141
801077b5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801077ba:	e9 f8 f5 ff ff       	jmp    80106db7 <alltraps>

801077bf <vector142>:
.globl vector142
vector142:
  pushl $0
801077bf:	6a 00                	push   $0x0
  pushl $142
801077c1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801077c6:	e9 ec f5 ff ff       	jmp    80106db7 <alltraps>

801077cb <vector143>:
.globl vector143
vector143:
  pushl $0
801077cb:	6a 00                	push   $0x0
  pushl $143
801077cd:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801077d2:	e9 e0 f5 ff ff       	jmp    80106db7 <alltraps>

801077d7 <vector144>:
.globl vector144
vector144:
  pushl $0
801077d7:	6a 00                	push   $0x0
  pushl $144
801077d9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801077de:	e9 d4 f5 ff ff       	jmp    80106db7 <alltraps>

801077e3 <vector145>:
.globl vector145
vector145:
  pushl $0
801077e3:	6a 00                	push   $0x0
  pushl $145
801077e5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801077ea:	e9 c8 f5 ff ff       	jmp    80106db7 <alltraps>

801077ef <vector146>:
.globl vector146
vector146:
  pushl $0
801077ef:	6a 00                	push   $0x0
  pushl $146
801077f1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801077f6:	e9 bc f5 ff ff       	jmp    80106db7 <alltraps>

801077fb <vector147>:
.globl vector147
vector147:
  pushl $0
801077fb:	6a 00                	push   $0x0
  pushl $147
801077fd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107802:	e9 b0 f5 ff ff       	jmp    80106db7 <alltraps>

80107807 <vector148>:
.globl vector148
vector148:
  pushl $0
80107807:	6a 00                	push   $0x0
  pushl $148
80107809:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010780e:	e9 a4 f5 ff ff       	jmp    80106db7 <alltraps>

80107813 <vector149>:
.globl vector149
vector149:
  pushl $0
80107813:	6a 00                	push   $0x0
  pushl $149
80107815:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010781a:	e9 98 f5 ff ff       	jmp    80106db7 <alltraps>

8010781f <vector150>:
.globl vector150
vector150:
  pushl $0
8010781f:	6a 00                	push   $0x0
  pushl $150
80107821:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107826:	e9 8c f5 ff ff       	jmp    80106db7 <alltraps>

8010782b <vector151>:
.globl vector151
vector151:
  pushl $0
8010782b:	6a 00                	push   $0x0
  pushl $151
8010782d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107832:	e9 80 f5 ff ff       	jmp    80106db7 <alltraps>

80107837 <vector152>:
.globl vector152
vector152:
  pushl $0
80107837:	6a 00                	push   $0x0
  pushl $152
80107839:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010783e:	e9 74 f5 ff ff       	jmp    80106db7 <alltraps>

80107843 <vector153>:
.globl vector153
vector153:
  pushl $0
80107843:	6a 00                	push   $0x0
  pushl $153
80107845:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010784a:	e9 68 f5 ff ff       	jmp    80106db7 <alltraps>

8010784f <vector154>:
.globl vector154
vector154:
  pushl $0
8010784f:	6a 00                	push   $0x0
  pushl $154
80107851:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107856:	e9 5c f5 ff ff       	jmp    80106db7 <alltraps>

8010785b <vector155>:
.globl vector155
vector155:
  pushl $0
8010785b:	6a 00                	push   $0x0
  pushl $155
8010785d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107862:	e9 50 f5 ff ff       	jmp    80106db7 <alltraps>

80107867 <vector156>:
.globl vector156
vector156:
  pushl $0
80107867:	6a 00                	push   $0x0
  pushl $156
80107869:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010786e:	e9 44 f5 ff ff       	jmp    80106db7 <alltraps>

80107873 <vector157>:
.globl vector157
vector157:
  pushl $0
80107873:	6a 00                	push   $0x0
  pushl $157
80107875:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010787a:	e9 38 f5 ff ff       	jmp    80106db7 <alltraps>

8010787f <vector158>:
.globl vector158
vector158:
  pushl $0
8010787f:	6a 00                	push   $0x0
  pushl $158
80107881:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107886:	e9 2c f5 ff ff       	jmp    80106db7 <alltraps>

8010788b <vector159>:
.globl vector159
vector159:
  pushl $0
8010788b:	6a 00                	push   $0x0
  pushl $159
8010788d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80107892:	e9 20 f5 ff ff       	jmp    80106db7 <alltraps>

80107897 <vector160>:
.globl vector160
vector160:
  pushl $0
80107897:	6a 00                	push   $0x0
  pushl $160
80107899:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010789e:	e9 14 f5 ff ff       	jmp    80106db7 <alltraps>

801078a3 <vector161>:
.globl vector161
vector161:
  pushl $0
801078a3:	6a 00                	push   $0x0
  pushl $161
801078a5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801078aa:	e9 08 f5 ff ff       	jmp    80106db7 <alltraps>

801078af <vector162>:
.globl vector162
vector162:
  pushl $0
801078af:	6a 00                	push   $0x0
  pushl $162
801078b1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801078b6:	e9 fc f4 ff ff       	jmp    80106db7 <alltraps>

801078bb <vector163>:
.globl vector163
vector163:
  pushl $0
801078bb:	6a 00                	push   $0x0
  pushl $163
801078bd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801078c2:	e9 f0 f4 ff ff       	jmp    80106db7 <alltraps>

801078c7 <vector164>:
.globl vector164
vector164:
  pushl $0
801078c7:	6a 00                	push   $0x0
  pushl $164
801078c9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801078ce:	e9 e4 f4 ff ff       	jmp    80106db7 <alltraps>

801078d3 <vector165>:
.globl vector165
vector165:
  pushl $0
801078d3:	6a 00                	push   $0x0
  pushl $165
801078d5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801078da:	e9 d8 f4 ff ff       	jmp    80106db7 <alltraps>

801078df <vector166>:
.globl vector166
vector166:
  pushl $0
801078df:	6a 00                	push   $0x0
  pushl $166
801078e1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801078e6:	e9 cc f4 ff ff       	jmp    80106db7 <alltraps>

801078eb <vector167>:
.globl vector167
vector167:
  pushl $0
801078eb:	6a 00                	push   $0x0
  pushl $167
801078ed:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801078f2:	e9 c0 f4 ff ff       	jmp    80106db7 <alltraps>

801078f7 <vector168>:
.globl vector168
vector168:
  pushl $0
801078f7:	6a 00                	push   $0x0
  pushl $168
801078f9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801078fe:	e9 b4 f4 ff ff       	jmp    80106db7 <alltraps>

80107903 <vector169>:
.globl vector169
vector169:
  pushl $0
80107903:	6a 00                	push   $0x0
  pushl $169
80107905:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010790a:	e9 a8 f4 ff ff       	jmp    80106db7 <alltraps>

8010790f <vector170>:
.globl vector170
vector170:
  pushl $0
8010790f:	6a 00                	push   $0x0
  pushl $170
80107911:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107916:	e9 9c f4 ff ff       	jmp    80106db7 <alltraps>

8010791b <vector171>:
.globl vector171
vector171:
  pushl $0
8010791b:	6a 00                	push   $0x0
  pushl $171
8010791d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107922:	e9 90 f4 ff ff       	jmp    80106db7 <alltraps>

80107927 <vector172>:
.globl vector172
vector172:
  pushl $0
80107927:	6a 00                	push   $0x0
  pushl $172
80107929:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010792e:	e9 84 f4 ff ff       	jmp    80106db7 <alltraps>

80107933 <vector173>:
.globl vector173
vector173:
  pushl $0
80107933:	6a 00                	push   $0x0
  pushl $173
80107935:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010793a:	e9 78 f4 ff ff       	jmp    80106db7 <alltraps>

8010793f <vector174>:
.globl vector174
vector174:
  pushl $0
8010793f:	6a 00                	push   $0x0
  pushl $174
80107941:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107946:	e9 6c f4 ff ff       	jmp    80106db7 <alltraps>

8010794b <vector175>:
.globl vector175
vector175:
  pushl $0
8010794b:	6a 00                	push   $0x0
  pushl $175
8010794d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107952:	e9 60 f4 ff ff       	jmp    80106db7 <alltraps>

80107957 <vector176>:
.globl vector176
vector176:
  pushl $0
80107957:	6a 00                	push   $0x0
  pushl $176
80107959:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010795e:	e9 54 f4 ff ff       	jmp    80106db7 <alltraps>

80107963 <vector177>:
.globl vector177
vector177:
  pushl $0
80107963:	6a 00                	push   $0x0
  pushl $177
80107965:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010796a:	e9 48 f4 ff ff       	jmp    80106db7 <alltraps>

8010796f <vector178>:
.globl vector178
vector178:
  pushl $0
8010796f:	6a 00                	push   $0x0
  pushl $178
80107971:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107976:	e9 3c f4 ff ff       	jmp    80106db7 <alltraps>

8010797b <vector179>:
.globl vector179
vector179:
  pushl $0
8010797b:	6a 00                	push   $0x0
  pushl $179
8010797d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107982:	e9 30 f4 ff ff       	jmp    80106db7 <alltraps>

80107987 <vector180>:
.globl vector180
vector180:
  pushl $0
80107987:	6a 00                	push   $0x0
  pushl $180
80107989:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010798e:	e9 24 f4 ff ff       	jmp    80106db7 <alltraps>

80107993 <vector181>:
.globl vector181
vector181:
  pushl $0
80107993:	6a 00                	push   $0x0
  pushl $181
80107995:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010799a:	e9 18 f4 ff ff       	jmp    80106db7 <alltraps>

8010799f <vector182>:
.globl vector182
vector182:
  pushl $0
8010799f:	6a 00                	push   $0x0
  pushl $182
801079a1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801079a6:	e9 0c f4 ff ff       	jmp    80106db7 <alltraps>

801079ab <vector183>:
.globl vector183
vector183:
  pushl $0
801079ab:	6a 00                	push   $0x0
  pushl $183
801079ad:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801079b2:	e9 00 f4 ff ff       	jmp    80106db7 <alltraps>

801079b7 <vector184>:
.globl vector184
vector184:
  pushl $0
801079b7:	6a 00                	push   $0x0
  pushl $184
801079b9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801079be:	e9 f4 f3 ff ff       	jmp    80106db7 <alltraps>

801079c3 <vector185>:
.globl vector185
vector185:
  pushl $0
801079c3:	6a 00                	push   $0x0
  pushl $185
801079c5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801079ca:	e9 e8 f3 ff ff       	jmp    80106db7 <alltraps>

801079cf <vector186>:
.globl vector186
vector186:
  pushl $0
801079cf:	6a 00                	push   $0x0
  pushl $186
801079d1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801079d6:	e9 dc f3 ff ff       	jmp    80106db7 <alltraps>

801079db <vector187>:
.globl vector187
vector187:
  pushl $0
801079db:	6a 00                	push   $0x0
  pushl $187
801079dd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801079e2:	e9 d0 f3 ff ff       	jmp    80106db7 <alltraps>

801079e7 <vector188>:
.globl vector188
vector188:
  pushl $0
801079e7:	6a 00                	push   $0x0
  pushl $188
801079e9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801079ee:	e9 c4 f3 ff ff       	jmp    80106db7 <alltraps>

801079f3 <vector189>:
.globl vector189
vector189:
  pushl $0
801079f3:	6a 00                	push   $0x0
  pushl $189
801079f5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801079fa:	e9 b8 f3 ff ff       	jmp    80106db7 <alltraps>

801079ff <vector190>:
.globl vector190
vector190:
  pushl $0
801079ff:	6a 00                	push   $0x0
  pushl $190
80107a01:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107a06:	e9 ac f3 ff ff       	jmp    80106db7 <alltraps>

80107a0b <vector191>:
.globl vector191
vector191:
  pushl $0
80107a0b:	6a 00                	push   $0x0
  pushl $191
80107a0d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107a12:	e9 a0 f3 ff ff       	jmp    80106db7 <alltraps>

80107a17 <vector192>:
.globl vector192
vector192:
  pushl $0
80107a17:	6a 00                	push   $0x0
  pushl $192
80107a19:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80107a1e:	e9 94 f3 ff ff       	jmp    80106db7 <alltraps>

80107a23 <vector193>:
.globl vector193
vector193:
  pushl $0
80107a23:	6a 00                	push   $0x0
  pushl $193
80107a25:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80107a2a:	e9 88 f3 ff ff       	jmp    80106db7 <alltraps>

80107a2f <vector194>:
.globl vector194
vector194:
  pushl $0
80107a2f:	6a 00                	push   $0x0
  pushl $194
80107a31:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107a36:	e9 7c f3 ff ff       	jmp    80106db7 <alltraps>

80107a3b <vector195>:
.globl vector195
vector195:
  pushl $0
80107a3b:	6a 00                	push   $0x0
  pushl $195
80107a3d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107a42:	e9 70 f3 ff ff       	jmp    80106db7 <alltraps>

80107a47 <vector196>:
.globl vector196
vector196:
  pushl $0
80107a47:	6a 00                	push   $0x0
  pushl $196
80107a49:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80107a4e:	e9 64 f3 ff ff       	jmp    80106db7 <alltraps>

80107a53 <vector197>:
.globl vector197
vector197:
  pushl $0
80107a53:	6a 00                	push   $0x0
  pushl $197
80107a55:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80107a5a:	e9 58 f3 ff ff       	jmp    80106db7 <alltraps>

80107a5f <vector198>:
.globl vector198
vector198:
  pushl $0
80107a5f:	6a 00                	push   $0x0
  pushl $198
80107a61:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107a66:	e9 4c f3 ff ff       	jmp    80106db7 <alltraps>

80107a6b <vector199>:
.globl vector199
vector199:
  pushl $0
80107a6b:	6a 00                	push   $0x0
  pushl $199
80107a6d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107a72:	e9 40 f3 ff ff       	jmp    80106db7 <alltraps>

80107a77 <vector200>:
.globl vector200
vector200:
  pushl $0
80107a77:	6a 00                	push   $0x0
  pushl $200
80107a79:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80107a7e:	e9 34 f3 ff ff       	jmp    80106db7 <alltraps>

80107a83 <vector201>:
.globl vector201
vector201:
  pushl $0
80107a83:	6a 00                	push   $0x0
  pushl $201
80107a85:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80107a8a:	e9 28 f3 ff ff       	jmp    80106db7 <alltraps>

80107a8f <vector202>:
.globl vector202
vector202:
  pushl $0
80107a8f:	6a 00                	push   $0x0
  pushl $202
80107a91:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80107a96:	e9 1c f3 ff ff       	jmp    80106db7 <alltraps>

80107a9b <vector203>:
.globl vector203
vector203:
  pushl $0
80107a9b:	6a 00                	push   $0x0
  pushl $203
80107a9d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80107aa2:	e9 10 f3 ff ff       	jmp    80106db7 <alltraps>

80107aa7 <vector204>:
.globl vector204
vector204:
  pushl $0
80107aa7:	6a 00                	push   $0x0
  pushl $204
80107aa9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80107aae:	e9 04 f3 ff ff       	jmp    80106db7 <alltraps>

80107ab3 <vector205>:
.globl vector205
vector205:
  pushl $0
80107ab3:	6a 00                	push   $0x0
  pushl $205
80107ab5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80107aba:	e9 f8 f2 ff ff       	jmp    80106db7 <alltraps>

80107abf <vector206>:
.globl vector206
vector206:
  pushl $0
80107abf:	6a 00                	push   $0x0
  pushl $206
80107ac1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80107ac6:	e9 ec f2 ff ff       	jmp    80106db7 <alltraps>

80107acb <vector207>:
.globl vector207
vector207:
  pushl $0
80107acb:	6a 00                	push   $0x0
  pushl $207
80107acd:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80107ad2:	e9 e0 f2 ff ff       	jmp    80106db7 <alltraps>

80107ad7 <vector208>:
.globl vector208
vector208:
  pushl $0
80107ad7:	6a 00                	push   $0x0
  pushl $208
80107ad9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80107ade:	e9 d4 f2 ff ff       	jmp    80106db7 <alltraps>

80107ae3 <vector209>:
.globl vector209
vector209:
  pushl $0
80107ae3:	6a 00                	push   $0x0
  pushl $209
80107ae5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80107aea:	e9 c8 f2 ff ff       	jmp    80106db7 <alltraps>

80107aef <vector210>:
.globl vector210
vector210:
  pushl $0
80107aef:	6a 00                	push   $0x0
  pushl $210
80107af1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107af6:	e9 bc f2 ff ff       	jmp    80106db7 <alltraps>

80107afb <vector211>:
.globl vector211
vector211:
  pushl $0
80107afb:	6a 00                	push   $0x0
  pushl $211
80107afd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107b02:	e9 b0 f2 ff ff       	jmp    80106db7 <alltraps>

80107b07 <vector212>:
.globl vector212
vector212:
  pushl $0
80107b07:	6a 00                	push   $0x0
  pushl $212
80107b09:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107b0e:	e9 a4 f2 ff ff       	jmp    80106db7 <alltraps>

80107b13 <vector213>:
.globl vector213
vector213:
  pushl $0
80107b13:	6a 00                	push   $0x0
  pushl $213
80107b15:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107b1a:	e9 98 f2 ff ff       	jmp    80106db7 <alltraps>

80107b1f <vector214>:
.globl vector214
vector214:
  pushl $0
80107b1f:	6a 00                	push   $0x0
  pushl $214
80107b21:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107b26:	e9 8c f2 ff ff       	jmp    80106db7 <alltraps>

80107b2b <vector215>:
.globl vector215
vector215:
  pushl $0
80107b2b:	6a 00                	push   $0x0
  pushl $215
80107b2d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107b32:	e9 80 f2 ff ff       	jmp    80106db7 <alltraps>

80107b37 <vector216>:
.globl vector216
vector216:
  pushl $0
80107b37:	6a 00                	push   $0x0
  pushl $216
80107b39:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107b3e:	e9 74 f2 ff ff       	jmp    80106db7 <alltraps>

80107b43 <vector217>:
.globl vector217
vector217:
  pushl $0
80107b43:	6a 00                	push   $0x0
  pushl $217
80107b45:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80107b4a:	e9 68 f2 ff ff       	jmp    80106db7 <alltraps>

80107b4f <vector218>:
.globl vector218
vector218:
  pushl $0
80107b4f:	6a 00                	push   $0x0
  pushl $218
80107b51:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107b56:	e9 5c f2 ff ff       	jmp    80106db7 <alltraps>

80107b5b <vector219>:
.globl vector219
vector219:
  pushl $0
80107b5b:	6a 00                	push   $0x0
  pushl $219
80107b5d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107b62:	e9 50 f2 ff ff       	jmp    80106db7 <alltraps>

80107b67 <vector220>:
.globl vector220
vector220:
  pushl $0
80107b67:	6a 00                	push   $0x0
  pushl $220
80107b69:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107b6e:	e9 44 f2 ff ff       	jmp    80106db7 <alltraps>

80107b73 <vector221>:
.globl vector221
vector221:
  pushl $0
80107b73:	6a 00                	push   $0x0
  pushl $221
80107b75:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107b7a:	e9 38 f2 ff ff       	jmp    80106db7 <alltraps>

80107b7f <vector222>:
.globl vector222
vector222:
  pushl $0
80107b7f:	6a 00                	push   $0x0
  pushl $222
80107b81:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107b86:	e9 2c f2 ff ff       	jmp    80106db7 <alltraps>

80107b8b <vector223>:
.globl vector223
vector223:
  pushl $0
80107b8b:	6a 00                	push   $0x0
  pushl $223
80107b8d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107b92:	e9 20 f2 ff ff       	jmp    80106db7 <alltraps>

80107b97 <vector224>:
.globl vector224
vector224:
  pushl $0
80107b97:	6a 00                	push   $0x0
  pushl $224
80107b99:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80107b9e:	e9 14 f2 ff ff       	jmp    80106db7 <alltraps>

80107ba3 <vector225>:
.globl vector225
vector225:
  pushl $0
80107ba3:	6a 00                	push   $0x0
  pushl $225
80107ba5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107baa:	e9 08 f2 ff ff       	jmp    80106db7 <alltraps>

80107baf <vector226>:
.globl vector226
vector226:
  pushl $0
80107baf:	6a 00                	push   $0x0
  pushl $226
80107bb1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107bb6:	e9 fc f1 ff ff       	jmp    80106db7 <alltraps>

80107bbb <vector227>:
.globl vector227
vector227:
  pushl $0
80107bbb:	6a 00                	push   $0x0
  pushl $227
80107bbd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107bc2:	e9 f0 f1 ff ff       	jmp    80106db7 <alltraps>

80107bc7 <vector228>:
.globl vector228
vector228:
  pushl $0
80107bc7:	6a 00                	push   $0x0
  pushl $228
80107bc9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107bce:	e9 e4 f1 ff ff       	jmp    80106db7 <alltraps>

80107bd3 <vector229>:
.globl vector229
vector229:
  pushl $0
80107bd3:	6a 00                	push   $0x0
  pushl $229
80107bd5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107bda:	e9 d8 f1 ff ff       	jmp    80106db7 <alltraps>

80107bdf <vector230>:
.globl vector230
vector230:
  pushl $0
80107bdf:	6a 00                	push   $0x0
  pushl $230
80107be1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107be6:	e9 cc f1 ff ff       	jmp    80106db7 <alltraps>

80107beb <vector231>:
.globl vector231
vector231:
  pushl $0
80107beb:	6a 00                	push   $0x0
  pushl $231
80107bed:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107bf2:	e9 c0 f1 ff ff       	jmp    80106db7 <alltraps>

80107bf7 <vector232>:
.globl vector232
vector232:
  pushl $0
80107bf7:	6a 00                	push   $0x0
  pushl $232
80107bf9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107bfe:	e9 b4 f1 ff ff       	jmp    80106db7 <alltraps>

80107c03 <vector233>:
.globl vector233
vector233:
  pushl $0
80107c03:	6a 00                	push   $0x0
  pushl $233
80107c05:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107c0a:	e9 a8 f1 ff ff       	jmp    80106db7 <alltraps>

80107c0f <vector234>:
.globl vector234
vector234:
  pushl $0
80107c0f:	6a 00                	push   $0x0
  pushl $234
80107c11:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107c16:	e9 9c f1 ff ff       	jmp    80106db7 <alltraps>

80107c1b <vector235>:
.globl vector235
vector235:
  pushl $0
80107c1b:	6a 00                	push   $0x0
  pushl $235
80107c1d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107c22:	e9 90 f1 ff ff       	jmp    80106db7 <alltraps>

80107c27 <vector236>:
.globl vector236
vector236:
  pushl $0
80107c27:	6a 00                	push   $0x0
  pushl $236
80107c29:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107c2e:	e9 84 f1 ff ff       	jmp    80106db7 <alltraps>

80107c33 <vector237>:
.globl vector237
vector237:
  pushl $0
80107c33:	6a 00                	push   $0x0
  pushl $237
80107c35:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107c3a:	e9 78 f1 ff ff       	jmp    80106db7 <alltraps>

80107c3f <vector238>:
.globl vector238
vector238:
  pushl $0
80107c3f:	6a 00                	push   $0x0
  pushl $238
80107c41:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107c46:	e9 6c f1 ff ff       	jmp    80106db7 <alltraps>

80107c4b <vector239>:
.globl vector239
vector239:
  pushl $0
80107c4b:	6a 00                	push   $0x0
  pushl $239
80107c4d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107c52:	e9 60 f1 ff ff       	jmp    80106db7 <alltraps>

80107c57 <vector240>:
.globl vector240
vector240:
  pushl $0
80107c57:	6a 00                	push   $0x0
  pushl $240
80107c59:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107c5e:	e9 54 f1 ff ff       	jmp    80106db7 <alltraps>

80107c63 <vector241>:
.globl vector241
vector241:
  pushl $0
80107c63:	6a 00                	push   $0x0
  pushl $241
80107c65:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107c6a:	e9 48 f1 ff ff       	jmp    80106db7 <alltraps>

80107c6f <vector242>:
.globl vector242
vector242:
  pushl $0
80107c6f:	6a 00                	push   $0x0
  pushl $242
80107c71:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107c76:	e9 3c f1 ff ff       	jmp    80106db7 <alltraps>

80107c7b <vector243>:
.globl vector243
vector243:
  pushl $0
80107c7b:	6a 00                	push   $0x0
  pushl $243
80107c7d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107c82:	e9 30 f1 ff ff       	jmp    80106db7 <alltraps>

80107c87 <vector244>:
.globl vector244
vector244:
  pushl $0
80107c87:	6a 00                	push   $0x0
  pushl $244
80107c89:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107c8e:	e9 24 f1 ff ff       	jmp    80106db7 <alltraps>

80107c93 <vector245>:
.globl vector245
vector245:
  pushl $0
80107c93:	6a 00                	push   $0x0
  pushl $245
80107c95:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107c9a:	e9 18 f1 ff ff       	jmp    80106db7 <alltraps>

80107c9f <vector246>:
.globl vector246
vector246:
  pushl $0
80107c9f:	6a 00                	push   $0x0
  pushl $246
80107ca1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107ca6:	e9 0c f1 ff ff       	jmp    80106db7 <alltraps>

80107cab <vector247>:
.globl vector247
vector247:
  pushl $0
80107cab:	6a 00                	push   $0x0
  pushl $247
80107cad:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107cb2:	e9 00 f1 ff ff       	jmp    80106db7 <alltraps>

80107cb7 <vector248>:
.globl vector248
vector248:
  pushl $0
80107cb7:	6a 00                	push   $0x0
  pushl $248
80107cb9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107cbe:	e9 f4 f0 ff ff       	jmp    80106db7 <alltraps>

80107cc3 <vector249>:
.globl vector249
vector249:
  pushl $0
80107cc3:	6a 00                	push   $0x0
  pushl $249
80107cc5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107cca:	e9 e8 f0 ff ff       	jmp    80106db7 <alltraps>

80107ccf <vector250>:
.globl vector250
vector250:
  pushl $0
80107ccf:	6a 00                	push   $0x0
  pushl $250
80107cd1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107cd6:	e9 dc f0 ff ff       	jmp    80106db7 <alltraps>

80107cdb <vector251>:
.globl vector251
vector251:
  pushl $0
80107cdb:	6a 00                	push   $0x0
  pushl $251
80107cdd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107ce2:	e9 d0 f0 ff ff       	jmp    80106db7 <alltraps>

80107ce7 <vector252>:
.globl vector252
vector252:
  pushl $0
80107ce7:	6a 00                	push   $0x0
  pushl $252
80107ce9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107cee:	e9 c4 f0 ff ff       	jmp    80106db7 <alltraps>

80107cf3 <vector253>:
.globl vector253
vector253:
  pushl $0
80107cf3:	6a 00                	push   $0x0
  pushl $253
80107cf5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107cfa:	e9 b8 f0 ff ff       	jmp    80106db7 <alltraps>

80107cff <vector254>:
.globl vector254
vector254:
  pushl $0
80107cff:	6a 00                	push   $0x0
  pushl $254
80107d01:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107d06:	e9 ac f0 ff ff       	jmp    80106db7 <alltraps>

80107d0b <vector255>:
.globl vector255
vector255:
  pushl $0
80107d0b:	6a 00                	push   $0x0
  pushl $255
80107d0d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107d12:	e9 a0 f0 ff ff       	jmp    80106db7 <alltraps>
80107d17:	66 90                	xchg   %ax,%ax
80107d19:	66 90                	xchg   %ax,%ax
80107d1b:	66 90                	xchg   %ax,%ax
80107d1d:	66 90                	xchg   %ax,%ax
80107d1f:	90                   	nop

80107d20 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107d20:	55                   	push   %ebp
80107d21:	89 e5                	mov    %esp,%ebp
80107d23:	57                   	push   %edi
80107d24:	56                   	push   %esi
80107d25:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107d26:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80107d2c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107d32:	83 ec 1c             	sub    $0x1c,%esp
  for(; a  < oldsz; a += PGSIZE){
80107d35:	39 d3                	cmp    %edx,%ebx
80107d37:	73 56                	jae    80107d8f <deallocuvm.part.0+0x6f>
80107d39:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80107d3c:	89 c6                	mov    %eax,%esi
80107d3e:	89 d7                	mov    %edx,%edi
80107d40:	eb 12                	jmp    80107d54 <deallocuvm.part.0+0x34>
80107d42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107d48:	83 c2 01             	add    $0x1,%edx
80107d4b:	89 d3                	mov    %edx,%ebx
80107d4d:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107d50:	39 fb                	cmp    %edi,%ebx
80107d52:	73 38                	jae    80107d8c <deallocuvm.part.0+0x6c>
  pde = &pgdir[PDX(va)];
80107d54:	89 da                	mov    %ebx,%edx
80107d56:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80107d59:	8b 04 96             	mov    (%esi,%edx,4),%eax
80107d5c:	a8 01                	test   $0x1,%al
80107d5e:	74 e8                	je     80107d48 <deallocuvm.part.0+0x28>
  return &pgtab[PTX(va)];
80107d60:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107d62:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107d67:	c1 e9 0a             	shr    $0xa,%ecx
80107d6a:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
80107d70:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
80107d77:	85 c0                	test   %eax,%eax
80107d79:	74 cd                	je     80107d48 <deallocuvm.part.0+0x28>
    else if((*pte & PTE_P) != 0){
80107d7b:	8b 10                	mov    (%eax),%edx
80107d7d:	f6 c2 01             	test   $0x1,%dl
80107d80:	75 1e                	jne    80107da0 <deallocuvm.part.0+0x80>
  for(; a  < oldsz; a += PGSIZE){
80107d82:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107d88:	39 fb                	cmp    %edi,%ebx
80107d8a:	72 c8                	jb     80107d54 <deallocuvm.part.0+0x34>
80107d8c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80107d8f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107d92:	89 c8                	mov    %ecx,%eax
80107d94:	5b                   	pop    %ebx
80107d95:	5e                   	pop    %esi
80107d96:	5f                   	pop    %edi
80107d97:	5d                   	pop    %ebp
80107d98:	c3                   	ret
80107d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(pa == 0)
80107da0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107da6:	74 26                	je     80107dce <deallocuvm.part.0+0xae>
      kfree(v);
80107da8:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80107dab:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107db1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107db4:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80107dba:	52                   	push   %edx
80107dbb:	e8 d0 b4 ff ff       	call   80103290 <kfree>
      *pte = 0;
80107dc0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(; a  < oldsz; a += PGSIZE){
80107dc3:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80107dc6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80107dcc:	eb 82                	jmp    80107d50 <deallocuvm.part.0+0x30>
        panic("kfree");
80107dce:	83 ec 0c             	sub    $0xc,%esp
80107dd1:	68 0b 89 10 80       	push   $0x8010890b
80107dd6:	e8 c5 85 ff ff       	call   801003a0 <panic>
80107ddb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80107de0 <mappages>:
{
80107de0:	55                   	push   %ebp
80107de1:	89 e5                	mov    %esp,%ebp
80107de3:	57                   	push   %edi
80107de4:	56                   	push   %esi
80107de5:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107de6:	89 d3                	mov    %edx,%ebx
80107de8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80107dee:	83 ec 1c             	sub    $0x1c,%esp
80107df1:	89 45 e0             	mov    %eax,-0x20(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107df4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107df8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107dfd:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107e00:	8b 45 08             	mov    0x8(%ebp),%eax
80107e03:	29 d8                	sub    %ebx,%eax
80107e05:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107e08:	eb 3f                	jmp    80107e49 <mappages+0x69>
80107e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107e10:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107e12:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107e17:	c1 ea 0a             	shr    $0xa,%edx
80107e1a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107e20:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107e27:	85 c0                	test   %eax,%eax
80107e29:	74 75                	je     80107ea0 <mappages+0xc0>
    if(*pte & PTE_P)
80107e2b:	f6 00 01             	testb  $0x1,(%eax)
80107e2e:	0f 85 86 00 00 00    	jne    80107eba <mappages+0xda>
    *pte = pa | perm | PTE_P;
80107e34:	0b 75 0c             	or     0xc(%ebp),%esi
80107e37:	83 ce 01             	or     $0x1,%esi
80107e3a:	89 30                	mov    %esi,(%eax)
    if(a == last)
80107e3c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80107e3f:	39 c3                	cmp    %eax,%ebx
80107e41:	74 6d                	je     80107eb0 <mappages+0xd0>
    a += PGSIZE;
80107e43:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80107e49:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
80107e4c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80107e4f:	8d 34 03             	lea    (%ebx,%eax,1),%esi
80107e52:	89 d8                	mov    %ebx,%eax
80107e54:	c1 e8 16             	shr    $0x16,%eax
80107e57:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80107e5a:	8b 07                	mov    (%edi),%eax
80107e5c:	a8 01                	test   $0x1,%al
80107e5e:	75 b0                	jne    80107e10 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107e60:	e8 eb b5 ff ff       	call   80103450 <kalloc>
80107e65:	85 c0                	test   %eax,%eax
80107e67:	74 37                	je     80107ea0 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80107e69:	83 ec 04             	sub    $0x4,%esp
80107e6c:	68 00 10 00 00       	push   $0x1000
80107e71:	6a 00                	push   $0x0
80107e73:	50                   	push   %eax
80107e74:	89 45 d8             	mov    %eax,-0x28(%ebp)
80107e77:	e8 44 d6 ff ff       	call   801054c0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107e7c:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
80107e7f:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107e82:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80107e88:	83 c8 07             	or     $0x7,%eax
80107e8b:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80107e8d:	89 d8                	mov    %ebx,%eax
80107e8f:	c1 e8 0a             	shr    $0xa,%eax
80107e92:	25 fc 0f 00 00       	and    $0xffc,%eax
80107e97:	01 d0                	add    %edx,%eax
80107e99:	eb 90                	jmp    80107e2b <mappages+0x4b>
80107e9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
}
80107ea0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107ea3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107ea8:	5b                   	pop    %ebx
80107ea9:	5e                   	pop    %esi
80107eaa:	5f                   	pop    %edi
80107eab:	5d                   	pop    %ebp
80107eac:	c3                   	ret
80107ead:	8d 76 00             	lea    0x0(%esi),%esi
80107eb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107eb3:	31 c0                	xor    %eax,%eax
}
80107eb5:	5b                   	pop    %ebx
80107eb6:	5e                   	pop    %esi
80107eb7:	5f                   	pop    %edi
80107eb8:	5d                   	pop    %ebp
80107eb9:	c3                   	ret
      panic("remap");
80107eba:	83 ec 0c             	sub    $0xc,%esp
80107ebd:	68 ac 8b 10 80       	push   $0x80108bac
80107ec2:	e8 d9 84 ff ff       	call   801003a0 <panic>
80107ec7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107ece:	00 
80107ecf:	90                   	nop

80107ed0 <seginit>:
{
80107ed0:	55                   	push   %ebp
80107ed1:	89 e5                	mov    %esp,%ebp
80107ed3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107ed6:	e8 75 c8 ff ff       	call   80104750 <cpuid>
  pd[0] = size-1;
80107edb:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107ee0:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80107ee6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
80107eea:	c7 80 38 5c 11 80 ff 	movl   $0xffff,-0x7feea3c8(%eax)
80107ef1:	ff 00 00 
80107ef4:	c7 80 3c 5c 11 80 00 	movl   $0xcf9a00,-0x7feea3c4(%eax)
80107efb:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107efe:	c7 80 40 5c 11 80 ff 	movl   $0xffff,-0x7feea3c0(%eax)
80107f05:	ff 00 00 
80107f08:	c7 80 44 5c 11 80 00 	movl   $0xcf9200,-0x7feea3bc(%eax)
80107f0f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107f12:	c7 80 48 5c 11 80 ff 	movl   $0xffff,-0x7feea3b8(%eax)
80107f19:	ff 00 00 
80107f1c:	c7 80 4c 5c 11 80 00 	movl   $0xcffa00,-0x7feea3b4(%eax)
80107f23:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107f26:	c7 80 50 5c 11 80 ff 	movl   $0xffff,-0x7feea3b0(%eax)
80107f2d:	ff 00 00 
80107f30:	c7 80 54 5c 11 80 00 	movl   $0xcff200,-0x7feea3ac(%eax)
80107f37:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80107f3a:	05 30 5c 11 80       	add    $0x80115c30,%eax
  pd[1] = (uint)p;
80107f3f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107f43:	c1 e8 10             	shr    $0x10,%eax
80107f46:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80107f4a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80107f4d:	0f 01 10             	lgdtl  (%eax)
}
80107f50:	c9                   	leave
80107f51:	c3                   	ret
80107f52:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107f59:	00 
80107f5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107f60 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107f60:	a1 e4 89 11 80       	mov    0x801189e4,%eax
80107f65:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107f6a:	0f 22 d8             	mov    %eax,%cr3
}
80107f6d:	c3                   	ret
80107f6e:	66 90                	xchg   %ax,%ax

80107f70 <switchuvm>:
{
80107f70:	55                   	push   %ebp
80107f71:	89 e5                	mov    %esp,%ebp
80107f73:	57                   	push   %edi
80107f74:	56                   	push   %esi
80107f75:	53                   	push   %ebx
80107f76:	83 ec 1c             	sub    $0x1c,%esp
80107f79:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80107f7c:	85 f6                	test   %esi,%esi
80107f7e:	0f 84 cb 00 00 00    	je     8010804f <switchuvm+0xdf>
  if(p->kstack == 0)
80107f84:	8b 46 08             	mov    0x8(%esi),%eax
80107f87:	85 c0                	test   %eax,%eax
80107f89:	0f 84 da 00 00 00    	je     80108069 <switchuvm+0xf9>
  if(p->pgdir == 0)
80107f8f:	8b 46 04             	mov    0x4(%esi),%eax
80107f92:	85 c0                	test   %eax,%eax
80107f94:	0f 84 c2 00 00 00    	je     8010805c <switchuvm+0xec>
  pushcli();
80107f9a:	e8 d1 d2 ff ff       	call   80105270 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107f9f:	e8 4c c7 ff ff       	call   801046f0 <mycpu>
80107fa4:	89 c3                	mov    %eax,%ebx
80107fa6:	e8 45 c7 ff ff       	call   801046f0 <mycpu>
80107fab:	89 c7                	mov    %eax,%edi
80107fad:	e8 3e c7 ff ff       	call   801046f0 <mycpu>
80107fb2:	83 c7 08             	add    $0x8,%edi
80107fb5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107fb8:	e8 33 c7 ff ff       	call   801046f0 <mycpu>
80107fbd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107fc0:	ba 67 00 00 00       	mov    $0x67,%edx
80107fc5:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80107fcc:	83 c0 08             	add    $0x8,%eax
80107fcf:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107fd6:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107fdb:	83 c1 08             	add    $0x8,%ecx
80107fde:	c1 e8 18             	shr    $0x18,%eax
80107fe1:	c1 e9 10             	shr    $0x10,%ecx
80107fe4:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80107fea:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107ff0:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107ff5:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107ffc:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80108001:	e8 ea c6 ff ff       	call   801046f0 <mycpu>
80108006:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
8010800d:	e8 de c6 ff ff       	call   801046f0 <mycpu>
80108012:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80108016:	8b 5e 08             	mov    0x8(%esi),%ebx
80108019:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010801f:	e8 cc c6 ff ff       	call   801046f0 <mycpu>
80108024:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80108027:	e8 c4 c6 ff ff       	call   801046f0 <mycpu>
8010802c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80108030:	b8 28 00 00 00       	mov    $0x28,%eax
80108035:	0f 00 d8             	ltr    %eax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80108038:	8b 46 04             	mov    0x4(%esi),%eax
8010803b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80108040:	0f 22 d8             	mov    %eax,%cr3
}
80108043:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108046:	5b                   	pop    %ebx
80108047:	5e                   	pop    %esi
80108048:	5f                   	pop    %edi
80108049:	5d                   	pop    %ebp
  popcli();
8010804a:	e9 71 d2 ff ff       	jmp    801052c0 <popcli>
    panic("switchuvm: no process");
8010804f:	83 ec 0c             	sub    $0xc,%esp
80108052:	68 b2 8b 10 80       	push   $0x80108bb2
80108057:	e8 44 83 ff ff       	call   801003a0 <panic>
    panic("switchuvm: no pgdir");
8010805c:	83 ec 0c             	sub    $0xc,%esp
8010805f:	68 dd 8b 10 80       	push   $0x80108bdd
80108064:	e8 37 83 ff ff       	call   801003a0 <panic>
    panic("switchuvm: no kstack");
80108069:	83 ec 0c             	sub    $0xc,%esp
8010806c:	68 c8 8b 10 80       	push   $0x80108bc8
80108071:	e8 2a 83 ff ff       	call   801003a0 <panic>
80108076:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010807d:	00 
8010807e:	66 90                	xchg   %ax,%ax

80108080 <inituvm>:
{
80108080:	55                   	push   %ebp
80108081:	89 e5                	mov    %esp,%ebp
80108083:	57                   	push   %edi
80108084:	56                   	push   %esi
80108085:	53                   	push   %ebx
80108086:	83 ec 1c             	sub    $0x1c,%esp
80108089:	8b 45 08             	mov    0x8(%ebp),%eax
8010808c:	8b 75 10             	mov    0x10(%ebp),%esi
8010808f:	8b 7d 0c             	mov    0xc(%ebp),%edi
80108092:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80108095:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
8010809b:	77 49                	ja     801080e6 <inituvm+0x66>
  mem = kalloc();
8010809d:	e8 ae b3 ff ff       	call   80103450 <kalloc>
  memset(mem, 0, PGSIZE);
801080a2:	83 ec 04             	sub    $0x4,%esp
801080a5:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
801080aa:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
801080ac:	6a 00                	push   $0x0
801080ae:	50                   	push   %eax
801080af:	e8 0c d4 ff ff       	call   801054c0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801080b4:	58                   	pop    %eax
801080b5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801080bb:	5a                   	pop    %edx
801080bc:	6a 06                	push   $0x6
801080be:	b9 00 10 00 00       	mov    $0x1000,%ecx
801080c3:	31 d2                	xor    %edx,%edx
801080c5:	50                   	push   %eax
801080c6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801080c9:	e8 12 fd ff ff       	call   80107de0 <mappages>
  memmove(mem, init, sz);
801080ce:	83 c4 10             	add    $0x10,%esp
801080d1:	89 75 10             	mov    %esi,0x10(%ebp)
801080d4:	89 7d 0c             	mov    %edi,0xc(%ebp)
801080d7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801080da:	8d 65 f4             	lea    -0xc(%ebp),%esp
801080dd:	5b                   	pop    %ebx
801080de:	5e                   	pop    %esi
801080df:	5f                   	pop    %edi
801080e0:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801080e1:	e9 6a d4 ff ff       	jmp    80105550 <memmove>
    panic("inituvm: more than a page");
801080e6:	83 ec 0c             	sub    $0xc,%esp
801080e9:	68 f1 8b 10 80       	push   $0x80108bf1
801080ee:	e8 ad 82 ff ff       	call   801003a0 <panic>
801080f3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801080fa:	00 
801080fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80108100 <loaduvm>:
{
80108100:	55                   	push   %ebp
80108101:	89 e5                	mov    %esp,%ebp
80108103:	57                   	push   %edi
80108104:	56                   	push   %esi
80108105:	53                   	push   %ebx
80108106:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80108109:	8b 75 0c             	mov    0xc(%ebp),%esi
{
8010810c:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
8010810f:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
80108115:	0f 85 a2 00 00 00    	jne    801081bd <loaduvm+0xbd>
  for(i = 0; i < sz; i += PGSIZE){
8010811b:	85 ff                	test   %edi,%edi
8010811d:	74 7d                	je     8010819c <loaduvm+0x9c>
8010811f:	90                   	nop
  pde = &pgdir[PDX(va)];
80108120:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80108123:	8b 55 08             	mov    0x8(%ebp),%edx
80108126:	01 f0                	add    %esi,%eax
  pde = &pgdir[PDX(va)];
80108128:	89 c1                	mov    %eax,%ecx
8010812a:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010812d:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
80108130:	f6 c1 01             	test   $0x1,%cl
80108133:	75 13                	jne    80108148 <loaduvm+0x48>
      panic("loaduvm: address should exist");
80108135:	83 ec 0c             	sub    $0xc,%esp
80108138:	68 0b 8c 10 80       	push   $0x80108c0b
8010813d:	e8 5e 82 ff ff       	call   801003a0 <panic>
80108142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80108148:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010814b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80108151:	25 fc 0f 00 00       	and    $0xffc,%eax
80108156:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010815d:	85 c9                	test   %ecx,%ecx
8010815f:	74 d4                	je     80108135 <loaduvm+0x35>
    if(sz - i < PGSIZE)
80108161:	89 fb                	mov    %edi,%ebx
80108163:	b8 00 10 00 00       	mov    $0x1000,%eax
80108168:	29 f3                	sub    %esi,%ebx
8010816a:	39 c3                	cmp    %eax,%ebx
8010816c:	0f 47 d8             	cmova  %eax,%ebx
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010816f:	53                   	push   %ebx
80108170:	8b 45 14             	mov    0x14(%ebp),%eax
80108173:	01 f0                	add    %esi,%eax
80108175:	50                   	push   %eax
    pa = PTE_ADDR(*pte);
80108176:	8b 01                	mov    (%ecx),%eax
80108178:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010817d:	05 00 00 00 80       	add    $0x80000000,%eax
80108182:	50                   	push   %eax
80108183:	ff 75 10             	push   0x10(%ebp)
80108186:	e8 15 a7 ff ff       	call   801028a0 <readi>
8010818b:	83 c4 10             	add    $0x10,%esp
8010818e:	39 d8                	cmp    %ebx,%eax
80108190:	75 1e                	jne    801081b0 <loaduvm+0xb0>
  for(i = 0; i < sz; i += PGSIZE){
80108192:	81 c6 00 10 00 00    	add    $0x1000,%esi
80108198:	39 fe                	cmp    %edi,%esi
8010819a:	72 84                	jb     80108120 <loaduvm+0x20>
}
8010819c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010819f:	31 c0                	xor    %eax,%eax
}
801081a1:	5b                   	pop    %ebx
801081a2:	5e                   	pop    %esi
801081a3:	5f                   	pop    %edi
801081a4:	5d                   	pop    %ebp
801081a5:	c3                   	ret
801081a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801081ad:	00 
801081ae:	66 90                	xchg   %ax,%ax
801081b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801081b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801081b8:	5b                   	pop    %ebx
801081b9:	5e                   	pop    %esi
801081ba:	5f                   	pop    %edi
801081bb:	5d                   	pop    %ebp
801081bc:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
801081bd:	83 ec 0c             	sub    $0xc,%esp
801081c0:	68 7c 8e 10 80       	push   $0x80108e7c
801081c5:	e8 d6 81 ff ff       	call   801003a0 <panic>
801081ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801081d0 <allocuvm>:
{
801081d0:	55                   	push   %ebp
801081d1:	89 e5                	mov    %esp,%ebp
801081d3:	57                   	push   %edi
801081d4:	56                   	push   %esi
801081d5:	53                   	push   %ebx
801081d6:	83 ec 1c             	sub    $0x1c,%esp
801081d9:	8b 75 10             	mov    0x10(%ebp),%esi
  if(newsz >= KERNBASE)
801081dc:	85 f6                	test   %esi,%esi
801081de:	0f 88 98 00 00 00    	js     8010827c <allocuvm+0xac>
801081e4:	89 f2                	mov    %esi,%edx
  if(newsz < oldsz)
801081e6:	3b 75 0c             	cmp    0xc(%ebp),%esi
801081e9:	0f 82 a1 00 00 00    	jb     80108290 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
801081ef:	8b 45 0c             	mov    0xc(%ebp),%eax
801081f2:	05 ff 0f 00 00       	add    $0xfff,%eax
801081f7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801081fc:	89 c7                	mov    %eax,%edi
  for(; a < newsz; a += PGSIZE){
801081fe:	39 f0                	cmp    %esi,%eax
80108200:	0f 83 8d 00 00 00    	jae    80108293 <allocuvm+0xc3>
80108206:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80108209:	eb 44                	jmp    8010824f <allocuvm+0x7f>
8010820b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80108210:	83 ec 04             	sub    $0x4,%esp
80108213:	68 00 10 00 00       	push   $0x1000
80108218:	6a 00                	push   $0x0
8010821a:	50                   	push   %eax
8010821b:	e8 a0 d2 ff ff       	call   801054c0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80108220:	58                   	pop    %eax
80108221:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80108227:	5a                   	pop    %edx
80108228:	6a 06                	push   $0x6
8010822a:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010822f:	89 fa                	mov    %edi,%edx
80108231:	50                   	push   %eax
80108232:	8b 45 08             	mov    0x8(%ebp),%eax
80108235:	e8 a6 fb ff ff       	call   80107de0 <mappages>
8010823a:	83 c4 10             	add    $0x10,%esp
8010823d:	85 c0                	test   %eax,%eax
8010823f:	78 5f                	js     801082a0 <allocuvm+0xd0>
  for(; a < newsz; a += PGSIZE){
80108241:	81 c7 00 10 00 00    	add    $0x1000,%edi
80108247:	39 f7                	cmp    %esi,%edi
80108249:	0f 83 89 00 00 00    	jae    801082d8 <allocuvm+0x108>
    mem = kalloc();
8010824f:	e8 fc b1 ff ff       	call   80103450 <kalloc>
80108254:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80108256:	85 c0                	test   %eax,%eax
80108258:	75 b6                	jne    80108210 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
8010825a:	83 ec 0c             	sub    $0xc,%esp
8010825d:	68 29 8c 10 80       	push   $0x80108c29
80108262:	e8 d9 89 ff ff       	call   80100c40 <cprintf>
  if(newsz >= oldsz)
80108267:	83 c4 10             	add    $0x10,%esp
8010826a:	3b 75 0c             	cmp    0xc(%ebp),%esi
8010826d:	74 0d                	je     8010827c <allocuvm+0xac>
8010826f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80108272:	8b 45 08             	mov    0x8(%ebp),%eax
80108275:	89 f2                	mov    %esi,%edx
80108277:	e8 a4 fa ff ff       	call   80107d20 <deallocuvm.part.0>
    return 0;
8010827c:	31 d2                	xor    %edx,%edx
}
8010827e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108281:	89 d0                	mov    %edx,%eax
80108283:	5b                   	pop    %ebx
80108284:	5e                   	pop    %esi
80108285:	5f                   	pop    %edi
80108286:	5d                   	pop    %ebp
80108287:	c3                   	ret
80108288:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010828f:	00 
    return oldsz;
80108290:	8b 55 0c             	mov    0xc(%ebp),%edx
}
80108293:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108296:	89 d0                	mov    %edx,%eax
80108298:	5b                   	pop    %ebx
80108299:	5e                   	pop    %esi
8010829a:	5f                   	pop    %edi
8010829b:	5d                   	pop    %ebp
8010829c:	c3                   	ret
8010829d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801082a0:	83 ec 0c             	sub    $0xc,%esp
801082a3:	68 41 8c 10 80       	push   $0x80108c41
801082a8:	e8 93 89 ff ff       	call   80100c40 <cprintf>
  if(newsz >= oldsz)
801082ad:	83 c4 10             	add    $0x10,%esp
801082b0:	3b 75 0c             	cmp    0xc(%ebp),%esi
801082b3:	74 0d                	je     801082c2 <allocuvm+0xf2>
801082b5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801082b8:	8b 45 08             	mov    0x8(%ebp),%eax
801082bb:	89 f2                	mov    %esi,%edx
801082bd:	e8 5e fa ff ff       	call   80107d20 <deallocuvm.part.0>
      kfree(mem);
801082c2:	83 ec 0c             	sub    $0xc,%esp
801082c5:	53                   	push   %ebx
801082c6:	e8 c5 af ff ff       	call   80103290 <kfree>
      return 0;
801082cb:	83 c4 10             	add    $0x10,%esp
    return 0;
801082ce:	31 d2                	xor    %edx,%edx
801082d0:	eb ac                	jmp    8010827e <allocuvm+0xae>
801082d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801082d8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
}
801082db:	8d 65 f4             	lea    -0xc(%ebp),%esp
801082de:	5b                   	pop    %ebx
801082df:	5e                   	pop    %esi
801082e0:	89 d0                	mov    %edx,%eax
801082e2:	5f                   	pop    %edi
801082e3:	5d                   	pop    %ebp
801082e4:	c3                   	ret
801082e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801082ec:	00 
801082ed:	8d 76 00             	lea    0x0(%esi),%esi

801082f0 <deallocuvm>:
{
801082f0:	55                   	push   %ebp
801082f1:	89 e5                	mov    %esp,%ebp
801082f3:	8b 55 0c             	mov    0xc(%ebp),%edx
801082f6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801082f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801082fc:	39 d1                	cmp    %edx,%ecx
801082fe:	73 10                	jae    80108310 <deallocuvm+0x20>
}
80108300:	5d                   	pop    %ebp
80108301:	e9 1a fa ff ff       	jmp    80107d20 <deallocuvm.part.0>
80108306:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010830d:	00 
8010830e:	66 90                	xchg   %ax,%ax
80108310:	89 d0                	mov    %edx,%eax
80108312:	5d                   	pop    %ebp
80108313:	c3                   	ret
80108314:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010831b:	00 
8010831c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80108320 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80108320:	55                   	push   %ebp
80108321:	89 e5                	mov    %esp,%ebp
80108323:	57                   	push   %edi
80108324:	56                   	push   %esi
80108325:	53                   	push   %ebx
80108326:	83 ec 0c             	sub    $0xc,%esp
80108329:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010832c:	85 f6                	test   %esi,%esi
8010832e:	74 59                	je     80108389 <freevm+0x69>
  if(newsz >= oldsz)
80108330:	31 c9                	xor    %ecx,%ecx
80108332:	ba 00 00 00 80       	mov    $0x80000000,%edx
80108337:	89 f0                	mov    %esi,%eax
80108339:	89 f3                	mov    %esi,%ebx
8010833b:	e8 e0 f9 ff ff       	call   80107d20 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80108340:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80108346:	eb 0f                	jmp    80108357 <freevm+0x37>
80108348:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010834f:	00 
80108350:	83 c3 04             	add    $0x4,%ebx
80108353:	39 fb                	cmp    %edi,%ebx
80108355:	74 23                	je     8010837a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80108357:	8b 03                	mov    (%ebx),%eax
80108359:	a8 01                	test   $0x1,%al
8010835b:	74 f3                	je     80108350 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010835d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80108362:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80108365:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80108368:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010836d:	50                   	push   %eax
8010836e:	e8 1d af ff ff       	call   80103290 <kfree>
80108373:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80108376:	39 fb                	cmp    %edi,%ebx
80108378:	75 dd                	jne    80108357 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010837a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010837d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108380:	5b                   	pop    %ebx
80108381:	5e                   	pop    %esi
80108382:	5f                   	pop    %edi
80108383:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80108384:	e9 07 af ff ff       	jmp    80103290 <kfree>
    panic("freevm: no pgdir");
80108389:	83 ec 0c             	sub    $0xc,%esp
8010838c:	68 5d 8c 10 80       	push   $0x80108c5d
80108391:	e8 0a 80 ff ff       	call   801003a0 <panic>
80108396:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010839d:	00 
8010839e:	66 90                	xchg   %ax,%ax

801083a0 <setupkvm>:
{
801083a0:	55                   	push   %ebp
801083a1:	89 e5                	mov    %esp,%ebp
801083a3:	56                   	push   %esi
801083a4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801083a5:	e8 a6 b0 ff ff       	call   80103450 <kalloc>
801083aa:	85 c0                	test   %eax,%eax
801083ac:	74 5e                	je     8010840c <setupkvm+0x6c>
  memset(pgdir, 0, PGSIZE);
801083ae:	83 ec 04             	sub    $0x4,%esp
801083b1:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801083b3:	bb 20 c4 10 80       	mov    $0x8010c420,%ebx
  memset(pgdir, 0, PGSIZE);
801083b8:	68 00 10 00 00       	push   $0x1000
801083bd:	6a 00                	push   $0x0
801083bf:	50                   	push   %eax
801083c0:	e8 fb d0 ff ff       	call   801054c0 <memset>
801083c5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
801083c8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801083cb:	83 ec 08             	sub    $0x8,%esp
801083ce:	8b 4b 08             	mov    0x8(%ebx),%ecx
801083d1:	8b 13                	mov    (%ebx),%edx
801083d3:	ff 73 0c             	push   0xc(%ebx)
801083d6:	50                   	push   %eax
801083d7:	29 c1                	sub    %eax,%ecx
801083d9:	89 f0                	mov    %esi,%eax
801083db:	e8 00 fa ff ff       	call   80107de0 <mappages>
801083e0:	83 c4 10             	add    $0x10,%esp
801083e3:	85 c0                	test   %eax,%eax
801083e5:	78 19                	js     80108400 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801083e7:	83 c3 10             	add    $0x10,%ebx
801083ea:	81 fb 60 c4 10 80    	cmp    $0x8010c460,%ebx
801083f0:	75 d6                	jne    801083c8 <setupkvm+0x28>
}
801083f2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801083f5:	89 f0                	mov    %esi,%eax
801083f7:	5b                   	pop    %ebx
801083f8:	5e                   	pop    %esi
801083f9:	5d                   	pop    %ebp
801083fa:	c3                   	ret
801083fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80108400:	83 ec 0c             	sub    $0xc,%esp
80108403:	56                   	push   %esi
80108404:	e8 17 ff ff ff       	call   80108320 <freevm>
      return 0;
80108409:	83 c4 10             	add    $0x10,%esp
}
8010840c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
8010840f:	31 f6                	xor    %esi,%esi
}
80108411:	89 f0                	mov    %esi,%eax
80108413:	5b                   	pop    %ebx
80108414:	5e                   	pop    %esi
80108415:	5d                   	pop    %ebp
80108416:	c3                   	ret
80108417:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010841e:	00 
8010841f:	90                   	nop

80108420 <kvmalloc>:
{
80108420:	55                   	push   %ebp
80108421:	89 e5                	mov    %esp,%ebp
80108423:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80108426:	e8 75 ff ff ff       	call   801083a0 <setupkvm>
8010842b:	a3 e4 89 11 80       	mov    %eax,0x801189e4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108430:	05 00 00 00 80       	add    $0x80000000,%eax
80108435:	0f 22 d8             	mov    %eax,%cr3
}
80108438:	c9                   	leave
80108439:	c3                   	ret
8010843a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108440 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108440:	55                   	push   %ebp
80108441:	89 e5                	mov    %esp,%ebp
80108443:	83 ec 08             	sub    $0x8,%esp
80108446:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80108449:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
8010844c:	89 c1                	mov    %eax,%ecx
8010844e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80108451:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80108454:	f6 c2 01             	test   $0x1,%dl
80108457:	75 17                	jne    80108470 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80108459:	83 ec 0c             	sub    $0xc,%esp
8010845c:	68 6e 8c 10 80       	push   $0x80108c6e
80108461:	e8 3a 7f ff ff       	call   801003a0 <panic>
80108466:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010846d:	00 
8010846e:	66 90                	xchg   %ax,%ax
  return &pgtab[PTX(va)];
80108470:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108473:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80108479:	25 fc 0f 00 00       	and    $0xffc,%eax
8010847e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80108485:	85 c0                	test   %eax,%eax
80108487:	74 d0                	je     80108459 <clearpteu+0x19>
  *pte &= ~PTE_U;
80108489:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010848c:	c9                   	leave
8010848d:	c3                   	ret
8010848e:	66 90                	xchg   %ax,%ax

80108490 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80108490:	55                   	push   %ebp
80108491:	89 e5                	mov    %esp,%ebp
80108493:	57                   	push   %edi
80108494:	56                   	push   %esi
80108495:	53                   	push   %ebx
80108496:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80108499:	e8 02 ff ff ff       	call   801083a0 <setupkvm>
8010849e:	89 45 e0             	mov    %eax,-0x20(%ebp)
801084a1:	85 c0                	test   %eax,%eax
801084a3:	0f 84 e9 00 00 00    	je     80108592 <copyuvm+0x102>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801084a9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801084ac:	85 c9                	test   %ecx,%ecx
801084ae:	0f 84 b2 00 00 00    	je     80108566 <copyuvm+0xd6>
801084b4:	31 f6                	xor    %esi,%esi
801084b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801084bd:	00 
801084be:	66 90                	xchg   %ax,%ax
  if(*pde & PTE_P){
801084c0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
801084c3:	89 f0                	mov    %esi,%eax
801084c5:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
801084c8:	8b 04 81             	mov    (%ecx,%eax,4),%eax
801084cb:	a8 01                	test   $0x1,%al
801084cd:	75 11                	jne    801084e0 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801084cf:	83 ec 0c             	sub    $0xc,%esp
801084d2:	68 78 8c 10 80       	push   $0x80108c78
801084d7:	e8 c4 7e ff ff       	call   801003a0 <panic>
801084dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
801084e0:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801084e2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801084e7:	c1 ea 0a             	shr    $0xa,%edx
801084ea:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801084f0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801084f7:	85 c0                	test   %eax,%eax
801084f9:	74 d4                	je     801084cf <copyuvm+0x3f>
    if(!(*pte & PTE_P))
801084fb:	8b 00                	mov    (%eax),%eax
801084fd:	a8 01                	test   $0x1,%al
801084ff:	0f 84 9f 00 00 00    	je     801085a4 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80108505:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80108507:	25 ff 0f 00 00       	and    $0xfff,%eax
8010850c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
8010850f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80108515:	e8 36 af ff ff       	call   80103450 <kalloc>
8010851a:	89 c3                	mov    %eax,%ebx
8010851c:	85 c0                	test   %eax,%eax
8010851e:	74 64                	je     80108584 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80108520:	83 ec 04             	sub    $0x4,%esp
80108523:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80108529:	68 00 10 00 00       	push   $0x1000
8010852e:	57                   	push   %edi
8010852f:	50                   	push   %eax
80108530:	e8 1b d0 ff ff       	call   80105550 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80108535:	58                   	pop    %eax
80108536:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010853c:	5a                   	pop    %edx
8010853d:	ff 75 e4             	push   -0x1c(%ebp)
80108540:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108545:	89 f2                	mov    %esi,%edx
80108547:	50                   	push   %eax
80108548:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010854b:	e8 90 f8 ff ff       	call   80107de0 <mappages>
80108550:	83 c4 10             	add    $0x10,%esp
80108553:	85 c0                	test   %eax,%eax
80108555:	78 21                	js     80108578 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
80108557:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010855d:	3b 75 0c             	cmp    0xc(%ebp),%esi
80108560:	0f 82 5a ff ff ff    	jb     801084c0 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80108566:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108569:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010856c:	5b                   	pop    %ebx
8010856d:	5e                   	pop    %esi
8010856e:	5f                   	pop    %edi
8010856f:	5d                   	pop    %ebp
80108570:	c3                   	ret
80108571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80108578:	83 ec 0c             	sub    $0xc,%esp
8010857b:	53                   	push   %ebx
8010857c:	e8 0f ad ff ff       	call   80103290 <kfree>
      goto bad;
80108581:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80108584:	83 ec 0c             	sub    $0xc,%esp
80108587:	ff 75 e0             	push   -0x20(%ebp)
8010858a:	e8 91 fd ff ff       	call   80108320 <freevm>
  return 0;
8010858f:	83 c4 10             	add    $0x10,%esp
    return 0;
80108592:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80108599:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010859c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010859f:	5b                   	pop    %ebx
801085a0:	5e                   	pop    %esi
801085a1:	5f                   	pop    %edi
801085a2:	5d                   	pop    %ebp
801085a3:	c3                   	ret
      panic("copyuvm: page not present");
801085a4:	83 ec 0c             	sub    $0xc,%esp
801085a7:	68 92 8c 10 80       	push   $0x80108c92
801085ac:	e8 ef 7d ff ff       	call   801003a0 <panic>
801085b1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801085b8:	00 
801085b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801085c0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801085c0:	55                   	push   %ebp
801085c1:	89 e5                	mov    %esp,%ebp
801085c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801085c6:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801085c9:	89 c1                	mov    %eax,%ecx
801085cb:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801085ce:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801085d1:	f6 c2 01             	test   $0x1,%dl
801085d4:	0f 84 f8 00 00 00    	je     801086d2 <uva2ka.cold>
  return &pgtab[PTX(va)];
801085da:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801085dd:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801085e3:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
801085e4:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
801085e9:	8b 94 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%edx
  return (char*)P2V(PTE_ADDR(*pte));
801085f0:	89 d0                	mov    %edx,%eax
801085f2:	f7 d2                	not    %edx
801085f4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801085f9:	05 00 00 00 80       	add    $0x80000000,%eax
801085fe:	83 e2 05             	and    $0x5,%edx
80108601:	ba 00 00 00 00       	mov    $0x0,%edx
80108606:	0f 45 c2             	cmovne %edx,%eax
}
80108609:	c3                   	ret
8010860a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108610 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108610:	55                   	push   %ebp
80108611:	89 e5                	mov    %esp,%ebp
80108613:	57                   	push   %edi
80108614:	56                   	push   %esi
80108615:	53                   	push   %ebx
80108616:	83 ec 0c             	sub    $0xc,%esp
80108619:	8b 75 14             	mov    0x14(%ebp),%esi
8010861c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010861f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80108622:	85 f6                	test   %esi,%esi
80108624:	75 51                	jne    80108677 <copyout+0x67>
80108626:	e9 9d 00 00 00       	jmp    801086c8 <copyout+0xb8>
8010862b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  return (char*)P2V(PTE_ADDR(*pte));
80108630:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80108636:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
8010863c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80108642:	74 74                	je     801086b8 <copyout+0xa8>
      return -1;
    n = PGSIZE - (va - va0);
80108644:	89 fb                	mov    %edi,%ebx
80108646:	29 c3                	sub    %eax,%ebx
80108648:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
8010864e:	39 f3                	cmp    %esi,%ebx
80108650:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80108653:	29 f8                	sub    %edi,%eax
80108655:	83 ec 04             	sub    $0x4,%esp
80108658:	01 c1                	add    %eax,%ecx
8010865a:	53                   	push   %ebx
8010865b:	52                   	push   %edx
8010865c:	89 55 10             	mov    %edx,0x10(%ebp)
8010865f:	51                   	push   %ecx
80108660:	e8 eb ce ff ff       	call   80105550 <memmove>
    len -= n;
    buf += n;
80108665:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80108668:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
8010866e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80108671:	01 da                	add    %ebx,%edx
  while(len > 0){
80108673:	29 de                	sub    %ebx,%esi
80108675:	74 51                	je     801086c8 <copyout+0xb8>
  if(*pde & PTE_P){
80108677:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
8010867a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
8010867c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
8010867e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80108681:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80108687:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
8010868a:	f6 c1 01             	test   $0x1,%cl
8010868d:	0f 84 46 00 00 00    	je     801086d9 <copyout.cold>
  return &pgtab[PTX(va)];
80108693:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108695:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
8010869b:	c1 eb 0c             	shr    $0xc,%ebx
8010869e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
801086a4:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
801086ab:	89 d9                	mov    %ebx,%ecx
801086ad:	f7 d1                	not    %ecx
801086af:	83 e1 05             	and    $0x5,%ecx
801086b2:	0f 84 78 ff ff ff    	je     80108630 <copyout+0x20>
  }
  return 0;
}
801086b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801086bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801086c0:	5b                   	pop    %ebx
801086c1:	5e                   	pop    %esi
801086c2:	5f                   	pop    %edi
801086c3:	5d                   	pop    %ebp
801086c4:	c3                   	ret
801086c5:	8d 76 00             	lea    0x0(%esi),%esi
801086c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801086cb:	31 c0                	xor    %eax,%eax
}
801086cd:	5b                   	pop    %ebx
801086ce:	5e                   	pop    %esi
801086cf:	5f                   	pop    %edi
801086d0:	5d                   	pop    %ebp
801086d1:	c3                   	ret

801086d2 <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
801086d2:	a1 00 00 00 00       	mov    0x0,%eax
801086d7:	0f 0b                	ud2

801086d9 <copyout.cold>:
801086d9:	a1 00 00 00 00       	mov    0x0,%eax
801086de:	0f 0b                	ud2
