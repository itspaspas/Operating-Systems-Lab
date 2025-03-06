
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
80100015:	b8 00 90 10 00       	mov    $0x109000,%eax
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
80100028:	bc d0 54 11 80       	mov    $0x801154d0,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 10 32 10 80       	mov    $0x80103210,%eax
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
80100044:	bb 54 a5 10 80       	mov    $0x8010a554,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 40 73 10 80       	push   $0x80107340
80100051:	68 20 a5 10 80       	push   $0x8010a520
80100056:	e8 35 45 00 00       	call   80104590 <initlock>
  bcache.head.next = &bcache.head;
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c ec 10 80       	mov    $0x8010ec1c,%eax
  bcache.head.prev = &bcache.head;
80100063:	c7 05 6c ec 10 80 1c 	movl   $0x8010ec1c,0x8010ec6c
8010006a:	ec 10 80 
  bcache.head.next = &bcache.head;
8010006d:	c7 05 70 ec 10 80 1c 	movl   $0x8010ec1c,0x8010ec70
80100074:	ec 10 80 
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
8010008b:	c7 43 50 1c ec 10 80 	movl   $0x8010ec1c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 47 73 10 80       	push   $0x80107347
80100097:	50                   	push   %eax
80100098:	e8 c3 43 00 00       	call   80104460 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 ec 10 80    	mov    %ebx,0x8010ec70
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	81 fb c0 e9 10 80    	cmp    $0x8010e9c0,%ebx
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
801000df:	68 20 a5 10 80       	push   $0x8010a520
801000e4:	e8 97 46 00 00       	call   80104780 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d 70 ec 10 80    	mov    0x8010ec70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
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
80100120:	8b 1d 6c ec 10 80    	mov    0x8010ec6c,%ebx
80100126:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c ec 10 80    	cmp    $0x8010ec1c,%ebx
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
8010015d:	68 20 a5 10 80       	push   $0x8010a520
80100162:	e8 b9 45 00 00       	call   80104720 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 2e 43 00 00       	call   801044a0 <acquiresleep>
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
8010018c:	e8 1f 23 00 00       	call   801024b0 <iderw>
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
801001a1:	68 4e 73 10 80       	push   $0x8010734e
801001a6:	e8 d5 01 00 00       	call   80100380 <panic>
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
801001be:	e8 7d 43 00 00       	call   80104540 <holdingsleep>
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
801001d4:	e9 d7 22 00 00       	jmp    801024b0 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 5f 73 10 80       	push   $0x8010735f
801001e1:	e8 9a 01 00 00       	call   80100380 <panic>
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
801001ff:	e8 3c 43 00 00       	call   80104540 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 63                	je     8010026e <brelse+0x7e>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 ec 42 00 00       	call   80104500 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010021b:	e8 60 45 00 00       	call   80104780 <acquire>
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
8010023f:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
    b->prev = &bcache.head;
80100244:	c7 43 50 1c ec 10 80 	movl   $0x8010ec1c,0x50(%ebx)
    b->next = bcache.head.next;
8010024b:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
8010024e:	a1 70 ec 10 80       	mov    0x8010ec70,%eax
80100253:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100256:	89 1d 70 ec 10 80    	mov    %ebx,0x8010ec70
  }
  
  release(&bcache.lock);
8010025c:	c7 45 08 20 a5 10 80 	movl   $0x8010a520,0x8(%ebp)
}
80100263:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100266:	5b                   	pop    %ebx
80100267:	5e                   	pop    %esi
80100268:	5d                   	pop    %ebp
  release(&bcache.lock);
80100269:	e9 b2 44 00 00       	jmp    80104720 <release>
    panic("brelse");
8010026e:	83 ec 0c             	sub    $0xc,%esp
80100271:	68 66 73 10 80       	push   $0x80107366
80100276:	e8 05 01 00 00       	call   80100380 <panic>
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
80100294:	e8 c7 17 00 00       	call   80101a60 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 20 ef 10 80 	movl   $0x8010ef20,(%esp)
801002a0:	e8 db 44 00 00       	call   80104780 <acquire>

  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>

    while(input.r == input.w){
801002b0:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
801002b5:	39 05 04 ef 10 80    	cmp    %eax,0x8010ef04
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
801002c3:	68 20 ef 10 80       	push   $0x8010ef20
801002c8:	68 00 ef 10 80       	push   $0x8010ef00
801002cd:	e8 2e 3f 00 00       	call   80104200 <sleep>
    while(input.r == input.w){
801002d2:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 59 38 00 00       	call   80103b40 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 20 ef 10 80       	push   $0x8010ef20
801002f6:	e8 25 44 00 00       	call   80104720 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 7c 16 00 00       	call   80101980 <ilock>
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
8010031b:	89 15 00 ef 10 80    	mov    %edx,0x8010ef00
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a 80 ee 10 80 	movsbl -0x7fef1180(%edx),%ecx
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
80100347:	68 20 ef 10 80       	push   $0x8010ef20
8010034c:	e8 cf 43 00 00       	call   80104720 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 26 16 00 00       	call   80101980 <ilock>
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
8010036d:	a3 00 ef 10 80       	mov    %eax,0x8010ef00
80100372:	eb d0                	jmp    80100344 <consoleread+0xc4>
80100374:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010037b:	00 
8010037c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100380 <panic>:
{
80100380:	55                   	push   %ebp
80100381:	89 e5                	mov    %esp,%ebp
80100383:	56                   	push   %esi
80100384:	53                   	push   %ebx
80100385:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100388:	fa                   	cli
  cons.locking = 0;
80100389:	c7 05 54 ef 10 80 00 	movl   $0x0,0x8010ef54
80100390:	00 00 00 
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 12 27 00 00       	call   80102ab0 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 6d 73 10 80       	push   $0x8010736d
801003a7:	e8 c4 02 00 00       	call   80100670 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	push   0x8(%ebp)
801003b0:	e8 bb 02 00 00       	call   80100670 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 ef 77 10 80 	movl   $0x801077ef,(%esp)
801003bc:	e8 af 02 00 00       	call   80100670 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 e3 41 00 00       	call   801045b0 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003d8:	68 81 73 10 80       	push   $0x80107381
801003dd:	e8 8e 02 00 00       	call   80100670 <cprintf>
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003e9:	c7 05 58 ef 10 80 01 	movl   $0x1,0x8010ef58
801003f0:	00 00 00 
  for(;;)
801003f3:	eb fe                	jmp    801003f3 <panic+0x73>
801003f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801003fc:	00 
801003fd:	8d 76 00             	lea    0x0(%esi),%esi

80100400 <cgaputc>:
{
80100400:	55                   	push   %ebp
80100401:	89 c1                	mov    %eax,%ecx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100403:	b8 0e 00 00 00       	mov    $0xe,%eax
80100408:	89 e5                	mov    %esp,%ebp
8010040a:	57                   	push   %edi
8010040b:	bf d4 03 00 00       	mov    $0x3d4,%edi
80100410:	56                   	push   %esi
80100411:	89 fa                	mov    %edi,%edx
80100413:	53                   	push   %ebx
80100414:	83 ec 1c             	sub    $0x1c,%esp
80100417:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100418:	be d5 03 00 00       	mov    $0x3d5,%esi
8010041d:	89 f2                	mov    %esi,%edx
8010041f:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100420:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100423:	89 fa                	mov    %edi,%edx
80100425:	b8 0f 00 00 00       	mov    $0xf,%eax
8010042a:	c1 e3 08             	shl    $0x8,%ebx
8010042d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010042e:	89 f2                	mov    %esi,%edx
80100430:	ec                   	in     (%dx),%al
  pos |= inb(CRTPORT+1);
80100431:	0f b6 c0             	movzbl %al,%eax
80100434:	09 d8                	or     %ebx,%eax
  if(c == '\n'){
80100436:	83 f9 0a             	cmp    $0xa,%ecx
80100439:	0f 84 91 00 00 00    	je     801004d0 <cgaputc+0xd0>
  else if(c == BACKSPACE){
8010043f:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
80100445:	74 71                	je     801004b8 <cgaputc+0xb8>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100447:	0f b6 c9             	movzbl %cl,%ecx
8010044a:	8d 58 01             	lea    0x1(%eax),%ebx
8010044d:	80 cd 07             	or     $0x7,%ch
80100450:	66 89 8c 00 00 80 0b 	mov    %cx,-0x7ff48000(%eax,%eax,1)
80100457:	80 
  if(pos < 0 || pos > 25*80)
80100458:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010045e:	0f 8f de 00 00 00    	jg     80100542 <cgaputc+0x142>
  if((pos/80) >= 24){  // Scroll up.
80100464:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
8010046a:	0f 8f 90 00 00 00    	jg     80100500 <cgaputc+0x100>
  outb(CRTPORT+1, pos>>8);
80100470:	0f b6 c7             	movzbl %bh,%eax
  outb(CRTPORT+1, pos);
80100473:	89 df                	mov    %ebx,%edi
  crt[pos] = ' ' | 0x0700;
80100475:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
  outb(CRTPORT+1, pos>>8);
8010047c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010047f:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100484:	b8 0e 00 00 00       	mov    $0xe,%eax
80100489:	89 da                	mov    %ebx,%edx
8010048b:	ee                   	out    %al,(%dx)
8010048c:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100491:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
80100495:	89 ca                	mov    %ecx,%edx
80100497:	ee                   	out    %al,(%dx)
80100498:	b8 0f 00 00 00       	mov    $0xf,%eax
8010049d:	89 da                	mov    %ebx,%edx
8010049f:	ee                   	out    %al,(%dx)
801004a0:	89 f8                	mov    %edi,%eax
801004a2:	89 ca                	mov    %ecx,%edx
801004a4:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004a5:	b8 20 07 00 00       	mov    $0x720,%eax
801004aa:	66 89 06             	mov    %ax,(%esi)
}
801004ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004b0:	5b                   	pop    %ebx
801004b1:	5e                   	pop    %esi
801004b2:	5f                   	pop    %edi
801004b3:	5d                   	pop    %ebp
801004b4:	c3                   	ret
801004b5:	8d 76 00             	lea    0x0(%esi),%esi
    if(pos > 0) --pos;
801004b8:	8d 58 ff             	lea    -0x1(%eax),%ebx
801004bb:	85 c0                	test   %eax,%eax
801004bd:	75 99                	jne    80100458 <cgaputc+0x58>
801004bf:	c6 45 e4 00          	movb   $0x0,-0x1c(%ebp)
801004c3:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004c8:	31 ff                	xor    %edi,%edi
801004ca:	eb b3                	jmp    8010047f <cgaputc+0x7f>
801004cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if (input.buf[input.r % INPUT_BUF] != '!') {
801004d0:	8b 15 00 ef 10 80    	mov    0x8010ef00,%edx
  pos |= inb(CRTPORT+1);
801004d6:	89 c3                	mov    %eax,%ebx
    if (input.buf[input.r % INPUT_BUF] != '!') {
801004d8:	83 e2 7f             	and    $0x7f,%edx
801004db:	80 ba 80 ee 10 80 21 	cmpb   $0x21,-0x7fef1180(%edx)
801004e2:	0f 84 70 ff ff ff    	je     80100458 <cgaputc+0x58>
      pos += 80 - pos % 80;  // Move to the next line.
801004e8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004ed:	f7 e2                	mul    %edx
801004ef:	c1 ea 06             	shr    $0x6,%edx
801004f2:	8d 04 92             	lea    (%edx,%edx,4),%eax
801004f5:	c1 e0 04             	shl    $0x4,%eax
801004f8:	8d 58 50             	lea    0x50(%eax),%ebx
801004fb:	e9 58 ff ff ff       	jmp    80100458 <cgaputc+0x58>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100500:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
80100503:	8d 7b b0             	lea    -0x50(%ebx),%edi
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100506:	8d b4 1b 60 7f 0b 80 	lea    -0x7ff480a0(%ebx,%ebx,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010050d:	68 60 0e 00 00       	push   $0xe60
80100512:	68 a0 80 0b 80       	push   $0x800b80a0
80100517:	68 00 80 0b 80       	push   $0x800b8000
8010051c:	e8 ef 43 00 00       	call   80104910 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100521:	b8 80 07 00 00       	mov    $0x780,%eax
80100526:	83 c4 0c             	add    $0xc,%esp
80100529:	29 f8                	sub    %edi,%eax
8010052b:	01 c0                	add    %eax,%eax
8010052d:	50                   	push   %eax
8010052e:	6a 00                	push   $0x0
80100530:	56                   	push   %esi
80100531:	e8 4a 43 00 00       	call   80104880 <memset>
  outb(CRTPORT+1, pos);
80100536:	83 c4 10             	add    $0x10,%esp
80100539:	c6 45 e4 07          	movb   $0x7,-0x1c(%ebp)
8010053d:	e9 3d ff ff ff       	jmp    8010047f <cgaputc+0x7f>
    panic("pos under/overflow");
80100542:	83 ec 0c             	sub    $0xc,%esp
80100545:	68 85 73 10 80       	push   $0x80107385
8010054a:	e8 31 fe ff ff       	call   80100380 <panic>
8010054f:	90                   	nop

80100550 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100550:	55                   	push   %ebp
80100551:	89 e5                	mov    %esp,%ebp
80100553:	57                   	push   %edi
80100554:	56                   	push   %esi
80100555:	53                   	push   %ebx
80100556:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100559:	ff 75 08             	push   0x8(%ebp)
8010055c:	e8 ff 14 00 00       	call   80101a60 <iunlock>
  acquire(&cons.lock);
80100561:	c7 04 24 20 ef 10 80 	movl   $0x8010ef20,(%esp)
80100568:	e8 13 42 00 00       	call   80104780 <acquire>
  for(i = 0; i < n; i++)
8010056d:	8b 4d 10             	mov    0x10(%ebp),%ecx
80100570:	83 c4 10             	add    $0x10,%esp
80100573:	85 c9                	test   %ecx,%ecx
80100575:	7e 36                	jle    801005ad <consolewrite+0x5d>
80100577:	8b 5d 0c             	mov    0xc(%ebp),%ebx
8010057a:	8b 7d 10             	mov    0x10(%ebp),%edi
8010057d:	01 df                	add    %ebx,%edi
  if (panicked) {
8010057f:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
    consputc(buf[i] & 0xff);
80100585:	0f b6 03             	movzbl (%ebx),%eax
  if (panicked) {
80100588:	85 d2                	test   %edx,%edx
8010058a:	74 04                	je     80100590 <consolewrite+0x40>
  asm volatile("cli");
8010058c:	fa                   	cli
    for (;;) ;
8010058d:	eb fe                	jmp    8010058d <consolewrite+0x3d>
8010058f:	90                   	nop
    uartputc(c);
80100590:	83 ec 0c             	sub    $0xc,%esp
    consputc(buf[i] & 0xff);
80100593:	0f b6 f0             	movzbl %al,%esi
  for(i = 0; i < n; i++)
80100596:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100599:	56                   	push   %esi
8010059a:	e8 f1 58 00 00       	call   80105e90 <uartputc>
    cgaputc(c);
8010059f:	89 f0                	mov    %esi,%eax
801005a1:	e8 5a fe ff ff       	call   80100400 <cgaputc>
  for(i = 0; i < n; i++)
801005a6:	83 c4 10             	add    $0x10,%esp
801005a9:	39 fb                	cmp    %edi,%ebx
801005ab:	75 d2                	jne    8010057f <consolewrite+0x2f>
  release(&cons.lock);
801005ad:	83 ec 0c             	sub    $0xc,%esp
801005b0:	68 20 ef 10 80       	push   $0x8010ef20
801005b5:	e8 66 41 00 00       	call   80104720 <release>
  ilock(ip);
801005ba:	58                   	pop    %eax
801005bb:	ff 75 08             	push   0x8(%ebp)
801005be:	e8 bd 13 00 00       	call   80101980 <ilock>

  return n;
}
801005c3:	8b 45 10             	mov    0x10(%ebp),%eax
801005c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801005c9:	5b                   	pop    %ebx
801005ca:	5e                   	pop    %esi
801005cb:	5f                   	pop    %edi
801005cc:	5d                   	pop    %ebp
801005cd:	c3                   	ret
801005ce:	66 90                	xchg   %ax,%ax

801005d0 <printint>:
{
801005d0:	55                   	push   %ebp
801005d1:	89 e5                	mov    %esp,%ebp
801005d3:	57                   	push   %edi
801005d4:	56                   	push   %esi
801005d5:	53                   	push   %ebx
801005d6:	89 d3                	mov    %edx,%ebx
801005d8:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
801005db:	85 c0                	test   %eax,%eax
801005dd:	79 05                	jns    801005e4 <printint+0x14>
801005df:	83 e1 01             	and    $0x1,%ecx
801005e2:	75 6a                	jne    8010064e <printint+0x7e>
    x = xx;
801005e4:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
801005eb:	89 c1                	mov    %eax,%ecx
  i = 0;
801005ed:	31 f6                	xor    %esi,%esi
801005ef:	90                   	nop
    buf[i++] = digits[x % base];
801005f0:	89 c8                	mov    %ecx,%eax
801005f2:	31 d2                	xor    %edx,%edx
801005f4:	89 f7                	mov    %esi,%edi
801005f6:	f7 f3                	div    %ebx
801005f8:	8d 76 01             	lea    0x1(%esi),%esi
801005fb:	0f b6 92 40 78 10 80 	movzbl -0x7fef87c0(%edx),%edx
80100602:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
80100606:	89 ca                	mov    %ecx,%edx
80100608:	89 c1                	mov    %eax,%ecx
8010060a:	39 da                	cmp    %ebx,%edx
8010060c:	73 e2                	jae    801005f0 <printint+0x20>
  if(sign)
8010060e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100611:	85 d2                	test   %edx,%edx
80100613:	74 07                	je     8010061c <printint+0x4c>
    buf[i++] = '-';
80100615:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
  while(--i >= 0)
8010061a:	89 f7                	mov    %esi,%edi
8010061c:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010061f:	01 f7                	add    %esi,%edi
  if (panicked) {
80100621:	a1 58 ef 10 80       	mov    0x8010ef58,%eax
    consputc(buf[i]);
80100626:	0f be 1f             	movsbl (%edi),%ebx
  if (panicked) {
80100629:	85 c0                	test   %eax,%eax
8010062b:	74 03                	je     80100630 <printint+0x60>
8010062d:	fa                   	cli
    for (;;) ;
8010062e:	eb fe                	jmp    8010062e <printint+0x5e>
    uartputc(c);
80100630:	83 ec 0c             	sub    $0xc,%esp
80100633:	53                   	push   %ebx
80100634:	e8 57 58 00 00       	call   80105e90 <uartputc>
    cgaputc(c);
80100639:	89 d8                	mov    %ebx,%eax
8010063b:	e8 c0 fd ff ff       	call   80100400 <cgaputc>
  while(--i >= 0)
80100640:	8d 47 ff             	lea    -0x1(%edi),%eax
80100643:	83 c4 10             	add    $0x10,%esp
80100646:	39 f7                	cmp    %esi,%edi
80100648:	74 11                	je     8010065b <printint+0x8b>
8010064a:	89 c7                	mov    %eax,%edi
8010064c:	eb d3                	jmp    80100621 <printint+0x51>
    x = -xx;
8010064e:	f7 d8                	neg    %eax
  if(sign && (sign = xx < 0))
80100650:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    x = -xx;
80100657:	89 c1                	mov    %eax,%ecx
80100659:	eb 92                	jmp    801005ed <printint+0x1d>
}
8010065b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010065e:	5b                   	pop    %ebx
8010065f:	5e                   	pop    %esi
80100660:	5f                   	pop    %edi
80100661:	5d                   	pop    %ebp
80100662:	c3                   	ret
80100663:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010066a:	00 
8010066b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80100670 <cprintf>:
{
80100670:	55                   	push   %ebp
80100671:	89 e5                	mov    %esp,%ebp
80100673:	57                   	push   %edi
80100674:	56                   	push   %esi
80100675:	53                   	push   %ebx
80100676:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100679:	8b 3d 54 ef 10 80    	mov    0x8010ef54,%edi
  if (fmt == 0)
8010067f:	8b 75 08             	mov    0x8(%ebp),%esi
  if(locking)
80100682:	85 ff                	test   %edi,%edi
80100684:	0f 85 36 01 00 00    	jne    801007c0 <cprintf+0x150>
  if (fmt == 0)
8010068a:	85 f6                	test   %esi,%esi
8010068c:	0f 84 1c 02 00 00    	je     801008ae <cprintf+0x23e>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100692:	0f b6 06             	movzbl (%esi),%eax
80100695:	85 c0                	test   %eax,%eax
80100697:	74 67                	je     80100700 <cprintf+0x90>
  argp = (uint*)(void*)(&fmt + 1);
80100699:	8d 55 0c             	lea    0xc(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010069c:	89 7d e4             	mov    %edi,-0x1c(%ebp)
8010069f:	31 db                	xor    %ebx,%ebx
801006a1:	89 d7                	mov    %edx,%edi
    if(c != '%'){
801006a3:	83 f8 25             	cmp    $0x25,%eax
801006a6:	75 68                	jne    80100710 <cprintf+0xa0>
    c = fmt[++i] & 0xff;
801006a8:	83 c3 01             	add    $0x1,%ebx
801006ab:	0f b6 0c 1e          	movzbl (%esi,%ebx,1),%ecx
    if(c == 0)
801006af:	85 c9                	test   %ecx,%ecx
801006b1:	74 42                	je     801006f5 <cprintf+0x85>
    switch(c){
801006b3:	83 f9 70             	cmp    $0x70,%ecx
801006b6:	0f 84 e4 00 00 00    	je     801007a0 <cprintf+0x130>
801006bc:	0f 8f 8e 00 00 00    	jg     80100750 <cprintf+0xe0>
801006c2:	83 f9 25             	cmp    $0x25,%ecx
801006c5:	74 72                	je     80100739 <cprintf+0xc9>
801006c7:	83 f9 64             	cmp    $0x64,%ecx
801006ca:	0f 85 8e 00 00 00    	jne    8010075e <cprintf+0xee>
      printint(*argp++, 10, 1);
801006d0:	8d 47 04             	lea    0x4(%edi),%eax
801006d3:	b9 01 00 00 00       	mov    $0x1,%ecx
801006d8:	ba 0a 00 00 00       	mov    $0xa,%edx
801006dd:	89 45 e0             	mov    %eax,-0x20(%ebp)
801006e0:	8b 07                	mov    (%edi),%eax
801006e2:	e8 e9 fe ff ff       	call   801005d0 <printint>
801006e7:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006ea:	83 c3 01             	add    $0x1,%ebx
801006ed:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801006f1:	85 c0                	test   %eax,%eax
801006f3:	75 ae                	jne    801006a3 <cprintf+0x33>
801006f5:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  if(locking)
801006f8:	85 ff                	test   %edi,%edi
801006fa:	0f 85 e3 00 00 00    	jne    801007e3 <cprintf+0x173>
}
80100700:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100703:	5b                   	pop    %ebx
80100704:	5e                   	pop    %esi
80100705:	5f                   	pop    %edi
80100706:	5d                   	pop    %ebp
80100707:	c3                   	ret
80100708:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010070f:	00 
  if (panicked) {
80100710:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
80100716:	85 d2                	test   %edx,%edx
80100718:	74 06                	je     80100720 <cprintf+0xb0>
8010071a:	fa                   	cli
    for (;;) ;
8010071b:	eb fe                	jmp    8010071b <cprintf+0xab>
8010071d:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(c);
80100720:	83 ec 0c             	sub    $0xc,%esp
80100723:	50                   	push   %eax
80100724:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100727:	e8 64 57 00 00       	call   80105e90 <uartputc>
    cgaputc(c);
8010072c:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010072f:	e8 cc fc ff ff       	call   80100400 <cgaputc>
      continue;
80100734:	83 c4 10             	add    $0x10,%esp
80100737:	eb b1                	jmp    801006ea <cprintf+0x7a>
  if (panicked) {
80100739:	8b 0d 58 ef 10 80    	mov    0x8010ef58,%ecx
8010073f:	85 c9                	test   %ecx,%ecx
80100741:	0f 84 f9 00 00 00    	je     80100840 <cprintf+0x1d0>
80100747:	fa                   	cli
    for (;;) ;
80100748:	eb fe                	jmp    80100748 <cprintf+0xd8>
8010074a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    switch(c){
80100750:	83 f9 73             	cmp    $0x73,%ecx
80100753:	0f 84 9f 00 00 00    	je     801007f8 <cprintf+0x188>
80100759:	83 f9 78             	cmp    $0x78,%ecx
8010075c:	74 42                	je     801007a0 <cprintf+0x130>
  if (panicked) {
8010075e:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
80100764:	85 d2                	test   %edx,%edx
80100766:	0f 85 d0 00 00 00    	jne    8010083c <cprintf+0x1cc>
    uartputc(c);
8010076c:	83 ec 0c             	sub    $0xc,%esp
8010076f:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100772:	6a 25                	push   $0x25
80100774:	e8 17 57 00 00       	call   80105e90 <uartputc>
    cgaputc(c);
80100779:	b8 25 00 00 00       	mov    $0x25,%eax
8010077e:	e8 7d fc ff ff       	call   80100400 <cgaputc>
  if (panicked) {
80100783:	a1 58 ef 10 80       	mov    0x8010ef58,%eax
80100788:	83 c4 10             	add    $0x10,%esp
8010078b:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010078e:	85 c0                	test   %eax,%eax
80100790:	0f 84 f5 00 00 00    	je     8010088b <cprintf+0x21b>
80100796:	fa                   	cli
    for (;;) ;
80100797:	eb fe                	jmp    80100797 <cprintf+0x127>
80100799:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      printint(*argp++, 16, 0);
801007a0:	8d 47 04             	lea    0x4(%edi),%eax
801007a3:	31 c9                	xor    %ecx,%ecx
801007a5:	ba 10 00 00 00       	mov    $0x10,%edx
801007aa:	89 45 e0             	mov    %eax,-0x20(%ebp)
801007ad:	8b 07                	mov    (%edi),%eax
801007af:	e8 1c fe ff ff       	call   801005d0 <printint>
801007b4:	8b 7d e0             	mov    -0x20(%ebp),%edi
      break;
801007b7:	e9 2e ff ff ff       	jmp    801006ea <cprintf+0x7a>
801007bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007c0:	83 ec 0c             	sub    $0xc,%esp
801007c3:	68 20 ef 10 80       	push   $0x8010ef20
801007c8:	e8 b3 3f 00 00       	call   80104780 <acquire>
  if (fmt == 0)
801007cd:	83 c4 10             	add    $0x10,%esp
801007d0:	85 f6                	test   %esi,%esi
801007d2:	0f 84 d6 00 00 00    	je     801008ae <cprintf+0x23e>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007d8:	0f b6 06             	movzbl (%esi),%eax
801007db:	85 c0                	test   %eax,%eax
801007dd:	0f 85 b6 fe ff ff    	jne    80100699 <cprintf+0x29>
    release(&cons.lock);
801007e3:	83 ec 0c             	sub    $0xc,%esp
801007e6:	68 20 ef 10 80       	push   $0x8010ef20
801007eb:	e8 30 3f 00 00       	call   80104720 <release>
801007f0:	83 c4 10             	add    $0x10,%esp
801007f3:	e9 08 ff ff ff       	jmp    80100700 <cprintf+0x90>
      if((s = (char*)*argp++) == 0)
801007f8:	8b 17                	mov    (%edi),%edx
801007fa:	8d 47 04             	lea    0x4(%edi),%eax
801007fd:	85 d2                	test   %edx,%edx
801007ff:	74 2f                	je     80100830 <cprintf+0x1c0>
      for(; *s; s++)
80100801:	0f b6 0a             	movzbl (%edx),%ecx
      if((s = (char*)*argp++) == 0)
80100804:	89 d7                	mov    %edx,%edi
      for(; *s; s++)
80100806:	84 c9                	test   %cl,%cl
80100808:	0f 84 99 00 00 00    	je     801008a7 <cprintf+0x237>
8010080e:	89 5d e0             	mov    %ebx,-0x20(%ebp)
80100811:	89 fb                	mov    %edi,%ebx
80100813:	89 f7                	mov    %esi,%edi
80100815:	89 45 dc             	mov    %eax,-0x24(%ebp)
80100818:	89 c8                	mov    %ecx,%eax
  if (panicked) {
8010081a:	8b 35 58 ef 10 80    	mov    0x8010ef58,%esi
80100820:	85 f6                	test   %esi,%esi
80100822:	74 38                	je     8010085c <cprintf+0x1ec>
80100824:	fa                   	cli
    for (;;) ;
80100825:	eb fe                	jmp    80100825 <cprintf+0x1b5>
80100827:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010082e:	00 
8010082f:	90                   	nop
80100830:	b9 28 00 00 00       	mov    $0x28,%ecx
        s = "(null)";
80100835:	bf 98 73 10 80       	mov    $0x80107398,%edi
8010083a:	eb d2                	jmp    8010080e <cprintf+0x19e>
8010083c:	fa                   	cli
    for (;;) ;
8010083d:	eb fe                	jmp    8010083d <cprintf+0x1cd>
8010083f:	90                   	nop
    uartputc(c);
80100840:	83 ec 0c             	sub    $0xc,%esp
80100843:	6a 25                	push   $0x25
80100845:	e8 46 56 00 00       	call   80105e90 <uartputc>
    cgaputc(c);
8010084a:	b8 25 00 00 00       	mov    $0x25,%eax
8010084f:	e8 ac fb ff ff       	call   80100400 <cgaputc>
}
80100854:	83 c4 10             	add    $0x10,%esp
80100857:	e9 8e fe ff ff       	jmp    801006ea <cprintf+0x7a>
    uartputc(c);
8010085c:	83 ec 0c             	sub    $0xc,%esp
        consputc(*s);
8010085f:	0f be f0             	movsbl %al,%esi
      for(; *s; s++)
80100862:	83 c3 01             	add    $0x1,%ebx
    uartputc(c);
80100865:	56                   	push   %esi
80100866:	e8 25 56 00 00       	call   80105e90 <uartputc>
    cgaputc(c);
8010086b:	89 f0                	mov    %esi,%eax
8010086d:	e8 8e fb ff ff       	call   80100400 <cgaputc>
      for(; *s; s++)
80100872:	0f b6 03             	movzbl (%ebx),%eax
80100875:	83 c4 10             	add    $0x10,%esp
80100878:	84 c0                	test   %al,%al
8010087a:	75 9e                	jne    8010081a <cprintf+0x1aa>
      if((s = (char*)*argp++) == 0)
8010087c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010087f:	89 fe                	mov    %edi,%esi
80100881:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80100884:	89 c7                	mov    %eax,%edi
80100886:	e9 5f fe ff ff       	jmp    801006ea <cprintf+0x7a>
    uartputc(c);
8010088b:	83 ec 0c             	sub    $0xc,%esp
8010088e:	51                   	push   %ecx
8010088f:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100892:	e8 f9 55 00 00       	call   80105e90 <uartputc>
    cgaputc(c);
80100897:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010089a:	e8 61 fb ff ff       	call   80100400 <cgaputc>
}
8010089f:	83 c4 10             	add    $0x10,%esp
801008a2:	e9 43 fe ff ff       	jmp    801006ea <cprintf+0x7a>
      if((s = (char*)*argp++) == 0)
801008a7:	89 c7                	mov    %eax,%edi
801008a9:	e9 3c fe ff ff       	jmp    801006ea <cprintf+0x7a>
    panic("null fmt");
801008ae:	83 ec 0c             	sub    $0xc,%esp
801008b1:	68 9f 73 10 80       	push   $0x8010739f
801008b6:	e8 c5 fa ff ff       	call   80100380 <panic>
801008bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801008c0 <consoleintr>:
{
801008c0:	55                   	push   %ebp
801008c1:	89 e5                	mov    %esp,%ebp
801008c3:	57                   	push   %edi
  int c, doprocdump = 0;
801008c4:	31 ff                	xor    %edi,%edi
{
801008c6:	56                   	push   %esi
801008c7:	53                   	push   %ebx
801008c8:	83 ec 18             	sub    $0x18,%esp
801008cb:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&cons.lock);
801008ce:	68 20 ef 10 80       	push   $0x8010ef20
801008d3:	e8 a8 3e 00 00       	call   80104780 <acquire>
  while((c = getc()) >= 0){
801008d8:	83 c4 10             	add    $0x10,%esp
801008db:	ff d6                	call   *%esi
801008dd:	89 c3                	mov    %eax,%ebx
801008df:	85 c0                	test   %eax,%eax
801008e1:	78 22                	js     80100905 <consoleintr+0x45>
    switch(c){
801008e3:	83 fb 15             	cmp    $0x15,%ebx
801008e6:	74 40                	je     80100928 <consoleintr+0x68>
801008e8:	7f 76                	jg     80100960 <consoleintr+0xa0>
801008ea:	83 fb 08             	cmp    $0x8,%ebx
801008ed:	74 76                	je     80100965 <consoleintr+0xa5>
801008ef:	83 fb 10             	cmp    $0x10,%ebx
801008f2:	0f 85 98 01 00 00    	jne    80100a90 <consoleintr+0x1d0>
  while((c = getc()) >= 0){
801008f8:	ff d6                	call   *%esi
    switch(c){
801008fa:	bf 01 00 00 00       	mov    $0x1,%edi
  while((c = getc()) >= 0){
801008ff:	89 c3                	mov    %eax,%ebx
80100901:	85 c0                	test   %eax,%eax
80100903:	79 de                	jns    801008e3 <consoleintr+0x23>
  release(&cons.lock);
80100905:	83 ec 0c             	sub    $0xc,%esp
80100908:	68 20 ef 10 80       	push   $0x8010ef20
8010090d:	e8 0e 3e 00 00       	call   80104720 <release>
  if(doprocdump) {
80100912:	83 c4 10             	add    $0x10,%esp
80100915:	85 ff                	test   %edi,%edi
80100917:	0f 85 3d 02 00 00    	jne    80100b5a <consoleintr+0x29a>
}
8010091d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100920:	5b                   	pop    %ebx
80100921:	5e                   	pop    %esi
80100922:	5f                   	pop    %edi
80100923:	5d                   	pop    %ebp
80100924:	c3                   	ret
80100925:	8d 76 00             	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100928:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
8010092d:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
80100933:	74 a6                	je     801008db <consoleintr+0x1b>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100935:	83 e8 01             	sub    $0x1,%eax
80100938:	89 c2                	mov    %eax,%edx
8010093a:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
8010093d:	80 ba 80 ee 10 80 0a 	cmpb   $0xa,-0x7fef1180(%edx)
80100944:	74 95                	je     801008db <consoleintr+0x1b>
        input.e--;
80100946:	a3 08 ef 10 80       	mov    %eax,0x8010ef08
  if (panicked) {
8010094b:	a1 58 ef 10 80       	mov    0x8010ef58,%eax
80100950:	85 c0                	test   %eax,%eax
80100952:	74 3c                	je     80100990 <consoleintr+0xd0>
80100954:	fa                   	cli
    for (;;) ;
80100955:	eb fe                	jmp    80100955 <consoleintr+0x95>
80100957:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010095e:	00 
8010095f:	90                   	nop
    switch(c){
80100960:	83 fb 7f             	cmp    $0x7f,%ebx
80100963:	75 73                	jne    801009d8 <consoleintr+0x118>
      if(input.e != input.w){
80100965:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
8010096a:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
80100970:	0f 84 65 ff ff ff    	je     801008db <consoleintr+0x1b>
  if (panicked) {
80100976:	8b 1d 58 ef 10 80    	mov    0x8010ef58,%ebx
        input.e--;
8010097c:	83 e8 01             	sub    $0x1,%eax
8010097f:	a3 08 ef 10 80       	mov    %eax,0x8010ef08
  if (panicked) {
80100984:	85 db                	test   %ebx,%ebx
80100986:	0f 84 9a 01 00 00    	je     80100b26 <consoleintr+0x266>
8010098c:	fa                   	cli
    for (;;) ;
8010098d:	eb fe                	jmp    8010098d <consoleintr+0xcd>
8010098f:	90                   	nop
    uartputc('\b');
80100990:	83 ec 0c             	sub    $0xc,%esp
80100993:	6a 08                	push   $0x8
80100995:	e8 f6 54 00 00       	call   80105e90 <uartputc>
    uartputc(' ');
8010099a:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801009a1:	e8 ea 54 00 00       	call   80105e90 <uartputc>
    uartputc('\b');
801009a6:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801009ad:	e8 de 54 00 00       	call   80105e90 <uartputc>
    cgaputc(c);
801009b2:	b8 00 01 00 00       	mov    $0x100,%eax
801009b7:	e8 44 fa ff ff       	call   80100400 <cgaputc>
      while(input.e != input.w &&
801009bc:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
801009c1:	83 c4 10             	add    $0x10,%esp
801009c4:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
801009ca:	0f 85 65 ff ff ff    	jne    80100935 <consoleintr+0x75>
801009d0:	e9 06 ff ff ff       	jmp    801008db <consoleintr+0x1b>
801009d5:	8d 76 00             	lea    0x0(%esi),%esi
      if(c != 0 && input.e-input.r < INPUT_BUF){
801009d8:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
801009dd:	89 c2                	mov    %eax,%edx
801009df:	2b 15 00 ef 10 80    	sub    0x8010ef00,%edx
801009e5:	83 fa 7f             	cmp    $0x7f,%edx
801009e8:	0f 87 ed fe ff ff    	ja     801008db <consoleintr+0x1b>
        input.buf[input.e++ % INPUT_BUF] = c;
801009ee:	8d 50 01             	lea    0x1(%eax),%edx
801009f1:	83 e0 7f             	and    $0x7f,%eax
801009f4:	88 98 80 ee 10 80    	mov    %bl,-0x7fef1180(%eax)
  if (panicked) {
801009fa:	a1 58 ef 10 80       	mov    0x8010ef58,%eax
        input.buf[input.e++ % INPUT_BUF] = c;
801009ff:	89 15 08 ef 10 80    	mov    %edx,0x8010ef08
  if (panicked) {
80100a05:	85 c0                	test   %eax,%eax
80100a07:	0f 85 63 01 00 00    	jne    80100b70 <consoleintr+0x2b0>
  if (c == BACKSPACE) {
80100a0d:	81 fb 00 01 00 00    	cmp    $0x100,%ebx
80100a13:	0f 85 5f 01 00 00    	jne    80100b78 <consoleintr+0x2b8>
    uartputc('\b');
80100a19:	83 ec 0c             	sub    $0xc,%esp
80100a1c:	6a 08                	push   $0x8
80100a1e:	e8 6d 54 00 00       	call   80105e90 <uartputc>
    uartputc(' ');
80100a23:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100a2a:	e8 61 54 00 00       	call   80105e90 <uartputc>
    uartputc('\b');
80100a2f:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100a36:	e8 55 54 00 00       	call   80105e90 <uartputc>
    cgaputc(c);
80100a3b:	b8 00 01 00 00       	mov    $0x100,%eax
80100a40:	e8 bb f9 ff ff       	call   80100400 <cgaputc>
80100a45:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100a48:	8b 15 00 ef 10 80    	mov    0x8010ef00,%edx
80100a4e:	8d 82 80 00 00 00    	lea    0x80(%edx),%eax
80100a54:	39 05 08 ef 10 80    	cmp    %eax,0x8010ef08
80100a5a:	0f 85 7b fe ff ff    	jne    801008db <consoleintr+0x1b>
          if (input.buf[input.r % INPUT_BUF] == '!') {
80100a60:	83 e2 7f             	and    $0x7f,%edx
80100a63:	80 ba 80 ee 10 80 21 	cmpb   $0x21,-0x7fef1180(%edx)
80100a6a:	0f 85 9c 00 00 00    	jne    80100b0c <consoleintr+0x24c>
  if (panicked) {
80100a70:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
              input.e--;
80100a76:	83 e8 01             	sub    $0x1,%eax
80100a79:	a3 08 ef 10 80       	mov    %eax,0x8010ef08
  if (panicked) {
80100a7e:	85 d2                	test   %edx,%edx
80100a80:	0f 84 23 01 00 00    	je     80100ba9 <consoleintr+0x2e9>
80100a86:	fa                   	cli
    for (;;) ;
80100a87:	eb fe                	jmp    80100a87 <consoleintr+0x1c7>
80100a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100a90:	85 db                	test   %ebx,%ebx
80100a92:	0f 84 43 fe ff ff    	je     801008db <consoleintr+0x1b>
80100a98:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100a9d:	89 c2                	mov    %eax,%edx
80100a9f:	2b 15 00 ef 10 80    	sub    0x8010ef00,%edx
80100aa5:	83 fa 7f             	cmp    $0x7f,%edx
80100aa8:	0f 87 2d fe ff ff    	ja     801008db <consoleintr+0x1b>
        input.buf[input.e++ % INPUT_BUF] = c;
80100aae:	8d 50 01             	lea    0x1(%eax),%edx
  if (panicked) {
80100ab1:	8b 0d 58 ef 10 80    	mov    0x8010ef58,%ecx
        input.buf[input.e++ % INPUT_BUF] = c;
80100ab7:	83 e0 7f             	and    $0x7f,%eax
80100aba:	89 15 08 ef 10 80    	mov    %edx,0x8010ef08
        c = (c == '\r') ? '\n' : c;
80100ac0:	83 fb 0d             	cmp    $0xd,%ebx
80100ac3:	0f 85 9d 00 00 00    	jne    80100b66 <consoleintr+0x2a6>
        input.buf[input.e++ % INPUT_BUF] = c;
80100ac9:	c6 80 80 ee 10 80 0a 	movb   $0xa,-0x7fef1180(%eax)
  if (panicked) {
80100ad0:	85 c9                	test   %ecx,%ecx
80100ad2:	0f 85 98 00 00 00    	jne    80100b70 <consoleintr+0x2b0>
    uartputc(c);
80100ad8:	83 ec 0c             	sub    $0xc,%esp
80100adb:	6a 0a                	push   $0xa
80100add:	e8 ae 53 00 00       	call   80105e90 <uartputc>
    cgaputc(c);
80100ae2:	b8 0a 00 00 00       	mov    $0xa,%eax
80100ae7:	e8 14 f9 ff ff       	call   80100400 <cgaputc>
          if (input.buf[input.r % INPUT_BUF] == '!') {
80100aec:	8b 15 00 ef 10 80    	mov    0x8010ef00,%edx
            while (input.e != input.r) {
80100af2:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100af7:	83 c4 10             	add    $0x10,%esp
          if (input.buf[input.r % INPUT_BUF] == '!') {
80100afa:	89 d1                	mov    %edx,%ecx
80100afc:	83 e1 7f             	and    $0x7f,%ecx
80100aff:	80 b9 80 ee 10 80 21 	cmpb   $0x21,-0x7fef1180(%ecx)
80100b06:	0f 84 f4 00 00 00    	je     80100c00 <consoleintr+0x340>
            wakeup(&input.r);
80100b0c:	83 ec 0c             	sub    $0xc,%esp
            input.w = input.e;
80100b0f:	a3 04 ef 10 80       	mov    %eax,0x8010ef04
            wakeup(&input.r);
80100b14:	68 00 ef 10 80       	push   $0x8010ef00
80100b19:	e8 a2 37 00 00       	call   801042c0 <wakeup>
80100b1e:	83 c4 10             	add    $0x10,%esp
80100b21:	e9 b5 fd ff ff       	jmp    801008db <consoleintr+0x1b>
    uartputc('\b');
80100b26:	83 ec 0c             	sub    $0xc,%esp
80100b29:	6a 08                	push   $0x8
80100b2b:	e8 60 53 00 00       	call   80105e90 <uartputc>
    uartputc(' ');
80100b30:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100b37:	e8 54 53 00 00       	call   80105e90 <uartputc>
    uartputc('\b');
80100b3c:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100b43:	e8 48 53 00 00       	call   80105e90 <uartputc>
    cgaputc(c);
80100b48:	b8 00 01 00 00       	mov    $0x100,%eax
80100b4d:	e8 ae f8 ff ff       	call   80100400 <cgaputc>
}
80100b52:	83 c4 10             	add    $0x10,%esp
80100b55:	e9 81 fd ff ff       	jmp    801008db <consoleintr+0x1b>
}
80100b5a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100b5d:	5b                   	pop    %ebx
80100b5e:	5e                   	pop    %esi
80100b5f:	5f                   	pop    %edi
80100b60:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100b61:	e9 3a 38 00 00       	jmp    801043a0 <procdump>
        input.buf[input.e++ % INPUT_BUF] = c;
80100b66:	88 98 80 ee 10 80    	mov    %bl,-0x7fef1180(%eax)
  if (panicked) {
80100b6c:	85 c9                	test   %ecx,%ecx
80100b6e:	74 08                	je     80100b78 <consoleintr+0x2b8>
80100b70:	fa                   	cli
    for (;;) ;
80100b71:	eb fe                	jmp    80100b71 <consoleintr+0x2b1>
80100b73:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    uartputc(c);
80100b78:	83 ec 0c             	sub    $0xc,%esp
80100b7b:	53                   	push   %ebx
80100b7c:	e8 0f 53 00 00       	call   80105e90 <uartputc>
    cgaputc(c);
80100b81:	89 d8                	mov    %ebx,%eax
80100b83:	e8 78 f8 ff ff       	call   80100400 <cgaputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100b88:	83 c4 10             	add    $0x10,%esp
80100b8b:	83 fb 0a             	cmp    $0xa,%ebx
80100b8e:	74 09                	je     80100b99 <consoleintr+0x2d9>
80100b90:	83 fb 04             	cmp    $0x4,%ebx
80100b93:	0f 85 af fe ff ff    	jne    80100a48 <consoleintr+0x188>
80100b99:	8b 15 00 ef 10 80    	mov    0x8010ef00,%edx
80100b9f:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100ba4:	e9 51 ff ff ff       	jmp    80100afa <consoleintr+0x23a>
    uartputc('\b');
80100ba9:	83 ec 0c             	sub    $0xc,%esp
80100bac:	6a 08                	push   $0x8
80100bae:	e8 dd 52 00 00       	call   80105e90 <uartputc>
    uartputc(' ');
80100bb3:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100bba:	e8 d1 52 00 00       	call   80105e90 <uartputc>
    uartputc('\b');
80100bbf:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100bc6:	e8 c5 52 00 00       	call   80105e90 <uartputc>
    cgaputc(c);
80100bcb:	b8 00 01 00 00       	mov    $0x100,%eax
80100bd0:	e8 2b f8 ff ff       	call   80100400 <cgaputc>
            while (input.e != input.r) {
80100bd5:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100bda:	83 c4 10             	add    $0x10,%esp
80100bdd:	3b 05 00 ef 10 80    	cmp    0x8010ef00,%eax
80100be3:	0f 85 87 fe ff ff    	jne    80100a70 <consoleintr+0x1b0>
  if (panicked) {
80100be9:	8b 0d 58 ef 10 80    	mov    0x8010ef58,%ecx
80100bef:	85 c9                	test   %ecx,%ecx
80100bf1:	74 17                	je     80100c0a <consoleintr+0x34a>
80100bf3:	fa                   	cli
    for (;;) ;
80100bf4:	eb fe                	jmp    80100bf4 <consoleintr+0x334>
80100bf6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100bfd:	00 
80100bfe:	66 90                	xchg   %ax,%ax
            while (input.e != input.r) {
80100c00:	39 c2                	cmp    %eax,%edx
80100c02:	0f 85 68 fe ff ff    	jne    80100a70 <consoleintr+0x1b0>
80100c08:	eb df                	jmp    80100be9 <consoleintr+0x329>
    uartputc(c);
80100c0a:	83 ec 0c             	sub    $0xc,%esp
80100c0d:	6a 20                	push   $0x20
80100c0f:	e8 7c 52 00 00       	call   80105e90 <uartputc>
    cgaputc(c);
80100c14:	b8 20 00 00 00       	mov    $0x20,%eax
80100c19:	e8 e2 f7 ff ff       	call   80100400 <cgaputc>
}
80100c1e:	83 c4 10             	add    $0x10,%esp
80100c21:	e9 b5 fc ff ff       	jmp    801008db <consoleintr+0x1b>
80100c26:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100c2d:	00 
80100c2e:	66 90                	xchg   %ax,%ax

80100c30 <consoleinit>:

void
consoleinit(void)
{
80100c30:	55                   	push   %ebp
80100c31:	89 e5                	mov    %esp,%ebp
80100c33:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100c36:	68 a8 73 10 80       	push   $0x801073a8
80100c3b:	68 20 ef 10 80       	push   $0x8010ef20
80100c40:	e8 4b 39 00 00       	call   80104590 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100c45:	58                   	pop    %eax
80100c46:	5a                   	pop    %edx
80100c47:	6a 00                	push   $0x0
80100c49:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100c4b:	c7 05 0c f9 10 80 50 	movl   $0x80100550,0x8010f90c
80100c52:	05 10 80 
  devsw[CONSOLE].read = consoleread;
80100c55:	c7 05 08 f9 10 80 80 	movl   $0x80100280,0x8010f908
80100c5c:	02 10 80 
  cons.locking = 1;
80100c5f:	c7 05 54 ef 10 80 01 	movl   $0x1,0x8010ef54
80100c66:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100c69:	e8 d2 19 00 00       	call   80102640 <ioapicenable>
}
80100c6e:	83 c4 10             	add    $0x10,%esp
80100c71:	c9                   	leave
80100c72:	c3                   	ret
80100c73:	66 90                	xchg   %ax,%ax
80100c75:	66 90                	xchg   %ax,%ax
80100c77:	66 90                	xchg   %ax,%ax
80100c79:	66 90                	xchg   %ax,%ax
80100c7b:	66 90                	xchg   %ax,%ax
80100c7d:	66 90                	xchg   %ax,%ax
80100c7f:	90                   	nop

80100c80 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100c80:	55                   	push   %ebp
80100c81:	89 e5                	mov    %esp,%ebp
80100c83:	57                   	push   %edi
80100c84:	56                   	push   %esi
80100c85:	53                   	push   %ebx
80100c86:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100c8c:	e8 af 2e 00 00       	call   80103b40 <myproc>
80100c91:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100c97:	e8 84 22 00 00       	call   80102f20 <begin_op>

  if((ip = namei(path)) == 0){
80100c9c:	83 ec 0c             	sub    $0xc,%esp
80100c9f:	ff 75 08             	push   0x8(%ebp)
80100ca2:	e8 b9 15 00 00       	call   80102260 <namei>
80100ca7:	83 c4 10             	add    $0x10,%esp
80100caa:	85 c0                	test   %eax,%eax
80100cac:	0f 84 30 03 00 00    	je     80100fe2 <exec+0x362>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100cb2:	83 ec 0c             	sub    $0xc,%esp
80100cb5:	89 c7                	mov    %eax,%edi
80100cb7:	50                   	push   %eax
80100cb8:	e8 c3 0c 00 00       	call   80101980 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100cbd:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100cc3:	6a 34                	push   $0x34
80100cc5:	6a 00                	push   $0x0
80100cc7:	50                   	push   %eax
80100cc8:	57                   	push   %edi
80100cc9:	e8 c2 0f 00 00       	call   80101c90 <readi>
80100cce:	83 c4 20             	add    $0x20,%esp
80100cd1:	83 f8 34             	cmp    $0x34,%eax
80100cd4:	0f 85 01 01 00 00    	jne    80100ddb <exec+0x15b>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100cda:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100ce1:	45 4c 46 
80100ce4:	0f 85 f1 00 00 00    	jne    80100ddb <exec+0x15b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100cea:	e8 11 63 00 00       	call   80107000 <setupkvm>
80100cef:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100cf5:	85 c0                	test   %eax,%eax
80100cf7:	0f 84 de 00 00 00    	je     80100ddb <exec+0x15b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100cfd:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100d04:	00 
80100d05:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100d0b:	0f 84 a1 02 00 00    	je     80100fb2 <exec+0x332>
  sz = 0;
80100d11:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100d18:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d1b:	31 db                	xor    %ebx,%ebx
80100d1d:	e9 8c 00 00 00       	jmp    80100dae <exec+0x12e>
80100d22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100d28:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100d2f:	75 6c                	jne    80100d9d <exec+0x11d>
      continue;
    if(ph.memsz < ph.filesz)
80100d31:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100d37:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100d3d:	0f 82 87 00 00 00    	jb     80100dca <exec+0x14a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100d43:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100d49:	72 7f                	jb     80100dca <exec+0x14a>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100d4b:	83 ec 04             	sub    $0x4,%esp
80100d4e:	50                   	push   %eax
80100d4f:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100d55:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d5b:	e8 d0 60 00 00       	call   80106e30 <allocuvm>
80100d60:	83 c4 10             	add    $0x10,%esp
80100d63:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100d69:	85 c0                	test   %eax,%eax
80100d6b:	74 5d                	je     80100dca <exec+0x14a>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100d6d:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100d73:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100d78:	75 50                	jne    80100dca <exec+0x14a>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100d7a:	83 ec 0c             	sub    $0xc,%esp
80100d7d:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100d83:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100d89:	57                   	push   %edi
80100d8a:	50                   	push   %eax
80100d8b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100d91:	e8 ca 5f 00 00       	call   80106d60 <loaduvm>
80100d96:	83 c4 20             	add    $0x20,%esp
80100d99:	85 c0                	test   %eax,%eax
80100d9b:	78 2d                	js     80100dca <exec+0x14a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d9d:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100da4:	83 c3 01             	add    $0x1,%ebx
80100da7:	83 c6 20             	add    $0x20,%esi
80100daa:	39 d8                	cmp    %ebx,%eax
80100dac:	7e 52                	jle    80100e00 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100dae:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100db4:	6a 20                	push   $0x20
80100db6:	56                   	push   %esi
80100db7:	50                   	push   %eax
80100db8:	57                   	push   %edi
80100db9:	e8 d2 0e 00 00       	call   80101c90 <readi>
80100dbe:	83 c4 10             	add    $0x10,%esp
80100dc1:	83 f8 20             	cmp    $0x20,%eax
80100dc4:	0f 84 5e ff ff ff    	je     80100d28 <exec+0xa8>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100dca:	83 ec 0c             	sub    $0xc,%esp
80100dcd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100dd3:	e8 a8 61 00 00       	call   80106f80 <freevm>
  if(ip){
80100dd8:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80100ddb:	83 ec 0c             	sub    $0xc,%esp
80100dde:	57                   	push   %edi
80100ddf:	e8 2c 0e 00 00       	call   80101c10 <iunlockput>
    end_op();
80100de4:	e8 a7 21 00 00       	call   80102f90 <end_op>
80100de9:	83 c4 10             	add    $0x10,%esp
    return -1;
80100dec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return -1;
}
80100df1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100df4:	5b                   	pop    %ebx
80100df5:	5e                   	pop    %esi
80100df6:	5f                   	pop    %edi
80100df7:	5d                   	pop    %ebp
80100df8:	c3                   	ret
80100df9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sz = PGROUNDUP(sz);
80100e00:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100e06:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100e0c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100e12:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
80100e18:	83 ec 0c             	sub    $0xc,%esp
80100e1b:	57                   	push   %edi
80100e1c:	e8 ef 0d 00 00       	call   80101c10 <iunlockput>
  end_op();
80100e21:	e8 6a 21 00 00       	call   80102f90 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100e26:	83 c4 0c             	add    $0xc,%esp
80100e29:	53                   	push   %ebx
80100e2a:	56                   	push   %esi
80100e2b:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100e31:	56                   	push   %esi
80100e32:	e8 f9 5f 00 00       	call   80106e30 <allocuvm>
80100e37:	83 c4 10             	add    $0x10,%esp
80100e3a:	89 c7                	mov    %eax,%edi
80100e3c:	85 c0                	test   %eax,%eax
80100e3e:	0f 84 86 00 00 00    	je     80100eca <exec+0x24a>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100e44:	83 ec 08             	sub    $0x8,%esp
80100e47:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  sp = sz;
80100e4d:	89 fb                	mov    %edi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100e4f:	50                   	push   %eax
80100e50:	56                   	push   %esi
  for(argc = 0; argv[argc]; argc++) {
80100e51:	31 f6                	xor    %esi,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100e53:	e8 48 62 00 00       	call   801070a0 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100e58:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e5b:	83 c4 10             	add    $0x10,%esp
80100e5e:	8b 10                	mov    (%eax),%edx
80100e60:	85 d2                	test   %edx,%edx
80100e62:	0f 84 56 01 00 00    	je     80100fbe <exec+0x33e>
80100e68:	89 bd f0 fe ff ff    	mov    %edi,-0x110(%ebp)
80100e6e:	8b 7d 0c             	mov    0xc(%ebp),%edi
80100e71:	eb 23                	jmp    80100e96 <exec+0x216>
80100e73:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100e78:	8d 46 01             	lea    0x1(%esi),%eax
    ustack[3+argc] = sp;
80100e7b:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
80100e82:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80100e88:	8b 14 87             	mov    (%edi,%eax,4),%edx
80100e8b:	85 d2                	test   %edx,%edx
80100e8d:	74 51                	je     80100ee0 <exec+0x260>
    if(argc >= MAXARG)
80100e8f:	83 f8 20             	cmp    $0x20,%eax
80100e92:	74 36                	je     80100eca <exec+0x24a>
80100e94:	89 c6                	mov    %eax,%esi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100e96:	83 ec 0c             	sub    $0xc,%esp
80100e99:	52                   	push   %edx
80100e9a:	e8 d1 3b 00 00       	call   80104a70 <strlen>
80100e9f:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100ea1:	58                   	pop    %eax
80100ea2:	ff 34 b7             	push   (%edi,%esi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100ea5:	83 eb 01             	sub    $0x1,%ebx
80100ea8:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100eab:	e8 c0 3b 00 00       	call   80104a70 <strlen>
80100eb0:	83 c0 01             	add    $0x1,%eax
80100eb3:	50                   	push   %eax
80100eb4:	ff 34 b7             	push   (%edi,%esi,4)
80100eb7:	53                   	push   %ebx
80100eb8:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100ebe:	e8 ad 63 00 00       	call   80107270 <copyout>
80100ec3:	83 c4 20             	add    $0x20,%esp
80100ec6:	85 c0                	test   %eax,%eax
80100ec8:	79 ae                	jns    80100e78 <exec+0x1f8>
    freevm(pgdir);
80100eca:	83 ec 0c             	sub    $0xc,%esp
80100ecd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100ed3:	e8 a8 60 00 00       	call   80106f80 <freevm>
80100ed8:	83 c4 10             	add    $0x10,%esp
80100edb:	e9 0c ff ff ff       	jmp    80100dec <exec+0x16c>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100ee0:	8d 14 b5 08 00 00 00 	lea    0x8(,%esi,4),%edx
  ustack[3+argc] = 0;
80100ee7:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100eed:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100ef3:	8d 46 04             	lea    0x4(%esi),%eax
  sp -= (3+argc+1) * 4;
80100ef6:	8d 72 0c             	lea    0xc(%edx),%esi
  ustack[3+argc] = 0;
80100ef9:	c7 84 85 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%eax,4)
80100f00:	00 00 00 00 
  ustack[1] = argc;
80100f04:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  ustack[0] = 0xffffffff;  // fake return PC
80100f0a:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100f11:	ff ff ff 
  ustack[1] = argc;
80100f14:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100f1a:	89 d8                	mov    %ebx,%eax
  sp -= (3+argc+1) * 4;
80100f1c:	29 f3                	sub    %esi,%ebx
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100f1e:	29 d0                	sub    %edx,%eax
80100f20:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100f26:	56                   	push   %esi
80100f27:	51                   	push   %ecx
80100f28:	53                   	push   %ebx
80100f29:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100f2f:	e8 3c 63 00 00       	call   80107270 <copyout>
80100f34:	83 c4 10             	add    $0x10,%esp
80100f37:	85 c0                	test   %eax,%eax
80100f39:	78 8f                	js     80100eca <exec+0x24a>
  for(last=s=path; *s; s++)
80100f3b:	8b 45 08             	mov    0x8(%ebp),%eax
80100f3e:	8b 55 08             	mov    0x8(%ebp),%edx
80100f41:	0f b6 00             	movzbl (%eax),%eax
80100f44:	84 c0                	test   %al,%al
80100f46:	74 17                	je     80100f5f <exec+0x2df>
80100f48:	89 d1                	mov    %edx,%ecx
80100f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      last = s+1;
80100f50:	83 c1 01             	add    $0x1,%ecx
80100f53:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100f55:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80100f58:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100f5b:	84 c0                	test   %al,%al
80100f5d:	75 f1                	jne    80100f50 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100f5f:	83 ec 04             	sub    $0x4,%esp
80100f62:	6a 10                	push   $0x10
80100f64:	52                   	push   %edx
80100f65:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80100f6b:	8d 46 6c             	lea    0x6c(%esi),%eax
80100f6e:	50                   	push   %eax
80100f6f:	e8 bc 3a 00 00       	call   80104a30 <safestrcpy>
  curproc->pgdir = pgdir;
80100f74:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100f7a:	89 f0                	mov    %esi,%eax
80100f7c:	8b 76 04             	mov    0x4(%esi),%esi
  curproc->sz = sz;
80100f7f:	89 38                	mov    %edi,(%eax)
  curproc->pgdir = pgdir;
80100f81:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100f84:	89 c1                	mov    %eax,%ecx
80100f86:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100f8c:	8b 40 18             	mov    0x18(%eax),%eax
80100f8f:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100f92:	8b 41 18             	mov    0x18(%ecx),%eax
80100f95:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100f98:	89 0c 24             	mov    %ecx,(%esp)
80100f9b:	e8 30 5c 00 00       	call   80106bd0 <switchuvm>
  freevm(oldpgdir);
80100fa0:	89 34 24             	mov    %esi,(%esp)
80100fa3:	e8 d8 5f 00 00       	call   80106f80 <freevm>
  return 0;
80100fa8:	83 c4 10             	add    $0x10,%esp
80100fab:	31 c0                	xor    %eax,%eax
80100fad:	e9 3f fe ff ff       	jmp    80100df1 <exec+0x171>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100fb2:	bb 00 20 00 00       	mov    $0x2000,%ebx
80100fb7:	31 f6                	xor    %esi,%esi
80100fb9:	e9 5a fe ff ff       	jmp    80100e18 <exec+0x198>
  for(argc = 0; argv[argc]; argc++) {
80100fbe:	be 10 00 00 00       	mov    $0x10,%esi
80100fc3:	ba 04 00 00 00       	mov    $0x4,%edx
80100fc8:	b8 03 00 00 00       	mov    $0x3,%eax
80100fcd:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100fd4:	00 00 00 
80100fd7:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100fdd:	e9 17 ff ff ff       	jmp    80100ef9 <exec+0x279>
    end_op();
80100fe2:	e8 a9 1f 00 00       	call   80102f90 <end_op>
    cprintf("exec: fail\n");
80100fe7:	83 ec 0c             	sub    $0xc,%esp
80100fea:	68 b0 73 10 80       	push   $0x801073b0
80100fef:	e8 7c f6 ff ff       	call   80100670 <cprintf>
    return -1;
80100ff4:	83 c4 10             	add    $0x10,%esp
80100ff7:	e9 f0 fd ff ff       	jmp    80100dec <exec+0x16c>
80100ffc:	66 90                	xchg   %ax,%ax
80100ffe:	66 90                	xchg   %ax,%ax

80101000 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101000:	55                   	push   %ebp
80101001:	89 e5                	mov    %esp,%ebp
80101003:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80101006:	68 bc 73 10 80       	push   $0x801073bc
8010100b:	68 60 ef 10 80       	push   $0x8010ef60
80101010:	e8 7b 35 00 00       	call   80104590 <initlock>
}
80101015:	83 c4 10             	add    $0x10,%esp
80101018:	c9                   	leave
80101019:	c3                   	ret
8010101a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101020 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101020:	55                   	push   %ebp
80101021:	89 e5                	mov    %esp,%ebp
80101023:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101024:	bb 94 ef 10 80       	mov    $0x8010ef94,%ebx
{
80101029:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
8010102c:	68 60 ef 10 80       	push   $0x8010ef60
80101031:	e8 4a 37 00 00       	call   80104780 <acquire>
80101036:	83 c4 10             	add    $0x10,%esp
80101039:	eb 10                	jmp    8010104b <filealloc+0x2b>
8010103b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101040:	83 c3 18             	add    $0x18,%ebx
80101043:	81 fb f4 f8 10 80    	cmp    $0x8010f8f4,%ebx
80101049:	74 25                	je     80101070 <filealloc+0x50>
    if(f->ref == 0){
8010104b:	8b 43 04             	mov    0x4(%ebx),%eax
8010104e:	85 c0                	test   %eax,%eax
80101050:	75 ee                	jne    80101040 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80101052:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80101055:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
8010105c:	68 60 ef 10 80       	push   $0x8010ef60
80101061:	e8 ba 36 00 00       	call   80104720 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80101066:	89 d8                	mov    %ebx,%eax
      return f;
80101068:	83 c4 10             	add    $0x10,%esp
}
8010106b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010106e:	c9                   	leave
8010106f:	c3                   	ret
  release(&ftable.lock);
80101070:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101073:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80101075:	68 60 ef 10 80       	push   $0x8010ef60
8010107a:	e8 a1 36 00 00       	call   80104720 <release>
}
8010107f:	89 d8                	mov    %ebx,%eax
  return 0;
80101081:	83 c4 10             	add    $0x10,%esp
}
80101084:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101087:	c9                   	leave
80101088:	c3                   	ret
80101089:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101090 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101090:	55                   	push   %ebp
80101091:	89 e5                	mov    %esp,%ebp
80101093:	53                   	push   %ebx
80101094:	83 ec 10             	sub    $0x10,%esp
80101097:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
8010109a:	68 60 ef 10 80       	push   $0x8010ef60
8010109f:	e8 dc 36 00 00       	call   80104780 <acquire>
  if(f->ref < 1)
801010a4:	8b 43 04             	mov    0x4(%ebx),%eax
801010a7:	83 c4 10             	add    $0x10,%esp
801010aa:	85 c0                	test   %eax,%eax
801010ac:	7e 1a                	jle    801010c8 <filedup+0x38>
    panic("filedup");
  f->ref++;
801010ae:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
801010b1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
801010b4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
801010b7:	68 60 ef 10 80       	push   $0x8010ef60
801010bc:	e8 5f 36 00 00       	call   80104720 <release>
  return f;
}
801010c1:	89 d8                	mov    %ebx,%eax
801010c3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801010c6:	c9                   	leave
801010c7:	c3                   	ret
    panic("filedup");
801010c8:	83 ec 0c             	sub    $0xc,%esp
801010cb:	68 c3 73 10 80       	push   $0x801073c3
801010d0:	e8 ab f2 ff ff       	call   80100380 <panic>
801010d5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801010dc:	00 
801010dd:	8d 76 00             	lea    0x0(%esi),%esi

801010e0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
801010e0:	55                   	push   %ebp
801010e1:	89 e5                	mov    %esp,%ebp
801010e3:	57                   	push   %edi
801010e4:	56                   	push   %esi
801010e5:	53                   	push   %ebx
801010e6:	83 ec 28             	sub    $0x28,%esp
801010e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
801010ec:	68 60 ef 10 80       	push   $0x8010ef60
801010f1:	e8 8a 36 00 00       	call   80104780 <acquire>
  if(f->ref < 1)
801010f6:	8b 53 04             	mov    0x4(%ebx),%edx
801010f9:	83 c4 10             	add    $0x10,%esp
801010fc:	85 d2                	test   %edx,%edx
801010fe:	0f 8e a5 00 00 00    	jle    801011a9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80101104:	83 ea 01             	sub    $0x1,%edx
80101107:	89 53 04             	mov    %edx,0x4(%ebx)
8010110a:	75 44                	jne    80101150 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
8010110c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101110:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80101113:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80101115:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
8010111b:	8b 73 0c             	mov    0xc(%ebx),%esi
8010111e:	88 45 e7             	mov    %al,-0x19(%ebp)
80101121:	8b 43 10             	mov    0x10(%ebx),%eax
80101124:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80101127:	68 60 ef 10 80       	push   $0x8010ef60
8010112c:	e8 ef 35 00 00       	call   80104720 <release>

  if(ff.type == FD_PIPE)
80101131:	83 c4 10             	add    $0x10,%esp
80101134:	83 ff 01             	cmp    $0x1,%edi
80101137:	74 57                	je     80101190 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80101139:	83 ff 02             	cmp    $0x2,%edi
8010113c:	74 2a                	je     80101168 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
8010113e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101141:	5b                   	pop    %ebx
80101142:	5e                   	pop    %esi
80101143:	5f                   	pop    %edi
80101144:	5d                   	pop    %ebp
80101145:	c3                   	ret
80101146:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010114d:	00 
8010114e:	66 90                	xchg   %ax,%ax
    release(&ftable.lock);
80101150:	c7 45 08 60 ef 10 80 	movl   $0x8010ef60,0x8(%ebp)
}
80101157:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010115a:	5b                   	pop    %ebx
8010115b:	5e                   	pop    %esi
8010115c:	5f                   	pop    %edi
8010115d:	5d                   	pop    %ebp
    release(&ftable.lock);
8010115e:	e9 bd 35 00 00       	jmp    80104720 <release>
80101163:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    begin_op();
80101168:	e8 b3 1d 00 00       	call   80102f20 <begin_op>
    iput(ff.ip);
8010116d:	83 ec 0c             	sub    $0xc,%esp
80101170:	ff 75 e0             	push   -0x20(%ebp)
80101173:	e8 38 09 00 00       	call   80101ab0 <iput>
    end_op();
80101178:	83 c4 10             	add    $0x10,%esp
}
8010117b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010117e:	5b                   	pop    %ebx
8010117f:	5e                   	pop    %esi
80101180:	5f                   	pop    %edi
80101181:	5d                   	pop    %ebp
    end_op();
80101182:	e9 09 1e 00 00       	jmp    80102f90 <end_op>
80101187:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010118e:	00 
8010118f:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
80101190:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101194:	83 ec 08             	sub    $0x8,%esp
80101197:	53                   	push   %ebx
80101198:	56                   	push   %esi
80101199:	e8 42 25 00 00       	call   801036e0 <pipeclose>
8010119e:	83 c4 10             	add    $0x10,%esp
}
801011a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011a4:	5b                   	pop    %ebx
801011a5:	5e                   	pop    %esi
801011a6:	5f                   	pop    %edi
801011a7:	5d                   	pop    %ebp
801011a8:	c3                   	ret
    panic("fileclose");
801011a9:	83 ec 0c             	sub    $0xc,%esp
801011ac:	68 cb 73 10 80       	push   $0x801073cb
801011b1:	e8 ca f1 ff ff       	call   80100380 <panic>
801011b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801011bd:	00 
801011be:	66 90                	xchg   %ax,%ax

801011c0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
801011c0:	55                   	push   %ebp
801011c1:	89 e5                	mov    %esp,%ebp
801011c3:	53                   	push   %ebx
801011c4:	83 ec 04             	sub    $0x4,%esp
801011c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
801011ca:	83 3b 02             	cmpl   $0x2,(%ebx)
801011cd:	75 31                	jne    80101200 <filestat+0x40>
    ilock(f->ip);
801011cf:	83 ec 0c             	sub    $0xc,%esp
801011d2:	ff 73 10             	push   0x10(%ebx)
801011d5:	e8 a6 07 00 00       	call   80101980 <ilock>
    stati(f->ip, st);
801011da:	58                   	pop    %eax
801011db:	5a                   	pop    %edx
801011dc:	ff 75 0c             	push   0xc(%ebp)
801011df:	ff 73 10             	push   0x10(%ebx)
801011e2:	e8 79 0a 00 00       	call   80101c60 <stati>
    iunlock(f->ip);
801011e7:	59                   	pop    %ecx
801011e8:	ff 73 10             	push   0x10(%ebx)
801011eb:	e8 70 08 00 00       	call   80101a60 <iunlock>
    return 0;
  }
  return -1;
}
801011f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
801011f3:	83 c4 10             	add    $0x10,%esp
801011f6:	31 c0                	xor    %eax,%eax
}
801011f8:	c9                   	leave
801011f9:	c3                   	ret
801011fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101200:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101203:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101208:	c9                   	leave
80101209:	c3                   	ret
8010120a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101210 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101210:	55                   	push   %ebp
80101211:	89 e5                	mov    %esp,%ebp
80101213:	57                   	push   %edi
80101214:	56                   	push   %esi
80101215:	53                   	push   %ebx
80101216:	83 ec 0c             	sub    $0xc,%esp
80101219:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010121c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010121f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101222:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101226:	74 60                	je     80101288 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101228:	8b 03                	mov    (%ebx),%eax
8010122a:	83 f8 01             	cmp    $0x1,%eax
8010122d:	74 41                	je     80101270 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010122f:	83 f8 02             	cmp    $0x2,%eax
80101232:	75 5b                	jne    8010128f <fileread+0x7f>
    ilock(f->ip);
80101234:	83 ec 0c             	sub    $0xc,%esp
80101237:	ff 73 10             	push   0x10(%ebx)
8010123a:	e8 41 07 00 00       	call   80101980 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010123f:	57                   	push   %edi
80101240:	ff 73 14             	push   0x14(%ebx)
80101243:	56                   	push   %esi
80101244:	ff 73 10             	push   0x10(%ebx)
80101247:	e8 44 0a 00 00       	call   80101c90 <readi>
8010124c:	83 c4 20             	add    $0x20,%esp
8010124f:	89 c6                	mov    %eax,%esi
80101251:	85 c0                	test   %eax,%eax
80101253:	7e 03                	jle    80101258 <fileread+0x48>
      f->off += r;
80101255:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101258:	83 ec 0c             	sub    $0xc,%esp
8010125b:	ff 73 10             	push   0x10(%ebx)
8010125e:	e8 fd 07 00 00       	call   80101a60 <iunlock>
    return r;
80101263:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101266:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101269:	89 f0                	mov    %esi,%eax
8010126b:	5b                   	pop    %ebx
8010126c:	5e                   	pop    %esi
8010126d:	5f                   	pop    %edi
8010126e:	5d                   	pop    %ebp
8010126f:	c3                   	ret
    return piperead(f->pipe, addr, n);
80101270:	8b 43 0c             	mov    0xc(%ebx),%eax
80101273:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101276:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101279:	5b                   	pop    %ebx
8010127a:	5e                   	pop    %esi
8010127b:	5f                   	pop    %edi
8010127c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010127d:	e9 1e 26 00 00       	jmp    801038a0 <piperead>
80101282:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101288:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010128d:	eb d7                	jmp    80101266 <fileread+0x56>
  panic("fileread");
8010128f:	83 ec 0c             	sub    $0xc,%esp
80101292:	68 d5 73 10 80       	push   $0x801073d5
80101297:	e8 e4 f0 ff ff       	call   80100380 <panic>
8010129c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801012a0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801012a0:	55                   	push   %ebp
801012a1:	89 e5                	mov    %esp,%ebp
801012a3:	57                   	push   %edi
801012a4:	56                   	push   %esi
801012a5:	53                   	push   %ebx
801012a6:	83 ec 1c             	sub    $0x1c,%esp
801012a9:	8b 45 0c             	mov    0xc(%ebp),%eax
801012ac:	8b 5d 08             	mov    0x8(%ebp),%ebx
801012af:	89 45 dc             	mov    %eax,-0x24(%ebp)
801012b2:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
801012b5:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
801012b9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801012bc:	0f 84 bb 00 00 00    	je     8010137d <filewrite+0xdd>
    return -1;
  if(f->type == FD_PIPE)
801012c2:	8b 03                	mov    (%ebx),%eax
801012c4:	83 f8 01             	cmp    $0x1,%eax
801012c7:	0f 84 bf 00 00 00    	je     8010138c <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801012cd:	83 f8 02             	cmp    $0x2,%eax
801012d0:	0f 85 c8 00 00 00    	jne    8010139e <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801012d6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801012d9:	31 f6                	xor    %esi,%esi
    while(i < n){
801012db:	85 c0                	test   %eax,%eax
801012dd:	7f 30                	jg     8010130f <filewrite+0x6f>
801012df:	e9 94 00 00 00       	jmp    80101378 <filewrite+0xd8>
801012e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801012e8:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
801012eb:	83 ec 0c             	sub    $0xc,%esp
        f->off += r;
801012ee:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801012f1:	ff 73 10             	push   0x10(%ebx)
801012f4:	e8 67 07 00 00       	call   80101a60 <iunlock>
      end_op();
801012f9:	e8 92 1c 00 00       	call   80102f90 <end_op>

      if(r < 0)
        break;
      if(r != n1)
801012fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101301:	83 c4 10             	add    $0x10,%esp
80101304:	39 c7                	cmp    %eax,%edi
80101306:	75 5c                	jne    80101364 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
80101308:	01 fe                	add    %edi,%esi
    while(i < n){
8010130a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010130d:	7e 69                	jle    80101378 <filewrite+0xd8>
      int n1 = n - i;
8010130f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      if(n1 > max)
80101312:	b8 00 06 00 00       	mov    $0x600,%eax
      int n1 = n - i;
80101317:	29 f7                	sub    %esi,%edi
      if(n1 > max)
80101319:	39 c7                	cmp    %eax,%edi
8010131b:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
8010131e:	e8 fd 1b 00 00       	call   80102f20 <begin_op>
      ilock(f->ip);
80101323:	83 ec 0c             	sub    $0xc,%esp
80101326:	ff 73 10             	push   0x10(%ebx)
80101329:	e8 52 06 00 00       	call   80101980 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010132e:	57                   	push   %edi
8010132f:	ff 73 14             	push   0x14(%ebx)
80101332:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101335:	01 f0                	add    %esi,%eax
80101337:	50                   	push   %eax
80101338:	ff 73 10             	push   0x10(%ebx)
8010133b:	e8 50 0a 00 00       	call   80101d90 <writei>
80101340:	83 c4 20             	add    $0x20,%esp
80101343:	85 c0                	test   %eax,%eax
80101345:	7f a1                	jg     801012e8 <filewrite+0x48>
80101347:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
8010134a:	83 ec 0c             	sub    $0xc,%esp
8010134d:	ff 73 10             	push   0x10(%ebx)
80101350:	e8 0b 07 00 00       	call   80101a60 <iunlock>
      end_op();
80101355:	e8 36 1c 00 00       	call   80102f90 <end_op>
      if(r < 0)
8010135a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010135d:	83 c4 10             	add    $0x10,%esp
80101360:	85 c0                	test   %eax,%eax
80101362:	75 14                	jne    80101378 <filewrite+0xd8>
        panic("short filewrite");
80101364:	83 ec 0c             	sub    $0xc,%esp
80101367:	68 de 73 10 80       	push   $0x801073de
8010136c:	e8 0f f0 ff ff       	call   80100380 <panic>
80101371:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80101378:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010137b:	74 05                	je     80101382 <filewrite+0xe2>
8010137d:	be ff ff ff ff       	mov    $0xffffffff,%esi
  }
  panic("filewrite");
}
80101382:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101385:	89 f0                	mov    %esi,%eax
80101387:	5b                   	pop    %ebx
80101388:	5e                   	pop    %esi
80101389:	5f                   	pop    %edi
8010138a:	5d                   	pop    %ebp
8010138b:	c3                   	ret
    return pipewrite(f->pipe, addr, n);
8010138c:	8b 43 0c             	mov    0xc(%ebx),%eax
8010138f:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101392:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101395:	5b                   	pop    %ebx
80101396:	5e                   	pop    %esi
80101397:	5f                   	pop    %edi
80101398:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101399:	e9 e2 23 00 00       	jmp    80103780 <pipewrite>
  panic("filewrite");
8010139e:	83 ec 0c             	sub    $0xc,%esp
801013a1:	68 e4 73 10 80       	push   $0x801073e4
801013a6:	e8 d5 ef ff ff       	call   80100380 <panic>
801013ab:	66 90                	xchg   %ax,%ax
801013ad:	66 90                	xchg   %ax,%ax
801013af:	90                   	nop

801013b0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801013b0:	55                   	push   %ebp
801013b1:	89 e5                	mov    %esp,%ebp
801013b3:	57                   	push   %edi
801013b4:	56                   	push   %esi
801013b5:	53                   	push   %ebx
801013b6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801013b9:	8b 0d b4 15 11 80    	mov    0x801115b4,%ecx
{
801013bf:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801013c2:	85 c9                	test   %ecx,%ecx
801013c4:	0f 84 8c 00 00 00    	je     80101456 <balloc+0xa6>
801013ca:	31 ff                	xor    %edi,%edi
    bp = bread(dev, BBLOCK(b, sb));
801013cc:	89 f8                	mov    %edi,%eax
801013ce:	83 ec 08             	sub    $0x8,%esp
801013d1:	89 fe                	mov    %edi,%esi
801013d3:	c1 f8 0c             	sar    $0xc,%eax
801013d6:	03 05 cc 15 11 80    	add    0x801115cc,%eax
801013dc:	50                   	push   %eax
801013dd:	ff 75 dc             	push   -0x24(%ebp)
801013e0:	e8 eb ec ff ff       	call   801000d0 <bread>
801013e5:	83 c4 10             	add    $0x10,%esp
801013e8:	89 7d d8             	mov    %edi,-0x28(%ebp)
801013eb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801013ee:	a1 b4 15 11 80       	mov    0x801115b4,%eax
801013f3:	89 45 e0             	mov    %eax,-0x20(%ebp)
801013f6:	31 c0                	xor    %eax,%eax
801013f8:	eb 32                	jmp    8010142c <balloc+0x7c>
801013fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101400:	89 c1                	mov    %eax,%ecx
80101402:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101407:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      m = 1 << (bi % 8);
8010140a:	83 e1 07             	and    $0x7,%ecx
8010140d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010140f:	89 c1                	mov    %eax,%ecx
80101411:	c1 f9 03             	sar    $0x3,%ecx
80101414:	0f b6 7c 0f 5c       	movzbl 0x5c(%edi,%ecx,1),%edi
80101419:	89 fa                	mov    %edi,%edx
8010141b:	85 df                	test   %ebx,%edi
8010141d:	74 49                	je     80101468 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010141f:	83 c0 01             	add    $0x1,%eax
80101422:	83 c6 01             	add    $0x1,%esi
80101425:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010142a:	74 07                	je     80101433 <balloc+0x83>
8010142c:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010142f:	39 d6                	cmp    %edx,%esi
80101431:	72 cd                	jb     80101400 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101433:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101436:	83 ec 0c             	sub    $0xc,%esp
80101439:	ff 75 e4             	push   -0x1c(%ebp)
  for(b = 0; b < sb.size; b += BPB){
8010143c:	81 c7 00 10 00 00    	add    $0x1000,%edi
    brelse(bp);
80101442:	e8 a9 ed ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
80101447:	83 c4 10             	add    $0x10,%esp
8010144a:	3b 3d b4 15 11 80    	cmp    0x801115b4,%edi
80101450:	0f 82 76 ff ff ff    	jb     801013cc <balloc+0x1c>
  }
  panic("balloc: out of blocks");
80101456:	83 ec 0c             	sub    $0xc,%esp
80101459:	68 ee 73 10 80       	push   $0x801073ee
8010145e:	e8 1d ef ff ff       	call   80100380 <panic>
80101463:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
80101468:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
8010146b:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
8010146e:	09 da                	or     %ebx,%edx
80101470:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
80101474:	57                   	push   %edi
80101475:	e8 86 1c 00 00       	call   80103100 <log_write>
        brelse(bp);
8010147a:	89 3c 24             	mov    %edi,(%esp)
8010147d:	e8 6e ed ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
80101482:	58                   	pop    %eax
80101483:	5a                   	pop    %edx
80101484:	56                   	push   %esi
80101485:	ff 75 dc             	push   -0x24(%ebp)
80101488:	e8 43 ec ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
8010148d:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101490:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101492:	8d 40 5c             	lea    0x5c(%eax),%eax
80101495:	68 00 02 00 00       	push   $0x200
8010149a:	6a 00                	push   $0x0
8010149c:	50                   	push   %eax
8010149d:	e8 de 33 00 00       	call   80104880 <memset>
  log_write(bp);
801014a2:	89 1c 24             	mov    %ebx,(%esp)
801014a5:	e8 56 1c 00 00       	call   80103100 <log_write>
  brelse(bp);
801014aa:	89 1c 24             	mov    %ebx,(%esp)
801014ad:	e8 3e ed ff ff       	call   801001f0 <brelse>
}
801014b2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014b5:	89 f0                	mov    %esi,%eax
801014b7:	5b                   	pop    %ebx
801014b8:	5e                   	pop    %esi
801014b9:	5f                   	pop    %edi
801014ba:	5d                   	pop    %ebp
801014bb:	c3                   	ret
801014bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801014c0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801014c0:	55                   	push   %ebp
801014c1:	89 e5                	mov    %esp,%ebp
801014c3:	57                   	push   %edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801014c4:	31 ff                	xor    %edi,%edi
{
801014c6:	56                   	push   %esi
801014c7:	89 c6                	mov    %eax,%esi
801014c9:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801014ca:	bb 94 f9 10 80       	mov    $0x8010f994,%ebx
{
801014cf:	83 ec 28             	sub    $0x28,%esp
801014d2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801014d5:	68 60 f9 10 80       	push   $0x8010f960
801014da:	e8 a1 32 00 00       	call   80104780 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801014df:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
801014e2:	83 c4 10             	add    $0x10,%esp
801014e5:	eb 1b                	jmp    80101502 <iget+0x42>
801014e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801014ee:	00 
801014ef:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801014f0:	39 33                	cmp    %esi,(%ebx)
801014f2:	74 6c                	je     80101560 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801014f4:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014fa:	81 fb b4 15 11 80    	cmp    $0x801115b4,%ebx
80101500:	74 26                	je     80101528 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101502:	8b 43 08             	mov    0x8(%ebx),%eax
80101505:	85 c0                	test   %eax,%eax
80101507:	7f e7                	jg     801014f0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101509:	85 ff                	test   %edi,%edi
8010150b:	75 e7                	jne    801014f4 <iget+0x34>
8010150d:	85 c0                	test   %eax,%eax
8010150f:	75 76                	jne    80101587 <iget+0xc7>
      empty = ip;
80101511:	89 df                	mov    %ebx,%edi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101513:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101519:	81 fb b4 15 11 80    	cmp    $0x801115b4,%ebx
8010151f:	75 e1                	jne    80101502 <iget+0x42>
80101521:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101528:	85 ff                	test   %edi,%edi
8010152a:	74 79                	je     801015a5 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010152c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010152f:	89 37                	mov    %esi,(%edi)
  ip->inum = inum;
80101531:	89 57 04             	mov    %edx,0x4(%edi)
  ip->ref = 1;
80101534:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
  ip->valid = 0;
8010153b:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
  release(&icache.lock);
80101542:	68 60 f9 10 80       	push   $0x8010f960
80101547:	e8 d4 31 00 00       	call   80104720 <release>

  return ip;
8010154c:	83 c4 10             	add    $0x10,%esp
}
8010154f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101552:	89 f8                	mov    %edi,%eax
80101554:	5b                   	pop    %ebx
80101555:	5e                   	pop    %esi
80101556:	5f                   	pop    %edi
80101557:	5d                   	pop    %ebp
80101558:	c3                   	ret
80101559:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101560:	39 53 04             	cmp    %edx,0x4(%ebx)
80101563:	75 8f                	jne    801014f4 <iget+0x34>
      ip->ref++;
80101565:	83 c0 01             	add    $0x1,%eax
      release(&icache.lock);
80101568:	83 ec 0c             	sub    $0xc,%esp
      return ip;
8010156b:	89 df                	mov    %ebx,%edi
      ip->ref++;
8010156d:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101570:	68 60 f9 10 80       	push   $0x8010f960
80101575:	e8 a6 31 00 00       	call   80104720 <release>
      return ip;
8010157a:	83 c4 10             	add    $0x10,%esp
}
8010157d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101580:	89 f8                	mov    %edi,%eax
80101582:	5b                   	pop    %ebx
80101583:	5e                   	pop    %esi
80101584:	5f                   	pop    %edi
80101585:	5d                   	pop    %ebp
80101586:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101587:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010158d:	81 fb b4 15 11 80    	cmp    $0x801115b4,%ebx
80101593:	74 10                	je     801015a5 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101595:	8b 43 08             	mov    0x8(%ebx),%eax
80101598:	85 c0                	test   %eax,%eax
8010159a:	0f 8f 50 ff ff ff    	jg     801014f0 <iget+0x30>
801015a0:	e9 68 ff ff ff       	jmp    8010150d <iget+0x4d>
    panic("iget: no inodes");
801015a5:	83 ec 0c             	sub    $0xc,%esp
801015a8:	68 04 74 10 80       	push   $0x80107404
801015ad:	e8 ce ed ff ff       	call   80100380 <panic>
801015b2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801015b9:	00 
801015ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801015c0 <bfree>:
{
801015c0:	55                   	push   %ebp
801015c1:	89 c1                	mov    %eax,%ecx
  bp = bread(dev, BBLOCK(b, sb));
801015c3:	89 d0                	mov    %edx,%eax
801015c5:	c1 e8 0c             	shr    $0xc,%eax
{
801015c8:	89 e5                	mov    %esp,%ebp
801015ca:	56                   	push   %esi
801015cb:	53                   	push   %ebx
  bp = bread(dev, BBLOCK(b, sb));
801015cc:	03 05 cc 15 11 80    	add    0x801115cc,%eax
{
801015d2:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
801015d4:	83 ec 08             	sub    $0x8,%esp
801015d7:	50                   	push   %eax
801015d8:	51                   	push   %ecx
801015d9:	e8 f2 ea ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
801015de:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801015e0:	c1 fb 03             	sar    $0x3,%ebx
801015e3:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
801015e6:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
801015e8:	83 e1 07             	and    $0x7,%ecx
801015eb:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
801015f0:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
801015f6:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
801015f8:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
801015fd:	85 c1                	test   %eax,%ecx
801015ff:	74 23                	je     80101624 <bfree+0x64>
  bp->data[bi/8] &= ~m;
80101601:	f7 d0                	not    %eax
  log_write(bp);
80101603:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101606:	21 c8                	and    %ecx,%eax
80101608:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010160c:	56                   	push   %esi
8010160d:	e8 ee 1a 00 00       	call   80103100 <log_write>
  brelse(bp);
80101612:	89 34 24             	mov    %esi,(%esp)
80101615:	e8 d6 eb ff ff       	call   801001f0 <brelse>
}
8010161a:	83 c4 10             	add    $0x10,%esp
8010161d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101620:	5b                   	pop    %ebx
80101621:	5e                   	pop    %esi
80101622:	5d                   	pop    %ebp
80101623:	c3                   	ret
    panic("freeing free block");
80101624:	83 ec 0c             	sub    $0xc,%esp
80101627:	68 14 74 10 80       	push   $0x80107414
8010162c:	e8 4f ed ff ff       	call   80100380 <panic>
80101631:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101638:	00 
80101639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101640 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101640:	55                   	push   %ebp
80101641:	89 e5                	mov    %esp,%ebp
80101643:	57                   	push   %edi
80101644:	56                   	push   %esi
80101645:	89 c6                	mov    %eax,%esi
80101647:	53                   	push   %ebx
80101648:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010164b:	83 fa 0b             	cmp    $0xb,%edx
8010164e:	0f 86 8c 00 00 00    	jbe    801016e0 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101654:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101657:	83 fb 7f             	cmp    $0x7f,%ebx
8010165a:	0f 87 a2 00 00 00    	ja     80101702 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101660:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101666:	85 c0                	test   %eax,%eax
80101668:	74 5e                	je     801016c8 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010166a:	83 ec 08             	sub    $0x8,%esp
8010166d:	50                   	push   %eax
8010166e:	ff 36                	push   (%esi)
80101670:	e8 5b ea ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101675:	83 c4 10             	add    $0x10,%esp
80101678:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010167c:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
8010167e:	8b 3b                	mov    (%ebx),%edi
80101680:	85 ff                	test   %edi,%edi
80101682:	74 1c                	je     801016a0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101684:	83 ec 0c             	sub    $0xc,%esp
80101687:	52                   	push   %edx
80101688:	e8 63 eb ff ff       	call   801001f0 <brelse>
8010168d:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101690:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101693:	89 f8                	mov    %edi,%eax
80101695:	5b                   	pop    %ebx
80101696:	5e                   	pop    %esi
80101697:	5f                   	pop    %edi
80101698:	5d                   	pop    %ebp
80101699:	c3                   	ret
8010169a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801016a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
801016a3:	8b 06                	mov    (%esi),%eax
801016a5:	e8 06 fd ff ff       	call   801013b0 <balloc>
      log_write(bp);
801016aa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801016ad:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801016b0:	89 03                	mov    %eax,(%ebx)
801016b2:	89 c7                	mov    %eax,%edi
      log_write(bp);
801016b4:	52                   	push   %edx
801016b5:	e8 46 1a 00 00       	call   80103100 <log_write>
801016ba:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801016bd:	83 c4 10             	add    $0x10,%esp
801016c0:	eb c2                	jmp    80101684 <bmap+0x44>
801016c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801016c8:	8b 06                	mov    (%esi),%eax
801016ca:	e8 e1 fc ff ff       	call   801013b0 <balloc>
801016cf:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801016d5:	eb 93                	jmp    8010166a <bmap+0x2a>
801016d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801016de:	00 
801016df:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
801016e0:	8d 5a 14             	lea    0x14(%edx),%ebx
801016e3:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
801016e7:	85 ff                	test   %edi,%edi
801016e9:	75 a5                	jne    80101690 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
801016eb:	8b 00                	mov    (%eax),%eax
801016ed:	e8 be fc ff ff       	call   801013b0 <balloc>
801016f2:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
801016f6:	89 c7                	mov    %eax,%edi
}
801016f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801016fb:	5b                   	pop    %ebx
801016fc:	89 f8                	mov    %edi,%eax
801016fe:	5e                   	pop    %esi
801016ff:	5f                   	pop    %edi
80101700:	5d                   	pop    %ebp
80101701:	c3                   	ret
  panic("bmap: out of range");
80101702:	83 ec 0c             	sub    $0xc,%esp
80101705:	68 27 74 10 80       	push   $0x80107427
8010170a:	e8 71 ec ff ff       	call   80100380 <panic>
8010170f:	90                   	nop

80101710 <readsb>:
{
80101710:	55                   	push   %ebp
80101711:	89 e5                	mov    %esp,%ebp
80101713:	56                   	push   %esi
80101714:	53                   	push   %ebx
80101715:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101718:	83 ec 08             	sub    $0x8,%esp
8010171b:	6a 01                	push   $0x1
8010171d:	ff 75 08             	push   0x8(%ebp)
80101720:	e8 ab e9 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101725:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101728:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010172a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010172d:	6a 1c                	push   $0x1c
8010172f:	50                   	push   %eax
80101730:	56                   	push   %esi
80101731:	e8 da 31 00 00       	call   80104910 <memmove>
  brelse(bp);
80101736:	83 c4 10             	add    $0x10,%esp
80101739:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010173c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010173f:	5b                   	pop    %ebx
80101740:	5e                   	pop    %esi
80101741:	5d                   	pop    %ebp
  brelse(bp);
80101742:	e9 a9 ea ff ff       	jmp    801001f0 <brelse>
80101747:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010174e:	00 
8010174f:	90                   	nop

80101750 <iinit>:
{
80101750:	55                   	push   %ebp
80101751:	89 e5                	mov    %esp,%ebp
80101753:	56                   	push   %esi
80101754:	53                   	push   %ebx
80101755:	8b 75 08             	mov    0x8(%ebp),%esi
80101758:	bb a0 f9 10 80       	mov    $0x8010f9a0,%ebx
  initlock(&icache.lock, "icache");
8010175d:	83 ec 08             	sub    $0x8,%esp
80101760:	68 3a 74 10 80       	push   $0x8010743a
80101765:	68 60 f9 10 80       	push   $0x8010f960
8010176a:	e8 21 2e 00 00       	call   80104590 <initlock>
  for(i = 0; i < NINODE; i++) {
8010176f:	83 c4 10             	add    $0x10,%esp
80101772:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    initsleeplock(&icache.inode[i].lock, "inode");
80101778:	83 ec 08             	sub    $0x8,%esp
8010177b:	68 41 74 10 80       	push   $0x80107441
80101780:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80101781:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
80101787:	e8 d4 2c 00 00       	call   80104460 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
8010178c:	83 c4 10             	add    $0x10,%esp
8010178f:	81 fb c0 15 11 80    	cmp    $0x801115c0,%ebx
80101795:	75 e1                	jne    80101778 <iinit+0x28>
  bp = bread(dev, 1);
80101797:	83 ec 08             	sub    $0x8,%esp
8010179a:	6a 01                	push   $0x1
8010179c:	56                   	push   %esi
8010179d:	e8 2e e9 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801017a2:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801017a5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801017a7:	8d 40 5c             	lea    0x5c(%eax),%eax
801017aa:	6a 1c                	push   $0x1c
801017ac:	50                   	push   %eax
801017ad:	68 b4 15 11 80       	push   $0x801115b4
801017b2:	e8 59 31 00 00       	call   80104910 <memmove>
  brelse(bp);
801017b7:	89 1c 24             	mov    %ebx,(%esp)
801017ba:	e8 31 ea ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801017bf:	ff 35 cc 15 11 80    	push   0x801115cc
801017c5:	ff 35 c8 15 11 80    	push   0x801115c8
801017cb:	ff 35 c4 15 11 80    	push   0x801115c4
801017d1:	ff 35 c0 15 11 80    	push   0x801115c0
801017d7:	ff 35 bc 15 11 80    	push   0x801115bc
801017dd:	ff 35 b8 15 11 80    	push   0x801115b8
801017e3:	ff 35 b4 15 11 80    	push   0x801115b4
801017e9:	68 54 78 10 80       	push   $0x80107854
801017ee:	e8 7d ee ff ff       	call   80100670 <cprintf>
  cprintf("\nMajid Sadeghinejad\nParsa Ahmadi Nav\nAria Azem\n\n");
801017f3:	83 c4 30             	add    $0x30,%esp
801017f6:	c7 45 08 a8 78 10 80 	movl   $0x801078a8,0x8(%ebp)
}
801017fd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101800:	5b                   	pop    %ebx
80101801:	5e                   	pop    %esi
80101802:	5d                   	pop    %ebp
  cprintf("\nMajid Sadeghinejad\nParsa Ahmadi Nav\nAria Azem\n\n");
80101803:	e9 68 ee ff ff       	jmp    80100670 <cprintf>
80101808:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010180f:	00 

80101810 <ialloc>:
{
80101810:	55                   	push   %ebp
80101811:	89 e5                	mov    %esp,%ebp
80101813:	57                   	push   %edi
80101814:	56                   	push   %esi
80101815:	53                   	push   %ebx
80101816:	83 ec 1c             	sub    $0x1c,%esp
80101819:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010181c:	83 3d bc 15 11 80 01 	cmpl   $0x1,0x801115bc
{
80101823:	8b 75 08             	mov    0x8(%ebp),%esi
80101826:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101829:	0f 86 91 00 00 00    	jbe    801018c0 <ialloc+0xb0>
8010182f:	bf 01 00 00 00       	mov    $0x1,%edi
80101834:	eb 21                	jmp    80101857 <ialloc+0x47>
80101836:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010183d:	00 
8010183e:	66 90                	xchg   %ax,%ax
    brelse(bp);
80101840:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101843:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101846:	53                   	push   %ebx
80101847:	e8 a4 e9 ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010184c:	83 c4 10             	add    $0x10,%esp
8010184f:	3b 3d bc 15 11 80    	cmp    0x801115bc,%edi
80101855:	73 69                	jae    801018c0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101857:	89 f8                	mov    %edi,%eax
80101859:	83 ec 08             	sub    $0x8,%esp
8010185c:	c1 e8 03             	shr    $0x3,%eax
8010185f:	03 05 c8 15 11 80    	add    0x801115c8,%eax
80101865:	50                   	push   %eax
80101866:	56                   	push   %esi
80101867:	e8 64 e8 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010186c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010186f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101871:	89 f8                	mov    %edi,%eax
80101873:	83 e0 07             	and    $0x7,%eax
80101876:	c1 e0 06             	shl    $0x6,%eax
80101879:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010187d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101881:	75 bd                	jne    80101840 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101883:	83 ec 04             	sub    $0x4,%esp
80101886:	6a 40                	push   $0x40
80101888:	6a 00                	push   $0x0
8010188a:	51                   	push   %ecx
8010188b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010188e:	e8 ed 2f 00 00       	call   80104880 <memset>
      dip->type = type;
80101893:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101897:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010189a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010189d:	89 1c 24             	mov    %ebx,(%esp)
801018a0:	e8 5b 18 00 00       	call   80103100 <log_write>
      brelse(bp);
801018a5:	89 1c 24             	mov    %ebx,(%esp)
801018a8:	e8 43 e9 ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
801018ad:	83 c4 10             	add    $0x10,%esp
}
801018b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801018b3:	89 fa                	mov    %edi,%edx
}
801018b5:	5b                   	pop    %ebx
      return iget(dev, inum);
801018b6:	89 f0                	mov    %esi,%eax
}
801018b8:	5e                   	pop    %esi
801018b9:	5f                   	pop    %edi
801018ba:	5d                   	pop    %ebp
      return iget(dev, inum);
801018bb:	e9 00 fc ff ff       	jmp    801014c0 <iget>
  panic("ialloc: no inodes");
801018c0:	83 ec 0c             	sub    $0xc,%esp
801018c3:	68 47 74 10 80       	push   $0x80107447
801018c8:	e8 b3 ea ff ff       	call   80100380 <panic>
801018cd:	8d 76 00             	lea    0x0(%esi),%esi

801018d0 <iupdate>:
{
801018d0:	55                   	push   %ebp
801018d1:	89 e5                	mov    %esp,%ebp
801018d3:	56                   	push   %esi
801018d4:	53                   	push   %ebx
801018d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018d8:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801018db:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018de:	83 ec 08             	sub    $0x8,%esp
801018e1:	c1 e8 03             	shr    $0x3,%eax
801018e4:	03 05 c8 15 11 80    	add    0x801115c8,%eax
801018ea:	50                   	push   %eax
801018eb:	ff 73 a4             	push   -0x5c(%ebx)
801018ee:	e8 dd e7 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
801018f3:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801018f7:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018fa:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801018fc:	8b 43 a8             	mov    -0x58(%ebx),%eax
801018ff:	83 e0 07             	and    $0x7,%eax
80101902:	c1 e0 06             	shl    $0x6,%eax
80101905:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101909:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010190c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101910:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101913:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101917:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010191b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010191f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101923:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101927:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010192a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010192d:	6a 34                	push   $0x34
8010192f:	53                   	push   %ebx
80101930:	50                   	push   %eax
80101931:	e8 da 2f 00 00       	call   80104910 <memmove>
  log_write(bp);
80101936:	89 34 24             	mov    %esi,(%esp)
80101939:	e8 c2 17 00 00       	call   80103100 <log_write>
  brelse(bp);
8010193e:	83 c4 10             	add    $0x10,%esp
80101941:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101944:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101947:	5b                   	pop    %ebx
80101948:	5e                   	pop    %esi
80101949:	5d                   	pop    %ebp
  brelse(bp);
8010194a:	e9 a1 e8 ff ff       	jmp    801001f0 <brelse>
8010194f:	90                   	nop

80101950 <idup>:
{
80101950:	55                   	push   %ebp
80101951:	89 e5                	mov    %esp,%ebp
80101953:	53                   	push   %ebx
80101954:	83 ec 10             	sub    $0x10,%esp
80101957:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010195a:	68 60 f9 10 80       	push   $0x8010f960
8010195f:	e8 1c 2e 00 00       	call   80104780 <acquire>
  ip->ref++;
80101964:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101968:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
8010196f:	e8 ac 2d 00 00       	call   80104720 <release>
}
80101974:	89 d8                	mov    %ebx,%eax
80101976:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101979:	c9                   	leave
8010197a:	c3                   	ret
8010197b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101980 <ilock>:
{
80101980:	55                   	push   %ebp
80101981:	89 e5                	mov    %esp,%ebp
80101983:	56                   	push   %esi
80101984:	53                   	push   %ebx
80101985:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101988:	85 db                	test   %ebx,%ebx
8010198a:	0f 84 b7 00 00 00    	je     80101a47 <ilock+0xc7>
80101990:	8b 53 08             	mov    0x8(%ebx),%edx
80101993:	85 d2                	test   %edx,%edx
80101995:	0f 8e ac 00 00 00    	jle    80101a47 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010199b:	83 ec 0c             	sub    $0xc,%esp
8010199e:	8d 43 0c             	lea    0xc(%ebx),%eax
801019a1:	50                   	push   %eax
801019a2:	e8 f9 2a 00 00       	call   801044a0 <acquiresleep>
  if(ip->valid == 0){
801019a7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801019aa:	83 c4 10             	add    $0x10,%esp
801019ad:	85 c0                	test   %eax,%eax
801019af:	74 0f                	je     801019c0 <ilock+0x40>
}
801019b1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801019b4:	5b                   	pop    %ebx
801019b5:	5e                   	pop    %esi
801019b6:	5d                   	pop    %ebp
801019b7:	c3                   	ret
801019b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801019bf:	00 
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801019c0:	8b 43 04             	mov    0x4(%ebx),%eax
801019c3:	83 ec 08             	sub    $0x8,%esp
801019c6:	c1 e8 03             	shr    $0x3,%eax
801019c9:	03 05 c8 15 11 80    	add    0x801115c8,%eax
801019cf:	50                   	push   %eax
801019d0:	ff 33                	push   (%ebx)
801019d2:	e8 f9 e6 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801019d7:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801019da:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801019dc:	8b 43 04             	mov    0x4(%ebx),%eax
801019df:	83 e0 07             	and    $0x7,%eax
801019e2:	c1 e0 06             	shl    $0x6,%eax
801019e5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801019e9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801019ec:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801019ef:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801019f3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801019f7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801019fb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801019ff:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101a03:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101a07:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101a0b:	8b 50 fc             	mov    -0x4(%eax),%edx
80101a0e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101a11:	6a 34                	push   $0x34
80101a13:	50                   	push   %eax
80101a14:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101a17:	50                   	push   %eax
80101a18:	e8 f3 2e 00 00       	call   80104910 <memmove>
    brelse(bp);
80101a1d:	89 34 24             	mov    %esi,(%esp)
80101a20:	e8 cb e7 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101a25:	83 c4 10             	add    $0x10,%esp
80101a28:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
80101a2d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101a34:	0f 85 77 ff ff ff    	jne    801019b1 <ilock+0x31>
      panic("ilock: no type");
80101a3a:	83 ec 0c             	sub    $0xc,%esp
80101a3d:	68 5f 74 10 80       	push   $0x8010745f
80101a42:	e8 39 e9 ff ff       	call   80100380 <panic>
    panic("ilock");
80101a47:	83 ec 0c             	sub    $0xc,%esp
80101a4a:	68 59 74 10 80       	push   $0x80107459
80101a4f:	e8 2c e9 ff ff       	call   80100380 <panic>
80101a54:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101a5b:	00 
80101a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101a60 <iunlock>:
{
80101a60:	55                   	push   %ebp
80101a61:	89 e5                	mov    %esp,%ebp
80101a63:	56                   	push   %esi
80101a64:	53                   	push   %ebx
80101a65:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101a68:	85 db                	test   %ebx,%ebx
80101a6a:	74 28                	je     80101a94 <iunlock+0x34>
80101a6c:	83 ec 0c             	sub    $0xc,%esp
80101a6f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101a72:	56                   	push   %esi
80101a73:	e8 c8 2a 00 00       	call   80104540 <holdingsleep>
80101a78:	83 c4 10             	add    $0x10,%esp
80101a7b:	85 c0                	test   %eax,%eax
80101a7d:	74 15                	je     80101a94 <iunlock+0x34>
80101a7f:	8b 43 08             	mov    0x8(%ebx),%eax
80101a82:	85 c0                	test   %eax,%eax
80101a84:	7e 0e                	jle    80101a94 <iunlock+0x34>
  releasesleep(&ip->lock);
80101a86:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101a89:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101a8c:	5b                   	pop    %ebx
80101a8d:	5e                   	pop    %esi
80101a8e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101a8f:	e9 6c 2a 00 00       	jmp    80104500 <releasesleep>
    panic("iunlock");
80101a94:	83 ec 0c             	sub    $0xc,%esp
80101a97:	68 6e 74 10 80       	push   $0x8010746e
80101a9c:	e8 df e8 ff ff       	call   80100380 <panic>
80101aa1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101aa8:	00 
80101aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101ab0 <iput>:
{
80101ab0:	55                   	push   %ebp
80101ab1:	89 e5                	mov    %esp,%ebp
80101ab3:	57                   	push   %edi
80101ab4:	56                   	push   %esi
80101ab5:	53                   	push   %ebx
80101ab6:	83 ec 28             	sub    $0x28,%esp
80101ab9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
80101abc:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101abf:	57                   	push   %edi
80101ac0:	e8 db 29 00 00       	call   801044a0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101ac5:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101ac8:	83 c4 10             	add    $0x10,%esp
80101acb:	85 d2                	test   %edx,%edx
80101acd:	74 07                	je     80101ad6 <iput+0x26>
80101acf:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101ad4:	74 32                	je     80101b08 <iput+0x58>
  releasesleep(&ip->lock);
80101ad6:	83 ec 0c             	sub    $0xc,%esp
80101ad9:	57                   	push   %edi
80101ada:	e8 21 2a 00 00       	call   80104500 <releasesleep>
  acquire(&icache.lock);
80101adf:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
80101ae6:	e8 95 2c 00 00       	call   80104780 <acquire>
  ip->ref--;
80101aeb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101aef:	83 c4 10             	add    $0x10,%esp
80101af2:	c7 45 08 60 f9 10 80 	movl   $0x8010f960,0x8(%ebp)
}
80101af9:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101afc:	5b                   	pop    %ebx
80101afd:	5e                   	pop    %esi
80101afe:	5f                   	pop    %edi
80101aff:	5d                   	pop    %ebp
  release(&icache.lock);
80101b00:	e9 1b 2c 00 00       	jmp    80104720 <release>
80101b05:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101b08:	83 ec 0c             	sub    $0xc,%esp
80101b0b:	68 60 f9 10 80       	push   $0x8010f960
80101b10:	e8 6b 2c 00 00       	call   80104780 <acquire>
    int r = ip->ref;
80101b15:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101b18:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
80101b1f:	e8 fc 2b 00 00       	call   80104720 <release>
    if(r == 1){
80101b24:	83 c4 10             	add    $0x10,%esp
80101b27:	83 fe 01             	cmp    $0x1,%esi
80101b2a:	75 aa                	jne    80101ad6 <iput+0x26>
80101b2c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101b32:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101b35:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101b38:	89 df                	mov    %ebx,%edi
80101b3a:	89 cb                	mov    %ecx,%ebx
80101b3c:	eb 09                	jmp    80101b47 <iput+0x97>
80101b3e:	66 90                	xchg   %ax,%ax
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101b40:	83 c6 04             	add    $0x4,%esi
80101b43:	39 de                	cmp    %ebx,%esi
80101b45:	74 19                	je     80101b60 <iput+0xb0>
    if(ip->addrs[i]){
80101b47:	8b 16                	mov    (%esi),%edx
80101b49:	85 d2                	test   %edx,%edx
80101b4b:	74 f3                	je     80101b40 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101b4d:	8b 07                	mov    (%edi),%eax
80101b4f:	e8 6c fa ff ff       	call   801015c0 <bfree>
      ip->addrs[i] = 0;
80101b54:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101b5a:	eb e4                	jmp    80101b40 <iput+0x90>
80101b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101b60:	89 fb                	mov    %edi,%ebx
80101b62:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101b65:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101b6b:	85 c0                	test   %eax,%eax
80101b6d:	75 2d                	jne    80101b9c <iput+0xec>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101b6f:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101b72:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101b79:	53                   	push   %ebx
80101b7a:	e8 51 fd ff ff       	call   801018d0 <iupdate>
      ip->type = 0;
80101b7f:	31 c0                	xor    %eax,%eax
80101b81:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101b85:	89 1c 24             	mov    %ebx,(%esp)
80101b88:	e8 43 fd ff ff       	call   801018d0 <iupdate>
      ip->valid = 0;
80101b8d:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101b94:	83 c4 10             	add    $0x10,%esp
80101b97:	e9 3a ff ff ff       	jmp    80101ad6 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101b9c:	83 ec 08             	sub    $0x8,%esp
80101b9f:	50                   	push   %eax
80101ba0:	ff 33                	push   (%ebx)
80101ba2:	e8 29 e5 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
80101ba7:	83 c4 10             	add    $0x10,%esp
80101baa:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101bad:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101bb3:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101bb6:	8d 70 5c             	lea    0x5c(%eax),%esi
80101bb9:	89 cf                	mov    %ecx,%edi
80101bbb:	eb 0a                	jmp    80101bc7 <iput+0x117>
80101bbd:	8d 76 00             	lea    0x0(%esi),%esi
80101bc0:	83 c6 04             	add    $0x4,%esi
80101bc3:	39 fe                	cmp    %edi,%esi
80101bc5:	74 0f                	je     80101bd6 <iput+0x126>
      if(a[j])
80101bc7:	8b 16                	mov    (%esi),%edx
80101bc9:	85 d2                	test   %edx,%edx
80101bcb:	74 f3                	je     80101bc0 <iput+0x110>
        bfree(ip->dev, a[j]);
80101bcd:	8b 03                	mov    (%ebx),%eax
80101bcf:	e8 ec f9 ff ff       	call   801015c0 <bfree>
80101bd4:	eb ea                	jmp    80101bc0 <iput+0x110>
    brelse(bp);
80101bd6:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101bd9:	83 ec 0c             	sub    $0xc,%esp
80101bdc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101bdf:	50                   	push   %eax
80101be0:	e8 0b e6 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101be5:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101beb:	8b 03                	mov    (%ebx),%eax
80101bed:	e8 ce f9 ff ff       	call   801015c0 <bfree>
    ip->addrs[NDIRECT] = 0;
80101bf2:	83 c4 10             	add    $0x10,%esp
80101bf5:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101bfc:	00 00 00 
80101bff:	e9 6b ff ff ff       	jmp    80101b6f <iput+0xbf>
80101c04:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101c0b:	00 
80101c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101c10 <iunlockput>:
{
80101c10:	55                   	push   %ebp
80101c11:	89 e5                	mov    %esp,%ebp
80101c13:	56                   	push   %esi
80101c14:	53                   	push   %ebx
80101c15:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101c18:	85 db                	test   %ebx,%ebx
80101c1a:	74 34                	je     80101c50 <iunlockput+0x40>
80101c1c:	83 ec 0c             	sub    $0xc,%esp
80101c1f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101c22:	56                   	push   %esi
80101c23:	e8 18 29 00 00       	call   80104540 <holdingsleep>
80101c28:	83 c4 10             	add    $0x10,%esp
80101c2b:	85 c0                	test   %eax,%eax
80101c2d:	74 21                	je     80101c50 <iunlockput+0x40>
80101c2f:	8b 43 08             	mov    0x8(%ebx),%eax
80101c32:	85 c0                	test   %eax,%eax
80101c34:	7e 1a                	jle    80101c50 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101c36:	83 ec 0c             	sub    $0xc,%esp
80101c39:	56                   	push   %esi
80101c3a:	e8 c1 28 00 00       	call   80104500 <releasesleep>
  iput(ip);
80101c3f:	83 c4 10             	add    $0x10,%esp
80101c42:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101c45:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101c48:	5b                   	pop    %ebx
80101c49:	5e                   	pop    %esi
80101c4a:	5d                   	pop    %ebp
  iput(ip);
80101c4b:	e9 60 fe ff ff       	jmp    80101ab0 <iput>
    panic("iunlock");
80101c50:	83 ec 0c             	sub    $0xc,%esp
80101c53:	68 6e 74 10 80       	push   $0x8010746e
80101c58:	e8 23 e7 ff ff       	call   80100380 <panic>
80101c5d:	8d 76 00             	lea    0x0(%esi),%esi

80101c60 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101c60:	55                   	push   %ebp
80101c61:	89 e5                	mov    %esp,%ebp
80101c63:	8b 55 08             	mov    0x8(%ebp),%edx
80101c66:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101c69:	8b 0a                	mov    (%edx),%ecx
80101c6b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101c6e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101c71:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101c74:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101c78:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101c7b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101c7f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101c83:	8b 52 58             	mov    0x58(%edx),%edx
80101c86:	89 50 10             	mov    %edx,0x10(%eax)
}
80101c89:	5d                   	pop    %ebp
80101c8a:	c3                   	ret
80101c8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101c90 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101c90:	55                   	push   %ebp
80101c91:	89 e5                	mov    %esp,%ebp
80101c93:	57                   	push   %edi
80101c94:	56                   	push   %esi
80101c95:	53                   	push   %ebx
80101c96:	83 ec 1c             	sub    $0x1c,%esp
80101c99:	8b 75 08             	mov    0x8(%ebp),%esi
80101c9c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101c9f:	8b 7d 10             	mov    0x10(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101ca2:	66 83 7e 50 03       	cmpw   $0x3,0x50(%esi)
{
80101ca7:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101caa:	89 75 d8             	mov    %esi,-0x28(%ebp)
80101cad:	8b 45 14             	mov    0x14(%ebp),%eax
  if(ip->type == T_DEV){
80101cb0:	0f 84 aa 00 00 00    	je     80101d60 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101cb6:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101cb9:	8b 56 58             	mov    0x58(%esi),%edx
80101cbc:	39 fa                	cmp    %edi,%edx
80101cbe:	0f 82 bd 00 00 00    	jb     80101d81 <readi+0xf1>
80101cc4:	89 f9                	mov    %edi,%ecx
80101cc6:	31 db                	xor    %ebx,%ebx
80101cc8:	01 c1                	add    %eax,%ecx
80101cca:	0f 92 c3             	setb   %bl
80101ccd:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80101cd0:	0f 82 ab 00 00 00    	jb     80101d81 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101cd6:	89 d3                	mov    %edx,%ebx
80101cd8:	29 fb                	sub    %edi,%ebx
80101cda:	39 ca                	cmp    %ecx,%edx
80101cdc:	0f 42 c3             	cmovb  %ebx,%eax

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101cdf:	85 c0                	test   %eax,%eax
80101ce1:	74 73                	je     80101d56 <readi+0xc6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101ce3:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101ce6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101cf0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101cf3:	89 fa                	mov    %edi,%edx
80101cf5:	c1 ea 09             	shr    $0x9,%edx
80101cf8:	89 d8                	mov    %ebx,%eax
80101cfa:	e8 41 f9 ff ff       	call   80101640 <bmap>
80101cff:	83 ec 08             	sub    $0x8,%esp
80101d02:	50                   	push   %eax
80101d03:	ff 33                	push   (%ebx)
80101d05:	e8 c6 e3 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101d0a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101d0d:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d12:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101d14:	89 f8                	mov    %edi,%eax
80101d16:	25 ff 01 00 00       	and    $0x1ff,%eax
80101d1b:	29 f3                	sub    %esi,%ebx
80101d1d:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101d1f:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101d23:	39 d9                	cmp    %ebx,%ecx
80101d25:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101d28:	83 c4 0c             	add    $0xc,%esp
80101d2b:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101d2c:	01 de                	add    %ebx,%esi
80101d2e:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101d30:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101d33:	50                   	push   %eax
80101d34:	ff 75 e0             	push   -0x20(%ebp)
80101d37:	e8 d4 2b 00 00       	call   80104910 <memmove>
    brelse(bp);
80101d3c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101d3f:	89 14 24             	mov    %edx,(%esp)
80101d42:	e8 a9 e4 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101d47:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101d4a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101d4d:	83 c4 10             	add    $0x10,%esp
80101d50:	39 de                	cmp    %ebx,%esi
80101d52:	72 9c                	jb     80101cf0 <readi+0x60>
80101d54:	89 d8                	mov    %ebx,%eax
  }
  return n;
}
80101d56:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d59:	5b                   	pop    %ebx
80101d5a:	5e                   	pop    %esi
80101d5b:	5f                   	pop    %edi
80101d5c:	5d                   	pop    %ebp
80101d5d:	c3                   	ret
80101d5e:	66 90                	xchg   %ax,%ax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101d60:	0f bf 56 52          	movswl 0x52(%esi),%edx
80101d64:	66 83 fa 09          	cmp    $0x9,%dx
80101d68:	77 17                	ja     80101d81 <readi+0xf1>
80101d6a:	8b 14 d5 00 f9 10 80 	mov    -0x7fef0700(,%edx,8),%edx
80101d71:	85 d2                	test   %edx,%edx
80101d73:	74 0c                	je     80101d81 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101d75:	89 45 10             	mov    %eax,0x10(%ebp)
}
80101d78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d7b:	5b                   	pop    %ebx
80101d7c:	5e                   	pop    %esi
80101d7d:	5f                   	pop    %edi
80101d7e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101d7f:	ff e2                	jmp    *%edx
      return -1;
80101d81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d86:	eb ce                	jmp    80101d56 <readi+0xc6>
80101d88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101d8f:	00 

80101d90 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101d90:	55                   	push   %ebp
80101d91:	89 e5                	mov    %esp,%ebp
80101d93:	57                   	push   %edi
80101d94:	56                   	push   %esi
80101d95:	53                   	push   %ebx
80101d96:	83 ec 1c             	sub    $0x1c,%esp
80101d99:	8b 45 08             	mov    0x8(%ebp),%eax
80101d9c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101d9f:	8b 75 14             	mov    0x14(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101da2:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101da7:	89 7d dc             	mov    %edi,-0x24(%ebp)
80101daa:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101dad:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(ip->type == T_DEV){
80101db0:	0f 84 ba 00 00 00    	je     80101e70 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101db6:	39 78 58             	cmp    %edi,0x58(%eax)
80101db9:	0f 82 ea 00 00 00    	jb     80101ea9 <writei+0x119>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101dbf:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101dc2:	89 f2                	mov    %esi,%edx
80101dc4:	01 fa                	add    %edi,%edx
80101dc6:	0f 82 dd 00 00 00    	jb     80101ea9 <writei+0x119>
80101dcc:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
80101dd2:	0f 87 d1 00 00 00    	ja     80101ea9 <writei+0x119>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101dd8:	85 f6                	test   %esi,%esi
80101dda:	0f 84 85 00 00 00    	je     80101e65 <writei+0xd5>
80101de0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101de7:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101dea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101df0:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101df3:	89 fa                	mov    %edi,%edx
80101df5:	c1 ea 09             	shr    $0x9,%edx
80101df8:	89 f0                	mov    %esi,%eax
80101dfa:	e8 41 f8 ff ff       	call   80101640 <bmap>
80101dff:	83 ec 08             	sub    $0x8,%esp
80101e02:	50                   	push   %eax
80101e03:	ff 36                	push   (%esi)
80101e05:	e8 c6 e2 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101e0a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101e0d:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101e10:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101e15:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80101e17:	89 f8                	mov    %edi,%eax
80101e19:	25 ff 01 00 00       	and    $0x1ff,%eax
80101e1e:	29 d3                	sub    %edx,%ebx
80101e20:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101e22:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101e26:	39 d9                	cmp    %ebx,%ecx
80101e28:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101e2b:	83 c4 0c             	add    $0xc,%esp
80101e2e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101e2f:	01 df                	add    %ebx,%edi
    memmove(bp->data + off%BSIZE, src, m);
80101e31:	ff 75 dc             	push   -0x24(%ebp)
80101e34:	50                   	push   %eax
80101e35:	e8 d6 2a 00 00       	call   80104910 <memmove>
    log_write(bp);
80101e3a:	89 34 24             	mov    %esi,(%esp)
80101e3d:	e8 be 12 00 00       	call   80103100 <log_write>
    brelse(bp);
80101e42:	89 34 24             	mov    %esi,(%esp)
80101e45:	e8 a6 e3 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101e4a:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101e4d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101e50:	83 c4 10             	add    $0x10,%esp
80101e53:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101e56:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101e59:	39 d8                	cmp    %ebx,%eax
80101e5b:	72 93                	jb     80101df0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101e5d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101e60:	39 78 58             	cmp    %edi,0x58(%eax)
80101e63:	72 33                	jb     80101e98 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101e65:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101e68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e6b:	5b                   	pop    %ebx
80101e6c:	5e                   	pop    %esi
80101e6d:	5f                   	pop    %edi
80101e6e:	5d                   	pop    %ebp
80101e6f:	c3                   	ret
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101e70:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101e74:	66 83 f8 09          	cmp    $0x9,%ax
80101e78:	77 2f                	ja     80101ea9 <writei+0x119>
80101e7a:	8b 04 c5 04 f9 10 80 	mov    -0x7fef06fc(,%eax,8),%eax
80101e81:	85 c0                	test   %eax,%eax
80101e83:	74 24                	je     80101ea9 <writei+0x119>
    return devsw[ip->major].write(ip, src, n);
80101e85:	89 75 10             	mov    %esi,0x10(%ebp)
}
80101e88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e8b:	5b                   	pop    %ebx
80101e8c:	5e                   	pop    %esi
80101e8d:	5f                   	pop    %edi
80101e8e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101e8f:	ff e0                	jmp    *%eax
80101e91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iupdate(ip);
80101e98:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101e9b:	89 78 58             	mov    %edi,0x58(%eax)
    iupdate(ip);
80101e9e:	50                   	push   %eax
80101e9f:	e8 2c fa ff ff       	call   801018d0 <iupdate>
80101ea4:	83 c4 10             	add    $0x10,%esp
80101ea7:	eb bc                	jmp    80101e65 <writei+0xd5>
      return -1;
80101ea9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101eae:	eb b8                	jmp    80101e68 <writei+0xd8>

80101eb0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101eb0:	55                   	push   %ebp
80101eb1:	89 e5                	mov    %esp,%ebp
80101eb3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101eb6:	6a 0e                	push   $0xe
80101eb8:	ff 75 0c             	push   0xc(%ebp)
80101ebb:	ff 75 08             	push   0x8(%ebp)
80101ebe:	e8 bd 2a 00 00       	call   80104980 <strncmp>
}
80101ec3:	c9                   	leave
80101ec4:	c3                   	ret
80101ec5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101ecc:	00 
80101ecd:	8d 76 00             	lea    0x0(%esi),%esi

80101ed0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101ed0:	55                   	push   %ebp
80101ed1:	89 e5                	mov    %esp,%ebp
80101ed3:	57                   	push   %edi
80101ed4:	56                   	push   %esi
80101ed5:	53                   	push   %ebx
80101ed6:	83 ec 1c             	sub    $0x1c,%esp
80101ed9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101edc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101ee1:	0f 85 85 00 00 00    	jne    80101f6c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101ee7:	8b 53 58             	mov    0x58(%ebx),%edx
80101eea:	31 ff                	xor    %edi,%edi
80101eec:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101eef:	85 d2                	test   %edx,%edx
80101ef1:	74 3e                	je     80101f31 <dirlookup+0x61>
80101ef3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ef8:	6a 10                	push   $0x10
80101efa:	57                   	push   %edi
80101efb:	56                   	push   %esi
80101efc:	53                   	push   %ebx
80101efd:	e8 8e fd ff ff       	call   80101c90 <readi>
80101f02:	83 c4 10             	add    $0x10,%esp
80101f05:	83 f8 10             	cmp    $0x10,%eax
80101f08:	75 55                	jne    80101f5f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101f0a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101f0f:	74 18                	je     80101f29 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101f11:	83 ec 04             	sub    $0x4,%esp
80101f14:	8d 45 da             	lea    -0x26(%ebp),%eax
80101f17:	6a 0e                	push   $0xe
80101f19:	50                   	push   %eax
80101f1a:	ff 75 0c             	push   0xc(%ebp)
80101f1d:	e8 5e 2a 00 00       	call   80104980 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101f22:	83 c4 10             	add    $0x10,%esp
80101f25:	85 c0                	test   %eax,%eax
80101f27:	74 17                	je     80101f40 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101f29:	83 c7 10             	add    $0x10,%edi
80101f2c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101f2f:	72 c7                	jb     80101ef8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101f31:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101f34:	31 c0                	xor    %eax,%eax
}
80101f36:	5b                   	pop    %ebx
80101f37:	5e                   	pop    %esi
80101f38:	5f                   	pop    %edi
80101f39:	5d                   	pop    %ebp
80101f3a:	c3                   	ret
80101f3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(poff)
80101f40:	8b 45 10             	mov    0x10(%ebp),%eax
80101f43:	85 c0                	test   %eax,%eax
80101f45:	74 05                	je     80101f4c <dirlookup+0x7c>
        *poff = off;
80101f47:	8b 45 10             	mov    0x10(%ebp),%eax
80101f4a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101f4c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101f50:	8b 03                	mov    (%ebx),%eax
80101f52:	e8 69 f5 ff ff       	call   801014c0 <iget>
}
80101f57:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f5a:	5b                   	pop    %ebx
80101f5b:	5e                   	pop    %esi
80101f5c:	5f                   	pop    %edi
80101f5d:	5d                   	pop    %ebp
80101f5e:	c3                   	ret
      panic("dirlookup read");
80101f5f:	83 ec 0c             	sub    $0xc,%esp
80101f62:	68 88 74 10 80       	push   $0x80107488
80101f67:	e8 14 e4 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
80101f6c:	83 ec 0c             	sub    $0xc,%esp
80101f6f:	68 76 74 10 80       	push   $0x80107476
80101f74:	e8 07 e4 ff ff       	call   80100380 <panic>
80101f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101f80 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101f80:	55                   	push   %ebp
80101f81:	89 e5                	mov    %esp,%ebp
80101f83:	57                   	push   %edi
80101f84:	56                   	push   %esi
80101f85:	53                   	push   %ebx
80101f86:	89 c3                	mov    %eax,%ebx
80101f88:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101f8b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101f8e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101f91:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101f94:	0f 84 9e 01 00 00    	je     80102138 <namex+0x1b8>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101f9a:	e8 a1 1b 00 00       	call   80103b40 <myproc>
  acquire(&icache.lock);
80101f9f:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101fa2:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101fa5:	68 60 f9 10 80       	push   $0x8010f960
80101faa:	e8 d1 27 00 00       	call   80104780 <acquire>
  ip->ref++;
80101faf:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101fb3:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
80101fba:	e8 61 27 00 00       	call   80104720 <release>
80101fbf:	83 c4 10             	add    $0x10,%esp
80101fc2:	eb 07                	jmp    80101fcb <namex+0x4b>
80101fc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101fc8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101fcb:	0f b6 03             	movzbl (%ebx),%eax
80101fce:	3c 2f                	cmp    $0x2f,%al
80101fd0:	74 f6                	je     80101fc8 <namex+0x48>
  if(*path == 0)
80101fd2:	84 c0                	test   %al,%al
80101fd4:	0f 84 06 01 00 00    	je     801020e0 <namex+0x160>
  while(*path != '/' && *path != 0)
80101fda:	0f b6 03             	movzbl (%ebx),%eax
80101fdd:	84 c0                	test   %al,%al
80101fdf:	0f 84 10 01 00 00    	je     801020f5 <namex+0x175>
80101fe5:	89 df                	mov    %ebx,%edi
80101fe7:	3c 2f                	cmp    $0x2f,%al
80101fe9:	0f 84 06 01 00 00    	je     801020f5 <namex+0x175>
80101fef:	90                   	nop
80101ff0:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80101ff4:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80101ff7:	3c 2f                	cmp    $0x2f,%al
80101ff9:	74 04                	je     80101fff <namex+0x7f>
80101ffb:	84 c0                	test   %al,%al
80101ffd:	75 f1                	jne    80101ff0 <namex+0x70>
  len = path - s;
80101fff:	89 f8                	mov    %edi,%eax
80102001:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80102003:	83 f8 0d             	cmp    $0xd,%eax
80102006:	0f 8e ac 00 00 00    	jle    801020b8 <namex+0x138>
    memmove(name, s, DIRSIZ);
8010200c:	83 ec 04             	sub    $0x4,%esp
8010200f:	6a 0e                	push   $0xe
80102011:	53                   	push   %ebx
80102012:	89 fb                	mov    %edi,%ebx
80102014:	ff 75 e4             	push   -0x1c(%ebp)
80102017:	e8 f4 28 00 00       	call   80104910 <memmove>
8010201c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
8010201f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80102022:	75 0c                	jne    80102030 <namex+0xb0>
80102024:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102028:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
8010202b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
8010202e:	74 f8                	je     80102028 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80102030:	83 ec 0c             	sub    $0xc,%esp
80102033:	56                   	push   %esi
80102034:	e8 47 f9 ff ff       	call   80101980 <ilock>
    if(ip->type != T_DIR){
80102039:	83 c4 10             	add    $0x10,%esp
8010203c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80102041:	0f 85 b7 00 00 00    	jne    801020fe <namex+0x17e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80102047:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010204a:	85 c0                	test   %eax,%eax
8010204c:	74 09                	je     80102057 <namex+0xd7>
8010204e:	80 3b 00             	cmpb   $0x0,(%ebx)
80102051:	0f 84 f7 00 00 00    	je     8010214e <namex+0x1ce>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80102057:	83 ec 04             	sub    $0x4,%esp
8010205a:	6a 00                	push   $0x0
8010205c:	ff 75 e4             	push   -0x1c(%ebp)
8010205f:	56                   	push   %esi
80102060:	e8 6b fe ff ff       	call   80101ed0 <dirlookup>
80102065:	83 c4 10             	add    $0x10,%esp
80102068:	89 c7                	mov    %eax,%edi
8010206a:	85 c0                	test   %eax,%eax
8010206c:	0f 84 8c 00 00 00    	je     801020fe <namex+0x17e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102072:	83 ec 0c             	sub    $0xc,%esp
80102075:	8d 4e 0c             	lea    0xc(%esi),%ecx
80102078:	51                   	push   %ecx
80102079:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010207c:	e8 bf 24 00 00       	call   80104540 <holdingsleep>
80102081:	83 c4 10             	add    $0x10,%esp
80102084:	85 c0                	test   %eax,%eax
80102086:	0f 84 02 01 00 00    	je     8010218e <namex+0x20e>
8010208c:	8b 56 08             	mov    0x8(%esi),%edx
8010208f:	85 d2                	test   %edx,%edx
80102091:	0f 8e f7 00 00 00    	jle    8010218e <namex+0x20e>
  releasesleep(&ip->lock);
80102097:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010209a:	83 ec 0c             	sub    $0xc,%esp
8010209d:	51                   	push   %ecx
8010209e:	e8 5d 24 00 00       	call   80104500 <releasesleep>
  iput(ip);
801020a3:	89 34 24             	mov    %esi,(%esp)
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
801020a6:	89 fe                	mov    %edi,%esi
  iput(ip);
801020a8:	e8 03 fa ff ff       	call   80101ab0 <iput>
801020ad:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
801020b0:	e9 16 ff ff ff       	jmp    80101fcb <namex+0x4b>
801020b5:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
801020b8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801020bb:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    memmove(name, s, len);
801020be:	83 ec 04             	sub    $0x4,%esp
801020c1:	89 4d e0             	mov    %ecx,-0x20(%ebp)
801020c4:	50                   	push   %eax
801020c5:	53                   	push   %ebx
    name[len] = 0;
801020c6:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
801020c8:	ff 75 e4             	push   -0x1c(%ebp)
801020cb:	e8 40 28 00 00       	call   80104910 <memmove>
    name[len] = 0;
801020d0:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801020d3:	83 c4 10             	add    $0x10,%esp
801020d6:	c6 01 00             	movb   $0x0,(%ecx)
801020d9:	e9 41 ff ff ff       	jmp    8010201f <namex+0x9f>
801020de:	66 90                	xchg   %ax,%ax
  }
  if(nameiparent){
801020e0:	8b 45 dc             	mov    -0x24(%ebp),%eax
801020e3:	85 c0                	test   %eax,%eax
801020e5:	0f 85 93 00 00 00    	jne    8010217e <namex+0x1fe>
    iput(ip);
    return 0;
  }
  return ip;
}
801020eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801020ee:	89 f0                	mov    %esi,%eax
801020f0:	5b                   	pop    %ebx
801020f1:	5e                   	pop    %esi
801020f2:	5f                   	pop    %edi
801020f3:	5d                   	pop    %ebp
801020f4:	c3                   	ret
  while(*path != '/' && *path != 0)
801020f5:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801020f8:	89 df                	mov    %ebx,%edi
801020fa:	31 c0                	xor    %eax,%eax
801020fc:	eb c0                	jmp    801020be <namex+0x13e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801020fe:	83 ec 0c             	sub    $0xc,%esp
80102101:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102104:	53                   	push   %ebx
80102105:	e8 36 24 00 00       	call   80104540 <holdingsleep>
8010210a:	83 c4 10             	add    $0x10,%esp
8010210d:	85 c0                	test   %eax,%eax
8010210f:	74 7d                	je     8010218e <namex+0x20e>
80102111:	8b 4e 08             	mov    0x8(%esi),%ecx
80102114:	85 c9                	test   %ecx,%ecx
80102116:	7e 76                	jle    8010218e <namex+0x20e>
  releasesleep(&ip->lock);
80102118:	83 ec 0c             	sub    $0xc,%esp
8010211b:	53                   	push   %ebx
8010211c:	e8 df 23 00 00       	call   80104500 <releasesleep>
  iput(ip);
80102121:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102124:	31 f6                	xor    %esi,%esi
  iput(ip);
80102126:	e8 85 f9 ff ff       	call   80101ab0 <iput>
      return 0;
8010212b:	83 c4 10             	add    $0x10,%esp
}
8010212e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102131:	89 f0                	mov    %esi,%eax
80102133:	5b                   	pop    %ebx
80102134:	5e                   	pop    %esi
80102135:	5f                   	pop    %edi
80102136:	5d                   	pop    %ebp
80102137:	c3                   	ret
    ip = iget(ROOTDEV, ROOTINO);
80102138:	ba 01 00 00 00       	mov    $0x1,%edx
8010213d:	b8 01 00 00 00       	mov    $0x1,%eax
80102142:	e8 79 f3 ff ff       	call   801014c0 <iget>
80102147:	89 c6                	mov    %eax,%esi
80102149:	e9 7d fe ff ff       	jmp    80101fcb <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010214e:	83 ec 0c             	sub    $0xc,%esp
80102151:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102154:	53                   	push   %ebx
80102155:	e8 e6 23 00 00       	call   80104540 <holdingsleep>
8010215a:	83 c4 10             	add    $0x10,%esp
8010215d:	85 c0                	test   %eax,%eax
8010215f:	74 2d                	je     8010218e <namex+0x20e>
80102161:	8b 7e 08             	mov    0x8(%esi),%edi
80102164:	85 ff                	test   %edi,%edi
80102166:	7e 26                	jle    8010218e <namex+0x20e>
  releasesleep(&ip->lock);
80102168:	83 ec 0c             	sub    $0xc,%esp
8010216b:	53                   	push   %ebx
8010216c:	e8 8f 23 00 00       	call   80104500 <releasesleep>
}
80102171:	83 c4 10             	add    $0x10,%esp
}
80102174:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102177:	89 f0                	mov    %esi,%eax
80102179:	5b                   	pop    %ebx
8010217a:	5e                   	pop    %esi
8010217b:	5f                   	pop    %edi
8010217c:	5d                   	pop    %ebp
8010217d:	c3                   	ret
    iput(ip);
8010217e:	83 ec 0c             	sub    $0xc,%esp
80102181:	56                   	push   %esi
      return 0;
80102182:	31 f6                	xor    %esi,%esi
    iput(ip);
80102184:	e8 27 f9 ff ff       	call   80101ab0 <iput>
    return 0;
80102189:	83 c4 10             	add    $0x10,%esp
8010218c:	eb a0                	jmp    8010212e <namex+0x1ae>
    panic("iunlock");
8010218e:	83 ec 0c             	sub    $0xc,%esp
80102191:	68 6e 74 10 80       	push   $0x8010746e
80102196:	e8 e5 e1 ff ff       	call   80100380 <panic>
8010219b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801021a0 <dirlink>:
{
801021a0:	55                   	push   %ebp
801021a1:	89 e5                	mov    %esp,%ebp
801021a3:	57                   	push   %edi
801021a4:	56                   	push   %esi
801021a5:	53                   	push   %ebx
801021a6:	83 ec 20             	sub    $0x20,%esp
801021a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
801021ac:	6a 00                	push   $0x0
801021ae:	ff 75 0c             	push   0xc(%ebp)
801021b1:	53                   	push   %ebx
801021b2:	e8 19 fd ff ff       	call   80101ed0 <dirlookup>
801021b7:	83 c4 10             	add    $0x10,%esp
801021ba:	85 c0                	test   %eax,%eax
801021bc:	75 67                	jne    80102225 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
801021be:	8b 7b 58             	mov    0x58(%ebx),%edi
801021c1:	8d 75 d8             	lea    -0x28(%ebp),%esi
801021c4:	85 ff                	test   %edi,%edi
801021c6:	74 29                	je     801021f1 <dirlink+0x51>
801021c8:	31 ff                	xor    %edi,%edi
801021ca:	8d 75 d8             	lea    -0x28(%ebp),%esi
801021cd:	eb 09                	jmp    801021d8 <dirlink+0x38>
801021cf:	90                   	nop
801021d0:	83 c7 10             	add    $0x10,%edi
801021d3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801021d6:	73 19                	jae    801021f1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801021d8:	6a 10                	push   $0x10
801021da:	57                   	push   %edi
801021db:	56                   	push   %esi
801021dc:	53                   	push   %ebx
801021dd:	e8 ae fa ff ff       	call   80101c90 <readi>
801021e2:	83 c4 10             	add    $0x10,%esp
801021e5:	83 f8 10             	cmp    $0x10,%eax
801021e8:	75 4e                	jne    80102238 <dirlink+0x98>
    if(de.inum == 0)
801021ea:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801021ef:	75 df                	jne    801021d0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
801021f1:	83 ec 04             	sub    $0x4,%esp
801021f4:	8d 45 da             	lea    -0x26(%ebp),%eax
801021f7:	6a 0e                	push   $0xe
801021f9:	ff 75 0c             	push   0xc(%ebp)
801021fc:	50                   	push   %eax
801021fd:	e8 ce 27 00 00       	call   801049d0 <strncpy>
  de.inum = inum;
80102202:	8b 45 10             	mov    0x10(%ebp),%eax
80102205:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102209:	6a 10                	push   $0x10
8010220b:	57                   	push   %edi
8010220c:	56                   	push   %esi
8010220d:	53                   	push   %ebx
8010220e:	e8 7d fb ff ff       	call   80101d90 <writei>
80102213:	83 c4 20             	add    $0x20,%esp
80102216:	83 f8 10             	cmp    $0x10,%eax
80102219:	75 2a                	jne    80102245 <dirlink+0xa5>
  return 0;
8010221b:	31 c0                	xor    %eax,%eax
}
8010221d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102220:	5b                   	pop    %ebx
80102221:	5e                   	pop    %esi
80102222:	5f                   	pop    %edi
80102223:	5d                   	pop    %ebp
80102224:	c3                   	ret
    iput(ip);
80102225:	83 ec 0c             	sub    $0xc,%esp
80102228:	50                   	push   %eax
80102229:	e8 82 f8 ff ff       	call   80101ab0 <iput>
    return -1;
8010222e:	83 c4 10             	add    $0x10,%esp
80102231:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102236:	eb e5                	jmp    8010221d <dirlink+0x7d>
      panic("dirlink read");
80102238:	83 ec 0c             	sub    $0xc,%esp
8010223b:	68 97 74 10 80       	push   $0x80107497
80102240:	e8 3b e1 ff ff       	call   80100380 <panic>
    panic("dirlink");
80102245:	83 ec 0c             	sub    $0xc,%esp
80102248:	68 f3 76 10 80       	push   $0x801076f3
8010224d:	e8 2e e1 ff ff       	call   80100380 <panic>
80102252:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102259:	00 
8010225a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102260 <namei>:

struct inode*
namei(char *path)
{
80102260:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102261:	31 d2                	xor    %edx,%edx
{
80102263:	89 e5                	mov    %esp,%ebp
80102265:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102268:	8b 45 08             	mov    0x8(%ebp),%eax
8010226b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010226e:	e8 0d fd ff ff       	call   80101f80 <namex>
}
80102273:	c9                   	leave
80102274:	c3                   	ret
80102275:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010227c:	00 
8010227d:	8d 76 00             	lea    0x0(%esi),%esi

80102280 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102280:	55                   	push   %ebp
  return namex(path, 1, name);
80102281:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102286:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102288:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010228b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010228e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010228f:	e9 ec fc ff ff       	jmp    80101f80 <namex>
80102294:	66 90                	xchg   %ax,%ax
80102296:	66 90                	xchg   %ax,%ax
80102298:	66 90                	xchg   %ax,%ax
8010229a:	66 90                	xchg   %ax,%ax
8010229c:	66 90                	xchg   %ax,%ax
8010229e:	66 90                	xchg   %ax,%ax

801022a0 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801022a0:	55                   	push   %ebp
801022a1:	89 e5                	mov    %esp,%ebp
801022a3:	57                   	push   %edi
801022a4:	56                   	push   %esi
801022a5:	53                   	push   %ebx
801022a6:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
801022a9:	85 c0                	test   %eax,%eax
801022ab:	0f 84 b4 00 00 00    	je     80102365 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801022b1:	8b 70 08             	mov    0x8(%eax),%esi
801022b4:	89 c3                	mov    %eax,%ebx
801022b6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
801022bc:	0f 87 96 00 00 00    	ja     80102358 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801022c2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801022c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801022ce:	00 
801022cf:	90                   	nop
801022d0:	89 ca                	mov    %ecx,%edx
801022d2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801022d3:	83 e0 c0             	and    $0xffffffc0,%eax
801022d6:	3c 40                	cmp    $0x40,%al
801022d8:	75 f6                	jne    801022d0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801022da:	31 ff                	xor    %edi,%edi
801022dc:	ba f6 03 00 00       	mov    $0x3f6,%edx
801022e1:	89 f8                	mov    %edi,%eax
801022e3:	ee                   	out    %al,(%dx)
801022e4:	b8 01 00 00 00       	mov    $0x1,%eax
801022e9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801022ee:	ee                   	out    %al,(%dx)
801022ef:	ba f3 01 00 00       	mov    $0x1f3,%edx
801022f4:	89 f0                	mov    %esi,%eax
801022f6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
801022f7:	89 f0                	mov    %esi,%eax
801022f9:	ba f4 01 00 00       	mov    $0x1f4,%edx
801022fe:	c1 f8 08             	sar    $0x8,%eax
80102301:	ee                   	out    %al,(%dx)
80102302:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102307:	89 f8                	mov    %edi,%eax
80102309:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010230a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010230e:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102313:	c1 e0 04             	shl    $0x4,%eax
80102316:	83 e0 10             	and    $0x10,%eax
80102319:	83 c8 e0             	or     $0xffffffe0,%eax
8010231c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010231d:	f6 03 04             	testb  $0x4,(%ebx)
80102320:	75 16                	jne    80102338 <idestart+0x98>
80102322:	b8 20 00 00 00       	mov    $0x20,%eax
80102327:	89 ca                	mov    %ecx,%edx
80102329:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010232a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010232d:	5b                   	pop    %ebx
8010232e:	5e                   	pop    %esi
8010232f:	5f                   	pop    %edi
80102330:	5d                   	pop    %ebp
80102331:	c3                   	ret
80102332:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102338:	b8 30 00 00 00       	mov    $0x30,%eax
8010233d:	89 ca                	mov    %ecx,%edx
8010233f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102340:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102345:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102348:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010234d:	fc                   	cld
8010234e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102350:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102353:	5b                   	pop    %ebx
80102354:	5e                   	pop    %esi
80102355:	5f                   	pop    %edi
80102356:	5d                   	pop    %ebp
80102357:	c3                   	ret
    panic("incorrect blockno");
80102358:	83 ec 0c             	sub    $0xc,%esp
8010235b:	68 ad 74 10 80       	push   $0x801074ad
80102360:	e8 1b e0 ff ff       	call   80100380 <panic>
    panic("idestart");
80102365:	83 ec 0c             	sub    $0xc,%esp
80102368:	68 a4 74 10 80       	push   $0x801074a4
8010236d:	e8 0e e0 ff ff       	call   80100380 <panic>
80102372:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102379:	00 
8010237a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102380 <ideinit>:
{
80102380:	55                   	push   %ebp
80102381:	89 e5                	mov    %esp,%ebp
80102383:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102386:	68 bf 74 10 80       	push   $0x801074bf
8010238b:	68 00 16 11 80       	push   $0x80111600
80102390:	e8 fb 21 00 00       	call   80104590 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102395:	58                   	pop    %eax
80102396:	a1 84 17 11 80       	mov    0x80111784,%eax
8010239b:	5a                   	pop    %edx
8010239c:	83 e8 01             	sub    $0x1,%eax
8010239f:	50                   	push   %eax
801023a0:	6a 0e                	push   $0xe
801023a2:	e8 99 02 00 00       	call   80102640 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801023a7:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801023aa:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801023af:	90                   	nop
801023b0:	89 ca                	mov    %ecx,%edx
801023b2:	ec                   	in     (%dx),%al
801023b3:	83 e0 c0             	and    $0xffffffc0,%eax
801023b6:	3c 40                	cmp    $0x40,%al
801023b8:	75 f6                	jne    801023b0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801023ba:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801023bf:	ba f6 01 00 00       	mov    $0x1f6,%edx
801023c4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801023c5:	89 ca                	mov    %ecx,%edx
801023c7:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801023c8:	84 c0                	test   %al,%al
801023ca:	75 1e                	jne    801023ea <ideinit+0x6a>
801023cc:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
801023d1:	ba f7 01 00 00       	mov    $0x1f7,%edx
801023d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801023dd:	00 
801023de:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
801023e0:	83 e9 01             	sub    $0x1,%ecx
801023e3:	74 0f                	je     801023f4 <ideinit+0x74>
801023e5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801023e6:	84 c0                	test   %al,%al
801023e8:	74 f6                	je     801023e0 <ideinit+0x60>
      havedisk1 = 1;
801023ea:	c7 05 e0 15 11 80 01 	movl   $0x1,0x801115e0
801023f1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801023f4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801023f9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801023fe:	ee                   	out    %al,(%dx)
}
801023ff:	c9                   	leave
80102400:	c3                   	ret
80102401:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102408:	00 
80102409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102410 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102410:	55                   	push   %ebp
80102411:	89 e5                	mov    %esp,%ebp
80102413:	57                   	push   %edi
80102414:	56                   	push   %esi
80102415:	53                   	push   %ebx
80102416:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102419:	68 00 16 11 80       	push   $0x80111600
8010241e:	e8 5d 23 00 00       	call   80104780 <acquire>

  if((b = idequeue) == 0){
80102423:	8b 1d e4 15 11 80    	mov    0x801115e4,%ebx
80102429:	83 c4 10             	add    $0x10,%esp
8010242c:	85 db                	test   %ebx,%ebx
8010242e:	74 63                	je     80102493 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102430:	8b 43 58             	mov    0x58(%ebx),%eax
80102433:	a3 e4 15 11 80       	mov    %eax,0x801115e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102438:	8b 33                	mov    (%ebx),%esi
8010243a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102440:	75 2f                	jne    80102471 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102442:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102447:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010244e:	00 
8010244f:	90                   	nop
80102450:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102451:	89 c1                	mov    %eax,%ecx
80102453:	83 e1 c0             	and    $0xffffffc0,%ecx
80102456:	80 f9 40             	cmp    $0x40,%cl
80102459:	75 f5                	jne    80102450 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010245b:	a8 21                	test   $0x21,%al
8010245d:	75 12                	jne    80102471 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010245f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102462:	b9 80 00 00 00       	mov    $0x80,%ecx
80102467:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010246c:	fc                   	cld
8010246d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010246f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80102471:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102474:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102477:	83 ce 02             	or     $0x2,%esi
8010247a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010247c:	53                   	push   %ebx
8010247d:	e8 3e 1e 00 00       	call   801042c0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102482:	a1 e4 15 11 80       	mov    0x801115e4,%eax
80102487:	83 c4 10             	add    $0x10,%esp
8010248a:	85 c0                	test   %eax,%eax
8010248c:	74 05                	je     80102493 <ideintr+0x83>
    idestart(idequeue);
8010248e:	e8 0d fe ff ff       	call   801022a0 <idestart>
    release(&idelock);
80102493:	83 ec 0c             	sub    $0xc,%esp
80102496:	68 00 16 11 80       	push   $0x80111600
8010249b:	e8 80 22 00 00       	call   80104720 <release>

  release(&idelock);
}
801024a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801024a3:	5b                   	pop    %ebx
801024a4:	5e                   	pop    %esi
801024a5:	5f                   	pop    %edi
801024a6:	5d                   	pop    %ebp
801024a7:	c3                   	ret
801024a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801024af:	00 

801024b0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801024b0:	55                   	push   %ebp
801024b1:	89 e5                	mov    %esp,%ebp
801024b3:	53                   	push   %ebx
801024b4:	83 ec 10             	sub    $0x10,%esp
801024b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801024ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801024bd:	50                   	push   %eax
801024be:	e8 7d 20 00 00       	call   80104540 <holdingsleep>
801024c3:	83 c4 10             	add    $0x10,%esp
801024c6:	85 c0                	test   %eax,%eax
801024c8:	0f 84 c3 00 00 00    	je     80102591 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801024ce:	8b 03                	mov    (%ebx),%eax
801024d0:	83 e0 06             	and    $0x6,%eax
801024d3:	83 f8 02             	cmp    $0x2,%eax
801024d6:	0f 84 a8 00 00 00    	je     80102584 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801024dc:	8b 53 04             	mov    0x4(%ebx),%edx
801024df:	85 d2                	test   %edx,%edx
801024e1:	74 0d                	je     801024f0 <iderw+0x40>
801024e3:	a1 e0 15 11 80       	mov    0x801115e0,%eax
801024e8:	85 c0                	test   %eax,%eax
801024ea:	0f 84 87 00 00 00    	je     80102577 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801024f0:	83 ec 0c             	sub    $0xc,%esp
801024f3:	68 00 16 11 80       	push   $0x80111600
801024f8:	e8 83 22 00 00       	call   80104780 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801024fd:	a1 e4 15 11 80       	mov    0x801115e4,%eax
  b->qnext = 0;
80102502:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102509:	83 c4 10             	add    $0x10,%esp
8010250c:	85 c0                	test   %eax,%eax
8010250e:	74 60                	je     80102570 <iderw+0xc0>
80102510:	89 c2                	mov    %eax,%edx
80102512:	8b 40 58             	mov    0x58(%eax),%eax
80102515:	85 c0                	test   %eax,%eax
80102517:	75 f7                	jne    80102510 <iderw+0x60>
80102519:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010251c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010251e:	39 1d e4 15 11 80    	cmp    %ebx,0x801115e4
80102524:	74 3a                	je     80102560 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102526:	8b 03                	mov    (%ebx),%eax
80102528:	83 e0 06             	and    $0x6,%eax
8010252b:	83 f8 02             	cmp    $0x2,%eax
8010252e:	74 1b                	je     8010254b <iderw+0x9b>
    sleep(b, &idelock);
80102530:	83 ec 08             	sub    $0x8,%esp
80102533:	68 00 16 11 80       	push   $0x80111600
80102538:	53                   	push   %ebx
80102539:	e8 c2 1c 00 00       	call   80104200 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010253e:	8b 03                	mov    (%ebx),%eax
80102540:	83 c4 10             	add    $0x10,%esp
80102543:	83 e0 06             	and    $0x6,%eax
80102546:	83 f8 02             	cmp    $0x2,%eax
80102549:	75 e5                	jne    80102530 <iderw+0x80>
  }


  release(&idelock);
8010254b:	c7 45 08 00 16 11 80 	movl   $0x80111600,0x8(%ebp)
}
80102552:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102555:	c9                   	leave
  release(&idelock);
80102556:	e9 c5 21 00 00       	jmp    80104720 <release>
8010255b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    idestart(b);
80102560:	89 d8                	mov    %ebx,%eax
80102562:	e8 39 fd ff ff       	call   801022a0 <idestart>
80102567:	eb bd                	jmp    80102526 <iderw+0x76>
80102569:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102570:	ba e4 15 11 80       	mov    $0x801115e4,%edx
80102575:	eb a5                	jmp    8010251c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80102577:	83 ec 0c             	sub    $0xc,%esp
8010257a:	68 ee 74 10 80       	push   $0x801074ee
8010257f:	e8 fc dd ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
80102584:	83 ec 0c             	sub    $0xc,%esp
80102587:	68 d9 74 10 80       	push   $0x801074d9
8010258c:	e8 ef dd ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
80102591:	83 ec 0c             	sub    $0xc,%esp
80102594:	68 c3 74 10 80       	push   $0x801074c3
80102599:	e8 e2 dd ff ff       	call   80100380 <panic>
8010259e:	66 90                	xchg   %ax,%ax

801025a0 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
801025a0:	55                   	push   %ebp
801025a1:	89 e5                	mov    %esp,%ebp
801025a3:	56                   	push   %esi
801025a4:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
801025a5:	c7 05 34 16 11 80 00 	movl   $0xfec00000,0x80111634
801025ac:	00 c0 fe 
  ioapic->reg = reg;
801025af:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801025b6:	00 00 00 
  return ioapic->data;
801025b9:	8b 15 34 16 11 80    	mov    0x80111634,%edx
801025bf:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
801025c2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801025c8:	8b 1d 34 16 11 80    	mov    0x80111634,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801025ce:	0f b6 15 80 17 11 80 	movzbl 0x80111780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801025d5:	c1 ee 10             	shr    $0x10,%esi
801025d8:	89 f0                	mov    %esi,%eax
801025da:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
801025dd:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
801025e0:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801025e3:	39 c2                	cmp    %eax,%edx
801025e5:	74 16                	je     801025fd <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801025e7:	83 ec 0c             	sub    $0xc,%esp
801025ea:	68 dc 78 10 80       	push   $0x801078dc
801025ef:	e8 7c e0 ff ff       	call   80100670 <cprintf>
  ioapic->reg = reg;
801025f4:	8b 1d 34 16 11 80    	mov    0x80111634,%ebx
801025fa:	83 c4 10             	add    $0x10,%esp
{
801025fd:	ba 10 00 00 00       	mov    $0x10,%edx
80102602:	31 c0                	xor    %eax,%eax
80102604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapic->reg = reg;
80102608:	89 13                	mov    %edx,(%ebx)
8010260a:	8d 48 20             	lea    0x20(%eax),%ecx
  ioapic->data = data;
8010260d:	8b 1d 34 16 11 80    	mov    0x80111634,%ebx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102613:	83 c0 01             	add    $0x1,%eax
80102616:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  ioapic->data = data;
8010261c:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
8010261f:	8d 4a 01             	lea    0x1(%edx),%ecx
  for(i = 0; i <= maxintr; i++){
80102622:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
80102625:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
80102627:	8b 1d 34 16 11 80    	mov    0x80111634,%ebx
8010262d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
80102634:	39 c6                	cmp    %eax,%esi
80102636:	7d d0                	jge    80102608 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102638:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010263b:	5b                   	pop    %ebx
8010263c:	5e                   	pop    %esi
8010263d:	5d                   	pop    %ebp
8010263e:	c3                   	ret
8010263f:	90                   	nop

80102640 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102640:	55                   	push   %ebp
  ioapic->reg = reg;
80102641:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
{
80102647:	89 e5                	mov    %esp,%ebp
80102649:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010264c:	8d 50 20             	lea    0x20(%eax),%edx
8010264f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102653:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102655:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010265b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010265e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102661:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102664:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102666:	a1 34 16 11 80       	mov    0x80111634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010266b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010266e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102671:	5d                   	pop    %ebp
80102672:	c3                   	ret
80102673:	66 90                	xchg   %ax,%ax
80102675:	66 90                	xchg   %ax,%ax
80102677:	66 90                	xchg   %ax,%ax
80102679:	66 90                	xchg   %ax,%ax
8010267b:	66 90                	xchg   %ax,%ax
8010267d:	66 90                	xchg   %ax,%ax
8010267f:	90                   	nop

80102680 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102680:	55                   	push   %ebp
80102681:	89 e5                	mov    %esp,%ebp
80102683:	53                   	push   %ebx
80102684:	83 ec 04             	sub    $0x4,%esp
80102687:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010268a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102690:	75 76                	jne    80102708 <kfree+0x88>
80102692:	81 fb d0 54 11 80    	cmp    $0x801154d0,%ebx
80102698:	72 6e                	jb     80102708 <kfree+0x88>
8010269a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801026a0:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
801026a5:	77 61                	ja     80102708 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
801026a7:	83 ec 04             	sub    $0x4,%esp
801026aa:	68 00 10 00 00       	push   $0x1000
801026af:	6a 01                	push   $0x1
801026b1:	53                   	push   %ebx
801026b2:	e8 c9 21 00 00       	call   80104880 <memset>

  if(kmem.use_lock)
801026b7:	8b 15 74 16 11 80    	mov    0x80111674,%edx
801026bd:	83 c4 10             	add    $0x10,%esp
801026c0:	85 d2                	test   %edx,%edx
801026c2:	75 1c                	jne    801026e0 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801026c4:	a1 78 16 11 80       	mov    0x80111678,%eax
801026c9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801026cb:	a1 74 16 11 80       	mov    0x80111674,%eax
  kmem.freelist = r;
801026d0:	89 1d 78 16 11 80    	mov    %ebx,0x80111678
  if(kmem.use_lock)
801026d6:	85 c0                	test   %eax,%eax
801026d8:	75 1e                	jne    801026f8 <kfree+0x78>
    release(&kmem.lock);
}
801026da:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801026dd:	c9                   	leave
801026de:	c3                   	ret
801026df:	90                   	nop
    acquire(&kmem.lock);
801026e0:	83 ec 0c             	sub    $0xc,%esp
801026e3:	68 40 16 11 80       	push   $0x80111640
801026e8:	e8 93 20 00 00       	call   80104780 <acquire>
801026ed:	83 c4 10             	add    $0x10,%esp
801026f0:	eb d2                	jmp    801026c4 <kfree+0x44>
801026f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
801026f8:	c7 45 08 40 16 11 80 	movl   $0x80111640,0x8(%ebp)
}
801026ff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102702:	c9                   	leave
    release(&kmem.lock);
80102703:	e9 18 20 00 00       	jmp    80104720 <release>
    panic("kfree");
80102708:	83 ec 0c             	sub    $0xc,%esp
8010270b:	68 0c 75 10 80       	push   $0x8010750c
80102710:	e8 6b dc ff ff       	call   80100380 <panic>
80102715:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010271c:	00 
8010271d:	8d 76 00             	lea    0x0(%esi),%esi

80102720 <freerange>:
{
80102720:	55                   	push   %ebp
80102721:	89 e5                	mov    %esp,%ebp
80102723:	56                   	push   %esi
80102724:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102725:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102728:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010272b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102731:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102737:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010273d:	39 de                	cmp    %ebx,%esi
8010273f:	72 23                	jb     80102764 <freerange+0x44>
80102741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102748:	83 ec 0c             	sub    $0xc,%esp
8010274b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102751:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102757:	50                   	push   %eax
80102758:	e8 23 ff ff ff       	call   80102680 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010275d:	83 c4 10             	add    $0x10,%esp
80102760:	39 de                	cmp    %ebx,%esi
80102762:	73 e4                	jae    80102748 <freerange+0x28>
}
80102764:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102767:	5b                   	pop    %ebx
80102768:	5e                   	pop    %esi
80102769:	5d                   	pop    %ebp
8010276a:	c3                   	ret
8010276b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102770 <kinit2>:
{
80102770:	55                   	push   %ebp
80102771:	89 e5                	mov    %esp,%ebp
80102773:	56                   	push   %esi
80102774:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102775:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102778:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010277b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102781:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102787:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010278d:	39 de                	cmp    %ebx,%esi
8010278f:	72 23                	jb     801027b4 <kinit2+0x44>
80102791:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102798:	83 ec 0c             	sub    $0xc,%esp
8010279b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027a1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801027a7:	50                   	push   %eax
801027a8:	e8 d3 fe ff ff       	call   80102680 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027ad:	83 c4 10             	add    $0x10,%esp
801027b0:	39 de                	cmp    %ebx,%esi
801027b2:	73 e4                	jae    80102798 <kinit2+0x28>
  kmem.use_lock = 1;
801027b4:	c7 05 74 16 11 80 01 	movl   $0x1,0x80111674
801027bb:	00 00 00 
}
801027be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027c1:	5b                   	pop    %ebx
801027c2:	5e                   	pop    %esi
801027c3:	5d                   	pop    %ebp
801027c4:	c3                   	ret
801027c5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801027cc:	00 
801027cd:	8d 76 00             	lea    0x0(%esi),%esi

801027d0 <kinit1>:
{
801027d0:	55                   	push   %ebp
801027d1:	89 e5                	mov    %esp,%ebp
801027d3:	56                   	push   %esi
801027d4:	53                   	push   %ebx
801027d5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801027d8:	83 ec 08             	sub    $0x8,%esp
801027db:	68 12 75 10 80       	push   $0x80107512
801027e0:	68 40 16 11 80       	push   $0x80111640
801027e5:	e8 a6 1d 00 00       	call   80104590 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801027ea:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027ed:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
801027f0:	c7 05 74 16 11 80 00 	movl   $0x0,0x80111674
801027f7:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
801027fa:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102800:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102806:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010280c:	39 de                	cmp    %ebx,%esi
8010280e:	72 1c                	jb     8010282c <kinit1+0x5c>
    kfree(p);
80102810:	83 ec 0c             	sub    $0xc,%esp
80102813:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102819:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010281f:	50                   	push   %eax
80102820:	e8 5b fe ff ff       	call   80102680 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102825:	83 c4 10             	add    $0x10,%esp
80102828:	39 de                	cmp    %ebx,%esi
8010282a:	73 e4                	jae    80102810 <kinit1+0x40>
}
8010282c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010282f:	5b                   	pop    %ebx
80102830:	5e                   	pop    %esi
80102831:	5d                   	pop    %ebp
80102832:	c3                   	ret
80102833:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010283a:	00 
8010283b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102840 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102840:	55                   	push   %ebp
80102841:	89 e5                	mov    %esp,%ebp
80102843:	53                   	push   %ebx
80102844:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102847:	a1 74 16 11 80       	mov    0x80111674,%eax
8010284c:	85 c0                	test   %eax,%eax
8010284e:	75 20                	jne    80102870 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102850:	8b 1d 78 16 11 80    	mov    0x80111678,%ebx
  if(r)
80102856:	85 db                	test   %ebx,%ebx
80102858:	74 07                	je     80102861 <kalloc+0x21>
    kmem.freelist = r->next;
8010285a:	8b 03                	mov    (%ebx),%eax
8010285c:	a3 78 16 11 80       	mov    %eax,0x80111678
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102861:	89 d8                	mov    %ebx,%eax
80102863:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102866:	c9                   	leave
80102867:	c3                   	ret
80102868:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010286f:	00 
    acquire(&kmem.lock);
80102870:	83 ec 0c             	sub    $0xc,%esp
80102873:	68 40 16 11 80       	push   $0x80111640
80102878:	e8 03 1f 00 00       	call   80104780 <acquire>
  r = kmem.freelist;
8010287d:	8b 1d 78 16 11 80    	mov    0x80111678,%ebx
  if(kmem.use_lock)
80102883:	a1 74 16 11 80       	mov    0x80111674,%eax
  if(r)
80102888:	83 c4 10             	add    $0x10,%esp
8010288b:	85 db                	test   %ebx,%ebx
8010288d:	74 08                	je     80102897 <kalloc+0x57>
    kmem.freelist = r->next;
8010288f:	8b 13                	mov    (%ebx),%edx
80102891:	89 15 78 16 11 80    	mov    %edx,0x80111678
  if(kmem.use_lock)
80102897:	85 c0                	test   %eax,%eax
80102899:	74 c6                	je     80102861 <kalloc+0x21>
    release(&kmem.lock);
8010289b:	83 ec 0c             	sub    $0xc,%esp
8010289e:	68 40 16 11 80       	push   $0x80111640
801028a3:	e8 78 1e 00 00       	call   80104720 <release>
}
801028a8:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
801028aa:	83 c4 10             	add    $0x10,%esp
}
801028ad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801028b0:	c9                   	leave
801028b1:	c3                   	ret
801028b2:	66 90                	xchg   %ax,%ax
801028b4:	66 90                	xchg   %ax,%ax
801028b6:	66 90                	xchg   %ax,%ax
801028b8:	66 90                	xchg   %ax,%ax
801028ba:	66 90                	xchg   %ax,%ax
801028bc:	66 90                	xchg   %ax,%ax
801028be:	66 90                	xchg   %ax,%ax

801028c0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028c0:	ba 64 00 00 00       	mov    $0x64,%edx
801028c5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801028c6:	a8 01                	test   $0x1,%al
801028c8:	0f 84 c2 00 00 00    	je     80102990 <kbdgetc+0xd0>
{
801028ce:	55                   	push   %ebp
801028cf:	ba 60 00 00 00       	mov    $0x60,%edx
801028d4:	89 e5                	mov    %esp,%ebp
801028d6:	53                   	push   %ebx
801028d7:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801028d8:	8b 1d 7c 16 11 80    	mov    0x8011167c,%ebx
  data = inb(KBDATAP);
801028de:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
801028e1:	3c e0                	cmp    $0xe0,%al
801028e3:	74 5b                	je     80102940 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801028e5:	89 da                	mov    %ebx,%edx
801028e7:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
801028ea:	84 c0                	test   %al,%al
801028ec:	78 62                	js     80102950 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801028ee:	85 d2                	test   %edx,%edx
801028f0:	74 09                	je     801028fb <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801028f2:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801028f5:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
801028f8:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
801028fb:	0f b6 91 40 7b 10 80 	movzbl -0x7fef84c0(%ecx),%edx
  shift ^= togglecode[data];
80102902:	0f b6 81 40 7a 10 80 	movzbl -0x7fef85c0(%ecx),%eax
  shift |= shiftcode[data];
80102909:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
8010290b:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010290d:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
8010290f:	89 15 7c 16 11 80    	mov    %edx,0x8011167c
  c = charcode[shift & (CTL | SHIFT)][data];
80102915:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102918:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010291b:	8b 04 85 20 7a 10 80 	mov    -0x7fef85e0(,%eax,4),%eax
80102922:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102926:	74 0b                	je     80102933 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80102928:	8d 50 9f             	lea    -0x61(%eax),%edx
8010292b:	83 fa 19             	cmp    $0x19,%edx
8010292e:	77 48                	ja     80102978 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102930:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102933:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102936:	c9                   	leave
80102937:	c3                   	ret
80102938:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010293f:	00 
    shift |= E0ESC;
80102940:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102943:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102945:	89 1d 7c 16 11 80    	mov    %ebx,0x8011167c
}
8010294b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010294e:	c9                   	leave
8010294f:	c3                   	ret
    data = (shift & E0ESC ? data : data & 0x7F);
80102950:	83 e0 7f             	and    $0x7f,%eax
80102953:	85 d2                	test   %edx,%edx
80102955:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102958:	0f b6 81 40 7b 10 80 	movzbl -0x7fef84c0(%ecx),%eax
8010295f:	83 c8 40             	or     $0x40,%eax
80102962:	0f b6 c0             	movzbl %al,%eax
80102965:	f7 d0                	not    %eax
80102967:	21 d8                	and    %ebx,%eax
80102969:	a3 7c 16 11 80       	mov    %eax,0x8011167c
    return 0;
8010296e:	31 c0                	xor    %eax,%eax
80102970:	eb d9                	jmp    8010294b <kbdgetc+0x8b>
80102972:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
80102978:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010297b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010297e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102981:	c9                   	leave
      c += 'a' - 'A';
80102982:	83 f9 1a             	cmp    $0x1a,%ecx
80102985:	0f 42 c2             	cmovb  %edx,%eax
}
80102988:	c3                   	ret
80102989:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80102990:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102995:	c3                   	ret
80102996:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010299d:	00 
8010299e:	66 90                	xchg   %ax,%ax

801029a0 <kbdintr>:

void
kbdintr(void)
{
801029a0:	55                   	push   %ebp
801029a1:	89 e5                	mov    %esp,%ebp
801029a3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
801029a6:	68 c0 28 10 80       	push   $0x801028c0
801029ab:	e8 10 df ff ff       	call   801008c0 <consoleintr>
}
801029b0:	83 c4 10             	add    $0x10,%esp
801029b3:	c9                   	leave
801029b4:	c3                   	ret
801029b5:	66 90                	xchg   %ax,%ax
801029b7:	66 90                	xchg   %ax,%ax
801029b9:	66 90                	xchg   %ax,%ax
801029bb:	66 90                	xchg   %ax,%ax
801029bd:	66 90                	xchg   %ax,%ax
801029bf:	90                   	nop

801029c0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801029c0:	a1 80 16 11 80       	mov    0x80111680,%eax
801029c5:	85 c0                	test   %eax,%eax
801029c7:	0f 84 c3 00 00 00    	je     80102a90 <lapicinit+0xd0>
  lapic[index] = value;
801029cd:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801029d4:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029d7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029da:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801029e1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029e4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029e7:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801029ee:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801029f1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801029f4:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801029fb:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801029fe:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a01:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102a08:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102a0b:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a0e:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102a15:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102a18:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102a1b:	8b 50 30             	mov    0x30(%eax),%edx
80102a1e:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
80102a24:	75 72                	jne    80102a98 <lapicinit+0xd8>
  lapic[index] = value;
80102a26:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102a2d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a30:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a33:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102a3a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a3d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a40:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102a47:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a4a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a4d:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102a54:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a57:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a5a:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102a61:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a64:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a67:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102a6e:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102a71:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102a78:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102a7e:	80 e6 10             	and    $0x10,%dh
80102a81:	75 f5                	jne    80102a78 <lapicinit+0xb8>
  lapic[index] = value;
80102a83:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102a8a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a8d:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102a90:	c3                   	ret
80102a91:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102a98:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102a9f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102aa2:	8b 50 20             	mov    0x20(%eax),%edx
}
80102aa5:	e9 7c ff ff ff       	jmp    80102a26 <lapicinit+0x66>
80102aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102ab0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102ab0:	a1 80 16 11 80       	mov    0x80111680,%eax
80102ab5:	85 c0                	test   %eax,%eax
80102ab7:	74 07                	je     80102ac0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80102ab9:	8b 40 20             	mov    0x20(%eax),%eax
80102abc:	c1 e8 18             	shr    $0x18,%eax
80102abf:	c3                   	ret
    return 0;
80102ac0:	31 c0                	xor    %eax,%eax
}
80102ac2:	c3                   	ret
80102ac3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102aca:	00 
80102acb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102ad0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102ad0:	a1 80 16 11 80       	mov    0x80111680,%eax
80102ad5:	85 c0                	test   %eax,%eax
80102ad7:	74 0d                	je     80102ae6 <lapiceoi+0x16>
  lapic[index] = value;
80102ad9:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102ae0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ae3:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102ae6:	c3                   	ret
80102ae7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102aee:	00 
80102aef:	90                   	nop

80102af0 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102af0:	c3                   	ret
80102af1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102af8:	00 
80102af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102b00 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102b00:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b01:	b8 0f 00 00 00       	mov    $0xf,%eax
80102b06:	ba 70 00 00 00       	mov    $0x70,%edx
80102b0b:	89 e5                	mov    %esp,%ebp
80102b0d:	53                   	push   %ebx
80102b0e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102b11:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102b14:	ee                   	out    %al,(%dx)
80102b15:	b8 0a 00 00 00       	mov    $0xa,%eax
80102b1a:	ba 71 00 00 00       	mov    $0x71,%edx
80102b1f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102b20:	31 c0                	xor    %eax,%eax
  lapic[index] = value;
80102b22:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102b25:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102b2b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102b2d:	c1 e9 0c             	shr    $0xc,%ecx
  lapic[index] = value;
80102b30:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102b32:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102b35:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102b38:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102b3e:	a1 80 16 11 80       	mov    0x80111680,%eax
80102b43:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b49:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b4c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102b53:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b56:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b59:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102b60:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b63:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b66:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b6c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b6f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b75:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102b78:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b7e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b81:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102b87:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102b8a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102b8d:	c9                   	leave
80102b8e:	c3                   	ret
80102b8f:	90                   	nop

80102b90 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102b90:	55                   	push   %ebp
80102b91:	b8 0b 00 00 00       	mov    $0xb,%eax
80102b96:	ba 70 00 00 00       	mov    $0x70,%edx
80102b9b:	89 e5                	mov    %esp,%ebp
80102b9d:	57                   	push   %edi
80102b9e:	56                   	push   %esi
80102b9f:	53                   	push   %ebx
80102ba0:	83 ec 4c             	sub    $0x4c,%esp
80102ba3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ba4:	ba 71 00 00 00       	mov    $0x71,%edx
80102ba9:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102baa:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bad:	bf 70 00 00 00       	mov    $0x70,%edi
80102bb2:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102bb5:	8d 76 00             	lea    0x0(%esi),%esi
80102bb8:	31 c0                	xor    %eax,%eax
80102bba:	89 fa                	mov    %edi,%edx
80102bbc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bbd:	b9 71 00 00 00       	mov    $0x71,%ecx
80102bc2:	89 ca                	mov    %ecx,%edx
80102bc4:	ec                   	in     (%dx),%al
80102bc5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bc8:	89 fa                	mov    %edi,%edx
80102bca:	b8 02 00 00 00       	mov    $0x2,%eax
80102bcf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bd0:	89 ca                	mov    %ecx,%edx
80102bd2:	ec                   	in     (%dx),%al
80102bd3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bd6:	89 fa                	mov    %edi,%edx
80102bd8:	b8 04 00 00 00       	mov    $0x4,%eax
80102bdd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bde:	89 ca                	mov    %ecx,%edx
80102be0:	ec                   	in     (%dx),%al
80102be1:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102be4:	89 fa                	mov    %edi,%edx
80102be6:	b8 07 00 00 00       	mov    $0x7,%eax
80102beb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bec:	89 ca                	mov    %ecx,%edx
80102bee:	ec                   	in     (%dx),%al
80102bef:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bf2:	89 fa                	mov    %edi,%edx
80102bf4:	b8 08 00 00 00       	mov    $0x8,%eax
80102bf9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102bfa:	89 ca                	mov    %ecx,%edx
80102bfc:	ec                   	in     (%dx),%al
80102bfd:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102bff:	89 fa                	mov    %edi,%edx
80102c01:	b8 09 00 00 00       	mov    $0x9,%eax
80102c06:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c07:	89 ca                	mov    %ecx,%edx
80102c09:	ec                   	in     (%dx),%al
80102c0a:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c0d:	89 fa                	mov    %edi,%edx
80102c0f:	b8 0a 00 00 00       	mov    $0xa,%eax
80102c14:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c15:	89 ca                	mov    %ecx,%edx
80102c17:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102c18:	84 c0                	test   %al,%al
80102c1a:	78 9c                	js     80102bb8 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102c1c:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102c20:	89 f2                	mov    %esi,%edx
80102c22:	89 5d cc             	mov    %ebx,-0x34(%ebp)
80102c25:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c28:	89 fa                	mov    %edi,%edx
80102c2a:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102c2d:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102c31:	89 75 c8             	mov    %esi,-0x38(%ebp)
80102c34:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102c37:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102c3b:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102c3e:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102c42:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102c45:	31 c0                	xor    %eax,%eax
80102c47:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c48:	89 ca                	mov    %ecx,%edx
80102c4a:	ec                   	in     (%dx),%al
80102c4b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c4e:	89 fa                	mov    %edi,%edx
80102c50:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102c53:	b8 02 00 00 00       	mov    $0x2,%eax
80102c58:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c59:	89 ca                	mov    %ecx,%edx
80102c5b:	ec                   	in     (%dx),%al
80102c5c:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c5f:	89 fa                	mov    %edi,%edx
80102c61:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102c64:	b8 04 00 00 00       	mov    $0x4,%eax
80102c69:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c6a:	89 ca                	mov    %ecx,%edx
80102c6c:	ec                   	in     (%dx),%al
80102c6d:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c70:	89 fa                	mov    %edi,%edx
80102c72:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102c75:	b8 07 00 00 00       	mov    $0x7,%eax
80102c7a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c7b:	89 ca                	mov    %ecx,%edx
80102c7d:	ec                   	in     (%dx),%al
80102c7e:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c81:	89 fa                	mov    %edi,%edx
80102c83:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102c86:	b8 08 00 00 00       	mov    $0x8,%eax
80102c8b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c8c:	89 ca                	mov    %ecx,%edx
80102c8e:	ec                   	in     (%dx),%al
80102c8f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c92:	89 fa                	mov    %edi,%edx
80102c94:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102c97:	b8 09 00 00 00       	mov    $0x9,%eax
80102c9c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c9d:	89 ca                	mov    %ecx,%edx
80102c9f:	ec                   	in     (%dx),%al
80102ca0:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102ca3:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102ca6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102ca9:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102cac:	6a 18                	push   $0x18
80102cae:	50                   	push   %eax
80102caf:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102cb2:	50                   	push   %eax
80102cb3:	e8 08 1c 00 00       	call   801048c0 <memcmp>
80102cb8:	83 c4 10             	add    $0x10,%esp
80102cbb:	85 c0                	test   %eax,%eax
80102cbd:	0f 85 f5 fe ff ff    	jne    80102bb8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102cc3:	0f b6 75 b3          	movzbl -0x4d(%ebp),%esi
80102cc7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102cca:	89 f0                	mov    %esi,%eax
80102ccc:	84 c0                	test   %al,%al
80102cce:	75 78                	jne    80102d48 <cmostime+0x1b8>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102cd0:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102cd3:	89 c2                	mov    %eax,%edx
80102cd5:	83 e0 0f             	and    $0xf,%eax
80102cd8:	c1 ea 04             	shr    $0x4,%edx
80102cdb:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102cde:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102ce1:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102ce4:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102ce7:	89 c2                	mov    %eax,%edx
80102ce9:	83 e0 0f             	and    $0xf,%eax
80102cec:	c1 ea 04             	shr    $0x4,%edx
80102cef:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102cf2:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102cf5:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102cf8:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102cfb:	89 c2                	mov    %eax,%edx
80102cfd:	83 e0 0f             	and    $0xf,%eax
80102d00:	c1 ea 04             	shr    $0x4,%edx
80102d03:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d06:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d09:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102d0c:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102d0f:	89 c2                	mov    %eax,%edx
80102d11:	83 e0 0f             	and    $0xf,%eax
80102d14:	c1 ea 04             	shr    $0x4,%edx
80102d17:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d1a:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d1d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102d20:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102d23:	89 c2                	mov    %eax,%edx
80102d25:	83 e0 0f             	and    $0xf,%eax
80102d28:	c1 ea 04             	shr    $0x4,%edx
80102d2b:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d2e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d31:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102d34:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102d37:	89 c2                	mov    %eax,%edx
80102d39:	83 e0 0f             	and    $0xf,%eax
80102d3c:	c1 ea 04             	shr    $0x4,%edx
80102d3f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d42:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d45:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102d48:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102d4b:	89 03                	mov    %eax,(%ebx)
80102d4d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102d50:	89 43 04             	mov    %eax,0x4(%ebx)
80102d53:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102d56:	89 43 08             	mov    %eax,0x8(%ebx)
80102d59:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102d5c:	89 43 0c             	mov    %eax,0xc(%ebx)
80102d5f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102d62:	89 43 10             	mov    %eax,0x10(%ebx)
80102d65:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102d68:	89 43 14             	mov    %eax,0x14(%ebx)
  r->year += 2000;
80102d6b:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
80102d72:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d75:	5b                   	pop    %ebx
80102d76:	5e                   	pop    %esi
80102d77:	5f                   	pop    %edi
80102d78:	5d                   	pop    %ebp
80102d79:	c3                   	ret
80102d7a:	66 90                	xchg   %ax,%ax
80102d7c:	66 90                	xchg   %ax,%ax
80102d7e:	66 90                	xchg   %ax,%ax

80102d80 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102d80:	8b 0d e8 16 11 80    	mov    0x801116e8,%ecx
80102d86:	85 c9                	test   %ecx,%ecx
80102d88:	0f 8e 8a 00 00 00    	jle    80102e18 <install_trans+0x98>
{
80102d8e:	55                   	push   %ebp
80102d8f:	89 e5                	mov    %esp,%ebp
80102d91:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102d92:	31 ff                	xor    %edi,%edi
{
80102d94:	56                   	push   %esi
80102d95:	53                   	push   %ebx
80102d96:	83 ec 0c             	sub    $0xc,%esp
80102d99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102da0:	a1 d4 16 11 80       	mov    0x801116d4,%eax
80102da5:	83 ec 08             	sub    $0x8,%esp
80102da8:	01 f8                	add    %edi,%eax
80102daa:	83 c0 01             	add    $0x1,%eax
80102dad:	50                   	push   %eax
80102dae:	ff 35 e4 16 11 80    	push   0x801116e4
80102db4:	e8 17 d3 ff ff       	call   801000d0 <bread>
80102db9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102dbb:	58                   	pop    %eax
80102dbc:	5a                   	pop    %edx
80102dbd:	ff 34 bd ec 16 11 80 	push   -0x7feee914(,%edi,4)
80102dc4:	ff 35 e4 16 11 80    	push   0x801116e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102dca:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102dcd:	e8 fe d2 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102dd2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102dd5:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102dd7:	8d 46 5c             	lea    0x5c(%esi),%eax
80102dda:	68 00 02 00 00       	push   $0x200
80102ddf:	50                   	push   %eax
80102de0:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102de3:	50                   	push   %eax
80102de4:	e8 27 1b 00 00       	call   80104910 <memmove>
    bwrite(dbuf);  // write dst to disk
80102de9:	89 1c 24             	mov    %ebx,(%esp)
80102dec:	e8 bf d3 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102df1:	89 34 24             	mov    %esi,(%esp)
80102df4:	e8 f7 d3 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102df9:	89 1c 24             	mov    %ebx,(%esp)
80102dfc:	e8 ef d3 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102e01:	83 c4 10             	add    $0x10,%esp
80102e04:	39 3d e8 16 11 80    	cmp    %edi,0x801116e8
80102e0a:	7f 94                	jg     80102da0 <install_trans+0x20>
  }
}
80102e0c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e0f:	5b                   	pop    %ebx
80102e10:	5e                   	pop    %esi
80102e11:	5f                   	pop    %edi
80102e12:	5d                   	pop    %ebp
80102e13:	c3                   	ret
80102e14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102e18:	c3                   	ret
80102e19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102e20 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102e20:	55                   	push   %ebp
80102e21:	89 e5                	mov    %esp,%ebp
80102e23:	53                   	push   %ebx
80102e24:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102e27:	ff 35 d4 16 11 80    	push   0x801116d4
80102e2d:	ff 35 e4 16 11 80    	push   0x801116e4
80102e33:	e8 98 d2 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102e38:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102e3b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102e3d:	a1 e8 16 11 80       	mov    0x801116e8,%eax
80102e42:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102e45:	85 c0                	test   %eax,%eax
80102e47:	7e 19                	jle    80102e62 <write_head+0x42>
80102e49:	31 d2                	xor    %edx,%edx
80102e4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102e50:	8b 0c 95 ec 16 11 80 	mov    -0x7feee914(,%edx,4),%ecx
80102e57:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102e5b:	83 c2 01             	add    $0x1,%edx
80102e5e:	39 d0                	cmp    %edx,%eax
80102e60:	75 ee                	jne    80102e50 <write_head+0x30>
  }
  bwrite(buf);
80102e62:	83 ec 0c             	sub    $0xc,%esp
80102e65:	53                   	push   %ebx
80102e66:	e8 45 d3 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102e6b:	89 1c 24             	mov    %ebx,(%esp)
80102e6e:	e8 7d d3 ff ff       	call   801001f0 <brelse>
}
80102e73:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e76:	83 c4 10             	add    $0x10,%esp
80102e79:	c9                   	leave
80102e7a:	c3                   	ret
80102e7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102e80 <initlog>:
{
80102e80:	55                   	push   %ebp
80102e81:	89 e5                	mov    %esp,%ebp
80102e83:	53                   	push   %ebx
80102e84:	83 ec 2c             	sub    $0x2c,%esp
80102e87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102e8a:	68 17 75 10 80       	push   $0x80107517
80102e8f:	68 a0 16 11 80       	push   $0x801116a0
80102e94:	e8 f7 16 00 00       	call   80104590 <initlock>
  readsb(dev, &sb);
80102e99:	58                   	pop    %eax
80102e9a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102e9d:	5a                   	pop    %edx
80102e9e:	50                   	push   %eax
80102e9f:	53                   	push   %ebx
80102ea0:	e8 6b e8 ff ff       	call   80101710 <readsb>
  log.start = sb.logstart;
80102ea5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102ea8:	59                   	pop    %ecx
  log.dev = dev;
80102ea9:	89 1d e4 16 11 80    	mov    %ebx,0x801116e4
  log.size = sb.nlog;
80102eaf:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102eb2:	a3 d4 16 11 80       	mov    %eax,0x801116d4
  log.size = sb.nlog;
80102eb7:	89 15 d8 16 11 80    	mov    %edx,0x801116d8
  struct buf *buf = bread(log.dev, log.start);
80102ebd:	5a                   	pop    %edx
80102ebe:	50                   	push   %eax
80102ebf:	53                   	push   %ebx
80102ec0:	e8 0b d2 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102ec5:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102ec8:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102ecb:	89 1d e8 16 11 80    	mov    %ebx,0x801116e8
  for (i = 0; i < log.lh.n; i++) {
80102ed1:	85 db                	test   %ebx,%ebx
80102ed3:	7e 1d                	jle    80102ef2 <initlog+0x72>
80102ed5:	31 d2                	xor    %edx,%edx
80102ed7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102ede:	00 
80102edf:	90                   	nop
    log.lh.block[i] = lh->block[i];
80102ee0:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102ee4:	89 0c 95 ec 16 11 80 	mov    %ecx,-0x7feee914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102eeb:	83 c2 01             	add    $0x1,%edx
80102eee:	39 d3                	cmp    %edx,%ebx
80102ef0:	75 ee                	jne    80102ee0 <initlog+0x60>
  brelse(buf);
80102ef2:	83 ec 0c             	sub    $0xc,%esp
80102ef5:	50                   	push   %eax
80102ef6:	e8 f5 d2 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102efb:	e8 80 fe ff ff       	call   80102d80 <install_trans>
  log.lh.n = 0;
80102f00:	c7 05 e8 16 11 80 00 	movl   $0x0,0x801116e8
80102f07:	00 00 00 
  write_head(); // clear the log
80102f0a:	e8 11 ff ff ff       	call   80102e20 <write_head>
}
80102f0f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f12:	83 c4 10             	add    $0x10,%esp
80102f15:	c9                   	leave
80102f16:	c3                   	ret
80102f17:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f1e:	00 
80102f1f:	90                   	nop

80102f20 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102f20:	55                   	push   %ebp
80102f21:	89 e5                	mov    %esp,%ebp
80102f23:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102f26:	68 a0 16 11 80       	push   $0x801116a0
80102f2b:	e8 50 18 00 00       	call   80104780 <acquire>
80102f30:	83 c4 10             	add    $0x10,%esp
80102f33:	eb 18                	jmp    80102f4d <begin_op+0x2d>
80102f35:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102f38:	83 ec 08             	sub    $0x8,%esp
80102f3b:	68 a0 16 11 80       	push   $0x801116a0
80102f40:	68 a0 16 11 80       	push   $0x801116a0
80102f45:	e8 b6 12 00 00       	call   80104200 <sleep>
80102f4a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102f4d:	a1 e0 16 11 80       	mov    0x801116e0,%eax
80102f52:	85 c0                	test   %eax,%eax
80102f54:	75 e2                	jne    80102f38 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102f56:	a1 dc 16 11 80       	mov    0x801116dc,%eax
80102f5b:	8b 15 e8 16 11 80    	mov    0x801116e8,%edx
80102f61:	83 c0 01             	add    $0x1,%eax
80102f64:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102f67:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102f6a:	83 fa 1e             	cmp    $0x1e,%edx
80102f6d:	7f c9                	jg     80102f38 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102f6f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102f72:	a3 dc 16 11 80       	mov    %eax,0x801116dc
      release(&log.lock);
80102f77:	68 a0 16 11 80       	push   $0x801116a0
80102f7c:	e8 9f 17 00 00       	call   80104720 <release>
      break;
    }
  }
}
80102f81:	83 c4 10             	add    $0x10,%esp
80102f84:	c9                   	leave
80102f85:	c3                   	ret
80102f86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f8d:	00 
80102f8e:	66 90                	xchg   %ax,%ax

80102f90 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102f90:	55                   	push   %ebp
80102f91:	89 e5                	mov    %esp,%ebp
80102f93:	57                   	push   %edi
80102f94:	56                   	push   %esi
80102f95:	53                   	push   %ebx
80102f96:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102f99:	68 a0 16 11 80       	push   $0x801116a0
80102f9e:	e8 dd 17 00 00       	call   80104780 <acquire>
  log.outstanding -= 1;
80102fa3:	a1 dc 16 11 80       	mov    0x801116dc,%eax
  if(log.committing)
80102fa8:	8b 35 e0 16 11 80    	mov    0x801116e0,%esi
80102fae:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102fb1:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102fb4:	89 1d dc 16 11 80    	mov    %ebx,0x801116dc
  if(log.committing)
80102fba:	85 f6                	test   %esi,%esi
80102fbc:	0f 85 22 01 00 00    	jne    801030e4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102fc2:	85 db                	test   %ebx,%ebx
80102fc4:	0f 85 f6 00 00 00    	jne    801030c0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102fca:	c7 05 e0 16 11 80 01 	movl   $0x1,0x801116e0
80102fd1:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102fd4:	83 ec 0c             	sub    $0xc,%esp
80102fd7:	68 a0 16 11 80       	push   $0x801116a0
80102fdc:	e8 3f 17 00 00       	call   80104720 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102fe1:	8b 0d e8 16 11 80    	mov    0x801116e8,%ecx
80102fe7:	83 c4 10             	add    $0x10,%esp
80102fea:	85 c9                	test   %ecx,%ecx
80102fec:	7f 42                	jg     80103030 <end_op+0xa0>
    acquire(&log.lock);
80102fee:	83 ec 0c             	sub    $0xc,%esp
80102ff1:	68 a0 16 11 80       	push   $0x801116a0
80102ff6:	e8 85 17 00 00       	call   80104780 <acquire>
    log.committing = 0;
80102ffb:	c7 05 e0 16 11 80 00 	movl   $0x0,0x801116e0
80103002:	00 00 00 
    wakeup(&log);
80103005:	c7 04 24 a0 16 11 80 	movl   $0x801116a0,(%esp)
8010300c:	e8 af 12 00 00       	call   801042c0 <wakeup>
    release(&log.lock);
80103011:	c7 04 24 a0 16 11 80 	movl   $0x801116a0,(%esp)
80103018:	e8 03 17 00 00       	call   80104720 <release>
8010301d:	83 c4 10             	add    $0x10,%esp
}
80103020:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103023:	5b                   	pop    %ebx
80103024:	5e                   	pop    %esi
80103025:	5f                   	pop    %edi
80103026:	5d                   	pop    %ebp
80103027:	c3                   	ret
80103028:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010302f:	00 
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103030:	a1 d4 16 11 80       	mov    0x801116d4,%eax
80103035:	83 ec 08             	sub    $0x8,%esp
80103038:	01 d8                	add    %ebx,%eax
8010303a:	83 c0 01             	add    $0x1,%eax
8010303d:	50                   	push   %eax
8010303e:	ff 35 e4 16 11 80    	push   0x801116e4
80103044:	e8 87 d0 ff ff       	call   801000d0 <bread>
80103049:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010304b:	58                   	pop    %eax
8010304c:	5a                   	pop    %edx
8010304d:	ff 34 9d ec 16 11 80 	push   -0x7feee914(,%ebx,4)
80103054:	ff 35 e4 16 11 80    	push   0x801116e4
  for (tail = 0; tail < log.lh.n; tail++) {
8010305a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
8010305d:	e8 6e d0 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103062:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103065:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103067:	8d 40 5c             	lea    0x5c(%eax),%eax
8010306a:	68 00 02 00 00       	push   $0x200
8010306f:	50                   	push   %eax
80103070:	8d 46 5c             	lea    0x5c(%esi),%eax
80103073:	50                   	push   %eax
80103074:	e8 97 18 00 00       	call   80104910 <memmove>
    bwrite(to);  // write the log
80103079:	89 34 24             	mov    %esi,(%esp)
8010307c:	e8 2f d1 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103081:	89 3c 24             	mov    %edi,(%esp)
80103084:	e8 67 d1 ff ff       	call   801001f0 <brelse>
    brelse(to);
80103089:	89 34 24             	mov    %esi,(%esp)
8010308c:	e8 5f d1 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103091:	83 c4 10             	add    $0x10,%esp
80103094:	3b 1d e8 16 11 80    	cmp    0x801116e8,%ebx
8010309a:	7c 94                	jl     80103030 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
8010309c:	e8 7f fd ff ff       	call   80102e20 <write_head>
    install_trans(); // Now install writes to home locations
801030a1:	e8 da fc ff ff       	call   80102d80 <install_trans>
    log.lh.n = 0;
801030a6:	c7 05 e8 16 11 80 00 	movl   $0x0,0x801116e8
801030ad:	00 00 00 
    write_head();    // Erase the transaction from the log
801030b0:	e8 6b fd ff ff       	call   80102e20 <write_head>
801030b5:	e9 34 ff ff ff       	jmp    80102fee <end_op+0x5e>
801030ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
801030c0:	83 ec 0c             	sub    $0xc,%esp
801030c3:	68 a0 16 11 80       	push   $0x801116a0
801030c8:	e8 f3 11 00 00       	call   801042c0 <wakeup>
  release(&log.lock);
801030cd:	c7 04 24 a0 16 11 80 	movl   $0x801116a0,(%esp)
801030d4:	e8 47 16 00 00       	call   80104720 <release>
801030d9:	83 c4 10             	add    $0x10,%esp
}
801030dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030df:	5b                   	pop    %ebx
801030e0:	5e                   	pop    %esi
801030e1:	5f                   	pop    %edi
801030e2:	5d                   	pop    %ebp
801030e3:	c3                   	ret
    panic("log.committing");
801030e4:	83 ec 0c             	sub    $0xc,%esp
801030e7:	68 1b 75 10 80       	push   $0x8010751b
801030ec:	e8 8f d2 ff ff       	call   80100380 <panic>
801030f1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801030f8:	00 
801030f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103100 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80103100:	55                   	push   %ebp
80103101:	89 e5                	mov    %esp,%ebp
80103103:	53                   	push   %ebx
80103104:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103107:	8b 15 e8 16 11 80    	mov    0x801116e8,%edx
{
8010310d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103110:	83 fa 1d             	cmp    $0x1d,%edx
80103113:	7f 7d                	jg     80103192 <log_write+0x92>
80103115:	a1 d8 16 11 80       	mov    0x801116d8,%eax
8010311a:	83 e8 01             	sub    $0x1,%eax
8010311d:	39 c2                	cmp    %eax,%edx
8010311f:	7d 71                	jge    80103192 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103121:	a1 dc 16 11 80       	mov    0x801116dc,%eax
80103126:	85 c0                	test   %eax,%eax
80103128:	7e 75                	jle    8010319f <log_write+0x9f>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010312a:	83 ec 0c             	sub    $0xc,%esp
8010312d:	68 a0 16 11 80       	push   $0x801116a0
80103132:	e8 49 16 00 00       	call   80104780 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103137:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
8010313a:	83 c4 10             	add    $0x10,%esp
8010313d:	31 c0                	xor    %eax,%eax
8010313f:	8b 15 e8 16 11 80    	mov    0x801116e8,%edx
80103145:	85 d2                	test   %edx,%edx
80103147:	7f 0e                	jg     80103157 <log_write+0x57>
80103149:	eb 15                	jmp    80103160 <log_write+0x60>
8010314b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103150:	83 c0 01             	add    $0x1,%eax
80103153:	39 c2                	cmp    %eax,%edx
80103155:	74 29                	je     80103180 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103157:	39 0c 85 ec 16 11 80 	cmp    %ecx,-0x7feee914(,%eax,4)
8010315e:	75 f0                	jne    80103150 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80103160:	89 0c 85 ec 16 11 80 	mov    %ecx,-0x7feee914(,%eax,4)
  if (i == log.lh.n)
80103167:	39 c2                	cmp    %eax,%edx
80103169:	74 1c                	je     80103187 <log_write+0x87>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
8010316b:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
8010316e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80103171:	c7 45 08 a0 16 11 80 	movl   $0x801116a0,0x8(%ebp)
}
80103178:	c9                   	leave
  release(&log.lock);
80103179:	e9 a2 15 00 00       	jmp    80104720 <release>
8010317e:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno;
80103180:	89 0c 95 ec 16 11 80 	mov    %ecx,-0x7feee914(,%edx,4)
    log.lh.n++;
80103187:	83 c2 01             	add    $0x1,%edx
8010318a:	89 15 e8 16 11 80    	mov    %edx,0x801116e8
80103190:	eb d9                	jmp    8010316b <log_write+0x6b>
    panic("too big a transaction");
80103192:	83 ec 0c             	sub    $0xc,%esp
80103195:	68 2a 75 10 80       	push   $0x8010752a
8010319a:	e8 e1 d1 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
8010319f:	83 ec 0c             	sub    $0xc,%esp
801031a2:	68 40 75 10 80       	push   $0x80107540
801031a7:	e8 d4 d1 ff ff       	call   80100380 <panic>
801031ac:	66 90                	xchg   %ax,%ax
801031ae:	66 90                	xchg   %ax,%ax

801031b0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801031b0:	55                   	push   %ebp
801031b1:	89 e5                	mov    %esp,%ebp
801031b3:	53                   	push   %ebx
801031b4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801031b7:	e8 64 09 00 00       	call   80103b20 <cpuid>
801031bc:	89 c3                	mov    %eax,%ebx
801031be:	e8 5d 09 00 00       	call   80103b20 <cpuid>
801031c3:	83 ec 04             	sub    $0x4,%esp
801031c6:	53                   	push   %ebx
801031c7:	50                   	push   %eax
801031c8:	68 5b 75 10 80       	push   $0x8010755b
801031cd:	e8 9e d4 ff ff       	call   80100670 <cprintf>
  idtinit();       // load idt register
801031d2:	e8 e9 28 00 00       	call   80105ac0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801031d7:	e8 e4 08 00 00       	call   80103ac0 <mycpu>
801031dc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801031de:	b8 01 00 00 00       	mov    $0x1,%eax
801031e3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
801031ea:	e8 01 0c 00 00       	call   80103df0 <scheduler>
801031ef:	90                   	nop

801031f0 <mpenter>:
{
801031f0:	55                   	push   %ebp
801031f1:	89 e5                	mov    %esp,%ebp
801031f3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
801031f6:	e8 c5 39 00 00       	call   80106bc0 <switchkvm>
  seginit();
801031fb:	e8 30 39 00 00       	call   80106b30 <seginit>
  lapicinit();
80103200:	e8 bb f7 ff ff       	call   801029c0 <lapicinit>
  mpmain();
80103205:	e8 a6 ff ff ff       	call   801031b0 <mpmain>
8010320a:	66 90                	xchg   %ax,%ax
8010320c:	66 90                	xchg   %ax,%ax
8010320e:	66 90                	xchg   %ax,%ax

80103210 <main>:
{
80103210:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103214:	83 e4 f0             	and    $0xfffffff0,%esp
80103217:	ff 71 fc             	push   -0x4(%ecx)
8010321a:	55                   	push   %ebp
8010321b:	89 e5                	mov    %esp,%ebp
8010321d:	53                   	push   %ebx
8010321e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010321f:	83 ec 08             	sub    $0x8,%esp
80103222:	68 00 00 40 80       	push   $0x80400000
80103227:	68 d0 54 11 80       	push   $0x801154d0
8010322c:	e8 9f f5 ff ff       	call   801027d0 <kinit1>
  kvmalloc();      // kernel page table
80103231:	e8 4a 3e 00 00       	call   80107080 <kvmalloc>
  mpinit();        // detect other processors
80103236:	e8 85 01 00 00       	call   801033c0 <mpinit>
  lapicinit();     // interrupt controller
8010323b:	e8 80 f7 ff ff       	call   801029c0 <lapicinit>
  seginit();       // segment descriptors
80103240:	e8 eb 38 00 00       	call   80106b30 <seginit>
  picinit();       // disable pic
80103245:	e8 86 03 00 00       	call   801035d0 <picinit>
  ioapicinit();    // another interrupt controller
8010324a:	e8 51 f3 ff ff       	call   801025a0 <ioapicinit>
  consoleinit();   // console hardware
8010324f:	e8 dc d9 ff ff       	call   80100c30 <consoleinit>
  uartinit();      // serial port
80103254:	e8 47 2b 00 00       	call   80105da0 <uartinit>
  pinit();         // process table
80103259:	e8 42 08 00 00       	call   80103aa0 <pinit>
  tvinit();        // trap vectors
8010325e:	e8 dd 27 00 00       	call   80105a40 <tvinit>
  binit();         // buffer cache
80103263:	e8 d8 cd ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103268:	e8 93 dd ff ff       	call   80101000 <fileinit>
  ideinit();       // disk 
8010326d:	e8 0e f1 ff ff       	call   80102380 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103272:	83 c4 0c             	add    $0xc,%esp
80103275:	68 8a 00 00 00       	push   $0x8a
8010327a:	68 8c a4 10 80       	push   $0x8010a48c
8010327f:	68 00 70 00 80       	push   $0x80007000
80103284:	e8 87 16 00 00       	call   80104910 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103289:	83 c4 10             	add    $0x10,%esp
8010328c:	69 05 84 17 11 80 b0 	imul   $0xb0,0x80111784,%eax
80103293:	00 00 00 
80103296:	05 a0 17 11 80       	add    $0x801117a0,%eax
8010329b:	3d a0 17 11 80       	cmp    $0x801117a0,%eax
801032a0:	76 7e                	jbe    80103320 <main+0x110>
801032a2:	bb a0 17 11 80       	mov    $0x801117a0,%ebx
801032a7:	eb 20                	jmp    801032c9 <main+0xb9>
801032a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801032b0:	69 05 84 17 11 80 b0 	imul   $0xb0,0x80111784,%eax
801032b7:	00 00 00 
801032ba:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801032c0:	05 a0 17 11 80       	add    $0x801117a0,%eax
801032c5:	39 c3                	cmp    %eax,%ebx
801032c7:	73 57                	jae    80103320 <main+0x110>
    if(c == mycpu())  // We've started already.
801032c9:	e8 f2 07 00 00       	call   80103ac0 <mycpu>
801032ce:	39 c3                	cmp    %eax,%ebx
801032d0:	74 de                	je     801032b0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801032d2:	e8 69 f5 ff ff       	call   80102840 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
801032d7:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
801032da:	c7 05 f8 6f 00 80 f0 	movl   $0x801031f0,0x80006ff8
801032e1:	31 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801032e4:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
801032eb:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
801032ee:	05 00 10 00 00       	add    $0x1000,%eax
801032f3:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
801032f8:	0f b6 03             	movzbl (%ebx),%eax
801032fb:	68 00 70 00 00       	push   $0x7000
80103300:	50                   	push   %eax
80103301:	e8 fa f7 ff ff       	call   80102b00 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80103306:	83 c4 10             	add    $0x10,%esp
80103309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103310:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103316:	85 c0                	test   %eax,%eax
80103318:	74 f6                	je     80103310 <main+0x100>
8010331a:	eb 94                	jmp    801032b0 <main+0xa0>
8010331c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103320:	83 ec 08             	sub    $0x8,%esp
80103323:	68 00 00 00 8e       	push   $0x8e000000
80103328:	68 00 00 40 80       	push   $0x80400000
8010332d:	e8 3e f4 ff ff       	call   80102770 <kinit2>
  userinit();      // first user process
80103332:	e8 39 08 00 00       	call   80103b70 <userinit>
  mpmain();        // finish this processor's setup
80103337:	e8 74 fe ff ff       	call   801031b0 <mpmain>
8010333c:	66 90                	xchg   %ax,%ax
8010333e:	66 90                	xchg   %ax,%ax

80103340 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103340:	55                   	push   %ebp
80103341:	89 e5                	mov    %esp,%ebp
80103343:	57                   	push   %edi
80103344:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103345:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010334b:	53                   	push   %ebx
  e = addr+len;
8010334c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010334f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103352:	39 de                	cmp    %ebx,%esi
80103354:	72 10                	jb     80103366 <mpsearch1+0x26>
80103356:	eb 50                	jmp    801033a8 <mpsearch1+0x68>
80103358:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010335f:	00 
80103360:	89 fe                	mov    %edi,%esi
80103362:	39 df                	cmp    %ebx,%edi
80103364:	73 42                	jae    801033a8 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103366:	83 ec 04             	sub    $0x4,%esp
80103369:	8d 7e 10             	lea    0x10(%esi),%edi
8010336c:	6a 04                	push   $0x4
8010336e:	68 6f 75 10 80       	push   $0x8010756f
80103373:	56                   	push   %esi
80103374:	e8 47 15 00 00       	call   801048c0 <memcmp>
80103379:	83 c4 10             	add    $0x10,%esp
8010337c:	85 c0                	test   %eax,%eax
8010337e:	75 e0                	jne    80103360 <mpsearch1+0x20>
80103380:	89 f2                	mov    %esi,%edx
80103382:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103388:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
8010338b:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
8010338e:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103390:	39 fa                	cmp    %edi,%edx
80103392:	75 f4                	jne    80103388 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103394:	84 c0                	test   %al,%al
80103396:	75 c8                	jne    80103360 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103398:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010339b:	89 f0                	mov    %esi,%eax
8010339d:	5b                   	pop    %ebx
8010339e:	5e                   	pop    %esi
8010339f:	5f                   	pop    %edi
801033a0:	5d                   	pop    %ebp
801033a1:	c3                   	ret
801033a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801033a8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801033ab:	31 f6                	xor    %esi,%esi
}
801033ad:	5b                   	pop    %ebx
801033ae:	89 f0                	mov    %esi,%eax
801033b0:	5e                   	pop    %esi
801033b1:	5f                   	pop    %edi
801033b2:	5d                   	pop    %ebp
801033b3:	c3                   	ret
801033b4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801033bb:	00 
801033bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801033c0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801033c0:	55                   	push   %ebp
801033c1:	89 e5                	mov    %esp,%ebp
801033c3:	57                   	push   %edi
801033c4:	56                   	push   %esi
801033c5:	53                   	push   %ebx
801033c6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801033c9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801033d0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801033d7:	c1 e0 08             	shl    $0x8,%eax
801033da:	09 d0                	or     %edx,%eax
801033dc:	c1 e0 04             	shl    $0x4,%eax
801033df:	75 1b                	jne    801033fc <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801033e1:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801033e8:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801033ef:	c1 e0 08             	shl    $0x8,%eax
801033f2:	09 d0                	or     %edx,%eax
801033f4:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801033f7:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801033fc:	ba 00 04 00 00       	mov    $0x400,%edx
80103401:	e8 3a ff ff ff       	call   80103340 <mpsearch1>
80103406:	89 c3                	mov    %eax,%ebx
80103408:	85 c0                	test   %eax,%eax
8010340a:	0f 84 58 01 00 00    	je     80103568 <mpinit+0x1a8>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103410:	8b 73 04             	mov    0x4(%ebx),%esi
80103413:	85 f6                	test   %esi,%esi
80103415:	0f 84 3d 01 00 00    	je     80103558 <mpinit+0x198>
  if(memcmp(conf, "PCMP", 4) != 0)
8010341b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010341e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80103424:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103427:	6a 04                	push   $0x4
80103429:	68 74 75 10 80       	push   $0x80107574
8010342e:	50                   	push   %eax
8010342f:	e8 8c 14 00 00       	call   801048c0 <memcmp>
80103434:	83 c4 10             	add    $0x10,%esp
80103437:	85 c0                	test   %eax,%eax
80103439:	0f 85 19 01 00 00    	jne    80103558 <mpinit+0x198>
  if(conf->version != 1 && conf->version != 4)
8010343f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103446:	3c 01                	cmp    $0x1,%al
80103448:	74 08                	je     80103452 <mpinit+0x92>
8010344a:	3c 04                	cmp    $0x4,%al
8010344c:	0f 85 06 01 00 00    	jne    80103558 <mpinit+0x198>
  if(sum((uchar*)conf, conf->length) != 0)
80103452:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80103459:	66 85 d2             	test   %dx,%dx
8010345c:	74 22                	je     80103480 <mpinit+0xc0>
8010345e:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80103461:	89 f0                	mov    %esi,%eax
  sum = 0;
80103463:	31 d2                	xor    %edx,%edx
80103465:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103468:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
8010346f:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103472:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103474:	39 f8                	cmp    %edi,%eax
80103476:	75 f0                	jne    80103468 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103478:	84 d2                	test   %dl,%dl
8010347a:	0f 85 d8 00 00 00    	jne    80103558 <mpinit+0x198>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103480:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103486:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103489:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  lapic = (uint*)conf->lapicaddr;
8010348c:	a3 80 16 11 80       	mov    %eax,0x80111680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103491:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103498:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
8010349e:	01 d7                	add    %edx,%edi
801034a0:	89 fa                	mov    %edi,%edx
  ismp = 1;
801034a2:	bf 01 00 00 00       	mov    $0x1,%edi
801034a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801034ae:	00 
801034af:	90                   	nop
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801034b0:	39 d0                	cmp    %edx,%eax
801034b2:	73 19                	jae    801034cd <mpinit+0x10d>
    switch(*p){
801034b4:	0f b6 08             	movzbl (%eax),%ecx
801034b7:	80 f9 02             	cmp    $0x2,%cl
801034ba:	0f 84 80 00 00 00    	je     80103540 <mpinit+0x180>
801034c0:	77 6e                	ja     80103530 <mpinit+0x170>
801034c2:	84 c9                	test   %cl,%cl
801034c4:	74 3a                	je     80103500 <mpinit+0x140>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801034c6:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801034c9:	39 d0                	cmp    %edx,%eax
801034cb:	72 e7                	jb     801034b4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801034cd:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801034d0:	85 ff                	test   %edi,%edi
801034d2:	0f 84 dd 00 00 00    	je     801035b5 <mpinit+0x1f5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801034d8:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
801034dc:	74 15                	je     801034f3 <mpinit+0x133>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801034de:	b8 70 00 00 00       	mov    $0x70,%eax
801034e3:	ba 22 00 00 00       	mov    $0x22,%edx
801034e8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801034e9:	ba 23 00 00 00       	mov    $0x23,%edx
801034ee:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801034ef:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801034f2:	ee                   	out    %al,(%dx)
  }
}
801034f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801034f6:	5b                   	pop    %ebx
801034f7:	5e                   	pop    %esi
801034f8:	5f                   	pop    %edi
801034f9:	5d                   	pop    %ebp
801034fa:	c3                   	ret
801034fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
80103500:	8b 0d 84 17 11 80    	mov    0x80111784,%ecx
80103506:	83 f9 07             	cmp    $0x7,%ecx
80103509:	7f 19                	jg     80103524 <mpinit+0x164>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010350b:	69 f1 b0 00 00 00    	imul   $0xb0,%ecx,%esi
80103511:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103515:	83 c1 01             	add    $0x1,%ecx
80103518:	89 0d 84 17 11 80    	mov    %ecx,0x80111784
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010351e:	88 9e a0 17 11 80    	mov    %bl,-0x7feee860(%esi)
      p += sizeof(struct mpproc);
80103524:	83 c0 14             	add    $0x14,%eax
      continue;
80103527:	eb 87                	jmp    801034b0 <mpinit+0xf0>
80103529:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(*p){
80103530:	83 e9 03             	sub    $0x3,%ecx
80103533:	80 f9 01             	cmp    $0x1,%cl
80103536:	76 8e                	jbe    801034c6 <mpinit+0x106>
80103538:	31 ff                	xor    %edi,%edi
8010353a:	e9 71 ff ff ff       	jmp    801034b0 <mpinit+0xf0>
8010353f:	90                   	nop
      ioapicid = ioapic->apicno;
80103540:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103544:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103547:	88 0d 80 17 11 80    	mov    %cl,0x80111780
      continue;
8010354d:	e9 5e ff ff ff       	jmp    801034b0 <mpinit+0xf0>
80103552:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103558:	83 ec 0c             	sub    $0xc,%esp
8010355b:	68 79 75 10 80       	push   $0x80107579
80103560:	e8 1b ce ff ff       	call   80100380 <panic>
80103565:	8d 76 00             	lea    0x0(%esi),%esi
{
80103568:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
8010356d:	eb 0b                	jmp    8010357a <mpinit+0x1ba>
8010356f:	90                   	nop
  for(p = addr; p < e; p += sizeof(struct mp))
80103570:	89 f3                	mov    %esi,%ebx
80103572:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103578:	74 de                	je     80103558 <mpinit+0x198>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010357a:	83 ec 04             	sub    $0x4,%esp
8010357d:	8d 73 10             	lea    0x10(%ebx),%esi
80103580:	6a 04                	push   $0x4
80103582:	68 6f 75 10 80       	push   $0x8010756f
80103587:	53                   	push   %ebx
80103588:	e8 33 13 00 00       	call   801048c0 <memcmp>
8010358d:	83 c4 10             	add    $0x10,%esp
80103590:	85 c0                	test   %eax,%eax
80103592:	75 dc                	jne    80103570 <mpinit+0x1b0>
80103594:	89 da                	mov    %ebx,%edx
80103596:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010359d:	00 
8010359e:	66 90                	xchg   %ax,%ax
    sum += addr[i];
801035a0:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
801035a3:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
801035a6:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
801035a8:	39 d6                	cmp    %edx,%esi
801035aa:	75 f4                	jne    801035a0 <mpinit+0x1e0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
801035ac:	84 c0                	test   %al,%al
801035ae:	75 c0                	jne    80103570 <mpinit+0x1b0>
801035b0:	e9 5b fe ff ff       	jmp    80103410 <mpinit+0x50>
    panic("Didn't find a suitable machine");
801035b5:	83 ec 0c             	sub    $0xc,%esp
801035b8:	68 10 79 10 80       	push   $0x80107910
801035bd:	e8 be cd ff ff       	call   80100380 <panic>
801035c2:	66 90                	xchg   %ax,%ax
801035c4:	66 90                	xchg   %ax,%ax
801035c6:	66 90                	xchg   %ax,%ax
801035c8:	66 90                	xchg   %ax,%ax
801035ca:	66 90                	xchg   %ax,%ax
801035cc:	66 90                	xchg   %ax,%ax
801035ce:	66 90                	xchg   %ax,%ax

801035d0 <picinit>:
801035d0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801035d5:	ba 21 00 00 00       	mov    $0x21,%edx
801035da:	ee                   	out    %al,(%dx)
801035db:	ba a1 00 00 00       	mov    $0xa1,%edx
801035e0:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801035e1:	c3                   	ret
801035e2:	66 90                	xchg   %ax,%ax
801035e4:	66 90                	xchg   %ax,%ax
801035e6:	66 90                	xchg   %ax,%ax
801035e8:	66 90                	xchg   %ax,%ax
801035ea:	66 90                	xchg   %ax,%ax
801035ec:	66 90                	xchg   %ax,%ax
801035ee:	66 90                	xchg   %ax,%ax

801035f0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801035f0:	55                   	push   %ebp
801035f1:	89 e5                	mov    %esp,%ebp
801035f3:	57                   	push   %edi
801035f4:	56                   	push   %esi
801035f5:	53                   	push   %ebx
801035f6:	83 ec 0c             	sub    $0xc,%esp
801035f9:	8b 75 08             	mov    0x8(%ebp),%esi
801035fc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801035ff:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80103605:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010360b:	e8 10 da ff ff       	call   80101020 <filealloc>
80103610:	89 06                	mov    %eax,(%esi)
80103612:	85 c0                	test   %eax,%eax
80103614:	0f 84 a5 00 00 00    	je     801036bf <pipealloc+0xcf>
8010361a:	e8 01 da ff ff       	call   80101020 <filealloc>
8010361f:	89 07                	mov    %eax,(%edi)
80103621:	85 c0                	test   %eax,%eax
80103623:	0f 84 84 00 00 00    	je     801036ad <pipealloc+0xbd>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103629:	e8 12 f2 ff ff       	call   80102840 <kalloc>
8010362e:	89 c3                	mov    %eax,%ebx
80103630:	85 c0                	test   %eax,%eax
80103632:	0f 84 a0 00 00 00    	je     801036d8 <pipealloc+0xe8>
    goto bad;
  p->readopen = 1;
80103638:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010363f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103642:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103645:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010364c:	00 00 00 
  p->nwrite = 0;
8010364f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103656:	00 00 00 
  p->nread = 0;
80103659:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103660:	00 00 00 
  initlock(&p->lock, "pipe");
80103663:	68 91 75 10 80       	push   $0x80107591
80103668:	50                   	push   %eax
80103669:	e8 22 0f 00 00       	call   80104590 <initlock>
  (*f0)->type = FD_PIPE;
8010366e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103670:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103673:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103679:	8b 06                	mov    (%esi),%eax
8010367b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010367f:	8b 06                	mov    (%esi),%eax
80103681:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103685:	8b 06                	mov    (%esi),%eax
80103687:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010368a:	8b 07                	mov    (%edi),%eax
8010368c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103692:	8b 07                	mov    (%edi),%eax
80103694:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103698:	8b 07                	mov    (%edi),%eax
8010369a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010369e:	8b 07                	mov    (%edi),%eax
801036a0:	89 58 0c             	mov    %ebx,0xc(%eax)
  return 0;
801036a3:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
801036a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036a8:	5b                   	pop    %ebx
801036a9:	5e                   	pop    %esi
801036aa:	5f                   	pop    %edi
801036ab:	5d                   	pop    %ebp
801036ac:	c3                   	ret
  if(*f0)
801036ad:	8b 06                	mov    (%esi),%eax
801036af:	85 c0                	test   %eax,%eax
801036b1:	74 1e                	je     801036d1 <pipealloc+0xe1>
    fileclose(*f0);
801036b3:	83 ec 0c             	sub    $0xc,%esp
801036b6:	50                   	push   %eax
801036b7:	e8 24 da ff ff       	call   801010e0 <fileclose>
801036bc:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801036bf:	8b 07                	mov    (%edi),%eax
801036c1:	85 c0                	test   %eax,%eax
801036c3:	74 0c                	je     801036d1 <pipealloc+0xe1>
    fileclose(*f1);
801036c5:	83 ec 0c             	sub    $0xc,%esp
801036c8:	50                   	push   %eax
801036c9:	e8 12 da ff ff       	call   801010e0 <fileclose>
801036ce:	83 c4 10             	add    $0x10,%esp
  return -1;
801036d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801036d6:	eb cd                	jmp    801036a5 <pipealloc+0xb5>
  if(*f0)
801036d8:	8b 06                	mov    (%esi),%eax
801036da:	85 c0                	test   %eax,%eax
801036dc:	75 d5                	jne    801036b3 <pipealloc+0xc3>
801036de:	eb df                	jmp    801036bf <pipealloc+0xcf>

801036e0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801036e0:	55                   	push   %ebp
801036e1:	89 e5                	mov    %esp,%ebp
801036e3:	56                   	push   %esi
801036e4:	53                   	push   %ebx
801036e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801036e8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801036eb:	83 ec 0c             	sub    $0xc,%esp
801036ee:	53                   	push   %ebx
801036ef:	e8 8c 10 00 00       	call   80104780 <acquire>
  if(writable){
801036f4:	83 c4 10             	add    $0x10,%esp
801036f7:	85 f6                	test   %esi,%esi
801036f9:	74 65                	je     80103760 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
801036fb:	83 ec 0c             	sub    $0xc,%esp
801036fe:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
80103704:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010370b:	00 00 00 
    wakeup(&p->nread);
8010370e:	50                   	push   %eax
8010370f:	e8 ac 0b 00 00       	call   801042c0 <wakeup>
80103714:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103717:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010371d:	85 d2                	test   %edx,%edx
8010371f:	75 0a                	jne    8010372b <pipeclose+0x4b>
80103721:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103727:	85 c0                	test   %eax,%eax
80103729:	74 15                	je     80103740 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010372b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010372e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103731:	5b                   	pop    %ebx
80103732:	5e                   	pop    %esi
80103733:	5d                   	pop    %ebp
    release(&p->lock);
80103734:	e9 e7 0f 00 00       	jmp    80104720 <release>
80103739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103740:	83 ec 0c             	sub    $0xc,%esp
80103743:	53                   	push   %ebx
80103744:	e8 d7 0f 00 00       	call   80104720 <release>
    kfree((char*)p);
80103749:	83 c4 10             	add    $0x10,%esp
8010374c:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010374f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103752:	5b                   	pop    %ebx
80103753:	5e                   	pop    %esi
80103754:	5d                   	pop    %ebp
    kfree((char*)p);
80103755:	e9 26 ef ff ff       	jmp    80102680 <kfree>
8010375a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103760:	83 ec 0c             	sub    $0xc,%esp
80103763:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103769:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103770:	00 00 00 
    wakeup(&p->nwrite);
80103773:	50                   	push   %eax
80103774:	e8 47 0b 00 00       	call   801042c0 <wakeup>
80103779:	83 c4 10             	add    $0x10,%esp
8010377c:	eb 99                	jmp    80103717 <pipeclose+0x37>
8010377e:	66 90                	xchg   %ax,%ax

80103780 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103780:	55                   	push   %ebp
80103781:	89 e5                	mov    %esp,%ebp
80103783:	57                   	push   %edi
80103784:	56                   	push   %esi
80103785:	53                   	push   %ebx
80103786:	83 ec 28             	sub    $0x28,%esp
80103789:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010378c:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
8010378f:	53                   	push   %ebx
80103790:	e8 eb 0f 00 00       	call   80104780 <acquire>
  for(i = 0; i < n; i++){
80103795:	83 c4 10             	add    $0x10,%esp
80103798:	85 ff                	test   %edi,%edi
8010379a:	0f 8e ce 00 00 00    	jle    8010386e <pipewrite+0xee>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801037a0:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
801037a6:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801037a9:	89 7d 10             	mov    %edi,0x10(%ebp)
801037ac:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801037af:	8d 34 39             	lea    (%ecx,%edi,1),%esi
801037b2:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801037b5:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801037bb:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801037c1:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801037c7:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
801037cd:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
801037d0:	0f 85 b6 00 00 00    	jne    8010388c <pipewrite+0x10c>
801037d6:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801037d9:	eb 3b                	jmp    80103816 <pipewrite+0x96>
801037db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
801037e0:	e8 5b 03 00 00       	call   80103b40 <myproc>
801037e5:	8b 48 24             	mov    0x24(%eax),%ecx
801037e8:	85 c9                	test   %ecx,%ecx
801037ea:	75 34                	jne    80103820 <pipewrite+0xa0>
      wakeup(&p->nread);
801037ec:	83 ec 0c             	sub    $0xc,%esp
801037ef:	56                   	push   %esi
801037f0:	e8 cb 0a 00 00       	call   801042c0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801037f5:	58                   	pop    %eax
801037f6:	5a                   	pop    %edx
801037f7:	53                   	push   %ebx
801037f8:	57                   	push   %edi
801037f9:	e8 02 0a 00 00       	call   80104200 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801037fe:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103804:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010380a:	83 c4 10             	add    $0x10,%esp
8010380d:	05 00 02 00 00       	add    $0x200,%eax
80103812:	39 c2                	cmp    %eax,%edx
80103814:	75 2a                	jne    80103840 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
80103816:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010381c:	85 c0                	test   %eax,%eax
8010381e:	75 c0                	jne    801037e0 <pipewrite+0x60>
        release(&p->lock);
80103820:	83 ec 0c             	sub    $0xc,%esp
80103823:	53                   	push   %ebx
80103824:	e8 f7 0e 00 00       	call   80104720 <release>
        return -1;
80103829:	83 c4 10             	add    $0x10,%esp
8010382c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103831:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103834:	5b                   	pop    %ebx
80103835:	5e                   	pop    %esi
80103836:	5f                   	pop    %edi
80103837:	5d                   	pop    %ebp
80103838:	c3                   	ret
80103839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103840:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103843:	8d 42 01             	lea    0x1(%edx),%eax
80103846:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  for(i = 0; i < n; i++){
8010384c:	83 c1 01             	add    $0x1,%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010384f:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103855:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103858:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
8010385c:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103860:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103863:	39 c1                	cmp    %eax,%ecx
80103865:	0f 85 50 ff ff ff    	jne    801037bb <pipewrite+0x3b>
8010386b:	8b 7d 10             	mov    0x10(%ebp),%edi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
8010386e:	83 ec 0c             	sub    $0xc,%esp
80103871:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103877:	50                   	push   %eax
80103878:	e8 43 0a 00 00       	call   801042c0 <wakeup>
  release(&p->lock);
8010387d:	89 1c 24             	mov    %ebx,(%esp)
80103880:	e8 9b 0e 00 00       	call   80104720 <release>
  return n;
80103885:	83 c4 10             	add    $0x10,%esp
80103888:	89 f8                	mov    %edi,%eax
8010388a:	eb a5                	jmp    80103831 <pipewrite+0xb1>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010388c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010388f:	eb b2                	jmp    80103843 <pipewrite+0xc3>
80103891:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103898:	00 
80103899:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801038a0 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801038a0:	55                   	push   %ebp
801038a1:	89 e5                	mov    %esp,%ebp
801038a3:	57                   	push   %edi
801038a4:	56                   	push   %esi
801038a5:	53                   	push   %ebx
801038a6:	83 ec 18             	sub    $0x18,%esp
801038a9:	8b 75 08             	mov    0x8(%ebp),%esi
801038ac:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
801038af:	56                   	push   %esi
801038b0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801038b6:	e8 c5 0e 00 00       	call   80104780 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801038bb:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801038c1:	83 c4 10             	add    $0x10,%esp
801038c4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801038ca:	74 2f                	je     801038fb <piperead+0x5b>
801038cc:	eb 37                	jmp    80103905 <piperead+0x65>
801038ce:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
801038d0:	e8 6b 02 00 00       	call   80103b40 <myproc>
801038d5:	8b 40 24             	mov    0x24(%eax),%eax
801038d8:	85 c0                	test   %eax,%eax
801038da:	0f 85 80 00 00 00    	jne    80103960 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801038e0:	83 ec 08             	sub    $0x8,%esp
801038e3:	56                   	push   %esi
801038e4:	53                   	push   %ebx
801038e5:	e8 16 09 00 00       	call   80104200 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801038ea:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801038f0:	83 c4 10             	add    $0x10,%esp
801038f3:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801038f9:	75 0a                	jne    80103905 <piperead+0x65>
801038fb:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103901:	85 d2                	test   %edx,%edx
80103903:	75 cb                	jne    801038d0 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103905:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103908:	31 db                	xor    %ebx,%ebx
8010390a:	85 c9                	test   %ecx,%ecx
8010390c:	7f 26                	jg     80103934 <piperead+0x94>
8010390e:	eb 2c                	jmp    8010393c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103910:	8d 48 01             	lea    0x1(%eax),%ecx
80103913:	25 ff 01 00 00       	and    $0x1ff,%eax
80103918:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010391e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103923:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103926:	83 c3 01             	add    $0x1,%ebx
80103929:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010392c:	74 0e                	je     8010393c <piperead+0x9c>
8010392e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
    if(p->nread == p->nwrite)
80103934:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010393a:	75 d4                	jne    80103910 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010393c:	83 ec 0c             	sub    $0xc,%esp
8010393f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103945:	50                   	push   %eax
80103946:	e8 75 09 00 00       	call   801042c0 <wakeup>
  release(&p->lock);
8010394b:	89 34 24             	mov    %esi,(%esp)
8010394e:	e8 cd 0d 00 00       	call   80104720 <release>
  return i;
80103953:	83 c4 10             	add    $0x10,%esp
}
80103956:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103959:	89 d8                	mov    %ebx,%eax
8010395b:	5b                   	pop    %ebx
8010395c:	5e                   	pop    %esi
8010395d:	5f                   	pop    %edi
8010395e:	5d                   	pop    %ebp
8010395f:	c3                   	ret
      release(&p->lock);
80103960:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103963:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103968:	56                   	push   %esi
80103969:	e8 b2 0d 00 00       	call   80104720 <release>
      return -1;
8010396e:	83 c4 10             	add    $0x10,%esp
}
80103971:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103974:	89 d8                	mov    %ebx,%eax
80103976:	5b                   	pop    %ebx
80103977:	5e                   	pop    %esi
80103978:	5f                   	pop    %edi
80103979:	5d                   	pop    %ebp
8010397a:	c3                   	ret
8010397b:	66 90                	xchg   %ax,%ax
8010397d:	66 90                	xchg   %ax,%ax
8010397f:	90                   	nop

80103980 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103980:	55                   	push   %ebp
80103981:	89 e5                	mov    %esp,%ebp
80103983:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103984:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
{
80103989:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010398c:	68 20 1d 11 80       	push   $0x80111d20
80103991:	e8 ea 0d 00 00       	call   80104780 <acquire>
80103996:	83 c4 10             	add    $0x10,%esp
80103999:	eb 10                	jmp    801039ab <allocproc+0x2b>
8010399b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801039a0:	83 c3 7c             	add    $0x7c,%ebx
801039a3:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
801039a9:	74 75                	je     80103a20 <allocproc+0xa0>
    if(p->state == UNUSED)
801039ab:	8b 43 0c             	mov    0xc(%ebx),%eax
801039ae:	85 c0                	test   %eax,%eax
801039b0:	75 ee                	jne    801039a0 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801039b2:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
801039b7:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801039ba:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
801039c1:	89 43 10             	mov    %eax,0x10(%ebx)
801039c4:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
801039c7:	68 20 1d 11 80       	push   $0x80111d20
  p->pid = nextpid++;
801039cc:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
801039d2:	e8 49 0d 00 00       	call   80104720 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801039d7:	e8 64 ee ff ff       	call   80102840 <kalloc>
801039dc:	83 c4 10             	add    $0x10,%esp
801039df:	89 43 08             	mov    %eax,0x8(%ebx)
801039e2:	85 c0                	test   %eax,%eax
801039e4:	74 53                	je     80103a39 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801039e6:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801039ec:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
801039ef:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
801039f4:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
801039f7:	c7 40 14 32 5a 10 80 	movl   $0x80105a32,0x14(%eax)
  p->context = (struct context*)sp;
801039fe:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103a01:	6a 14                	push   $0x14
80103a03:	6a 00                	push   $0x0
80103a05:	50                   	push   %eax
80103a06:	e8 75 0e 00 00       	call   80104880 <memset>
  p->context->eip = (uint)forkret;
80103a0b:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103a0e:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103a11:	c7 40 10 50 3a 10 80 	movl   $0x80103a50,0x10(%eax)
}
80103a18:	89 d8                	mov    %ebx,%eax
80103a1a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a1d:	c9                   	leave
80103a1e:	c3                   	ret
80103a1f:	90                   	nop
  release(&ptable.lock);
80103a20:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103a23:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103a25:	68 20 1d 11 80       	push   $0x80111d20
80103a2a:	e8 f1 0c 00 00       	call   80104720 <release>
  return 0;
80103a2f:	83 c4 10             	add    $0x10,%esp
}
80103a32:	89 d8                	mov    %ebx,%eax
80103a34:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a37:	c9                   	leave
80103a38:	c3                   	ret
    p->state = UNUSED;
80103a39:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
80103a40:	31 db                	xor    %ebx,%ebx
80103a42:	eb ee                	jmp    80103a32 <allocproc+0xb2>
80103a44:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103a4b:	00 
80103a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103a50 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103a50:	55                   	push   %ebp
80103a51:	89 e5                	mov    %esp,%ebp
80103a53:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103a56:	68 20 1d 11 80       	push   $0x80111d20
80103a5b:	e8 c0 0c 00 00       	call   80104720 <release>

  if (first) {
80103a60:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103a65:	83 c4 10             	add    $0x10,%esp
80103a68:	85 c0                	test   %eax,%eax
80103a6a:	75 04                	jne    80103a70 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103a6c:	c9                   	leave
80103a6d:	c3                   	ret
80103a6e:	66 90                	xchg   %ax,%ax
    first = 0;
80103a70:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
80103a77:	00 00 00 
    iinit(ROOTDEV);
80103a7a:	83 ec 0c             	sub    $0xc,%esp
80103a7d:	6a 01                	push   $0x1
80103a7f:	e8 cc dc ff ff       	call   80101750 <iinit>
    initlog(ROOTDEV);
80103a84:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103a8b:	e8 f0 f3 ff ff       	call   80102e80 <initlog>
}
80103a90:	83 c4 10             	add    $0x10,%esp
80103a93:	c9                   	leave
80103a94:	c3                   	ret
80103a95:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103a9c:	00 
80103a9d:	8d 76 00             	lea    0x0(%esi),%esi

80103aa0 <pinit>:
{
80103aa0:	55                   	push   %ebp
80103aa1:	89 e5                	mov    %esp,%ebp
80103aa3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103aa6:	68 96 75 10 80       	push   $0x80107596
80103aab:	68 20 1d 11 80       	push   $0x80111d20
80103ab0:	e8 db 0a 00 00       	call   80104590 <initlock>
}
80103ab5:	83 c4 10             	add    $0x10,%esp
80103ab8:	c9                   	leave
80103ab9:	c3                   	ret
80103aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103ac0 <mycpu>:
{
80103ac0:	55                   	push   %ebp
80103ac1:	89 e5                	mov    %esp,%ebp
80103ac3:	56                   	push   %esi
80103ac4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103ac5:	9c                   	pushf
80103ac6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103ac7:	f6 c4 02             	test   $0x2,%ah
80103aca:	75 46                	jne    80103b12 <mycpu+0x52>
  apicid = lapicid();
80103acc:	e8 df ef ff ff       	call   80102ab0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103ad1:	8b 35 84 17 11 80    	mov    0x80111784,%esi
80103ad7:	85 f6                	test   %esi,%esi
80103ad9:	7e 2a                	jle    80103b05 <mycpu+0x45>
80103adb:	31 d2                	xor    %edx,%edx
80103add:	eb 08                	jmp    80103ae7 <mycpu+0x27>
80103adf:	90                   	nop
80103ae0:	83 c2 01             	add    $0x1,%edx
80103ae3:	39 f2                	cmp    %esi,%edx
80103ae5:	74 1e                	je     80103b05 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80103ae7:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103aed:	0f b6 99 a0 17 11 80 	movzbl -0x7feee860(%ecx),%ebx
80103af4:	39 c3                	cmp    %eax,%ebx
80103af6:	75 e8                	jne    80103ae0 <mycpu+0x20>
}
80103af8:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103afb:	8d 81 a0 17 11 80    	lea    -0x7feee860(%ecx),%eax
}
80103b01:	5b                   	pop    %ebx
80103b02:	5e                   	pop    %esi
80103b03:	5d                   	pop    %ebp
80103b04:	c3                   	ret
  panic("unknown apicid\n");
80103b05:	83 ec 0c             	sub    $0xc,%esp
80103b08:	68 9d 75 10 80       	push   $0x8010759d
80103b0d:	e8 6e c8 ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
80103b12:	83 ec 0c             	sub    $0xc,%esp
80103b15:	68 30 79 10 80       	push   $0x80107930
80103b1a:	e8 61 c8 ff ff       	call   80100380 <panic>
80103b1f:	90                   	nop

80103b20 <cpuid>:
cpuid() {
80103b20:	55                   	push   %ebp
80103b21:	89 e5                	mov    %esp,%ebp
80103b23:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103b26:	e8 95 ff ff ff       	call   80103ac0 <mycpu>
}
80103b2b:	c9                   	leave
  return mycpu()-cpus;
80103b2c:	2d a0 17 11 80       	sub    $0x801117a0,%eax
80103b31:	c1 f8 04             	sar    $0x4,%eax
80103b34:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103b3a:	c3                   	ret
80103b3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103b40 <myproc>:
myproc(void) {
80103b40:	55                   	push   %ebp
80103b41:	89 e5                	mov    %esp,%ebp
80103b43:	53                   	push   %ebx
80103b44:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103b47:	e8 e4 0a 00 00       	call   80104630 <pushcli>
  c = mycpu();
80103b4c:	e8 6f ff ff ff       	call   80103ac0 <mycpu>
  p = c->proc;
80103b51:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b57:	e8 24 0b 00 00       	call   80104680 <popcli>
}
80103b5c:	89 d8                	mov    %ebx,%eax
80103b5e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b61:	c9                   	leave
80103b62:	c3                   	ret
80103b63:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103b6a:	00 
80103b6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103b70 <userinit>:
{
80103b70:	55                   	push   %ebp
80103b71:	89 e5                	mov    %esp,%ebp
80103b73:	53                   	push   %ebx
80103b74:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103b77:	e8 04 fe ff ff       	call   80103980 <allocproc>
80103b7c:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103b7e:	a3 54 3c 11 80       	mov    %eax,0x80113c54
  if((p->pgdir = setupkvm()) == 0)
80103b83:	e8 78 34 00 00       	call   80107000 <setupkvm>
80103b88:	89 43 04             	mov    %eax,0x4(%ebx)
80103b8b:	85 c0                	test   %eax,%eax
80103b8d:	0f 84 bd 00 00 00    	je     80103c50 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103b93:	83 ec 04             	sub    $0x4,%esp
80103b96:	68 2c 00 00 00       	push   $0x2c
80103b9b:	68 60 a4 10 80       	push   $0x8010a460
80103ba0:	50                   	push   %eax
80103ba1:	e8 3a 31 00 00       	call   80106ce0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103ba6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103ba9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103baf:	6a 4c                	push   $0x4c
80103bb1:	6a 00                	push   $0x0
80103bb3:	ff 73 18             	push   0x18(%ebx)
80103bb6:	e8 c5 0c 00 00       	call   80104880 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103bbb:	8b 43 18             	mov    0x18(%ebx),%eax
80103bbe:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103bc3:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103bc6:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103bcb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103bcf:	8b 43 18             	mov    0x18(%ebx),%eax
80103bd2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103bd6:	8b 43 18             	mov    0x18(%ebx),%eax
80103bd9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103bdd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103be1:	8b 43 18             	mov    0x18(%ebx),%eax
80103be4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103be8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103bec:	8b 43 18             	mov    0x18(%ebx),%eax
80103bef:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103bf6:	8b 43 18             	mov    0x18(%ebx),%eax
80103bf9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103c00:	8b 43 18             	mov    0x18(%ebx),%eax
80103c03:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103c0a:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103c0d:	6a 10                	push   $0x10
80103c0f:	68 c6 75 10 80       	push   $0x801075c6
80103c14:	50                   	push   %eax
80103c15:	e8 16 0e 00 00       	call   80104a30 <safestrcpy>
  p->cwd = namei("/");
80103c1a:	c7 04 24 cf 75 10 80 	movl   $0x801075cf,(%esp)
80103c21:	e8 3a e6 ff ff       	call   80102260 <namei>
80103c26:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103c29:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103c30:	e8 4b 0b 00 00       	call   80104780 <acquire>
  p->state = RUNNABLE;
80103c35:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103c3c:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103c43:	e8 d8 0a 00 00       	call   80104720 <release>
}
80103c48:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c4b:	83 c4 10             	add    $0x10,%esp
80103c4e:	c9                   	leave
80103c4f:	c3                   	ret
    panic("userinit: out of memory?");
80103c50:	83 ec 0c             	sub    $0xc,%esp
80103c53:	68 ad 75 10 80       	push   $0x801075ad
80103c58:	e8 23 c7 ff ff       	call   80100380 <panic>
80103c5d:	8d 76 00             	lea    0x0(%esi),%esi

80103c60 <growproc>:
{
80103c60:	55                   	push   %ebp
80103c61:	89 e5                	mov    %esp,%ebp
80103c63:	56                   	push   %esi
80103c64:	53                   	push   %ebx
80103c65:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103c68:	e8 c3 09 00 00       	call   80104630 <pushcli>
  c = mycpu();
80103c6d:	e8 4e fe ff ff       	call   80103ac0 <mycpu>
  p = c->proc;
80103c72:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103c78:	e8 03 0a 00 00       	call   80104680 <popcli>
  sz = curproc->sz;
80103c7d:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103c7f:	85 f6                	test   %esi,%esi
80103c81:	7f 1d                	jg     80103ca0 <growproc+0x40>
  } else if(n < 0){
80103c83:	75 3b                	jne    80103cc0 <growproc+0x60>
  switchuvm(curproc);
80103c85:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103c88:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103c8a:	53                   	push   %ebx
80103c8b:	e8 40 2f 00 00       	call   80106bd0 <switchuvm>
  return 0;
80103c90:	83 c4 10             	add    $0x10,%esp
80103c93:	31 c0                	xor    %eax,%eax
}
80103c95:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103c98:	5b                   	pop    %ebx
80103c99:	5e                   	pop    %esi
80103c9a:	5d                   	pop    %ebp
80103c9b:	c3                   	ret
80103c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103ca0:	83 ec 04             	sub    $0x4,%esp
80103ca3:	01 c6                	add    %eax,%esi
80103ca5:	56                   	push   %esi
80103ca6:	50                   	push   %eax
80103ca7:	ff 73 04             	push   0x4(%ebx)
80103caa:	e8 81 31 00 00       	call   80106e30 <allocuvm>
80103caf:	83 c4 10             	add    $0x10,%esp
80103cb2:	85 c0                	test   %eax,%eax
80103cb4:	75 cf                	jne    80103c85 <growproc+0x25>
      return -1;
80103cb6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103cbb:	eb d8                	jmp    80103c95 <growproc+0x35>
80103cbd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103cc0:	83 ec 04             	sub    $0x4,%esp
80103cc3:	01 c6                	add    %eax,%esi
80103cc5:	56                   	push   %esi
80103cc6:	50                   	push   %eax
80103cc7:	ff 73 04             	push   0x4(%ebx)
80103cca:	e8 81 32 00 00       	call   80106f50 <deallocuvm>
80103ccf:	83 c4 10             	add    $0x10,%esp
80103cd2:	85 c0                	test   %eax,%eax
80103cd4:	75 af                	jne    80103c85 <growproc+0x25>
80103cd6:	eb de                	jmp    80103cb6 <growproc+0x56>
80103cd8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103cdf:	00 

80103ce0 <fork>:
{
80103ce0:	55                   	push   %ebp
80103ce1:	89 e5                	mov    %esp,%ebp
80103ce3:	57                   	push   %edi
80103ce4:	56                   	push   %esi
80103ce5:	53                   	push   %ebx
80103ce6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103ce9:	e8 42 09 00 00       	call   80104630 <pushcli>
  c = mycpu();
80103cee:	e8 cd fd ff ff       	call   80103ac0 <mycpu>
  p = c->proc;
80103cf3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103cf9:	e8 82 09 00 00       	call   80104680 <popcli>
  if((np = allocproc()) == 0){
80103cfe:	e8 7d fc ff ff       	call   80103980 <allocproc>
80103d03:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103d06:	85 c0                	test   %eax,%eax
80103d08:	0f 84 d6 00 00 00    	je     80103de4 <fork+0x104>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103d0e:	83 ec 08             	sub    $0x8,%esp
80103d11:	ff 33                	push   (%ebx)
80103d13:	89 c7                	mov    %eax,%edi
80103d15:	ff 73 04             	push   0x4(%ebx)
80103d18:	e8 d3 33 00 00       	call   801070f0 <copyuvm>
80103d1d:	83 c4 10             	add    $0x10,%esp
80103d20:	89 47 04             	mov    %eax,0x4(%edi)
80103d23:	85 c0                	test   %eax,%eax
80103d25:	0f 84 9a 00 00 00    	je     80103dc5 <fork+0xe5>
  np->sz = curproc->sz;
80103d2b:	8b 03                	mov    (%ebx),%eax
80103d2d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103d30:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103d32:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80103d35:	89 c8                	mov    %ecx,%eax
80103d37:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103d3a:	b9 13 00 00 00       	mov    $0x13,%ecx
80103d3f:	8b 73 18             	mov    0x18(%ebx),%esi
80103d42:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103d44:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103d46:	8b 40 18             	mov    0x18(%eax),%eax
80103d49:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103d50:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103d54:	85 c0                	test   %eax,%eax
80103d56:	74 13                	je     80103d6b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103d58:	83 ec 0c             	sub    $0xc,%esp
80103d5b:	50                   	push   %eax
80103d5c:	e8 2f d3 ff ff       	call   80101090 <filedup>
80103d61:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103d64:	83 c4 10             	add    $0x10,%esp
80103d67:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103d6b:	83 c6 01             	add    $0x1,%esi
80103d6e:	83 fe 10             	cmp    $0x10,%esi
80103d71:	75 dd                	jne    80103d50 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103d73:	83 ec 0c             	sub    $0xc,%esp
80103d76:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d79:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103d7c:	e8 cf db ff ff       	call   80101950 <idup>
80103d81:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d84:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103d87:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103d8a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103d8d:	6a 10                	push   $0x10
80103d8f:	53                   	push   %ebx
80103d90:	50                   	push   %eax
80103d91:	e8 9a 0c 00 00       	call   80104a30 <safestrcpy>
  pid = np->pid;
80103d96:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103d99:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103da0:	e8 db 09 00 00       	call   80104780 <acquire>
  np->state = RUNNABLE;
80103da5:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103dac:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103db3:	e8 68 09 00 00       	call   80104720 <release>
  return pid;
80103db8:	83 c4 10             	add    $0x10,%esp
}
80103dbb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103dbe:	89 d8                	mov    %ebx,%eax
80103dc0:	5b                   	pop    %ebx
80103dc1:	5e                   	pop    %esi
80103dc2:	5f                   	pop    %edi
80103dc3:	5d                   	pop    %ebp
80103dc4:	c3                   	ret
    kfree(np->kstack);
80103dc5:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103dc8:	83 ec 0c             	sub    $0xc,%esp
80103dcb:	ff 73 08             	push   0x8(%ebx)
80103dce:	e8 ad e8 ff ff       	call   80102680 <kfree>
    np->kstack = 0;
80103dd3:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103dda:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103ddd:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103de4:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103de9:	eb d0                	jmp    80103dbb <fork+0xdb>
80103deb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103df0 <scheduler>:
{
80103df0:	55                   	push   %ebp
80103df1:	89 e5                	mov    %esp,%ebp
80103df3:	57                   	push   %edi
80103df4:	56                   	push   %esi
80103df5:	53                   	push   %ebx
80103df6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103df9:	e8 c2 fc ff ff       	call   80103ac0 <mycpu>
  c->proc = 0;
80103dfe:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103e05:	00 00 00 
  struct cpu *c = mycpu();
80103e08:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103e0a:	8d 78 04             	lea    0x4(%eax),%edi
80103e0d:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103e10:	fb                   	sti
    acquire(&ptable.lock);
80103e11:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e14:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
    acquire(&ptable.lock);
80103e19:	68 20 1d 11 80       	push   $0x80111d20
80103e1e:	e8 5d 09 00 00       	call   80104780 <acquire>
80103e23:	83 c4 10             	add    $0x10,%esp
80103e26:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103e2d:	00 
80103e2e:	66 90                	xchg   %ax,%ax
      if(p->state != RUNNABLE)
80103e30:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103e34:	75 33                	jne    80103e69 <scheduler+0x79>
      switchuvm(p);
80103e36:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103e39:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103e3f:	53                   	push   %ebx
80103e40:	e8 8b 2d 00 00       	call   80106bd0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103e45:	58                   	pop    %eax
80103e46:	5a                   	pop    %edx
80103e47:	ff 73 1c             	push   0x1c(%ebx)
80103e4a:	57                   	push   %edi
      p->state = RUNNING;
80103e4b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103e52:	e8 34 0c 00 00       	call   80104a8b <swtch>
      switchkvm();
80103e57:	e8 64 2d 00 00       	call   80106bc0 <switchkvm>
      c->proc = 0;
80103e5c:	83 c4 10             	add    $0x10,%esp
80103e5f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103e66:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103e69:	83 c3 7c             	add    $0x7c,%ebx
80103e6c:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80103e72:	75 bc                	jne    80103e30 <scheduler+0x40>
    release(&ptable.lock);
80103e74:	83 ec 0c             	sub    $0xc,%esp
80103e77:	68 20 1d 11 80       	push   $0x80111d20
80103e7c:	e8 9f 08 00 00       	call   80104720 <release>
    sti();
80103e81:	83 c4 10             	add    $0x10,%esp
80103e84:	eb 8a                	jmp    80103e10 <scheduler+0x20>
80103e86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103e8d:	00 
80103e8e:	66 90                	xchg   %ax,%ax

80103e90 <sched>:
{
80103e90:	55                   	push   %ebp
80103e91:	89 e5                	mov    %esp,%ebp
80103e93:	56                   	push   %esi
80103e94:	53                   	push   %ebx
  pushcli();
80103e95:	e8 96 07 00 00       	call   80104630 <pushcli>
  c = mycpu();
80103e9a:	e8 21 fc ff ff       	call   80103ac0 <mycpu>
  p = c->proc;
80103e9f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ea5:	e8 d6 07 00 00       	call   80104680 <popcli>
  if(!holding(&ptable.lock))
80103eaa:	83 ec 0c             	sub    $0xc,%esp
80103ead:	68 20 1d 11 80       	push   $0x80111d20
80103eb2:	e8 29 08 00 00       	call   801046e0 <holding>
80103eb7:	83 c4 10             	add    $0x10,%esp
80103eba:	85 c0                	test   %eax,%eax
80103ebc:	74 4f                	je     80103f0d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103ebe:	e8 fd fb ff ff       	call   80103ac0 <mycpu>
80103ec3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103eca:	75 68                	jne    80103f34 <sched+0xa4>
  if(p->state == RUNNING)
80103ecc:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103ed0:	74 55                	je     80103f27 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103ed2:	9c                   	pushf
80103ed3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103ed4:	f6 c4 02             	test   $0x2,%ah
80103ed7:	75 41                	jne    80103f1a <sched+0x8a>
  intena = mycpu()->intena;
80103ed9:	e8 e2 fb ff ff       	call   80103ac0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103ede:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103ee1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103ee7:	e8 d4 fb ff ff       	call   80103ac0 <mycpu>
80103eec:	83 ec 08             	sub    $0x8,%esp
80103eef:	ff 70 04             	push   0x4(%eax)
80103ef2:	53                   	push   %ebx
80103ef3:	e8 93 0b 00 00       	call   80104a8b <swtch>
  mycpu()->intena = intena;
80103ef8:	e8 c3 fb ff ff       	call   80103ac0 <mycpu>
}
80103efd:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103f00:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103f06:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103f09:	5b                   	pop    %ebx
80103f0a:	5e                   	pop    %esi
80103f0b:	5d                   	pop    %ebp
80103f0c:	c3                   	ret
    panic("sched ptable.lock");
80103f0d:	83 ec 0c             	sub    $0xc,%esp
80103f10:	68 d1 75 10 80       	push   $0x801075d1
80103f15:	e8 66 c4 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
80103f1a:	83 ec 0c             	sub    $0xc,%esp
80103f1d:	68 fd 75 10 80       	push   $0x801075fd
80103f22:	e8 59 c4 ff ff       	call   80100380 <panic>
    panic("sched running");
80103f27:	83 ec 0c             	sub    $0xc,%esp
80103f2a:	68 ef 75 10 80       	push   $0x801075ef
80103f2f:	e8 4c c4 ff ff       	call   80100380 <panic>
    panic("sched locks");
80103f34:	83 ec 0c             	sub    $0xc,%esp
80103f37:	68 e3 75 10 80       	push   $0x801075e3
80103f3c:	e8 3f c4 ff ff       	call   80100380 <panic>
80103f41:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f48:	00 
80103f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103f50 <exit>:
{
80103f50:	55                   	push   %ebp
80103f51:	89 e5                	mov    %esp,%ebp
80103f53:	57                   	push   %edi
80103f54:	56                   	push   %esi
80103f55:	53                   	push   %ebx
80103f56:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80103f59:	e8 e2 fb ff ff       	call   80103b40 <myproc>
  if(curproc == initproc)
80103f5e:	39 05 54 3c 11 80    	cmp    %eax,0x80113c54
80103f64:	0f 84 fd 00 00 00    	je     80104067 <exit+0x117>
80103f6a:	89 c3                	mov    %eax,%ebx
80103f6c:	8d 70 28             	lea    0x28(%eax),%esi
80103f6f:	8d 78 68             	lea    0x68(%eax),%edi
80103f72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80103f78:	8b 06                	mov    (%esi),%eax
80103f7a:	85 c0                	test   %eax,%eax
80103f7c:	74 12                	je     80103f90 <exit+0x40>
      fileclose(curproc->ofile[fd]);
80103f7e:	83 ec 0c             	sub    $0xc,%esp
80103f81:	50                   	push   %eax
80103f82:	e8 59 d1 ff ff       	call   801010e0 <fileclose>
      curproc->ofile[fd] = 0;
80103f87:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103f8d:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80103f90:	83 c6 04             	add    $0x4,%esi
80103f93:	39 f7                	cmp    %esi,%edi
80103f95:	75 e1                	jne    80103f78 <exit+0x28>
  begin_op();
80103f97:	e8 84 ef ff ff       	call   80102f20 <begin_op>
  iput(curproc->cwd);
80103f9c:	83 ec 0c             	sub    $0xc,%esp
80103f9f:	ff 73 68             	push   0x68(%ebx)
80103fa2:	e8 09 db ff ff       	call   80101ab0 <iput>
  end_op();
80103fa7:	e8 e4 ef ff ff       	call   80102f90 <end_op>
  curproc->cwd = 0;
80103fac:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80103fb3:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103fba:	e8 c1 07 00 00       	call   80104780 <acquire>
  wakeup1(curproc->parent);
80103fbf:	8b 53 14             	mov    0x14(%ebx),%edx
80103fc2:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fc5:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
80103fca:	eb 0e                	jmp    80103fda <exit+0x8a>
80103fcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103fd0:	83 c0 7c             	add    $0x7c,%eax
80103fd3:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103fd8:	74 1c                	je     80103ff6 <exit+0xa6>
    if(p->state == SLEEPING && p->chan == chan)
80103fda:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103fde:	75 f0                	jne    80103fd0 <exit+0x80>
80103fe0:	3b 50 20             	cmp    0x20(%eax),%edx
80103fe3:	75 eb                	jne    80103fd0 <exit+0x80>
      p->state = RUNNABLE;
80103fe5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103fec:	83 c0 7c             	add    $0x7c,%eax
80103fef:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103ff4:	75 e4                	jne    80103fda <exit+0x8a>
      p->parent = initproc;
80103ff6:	8b 0d 54 3c 11 80    	mov    0x80113c54,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103ffc:	ba 54 1d 11 80       	mov    $0x80111d54,%edx
80104001:	eb 10                	jmp    80104013 <exit+0xc3>
80104003:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104008:	83 c2 7c             	add    $0x7c,%edx
8010400b:	81 fa 54 3c 11 80    	cmp    $0x80113c54,%edx
80104011:	74 3b                	je     8010404e <exit+0xfe>
    if(p->parent == curproc){
80104013:	39 5a 14             	cmp    %ebx,0x14(%edx)
80104016:	75 f0                	jne    80104008 <exit+0xb8>
      if(p->state == ZOMBIE)
80104018:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
8010401c:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
8010401f:	75 e7                	jne    80104008 <exit+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104021:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
80104026:	eb 12                	jmp    8010403a <exit+0xea>
80104028:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010402f:	00 
80104030:	83 c0 7c             	add    $0x7c,%eax
80104033:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80104038:	74 ce                	je     80104008 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
8010403a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010403e:	75 f0                	jne    80104030 <exit+0xe0>
80104040:	3b 48 20             	cmp    0x20(%eax),%ecx
80104043:	75 eb                	jne    80104030 <exit+0xe0>
      p->state = RUNNABLE;
80104045:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010404c:	eb e2                	jmp    80104030 <exit+0xe0>
  curproc->state = ZOMBIE;
8010404e:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80104055:	e8 36 fe ff ff       	call   80103e90 <sched>
  panic("zombie exit");
8010405a:	83 ec 0c             	sub    $0xc,%esp
8010405d:	68 1e 76 10 80       	push   $0x8010761e
80104062:	e8 19 c3 ff ff       	call   80100380 <panic>
    panic("init exiting");
80104067:	83 ec 0c             	sub    $0xc,%esp
8010406a:	68 11 76 10 80       	push   $0x80107611
8010406f:	e8 0c c3 ff ff       	call   80100380 <panic>
80104074:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010407b:	00 
8010407c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104080 <wait>:
{
80104080:	55                   	push   %ebp
80104081:	89 e5                	mov    %esp,%ebp
80104083:	56                   	push   %esi
80104084:	53                   	push   %ebx
  pushcli();
80104085:	e8 a6 05 00 00       	call   80104630 <pushcli>
  c = mycpu();
8010408a:	e8 31 fa ff ff       	call   80103ac0 <mycpu>
  p = c->proc;
8010408f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104095:	e8 e6 05 00 00       	call   80104680 <popcli>
  acquire(&ptable.lock);
8010409a:	83 ec 0c             	sub    $0xc,%esp
8010409d:	68 20 1d 11 80       	push   $0x80111d20
801040a2:	e8 d9 06 00 00       	call   80104780 <acquire>
801040a7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
801040aa:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040ac:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
801040b1:	eb 10                	jmp    801040c3 <wait+0x43>
801040b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801040b8:	83 c3 7c             	add    $0x7c,%ebx
801040bb:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
801040c1:	74 1b                	je     801040de <wait+0x5e>
      if(p->parent != curproc)
801040c3:	39 73 14             	cmp    %esi,0x14(%ebx)
801040c6:	75 f0                	jne    801040b8 <wait+0x38>
      if(p->state == ZOMBIE){
801040c8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801040cc:	74 62                	je     80104130 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040ce:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
801040d1:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040d6:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
801040dc:	75 e5                	jne    801040c3 <wait+0x43>
    if(!havekids || curproc->killed){
801040de:	85 c0                	test   %eax,%eax
801040e0:	0f 84 a0 00 00 00    	je     80104186 <wait+0x106>
801040e6:	8b 46 24             	mov    0x24(%esi),%eax
801040e9:	85 c0                	test   %eax,%eax
801040eb:	0f 85 95 00 00 00    	jne    80104186 <wait+0x106>
  pushcli();
801040f1:	e8 3a 05 00 00       	call   80104630 <pushcli>
  c = mycpu();
801040f6:	e8 c5 f9 ff ff       	call   80103ac0 <mycpu>
  p = c->proc;
801040fb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104101:	e8 7a 05 00 00       	call   80104680 <popcli>
  if(p == 0)
80104106:	85 db                	test   %ebx,%ebx
80104108:	0f 84 8f 00 00 00    	je     8010419d <wait+0x11d>
  p->chan = chan;
8010410e:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104111:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104118:	e8 73 fd ff ff       	call   80103e90 <sched>
  p->chan = 0;
8010411d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104124:	eb 84                	jmp    801040aa <wait+0x2a>
80104126:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010412d:	00 
8010412e:	66 90                	xchg   %ax,%ax
        kfree(p->kstack);
80104130:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104133:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104136:	ff 73 08             	push   0x8(%ebx)
80104139:	e8 42 e5 ff ff       	call   80102680 <kfree>
        p->kstack = 0;
8010413e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104145:	5a                   	pop    %edx
80104146:	ff 73 04             	push   0x4(%ebx)
80104149:	e8 32 2e 00 00       	call   80106f80 <freevm>
        p->pid = 0;
8010414e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104155:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010415c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104160:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104167:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010416e:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80104175:	e8 a6 05 00 00       	call   80104720 <release>
        return pid;
8010417a:	83 c4 10             	add    $0x10,%esp
}
8010417d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104180:	89 f0                	mov    %esi,%eax
80104182:	5b                   	pop    %ebx
80104183:	5e                   	pop    %esi
80104184:	5d                   	pop    %ebp
80104185:	c3                   	ret
      release(&ptable.lock);
80104186:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104189:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010418e:	68 20 1d 11 80       	push   $0x80111d20
80104193:	e8 88 05 00 00       	call   80104720 <release>
      return -1;
80104198:	83 c4 10             	add    $0x10,%esp
8010419b:	eb e0                	jmp    8010417d <wait+0xfd>
    panic("sleep");
8010419d:	83 ec 0c             	sub    $0xc,%esp
801041a0:	68 2a 76 10 80       	push   $0x8010762a
801041a5:	e8 d6 c1 ff ff       	call   80100380 <panic>
801041aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801041b0 <yield>:
{
801041b0:	55                   	push   %ebp
801041b1:	89 e5                	mov    %esp,%ebp
801041b3:	53                   	push   %ebx
801041b4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801041b7:	68 20 1d 11 80       	push   $0x80111d20
801041bc:	e8 bf 05 00 00       	call   80104780 <acquire>
  pushcli();
801041c1:	e8 6a 04 00 00       	call   80104630 <pushcli>
  c = mycpu();
801041c6:	e8 f5 f8 ff ff       	call   80103ac0 <mycpu>
  p = c->proc;
801041cb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801041d1:	e8 aa 04 00 00       	call   80104680 <popcli>
  myproc()->state = RUNNABLE;
801041d6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
801041dd:	e8 ae fc ff ff       	call   80103e90 <sched>
  release(&ptable.lock);
801041e2:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801041e9:	e8 32 05 00 00       	call   80104720 <release>
}
801041ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801041f1:	83 c4 10             	add    $0x10,%esp
801041f4:	c9                   	leave
801041f5:	c3                   	ret
801041f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801041fd:	00 
801041fe:	66 90                	xchg   %ax,%ax

80104200 <sleep>:
{
80104200:	55                   	push   %ebp
80104201:	89 e5                	mov    %esp,%ebp
80104203:	57                   	push   %edi
80104204:	56                   	push   %esi
80104205:	53                   	push   %ebx
80104206:	83 ec 0c             	sub    $0xc,%esp
80104209:	8b 7d 08             	mov    0x8(%ebp),%edi
8010420c:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
8010420f:	e8 1c 04 00 00       	call   80104630 <pushcli>
  c = mycpu();
80104214:	e8 a7 f8 ff ff       	call   80103ac0 <mycpu>
  p = c->proc;
80104219:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010421f:	e8 5c 04 00 00       	call   80104680 <popcli>
  if(p == 0)
80104224:	85 db                	test   %ebx,%ebx
80104226:	0f 84 87 00 00 00    	je     801042b3 <sleep+0xb3>
  if(lk == 0)
8010422c:	85 f6                	test   %esi,%esi
8010422e:	74 76                	je     801042a6 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104230:	81 fe 20 1d 11 80    	cmp    $0x80111d20,%esi
80104236:	74 50                	je     80104288 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104238:	83 ec 0c             	sub    $0xc,%esp
8010423b:	68 20 1d 11 80       	push   $0x80111d20
80104240:	e8 3b 05 00 00       	call   80104780 <acquire>
    release(lk);
80104245:	89 34 24             	mov    %esi,(%esp)
80104248:	e8 d3 04 00 00       	call   80104720 <release>
  p->chan = chan;
8010424d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104250:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104257:	e8 34 fc ff ff       	call   80103e90 <sched>
  p->chan = 0;
8010425c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104263:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
8010426a:	e8 b1 04 00 00       	call   80104720 <release>
    acquire(lk);
8010426f:	83 c4 10             	add    $0x10,%esp
80104272:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104275:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104278:	5b                   	pop    %ebx
80104279:	5e                   	pop    %esi
8010427a:	5f                   	pop    %edi
8010427b:	5d                   	pop    %ebp
    acquire(lk);
8010427c:	e9 ff 04 00 00       	jmp    80104780 <acquire>
80104281:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104288:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010428b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104292:	e8 f9 fb ff ff       	call   80103e90 <sched>
  p->chan = 0;
80104297:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010429e:	8d 65 f4             	lea    -0xc(%ebp),%esp
801042a1:	5b                   	pop    %ebx
801042a2:	5e                   	pop    %esi
801042a3:	5f                   	pop    %edi
801042a4:	5d                   	pop    %ebp
801042a5:	c3                   	ret
    panic("sleep without lk");
801042a6:	83 ec 0c             	sub    $0xc,%esp
801042a9:	68 30 76 10 80       	push   $0x80107630
801042ae:	e8 cd c0 ff ff       	call   80100380 <panic>
    panic("sleep");
801042b3:	83 ec 0c             	sub    $0xc,%esp
801042b6:	68 2a 76 10 80       	push   $0x8010762a
801042bb:	e8 c0 c0 ff ff       	call   80100380 <panic>

801042c0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801042c0:	55                   	push   %ebp
801042c1:	89 e5                	mov    %esp,%ebp
801042c3:	53                   	push   %ebx
801042c4:	83 ec 10             	sub    $0x10,%esp
801042c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801042ca:	68 20 1d 11 80       	push   $0x80111d20
801042cf:	e8 ac 04 00 00       	call   80104780 <acquire>
801042d4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801042d7:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
801042dc:	eb 0c                	jmp    801042ea <wakeup+0x2a>
801042de:	66 90                	xchg   %ax,%ax
801042e0:	83 c0 7c             	add    $0x7c,%eax
801042e3:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
801042e8:	74 1c                	je     80104306 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
801042ea:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801042ee:	75 f0                	jne    801042e0 <wakeup+0x20>
801042f0:	3b 58 20             	cmp    0x20(%eax),%ebx
801042f3:	75 eb                	jne    801042e0 <wakeup+0x20>
      p->state = RUNNABLE;
801042f5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801042fc:	83 c0 7c             	add    $0x7c,%eax
801042ff:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80104304:	75 e4                	jne    801042ea <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
80104306:	c7 45 08 20 1d 11 80 	movl   $0x80111d20,0x8(%ebp)
}
8010430d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104310:	c9                   	leave
  release(&ptable.lock);
80104311:	e9 0a 04 00 00       	jmp    80104720 <release>
80104316:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010431d:	00 
8010431e:	66 90                	xchg   %ax,%ax

80104320 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104320:	55                   	push   %ebp
80104321:	89 e5                	mov    %esp,%ebp
80104323:	53                   	push   %ebx
80104324:	83 ec 10             	sub    $0x10,%esp
80104327:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010432a:	68 20 1d 11 80       	push   $0x80111d20
8010432f:	e8 4c 04 00 00       	call   80104780 <acquire>
80104334:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104337:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
8010433c:	eb 0c                	jmp    8010434a <kill+0x2a>
8010433e:	66 90                	xchg   %ax,%ax
80104340:	83 c0 7c             	add    $0x7c,%eax
80104343:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80104348:	74 36                	je     80104380 <kill+0x60>
    if(p->pid == pid){
8010434a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010434d:	75 f1                	jne    80104340 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010434f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104353:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010435a:	75 07                	jne    80104363 <kill+0x43>
        p->state = RUNNABLE;
8010435c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104363:	83 ec 0c             	sub    $0xc,%esp
80104366:	68 20 1d 11 80       	push   $0x80111d20
8010436b:	e8 b0 03 00 00       	call   80104720 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104370:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104373:	83 c4 10             	add    $0x10,%esp
80104376:	31 c0                	xor    %eax,%eax
}
80104378:	c9                   	leave
80104379:	c3                   	ret
8010437a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104380:	83 ec 0c             	sub    $0xc,%esp
80104383:	68 20 1d 11 80       	push   $0x80111d20
80104388:	e8 93 03 00 00       	call   80104720 <release>
}
8010438d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104390:	83 c4 10             	add    $0x10,%esp
80104393:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104398:	c9                   	leave
80104399:	c3                   	ret
8010439a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801043a0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801043a0:	55                   	push   %ebp
801043a1:	89 e5                	mov    %esp,%ebp
801043a3:	57                   	push   %edi
801043a4:	56                   	push   %esi
801043a5:	8d 75 e8             	lea    -0x18(%ebp),%esi
801043a8:	53                   	push   %ebx
801043a9:	bb c0 1d 11 80       	mov    $0x80111dc0,%ebx
801043ae:	83 ec 3c             	sub    $0x3c,%esp
801043b1:	eb 24                	jmp    801043d7 <procdump+0x37>
801043b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801043b8:	83 ec 0c             	sub    $0xc,%esp
801043bb:	68 ef 77 10 80       	push   $0x801077ef
801043c0:	e8 ab c2 ff ff       	call   80100670 <cprintf>
801043c5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043c8:	83 c3 7c             	add    $0x7c,%ebx
801043cb:	81 fb c0 3c 11 80    	cmp    $0x80113cc0,%ebx
801043d1:	0f 84 81 00 00 00    	je     80104458 <procdump+0xb8>
    if(p->state == UNUSED)
801043d7:	8b 43 a0             	mov    -0x60(%ebx),%eax
801043da:	85 c0                	test   %eax,%eax
801043dc:	74 ea                	je     801043c8 <procdump+0x28>
      state = "???";
801043de:	ba 41 76 10 80       	mov    $0x80107641,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801043e3:	83 f8 05             	cmp    $0x5,%eax
801043e6:	77 11                	ja     801043f9 <procdump+0x59>
801043e8:	8b 14 85 40 7c 10 80 	mov    -0x7fef83c0(,%eax,4),%edx
      state = "???";
801043ef:	b8 41 76 10 80       	mov    $0x80107641,%eax
801043f4:	85 d2                	test   %edx,%edx
801043f6:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801043f9:	53                   	push   %ebx
801043fa:	52                   	push   %edx
801043fb:	ff 73 a4             	push   -0x5c(%ebx)
801043fe:	68 45 76 10 80       	push   $0x80107645
80104403:	e8 68 c2 ff ff       	call   80100670 <cprintf>
    if(p->state == SLEEPING){
80104408:	83 c4 10             	add    $0x10,%esp
8010440b:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
8010440f:	75 a7                	jne    801043b8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104411:	83 ec 08             	sub    $0x8,%esp
80104414:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104417:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010441a:	50                   	push   %eax
8010441b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010441e:	8b 40 0c             	mov    0xc(%eax),%eax
80104421:	83 c0 08             	add    $0x8,%eax
80104424:	50                   	push   %eax
80104425:	e8 86 01 00 00       	call   801045b0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010442a:	83 c4 10             	add    $0x10,%esp
8010442d:	8d 76 00             	lea    0x0(%esi),%esi
80104430:	8b 17                	mov    (%edi),%edx
80104432:	85 d2                	test   %edx,%edx
80104434:	74 82                	je     801043b8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104436:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104439:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010443c:	52                   	push   %edx
8010443d:	68 81 73 10 80       	push   $0x80107381
80104442:	e8 29 c2 ff ff       	call   80100670 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104447:	83 c4 10             	add    $0x10,%esp
8010444a:	39 f7                	cmp    %esi,%edi
8010444c:	75 e2                	jne    80104430 <procdump+0x90>
8010444e:	e9 65 ff ff ff       	jmp    801043b8 <procdump+0x18>
80104453:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  }
}
80104458:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010445b:	5b                   	pop    %ebx
8010445c:	5e                   	pop    %esi
8010445d:	5f                   	pop    %edi
8010445e:	5d                   	pop    %ebp
8010445f:	c3                   	ret

80104460 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104460:	55                   	push   %ebp
80104461:	89 e5                	mov    %esp,%ebp
80104463:	53                   	push   %ebx
80104464:	83 ec 0c             	sub    $0xc,%esp
80104467:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010446a:	68 78 76 10 80       	push   $0x80107678
8010446f:	8d 43 04             	lea    0x4(%ebx),%eax
80104472:	50                   	push   %eax
80104473:	e8 18 01 00 00       	call   80104590 <initlock>
  lk->name = name;
80104478:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010447b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104481:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104484:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010448b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010448e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104491:	c9                   	leave
80104492:	c3                   	ret
80104493:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010449a:	00 
8010449b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801044a0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	56                   	push   %esi
801044a4:	53                   	push   %ebx
801044a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801044a8:	8d 73 04             	lea    0x4(%ebx),%esi
801044ab:	83 ec 0c             	sub    $0xc,%esp
801044ae:	56                   	push   %esi
801044af:	e8 cc 02 00 00       	call   80104780 <acquire>
  while (lk->locked) {
801044b4:	8b 13                	mov    (%ebx),%edx
801044b6:	83 c4 10             	add    $0x10,%esp
801044b9:	85 d2                	test   %edx,%edx
801044bb:	74 16                	je     801044d3 <acquiresleep+0x33>
801044bd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801044c0:	83 ec 08             	sub    $0x8,%esp
801044c3:	56                   	push   %esi
801044c4:	53                   	push   %ebx
801044c5:	e8 36 fd ff ff       	call   80104200 <sleep>
  while (lk->locked) {
801044ca:	8b 03                	mov    (%ebx),%eax
801044cc:	83 c4 10             	add    $0x10,%esp
801044cf:	85 c0                	test   %eax,%eax
801044d1:	75 ed                	jne    801044c0 <acquiresleep+0x20>
  }
  lk->locked = 1;
801044d3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801044d9:	e8 62 f6 ff ff       	call   80103b40 <myproc>
801044de:	8b 40 10             	mov    0x10(%eax),%eax
801044e1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801044e4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801044e7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801044ea:	5b                   	pop    %ebx
801044eb:	5e                   	pop    %esi
801044ec:	5d                   	pop    %ebp
  release(&lk->lk);
801044ed:	e9 2e 02 00 00       	jmp    80104720 <release>
801044f2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801044f9:	00 
801044fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104500 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104500:	55                   	push   %ebp
80104501:	89 e5                	mov    %esp,%ebp
80104503:	56                   	push   %esi
80104504:	53                   	push   %ebx
80104505:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104508:	8d 73 04             	lea    0x4(%ebx),%esi
8010450b:	83 ec 0c             	sub    $0xc,%esp
8010450e:	56                   	push   %esi
8010450f:	e8 6c 02 00 00       	call   80104780 <acquire>
  lk->locked = 0;
80104514:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010451a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104521:	89 1c 24             	mov    %ebx,(%esp)
80104524:	e8 97 fd ff ff       	call   801042c0 <wakeup>
  release(&lk->lk);
80104529:	83 c4 10             	add    $0x10,%esp
8010452c:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010452f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104532:	5b                   	pop    %ebx
80104533:	5e                   	pop    %esi
80104534:	5d                   	pop    %ebp
  release(&lk->lk);
80104535:	e9 e6 01 00 00       	jmp    80104720 <release>
8010453a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104540 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	57                   	push   %edi
80104544:	31 ff                	xor    %edi,%edi
80104546:	56                   	push   %esi
80104547:	53                   	push   %ebx
80104548:	83 ec 18             	sub    $0x18,%esp
8010454b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010454e:	8d 73 04             	lea    0x4(%ebx),%esi
80104551:	56                   	push   %esi
80104552:	e8 29 02 00 00       	call   80104780 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104557:	8b 03                	mov    (%ebx),%eax
80104559:	83 c4 10             	add    $0x10,%esp
8010455c:	85 c0                	test   %eax,%eax
8010455e:	75 18                	jne    80104578 <holdingsleep+0x38>
  release(&lk->lk);
80104560:	83 ec 0c             	sub    $0xc,%esp
80104563:	56                   	push   %esi
80104564:	e8 b7 01 00 00       	call   80104720 <release>
  return r;
}
80104569:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010456c:	89 f8                	mov    %edi,%eax
8010456e:	5b                   	pop    %ebx
8010456f:	5e                   	pop    %esi
80104570:	5f                   	pop    %edi
80104571:	5d                   	pop    %ebp
80104572:	c3                   	ret
80104573:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
80104578:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
8010457b:	e8 c0 f5 ff ff       	call   80103b40 <myproc>
80104580:	39 58 10             	cmp    %ebx,0x10(%eax)
80104583:	0f 94 c0             	sete   %al
80104586:	0f b6 c0             	movzbl %al,%eax
80104589:	89 c7                	mov    %eax,%edi
8010458b:	eb d3                	jmp    80104560 <holdingsleep+0x20>
8010458d:	66 90                	xchg   %ax,%ax
8010458f:	90                   	nop

80104590 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104590:	55                   	push   %ebp
80104591:	89 e5                	mov    %esp,%ebp
80104593:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104596:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104599:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010459f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801045a2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801045a9:	5d                   	pop    %ebp
801045aa:	c3                   	ret
801045ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801045b0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801045b0:	55                   	push   %ebp
801045b1:	89 e5                	mov    %esp,%ebp
801045b3:	53                   	push   %ebx
801045b4:	8b 45 08             	mov    0x8(%ebp),%eax
801045b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801045ba:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801045bd:	05 f8 ff ff 7f       	add    $0x7ffffff8,%eax
801045c2:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
  for(i = 0; i < 10; i++){
801045c7:	b8 00 00 00 00       	mov    $0x0,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801045cc:	76 10                	jbe    801045de <getcallerpcs+0x2e>
801045ce:	eb 28                	jmp    801045f8 <getcallerpcs+0x48>
801045d0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801045d6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801045dc:	77 1a                	ja     801045f8 <getcallerpcs+0x48>
      break;
    pcs[i] = ebp[1];     // saved %eip
801045de:	8b 5a 04             	mov    0x4(%edx),%ebx
801045e1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
801045e4:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
801045e7:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
801045e9:	83 f8 0a             	cmp    $0xa,%eax
801045ec:	75 e2                	jne    801045d0 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801045ee:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801045f1:	c9                   	leave
801045f2:	c3                   	ret
801045f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801045f8:	8d 04 81             	lea    (%ecx,%eax,4),%eax
801045fb:	83 c1 28             	add    $0x28,%ecx
801045fe:	89 ca                	mov    %ecx,%edx
80104600:	29 c2                	sub    %eax,%edx
80104602:	83 e2 04             	and    $0x4,%edx
80104605:	74 11                	je     80104618 <getcallerpcs+0x68>
    pcs[i] = 0;
80104607:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
8010460d:	83 c0 04             	add    $0x4,%eax
80104610:	39 c1                	cmp    %eax,%ecx
80104612:	74 da                	je     801045ee <getcallerpcs+0x3e>
80104614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
80104618:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
8010461e:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80104621:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80104628:	39 c1                	cmp    %eax,%ecx
8010462a:	75 ec                	jne    80104618 <getcallerpcs+0x68>
8010462c:	eb c0                	jmp    801045ee <getcallerpcs+0x3e>
8010462e:	66 90                	xchg   %ax,%ax

80104630 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	53                   	push   %ebx
80104634:	83 ec 04             	sub    $0x4,%esp
80104637:	9c                   	pushf
80104638:	5b                   	pop    %ebx
  asm volatile("cli");
80104639:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010463a:	e8 81 f4 ff ff       	call   80103ac0 <mycpu>
8010463f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104645:	85 c0                	test   %eax,%eax
80104647:	74 17                	je     80104660 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104649:	e8 72 f4 ff ff       	call   80103ac0 <mycpu>
8010464e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104655:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104658:	c9                   	leave
80104659:	c3                   	ret
8010465a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104660:	e8 5b f4 ff ff       	call   80103ac0 <mycpu>
80104665:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010466b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104671:	eb d6                	jmp    80104649 <pushcli+0x19>
80104673:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010467a:	00 
8010467b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104680 <popcli>:

void
popcli(void)
{
80104680:	55                   	push   %ebp
80104681:	89 e5                	mov    %esp,%ebp
80104683:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104686:	9c                   	pushf
80104687:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104688:	f6 c4 02             	test   $0x2,%ah
8010468b:	75 35                	jne    801046c2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010468d:	e8 2e f4 ff ff       	call   80103ac0 <mycpu>
80104692:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104699:	78 34                	js     801046cf <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010469b:	e8 20 f4 ff ff       	call   80103ac0 <mycpu>
801046a0:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801046a6:	85 d2                	test   %edx,%edx
801046a8:	74 06                	je     801046b0 <popcli+0x30>
    sti();
}
801046aa:	c9                   	leave
801046ab:	c3                   	ret
801046ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801046b0:	e8 0b f4 ff ff       	call   80103ac0 <mycpu>
801046b5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801046bb:	85 c0                	test   %eax,%eax
801046bd:	74 eb                	je     801046aa <popcli+0x2a>
  asm volatile("sti");
801046bf:	fb                   	sti
}
801046c0:	c9                   	leave
801046c1:	c3                   	ret
    panic("popcli - interruptible");
801046c2:	83 ec 0c             	sub    $0xc,%esp
801046c5:	68 83 76 10 80       	push   $0x80107683
801046ca:	e8 b1 bc ff ff       	call   80100380 <panic>
    panic("popcli");
801046cf:	83 ec 0c             	sub    $0xc,%esp
801046d2:	68 9a 76 10 80       	push   $0x8010769a
801046d7:	e8 a4 bc ff ff       	call   80100380 <panic>
801046dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801046e0 <holding>:
{
801046e0:	55                   	push   %ebp
801046e1:	89 e5                	mov    %esp,%ebp
801046e3:	56                   	push   %esi
801046e4:	53                   	push   %ebx
801046e5:	8b 75 08             	mov    0x8(%ebp),%esi
801046e8:	31 db                	xor    %ebx,%ebx
  pushcli();
801046ea:	e8 41 ff ff ff       	call   80104630 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801046ef:	8b 06                	mov    (%esi),%eax
801046f1:	85 c0                	test   %eax,%eax
801046f3:	75 0b                	jne    80104700 <holding+0x20>
  popcli();
801046f5:	e8 86 ff ff ff       	call   80104680 <popcli>
}
801046fa:	89 d8                	mov    %ebx,%eax
801046fc:	5b                   	pop    %ebx
801046fd:	5e                   	pop    %esi
801046fe:	5d                   	pop    %ebp
801046ff:	c3                   	ret
  r = lock->locked && lock->cpu == mycpu();
80104700:	8b 5e 08             	mov    0x8(%esi),%ebx
80104703:	e8 b8 f3 ff ff       	call   80103ac0 <mycpu>
80104708:	39 c3                	cmp    %eax,%ebx
8010470a:	0f 94 c3             	sete   %bl
  popcli();
8010470d:	e8 6e ff ff ff       	call   80104680 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104712:	0f b6 db             	movzbl %bl,%ebx
}
80104715:	89 d8                	mov    %ebx,%eax
80104717:	5b                   	pop    %ebx
80104718:	5e                   	pop    %esi
80104719:	5d                   	pop    %ebp
8010471a:	c3                   	ret
8010471b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104720 <release>:
{
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	56                   	push   %esi
80104724:	53                   	push   %ebx
80104725:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104728:	e8 03 ff ff ff       	call   80104630 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010472d:	8b 03                	mov    (%ebx),%eax
8010472f:	85 c0                	test   %eax,%eax
80104731:	75 15                	jne    80104748 <release+0x28>
  popcli();
80104733:	e8 48 ff ff ff       	call   80104680 <popcli>
    panic("release");
80104738:	83 ec 0c             	sub    $0xc,%esp
8010473b:	68 a1 76 10 80       	push   $0x801076a1
80104740:	e8 3b bc ff ff       	call   80100380 <panic>
80104745:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104748:	8b 73 08             	mov    0x8(%ebx),%esi
8010474b:	e8 70 f3 ff ff       	call   80103ac0 <mycpu>
80104750:	39 c6                	cmp    %eax,%esi
80104752:	75 df                	jne    80104733 <release+0x13>
  popcli();
80104754:	e8 27 ff ff ff       	call   80104680 <popcli>
  lk->pcs[0] = 0;
80104759:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104760:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104767:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010476c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104772:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104775:	5b                   	pop    %ebx
80104776:	5e                   	pop    %esi
80104777:	5d                   	pop    %ebp
  popcli();
80104778:	e9 03 ff ff ff       	jmp    80104680 <popcli>
8010477d:	8d 76 00             	lea    0x0(%esi),%esi

80104780 <acquire>:
{
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	53                   	push   %ebx
80104784:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104787:	e8 a4 fe ff ff       	call   80104630 <pushcli>
  if(holding(lk))
8010478c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
8010478f:	e8 9c fe ff ff       	call   80104630 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104794:	8b 03                	mov    (%ebx),%eax
80104796:	85 c0                	test   %eax,%eax
80104798:	0f 85 b2 00 00 00    	jne    80104850 <acquire+0xd0>
  popcli();
8010479e:	e8 dd fe ff ff       	call   80104680 <popcli>
  asm volatile("lock; xchgl %0, %1" :
801047a3:	b9 01 00 00 00       	mov    $0x1,%ecx
801047a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801047af:	00 
  while(xchg(&lk->locked, 1) != 0)
801047b0:	8b 55 08             	mov    0x8(%ebp),%edx
801047b3:	89 c8                	mov    %ecx,%eax
801047b5:	f0 87 02             	lock xchg %eax,(%edx)
801047b8:	85 c0                	test   %eax,%eax
801047ba:	75 f4                	jne    801047b0 <acquire+0x30>
  __sync_synchronize();
801047bc:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801047c1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801047c4:	e8 f7 f2 ff ff       	call   80103ac0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801047c9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  for(i = 0; i < 10; i++){
801047cc:	31 d2                	xor    %edx,%edx
  lk->cpu = mycpu();
801047ce:	89 43 08             	mov    %eax,0x8(%ebx)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801047d1:	8d 85 00 00 00 80    	lea    -0x80000000(%ebp),%eax
801047d7:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
801047dc:	77 32                	ja     80104810 <acquire+0x90>
  ebp = (uint*)v - 2;
801047de:	89 e8                	mov    %ebp,%eax
801047e0:	eb 14                	jmp    801047f6 <acquire+0x76>
801047e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801047e8:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801047ee:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801047f4:	77 1a                	ja     80104810 <acquire+0x90>
    pcs[i] = ebp[1];     // saved %eip
801047f6:	8b 58 04             	mov    0x4(%eax),%ebx
801047f9:	89 5c 91 0c          	mov    %ebx,0xc(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801047fd:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
80104800:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104802:	83 fa 0a             	cmp    $0xa,%edx
80104805:	75 e1                	jne    801047e8 <acquire+0x68>
}
80104807:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010480a:	c9                   	leave
8010480b:	c3                   	ret
8010480c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104810:	8d 44 91 0c          	lea    0xc(%ecx,%edx,4),%eax
80104814:	83 c1 34             	add    $0x34,%ecx
80104817:	89 ca                	mov    %ecx,%edx
80104819:	29 c2                	sub    %eax,%edx
8010481b:	83 e2 04             	and    $0x4,%edx
8010481e:	74 10                	je     80104830 <acquire+0xb0>
    pcs[i] = 0;
80104820:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104826:	83 c0 04             	add    $0x4,%eax
80104829:	39 c1                	cmp    %eax,%ecx
8010482b:	74 da                	je     80104807 <acquire+0x87>
8010482d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80104830:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104836:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80104839:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80104840:	39 c1                	cmp    %eax,%ecx
80104842:	75 ec                	jne    80104830 <acquire+0xb0>
80104844:	eb c1                	jmp    80104807 <acquire+0x87>
80104846:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010484d:	00 
8010484e:	66 90                	xchg   %ax,%ax
  r = lock->locked && lock->cpu == mycpu();
80104850:	8b 5b 08             	mov    0x8(%ebx),%ebx
80104853:	e8 68 f2 ff ff       	call   80103ac0 <mycpu>
80104858:	39 c3                	cmp    %eax,%ebx
8010485a:	0f 85 3e ff ff ff    	jne    8010479e <acquire+0x1e>
  popcli();
80104860:	e8 1b fe ff ff       	call   80104680 <popcli>
    panic("acquire");
80104865:	83 ec 0c             	sub    $0xc,%esp
80104868:	68 a9 76 10 80       	push   $0x801076a9
8010486d:	e8 0e bb ff ff       	call   80100380 <panic>
80104872:	66 90                	xchg   %ax,%ax
80104874:	66 90                	xchg   %ax,%ax
80104876:	66 90                	xchg   %ax,%ax
80104878:	66 90                	xchg   %ax,%ax
8010487a:	66 90                	xchg   %ax,%ax
8010487c:	66 90                	xchg   %ax,%ax
8010487e:	66 90                	xchg   %ax,%ax

80104880 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104880:	55                   	push   %ebp
80104881:	89 e5                	mov    %esp,%ebp
80104883:	57                   	push   %edi
80104884:	8b 55 08             	mov    0x8(%ebp),%edx
80104887:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010488a:	89 d0                	mov    %edx,%eax
8010488c:	09 c8                	or     %ecx,%eax
8010488e:	a8 03                	test   $0x3,%al
80104890:	75 1e                	jne    801048b0 <memset+0x30>
    c &= 0xFF;
80104892:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104896:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
80104899:	89 d7                	mov    %edx,%edi
8010489b:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
801048a1:	fc                   	cld
801048a2:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
801048a4:	8b 7d fc             	mov    -0x4(%ebp),%edi
801048a7:	89 d0                	mov    %edx,%eax
801048a9:	c9                   	leave
801048aa:	c3                   	ret
801048ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
801048b0:	8b 45 0c             	mov    0xc(%ebp),%eax
801048b3:	89 d7                	mov    %edx,%edi
801048b5:	fc                   	cld
801048b6:	f3 aa                	rep stos %al,%es:(%edi)
801048b8:	8b 7d fc             	mov    -0x4(%ebp),%edi
801048bb:	89 d0                	mov    %edx,%eax
801048bd:	c9                   	leave
801048be:	c3                   	ret
801048bf:	90                   	nop

801048c0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	56                   	push   %esi
801048c4:	8b 75 10             	mov    0x10(%ebp),%esi
801048c7:	8b 45 08             	mov    0x8(%ebp),%eax
801048ca:	53                   	push   %ebx
801048cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801048ce:	85 f6                	test   %esi,%esi
801048d0:	74 2e                	je     80104900 <memcmp+0x40>
801048d2:	01 c6                	add    %eax,%esi
801048d4:	eb 14                	jmp    801048ea <memcmp+0x2a>
801048d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801048dd:	00 
801048de:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
801048e0:	83 c0 01             	add    $0x1,%eax
801048e3:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
801048e6:	39 f0                	cmp    %esi,%eax
801048e8:	74 16                	je     80104900 <memcmp+0x40>
    if(*s1 != *s2)
801048ea:	0f b6 08             	movzbl (%eax),%ecx
801048ed:	0f b6 1a             	movzbl (%edx),%ebx
801048f0:	38 d9                	cmp    %bl,%cl
801048f2:	74 ec                	je     801048e0 <memcmp+0x20>
      return *s1 - *s2;
801048f4:	0f b6 c1             	movzbl %cl,%eax
801048f7:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
801048f9:	5b                   	pop    %ebx
801048fa:	5e                   	pop    %esi
801048fb:	5d                   	pop    %ebp
801048fc:	c3                   	ret
801048fd:	8d 76 00             	lea    0x0(%esi),%esi
80104900:	5b                   	pop    %ebx
  return 0;
80104901:	31 c0                	xor    %eax,%eax
}
80104903:	5e                   	pop    %esi
80104904:	5d                   	pop    %ebp
80104905:	c3                   	ret
80104906:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010490d:	00 
8010490e:	66 90                	xchg   %ax,%ax

80104910 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104910:	55                   	push   %ebp
80104911:	89 e5                	mov    %esp,%ebp
80104913:	57                   	push   %edi
80104914:	8b 55 08             	mov    0x8(%ebp),%edx
80104917:	8b 45 10             	mov    0x10(%ebp),%eax
8010491a:	56                   	push   %esi
8010491b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010491e:	39 d6                	cmp    %edx,%esi
80104920:	73 26                	jae    80104948 <memmove+0x38>
80104922:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104925:	39 ca                	cmp    %ecx,%edx
80104927:	73 1f                	jae    80104948 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104929:	85 c0                	test   %eax,%eax
8010492b:	74 0f                	je     8010493c <memmove+0x2c>
8010492d:	83 e8 01             	sub    $0x1,%eax
      *--d = *--s;
80104930:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104934:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104937:	83 e8 01             	sub    $0x1,%eax
8010493a:	73 f4                	jae    80104930 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010493c:	5e                   	pop    %esi
8010493d:	89 d0                	mov    %edx,%eax
8010493f:	5f                   	pop    %edi
80104940:	5d                   	pop    %ebp
80104941:	c3                   	ret
80104942:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104948:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
8010494b:	89 d7                	mov    %edx,%edi
8010494d:	85 c0                	test   %eax,%eax
8010494f:	74 eb                	je     8010493c <memmove+0x2c>
80104951:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104958:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104959:	39 ce                	cmp    %ecx,%esi
8010495b:	75 fb                	jne    80104958 <memmove+0x48>
}
8010495d:	5e                   	pop    %esi
8010495e:	89 d0                	mov    %edx,%eax
80104960:	5f                   	pop    %edi
80104961:	5d                   	pop    %ebp
80104962:	c3                   	ret
80104963:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010496a:	00 
8010496b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104970 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104970:	eb 9e                	jmp    80104910 <memmove>
80104972:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104979:	00 
8010497a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104980 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104980:	55                   	push   %ebp
80104981:	89 e5                	mov    %esp,%ebp
80104983:	53                   	push   %ebx
80104984:	8b 55 10             	mov    0x10(%ebp),%edx
80104987:	8b 45 08             	mov    0x8(%ebp),%eax
8010498a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
8010498d:	85 d2                	test   %edx,%edx
8010498f:	75 16                	jne    801049a7 <strncmp+0x27>
80104991:	eb 2d                	jmp    801049c0 <strncmp+0x40>
80104993:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104998:	3a 19                	cmp    (%ecx),%bl
8010499a:	75 12                	jne    801049ae <strncmp+0x2e>
    n--, p++, q++;
8010499c:	83 c0 01             	add    $0x1,%eax
8010499f:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
801049a2:	83 ea 01             	sub    $0x1,%edx
801049a5:	74 19                	je     801049c0 <strncmp+0x40>
801049a7:	0f b6 18             	movzbl (%eax),%ebx
801049aa:	84 db                	test   %bl,%bl
801049ac:	75 ea                	jne    80104998 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
801049ae:	0f b6 00             	movzbl (%eax),%eax
801049b1:	0f b6 11             	movzbl (%ecx),%edx
}
801049b4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049b7:	c9                   	leave
  return (uchar)*p - (uchar)*q;
801049b8:	29 d0                	sub    %edx,%eax
}
801049ba:	c3                   	ret
801049bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801049c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
801049c3:	31 c0                	xor    %eax,%eax
}
801049c5:	c9                   	leave
801049c6:	c3                   	ret
801049c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801049ce:	00 
801049cf:	90                   	nop

801049d0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801049d0:	55                   	push   %ebp
801049d1:	89 e5                	mov    %esp,%ebp
801049d3:	57                   	push   %edi
801049d4:	56                   	push   %esi
801049d5:	8b 75 08             	mov    0x8(%ebp),%esi
801049d8:	53                   	push   %ebx
801049d9:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801049dc:	89 f0                	mov    %esi,%eax
801049de:	eb 15                	jmp    801049f5 <strncpy+0x25>
801049e0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
801049e4:	8b 7d 0c             	mov    0xc(%ebp),%edi
801049e7:	83 c0 01             	add    $0x1,%eax
801049ea:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
801049ee:	88 48 ff             	mov    %cl,-0x1(%eax)
801049f1:	84 c9                	test   %cl,%cl
801049f3:	74 13                	je     80104a08 <strncpy+0x38>
801049f5:	89 d3                	mov    %edx,%ebx
801049f7:	83 ea 01             	sub    $0x1,%edx
801049fa:	85 db                	test   %ebx,%ebx
801049fc:	7f e2                	jg     801049e0 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
801049fe:	5b                   	pop    %ebx
801049ff:	89 f0                	mov    %esi,%eax
80104a01:	5e                   	pop    %esi
80104a02:	5f                   	pop    %edi
80104a03:	5d                   	pop    %ebp
80104a04:	c3                   	ret
80104a05:	8d 76 00             	lea    0x0(%esi),%esi
  while(n-- > 0)
80104a08:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80104a0b:	83 e9 01             	sub    $0x1,%ecx
80104a0e:	85 d2                	test   %edx,%edx
80104a10:	74 ec                	je     801049fe <strncpy+0x2e>
80104a12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *s++ = 0;
80104a18:	83 c0 01             	add    $0x1,%eax
80104a1b:	89 ca                	mov    %ecx,%edx
80104a1d:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
80104a21:	29 c2                	sub    %eax,%edx
80104a23:	85 d2                	test   %edx,%edx
80104a25:	7f f1                	jg     80104a18 <strncpy+0x48>
}
80104a27:	5b                   	pop    %ebx
80104a28:	89 f0                	mov    %esi,%eax
80104a2a:	5e                   	pop    %esi
80104a2b:	5f                   	pop    %edi
80104a2c:	5d                   	pop    %ebp
80104a2d:	c3                   	ret
80104a2e:	66 90                	xchg   %ax,%ax

80104a30 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104a30:	55                   	push   %ebp
80104a31:	89 e5                	mov    %esp,%ebp
80104a33:	56                   	push   %esi
80104a34:	8b 55 10             	mov    0x10(%ebp),%edx
80104a37:	8b 75 08             	mov    0x8(%ebp),%esi
80104a3a:	53                   	push   %ebx
80104a3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104a3e:	85 d2                	test   %edx,%edx
80104a40:	7e 25                	jle    80104a67 <safestrcpy+0x37>
80104a42:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104a46:	89 f2                	mov    %esi,%edx
80104a48:	eb 16                	jmp    80104a60 <safestrcpy+0x30>
80104a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104a50:	0f b6 08             	movzbl (%eax),%ecx
80104a53:	83 c0 01             	add    $0x1,%eax
80104a56:	83 c2 01             	add    $0x1,%edx
80104a59:	88 4a ff             	mov    %cl,-0x1(%edx)
80104a5c:	84 c9                	test   %cl,%cl
80104a5e:	74 04                	je     80104a64 <safestrcpy+0x34>
80104a60:	39 d8                	cmp    %ebx,%eax
80104a62:	75 ec                	jne    80104a50 <safestrcpy+0x20>
    ;
  *s = 0;
80104a64:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104a67:	89 f0                	mov    %esi,%eax
80104a69:	5b                   	pop    %ebx
80104a6a:	5e                   	pop    %esi
80104a6b:	5d                   	pop    %ebp
80104a6c:	c3                   	ret
80104a6d:	8d 76 00             	lea    0x0(%esi),%esi

80104a70 <strlen>:

int
strlen(const char *s)
{
80104a70:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104a71:	31 c0                	xor    %eax,%eax
{
80104a73:	89 e5                	mov    %esp,%ebp
80104a75:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104a78:	80 3a 00             	cmpb   $0x0,(%edx)
80104a7b:	74 0c                	je     80104a89 <strlen+0x19>
80104a7d:	8d 76 00             	lea    0x0(%esi),%esi
80104a80:	83 c0 01             	add    $0x1,%eax
80104a83:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104a87:	75 f7                	jne    80104a80 <strlen+0x10>
    ;
  return n;
}
80104a89:	5d                   	pop    %ebp
80104a8a:	c3                   	ret

80104a8b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104a8b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104a8f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104a93:	55                   	push   %ebp
  pushl %ebx
80104a94:	53                   	push   %ebx
  pushl %esi
80104a95:	56                   	push   %esi
  pushl %edi
80104a96:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104a97:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104a99:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104a9b:	5f                   	pop    %edi
  popl %esi
80104a9c:	5e                   	pop    %esi
  popl %ebx
80104a9d:	5b                   	pop    %ebx
  popl %ebp
80104a9e:	5d                   	pop    %ebp
  ret
80104a9f:	c3                   	ret

80104aa0 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104aa0:	55                   	push   %ebp
80104aa1:	89 e5                	mov    %esp,%ebp
80104aa3:	53                   	push   %ebx
80104aa4:	83 ec 04             	sub    $0x4,%esp
80104aa7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104aaa:	e8 91 f0 ff ff       	call   80103b40 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104aaf:	8b 00                	mov    (%eax),%eax
80104ab1:	39 c3                	cmp    %eax,%ebx
80104ab3:	73 1b                	jae    80104ad0 <fetchint+0x30>
80104ab5:	8d 53 04             	lea    0x4(%ebx),%edx
80104ab8:	39 d0                	cmp    %edx,%eax
80104aba:	72 14                	jb     80104ad0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104abc:	8b 45 0c             	mov    0xc(%ebp),%eax
80104abf:	8b 13                	mov    (%ebx),%edx
80104ac1:	89 10                	mov    %edx,(%eax)
  return 0;
80104ac3:	31 c0                	xor    %eax,%eax
}
80104ac5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ac8:	c9                   	leave
80104ac9:	c3                   	ret
80104aca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104ad0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ad5:	eb ee                	jmp    80104ac5 <fetchint+0x25>
80104ad7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104ade:	00 
80104adf:	90                   	nop

80104ae0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104ae0:	55                   	push   %ebp
80104ae1:	89 e5                	mov    %esp,%ebp
80104ae3:	53                   	push   %ebx
80104ae4:	83 ec 04             	sub    $0x4,%esp
80104ae7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104aea:	e8 51 f0 ff ff       	call   80103b40 <myproc>

  if(addr >= curproc->sz)
80104aef:	3b 18                	cmp    (%eax),%ebx
80104af1:	73 2d                	jae    80104b20 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80104af3:	8b 55 0c             	mov    0xc(%ebp),%edx
80104af6:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104af8:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104afa:	39 d3                	cmp    %edx,%ebx
80104afc:	73 22                	jae    80104b20 <fetchstr+0x40>
80104afe:	89 d8                	mov    %ebx,%eax
80104b00:	eb 0d                	jmp    80104b0f <fetchstr+0x2f>
80104b02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b08:	83 c0 01             	add    $0x1,%eax
80104b0b:	39 d0                	cmp    %edx,%eax
80104b0d:	73 11                	jae    80104b20 <fetchstr+0x40>
    if(*s == 0)
80104b0f:	80 38 00             	cmpb   $0x0,(%eax)
80104b12:	75 f4                	jne    80104b08 <fetchstr+0x28>
      return s - *pp;
80104b14:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104b16:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b19:	c9                   	leave
80104b1a:	c3                   	ret
80104b1b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b20:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80104b23:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104b28:	c9                   	leave
80104b29:	c3                   	ret
80104b2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104b30 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104b30:	55                   	push   %ebp
80104b31:	89 e5                	mov    %esp,%ebp
80104b33:	56                   	push   %esi
80104b34:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b35:	e8 06 f0 ff ff       	call   80103b40 <myproc>
80104b3a:	8b 55 08             	mov    0x8(%ebp),%edx
80104b3d:	8b 40 18             	mov    0x18(%eax),%eax
80104b40:	8b 40 44             	mov    0x44(%eax),%eax
80104b43:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104b46:	e8 f5 ef ff ff       	call   80103b40 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b4b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104b4e:	8b 00                	mov    (%eax),%eax
80104b50:	39 c6                	cmp    %eax,%esi
80104b52:	73 1c                	jae    80104b70 <argint+0x40>
80104b54:	8d 53 08             	lea    0x8(%ebx),%edx
80104b57:	39 d0                	cmp    %edx,%eax
80104b59:	72 15                	jb     80104b70 <argint+0x40>
  *ip = *(int*)(addr);
80104b5b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b5e:	8b 53 04             	mov    0x4(%ebx),%edx
80104b61:	89 10                	mov    %edx,(%eax)
  return 0;
80104b63:	31 c0                	xor    %eax,%eax
}
80104b65:	5b                   	pop    %ebx
80104b66:	5e                   	pop    %esi
80104b67:	5d                   	pop    %ebp
80104b68:	c3                   	ret
80104b69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104b70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b75:	eb ee                	jmp    80104b65 <argint+0x35>
80104b77:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b7e:	00 
80104b7f:	90                   	nop

80104b80 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104b80:	55                   	push   %ebp
80104b81:	89 e5                	mov    %esp,%ebp
80104b83:	57                   	push   %edi
80104b84:	56                   	push   %esi
80104b85:	53                   	push   %ebx
80104b86:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80104b89:	e8 b2 ef ff ff       	call   80103b40 <myproc>
80104b8e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104b90:	e8 ab ef ff ff       	call   80103b40 <myproc>
80104b95:	8b 55 08             	mov    0x8(%ebp),%edx
80104b98:	8b 40 18             	mov    0x18(%eax),%eax
80104b9b:	8b 40 44             	mov    0x44(%eax),%eax
80104b9e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104ba1:	e8 9a ef ff ff       	call   80103b40 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104ba6:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104ba9:	8b 00                	mov    (%eax),%eax
80104bab:	39 c7                	cmp    %eax,%edi
80104bad:	73 31                	jae    80104be0 <argptr+0x60>
80104baf:	8d 4b 08             	lea    0x8(%ebx),%ecx
80104bb2:	39 c8                	cmp    %ecx,%eax
80104bb4:	72 2a                	jb     80104be0 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104bb6:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80104bb9:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104bbc:	85 d2                	test   %edx,%edx
80104bbe:	78 20                	js     80104be0 <argptr+0x60>
80104bc0:	8b 16                	mov    (%esi),%edx
80104bc2:	39 d0                	cmp    %edx,%eax
80104bc4:	73 1a                	jae    80104be0 <argptr+0x60>
80104bc6:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104bc9:	01 c3                	add    %eax,%ebx
80104bcb:	39 da                	cmp    %ebx,%edx
80104bcd:	72 11                	jb     80104be0 <argptr+0x60>
    return -1;
  *pp = (char*)i;
80104bcf:	8b 55 0c             	mov    0xc(%ebp),%edx
80104bd2:	89 02                	mov    %eax,(%edx)
  return 0;
80104bd4:	31 c0                	xor    %eax,%eax
}
80104bd6:	83 c4 0c             	add    $0xc,%esp
80104bd9:	5b                   	pop    %ebx
80104bda:	5e                   	pop    %esi
80104bdb:	5f                   	pop    %edi
80104bdc:	5d                   	pop    %ebp
80104bdd:	c3                   	ret
80104bde:	66 90                	xchg   %ax,%ax
    return -1;
80104be0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104be5:	eb ef                	jmp    80104bd6 <argptr+0x56>
80104be7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104bee:	00 
80104bef:	90                   	nop

80104bf0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104bf0:	55                   	push   %ebp
80104bf1:	89 e5                	mov    %esp,%ebp
80104bf3:	56                   	push   %esi
80104bf4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104bf5:	e8 46 ef ff ff       	call   80103b40 <myproc>
80104bfa:	8b 55 08             	mov    0x8(%ebp),%edx
80104bfd:	8b 40 18             	mov    0x18(%eax),%eax
80104c00:	8b 40 44             	mov    0x44(%eax),%eax
80104c03:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104c06:	e8 35 ef ff ff       	call   80103b40 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c0b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104c0e:	8b 00                	mov    (%eax),%eax
80104c10:	39 c6                	cmp    %eax,%esi
80104c12:	73 44                	jae    80104c58 <argstr+0x68>
80104c14:	8d 53 08             	lea    0x8(%ebx),%edx
80104c17:	39 d0                	cmp    %edx,%eax
80104c19:	72 3d                	jb     80104c58 <argstr+0x68>
  *ip = *(int*)(addr);
80104c1b:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80104c1e:	e8 1d ef ff ff       	call   80103b40 <myproc>
  if(addr >= curproc->sz)
80104c23:	3b 18                	cmp    (%eax),%ebx
80104c25:	73 31                	jae    80104c58 <argstr+0x68>
  *pp = (char*)addr;
80104c27:	8b 55 0c             	mov    0xc(%ebp),%edx
80104c2a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104c2c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104c2e:	39 d3                	cmp    %edx,%ebx
80104c30:	73 26                	jae    80104c58 <argstr+0x68>
80104c32:	89 d8                	mov    %ebx,%eax
80104c34:	eb 11                	jmp    80104c47 <argstr+0x57>
80104c36:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c3d:	00 
80104c3e:	66 90                	xchg   %ax,%ax
80104c40:	83 c0 01             	add    $0x1,%eax
80104c43:	39 d0                	cmp    %edx,%eax
80104c45:	73 11                	jae    80104c58 <argstr+0x68>
    if(*s == 0)
80104c47:	80 38 00             	cmpb   $0x0,(%eax)
80104c4a:	75 f4                	jne    80104c40 <argstr+0x50>
      return s - *pp;
80104c4c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104c4e:	5b                   	pop    %ebx
80104c4f:	5e                   	pop    %esi
80104c50:	5d                   	pop    %ebp
80104c51:	c3                   	ret
80104c52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104c58:	5b                   	pop    %ebx
    return -1;
80104c59:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104c5e:	5e                   	pop    %esi
80104c5f:	5d                   	pop    %ebp
80104c60:	c3                   	ret
80104c61:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c68:	00 
80104c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104c70 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80104c70:	55                   	push   %ebp
80104c71:	89 e5                	mov    %esp,%ebp
80104c73:	53                   	push   %ebx
80104c74:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104c77:	e8 c4 ee ff ff       	call   80103b40 <myproc>
80104c7c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104c7e:	8b 40 18             	mov    0x18(%eax),%eax
80104c81:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104c84:	8d 50 ff             	lea    -0x1(%eax),%edx
80104c87:	83 fa 14             	cmp    $0x14,%edx
80104c8a:	77 24                	ja     80104cb0 <syscall+0x40>
80104c8c:	8b 14 85 60 7c 10 80 	mov    -0x7fef83a0(,%eax,4),%edx
80104c93:	85 d2                	test   %edx,%edx
80104c95:	74 19                	je     80104cb0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104c97:	ff d2                	call   *%edx
80104c99:	89 c2                	mov    %eax,%edx
80104c9b:	8b 43 18             	mov    0x18(%ebx),%eax
80104c9e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104ca1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ca4:	c9                   	leave
80104ca5:	c3                   	ret
80104ca6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104cad:	00 
80104cae:	66 90                	xchg   %ax,%ax
    cprintf("%d %s: unknown sys call %d\n",
80104cb0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104cb1:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104cb4:	50                   	push   %eax
80104cb5:	ff 73 10             	push   0x10(%ebx)
80104cb8:	68 b1 76 10 80       	push   $0x801076b1
80104cbd:	e8 ae b9 ff ff       	call   80100670 <cprintf>
    curproc->tf->eax = -1;
80104cc2:	8b 43 18             	mov    0x18(%ebx),%eax
80104cc5:	83 c4 10             	add    $0x10,%esp
80104cc8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104ccf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104cd2:	c9                   	leave
80104cd3:	c3                   	ret
80104cd4:	66 90                	xchg   %ax,%ax
80104cd6:	66 90                	xchg   %ax,%ax
80104cd8:	66 90                	xchg   %ax,%ax
80104cda:	66 90                	xchg   %ax,%ax
80104cdc:	66 90                	xchg   %ax,%ax
80104cde:	66 90                	xchg   %ax,%ax

80104ce0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104ce0:	55                   	push   %ebp
80104ce1:	89 e5                	mov    %esp,%ebp
80104ce3:	57                   	push   %edi
80104ce4:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104ce5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80104ce8:	53                   	push   %ebx
80104ce9:	83 ec 34             	sub    $0x34,%esp
80104cec:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104cef:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104cf2:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104cf5:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104cf8:	57                   	push   %edi
80104cf9:	50                   	push   %eax
80104cfa:	e8 81 d5 ff ff       	call   80102280 <nameiparent>
80104cff:	83 c4 10             	add    $0x10,%esp
80104d02:	85 c0                	test   %eax,%eax
80104d04:	74 5e                	je     80104d64 <create+0x84>
    return 0;
  ilock(dp);
80104d06:	83 ec 0c             	sub    $0xc,%esp
80104d09:	89 c3                	mov    %eax,%ebx
80104d0b:	50                   	push   %eax
80104d0c:	e8 6f cc ff ff       	call   80101980 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104d11:	83 c4 0c             	add    $0xc,%esp
80104d14:	6a 00                	push   $0x0
80104d16:	57                   	push   %edi
80104d17:	53                   	push   %ebx
80104d18:	e8 b3 d1 ff ff       	call   80101ed0 <dirlookup>
80104d1d:	83 c4 10             	add    $0x10,%esp
80104d20:	89 c6                	mov    %eax,%esi
80104d22:	85 c0                	test   %eax,%eax
80104d24:	74 4a                	je     80104d70 <create+0x90>
    iunlockput(dp);
80104d26:	83 ec 0c             	sub    $0xc,%esp
80104d29:	53                   	push   %ebx
80104d2a:	e8 e1 ce ff ff       	call   80101c10 <iunlockput>
    ilock(ip);
80104d2f:	89 34 24             	mov    %esi,(%esp)
80104d32:	e8 49 cc ff ff       	call   80101980 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104d37:	83 c4 10             	add    $0x10,%esp
80104d3a:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104d3f:	75 17                	jne    80104d58 <create+0x78>
80104d41:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104d46:	75 10                	jne    80104d58 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104d48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104d4b:	89 f0                	mov    %esi,%eax
80104d4d:	5b                   	pop    %ebx
80104d4e:	5e                   	pop    %esi
80104d4f:	5f                   	pop    %edi
80104d50:	5d                   	pop    %ebp
80104d51:	c3                   	ret
80104d52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80104d58:	83 ec 0c             	sub    $0xc,%esp
80104d5b:	56                   	push   %esi
80104d5c:	e8 af ce ff ff       	call   80101c10 <iunlockput>
    return 0;
80104d61:	83 c4 10             	add    $0x10,%esp
}
80104d64:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104d67:	31 f6                	xor    %esi,%esi
}
80104d69:	5b                   	pop    %ebx
80104d6a:	89 f0                	mov    %esi,%eax
80104d6c:	5e                   	pop    %esi
80104d6d:	5f                   	pop    %edi
80104d6e:	5d                   	pop    %ebp
80104d6f:	c3                   	ret
  if((ip = ialloc(dp->dev, type)) == 0)
80104d70:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104d74:	83 ec 08             	sub    $0x8,%esp
80104d77:	50                   	push   %eax
80104d78:	ff 33                	push   (%ebx)
80104d7a:	e8 91 ca ff ff       	call   80101810 <ialloc>
80104d7f:	83 c4 10             	add    $0x10,%esp
80104d82:	89 c6                	mov    %eax,%esi
80104d84:	85 c0                	test   %eax,%eax
80104d86:	0f 84 bc 00 00 00    	je     80104e48 <create+0x168>
  ilock(ip);
80104d8c:	83 ec 0c             	sub    $0xc,%esp
80104d8f:	50                   	push   %eax
80104d90:	e8 eb cb ff ff       	call   80101980 <ilock>
  ip->major = major;
80104d95:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104d99:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104d9d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104da1:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104da5:	b8 01 00 00 00       	mov    $0x1,%eax
80104daa:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80104dae:	89 34 24             	mov    %esi,(%esp)
80104db1:	e8 1a cb ff ff       	call   801018d0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104db6:	83 c4 10             	add    $0x10,%esp
80104db9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104dbe:	74 30                	je     80104df0 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
80104dc0:	83 ec 04             	sub    $0x4,%esp
80104dc3:	ff 76 04             	push   0x4(%esi)
80104dc6:	57                   	push   %edi
80104dc7:	53                   	push   %ebx
80104dc8:	e8 d3 d3 ff ff       	call   801021a0 <dirlink>
80104dcd:	83 c4 10             	add    $0x10,%esp
80104dd0:	85 c0                	test   %eax,%eax
80104dd2:	78 67                	js     80104e3b <create+0x15b>
  iunlockput(dp);
80104dd4:	83 ec 0c             	sub    $0xc,%esp
80104dd7:	53                   	push   %ebx
80104dd8:	e8 33 ce ff ff       	call   80101c10 <iunlockput>
  return ip;
80104ddd:	83 c4 10             	add    $0x10,%esp
}
80104de0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104de3:	89 f0                	mov    %esi,%eax
80104de5:	5b                   	pop    %ebx
80104de6:	5e                   	pop    %esi
80104de7:	5f                   	pop    %edi
80104de8:	5d                   	pop    %ebp
80104de9:	c3                   	ret
80104dea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104df0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104df3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104df8:	53                   	push   %ebx
80104df9:	e8 d2 ca ff ff       	call   801018d0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104dfe:	83 c4 0c             	add    $0xc,%esp
80104e01:	ff 76 04             	push   0x4(%esi)
80104e04:	68 e9 76 10 80       	push   $0x801076e9
80104e09:	56                   	push   %esi
80104e0a:	e8 91 d3 ff ff       	call   801021a0 <dirlink>
80104e0f:	83 c4 10             	add    $0x10,%esp
80104e12:	85 c0                	test   %eax,%eax
80104e14:	78 18                	js     80104e2e <create+0x14e>
80104e16:	83 ec 04             	sub    $0x4,%esp
80104e19:	ff 73 04             	push   0x4(%ebx)
80104e1c:	68 e8 76 10 80       	push   $0x801076e8
80104e21:	56                   	push   %esi
80104e22:	e8 79 d3 ff ff       	call   801021a0 <dirlink>
80104e27:	83 c4 10             	add    $0x10,%esp
80104e2a:	85 c0                	test   %eax,%eax
80104e2c:	79 92                	jns    80104dc0 <create+0xe0>
      panic("create dots");
80104e2e:	83 ec 0c             	sub    $0xc,%esp
80104e31:	68 dc 76 10 80       	push   $0x801076dc
80104e36:	e8 45 b5 ff ff       	call   80100380 <panic>
    panic("create: dirlink");
80104e3b:	83 ec 0c             	sub    $0xc,%esp
80104e3e:	68 eb 76 10 80       	push   $0x801076eb
80104e43:	e8 38 b5 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80104e48:	83 ec 0c             	sub    $0xc,%esp
80104e4b:	68 cd 76 10 80       	push   $0x801076cd
80104e50:	e8 2b b5 ff ff       	call   80100380 <panic>
80104e55:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e5c:	00 
80104e5d:	8d 76 00             	lea    0x0(%esi),%esi

80104e60 <sys_dup>:
{
80104e60:	55                   	push   %ebp
80104e61:	89 e5                	mov    %esp,%ebp
80104e63:	56                   	push   %esi
80104e64:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104e65:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80104e68:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104e6b:	50                   	push   %eax
80104e6c:	6a 00                	push   $0x0
80104e6e:	e8 bd fc ff ff       	call   80104b30 <argint>
80104e73:	83 c4 10             	add    $0x10,%esp
80104e76:	85 c0                	test   %eax,%eax
80104e78:	78 36                	js     80104eb0 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104e7a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104e7e:	77 30                	ja     80104eb0 <sys_dup+0x50>
80104e80:	e8 bb ec ff ff       	call   80103b40 <myproc>
80104e85:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e88:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104e8c:	85 f6                	test   %esi,%esi
80104e8e:	74 20                	je     80104eb0 <sys_dup+0x50>
  struct proc *curproc = myproc();
80104e90:	e8 ab ec ff ff       	call   80103b40 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80104e95:	31 db                	xor    %ebx,%ebx
80104e97:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e9e:	00 
80104e9f:	90                   	nop
    if(curproc->ofile[fd] == 0){
80104ea0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104ea4:	85 d2                	test   %edx,%edx
80104ea6:	74 18                	je     80104ec0 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80104ea8:	83 c3 01             	add    $0x1,%ebx
80104eab:	83 fb 10             	cmp    $0x10,%ebx
80104eae:	75 f0                	jne    80104ea0 <sys_dup+0x40>
}
80104eb0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104eb3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104eb8:	89 d8                	mov    %ebx,%eax
80104eba:	5b                   	pop    %ebx
80104ebb:	5e                   	pop    %esi
80104ebc:	5d                   	pop    %ebp
80104ebd:	c3                   	ret
80104ebe:	66 90                	xchg   %ax,%ax
  filedup(f);
80104ec0:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80104ec3:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104ec7:	56                   	push   %esi
80104ec8:	e8 c3 c1 ff ff       	call   80101090 <filedup>
  return fd;
80104ecd:	83 c4 10             	add    $0x10,%esp
}
80104ed0:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ed3:	89 d8                	mov    %ebx,%eax
80104ed5:	5b                   	pop    %ebx
80104ed6:	5e                   	pop    %esi
80104ed7:	5d                   	pop    %ebp
80104ed8:	c3                   	ret
80104ed9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104ee0 <sys_read>:
{
80104ee0:	55                   	push   %ebp
80104ee1:	89 e5                	mov    %esp,%ebp
80104ee3:	56                   	push   %esi
80104ee4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104ee5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104ee8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104eeb:	53                   	push   %ebx
80104eec:	6a 00                	push   $0x0
80104eee:	e8 3d fc ff ff       	call   80104b30 <argint>
80104ef3:	83 c4 10             	add    $0x10,%esp
80104ef6:	85 c0                	test   %eax,%eax
80104ef8:	78 5e                	js     80104f58 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104efa:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104efe:	77 58                	ja     80104f58 <sys_read+0x78>
80104f00:	e8 3b ec ff ff       	call   80103b40 <myproc>
80104f05:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104f08:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104f0c:	85 f6                	test   %esi,%esi
80104f0e:	74 48                	je     80104f58 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f10:	83 ec 08             	sub    $0x8,%esp
80104f13:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f16:	50                   	push   %eax
80104f17:	6a 02                	push   $0x2
80104f19:	e8 12 fc ff ff       	call   80104b30 <argint>
80104f1e:	83 c4 10             	add    $0x10,%esp
80104f21:	85 c0                	test   %eax,%eax
80104f23:	78 33                	js     80104f58 <sys_read+0x78>
80104f25:	83 ec 04             	sub    $0x4,%esp
80104f28:	ff 75 f0             	push   -0x10(%ebp)
80104f2b:	53                   	push   %ebx
80104f2c:	6a 01                	push   $0x1
80104f2e:	e8 4d fc ff ff       	call   80104b80 <argptr>
80104f33:	83 c4 10             	add    $0x10,%esp
80104f36:	85 c0                	test   %eax,%eax
80104f38:	78 1e                	js     80104f58 <sys_read+0x78>
  return fileread(f, p, n);
80104f3a:	83 ec 04             	sub    $0x4,%esp
80104f3d:	ff 75 f0             	push   -0x10(%ebp)
80104f40:	ff 75 f4             	push   -0xc(%ebp)
80104f43:	56                   	push   %esi
80104f44:	e8 c7 c2 ff ff       	call   80101210 <fileread>
80104f49:	83 c4 10             	add    $0x10,%esp
}
80104f4c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f4f:	5b                   	pop    %ebx
80104f50:	5e                   	pop    %esi
80104f51:	5d                   	pop    %ebp
80104f52:	c3                   	ret
80104f53:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80104f58:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f5d:	eb ed                	jmp    80104f4c <sys_read+0x6c>
80104f5f:	90                   	nop

80104f60 <sys_write>:
{
80104f60:	55                   	push   %ebp
80104f61:	89 e5                	mov    %esp,%ebp
80104f63:	56                   	push   %esi
80104f64:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104f65:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104f68:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104f6b:	53                   	push   %ebx
80104f6c:	6a 00                	push   $0x0
80104f6e:	e8 bd fb ff ff       	call   80104b30 <argint>
80104f73:	83 c4 10             	add    $0x10,%esp
80104f76:	85 c0                	test   %eax,%eax
80104f78:	78 5e                	js     80104fd8 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104f7a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104f7e:	77 58                	ja     80104fd8 <sys_write+0x78>
80104f80:	e8 bb eb ff ff       	call   80103b40 <myproc>
80104f85:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104f88:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104f8c:	85 f6                	test   %esi,%esi
80104f8e:	74 48                	je     80104fd8 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104f90:	83 ec 08             	sub    $0x8,%esp
80104f93:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104f96:	50                   	push   %eax
80104f97:	6a 02                	push   $0x2
80104f99:	e8 92 fb ff ff       	call   80104b30 <argint>
80104f9e:	83 c4 10             	add    $0x10,%esp
80104fa1:	85 c0                	test   %eax,%eax
80104fa3:	78 33                	js     80104fd8 <sys_write+0x78>
80104fa5:	83 ec 04             	sub    $0x4,%esp
80104fa8:	ff 75 f0             	push   -0x10(%ebp)
80104fab:	53                   	push   %ebx
80104fac:	6a 01                	push   $0x1
80104fae:	e8 cd fb ff ff       	call   80104b80 <argptr>
80104fb3:	83 c4 10             	add    $0x10,%esp
80104fb6:	85 c0                	test   %eax,%eax
80104fb8:	78 1e                	js     80104fd8 <sys_write+0x78>
  return filewrite(f, p, n);
80104fba:	83 ec 04             	sub    $0x4,%esp
80104fbd:	ff 75 f0             	push   -0x10(%ebp)
80104fc0:	ff 75 f4             	push   -0xc(%ebp)
80104fc3:	56                   	push   %esi
80104fc4:	e8 d7 c2 ff ff       	call   801012a0 <filewrite>
80104fc9:	83 c4 10             	add    $0x10,%esp
}
80104fcc:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104fcf:	5b                   	pop    %ebx
80104fd0:	5e                   	pop    %esi
80104fd1:	5d                   	pop    %ebp
80104fd2:	c3                   	ret
80104fd3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80104fd8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104fdd:	eb ed                	jmp    80104fcc <sys_write+0x6c>
80104fdf:	90                   	nop

80104fe0 <sys_close>:
{
80104fe0:	55                   	push   %ebp
80104fe1:	89 e5                	mov    %esp,%ebp
80104fe3:	56                   	push   %esi
80104fe4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104fe5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80104fe8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104feb:	50                   	push   %eax
80104fec:	6a 00                	push   $0x0
80104fee:	e8 3d fb ff ff       	call   80104b30 <argint>
80104ff3:	83 c4 10             	add    $0x10,%esp
80104ff6:	85 c0                	test   %eax,%eax
80104ff8:	78 3e                	js     80105038 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104ffa:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104ffe:	77 38                	ja     80105038 <sys_close+0x58>
80105000:	e8 3b eb ff ff       	call   80103b40 <myproc>
80105005:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105008:	8d 5a 08             	lea    0x8(%edx),%ebx
8010500b:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
8010500f:	85 f6                	test   %esi,%esi
80105011:	74 25                	je     80105038 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80105013:	e8 28 eb ff ff       	call   80103b40 <myproc>
  fileclose(f);
80105018:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
8010501b:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80105022:	00 
  fileclose(f);
80105023:	56                   	push   %esi
80105024:	e8 b7 c0 ff ff       	call   801010e0 <fileclose>
  return 0;
80105029:	83 c4 10             	add    $0x10,%esp
8010502c:	31 c0                	xor    %eax,%eax
}
8010502e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105031:	5b                   	pop    %ebx
80105032:	5e                   	pop    %esi
80105033:	5d                   	pop    %ebp
80105034:	c3                   	ret
80105035:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105038:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010503d:	eb ef                	jmp    8010502e <sys_close+0x4e>
8010503f:	90                   	nop

80105040 <sys_fstat>:
{
80105040:	55                   	push   %ebp
80105041:	89 e5                	mov    %esp,%ebp
80105043:	56                   	push   %esi
80105044:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105045:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105048:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010504b:	53                   	push   %ebx
8010504c:	6a 00                	push   $0x0
8010504e:	e8 dd fa ff ff       	call   80104b30 <argint>
80105053:	83 c4 10             	add    $0x10,%esp
80105056:	85 c0                	test   %eax,%eax
80105058:	78 46                	js     801050a0 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010505a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010505e:	77 40                	ja     801050a0 <sys_fstat+0x60>
80105060:	e8 db ea ff ff       	call   80103b40 <myproc>
80105065:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105068:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010506c:	85 f6                	test   %esi,%esi
8010506e:	74 30                	je     801050a0 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105070:	83 ec 04             	sub    $0x4,%esp
80105073:	6a 14                	push   $0x14
80105075:	53                   	push   %ebx
80105076:	6a 01                	push   $0x1
80105078:	e8 03 fb ff ff       	call   80104b80 <argptr>
8010507d:	83 c4 10             	add    $0x10,%esp
80105080:	85 c0                	test   %eax,%eax
80105082:	78 1c                	js     801050a0 <sys_fstat+0x60>
  return filestat(f, st);
80105084:	83 ec 08             	sub    $0x8,%esp
80105087:	ff 75 f4             	push   -0xc(%ebp)
8010508a:	56                   	push   %esi
8010508b:	e8 30 c1 ff ff       	call   801011c0 <filestat>
80105090:	83 c4 10             	add    $0x10,%esp
}
80105093:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105096:	5b                   	pop    %ebx
80105097:	5e                   	pop    %esi
80105098:	5d                   	pop    %ebp
80105099:	c3                   	ret
8010509a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801050a0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050a5:	eb ec                	jmp    80105093 <sys_fstat+0x53>
801050a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801050ae:	00 
801050af:	90                   	nop

801050b0 <sys_link>:
{
801050b0:	55                   	push   %ebp
801050b1:	89 e5                	mov    %esp,%ebp
801050b3:	57                   	push   %edi
801050b4:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801050b5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
801050b8:	53                   	push   %ebx
801050b9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801050bc:	50                   	push   %eax
801050bd:	6a 00                	push   $0x0
801050bf:	e8 2c fb ff ff       	call   80104bf0 <argstr>
801050c4:	83 c4 10             	add    $0x10,%esp
801050c7:	85 c0                	test   %eax,%eax
801050c9:	0f 88 fb 00 00 00    	js     801051ca <sys_link+0x11a>
801050cf:	83 ec 08             	sub    $0x8,%esp
801050d2:	8d 45 d0             	lea    -0x30(%ebp),%eax
801050d5:	50                   	push   %eax
801050d6:	6a 01                	push   $0x1
801050d8:	e8 13 fb ff ff       	call   80104bf0 <argstr>
801050dd:	83 c4 10             	add    $0x10,%esp
801050e0:	85 c0                	test   %eax,%eax
801050e2:	0f 88 e2 00 00 00    	js     801051ca <sys_link+0x11a>
  begin_op();
801050e8:	e8 33 de ff ff       	call   80102f20 <begin_op>
  if((ip = namei(old)) == 0){
801050ed:	83 ec 0c             	sub    $0xc,%esp
801050f0:	ff 75 d4             	push   -0x2c(%ebp)
801050f3:	e8 68 d1 ff ff       	call   80102260 <namei>
801050f8:	83 c4 10             	add    $0x10,%esp
801050fb:	89 c3                	mov    %eax,%ebx
801050fd:	85 c0                	test   %eax,%eax
801050ff:	0f 84 df 00 00 00    	je     801051e4 <sys_link+0x134>
  ilock(ip);
80105105:	83 ec 0c             	sub    $0xc,%esp
80105108:	50                   	push   %eax
80105109:	e8 72 c8 ff ff       	call   80101980 <ilock>
  if(ip->type == T_DIR){
8010510e:	83 c4 10             	add    $0x10,%esp
80105111:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105116:	0f 84 b5 00 00 00    	je     801051d1 <sys_link+0x121>
  iupdate(ip);
8010511c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
8010511f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105124:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105127:	53                   	push   %ebx
80105128:	e8 a3 c7 ff ff       	call   801018d0 <iupdate>
  iunlock(ip);
8010512d:	89 1c 24             	mov    %ebx,(%esp)
80105130:	e8 2b c9 ff ff       	call   80101a60 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105135:	58                   	pop    %eax
80105136:	5a                   	pop    %edx
80105137:	57                   	push   %edi
80105138:	ff 75 d0             	push   -0x30(%ebp)
8010513b:	e8 40 d1 ff ff       	call   80102280 <nameiparent>
80105140:	83 c4 10             	add    $0x10,%esp
80105143:	89 c6                	mov    %eax,%esi
80105145:	85 c0                	test   %eax,%eax
80105147:	74 5b                	je     801051a4 <sys_link+0xf4>
  ilock(dp);
80105149:	83 ec 0c             	sub    $0xc,%esp
8010514c:	50                   	push   %eax
8010514d:	e8 2e c8 ff ff       	call   80101980 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105152:	8b 03                	mov    (%ebx),%eax
80105154:	83 c4 10             	add    $0x10,%esp
80105157:	39 06                	cmp    %eax,(%esi)
80105159:	75 3d                	jne    80105198 <sys_link+0xe8>
8010515b:	83 ec 04             	sub    $0x4,%esp
8010515e:	ff 73 04             	push   0x4(%ebx)
80105161:	57                   	push   %edi
80105162:	56                   	push   %esi
80105163:	e8 38 d0 ff ff       	call   801021a0 <dirlink>
80105168:	83 c4 10             	add    $0x10,%esp
8010516b:	85 c0                	test   %eax,%eax
8010516d:	78 29                	js     80105198 <sys_link+0xe8>
  iunlockput(dp);
8010516f:	83 ec 0c             	sub    $0xc,%esp
80105172:	56                   	push   %esi
80105173:	e8 98 ca ff ff       	call   80101c10 <iunlockput>
  iput(ip);
80105178:	89 1c 24             	mov    %ebx,(%esp)
8010517b:	e8 30 c9 ff ff       	call   80101ab0 <iput>
  end_op();
80105180:	e8 0b de ff ff       	call   80102f90 <end_op>
  return 0;
80105185:	83 c4 10             	add    $0x10,%esp
80105188:	31 c0                	xor    %eax,%eax
}
8010518a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010518d:	5b                   	pop    %ebx
8010518e:	5e                   	pop    %esi
8010518f:	5f                   	pop    %edi
80105190:	5d                   	pop    %ebp
80105191:	c3                   	ret
80105192:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105198:	83 ec 0c             	sub    $0xc,%esp
8010519b:	56                   	push   %esi
8010519c:	e8 6f ca ff ff       	call   80101c10 <iunlockput>
    goto bad;
801051a1:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
801051a4:	83 ec 0c             	sub    $0xc,%esp
801051a7:	53                   	push   %ebx
801051a8:	e8 d3 c7 ff ff       	call   80101980 <ilock>
  ip->nlink--;
801051ad:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801051b2:	89 1c 24             	mov    %ebx,(%esp)
801051b5:	e8 16 c7 ff ff       	call   801018d0 <iupdate>
  iunlockput(ip);
801051ba:	89 1c 24             	mov    %ebx,(%esp)
801051bd:	e8 4e ca ff ff       	call   80101c10 <iunlockput>
  end_op();
801051c2:	e8 c9 dd ff ff       	call   80102f90 <end_op>
  return -1;
801051c7:	83 c4 10             	add    $0x10,%esp
    return -1;
801051ca:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051cf:	eb b9                	jmp    8010518a <sys_link+0xda>
    iunlockput(ip);
801051d1:	83 ec 0c             	sub    $0xc,%esp
801051d4:	53                   	push   %ebx
801051d5:	e8 36 ca ff ff       	call   80101c10 <iunlockput>
    end_op();
801051da:	e8 b1 dd ff ff       	call   80102f90 <end_op>
    return -1;
801051df:	83 c4 10             	add    $0x10,%esp
801051e2:	eb e6                	jmp    801051ca <sys_link+0x11a>
    end_op();
801051e4:	e8 a7 dd ff ff       	call   80102f90 <end_op>
    return -1;
801051e9:	eb df                	jmp    801051ca <sys_link+0x11a>
801051eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801051f0 <sys_unlink>:
{
801051f0:	55                   	push   %ebp
801051f1:	89 e5                	mov    %esp,%ebp
801051f3:	57                   	push   %edi
801051f4:	56                   	push   %esi
  if(argstr(0, &path) < 0)
801051f5:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801051f8:	53                   	push   %ebx
801051f9:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
801051fc:	50                   	push   %eax
801051fd:	6a 00                	push   $0x0
801051ff:	e8 ec f9 ff ff       	call   80104bf0 <argstr>
80105204:	83 c4 10             	add    $0x10,%esp
80105207:	85 c0                	test   %eax,%eax
80105209:	0f 88 54 01 00 00    	js     80105363 <sys_unlink+0x173>
  begin_op();
8010520f:	e8 0c dd ff ff       	call   80102f20 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105214:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105217:	83 ec 08             	sub    $0x8,%esp
8010521a:	53                   	push   %ebx
8010521b:	ff 75 c0             	push   -0x40(%ebp)
8010521e:	e8 5d d0 ff ff       	call   80102280 <nameiparent>
80105223:	83 c4 10             	add    $0x10,%esp
80105226:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105229:	85 c0                	test   %eax,%eax
8010522b:	0f 84 58 01 00 00    	je     80105389 <sys_unlink+0x199>
  ilock(dp);
80105231:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105234:	83 ec 0c             	sub    $0xc,%esp
80105237:	57                   	push   %edi
80105238:	e8 43 c7 ff ff       	call   80101980 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010523d:	58                   	pop    %eax
8010523e:	5a                   	pop    %edx
8010523f:	68 e9 76 10 80       	push   $0x801076e9
80105244:	53                   	push   %ebx
80105245:	e8 66 cc ff ff       	call   80101eb0 <namecmp>
8010524a:	83 c4 10             	add    $0x10,%esp
8010524d:	85 c0                	test   %eax,%eax
8010524f:	0f 84 fb 00 00 00    	je     80105350 <sys_unlink+0x160>
80105255:	83 ec 08             	sub    $0x8,%esp
80105258:	68 e8 76 10 80       	push   $0x801076e8
8010525d:	53                   	push   %ebx
8010525e:	e8 4d cc ff ff       	call   80101eb0 <namecmp>
80105263:	83 c4 10             	add    $0x10,%esp
80105266:	85 c0                	test   %eax,%eax
80105268:	0f 84 e2 00 00 00    	je     80105350 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010526e:	83 ec 04             	sub    $0x4,%esp
80105271:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105274:	50                   	push   %eax
80105275:	53                   	push   %ebx
80105276:	57                   	push   %edi
80105277:	e8 54 cc ff ff       	call   80101ed0 <dirlookup>
8010527c:	83 c4 10             	add    $0x10,%esp
8010527f:	89 c3                	mov    %eax,%ebx
80105281:	85 c0                	test   %eax,%eax
80105283:	0f 84 c7 00 00 00    	je     80105350 <sys_unlink+0x160>
  ilock(ip);
80105289:	83 ec 0c             	sub    $0xc,%esp
8010528c:	50                   	push   %eax
8010528d:	e8 ee c6 ff ff       	call   80101980 <ilock>
  if(ip->nlink < 1)
80105292:	83 c4 10             	add    $0x10,%esp
80105295:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010529a:	0f 8e 0a 01 00 00    	jle    801053aa <sys_unlink+0x1ba>
  if(ip->type == T_DIR && !isdirempty(ip)){
801052a0:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801052a5:	8d 7d d8             	lea    -0x28(%ebp),%edi
801052a8:	74 66                	je     80105310 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
801052aa:	83 ec 04             	sub    $0x4,%esp
801052ad:	6a 10                	push   $0x10
801052af:	6a 00                	push   $0x0
801052b1:	57                   	push   %edi
801052b2:	e8 c9 f5 ff ff       	call   80104880 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801052b7:	6a 10                	push   $0x10
801052b9:	ff 75 c4             	push   -0x3c(%ebp)
801052bc:	57                   	push   %edi
801052bd:	ff 75 b4             	push   -0x4c(%ebp)
801052c0:	e8 cb ca ff ff       	call   80101d90 <writei>
801052c5:	83 c4 20             	add    $0x20,%esp
801052c8:	83 f8 10             	cmp    $0x10,%eax
801052cb:	0f 85 cc 00 00 00    	jne    8010539d <sys_unlink+0x1ad>
  if(ip->type == T_DIR){
801052d1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801052d6:	0f 84 94 00 00 00    	je     80105370 <sys_unlink+0x180>
  iunlockput(dp);
801052dc:	83 ec 0c             	sub    $0xc,%esp
801052df:	ff 75 b4             	push   -0x4c(%ebp)
801052e2:	e8 29 c9 ff ff       	call   80101c10 <iunlockput>
  ip->nlink--;
801052e7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801052ec:	89 1c 24             	mov    %ebx,(%esp)
801052ef:	e8 dc c5 ff ff       	call   801018d0 <iupdate>
  iunlockput(ip);
801052f4:	89 1c 24             	mov    %ebx,(%esp)
801052f7:	e8 14 c9 ff ff       	call   80101c10 <iunlockput>
  end_op();
801052fc:	e8 8f dc ff ff       	call   80102f90 <end_op>
  return 0;
80105301:	83 c4 10             	add    $0x10,%esp
80105304:	31 c0                	xor    %eax,%eax
}
80105306:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105309:	5b                   	pop    %ebx
8010530a:	5e                   	pop    %esi
8010530b:	5f                   	pop    %edi
8010530c:	5d                   	pop    %ebp
8010530d:	c3                   	ret
8010530e:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105310:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105314:	76 94                	jbe    801052aa <sys_unlink+0xba>
80105316:	be 20 00 00 00       	mov    $0x20,%esi
8010531b:	eb 0b                	jmp    80105328 <sys_unlink+0x138>
8010531d:	8d 76 00             	lea    0x0(%esi),%esi
80105320:	83 c6 10             	add    $0x10,%esi
80105323:	3b 73 58             	cmp    0x58(%ebx),%esi
80105326:	73 82                	jae    801052aa <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105328:	6a 10                	push   $0x10
8010532a:	56                   	push   %esi
8010532b:	57                   	push   %edi
8010532c:	53                   	push   %ebx
8010532d:	e8 5e c9 ff ff       	call   80101c90 <readi>
80105332:	83 c4 10             	add    $0x10,%esp
80105335:	83 f8 10             	cmp    $0x10,%eax
80105338:	75 56                	jne    80105390 <sys_unlink+0x1a0>
    if(de.inum != 0)
8010533a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010533f:	74 df                	je     80105320 <sys_unlink+0x130>
    iunlockput(ip);
80105341:	83 ec 0c             	sub    $0xc,%esp
80105344:	53                   	push   %ebx
80105345:	e8 c6 c8 ff ff       	call   80101c10 <iunlockput>
    goto bad;
8010534a:	83 c4 10             	add    $0x10,%esp
8010534d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105350:	83 ec 0c             	sub    $0xc,%esp
80105353:	ff 75 b4             	push   -0x4c(%ebp)
80105356:	e8 b5 c8 ff ff       	call   80101c10 <iunlockput>
  end_op();
8010535b:	e8 30 dc ff ff       	call   80102f90 <end_op>
  return -1;
80105360:	83 c4 10             	add    $0x10,%esp
    return -1;
80105363:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105368:	eb 9c                	jmp    80105306 <sys_unlink+0x116>
8010536a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105370:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105373:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105376:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
8010537b:	50                   	push   %eax
8010537c:	e8 4f c5 ff ff       	call   801018d0 <iupdate>
80105381:	83 c4 10             	add    $0x10,%esp
80105384:	e9 53 ff ff ff       	jmp    801052dc <sys_unlink+0xec>
    end_op();
80105389:	e8 02 dc ff ff       	call   80102f90 <end_op>
    return -1;
8010538e:	eb d3                	jmp    80105363 <sys_unlink+0x173>
      panic("isdirempty: readi");
80105390:	83 ec 0c             	sub    $0xc,%esp
80105393:	68 0d 77 10 80       	push   $0x8010770d
80105398:	e8 e3 af ff ff       	call   80100380 <panic>
    panic("unlink: writei");
8010539d:	83 ec 0c             	sub    $0xc,%esp
801053a0:	68 1f 77 10 80       	push   $0x8010771f
801053a5:	e8 d6 af ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
801053aa:	83 ec 0c             	sub    $0xc,%esp
801053ad:	68 fb 76 10 80       	push   $0x801076fb
801053b2:	e8 c9 af ff ff       	call   80100380 <panic>
801053b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801053be:	00 
801053bf:	90                   	nop

801053c0 <sys_open>:

int
sys_open(void)
{
801053c0:	55                   	push   %ebp
801053c1:	89 e5                	mov    %esp,%ebp
801053c3:	57                   	push   %edi
801053c4:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801053c5:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801053c8:	53                   	push   %ebx
801053c9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801053cc:	50                   	push   %eax
801053cd:	6a 00                	push   $0x0
801053cf:	e8 1c f8 ff ff       	call   80104bf0 <argstr>
801053d4:	83 c4 10             	add    $0x10,%esp
801053d7:	85 c0                	test   %eax,%eax
801053d9:	0f 88 8e 00 00 00    	js     8010546d <sys_open+0xad>
801053df:	83 ec 08             	sub    $0x8,%esp
801053e2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801053e5:	50                   	push   %eax
801053e6:	6a 01                	push   $0x1
801053e8:	e8 43 f7 ff ff       	call   80104b30 <argint>
801053ed:	83 c4 10             	add    $0x10,%esp
801053f0:	85 c0                	test   %eax,%eax
801053f2:	78 79                	js     8010546d <sys_open+0xad>
    return -1;

  begin_op();
801053f4:	e8 27 db ff ff       	call   80102f20 <begin_op>

  if(omode & O_CREATE){
801053f9:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801053fd:	75 79                	jne    80105478 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801053ff:	83 ec 0c             	sub    $0xc,%esp
80105402:	ff 75 e0             	push   -0x20(%ebp)
80105405:	e8 56 ce ff ff       	call   80102260 <namei>
8010540a:	83 c4 10             	add    $0x10,%esp
8010540d:	89 c6                	mov    %eax,%esi
8010540f:	85 c0                	test   %eax,%eax
80105411:	0f 84 7e 00 00 00    	je     80105495 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105417:	83 ec 0c             	sub    $0xc,%esp
8010541a:	50                   	push   %eax
8010541b:	e8 60 c5 ff ff       	call   80101980 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105420:	83 c4 10             	add    $0x10,%esp
80105423:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105428:	0f 84 ba 00 00 00    	je     801054e8 <sys_open+0x128>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010542e:	e8 ed bb ff ff       	call   80101020 <filealloc>
80105433:	89 c7                	mov    %eax,%edi
80105435:	85 c0                	test   %eax,%eax
80105437:	74 23                	je     8010545c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105439:	e8 02 e7 ff ff       	call   80103b40 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010543e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105440:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105444:	85 d2                	test   %edx,%edx
80105446:	74 58                	je     801054a0 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
80105448:	83 c3 01             	add    $0x1,%ebx
8010544b:	83 fb 10             	cmp    $0x10,%ebx
8010544e:	75 f0                	jne    80105440 <sys_open+0x80>
    if(f)
      fileclose(f);
80105450:	83 ec 0c             	sub    $0xc,%esp
80105453:	57                   	push   %edi
80105454:	e8 87 bc ff ff       	call   801010e0 <fileclose>
80105459:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010545c:	83 ec 0c             	sub    $0xc,%esp
8010545f:	56                   	push   %esi
80105460:	e8 ab c7 ff ff       	call   80101c10 <iunlockput>
    end_op();
80105465:	e8 26 db ff ff       	call   80102f90 <end_op>
    return -1;
8010546a:	83 c4 10             	add    $0x10,%esp
    return -1;
8010546d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105472:	eb 65                	jmp    801054d9 <sys_open+0x119>
80105474:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105478:	83 ec 0c             	sub    $0xc,%esp
8010547b:	31 c9                	xor    %ecx,%ecx
8010547d:	ba 02 00 00 00       	mov    $0x2,%edx
80105482:	6a 00                	push   $0x0
80105484:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105487:	e8 54 f8 ff ff       	call   80104ce0 <create>
    if(ip == 0){
8010548c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
8010548f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105491:	85 c0                	test   %eax,%eax
80105493:	75 99                	jne    8010542e <sys_open+0x6e>
      end_op();
80105495:	e8 f6 da ff ff       	call   80102f90 <end_op>
      return -1;
8010549a:	eb d1                	jmp    8010546d <sys_open+0xad>
8010549c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
801054a0:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
801054a3:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
801054a7:	56                   	push   %esi
801054a8:	e8 b3 c5 ff ff       	call   80101a60 <iunlock>
  end_op();
801054ad:	e8 de da ff ff       	call   80102f90 <end_op>

  f->type = FD_INODE;
801054b2:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801054b8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801054bb:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801054be:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
801054c1:	89 d0                	mov    %edx,%eax
  f->off = 0;
801054c3:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801054ca:	f7 d0                	not    %eax
801054cc:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801054cf:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801054d2:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801054d5:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801054d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801054dc:	89 d8                	mov    %ebx,%eax
801054de:	5b                   	pop    %ebx
801054df:	5e                   	pop    %esi
801054e0:	5f                   	pop    %edi
801054e1:	5d                   	pop    %ebp
801054e2:	c3                   	ret
801054e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
801054e8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801054eb:	85 c9                	test   %ecx,%ecx
801054ed:	0f 84 3b ff ff ff    	je     8010542e <sys_open+0x6e>
801054f3:	e9 64 ff ff ff       	jmp    8010545c <sys_open+0x9c>
801054f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801054ff:	00 

80105500 <sys_mkdir>:

int
sys_mkdir(void)
{
80105500:	55                   	push   %ebp
80105501:	89 e5                	mov    %esp,%ebp
80105503:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80105506:	e8 15 da ff ff       	call   80102f20 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010550b:	83 ec 08             	sub    $0x8,%esp
8010550e:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105511:	50                   	push   %eax
80105512:	6a 00                	push   $0x0
80105514:	e8 d7 f6 ff ff       	call   80104bf0 <argstr>
80105519:	83 c4 10             	add    $0x10,%esp
8010551c:	85 c0                	test   %eax,%eax
8010551e:	78 30                	js     80105550 <sys_mkdir+0x50>
80105520:	83 ec 0c             	sub    $0xc,%esp
80105523:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105526:	31 c9                	xor    %ecx,%ecx
80105528:	ba 01 00 00 00       	mov    $0x1,%edx
8010552d:	6a 00                	push   $0x0
8010552f:	e8 ac f7 ff ff       	call   80104ce0 <create>
80105534:	83 c4 10             	add    $0x10,%esp
80105537:	85 c0                	test   %eax,%eax
80105539:	74 15                	je     80105550 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010553b:	83 ec 0c             	sub    $0xc,%esp
8010553e:	50                   	push   %eax
8010553f:	e8 cc c6 ff ff       	call   80101c10 <iunlockput>
  end_op();
80105544:	e8 47 da ff ff       	call   80102f90 <end_op>
  return 0;
80105549:	83 c4 10             	add    $0x10,%esp
8010554c:	31 c0                	xor    %eax,%eax
}
8010554e:	c9                   	leave
8010554f:	c3                   	ret
    end_op();
80105550:	e8 3b da ff ff       	call   80102f90 <end_op>
    return -1;
80105555:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010555a:	c9                   	leave
8010555b:	c3                   	ret
8010555c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105560 <sys_mknod>:

int
sys_mknod(void)
{
80105560:	55                   	push   %ebp
80105561:	89 e5                	mov    %esp,%ebp
80105563:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105566:	e8 b5 d9 ff ff       	call   80102f20 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010556b:	83 ec 08             	sub    $0x8,%esp
8010556e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105571:	50                   	push   %eax
80105572:	6a 00                	push   $0x0
80105574:	e8 77 f6 ff ff       	call   80104bf0 <argstr>
80105579:	83 c4 10             	add    $0x10,%esp
8010557c:	85 c0                	test   %eax,%eax
8010557e:	78 60                	js     801055e0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105580:	83 ec 08             	sub    $0x8,%esp
80105583:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105586:	50                   	push   %eax
80105587:	6a 01                	push   $0x1
80105589:	e8 a2 f5 ff ff       	call   80104b30 <argint>
  if((argstr(0, &path)) < 0 ||
8010558e:	83 c4 10             	add    $0x10,%esp
80105591:	85 c0                	test   %eax,%eax
80105593:	78 4b                	js     801055e0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105595:	83 ec 08             	sub    $0x8,%esp
80105598:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010559b:	50                   	push   %eax
8010559c:	6a 02                	push   $0x2
8010559e:	e8 8d f5 ff ff       	call   80104b30 <argint>
     argint(1, &major) < 0 ||
801055a3:	83 c4 10             	add    $0x10,%esp
801055a6:	85 c0                	test   %eax,%eax
801055a8:	78 36                	js     801055e0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
801055aa:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
801055ae:	83 ec 0c             	sub    $0xc,%esp
801055b1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801055b5:	ba 03 00 00 00       	mov    $0x3,%edx
801055ba:	50                   	push   %eax
801055bb:	8b 45 ec             	mov    -0x14(%ebp),%eax
801055be:	e8 1d f7 ff ff       	call   80104ce0 <create>
     argint(2, &minor) < 0 ||
801055c3:	83 c4 10             	add    $0x10,%esp
801055c6:	85 c0                	test   %eax,%eax
801055c8:	74 16                	je     801055e0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801055ca:	83 ec 0c             	sub    $0xc,%esp
801055cd:	50                   	push   %eax
801055ce:	e8 3d c6 ff ff       	call   80101c10 <iunlockput>
  end_op();
801055d3:	e8 b8 d9 ff ff       	call   80102f90 <end_op>
  return 0;
801055d8:	83 c4 10             	add    $0x10,%esp
801055db:	31 c0                	xor    %eax,%eax
}
801055dd:	c9                   	leave
801055de:	c3                   	ret
801055df:	90                   	nop
    end_op();
801055e0:	e8 ab d9 ff ff       	call   80102f90 <end_op>
    return -1;
801055e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055ea:	c9                   	leave
801055eb:	c3                   	ret
801055ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801055f0 <sys_chdir>:

int
sys_chdir(void)
{
801055f0:	55                   	push   %ebp
801055f1:	89 e5                	mov    %esp,%ebp
801055f3:	56                   	push   %esi
801055f4:	53                   	push   %ebx
801055f5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801055f8:	e8 43 e5 ff ff       	call   80103b40 <myproc>
801055fd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801055ff:	e8 1c d9 ff ff       	call   80102f20 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80105604:	83 ec 08             	sub    $0x8,%esp
80105607:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010560a:	50                   	push   %eax
8010560b:	6a 00                	push   $0x0
8010560d:	e8 de f5 ff ff       	call   80104bf0 <argstr>
80105612:	83 c4 10             	add    $0x10,%esp
80105615:	85 c0                	test   %eax,%eax
80105617:	78 77                	js     80105690 <sys_chdir+0xa0>
80105619:	83 ec 0c             	sub    $0xc,%esp
8010561c:	ff 75 f4             	push   -0xc(%ebp)
8010561f:	e8 3c cc ff ff       	call   80102260 <namei>
80105624:	83 c4 10             	add    $0x10,%esp
80105627:	89 c3                	mov    %eax,%ebx
80105629:	85 c0                	test   %eax,%eax
8010562b:	74 63                	je     80105690 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010562d:	83 ec 0c             	sub    $0xc,%esp
80105630:	50                   	push   %eax
80105631:	e8 4a c3 ff ff       	call   80101980 <ilock>
  if(ip->type != T_DIR){
80105636:	83 c4 10             	add    $0x10,%esp
80105639:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010563e:	75 30                	jne    80105670 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105640:	83 ec 0c             	sub    $0xc,%esp
80105643:	53                   	push   %ebx
80105644:	e8 17 c4 ff ff       	call   80101a60 <iunlock>
  iput(curproc->cwd);
80105649:	58                   	pop    %eax
8010564a:	ff 76 68             	push   0x68(%esi)
8010564d:	e8 5e c4 ff ff       	call   80101ab0 <iput>
  end_op();
80105652:	e8 39 d9 ff ff       	call   80102f90 <end_op>
  curproc->cwd = ip;
80105657:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010565a:	83 c4 10             	add    $0x10,%esp
8010565d:	31 c0                	xor    %eax,%eax
}
8010565f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105662:	5b                   	pop    %ebx
80105663:	5e                   	pop    %esi
80105664:	5d                   	pop    %ebp
80105665:	c3                   	ret
80105666:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010566d:	00 
8010566e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105670:	83 ec 0c             	sub    $0xc,%esp
80105673:	53                   	push   %ebx
80105674:	e8 97 c5 ff ff       	call   80101c10 <iunlockput>
    end_op();
80105679:	e8 12 d9 ff ff       	call   80102f90 <end_op>
    return -1;
8010567e:	83 c4 10             	add    $0x10,%esp
    return -1;
80105681:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105686:	eb d7                	jmp    8010565f <sys_chdir+0x6f>
80105688:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010568f:	00 
    end_op();
80105690:	e8 fb d8 ff ff       	call   80102f90 <end_op>
    return -1;
80105695:	eb ea                	jmp    80105681 <sys_chdir+0x91>
80105697:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010569e:	00 
8010569f:	90                   	nop

801056a0 <sys_exec>:

int
sys_exec(void)
{
801056a0:	55                   	push   %ebp
801056a1:	89 e5                	mov    %esp,%ebp
801056a3:	57                   	push   %edi
801056a4:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801056a5:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
801056ab:	53                   	push   %ebx
801056ac:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801056b2:	50                   	push   %eax
801056b3:	6a 00                	push   $0x0
801056b5:	e8 36 f5 ff ff       	call   80104bf0 <argstr>
801056ba:	83 c4 10             	add    $0x10,%esp
801056bd:	85 c0                	test   %eax,%eax
801056bf:	0f 88 87 00 00 00    	js     8010574c <sys_exec+0xac>
801056c5:	83 ec 08             	sub    $0x8,%esp
801056c8:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801056ce:	50                   	push   %eax
801056cf:	6a 01                	push   $0x1
801056d1:	e8 5a f4 ff ff       	call   80104b30 <argint>
801056d6:	83 c4 10             	add    $0x10,%esp
801056d9:	85 c0                	test   %eax,%eax
801056db:	78 6f                	js     8010574c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801056dd:	83 ec 04             	sub    $0x4,%esp
801056e0:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
801056e6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801056e8:	68 80 00 00 00       	push   $0x80
801056ed:	6a 00                	push   $0x0
801056ef:	56                   	push   %esi
801056f0:	e8 8b f1 ff ff       	call   80104880 <memset>
801056f5:	83 c4 10             	add    $0x10,%esp
801056f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801056ff:	00 
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
80105700:	83 ec 08             	sub    $0x8,%esp
80105703:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105709:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80105710:	50                   	push   %eax
80105711:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105717:	01 f8                	add    %edi,%eax
80105719:	50                   	push   %eax
8010571a:	e8 81 f3 ff ff       	call   80104aa0 <fetchint>
8010571f:	83 c4 10             	add    $0x10,%esp
80105722:	85 c0                	test   %eax,%eax
80105724:	78 26                	js     8010574c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80105726:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010572c:	85 c0                	test   %eax,%eax
8010572e:	74 30                	je     80105760 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105730:	83 ec 08             	sub    $0x8,%esp
80105733:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80105736:	52                   	push   %edx
80105737:	50                   	push   %eax
80105738:	e8 a3 f3 ff ff       	call   80104ae0 <fetchstr>
8010573d:	83 c4 10             	add    $0x10,%esp
80105740:	85 c0                	test   %eax,%eax
80105742:	78 08                	js     8010574c <sys_exec+0xac>
  for(i=0;; i++){
80105744:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105747:	83 fb 20             	cmp    $0x20,%ebx
8010574a:	75 b4                	jne    80105700 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010574c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010574f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105754:	5b                   	pop    %ebx
80105755:	5e                   	pop    %esi
80105756:	5f                   	pop    %edi
80105757:	5d                   	pop    %ebp
80105758:	c3                   	ret
80105759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80105760:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105767:	00 00 00 00 
  return exec(path, argv);
8010576b:	83 ec 08             	sub    $0x8,%esp
8010576e:	56                   	push   %esi
8010576f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80105775:	e8 06 b5 ff ff       	call   80100c80 <exec>
8010577a:	83 c4 10             	add    $0x10,%esp
}
8010577d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105780:	5b                   	pop    %ebx
80105781:	5e                   	pop    %esi
80105782:	5f                   	pop    %edi
80105783:	5d                   	pop    %ebp
80105784:	c3                   	ret
80105785:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010578c:	00 
8010578d:	8d 76 00             	lea    0x0(%esi),%esi

80105790 <sys_pipe>:

int
sys_pipe(void)
{
80105790:	55                   	push   %ebp
80105791:	89 e5                	mov    %esp,%ebp
80105793:	57                   	push   %edi
80105794:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105795:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105798:	53                   	push   %ebx
80105799:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010579c:	6a 08                	push   $0x8
8010579e:	50                   	push   %eax
8010579f:	6a 00                	push   $0x0
801057a1:	e8 da f3 ff ff       	call   80104b80 <argptr>
801057a6:	83 c4 10             	add    $0x10,%esp
801057a9:	85 c0                	test   %eax,%eax
801057ab:	0f 88 8b 00 00 00    	js     8010583c <sys_pipe+0xac>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801057b1:	83 ec 08             	sub    $0x8,%esp
801057b4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801057b7:	50                   	push   %eax
801057b8:	8d 45 e0             	lea    -0x20(%ebp),%eax
801057bb:	50                   	push   %eax
801057bc:	e8 2f de ff ff       	call   801035f0 <pipealloc>
801057c1:	83 c4 10             	add    $0x10,%esp
801057c4:	85 c0                	test   %eax,%eax
801057c6:	78 74                	js     8010583c <sys_pipe+0xac>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801057c8:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801057cb:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801057cd:	e8 6e e3 ff ff       	call   80103b40 <myproc>
    if(curproc->ofile[fd] == 0){
801057d2:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801057d6:	85 f6                	test   %esi,%esi
801057d8:	74 16                	je     801057f0 <sys_pipe+0x60>
801057da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
801057e0:	83 c3 01             	add    $0x1,%ebx
801057e3:	83 fb 10             	cmp    $0x10,%ebx
801057e6:	74 3d                	je     80105825 <sys_pipe+0x95>
    if(curproc->ofile[fd] == 0){
801057e8:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801057ec:	85 f6                	test   %esi,%esi
801057ee:	75 f0                	jne    801057e0 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
801057f0:	8d 73 08             	lea    0x8(%ebx),%esi
801057f3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801057f7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801057fa:	e8 41 e3 ff ff       	call   80103b40 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801057ff:	31 d2                	xor    %edx,%edx
80105801:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
80105808:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
8010580c:	85 c9                	test   %ecx,%ecx
8010580e:	74 38                	je     80105848 <sys_pipe+0xb8>
  for(fd = 0; fd < NOFILE; fd++){
80105810:	83 c2 01             	add    $0x1,%edx
80105813:	83 fa 10             	cmp    $0x10,%edx
80105816:	75 f0                	jne    80105808 <sys_pipe+0x78>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105818:	e8 23 e3 ff ff       	call   80103b40 <myproc>
8010581d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105824:	00 
    fileclose(rf);
80105825:	83 ec 0c             	sub    $0xc,%esp
80105828:	ff 75 e0             	push   -0x20(%ebp)
8010582b:	e8 b0 b8 ff ff       	call   801010e0 <fileclose>
    fileclose(wf);
80105830:	58                   	pop    %eax
80105831:	ff 75 e4             	push   -0x1c(%ebp)
80105834:	e8 a7 b8 ff ff       	call   801010e0 <fileclose>
    return -1;
80105839:	83 c4 10             	add    $0x10,%esp
    return -1;
8010583c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105841:	eb 16                	jmp    80105859 <sys_pipe+0xc9>
80105843:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80105848:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
8010584c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010584f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105851:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105854:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105857:	31 c0                	xor    %eax,%eax
}
80105859:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010585c:	5b                   	pop    %ebx
8010585d:	5e                   	pop    %esi
8010585e:	5f                   	pop    %edi
8010585f:	5d                   	pop    %ebp
80105860:	c3                   	ret
80105861:	66 90                	xchg   %ax,%ax
80105863:	66 90                	xchg   %ax,%ax
80105865:	66 90                	xchg   %ax,%ax
80105867:	66 90                	xchg   %ax,%ax
80105869:	66 90                	xchg   %ax,%ax
8010586b:	66 90                	xchg   %ax,%ax
8010586d:	66 90                	xchg   %ax,%ax
8010586f:	90                   	nop

80105870 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105870:	e9 6b e4 ff ff       	jmp    80103ce0 <fork>
80105875:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010587c:	00 
8010587d:	8d 76 00             	lea    0x0(%esi),%esi

80105880 <sys_exit>:
}

int
sys_exit(void)
{
80105880:	55                   	push   %ebp
80105881:	89 e5                	mov    %esp,%ebp
80105883:	83 ec 08             	sub    $0x8,%esp
  exit();
80105886:	e8 c5 e6 ff ff       	call   80103f50 <exit>
  return 0;  // not reached
}
8010588b:	31 c0                	xor    %eax,%eax
8010588d:	c9                   	leave
8010588e:	c3                   	ret
8010588f:	90                   	nop

80105890 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105890:	e9 eb e7 ff ff       	jmp    80104080 <wait>
80105895:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010589c:	00 
8010589d:	8d 76 00             	lea    0x0(%esi),%esi

801058a0 <sys_kill>:
}

int
sys_kill(void)
{
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
801058a3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
801058a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801058a9:	50                   	push   %eax
801058aa:	6a 00                	push   $0x0
801058ac:	e8 7f f2 ff ff       	call   80104b30 <argint>
801058b1:	83 c4 10             	add    $0x10,%esp
801058b4:	85 c0                	test   %eax,%eax
801058b6:	78 18                	js     801058d0 <sys_kill+0x30>
    return -1;
  return kill(pid);
801058b8:	83 ec 0c             	sub    $0xc,%esp
801058bb:	ff 75 f4             	push   -0xc(%ebp)
801058be:	e8 5d ea ff ff       	call   80104320 <kill>
801058c3:	83 c4 10             	add    $0x10,%esp
}
801058c6:	c9                   	leave
801058c7:	c3                   	ret
801058c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801058cf:	00 
801058d0:	c9                   	leave
    return -1;
801058d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058d6:	c3                   	ret
801058d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801058de:	00 
801058df:	90                   	nop

801058e0 <sys_getpid>:

int
sys_getpid(void)
{
801058e0:	55                   	push   %ebp
801058e1:	89 e5                	mov    %esp,%ebp
801058e3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801058e6:	e8 55 e2 ff ff       	call   80103b40 <myproc>
801058eb:	8b 40 10             	mov    0x10(%eax),%eax
}
801058ee:	c9                   	leave
801058ef:	c3                   	ret

801058f0 <sys_sbrk>:

int
sys_sbrk(void)
{
801058f0:	55                   	push   %ebp
801058f1:	89 e5                	mov    %esp,%ebp
801058f3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801058f4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801058f7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801058fa:	50                   	push   %eax
801058fb:	6a 00                	push   $0x0
801058fd:	e8 2e f2 ff ff       	call   80104b30 <argint>
80105902:	83 c4 10             	add    $0x10,%esp
80105905:	85 c0                	test   %eax,%eax
80105907:	78 27                	js     80105930 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105909:	e8 32 e2 ff ff       	call   80103b40 <myproc>
  if(growproc(n) < 0)
8010590e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105911:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105913:	ff 75 f4             	push   -0xc(%ebp)
80105916:	e8 45 e3 ff ff       	call   80103c60 <growproc>
8010591b:	83 c4 10             	add    $0x10,%esp
8010591e:	85 c0                	test   %eax,%eax
80105920:	78 0e                	js     80105930 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105922:	89 d8                	mov    %ebx,%eax
80105924:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105927:	c9                   	leave
80105928:	c3                   	ret
80105929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105930:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105935:	eb eb                	jmp    80105922 <sys_sbrk+0x32>
80105937:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010593e:	00 
8010593f:	90                   	nop

80105940 <sys_sleep>:

int
sys_sleep(void)
{
80105940:	55                   	push   %ebp
80105941:	89 e5                	mov    %esp,%ebp
80105943:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105944:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105947:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010594a:	50                   	push   %eax
8010594b:	6a 00                	push   $0x0
8010594d:	e8 de f1 ff ff       	call   80104b30 <argint>
80105952:	83 c4 10             	add    $0x10,%esp
80105955:	85 c0                	test   %eax,%eax
80105957:	78 64                	js     801059bd <sys_sleep+0x7d>
    return -1;
  acquire(&tickslock);
80105959:	83 ec 0c             	sub    $0xc,%esp
8010595c:	68 80 3c 11 80       	push   $0x80113c80
80105961:	e8 1a ee ff ff       	call   80104780 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105966:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80105969:	8b 1d 60 3c 11 80    	mov    0x80113c60,%ebx
  while(ticks - ticks0 < n){
8010596f:	83 c4 10             	add    $0x10,%esp
80105972:	85 d2                	test   %edx,%edx
80105974:	75 2b                	jne    801059a1 <sys_sleep+0x61>
80105976:	eb 58                	jmp    801059d0 <sys_sleep+0x90>
80105978:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010597f:	00 
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105980:	83 ec 08             	sub    $0x8,%esp
80105983:	68 80 3c 11 80       	push   $0x80113c80
80105988:	68 60 3c 11 80       	push   $0x80113c60
8010598d:	e8 6e e8 ff ff       	call   80104200 <sleep>
  while(ticks - ticks0 < n){
80105992:	a1 60 3c 11 80       	mov    0x80113c60,%eax
80105997:	83 c4 10             	add    $0x10,%esp
8010599a:	29 d8                	sub    %ebx,%eax
8010599c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010599f:	73 2f                	jae    801059d0 <sys_sleep+0x90>
    if(myproc()->killed){
801059a1:	e8 9a e1 ff ff       	call   80103b40 <myproc>
801059a6:	8b 40 24             	mov    0x24(%eax),%eax
801059a9:	85 c0                	test   %eax,%eax
801059ab:	74 d3                	je     80105980 <sys_sleep+0x40>
      release(&tickslock);
801059ad:	83 ec 0c             	sub    $0xc,%esp
801059b0:	68 80 3c 11 80       	push   $0x80113c80
801059b5:	e8 66 ed ff ff       	call   80104720 <release>
      return -1;
801059ba:	83 c4 10             	add    $0x10,%esp
  }
  release(&tickslock);
  return 0;
}
801059bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
801059c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801059c5:	c9                   	leave
801059c6:	c3                   	ret
801059c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801059ce:	00 
801059cf:	90                   	nop
  release(&tickslock);
801059d0:	83 ec 0c             	sub    $0xc,%esp
801059d3:	68 80 3c 11 80       	push   $0x80113c80
801059d8:	e8 43 ed ff ff       	call   80104720 <release>
}
801059dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return 0;
801059e0:	83 c4 10             	add    $0x10,%esp
801059e3:	31 c0                	xor    %eax,%eax
}
801059e5:	c9                   	leave
801059e6:	c3                   	ret
801059e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801059ee:	00 
801059ef:	90                   	nop

801059f0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801059f0:	55                   	push   %ebp
801059f1:	89 e5                	mov    %esp,%ebp
801059f3:	53                   	push   %ebx
801059f4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801059f7:	68 80 3c 11 80       	push   $0x80113c80
801059fc:	e8 7f ed ff ff       	call   80104780 <acquire>
  xticks = ticks;
80105a01:	8b 1d 60 3c 11 80    	mov    0x80113c60,%ebx
  release(&tickslock);
80105a07:	c7 04 24 80 3c 11 80 	movl   $0x80113c80,(%esp)
80105a0e:	e8 0d ed ff ff       	call   80104720 <release>
  return xticks;
}
80105a13:	89 d8                	mov    %ebx,%eax
80105a15:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105a18:	c9                   	leave
80105a19:	c3                   	ret

80105a1a <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105a1a:	1e                   	push   %ds
  pushl %es
80105a1b:	06                   	push   %es
  pushl %fs
80105a1c:	0f a0                	push   %fs
  pushl %gs
80105a1e:	0f a8                	push   %gs
  pushal
80105a20:	60                   	pusha
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105a21:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105a25:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105a27:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105a29:	54                   	push   %esp
  call trap
80105a2a:	e8 c1 00 00 00       	call   80105af0 <trap>
  addl $4, %esp
80105a2f:	83 c4 04             	add    $0x4,%esp

80105a32 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105a32:	61                   	popa
  popl %gs
80105a33:	0f a9                	pop    %gs
  popl %fs
80105a35:	0f a1                	pop    %fs
  popl %es
80105a37:	07                   	pop    %es
  popl %ds
80105a38:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105a39:	83 c4 08             	add    $0x8,%esp
  iret
80105a3c:	cf                   	iret
80105a3d:	66 90                	xchg   %ax,%ax
80105a3f:	90                   	nop

80105a40 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105a40:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105a41:	31 c0                	xor    %eax,%eax
{
80105a43:	89 e5                	mov    %esp,%ebp
80105a45:	83 ec 08             	sub    $0x8,%esp
80105a48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a4f:	00 
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105a50:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105a57:	c7 04 c5 c2 3c 11 80 	movl   $0x8e000008,-0x7feec33e(,%eax,8)
80105a5e:	08 00 00 8e 
80105a62:	66 89 14 c5 c0 3c 11 	mov    %dx,-0x7feec340(,%eax,8)
80105a69:	80 
80105a6a:	c1 ea 10             	shr    $0x10,%edx
80105a6d:	66 89 14 c5 c6 3c 11 	mov    %dx,-0x7feec33a(,%eax,8)
80105a74:	80 
  for(i = 0; i < 256; i++)
80105a75:	83 c0 01             	add    $0x1,%eax
80105a78:	3d 00 01 00 00       	cmp    $0x100,%eax
80105a7d:	75 d1                	jne    80105a50 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80105a7f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a82:	a1 08 a1 10 80       	mov    0x8010a108,%eax
80105a87:	c7 05 c2 3e 11 80 08 	movl   $0xef000008,0x80113ec2
80105a8e:	00 00 ef 
  initlock(&tickslock, "time");
80105a91:	68 2e 77 10 80       	push   $0x8010772e
80105a96:	68 80 3c 11 80       	push   $0x80113c80
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105a9b:	66 a3 c0 3e 11 80    	mov    %ax,0x80113ec0
80105aa1:	c1 e8 10             	shr    $0x10,%eax
80105aa4:	66 a3 c6 3e 11 80    	mov    %ax,0x80113ec6
  initlock(&tickslock, "time");
80105aaa:	e8 e1 ea ff ff       	call   80104590 <initlock>
}
80105aaf:	83 c4 10             	add    $0x10,%esp
80105ab2:	c9                   	leave
80105ab3:	c3                   	ret
80105ab4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105abb:	00 
80105abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ac0 <idtinit>:

void
idtinit(void)
{
80105ac0:	55                   	push   %ebp
  pd[0] = size-1;
80105ac1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105ac6:	89 e5                	mov    %esp,%ebp
80105ac8:	83 ec 10             	sub    $0x10,%esp
80105acb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105acf:	b8 c0 3c 11 80       	mov    $0x80113cc0,%eax
80105ad4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105ad8:	c1 e8 10             	shr    $0x10,%eax
80105adb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105adf:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105ae2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105ae5:	c9                   	leave
80105ae6:	c3                   	ret
80105ae7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105aee:	00 
80105aef:	90                   	nop

80105af0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105af0:	55                   	push   %ebp
80105af1:	89 e5                	mov    %esp,%ebp
80105af3:	57                   	push   %edi
80105af4:	56                   	push   %esi
80105af5:	53                   	push   %ebx
80105af6:	83 ec 1c             	sub    $0x1c,%esp
80105af9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105afc:	8b 43 30             	mov    0x30(%ebx),%eax
80105aff:	83 f8 40             	cmp    $0x40,%eax
80105b02:	0f 84 58 01 00 00    	je     80105c60 <trap+0x170>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105b08:	83 e8 20             	sub    $0x20,%eax
80105b0b:	83 f8 1f             	cmp    $0x1f,%eax
80105b0e:	0f 87 7c 00 00 00    	ja     80105b90 <trap+0xa0>
80105b14:	ff 24 85 b8 7c 10 80 	jmp    *-0x7fef8348(,%eax,4)
80105b1b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105b20:	e8 eb c8 ff ff       	call   80102410 <ideintr>
    lapiceoi();
80105b25:	e8 a6 cf ff ff       	call   80102ad0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b2a:	e8 11 e0 ff ff       	call   80103b40 <myproc>
80105b2f:	85 c0                	test   %eax,%eax
80105b31:	74 1a                	je     80105b4d <trap+0x5d>
80105b33:	e8 08 e0 ff ff       	call   80103b40 <myproc>
80105b38:	8b 50 24             	mov    0x24(%eax),%edx
80105b3b:	85 d2                	test   %edx,%edx
80105b3d:	74 0e                	je     80105b4d <trap+0x5d>
80105b3f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105b43:	f7 d0                	not    %eax
80105b45:	a8 03                	test   $0x3,%al
80105b47:	0f 84 db 01 00 00    	je     80105d28 <trap+0x238>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105b4d:	e8 ee df ff ff       	call   80103b40 <myproc>
80105b52:	85 c0                	test   %eax,%eax
80105b54:	74 0f                	je     80105b65 <trap+0x75>
80105b56:	e8 e5 df ff ff       	call   80103b40 <myproc>
80105b5b:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105b5f:	0f 84 ab 00 00 00    	je     80105c10 <trap+0x120>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b65:	e8 d6 df ff ff       	call   80103b40 <myproc>
80105b6a:	85 c0                	test   %eax,%eax
80105b6c:	74 1a                	je     80105b88 <trap+0x98>
80105b6e:	e8 cd df ff ff       	call   80103b40 <myproc>
80105b73:	8b 40 24             	mov    0x24(%eax),%eax
80105b76:	85 c0                	test   %eax,%eax
80105b78:	74 0e                	je     80105b88 <trap+0x98>
80105b7a:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105b7e:	f7 d0                	not    %eax
80105b80:	a8 03                	test   $0x3,%al
80105b82:	0f 84 05 01 00 00    	je     80105c8d <trap+0x19d>
    exit();
}
80105b88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b8b:	5b                   	pop    %ebx
80105b8c:	5e                   	pop    %esi
80105b8d:	5f                   	pop    %edi
80105b8e:	5d                   	pop    %ebp
80105b8f:	c3                   	ret
    if(myproc() == 0 || (tf->cs&3) == 0){
80105b90:	e8 ab df ff ff       	call   80103b40 <myproc>
80105b95:	8b 7b 38             	mov    0x38(%ebx),%edi
80105b98:	85 c0                	test   %eax,%eax
80105b9a:	0f 84 a2 01 00 00    	je     80105d42 <trap+0x252>
80105ba0:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105ba4:	0f 84 98 01 00 00    	je     80105d42 <trap+0x252>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105baa:	0f 20 d1             	mov    %cr2,%ecx
80105bad:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105bb0:	e8 6b df ff ff       	call   80103b20 <cpuid>
80105bb5:	8b 73 30             	mov    0x30(%ebx),%esi
80105bb8:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105bbb:	8b 43 34             	mov    0x34(%ebx),%eax
80105bbe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80105bc1:	e8 7a df ff ff       	call   80103b40 <myproc>
80105bc6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105bc9:	e8 72 df ff ff       	call   80103b40 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105bce:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105bd1:	51                   	push   %ecx
80105bd2:	57                   	push   %edi
80105bd3:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105bd6:	52                   	push   %edx
80105bd7:	ff 75 e4             	push   -0x1c(%ebp)
80105bda:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105bdb:	8b 75 e0             	mov    -0x20(%ebp),%esi
80105bde:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105be1:	56                   	push   %esi
80105be2:	ff 70 10             	push   0x10(%eax)
80105be5:	68 b0 79 10 80       	push   $0x801079b0
80105bea:	e8 81 aa ff ff       	call   80100670 <cprintf>
    myproc()->killed = 1;
80105bef:	83 c4 20             	add    $0x20,%esp
80105bf2:	e8 49 df ff ff       	call   80103b40 <myproc>
80105bf7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105bfe:	e8 3d df ff ff       	call   80103b40 <myproc>
80105c03:	85 c0                	test   %eax,%eax
80105c05:	0f 85 28 ff ff ff    	jne    80105b33 <trap+0x43>
80105c0b:	e9 3d ff ff ff       	jmp    80105b4d <trap+0x5d>
  if(myproc() && myproc()->state == RUNNING &&
80105c10:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105c14:	0f 85 4b ff ff ff    	jne    80105b65 <trap+0x75>
    yield();
80105c1a:	e8 91 e5 ff ff       	call   801041b0 <yield>
80105c1f:	e9 41 ff ff ff       	jmp    80105b65 <trap+0x75>
80105c24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105c28:	8b 7b 38             	mov    0x38(%ebx),%edi
80105c2b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105c2f:	e8 ec de ff ff       	call   80103b20 <cpuid>
80105c34:	57                   	push   %edi
80105c35:	56                   	push   %esi
80105c36:	50                   	push   %eax
80105c37:	68 58 79 10 80       	push   $0x80107958
80105c3c:	e8 2f aa ff ff       	call   80100670 <cprintf>
    lapiceoi();
80105c41:	e8 8a ce ff ff       	call   80102ad0 <lapiceoi>
    break;
80105c46:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c49:	e8 f2 de ff ff       	call   80103b40 <myproc>
80105c4e:	85 c0                	test   %eax,%eax
80105c50:	0f 85 dd fe ff ff    	jne    80105b33 <trap+0x43>
80105c56:	e9 f2 fe ff ff       	jmp    80105b4d <trap+0x5d>
80105c5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80105c60:	e8 db de ff ff       	call   80103b40 <myproc>
80105c65:	8b 70 24             	mov    0x24(%eax),%esi
80105c68:	85 f6                	test   %esi,%esi
80105c6a:	0f 85 c8 00 00 00    	jne    80105d38 <trap+0x248>
    myproc()->tf = tf;
80105c70:	e8 cb de ff ff       	call   80103b40 <myproc>
80105c75:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105c78:	e8 f3 ef ff ff       	call   80104c70 <syscall>
    if(myproc()->killed)
80105c7d:	e8 be de ff ff       	call   80103b40 <myproc>
80105c82:	8b 48 24             	mov    0x24(%eax),%ecx
80105c85:	85 c9                	test   %ecx,%ecx
80105c87:	0f 84 fb fe ff ff    	je     80105b88 <trap+0x98>
}
80105c8d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c90:	5b                   	pop    %ebx
80105c91:	5e                   	pop    %esi
80105c92:	5f                   	pop    %edi
80105c93:	5d                   	pop    %ebp
      exit();
80105c94:	e9 b7 e2 ff ff       	jmp    80103f50 <exit>
80105c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105ca0:	e8 4b 02 00 00       	call   80105ef0 <uartintr>
    lapiceoi();
80105ca5:	e8 26 ce ff ff       	call   80102ad0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105caa:	e8 91 de ff ff       	call   80103b40 <myproc>
80105caf:	85 c0                	test   %eax,%eax
80105cb1:	0f 85 7c fe ff ff    	jne    80105b33 <trap+0x43>
80105cb7:	e9 91 fe ff ff       	jmp    80105b4d <trap+0x5d>
80105cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105cc0:	e8 db cc ff ff       	call   801029a0 <kbdintr>
    lapiceoi();
80105cc5:	e8 06 ce ff ff       	call   80102ad0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105cca:	e8 71 de ff ff       	call   80103b40 <myproc>
80105ccf:	85 c0                	test   %eax,%eax
80105cd1:	0f 85 5c fe ff ff    	jne    80105b33 <trap+0x43>
80105cd7:	e9 71 fe ff ff       	jmp    80105b4d <trap+0x5d>
80105cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80105ce0:	e8 3b de ff ff       	call   80103b20 <cpuid>
80105ce5:	85 c0                	test   %eax,%eax
80105ce7:	0f 85 38 fe ff ff    	jne    80105b25 <trap+0x35>
      acquire(&tickslock);
80105ced:	83 ec 0c             	sub    $0xc,%esp
80105cf0:	68 80 3c 11 80       	push   $0x80113c80
80105cf5:	e8 86 ea ff ff       	call   80104780 <acquire>
      ticks++;
80105cfa:	83 05 60 3c 11 80 01 	addl   $0x1,0x80113c60
      wakeup(&ticks);
80105d01:	c7 04 24 60 3c 11 80 	movl   $0x80113c60,(%esp)
80105d08:	e8 b3 e5 ff ff       	call   801042c0 <wakeup>
      release(&tickslock);
80105d0d:	c7 04 24 80 3c 11 80 	movl   $0x80113c80,(%esp)
80105d14:	e8 07 ea ff ff       	call   80104720 <release>
80105d19:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80105d1c:	e9 04 fe ff ff       	jmp    80105b25 <trap+0x35>
80105d21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80105d28:	e8 23 e2 ff ff       	call   80103f50 <exit>
80105d2d:	e9 1b fe ff ff       	jmp    80105b4d <trap+0x5d>
80105d32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105d38:	e8 13 e2 ff ff       	call   80103f50 <exit>
80105d3d:	e9 2e ff ff ff       	jmp    80105c70 <trap+0x180>
80105d42:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105d45:	e8 d6 dd ff ff       	call   80103b20 <cpuid>
80105d4a:	83 ec 0c             	sub    $0xc,%esp
80105d4d:	56                   	push   %esi
80105d4e:	57                   	push   %edi
80105d4f:	50                   	push   %eax
80105d50:	ff 73 30             	push   0x30(%ebx)
80105d53:	68 7c 79 10 80       	push   $0x8010797c
80105d58:	e8 13 a9 ff ff       	call   80100670 <cprintf>
      panic("trap");
80105d5d:	83 c4 14             	add    $0x14,%esp
80105d60:	68 33 77 10 80       	push   $0x80107733
80105d65:	e8 16 a6 ff ff       	call   80100380 <panic>
80105d6a:	66 90                	xchg   %ax,%ax
80105d6c:	66 90                	xchg   %ax,%ax
80105d6e:	66 90                	xchg   %ax,%ax

80105d70 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105d70:	a1 c0 44 11 80       	mov    0x801144c0,%eax
80105d75:	85 c0                	test   %eax,%eax
80105d77:	74 17                	je     80105d90 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d79:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d7e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105d7f:	a8 01                	test   $0x1,%al
80105d81:	74 0d                	je     80105d90 <uartgetc+0x20>
80105d83:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d88:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105d89:	0f b6 c0             	movzbl %al,%eax
80105d8c:	c3                   	ret
80105d8d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105d90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105d95:	c3                   	ret
80105d96:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d9d:	00 
80105d9e:	66 90                	xchg   %ax,%ax

80105da0 <uartinit>:
{
80105da0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105da1:	31 c9                	xor    %ecx,%ecx
80105da3:	89 c8                	mov    %ecx,%eax
80105da5:	89 e5                	mov    %esp,%ebp
80105da7:	57                   	push   %edi
80105da8:	bf fa 03 00 00       	mov    $0x3fa,%edi
80105dad:	56                   	push   %esi
80105dae:	89 fa                	mov    %edi,%edx
80105db0:	53                   	push   %ebx
80105db1:	83 ec 1c             	sub    $0x1c,%esp
80105db4:	ee                   	out    %al,(%dx)
80105db5:	be fb 03 00 00       	mov    $0x3fb,%esi
80105dba:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105dbf:	89 f2                	mov    %esi,%edx
80105dc1:	ee                   	out    %al,(%dx)
80105dc2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105dc7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105dcc:	ee                   	out    %al,(%dx)
80105dcd:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80105dd2:	89 c8                	mov    %ecx,%eax
80105dd4:	89 da                	mov    %ebx,%edx
80105dd6:	ee                   	out    %al,(%dx)
80105dd7:	b8 03 00 00 00       	mov    $0x3,%eax
80105ddc:	89 f2                	mov    %esi,%edx
80105dde:	ee                   	out    %al,(%dx)
80105ddf:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105de4:	89 c8                	mov    %ecx,%eax
80105de6:	ee                   	out    %al,(%dx)
80105de7:	b8 01 00 00 00       	mov    $0x1,%eax
80105dec:	89 da                	mov    %ebx,%edx
80105dee:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105def:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105df4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105df5:	3c ff                	cmp    $0xff,%al
80105df7:	0f 84 7c 00 00 00    	je     80105e79 <uartinit+0xd9>
  uart = 1;
80105dfd:	c7 05 c0 44 11 80 01 	movl   $0x1,0x801144c0
80105e04:	00 00 00 
80105e07:	89 fa                	mov    %edi,%edx
80105e09:	ec                   	in     (%dx),%al
80105e0a:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e0f:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105e10:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105e13:	bf 38 77 10 80       	mov    $0x80107738,%edi
80105e18:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
80105e1d:	6a 00                	push   $0x0
80105e1f:	6a 04                	push   $0x4
80105e21:	e8 1a c8 ff ff       	call   80102640 <ioapicenable>
80105e26:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105e29:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
80105e2d:	8d 76 00             	lea    0x0(%esi),%esi
  if(!uart)
80105e30:	a1 c0 44 11 80       	mov    0x801144c0,%eax
80105e35:	85 c0                	test   %eax,%eax
80105e37:	74 32                	je     80105e6b <uartinit+0xcb>
80105e39:	89 f2                	mov    %esi,%edx
80105e3b:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105e3c:	a8 20                	test   $0x20,%al
80105e3e:	75 21                	jne    80105e61 <uartinit+0xc1>
80105e40:	bb 80 00 00 00       	mov    $0x80,%ebx
80105e45:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
80105e48:	83 ec 0c             	sub    $0xc,%esp
80105e4b:	6a 0a                	push   $0xa
80105e4d:	e8 9e cc ff ff       	call   80102af0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105e52:	83 c4 10             	add    $0x10,%esp
80105e55:	83 eb 01             	sub    $0x1,%ebx
80105e58:	74 07                	je     80105e61 <uartinit+0xc1>
80105e5a:	89 f2                	mov    %esi,%edx
80105e5c:	ec                   	in     (%dx),%al
80105e5d:	a8 20                	test   $0x20,%al
80105e5f:	74 e7                	je     80105e48 <uartinit+0xa8>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105e61:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e66:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80105e6a:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80105e6b:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80105e6f:	83 c7 01             	add    $0x1,%edi
80105e72:	88 45 e7             	mov    %al,-0x19(%ebp)
80105e75:	84 c0                	test   %al,%al
80105e77:	75 b7                	jne    80105e30 <uartinit+0x90>
}
80105e79:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e7c:	5b                   	pop    %ebx
80105e7d:	5e                   	pop    %esi
80105e7e:	5f                   	pop    %edi
80105e7f:	5d                   	pop    %ebp
80105e80:	c3                   	ret
80105e81:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e88:	00 
80105e89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105e90 <uartputc>:
  if(!uart)
80105e90:	a1 c0 44 11 80       	mov    0x801144c0,%eax
80105e95:	85 c0                	test   %eax,%eax
80105e97:	74 4f                	je     80105ee8 <uartputc+0x58>
{
80105e99:	55                   	push   %ebp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105e9a:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105e9f:	89 e5                	mov    %esp,%ebp
80105ea1:	56                   	push   %esi
80105ea2:	53                   	push   %ebx
80105ea3:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105ea4:	a8 20                	test   $0x20,%al
80105ea6:	75 29                	jne    80105ed1 <uartputc+0x41>
80105ea8:	bb 80 00 00 00       	mov    $0x80,%ebx
80105ead:	be fd 03 00 00       	mov    $0x3fd,%esi
80105eb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80105eb8:	83 ec 0c             	sub    $0xc,%esp
80105ebb:	6a 0a                	push   $0xa
80105ebd:	e8 2e cc ff ff       	call   80102af0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105ec2:	83 c4 10             	add    $0x10,%esp
80105ec5:	83 eb 01             	sub    $0x1,%ebx
80105ec8:	74 07                	je     80105ed1 <uartputc+0x41>
80105eca:	89 f2                	mov    %esi,%edx
80105ecc:	ec                   	in     (%dx),%al
80105ecd:	a8 20                	test   $0x20,%al
80105ecf:	74 e7                	je     80105eb8 <uartputc+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105ed1:	8b 45 08             	mov    0x8(%ebp),%eax
80105ed4:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105ed9:	ee                   	out    %al,(%dx)
}
80105eda:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105edd:	5b                   	pop    %ebx
80105ede:	5e                   	pop    %esi
80105edf:	5d                   	pop    %ebp
80105ee0:	c3                   	ret
80105ee1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105ee8:	c3                   	ret
80105ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ef0 <uartintr>:

void
uartintr(void)
{
80105ef0:	55                   	push   %ebp
80105ef1:	89 e5                	mov    %esp,%ebp
80105ef3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105ef6:	68 70 5d 10 80       	push   $0x80105d70
80105efb:	e8 c0 a9 ff ff       	call   801008c0 <consoleintr>
}
80105f00:	83 c4 10             	add    $0x10,%esp
80105f03:	c9                   	leave
80105f04:	c3                   	ret

80105f05 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105f05:	6a 00                	push   $0x0
  pushl $0
80105f07:	6a 00                	push   $0x0
  jmp alltraps
80105f09:	e9 0c fb ff ff       	jmp    80105a1a <alltraps>

80105f0e <vector1>:
.globl vector1
vector1:
  pushl $0
80105f0e:	6a 00                	push   $0x0
  pushl $1
80105f10:	6a 01                	push   $0x1
  jmp alltraps
80105f12:	e9 03 fb ff ff       	jmp    80105a1a <alltraps>

80105f17 <vector2>:
.globl vector2
vector2:
  pushl $0
80105f17:	6a 00                	push   $0x0
  pushl $2
80105f19:	6a 02                	push   $0x2
  jmp alltraps
80105f1b:	e9 fa fa ff ff       	jmp    80105a1a <alltraps>

80105f20 <vector3>:
.globl vector3
vector3:
  pushl $0
80105f20:	6a 00                	push   $0x0
  pushl $3
80105f22:	6a 03                	push   $0x3
  jmp alltraps
80105f24:	e9 f1 fa ff ff       	jmp    80105a1a <alltraps>

80105f29 <vector4>:
.globl vector4
vector4:
  pushl $0
80105f29:	6a 00                	push   $0x0
  pushl $4
80105f2b:	6a 04                	push   $0x4
  jmp alltraps
80105f2d:	e9 e8 fa ff ff       	jmp    80105a1a <alltraps>

80105f32 <vector5>:
.globl vector5
vector5:
  pushl $0
80105f32:	6a 00                	push   $0x0
  pushl $5
80105f34:	6a 05                	push   $0x5
  jmp alltraps
80105f36:	e9 df fa ff ff       	jmp    80105a1a <alltraps>

80105f3b <vector6>:
.globl vector6
vector6:
  pushl $0
80105f3b:	6a 00                	push   $0x0
  pushl $6
80105f3d:	6a 06                	push   $0x6
  jmp alltraps
80105f3f:	e9 d6 fa ff ff       	jmp    80105a1a <alltraps>

80105f44 <vector7>:
.globl vector7
vector7:
  pushl $0
80105f44:	6a 00                	push   $0x0
  pushl $7
80105f46:	6a 07                	push   $0x7
  jmp alltraps
80105f48:	e9 cd fa ff ff       	jmp    80105a1a <alltraps>

80105f4d <vector8>:
.globl vector8
vector8:
  pushl $8
80105f4d:	6a 08                	push   $0x8
  jmp alltraps
80105f4f:	e9 c6 fa ff ff       	jmp    80105a1a <alltraps>

80105f54 <vector9>:
.globl vector9
vector9:
  pushl $0
80105f54:	6a 00                	push   $0x0
  pushl $9
80105f56:	6a 09                	push   $0x9
  jmp alltraps
80105f58:	e9 bd fa ff ff       	jmp    80105a1a <alltraps>

80105f5d <vector10>:
.globl vector10
vector10:
  pushl $10
80105f5d:	6a 0a                	push   $0xa
  jmp alltraps
80105f5f:	e9 b6 fa ff ff       	jmp    80105a1a <alltraps>

80105f64 <vector11>:
.globl vector11
vector11:
  pushl $11
80105f64:	6a 0b                	push   $0xb
  jmp alltraps
80105f66:	e9 af fa ff ff       	jmp    80105a1a <alltraps>

80105f6b <vector12>:
.globl vector12
vector12:
  pushl $12
80105f6b:	6a 0c                	push   $0xc
  jmp alltraps
80105f6d:	e9 a8 fa ff ff       	jmp    80105a1a <alltraps>

80105f72 <vector13>:
.globl vector13
vector13:
  pushl $13
80105f72:	6a 0d                	push   $0xd
  jmp alltraps
80105f74:	e9 a1 fa ff ff       	jmp    80105a1a <alltraps>

80105f79 <vector14>:
.globl vector14
vector14:
  pushl $14
80105f79:	6a 0e                	push   $0xe
  jmp alltraps
80105f7b:	e9 9a fa ff ff       	jmp    80105a1a <alltraps>

80105f80 <vector15>:
.globl vector15
vector15:
  pushl $0
80105f80:	6a 00                	push   $0x0
  pushl $15
80105f82:	6a 0f                	push   $0xf
  jmp alltraps
80105f84:	e9 91 fa ff ff       	jmp    80105a1a <alltraps>

80105f89 <vector16>:
.globl vector16
vector16:
  pushl $0
80105f89:	6a 00                	push   $0x0
  pushl $16
80105f8b:	6a 10                	push   $0x10
  jmp alltraps
80105f8d:	e9 88 fa ff ff       	jmp    80105a1a <alltraps>

80105f92 <vector17>:
.globl vector17
vector17:
  pushl $17
80105f92:	6a 11                	push   $0x11
  jmp alltraps
80105f94:	e9 81 fa ff ff       	jmp    80105a1a <alltraps>

80105f99 <vector18>:
.globl vector18
vector18:
  pushl $0
80105f99:	6a 00                	push   $0x0
  pushl $18
80105f9b:	6a 12                	push   $0x12
  jmp alltraps
80105f9d:	e9 78 fa ff ff       	jmp    80105a1a <alltraps>

80105fa2 <vector19>:
.globl vector19
vector19:
  pushl $0
80105fa2:	6a 00                	push   $0x0
  pushl $19
80105fa4:	6a 13                	push   $0x13
  jmp alltraps
80105fa6:	e9 6f fa ff ff       	jmp    80105a1a <alltraps>

80105fab <vector20>:
.globl vector20
vector20:
  pushl $0
80105fab:	6a 00                	push   $0x0
  pushl $20
80105fad:	6a 14                	push   $0x14
  jmp alltraps
80105faf:	e9 66 fa ff ff       	jmp    80105a1a <alltraps>

80105fb4 <vector21>:
.globl vector21
vector21:
  pushl $0
80105fb4:	6a 00                	push   $0x0
  pushl $21
80105fb6:	6a 15                	push   $0x15
  jmp alltraps
80105fb8:	e9 5d fa ff ff       	jmp    80105a1a <alltraps>

80105fbd <vector22>:
.globl vector22
vector22:
  pushl $0
80105fbd:	6a 00                	push   $0x0
  pushl $22
80105fbf:	6a 16                	push   $0x16
  jmp alltraps
80105fc1:	e9 54 fa ff ff       	jmp    80105a1a <alltraps>

80105fc6 <vector23>:
.globl vector23
vector23:
  pushl $0
80105fc6:	6a 00                	push   $0x0
  pushl $23
80105fc8:	6a 17                	push   $0x17
  jmp alltraps
80105fca:	e9 4b fa ff ff       	jmp    80105a1a <alltraps>

80105fcf <vector24>:
.globl vector24
vector24:
  pushl $0
80105fcf:	6a 00                	push   $0x0
  pushl $24
80105fd1:	6a 18                	push   $0x18
  jmp alltraps
80105fd3:	e9 42 fa ff ff       	jmp    80105a1a <alltraps>

80105fd8 <vector25>:
.globl vector25
vector25:
  pushl $0
80105fd8:	6a 00                	push   $0x0
  pushl $25
80105fda:	6a 19                	push   $0x19
  jmp alltraps
80105fdc:	e9 39 fa ff ff       	jmp    80105a1a <alltraps>

80105fe1 <vector26>:
.globl vector26
vector26:
  pushl $0
80105fe1:	6a 00                	push   $0x0
  pushl $26
80105fe3:	6a 1a                	push   $0x1a
  jmp alltraps
80105fe5:	e9 30 fa ff ff       	jmp    80105a1a <alltraps>

80105fea <vector27>:
.globl vector27
vector27:
  pushl $0
80105fea:	6a 00                	push   $0x0
  pushl $27
80105fec:	6a 1b                	push   $0x1b
  jmp alltraps
80105fee:	e9 27 fa ff ff       	jmp    80105a1a <alltraps>

80105ff3 <vector28>:
.globl vector28
vector28:
  pushl $0
80105ff3:	6a 00                	push   $0x0
  pushl $28
80105ff5:	6a 1c                	push   $0x1c
  jmp alltraps
80105ff7:	e9 1e fa ff ff       	jmp    80105a1a <alltraps>

80105ffc <vector29>:
.globl vector29
vector29:
  pushl $0
80105ffc:	6a 00                	push   $0x0
  pushl $29
80105ffe:	6a 1d                	push   $0x1d
  jmp alltraps
80106000:	e9 15 fa ff ff       	jmp    80105a1a <alltraps>

80106005 <vector30>:
.globl vector30
vector30:
  pushl $0
80106005:	6a 00                	push   $0x0
  pushl $30
80106007:	6a 1e                	push   $0x1e
  jmp alltraps
80106009:	e9 0c fa ff ff       	jmp    80105a1a <alltraps>

8010600e <vector31>:
.globl vector31
vector31:
  pushl $0
8010600e:	6a 00                	push   $0x0
  pushl $31
80106010:	6a 1f                	push   $0x1f
  jmp alltraps
80106012:	e9 03 fa ff ff       	jmp    80105a1a <alltraps>

80106017 <vector32>:
.globl vector32
vector32:
  pushl $0
80106017:	6a 00                	push   $0x0
  pushl $32
80106019:	6a 20                	push   $0x20
  jmp alltraps
8010601b:	e9 fa f9 ff ff       	jmp    80105a1a <alltraps>

80106020 <vector33>:
.globl vector33
vector33:
  pushl $0
80106020:	6a 00                	push   $0x0
  pushl $33
80106022:	6a 21                	push   $0x21
  jmp alltraps
80106024:	e9 f1 f9 ff ff       	jmp    80105a1a <alltraps>

80106029 <vector34>:
.globl vector34
vector34:
  pushl $0
80106029:	6a 00                	push   $0x0
  pushl $34
8010602b:	6a 22                	push   $0x22
  jmp alltraps
8010602d:	e9 e8 f9 ff ff       	jmp    80105a1a <alltraps>

80106032 <vector35>:
.globl vector35
vector35:
  pushl $0
80106032:	6a 00                	push   $0x0
  pushl $35
80106034:	6a 23                	push   $0x23
  jmp alltraps
80106036:	e9 df f9 ff ff       	jmp    80105a1a <alltraps>

8010603b <vector36>:
.globl vector36
vector36:
  pushl $0
8010603b:	6a 00                	push   $0x0
  pushl $36
8010603d:	6a 24                	push   $0x24
  jmp alltraps
8010603f:	e9 d6 f9 ff ff       	jmp    80105a1a <alltraps>

80106044 <vector37>:
.globl vector37
vector37:
  pushl $0
80106044:	6a 00                	push   $0x0
  pushl $37
80106046:	6a 25                	push   $0x25
  jmp alltraps
80106048:	e9 cd f9 ff ff       	jmp    80105a1a <alltraps>

8010604d <vector38>:
.globl vector38
vector38:
  pushl $0
8010604d:	6a 00                	push   $0x0
  pushl $38
8010604f:	6a 26                	push   $0x26
  jmp alltraps
80106051:	e9 c4 f9 ff ff       	jmp    80105a1a <alltraps>

80106056 <vector39>:
.globl vector39
vector39:
  pushl $0
80106056:	6a 00                	push   $0x0
  pushl $39
80106058:	6a 27                	push   $0x27
  jmp alltraps
8010605a:	e9 bb f9 ff ff       	jmp    80105a1a <alltraps>

8010605f <vector40>:
.globl vector40
vector40:
  pushl $0
8010605f:	6a 00                	push   $0x0
  pushl $40
80106061:	6a 28                	push   $0x28
  jmp alltraps
80106063:	e9 b2 f9 ff ff       	jmp    80105a1a <alltraps>

80106068 <vector41>:
.globl vector41
vector41:
  pushl $0
80106068:	6a 00                	push   $0x0
  pushl $41
8010606a:	6a 29                	push   $0x29
  jmp alltraps
8010606c:	e9 a9 f9 ff ff       	jmp    80105a1a <alltraps>

80106071 <vector42>:
.globl vector42
vector42:
  pushl $0
80106071:	6a 00                	push   $0x0
  pushl $42
80106073:	6a 2a                	push   $0x2a
  jmp alltraps
80106075:	e9 a0 f9 ff ff       	jmp    80105a1a <alltraps>

8010607a <vector43>:
.globl vector43
vector43:
  pushl $0
8010607a:	6a 00                	push   $0x0
  pushl $43
8010607c:	6a 2b                	push   $0x2b
  jmp alltraps
8010607e:	e9 97 f9 ff ff       	jmp    80105a1a <alltraps>

80106083 <vector44>:
.globl vector44
vector44:
  pushl $0
80106083:	6a 00                	push   $0x0
  pushl $44
80106085:	6a 2c                	push   $0x2c
  jmp alltraps
80106087:	e9 8e f9 ff ff       	jmp    80105a1a <alltraps>

8010608c <vector45>:
.globl vector45
vector45:
  pushl $0
8010608c:	6a 00                	push   $0x0
  pushl $45
8010608e:	6a 2d                	push   $0x2d
  jmp alltraps
80106090:	e9 85 f9 ff ff       	jmp    80105a1a <alltraps>

80106095 <vector46>:
.globl vector46
vector46:
  pushl $0
80106095:	6a 00                	push   $0x0
  pushl $46
80106097:	6a 2e                	push   $0x2e
  jmp alltraps
80106099:	e9 7c f9 ff ff       	jmp    80105a1a <alltraps>

8010609e <vector47>:
.globl vector47
vector47:
  pushl $0
8010609e:	6a 00                	push   $0x0
  pushl $47
801060a0:	6a 2f                	push   $0x2f
  jmp alltraps
801060a2:	e9 73 f9 ff ff       	jmp    80105a1a <alltraps>

801060a7 <vector48>:
.globl vector48
vector48:
  pushl $0
801060a7:	6a 00                	push   $0x0
  pushl $48
801060a9:	6a 30                	push   $0x30
  jmp alltraps
801060ab:	e9 6a f9 ff ff       	jmp    80105a1a <alltraps>

801060b0 <vector49>:
.globl vector49
vector49:
  pushl $0
801060b0:	6a 00                	push   $0x0
  pushl $49
801060b2:	6a 31                	push   $0x31
  jmp alltraps
801060b4:	e9 61 f9 ff ff       	jmp    80105a1a <alltraps>

801060b9 <vector50>:
.globl vector50
vector50:
  pushl $0
801060b9:	6a 00                	push   $0x0
  pushl $50
801060bb:	6a 32                	push   $0x32
  jmp alltraps
801060bd:	e9 58 f9 ff ff       	jmp    80105a1a <alltraps>

801060c2 <vector51>:
.globl vector51
vector51:
  pushl $0
801060c2:	6a 00                	push   $0x0
  pushl $51
801060c4:	6a 33                	push   $0x33
  jmp alltraps
801060c6:	e9 4f f9 ff ff       	jmp    80105a1a <alltraps>

801060cb <vector52>:
.globl vector52
vector52:
  pushl $0
801060cb:	6a 00                	push   $0x0
  pushl $52
801060cd:	6a 34                	push   $0x34
  jmp alltraps
801060cf:	e9 46 f9 ff ff       	jmp    80105a1a <alltraps>

801060d4 <vector53>:
.globl vector53
vector53:
  pushl $0
801060d4:	6a 00                	push   $0x0
  pushl $53
801060d6:	6a 35                	push   $0x35
  jmp alltraps
801060d8:	e9 3d f9 ff ff       	jmp    80105a1a <alltraps>

801060dd <vector54>:
.globl vector54
vector54:
  pushl $0
801060dd:	6a 00                	push   $0x0
  pushl $54
801060df:	6a 36                	push   $0x36
  jmp alltraps
801060e1:	e9 34 f9 ff ff       	jmp    80105a1a <alltraps>

801060e6 <vector55>:
.globl vector55
vector55:
  pushl $0
801060e6:	6a 00                	push   $0x0
  pushl $55
801060e8:	6a 37                	push   $0x37
  jmp alltraps
801060ea:	e9 2b f9 ff ff       	jmp    80105a1a <alltraps>

801060ef <vector56>:
.globl vector56
vector56:
  pushl $0
801060ef:	6a 00                	push   $0x0
  pushl $56
801060f1:	6a 38                	push   $0x38
  jmp alltraps
801060f3:	e9 22 f9 ff ff       	jmp    80105a1a <alltraps>

801060f8 <vector57>:
.globl vector57
vector57:
  pushl $0
801060f8:	6a 00                	push   $0x0
  pushl $57
801060fa:	6a 39                	push   $0x39
  jmp alltraps
801060fc:	e9 19 f9 ff ff       	jmp    80105a1a <alltraps>

80106101 <vector58>:
.globl vector58
vector58:
  pushl $0
80106101:	6a 00                	push   $0x0
  pushl $58
80106103:	6a 3a                	push   $0x3a
  jmp alltraps
80106105:	e9 10 f9 ff ff       	jmp    80105a1a <alltraps>

8010610a <vector59>:
.globl vector59
vector59:
  pushl $0
8010610a:	6a 00                	push   $0x0
  pushl $59
8010610c:	6a 3b                	push   $0x3b
  jmp alltraps
8010610e:	e9 07 f9 ff ff       	jmp    80105a1a <alltraps>

80106113 <vector60>:
.globl vector60
vector60:
  pushl $0
80106113:	6a 00                	push   $0x0
  pushl $60
80106115:	6a 3c                	push   $0x3c
  jmp alltraps
80106117:	e9 fe f8 ff ff       	jmp    80105a1a <alltraps>

8010611c <vector61>:
.globl vector61
vector61:
  pushl $0
8010611c:	6a 00                	push   $0x0
  pushl $61
8010611e:	6a 3d                	push   $0x3d
  jmp alltraps
80106120:	e9 f5 f8 ff ff       	jmp    80105a1a <alltraps>

80106125 <vector62>:
.globl vector62
vector62:
  pushl $0
80106125:	6a 00                	push   $0x0
  pushl $62
80106127:	6a 3e                	push   $0x3e
  jmp alltraps
80106129:	e9 ec f8 ff ff       	jmp    80105a1a <alltraps>

8010612e <vector63>:
.globl vector63
vector63:
  pushl $0
8010612e:	6a 00                	push   $0x0
  pushl $63
80106130:	6a 3f                	push   $0x3f
  jmp alltraps
80106132:	e9 e3 f8 ff ff       	jmp    80105a1a <alltraps>

80106137 <vector64>:
.globl vector64
vector64:
  pushl $0
80106137:	6a 00                	push   $0x0
  pushl $64
80106139:	6a 40                	push   $0x40
  jmp alltraps
8010613b:	e9 da f8 ff ff       	jmp    80105a1a <alltraps>

80106140 <vector65>:
.globl vector65
vector65:
  pushl $0
80106140:	6a 00                	push   $0x0
  pushl $65
80106142:	6a 41                	push   $0x41
  jmp alltraps
80106144:	e9 d1 f8 ff ff       	jmp    80105a1a <alltraps>

80106149 <vector66>:
.globl vector66
vector66:
  pushl $0
80106149:	6a 00                	push   $0x0
  pushl $66
8010614b:	6a 42                	push   $0x42
  jmp alltraps
8010614d:	e9 c8 f8 ff ff       	jmp    80105a1a <alltraps>

80106152 <vector67>:
.globl vector67
vector67:
  pushl $0
80106152:	6a 00                	push   $0x0
  pushl $67
80106154:	6a 43                	push   $0x43
  jmp alltraps
80106156:	e9 bf f8 ff ff       	jmp    80105a1a <alltraps>

8010615b <vector68>:
.globl vector68
vector68:
  pushl $0
8010615b:	6a 00                	push   $0x0
  pushl $68
8010615d:	6a 44                	push   $0x44
  jmp alltraps
8010615f:	e9 b6 f8 ff ff       	jmp    80105a1a <alltraps>

80106164 <vector69>:
.globl vector69
vector69:
  pushl $0
80106164:	6a 00                	push   $0x0
  pushl $69
80106166:	6a 45                	push   $0x45
  jmp alltraps
80106168:	e9 ad f8 ff ff       	jmp    80105a1a <alltraps>

8010616d <vector70>:
.globl vector70
vector70:
  pushl $0
8010616d:	6a 00                	push   $0x0
  pushl $70
8010616f:	6a 46                	push   $0x46
  jmp alltraps
80106171:	e9 a4 f8 ff ff       	jmp    80105a1a <alltraps>

80106176 <vector71>:
.globl vector71
vector71:
  pushl $0
80106176:	6a 00                	push   $0x0
  pushl $71
80106178:	6a 47                	push   $0x47
  jmp alltraps
8010617a:	e9 9b f8 ff ff       	jmp    80105a1a <alltraps>

8010617f <vector72>:
.globl vector72
vector72:
  pushl $0
8010617f:	6a 00                	push   $0x0
  pushl $72
80106181:	6a 48                	push   $0x48
  jmp alltraps
80106183:	e9 92 f8 ff ff       	jmp    80105a1a <alltraps>

80106188 <vector73>:
.globl vector73
vector73:
  pushl $0
80106188:	6a 00                	push   $0x0
  pushl $73
8010618a:	6a 49                	push   $0x49
  jmp alltraps
8010618c:	e9 89 f8 ff ff       	jmp    80105a1a <alltraps>

80106191 <vector74>:
.globl vector74
vector74:
  pushl $0
80106191:	6a 00                	push   $0x0
  pushl $74
80106193:	6a 4a                	push   $0x4a
  jmp alltraps
80106195:	e9 80 f8 ff ff       	jmp    80105a1a <alltraps>

8010619a <vector75>:
.globl vector75
vector75:
  pushl $0
8010619a:	6a 00                	push   $0x0
  pushl $75
8010619c:	6a 4b                	push   $0x4b
  jmp alltraps
8010619e:	e9 77 f8 ff ff       	jmp    80105a1a <alltraps>

801061a3 <vector76>:
.globl vector76
vector76:
  pushl $0
801061a3:	6a 00                	push   $0x0
  pushl $76
801061a5:	6a 4c                	push   $0x4c
  jmp alltraps
801061a7:	e9 6e f8 ff ff       	jmp    80105a1a <alltraps>

801061ac <vector77>:
.globl vector77
vector77:
  pushl $0
801061ac:	6a 00                	push   $0x0
  pushl $77
801061ae:	6a 4d                	push   $0x4d
  jmp alltraps
801061b0:	e9 65 f8 ff ff       	jmp    80105a1a <alltraps>

801061b5 <vector78>:
.globl vector78
vector78:
  pushl $0
801061b5:	6a 00                	push   $0x0
  pushl $78
801061b7:	6a 4e                	push   $0x4e
  jmp alltraps
801061b9:	e9 5c f8 ff ff       	jmp    80105a1a <alltraps>

801061be <vector79>:
.globl vector79
vector79:
  pushl $0
801061be:	6a 00                	push   $0x0
  pushl $79
801061c0:	6a 4f                	push   $0x4f
  jmp alltraps
801061c2:	e9 53 f8 ff ff       	jmp    80105a1a <alltraps>

801061c7 <vector80>:
.globl vector80
vector80:
  pushl $0
801061c7:	6a 00                	push   $0x0
  pushl $80
801061c9:	6a 50                	push   $0x50
  jmp alltraps
801061cb:	e9 4a f8 ff ff       	jmp    80105a1a <alltraps>

801061d0 <vector81>:
.globl vector81
vector81:
  pushl $0
801061d0:	6a 00                	push   $0x0
  pushl $81
801061d2:	6a 51                	push   $0x51
  jmp alltraps
801061d4:	e9 41 f8 ff ff       	jmp    80105a1a <alltraps>

801061d9 <vector82>:
.globl vector82
vector82:
  pushl $0
801061d9:	6a 00                	push   $0x0
  pushl $82
801061db:	6a 52                	push   $0x52
  jmp alltraps
801061dd:	e9 38 f8 ff ff       	jmp    80105a1a <alltraps>

801061e2 <vector83>:
.globl vector83
vector83:
  pushl $0
801061e2:	6a 00                	push   $0x0
  pushl $83
801061e4:	6a 53                	push   $0x53
  jmp alltraps
801061e6:	e9 2f f8 ff ff       	jmp    80105a1a <alltraps>

801061eb <vector84>:
.globl vector84
vector84:
  pushl $0
801061eb:	6a 00                	push   $0x0
  pushl $84
801061ed:	6a 54                	push   $0x54
  jmp alltraps
801061ef:	e9 26 f8 ff ff       	jmp    80105a1a <alltraps>

801061f4 <vector85>:
.globl vector85
vector85:
  pushl $0
801061f4:	6a 00                	push   $0x0
  pushl $85
801061f6:	6a 55                	push   $0x55
  jmp alltraps
801061f8:	e9 1d f8 ff ff       	jmp    80105a1a <alltraps>

801061fd <vector86>:
.globl vector86
vector86:
  pushl $0
801061fd:	6a 00                	push   $0x0
  pushl $86
801061ff:	6a 56                	push   $0x56
  jmp alltraps
80106201:	e9 14 f8 ff ff       	jmp    80105a1a <alltraps>

80106206 <vector87>:
.globl vector87
vector87:
  pushl $0
80106206:	6a 00                	push   $0x0
  pushl $87
80106208:	6a 57                	push   $0x57
  jmp alltraps
8010620a:	e9 0b f8 ff ff       	jmp    80105a1a <alltraps>

8010620f <vector88>:
.globl vector88
vector88:
  pushl $0
8010620f:	6a 00                	push   $0x0
  pushl $88
80106211:	6a 58                	push   $0x58
  jmp alltraps
80106213:	e9 02 f8 ff ff       	jmp    80105a1a <alltraps>

80106218 <vector89>:
.globl vector89
vector89:
  pushl $0
80106218:	6a 00                	push   $0x0
  pushl $89
8010621a:	6a 59                	push   $0x59
  jmp alltraps
8010621c:	e9 f9 f7 ff ff       	jmp    80105a1a <alltraps>

80106221 <vector90>:
.globl vector90
vector90:
  pushl $0
80106221:	6a 00                	push   $0x0
  pushl $90
80106223:	6a 5a                	push   $0x5a
  jmp alltraps
80106225:	e9 f0 f7 ff ff       	jmp    80105a1a <alltraps>

8010622a <vector91>:
.globl vector91
vector91:
  pushl $0
8010622a:	6a 00                	push   $0x0
  pushl $91
8010622c:	6a 5b                	push   $0x5b
  jmp alltraps
8010622e:	e9 e7 f7 ff ff       	jmp    80105a1a <alltraps>

80106233 <vector92>:
.globl vector92
vector92:
  pushl $0
80106233:	6a 00                	push   $0x0
  pushl $92
80106235:	6a 5c                	push   $0x5c
  jmp alltraps
80106237:	e9 de f7 ff ff       	jmp    80105a1a <alltraps>

8010623c <vector93>:
.globl vector93
vector93:
  pushl $0
8010623c:	6a 00                	push   $0x0
  pushl $93
8010623e:	6a 5d                	push   $0x5d
  jmp alltraps
80106240:	e9 d5 f7 ff ff       	jmp    80105a1a <alltraps>

80106245 <vector94>:
.globl vector94
vector94:
  pushl $0
80106245:	6a 00                	push   $0x0
  pushl $94
80106247:	6a 5e                	push   $0x5e
  jmp alltraps
80106249:	e9 cc f7 ff ff       	jmp    80105a1a <alltraps>

8010624e <vector95>:
.globl vector95
vector95:
  pushl $0
8010624e:	6a 00                	push   $0x0
  pushl $95
80106250:	6a 5f                	push   $0x5f
  jmp alltraps
80106252:	e9 c3 f7 ff ff       	jmp    80105a1a <alltraps>

80106257 <vector96>:
.globl vector96
vector96:
  pushl $0
80106257:	6a 00                	push   $0x0
  pushl $96
80106259:	6a 60                	push   $0x60
  jmp alltraps
8010625b:	e9 ba f7 ff ff       	jmp    80105a1a <alltraps>

80106260 <vector97>:
.globl vector97
vector97:
  pushl $0
80106260:	6a 00                	push   $0x0
  pushl $97
80106262:	6a 61                	push   $0x61
  jmp alltraps
80106264:	e9 b1 f7 ff ff       	jmp    80105a1a <alltraps>

80106269 <vector98>:
.globl vector98
vector98:
  pushl $0
80106269:	6a 00                	push   $0x0
  pushl $98
8010626b:	6a 62                	push   $0x62
  jmp alltraps
8010626d:	e9 a8 f7 ff ff       	jmp    80105a1a <alltraps>

80106272 <vector99>:
.globl vector99
vector99:
  pushl $0
80106272:	6a 00                	push   $0x0
  pushl $99
80106274:	6a 63                	push   $0x63
  jmp alltraps
80106276:	e9 9f f7 ff ff       	jmp    80105a1a <alltraps>

8010627b <vector100>:
.globl vector100
vector100:
  pushl $0
8010627b:	6a 00                	push   $0x0
  pushl $100
8010627d:	6a 64                	push   $0x64
  jmp alltraps
8010627f:	e9 96 f7 ff ff       	jmp    80105a1a <alltraps>

80106284 <vector101>:
.globl vector101
vector101:
  pushl $0
80106284:	6a 00                	push   $0x0
  pushl $101
80106286:	6a 65                	push   $0x65
  jmp alltraps
80106288:	e9 8d f7 ff ff       	jmp    80105a1a <alltraps>

8010628d <vector102>:
.globl vector102
vector102:
  pushl $0
8010628d:	6a 00                	push   $0x0
  pushl $102
8010628f:	6a 66                	push   $0x66
  jmp alltraps
80106291:	e9 84 f7 ff ff       	jmp    80105a1a <alltraps>

80106296 <vector103>:
.globl vector103
vector103:
  pushl $0
80106296:	6a 00                	push   $0x0
  pushl $103
80106298:	6a 67                	push   $0x67
  jmp alltraps
8010629a:	e9 7b f7 ff ff       	jmp    80105a1a <alltraps>

8010629f <vector104>:
.globl vector104
vector104:
  pushl $0
8010629f:	6a 00                	push   $0x0
  pushl $104
801062a1:	6a 68                	push   $0x68
  jmp alltraps
801062a3:	e9 72 f7 ff ff       	jmp    80105a1a <alltraps>

801062a8 <vector105>:
.globl vector105
vector105:
  pushl $0
801062a8:	6a 00                	push   $0x0
  pushl $105
801062aa:	6a 69                	push   $0x69
  jmp alltraps
801062ac:	e9 69 f7 ff ff       	jmp    80105a1a <alltraps>

801062b1 <vector106>:
.globl vector106
vector106:
  pushl $0
801062b1:	6a 00                	push   $0x0
  pushl $106
801062b3:	6a 6a                	push   $0x6a
  jmp alltraps
801062b5:	e9 60 f7 ff ff       	jmp    80105a1a <alltraps>

801062ba <vector107>:
.globl vector107
vector107:
  pushl $0
801062ba:	6a 00                	push   $0x0
  pushl $107
801062bc:	6a 6b                	push   $0x6b
  jmp alltraps
801062be:	e9 57 f7 ff ff       	jmp    80105a1a <alltraps>

801062c3 <vector108>:
.globl vector108
vector108:
  pushl $0
801062c3:	6a 00                	push   $0x0
  pushl $108
801062c5:	6a 6c                	push   $0x6c
  jmp alltraps
801062c7:	e9 4e f7 ff ff       	jmp    80105a1a <alltraps>

801062cc <vector109>:
.globl vector109
vector109:
  pushl $0
801062cc:	6a 00                	push   $0x0
  pushl $109
801062ce:	6a 6d                	push   $0x6d
  jmp alltraps
801062d0:	e9 45 f7 ff ff       	jmp    80105a1a <alltraps>

801062d5 <vector110>:
.globl vector110
vector110:
  pushl $0
801062d5:	6a 00                	push   $0x0
  pushl $110
801062d7:	6a 6e                	push   $0x6e
  jmp alltraps
801062d9:	e9 3c f7 ff ff       	jmp    80105a1a <alltraps>

801062de <vector111>:
.globl vector111
vector111:
  pushl $0
801062de:	6a 00                	push   $0x0
  pushl $111
801062e0:	6a 6f                	push   $0x6f
  jmp alltraps
801062e2:	e9 33 f7 ff ff       	jmp    80105a1a <alltraps>

801062e7 <vector112>:
.globl vector112
vector112:
  pushl $0
801062e7:	6a 00                	push   $0x0
  pushl $112
801062e9:	6a 70                	push   $0x70
  jmp alltraps
801062eb:	e9 2a f7 ff ff       	jmp    80105a1a <alltraps>

801062f0 <vector113>:
.globl vector113
vector113:
  pushl $0
801062f0:	6a 00                	push   $0x0
  pushl $113
801062f2:	6a 71                	push   $0x71
  jmp alltraps
801062f4:	e9 21 f7 ff ff       	jmp    80105a1a <alltraps>

801062f9 <vector114>:
.globl vector114
vector114:
  pushl $0
801062f9:	6a 00                	push   $0x0
  pushl $114
801062fb:	6a 72                	push   $0x72
  jmp alltraps
801062fd:	e9 18 f7 ff ff       	jmp    80105a1a <alltraps>

80106302 <vector115>:
.globl vector115
vector115:
  pushl $0
80106302:	6a 00                	push   $0x0
  pushl $115
80106304:	6a 73                	push   $0x73
  jmp alltraps
80106306:	e9 0f f7 ff ff       	jmp    80105a1a <alltraps>

8010630b <vector116>:
.globl vector116
vector116:
  pushl $0
8010630b:	6a 00                	push   $0x0
  pushl $116
8010630d:	6a 74                	push   $0x74
  jmp alltraps
8010630f:	e9 06 f7 ff ff       	jmp    80105a1a <alltraps>

80106314 <vector117>:
.globl vector117
vector117:
  pushl $0
80106314:	6a 00                	push   $0x0
  pushl $117
80106316:	6a 75                	push   $0x75
  jmp alltraps
80106318:	e9 fd f6 ff ff       	jmp    80105a1a <alltraps>

8010631d <vector118>:
.globl vector118
vector118:
  pushl $0
8010631d:	6a 00                	push   $0x0
  pushl $118
8010631f:	6a 76                	push   $0x76
  jmp alltraps
80106321:	e9 f4 f6 ff ff       	jmp    80105a1a <alltraps>

80106326 <vector119>:
.globl vector119
vector119:
  pushl $0
80106326:	6a 00                	push   $0x0
  pushl $119
80106328:	6a 77                	push   $0x77
  jmp alltraps
8010632a:	e9 eb f6 ff ff       	jmp    80105a1a <alltraps>

8010632f <vector120>:
.globl vector120
vector120:
  pushl $0
8010632f:	6a 00                	push   $0x0
  pushl $120
80106331:	6a 78                	push   $0x78
  jmp alltraps
80106333:	e9 e2 f6 ff ff       	jmp    80105a1a <alltraps>

80106338 <vector121>:
.globl vector121
vector121:
  pushl $0
80106338:	6a 00                	push   $0x0
  pushl $121
8010633a:	6a 79                	push   $0x79
  jmp alltraps
8010633c:	e9 d9 f6 ff ff       	jmp    80105a1a <alltraps>

80106341 <vector122>:
.globl vector122
vector122:
  pushl $0
80106341:	6a 00                	push   $0x0
  pushl $122
80106343:	6a 7a                	push   $0x7a
  jmp alltraps
80106345:	e9 d0 f6 ff ff       	jmp    80105a1a <alltraps>

8010634a <vector123>:
.globl vector123
vector123:
  pushl $0
8010634a:	6a 00                	push   $0x0
  pushl $123
8010634c:	6a 7b                	push   $0x7b
  jmp alltraps
8010634e:	e9 c7 f6 ff ff       	jmp    80105a1a <alltraps>

80106353 <vector124>:
.globl vector124
vector124:
  pushl $0
80106353:	6a 00                	push   $0x0
  pushl $124
80106355:	6a 7c                	push   $0x7c
  jmp alltraps
80106357:	e9 be f6 ff ff       	jmp    80105a1a <alltraps>

8010635c <vector125>:
.globl vector125
vector125:
  pushl $0
8010635c:	6a 00                	push   $0x0
  pushl $125
8010635e:	6a 7d                	push   $0x7d
  jmp alltraps
80106360:	e9 b5 f6 ff ff       	jmp    80105a1a <alltraps>

80106365 <vector126>:
.globl vector126
vector126:
  pushl $0
80106365:	6a 00                	push   $0x0
  pushl $126
80106367:	6a 7e                	push   $0x7e
  jmp alltraps
80106369:	e9 ac f6 ff ff       	jmp    80105a1a <alltraps>

8010636e <vector127>:
.globl vector127
vector127:
  pushl $0
8010636e:	6a 00                	push   $0x0
  pushl $127
80106370:	6a 7f                	push   $0x7f
  jmp alltraps
80106372:	e9 a3 f6 ff ff       	jmp    80105a1a <alltraps>

80106377 <vector128>:
.globl vector128
vector128:
  pushl $0
80106377:	6a 00                	push   $0x0
  pushl $128
80106379:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010637e:	e9 97 f6 ff ff       	jmp    80105a1a <alltraps>

80106383 <vector129>:
.globl vector129
vector129:
  pushl $0
80106383:	6a 00                	push   $0x0
  pushl $129
80106385:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010638a:	e9 8b f6 ff ff       	jmp    80105a1a <alltraps>

8010638f <vector130>:
.globl vector130
vector130:
  pushl $0
8010638f:	6a 00                	push   $0x0
  pushl $130
80106391:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106396:	e9 7f f6 ff ff       	jmp    80105a1a <alltraps>

8010639b <vector131>:
.globl vector131
vector131:
  pushl $0
8010639b:	6a 00                	push   $0x0
  pushl $131
8010639d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
801063a2:	e9 73 f6 ff ff       	jmp    80105a1a <alltraps>

801063a7 <vector132>:
.globl vector132
vector132:
  pushl $0
801063a7:	6a 00                	push   $0x0
  pushl $132
801063a9:	68 84 00 00 00       	push   $0x84
  jmp alltraps
801063ae:	e9 67 f6 ff ff       	jmp    80105a1a <alltraps>

801063b3 <vector133>:
.globl vector133
vector133:
  pushl $0
801063b3:	6a 00                	push   $0x0
  pushl $133
801063b5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801063ba:	e9 5b f6 ff ff       	jmp    80105a1a <alltraps>

801063bf <vector134>:
.globl vector134
vector134:
  pushl $0
801063bf:	6a 00                	push   $0x0
  pushl $134
801063c1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801063c6:	e9 4f f6 ff ff       	jmp    80105a1a <alltraps>

801063cb <vector135>:
.globl vector135
vector135:
  pushl $0
801063cb:	6a 00                	push   $0x0
  pushl $135
801063cd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801063d2:	e9 43 f6 ff ff       	jmp    80105a1a <alltraps>

801063d7 <vector136>:
.globl vector136
vector136:
  pushl $0
801063d7:	6a 00                	push   $0x0
  pushl $136
801063d9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801063de:	e9 37 f6 ff ff       	jmp    80105a1a <alltraps>

801063e3 <vector137>:
.globl vector137
vector137:
  pushl $0
801063e3:	6a 00                	push   $0x0
  pushl $137
801063e5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801063ea:	e9 2b f6 ff ff       	jmp    80105a1a <alltraps>

801063ef <vector138>:
.globl vector138
vector138:
  pushl $0
801063ef:	6a 00                	push   $0x0
  pushl $138
801063f1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801063f6:	e9 1f f6 ff ff       	jmp    80105a1a <alltraps>

801063fb <vector139>:
.globl vector139
vector139:
  pushl $0
801063fb:	6a 00                	push   $0x0
  pushl $139
801063fd:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106402:	e9 13 f6 ff ff       	jmp    80105a1a <alltraps>

80106407 <vector140>:
.globl vector140
vector140:
  pushl $0
80106407:	6a 00                	push   $0x0
  pushl $140
80106409:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010640e:	e9 07 f6 ff ff       	jmp    80105a1a <alltraps>

80106413 <vector141>:
.globl vector141
vector141:
  pushl $0
80106413:	6a 00                	push   $0x0
  pushl $141
80106415:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010641a:	e9 fb f5 ff ff       	jmp    80105a1a <alltraps>

8010641f <vector142>:
.globl vector142
vector142:
  pushl $0
8010641f:	6a 00                	push   $0x0
  pushl $142
80106421:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106426:	e9 ef f5 ff ff       	jmp    80105a1a <alltraps>

8010642b <vector143>:
.globl vector143
vector143:
  pushl $0
8010642b:	6a 00                	push   $0x0
  pushl $143
8010642d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106432:	e9 e3 f5 ff ff       	jmp    80105a1a <alltraps>

80106437 <vector144>:
.globl vector144
vector144:
  pushl $0
80106437:	6a 00                	push   $0x0
  pushl $144
80106439:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010643e:	e9 d7 f5 ff ff       	jmp    80105a1a <alltraps>

80106443 <vector145>:
.globl vector145
vector145:
  pushl $0
80106443:	6a 00                	push   $0x0
  pushl $145
80106445:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010644a:	e9 cb f5 ff ff       	jmp    80105a1a <alltraps>

8010644f <vector146>:
.globl vector146
vector146:
  pushl $0
8010644f:	6a 00                	push   $0x0
  pushl $146
80106451:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106456:	e9 bf f5 ff ff       	jmp    80105a1a <alltraps>

8010645b <vector147>:
.globl vector147
vector147:
  pushl $0
8010645b:	6a 00                	push   $0x0
  pushl $147
8010645d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106462:	e9 b3 f5 ff ff       	jmp    80105a1a <alltraps>

80106467 <vector148>:
.globl vector148
vector148:
  pushl $0
80106467:	6a 00                	push   $0x0
  pushl $148
80106469:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010646e:	e9 a7 f5 ff ff       	jmp    80105a1a <alltraps>

80106473 <vector149>:
.globl vector149
vector149:
  pushl $0
80106473:	6a 00                	push   $0x0
  pushl $149
80106475:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010647a:	e9 9b f5 ff ff       	jmp    80105a1a <alltraps>

8010647f <vector150>:
.globl vector150
vector150:
  pushl $0
8010647f:	6a 00                	push   $0x0
  pushl $150
80106481:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106486:	e9 8f f5 ff ff       	jmp    80105a1a <alltraps>

8010648b <vector151>:
.globl vector151
vector151:
  pushl $0
8010648b:	6a 00                	push   $0x0
  pushl $151
8010648d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106492:	e9 83 f5 ff ff       	jmp    80105a1a <alltraps>

80106497 <vector152>:
.globl vector152
vector152:
  pushl $0
80106497:	6a 00                	push   $0x0
  pushl $152
80106499:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010649e:	e9 77 f5 ff ff       	jmp    80105a1a <alltraps>

801064a3 <vector153>:
.globl vector153
vector153:
  pushl $0
801064a3:	6a 00                	push   $0x0
  pushl $153
801064a5:	68 99 00 00 00       	push   $0x99
  jmp alltraps
801064aa:	e9 6b f5 ff ff       	jmp    80105a1a <alltraps>

801064af <vector154>:
.globl vector154
vector154:
  pushl $0
801064af:	6a 00                	push   $0x0
  pushl $154
801064b1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801064b6:	e9 5f f5 ff ff       	jmp    80105a1a <alltraps>

801064bb <vector155>:
.globl vector155
vector155:
  pushl $0
801064bb:	6a 00                	push   $0x0
  pushl $155
801064bd:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801064c2:	e9 53 f5 ff ff       	jmp    80105a1a <alltraps>

801064c7 <vector156>:
.globl vector156
vector156:
  pushl $0
801064c7:	6a 00                	push   $0x0
  pushl $156
801064c9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801064ce:	e9 47 f5 ff ff       	jmp    80105a1a <alltraps>

801064d3 <vector157>:
.globl vector157
vector157:
  pushl $0
801064d3:	6a 00                	push   $0x0
  pushl $157
801064d5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801064da:	e9 3b f5 ff ff       	jmp    80105a1a <alltraps>

801064df <vector158>:
.globl vector158
vector158:
  pushl $0
801064df:	6a 00                	push   $0x0
  pushl $158
801064e1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801064e6:	e9 2f f5 ff ff       	jmp    80105a1a <alltraps>

801064eb <vector159>:
.globl vector159
vector159:
  pushl $0
801064eb:	6a 00                	push   $0x0
  pushl $159
801064ed:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801064f2:	e9 23 f5 ff ff       	jmp    80105a1a <alltraps>

801064f7 <vector160>:
.globl vector160
vector160:
  pushl $0
801064f7:	6a 00                	push   $0x0
  pushl $160
801064f9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801064fe:	e9 17 f5 ff ff       	jmp    80105a1a <alltraps>

80106503 <vector161>:
.globl vector161
vector161:
  pushl $0
80106503:	6a 00                	push   $0x0
  pushl $161
80106505:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
8010650a:	e9 0b f5 ff ff       	jmp    80105a1a <alltraps>

8010650f <vector162>:
.globl vector162
vector162:
  pushl $0
8010650f:	6a 00                	push   $0x0
  pushl $162
80106511:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106516:	e9 ff f4 ff ff       	jmp    80105a1a <alltraps>

8010651b <vector163>:
.globl vector163
vector163:
  pushl $0
8010651b:	6a 00                	push   $0x0
  pushl $163
8010651d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106522:	e9 f3 f4 ff ff       	jmp    80105a1a <alltraps>

80106527 <vector164>:
.globl vector164
vector164:
  pushl $0
80106527:	6a 00                	push   $0x0
  pushl $164
80106529:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010652e:	e9 e7 f4 ff ff       	jmp    80105a1a <alltraps>

80106533 <vector165>:
.globl vector165
vector165:
  pushl $0
80106533:	6a 00                	push   $0x0
  pushl $165
80106535:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010653a:	e9 db f4 ff ff       	jmp    80105a1a <alltraps>

8010653f <vector166>:
.globl vector166
vector166:
  pushl $0
8010653f:	6a 00                	push   $0x0
  pushl $166
80106541:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106546:	e9 cf f4 ff ff       	jmp    80105a1a <alltraps>

8010654b <vector167>:
.globl vector167
vector167:
  pushl $0
8010654b:	6a 00                	push   $0x0
  pushl $167
8010654d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106552:	e9 c3 f4 ff ff       	jmp    80105a1a <alltraps>

80106557 <vector168>:
.globl vector168
vector168:
  pushl $0
80106557:	6a 00                	push   $0x0
  pushl $168
80106559:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010655e:	e9 b7 f4 ff ff       	jmp    80105a1a <alltraps>

80106563 <vector169>:
.globl vector169
vector169:
  pushl $0
80106563:	6a 00                	push   $0x0
  pushl $169
80106565:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010656a:	e9 ab f4 ff ff       	jmp    80105a1a <alltraps>

8010656f <vector170>:
.globl vector170
vector170:
  pushl $0
8010656f:	6a 00                	push   $0x0
  pushl $170
80106571:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106576:	e9 9f f4 ff ff       	jmp    80105a1a <alltraps>

8010657b <vector171>:
.globl vector171
vector171:
  pushl $0
8010657b:	6a 00                	push   $0x0
  pushl $171
8010657d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106582:	e9 93 f4 ff ff       	jmp    80105a1a <alltraps>

80106587 <vector172>:
.globl vector172
vector172:
  pushl $0
80106587:	6a 00                	push   $0x0
  pushl $172
80106589:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010658e:	e9 87 f4 ff ff       	jmp    80105a1a <alltraps>

80106593 <vector173>:
.globl vector173
vector173:
  pushl $0
80106593:	6a 00                	push   $0x0
  pushl $173
80106595:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010659a:	e9 7b f4 ff ff       	jmp    80105a1a <alltraps>

8010659f <vector174>:
.globl vector174
vector174:
  pushl $0
8010659f:	6a 00                	push   $0x0
  pushl $174
801065a1:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
801065a6:	e9 6f f4 ff ff       	jmp    80105a1a <alltraps>

801065ab <vector175>:
.globl vector175
vector175:
  pushl $0
801065ab:	6a 00                	push   $0x0
  pushl $175
801065ad:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801065b2:	e9 63 f4 ff ff       	jmp    80105a1a <alltraps>

801065b7 <vector176>:
.globl vector176
vector176:
  pushl $0
801065b7:	6a 00                	push   $0x0
  pushl $176
801065b9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801065be:	e9 57 f4 ff ff       	jmp    80105a1a <alltraps>

801065c3 <vector177>:
.globl vector177
vector177:
  pushl $0
801065c3:	6a 00                	push   $0x0
  pushl $177
801065c5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801065ca:	e9 4b f4 ff ff       	jmp    80105a1a <alltraps>

801065cf <vector178>:
.globl vector178
vector178:
  pushl $0
801065cf:	6a 00                	push   $0x0
  pushl $178
801065d1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801065d6:	e9 3f f4 ff ff       	jmp    80105a1a <alltraps>

801065db <vector179>:
.globl vector179
vector179:
  pushl $0
801065db:	6a 00                	push   $0x0
  pushl $179
801065dd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801065e2:	e9 33 f4 ff ff       	jmp    80105a1a <alltraps>

801065e7 <vector180>:
.globl vector180
vector180:
  pushl $0
801065e7:	6a 00                	push   $0x0
  pushl $180
801065e9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801065ee:	e9 27 f4 ff ff       	jmp    80105a1a <alltraps>

801065f3 <vector181>:
.globl vector181
vector181:
  pushl $0
801065f3:	6a 00                	push   $0x0
  pushl $181
801065f5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801065fa:	e9 1b f4 ff ff       	jmp    80105a1a <alltraps>

801065ff <vector182>:
.globl vector182
vector182:
  pushl $0
801065ff:	6a 00                	push   $0x0
  pushl $182
80106601:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106606:	e9 0f f4 ff ff       	jmp    80105a1a <alltraps>

8010660b <vector183>:
.globl vector183
vector183:
  pushl $0
8010660b:	6a 00                	push   $0x0
  pushl $183
8010660d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106612:	e9 03 f4 ff ff       	jmp    80105a1a <alltraps>

80106617 <vector184>:
.globl vector184
vector184:
  pushl $0
80106617:	6a 00                	push   $0x0
  pushl $184
80106619:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010661e:	e9 f7 f3 ff ff       	jmp    80105a1a <alltraps>

80106623 <vector185>:
.globl vector185
vector185:
  pushl $0
80106623:	6a 00                	push   $0x0
  pushl $185
80106625:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010662a:	e9 eb f3 ff ff       	jmp    80105a1a <alltraps>

8010662f <vector186>:
.globl vector186
vector186:
  pushl $0
8010662f:	6a 00                	push   $0x0
  pushl $186
80106631:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106636:	e9 df f3 ff ff       	jmp    80105a1a <alltraps>

8010663b <vector187>:
.globl vector187
vector187:
  pushl $0
8010663b:	6a 00                	push   $0x0
  pushl $187
8010663d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106642:	e9 d3 f3 ff ff       	jmp    80105a1a <alltraps>

80106647 <vector188>:
.globl vector188
vector188:
  pushl $0
80106647:	6a 00                	push   $0x0
  pushl $188
80106649:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010664e:	e9 c7 f3 ff ff       	jmp    80105a1a <alltraps>

80106653 <vector189>:
.globl vector189
vector189:
  pushl $0
80106653:	6a 00                	push   $0x0
  pushl $189
80106655:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010665a:	e9 bb f3 ff ff       	jmp    80105a1a <alltraps>

8010665f <vector190>:
.globl vector190
vector190:
  pushl $0
8010665f:	6a 00                	push   $0x0
  pushl $190
80106661:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106666:	e9 af f3 ff ff       	jmp    80105a1a <alltraps>

8010666b <vector191>:
.globl vector191
vector191:
  pushl $0
8010666b:	6a 00                	push   $0x0
  pushl $191
8010666d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106672:	e9 a3 f3 ff ff       	jmp    80105a1a <alltraps>

80106677 <vector192>:
.globl vector192
vector192:
  pushl $0
80106677:	6a 00                	push   $0x0
  pushl $192
80106679:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010667e:	e9 97 f3 ff ff       	jmp    80105a1a <alltraps>

80106683 <vector193>:
.globl vector193
vector193:
  pushl $0
80106683:	6a 00                	push   $0x0
  pushl $193
80106685:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010668a:	e9 8b f3 ff ff       	jmp    80105a1a <alltraps>

8010668f <vector194>:
.globl vector194
vector194:
  pushl $0
8010668f:	6a 00                	push   $0x0
  pushl $194
80106691:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106696:	e9 7f f3 ff ff       	jmp    80105a1a <alltraps>

8010669b <vector195>:
.globl vector195
vector195:
  pushl $0
8010669b:	6a 00                	push   $0x0
  pushl $195
8010669d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
801066a2:	e9 73 f3 ff ff       	jmp    80105a1a <alltraps>

801066a7 <vector196>:
.globl vector196
vector196:
  pushl $0
801066a7:	6a 00                	push   $0x0
  pushl $196
801066a9:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
801066ae:	e9 67 f3 ff ff       	jmp    80105a1a <alltraps>

801066b3 <vector197>:
.globl vector197
vector197:
  pushl $0
801066b3:	6a 00                	push   $0x0
  pushl $197
801066b5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801066ba:	e9 5b f3 ff ff       	jmp    80105a1a <alltraps>

801066bf <vector198>:
.globl vector198
vector198:
  pushl $0
801066bf:	6a 00                	push   $0x0
  pushl $198
801066c1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801066c6:	e9 4f f3 ff ff       	jmp    80105a1a <alltraps>

801066cb <vector199>:
.globl vector199
vector199:
  pushl $0
801066cb:	6a 00                	push   $0x0
  pushl $199
801066cd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801066d2:	e9 43 f3 ff ff       	jmp    80105a1a <alltraps>

801066d7 <vector200>:
.globl vector200
vector200:
  pushl $0
801066d7:	6a 00                	push   $0x0
  pushl $200
801066d9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801066de:	e9 37 f3 ff ff       	jmp    80105a1a <alltraps>

801066e3 <vector201>:
.globl vector201
vector201:
  pushl $0
801066e3:	6a 00                	push   $0x0
  pushl $201
801066e5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801066ea:	e9 2b f3 ff ff       	jmp    80105a1a <alltraps>

801066ef <vector202>:
.globl vector202
vector202:
  pushl $0
801066ef:	6a 00                	push   $0x0
  pushl $202
801066f1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801066f6:	e9 1f f3 ff ff       	jmp    80105a1a <alltraps>

801066fb <vector203>:
.globl vector203
vector203:
  pushl $0
801066fb:	6a 00                	push   $0x0
  pushl $203
801066fd:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106702:	e9 13 f3 ff ff       	jmp    80105a1a <alltraps>

80106707 <vector204>:
.globl vector204
vector204:
  pushl $0
80106707:	6a 00                	push   $0x0
  pushl $204
80106709:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
8010670e:	e9 07 f3 ff ff       	jmp    80105a1a <alltraps>

80106713 <vector205>:
.globl vector205
vector205:
  pushl $0
80106713:	6a 00                	push   $0x0
  pushl $205
80106715:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010671a:	e9 fb f2 ff ff       	jmp    80105a1a <alltraps>

8010671f <vector206>:
.globl vector206
vector206:
  pushl $0
8010671f:	6a 00                	push   $0x0
  pushl $206
80106721:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106726:	e9 ef f2 ff ff       	jmp    80105a1a <alltraps>

8010672b <vector207>:
.globl vector207
vector207:
  pushl $0
8010672b:	6a 00                	push   $0x0
  pushl $207
8010672d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106732:	e9 e3 f2 ff ff       	jmp    80105a1a <alltraps>

80106737 <vector208>:
.globl vector208
vector208:
  pushl $0
80106737:	6a 00                	push   $0x0
  pushl $208
80106739:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010673e:	e9 d7 f2 ff ff       	jmp    80105a1a <alltraps>

80106743 <vector209>:
.globl vector209
vector209:
  pushl $0
80106743:	6a 00                	push   $0x0
  pushl $209
80106745:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010674a:	e9 cb f2 ff ff       	jmp    80105a1a <alltraps>

8010674f <vector210>:
.globl vector210
vector210:
  pushl $0
8010674f:	6a 00                	push   $0x0
  pushl $210
80106751:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106756:	e9 bf f2 ff ff       	jmp    80105a1a <alltraps>

8010675b <vector211>:
.globl vector211
vector211:
  pushl $0
8010675b:	6a 00                	push   $0x0
  pushl $211
8010675d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106762:	e9 b3 f2 ff ff       	jmp    80105a1a <alltraps>

80106767 <vector212>:
.globl vector212
vector212:
  pushl $0
80106767:	6a 00                	push   $0x0
  pushl $212
80106769:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010676e:	e9 a7 f2 ff ff       	jmp    80105a1a <alltraps>

80106773 <vector213>:
.globl vector213
vector213:
  pushl $0
80106773:	6a 00                	push   $0x0
  pushl $213
80106775:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010677a:	e9 9b f2 ff ff       	jmp    80105a1a <alltraps>

8010677f <vector214>:
.globl vector214
vector214:
  pushl $0
8010677f:	6a 00                	push   $0x0
  pushl $214
80106781:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106786:	e9 8f f2 ff ff       	jmp    80105a1a <alltraps>

8010678b <vector215>:
.globl vector215
vector215:
  pushl $0
8010678b:	6a 00                	push   $0x0
  pushl $215
8010678d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106792:	e9 83 f2 ff ff       	jmp    80105a1a <alltraps>

80106797 <vector216>:
.globl vector216
vector216:
  pushl $0
80106797:	6a 00                	push   $0x0
  pushl $216
80106799:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010679e:	e9 77 f2 ff ff       	jmp    80105a1a <alltraps>

801067a3 <vector217>:
.globl vector217
vector217:
  pushl $0
801067a3:	6a 00                	push   $0x0
  pushl $217
801067a5:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
801067aa:	e9 6b f2 ff ff       	jmp    80105a1a <alltraps>

801067af <vector218>:
.globl vector218
vector218:
  pushl $0
801067af:	6a 00                	push   $0x0
  pushl $218
801067b1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801067b6:	e9 5f f2 ff ff       	jmp    80105a1a <alltraps>

801067bb <vector219>:
.globl vector219
vector219:
  pushl $0
801067bb:	6a 00                	push   $0x0
  pushl $219
801067bd:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801067c2:	e9 53 f2 ff ff       	jmp    80105a1a <alltraps>

801067c7 <vector220>:
.globl vector220
vector220:
  pushl $0
801067c7:	6a 00                	push   $0x0
  pushl $220
801067c9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801067ce:	e9 47 f2 ff ff       	jmp    80105a1a <alltraps>

801067d3 <vector221>:
.globl vector221
vector221:
  pushl $0
801067d3:	6a 00                	push   $0x0
  pushl $221
801067d5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801067da:	e9 3b f2 ff ff       	jmp    80105a1a <alltraps>

801067df <vector222>:
.globl vector222
vector222:
  pushl $0
801067df:	6a 00                	push   $0x0
  pushl $222
801067e1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801067e6:	e9 2f f2 ff ff       	jmp    80105a1a <alltraps>

801067eb <vector223>:
.globl vector223
vector223:
  pushl $0
801067eb:	6a 00                	push   $0x0
  pushl $223
801067ed:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801067f2:	e9 23 f2 ff ff       	jmp    80105a1a <alltraps>

801067f7 <vector224>:
.globl vector224
vector224:
  pushl $0
801067f7:	6a 00                	push   $0x0
  pushl $224
801067f9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801067fe:	e9 17 f2 ff ff       	jmp    80105a1a <alltraps>

80106803 <vector225>:
.globl vector225
vector225:
  pushl $0
80106803:	6a 00                	push   $0x0
  pushl $225
80106805:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
8010680a:	e9 0b f2 ff ff       	jmp    80105a1a <alltraps>

8010680f <vector226>:
.globl vector226
vector226:
  pushl $0
8010680f:	6a 00                	push   $0x0
  pushl $226
80106811:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106816:	e9 ff f1 ff ff       	jmp    80105a1a <alltraps>

8010681b <vector227>:
.globl vector227
vector227:
  pushl $0
8010681b:	6a 00                	push   $0x0
  pushl $227
8010681d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106822:	e9 f3 f1 ff ff       	jmp    80105a1a <alltraps>

80106827 <vector228>:
.globl vector228
vector228:
  pushl $0
80106827:	6a 00                	push   $0x0
  pushl $228
80106829:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010682e:	e9 e7 f1 ff ff       	jmp    80105a1a <alltraps>

80106833 <vector229>:
.globl vector229
vector229:
  pushl $0
80106833:	6a 00                	push   $0x0
  pushl $229
80106835:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010683a:	e9 db f1 ff ff       	jmp    80105a1a <alltraps>

8010683f <vector230>:
.globl vector230
vector230:
  pushl $0
8010683f:	6a 00                	push   $0x0
  pushl $230
80106841:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106846:	e9 cf f1 ff ff       	jmp    80105a1a <alltraps>

8010684b <vector231>:
.globl vector231
vector231:
  pushl $0
8010684b:	6a 00                	push   $0x0
  pushl $231
8010684d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106852:	e9 c3 f1 ff ff       	jmp    80105a1a <alltraps>

80106857 <vector232>:
.globl vector232
vector232:
  pushl $0
80106857:	6a 00                	push   $0x0
  pushl $232
80106859:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010685e:	e9 b7 f1 ff ff       	jmp    80105a1a <alltraps>

80106863 <vector233>:
.globl vector233
vector233:
  pushl $0
80106863:	6a 00                	push   $0x0
  pushl $233
80106865:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010686a:	e9 ab f1 ff ff       	jmp    80105a1a <alltraps>

8010686f <vector234>:
.globl vector234
vector234:
  pushl $0
8010686f:	6a 00                	push   $0x0
  pushl $234
80106871:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106876:	e9 9f f1 ff ff       	jmp    80105a1a <alltraps>

8010687b <vector235>:
.globl vector235
vector235:
  pushl $0
8010687b:	6a 00                	push   $0x0
  pushl $235
8010687d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106882:	e9 93 f1 ff ff       	jmp    80105a1a <alltraps>

80106887 <vector236>:
.globl vector236
vector236:
  pushl $0
80106887:	6a 00                	push   $0x0
  pushl $236
80106889:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010688e:	e9 87 f1 ff ff       	jmp    80105a1a <alltraps>

80106893 <vector237>:
.globl vector237
vector237:
  pushl $0
80106893:	6a 00                	push   $0x0
  pushl $237
80106895:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010689a:	e9 7b f1 ff ff       	jmp    80105a1a <alltraps>

8010689f <vector238>:
.globl vector238
vector238:
  pushl $0
8010689f:	6a 00                	push   $0x0
  pushl $238
801068a1:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
801068a6:	e9 6f f1 ff ff       	jmp    80105a1a <alltraps>

801068ab <vector239>:
.globl vector239
vector239:
  pushl $0
801068ab:	6a 00                	push   $0x0
  pushl $239
801068ad:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801068b2:	e9 63 f1 ff ff       	jmp    80105a1a <alltraps>

801068b7 <vector240>:
.globl vector240
vector240:
  pushl $0
801068b7:	6a 00                	push   $0x0
  pushl $240
801068b9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801068be:	e9 57 f1 ff ff       	jmp    80105a1a <alltraps>

801068c3 <vector241>:
.globl vector241
vector241:
  pushl $0
801068c3:	6a 00                	push   $0x0
  pushl $241
801068c5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801068ca:	e9 4b f1 ff ff       	jmp    80105a1a <alltraps>

801068cf <vector242>:
.globl vector242
vector242:
  pushl $0
801068cf:	6a 00                	push   $0x0
  pushl $242
801068d1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801068d6:	e9 3f f1 ff ff       	jmp    80105a1a <alltraps>

801068db <vector243>:
.globl vector243
vector243:
  pushl $0
801068db:	6a 00                	push   $0x0
  pushl $243
801068dd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801068e2:	e9 33 f1 ff ff       	jmp    80105a1a <alltraps>

801068e7 <vector244>:
.globl vector244
vector244:
  pushl $0
801068e7:	6a 00                	push   $0x0
  pushl $244
801068e9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801068ee:	e9 27 f1 ff ff       	jmp    80105a1a <alltraps>

801068f3 <vector245>:
.globl vector245
vector245:
  pushl $0
801068f3:	6a 00                	push   $0x0
  pushl $245
801068f5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801068fa:	e9 1b f1 ff ff       	jmp    80105a1a <alltraps>

801068ff <vector246>:
.globl vector246
vector246:
  pushl $0
801068ff:	6a 00                	push   $0x0
  pushl $246
80106901:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106906:	e9 0f f1 ff ff       	jmp    80105a1a <alltraps>

8010690b <vector247>:
.globl vector247
vector247:
  pushl $0
8010690b:	6a 00                	push   $0x0
  pushl $247
8010690d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106912:	e9 03 f1 ff ff       	jmp    80105a1a <alltraps>

80106917 <vector248>:
.globl vector248
vector248:
  pushl $0
80106917:	6a 00                	push   $0x0
  pushl $248
80106919:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010691e:	e9 f7 f0 ff ff       	jmp    80105a1a <alltraps>

80106923 <vector249>:
.globl vector249
vector249:
  pushl $0
80106923:	6a 00                	push   $0x0
  pushl $249
80106925:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010692a:	e9 eb f0 ff ff       	jmp    80105a1a <alltraps>

8010692f <vector250>:
.globl vector250
vector250:
  pushl $0
8010692f:	6a 00                	push   $0x0
  pushl $250
80106931:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106936:	e9 df f0 ff ff       	jmp    80105a1a <alltraps>

8010693b <vector251>:
.globl vector251
vector251:
  pushl $0
8010693b:	6a 00                	push   $0x0
  pushl $251
8010693d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106942:	e9 d3 f0 ff ff       	jmp    80105a1a <alltraps>

80106947 <vector252>:
.globl vector252
vector252:
  pushl $0
80106947:	6a 00                	push   $0x0
  pushl $252
80106949:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010694e:	e9 c7 f0 ff ff       	jmp    80105a1a <alltraps>

80106953 <vector253>:
.globl vector253
vector253:
  pushl $0
80106953:	6a 00                	push   $0x0
  pushl $253
80106955:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010695a:	e9 bb f0 ff ff       	jmp    80105a1a <alltraps>

8010695f <vector254>:
.globl vector254
vector254:
  pushl $0
8010695f:	6a 00                	push   $0x0
  pushl $254
80106961:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106966:	e9 af f0 ff ff       	jmp    80105a1a <alltraps>

8010696b <vector255>:
.globl vector255
vector255:
  pushl $0
8010696b:	6a 00                	push   $0x0
  pushl $255
8010696d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106972:	e9 a3 f0 ff ff       	jmp    80105a1a <alltraps>
80106977:	66 90                	xchg   %ax,%ax
80106979:	66 90                	xchg   %ax,%ax
8010697b:	66 90                	xchg   %ax,%ax
8010697d:	66 90                	xchg   %ax,%ax
8010697f:	90                   	nop

80106980 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106980:	55                   	push   %ebp
80106981:	89 e5                	mov    %esp,%ebp
80106983:	57                   	push   %edi
80106984:	56                   	push   %esi
80106985:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106986:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
8010698c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106992:	83 ec 1c             	sub    $0x1c,%esp
  for(; a  < oldsz; a += PGSIZE){
80106995:	39 d3                	cmp    %edx,%ebx
80106997:	73 56                	jae    801069ef <deallocuvm.part.0+0x6f>
80106999:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010699c:	89 c6                	mov    %eax,%esi
8010699e:	89 d7                	mov    %edx,%edi
801069a0:	eb 12                	jmp    801069b4 <deallocuvm.part.0+0x34>
801069a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
801069a8:	83 c2 01             	add    $0x1,%edx
801069ab:	89 d3                	mov    %edx,%ebx
801069ad:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
801069b0:	39 fb                	cmp    %edi,%ebx
801069b2:	73 38                	jae    801069ec <deallocuvm.part.0+0x6c>
  pde = &pgdir[PDX(va)];
801069b4:	89 da                	mov    %ebx,%edx
801069b6:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
801069b9:	8b 04 96             	mov    (%esi,%edx,4),%eax
801069bc:	a8 01                	test   $0x1,%al
801069be:	74 e8                	je     801069a8 <deallocuvm.part.0+0x28>
  return &pgtab[PTX(va)];
801069c0:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801069c2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801069c7:	c1 e9 0a             	shr    $0xa,%ecx
801069ca:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
801069d0:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
801069d7:	85 c0                	test   %eax,%eax
801069d9:	74 cd                	je     801069a8 <deallocuvm.part.0+0x28>
    else if((*pte & PTE_P) != 0){
801069db:	8b 10                	mov    (%eax),%edx
801069dd:	f6 c2 01             	test   $0x1,%dl
801069e0:	75 1e                	jne    80106a00 <deallocuvm.part.0+0x80>
  for(; a  < oldsz; a += PGSIZE){
801069e2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801069e8:	39 fb                	cmp    %edi,%ebx
801069ea:	72 c8                	jb     801069b4 <deallocuvm.part.0+0x34>
801069ec:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
801069ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
801069f2:	89 c8                	mov    %ecx,%eax
801069f4:	5b                   	pop    %ebx
801069f5:	5e                   	pop    %esi
801069f6:	5f                   	pop    %edi
801069f7:	5d                   	pop    %ebp
801069f8:	c3                   	ret
801069f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(pa == 0)
80106a00:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106a06:	74 26                	je     80106a2e <deallocuvm.part.0+0xae>
      kfree(v);
80106a08:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106a0b:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106a11:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106a14:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80106a1a:	52                   	push   %edx
80106a1b:	e8 60 bc ff ff       	call   80102680 <kfree>
      *pte = 0;
80106a20:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(; a  < oldsz; a += PGSIZE){
80106a23:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80106a26:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80106a2c:	eb 82                	jmp    801069b0 <deallocuvm.part.0+0x30>
        panic("kfree");
80106a2e:	83 ec 0c             	sub    $0xc,%esp
80106a31:	68 0c 75 10 80       	push   $0x8010750c
80106a36:	e8 45 99 ff ff       	call   80100380 <panic>
80106a3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80106a40 <mappages>:
{
80106a40:	55                   	push   %ebp
80106a41:	89 e5                	mov    %esp,%ebp
80106a43:	57                   	push   %edi
80106a44:	56                   	push   %esi
80106a45:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106a46:	89 d3                	mov    %edx,%ebx
80106a48:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106a4e:	83 ec 1c             	sub    $0x1c,%esp
80106a51:	89 45 e0             	mov    %eax,-0x20(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106a54:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106a58:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106a5d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106a60:	8b 45 08             	mov    0x8(%ebp),%eax
80106a63:	29 d8                	sub    %ebx,%eax
80106a65:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106a68:	eb 3f                	jmp    80106aa9 <mappages+0x69>
80106a6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106a70:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106a72:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106a77:	c1 ea 0a             	shr    $0xa,%edx
80106a7a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106a80:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106a87:	85 c0                	test   %eax,%eax
80106a89:	74 75                	je     80106b00 <mappages+0xc0>
    if(*pte & PTE_P)
80106a8b:	f6 00 01             	testb  $0x1,(%eax)
80106a8e:	0f 85 86 00 00 00    	jne    80106b1a <mappages+0xda>
    *pte = pa | perm | PTE_P;
80106a94:	0b 75 0c             	or     0xc(%ebp),%esi
80106a97:	83 ce 01             	or     $0x1,%esi
80106a9a:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106a9c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106a9f:	39 c3                	cmp    %eax,%ebx
80106aa1:	74 6d                	je     80106b10 <mappages+0xd0>
    a += PGSIZE;
80106aa3:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80106aa9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
80106aac:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80106aaf:	8d 34 03             	lea    (%ebx,%eax,1),%esi
80106ab2:	89 d8                	mov    %ebx,%eax
80106ab4:	c1 e8 16             	shr    $0x16,%eax
80106ab7:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80106aba:	8b 07                	mov    (%edi),%eax
80106abc:	a8 01                	test   $0x1,%al
80106abe:	75 b0                	jne    80106a70 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106ac0:	e8 7b bd ff ff       	call   80102840 <kalloc>
80106ac5:	85 c0                	test   %eax,%eax
80106ac7:	74 37                	je     80106b00 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80106ac9:	83 ec 04             	sub    $0x4,%esp
80106acc:	68 00 10 00 00       	push   $0x1000
80106ad1:	6a 00                	push   $0x0
80106ad3:	50                   	push   %eax
80106ad4:	89 45 d8             	mov    %eax,-0x28(%ebp)
80106ad7:	e8 a4 dd ff ff       	call   80104880 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106adc:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
80106adf:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106ae2:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80106ae8:	83 c8 07             	or     $0x7,%eax
80106aeb:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80106aed:	89 d8                	mov    %ebx,%eax
80106aef:	c1 e8 0a             	shr    $0xa,%eax
80106af2:	25 fc 0f 00 00       	and    $0xffc,%eax
80106af7:	01 d0                	add    %edx,%eax
80106af9:	eb 90                	jmp    80106a8b <mappages+0x4b>
80106afb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
}
80106b00:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106b03:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b08:	5b                   	pop    %ebx
80106b09:	5e                   	pop    %esi
80106b0a:	5f                   	pop    %edi
80106b0b:	5d                   	pop    %ebp
80106b0c:	c3                   	ret
80106b0d:	8d 76 00             	lea    0x0(%esi),%esi
80106b10:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106b13:	31 c0                	xor    %eax,%eax
}
80106b15:	5b                   	pop    %ebx
80106b16:	5e                   	pop    %esi
80106b17:	5f                   	pop    %edi
80106b18:	5d                   	pop    %ebp
80106b19:	c3                   	ret
      panic("remap");
80106b1a:	83 ec 0c             	sub    $0xc,%esp
80106b1d:	68 40 77 10 80       	push   $0x80107740
80106b22:	e8 59 98 ff ff       	call   80100380 <panic>
80106b27:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106b2e:	00 
80106b2f:	90                   	nop

80106b30 <seginit>:
{
80106b30:	55                   	push   %ebp
80106b31:	89 e5                	mov    %esp,%ebp
80106b33:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106b36:	e8 e5 cf ff ff       	call   80103b20 <cpuid>
  pd[0] = size-1;
80106b3b:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106b40:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106b46:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
80106b4a:	c7 80 18 18 11 80 ff 	movl   $0xffff,-0x7feee7e8(%eax)
80106b51:	ff 00 00 
80106b54:	c7 80 1c 18 11 80 00 	movl   $0xcf9a00,-0x7feee7e4(%eax)
80106b5b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106b5e:	c7 80 20 18 11 80 ff 	movl   $0xffff,-0x7feee7e0(%eax)
80106b65:	ff 00 00 
80106b68:	c7 80 24 18 11 80 00 	movl   $0xcf9200,-0x7feee7dc(%eax)
80106b6f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106b72:	c7 80 28 18 11 80 ff 	movl   $0xffff,-0x7feee7d8(%eax)
80106b79:	ff 00 00 
80106b7c:	c7 80 2c 18 11 80 00 	movl   $0xcffa00,-0x7feee7d4(%eax)
80106b83:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106b86:	c7 80 30 18 11 80 ff 	movl   $0xffff,-0x7feee7d0(%eax)
80106b8d:	ff 00 00 
80106b90:	c7 80 34 18 11 80 00 	movl   $0xcff200,-0x7feee7cc(%eax)
80106b97:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106b9a:	05 10 18 11 80       	add    $0x80111810,%eax
  pd[1] = (uint)p;
80106b9f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106ba3:	c1 e8 10             	shr    $0x10,%eax
80106ba6:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106baa:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106bad:	0f 01 10             	lgdtl  (%eax)
}
80106bb0:	c9                   	leave
80106bb1:	c3                   	ret
80106bb2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106bb9:	00 
80106bba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106bc0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106bc0:	a1 c4 44 11 80       	mov    0x801144c4,%eax
80106bc5:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106bca:	0f 22 d8             	mov    %eax,%cr3
}
80106bcd:	c3                   	ret
80106bce:	66 90                	xchg   %ax,%ax

80106bd0 <switchuvm>:
{
80106bd0:	55                   	push   %ebp
80106bd1:	89 e5                	mov    %esp,%ebp
80106bd3:	57                   	push   %edi
80106bd4:	56                   	push   %esi
80106bd5:	53                   	push   %ebx
80106bd6:	83 ec 1c             	sub    $0x1c,%esp
80106bd9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106bdc:	85 f6                	test   %esi,%esi
80106bde:	0f 84 cb 00 00 00    	je     80106caf <switchuvm+0xdf>
  if(p->kstack == 0)
80106be4:	8b 46 08             	mov    0x8(%esi),%eax
80106be7:	85 c0                	test   %eax,%eax
80106be9:	0f 84 da 00 00 00    	je     80106cc9 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106bef:	8b 46 04             	mov    0x4(%esi),%eax
80106bf2:	85 c0                	test   %eax,%eax
80106bf4:	0f 84 c2 00 00 00    	je     80106cbc <switchuvm+0xec>
  pushcli();
80106bfa:	e8 31 da ff ff       	call   80104630 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106bff:	e8 bc ce ff ff       	call   80103ac0 <mycpu>
80106c04:	89 c3                	mov    %eax,%ebx
80106c06:	e8 b5 ce ff ff       	call   80103ac0 <mycpu>
80106c0b:	89 c7                	mov    %eax,%edi
80106c0d:	e8 ae ce ff ff       	call   80103ac0 <mycpu>
80106c12:	83 c7 08             	add    $0x8,%edi
80106c15:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106c18:	e8 a3 ce ff ff       	call   80103ac0 <mycpu>
80106c1d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106c20:	ba 67 00 00 00       	mov    $0x67,%edx
80106c25:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106c2c:	83 c0 08             	add    $0x8,%eax
80106c2f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106c36:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106c3b:	83 c1 08             	add    $0x8,%ecx
80106c3e:	c1 e8 18             	shr    $0x18,%eax
80106c41:	c1 e9 10             	shr    $0x10,%ecx
80106c44:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106c4a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106c50:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106c55:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106c5c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80106c61:	e8 5a ce ff ff       	call   80103ac0 <mycpu>
80106c66:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106c6d:	e8 4e ce ff ff       	call   80103ac0 <mycpu>
80106c72:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106c76:	8b 5e 08             	mov    0x8(%esi),%ebx
80106c79:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106c7f:	e8 3c ce ff ff       	call   80103ac0 <mycpu>
80106c84:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106c87:	e8 34 ce ff ff       	call   80103ac0 <mycpu>
80106c8c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106c90:	b8 28 00 00 00       	mov    $0x28,%eax
80106c95:	0f 00 d8             	ltr    %eax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106c98:	8b 46 04             	mov    0x4(%esi),%eax
80106c9b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106ca0:	0f 22 d8             	mov    %eax,%cr3
}
80106ca3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ca6:	5b                   	pop    %ebx
80106ca7:	5e                   	pop    %esi
80106ca8:	5f                   	pop    %edi
80106ca9:	5d                   	pop    %ebp
  popcli();
80106caa:	e9 d1 d9 ff ff       	jmp    80104680 <popcli>
    panic("switchuvm: no process");
80106caf:	83 ec 0c             	sub    $0xc,%esp
80106cb2:	68 46 77 10 80       	push   $0x80107746
80106cb7:	e8 c4 96 ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
80106cbc:	83 ec 0c             	sub    $0xc,%esp
80106cbf:	68 71 77 10 80       	push   $0x80107771
80106cc4:	e8 b7 96 ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
80106cc9:	83 ec 0c             	sub    $0xc,%esp
80106ccc:	68 5c 77 10 80       	push   $0x8010775c
80106cd1:	e8 aa 96 ff ff       	call   80100380 <panic>
80106cd6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106cdd:	00 
80106cde:	66 90                	xchg   %ax,%ax

80106ce0 <inituvm>:
{
80106ce0:	55                   	push   %ebp
80106ce1:	89 e5                	mov    %esp,%ebp
80106ce3:	57                   	push   %edi
80106ce4:	56                   	push   %esi
80106ce5:	53                   	push   %ebx
80106ce6:	83 ec 1c             	sub    $0x1c,%esp
80106ce9:	8b 45 08             	mov    0x8(%ebp),%eax
80106cec:	8b 75 10             	mov    0x10(%ebp),%esi
80106cef:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106cf2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106cf5:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106cfb:	77 49                	ja     80106d46 <inituvm+0x66>
  mem = kalloc();
80106cfd:	e8 3e bb ff ff       	call   80102840 <kalloc>
  memset(mem, 0, PGSIZE);
80106d02:	83 ec 04             	sub    $0x4,%esp
80106d05:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
80106d0a:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106d0c:	6a 00                	push   $0x0
80106d0e:	50                   	push   %eax
80106d0f:	e8 6c db ff ff       	call   80104880 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106d14:	58                   	pop    %eax
80106d15:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106d1b:	5a                   	pop    %edx
80106d1c:	6a 06                	push   $0x6
80106d1e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106d23:	31 d2                	xor    %edx,%edx
80106d25:	50                   	push   %eax
80106d26:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106d29:	e8 12 fd ff ff       	call   80106a40 <mappages>
  memmove(mem, init, sz);
80106d2e:	83 c4 10             	add    $0x10,%esp
80106d31:	89 75 10             	mov    %esi,0x10(%ebp)
80106d34:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106d37:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106d3a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d3d:	5b                   	pop    %ebx
80106d3e:	5e                   	pop    %esi
80106d3f:	5f                   	pop    %edi
80106d40:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106d41:	e9 ca db ff ff       	jmp    80104910 <memmove>
    panic("inituvm: more than a page");
80106d46:	83 ec 0c             	sub    $0xc,%esp
80106d49:	68 85 77 10 80       	push   $0x80107785
80106d4e:	e8 2d 96 ff ff       	call   80100380 <panic>
80106d53:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106d5a:	00 
80106d5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80106d60 <loaduvm>:
{
80106d60:	55                   	push   %ebp
80106d61:	89 e5                	mov    %esp,%ebp
80106d63:	57                   	push   %edi
80106d64:	56                   	push   %esi
80106d65:	53                   	push   %ebx
80106d66:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106d69:	8b 75 0c             	mov    0xc(%ebp),%esi
{
80106d6c:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
80106d6f:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
80106d75:	0f 85 a2 00 00 00    	jne    80106e1d <loaduvm+0xbd>
  for(i = 0; i < sz; i += PGSIZE){
80106d7b:	85 ff                	test   %edi,%edi
80106d7d:	74 7d                	je     80106dfc <loaduvm+0x9c>
80106d7f:	90                   	nop
  pde = &pgdir[PDX(va)];
80106d80:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80106d83:	8b 55 08             	mov    0x8(%ebp),%edx
80106d86:	01 f0                	add    %esi,%eax
  pde = &pgdir[PDX(va)];
80106d88:	89 c1                	mov    %eax,%ecx
80106d8a:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80106d8d:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
80106d90:	f6 c1 01             	test   $0x1,%cl
80106d93:	75 13                	jne    80106da8 <loaduvm+0x48>
      panic("loaduvm: address should exist");
80106d95:	83 ec 0c             	sub    $0xc,%esp
80106d98:	68 9f 77 10 80       	push   $0x8010779f
80106d9d:	e8 de 95 ff ff       	call   80100380 <panic>
80106da2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106da8:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106dab:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80106db1:	25 fc 0f 00 00       	and    $0xffc,%eax
80106db6:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106dbd:	85 c9                	test   %ecx,%ecx
80106dbf:	74 d4                	je     80106d95 <loaduvm+0x35>
    if(sz - i < PGSIZE)
80106dc1:	89 fb                	mov    %edi,%ebx
80106dc3:	b8 00 10 00 00       	mov    $0x1000,%eax
80106dc8:	29 f3                	sub    %esi,%ebx
80106dca:	39 c3                	cmp    %eax,%ebx
80106dcc:	0f 47 d8             	cmova  %eax,%ebx
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106dcf:	53                   	push   %ebx
80106dd0:	8b 45 14             	mov    0x14(%ebp),%eax
80106dd3:	01 f0                	add    %esi,%eax
80106dd5:	50                   	push   %eax
    pa = PTE_ADDR(*pte);
80106dd6:	8b 01                	mov    (%ecx),%eax
80106dd8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106ddd:	05 00 00 00 80       	add    $0x80000000,%eax
80106de2:	50                   	push   %eax
80106de3:	ff 75 10             	push   0x10(%ebp)
80106de6:	e8 a5 ae ff ff       	call   80101c90 <readi>
80106deb:	83 c4 10             	add    $0x10,%esp
80106dee:	39 d8                	cmp    %ebx,%eax
80106df0:	75 1e                	jne    80106e10 <loaduvm+0xb0>
  for(i = 0; i < sz; i += PGSIZE){
80106df2:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106df8:	39 fe                	cmp    %edi,%esi
80106dfa:	72 84                	jb     80106d80 <loaduvm+0x20>
}
80106dfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106dff:	31 c0                	xor    %eax,%eax
}
80106e01:	5b                   	pop    %ebx
80106e02:	5e                   	pop    %esi
80106e03:	5f                   	pop    %edi
80106e04:	5d                   	pop    %ebp
80106e05:	c3                   	ret
80106e06:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106e0d:	00 
80106e0e:	66 90                	xchg   %ax,%ax
80106e10:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106e13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106e18:	5b                   	pop    %ebx
80106e19:	5e                   	pop    %esi
80106e1a:	5f                   	pop    %edi
80106e1b:	5d                   	pop    %ebp
80106e1c:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
80106e1d:	83 ec 0c             	sub    $0xc,%esp
80106e20:	68 f4 79 10 80       	push   $0x801079f4
80106e25:	e8 56 95 ff ff       	call   80100380 <panic>
80106e2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106e30 <allocuvm>:
{
80106e30:	55                   	push   %ebp
80106e31:	89 e5                	mov    %esp,%ebp
80106e33:	57                   	push   %edi
80106e34:	56                   	push   %esi
80106e35:	53                   	push   %ebx
80106e36:	83 ec 1c             	sub    $0x1c,%esp
80106e39:	8b 75 10             	mov    0x10(%ebp),%esi
  if(newsz >= KERNBASE)
80106e3c:	85 f6                	test   %esi,%esi
80106e3e:	0f 88 98 00 00 00    	js     80106edc <allocuvm+0xac>
80106e44:	89 f2                	mov    %esi,%edx
  if(newsz < oldsz)
80106e46:	3b 75 0c             	cmp    0xc(%ebp),%esi
80106e49:	0f 82 a1 00 00 00    	jb     80106ef0 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80106e4f:	8b 45 0c             	mov    0xc(%ebp),%eax
80106e52:	05 ff 0f 00 00       	add    $0xfff,%eax
80106e57:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106e5c:	89 c7                	mov    %eax,%edi
  for(; a < newsz; a += PGSIZE){
80106e5e:	39 f0                	cmp    %esi,%eax
80106e60:	0f 83 8d 00 00 00    	jae    80106ef3 <allocuvm+0xc3>
80106e66:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80106e69:	eb 44                	jmp    80106eaf <allocuvm+0x7f>
80106e6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80106e70:	83 ec 04             	sub    $0x4,%esp
80106e73:	68 00 10 00 00       	push   $0x1000
80106e78:	6a 00                	push   $0x0
80106e7a:	50                   	push   %eax
80106e7b:	e8 00 da ff ff       	call   80104880 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106e80:	58                   	pop    %eax
80106e81:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106e87:	5a                   	pop    %edx
80106e88:	6a 06                	push   $0x6
80106e8a:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106e8f:	89 fa                	mov    %edi,%edx
80106e91:	50                   	push   %eax
80106e92:	8b 45 08             	mov    0x8(%ebp),%eax
80106e95:	e8 a6 fb ff ff       	call   80106a40 <mappages>
80106e9a:	83 c4 10             	add    $0x10,%esp
80106e9d:	85 c0                	test   %eax,%eax
80106e9f:	78 5f                	js     80106f00 <allocuvm+0xd0>
  for(; a < newsz; a += PGSIZE){
80106ea1:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106ea7:	39 f7                	cmp    %esi,%edi
80106ea9:	0f 83 89 00 00 00    	jae    80106f38 <allocuvm+0x108>
    mem = kalloc();
80106eaf:	e8 8c b9 ff ff       	call   80102840 <kalloc>
80106eb4:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80106eb6:	85 c0                	test   %eax,%eax
80106eb8:	75 b6                	jne    80106e70 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106eba:	83 ec 0c             	sub    $0xc,%esp
80106ebd:	68 bd 77 10 80       	push   $0x801077bd
80106ec2:	e8 a9 97 ff ff       	call   80100670 <cprintf>
  if(newsz >= oldsz)
80106ec7:	83 c4 10             	add    $0x10,%esp
80106eca:	3b 75 0c             	cmp    0xc(%ebp),%esi
80106ecd:	74 0d                	je     80106edc <allocuvm+0xac>
80106ecf:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106ed2:	8b 45 08             	mov    0x8(%ebp),%eax
80106ed5:	89 f2                	mov    %esi,%edx
80106ed7:	e8 a4 fa ff ff       	call   80106980 <deallocuvm.part.0>
    return 0;
80106edc:	31 d2                	xor    %edx,%edx
}
80106ede:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ee1:	89 d0                	mov    %edx,%eax
80106ee3:	5b                   	pop    %ebx
80106ee4:	5e                   	pop    %esi
80106ee5:	5f                   	pop    %edi
80106ee6:	5d                   	pop    %ebp
80106ee7:	c3                   	ret
80106ee8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106eef:	00 
    return oldsz;
80106ef0:	8b 55 0c             	mov    0xc(%ebp),%edx
}
80106ef3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ef6:	89 d0                	mov    %edx,%eax
80106ef8:	5b                   	pop    %ebx
80106ef9:	5e                   	pop    %esi
80106efa:	5f                   	pop    %edi
80106efb:	5d                   	pop    %ebp
80106efc:	c3                   	ret
80106efd:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106f00:	83 ec 0c             	sub    $0xc,%esp
80106f03:	68 d5 77 10 80       	push   $0x801077d5
80106f08:	e8 63 97 ff ff       	call   80100670 <cprintf>
  if(newsz >= oldsz)
80106f0d:	83 c4 10             	add    $0x10,%esp
80106f10:	3b 75 0c             	cmp    0xc(%ebp),%esi
80106f13:	74 0d                	je     80106f22 <allocuvm+0xf2>
80106f15:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106f18:	8b 45 08             	mov    0x8(%ebp),%eax
80106f1b:	89 f2                	mov    %esi,%edx
80106f1d:	e8 5e fa ff ff       	call   80106980 <deallocuvm.part.0>
      kfree(mem);
80106f22:	83 ec 0c             	sub    $0xc,%esp
80106f25:	53                   	push   %ebx
80106f26:	e8 55 b7 ff ff       	call   80102680 <kfree>
      return 0;
80106f2b:	83 c4 10             	add    $0x10,%esp
    return 0;
80106f2e:	31 d2                	xor    %edx,%edx
80106f30:	eb ac                	jmp    80106ede <allocuvm+0xae>
80106f32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106f38:	8b 55 e4             	mov    -0x1c(%ebp),%edx
}
80106f3b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f3e:	5b                   	pop    %ebx
80106f3f:	5e                   	pop    %esi
80106f40:	89 d0                	mov    %edx,%eax
80106f42:	5f                   	pop    %edi
80106f43:	5d                   	pop    %ebp
80106f44:	c3                   	ret
80106f45:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106f4c:	00 
80106f4d:	8d 76 00             	lea    0x0(%esi),%esi

80106f50 <deallocuvm>:
{
80106f50:	55                   	push   %ebp
80106f51:	89 e5                	mov    %esp,%ebp
80106f53:	8b 55 0c             	mov    0xc(%ebp),%edx
80106f56:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106f59:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106f5c:	39 d1                	cmp    %edx,%ecx
80106f5e:	73 10                	jae    80106f70 <deallocuvm+0x20>
}
80106f60:	5d                   	pop    %ebp
80106f61:	e9 1a fa ff ff       	jmp    80106980 <deallocuvm.part.0>
80106f66:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106f6d:	00 
80106f6e:	66 90                	xchg   %ax,%ax
80106f70:	89 d0                	mov    %edx,%eax
80106f72:	5d                   	pop    %ebp
80106f73:	c3                   	ret
80106f74:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106f7b:	00 
80106f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106f80 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106f80:	55                   	push   %ebp
80106f81:	89 e5                	mov    %esp,%ebp
80106f83:	57                   	push   %edi
80106f84:	56                   	push   %esi
80106f85:	53                   	push   %ebx
80106f86:	83 ec 0c             	sub    $0xc,%esp
80106f89:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106f8c:	85 f6                	test   %esi,%esi
80106f8e:	74 59                	je     80106fe9 <freevm+0x69>
  if(newsz >= oldsz)
80106f90:	31 c9                	xor    %ecx,%ecx
80106f92:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106f97:	89 f0                	mov    %esi,%eax
80106f99:	89 f3                	mov    %esi,%ebx
80106f9b:	e8 e0 f9 ff ff       	call   80106980 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106fa0:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106fa6:	eb 0f                	jmp    80106fb7 <freevm+0x37>
80106fa8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106faf:	00 
80106fb0:	83 c3 04             	add    $0x4,%ebx
80106fb3:	39 fb                	cmp    %edi,%ebx
80106fb5:	74 23                	je     80106fda <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106fb7:	8b 03                	mov    (%ebx),%eax
80106fb9:	a8 01                	test   $0x1,%al
80106fbb:	74 f3                	je     80106fb0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106fbd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106fc2:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106fc5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106fc8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106fcd:	50                   	push   %eax
80106fce:	e8 ad b6 ff ff       	call   80102680 <kfree>
80106fd3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106fd6:	39 fb                	cmp    %edi,%ebx
80106fd8:	75 dd                	jne    80106fb7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106fda:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106fdd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fe0:	5b                   	pop    %ebx
80106fe1:	5e                   	pop    %esi
80106fe2:	5f                   	pop    %edi
80106fe3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106fe4:	e9 97 b6 ff ff       	jmp    80102680 <kfree>
    panic("freevm: no pgdir");
80106fe9:	83 ec 0c             	sub    $0xc,%esp
80106fec:	68 f1 77 10 80       	push   $0x801077f1
80106ff1:	e8 8a 93 ff ff       	call   80100380 <panic>
80106ff6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106ffd:	00 
80106ffe:	66 90                	xchg   %ax,%ax

80107000 <setupkvm>:
{
80107000:	55                   	push   %ebp
80107001:	89 e5                	mov    %esp,%ebp
80107003:	56                   	push   %esi
80107004:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107005:	e8 36 b8 ff ff       	call   80102840 <kalloc>
8010700a:	85 c0                	test   %eax,%eax
8010700c:	74 5e                	je     8010706c <setupkvm+0x6c>
  memset(pgdir, 0, PGSIZE);
8010700e:	83 ec 04             	sub    $0x4,%esp
80107011:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107013:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80107018:	68 00 10 00 00       	push   $0x1000
8010701d:	6a 00                	push   $0x0
8010701f:	50                   	push   %eax
80107020:	e8 5b d8 ff ff       	call   80104880 <memset>
80107025:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80107028:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
8010702b:	83 ec 08             	sub    $0x8,%esp
8010702e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80107031:	8b 13                	mov    (%ebx),%edx
80107033:	ff 73 0c             	push   0xc(%ebx)
80107036:	50                   	push   %eax
80107037:	29 c1                	sub    %eax,%ecx
80107039:	89 f0                	mov    %esi,%eax
8010703b:	e8 00 fa ff ff       	call   80106a40 <mappages>
80107040:	83 c4 10             	add    $0x10,%esp
80107043:	85 c0                	test   %eax,%eax
80107045:	78 19                	js     80107060 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80107047:	83 c3 10             	add    $0x10,%ebx
8010704a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80107050:	75 d6                	jne    80107028 <setupkvm+0x28>
}
80107052:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107055:	89 f0                	mov    %esi,%eax
80107057:	5b                   	pop    %ebx
80107058:	5e                   	pop    %esi
80107059:	5d                   	pop    %ebp
8010705a:	c3                   	ret
8010705b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107060:	83 ec 0c             	sub    $0xc,%esp
80107063:	56                   	push   %esi
80107064:	e8 17 ff ff ff       	call   80106f80 <freevm>
      return 0;
80107069:	83 c4 10             	add    $0x10,%esp
}
8010706c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
8010706f:	31 f6                	xor    %esi,%esi
}
80107071:	89 f0                	mov    %esi,%eax
80107073:	5b                   	pop    %ebx
80107074:	5e                   	pop    %esi
80107075:	5d                   	pop    %ebp
80107076:	c3                   	ret
80107077:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010707e:	00 
8010707f:	90                   	nop

80107080 <kvmalloc>:
{
80107080:	55                   	push   %ebp
80107081:	89 e5                	mov    %esp,%ebp
80107083:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107086:	e8 75 ff ff ff       	call   80107000 <setupkvm>
8010708b:	a3 c4 44 11 80       	mov    %eax,0x801144c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107090:	05 00 00 00 80       	add    $0x80000000,%eax
80107095:	0f 22 d8             	mov    %eax,%cr3
}
80107098:	c9                   	leave
80107099:	c3                   	ret
8010709a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801070a0 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801070a0:	55                   	push   %ebp
801070a1:	89 e5                	mov    %esp,%ebp
801070a3:	83 ec 08             	sub    $0x8,%esp
801070a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801070a9:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801070ac:	89 c1                	mov    %eax,%ecx
801070ae:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801070b1:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801070b4:	f6 c2 01             	test   $0x1,%dl
801070b7:	75 17                	jne    801070d0 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
801070b9:	83 ec 0c             	sub    $0xc,%esp
801070bc:	68 02 78 10 80       	push   $0x80107802
801070c1:	e8 ba 92 ff ff       	call   80100380 <panic>
801070c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801070cd:	00 
801070ce:	66 90                	xchg   %ax,%ax
  return &pgtab[PTX(va)];
801070d0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801070d3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
801070d9:	25 fc 0f 00 00       	and    $0xffc,%eax
801070de:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
801070e5:	85 c0                	test   %eax,%eax
801070e7:	74 d0                	je     801070b9 <clearpteu+0x19>
  *pte &= ~PTE_U;
801070e9:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
801070ec:	c9                   	leave
801070ed:	c3                   	ret
801070ee:	66 90                	xchg   %ax,%ax

801070f0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801070f0:	55                   	push   %ebp
801070f1:	89 e5                	mov    %esp,%ebp
801070f3:	57                   	push   %edi
801070f4:	56                   	push   %esi
801070f5:	53                   	push   %ebx
801070f6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801070f9:	e8 02 ff ff ff       	call   80107000 <setupkvm>
801070fe:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107101:	85 c0                	test   %eax,%eax
80107103:	0f 84 e9 00 00 00    	je     801071f2 <copyuvm+0x102>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107109:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010710c:	85 c9                	test   %ecx,%ecx
8010710e:	0f 84 b2 00 00 00    	je     801071c6 <copyuvm+0xd6>
80107114:	31 f6                	xor    %esi,%esi
80107116:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010711d:	00 
8010711e:	66 90                	xchg   %ax,%ax
  if(*pde & PTE_P){
80107120:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107123:	89 f0                	mov    %esi,%eax
80107125:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107128:	8b 04 81             	mov    (%ecx,%eax,4),%eax
8010712b:	a8 01                	test   $0x1,%al
8010712d:	75 11                	jne    80107140 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010712f:	83 ec 0c             	sub    $0xc,%esp
80107132:	68 0c 78 10 80       	push   $0x8010780c
80107137:	e8 44 92 ff ff       	call   80100380 <panic>
8010713c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107140:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107142:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107147:	c1 ea 0a             	shr    $0xa,%edx
8010714a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107150:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107157:	85 c0                	test   %eax,%eax
80107159:	74 d4                	je     8010712f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
8010715b:	8b 00                	mov    (%eax),%eax
8010715d:	a8 01                	test   $0x1,%al
8010715f:	0f 84 9f 00 00 00    	je     80107204 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107165:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107167:	25 ff 0f 00 00       	and    $0xfff,%eax
8010716c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
8010716f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107175:	e8 c6 b6 ff ff       	call   80102840 <kalloc>
8010717a:	89 c3                	mov    %eax,%ebx
8010717c:	85 c0                	test   %eax,%eax
8010717e:	74 64                	je     801071e4 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107180:	83 ec 04             	sub    $0x4,%esp
80107183:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107189:	68 00 10 00 00       	push   $0x1000
8010718e:	57                   	push   %edi
8010718f:	50                   	push   %eax
80107190:	e8 7b d7 ff ff       	call   80104910 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107195:	58                   	pop    %eax
80107196:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010719c:	5a                   	pop    %edx
8010719d:	ff 75 e4             	push   -0x1c(%ebp)
801071a0:	b9 00 10 00 00       	mov    $0x1000,%ecx
801071a5:	89 f2                	mov    %esi,%edx
801071a7:	50                   	push   %eax
801071a8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801071ab:	e8 90 f8 ff ff       	call   80106a40 <mappages>
801071b0:	83 c4 10             	add    $0x10,%esp
801071b3:	85 c0                	test   %eax,%eax
801071b5:	78 21                	js     801071d8 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
801071b7:	81 c6 00 10 00 00    	add    $0x1000,%esi
801071bd:	3b 75 0c             	cmp    0xc(%ebp),%esi
801071c0:	0f 82 5a ff ff ff    	jb     80107120 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
801071c6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801071c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801071cc:	5b                   	pop    %ebx
801071cd:	5e                   	pop    %esi
801071ce:	5f                   	pop    %edi
801071cf:	5d                   	pop    %ebp
801071d0:	c3                   	ret
801071d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
801071d8:	83 ec 0c             	sub    $0xc,%esp
801071db:	53                   	push   %ebx
801071dc:	e8 9f b4 ff ff       	call   80102680 <kfree>
      goto bad;
801071e1:	83 c4 10             	add    $0x10,%esp
  freevm(d);
801071e4:	83 ec 0c             	sub    $0xc,%esp
801071e7:	ff 75 e0             	push   -0x20(%ebp)
801071ea:	e8 91 fd ff ff       	call   80106f80 <freevm>
  return 0;
801071ef:	83 c4 10             	add    $0x10,%esp
    return 0;
801071f2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
801071f9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801071fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801071ff:	5b                   	pop    %ebx
80107200:	5e                   	pop    %esi
80107201:	5f                   	pop    %edi
80107202:	5d                   	pop    %ebp
80107203:	c3                   	ret
      panic("copyuvm: page not present");
80107204:	83 ec 0c             	sub    $0xc,%esp
80107207:	68 26 78 10 80       	push   $0x80107826
8010720c:	e8 6f 91 ff ff       	call   80100380 <panic>
80107211:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107218:	00 
80107219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107220 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107220:	55                   	push   %ebp
80107221:	89 e5                	mov    %esp,%ebp
80107223:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107226:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107229:	89 c1                	mov    %eax,%ecx
8010722b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010722e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107231:	f6 c2 01             	test   $0x1,%dl
80107234:	0f 84 f8 00 00 00    	je     80107332 <uva2ka.cold>
  return &pgtab[PTX(va)];
8010723a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010723d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107243:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107244:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107249:	8b 94 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107250:	89 d0                	mov    %edx,%eax
80107252:	f7 d2                	not    %edx
80107254:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107259:	05 00 00 00 80       	add    $0x80000000,%eax
8010725e:	83 e2 05             	and    $0x5,%edx
80107261:	ba 00 00 00 00       	mov    $0x0,%edx
80107266:	0f 45 c2             	cmovne %edx,%eax
}
80107269:	c3                   	ret
8010726a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107270 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107270:	55                   	push   %ebp
80107271:	89 e5                	mov    %esp,%ebp
80107273:	57                   	push   %edi
80107274:	56                   	push   %esi
80107275:	53                   	push   %ebx
80107276:	83 ec 0c             	sub    $0xc,%esp
80107279:	8b 75 14             	mov    0x14(%ebp),%esi
8010727c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010727f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107282:	85 f6                	test   %esi,%esi
80107284:	75 51                	jne    801072d7 <copyout+0x67>
80107286:	e9 9d 00 00 00       	jmp    80107328 <copyout+0xb8>
8010728b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  return (char*)P2V(PTE_ADDR(*pte));
80107290:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107296:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
8010729c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
801072a2:	74 74                	je     80107318 <copyout+0xa8>
      return -1;
    n = PGSIZE - (va - va0);
801072a4:	89 fb                	mov    %edi,%ebx
801072a6:	29 c3                	sub    %eax,%ebx
801072a8:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
801072ae:	39 f3                	cmp    %esi,%ebx
801072b0:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801072b3:	29 f8                	sub    %edi,%eax
801072b5:	83 ec 04             	sub    $0x4,%esp
801072b8:	01 c1                	add    %eax,%ecx
801072ba:	53                   	push   %ebx
801072bb:	52                   	push   %edx
801072bc:	89 55 10             	mov    %edx,0x10(%ebp)
801072bf:	51                   	push   %ecx
801072c0:	e8 4b d6 ff ff       	call   80104910 <memmove>
    len -= n;
    buf += n;
801072c5:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
801072c8:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
801072ce:	83 c4 10             	add    $0x10,%esp
    buf += n;
801072d1:	01 da                	add    %ebx,%edx
  while(len > 0){
801072d3:	29 de                	sub    %ebx,%esi
801072d5:	74 51                	je     80107328 <copyout+0xb8>
  if(*pde & PTE_P){
801072d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
801072da:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
801072dc:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
801072de:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
801072e1:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
801072e7:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
801072ea:	f6 c1 01             	test   $0x1,%cl
801072ed:	0f 84 46 00 00 00    	je     80107339 <copyout.cold>
  return &pgtab[PTX(va)];
801072f3:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801072f5:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
801072fb:	c1 eb 0c             	shr    $0xc,%ebx
801072fe:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
80107304:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
8010730b:	89 d9                	mov    %ebx,%ecx
8010730d:	f7 d1                	not    %ecx
8010730f:	83 e1 05             	and    $0x5,%ecx
80107312:	0f 84 78 ff ff ff    	je     80107290 <copyout+0x20>
  }
  return 0;
}
80107318:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010731b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107320:	5b                   	pop    %ebx
80107321:	5e                   	pop    %esi
80107322:	5f                   	pop    %edi
80107323:	5d                   	pop    %ebp
80107324:	c3                   	ret
80107325:	8d 76 00             	lea    0x0(%esi),%esi
80107328:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010732b:	31 c0                	xor    %eax,%eax
}
8010732d:	5b                   	pop    %ebx
8010732e:	5e                   	pop    %esi
8010732f:	5f                   	pop    %edi
80107330:	5d                   	pop    %ebp
80107331:	c3                   	ret

80107332 <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
80107332:	a1 00 00 00 00       	mov    0x0,%eax
80107337:	0f 0b                	ud2

80107339 <copyout.cold>:
80107339:	a1 00 00 00 00       	mov    0x0,%eax
8010733e:	0f 0b                	ud2
