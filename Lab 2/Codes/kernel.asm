
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
8010002d:	b8 50 3e 10 80       	mov    $0x80103e50,%eax
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
8010004c:	68 00 86 10 80       	push   $0x80108600
80100051:	68 20 c5 10 80       	push   $0x8010c520
80100056:	e8 95 51 00 00       	call   801051f0 <initlock>
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
80100092:	68 07 86 10 80       	push   $0x80108607
80100097:	50                   	push   %eax
80100098:	e8 23 50 00 00       	call   801050c0 <initsleeplock>
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
801000e4:	e8 f7 52 00 00       	call   801053e0 <acquire>
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
80100162:	e8 19 52 00 00       	call   80105380 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 8e 4f 00 00       	call   80105100 <acquiresleep>
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
8010018c:	e8 4f 2f 00 00       	call   801030e0 <iderw>
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
801001a1:	68 0e 86 10 80       	push   $0x8010860e
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
801001be:	e8 dd 4f 00 00       	call   801051a0 <holdingsleep>
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
801001d4:	e9 07 2f 00 00       	jmp    801030e0 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 1f 86 10 80       	push   $0x8010861f
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
801001ff:	e8 9c 4f 00 00       	call   801051a0 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 63                	je     8010026e <brelse+0x7e>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 4c 4f 00 00       	call   80105160 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 c5 10 80 	movl   $0x8010c520,(%esp)
8010021b:	e8 c0 51 00 00       	call   801053e0 <acquire>
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
80100269:	e9 12 51 00 00       	jmp    80105380 <release>
    panic("brelse");
8010026e:	83 ec 0c             	sub    $0xc,%esp
80100271:	68 26 86 10 80       	push   $0x80108626
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
80100294:	e8 f7 23 00 00       	call   80102690 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 60 15 11 80 	movl   $0x80111560,(%esp)
801002a0:	e8 3b 51 00 00       	call   801053e0 <acquire>

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
801002cd:	e8 8e 4b 00 00       	call   80104e60 <sleep>
    while(input.r == input.w){
801002d2:	a1 28 15 11 80       	mov    0x80111528,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 2c 15 11 80    	cmp    0x8011152c,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 a9 44 00 00       	call   80104790 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 60 15 11 80       	push   $0x80111560
801002f6:	e8 85 50 00 00       	call   80105380 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 ac 22 00 00       	call   801025b0 <ilock>
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
8010034c:	e8 2f 50 00 00       	call   80105380 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 56 22 00 00       	call   801025b0 <ilock>
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
801003b9:	e8 32 33 00 00       	call   801036f0 <lapicid>
801003be:	83 ec 08             	sub    $0x8,%esp
801003c1:	50                   	push   %eax
801003c2:	68 2d 86 10 80       	push   $0x8010862d
801003c7:	e8 74 08 00 00       	call   80100c40 <cprintf>
  cprintf(s);
801003cc:	58                   	pop    %eax
801003cd:	ff 75 08             	push   0x8(%ebp)
801003d0:	e8 6b 08 00 00       	call   80100c40 <cprintf>
  cprintf("\n");
801003d5:	c7 04 24 65 8b 10 80 	movl   $0x80108b65,(%esp)
801003dc:	e8 5f 08 00 00       	call   80100c40 <cprintf>
  getcallerpcs(&s, pcs);
801003e1:	8d 45 08             	lea    0x8(%ebp),%eax
801003e4:	5a                   	pop    %edx
801003e5:	59                   	pop    %ecx
801003e6:	53                   	push   %ebx
801003e7:	50                   	push   %eax
801003e8:	e8 23 4e 00 00       	call   80105210 <getcallerpcs>
  for(i=0; i<10; i++)
801003ed:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003f0:	83 ec 08             	sub    $0x8,%esp
801003f3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003f5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003f8:	68 41 86 10 80       	push   $0x80108641
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
8010052c:	e8 3f 50 00 00       	call   80105570 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100531:	b8 80 07 00 00       	mov    $0x780,%eax
80100536:	83 c4 0c             	add    $0xc,%esp
80100539:	29 f8                	sub    %edi,%eax
8010053b:	01 c0                	add    %eax,%eax
8010053d:	50                   	push   %eax
8010053e:	6a 00                	push   $0x0
80100540:	56                   	push   %esi
80100541:	e8 9a 4f 00 00       	call   801054e0 <memset>
  outb(CRTPORT+1, pos);
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	c6 45 e4 07          	movb   $0x7,-0x1c(%ebp)
8010054d:	e9 51 ff ff ff       	jmp    801004a3 <cgaputc+0x83>
    panic("pos under/overflow");
80100552:	83 ec 0c             	sub    $0xc,%esp
80100555:	68 45 86 10 80       	push   $0x80108645
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
80100583:	e8 b8 6b 00 00       	call   80107140 <uartputc>
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
801005d9:	e8 62 6b 00 00       	call   80107140 <uartputc>
    uartputc(' ');
801005de:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801005e5:	e8 56 6b 00 00       	call   80107140 <uartputc>
    uartputc('\b');
801005ea:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801005f1:	e8 4a 6b 00 00       	call   80107140 <uartputc>
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
8010063b:	0f b6 92 08 8c 10 80 	movzbl -0x7fef73f8(%edx),%edx
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
8010072a:	e8 b1 4e 00 00       	call   801055e0 <strncmp>
8010072f:	83 c4 10             	add    $0x10,%esp
80100732:	85 c0                	test   %eax,%eax
80100734:	75 da                	jne    80100710 <handle_tab_completion+0x70>
  int match_len = strlen(match);
80100736:	83 ec 0c             	sub    $0xc,%esp
80100739:	57                   	push   %edi
8010073a:	e8 91 4f 00 00       	call   801056d0 <strlen>
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
80100855:	e8 e6 68 00 00       	call   80107140 <uartputc>
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
80100889:	e8 b2 68 00 00       	call   80107140 <uartputc>
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
801008a9:	e8 92 68 00 00       	call   80107140 <uartputc>
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
801008dc:	e8 af 1d 00 00       	call   80102690 <iunlock>
  acquire(&cons.lock);
801008e1:	c7 04 24 60 15 11 80 	movl   $0x80111560,(%esp)
801008e8:	e8 f3 4a 00 00       	call   801053e0 <acquire>
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
8010091c:	e8 1f 68 00 00       	call   80107140 <uartputc>
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
8010093a:	e8 41 4a 00 00       	call   80105380 <release>
  ilock(ip);
8010093f:	58                   	pop    %eax
80100940:	ff 75 08             	push   0x8(%ebp)
80100943:	e8 68 1c 00 00       	call   801025b0 <ilock>

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
801009d3:	e8 68 67 00 00       	call   80107140 <uartputc>
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
80100a7c:	e8 bf 66 00 00       	call   80107140 <uartputc>
    uartputc(' ');
80100a81:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100a88:	e8 b3 66 00 00       	call   80107140 <uartputc>
    uartputc('\b');
80100a8d:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100a94:	e8 a7 66 00 00       	call   80107140 <uartputc>
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
80100ad5:	e8 66 66 00 00       	call   80107140 <uartputc>
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
80100b1d:	e8 1e 66 00 00       	call   80107140 <uartputc>
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
80100b54:	e8 e7 65 00 00       	call   80107140 <uartputc>
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
80100b81:	e8 ba 65 00 00       	call   80107140 <uartputc>
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
80100bc0:	e8 7b 65 00 00       	call   80107140 <uartputc>
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
80100bea:	e8 51 65 00 00       	call   80107140 <uartputc>
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
80100c25:	e8 16 65 00 00       	call   80107140 <uartputc>
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
80100d21:	bf 58 86 10 80       	mov    $0x80108658,%edi
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
80100d70:	e8 cb 63 00 00       	call   80107140 <uartputc>
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
80100da8:	e8 93 63 00 00       	call   80107140 <uartputc>
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
80100dd8:	e8 03 46 00 00       	call   801053e0 <acquire>
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
80100df7:	e8 84 45 00 00       	call   80105380 <release>
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
80100e0a:	68 5f 86 10 80       	push   $0x8010865f
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
80100eef:	e8 7c 46 00 00       	call   80105570 <memmove>
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
80100f83:	e8 58 44 00 00       	call   801053e0 <acquire>
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
80100fb5:	ff 24 85 b8 8b 10 80 	jmp    *-0x7fef7448(,%eax,4)
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
80101068:	e8 13 43 00 00       	call   80105380 <release>
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
801011ad:	e8 6e 3d 00 00       	call   80104f20 <wakeup>
801011b2:	83 c4 10             	add    $0x10,%esp
801011b5:	e9 d1 fd ff ff       	jmp    80100f8b <consoleintr+0x1b>
    uartputc('\b');
801011ba:	83 ec 0c             	sub    $0xc,%esp
801011bd:	6a 08                	push   $0x8
801011bf:	e8 7c 5f 00 00       	call   80107140 <uartputc>
    uartputc(' ');
801011c4:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801011cb:	e8 70 5f 00 00       	call   80107140 <uartputc>
    uartputc('\b');
801011d0:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801011d7:	e8 64 5f 00 00       	call   80107140 <uartputc>
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
8010128a:	e9 71 3d 00 00       	jmp    80105000 <procdump>
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
801012e6:	68 68 86 10 80       	push   $0x80108668
801012eb:	68 60 15 11 80       	push   $0x80111560
801012f0:	e8 fb 3e 00 00       	call   801051f0 <initlock>

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
80101319:	e8 52 1f 00 00       	call   80103270 <ioapicenable>
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
8010133c:	e8 4f 34 00 00       	call   80104790 <myproc>
80101341:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80101347:	e8 14 28 00 00       	call   80103b60 <begin_op>

  if((ip = namei(path)) == 0){
8010134c:	83 ec 0c             	sub    $0xc,%esp
8010134f:	ff 75 08             	push   0x8(%ebp)
80101352:	e8 39 1b 00 00       	call   80102e90 <namei>
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
80101368:	e8 43 12 00 00       	call   801025b0 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
8010136d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80101373:	6a 34                	push   $0x34
80101375:	6a 00                	push   $0x0
80101377:	50                   	push   %eax
80101378:	57                   	push   %edi
80101379:	e8 42 15 00 00       	call   801028c0 <readi>
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
8010139a:	e8 11 6f 00 00       	call   801082b0 <setupkvm>
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
8010140b:	e8 d0 6c 00 00       	call   801080e0 <allocuvm>
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
80101441:	e8 ca 6b 00 00       	call   80108010 <loaduvm>
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
80101469:	e8 52 14 00 00       	call   801028c0 <readi>
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
80101483:	e8 a8 6d 00 00       	call   80108230 <freevm>
  if(ip){
80101488:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010148b:	83 ec 0c             	sub    $0xc,%esp
8010148e:	57                   	push   %edi
8010148f:	e8 ac 13 00 00       	call   80102840 <iunlockput>
    end_op();
80101494:	e8 37 27 00 00       	call   80103bd0 <end_op>
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
801014cc:	e8 6f 13 00 00       	call   80102840 <iunlockput>
  end_op();
801014d1:	e8 fa 26 00 00       	call   80103bd0 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
801014d6:	83 c4 0c             	add    $0xc,%esp
801014d9:	53                   	push   %ebx
801014da:	56                   	push   %esi
801014db:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
801014e1:	56                   	push   %esi
801014e2:	e8 f9 6b 00 00       	call   801080e0 <allocuvm>
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
80101503:	e8 48 6e 00 00       	call   80108350 <clearpteu>
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
8010154a:	e8 81 41 00 00       	call   801056d0 <strlen>
8010154f:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80101551:	58                   	pop    %eax
80101552:	ff 34 b7             	push   (%edi,%esi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80101555:	83 eb 01             	sub    $0x1,%ebx
80101558:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
8010155b:	e8 70 41 00 00       	call   801056d0 <strlen>
80101560:	83 c0 01             	add    $0x1,%eax
80101563:	50                   	push   %eax
80101564:	ff 34 b7             	push   (%edi,%esi,4)
80101567:	53                   	push   %ebx
80101568:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
8010156e:	e8 ad 6f 00 00       	call   80108520 <copyout>
80101573:	83 c4 20             	add    $0x20,%esp
80101576:	85 c0                	test   %eax,%eax
80101578:	79 ae                	jns    80101528 <exec+0x1f8>
    freevm(pgdir);
8010157a:	83 ec 0c             	sub    $0xc,%esp
8010157d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101583:	e8 a8 6c 00 00       	call   80108230 <freevm>
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
801015df:	e8 3c 6f 00 00       	call   80108520 <copyout>
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
8010161f:	e8 6c 40 00 00       	call   80105690 <safestrcpy>
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
8010164b:	e8 30 68 00 00       	call   80107e80 <switchuvm>
  freevm(oldpgdir);
80101650:	89 34 24             	mov    %esi,(%esp)
80101653:	e8 d8 6b 00 00       	call   80108230 <freevm>
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
80101692:	e8 39 25 00 00       	call   80103bd0 <end_op>
    cprintf("exec: fail\n");
80101697:	83 ec 0c             	sub    $0xc,%esp
8010169a:	68 70 86 10 80       	push   $0x80108670
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
801016b6:	68 7c 86 10 80       	push   $0x8010867c
801016bb:	68 a0 16 11 80       	push   $0x801116a0
801016c0:	e8 2b 3b 00 00       	call   801051f0 <initlock>
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
801016e1:	e8 fa 3c 00 00       	call   801053e0 <acquire>
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
80101711:	e8 6a 3c 00 00       	call   80105380 <release>
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
8010172a:	e8 51 3c 00 00       	call   80105380 <release>
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
8010174f:	e8 8c 3c 00 00       	call   801053e0 <acquire>
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
8010176c:	e8 0f 3c 00 00       	call   80105380 <release>
  return f;
}
80101771:	89 d8                	mov    %ebx,%eax
80101773:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101776:	c9                   	leave
80101777:	c3                   	ret
    panic("filedup");
80101778:	83 ec 0c             	sub    $0xc,%esp
8010177b:	68 83 86 10 80       	push   $0x80108683
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
801017a1:	e8 3a 3c 00 00       	call   801053e0 <acquire>
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
801017dc:	e8 9f 3b 00 00       	call   80105380 <release>

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
8010180e:	e9 6d 3b 00 00       	jmp    80105380 <release>
80101813:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    begin_op();
80101818:	e8 43 23 00 00       	call   80103b60 <begin_op>
    iput(ff.ip);
8010181d:	83 ec 0c             	sub    $0xc,%esp
80101820:	ff 75 e0             	push   -0x20(%ebp)
80101823:	e8 b8 0e 00 00       	call   801026e0 <iput>
    end_op();
80101828:	83 c4 10             	add    $0x10,%esp
}
8010182b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010182e:	5b                   	pop    %ebx
8010182f:	5e                   	pop    %esi
80101830:	5f                   	pop    %edi
80101831:	5d                   	pop    %ebp
    end_op();
80101832:	e9 99 23 00 00       	jmp    80103bd0 <end_op>
80101837:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010183e:	00 
8010183f:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
80101840:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101844:	83 ec 08             	sub    $0x8,%esp
80101847:	53                   	push   %ebx
80101848:	56                   	push   %esi
80101849:	e8 d2 2a 00 00       	call   80104320 <pipeclose>
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
8010185c:	68 8b 86 10 80       	push   $0x8010868b
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
80101885:	e8 26 0d 00 00       	call   801025b0 <ilock>
    stati(f->ip, st);
8010188a:	58                   	pop    %eax
8010188b:	5a                   	pop    %edx
8010188c:	ff 75 0c             	push   0xc(%ebp)
8010188f:	ff 73 10             	push   0x10(%ebx)
80101892:	e8 f9 0f 00 00       	call   80102890 <stati>
    iunlock(f->ip);
80101897:	59                   	pop    %ecx
80101898:	ff 73 10             	push   0x10(%ebx)
8010189b:	e8 f0 0d 00 00       	call   80102690 <iunlock>
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
801018ea:	e8 c1 0c 00 00       	call   801025b0 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801018ef:	57                   	push   %edi
801018f0:	ff 73 14             	push   0x14(%ebx)
801018f3:	56                   	push   %esi
801018f4:	ff 73 10             	push   0x10(%ebx)
801018f7:	e8 c4 0f 00 00       	call   801028c0 <readi>
801018fc:	83 c4 20             	add    $0x20,%esp
801018ff:	89 c6                	mov    %eax,%esi
80101901:	85 c0                	test   %eax,%eax
80101903:	7e 03                	jle    80101908 <fileread+0x48>
      f->off += r;
80101905:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101908:	83 ec 0c             	sub    $0xc,%esp
8010190b:	ff 73 10             	push   0x10(%ebx)
8010190e:	e8 7d 0d 00 00       	call   80102690 <iunlock>
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
8010192d:	e9 ae 2b 00 00       	jmp    801044e0 <piperead>
80101932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101938:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010193d:	eb d7                	jmp    80101916 <fileread+0x56>
  panic("fileread");
8010193f:	83 ec 0c             	sub    $0xc,%esp
80101942:	68 95 86 10 80       	push   $0x80108695
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
801019a4:	e8 e7 0c 00 00       	call   80102690 <iunlock>
      end_op();
801019a9:	e8 22 22 00 00       	call   80103bd0 <end_op>

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
801019ce:	e8 8d 21 00 00       	call   80103b60 <begin_op>
      ilock(f->ip);
801019d3:	83 ec 0c             	sub    $0xc,%esp
801019d6:	ff 73 10             	push   0x10(%ebx)
801019d9:	e8 d2 0b 00 00       	call   801025b0 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801019de:	57                   	push   %edi
801019df:	ff 73 14             	push   0x14(%ebx)
801019e2:	8b 45 dc             	mov    -0x24(%ebp),%eax
801019e5:	01 f0                	add    %esi,%eax
801019e7:	50                   	push   %eax
801019e8:	ff 73 10             	push   0x10(%ebx)
801019eb:	e8 d0 0f 00 00       	call   801029c0 <writei>
801019f0:	83 c4 20             	add    $0x20,%esp
801019f3:	85 c0                	test   %eax,%eax
801019f5:	7f a1                	jg     80101998 <filewrite+0x48>
801019f7:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801019fa:	83 ec 0c             	sub    $0xc,%esp
801019fd:	ff 73 10             	push   0x10(%ebx)
80101a00:	e8 8b 0c 00 00       	call   80102690 <iunlock>
      end_op();
80101a05:	e8 c6 21 00 00       	call   80103bd0 <end_op>
      if(r < 0)
80101a0a:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101a0d:	83 c4 10             	add    $0x10,%esp
80101a10:	85 c0                	test   %eax,%eax
80101a12:	75 14                	jne    80101a28 <filewrite+0xd8>
        panic("short filewrite");
80101a14:	83 ec 0c             	sub    $0xc,%esp
80101a17:	68 9e 86 10 80       	push   $0x8010869e
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
80101a49:	e9 72 29 00 00       	jmp    801043c0 <pipewrite>
  panic("filewrite");
80101a4e:	83 ec 0c             	sub    $0xc,%esp
80101a51:	68 a4 86 10 80       	push   $0x801086a4
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
80101a66:	68 ae 86 10 80       	push   $0x801086ae
80101a6b:	68 a0 20 11 80       	push   $0x801120a0
80101a70:	e8 7b 37 00 00       	call   801051f0 <initlock>
  
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
80101ae1:	e8 fa 38 00 00       	call   801053e0 <acquire>
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
  if(find_user(user_id) >= 0) {
    release(&user_lock);
    return -1;
  }

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
80101b2e:	e8 4d 38 00 00       	call   80105380 <release>
    return -1;
80101b33:	83 c4 10             	add    $0x10,%esp
80101b36:	eb 58                	jmp    80101b90 <make_user+0xc0>
80101b38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101b3f:	00 
  if(i == MAX_USERS) {
    release(&user_lock);
    return -1;
  }
  
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
80101b63:	e8 c8 3a 00 00       	call   80105630 <strncpy>
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
80101b88:	e8 f3 37 00 00       	call   80105380 <release>
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
80101bac:	e8 df 2b 00 00       	call   80104790 <myproc>
  int user_index;
  
  acquire(&user_lock);
80101bb1:	83 ec 0c             	sub    $0xc,%esp
80101bb4:	68 a0 20 11 80       	push   $0x801120a0
  struct proc *p = myproc();
80101bb9:	89 c3                	mov    %eax,%ebx
  acquire(&user_lock);
80101bbb:	e8 20 38 00 00       	call   801053e0 <acquire>
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
  
  user_index = find_user(user_id);
  if(user_index < 0) {
    release(&user_lock);
80101be6:	83 ec 0c             	sub    $0xc,%esp
    return -1;
80101be9:	bf ff ff ff ff       	mov    $0xffffffff,%edi
    release(&user_lock);
80101bee:	68 a0 20 11 80       	push   $0x801120a0
80101bf3:	e8 88 37 00 00       	call   80105380 <release>
    return -1;
80101bf8:	83 c4 10             	add    $0x10,%esp
80101bfb:	eb 3d                	jmp    80101c3a <login_user+0x9a>
80101bfd:	8d 76 00             	lea    0x0(%esi),%esi
  }

  if(strncmp(users[user_index].password, password, MAX_PASSWORD_LEN) != 0) {
80101c00:	8d 04 92             	lea    (%edx,%edx,4),%eax
80101c03:	83 ec 04             	sub    $0x4,%esp
80101c06:	8d 04 c5 04 3b 11 80 	lea    -0x7feec4fc(,%eax,8),%eax
80101c0d:	6a 20                	push   $0x20
80101c0f:	ff 75 0c             	push   0xc(%ebp)
80101c12:	50                   	push   %eax
80101c13:	e8 c8 39 00 00       	call   801055e0 <strncmp>
80101c18:	83 c4 10             	add    $0x10,%esp
80101c1b:	89 c7                	mov    %eax,%edi
80101c1d:	85 c0                	test   %eax,%eax
80101c1f:	75 c5                	jne    80101be6 <login_user+0x46>
    release(&user_lock);
    return -1;
  }
  
  if(p->logged_in_user != -1) {
80101c21:	83 7b 7c ff          	cmpl   $0xffffffff,0x7c(%ebx)
80101c25:	75 bf                	jne    80101be6 <login_user+0x46>
    return -1;
  }

  p->logged_in_user = user_id;
  
  release(&user_lock);
80101c27:	83 ec 0c             	sub    $0xc,%esp
  p->logged_in_user = user_id;
80101c2a:	89 73 7c             	mov    %esi,0x7c(%ebx)
  release(&user_lock);
80101c2d:	68 a0 20 11 80       	push   $0x801120a0
80101c32:	e8 49 37 00 00       	call   80105380 <release>
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

int
logout_user(void)
{
80101c50:	55                   	push   %ebp
80101c51:	89 e5                	mov    %esp,%ebp
80101c53:	56                   	push   %esi
80101c54:	53                   	push   %ebx
  struct proc *p = myproc();
80101c55:	e8 36 2b 00 00       	call   80104790 <myproc>
  
  acquire(&user_lock);
80101c5a:	83 ec 0c             	sub    $0xc,%esp
80101c5d:	68 a0 20 11 80       	push   $0x801120a0
  struct proc *p = myproc();
80101c62:	89 c6                	mov    %eax,%esi
  acquire(&user_lock);
80101c64:	e8 77 37 00 00       	call   801053e0 <acquire>
  
  // Check if a user is logged in
  if(p->logged_in_user == -1) {
80101c69:	8b 5e 7c             	mov    0x7c(%esi),%ebx
80101c6c:	83 c4 10             	add    $0x10,%esp
80101c6f:	83 fb ff             	cmp    $0xffffffff,%ebx
80101c72:	0f 84 8c 00 00 00    	je     80101d04 <logout_user+0xb4>
80101c78:	b8 00 3b 11 80       	mov    $0x80113b00,%eax
  for(int i = 0; i < MAX_USERS; i++) {
80101c7d:	31 c9                	xor    %ecx,%ecx
80101c7f:	90                   	nop
    if(users[i].valid && users[i].user_id == user_id)
80101c80:	8b 50 24             	mov    0x24(%eax),%edx
80101c83:	85 d2                	test   %edx,%edx
80101c85:	74 04                	je     80101c8b <logout_user+0x3b>
80101c87:	3b 18                	cmp    (%eax),%ebx
80101c89:	74 35                	je     80101cc0 <logout_user+0x70>
  for(int i = 0; i < MAX_USERS; i++) {
80101c8b:	83 c1 01             	add    $0x1,%ecx
80101c8e:	83 c0 28             	add    $0x28,%eax
80101c91:	83 f9 10             	cmp    $0x10,%ecx
80101c94:	75 ea                	jne    80101c80 <logout_user+0x30>
    log_indices[user_index] = (log_indices[user_index] + 1) % MAX_LOG_ENTRIES;
  }
  
  p->logged_in_user = -1;
  
  release(&user_lock);
80101c96:	83 ec 0c             	sub    $0xc,%esp
  p->logged_in_user = -1;
80101c99:	c7 46 7c ff ff ff ff 	movl   $0xffffffff,0x7c(%esi)
  return 0;
80101ca0:	31 db                	xor    %ebx,%ebx
  release(&user_lock);
80101ca2:	68 a0 20 11 80       	push   $0x801120a0
80101ca7:	e8 d4 36 00 00       	call   80105380 <release>
  return 0;
80101cac:	83 c4 10             	add    $0x10,%esp
}
80101caf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101cb2:	89 d8                	mov    %ebx,%eax
80101cb4:	5b                   	pop    %ebx
80101cb5:	5e                   	pop    %esi
80101cb6:	5d                   	pop    %ebp
80101cb7:	c3                   	ret
80101cb8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101cbf:	00 
    syscall_logs[user_index][log_indices[user_index]].syscall_num = SYS_logout;
80101cc0:	6b c1 32             	imul   $0x32,%ecx,%eax
80101cc3:	8b 1c 8d c0 21 11 80 	mov    -0x7feede40(,%ecx,4),%ebx
80101cca:	01 d8                	add    %ebx,%eax
    log_indices[user_index] = (log_indices[user_index] + 1) % MAX_LOG_ENTRIES;
80101ccc:	83 c3 01             	add    $0x1,%ebx
    syscall_logs[user_index][log_indices[user_index]].syscall_num = SYS_logout;
80101ccf:	c7 04 c5 00 22 11 80 	movl   $0x18,-0x7feede00(,%eax,8)
80101cd6:	18 00 00 00 
    syscall_logs[user_index][log_indices[user_index]].pid = 1;
80101cda:	c7 04 c5 04 22 11 80 	movl   $0x1,-0x7feeddfc(,%eax,8)
80101ce1:	01 00 00 00 
    log_indices[user_index] = (log_indices[user_index] + 1) % MAX_LOG_ENTRIES;
80101ce5:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
80101cea:	f7 eb                	imul   %ebx
80101cec:	89 d8                	mov    %ebx,%eax
80101cee:	c1 f8 1f             	sar    $0x1f,%eax
80101cf1:	c1 fa 04             	sar    $0x4,%edx
80101cf4:	29 c2                	sub    %eax,%edx
80101cf6:	6b c2 32             	imul   $0x32,%edx,%eax
80101cf9:	29 c3                	sub    %eax,%ebx
80101cfb:	89 1c 8d c0 21 11 80 	mov    %ebx,-0x7feede40(,%ecx,4)
80101d02:	eb 92                	jmp    80101c96 <logout_user+0x46>
    release(&user_lock);
80101d04:	83 ec 0c             	sub    $0xc,%esp
80101d07:	68 a0 20 11 80       	push   $0x801120a0
80101d0c:	e8 6f 36 00 00       	call   80105380 <release>
    return -1;
80101d11:	83 c4 10             	add    $0x10,%esp
80101d14:	eb 99                	jmp    80101caf <logout_user+0x5f>
80101d16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101d1d:	00 
80101d1e:	66 90                	xchg   %ax,%ax

80101d20 <log_syscall>:

void
log_syscall(int num)
{
80101d20:	55                   	push   %ebp
80101d21:	89 e5                	mov    %esp,%ebp
80101d23:	56                   	push   %esi
80101d24:	53                   	push   %ebx
80101d25:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p = myproc();
80101d28:	e8 63 2a 00 00       	call   80104790 <myproc>
  int user_index;
  
  acquire(&user_lock);
80101d2d:	83 ec 0c             	sub    $0xc,%esp
80101d30:	68 a0 20 11 80       	push   $0x801120a0
  struct proc *p = myproc();
80101d35:	89 c6                	mov    %eax,%esi
  acquire(&user_lock);
80101d37:	e8 a4 36 00 00       	call   801053e0 <acquire>
  
  if(p->logged_in_user != -1) {
80101d3c:	8b 56 7c             	mov    0x7c(%esi),%edx
80101d3f:	83 c4 10             	add    $0x10,%esp
80101d42:	83 fa ff             	cmp    $0xffffffff,%edx
80101d45:	74 1f                	je     80101d66 <log_syscall+0x46>
80101d47:	b8 00 3b 11 80       	mov    $0x80113b00,%eax
  for(int i = 0; i < MAX_USERS; i++) {
80101d4c:	31 c9                	xor    %ecx,%ecx
80101d4e:	66 90                	xchg   %ax,%ax
    if(users[i].valid && users[i].user_id == user_id)
80101d50:	8b 70 24             	mov    0x24(%eax),%esi
80101d53:	85 f6                	test   %esi,%esi
80101d55:	74 04                	je     80101d5b <log_syscall+0x3b>
80101d57:	3b 10                	cmp    (%eax),%edx
80101d59:	74 4d                	je     80101da8 <log_syscall+0x88>
  for(int i = 0; i < MAX_USERS; i++) {
80101d5b:	83 c1 01             	add    $0x1,%ecx
80101d5e:	83 c0 28             	add    $0x28,%eax
80101d61:	83 f9 10             	cmp    $0x10,%ecx
80101d64:	75 ea                	jne    80101d50 <log_syscall+0x30>
      syscall_logs[user_index][log_indices[user_index]].pid = 1;
      log_indices[user_index] = (log_indices[user_index] + 1) % MAX_LOG_ENTRIES;
    }
  }

  global_log[global_log_index] = num;
80101d66:	8b 0d d4 20 11 80    	mov    0x801120d4,%ecx
  global_log_index = (global_log_index + 1) % MAX_LOG_ENTRIES;
80101d6c:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
  
  release(&user_lock);
80101d71:	c7 45 08 a0 20 11 80 	movl   $0x801120a0,0x8(%ebp)
  global_log[global_log_index] = num;
80101d78:	89 1c 8d e0 20 11 80 	mov    %ebx,-0x7feedf20(,%ecx,4)
  global_log_index = (global_log_index + 1) % MAX_LOG_ENTRIES;
80101d7f:	83 c1 01             	add    $0x1,%ecx
80101d82:	f7 e9                	imul   %ecx
80101d84:	89 c8                	mov    %ecx,%eax
80101d86:	c1 f8 1f             	sar    $0x1f,%eax
80101d89:	c1 fa 04             	sar    $0x4,%edx
80101d8c:	29 c2                	sub    %eax,%edx
80101d8e:	6b d2 32             	imul   $0x32,%edx,%edx
80101d91:	29 d1                	sub    %edx,%ecx
80101d93:	89 0d d4 20 11 80    	mov    %ecx,0x801120d4
}
80101d99:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101d9c:	5b                   	pop    %ebx
80101d9d:	5e                   	pop    %esi
80101d9e:	5d                   	pop    %ebp
  release(&user_lock);
80101d9f:	e9 dc 35 00 00       	jmp    80105380 <release>
80101da4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      syscall_logs[user_index][log_indices[user_index]].syscall_num = num;
80101da8:	6b c1 32             	imul   $0x32,%ecx,%eax
80101dab:	8b 34 8d c0 21 11 80 	mov    -0x7feede40(,%ecx,4),%esi
80101db2:	01 f0                	add    %esi,%eax
      log_indices[user_index] = (log_indices[user_index] + 1) % MAX_LOG_ENTRIES;
80101db4:	83 c6 01             	add    $0x1,%esi
      syscall_logs[user_index][log_indices[user_index]].syscall_num = num;
80101db7:	89 1c c5 00 22 11 80 	mov    %ebx,-0x7feede00(,%eax,8)
      syscall_logs[user_index][log_indices[user_index]].pid = 1;
80101dbe:	c7 04 c5 04 22 11 80 	movl   $0x1,-0x7feeddfc(,%eax,8)
80101dc5:	01 00 00 00 
      log_indices[user_index] = (log_indices[user_index] + 1) % MAX_LOG_ENTRIES;
80101dc9:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
80101dce:	f7 ee                	imul   %esi
80101dd0:	89 f0                	mov    %esi,%eax
80101dd2:	c1 f8 1f             	sar    $0x1f,%eax
80101dd5:	c1 fa 04             	sar    $0x4,%edx
80101dd8:	29 c2                	sub    %eax,%edx
80101dda:	6b c2 32             	imul   $0x32,%edx,%eax
80101ddd:	29 c6                	sub    %eax,%esi
80101ddf:	89 34 8d c0 21 11 80 	mov    %esi,-0x7feede40(,%ecx,4)
80101de6:	e9 7b ff ff ff       	jmp    80101d66 <log_syscall+0x46>
80101deb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101df0 <get_log>:

int
get_log(void)
{
80101df0:	55                   	push   %ebp
80101df1:	89 e5                	mov    %esp,%ebp
80101df3:	57                   	push   %edi
80101df4:	56                   	push   %esi
80101df5:	53                   	push   %ebx
80101df6:	83 ec 0c             	sub    $0xc,%esp
  struct proc *p = myproc();
80101df9:	e8 92 29 00 00       	call   80104790 <myproc>
  int user_index;
  int i;
  
  acquire(&user_lock);
80101dfe:	83 ec 0c             	sub    $0xc,%esp
80101e01:	68 a0 20 11 80       	push   $0x801120a0
  struct proc *p = myproc();
80101e06:	89 c3                	mov    %eax,%ebx
  acquire(&user_lock);
80101e08:	e8 d3 35 00 00       	call   801053e0 <acquire>
  
  if(p->logged_in_user != -1) {
80101e0d:	8b 53 7c             	mov    0x7c(%ebx),%edx
80101e10:	83 c4 10             	add    $0x10,%esp
80101e13:	83 fa ff             	cmp    $0xffffffff,%edx
80101e16:	0f 84 a4 00 00 00    	je     80101ec0 <get_log+0xd0>
80101e1c:	b8 00 3b 11 80       	mov    $0x80113b00,%eax
  for(int i = 0; i < MAX_USERS; i++) {
80101e21:	31 ff                	xor    %edi,%edi
80101e23:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(users[i].valid && users[i].user_id == user_id)
80101e28:	8b 48 24             	mov    0x24(%eax),%ecx
80101e2b:	85 c9                	test   %ecx,%ecx
80101e2d:	74 04                	je     80101e33 <get_log+0x43>
80101e2f:	3b 10                	cmp    (%eax),%edx
80101e31:	74 25                	je     80101e58 <get_log+0x68>
  for(int i = 0; i < MAX_USERS; i++) {
80101e33:	83 c7 01             	add    $0x1,%edi
80101e36:	83 c0 28             	add    $0x28,%eax
80101e39:	83 ff 10             	cmp    $0x10,%edi
80101e3c:	75 ea                	jne    80101e28 <get_log+0x38>
        cprintf("SysCall: %d\n", global_log[idx]);
      }
    }
  }
  
  release(&user_lock);
80101e3e:	83 ec 0c             	sub    $0xc,%esp
80101e41:	68 a0 20 11 80       	push   $0x801120a0
80101e46:	e8 35 35 00 00       	call   80105380 <release>
  return 0;
}
80101e4b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e4e:	31 c0                	xor    %eax,%eax
80101e50:	5b                   	pop    %ebx
80101e51:	5e                   	pop    %esi
80101e52:	5f                   	pop    %edi
80101e53:	5d                   	pop    %ebp
80101e54:	c3                   	ret
80101e55:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("System call log for user %d:\n", p->logged_in_user);
80101e58:	83 ec 08             	sub    $0x8,%esp
        if(syscall_logs[user_index][idx].syscall_num != 0) {
80101e5b:	6b f7 32             	imul   $0x32,%edi,%esi
      for(i = 0; i < MAX_LOG_ENTRIES; i++) {
80101e5e:	31 db                	xor    %ebx,%ebx
      cprintf("System call log for user %d:\n", p->logged_in_user);
80101e60:	52                   	push   %edx
80101e61:	68 d9 86 10 80       	push   $0x801086d9
80101e66:	e8 d5 ed ff ff       	call   80100c40 <cprintf>
80101e6b:	83 c4 10             	add    $0x10,%esp
80101e6e:	eb 08                	jmp    80101e78 <get_log+0x88>
      for(i = 0; i < MAX_LOG_ENTRIES; i++) {
80101e70:	83 c3 01             	add    $0x1,%ebx
80101e73:	83 fb 32             	cmp    $0x32,%ebx
80101e76:	74 c6                	je     80101e3e <get_log+0x4e>
        int idx = (log_indices[user_index] - i - 1 + MAX_LOG_ENTRIES) % MAX_LOG_ENTRIES;
80101e78:	8b 0c bd c0 21 11 80 	mov    -0x7feede40(,%edi,4),%ecx
80101e7f:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
80101e84:	29 d9                	sub    %ebx,%ecx
80101e86:	83 c1 31             	add    $0x31,%ecx
80101e89:	f7 e9                	imul   %ecx
80101e8b:	89 c8                	mov    %ecx,%eax
80101e8d:	c1 f8 1f             	sar    $0x1f,%eax
80101e90:	c1 fa 04             	sar    $0x4,%edx
80101e93:	29 c2                	sub    %eax,%edx
80101e95:	6b d2 32             	imul   $0x32,%edx,%edx
80101e98:	29 d1                	sub    %edx,%ecx
        if(syscall_logs[user_index][idx].syscall_num != 0) {
80101e9a:	01 f1                	add    %esi,%ecx
80101e9c:	8b 04 cd 00 22 11 80 	mov    -0x7feede00(,%ecx,8),%eax
80101ea3:	85 c0                	test   %eax,%eax
80101ea5:	74 c9                	je     80101e70 <get_log+0x80>
          cprintf("SysCall: %d\n", syscall_logs[user_index][idx].syscall_num);
80101ea7:	83 ec 08             	sub    $0x8,%esp
80101eaa:	50                   	push   %eax
80101eab:	68 b3 86 10 80       	push   $0x801086b3
80101eb0:	e8 8b ed ff ff       	call   80100c40 <cprintf>
80101eb5:	83 c4 10             	add    $0x10,%esp
80101eb8:	eb b6                	jmp    80101e70 <get_log+0x80>
80101eba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("Global system call log:\n");
80101ec0:	83 ec 0c             	sub    $0xc,%esp
    for(i = 0; i < MAX_LOG_ENTRIES; i++) {
80101ec3:	31 db                	xor    %ebx,%ebx
      int idx = (global_log_index - i - 1 + MAX_LOG_ENTRIES) % MAX_LOG_ENTRIES;
80101ec5:	be 1f 85 eb 51       	mov    $0x51eb851f,%esi
    cprintf("Global system call log:\n");
80101eca:	68 c0 86 10 80       	push   $0x801086c0
80101ecf:	e8 6c ed ff ff       	call   80100c40 <cprintf>
80101ed4:	83 c4 10             	add    $0x10,%esp
80101ed7:	eb 13                	jmp    80101eec <get_log+0xfc>
80101ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(i = 0; i < MAX_LOG_ENTRIES; i++) {
80101ee0:	83 c3 01             	add    $0x1,%ebx
80101ee3:	83 fb 32             	cmp    $0x32,%ebx
80101ee6:	0f 84 52 ff ff ff    	je     80101e3e <get_log+0x4e>
      int idx = (global_log_index - i - 1 + MAX_LOG_ENTRIES) % MAX_LOG_ENTRIES;
80101eec:	8b 0d d4 20 11 80    	mov    0x801120d4,%ecx
80101ef2:	29 d9                	sub    %ebx,%ecx
80101ef4:	83 c1 31             	add    $0x31,%ecx
80101ef7:	89 c8                	mov    %ecx,%eax
80101ef9:	f7 ee                	imul   %esi
80101efb:	89 c8                	mov    %ecx,%eax
80101efd:	c1 f8 1f             	sar    $0x1f,%eax
80101f00:	c1 fa 04             	sar    $0x4,%edx
80101f03:	29 c2                	sub    %eax,%edx
80101f05:	6b d2 32             	imul   $0x32,%edx,%edx
80101f08:	29 d1                	sub    %edx,%ecx
      if(global_log[idx] != 0) {
80101f0a:	8b 04 8d e0 20 11 80 	mov    -0x7feedf20(,%ecx,4),%eax
80101f11:	85 c0                	test   %eax,%eax
80101f13:	74 cb                	je     80101ee0 <get_log+0xf0>
        cprintf("SysCall: %d\n", global_log[idx]);
80101f15:	83 ec 08             	sub    $0x8,%esp
80101f18:	50                   	push   %eax
80101f19:	68 b3 86 10 80       	push   $0x801086b3
80101f1e:	e8 1d ed ff ff       	call   80100c40 <cprintf>
80101f23:	83 c4 10             	add    $0x10,%esp
80101f26:	eb b8                	jmp    80101ee0 <get_log+0xf0>
80101f28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101f2f:	00 

80101f30 <sys_make_user>:


int
sys_make_user(void)
{
80101f30:	55                   	push   %ebp
80101f31:	89 e5                	mov    %esp,%ebp
80101f33:	83 ec 20             	sub    $0x20,%esp
  int user_id;
  char *password;

  if(argint(0, &user_id) < 0)
80101f36:	8d 45 f0             	lea    -0x10(%ebp),%eax
80101f39:	50                   	push   %eax
80101f3a:	6a 00                	push   $0x0
80101f3c:	e8 4f 38 00 00       	call   80105790 <argint>
80101f41:	83 c4 10             	add    $0x10,%esp
80101f44:	85 c0                	test   %eax,%eax
80101f46:	78 28                	js     80101f70 <sys_make_user+0x40>
    return -1;
  if(argstr(1, &password) < 0)
80101f48:	83 ec 08             	sub    $0x8,%esp
80101f4b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80101f4e:	50                   	push   %eax
80101f4f:	6a 01                	push   $0x1
80101f51:	e8 fa 38 00 00       	call   80105850 <argstr>
80101f56:	83 c4 10             	add    $0x10,%esp
80101f59:	85 c0                	test   %eax,%eax
80101f5b:	78 13                	js     80101f70 <sys_make_user+0x40>
    return -1;
  
  return make_user(user_id, password);
80101f5d:	83 ec 08             	sub    $0x8,%esp
80101f60:	ff 75 f4             	push   -0xc(%ebp)
80101f63:	ff 75 f0             	push   -0x10(%ebp)
80101f66:	e8 65 fb ff ff       	call   80101ad0 <make_user>
80101f6b:	83 c4 10             	add    $0x10,%esp
}
80101f6e:	c9                   	leave
80101f6f:	c3                   	ret
80101f70:	c9                   	leave
    return -1;
80101f71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101f76:	c3                   	ret
80101f77:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101f7e:	00 
80101f7f:	90                   	nop

80101f80 <sys_login>:

int
sys_login(void)
{
80101f80:	55                   	push   %ebp
80101f81:	89 e5                	mov    %esp,%ebp
80101f83:	83 ec 20             	sub    $0x20,%esp
  int user_id;
  char *password;

  if(argint(0, &user_id) < 0)
80101f86:	8d 45 f0             	lea    -0x10(%ebp),%eax
80101f89:	50                   	push   %eax
80101f8a:	6a 00                	push   $0x0
80101f8c:	e8 ff 37 00 00       	call   80105790 <argint>
80101f91:	83 c4 10             	add    $0x10,%esp
80101f94:	85 c0                	test   %eax,%eax
80101f96:	78 28                	js     80101fc0 <sys_login+0x40>
    return -1;
  if(argstr(1, &password) < 0)
80101f98:	83 ec 08             	sub    $0x8,%esp
80101f9b:	8d 45 f4             	lea    -0xc(%ebp),%eax
80101f9e:	50                   	push   %eax
80101f9f:	6a 01                	push   $0x1
80101fa1:	e8 aa 38 00 00       	call   80105850 <argstr>
80101fa6:	83 c4 10             	add    $0x10,%esp
80101fa9:	85 c0                	test   %eax,%eax
80101fab:	78 13                	js     80101fc0 <sys_login+0x40>
    return -1;
  
  return login_user(user_id, password);
80101fad:	83 ec 08             	sub    $0x8,%esp
80101fb0:	ff 75 f4             	push   -0xc(%ebp)
80101fb3:	ff 75 f0             	push   -0x10(%ebp)
80101fb6:	e8 e5 fb ff ff       	call   80101ba0 <login_user>
80101fbb:	83 c4 10             	add    $0x10,%esp
}
80101fbe:	c9                   	leave
80101fbf:	c3                   	ret
80101fc0:	c9                   	leave
    return -1;
80101fc1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101fc6:	c3                   	ret
80101fc7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101fce:	00 
80101fcf:	90                   	nop

80101fd0 <sys_logout>:

int
sys_logout(void)
{
  return logout_user();
80101fd0:	e9 7b fc ff ff       	jmp    80101c50 <logout_user>
80101fd5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101fdc:	00 
80101fdd:	8d 76 00             	lea    0x0(%esi),%esi

80101fe0 <sys_get_log>:
}

int
sys_get_log(void)
{
  return get_log();
80101fe0:	e9 0b fe ff ff       	jmp    80101df0 <get_log>
80101fe5:	66 90                	xchg   %ax,%ax
80101fe7:	66 90                	xchg   %ax,%ax
80101fe9:	66 90                	xchg   %ax,%ax
80101feb:	66 90                	xchg   %ax,%ax
80101fed:	66 90                	xchg   %ax,%ax
80101fef:	90                   	nop

80101ff0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101ff0:	55                   	push   %ebp
80101ff1:	89 e5                	mov    %esp,%ebp
80101ff3:	57                   	push   %edi
80101ff4:	56                   	push   %esi
80101ff5:	53                   	push   %ebx
80101ff6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101ff9:	8b 0d d4 59 11 80    	mov    0x801159d4,%ecx
{
80101fff:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80102002:	85 c9                	test   %ecx,%ecx
80102004:	0f 84 8c 00 00 00    	je     80102096 <balloc+0xa6>
8010200a:	31 ff                	xor    %edi,%edi
    bp = bread(dev, BBLOCK(b, sb));
8010200c:	89 f8                	mov    %edi,%eax
8010200e:	83 ec 08             	sub    $0x8,%esp
80102011:	89 fe                	mov    %edi,%esi
80102013:	c1 f8 0c             	sar    $0xc,%eax
80102016:	03 05 ec 59 11 80    	add    0x801159ec,%eax
8010201c:	50                   	push   %eax
8010201d:	ff 75 dc             	push   -0x24(%ebp)
80102020:	e8 ab e0 ff ff       	call   801000d0 <bread>
80102025:	83 c4 10             	add    $0x10,%esp
80102028:	89 7d d8             	mov    %edi,-0x28(%ebp)
8010202b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010202e:	a1 d4 59 11 80       	mov    0x801159d4,%eax
80102033:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102036:	31 c0                	xor    %eax,%eax
80102038:	eb 32                	jmp    8010206c <balloc+0x7c>
8010203a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80102040:	89 c1                	mov    %eax,%ecx
80102042:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80102047:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      m = 1 << (bi % 8);
8010204a:	83 e1 07             	and    $0x7,%ecx
8010204d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010204f:	89 c1                	mov    %eax,%ecx
80102051:	c1 f9 03             	sar    $0x3,%ecx
80102054:	0f b6 7c 0f 5c       	movzbl 0x5c(%edi,%ecx,1),%edi
80102059:	89 fa                	mov    %edi,%edx
8010205b:	85 df                	test   %ebx,%edi
8010205d:	74 49                	je     801020a8 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010205f:	83 c0 01             	add    $0x1,%eax
80102062:	83 c6 01             	add    $0x1,%esi
80102065:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010206a:	74 07                	je     80102073 <balloc+0x83>
8010206c:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010206f:	39 d6                	cmp    %edx,%esi
80102071:	72 cd                	jb     80102040 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80102073:	8b 7d d8             	mov    -0x28(%ebp),%edi
80102076:	83 ec 0c             	sub    $0xc,%esp
80102079:	ff 75 e4             	push   -0x1c(%ebp)
  for(b = 0; b < sb.size; b += BPB){
8010207c:	81 c7 00 10 00 00    	add    $0x1000,%edi
    brelse(bp);
80102082:	e8 69 e1 ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
80102087:	83 c4 10             	add    $0x10,%esp
8010208a:	3b 3d d4 59 11 80    	cmp    0x801159d4,%edi
80102090:	0f 82 76 ff ff ff    	jb     8010200c <balloc+0x1c>
  }
  panic("balloc: out of blocks");
80102096:	83 ec 0c             	sub    $0xc,%esp
80102099:	68 f7 86 10 80       	push   $0x801086f7
8010209e:	e8 fd e2 ff ff       	call   801003a0 <panic>
801020a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
801020a8:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801020ab:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801020ae:	09 da                	or     %ebx,%edx
801020b0:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801020b4:	57                   	push   %edi
801020b5:	e8 86 1c 00 00       	call   80103d40 <log_write>
        brelse(bp);
801020ba:	89 3c 24             	mov    %edi,(%esp)
801020bd:	e8 2e e1 ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
801020c2:	58                   	pop    %eax
801020c3:	5a                   	pop    %edx
801020c4:	56                   	push   %esi
801020c5:	ff 75 dc             	push   -0x24(%ebp)
801020c8:	e8 03 e0 ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
801020cd:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
801020d0:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801020d2:	8d 40 5c             	lea    0x5c(%eax),%eax
801020d5:	68 00 02 00 00       	push   $0x200
801020da:	6a 00                	push   $0x0
801020dc:	50                   	push   %eax
801020dd:	e8 fe 33 00 00       	call   801054e0 <memset>
  log_write(bp);
801020e2:	89 1c 24             	mov    %ebx,(%esp)
801020e5:	e8 56 1c 00 00       	call   80103d40 <log_write>
  brelse(bp);
801020ea:	89 1c 24             	mov    %ebx,(%esp)
801020ed:	e8 fe e0 ff ff       	call   801001f0 <brelse>
}
801020f2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020f5:	89 f0                	mov    %esi,%eax
801020f7:	5b                   	pop    %ebx
801020f8:	5e                   	pop    %esi
801020f9:	5f                   	pop    %edi
801020fa:	5d                   	pop    %ebp
801020fb:	c3                   	ret
801020fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102100 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80102100:	55                   	push   %ebp
80102101:	89 e5                	mov    %esp,%ebp
80102103:	57                   	push   %edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80102104:	31 ff                	xor    %edi,%edi
{
80102106:	56                   	push   %esi
80102107:	89 c6                	mov    %eax,%esi
80102109:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010210a:	bb b4 3d 11 80       	mov    $0x80113db4,%ebx
{
8010210f:	83 ec 28             	sub    $0x28,%esp
80102112:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80102115:	68 80 3d 11 80       	push   $0x80113d80
8010211a:	e8 c1 32 00 00       	call   801053e0 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010211f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80102122:	83 c4 10             	add    $0x10,%esp
80102125:	eb 1b                	jmp    80102142 <iget+0x42>
80102127:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010212e:	00 
8010212f:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80102130:	39 33                	cmp    %esi,(%ebx)
80102132:	74 6c                	je     801021a0 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80102134:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010213a:	81 fb d4 59 11 80    	cmp    $0x801159d4,%ebx
80102140:	74 26                	je     80102168 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80102142:	8b 43 08             	mov    0x8(%ebx),%eax
80102145:	85 c0                	test   %eax,%eax
80102147:	7f e7                	jg     80102130 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80102149:	85 ff                	test   %edi,%edi
8010214b:	75 e7                	jne    80102134 <iget+0x34>
8010214d:	85 c0                	test   %eax,%eax
8010214f:	75 76                	jne    801021c7 <iget+0xc7>
      empty = ip;
80102151:	89 df                	mov    %ebx,%edi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80102153:	81 c3 90 00 00 00    	add    $0x90,%ebx
80102159:	81 fb d4 59 11 80    	cmp    $0x801159d4,%ebx
8010215f:	75 e1                	jne    80102142 <iget+0x42>
80102161:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80102168:	85 ff                	test   %edi,%edi
8010216a:	74 79                	je     801021e5 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010216c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010216f:	89 37                	mov    %esi,(%edi)
  ip->inum = inum;
80102171:	89 57 04             	mov    %edx,0x4(%edi)
  ip->ref = 1;
80102174:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
  ip->valid = 0;
8010217b:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
  release(&icache.lock);
80102182:	68 80 3d 11 80       	push   $0x80113d80
80102187:	e8 f4 31 00 00       	call   80105380 <release>

  return ip;
8010218c:	83 c4 10             	add    $0x10,%esp
}
8010218f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102192:	89 f8                	mov    %edi,%eax
80102194:	5b                   	pop    %ebx
80102195:	5e                   	pop    %esi
80102196:	5f                   	pop    %edi
80102197:	5d                   	pop    %ebp
80102198:	c3                   	ret
80102199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801021a0:	39 53 04             	cmp    %edx,0x4(%ebx)
801021a3:	75 8f                	jne    80102134 <iget+0x34>
      ip->ref++;
801021a5:	83 c0 01             	add    $0x1,%eax
      release(&icache.lock);
801021a8:	83 ec 0c             	sub    $0xc,%esp
      return ip;
801021ab:	89 df                	mov    %ebx,%edi
      ip->ref++;
801021ad:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
801021b0:	68 80 3d 11 80       	push   $0x80113d80
801021b5:	e8 c6 31 00 00       	call   80105380 <release>
      return ip;
801021ba:	83 c4 10             	add    $0x10,%esp
}
801021bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021c0:	89 f8                	mov    %edi,%eax
801021c2:	5b                   	pop    %ebx
801021c3:	5e                   	pop    %esi
801021c4:	5f                   	pop    %edi
801021c5:	5d                   	pop    %ebp
801021c6:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801021c7:	81 c3 90 00 00 00    	add    $0x90,%ebx
801021cd:	81 fb d4 59 11 80    	cmp    $0x801159d4,%ebx
801021d3:	74 10                	je     801021e5 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801021d5:	8b 43 08             	mov    0x8(%ebx),%eax
801021d8:	85 c0                	test   %eax,%eax
801021da:	0f 8f 50 ff ff ff    	jg     80102130 <iget+0x30>
801021e0:	e9 68 ff ff ff       	jmp    8010214d <iget+0x4d>
    panic("iget: no inodes");
801021e5:	83 ec 0c             	sub    $0xc,%esp
801021e8:	68 0d 87 10 80       	push   $0x8010870d
801021ed:	e8 ae e1 ff ff       	call   801003a0 <panic>
801021f2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801021f9:	00 
801021fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102200 <bfree>:
{
80102200:	55                   	push   %ebp
80102201:	89 c1                	mov    %eax,%ecx
  bp = bread(dev, BBLOCK(b, sb));
80102203:	89 d0                	mov    %edx,%eax
80102205:	c1 e8 0c             	shr    $0xc,%eax
{
80102208:	89 e5                	mov    %esp,%ebp
8010220a:	56                   	push   %esi
8010220b:	53                   	push   %ebx
  bp = bread(dev, BBLOCK(b, sb));
8010220c:	03 05 ec 59 11 80    	add    0x801159ec,%eax
{
80102212:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80102214:	83 ec 08             	sub    $0x8,%esp
80102217:	50                   	push   %eax
80102218:	51                   	push   %ecx
80102219:	e8 b2 de ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010221e:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80102220:	c1 fb 03             	sar    $0x3,%ebx
80102223:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80102226:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80102228:	83 e1 07             	and    $0x7,%ecx
8010222b:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
80102230:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
80102236:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80102238:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
8010223d:	85 c1                	test   %eax,%ecx
8010223f:	74 23                	je     80102264 <bfree+0x64>
  bp->data[bi/8] &= ~m;
80102241:	f7 d0                	not    %eax
  log_write(bp);
80102243:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80102246:	21 c8                	and    %ecx,%eax
80102248:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010224c:	56                   	push   %esi
8010224d:	e8 ee 1a 00 00       	call   80103d40 <log_write>
  brelse(bp);
80102252:	89 34 24             	mov    %esi,(%esp)
80102255:	e8 96 df ff ff       	call   801001f0 <brelse>
}
8010225a:	83 c4 10             	add    $0x10,%esp
8010225d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102260:	5b                   	pop    %ebx
80102261:	5e                   	pop    %esi
80102262:	5d                   	pop    %ebp
80102263:	c3                   	ret
    panic("freeing free block");
80102264:	83 ec 0c             	sub    $0xc,%esp
80102267:	68 1d 87 10 80       	push   $0x8010871d
8010226c:	e8 2f e1 ff ff       	call   801003a0 <panic>
80102271:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102278:	00 
80102279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102280 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80102280:	55                   	push   %ebp
80102281:	89 e5                	mov    %esp,%ebp
80102283:	57                   	push   %edi
80102284:	56                   	push   %esi
80102285:	89 c6                	mov    %eax,%esi
80102287:	53                   	push   %ebx
80102288:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010228b:	83 fa 0b             	cmp    $0xb,%edx
8010228e:	0f 86 8c 00 00 00    	jbe    80102320 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80102294:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80102297:	83 fb 7f             	cmp    $0x7f,%ebx
8010229a:	0f 87 a2 00 00 00    	ja     80102342 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
801022a0:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
801022a6:	85 c0                	test   %eax,%eax
801022a8:	74 5e                	je     80102308 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
801022aa:	83 ec 08             	sub    $0x8,%esp
801022ad:	50                   	push   %eax
801022ae:	ff 36                	push   (%esi)
801022b0:	e8 1b de ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
801022b5:	83 c4 10             	add    $0x10,%esp
801022b8:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
801022bc:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
801022be:	8b 3b                	mov    (%ebx),%edi
801022c0:	85 ff                	test   %edi,%edi
801022c2:	74 1c                	je     801022e0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
801022c4:	83 ec 0c             	sub    $0xc,%esp
801022c7:	52                   	push   %edx
801022c8:	e8 23 df ff ff       	call   801001f0 <brelse>
801022cd:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
801022d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022d3:	89 f8                	mov    %edi,%eax
801022d5:	5b                   	pop    %ebx
801022d6:	5e                   	pop    %esi
801022d7:	5f                   	pop    %edi
801022d8:	5d                   	pop    %ebp
801022d9:	c3                   	ret
801022da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801022e0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
801022e3:	8b 06                	mov    (%esi),%eax
801022e5:	e8 06 fd ff ff       	call   80101ff0 <balloc>
      log_write(bp);
801022ea:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801022ed:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801022f0:	89 03                	mov    %eax,(%ebx)
801022f2:	89 c7                	mov    %eax,%edi
      log_write(bp);
801022f4:	52                   	push   %edx
801022f5:	e8 46 1a 00 00       	call   80103d40 <log_write>
801022fa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801022fd:	83 c4 10             	add    $0x10,%esp
80102300:	eb c2                	jmp    801022c4 <bmap+0x44>
80102302:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80102308:	8b 06                	mov    (%esi),%eax
8010230a:	e8 e1 fc ff ff       	call   80101ff0 <balloc>
8010230f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80102315:	eb 93                	jmp    801022aa <bmap+0x2a>
80102317:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010231e:	00 
8010231f:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
80102320:	8d 5a 14             	lea    0x14(%edx),%ebx
80102323:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80102327:	85 ff                	test   %edi,%edi
80102329:	75 a5                	jne    801022d0 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010232b:	8b 00                	mov    (%eax),%eax
8010232d:	e8 be fc ff ff       	call   80101ff0 <balloc>
80102332:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80102336:	89 c7                	mov    %eax,%edi
}
80102338:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010233b:	5b                   	pop    %ebx
8010233c:	89 f8                	mov    %edi,%eax
8010233e:	5e                   	pop    %esi
8010233f:	5f                   	pop    %edi
80102340:	5d                   	pop    %ebp
80102341:	c3                   	ret
  panic("bmap: out of range");
80102342:	83 ec 0c             	sub    $0xc,%esp
80102345:	68 30 87 10 80       	push   $0x80108730
8010234a:	e8 51 e0 ff ff       	call   801003a0 <panic>
8010234f:	90                   	nop

80102350 <readsb>:
{
80102350:	55                   	push   %ebp
80102351:	89 e5                	mov    %esp,%ebp
80102353:	56                   	push   %esi
80102354:	53                   	push   %ebx
80102355:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80102358:	83 ec 08             	sub    $0x8,%esp
8010235b:	6a 01                	push   $0x1
8010235d:	ff 75 08             	push   0x8(%ebp)
80102360:	e8 6b dd ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80102365:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80102368:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010236a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010236d:	6a 1c                	push   $0x1c
8010236f:	50                   	push   %eax
80102370:	56                   	push   %esi
80102371:	e8 fa 31 00 00       	call   80105570 <memmove>
  brelse(bp);
80102376:	83 c4 10             	add    $0x10,%esp
80102379:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010237c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010237f:	5b                   	pop    %ebx
80102380:	5e                   	pop    %esi
80102381:	5d                   	pop    %ebp
  brelse(bp);
80102382:	e9 69 de ff ff       	jmp    801001f0 <brelse>
80102387:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010238e:	00 
8010238f:	90                   	nop

80102390 <iinit>:
{
80102390:	55                   	push   %ebp
80102391:	89 e5                	mov    %esp,%ebp
80102393:	53                   	push   %ebx
80102394:	bb c0 3d 11 80       	mov    $0x80113dc0,%ebx
80102399:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010239c:	68 43 87 10 80       	push   $0x80108743
801023a1:	68 80 3d 11 80       	push   $0x80113d80
801023a6:	e8 45 2e 00 00       	call   801051f0 <initlock>
  for(i = 0; i < NINODE; i++) {
801023ab:	83 c4 10             	add    $0x10,%esp
801023ae:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801023b0:	83 ec 08             	sub    $0x8,%esp
801023b3:	68 4a 87 10 80       	push   $0x8010874a
801023b8:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
801023b9:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
801023bf:	e8 fc 2c 00 00       	call   801050c0 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801023c4:	83 c4 10             	add    $0x10,%esp
801023c7:	81 fb e0 59 11 80    	cmp    $0x801159e0,%ebx
801023cd:	75 e1                	jne    801023b0 <iinit+0x20>
  bp = bread(dev, 1);
801023cf:	83 ec 08             	sub    $0x8,%esp
801023d2:	6a 01                	push   $0x1
801023d4:	ff 75 08             	push   0x8(%ebp)
801023d7:	e8 f4 dc ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801023dc:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801023df:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801023e1:	8d 40 5c             	lea    0x5c(%eax),%eax
801023e4:	6a 1c                	push   $0x1c
801023e6:	50                   	push   %eax
801023e7:	68 d4 59 11 80       	push   $0x801159d4
801023ec:	e8 7f 31 00 00       	call   80105570 <memmove>
  brelse(bp);
801023f1:	89 1c 24             	mov    %ebx,(%esp)
801023f4:	e8 f7 dd ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801023f9:	ff 35 ec 59 11 80    	push   0x801159ec
801023ff:	ff 35 e8 59 11 80    	push   0x801159e8
80102405:	ff 35 e4 59 11 80    	push   0x801159e4
8010240b:	ff 35 e0 59 11 80    	push   0x801159e0
80102411:	ff 35 dc 59 11 80    	push   0x801159dc
80102417:	ff 35 d8 59 11 80    	push   0x801159d8
8010241d:	ff 35 d4 59 11 80    	push   0x801159d4
80102423:	68 1c 8c 10 80       	push   $0x80108c1c
80102428:	e8 13 e8 ff ff       	call   80100c40 <cprintf>
}
8010242d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102430:	83 c4 30             	add    $0x30,%esp
80102433:	c9                   	leave
80102434:	c3                   	ret
80102435:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010243c:	00 
8010243d:	8d 76 00             	lea    0x0(%esi),%esi

80102440 <ialloc>:
{
80102440:	55                   	push   %ebp
80102441:	89 e5                	mov    %esp,%ebp
80102443:	57                   	push   %edi
80102444:	56                   	push   %esi
80102445:	53                   	push   %ebx
80102446:	83 ec 1c             	sub    $0x1c,%esp
80102449:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010244c:	83 3d dc 59 11 80 01 	cmpl   $0x1,0x801159dc
{
80102453:	8b 75 08             	mov    0x8(%ebp),%esi
80102456:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80102459:	0f 86 91 00 00 00    	jbe    801024f0 <ialloc+0xb0>
8010245f:	bf 01 00 00 00       	mov    $0x1,%edi
80102464:	eb 21                	jmp    80102487 <ialloc+0x47>
80102466:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010246d:	00 
8010246e:	66 90                	xchg   %ax,%ax
    brelse(bp);
80102470:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80102473:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80102476:	53                   	push   %ebx
80102477:	e8 74 dd ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010247c:	83 c4 10             	add    $0x10,%esp
8010247f:	3b 3d dc 59 11 80    	cmp    0x801159dc,%edi
80102485:	73 69                	jae    801024f0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80102487:	89 f8                	mov    %edi,%eax
80102489:	83 ec 08             	sub    $0x8,%esp
8010248c:	c1 e8 03             	shr    $0x3,%eax
8010248f:	03 05 e8 59 11 80    	add    0x801159e8,%eax
80102495:	50                   	push   %eax
80102496:	56                   	push   %esi
80102497:	e8 34 dc ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010249c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010249f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
801024a1:	89 f8                	mov    %edi,%eax
801024a3:	83 e0 07             	and    $0x7,%eax
801024a6:	c1 e0 06             	shl    $0x6,%eax
801024a9:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
801024ad:	66 83 39 00          	cmpw   $0x0,(%ecx)
801024b1:	75 bd                	jne    80102470 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
801024b3:	83 ec 04             	sub    $0x4,%esp
801024b6:	6a 40                	push   $0x40
801024b8:	6a 00                	push   $0x0
801024ba:	51                   	push   %ecx
801024bb:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801024be:	e8 1d 30 00 00       	call   801054e0 <memset>
      dip->type = type;
801024c3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801024c7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801024ca:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801024cd:	89 1c 24             	mov    %ebx,(%esp)
801024d0:	e8 6b 18 00 00       	call   80103d40 <log_write>
      brelse(bp);
801024d5:	89 1c 24             	mov    %ebx,(%esp)
801024d8:	e8 13 dd ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
801024dd:	83 c4 10             	add    $0x10,%esp
}
801024e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801024e3:	89 fa                	mov    %edi,%edx
}
801024e5:	5b                   	pop    %ebx
      return iget(dev, inum);
801024e6:	89 f0                	mov    %esi,%eax
}
801024e8:	5e                   	pop    %esi
801024e9:	5f                   	pop    %edi
801024ea:	5d                   	pop    %ebp
      return iget(dev, inum);
801024eb:	e9 10 fc ff ff       	jmp    80102100 <iget>
  panic("ialloc: no inodes");
801024f0:	83 ec 0c             	sub    $0xc,%esp
801024f3:	68 50 87 10 80       	push   $0x80108750
801024f8:	e8 a3 de ff ff       	call   801003a0 <panic>
801024fd:	8d 76 00             	lea    0x0(%esi),%esi

80102500 <iupdate>:
{
80102500:	55                   	push   %ebp
80102501:	89 e5                	mov    %esp,%ebp
80102503:	56                   	push   %esi
80102504:	53                   	push   %ebx
80102505:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80102508:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010250b:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010250e:	83 ec 08             	sub    $0x8,%esp
80102511:	c1 e8 03             	shr    $0x3,%eax
80102514:	03 05 e8 59 11 80    	add    0x801159e8,%eax
8010251a:	50                   	push   %eax
8010251b:	ff 73 a4             	push   -0x5c(%ebx)
8010251e:	e8 ad db ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80102523:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80102527:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010252a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010252c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010252f:	83 e0 07             	and    $0x7,%eax
80102532:	c1 e0 06             	shl    $0x6,%eax
80102535:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80102539:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010253c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80102540:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80102543:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80102547:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010254b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010254f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80102553:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80102557:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010255a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010255d:	6a 34                	push   $0x34
8010255f:	53                   	push   %ebx
80102560:	50                   	push   %eax
80102561:	e8 0a 30 00 00       	call   80105570 <memmove>
  log_write(bp);
80102566:	89 34 24             	mov    %esi,(%esp)
80102569:	e8 d2 17 00 00       	call   80103d40 <log_write>
  brelse(bp);
8010256e:	83 c4 10             	add    $0x10,%esp
80102571:	89 75 08             	mov    %esi,0x8(%ebp)
}
80102574:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102577:	5b                   	pop    %ebx
80102578:	5e                   	pop    %esi
80102579:	5d                   	pop    %ebp
  brelse(bp);
8010257a:	e9 71 dc ff ff       	jmp    801001f0 <brelse>
8010257f:	90                   	nop

80102580 <idup>:
{
80102580:	55                   	push   %ebp
80102581:	89 e5                	mov    %esp,%ebp
80102583:	53                   	push   %ebx
80102584:	83 ec 10             	sub    $0x10,%esp
80102587:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010258a:	68 80 3d 11 80       	push   $0x80113d80
8010258f:	e8 4c 2e 00 00       	call   801053e0 <acquire>
  ip->ref++;
80102594:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80102598:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
8010259f:	e8 dc 2d 00 00       	call   80105380 <release>
}
801025a4:	89 d8                	mov    %ebx,%eax
801025a6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801025a9:	c9                   	leave
801025aa:	c3                   	ret
801025ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801025b0 <ilock>:
{
801025b0:	55                   	push   %ebp
801025b1:	89 e5                	mov    %esp,%ebp
801025b3:	56                   	push   %esi
801025b4:	53                   	push   %ebx
801025b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
801025b8:	85 db                	test   %ebx,%ebx
801025ba:	0f 84 b7 00 00 00    	je     80102677 <ilock+0xc7>
801025c0:	8b 53 08             	mov    0x8(%ebx),%edx
801025c3:	85 d2                	test   %edx,%edx
801025c5:	0f 8e ac 00 00 00    	jle    80102677 <ilock+0xc7>
  acquiresleep(&ip->lock);
801025cb:	83 ec 0c             	sub    $0xc,%esp
801025ce:	8d 43 0c             	lea    0xc(%ebx),%eax
801025d1:	50                   	push   %eax
801025d2:	e8 29 2b 00 00       	call   80105100 <acquiresleep>
  if(ip->valid == 0){
801025d7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801025da:	83 c4 10             	add    $0x10,%esp
801025dd:	85 c0                	test   %eax,%eax
801025df:	74 0f                	je     801025f0 <ilock+0x40>
}
801025e1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801025e4:	5b                   	pop    %ebx
801025e5:	5e                   	pop    %esi
801025e6:	5d                   	pop    %ebp
801025e7:	c3                   	ret
801025e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801025ef:	00 
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801025f0:	8b 43 04             	mov    0x4(%ebx),%eax
801025f3:	83 ec 08             	sub    $0x8,%esp
801025f6:	c1 e8 03             	shr    $0x3,%eax
801025f9:	03 05 e8 59 11 80    	add    0x801159e8,%eax
801025ff:	50                   	push   %eax
80102600:	ff 33                	push   (%ebx)
80102602:	e8 c9 da ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80102607:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010260a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
8010260c:	8b 43 04             	mov    0x4(%ebx),%eax
8010260f:	83 e0 07             	and    $0x7,%eax
80102612:	c1 e0 06             	shl    $0x6,%eax
80102615:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80102619:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
8010261c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
8010261f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80102623:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80102627:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010262b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010262f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80102633:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80102637:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010263b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010263e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80102641:	6a 34                	push   $0x34
80102643:	50                   	push   %eax
80102644:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102647:	50                   	push   %eax
80102648:	e8 23 2f 00 00       	call   80105570 <memmove>
    brelse(bp);
8010264d:	89 34 24             	mov    %esi,(%esp)
80102650:	e8 9b db ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80102655:	83 c4 10             	add    $0x10,%esp
80102658:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010265d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80102664:	0f 85 77 ff ff ff    	jne    801025e1 <ilock+0x31>
      panic("ilock: no type");
8010266a:	83 ec 0c             	sub    $0xc,%esp
8010266d:	68 68 87 10 80       	push   $0x80108768
80102672:	e8 29 dd ff ff       	call   801003a0 <panic>
    panic("ilock");
80102677:	83 ec 0c             	sub    $0xc,%esp
8010267a:	68 62 87 10 80       	push   $0x80108762
8010267f:	e8 1c dd ff ff       	call   801003a0 <panic>
80102684:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010268b:	00 
8010268c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102690 <iunlock>:
{
80102690:	55                   	push   %ebp
80102691:	89 e5                	mov    %esp,%ebp
80102693:	56                   	push   %esi
80102694:	53                   	push   %ebx
80102695:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102698:	85 db                	test   %ebx,%ebx
8010269a:	74 28                	je     801026c4 <iunlock+0x34>
8010269c:	83 ec 0c             	sub    $0xc,%esp
8010269f:	8d 73 0c             	lea    0xc(%ebx),%esi
801026a2:	56                   	push   %esi
801026a3:	e8 f8 2a 00 00       	call   801051a0 <holdingsleep>
801026a8:	83 c4 10             	add    $0x10,%esp
801026ab:	85 c0                	test   %eax,%eax
801026ad:	74 15                	je     801026c4 <iunlock+0x34>
801026af:	8b 43 08             	mov    0x8(%ebx),%eax
801026b2:	85 c0                	test   %eax,%eax
801026b4:	7e 0e                	jle    801026c4 <iunlock+0x34>
  releasesleep(&ip->lock);
801026b6:	89 75 08             	mov    %esi,0x8(%ebp)
}
801026b9:	8d 65 f8             	lea    -0x8(%ebp),%esp
801026bc:	5b                   	pop    %ebx
801026bd:	5e                   	pop    %esi
801026be:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
801026bf:	e9 9c 2a 00 00       	jmp    80105160 <releasesleep>
    panic("iunlock");
801026c4:	83 ec 0c             	sub    $0xc,%esp
801026c7:	68 77 87 10 80       	push   $0x80108777
801026cc:	e8 cf dc ff ff       	call   801003a0 <panic>
801026d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801026d8:	00 
801026d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801026e0 <iput>:
{
801026e0:	55                   	push   %ebp
801026e1:	89 e5                	mov    %esp,%ebp
801026e3:	57                   	push   %edi
801026e4:	56                   	push   %esi
801026e5:	53                   	push   %ebx
801026e6:	83 ec 28             	sub    $0x28,%esp
801026e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801026ec:	8d 7b 0c             	lea    0xc(%ebx),%edi
801026ef:	57                   	push   %edi
801026f0:	e8 0b 2a 00 00       	call   80105100 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801026f5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801026f8:	83 c4 10             	add    $0x10,%esp
801026fb:	85 d2                	test   %edx,%edx
801026fd:	74 07                	je     80102706 <iput+0x26>
801026ff:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80102704:	74 32                	je     80102738 <iput+0x58>
  releasesleep(&ip->lock);
80102706:	83 ec 0c             	sub    $0xc,%esp
80102709:	57                   	push   %edi
8010270a:	e8 51 2a 00 00       	call   80105160 <releasesleep>
  acquire(&icache.lock);
8010270f:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80102716:	e8 c5 2c 00 00       	call   801053e0 <acquire>
  ip->ref--;
8010271b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
8010271f:	83 c4 10             	add    $0x10,%esp
80102722:	c7 45 08 80 3d 11 80 	movl   $0x80113d80,0x8(%ebp)
}
80102729:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010272c:	5b                   	pop    %ebx
8010272d:	5e                   	pop    %esi
8010272e:	5f                   	pop    %edi
8010272f:	5d                   	pop    %ebp
  release(&icache.lock);
80102730:	e9 4b 2c 00 00       	jmp    80105380 <release>
80102735:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80102738:	83 ec 0c             	sub    $0xc,%esp
8010273b:	68 80 3d 11 80       	push   $0x80113d80
80102740:	e8 9b 2c 00 00       	call   801053e0 <acquire>
    int r = ip->ref;
80102745:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80102748:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
8010274f:	e8 2c 2c 00 00       	call   80105380 <release>
    if(r == 1){
80102754:	83 c4 10             	add    $0x10,%esp
80102757:	83 fe 01             	cmp    $0x1,%esi
8010275a:	75 aa                	jne    80102706 <iput+0x26>
8010275c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80102762:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80102765:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102768:	89 df                	mov    %ebx,%edi
8010276a:	89 cb                	mov    %ecx,%ebx
8010276c:	eb 09                	jmp    80102777 <iput+0x97>
8010276e:	66 90                	xchg   %ax,%ax
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80102770:	83 c6 04             	add    $0x4,%esi
80102773:	39 de                	cmp    %ebx,%esi
80102775:	74 19                	je     80102790 <iput+0xb0>
    if(ip->addrs[i]){
80102777:	8b 16                	mov    (%esi),%edx
80102779:	85 d2                	test   %edx,%edx
8010277b:	74 f3                	je     80102770 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010277d:	8b 07                	mov    (%edi),%eax
8010277f:	e8 7c fa ff ff       	call   80102200 <bfree>
      ip->addrs[i] = 0;
80102784:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010278a:	eb e4                	jmp    80102770 <iput+0x90>
8010278c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80102790:	89 fb                	mov    %edi,%ebx
80102792:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80102795:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
8010279b:	85 c0                	test   %eax,%eax
8010279d:	75 2d                	jne    801027cc <iput+0xec>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010279f:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
801027a2:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
801027a9:	53                   	push   %ebx
801027aa:	e8 51 fd ff ff       	call   80102500 <iupdate>
      ip->type = 0;
801027af:	31 c0                	xor    %eax,%eax
801027b1:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
801027b5:	89 1c 24             	mov    %ebx,(%esp)
801027b8:	e8 43 fd ff ff       	call   80102500 <iupdate>
      ip->valid = 0;
801027bd:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801027c4:	83 c4 10             	add    $0x10,%esp
801027c7:	e9 3a ff ff ff       	jmp    80102706 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801027cc:	83 ec 08             	sub    $0x8,%esp
801027cf:	50                   	push   %eax
801027d0:	ff 33                	push   (%ebx)
801027d2:	e8 f9 d8 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
801027d7:	83 c4 10             	add    $0x10,%esp
801027da:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801027dd:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801027e3:	89 45 e0             	mov    %eax,-0x20(%ebp)
801027e6:	8d 70 5c             	lea    0x5c(%eax),%esi
801027e9:	89 cf                	mov    %ecx,%edi
801027eb:	eb 0a                	jmp    801027f7 <iput+0x117>
801027ed:	8d 76 00             	lea    0x0(%esi),%esi
801027f0:	83 c6 04             	add    $0x4,%esi
801027f3:	39 fe                	cmp    %edi,%esi
801027f5:	74 0f                	je     80102806 <iput+0x126>
      if(a[j])
801027f7:	8b 16                	mov    (%esi),%edx
801027f9:	85 d2                	test   %edx,%edx
801027fb:	74 f3                	je     801027f0 <iput+0x110>
        bfree(ip->dev, a[j]);
801027fd:	8b 03                	mov    (%ebx),%eax
801027ff:	e8 fc f9 ff ff       	call   80102200 <bfree>
80102804:	eb ea                	jmp    801027f0 <iput+0x110>
    brelse(bp);
80102806:	8b 45 e0             	mov    -0x20(%ebp),%eax
80102809:	83 ec 0c             	sub    $0xc,%esp
8010280c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010280f:	50                   	push   %eax
80102810:	e8 db d9 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80102815:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
8010281b:	8b 03                	mov    (%ebx),%eax
8010281d:	e8 de f9 ff ff       	call   80102200 <bfree>
    ip->addrs[NDIRECT] = 0;
80102822:	83 c4 10             	add    $0x10,%esp
80102825:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
8010282c:	00 00 00 
8010282f:	e9 6b ff ff ff       	jmp    8010279f <iput+0xbf>
80102834:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010283b:	00 
8010283c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102840 <iunlockput>:
{
80102840:	55                   	push   %ebp
80102841:	89 e5                	mov    %esp,%ebp
80102843:	56                   	push   %esi
80102844:	53                   	push   %ebx
80102845:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102848:	85 db                	test   %ebx,%ebx
8010284a:	74 34                	je     80102880 <iunlockput+0x40>
8010284c:	83 ec 0c             	sub    $0xc,%esp
8010284f:	8d 73 0c             	lea    0xc(%ebx),%esi
80102852:	56                   	push   %esi
80102853:	e8 48 29 00 00       	call   801051a0 <holdingsleep>
80102858:	83 c4 10             	add    $0x10,%esp
8010285b:	85 c0                	test   %eax,%eax
8010285d:	74 21                	je     80102880 <iunlockput+0x40>
8010285f:	8b 43 08             	mov    0x8(%ebx),%eax
80102862:	85 c0                	test   %eax,%eax
80102864:	7e 1a                	jle    80102880 <iunlockput+0x40>
  releasesleep(&ip->lock);
80102866:	83 ec 0c             	sub    $0xc,%esp
80102869:	56                   	push   %esi
8010286a:	e8 f1 28 00 00       	call   80105160 <releasesleep>
  iput(ip);
8010286f:	83 c4 10             	add    $0x10,%esp
80102872:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80102875:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102878:	5b                   	pop    %ebx
80102879:	5e                   	pop    %esi
8010287a:	5d                   	pop    %ebp
  iput(ip);
8010287b:	e9 60 fe ff ff       	jmp    801026e0 <iput>
    panic("iunlock");
80102880:	83 ec 0c             	sub    $0xc,%esp
80102883:	68 77 87 10 80       	push   $0x80108777
80102888:	e8 13 db ff ff       	call   801003a0 <panic>
8010288d:	8d 76 00             	lea    0x0(%esi),%esi

80102890 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80102890:	55                   	push   %ebp
80102891:	89 e5                	mov    %esp,%ebp
80102893:	8b 55 08             	mov    0x8(%ebp),%edx
80102896:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80102899:	8b 0a                	mov    (%edx),%ecx
8010289b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010289e:	8b 4a 04             	mov    0x4(%edx),%ecx
801028a1:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
801028a4:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
801028a8:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
801028ab:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
801028af:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
801028b3:	8b 52 58             	mov    0x58(%edx),%edx
801028b6:	89 50 10             	mov    %edx,0x10(%eax)
}
801028b9:	5d                   	pop    %ebp
801028ba:	c3                   	ret
801028bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801028c0 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
801028c0:	55                   	push   %ebp
801028c1:	89 e5                	mov    %esp,%ebp
801028c3:	57                   	push   %edi
801028c4:	56                   	push   %esi
801028c5:	53                   	push   %ebx
801028c6:	83 ec 1c             	sub    $0x1c,%esp
801028c9:	8b 75 08             	mov    0x8(%ebp),%esi
801028cc:	8b 45 0c             	mov    0xc(%ebp),%eax
801028cf:	8b 7d 10             	mov    0x10(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801028d2:	66 83 7e 50 03       	cmpw   $0x3,0x50(%esi)
{
801028d7:	89 45 e0             	mov    %eax,-0x20(%ebp)
801028da:	89 75 d8             	mov    %esi,-0x28(%ebp)
801028dd:	8b 45 14             	mov    0x14(%ebp),%eax
  if(ip->type == T_DEV){
801028e0:	0f 84 aa 00 00 00    	je     80102990 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
801028e6:	8b 75 d8             	mov    -0x28(%ebp),%esi
801028e9:	8b 56 58             	mov    0x58(%esi),%edx
801028ec:	39 fa                	cmp    %edi,%edx
801028ee:	0f 82 bd 00 00 00    	jb     801029b1 <readi+0xf1>
801028f4:	89 f9                	mov    %edi,%ecx
801028f6:	31 db                	xor    %ebx,%ebx
801028f8:	01 c1                	add    %eax,%ecx
801028fa:	0f 92 c3             	setb   %bl
801028fd:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80102900:	0f 82 ab 00 00 00    	jb     801029b1 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80102906:	89 d3                	mov    %edx,%ebx
80102908:	29 fb                	sub    %edi,%ebx
8010290a:	39 ca                	cmp    %ecx,%edx
8010290c:	0f 42 c3             	cmovb  %ebx,%eax

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010290f:	85 c0                	test   %eax,%eax
80102911:	74 73                	je     80102986 <readi+0xc6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80102913:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80102916:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80102919:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102920:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80102923:	89 fa                	mov    %edi,%edx
80102925:	c1 ea 09             	shr    $0x9,%edx
80102928:	89 d8                	mov    %ebx,%eax
8010292a:	e8 51 f9 ff ff       	call   80102280 <bmap>
8010292f:	83 ec 08             	sub    $0x8,%esp
80102932:	50                   	push   %eax
80102933:	ff 33                	push   (%ebx)
80102935:	e8 96 d7 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
8010293a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010293d:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102942:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80102944:	89 f8                	mov    %edi,%eax
80102946:	25 ff 01 00 00       	and    $0x1ff,%eax
8010294b:	29 f3                	sub    %esi,%ebx
8010294d:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
8010294f:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102953:	39 d9                	cmp    %ebx,%ecx
80102955:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80102958:	83 c4 0c             	add    $0xc,%esp
8010295b:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
8010295c:	01 de                	add    %ebx,%esi
8010295e:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80102960:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102963:	50                   	push   %eax
80102964:	ff 75 e0             	push   -0x20(%ebp)
80102967:	e8 04 2c 00 00       	call   80105570 <memmove>
    brelse(bp);
8010296c:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010296f:	89 14 24             	mov    %edx,(%esp)
80102972:	e8 79 d8 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102977:	01 5d e0             	add    %ebx,-0x20(%ebp)
8010297a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010297d:	83 c4 10             	add    $0x10,%esp
80102980:	39 de                	cmp    %ebx,%esi
80102982:	72 9c                	jb     80102920 <readi+0x60>
80102984:	89 d8                	mov    %ebx,%eax
  }
  return n;
}
80102986:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102989:	5b                   	pop    %ebx
8010298a:	5e                   	pop    %esi
8010298b:	5f                   	pop    %edi
8010298c:	5d                   	pop    %ebp
8010298d:	c3                   	ret
8010298e:	66 90                	xchg   %ax,%ax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80102990:	0f bf 56 52          	movswl 0x52(%esi),%edx
80102994:	66 83 fa 09          	cmp    $0x9,%dx
80102998:	77 17                	ja     801029b1 <readi+0xf1>
8010299a:	8b 14 d5 40 20 11 80 	mov    -0x7feedfc0(,%edx,8),%edx
801029a1:	85 d2                	test   %edx,%edx
801029a3:	74 0c                	je     801029b1 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
801029a5:	89 45 10             	mov    %eax,0x10(%ebp)
}
801029a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801029ab:	5b                   	pop    %ebx
801029ac:	5e                   	pop    %esi
801029ad:	5f                   	pop    %edi
801029ae:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
801029af:	ff e2                	jmp    *%edx
      return -1;
801029b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801029b6:	eb ce                	jmp    80102986 <readi+0xc6>
801029b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801029bf:	00 

801029c0 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
801029c0:	55                   	push   %ebp
801029c1:	89 e5                	mov    %esp,%ebp
801029c3:	57                   	push   %edi
801029c4:	56                   	push   %esi
801029c5:	53                   	push   %ebx
801029c6:	83 ec 1c             	sub    $0x1c,%esp
801029c9:	8b 45 08             	mov    0x8(%ebp),%eax
801029cc:	8b 7d 0c             	mov    0xc(%ebp),%edi
801029cf:	8b 75 14             	mov    0x14(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
801029d2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
801029d7:	89 7d dc             	mov    %edi,-0x24(%ebp)
801029da:	89 75 e0             	mov    %esi,-0x20(%ebp)
801029dd:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(ip->type == T_DEV){
801029e0:	0f 84 ba 00 00 00    	je     80102aa0 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
801029e6:	39 78 58             	cmp    %edi,0x58(%eax)
801029e9:	0f 82 ea 00 00 00    	jb     80102ad9 <writei+0x119>
    return -1;
  if(off + n > MAXFILE*BSIZE)
801029ef:	8b 75 e0             	mov    -0x20(%ebp),%esi
801029f2:	89 f2                	mov    %esi,%edx
801029f4:	01 fa                	add    %edi,%edx
801029f6:	0f 82 dd 00 00 00    	jb     80102ad9 <writei+0x119>
801029fc:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
80102a02:	0f 87 d1 00 00 00    	ja     80102ad9 <writei+0x119>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102a08:	85 f6                	test   %esi,%esi
80102a0a:	0f 84 85 00 00 00    	je     80102a95 <writei+0xd5>
80102a10:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80102a17:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102a20:	8b 75 d8             	mov    -0x28(%ebp),%esi
80102a23:	89 fa                	mov    %edi,%edx
80102a25:	c1 ea 09             	shr    $0x9,%edx
80102a28:	89 f0                	mov    %esi,%eax
80102a2a:	e8 51 f8 ff ff       	call   80102280 <bmap>
80102a2f:	83 ec 08             	sub    $0x8,%esp
80102a32:	50                   	push   %eax
80102a33:	ff 36                	push   (%esi)
80102a35:	e8 96 d6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80102a3a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102a3d:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80102a40:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102a45:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80102a47:	89 f8                	mov    %edi,%eax
80102a49:	25 ff 01 00 00       	and    $0x1ff,%eax
80102a4e:	29 d3                	sub    %edx,%ebx
80102a50:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80102a52:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80102a56:	39 d9                	cmp    %ebx,%ecx
80102a58:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80102a5b:	83 c4 0c             	add    $0xc,%esp
80102a5e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102a5f:	01 df                	add    %ebx,%edi
    memmove(bp->data + off%BSIZE, src, m);
80102a61:	ff 75 dc             	push   -0x24(%ebp)
80102a64:	50                   	push   %eax
80102a65:	e8 06 2b 00 00       	call   80105570 <memmove>
    log_write(bp);
80102a6a:	89 34 24             	mov    %esi,(%esp)
80102a6d:	e8 ce 12 00 00       	call   80103d40 <log_write>
    brelse(bp);
80102a72:	89 34 24             	mov    %esi,(%esp)
80102a75:	e8 76 d7 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102a7a:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80102a7d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80102a80:	83 c4 10             	add    $0x10,%esp
80102a83:	01 5d dc             	add    %ebx,-0x24(%ebp)
80102a86:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80102a89:	39 d8                	cmp    %ebx,%eax
80102a8b:	72 93                	jb     80102a20 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80102a8d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102a90:	39 78 58             	cmp    %edi,0x58(%eax)
80102a93:	72 33                	jb     80102ac8 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80102a95:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80102a98:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a9b:	5b                   	pop    %ebx
80102a9c:	5e                   	pop    %esi
80102a9d:	5f                   	pop    %edi
80102a9e:	5d                   	pop    %ebp
80102a9f:	c3                   	ret
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80102aa0:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102aa4:	66 83 f8 09          	cmp    $0x9,%ax
80102aa8:	77 2f                	ja     80102ad9 <writei+0x119>
80102aaa:	8b 04 c5 44 20 11 80 	mov    -0x7feedfbc(,%eax,8),%eax
80102ab1:	85 c0                	test   %eax,%eax
80102ab3:	74 24                	je     80102ad9 <writei+0x119>
    return devsw[ip->major].write(ip, src, n);
80102ab5:	89 75 10             	mov    %esi,0x10(%ebp)
}
80102ab8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102abb:	5b                   	pop    %ebx
80102abc:	5e                   	pop    %esi
80102abd:	5f                   	pop    %edi
80102abe:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80102abf:	ff e0                	jmp    *%eax
80102ac1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iupdate(ip);
80102ac8:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80102acb:	89 78 58             	mov    %edi,0x58(%eax)
    iupdate(ip);
80102ace:	50                   	push   %eax
80102acf:	e8 2c fa ff ff       	call   80102500 <iupdate>
80102ad4:	83 c4 10             	add    $0x10,%esp
80102ad7:	eb bc                	jmp    80102a95 <writei+0xd5>
      return -1;
80102ad9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102ade:	eb b8                	jmp    80102a98 <writei+0xd8>

80102ae0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80102ae0:	55                   	push   %ebp
80102ae1:	89 e5                	mov    %esp,%ebp
80102ae3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80102ae6:	6a 0e                	push   $0xe
80102ae8:	ff 75 0c             	push   0xc(%ebp)
80102aeb:	ff 75 08             	push   0x8(%ebp)
80102aee:	e8 ed 2a 00 00       	call   801055e0 <strncmp>
}
80102af3:	c9                   	leave
80102af4:	c3                   	ret
80102af5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102afc:	00 
80102afd:	8d 76 00             	lea    0x0(%esi),%esi

80102b00 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80102b00:	55                   	push   %ebp
80102b01:	89 e5                	mov    %esp,%ebp
80102b03:	57                   	push   %edi
80102b04:	56                   	push   %esi
80102b05:	53                   	push   %ebx
80102b06:	83 ec 1c             	sub    $0x1c,%esp
80102b09:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80102b0c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102b11:	0f 85 85 00 00 00    	jne    80102b9c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80102b17:	8b 53 58             	mov    0x58(%ebx),%edx
80102b1a:	31 ff                	xor    %edi,%edi
80102b1c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102b1f:	85 d2                	test   %edx,%edx
80102b21:	74 3e                	je     80102b61 <dirlookup+0x61>
80102b23:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102b28:	6a 10                	push   $0x10
80102b2a:	57                   	push   %edi
80102b2b:	56                   	push   %esi
80102b2c:	53                   	push   %ebx
80102b2d:	e8 8e fd ff ff       	call   801028c0 <readi>
80102b32:	83 c4 10             	add    $0x10,%esp
80102b35:	83 f8 10             	cmp    $0x10,%eax
80102b38:	75 55                	jne    80102b8f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80102b3a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102b3f:	74 18                	je     80102b59 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80102b41:	83 ec 04             	sub    $0x4,%esp
80102b44:	8d 45 da             	lea    -0x26(%ebp),%eax
80102b47:	6a 0e                	push   $0xe
80102b49:	50                   	push   %eax
80102b4a:	ff 75 0c             	push   0xc(%ebp)
80102b4d:	e8 8e 2a 00 00       	call   801055e0 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80102b52:	83 c4 10             	add    $0x10,%esp
80102b55:	85 c0                	test   %eax,%eax
80102b57:	74 17                	je     80102b70 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102b59:	83 c7 10             	add    $0x10,%edi
80102b5c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102b5f:	72 c7                	jb     80102b28 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80102b61:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80102b64:	31 c0                	xor    %eax,%eax
}
80102b66:	5b                   	pop    %ebx
80102b67:	5e                   	pop    %esi
80102b68:	5f                   	pop    %edi
80102b69:	5d                   	pop    %ebp
80102b6a:	c3                   	ret
80102b6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(poff)
80102b70:	8b 45 10             	mov    0x10(%ebp),%eax
80102b73:	85 c0                	test   %eax,%eax
80102b75:	74 05                	je     80102b7c <dirlookup+0x7c>
        *poff = off;
80102b77:	8b 45 10             	mov    0x10(%ebp),%eax
80102b7a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80102b7c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80102b80:	8b 03                	mov    (%ebx),%eax
80102b82:	e8 79 f5 ff ff       	call   80102100 <iget>
}
80102b87:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b8a:	5b                   	pop    %ebx
80102b8b:	5e                   	pop    %esi
80102b8c:	5f                   	pop    %edi
80102b8d:	5d                   	pop    %ebp
80102b8e:	c3                   	ret
      panic("dirlookup read");
80102b8f:	83 ec 0c             	sub    $0xc,%esp
80102b92:	68 91 87 10 80       	push   $0x80108791
80102b97:	e8 04 d8 ff ff       	call   801003a0 <panic>
    panic("dirlookup not DIR");
80102b9c:	83 ec 0c             	sub    $0xc,%esp
80102b9f:	68 7f 87 10 80       	push   $0x8010877f
80102ba4:	e8 f7 d7 ff ff       	call   801003a0 <panic>
80102ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102bb0 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102bb0:	55                   	push   %ebp
80102bb1:	89 e5                	mov    %esp,%ebp
80102bb3:	57                   	push   %edi
80102bb4:	56                   	push   %esi
80102bb5:	53                   	push   %ebx
80102bb6:	89 c3                	mov    %eax,%ebx
80102bb8:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80102bbb:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80102bbe:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102bc1:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80102bc4:	0f 84 9e 01 00 00    	je     80102d68 <namex+0x1b8>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80102bca:	e8 c1 1b 00 00       	call   80104790 <myproc>
  acquire(&icache.lock);
80102bcf:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80102bd2:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80102bd5:	68 80 3d 11 80       	push   $0x80113d80
80102bda:	e8 01 28 00 00       	call   801053e0 <acquire>
  ip->ref++;
80102bdf:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102be3:	c7 04 24 80 3d 11 80 	movl   $0x80113d80,(%esp)
80102bea:	e8 91 27 00 00       	call   80105380 <release>
80102bef:	83 c4 10             	add    $0x10,%esp
80102bf2:	eb 07                	jmp    80102bfb <namex+0x4b>
80102bf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102bf8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80102bfb:	0f b6 03             	movzbl (%ebx),%eax
80102bfe:	3c 2f                	cmp    $0x2f,%al
80102c00:	74 f6                	je     80102bf8 <namex+0x48>
  if(*path == 0)
80102c02:	84 c0                	test   %al,%al
80102c04:	0f 84 06 01 00 00    	je     80102d10 <namex+0x160>
  while(*path != '/' && *path != 0)
80102c0a:	0f b6 03             	movzbl (%ebx),%eax
80102c0d:	84 c0                	test   %al,%al
80102c0f:	0f 84 10 01 00 00    	je     80102d25 <namex+0x175>
80102c15:	89 df                	mov    %ebx,%edi
80102c17:	3c 2f                	cmp    $0x2f,%al
80102c19:	0f 84 06 01 00 00    	je     80102d25 <namex+0x175>
80102c1f:	90                   	nop
80102c20:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80102c24:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80102c27:	3c 2f                	cmp    $0x2f,%al
80102c29:	74 04                	je     80102c2f <namex+0x7f>
80102c2b:	84 c0                	test   %al,%al
80102c2d:	75 f1                	jne    80102c20 <namex+0x70>
  len = path - s;
80102c2f:	89 f8                	mov    %edi,%eax
80102c31:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80102c33:	83 f8 0d             	cmp    $0xd,%eax
80102c36:	0f 8e ac 00 00 00    	jle    80102ce8 <namex+0x138>
    memmove(name, s, DIRSIZ);
80102c3c:	83 ec 04             	sub    $0x4,%esp
80102c3f:	6a 0e                	push   $0xe
80102c41:	53                   	push   %ebx
80102c42:	89 fb                	mov    %edi,%ebx
80102c44:	ff 75 e4             	push   -0x1c(%ebp)
80102c47:	e8 24 29 00 00       	call   80105570 <memmove>
80102c4c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80102c4f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80102c52:	75 0c                	jne    80102c60 <namex+0xb0>
80102c54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102c58:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80102c5b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80102c5e:	74 f8                	je     80102c58 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80102c60:	83 ec 0c             	sub    $0xc,%esp
80102c63:	56                   	push   %esi
80102c64:	e8 47 f9 ff ff       	call   801025b0 <ilock>
    if(ip->type != T_DIR){
80102c69:	83 c4 10             	add    $0x10,%esp
80102c6c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102c71:	0f 85 b7 00 00 00    	jne    80102d2e <namex+0x17e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80102c77:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102c7a:	85 c0                	test   %eax,%eax
80102c7c:	74 09                	je     80102c87 <namex+0xd7>
80102c7e:	80 3b 00             	cmpb   $0x0,(%ebx)
80102c81:	0f 84 f7 00 00 00    	je     80102d7e <namex+0x1ce>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102c87:	83 ec 04             	sub    $0x4,%esp
80102c8a:	6a 00                	push   $0x0
80102c8c:	ff 75 e4             	push   -0x1c(%ebp)
80102c8f:	56                   	push   %esi
80102c90:	e8 6b fe ff ff       	call   80102b00 <dirlookup>
80102c95:	83 c4 10             	add    $0x10,%esp
80102c98:	89 c7                	mov    %eax,%edi
80102c9a:	85 c0                	test   %eax,%eax
80102c9c:	0f 84 8c 00 00 00    	je     80102d2e <namex+0x17e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102ca2:	83 ec 0c             	sub    $0xc,%esp
80102ca5:	8d 4e 0c             	lea    0xc(%esi),%ecx
80102ca8:	51                   	push   %ecx
80102ca9:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80102cac:	e8 ef 24 00 00       	call   801051a0 <holdingsleep>
80102cb1:	83 c4 10             	add    $0x10,%esp
80102cb4:	85 c0                	test   %eax,%eax
80102cb6:	0f 84 02 01 00 00    	je     80102dbe <namex+0x20e>
80102cbc:	8b 56 08             	mov    0x8(%esi),%edx
80102cbf:	85 d2                	test   %edx,%edx
80102cc1:	0f 8e f7 00 00 00    	jle    80102dbe <namex+0x20e>
  releasesleep(&ip->lock);
80102cc7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80102cca:	83 ec 0c             	sub    $0xc,%esp
80102ccd:	51                   	push   %ecx
80102cce:	e8 8d 24 00 00       	call   80105160 <releasesleep>
  iput(ip);
80102cd3:	89 34 24             	mov    %esi,(%esp)
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80102cd6:	89 fe                	mov    %edi,%esi
  iput(ip);
80102cd8:	e8 03 fa ff ff       	call   801026e0 <iput>
80102cdd:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80102ce0:	e9 16 ff ff ff       	jmp    80102bfb <namex+0x4b>
80102ce5:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80102ce8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80102ceb:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    memmove(name, s, len);
80102cee:	83 ec 04             	sub    $0x4,%esp
80102cf1:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80102cf4:	50                   	push   %eax
80102cf5:	53                   	push   %ebx
    name[len] = 0;
80102cf6:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80102cf8:	ff 75 e4             	push   -0x1c(%ebp)
80102cfb:	e8 70 28 00 00       	call   80105570 <memmove>
    name[len] = 0;
80102d00:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80102d03:	83 c4 10             	add    $0x10,%esp
80102d06:	c6 01 00             	movb   $0x0,(%ecx)
80102d09:	e9 41 ff ff ff       	jmp    80102c4f <namex+0x9f>
80102d0e:	66 90                	xchg   %ax,%ax
  }
  if(nameiparent){
80102d10:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102d13:	85 c0                	test   %eax,%eax
80102d15:	0f 85 93 00 00 00    	jne    80102dae <namex+0x1fe>
    iput(ip);
    return 0;
  }
  return ip;
}
80102d1b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d1e:	89 f0                	mov    %esi,%eax
80102d20:	5b                   	pop    %ebx
80102d21:	5e                   	pop    %esi
80102d22:	5f                   	pop    %edi
80102d23:	5d                   	pop    %ebp
80102d24:	c3                   	ret
  while(*path != '/' && *path != 0)
80102d25:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102d28:	89 df                	mov    %ebx,%edi
80102d2a:	31 c0                	xor    %eax,%eax
80102d2c:	eb c0                	jmp    80102cee <namex+0x13e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102d2e:	83 ec 0c             	sub    $0xc,%esp
80102d31:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102d34:	53                   	push   %ebx
80102d35:	e8 66 24 00 00       	call   801051a0 <holdingsleep>
80102d3a:	83 c4 10             	add    $0x10,%esp
80102d3d:	85 c0                	test   %eax,%eax
80102d3f:	74 7d                	je     80102dbe <namex+0x20e>
80102d41:	8b 4e 08             	mov    0x8(%esi),%ecx
80102d44:	85 c9                	test   %ecx,%ecx
80102d46:	7e 76                	jle    80102dbe <namex+0x20e>
  releasesleep(&ip->lock);
80102d48:	83 ec 0c             	sub    $0xc,%esp
80102d4b:	53                   	push   %ebx
80102d4c:	e8 0f 24 00 00       	call   80105160 <releasesleep>
  iput(ip);
80102d51:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102d54:	31 f6                	xor    %esi,%esi
  iput(ip);
80102d56:	e8 85 f9 ff ff       	call   801026e0 <iput>
      return 0;
80102d5b:	83 c4 10             	add    $0x10,%esp
}
80102d5e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d61:	89 f0                	mov    %esi,%eax
80102d63:	5b                   	pop    %ebx
80102d64:	5e                   	pop    %esi
80102d65:	5f                   	pop    %edi
80102d66:	5d                   	pop    %ebp
80102d67:	c3                   	ret
    ip = iget(ROOTDEV, ROOTINO);
80102d68:	ba 01 00 00 00       	mov    $0x1,%edx
80102d6d:	b8 01 00 00 00       	mov    $0x1,%eax
80102d72:	e8 89 f3 ff ff       	call   80102100 <iget>
80102d77:	89 c6                	mov    %eax,%esi
80102d79:	e9 7d fe ff ff       	jmp    80102bfb <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102d7e:	83 ec 0c             	sub    $0xc,%esp
80102d81:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102d84:	53                   	push   %ebx
80102d85:	e8 16 24 00 00       	call   801051a0 <holdingsleep>
80102d8a:	83 c4 10             	add    $0x10,%esp
80102d8d:	85 c0                	test   %eax,%eax
80102d8f:	74 2d                	je     80102dbe <namex+0x20e>
80102d91:	8b 7e 08             	mov    0x8(%esi),%edi
80102d94:	85 ff                	test   %edi,%edi
80102d96:	7e 26                	jle    80102dbe <namex+0x20e>
  releasesleep(&ip->lock);
80102d98:	83 ec 0c             	sub    $0xc,%esp
80102d9b:	53                   	push   %ebx
80102d9c:	e8 bf 23 00 00       	call   80105160 <releasesleep>
}
80102da1:	83 c4 10             	add    $0x10,%esp
}
80102da4:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102da7:	89 f0                	mov    %esi,%eax
80102da9:	5b                   	pop    %ebx
80102daa:	5e                   	pop    %esi
80102dab:	5f                   	pop    %edi
80102dac:	5d                   	pop    %ebp
80102dad:	c3                   	ret
    iput(ip);
80102dae:	83 ec 0c             	sub    $0xc,%esp
80102db1:	56                   	push   %esi
      return 0;
80102db2:	31 f6                	xor    %esi,%esi
    iput(ip);
80102db4:	e8 27 f9 ff ff       	call   801026e0 <iput>
    return 0;
80102db9:	83 c4 10             	add    $0x10,%esp
80102dbc:	eb a0                	jmp    80102d5e <namex+0x1ae>
    panic("iunlock");
80102dbe:	83 ec 0c             	sub    $0xc,%esp
80102dc1:	68 77 87 10 80       	push   $0x80108777
80102dc6:	e8 d5 d5 ff ff       	call   801003a0 <panic>
80102dcb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102dd0 <dirlink>:
{
80102dd0:	55                   	push   %ebp
80102dd1:	89 e5                	mov    %esp,%ebp
80102dd3:	57                   	push   %edi
80102dd4:	56                   	push   %esi
80102dd5:	53                   	push   %ebx
80102dd6:	83 ec 20             	sub    $0x20,%esp
80102dd9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80102ddc:	6a 00                	push   $0x0
80102dde:	ff 75 0c             	push   0xc(%ebp)
80102de1:	53                   	push   %ebx
80102de2:	e8 19 fd ff ff       	call   80102b00 <dirlookup>
80102de7:	83 c4 10             	add    $0x10,%esp
80102dea:	85 c0                	test   %eax,%eax
80102dec:	75 67                	jne    80102e55 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102dee:	8b 7b 58             	mov    0x58(%ebx),%edi
80102df1:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102df4:	85 ff                	test   %edi,%edi
80102df6:	74 29                	je     80102e21 <dirlink+0x51>
80102df8:	31 ff                	xor    %edi,%edi
80102dfa:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102dfd:	eb 09                	jmp    80102e08 <dirlink+0x38>
80102dff:	90                   	nop
80102e00:	83 c7 10             	add    $0x10,%edi
80102e03:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102e06:	73 19                	jae    80102e21 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102e08:	6a 10                	push   $0x10
80102e0a:	57                   	push   %edi
80102e0b:	56                   	push   %esi
80102e0c:	53                   	push   %ebx
80102e0d:	e8 ae fa ff ff       	call   801028c0 <readi>
80102e12:	83 c4 10             	add    $0x10,%esp
80102e15:	83 f8 10             	cmp    $0x10,%eax
80102e18:	75 4e                	jne    80102e68 <dirlink+0x98>
    if(de.inum == 0)
80102e1a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80102e1f:	75 df                	jne    80102e00 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102e21:	83 ec 04             	sub    $0x4,%esp
80102e24:	8d 45 da             	lea    -0x26(%ebp),%eax
80102e27:	6a 0e                	push   $0xe
80102e29:	ff 75 0c             	push   0xc(%ebp)
80102e2c:	50                   	push   %eax
80102e2d:	e8 fe 27 00 00       	call   80105630 <strncpy>
  de.inum = inum;
80102e32:	8b 45 10             	mov    0x10(%ebp),%eax
80102e35:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102e39:	6a 10                	push   $0x10
80102e3b:	57                   	push   %edi
80102e3c:	56                   	push   %esi
80102e3d:	53                   	push   %ebx
80102e3e:	e8 7d fb ff ff       	call   801029c0 <writei>
80102e43:	83 c4 20             	add    $0x20,%esp
80102e46:	83 f8 10             	cmp    $0x10,%eax
80102e49:	75 2a                	jne    80102e75 <dirlink+0xa5>
  return 0;
80102e4b:	31 c0                	xor    %eax,%eax
}
80102e4d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e50:	5b                   	pop    %ebx
80102e51:	5e                   	pop    %esi
80102e52:	5f                   	pop    %edi
80102e53:	5d                   	pop    %ebp
80102e54:	c3                   	ret
    iput(ip);
80102e55:	83 ec 0c             	sub    $0xc,%esp
80102e58:	50                   	push   %eax
80102e59:	e8 82 f8 ff ff       	call   801026e0 <iput>
    return -1;
80102e5e:	83 c4 10             	add    $0x10,%esp
80102e61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102e66:	eb e5                	jmp    80102e4d <dirlink+0x7d>
      panic("dirlink read");
80102e68:	83 ec 0c             	sub    $0xc,%esp
80102e6b:	68 a0 87 10 80       	push   $0x801087a0
80102e70:	e8 2b d5 ff ff       	call   801003a0 <panic>
    panic("dirlink");
80102e75:	83 ec 0c             	sub    $0xc,%esp
80102e78:	68 01 8a 10 80       	push   $0x80108a01
80102e7d:	e8 1e d5 ff ff       	call   801003a0 <panic>
80102e82:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e89:	00 
80102e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102e90 <namei>:

struct inode*
namei(char *path)
{
80102e90:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102e91:	31 d2                	xor    %edx,%edx
{
80102e93:	89 e5                	mov    %esp,%ebp
80102e95:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102e98:	8b 45 08             	mov    0x8(%ebp),%eax
80102e9b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80102e9e:	e8 0d fd ff ff       	call   80102bb0 <namex>
}
80102ea3:	c9                   	leave
80102ea4:	c3                   	ret
80102ea5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102eac:	00 
80102ead:	8d 76 00             	lea    0x0(%esi),%esi

80102eb0 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102eb0:	55                   	push   %ebp
  return namex(path, 1, name);
80102eb1:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102eb6:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102eb8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102ebb:	8b 45 08             	mov    0x8(%ebp),%eax
}
80102ebe:	5d                   	pop    %ebp
  return namex(path, 1, name);
80102ebf:	e9 ec fc ff ff       	jmp    80102bb0 <namex>
80102ec4:	66 90                	xchg   %ax,%ax
80102ec6:	66 90                	xchg   %ax,%ax
80102ec8:	66 90                	xchg   %ax,%ax
80102eca:	66 90                	xchg   %ax,%ax
80102ecc:	66 90                	xchg   %ax,%ax
80102ece:	66 90                	xchg   %ax,%ax

80102ed0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102ed0:	55                   	push   %ebp
80102ed1:	89 e5                	mov    %esp,%ebp
80102ed3:	57                   	push   %edi
80102ed4:	56                   	push   %esi
80102ed5:	53                   	push   %ebx
80102ed6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102ed9:	85 c0                	test   %eax,%eax
80102edb:	0f 84 b4 00 00 00    	je     80102f95 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102ee1:	8b 70 08             	mov    0x8(%eax),%esi
80102ee4:	89 c3                	mov    %eax,%ebx
80102ee6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
80102eec:	0f 87 96 00 00 00    	ja     80102f88 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ef2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102ef7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102efe:	00 
80102eff:	90                   	nop
80102f00:	89 ca                	mov    %ecx,%edx
80102f02:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102f03:	83 e0 c0             	and    $0xffffffc0,%eax
80102f06:	3c 40                	cmp    $0x40,%al
80102f08:	75 f6                	jne    80102f00 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102f0a:	31 ff                	xor    %edi,%edi
80102f0c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102f11:	89 f8                	mov    %edi,%eax
80102f13:	ee                   	out    %al,(%dx)
80102f14:	b8 01 00 00 00       	mov    $0x1,%eax
80102f19:	ba f2 01 00 00       	mov    $0x1f2,%edx
80102f1e:	ee                   	out    %al,(%dx)
80102f1f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102f24:	89 f0                	mov    %esi,%eax
80102f26:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102f27:	89 f0                	mov    %esi,%eax
80102f29:	ba f4 01 00 00       	mov    $0x1f4,%edx
80102f2e:	c1 f8 08             	sar    $0x8,%eax
80102f31:	ee                   	out    %al,(%dx)
80102f32:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102f37:	89 f8                	mov    %edi,%eax
80102f39:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80102f3a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
80102f3e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102f43:	c1 e0 04             	shl    $0x4,%eax
80102f46:	83 e0 10             	and    $0x10,%eax
80102f49:	83 c8 e0             	or     $0xffffffe0,%eax
80102f4c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80102f4d:	f6 03 04             	testb  $0x4,(%ebx)
80102f50:	75 16                	jne    80102f68 <idestart+0x98>
80102f52:	b8 20 00 00 00       	mov    $0x20,%eax
80102f57:	89 ca                	mov    %ecx,%edx
80102f59:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80102f5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f5d:	5b                   	pop    %ebx
80102f5e:	5e                   	pop    %esi
80102f5f:	5f                   	pop    %edi
80102f60:	5d                   	pop    %ebp
80102f61:	c3                   	ret
80102f62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102f68:	b8 30 00 00 00       	mov    $0x30,%eax
80102f6d:	89 ca                	mov    %ecx,%edx
80102f6f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102f70:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102f75:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102f78:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102f7d:	fc                   	cld
80102f7e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102f80:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f83:	5b                   	pop    %ebx
80102f84:	5e                   	pop    %esi
80102f85:	5f                   	pop    %edi
80102f86:	5d                   	pop    %ebp
80102f87:	c3                   	ret
    panic("incorrect blockno");
80102f88:	83 ec 0c             	sub    $0xc,%esp
80102f8b:	68 b6 87 10 80       	push   $0x801087b6
80102f90:	e8 0b d4 ff ff       	call   801003a0 <panic>
    panic("idestart");
80102f95:	83 ec 0c             	sub    $0xc,%esp
80102f98:	68 ad 87 10 80       	push   $0x801087ad
80102f9d:	e8 fe d3 ff ff       	call   801003a0 <panic>
80102fa2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102fa9:	00 
80102faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102fb0 <ideinit>:
{
80102fb0:	55                   	push   %ebp
80102fb1:	89 e5                	mov    %esp,%ebp
80102fb3:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102fb6:	68 c8 87 10 80       	push   $0x801087c8
80102fbb:	68 20 5a 11 80       	push   $0x80115a20
80102fc0:	e8 2b 22 00 00       	call   801051f0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102fc5:	58                   	pop    %eax
80102fc6:	a1 a4 5b 11 80       	mov    0x80115ba4,%eax
80102fcb:	5a                   	pop    %edx
80102fcc:	83 e8 01             	sub    $0x1,%eax
80102fcf:	50                   	push   %eax
80102fd0:	6a 0e                	push   $0xe
80102fd2:	e8 99 02 00 00       	call   80103270 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102fd7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102fda:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102fdf:	90                   	nop
80102fe0:	89 ca                	mov    %ecx,%edx
80102fe2:	ec                   	in     (%dx),%al
80102fe3:	83 e0 c0             	and    $0xffffffc0,%eax
80102fe6:	3c 40                	cmp    $0x40,%al
80102fe8:	75 f6                	jne    80102fe0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102fea:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102fef:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102ff4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ff5:	89 ca                	mov    %ecx,%edx
80102ff7:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102ff8:	84 c0                	test   %al,%al
80102ffa:	75 1e                	jne    8010301a <ideinit+0x6a>
80102ffc:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80103001:	ba f7 01 00 00       	mov    $0x1f7,%edx
80103006:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010300d:	00 
8010300e:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
80103010:	83 e9 01             	sub    $0x1,%ecx
80103013:	74 0f                	je     80103024 <ideinit+0x74>
80103015:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80103016:	84 c0                	test   %al,%al
80103018:	74 f6                	je     80103010 <ideinit+0x60>
      havedisk1 = 1;
8010301a:	c7 05 00 5a 11 80 01 	movl   $0x1,0x80115a00
80103021:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103024:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80103029:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010302e:	ee                   	out    %al,(%dx)
}
8010302f:	c9                   	leave
80103030:	c3                   	ret
80103031:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103038:	00 
80103039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103040 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80103040:	55                   	push   %ebp
80103041:	89 e5                	mov    %esp,%ebp
80103043:	57                   	push   %edi
80103044:	56                   	push   %esi
80103045:	53                   	push   %ebx
80103046:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80103049:	68 20 5a 11 80       	push   $0x80115a20
8010304e:	e8 8d 23 00 00       	call   801053e0 <acquire>

  if((b = idequeue) == 0){
80103053:	8b 1d 04 5a 11 80    	mov    0x80115a04,%ebx
80103059:	83 c4 10             	add    $0x10,%esp
8010305c:	85 db                	test   %ebx,%ebx
8010305e:	74 63                	je     801030c3 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80103060:	8b 43 58             	mov    0x58(%ebx),%eax
80103063:	a3 04 5a 11 80       	mov    %eax,0x80115a04

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80103068:	8b 33                	mov    (%ebx),%esi
8010306a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80103070:	75 2f                	jne    801030a1 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103072:	ba f7 01 00 00       	mov    $0x1f7,%edx
80103077:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010307e:	00 
8010307f:	90                   	nop
80103080:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80103081:	89 c1                	mov    %eax,%ecx
80103083:	83 e1 c0             	and    $0xffffffc0,%ecx
80103086:	80 f9 40             	cmp    $0x40,%cl
80103089:	75 f5                	jne    80103080 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010308b:	a8 21                	test   $0x21,%al
8010308d:	75 12                	jne    801030a1 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010308f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80103092:	b9 80 00 00 00       	mov    $0x80,%ecx
80103097:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010309c:	fc                   	cld
8010309d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010309f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
801030a1:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
801030a4:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
801030a7:	83 ce 02             	or     $0x2,%esi
801030aa:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
801030ac:	53                   	push   %ebx
801030ad:	e8 6e 1e 00 00       	call   80104f20 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
801030b2:	a1 04 5a 11 80       	mov    0x80115a04,%eax
801030b7:	83 c4 10             	add    $0x10,%esp
801030ba:	85 c0                	test   %eax,%eax
801030bc:	74 05                	je     801030c3 <ideintr+0x83>
    idestart(idequeue);
801030be:	e8 0d fe ff ff       	call   80102ed0 <idestart>
    release(&idelock);
801030c3:	83 ec 0c             	sub    $0xc,%esp
801030c6:	68 20 5a 11 80       	push   $0x80115a20
801030cb:	e8 b0 22 00 00       	call   80105380 <release>

  release(&idelock);
}
801030d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030d3:	5b                   	pop    %ebx
801030d4:	5e                   	pop    %esi
801030d5:	5f                   	pop    %edi
801030d6:	5d                   	pop    %ebp
801030d7:	c3                   	ret
801030d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801030df:	00 

801030e0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801030e0:	55                   	push   %ebp
801030e1:	89 e5                	mov    %esp,%ebp
801030e3:	53                   	push   %ebx
801030e4:	83 ec 10             	sub    $0x10,%esp
801030e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801030ea:	8d 43 0c             	lea    0xc(%ebx),%eax
801030ed:	50                   	push   %eax
801030ee:	e8 ad 20 00 00       	call   801051a0 <holdingsleep>
801030f3:	83 c4 10             	add    $0x10,%esp
801030f6:	85 c0                	test   %eax,%eax
801030f8:	0f 84 c3 00 00 00    	je     801031c1 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801030fe:	8b 03                	mov    (%ebx),%eax
80103100:	83 e0 06             	and    $0x6,%eax
80103103:	83 f8 02             	cmp    $0x2,%eax
80103106:	0f 84 a8 00 00 00    	je     801031b4 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010310c:	8b 53 04             	mov    0x4(%ebx),%edx
8010310f:	85 d2                	test   %edx,%edx
80103111:	74 0d                	je     80103120 <iderw+0x40>
80103113:	a1 00 5a 11 80       	mov    0x80115a00,%eax
80103118:	85 c0                	test   %eax,%eax
8010311a:	0f 84 87 00 00 00    	je     801031a7 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80103120:	83 ec 0c             	sub    $0xc,%esp
80103123:	68 20 5a 11 80       	push   $0x80115a20
80103128:	e8 b3 22 00 00       	call   801053e0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010312d:	a1 04 5a 11 80       	mov    0x80115a04,%eax
  b->qnext = 0;
80103132:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80103139:	83 c4 10             	add    $0x10,%esp
8010313c:	85 c0                	test   %eax,%eax
8010313e:	74 60                	je     801031a0 <iderw+0xc0>
80103140:	89 c2                	mov    %eax,%edx
80103142:	8b 40 58             	mov    0x58(%eax),%eax
80103145:	85 c0                	test   %eax,%eax
80103147:	75 f7                	jne    80103140 <iderw+0x60>
80103149:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010314c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010314e:	39 1d 04 5a 11 80    	cmp    %ebx,0x80115a04
80103154:	74 3a                	je     80103190 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80103156:	8b 03                	mov    (%ebx),%eax
80103158:	83 e0 06             	and    $0x6,%eax
8010315b:	83 f8 02             	cmp    $0x2,%eax
8010315e:	74 1b                	je     8010317b <iderw+0x9b>
    sleep(b, &idelock);
80103160:	83 ec 08             	sub    $0x8,%esp
80103163:	68 20 5a 11 80       	push   $0x80115a20
80103168:	53                   	push   %ebx
80103169:	e8 f2 1c 00 00       	call   80104e60 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010316e:	8b 03                	mov    (%ebx),%eax
80103170:	83 c4 10             	add    $0x10,%esp
80103173:	83 e0 06             	and    $0x6,%eax
80103176:	83 f8 02             	cmp    $0x2,%eax
80103179:	75 e5                	jne    80103160 <iderw+0x80>
  }


  release(&idelock);
8010317b:	c7 45 08 20 5a 11 80 	movl   $0x80115a20,0x8(%ebp)
}
80103182:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103185:	c9                   	leave
  release(&idelock);
80103186:	e9 f5 21 00 00       	jmp    80105380 <release>
8010318b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    idestart(b);
80103190:	89 d8                	mov    %ebx,%eax
80103192:	e8 39 fd ff ff       	call   80102ed0 <idestart>
80103197:	eb bd                	jmp    80103156 <iderw+0x76>
80103199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801031a0:	ba 04 5a 11 80       	mov    $0x80115a04,%edx
801031a5:	eb a5                	jmp    8010314c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
801031a7:	83 ec 0c             	sub    $0xc,%esp
801031aa:	68 f7 87 10 80       	push   $0x801087f7
801031af:	e8 ec d1 ff ff       	call   801003a0 <panic>
    panic("iderw: nothing to do");
801031b4:	83 ec 0c             	sub    $0xc,%esp
801031b7:	68 e2 87 10 80       	push   $0x801087e2
801031bc:	e8 df d1 ff ff       	call   801003a0 <panic>
    panic("iderw: buf not locked");
801031c1:	83 ec 0c             	sub    $0xc,%esp
801031c4:	68 cc 87 10 80       	push   $0x801087cc
801031c9:	e8 d2 d1 ff ff       	call   801003a0 <panic>
801031ce:	66 90                	xchg   %ax,%ax

801031d0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801031d0:	55                   	push   %ebp
801031d1:	89 e5                	mov    %esp,%ebp
801031d3:	56                   	push   %esi
801031d4:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801031d5:	c7 05 54 5a 11 80 00 	movl   $0xfec00000,0x80115a54
801031dc:	00 c0 fe 
  ioapic->reg = reg;
801031df:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801031e6:	00 00 00 
  return ioapic->data;
801031e9:	8b 15 54 5a 11 80    	mov    0x80115a54,%edx
801031ef:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
801031f2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801031f8:	8b 1d 54 5a 11 80    	mov    0x80115a54,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801031fe:	0f b6 15 a0 5b 11 80 	movzbl 0x80115ba0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80103205:	c1 ee 10             	shr    $0x10,%esi
80103208:	89 f0                	mov    %esi,%eax
8010320a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010320d:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
80103210:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80103213:	39 c2                	cmp    %eax,%edx
80103215:	74 16                	je     8010322d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80103217:	83 ec 0c             	sub    $0xc,%esp
8010321a:	68 70 8c 10 80       	push   $0x80108c70
8010321f:	e8 1c da ff ff       	call   80100c40 <cprintf>
  ioapic->reg = reg;
80103224:	8b 1d 54 5a 11 80    	mov    0x80115a54,%ebx
8010322a:	83 c4 10             	add    $0x10,%esp
{
8010322d:	ba 10 00 00 00       	mov    $0x10,%edx
80103232:	31 c0                	xor    %eax,%eax
80103234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapic->reg = reg;
80103238:	89 13                	mov    %edx,(%ebx)
8010323a:	8d 48 20             	lea    0x20(%eax),%ecx
  ioapic->data = data;
8010323d:	8b 1d 54 5a 11 80    	mov    0x80115a54,%ebx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80103243:	83 c0 01             	add    $0x1,%eax
80103246:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  ioapic->data = data;
8010324c:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
8010324f:	8d 4a 01             	lea    0x1(%edx),%ecx
  for(i = 0; i <= maxintr; i++){
80103252:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
80103255:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
80103257:	8b 1d 54 5a 11 80    	mov    0x80115a54,%ebx
8010325d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
80103264:	39 c6                	cmp    %eax,%esi
80103266:	7d d0                	jge    80103238 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80103268:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010326b:	5b                   	pop    %ebx
8010326c:	5e                   	pop    %esi
8010326d:	5d                   	pop    %ebp
8010326e:	c3                   	ret
8010326f:	90                   	nop

80103270 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80103270:	55                   	push   %ebp
  ioapic->reg = reg;
80103271:	8b 0d 54 5a 11 80    	mov    0x80115a54,%ecx
{
80103277:	89 e5                	mov    %esp,%ebp
80103279:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010327c:	8d 50 20             	lea    0x20(%eax),%edx
8010327f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80103283:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80103285:	8b 0d 54 5a 11 80    	mov    0x80115a54,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010328b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010328e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80103291:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80103294:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80103296:	a1 54 5a 11 80       	mov    0x80115a54,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010329b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010329e:	89 50 10             	mov    %edx,0x10(%eax)
}
801032a1:	5d                   	pop    %ebp
801032a2:	c3                   	ret
801032a3:	66 90                	xchg   %ax,%ax
801032a5:	66 90                	xchg   %ax,%ax
801032a7:	66 90                	xchg   %ax,%ax
801032a9:	66 90                	xchg   %ax,%ax
801032ab:	66 90                	xchg   %ax,%ax
801032ad:	66 90                	xchg   %ax,%ax
801032af:	90                   	nop

801032b0 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
801032b0:	55                   	push   %ebp
801032b1:	89 e5                	mov    %esp,%ebp
801032b3:	53                   	push   %ebx
801032b4:	83 ec 04             	sub    $0x4,%esp
801032b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
801032ba:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
801032c0:	75 76                	jne    80103338 <kfree+0x88>
801032c2:	81 fb f0 99 11 80    	cmp    $0x801199f0,%ebx
801032c8:	72 6e                	jb     80103338 <kfree+0x88>
801032ca:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801032d0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801032d5:	77 61                	ja     80103338 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801032d7:	83 ec 04             	sub    $0x4,%esp
801032da:	68 00 10 00 00       	push   $0x1000
801032df:	6a 01                	push   $0x1
801032e1:	53                   	push   %ebx
801032e2:	e8 f9 21 00 00       	call   801054e0 <memset>

  if(kmem.use_lock)
801032e7:	8b 15 94 5a 11 80    	mov    0x80115a94,%edx
801032ed:	83 c4 10             	add    $0x10,%esp
801032f0:	85 d2                	test   %edx,%edx
801032f2:	75 1c                	jne    80103310 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801032f4:	a1 98 5a 11 80       	mov    0x80115a98,%eax
801032f9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801032fb:	a1 94 5a 11 80       	mov    0x80115a94,%eax
  kmem.freelist = r;
80103300:	89 1d 98 5a 11 80    	mov    %ebx,0x80115a98
  if(kmem.use_lock)
80103306:	85 c0                	test   %eax,%eax
80103308:	75 1e                	jne    80103328 <kfree+0x78>
    release(&kmem.lock);
}
8010330a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010330d:	c9                   	leave
8010330e:	c3                   	ret
8010330f:	90                   	nop
    acquire(&kmem.lock);
80103310:	83 ec 0c             	sub    $0xc,%esp
80103313:	68 60 5a 11 80       	push   $0x80115a60
80103318:	e8 c3 20 00 00       	call   801053e0 <acquire>
8010331d:	83 c4 10             	add    $0x10,%esp
80103320:	eb d2                	jmp    801032f4 <kfree+0x44>
80103322:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80103328:	c7 45 08 60 5a 11 80 	movl   $0x80115a60,0x8(%ebp)
}
8010332f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103332:	c9                   	leave
    release(&kmem.lock);
80103333:	e9 48 20 00 00       	jmp    80105380 <release>
    panic("kfree");
80103338:	83 ec 0c             	sub    $0xc,%esp
8010333b:	68 15 88 10 80       	push   $0x80108815
80103340:	e8 5b d0 ff ff       	call   801003a0 <panic>
80103345:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010334c:	00 
8010334d:	8d 76 00             	lea    0x0(%esi),%esi

80103350 <freerange>:
{
80103350:	55                   	push   %ebp
80103351:	89 e5                	mov    %esp,%ebp
80103353:	56                   	push   %esi
80103354:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80103355:	8b 45 08             	mov    0x8(%ebp),%eax
{
80103358:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010335b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103361:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103367:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010336d:	39 de                	cmp    %ebx,%esi
8010336f:	72 23                	jb     80103394 <freerange+0x44>
80103371:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80103378:	83 ec 0c             	sub    $0xc,%esp
8010337b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103381:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80103387:	50                   	push   %eax
80103388:	e8 23 ff ff ff       	call   801032b0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010338d:	83 c4 10             	add    $0x10,%esp
80103390:	39 de                	cmp    %ebx,%esi
80103392:	73 e4                	jae    80103378 <freerange+0x28>
}
80103394:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103397:	5b                   	pop    %ebx
80103398:	5e                   	pop    %esi
80103399:	5d                   	pop    %ebp
8010339a:	c3                   	ret
8010339b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801033a0 <kinit2>:
{
801033a0:	55                   	push   %ebp
801033a1:	89 e5                	mov    %esp,%ebp
801033a3:	56                   	push   %esi
801033a4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801033a5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801033a8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801033ab:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801033b1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801033b7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801033bd:	39 de                	cmp    %ebx,%esi
801033bf:	72 23                	jb     801033e4 <kinit2+0x44>
801033c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801033c8:	83 ec 0c             	sub    $0xc,%esp
801033cb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801033d1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801033d7:	50                   	push   %eax
801033d8:	e8 d3 fe ff ff       	call   801032b0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801033dd:	83 c4 10             	add    $0x10,%esp
801033e0:	39 de                	cmp    %ebx,%esi
801033e2:	73 e4                	jae    801033c8 <kinit2+0x28>
  kmem.use_lock = 1;
801033e4:	c7 05 94 5a 11 80 01 	movl   $0x1,0x80115a94
801033eb:	00 00 00 
}
801033ee:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033f1:	5b                   	pop    %ebx
801033f2:	5e                   	pop    %esi
801033f3:	5d                   	pop    %ebp
801033f4:	c3                   	ret
801033f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801033fc:	00 
801033fd:	8d 76 00             	lea    0x0(%esi),%esi

80103400 <kinit1>:
{
80103400:	55                   	push   %ebp
80103401:	89 e5                	mov    %esp,%ebp
80103403:	56                   	push   %esi
80103404:	53                   	push   %ebx
80103405:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80103408:	83 ec 08             	sub    $0x8,%esp
8010340b:	68 1b 88 10 80       	push   $0x8010881b
80103410:	68 60 5a 11 80       	push   $0x80115a60
80103415:	e8 d6 1d 00 00       	call   801051f0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010341a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010341d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80103420:	c7 05 94 5a 11 80 00 	movl   $0x0,0x80115a94
80103427:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010342a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80103430:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103436:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010343c:	39 de                	cmp    %ebx,%esi
8010343e:	72 1c                	jb     8010345c <kinit1+0x5c>
    kfree(p);
80103440:	83 ec 0c             	sub    $0xc,%esp
80103443:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103449:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010344f:	50                   	push   %eax
80103450:	e8 5b fe ff ff       	call   801032b0 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80103455:	83 c4 10             	add    $0x10,%esp
80103458:	39 de                	cmp    %ebx,%esi
8010345a:	73 e4                	jae    80103440 <kinit1+0x40>
}
8010345c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010345f:	5b                   	pop    %ebx
80103460:	5e                   	pop    %esi
80103461:	5d                   	pop    %ebp
80103462:	c3                   	ret
80103463:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010346a:	00 
8010346b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103470 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80103470:	55                   	push   %ebp
80103471:	89 e5                	mov    %esp,%ebp
80103473:	53                   	push   %ebx
80103474:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80103477:	a1 94 5a 11 80       	mov    0x80115a94,%eax
8010347c:	85 c0                	test   %eax,%eax
8010347e:	75 20                	jne    801034a0 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
80103480:	8b 1d 98 5a 11 80    	mov    0x80115a98,%ebx
  if(r)
80103486:	85 db                	test   %ebx,%ebx
80103488:	74 07                	je     80103491 <kalloc+0x21>
    kmem.freelist = r->next;
8010348a:	8b 03                	mov    (%ebx),%eax
8010348c:	a3 98 5a 11 80       	mov    %eax,0x80115a98
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80103491:	89 d8                	mov    %ebx,%eax
80103493:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103496:	c9                   	leave
80103497:	c3                   	ret
80103498:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010349f:	00 
    acquire(&kmem.lock);
801034a0:	83 ec 0c             	sub    $0xc,%esp
801034a3:	68 60 5a 11 80       	push   $0x80115a60
801034a8:	e8 33 1f 00 00       	call   801053e0 <acquire>
  r = kmem.freelist;
801034ad:	8b 1d 98 5a 11 80    	mov    0x80115a98,%ebx
  if(kmem.use_lock)
801034b3:	a1 94 5a 11 80       	mov    0x80115a94,%eax
  if(r)
801034b8:	83 c4 10             	add    $0x10,%esp
801034bb:	85 db                	test   %ebx,%ebx
801034bd:	74 08                	je     801034c7 <kalloc+0x57>
    kmem.freelist = r->next;
801034bf:	8b 13                	mov    (%ebx),%edx
801034c1:	89 15 98 5a 11 80    	mov    %edx,0x80115a98
  if(kmem.use_lock)
801034c7:	85 c0                	test   %eax,%eax
801034c9:	74 c6                	je     80103491 <kalloc+0x21>
    release(&kmem.lock);
801034cb:	83 ec 0c             	sub    $0xc,%esp
801034ce:	68 60 5a 11 80       	push   $0x80115a60
801034d3:	e8 a8 1e 00 00       	call   80105380 <release>
}
801034d8:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
801034da:	83 c4 10             	add    $0x10,%esp
}
801034dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801034e0:	c9                   	leave
801034e1:	c3                   	ret
801034e2:	66 90                	xchg   %ax,%ax
801034e4:	66 90                	xchg   %ax,%ax
801034e6:	66 90                	xchg   %ax,%ax
801034e8:	66 90                	xchg   %ax,%ax
801034ea:	66 90                	xchg   %ax,%ax
801034ec:	66 90                	xchg   %ax,%ax
801034ee:	66 90                	xchg   %ax,%ax

801034f0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801034f0:	ba 64 00 00 00       	mov    $0x64,%edx
801034f5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if ((st & KBS_DIB) == 0)
801034f6:	a8 01                	test   $0x1,%al
801034f8:	0f 84 d2 00 00 00    	je     801035d0 <kbdgetc+0xe0>
int kbdgetc(void) {
801034fe:	55                   	push   %ebp
801034ff:	ba 60 00 00 00       	mov    $0x60,%edx
80103504:	89 e5                	mov    %esp,%ebp
80103506:	53                   	push   %ebx
80103507:	ec                   	in     (%dx),%al
    return -1;

  data = inb(KBDATAP);

  if (data == 0xE0) {   // Special key prefix
    shift |= E0ESC;
80103508:	8b 1d 9c 5a 11 80    	mov    0x80115a9c,%ebx
  data = inb(KBDATAP);
8010350e:	0f b6 c8             	movzbl %al,%ecx
  if (data == 0xE0) {   // Special key prefix
80103511:	3c e0                	cmp    $0xe0,%al
80103513:	74 5b                	je     80103570 <kbdgetc+0x80>
    return 0;
  } else if (data & 0x80) { 
    data = (shift & E0ESC) ? data : (data & 0x7F);
80103515:	89 da                	mov    %ebx,%edx
80103517:	83 e2 40             	and    $0x40,%edx
  } else if (data & 0x80) { 
8010351a:	84 c0                	test   %al,%al
8010351c:	78 62                	js     80103580 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if (shift & E0ESC) {
8010351e:	85 d2                	test   %edx,%edx
80103520:	74 0c                	je     8010352e <kbdgetc+0x3e>
    switch (data) {
80103522:	83 f9 4b             	cmp    $0x4b,%ecx
80103525:	0f 84 95 00 00 00    	je     801035c0 <kbdgetc+0xd0>
      case 0x4B:
        return KEY_LEFT;
    }
    shift &= ~E0ESC;
8010352b:	83 e3 bf             	and    $0xffffffbf,%ebx
  }

  shift |= shiftcode[data];
8010352e:	0f b6 91 e0 8e 10 80 	movzbl -0x7fef7120(%ecx),%edx
  shift ^= togglecode[data];
80103535:	0f b6 81 e0 8d 10 80 	movzbl -0x7fef7220(%ecx),%eax
  shift |= shiftcode[data];
8010353c:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
8010353e:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
80103540:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
80103542:	89 15 9c 5a 11 80    	mov    %edx,0x80115a9c
  c = charcode[shift & (CTL | SHIFT)][data];
80103548:	83 e0 03             	and    $0x3,%eax

  if (shift & CAPSLOCK) {
8010354b:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010354e:	8b 04 85 c0 8d 10 80 	mov    -0x7fef7240(,%eax,4),%eax
80103555:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if (shift & CAPSLOCK) {
80103559:	74 0b                	je     80103566 <kbdgetc+0x76>
    if ('a' <= c && c <= 'z')
8010355b:	8d 50 9f             	lea    -0x61(%eax),%edx
8010355e:	83 fa 19             	cmp    $0x19,%edx
80103561:	77 45                	ja     801035a8 <kbdgetc+0xb8>
      c += 'A' - 'a';
80103563:	83 e8 20             	sub    $0x20,%eax
    else if ('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  
  return c;
}
80103566:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103569:	c9                   	leave
8010356a:	c3                   	ret
8010356b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
80103570:	83 cb 40             	or     $0x40,%ebx
    return 0;
80103573:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80103575:	89 1d 9c 5a 11 80    	mov    %ebx,0x80115a9c
}
8010357b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010357e:	c9                   	leave
8010357f:	c3                   	ret
    data = (shift & E0ESC) ? data : (data & 0x7F);
80103580:	83 e0 7f             	and    $0x7f,%eax
80103583:	85 d2                	test   %edx,%edx
80103585:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80103588:	0f b6 81 e0 8e 10 80 	movzbl -0x7fef7120(%ecx),%eax
8010358f:	83 c8 40             	or     $0x40,%eax
80103592:	0f b6 c0             	movzbl %al,%eax
80103595:	f7 d0                	not    %eax
80103597:	21 d8                	and    %ebx,%eax
80103599:	a3 9c 5a 11 80       	mov    %eax,0x80115a9c
    return 0;
8010359e:	31 c0                	xor    %eax,%eax
801035a0:	eb d9                	jmp    8010357b <kbdgetc+0x8b>
801035a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if ('A' <= c && c <= 'Z')
801035a8:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
801035ab:	8d 50 20             	lea    0x20(%eax),%edx
}
801035ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801035b1:	c9                   	leave
      c += 'a' - 'A';
801035b2:	83 f9 1a             	cmp    $0x1a,%ecx
801035b5:	0f 42 c2             	cmovb  %edx,%eax
}
801035b8:	c3                   	ret
801035b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return KEY_LEFT;
801035c0:	b8 4b e0 00 00       	mov    $0xe04b,%eax
801035c5:	eb 9f                	jmp    80103566 <kbdgetc+0x76>
801035c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801035ce:	00 
801035cf:	90                   	nop
    return -1;
801035d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801035d5:	c3                   	ret
801035d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801035dd:	00 
801035de:	66 90                	xchg   %ax,%ax

801035e0 <kbdintr>:

void kbdintr(void) {
801035e0:	55                   	push   %ebp
801035e1:	89 e5                	mov    %esp,%ebp
801035e3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801035e6:	68 f0 34 10 80       	push   $0x801034f0
801035eb:	e8 80 d9 ff ff       	call   80100f70 <consoleintr>
}
801035f0:	83 c4 10             	add    $0x10,%esp
801035f3:	c9                   	leave
801035f4:	c3                   	ret
801035f5:	66 90                	xchg   %ax,%ax
801035f7:	66 90                	xchg   %ax,%ax
801035f9:	66 90                	xchg   %ax,%ax
801035fb:	66 90                	xchg   %ax,%ax
801035fd:	66 90                	xchg   %ax,%ax
801035ff:	90                   	nop

80103600 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80103600:	a1 a0 5a 11 80       	mov    0x80115aa0,%eax
80103605:	85 c0                	test   %eax,%eax
80103607:	0f 84 c3 00 00 00    	je     801036d0 <lapicinit+0xd0>
  lapic[index] = value;
8010360d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80103614:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103617:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010361a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80103621:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103624:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103627:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010362e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80103631:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103634:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010363b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
8010363e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103641:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80103648:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010364b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010364e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80103655:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80103658:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010365b:	8b 50 30             	mov    0x30(%eax),%edx
8010365e:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
80103664:	75 72                	jne    801036d8 <lapicinit+0xd8>
  lapic[index] = value;
80103666:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
8010366d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103670:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103673:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010367a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010367d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80103680:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80103687:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010368a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010368d:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103694:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103697:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010369a:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801036a1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801036a4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801036a7:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
801036ae:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
801036b1:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
801036b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801036b8:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
801036be:	80 e6 10             	and    $0x10,%dh
801036c1:	75 f5                	jne    801036b8 <lapicinit+0xb8>
  lapic[index] = value;
801036c3:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
801036ca:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801036cd:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
801036d0:	c3                   	ret
801036d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
801036d8:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
801036df:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801036e2:	8b 50 20             	mov    0x20(%eax),%edx
}
801036e5:	e9 7c ff ff ff       	jmp    80103666 <lapicinit+0x66>
801036ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801036f0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801036f0:	a1 a0 5a 11 80       	mov    0x80115aa0,%eax
801036f5:	85 c0                	test   %eax,%eax
801036f7:	74 07                	je     80103700 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
801036f9:	8b 40 20             	mov    0x20(%eax),%eax
801036fc:	c1 e8 18             	shr    $0x18,%eax
801036ff:	c3                   	ret
    return 0;
80103700:	31 c0                	xor    %eax,%eax
}
80103702:	c3                   	ret
80103703:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010370a:	00 
8010370b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103710 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80103710:	a1 a0 5a 11 80       	mov    0x80115aa0,%eax
80103715:	85 c0                	test   %eax,%eax
80103717:	74 0d                	je     80103726 <lapiceoi+0x16>
  lapic[index] = value;
80103719:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103720:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103723:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80103726:	c3                   	ret
80103727:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010372e:	00 
8010372f:	90                   	nop

80103730 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80103730:	c3                   	ret
80103731:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103738:	00 
80103739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103740 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80103740:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103741:	b8 0f 00 00 00       	mov    $0xf,%eax
80103746:	ba 70 00 00 00       	mov    $0x70,%edx
8010374b:	89 e5                	mov    %esp,%ebp
8010374d:	53                   	push   %ebx
8010374e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103751:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103754:	ee                   	out    %al,(%dx)
80103755:	b8 0a 00 00 00       	mov    $0xa,%eax
8010375a:	ba 71 00 00 00       	mov    $0x71,%edx
8010375f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80103760:	31 c0                	xor    %eax,%eax
  lapic[index] = value;
80103762:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80103765:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
8010376b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
8010376d:	c1 e9 0c             	shr    $0xc,%ecx
  lapic[index] = value;
80103770:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80103772:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80103775:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80103778:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
8010377e:	a1 a0 5a 11 80       	mov    0x80115aa0,%eax
80103783:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80103789:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010378c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80103793:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80103796:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80103799:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
801037a0:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
801037a3:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801037a6:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801037ac:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801037af:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801037b5:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801037b8:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801037be:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801037c1:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
801037c7:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
801037ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037cd:	c9                   	leave
801037ce:	c3                   	ret
801037cf:	90                   	nop

801037d0 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801037d0:	55                   	push   %ebp
801037d1:	b8 0b 00 00 00       	mov    $0xb,%eax
801037d6:	ba 70 00 00 00       	mov    $0x70,%edx
801037db:	89 e5                	mov    %esp,%ebp
801037dd:	57                   	push   %edi
801037de:	56                   	push   %esi
801037df:	53                   	push   %ebx
801037e0:	83 ec 4c             	sub    $0x4c,%esp
801037e3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801037e4:	ba 71 00 00 00       	mov    $0x71,%edx
801037e9:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
801037ea:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801037ed:	bf 70 00 00 00       	mov    $0x70,%edi
801037f2:	88 45 b3             	mov    %al,-0x4d(%ebp)
801037f5:	8d 76 00             	lea    0x0(%esi),%esi
801037f8:	31 c0                	xor    %eax,%eax
801037fa:	89 fa                	mov    %edi,%edx
801037fc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801037fd:	b9 71 00 00 00       	mov    $0x71,%ecx
80103802:	89 ca                	mov    %ecx,%edx
80103804:	ec                   	in     (%dx),%al
80103805:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103808:	89 fa                	mov    %edi,%edx
8010380a:	b8 02 00 00 00       	mov    $0x2,%eax
8010380f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103810:	89 ca                	mov    %ecx,%edx
80103812:	ec                   	in     (%dx),%al
80103813:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103816:	89 fa                	mov    %edi,%edx
80103818:	b8 04 00 00 00       	mov    $0x4,%eax
8010381d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010381e:	89 ca                	mov    %ecx,%edx
80103820:	ec                   	in     (%dx),%al
80103821:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103824:	89 fa                	mov    %edi,%edx
80103826:	b8 07 00 00 00       	mov    $0x7,%eax
8010382b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010382c:	89 ca                	mov    %ecx,%edx
8010382e:	ec                   	in     (%dx),%al
8010382f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103832:	89 fa                	mov    %edi,%edx
80103834:	b8 08 00 00 00       	mov    $0x8,%eax
80103839:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010383a:	89 ca                	mov    %ecx,%edx
8010383c:	ec                   	in     (%dx),%al
8010383d:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010383f:	89 fa                	mov    %edi,%edx
80103841:	b8 09 00 00 00       	mov    $0x9,%eax
80103846:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103847:	89 ca                	mov    %ecx,%edx
80103849:	ec                   	in     (%dx),%al
8010384a:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010384d:	89 fa                	mov    %edi,%edx
8010384f:	b8 0a 00 00 00       	mov    $0xa,%eax
80103854:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103855:	89 ca                	mov    %ecx,%edx
80103857:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80103858:	84 c0                	test   %al,%al
8010385a:	78 9c                	js     801037f8 <cmostime+0x28>
  return inb(CMOS_RETURN);
8010385c:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80103860:	89 f2                	mov    %esi,%edx
80103862:	89 5d cc             	mov    %ebx,-0x34(%ebp)
80103865:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103868:	89 fa                	mov    %edi,%edx
8010386a:	89 45 b8             	mov    %eax,-0x48(%ebp)
8010386d:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80103871:	89 75 c8             	mov    %esi,-0x38(%ebp)
80103874:	89 45 bc             	mov    %eax,-0x44(%ebp)
80103877:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
8010387b:	89 45 c0             	mov    %eax,-0x40(%ebp)
8010387e:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80103882:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80103885:	31 c0                	xor    %eax,%eax
80103887:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103888:	89 ca                	mov    %ecx,%edx
8010388a:	ec                   	in     (%dx),%al
8010388b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010388e:	89 fa                	mov    %edi,%edx
80103890:	89 45 d0             	mov    %eax,-0x30(%ebp)
80103893:	b8 02 00 00 00       	mov    $0x2,%eax
80103898:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103899:	89 ca                	mov    %ecx,%edx
8010389b:	ec                   	in     (%dx),%al
8010389c:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010389f:	89 fa                	mov    %edi,%edx
801038a1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
801038a4:	b8 04 00 00 00       	mov    $0x4,%eax
801038a9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801038aa:	89 ca                	mov    %ecx,%edx
801038ac:	ec                   	in     (%dx),%al
801038ad:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801038b0:	89 fa                	mov    %edi,%edx
801038b2:	89 45 d8             	mov    %eax,-0x28(%ebp)
801038b5:	b8 07 00 00 00       	mov    $0x7,%eax
801038ba:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801038bb:	89 ca                	mov    %ecx,%edx
801038bd:	ec                   	in     (%dx),%al
801038be:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801038c1:	89 fa                	mov    %edi,%edx
801038c3:	89 45 dc             	mov    %eax,-0x24(%ebp)
801038c6:	b8 08 00 00 00       	mov    $0x8,%eax
801038cb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801038cc:	89 ca                	mov    %ecx,%edx
801038ce:	ec                   	in     (%dx),%al
801038cf:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801038d2:	89 fa                	mov    %edi,%edx
801038d4:	89 45 e0             	mov    %eax,-0x20(%ebp)
801038d7:	b8 09 00 00 00       	mov    $0x9,%eax
801038dc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801038dd:	89 ca                	mov    %ecx,%edx
801038df:	ec                   	in     (%dx),%al
801038e0:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801038e3:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
801038e6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801038e9:	8d 45 d0             	lea    -0x30(%ebp),%eax
801038ec:	6a 18                	push   $0x18
801038ee:	50                   	push   %eax
801038ef:	8d 45 b8             	lea    -0x48(%ebp),%eax
801038f2:	50                   	push   %eax
801038f3:	e8 28 1c 00 00       	call   80105520 <memcmp>
801038f8:	83 c4 10             	add    $0x10,%esp
801038fb:	85 c0                	test   %eax,%eax
801038fd:	0f 85 f5 fe ff ff    	jne    801037f8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80103903:	0f b6 75 b3          	movzbl -0x4d(%ebp),%esi
80103907:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010390a:	89 f0                	mov    %esi,%eax
8010390c:	84 c0                	test   %al,%al
8010390e:	75 78                	jne    80103988 <cmostime+0x1b8>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80103910:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103913:	89 c2                	mov    %eax,%edx
80103915:	83 e0 0f             	and    $0xf,%eax
80103918:	c1 ea 04             	shr    $0x4,%edx
8010391b:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010391e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103921:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80103924:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103927:	89 c2                	mov    %eax,%edx
80103929:	83 e0 0f             	and    $0xf,%eax
8010392c:	c1 ea 04             	shr    $0x4,%edx
8010392f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103932:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103935:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80103938:	8b 45 c0             	mov    -0x40(%ebp),%eax
8010393b:	89 c2                	mov    %eax,%edx
8010393d:	83 e0 0f             	and    $0xf,%eax
80103940:	c1 ea 04             	shr    $0x4,%edx
80103943:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103946:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103949:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
8010394c:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010394f:	89 c2                	mov    %eax,%edx
80103951:	83 e0 0f             	and    $0xf,%eax
80103954:	c1 ea 04             	shr    $0x4,%edx
80103957:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010395a:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010395d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80103960:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103963:	89 c2                	mov    %eax,%edx
80103965:	83 e0 0f             	and    $0xf,%eax
80103968:	c1 ea 04             	shr    $0x4,%edx
8010396b:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010396e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103971:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80103974:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103977:	89 c2                	mov    %eax,%edx
80103979:	83 e0 0f             	and    $0xf,%eax
8010397c:	c1 ea 04             	shr    $0x4,%edx
8010397f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80103982:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103985:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80103988:	8b 45 b8             	mov    -0x48(%ebp),%eax
8010398b:	89 03                	mov    %eax,(%ebx)
8010398d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103990:	89 43 04             	mov    %eax,0x4(%ebx)
80103993:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103996:	89 43 08             	mov    %eax,0x8(%ebx)
80103999:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010399c:	89 43 0c             	mov    %eax,0xc(%ebx)
8010399f:	8b 45 c8             	mov    -0x38(%ebp),%eax
801039a2:	89 43 10             	mov    %eax,0x10(%ebx)
801039a5:	8b 45 cc             	mov    -0x34(%ebp),%eax
801039a8:	89 43 14             	mov    %eax,0x14(%ebx)
  r->year += 2000;
801039ab:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
801039b2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801039b5:	5b                   	pop    %ebx
801039b6:	5e                   	pop    %esi
801039b7:	5f                   	pop    %edi
801039b8:	5d                   	pop    %ebp
801039b9:	c3                   	ret
801039ba:	66 90                	xchg   %ax,%ax
801039bc:	66 90                	xchg   %ax,%ax
801039be:	66 90                	xchg   %ax,%ax

801039c0 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
801039c0:	8b 0d 08 5b 11 80    	mov    0x80115b08,%ecx
801039c6:	85 c9                	test   %ecx,%ecx
801039c8:	0f 8e 8a 00 00 00    	jle    80103a58 <install_trans+0x98>
{
801039ce:	55                   	push   %ebp
801039cf:	89 e5                	mov    %esp,%ebp
801039d1:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
801039d2:	31 ff                	xor    %edi,%edi
{
801039d4:	56                   	push   %esi
801039d5:	53                   	push   %ebx
801039d6:	83 ec 0c             	sub    $0xc,%esp
801039d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
801039e0:	a1 f4 5a 11 80       	mov    0x80115af4,%eax
801039e5:	83 ec 08             	sub    $0x8,%esp
801039e8:	01 f8                	add    %edi,%eax
801039ea:	83 c0 01             	add    $0x1,%eax
801039ed:	50                   	push   %eax
801039ee:	ff 35 04 5b 11 80    	push   0x80115b04
801039f4:	e8 d7 c6 ff ff       	call   801000d0 <bread>
801039f9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
801039fb:	58                   	pop    %eax
801039fc:	5a                   	pop    %edx
801039fd:	ff 34 bd 0c 5b 11 80 	push   -0x7feea4f4(,%edi,4)
80103a04:	ff 35 04 5b 11 80    	push   0x80115b04
  for (tail = 0; tail < log.lh.n; tail++) {
80103a0a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103a0d:	e8 be c6 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103a12:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103a15:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80103a17:	8d 46 5c             	lea    0x5c(%esi),%eax
80103a1a:	68 00 02 00 00       	push   $0x200
80103a1f:	50                   	push   %eax
80103a20:	8d 43 5c             	lea    0x5c(%ebx),%eax
80103a23:	50                   	push   %eax
80103a24:	e8 47 1b 00 00       	call   80105570 <memmove>
    bwrite(dbuf);  // write dst to disk
80103a29:	89 1c 24             	mov    %ebx,(%esp)
80103a2c:	e8 7f c7 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80103a31:	89 34 24             	mov    %esi,(%esp)
80103a34:	e8 b7 c7 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80103a39:	89 1c 24             	mov    %ebx,(%esp)
80103a3c:	e8 af c7 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103a41:	83 c4 10             	add    $0x10,%esp
80103a44:	39 3d 08 5b 11 80    	cmp    %edi,0x80115b08
80103a4a:	7f 94                	jg     801039e0 <install_trans+0x20>
  }
}
80103a4c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a4f:	5b                   	pop    %ebx
80103a50:	5e                   	pop    %esi
80103a51:	5f                   	pop    %edi
80103a52:	5d                   	pop    %ebp
80103a53:	c3                   	ret
80103a54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103a58:	c3                   	ret
80103a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103a60 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80103a60:	55                   	push   %ebp
80103a61:	89 e5                	mov    %esp,%ebp
80103a63:	53                   	push   %ebx
80103a64:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80103a67:	ff 35 f4 5a 11 80    	push   0x80115af4
80103a6d:	ff 35 04 5b 11 80    	push   0x80115b04
80103a73:	e8 58 c6 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80103a78:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80103a7b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80103a7d:	a1 08 5b 11 80       	mov    0x80115b08,%eax
80103a82:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80103a85:	85 c0                	test   %eax,%eax
80103a87:	7e 19                	jle    80103aa2 <write_head+0x42>
80103a89:	31 d2                	xor    %edx,%edx
80103a8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80103a90:	8b 0c 95 0c 5b 11 80 	mov    -0x7feea4f4(,%edx,4),%ecx
80103a97:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80103a9b:	83 c2 01             	add    $0x1,%edx
80103a9e:	39 d0                	cmp    %edx,%eax
80103aa0:	75 ee                	jne    80103a90 <write_head+0x30>
  }
  bwrite(buf);
80103aa2:	83 ec 0c             	sub    $0xc,%esp
80103aa5:	53                   	push   %ebx
80103aa6:	e8 05 c7 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80103aab:	89 1c 24             	mov    %ebx,(%esp)
80103aae:	e8 3d c7 ff ff       	call   801001f0 <brelse>
}
80103ab3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ab6:	83 c4 10             	add    $0x10,%esp
80103ab9:	c9                   	leave
80103aba:	c3                   	ret
80103abb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103ac0 <initlog>:
{
80103ac0:	55                   	push   %ebp
80103ac1:	89 e5                	mov    %esp,%ebp
80103ac3:	53                   	push   %ebx
80103ac4:	83 ec 2c             	sub    $0x2c,%esp
80103ac7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80103aca:	68 20 88 10 80       	push   $0x80108820
80103acf:	68 c0 5a 11 80       	push   $0x80115ac0
80103ad4:	e8 17 17 00 00       	call   801051f0 <initlock>
  readsb(dev, &sb);
80103ad9:	58                   	pop    %eax
80103ada:	8d 45 dc             	lea    -0x24(%ebp),%eax
80103add:	5a                   	pop    %edx
80103ade:	50                   	push   %eax
80103adf:	53                   	push   %ebx
80103ae0:	e8 6b e8 ff ff       	call   80102350 <readsb>
  log.start = sb.logstart;
80103ae5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80103ae8:	59                   	pop    %ecx
  log.dev = dev;
80103ae9:	89 1d 04 5b 11 80    	mov    %ebx,0x80115b04
  log.size = sb.nlog;
80103aef:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80103af2:	a3 f4 5a 11 80       	mov    %eax,0x80115af4
  log.size = sb.nlog;
80103af7:	89 15 f8 5a 11 80    	mov    %edx,0x80115af8
  struct buf *buf = bread(log.dev, log.start);
80103afd:	5a                   	pop    %edx
80103afe:	50                   	push   %eax
80103aff:	53                   	push   %ebx
80103b00:	e8 cb c5 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80103b05:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80103b08:	8b 58 5c             	mov    0x5c(%eax),%ebx
80103b0b:	89 1d 08 5b 11 80    	mov    %ebx,0x80115b08
  for (i = 0; i < log.lh.n; i++) {
80103b11:	85 db                	test   %ebx,%ebx
80103b13:	7e 1d                	jle    80103b32 <initlog+0x72>
80103b15:	31 d2                	xor    %edx,%edx
80103b17:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103b1e:	00 
80103b1f:	90                   	nop
    log.lh.block[i] = lh->block[i];
80103b20:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80103b24:	89 0c 95 0c 5b 11 80 	mov    %ecx,-0x7feea4f4(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80103b2b:	83 c2 01             	add    $0x1,%edx
80103b2e:	39 d3                	cmp    %edx,%ebx
80103b30:	75 ee                	jne    80103b20 <initlog+0x60>
  brelse(buf);
80103b32:	83 ec 0c             	sub    $0xc,%esp
80103b35:	50                   	push   %eax
80103b36:	e8 b5 c6 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80103b3b:	e8 80 fe ff ff       	call   801039c0 <install_trans>
  log.lh.n = 0;
80103b40:	c7 05 08 5b 11 80 00 	movl   $0x0,0x80115b08
80103b47:	00 00 00 
  write_head(); // clear the log
80103b4a:	e8 11 ff ff ff       	call   80103a60 <write_head>
}
80103b4f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b52:	83 c4 10             	add    $0x10,%esp
80103b55:	c9                   	leave
80103b56:	c3                   	ret
80103b57:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103b5e:	00 
80103b5f:	90                   	nop

80103b60 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80103b60:	55                   	push   %ebp
80103b61:	89 e5                	mov    %esp,%ebp
80103b63:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80103b66:	68 c0 5a 11 80       	push   $0x80115ac0
80103b6b:	e8 70 18 00 00       	call   801053e0 <acquire>
80103b70:	83 c4 10             	add    $0x10,%esp
80103b73:	eb 18                	jmp    80103b8d <begin_op+0x2d>
80103b75:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80103b78:	83 ec 08             	sub    $0x8,%esp
80103b7b:	68 c0 5a 11 80       	push   $0x80115ac0
80103b80:	68 c0 5a 11 80       	push   $0x80115ac0
80103b85:	e8 d6 12 00 00       	call   80104e60 <sleep>
80103b8a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80103b8d:	a1 00 5b 11 80       	mov    0x80115b00,%eax
80103b92:	85 c0                	test   %eax,%eax
80103b94:	75 e2                	jne    80103b78 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103b96:	a1 fc 5a 11 80       	mov    0x80115afc,%eax
80103b9b:	8b 15 08 5b 11 80    	mov    0x80115b08,%edx
80103ba1:	83 c0 01             	add    $0x1,%eax
80103ba4:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103ba7:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80103baa:	83 fa 1e             	cmp    $0x1e,%edx
80103bad:	7f c9                	jg     80103b78 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80103baf:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80103bb2:	a3 fc 5a 11 80       	mov    %eax,0x80115afc
      release(&log.lock);
80103bb7:	68 c0 5a 11 80       	push   $0x80115ac0
80103bbc:	e8 bf 17 00 00       	call   80105380 <release>
      break;
    }
  }
}
80103bc1:	83 c4 10             	add    $0x10,%esp
80103bc4:	c9                   	leave
80103bc5:	c3                   	ret
80103bc6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103bcd:	00 
80103bce:	66 90                	xchg   %ax,%ax

80103bd0 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103bd0:	55                   	push   %ebp
80103bd1:	89 e5                	mov    %esp,%ebp
80103bd3:	57                   	push   %edi
80103bd4:	56                   	push   %esi
80103bd5:	53                   	push   %ebx
80103bd6:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103bd9:	68 c0 5a 11 80       	push   $0x80115ac0
80103bde:	e8 fd 17 00 00       	call   801053e0 <acquire>
  log.outstanding -= 1;
80103be3:	a1 fc 5a 11 80       	mov    0x80115afc,%eax
  if(log.committing)
80103be8:	8b 35 00 5b 11 80    	mov    0x80115b00,%esi
80103bee:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103bf1:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103bf4:	89 1d fc 5a 11 80    	mov    %ebx,0x80115afc
  if(log.committing)
80103bfa:	85 f6                	test   %esi,%esi
80103bfc:	0f 85 22 01 00 00    	jne    80103d24 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80103c02:	85 db                	test   %ebx,%ebx
80103c04:	0f 85 f6 00 00 00    	jne    80103d00 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80103c0a:	c7 05 00 5b 11 80 01 	movl   $0x1,0x80115b00
80103c11:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80103c14:	83 ec 0c             	sub    $0xc,%esp
80103c17:	68 c0 5a 11 80       	push   $0x80115ac0
80103c1c:	e8 5f 17 00 00       	call   80105380 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103c21:	8b 0d 08 5b 11 80    	mov    0x80115b08,%ecx
80103c27:	83 c4 10             	add    $0x10,%esp
80103c2a:	85 c9                	test   %ecx,%ecx
80103c2c:	7f 42                	jg     80103c70 <end_op+0xa0>
    acquire(&log.lock);
80103c2e:	83 ec 0c             	sub    $0xc,%esp
80103c31:	68 c0 5a 11 80       	push   $0x80115ac0
80103c36:	e8 a5 17 00 00       	call   801053e0 <acquire>
    log.committing = 0;
80103c3b:	c7 05 00 5b 11 80 00 	movl   $0x0,0x80115b00
80103c42:	00 00 00 
    wakeup(&log);
80103c45:	c7 04 24 c0 5a 11 80 	movl   $0x80115ac0,(%esp)
80103c4c:	e8 cf 12 00 00       	call   80104f20 <wakeup>
    release(&log.lock);
80103c51:	c7 04 24 c0 5a 11 80 	movl   $0x80115ac0,(%esp)
80103c58:	e8 23 17 00 00       	call   80105380 <release>
80103c5d:	83 c4 10             	add    $0x10,%esp
}
80103c60:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103c63:	5b                   	pop    %ebx
80103c64:	5e                   	pop    %esi
80103c65:	5f                   	pop    %edi
80103c66:	5d                   	pop    %ebp
80103c67:	c3                   	ret
80103c68:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103c6f:	00 
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103c70:	a1 f4 5a 11 80       	mov    0x80115af4,%eax
80103c75:	83 ec 08             	sub    $0x8,%esp
80103c78:	01 d8                	add    %ebx,%eax
80103c7a:	83 c0 01             	add    $0x1,%eax
80103c7d:	50                   	push   %eax
80103c7e:	ff 35 04 5b 11 80    	push   0x80115b04
80103c84:	e8 47 c4 ff ff       	call   801000d0 <bread>
80103c89:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103c8b:	58                   	pop    %eax
80103c8c:	5a                   	pop    %edx
80103c8d:	ff 34 9d 0c 5b 11 80 	push   -0x7feea4f4(,%ebx,4)
80103c94:	ff 35 04 5b 11 80    	push   0x80115b04
  for (tail = 0; tail < log.lh.n; tail++) {
80103c9a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103c9d:	e8 2e c4 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103ca2:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103ca5:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103ca7:	8d 40 5c             	lea    0x5c(%eax),%eax
80103caa:	68 00 02 00 00       	push   $0x200
80103caf:	50                   	push   %eax
80103cb0:	8d 46 5c             	lea    0x5c(%esi),%eax
80103cb3:	50                   	push   %eax
80103cb4:	e8 b7 18 00 00       	call   80105570 <memmove>
    bwrite(to);  // write the log
80103cb9:	89 34 24             	mov    %esi,(%esp)
80103cbc:	e8 ef c4 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103cc1:	89 3c 24             	mov    %edi,(%esp)
80103cc4:	e8 27 c5 ff ff       	call   801001f0 <brelse>
    brelse(to);
80103cc9:	89 34 24             	mov    %esi,(%esp)
80103ccc:	e8 1f c5 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103cd1:	83 c4 10             	add    $0x10,%esp
80103cd4:	3b 1d 08 5b 11 80    	cmp    0x80115b08,%ebx
80103cda:	7c 94                	jl     80103c70 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80103cdc:	e8 7f fd ff ff       	call   80103a60 <write_head>
    install_trans(); // Now install writes to home locations
80103ce1:	e8 da fc ff ff       	call   801039c0 <install_trans>
    log.lh.n = 0;
80103ce6:	c7 05 08 5b 11 80 00 	movl   $0x0,0x80115b08
80103ced:	00 00 00 
    write_head();    // Erase the transaction from the log
80103cf0:	e8 6b fd ff ff       	call   80103a60 <write_head>
80103cf5:	e9 34 ff ff ff       	jmp    80103c2e <end_op+0x5e>
80103cfa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80103d00:	83 ec 0c             	sub    $0xc,%esp
80103d03:	68 c0 5a 11 80       	push   $0x80115ac0
80103d08:	e8 13 12 00 00       	call   80104f20 <wakeup>
  release(&log.lock);
80103d0d:	c7 04 24 c0 5a 11 80 	movl   $0x80115ac0,(%esp)
80103d14:	e8 67 16 00 00       	call   80105380 <release>
80103d19:	83 c4 10             	add    $0x10,%esp
}
80103d1c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103d1f:	5b                   	pop    %ebx
80103d20:	5e                   	pop    %esi
80103d21:	5f                   	pop    %edi
80103d22:	5d                   	pop    %ebp
80103d23:	c3                   	ret
    panic("log.committing");
80103d24:	83 ec 0c             	sub    $0xc,%esp
80103d27:	68 24 88 10 80       	push   $0x80108824
80103d2c:	e8 6f c6 ff ff       	call   801003a0 <panic>
80103d31:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103d38:	00 
80103d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103d40 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103d40:	55                   	push   %ebp
80103d41:	89 e5                	mov    %esp,%ebp
80103d43:	53                   	push   %ebx
80103d44:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103d47:	8b 15 08 5b 11 80    	mov    0x80115b08,%edx
{
80103d4d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103d50:	83 fa 1d             	cmp    $0x1d,%edx
80103d53:	7f 7d                	jg     80103dd2 <log_write+0x92>
80103d55:	a1 f8 5a 11 80       	mov    0x80115af8,%eax
80103d5a:	83 e8 01             	sub    $0x1,%eax
80103d5d:	39 c2                	cmp    %eax,%edx
80103d5f:	7d 71                	jge    80103dd2 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103d61:	a1 fc 5a 11 80       	mov    0x80115afc,%eax
80103d66:	85 c0                	test   %eax,%eax
80103d68:	7e 75                	jle    80103ddf <log_write+0x9f>
    panic("log_write outside of trans");

  acquire(&log.lock);
80103d6a:	83 ec 0c             	sub    $0xc,%esp
80103d6d:	68 c0 5a 11 80       	push   $0x80115ac0
80103d72:	e8 69 16 00 00       	call   801053e0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103d77:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
80103d7a:	83 c4 10             	add    $0x10,%esp
80103d7d:	31 c0                	xor    %eax,%eax
80103d7f:	8b 15 08 5b 11 80    	mov    0x80115b08,%edx
80103d85:	85 d2                	test   %edx,%edx
80103d87:	7f 0e                	jg     80103d97 <log_write+0x57>
80103d89:	eb 15                	jmp    80103da0 <log_write+0x60>
80103d8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103d90:	83 c0 01             	add    $0x1,%eax
80103d93:	39 c2                	cmp    %eax,%edx
80103d95:	74 29                	je     80103dc0 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103d97:	39 0c 85 0c 5b 11 80 	cmp    %ecx,-0x7feea4f4(,%eax,4)
80103d9e:	75 f0                	jne    80103d90 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80103da0:	89 0c 85 0c 5b 11 80 	mov    %ecx,-0x7feea4f4(,%eax,4)
  if (i == log.lh.n)
80103da7:	39 c2                	cmp    %eax,%edx
80103da9:	74 1c                	je     80103dc7 <log_write+0x87>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
80103dab:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
80103dae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80103db1:	c7 45 08 c0 5a 11 80 	movl   $0x80115ac0,0x8(%ebp)
}
80103db8:	c9                   	leave
  release(&log.lock);
80103db9:	e9 c2 15 00 00       	jmp    80105380 <release>
80103dbe:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno;
80103dc0:	89 0c 95 0c 5b 11 80 	mov    %ecx,-0x7feea4f4(,%edx,4)
    log.lh.n++;
80103dc7:	83 c2 01             	add    $0x1,%edx
80103dca:	89 15 08 5b 11 80    	mov    %edx,0x80115b08
80103dd0:	eb d9                	jmp    80103dab <log_write+0x6b>
    panic("too big a transaction");
80103dd2:	83 ec 0c             	sub    $0xc,%esp
80103dd5:	68 33 88 10 80       	push   $0x80108833
80103dda:	e8 c1 c5 ff ff       	call   801003a0 <panic>
    panic("log_write outside of trans");
80103ddf:	83 ec 0c             	sub    $0xc,%esp
80103de2:	68 49 88 10 80       	push   $0x80108849
80103de7:	e8 b4 c5 ff ff       	call   801003a0 <panic>
80103dec:	66 90                	xchg   %ax,%ax
80103dee:	66 90                	xchg   %ax,%ax

80103df0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103df0:	55                   	push   %ebp
80103df1:	89 e5                	mov    %esp,%ebp
80103df3:	53                   	push   %ebx
80103df4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103df7:	e8 74 09 00 00       	call   80104770 <cpuid>
80103dfc:	89 c3                	mov    %eax,%ebx
80103dfe:	e8 6d 09 00 00       	call   80104770 <cpuid>
80103e03:	83 ec 04             	sub    $0x4,%esp
80103e06:	53                   	push   %ebx
80103e07:	50                   	push   %eax
80103e08:	68 64 88 10 80       	push   $0x80108864
80103e0d:	e8 2e ce ff ff       	call   80100c40 <cprintf>
  idtinit();       // load idt register
80103e12:	e8 59 2f 00 00       	call   80106d70 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103e17:	e8 f4 08 00 00       	call   80104710 <mycpu>
80103e1c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103e1e:	b8 01 00 00 00       	mov    $0x1,%eax
80103e23:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80103e2a:	e8 21 0c 00 00       	call   80104a50 <scheduler>
80103e2f:	90                   	nop

80103e30 <mpenter>:
{
80103e30:	55                   	push   %ebp
80103e31:	89 e5                	mov    %esp,%ebp
80103e33:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103e36:	e8 35 40 00 00       	call   80107e70 <switchkvm>
  seginit();
80103e3b:	e8 a0 3f 00 00       	call   80107de0 <seginit>
  lapicinit();
80103e40:	e8 bb f7 ff ff       	call   80103600 <lapicinit>
  mpmain();
80103e45:	e8 a6 ff ff ff       	call   80103df0 <mpmain>
80103e4a:	66 90                	xchg   %ax,%ax
80103e4c:	66 90                	xchg   %ax,%ax
80103e4e:	66 90                	xchg   %ax,%ax

80103e50 <main>:
{
80103e50:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103e54:	83 e4 f0             	and    $0xfffffff0,%esp
80103e57:	ff 71 fc             	push   -0x4(%ecx)
80103e5a:	55                   	push   %ebp
80103e5b:	89 e5                	mov    %esp,%ebp
80103e5d:	53                   	push   %ebx
80103e5e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80103e5f:	83 ec 08             	sub    $0x8,%esp
80103e62:	68 00 00 40 80       	push   $0x80400000
80103e67:	68 f0 99 11 80       	push   $0x801199f0
80103e6c:	e8 8f f5 ff ff       	call   80103400 <kinit1>
  kvmalloc();      // kernel page table
80103e71:	e8 ba 44 00 00       	call   80108330 <kvmalloc>
  mpinit();        // detect other processors
80103e76:	e8 85 01 00 00       	call   80104000 <mpinit>
  lapicinit();     // interrupt controller
80103e7b:	e8 80 f7 ff ff       	call   80103600 <lapicinit>
  seginit();       // segment descriptors
80103e80:	e8 5b 3f 00 00       	call   80107de0 <seginit>
  picinit();       // disable pic
80103e85:	e8 86 03 00 00       	call   80104210 <picinit>
  ioapicinit();    // another interrupt controller
80103e8a:	e8 41 f3 ff ff       	call   801031d0 <ioapicinit>
  consoleinit();   // console hardware
80103e8f:	e8 4c d4 ff ff       	call   801012e0 <consoleinit>
  uartinit();      // serial port
80103e94:	e8 b7 31 00 00       	call   80107050 <uartinit>
  pinit();         // process table
80103e99:	e8 52 08 00 00       	call   801046f0 <pinit>
  tvinit();        // trap vectors
80103e9e:	e8 4d 2e 00 00       	call   80106cf0 <tvinit>
  binit();         // buffer cache
80103ea3:	e8 98 c1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103ea8:	e8 03 d8 ff ff       	call   801016b0 <fileinit>
  ideinit();       // disk 
80103ead:	e8 fe f0 ff ff       	call   80102fb0 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103eb2:	83 c4 0c             	add    $0xc,%esp
80103eb5:	68 8a 00 00 00       	push   $0x8a
80103eba:	68 8c c4 10 80       	push   $0x8010c48c
80103ebf:	68 00 70 00 80       	push   $0x80007000
80103ec4:	e8 a7 16 00 00       	call   80105570 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103ec9:	83 c4 10             	add    $0x10,%esp
80103ecc:	69 05 a4 5b 11 80 b0 	imul   $0xb0,0x80115ba4,%eax
80103ed3:	00 00 00 
80103ed6:	05 c0 5b 11 80       	add    $0x80115bc0,%eax
80103edb:	3d c0 5b 11 80       	cmp    $0x80115bc0,%eax
80103ee0:	76 7e                	jbe    80103f60 <main+0x110>
80103ee2:	bb c0 5b 11 80       	mov    $0x80115bc0,%ebx
80103ee7:	eb 20                	jmp    80103f09 <main+0xb9>
80103ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ef0:	69 05 a4 5b 11 80 b0 	imul   $0xb0,0x80115ba4,%eax
80103ef7:	00 00 00 
80103efa:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103f00:	05 c0 5b 11 80       	add    $0x80115bc0,%eax
80103f05:	39 c3                	cmp    %eax,%ebx
80103f07:	73 57                	jae    80103f60 <main+0x110>
    if(c == mycpu())  // We've started already.
80103f09:	e8 02 08 00 00       	call   80104710 <mycpu>
80103f0e:	39 c3                	cmp    %eax,%ebx
80103f10:	74 de                	je     80103ef0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103f12:	e8 59 f5 ff ff       	call   80103470 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103f17:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
80103f1a:	c7 05 f8 6f 00 80 30 	movl   $0x80103e30,0x80006ff8
80103f21:	3e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103f24:	c7 05 f4 6f 00 80 00 	movl   $0x10b000,0x80006ff4
80103f2b:	b0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80103f2e:	05 00 10 00 00       	add    $0x1000,%eax
80103f33:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103f38:	0f b6 03             	movzbl (%ebx),%eax
80103f3b:	68 00 70 00 00       	push   $0x7000
80103f40:	50                   	push   %eax
80103f41:	e8 fa f7 ff ff       	call   80103740 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103f46:	83 c4 10             	add    $0x10,%esp
80103f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103f50:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103f56:	85 c0                	test   %eax,%eax
80103f58:	74 f6                	je     80103f50 <main+0x100>
80103f5a:	eb 94                	jmp    80103ef0 <main+0xa0>
80103f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103f60:	83 ec 08             	sub    $0x8,%esp
80103f63:	68 00 00 00 8e       	push   $0x8e000000
80103f68:	68 00 00 40 80       	push   $0x80400000
80103f6d:	e8 2e f4 ff ff       	call   801033a0 <kinit2>
  userinit();      // first user process
80103f72:	e8 49 08 00 00       	call   801047c0 <userinit>
  mpmain();        // finish this processor's setup
80103f77:	e8 74 fe ff ff       	call   80103df0 <mpmain>
80103f7c:	66 90                	xchg   %ax,%ax
80103f7e:	66 90                	xchg   %ax,%ax

80103f80 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103f80:	55                   	push   %ebp
80103f81:	89 e5                	mov    %esp,%ebp
80103f83:	57                   	push   %edi
80103f84:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103f85:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80103f8b:	53                   	push   %ebx
  e = addr+len;
80103f8c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80103f8f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103f92:	39 de                	cmp    %ebx,%esi
80103f94:	72 10                	jb     80103fa6 <mpsearch1+0x26>
80103f96:	eb 50                	jmp    80103fe8 <mpsearch1+0x68>
80103f98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f9f:	00 
80103fa0:	89 fe                	mov    %edi,%esi
80103fa2:	39 df                	cmp    %ebx,%edi
80103fa4:	73 42                	jae    80103fe8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103fa6:	83 ec 04             	sub    $0x4,%esp
80103fa9:	8d 7e 10             	lea    0x10(%esi),%edi
80103fac:	6a 04                	push   $0x4
80103fae:	68 78 88 10 80       	push   $0x80108878
80103fb3:	56                   	push   %esi
80103fb4:	e8 67 15 00 00       	call   80105520 <memcmp>
80103fb9:	83 c4 10             	add    $0x10,%esp
80103fbc:	85 c0                	test   %eax,%eax
80103fbe:	75 e0                	jne    80103fa0 <mpsearch1+0x20>
80103fc0:	89 f2                	mov    %esi,%edx
80103fc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103fc8:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103fcb:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103fce:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103fd0:	39 fa                	cmp    %edi,%edx
80103fd2:	75 f4                	jne    80103fc8 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103fd4:	84 c0                	test   %al,%al
80103fd6:	75 c8                	jne    80103fa0 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103fd8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103fdb:	89 f0                	mov    %esi,%eax
80103fdd:	5b                   	pop    %ebx
80103fde:	5e                   	pop    %esi
80103fdf:	5f                   	pop    %edi
80103fe0:	5d                   	pop    %ebp
80103fe1:	c3                   	ret
80103fe2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103fe8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80103feb:	31 f6                	xor    %esi,%esi
}
80103fed:	5b                   	pop    %ebx
80103fee:	89 f0                	mov    %esi,%eax
80103ff0:	5e                   	pop    %esi
80103ff1:	5f                   	pop    %edi
80103ff2:	5d                   	pop    %ebp
80103ff3:	c3                   	ret
80103ff4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103ffb:	00 
80103ffc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104000 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80104000:	55                   	push   %ebp
80104001:	89 e5                	mov    %esp,%ebp
80104003:	57                   	push   %edi
80104004:	56                   	push   %esi
80104005:	53                   	push   %ebx
80104006:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80104009:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80104010:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80104017:	c1 e0 08             	shl    $0x8,%eax
8010401a:	09 d0                	or     %edx,%eax
8010401c:	c1 e0 04             	shl    $0x4,%eax
8010401f:	75 1b                	jne    8010403c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80104021:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80104028:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010402f:	c1 e0 08             	shl    $0x8,%eax
80104032:	09 d0                	or     %edx,%eax
80104034:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80104037:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010403c:	ba 00 04 00 00       	mov    $0x400,%edx
80104041:	e8 3a ff ff ff       	call   80103f80 <mpsearch1>
80104046:	89 c3                	mov    %eax,%ebx
80104048:	85 c0                	test   %eax,%eax
8010404a:	0f 84 58 01 00 00    	je     801041a8 <mpinit+0x1a8>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80104050:	8b 73 04             	mov    0x4(%ebx),%esi
80104053:	85 f6                	test   %esi,%esi
80104055:	0f 84 3d 01 00 00    	je     80104198 <mpinit+0x198>
  if(memcmp(conf, "PCMP", 4) != 0)
8010405b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010405e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80104064:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80104067:	6a 04                	push   $0x4
80104069:	68 7d 88 10 80       	push   $0x8010887d
8010406e:	50                   	push   %eax
8010406f:	e8 ac 14 00 00       	call   80105520 <memcmp>
80104074:	83 c4 10             	add    $0x10,%esp
80104077:	85 c0                	test   %eax,%eax
80104079:	0f 85 19 01 00 00    	jne    80104198 <mpinit+0x198>
  if(conf->version != 1 && conf->version != 4)
8010407f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80104086:	3c 01                	cmp    $0x1,%al
80104088:	74 08                	je     80104092 <mpinit+0x92>
8010408a:	3c 04                	cmp    $0x4,%al
8010408c:	0f 85 06 01 00 00    	jne    80104198 <mpinit+0x198>
  if(sum((uchar*)conf, conf->length) != 0)
80104092:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80104099:	66 85 d2             	test   %dx,%dx
8010409c:	74 22                	je     801040c0 <mpinit+0xc0>
8010409e:	8d 3c 32             	lea    (%edx,%esi,1),%edi
801040a1:	89 f0                	mov    %esi,%eax
  sum = 0;
801040a3:	31 d2                	xor    %edx,%edx
801040a5:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
801040a8:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
801040af:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
801040b2:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
801040b4:	39 f8                	cmp    %edi,%eax
801040b6:	75 f0                	jne    801040a8 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
801040b8:	84 d2                	test   %dl,%dl
801040ba:	0f 85 d8 00 00 00    	jne    80104198 <mpinit+0x198>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
801040c0:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801040c6:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801040c9:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  lapic = (uint*)conf->lapicaddr;
801040cc:	a3 a0 5a 11 80       	mov    %eax,0x80115aa0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801040d1:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
801040d8:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
801040de:	01 d7                	add    %edx,%edi
801040e0:	89 fa                	mov    %edi,%edx
  ismp = 1;
801040e2:	bf 01 00 00 00       	mov    $0x1,%edi
801040e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801040ee:	00 
801040ef:	90                   	nop
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801040f0:	39 d0                	cmp    %edx,%eax
801040f2:	73 19                	jae    8010410d <mpinit+0x10d>
    switch(*p){
801040f4:	0f b6 08             	movzbl (%eax),%ecx
801040f7:	80 f9 02             	cmp    $0x2,%cl
801040fa:	0f 84 80 00 00 00    	je     80104180 <mpinit+0x180>
80104100:	77 6e                	ja     80104170 <mpinit+0x170>
80104102:	84 c9                	test   %cl,%cl
80104104:	74 3a                	je     80104140 <mpinit+0x140>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80104106:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80104109:	39 d0                	cmp    %edx,%eax
8010410b:	72 e7                	jb     801040f4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
8010410d:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80104110:	85 ff                	test   %edi,%edi
80104112:	0f 84 dd 00 00 00    	je     801041f5 <mpinit+0x1f5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80104118:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
8010411c:	74 15                	je     80104133 <mpinit+0x133>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010411e:	b8 70 00 00 00       	mov    $0x70,%eax
80104123:	ba 22 00 00 00       	mov    $0x22,%edx
80104128:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80104129:	ba 23 00 00 00       	mov    $0x23,%edx
8010412e:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
8010412f:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80104132:	ee                   	out    %al,(%dx)
  }
}
80104133:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104136:	5b                   	pop    %ebx
80104137:	5e                   	pop    %esi
80104138:	5f                   	pop    %edi
80104139:	5d                   	pop    %ebp
8010413a:	c3                   	ret
8010413b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
80104140:	8b 0d a4 5b 11 80    	mov    0x80115ba4,%ecx
80104146:	83 f9 07             	cmp    $0x7,%ecx
80104149:	7f 19                	jg     80104164 <mpinit+0x164>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010414b:	69 f1 b0 00 00 00    	imul   $0xb0,%ecx,%esi
80104151:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80104155:	83 c1 01             	add    $0x1,%ecx
80104158:	89 0d a4 5b 11 80    	mov    %ecx,0x80115ba4
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010415e:	88 9e c0 5b 11 80    	mov    %bl,-0x7feea440(%esi)
      p += sizeof(struct mpproc);
80104164:	83 c0 14             	add    $0x14,%eax
      continue;
80104167:	eb 87                	jmp    801040f0 <mpinit+0xf0>
80104169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(*p){
80104170:	83 e9 03             	sub    $0x3,%ecx
80104173:	80 f9 01             	cmp    $0x1,%cl
80104176:	76 8e                	jbe    80104106 <mpinit+0x106>
80104178:	31 ff                	xor    %edi,%edi
8010417a:	e9 71 ff ff ff       	jmp    801040f0 <mpinit+0xf0>
8010417f:	90                   	nop
      ioapicid = ioapic->apicno;
80104180:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80104184:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80104187:	88 0d a0 5b 11 80    	mov    %cl,0x80115ba0
      continue;
8010418d:	e9 5e ff ff ff       	jmp    801040f0 <mpinit+0xf0>
80104192:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80104198:	83 ec 0c             	sub    $0xc,%esp
8010419b:	68 82 88 10 80       	push   $0x80108882
801041a0:	e8 fb c1 ff ff       	call   801003a0 <panic>
801041a5:	8d 76 00             	lea    0x0(%esi),%esi
{
801041a8:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
801041ad:	eb 0b                	jmp    801041ba <mpinit+0x1ba>
801041af:	90                   	nop
  for(p = addr; p < e; p += sizeof(struct mp))
801041b0:	89 f3                	mov    %esi,%ebx
801041b2:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
801041b8:	74 de                	je     80104198 <mpinit+0x198>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801041ba:	83 ec 04             	sub    $0x4,%esp
801041bd:	8d 73 10             	lea    0x10(%ebx),%esi
801041c0:	6a 04                	push   $0x4
801041c2:	68 78 88 10 80       	push   $0x80108878
801041c7:	53                   	push   %ebx
801041c8:	e8 53 13 00 00       	call   80105520 <memcmp>
801041cd:	83 c4 10             	add    $0x10,%esp
801041d0:	85 c0                	test   %eax,%eax
801041d2:	75 dc                	jne    801041b0 <mpinit+0x1b0>
801041d4:	89 da                	mov    %ebx,%edx
801041d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801041dd:	00 
801041de:	66 90                	xchg   %ax,%ax
    sum += addr[i];
801041e0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801041e3:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801041e6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801041e8:	39 d6                	cmp    %edx,%esi
801041ea:	75 f4                	jne    801041e0 <mpinit+0x1e0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801041ec:	84 c0                	test   %al,%al
801041ee:	75 c0                	jne    801041b0 <mpinit+0x1b0>
801041f0:	e9 5b fe ff ff       	jmp    80104050 <mpinit+0x50>
    panic("Didn't find a suitable machine");
801041f5:	83 ec 0c             	sub    $0xc,%esp
801041f8:	68 a4 8c 10 80       	push   $0x80108ca4
801041fd:	e8 9e c1 ff ff       	call   801003a0 <panic>
80104202:	66 90                	xchg   %ax,%ax
80104204:	66 90                	xchg   %ax,%ax
80104206:	66 90                	xchg   %ax,%ax
80104208:	66 90                	xchg   %ax,%ax
8010420a:	66 90                	xchg   %ax,%ax
8010420c:	66 90                	xchg   %ax,%ax
8010420e:	66 90                	xchg   %ax,%ax

80104210 <picinit>:
80104210:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104215:	ba 21 00 00 00       	mov    $0x21,%edx
8010421a:	ee                   	out    %al,(%dx)
8010421b:	ba a1 00 00 00       	mov    $0xa1,%edx
80104220:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80104221:	c3                   	ret
80104222:	66 90                	xchg   %ax,%ax
80104224:	66 90                	xchg   %ax,%ax
80104226:	66 90                	xchg   %ax,%ax
80104228:	66 90                	xchg   %ax,%ax
8010422a:	66 90                	xchg   %ax,%ax
8010422c:	66 90                	xchg   %ax,%ax
8010422e:	66 90                	xchg   %ax,%ax

80104230 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80104230:	55                   	push   %ebp
80104231:	89 e5                	mov    %esp,%ebp
80104233:	57                   	push   %edi
80104234:	56                   	push   %esi
80104235:	53                   	push   %ebx
80104236:	83 ec 0c             	sub    $0xc,%esp
80104239:	8b 75 08             	mov    0x8(%ebp),%esi
8010423c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010423f:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80104245:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010424b:	e8 80 d4 ff ff       	call   801016d0 <filealloc>
80104250:	89 06                	mov    %eax,(%esi)
80104252:	85 c0                	test   %eax,%eax
80104254:	0f 84 a5 00 00 00    	je     801042ff <pipealloc+0xcf>
8010425a:	e8 71 d4 ff ff       	call   801016d0 <filealloc>
8010425f:	89 07                	mov    %eax,(%edi)
80104261:	85 c0                	test   %eax,%eax
80104263:	0f 84 84 00 00 00    	je     801042ed <pipealloc+0xbd>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80104269:	e8 02 f2 ff ff       	call   80103470 <kalloc>
8010426e:	89 c3                	mov    %eax,%ebx
80104270:	85 c0                	test   %eax,%eax
80104272:	0f 84 a0 00 00 00    	je     80104318 <pipealloc+0xe8>
    goto bad;
  p->readopen = 1;
80104278:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010427f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80104282:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80104285:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010428c:	00 00 00 
  p->nwrite = 0;
8010428f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80104296:	00 00 00 
  p->nread = 0;
80104299:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
801042a0:	00 00 00 
  initlock(&p->lock, "pipe");
801042a3:	68 9a 88 10 80       	push   $0x8010889a
801042a8:	50                   	push   %eax
801042a9:	e8 42 0f 00 00       	call   801051f0 <initlock>
  (*f0)->type = FD_PIPE;
801042ae:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
801042b0:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
801042b3:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
801042b9:	8b 06                	mov    (%esi),%eax
801042bb:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
801042bf:	8b 06                	mov    (%esi),%eax
801042c1:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
801042c5:	8b 06                	mov    (%esi),%eax
801042c7:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
801042ca:	8b 07                	mov    (%edi),%eax
801042cc:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
801042d2:	8b 07                	mov    (%edi),%eax
801042d4:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
801042d8:	8b 07                	mov    (%edi),%eax
801042da:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
801042de:	8b 07                	mov    (%edi),%eax
801042e0:	89 58 0c             	mov    %ebx,0xc(%eax)
  return 0;
801042e3:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801042e5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801042e8:	5b                   	pop    %ebx
801042e9:	5e                   	pop    %esi
801042ea:	5f                   	pop    %edi
801042eb:	5d                   	pop    %ebp
801042ec:	c3                   	ret
  if(*f0)
801042ed:	8b 06                	mov    (%esi),%eax
801042ef:	85 c0                	test   %eax,%eax
801042f1:	74 1e                	je     80104311 <pipealloc+0xe1>
    fileclose(*f0);
801042f3:	83 ec 0c             	sub    $0xc,%esp
801042f6:	50                   	push   %eax
801042f7:	e8 94 d4 ff ff       	call   80101790 <fileclose>
801042fc:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801042ff:	8b 07                	mov    (%edi),%eax
80104301:	85 c0                	test   %eax,%eax
80104303:	74 0c                	je     80104311 <pipealloc+0xe1>
    fileclose(*f1);
80104305:	83 ec 0c             	sub    $0xc,%esp
80104308:	50                   	push   %eax
80104309:	e8 82 d4 ff ff       	call   80101790 <fileclose>
8010430e:	83 c4 10             	add    $0x10,%esp
  return -1;
80104311:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104316:	eb cd                	jmp    801042e5 <pipealloc+0xb5>
  if(*f0)
80104318:	8b 06                	mov    (%esi),%eax
8010431a:	85 c0                	test   %eax,%eax
8010431c:	75 d5                	jne    801042f3 <pipealloc+0xc3>
8010431e:	eb df                	jmp    801042ff <pipealloc+0xcf>

80104320 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80104320:	55                   	push   %ebp
80104321:	89 e5                	mov    %esp,%ebp
80104323:	56                   	push   %esi
80104324:	53                   	push   %ebx
80104325:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104328:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010432b:	83 ec 0c             	sub    $0xc,%esp
8010432e:	53                   	push   %ebx
8010432f:	e8 ac 10 00 00       	call   801053e0 <acquire>
  if(writable){
80104334:	83 c4 10             	add    $0x10,%esp
80104337:	85 f6                	test   %esi,%esi
80104339:	74 65                	je     801043a0 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010433b:	83 ec 0c             	sub    $0xc,%esp
8010433e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80104344:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010434b:	00 00 00 
    wakeup(&p->nread);
8010434e:	50                   	push   %eax
8010434f:	e8 cc 0b 00 00       	call   80104f20 <wakeup>
80104354:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80104357:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010435d:	85 d2                	test   %edx,%edx
8010435f:	75 0a                	jne    8010436b <pipeclose+0x4b>
80104361:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80104367:	85 c0                	test   %eax,%eax
80104369:	74 15                	je     80104380 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010436b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010436e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104371:	5b                   	pop    %ebx
80104372:	5e                   	pop    %esi
80104373:	5d                   	pop    %ebp
    release(&p->lock);
80104374:	e9 07 10 00 00       	jmp    80105380 <release>
80104379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80104380:	83 ec 0c             	sub    $0xc,%esp
80104383:	53                   	push   %ebx
80104384:	e8 f7 0f 00 00       	call   80105380 <release>
    kfree((char*)p);
80104389:	83 c4 10             	add    $0x10,%esp
8010438c:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010438f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104392:	5b                   	pop    %ebx
80104393:	5e                   	pop    %esi
80104394:	5d                   	pop    %ebp
    kfree((char*)p);
80104395:	e9 16 ef ff ff       	jmp    801032b0 <kfree>
8010439a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
801043a0:	83 ec 0c             	sub    $0xc,%esp
801043a3:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
801043a9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801043b0:	00 00 00 
    wakeup(&p->nwrite);
801043b3:	50                   	push   %eax
801043b4:	e8 67 0b 00 00       	call   80104f20 <wakeup>
801043b9:	83 c4 10             	add    $0x10,%esp
801043bc:	eb 99                	jmp    80104357 <pipeclose+0x37>
801043be:	66 90                	xchg   %ax,%ax

801043c0 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	57                   	push   %edi
801043c4:	56                   	push   %esi
801043c5:	53                   	push   %ebx
801043c6:	83 ec 28             	sub    $0x28,%esp
801043c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801043cc:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
801043cf:	53                   	push   %ebx
801043d0:	e8 0b 10 00 00       	call   801053e0 <acquire>
  for(i = 0; i < n; i++){
801043d5:	83 c4 10             	add    $0x10,%esp
801043d8:	85 ff                	test   %edi,%edi
801043da:	0f 8e ce 00 00 00    	jle    801044ae <pipewrite+0xee>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801043e0:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801043e6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801043e9:	89 7d 10             	mov    %edi,0x10(%ebp)
801043ec:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801043ef:	8d 34 39             	lea    (%ecx,%edi,1),%esi
801043f2:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801043f5:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801043fb:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80104401:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104407:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
8010440d:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
80104410:	0f 85 b6 00 00 00    	jne    801044cc <pipewrite+0x10c>
80104416:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80104419:	eb 3b                	jmp    80104456 <pipewrite+0x96>
8010441b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80104420:	e8 6b 03 00 00       	call   80104790 <myproc>
80104425:	8b 48 24             	mov    0x24(%eax),%ecx
80104428:	85 c9                	test   %ecx,%ecx
8010442a:	75 34                	jne    80104460 <pipewrite+0xa0>
      wakeup(&p->nread);
8010442c:	83 ec 0c             	sub    $0xc,%esp
8010442f:	56                   	push   %esi
80104430:	e8 eb 0a 00 00       	call   80104f20 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80104435:	58                   	pop    %eax
80104436:	5a                   	pop    %edx
80104437:	53                   	push   %ebx
80104438:	57                   	push   %edi
80104439:	e8 22 0a 00 00       	call   80104e60 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010443e:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80104444:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010444a:	83 c4 10             	add    $0x10,%esp
8010444d:	05 00 02 00 00       	add    $0x200,%eax
80104452:	39 c2                	cmp    %eax,%edx
80104454:	75 2a                	jne    80104480 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
80104456:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010445c:	85 c0                	test   %eax,%eax
8010445e:	75 c0                	jne    80104420 <pipewrite+0x60>
        release(&p->lock);
80104460:	83 ec 0c             	sub    $0xc,%esp
80104463:	53                   	push   %ebx
80104464:	e8 17 0f 00 00       	call   80105380 <release>
        return -1;
80104469:	83 c4 10             	add    $0x10,%esp
8010446c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80104471:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104474:	5b                   	pop    %ebx
80104475:	5e                   	pop    %esi
80104476:	5f                   	pop    %edi
80104477:	5d                   	pop    %ebp
80104478:	c3                   	ret
80104479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104480:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80104483:	8d 42 01             	lea    0x1(%edx),%eax
80104486:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  for(i = 0; i < n; i++){
8010448c:	83 c1 01             	add    $0x1,%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010448f:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80104495:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104498:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
8010449c:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801044a0:	8b 45 e0             	mov    -0x20(%ebp),%eax
801044a3:	39 c1                	cmp    %eax,%ecx
801044a5:	0f 85 50 ff ff ff    	jne    801043fb <pipewrite+0x3b>
801044ab:	8b 7d 10             	mov    0x10(%ebp),%edi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801044ae:	83 ec 0c             	sub    $0xc,%esp
801044b1:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801044b7:	50                   	push   %eax
801044b8:	e8 63 0a 00 00       	call   80104f20 <wakeup>
  release(&p->lock);
801044bd:	89 1c 24             	mov    %ebx,(%esp)
801044c0:	e8 bb 0e 00 00       	call   80105380 <release>
  return n;
801044c5:	83 c4 10             	add    $0x10,%esp
801044c8:	89 f8                	mov    %edi,%eax
801044ca:	eb a5                	jmp    80104471 <pipewrite+0xb1>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801044cc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801044cf:	eb b2                	jmp    80104483 <pipewrite+0xc3>
801044d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801044d8:	00 
801044d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801044e0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801044e0:	55                   	push   %ebp
801044e1:	89 e5                	mov    %esp,%ebp
801044e3:	57                   	push   %edi
801044e4:	56                   	push   %esi
801044e5:	53                   	push   %ebx
801044e6:	83 ec 18             	sub    $0x18,%esp
801044e9:	8b 75 08             	mov    0x8(%ebp),%esi
801044ec:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801044ef:	56                   	push   %esi
801044f0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801044f6:	e8 e5 0e 00 00       	call   801053e0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801044fb:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80104501:	83 c4 10             	add    $0x10,%esp
80104504:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010450a:	74 2f                	je     8010453b <piperead+0x5b>
8010450c:	eb 37                	jmp    80104545 <piperead+0x65>
8010450e:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80104510:	e8 7b 02 00 00       	call   80104790 <myproc>
80104515:	8b 40 24             	mov    0x24(%eax),%eax
80104518:	85 c0                	test   %eax,%eax
8010451a:	0f 85 80 00 00 00    	jne    801045a0 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80104520:	83 ec 08             	sub    $0x8,%esp
80104523:	56                   	push   %esi
80104524:	53                   	push   %ebx
80104525:	e8 36 09 00 00       	call   80104e60 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010452a:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80104530:	83 c4 10             	add    $0x10,%esp
80104533:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80104539:	75 0a                	jne    80104545 <piperead+0x65>
8010453b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80104541:	85 d2                	test   %edx,%edx
80104543:	75 cb                	jne    80104510 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104545:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104548:	31 db                	xor    %ebx,%ebx
8010454a:	85 c9                	test   %ecx,%ecx
8010454c:	7f 26                	jg     80104574 <piperead+0x94>
8010454e:	eb 2c                	jmp    8010457c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80104550:	8d 48 01             	lea    0x1(%eax),%ecx
80104553:	25 ff 01 00 00       	and    $0x1ff,%eax
80104558:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010455e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80104563:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80104566:	83 c3 01             	add    $0x1,%ebx
80104569:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010456c:	74 0e                	je     8010457c <piperead+0x9c>
8010456e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
    if(p->nread == p->nwrite)
80104574:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010457a:	75 d4                	jne    80104550 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010457c:	83 ec 0c             	sub    $0xc,%esp
8010457f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80104585:	50                   	push   %eax
80104586:	e8 95 09 00 00       	call   80104f20 <wakeup>
  release(&p->lock);
8010458b:	89 34 24             	mov    %esi,(%esp)
8010458e:	e8 ed 0d 00 00       	call   80105380 <release>
  return i;
80104593:	83 c4 10             	add    $0x10,%esp
}
80104596:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104599:	89 d8                	mov    %ebx,%eax
8010459b:	5b                   	pop    %ebx
8010459c:	5e                   	pop    %esi
8010459d:	5f                   	pop    %edi
8010459e:	5d                   	pop    %ebp
8010459f:	c3                   	ret
      release(&p->lock);
801045a0:	83 ec 0c             	sub    $0xc,%esp
      return -1;
801045a3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
801045a8:	56                   	push   %esi
801045a9:	e8 d2 0d 00 00       	call   80105380 <release>
      return -1;
801045ae:	83 c4 10             	add    $0x10,%esp
}
801045b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801045b4:	89 d8                	mov    %ebx,%eax
801045b6:	5b                   	pop    %ebx
801045b7:	5e                   	pop    %esi
801045b8:	5f                   	pop    %edi
801045b9:	5d                   	pop    %ebp
801045ba:	c3                   	ret
801045bb:	66 90                	xchg   %ax,%ax
801045bd:	66 90                	xchg   %ax,%ax
801045bf:	90                   	nop

801045c0 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
801045c0:	55                   	push   %ebp
801045c1:	89 e5                	mov    %esp,%ebp
801045c3:	53                   	push   %ebx
  char *sp;
  

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801045c4:	bb 74 61 11 80       	mov    $0x80116174,%ebx
{
801045c9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801045cc:	68 40 61 11 80       	push   $0x80116140
801045d1:	e8 0a 0e 00 00       	call   801053e0 <acquire>
801045d6:	83 c4 10             	add    $0x10,%esp
801045d9:	eb 14                	jmp    801045ef <allocproc+0x2f>
801045db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801045e0:	83 eb 80             	sub    $0xffffff80,%ebx
801045e3:	81 fb 74 81 11 80    	cmp    $0x80118174,%ebx
801045e9:	0f 84 81 00 00 00    	je     80104670 <allocproc+0xb0>
    if(p->state == UNUSED)
801045ef:	8b 43 0c             	mov    0xc(%ebx),%eax
801045f2:	85 c0                	test   %eax,%eax
801045f4:	75 ea                	jne    801045e0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801045f6:	a1 04 c0 10 80       	mov    0x8010c004,%eax
  p->logged_in_user = -1;

  release(&ptable.lock);
801045fb:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801045fe:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->logged_in_user = -1;
80104605:	c7 43 7c ff ff ff ff 	movl   $0xffffffff,0x7c(%ebx)
  p->pid = nextpid++;
8010460c:	89 43 10             	mov    %eax,0x10(%ebx)
8010460f:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80104612:	68 40 61 11 80       	push   $0x80116140
  p->pid = nextpid++;
80104617:	89 15 04 c0 10 80    	mov    %edx,0x8010c004
  release(&ptable.lock);
8010461d:	e8 5e 0d 00 00       	call   80105380 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80104622:	e8 49 ee ff ff       	call   80103470 <kalloc>
80104627:	83 c4 10             	add    $0x10,%esp
8010462a:	89 43 08             	mov    %eax,0x8(%ebx)
8010462d:	85 c0                	test   %eax,%eax
8010462f:	74 58                	je     80104689 <allocproc+0xc9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80104631:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80104637:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010463a:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
8010463f:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80104642:	c7 40 14 df 6c 10 80 	movl   $0x80106cdf,0x14(%eax)
  p->context = (struct context*)sp;
80104649:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
8010464c:	6a 14                	push   $0x14
8010464e:	6a 00                	push   $0x0
80104650:	50                   	push   %eax
80104651:	e8 8a 0e 00 00       	call   801054e0 <memset>
  p->context->eip = (uint)forkret;
80104656:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80104659:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
8010465c:	c7 40 10 a0 46 10 80 	movl   $0x801046a0,0x10(%eax)
}
80104663:	89 d8                	mov    %ebx,%eax
80104665:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104668:	c9                   	leave
80104669:	c3                   	ret
8010466a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104670:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80104673:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80104675:	68 40 61 11 80       	push   $0x80116140
8010467a:	e8 01 0d 00 00       	call   80105380 <release>
  return 0;
8010467f:	83 c4 10             	add    $0x10,%esp
}
80104682:	89 d8                	mov    %ebx,%eax
80104684:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104687:	c9                   	leave
80104688:	c3                   	ret
    p->state = UNUSED;
80104689:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
80104690:	31 db                	xor    %ebx,%ebx
80104692:	eb ee                	jmp    80104682 <allocproc+0xc2>
80104694:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010469b:	00 
8010469c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046a0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
801046a0:	55                   	push   %ebp
801046a1:	89 e5                	mov    %esp,%ebp
801046a3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801046a6:	68 40 61 11 80       	push   $0x80116140
801046ab:	e8 d0 0c 00 00       	call   80105380 <release>

  if (first) {
801046b0:	a1 00 c0 10 80       	mov    0x8010c000,%eax
801046b5:	83 c4 10             	add    $0x10,%esp
801046b8:	85 c0                	test   %eax,%eax
801046ba:	75 04                	jne    801046c0 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
801046bc:	c9                   	leave
801046bd:	c3                   	ret
801046be:	66 90                	xchg   %ax,%ax
    first = 0;
801046c0:	c7 05 00 c0 10 80 00 	movl   $0x0,0x8010c000
801046c7:	00 00 00 
    iinit(ROOTDEV);
801046ca:	83 ec 0c             	sub    $0xc,%esp
801046cd:	6a 01                	push   $0x1
801046cf:	e8 bc dc ff ff       	call   80102390 <iinit>
    initlog(ROOTDEV);
801046d4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
801046db:	e8 e0 f3 ff ff       	call   80103ac0 <initlog>
}
801046e0:	83 c4 10             	add    $0x10,%esp
801046e3:	c9                   	leave
801046e4:	c3                   	ret
801046e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801046ec:	00 
801046ed:	8d 76 00             	lea    0x0(%esi),%esi

801046f0 <pinit>:
{
801046f0:	55                   	push   %ebp
801046f1:	89 e5                	mov    %esp,%ebp
801046f3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
801046f6:	68 9f 88 10 80       	push   $0x8010889f
801046fb:	68 40 61 11 80       	push   $0x80116140
80104700:	e8 eb 0a 00 00       	call   801051f0 <initlock>
}
80104705:	83 c4 10             	add    $0x10,%esp
80104708:	c9                   	leave
80104709:	c3                   	ret
8010470a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104710 <mycpu>:
{
80104710:	55                   	push   %ebp
80104711:	89 e5                	mov    %esp,%ebp
80104713:	56                   	push   %esi
80104714:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104715:	9c                   	pushf
80104716:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104717:	f6 c4 02             	test   $0x2,%ah
8010471a:	75 46                	jne    80104762 <mycpu+0x52>
  apicid = lapicid();
8010471c:	e8 cf ef ff ff       	call   801036f0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80104721:	8b 35 a4 5b 11 80    	mov    0x80115ba4,%esi
80104727:	85 f6                	test   %esi,%esi
80104729:	7e 2a                	jle    80104755 <mycpu+0x45>
8010472b:	31 d2                	xor    %edx,%edx
8010472d:	eb 08                	jmp    80104737 <mycpu+0x27>
8010472f:	90                   	nop
80104730:	83 c2 01             	add    $0x1,%edx
80104733:	39 f2                	cmp    %esi,%edx
80104735:	74 1e                	je     80104755 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80104737:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
8010473d:	0f b6 99 c0 5b 11 80 	movzbl -0x7feea440(%ecx),%ebx
80104744:	39 c3                	cmp    %eax,%ebx
80104746:	75 e8                	jne    80104730 <mycpu+0x20>
}
80104748:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
8010474b:	8d 81 c0 5b 11 80    	lea    -0x7feea440(%ecx),%eax
}
80104751:	5b                   	pop    %ebx
80104752:	5e                   	pop    %esi
80104753:	5d                   	pop    %ebp
80104754:	c3                   	ret
  panic("unknown apicid\n");
80104755:	83 ec 0c             	sub    $0xc,%esp
80104758:	68 a6 88 10 80       	push   $0x801088a6
8010475d:	e8 3e bc ff ff       	call   801003a0 <panic>
    panic("mycpu called with interrupts enabled\n");
80104762:	83 ec 0c             	sub    $0xc,%esp
80104765:	68 c4 8c 10 80       	push   $0x80108cc4
8010476a:	e8 31 bc ff ff       	call   801003a0 <panic>
8010476f:	90                   	nop

80104770 <cpuid>:
cpuid() {
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
80104773:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80104776:	e8 95 ff ff ff       	call   80104710 <mycpu>
}
8010477b:	c9                   	leave
  return mycpu()-cpus;
8010477c:	2d c0 5b 11 80       	sub    $0x80115bc0,%eax
80104781:	c1 f8 04             	sar    $0x4,%eax
80104784:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010478a:	c3                   	ret
8010478b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104790 <myproc>:
myproc(void) {
80104790:	55                   	push   %ebp
80104791:	89 e5                	mov    %esp,%ebp
80104793:	53                   	push   %ebx
80104794:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104797:	e8 f4 0a 00 00       	call   80105290 <pushcli>
  c = mycpu();
8010479c:	e8 6f ff ff ff       	call   80104710 <mycpu>
  p = c->proc;
801047a1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801047a7:	e8 34 0b 00 00       	call   801052e0 <popcli>
}
801047ac:	89 d8                	mov    %ebx,%eax
801047ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801047b1:	c9                   	leave
801047b2:	c3                   	ret
801047b3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801047ba:	00 
801047bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801047c0 <userinit>:
{
801047c0:	55                   	push   %ebp
801047c1:	89 e5                	mov    %esp,%ebp
801047c3:	53                   	push   %ebx
801047c4:	83 ec 10             	sub    $0x10,%esp
  cprintf("hehe");
801047c7:	68 b6 88 10 80       	push   $0x801088b6
801047cc:	e8 6f c4 ff ff       	call   80100c40 <cprintf>
  p = allocproc();
801047d1:	e8 ea fd ff ff       	call   801045c0 <allocproc>
801047d6:	89 c3                	mov    %eax,%ebx
  initproc = p;
801047d8:	a3 74 81 11 80       	mov    %eax,0x80118174
  if((p->pgdir = setupkvm()) == 0)
801047dd:	e8 ce 3a 00 00       	call   801082b0 <setupkvm>
801047e2:	83 c4 10             	add    $0x10,%esp
801047e5:	89 43 04             	mov    %eax,0x4(%ebx)
801047e8:	85 c0                	test   %eax,%eax
801047ea:	0f 84 c1 00 00 00    	je     801048b1 <userinit+0xf1>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801047f0:	83 ec 04             	sub    $0x4,%esp
801047f3:	68 2c 00 00 00       	push   $0x2c
801047f8:	68 60 c4 10 80       	push   $0x8010c460
801047fd:	50                   	push   %eax
801047fe:	e8 8d 37 00 00       	call   80107f90 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80104803:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80104806:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
8010480c:	6a 4c                	push   $0x4c
8010480e:	6a 00                	push   $0x0
80104810:	ff 73 18             	push   0x18(%ebx)
80104813:	e8 c8 0c 00 00       	call   801054e0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80104818:	8b 43 18             	mov    0x18(%ebx),%eax
8010481b:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104820:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80104823:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80104828:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
8010482c:	8b 43 18             	mov    0x18(%ebx),%eax
8010482f:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80104833:	8b 43 18             	mov    0x18(%ebx),%eax
80104836:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010483a:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
8010483e:	8b 43 18             	mov    0x18(%ebx),%eax
80104841:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104845:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80104849:	8b 43 18             	mov    0x18(%ebx),%eax
8010484c:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104853:	8b 43 18             	mov    0x18(%ebx),%eax
80104856:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
8010485d:	8b 43 18             	mov    0x18(%ebx),%eax
80104860:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80104867:	8d 43 6c             	lea    0x6c(%ebx),%eax
8010486a:	6a 10                	push   $0x10
8010486c:	68 d4 88 10 80       	push   $0x801088d4
80104871:	50                   	push   %eax
80104872:	e8 19 0e 00 00       	call   80105690 <safestrcpy>
  p->cwd = namei("/");
80104877:	c7 04 24 dd 88 10 80 	movl   $0x801088dd,(%esp)
8010487e:	e8 0d e6 ff ff       	call   80102e90 <namei>
80104883:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80104886:	c7 04 24 40 61 11 80 	movl   $0x80116140,(%esp)
8010488d:	e8 4e 0b 00 00       	call   801053e0 <acquire>
  p->state = RUNNABLE;
80104892:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80104899:	c7 04 24 40 61 11 80 	movl   $0x80116140,(%esp)
801048a0:	e8 db 0a 00 00       	call   80105380 <release>
}
801048a5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  userinit_extra();
801048a8:	83 c4 10             	add    $0x10,%esp
}
801048ab:	c9                   	leave
  userinit_extra();
801048ac:	e9 af d1 ff ff       	jmp    80101a60 <userinit_extra>
    panic("userinit: out of memory?");
801048b1:	83 ec 0c             	sub    $0xc,%esp
801048b4:	68 bb 88 10 80       	push   $0x801088bb
801048b9:	e8 e2 ba ff ff       	call   801003a0 <panic>
801048be:	66 90                	xchg   %ax,%ax

801048c0 <growproc>:
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	56                   	push   %esi
801048c4:	53                   	push   %ebx
801048c5:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
801048c8:	e8 c3 09 00 00       	call   80105290 <pushcli>
  c = mycpu();
801048cd:	e8 3e fe ff ff       	call   80104710 <mycpu>
  p = c->proc;
801048d2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801048d8:	e8 03 0a 00 00       	call   801052e0 <popcli>
  sz = curproc->sz;
801048dd:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
801048df:	85 f6                	test   %esi,%esi
801048e1:	7f 1d                	jg     80104900 <growproc+0x40>
  } else if(n < 0){
801048e3:	75 3b                	jne    80104920 <growproc+0x60>
  switchuvm(curproc);
801048e5:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
801048e8:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
801048ea:	53                   	push   %ebx
801048eb:	e8 90 35 00 00       	call   80107e80 <switchuvm>
  return 0;
801048f0:	83 c4 10             	add    $0x10,%esp
801048f3:	31 c0                	xor    %eax,%eax
}
801048f5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801048f8:	5b                   	pop    %ebx
801048f9:	5e                   	pop    %esi
801048fa:	5d                   	pop    %ebp
801048fb:	c3                   	ret
801048fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104900:	83 ec 04             	sub    $0x4,%esp
80104903:	01 c6                	add    %eax,%esi
80104905:	56                   	push   %esi
80104906:	50                   	push   %eax
80104907:	ff 73 04             	push   0x4(%ebx)
8010490a:	e8 d1 37 00 00       	call   801080e0 <allocuvm>
8010490f:	83 c4 10             	add    $0x10,%esp
80104912:	85 c0                	test   %eax,%eax
80104914:	75 cf                	jne    801048e5 <growproc+0x25>
      return -1;
80104916:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010491b:	eb d8                	jmp    801048f5 <growproc+0x35>
8010491d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104920:	83 ec 04             	sub    $0x4,%esp
80104923:	01 c6                	add    %eax,%esi
80104925:	56                   	push   %esi
80104926:	50                   	push   %eax
80104927:	ff 73 04             	push   0x4(%ebx)
8010492a:	e8 d1 38 00 00       	call   80108200 <deallocuvm>
8010492f:	83 c4 10             	add    $0x10,%esp
80104932:	85 c0                	test   %eax,%eax
80104934:	75 af                	jne    801048e5 <growproc+0x25>
80104936:	eb de                	jmp    80104916 <growproc+0x56>
80104938:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010493f:	00 

80104940 <fork>:
{
80104940:	55                   	push   %ebp
80104941:	89 e5                	mov    %esp,%ebp
80104943:	57                   	push   %edi
80104944:	56                   	push   %esi
80104945:	53                   	push   %ebx
80104946:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80104949:	e8 42 09 00 00       	call   80105290 <pushcli>
  c = mycpu();
8010494e:	e8 bd fd ff ff       	call   80104710 <mycpu>
  p = c->proc;
80104953:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104959:	e8 82 09 00 00       	call   801052e0 <popcli>
  if((np = allocproc()) == 0){
8010495e:	e8 5d fc ff ff       	call   801045c0 <allocproc>
80104963:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80104966:	85 c0                	test   %eax,%eax
80104968:	0f 84 d6 00 00 00    	je     80104a44 <fork+0x104>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
8010496e:	83 ec 08             	sub    $0x8,%esp
80104971:	ff 33                	push   (%ebx)
80104973:	89 c7                	mov    %eax,%edi
80104975:	ff 73 04             	push   0x4(%ebx)
80104978:	e8 23 3a 00 00       	call   801083a0 <copyuvm>
8010497d:	83 c4 10             	add    $0x10,%esp
80104980:	89 47 04             	mov    %eax,0x4(%edi)
80104983:	85 c0                	test   %eax,%eax
80104985:	0f 84 9a 00 00 00    	je     80104a25 <fork+0xe5>
  np->sz = curproc->sz;
8010498b:	8b 03                	mov    (%ebx),%eax
8010498d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104990:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80104992:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80104995:	89 c8                	mov    %ecx,%eax
80104997:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
8010499a:	b9 13 00 00 00       	mov    $0x13,%ecx
8010499f:	8b 73 18             	mov    0x18(%ebx),%esi
801049a2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
801049a4:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
801049a6:	8b 40 18             	mov    0x18(%eax),%eax
801049a9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
801049b0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
801049b4:	85 c0                	test   %eax,%eax
801049b6:	74 13                	je     801049cb <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
801049b8:	83 ec 0c             	sub    $0xc,%esp
801049bb:	50                   	push   %eax
801049bc:	e8 7f cd ff ff       	call   80101740 <filedup>
801049c1:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801049c4:	83 c4 10             	add    $0x10,%esp
801049c7:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
801049cb:	83 c6 01             	add    $0x1,%esi
801049ce:	83 fe 10             	cmp    $0x10,%esi
801049d1:	75 dd                	jne    801049b0 <fork+0x70>
  np->cwd = idup(curproc->cwd);
801049d3:	83 ec 0c             	sub    $0xc,%esp
801049d6:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801049d9:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
801049dc:	e8 9f db ff ff       	call   80102580 <idup>
801049e1:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801049e4:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
801049e7:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
801049ea:	8d 47 6c             	lea    0x6c(%edi),%eax
801049ed:	6a 10                	push   $0x10
801049ef:	53                   	push   %ebx
801049f0:	50                   	push   %eax
801049f1:	e8 9a 0c 00 00       	call   80105690 <safestrcpy>
  pid = np->pid;
801049f6:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
801049f9:	c7 04 24 40 61 11 80 	movl   $0x80116140,(%esp)
80104a00:	e8 db 09 00 00       	call   801053e0 <acquire>
  np->state = RUNNABLE;
80104a05:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80104a0c:	c7 04 24 40 61 11 80 	movl   $0x80116140,(%esp)
80104a13:	e8 68 09 00 00       	call   80105380 <release>
  return pid;
80104a18:	83 c4 10             	add    $0x10,%esp
}
80104a1b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104a1e:	89 d8                	mov    %ebx,%eax
80104a20:	5b                   	pop    %ebx
80104a21:	5e                   	pop    %esi
80104a22:	5f                   	pop    %edi
80104a23:	5d                   	pop    %ebp
80104a24:	c3                   	ret
    kfree(np->kstack);
80104a25:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80104a28:	83 ec 0c             	sub    $0xc,%esp
80104a2b:	ff 73 08             	push   0x8(%ebx)
80104a2e:	e8 7d e8 ff ff       	call   801032b0 <kfree>
    np->kstack = 0;
80104a33:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80104a3a:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80104a3d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80104a44:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104a49:	eb d0                	jmp    80104a1b <fork+0xdb>
80104a4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104a50 <scheduler>:
{
80104a50:	55                   	push   %ebp
80104a51:	89 e5                	mov    %esp,%ebp
80104a53:	57                   	push   %edi
80104a54:	56                   	push   %esi
80104a55:	53                   	push   %ebx
80104a56:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80104a59:	e8 b2 fc ff ff       	call   80104710 <mycpu>
  c->proc = 0;
80104a5e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104a65:	00 00 00 
  struct cpu *c = mycpu();
80104a68:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80104a6a:	8d 78 04             	lea    0x4(%eax),%edi
80104a6d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80104a70:	fb                   	sti
    acquire(&ptable.lock);
80104a71:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104a74:	bb 74 61 11 80       	mov    $0x80116174,%ebx
    acquire(&ptable.lock);
80104a79:	68 40 61 11 80       	push   $0x80116140
80104a7e:	e8 5d 09 00 00       	call   801053e0 <acquire>
80104a83:	83 c4 10             	add    $0x10,%esp
80104a86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a8d:	00 
80104a8e:	66 90                	xchg   %ax,%ax
      if(p->state != RUNNABLE)
80104a90:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80104a94:	75 33                	jne    80104ac9 <scheduler+0x79>
      switchuvm(p);
80104a96:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80104a99:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80104a9f:	53                   	push   %ebx
80104aa0:	e8 db 33 00 00       	call   80107e80 <switchuvm>
      swtch(&(c->scheduler), p->context);
80104aa5:	58                   	pop    %eax
80104aa6:	5a                   	pop    %edx
80104aa7:	ff 73 1c             	push   0x1c(%ebx)
80104aaa:	57                   	push   %edi
      p->state = RUNNING;
80104aab:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80104ab2:	e8 34 0c 00 00       	call   801056eb <swtch>
      switchkvm();
80104ab7:	e8 b4 33 00 00       	call   80107e70 <switchkvm>
      c->proc = 0;
80104abc:	83 c4 10             	add    $0x10,%esp
80104abf:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104ac6:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104ac9:	83 eb 80             	sub    $0xffffff80,%ebx
80104acc:	81 fb 74 81 11 80    	cmp    $0x80118174,%ebx
80104ad2:	75 bc                	jne    80104a90 <scheduler+0x40>
    release(&ptable.lock);
80104ad4:	83 ec 0c             	sub    $0xc,%esp
80104ad7:	68 40 61 11 80       	push   $0x80116140
80104adc:	e8 9f 08 00 00       	call   80105380 <release>
    sti();
80104ae1:	83 c4 10             	add    $0x10,%esp
80104ae4:	eb 8a                	jmp    80104a70 <scheduler+0x20>
80104ae6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104aed:	00 
80104aee:	66 90                	xchg   %ax,%ax

80104af0 <sched>:
{
80104af0:	55                   	push   %ebp
80104af1:	89 e5                	mov    %esp,%ebp
80104af3:	56                   	push   %esi
80104af4:	53                   	push   %ebx
  pushcli();
80104af5:	e8 96 07 00 00       	call   80105290 <pushcli>
  c = mycpu();
80104afa:	e8 11 fc ff ff       	call   80104710 <mycpu>
  p = c->proc;
80104aff:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104b05:	e8 d6 07 00 00       	call   801052e0 <popcli>
  if(!holding(&ptable.lock))
80104b0a:	83 ec 0c             	sub    $0xc,%esp
80104b0d:	68 40 61 11 80       	push   $0x80116140
80104b12:	e8 29 08 00 00       	call   80105340 <holding>
80104b17:	83 c4 10             	add    $0x10,%esp
80104b1a:	85 c0                	test   %eax,%eax
80104b1c:	74 4f                	je     80104b6d <sched+0x7d>
  if(mycpu()->ncli != 1)
80104b1e:	e8 ed fb ff ff       	call   80104710 <mycpu>
80104b23:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80104b2a:	75 68                	jne    80104b94 <sched+0xa4>
  if(p->state == RUNNING)
80104b2c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104b30:	74 55                	je     80104b87 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104b32:	9c                   	pushf
80104b33:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104b34:	f6 c4 02             	test   $0x2,%ah
80104b37:	75 41                	jne    80104b7a <sched+0x8a>
  intena = mycpu()->intena;
80104b39:	e8 d2 fb ff ff       	call   80104710 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80104b3e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80104b41:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80104b47:	e8 c4 fb ff ff       	call   80104710 <mycpu>
80104b4c:	83 ec 08             	sub    $0x8,%esp
80104b4f:	ff 70 04             	push   0x4(%eax)
80104b52:	53                   	push   %ebx
80104b53:	e8 93 0b 00 00       	call   801056eb <swtch>
  mycpu()->intena = intena;
80104b58:	e8 b3 fb ff ff       	call   80104710 <mycpu>
}
80104b5d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80104b60:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80104b66:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b69:	5b                   	pop    %ebx
80104b6a:	5e                   	pop    %esi
80104b6b:	5d                   	pop    %ebp
80104b6c:	c3                   	ret
    panic("sched ptable.lock");
80104b6d:	83 ec 0c             	sub    $0xc,%esp
80104b70:	68 df 88 10 80       	push   $0x801088df
80104b75:	e8 26 b8 ff ff       	call   801003a0 <panic>
    panic("sched interruptible");
80104b7a:	83 ec 0c             	sub    $0xc,%esp
80104b7d:	68 0b 89 10 80       	push   $0x8010890b
80104b82:	e8 19 b8 ff ff       	call   801003a0 <panic>
    panic("sched running");
80104b87:	83 ec 0c             	sub    $0xc,%esp
80104b8a:	68 fd 88 10 80       	push   $0x801088fd
80104b8f:	e8 0c b8 ff ff       	call   801003a0 <panic>
    panic("sched locks");
80104b94:	83 ec 0c             	sub    $0xc,%esp
80104b97:	68 f1 88 10 80       	push   $0x801088f1
80104b9c:	e8 ff b7 ff ff       	call   801003a0 <panic>
80104ba1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104ba8:	00 
80104ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104bb0 <exit>:
{
80104bb0:	55                   	push   %ebp
80104bb1:	89 e5                	mov    %esp,%ebp
80104bb3:	57                   	push   %edi
80104bb4:	56                   	push   %esi
80104bb5:	53                   	push   %ebx
80104bb6:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80104bb9:	e8 d2 fb ff ff       	call   80104790 <myproc>
  if(curproc == initproc)
80104bbe:	39 05 74 81 11 80    	cmp    %eax,0x80118174
80104bc4:	0f 84 fd 00 00 00    	je     80104cc7 <exit+0x117>
80104bca:	89 c3                	mov    %eax,%ebx
80104bcc:	8d 70 28             	lea    0x28(%eax),%esi
80104bcf:	8d 78 68             	lea    0x68(%eax),%edi
80104bd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80104bd8:	8b 06                	mov    (%esi),%eax
80104bda:	85 c0                	test   %eax,%eax
80104bdc:	74 12                	je     80104bf0 <exit+0x40>
      fileclose(curproc->ofile[fd]);
80104bde:	83 ec 0c             	sub    $0xc,%esp
80104be1:	50                   	push   %eax
80104be2:	e8 a9 cb ff ff       	call   80101790 <fileclose>
      curproc->ofile[fd] = 0;
80104be7:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80104bed:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104bf0:	83 c6 04             	add    $0x4,%esi
80104bf3:	39 f7                	cmp    %esi,%edi
80104bf5:	75 e1                	jne    80104bd8 <exit+0x28>
  begin_op();
80104bf7:	e8 64 ef ff ff       	call   80103b60 <begin_op>
  iput(curproc->cwd);
80104bfc:	83 ec 0c             	sub    $0xc,%esp
80104bff:	ff 73 68             	push   0x68(%ebx)
80104c02:	e8 d9 da ff ff       	call   801026e0 <iput>
  end_op();
80104c07:	e8 c4 ef ff ff       	call   80103bd0 <end_op>
  curproc->cwd = 0;
80104c0c:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80104c13:	c7 04 24 40 61 11 80 	movl   $0x80116140,(%esp)
80104c1a:	e8 c1 07 00 00       	call   801053e0 <acquire>
  wakeup1(curproc->parent);
80104c1f:	8b 53 14             	mov    0x14(%ebx),%edx
80104c22:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c25:	b8 74 61 11 80       	mov    $0x80116174,%eax
80104c2a:	eb 0e                	jmp    80104c3a <exit+0x8a>
80104c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104c30:	83 e8 80             	sub    $0xffffff80,%eax
80104c33:	3d 74 81 11 80       	cmp    $0x80118174,%eax
80104c38:	74 1c                	je     80104c56 <exit+0xa6>
    if(p->state == SLEEPING && p->chan == chan)
80104c3a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104c3e:	75 f0                	jne    80104c30 <exit+0x80>
80104c40:	3b 50 20             	cmp    0x20(%eax),%edx
80104c43:	75 eb                	jne    80104c30 <exit+0x80>
      p->state = RUNNABLE;
80104c45:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c4c:	83 e8 80             	sub    $0xffffff80,%eax
80104c4f:	3d 74 81 11 80       	cmp    $0x80118174,%eax
80104c54:	75 e4                	jne    80104c3a <exit+0x8a>
      p->parent = initproc;
80104c56:	8b 0d 74 81 11 80    	mov    0x80118174,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104c5c:	ba 74 61 11 80       	mov    $0x80116174,%edx
80104c61:	eb 10                	jmp    80104c73 <exit+0xc3>
80104c63:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c68:	83 ea 80             	sub    $0xffffff80,%edx
80104c6b:	81 fa 74 81 11 80    	cmp    $0x80118174,%edx
80104c71:	74 3b                	je     80104cae <exit+0xfe>
    if(p->parent == curproc){
80104c73:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104c76:	75 f0                	jne    80104c68 <exit+0xb8>
      if(p->state == ZOMBIE)
80104c78:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80104c7c:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80104c7f:	75 e7                	jne    80104c68 <exit+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c81:	b8 74 61 11 80       	mov    $0x80116174,%eax
80104c86:	eb 12                	jmp    80104c9a <exit+0xea>
80104c88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c8f:	00 
80104c90:	83 e8 80             	sub    $0xffffff80,%eax
80104c93:	3d 74 81 11 80       	cmp    $0x80118174,%eax
80104c98:	74 ce                	je     80104c68 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
80104c9a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104c9e:	75 f0                	jne    80104c90 <exit+0xe0>
80104ca0:	3b 48 20             	cmp    0x20(%eax),%ecx
80104ca3:	75 eb                	jne    80104c90 <exit+0xe0>
      p->state = RUNNABLE;
80104ca5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104cac:	eb e2                	jmp    80104c90 <exit+0xe0>
  curproc->state = ZOMBIE;
80104cae:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80104cb5:	e8 36 fe ff ff       	call   80104af0 <sched>
  panic("zombie exit");
80104cba:	83 ec 0c             	sub    $0xc,%esp
80104cbd:	68 2c 89 10 80       	push   $0x8010892c
80104cc2:	e8 d9 b6 ff ff       	call   801003a0 <panic>
    panic("init exiting");
80104cc7:	83 ec 0c             	sub    $0xc,%esp
80104cca:	68 1f 89 10 80       	push   $0x8010891f
80104ccf:	e8 cc b6 ff ff       	call   801003a0 <panic>
80104cd4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104cdb:	00 
80104cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104ce0 <wait>:
{
80104ce0:	55                   	push   %ebp
80104ce1:	89 e5                	mov    %esp,%ebp
80104ce3:	56                   	push   %esi
80104ce4:	53                   	push   %ebx
  pushcli();
80104ce5:	e8 a6 05 00 00       	call   80105290 <pushcli>
  c = mycpu();
80104cea:	e8 21 fa ff ff       	call   80104710 <mycpu>
  p = c->proc;
80104cef:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104cf5:	e8 e6 05 00 00       	call   801052e0 <popcli>
  acquire(&ptable.lock);
80104cfa:	83 ec 0c             	sub    $0xc,%esp
80104cfd:	68 40 61 11 80       	push   $0x80116140
80104d02:	e8 d9 06 00 00       	call   801053e0 <acquire>
80104d07:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80104d0a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d0c:	bb 74 61 11 80       	mov    $0x80116174,%ebx
80104d11:	eb 10                	jmp    80104d23 <wait+0x43>
80104d13:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d18:	83 eb 80             	sub    $0xffffff80,%ebx
80104d1b:	81 fb 74 81 11 80    	cmp    $0x80118174,%ebx
80104d21:	74 1b                	je     80104d3e <wait+0x5e>
      if(p->parent != curproc)
80104d23:	39 73 14             	cmp    %esi,0x14(%ebx)
80104d26:	75 f0                	jne    80104d18 <wait+0x38>
      if(p->state == ZOMBIE){
80104d28:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80104d2c:	74 62                	je     80104d90 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d2e:	83 eb 80             	sub    $0xffffff80,%ebx
      havekids = 1;
80104d31:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104d36:	81 fb 74 81 11 80    	cmp    $0x80118174,%ebx
80104d3c:	75 e5                	jne    80104d23 <wait+0x43>
    if(!havekids || curproc->killed){
80104d3e:	85 c0                	test   %eax,%eax
80104d40:	0f 84 a0 00 00 00    	je     80104de6 <wait+0x106>
80104d46:	8b 46 24             	mov    0x24(%esi),%eax
80104d49:	85 c0                	test   %eax,%eax
80104d4b:	0f 85 95 00 00 00    	jne    80104de6 <wait+0x106>
  pushcli();
80104d51:	e8 3a 05 00 00       	call   80105290 <pushcli>
  c = mycpu();
80104d56:	e8 b5 f9 ff ff       	call   80104710 <mycpu>
  p = c->proc;
80104d5b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104d61:	e8 7a 05 00 00       	call   801052e0 <popcli>
  if(p == 0)
80104d66:	85 db                	test   %ebx,%ebx
80104d68:	0f 84 8f 00 00 00    	je     80104dfd <wait+0x11d>
  p->chan = chan;
80104d6e:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104d71:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104d78:	e8 73 fd ff ff       	call   80104af0 <sched>
  p->chan = 0;
80104d7d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104d84:	eb 84                	jmp    80104d0a <wait+0x2a>
80104d86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d8d:	00 
80104d8e:	66 90                	xchg   %ax,%ax
        kfree(p->kstack);
80104d90:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104d93:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104d96:	ff 73 08             	push   0x8(%ebx)
80104d99:	e8 12 e5 ff ff       	call   801032b0 <kfree>
        p->kstack = 0;
80104d9e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104da5:	5a                   	pop    %edx
80104da6:	ff 73 04             	push   0x4(%ebx)
80104da9:	e8 82 34 00 00       	call   80108230 <freevm>
        p->pid = 0;
80104dae:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104db5:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
80104dbc:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104dc0:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104dc7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104dce:	c7 04 24 40 61 11 80 	movl   $0x80116140,(%esp)
80104dd5:	e8 a6 05 00 00       	call   80105380 <release>
        return pid;
80104dda:	83 c4 10             	add    $0x10,%esp
}
80104ddd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104de0:	89 f0                	mov    %esi,%eax
80104de2:	5b                   	pop    %ebx
80104de3:	5e                   	pop    %esi
80104de4:	5d                   	pop    %ebp
80104de5:	c3                   	ret
      release(&ptable.lock);
80104de6:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104de9:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104dee:	68 40 61 11 80       	push   $0x80116140
80104df3:	e8 88 05 00 00       	call   80105380 <release>
      return -1;
80104df8:	83 c4 10             	add    $0x10,%esp
80104dfb:	eb e0                	jmp    80104ddd <wait+0xfd>
    panic("sleep");
80104dfd:	83 ec 0c             	sub    $0xc,%esp
80104e00:	68 38 89 10 80       	push   $0x80108938
80104e05:	e8 96 b5 ff ff       	call   801003a0 <panic>
80104e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104e10 <yield>:
{
80104e10:	55                   	push   %ebp
80104e11:	89 e5                	mov    %esp,%ebp
80104e13:	53                   	push   %ebx
80104e14:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104e17:	68 40 61 11 80       	push   $0x80116140
80104e1c:	e8 bf 05 00 00       	call   801053e0 <acquire>
  pushcli();
80104e21:	e8 6a 04 00 00       	call   80105290 <pushcli>
  c = mycpu();
80104e26:	e8 e5 f8 ff ff       	call   80104710 <mycpu>
  p = c->proc;
80104e2b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104e31:	e8 aa 04 00 00       	call   801052e0 <popcli>
  myproc()->state = RUNNABLE;
80104e36:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80104e3d:	e8 ae fc ff ff       	call   80104af0 <sched>
  release(&ptable.lock);
80104e42:	c7 04 24 40 61 11 80 	movl   $0x80116140,(%esp)
80104e49:	e8 32 05 00 00       	call   80105380 <release>
}
80104e4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e51:	83 c4 10             	add    $0x10,%esp
80104e54:	c9                   	leave
80104e55:	c3                   	ret
80104e56:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e5d:	00 
80104e5e:	66 90                	xchg   %ax,%ax

80104e60 <sleep>:
{
80104e60:	55                   	push   %ebp
80104e61:	89 e5                	mov    %esp,%ebp
80104e63:	57                   	push   %edi
80104e64:	56                   	push   %esi
80104e65:	53                   	push   %ebx
80104e66:	83 ec 0c             	sub    $0xc,%esp
80104e69:	8b 7d 08             	mov    0x8(%ebp),%edi
80104e6c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80104e6f:	e8 1c 04 00 00       	call   80105290 <pushcli>
  c = mycpu();
80104e74:	e8 97 f8 ff ff       	call   80104710 <mycpu>
  p = c->proc;
80104e79:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104e7f:	e8 5c 04 00 00       	call   801052e0 <popcli>
  if(p == 0)
80104e84:	85 db                	test   %ebx,%ebx
80104e86:	0f 84 87 00 00 00    	je     80104f13 <sleep+0xb3>
  if(lk == 0)
80104e8c:	85 f6                	test   %esi,%esi
80104e8e:	74 76                	je     80104f06 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104e90:	81 fe 40 61 11 80    	cmp    $0x80116140,%esi
80104e96:	74 50                	je     80104ee8 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104e98:	83 ec 0c             	sub    $0xc,%esp
80104e9b:	68 40 61 11 80       	push   $0x80116140
80104ea0:	e8 3b 05 00 00       	call   801053e0 <acquire>
    release(lk);
80104ea5:	89 34 24             	mov    %esi,(%esp)
80104ea8:	e8 d3 04 00 00       	call   80105380 <release>
  p->chan = chan;
80104ead:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104eb0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104eb7:	e8 34 fc ff ff       	call   80104af0 <sched>
  p->chan = 0;
80104ebc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104ec3:	c7 04 24 40 61 11 80 	movl   $0x80116140,(%esp)
80104eca:	e8 b1 04 00 00       	call   80105380 <release>
    acquire(lk);
80104ecf:	83 c4 10             	add    $0x10,%esp
80104ed2:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104ed5:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ed8:	5b                   	pop    %ebx
80104ed9:	5e                   	pop    %esi
80104eda:	5f                   	pop    %edi
80104edb:	5d                   	pop    %ebp
    acquire(lk);
80104edc:	e9 ff 04 00 00       	jmp    801053e0 <acquire>
80104ee1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104ee8:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104eeb:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104ef2:	e8 f9 fb ff ff       	call   80104af0 <sched>
  p->chan = 0;
80104ef7:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104efe:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f01:	5b                   	pop    %ebx
80104f02:	5e                   	pop    %esi
80104f03:	5f                   	pop    %edi
80104f04:	5d                   	pop    %ebp
80104f05:	c3                   	ret
    panic("sleep without lk");
80104f06:	83 ec 0c             	sub    $0xc,%esp
80104f09:	68 3e 89 10 80       	push   $0x8010893e
80104f0e:	e8 8d b4 ff ff       	call   801003a0 <panic>
    panic("sleep");
80104f13:	83 ec 0c             	sub    $0xc,%esp
80104f16:	68 38 89 10 80       	push   $0x80108938
80104f1b:	e8 80 b4 ff ff       	call   801003a0 <panic>

80104f20 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104f20:	55                   	push   %ebp
80104f21:	89 e5                	mov    %esp,%ebp
80104f23:	53                   	push   %ebx
80104f24:	83 ec 10             	sub    $0x10,%esp
80104f27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
80104f2a:	68 40 61 11 80       	push   $0x80116140
80104f2f:	e8 ac 04 00 00       	call   801053e0 <acquire>
80104f34:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104f37:	b8 74 61 11 80       	mov    $0x80116174,%eax
80104f3c:	eb 0c                	jmp    80104f4a <wakeup+0x2a>
80104f3e:	66 90                	xchg   %ax,%ax
80104f40:	83 e8 80             	sub    $0xffffff80,%eax
80104f43:	3d 74 81 11 80       	cmp    $0x80118174,%eax
80104f48:	74 1c                	je     80104f66 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
80104f4a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104f4e:	75 f0                	jne    80104f40 <wakeup+0x20>
80104f50:	3b 58 20             	cmp    0x20(%eax),%ebx
80104f53:	75 eb                	jne    80104f40 <wakeup+0x20>
      p->state = RUNNABLE;
80104f55:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104f5c:	83 e8 80             	sub    $0xffffff80,%eax
80104f5f:	3d 74 81 11 80       	cmp    $0x80118174,%eax
80104f64:	75 e4                	jne    80104f4a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104f66:	c7 45 08 40 61 11 80 	movl   $0x80116140,0x8(%ebp)
}
80104f6d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104f70:	c9                   	leave
  release(&ptable.lock);
80104f71:	e9 0a 04 00 00       	jmp    80105380 <release>
80104f76:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f7d:	00 
80104f7e:	66 90                	xchg   %ax,%ax

80104f80 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	53                   	push   %ebx
80104f84:	83 ec 10             	sub    $0x10,%esp
80104f87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
80104f8a:	68 40 61 11 80       	push   $0x80116140
80104f8f:	e8 4c 04 00 00       	call   801053e0 <acquire>
80104f94:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104f97:	b8 74 61 11 80       	mov    $0x80116174,%eax
80104f9c:	eb 0c                	jmp    80104faa <kill+0x2a>
80104f9e:	66 90                	xchg   %ax,%ax
80104fa0:	83 e8 80             	sub    $0xffffff80,%eax
80104fa3:	3d 74 81 11 80       	cmp    $0x80118174,%eax
80104fa8:	74 36                	je     80104fe0 <kill+0x60>
    if(p->pid == pid){
80104faa:	39 58 10             	cmp    %ebx,0x10(%eax)
80104fad:	75 f1                	jne    80104fa0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104faf:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104fb3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
80104fba:	75 07                	jne    80104fc3 <kill+0x43>
        p->state = RUNNABLE;
80104fbc:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104fc3:	83 ec 0c             	sub    $0xc,%esp
80104fc6:	68 40 61 11 80       	push   $0x80116140
80104fcb:	e8 b0 03 00 00       	call   80105380 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104fd0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104fd3:	83 c4 10             	add    $0x10,%esp
80104fd6:	31 c0                	xor    %eax,%eax
}
80104fd8:	c9                   	leave
80104fd9:	c3                   	ret
80104fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104fe0:	83 ec 0c             	sub    $0xc,%esp
80104fe3:	68 40 61 11 80       	push   $0x80116140
80104fe8:	e8 93 03 00 00       	call   80105380 <release>
}
80104fed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104ff0:	83 c4 10             	add    $0x10,%esp
80104ff3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104ff8:	c9                   	leave
80104ff9:	c3                   	ret
80104ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105000 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80105000:	55                   	push   %ebp
80105001:	89 e5                	mov    %esp,%ebp
80105003:	57                   	push   %edi
80105004:	56                   	push   %esi
80105005:	8d 75 e8             	lea    -0x18(%ebp),%esi
80105008:	53                   	push   %ebx
80105009:	bb e0 61 11 80       	mov    $0x801161e0,%ebx
8010500e:	83 ec 3c             	sub    $0x3c,%esp
80105011:	eb 24                	jmp    80105037 <procdump+0x37>
80105013:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80105018:	83 ec 0c             	sub    $0xc,%esp
8010501b:	68 65 8b 10 80       	push   $0x80108b65
80105020:	e8 1b bc ff ff       	call   80100c40 <cprintf>
80105025:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80105028:	83 eb 80             	sub    $0xffffff80,%ebx
8010502b:	81 fb e0 81 11 80    	cmp    $0x801181e0,%ebx
80105031:	0f 84 81 00 00 00    	je     801050b8 <procdump+0xb8>
    if(p->state == UNUSED)
80105037:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010503a:	85 c0                	test   %eax,%eax
8010503c:	74 ea                	je     80105028 <procdump+0x28>
      state = "???";
8010503e:	ba 4f 89 10 80       	mov    $0x8010894f,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80105043:	83 f8 05             	cmp    $0x5,%eax
80105046:	77 11                	ja     80105059 <procdump+0x59>
80105048:	8b 14 85 e0 8f 10 80 	mov    -0x7fef7020(,%eax,4),%edx
      state = "???";
8010504f:	b8 4f 89 10 80       	mov    $0x8010894f,%eax
80105054:	85 d2                	test   %edx,%edx
80105056:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80105059:	53                   	push   %ebx
8010505a:	52                   	push   %edx
8010505b:	ff 73 a4             	push   -0x5c(%ebx)
8010505e:	68 53 89 10 80       	push   $0x80108953
80105063:	e8 d8 bb ff ff       	call   80100c40 <cprintf>
    if(p->state == SLEEPING){
80105068:	83 c4 10             	add    $0x10,%esp
8010506b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010506f:	75 a7                	jne    80105018 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80105071:	83 ec 08             	sub    $0x8,%esp
80105074:	8d 45 c0             	lea    -0x40(%ebp),%eax
80105077:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010507a:	50                   	push   %eax
8010507b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010507e:	8b 40 0c             	mov    0xc(%eax),%eax
80105081:	83 c0 08             	add    $0x8,%eax
80105084:	50                   	push   %eax
80105085:	e8 86 01 00 00       	call   80105210 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010508a:	83 c4 10             	add    $0x10,%esp
8010508d:	8d 76 00             	lea    0x0(%esi),%esi
80105090:	8b 17                	mov    (%edi),%edx
80105092:	85 d2                	test   %edx,%edx
80105094:	74 82                	je     80105018 <procdump+0x18>
        cprintf(" %p", pc[i]);
80105096:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80105099:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010509c:	52                   	push   %edx
8010509d:	68 41 86 10 80       	push   $0x80108641
801050a2:	e8 99 bb ff ff       	call   80100c40 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801050a7:	83 c4 10             	add    $0x10,%esp
801050aa:	39 f7                	cmp    %esi,%edi
801050ac:	75 e2                	jne    80105090 <procdump+0x90>
801050ae:	e9 65 ff ff ff       	jmp    80105018 <procdump+0x18>
801050b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  }
}
801050b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801050bb:	5b                   	pop    %ebx
801050bc:	5e                   	pop    %esi
801050bd:	5f                   	pop    %edi
801050be:	5d                   	pop    %ebp
801050bf:	c3                   	ret

801050c0 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
801050c0:	55                   	push   %ebp
801050c1:	89 e5                	mov    %esp,%ebp
801050c3:	53                   	push   %ebx
801050c4:	83 ec 0c             	sub    $0xc,%esp
801050c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
801050ca:	68 86 89 10 80       	push   $0x80108986
801050cf:	8d 43 04             	lea    0x4(%ebx),%eax
801050d2:	50                   	push   %eax
801050d3:	e8 18 01 00 00       	call   801051f0 <initlock>
  lk->name = name;
801050d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
801050db:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
801050e1:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
801050e4:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
801050eb:	89 43 38             	mov    %eax,0x38(%ebx)
}
801050ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801050f1:	c9                   	leave
801050f2:	c3                   	ret
801050f3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801050fa:	00 
801050fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105100 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80105100:	55                   	push   %ebp
80105101:	89 e5                	mov    %esp,%ebp
80105103:	56                   	push   %esi
80105104:	53                   	push   %ebx
80105105:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105108:	8d 73 04             	lea    0x4(%ebx),%esi
8010510b:	83 ec 0c             	sub    $0xc,%esp
8010510e:	56                   	push   %esi
8010510f:	e8 cc 02 00 00       	call   801053e0 <acquire>
  while (lk->locked) {
80105114:	8b 13                	mov    (%ebx),%edx
80105116:	83 c4 10             	add    $0x10,%esp
80105119:	85 d2                	test   %edx,%edx
8010511b:	74 16                	je     80105133 <acquiresleep+0x33>
8010511d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80105120:	83 ec 08             	sub    $0x8,%esp
80105123:	56                   	push   %esi
80105124:	53                   	push   %ebx
80105125:	e8 36 fd ff ff       	call   80104e60 <sleep>
  while (lk->locked) {
8010512a:	8b 03                	mov    (%ebx),%eax
8010512c:	83 c4 10             	add    $0x10,%esp
8010512f:	85 c0                	test   %eax,%eax
80105131:	75 ed                	jne    80105120 <acquiresleep+0x20>
  }
  lk->locked = 1;
80105133:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80105139:	e8 52 f6 ff ff       	call   80104790 <myproc>
8010513e:	8b 40 10             	mov    0x10(%eax),%eax
80105141:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80105144:	89 75 08             	mov    %esi,0x8(%ebp)
}
80105147:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010514a:	5b                   	pop    %ebx
8010514b:	5e                   	pop    %esi
8010514c:	5d                   	pop    %ebp
  release(&lk->lk);
8010514d:	e9 2e 02 00 00       	jmp    80105380 <release>
80105152:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105159:	00 
8010515a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105160 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80105160:	55                   	push   %ebp
80105161:	89 e5                	mov    %esp,%ebp
80105163:	56                   	push   %esi
80105164:	53                   	push   %ebx
80105165:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80105168:	8d 73 04             	lea    0x4(%ebx),%esi
8010516b:	83 ec 0c             	sub    $0xc,%esp
8010516e:	56                   	push   %esi
8010516f:	e8 6c 02 00 00       	call   801053e0 <acquire>
  lk->locked = 0;
80105174:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010517a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80105181:	89 1c 24             	mov    %ebx,(%esp)
80105184:	e8 97 fd ff ff       	call   80104f20 <wakeup>
  release(&lk->lk);
80105189:	83 c4 10             	add    $0x10,%esp
8010518c:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010518f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105192:	5b                   	pop    %ebx
80105193:	5e                   	pop    %esi
80105194:	5d                   	pop    %ebp
  release(&lk->lk);
80105195:	e9 e6 01 00 00       	jmp    80105380 <release>
8010519a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801051a0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801051a0:	55                   	push   %ebp
801051a1:	89 e5                	mov    %esp,%ebp
801051a3:	57                   	push   %edi
801051a4:	31 ff                	xor    %edi,%edi
801051a6:	56                   	push   %esi
801051a7:	53                   	push   %ebx
801051a8:	83 ec 18             	sub    $0x18,%esp
801051ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801051ae:	8d 73 04             	lea    0x4(%ebx),%esi
801051b1:	56                   	push   %esi
801051b2:	e8 29 02 00 00       	call   801053e0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801051b7:	8b 03                	mov    (%ebx),%eax
801051b9:	83 c4 10             	add    $0x10,%esp
801051bc:	85 c0                	test   %eax,%eax
801051be:	75 18                	jne    801051d8 <holdingsleep+0x38>
  release(&lk->lk);
801051c0:	83 ec 0c             	sub    $0xc,%esp
801051c3:	56                   	push   %esi
801051c4:	e8 b7 01 00 00       	call   80105380 <release>
  return r;
}
801051c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051cc:	89 f8                	mov    %edi,%eax
801051ce:	5b                   	pop    %ebx
801051cf:	5e                   	pop    %esi
801051d0:	5f                   	pop    %edi
801051d1:	5d                   	pop    %ebp
801051d2:	c3                   	ret
801051d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
801051d8:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
801051db:	e8 b0 f5 ff ff       	call   80104790 <myproc>
801051e0:	39 58 10             	cmp    %ebx,0x10(%eax)
801051e3:	0f 94 c0             	sete   %al
801051e6:	0f b6 c0             	movzbl %al,%eax
801051e9:	89 c7                	mov    %eax,%edi
801051eb:	eb d3                	jmp    801051c0 <holdingsleep+0x20>
801051ed:	66 90                	xchg   %ax,%ax
801051ef:	90                   	nop

801051f0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801051f0:	55                   	push   %ebp
801051f1:	89 e5                	mov    %esp,%ebp
801051f3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801051f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801051f9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801051ff:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80105202:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105209:	5d                   	pop    %ebp
8010520a:	c3                   	ret
8010520b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105210 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80105210:	55                   	push   %ebp
80105211:	89 e5                	mov    %esp,%ebp
80105213:	53                   	push   %ebx
80105214:	8b 45 08             	mov    0x8(%ebp),%eax
80105217:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010521a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
8010521d:	05 f8 ff ff 7f       	add    $0x7ffffff8,%eax
80105222:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
  for(i = 0; i < 10; i++){
80105227:	b8 00 00 00 00       	mov    $0x0,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
8010522c:	76 10                	jbe    8010523e <getcallerpcs+0x2e>
8010522e:	eb 28                	jmp    80105258 <getcallerpcs+0x48>
80105230:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80105236:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010523c:	77 1a                	ja     80105258 <getcallerpcs+0x48>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010523e:	8b 5a 04             	mov    0x4(%edx),%ebx
80105241:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80105244:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80105247:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80105249:	83 f8 0a             	cmp    $0xa,%eax
8010524c:	75 e2                	jne    80105230 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010524e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105251:	c9                   	leave
80105252:	c3                   	ret
80105253:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105258:	8d 04 81             	lea    (%ecx,%eax,4),%eax
8010525b:	83 c1 28             	add    $0x28,%ecx
8010525e:	89 ca                	mov    %ecx,%edx
80105260:	29 c2                	sub    %eax,%edx
80105262:	83 e2 04             	and    $0x4,%edx
80105265:	74 11                	je     80105278 <getcallerpcs+0x68>
    pcs[i] = 0;
80105267:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
8010526d:	83 c0 04             	add    $0x4,%eax
80105270:	39 c1                	cmp    %eax,%ecx
80105272:	74 da                	je     8010524e <getcallerpcs+0x3e>
80105274:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
80105278:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
8010527e:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80105281:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80105288:	39 c1                	cmp    %eax,%ecx
8010528a:	75 ec                	jne    80105278 <getcallerpcs+0x68>
8010528c:	eb c0                	jmp    8010524e <getcallerpcs+0x3e>
8010528e:	66 90                	xchg   %ax,%ax

80105290 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80105290:	55                   	push   %ebp
80105291:	89 e5                	mov    %esp,%ebp
80105293:	53                   	push   %ebx
80105294:	83 ec 04             	sub    $0x4,%esp
80105297:	9c                   	pushf
80105298:	5b                   	pop    %ebx
  asm volatile("cli");
80105299:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010529a:	e8 71 f4 ff ff       	call   80104710 <mycpu>
8010529f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801052a5:	85 c0                	test   %eax,%eax
801052a7:	74 17                	je     801052c0 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
801052a9:	e8 62 f4 ff ff       	call   80104710 <mycpu>
801052ae:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801052b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801052b8:	c9                   	leave
801052b9:	c3                   	ret
801052ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
801052c0:	e8 4b f4 ff ff       	call   80104710 <mycpu>
801052c5:	81 e3 00 02 00 00    	and    $0x200,%ebx
801052cb:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
801052d1:	eb d6                	jmp    801052a9 <pushcli+0x19>
801052d3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801052da:	00 
801052db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801052e0 <popcli>:

void
popcli(void)
{
801052e0:	55                   	push   %ebp
801052e1:	89 e5                	mov    %esp,%ebp
801052e3:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801052e6:	9c                   	pushf
801052e7:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801052e8:	f6 c4 02             	test   $0x2,%ah
801052eb:	75 35                	jne    80105322 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
801052ed:	e8 1e f4 ff ff       	call   80104710 <mycpu>
801052f2:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
801052f9:	78 34                	js     8010532f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
801052fb:	e8 10 f4 ff ff       	call   80104710 <mycpu>
80105300:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80105306:	85 d2                	test   %edx,%edx
80105308:	74 06                	je     80105310 <popcli+0x30>
    sti();
}
8010530a:	c9                   	leave
8010530b:	c3                   	ret
8010530c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80105310:	e8 fb f3 ff ff       	call   80104710 <mycpu>
80105315:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010531b:	85 c0                	test   %eax,%eax
8010531d:	74 eb                	je     8010530a <popcli+0x2a>
  asm volatile("sti");
8010531f:	fb                   	sti
}
80105320:	c9                   	leave
80105321:	c3                   	ret
    panic("popcli - interruptible");
80105322:	83 ec 0c             	sub    $0xc,%esp
80105325:	68 91 89 10 80       	push   $0x80108991
8010532a:	e8 71 b0 ff ff       	call   801003a0 <panic>
    panic("popcli");
8010532f:	83 ec 0c             	sub    $0xc,%esp
80105332:	68 a8 89 10 80       	push   $0x801089a8
80105337:	e8 64 b0 ff ff       	call   801003a0 <panic>
8010533c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105340 <holding>:
{
80105340:	55                   	push   %ebp
80105341:	89 e5                	mov    %esp,%ebp
80105343:	56                   	push   %esi
80105344:	53                   	push   %ebx
80105345:	8b 75 08             	mov    0x8(%ebp),%esi
80105348:	31 db                	xor    %ebx,%ebx
  pushcli();
8010534a:	e8 41 ff ff ff       	call   80105290 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010534f:	8b 06                	mov    (%esi),%eax
80105351:	85 c0                	test   %eax,%eax
80105353:	75 0b                	jne    80105360 <holding+0x20>
  popcli();
80105355:	e8 86 ff ff ff       	call   801052e0 <popcli>
}
8010535a:	89 d8                	mov    %ebx,%eax
8010535c:	5b                   	pop    %ebx
8010535d:	5e                   	pop    %esi
8010535e:	5d                   	pop    %ebp
8010535f:	c3                   	ret
  r = lock->locked && lock->cpu == mycpu();
80105360:	8b 5e 08             	mov    0x8(%esi),%ebx
80105363:	e8 a8 f3 ff ff       	call   80104710 <mycpu>
80105368:	39 c3                	cmp    %eax,%ebx
8010536a:	0f 94 c3             	sete   %bl
  popcli();
8010536d:	e8 6e ff ff ff       	call   801052e0 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80105372:	0f b6 db             	movzbl %bl,%ebx
}
80105375:	89 d8                	mov    %ebx,%eax
80105377:	5b                   	pop    %ebx
80105378:	5e                   	pop    %esi
80105379:	5d                   	pop    %ebp
8010537a:	c3                   	ret
8010537b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105380 <release>:
{
80105380:	55                   	push   %ebp
80105381:	89 e5                	mov    %esp,%ebp
80105383:	56                   	push   %esi
80105384:	53                   	push   %ebx
80105385:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80105388:	e8 03 ff ff ff       	call   80105290 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010538d:	8b 03                	mov    (%ebx),%eax
8010538f:	85 c0                	test   %eax,%eax
80105391:	75 15                	jne    801053a8 <release+0x28>
  popcli();
80105393:	e8 48 ff ff ff       	call   801052e0 <popcli>
    panic("release");
80105398:	83 ec 0c             	sub    $0xc,%esp
8010539b:	68 af 89 10 80       	push   $0x801089af
801053a0:	e8 fb af ff ff       	call   801003a0 <panic>
801053a5:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
801053a8:	8b 73 08             	mov    0x8(%ebx),%esi
801053ab:	e8 60 f3 ff ff       	call   80104710 <mycpu>
801053b0:	39 c6                	cmp    %eax,%esi
801053b2:	75 df                	jne    80105393 <release+0x13>
  popcli();
801053b4:	e8 27 ff ff ff       	call   801052e0 <popcli>
  lk->pcs[0] = 0;
801053b9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801053c0:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801053c7:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801053cc:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801053d2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801053d5:	5b                   	pop    %ebx
801053d6:	5e                   	pop    %esi
801053d7:	5d                   	pop    %ebp
  popcli();
801053d8:	e9 03 ff ff ff       	jmp    801052e0 <popcli>
801053dd:	8d 76 00             	lea    0x0(%esi),%esi

801053e0 <acquire>:
{
801053e0:	55                   	push   %ebp
801053e1:	89 e5                	mov    %esp,%ebp
801053e3:	53                   	push   %ebx
801053e4:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
801053e7:	e8 a4 fe ff ff       	call   80105290 <pushcli>
  if(holding(lk))
801053ec:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801053ef:	e8 9c fe ff ff       	call   80105290 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801053f4:	8b 03                	mov    (%ebx),%eax
801053f6:	85 c0                	test   %eax,%eax
801053f8:	0f 85 b2 00 00 00    	jne    801054b0 <acquire+0xd0>
  popcli();
801053fe:	e8 dd fe ff ff       	call   801052e0 <popcli>
  asm volatile("lock; xchgl %0, %1" :
80105403:	b9 01 00 00 00       	mov    $0x1,%ecx
80105408:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010540f:	00 
  while(xchg(&lk->locked, 1) != 0)
80105410:	8b 55 08             	mov    0x8(%ebp),%edx
80105413:	89 c8                	mov    %ecx,%eax
80105415:	f0 87 02             	lock xchg %eax,(%edx)
80105418:	85 c0                	test   %eax,%eax
8010541a:	75 f4                	jne    80105410 <acquire+0x30>
  __sync_synchronize();
8010541c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80105421:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105424:	e8 e7 f2 ff ff       	call   80104710 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80105429:	8b 4d 08             	mov    0x8(%ebp),%ecx
  for(i = 0; i < 10; i++){
8010542c:	31 d2                	xor    %edx,%edx
  lk->cpu = mycpu();
8010542e:	89 43 08             	mov    %eax,0x8(%ebx)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105431:	8d 85 00 00 00 80    	lea    -0x80000000(%ebp),%eax
80105437:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
8010543c:	77 32                	ja     80105470 <acquire+0x90>
  ebp = (uint*)v - 2;
8010543e:	89 e8                	mov    %ebp,%eax
80105440:	eb 14                	jmp    80105456 <acquire+0x76>
80105442:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80105448:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
8010544e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80105454:	77 1a                	ja     80105470 <acquire+0x90>
    pcs[i] = ebp[1];     // saved %eip
80105456:	8b 58 04             	mov    0x4(%eax),%ebx
80105459:	89 5c 91 0c          	mov    %ebx,0xc(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
8010545d:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80105460:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80105462:	83 fa 0a             	cmp    $0xa,%edx
80105465:	75 e1                	jne    80105448 <acquire+0x68>
}
80105467:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010546a:	c9                   	leave
8010546b:	c3                   	ret
8010546c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105470:	8d 44 91 0c          	lea    0xc(%ecx,%edx,4),%eax
80105474:	83 c1 34             	add    $0x34,%ecx
80105477:	89 ca                	mov    %ecx,%edx
80105479:	29 c2                	sub    %eax,%edx
8010547b:	83 e2 04             	and    $0x4,%edx
8010547e:	74 10                	je     80105490 <acquire+0xb0>
    pcs[i] = 0;
80105480:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105486:	83 c0 04             	add    $0x4,%eax
80105489:	39 c1                	cmp    %eax,%ecx
8010548b:	74 da                	je     80105467 <acquire+0x87>
8010548d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80105490:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80105496:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80105499:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
801054a0:	39 c1                	cmp    %eax,%ecx
801054a2:	75 ec                	jne    80105490 <acquire+0xb0>
801054a4:	eb c1                	jmp    80105467 <acquire+0x87>
801054a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801054ad:	00 
801054ae:	66 90                	xchg   %ax,%ax
  r = lock->locked && lock->cpu == mycpu();
801054b0:	8b 5b 08             	mov    0x8(%ebx),%ebx
801054b3:	e8 58 f2 ff ff       	call   80104710 <mycpu>
801054b8:	39 c3                	cmp    %eax,%ebx
801054ba:	0f 85 3e ff ff ff    	jne    801053fe <acquire+0x1e>
  popcli();
801054c0:	e8 1b fe ff ff       	call   801052e0 <popcli>
    panic("acquire");
801054c5:	83 ec 0c             	sub    $0xc,%esp
801054c8:	68 b7 89 10 80       	push   $0x801089b7
801054cd:	e8 ce ae ff ff       	call   801003a0 <panic>
801054d2:	66 90                	xchg   %ax,%ax
801054d4:	66 90                	xchg   %ax,%ax
801054d6:	66 90                	xchg   %ax,%ax
801054d8:	66 90                	xchg   %ax,%ax
801054da:	66 90                	xchg   %ax,%ax
801054dc:	66 90                	xchg   %ax,%ax
801054de:	66 90                	xchg   %ax,%ax

801054e0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801054e0:	55                   	push   %ebp
801054e1:	89 e5                	mov    %esp,%ebp
801054e3:	57                   	push   %edi
801054e4:	8b 55 08             	mov    0x8(%ebp),%edx
801054e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801054ea:	89 d0                	mov    %edx,%eax
801054ec:	09 c8                	or     %ecx,%eax
801054ee:	a8 03                	test   $0x3,%al
801054f0:	75 1e                	jne    80105510 <memset+0x30>
    c &= 0xFF;
801054f2:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801054f6:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
801054f9:	89 d7                	mov    %edx,%edi
801054fb:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
80105501:	fc                   	cld
80105502:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80105504:	8b 7d fc             	mov    -0x4(%ebp),%edi
80105507:	89 d0                	mov    %edx,%eax
80105509:	c9                   	leave
8010550a:	c3                   	ret
8010550b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80105510:	8b 45 0c             	mov    0xc(%ebp),%eax
80105513:	89 d7                	mov    %edx,%edi
80105515:	fc                   	cld
80105516:	f3 aa                	rep stos %al,%es:(%edi)
80105518:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010551b:	89 d0                	mov    %edx,%eax
8010551d:	c9                   	leave
8010551e:	c3                   	ret
8010551f:	90                   	nop

80105520 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80105520:	55                   	push   %ebp
80105521:	89 e5                	mov    %esp,%ebp
80105523:	56                   	push   %esi
80105524:	8b 75 10             	mov    0x10(%ebp),%esi
80105527:	8b 45 08             	mov    0x8(%ebp),%eax
8010552a:	53                   	push   %ebx
8010552b:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010552e:	85 f6                	test   %esi,%esi
80105530:	74 2e                	je     80105560 <memcmp+0x40>
80105532:	01 c6                	add    %eax,%esi
80105534:	eb 14                	jmp    8010554a <memcmp+0x2a>
80105536:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010553d:	00 
8010553e:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80105540:	83 c0 01             	add    $0x1,%eax
80105543:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80105546:	39 f0                	cmp    %esi,%eax
80105548:	74 16                	je     80105560 <memcmp+0x40>
    if(*s1 != *s2)
8010554a:	0f b6 08             	movzbl (%eax),%ecx
8010554d:	0f b6 1a             	movzbl (%edx),%ebx
80105550:	38 d9                	cmp    %bl,%cl
80105552:	74 ec                	je     80105540 <memcmp+0x20>
      return *s1 - *s2;
80105554:	0f b6 c1             	movzbl %cl,%eax
80105557:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80105559:	5b                   	pop    %ebx
8010555a:	5e                   	pop    %esi
8010555b:	5d                   	pop    %ebp
8010555c:	c3                   	ret
8010555d:	8d 76 00             	lea    0x0(%esi),%esi
80105560:	5b                   	pop    %ebx
  return 0;
80105561:	31 c0                	xor    %eax,%eax
}
80105563:	5e                   	pop    %esi
80105564:	5d                   	pop    %ebp
80105565:	c3                   	ret
80105566:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010556d:	00 
8010556e:	66 90                	xchg   %ax,%ax

80105570 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80105570:	55                   	push   %ebp
80105571:	89 e5                	mov    %esp,%ebp
80105573:	57                   	push   %edi
80105574:	8b 55 08             	mov    0x8(%ebp),%edx
80105577:	8b 45 10             	mov    0x10(%ebp),%eax
8010557a:	56                   	push   %esi
8010557b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010557e:	39 d6                	cmp    %edx,%esi
80105580:	73 26                	jae    801055a8 <memmove+0x38>
80105582:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80105585:	39 ca                	cmp    %ecx,%edx
80105587:	73 1f                	jae    801055a8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80105589:	85 c0                	test   %eax,%eax
8010558b:	74 0f                	je     8010559c <memmove+0x2c>
8010558d:	83 e8 01             	sub    $0x1,%eax
      *--d = *--s;
80105590:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80105594:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80105597:	83 e8 01             	sub    $0x1,%eax
8010559a:	73 f4                	jae    80105590 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010559c:	5e                   	pop    %esi
8010559d:	89 d0                	mov    %edx,%eax
8010559f:	5f                   	pop    %edi
801055a0:	5d                   	pop    %ebp
801055a1:	c3                   	ret
801055a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
801055a8:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
801055ab:	89 d7                	mov    %edx,%edi
801055ad:	85 c0                	test   %eax,%eax
801055af:	74 eb                	je     8010559c <memmove+0x2c>
801055b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
801055b8:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
801055b9:	39 ce                	cmp    %ecx,%esi
801055bb:	75 fb                	jne    801055b8 <memmove+0x48>
}
801055bd:	5e                   	pop    %esi
801055be:	89 d0                	mov    %edx,%eax
801055c0:	5f                   	pop    %edi
801055c1:	5d                   	pop    %ebp
801055c2:	c3                   	ret
801055c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801055ca:	00 
801055cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801055d0 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
801055d0:	eb 9e                	jmp    80105570 <memmove>
801055d2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801055d9:	00 
801055da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801055e0 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
801055e0:	55                   	push   %ebp
801055e1:	89 e5                	mov    %esp,%ebp
801055e3:	53                   	push   %ebx
801055e4:	8b 55 10             	mov    0x10(%ebp),%edx
801055e7:	8b 45 08             	mov    0x8(%ebp),%eax
801055ea:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
801055ed:	85 d2                	test   %edx,%edx
801055ef:	75 16                	jne    80105607 <strncmp+0x27>
801055f1:	eb 2d                	jmp    80105620 <strncmp+0x40>
801055f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801055f8:	3a 19                	cmp    (%ecx),%bl
801055fa:	75 12                	jne    8010560e <strncmp+0x2e>
    n--, p++, q++;
801055fc:	83 c0 01             	add    $0x1,%eax
801055ff:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80105602:	83 ea 01             	sub    $0x1,%edx
80105605:	74 19                	je     80105620 <strncmp+0x40>
80105607:	0f b6 18             	movzbl (%eax),%ebx
8010560a:	84 db                	test   %bl,%bl
8010560c:	75 ea                	jne    801055f8 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010560e:	0f b6 00             	movzbl (%eax),%eax
80105611:	0f b6 11             	movzbl (%ecx),%edx
}
80105614:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105617:	c9                   	leave
  return (uchar)*p - (uchar)*q;
80105618:	29 d0                	sub    %edx,%eax
}
8010561a:	c3                   	ret
8010561b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105620:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80105623:	31 c0                	xor    %eax,%eax
}
80105625:	c9                   	leave
80105626:	c3                   	ret
80105627:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010562e:	00 
8010562f:	90                   	nop

80105630 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80105630:	55                   	push   %ebp
80105631:	89 e5                	mov    %esp,%ebp
80105633:	57                   	push   %edi
80105634:	56                   	push   %esi
80105635:	8b 75 08             	mov    0x8(%ebp),%esi
80105638:	53                   	push   %ebx
80105639:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
8010563c:	89 f0                	mov    %esi,%eax
8010563e:	eb 15                	jmp    80105655 <strncpy+0x25>
80105640:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80105644:	8b 7d 0c             	mov    0xc(%ebp),%edi
80105647:	83 c0 01             	add    $0x1,%eax
8010564a:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
8010564e:	88 48 ff             	mov    %cl,-0x1(%eax)
80105651:	84 c9                	test   %cl,%cl
80105653:	74 13                	je     80105668 <strncpy+0x38>
80105655:	89 d3                	mov    %edx,%ebx
80105657:	83 ea 01             	sub    $0x1,%edx
8010565a:	85 db                	test   %ebx,%ebx
8010565c:	7f e2                	jg     80105640 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
8010565e:	5b                   	pop    %ebx
8010565f:	89 f0                	mov    %esi,%eax
80105661:	5e                   	pop    %esi
80105662:	5f                   	pop    %edi
80105663:	5d                   	pop    %ebp
80105664:	c3                   	ret
80105665:	8d 76 00             	lea    0x0(%esi),%esi
  while(n-- > 0)
80105668:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
8010566b:	83 e9 01             	sub    $0x1,%ecx
8010566e:	85 d2                	test   %edx,%edx
80105670:	74 ec                	je     8010565e <strncpy+0x2e>
80105672:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *s++ = 0;
80105678:	83 c0 01             	add    $0x1,%eax
8010567b:	89 ca                	mov    %ecx,%edx
8010567d:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
80105681:	29 c2                	sub    %eax,%edx
80105683:	85 d2                	test   %edx,%edx
80105685:	7f f1                	jg     80105678 <strncpy+0x48>
}
80105687:	5b                   	pop    %ebx
80105688:	89 f0                	mov    %esi,%eax
8010568a:	5e                   	pop    %esi
8010568b:	5f                   	pop    %edi
8010568c:	5d                   	pop    %ebp
8010568d:	c3                   	ret
8010568e:	66 90                	xchg   %ax,%ax

80105690 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80105690:	55                   	push   %ebp
80105691:	89 e5                	mov    %esp,%ebp
80105693:	56                   	push   %esi
80105694:	8b 55 10             	mov    0x10(%ebp),%edx
80105697:	8b 75 08             	mov    0x8(%ebp),%esi
8010569a:	53                   	push   %ebx
8010569b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
8010569e:	85 d2                	test   %edx,%edx
801056a0:	7e 25                	jle    801056c7 <safestrcpy+0x37>
801056a2:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
801056a6:	89 f2                	mov    %esi,%edx
801056a8:	eb 16                	jmp    801056c0 <safestrcpy+0x30>
801056aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
801056b0:	0f b6 08             	movzbl (%eax),%ecx
801056b3:	83 c0 01             	add    $0x1,%eax
801056b6:	83 c2 01             	add    $0x1,%edx
801056b9:	88 4a ff             	mov    %cl,-0x1(%edx)
801056bc:	84 c9                	test   %cl,%cl
801056be:	74 04                	je     801056c4 <safestrcpy+0x34>
801056c0:	39 d8                	cmp    %ebx,%eax
801056c2:	75 ec                	jne    801056b0 <safestrcpy+0x20>
    ;
  *s = 0;
801056c4:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
801056c7:	89 f0                	mov    %esi,%eax
801056c9:	5b                   	pop    %ebx
801056ca:	5e                   	pop    %esi
801056cb:	5d                   	pop    %ebp
801056cc:	c3                   	ret
801056cd:	8d 76 00             	lea    0x0(%esi),%esi

801056d0 <strlen>:

int
strlen(const char *s)
{
801056d0:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
801056d1:	31 c0                	xor    %eax,%eax
{
801056d3:	89 e5                	mov    %esp,%ebp
801056d5:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
801056d8:	80 3a 00             	cmpb   $0x0,(%edx)
801056db:	74 0c                	je     801056e9 <strlen+0x19>
801056dd:	8d 76 00             	lea    0x0(%esi),%esi
801056e0:	83 c0 01             	add    $0x1,%eax
801056e3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
801056e7:	75 f7                	jne    801056e0 <strlen+0x10>
    ;
  return n;
}
801056e9:	5d                   	pop    %ebp
801056ea:	c3                   	ret

801056eb <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
801056eb:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
801056ef:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
801056f3:	55                   	push   %ebp
  pushl %ebx
801056f4:	53                   	push   %ebx
  pushl %esi
801056f5:	56                   	push   %esi
  pushl %edi
801056f6:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
801056f7:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
801056f9:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
801056fb:	5f                   	pop    %edi
  popl %esi
801056fc:	5e                   	pop    %esi
  popl %ebx
801056fd:	5b                   	pop    %ebx
  popl %ebp
801056fe:	5d                   	pop    %ebp
  ret
801056ff:	c3                   	ret

80105700 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80105700:	55                   	push   %ebp
80105701:	89 e5                	mov    %esp,%ebp
80105703:	53                   	push   %ebx
80105704:	83 ec 04             	sub    $0x4,%esp
80105707:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010570a:	e8 81 f0 ff ff       	call   80104790 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010570f:	8b 00                	mov    (%eax),%eax
80105711:	39 c3                	cmp    %eax,%ebx
80105713:	73 1b                	jae    80105730 <fetchint+0x30>
80105715:	8d 53 04             	lea    0x4(%ebx),%edx
80105718:	39 d0                	cmp    %edx,%eax
8010571a:	72 14                	jb     80105730 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
8010571c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010571f:	8b 13                	mov    (%ebx),%edx
80105721:	89 10                	mov    %edx,(%eax)
  return 0;
80105723:	31 c0                	xor    %eax,%eax
}
80105725:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105728:	c9                   	leave
80105729:	c3                   	ret
8010572a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105730:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105735:	eb ee                	jmp    80105725 <fetchint+0x25>
80105737:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010573e:	00 
8010573f:	90                   	nop

80105740 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80105740:	55                   	push   %ebp
80105741:	89 e5                	mov    %esp,%ebp
80105743:	53                   	push   %ebx
80105744:	83 ec 04             	sub    $0x4,%esp
80105747:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
8010574a:	e8 41 f0 ff ff       	call   80104790 <myproc>

  if(addr >= curproc->sz)
8010574f:	3b 18                	cmp    (%eax),%ebx
80105751:	73 2d                	jae    80105780 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80105753:	8b 55 0c             	mov    0xc(%ebp),%edx
80105756:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80105758:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010575a:	39 d3                	cmp    %edx,%ebx
8010575c:	73 22                	jae    80105780 <fetchstr+0x40>
8010575e:	89 d8                	mov    %ebx,%eax
80105760:	eb 0d                	jmp    8010576f <fetchstr+0x2f>
80105762:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105768:	83 c0 01             	add    $0x1,%eax
8010576b:	39 d0                	cmp    %edx,%eax
8010576d:	73 11                	jae    80105780 <fetchstr+0x40>
    if(*s == 0)
8010576f:	80 38 00             	cmpb   $0x0,(%eax)
80105772:	75 f4                	jne    80105768 <fetchstr+0x28>
      return s - *pp;
80105774:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80105776:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105779:	c9                   	leave
8010577a:	c3                   	ret
8010577b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105780:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80105783:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105788:	c9                   	leave
80105789:	c3                   	ret
8010578a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105790 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80105790:	55                   	push   %ebp
80105791:	89 e5                	mov    %esp,%ebp
80105793:	56                   	push   %esi
80105794:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105795:	e8 f6 ef ff ff       	call   80104790 <myproc>
8010579a:	8b 55 08             	mov    0x8(%ebp),%edx
8010579d:	8b 40 18             	mov    0x18(%eax),%eax
801057a0:	8b 40 44             	mov    0x44(%eax),%eax
801057a3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
801057a6:	e8 e5 ef ff ff       	call   80104790 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801057ab:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
801057ae:	8b 00                	mov    (%eax),%eax
801057b0:	39 c6                	cmp    %eax,%esi
801057b2:	73 1c                	jae    801057d0 <argint+0x40>
801057b4:	8d 53 08             	lea    0x8(%ebx),%edx
801057b7:	39 d0                	cmp    %edx,%eax
801057b9:	72 15                	jb     801057d0 <argint+0x40>
  *ip = *(int*)(addr);
801057bb:	8b 45 0c             	mov    0xc(%ebp),%eax
801057be:	8b 53 04             	mov    0x4(%ebx),%edx
801057c1:	89 10                	mov    %edx,(%eax)
  return 0;
801057c3:	31 c0                	xor    %eax,%eax
}
801057c5:	5b                   	pop    %ebx
801057c6:	5e                   	pop    %esi
801057c7:	5d                   	pop    %ebp
801057c8:	c3                   	ret
801057c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801057d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801057d5:	eb ee                	jmp    801057c5 <argint+0x35>
801057d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801057de:	00 
801057df:	90                   	nop

801057e0 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
801057e0:	55                   	push   %ebp
801057e1:	89 e5                	mov    %esp,%ebp
801057e3:	57                   	push   %edi
801057e4:	56                   	push   %esi
801057e5:	53                   	push   %ebx
801057e6:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
801057e9:	e8 a2 ef ff ff       	call   80104790 <myproc>
801057ee:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801057f0:	e8 9b ef ff ff       	call   80104790 <myproc>
801057f5:	8b 55 08             	mov    0x8(%ebp),%edx
801057f8:	8b 40 18             	mov    0x18(%eax),%eax
801057fb:	8b 40 44             	mov    0x44(%eax),%eax
801057fe:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105801:	e8 8a ef ff ff       	call   80104790 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105806:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80105809:	8b 00                	mov    (%eax),%eax
8010580b:	39 c7                	cmp    %eax,%edi
8010580d:	73 31                	jae    80105840 <argptr+0x60>
8010580f:	8d 4b 08             	lea    0x8(%ebx),%ecx
80105812:	39 c8                	cmp    %ecx,%eax
80105814:	72 2a                	jb     80105840 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80105816:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80105819:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
8010581c:	85 d2                	test   %edx,%edx
8010581e:	78 20                	js     80105840 <argptr+0x60>
80105820:	8b 16                	mov    (%esi),%edx
80105822:	39 d0                	cmp    %edx,%eax
80105824:	73 1a                	jae    80105840 <argptr+0x60>
80105826:	8b 5d 10             	mov    0x10(%ebp),%ebx
80105829:	01 c3                	add    %eax,%ebx
8010582b:	39 da                	cmp    %ebx,%edx
8010582d:	72 11                	jb     80105840 <argptr+0x60>
    return -1;
  *pp = (char*)i;
8010582f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105832:	89 02                	mov    %eax,(%edx)
  return 0;
80105834:	31 c0                	xor    %eax,%eax
}
80105836:	83 c4 0c             	add    $0xc,%esp
80105839:	5b                   	pop    %ebx
8010583a:	5e                   	pop    %esi
8010583b:	5f                   	pop    %edi
8010583c:	5d                   	pop    %ebp
8010583d:	c3                   	ret
8010583e:	66 90                	xchg   %ax,%ax
    return -1;
80105840:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105845:	eb ef                	jmp    80105836 <argptr+0x56>
80105847:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010584e:	00 
8010584f:	90                   	nop

80105850 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80105850:	55                   	push   %ebp
80105851:	89 e5                	mov    %esp,%ebp
80105853:	56                   	push   %esi
80105854:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80105855:	e8 36 ef ff ff       	call   80104790 <myproc>
8010585a:	8b 55 08             	mov    0x8(%ebp),%edx
8010585d:	8b 40 18             	mov    0x18(%eax),%eax
80105860:	8b 40 44             	mov    0x44(%eax),%eax
80105863:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80105866:	e8 25 ef ff ff       	call   80104790 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
8010586b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010586e:	8b 00                	mov    (%eax),%eax
80105870:	39 c6                	cmp    %eax,%esi
80105872:	73 44                	jae    801058b8 <argstr+0x68>
80105874:	8d 53 08             	lea    0x8(%ebx),%edx
80105877:	39 d0                	cmp    %edx,%eax
80105879:	72 3d                	jb     801058b8 <argstr+0x68>
  *ip = *(int*)(addr);
8010587b:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
8010587e:	e8 0d ef ff ff       	call   80104790 <myproc>
  if(addr >= curproc->sz)
80105883:	3b 18                	cmp    (%eax),%ebx
80105885:	73 31                	jae    801058b8 <argstr+0x68>
  *pp = (char*)addr;
80105887:	8b 55 0c             	mov    0xc(%ebp),%edx
8010588a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
8010588c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
8010588e:	39 d3                	cmp    %edx,%ebx
80105890:	73 26                	jae    801058b8 <argstr+0x68>
80105892:	89 d8                	mov    %ebx,%eax
80105894:	eb 11                	jmp    801058a7 <argstr+0x57>
80105896:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010589d:	00 
8010589e:	66 90                	xchg   %ax,%ax
801058a0:	83 c0 01             	add    $0x1,%eax
801058a3:	39 d0                	cmp    %edx,%eax
801058a5:	73 11                	jae    801058b8 <argstr+0x68>
    if(*s == 0)
801058a7:	80 38 00             	cmpb   $0x0,(%eax)
801058aa:	75 f4                	jne    801058a0 <argstr+0x50>
      return s - *pp;
801058ac:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
801058ae:	5b                   	pop    %ebx
801058af:	5e                   	pop    %esi
801058b0:	5d                   	pop    %ebp
801058b1:	c3                   	ret
801058b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801058b8:	5b                   	pop    %ebx
    return -1;
801058b9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058be:	5e                   	pop    %esi
801058bf:	5d                   	pop    %ebp
801058c0:	c3                   	ret
801058c1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801058c8:	00 
801058c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801058d0 <syscall>:
[SYS_getcmostime] sys_getcmostime,
};

void
syscall(void)
{
801058d0:	55                   	push   %ebp
801058d1:	89 e5                	mov    %esp,%ebp
801058d3:	56                   	push   %esi
801058d4:	53                   	push   %ebx
  int num;
  struct proc *curproc = myproc();
801058d5:	e8 b6 ee ff ff       	call   80104790 <myproc>
801058da:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
801058dc:	8b 40 18             	mov    0x18(%eax),%eax
801058df:	8b 70 1c             	mov    0x1c(%eax),%esi
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801058e2:	8d 46 ff             	lea    -0x1(%esi),%eax
801058e5:	83 f8 1b             	cmp    $0x1b,%eax
801058e8:	77 36                	ja     80105920 <syscall+0x50>
801058ea:	8b 04 b5 00 90 10 80 	mov    -0x7fef7000(,%esi,4),%eax
801058f1:	85 c0                	test   %eax,%eax
801058f3:	74 2b                	je     80105920 <syscall+0x50>
    curproc->tf->eax = syscalls[num]();
801058f5:	ff d0                	call   *%eax
801058f7:	89 c2                	mov    %eax,%edx
801058f9:	8b 43 18             	mov    0x18(%ebx),%eax
801058fc:	89 50 1c             	mov    %edx,0x1c(%eax)

    // Ive added this line which logs each systemcall:
    if(num != SYS_write)
801058ff:	83 fe 10             	cmp    $0x10,%esi
80105902:	74 3b                	je     8010593f <syscall+0x6f>
      log_syscall(num);
80105904:	83 ec 0c             	sub    $0xc,%esp
80105907:	56                   	push   %esi
80105908:	e8 13 c4 ff ff       	call   80101d20 <log_syscall>
8010590d:	83 c4 10             	add    $0x10,%esp
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80105910:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105913:	5b                   	pop    %ebx
80105914:	5e                   	pop    %esi
80105915:	5d                   	pop    %ebp
80105916:	c3                   	ret
80105917:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010591e:	00 
8010591f:	90                   	nop
            curproc->pid, curproc->name, num);
80105920:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80105923:	56                   	push   %esi
80105924:	50                   	push   %eax
80105925:	ff 73 10             	push   0x10(%ebx)
80105928:	68 bf 89 10 80       	push   $0x801089bf
8010592d:	e8 0e b3 ff ff       	call   80100c40 <cprintf>
    curproc->tf->eax = -1;
80105932:	8b 43 18             	mov    0x18(%ebx),%eax
80105935:	83 c4 10             	add    $0x10,%esp
80105938:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
8010593f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105942:	5b                   	pop    %ebx
80105943:	5e                   	pop    %esi
80105944:	5d                   	pop    %ebp
80105945:	c3                   	ret
80105946:	66 90                	xchg   %ax,%ax
80105948:	66 90                	xchg   %ax,%ax
8010594a:	66 90                	xchg   %ax,%ax
8010594c:	66 90                	xchg   %ax,%ax
8010594e:	66 90                	xchg   %ax,%ax

80105950 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80105950:	55                   	push   %ebp
80105951:	89 e5                	mov    %esp,%ebp
80105953:	57                   	push   %edi
80105954:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80105955:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80105958:	53                   	push   %ebx
80105959:	83 ec 34             	sub    $0x34,%esp
8010595c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010595f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105962:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80105965:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80105968:	57                   	push   %edi
80105969:	50                   	push   %eax
8010596a:	e8 41 d5 ff ff       	call   80102eb0 <nameiparent>
8010596f:	83 c4 10             	add    $0x10,%esp
80105972:	85 c0                	test   %eax,%eax
80105974:	74 5e                	je     801059d4 <create+0x84>
    return 0;
  ilock(dp);
80105976:	83 ec 0c             	sub    $0xc,%esp
80105979:	89 c3                	mov    %eax,%ebx
8010597b:	50                   	push   %eax
8010597c:	e8 2f cc ff ff       	call   801025b0 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80105981:	83 c4 0c             	add    $0xc,%esp
80105984:	6a 00                	push   $0x0
80105986:	57                   	push   %edi
80105987:	53                   	push   %ebx
80105988:	e8 73 d1 ff ff       	call   80102b00 <dirlookup>
8010598d:	83 c4 10             	add    $0x10,%esp
80105990:	89 c6                	mov    %eax,%esi
80105992:	85 c0                	test   %eax,%eax
80105994:	74 4a                	je     801059e0 <create+0x90>
    iunlockput(dp);
80105996:	83 ec 0c             	sub    $0xc,%esp
80105999:	53                   	push   %ebx
8010599a:	e8 a1 ce ff ff       	call   80102840 <iunlockput>
    ilock(ip);
8010599f:	89 34 24             	mov    %esi,(%esp)
801059a2:	e8 09 cc ff ff       	call   801025b0 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
801059a7:	83 c4 10             	add    $0x10,%esp
801059aa:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801059af:	75 17                	jne    801059c8 <create+0x78>
801059b1:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
801059b6:	75 10                	jne    801059c8 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
801059b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059bb:	89 f0                	mov    %esi,%eax
801059bd:	5b                   	pop    %ebx
801059be:	5e                   	pop    %esi
801059bf:	5f                   	pop    %edi
801059c0:	5d                   	pop    %ebp
801059c1:	c3                   	ret
801059c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
801059c8:	83 ec 0c             	sub    $0xc,%esp
801059cb:	56                   	push   %esi
801059cc:	e8 6f ce ff ff       	call   80102840 <iunlockput>
    return 0;
801059d1:	83 c4 10             	add    $0x10,%esp
}
801059d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
801059d7:	31 f6                	xor    %esi,%esi
}
801059d9:	5b                   	pop    %ebx
801059da:	89 f0                	mov    %esi,%eax
801059dc:	5e                   	pop    %esi
801059dd:	5f                   	pop    %edi
801059de:	5d                   	pop    %ebp
801059df:	c3                   	ret
  if((ip = ialloc(dp->dev, type)) == 0)
801059e0:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
801059e4:	83 ec 08             	sub    $0x8,%esp
801059e7:	50                   	push   %eax
801059e8:	ff 33                	push   (%ebx)
801059ea:	e8 51 ca ff ff       	call   80102440 <ialloc>
801059ef:	83 c4 10             	add    $0x10,%esp
801059f2:	89 c6                	mov    %eax,%esi
801059f4:	85 c0                	test   %eax,%eax
801059f6:	0f 84 bc 00 00 00    	je     80105ab8 <create+0x168>
  ilock(ip);
801059fc:	83 ec 0c             	sub    $0xc,%esp
801059ff:	50                   	push   %eax
80105a00:	e8 ab cb ff ff       	call   801025b0 <ilock>
  ip->major = major;
80105a05:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105a09:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80105a0d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105a11:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80105a15:	b8 01 00 00 00       	mov    $0x1,%eax
80105a1a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80105a1e:	89 34 24             	mov    %esi,(%esp)
80105a21:	e8 da ca ff ff       	call   80102500 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80105a26:	83 c4 10             	add    $0x10,%esp
80105a29:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80105a2e:	74 30                	je     80105a60 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
80105a30:	83 ec 04             	sub    $0x4,%esp
80105a33:	ff 76 04             	push   0x4(%esi)
80105a36:	57                   	push   %edi
80105a37:	53                   	push   %ebx
80105a38:	e8 93 d3 ff ff       	call   80102dd0 <dirlink>
80105a3d:	83 c4 10             	add    $0x10,%esp
80105a40:	85 c0                	test   %eax,%eax
80105a42:	78 67                	js     80105aab <create+0x15b>
  iunlockput(dp);
80105a44:	83 ec 0c             	sub    $0xc,%esp
80105a47:	53                   	push   %ebx
80105a48:	e8 f3 cd ff ff       	call   80102840 <iunlockput>
  return ip;
80105a4d:	83 c4 10             	add    $0x10,%esp
}
80105a50:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a53:	89 f0                	mov    %esi,%eax
80105a55:	5b                   	pop    %ebx
80105a56:	5e                   	pop    %esi
80105a57:	5f                   	pop    %edi
80105a58:	5d                   	pop    %ebp
80105a59:	c3                   	ret
80105a5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80105a60:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80105a63:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80105a68:	53                   	push   %ebx
80105a69:	e8 92 ca ff ff       	call   80102500 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80105a6e:	83 c4 0c             	add    $0xc,%esp
80105a71:	ff 76 04             	push   0x4(%esi)
80105a74:	68 f7 89 10 80       	push   $0x801089f7
80105a79:	56                   	push   %esi
80105a7a:	e8 51 d3 ff ff       	call   80102dd0 <dirlink>
80105a7f:	83 c4 10             	add    $0x10,%esp
80105a82:	85 c0                	test   %eax,%eax
80105a84:	78 18                	js     80105a9e <create+0x14e>
80105a86:	83 ec 04             	sub    $0x4,%esp
80105a89:	ff 73 04             	push   0x4(%ebx)
80105a8c:	68 f6 89 10 80       	push   $0x801089f6
80105a91:	56                   	push   %esi
80105a92:	e8 39 d3 ff ff       	call   80102dd0 <dirlink>
80105a97:	83 c4 10             	add    $0x10,%esp
80105a9a:	85 c0                	test   %eax,%eax
80105a9c:	79 92                	jns    80105a30 <create+0xe0>
      panic("create dots");
80105a9e:	83 ec 0c             	sub    $0xc,%esp
80105aa1:	68 ea 89 10 80       	push   $0x801089ea
80105aa6:	e8 f5 a8 ff ff       	call   801003a0 <panic>
    panic("create: dirlink");
80105aab:	83 ec 0c             	sub    $0xc,%esp
80105aae:	68 f9 89 10 80       	push   $0x801089f9
80105ab3:	e8 e8 a8 ff ff       	call   801003a0 <panic>
    panic("create: ialloc");
80105ab8:	83 ec 0c             	sub    $0xc,%esp
80105abb:	68 db 89 10 80       	push   $0x801089db
80105ac0:	e8 db a8 ff ff       	call   801003a0 <panic>
80105ac5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105acc:	00 
80105acd:	8d 76 00             	lea    0x0(%esi),%esi

80105ad0 <sys_dup>:
{
80105ad0:	55                   	push   %ebp
80105ad1:	89 e5                	mov    %esp,%ebp
80105ad3:	56                   	push   %esi
80105ad4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105ad5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105ad8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105adb:	50                   	push   %eax
80105adc:	6a 00                	push   $0x0
80105ade:	e8 ad fc ff ff       	call   80105790 <argint>
80105ae3:	83 c4 10             	add    $0x10,%esp
80105ae6:	85 c0                	test   %eax,%eax
80105ae8:	78 36                	js     80105b20 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105aea:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105aee:	77 30                	ja     80105b20 <sys_dup+0x50>
80105af0:	e8 9b ec ff ff       	call   80104790 <myproc>
80105af5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105af8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105afc:	85 f6                	test   %esi,%esi
80105afe:	74 20                	je     80105b20 <sys_dup+0x50>
  struct proc *curproc = myproc();
80105b00:	e8 8b ec ff ff       	call   80104790 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80105b05:	31 db                	xor    %ebx,%ebx
80105b07:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105b0e:	00 
80105b0f:	90                   	nop
    if(curproc->ofile[fd] == 0){
80105b10:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105b14:	85 d2                	test   %edx,%edx
80105b16:	74 18                	je     80105b30 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80105b18:	83 c3 01             	add    $0x1,%ebx
80105b1b:	83 fb 10             	cmp    $0x10,%ebx
80105b1e:	75 f0                	jne    80105b10 <sys_dup+0x40>
}
80105b20:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80105b23:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80105b28:	89 d8                	mov    %ebx,%eax
80105b2a:	5b                   	pop    %ebx
80105b2b:	5e                   	pop    %esi
80105b2c:	5d                   	pop    %ebp
80105b2d:	c3                   	ret
80105b2e:	66 90                	xchg   %ax,%ax
  filedup(f);
80105b30:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105b33:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80105b37:	56                   	push   %esi
80105b38:	e8 03 bc ff ff       	call   80101740 <filedup>
  return fd;
80105b3d:	83 c4 10             	add    $0x10,%esp
}
80105b40:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105b43:	89 d8                	mov    %ebx,%eax
80105b45:	5b                   	pop    %ebx
80105b46:	5e                   	pop    %esi
80105b47:	5d                   	pop    %ebp
80105b48:	c3                   	ret
80105b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105b50 <sys_read>:
{
80105b50:	55                   	push   %ebp
80105b51:	89 e5                	mov    %esp,%ebp
80105b53:	56                   	push   %esi
80105b54:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105b55:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105b58:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105b5b:	53                   	push   %ebx
80105b5c:	6a 00                	push   $0x0
80105b5e:	e8 2d fc ff ff       	call   80105790 <argint>
80105b63:	83 c4 10             	add    $0x10,%esp
80105b66:	85 c0                	test   %eax,%eax
80105b68:	78 5e                	js     80105bc8 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105b6a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105b6e:	77 58                	ja     80105bc8 <sys_read+0x78>
80105b70:	e8 1b ec ff ff       	call   80104790 <myproc>
80105b75:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105b78:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105b7c:	85 f6                	test   %esi,%esi
80105b7e:	74 48                	je     80105bc8 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105b80:	83 ec 08             	sub    $0x8,%esp
80105b83:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105b86:	50                   	push   %eax
80105b87:	6a 02                	push   $0x2
80105b89:	e8 02 fc ff ff       	call   80105790 <argint>
80105b8e:	83 c4 10             	add    $0x10,%esp
80105b91:	85 c0                	test   %eax,%eax
80105b93:	78 33                	js     80105bc8 <sys_read+0x78>
80105b95:	83 ec 04             	sub    $0x4,%esp
80105b98:	ff 75 f0             	push   -0x10(%ebp)
80105b9b:	53                   	push   %ebx
80105b9c:	6a 01                	push   $0x1
80105b9e:	e8 3d fc ff ff       	call   801057e0 <argptr>
80105ba3:	83 c4 10             	add    $0x10,%esp
80105ba6:	85 c0                	test   %eax,%eax
80105ba8:	78 1e                	js     80105bc8 <sys_read+0x78>
  return fileread(f, p, n);
80105baa:	83 ec 04             	sub    $0x4,%esp
80105bad:	ff 75 f0             	push   -0x10(%ebp)
80105bb0:	ff 75 f4             	push   -0xc(%ebp)
80105bb3:	56                   	push   %esi
80105bb4:	e8 07 bd ff ff       	call   801018c0 <fileread>
80105bb9:	83 c4 10             	add    $0x10,%esp
}
80105bbc:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105bbf:	5b                   	pop    %ebx
80105bc0:	5e                   	pop    %esi
80105bc1:	5d                   	pop    %ebp
80105bc2:	c3                   	ret
80105bc3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80105bc8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bcd:	eb ed                	jmp    80105bbc <sys_read+0x6c>
80105bcf:	90                   	nop

80105bd0 <sys_write>:
{
80105bd0:	55                   	push   %ebp
80105bd1:	89 e5                	mov    %esp,%ebp
80105bd3:	56                   	push   %esi
80105bd4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105bd5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105bd8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105bdb:	53                   	push   %ebx
80105bdc:	6a 00                	push   $0x0
80105bde:	e8 ad fb ff ff       	call   80105790 <argint>
80105be3:	83 c4 10             	add    $0x10,%esp
80105be6:	85 c0                	test   %eax,%eax
80105be8:	78 5e                	js     80105c48 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105bea:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105bee:	77 58                	ja     80105c48 <sys_write+0x78>
80105bf0:	e8 9b eb ff ff       	call   80104790 <myproc>
80105bf5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105bf8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105bfc:	85 f6                	test   %esi,%esi
80105bfe:	74 48                	je     80105c48 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105c00:	83 ec 08             	sub    $0x8,%esp
80105c03:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105c06:	50                   	push   %eax
80105c07:	6a 02                	push   $0x2
80105c09:	e8 82 fb ff ff       	call   80105790 <argint>
80105c0e:	83 c4 10             	add    $0x10,%esp
80105c11:	85 c0                	test   %eax,%eax
80105c13:	78 33                	js     80105c48 <sys_write+0x78>
80105c15:	83 ec 04             	sub    $0x4,%esp
80105c18:	ff 75 f0             	push   -0x10(%ebp)
80105c1b:	53                   	push   %ebx
80105c1c:	6a 01                	push   $0x1
80105c1e:	e8 bd fb ff ff       	call   801057e0 <argptr>
80105c23:	83 c4 10             	add    $0x10,%esp
80105c26:	85 c0                	test   %eax,%eax
80105c28:	78 1e                	js     80105c48 <sys_write+0x78>
  return filewrite(f, p, n);
80105c2a:	83 ec 04             	sub    $0x4,%esp
80105c2d:	ff 75 f0             	push   -0x10(%ebp)
80105c30:	ff 75 f4             	push   -0xc(%ebp)
80105c33:	56                   	push   %esi
80105c34:	e8 17 bd ff ff       	call   80101950 <filewrite>
80105c39:	83 c4 10             	add    $0x10,%esp
}
80105c3c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105c3f:	5b                   	pop    %ebx
80105c40:	5e                   	pop    %esi
80105c41:	5d                   	pop    %ebp
80105c42:	c3                   	ret
80105c43:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80105c48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c4d:	eb ed                	jmp    80105c3c <sys_write+0x6c>
80105c4f:	90                   	nop

80105c50 <sys_close>:
{
80105c50:	55                   	push   %ebp
80105c51:	89 e5                	mov    %esp,%ebp
80105c53:	56                   	push   %esi
80105c54:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105c55:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105c58:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105c5b:	50                   	push   %eax
80105c5c:	6a 00                	push   $0x0
80105c5e:	e8 2d fb ff ff       	call   80105790 <argint>
80105c63:	83 c4 10             	add    $0x10,%esp
80105c66:	85 c0                	test   %eax,%eax
80105c68:	78 3e                	js     80105ca8 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105c6a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105c6e:	77 38                	ja     80105ca8 <sys_close+0x58>
80105c70:	e8 1b eb ff ff       	call   80104790 <myproc>
80105c75:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105c78:	8d 5a 08             	lea    0x8(%edx),%ebx
80105c7b:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
80105c7f:	85 f6                	test   %esi,%esi
80105c81:	74 25                	je     80105ca8 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80105c83:	e8 08 eb ff ff       	call   80104790 <myproc>
  fileclose(f);
80105c88:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80105c8b:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80105c92:	00 
  fileclose(f);
80105c93:	56                   	push   %esi
80105c94:	e8 f7 ba ff ff       	call   80101790 <fileclose>
  return 0;
80105c99:	83 c4 10             	add    $0x10,%esp
80105c9c:	31 c0                	xor    %eax,%eax
}
80105c9e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105ca1:	5b                   	pop    %ebx
80105ca2:	5e                   	pop    %esi
80105ca3:	5d                   	pop    %ebp
80105ca4:	c3                   	ret
80105ca5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105ca8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105cad:	eb ef                	jmp    80105c9e <sys_close+0x4e>
80105caf:	90                   	nop

80105cb0 <sys_fstat>:
{
80105cb0:	55                   	push   %ebp
80105cb1:	89 e5                	mov    %esp,%ebp
80105cb3:	56                   	push   %esi
80105cb4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105cb5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105cb8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80105cbb:	53                   	push   %ebx
80105cbc:	6a 00                	push   $0x0
80105cbe:	e8 cd fa ff ff       	call   80105790 <argint>
80105cc3:	83 c4 10             	add    $0x10,%esp
80105cc6:	85 c0                	test   %eax,%eax
80105cc8:	78 46                	js     80105d10 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80105cca:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80105cce:	77 40                	ja     80105d10 <sys_fstat+0x60>
80105cd0:	e8 bb ea ff ff       	call   80104790 <myproc>
80105cd5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105cd8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80105cdc:	85 f6                	test   %esi,%esi
80105cde:	74 30                	je     80105d10 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105ce0:	83 ec 04             	sub    $0x4,%esp
80105ce3:	6a 14                	push   $0x14
80105ce5:	53                   	push   %ebx
80105ce6:	6a 01                	push   $0x1
80105ce8:	e8 f3 fa ff ff       	call   801057e0 <argptr>
80105ced:	83 c4 10             	add    $0x10,%esp
80105cf0:	85 c0                	test   %eax,%eax
80105cf2:	78 1c                	js     80105d10 <sys_fstat+0x60>
  return filestat(f, st);
80105cf4:	83 ec 08             	sub    $0x8,%esp
80105cf7:	ff 75 f4             	push   -0xc(%ebp)
80105cfa:	56                   	push   %esi
80105cfb:	e8 70 bb ff ff       	call   80101870 <filestat>
80105d00:	83 c4 10             	add    $0x10,%esp
}
80105d03:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105d06:	5b                   	pop    %ebx
80105d07:	5e                   	pop    %esi
80105d08:	5d                   	pop    %ebp
80105d09:	c3                   	ret
80105d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105d10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d15:	eb ec                	jmp    80105d03 <sys_fstat+0x53>
80105d17:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d1e:	00 
80105d1f:	90                   	nop

80105d20 <sys_link>:
{
80105d20:	55                   	push   %ebp
80105d21:	89 e5                	mov    %esp,%ebp
80105d23:	57                   	push   %edi
80105d24:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105d25:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105d28:	53                   	push   %ebx
80105d29:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105d2c:	50                   	push   %eax
80105d2d:	6a 00                	push   $0x0
80105d2f:	e8 1c fb ff ff       	call   80105850 <argstr>
80105d34:	83 c4 10             	add    $0x10,%esp
80105d37:	85 c0                	test   %eax,%eax
80105d39:	0f 88 fb 00 00 00    	js     80105e3a <sys_link+0x11a>
80105d3f:	83 ec 08             	sub    $0x8,%esp
80105d42:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105d45:	50                   	push   %eax
80105d46:	6a 01                	push   $0x1
80105d48:	e8 03 fb ff ff       	call   80105850 <argstr>
80105d4d:	83 c4 10             	add    $0x10,%esp
80105d50:	85 c0                	test   %eax,%eax
80105d52:	0f 88 e2 00 00 00    	js     80105e3a <sys_link+0x11a>
  begin_op();
80105d58:	e8 03 de ff ff       	call   80103b60 <begin_op>
  if((ip = namei(old)) == 0){
80105d5d:	83 ec 0c             	sub    $0xc,%esp
80105d60:	ff 75 d4             	push   -0x2c(%ebp)
80105d63:	e8 28 d1 ff ff       	call   80102e90 <namei>
80105d68:	83 c4 10             	add    $0x10,%esp
80105d6b:	89 c3                	mov    %eax,%ebx
80105d6d:	85 c0                	test   %eax,%eax
80105d6f:	0f 84 df 00 00 00    	je     80105e54 <sys_link+0x134>
  ilock(ip);
80105d75:	83 ec 0c             	sub    $0xc,%esp
80105d78:	50                   	push   %eax
80105d79:	e8 32 c8 ff ff       	call   801025b0 <ilock>
  if(ip->type == T_DIR){
80105d7e:	83 c4 10             	add    $0x10,%esp
80105d81:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105d86:	0f 84 b5 00 00 00    	je     80105e41 <sys_link+0x121>
  iupdate(ip);
80105d8c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
80105d8f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105d94:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105d97:	53                   	push   %ebx
80105d98:	e8 63 c7 ff ff       	call   80102500 <iupdate>
  iunlock(ip);
80105d9d:	89 1c 24             	mov    %ebx,(%esp)
80105da0:	e8 eb c8 ff ff       	call   80102690 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105da5:	58                   	pop    %eax
80105da6:	5a                   	pop    %edx
80105da7:	57                   	push   %edi
80105da8:	ff 75 d0             	push   -0x30(%ebp)
80105dab:	e8 00 d1 ff ff       	call   80102eb0 <nameiparent>
80105db0:	83 c4 10             	add    $0x10,%esp
80105db3:	89 c6                	mov    %eax,%esi
80105db5:	85 c0                	test   %eax,%eax
80105db7:	74 5b                	je     80105e14 <sys_link+0xf4>
  ilock(dp);
80105db9:	83 ec 0c             	sub    $0xc,%esp
80105dbc:	50                   	push   %eax
80105dbd:	e8 ee c7 ff ff       	call   801025b0 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105dc2:	8b 03                	mov    (%ebx),%eax
80105dc4:	83 c4 10             	add    $0x10,%esp
80105dc7:	39 06                	cmp    %eax,(%esi)
80105dc9:	75 3d                	jne    80105e08 <sys_link+0xe8>
80105dcb:	83 ec 04             	sub    $0x4,%esp
80105dce:	ff 73 04             	push   0x4(%ebx)
80105dd1:	57                   	push   %edi
80105dd2:	56                   	push   %esi
80105dd3:	e8 f8 cf ff ff       	call   80102dd0 <dirlink>
80105dd8:	83 c4 10             	add    $0x10,%esp
80105ddb:	85 c0                	test   %eax,%eax
80105ddd:	78 29                	js     80105e08 <sys_link+0xe8>
  iunlockput(dp);
80105ddf:	83 ec 0c             	sub    $0xc,%esp
80105de2:	56                   	push   %esi
80105de3:	e8 58 ca ff ff       	call   80102840 <iunlockput>
  iput(ip);
80105de8:	89 1c 24             	mov    %ebx,(%esp)
80105deb:	e8 f0 c8 ff ff       	call   801026e0 <iput>
  end_op();
80105df0:	e8 db dd ff ff       	call   80103bd0 <end_op>
  return 0;
80105df5:	83 c4 10             	add    $0x10,%esp
80105df8:	31 c0                	xor    %eax,%eax
}
80105dfa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105dfd:	5b                   	pop    %ebx
80105dfe:	5e                   	pop    %esi
80105dff:	5f                   	pop    %edi
80105e00:	5d                   	pop    %ebp
80105e01:	c3                   	ret
80105e02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105e08:	83 ec 0c             	sub    $0xc,%esp
80105e0b:	56                   	push   %esi
80105e0c:	e8 2f ca ff ff       	call   80102840 <iunlockput>
    goto bad;
80105e11:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105e14:	83 ec 0c             	sub    $0xc,%esp
80105e17:	53                   	push   %ebx
80105e18:	e8 93 c7 ff ff       	call   801025b0 <ilock>
  ip->nlink--;
80105e1d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105e22:	89 1c 24             	mov    %ebx,(%esp)
80105e25:	e8 d6 c6 ff ff       	call   80102500 <iupdate>
  iunlockput(ip);
80105e2a:	89 1c 24             	mov    %ebx,(%esp)
80105e2d:	e8 0e ca ff ff       	call   80102840 <iunlockput>
  end_op();
80105e32:	e8 99 dd ff ff       	call   80103bd0 <end_op>
  return -1;
80105e37:	83 c4 10             	add    $0x10,%esp
    return -1;
80105e3a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e3f:	eb b9                	jmp    80105dfa <sys_link+0xda>
    iunlockput(ip);
80105e41:	83 ec 0c             	sub    $0xc,%esp
80105e44:	53                   	push   %ebx
80105e45:	e8 f6 c9 ff ff       	call   80102840 <iunlockput>
    end_op();
80105e4a:	e8 81 dd ff ff       	call   80103bd0 <end_op>
    return -1;
80105e4f:	83 c4 10             	add    $0x10,%esp
80105e52:	eb e6                	jmp    80105e3a <sys_link+0x11a>
    end_op();
80105e54:	e8 77 dd ff ff       	call   80103bd0 <end_op>
    return -1;
80105e59:	eb df                	jmp    80105e3a <sys_link+0x11a>
80105e5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105e60 <sys_unlink>:
{
80105e60:	55                   	push   %ebp
80105e61:	89 e5                	mov    %esp,%ebp
80105e63:	57                   	push   %edi
80105e64:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105e65:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105e68:	53                   	push   %ebx
80105e69:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
80105e6c:	50                   	push   %eax
80105e6d:	6a 00                	push   $0x0
80105e6f:	e8 dc f9 ff ff       	call   80105850 <argstr>
80105e74:	83 c4 10             	add    $0x10,%esp
80105e77:	85 c0                	test   %eax,%eax
80105e79:	0f 88 54 01 00 00    	js     80105fd3 <sys_unlink+0x173>
  begin_op();
80105e7f:	e8 dc dc ff ff       	call   80103b60 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105e84:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105e87:	83 ec 08             	sub    $0x8,%esp
80105e8a:	53                   	push   %ebx
80105e8b:	ff 75 c0             	push   -0x40(%ebp)
80105e8e:	e8 1d d0 ff ff       	call   80102eb0 <nameiparent>
80105e93:	83 c4 10             	add    $0x10,%esp
80105e96:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105e99:	85 c0                	test   %eax,%eax
80105e9b:	0f 84 58 01 00 00    	je     80105ff9 <sys_unlink+0x199>
  ilock(dp);
80105ea1:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105ea4:	83 ec 0c             	sub    $0xc,%esp
80105ea7:	57                   	push   %edi
80105ea8:	e8 03 c7 ff ff       	call   801025b0 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80105ead:	58                   	pop    %eax
80105eae:	5a                   	pop    %edx
80105eaf:	68 f7 89 10 80       	push   $0x801089f7
80105eb4:	53                   	push   %ebx
80105eb5:	e8 26 cc ff ff       	call   80102ae0 <namecmp>
80105eba:	83 c4 10             	add    $0x10,%esp
80105ebd:	85 c0                	test   %eax,%eax
80105ebf:	0f 84 fb 00 00 00    	je     80105fc0 <sys_unlink+0x160>
80105ec5:	83 ec 08             	sub    $0x8,%esp
80105ec8:	68 f6 89 10 80       	push   $0x801089f6
80105ecd:	53                   	push   %ebx
80105ece:	e8 0d cc ff ff       	call   80102ae0 <namecmp>
80105ed3:	83 c4 10             	add    $0x10,%esp
80105ed6:	85 c0                	test   %eax,%eax
80105ed8:	0f 84 e2 00 00 00    	je     80105fc0 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
80105ede:	83 ec 04             	sub    $0x4,%esp
80105ee1:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105ee4:	50                   	push   %eax
80105ee5:	53                   	push   %ebx
80105ee6:	57                   	push   %edi
80105ee7:	e8 14 cc ff ff       	call   80102b00 <dirlookup>
80105eec:	83 c4 10             	add    $0x10,%esp
80105eef:	89 c3                	mov    %eax,%ebx
80105ef1:	85 c0                	test   %eax,%eax
80105ef3:	0f 84 c7 00 00 00    	je     80105fc0 <sys_unlink+0x160>
  ilock(ip);
80105ef9:	83 ec 0c             	sub    $0xc,%esp
80105efc:	50                   	push   %eax
80105efd:	e8 ae c6 ff ff       	call   801025b0 <ilock>
  if(ip->nlink < 1)
80105f02:	83 c4 10             	add    $0x10,%esp
80105f05:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105f0a:	0f 8e 0a 01 00 00    	jle    8010601a <sys_unlink+0x1ba>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105f10:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105f15:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105f18:	74 66                	je     80105f80 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105f1a:	83 ec 04             	sub    $0x4,%esp
80105f1d:	6a 10                	push   $0x10
80105f1f:	6a 00                	push   $0x0
80105f21:	57                   	push   %edi
80105f22:	e8 b9 f5 ff ff       	call   801054e0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105f27:	6a 10                	push   $0x10
80105f29:	ff 75 c4             	push   -0x3c(%ebp)
80105f2c:	57                   	push   %edi
80105f2d:	ff 75 b4             	push   -0x4c(%ebp)
80105f30:	e8 8b ca ff ff       	call   801029c0 <writei>
80105f35:	83 c4 20             	add    $0x20,%esp
80105f38:	83 f8 10             	cmp    $0x10,%eax
80105f3b:	0f 85 cc 00 00 00    	jne    8010600d <sys_unlink+0x1ad>
  if(ip->type == T_DIR){
80105f41:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105f46:	0f 84 94 00 00 00    	je     80105fe0 <sys_unlink+0x180>
  iunlockput(dp);
80105f4c:	83 ec 0c             	sub    $0xc,%esp
80105f4f:	ff 75 b4             	push   -0x4c(%ebp)
80105f52:	e8 e9 c8 ff ff       	call   80102840 <iunlockput>
  ip->nlink--;
80105f57:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105f5c:	89 1c 24             	mov    %ebx,(%esp)
80105f5f:	e8 9c c5 ff ff       	call   80102500 <iupdate>
  iunlockput(ip);
80105f64:	89 1c 24             	mov    %ebx,(%esp)
80105f67:	e8 d4 c8 ff ff       	call   80102840 <iunlockput>
  end_op();
80105f6c:	e8 5f dc ff ff       	call   80103bd0 <end_op>
  return 0;
80105f71:	83 c4 10             	add    $0x10,%esp
80105f74:	31 c0                	xor    %eax,%eax
}
80105f76:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f79:	5b                   	pop    %ebx
80105f7a:	5e                   	pop    %esi
80105f7b:	5f                   	pop    %edi
80105f7c:	5d                   	pop    %ebp
80105f7d:	c3                   	ret
80105f7e:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105f80:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105f84:	76 94                	jbe    80105f1a <sys_unlink+0xba>
80105f86:	be 20 00 00 00       	mov    $0x20,%esi
80105f8b:	eb 0b                	jmp    80105f98 <sys_unlink+0x138>
80105f8d:	8d 76 00             	lea    0x0(%esi),%esi
80105f90:	83 c6 10             	add    $0x10,%esi
80105f93:	3b 73 58             	cmp    0x58(%ebx),%esi
80105f96:	73 82                	jae    80105f1a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105f98:	6a 10                	push   $0x10
80105f9a:	56                   	push   %esi
80105f9b:	57                   	push   %edi
80105f9c:	53                   	push   %ebx
80105f9d:	e8 1e c9 ff ff       	call   801028c0 <readi>
80105fa2:	83 c4 10             	add    $0x10,%esp
80105fa5:	83 f8 10             	cmp    $0x10,%eax
80105fa8:	75 56                	jne    80106000 <sys_unlink+0x1a0>
    if(de.inum != 0)
80105faa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80105faf:	74 df                	je     80105f90 <sys_unlink+0x130>
    iunlockput(ip);
80105fb1:	83 ec 0c             	sub    $0xc,%esp
80105fb4:	53                   	push   %ebx
80105fb5:	e8 86 c8 ff ff       	call   80102840 <iunlockput>
    goto bad;
80105fba:	83 c4 10             	add    $0x10,%esp
80105fbd:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105fc0:	83 ec 0c             	sub    $0xc,%esp
80105fc3:	ff 75 b4             	push   -0x4c(%ebp)
80105fc6:	e8 75 c8 ff ff       	call   80102840 <iunlockput>
  end_op();
80105fcb:	e8 00 dc ff ff       	call   80103bd0 <end_op>
  return -1;
80105fd0:	83 c4 10             	add    $0x10,%esp
    return -1;
80105fd3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105fd8:	eb 9c                	jmp    80105f76 <sys_unlink+0x116>
80105fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105fe0:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105fe3:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105fe6:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
80105feb:	50                   	push   %eax
80105fec:	e8 0f c5 ff ff       	call   80102500 <iupdate>
80105ff1:	83 c4 10             	add    $0x10,%esp
80105ff4:	e9 53 ff ff ff       	jmp    80105f4c <sys_unlink+0xec>
    end_op();
80105ff9:	e8 d2 db ff ff       	call   80103bd0 <end_op>
    return -1;
80105ffe:	eb d3                	jmp    80105fd3 <sys_unlink+0x173>
      panic("isdirempty: readi");
80106000:	83 ec 0c             	sub    $0xc,%esp
80106003:	68 1b 8a 10 80       	push   $0x80108a1b
80106008:	e8 93 a3 ff ff       	call   801003a0 <panic>
    panic("unlink: writei");
8010600d:	83 ec 0c             	sub    $0xc,%esp
80106010:	68 2d 8a 10 80       	push   $0x80108a2d
80106015:	e8 86 a3 ff ff       	call   801003a0 <panic>
    panic("unlink: nlink < 1");
8010601a:	83 ec 0c             	sub    $0xc,%esp
8010601d:	68 09 8a 10 80       	push   $0x80108a09
80106022:	e8 79 a3 ff ff       	call   801003a0 <panic>
80106027:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010602e:	00 
8010602f:	90                   	nop

80106030 <sys_open>:

int
sys_open(void)
{
80106030:	55                   	push   %ebp
80106031:	89 e5                	mov    %esp,%ebp
80106033:	57                   	push   %edi
80106034:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106035:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80106038:	53                   	push   %ebx
80106039:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010603c:	50                   	push   %eax
8010603d:	6a 00                	push   $0x0
8010603f:	e8 0c f8 ff ff       	call   80105850 <argstr>
80106044:	83 c4 10             	add    $0x10,%esp
80106047:	85 c0                	test   %eax,%eax
80106049:	0f 88 8e 00 00 00    	js     801060dd <sys_open+0xad>
8010604f:	83 ec 08             	sub    $0x8,%esp
80106052:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106055:	50                   	push   %eax
80106056:	6a 01                	push   $0x1
80106058:	e8 33 f7 ff ff       	call   80105790 <argint>
8010605d:	83 c4 10             	add    $0x10,%esp
80106060:	85 c0                	test   %eax,%eax
80106062:	78 79                	js     801060dd <sys_open+0xad>
    return -1;

  begin_op();
80106064:	e8 f7 da ff ff       	call   80103b60 <begin_op>

  if(omode & O_CREATE){
80106069:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
8010606d:	75 79                	jne    801060e8 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010606f:	83 ec 0c             	sub    $0xc,%esp
80106072:	ff 75 e0             	push   -0x20(%ebp)
80106075:	e8 16 ce ff ff       	call   80102e90 <namei>
8010607a:	83 c4 10             	add    $0x10,%esp
8010607d:	89 c6                	mov    %eax,%esi
8010607f:	85 c0                	test   %eax,%eax
80106081:	0f 84 7e 00 00 00    	je     80106105 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80106087:	83 ec 0c             	sub    $0xc,%esp
8010608a:	50                   	push   %eax
8010608b:	e8 20 c5 ff ff       	call   801025b0 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80106090:	83 c4 10             	add    $0x10,%esp
80106093:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80106098:	0f 84 ba 00 00 00    	je     80106158 <sys_open+0x128>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010609e:	e8 2d b6 ff ff       	call   801016d0 <filealloc>
801060a3:	89 c7                	mov    %eax,%edi
801060a5:	85 c0                	test   %eax,%eax
801060a7:	74 23                	je     801060cc <sys_open+0x9c>
  struct proc *curproc = myproc();
801060a9:	e8 e2 e6 ff ff       	call   80104790 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801060ae:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
801060b0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801060b4:	85 d2                	test   %edx,%edx
801060b6:	74 58                	je     80106110 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
801060b8:	83 c3 01             	add    $0x1,%ebx
801060bb:	83 fb 10             	cmp    $0x10,%ebx
801060be:	75 f0                	jne    801060b0 <sys_open+0x80>
    if(f)
      fileclose(f);
801060c0:	83 ec 0c             	sub    $0xc,%esp
801060c3:	57                   	push   %edi
801060c4:	e8 c7 b6 ff ff       	call   80101790 <fileclose>
801060c9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801060cc:	83 ec 0c             	sub    $0xc,%esp
801060cf:	56                   	push   %esi
801060d0:	e8 6b c7 ff ff       	call   80102840 <iunlockput>
    end_op();
801060d5:	e8 f6 da ff ff       	call   80103bd0 <end_op>
    return -1;
801060da:	83 c4 10             	add    $0x10,%esp
    return -1;
801060dd:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801060e2:	eb 65                	jmp    80106149 <sys_open+0x119>
801060e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
801060e8:	83 ec 0c             	sub    $0xc,%esp
801060eb:	31 c9                	xor    %ecx,%ecx
801060ed:	ba 02 00 00 00       	mov    $0x2,%edx
801060f2:	6a 00                	push   $0x0
801060f4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801060f7:	e8 54 f8 ff ff       	call   80105950 <create>
    if(ip == 0){
801060fc:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
801060ff:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80106101:	85 c0                	test   %eax,%eax
80106103:	75 99                	jne    8010609e <sys_open+0x6e>
      end_op();
80106105:	e8 c6 da ff ff       	call   80103bd0 <end_op>
      return -1;
8010610a:	eb d1                	jmp    801060dd <sys_open+0xad>
8010610c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80106110:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80106113:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80106117:	56                   	push   %esi
80106118:	e8 73 c5 ff ff       	call   80102690 <iunlock>
  end_op();
8010611d:	e8 ae da ff ff       	call   80103bd0 <end_op>

  f->type = FD_INODE;
80106122:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80106128:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010612b:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
8010612e:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80106131:	89 d0                	mov    %edx,%eax
  f->off = 0;
80106133:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010613a:	f7 d0                	not    %eax
8010613c:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010613f:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80106142:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80106145:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80106149:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010614c:	89 d8                	mov    %ebx,%eax
8010614e:	5b                   	pop    %ebx
8010614f:	5e                   	pop    %esi
80106150:	5f                   	pop    %edi
80106151:	5d                   	pop    %ebp
80106152:	c3                   	ret
80106153:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80106158:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010615b:	85 c9                	test   %ecx,%ecx
8010615d:	0f 84 3b ff ff ff    	je     8010609e <sys_open+0x6e>
80106163:	e9 64 ff ff ff       	jmp    801060cc <sys_open+0x9c>
80106168:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010616f:	00 

80106170 <sys_mkdir>:

int
sys_mkdir(void)
{
80106170:	55                   	push   %ebp
80106171:	89 e5                	mov    %esp,%ebp
80106173:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80106176:	e8 e5 d9 ff ff       	call   80103b60 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010617b:	83 ec 08             	sub    $0x8,%esp
8010617e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106181:	50                   	push   %eax
80106182:	6a 00                	push   $0x0
80106184:	e8 c7 f6 ff ff       	call   80105850 <argstr>
80106189:	83 c4 10             	add    $0x10,%esp
8010618c:	85 c0                	test   %eax,%eax
8010618e:	78 30                	js     801061c0 <sys_mkdir+0x50>
80106190:	83 ec 0c             	sub    $0xc,%esp
80106193:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106196:	31 c9                	xor    %ecx,%ecx
80106198:	ba 01 00 00 00       	mov    $0x1,%edx
8010619d:	6a 00                	push   $0x0
8010619f:	e8 ac f7 ff ff       	call   80105950 <create>
801061a4:	83 c4 10             	add    $0x10,%esp
801061a7:	85 c0                	test   %eax,%eax
801061a9:	74 15                	je     801061c0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801061ab:	83 ec 0c             	sub    $0xc,%esp
801061ae:	50                   	push   %eax
801061af:	e8 8c c6 ff ff       	call   80102840 <iunlockput>
  end_op();
801061b4:	e8 17 da ff ff       	call   80103bd0 <end_op>
  return 0;
801061b9:	83 c4 10             	add    $0x10,%esp
801061bc:	31 c0                	xor    %eax,%eax
}
801061be:	c9                   	leave
801061bf:	c3                   	ret
    end_op();
801061c0:	e8 0b da ff ff       	call   80103bd0 <end_op>
    return -1;
801061c5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801061ca:	c9                   	leave
801061cb:	c3                   	ret
801061cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801061d0 <sys_mknod>:

int
sys_mknod(void)
{
801061d0:	55                   	push   %ebp
801061d1:	89 e5                	mov    %esp,%ebp
801061d3:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
801061d6:	e8 85 d9 ff ff       	call   80103b60 <begin_op>
  if((argstr(0, &path)) < 0 ||
801061db:	83 ec 08             	sub    $0x8,%esp
801061de:	8d 45 ec             	lea    -0x14(%ebp),%eax
801061e1:	50                   	push   %eax
801061e2:	6a 00                	push   $0x0
801061e4:	e8 67 f6 ff ff       	call   80105850 <argstr>
801061e9:	83 c4 10             	add    $0x10,%esp
801061ec:	85 c0                	test   %eax,%eax
801061ee:	78 60                	js     80106250 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
801061f0:	83 ec 08             	sub    $0x8,%esp
801061f3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801061f6:	50                   	push   %eax
801061f7:	6a 01                	push   $0x1
801061f9:	e8 92 f5 ff ff       	call   80105790 <argint>
  if((argstr(0, &path)) < 0 ||
801061fe:	83 c4 10             	add    $0x10,%esp
80106201:	85 c0                	test   %eax,%eax
80106203:	78 4b                	js     80106250 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80106205:	83 ec 08             	sub    $0x8,%esp
80106208:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010620b:	50                   	push   %eax
8010620c:	6a 02                	push   $0x2
8010620e:	e8 7d f5 ff ff       	call   80105790 <argint>
     argint(1, &major) < 0 ||
80106213:	83 c4 10             	add    $0x10,%esp
80106216:	85 c0                	test   %eax,%eax
80106218:	78 36                	js     80106250 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010621a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010621e:	83 ec 0c             	sub    $0xc,%esp
80106221:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80106225:	ba 03 00 00 00       	mov    $0x3,%edx
8010622a:	50                   	push   %eax
8010622b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010622e:	e8 1d f7 ff ff       	call   80105950 <create>
     argint(2, &minor) < 0 ||
80106233:	83 c4 10             	add    $0x10,%esp
80106236:	85 c0                	test   %eax,%eax
80106238:	74 16                	je     80106250 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010623a:	83 ec 0c             	sub    $0xc,%esp
8010623d:	50                   	push   %eax
8010623e:	e8 fd c5 ff ff       	call   80102840 <iunlockput>
  end_op();
80106243:	e8 88 d9 ff ff       	call   80103bd0 <end_op>
  return 0;
80106248:	83 c4 10             	add    $0x10,%esp
8010624b:	31 c0                	xor    %eax,%eax
}
8010624d:	c9                   	leave
8010624e:	c3                   	ret
8010624f:	90                   	nop
    end_op();
80106250:	e8 7b d9 ff ff       	call   80103bd0 <end_op>
    return -1;
80106255:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010625a:	c9                   	leave
8010625b:	c3                   	ret
8010625c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106260 <sys_chdir>:

int
sys_chdir(void)
{
80106260:	55                   	push   %ebp
80106261:	89 e5                	mov    %esp,%ebp
80106263:	56                   	push   %esi
80106264:	53                   	push   %ebx
80106265:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80106268:	e8 23 e5 ff ff       	call   80104790 <myproc>
8010626d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010626f:	e8 ec d8 ff ff       	call   80103b60 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80106274:	83 ec 08             	sub    $0x8,%esp
80106277:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010627a:	50                   	push   %eax
8010627b:	6a 00                	push   $0x0
8010627d:	e8 ce f5 ff ff       	call   80105850 <argstr>
80106282:	83 c4 10             	add    $0x10,%esp
80106285:	85 c0                	test   %eax,%eax
80106287:	78 77                	js     80106300 <sys_chdir+0xa0>
80106289:	83 ec 0c             	sub    $0xc,%esp
8010628c:	ff 75 f4             	push   -0xc(%ebp)
8010628f:	e8 fc cb ff ff       	call   80102e90 <namei>
80106294:	83 c4 10             	add    $0x10,%esp
80106297:	89 c3                	mov    %eax,%ebx
80106299:	85 c0                	test   %eax,%eax
8010629b:	74 63                	je     80106300 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010629d:	83 ec 0c             	sub    $0xc,%esp
801062a0:	50                   	push   %eax
801062a1:	e8 0a c3 ff ff       	call   801025b0 <ilock>
  if(ip->type != T_DIR){
801062a6:	83 c4 10             	add    $0x10,%esp
801062a9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801062ae:	75 30                	jne    801062e0 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801062b0:	83 ec 0c             	sub    $0xc,%esp
801062b3:	53                   	push   %ebx
801062b4:	e8 d7 c3 ff ff       	call   80102690 <iunlock>
  iput(curproc->cwd);
801062b9:	58                   	pop    %eax
801062ba:	ff 76 68             	push   0x68(%esi)
801062bd:	e8 1e c4 ff ff       	call   801026e0 <iput>
  end_op();
801062c2:	e8 09 d9 ff ff       	call   80103bd0 <end_op>
  curproc->cwd = ip;
801062c7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
801062ca:	83 c4 10             	add    $0x10,%esp
801062cd:	31 c0                	xor    %eax,%eax
}
801062cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801062d2:	5b                   	pop    %ebx
801062d3:	5e                   	pop    %esi
801062d4:	5d                   	pop    %ebp
801062d5:	c3                   	ret
801062d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801062dd:	00 
801062de:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
801062e0:	83 ec 0c             	sub    $0xc,%esp
801062e3:	53                   	push   %ebx
801062e4:	e8 57 c5 ff ff       	call   80102840 <iunlockput>
    end_op();
801062e9:	e8 e2 d8 ff ff       	call   80103bd0 <end_op>
    return -1;
801062ee:	83 c4 10             	add    $0x10,%esp
    return -1;
801062f1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801062f6:	eb d7                	jmp    801062cf <sys_chdir+0x6f>
801062f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801062ff:	00 
    end_op();
80106300:	e8 cb d8 ff ff       	call   80103bd0 <end_op>
    return -1;
80106305:	eb ea                	jmp    801062f1 <sys_chdir+0x91>
80106307:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010630e:	00 
8010630f:	90                   	nop

80106310 <sys_exec>:

int
sys_exec(void)
{
80106310:	55                   	push   %ebp
80106311:	89 e5                	mov    %esp,%ebp
80106313:	57                   	push   %edi
80106314:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106315:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010631b:	53                   	push   %ebx
8010631c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80106322:	50                   	push   %eax
80106323:	6a 00                	push   $0x0
80106325:	e8 26 f5 ff ff       	call   80105850 <argstr>
8010632a:	83 c4 10             	add    $0x10,%esp
8010632d:	85 c0                	test   %eax,%eax
8010632f:	0f 88 87 00 00 00    	js     801063bc <sys_exec+0xac>
80106335:	83 ec 08             	sub    $0x8,%esp
80106338:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010633e:	50                   	push   %eax
8010633f:	6a 01                	push   $0x1
80106341:	e8 4a f4 ff ff       	call   80105790 <argint>
80106346:	83 c4 10             	add    $0x10,%esp
80106349:	85 c0                	test   %eax,%eax
8010634b:	78 6f                	js     801063bc <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010634d:	83 ec 04             	sub    $0x4,%esp
80106350:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80106356:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80106358:	68 80 00 00 00       	push   $0x80
8010635d:	6a 00                	push   $0x0
8010635f:	56                   	push   %esi
80106360:	e8 7b f1 ff ff       	call   801054e0 <memset>
80106365:	83 c4 10             	add    $0x10,%esp
80106368:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010636f:	00 
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80106370:	83 ec 08             	sub    $0x8,%esp
80106373:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80106379:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80106380:	50                   	push   %eax
80106381:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80106387:	01 f8                	add    %edi,%eax
80106389:	50                   	push   %eax
8010638a:	e8 71 f3 ff ff       	call   80105700 <fetchint>
8010638f:	83 c4 10             	add    $0x10,%esp
80106392:	85 c0                	test   %eax,%eax
80106394:	78 26                	js     801063bc <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80106396:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010639c:	85 c0                	test   %eax,%eax
8010639e:	74 30                	je     801063d0 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801063a0:	83 ec 08             	sub    $0x8,%esp
801063a3:	8d 14 3e             	lea    (%esi,%edi,1),%edx
801063a6:	52                   	push   %edx
801063a7:	50                   	push   %eax
801063a8:	e8 93 f3 ff ff       	call   80105740 <fetchstr>
801063ad:	83 c4 10             	add    $0x10,%esp
801063b0:	85 c0                	test   %eax,%eax
801063b2:	78 08                	js     801063bc <sys_exec+0xac>
  for(i=0;; i++){
801063b4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801063b7:	83 fb 20             	cmp    $0x20,%ebx
801063ba:	75 b4                	jne    80106370 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
801063bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801063bf:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801063c4:	5b                   	pop    %ebx
801063c5:	5e                   	pop    %esi
801063c6:	5f                   	pop    %edi
801063c7:	5d                   	pop    %ebp
801063c8:	c3                   	ret
801063c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
801063d0:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
801063d7:	00 00 00 00 
  return exec(path, argv);
801063db:	83 ec 08             	sub    $0x8,%esp
801063de:	56                   	push   %esi
801063df:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
801063e5:	e8 46 af ff ff       	call   80101330 <exec>
801063ea:	83 c4 10             	add    $0x10,%esp
}
801063ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
801063f0:	5b                   	pop    %ebx
801063f1:	5e                   	pop    %esi
801063f2:	5f                   	pop    %edi
801063f3:	5d                   	pop    %ebp
801063f4:	c3                   	ret
801063f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801063fc:	00 
801063fd:	8d 76 00             	lea    0x0(%esi),%esi

80106400 <sys_pipe>:

int
sys_pipe(void)
{
80106400:	55                   	push   %ebp
80106401:	89 e5                	mov    %esp,%ebp
80106403:	57                   	push   %edi
80106404:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80106405:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80106408:	53                   	push   %ebx
80106409:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010640c:	6a 08                	push   $0x8
8010640e:	50                   	push   %eax
8010640f:	6a 00                	push   $0x0
80106411:	e8 ca f3 ff ff       	call   801057e0 <argptr>
80106416:	83 c4 10             	add    $0x10,%esp
80106419:	85 c0                	test   %eax,%eax
8010641b:	0f 88 8b 00 00 00    	js     801064ac <sys_pipe+0xac>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80106421:	83 ec 08             	sub    $0x8,%esp
80106424:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106427:	50                   	push   %eax
80106428:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010642b:	50                   	push   %eax
8010642c:	e8 ff dd ff ff       	call   80104230 <pipealloc>
80106431:	83 c4 10             	add    $0x10,%esp
80106434:	85 c0                	test   %eax,%eax
80106436:	78 74                	js     801064ac <sys_pipe+0xac>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106438:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010643b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010643d:	e8 4e e3 ff ff       	call   80104790 <myproc>
    if(curproc->ofile[fd] == 0){
80106442:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80106446:	85 f6                	test   %esi,%esi
80106448:	74 16                	je     80106460 <sys_pipe+0x60>
8010644a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80106450:	83 c3 01             	add    $0x1,%ebx
80106453:	83 fb 10             	cmp    $0x10,%ebx
80106456:	74 3d                	je     80106495 <sys_pipe+0x95>
    if(curproc->ofile[fd] == 0){
80106458:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010645c:	85 f6                	test   %esi,%esi
8010645e:	75 f0                	jne    80106450 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80106460:	8d 73 08             	lea    0x8(%ebx),%esi
80106463:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80106467:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010646a:	e8 21 e3 ff ff       	call   80104790 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010646f:	31 d2                	xor    %edx,%edx
80106471:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80106478:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
8010647c:	85 c9                	test   %ecx,%ecx
8010647e:	74 38                	je     801064b8 <sys_pipe+0xb8>
  for(fd = 0; fd < NOFILE; fd++){
80106480:	83 c2 01             	add    $0x1,%edx
80106483:	83 fa 10             	cmp    $0x10,%edx
80106486:	75 f0                	jne    80106478 <sys_pipe+0x78>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80106488:	e8 03 e3 ff ff       	call   80104790 <myproc>
8010648d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80106494:	00 
    fileclose(rf);
80106495:	83 ec 0c             	sub    $0xc,%esp
80106498:	ff 75 e0             	push   -0x20(%ebp)
8010649b:	e8 f0 b2 ff ff       	call   80101790 <fileclose>
    fileclose(wf);
801064a0:	58                   	pop    %eax
801064a1:	ff 75 e4             	push   -0x1c(%ebp)
801064a4:	e8 e7 b2 ff ff       	call   80101790 <fileclose>
    return -1;
801064a9:	83 c4 10             	add    $0x10,%esp
    return -1;
801064ac:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064b1:	eb 16                	jmp    801064c9 <sys_pipe+0xc9>
801064b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
801064b8:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
801064bc:	8b 45 dc             	mov    -0x24(%ebp),%eax
801064bf:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801064c1:	8b 45 dc             	mov    -0x24(%ebp),%eax
801064c4:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801064c7:	31 c0                	xor    %eax,%eax
}
801064c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801064cc:	5b                   	pop    %ebx
801064cd:	5e                   	pop    %esi
801064ce:	5f                   	pop    %edi
801064cf:	5d                   	pop    %ebp
801064d0:	c3                   	ret
801064d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801064d8:	00 
801064d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801064e0 <sys_diff>:

int
sys_diff(void)
{
801064e0:	55                   	push   %ebp
801064e1:	89 e5                	mov    %esp,%ebp
801064e3:	57                   	push   %edi
801064e4:	56                   	push   %esi
  struct inode *ip1, *ip2;
  char buf1[512], buf2[512];
  int line, diff_found;
  
  // Get the two file names as arguments
  if(argstr(0, &file1) < 0 || argstr(1, &file2) < 0)
801064e5:	8d 85 e0 fb ff ff    	lea    -0x420(%ebp),%eax
{
801064eb:	53                   	push   %ebx
801064ec:	81 ec 44 04 00 00    	sub    $0x444,%esp
  if(argstr(0, &file1) < 0 || argstr(1, &file2) < 0)
801064f2:	50                   	push   %eax
801064f3:	6a 00                	push   $0x0
801064f5:	e8 56 f3 ff ff       	call   80105850 <argstr>
801064fa:	83 c4 10             	add    $0x10,%esp
801064fd:	85 c0                	test   %eax,%eax
801064ff:	0f 88 ea 02 00 00    	js     801067ef <sys_diff+0x30f>
80106505:	83 ec 08             	sub    $0x8,%esp
80106508:	8d 85 e4 fb ff ff    	lea    -0x41c(%ebp),%eax
8010650e:	50                   	push   %eax
8010650f:	6a 01                	push   $0x1
80106511:	e8 3a f3 ff ff       	call   80105850 <argstr>
80106516:	83 c4 10             	add    $0x10,%esp
80106519:	85 c0                	test   %eax,%eax
8010651b:	0f 88 ce 02 00 00    	js     801067ef <sys_diff+0x30f>
    return -1;
  
  // Open the first file
  begin_op();
80106521:	e8 3a d6 ff ff       	call   80103b60 <begin_op>
  if((ip1 = namei(file1)) == 0){
80106526:	83 ec 0c             	sub    $0xc,%esp
80106529:	ff b5 e0 fb ff ff    	push   -0x420(%ebp)
8010652f:	e8 5c c9 ff ff       	call   80102e90 <namei>
80106534:	83 c4 10             	add    $0x10,%esp
80106537:	89 c3                	mov    %eax,%ebx
80106539:	85 c0                	test   %eax,%eax
8010653b:	0f 84 26 05 00 00    	je     80106a67 <sys_diff+0x587>
    end_op();
    cprintf("diff: cannot open %s\n", file1);
    return -1;
  }
  
  ilock(ip1);
80106541:	83 ec 0c             	sub    $0xc,%esp
80106544:	50                   	push   %eax
80106545:	e8 66 c0 ff ff       	call   801025b0 <ilock>
  if(ip1->type == T_DIR){
8010654a:	83 c4 10             	add    $0x10,%esp
8010654d:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80106552:	0f 84 70 04 00 00    	je     801069c8 <sys_diff+0x4e8>
    iunlockput(ip1);
    end_op();
    cprintf("diff: %s is a directory\n", file1);
    return -1;
  }
  iunlock(ip1);
80106558:	83 ec 0c             	sub    $0xc,%esp
8010655b:	53                   	push   %ebx
8010655c:	e8 2f c1 ff ff       	call   80102690 <iunlock>
  
  if((f1 = filealloc()) == 0){
80106561:	e8 6a b1 ff ff       	call   801016d0 <filealloc>
80106566:	83 c4 10             	add    $0x10,%esp
80106569:	89 85 bc fb ff ff    	mov    %eax,-0x444(%ebp)
8010656f:	85 c0                	test   %eax,%eax
80106571:	0f 84 da 04 00 00    	je     80106a51 <sys_diff+0x571>
    end_op();
    return -1;
  }
  
  // Initialize the first file
  f1->type = FD_INODE;
80106577:	8b 85 bc fb ff ff    	mov    -0x444(%ebp),%eax
  f1->off = 0;
  f1->readable = 1;
  f1->writable = 0;
  
  // Open the second file
  if((ip2 = namei(file2)) == 0){
8010657d:	83 ec 0c             	sub    $0xc,%esp
  f1->ip = ip1;
80106580:	89 58 10             	mov    %ebx,0x10(%eax)
  f1->readable = 1;
80106583:	0f b7 1d 74 90 10 80 	movzwl 0x80109074,%ebx
  f1->type = FD_INODE;
8010658a:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f1->off = 0;
80106590:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f1->readable = 1;
80106597:	66 89 58 08          	mov    %bx,0x8(%eax)
  if((ip2 = namei(file2)) == 0){
8010659b:	ff b5 e4 fb ff ff    	push   -0x41c(%ebp)
801065a1:	e8 ea c8 ff ff       	call   80102e90 <namei>
801065a6:	83 c4 10             	add    $0x10,%esp
801065a9:	89 c6                	mov    %eax,%esi
801065ab:	85 c0                	test   %eax,%eax
801065ad:	0f 84 71 04 00 00    	je     80106a24 <sys_diff+0x544>
    end_op();
    cprintf("diff: cannot open %s\n", file2);
    return -1;
  }
  
  ilock(ip2);
801065b3:	83 ec 0c             	sub    $0xc,%esp
801065b6:	50                   	push   %eax
801065b7:	e8 f4 bf ff ff       	call   801025b0 <ilock>
  if(ip2->type == T_DIR){
801065bc:	83 c4 10             	add    $0x10,%esp
801065bf:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801065c4:	0f 84 26 04 00 00    	je     801069f0 <sys_diff+0x510>
    fileclose(f1);
    end_op();
    cprintf("diff: %s is a directory\n", file2);
    return -1;
  }
  iunlock(ip2);
801065ca:	83 ec 0c             	sub    $0xc,%esp
801065cd:	56                   	push   %esi
801065ce:	e8 bd c0 ff ff       	call   80102690 <iunlock>
  
  if((f2 = filealloc()) == 0){
801065d3:	e8 f8 b0 ff ff       	call   801016d0 <filealloc>
801065d8:	83 c4 10             	add    $0x10,%esp
801065db:	89 85 d4 fb ff ff    	mov    %eax,-0x42c(%ebp)
801065e1:	85 c0                	test   %eax,%eax
801065e3:	0f 84 9e 04 00 00    	je     80106a87 <sys_diff+0x5a7>
    end_op();
    return -1;
  }
  
  // Initialize the second file
  f2->type = FD_INODE;
801065e9:	8b 85 d4 fb ff ff    	mov    -0x42c(%ebp),%eax
801065ef:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f2->ip = ip2;
801065f5:	89 70 10             	mov    %esi,0x10(%eax)
  f2->off = 0;
801065f8:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f2->readable = 1;
801065ff:	66 89 58 08          	mov    %bx,0x8(%eax)
  f2->writable = 0;
  
  end_op();
80106603:	e8 c8 d5 ff ff       	call   80103bd0 <end_op>
  // Compare the files line by line
  line = 1;
  diff_found = 0;
  char *p1, *p2;
  int i1, i2;
  int eof1 = 0, eof2 = 0;
80106608:	c7 85 cc fb ff ff 00 	movl   $0x0,-0x434(%ebp)
8010660f:	00 00 00 
80106612:	c7 85 d0 fb ff ff 00 	movl   $0x0,-0x430(%ebp)
80106619:	00 00 00 
  diff_found = 0;
8010661c:	c7 85 b8 fb ff ff 00 	movl   $0x0,-0x448(%ebp)
80106623:	00 00 00 
  line = 1;
80106626:	c7 85 c4 fb ff ff 01 	movl   $0x1,-0x43c(%ebp)
8010662d:	00 00 00 
  while(!eof1 || !eof2){
    // Read a line from the first file
    p1 = buf1;
    i1 = 0;
    
    if(!eof1){
80106630:	8b 85 d0 fb ff ff    	mov    -0x430(%ebp),%eax
80106636:	85 c0                	test   %eax,%eax
80106638:	74 56                	je     80106690 <sys_diff+0x1b0>
    
    // Read a line from the second file
    p2 = buf2;
    i2 = 0;
    
    if(!eof2){
8010663a:	8b 85 cc fb ff ff    	mov    -0x434(%ebp),%eax
80106640:	85 c0                	test   %eax,%eax
80106642:	0f 84 38 02 00 00    	je     80106880 <sys_diff+0x3a0>
    
    line++;
  }
  
  // If one file has more content than the other
  if(eof1 && !eof2){
80106648:	b8 01 00 00 00       	mov    $0x1,%eax
    diff_found = 1;
    cprintf("File %s has more lines\n", file2);
  } else if(!eof1 && eof2){
8010664d:	8b 95 cc fb ff ff    	mov    -0x434(%ebp),%edx
80106653:	83 f2 01             	xor    $0x1,%edx
80106656:	85 c2                	test   %eax,%edx
80106658:	0f 85 f1 02 00 00    	jne    8010694f <sys_diff+0x46f>
    diff_found = 1;
    cprintf("File %s has more lines\n", file1);
  }
  
  // Close the files
  fileclose(f1);
8010665e:	83 ec 0c             	sub    $0xc,%esp
80106661:	ff b5 bc fb ff ff    	push   -0x444(%ebp)
80106667:	e8 24 b1 ff ff       	call   80101790 <fileclose>
  fileclose(f2);
8010666c:	58                   	pop    %eax
8010666d:	ff b5 d4 fb ff ff    	push   -0x42c(%ebp)
80106673:	e8 18 b1 ff ff       	call   80101790 <fileclose>
  
  return diff_found ? -1 : 0;
80106678:	8b 85 b8 fb ff ff    	mov    -0x448(%ebp),%eax
8010667e:	83 c4 10             	add    $0x10,%esp
80106681:	f7 d8                	neg    %eax
}
80106683:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106686:	5b                   	pop    %ebx
80106687:	5e                   	pop    %esi
80106688:	5f                   	pop    %edi
80106689:	5d                   	pop    %ebp
8010668a:	c3                   	ret
8010668b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80106690:	8b b5 bc fb ff ff    	mov    -0x444(%ebp),%esi
    i1 = 0;
80106696:	31 ff                	xor    %edi,%edi
80106698:	eb 25                	jmp    801066bf <sys_diff+0x1df>
8010669a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        if(*p1 == '\n'){
801066a0:	80 bc 3d e8 fb ff ff 	cmpb   $0xa,-0x418(%ebp,%edi,1)
801066a7:	0a 
          i1++;
801066a8:	8d 5f 01             	lea    0x1(%edi),%ebx
        if(*p1 == '\n'){
801066ab:	0f 84 3f 02 00 00    	je     801068f0 <sys_diff+0x410>
      while(i1 < sizeof(buf1) - 1){
801066b1:	81 fb ff 01 00 00    	cmp    $0x1ff,%ebx
801066b7:	0f 84 b5 02 00 00    	je     80106972 <sys_diff+0x492>
801066bd:	89 df                	mov    %ebx,%edi
        if(fileread(f1, p1, 1) != 1){
801066bf:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
801066c5:	83 ec 04             	sub    $0x4,%esp
801066c8:	01 f8                	add    %edi,%eax
801066ca:	6a 01                	push   $0x1
801066cc:	50                   	push   %eax
801066cd:	56                   	push   %esi
801066ce:	e8 ed b1 ff ff       	call   801018c0 <fileread>
801066d3:	83 c4 10             	add    $0x10,%esp
801066d6:	83 f8 01             	cmp    $0x1,%eax
801066d9:	74 c5                	je     801066a0 <sys_diff+0x1c0>
    if(!eof2){
801066db:	8b 8d cc fb ff ff    	mov    -0x434(%ebp),%ecx
801066e1:	85 c9                	test   %ecx,%ecx
801066e3:	0f 84 87 01 00 00    	je     80106870 <sys_diff+0x390>
801066e9:	8b 95 cc fb ff ff    	mov    -0x434(%ebp),%edx
801066ef:	89 f8                	mov    %edi,%eax
      i2 = 0;
801066f1:	31 db                	xor    %ebx,%ebx
801066f3:	89 95 d0 fb ff ff    	mov    %edx,-0x430(%ebp)
    if(i1 == 0 && i2 == 0)
801066f9:	85 c0                	test   %eax,%eax
801066fb:	0f 84 b6 02 00 00    	je     801069b7 <sys_diff+0x4d7>
80106701:	c7 85 c0 fb ff ff 00 	movl   $0x0,-0x440(%ebp)
80106708:	00 00 00 
8010670b:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
80106711:	c7 85 cc fb ff ff 01 	movl   $0x1,-0x434(%ebp)
80106718:	00 00 00 
    if(i1 != i2 || memcmp(buf1, buf2, i1 < i2 ? i1 : i2) != 0){
8010671b:	8b 85 d0 fb ff ff    	mov    -0x430(%ebp),%eax
80106721:	8b 8d c0 fb ff ff    	mov    -0x440(%ebp),%ecx
80106727:	83 f0 01             	xor    $0x1,%eax
8010672a:	09 c1                	or     %eax,%ecx
8010672c:	89 8d c8 fb ff ff    	mov    %ecx,-0x438(%ebp)
80106732:	39 df                	cmp    %ebx,%edi
80106734:	0f 84 e6 00 00 00    	je     80106820 <sys_diff+0x340>
      cprintf("Line %d: files differ\n", line);
8010673a:	83 ec 08             	sub    $0x8,%esp
8010673d:	ff b5 c4 fb ff ff    	push   -0x43c(%ebp)
80106743:	68 6b 8a 10 80       	push   $0x80108a6b
80106748:	e8 f3 a4 ff ff       	call   80100c40 <cprintf>
      buf1[i1] = '\0';
8010674d:	c6 84 3d e8 fb ff ff 	movb   $0x0,-0x418(%ebp,%edi,1)
80106754:	00 
      buf2[i2] = '\0';
80106755:	c6 84 1d e8 fd ff ff 	movb   $0x0,-0x218(%ebp,%ebx,1)
8010675c:	00 
      cprintf("< %s", buf1);
8010675d:	58                   	pop    %eax
8010675e:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
80106764:	5a                   	pop    %edx
80106765:	50                   	push   %eax
80106766:	68 82 8a 10 80       	push   $0x80108a82
8010676b:	e8 d0 a4 ff ff       	call   80100c40 <cprintf>
      if(i1 > 0 && buf1[i1-1] != '\n')
80106770:	83 c4 10             	add    $0x10,%esp
80106773:	85 ff                	test   %edi,%edi
80106775:	0f 85 cd 00 00 00    	jne    80106848 <sys_diff+0x368>
      cprintf("> %s", buf2);
8010677b:	83 ec 08             	sub    $0x8,%esp
8010677e:	56                   	push   %esi
8010677f:	68 87 8a 10 80       	push   $0x80108a87
80106784:	e8 b7 a4 ff ff       	call   80100c40 <cprintf>
      if(i2 > 0 && buf2[i2-1] != '\n')
80106789:	83 c4 10             	add    $0x10,%esp
8010678c:	85 db                	test   %ebx,%ebx
8010678e:	75 70                	jne    80106800 <sys_diff+0x320>
      diff_found = 1;
80106790:	c7 85 b8 fb ff ff 01 	movl   $0x1,-0x448(%ebp)
80106797:	00 00 00 
  while(!eof1 || !eof2){
8010679a:	8b 9d c8 fb ff ff    	mov    -0x438(%ebp),%ebx
    line++;
801067a0:	83 85 c4 fb ff ff 01 	addl   $0x1,-0x43c(%ebp)
  while(!eof1 || !eof2){
801067a7:	85 db                	test   %ebx,%ebx
801067a9:	0f 85 81 fe ff ff    	jne    80106630 <sys_diff+0x150>
  if(eof1 && !eof2){
801067af:	8b 95 c0 fb ff ff    	mov    -0x440(%ebp),%edx
801067b5:	85 95 d0 fb ff ff    	test   %edx,-0x430(%ebp)
801067bb:	0f 84 e9 02 00 00    	je     80106aaa <sys_diff+0x5ca>
    cprintf("File %s has more lines\n", file2);
801067c1:	83 ec 08             	sub    $0x8,%esp
801067c4:	ff b5 e4 fb ff ff    	push   -0x41c(%ebp)
    cprintf("File %s has more lines\n", file1);
801067ca:	68 8c 8a 10 80       	push   $0x80108a8c
801067cf:	e8 6c a4 ff ff       	call   80100c40 <cprintf>
  fileclose(f1);
801067d4:	5a                   	pop    %edx
801067d5:	ff b5 bc fb ff ff    	push   -0x444(%ebp)
801067db:	e8 b0 af ff ff       	call   80101790 <fileclose>
  fileclose(f2);
801067e0:	59                   	pop    %ecx
801067e1:	ff b5 d4 fb ff ff    	push   -0x42c(%ebp)
801067e7:	e8 a4 af ff ff       	call   80101790 <fileclose>
801067ec:	83 c4 10             	add    $0x10,%esp
    return -1;
801067ef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801067f4:	e9 8a fe ff ff       	jmp    80106683 <sys_diff+0x1a3>
801067f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(i2 > 0 && buf2[i2-1] != '\n')
80106800:	80 bc 1d e7 fd ff ff 	cmpb   $0xa,-0x219(%ebp,%ebx,1)
80106807:	0a 
80106808:	74 86                	je     80106790 <sys_diff+0x2b0>
        cprintf("\n");
8010680a:	83 ec 0c             	sub    $0xc,%esp
8010680d:	68 65 8b 10 80       	push   $0x80108b65
80106812:	e8 29 a4 ff ff       	call   80100c40 <cprintf>
80106817:	83 c4 10             	add    $0x10,%esp
8010681a:	e9 71 ff ff ff       	jmp    80106790 <sys_diff+0x2b0>
8010681f:	90                   	nop
    if(i1 != i2 || memcmp(buf1, buf2, i1 < i2 ? i1 : i2) != 0){
80106820:	83 ec 04             	sub    $0x4,%esp
80106823:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
80106829:	57                   	push   %edi
8010682a:	56                   	push   %esi
8010682b:	50                   	push   %eax
8010682c:	e8 ef ec ff ff       	call   80105520 <memcmp>
80106831:	83 c4 10             	add    $0x10,%esp
80106834:	85 c0                	test   %eax,%eax
80106836:	0f 85 fe fe ff ff    	jne    8010673a <sys_diff+0x25a>
8010683c:	e9 59 ff ff ff       	jmp    8010679a <sys_diff+0x2ba>
80106841:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(i1 > 0 && buf1[i1-1] != '\n')
80106848:	83 ef 01             	sub    $0x1,%edi
8010684b:	80 bc 3d e8 fb ff ff 	cmpb   $0xa,-0x418(%ebp,%edi,1)
80106852:	0a 
80106853:	0f 84 22 ff ff ff    	je     8010677b <sys_diff+0x29b>
        cprintf("\n");
80106859:	83 ec 0c             	sub    $0xc,%esp
8010685c:	68 65 8b 10 80       	push   $0x80108b65
80106861:	e8 da a3 ff ff       	call   80100c40 <cprintf>
80106866:	83 c4 10             	add    $0x10,%esp
80106869:	e9 0d ff ff ff       	jmp    8010677b <sys_diff+0x29b>
8010686e:	66 90                	xchg   %ax,%ax
80106870:	89 bd cc fb ff ff    	mov    %edi,-0x434(%ebp)
80106876:	c7 85 d0 fb ff ff 01 	movl   $0x1,-0x430(%ebp)
8010687d:	00 00 00 
    i2 = 0;
80106880:	31 db                	xor    %ebx,%ebx
80106882:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
80106888:	eb 17                	jmp    801068a1 <sys_diff+0x3c1>
8010688a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
          i2++;
80106890:	83 c3 01             	add    $0x1,%ebx
        if(*p2 == '\n'){
80106893:	80 3c 3e 0a          	cmpb   $0xa,(%esi,%edi,1)
80106897:	74 37                	je     801068d0 <sys_diff+0x3f0>
      while(i2 < sizeof(buf2) - 1){
80106899:	81 fb ff 01 00 00    	cmp    $0x1ff,%ebx
8010689f:	74 2f                	je     801068d0 <sys_diff+0x3f0>
        if(fileread(f2, p2, 1) != 1){
801068a1:	83 ec 04             	sub    $0x4,%esp
801068a4:	8d 04 1e             	lea    (%esi,%ebx,1),%eax
801068a7:	89 df                	mov    %ebx,%edi
801068a9:	6a 01                	push   $0x1
801068ab:	50                   	push   %eax
801068ac:	ff b5 d4 fb ff ff    	push   -0x42c(%ebp)
801068b2:	e8 09 b0 ff ff       	call   801018c0 <fileread>
801068b7:	83 c4 10             	add    $0x10,%esp
801068ba:	83 f8 01             	cmp    $0x1,%eax
801068bd:	74 d1                	je     80106890 <sys_diff+0x3b0>
    if(i1 == 0 && i2 == 0)
801068bf:	8b bd cc fb ff ff    	mov    -0x434(%ebp),%edi
801068c5:	89 f8                	mov    %edi,%eax
801068c7:	09 d8                	or     %ebx,%eax
801068c9:	e9 2b fe ff ff       	jmp    801066f9 <sys_diff+0x219>
801068ce:	66 90                	xchg   %ax,%ax
801068d0:	8b bd cc fb ff ff    	mov    -0x434(%ebp),%edi
801068d6:	89 85 c0 fb ff ff    	mov    %eax,-0x440(%ebp)
801068dc:	c7 85 cc fb ff ff 00 	movl   $0x0,-0x434(%ebp)
801068e3:	00 00 00 
801068e6:	e9 30 fe ff ff       	jmp    8010671b <sys_diff+0x23b>
801068eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(!eof2){
801068f0:	8b b5 cc fb ff ff    	mov    -0x434(%ebp),%esi
801068f6:	85 f6                	test   %esi,%esi
801068f8:	74 63                	je     8010695d <sys_diff+0x47d>
      cprintf("Line %d: files differ\n", line);
801068fa:	83 ec 08             	sub    $0x8,%esp
801068fd:	ff b5 c4 fb ff ff    	push   -0x43c(%ebp)
80106903:	68 6b 8a 10 80       	push   $0x80108a6b
80106908:	e8 33 a3 ff ff       	call   80100c40 <cprintf>
      buf1[i1] = '\0';
8010690d:	c6 84 1d e8 fb ff ff 	movb   $0x0,-0x418(%ebp,%ebx,1)
80106914:	00 
      buf2[i2] = '\0';
80106915:	c6 85 e8 fd ff ff 00 	movb   $0x0,-0x218(%ebp)
      cprintf("< %s", buf1);
8010691c:	5b                   	pop    %ebx
      i2 = 0;
8010691d:	31 db                	xor    %ebx,%ebx
      cprintf("< %s", buf1);
8010691f:	58                   	pop    %eax
80106920:	8d 85 e8 fb ff ff    	lea    -0x418(%ebp),%eax
80106926:	50                   	push   %eax
80106927:	68 82 8a 10 80       	push   $0x80108a82
8010692c:	e8 0f a3 ff ff       	call   80100c40 <cprintf>
80106931:	83 c4 10             	add    $0x10,%esp
80106934:	89 b5 c8 fb ff ff    	mov    %esi,-0x438(%ebp)
8010693a:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
80106940:	c7 85 c0 fb ff ff 00 	movl   $0x0,-0x440(%ebp)
80106947:	00 00 00 
8010694a:	e9 fc fe ff ff       	jmp    8010684b <sys_diff+0x36b>
    cprintf("File %s has more lines\n", file1);
8010694f:	83 ec 08             	sub    $0x8,%esp
80106952:	ff b5 e0 fb ff ff    	push   -0x420(%ebp)
80106958:	e9 6d fe ff ff       	jmp    801067ca <sys_diff+0x2ea>
    if(!eof2){
8010695d:	c7 85 d0 fb ff ff 00 	movl   $0x0,-0x430(%ebp)
80106964:	00 00 00 
          i1++;
80106967:	89 9d cc fb ff ff    	mov    %ebx,-0x434(%ebp)
8010696d:	e9 0e ff ff ff       	jmp    80106880 <sys_diff+0x3a0>
    if(!eof2){
80106972:	8b 85 cc fb ff ff    	mov    -0x434(%ebp),%eax
80106978:	85 c0                	test   %eax,%eax
8010697a:	74 22                	je     8010699e <sys_diff+0x4be>
8010697c:	89 85 c8 fb ff ff    	mov    %eax,-0x438(%ebp)
      i2 = 0;
80106982:	31 db                	xor    %ebx,%ebx
    if(!eof2){
80106984:	bf ff 01 00 00       	mov    $0x1ff,%edi
80106989:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi
8010698f:	c7 85 c0 fb ff ff 00 	movl   $0x0,-0x440(%ebp)
80106996:	00 00 00 
80106999:	e9 9c fd ff ff       	jmp    8010673a <sys_diff+0x25a>
8010699e:	c7 85 d0 fb ff ff 00 	movl   $0x0,-0x430(%ebp)
801069a5:	00 00 00 
801069a8:	c7 85 cc fb ff ff ff 	movl   $0x1ff,-0x434(%ebp)
801069af:	01 00 00 
801069b2:	e9 c9 fe ff ff       	jmp    80106880 <sys_diff+0x3a0>
801069b7:	8b 85 d0 fb ff ff    	mov    -0x430(%ebp),%eax
801069bd:	89 85 cc fb ff ff    	mov    %eax,-0x434(%ebp)
801069c3:	e9 80 fc ff ff       	jmp    80106648 <sys_diff+0x168>
    iunlockput(ip1);
801069c8:	83 ec 0c             	sub    $0xc,%esp
801069cb:	53                   	push   %ebx
801069cc:	e8 6f be ff ff       	call   80102840 <iunlockput>
    end_op();
801069d1:	e8 fa d1 ff ff       	call   80103bd0 <end_op>
    cprintf("diff: %s is a directory\n", file1);
801069d6:	5e                   	pop    %esi
801069d7:	5f                   	pop    %edi
801069d8:	ff b5 e0 fb ff ff    	push   -0x420(%ebp)
801069de:	68 52 8a 10 80       	push   $0x80108a52
801069e3:	e8 58 a2 ff ff       	call   80100c40 <cprintf>
    return -1;
801069e8:	83 c4 10             	add    $0x10,%esp
801069eb:	e9 ff fd ff ff       	jmp    801067ef <sys_diff+0x30f>
    iunlockput(ip2);
801069f0:	83 ec 0c             	sub    $0xc,%esp
801069f3:	56                   	push   %esi
801069f4:	e8 47 be ff ff       	call   80102840 <iunlockput>
    fileclose(f1);
801069f9:	58                   	pop    %eax
801069fa:	ff b5 bc fb ff ff    	push   -0x444(%ebp)
80106a00:	e8 8b ad ff ff       	call   80101790 <fileclose>
    end_op();
80106a05:	e8 c6 d1 ff ff       	call   80103bd0 <end_op>
    cprintf("diff: %s is a directory\n", file2);
80106a0a:	58                   	pop    %eax
80106a0b:	5a                   	pop    %edx
80106a0c:	ff b5 e4 fb ff ff    	push   -0x41c(%ebp)
80106a12:	68 52 8a 10 80       	push   $0x80108a52
80106a17:	e8 24 a2 ff ff       	call   80100c40 <cprintf>
    return -1;
80106a1c:	83 c4 10             	add    $0x10,%esp
80106a1f:	e9 cb fd ff ff       	jmp    801067ef <sys_diff+0x30f>
    fileclose(f1);
80106a24:	83 ec 0c             	sub    $0xc,%esp
80106a27:	ff b5 bc fb ff ff    	push   -0x444(%ebp)
80106a2d:	e8 5e ad ff ff       	call   80101790 <fileclose>
    end_op();
80106a32:	e8 99 d1 ff ff       	call   80103bd0 <end_op>
    cprintf("diff: cannot open %s\n", file2);
80106a37:	59                   	pop    %ecx
80106a38:	5b                   	pop    %ebx
80106a39:	ff b5 e4 fb ff ff    	push   -0x41c(%ebp)
80106a3f:	68 3c 8a 10 80       	push   $0x80108a3c
80106a44:	e8 f7 a1 ff ff       	call   80100c40 <cprintf>
    return -1;
80106a49:	83 c4 10             	add    $0x10,%esp
80106a4c:	e9 9e fd ff ff       	jmp    801067ef <sys_diff+0x30f>
    iput(ip1);
80106a51:	83 ec 0c             	sub    $0xc,%esp
80106a54:	53                   	push   %ebx
80106a55:	e8 86 bc ff ff       	call   801026e0 <iput>
    end_op();
80106a5a:	e8 71 d1 ff ff       	call   80103bd0 <end_op>
    return -1;
80106a5f:	83 c4 10             	add    $0x10,%esp
80106a62:	e9 88 fd ff ff       	jmp    801067ef <sys_diff+0x30f>
    end_op();
80106a67:	e8 64 d1 ff ff       	call   80103bd0 <end_op>
    cprintf("diff: cannot open %s\n", file1);
80106a6c:	83 ec 08             	sub    $0x8,%esp
80106a6f:	ff b5 e0 fb ff ff    	push   -0x420(%ebp)
80106a75:	68 3c 8a 10 80       	push   $0x80108a3c
80106a7a:	e8 c1 a1 ff ff       	call   80100c40 <cprintf>
    return -1;
80106a7f:	83 c4 10             	add    $0x10,%esp
80106a82:	e9 68 fd ff ff       	jmp    801067ef <sys_diff+0x30f>
    fileclose(f1);
80106a87:	83 ec 0c             	sub    $0xc,%esp
80106a8a:	ff b5 bc fb ff ff    	push   -0x444(%ebp)
80106a90:	e8 fb ac ff ff       	call   80101790 <fileclose>
    iput(ip2);
80106a95:	89 34 24             	mov    %esi,(%esp)
80106a98:	e8 43 bc ff ff       	call   801026e0 <iput>
    end_op();
80106a9d:	e8 2e d1 ff ff       	call   80103bd0 <end_op>
    return -1;
80106aa2:	83 c4 10             	add    $0x10,%esp
80106aa5:	e9 45 fd ff ff       	jmp    801067ef <sys_diff+0x30f>
80106aaa:	8b 95 d0 fb ff ff    	mov    -0x430(%ebp),%edx
80106ab0:	8b 85 cc fb ff ff    	mov    -0x434(%ebp),%eax
80106ab6:	89 95 cc fb ff ff    	mov    %edx,-0x434(%ebp)
80106abc:	e9 8c fb ff ff       	jmp    8010664d <sys_diff+0x16d>
80106ac1:	66 90                	xchg   %ax,%ax
80106ac3:	66 90                	xchg   %ax,%ax
80106ac5:	66 90                	xchg   %ax,%ax
80106ac7:	66 90                	xchg   %ax,%ax
80106ac9:	66 90                	xchg   %ax,%ax
80106acb:	66 90                	xchg   %ax,%ax
80106acd:	66 90                	xchg   %ax,%ax
80106acf:	90                   	nop

80106ad0 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80106ad0:	e9 6b de ff ff       	jmp    80104940 <fork>
80106ad5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106adc:	00 
80106add:	8d 76 00             	lea    0x0(%esi),%esi

80106ae0 <sys_exit>:
}

int
sys_exit(void)
{
80106ae0:	55                   	push   %ebp
80106ae1:	89 e5                	mov    %esp,%ebp
80106ae3:	83 ec 08             	sub    $0x8,%esp
  exit();
80106ae6:	e8 c5 e0 ff ff       	call   80104bb0 <exit>
  return 0;  // not reached
}
80106aeb:	31 c0                	xor    %eax,%eax
80106aed:	c9                   	leave
80106aee:	c3                   	ret
80106aef:	90                   	nop

80106af0 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80106af0:	e9 eb e1 ff ff       	jmp    80104ce0 <wait>
80106af5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106afc:	00 
80106afd:	8d 76 00             	lea    0x0(%esi),%esi

80106b00 <sys_kill>:
}

int
sys_kill(void)
{
80106b00:	55                   	push   %ebp
80106b01:	89 e5                	mov    %esp,%ebp
80106b03:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80106b06:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106b09:	50                   	push   %eax
80106b0a:	6a 00                	push   $0x0
80106b0c:	e8 7f ec ff ff       	call   80105790 <argint>
80106b11:	83 c4 10             	add    $0x10,%esp
80106b14:	85 c0                	test   %eax,%eax
80106b16:	78 18                	js     80106b30 <sys_kill+0x30>
    return -1;
  return kill(pid);
80106b18:	83 ec 0c             	sub    $0xc,%esp
80106b1b:	ff 75 f4             	push   -0xc(%ebp)
80106b1e:	e8 5d e4 ff ff       	call   80104f80 <kill>
80106b23:	83 c4 10             	add    $0x10,%esp
}
80106b26:	c9                   	leave
80106b27:	c3                   	ret
80106b28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106b2f:	00 
80106b30:	c9                   	leave
    return -1;
80106b31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b36:	c3                   	ret
80106b37:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106b3e:	00 
80106b3f:	90                   	nop

80106b40 <sys_getpid>:

int
sys_getpid(void)
{
80106b40:	55                   	push   %ebp
80106b41:	89 e5                	mov    %esp,%ebp
80106b43:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80106b46:	e8 45 dc ff ff       	call   80104790 <myproc>
80106b4b:	8b 40 10             	mov    0x10(%eax),%eax
}
80106b4e:	c9                   	leave
80106b4f:	c3                   	ret

80106b50 <sys_sbrk>:

int
sys_sbrk(void)
{
80106b50:	55                   	push   %ebp
80106b51:	89 e5                	mov    %esp,%ebp
80106b53:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80106b54:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106b57:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80106b5a:	50                   	push   %eax
80106b5b:	6a 00                	push   $0x0
80106b5d:	e8 2e ec ff ff       	call   80105790 <argint>
80106b62:	83 c4 10             	add    $0x10,%esp
80106b65:	85 c0                	test   %eax,%eax
80106b67:	78 27                	js     80106b90 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80106b69:	e8 22 dc ff ff       	call   80104790 <myproc>
  if(growproc(n) < 0)
80106b6e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80106b71:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80106b73:	ff 75 f4             	push   -0xc(%ebp)
80106b76:	e8 45 dd ff ff       	call   801048c0 <growproc>
80106b7b:	83 c4 10             	add    $0x10,%esp
80106b7e:	85 c0                	test   %eax,%eax
80106b80:	78 0e                	js     80106b90 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80106b82:	89 d8                	mov    %ebx,%eax
80106b84:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106b87:	c9                   	leave
80106b88:	c3                   	ret
80106b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106b90:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80106b95:	eb eb                	jmp    80106b82 <sys_sbrk+0x32>
80106b97:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106b9e:	00 
80106b9f:	90                   	nop

80106ba0 <sys_sleep>:

int
sys_sleep(void)
{
80106ba0:	55                   	push   %ebp
80106ba1:	89 e5                	mov    %esp,%ebp
80106ba3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80106ba4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80106ba7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80106baa:	50                   	push   %eax
80106bab:	6a 00                	push   $0x0
80106bad:	e8 de eb ff ff       	call   80105790 <argint>
80106bb2:	83 c4 10             	add    $0x10,%esp
80106bb5:	85 c0                	test   %eax,%eax
80106bb7:	78 64                	js     80106c1d <sys_sleep+0x7d>
    return -1;
  acquire(&tickslock);
80106bb9:	83 ec 0c             	sub    $0xc,%esp
80106bbc:	68 a0 81 11 80       	push   $0x801181a0
80106bc1:	e8 1a e8 ff ff       	call   801053e0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80106bc6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80106bc9:	8b 1d 80 81 11 80    	mov    0x80118180,%ebx
  while(ticks - ticks0 < n){
80106bcf:	83 c4 10             	add    $0x10,%esp
80106bd2:	85 d2                	test   %edx,%edx
80106bd4:	75 2b                	jne    80106c01 <sys_sleep+0x61>
80106bd6:	eb 58                	jmp    80106c30 <sys_sleep+0x90>
80106bd8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106bdf:	00 
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80106be0:	83 ec 08             	sub    $0x8,%esp
80106be3:	68 a0 81 11 80       	push   $0x801181a0
80106be8:	68 80 81 11 80       	push   $0x80118180
80106bed:	e8 6e e2 ff ff       	call   80104e60 <sleep>
  while(ticks - ticks0 < n){
80106bf2:	a1 80 81 11 80       	mov    0x80118180,%eax
80106bf7:	83 c4 10             	add    $0x10,%esp
80106bfa:	29 d8                	sub    %ebx,%eax
80106bfc:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80106bff:	73 2f                	jae    80106c30 <sys_sleep+0x90>
    if(myproc()->killed){
80106c01:	e8 8a db ff ff       	call   80104790 <myproc>
80106c06:	8b 40 24             	mov    0x24(%eax),%eax
80106c09:	85 c0                	test   %eax,%eax
80106c0b:	74 d3                	je     80106be0 <sys_sleep+0x40>
      release(&tickslock);
80106c0d:	83 ec 0c             	sub    $0xc,%esp
80106c10:	68 a0 81 11 80       	push   $0x801181a0
80106c15:	e8 66 e7 ff ff       	call   80105380 <release>
      return -1;
80106c1a:	83 c4 10             	add    $0x10,%esp
  }
  release(&tickslock);
  return 0;
}
80106c1d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80106c20:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106c25:	c9                   	leave
80106c26:	c3                   	ret
80106c27:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106c2e:	00 
80106c2f:	90                   	nop
  release(&tickslock);
80106c30:	83 ec 0c             	sub    $0xc,%esp
80106c33:	68 a0 81 11 80       	push   $0x801181a0
80106c38:	e8 43 e7 ff ff       	call   80105380 <release>
}
80106c3d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return 0;
80106c40:	83 c4 10             	add    $0x10,%esp
80106c43:	31 c0                	xor    %eax,%eax
}
80106c45:	c9                   	leave
80106c46:	c3                   	ret
80106c47:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106c4e:	00 
80106c4f:	90                   	nop

80106c50 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80106c50:	55                   	push   %ebp
80106c51:	89 e5                	mov    %esp,%ebp
80106c53:	53                   	push   %ebx
80106c54:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80106c57:	68 a0 81 11 80       	push   $0x801181a0
80106c5c:	e8 7f e7 ff ff       	call   801053e0 <acquire>
  xticks = ticks;
80106c61:	8b 1d 80 81 11 80    	mov    0x80118180,%ebx
  release(&tickslock);
80106c67:	c7 04 24 a0 81 11 80 	movl   $0x801181a0,(%esp)
80106c6e:	e8 0d e7 ff ff       	call   80105380 <release>
  return xticks;
}
80106c73:	89 d8                	mov    %ebx,%eax
80106c75:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106c78:	c9                   	leave
80106c79:	c3                   	ret
80106c7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106c80 <sys_set_sleep>:

int
sys_set_sleep(void)
80106c80:	e9 1b ff ff ff       	jmp    80106ba0 <sys_sleep>
80106c85:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106c8c:	00 
80106c8d:	8d 76 00             	lea    0x0(%esi),%esi

80106c90 <sys_getcmostime>:
  return 0;
}

int
sys_getcmostime(void)
{
80106c90:	55                   	push   %ebp
80106c91:	89 e5                	mov    %esp,%ebp
80106c93:	83 ec 1c             	sub    $0x1c,%esp
  struct rtcdate *r;
  
  if(argptr(0, (char**)&r, sizeof(*r)) < 0)
80106c96:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106c99:	6a 18                	push   $0x18
80106c9b:	50                   	push   %eax
80106c9c:	6a 00                	push   $0x0
80106c9e:	e8 3d eb ff ff       	call   801057e0 <argptr>
80106ca3:	83 c4 10             	add    $0x10,%esp
80106ca6:	85 c0                	test   %eax,%eax
80106ca8:	78 16                	js     80106cc0 <sys_getcmostime+0x30>
    return -1;
  
  cmostime(r);
80106caa:	83 ec 0c             	sub    $0xc,%esp
80106cad:	ff 75 f4             	push   -0xc(%ebp)
80106cb0:	e8 1b cb ff ff       	call   801037d0 <cmostime>
  return 0;
80106cb5:	83 c4 10             	add    $0x10,%esp
80106cb8:	31 c0                	xor    %eax,%eax
}
80106cba:	c9                   	leave
80106cbb:	c3                   	ret
80106cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106cc0:	c9                   	leave
    return -1;
80106cc1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106cc6:	c3                   	ret

80106cc7 <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80106cc7:	1e                   	push   %ds
  pushl %es
80106cc8:	06                   	push   %es
  pushl %fs
80106cc9:	0f a0                	push   %fs
  pushl %gs
80106ccb:	0f a8                	push   %gs
  pushal
80106ccd:	60                   	pusha
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80106cce:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80106cd2:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80106cd4:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80106cd6:	54                   	push   %esp
  call trap
80106cd7:	e8 c4 00 00 00       	call   80106da0 <trap>
  addl $4, %esp
80106cdc:	83 c4 04             	add    $0x4,%esp

80106cdf <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80106cdf:	61                   	popa
  popl %gs
80106ce0:	0f a9                	pop    %gs
  popl %fs
80106ce2:	0f a1                	pop    %fs
  popl %es
80106ce4:	07                   	pop    %es
  popl %ds
80106ce5:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80106ce6:	83 c4 08             	add    $0x8,%esp
  iret
80106ce9:	cf                   	iret
80106cea:	66 90                	xchg   %ax,%ax
80106cec:	66 90                	xchg   %ax,%ax
80106cee:	66 90                	xchg   %ax,%ax

80106cf0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80106cf0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80106cf1:	31 c0                	xor    %eax,%eax
{
80106cf3:	89 e5                	mov    %esp,%ebp
80106cf5:	83 ec 08             	sub    $0x8,%esp
80106cf8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106cff:	00 
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80106d00:	8b 14 85 08 c0 10 80 	mov    -0x7fef3ff8(,%eax,4),%edx
80106d07:	c7 04 c5 e2 81 11 80 	movl   $0x8e000008,-0x7fee7e1e(,%eax,8)
80106d0e:	08 00 00 8e 
80106d12:	66 89 14 c5 e0 81 11 	mov    %dx,-0x7fee7e20(,%eax,8)
80106d19:	80 
80106d1a:	c1 ea 10             	shr    $0x10,%edx
80106d1d:	66 89 14 c5 e6 81 11 	mov    %dx,-0x7fee7e1a(,%eax,8)
80106d24:	80 
  for(i = 0; i < 256; i++)
80106d25:	83 c0 01             	add    $0x1,%eax
80106d28:	3d 00 01 00 00       	cmp    $0x100,%eax
80106d2d:	75 d1                	jne    80106d00 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80106d2f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106d32:	a1 08 c1 10 80       	mov    0x8010c108,%eax
80106d37:	c7 05 e2 83 11 80 08 	movl   $0xef000008,0x801183e2
80106d3e:	00 00 ef 
  initlock(&tickslock, "time");
80106d41:	68 a4 8a 10 80       	push   $0x80108aa4
80106d46:	68 a0 81 11 80       	push   $0x801181a0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106d4b:	66 a3 e0 83 11 80    	mov    %ax,0x801183e0
80106d51:	c1 e8 10             	shr    $0x10,%eax
80106d54:	66 a3 e6 83 11 80    	mov    %ax,0x801183e6
  initlock(&tickslock, "time");
80106d5a:	e8 91 e4 ff ff       	call   801051f0 <initlock>
}
80106d5f:	83 c4 10             	add    $0x10,%esp
80106d62:	c9                   	leave
80106d63:	c3                   	ret
80106d64:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106d6b:	00 
80106d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106d70 <idtinit>:

void
idtinit(void)
{
80106d70:	55                   	push   %ebp
  pd[0] = size-1;
80106d71:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106d76:	89 e5                	mov    %esp,%ebp
80106d78:	83 ec 10             	sub    $0x10,%esp
80106d7b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80106d7f:	b8 e0 81 11 80       	mov    $0x801181e0,%eax
80106d84:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106d88:	c1 e8 10             	shr    $0x10,%eax
80106d8b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80106d8f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106d92:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106d95:	c9                   	leave
80106d96:	c3                   	ret
80106d97:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106d9e:	00 
80106d9f:	90                   	nop

80106da0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106da0:	55                   	push   %ebp
80106da1:	89 e5                	mov    %esp,%ebp
80106da3:	57                   	push   %edi
80106da4:	56                   	push   %esi
80106da5:	53                   	push   %ebx
80106da6:	83 ec 1c             	sub    $0x1c,%esp
80106da9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80106dac:	8b 43 30             	mov    0x30(%ebx),%eax
80106daf:	83 f8 40             	cmp    $0x40,%eax
80106db2:	0f 84 58 01 00 00    	je     80106f10 <trap+0x170>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106db8:	83 e8 20             	sub    $0x20,%eax
80106dbb:	83 f8 1f             	cmp    $0x1f,%eax
80106dbe:	0f 87 7c 00 00 00    	ja     80106e40 <trap+0xa0>
80106dc4:	ff 24 85 78 90 10 80 	jmp    *-0x7fef6f88(,%eax,4)
80106dcb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80106dd0:	e8 6b c2 ff ff       	call   80103040 <ideintr>
    lapiceoi();
80106dd5:	e8 36 c9 ff ff       	call   80103710 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106dda:	e8 b1 d9 ff ff       	call   80104790 <myproc>
80106ddf:	85 c0                	test   %eax,%eax
80106de1:	74 1a                	je     80106dfd <trap+0x5d>
80106de3:	e8 a8 d9 ff ff       	call   80104790 <myproc>
80106de8:	8b 50 24             	mov    0x24(%eax),%edx
80106deb:	85 d2                	test   %edx,%edx
80106ded:	74 0e                	je     80106dfd <trap+0x5d>
80106def:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106df3:	f7 d0                	not    %eax
80106df5:	a8 03                	test   $0x3,%al
80106df7:	0f 84 db 01 00 00    	je     80106fd8 <trap+0x238>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106dfd:	e8 8e d9 ff ff       	call   80104790 <myproc>
80106e02:	85 c0                	test   %eax,%eax
80106e04:	74 0f                	je     80106e15 <trap+0x75>
80106e06:	e8 85 d9 ff ff       	call   80104790 <myproc>
80106e0b:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106e0f:	0f 84 ab 00 00 00    	je     80106ec0 <trap+0x120>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106e15:	e8 76 d9 ff ff       	call   80104790 <myproc>
80106e1a:	85 c0                	test   %eax,%eax
80106e1c:	74 1a                	je     80106e38 <trap+0x98>
80106e1e:	e8 6d d9 ff ff       	call   80104790 <myproc>
80106e23:	8b 40 24             	mov    0x24(%eax),%eax
80106e26:	85 c0                	test   %eax,%eax
80106e28:	74 0e                	je     80106e38 <trap+0x98>
80106e2a:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80106e2e:	f7 d0                	not    %eax
80106e30:	a8 03                	test   $0x3,%al
80106e32:	0f 84 05 01 00 00    	je     80106f3d <trap+0x19d>
    exit();
}
80106e38:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e3b:	5b                   	pop    %ebx
80106e3c:	5e                   	pop    %esi
80106e3d:	5f                   	pop    %edi
80106e3e:	5d                   	pop    %ebp
80106e3f:	c3                   	ret
    if(myproc() == 0 || (tf->cs&3) == 0){
80106e40:	e8 4b d9 ff ff       	call   80104790 <myproc>
80106e45:	8b 7b 38             	mov    0x38(%ebx),%edi
80106e48:	85 c0                	test   %eax,%eax
80106e4a:	0f 84 a2 01 00 00    	je     80106ff2 <trap+0x252>
80106e50:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106e54:	0f 84 98 01 00 00    	je     80106ff2 <trap+0x252>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80106e5a:	0f 20 d1             	mov    %cr2,%ecx
80106e5d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106e60:	e8 0b d9 ff ff       	call   80104770 <cpuid>
80106e65:	8b 73 30             	mov    0x30(%ebx),%esi
80106e68:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106e6b:	8b 43 34             	mov    0x34(%ebx),%eax
80106e6e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80106e71:	e8 1a d9 ff ff       	call   80104790 <myproc>
80106e76:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106e79:	e8 12 d9 ff ff       	call   80104790 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106e7e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106e81:	51                   	push   %ecx
80106e82:	57                   	push   %edi
80106e83:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106e86:	52                   	push   %edx
80106e87:	ff 75 e4             	push   -0x1c(%ebp)
80106e8a:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80106e8b:	8b 75 e0             	mov    -0x20(%ebp),%esi
80106e8e:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106e91:	56                   	push   %esi
80106e92:	ff 70 10             	push   0x10(%eax)
80106e95:	68 44 8d 10 80       	push   $0x80108d44
80106e9a:	e8 a1 9d ff ff       	call   80100c40 <cprintf>
    myproc()->killed = 1;
80106e9f:	83 c4 20             	add    $0x20,%esp
80106ea2:	e8 e9 d8 ff ff       	call   80104790 <myproc>
80106ea7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106eae:	e8 dd d8 ff ff       	call   80104790 <myproc>
80106eb3:	85 c0                	test   %eax,%eax
80106eb5:	0f 85 28 ff ff ff    	jne    80106de3 <trap+0x43>
80106ebb:	e9 3d ff ff ff       	jmp    80106dfd <trap+0x5d>
  if(myproc() && myproc()->state == RUNNING &&
80106ec0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80106ec4:	0f 85 4b ff ff ff    	jne    80106e15 <trap+0x75>
    yield();
80106eca:	e8 41 df ff ff       	call   80104e10 <yield>
80106ecf:	e9 41 ff ff ff       	jmp    80106e15 <trap+0x75>
80106ed4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106ed8:	8b 7b 38             	mov    0x38(%ebx),%edi
80106edb:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80106edf:	e8 8c d8 ff ff       	call   80104770 <cpuid>
80106ee4:	57                   	push   %edi
80106ee5:	56                   	push   %esi
80106ee6:	50                   	push   %eax
80106ee7:	68 ec 8c 10 80       	push   $0x80108cec
80106eec:	e8 4f 9d ff ff       	call   80100c40 <cprintf>
    lapiceoi();
80106ef1:	e8 1a c8 ff ff       	call   80103710 <lapiceoi>
    break;
80106ef6:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106ef9:	e8 92 d8 ff ff       	call   80104790 <myproc>
80106efe:	85 c0                	test   %eax,%eax
80106f00:	0f 85 dd fe ff ff    	jne    80106de3 <trap+0x43>
80106f06:	e9 f2 fe ff ff       	jmp    80106dfd <trap+0x5d>
80106f0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80106f10:	e8 7b d8 ff ff       	call   80104790 <myproc>
80106f15:	8b 70 24             	mov    0x24(%eax),%esi
80106f18:	85 f6                	test   %esi,%esi
80106f1a:	0f 85 c8 00 00 00    	jne    80106fe8 <trap+0x248>
    myproc()->tf = tf;
80106f20:	e8 6b d8 ff ff       	call   80104790 <myproc>
80106f25:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80106f28:	e8 a3 e9 ff ff       	call   801058d0 <syscall>
    if(myproc()->killed)
80106f2d:	e8 5e d8 ff ff       	call   80104790 <myproc>
80106f32:	8b 48 24             	mov    0x24(%eax),%ecx
80106f35:	85 c9                	test   %ecx,%ecx
80106f37:	0f 84 fb fe ff ff    	je     80106e38 <trap+0x98>
}
80106f3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f40:	5b                   	pop    %ebx
80106f41:	5e                   	pop    %esi
80106f42:	5f                   	pop    %edi
80106f43:	5d                   	pop    %ebp
      exit();
80106f44:	e9 67 dc ff ff       	jmp    80104bb0 <exit>
80106f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106f50:	e8 4b 02 00 00       	call   801071a0 <uartintr>
    lapiceoi();
80106f55:	e8 b6 c7 ff ff       	call   80103710 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106f5a:	e8 31 d8 ff ff       	call   80104790 <myproc>
80106f5f:	85 c0                	test   %eax,%eax
80106f61:	0f 85 7c fe ff ff    	jne    80106de3 <trap+0x43>
80106f67:	e9 91 fe ff ff       	jmp    80106dfd <trap+0x5d>
80106f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80106f70:	e8 6b c6 ff ff       	call   801035e0 <kbdintr>
    lapiceoi();
80106f75:	e8 96 c7 ff ff       	call   80103710 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106f7a:	e8 11 d8 ff ff       	call   80104790 <myproc>
80106f7f:	85 c0                	test   %eax,%eax
80106f81:	0f 85 5c fe ff ff    	jne    80106de3 <trap+0x43>
80106f87:	e9 71 fe ff ff       	jmp    80106dfd <trap+0x5d>
80106f8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80106f90:	e8 db d7 ff ff       	call   80104770 <cpuid>
80106f95:	85 c0                	test   %eax,%eax
80106f97:	0f 85 38 fe ff ff    	jne    80106dd5 <trap+0x35>
      acquire(&tickslock);
80106f9d:	83 ec 0c             	sub    $0xc,%esp
80106fa0:	68 a0 81 11 80       	push   $0x801181a0
80106fa5:	e8 36 e4 ff ff       	call   801053e0 <acquire>
      ticks++;
80106faa:	83 05 80 81 11 80 01 	addl   $0x1,0x80118180
      wakeup(&ticks);
80106fb1:	c7 04 24 80 81 11 80 	movl   $0x80118180,(%esp)
80106fb8:	e8 63 df ff ff       	call   80104f20 <wakeup>
      release(&tickslock);
80106fbd:	c7 04 24 a0 81 11 80 	movl   $0x801181a0,(%esp)
80106fc4:	e8 b7 e3 ff ff       	call   80105380 <release>
80106fc9:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80106fcc:	e9 04 fe ff ff       	jmp    80106dd5 <trap+0x35>
80106fd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80106fd8:	e8 d3 db ff ff       	call   80104bb0 <exit>
80106fdd:	e9 1b fe ff ff       	jmp    80106dfd <trap+0x5d>
80106fe2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106fe8:	e8 c3 db ff ff       	call   80104bb0 <exit>
80106fed:	e9 2e ff ff ff       	jmp    80106f20 <trap+0x180>
80106ff2:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80106ff5:	e8 76 d7 ff ff       	call   80104770 <cpuid>
80106ffa:	83 ec 0c             	sub    $0xc,%esp
80106ffd:	56                   	push   %esi
80106ffe:	57                   	push   %edi
80106fff:	50                   	push   %eax
80107000:	ff 73 30             	push   0x30(%ebx)
80107003:	68 10 8d 10 80       	push   $0x80108d10
80107008:	e8 33 9c ff ff       	call   80100c40 <cprintf>
      panic("trap");
8010700d:	83 c4 14             	add    $0x14,%esp
80107010:	68 a9 8a 10 80       	push   $0x80108aa9
80107015:	e8 86 93 ff ff       	call   801003a0 <panic>
8010701a:	66 90                	xchg   %ax,%ax
8010701c:	66 90                	xchg   %ax,%ax
8010701e:	66 90                	xchg   %ax,%ax

80107020 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80107020:	a1 e0 89 11 80       	mov    0x801189e0,%eax
80107025:	85 c0                	test   %eax,%eax
80107027:	74 17                	je     80107040 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80107029:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010702e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
8010702f:	a8 01                	test   $0x1,%al
80107031:	74 0d                	je     80107040 <uartgetc+0x20>
80107033:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107038:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80107039:	0f b6 c0             	movzbl %al,%eax
8010703c:	c3                   	ret
8010703d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80107040:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107045:	c3                   	ret
80107046:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010704d:	00 
8010704e:	66 90                	xchg   %ax,%ax

80107050 <uartinit>:
{
80107050:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107051:	31 c9                	xor    %ecx,%ecx
80107053:	89 c8                	mov    %ecx,%eax
80107055:	89 e5                	mov    %esp,%ebp
80107057:	57                   	push   %edi
80107058:	bf fa 03 00 00       	mov    $0x3fa,%edi
8010705d:	56                   	push   %esi
8010705e:	89 fa                	mov    %edi,%edx
80107060:	53                   	push   %ebx
80107061:	83 ec 1c             	sub    $0x1c,%esp
80107064:	ee                   	out    %al,(%dx)
80107065:	be fb 03 00 00       	mov    $0x3fb,%esi
8010706a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010706f:	89 f2                	mov    %esi,%edx
80107071:	ee                   	out    %al,(%dx)
80107072:	b8 0c 00 00 00       	mov    $0xc,%eax
80107077:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010707c:	ee                   	out    %al,(%dx)
8010707d:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80107082:	89 c8                	mov    %ecx,%eax
80107084:	89 da                	mov    %ebx,%edx
80107086:	ee                   	out    %al,(%dx)
80107087:	b8 03 00 00 00       	mov    $0x3,%eax
8010708c:	89 f2                	mov    %esi,%edx
8010708e:	ee                   	out    %al,(%dx)
8010708f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80107094:	89 c8                	mov    %ecx,%eax
80107096:	ee                   	out    %al,(%dx)
80107097:	b8 01 00 00 00       	mov    $0x1,%eax
8010709c:	89 da                	mov    %ebx,%edx
8010709e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010709f:	ba fd 03 00 00       	mov    $0x3fd,%edx
801070a4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801070a5:	3c ff                	cmp    $0xff,%al
801070a7:	0f 84 7c 00 00 00    	je     80107129 <uartinit+0xd9>
  uart = 1;
801070ad:	c7 05 e0 89 11 80 01 	movl   $0x1,0x801189e0
801070b4:	00 00 00 
801070b7:	89 fa                	mov    %edi,%edx
801070b9:	ec                   	in     (%dx),%al
801070ba:	ba f8 03 00 00       	mov    $0x3f8,%edx
801070bf:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801070c0:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
801070c3:	bf ae 8a 10 80       	mov    $0x80108aae,%edi
801070c8:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
801070cd:	6a 00                	push   $0x0
801070cf:	6a 04                	push   $0x4
801070d1:	e8 9a c1 ff ff       	call   80103270 <ioapicenable>
801070d6:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
801070d9:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
801070dd:	8d 76 00             	lea    0x0(%esi),%esi
  if(!uart)
801070e0:	a1 e0 89 11 80       	mov    0x801189e0,%eax
801070e5:	85 c0                	test   %eax,%eax
801070e7:	74 32                	je     8010711b <uartinit+0xcb>
801070e9:	89 f2                	mov    %esi,%edx
801070eb:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
801070ec:	a8 20                	test   $0x20,%al
801070ee:	75 21                	jne    80107111 <uartinit+0xc1>
801070f0:	bb 80 00 00 00       	mov    $0x80,%ebx
801070f5:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
801070f8:	83 ec 0c             	sub    $0xc,%esp
801070fb:	6a 0a                	push   $0xa
801070fd:	e8 2e c6 ff ff       	call   80103730 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80107102:	83 c4 10             	add    $0x10,%esp
80107105:	83 eb 01             	sub    $0x1,%ebx
80107108:	74 07                	je     80107111 <uartinit+0xc1>
8010710a:	89 f2                	mov    %esi,%edx
8010710c:	ec                   	in     (%dx),%al
8010710d:	a8 20                	test   $0x20,%al
8010710f:	74 e7                	je     801070f8 <uartinit+0xa8>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107111:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107116:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010711a:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
8010711b:	0f b6 47 01          	movzbl 0x1(%edi),%eax
8010711f:	83 c7 01             	add    $0x1,%edi
80107122:	88 45 e7             	mov    %al,-0x19(%ebp)
80107125:	84 c0                	test   %al,%al
80107127:	75 b7                	jne    801070e0 <uartinit+0x90>
}
80107129:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010712c:	5b                   	pop    %ebx
8010712d:	5e                   	pop    %esi
8010712e:	5f                   	pop    %edi
8010712f:	5d                   	pop    %ebp
80107130:	c3                   	ret
80107131:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107138:	00 
80107139:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107140 <uartputc>:
  if(!uart)
80107140:	a1 e0 89 11 80       	mov    0x801189e0,%eax
80107145:	85 c0                	test   %eax,%eax
80107147:	74 4f                	je     80107198 <uartputc+0x58>
{
80107149:	55                   	push   %ebp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010714a:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010714f:	89 e5                	mov    %esp,%ebp
80107151:	56                   	push   %esi
80107152:	53                   	push   %ebx
80107153:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80107154:	a8 20                	test   $0x20,%al
80107156:	75 29                	jne    80107181 <uartputc+0x41>
80107158:	bb 80 00 00 00       	mov    $0x80,%ebx
8010715d:	be fd 03 00 00       	mov    $0x3fd,%esi
80107162:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80107168:	83 ec 0c             	sub    $0xc,%esp
8010716b:	6a 0a                	push   $0xa
8010716d:	e8 be c5 ff ff       	call   80103730 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80107172:	83 c4 10             	add    $0x10,%esp
80107175:	83 eb 01             	sub    $0x1,%ebx
80107178:	74 07                	je     80107181 <uartputc+0x41>
8010717a:	89 f2                	mov    %esi,%edx
8010717c:	ec                   	in     (%dx),%al
8010717d:	a8 20                	test   $0x20,%al
8010717f:	74 e7                	je     80107168 <uartputc+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107181:	8b 45 08             	mov    0x8(%ebp),%eax
80107184:	ba f8 03 00 00       	mov    $0x3f8,%edx
80107189:	ee                   	out    %al,(%dx)
}
8010718a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010718d:	5b                   	pop    %ebx
8010718e:	5e                   	pop    %esi
8010718f:	5d                   	pop    %ebp
80107190:	c3                   	ret
80107191:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107198:	c3                   	ret
80107199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801071a0 <uartintr>:

void
uartintr(void)
{
801071a0:	55                   	push   %ebp
801071a1:	89 e5                	mov    %esp,%ebp
801071a3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
801071a6:	68 20 70 10 80       	push   $0x80107020
801071ab:	e8 c0 9d ff ff       	call   80100f70 <consoleintr>
}
801071b0:	83 c4 10             	add    $0x10,%esp
801071b3:	c9                   	leave
801071b4:	c3                   	ret

801071b5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
801071b5:	6a 00                	push   $0x0
  pushl $0
801071b7:	6a 00                	push   $0x0
  jmp alltraps
801071b9:	e9 09 fb ff ff       	jmp    80106cc7 <alltraps>

801071be <vector1>:
.globl vector1
vector1:
  pushl $0
801071be:	6a 00                	push   $0x0
  pushl $1
801071c0:	6a 01                	push   $0x1
  jmp alltraps
801071c2:	e9 00 fb ff ff       	jmp    80106cc7 <alltraps>

801071c7 <vector2>:
.globl vector2
vector2:
  pushl $0
801071c7:	6a 00                	push   $0x0
  pushl $2
801071c9:	6a 02                	push   $0x2
  jmp alltraps
801071cb:	e9 f7 fa ff ff       	jmp    80106cc7 <alltraps>

801071d0 <vector3>:
.globl vector3
vector3:
  pushl $0
801071d0:	6a 00                	push   $0x0
  pushl $3
801071d2:	6a 03                	push   $0x3
  jmp alltraps
801071d4:	e9 ee fa ff ff       	jmp    80106cc7 <alltraps>

801071d9 <vector4>:
.globl vector4
vector4:
  pushl $0
801071d9:	6a 00                	push   $0x0
  pushl $4
801071db:	6a 04                	push   $0x4
  jmp alltraps
801071dd:	e9 e5 fa ff ff       	jmp    80106cc7 <alltraps>

801071e2 <vector5>:
.globl vector5
vector5:
  pushl $0
801071e2:	6a 00                	push   $0x0
  pushl $5
801071e4:	6a 05                	push   $0x5
  jmp alltraps
801071e6:	e9 dc fa ff ff       	jmp    80106cc7 <alltraps>

801071eb <vector6>:
.globl vector6
vector6:
  pushl $0
801071eb:	6a 00                	push   $0x0
  pushl $6
801071ed:	6a 06                	push   $0x6
  jmp alltraps
801071ef:	e9 d3 fa ff ff       	jmp    80106cc7 <alltraps>

801071f4 <vector7>:
.globl vector7
vector7:
  pushl $0
801071f4:	6a 00                	push   $0x0
  pushl $7
801071f6:	6a 07                	push   $0x7
  jmp alltraps
801071f8:	e9 ca fa ff ff       	jmp    80106cc7 <alltraps>

801071fd <vector8>:
.globl vector8
vector8:
  pushl $8
801071fd:	6a 08                	push   $0x8
  jmp alltraps
801071ff:	e9 c3 fa ff ff       	jmp    80106cc7 <alltraps>

80107204 <vector9>:
.globl vector9
vector9:
  pushl $0
80107204:	6a 00                	push   $0x0
  pushl $9
80107206:	6a 09                	push   $0x9
  jmp alltraps
80107208:	e9 ba fa ff ff       	jmp    80106cc7 <alltraps>

8010720d <vector10>:
.globl vector10
vector10:
  pushl $10
8010720d:	6a 0a                	push   $0xa
  jmp alltraps
8010720f:	e9 b3 fa ff ff       	jmp    80106cc7 <alltraps>

80107214 <vector11>:
.globl vector11
vector11:
  pushl $11
80107214:	6a 0b                	push   $0xb
  jmp alltraps
80107216:	e9 ac fa ff ff       	jmp    80106cc7 <alltraps>

8010721b <vector12>:
.globl vector12
vector12:
  pushl $12
8010721b:	6a 0c                	push   $0xc
  jmp alltraps
8010721d:	e9 a5 fa ff ff       	jmp    80106cc7 <alltraps>

80107222 <vector13>:
.globl vector13
vector13:
  pushl $13
80107222:	6a 0d                	push   $0xd
  jmp alltraps
80107224:	e9 9e fa ff ff       	jmp    80106cc7 <alltraps>

80107229 <vector14>:
.globl vector14
vector14:
  pushl $14
80107229:	6a 0e                	push   $0xe
  jmp alltraps
8010722b:	e9 97 fa ff ff       	jmp    80106cc7 <alltraps>

80107230 <vector15>:
.globl vector15
vector15:
  pushl $0
80107230:	6a 00                	push   $0x0
  pushl $15
80107232:	6a 0f                	push   $0xf
  jmp alltraps
80107234:	e9 8e fa ff ff       	jmp    80106cc7 <alltraps>

80107239 <vector16>:
.globl vector16
vector16:
  pushl $0
80107239:	6a 00                	push   $0x0
  pushl $16
8010723b:	6a 10                	push   $0x10
  jmp alltraps
8010723d:	e9 85 fa ff ff       	jmp    80106cc7 <alltraps>

80107242 <vector17>:
.globl vector17
vector17:
  pushl $17
80107242:	6a 11                	push   $0x11
  jmp alltraps
80107244:	e9 7e fa ff ff       	jmp    80106cc7 <alltraps>

80107249 <vector18>:
.globl vector18
vector18:
  pushl $0
80107249:	6a 00                	push   $0x0
  pushl $18
8010724b:	6a 12                	push   $0x12
  jmp alltraps
8010724d:	e9 75 fa ff ff       	jmp    80106cc7 <alltraps>

80107252 <vector19>:
.globl vector19
vector19:
  pushl $0
80107252:	6a 00                	push   $0x0
  pushl $19
80107254:	6a 13                	push   $0x13
  jmp alltraps
80107256:	e9 6c fa ff ff       	jmp    80106cc7 <alltraps>

8010725b <vector20>:
.globl vector20
vector20:
  pushl $0
8010725b:	6a 00                	push   $0x0
  pushl $20
8010725d:	6a 14                	push   $0x14
  jmp alltraps
8010725f:	e9 63 fa ff ff       	jmp    80106cc7 <alltraps>

80107264 <vector21>:
.globl vector21
vector21:
  pushl $0
80107264:	6a 00                	push   $0x0
  pushl $21
80107266:	6a 15                	push   $0x15
  jmp alltraps
80107268:	e9 5a fa ff ff       	jmp    80106cc7 <alltraps>

8010726d <vector22>:
.globl vector22
vector22:
  pushl $0
8010726d:	6a 00                	push   $0x0
  pushl $22
8010726f:	6a 16                	push   $0x16
  jmp alltraps
80107271:	e9 51 fa ff ff       	jmp    80106cc7 <alltraps>

80107276 <vector23>:
.globl vector23
vector23:
  pushl $0
80107276:	6a 00                	push   $0x0
  pushl $23
80107278:	6a 17                	push   $0x17
  jmp alltraps
8010727a:	e9 48 fa ff ff       	jmp    80106cc7 <alltraps>

8010727f <vector24>:
.globl vector24
vector24:
  pushl $0
8010727f:	6a 00                	push   $0x0
  pushl $24
80107281:	6a 18                	push   $0x18
  jmp alltraps
80107283:	e9 3f fa ff ff       	jmp    80106cc7 <alltraps>

80107288 <vector25>:
.globl vector25
vector25:
  pushl $0
80107288:	6a 00                	push   $0x0
  pushl $25
8010728a:	6a 19                	push   $0x19
  jmp alltraps
8010728c:	e9 36 fa ff ff       	jmp    80106cc7 <alltraps>

80107291 <vector26>:
.globl vector26
vector26:
  pushl $0
80107291:	6a 00                	push   $0x0
  pushl $26
80107293:	6a 1a                	push   $0x1a
  jmp alltraps
80107295:	e9 2d fa ff ff       	jmp    80106cc7 <alltraps>

8010729a <vector27>:
.globl vector27
vector27:
  pushl $0
8010729a:	6a 00                	push   $0x0
  pushl $27
8010729c:	6a 1b                	push   $0x1b
  jmp alltraps
8010729e:	e9 24 fa ff ff       	jmp    80106cc7 <alltraps>

801072a3 <vector28>:
.globl vector28
vector28:
  pushl $0
801072a3:	6a 00                	push   $0x0
  pushl $28
801072a5:	6a 1c                	push   $0x1c
  jmp alltraps
801072a7:	e9 1b fa ff ff       	jmp    80106cc7 <alltraps>

801072ac <vector29>:
.globl vector29
vector29:
  pushl $0
801072ac:	6a 00                	push   $0x0
  pushl $29
801072ae:	6a 1d                	push   $0x1d
  jmp alltraps
801072b0:	e9 12 fa ff ff       	jmp    80106cc7 <alltraps>

801072b5 <vector30>:
.globl vector30
vector30:
  pushl $0
801072b5:	6a 00                	push   $0x0
  pushl $30
801072b7:	6a 1e                	push   $0x1e
  jmp alltraps
801072b9:	e9 09 fa ff ff       	jmp    80106cc7 <alltraps>

801072be <vector31>:
.globl vector31
vector31:
  pushl $0
801072be:	6a 00                	push   $0x0
  pushl $31
801072c0:	6a 1f                	push   $0x1f
  jmp alltraps
801072c2:	e9 00 fa ff ff       	jmp    80106cc7 <alltraps>

801072c7 <vector32>:
.globl vector32
vector32:
  pushl $0
801072c7:	6a 00                	push   $0x0
  pushl $32
801072c9:	6a 20                	push   $0x20
  jmp alltraps
801072cb:	e9 f7 f9 ff ff       	jmp    80106cc7 <alltraps>

801072d0 <vector33>:
.globl vector33
vector33:
  pushl $0
801072d0:	6a 00                	push   $0x0
  pushl $33
801072d2:	6a 21                	push   $0x21
  jmp alltraps
801072d4:	e9 ee f9 ff ff       	jmp    80106cc7 <alltraps>

801072d9 <vector34>:
.globl vector34
vector34:
  pushl $0
801072d9:	6a 00                	push   $0x0
  pushl $34
801072db:	6a 22                	push   $0x22
  jmp alltraps
801072dd:	e9 e5 f9 ff ff       	jmp    80106cc7 <alltraps>

801072e2 <vector35>:
.globl vector35
vector35:
  pushl $0
801072e2:	6a 00                	push   $0x0
  pushl $35
801072e4:	6a 23                	push   $0x23
  jmp alltraps
801072e6:	e9 dc f9 ff ff       	jmp    80106cc7 <alltraps>

801072eb <vector36>:
.globl vector36
vector36:
  pushl $0
801072eb:	6a 00                	push   $0x0
  pushl $36
801072ed:	6a 24                	push   $0x24
  jmp alltraps
801072ef:	e9 d3 f9 ff ff       	jmp    80106cc7 <alltraps>

801072f4 <vector37>:
.globl vector37
vector37:
  pushl $0
801072f4:	6a 00                	push   $0x0
  pushl $37
801072f6:	6a 25                	push   $0x25
  jmp alltraps
801072f8:	e9 ca f9 ff ff       	jmp    80106cc7 <alltraps>

801072fd <vector38>:
.globl vector38
vector38:
  pushl $0
801072fd:	6a 00                	push   $0x0
  pushl $38
801072ff:	6a 26                	push   $0x26
  jmp alltraps
80107301:	e9 c1 f9 ff ff       	jmp    80106cc7 <alltraps>

80107306 <vector39>:
.globl vector39
vector39:
  pushl $0
80107306:	6a 00                	push   $0x0
  pushl $39
80107308:	6a 27                	push   $0x27
  jmp alltraps
8010730a:	e9 b8 f9 ff ff       	jmp    80106cc7 <alltraps>

8010730f <vector40>:
.globl vector40
vector40:
  pushl $0
8010730f:	6a 00                	push   $0x0
  pushl $40
80107311:	6a 28                	push   $0x28
  jmp alltraps
80107313:	e9 af f9 ff ff       	jmp    80106cc7 <alltraps>

80107318 <vector41>:
.globl vector41
vector41:
  pushl $0
80107318:	6a 00                	push   $0x0
  pushl $41
8010731a:	6a 29                	push   $0x29
  jmp alltraps
8010731c:	e9 a6 f9 ff ff       	jmp    80106cc7 <alltraps>

80107321 <vector42>:
.globl vector42
vector42:
  pushl $0
80107321:	6a 00                	push   $0x0
  pushl $42
80107323:	6a 2a                	push   $0x2a
  jmp alltraps
80107325:	e9 9d f9 ff ff       	jmp    80106cc7 <alltraps>

8010732a <vector43>:
.globl vector43
vector43:
  pushl $0
8010732a:	6a 00                	push   $0x0
  pushl $43
8010732c:	6a 2b                	push   $0x2b
  jmp alltraps
8010732e:	e9 94 f9 ff ff       	jmp    80106cc7 <alltraps>

80107333 <vector44>:
.globl vector44
vector44:
  pushl $0
80107333:	6a 00                	push   $0x0
  pushl $44
80107335:	6a 2c                	push   $0x2c
  jmp alltraps
80107337:	e9 8b f9 ff ff       	jmp    80106cc7 <alltraps>

8010733c <vector45>:
.globl vector45
vector45:
  pushl $0
8010733c:	6a 00                	push   $0x0
  pushl $45
8010733e:	6a 2d                	push   $0x2d
  jmp alltraps
80107340:	e9 82 f9 ff ff       	jmp    80106cc7 <alltraps>

80107345 <vector46>:
.globl vector46
vector46:
  pushl $0
80107345:	6a 00                	push   $0x0
  pushl $46
80107347:	6a 2e                	push   $0x2e
  jmp alltraps
80107349:	e9 79 f9 ff ff       	jmp    80106cc7 <alltraps>

8010734e <vector47>:
.globl vector47
vector47:
  pushl $0
8010734e:	6a 00                	push   $0x0
  pushl $47
80107350:	6a 2f                	push   $0x2f
  jmp alltraps
80107352:	e9 70 f9 ff ff       	jmp    80106cc7 <alltraps>

80107357 <vector48>:
.globl vector48
vector48:
  pushl $0
80107357:	6a 00                	push   $0x0
  pushl $48
80107359:	6a 30                	push   $0x30
  jmp alltraps
8010735b:	e9 67 f9 ff ff       	jmp    80106cc7 <alltraps>

80107360 <vector49>:
.globl vector49
vector49:
  pushl $0
80107360:	6a 00                	push   $0x0
  pushl $49
80107362:	6a 31                	push   $0x31
  jmp alltraps
80107364:	e9 5e f9 ff ff       	jmp    80106cc7 <alltraps>

80107369 <vector50>:
.globl vector50
vector50:
  pushl $0
80107369:	6a 00                	push   $0x0
  pushl $50
8010736b:	6a 32                	push   $0x32
  jmp alltraps
8010736d:	e9 55 f9 ff ff       	jmp    80106cc7 <alltraps>

80107372 <vector51>:
.globl vector51
vector51:
  pushl $0
80107372:	6a 00                	push   $0x0
  pushl $51
80107374:	6a 33                	push   $0x33
  jmp alltraps
80107376:	e9 4c f9 ff ff       	jmp    80106cc7 <alltraps>

8010737b <vector52>:
.globl vector52
vector52:
  pushl $0
8010737b:	6a 00                	push   $0x0
  pushl $52
8010737d:	6a 34                	push   $0x34
  jmp alltraps
8010737f:	e9 43 f9 ff ff       	jmp    80106cc7 <alltraps>

80107384 <vector53>:
.globl vector53
vector53:
  pushl $0
80107384:	6a 00                	push   $0x0
  pushl $53
80107386:	6a 35                	push   $0x35
  jmp alltraps
80107388:	e9 3a f9 ff ff       	jmp    80106cc7 <alltraps>

8010738d <vector54>:
.globl vector54
vector54:
  pushl $0
8010738d:	6a 00                	push   $0x0
  pushl $54
8010738f:	6a 36                	push   $0x36
  jmp alltraps
80107391:	e9 31 f9 ff ff       	jmp    80106cc7 <alltraps>

80107396 <vector55>:
.globl vector55
vector55:
  pushl $0
80107396:	6a 00                	push   $0x0
  pushl $55
80107398:	6a 37                	push   $0x37
  jmp alltraps
8010739a:	e9 28 f9 ff ff       	jmp    80106cc7 <alltraps>

8010739f <vector56>:
.globl vector56
vector56:
  pushl $0
8010739f:	6a 00                	push   $0x0
  pushl $56
801073a1:	6a 38                	push   $0x38
  jmp alltraps
801073a3:	e9 1f f9 ff ff       	jmp    80106cc7 <alltraps>

801073a8 <vector57>:
.globl vector57
vector57:
  pushl $0
801073a8:	6a 00                	push   $0x0
  pushl $57
801073aa:	6a 39                	push   $0x39
  jmp alltraps
801073ac:	e9 16 f9 ff ff       	jmp    80106cc7 <alltraps>

801073b1 <vector58>:
.globl vector58
vector58:
  pushl $0
801073b1:	6a 00                	push   $0x0
  pushl $58
801073b3:	6a 3a                	push   $0x3a
  jmp alltraps
801073b5:	e9 0d f9 ff ff       	jmp    80106cc7 <alltraps>

801073ba <vector59>:
.globl vector59
vector59:
  pushl $0
801073ba:	6a 00                	push   $0x0
  pushl $59
801073bc:	6a 3b                	push   $0x3b
  jmp alltraps
801073be:	e9 04 f9 ff ff       	jmp    80106cc7 <alltraps>

801073c3 <vector60>:
.globl vector60
vector60:
  pushl $0
801073c3:	6a 00                	push   $0x0
  pushl $60
801073c5:	6a 3c                	push   $0x3c
  jmp alltraps
801073c7:	e9 fb f8 ff ff       	jmp    80106cc7 <alltraps>

801073cc <vector61>:
.globl vector61
vector61:
  pushl $0
801073cc:	6a 00                	push   $0x0
  pushl $61
801073ce:	6a 3d                	push   $0x3d
  jmp alltraps
801073d0:	e9 f2 f8 ff ff       	jmp    80106cc7 <alltraps>

801073d5 <vector62>:
.globl vector62
vector62:
  pushl $0
801073d5:	6a 00                	push   $0x0
  pushl $62
801073d7:	6a 3e                	push   $0x3e
  jmp alltraps
801073d9:	e9 e9 f8 ff ff       	jmp    80106cc7 <alltraps>

801073de <vector63>:
.globl vector63
vector63:
  pushl $0
801073de:	6a 00                	push   $0x0
  pushl $63
801073e0:	6a 3f                	push   $0x3f
  jmp alltraps
801073e2:	e9 e0 f8 ff ff       	jmp    80106cc7 <alltraps>

801073e7 <vector64>:
.globl vector64
vector64:
  pushl $0
801073e7:	6a 00                	push   $0x0
  pushl $64
801073e9:	6a 40                	push   $0x40
  jmp alltraps
801073eb:	e9 d7 f8 ff ff       	jmp    80106cc7 <alltraps>

801073f0 <vector65>:
.globl vector65
vector65:
  pushl $0
801073f0:	6a 00                	push   $0x0
  pushl $65
801073f2:	6a 41                	push   $0x41
  jmp alltraps
801073f4:	e9 ce f8 ff ff       	jmp    80106cc7 <alltraps>

801073f9 <vector66>:
.globl vector66
vector66:
  pushl $0
801073f9:	6a 00                	push   $0x0
  pushl $66
801073fb:	6a 42                	push   $0x42
  jmp alltraps
801073fd:	e9 c5 f8 ff ff       	jmp    80106cc7 <alltraps>

80107402 <vector67>:
.globl vector67
vector67:
  pushl $0
80107402:	6a 00                	push   $0x0
  pushl $67
80107404:	6a 43                	push   $0x43
  jmp alltraps
80107406:	e9 bc f8 ff ff       	jmp    80106cc7 <alltraps>

8010740b <vector68>:
.globl vector68
vector68:
  pushl $0
8010740b:	6a 00                	push   $0x0
  pushl $68
8010740d:	6a 44                	push   $0x44
  jmp alltraps
8010740f:	e9 b3 f8 ff ff       	jmp    80106cc7 <alltraps>

80107414 <vector69>:
.globl vector69
vector69:
  pushl $0
80107414:	6a 00                	push   $0x0
  pushl $69
80107416:	6a 45                	push   $0x45
  jmp alltraps
80107418:	e9 aa f8 ff ff       	jmp    80106cc7 <alltraps>

8010741d <vector70>:
.globl vector70
vector70:
  pushl $0
8010741d:	6a 00                	push   $0x0
  pushl $70
8010741f:	6a 46                	push   $0x46
  jmp alltraps
80107421:	e9 a1 f8 ff ff       	jmp    80106cc7 <alltraps>

80107426 <vector71>:
.globl vector71
vector71:
  pushl $0
80107426:	6a 00                	push   $0x0
  pushl $71
80107428:	6a 47                	push   $0x47
  jmp alltraps
8010742a:	e9 98 f8 ff ff       	jmp    80106cc7 <alltraps>

8010742f <vector72>:
.globl vector72
vector72:
  pushl $0
8010742f:	6a 00                	push   $0x0
  pushl $72
80107431:	6a 48                	push   $0x48
  jmp alltraps
80107433:	e9 8f f8 ff ff       	jmp    80106cc7 <alltraps>

80107438 <vector73>:
.globl vector73
vector73:
  pushl $0
80107438:	6a 00                	push   $0x0
  pushl $73
8010743a:	6a 49                	push   $0x49
  jmp alltraps
8010743c:	e9 86 f8 ff ff       	jmp    80106cc7 <alltraps>

80107441 <vector74>:
.globl vector74
vector74:
  pushl $0
80107441:	6a 00                	push   $0x0
  pushl $74
80107443:	6a 4a                	push   $0x4a
  jmp alltraps
80107445:	e9 7d f8 ff ff       	jmp    80106cc7 <alltraps>

8010744a <vector75>:
.globl vector75
vector75:
  pushl $0
8010744a:	6a 00                	push   $0x0
  pushl $75
8010744c:	6a 4b                	push   $0x4b
  jmp alltraps
8010744e:	e9 74 f8 ff ff       	jmp    80106cc7 <alltraps>

80107453 <vector76>:
.globl vector76
vector76:
  pushl $0
80107453:	6a 00                	push   $0x0
  pushl $76
80107455:	6a 4c                	push   $0x4c
  jmp alltraps
80107457:	e9 6b f8 ff ff       	jmp    80106cc7 <alltraps>

8010745c <vector77>:
.globl vector77
vector77:
  pushl $0
8010745c:	6a 00                	push   $0x0
  pushl $77
8010745e:	6a 4d                	push   $0x4d
  jmp alltraps
80107460:	e9 62 f8 ff ff       	jmp    80106cc7 <alltraps>

80107465 <vector78>:
.globl vector78
vector78:
  pushl $0
80107465:	6a 00                	push   $0x0
  pushl $78
80107467:	6a 4e                	push   $0x4e
  jmp alltraps
80107469:	e9 59 f8 ff ff       	jmp    80106cc7 <alltraps>

8010746e <vector79>:
.globl vector79
vector79:
  pushl $0
8010746e:	6a 00                	push   $0x0
  pushl $79
80107470:	6a 4f                	push   $0x4f
  jmp alltraps
80107472:	e9 50 f8 ff ff       	jmp    80106cc7 <alltraps>

80107477 <vector80>:
.globl vector80
vector80:
  pushl $0
80107477:	6a 00                	push   $0x0
  pushl $80
80107479:	6a 50                	push   $0x50
  jmp alltraps
8010747b:	e9 47 f8 ff ff       	jmp    80106cc7 <alltraps>

80107480 <vector81>:
.globl vector81
vector81:
  pushl $0
80107480:	6a 00                	push   $0x0
  pushl $81
80107482:	6a 51                	push   $0x51
  jmp alltraps
80107484:	e9 3e f8 ff ff       	jmp    80106cc7 <alltraps>

80107489 <vector82>:
.globl vector82
vector82:
  pushl $0
80107489:	6a 00                	push   $0x0
  pushl $82
8010748b:	6a 52                	push   $0x52
  jmp alltraps
8010748d:	e9 35 f8 ff ff       	jmp    80106cc7 <alltraps>

80107492 <vector83>:
.globl vector83
vector83:
  pushl $0
80107492:	6a 00                	push   $0x0
  pushl $83
80107494:	6a 53                	push   $0x53
  jmp alltraps
80107496:	e9 2c f8 ff ff       	jmp    80106cc7 <alltraps>

8010749b <vector84>:
.globl vector84
vector84:
  pushl $0
8010749b:	6a 00                	push   $0x0
  pushl $84
8010749d:	6a 54                	push   $0x54
  jmp alltraps
8010749f:	e9 23 f8 ff ff       	jmp    80106cc7 <alltraps>

801074a4 <vector85>:
.globl vector85
vector85:
  pushl $0
801074a4:	6a 00                	push   $0x0
  pushl $85
801074a6:	6a 55                	push   $0x55
  jmp alltraps
801074a8:	e9 1a f8 ff ff       	jmp    80106cc7 <alltraps>

801074ad <vector86>:
.globl vector86
vector86:
  pushl $0
801074ad:	6a 00                	push   $0x0
  pushl $86
801074af:	6a 56                	push   $0x56
  jmp alltraps
801074b1:	e9 11 f8 ff ff       	jmp    80106cc7 <alltraps>

801074b6 <vector87>:
.globl vector87
vector87:
  pushl $0
801074b6:	6a 00                	push   $0x0
  pushl $87
801074b8:	6a 57                	push   $0x57
  jmp alltraps
801074ba:	e9 08 f8 ff ff       	jmp    80106cc7 <alltraps>

801074bf <vector88>:
.globl vector88
vector88:
  pushl $0
801074bf:	6a 00                	push   $0x0
  pushl $88
801074c1:	6a 58                	push   $0x58
  jmp alltraps
801074c3:	e9 ff f7 ff ff       	jmp    80106cc7 <alltraps>

801074c8 <vector89>:
.globl vector89
vector89:
  pushl $0
801074c8:	6a 00                	push   $0x0
  pushl $89
801074ca:	6a 59                	push   $0x59
  jmp alltraps
801074cc:	e9 f6 f7 ff ff       	jmp    80106cc7 <alltraps>

801074d1 <vector90>:
.globl vector90
vector90:
  pushl $0
801074d1:	6a 00                	push   $0x0
  pushl $90
801074d3:	6a 5a                	push   $0x5a
  jmp alltraps
801074d5:	e9 ed f7 ff ff       	jmp    80106cc7 <alltraps>

801074da <vector91>:
.globl vector91
vector91:
  pushl $0
801074da:	6a 00                	push   $0x0
  pushl $91
801074dc:	6a 5b                	push   $0x5b
  jmp alltraps
801074de:	e9 e4 f7 ff ff       	jmp    80106cc7 <alltraps>

801074e3 <vector92>:
.globl vector92
vector92:
  pushl $0
801074e3:	6a 00                	push   $0x0
  pushl $92
801074e5:	6a 5c                	push   $0x5c
  jmp alltraps
801074e7:	e9 db f7 ff ff       	jmp    80106cc7 <alltraps>

801074ec <vector93>:
.globl vector93
vector93:
  pushl $0
801074ec:	6a 00                	push   $0x0
  pushl $93
801074ee:	6a 5d                	push   $0x5d
  jmp alltraps
801074f0:	e9 d2 f7 ff ff       	jmp    80106cc7 <alltraps>

801074f5 <vector94>:
.globl vector94
vector94:
  pushl $0
801074f5:	6a 00                	push   $0x0
  pushl $94
801074f7:	6a 5e                	push   $0x5e
  jmp alltraps
801074f9:	e9 c9 f7 ff ff       	jmp    80106cc7 <alltraps>

801074fe <vector95>:
.globl vector95
vector95:
  pushl $0
801074fe:	6a 00                	push   $0x0
  pushl $95
80107500:	6a 5f                	push   $0x5f
  jmp alltraps
80107502:	e9 c0 f7 ff ff       	jmp    80106cc7 <alltraps>

80107507 <vector96>:
.globl vector96
vector96:
  pushl $0
80107507:	6a 00                	push   $0x0
  pushl $96
80107509:	6a 60                	push   $0x60
  jmp alltraps
8010750b:	e9 b7 f7 ff ff       	jmp    80106cc7 <alltraps>

80107510 <vector97>:
.globl vector97
vector97:
  pushl $0
80107510:	6a 00                	push   $0x0
  pushl $97
80107512:	6a 61                	push   $0x61
  jmp alltraps
80107514:	e9 ae f7 ff ff       	jmp    80106cc7 <alltraps>

80107519 <vector98>:
.globl vector98
vector98:
  pushl $0
80107519:	6a 00                	push   $0x0
  pushl $98
8010751b:	6a 62                	push   $0x62
  jmp alltraps
8010751d:	e9 a5 f7 ff ff       	jmp    80106cc7 <alltraps>

80107522 <vector99>:
.globl vector99
vector99:
  pushl $0
80107522:	6a 00                	push   $0x0
  pushl $99
80107524:	6a 63                	push   $0x63
  jmp alltraps
80107526:	e9 9c f7 ff ff       	jmp    80106cc7 <alltraps>

8010752b <vector100>:
.globl vector100
vector100:
  pushl $0
8010752b:	6a 00                	push   $0x0
  pushl $100
8010752d:	6a 64                	push   $0x64
  jmp alltraps
8010752f:	e9 93 f7 ff ff       	jmp    80106cc7 <alltraps>

80107534 <vector101>:
.globl vector101
vector101:
  pushl $0
80107534:	6a 00                	push   $0x0
  pushl $101
80107536:	6a 65                	push   $0x65
  jmp alltraps
80107538:	e9 8a f7 ff ff       	jmp    80106cc7 <alltraps>

8010753d <vector102>:
.globl vector102
vector102:
  pushl $0
8010753d:	6a 00                	push   $0x0
  pushl $102
8010753f:	6a 66                	push   $0x66
  jmp alltraps
80107541:	e9 81 f7 ff ff       	jmp    80106cc7 <alltraps>

80107546 <vector103>:
.globl vector103
vector103:
  pushl $0
80107546:	6a 00                	push   $0x0
  pushl $103
80107548:	6a 67                	push   $0x67
  jmp alltraps
8010754a:	e9 78 f7 ff ff       	jmp    80106cc7 <alltraps>

8010754f <vector104>:
.globl vector104
vector104:
  pushl $0
8010754f:	6a 00                	push   $0x0
  pushl $104
80107551:	6a 68                	push   $0x68
  jmp alltraps
80107553:	e9 6f f7 ff ff       	jmp    80106cc7 <alltraps>

80107558 <vector105>:
.globl vector105
vector105:
  pushl $0
80107558:	6a 00                	push   $0x0
  pushl $105
8010755a:	6a 69                	push   $0x69
  jmp alltraps
8010755c:	e9 66 f7 ff ff       	jmp    80106cc7 <alltraps>

80107561 <vector106>:
.globl vector106
vector106:
  pushl $0
80107561:	6a 00                	push   $0x0
  pushl $106
80107563:	6a 6a                	push   $0x6a
  jmp alltraps
80107565:	e9 5d f7 ff ff       	jmp    80106cc7 <alltraps>

8010756a <vector107>:
.globl vector107
vector107:
  pushl $0
8010756a:	6a 00                	push   $0x0
  pushl $107
8010756c:	6a 6b                	push   $0x6b
  jmp alltraps
8010756e:	e9 54 f7 ff ff       	jmp    80106cc7 <alltraps>

80107573 <vector108>:
.globl vector108
vector108:
  pushl $0
80107573:	6a 00                	push   $0x0
  pushl $108
80107575:	6a 6c                	push   $0x6c
  jmp alltraps
80107577:	e9 4b f7 ff ff       	jmp    80106cc7 <alltraps>

8010757c <vector109>:
.globl vector109
vector109:
  pushl $0
8010757c:	6a 00                	push   $0x0
  pushl $109
8010757e:	6a 6d                	push   $0x6d
  jmp alltraps
80107580:	e9 42 f7 ff ff       	jmp    80106cc7 <alltraps>

80107585 <vector110>:
.globl vector110
vector110:
  pushl $0
80107585:	6a 00                	push   $0x0
  pushl $110
80107587:	6a 6e                	push   $0x6e
  jmp alltraps
80107589:	e9 39 f7 ff ff       	jmp    80106cc7 <alltraps>

8010758e <vector111>:
.globl vector111
vector111:
  pushl $0
8010758e:	6a 00                	push   $0x0
  pushl $111
80107590:	6a 6f                	push   $0x6f
  jmp alltraps
80107592:	e9 30 f7 ff ff       	jmp    80106cc7 <alltraps>

80107597 <vector112>:
.globl vector112
vector112:
  pushl $0
80107597:	6a 00                	push   $0x0
  pushl $112
80107599:	6a 70                	push   $0x70
  jmp alltraps
8010759b:	e9 27 f7 ff ff       	jmp    80106cc7 <alltraps>

801075a0 <vector113>:
.globl vector113
vector113:
  pushl $0
801075a0:	6a 00                	push   $0x0
  pushl $113
801075a2:	6a 71                	push   $0x71
  jmp alltraps
801075a4:	e9 1e f7 ff ff       	jmp    80106cc7 <alltraps>

801075a9 <vector114>:
.globl vector114
vector114:
  pushl $0
801075a9:	6a 00                	push   $0x0
  pushl $114
801075ab:	6a 72                	push   $0x72
  jmp alltraps
801075ad:	e9 15 f7 ff ff       	jmp    80106cc7 <alltraps>

801075b2 <vector115>:
.globl vector115
vector115:
  pushl $0
801075b2:	6a 00                	push   $0x0
  pushl $115
801075b4:	6a 73                	push   $0x73
  jmp alltraps
801075b6:	e9 0c f7 ff ff       	jmp    80106cc7 <alltraps>

801075bb <vector116>:
.globl vector116
vector116:
  pushl $0
801075bb:	6a 00                	push   $0x0
  pushl $116
801075bd:	6a 74                	push   $0x74
  jmp alltraps
801075bf:	e9 03 f7 ff ff       	jmp    80106cc7 <alltraps>

801075c4 <vector117>:
.globl vector117
vector117:
  pushl $0
801075c4:	6a 00                	push   $0x0
  pushl $117
801075c6:	6a 75                	push   $0x75
  jmp alltraps
801075c8:	e9 fa f6 ff ff       	jmp    80106cc7 <alltraps>

801075cd <vector118>:
.globl vector118
vector118:
  pushl $0
801075cd:	6a 00                	push   $0x0
  pushl $118
801075cf:	6a 76                	push   $0x76
  jmp alltraps
801075d1:	e9 f1 f6 ff ff       	jmp    80106cc7 <alltraps>

801075d6 <vector119>:
.globl vector119
vector119:
  pushl $0
801075d6:	6a 00                	push   $0x0
  pushl $119
801075d8:	6a 77                	push   $0x77
  jmp alltraps
801075da:	e9 e8 f6 ff ff       	jmp    80106cc7 <alltraps>

801075df <vector120>:
.globl vector120
vector120:
  pushl $0
801075df:	6a 00                	push   $0x0
  pushl $120
801075e1:	6a 78                	push   $0x78
  jmp alltraps
801075e3:	e9 df f6 ff ff       	jmp    80106cc7 <alltraps>

801075e8 <vector121>:
.globl vector121
vector121:
  pushl $0
801075e8:	6a 00                	push   $0x0
  pushl $121
801075ea:	6a 79                	push   $0x79
  jmp alltraps
801075ec:	e9 d6 f6 ff ff       	jmp    80106cc7 <alltraps>

801075f1 <vector122>:
.globl vector122
vector122:
  pushl $0
801075f1:	6a 00                	push   $0x0
  pushl $122
801075f3:	6a 7a                	push   $0x7a
  jmp alltraps
801075f5:	e9 cd f6 ff ff       	jmp    80106cc7 <alltraps>

801075fa <vector123>:
.globl vector123
vector123:
  pushl $0
801075fa:	6a 00                	push   $0x0
  pushl $123
801075fc:	6a 7b                	push   $0x7b
  jmp alltraps
801075fe:	e9 c4 f6 ff ff       	jmp    80106cc7 <alltraps>

80107603 <vector124>:
.globl vector124
vector124:
  pushl $0
80107603:	6a 00                	push   $0x0
  pushl $124
80107605:	6a 7c                	push   $0x7c
  jmp alltraps
80107607:	e9 bb f6 ff ff       	jmp    80106cc7 <alltraps>

8010760c <vector125>:
.globl vector125
vector125:
  pushl $0
8010760c:	6a 00                	push   $0x0
  pushl $125
8010760e:	6a 7d                	push   $0x7d
  jmp alltraps
80107610:	e9 b2 f6 ff ff       	jmp    80106cc7 <alltraps>

80107615 <vector126>:
.globl vector126
vector126:
  pushl $0
80107615:	6a 00                	push   $0x0
  pushl $126
80107617:	6a 7e                	push   $0x7e
  jmp alltraps
80107619:	e9 a9 f6 ff ff       	jmp    80106cc7 <alltraps>

8010761e <vector127>:
.globl vector127
vector127:
  pushl $0
8010761e:	6a 00                	push   $0x0
  pushl $127
80107620:	6a 7f                	push   $0x7f
  jmp alltraps
80107622:	e9 a0 f6 ff ff       	jmp    80106cc7 <alltraps>

80107627 <vector128>:
.globl vector128
vector128:
  pushl $0
80107627:	6a 00                	push   $0x0
  pushl $128
80107629:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010762e:	e9 94 f6 ff ff       	jmp    80106cc7 <alltraps>

80107633 <vector129>:
.globl vector129
vector129:
  pushl $0
80107633:	6a 00                	push   $0x0
  pushl $129
80107635:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010763a:	e9 88 f6 ff ff       	jmp    80106cc7 <alltraps>

8010763f <vector130>:
.globl vector130
vector130:
  pushl $0
8010763f:	6a 00                	push   $0x0
  pushl $130
80107641:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80107646:	e9 7c f6 ff ff       	jmp    80106cc7 <alltraps>

8010764b <vector131>:
.globl vector131
vector131:
  pushl $0
8010764b:	6a 00                	push   $0x0
  pushl $131
8010764d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80107652:	e9 70 f6 ff ff       	jmp    80106cc7 <alltraps>

80107657 <vector132>:
.globl vector132
vector132:
  pushl $0
80107657:	6a 00                	push   $0x0
  pushl $132
80107659:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010765e:	e9 64 f6 ff ff       	jmp    80106cc7 <alltraps>

80107663 <vector133>:
.globl vector133
vector133:
  pushl $0
80107663:	6a 00                	push   $0x0
  pushl $133
80107665:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010766a:	e9 58 f6 ff ff       	jmp    80106cc7 <alltraps>

8010766f <vector134>:
.globl vector134
vector134:
  pushl $0
8010766f:	6a 00                	push   $0x0
  pushl $134
80107671:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80107676:	e9 4c f6 ff ff       	jmp    80106cc7 <alltraps>

8010767b <vector135>:
.globl vector135
vector135:
  pushl $0
8010767b:	6a 00                	push   $0x0
  pushl $135
8010767d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80107682:	e9 40 f6 ff ff       	jmp    80106cc7 <alltraps>

80107687 <vector136>:
.globl vector136
vector136:
  pushl $0
80107687:	6a 00                	push   $0x0
  pushl $136
80107689:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010768e:	e9 34 f6 ff ff       	jmp    80106cc7 <alltraps>

80107693 <vector137>:
.globl vector137
vector137:
  pushl $0
80107693:	6a 00                	push   $0x0
  pushl $137
80107695:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010769a:	e9 28 f6 ff ff       	jmp    80106cc7 <alltraps>

8010769f <vector138>:
.globl vector138
vector138:
  pushl $0
8010769f:	6a 00                	push   $0x0
  pushl $138
801076a1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801076a6:	e9 1c f6 ff ff       	jmp    80106cc7 <alltraps>

801076ab <vector139>:
.globl vector139
vector139:
  pushl $0
801076ab:	6a 00                	push   $0x0
  pushl $139
801076ad:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801076b2:	e9 10 f6 ff ff       	jmp    80106cc7 <alltraps>

801076b7 <vector140>:
.globl vector140
vector140:
  pushl $0
801076b7:	6a 00                	push   $0x0
  pushl $140
801076b9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801076be:	e9 04 f6 ff ff       	jmp    80106cc7 <alltraps>

801076c3 <vector141>:
.globl vector141
vector141:
  pushl $0
801076c3:	6a 00                	push   $0x0
  pushl $141
801076c5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801076ca:	e9 f8 f5 ff ff       	jmp    80106cc7 <alltraps>

801076cf <vector142>:
.globl vector142
vector142:
  pushl $0
801076cf:	6a 00                	push   $0x0
  pushl $142
801076d1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801076d6:	e9 ec f5 ff ff       	jmp    80106cc7 <alltraps>

801076db <vector143>:
.globl vector143
vector143:
  pushl $0
801076db:	6a 00                	push   $0x0
  pushl $143
801076dd:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801076e2:	e9 e0 f5 ff ff       	jmp    80106cc7 <alltraps>

801076e7 <vector144>:
.globl vector144
vector144:
  pushl $0
801076e7:	6a 00                	push   $0x0
  pushl $144
801076e9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801076ee:	e9 d4 f5 ff ff       	jmp    80106cc7 <alltraps>

801076f3 <vector145>:
.globl vector145
vector145:
  pushl $0
801076f3:	6a 00                	push   $0x0
  pushl $145
801076f5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801076fa:	e9 c8 f5 ff ff       	jmp    80106cc7 <alltraps>

801076ff <vector146>:
.globl vector146
vector146:
  pushl $0
801076ff:	6a 00                	push   $0x0
  pushl $146
80107701:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80107706:	e9 bc f5 ff ff       	jmp    80106cc7 <alltraps>

8010770b <vector147>:
.globl vector147
vector147:
  pushl $0
8010770b:	6a 00                	push   $0x0
  pushl $147
8010770d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80107712:	e9 b0 f5 ff ff       	jmp    80106cc7 <alltraps>

80107717 <vector148>:
.globl vector148
vector148:
  pushl $0
80107717:	6a 00                	push   $0x0
  pushl $148
80107719:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010771e:	e9 a4 f5 ff ff       	jmp    80106cc7 <alltraps>

80107723 <vector149>:
.globl vector149
vector149:
  pushl $0
80107723:	6a 00                	push   $0x0
  pushl $149
80107725:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010772a:	e9 98 f5 ff ff       	jmp    80106cc7 <alltraps>

8010772f <vector150>:
.globl vector150
vector150:
  pushl $0
8010772f:	6a 00                	push   $0x0
  pushl $150
80107731:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80107736:	e9 8c f5 ff ff       	jmp    80106cc7 <alltraps>

8010773b <vector151>:
.globl vector151
vector151:
  pushl $0
8010773b:	6a 00                	push   $0x0
  pushl $151
8010773d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80107742:	e9 80 f5 ff ff       	jmp    80106cc7 <alltraps>

80107747 <vector152>:
.globl vector152
vector152:
  pushl $0
80107747:	6a 00                	push   $0x0
  pushl $152
80107749:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010774e:	e9 74 f5 ff ff       	jmp    80106cc7 <alltraps>

80107753 <vector153>:
.globl vector153
vector153:
  pushl $0
80107753:	6a 00                	push   $0x0
  pushl $153
80107755:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010775a:	e9 68 f5 ff ff       	jmp    80106cc7 <alltraps>

8010775f <vector154>:
.globl vector154
vector154:
  pushl $0
8010775f:	6a 00                	push   $0x0
  pushl $154
80107761:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80107766:	e9 5c f5 ff ff       	jmp    80106cc7 <alltraps>

8010776b <vector155>:
.globl vector155
vector155:
  pushl $0
8010776b:	6a 00                	push   $0x0
  pushl $155
8010776d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80107772:	e9 50 f5 ff ff       	jmp    80106cc7 <alltraps>

80107777 <vector156>:
.globl vector156
vector156:
  pushl $0
80107777:	6a 00                	push   $0x0
  pushl $156
80107779:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010777e:	e9 44 f5 ff ff       	jmp    80106cc7 <alltraps>

80107783 <vector157>:
.globl vector157
vector157:
  pushl $0
80107783:	6a 00                	push   $0x0
  pushl $157
80107785:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010778a:	e9 38 f5 ff ff       	jmp    80106cc7 <alltraps>

8010778f <vector158>:
.globl vector158
vector158:
  pushl $0
8010778f:	6a 00                	push   $0x0
  pushl $158
80107791:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80107796:	e9 2c f5 ff ff       	jmp    80106cc7 <alltraps>

8010779b <vector159>:
.globl vector159
vector159:
  pushl $0
8010779b:	6a 00                	push   $0x0
  pushl $159
8010779d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801077a2:	e9 20 f5 ff ff       	jmp    80106cc7 <alltraps>

801077a7 <vector160>:
.globl vector160
vector160:
  pushl $0
801077a7:	6a 00                	push   $0x0
  pushl $160
801077a9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801077ae:	e9 14 f5 ff ff       	jmp    80106cc7 <alltraps>

801077b3 <vector161>:
.globl vector161
vector161:
  pushl $0
801077b3:	6a 00                	push   $0x0
  pushl $161
801077b5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801077ba:	e9 08 f5 ff ff       	jmp    80106cc7 <alltraps>

801077bf <vector162>:
.globl vector162
vector162:
  pushl $0
801077bf:	6a 00                	push   $0x0
  pushl $162
801077c1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801077c6:	e9 fc f4 ff ff       	jmp    80106cc7 <alltraps>

801077cb <vector163>:
.globl vector163
vector163:
  pushl $0
801077cb:	6a 00                	push   $0x0
  pushl $163
801077cd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801077d2:	e9 f0 f4 ff ff       	jmp    80106cc7 <alltraps>

801077d7 <vector164>:
.globl vector164
vector164:
  pushl $0
801077d7:	6a 00                	push   $0x0
  pushl $164
801077d9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801077de:	e9 e4 f4 ff ff       	jmp    80106cc7 <alltraps>

801077e3 <vector165>:
.globl vector165
vector165:
  pushl $0
801077e3:	6a 00                	push   $0x0
  pushl $165
801077e5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801077ea:	e9 d8 f4 ff ff       	jmp    80106cc7 <alltraps>

801077ef <vector166>:
.globl vector166
vector166:
  pushl $0
801077ef:	6a 00                	push   $0x0
  pushl $166
801077f1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801077f6:	e9 cc f4 ff ff       	jmp    80106cc7 <alltraps>

801077fb <vector167>:
.globl vector167
vector167:
  pushl $0
801077fb:	6a 00                	push   $0x0
  pushl $167
801077fd:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80107802:	e9 c0 f4 ff ff       	jmp    80106cc7 <alltraps>

80107807 <vector168>:
.globl vector168
vector168:
  pushl $0
80107807:	6a 00                	push   $0x0
  pushl $168
80107809:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010780e:	e9 b4 f4 ff ff       	jmp    80106cc7 <alltraps>

80107813 <vector169>:
.globl vector169
vector169:
  pushl $0
80107813:	6a 00                	push   $0x0
  pushl $169
80107815:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010781a:	e9 a8 f4 ff ff       	jmp    80106cc7 <alltraps>

8010781f <vector170>:
.globl vector170
vector170:
  pushl $0
8010781f:	6a 00                	push   $0x0
  pushl $170
80107821:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80107826:	e9 9c f4 ff ff       	jmp    80106cc7 <alltraps>

8010782b <vector171>:
.globl vector171
vector171:
  pushl $0
8010782b:	6a 00                	push   $0x0
  pushl $171
8010782d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80107832:	e9 90 f4 ff ff       	jmp    80106cc7 <alltraps>

80107837 <vector172>:
.globl vector172
vector172:
  pushl $0
80107837:	6a 00                	push   $0x0
  pushl $172
80107839:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010783e:	e9 84 f4 ff ff       	jmp    80106cc7 <alltraps>

80107843 <vector173>:
.globl vector173
vector173:
  pushl $0
80107843:	6a 00                	push   $0x0
  pushl $173
80107845:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010784a:	e9 78 f4 ff ff       	jmp    80106cc7 <alltraps>

8010784f <vector174>:
.globl vector174
vector174:
  pushl $0
8010784f:	6a 00                	push   $0x0
  pushl $174
80107851:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80107856:	e9 6c f4 ff ff       	jmp    80106cc7 <alltraps>

8010785b <vector175>:
.globl vector175
vector175:
  pushl $0
8010785b:	6a 00                	push   $0x0
  pushl $175
8010785d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80107862:	e9 60 f4 ff ff       	jmp    80106cc7 <alltraps>

80107867 <vector176>:
.globl vector176
vector176:
  pushl $0
80107867:	6a 00                	push   $0x0
  pushl $176
80107869:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010786e:	e9 54 f4 ff ff       	jmp    80106cc7 <alltraps>

80107873 <vector177>:
.globl vector177
vector177:
  pushl $0
80107873:	6a 00                	push   $0x0
  pushl $177
80107875:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010787a:	e9 48 f4 ff ff       	jmp    80106cc7 <alltraps>

8010787f <vector178>:
.globl vector178
vector178:
  pushl $0
8010787f:	6a 00                	push   $0x0
  pushl $178
80107881:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80107886:	e9 3c f4 ff ff       	jmp    80106cc7 <alltraps>

8010788b <vector179>:
.globl vector179
vector179:
  pushl $0
8010788b:	6a 00                	push   $0x0
  pushl $179
8010788d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80107892:	e9 30 f4 ff ff       	jmp    80106cc7 <alltraps>

80107897 <vector180>:
.globl vector180
vector180:
  pushl $0
80107897:	6a 00                	push   $0x0
  pushl $180
80107899:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010789e:	e9 24 f4 ff ff       	jmp    80106cc7 <alltraps>

801078a3 <vector181>:
.globl vector181
vector181:
  pushl $0
801078a3:	6a 00                	push   $0x0
  pushl $181
801078a5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801078aa:	e9 18 f4 ff ff       	jmp    80106cc7 <alltraps>

801078af <vector182>:
.globl vector182
vector182:
  pushl $0
801078af:	6a 00                	push   $0x0
  pushl $182
801078b1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801078b6:	e9 0c f4 ff ff       	jmp    80106cc7 <alltraps>

801078bb <vector183>:
.globl vector183
vector183:
  pushl $0
801078bb:	6a 00                	push   $0x0
  pushl $183
801078bd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801078c2:	e9 00 f4 ff ff       	jmp    80106cc7 <alltraps>

801078c7 <vector184>:
.globl vector184
vector184:
  pushl $0
801078c7:	6a 00                	push   $0x0
  pushl $184
801078c9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801078ce:	e9 f4 f3 ff ff       	jmp    80106cc7 <alltraps>

801078d3 <vector185>:
.globl vector185
vector185:
  pushl $0
801078d3:	6a 00                	push   $0x0
  pushl $185
801078d5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801078da:	e9 e8 f3 ff ff       	jmp    80106cc7 <alltraps>

801078df <vector186>:
.globl vector186
vector186:
  pushl $0
801078df:	6a 00                	push   $0x0
  pushl $186
801078e1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801078e6:	e9 dc f3 ff ff       	jmp    80106cc7 <alltraps>

801078eb <vector187>:
.globl vector187
vector187:
  pushl $0
801078eb:	6a 00                	push   $0x0
  pushl $187
801078ed:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801078f2:	e9 d0 f3 ff ff       	jmp    80106cc7 <alltraps>

801078f7 <vector188>:
.globl vector188
vector188:
  pushl $0
801078f7:	6a 00                	push   $0x0
  pushl $188
801078f9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801078fe:	e9 c4 f3 ff ff       	jmp    80106cc7 <alltraps>

80107903 <vector189>:
.globl vector189
vector189:
  pushl $0
80107903:	6a 00                	push   $0x0
  pushl $189
80107905:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010790a:	e9 b8 f3 ff ff       	jmp    80106cc7 <alltraps>

8010790f <vector190>:
.globl vector190
vector190:
  pushl $0
8010790f:	6a 00                	push   $0x0
  pushl $190
80107911:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80107916:	e9 ac f3 ff ff       	jmp    80106cc7 <alltraps>

8010791b <vector191>:
.globl vector191
vector191:
  pushl $0
8010791b:	6a 00                	push   $0x0
  pushl $191
8010791d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80107922:	e9 a0 f3 ff ff       	jmp    80106cc7 <alltraps>

80107927 <vector192>:
.globl vector192
vector192:
  pushl $0
80107927:	6a 00                	push   $0x0
  pushl $192
80107929:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010792e:	e9 94 f3 ff ff       	jmp    80106cc7 <alltraps>

80107933 <vector193>:
.globl vector193
vector193:
  pushl $0
80107933:	6a 00                	push   $0x0
  pushl $193
80107935:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010793a:	e9 88 f3 ff ff       	jmp    80106cc7 <alltraps>

8010793f <vector194>:
.globl vector194
vector194:
  pushl $0
8010793f:	6a 00                	push   $0x0
  pushl $194
80107941:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80107946:	e9 7c f3 ff ff       	jmp    80106cc7 <alltraps>

8010794b <vector195>:
.globl vector195
vector195:
  pushl $0
8010794b:	6a 00                	push   $0x0
  pushl $195
8010794d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80107952:	e9 70 f3 ff ff       	jmp    80106cc7 <alltraps>

80107957 <vector196>:
.globl vector196
vector196:
  pushl $0
80107957:	6a 00                	push   $0x0
  pushl $196
80107959:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010795e:	e9 64 f3 ff ff       	jmp    80106cc7 <alltraps>

80107963 <vector197>:
.globl vector197
vector197:
  pushl $0
80107963:	6a 00                	push   $0x0
  pushl $197
80107965:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010796a:	e9 58 f3 ff ff       	jmp    80106cc7 <alltraps>

8010796f <vector198>:
.globl vector198
vector198:
  pushl $0
8010796f:	6a 00                	push   $0x0
  pushl $198
80107971:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80107976:	e9 4c f3 ff ff       	jmp    80106cc7 <alltraps>

8010797b <vector199>:
.globl vector199
vector199:
  pushl $0
8010797b:	6a 00                	push   $0x0
  pushl $199
8010797d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80107982:	e9 40 f3 ff ff       	jmp    80106cc7 <alltraps>

80107987 <vector200>:
.globl vector200
vector200:
  pushl $0
80107987:	6a 00                	push   $0x0
  pushl $200
80107989:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010798e:	e9 34 f3 ff ff       	jmp    80106cc7 <alltraps>

80107993 <vector201>:
.globl vector201
vector201:
  pushl $0
80107993:	6a 00                	push   $0x0
  pushl $201
80107995:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010799a:	e9 28 f3 ff ff       	jmp    80106cc7 <alltraps>

8010799f <vector202>:
.globl vector202
vector202:
  pushl $0
8010799f:	6a 00                	push   $0x0
  pushl $202
801079a1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801079a6:	e9 1c f3 ff ff       	jmp    80106cc7 <alltraps>

801079ab <vector203>:
.globl vector203
vector203:
  pushl $0
801079ab:	6a 00                	push   $0x0
  pushl $203
801079ad:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801079b2:	e9 10 f3 ff ff       	jmp    80106cc7 <alltraps>

801079b7 <vector204>:
.globl vector204
vector204:
  pushl $0
801079b7:	6a 00                	push   $0x0
  pushl $204
801079b9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801079be:	e9 04 f3 ff ff       	jmp    80106cc7 <alltraps>

801079c3 <vector205>:
.globl vector205
vector205:
  pushl $0
801079c3:	6a 00                	push   $0x0
  pushl $205
801079c5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801079ca:	e9 f8 f2 ff ff       	jmp    80106cc7 <alltraps>

801079cf <vector206>:
.globl vector206
vector206:
  pushl $0
801079cf:	6a 00                	push   $0x0
  pushl $206
801079d1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801079d6:	e9 ec f2 ff ff       	jmp    80106cc7 <alltraps>

801079db <vector207>:
.globl vector207
vector207:
  pushl $0
801079db:	6a 00                	push   $0x0
  pushl $207
801079dd:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801079e2:	e9 e0 f2 ff ff       	jmp    80106cc7 <alltraps>

801079e7 <vector208>:
.globl vector208
vector208:
  pushl $0
801079e7:	6a 00                	push   $0x0
  pushl $208
801079e9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801079ee:	e9 d4 f2 ff ff       	jmp    80106cc7 <alltraps>

801079f3 <vector209>:
.globl vector209
vector209:
  pushl $0
801079f3:	6a 00                	push   $0x0
  pushl $209
801079f5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801079fa:	e9 c8 f2 ff ff       	jmp    80106cc7 <alltraps>

801079ff <vector210>:
.globl vector210
vector210:
  pushl $0
801079ff:	6a 00                	push   $0x0
  pushl $210
80107a01:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80107a06:	e9 bc f2 ff ff       	jmp    80106cc7 <alltraps>

80107a0b <vector211>:
.globl vector211
vector211:
  pushl $0
80107a0b:	6a 00                	push   $0x0
  pushl $211
80107a0d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80107a12:	e9 b0 f2 ff ff       	jmp    80106cc7 <alltraps>

80107a17 <vector212>:
.globl vector212
vector212:
  pushl $0
80107a17:	6a 00                	push   $0x0
  pushl $212
80107a19:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80107a1e:	e9 a4 f2 ff ff       	jmp    80106cc7 <alltraps>

80107a23 <vector213>:
.globl vector213
vector213:
  pushl $0
80107a23:	6a 00                	push   $0x0
  pushl $213
80107a25:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80107a2a:	e9 98 f2 ff ff       	jmp    80106cc7 <alltraps>

80107a2f <vector214>:
.globl vector214
vector214:
  pushl $0
80107a2f:	6a 00                	push   $0x0
  pushl $214
80107a31:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80107a36:	e9 8c f2 ff ff       	jmp    80106cc7 <alltraps>

80107a3b <vector215>:
.globl vector215
vector215:
  pushl $0
80107a3b:	6a 00                	push   $0x0
  pushl $215
80107a3d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80107a42:	e9 80 f2 ff ff       	jmp    80106cc7 <alltraps>

80107a47 <vector216>:
.globl vector216
vector216:
  pushl $0
80107a47:	6a 00                	push   $0x0
  pushl $216
80107a49:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80107a4e:	e9 74 f2 ff ff       	jmp    80106cc7 <alltraps>

80107a53 <vector217>:
.globl vector217
vector217:
  pushl $0
80107a53:	6a 00                	push   $0x0
  pushl $217
80107a55:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80107a5a:	e9 68 f2 ff ff       	jmp    80106cc7 <alltraps>

80107a5f <vector218>:
.globl vector218
vector218:
  pushl $0
80107a5f:	6a 00                	push   $0x0
  pushl $218
80107a61:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80107a66:	e9 5c f2 ff ff       	jmp    80106cc7 <alltraps>

80107a6b <vector219>:
.globl vector219
vector219:
  pushl $0
80107a6b:	6a 00                	push   $0x0
  pushl $219
80107a6d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80107a72:	e9 50 f2 ff ff       	jmp    80106cc7 <alltraps>

80107a77 <vector220>:
.globl vector220
vector220:
  pushl $0
80107a77:	6a 00                	push   $0x0
  pushl $220
80107a79:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80107a7e:	e9 44 f2 ff ff       	jmp    80106cc7 <alltraps>

80107a83 <vector221>:
.globl vector221
vector221:
  pushl $0
80107a83:	6a 00                	push   $0x0
  pushl $221
80107a85:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80107a8a:	e9 38 f2 ff ff       	jmp    80106cc7 <alltraps>

80107a8f <vector222>:
.globl vector222
vector222:
  pushl $0
80107a8f:	6a 00                	push   $0x0
  pushl $222
80107a91:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80107a96:	e9 2c f2 ff ff       	jmp    80106cc7 <alltraps>

80107a9b <vector223>:
.globl vector223
vector223:
  pushl $0
80107a9b:	6a 00                	push   $0x0
  pushl $223
80107a9d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80107aa2:	e9 20 f2 ff ff       	jmp    80106cc7 <alltraps>

80107aa7 <vector224>:
.globl vector224
vector224:
  pushl $0
80107aa7:	6a 00                	push   $0x0
  pushl $224
80107aa9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80107aae:	e9 14 f2 ff ff       	jmp    80106cc7 <alltraps>

80107ab3 <vector225>:
.globl vector225
vector225:
  pushl $0
80107ab3:	6a 00                	push   $0x0
  pushl $225
80107ab5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80107aba:	e9 08 f2 ff ff       	jmp    80106cc7 <alltraps>

80107abf <vector226>:
.globl vector226
vector226:
  pushl $0
80107abf:	6a 00                	push   $0x0
  pushl $226
80107ac1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80107ac6:	e9 fc f1 ff ff       	jmp    80106cc7 <alltraps>

80107acb <vector227>:
.globl vector227
vector227:
  pushl $0
80107acb:	6a 00                	push   $0x0
  pushl $227
80107acd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80107ad2:	e9 f0 f1 ff ff       	jmp    80106cc7 <alltraps>

80107ad7 <vector228>:
.globl vector228
vector228:
  pushl $0
80107ad7:	6a 00                	push   $0x0
  pushl $228
80107ad9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80107ade:	e9 e4 f1 ff ff       	jmp    80106cc7 <alltraps>

80107ae3 <vector229>:
.globl vector229
vector229:
  pushl $0
80107ae3:	6a 00                	push   $0x0
  pushl $229
80107ae5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80107aea:	e9 d8 f1 ff ff       	jmp    80106cc7 <alltraps>

80107aef <vector230>:
.globl vector230
vector230:
  pushl $0
80107aef:	6a 00                	push   $0x0
  pushl $230
80107af1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80107af6:	e9 cc f1 ff ff       	jmp    80106cc7 <alltraps>

80107afb <vector231>:
.globl vector231
vector231:
  pushl $0
80107afb:	6a 00                	push   $0x0
  pushl $231
80107afd:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80107b02:	e9 c0 f1 ff ff       	jmp    80106cc7 <alltraps>

80107b07 <vector232>:
.globl vector232
vector232:
  pushl $0
80107b07:	6a 00                	push   $0x0
  pushl $232
80107b09:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80107b0e:	e9 b4 f1 ff ff       	jmp    80106cc7 <alltraps>

80107b13 <vector233>:
.globl vector233
vector233:
  pushl $0
80107b13:	6a 00                	push   $0x0
  pushl $233
80107b15:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80107b1a:	e9 a8 f1 ff ff       	jmp    80106cc7 <alltraps>

80107b1f <vector234>:
.globl vector234
vector234:
  pushl $0
80107b1f:	6a 00                	push   $0x0
  pushl $234
80107b21:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80107b26:	e9 9c f1 ff ff       	jmp    80106cc7 <alltraps>

80107b2b <vector235>:
.globl vector235
vector235:
  pushl $0
80107b2b:	6a 00                	push   $0x0
  pushl $235
80107b2d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80107b32:	e9 90 f1 ff ff       	jmp    80106cc7 <alltraps>

80107b37 <vector236>:
.globl vector236
vector236:
  pushl $0
80107b37:	6a 00                	push   $0x0
  pushl $236
80107b39:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80107b3e:	e9 84 f1 ff ff       	jmp    80106cc7 <alltraps>

80107b43 <vector237>:
.globl vector237
vector237:
  pushl $0
80107b43:	6a 00                	push   $0x0
  pushl $237
80107b45:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80107b4a:	e9 78 f1 ff ff       	jmp    80106cc7 <alltraps>

80107b4f <vector238>:
.globl vector238
vector238:
  pushl $0
80107b4f:	6a 00                	push   $0x0
  pushl $238
80107b51:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80107b56:	e9 6c f1 ff ff       	jmp    80106cc7 <alltraps>

80107b5b <vector239>:
.globl vector239
vector239:
  pushl $0
80107b5b:	6a 00                	push   $0x0
  pushl $239
80107b5d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80107b62:	e9 60 f1 ff ff       	jmp    80106cc7 <alltraps>

80107b67 <vector240>:
.globl vector240
vector240:
  pushl $0
80107b67:	6a 00                	push   $0x0
  pushl $240
80107b69:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80107b6e:	e9 54 f1 ff ff       	jmp    80106cc7 <alltraps>

80107b73 <vector241>:
.globl vector241
vector241:
  pushl $0
80107b73:	6a 00                	push   $0x0
  pushl $241
80107b75:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80107b7a:	e9 48 f1 ff ff       	jmp    80106cc7 <alltraps>

80107b7f <vector242>:
.globl vector242
vector242:
  pushl $0
80107b7f:	6a 00                	push   $0x0
  pushl $242
80107b81:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80107b86:	e9 3c f1 ff ff       	jmp    80106cc7 <alltraps>

80107b8b <vector243>:
.globl vector243
vector243:
  pushl $0
80107b8b:	6a 00                	push   $0x0
  pushl $243
80107b8d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80107b92:	e9 30 f1 ff ff       	jmp    80106cc7 <alltraps>

80107b97 <vector244>:
.globl vector244
vector244:
  pushl $0
80107b97:	6a 00                	push   $0x0
  pushl $244
80107b99:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80107b9e:	e9 24 f1 ff ff       	jmp    80106cc7 <alltraps>

80107ba3 <vector245>:
.globl vector245
vector245:
  pushl $0
80107ba3:	6a 00                	push   $0x0
  pushl $245
80107ba5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80107baa:	e9 18 f1 ff ff       	jmp    80106cc7 <alltraps>

80107baf <vector246>:
.globl vector246
vector246:
  pushl $0
80107baf:	6a 00                	push   $0x0
  pushl $246
80107bb1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80107bb6:	e9 0c f1 ff ff       	jmp    80106cc7 <alltraps>

80107bbb <vector247>:
.globl vector247
vector247:
  pushl $0
80107bbb:	6a 00                	push   $0x0
  pushl $247
80107bbd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80107bc2:	e9 00 f1 ff ff       	jmp    80106cc7 <alltraps>

80107bc7 <vector248>:
.globl vector248
vector248:
  pushl $0
80107bc7:	6a 00                	push   $0x0
  pushl $248
80107bc9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80107bce:	e9 f4 f0 ff ff       	jmp    80106cc7 <alltraps>

80107bd3 <vector249>:
.globl vector249
vector249:
  pushl $0
80107bd3:	6a 00                	push   $0x0
  pushl $249
80107bd5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80107bda:	e9 e8 f0 ff ff       	jmp    80106cc7 <alltraps>

80107bdf <vector250>:
.globl vector250
vector250:
  pushl $0
80107bdf:	6a 00                	push   $0x0
  pushl $250
80107be1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80107be6:	e9 dc f0 ff ff       	jmp    80106cc7 <alltraps>

80107beb <vector251>:
.globl vector251
vector251:
  pushl $0
80107beb:	6a 00                	push   $0x0
  pushl $251
80107bed:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80107bf2:	e9 d0 f0 ff ff       	jmp    80106cc7 <alltraps>

80107bf7 <vector252>:
.globl vector252
vector252:
  pushl $0
80107bf7:	6a 00                	push   $0x0
  pushl $252
80107bf9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80107bfe:	e9 c4 f0 ff ff       	jmp    80106cc7 <alltraps>

80107c03 <vector253>:
.globl vector253
vector253:
  pushl $0
80107c03:	6a 00                	push   $0x0
  pushl $253
80107c05:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80107c0a:	e9 b8 f0 ff ff       	jmp    80106cc7 <alltraps>

80107c0f <vector254>:
.globl vector254
vector254:
  pushl $0
80107c0f:	6a 00                	push   $0x0
  pushl $254
80107c11:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80107c16:	e9 ac f0 ff ff       	jmp    80106cc7 <alltraps>

80107c1b <vector255>:
.globl vector255
vector255:
  pushl $0
80107c1b:	6a 00                	push   $0x0
  pushl $255
80107c1d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80107c22:	e9 a0 f0 ff ff       	jmp    80106cc7 <alltraps>
80107c27:	66 90                	xchg   %ax,%ax
80107c29:	66 90                	xchg   %ax,%ax
80107c2b:	66 90                	xchg   %ax,%ax
80107c2d:	66 90                	xchg   %ax,%ax
80107c2f:	90                   	nop

80107c30 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107c30:	55                   	push   %ebp
80107c31:	89 e5                	mov    %esp,%ebp
80107c33:	57                   	push   %edi
80107c34:	56                   	push   %esi
80107c35:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107c36:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80107c3c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107c42:	83 ec 1c             	sub    $0x1c,%esp
  for(; a  < oldsz; a += PGSIZE){
80107c45:	39 d3                	cmp    %edx,%ebx
80107c47:	73 56                	jae    80107c9f <deallocuvm.part.0+0x6f>
80107c49:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80107c4c:	89 c6                	mov    %eax,%esi
80107c4e:	89 d7                	mov    %edx,%edi
80107c50:	eb 12                	jmp    80107c64 <deallocuvm.part.0+0x34>
80107c52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80107c58:	83 c2 01             	add    $0x1,%edx
80107c5b:	89 d3                	mov    %edx,%ebx
80107c5d:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
80107c60:	39 fb                	cmp    %edi,%ebx
80107c62:	73 38                	jae    80107c9c <deallocuvm.part.0+0x6c>
  pde = &pgdir[PDX(va)];
80107c64:	89 da                	mov    %ebx,%edx
80107c66:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80107c69:	8b 04 96             	mov    (%esi,%edx,4),%eax
80107c6c:	a8 01                	test   $0x1,%al
80107c6e:	74 e8                	je     80107c58 <deallocuvm.part.0+0x28>
  return &pgtab[PTX(va)];
80107c70:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107c72:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107c77:	c1 e9 0a             	shr    $0xa,%ecx
80107c7a:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
80107c80:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
80107c87:	85 c0                	test   %eax,%eax
80107c89:	74 cd                	je     80107c58 <deallocuvm.part.0+0x28>
    else if((*pte & PTE_P) != 0){
80107c8b:	8b 10                	mov    (%eax),%edx
80107c8d:	f6 c2 01             	test   $0x1,%dl
80107c90:	75 1e                	jne    80107cb0 <deallocuvm.part.0+0x80>
  for(; a  < oldsz; a += PGSIZE){
80107c92:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107c98:	39 fb                	cmp    %edi,%ebx
80107c9a:	72 c8                	jb     80107c64 <deallocuvm.part.0+0x34>
80107c9c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80107c9f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107ca2:	89 c8                	mov    %ecx,%eax
80107ca4:	5b                   	pop    %ebx
80107ca5:	5e                   	pop    %esi
80107ca6:	5f                   	pop    %edi
80107ca7:	5d                   	pop    %ebp
80107ca8:	c3                   	ret
80107ca9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(pa == 0)
80107cb0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107cb6:	74 26                	je     80107cde <deallocuvm.part.0+0xae>
      kfree(v);
80107cb8:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80107cbb:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107cc1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80107cc4:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80107cca:	52                   	push   %edx
80107ccb:	e8 e0 b5 ff ff       	call   801032b0 <kfree>
      *pte = 0;
80107cd0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(; a  < oldsz; a += PGSIZE){
80107cd3:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80107cd6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80107cdc:	eb 82                	jmp    80107c60 <deallocuvm.part.0+0x30>
        panic("kfree");
80107cde:	83 ec 0c             	sub    $0xc,%esp
80107ce1:	68 15 88 10 80       	push   $0x80108815
80107ce6:	e8 b5 86 ff ff       	call   801003a0 <panic>
80107ceb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80107cf0 <mappages>:
{
80107cf0:	55                   	push   %ebp
80107cf1:	89 e5                	mov    %esp,%ebp
80107cf3:	57                   	push   %edi
80107cf4:	56                   	push   %esi
80107cf5:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80107cf6:	89 d3                	mov    %edx,%ebx
80107cf8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80107cfe:	83 ec 1c             	sub    $0x1c,%esp
80107d01:	89 45 e0             	mov    %eax,-0x20(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80107d04:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107d08:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107d0d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107d10:	8b 45 08             	mov    0x8(%ebp),%eax
80107d13:	29 d8                	sub    %ebx,%eax
80107d15:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107d18:	eb 3f                	jmp    80107d59 <mappages+0x69>
80107d1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80107d20:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107d22:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107d27:	c1 ea 0a             	shr    $0xa,%edx
80107d2a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107d30:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80107d37:	85 c0                	test   %eax,%eax
80107d39:	74 75                	je     80107db0 <mappages+0xc0>
    if(*pte & PTE_P)
80107d3b:	f6 00 01             	testb  $0x1,(%eax)
80107d3e:	0f 85 86 00 00 00    	jne    80107dca <mappages+0xda>
    *pte = pa | perm | PTE_P;
80107d44:	0b 75 0c             	or     0xc(%ebp),%esi
80107d47:	83 ce 01             	or     $0x1,%esi
80107d4a:	89 30                	mov    %esi,(%eax)
    if(a == last)
80107d4c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80107d4f:	39 c3                	cmp    %eax,%ebx
80107d51:	74 6d                	je     80107dc0 <mappages+0xd0>
    a += PGSIZE;
80107d53:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80107d59:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
80107d5c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80107d5f:	8d 34 03             	lea    (%ebx,%eax,1),%esi
80107d62:	89 d8                	mov    %ebx,%eax
80107d64:	c1 e8 16             	shr    $0x16,%eax
80107d67:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80107d6a:	8b 07                	mov    (%edi),%eax
80107d6c:	a8 01                	test   $0x1,%al
80107d6e:	75 b0                	jne    80107d20 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80107d70:	e8 fb b6 ff ff       	call   80103470 <kalloc>
80107d75:	85 c0                	test   %eax,%eax
80107d77:	74 37                	je     80107db0 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80107d79:	83 ec 04             	sub    $0x4,%esp
80107d7c:	68 00 10 00 00       	push   $0x1000
80107d81:	6a 00                	push   $0x0
80107d83:	50                   	push   %eax
80107d84:	89 45 d8             	mov    %eax,-0x28(%ebp)
80107d87:	e8 54 d7 ff ff       	call   801054e0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107d8c:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
80107d8f:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80107d92:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80107d98:	83 c8 07             	or     $0x7,%eax
80107d9b:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80107d9d:	89 d8                	mov    %ebx,%eax
80107d9f:	c1 e8 0a             	shr    $0xa,%eax
80107da2:	25 fc 0f 00 00       	and    $0xffc,%eax
80107da7:	01 d0                	add    %edx,%eax
80107da9:	eb 90                	jmp    80107d3b <mappages+0x4b>
80107dab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
}
80107db0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107db3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107db8:	5b                   	pop    %ebx
80107db9:	5e                   	pop    %esi
80107dba:	5f                   	pop    %edi
80107dbb:	5d                   	pop    %ebp
80107dbc:	c3                   	ret
80107dbd:	8d 76 00             	lea    0x0(%esi),%esi
80107dc0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107dc3:	31 c0                	xor    %eax,%eax
}
80107dc5:	5b                   	pop    %ebx
80107dc6:	5e                   	pop    %esi
80107dc7:	5f                   	pop    %edi
80107dc8:	5d                   	pop    %ebp
80107dc9:	c3                   	ret
      panic("remap");
80107dca:	83 ec 0c             	sub    $0xc,%esp
80107dcd:	68 b6 8a 10 80       	push   $0x80108ab6
80107dd2:	e8 c9 85 ff ff       	call   801003a0 <panic>
80107dd7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107dde:	00 
80107ddf:	90                   	nop

80107de0 <seginit>:
{
80107de0:	55                   	push   %ebp
80107de1:	89 e5                	mov    %esp,%ebp
80107de3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80107de6:	e8 85 c9 ff ff       	call   80104770 <cpuid>
  pd[0] = size-1;
80107deb:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80107df0:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80107df6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
80107dfa:	c7 80 38 5c 11 80 ff 	movl   $0xffff,-0x7feea3c8(%eax)
80107e01:	ff 00 00 
80107e04:	c7 80 3c 5c 11 80 00 	movl   $0xcf9a00,-0x7feea3c4(%eax)
80107e0b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80107e0e:	c7 80 40 5c 11 80 ff 	movl   $0xffff,-0x7feea3c0(%eax)
80107e15:	ff 00 00 
80107e18:	c7 80 44 5c 11 80 00 	movl   $0xcf9200,-0x7feea3bc(%eax)
80107e1f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80107e22:	c7 80 48 5c 11 80 ff 	movl   $0xffff,-0x7feea3b8(%eax)
80107e29:	ff 00 00 
80107e2c:	c7 80 4c 5c 11 80 00 	movl   $0xcffa00,-0x7feea3b4(%eax)
80107e33:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107e36:	c7 80 50 5c 11 80 ff 	movl   $0xffff,-0x7feea3b0(%eax)
80107e3d:	ff 00 00 
80107e40:	c7 80 54 5c 11 80 00 	movl   $0xcff200,-0x7feea3ac(%eax)
80107e47:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80107e4a:	05 30 5c 11 80       	add    $0x80115c30,%eax
  pd[1] = (uint)p;
80107e4f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107e53:	c1 e8 10             	shr    $0x10,%eax
80107e56:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80107e5a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80107e5d:	0f 01 10             	lgdtl  (%eax)
}
80107e60:	c9                   	leave
80107e61:	c3                   	ret
80107e62:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107e69:	00 
80107e6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107e70 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107e70:	a1 e4 89 11 80       	mov    0x801189e4,%eax
80107e75:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107e7a:	0f 22 d8             	mov    %eax,%cr3
}
80107e7d:	c3                   	ret
80107e7e:	66 90                	xchg   %ax,%ax

80107e80 <switchuvm>:
{
80107e80:	55                   	push   %ebp
80107e81:	89 e5                	mov    %esp,%ebp
80107e83:	57                   	push   %edi
80107e84:	56                   	push   %esi
80107e85:	53                   	push   %ebx
80107e86:	83 ec 1c             	sub    $0x1c,%esp
80107e89:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80107e8c:	85 f6                	test   %esi,%esi
80107e8e:	0f 84 cb 00 00 00    	je     80107f5f <switchuvm+0xdf>
  if(p->kstack == 0)
80107e94:	8b 46 08             	mov    0x8(%esi),%eax
80107e97:	85 c0                	test   %eax,%eax
80107e99:	0f 84 da 00 00 00    	je     80107f79 <switchuvm+0xf9>
  if(p->pgdir == 0)
80107e9f:	8b 46 04             	mov    0x4(%esi),%eax
80107ea2:	85 c0                	test   %eax,%eax
80107ea4:	0f 84 c2 00 00 00    	je     80107f6c <switchuvm+0xec>
  pushcli();
80107eaa:	e8 e1 d3 ff ff       	call   80105290 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107eaf:	e8 5c c8 ff ff       	call   80104710 <mycpu>
80107eb4:	89 c3                	mov    %eax,%ebx
80107eb6:	e8 55 c8 ff ff       	call   80104710 <mycpu>
80107ebb:	89 c7                	mov    %eax,%edi
80107ebd:	e8 4e c8 ff ff       	call   80104710 <mycpu>
80107ec2:	83 c7 08             	add    $0x8,%edi
80107ec5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107ec8:	e8 43 c8 ff ff       	call   80104710 <mycpu>
80107ecd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80107ed0:	ba 67 00 00 00       	mov    $0x67,%edx
80107ed5:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80107edc:	83 c0 08             	add    $0x8,%eax
80107edf:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107ee6:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80107eeb:	83 c1 08             	add    $0x8,%ecx
80107eee:	c1 e8 18             	shr    $0x18,%eax
80107ef1:	c1 e9 10             	shr    $0x10,%ecx
80107ef4:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80107efa:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107f00:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107f05:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107f0c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80107f11:	e8 fa c7 ff ff       	call   80104710 <mycpu>
80107f16:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80107f1d:	e8 ee c7 ff ff       	call   80104710 <mycpu>
80107f22:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107f26:	8b 5e 08             	mov    0x8(%esi),%ebx
80107f29:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107f2f:	e8 dc c7 ff ff       	call   80104710 <mycpu>
80107f34:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107f37:	e8 d4 c7 ff ff       	call   80104710 <mycpu>
80107f3c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107f40:	b8 28 00 00 00       	mov    $0x28,%eax
80107f45:	0f 00 d8             	ltr    %eax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107f48:	8b 46 04             	mov    0x4(%esi),%eax
80107f4b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107f50:	0f 22 d8             	mov    %eax,%cr3
}
80107f53:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107f56:	5b                   	pop    %ebx
80107f57:	5e                   	pop    %esi
80107f58:	5f                   	pop    %edi
80107f59:	5d                   	pop    %ebp
  popcli();
80107f5a:	e9 81 d3 ff ff       	jmp    801052e0 <popcli>
    panic("switchuvm: no process");
80107f5f:	83 ec 0c             	sub    $0xc,%esp
80107f62:	68 bc 8a 10 80       	push   $0x80108abc
80107f67:	e8 34 84 ff ff       	call   801003a0 <panic>
    panic("switchuvm: no pgdir");
80107f6c:	83 ec 0c             	sub    $0xc,%esp
80107f6f:	68 e7 8a 10 80       	push   $0x80108ae7
80107f74:	e8 27 84 ff ff       	call   801003a0 <panic>
    panic("switchuvm: no kstack");
80107f79:	83 ec 0c             	sub    $0xc,%esp
80107f7c:	68 d2 8a 10 80       	push   $0x80108ad2
80107f81:	e8 1a 84 ff ff       	call   801003a0 <panic>
80107f86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107f8d:	00 
80107f8e:	66 90                	xchg   %ax,%ax

80107f90 <inituvm>:
{
80107f90:	55                   	push   %ebp
80107f91:	89 e5                	mov    %esp,%ebp
80107f93:	57                   	push   %edi
80107f94:	56                   	push   %esi
80107f95:	53                   	push   %ebx
80107f96:	83 ec 1c             	sub    $0x1c,%esp
80107f99:	8b 45 08             	mov    0x8(%ebp),%eax
80107f9c:	8b 75 10             	mov    0x10(%ebp),%esi
80107f9f:	8b 7d 0c             	mov    0xc(%ebp),%edi
80107fa2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80107fa5:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107fab:	77 49                	ja     80107ff6 <inituvm+0x66>
  mem = kalloc();
80107fad:	e8 be b4 ff ff       	call   80103470 <kalloc>
  memset(mem, 0, PGSIZE);
80107fb2:	83 ec 04             	sub    $0x4,%esp
80107fb5:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
80107fba:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107fbc:	6a 00                	push   $0x0
80107fbe:	50                   	push   %eax
80107fbf:	e8 1c d5 ff ff       	call   801054e0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80107fc4:	58                   	pop    %eax
80107fc5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107fcb:	5a                   	pop    %edx
80107fcc:	6a 06                	push   $0x6
80107fce:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107fd3:	31 d2                	xor    %edx,%edx
80107fd5:	50                   	push   %eax
80107fd6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107fd9:	e8 12 fd ff ff       	call   80107cf0 <mappages>
  memmove(mem, init, sz);
80107fde:	83 c4 10             	add    $0x10,%esp
80107fe1:	89 75 10             	mov    %esi,0x10(%ebp)
80107fe4:	89 7d 0c             	mov    %edi,0xc(%ebp)
80107fe7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80107fea:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107fed:	5b                   	pop    %ebx
80107fee:	5e                   	pop    %esi
80107fef:	5f                   	pop    %edi
80107ff0:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80107ff1:	e9 7a d5 ff ff       	jmp    80105570 <memmove>
    panic("inituvm: more than a page");
80107ff6:	83 ec 0c             	sub    $0xc,%esp
80107ff9:	68 fb 8a 10 80       	push   $0x80108afb
80107ffe:	e8 9d 83 ff ff       	call   801003a0 <panic>
80108003:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010800a:	00 
8010800b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80108010 <loaduvm>:
{
80108010:	55                   	push   %ebp
80108011:	89 e5                	mov    %esp,%ebp
80108013:	57                   	push   %edi
80108014:	56                   	push   %esi
80108015:	53                   	push   %ebx
80108016:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80108019:	8b 75 0c             	mov    0xc(%ebp),%esi
{
8010801c:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
8010801f:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
80108025:	0f 85 a2 00 00 00    	jne    801080cd <loaduvm+0xbd>
  for(i = 0; i < sz; i += PGSIZE){
8010802b:	85 ff                	test   %edi,%edi
8010802d:	74 7d                	je     801080ac <loaduvm+0x9c>
8010802f:	90                   	nop
  pde = &pgdir[PDX(va)];
80108030:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80108033:	8b 55 08             	mov    0x8(%ebp),%edx
80108036:	01 f0                	add    %esi,%eax
  pde = &pgdir[PDX(va)];
80108038:	89 c1                	mov    %eax,%ecx
8010803a:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010803d:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
80108040:	f6 c1 01             	test   $0x1,%cl
80108043:	75 13                	jne    80108058 <loaduvm+0x48>
      panic("loaduvm: address should exist");
80108045:	83 ec 0c             	sub    $0xc,%esp
80108048:	68 15 8b 10 80       	push   $0x80108b15
8010804d:	e8 4e 83 ff ff       	call   801003a0 <panic>
80108052:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80108058:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010805b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80108061:	25 fc 0f 00 00       	and    $0xffc,%eax
80108066:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
8010806d:	85 c9                	test   %ecx,%ecx
8010806f:	74 d4                	je     80108045 <loaduvm+0x35>
    if(sz - i < PGSIZE)
80108071:	89 fb                	mov    %edi,%ebx
80108073:	b8 00 10 00 00       	mov    $0x1000,%eax
80108078:	29 f3                	sub    %esi,%ebx
8010807a:	39 c3                	cmp    %eax,%ebx
8010807c:	0f 47 d8             	cmova  %eax,%ebx
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010807f:	53                   	push   %ebx
80108080:	8b 45 14             	mov    0x14(%ebp),%eax
80108083:	01 f0                	add    %esi,%eax
80108085:	50                   	push   %eax
    pa = PTE_ADDR(*pte);
80108086:	8b 01                	mov    (%ecx),%eax
80108088:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010808d:	05 00 00 00 80       	add    $0x80000000,%eax
80108092:	50                   	push   %eax
80108093:	ff 75 10             	push   0x10(%ebp)
80108096:	e8 25 a8 ff ff       	call   801028c0 <readi>
8010809b:	83 c4 10             	add    $0x10,%esp
8010809e:	39 d8                	cmp    %ebx,%eax
801080a0:	75 1e                	jne    801080c0 <loaduvm+0xb0>
  for(i = 0; i < sz; i += PGSIZE){
801080a2:	81 c6 00 10 00 00    	add    $0x1000,%esi
801080a8:	39 fe                	cmp    %edi,%esi
801080aa:	72 84                	jb     80108030 <loaduvm+0x20>
}
801080ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801080af:	31 c0                	xor    %eax,%eax
}
801080b1:	5b                   	pop    %ebx
801080b2:	5e                   	pop    %esi
801080b3:	5f                   	pop    %edi
801080b4:	5d                   	pop    %ebp
801080b5:	c3                   	ret
801080b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801080bd:	00 
801080be:	66 90                	xchg   %ax,%ax
801080c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801080c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801080c8:	5b                   	pop    %ebx
801080c9:	5e                   	pop    %esi
801080ca:	5f                   	pop    %edi
801080cb:	5d                   	pop    %ebp
801080cc:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
801080cd:	83 ec 0c             	sub    $0xc,%esp
801080d0:	68 88 8d 10 80       	push   $0x80108d88
801080d5:	e8 c6 82 ff ff       	call   801003a0 <panic>
801080da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801080e0 <allocuvm>:
{
801080e0:	55                   	push   %ebp
801080e1:	89 e5                	mov    %esp,%ebp
801080e3:	57                   	push   %edi
801080e4:	56                   	push   %esi
801080e5:	53                   	push   %ebx
801080e6:	83 ec 1c             	sub    $0x1c,%esp
801080e9:	8b 75 10             	mov    0x10(%ebp),%esi
  if(newsz >= KERNBASE)
801080ec:	85 f6                	test   %esi,%esi
801080ee:	0f 88 98 00 00 00    	js     8010818c <allocuvm+0xac>
801080f4:	89 f2                	mov    %esi,%edx
  if(newsz < oldsz)
801080f6:	3b 75 0c             	cmp    0xc(%ebp),%esi
801080f9:	0f 82 a1 00 00 00    	jb     801081a0 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
801080ff:	8b 45 0c             	mov    0xc(%ebp),%eax
80108102:	05 ff 0f 00 00       	add    $0xfff,%eax
80108107:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010810c:	89 c7                	mov    %eax,%edi
  for(; a < newsz; a += PGSIZE){
8010810e:	39 f0                	cmp    %esi,%eax
80108110:	0f 83 8d 00 00 00    	jae    801081a3 <allocuvm+0xc3>
80108116:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80108119:	eb 44                	jmp    8010815f <allocuvm+0x7f>
8010811b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80108120:	83 ec 04             	sub    $0x4,%esp
80108123:	68 00 10 00 00       	push   $0x1000
80108128:	6a 00                	push   $0x0
8010812a:	50                   	push   %eax
8010812b:	e8 b0 d3 ff ff       	call   801054e0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80108130:	58                   	pop    %eax
80108131:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80108137:	5a                   	pop    %edx
80108138:	6a 06                	push   $0x6
8010813a:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010813f:	89 fa                	mov    %edi,%edx
80108141:	50                   	push   %eax
80108142:	8b 45 08             	mov    0x8(%ebp),%eax
80108145:	e8 a6 fb ff ff       	call   80107cf0 <mappages>
8010814a:	83 c4 10             	add    $0x10,%esp
8010814d:	85 c0                	test   %eax,%eax
8010814f:	78 5f                	js     801081b0 <allocuvm+0xd0>
  for(; a < newsz; a += PGSIZE){
80108151:	81 c7 00 10 00 00    	add    $0x1000,%edi
80108157:	39 f7                	cmp    %esi,%edi
80108159:	0f 83 89 00 00 00    	jae    801081e8 <allocuvm+0x108>
    mem = kalloc();
8010815f:	e8 0c b3 ff ff       	call   80103470 <kalloc>
80108164:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80108166:	85 c0                	test   %eax,%eax
80108168:	75 b6                	jne    80108120 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
8010816a:	83 ec 0c             	sub    $0xc,%esp
8010816d:	68 33 8b 10 80       	push   $0x80108b33
80108172:	e8 c9 8a ff ff       	call   80100c40 <cprintf>
  if(newsz >= oldsz)
80108177:	83 c4 10             	add    $0x10,%esp
8010817a:	3b 75 0c             	cmp    0xc(%ebp),%esi
8010817d:	74 0d                	je     8010818c <allocuvm+0xac>
8010817f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80108182:	8b 45 08             	mov    0x8(%ebp),%eax
80108185:	89 f2                	mov    %esi,%edx
80108187:	e8 a4 fa ff ff       	call   80107c30 <deallocuvm.part.0>
    return 0;
8010818c:	31 d2                	xor    %edx,%edx
}
8010818e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108191:	89 d0                	mov    %edx,%eax
80108193:	5b                   	pop    %ebx
80108194:	5e                   	pop    %esi
80108195:	5f                   	pop    %edi
80108196:	5d                   	pop    %ebp
80108197:	c3                   	ret
80108198:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010819f:	00 
    return oldsz;
801081a0:	8b 55 0c             	mov    0xc(%ebp),%edx
}
801081a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801081a6:	89 d0                	mov    %edx,%eax
801081a8:	5b                   	pop    %ebx
801081a9:	5e                   	pop    %esi
801081aa:	5f                   	pop    %edi
801081ab:	5d                   	pop    %ebp
801081ac:	c3                   	ret
801081ad:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
801081b0:	83 ec 0c             	sub    $0xc,%esp
801081b3:	68 4b 8b 10 80       	push   $0x80108b4b
801081b8:	e8 83 8a ff ff       	call   80100c40 <cprintf>
  if(newsz >= oldsz)
801081bd:	83 c4 10             	add    $0x10,%esp
801081c0:	3b 75 0c             	cmp    0xc(%ebp),%esi
801081c3:	74 0d                	je     801081d2 <allocuvm+0xf2>
801081c5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801081c8:	8b 45 08             	mov    0x8(%ebp),%eax
801081cb:	89 f2                	mov    %esi,%edx
801081cd:	e8 5e fa ff ff       	call   80107c30 <deallocuvm.part.0>
      kfree(mem);
801081d2:	83 ec 0c             	sub    $0xc,%esp
801081d5:	53                   	push   %ebx
801081d6:	e8 d5 b0 ff ff       	call   801032b0 <kfree>
      return 0;
801081db:	83 c4 10             	add    $0x10,%esp
    return 0;
801081de:	31 d2                	xor    %edx,%edx
801081e0:	eb ac                	jmp    8010818e <allocuvm+0xae>
801081e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801081e8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
}
801081eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801081ee:	5b                   	pop    %ebx
801081ef:	5e                   	pop    %esi
801081f0:	89 d0                	mov    %edx,%eax
801081f2:	5f                   	pop    %edi
801081f3:	5d                   	pop    %ebp
801081f4:	c3                   	ret
801081f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801081fc:	00 
801081fd:	8d 76 00             	lea    0x0(%esi),%esi

80108200 <deallocuvm>:
{
80108200:	55                   	push   %ebp
80108201:	89 e5                	mov    %esp,%ebp
80108203:	8b 55 0c             	mov    0xc(%ebp),%edx
80108206:	8b 4d 10             	mov    0x10(%ebp),%ecx
80108209:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
8010820c:	39 d1                	cmp    %edx,%ecx
8010820e:	73 10                	jae    80108220 <deallocuvm+0x20>
}
80108210:	5d                   	pop    %ebp
80108211:	e9 1a fa ff ff       	jmp    80107c30 <deallocuvm.part.0>
80108216:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010821d:	00 
8010821e:	66 90                	xchg   %ax,%ax
80108220:	89 d0                	mov    %edx,%eax
80108222:	5d                   	pop    %ebp
80108223:	c3                   	ret
80108224:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010822b:	00 
8010822c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80108230 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80108230:	55                   	push   %ebp
80108231:	89 e5                	mov    %esp,%ebp
80108233:	57                   	push   %edi
80108234:	56                   	push   %esi
80108235:	53                   	push   %ebx
80108236:	83 ec 0c             	sub    $0xc,%esp
80108239:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010823c:	85 f6                	test   %esi,%esi
8010823e:	74 59                	je     80108299 <freevm+0x69>
  if(newsz >= oldsz)
80108240:	31 c9                	xor    %ecx,%ecx
80108242:	ba 00 00 00 80       	mov    $0x80000000,%edx
80108247:	89 f0                	mov    %esi,%eax
80108249:	89 f3                	mov    %esi,%ebx
8010824b:	e8 e0 f9 ff ff       	call   80107c30 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80108250:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80108256:	eb 0f                	jmp    80108267 <freevm+0x37>
80108258:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010825f:	00 
80108260:	83 c3 04             	add    $0x4,%ebx
80108263:	39 fb                	cmp    %edi,%ebx
80108265:	74 23                	je     8010828a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80108267:	8b 03                	mov    (%ebx),%eax
80108269:	a8 01                	test   $0x1,%al
8010826b:	74 f3                	je     80108260 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010826d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80108272:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80108275:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80108278:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010827d:	50                   	push   %eax
8010827e:	e8 2d b0 ff ff       	call   801032b0 <kfree>
80108283:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80108286:	39 fb                	cmp    %edi,%ebx
80108288:	75 dd                	jne    80108267 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010828a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010828d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80108290:	5b                   	pop    %ebx
80108291:	5e                   	pop    %esi
80108292:	5f                   	pop    %edi
80108293:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80108294:	e9 17 b0 ff ff       	jmp    801032b0 <kfree>
    panic("freevm: no pgdir");
80108299:	83 ec 0c             	sub    $0xc,%esp
8010829c:	68 67 8b 10 80       	push   $0x80108b67
801082a1:	e8 fa 80 ff ff       	call   801003a0 <panic>
801082a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801082ad:	00 
801082ae:	66 90                	xchg   %ax,%ax

801082b0 <setupkvm>:
{
801082b0:	55                   	push   %ebp
801082b1:	89 e5                	mov    %esp,%ebp
801082b3:	56                   	push   %esi
801082b4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801082b5:	e8 b6 b1 ff ff       	call   80103470 <kalloc>
801082ba:	85 c0                	test   %eax,%eax
801082bc:	74 5e                	je     8010831c <setupkvm+0x6c>
  memset(pgdir, 0, PGSIZE);
801082be:	83 ec 04             	sub    $0x4,%esp
801082c1:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801082c3:	bb 20 c4 10 80       	mov    $0x8010c420,%ebx
  memset(pgdir, 0, PGSIZE);
801082c8:	68 00 10 00 00       	push   $0x1000
801082cd:	6a 00                	push   $0x0
801082cf:	50                   	push   %eax
801082d0:	e8 0b d2 ff ff       	call   801054e0 <memset>
801082d5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
801082d8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801082db:	83 ec 08             	sub    $0x8,%esp
801082de:	8b 4b 08             	mov    0x8(%ebx),%ecx
801082e1:	8b 13                	mov    (%ebx),%edx
801082e3:	ff 73 0c             	push   0xc(%ebx)
801082e6:	50                   	push   %eax
801082e7:	29 c1                	sub    %eax,%ecx
801082e9:	89 f0                	mov    %esi,%eax
801082eb:	e8 00 fa ff ff       	call   80107cf0 <mappages>
801082f0:	83 c4 10             	add    $0x10,%esp
801082f3:	85 c0                	test   %eax,%eax
801082f5:	78 19                	js     80108310 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801082f7:	83 c3 10             	add    $0x10,%ebx
801082fa:	81 fb 60 c4 10 80    	cmp    $0x8010c460,%ebx
80108300:	75 d6                	jne    801082d8 <setupkvm+0x28>
}
80108302:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108305:	89 f0                	mov    %esi,%eax
80108307:	5b                   	pop    %ebx
80108308:	5e                   	pop    %esi
80108309:	5d                   	pop    %ebp
8010830a:	c3                   	ret
8010830b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80108310:	83 ec 0c             	sub    $0xc,%esp
80108313:	56                   	push   %esi
80108314:	e8 17 ff ff ff       	call   80108230 <freevm>
      return 0;
80108319:	83 c4 10             	add    $0x10,%esp
}
8010831c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
8010831f:	31 f6                	xor    %esi,%esi
}
80108321:	89 f0                	mov    %esi,%eax
80108323:	5b                   	pop    %ebx
80108324:	5e                   	pop    %esi
80108325:	5d                   	pop    %ebp
80108326:	c3                   	ret
80108327:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010832e:	00 
8010832f:	90                   	nop

80108330 <kvmalloc>:
{
80108330:	55                   	push   %ebp
80108331:	89 e5                	mov    %esp,%ebp
80108333:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80108336:	e8 75 ff ff ff       	call   801082b0 <setupkvm>
8010833b:	a3 e4 89 11 80       	mov    %eax,0x801189e4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108340:	05 00 00 00 80       	add    $0x80000000,%eax
80108345:	0f 22 d8             	mov    %eax,%cr3
}
80108348:	c9                   	leave
80108349:	c3                   	ret
8010834a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108350 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80108350:	55                   	push   %ebp
80108351:	89 e5                	mov    %esp,%ebp
80108353:	83 ec 08             	sub    $0x8,%esp
80108356:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80108359:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
8010835c:	89 c1                	mov    %eax,%ecx
8010835e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80108361:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80108364:	f6 c2 01             	test   $0x1,%dl
80108367:	75 17                	jne    80108380 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80108369:	83 ec 0c             	sub    $0xc,%esp
8010836c:	68 78 8b 10 80       	push   $0x80108b78
80108371:	e8 2a 80 ff ff       	call   801003a0 <panic>
80108376:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010837d:	00 
8010837e:	66 90                	xchg   %ax,%ax
  return &pgtab[PTX(va)];
80108380:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108383:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80108389:	25 fc 0f 00 00       	and    $0xffc,%eax
8010838e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80108395:	85 c0                	test   %eax,%eax
80108397:	74 d0                	je     80108369 <clearpteu+0x19>
  *pte &= ~PTE_U;
80108399:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010839c:	c9                   	leave
8010839d:	c3                   	ret
8010839e:	66 90                	xchg   %ax,%ax

801083a0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801083a0:	55                   	push   %ebp
801083a1:	89 e5                	mov    %esp,%ebp
801083a3:	57                   	push   %edi
801083a4:	56                   	push   %esi
801083a5:	53                   	push   %ebx
801083a6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801083a9:	e8 02 ff ff ff       	call   801082b0 <setupkvm>
801083ae:	89 45 e0             	mov    %eax,-0x20(%ebp)
801083b1:	85 c0                	test   %eax,%eax
801083b3:	0f 84 e9 00 00 00    	je     801084a2 <copyuvm+0x102>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801083b9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801083bc:	85 c9                	test   %ecx,%ecx
801083be:	0f 84 b2 00 00 00    	je     80108476 <copyuvm+0xd6>
801083c4:	31 f6                	xor    %esi,%esi
801083c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801083cd:	00 
801083ce:	66 90                	xchg   %ax,%ax
  if(*pde & PTE_P){
801083d0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
801083d3:	89 f0                	mov    %esi,%eax
801083d5:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
801083d8:	8b 04 81             	mov    (%ecx,%eax,4),%eax
801083db:	a8 01                	test   $0x1,%al
801083dd:	75 11                	jne    801083f0 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801083df:	83 ec 0c             	sub    $0xc,%esp
801083e2:	68 82 8b 10 80       	push   $0x80108b82
801083e7:	e8 b4 7f ff ff       	call   801003a0 <panic>
801083ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
801083f0:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801083f2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801083f7:	c1 ea 0a             	shr    $0xa,%edx
801083fa:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80108400:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80108407:	85 c0                	test   %eax,%eax
80108409:	74 d4                	je     801083df <copyuvm+0x3f>
    if(!(*pte & PTE_P))
8010840b:	8b 00                	mov    (%eax),%eax
8010840d:	a8 01                	test   $0x1,%al
8010840f:	0f 84 9f 00 00 00    	je     801084b4 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80108415:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80108417:	25 ff 0f 00 00       	and    $0xfff,%eax
8010841c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
8010841f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80108425:	e8 46 b0 ff ff       	call   80103470 <kalloc>
8010842a:	89 c3                	mov    %eax,%ebx
8010842c:	85 c0                	test   %eax,%eax
8010842e:	74 64                	je     80108494 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80108430:	83 ec 04             	sub    $0x4,%esp
80108433:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80108439:	68 00 10 00 00       	push   $0x1000
8010843e:	57                   	push   %edi
8010843f:	50                   	push   %eax
80108440:	e8 2b d1 ff ff       	call   80105570 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80108445:	58                   	pop    %eax
80108446:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010844c:	5a                   	pop    %edx
8010844d:	ff 75 e4             	push   -0x1c(%ebp)
80108450:	b9 00 10 00 00       	mov    $0x1000,%ecx
80108455:	89 f2                	mov    %esi,%edx
80108457:	50                   	push   %eax
80108458:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010845b:	e8 90 f8 ff ff       	call   80107cf0 <mappages>
80108460:	83 c4 10             	add    $0x10,%esp
80108463:	85 c0                	test   %eax,%eax
80108465:	78 21                	js     80108488 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
80108467:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010846d:	3b 75 0c             	cmp    0xc(%ebp),%esi
80108470:	0f 82 5a ff ff ff    	jb     801083d0 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80108476:	8b 45 e0             	mov    -0x20(%ebp),%eax
80108479:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010847c:	5b                   	pop    %ebx
8010847d:	5e                   	pop    %esi
8010847e:	5f                   	pop    %edi
8010847f:	5d                   	pop    %ebp
80108480:	c3                   	ret
80108481:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80108488:	83 ec 0c             	sub    $0xc,%esp
8010848b:	53                   	push   %ebx
8010848c:	e8 1f ae ff ff       	call   801032b0 <kfree>
      goto bad;
80108491:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80108494:	83 ec 0c             	sub    $0xc,%esp
80108497:	ff 75 e0             	push   -0x20(%ebp)
8010849a:	e8 91 fd ff ff       	call   80108230 <freevm>
  return 0;
8010849f:	83 c4 10             	add    $0x10,%esp
    return 0;
801084a2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
801084a9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801084ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
801084af:	5b                   	pop    %ebx
801084b0:	5e                   	pop    %esi
801084b1:	5f                   	pop    %edi
801084b2:	5d                   	pop    %ebp
801084b3:	c3                   	ret
      panic("copyuvm: page not present");
801084b4:	83 ec 0c             	sub    $0xc,%esp
801084b7:	68 9c 8b 10 80       	push   $0x80108b9c
801084bc:	e8 df 7e ff ff       	call   801003a0 <panic>
801084c1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801084c8:	00 
801084c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801084d0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801084d0:	55                   	push   %ebp
801084d1:	89 e5                	mov    %esp,%ebp
801084d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801084d6:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801084d9:	89 c1                	mov    %eax,%ecx
801084db:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801084de:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801084e1:	f6 c2 01             	test   $0x1,%dl
801084e4:	0f 84 f8 00 00 00    	je     801085e2 <uva2ka.cold>
  return &pgtab[PTX(va)];
801084ea:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801084ed:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801084f3:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
801084f4:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
801084f9:	8b 94 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%edx
  return (char*)P2V(PTE_ADDR(*pte));
80108500:	89 d0                	mov    %edx,%eax
80108502:	f7 d2                	not    %edx
80108504:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108509:	05 00 00 00 80       	add    $0x80000000,%eax
8010850e:	83 e2 05             	and    $0x5,%edx
80108511:	ba 00 00 00 00       	mov    $0x0,%edx
80108516:	0f 45 c2             	cmovne %edx,%eax
}
80108519:	c3                   	ret
8010851a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80108520 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80108520:	55                   	push   %ebp
80108521:	89 e5                	mov    %esp,%ebp
80108523:	57                   	push   %edi
80108524:	56                   	push   %esi
80108525:	53                   	push   %ebx
80108526:	83 ec 0c             	sub    $0xc,%esp
80108529:	8b 75 14             	mov    0x14(%ebp),%esi
8010852c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010852f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80108532:	85 f6                	test   %esi,%esi
80108534:	75 51                	jne    80108587 <copyout+0x67>
80108536:	e9 9d 00 00 00       	jmp    801085d8 <copyout+0xb8>
8010853b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  return (char*)P2V(PTE_ADDR(*pte));
80108540:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80108546:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
8010854c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80108552:	74 74                	je     801085c8 <copyout+0xa8>
      return -1;
    n = PGSIZE - (va - va0);
80108554:	89 fb                	mov    %edi,%ebx
80108556:	29 c3                	sub    %eax,%ebx
80108558:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
8010855e:	39 f3                	cmp    %esi,%ebx
80108560:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80108563:	29 f8                	sub    %edi,%eax
80108565:	83 ec 04             	sub    $0x4,%esp
80108568:	01 c1                	add    %eax,%ecx
8010856a:	53                   	push   %ebx
8010856b:	52                   	push   %edx
8010856c:	89 55 10             	mov    %edx,0x10(%ebp)
8010856f:	51                   	push   %ecx
80108570:	e8 fb cf ff ff       	call   80105570 <memmove>
    len -= n;
    buf += n;
80108575:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80108578:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
8010857e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80108581:	01 da                	add    %ebx,%edx
  while(len > 0){
80108583:	29 de                	sub    %ebx,%esi
80108585:	74 51                	je     801085d8 <copyout+0xb8>
  if(*pde & PTE_P){
80108587:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
8010858a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
8010858c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
8010858e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80108591:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80108597:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
8010859a:	f6 c1 01             	test   $0x1,%cl
8010859d:	0f 84 46 00 00 00    	je     801085e9 <copyout.cold>
  return &pgtab[PTX(va)];
801085a3:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801085a5:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
801085ab:	c1 eb 0c             	shr    $0xc,%ebx
801085ae:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
801085b4:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
801085bb:	89 d9                	mov    %ebx,%ecx
801085bd:	f7 d1                	not    %ecx
801085bf:	83 e1 05             	and    $0x5,%ecx
801085c2:	0f 84 78 ff ff ff    	je     80108540 <copyout+0x20>
  }
  return 0;
}
801085c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801085cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801085d0:	5b                   	pop    %ebx
801085d1:	5e                   	pop    %esi
801085d2:	5f                   	pop    %edi
801085d3:	5d                   	pop    %ebp
801085d4:	c3                   	ret
801085d5:	8d 76 00             	lea    0x0(%esi),%esi
801085d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801085db:	31 c0                	xor    %eax,%eax
}
801085dd:	5b                   	pop    %ebx
801085de:	5e                   	pop    %esi
801085df:	5f                   	pop    %edi
801085e0:	5d                   	pop    %ebp
801085e1:	c3                   	ret

801085e2 <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
801085e2:	a1 00 00 00 00       	mov    0x0,%eax
801085e7:	0f 0b                	ud2

801085e9 <copyout.cold>:
801085e9:	a1 00 00 00 00       	mov    0x0,%eax
801085ee:	0f 0b                	ud2
