
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
80100028:	bc 10 56 11 80       	mov    $0x80115610,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 b0 32 10 80       	mov    $0x801032b0,%eax
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
8010004c:	68 e0 73 10 80       	push   $0x801073e0
80100051:	68 20 a5 10 80       	push   $0x8010a520
80100056:	e8 d5 45 00 00       	call   80104630 <initlock>
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
80100092:	68 e7 73 10 80       	push   $0x801073e7
80100097:	50                   	push   %eax
80100098:	e8 63 44 00 00       	call   80104500 <initsleeplock>
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
801000e4:	e8 37 47 00 00       	call   80104820 <acquire>
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
80100162:	e8 59 46 00 00       	call   801047c0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 ce 43 00 00       	call   80104540 <acquiresleep>
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
8010018c:	e8 af 23 00 00       	call   80102540 <iderw>
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
801001a1:	68 ee 73 10 80       	push   $0x801073ee
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
801001be:	e8 1d 44 00 00       	call   801045e0 <holdingsleep>
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
801001d4:	e9 67 23 00 00       	jmp    80102540 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 ff 73 10 80       	push   $0x801073ff
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
801001ff:	e8 dc 43 00 00       	call   801045e0 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 63                	je     8010026e <brelse+0x7e>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 8c 43 00 00       	call   801045a0 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010021b:	e8 00 46 00 00       	call   80104820 <acquire>
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
80100269:	e9 52 45 00 00       	jmp    801047c0 <release>
    panic("brelse");
8010026e:	83 ec 0c             	sub    $0xc,%esp
80100271:	68 06 74 10 80       	push   $0x80107406
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
80100294:	e8 57 18 00 00       	call   80101af0 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 60 f0 10 80 	movl   $0x8010f060,(%esp)
801002a0:	e8 7b 45 00 00       	call   80104820 <acquire>

  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>

    while(input.r == input.w){
801002b0:	a1 20 ef 10 80       	mov    0x8010ef20,%eax
801002b5:	39 05 24 ef 10 80    	cmp    %eax,0x8010ef24
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
801002c3:	68 60 f0 10 80       	push   $0x8010f060
801002c8:	68 20 ef 10 80       	push   $0x8010ef20
801002cd:	e8 ce 3f 00 00       	call   801042a0 <sleep>
    while(input.r == input.w){
801002d2:	a1 20 ef 10 80       	mov    0x8010ef20,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 24 ef 10 80    	cmp    0x8010ef24,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 f9 38 00 00       	call   80103be0 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 60 f0 10 80       	push   $0x8010f060
801002f6:	e8 c5 44 00 00       	call   801047c0 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 0c 17 00 00       	call   80101a10 <ilock>
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
8010031b:	89 15 20 ef 10 80    	mov    %edx,0x8010ef20
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a a0 ee 10 80 	movsbl -0x7fef1160(%edx),%ecx
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
80100347:	68 60 f0 10 80       	push   $0x8010f060
8010034c:	e8 6f 44 00 00       	call   801047c0 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 b6 16 00 00       	call   80101a10 <ilock>
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
8010036d:	a3 20 ef 10 80       	mov    %eax,0x8010ef20
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
80100389:	c7 05 94 f0 10 80 00 	movl   $0x0,0x8010f094
80100390:	00 00 00 
  getcallerpcs(&s, pcs);
80100393:	8d 5d d0             	lea    -0x30(%ebp),%ebx
80100396:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
80100399:	e8 b2 27 00 00       	call   80102b50 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 0d 74 10 80       	push   $0x8010740d
801003a7:	e8 94 03 00 00       	call   80100740 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	push   0x8(%ebp)
801003b0:	e8 8b 03 00 00       	call   80100740 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 8f 78 10 80 	movl   $0x8010788f,(%esp)
801003bc:	e8 7f 03 00 00       	call   80100740 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 83 42 00 00       	call   80104650 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003d8:	68 21 74 10 80       	push   $0x80107421
801003dd:	e8 5e 03 00 00       	call   80100740 <cprintf>
  for(i=0; i<10; i++)
801003e2:	83 c4 10             	add    $0x10,%esp
801003e5:	39 f3                	cmp    %esi,%ebx
801003e7:	75 e7                	jne    801003d0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003e9:	c7 05 98 f0 10 80 01 	movl   $0x1,0x8010f098
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
80100439:	0f 84 99 00 00 00    	je     801004d8 <cgaputc+0xd8>
  else if(c == BACKSPACE){
8010043f:	81 f9 00 01 00 00    	cmp    $0x100,%ecx
80100445:	74 79                	je     801004c0 <cgaputc+0xc0>
    crt[pos++] = (c&0xff) | attribute;
80100447:	0f b6 c9             	movzbl %cl,%ecx
8010044a:	66 0b 0d 00 80 10 80 	or     0x80108000,%cx
80100451:	8d 58 01             	lea    0x1(%eax),%ebx
80100454:	66 89 8c 00 00 80 0b 	mov    %cx,-0x7ff48000(%eax,%eax,1)
8010045b:	80 
  if(pos < 0 || pos > 25*80)
8010045c:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
80100462:	0f 8f ca 00 00 00    	jg     80100532 <cgaputc+0x132>
  if((pos/80) >= 24){  // Scroll up.
80100468:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
8010046e:	0f 8f 7c 00 00 00    	jg     801004f0 <cgaputc+0xf0>
  outb(CRTPORT+1, pos>>8);
80100474:	0f b6 c7             	movzbl %bh,%eax
  outb(CRTPORT+1, pos);
80100477:	89 df                	mov    %ebx,%edi
  crt[pos] = ' ' | 0x0700;
80100479:	8d b4 1b 00 80 0b 80 	lea    -0x7ff48000(%ebx,%ebx,1),%esi
  outb(CRTPORT+1, pos>>8);
80100480:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100483:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100488:	b8 0e 00 00 00       	mov    $0xe,%eax
8010048d:	89 da                	mov    %ebx,%edx
8010048f:	ee                   	out    %al,(%dx)
80100490:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100495:	0f b6 45 e4          	movzbl -0x1c(%ebp),%eax
80100499:	89 ca                	mov    %ecx,%edx
8010049b:	ee                   	out    %al,(%dx)
8010049c:	b8 0f 00 00 00       	mov    $0xf,%eax
801004a1:	89 da                	mov    %ebx,%edx
801004a3:	ee                   	out    %al,(%dx)
801004a4:	89 f8                	mov    %edi,%eax
801004a6:	89 ca                	mov    %ecx,%edx
801004a8:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004a9:	b8 20 07 00 00       	mov    $0x720,%eax
801004ae:	66 89 06             	mov    %ax,(%esi)
}
801004b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004b4:	5b                   	pop    %ebx
801004b5:	5e                   	pop    %esi
801004b6:	5f                   	pop    %edi
801004b7:	5d                   	pop    %ebp
801004b8:	c3                   	ret
801004b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(pos > 0) --pos;
801004c0:	8d 58 ff             	lea    -0x1(%eax),%ebx
801004c3:	85 c0                	test   %eax,%eax
801004c5:	75 95                	jne    8010045c <cgaputc+0x5c>
801004c7:	c6 45 e4 00          	movb   $0x0,-0x1c(%ebp)
801004cb:	be 00 80 0b 80       	mov    $0x800b8000,%esi
801004d0:	31 ff                	xor    %edi,%edi
801004d2:	eb af                	jmp    80100483 <cgaputc+0x83>
801004d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      pos += 80 - pos % 80;  // Move to the next line.
801004d8:	ba cd cc cc cc       	mov    $0xcccccccd,%edx
801004dd:	f7 e2                	mul    %edx
801004df:	c1 ea 06             	shr    $0x6,%edx
801004e2:	8d 04 92             	lea    (%edx,%edx,4),%eax
801004e5:	c1 e0 04             	shl    $0x4,%eax
801004e8:	8d 58 50             	lea    0x50(%eax),%ebx
801004eb:	e9 6c ff ff ff       	jmp    8010045c <cgaputc+0x5c>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004f0:	83 ec 04             	sub    $0x4,%esp
    pos -= 80;
801004f3:	8d 7b b0             	lea    -0x50(%ebx),%edi
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
801004f6:	8d b4 1b 60 7f 0b 80 	lea    -0x7ff480a0(%ebx,%ebx,1),%esi
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
801004fd:	68 60 0e 00 00       	push   $0xe60
80100502:	68 a0 80 0b 80       	push   $0x800b80a0
80100507:	68 00 80 0b 80       	push   $0x800b8000
8010050c:	e8 9f 44 00 00       	call   801049b0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100511:	b8 80 07 00 00       	mov    $0x780,%eax
80100516:	83 c4 0c             	add    $0xc,%esp
80100519:	29 f8                	sub    %edi,%eax
8010051b:	01 c0                	add    %eax,%eax
8010051d:	50                   	push   %eax
8010051e:	6a 00                	push   $0x0
80100520:	56                   	push   %esi
80100521:	e8 fa 43 00 00       	call   80104920 <memset>
  outb(CRTPORT+1, pos);
80100526:	83 c4 10             	add    $0x10,%esp
80100529:	c6 45 e4 07          	movb   $0x7,-0x1c(%ebp)
8010052d:	e9 51 ff ff ff       	jmp    80100483 <cgaputc+0x83>
    panic("pos under/overflow");
80100532:	83 ec 0c             	sub    $0xc,%esp
80100535:	68 25 74 10 80       	push   $0x80107425
8010053a:	e8 41 fe ff ff       	call   80100380 <panic>
8010053f:	90                   	nop

80100540 <consputc>:
  if (c == '\5') {
80100540:	83 f8 05             	cmp    $0x5,%eax
80100543:	74 3b                	je     80100580 <consputc+0x40>
  if (panicked) {
80100545:	8b 15 98 f0 10 80    	mov    0x8010f098,%edx
8010054b:	85 d2                	test   %edx,%edx
8010054d:	75 27                	jne    80100576 <consputc+0x36>
{
8010054f:	55                   	push   %ebp
80100550:	89 e5                	mov    %esp,%ebp
80100552:	53                   	push   %ebx
80100553:	89 c3                	mov    %eax,%ebx
80100555:	83 ec 04             	sub    $0x4,%esp
  if (c == BACKSPACE) {
80100558:	3d 00 01 00 00       	cmp    $0x100,%eax
8010055d:	74 55                	je     801005b4 <consputc+0x74>
    uartputc(c);
8010055f:	83 ec 0c             	sub    $0xc,%esp
80100562:	50                   	push   %eax
80100563:	e8 c8 59 00 00       	call   80105f30 <uartputc>
    cgaputc(c);
80100568:	83 c4 10             	add    $0x10,%esp
8010056b:	89 d8                	mov    %ebx,%eax
}
8010056d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100570:	c9                   	leave
    cgaputc(c);
80100571:	e9 8a fe ff ff       	jmp    80100400 <cgaputc>
  asm volatile("cli");
80100576:	fa                   	cli
    for (;;) ;
80100577:	eb fe                	jmp    80100577 <consputc+0x37>
80100579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if (!stat) {
80100580:	8b 0d 40 f0 10 80    	mov    0x8010f040,%ecx
80100586:	85 c9                	test   %ecx,%ecx
80100588:	75 15                	jne    8010059f <consputc+0x5f>
      stat = 1 ;
8010058a:	c7 05 40 f0 10 80 01 	movl   $0x1,0x8010f040
80100591:	00 00 00 
      attribute = 0x7100 ;
80100594:	c7 05 00 80 10 80 00 	movl   $0x7100,0x80108000
8010059b:	71 00 00 
8010059e:	c3                   	ret
      stat = 0 ;
8010059f:	c7 05 40 f0 10 80 00 	movl   $0x0,0x8010f040
801005a6:	00 00 00 
      attribute = 0x0700;
801005a9:	c7 05 00 80 10 80 00 	movl   $0x700,0x80108000
801005b0:	07 00 00 
801005b3:	c3                   	ret
    uartputc('\b');
801005b4:	83 ec 0c             	sub    $0xc,%esp
801005b7:	6a 08                	push   $0x8
801005b9:	e8 72 59 00 00       	call   80105f30 <uartputc>
    uartputc(' ');
801005be:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801005c5:	e8 66 59 00 00       	call   80105f30 <uartputc>
    uartputc('\b');
801005ca:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801005d1:	e8 5a 59 00 00       	call   80105f30 <uartputc>
}
801005d6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    cgaputc(c);
801005d9:	83 c4 10             	add    $0x10,%esp
801005dc:	b8 00 01 00 00       	mov    $0x100,%eax
}
801005e1:	c9                   	leave
    cgaputc(c);
801005e2:	e9 19 fe ff ff       	jmp    80100400 <cgaputc>
801005e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801005ee:	00 
801005ef:	90                   	nop

801005f0 <printint>:
{
801005f0:	55                   	push   %ebp
801005f1:	89 e5                	mov    %esp,%ebp
801005f3:	57                   	push   %edi
801005f4:	56                   	push   %esi
801005f5:	53                   	push   %ebx
801005f6:	89 d3                	mov    %edx,%ebx
801005f8:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
801005fb:	85 c0                	test   %eax,%eax
801005fd:	79 05                	jns    80100604 <printint+0x14>
801005ff:	83 e1 01             	and    $0x1,%ecx
80100602:	75 64                	jne    80100668 <printint+0x78>
    x = xx;
80100604:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
8010060b:	89 c1                	mov    %eax,%ecx
  i = 0;
8010060d:	31 f6                	xor    %esi,%esi
8010060f:	90                   	nop
    buf[i++] = digits[x % base];
80100610:	89 c8                	mov    %ecx,%eax
80100612:	31 d2                	xor    %edx,%edx
80100614:	89 f7                	mov    %esi,%edi
80100616:	f7 f3                	div    %ebx
80100618:	8d 76 01             	lea    0x1(%esi),%esi
8010061b:	0f b6 92 30 79 10 80 	movzbl -0x7fef86d0(%edx),%edx
80100622:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
80100626:	89 ca                	mov    %ecx,%edx
80100628:	89 c1                	mov    %eax,%ecx
8010062a:	39 da                	cmp    %ebx,%edx
8010062c:	73 e2                	jae    80100610 <printint+0x20>
  if(sign)
8010062e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80100631:	85 c0                	test   %eax,%eax
80100633:	74 07                	je     8010063c <printint+0x4c>
    buf[i++] = '-';
80100635:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
  while(--i >= 0)
8010063a:	89 f7                	mov    %esi,%edi
8010063c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
8010063f:	01 df                	add    %ebx,%edi
80100641:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    consputc(buf[i]);
80100648:	0f be 07             	movsbl (%edi),%eax
8010064b:	e8 f0 fe ff ff       	call   80100540 <consputc>
  while(--i >= 0)
80100650:	89 f8                	mov    %edi,%eax
80100652:	83 ef 01             	sub    $0x1,%edi
80100655:	39 d8                	cmp    %ebx,%eax
80100657:	75 ef                	jne    80100648 <printint+0x58>
}
80100659:	83 c4 2c             	add    $0x2c,%esp
8010065c:	5b                   	pop    %ebx
8010065d:	5e                   	pop    %esi
8010065e:	5f                   	pop    %edi
8010065f:	5d                   	pop    %ebp
80100660:	c3                   	ret
80100661:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    x = -xx;
80100668:	f7 d8                	neg    %eax
  if(sign && (sign = xx < 0))
8010066a:	c7 45 d4 01 00 00 00 	movl   $0x1,-0x2c(%ebp)
    x = -xx;
80100671:	89 c1                	mov    %eax,%ecx
80100673:	eb 98                	jmp    8010060d <printint+0x1d>
80100675:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010067c:	00 
8010067d:	8d 76 00             	lea    0x0(%esi),%esi

80100680 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100680:	55                   	push   %ebp
80100681:	89 e5                	mov    %esp,%ebp
80100683:	57                   	push   %edi
80100684:	56                   	push   %esi
80100685:	53                   	push   %ebx
80100686:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100689:	ff 75 08             	push   0x8(%ebp)
8010068c:	e8 5f 14 00 00       	call   80101af0 <iunlock>
  acquire(&cons.lock);
80100691:	c7 04 24 60 f0 10 80 	movl   $0x8010f060,(%esp)
80100698:	e8 83 41 00 00       	call   80104820 <acquire>
  for(i = 0; i < n; i++){
8010069d:	8b 5d 10             	mov    0x10(%ebp),%ebx
801006a0:	83 c4 10             	add    $0x10,%esp
801006a3:	85 db                	test   %ebx,%ebx
801006a5:	7e 3b                	jle    801006e2 <consolewrite+0x62>
801006a7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
801006aa:	8b 7d 10             	mov    0x10(%ebp),%edi
801006ad:	01 df                	add    %ebx,%edi
    consputc(buf[i] & 0xff);
801006af:	0f b6 33             	movzbl (%ebx),%esi
  if (c == '\5') {
801006b2:	83 fe 05             	cmp    $0x5,%esi
801006b5:	74 4c                	je     80100703 <consolewrite+0x83>
  if (panicked) {
801006b7:	8b 15 98 f0 10 80    	mov    0x8010f098,%edx
801006bd:	85 d2                	test   %edx,%edx
801006bf:	74 07                	je     801006c8 <consolewrite+0x48>
801006c1:	fa                   	cli
    for (;;) ;
801006c2:	eb fe                	jmp    801006c2 <consolewrite+0x42>
801006c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartputc(c);
801006c8:	83 ec 0c             	sub    $0xc,%esp
801006cb:	56                   	push   %esi
801006cc:	e8 5f 58 00 00       	call   80105f30 <uartputc>
    cgaputc(c);
801006d1:	89 f0                	mov    %esi,%eax
801006d3:	e8 28 fd ff ff       	call   80100400 <cgaputc>
801006d8:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
801006db:	83 c3 01             	add    $0x1,%ebx
801006de:	39 fb                	cmp    %edi,%ebx
801006e0:	75 cd                	jne    801006af <consolewrite+0x2f>
  }
  release(&cons.lock);
801006e2:	83 ec 0c             	sub    $0xc,%esp
801006e5:	68 60 f0 10 80       	push   $0x8010f060
801006ea:	e8 d1 40 00 00       	call   801047c0 <release>
  ilock(ip);
801006ef:	58                   	pop    %eax
801006f0:	ff 75 08             	push   0x8(%ebp)
801006f3:	e8 18 13 00 00       	call   80101a10 <ilock>

  return n;
}
801006f8:	8b 45 10             	mov    0x10(%ebp),%eax
801006fb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801006fe:	5b                   	pop    %ebx
801006ff:	5e                   	pop    %esi
80100700:	5f                   	pop    %edi
80100701:	5d                   	pop    %ebp
80100702:	c3                   	ret
    if (!stat) {
80100703:	8b 0d 40 f0 10 80    	mov    0x8010f040,%ecx
80100709:	85 c9                	test   %ecx,%ecx
8010070b:	75 16                	jne    80100723 <consolewrite+0xa3>
      stat = 1 ;
8010070d:	c7 05 40 f0 10 80 01 	movl   $0x1,0x8010f040
80100714:	00 00 00 
      attribute = 0x7100 ;
80100717:	c7 05 00 80 10 80 00 	movl   $0x7100,0x80108000
8010071e:	71 00 00 
80100721:	eb b8                	jmp    801006db <consolewrite+0x5b>
      stat = 0 ;
80100723:	c7 05 40 f0 10 80 00 	movl   $0x0,0x8010f040
8010072a:	00 00 00 
      attribute = 0x0700;
8010072d:	c7 05 00 80 10 80 00 	movl   $0x700,0x80108000
80100734:	07 00 00 
80100737:	eb a2                	jmp    801006db <consolewrite+0x5b>
80100739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100740 <cprintf>:
{
80100740:	55                   	push   %ebp
80100741:	89 e5                	mov    %esp,%ebp
80100743:	57                   	push   %edi
80100744:	56                   	push   %esi
80100745:	53                   	push   %ebx
80100746:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100749:	8b 3d 94 f0 10 80    	mov    0x8010f094,%edi
  if (fmt == 0)
8010074f:	8b 75 08             	mov    0x8(%ebp),%esi
  if(locking)
80100752:	85 ff                	test   %edi,%edi
80100754:	0f 85 76 01 00 00    	jne    801008d0 <cprintf+0x190>
  if (fmt == 0)
8010075a:	85 f6                	test   %esi,%esi
8010075c:	0f 84 a5 01 00 00    	je     80100907 <cprintf+0x1c7>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100762:	0f b6 06             	movzbl (%esi),%eax
80100765:	85 c0                	test   %eax,%eax
80100767:	74 5d                	je     801007c6 <cprintf+0x86>
80100769:	89 7d e0             	mov    %edi,-0x20(%ebp)
  argp = (uint*)(void*)(&fmt + 1);
8010076c:	8d 55 0c             	lea    0xc(%ebp),%edx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010076f:	31 db                	xor    %ebx,%ebx
    if(c != '%'){
80100771:	83 f8 25             	cmp    $0x25,%eax
80100774:	75 5a                	jne    801007d0 <cprintf+0x90>
    c = fmt[++i] & 0xff;
80100776:	83 c3 01             	add    $0x1,%ebx
80100779:	0f b6 3c 1e          	movzbl (%esi,%ebx,1),%edi
    if(c == 0)
8010077d:	85 ff                	test   %edi,%edi
8010077f:	74 3a                	je     801007bb <cprintf+0x7b>
    switch(c){
80100781:	83 ff 70             	cmp    $0x70,%edi
80100784:	74 7a                	je     80100800 <cprintf+0xc0>
80100786:	7f 58                	jg     801007e0 <cprintf+0xa0>
80100788:	83 ff 25             	cmp    $0x25,%edi
8010078b:	0f 84 c7 00 00 00    	je     80100858 <cprintf+0x118>
80100791:	83 ff 64             	cmp    $0x64,%edi
80100794:	75 54                	jne    801007ea <cprintf+0xaa>
      printint(*argp++, 10, 1);
80100796:	8b 02                	mov    (%edx),%eax
80100798:	8d 7a 04             	lea    0x4(%edx),%edi
8010079b:	b9 01 00 00 00       	mov    $0x1,%ecx
801007a0:	ba 0a 00 00 00       	mov    $0xa,%edx
801007a5:	e8 46 fe ff ff       	call   801005f0 <printint>
801007aa:	89 fa                	mov    %edi,%edx
801007ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801007b0:	83 c3 01             	add    $0x1,%ebx
801007b3:	0f b6 04 1e          	movzbl (%esi,%ebx,1),%eax
801007b7:	85 c0                	test   %eax,%eax
801007b9:	75 b6                	jne    80100771 <cprintf+0x31>
801007bb:	8b 7d e0             	mov    -0x20(%ebp),%edi
  if(locking)
801007be:	85 ff                	test   %edi,%edi
801007c0:	0f 85 29 01 00 00    	jne    801008ef <cprintf+0x1af>
}
801007c6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801007c9:	5b                   	pop    %ebx
801007ca:	5e                   	pop    %esi
801007cb:	5f                   	pop    %edi
801007cc:	5d                   	pop    %ebp
801007cd:	c3                   	ret
801007ce:	66 90                	xchg   %ax,%ax
801007d0:	89 55 e4             	mov    %edx,-0x1c(%ebp)
      consputc(c);
801007d3:	e8 68 fd ff ff       	call   80100540 <consputc>
      continue;
801007d8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801007db:	eb d3                	jmp    801007b0 <cprintf+0x70>
801007dd:	8d 76 00             	lea    0x0(%esi),%esi
    switch(c){
801007e0:	83 ff 73             	cmp    $0x73,%edi
801007e3:	74 33                	je     80100818 <cprintf+0xd8>
801007e5:	83 ff 78             	cmp    $0x78,%edi
801007e8:	74 16                	je     80100800 <cprintf+0xc0>
  if (panicked) {
801007ea:	a1 98 f0 10 80       	mov    0x8010f098,%eax
801007ef:	85 c0                	test   %eax,%eax
801007f1:	0f 84 a9 00 00 00    	je     801008a0 <cprintf+0x160>
801007f7:	fa                   	cli
    for (;;) ;
801007f8:	eb fe                	jmp    801007f8 <cprintf+0xb8>
801007fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      printint(*argp++, 16, 0);
80100800:	8b 02                	mov    (%edx),%eax
80100802:	8d 7a 04             	lea    0x4(%edx),%edi
80100805:	31 c9                	xor    %ecx,%ecx
80100807:	ba 10 00 00 00       	mov    $0x10,%edx
8010080c:	e8 df fd ff ff       	call   801005f0 <printint>
80100811:	89 fa                	mov    %edi,%edx
      break;
80100813:	eb 9b                	jmp    801007b0 <cprintf+0x70>
80100815:	8d 76 00             	lea    0x0(%esi),%esi
      if((s = (char*)*argp++) == 0)
80100818:	8b 3a                	mov    (%edx),%edi
8010081a:	8d 4a 04             	lea    0x4(%edx),%ecx
8010081d:	85 ff                	test   %edi,%edi
8010081f:	75 69                	jne    8010088a <cprintf+0x14a>
        s = "(null)";
80100821:	bf 38 74 10 80       	mov    $0x80107438,%edi
80100826:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100829:	b8 28 00 00 00       	mov    $0x28,%eax
8010082e:	89 fb                	mov    %edi,%ebx
80100830:	89 cf                	mov    %ecx,%edi
80100832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        consputc(*s);
80100838:	e8 03 fd ff ff       	call   80100540 <consputc>
      for(; *s; s++)
8010083d:	0f be 43 01          	movsbl 0x1(%ebx),%eax
80100841:	83 c3 01             	add    $0x1,%ebx
80100844:	84 c0                	test   %al,%al
80100846:	75 f0                	jne    80100838 <cprintf+0xf8>
      if((s = (char*)*argp++) == 0)
80100848:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
8010084b:	89 fa                	mov    %edi,%edx
8010084d:	e9 5e ff ff ff       	jmp    801007b0 <cprintf+0x70>
80100852:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if (panicked) {
80100858:	8b 0d 98 f0 10 80    	mov    0x8010f098,%ecx
8010085e:	85 c9                	test   %ecx,%ecx
80100860:	74 06                	je     80100868 <cprintf+0x128>
80100862:	fa                   	cli
    for (;;) ;
80100863:	eb fe                	jmp    80100863 <cprintf+0x123>
80100865:	8d 76 00             	lea    0x0(%esi),%esi
    uartputc(c);
80100868:	83 ec 0c             	sub    $0xc,%esp
8010086b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010086e:	6a 25                	push   $0x25
80100870:	e8 bb 56 00 00       	call   80105f30 <uartputc>
    cgaputc(c);
80100875:	b8 25 00 00 00       	mov    $0x25,%eax
8010087a:	e8 81 fb ff ff       	call   80100400 <cgaputc>
      break;
8010087f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    cgaputc(c);
80100882:	83 c4 10             	add    $0x10,%esp
80100885:	e9 26 ff ff ff       	jmp    801007b0 <cprintf+0x70>
      for(; *s; s++)
8010088a:	0f be 07             	movsbl (%edi),%eax
      if((s = (char*)*argp++) == 0)
8010088d:	89 ca                	mov    %ecx,%edx
      for(; *s; s++)
8010088f:	84 c0                	test   %al,%al
80100891:	0f 84 19 ff ff ff    	je     801007b0 <cprintf+0x70>
80100897:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
8010089a:	89 fb                	mov    %edi,%ebx
8010089c:	89 cf                	mov    %ecx,%edi
8010089e:	eb 98                	jmp    80100838 <cprintf+0xf8>
    uartputc(c);
801008a0:	83 ec 0c             	sub    $0xc,%esp
801008a3:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801008a6:	6a 25                	push   $0x25
801008a8:	e8 83 56 00 00       	call   80105f30 <uartputc>
    cgaputc(c);
801008ad:	b8 25 00 00 00       	mov    $0x25,%eax
801008b2:	e8 49 fb ff ff       	call   80100400 <cgaputc>
      consputc(c);
801008b7:	89 f8                	mov    %edi,%eax
801008b9:	e8 82 fc ff ff       	call   80100540 <consputc>
      break;
801008be:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801008c1:	83 c4 10             	add    $0x10,%esp
801008c4:	e9 e7 fe ff ff       	jmp    801007b0 <cprintf+0x70>
801008c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801008d0:	83 ec 0c             	sub    $0xc,%esp
801008d3:	68 60 f0 10 80       	push   $0x8010f060
801008d8:	e8 43 3f 00 00       	call   80104820 <acquire>
  if (fmt == 0)
801008dd:	83 c4 10             	add    $0x10,%esp
801008e0:	85 f6                	test   %esi,%esi
801008e2:	74 23                	je     80100907 <cprintf+0x1c7>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801008e4:	0f b6 06             	movzbl (%esi),%eax
801008e7:	85 c0                	test   %eax,%eax
801008e9:	0f 85 7a fe ff ff    	jne    80100769 <cprintf+0x29>
    release(&cons.lock);
801008ef:	83 ec 0c             	sub    $0xc,%esp
801008f2:	68 60 f0 10 80       	push   $0x8010f060
801008f7:	e8 c4 3e 00 00       	call   801047c0 <release>
801008fc:	83 c4 10             	add    $0x10,%esp
}
801008ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100902:	5b                   	pop    %ebx
80100903:	5e                   	pop    %esi
80100904:	5f                   	pop    %edi
80100905:	5d                   	pop    %ebp
80100906:	c3                   	ret
    panic("null fmt");
80100907:	83 ec 0c             	sub    $0xc,%esp
8010090a:	68 3f 74 10 80       	push   $0x8010743f
8010090f:	e8 6c fa ff ff       	call   80100380 <panic>
80100914:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010091b:	00 
8010091c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100920 <reverse_buff>:
  for (int i = 0; i < select_in; i++)
80100920:	8b 0d 88 ee 10 80    	mov    0x8010ee88,%ecx
80100926:	85 c9                	test   %ecx,%ecx
80100928:	74 3e                	je     80100968 <reverse_buff+0x48>
void reverse_buff(){
8010092a:	55                   	push   %ebp
8010092b:	31 c0                	xor    %eax,%eax
8010092d:	89 e5                	mov    %esp,%ebp
8010092f:	53                   	push   %ebx
80100930:	8d 99 c0 ef 10 80    	lea    -0x7fef1040(%ecx),%ebx
80100936:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010093d:	00 
8010093e:	66 90                	xchg   %ax,%ax
    reversed_buffer[i] = selected_buffer[select_in-1-i];
80100940:	89 c2                	mov    %eax,%edx
  for (int i = 0; i < select_in; i++)
80100942:	83 c0 01             	add    $0x1,%eax
    reversed_buffer[i] = selected_buffer[select_in-1-i];
80100945:	f7 da                	neg    %edx
80100947:	0f b6 54 13 ff       	movzbl -0x1(%ebx,%edx,1),%edx
8010094c:	88 90 3f ef 10 80    	mov    %dl,-0x7fef10c1(%eax)
  for (int i = 0; i < select_in; i++)
80100952:	39 c8                	cmp    %ecx,%eax
80100954:	75 ea                	jne    80100940 <reverse_buff+0x20>
  reversed_buffer[select_in] = '\0';
80100956:	c6 81 40 ef 10 80 00 	movb   $0x0,-0x7fef10c0(%ecx)
}
8010095d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100960:	c9                   	leave
80100961:	c3                   	ret
80100962:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  reversed_buffer[select_in] = '\0';
80100968:	c6 81 40 ef 10 80 00 	movb   $0x0,-0x7fef10c0(%ecx)
8010096f:	c3                   	ret

80100970 <consoleintr>:
void consoleintr(int (*getc)(void)) {
80100970:	55                   	push   %ebp
80100971:	89 e5                	mov    %esp,%ebp
80100973:	57                   	push   %edi
  int c, doprocdump = 0;
80100974:	31 ff                	xor    %edi,%edi
void consoleintr(int (*getc)(void)) {
80100976:	56                   	push   %esi
80100977:	53                   	push   %ebx
80100978:	83 ec 18             	sub    $0x18,%esp
8010097b:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&cons.lock);
8010097e:	68 60 f0 10 80       	push   $0x8010f060
80100983:	e8 98 3e 00 00       	call   80104820 <acquire>
  while ((c = getc()) >= 0) {
80100988:	83 c4 10             	add    $0x10,%esp
8010098b:	ff d6                	call   *%esi
8010098d:	89 c3                	mov    %eax,%ebx
8010098f:	85 c0                	test   %eax,%eax
80100991:	0f 88 99 01 00 00    	js     80100b30 <consoleintr+0x1c0>
    switch (c) {
80100997:	83 fb 16             	cmp    $0x16,%ebx
8010099a:	7f 14                	jg     801009b0 <consoleintr+0x40>
8010099c:	83 fb 02             	cmp    $0x2,%ebx
8010099f:	7e 6f                	jle    80100a10 <consoleintr+0xa0>
801009a1:	8d 43 fd             	lea    -0x3(%ebx),%eax
801009a4:	83 f8 13             	cmp    $0x13,%eax
801009a7:	77 67                	ja     80100a10 <consoleintr+0xa0>
801009a9:	ff 24 85 e0 78 10 80 	jmp    *-0x7fef8720(,%eax,4)
801009b0:	81 fb 4b e0 00 00    	cmp    $0xe04b,%ebx
801009b6:	0f 85 b8 00 00 00    	jne    80100a74 <consoleintr+0x104>
        if (input.e > input.w && select_e > input.w) {
801009bc:	a1 24 ef 10 80       	mov    0x8010ef24,%eax
801009c1:	3b 05 28 ef 10 80    	cmp    0x8010ef28,%eax
801009c7:	73 c2                	jae    8010098b <consoleintr+0x1b>
801009c9:	8b 15 84 ee 10 80    	mov    0x8010ee84,%edx
801009cf:	39 d0                	cmp    %edx,%eax
801009d1:	73 b8                	jae    8010098b <consoleintr+0x1b>
          if (copy_mode){
801009d3:	8b 0d 80 ee 10 80    	mov    0x8010ee80,%ecx
          select_e--;
801009d9:	83 ea 01             	sub    $0x1,%edx
801009dc:	89 15 84 ee 10 80    	mov    %edx,0x8010ee84
          if (copy_mode){
801009e2:	85 c9                	test   %ecx,%ecx
801009e4:	74 a5                	je     8010098b <consoleintr+0x1b>
            selected_buffer[select_in++] = input.buf[select_e % INPUT_BUF];
801009e6:	a1 88 ee 10 80       	mov    0x8010ee88,%eax
801009eb:	83 e2 7f             	and    $0x7f,%edx
801009ee:	0f b6 92 a0 ee 10 80 	movzbl -0x7fef1160(%edx),%edx
801009f5:	8d 48 01             	lea    0x1(%eax),%ecx
801009f8:	89 0d 88 ee 10 80    	mov    %ecx,0x8010ee88
801009fe:	88 90 c0 ef 10 80    	mov    %dl,-0x7fef1040(%eax)
80100a04:	eb 85                	jmp    8010098b <consoleintr+0x1b>
80100a06:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100a0d:	00 
80100a0e:	66 90                	xchg   %ax,%ax
        if (c != 0 && input.e - input.r < INPUT_BUF) {
80100a10:	85 db                	test   %ebx,%ebx
80100a12:	0f 84 73 ff ff ff    	je     8010098b <consoleintr+0x1b>
80100a18:	a1 28 ef 10 80       	mov    0x8010ef28,%eax
80100a1d:	89 c2                	mov    %eax,%edx
80100a1f:	2b 15 20 ef 10 80    	sub    0x8010ef20,%edx
80100a25:	83 fa 7f             	cmp    $0x7f,%edx
80100a28:	0f 87 5d ff ff ff    	ja     8010098b <consoleintr+0x1b>
          input.buf[input.e++ % INPUT_BUF] = c;
80100a2e:	8d 50 01             	lea    0x1(%eax),%edx
80100a31:	83 e0 7f             	and    $0x7f,%eax
          c = (c == '\r') ? '\n' : c;
80100a34:	83 fb 0d             	cmp    $0xd,%ebx
80100a37:	75 57                	jne    80100a90 <consoleintr+0x120>
          input.buf[input.e++ % INPUT_BUF] = c;
80100a39:	c6 80 a0 ee 10 80 0a 	movb   $0xa,-0x7fef1160(%eax)
          consputc(c);
80100a40:	b8 0a 00 00 00       	mov    $0xa,%eax
          input.buf[input.e++ % INPUT_BUF] = c;
80100a45:	89 15 28 ef 10 80    	mov    %edx,0x8010ef28
          consputc(c);
80100a4b:	e8 f0 fa ff ff       	call   80100540 <consputc>
          select_e = input.e ;
80100a50:	a1 28 ef 10 80       	mov    0x8010ef28,%eax
80100a55:	a3 84 ee 10 80       	mov    %eax,0x8010ee84
            wakeup(&input.r);
80100a5a:	83 ec 0c             	sub    $0xc,%esp
            input.w = input.e;
80100a5d:	a3 24 ef 10 80       	mov    %eax,0x8010ef24
            wakeup(&input.r);
80100a62:	68 20 ef 10 80       	push   $0x8010ef20
80100a67:	e8 f4 38 00 00       	call   80104360 <wakeup>
80100a6c:	83 c4 10             	add    $0x10,%esp
80100a6f:	e9 17 ff ff ff       	jmp    8010098b <consoleintr+0x1b>
        if (c != 0 && input.e - input.r < INPUT_BUF) {
80100a74:	a1 28 ef 10 80       	mov    0x8010ef28,%eax
80100a79:	89 c2                	mov    %eax,%edx
80100a7b:	2b 15 20 ef 10 80    	sub    0x8010ef20,%edx
80100a81:	83 fa 7f             	cmp    $0x7f,%edx
80100a84:	0f 87 01 ff ff ff    	ja     8010098b <consoleintr+0x1b>
          input.buf[input.e++ % INPUT_BUF] = c;
80100a8a:	8d 50 01             	lea    0x1(%eax),%edx
80100a8d:	83 e0 7f             	and    $0x7f,%eax
80100a90:	88 98 a0 ee 10 80    	mov    %bl,-0x7fef1160(%eax)
          consputc(c);
80100a96:	89 d8                	mov    %ebx,%eax
          input.buf[input.e++ % INPUT_BUF] = c;
80100a98:	89 15 28 ef 10 80    	mov    %edx,0x8010ef28
          consputc(c);
80100a9e:	e8 9d fa ff ff       	call   80100540 <consputc>
          select_e = input.e ;
80100aa3:	a1 28 ef 10 80       	mov    0x8010ef28,%eax
80100aa8:	a3 84 ee 10 80       	mov    %eax,0x8010ee84
          if (c == '\n' || c == C('D') || input.e == input.r + INPUT_BUF) {
80100aad:	83 fb 0a             	cmp    $0xa,%ebx
80100ab0:	74 a8                	je     80100a5a <consoleintr+0xea>
80100ab2:	83 fb 04             	cmp    $0x4,%ebx
80100ab5:	74 a3                	je     80100a5a <consoleintr+0xea>
80100ab7:	8b 0d 20 ef 10 80    	mov    0x8010ef20,%ecx
80100abd:	8d 91 80 00 00 00    	lea    0x80(%ecx),%edx
80100ac3:	39 d0                	cmp    %edx,%eax
80100ac5:	0f 85 c0 fe ff ff    	jne    8010098b <consoleintr+0x1b>
80100acb:	eb 8d                	jmp    80100a5a <consoleintr+0xea>
80100acd:	8d 76 00             	lea    0x0(%esi),%esi
        while(reversed_buffer[i] != '\0'){
80100ad0:	0f b6 15 40 ef 10 80 	movzbl 0x8010ef40,%edx
        while (input.e != input.w && input.buf[(input.e) % INPUT_BUF] != '\n') {
80100ad7:	a1 28 ef 10 80       	mov    0x8010ef28,%eax
        int i=0;
80100adc:	31 db                	xor    %ebx,%ebx
        while(reversed_buffer[i] != '\0'){
80100ade:	84 d2                	test   %dl,%dl
80100ae0:	0f 84 a5 fe ff ff    	je     8010098b <consoleintr+0x1b>
80100ae6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100aed:	00 
80100aee:	66 90                	xchg   %ax,%ax
          input.buf[input.e++ % INPUT_BUF] = reversed_buffer[i];
80100af0:	8d 48 01             	lea    0x1(%eax),%ecx
80100af3:	83 e0 7f             	and    $0x7f,%eax
          i++;
80100af6:	83 c3 01             	add    $0x1,%ebx
          input.buf[input.e++ % INPUT_BUF] = reversed_buffer[i];
80100af9:	88 90 a0 ee 10 80    	mov    %dl,-0x7fef1160(%eax)
          consputc(reversed_buffer[i]);
80100aff:	0f be c2             	movsbl %dl,%eax
          input.buf[input.e++ % INPUT_BUF] = reversed_buffer[i];
80100b02:	89 0d 28 ef 10 80    	mov    %ecx,0x8010ef28
          consputc(reversed_buffer[i]);
80100b08:	e8 33 fa ff ff       	call   80100540 <consputc>
          select_e = input.e ;
80100b0d:	a1 28 ef 10 80       	mov    0x8010ef28,%eax
        while(reversed_buffer[i] != '\0'){
80100b12:	0f b6 93 40 ef 10 80 	movzbl -0x7fef10c0(%ebx),%edx
          select_e = input.e ;
80100b19:	a3 84 ee 10 80       	mov    %eax,0x8010ee84
        while(reversed_buffer[i] != '\0'){
80100b1e:	84 d2                	test   %dl,%dl
80100b20:	75 ce                	jne    80100af0 <consoleintr+0x180>
  while ((c = getc()) >= 0) {
80100b22:	ff d6                	call   *%esi
80100b24:	89 c3                	mov    %eax,%ebx
80100b26:	85 c0                	test   %eax,%eax
80100b28:	0f 89 69 fe ff ff    	jns    80100997 <consoleintr+0x27>
80100b2e:	66 90                	xchg   %ax,%ax
  release(&cons.lock);
80100b30:	83 ec 0c             	sub    $0xc,%esp
80100b33:	68 60 f0 10 80       	push   $0x8010f060
80100b38:	e8 83 3c 00 00       	call   801047c0 <release>
  if (doprocdump) {
80100b3d:	83 c4 10             	add    $0x10,%esp
80100b40:	85 ff                	test   %edi,%edi
80100b42:	0f 85 7a 01 00 00    	jne    80100cc2 <consoleintr+0x352>
}
80100b48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100b4b:	5b                   	pop    %ebx
80100b4c:	5e                   	pop    %esi
80100b4d:	5f                   	pop    %edi
80100b4e:	5d                   	pop    %ebp
80100b4f:	c3                   	ret
        while (input.e != input.w && input.buf[(input.e) % INPUT_BUF] != '\n') {
80100b50:	a1 28 ef 10 80       	mov    0x8010ef28,%eax
80100b55:	39 05 24 ef 10 80    	cmp    %eax,0x8010ef24
80100b5b:	0f 84 2a fe ff ff    	je     8010098b <consoleintr+0x1b>
80100b61:	89 c2                	mov    %eax,%edx
80100b63:	83 e2 7f             	and    $0x7f,%edx
80100b66:	80 ba a0 ee 10 80 0a 	cmpb   $0xa,-0x7fef1160(%edx)
80100b6d:	0f 84 18 fe ff ff    	je     8010098b <consoleintr+0x1b>
          input.e--;
80100b73:	83 e8 01             	sub    $0x1,%eax
80100b76:	a3 28 ef 10 80       	mov    %eax,0x8010ef28
          select_e = input.e ;
80100b7b:	a3 84 ee 10 80       	mov    %eax,0x8010ee84
  if (panicked) {
80100b80:	a1 98 f0 10 80       	mov    0x8010f098,%eax
80100b85:	85 c0                	test   %eax,%eax
80100b87:	74 76                	je     80100bff <consoleintr+0x28f>
80100b89:	fa                   	cli
    for (;;) ;
80100b8a:	eb fe                	jmp    80100b8a <consoleintr+0x21a>
80100b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if (panicked) {
80100b90:	8b 1d 98 f0 10 80    	mov    0x8010f098,%ebx
80100b96:	85 db                	test   %ebx,%ebx
80100b98:	0f 84 c3 00 00 00    	je     80100c61 <consoleintr+0x2f1>
80100b9e:	fa                   	cli
    for (;;) ;
80100b9f:	eb fe                	jmp    80100b9f <consoleintr+0x22f>
80100ba1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if (!stat) {
80100ba8:	a1 40 f0 10 80       	mov    0x8010f040,%eax
80100bad:	85 c0                	test   %eax,%eax
80100baf:	0f 85 93 00 00 00    	jne    80100c48 <consoleintr+0x2d8>
          stat = 1 ;
80100bb5:	c7 05 40 f0 10 80 01 	movl   $0x1,0x8010f040
80100bbc:	00 00 00 
          attribute = 0x7100 ;
80100bbf:	c7 05 00 80 10 80 00 	movl   $0x7100,0x80108000
80100bc6:	71 00 00 
80100bc9:	e9 bd fd ff ff       	jmp    8010098b <consoleintr+0x1b>
        if (!copy_mode)
80100bce:	8b 15 80 ee 10 80    	mov    0x8010ee80,%edx
80100bd4:	85 d2                	test   %edx,%edx
80100bd6:	0f 85 a1 00 00 00    	jne    80100c7d <consoleintr+0x30d>
          copy_mode = 1 ;
80100bdc:	c7 05 80 ee 10 80 01 	movl   $0x1,0x8010ee80
80100be3:	00 00 00 
          select_in = 0 ;
80100be6:	c7 05 88 ee 10 80 00 	movl   $0x0,0x8010ee88
80100bed:	00 00 00 
80100bf0:	e9 96 fd ff ff       	jmp    8010098b <consoleintr+0x1b>
    switch (c) {
80100bf5:	bf 01 00 00 00       	mov    $0x1,%edi
80100bfa:	e9 8c fd ff ff       	jmp    8010098b <consoleintr+0x1b>
    uartputc('\b');
80100bff:	83 ec 0c             	sub    $0xc,%esp
80100c02:	6a 08                	push   $0x8
80100c04:	e8 27 53 00 00       	call   80105f30 <uartputc>
    uartputc(' ');
80100c09:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100c10:	e8 1b 53 00 00       	call   80105f30 <uartputc>
    uartputc('\b');
80100c15:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100c1c:	e8 0f 53 00 00       	call   80105f30 <uartputc>
    cgaputc(c);
80100c21:	b8 00 01 00 00       	mov    $0x100,%eax
80100c26:	e8 d5 f7 ff ff       	call   80100400 <cgaputc>
        while (input.e != input.w && input.buf[(input.e) % INPUT_BUF] != '\n') {
80100c2b:	a1 28 ef 10 80       	mov    0x8010ef28,%eax
80100c30:	83 c4 10             	add    $0x10,%esp
80100c33:	3b 05 24 ef 10 80    	cmp    0x8010ef24,%eax
80100c39:	0f 85 22 ff ff ff    	jne    80100b61 <consoleintr+0x1f1>
80100c3f:	e9 47 fd ff ff       	jmp    8010098b <consoleintr+0x1b>
80100c44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
          stat = 0 ;
80100c48:	c7 05 40 f0 10 80 00 	movl   $0x0,0x8010f040
80100c4f:	00 00 00 
          attribute = 0x0700;
80100c52:	c7 05 00 80 10 80 00 	movl   $0x700,0x80108000
80100c59:	07 00 00 
80100c5c:	e9 2a fd ff ff       	jmp    8010098b <consoleintr+0x1b>
    uartputc(c);
80100c61:	83 ec 0c             	sub    $0xc,%esp
80100c64:	6a 0a                	push   $0xa
80100c66:	e8 c5 52 00 00       	call   80105f30 <uartputc>
    cgaputc(c);
80100c6b:	b8 0a 00 00 00       	mov    $0xa,%eax
80100c70:	e8 8b f7 ff ff       	call   80100400 <cgaputc>
80100c75:	83 c4 10             	add    $0x10,%esp
80100c78:	e9 0e fd ff ff       	jmp    8010098b <consoleintr+0x1b>
  for (int i = 0; i < select_in; i++)
80100c7d:	8b 0d 88 ee 10 80    	mov    0x8010ee88,%ecx
80100c83:	31 c0                	xor    %eax,%eax
          copy_mode = 0;
80100c85:	c7 05 80 ee 10 80 00 	movl   $0x0,0x8010ee80
80100c8c:	00 00 00 
  for (int i = 0; i < select_in; i++)
80100c8f:	8d 99 c0 ef 10 80    	lea    -0x7fef1040(%ecx),%ebx
80100c95:	85 c9                	test   %ecx,%ecx
80100c97:	74 1d                	je     80100cb6 <consoleintr+0x346>
80100c99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    reversed_buffer[i] = selected_buffer[select_in-1-i];
80100ca0:	89 c2                	mov    %eax,%edx
  for (int i = 0; i < select_in; i++)
80100ca2:	83 c0 01             	add    $0x1,%eax
    reversed_buffer[i] = selected_buffer[select_in-1-i];
80100ca5:	f7 da                	neg    %edx
80100ca7:	0f b6 54 13 ff       	movzbl -0x1(%ebx,%edx,1),%edx
80100cac:	88 90 3f ef 10 80    	mov    %dl,-0x7fef10c1(%eax)
  for (int i = 0; i < select_in; i++)
80100cb2:	39 c8                	cmp    %ecx,%eax
80100cb4:	75 ea                	jne    80100ca0 <consoleintr+0x330>
  reversed_buffer[select_in] = '\0';
80100cb6:	c6 81 40 ef 10 80 00 	movb   $0x0,-0x7fef10c0(%ecx)
}
80100cbd:	e9 c9 fc ff ff       	jmp    8010098b <consoleintr+0x1b>
}
80100cc2:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100cc5:	5b                   	pop    %ebx
80100cc6:	5e                   	pop    %esi
80100cc7:	5f                   	pop    %edi
80100cc8:	5d                   	pop    %ebp
    procdump();  // Now call procdump() without holding cons.lock
80100cc9:	e9 72 37 00 00       	jmp    80104440 <procdump>
80100cce:	66 90                	xchg   %ax,%ax

80100cd0 <consoleinit>:

void
consoleinit(void)
{
80100cd0:	55                   	push   %ebp
80100cd1:	89 e5                	mov    %esp,%ebp
80100cd3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100cd6:	68 48 74 10 80       	push   $0x80107448
80100cdb:	68 60 f0 10 80       	push   $0x8010f060
80100ce0:	e8 4b 39 00 00       	call   80104630 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100ce5:	58                   	pop    %eax
80100ce6:	5a                   	pop    %edx
80100ce7:	6a 00                	push   $0x0
80100ce9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100ceb:	c7 05 4c fa 10 80 80 	movl   $0x80100680,0x8010fa4c
80100cf2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100cf5:	c7 05 48 fa 10 80 80 	movl   $0x80100280,0x8010fa48
80100cfc:	02 10 80 
  cons.locking = 1;
80100cff:	c7 05 94 f0 10 80 01 	movl   $0x1,0x8010f094
80100d06:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100d09:	e8 c2 19 00 00       	call   801026d0 <ioapicenable>
}
80100d0e:	83 c4 10             	add    $0x10,%esp
80100d11:	c9                   	leave
80100d12:	c3                   	ret
80100d13:	66 90                	xchg   %ax,%ax
80100d15:	66 90                	xchg   %ax,%ax
80100d17:	66 90                	xchg   %ax,%ax
80100d19:	66 90                	xchg   %ax,%ax
80100d1b:	66 90                	xchg   %ax,%ax
80100d1d:	66 90                	xchg   %ax,%ax
80100d1f:	90                   	nop

80100d20 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100d20:	55                   	push   %ebp
80100d21:	89 e5                	mov    %esp,%ebp
80100d23:	57                   	push   %edi
80100d24:	56                   	push   %esi
80100d25:	53                   	push   %ebx
80100d26:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100d2c:	e8 af 2e 00 00       	call   80103be0 <myproc>
80100d31:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100d37:	e8 84 22 00 00       	call   80102fc0 <begin_op>

  if((ip = namei(path)) == 0){
80100d3c:	83 ec 0c             	sub    $0xc,%esp
80100d3f:	ff 75 08             	push   0x8(%ebp)
80100d42:	e8 a9 15 00 00       	call   801022f0 <namei>
80100d47:	83 c4 10             	add    $0x10,%esp
80100d4a:	85 c0                	test   %eax,%eax
80100d4c:	0f 84 30 03 00 00    	je     80101082 <exec+0x362>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100d52:	83 ec 0c             	sub    $0xc,%esp
80100d55:	89 c7                	mov    %eax,%edi
80100d57:	50                   	push   %eax
80100d58:	e8 b3 0c 00 00       	call   80101a10 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100d5d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100d63:	6a 34                	push   $0x34
80100d65:	6a 00                	push   $0x0
80100d67:	50                   	push   %eax
80100d68:	57                   	push   %edi
80100d69:	e8 b2 0f 00 00       	call   80101d20 <readi>
80100d6e:	83 c4 20             	add    $0x20,%esp
80100d71:	83 f8 34             	cmp    $0x34,%eax
80100d74:	0f 85 01 01 00 00    	jne    80100e7b <exec+0x15b>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100d7a:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100d81:	45 4c 46 
80100d84:	0f 85 f1 00 00 00    	jne    80100e7b <exec+0x15b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100d8a:	e8 11 63 00 00       	call   801070a0 <setupkvm>
80100d8f:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100d95:	85 c0                	test   %eax,%eax
80100d97:	0f 84 de 00 00 00    	je     80100e7b <exec+0x15b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d9d:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100da4:	00 
80100da5:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100dab:	0f 84 a1 02 00 00    	je     80101052 <exec+0x332>
  sz = 0;
80100db1:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100db8:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100dbb:	31 db                	xor    %ebx,%ebx
80100dbd:	e9 8c 00 00 00       	jmp    80100e4e <exec+0x12e>
80100dc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100dc8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100dcf:	75 6c                	jne    80100e3d <exec+0x11d>
      continue;
    if(ph.memsz < ph.filesz)
80100dd1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100dd7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100ddd:	0f 82 87 00 00 00    	jb     80100e6a <exec+0x14a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100de3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100de9:	72 7f                	jb     80100e6a <exec+0x14a>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100deb:	83 ec 04             	sub    $0x4,%esp
80100dee:	50                   	push   %eax
80100def:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100df5:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100dfb:	e8 d0 60 00 00       	call   80106ed0 <allocuvm>
80100e00:	83 c4 10             	add    $0x10,%esp
80100e03:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100e09:	85 c0                	test   %eax,%eax
80100e0b:	74 5d                	je     80100e6a <exec+0x14a>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100e0d:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100e13:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100e18:	75 50                	jne    80100e6a <exec+0x14a>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100e1a:	83 ec 0c             	sub    $0xc,%esp
80100e1d:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100e23:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100e29:	57                   	push   %edi
80100e2a:	50                   	push   %eax
80100e2b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100e31:	e8 ca 5f 00 00       	call   80106e00 <loaduvm>
80100e36:	83 c4 20             	add    $0x20,%esp
80100e39:	85 c0                	test   %eax,%eax
80100e3b:	78 2d                	js     80100e6a <exec+0x14a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100e3d:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100e44:	83 c3 01             	add    $0x1,%ebx
80100e47:	83 c6 20             	add    $0x20,%esi
80100e4a:	39 d8                	cmp    %ebx,%eax
80100e4c:	7e 52                	jle    80100ea0 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100e4e:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100e54:	6a 20                	push   $0x20
80100e56:	56                   	push   %esi
80100e57:	50                   	push   %eax
80100e58:	57                   	push   %edi
80100e59:	e8 c2 0e 00 00       	call   80101d20 <readi>
80100e5e:	83 c4 10             	add    $0x10,%esp
80100e61:	83 f8 20             	cmp    $0x20,%eax
80100e64:	0f 84 5e ff ff ff    	je     80100dc8 <exec+0xa8>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100e6a:	83 ec 0c             	sub    $0xc,%esp
80100e6d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100e73:	e8 a8 61 00 00       	call   80107020 <freevm>
  if(ip){
80100e78:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80100e7b:	83 ec 0c             	sub    $0xc,%esp
80100e7e:	57                   	push   %edi
80100e7f:	e8 1c 0e 00 00       	call   80101ca0 <iunlockput>
    end_op();
80100e84:	e8 a7 21 00 00       	call   80103030 <end_op>
80100e89:	83 c4 10             	add    $0x10,%esp
    return -1;
80100e8c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return -1;
}
80100e91:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e94:	5b                   	pop    %ebx
80100e95:	5e                   	pop    %esi
80100e96:	5f                   	pop    %edi
80100e97:	5d                   	pop    %ebp
80100e98:	c3                   	ret
80100e99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sz = PGROUNDUP(sz);
80100ea0:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100ea6:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100eac:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100eb2:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
80100eb8:	83 ec 0c             	sub    $0xc,%esp
80100ebb:	57                   	push   %edi
80100ebc:	e8 df 0d 00 00       	call   80101ca0 <iunlockput>
  end_op();
80100ec1:	e8 6a 21 00 00       	call   80103030 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100ec6:	83 c4 0c             	add    $0xc,%esp
80100ec9:	53                   	push   %ebx
80100eca:	56                   	push   %esi
80100ecb:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100ed1:	56                   	push   %esi
80100ed2:	e8 f9 5f 00 00       	call   80106ed0 <allocuvm>
80100ed7:	83 c4 10             	add    $0x10,%esp
80100eda:	89 c7                	mov    %eax,%edi
80100edc:	85 c0                	test   %eax,%eax
80100ede:	0f 84 86 00 00 00    	je     80100f6a <exec+0x24a>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100ee4:	83 ec 08             	sub    $0x8,%esp
80100ee7:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  sp = sz;
80100eed:	89 fb                	mov    %edi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100eef:	50                   	push   %eax
80100ef0:	56                   	push   %esi
  for(argc = 0; argv[argc]; argc++) {
80100ef1:	31 f6                	xor    %esi,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100ef3:	e8 48 62 00 00       	call   80107140 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100ef8:	8b 45 0c             	mov    0xc(%ebp),%eax
80100efb:	83 c4 10             	add    $0x10,%esp
80100efe:	8b 10                	mov    (%eax),%edx
80100f00:	85 d2                	test   %edx,%edx
80100f02:	0f 84 56 01 00 00    	je     8010105e <exec+0x33e>
80100f08:	89 bd f0 fe ff ff    	mov    %edi,-0x110(%ebp)
80100f0e:	8b 7d 0c             	mov    0xc(%ebp),%edi
80100f11:	eb 23                	jmp    80100f36 <exec+0x216>
80100f13:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100f18:	8d 46 01             	lea    0x1(%esi),%eax
    ustack[3+argc] = sp;
80100f1b:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
80100f22:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80100f28:	8b 14 87             	mov    (%edi,%eax,4),%edx
80100f2b:	85 d2                	test   %edx,%edx
80100f2d:	74 51                	je     80100f80 <exec+0x260>
    if(argc >= MAXARG)
80100f2f:	83 f8 20             	cmp    $0x20,%eax
80100f32:	74 36                	je     80100f6a <exec+0x24a>
80100f34:	89 c6                	mov    %eax,%esi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100f36:	83 ec 0c             	sub    $0xc,%esp
80100f39:	52                   	push   %edx
80100f3a:	e8 d1 3b 00 00       	call   80104b10 <strlen>
80100f3f:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100f41:	58                   	pop    %eax
80100f42:	ff 34 b7             	push   (%edi,%esi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100f45:	83 eb 01             	sub    $0x1,%ebx
80100f48:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100f4b:	e8 c0 3b 00 00       	call   80104b10 <strlen>
80100f50:	83 c0 01             	add    $0x1,%eax
80100f53:	50                   	push   %eax
80100f54:	ff 34 b7             	push   (%edi,%esi,4)
80100f57:	53                   	push   %ebx
80100f58:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100f5e:	e8 ad 63 00 00       	call   80107310 <copyout>
80100f63:	83 c4 20             	add    $0x20,%esp
80100f66:	85 c0                	test   %eax,%eax
80100f68:	79 ae                	jns    80100f18 <exec+0x1f8>
    freevm(pgdir);
80100f6a:	83 ec 0c             	sub    $0xc,%esp
80100f6d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100f73:	e8 a8 60 00 00       	call   80107020 <freevm>
80100f78:	83 c4 10             	add    $0x10,%esp
80100f7b:	e9 0c ff ff ff       	jmp    80100e8c <exec+0x16c>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100f80:	8d 14 b5 08 00 00 00 	lea    0x8(,%esi,4),%edx
  ustack[3+argc] = 0;
80100f87:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100f8d:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100f93:	8d 46 04             	lea    0x4(%esi),%eax
  sp -= (3+argc+1) * 4;
80100f96:	8d 72 0c             	lea    0xc(%edx),%esi
  ustack[3+argc] = 0;
80100f99:	c7 84 85 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%eax,4)
80100fa0:	00 00 00 00 
  ustack[1] = argc;
80100fa4:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  ustack[0] = 0xffffffff;  // fake return PC
80100faa:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100fb1:	ff ff ff 
  ustack[1] = argc;
80100fb4:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100fba:	89 d8                	mov    %ebx,%eax
  sp -= (3+argc+1) * 4;
80100fbc:	29 f3                	sub    %esi,%ebx
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100fbe:	29 d0                	sub    %edx,%eax
80100fc0:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100fc6:	56                   	push   %esi
80100fc7:	51                   	push   %ecx
80100fc8:	53                   	push   %ebx
80100fc9:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100fcf:	e8 3c 63 00 00       	call   80107310 <copyout>
80100fd4:	83 c4 10             	add    $0x10,%esp
80100fd7:	85 c0                	test   %eax,%eax
80100fd9:	78 8f                	js     80100f6a <exec+0x24a>
  for(last=s=path; *s; s++)
80100fdb:	8b 45 08             	mov    0x8(%ebp),%eax
80100fde:	8b 55 08             	mov    0x8(%ebp),%edx
80100fe1:	0f b6 00             	movzbl (%eax),%eax
80100fe4:	84 c0                	test   %al,%al
80100fe6:	74 17                	je     80100fff <exec+0x2df>
80100fe8:	89 d1                	mov    %edx,%ecx
80100fea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      last = s+1;
80100ff0:	83 c1 01             	add    $0x1,%ecx
80100ff3:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100ff5:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80100ff8:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100ffb:	84 c0                	test   %al,%al
80100ffd:	75 f1                	jne    80100ff0 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100fff:	83 ec 04             	sub    $0x4,%esp
80101002:	6a 10                	push   $0x10
80101004:	52                   	push   %edx
80101005:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
8010100b:	8d 46 6c             	lea    0x6c(%esi),%eax
8010100e:	50                   	push   %eax
8010100f:	e8 bc 3a 00 00       	call   80104ad0 <safestrcpy>
  curproc->pgdir = pgdir;
80101014:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
8010101a:	89 f0                	mov    %esi,%eax
8010101c:	8b 76 04             	mov    0x4(%esi),%esi
  curproc->sz = sz;
8010101f:	89 38                	mov    %edi,(%eax)
  curproc->pgdir = pgdir;
80101021:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80101024:	89 c1                	mov    %eax,%ecx
80101026:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
8010102c:	8b 40 18             	mov    0x18(%eax),%eax
8010102f:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80101032:	8b 41 18             	mov    0x18(%ecx),%eax
80101035:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80101038:	89 0c 24             	mov    %ecx,(%esp)
8010103b:	e8 30 5c 00 00       	call   80106c70 <switchuvm>
  freevm(oldpgdir);
80101040:	89 34 24             	mov    %esi,(%esp)
80101043:	e8 d8 5f 00 00       	call   80107020 <freevm>
  return 0;
80101048:	83 c4 10             	add    $0x10,%esp
8010104b:	31 c0                	xor    %eax,%eax
8010104d:	e9 3f fe ff ff       	jmp    80100e91 <exec+0x171>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80101052:	bb 00 20 00 00       	mov    $0x2000,%ebx
80101057:	31 f6                	xor    %esi,%esi
80101059:	e9 5a fe ff ff       	jmp    80100eb8 <exec+0x198>
  for(argc = 0; argv[argc]; argc++) {
8010105e:	be 10 00 00 00       	mov    $0x10,%esi
80101063:	ba 04 00 00 00       	mov    $0x4,%edx
80101068:	b8 03 00 00 00       	mov    $0x3,%eax
8010106d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80101074:	00 00 00 
80101077:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
8010107d:	e9 17 ff ff ff       	jmp    80100f99 <exec+0x279>
    end_op();
80101082:	e8 a9 1f 00 00       	call   80103030 <end_op>
    cprintf("exec: fail\n");
80101087:	83 ec 0c             	sub    $0xc,%esp
8010108a:	68 50 74 10 80       	push   $0x80107450
8010108f:	e8 ac f6 ff ff       	call   80100740 <cprintf>
    return -1;
80101094:	83 c4 10             	add    $0x10,%esp
80101097:	e9 f0 fd ff ff       	jmp    80100e8c <exec+0x16c>
8010109c:	66 90                	xchg   %ax,%ax
8010109e:	66 90                	xchg   %ax,%ax

801010a0 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
801010a0:	55                   	push   %ebp
801010a1:	89 e5                	mov    %esp,%ebp
801010a3:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
801010a6:	68 5c 74 10 80       	push   $0x8010745c
801010ab:	68 a0 f0 10 80       	push   $0x8010f0a0
801010b0:	e8 7b 35 00 00       	call   80104630 <initlock>
}
801010b5:	83 c4 10             	add    $0x10,%esp
801010b8:	c9                   	leave
801010b9:	c3                   	ret
801010ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801010c0 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
801010c0:	55                   	push   %ebp
801010c1:	89 e5                	mov    %esp,%ebp
801010c3:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801010c4:	bb d4 f0 10 80       	mov    $0x8010f0d4,%ebx
{
801010c9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
801010cc:	68 a0 f0 10 80       	push   $0x8010f0a0
801010d1:	e8 4a 37 00 00       	call   80104820 <acquire>
801010d6:	83 c4 10             	add    $0x10,%esp
801010d9:	eb 10                	jmp    801010eb <filealloc+0x2b>
801010db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
801010e0:	83 c3 18             	add    $0x18,%ebx
801010e3:	81 fb 34 fa 10 80    	cmp    $0x8010fa34,%ebx
801010e9:	74 25                	je     80101110 <filealloc+0x50>
    if(f->ref == 0){
801010eb:	8b 43 04             	mov    0x4(%ebx),%eax
801010ee:	85 c0                	test   %eax,%eax
801010f0:	75 ee                	jne    801010e0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
801010f2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
801010f5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
801010fc:	68 a0 f0 10 80       	push   $0x8010f0a0
80101101:	e8 ba 36 00 00       	call   801047c0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80101106:	89 d8                	mov    %ebx,%eax
      return f;
80101108:	83 c4 10             	add    $0x10,%esp
}
8010110b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010110e:	c9                   	leave
8010110f:	c3                   	ret
  release(&ftable.lock);
80101110:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80101113:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80101115:	68 a0 f0 10 80       	push   $0x8010f0a0
8010111a:	e8 a1 36 00 00       	call   801047c0 <release>
}
8010111f:	89 d8                	mov    %ebx,%eax
  return 0;
80101121:	83 c4 10             	add    $0x10,%esp
}
80101124:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101127:	c9                   	leave
80101128:	c3                   	ret
80101129:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101130 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80101130:	55                   	push   %ebp
80101131:	89 e5                	mov    %esp,%ebp
80101133:	53                   	push   %ebx
80101134:	83 ec 10             	sub    $0x10,%esp
80101137:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
8010113a:	68 a0 f0 10 80       	push   $0x8010f0a0
8010113f:	e8 dc 36 00 00       	call   80104820 <acquire>
  if(f->ref < 1)
80101144:	8b 43 04             	mov    0x4(%ebx),%eax
80101147:	83 c4 10             	add    $0x10,%esp
8010114a:	85 c0                	test   %eax,%eax
8010114c:	7e 1a                	jle    80101168 <filedup+0x38>
    panic("filedup");
  f->ref++;
8010114e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80101151:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80101154:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80101157:	68 a0 f0 10 80       	push   $0x8010f0a0
8010115c:	e8 5f 36 00 00       	call   801047c0 <release>
  return f;
}
80101161:	89 d8                	mov    %ebx,%eax
80101163:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101166:	c9                   	leave
80101167:	c3                   	ret
    panic("filedup");
80101168:	83 ec 0c             	sub    $0xc,%esp
8010116b:	68 63 74 10 80       	push   $0x80107463
80101170:	e8 0b f2 ff ff       	call   80100380 <panic>
80101175:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010117c:	00 
8010117d:	8d 76 00             	lea    0x0(%esi),%esi

80101180 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80101180:	55                   	push   %ebp
80101181:	89 e5                	mov    %esp,%ebp
80101183:	57                   	push   %edi
80101184:	56                   	push   %esi
80101185:	53                   	push   %ebx
80101186:	83 ec 28             	sub    $0x28,%esp
80101189:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
8010118c:	68 a0 f0 10 80       	push   $0x8010f0a0
80101191:	e8 8a 36 00 00       	call   80104820 <acquire>
  if(f->ref < 1)
80101196:	8b 53 04             	mov    0x4(%ebx),%edx
80101199:	83 c4 10             	add    $0x10,%esp
8010119c:	85 d2                	test   %edx,%edx
8010119e:	0f 8e a5 00 00 00    	jle    80101249 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
801011a4:	83 ea 01             	sub    $0x1,%edx
801011a7:	89 53 04             	mov    %edx,0x4(%ebx)
801011aa:	75 44                	jne    801011f0 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
801011ac:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
801011b0:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
801011b3:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
801011b5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
801011bb:	8b 73 0c             	mov    0xc(%ebx),%esi
801011be:	88 45 e7             	mov    %al,-0x19(%ebp)
801011c1:	8b 43 10             	mov    0x10(%ebx),%eax
801011c4:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
801011c7:	68 a0 f0 10 80       	push   $0x8010f0a0
801011cc:	e8 ef 35 00 00       	call   801047c0 <release>

  if(ff.type == FD_PIPE)
801011d1:	83 c4 10             	add    $0x10,%esp
801011d4:	83 ff 01             	cmp    $0x1,%edi
801011d7:	74 57                	je     80101230 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
801011d9:	83 ff 02             	cmp    $0x2,%edi
801011dc:	74 2a                	je     80101208 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
801011de:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011e1:	5b                   	pop    %ebx
801011e2:	5e                   	pop    %esi
801011e3:	5f                   	pop    %edi
801011e4:	5d                   	pop    %ebp
801011e5:	c3                   	ret
801011e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801011ed:	00 
801011ee:	66 90                	xchg   %ax,%ax
    release(&ftable.lock);
801011f0:	c7 45 08 a0 f0 10 80 	movl   $0x8010f0a0,0x8(%ebp)
}
801011f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801011fa:	5b                   	pop    %ebx
801011fb:	5e                   	pop    %esi
801011fc:	5f                   	pop    %edi
801011fd:	5d                   	pop    %ebp
    release(&ftable.lock);
801011fe:	e9 bd 35 00 00       	jmp    801047c0 <release>
80101203:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    begin_op();
80101208:	e8 b3 1d 00 00       	call   80102fc0 <begin_op>
    iput(ff.ip);
8010120d:	83 ec 0c             	sub    $0xc,%esp
80101210:	ff 75 e0             	push   -0x20(%ebp)
80101213:	e8 28 09 00 00       	call   80101b40 <iput>
    end_op();
80101218:	83 c4 10             	add    $0x10,%esp
}
8010121b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010121e:	5b                   	pop    %ebx
8010121f:	5e                   	pop    %esi
80101220:	5f                   	pop    %edi
80101221:	5d                   	pop    %ebp
    end_op();
80101222:	e9 09 1e 00 00       	jmp    80103030 <end_op>
80101227:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010122e:	00 
8010122f:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
80101230:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101234:	83 ec 08             	sub    $0x8,%esp
80101237:	53                   	push   %ebx
80101238:	56                   	push   %esi
80101239:	e8 42 25 00 00       	call   80103780 <pipeclose>
8010123e:	83 c4 10             	add    $0x10,%esp
}
80101241:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101244:	5b                   	pop    %ebx
80101245:	5e                   	pop    %esi
80101246:	5f                   	pop    %edi
80101247:	5d                   	pop    %ebp
80101248:	c3                   	ret
    panic("fileclose");
80101249:	83 ec 0c             	sub    $0xc,%esp
8010124c:	68 6b 74 10 80       	push   $0x8010746b
80101251:	e8 2a f1 ff ff       	call   80100380 <panic>
80101256:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010125d:	00 
8010125e:	66 90                	xchg   %ax,%ax

80101260 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80101260:	55                   	push   %ebp
80101261:	89 e5                	mov    %esp,%ebp
80101263:	53                   	push   %ebx
80101264:	83 ec 04             	sub    $0x4,%esp
80101267:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
8010126a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010126d:	75 31                	jne    801012a0 <filestat+0x40>
    ilock(f->ip);
8010126f:	83 ec 0c             	sub    $0xc,%esp
80101272:	ff 73 10             	push   0x10(%ebx)
80101275:	e8 96 07 00 00       	call   80101a10 <ilock>
    stati(f->ip, st);
8010127a:	58                   	pop    %eax
8010127b:	5a                   	pop    %edx
8010127c:	ff 75 0c             	push   0xc(%ebp)
8010127f:	ff 73 10             	push   0x10(%ebx)
80101282:	e8 69 0a 00 00       	call   80101cf0 <stati>
    iunlock(f->ip);
80101287:	59                   	pop    %ecx
80101288:	ff 73 10             	push   0x10(%ebx)
8010128b:	e8 60 08 00 00       	call   80101af0 <iunlock>
    return 0;
  }
  return -1;
}
80101290:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80101293:	83 c4 10             	add    $0x10,%esp
80101296:	31 c0                	xor    %eax,%eax
}
80101298:	c9                   	leave
80101299:	c3                   	ret
8010129a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801012a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
801012a3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801012a8:	c9                   	leave
801012a9:	c3                   	ret
801012aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801012b0 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
801012b0:	55                   	push   %ebp
801012b1:	89 e5                	mov    %esp,%ebp
801012b3:	57                   	push   %edi
801012b4:	56                   	push   %esi
801012b5:	53                   	push   %ebx
801012b6:	83 ec 0c             	sub    $0xc,%esp
801012b9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801012bc:	8b 75 0c             	mov    0xc(%ebp),%esi
801012bf:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
801012c2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801012c6:	74 60                	je     80101328 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
801012c8:	8b 03                	mov    (%ebx),%eax
801012ca:	83 f8 01             	cmp    $0x1,%eax
801012cd:	74 41                	je     80101310 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
801012cf:	83 f8 02             	cmp    $0x2,%eax
801012d2:	75 5b                	jne    8010132f <fileread+0x7f>
    ilock(f->ip);
801012d4:	83 ec 0c             	sub    $0xc,%esp
801012d7:	ff 73 10             	push   0x10(%ebx)
801012da:	e8 31 07 00 00       	call   80101a10 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
801012df:	57                   	push   %edi
801012e0:	ff 73 14             	push   0x14(%ebx)
801012e3:	56                   	push   %esi
801012e4:	ff 73 10             	push   0x10(%ebx)
801012e7:	e8 34 0a 00 00       	call   80101d20 <readi>
801012ec:	83 c4 20             	add    $0x20,%esp
801012ef:	89 c6                	mov    %eax,%esi
801012f1:	85 c0                	test   %eax,%eax
801012f3:	7e 03                	jle    801012f8 <fileread+0x48>
      f->off += r;
801012f5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
801012f8:	83 ec 0c             	sub    $0xc,%esp
801012fb:	ff 73 10             	push   0x10(%ebx)
801012fe:	e8 ed 07 00 00       	call   80101af0 <iunlock>
    return r;
80101303:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101306:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101309:	89 f0                	mov    %esi,%eax
8010130b:	5b                   	pop    %ebx
8010130c:	5e                   	pop    %esi
8010130d:	5f                   	pop    %edi
8010130e:	5d                   	pop    %ebp
8010130f:	c3                   	ret
    return piperead(f->pipe, addr, n);
80101310:	8b 43 0c             	mov    0xc(%ebx),%eax
80101313:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101316:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101319:	5b                   	pop    %ebx
8010131a:	5e                   	pop    %esi
8010131b:	5f                   	pop    %edi
8010131c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010131d:	e9 1e 26 00 00       	jmp    80103940 <piperead>
80101322:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101328:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010132d:	eb d7                	jmp    80101306 <fileread+0x56>
  panic("fileread");
8010132f:	83 ec 0c             	sub    $0xc,%esp
80101332:	68 75 74 10 80       	push   $0x80107475
80101337:	e8 44 f0 ff ff       	call   80100380 <panic>
8010133c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101340 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80101340:	55                   	push   %ebp
80101341:	89 e5                	mov    %esp,%ebp
80101343:	57                   	push   %edi
80101344:	56                   	push   %esi
80101345:	53                   	push   %ebx
80101346:	83 ec 1c             	sub    $0x1c,%esp
80101349:	8b 45 0c             	mov    0xc(%ebp),%eax
8010134c:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010134f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101352:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
80101355:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
80101359:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010135c:	0f 84 bb 00 00 00    	je     8010141d <filewrite+0xdd>
    return -1;
  if(f->type == FD_PIPE)
80101362:	8b 03                	mov    (%ebx),%eax
80101364:	83 f8 01             	cmp    $0x1,%eax
80101367:	0f 84 bf 00 00 00    	je     8010142c <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010136d:	83 f8 02             	cmp    $0x2,%eax
80101370:	0f 85 c8 00 00 00    	jne    8010143e <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101376:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101379:	31 f6                	xor    %esi,%esi
    while(i < n){
8010137b:	85 c0                	test   %eax,%eax
8010137d:	7f 30                	jg     801013af <filewrite+0x6f>
8010137f:	e9 94 00 00 00       	jmp    80101418 <filewrite+0xd8>
80101384:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101388:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
8010138b:	83 ec 0c             	sub    $0xc,%esp
        f->off += r;
8010138e:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101391:	ff 73 10             	push   0x10(%ebx)
80101394:	e8 57 07 00 00       	call   80101af0 <iunlock>
      end_op();
80101399:	e8 92 1c 00 00       	call   80103030 <end_op>

      if(r < 0)
        break;
      if(r != n1)
8010139e:	8b 45 e0             	mov    -0x20(%ebp),%eax
801013a1:	83 c4 10             	add    $0x10,%esp
801013a4:	39 c7                	cmp    %eax,%edi
801013a6:	75 5c                	jne    80101404 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
801013a8:	01 fe                	add    %edi,%esi
    while(i < n){
801013aa:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801013ad:	7e 69                	jle    80101418 <filewrite+0xd8>
      int n1 = n - i;
801013af:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      if(n1 > max)
801013b2:	b8 00 06 00 00       	mov    $0x600,%eax
      int n1 = n - i;
801013b7:	29 f7                	sub    %esi,%edi
      if(n1 > max)
801013b9:	39 c7                	cmp    %eax,%edi
801013bb:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
801013be:	e8 fd 1b 00 00       	call   80102fc0 <begin_op>
      ilock(f->ip);
801013c3:	83 ec 0c             	sub    $0xc,%esp
801013c6:	ff 73 10             	push   0x10(%ebx)
801013c9:	e8 42 06 00 00       	call   80101a10 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
801013ce:	57                   	push   %edi
801013cf:	ff 73 14             	push   0x14(%ebx)
801013d2:	8b 45 dc             	mov    -0x24(%ebp),%eax
801013d5:	01 f0                	add    %esi,%eax
801013d7:	50                   	push   %eax
801013d8:	ff 73 10             	push   0x10(%ebx)
801013db:	e8 40 0a 00 00       	call   80101e20 <writei>
801013e0:	83 c4 20             	add    $0x20,%esp
801013e3:	85 c0                	test   %eax,%eax
801013e5:	7f a1                	jg     80101388 <filewrite+0x48>
801013e7:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801013ea:	83 ec 0c             	sub    $0xc,%esp
801013ed:	ff 73 10             	push   0x10(%ebx)
801013f0:	e8 fb 06 00 00       	call   80101af0 <iunlock>
      end_op();
801013f5:	e8 36 1c 00 00       	call   80103030 <end_op>
      if(r < 0)
801013fa:	8b 45 e0             	mov    -0x20(%ebp),%eax
801013fd:	83 c4 10             	add    $0x10,%esp
80101400:	85 c0                	test   %eax,%eax
80101402:	75 14                	jne    80101418 <filewrite+0xd8>
        panic("short filewrite");
80101404:	83 ec 0c             	sub    $0xc,%esp
80101407:	68 7e 74 10 80       	push   $0x8010747e
8010140c:	e8 6f ef ff ff       	call   80100380 <panic>
80101411:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80101418:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010141b:	74 05                	je     80101422 <filewrite+0xe2>
8010141d:	be ff ff ff ff       	mov    $0xffffffff,%esi
  }
  panic("filewrite");
}
80101422:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101425:	89 f0                	mov    %esi,%eax
80101427:	5b                   	pop    %ebx
80101428:	5e                   	pop    %esi
80101429:	5f                   	pop    %edi
8010142a:	5d                   	pop    %ebp
8010142b:	c3                   	ret
    return pipewrite(f->pipe, addr, n);
8010142c:	8b 43 0c             	mov    0xc(%ebx),%eax
8010142f:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101432:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101435:	5b                   	pop    %ebx
80101436:	5e                   	pop    %esi
80101437:	5f                   	pop    %edi
80101438:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101439:	e9 e2 23 00 00       	jmp    80103820 <pipewrite>
  panic("filewrite");
8010143e:	83 ec 0c             	sub    $0xc,%esp
80101441:	68 84 74 10 80       	push   $0x80107484
80101446:	e8 35 ef ff ff       	call   80100380 <panic>
8010144b:	66 90                	xchg   %ax,%ax
8010144d:	66 90                	xchg   %ax,%ax
8010144f:	90                   	nop

80101450 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101450:	55                   	push   %ebp
80101451:	89 e5                	mov    %esp,%ebp
80101453:	57                   	push   %edi
80101454:	56                   	push   %esi
80101455:	53                   	push   %ebx
80101456:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101459:	8b 0d f4 16 11 80    	mov    0x801116f4,%ecx
{
8010145f:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101462:	85 c9                	test   %ecx,%ecx
80101464:	0f 84 8c 00 00 00    	je     801014f6 <balloc+0xa6>
8010146a:	31 ff                	xor    %edi,%edi
    bp = bread(dev, BBLOCK(b, sb));
8010146c:	89 f8                	mov    %edi,%eax
8010146e:	83 ec 08             	sub    $0x8,%esp
80101471:	89 fe                	mov    %edi,%esi
80101473:	c1 f8 0c             	sar    $0xc,%eax
80101476:	03 05 0c 17 11 80    	add    0x8011170c,%eax
8010147c:	50                   	push   %eax
8010147d:	ff 75 dc             	push   -0x24(%ebp)
80101480:	e8 4b ec ff ff       	call   801000d0 <bread>
80101485:	83 c4 10             	add    $0x10,%esp
80101488:	89 7d d8             	mov    %edi,-0x28(%ebp)
8010148b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010148e:	a1 f4 16 11 80       	mov    0x801116f4,%eax
80101493:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101496:	31 c0                	xor    %eax,%eax
80101498:	eb 32                	jmp    801014cc <balloc+0x7c>
8010149a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
801014a0:	89 c1                	mov    %eax,%ecx
801014a2:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801014a7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      m = 1 << (bi % 8);
801014aa:	83 e1 07             	and    $0x7,%ecx
801014ad:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
801014af:	89 c1                	mov    %eax,%ecx
801014b1:	c1 f9 03             	sar    $0x3,%ecx
801014b4:	0f b6 7c 0f 5c       	movzbl 0x5c(%edi,%ecx,1),%edi
801014b9:	89 fa                	mov    %edi,%edx
801014bb:	85 df                	test   %ebx,%edi
801014bd:	74 49                	je     80101508 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801014bf:	83 c0 01             	add    $0x1,%eax
801014c2:	83 c6 01             	add    $0x1,%esi
801014c5:	3d 00 10 00 00       	cmp    $0x1000,%eax
801014ca:	74 07                	je     801014d3 <balloc+0x83>
801014cc:	8b 55 e0             	mov    -0x20(%ebp),%edx
801014cf:	39 d6                	cmp    %edx,%esi
801014d1:	72 cd                	jb     801014a0 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
801014d3:	8b 7d d8             	mov    -0x28(%ebp),%edi
801014d6:	83 ec 0c             	sub    $0xc,%esp
801014d9:	ff 75 e4             	push   -0x1c(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801014dc:	81 c7 00 10 00 00    	add    $0x1000,%edi
    brelse(bp);
801014e2:	e8 09 ed ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
801014e7:	83 c4 10             	add    $0x10,%esp
801014ea:	3b 3d f4 16 11 80    	cmp    0x801116f4,%edi
801014f0:	0f 82 76 ff ff ff    	jb     8010146c <balloc+0x1c>
  }
  panic("balloc: out of blocks");
801014f6:	83 ec 0c             	sub    $0xc,%esp
801014f9:	68 8e 74 10 80       	push   $0x8010748e
801014fe:	e8 7d ee ff ff       	call   80100380 <panic>
80101503:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
80101508:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
8010150b:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
8010150e:	09 da                	or     %ebx,%edx
80101510:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
80101514:	57                   	push   %edi
80101515:	e8 86 1c 00 00       	call   801031a0 <log_write>
        brelse(bp);
8010151a:	89 3c 24             	mov    %edi,(%esp)
8010151d:	e8 ce ec ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
80101522:	58                   	pop    %eax
80101523:	5a                   	pop    %edx
80101524:	56                   	push   %esi
80101525:	ff 75 dc             	push   -0x24(%ebp)
80101528:	e8 a3 eb ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
8010152d:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101530:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101532:	8d 40 5c             	lea    0x5c(%eax),%eax
80101535:	68 00 02 00 00       	push   $0x200
8010153a:	6a 00                	push   $0x0
8010153c:	50                   	push   %eax
8010153d:	e8 de 33 00 00       	call   80104920 <memset>
  log_write(bp);
80101542:	89 1c 24             	mov    %ebx,(%esp)
80101545:	e8 56 1c 00 00       	call   801031a0 <log_write>
  brelse(bp);
8010154a:	89 1c 24             	mov    %ebx,(%esp)
8010154d:	e8 9e ec ff ff       	call   801001f0 <brelse>
}
80101552:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101555:	89 f0                	mov    %esi,%eax
80101557:	5b                   	pop    %ebx
80101558:	5e                   	pop    %esi
80101559:	5f                   	pop    %edi
8010155a:	5d                   	pop    %ebp
8010155b:	c3                   	ret
8010155c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101560 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101560:	55                   	push   %ebp
80101561:	89 e5                	mov    %esp,%ebp
80101563:	57                   	push   %edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101564:	31 ff                	xor    %edi,%edi
{
80101566:	56                   	push   %esi
80101567:	89 c6                	mov    %eax,%esi
80101569:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010156a:	bb d4 fa 10 80       	mov    $0x8010fad4,%ebx
{
8010156f:	83 ec 28             	sub    $0x28,%esp
80101572:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101575:	68 a0 fa 10 80       	push   $0x8010faa0
8010157a:	e8 a1 32 00 00       	call   80104820 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010157f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
80101582:	83 c4 10             	add    $0x10,%esp
80101585:	eb 1b                	jmp    801015a2 <iget+0x42>
80101587:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010158e:	00 
8010158f:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101590:	39 33                	cmp    %esi,(%ebx)
80101592:	74 6c                	je     80101600 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101594:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010159a:	81 fb f4 16 11 80    	cmp    $0x801116f4,%ebx
801015a0:	74 26                	je     801015c8 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801015a2:	8b 43 08             	mov    0x8(%ebx),%eax
801015a5:	85 c0                	test   %eax,%eax
801015a7:	7f e7                	jg     80101590 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
801015a9:	85 ff                	test   %edi,%edi
801015ab:	75 e7                	jne    80101594 <iget+0x34>
801015ad:	85 c0                	test   %eax,%eax
801015af:	75 76                	jne    80101627 <iget+0xc7>
      empty = ip;
801015b1:	89 df                	mov    %ebx,%edi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801015b3:	81 c3 90 00 00 00    	add    $0x90,%ebx
801015b9:	81 fb f4 16 11 80    	cmp    $0x801116f4,%ebx
801015bf:	75 e1                	jne    801015a2 <iget+0x42>
801015c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }

  // Recycle an inode cache entry.
  if(empty == 0)
801015c8:	85 ff                	test   %edi,%edi
801015ca:	74 79                	je     80101645 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
801015cc:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
801015cf:	89 37                	mov    %esi,(%edi)
  ip->inum = inum;
801015d1:	89 57 04             	mov    %edx,0x4(%edi)
  ip->ref = 1;
801015d4:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
  ip->valid = 0;
801015db:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
  release(&icache.lock);
801015e2:	68 a0 fa 10 80       	push   $0x8010faa0
801015e7:	e8 d4 31 00 00       	call   801047c0 <release>

  return ip;
801015ec:	83 c4 10             	add    $0x10,%esp
}
801015ef:	8d 65 f4             	lea    -0xc(%ebp),%esp
801015f2:	89 f8                	mov    %edi,%eax
801015f4:	5b                   	pop    %ebx
801015f5:	5e                   	pop    %esi
801015f6:	5f                   	pop    %edi
801015f7:	5d                   	pop    %ebp
801015f8:	c3                   	ret
801015f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101600:	39 53 04             	cmp    %edx,0x4(%ebx)
80101603:	75 8f                	jne    80101594 <iget+0x34>
      ip->ref++;
80101605:	83 c0 01             	add    $0x1,%eax
      release(&icache.lock);
80101608:	83 ec 0c             	sub    $0xc,%esp
      return ip;
8010160b:	89 df                	mov    %ebx,%edi
      ip->ref++;
8010160d:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101610:	68 a0 fa 10 80       	push   $0x8010faa0
80101615:	e8 a6 31 00 00       	call   801047c0 <release>
      return ip;
8010161a:	83 c4 10             	add    $0x10,%esp
}
8010161d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101620:	89 f8                	mov    %edi,%eax
80101622:	5b                   	pop    %ebx
80101623:	5e                   	pop    %esi
80101624:	5f                   	pop    %edi
80101625:	5d                   	pop    %ebp
80101626:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101627:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010162d:	81 fb f4 16 11 80    	cmp    $0x801116f4,%ebx
80101633:	74 10                	je     80101645 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101635:	8b 43 08             	mov    0x8(%ebx),%eax
80101638:	85 c0                	test   %eax,%eax
8010163a:	0f 8f 50 ff ff ff    	jg     80101590 <iget+0x30>
80101640:	e9 68 ff ff ff       	jmp    801015ad <iget+0x4d>
    panic("iget: no inodes");
80101645:	83 ec 0c             	sub    $0xc,%esp
80101648:	68 a4 74 10 80       	push   $0x801074a4
8010164d:	e8 2e ed ff ff       	call   80100380 <panic>
80101652:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101659:	00 
8010165a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101660 <bfree>:
{
80101660:	55                   	push   %ebp
80101661:	89 c1                	mov    %eax,%ecx
  bp = bread(dev, BBLOCK(b, sb));
80101663:	89 d0                	mov    %edx,%eax
80101665:	c1 e8 0c             	shr    $0xc,%eax
{
80101668:	89 e5                	mov    %esp,%ebp
8010166a:	56                   	push   %esi
8010166b:	53                   	push   %ebx
  bp = bread(dev, BBLOCK(b, sb));
8010166c:	03 05 0c 17 11 80    	add    0x8011170c,%eax
{
80101672:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
80101674:	83 ec 08             	sub    $0x8,%esp
80101677:	50                   	push   %eax
80101678:	51                   	push   %ecx
80101679:	e8 52 ea ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010167e:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
80101680:	c1 fb 03             	sar    $0x3,%ebx
80101683:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
80101686:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
80101688:	83 e1 07             	and    $0x7,%ecx
8010168b:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
80101690:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
80101696:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
80101698:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
8010169d:	85 c1                	test   %eax,%ecx
8010169f:	74 23                	je     801016c4 <bfree+0x64>
  bp->data[bi/8] &= ~m;
801016a1:	f7 d0                	not    %eax
  log_write(bp);
801016a3:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
801016a6:	21 c8                	and    %ecx,%eax
801016a8:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
801016ac:	56                   	push   %esi
801016ad:	e8 ee 1a 00 00       	call   801031a0 <log_write>
  brelse(bp);
801016b2:	89 34 24             	mov    %esi,(%esp)
801016b5:	e8 36 eb ff ff       	call   801001f0 <brelse>
}
801016ba:	83 c4 10             	add    $0x10,%esp
801016bd:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016c0:	5b                   	pop    %ebx
801016c1:	5e                   	pop    %esi
801016c2:	5d                   	pop    %ebp
801016c3:	c3                   	ret
    panic("freeing free block");
801016c4:	83 ec 0c             	sub    $0xc,%esp
801016c7:	68 b4 74 10 80       	push   $0x801074b4
801016cc:	e8 af ec ff ff       	call   80100380 <panic>
801016d1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801016d8:	00 
801016d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801016e0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801016e0:	55                   	push   %ebp
801016e1:	89 e5                	mov    %esp,%ebp
801016e3:	57                   	push   %edi
801016e4:	56                   	push   %esi
801016e5:	89 c6                	mov    %eax,%esi
801016e7:	53                   	push   %ebx
801016e8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801016eb:	83 fa 0b             	cmp    $0xb,%edx
801016ee:	0f 86 8c 00 00 00    	jbe    80101780 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
801016f4:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
801016f7:	83 fb 7f             	cmp    $0x7f,%ebx
801016fa:	0f 87 a2 00 00 00    	ja     801017a2 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101700:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101706:	85 c0                	test   %eax,%eax
80101708:	74 5e                	je     80101768 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010170a:	83 ec 08             	sub    $0x8,%esp
8010170d:	50                   	push   %eax
8010170e:	ff 36                	push   (%esi)
80101710:	e8 bb e9 ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101715:	83 c4 10             	add    $0x10,%esp
80101718:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010171c:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
8010171e:	8b 3b                	mov    (%ebx),%edi
80101720:	85 ff                	test   %edi,%edi
80101722:	74 1c                	je     80101740 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101724:	83 ec 0c             	sub    $0xc,%esp
80101727:	52                   	push   %edx
80101728:	e8 c3 ea ff ff       	call   801001f0 <brelse>
8010172d:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101730:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101733:	89 f8                	mov    %edi,%eax
80101735:	5b                   	pop    %ebx
80101736:	5e                   	pop    %esi
80101737:	5f                   	pop    %edi
80101738:	5d                   	pop    %ebp
80101739:	c3                   	ret
8010173a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101740:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
80101743:	8b 06                	mov    (%esi),%eax
80101745:	e8 06 fd ff ff       	call   80101450 <balloc>
      log_write(bp);
8010174a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010174d:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101750:	89 03                	mov    %eax,(%ebx)
80101752:	89 c7                	mov    %eax,%edi
      log_write(bp);
80101754:	52                   	push   %edx
80101755:	e8 46 1a 00 00       	call   801031a0 <log_write>
8010175a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010175d:	83 c4 10             	add    $0x10,%esp
80101760:	eb c2                	jmp    80101724 <bmap+0x44>
80101762:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101768:	8b 06                	mov    (%esi),%eax
8010176a:	e8 e1 fc ff ff       	call   80101450 <balloc>
8010176f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101775:	eb 93                	jmp    8010170a <bmap+0x2a>
80101777:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010177e:	00 
8010177f:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
80101780:	8d 5a 14             	lea    0x14(%edx),%ebx
80101783:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80101787:	85 ff                	test   %edi,%edi
80101789:	75 a5                	jne    80101730 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
8010178b:	8b 00                	mov    (%eax),%eax
8010178d:	e8 be fc ff ff       	call   80101450 <balloc>
80101792:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80101796:	89 c7                	mov    %eax,%edi
}
80101798:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010179b:	5b                   	pop    %ebx
8010179c:	89 f8                	mov    %edi,%eax
8010179e:	5e                   	pop    %esi
8010179f:	5f                   	pop    %edi
801017a0:	5d                   	pop    %ebp
801017a1:	c3                   	ret
  panic("bmap: out of range");
801017a2:	83 ec 0c             	sub    $0xc,%esp
801017a5:	68 c7 74 10 80       	push   $0x801074c7
801017aa:	e8 d1 eb ff ff       	call   80100380 <panic>
801017af:	90                   	nop

801017b0 <readsb>:
{
801017b0:	55                   	push   %ebp
801017b1:	89 e5                	mov    %esp,%ebp
801017b3:	56                   	push   %esi
801017b4:	53                   	push   %ebx
801017b5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801017b8:	83 ec 08             	sub    $0x8,%esp
801017bb:	6a 01                	push   $0x1
801017bd:	ff 75 08             	push   0x8(%ebp)
801017c0:	e8 0b e9 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
801017c5:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
801017c8:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801017ca:	8d 40 5c             	lea    0x5c(%eax),%eax
801017cd:	6a 1c                	push   $0x1c
801017cf:	50                   	push   %eax
801017d0:	56                   	push   %esi
801017d1:	e8 da 31 00 00       	call   801049b0 <memmove>
  brelse(bp);
801017d6:	83 c4 10             	add    $0x10,%esp
801017d9:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801017dc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801017df:	5b                   	pop    %ebx
801017e0:	5e                   	pop    %esi
801017e1:	5d                   	pop    %ebp
  brelse(bp);
801017e2:	e9 09 ea ff ff       	jmp    801001f0 <brelse>
801017e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801017ee:	00 
801017ef:	90                   	nop

801017f0 <iinit>:
{
801017f0:	55                   	push   %ebp
801017f1:	89 e5                	mov    %esp,%ebp
801017f3:	53                   	push   %ebx
801017f4:	bb e0 fa 10 80       	mov    $0x8010fae0,%ebx
801017f9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
801017fc:	68 da 74 10 80       	push   $0x801074da
80101801:	68 a0 fa 10 80       	push   $0x8010faa0
80101806:	e8 25 2e 00 00       	call   80104630 <initlock>
  for(i = 0; i < NINODE; i++) {
8010180b:	83 c4 10             	add    $0x10,%esp
8010180e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101810:	83 ec 08             	sub    $0x8,%esp
80101813:	68 e1 74 10 80       	push   $0x801074e1
80101818:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80101819:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
8010181f:	e8 dc 2c 00 00       	call   80104500 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101824:	83 c4 10             	add    $0x10,%esp
80101827:	81 fb 00 17 11 80    	cmp    $0x80111700,%ebx
8010182d:	75 e1                	jne    80101810 <iinit+0x20>
  bp = bread(dev, 1);
8010182f:	83 ec 08             	sub    $0x8,%esp
80101832:	6a 01                	push   $0x1
80101834:	ff 75 08             	push   0x8(%ebp)
80101837:	e8 94 e8 ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
8010183c:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
8010183f:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
80101841:	8d 40 5c             	lea    0x5c(%eax),%eax
80101844:	6a 1c                	push   $0x1c
80101846:	50                   	push   %eax
80101847:	68 f4 16 11 80       	push   $0x801116f4
8010184c:	e8 5f 31 00 00       	call   801049b0 <memmove>
  brelse(bp);
80101851:	89 1c 24             	mov    %ebx,(%esp)
80101854:	e8 97 e9 ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
80101859:	ff 35 0c 17 11 80    	push   0x8011170c
8010185f:	ff 35 08 17 11 80    	push   0x80111708
80101865:	ff 35 04 17 11 80    	push   0x80111704
8010186b:	ff 35 00 17 11 80    	push   0x80111700
80101871:	ff 35 fc 16 11 80    	push   0x801116fc
80101877:	ff 35 f8 16 11 80    	push   0x801116f8
8010187d:	ff 35 f4 16 11 80    	push   0x801116f4
80101883:	68 44 79 10 80       	push   $0x80107944
80101888:	e8 b3 ee ff ff       	call   80100740 <cprintf>
}
8010188d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101890:	83 c4 30             	add    $0x30,%esp
80101893:	c9                   	leave
80101894:	c3                   	ret
80101895:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010189c:	00 
8010189d:	8d 76 00             	lea    0x0(%esi),%esi

801018a0 <ialloc>:
{
801018a0:	55                   	push   %ebp
801018a1:	89 e5                	mov    %esp,%ebp
801018a3:	57                   	push   %edi
801018a4:	56                   	push   %esi
801018a5:	53                   	push   %ebx
801018a6:	83 ec 1c             	sub    $0x1c,%esp
801018a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
801018ac:	83 3d fc 16 11 80 01 	cmpl   $0x1,0x801116fc
{
801018b3:	8b 75 08             	mov    0x8(%ebp),%esi
801018b6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
801018b9:	0f 86 91 00 00 00    	jbe    80101950 <ialloc+0xb0>
801018bf:	bf 01 00 00 00       	mov    $0x1,%edi
801018c4:	eb 21                	jmp    801018e7 <ialloc+0x47>
801018c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801018cd:	00 
801018ce:	66 90                	xchg   %ax,%ax
    brelse(bp);
801018d0:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
801018d3:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
801018d6:	53                   	push   %ebx
801018d7:	e8 14 e9 ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
801018dc:	83 c4 10             	add    $0x10,%esp
801018df:	3b 3d fc 16 11 80    	cmp    0x801116fc,%edi
801018e5:	73 69                	jae    80101950 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
801018e7:	89 f8                	mov    %edi,%eax
801018e9:	83 ec 08             	sub    $0x8,%esp
801018ec:	c1 e8 03             	shr    $0x3,%eax
801018ef:	03 05 08 17 11 80    	add    0x80111708,%eax
801018f5:	50                   	push   %eax
801018f6:	56                   	push   %esi
801018f7:	e8 d4 e7 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
801018fc:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
801018ff:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101901:	89 f8                	mov    %edi,%eax
80101903:	83 e0 07             	and    $0x7,%eax
80101906:	c1 e0 06             	shl    $0x6,%eax
80101909:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010190d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101911:	75 bd                	jne    801018d0 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101913:	83 ec 04             	sub    $0x4,%esp
80101916:	6a 40                	push   $0x40
80101918:	6a 00                	push   $0x0
8010191a:	51                   	push   %ecx
8010191b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010191e:	e8 fd 2f 00 00       	call   80104920 <memset>
      dip->type = type;
80101923:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101927:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010192a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010192d:	89 1c 24             	mov    %ebx,(%esp)
80101930:	e8 6b 18 00 00       	call   801031a0 <log_write>
      brelse(bp);
80101935:	89 1c 24             	mov    %ebx,(%esp)
80101938:	e8 b3 e8 ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
8010193d:	83 c4 10             	add    $0x10,%esp
}
80101940:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
80101943:	89 fa                	mov    %edi,%edx
}
80101945:	5b                   	pop    %ebx
      return iget(dev, inum);
80101946:	89 f0                	mov    %esi,%eax
}
80101948:	5e                   	pop    %esi
80101949:	5f                   	pop    %edi
8010194a:	5d                   	pop    %ebp
      return iget(dev, inum);
8010194b:	e9 10 fc ff ff       	jmp    80101560 <iget>
  panic("ialloc: no inodes");
80101950:	83 ec 0c             	sub    $0xc,%esp
80101953:	68 e7 74 10 80       	push   $0x801074e7
80101958:	e8 23 ea ff ff       	call   80100380 <panic>
8010195d:	8d 76 00             	lea    0x0(%esi),%esi

80101960 <iupdate>:
{
80101960:	55                   	push   %ebp
80101961:	89 e5                	mov    %esp,%ebp
80101963:	56                   	push   %esi
80101964:	53                   	push   %ebx
80101965:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101968:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010196b:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010196e:	83 ec 08             	sub    $0x8,%esp
80101971:	c1 e8 03             	shr    $0x3,%eax
80101974:	03 05 08 17 11 80    	add    0x80111708,%eax
8010197a:	50                   	push   %eax
8010197b:	ff 73 a4             	push   -0x5c(%ebx)
8010197e:	e8 4d e7 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
80101983:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101987:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
8010198a:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010198c:	8b 43 a8             	mov    -0x58(%ebx),%eax
8010198f:	83 e0 07             	and    $0x7,%eax
80101992:	c1 e0 06             	shl    $0x6,%eax
80101995:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101999:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010199c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801019a0:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
801019a3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
801019a7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
801019ab:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
801019af:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
801019b3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
801019b7:	8b 53 fc             	mov    -0x4(%ebx),%edx
801019ba:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801019bd:	6a 34                	push   $0x34
801019bf:	53                   	push   %ebx
801019c0:	50                   	push   %eax
801019c1:	e8 ea 2f 00 00       	call   801049b0 <memmove>
  log_write(bp);
801019c6:	89 34 24             	mov    %esi,(%esp)
801019c9:	e8 d2 17 00 00       	call   801031a0 <log_write>
  brelse(bp);
801019ce:	83 c4 10             	add    $0x10,%esp
801019d1:	89 75 08             	mov    %esi,0x8(%ebp)
}
801019d4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801019d7:	5b                   	pop    %ebx
801019d8:	5e                   	pop    %esi
801019d9:	5d                   	pop    %ebp
  brelse(bp);
801019da:	e9 11 e8 ff ff       	jmp    801001f0 <brelse>
801019df:	90                   	nop

801019e0 <idup>:
{
801019e0:	55                   	push   %ebp
801019e1:	89 e5                	mov    %esp,%ebp
801019e3:	53                   	push   %ebx
801019e4:	83 ec 10             	sub    $0x10,%esp
801019e7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
801019ea:	68 a0 fa 10 80       	push   $0x8010faa0
801019ef:	e8 2c 2e 00 00       	call   80104820 <acquire>
  ip->ref++;
801019f4:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
801019f8:	c7 04 24 a0 fa 10 80 	movl   $0x8010faa0,(%esp)
801019ff:	e8 bc 2d 00 00       	call   801047c0 <release>
}
80101a04:	89 d8                	mov    %ebx,%eax
80101a06:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101a09:	c9                   	leave
80101a0a:	c3                   	ret
80101a0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101a10 <ilock>:
{
80101a10:	55                   	push   %ebp
80101a11:	89 e5                	mov    %esp,%ebp
80101a13:	56                   	push   %esi
80101a14:	53                   	push   %ebx
80101a15:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101a18:	85 db                	test   %ebx,%ebx
80101a1a:	0f 84 b7 00 00 00    	je     80101ad7 <ilock+0xc7>
80101a20:	8b 53 08             	mov    0x8(%ebx),%edx
80101a23:	85 d2                	test   %edx,%edx
80101a25:	0f 8e ac 00 00 00    	jle    80101ad7 <ilock+0xc7>
  acquiresleep(&ip->lock);
80101a2b:	83 ec 0c             	sub    $0xc,%esp
80101a2e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101a31:	50                   	push   %eax
80101a32:	e8 09 2b 00 00       	call   80104540 <acquiresleep>
  if(ip->valid == 0){
80101a37:	8b 43 4c             	mov    0x4c(%ebx),%eax
80101a3a:	83 c4 10             	add    $0x10,%esp
80101a3d:	85 c0                	test   %eax,%eax
80101a3f:	74 0f                	je     80101a50 <ilock+0x40>
}
80101a41:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101a44:	5b                   	pop    %ebx
80101a45:	5e                   	pop    %esi
80101a46:	5d                   	pop    %ebp
80101a47:	c3                   	ret
80101a48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101a4f:	00 
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101a50:	8b 43 04             	mov    0x4(%ebx),%eax
80101a53:	83 ec 08             	sub    $0x8,%esp
80101a56:	c1 e8 03             	shr    $0x3,%eax
80101a59:	03 05 08 17 11 80    	add    0x80111708,%eax
80101a5f:	50                   	push   %eax
80101a60:	ff 33                	push   (%ebx)
80101a62:	e8 69 e6 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101a67:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101a6a:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101a6c:	8b 43 04             	mov    0x4(%ebx),%eax
80101a6f:	83 e0 07             	and    $0x7,%eax
80101a72:	c1 e0 06             	shl    $0x6,%eax
80101a75:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
80101a79:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101a7c:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
80101a7f:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101a83:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101a87:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
80101a8b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
80101a8f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101a93:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101a97:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
80101a9b:	8b 50 fc             	mov    -0x4(%eax),%edx
80101a9e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101aa1:	6a 34                	push   $0x34
80101aa3:	50                   	push   %eax
80101aa4:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101aa7:	50                   	push   %eax
80101aa8:	e8 03 2f 00 00       	call   801049b0 <memmove>
    brelse(bp);
80101aad:	89 34 24             	mov    %esi,(%esp)
80101ab0:	e8 3b e7 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101ab5:	83 c4 10             	add    $0x10,%esp
80101ab8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
80101abd:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101ac4:	0f 85 77 ff ff ff    	jne    80101a41 <ilock+0x31>
      panic("ilock: no type");
80101aca:	83 ec 0c             	sub    $0xc,%esp
80101acd:	68 ff 74 10 80       	push   $0x801074ff
80101ad2:	e8 a9 e8 ff ff       	call   80100380 <panic>
    panic("ilock");
80101ad7:	83 ec 0c             	sub    $0xc,%esp
80101ada:	68 f9 74 10 80       	push   $0x801074f9
80101adf:	e8 9c e8 ff ff       	call   80100380 <panic>
80101ae4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101aeb:	00 
80101aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101af0 <iunlock>:
{
80101af0:	55                   	push   %ebp
80101af1:	89 e5                	mov    %esp,%ebp
80101af3:	56                   	push   %esi
80101af4:	53                   	push   %ebx
80101af5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101af8:	85 db                	test   %ebx,%ebx
80101afa:	74 28                	je     80101b24 <iunlock+0x34>
80101afc:	83 ec 0c             	sub    $0xc,%esp
80101aff:	8d 73 0c             	lea    0xc(%ebx),%esi
80101b02:	56                   	push   %esi
80101b03:	e8 d8 2a 00 00       	call   801045e0 <holdingsleep>
80101b08:	83 c4 10             	add    $0x10,%esp
80101b0b:	85 c0                	test   %eax,%eax
80101b0d:	74 15                	je     80101b24 <iunlock+0x34>
80101b0f:	8b 43 08             	mov    0x8(%ebx),%eax
80101b12:	85 c0                	test   %eax,%eax
80101b14:	7e 0e                	jle    80101b24 <iunlock+0x34>
  releasesleep(&ip->lock);
80101b16:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101b19:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101b1c:	5b                   	pop    %ebx
80101b1d:	5e                   	pop    %esi
80101b1e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
80101b1f:	e9 7c 2a 00 00       	jmp    801045a0 <releasesleep>
    panic("iunlock");
80101b24:	83 ec 0c             	sub    $0xc,%esp
80101b27:	68 0e 75 10 80       	push   $0x8010750e
80101b2c:	e8 4f e8 ff ff       	call   80100380 <panic>
80101b31:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101b38:	00 
80101b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101b40 <iput>:
{
80101b40:	55                   	push   %ebp
80101b41:	89 e5                	mov    %esp,%ebp
80101b43:	57                   	push   %edi
80101b44:	56                   	push   %esi
80101b45:	53                   	push   %ebx
80101b46:	83 ec 28             	sub    $0x28,%esp
80101b49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
80101b4c:	8d 7b 0c             	lea    0xc(%ebx),%edi
80101b4f:	57                   	push   %edi
80101b50:	e8 eb 29 00 00       	call   80104540 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
80101b55:	8b 53 4c             	mov    0x4c(%ebx),%edx
80101b58:	83 c4 10             	add    $0x10,%esp
80101b5b:	85 d2                	test   %edx,%edx
80101b5d:	74 07                	je     80101b66 <iput+0x26>
80101b5f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80101b64:	74 32                	je     80101b98 <iput+0x58>
  releasesleep(&ip->lock);
80101b66:	83 ec 0c             	sub    $0xc,%esp
80101b69:	57                   	push   %edi
80101b6a:	e8 31 2a 00 00       	call   801045a0 <releasesleep>
  acquire(&icache.lock);
80101b6f:	c7 04 24 a0 fa 10 80 	movl   $0x8010faa0,(%esp)
80101b76:	e8 a5 2c 00 00       	call   80104820 <acquire>
  ip->ref--;
80101b7b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101b7f:	83 c4 10             	add    $0x10,%esp
80101b82:	c7 45 08 a0 fa 10 80 	movl   $0x8010faa0,0x8(%ebp)
}
80101b89:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b8c:	5b                   	pop    %ebx
80101b8d:	5e                   	pop    %esi
80101b8e:	5f                   	pop    %edi
80101b8f:	5d                   	pop    %ebp
  release(&icache.lock);
80101b90:	e9 2b 2c 00 00       	jmp    801047c0 <release>
80101b95:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101b98:	83 ec 0c             	sub    $0xc,%esp
80101b9b:	68 a0 fa 10 80       	push   $0x8010faa0
80101ba0:	e8 7b 2c 00 00       	call   80104820 <acquire>
    int r = ip->ref;
80101ba5:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101ba8:	c7 04 24 a0 fa 10 80 	movl   $0x8010faa0,(%esp)
80101baf:	e8 0c 2c 00 00       	call   801047c0 <release>
    if(r == 1){
80101bb4:	83 c4 10             	add    $0x10,%esp
80101bb7:	83 fe 01             	cmp    $0x1,%esi
80101bba:	75 aa                	jne    80101b66 <iput+0x26>
80101bbc:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101bc2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101bc5:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101bc8:	89 df                	mov    %ebx,%edi
80101bca:	89 cb                	mov    %ecx,%ebx
80101bcc:	eb 09                	jmp    80101bd7 <iput+0x97>
80101bce:	66 90                	xchg   %ax,%ax
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101bd0:	83 c6 04             	add    $0x4,%esi
80101bd3:	39 de                	cmp    %ebx,%esi
80101bd5:	74 19                	je     80101bf0 <iput+0xb0>
    if(ip->addrs[i]){
80101bd7:	8b 16                	mov    (%esi),%edx
80101bd9:	85 d2                	test   %edx,%edx
80101bdb:	74 f3                	je     80101bd0 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101bdd:	8b 07                	mov    (%edi),%eax
80101bdf:	e8 7c fa ff ff       	call   80101660 <bfree>
      ip->addrs[i] = 0;
80101be4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101bea:	eb e4                	jmp    80101bd0 <iput+0x90>
80101bec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101bf0:	89 fb                	mov    %edi,%ebx
80101bf2:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101bf5:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101bfb:	85 c0                	test   %eax,%eax
80101bfd:	75 2d                	jne    80101c2c <iput+0xec>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101bff:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101c02:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101c09:	53                   	push   %ebx
80101c0a:	e8 51 fd ff ff       	call   80101960 <iupdate>
      ip->type = 0;
80101c0f:	31 c0                	xor    %eax,%eax
80101c11:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101c15:	89 1c 24             	mov    %ebx,(%esp)
80101c18:	e8 43 fd ff ff       	call   80101960 <iupdate>
      ip->valid = 0;
80101c1d:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101c24:	83 c4 10             	add    $0x10,%esp
80101c27:	e9 3a ff ff ff       	jmp    80101b66 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101c2c:	83 ec 08             	sub    $0x8,%esp
80101c2f:	50                   	push   %eax
80101c30:	ff 33                	push   (%ebx)
80101c32:	e8 99 e4 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
80101c37:	83 c4 10             	add    $0x10,%esp
80101c3a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101c3d:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101c43:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101c46:	8d 70 5c             	lea    0x5c(%eax),%esi
80101c49:	89 cf                	mov    %ecx,%edi
80101c4b:	eb 0a                	jmp    80101c57 <iput+0x117>
80101c4d:	8d 76 00             	lea    0x0(%esi),%esi
80101c50:	83 c6 04             	add    $0x4,%esi
80101c53:	39 fe                	cmp    %edi,%esi
80101c55:	74 0f                	je     80101c66 <iput+0x126>
      if(a[j])
80101c57:	8b 16                	mov    (%esi),%edx
80101c59:	85 d2                	test   %edx,%edx
80101c5b:	74 f3                	je     80101c50 <iput+0x110>
        bfree(ip->dev, a[j]);
80101c5d:	8b 03                	mov    (%ebx),%eax
80101c5f:	e8 fc f9 ff ff       	call   80101660 <bfree>
80101c64:	eb ea                	jmp    80101c50 <iput+0x110>
    brelse(bp);
80101c66:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101c69:	83 ec 0c             	sub    $0xc,%esp
80101c6c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101c6f:	50                   	push   %eax
80101c70:	e8 7b e5 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101c75:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101c7b:	8b 03                	mov    (%ebx),%eax
80101c7d:	e8 de f9 ff ff       	call   80101660 <bfree>
    ip->addrs[NDIRECT] = 0;
80101c82:	83 c4 10             	add    $0x10,%esp
80101c85:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101c8c:	00 00 00 
80101c8f:	e9 6b ff ff ff       	jmp    80101bff <iput+0xbf>
80101c94:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101c9b:	00 
80101c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101ca0 <iunlockput>:
{
80101ca0:	55                   	push   %ebp
80101ca1:	89 e5                	mov    %esp,%ebp
80101ca3:	56                   	push   %esi
80101ca4:	53                   	push   %ebx
80101ca5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101ca8:	85 db                	test   %ebx,%ebx
80101caa:	74 34                	je     80101ce0 <iunlockput+0x40>
80101cac:	83 ec 0c             	sub    $0xc,%esp
80101caf:	8d 73 0c             	lea    0xc(%ebx),%esi
80101cb2:	56                   	push   %esi
80101cb3:	e8 28 29 00 00       	call   801045e0 <holdingsleep>
80101cb8:	83 c4 10             	add    $0x10,%esp
80101cbb:	85 c0                	test   %eax,%eax
80101cbd:	74 21                	je     80101ce0 <iunlockput+0x40>
80101cbf:	8b 43 08             	mov    0x8(%ebx),%eax
80101cc2:	85 c0                	test   %eax,%eax
80101cc4:	7e 1a                	jle    80101ce0 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101cc6:	83 ec 0c             	sub    $0xc,%esp
80101cc9:	56                   	push   %esi
80101cca:	e8 d1 28 00 00       	call   801045a0 <releasesleep>
  iput(ip);
80101ccf:	83 c4 10             	add    $0x10,%esp
80101cd2:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101cd5:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101cd8:	5b                   	pop    %ebx
80101cd9:	5e                   	pop    %esi
80101cda:	5d                   	pop    %ebp
  iput(ip);
80101cdb:	e9 60 fe ff ff       	jmp    80101b40 <iput>
    panic("iunlock");
80101ce0:	83 ec 0c             	sub    $0xc,%esp
80101ce3:	68 0e 75 10 80       	push   $0x8010750e
80101ce8:	e8 93 e6 ff ff       	call   80100380 <panic>
80101ced:	8d 76 00             	lea    0x0(%esi),%esi

80101cf0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101cf0:	55                   	push   %ebp
80101cf1:	89 e5                	mov    %esp,%ebp
80101cf3:	8b 55 08             	mov    0x8(%ebp),%edx
80101cf6:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101cf9:	8b 0a                	mov    (%edx),%ecx
80101cfb:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101cfe:	8b 4a 04             	mov    0x4(%edx),%ecx
80101d01:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101d04:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101d08:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101d0b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101d0f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101d13:	8b 52 58             	mov    0x58(%edx),%edx
80101d16:	89 50 10             	mov    %edx,0x10(%eax)
}
80101d19:	5d                   	pop    %ebp
80101d1a:	c3                   	ret
80101d1b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101d20 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101d20:	55                   	push   %ebp
80101d21:	89 e5                	mov    %esp,%ebp
80101d23:	57                   	push   %edi
80101d24:	56                   	push   %esi
80101d25:	53                   	push   %ebx
80101d26:	83 ec 1c             	sub    $0x1c,%esp
80101d29:	8b 75 08             	mov    0x8(%ebp),%esi
80101d2c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d2f:	8b 7d 10             	mov    0x10(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101d32:	66 83 7e 50 03       	cmpw   $0x3,0x50(%esi)
{
80101d37:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101d3a:	89 75 d8             	mov    %esi,-0x28(%ebp)
80101d3d:	8b 45 14             	mov    0x14(%ebp),%eax
  if(ip->type == T_DEV){
80101d40:	0f 84 aa 00 00 00    	je     80101df0 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101d46:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101d49:	8b 56 58             	mov    0x58(%esi),%edx
80101d4c:	39 fa                	cmp    %edi,%edx
80101d4e:	0f 82 bd 00 00 00    	jb     80101e11 <readi+0xf1>
80101d54:	89 f9                	mov    %edi,%ecx
80101d56:	31 db                	xor    %ebx,%ebx
80101d58:	01 c1                	add    %eax,%ecx
80101d5a:	0f 92 c3             	setb   %bl
80101d5d:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80101d60:	0f 82 ab 00 00 00    	jb     80101e11 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101d66:	89 d3                	mov    %edx,%ebx
80101d68:	29 fb                	sub    %edi,%ebx
80101d6a:	39 ca                	cmp    %ecx,%edx
80101d6c:	0f 42 c3             	cmovb  %ebx,%eax

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101d6f:	85 c0                	test   %eax,%eax
80101d71:	74 73                	je     80101de6 <readi+0xc6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101d73:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101d76:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d80:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101d83:	89 fa                	mov    %edi,%edx
80101d85:	c1 ea 09             	shr    $0x9,%edx
80101d88:	89 d8                	mov    %ebx,%eax
80101d8a:	e8 51 f9 ff ff       	call   801016e0 <bmap>
80101d8f:	83 ec 08             	sub    $0x8,%esp
80101d92:	50                   	push   %eax
80101d93:	ff 33                	push   (%ebx)
80101d95:	e8 36 e3 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101d9a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101d9d:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101da2:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101da4:	89 f8                	mov    %edi,%eax
80101da6:	25 ff 01 00 00       	and    $0x1ff,%eax
80101dab:	29 f3                	sub    %esi,%ebx
80101dad:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101daf:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101db3:	39 d9                	cmp    %ebx,%ecx
80101db5:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101db8:	83 c4 0c             	add    $0xc,%esp
80101dbb:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101dbc:	01 de                	add    %ebx,%esi
80101dbe:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101dc0:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101dc3:	50                   	push   %eax
80101dc4:	ff 75 e0             	push   -0x20(%ebp)
80101dc7:	e8 e4 2b 00 00       	call   801049b0 <memmove>
    brelse(bp);
80101dcc:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101dcf:	89 14 24             	mov    %edx,(%esp)
80101dd2:	e8 19 e4 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101dd7:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101dda:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101ddd:	83 c4 10             	add    $0x10,%esp
80101de0:	39 de                	cmp    %ebx,%esi
80101de2:	72 9c                	jb     80101d80 <readi+0x60>
80101de4:	89 d8                	mov    %ebx,%eax
  }
  return n;
}
80101de6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101de9:	5b                   	pop    %ebx
80101dea:	5e                   	pop    %esi
80101deb:	5f                   	pop    %edi
80101dec:	5d                   	pop    %ebp
80101ded:	c3                   	ret
80101dee:	66 90                	xchg   %ax,%ax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101df0:	0f bf 56 52          	movswl 0x52(%esi),%edx
80101df4:	66 83 fa 09          	cmp    $0x9,%dx
80101df8:	77 17                	ja     80101e11 <readi+0xf1>
80101dfa:	8b 14 d5 40 fa 10 80 	mov    -0x7fef05c0(,%edx,8),%edx
80101e01:	85 d2                	test   %edx,%edx
80101e03:	74 0c                	je     80101e11 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101e05:	89 45 10             	mov    %eax,0x10(%ebp)
}
80101e08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e0b:	5b                   	pop    %ebx
80101e0c:	5e                   	pop    %esi
80101e0d:	5f                   	pop    %edi
80101e0e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101e0f:	ff e2                	jmp    *%edx
      return -1;
80101e11:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101e16:	eb ce                	jmp    80101de6 <readi+0xc6>
80101e18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101e1f:	00 

80101e20 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101e20:	55                   	push   %ebp
80101e21:	89 e5                	mov    %esp,%ebp
80101e23:	57                   	push   %edi
80101e24:	56                   	push   %esi
80101e25:	53                   	push   %ebx
80101e26:	83 ec 1c             	sub    $0x1c,%esp
80101e29:	8b 45 08             	mov    0x8(%ebp),%eax
80101e2c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101e2f:	8b 75 14             	mov    0x14(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101e32:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101e37:	89 7d dc             	mov    %edi,-0x24(%ebp)
80101e3a:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101e3d:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(ip->type == T_DEV){
80101e40:	0f 84 ba 00 00 00    	je     80101f00 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101e46:	39 78 58             	cmp    %edi,0x58(%eax)
80101e49:	0f 82 ea 00 00 00    	jb     80101f39 <writei+0x119>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101e4f:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101e52:	89 f2                	mov    %esi,%edx
80101e54:	01 fa                	add    %edi,%edx
80101e56:	0f 82 dd 00 00 00    	jb     80101f39 <writei+0x119>
80101e5c:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
80101e62:	0f 87 d1 00 00 00    	ja     80101f39 <writei+0x119>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101e68:	85 f6                	test   %esi,%esi
80101e6a:	0f 84 85 00 00 00    	je     80101ef5 <writei+0xd5>
80101e70:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101e77:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101e7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101e80:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101e83:	89 fa                	mov    %edi,%edx
80101e85:	c1 ea 09             	shr    $0x9,%edx
80101e88:	89 f0                	mov    %esi,%eax
80101e8a:	e8 51 f8 ff ff       	call   801016e0 <bmap>
80101e8f:	83 ec 08             	sub    $0x8,%esp
80101e92:	50                   	push   %eax
80101e93:	ff 36                	push   (%esi)
80101e95:	e8 36 e2 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101e9a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101e9d:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101ea0:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ea5:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80101ea7:	89 f8                	mov    %edi,%eax
80101ea9:	25 ff 01 00 00       	and    $0x1ff,%eax
80101eae:	29 d3                	sub    %edx,%ebx
80101eb0:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101eb2:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101eb6:	39 d9                	cmp    %ebx,%ecx
80101eb8:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101ebb:	83 c4 0c             	add    $0xc,%esp
80101ebe:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ebf:	01 df                	add    %ebx,%edi
    memmove(bp->data + off%BSIZE, src, m);
80101ec1:	ff 75 dc             	push   -0x24(%ebp)
80101ec4:	50                   	push   %eax
80101ec5:	e8 e6 2a 00 00       	call   801049b0 <memmove>
    log_write(bp);
80101eca:	89 34 24             	mov    %esi,(%esp)
80101ecd:	e8 ce 12 00 00       	call   801031a0 <log_write>
    brelse(bp);
80101ed2:	89 34 24             	mov    %esi,(%esp)
80101ed5:	e8 16 e3 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101eda:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101edd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101ee0:	83 c4 10             	add    $0x10,%esp
80101ee3:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101ee6:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101ee9:	39 d8                	cmp    %ebx,%eax
80101eeb:	72 93                	jb     80101e80 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101eed:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101ef0:	39 78 58             	cmp    %edi,0x58(%eax)
80101ef3:	72 33                	jb     80101f28 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101ef5:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101ef8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101efb:	5b                   	pop    %ebx
80101efc:	5e                   	pop    %esi
80101efd:	5f                   	pop    %edi
80101efe:	5d                   	pop    %ebp
80101eff:	c3                   	ret
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101f00:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101f04:	66 83 f8 09          	cmp    $0x9,%ax
80101f08:	77 2f                	ja     80101f39 <writei+0x119>
80101f0a:	8b 04 c5 44 fa 10 80 	mov    -0x7fef05bc(,%eax,8),%eax
80101f11:	85 c0                	test   %eax,%eax
80101f13:	74 24                	je     80101f39 <writei+0x119>
    return devsw[ip->major].write(ip, src, n);
80101f15:	89 75 10             	mov    %esi,0x10(%ebp)
}
80101f18:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f1b:	5b                   	pop    %ebx
80101f1c:	5e                   	pop    %esi
80101f1d:	5f                   	pop    %edi
80101f1e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101f1f:	ff e0                	jmp    *%eax
80101f21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iupdate(ip);
80101f28:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101f2b:	89 78 58             	mov    %edi,0x58(%eax)
    iupdate(ip);
80101f2e:	50                   	push   %eax
80101f2f:	e8 2c fa ff ff       	call   80101960 <iupdate>
80101f34:	83 c4 10             	add    $0x10,%esp
80101f37:	eb bc                	jmp    80101ef5 <writei+0xd5>
      return -1;
80101f39:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f3e:	eb b8                	jmp    80101ef8 <writei+0xd8>

80101f40 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101f40:	55                   	push   %ebp
80101f41:	89 e5                	mov    %esp,%ebp
80101f43:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101f46:	6a 0e                	push   $0xe
80101f48:	ff 75 0c             	push   0xc(%ebp)
80101f4b:	ff 75 08             	push   0x8(%ebp)
80101f4e:	e8 cd 2a 00 00       	call   80104a20 <strncmp>
}
80101f53:	c9                   	leave
80101f54:	c3                   	ret
80101f55:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101f5c:	00 
80101f5d:	8d 76 00             	lea    0x0(%esi),%esi

80101f60 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101f60:	55                   	push   %ebp
80101f61:	89 e5                	mov    %esp,%ebp
80101f63:	57                   	push   %edi
80101f64:	56                   	push   %esi
80101f65:	53                   	push   %ebx
80101f66:	83 ec 1c             	sub    $0x1c,%esp
80101f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101f6c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101f71:	0f 85 85 00 00 00    	jne    80101ffc <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101f77:	8b 53 58             	mov    0x58(%ebx),%edx
80101f7a:	31 ff                	xor    %edi,%edi
80101f7c:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101f7f:	85 d2                	test   %edx,%edx
80101f81:	74 3e                	je     80101fc1 <dirlookup+0x61>
80101f83:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101f88:	6a 10                	push   $0x10
80101f8a:	57                   	push   %edi
80101f8b:	56                   	push   %esi
80101f8c:	53                   	push   %ebx
80101f8d:	e8 8e fd ff ff       	call   80101d20 <readi>
80101f92:	83 c4 10             	add    $0x10,%esp
80101f95:	83 f8 10             	cmp    $0x10,%eax
80101f98:	75 55                	jne    80101fef <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101f9a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101f9f:	74 18                	je     80101fb9 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101fa1:	83 ec 04             	sub    $0x4,%esp
80101fa4:	8d 45 da             	lea    -0x26(%ebp),%eax
80101fa7:	6a 0e                	push   $0xe
80101fa9:	50                   	push   %eax
80101faa:	ff 75 0c             	push   0xc(%ebp)
80101fad:	e8 6e 2a 00 00       	call   80104a20 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101fb2:	83 c4 10             	add    $0x10,%esp
80101fb5:	85 c0                	test   %eax,%eax
80101fb7:	74 17                	je     80101fd0 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101fb9:	83 c7 10             	add    $0x10,%edi
80101fbc:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101fbf:	72 c7                	jb     80101f88 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101fc1:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101fc4:	31 c0                	xor    %eax,%eax
}
80101fc6:	5b                   	pop    %ebx
80101fc7:	5e                   	pop    %esi
80101fc8:	5f                   	pop    %edi
80101fc9:	5d                   	pop    %ebp
80101fca:	c3                   	ret
80101fcb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(poff)
80101fd0:	8b 45 10             	mov    0x10(%ebp),%eax
80101fd3:	85 c0                	test   %eax,%eax
80101fd5:	74 05                	je     80101fdc <dirlookup+0x7c>
        *poff = off;
80101fd7:	8b 45 10             	mov    0x10(%ebp),%eax
80101fda:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101fdc:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101fe0:	8b 03                	mov    (%ebx),%eax
80101fe2:	e8 79 f5 ff ff       	call   80101560 <iget>
}
80101fe7:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fea:	5b                   	pop    %ebx
80101feb:	5e                   	pop    %esi
80101fec:	5f                   	pop    %edi
80101fed:	5d                   	pop    %ebp
80101fee:	c3                   	ret
      panic("dirlookup read");
80101fef:	83 ec 0c             	sub    $0xc,%esp
80101ff2:	68 28 75 10 80       	push   $0x80107528
80101ff7:	e8 84 e3 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
80101ffc:	83 ec 0c             	sub    $0xc,%esp
80101fff:	68 16 75 10 80       	push   $0x80107516
80102004:	e8 77 e3 ff ff       	call   80100380 <panic>
80102009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102010 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80102010:	55                   	push   %ebp
80102011:	89 e5                	mov    %esp,%ebp
80102013:	57                   	push   %edi
80102014:	56                   	push   %esi
80102015:	53                   	push   %ebx
80102016:	89 c3                	mov    %eax,%ebx
80102018:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
8010201b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
8010201e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102021:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80102024:	0f 84 9e 01 00 00    	je     801021c8 <namex+0x1b8>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
8010202a:	e8 b1 1b 00 00       	call   80103be0 <myproc>
  acquire(&icache.lock);
8010202f:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80102032:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80102035:	68 a0 fa 10 80       	push   $0x8010faa0
8010203a:	e8 e1 27 00 00       	call   80104820 <acquire>
  ip->ref++;
8010203f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80102043:	c7 04 24 a0 fa 10 80 	movl   $0x8010faa0,(%esp)
8010204a:	e8 71 27 00 00       	call   801047c0 <release>
8010204f:	83 c4 10             	add    $0x10,%esp
80102052:	eb 07                	jmp    8010205b <namex+0x4b>
80102054:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80102058:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
8010205b:	0f b6 03             	movzbl (%ebx),%eax
8010205e:	3c 2f                	cmp    $0x2f,%al
80102060:	74 f6                	je     80102058 <namex+0x48>
  if(*path == 0)
80102062:	84 c0                	test   %al,%al
80102064:	0f 84 06 01 00 00    	je     80102170 <namex+0x160>
  while(*path != '/' && *path != 0)
8010206a:	0f b6 03             	movzbl (%ebx),%eax
8010206d:	84 c0                	test   %al,%al
8010206f:	0f 84 10 01 00 00    	je     80102185 <namex+0x175>
80102075:	89 df                	mov    %ebx,%edi
80102077:	3c 2f                	cmp    $0x2f,%al
80102079:	0f 84 06 01 00 00    	je     80102185 <namex+0x175>
8010207f:	90                   	nop
80102080:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80102084:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80102087:	3c 2f                	cmp    $0x2f,%al
80102089:	74 04                	je     8010208f <namex+0x7f>
8010208b:	84 c0                	test   %al,%al
8010208d:	75 f1                	jne    80102080 <namex+0x70>
  len = path - s;
8010208f:	89 f8                	mov    %edi,%eax
80102091:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80102093:	83 f8 0d             	cmp    $0xd,%eax
80102096:	0f 8e ac 00 00 00    	jle    80102148 <namex+0x138>
    memmove(name, s, DIRSIZ);
8010209c:	83 ec 04             	sub    $0x4,%esp
8010209f:	6a 0e                	push   $0xe
801020a1:	53                   	push   %ebx
801020a2:	89 fb                	mov    %edi,%ebx
801020a4:	ff 75 e4             	push   -0x1c(%ebp)
801020a7:	e8 04 29 00 00       	call   801049b0 <memmove>
801020ac:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
801020af:	80 3f 2f             	cmpb   $0x2f,(%edi)
801020b2:	75 0c                	jne    801020c0 <namex+0xb0>
801020b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
801020b8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
801020bb:	80 3b 2f             	cmpb   $0x2f,(%ebx)
801020be:	74 f8                	je     801020b8 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
801020c0:	83 ec 0c             	sub    $0xc,%esp
801020c3:	56                   	push   %esi
801020c4:	e8 47 f9 ff ff       	call   80101a10 <ilock>
    if(ip->type != T_DIR){
801020c9:	83 c4 10             	add    $0x10,%esp
801020cc:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801020d1:	0f 85 b7 00 00 00    	jne    8010218e <namex+0x17e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
801020d7:	8b 45 dc             	mov    -0x24(%ebp),%eax
801020da:	85 c0                	test   %eax,%eax
801020dc:	74 09                	je     801020e7 <namex+0xd7>
801020de:	80 3b 00             	cmpb   $0x0,(%ebx)
801020e1:	0f 84 f7 00 00 00    	je     801021de <namex+0x1ce>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
801020e7:	83 ec 04             	sub    $0x4,%esp
801020ea:	6a 00                	push   $0x0
801020ec:	ff 75 e4             	push   -0x1c(%ebp)
801020ef:	56                   	push   %esi
801020f0:	e8 6b fe ff ff       	call   80101f60 <dirlookup>
801020f5:	83 c4 10             	add    $0x10,%esp
801020f8:	89 c7                	mov    %eax,%edi
801020fa:	85 c0                	test   %eax,%eax
801020fc:	0f 84 8c 00 00 00    	je     8010218e <namex+0x17e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80102102:	83 ec 0c             	sub    $0xc,%esp
80102105:	8d 4e 0c             	lea    0xc(%esi),%ecx
80102108:	51                   	push   %ecx
80102109:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010210c:	e8 cf 24 00 00       	call   801045e0 <holdingsleep>
80102111:	83 c4 10             	add    $0x10,%esp
80102114:	85 c0                	test   %eax,%eax
80102116:	0f 84 02 01 00 00    	je     8010221e <namex+0x20e>
8010211c:	8b 56 08             	mov    0x8(%esi),%edx
8010211f:	85 d2                	test   %edx,%edx
80102121:	0f 8e f7 00 00 00    	jle    8010221e <namex+0x20e>
  releasesleep(&ip->lock);
80102127:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010212a:	83 ec 0c             	sub    $0xc,%esp
8010212d:	51                   	push   %ecx
8010212e:	e8 6d 24 00 00       	call   801045a0 <releasesleep>
  iput(ip);
80102133:	89 34 24             	mov    %esi,(%esp)
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80102136:	89 fe                	mov    %edi,%esi
  iput(ip);
80102138:	e8 03 fa ff ff       	call   80101b40 <iput>
8010213d:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80102140:	e9 16 ff ff ff       	jmp    8010205b <namex+0x4b>
80102145:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80102148:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010214b:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    memmove(name, s, len);
8010214e:	83 ec 04             	sub    $0x4,%esp
80102151:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80102154:	50                   	push   %eax
80102155:	53                   	push   %ebx
    name[len] = 0;
80102156:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80102158:	ff 75 e4             	push   -0x1c(%ebp)
8010215b:	e8 50 28 00 00       	call   801049b0 <memmove>
    name[len] = 0;
80102160:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80102163:	83 c4 10             	add    $0x10,%esp
80102166:	c6 01 00             	movb   $0x0,(%ecx)
80102169:	e9 41 ff ff ff       	jmp    801020af <namex+0x9f>
8010216e:	66 90                	xchg   %ax,%ax
  }
  if(nameiparent){
80102170:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102173:	85 c0                	test   %eax,%eax
80102175:	0f 85 93 00 00 00    	jne    8010220e <namex+0x1fe>
    iput(ip);
    return 0;
  }
  return ip;
}
8010217b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010217e:	89 f0                	mov    %esi,%eax
80102180:	5b                   	pop    %ebx
80102181:	5e                   	pop    %esi
80102182:	5f                   	pop    %edi
80102183:	5d                   	pop    %ebp
80102184:	c3                   	ret
  while(*path != '/' && *path != 0)
80102185:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102188:	89 df                	mov    %ebx,%edi
8010218a:	31 c0                	xor    %eax,%eax
8010218c:	eb c0                	jmp    8010214e <namex+0x13e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010218e:	83 ec 0c             	sub    $0xc,%esp
80102191:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102194:	53                   	push   %ebx
80102195:	e8 46 24 00 00       	call   801045e0 <holdingsleep>
8010219a:	83 c4 10             	add    $0x10,%esp
8010219d:	85 c0                	test   %eax,%eax
8010219f:	74 7d                	je     8010221e <namex+0x20e>
801021a1:	8b 4e 08             	mov    0x8(%esi),%ecx
801021a4:	85 c9                	test   %ecx,%ecx
801021a6:	7e 76                	jle    8010221e <namex+0x20e>
  releasesleep(&ip->lock);
801021a8:	83 ec 0c             	sub    $0xc,%esp
801021ab:	53                   	push   %ebx
801021ac:	e8 ef 23 00 00       	call   801045a0 <releasesleep>
  iput(ip);
801021b1:	89 34 24             	mov    %esi,(%esp)
      return 0;
801021b4:	31 f6                	xor    %esi,%esi
  iput(ip);
801021b6:	e8 85 f9 ff ff       	call   80101b40 <iput>
      return 0;
801021bb:	83 c4 10             	add    $0x10,%esp
}
801021be:	8d 65 f4             	lea    -0xc(%ebp),%esp
801021c1:	89 f0                	mov    %esi,%eax
801021c3:	5b                   	pop    %ebx
801021c4:	5e                   	pop    %esi
801021c5:	5f                   	pop    %edi
801021c6:	5d                   	pop    %ebp
801021c7:	c3                   	ret
    ip = iget(ROOTDEV, ROOTINO);
801021c8:	ba 01 00 00 00       	mov    $0x1,%edx
801021cd:	b8 01 00 00 00       	mov    $0x1,%eax
801021d2:	e8 89 f3 ff ff       	call   80101560 <iget>
801021d7:	89 c6                	mov    %eax,%esi
801021d9:	e9 7d fe ff ff       	jmp    8010205b <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
801021de:	83 ec 0c             	sub    $0xc,%esp
801021e1:	8d 5e 0c             	lea    0xc(%esi),%ebx
801021e4:	53                   	push   %ebx
801021e5:	e8 f6 23 00 00       	call   801045e0 <holdingsleep>
801021ea:	83 c4 10             	add    $0x10,%esp
801021ed:	85 c0                	test   %eax,%eax
801021ef:	74 2d                	je     8010221e <namex+0x20e>
801021f1:	8b 7e 08             	mov    0x8(%esi),%edi
801021f4:	85 ff                	test   %edi,%edi
801021f6:	7e 26                	jle    8010221e <namex+0x20e>
  releasesleep(&ip->lock);
801021f8:	83 ec 0c             	sub    $0xc,%esp
801021fb:	53                   	push   %ebx
801021fc:	e8 9f 23 00 00       	call   801045a0 <releasesleep>
}
80102201:	83 c4 10             	add    $0x10,%esp
}
80102204:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102207:	89 f0                	mov    %esi,%eax
80102209:	5b                   	pop    %ebx
8010220a:	5e                   	pop    %esi
8010220b:	5f                   	pop    %edi
8010220c:	5d                   	pop    %ebp
8010220d:	c3                   	ret
    iput(ip);
8010220e:	83 ec 0c             	sub    $0xc,%esp
80102211:	56                   	push   %esi
      return 0;
80102212:	31 f6                	xor    %esi,%esi
    iput(ip);
80102214:	e8 27 f9 ff ff       	call   80101b40 <iput>
    return 0;
80102219:	83 c4 10             	add    $0x10,%esp
8010221c:	eb a0                	jmp    801021be <namex+0x1ae>
    panic("iunlock");
8010221e:	83 ec 0c             	sub    $0xc,%esp
80102221:	68 0e 75 10 80       	push   $0x8010750e
80102226:	e8 55 e1 ff ff       	call   80100380 <panic>
8010222b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102230 <dirlink>:
{
80102230:	55                   	push   %ebp
80102231:	89 e5                	mov    %esp,%ebp
80102233:	57                   	push   %edi
80102234:	56                   	push   %esi
80102235:	53                   	push   %ebx
80102236:	83 ec 20             	sub    $0x20,%esp
80102239:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
8010223c:	6a 00                	push   $0x0
8010223e:	ff 75 0c             	push   0xc(%ebp)
80102241:	53                   	push   %ebx
80102242:	e8 19 fd ff ff       	call   80101f60 <dirlookup>
80102247:	83 c4 10             	add    $0x10,%esp
8010224a:	85 c0                	test   %eax,%eax
8010224c:	75 67                	jne    801022b5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
8010224e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102251:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102254:	85 ff                	test   %edi,%edi
80102256:	74 29                	je     80102281 <dirlink+0x51>
80102258:	31 ff                	xor    %edi,%edi
8010225a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010225d:	eb 09                	jmp    80102268 <dirlink+0x38>
8010225f:	90                   	nop
80102260:	83 c7 10             	add    $0x10,%edi
80102263:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102266:	73 19                	jae    80102281 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102268:	6a 10                	push   $0x10
8010226a:	57                   	push   %edi
8010226b:	56                   	push   %esi
8010226c:	53                   	push   %ebx
8010226d:	e8 ae fa ff ff       	call   80101d20 <readi>
80102272:	83 c4 10             	add    $0x10,%esp
80102275:	83 f8 10             	cmp    $0x10,%eax
80102278:	75 4e                	jne    801022c8 <dirlink+0x98>
    if(de.inum == 0)
8010227a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010227f:	75 df                	jne    80102260 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80102281:	83 ec 04             	sub    $0x4,%esp
80102284:	8d 45 da             	lea    -0x26(%ebp),%eax
80102287:	6a 0e                	push   $0xe
80102289:	ff 75 0c             	push   0xc(%ebp)
8010228c:	50                   	push   %eax
8010228d:	e8 de 27 00 00       	call   80104a70 <strncpy>
  de.inum = inum;
80102292:	8b 45 10             	mov    0x10(%ebp),%eax
80102295:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102299:	6a 10                	push   $0x10
8010229b:	57                   	push   %edi
8010229c:	56                   	push   %esi
8010229d:	53                   	push   %ebx
8010229e:	e8 7d fb ff ff       	call   80101e20 <writei>
801022a3:	83 c4 20             	add    $0x20,%esp
801022a6:	83 f8 10             	cmp    $0x10,%eax
801022a9:	75 2a                	jne    801022d5 <dirlink+0xa5>
  return 0;
801022ab:	31 c0                	xor    %eax,%eax
}
801022ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
801022b0:	5b                   	pop    %ebx
801022b1:	5e                   	pop    %esi
801022b2:	5f                   	pop    %edi
801022b3:	5d                   	pop    %ebp
801022b4:	c3                   	ret
    iput(ip);
801022b5:	83 ec 0c             	sub    $0xc,%esp
801022b8:	50                   	push   %eax
801022b9:	e8 82 f8 ff ff       	call   80101b40 <iput>
    return -1;
801022be:	83 c4 10             	add    $0x10,%esp
801022c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801022c6:	eb e5                	jmp    801022ad <dirlink+0x7d>
      panic("dirlink read");
801022c8:	83 ec 0c             	sub    $0xc,%esp
801022cb:	68 37 75 10 80       	push   $0x80107537
801022d0:	e8 ab e0 ff ff       	call   80100380 <panic>
    panic("dirlink");
801022d5:	83 ec 0c             	sub    $0xc,%esp
801022d8:	68 93 77 10 80       	push   $0x80107793
801022dd:	e8 9e e0 ff ff       	call   80100380 <panic>
801022e2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801022e9:	00 
801022ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801022f0 <namei>:

struct inode*
namei(char *path)
{
801022f0:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
801022f1:	31 d2                	xor    %edx,%edx
{
801022f3:	89 e5                	mov    %esp,%ebp
801022f5:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
801022f8:	8b 45 08             	mov    0x8(%ebp),%eax
801022fb:	8d 4d ea             	lea    -0x16(%ebp),%ecx
801022fe:	e8 0d fd ff ff       	call   80102010 <namex>
}
80102303:	c9                   	leave
80102304:	c3                   	ret
80102305:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010230c:	00 
8010230d:	8d 76 00             	lea    0x0(%esi),%esi

80102310 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102310:	55                   	push   %ebp
  return namex(path, 1, name);
80102311:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102316:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102318:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010231b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010231e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010231f:	e9 ec fc ff ff       	jmp    80102010 <namex>
80102324:	66 90                	xchg   %ax,%ax
80102326:	66 90                	xchg   %ax,%ax
80102328:	66 90                	xchg   %ax,%ax
8010232a:	66 90                	xchg   %ax,%ax
8010232c:	66 90                	xchg   %ax,%ax
8010232e:	66 90                	xchg   %ax,%ax

80102330 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102330:	55                   	push   %ebp
80102331:	89 e5                	mov    %esp,%ebp
80102333:	57                   	push   %edi
80102334:	56                   	push   %esi
80102335:	53                   	push   %ebx
80102336:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102339:	85 c0                	test   %eax,%eax
8010233b:	0f 84 b4 00 00 00    	je     801023f5 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80102341:	8b 70 08             	mov    0x8(%eax),%esi
80102344:	89 c3                	mov    %eax,%ebx
80102346:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010234c:	0f 87 96 00 00 00    	ja     801023e8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102352:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102357:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010235e:	00 
8010235f:	90                   	nop
80102360:	89 ca                	mov    %ecx,%edx
80102362:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102363:	83 e0 c0             	and    $0xffffffc0,%eax
80102366:	3c 40                	cmp    $0x40,%al
80102368:	75 f6                	jne    80102360 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010236a:	31 ff                	xor    %edi,%edi
8010236c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102371:	89 f8                	mov    %edi,%eax
80102373:	ee                   	out    %al,(%dx)
80102374:	b8 01 00 00 00       	mov    $0x1,%eax
80102379:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010237e:	ee                   	out    %al,(%dx)
8010237f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102384:	89 f0                	mov    %esi,%eax
80102386:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80102387:	89 f0                	mov    %esi,%eax
80102389:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010238e:	c1 f8 08             	sar    $0x8,%eax
80102391:	ee                   	out    %al,(%dx)
80102392:	ba f5 01 00 00       	mov    $0x1f5,%edx
80102397:	89 f8                	mov    %edi,%eax
80102399:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
8010239a:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
8010239e:	ba f6 01 00 00       	mov    $0x1f6,%edx
801023a3:	c1 e0 04             	shl    $0x4,%eax
801023a6:	83 e0 10             	and    $0x10,%eax
801023a9:	83 c8 e0             	or     $0xffffffe0,%eax
801023ac:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
801023ad:	f6 03 04             	testb  $0x4,(%ebx)
801023b0:	75 16                	jne    801023c8 <idestart+0x98>
801023b2:	b8 20 00 00 00       	mov    $0x20,%eax
801023b7:	89 ca                	mov    %ecx,%edx
801023b9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
801023ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023bd:	5b                   	pop    %ebx
801023be:	5e                   	pop    %esi
801023bf:	5f                   	pop    %edi
801023c0:	5d                   	pop    %ebp
801023c1:	c3                   	ret
801023c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801023c8:	b8 30 00 00 00       	mov    $0x30,%eax
801023cd:	89 ca                	mov    %ecx,%edx
801023cf:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
801023d0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
801023d5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801023d8:	ba f0 01 00 00       	mov    $0x1f0,%edx
801023dd:	fc                   	cld
801023de:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
801023e0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023e3:	5b                   	pop    %ebx
801023e4:	5e                   	pop    %esi
801023e5:	5f                   	pop    %edi
801023e6:	5d                   	pop    %ebp
801023e7:	c3                   	ret
    panic("incorrect blockno");
801023e8:	83 ec 0c             	sub    $0xc,%esp
801023eb:	68 4d 75 10 80       	push   $0x8010754d
801023f0:	e8 8b df ff ff       	call   80100380 <panic>
    panic("idestart");
801023f5:	83 ec 0c             	sub    $0xc,%esp
801023f8:	68 44 75 10 80       	push   $0x80107544
801023fd:	e8 7e df ff ff       	call   80100380 <panic>
80102402:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102409:	00 
8010240a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102410 <ideinit>:
{
80102410:	55                   	push   %ebp
80102411:	89 e5                	mov    %esp,%ebp
80102413:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102416:	68 5f 75 10 80       	push   $0x8010755f
8010241b:	68 40 17 11 80       	push   $0x80111740
80102420:	e8 0b 22 00 00       	call   80104630 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102425:	58                   	pop    %eax
80102426:	a1 c4 18 11 80       	mov    0x801118c4,%eax
8010242b:	5a                   	pop    %edx
8010242c:	83 e8 01             	sub    $0x1,%eax
8010242f:	50                   	push   %eax
80102430:	6a 0e                	push   $0xe
80102432:	e8 99 02 00 00       	call   801026d0 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102437:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010243a:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
8010243f:	90                   	nop
80102440:	89 ca                	mov    %ecx,%edx
80102442:	ec                   	in     (%dx),%al
80102443:	83 e0 c0             	and    $0xffffffc0,%eax
80102446:	3c 40                	cmp    $0x40,%al
80102448:	75 f6                	jne    80102440 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010244a:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010244f:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102454:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102455:	89 ca                	mov    %ecx,%edx
80102457:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102458:	84 c0                	test   %al,%al
8010245a:	75 1e                	jne    8010247a <ideinit+0x6a>
8010245c:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80102461:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102466:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010246d:	00 
8010246e:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
80102470:	83 e9 01             	sub    $0x1,%ecx
80102473:	74 0f                	je     80102484 <ideinit+0x74>
80102475:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102476:	84 c0                	test   %al,%al
80102478:	74 f6                	je     80102470 <ideinit+0x60>
      havedisk1 = 1;
8010247a:	c7 05 20 17 11 80 01 	movl   $0x1,0x80111720
80102481:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102484:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102489:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010248e:	ee                   	out    %al,(%dx)
}
8010248f:	c9                   	leave
80102490:	c3                   	ret
80102491:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102498:	00 
80102499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801024a0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801024a0:	55                   	push   %ebp
801024a1:	89 e5                	mov    %esp,%ebp
801024a3:	57                   	push   %edi
801024a4:	56                   	push   %esi
801024a5:	53                   	push   %ebx
801024a6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801024a9:	68 40 17 11 80       	push   $0x80111740
801024ae:	e8 6d 23 00 00       	call   80104820 <acquire>

  if((b = idequeue) == 0){
801024b3:	8b 1d 24 17 11 80    	mov    0x80111724,%ebx
801024b9:	83 c4 10             	add    $0x10,%esp
801024bc:	85 db                	test   %ebx,%ebx
801024be:	74 63                	je     80102523 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801024c0:	8b 43 58             	mov    0x58(%ebx),%eax
801024c3:	a3 24 17 11 80       	mov    %eax,0x80111724

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801024c8:	8b 33                	mov    (%ebx),%esi
801024ca:	f7 c6 04 00 00 00    	test   $0x4,%esi
801024d0:	75 2f                	jne    80102501 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801024d2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801024d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801024de:	00 
801024df:	90                   	nop
801024e0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801024e1:	89 c1                	mov    %eax,%ecx
801024e3:	83 e1 c0             	and    $0xffffffc0,%ecx
801024e6:	80 f9 40             	cmp    $0x40,%cl
801024e9:	75 f5                	jne    801024e0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801024eb:	a8 21                	test   $0x21,%al
801024ed:	75 12                	jne    80102501 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
801024ef:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801024f2:	b9 80 00 00 00       	mov    $0x80,%ecx
801024f7:	ba f0 01 00 00       	mov    $0x1f0,%edx
801024fc:	fc                   	cld
801024fd:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
801024ff:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80102501:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102504:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102507:	83 ce 02             	or     $0x2,%esi
8010250a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010250c:	53                   	push   %ebx
8010250d:	e8 4e 1e 00 00       	call   80104360 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102512:	a1 24 17 11 80       	mov    0x80111724,%eax
80102517:	83 c4 10             	add    $0x10,%esp
8010251a:	85 c0                	test   %eax,%eax
8010251c:	74 05                	je     80102523 <ideintr+0x83>
    idestart(idequeue);
8010251e:	e8 0d fe ff ff       	call   80102330 <idestart>
    release(&idelock);
80102523:	83 ec 0c             	sub    $0xc,%esp
80102526:	68 40 17 11 80       	push   $0x80111740
8010252b:	e8 90 22 00 00       	call   801047c0 <release>

  release(&idelock);
}
80102530:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102533:	5b                   	pop    %ebx
80102534:	5e                   	pop    %esi
80102535:	5f                   	pop    %edi
80102536:	5d                   	pop    %ebp
80102537:	c3                   	ret
80102538:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010253f:	00 

80102540 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102540:	55                   	push   %ebp
80102541:	89 e5                	mov    %esp,%ebp
80102543:	53                   	push   %ebx
80102544:	83 ec 10             	sub    $0x10,%esp
80102547:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010254a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010254d:	50                   	push   %eax
8010254e:	e8 8d 20 00 00       	call   801045e0 <holdingsleep>
80102553:	83 c4 10             	add    $0x10,%esp
80102556:	85 c0                	test   %eax,%eax
80102558:	0f 84 c3 00 00 00    	je     80102621 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010255e:	8b 03                	mov    (%ebx),%eax
80102560:	83 e0 06             	and    $0x6,%eax
80102563:	83 f8 02             	cmp    $0x2,%eax
80102566:	0f 84 a8 00 00 00    	je     80102614 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010256c:	8b 53 04             	mov    0x4(%ebx),%edx
8010256f:	85 d2                	test   %edx,%edx
80102571:	74 0d                	je     80102580 <iderw+0x40>
80102573:	a1 20 17 11 80       	mov    0x80111720,%eax
80102578:	85 c0                	test   %eax,%eax
8010257a:	0f 84 87 00 00 00    	je     80102607 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102580:	83 ec 0c             	sub    $0xc,%esp
80102583:	68 40 17 11 80       	push   $0x80111740
80102588:	e8 93 22 00 00       	call   80104820 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010258d:	a1 24 17 11 80       	mov    0x80111724,%eax
  b->qnext = 0;
80102592:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102599:	83 c4 10             	add    $0x10,%esp
8010259c:	85 c0                	test   %eax,%eax
8010259e:	74 60                	je     80102600 <iderw+0xc0>
801025a0:	89 c2                	mov    %eax,%edx
801025a2:	8b 40 58             	mov    0x58(%eax),%eax
801025a5:	85 c0                	test   %eax,%eax
801025a7:	75 f7                	jne    801025a0 <iderw+0x60>
801025a9:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801025ac:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801025ae:	39 1d 24 17 11 80    	cmp    %ebx,0x80111724
801025b4:	74 3a                	je     801025f0 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801025b6:	8b 03                	mov    (%ebx),%eax
801025b8:	83 e0 06             	and    $0x6,%eax
801025bb:	83 f8 02             	cmp    $0x2,%eax
801025be:	74 1b                	je     801025db <iderw+0x9b>
    sleep(b, &idelock);
801025c0:	83 ec 08             	sub    $0x8,%esp
801025c3:	68 40 17 11 80       	push   $0x80111740
801025c8:	53                   	push   %ebx
801025c9:	e8 d2 1c 00 00       	call   801042a0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801025ce:	8b 03                	mov    (%ebx),%eax
801025d0:	83 c4 10             	add    $0x10,%esp
801025d3:	83 e0 06             	and    $0x6,%eax
801025d6:	83 f8 02             	cmp    $0x2,%eax
801025d9:	75 e5                	jne    801025c0 <iderw+0x80>
  }


  release(&idelock);
801025db:	c7 45 08 40 17 11 80 	movl   $0x80111740,0x8(%ebp)
}
801025e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801025e5:	c9                   	leave
  release(&idelock);
801025e6:	e9 d5 21 00 00       	jmp    801047c0 <release>
801025eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    idestart(b);
801025f0:	89 d8                	mov    %ebx,%eax
801025f2:	e8 39 fd ff ff       	call   80102330 <idestart>
801025f7:	eb bd                	jmp    801025b6 <iderw+0x76>
801025f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102600:	ba 24 17 11 80       	mov    $0x80111724,%edx
80102605:	eb a5                	jmp    801025ac <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80102607:	83 ec 0c             	sub    $0xc,%esp
8010260a:	68 8e 75 10 80       	push   $0x8010758e
8010260f:	e8 6c dd ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
80102614:	83 ec 0c             	sub    $0xc,%esp
80102617:	68 79 75 10 80       	push   $0x80107579
8010261c:	e8 5f dd ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
80102621:	83 ec 0c             	sub    $0xc,%esp
80102624:	68 63 75 10 80       	push   $0x80107563
80102629:	e8 52 dd ff ff       	call   80100380 <panic>
8010262e:	66 90                	xchg   %ax,%ax

80102630 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102630:	55                   	push   %ebp
80102631:	89 e5                	mov    %esp,%ebp
80102633:	56                   	push   %esi
80102634:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102635:	c7 05 74 17 11 80 00 	movl   $0xfec00000,0x80111774
8010263c:	00 c0 fe 
  ioapic->reg = reg;
8010263f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102646:	00 00 00 
  return ioapic->data;
80102649:	8b 15 74 17 11 80    	mov    0x80111774,%edx
8010264f:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
80102652:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
80102658:	8b 1d 74 17 11 80    	mov    0x80111774,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010265e:	0f b6 15 c0 18 11 80 	movzbl 0x801118c0,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102665:	c1 ee 10             	shr    $0x10,%esi
80102668:	89 f0                	mov    %esi,%eax
8010266a:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
8010266d:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
80102670:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102673:	39 c2                	cmp    %eax,%edx
80102675:	74 16                	je     8010268d <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102677:	83 ec 0c             	sub    $0xc,%esp
8010267a:	68 98 79 10 80       	push   $0x80107998
8010267f:	e8 bc e0 ff ff       	call   80100740 <cprintf>
  ioapic->reg = reg;
80102684:	8b 1d 74 17 11 80    	mov    0x80111774,%ebx
8010268a:	83 c4 10             	add    $0x10,%esp
{
8010268d:	ba 10 00 00 00       	mov    $0x10,%edx
80102692:	31 c0                	xor    %eax,%eax
80102694:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapic->reg = reg;
80102698:	89 13                	mov    %edx,(%ebx)
8010269a:	8d 48 20             	lea    0x20(%eax),%ecx
  ioapic->data = data;
8010269d:	8b 1d 74 17 11 80    	mov    0x80111774,%ebx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
801026a3:	83 c0 01             	add    $0x1,%eax
801026a6:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  ioapic->data = data;
801026ac:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
801026af:	8d 4a 01             	lea    0x1(%edx),%ecx
  for(i = 0; i <= maxintr; i++){
801026b2:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
801026b5:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
801026b7:	8b 1d 74 17 11 80    	mov    0x80111774,%ebx
801026bd:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
801026c4:	39 c6                	cmp    %eax,%esi
801026c6:	7d d0                	jge    80102698 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801026c8:	8d 65 f8             	lea    -0x8(%ebp),%esp
801026cb:	5b                   	pop    %ebx
801026cc:	5e                   	pop    %esi
801026cd:	5d                   	pop    %ebp
801026ce:	c3                   	ret
801026cf:	90                   	nop

801026d0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801026d0:	55                   	push   %ebp
  ioapic->reg = reg;
801026d1:	8b 0d 74 17 11 80    	mov    0x80111774,%ecx
{
801026d7:	89 e5                	mov    %esp,%ebp
801026d9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801026dc:	8d 50 20             	lea    0x20(%eax),%edx
801026df:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
801026e3:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801026e5:	8b 0d 74 17 11 80    	mov    0x80111774,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801026eb:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801026ee:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801026f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
801026f4:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
801026f6:	a1 74 17 11 80       	mov    0x80111774,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
801026fb:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
801026fe:	89 50 10             	mov    %edx,0x10(%eax)
}
80102701:	5d                   	pop    %ebp
80102702:	c3                   	ret
80102703:	66 90                	xchg   %ax,%ax
80102705:	66 90                	xchg   %ax,%ax
80102707:	66 90                	xchg   %ax,%ax
80102709:	66 90                	xchg   %ax,%ax
8010270b:	66 90                	xchg   %ax,%ax
8010270d:	66 90                	xchg   %ax,%ax
8010270f:	90                   	nop

80102710 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102710:	55                   	push   %ebp
80102711:	89 e5                	mov    %esp,%ebp
80102713:	53                   	push   %ebx
80102714:	83 ec 04             	sub    $0x4,%esp
80102717:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010271a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102720:	75 76                	jne    80102798 <kfree+0x88>
80102722:	81 fb 10 56 11 80    	cmp    $0x80115610,%ebx
80102728:	72 6e                	jb     80102798 <kfree+0x88>
8010272a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102730:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102735:	77 61                	ja     80102798 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102737:	83 ec 04             	sub    $0x4,%esp
8010273a:	68 00 10 00 00       	push   $0x1000
8010273f:	6a 01                	push   $0x1
80102741:	53                   	push   %ebx
80102742:	e8 d9 21 00 00       	call   80104920 <memset>

  if(kmem.use_lock)
80102747:	8b 15 b4 17 11 80    	mov    0x801117b4,%edx
8010274d:	83 c4 10             	add    $0x10,%esp
80102750:	85 d2                	test   %edx,%edx
80102752:	75 1c                	jne    80102770 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102754:	a1 b8 17 11 80       	mov    0x801117b8,%eax
80102759:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010275b:	a1 b4 17 11 80       	mov    0x801117b4,%eax
  kmem.freelist = r;
80102760:	89 1d b8 17 11 80    	mov    %ebx,0x801117b8
  if(kmem.use_lock)
80102766:	85 c0                	test   %eax,%eax
80102768:	75 1e                	jne    80102788 <kfree+0x78>
    release(&kmem.lock);
}
8010276a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010276d:	c9                   	leave
8010276e:	c3                   	ret
8010276f:	90                   	nop
    acquire(&kmem.lock);
80102770:	83 ec 0c             	sub    $0xc,%esp
80102773:	68 80 17 11 80       	push   $0x80111780
80102778:	e8 a3 20 00 00       	call   80104820 <acquire>
8010277d:	83 c4 10             	add    $0x10,%esp
80102780:	eb d2                	jmp    80102754 <kfree+0x44>
80102782:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
80102788:	c7 45 08 80 17 11 80 	movl   $0x80111780,0x8(%ebp)
}
8010278f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102792:	c9                   	leave
    release(&kmem.lock);
80102793:	e9 28 20 00 00       	jmp    801047c0 <release>
    panic("kfree");
80102798:	83 ec 0c             	sub    $0xc,%esp
8010279b:	68 ac 75 10 80       	push   $0x801075ac
801027a0:	e8 db db ff ff       	call   80100380 <panic>
801027a5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801027ac:	00 
801027ad:	8d 76 00             	lea    0x0(%esi),%esi

801027b0 <freerange>:
{
801027b0:	55                   	push   %ebp
801027b1:	89 e5                	mov    %esp,%ebp
801027b3:	56                   	push   %esi
801027b4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801027b5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801027b8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801027bb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801027c1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027c7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801027cd:	39 de                	cmp    %ebx,%esi
801027cf:	72 23                	jb     801027f4 <freerange+0x44>
801027d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801027d8:	83 ec 0c             	sub    $0xc,%esp
801027db:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027e1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801027e7:	50                   	push   %eax
801027e8:	e8 23 ff ff ff       	call   80102710 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801027ed:	83 c4 10             	add    $0x10,%esp
801027f0:	39 de                	cmp    %ebx,%esi
801027f2:	73 e4                	jae    801027d8 <freerange+0x28>
}
801027f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
801027f7:	5b                   	pop    %ebx
801027f8:	5e                   	pop    %esi
801027f9:	5d                   	pop    %ebp
801027fa:	c3                   	ret
801027fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102800 <kinit2>:
{
80102800:	55                   	push   %ebp
80102801:	89 e5                	mov    %esp,%ebp
80102803:	56                   	push   %esi
80102804:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102805:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102808:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010280b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102811:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102817:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010281d:	39 de                	cmp    %ebx,%esi
8010281f:	72 23                	jb     80102844 <kinit2+0x44>
80102821:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102828:	83 ec 0c             	sub    $0xc,%esp
8010282b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102831:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102837:	50                   	push   %eax
80102838:	e8 d3 fe ff ff       	call   80102710 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010283d:	83 c4 10             	add    $0x10,%esp
80102840:	39 de                	cmp    %ebx,%esi
80102842:	73 e4                	jae    80102828 <kinit2+0x28>
  kmem.use_lock = 1;
80102844:	c7 05 b4 17 11 80 01 	movl   $0x1,0x801117b4
8010284b:	00 00 00 
}
8010284e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102851:	5b                   	pop    %ebx
80102852:	5e                   	pop    %esi
80102853:	5d                   	pop    %ebp
80102854:	c3                   	ret
80102855:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010285c:	00 
8010285d:	8d 76 00             	lea    0x0(%esi),%esi

80102860 <kinit1>:
{
80102860:	55                   	push   %ebp
80102861:	89 e5                	mov    %esp,%ebp
80102863:	56                   	push   %esi
80102864:	53                   	push   %ebx
80102865:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102868:	83 ec 08             	sub    $0x8,%esp
8010286b:	68 b2 75 10 80       	push   $0x801075b2
80102870:	68 80 17 11 80       	push   $0x80111780
80102875:	e8 b6 1d 00 00       	call   80104630 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010287a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010287d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102880:	c7 05 b4 17 11 80 00 	movl   $0x0,0x801117b4
80102887:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010288a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102890:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102896:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010289c:	39 de                	cmp    %ebx,%esi
8010289e:	72 1c                	jb     801028bc <kinit1+0x5c>
    kfree(p);
801028a0:	83 ec 0c             	sub    $0xc,%esp
801028a3:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801028a9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801028af:	50                   	push   %eax
801028b0:	e8 5b fe ff ff       	call   80102710 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801028b5:	83 c4 10             	add    $0x10,%esp
801028b8:	39 de                	cmp    %ebx,%esi
801028ba:	73 e4                	jae    801028a0 <kinit1+0x40>
}
801028bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801028bf:	5b                   	pop    %ebx
801028c0:	5e                   	pop    %esi
801028c1:	5d                   	pop    %ebp
801028c2:	c3                   	ret
801028c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801028ca:	00 
801028cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801028d0 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
801028d0:	55                   	push   %ebp
801028d1:	89 e5                	mov    %esp,%ebp
801028d3:	53                   	push   %ebx
801028d4:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
801028d7:	a1 b4 17 11 80       	mov    0x801117b4,%eax
801028dc:	85 c0                	test   %eax,%eax
801028de:	75 20                	jne    80102900 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
801028e0:	8b 1d b8 17 11 80    	mov    0x801117b8,%ebx
  if(r)
801028e6:	85 db                	test   %ebx,%ebx
801028e8:	74 07                	je     801028f1 <kalloc+0x21>
    kmem.freelist = r->next;
801028ea:	8b 03                	mov    (%ebx),%eax
801028ec:	a3 b8 17 11 80       	mov    %eax,0x801117b8
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
801028f1:	89 d8                	mov    %ebx,%eax
801028f3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801028f6:	c9                   	leave
801028f7:	c3                   	ret
801028f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801028ff:	00 
    acquire(&kmem.lock);
80102900:	83 ec 0c             	sub    $0xc,%esp
80102903:	68 80 17 11 80       	push   $0x80111780
80102908:	e8 13 1f 00 00       	call   80104820 <acquire>
  r = kmem.freelist;
8010290d:	8b 1d b8 17 11 80    	mov    0x801117b8,%ebx
  if(kmem.use_lock)
80102913:	a1 b4 17 11 80       	mov    0x801117b4,%eax
  if(r)
80102918:	83 c4 10             	add    $0x10,%esp
8010291b:	85 db                	test   %ebx,%ebx
8010291d:	74 08                	je     80102927 <kalloc+0x57>
    kmem.freelist = r->next;
8010291f:	8b 13                	mov    (%ebx),%edx
80102921:	89 15 b8 17 11 80    	mov    %edx,0x801117b8
  if(kmem.use_lock)
80102927:	85 c0                	test   %eax,%eax
80102929:	74 c6                	je     801028f1 <kalloc+0x21>
    release(&kmem.lock);
8010292b:	83 ec 0c             	sub    $0xc,%esp
8010292e:	68 80 17 11 80       	push   $0x80111780
80102933:	e8 88 1e 00 00       	call   801047c0 <release>
}
80102938:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
8010293a:	83 c4 10             	add    $0x10,%esp
}
8010293d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102940:	c9                   	leave
80102941:	c3                   	ret
80102942:	66 90                	xchg   %ax,%ax
80102944:	66 90                	xchg   %ax,%ax
80102946:	66 90                	xchg   %ax,%ax
80102948:	66 90                	xchg   %ax,%ax
8010294a:	66 90                	xchg   %ax,%ax
8010294c:	66 90                	xchg   %ax,%ax
8010294e:	66 90                	xchg   %ax,%ax

80102950 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102950:	ba 64 00 00 00       	mov    $0x64,%edx
80102955:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if ((st & KBS_DIB) == 0)
80102956:	a8 01                	test   $0x1,%al
80102958:	0f 84 d2 00 00 00    	je     80102a30 <kbdgetc+0xe0>
int kbdgetc(void) {
8010295e:	55                   	push   %ebp
8010295f:	ba 60 00 00 00       	mov    $0x60,%edx
80102964:	89 e5                	mov    %esp,%ebp
80102966:	53                   	push   %ebx
80102967:	ec                   	in     (%dx),%al
    return -1;

  data = inb(KBDATAP);

  if (data == 0xE0) {   // Special key prefix
    shift |= E0ESC;
80102968:	8b 1d bc 17 11 80    	mov    0x801117bc,%ebx
  data = inb(KBDATAP);
8010296e:	0f b6 c8             	movzbl %al,%ecx
  if (data == 0xE0) {   // Special key prefix
80102971:	3c e0                	cmp    $0xe0,%al
80102973:	74 5b                	je     801029d0 <kbdgetc+0x80>
    return 0;
  } else if (data & 0x80) { 
    data = (shift & E0ESC) ? data : (data & 0x7F);
80102975:	89 da                	mov    %ebx,%edx
80102977:	83 e2 40             	and    $0x40,%edx
  } else if (data & 0x80) { 
8010297a:	84 c0                	test   %al,%al
8010297c:	78 62                	js     801029e0 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if (shift & E0ESC) {
8010297e:	85 d2                	test   %edx,%edx
80102980:	74 0c                	je     8010298e <kbdgetc+0x3e>
    switch (data) {
80102982:	83 f9 4b             	cmp    $0x4b,%ecx
80102985:	0f 84 95 00 00 00    	je     80102a20 <kbdgetc+0xd0>
      case 0x4B:
        return KEY_LEFT;
    }
    shift &= ~E0ESC;
8010298b:	83 e3 bf             	and    $0xffffffbf,%ebx
  }

  shift |= shiftcode[data];
8010298e:	0f b6 91 00 7c 10 80 	movzbl -0x7fef8400(%ecx),%edx
  shift ^= togglecode[data];
80102995:	0f b6 81 00 7b 10 80 	movzbl -0x7fef8500(%ecx),%eax
  shift |= shiftcode[data];
8010299c:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
8010299e:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
801029a0:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
801029a2:	89 15 bc 17 11 80    	mov    %edx,0x801117bc
  c = charcode[shift & (CTL | SHIFT)][data];
801029a8:	83 e0 03             	and    $0x3,%eax

  if (shift & CAPSLOCK) {
801029ab:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
801029ae:	8b 04 85 e0 7a 10 80 	mov    -0x7fef8520(,%eax,4),%eax
801029b5:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if (shift & CAPSLOCK) {
801029b9:	74 0b                	je     801029c6 <kbdgetc+0x76>
    if ('a' <= c && c <= 'z')
801029bb:	8d 50 9f             	lea    -0x61(%eax),%edx
801029be:	83 fa 19             	cmp    $0x19,%edx
801029c1:	77 45                	ja     80102a08 <kbdgetc+0xb8>
      c += 'A' - 'a';
801029c3:	83 e8 20             	sub    $0x20,%eax
    else if ('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  
  return c;
}
801029c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029c9:	c9                   	leave
801029ca:	c3                   	ret
801029cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801029d0:	83 cb 40             	or     $0x40,%ebx
    return 0;
801029d3:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801029d5:	89 1d bc 17 11 80    	mov    %ebx,0x801117bc
}
801029db:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801029de:	c9                   	leave
801029df:	c3                   	ret
    data = (shift & E0ESC) ? data : (data & 0x7F);
801029e0:	83 e0 7f             	and    $0x7f,%eax
801029e3:	85 d2                	test   %edx,%edx
801029e5:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
801029e8:	0f b6 81 00 7c 10 80 	movzbl -0x7fef8400(%ecx),%eax
801029ef:	83 c8 40             	or     $0x40,%eax
801029f2:	0f b6 c0             	movzbl %al,%eax
801029f5:	f7 d0                	not    %eax
801029f7:	21 d8                	and    %ebx,%eax
801029f9:	a3 bc 17 11 80       	mov    %eax,0x801117bc
    return 0;
801029fe:	31 c0                	xor    %eax,%eax
80102a00:	eb d9                	jmp    801029db <kbdgetc+0x8b>
80102a02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if ('A' <= c && c <= 'Z')
80102a08:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
80102a0b:	8d 50 20             	lea    0x20(%eax),%edx
}
80102a0e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a11:	c9                   	leave
      c += 'a' - 'A';
80102a12:	83 f9 1a             	cmp    $0x1a,%ecx
80102a15:	0f 42 c2             	cmovb  %edx,%eax
}
80102a18:	c3                   	ret
80102a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        return KEY_LEFT;
80102a20:	b8 4b e0 00 00       	mov    $0xe04b,%eax
80102a25:	eb 9f                	jmp    801029c6 <kbdgetc+0x76>
80102a27:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102a2e:	00 
80102a2f:	90                   	nop
    return -1;
80102a30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102a35:	c3                   	ret
80102a36:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102a3d:	00 
80102a3e:	66 90                	xchg   %ax,%ax

80102a40 <kbdintr>:

void kbdintr(void) {
80102a40:	55                   	push   %ebp
80102a41:	89 e5                	mov    %esp,%ebp
80102a43:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102a46:	68 50 29 10 80       	push   $0x80102950
80102a4b:	e8 20 df ff ff       	call   80100970 <consoleintr>
}
80102a50:	83 c4 10             	add    $0x10,%esp
80102a53:	c9                   	leave
80102a54:	c3                   	ret
80102a55:	66 90                	xchg   %ax,%ax
80102a57:	66 90                	xchg   %ax,%ax
80102a59:	66 90                	xchg   %ax,%ax
80102a5b:	66 90                	xchg   %ax,%ax
80102a5d:	66 90                	xchg   %ax,%ax
80102a5f:	90                   	nop

80102a60 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102a60:	a1 c0 17 11 80       	mov    0x801117c0,%eax
80102a65:	85 c0                	test   %eax,%eax
80102a67:	0f 84 c3 00 00 00    	je     80102b30 <lapicinit+0xd0>
  lapic[index] = value;
80102a6d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102a74:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a77:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a7a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102a81:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a84:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a87:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102a8e:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102a91:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a94:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
80102a9b:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102a9e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102aa1:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
80102aa8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102aab:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102aae:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102ab5:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102ab8:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102abb:	8b 50 30             	mov    0x30(%eax),%edx
80102abe:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
80102ac4:	75 72                	jne    80102b38 <lapicinit+0xd8>
  lapic[index] = value;
80102ac6:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
80102acd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102ad0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102ad3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102ada:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102add:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102ae0:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102ae7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102aea:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102aed:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102af4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102af7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102afa:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102b01:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b04:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102b07:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102b0e:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102b11:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102b14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102b18:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102b1e:	80 e6 10             	and    $0x10,%dh
80102b21:	75 f5                	jne    80102b18 <lapicinit+0xb8>
  lapic[index] = value;
80102b23:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102b2a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b2d:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102b30:	c3                   	ret
80102b31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102b38:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102b3f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102b42:	8b 50 20             	mov    0x20(%eax),%edx
}
80102b45:	e9 7c ff ff ff       	jmp    80102ac6 <lapicinit+0x66>
80102b4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102b50 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102b50:	a1 c0 17 11 80       	mov    0x801117c0,%eax
80102b55:	85 c0                	test   %eax,%eax
80102b57:	74 07                	je     80102b60 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
80102b59:	8b 40 20             	mov    0x20(%eax),%eax
80102b5c:	c1 e8 18             	shr    $0x18,%eax
80102b5f:	c3                   	ret
    return 0;
80102b60:	31 c0                	xor    %eax,%eax
}
80102b62:	c3                   	ret
80102b63:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102b6a:	00 
80102b6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102b70 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102b70:	a1 c0 17 11 80       	mov    0x801117c0,%eax
80102b75:	85 c0                	test   %eax,%eax
80102b77:	74 0d                	je     80102b86 <lapiceoi+0x16>
  lapic[index] = value;
80102b79:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102b80:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102b83:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102b86:	c3                   	ret
80102b87:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102b8e:	00 
80102b8f:	90                   	nop

80102b90 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
80102b90:	c3                   	ret
80102b91:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102b98:	00 
80102b99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102ba0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80102ba0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ba1:	b8 0f 00 00 00       	mov    $0xf,%eax
80102ba6:	ba 70 00 00 00       	mov    $0x70,%edx
80102bab:	89 e5                	mov    %esp,%ebp
80102bad:	53                   	push   %ebx
80102bae:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102bb1:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102bb4:	ee                   	out    %al,(%dx)
80102bb5:	b8 0a 00 00 00       	mov    $0xa,%eax
80102bba:	ba 71 00 00 00       	mov    $0x71,%edx
80102bbf:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102bc0:	31 c0                	xor    %eax,%eax
  lapic[index] = value;
80102bc2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102bc5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102bcb:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102bcd:	c1 e9 0c             	shr    $0xc,%ecx
  lapic[index] = value;
80102bd0:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102bd2:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102bd5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102bd8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102bde:	a1 c0 17 11 80       	mov    0x801117c0,%eax
80102be3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102be9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102bec:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102bf3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102bf6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102bf9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102c00:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102c03:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102c06:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102c0c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102c0f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102c15:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102c18:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102c1e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102c21:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102c27:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102c2a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102c2d:	c9                   	leave
80102c2e:	c3                   	ret
80102c2f:	90                   	nop

80102c30 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102c30:	55                   	push   %ebp
80102c31:	b8 0b 00 00 00       	mov    $0xb,%eax
80102c36:	ba 70 00 00 00       	mov    $0x70,%edx
80102c3b:	89 e5                	mov    %esp,%ebp
80102c3d:	57                   	push   %edi
80102c3e:	56                   	push   %esi
80102c3f:	53                   	push   %ebx
80102c40:	83 ec 4c             	sub    $0x4c,%esp
80102c43:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c44:	ba 71 00 00 00       	mov    $0x71,%edx
80102c49:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102c4a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c4d:	bf 70 00 00 00       	mov    $0x70,%edi
80102c52:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102c55:	8d 76 00             	lea    0x0(%esi),%esi
80102c58:	31 c0                	xor    %eax,%eax
80102c5a:	89 fa                	mov    %edi,%edx
80102c5c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c5d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102c62:	89 ca                	mov    %ecx,%edx
80102c64:	ec                   	in     (%dx),%al
80102c65:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c68:	89 fa                	mov    %edi,%edx
80102c6a:	b8 02 00 00 00       	mov    $0x2,%eax
80102c6f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c70:	89 ca                	mov    %ecx,%edx
80102c72:	ec                   	in     (%dx),%al
80102c73:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c76:	89 fa                	mov    %edi,%edx
80102c78:	b8 04 00 00 00       	mov    $0x4,%eax
80102c7d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c7e:	89 ca                	mov    %ecx,%edx
80102c80:	ec                   	in     (%dx),%al
80102c81:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c84:	89 fa                	mov    %edi,%edx
80102c86:	b8 07 00 00 00       	mov    $0x7,%eax
80102c8b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c8c:	89 ca                	mov    %ecx,%edx
80102c8e:	ec                   	in     (%dx),%al
80102c8f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c92:	89 fa                	mov    %edi,%edx
80102c94:	b8 08 00 00 00       	mov    $0x8,%eax
80102c99:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102c9a:	89 ca                	mov    %ecx,%edx
80102c9c:	ec                   	in     (%dx),%al
80102c9d:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102c9f:	89 fa                	mov    %edi,%edx
80102ca1:	b8 09 00 00 00       	mov    $0x9,%eax
80102ca6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ca7:	89 ca                	mov    %ecx,%edx
80102ca9:	ec                   	in     (%dx),%al
80102caa:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cad:	89 fa                	mov    %edi,%edx
80102caf:	b8 0a 00 00 00       	mov    $0xa,%eax
80102cb4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cb5:	89 ca                	mov    %ecx,%edx
80102cb7:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102cb8:	84 c0                	test   %al,%al
80102cba:	78 9c                	js     80102c58 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102cbc:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102cc0:	89 f2                	mov    %esi,%edx
80102cc2:	89 5d cc             	mov    %ebx,-0x34(%ebp)
80102cc5:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cc8:	89 fa                	mov    %edi,%edx
80102cca:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102ccd:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102cd1:	89 75 c8             	mov    %esi,-0x38(%ebp)
80102cd4:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102cd7:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102cdb:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102cde:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102ce2:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102ce5:	31 c0                	xor    %eax,%eax
80102ce7:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ce8:	89 ca                	mov    %ecx,%edx
80102cea:	ec                   	in     (%dx),%al
80102ceb:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cee:	89 fa                	mov    %edi,%edx
80102cf0:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102cf3:	b8 02 00 00 00       	mov    $0x2,%eax
80102cf8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cf9:	89 ca                	mov    %ecx,%edx
80102cfb:	ec                   	in     (%dx),%al
80102cfc:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102cff:	89 fa                	mov    %edi,%edx
80102d01:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102d04:	b8 04 00 00 00       	mov    $0x4,%eax
80102d09:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d0a:	89 ca                	mov    %ecx,%edx
80102d0c:	ec                   	in     (%dx),%al
80102d0d:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d10:	89 fa                	mov    %edi,%edx
80102d12:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102d15:	b8 07 00 00 00       	mov    $0x7,%eax
80102d1a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d1b:	89 ca                	mov    %ecx,%edx
80102d1d:	ec                   	in     (%dx),%al
80102d1e:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d21:	89 fa                	mov    %edi,%edx
80102d23:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102d26:	b8 08 00 00 00       	mov    $0x8,%eax
80102d2b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d2c:	89 ca                	mov    %ecx,%edx
80102d2e:	ec                   	in     (%dx),%al
80102d2f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102d32:	89 fa                	mov    %edi,%edx
80102d34:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102d37:	b8 09 00 00 00       	mov    $0x9,%eax
80102d3c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102d3d:	89 ca                	mov    %ecx,%edx
80102d3f:	ec                   	in     (%dx),%al
80102d40:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102d43:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102d46:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102d49:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102d4c:	6a 18                	push   $0x18
80102d4e:	50                   	push   %eax
80102d4f:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102d52:	50                   	push   %eax
80102d53:	e8 08 1c 00 00       	call   80104960 <memcmp>
80102d58:	83 c4 10             	add    $0x10,%esp
80102d5b:	85 c0                	test   %eax,%eax
80102d5d:	0f 85 f5 fe ff ff    	jne    80102c58 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102d63:	0f b6 75 b3          	movzbl -0x4d(%ebp),%esi
80102d67:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102d6a:	89 f0                	mov    %esi,%eax
80102d6c:	84 c0                	test   %al,%al
80102d6e:	75 78                	jne    80102de8 <cmostime+0x1b8>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102d70:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102d73:	89 c2                	mov    %eax,%edx
80102d75:	83 e0 0f             	and    $0xf,%eax
80102d78:	c1 ea 04             	shr    $0x4,%edx
80102d7b:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d7e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d81:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102d84:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102d87:	89 c2                	mov    %eax,%edx
80102d89:	83 e0 0f             	and    $0xf,%eax
80102d8c:	c1 ea 04             	shr    $0x4,%edx
80102d8f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102d92:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102d95:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102d98:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102d9b:	89 c2                	mov    %eax,%edx
80102d9d:	83 e0 0f             	and    $0xf,%eax
80102da0:	c1 ea 04             	shr    $0x4,%edx
80102da3:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102da6:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102da9:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102dac:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102daf:	89 c2                	mov    %eax,%edx
80102db1:	83 e0 0f             	and    $0xf,%eax
80102db4:	c1 ea 04             	shr    $0x4,%edx
80102db7:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102dba:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102dbd:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102dc0:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102dc3:	89 c2                	mov    %eax,%edx
80102dc5:	83 e0 0f             	and    $0xf,%eax
80102dc8:	c1 ea 04             	shr    $0x4,%edx
80102dcb:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102dce:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102dd1:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102dd4:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102dd7:	89 c2                	mov    %eax,%edx
80102dd9:	83 e0 0f             	and    $0xf,%eax
80102ddc:	c1 ea 04             	shr    $0x4,%edx
80102ddf:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102de2:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102de5:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102de8:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102deb:	89 03                	mov    %eax,(%ebx)
80102ded:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102df0:	89 43 04             	mov    %eax,0x4(%ebx)
80102df3:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102df6:	89 43 08             	mov    %eax,0x8(%ebx)
80102df9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102dfc:	89 43 0c             	mov    %eax,0xc(%ebx)
80102dff:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102e02:	89 43 10             	mov    %eax,0x10(%ebx)
80102e05:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102e08:	89 43 14             	mov    %eax,0x14(%ebx)
  r->year += 2000;
80102e0b:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
80102e12:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102e15:	5b                   	pop    %ebx
80102e16:	5e                   	pop    %esi
80102e17:	5f                   	pop    %edi
80102e18:	5d                   	pop    %ebp
80102e19:	c3                   	ret
80102e1a:	66 90                	xchg   %ax,%ax
80102e1c:	66 90                	xchg   %ax,%ax
80102e1e:	66 90                	xchg   %ax,%ax

80102e20 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102e20:	8b 0d 28 18 11 80    	mov    0x80111828,%ecx
80102e26:	85 c9                	test   %ecx,%ecx
80102e28:	0f 8e 8a 00 00 00    	jle    80102eb8 <install_trans+0x98>
{
80102e2e:	55                   	push   %ebp
80102e2f:	89 e5                	mov    %esp,%ebp
80102e31:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102e32:	31 ff                	xor    %edi,%edi
{
80102e34:	56                   	push   %esi
80102e35:	53                   	push   %ebx
80102e36:	83 ec 0c             	sub    $0xc,%esp
80102e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102e40:	a1 14 18 11 80       	mov    0x80111814,%eax
80102e45:	83 ec 08             	sub    $0x8,%esp
80102e48:	01 f8                	add    %edi,%eax
80102e4a:	83 c0 01             	add    $0x1,%eax
80102e4d:	50                   	push   %eax
80102e4e:	ff 35 24 18 11 80    	push   0x80111824
80102e54:	e8 77 d2 ff ff       	call   801000d0 <bread>
80102e59:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102e5b:	58                   	pop    %eax
80102e5c:	5a                   	pop    %edx
80102e5d:	ff 34 bd 2c 18 11 80 	push   -0x7feee7d4(,%edi,4)
80102e64:	ff 35 24 18 11 80    	push   0x80111824
  for (tail = 0; tail < log.lh.n; tail++) {
80102e6a:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102e6d:	e8 5e d2 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102e72:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102e75:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102e77:	8d 46 5c             	lea    0x5c(%esi),%eax
80102e7a:	68 00 02 00 00       	push   $0x200
80102e7f:	50                   	push   %eax
80102e80:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102e83:	50                   	push   %eax
80102e84:	e8 27 1b 00 00       	call   801049b0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102e89:	89 1c 24             	mov    %ebx,(%esp)
80102e8c:	e8 1f d3 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102e91:	89 34 24             	mov    %esi,(%esp)
80102e94:	e8 57 d3 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102e99:	89 1c 24             	mov    %ebx,(%esp)
80102e9c:	e8 4f d3 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102ea1:	83 c4 10             	add    $0x10,%esp
80102ea4:	39 3d 28 18 11 80    	cmp    %edi,0x80111828
80102eaa:	7f 94                	jg     80102e40 <install_trans+0x20>
  }
}
80102eac:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102eaf:	5b                   	pop    %ebx
80102eb0:	5e                   	pop    %esi
80102eb1:	5f                   	pop    %edi
80102eb2:	5d                   	pop    %ebp
80102eb3:	c3                   	ret
80102eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102eb8:	c3                   	ret
80102eb9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102ec0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102ec0:	55                   	push   %ebp
80102ec1:	89 e5                	mov    %esp,%ebp
80102ec3:	53                   	push   %ebx
80102ec4:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ec7:	ff 35 14 18 11 80    	push   0x80111814
80102ecd:	ff 35 24 18 11 80    	push   0x80111824
80102ed3:	e8 f8 d1 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102ed8:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102edb:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102edd:	a1 28 18 11 80       	mov    0x80111828,%eax
80102ee2:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102ee5:	85 c0                	test   %eax,%eax
80102ee7:	7e 19                	jle    80102f02 <write_head+0x42>
80102ee9:	31 d2                	xor    %edx,%edx
80102eeb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102ef0:	8b 0c 95 2c 18 11 80 	mov    -0x7feee7d4(,%edx,4),%ecx
80102ef7:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102efb:	83 c2 01             	add    $0x1,%edx
80102efe:	39 d0                	cmp    %edx,%eax
80102f00:	75 ee                	jne    80102ef0 <write_head+0x30>
  }
  bwrite(buf);
80102f02:	83 ec 0c             	sub    $0xc,%esp
80102f05:	53                   	push   %ebx
80102f06:	e8 a5 d2 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102f0b:	89 1c 24             	mov    %ebx,(%esp)
80102f0e:	e8 dd d2 ff ff       	call   801001f0 <brelse>
}
80102f13:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f16:	83 c4 10             	add    $0x10,%esp
80102f19:	c9                   	leave
80102f1a:	c3                   	ret
80102f1b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102f20 <initlog>:
{
80102f20:	55                   	push   %ebp
80102f21:	89 e5                	mov    %esp,%ebp
80102f23:	53                   	push   %ebx
80102f24:	83 ec 2c             	sub    $0x2c,%esp
80102f27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102f2a:	68 b7 75 10 80       	push   $0x801075b7
80102f2f:	68 e0 17 11 80       	push   $0x801117e0
80102f34:	e8 f7 16 00 00       	call   80104630 <initlock>
  readsb(dev, &sb);
80102f39:	58                   	pop    %eax
80102f3a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102f3d:	5a                   	pop    %edx
80102f3e:	50                   	push   %eax
80102f3f:	53                   	push   %ebx
80102f40:	e8 6b e8 ff ff       	call   801017b0 <readsb>
  log.start = sb.logstart;
80102f45:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102f48:	59                   	pop    %ecx
  log.dev = dev;
80102f49:	89 1d 24 18 11 80    	mov    %ebx,0x80111824
  log.size = sb.nlog;
80102f4f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102f52:	a3 14 18 11 80       	mov    %eax,0x80111814
  log.size = sb.nlog;
80102f57:	89 15 18 18 11 80    	mov    %edx,0x80111818
  struct buf *buf = bread(log.dev, log.start);
80102f5d:	5a                   	pop    %edx
80102f5e:	50                   	push   %eax
80102f5f:	53                   	push   %ebx
80102f60:	e8 6b d1 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102f65:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102f68:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102f6b:	89 1d 28 18 11 80    	mov    %ebx,0x80111828
  for (i = 0; i < log.lh.n; i++) {
80102f71:	85 db                	test   %ebx,%ebx
80102f73:	7e 1d                	jle    80102f92 <initlog+0x72>
80102f75:	31 d2                	xor    %edx,%edx
80102f77:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f7e:	00 
80102f7f:	90                   	nop
    log.lh.block[i] = lh->block[i];
80102f80:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102f84:	89 0c 95 2c 18 11 80 	mov    %ecx,-0x7feee7d4(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102f8b:	83 c2 01             	add    $0x1,%edx
80102f8e:	39 d3                	cmp    %edx,%ebx
80102f90:	75 ee                	jne    80102f80 <initlog+0x60>
  brelse(buf);
80102f92:	83 ec 0c             	sub    $0xc,%esp
80102f95:	50                   	push   %eax
80102f96:	e8 55 d2 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102f9b:	e8 80 fe ff ff       	call   80102e20 <install_trans>
  log.lh.n = 0;
80102fa0:	c7 05 28 18 11 80 00 	movl   $0x0,0x80111828
80102fa7:	00 00 00 
  write_head(); // clear the log
80102faa:	e8 11 ff ff ff       	call   80102ec0 <write_head>
}
80102faf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102fb2:	83 c4 10             	add    $0x10,%esp
80102fb5:	c9                   	leave
80102fb6:	c3                   	ret
80102fb7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102fbe:	00 
80102fbf:	90                   	nop

80102fc0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102fc0:	55                   	push   %ebp
80102fc1:	89 e5                	mov    %esp,%ebp
80102fc3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102fc6:	68 e0 17 11 80       	push   $0x801117e0
80102fcb:	e8 50 18 00 00       	call   80104820 <acquire>
80102fd0:	83 c4 10             	add    $0x10,%esp
80102fd3:	eb 18                	jmp    80102fed <begin_op+0x2d>
80102fd5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102fd8:	83 ec 08             	sub    $0x8,%esp
80102fdb:	68 e0 17 11 80       	push   $0x801117e0
80102fe0:	68 e0 17 11 80       	push   $0x801117e0
80102fe5:	e8 b6 12 00 00       	call   801042a0 <sleep>
80102fea:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102fed:	a1 20 18 11 80       	mov    0x80111820,%eax
80102ff2:	85 c0                	test   %eax,%eax
80102ff4:	75 e2                	jne    80102fd8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102ff6:	a1 1c 18 11 80       	mov    0x8011181c,%eax
80102ffb:	8b 15 28 18 11 80    	mov    0x80111828,%edx
80103001:	83 c0 01             	add    $0x1,%eax
80103004:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103007:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
8010300a:	83 fa 1e             	cmp    $0x1e,%edx
8010300d:	7f c9                	jg     80102fd8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
8010300f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80103012:	a3 1c 18 11 80       	mov    %eax,0x8011181c
      release(&log.lock);
80103017:	68 e0 17 11 80       	push   $0x801117e0
8010301c:	e8 9f 17 00 00       	call   801047c0 <release>
      break;
    }
  }
}
80103021:	83 c4 10             	add    $0x10,%esp
80103024:	c9                   	leave
80103025:	c3                   	ret
80103026:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010302d:	00 
8010302e:	66 90                	xchg   %ax,%ax

80103030 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80103030:	55                   	push   %ebp
80103031:	89 e5                	mov    %esp,%ebp
80103033:	57                   	push   %edi
80103034:	56                   	push   %esi
80103035:	53                   	push   %ebx
80103036:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80103039:	68 e0 17 11 80       	push   $0x801117e0
8010303e:	e8 dd 17 00 00       	call   80104820 <acquire>
  log.outstanding -= 1;
80103043:	a1 1c 18 11 80       	mov    0x8011181c,%eax
  if(log.committing)
80103048:	8b 35 20 18 11 80    	mov    0x80111820,%esi
8010304e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80103051:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103054:	89 1d 1c 18 11 80    	mov    %ebx,0x8011181c
  if(log.committing)
8010305a:	85 f6                	test   %esi,%esi
8010305c:	0f 85 22 01 00 00    	jne    80103184 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80103062:	85 db                	test   %ebx,%ebx
80103064:	0f 85 f6 00 00 00    	jne    80103160 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
8010306a:	c7 05 20 18 11 80 01 	movl   $0x1,0x80111820
80103071:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80103074:	83 ec 0c             	sub    $0xc,%esp
80103077:	68 e0 17 11 80       	push   $0x801117e0
8010307c:	e8 3f 17 00 00       	call   801047c0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80103081:	8b 0d 28 18 11 80    	mov    0x80111828,%ecx
80103087:	83 c4 10             	add    $0x10,%esp
8010308a:	85 c9                	test   %ecx,%ecx
8010308c:	7f 42                	jg     801030d0 <end_op+0xa0>
    acquire(&log.lock);
8010308e:	83 ec 0c             	sub    $0xc,%esp
80103091:	68 e0 17 11 80       	push   $0x801117e0
80103096:	e8 85 17 00 00       	call   80104820 <acquire>
    log.committing = 0;
8010309b:	c7 05 20 18 11 80 00 	movl   $0x0,0x80111820
801030a2:	00 00 00 
    wakeup(&log);
801030a5:	c7 04 24 e0 17 11 80 	movl   $0x801117e0,(%esp)
801030ac:	e8 af 12 00 00       	call   80104360 <wakeup>
    release(&log.lock);
801030b1:	c7 04 24 e0 17 11 80 	movl   $0x801117e0,(%esp)
801030b8:	e8 03 17 00 00       	call   801047c0 <release>
801030bd:	83 c4 10             	add    $0x10,%esp
}
801030c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801030c3:	5b                   	pop    %ebx
801030c4:	5e                   	pop    %esi
801030c5:	5f                   	pop    %edi
801030c6:	5d                   	pop    %ebp
801030c7:	c3                   	ret
801030c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801030cf:	00 
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
801030d0:	a1 14 18 11 80       	mov    0x80111814,%eax
801030d5:	83 ec 08             	sub    $0x8,%esp
801030d8:	01 d8                	add    %ebx,%eax
801030da:	83 c0 01             	add    $0x1,%eax
801030dd:	50                   	push   %eax
801030de:	ff 35 24 18 11 80    	push   0x80111824
801030e4:	e8 e7 cf ff ff       	call   801000d0 <bread>
801030e9:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801030eb:	58                   	pop    %eax
801030ec:	5a                   	pop    %edx
801030ed:	ff 34 9d 2c 18 11 80 	push   -0x7feee7d4(,%ebx,4)
801030f4:	ff 35 24 18 11 80    	push   0x80111824
  for (tail = 0; tail < log.lh.n; tail++) {
801030fa:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801030fd:	e8 ce cf ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80103102:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80103105:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80103107:	8d 40 5c             	lea    0x5c(%eax),%eax
8010310a:	68 00 02 00 00       	push   $0x200
8010310f:	50                   	push   %eax
80103110:	8d 46 5c             	lea    0x5c(%esi),%eax
80103113:	50                   	push   %eax
80103114:	e8 97 18 00 00       	call   801049b0 <memmove>
    bwrite(to);  // write the log
80103119:	89 34 24             	mov    %esi,(%esp)
8010311c:	e8 8f d0 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80103121:	89 3c 24             	mov    %edi,(%esp)
80103124:	e8 c7 d0 ff ff       	call   801001f0 <brelse>
    brelse(to);
80103129:	89 34 24             	mov    %esi,(%esp)
8010312c:	e8 bf d0 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80103131:	83 c4 10             	add    $0x10,%esp
80103134:	3b 1d 28 18 11 80    	cmp    0x80111828,%ebx
8010313a:	7c 94                	jl     801030d0 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
8010313c:	e8 7f fd ff ff       	call   80102ec0 <write_head>
    install_trans(); // Now install writes to home locations
80103141:	e8 da fc ff ff       	call   80102e20 <install_trans>
    log.lh.n = 0;
80103146:	c7 05 28 18 11 80 00 	movl   $0x0,0x80111828
8010314d:	00 00 00 
    write_head();    // Erase the transaction from the log
80103150:	e8 6b fd ff ff       	call   80102ec0 <write_head>
80103155:	e9 34 ff ff ff       	jmp    8010308e <end_op+0x5e>
8010315a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80103160:	83 ec 0c             	sub    $0xc,%esp
80103163:	68 e0 17 11 80       	push   $0x801117e0
80103168:	e8 f3 11 00 00       	call   80104360 <wakeup>
  release(&log.lock);
8010316d:	c7 04 24 e0 17 11 80 	movl   $0x801117e0,(%esp)
80103174:	e8 47 16 00 00       	call   801047c0 <release>
80103179:	83 c4 10             	add    $0x10,%esp
}
8010317c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010317f:	5b                   	pop    %ebx
80103180:	5e                   	pop    %esi
80103181:	5f                   	pop    %edi
80103182:	5d                   	pop    %ebp
80103183:	c3                   	ret
    panic("log.committing");
80103184:	83 ec 0c             	sub    $0xc,%esp
80103187:	68 bb 75 10 80       	push   $0x801075bb
8010318c:	e8 ef d1 ff ff       	call   80100380 <panic>
80103191:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103198:	00 
80103199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801031a0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
801031a0:	55                   	push   %ebp
801031a1:	89 e5                	mov    %esp,%ebp
801031a3:	53                   	push   %ebx
801031a4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801031a7:	8b 15 28 18 11 80    	mov    0x80111828,%edx
{
801031ad:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
801031b0:	83 fa 1d             	cmp    $0x1d,%edx
801031b3:	7f 7d                	jg     80103232 <log_write+0x92>
801031b5:	a1 18 18 11 80       	mov    0x80111818,%eax
801031ba:	83 e8 01             	sub    $0x1,%eax
801031bd:	39 c2                	cmp    %eax,%edx
801031bf:	7d 71                	jge    80103232 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
801031c1:	a1 1c 18 11 80       	mov    0x8011181c,%eax
801031c6:	85 c0                	test   %eax,%eax
801031c8:	7e 75                	jle    8010323f <log_write+0x9f>
    panic("log_write outside of trans");

  acquire(&log.lock);
801031ca:	83 ec 0c             	sub    $0xc,%esp
801031cd:	68 e0 17 11 80       	push   $0x801117e0
801031d2:	e8 49 16 00 00       	call   80104820 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801031d7:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
801031da:	83 c4 10             	add    $0x10,%esp
801031dd:	31 c0                	xor    %eax,%eax
801031df:	8b 15 28 18 11 80    	mov    0x80111828,%edx
801031e5:	85 d2                	test   %edx,%edx
801031e7:	7f 0e                	jg     801031f7 <log_write+0x57>
801031e9:	eb 15                	jmp    80103200 <log_write+0x60>
801031eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801031f0:	83 c0 01             	add    $0x1,%eax
801031f3:	39 c2                	cmp    %eax,%edx
801031f5:	74 29                	je     80103220 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801031f7:	39 0c 85 2c 18 11 80 	cmp    %ecx,-0x7feee7d4(,%eax,4)
801031fe:	75 f0                	jne    801031f0 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80103200:	89 0c 85 2c 18 11 80 	mov    %ecx,-0x7feee7d4(,%eax,4)
  if (i == log.lh.n)
80103207:	39 c2                	cmp    %eax,%edx
80103209:	74 1c                	je     80103227 <log_write+0x87>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
8010320b:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
8010320e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80103211:	c7 45 08 e0 17 11 80 	movl   $0x801117e0,0x8(%ebp)
}
80103218:	c9                   	leave
  release(&log.lock);
80103219:	e9 a2 15 00 00       	jmp    801047c0 <release>
8010321e:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno;
80103220:	89 0c 95 2c 18 11 80 	mov    %ecx,-0x7feee7d4(,%edx,4)
    log.lh.n++;
80103227:	83 c2 01             	add    $0x1,%edx
8010322a:	89 15 28 18 11 80    	mov    %edx,0x80111828
80103230:	eb d9                	jmp    8010320b <log_write+0x6b>
    panic("too big a transaction");
80103232:	83 ec 0c             	sub    $0xc,%esp
80103235:	68 ca 75 10 80       	push   $0x801075ca
8010323a:	e8 41 d1 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
8010323f:	83 ec 0c             	sub    $0xc,%esp
80103242:	68 e0 75 10 80       	push   $0x801075e0
80103247:	e8 34 d1 ff ff       	call   80100380 <panic>
8010324c:	66 90                	xchg   %ax,%ax
8010324e:	66 90                	xchg   %ax,%ax

80103250 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103250:	55                   	push   %ebp
80103251:	89 e5                	mov    %esp,%ebp
80103253:	53                   	push   %ebx
80103254:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103257:	e8 64 09 00 00       	call   80103bc0 <cpuid>
8010325c:	89 c3                	mov    %eax,%ebx
8010325e:	e8 5d 09 00 00       	call   80103bc0 <cpuid>
80103263:	83 ec 04             	sub    $0x4,%esp
80103266:	53                   	push   %ebx
80103267:	50                   	push   %eax
80103268:	68 fb 75 10 80       	push   $0x801075fb
8010326d:	e8 ce d4 ff ff       	call   80100740 <cprintf>
  idtinit();       // load idt register
80103272:	e8 e9 28 00 00       	call   80105b60 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80103277:	e8 e4 08 00 00       	call   80103b60 <mycpu>
8010327c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
8010327e:	b8 01 00 00 00       	mov    $0x1,%eax
80103283:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
8010328a:	e8 01 0c 00 00       	call   80103e90 <scheduler>
8010328f:	90                   	nop

80103290 <mpenter>:
{
80103290:	55                   	push   %ebp
80103291:	89 e5                	mov    %esp,%ebp
80103293:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80103296:	e8 c5 39 00 00       	call   80106c60 <switchkvm>
  seginit();
8010329b:	e8 30 39 00 00       	call   80106bd0 <seginit>
  lapicinit();
801032a0:	e8 bb f7 ff ff       	call   80102a60 <lapicinit>
  mpmain();
801032a5:	e8 a6 ff ff ff       	call   80103250 <mpmain>
801032aa:	66 90                	xchg   %ax,%ax
801032ac:	66 90                	xchg   %ax,%ax
801032ae:	66 90                	xchg   %ax,%ax

801032b0 <main>:
{
801032b0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801032b4:	83 e4 f0             	and    $0xfffffff0,%esp
801032b7:	ff 71 fc             	push   -0x4(%ecx)
801032ba:	55                   	push   %ebp
801032bb:	89 e5                	mov    %esp,%ebp
801032bd:	53                   	push   %ebx
801032be:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
801032bf:	83 ec 08             	sub    $0x8,%esp
801032c2:	68 00 00 40 80       	push   $0x80400000
801032c7:	68 10 56 11 80       	push   $0x80115610
801032cc:	e8 8f f5 ff ff       	call   80102860 <kinit1>
  kvmalloc();      // kernel page table
801032d1:	e8 4a 3e 00 00       	call   80107120 <kvmalloc>
  mpinit();        // detect other processors
801032d6:	e8 85 01 00 00       	call   80103460 <mpinit>
  lapicinit();     // interrupt controller
801032db:	e8 80 f7 ff ff       	call   80102a60 <lapicinit>
  seginit();       // segment descriptors
801032e0:	e8 eb 38 00 00       	call   80106bd0 <seginit>
  picinit();       // disable pic
801032e5:	e8 86 03 00 00       	call   80103670 <picinit>
  ioapicinit();    // another interrupt controller
801032ea:	e8 41 f3 ff ff       	call   80102630 <ioapicinit>
  consoleinit();   // console hardware
801032ef:	e8 dc d9 ff ff       	call   80100cd0 <consoleinit>
  uartinit();      // serial port
801032f4:	e8 47 2b 00 00       	call   80105e40 <uartinit>
  pinit();         // process table
801032f9:	e8 42 08 00 00       	call   80103b40 <pinit>
  tvinit();        // trap vectors
801032fe:	e8 dd 27 00 00       	call   80105ae0 <tvinit>
  binit();         // buffer cache
80103303:	e8 38 cd ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103308:	e8 93 dd ff ff       	call   801010a0 <fileinit>
  ideinit();       // disk 
8010330d:	e8 fe f0 ff ff       	call   80102410 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103312:	83 c4 0c             	add    $0xc,%esp
80103315:	68 8a 00 00 00       	push   $0x8a
8010331a:	68 8c a4 10 80       	push   $0x8010a48c
8010331f:	68 00 70 00 80       	push   $0x80007000
80103324:	e8 87 16 00 00       	call   801049b0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103329:	83 c4 10             	add    $0x10,%esp
8010332c:	69 05 c4 18 11 80 b0 	imul   $0xb0,0x801118c4,%eax
80103333:	00 00 00 
80103336:	05 e0 18 11 80       	add    $0x801118e0,%eax
8010333b:	3d e0 18 11 80       	cmp    $0x801118e0,%eax
80103340:	76 7e                	jbe    801033c0 <main+0x110>
80103342:	bb e0 18 11 80       	mov    $0x801118e0,%ebx
80103347:	eb 20                	jmp    80103369 <main+0xb9>
80103349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103350:	69 05 c4 18 11 80 b0 	imul   $0xb0,0x801118c4,%eax
80103357:	00 00 00 
8010335a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103360:	05 e0 18 11 80       	add    $0x801118e0,%eax
80103365:	39 c3                	cmp    %eax,%ebx
80103367:	73 57                	jae    801033c0 <main+0x110>
    if(c == mycpu())  // We've started already.
80103369:	e8 f2 07 00 00       	call   80103b60 <mycpu>
8010336e:	39 c3                	cmp    %eax,%ebx
80103370:	74 de                	je     80103350 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103372:	e8 59 f5 ff ff       	call   801028d0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
80103377:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
8010337a:	c7 05 f8 6f 00 80 90 	movl   $0x80103290,0x80006ff8
80103381:	32 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80103384:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
8010338b:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
8010338e:	05 00 10 00 00       	add    $0x1000,%eax
80103393:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
80103398:	0f b6 03             	movzbl (%ebx),%eax
8010339b:	68 00 70 00 00       	push   $0x7000
801033a0:	50                   	push   %eax
801033a1:	e8 fa f7 ff ff       	call   80102ba0 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801033a6:	83 c4 10             	add    $0x10,%esp
801033a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801033b0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
801033b6:	85 c0                	test   %eax,%eax
801033b8:	74 f6                	je     801033b0 <main+0x100>
801033ba:	eb 94                	jmp    80103350 <main+0xa0>
801033bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801033c0:	83 ec 08             	sub    $0x8,%esp
801033c3:	68 00 00 00 8e       	push   $0x8e000000
801033c8:	68 00 00 40 80       	push   $0x80400000
801033cd:	e8 2e f4 ff ff       	call   80102800 <kinit2>
  userinit();      // first user process
801033d2:	e8 39 08 00 00       	call   80103c10 <userinit>
  mpmain();        // finish this processor's setup
801033d7:	e8 74 fe ff ff       	call   80103250 <mpmain>
801033dc:	66 90                	xchg   %ax,%ax
801033de:	66 90                	xchg   %ax,%ax

801033e0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
801033e0:	55                   	push   %ebp
801033e1:	89 e5                	mov    %esp,%ebp
801033e3:	57                   	push   %edi
801033e4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
801033e5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
801033eb:	53                   	push   %ebx
  e = addr+len;
801033ec:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
801033ef:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
801033f2:	39 de                	cmp    %ebx,%esi
801033f4:	72 10                	jb     80103406 <mpsearch1+0x26>
801033f6:	eb 50                	jmp    80103448 <mpsearch1+0x68>
801033f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801033ff:	00 
80103400:	89 fe                	mov    %edi,%esi
80103402:	39 df                	cmp    %ebx,%edi
80103404:	73 42                	jae    80103448 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103406:	83 ec 04             	sub    $0x4,%esp
80103409:	8d 7e 10             	lea    0x10(%esi),%edi
8010340c:	6a 04                	push   $0x4
8010340e:	68 0f 76 10 80       	push   $0x8010760f
80103413:	56                   	push   %esi
80103414:	e8 47 15 00 00       	call   80104960 <memcmp>
80103419:	83 c4 10             	add    $0x10,%esp
8010341c:	85 c0                	test   %eax,%eax
8010341e:	75 e0                	jne    80103400 <mpsearch1+0x20>
80103420:	89 f2                	mov    %esi,%edx
80103422:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103428:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
8010342b:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
8010342e:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103430:	39 fa                	cmp    %edi,%edx
80103432:	75 f4                	jne    80103428 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103434:	84 c0                	test   %al,%al
80103436:	75 c8                	jne    80103400 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103438:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010343b:	89 f0                	mov    %esi,%eax
8010343d:	5b                   	pop    %ebx
8010343e:	5e                   	pop    %esi
8010343f:	5f                   	pop    %edi
80103440:	5d                   	pop    %ebp
80103441:	c3                   	ret
80103442:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103448:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010344b:	31 f6                	xor    %esi,%esi
}
8010344d:	5b                   	pop    %ebx
8010344e:	89 f0                	mov    %esi,%eax
80103450:	5e                   	pop    %esi
80103451:	5f                   	pop    %edi
80103452:	5d                   	pop    %ebp
80103453:	c3                   	ret
80103454:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010345b:	00 
8010345c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103460 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103460:	55                   	push   %ebp
80103461:	89 e5                	mov    %esp,%ebp
80103463:	57                   	push   %edi
80103464:	56                   	push   %esi
80103465:	53                   	push   %ebx
80103466:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103469:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103470:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103477:	c1 e0 08             	shl    $0x8,%eax
8010347a:	09 d0                	or     %edx,%eax
8010347c:	c1 e0 04             	shl    $0x4,%eax
8010347f:	75 1b                	jne    8010349c <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103481:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103488:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
8010348f:	c1 e0 08             	shl    $0x8,%eax
80103492:	09 d0                	or     %edx,%eax
80103494:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103497:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010349c:	ba 00 04 00 00       	mov    $0x400,%edx
801034a1:	e8 3a ff ff ff       	call   801033e0 <mpsearch1>
801034a6:	89 c3                	mov    %eax,%ebx
801034a8:	85 c0                	test   %eax,%eax
801034aa:	0f 84 58 01 00 00    	je     80103608 <mpinit+0x1a8>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801034b0:	8b 73 04             	mov    0x4(%ebx),%esi
801034b3:	85 f6                	test   %esi,%esi
801034b5:	0f 84 3d 01 00 00    	je     801035f8 <mpinit+0x198>
  if(memcmp(conf, "PCMP", 4) != 0)
801034bb:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801034be:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801034c4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
801034c7:	6a 04                	push   $0x4
801034c9:	68 14 76 10 80       	push   $0x80107614
801034ce:	50                   	push   %eax
801034cf:	e8 8c 14 00 00       	call   80104960 <memcmp>
801034d4:	83 c4 10             	add    $0x10,%esp
801034d7:	85 c0                	test   %eax,%eax
801034d9:	0f 85 19 01 00 00    	jne    801035f8 <mpinit+0x198>
  if(conf->version != 1 && conf->version != 4)
801034df:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
801034e6:	3c 01                	cmp    $0x1,%al
801034e8:	74 08                	je     801034f2 <mpinit+0x92>
801034ea:	3c 04                	cmp    $0x4,%al
801034ec:	0f 85 06 01 00 00    	jne    801035f8 <mpinit+0x198>
  if(sum((uchar*)conf, conf->length) != 0)
801034f2:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
801034f9:	66 85 d2             	test   %dx,%dx
801034fc:	74 22                	je     80103520 <mpinit+0xc0>
801034fe:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80103501:	89 f0                	mov    %esi,%eax
  sum = 0;
80103503:	31 d2                	xor    %edx,%edx
80103505:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103508:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
8010350f:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103512:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103514:	39 f8                	cmp    %edi,%eax
80103516:	75 f0                	jne    80103508 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103518:	84 d2                	test   %dl,%dl
8010351a:	0f 85 d8 00 00 00    	jne    801035f8 <mpinit+0x198>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103520:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103526:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103529:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  lapic = (uint*)conf->lapicaddr;
8010352c:	a3 c0 17 11 80       	mov    %eax,0x801117c0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103531:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103538:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
8010353e:	01 d7                	add    %edx,%edi
80103540:	89 fa                	mov    %edi,%edx
  ismp = 1;
80103542:	bf 01 00 00 00       	mov    $0x1,%edi
80103547:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010354e:	00 
8010354f:	90                   	nop
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103550:	39 d0                	cmp    %edx,%eax
80103552:	73 19                	jae    8010356d <mpinit+0x10d>
    switch(*p){
80103554:	0f b6 08             	movzbl (%eax),%ecx
80103557:	80 f9 02             	cmp    $0x2,%cl
8010355a:	0f 84 80 00 00 00    	je     801035e0 <mpinit+0x180>
80103560:	77 6e                	ja     801035d0 <mpinit+0x170>
80103562:	84 c9                	test   %cl,%cl
80103564:	74 3a                	je     801035a0 <mpinit+0x140>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103566:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103569:	39 d0                	cmp    %edx,%eax
8010356b:	72 e7                	jb     80103554 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
8010356d:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103570:	85 ff                	test   %edi,%edi
80103572:	0f 84 dd 00 00 00    	je     80103655 <mpinit+0x1f5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
80103578:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
8010357c:	74 15                	je     80103593 <mpinit+0x133>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010357e:	b8 70 00 00 00       	mov    $0x70,%eax
80103583:	ba 22 00 00 00       	mov    $0x22,%edx
80103588:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103589:	ba 23 00 00 00       	mov    $0x23,%edx
8010358e:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
8010358f:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103592:	ee                   	out    %al,(%dx)
  }
}
80103593:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103596:	5b                   	pop    %ebx
80103597:	5e                   	pop    %esi
80103598:	5f                   	pop    %edi
80103599:	5d                   	pop    %ebp
8010359a:	c3                   	ret
8010359b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
801035a0:	8b 0d c4 18 11 80    	mov    0x801118c4,%ecx
801035a6:	83 f9 07             	cmp    $0x7,%ecx
801035a9:	7f 19                	jg     801035c4 <mpinit+0x164>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801035ab:	69 f1 b0 00 00 00    	imul   $0xb0,%ecx,%esi
801035b1:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
801035b5:	83 c1 01             	add    $0x1,%ecx
801035b8:	89 0d c4 18 11 80    	mov    %ecx,0x801118c4
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801035be:	88 9e e0 18 11 80    	mov    %bl,-0x7feee720(%esi)
      p += sizeof(struct mpproc);
801035c4:	83 c0 14             	add    $0x14,%eax
      continue;
801035c7:	eb 87                	jmp    80103550 <mpinit+0xf0>
801035c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(*p){
801035d0:	83 e9 03             	sub    $0x3,%ecx
801035d3:	80 f9 01             	cmp    $0x1,%cl
801035d6:	76 8e                	jbe    80103566 <mpinit+0x106>
801035d8:	31 ff                	xor    %edi,%edi
801035da:	e9 71 ff ff ff       	jmp    80103550 <mpinit+0xf0>
801035df:	90                   	nop
      ioapicid = ioapic->apicno;
801035e0:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
801035e4:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801035e7:	88 0d c0 18 11 80    	mov    %cl,0x801118c0
      continue;
801035ed:	e9 5e ff ff ff       	jmp    80103550 <mpinit+0xf0>
801035f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
801035f8:	83 ec 0c             	sub    $0xc,%esp
801035fb:	68 19 76 10 80       	push   $0x80107619
80103600:	e8 7b cd ff ff       	call   80100380 <panic>
80103605:	8d 76 00             	lea    0x0(%esi),%esi
{
80103608:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
8010360d:	eb 0b                	jmp    8010361a <mpinit+0x1ba>
8010360f:	90                   	nop
  for(p = addr; p < e; p += sizeof(struct mp))
80103610:	89 f3                	mov    %esi,%ebx
80103612:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103618:	74 de                	je     801035f8 <mpinit+0x198>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010361a:	83 ec 04             	sub    $0x4,%esp
8010361d:	8d 73 10             	lea    0x10(%ebx),%esi
80103620:	6a 04                	push   $0x4
80103622:	68 0f 76 10 80       	push   $0x8010760f
80103627:	53                   	push   %ebx
80103628:	e8 33 13 00 00       	call   80104960 <memcmp>
8010362d:	83 c4 10             	add    $0x10,%esp
80103630:	85 c0                	test   %eax,%eax
80103632:	75 dc                	jne    80103610 <mpinit+0x1b0>
80103634:	89 da                	mov    %ebx,%edx
80103636:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010363d:	00 
8010363e:	66 90                	xchg   %ax,%ax
    sum += addr[i];
80103640:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103643:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103646:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103648:	39 d6                	cmp    %edx,%esi
8010364a:	75 f4                	jne    80103640 <mpinit+0x1e0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010364c:	84 c0                	test   %al,%al
8010364e:	75 c0                	jne    80103610 <mpinit+0x1b0>
80103650:	e9 5b fe ff ff       	jmp    801034b0 <mpinit+0x50>
    panic("Didn't find a suitable machine");
80103655:	83 ec 0c             	sub    $0xc,%esp
80103658:	68 cc 79 10 80       	push   $0x801079cc
8010365d:	e8 1e cd ff ff       	call   80100380 <panic>
80103662:	66 90                	xchg   %ax,%ax
80103664:	66 90                	xchg   %ax,%ax
80103666:	66 90                	xchg   %ax,%ax
80103668:	66 90                	xchg   %ax,%ax
8010366a:	66 90                	xchg   %ax,%ax
8010366c:	66 90                	xchg   %ax,%ax
8010366e:	66 90                	xchg   %ax,%ax

80103670 <picinit>:
80103670:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103675:	ba 21 00 00 00       	mov    $0x21,%edx
8010367a:	ee                   	out    %al,(%dx)
8010367b:	ba a1 00 00 00       	mov    $0xa1,%edx
80103680:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103681:	c3                   	ret
80103682:	66 90                	xchg   %ax,%ax
80103684:	66 90                	xchg   %ax,%ax
80103686:	66 90                	xchg   %ax,%ax
80103688:	66 90                	xchg   %ax,%ax
8010368a:	66 90                	xchg   %ax,%ax
8010368c:	66 90                	xchg   %ax,%ax
8010368e:	66 90                	xchg   %ax,%ax

80103690 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103690:	55                   	push   %ebp
80103691:	89 e5                	mov    %esp,%ebp
80103693:	57                   	push   %edi
80103694:	56                   	push   %esi
80103695:	53                   	push   %ebx
80103696:	83 ec 0c             	sub    $0xc,%esp
80103699:	8b 75 08             	mov    0x8(%ebp),%esi
8010369c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010369f:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
801036a5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801036ab:	e8 10 da ff ff       	call   801010c0 <filealloc>
801036b0:	89 06                	mov    %eax,(%esi)
801036b2:	85 c0                	test   %eax,%eax
801036b4:	0f 84 a5 00 00 00    	je     8010375f <pipealloc+0xcf>
801036ba:	e8 01 da ff ff       	call   801010c0 <filealloc>
801036bf:	89 07                	mov    %eax,(%edi)
801036c1:	85 c0                	test   %eax,%eax
801036c3:	0f 84 84 00 00 00    	je     8010374d <pipealloc+0xbd>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
801036c9:	e8 02 f2 ff ff       	call   801028d0 <kalloc>
801036ce:	89 c3                	mov    %eax,%ebx
801036d0:	85 c0                	test   %eax,%eax
801036d2:	0f 84 a0 00 00 00    	je     80103778 <pipealloc+0xe8>
    goto bad;
  p->readopen = 1;
801036d8:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801036df:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
801036e2:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
801036e5:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
801036ec:	00 00 00 
  p->nwrite = 0;
801036ef:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
801036f6:	00 00 00 
  p->nread = 0;
801036f9:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103700:	00 00 00 
  initlock(&p->lock, "pipe");
80103703:	68 31 76 10 80       	push   $0x80107631
80103708:	50                   	push   %eax
80103709:	e8 22 0f 00 00       	call   80104630 <initlock>
  (*f0)->type = FD_PIPE;
8010370e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103710:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103713:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103719:	8b 06                	mov    (%esi),%eax
8010371b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010371f:	8b 06                	mov    (%esi),%eax
80103721:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103725:	8b 06                	mov    (%esi),%eax
80103727:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010372a:	8b 07                	mov    (%edi),%eax
8010372c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103732:	8b 07                	mov    (%edi),%eax
80103734:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103738:	8b 07                	mov    (%edi),%eax
8010373a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010373e:	8b 07                	mov    (%edi),%eax
80103740:	89 58 0c             	mov    %ebx,0xc(%eax)
  return 0;
80103743:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103745:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103748:	5b                   	pop    %ebx
80103749:	5e                   	pop    %esi
8010374a:	5f                   	pop    %edi
8010374b:	5d                   	pop    %ebp
8010374c:	c3                   	ret
  if(*f0)
8010374d:	8b 06                	mov    (%esi),%eax
8010374f:	85 c0                	test   %eax,%eax
80103751:	74 1e                	je     80103771 <pipealloc+0xe1>
    fileclose(*f0);
80103753:	83 ec 0c             	sub    $0xc,%esp
80103756:	50                   	push   %eax
80103757:	e8 24 da ff ff       	call   80101180 <fileclose>
8010375c:	83 c4 10             	add    $0x10,%esp
  if(*f1)
8010375f:	8b 07                	mov    (%edi),%eax
80103761:	85 c0                	test   %eax,%eax
80103763:	74 0c                	je     80103771 <pipealloc+0xe1>
    fileclose(*f1);
80103765:	83 ec 0c             	sub    $0xc,%esp
80103768:	50                   	push   %eax
80103769:	e8 12 da ff ff       	call   80101180 <fileclose>
8010376e:	83 c4 10             	add    $0x10,%esp
  return -1;
80103771:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103776:	eb cd                	jmp    80103745 <pipealloc+0xb5>
  if(*f0)
80103778:	8b 06                	mov    (%esi),%eax
8010377a:	85 c0                	test   %eax,%eax
8010377c:	75 d5                	jne    80103753 <pipealloc+0xc3>
8010377e:	eb df                	jmp    8010375f <pipealloc+0xcf>

80103780 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103780:	55                   	push   %ebp
80103781:	89 e5                	mov    %esp,%ebp
80103783:	56                   	push   %esi
80103784:	53                   	push   %ebx
80103785:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103788:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010378b:	83 ec 0c             	sub    $0xc,%esp
8010378e:	53                   	push   %ebx
8010378f:	e8 8c 10 00 00       	call   80104820 <acquire>
  if(writable){
80103794:	83 c4 10             	add    $0x10,%esp
80103797:	85 f6                	test   %esi,%esi
80103799:	74 65                	je     80103800 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
8010379b:	83 ec 0c             	sub    $0xc,%esp
8010379e:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
801037a4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801037ab:	00 00 00 
    wakeup(&p->nread);
801037ae:	50                   	push   %eax
801037af:	e8 ac 0b 00 00       	call   80104360 <wakeup>
801037b4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801037b7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801037bd:	85 d2                	test   %edx,%edx
801037bf:	75 0a                	jne    801037cb <pipeclose+0x4b>
801037c1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801037c7:	85 c0                	test   %eax,%eax
801037c9:	74 15                	je     801037e0 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801037cb:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801037ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801037d1:	5b                   	pop    %ebx
801037d2:	5e                   	pop    %esi
801037d3:	5d                   	pop    %ebp
    release(&p->lock);
801037d4:	e9 e7 0f 00 00       	jmp    801047c0 <release>
801037d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
801037e0:	83 ec 0c             	sub    $0xc,%esp
801037e3:	53                   	push   %ebx
801037e4:	e8 d7 0f 00 00       	call   801047c0 <release>
    kfree((char*)p);
801037e9:	83 c4 10             	add    $0x10,%esp
801037ec:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801037ef:	8d 65 f8             	lea    -0x8(%ebp),%esp
801037f2:	5b                   	pop    %ebx
801037f3:	5e                   	pop    %esi
801037f4:	5d                   	pop    %ebp
    kfree((char*)p);
801037f5:	e9 16 ef ff ff       	jmp    80102710 <kfree>
801037fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103800:	83 ec 0c             	sub    $0xc,%esp
80103803:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103809:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103810:	00 00 00 
    wakeup(&p->nwrite);
80103813:	50                   	push   %eax
80103814:	e8 47 0b 00 00       	call   80104360 <wakeup>
80103819:	83 c4 10             	add    $0x10,%esp
8010381c:	eb 99                	jmp    801037b7 <pipeclose+0x37>
8010381e:	66 90                	xchg   %ax,%ax

80103820 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103820:	55                   	push   %ebp
80103821:	89 e5                	mov    %esp,%ebp
80103823:	57                   	push   %edi
80103824:	56                   	push   %esi
80103825:	53                   	push   %ebx
80103826:	83 ec 28             	sub    $0x28,%esp
80103829:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010382c:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
8010382f:	53                   	push   %ebx
80103830:	e8 eb 0f 00 00       	call   80104820 <acquire>
  for(i = 0; i < n; i++){
80103835:	83 c4 10             	add    $0x10,%esp
80103838:	85 ff                	test   %edi,%edi
8010383a:	0f 8e ce 00 00 00    	jle    8010390e <pipewrite+0xee>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103840:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103846:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103849:	89 7d 10             	mov    %edi,0x10(%ebp)
8010384c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010384f:	8d 34 39             	lea    (%ecx,%edi,1),%esi
80103852:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103855:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010385b:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103861:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103867:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
8010386d:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
80103870:	0f 85 b6 00 00 00    	jne    8010392c <pipewrite+0x10c>
80103876:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103879:	eb 3b                	jmp    801038b6 <pipewrite+0x96>
8010387b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
80103880:	e8 5b 03 00 00       	call   80103be0 <myproc>
80103885:	8b 48 24             	mov    0x24(%eax),%ecx
80103888:	85 c9                	test   %ecx,%ecx
8010388a:	75 34                	jne    801038c0 <pipewrite+0xa0>
      wakeup(&p->nread);
8010388c:	83 ec 0c             	sub    $0xc,%esp
8010388f:	56                   	push   %esi
80103890:	e8 cb 0a 00 00       	call   80104360 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103895:	58                   	pop    %eax
80103896:	5a                   	pop    %edx
80103897:	53                   	push   %ebx
80103898:	57                   	push   %edi
80103899:	e8 02 0a 00 00       	call   801042a0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010389e:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801038a4:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801038aa:	83 c4 10             	add    $0x10,%esp
801038ad:	05 00 02 00 00       	add    $0x200,%eax
801038b2:	39 c2                	cmp    %eax,%edx
801038b4:	75 2a                	jne    801038e0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
801038b6:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801038bc:	85 c0                	test   %eax,%eax
801038be:	75 c0                	jne    80103880 <pipewrite+0x60>
        release(&p->lock);
801038c0:	83 ec 0c             	sub    $0xc,%esp
801038c3:	53                   	push   %ebx
801038c4:	e8 f7 0e 00 00       	call   801047c0 <release>
        return -1;
801038c9:	83 c4 10             	add    $0x10,%esp
801038cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801038d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801038d4:	5b                   	pop    %ebx
801038d5:	5e                   	pop    %esi
801038d6:	5f                   	pop    %edi
801038d7:	5d                   	pop    %ebp
801038d8:	c3                   	ret
801038d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801038e0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801038e3:	8d 42 01             	lea    0x1(%edx),%eax
801038e6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  for(i = 0; i < n; i++){
801038ec:	83 c1 01             	add    $0x1,%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801038ef:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801038f5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801038f8:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
801038fc:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103900:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103903:	39 c1                	cmp    %eax,%ecx
80103905:	0f 85 50 ff ff ff    	jne    8010385b <pipewrite+0x3b>
8010390b:	8b 7d 10             	mov    0x10(%ebp),%edi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
8010390e:	83 ec 0c             	sub    $0xc,%esp
80103911:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103917:	50                   	push   %eax
80103918:	e8 43 0a 00 00       	call   80104360 <wakeup>
  release(&p->lock);
8010391d:	89 1c 24             	mov    %ebx,(%esp)
80103920:	e8 9b 0e 00 00       	call   801047c0 <release>
  return n;
80103925:	83 c4 10             	add    $0x10,%esp
80103928:	89 f8                	mov    %edi,%eax
8010392a:	eb a5                	jmp    801038d1 <pipewrite+0xb1>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010392c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010392f:	eb b2                	jmp    801038e3 <pipewrite+0xc3>
80103931:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103938:	00 
80103939:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103940 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103940:	55                   	push   %ebp
80103941:	89 e5                	mov    %esp,%ebp
80103943:	57                   	push   %edi
80103944:	56                   	push   %esi
80103945:	53                   	push   %ebx
80103946:	83 ec 18             	sub    $0x18,%esp
80103949:	8b 75 08             	mov    0x8(%ebp),%esi
8010394c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010394f:	56                   	push   %esi
80103950:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103956:	e8 c5 0e 00 00       	call   80104820 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010395b:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103961:	83 c4 10             	add    $0x10,%esp
80103964:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010396a:	74 2f                	je     8010399b <piperead+0x5b>
8010396c:	eb 37                	jmp    801039a5 <piperead+0x65>
8010396e:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
80103970:	e8 6b 02 00 00       	call   80103be0 <myproc>
80103975:	8b 40 24             	mov    0x24(%eax),%eax
80103978:	85 c0                	test   %eax,%eax
8010397a:	0f 85 80 00 00 00    	jne    80103a00 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103980:	83 ec 08             	sub    $0x8,%esp
80103983:	56                   	push   %esi
80103984:	53                   	push   %ebx
80103985:	e8 16 09 00 00       	call   801042a0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010398a:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103990:	83 c4 10             	add    $0x10,%esp
80103993:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103999:	75 0a                	jne    801039a5 <piperead+0x65>
8010399b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801039a1:	85 d2                	test   %edx,%edx
801039a3:	75 cb                	jne    80103970 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801039a5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801039a8:	31 db                	xor    %ebx,%ebx
801039aa:	85 c9                	test   %ecx,%ecx
801039ac:	7f 26                	jg     801039d4 <piperead+0x94>
801039ae:	eb 2c                	jmp    801039dc <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
801039b0:	8d 48 01             	lea    0x1(%eax),%ecx
801039b3:	25 ff 01 00 00       	and    $0x1ff,%eax
801039b8:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
801039be:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
801039c3:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801039c6:	83 c3 01             	add    $0x1,%ebx
801039c9:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801039cc:	74 0e                	je     801039dc <piperead+0x9c>
801039ce:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
    if(p->nread == p->nwrite)
801039d4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801039da:	75 d4                	jne    801039b0 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801039dc:	83 ec 0c             	sub    $0xc,%esp
801039df:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801039e5:	50                   	push   %eax
801039e6:	e8 75 09 00 00       	call   80104360 <wakeup>
  release(&p->lock);
801039eb:	89 34 24             	mov    %esi,(%esp)
801039ee:	e8 cd 0d 00 00       	call   801047c0 <release>
  return i;
801039f3:	83 c4 10             	add    $0x10,%esp
}
801039f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801039f9:	89 d8                	mov    %ebx,%eax
801039fb:	5b                   	pop    %ebx
801039fc:	5e                   	pop    %esi
801039fd:	5f                   	pop    %edi
801039fe:	5d                   	pop    %ebp
801039ff:	c3                   	ret
      release(&p->lock);
80103a00:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103a03:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103a08:	56                   	push   %esi
80103a09:	e8 b2 0d 00 00       	call   801047c0 <release>
      return -1;
80103a0e:	83 c4 10             	add    $0x10,%esp
}
80103a11:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a14:	89 d8                	mov    %ebx,%eax
80103a16:	5b                   	pop    %ebx
80103a17:	5e                   	pop    %esi
80103a18:	5f                   	pop    %edi
80103a19:	5d                   	pop    %ebp
80103a1a:	c3                   	ret
80103a1b:	66 90                	xchg   %ax,%ax
80103a1d:	66 90                	xchg   %ax,%ax
80103a1f:	90                   	nop

80103a20 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103a20:	55                   	push   %ebp
80103a21:	89 e5                	mov    %esp,%ebp
80103a23:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a24:	bb 94 1e 11 80       	mov    $0x80111e94,%ebx
{
80103a29:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
80103a2c:	68 60 1e 11 80       	push   $0x80111e60
80103a31:	e8 ea 0d 00 00       	call   80104820 <acquire>
80103a36:	83 c4 10             	add    $0x10,%esp
80103a39:	eb 10                	jmp    80103a4b <allocproc+0x2b>
80103a3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103a40:	83 c3 7c             	add    $0x7c,%ebx
80103a43:	81 fb 94 3d 11 80    	cmp    $0x80113d94,%ebx
80103a49:	74 75                	je     80103ac0 <allocproc+0xa0>
    if(p->state == UNUSED)
80103a4b:	8b 43 0c             	mov    0xc(%ebx),%eax
80103a4e:	85 c0                	test   %eax,%eax
80103a50:	75 ee                	jne    80103a40 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103a52:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
80103a57:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103a5a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103a61:	89 43 10             	mov    %eax,0x10(%ebx)
80103a64:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
80103a67:	68 60 1e 11 80       	push   $0x80111e60
  p->pid = nextpid++;
80103a6c:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
80103a72:	e8 49 0d 00 00       	call   801047c0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
80103a77:	e8 54 ee ff ff       	call   801028d0 <kalloc>
80103a7c:	83 c4 10             	add    $0x10,%esp
80103a7f:	89 43 08             	mov    %eax,0x8(%ebx)
80103a82:	85 c0                	test   %eax,%eax
80103a84:	74 53                	je     80103ad9 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103a86:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103a8c:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
80103a8f:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
80103a94:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
80103a97:	c7 40 14 d2 5a 10 80 	movl   $0x80105ad2,0x14(%eax)
  p->context = (struct context*)sp;
80103a9e:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
80103aa1:	6a 14                	push   $0x14
80103aa3:	6a 00                	push   $0x0
80103aa5:	50                   	push   %eax
80103aa6:	e8 75 0e 00 00       	call   80104920 <memset>
  p->context->eip = (uint)forkret;
80103aab:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
80103aae:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103ab1:	c7 40 10 f0 3a 10 80 	movl   $0x80103af0,0x10(%eax)
}
80103ab8:	89 d8                	mov    %ebx,%eax
80103aba:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103abd:	c9                   	leave
80103abe:	c3                   	ret
80103abf:	90                   	nop
  release(&ptable.lock);
80103ac0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103ac3:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103ac5:	68 60 1e 11 80       	push   $0x80111e60
80103aca:	e8 f1 0c 00 00       	call   801047c0 <release>
  return 0;
80103acf:	83 c4 10             	add    $0x10,%esp
}
80103ad2:	89 d8                	mov    %ebx,%eax
80103ad4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ad7:	c9                   	leave
80103ad8:	c3                   	ret
    p->state = UNUSED;
80103ad9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
80103ae0:	31 db                	xor    %ebx,%ebx
80103ae2:	eb ee                	jmp    80103ad2 <allocproc+0xb2>
80103ae4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103aeb:	00 
80103aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103af0 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103af0:	55                   	push   %ebp
80103af1:	89 e5                	mov    %esp,%ebp
80103af3:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103af6:	68 60 1e 11 80       	push   $0x80111e60
80103afb:	e8 c0 0c 00 00       	call   801047c0 <release>

  if (first) {
80103b00:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103b05:	83 c4 10             	add    $0x10,%esp
80103b08:	85 c0                	test   %eax,%eax
80103b0a:	75 04                	jne    80103b10 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
80103b0c:	c9                   	leave
80103b0d:	c3                   	ret
80103b0e:	66 90                	xchg   %ax,%ax
    first = 0;
80103b10:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
80103b17:	00 00 00 
    iinit(ROOTDEV);
80103b1a:	83 ec 0c             	sub    $0xc,%esp
80103b1d:	6a 01                	push   $0x1
80103b1f:	e8 cc dc ff ff       	call   801017f0 <iinit>
    initlog(ROOTDEV);
80103b24:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
80103b2b:	e8 f0 f3 ff ff       	call   80102f20 <initlog>
}
80103b30:	83 c4 10             	add    $0x10,%esp
80103b33:	c9                   	leave
80103b34:	c3                   	ret
80103b35:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103b3c:	00 
80103b3d:	8d 76 00             	lea    0x0(%esi),%esi

80103b40 <pinit>:
{
80103b40:	55                   	push   %ebp
80103b41:	89 e5                	mov    %esp,%ebp
80103b43:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103b46:	68 36 76 10 80       	push   $0x80107636
80103b4b:	68 60 1e 11 80       	push   $0x80111e60
80103b50:	e8 db 0a 00 00       	call   80104630 <initlock>
}
80103b55:	83 c4 10             	add    $0x10,%esp
80103b58:	c9                   	leave
80103b59:	c3                   	ret
80103b5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103b60 <mycpu>:
{
80103b60:	55                   	push   %ebp
80103b61:	89 e5                	mov    %esp,%ebp
80103b63:	56                   	push   %esi
80103b64:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103b65:	9c                   	pushf
80103b66:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103b67:	f6 c4 02             	test   $0x2,%ah
80103b6a:	75 46                	jne    80103bb2 <mycpu+0x52>
  apicid = lapicid();
80103b6c:	e8 df ef ff ff       	call   80102b50 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103b71:	8b 35 c4 18 11 80    	mov    0x801118c4,%esi
80103b77:	85 f6                	test   %esi,%esi
80103b79:	7e 2a                	jle    80103ba5 <mycpu+0x45>
80103b7b:	31 d2                	xor    %edx,%edx
80103b7d:	eb 08                	jmp    80103b87 <mycpu+0x27>
80103b7f:	90                   	nop
80103b80:	83 c2 01             	add    $0x1,%edx
80103b83:	39 f2                	cmp    %esi,%edx
80103b85:	74 1e                	je     80103ba5 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
80103b87:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
80103b8d:	0f b6 99 e0 18 11 80 	movzbl -0x7feee720(%ecx),%ebx
80103b94:	39 c3                	cmp    %eax,%ebx
80103b96:	75 e8                	jne    80103b80 <mycpu+0x20>
}
80103b98:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
80103b9b:	8d 81 e0 18 11 80    	lea    -0x7feee720(%ecx),%eax
}
80103ba1:	5b                   	pop    %ebx
80103ba2:	5e                   	pop    %esi
80103ba3:	5d                   	pop    %ebp
80103ba4:	c3                   	ret
  panic("unknown apicid\n");
80103ba5:	83 ec 0c             	sub    $0xc,%esp
80103ba8:	68 3d 76 10 80       	push   $0x8010763d
80103bad:	e8 ce c7 ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
80103bb2:	83 ec 0c             	sub    $0xc,%esp
80103bb5:	68 ec 79 10 80       	push   $0x801079ec
80103bba:	e8 c1 c7 ff ff       	call   80100380 <panic>
80103bbf:	90                   	nop

80103bc0 <cpuid>:
cpuid() {
80103bc0:	55                   	push   %ebp
80103bc1:	89 e5                	mov    %esp,%ebp
80103bc3:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103bc6:	e8 95 ff ff ff       	call   80103b60 <mycpu>
}
80103bcb:	c9                   	leave
  return mycpu()-cpus;
80103bcc:	2d e0 18 11 80       	sub    $0x801118e0,%eax
80103bd1:	c1 f8 04             	sar    $0x4,%eax
80103bd4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103bda:	c3                   	ret
80103bdb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103be0 <myproc>:
myproc(void) {
80103be0:	55                   	push   %ebp
80103be1:	89 e5                	mov    %esp,%ebp
80103be3:	53                   	push   %ebx
80103be4:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103be7:	e8 e4 0a 00 00       	call   801046d0 <pushcli>
  c = mycpu();
80103bec:	e8 6f ff ff ff       	call   80103b60 <mycpu>
  p = c->proc;
80103bf1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103bf7:	e8 24 0b 00 00       	call   80104720 <popcli>
}
80103bfc:	89 d8                	mov    %ebx,%eax
80103bfe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103c01:	c9                   	leave
80103c02:	c3                   	ret
80103c03:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103c0a:	00 
80103c0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103c10 <userinit>:
{
80103c10:	55                   	push   %ebp
80103c11:	89 e5                	mov    %esp,%ebp
80103c13:	53                   	push   %ebx
80103c14:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103c17:	e8 04 fe ff ff       	call   80103a20 <allocproc>
80103c1c:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103c1e:	a3 94 3d 11 80       	mov    %eax,0x80113d94
  if((p->pgdir = setupkvm()) == 0)
80103c23:	e8 78 34 00 00       	call   801070a0 <setupkvm>
80103c28:	89 43 04             	mov    %eax,0x4(%ebx)
80103c2b:	85 c0                	test   %eax,%eax
80103c2d:	0f 84 bd 00 00 00    	je     80103cf0 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103c33:	83 ec 04             	sub    $0x4,%esp
80103c36:	68 2c 00 00 00       	push   $0x2c
80103c3b:	68 60 a4 10 80       	push   $0x8010a460
80103c40:	50                   	push   %eax
80103c41:	e8 3a 31 00 00       	call   80106d80 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103c46:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103c49:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103c4f:	6a 4c                	push   $0x4c
80103c51:	6a 00                	push   $0x0
80103c53:	ff 73 18             	push   0x18(%ebx)
80103c56:	e8 c5 0c 00 00       	call   80104920 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103c5b:	8b 43 18             	mov    0x18(%ebx),%eax
80103c5e:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103c63:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103c66:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103c6b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103c6f:	8b 43 18             	mov    0x18(%ebx),%eax
80103c72:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103c76:	8b 43 18             	mov    0x18(%ebx),%eax
80103c79:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103c7d:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103c81:	8b 43 18             	mov    0x18(%ebx),%eax
80103c84:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103c88:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103c8c:	8b 43 18             	mov    0x18(%ebx),%eax
80103c8f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103c96:	8b 43 18             	mov    0x18(%ebx),%eax
80103c99:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103ca0:	8b 43 18             	mov    0x18(%ebx),%eax
80103ca3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103caa:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103cad:	6a 10                	push   $0x10
80103caf:	68 66 76 10 80       	push   $0x80107666
80103cb4:	50                   	push   %eax
80103cb5:	e8 16 0e 00 00       	call   80104ad0 <safestrcpy>
  p->cwd = namei("/");
80103cba:	c7 04 24 6f 76 10 80 	movl   $0x8010766f,(%esp)
80103cc1:	e8 2a e6 ff ff       	call   801022f0 <namei>
80103cc6:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103cc9:	c7 04 24 60 1e 11 80 	movl   $0x80111e60,(%esp)
80103cd0:	e8 4b 0b 00 00       	call   80104820 <acquire>
  p->state = RUNNABLE;
80103cd5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103cdc:	c7 04 24 60 1e 11 80 	movl   $0x80111e60,(%esp)
80103ce3:	e8 d8 0a 00 00       	call   801047c0 <release>
}
80103ce8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103ceb:	83 c4 10             	add    $0x10,%esp
80103cee:	c9                   	leave
80103cef:	c3                   	ret
    panic("userinit: out of memory?");
80103cf0:	83 ec 0c             	sub    $0xc,%esp
80103cf3:	68 4d 76 10 80       	push   $0x8010764d
80103cf8:	e8 83 c6 ff ff       	call   80100380 <panic>
80103cfd:	8d 76 00             	lea    0x0(%esi),%esi

80103d00 <growproc>:
{
80103d00:	55                   	push   %ebp
80103d01:	89 e5                	mov    %esp,%ebp
80103d03:	56                   	push   %esi
80103d04:	53                   	push   %ebx
80103d05:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103d08:	e8 c3 09 00 00       	call   801046d0 <pushcli>
  c = mycpu();
80103d0d:	e8 4e fe ff ff       	call   80103b60 <mycpu>
  p = c->proc;
80103d12:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d18:	e8 03 0a 00 00       	call   80104720 <popcli>
  sz = curproc->sz;
80103d1d:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103d1f:	85 f6                	test   %esi,%esi
80103d21:	7f 1d                	jg     80103d40 <growproc+0x40>
  } else if(n < 0){
80103d23:	75 3b                	jne    80103d60 <growproc+0x60>
  switchuvm(curproc);
80103d25:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103d28:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103d2a:	53                   	push   %ebx
80103d2b:	e8 40 2f 00 00       	call   80106c70 <switchuvm>
  return 0;
80103d30:	83 c4 10             	add    $0x10,%esp
80103d33:	31 c0                	xor    %eax,%eax
}
80103d35:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103d38:	5b                   	pop    %ebx
80103d39:	5e                   	pop    %esi
80103d3a:	5d                   	pop    %ebp
80103d3b:	c3                   	ret
80103d3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103d40:	83 ec 04             	sub    $0x4,%esp
80103d43:	01 c6                	add    %eax,%esi
80103d45:	56                   	push   %esi
80103d46:	50                   	push   %eax
80103d47:	ff 73 04             	push   0x4(%ebx)
80103d4a:	e8 81 31 00 00       	call   80106ed0 <allocuvm>
80103d4f:	83 c4 10             	add    $0x10,%esp
80103d52:	85 c0                	test   %eax,%eax
80103d54:	75 cf                	jne    80103d25 <growproc+0x25>
      return -1;
80103d56:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103d5b:	eb d8                	jmp    80103d35 <growproc+0x35>
80103d5d:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103d60:	83 ec 04             	sub    $0x4,%esp
80103d63:	01 c6                	add    %eax,%esi
80103d65:	56                   	push   %esi
80103d66:	50                   	push   %eax
80103d67:	ff 73 04             	push   0x4(%ebx)
80103d6a:	e8 81 32 00 00       	call   80106ff0 <deallocuvm>
80103d6f:	83 c4 10             	add    $0x10,%esp
80103d72:	85 c0                	test   %eax,%eax
80103d74:	75 af                	jne    80103d25 <growproc+0x25>
80103d76:	eb de                	jmp    80103d56 <growproc+0x56>
80103d78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103d7f:	00 

80103d80 <fork>:
{
80103d80:	55                   	push   %ebp
80103d81:	89 e5                	mov    %esp,%ebp
80103d83:	57                   	push   %edi
80103d84:	56                   	push   %esi
80103d85:	53                   	push   %ebx
80103d86:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103d89:	e8 42 09 00 00       	call   801046d0 <pushcli>
  c = mycpu();
80103d8e:	e8 cd fd ff ff       	call   80103b60 <mycpu>
  p = c->proc;
80103d93:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d99:	e8 82 09 00 00       	call   80104720 <popcli>
  if((np = allocproc()) == 0){
80103d9e:	e8 7d fc ff ff       	call   80103a20 <allocproc>
80103da3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103da6:	85 c0                	test   %eax,%eax
80103da8:	0f 84 d6 00 00 00    	je     80103e84 <fork+0x104>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103dae:	83 ec 08             	sub    $0x8,%esp
80103db1:	ff 33                	push   (%ebx)
80103db3:	89 c7                	mov    %eax,%edi
80103db5:	ff 73 04             	push   0x4(%ebx)
80103db8:	e8 d3 33 00 00       	call   80107190 <copyuvm>
80103dbd:	83 c4 10             	add    $0x10,%esp
80103dc0:	89 47 04             	mov    %eax,0x4(%edi)
80103dc3:	85 c0                	test   %eax,%eax
80103dc5:	0f 84 9a 00 00 00    	je     80103e65 <fork+0xe5>
  np->sz = curproc->sz;
80103dcb:	8b 03                	mov    (%ebx),%eax
80103dcd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103dd0:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103dd2:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80103dd5:	89 c8                	mov    %ecx,%eax
80103dd7:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103dda:	b9 13 00 00 00       	mov    $0x13,%ecx
80103ddf:	8b 73 18             	mov    0x18(%ebx),%esi
80103de2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103de4:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103de6:	8b 40 18             	mov    0x18(%eax),%eax
80103de9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103df0:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103df4:	85 c0                	test   %eax,%eax
80103df6:	74 13                	je     80103e0b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103df8:	83 ec 0c             	sub    $0xc,%esp
80103dfb:	50                   	push   %eax
80103dfc:	e8 2f d3 ff ff       	call   80101130 <filedup>
80103e01:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103e04:	83 c4 10             	add    $0x10,%esp
80103e07:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103e0b:	83 c6 01             	add    $0x1,%esi
80103e0e:	83 fe 10             	cmp    $0x10,%esi
80103e11:	75 dd                	jne    80103df0 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103e13:	83 ec 0c             	sub    $0xc,%esp
80103e16:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103e19:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103e1c:	e8 bf db ff ff       	call   801019e0 <idup>
80103e21:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103e24:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103e27:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103e2a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103e2d:	6a 10                	push   $0x10
80103e2f:	53                   	push   %ebx
80103e30:	50                   	push   %eax
80103e31:	e8 9a 0c 00 00       	call   80104ad0 <safestrcpy>
  pid = np->pid;
80103e36:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103e39:	c7 04 24 60 1e 11 80 	movl   $0x80111e60,(%esp)
80103e40:	e8 db 09 00 00       	call   80104820 <acquire>
  np->state = RUNNABLE;
80103e45:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103e4c:	c7 04 24 60 1e 11 80 	movl   $0x80111e60,(%esp)
80103e53:	e8 68 09 00 00       	call   801047c0 <release>
  return pid;
80103e58:	83 c4 10             	add    $0x10,%esp
}
80103e5b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103e5e:	89 d8                	mov    %ebx,%eax
80103e60:	5b                   	pop    %ebx
80103e61:	5e                   	pop    %esi
80103e62:	5f                   	pop    %edi
80103e63:	5d                   	pop    %ebp
80103e64:	c3                   	ret
    kfree(np->kstack);
80103e65:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103e68:	83 ec 0c             	sub    $0xc,%esp
80103e6b:	ff 73 08             	push   0x8(%ebx)
80103e6e:	e8 9d e8 ff ff       	call   80102710 <kfree>
    np->kstack = 0;
80103e73:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103e7a:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103e7d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103e84:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103e89:	eb d0                	jmp    80103e5b <fork+0xdb>
80103e8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103e90 <scheduler>:
{
80103e90:	55                   	push   %ebp
80103e91:	89 e5                	mov    %esp,%ebp
80103e93:	57                   	push   %edi
80103e94:	56                   	push   %esi
80103e95:	53                   	push   %ebx
80103e96:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103e99:	e8 c2 fc ff ff       	call   80103b60 <mycpu>
  c->proc = 0;
80103e9e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103ea5:	00 00 00 
  struct cpu *c = mycpu();
80103ea8:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103eaa:	8d 78 04             	lea    0x4(%eax),%edi
80103ead:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103eb0:	fb                   	sti
    acquire(&ptable.lock);
80103eb1:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103eb4:	bb 94 1e 11 80       	mov    $0x80111e94,%ebx
    acquire(&ptable.lock);
80103eb9:	68 60 1e 11 80       	push   $0x80111e60
80103ebe:	e8 5d 09 00 00       	call   80104820 <acquire>
80103ec3:	83 c4 10             	add    $0x10,%esp
80103ec6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103ecd:	00 
80103ece:	66 90                	xchg   %ax,%ax
      if(p->state != RUNNABLE)
80103ed0:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103ed4:	75 33                	jne    80103f09 <scheduler+0x79>
      switchuvm(p);
80103ed6:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103ed9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103edf:	53                   	push   %ebx
80103ee0:	e8 8b 2d 00 00       	call   80106c70 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103ee5:	58                   	pop    %eax
80103ee6:	5a                   	pop    %edx
80103ee7:	ff 73 1c             	push   0x1c(%ebx)
80103eea:	57                   	push   %edi
      p->state = RUNNING;
80103eeb:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103ef2:	e8 34 0c 00 00       	call   80104b2b <swtch>
      switchkvm();
80103ef7:	e8 64 2d 00 00       	call   80106c60 <switchkvm>
      c->proc = 0;
80103efc:	83 c4 10             	add    $0x10,%esp
80103eff:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103f06:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f09:	83 c3 7c             	add    $0x7c,%ebx
80103f0c:	81 fb 94 3d 11 80    	cmp    $0x80113d94,%ebx
80103f12:	75 bc                	jne    80103ed0 <scheduler+0x40>
    release(&ptable.lock);
80103f14:	83 ec 0c             	sub    $0xc,%esp
80103f17:	68 60 1e 11 80       	push   $0x80111e60
80103f1c:	e8 9f 08 00 00       	call   801047c0 <release>
    sti();
80103f21:	83 c4 10             	add    $0x10,%esp
80103f24:	eb 8a                	jmp    80103eb0 <scheduler+0x20>
80103f26:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f2d:	00 
80103f2e:	66 90                	xchg   %ax,%ax

80103f30 <sched>:
{
80103f30:	55                   	push   %ebp
80103f31:	89 e5                	mov    %esp,%ebp
80103f33:	56                   	push   %esi
80103f34:	53                   	push   %ebx
  pushcli();
80103f35:	e8 96 07 00 00       	call   801046d0 <pushcli>
  c = mycpu();
80103f3a:	e8 21 fc ff ff       	call   80103b60 <mycpu>
  p = c->proc;
80103f3f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103f45:	e8 d6 07 00 00       	call   80104720 <popcli>
  if(!holding(&ptable.lock))
80103f4a:	83 ec 0c             	sub    $0xc,%esp
80103f4d:	68 60 1e 11 80       	push   $0x80111e60
80103f52:	e8 29 08 00 00       	call   80104780 <holding>
80103f57:	83 c4 10             	add    $0x10,%esp
80103f5a:	85 c0                	test   %eax,%eax
80103f5c:	74 4f                	je     80103fad <sched+0x7d>
  if(mycpu()->ncli != 1)
80103f5e:	e8 fd fb ff ff       	call   80103b60 <mycpu>
80103f63:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103f6a:	75 68                	jne    80103fd4 <sched+0xa4>
  if(p->state == RUNNING)
80103f6c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103f70:	74 55                	je     80103fc7 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103f72:	9c                   	pushf
80103f73:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103f74:	f6 c4 02             	test   $0x2,%ah
80103f77:	75 41                	jne    80103fba <sched+0x8a>
  intena = mycpu()->intena;
80103f79:	e8 e2 fb ff ff       	call   80103b60 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103f7e:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103f81:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103f87:	e8 d4 fb ff ff       	call   80103b60 <mycpu>
80103f8c:	83 ec 08             	sub    $0x8,%esp
80103f8f:	ff 70 04             	push   0x4(%eax)
80103f92:	53                   	push   %ebx
80103f93:	e8 93 0b 00 00       	call   80104b2b <swtch>
  mycpu()->intena = intena;
80103f98:	e8 c3 fb ff ff       	call   80103b60 <mycpu>
}
80103f9d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103fa0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103fa6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103fa9:	5b                   	pop    %ebx
80103faa:	5e                   	pop    %esi
80103fab:	5d                   	pop    %ebp
80103fac:	c3                   	ret
    panic("sched ptable.lock");
80103fad:	83 ec 0c             	sub    $0xc,%esp
80103fb0:	68 71 76 10 80       	push   $0x80107671
80103fb5:	e8 c6 c3 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
80103fba:	83 ec 0c             	sub    $0xc,%esp
80103fbd:	68 9d 76 10 80       	push   $0x8010769d
80103fc2:	e8 b9 c3 ff ff       	call   80100380 <panic>
    panic("sched running");
80103fc7:	83 ec 0c             	sub    $0xc,%esp
80103fca:	68 8f 76 10 80       	push   $0x8010768f
80103fcf:	e8 ac c3 ff ff       	call   80100380 <panic>
    panic("sched locks");
80103fd4:	83 ec 0c             	sub    $0xc,%esp
80103fd7:	68 83 76 10 80       	push   $0x80107683
80103fdc:	e8 9f c3 ff ff       	call   80100380 <panic>
80103fe1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103fe8:	00 
80103fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103ff0 <exit>:
{
80103ff0:	55                   	push   %ebp
80103ff1:	89 e5                	mov    %esp,%ebp
80103ff3:	57                   	push   %edi
80103ff4:	56                   	push   %esi
80103ff5:	53                   	push   %ebx
80103ff6:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80103ff9:	e8 e2 fb ff ff       	call   80103be0 <myproc>
  if(curproc == initproc)
80103ffe:	39 05 94 3d 11 80    	cmp    %eax,0x80113d94
80104004:	0f 84 fd 00 00 00    	je     80104107 <exit+0x117>
8010400a:	89 c3                	mov    %eax,%ebx
8010400c:	8d 70 28             	lea    0x28(%eax),%esi
8010400f:	8d 78 68             	lea    0x68(%eax),%edi
80104012:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80104018:	8b 06                	mov    (%esi),%eax
8010401a:	85 c0                	test   %eax,%eax
8010401c:	74 12                	je     80104030 <exit+0x40>
      fileclose(curproc->ofile[fd]);
8010401e:	83 ec 0c             	sub    $0xc,%esp
80104021:	50                   	push   %eax
80104022:	e8 59 d1 ff ff       	call   80101180 <fileclose>
      curproc->ofile[fd] = 0;
80104027:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010402d:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80104030:	83 c6 04             	add    $0x4,%esi
80104033:	39 f7                	cmp    %esi,%edi
80104035:	75 e1                	jne    80104018 <exit+0x28>
  begin_op();
80104037:	e8 84 ef ff ff       	call   80102fc0 <begin_op>
  iput(curproc->cwd);
8010403c:	83 ec 0c             	sub    $0xc,%esp
8010403f:	ff 73 68             	push   0x68(%ebx)
80104042:	e8 f9 da ff ff       	call   80101b40 <iput>
  end_op();
80104047:	e8 e4 ef ff ff       	call   80103030 <end_op>
  curproc->cwd = 0;
8010404c:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80104053:	c7 04 24 60 1e 11 80 	movl   $0x80111e60,(%esp)
8010405a:	e8 c1 07 00 00       	call   80104820 <acquire>
  wakeup1(curproc->parent);
8010405f:	8b 53 14             	mov    0x14(%ebx),%edx
80104062:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104065:	b8 94 1e 11 80       	mov    $0x80111e94,%eax
8010406a:	eb 0e                	jmp    8010407a <exit+0x8a>
8010406c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104070:	83 c0 7c             	add    $0x7c,%eax
80104073:	3d 94 3d 11 80       	cmp    $0x80113d94,%eax
80104078:	74 1c                	je     80104096 <exit+0xa6>
    if(p->state == SLEEPING && p->chan == chan)
8010407a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010407e:	75 f0                	jne    80104070 <exit+0x80>
80104080:	3b 50 20             	cmp    0x20(%eax),%edx
80104083:	75 eb                	jne    80104070 <exit+0x80>
      p->state = RUNNABLE;
80104085:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010408c:	83 c0 7c             	add    $0x7c,%eax
8010408f:	3d 94 3d 11 80       	cmp    $0x80113d94,%eax
80104094:	75 e4                	jne    8010407a <exit+0x8a>
      p->parent = initproc;
80104096:	8b 0d 94 3d 11 80    	mov    0x80113d94,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010409c:	ba 94 1e 11 80       	mov    $0x80111e94,%edx
801040a1:	eb 10                	jmp    801040b3 <exit+0xc3>
801040a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801040a8:	83 c2 7c             	add    $0x7c,%edx
801040ab:	81 fa 94 3d 11 80    	cmp    $0x80113d94,%edx
801040b1:	74 3b                	je     801040ee <exit+0xfe>
    if(p->parent == curproc){
801040b3:	39 5a 14             	cmp    %ebx,0x14(%edx)
801040b6:	75 f0                	jne    801040a8 <exit+0xb8>
      if(p->state == ZOMBIE)
801040b8:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
801040bc:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
801040bf:	75 e7                	jne    801040a8 <exit+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801040c1:	b8 94 1e 11 80       	mov    $0x80111e94,%eax
801040c6:	eb 12                	jmp    801040da <exit+0xea>
801040c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801040cf:	00 
801040d0:	83 c0 7c             	add    $0x7c,%eax
801040d3:	3d 94 3d 11 80       	cmp    $0x80113d94,%eax
801040d8:	74 ce                	je     801040a8 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
801040da:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801040de:	75 f0                	jne    801040d0 <exit+0xe0>
801040e0:	3b 48 20             	cmp    0x20(%eax),%ecx
801040e3:	75 eb                	jne    801040d0 <exit+0xe0>
      p->state = RUNNABLE;
801040e5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801040ec:	eb e2                	jmp    801040d0 <exit+0xe0>
  curproc->state = ZOMBIE;
801040ee:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
801040f5:	e8 36 fe ff ff       	call   80103f30 <sched>
  panic("zombie exit");
801040fa:	83 ec 0c             	sub    $0xc,%esp
801040fd:	68 be 76 10 80       	push   $0x801076be
80104102:	e8 79 c2 ff ff       	call   80100380 <panic>
    panic("init exiting");
80104107:	83 ec 0c             	sub    $0xc,%esp
8010410a:	68 b1 76 10 80       	push   $0x801076b1
8010410f:	e8 6c c2 ff ff       	call   80100380 <panic>
80104114:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010411b:	00 
8010411c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104120 <wait>:
{
80104120:	55                   	push   %ebp
80104121:	89 e5                	mov    %esp,%ebp
80104123:	56                   	push   %esi
80104124:	53                   	push   %ebx
  pushcli();
80104125:	e8 a6 05 00 00       	call   801046d0 <pushcli>
  c = mycpu();
8010412a:	e8 31 fa ff ff       	call   80103b60 <mycpu>
  p = c->proc;
8010412f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80104135:	e8 e6 05 00 00       	call   80104720 <popcli>
  acquire(&ptable.lock);
8010413a:	83 ec 0c             	sub    $0xc,%esp
8010413d:	68 60 1e 11 80       	push   $0x80111e60
80104142:	e8 d9 06 00 00       	call   80104820 <acquire>
80104147:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
8010414a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010414c:	bb 94 1e 11 80       	mov    $0x80111e94,%ebx
80104151:	eb 10                	jmp    80104163 <wait+0x43>
80104153:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104158:	83 c3 7c             	add    $0x7c,%ebx
8010415b:	81 fb 94 3d 11 80    	cmp    $0x80113d94,%ebx
80104161:	74 1b                	je     8010417e <wait+0x5e>
      if(p->parent != curproc)
80104163:	39 73 14             	cmp    %esi,0x14(%ebx)
80104166:	75 f0                	jne    80104158 <wait+0x38>
      if(p->state == ZOMBIE){
80104168:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010416c:	74 62                	je     801041d0 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010416e:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80104171:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104176:	81 fb 94 3d 11 80    	cmp    $0x80113d94,%ebx
8010417c:	75 e5                	jne    80104163 <wait+0x43>
    if(!havekids || curproc->killed){
8010417e:	85 c0                	test   %eax,%eax
80104180:	0f 84 a0 00 00 00    	je     80104226 <wait+0x106>
80104186:	8b 46 24             	mov    0x24(%esi),%eax
80104189:	85 c0                	test   %eax,%eax
8010418b:	0f 85 95 00 00 00    	jne    80104226 <wait+0x106>
  pushcli();
80104191:	e8 3a 05 00 00       	call   801046d0 <pushcli>
  c = mycpu();
80104196:	e8 c5 f9 ff ff       	call   80103b60 <mycpu>
  p = c->proc;
8010419b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801041a1:	e8 7a 05 00 00       	call   80104720 <popcli>
  if(p == 0)
801041a6:	85 db                	test   %ebx,%ebx
801041a8:	0f 84 8f 00 00 00    	je     8010423d <wait+0x11d>
  p->chan = chan;
801041ae:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
801041b1:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801041b8:	e8 73 fd ff ff       	call   80103f30 <sched>
  p->chan = 0;
801041bd:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
801041c4:	eb 84                	jmp    8010414a <wait+0x2a>
801041c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801041cd:	00 
801041ce:	66 90                	xchg   %ax,%ax
        kfree(p->kstack);
801041d0:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
801041d3:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
801041d6:	ff 73 08             	push   0x8(%ebx)
801041d9:	e8 32 e5 ff ff       	call   80102710 <kfree>
        p->kstack = 0;
801041de:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
801041e5:	5a                   	pop    %edx
801041e6:	ff 73 04             	push   0x4(%ebx)
801041e9:	e8 32 2e 00 00       	call   80107020 <freevm>
        p->pid = 0;
801041ee:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
801041f5:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
801041fc:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104200:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104207:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010420e:	c7 04 24 60 1e 11 80 	movl   $0x80111e60,(%esp)
80104215:	e8 a6 05 00 00       	call   801047c0 <release>
        return pid;
8010421a:	83 c4 10             	add    $0x10,%esp
}
8010421d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104220:	89 f0                	mov    %esi,%eax
80104222:	5b                   	pop    %ebx
80104223:	5e                   	pop    %esi
80104224:	5d                   	pop    %ebp
80104225:	c3                   	ret
      release(&ptable.lock);
80104226:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104229:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010422e:	68 60 1e 11 80       	push   $0x80111e60
80104233:	e8 88 05 00 00       	call   801047c0 <release>
      return -1;
80104238:	83 c4 10             	add    $0x10,%esp
8010423b:	eb e0                	jmp    8010421d <wait+0xfd>
    panic("sleep");
8010423d:	83 ec 0c             	sub    $0xc,%esp
80104240:	68 ca 76 10 80       	push   $0x801076ca
80104245:	e8 36 c1 ff ff       	call   80100380 <panic>
8010424a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104250 <yield>:
{
80104250:	55                   	push   %ebp
80104251:	89 e5                	mov    %esp,%ebp
80104253:	53                   	push   %ebx
80104254:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80104257:	68 60 1e 11 80       	push   $0x80111e60
8010425c:	e8 bf 05 00 00       	call   80104820 <acquire>
  pushcli();
80104261:	e8 6a 04 00 00       	call   801046d0 <pushcli>
  c = mycpu();
80104266:	e8 f5 f8 ff ff       	call   80103b60 <mycpu>
  p = c->proc;
8010426b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104271:	e8 aa 04 00 00       	call   80104720 <popcli>
  myproc()->state = RUNNABLE;
80104276:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
8010427d:	e8 ae fc ff ff       	call   80103f30 <sched>
  release(&ptable.lock);
80104282:	c7 04 24 60 1e 11 80 	movl   $0x80111e60,(%esp)
80104289:	e8 32 05 00 00       	call   801047c0 <release>
}
8010428e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104291:	83 c4 10             	add    $0x10,%esp
80104294:	c9                   	leave
80104295:	c3                   	ret
80104296:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010429d:	00 
8010429e:	66 90                	xchg   %ax,%ax

801042a0 <sleep>:
{
801042a0:	55                   	push   %ebp
801042a1:	89 e5                	mov    %esp,%ebp
801042a3:	57                   	push   %edi
801042a4:	56                   	push   %esi
801042a5:	53                   	push   %ebx
801042a6:	83 ec 0c             	sub    $0xc,%esp
801042a9:	8b 7d 08             	mov    0x8(%ebp),%edi
801042ac:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
801042af:	e8 1c 04 00 00       	call   801046d0 <pushcli>
  c = mycpu();
801042b4:	e8 a7 f8 ff ff       	call   80103b60 <mycpu>
  p = c->proc;
801042b9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801042bf:	e8 5c 04 00 00       	call   80104720 <popcli>
  if(p == 0)
801042c4:	85 db                	test   %ebx,%ebx
801042c6:	0f 84 87 00 00 00    	je     80104353 <sleep+0xb3>
  if(lk == 0)
801042cc:	85 f6                	test   %esi,%esi
801042ce:	74 76                	je     80104346 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
801042d0:	81 fe 60 1e 11 80    	cmp    $0x80111e60,%esi
801042d6:	74 50                	je     80104328 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
801042d8:	83 ec 0c             	sub    $0xc,%esp
801042db:	68 60 1e 11 80       	push   $0x80111e60
801042e0:	e8 3b 05 00 00       	call   80104820 <acquire>
    release(lk);
801042e5:	89 34 24             	mov    %esi,(%esp)
801042e8:	e8 d3 04 00 00       	call   801047c0 <release>
  p->chan = chan;
801042ed:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
801042f0:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
801042f7:	e8 34 fc ff ff       	call   80103f30 <sched>
  p->chan = 0;
801042fc:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104303:	c7 04 24 60 1e 11 80 	movl   $0x80111e60,(%esp)
8010430a:	e8 b1 04 00 00       	call   801047c0 <release>
    acquire(lk);
8010430f:	83 c4 10             	add    $0x10,%esp
80104312:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104315:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104318:	5b                   	pop    %ebx
80104319:	5e                   	pop    %esi
8010431a:	5f                   	pop    %edi
8010431b:	5d                   	pop    %ebp
    acquire(lk);
8010431c:	e9 ff 04 00 00       	jmp    80104820 <acquire>
80104321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104328:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010432b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104332:	e8 f9 fb ff ff       	call   80103f30 <sched>
  p->chan = 0;
80104337:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010433e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104341:	5b                   	pop    %ebx
80104342:	5e                   	pop    %esi
80104343:	5f                   	pop    %edi
80104344:	5d                   	pop    %ebp
80104345:	c3                   	ret
    panic("sleep without lk");
80104346:	83 ec 0c             	sub    $0xc,%esp
80104349:	68 d0 76 10 80       	push   $0x801076d0
8010434e:	e8 2d c0 ff ff       	call   80100380 <panic>
    panic("sleep");
80104353:	83 ec 0c             	sub    $0xc,%esp
80104356:	68 ca 76 10 80       	push   $0x801076ca
8010435b:	e8 20 c0 ff ff       	call   80100380 <panic>

80104360 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
80104360:	55                   	push   %ebp
80104361:	89 e5                	mov    %esp,%ebp
80104363:	53                   	push   %ebx
80104364:	83 ec 10             	sub    $0x10,%esp
80104367:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
8010436a:	68 60 1e 11 80       	push   $0x80111e60
8010436f:	e8 ac 04 00 00       	call   80104820 <acquire>
80104374:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104377:	b8 94 1e 11 80       	mov    $0x80111e94,%eax
8010437c:	eb 0c                	jmp    8010438a <wakeup+0x2a>
8010437e:	66 90                	xchg   %ax,%ax
80104380:	83 c0 7c             	add    $0x7c,%eax
80104383:	3d 94 3d 11 80       	cmp    $0x80113d94,%eax
80104388:	74 1c                	je     801043a6 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
8010438a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010438e:	75 f0                	jne    80104380 <wakeup+0x20>
80104390:	3b 58 20             	cmp    0x20(%eax),%ebx
80104393:	75 eb                	jne    80104380 <wakeup+0x20>
      p->state = RUNNABLE;
80104395:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010439c:	83 c0 7c             	add    $0x7c,%eax
8010439f:	3d 94 3d 11 80       	cmp    $0x80113d94,%eax
801043a4:	75 e4                	jne    8010438a <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
801043a6:	c7 45 08 60 1e 11 80 	movl   $0x80111e60,0x8(%ebp)
}
801043ad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801043b0:	c9                   	leave
  release(&ptable.lock);
801043b1:	e9 0a 04 00 00       	jmp    801047c0 <release>
801043b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801043bd:	00 
801043be:	66 90                	xchg   %ax,%ax

801043c0 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	53                   	push   %ebx
801043c4:	83 ec 10             	sub    $0x10,%esp
801043c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
801043ca:	68 60 1e 11 80       	push   $0x80111e60
801043cf:	e8 4c 04 00 00       	call   80104820 <acquire>
801043d4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801043d7:	b8 94 1e 11 80       	mov    $0x80111e94,%eax
801043dc:	eb 0c                	jmp    801043ea <kill+0x2a>
801043de:	66 90                	xchg   %ax,%ax
801043e0:	83 c0 7c             	add    $0x7c,%eax
801043e3:	3d 94 3d 11 80       	cmp    $0x80113d94,%eax
801043e8:	74 36                	je     80104420 <kill+0x60>
    if(p->pid == pid){
801043ea:	39 58 10             	cmp    %ebx,0x10(%eax)
801043ed:	75 f1                	jne    801043e0 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
801043ef:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
801043f3:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
801043fa:	75 07                	jne    80104403 <kill+0x43>
        p->state = RUNNABLE;
801043fc:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104403:	83 ec 0c             	sub    $0xc,%esp
80104406:	68 60 1e 11 80       	push   $0x80111e60
8010440b:	e8 b0 03 00 00       	call   801047c0 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104410:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104413:	83 c4 10             	add    $0x10,%esp
80104416:	31 c0                	xor    %eax,%eax
}
80104418:	c9                   	leave
80104419:	c3                   	ret
8010441a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104420:	83 ec 0c             	sub    $0xc,%esp
80104423:	68 60 1e 11 80       	push   $0x80111e60
80104428:	e8 93 03 00 00       	call   801047c0 <release>
}
8010442d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104430:	83 c4 10             	add    $0x10,%esp
80104433:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104438:	c9                   	leave
80104439:	c3                   	ret
8010443a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104440 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104440:	55                   	push   %ebp
80104441:	89 e5                	mov    %esp,%ebp
80104443:	57                   	push   %edi
80104444:	56                   	push   %esi
80104445:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104448:	53                   	push   %ebx
80104449:	bb 00 1f 11 80       	mov    $0x80111f00,%ebx
8010444e:	83 ec 3c             	sub    $0x3c,%esp
80104451:	eb 24                	jmp    80104477 <procdump+0x37>
80104453:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
80104458:	83 ec 0c             	sub    $0xc,%esp
8010445b:	68 8f 78 10 80       	push   $0x8010788f
80104460:	e8 db c2 ff ff       	call   80100740 <cprintf>
80104465:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104468:	83 c3 7c             	add    $0x7c,%ebx
8010446b:	81 fb 00 3e 11 80    	cmp    $0x80113e00,%ebx
80104471:	0f 84 81 00 00 00    	je     801044f8 <procdump+0xb8>
    if(p->state == UNUSED)
80104477:	8b 43 a0             	mov    -0x60(%ebx),%eax
8010447a:	85 c0                	test   %eax,%eax
8010447c:	74 ea                	je     80104468 <procdump+0x28>
      state = "???";
8010447e:	ba e1 76 10 80       	mov    $0x801076e1,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104483:	83 f8 05             	cmp    $0x5,%eax
80104486:	77 11                	ja     80104499 <procdump+0x59>
80104488:	8b 14 85 00 7d 10 80 	mov    -0x7fef8300(,%eax,4),%edx
      state = "???";
8010448f:	b8 e1 76 10 80       	mov    $0x801076e1,%eax
80104494:	85 d2                	test   %edx,%edx
80104496:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
80104499:	53                   	push   %ebx
8010449a:	52                   	push   %edx
8010449b:	ff 73 a4             	push   -0x5c(%ebx)
8010449e:	68 e5 76 10 80       	push   $0x801076e5
801044a3:	e8 98 c2 ff ff       	call   80100740 <cprintf>
    if(p->state == SLEEPING){
801044a8:	83 c4 10             	add    $0x10,%esp
801044ab:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801044af:	75 a7                	jne    80104458 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
801044b1:	83 ec 08             	sub    $0x8,%esp
801044b4:	8d 45 c0             	lea    -0x40(%ebp),%eax
801044b7:	8d 7d c0             	lea    -0x40(%ebp),%edi
801044ba:	50                   	push   %eax
801044bb:	8b 43 b0             	mov    -0x50(%ebx),%eax
801044be:	8b 40 0c             	mov    0xc(%eax),%eax
801044c1:	83 c0 08             	add    $0x8,%eax
801044c4:	50                   	push   %eax
801044c5:	e8 86 01 00 00       	call   80104650 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
801044ca:	83 c4 10             	add    $0x10,%esp
801044cd:	8d 76 00             	lea    0x0(%esi),%esi
801044d0:	8b 17                	mov    (%edi),%edx
801044d2:	85 d2                	test   %edx,%edx
801044d4:	74 82                	je     80104458 <procdump+0x18>
        cprintf(" %p", pc[i]);
801044d6:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
801044d9:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
801044dc:	52                   	push   %edx
801044dd:	68 21 74 10 80       	push   $0x80107421
801044e2:	e8 59 c2 ff ff       	call   80100740 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
801044e7:	83 c4 10             	add    $0x10,%esp
801044ea:	39 f7                	cmp    %esi,%edi
801044ec:	75 e2                	jne    801044d0 <procdump+0x90>
801044ee:	e9 65 ff ff ff       	jmp    80104458 <procdump+0x18>
801044f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  }
}
801044f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801044fb:	5b                   	pop    %ebx
801044fc:	5e                   	pop    %esi
801044fd:	5f                   	pop    %edi
801044fe:	5d                   	pop    %ebp
801044ff:	c3                   	ret

80104500 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104500:	55                   	push   %ebp
80104501:	89 e5                	mov    %esp,%ebp
80104503:	53                   	push   %ebx
80104504:	83 ec 0c             	sub    $0xc,%esp
80104507:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010450a:	68 18 77 10 80       	push   $0x80107718
8010450f:	8d 43 04             	lea    0x4(%ebx),%eax
80104512:	50                   	push   %eax
80104513:	e8 18 01 00 00       	call   80104630 <initlock>
  lk->name = name;
80104518:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010451b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104521:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104524:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010452b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010452e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104531:	c9                   	leave
80104532:	c3                   	ret
80104533:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010453a:	00 
8010453b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104540 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	56                   	push   %esi
80104544:	53                   	push   %ebx
80104545:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104548:	8d 73 04             	lea    0x4(%ebx),%esi
8010454b:	83 ec 0c             	sub    $0xc,%esp
8010454e:	56                   	push   %esi
8010454f:	e8 cc 02 00 00       	call   80104820 <acquire>
  while (lk->locked) {
80104554:	8b 13                	mov    (%ebx),%edx
80104556:	83 c4 10             	add    $0x10,%esp
80104559:	85 d2                	test   %edx,%edx
8010455b:	74 16                	je     80104573 <acquiresleep+0x33>
8010455d:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
80104560:	83 ec 08             	sub    $0x8,%esp
80104563:	56                   	push   %esi
80104564:	53                   	push   %ebx
80104565:	e8 36 fd ff ff       	call   801042a0 <sleep>
  while (lk->locked) {
8010456a:	8b 03                	mov    (%ebx),%eax
8010456c:	83 c4 10             	add    $0x10,%esp
8010456f:	85 c0                	test   %eax,%eax
80104571:	75 ed                	jne    80104560 <acquiresleep+0x20>
  }
  lk->locked = 1;
80104573:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
80104579:	e8 62 f6 ff ff       	call   80103be0 <myproc>
8010457e:	8b 40 10             	mov    0x10(%eax),%eax
80104581:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
80104584:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104587:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010458a:	5b                   	pop    %ebx
8010458b:	5e                   	pop    %esi
8010458c:	5d                   	pop    %ebp
  release(&lk->lk);
8010458d:	e9 2e 02 00 00       	jmp    801047c0 <release>
80104592:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104599:	00 
8010459a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801045a0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801045a0:	55                   	push   %ebp
801045a1:	89 e5                	mov    %esp,%ebp
801045a3:	56                   	push   %esi
801045a4:	53                   	push   %ebx
801045a5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801045a8:	8d 73 04             	lea    0x4(%ebx),%esi
801045ab:	83 ec 0c             	sub    $0xc,%esp
801045ae:	56                   	push   %esi
801045af:	e8 6c 02 00 00       	call   80104820 <acquire>
  lk->locked = 0;
801045b4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
801045ba:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
801045c1:	89 1c 24             	mov    %ebx,(%esp)
801045c4:	e8 97 fd ff ff       	call   80104360 <wakeup>
  release(&lk->lk);
801045c9:	83 c4 10             	add    $0x10,%esp
801045cc:	89 75 08             	mov    %esi,0x8(%ebp)
}
801045cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045d2:	5b                   	pop    %ebx
801045d3:	5e                   	pop    %esi
801045d4:	5d                   	pop    %ebp
  release(&lk->lk);
801045d5:	e9 e6 01 00 00       	jmp    801047c0 <release>
801045da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801045e0 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	57                   	push   %edi
801045e4:	31 ff                	xor    %edi,%edi
801045e6:	56                   	push   %esi
801045e7:	53                   	push   %ebx
801045e8:	83 ec 18             	sub    $0x18,%esp
801045eb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
801045ee:	8d 73 04             	lea    0x4(%ebx),%esi
801045f1:	56                   	push   %esi
801045f2:	e8 29 02 00 00       	call   80104820 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
801045f7:	8b 03                	mov    (%ebx),%eax
801045f9:	83 c4 10             	add    $0x10,%esp
801045fc:	85 c0                	test   %eax,%eax
801045fe:	75 18                	jne    80104618 <holdingsleep+0x38>
  release(&lk->lk);
80104600:	83 ec 0c             	sub    $0xc,%esp
80104603:	56                   	push   %esi
80104604:	e8 b7 01 00 00       	call   801047c0 <release>
  return r;
}
80104609:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010460c:	89 f8                	mov    %edi,%eax
8010460e:	5b                   	pop    %ebx
8010460f:	5e                   	pop    %esi
80104610:	5f                   	pop    %edi
80104611:	5d                   	pop    %ebp
80104612:	c3                   	ret
80104613:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
80104618:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
8010461b:	e8 c0 f5 ff ff       	call   80103be0 <myproc>
80104620:	39 58 10             	cmp    %ebx,0x10(%eax)
80104623:	0f 94 c0             	sete   %al
80104626:	0f b6 c0             	movzbl %al,%eax
80104629:	89 c7                	mov    %eax,%edi
8010462b:	eb d3                	jmp    80104600 <holdingsleep+0x20>
8010462d:	66 90                	xchg   %ax,%ax
8010462f:	90                   	nop

80104630 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104630:	55                   	push   %ebp
80104631:	89 e5                	mov    %esp,%ebp
80104633:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104636:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104639:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010463f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104642:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104649:	5d                   	pop    %ebp
8010464a:	c3                   	ret
8010464b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104650 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
80104650:	55                   	push   %ebp
80104651:	89 e5                	mov    %esp,%ebp
80104653:	53                   	push   %ebx
80104654:	8b 45 08             	mov    0x8(%ebp),%eax
80104657:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
8010465a:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
8010465d:	05 f8 ff ff 7f       	add    $0x7ffffff8,%eax
80104662:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
  for(i = 0; i < 10; i++){
80104667:	b8 00 00 00 00       	mov    $0x0,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
8010466c:	76 10                	jbe    8010467e <getcallerpcs+0x2e>
8010466e:	eb 28                	jmp    80104698 <getcallerpcs+0x48>
80104670:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104676:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
8010467c:	77 1a                	ja     80104698 <getcallerpcs+0x48>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010467e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104681:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
80104684:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
80104687:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
80104689:	83 f8 0a             	cmp    $0xa,%eax
8010468c:	75 e2                	jne    80104670 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
8010468e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104691:	c9                   	leave
80104692:	c3                   	ret
80104693:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104698:	8d 04 81             	lea    (%ecx,%eax,4),%eax
8010469b:	83 c1 28             	add    $0x28,%ecx
8010469e:	89 ca                	mov    %ecx,%edx
801046a0:	29 c2                	sub    %eax,%edx
801046a2:	83 e2 04             	and    $0x4,%edx
801046a5:	74 11                	je     801046b8 <getcallerpcs+0x68>
    pcs[i] = 0;
801046a7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801046ad:	83 c0 04             	add    $0x4,%eax
801046b0:	39 c1                	cmp    %eax,%ecx
801046b2:	74 da                	je     8010468e <getcallerpcs+0x3e>
801046b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
801046b8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801046be:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
801046c1:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
801046c8:	39 c1                	cmp    %eax,%ecx
801046ca:	75 ec                	jne    801046b8 <getcallerpcs+0x68>
801046cc:	eb c0                	jmp    8010468e <getcallerpcs+0x3e>
801046ce:	66 90                	xchg   %ax,%ax

801046d0 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801046d0:	55                   	push   %ebp
801046d1:	89 e5                	mov    %esp,%ebp
801046d3:	53                   	push   %ebx
801046d4:	83 ec 04             	sub    $0x4,%esp
801046d7:	9c                   	pushf
801046d8:	5b                   	pop    %ebx
  asm volatile("cli");
801046d9:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
801046da:	e8 81 f4 ff ff       	call   80103b60 <mycpu>
801046df:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801046e5:	85 c0                	test   %eax,%eax
801046e7:	74 17                	je     80104700 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
801046e9:	e8 72 f4 ff ff       	call   80103b60 <mycpu>
801046ee:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
801046f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801046f8:	c9                   	leave
801046f9:	c3                   	ret
801046fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104700:	e8 5b f4 ff ff       	call   80103b60 <mycpu>
80104705:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010470b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104711:	eb d6                	jmp    801046e9 <pushcli+0x19>
80104713:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010471a:	00 
8010471b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104720 <popcli>:

void
popcli(void)
{
80104720:	55                   	push   %ebp
80104721:	89 e5                	mov    %esp,%ebp
80104723:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104726:	9c                   	pushf
80104727:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104728:	f6 c4 02             	test   $0x2,%ah
8010472b:	75 35                	jne    80104762 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010472d:	e8 2e f4 ff ff       	call   80103b60 <mycpu>
80104732:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104739:	78 34                	js     8010476f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010473b:	e8 20 f4 ff ff       	call   80103b60 <mycpu>
80104740:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104746:	85 d2                	test   %edx,%edx
80104748:	74 06                	je     80104750 <popcli+0x30>
    sti();
}
8010474a:	c9                   	leave
8010474b:	c3                   	ret
8010474c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104750:	e8 0b f4 ff ff       	call   80103b60 <mycpu>
80104755:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010475b:	85 c0                	test   %eax,%eax
8010475d:	74 eb                	je     8010474a <popcli+0x2a>
  asm volatile("sti");
8010475f:	fb                   	sti
}
80104760:	c9                   	leave
80104761:	c3                   	ret
    panic("popcli - interruptible");
80104762:	83 ec 0c             	sub    $0xc,%esp
80104765:	68 23 77 10 80       	push   $0x80107723
8010476a:	e8 11 bc ff ff       	call   80100380 <panic>
    panic("popcli");
8010476f:	83 ec 0c             	sub    $0xc,%esp
80104772:	68 3a 77 10 80       	push   $0x8010773a
80104777:	e8 04 bc ff ff       	call   80100380 <panic>
8010477c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104780 <holding>:
{
80104780:	55                   	push   %ebp
80104781:	89 e5                	mov    %esp,%ebp
80104783:	56                   	push   %esi
80104784:	53                   	push   %ebx
80104785:	8b 75 08             	mov    0x8(%ebp),%esi
80104788:	31 db                	xor    %ebx,%ebx
  pushcli();
8010478a:	e8 41 ff ff ff       	call   801046d0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010478f:	8b 06                	mov    (%esi),%eax
80104791:	85 c0                	test   %eax,%eax
80104793:	75 0b                	jne    801047a0 <holding+0x20>
  popcli();
80104795:	e8 86 ff ff ff       	call   80104720 <popcli>
}
8010479a:	89 d8                	mov    %ebx,%eax
8010479c:	5b                   	pop    %ebx
8010479d:	5e                   	pop    %esi
8010479e:	5d                   	pop    %ebp
8010479f:	c3                   	ret
  r = lock->locked && lock->cpu == mycpu();
801047a0:	8b 5e 08             	mov    0x8(%esi),%ebx
801047a3:	e8 b8 f3 ff ff       	call   80103b60 <mycpu>
801047a8:	39 c3                	cmp    %eax,%ebx
801047aa:	0f 94 c3             	sete   %bl
  popcli();
801047ad:	e8 6e ff ff ff       	call   80104720 <popcli>
  r = lock->locked && lock->cpu == mycpu();
801047b2:	0f b6 db             	movzbl %bl,%ebx
}
801047b5:	89 d8                	mov    %ebx,%eax
801047b7:	5b                   	pop    %ebx
801047b8:	5e                   	pop    %esi
801047b9:	5d                   	pop    %ebp
801047ba:	c3                   	ret
801047bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801047c0 <release>:
{
801047c0:	55                   	push   %ebp
801047c1:	89 e5                	mov    %esp,%ebp
801047c3:	56                   	push   %esi
801047c4:	53                   	push   %ebx
801047c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
801047c8:	e8 03 ff ff ff       	call   801046d0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801047cd:	8b 03                	mov    (%ebx),%eax
801047cf:	85 c0                	test   %eax,%eax
801047d1:	75 15                	jne    801047e8 <release+0x28>
  popcli();
801047d3:	e8 48 ff ff ff       	call   80104720 <popcli>
    panic("release");
801047d8:	83 ec 0c             	sub    $0xc,%esp
801047db:	68 41 77 10 80       	push   $0x80107741
801047e0:	e8 9b bb ff ff       	call   80100380 <panic>
801047e5:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
801047e8:	8b 73 08             	mov    0x8(%ebx),%esi
801047eb:	e8 70 f3 ff ff       	call   80103b60 <mycpu>
801047f0:	39 c6                	cmp    %eax,%esi
801047f2:	75 df                	jne    801047d3 <release+0x13>
  popcli();
801047f4:	e8 27 ff ff ff       	call   80104720 <popcli>
  lk->pcs[0] = 0;
801047f9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104800:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104807:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010480c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104812:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104815:	5b                   	pop    %ebx
80104816:	5e                   	pop    %esi
80104817:	5d                   	pop    %ebp
  popcli();
80104818:	e9 03 ff ff ff       	jmp    80104720 <popcli>
8010481d:	8d 76 00             	lea    0x0(%esi),%esi

80104820 <acquire>:
{
80104820:	55                   	push   %ebp
80104821:	89 e5                	mov    %esp,%ebp
80104823:	53                   	push   %ebx
80104824:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104827:	e8 a4 fe ff ff       	call   801046d0 <pushcli>
  if(holding(lk))
8010482c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
8010482f:	e8 9c fe ff ff       	call   801046d0 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104834:	8b 03                	mov    (%ebx),%eax
80104836:	85 c0                	test   %eax,%eax
80104838:	0f 85 b2 00 00 00    	jne    801048f0 <acquire+0xd0>
  popcli();
8010483e:	e8 dd fe ff ff       	call   80104720 <popcli>
  asm volatile("lock; xchgl %0, %1" :
80104843:	b9 01 00 00 00       	mov    $0x1,%ecx
80104848:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010484f:	00 
  while(xchg(&lk->locked, 1) != 0)
80104850:	8b 55 08             	mov    0x8(%ebp),%edx
80104853:	89 c8                	mov    %ecx,%eax
80104855:	f0 87 02             	lock xchg %eax,(%edx)
80104858:	85 c0                	test   %eax,%eax
8010485a:	75 f4                	jne    80104850 <acquire+0x30>
  __sync_synchronize();
8010485c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104861:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104864:	e8 f7 f2 ff ff       	call   80103b60 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104869:	8b 4d 08             	mov    0x8(%ebp),%ecx
  for(i = 0; i < 10; i++){
8010486c:	31 d2                	xor    %edx,%edx
  lk->cpu = mycpu();
8010486e:	89 43 08             	mov    %eax,0x8(%ebx)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104871:	8d 85 00 00 00 80    	lea    -0x80000000(%ebp),%eax
80104877:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
8010487c:	77 32                	ja     801048b0 <acquire+0x90>
  ebp = (uint*)v - 2;
8010487e:	89 e8                	mov    %ebp,%eax
80104880:	eb 14                	jmp    80104896 <acquire+0x76>
80104882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104888:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
8010488e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104894:	77 1a                	ja     801048b0 <acquire+0x90>
    pcs[i] = ebp[1];     // saved %eip
80104896:	8b 58 04             	mov    0x4(%eax),%ebx
80104899:	89 5c 91 0c          	mov    %ebx,0xc(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
8010489d:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801048a0:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801048a2:	83 fa 0a             	cmp    $0xa,%edx
801048a5:	75 e1                	jne    80104888 <acquire+0x68>
}
801048a7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048aa:	c9                   	leave
801048ab:	c3                   	ret
801048ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801048b0:	8d 44 91 0c          	lea    0xc(%ecx,%edx,4),%eax
801048b4:	83 c1 34             	add    $0x34,%ecx
801048b7:	89 ca                	mov    %ecx,%edx
801048b9:	29 c2                	sub    %eax,%edx
801048bb:	83 e2 04             	and    $0x4,%edx
801048be:	74 10                	je     801048d0 <acquire+0xb0>
    pcs[i] = 0;
801048c0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801048c6:	83 c0 04             	add    $0x4,%eax
801048c9:	39 c1                	cmp    %eax,%ecx
801048cb:	74 da                	je     801048a7 <acquire+0x87>
801048cd:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
801048d0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801048d6:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
801048d9:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
801048e0:	39 c1                	cmp    %eax,%ecx
801048e2:	75 ec                	jne    801048d0 <acquire+0xb0>
801048e4:	eb c1                	jmp    801048a7 <acquire+0x87>
801048e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801048ed:	00 
801048ee:	66 90                	xchg   %ax,%ax
  r = lock->locked && lock->cpu == mycpu();
801048f0:	8b 5b 08             	mov    0x8(%ebx),%ebx
801048f3:	e8 68 f2 ff ff       	call   80103b60 <mycpu>
801048f8:	39 c3                	cmp    %eax,%ebx
801048fa:	0f 85 3e ff ff ff    	jne    8010483e <acquire+0x1e>
  popcli();
80104900:	e8 1b fe ff ff       	call   80104720 <popcli>
    panic("acquire");
80104905:	83 ec 0c             	sub    $0xc,%esp
80104908:	68 49 77 10 80       	push   $0x80107749
8010490d:	e8 6e ba ff ff       	call   80100380 <panic>
80104912:	66 90                	xchg   %ax,%ax
80104914:	66 90                	xchg   %ax,%ax
80104916:	66 90                	xchg   %ax,%ax
80104918:	66 90                	xchg   %ax,%ax
8010491a:	66 90                	xchg   %ax,%ax
8010491c:	66 90                	xchg   %ax,%ax
8010491e:	66 90                	xchg   %ax,%ax

80104920 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104920:	55                   	push   %ebp
80104921:	89 e5                	mov    %esp,%ebp
80104923:	57                   	push   %edi
80104924:	8b 55 08             	mov    0x8(%ebp),%edx
80104927:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010492a:	89 d0                	mov    %edx,%eax
8010492c:	09 c8                	or     %ecx,%eax
8010492e:	a8 03                	test   $0x3,%al
80104930:	75 1e                	jne    80104950 <memset+0x30>
    c &= 0xFF;
80104932:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104936:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
80104939:	89 d7                	mov    %edx,%edi
8010493b:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
80104941:	fc                   	cld
80104942:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104944:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104947:	89 d0                	mov    %edx,%eax
80104949:	c9                   	leave
8010494a:	c3                   	ret
8010494b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
80104950:	8b 45 0c             	mov    0xc(%ebp),%eax
80104953:	89 d7                	mov    %edx,%edi
80104955:	fc                   	cld
80104956:	f3 aa                	rep stos %al,%es:(%edi)
80104958:	8b 7d fc             	mov    -0x4(%ebp),%edi
8010495b:	89 d0                	mov    %edx,%eax
8010495d:	c9                   	leave
8010495e:	c3                   	ret
8010495f:	90                   	nop

80104960 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104960:	55                   	push   %ebp
80104961:	89 e5                	mov    %esp,%ebp
80104963:	56                   	push   %esi
80104964:	8b 75 10             	mov    0x10(%ebp),%esi
80104967:	8b 45 08             	mov    0x8(%ebp),%eax
8010496a:	53                   	push   %ebx
8010496b:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
8010496e:	85 f6                	test   %esi,%esi
80104970:	74 2e                	je     801049a0 <memcmp+0x40>
80104972:	01 c6                	add    %eax,%esi
80104974:	eb 14                	jmp    8010498a <memcmp+0x2a>
80104976:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010497d:	00 
8010497e:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
80104980:	83 c0 01             	add    $0x1,%eax
80104983:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
80104986:	39 f0                	cmp    %esi,%eax
80104988:	74 16                	je     801049a0 <memcmp+0x40>
    if(*s1 != *s2)
8010498a:	0f b6 08             	movzbl (%eax),%ecx
8010498d:	0f b6 1a             	movzbl (%edx),%ebx
80104990:	38 d9                	cmp    %bl,%cl
80104992:	74 ec                	je     80104980 <memcmp+0x20>
      return *s1 - *s2;
80104994:	0f b6 c1             	movzbl %cl,%eax
80104997:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
80104999:	5b                   	pop    %ebx
8010499a:	5e                   	pop    %esi
8010499b:	5d                   	pop    %ebp
8010499c:	c3                   	ret
8010499d:	8d 76 00             	lea    0x0(%esi),%esi
801049a0:	5b                   	pop    %ebx
  return 0;
801049a1:	31 c0                	xor    %eax,%eax
}
801049a3:	5e                   	pop    %esi
801049a4:	5d                   	pop    %ebp
801049a5:	c3                   	ret
801049a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801049ad:	00 
801049ae:	66 90                	xchg   %ax,%ax

801049b0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801049b0:	55                   	push   %ebp
801049b1:	89 e5                	mov    %esp,%ebp
801049b3:	57                   	push   %edi
801049b4:	8b 55 08             	mov    0x8(%ebp),%edx
801049b7:	8b 45 10             	mov    0x10(%ebp),%eax
801049ba:	56                   	push   %esi
801049bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
801049be:	39 d6                	cmp    %edx,%esi
801049c0:	73 26                	jae    801049e8 <memmove+0x38>
801049c2:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
801049c5:	39 ca                	cmp    %ecx,%edx
801049c7:	73 1f                	jae    801049e8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
801049c9:	85 c0                	test   %eax,%eax
801049cb:	74 0f                	je     801049dc <memmove+0x2c>
801049cd:	83 e8 01             	sub    $0x1,%eax
      *--d = *--s;
801049d0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
801049d4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
801049d7:	83 e8 01             	sub    $0x1,%eax
801049da:	73 f4                	jae    801049d0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
801049dc:	5e                   	pop    %esi
801049dd:	89 d0                	mov    %edx,%eax
801049df:	5f                   	pop    %edi
801049e0:	5d                   	pop    %ebp
801049e1:	c3                   	ret
801049e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
801049e8:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
801049eb:	89 d7                	mov    %edx,%edi
801049ed:	85 c0                	test   %eax,%eax
801049ef:	74 eb                	je     801049dc <memmove+0x2c>
801049f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
801049f8:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
801049f9:	39 ce                	cmp    %ecx,%esi
801049fb:	75 fb                	jne    801049f8 <memmove+0x48>
}
801049fd:	5e                   	pop    %esi
801049fe:	89 d0                	mov    %edx,%eax
80104a00:	5f                   	pop    %edi
80104a01:	5d                   	pop    %ebp
80104a02:	c3                   	ret
80104a03:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a0a:	00 
80104a0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104a10 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104a10:	eb 9e                	jmp    801049b0 <memmove>
80104a12:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a19:	00 
80104a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a20 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	53                   	push   %ebx
80104a24:	8b 55 10             	mov    0x10(%ebp),%edx
80104a27:	8b 45 08             	mov    0x8(%ebp),%eax
80104a2a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
80104a2d:	85 d2                	test   %edx,%edx
80104a2f:	75 16                	jne    80104a47 <strncmp+0x27>
80104a31:	eb 2d                	jmp    80104a60 <strncmp+0x40>
80104a33:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a38:	3a 19                	cmp    (%ecx),%bl
80104a3a:	75 12                	jne    80104a4e <strncmp+0x2e>
    n--, p++, q++;
80104a3c:	83 c0 01             	add    $0x1,%eax
80104a3f:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104a42:	83 ea 01             	sub    $0x1,%edx
80104a45:	74 19                	je     80104a60 <strncmp+0x40>
80104a47:	0f b6 18             	movzbl (%eax),%ebx
80104a4a:	84 db                	test   %bl,%bl
80104a4c:	75 ea                	jne    80104a38 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
80104a4e:	0f b6 00             	movzbl (%eax),%eax
80104a51:	0f b6 11             	movzbl (%ecx),%edx
}
80104a54:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a57:	c9                   	leave
  return (uchar)*p - (uchar)*q;
80104a58:	29 d0                	sub    %edx,%eax
}
80104a5a:	c3                   	ret
80104a5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a60:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
80104a63:	31 c0                	xor    %eax,%eax
}
80104a65:	c9                   	leave
80104a66:	c3                   	ret
80104a67:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a6e:	00 
80104a6f:	90                   	nop

80104a70 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104a70:	55                   	push   %ebp
80104a71:	89 e5                	mov    %esp,%ebp
80104a73:	57                   	push   %edi
80104a74:	56                   	push   %esi
80104a75:	8b 75 08             	mov    0x8(%ebp),%esi
80104a78:	53                   	push   %ebx
80104a79:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104a7c:	89 f0                	mov    %esi,%eax
80104a7e:	eb 15                	jmp    80104a95 <strncpy+0x25>
80104a80:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80104a84:	8b 7d 0c             	mov    0xc(%ebp),%edi
80104a87:	83 c0 01             	add    $0x1,%eax
80104a8a:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
80104a8e:	88 48 ff             	mov    %cl,-0x1(%eax)
80104a91:	84 c9                	test   %cl,%cl
80104a93:	74 13                	je     80104aa8 <strncpy+0x38>
80104a95:	89 d3                	mov    %edx,%ebx
80104a97:	83 ea 01             	sub    $0x1,%edx
80104a9a:	85 db                	test   %ebx,%ebx
80104a9c:	7f e2                	jg     80104a80 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
80104a9e:	5b                   	pop    %ebx
80104a9f:	89 f0                	mov    %esi,%eax
80104aa1:	5e                   	pop    %esi
80104aa2:	5f                   	pop    %edi
80104aa3:	5d                   	pop    %ebp
80104aa4:	c3                   	ret
80104aa5:	8d 76 00             	lea    0x0(%esi),%esi
  while(n-- > 0)
80104aa8:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
80104aab:	83 e9 01             	sub    $0x1,%ecx
80104aae:	85 d2                	test   %edx,%edx
80104ab0:	74 ec                	je     80104a9e <strncpy+0x2e>
80104ab2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *s++ = 0;
80104ab8:	83 c0 01             	add    $0x1,%eax
80104abb:	89 ca                	mov    %ecx,%edx
80104abd:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
80104ac1:	29 c2                	sub    %eax,%edx
80104ac3:	85 d2                	test   %edx,%edx
80104ac5:	7f f1                	jg     80104ab8 <strncpy+0x48>
}
80104ac7:	5b                   	pop    %ebx
80104ac8:	89 f0                	mov    %esi,%eax
80104aca:	5e                   	pop    %esi
80104acb:	5f                   	pop    %edi
80104acc:	5d                   	pop    %ebp
80104acd:	c3                   	ret
80104ace:	66 90                	xchg   %ax,%ax

80104ad0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104ad0:	55                   	push   %ebp
80104ad1:	89 e5                	mov    %esp,%ebp
80104ad3:	56                   	push   %esi
80104ad4:	8b 55 10             	mov    0x10(%ebp),%edx
80104ad7:	8b 75 08             	mov    0x8(%ebp),%esi
80104ada:	53                   	push   %ebx
80104adb:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
80104ade:	85 d2                	test   %edx,%edx
80104ae0:	7e 25                	jle    80104b07 <safestrcpy+0x37>
80104ae2:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104ae6:	89 f2                	mov    %esi,%edx
80104ae8:	eb 16                	jmp    80104b00 <safestrcpy+0x30>
80104aea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104af0:	0f b6 08             	movzbl (%eax),%ecx
80104af3:	83 c0 01             	add    $0x1,%eax
80104af6:	83 c2 01             	add    $0x1,%edx
80104af9:	88 4a ff             	mov    %cl,-0x1(%edx)
80104afc:	84 c9                	test   %cl,%cl
80104afe:	74 04                	je     80104b04 <safestrcpy+0x34>
80104b00:	39 d8                	cmp    %ebx,%eax
80104b02:	75 ec                	jne    80104af0 <safestrcpy+0x20>
    ;
  *s = 0;
80104b04:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104b07:	89 f0                	mov    %esi,%eax
80104b09:	5b                   	pop    %ebx
80104b0a:	5e                   	pop    %esi
80104b0b:	5d                   	pop    %ebp
80104b0c:	c3                   	ret
80104b0d:	8d 76 00             	lea    0x0(%esi),%esi

80104b10 <strlen>:

int
strlen(const char *s)
{
80104b10:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104b11:	31 c0                	xor    %eax,%eax
{
80104b13:	89 e5                	mov    %esp,%ebp
80104b15:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104b18:	80 3a 00             	cmpb   $0x0,(%edx)
80104b1b:	74 0c                	je     80104b29 <strlen+0x19>
80104b1d:	8d 76 00             	lea    0x0(%esi),%esi
80104b20:	83 c0 01             	add    $0x1,%eax
80104b23:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104b27:	75 f7                	jne    80104b20 <strlen+0x10>
    ;
  return n;
}
80104b29:	5d                   	pop    %ebp
80104b2a:	c3                   	ret

80104b2b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104b2b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104b2f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104b33:	55                   	push   %ebp
  pushl %ebx
80104b34:	53                   	push   %ebx
  pushl %esi
80104b35:	56                   	push   %esi
  pushl %edi
80104b36:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104b37:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104b39:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104b3b:	5f                   	pop    %edi
  popl %esi
80104b3c:	5e                   	pop    %esi
  popl %ebx
80104b3d:	5b                   	pop    %ebx
  popl %ebp
80104b3e:	5d                   	pop    %ebp
  ret
80104b3f:	c3                   	ret

80104b40 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104b40:	55                   	push   %ebp
80104b41:	89 e5                	mov    %esp,%ebp
80104b43:	53                   	push   %ebx
80104b44:	83 ec 04             	sub    $0x4,%esp
80104b47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104b4a:	e8 91 f0 ff ff       	call   80103be0 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104b4f:	8b 00                	mov    (%eax),%eax
80104b51:	39 c3                	cmp    %eax,%ebx
80104b53:	73 1b                	jae    80104b70 <fetchint+0x30>
80104b55:	8d 53 04             	lea    0x4(%ebx),%edx
80104b58:	39 d0                	cmp    %edx,%eax
80104b5a:	72 14                	jb     80104b70 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104b5c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b5f:	8b 13                	mov    (%ebx),%edx
80104b61:	89 10                	mov    %edx,(%eax)
  return 0;
80104b63:	31 c0                	xor    %eax,%eax
}
80104b65:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b68:	c9                   	leave
80104b69:	c3                   	ret
80104b6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104b70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104b75:	eb ee                	jmp    80104b65 <fetchint+0x25>
80104b77:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b7e:	00 
80104b7f:	90                   	nop

80104b80 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104b80:	55                   	push   %ebp
80104b81:	89 e5                	mov    %esp,%ebp
80104b83:	53                   	push   %ebx
80104b84:	83 ec 04             	sub    $0x4,%esp
80104b87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104b8a:	e8 51 f0 ff ff       	call   80103be0 <myproc>

  if(addr >= curproc->sz)
80104b8f:	3b 18                	cmp    (%eax),%ebx
80104b91:	73 2d                	jae    80104bc0 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
80104b93:	8b 55 0c             	mov    0xc(%ebp),%edx
80104b96:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104b98:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104b9a:	39 d3                	cmp    %edx,%ebx
80104b9c:	73 22                	jae    80104bc0 <fetchstr+0x40>
80104b9e:	89 d8                	mov    %ebx,%eax
80104ba0:	eb 0d                	jmp    80104baf <fetchstr+0x2f>
80104ba2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ba8:	83 c0 01             	add    $0x1,%eax
80104bab:	39 d0                	cmp    %edx,%eax
80104bad:	73 11                	jae    80104bc0 <fetchstr+0x40>
    if(*s == 0)
80104baf:	80 38 00             	cmpb   $0x0,(%eax)
80104bb2:	75 f4                	jne    80104ba8 <fetchstr+0x28>
      return s - *pp;
80104bb4:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104bb6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104bb9:	c9                   	leave
80104bba:	c3                   	ret
80104bbb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104bc0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80104bc3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104bc8:	c9                   	leave
80104bc9:	c3                   	ret
80104bca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104bd0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104bd0:	55                   	push   %ebp
80104bd1:	89 e5                	mov    %esp,%ebp
80104bd3:	56                   	push   %esi
80104bd4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104bd5:	e8 06 f0 ff ff       	call   80103be0 <myproc>
80104bda:	8b 55 08             	mov    0x8(%ebp),%edx
80104bdd:	8b 40 18             	mov    0x18(%eax),%eax
80104be0:	8b 40 44             	mov    0x44(%eax),%eax
80104be3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104be6:	e8 f5 ef ff ff       	call   80103be0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104beb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104bee:	8b 00                	mov    (%eax),%eax
80104bf0:	39 c6                	cmp    %eax,%esi
80104bf2:	73 1c                	jae    80104c10 <argint+0x40>
80104bf4:	8d 53 08             	lea    0x8(%ebx),%edx
80104bf7:	39 d0                	cmp    %edx,%eax
80104bf9:	72 15                	jb     80104c10 <argint+0x40>
  *ip = *(int*)(addr);
80104bfb:	8b 45 0c             	mov    0xc(%ebp),%eax
80104bfe:	8b 53 04             	mov    0x4(%ebx),%edx
80104c01:	89 10                	mov    %edx,(%eax)
  return 0;
80104c03:	31 c0                	xor    %eax,%eax
}
80104c05:	5b                   	pop    %ebx
80104c06:	5e                   	pop    %esi
80104c07:	5d                   	pop    %ebp
80104c08:	c3                   	ret
80104c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104c10:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c15:	eb ee                	jmp    80104c05 <argint+0x35>
80104c17:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c1e:	00 
80104c1f:	90                   	nop

80104c20 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104c20:	55                   	push   %ebp
80104c21:	89 e5                	mov    %esp,%ebp
80104c23:	57                   	push   %edi
80104c24:	56                   	push   %esi
80104c25:	53                   	push   %ebx
80104c26:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80104c29:	e8 b2 ef ff ff       	call   80103be0 <myproc>
80104c2e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c30:	e8 ab ef ff ff       	call   80103be0 <myproc>
80104c35:	8b 55 08             	mov    0x8(%ebp),%edx
80104c38:	8b 40 18             	mov    0x18(%eax),%eax
80104c3b:	8b 40 44             	mov    0x44(%eax),%eax
80104c3e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104c41:	e8 9a ef ff ff       	call   80103be0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c46:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104c49:	8b 00                	mov    (%eax),%eax
80104c4b:	39 c7                	cmp    %eax,%edi
80104c4d:	73 31                	jae    80104c80 <argptr+0x60>
80104c4f:	8d 4b 08             	lea    0x8(%ebx),%ecx
80104c52:	39 c8                	cmp    %ecx,%eax
80104c54:	72 2a                	jb     80104c80 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104c56:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80104c59:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104c5c:	85 d2                	test   %edx,%edx
80104c5e:	78 20                	js     80104c80 <argptr+0x60>
80104c60:	8b 16                	mov    (%esi),%edx
80104c62:	39 d0                	cmp    %edx,%eax
80104c64:	73 1a                	jae    80104c80 <argptr+0x60>
80104c66:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104c69:	01 c3                	add    %eax,%ebx
80104c6b:	39 da                	cmp    %ebx,%edx
80104c6d:	72 11                	jb     80104c80 <argptr+0x60>
    return -1;
  *pp = (char*)i;
80104c6f:	8b 55 0c             	mov    0xc(%ebp),%edx
80104c72:	89 02                	mov    %eax,(%edx)
  return 0;
80104c74:	31 c0                	xor    %eax,%eax
}
80104c76:	83 c4 0c             	add    $0xc,%esp
80104c79:	5b                   	pop    %ebx
80104c7a:	5e                   	pop    %esi
80104c7b:	5f                   	pop    %edi
80104c7c:	5d                   	pop    %ebp
80104c7d:	c3                   	ret
80104c7e:	66 90                	xchg   %ax,%ax
    return -1;
80104c80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c85:	eb ef                	jmp    80104c76 <argptr+0x56>
80104c87:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c8e:	00 
80104c8f:	90                   	nop

80104c90 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104c90:	55                   	push   %ebp
80104c91:	89 e5                	mov    %esp,%ebp
80104c93:	56                   	push   %esi
80104c94:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104c95:	e8 46 ef ff ff       	call   80103be0 <myproc>
80104c9a:	8b 55 08             	mov    0x8(%ebp),%edx
80104c9d:	8b 40 18             	mov    0x18(%eax),%eax
80104ca0:	8b 40 44             	mov    0x44(%eax),%eax
80104ca3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104ca6:	e8 35 ef ff ff       	call   80103be0 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104cab:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104cae:	8b 00                	mov    (%eax),%eax
80104cb0:	39 c6                	cmp    %eax,%esi
80104cb2:	73 44                	jae    80104cf8 <argstr+0x68>
80104cb4:	8d 53 08             	lea    0x8(%ebx),%edx
80104cb7:	39 d0                	cmp    %edx,%eax
80104cb9:	72 3d                	jb     80104cf8 <argstr+0x68>
  *ip = *(int*)(addr);
80104cbb:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80104cbe:	e8 1d ef ff ff       	call   80103be0 <myproc>
  if(addr >= curproc->sz)
80104cc3:	3b 18                	cmp    (%eax),%ebx
80104cc5:	73 31                	jae    80104cf8 <argstr+0x68>
  *pp = (char*)addr;
80104cc7:	8b 55 0c             	mov    0xc(%ebp),%edx
80104cca:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104ccc:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104cce:	39 d3                	cmp    %edx,%ebx
80104cd0:	73 26                	jae    80104cf8 <argstr+0x68>
80104cd2:	89 d8                	mov    %ebx,%eax
80104cd4:	eb 11                	jmp    80104ce7 <argstr+0x57>
80104cd6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104cdd:	00 
80104cde:	66 90                	xchg   %ax,%ax
80104ce0:	83 c0 01             	add    $0x1,%eax
80104ce3:	39 d0                	cmp    %edx,%eax
80104ce5:	73 11                	jae    80104cf8 <argstr+0x68>
    if(*s == 0)
80104ce7:	80 38 00             	cmpb   $0x0,(%eax)
80104cea:	75 f4                	jne    80104ce0 <argstr+0x50>
      return s - *pp;
80104cec:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104cee:	5b                   	pop    %ebx
80104cef:	5e                   	pop    %esi
80104cf0:	5d                   	pop    %ebp
80104cf1:	c3                   	ret
80104cf2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104cf8:	5b                   	pop    %ebx
    return -1;
80104cf9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104cfe:	5e                   	pop    %esi
80104cff:	5d                   	pop    %ebp
80104d00:	c3                   	ret
80104d01:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d08:	00 
80104d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104d10 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80104d10:	55                   	push   %ebp
80104d11:	89 e5                	mov    %esp,%ebp
80104d13:	53                   	push   %ebx
80104d14:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104d17:	e8 c4 ee ff ff       	call   80103be0 <myproc>
80104d1c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104d1e:	8b 40 18             	mov    0x18(%eax),%eax
80104d21:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104d24:	8d 50 ff             	lea    -0x1(%eax),%edx
80104d27:	83 fa 14             	cmp    $0x14,%edx
80104d2a:	77 24                	ja     80104d50 <syscall+0x40>
80104d2c:	8b 14 85 20 7d 10 80 	mov    -0x7fef82e0(,%eax,4),%edx
80104d33:	85 d2                	test   %edx,%edx
80104d35:	74 19                	je     80104d50 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104d37:	ff d2                	call   *%edx
80104d39:	89 c2                	mov    %eax,%edx
80104d3b:	8b 43 18             	mov    0x18(%ebx),%eax
80104d3e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104d41:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d44:	c9                   	leave
80104d45:	c3                   	ret
80104d46:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d4d:	00 
80104d4e:	66 90                	xchg   %ax,%ax
    cprintf("%d %s: unknown sys call %d\n",
80104d50:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104d51:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104d54:	50                   	push   %eax
80104d55:	ff 73 10             	push   0x10(%ebx)
80104d58:	68 51 77 10 80       	push   $0x80107751
80104d5d:	e8 de b9 ff ff       	call   80100740 <cprintf>
    curproc->tf->eax = -1;
80104d62:	8b 43 18             	mov    0x18(%ebx),%eax
80104d65:	83 c4 10             	add    $0x10,%esp
80104d68:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104d6f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d72:	c9                   	leave
80104d73:	c3                   	ret
80104d74:	66 90                	xchg   %ax,%ax
80104d76:	66 90                	xchg   %ax,%ax
80104d78:	66 90                	xchg   %ax,%ax
80104d7a:	66 90                	xchg   %ax,%ax
80104d7c:	66 90                	xchg   %ax,%ax
80104d7e:	66 90                	xchg   %ax,%ax

80104d80 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104d80:	55                   	push   %ebp
80104d81:	89 e5                	mov    %esp,%ebp
80104d83:	57                   	push   %edi
80104d84:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104d85:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80104d88:	53                   	push   %ebx
80104d89:	83 ec 34             	sub    $0x34,%esp
80104d8c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104d8f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104d92:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104d95:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104d98:	57                   	push   %edi
80104d99:	50                   	push   %eax
80104d9a:	e8 71 d5 ff ff       	call   80102310 <nameiparent>
80104d9f:	83 c4 10             	add    $0x10,%esp
80104da2:	85 c0                	test   %eax,%eax
80104da4:	74 5e                	je     80104e04 <create+0x84>
    return 0;
  ilock(dp);
80104da6:	83 ec 0c             	sub    $0xc,%esp
80104da9:	89 c3                	mov    %eax,%ebx
80104dab:	50                   	push   %eax
80104dac:	e8 5f cc ff ff       	call   80101a10 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104db1:	83 c4 0c             	add    $0xc,%esp
80104db4:	6a 00                	push   $0x0
80104db6:	57                   	push   %edi
80104db7:	53                   	push   %ebx
80104db8:	e8 a3 d1 ff ff       	call   80101f60 <dirlookup>
80104dbd:	83 c4 10             	add    $0x10,%esp
80104dc0:	89 c6                	mov    %eax,%esi
80104dc2:	85 c0                	test   %eax,%eax
80104dc4:	74 4a                	je     80104e10 <create+0x90>
    iunlockput(dp);
80104dc6:	83 ec 0c             	sub    $0xc,%esp
80104dc9:	53                   	push   %ebx
80104dca:	e8 d1 ce ff ff       	call   80101ca0 <iunlockput>
    ilock(ip);
80104dcf:	89 34 24             	mov    %esi,(%esp)
80104dd2:	e8 39 cc ff ff       	call   80101a10 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104dd7:	83 c4 10             	add    $0x10,%esp
80104dda:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104ddf:	75 17                	jne    80104df8 <create+0x78>
80104de1:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104de6:	75 10                	jne    80104df8 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104de8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104deb:	89 f0                	mov    %esi,%eax
80104ded:	5b                   	pop    %ebx
80104dee:	5e                   	pop    %esi
80104def:	5f                   	pop    %edi
80104df0:	5d                   	pop    %ebp
80104df1:	c3                   	ret
80104df2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80104df8:	83 ec 0c             	sub    $0xc,%esp
80104dfb:	56                   	push   %esi
80104dfc:	e8 9f ce ff ff       	call   80101ca0 <iunlockput>
    return 0;
80104e01:	83 c4 10             	add    $0x10,%esp
}
80104e04:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104e07:	31 f6                	xor    %esi,%esi
}
80104e09:	5b                   	pop    %ebx
80104e0a:	89 f0                	mov    %esi,%eax
80104e0c:	5e                   	pop    %esi
80104e0d:	5f                   	pop    %edi
80104e0e:	5d                   	pop    %ebp
80104e0f:	c3                   	ret
  if((ip = ialloc(dp->dev, type)) == 0)
80104e10:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104e14:	83 ec 08             	sub    $0x8,%esp
80104e17:	50                   	push   %eax
80104e18:	ff 33                	push   (%ebx)
80104e1a:	e8 81 ca ff ff       	call   801018a0 <ialloc>
80104e1f:	83 c4 10             	add    $0x10,%esp
80104e22:	89 c6                	mov    %eax,%esi
80104e24:	85 c0                	test   %eax,%eax
80104e26:	0f 84 bc 00 00 00    	je     80104ee8 <create+0x168>
  ilock(ip);
80104e2c:	83 ec 0c             	sub    $0xc,%esp
80104e2f:	50                   	push   %eax
80104e30:	e8 db cb ff ff       	call   80101a10 <ilock>
  ip->major = major;
80104e35:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104e39:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104e3d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104e41:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104e45:	b8 01 00 00 00       	mov    $0x1,%eax
80104e4a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80104e4e:	89 34 24             	mov    %esi,(%esp)
80104e51:	e8 0a cb ff ff       	call   80101960 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104e56:	83 c4 10             	add    $0x10,%esp
80104e59:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104e5e:	74 30                	je     80104e90 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
80104e60:	83 ec 04             	sub    $0x4,%esp
80104e63:	ff 76 04             	push   0x4(%esi)
80104e66:	57                   	push   %edi
80104e67:	53                   	push   %ebx
80104e68:	e8 c3 d3 ff ff       	call   80102230 <dirlink>
80104e6d:	83 c4 10             	add    $0x10,%esp
80104e70:	85 c0                	test   %eax,%eax
80104e72:	78 67                	js     80104edb <create+0x15b>
  iunlockput(dp);
80104e74:	83 ec 0c             	sub    $0xc,%esp
80104e77:	53                   	push   %ebx
80104e78:	e8 23 ce ff ff       	call   80101ca0 <iunlockput>
  return ip;
80104e7d:	83 c4 10             	add    $0x10,%esp
}
80104e80:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104e83:	89 f0                	mov    %esi,%eax
80104e85:	5b                   	pop    %ebx
80104e86:	5e                   	pop    %esi
80104e87:	5f                   	pop    %edi
80104e88:	5d                   	pop    %ebp
80104e89:	c3                   	ret
80104e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104e90:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104e93:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104e98:	53                   	push   %ebx
80104e99:	e8 c2 ca ff ff       	call   80101960 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104e9e:	83 c4 0c             	add    $0xc,%esp
80104ea1:	ff 76 04             	push   0x4(%esi)
80104ea4:	68 89 77 10 80       	push   $0x80107789
80104ea9:	56                   	push   %esi
80104eaa:	e8 81 d3 ff ff       	call   80102230 <dirlink>
80104eaf:	83 c4 10             	add    $0x10,%esp
80104eb2:	85 c0                	test   %eax,%eax
80104eb4:	78 18                	js     80104ece <create+0x14e>
80104eb6:	83 ec 04             	sub    $0x4,%esp
80104eb9:	ff 73 04             	push   0x4(%ebx)
80104ebc:	68 88 77 10 80       	push   $0x80107788
80104ec1:	56                   	push   %esi
80104ec2:	e8 69 d3 ff ff       	call   80102230 <dirlink>
80104ec7:	83 c4 10             	add    $0x10,%esp
80104eca:	85 c0                	test   %eax,%eax
80104ecc:	79 92                	jns    80104e60 <create+0xe0>
      panic("create dots");
80104ece:	83 ec 0c             	sub    $0xc,%esp
80104ed1:	68 7c 77 10 80       	push   $0x8010777c
80104ed6:	e8 a5 b4 ff ff       	call   80100380 <panic>
    panic("create: dirlink");
80104edb:	83 ec 0c             	sub    $0xc,%esp
80104ede:	68 8b 77 10 80       	push   $0x8010778b
80104ee3:	e8 98 b4 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80104ee8:	83 ec 0c             	sub    $0xc,%esp
80104eeb:	68 6d 77 10 80       	push   $0x8010776d
80104ef0:	e8 8b b4 ff ff       	call   80100380 <panic>
80104ef5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104efc:	00 
80104efd:	8d 76 00             	lea    0x0(%esi),%esi

80104f00 <sys_dup>:
{
80104f00:	55                   	push   %ebp
80104f01:	89 e5                	mov    %esp,%ebp
80104f03:	56                   	push   %esi
80104f04:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104f05:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80104f08:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104f0b:	50                   	push   %eax
80104f0c:	6a 00                	push   $0x0
80104f0e:	e8 bd fc ff ff       	call   80104bd0 <argint>
80104f13:	83 c4 10             	add    $0x10,%esp
80104f16:	85 c0                	test   %eax,%eax
80104f18:	78 36                	js     80104f50 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104f1a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104f1e:	77 30                	ja     80104f50 <sys_dup+0x50>
80104f20:	e8 bb ec ff ff       	call   80103be0 <myproc>
80104f25:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104f28:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104f2c:	85 f6                	test   %esi,%esi
80104f2e:	74 20                	je     80104f50 <sys_dup+0x50>
  struct proc *curproc = myproc();
80104f30:	e8 ab ec ff ff       	call   80103be0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80104f35:	31 db                	xor    %ebx,%ebx
80104f37:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f3e:	00 
80104f3f:	90                   	nop
    if(curproc->ofile[fd] == 0){
80104f40:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104f44:	85 d2                	test   %edx,%edx
80104f46:	74 18                	je     80104f60 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80104f48:	83 c3 01             	add    $0x1,%ebx
80104f4b:	83 fb 10             	cmp    $0x10,%ebx
80104f4e:	75 f0                	jne    80104f40 <sys_dup+0x40>
}
80104f50:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104f53:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104f58:	89 d8                	mov    %ebx,%eax
80104f5a:	5b                   	pop    %ebx
80104f5b:	5e                   	pop    %esi
80104f5c:	5d                   	pop    %ebp
80104f5d:	c3                   	ret
80104f5e:	66 90                	xchg   %ax,%ax
  filedup(f);
80104f60:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80104f63:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104f67:	56                   	push   %esi
80104f68:	e8 c3 c1 ff ff       	call   80101130 <filedup>
  return fd;
80104f6d:	83 c4 10             	add    $0x10,%esp
}
80104f70:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f73:	89 d8                	mov    %ebx,%eax
80104f75:	5b                   	pop    %ebx
80104f76:	5e                   	pop    %esi
80104f77:	5d                   	pop    %ebp
80104f78:	c3                   	ret
80104f79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104f80 <sys_read>:
{
80104f80:	55                   	push   %ebp
80104f81:	89 e5                	mov    %esp,%ebp
80104f83:	56                   	push   %esi
80104f84:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104f85:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104f88:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104f8b:	53                   	push   %ebx
80104f8c:	6a 00                	push   $0x0
80104f8e:	e8 3d fc ff ff       	call   80104bd0 <argint>
80104f93:	83 c4 10             	add    $0x10,%esp
80104f96:	85 c0                	test   %eax,%eax
80104f98:	78 5e                	js     80104ff8 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104f9a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104f9e:	77 58                	ja     80104ff8 <sys_read+0x78>
80104fa0:	e8 3b ec ff ff       	call   80103be0 <myproc>
80104fa5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104fa8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104fac:	85 f6                	test   %esi,%esi
80104fae:	74 48                	je     80104ff8 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104fb0:	83 ec 08             	sub    $0x8,%esp
80104fb3:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104fb6:	50                   	push   %eax
80104fb7:	6a 02                	push   $0x2
80104fb9:	e8 12 fc ff ff       	call   80104bd0 <argint>
80104fbe:	83 c4 10             	add    $0x10,%esp
80104fc1:	85 c0                	test   %eax,%eax
80104fc3:	78 33                	js     80104ff8 <sys_read+0x78>
80104fc5:	83 ec 04             	sub    $0x4,%esp
80104fc8:	ff 75 f0             	push   -0x10(%ebp)
80104fcb:	53                   	push   %ebx
80104fcc:	6a 01                	push   $0x1
80104fce:	e8 4d fc ff ff       	call   80104c20 <argptr>
80104fd3:	83 c4 10             	add    $0x10,%esp
80104fd6:	85 c0                	test   %eax,%eax
80104fd8:	78 1e                	js     80104ff8 <sys_read+0x78>
  return fileread(f, p, n);
80104fda:	83 ec 04             	sub    $0x4,%esp
80104fdd:	ff 75 f0             	push   -0x10(%ebp)
80104fe0:	ff 75 f4             	push   -0xc(%ebp)
80104fe3:	56                   	push   %esi
80104fe4:	e8 c7 c2 ff ff       	call   801012b0 <fileread>
80104fe9:	83 c4 10             	add    $0x10,%esp
}
80104fec:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104fef:	5b                   	pop    %ebx
80104ff0:	5e                   	pop    %esi
80104ff1:	5d                   	pop    %ebp
80104ff2:	c3                   	ret
80104ff3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80104ff8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ffd:	eb ed                	jmp    80104fec <sys_read+0x6c>
80104fff:	90                   	nop

80105000 <sys_write>:
{
80105000:	55                   	push   %ebp
80105001:	89 e5                	mov    %esp,%ebp
80105003:	56                   	push   %esi
80105004:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105005:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80105008:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010500b:	53                   	push   %ebx
8010500c:	6a 00                	push   $0x0
8010500e:	e8 bd fb ff ff       	call   80104bd0 <argint>
80105013:	83 c4 10             	add    $0x10,%esp
80105016:	85 c0                	test   %eax,%eax
80105018:	78 5e                	js     80105078 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010501a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010501e:	77 58                	ja     80105078 <sys_write+0x78>
80105020:	e8 bb eb ff ff       	call   80103be0 <myproc>
80105025:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105028:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010502c:	85 f6                	test   %esi,%esi
8010502e:	74 48                	je     80105078 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105030:	83 ec 08             	sub    $0x8,%esp
80105033:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105036:	50                   	push   %eax
80105037:	6a 02                	push   $0x2
80105039:	e8 92 fb ff ff       	call   80104bd0 <argint>
8010503e:	83 c4 10             	add    $0x10,%esp
80105041:	85 c0                	test   %eax,%eax
80105043:	78 33                	js     80105078 <sys_write+0x78>
80105045:	83 ec 04             	sub    $0x4,%esp
80105048:	ff 75 f0             	push   -0x10(%ebp)
8010504b:	53                   	push   %ebx
8010504c:	6a 01                	push   $0x1
8010504e:	e8 cd fb ff ff       	call   80104c20 <argptr>
80105053:	83 c4 10             	add    $0x10,%esp
80105056:	85 c0                	test   %eax,%eax
80105058:	78 1e                	js     80105078 <sys_write+0x78>
  return filewrite(f, p, n);
8010505a:	83 ec 04             	sub    $0x4,%esp
8010505d:	ff 75 f0             	push   -0x10(%ebp)
80105060:	ff 75 f4             	push   -0xc(%ebp)
80105063:	56                   	push   %esi
80105064:	e8 d7 c2 ff ff       	call   80101340 <filewrite>
80105069:	83 c4 10             	add    $0x10,%esp
}
8010506c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010506f:	5b                   	pop    %ebx
80105070:	5e                   	pop    %esi
80105071:	5d                   	pop    %ebp
80105072:	c3                   	ret
80105073:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80105078:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010507d:	eb ed                	jmp    8010506c <sys_write+0x6c>
8010507f:	90                   	nop

80105080 <sys_close>:
{
80105080:	55                   	push   %ebp
80105081:	89 e5                	mov    %esp,%ebp
80105083:	56                   	push   %esi
80105084:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80105085:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105088:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
8010508b:	50                   	push   %eax
8010508c:	6a 00                	push   $0x0
8010508e:	e8 3d fb ff ff       	call   80104bd0 <argint>
80105093:	83 c4 10             	add    $0x10,%esp
80105096:	85 c0                	test   %eax,%eax
80105098:	78 3e                	js     801050d8 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010509a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010509e:	77 38                	ja     801050d8 <sys_close+0x58>
801050a0:	e8 3b eb ff ff       	call   80103be0 <myproc>
801050a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801050a8:	8d 5a 08             	lea    0x8(%edx),%ebx
801050ab:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
801050af:	85 f6                	test   %esi,%esi
801050b1:	74 25                	je     801050d8 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
801050b3:	e8 28 eb ff ff       	call   80103be0 <myproc>
  fileclose(f);
801050b8:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801050bb:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
801050c2:	00 
  fileclose(f);
801050c3:	56                   	push   %esi
801050c4:	e8 b7 c0 ff ff       	call   80101180 <fileclose>
  return 0;
801050c9:	83 c4 10             	add    $0x10,%esp
801050cc:	31 c0                	xor    %eax,%eax
}
801050ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050d1:	5b                   	pop    %ebx
801050d2:	5e                   	pop    %esi
801050d3:	5d                   	pop    %ebp
801050d4:	c3                   	ret
801050d5:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
801050d8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050dd:	eb ef                	jmp    801050ce <sys_close+0x4e>
801050df:	90                   	nop

801050e0 <sys_fstat>:
{
801050e0:	55                   	push   %ebp
801050e1:	89 e5                	mov    %esp,%ebp
801050e3:	56                   	push   %esi
801050e4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
801050e5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
801050e8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
801050eb:	53                   	push   %ebx
801050ec:	6a 00                	push   $0x0
801050ee:	e8 dd fa ff ff       	call   80104bd0 <argint>
801050f3:	83 c4 10             	add    $0x10,%esp
801050f6:	85 c0                	test   %eax,%eax
801050f8:	78 46                	js     80105140 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
801050fa:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801050fe:	77 40                	ja     80105140 <sys_fstat+0x60>
80105100:	e8 db ea ff ff       	call   80103be0 <myproc>
80105105:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105108:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010510c:	85 f6                	test   %esi,%esi
8010510e:	74 30                	je     80105140 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80105110:	83 ec 04             	sub    $0x4,%esp
80105113:	6a 14                	push   $0x14
80105115:	53                   	push   %ebx
80105116:	6a 01                	push   $0x1
80105118:	e8 03 fb ff ff       	call   80104c20 <argptr>
8010511d:	83 c4 10             	add    $0x10,%esp
80105120:	85 c0                	test   %eax,%eax
80105122:	78 1c                	js     80105140 <sys_fstat+0x60>
  return filestat(f, st);
80105124:	83 ec 08             	sub    $0x8,%esp
80105127:	ff 75 f4             	push   -0xc(%ebp)
8010512a:	56                   	push   %esi
8010512b:	e8 30 c1 ff ff       	call   80101260 <filestat>
80105130:	83 c4 10             	add    $0x10,%esp
}
80105133:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105136:	5b                   	pop    %ebx
80105137:	5e                   	pop    %esi
80105138:	5d                   	pop    %ebp
80105139:	c3                   	ret
8010513a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80105140:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105145:	eb ec                	jmp    80105133 <sys_fstat+0x53>
80105147:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010514e:	00 
8010514f:	90                   	nop

80105150 <sys_link>:
{
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	57                   	push   %edi
80105154:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105155:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105158:	53                   	push   %ebx
80105159:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010515c:	50                   	push   %eax
8010515d:	6a 00                	push   $0x0
8010515f:	e8 2c fb ff ff       	call   80104c90 <argstr>
80105164:	83 c4 10             	add    $0x10,%esp
80105167:	85 c0                	test   %eax,%eax
80105169:	0f 88 fb 00 00 00    	js     8010526a <sys_link+0x11a>
8010516f:	83 ec 08             	sub    $0x8,%esp
80105172:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105175:	50                   	push   %eax
80105176:	6a 01                	push   $0x1
80105178:	e8 13 fb ff ff       	call   80104c90 <argstr>
8010517d:	83 c4 10             	add    $0x10,%esp
80105180:	85 c0                	test   %eax,%eax
80105182:	0f 88 e2 00 00 00    	js     8010526a <sys_link+0x11a>
  begin_op();
80105188:	e8 33 de ff ff       	call   80102fc0 <begin_op>
  if((ip = namei(old)) == 0){
8010518d:	83 ec 0c             	sub    $0xc,%esp
80105190:	ff 75 d4             	push   -0x2c(%ebp)
80105193:	e8 58 d1 ff ff       	call   801022f0 <namei>
80105198:	83 c4 10             	add    $0x10,%esp
8010519b:	89 c3                	mov    %eax,%ebx
8010519d:	85 c0                	test   %eax,%eax
8010519f:	0f 84 df 00 00 00    	je     80105284 <sys_link+0x134>
  ilock(ip);
801051a5:	83 ec 0c             	sub    $0xc,%esp
801051a8:	50                   	push   %eax
801051a9:	e8 62 c8 ff ff       	call   80101a10 <ilock>
  if(ip->type == T_DIR){
801051ae:	83 c4 10             	add    $0x10,%esp
801051b1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801051b6:	0f 84 b5 00 00 00    	je     80105271 <sys_link+0x121>
  iupdate(ip);
801051bc:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
801051bf:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
801051c4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801051c7:	53                   	push   %ebx
801051c8:	e8 93 c7 ff ff       	call   80101960 <iupdate>
  iunlock(ip);
801051cd:	89 1c 24             	mov    %ebx,(%esp)
801051d0:	e8 1b c9 ff ff       	call   80101af0 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801051d5:	58                   	pop    %eax
801051d6:	5a                   	pop    %edx
801051d7:	57                   	push   %edi
801051d8:	ff 75 d0             	push   -0x30(%ebp)
801051db:	e8 30 d1 ff ff       	call   80102310 <nameiparent>
801051e0:	83 c4 10             	add    $0x10,%esp
801051e3:	89 c6                	mov    %eax,%esi
801051e5:	85 c0                	test   %eax,%eax
801051e7:	74 5b                	je     80105244 <sys_link+0xf4>
  ilock(dp);
801051e9:	83 ec 0c             	sub    $0xc,%esp
801051ec:	50                   	push   %eax
801051ed:	e8 1e c8 ff ff       	call   80101a10 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801051f2:	8b 03                	mov    (%ebx),%eax
801051f4:	83 c4 10             	add    $0x10,%esp
801051f7:	39 06                	cmp    %eax,(%esi)
801051f9:	75 3d                	jne    80105238 <sys_link+0xe8>
801051fb:	83 ec 04             	sub    $0x4,%esp
801051fe:	ff 73 04             	push   0x4(%ebx)
80105201:	57                   	push   %edi
80105202:	56                   	push   %esi
80105203:	e8 28 d0 ff ff       	call   80102230 <dirlink>
80105208:	83 c4 10             	add    $0x10,%esp
8010520b:	85 c0                	test   %eax,%eax
8010520d:	78 29                	js     80105238 <sys_link+0xe8>
  iunlockput(dp);
8010520f:	83 ec 0c             	sub    $0xc,%esp
80105212:	56                   	push   %esi
80105213:	e8 88 ca ff ff       	call   80101ca0 <iunlockput>
  iput(ip);
80105218:	89 1c 24             	mov    %ebx,(%esp)
8010521b:	e8 20 c9 ff ff       	call   80101b40 <iput>
  end_op();
80105220:	e8 0b de ff ff       	call   80103030 <end_op>
  return 0;
80105225:	83 c4 10             	add    $0x10,%esp
80105228:	31 c0                	xor    %eax,%eax
}
8010522a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010522d:	5b                   	pop    %ebx
8010522e:	5e                   	pop    %esi
8010522f:	5f                   	pop    %edi
80105230:	5d                   	pop    %ebp
80105231:	c3                   	ret
80105232:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105238:	83 ec 0c             	sub    $0xc,%esp
8010523b:	56                   	push   %esi
8010523c:	e8 5f ca ff ff       	call   80101ca0 <iunlockput>
    goto bad;
80105241:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105244:	83 ec 0c             	sub    $0xc,%esp
80105247:	53                   	push   %ebx
80105248:	e8 c3 c7 ff ff       	call   80101a10 <ilock>
  ip->nlink--;
8010524d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105252:	89 1c 24             	mov    %ebx,(%esp)
80105255:	e8 06 c7 ff ff       	call   80101960 <iupdate>
  iunlockput(ip);
8010525a:	89 1c 24             	mov    %ebx,(%esp)
8010525d:	e8 3e ca ff ff       	call   80101ca0 <iunlockput>
  end_op();
80105262:	e8 c9 dd ff ff       	call   80103030 <end_op>
  return -1;
80105267:	83 c4 10             	add    $0x10,%esp
    return -1;
8010526a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010526f:	eb b9                	jmp    8010522a <sys_link+0xda>
    iunlockput(ip);
80105271:	83 ec 0c             	sub    $0xc,%esp
80105274:	53                   	push   %ebx
80105275:	e8 26 ca ff ff       	call   80101ca0 <iunlockput>
    end_op();
8010527a:	e8 b1 dd ff ff       	call   80103030 <end_op>
    return -1;
8010527f:	83 c4 10             	add    $0x10,%esp
80105282:	eb e6                	jmp    8010526a <sys_link+0x11a>
    end_op();
80105284:	e8 a7 dd ff ff       	call   80103030 <end_op>
    return -1;
80105289:	eb df                	jmp    8010526a <sys_link+0x11a>
8010528b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105290 <sys_unlink>:
{
80105290:	55                   	push   %ebp
80105291:	89 e5                	mov    %esp,%ebp
80105293:	57                   	push   %edi
80105294:	56                   	push   %esi
  if(argstr(0, &path) < 0)
80105295:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105298:	53                   	push   %ebx
80105299:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
8010529c:	50                   	push   %eax
8010529d:	6a 00                	push   $0x0
8010529f:	e8 ec f9 ff ff       	call   80104c90 <argstr>
801052a4:	83 c4 10             	add    $0x10,%esp
801052a7:	85 c0                	test   %eax,%eax
801052a9:	0f 88 54 01 00 00    	js     80105403 <sys_unlink+0x173>
  begin_op();
801052af:	e8 0c dd ff ff       	call   80102fc0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801052b4:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801052b7:	83 ec 08             	sub    $0x8,%esp
801052ba:	53                   	push   %ebx
801052bb:	ff 75 c0             	push   -0x40(%ebp)
801052be:	e8 4d d0 ff ff       	call   80102310 <nameiparent>
801052c3:	83 c4 10             	add    $0x10,%esp
801052c6:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801052c9:	85 c0                	test   %eax,%eax
801052cb:	0f 84 58 01 00 00    	je     80105429 <sys_unlink+0x199>
  ilock(dp);
801052d1:	8b 7d b4             	mov    -0x4c(%ebp),%edi
801052d4:	83 ec 0c             	sub    $0xc,%esp
801052d7:	57                   	push   %edi
801052d8:	e8 33 c7 ff ff       	call   80101a10 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801052dd:	58                   	pop    %eax
801052de:	5a                   	pop    %edx
801052df:	68 89 77 10 80       	push   $0x80107789
801052e4:	53                   	push   %ebx
801052e5:	e8 56 cc ff ff       	call   80101f40 <namecmp>
801052ea:	83 c4 10             	add    $0x10,%esp
801052ed:	85 c0                	test   %eax,%eax
801052ef:	0f 84 fb 00 00 00    	je     801053f0 <sys_unlink+0x160>
801052f5:	83 ec 08             	sub    $0x8,%esp
801052f8:	68 88 77 10 80       	push   $0x80107788
801052fd:	53                   	push   %ebx
801052fe:	e8 3d cc ff ff       	call   80101f40 <namecmp>
80105303:	83 c4 10             	add    $0x10,%esp
80105306:	85 c0                	test   %eax,%eax
80105308:	0f 84 e2 00 00 00    	je     801053f0 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010530e:	83 ec 04             	sub    $0x4,%esp
80105311:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105314:	50                   	push   %eax
80105315:	53                   	push   %ebx
80105316:	57                   	push   %edi
80105317:	e8 44 cc ff ff       	call   80101f60 <dirlookup>
8010531c:	83 c4 10             	add    $0x10,%esp
8010531f:	89 c3                	mov    %eax,%ebx
80105321:	85 c0                	test   %eax,%eax
80105323:	0f 84 c7 00 00 00    	je     801053f0 <sys_unlink+0x160>
  ilock(ip);
80105329:	83 ec 0c             	sub    $0xc,%esp
8010532c:	50                   	push   %eax
8010532d:	e8 de c6 ff ff       	call   80101a10 <ilock>
  if(ip->nlink < 1)
80105332:	83 c4 10             	add    $0x10,%esp
80105335:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010533a:	0f 8e 0a 01 00 00    	jle    8010544a <sys_unlink+0x1ba>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105340:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105345:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105348:	74 66                	je     801053b0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010534a:	83 ec 04             	sub    $0x4,%esp
8010534d:	6a 10                	push   $0x10
8010534f:	6a 00                	push   $0x0
80105351:	57                   	push   %edi
80105352:	e8 c9 f5 ff ff       	call   80104920 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105357:	6a 10                	push   $0x10
80105359:	ff 75 c4             	push   -0x3c(%ebp)
8010535c:	57                   	push   %edi
8010535d:	ff 75 b4             	push   -0x4c(%ebp)
80105360:	e8 bb ca ff ff       	call   80101e20 <writei>
80105365:	83 c4 20             	add    $0x20,%esp
80105368:	83 f8 10             	cmp    $0x10,%eax
8010536b:	0f 85 cc 00 00 00    	jne    8010543d <sys_unlink+0x1ad>
  if(ip->type == T_DIR){
80105371:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105376:	0f 84 94 00 00 00    	je     80105410 <sys_unlink+0x180>
  iunlockput(dp);
8010537c:	83 ec 0c             	sub    $0xc,%esp
8010537f:	ff 75 b4             	push   -0x4c(%ebp)
80105382:	e8 19 c9 ff ff       	call   80101ca0 <iunlockput>
  ip->nlink--;
80105387:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
8010538c:	89 1c 24             	mov    %ebx,(%esp)
8010538f:	e8 cc c5 ff ff       	call   80101960 <iupdate>
  iunlockput(ip);
80105394:	89 1c 24             	mov    %ebx,(%esp)
80105397:	e8 04 c9 ff ff       	call   80101ca0 <iunlockput>
  end_op();
8010539c:	e8 8f dc ff ff       	call   80103030 <end_op>
  return 0;
801053a1:	83 c4 10             	add    $0x10,%esp
801053a4:	31 c0                	xor    %eax,%eax
}
801053a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053a9:	5b                   	pop    %ebx
801053aa:	5e                   	pop    %esi
801053ab:	5f                   	pop    %edi
801053ac:	5d                   	pop    %ebp
801053ad:	c3                   	ret
801053ae:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801053b0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801053b4:	76 94                	jbe    8010534a <sys_unlink+0xba>
801053b6:	be 20 00 00 00       	mov    $0x20,%esi
801053bb:	eb 0b                	jmp    801053c8 <sys_unlink+0x138>
801053bd:	8d 76 00             	lea    0x0(%esi),%esi
801053c0:	83 c6 10             	add    $0x10,%esi
801053c3:	3b 73 58             	cmp    0x58(%ebx),%esi
801053c6:	73 82                	jae    8010534a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801053c8:	6a 10                	push   $0x10
801053ca:	56                   	push   %esi
801053cb:	57                   	push   %edi
801053cc:	53                   	push   %ebx
801053cd:	e8 4e c9 ff ff       	call   80101d20 <readi>
801053d2:	83 c4 10             	add    $0x10,%esp
801053d5:	83 f8 10             	cmp    $0x10,%eax
801053d8:	75 56                	jne    80105430 <sys_unlink+0x1a0>
    if(de.inum != 0)
801053da:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801053df:	74 df                	je     801053c0 <sys_unlink+0x130>
    iunlockput(ip);
801053e1:	83 ec 0c             	sub    $0xc,%esp
801053e4:	53                   	push   %ebx
801053e5:	e8 b6 c8 ff ff       	call   80101ca0 <iunlockput>
    goto bad;
801053ea:	83 c4 10             	add    $0x10,%esp
801053ed:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
801053f0:	83 ec 0c             	sub    $0xc,%esp
801053f3:	ff 75 b4             	push   -0x4c(%ebp)
801053f6:	e8 a5 c8 ff ff       	call   80101ca0 <iunlockput>
  end_op();
801053fb:	e8 30 dc ff ff       	call   80103030 <end_op>
  return -1;
80105400:	83 c4 10             	add    $0x10,%esp
    return -1;
80105403:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105408:	eb 9c                	jmp    801053a6 <sys_unlink+0x116>
8010540a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105410:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105413:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105416:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
8010541b:	50                   	push   %eax
8010541c:	e8 3f c5 ff ff       	call   80101960 <iupdate>
80105421:	83 c4 10             	add    $0x10,%esp
80105424:	e9 53 ff ff ff       	jmp    8010537c <sys_unlink+0xec>
    end_op();
80105429:	e8 02 dc ff ff       	call   80103030 <end_op>
    return -1;
8010542e:	eb d3                	jmp    80105403 <sys_unlink+0x173>
      panic("isdirempty: readi");
80105430:	83 ec 0c             	sub    $0xc,%esp
80105433:	68 ad 77 10 80       	push   $0x801077ad
80105438:	e8 43 af ff ff       	call   80100380 <panic>
    panic("unlink: writei");
8010543d:	83 ec 0c             	sub    $0xc,%esp
80105440:	68 bf 77 10 80       	push   $0x801077bf
80105445:	e8 36 af ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
8010544a:	83 ec 0c             	sub    $0xc,%esp
8010544d:	68 9b 77 10 80       	push   $0x8010779b
80105452:	e8 29 af ff ff       	call   80100380 <panic>
80105457:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010545e:	00 
8010545f:	90                   	nop

80105460 <sys_open>:

int
sys_open(void)
{
80105460:	55                   	push   %ebp
80105461:	89 e5                	mov    %esp,%ebp
80105463:	57                   	push   %edi
80105464:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105465:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105468:	53                   	push   %ebx
80105469:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010546c:	50                   	push   %eax
8010546d:	6a 00                	push   $0x0
8010546f:	e8 1c f8 ff ff       	call   80104c90 <argstr>
80105474:	83 c4 10             	add    $0x10,%esp
80105477:	85 c0                	test   %eax,%eax
80105479:	0f 88 8e 00 00 00    	js     8010550d <sys_open+0xad>
8010547f:	83 ec 08             	sub    $0x8,%esp
80105482:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105485:	50                   	push   %eax
80105486:	6a 01                	push   $0x1
80105488:	e8 43 f7 ff ff       	call   80104bd0 <argint>
8010548d:	83 c4 10             	add    $0x10,%esp
80105490:	85 c0                	test   %eax,%eax
80105492:	78 79                	js     8010550d <sys_open+0xad>
    return -1;

  begin_op();
80105494:	e8 27 db ff ff       	call   80102fc0 <begin_op>

  if(omode & O_CREATE){
80105499:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
8010549d:	75 79                	jne    80105518 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
8010549f:	83 ec 0c             	sub    $0xc,%esp
801054a2:	ff 75 e0             	push   -0x20(%ebp)
801054a5:	e8 46 ce ff ff       	call   801022f0 <namei>
801054aa:	83 c4 10             	add    $0x10,%esp
801054ad:	89 c6                	mov    %eax,%esi
801054af:	85 c0                	test   %eax,%eax
801054b1:	0f 84 7e 00 00 00    	je     80105535 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
801054b7:	83 ec 0c             	sub    $0xc,%esp
801054ba:	50                   	push   %eax
801054bb:	e8 50 c5 ff ff       	call   80101a10 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801054c0:	83 c4 10             	add    $0x10,%esp
801054c3:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801054c8:	0f 84 ba 00 00 00    	je     80105588 <sys_open+0x128>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801054ce:	e8 ed bb ff ff       	call   801010c0 <filealloc>
801054d3:	89 c7                	mov    %eax,%edi
801054d5:	85 c0                	test   %eax,%eax
801054d7:	74 23                	je     801054fc <sys_open+0x9c>
  struct proc *curproc = myproc();
801054d9:	e8 02 e7 ff ff       	call   80103be0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801054de:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
801054e0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
801054e4:	85 d2                	test   %edx,%edx
801054e6:	74 58                	je     80105540 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
801054e8:	83 c3 01             	add    $0x1,%ebx
801054eb:	83 fb 10             	cmp    $0x10,%ebx
801054ee:	75 f0                	jne    801054e0 <sys_open+0x80>
    if(f)
      fileclose(f);
801054f0:	83 ec 0c             	sub    $0xc,%esp
801054f3:	57                   	push   %edi
801054f4:	e8 87 bc ff ff       	call   80101180 <fileclose>
801054f9:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
801054fc:	83 ec 0c             	sub    $0xc,%esp
801054ff:	56                   	push   %esi
80105500:	e8 9b c7 ff ff       	call   80101ca0 <iunlockput>
    end_op();
80105505:	e8 26 db ff ff       	call   80103030 <end_op>
    return -1;
8010550a:	83 c4 10             	add    $0x10,%esp
    return -1;
8010550d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105512:	eb 65                	jmp    80105579 <sys_open+0x119>
80105514:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105518:	83 ec 0c             	sub    $0xc,%esp
8010551b:	31 c9                	xor    %ecx,%ecx
8010551d:	ba 02 00 00 00       	mov    $0x2,%edx
80105522:	6a 00                	push   $0x0
80105524:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105527:	e8 54 f8 ff ff       	call   80104d80 <create>
    if(ip == 0){
8010552c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
8010552f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105531:	85 c0                	test   %eax,%eax
80105533:	75 99                	jne    801054ce <sys_open+0x6e>
      end_op();
80105535:	e8 f6 da ff ff       	call   80103030 <end_op>
      return -1;
8010553a:	eb d1                	jmp    8010550d <sys_open+0xad>
8010553c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105540:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105543:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105547:	56                   	push   %esi
80105548:	e8 a3 c5 ff ff       	call   80101af0 <iunlock>
  end_op();
8010554d:	e8 de da ff ff       	call   80103030 <end_op>

  f->type = FD_INODE;
80105552:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
80105558:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010555b:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
8010555e:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
80105561:	89 d0                	mov    %edx,%eax
  f->off = 0;
80105563:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010556a:	f7 d0                	not    %eax
8010556c:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010556f:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105572:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105575:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105579:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010557c:	89 d8                	mov    %ebx,%eax
8010557e:	5b                   	pop    %ebx
8010557f:	5e                   	pop    %esi
80105580:	5f                   	pop    %edi
80105581:	5d                   	pop    %ebp
80105582:	c3                   	ret
80105583:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105588:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
8010558b:	85 c9                	test   %ecx,%ecx
8010558d:	0f 84 3b ff ff ff    	je     801054ce <sys_open+0x6e>
80105593:	e9 64 ff ff ff       	jmp    801054fc <sys_open+0x9c>
80105598:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010559f:	00 

801055a0 <sys_mkdir>:

int
sys_mkdir(void)
{
801055a0:	55                   	push   %ebp
801055a1:	89 e5                	mov    %esp,%ebp
801055a3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801055a6:	e8 15 da ff ff       	call   80102fc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801055ab:	83 ec 08             	sub    $0x8,%esp
801055ae:	8d 45 f4             	lea    -0xc(%ebp),%eax
801055b1:	50                   	push   %eax
801055b2:	6a 00                	push   $0x0
801055b4:	e8 d7 f6 ff ff       	call   80104c90 <argstr>
801055b9:	83 c4 10             	add    $0x10,%esp
801055bc:	85 c0                	test   %eax,%eax
801055be:	78 30                	js     801055f0 <sys_mkdir+0x50>
801055c0:	83 ec 0c             	sub    $0xc,%esp
801055c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055c6:	31 c9                	xor    %ecx,%ecx
801055c8:	ba 01 00 00 00       	mov    $0x1,%edx
801055cd:	6a 00                	push   $0x0
801055cf:	e8 ac f7 ff ff       	call   80104d80 <create>
801055d4:	83 c4 10             	add    $0x10,%esp
801055d7:	85 c0                	test   %eax,%eax
801055d9:	74 15                	je     801055f0 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
801055db:	83 ec 0c             	sub    $0xc,%esp
801055de:	50                   	push   %eax
801055df:	e8 bc c6 ff ff       	call   80101ca0 <iunlockput>
  end_op();
801055e4:	e8 47 da ff ff       	call   80103030 <end_op>
  return 0;
801055e9:	83 c4 10             	add    $0x10,%esp
801055ec:	31 c0                	xor    %eax,%eax
}
801055ee:	c9                   	leave
801055ef:	c3                   	ret
    end_op();
801055f0:	e8 3b da ff ff       	call   80103030 <end_op>
    return -1;
801055f5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055fa:	c9                   	leave
801055fb:	c3                   	ret
801055fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105600 <sys_mknod>:

int
sys_mknod(void)
{
80105600:	55                   	push   %ebp
80105601:	89 e5                	mov    %esp,%ebp
80105603:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105606:	e8 b5 d9 ff ff       	call   80102fc0 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010560b:	83 ec 08             	sub    $0x8,%esp
8010560e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105611:	50                   	push   %eax
80105612:	6a 00                	push   $0x0
80105614:	e8 77 f6 ff ff       	call   80104c90 <argstr>
80105619:	83 c4 10             	add    $0x10,%esp
8010561c:	85 c0                	test   %eax,%eax
8010561e:	78 60                	js     80105680 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105620:	83 ec 08             	sub    $0x8,%esp
80105623:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105626:	50                   	push   %eax
80105627:	6a 01                	push   $0x1
80105629:	e8 a2 f5 ff ff       	call   80104bd0 <argint>
  if((argstr(0, &path)) < 0 ||
8010562e:	83 c4 10             	add    $0x10,%esp
80105631:	85 c0                	test   %eax,%eax
80105633:	78 4b                	js     80105680 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105635:	83 ec 08             	sub    $0x8,%esp
80105638:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010563b:	50                   	push   %eax
8010563c:	6a 02                	push   $0x2
8010563e:	e8 8d f5 ff ff       	call   80104bd0 <argint>
     argint(1, &major) < 0 ||
80105643:	83 c4 10             	add    $0x10,%esp
80105646:	85 c0                	test   %eax,%eax
80105648:	78 36                	js     80105680 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010564a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010564e:	83 ec 0c             	sub    $0xc,%esp
80105651:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105655:	ba 03 00 00 00       	mov    $0x3,%edx
8010565a:	50                   	push   %eax
8010565b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010565e:	e8 1d f7 ff ff       	call   80104d80 <create>
     argint(2, &minor) < 0 ||
80105663:	83 c4 10             	add    $0x10,%esp
80105666:	85 c0                	test   %eax,%eax
80105668:	74 16                	je     80105680 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010566a:	83 ec 0c             	sub    $0xc,%esp
8010566d:	50                   	push   %eax
8010566e:	e8 2d c6 ff ff       	call   80101ca0 <iunlockput>
  end_op();
80105673:	e8 b8 d9 ff ff       	call   80103030 <end_op>
  return 0;
80105678:	83 c4 10             	add    $0x10,%esp
8010567b:	31 c0                	xor    %eax,%eax
}
8010567d:	c9                   	leave
8010567e:	c3                   	ret
8010567f:	90                   	nop
    end_op();
80105680:	e8 ab d9 ff ff       	call   80103030 <end_op>
    return -1;
80105685:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010568a:	c9                   	leave
8010568b:	c3                   	ret
8010568c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105690 <sys_chdir>:

int
sys_chdir(void)
{
80105690:	55                   	push   %ebp
80105691:	89 e5                	mov    %esp,%ebp
80105693:	56                   	push   %esi
80105694:	53                   	push   %ebx
80105695:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
80105698:	e8 43 e5 ff ff       	call   80103be0 <myproc>
8010569d:	89 c6                	mov    %eax,%esi
  
  begin_op();
8010569f:	e8 1c d9 ff ff       	call   80102fc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801056a4:	83 ec 08             	sub    $0x8,%esp
801056a7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056aa:	50                   	push   %eax
801056ab:	6a 00                	push   $0x0
801056ad:	e8 de f5 ff ff       	call   80104c90 <argstr>
801056b2:	83 c4 10             	add    $0x10,%esp
801056b5:	85 c0                	test   %eax,%eax
801056b7:	78 77                	js     80105730 <sys_chdir+0xa0>
801056b9:	83 ec 0c             	sub    $0xc,%esp
801056bc:	ff 75 f4             	push   -0xc(%ebp)
801056bf:	e8 2c cc ff ff       	call   801022f0 <namei>
801056c4:	83 c4 10             	add    $0x10,%esp
801056c7:	89 c3                	mov    %eax,%ebx
801056c9:	85 c0                	test   %eax,%eax
801056cb:	74 63                	je     80105730 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801056cd:	83 ec 0c             	sub    $0xc,%esp
801056d0:	50                   	push   %eax
801056d1:	e8 3a c3 ff ff       	call   80101a10 <ilock>
  if(ip->type != T_DIR){
801056d6:	83 c4 10             	add    $0x10,%esp
801056d9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801056de:	75 30                	jne    80105710 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
801056e0:	83 ec 0c             	sub    $0xc,%esp
801056e3:	53                   	push   %ebx
801056e4:	e8 07 c4 ff ff       	call   80101af0 <iunlock>
  iput(curproc->cwd);
801056e9:	58                   	pop    %eax
801056ea:	ff 76 68             	push   0x68(%esi)
801056ed:	e8 4e c4 ff ff       	call   80101b40 <iput>
  end_op();
801056f2:	e8 39 d9 ff ff       	call   80103030 <end_op>
  curproc->cwd = ip;
801056f7:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
801056fa:	83 c4 10             	add    $0x10,%esp
801056fd:	31 c0                	xor    %eax,%eax
}
801056ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105702:	5b                   	pop    %ebx
80105703:	5e                   	pop    %esi
80105704:	5d                   	pop    %ebp
80105705:	c3                   	ret
80105706:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010570d:	00 
8010570e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105710:	83 ec 0c             	sub    $0xc,%esp
80105713:	53                   	push   %ebx
80105714:	e8 87 c5 ff ff       	call   80101ca0 <iunlockput>
    end_op();
80105719:	e8 12 d9 ff ff       	call   80103030 <end_op>
    return -1;
8010571e:	83 c4 10             	add    $0x10,%esp
    return -1;
80105721:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105726:	eb d7                	jmp    801056ff <sys_chdir+0x6f>
80105728:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010572f:	00 
    end_op();
80105730:	e8 fb d8 ff ff       	call   80103030 <end_op>
    return -1;
80105735:	eb ea                	jmp    80105721 <sys_chdir+0x91>
80105737:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010573e:	00 
8010573f:	90                   	nop

80105740 <sys_exec>:

int
sys_exec(void)
{
80105740:	55                   	push   %ebp
80105741:	89 e5                	mov    %esp,%ebp
80105743:	57                   	push   %edi
80105744:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105745:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010574b:	53                   	push   %ebx
8010574c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105752:	50                   	push   %eax
80105753:	6a 00                	push   $0x0
80105755:	e8 36 f5 ff ff       	call   80104c90 <argstr>
8010575a:	83 c4 10             	add    $0x10,%esp
8010575d:	85 c0                	test   %eax,%eax
8010575f:	0f 88 87 00 00 00    	js     801057ec <sys_exec+0xac>
80105765:	83 ec 08             	sub    $0x8,%esp
80105768:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010576e:	50                   	push   %eax
8010576f:	6a 01                	push   $0x1
80105771:	e8 5a f4 ff ff       	call   80104bd0 <argint>
80105776:	83 c4 10             	add    $0x10,%esp
80105779:	85 c0                	test   %eax,%eax
8010577b:	78 6f                	js     801057ec <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
8010577d:	83 ec 04             	sub    $0x4,%esp
80105780:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
80105786:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
80105788:	68 80 00 00 00       	push   $0x80
8010578d:	6a 00                	push   $0x0
8010578f:	56                   	push   %esi
80105790:	e8 8b f1 ff ff       	call   80104920 <memset>
80105795:	83 c4 10             	add    $0x10,%esp
80105798:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010579f:	00 
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801057a0:	83 ec 08             	sub    $0x8,%esp
801057a3:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
801057a9:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
801057b0:	50                   	push   %eax
801057b1:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
801057b7:	01 f8                	add    %edi,%eax
801057b9:	50                   	push   %eax
801057ba:	e8 81 f3 ff ff       	call   80104b40 <fetchint>
801057bf:	83 c4 10             	add    $0x10,%esp
801057c2:	85 c0                	test   %eax,%eax
801057c4:	78 26                	js     801057ec <sys_exec+0xac>
      return -1;
    if(uarg == 0){
801057c6:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801057cc:	85 c0                	test   %eax,%eax
801057ce:	74 30                	je     80105800 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801057d0:	83 ec 08             	sub    $0x8,%esp
801057d3:	8d 14 3e             	lea    (%esi,%edi,1),%edx
801057d6:	52                   	push   %edx
801057d7:	50                   	push   %eax
801057d8:	e8 a3 f3 ff ff       	call   80104b80 <fetchstr>
801057dd:	83 c4 10             	add    $0x10,%esp
801057e0:	85 c0                	test   %eax,%eax
801057e2:	78 08                	js     801057ec <sys_exec+0xac>
  for(i=0;; i++){
801057e4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801057e7:	83 fb 20             	cmp    $0x20,%ebx
801057ea:	75 b4                	jne    801057a0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
801057ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801057ef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801057f4:	5b                   	pop    %ebx
801057f5:	5e                   	pop    %esi
801057f6:	5f                   	pop    %edi
801057f7:	5d                   	pop    %ebp
801057f8:	c3                   	ret
801057f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80105800:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105807:	00 00 00 00 
  return exec(path, argv);
8010580b:	83 ec 08             	sub    $0x8,%esp
8010580e:	56                   	push   %esi
8010580f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80105815:	e8 06 b5 ff ff       	call   80100d20 <exec>
8010581a:	83 c4 10             	add    $0x10,%esp
}
8010581d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105820:	5b                   	pop    %ebx
80105821:	5e                   	pop    %esi
80105822:	5f                   	pop    %edi
80105823:	5d                   	pop    %ebp
80105824:	c3                   	ret
80105825:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010582c:	00 
8010582d:	8d 76 00             	lea    0x0(%esi),%esi

80105830 <sys_pipe>:

int
sys_pipe(void)
{
80105830:	55                   	push   %ebp
80105831:	89 e5                	mov    %esp,%ebp
80105833:	57                   	push   %edi
80105834:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105835:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105838:	53                   	push   %ebx
80105839:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010583c:	6a 08                	push   $0x8
8010583e:	50                   	push   %eax
8010583f:	6a 00                	push   $0x0
80105841:	e8 da f3 ff ff       	call   80104c20 <argptr>
80105846:	83 c4 10             	add    $0x10,%esp
80105849:	85 c0                	test   %eax,%eax
8010584b:	0f 88 8b 00 00 00    	js     801058dc <sys_pipe+0xac>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
80105851:	83 ec 08             	sub    $0x8,%esp
80105854:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105857:	50                   	push   %eax
80105858:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010585b:	50                   	push   %eax
8010585c:	e8 2f de ff ff       	call   80103690 <pipealloc>
80105861:	83 c4 10             	add    $0x10,%esp
80105864:	85 c0                	test   %eax,%eax
80105866:	78 74                	js     801058dc <sys_pipe+0xac>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105868:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010586b:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010586d:	e8 6e e3 ff ff       	call   80103be0 <myproc>
    if(curproc->ofile[fd] == 0){
80105872:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105876:	85 f6                	test   %esi,%esi
80105878:	74 16                	je     80105890 <sys_pipe+0x60>
8010587a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105880:	83 c3 01             	add    $0x1,%ebx
80105883:	83 fb 10             	cmp    $0x10,%ebx
80105886:	74 3d                	je     801058c5 <sys_pipe+0x95>
    if(curproc->ofile[fd] == 0){
80105888:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
8010588c:	85 f6                	test   %esi,%esi
8010588e:	75 f0                	jne    80105880 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
80105890:	8d 73 08             	lea    0x8(%ebx),%esi
80105893:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80105897:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
8010589a:	e8 41 e3 ff ff       	call   80103be0 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010589f:	31 d2                	xor    %edx,%edx
801058a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801058a8:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801058ac:	85 c9                	test   %ecx,%ecx
801058ae:	74 38                	je     801058e8 <sys_pipe+0xb8>
  for(fd = 0; fd < NOFILE; fd++){
801058b0:	83 c2 01             	add    $0x1,%edx
801058b3:	83 fa 10             	cmp    $0x10,%edx
801058b6:	75 f0                	jne    801058a8 <sys_pipe+0x78>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
801058b8:	e8 23 e3 ff ff       	call   80103be0 <myproc>
801058bd:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
801058c4:	00 
    fileclose(rf);
801058c5:	83 ec 0c             	sub    $0xc,%esp
801058c8:	ff 75 e0             	push   -0x20(%ebp)
801058cb:	e8 b0 b8 ff ff       	call   80101180 <fileclose>
    fileclose(wf);
801058d0:	58                   	pop    %eax
801058d1:	ff 75 e4             	push   -0x1c(%ebp)
801058d4:	e8 a7 b8 ff ff       	call   80101180 <fileclose>
    return -1;
801058d9:	83 c4 10             	add    $0x10,%esp
    return -1;
801058dc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801058e1:	eb 16                	jmp    801058f9 <sys_pipe+0xc9>
801058e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
801058e8:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
801058ec:	8b 45 dc             	mov    -0x24(%ebp),%eax
801058ef:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801058f1:	8b 45 dc             	mov    -0x24(%ebp),%eax
801058f4:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
801058f7:	31 c0                	xor    %eax,%eax
}
801058f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801058fc:	5b                   	pop    %ebx
801058fd:	5e                   	pop    %esi
801058fe:	5f                   	pop    %edi
801058ff:	5d                   	pop    %ebp
80105900:	c3                   	ret
80105901:	66 90                	xchg   %ax,%ax
80105903:	66 90                	xchg   %ax,%ax
80105905:	66 90                	xchg   %ax,%ax
80105907:	66 90                	xchg   %ax,%ax
80105909:	66 90                	xchg   %ax,%ax
8010590b:	66 90                	xchg   %ax,%ax
8010590d:	66 90                	xchg   %ax,%ax
8010590f:	90                   	nop

80105910 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105910:	e9 6b e4 ff ff       	jmp    80103d80 <fork>
80105915:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010591c:	00 
8010591d:	8d 76 00             	lea    0x0(%esi),%esi

80105920 <sys_exit>:
}

int
sys_exit(void)
{
80105920:	55                   	push   %ebp
80105921:	89 e5                	mov    %esp,%ebp
80105923:	83 ec 08             	sub    $0x8,%esp
  exit();
80105926:	e8 c5 e6 ff ff       	call   80103ff0 <exit>
  return 0;  // not reached
}
8010592b:	31 c0                	xor    %eax,%eax
8010592d:	c9                   	leave
8010592e:	c3                   	ret
8010592f:	90                   	nop

80105930 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105930:	e9 eb e7 ff ff       	jmp    80104120 <wait>
80105935:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010593c:	00 
8010593d:	8d 76 00             	lea    0x0(%esi),%esi

80105940 <sys_kill>:
}

int
sys_kill(void)
{
80105940:	55                   	push   %ebp
80105941:	89 e5                	mov    %esp,%ebp
80105943:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105946:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105949:	50                   	push   %eax
8010594a:	6a 00                	push   $0x0
8010594c:	e8 7f f2 ff ff       	call   80104bd0 <argint>
80105951:	83 c4 10             	add    $0x10,%esp
80105954:	85 c0                	test   %eax,%eax
80105956:	78 18                	js     80105970 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105958:	83 ec 0c             	sub    $0xc,%esp
8010595b:	ff 75 f4             	push   -0xc(%ebp)
8010595e:	e8 5d ea ff ff       	call   801043c0 <kill>
80105963:	83 c4 10             	add    $0x10,%esp
}
80105966:	c9                   	leave
80105967:	c3                   	ret
80105968:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010596f:	00 
80105970:	c9                   	leave
    return -1;
80105971:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105976:	c3                   	ret
80105977:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010597e:	00 
8010597f:	90                   	nop

80105980 <sys_getpid>:

int
sys_getpid(void)
{
80105980:	55                   	push   %ebp
80105981:	89 e5                	mov    %esp,%ebp
80105983:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105986:	e8 55 e2 ff ff       	call   80103be0 <myproc>
8010598b:	8b 40 10             	mov    0x10(%eax),%eax
}
8010598e:	c9                   	leave
8010598f:	c3                   	ret

80105990 <sys_sbrk>:

int
sys_sbrk(void)
{
80105990:	55                   	push   %ebp
80105991:	89 e5                	mov    %esp,%ebp
80105993:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105994:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105997:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010599a:	50                   	push   %eax
8010599b:	6a 00                	push   $0x0
8010599d:	e8 2e f2 ff ff       	call   80104bd0 <argint>
801059a2:	83 c4 10             	add    $0x10,%esp
801059a5:	85 c0                	test   %eax,%eax
801059a7:	78 27                	js     801059d0 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801059a9:	e8 32 e2 ff ff       	call   80103be0 <myproc>
  if(growproc(n) < 0)
801059ae:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
801059b1:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
801059b3:	ff 75 f4             	push   -0xc(%ebp)
801059b6:	e8 45 e3 ff ff       	call   80103d00 <growproc>
801059bb:	83 c4 10             	add    $0x10,%esp
801059be:	85 c0                	test   %eax,%eax
801059c0:	78 0e                	js     801059d0 <sys_sbrk+0x40>
    return -1;
  return addr;
}
801059c2:	89 d8                	mov    %ebx,%eax
801059c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801059c7:	c9                   	leave
801059c8:	c3                   	ret
801059c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
801059d0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801059d5:	eb eb                	jmp    801059c2 <sys_sbrk+0x32>
801059d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801059de:	00 
801059df:	90                   	nop

801059e0 <sys_sleep>:

int
sys_sleep(void)
{
801059e0:	55                   	push   %ebp
801059e1:	89 e5                	mov    %esp,%ebp
801059e3:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
801059e4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801059e7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801059ea:	50                   	push   %eax
801059eb:	6a 00                	push   $0x0
801059ed:	e8 de f1 ff ff       	call   80104bd0 <argint>
801059f2:	83 c4 10             	add    $0x10,%esp
801059f5:	85 c0                	test   %eax,%eax
801059f7:	78 64                	js     80105a5d <sys_sleep+0x7d>
    return -1;
  acquire(&tickslock);
801059f9:	83 ec 0c             	sub    $0xc,%esp
801059fc:	68 c0 3d 11 80       	push   $0x80113dc0
80105a01:	e8 1a ee ff ff       	call   80104820 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105a06:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80105a09:	8b 1d a0 3d 11 80    	mov    0x80113da0,%ebx
  while(ticks - ticks0 < n){
80105a0f:	83 c4 10             	add    $0x10,%esp
80105a12:	85 d2                	test   %edx,%edx
80105a14:	75 2b                	jne    80105a41 <sys_sleep+0x61>
80105a16:	eb 58                	jmp    80105a70 <sys_sleep+0x90>
80105a18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a1f:	00 
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105a20:	83 ec 08             	sub    $0x8,%esp
80105a23:	68 c0 3d 11 80       	push   $0x80113dc0
80105a28:	68 a0 3d 11 80       	push   $0x80113da0
80105a2d:	e8 6e e8 ff ff       	call   801042a0 <sleep>
  while(ticks - ticks0 < n){
80105a32:	a1 a0 3d 11 80       	mov    0x80113da0,%eax
80105a37:	83 c4 10             	add    $0x10,%esp
80105a3a:	29 d8                	sub    %ebx,%eax
80105a3c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105a3f:	73 2f                	jae    80105a70 <sys_sleep+0x90>
    if(myproc()->killed){
80105a41:	e8 9a e1 ff ff       	call   80103be0 <myproc>
80105a46:	8b 40 24             	mov    0x24(%eax),%eax
80105a49:	85 c0                	test   %eax,%eax
80105a4b:	74 d3                	je     80105a20 <sys_sleep+0x40>
      release(&tickslock);
80105a4d:	83 ec 0c             	sub    $0xc,%esp
80105a50:	68 c0 3d 11 80       	push   $0x80113dc0
80105a55:	e8 66 ed ff ff       	call   801047c0 <release>
      return -1;
80105a5a:	83 c4 10             	add    $0x10,%esp
  }
  release(&tickslock);
  return 0;
}
80105a5d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80105a60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105a65:	c9                   	leave
80105a66:	c3                   	ret
80105a67:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a6e:	00 
80105a6f:	90                   	nop
  release(&tickslock);
80105a70:	83 ec 0c             	sub    $0xc,%esp
80105a73:	68 c0 3d 11 80       	push   $0x80113dc0
80105a78:	e8 43 ed ff ff       	call   801047c0 <release>
}
80105a7d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return 0;
80105a80:	83 c4 10             	add    $0x10,%esp
80105a83:	31 c0                	xor    %eax,%eax
}
80105a85:	c9                   	leave
80105a86:	c3                   	ret
80105a87:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a8e:	00 
80105a8f:	90                   	nop

80105a90 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105a90:	55                   	push   %ebp
80105a91:	89 e5                	mov    %esp,%ebp
80105a93:	53                   	push   %ebx
80105a94:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105a97:	68 c0 3d 11 80       	push   $0x80113dc0
80105a9c:	e8 7f ed ff ff       	call   80104820 <acquire>
  xticks = ticks;
80105aa1:	8b 1d a0 3d 11 80    	mov    0x80113da0,%ebx
  release(&tickslock);
80105aa7:	c7 04 24 c0 3d 11 80 	movl   $0x80113dc0,(%esp)
80105aae:	e8 0d ed ff ff       	call   801047c0 <release>
  return xticks;
}
80105ab3:	89 d8                	mov    %ebx,%eax
80105ab5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ab8:	c9                   	leave
80105ab9:	c3                   	ret

80105aba <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105aba:	1e                   	push   %ds
  pushl %es
80105abb:	06                   	push   %es
  pushl %fs
80105abc:	0f a0                	push   %fs
  pushl %gs
80105abe:	0f a8                	push   %gs
  pushal
80105ac0:	60                   	pusha
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105ac1:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105ac5:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105ac7:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105ac9:	54                   	push   %esp
  call trap
80105aca:	e8 c1 00 00 00       	call   80105b90 <trap>
  addl $4, %esp
80105acf:	83 c4 04             	add    $0x4,%esp

80105ad2 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105ad2:	61                   	popa
  popl %gs
80105ad3:	0f a9                	pop    %gs
  popl %fs
80105ad5:	0f a1                	pop    %fs
  popl %es
80105ad7:	07                   	pop    %es
  popl %ds
80105ad8:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105ad9:	83 c4 08             	add    $0x8,%esp
  iret
80105adc:	cf                   	iret
80105add:	66 90                	xchg   %ax,%ax
80105adf:	90                   	nop

80105ae0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105ae0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105ae1:	31 c0                	xor    %eax,%eax
{
80105ae3:	89 e5                	mov    %esp,%ebp
80105ae5:	83 ec 08             	sub    $0x8,%esp
80105ae8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105aef:	00 
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105af0:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105af7:	c7 04 c5 02 3e 11 80 	movl   $0x8e000008,-0x7feec1fe(,%eax,8)
80105afe:	08 00 00 8e 
80105b02:	66 89 14 c5 00 3e 11 	mov    %dx,-0x7feec200(,%eax,8)
80105b09:	80 
80105b0a:	c1 ea 10             	shr    $0x10,%edx
80105b0d:	66 89 14 c5 06 3e 11 	mov    %dx,-0x7feec1fa(,%eax,8)
80105b14:	80 
  for(i = 0; i < 256; i++)
80105b15:	83 c0 01             	add    $0x1,%eax
80105b18:	3d 00 01 00 00       	cmp    $0x100,%eax
80105b1d:	75 d1                	jne    80105af0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
80105b1f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105b22:	a1 08 a1 10 80       	mov    0x8010a108,%eax
80105b27:	c7 05 02 40 11 80 08 	movl   $0xef000008,0x80114002
80105b2e:	00 00 ef 
  initlock(&tickslock, "time");
80105b31:	68 ce 77 10 80       	push   $0x801077ce
80105b36:	68 c0 3d 11 80       	push   $0x80113dc0
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105b3b:	66 a3 00 40 11 80    	mov    %ax,0x80114000
80105b41:	c1 e8 10             	shr    $0x10,%eax
80105b44:	66 a3 06 40 11 80    	mov    %ax,0x80114006
  initlock(&tickslock, "time");
80105b4a:	e8 e1 ea ff ff       	call   80104630 <initlock>
}
80105b4f:	83 c4 10             	add    $0x10,%esp
80105b52:	c9                   	leave
80105b53:	c3                   	ret
80105b54:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105b5b:	00 
80105b5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105b60 <idtinit>:

void
idtinit(void)
{
80105b60:	55                   	push   %ebp
  pd[0] = size-1;
80105b61:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80105b66:	89 e5                	mov    %esp,%ebp
80105b68:	83 ec 10             	sub    $0x10,%esp
80105b6b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
80105b6f:	b8 00 3e 11 80       	mov    $0x80113e00,%eax
80105b74:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80105b78:	c1 e8 10             	shr    $0x10,%eax
80105b7b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80105b7f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80105b82:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80105b85:	c9                   	leave
80105b86:	c3                   	ret
80105b87:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105b8e:	00 
80105b8f:	90                   	nop

80105b90 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80105b90:	55                   	push   %ebp
80105b91:	89 e5                	mov    %esp,%ebp
80105b93:	57                   	push   %edi
80105b94:	56                   	push   %esi
80105b95:	53                   	push   %ebx
80105b96:	83 ec 1c             	sub    $0x1c,%esp
80105b99:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
80105b9c:	8b 43 30             	mov    0x30(%ebx),%eax
80105b9f:	83 f8 40             	cmp    $0x40,%eax
80105ba2:	0f 84 58 01 00 00    	je     80105d00 <trap+0x170>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80105ba8:	83 e8 20             	sub    $0x20,%eax
80105bab:	83 f8 1f             	cmp    $0x1f,%eax
80105bae:	0f 87 7c 00 00 00    	ja     80105c30 <trap+0xa0>
80105bb4:	ff 24 85 78 7d 10 80 	jmp    *-0x7fef8288(,%eax,4)
80105bbb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105bc0:	e8 db c8 ff ff       	call   801024a0 <ideintr>
    lapiceoi();
80105bc5:	e8 a6 cf ff ff       	call   80102b70 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105bca:	e8 11 e0 ff ff       	call   80103be0 <myproc>
80105bcf:	85 c0                	test   %eax,%eax
80105bd1:	74 1a                	je     80105bed <trap+0x5d>
80105bd3:	e8 08 e0 ff ff       	call   80103be0 <myproc>
80105bd8:	8b 50 24             	mov    0x24(%eax),%edx
80105bdb:	85 d2                	test   %edx,%edx
80105bdd:	74 0e                	je     80105bed <trap+0x5d>
80105bdf:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105be3:	f7 d0                	not    %eax
80105be5:	a8 03                	test   $0x3,%al
80105be7:	0f 84 db 01 00 00    	je     80105dc8 <trap+0x238>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105bed:	e8 ee df ff ff       	call   80103be0 <myproc>
80105bf2:	85 c0                	test   %eax,%eax
80105bf4:	74 0f                	je     80105c05 <trap+0x75>
80105bf6:	e8 e5 df ff ff       	call   80103be0 <myproc>
80105bfb:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105bff:	0f 84 ab 00 00 00    	je     80105cb0 <trap+0x120>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c05:	e8 d6 df ff ff       	call   80103be0 <myproc>
80105c0a:	85 c0                	test   %eax,%eax
80105c0c:	74 1a                	je     80105c28 <trap+0x98>
80105c0e:	e8 cd df ff ff       	call   80103be0 <myproc>
80105c13:	8b 40 24             	mov    0x24(%eax),%eax
80105c16:	85 c0                	test   %eax,%eax
80105c18:	74 0e                	je     80105c28 <trap+0x98>
80105c1a:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105c1e:	f7 d0                	not    %eax
80105c20:	a8 03                	test   $0x3,%al
80105c22:	0f 84 05 01 00 00    	je     80105d2d <trap+0x19d>
    exit();
}
80105c28:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105c2b:	5b                   	pop    %ebx
80105c2c:	5e                   	pop    %esi
80105c2d:	5f                   	pop    %edi
80105c2e:	5d                   	pop    %ebp
80105c2f:	c3                   	ret
    if(myproc() == 0 || (tf->cs&3) == 0){
80105c30:	e8 ab df ff ff       	call   80103be0 <myproc>
80105c35:	8b 7b 38             	mov    0x38(%ebx),%edi
80105c38:	85 c0                	test   %eax,%eax
80105c3a:	0f 84 a2 01 00 00    	je     80105de2 <trap+0x252>
80105c40:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105c44:	0f 84 98 01 00 00    	je     80105de2 <trap+0x252>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105c4a:	0f 20 d1             	mov    %cr2,%ecx
80105c4d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105c50:	e8 6b df ff ff       	call   80103bc0 <cpuid>
80105c55:	8b 73 30             	mov    0x30(%ebx),%esi
80105c58:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105c5b:	8b 43 34             	mov    0x34(%ebx),%eax
80105c5e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80105c61:	e8 7a df ff ff       	call   80103be0 <myproc>
80105c66:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105c69:	e8 72 df ff ff       	call   80103be0 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105c6e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105c71:	51                   	push   %ecx
80105c72:	57                   	push   %edi
80105c73:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105c76:	52                   	push   %edx
80105c77:	ff 75 e4             	push   -0x1c(%ebp)
80105c7a:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105c7b:	8b 75 e0             	mov    -0x20(%ebp),%esi
80105c7e:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105c81:	56                   	push   %esi
80105c82:	ff 70 10             	push   0x10(%eax)
80105c85:	68 6c 7a 10 80       	push   $0x80107a6c
80105c8a:	e8 b1 aa ff ff       	call   80100740 <cprintf>
    myproc()->killed = 1;
80105c8f:	83 c4 20             	add    $0x20,%esp
80105c92:	e8 49 df ff ff       	call   80103be0 <myproc>
80105c97:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105c9e:	e8 3d df ff ff       	call   80103be0 <myproc>
80105ca3:	85 c0                	test   %eax,%eax
80105ca5:	0f 85 28 ff ff ff    	jne    80105bd3 <trap+0x43>
80105cab:	e9 3d ff ff ff       	jmp    80105bed <trap+0x5d>
  if(myproc() && myproc()->state == RUNNING &&
80105cb0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105cb4:	0f 85 4b ff ff ff    	jne    80105c05 <trap+0x75>
    yield();
80105cba:	e8 91 e5 ff ff       	call   80104250 <yield>
80105cbf:	e9 41 ff ff ff       	jmp    80105c05 <trap+0x75>
80105cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105cc8:	8b 7b 38             	mov    0x38(%ebx),%edi
80105ccb:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105ccf:	e8 ec de ff ff       	call   80103bc0 <cpuid>
80105cd4:	57                   	push   %edi
80105cd5:	56                   	push   %esi
80105cd6:	50                   	push   %eax
80105cd7:	68 14 7a 10 80       	push   $0x80107a14
80105cdc:	e8 5f aa ff ff       	call   80100740 <cprintf>
    lapiceoi();
80105ce1:	e8 8a ce ff ff       	call   80102b70 <lapiceoi>
    break;
80105ce6:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105ce9:	e8 f2 de ff ff       	call   80103be0 <myproc>
80105cee:	85 c0                	test   %eax,%eax
80105cf0:	0f 85 dd fe ff ff    	jne    80105bd3 <trap+0x43>
80105cf6:	e9 f2 fe ff ff       	jmp    80105bed <trap+0x5d>
80105cfb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80105d00:	e8 db de ff ff       	call   80103be0 <myproc>
80105d05:	8b 70 24             	mov    0x24(%eax),%esi
80105d08:	85 f6                	test   %esi,%esi
80105d0a:	0f 85 c8 00 00 00    	jne    80105dd8 <trap+0x248>
    myproc()->tf = tf;
80105d10:	e8 cb de ff ff       	call   80103be0 <myproc>
80105d15:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105d18:	e8 f3 ef ff ff       	call   80104d10 <syscall>
    if(myproc()->killed)
80105d1d:	e8 be de ff ff       	call   80103be0 <myproc>
80105d22:	8b 48 24             	mov    0x24(%eax),%ecx
80105d25:	85 c9                	test   %ecx,%ecx
80105d27:	0f 84 fb fe ff ff    	je     80105c28 <trap+0x98>
}
80105d2d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d30:	5b                   	pop    %ebx
80105d31:	5e                   	pop    %esi
80105d32:	5f                   	pop    %edi
80105d33:	5d                   	pop    %ebp
      exit();
80105d34:	e9 b7 e2 ff ff       	jmp    80103ff0 <exit>
80105d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105d40:	e8 4b 02 00 00       	call   80105f90 <uartintr>
    lapiceoi();
80105d45:	e8 26 ce ff ff       	call   80102b70 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d4a:	e8 91 de ff ff       	call   80103be0 <myproc>
80105d4f:	85 c0                	test   %eax,%eax
80105d51:	0f 85 7c fe ff ff    	jne    80105bd3 <trap+0x43>
80105d57:	e9 91 fe ff ff       	jmp    80105bed <trap+0x5d>
80105d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105d60:	e8 db cc ff ff       	call   80102a40 <kbdintr>
    lapiceoi();
80105d65:	e8 06 ce ff ff       	call   80102b70 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105d6a:	e8 71 de ff ff       	call   80103be0 <myproc>
80105d6f:	85 c0                	test   %eax,%eax
80105d71:	0f 85 5c fe ff ff    	jne    80105bd3 <trap+0x43>
80105d77:	e9 71 fe ff ff       	jmp    80105bed <trap+0x5d>
80105d7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80105d80:	e8 3b de ff ff       	call   80103bc0 <cpuid>
80105d85:	85 c0                	test   %eax,%eax
80105d87:	0f 85 38 fe ff ff    	jne    80105bc5 <trap+0x35>
      acquire(&tickslock);
80105d8d:	83 ec 0c             	sub    $0xc,%esp
80105d90:	68 c0 3d 11 80       	push   $0x80113dc0
80105d95:	e8 86 ea ff ff       	call   80104820 <acquire>
      ticks++;
80105d9a:	83 05 a0 3d 11 80 01 	addl   $0x1,0x80113da0
      wakeup(&ticks);
80105da1:	c7 04 24 a0 3d 11 80 	movl   $0x80113da0,(%esp)
80105da8:	e8 b3 e5 ff ff       	call   80104360 <wakeup>
      release(&tickslock);
80105dad:	c7 04 24 c0 3d 11 80 	movl   $0x80113dc0,(%esp)
80105db4:	e8 07 ea ff ff       	call   801047c0 <release>
80105db9:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80105dbc:	e9 04 fe ff ff       	jmp    80105bc5 <trap+0x35>
80105dc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80105dc8:	e8 23 e2 ff ff       	call   80103ff0 <exit>
80105dcd:	e9 1b fe ff ff       	jmp    80105bed <trap+0x5d>
80105dd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105dd8:	e8 13 e2 ff ff       	call   80103ff0 <exit>
80105ddd:	e9 2e ff ff ff       	jmp    80105d10 <trap+0x180>
80105de2:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105de5:	e8 d6 dd ff ff       	call   80103bc0 <cpuid>
80105dea:	83 ec 0c             	sub    $0xc,%esp
80105ded:	56                   	push   %esi
80105dee:	57                   	push   %edi
80105def:	50                   	push   %eax
80105df0:	ff 73 30             	push   0x30(%ebx)
80105df3:	68 38 7a 10 80       	push   $0x80107a38
80105df8:	e8 43 a9 ff ff       	call   80100740 <cprintf>
      panic("trap");
80105dfd:	83 c4 14             	add    $0x14,%esp
80105e00:	68 d3 77 10 80       	push   $0x801077d3
80105e05:	e8 76 a5 ff ff       	call   80100380 <panic>
80105e0a:	66 90                	xchg   %ax,%ax
80105e0c:	66 90                	xchg   %ax,%ax
80105e0e:	66 90                	xchg   %ax,%ax

80105e10 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105e10:	a1 00 46 11 80       	mov    0x80114600,%eax
80105e15:	85 c0                	test   %eax,%eax
80105e17:	74 17                	je     80105e30 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105e19:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105e1e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105e1f:	a8 01                	test   $0x1,%al
80105e21:	74 0d                	je     80105e30 <uartgetc+0x20>
80105e23:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e28:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105e29:	0f b6 c0             	movzbl %al,%eax
80105e2c:	c3                   	ret
80105e2d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105e30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105e35:	c3                   	ret
80105e36:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e3d:	00 
80105e3e:	66 90                	xchg   %ax,%ax

80105e40 <uartinit>:
{
80105e40:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105e41:	31 c9                	xor    %ecx,%ecx
80105e43:	89 c8                	mov    %ecx,%eax
80105e45:	89 e5                	mov    %esp,%ebp
80105e47:	57                   	push   %edi
80105e48:	bf fa 03 00 00       	mov    $0x3fa,%edi
80105e4d:	56                   	push   %esi
80105e4e:	89 fa                	mov    %edi,%edx
80105e50:	53                   	push   %ebx
80105e51:	83 ec 1c             	sub    $0x1c,%esp
80105e54:	ee                   	out    %al,(%dx)
80105e55:	be fb 03 00 00       	mov    $0x3fb,%esi
80105e5a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105e5f:	89 f2                	mov    %esi,%edx
80105e61:	ee                   	out    %al,(%dx)
80105e62:	b8 0c 00 00 00       	mov    $0xc,%eax
80105e67:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105e6c:	ee                   	out    %al,(%dx)
80105e6d:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80105e72:	89 c8                	mov    %ecx,%eax
80105e74:	89 da                	mov    %ebx,%edx
80105e76:	ee                   	out    %al,(%dx)
80105e77:	b8 03 00 00 00       	mov    $0x3,%eax
80105e7c:	89 f2                	mov    %esi,%edx
80105e7e:	ee                   	out    %al,(%dx)
80105e7f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105e84:	89 c8                	mov    %ecx,%eax
80105e86:	ee                   	out    %al,(%dx)
80105e87:	b8 01 00 00 00       	mov    $0x1,%eax
80105e8c:	89 da                	mov    %ebx,%edx
80105e8e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105e8f:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105e94:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105e95:	3c ff                	cmp    $0xff,%al
80105e97:	0f 84 7c 00 00 00    	je     80105f19 <uartinit+0xd9>
  uart = 1;
80105e9d:	c7 05 00 46 11 80 01 	movl   $0x1,0x80114600
80105ea4:	00 00 00 
80105ea7:	89 fa                	mov    %edi,%edx
80105ea9:	ec                   	in     (%dx),%al
80105eaa:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105eaf:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105eb0:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105eb3:	bf d8 77 10 80       	mov    $0x801077d8,%edi
80105eb8:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
80105ebd:	6a 00                	push   $0x0
80105ebf:	6a 04                	push   $0x4
80105ec1:	e8 0a c8 ff ff       	call   801026d0 <ioapicenable>
80105ec6:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105ec9:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
80105ecd:	8d 76 00             	lea    0x0(%esi),%esi
  if(!uart)
80105ed0:	a1 00 46 11 80       	mov    0x80114600,%eax
80105ed5:	85 c0                	test   %eax,%eax
80105ed7:	74 32                	je     80105f0b <uartinit+0xcb>
80105ed9:	89 f2                	mov    %esi,%edx
80105edb:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105edc:	a8 20                	test   $0x20,%al
80105ede:	75 21                	jne    80105f01 <uartinit+0xc1>
80105ee0:	bb 80 00 00 00       	mov    $0x80,%ebx
80105ee5:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
80105ee8:	83 ec 0c             	sub    $0xc,%esp
80105eeb:	6a 0a                	push   $0xa
80105eed:	e8 9e cc ff ff       	call   80102b90 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105ef2:	83 c4 10             	add    $0x10,%esp
80105ef5:	83 eb 01             	sub    $0x1,%ebx
80105ef8:	74 07                	je     80105f01 <uartinit+0xc1>
80105efa:	89 f2                	mov    %esi,%edx
80105efc:	ec                   	in     (%dx),%al
80105efd:	a8 20                	test   $0x20,%al
80105eff:	74 e7                	je     80105ee8 <uartinit+0xa8>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105f01:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105f06:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80105f0a:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80105f0b:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80105f0f:	83 c7 01             	add    $0x1,%edi
80105f12:	88 45 e7             	mov    %al,-0x19(%ebp)
80105f15:	84 c0                	test   %al,%al
80105f17:	75 b7                	jne    80105ed0 <uartinit+0x90>
}
80105f19:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f1c:	5b                   	pop    %ebx
80105f1d:	5e                   	pop    %esi
80105f1e:	5f                   	pop    %edi
80105f1f:	5d                   	pop    %ebp
80105f20:	c3                   	ret
80105f21:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105f28:	00 
80105f29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105f30 <uartputc>:
  if(!uart)
80105f30:	a1 00 46 11 80       	mov    0x80114600,%eax
80105f35:	85 c0                	test   %eax,%eax
80105f37:	74 4f                	je     80105f88 <uartputc+0x58>
{
80105f39:	55                   	push   %ebp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105f3a:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105f3f:	89 e5                	mov    %esp,%ebp
80105f41:	56                   	push   %esi
80105f42:	53                   	push   %ebx
80105f43:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105f44:	a8 20                	test   $0x20,%al
80105f46:	75 29                	jne    80105f71 <uartputc+0x41>
80105f48:	bb 80 00 00 00       	mov    $0x80,%ebx
80105f4d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105f52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80105f58:	83 ec 0c             	sub    $0xc,%esp
80105f5b:	6a 0a                	push   $0xa
80105f5d:	e8 2e cc ff ff       	call   80102b90 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105f62:	83 c4 10             	add    $0x10,%esp
80105f65:	83 eb 01             	sub    $0x1,%ebx
80105f68:	74 07                	je     80105f71 <uartputc+0x41>
80105f6a:	89 f2                	mov    %esi,%edx
80105f6c:	ec                   	in     (%dx),%al
80105f6d:	a8 20                	test   $0x20,%al
80105f6f:	74 e7                	je     80105f58 <uartputc+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105f71:	8b 45 08             	mov    0x8(%ebp),%eax
80105f74:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105f79:	ee                   	out    %al,(%dx)
}
80105f7a:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105f7d:	5b                   	pop    %ebx
80105f7e:	5e                   	pop    %esi
80105f7f:	5d                   	pop    %ebp
80105f80:	c3                   	ret
80105f81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105f88:	c3                   	ret
80105f89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105f90 <uartintr>:

void
uartintr(void)
{
80105f90:	55                   	push   %ebp
80105f91:	89 e5                	mov    %esp,%ebp
80105f93:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105f96:	68 10 5e 10 80       	push   $0x80105e10
80105f9b:	e8 d0 a9 ff ff       	call   80100970 <consoleintr>
}
80105fa0:	83 c4 10             	add    $0x10,%esp
80105fa3:	c9                   	leave
80105fa4:	c3                   	ret

80105fa5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105fa5:	6a 00                	push   $0x0
  pushl $0
80105fa7:	6a 00                	push   $0x0
  jmp alltraps
80105fa9:	e9 0c fb ff ff       	jmp    80105aba <alltraps>

80105fae <vector1>:
.globl vector1
vector1:
  pushl $0
80105fae:	6a 00                	push   $0x0
  pushl $1
80105fb0:	6a 01                	push   $0x1
  jmp alltraps
80105fb2:	e9 03 fb ff ff       	jmp    80105aba <alltraps>

80105fb7 <vector2>:
.globl vector2
vector2:
  pushl $0
80105fb7:	6a 00                	push   $0x0
  pushl $2
80105fb9:	6a 02                	push   $0x2
  jmp alltraps
80105fbb:	e9 fa fa ff ff       	jmp    80105aba <alltraps>

80105fc0 <vector3>:
.globl vector3
vector3:
  pushl $0
80105fc0:	6a 00                	push   $0x0
  pushl $3
80105fc2:	6a 03                	push   $0x3
  jmp alltraps
80105fc4:	e9 f1 fa ff ff       	jmp    80105aba <alltraps>

80105fc9 <vector4>:
.globl vector4
vector4:
  pushl $0
80105fc9:	6a 00                	push   $0x0
  pushl $4
80105fcb:	6a 04                	push   $0x4
  jmp alltraps
80105fcd:	e9 e8 fa ff ff       	jmp    80105aba <alltraps>

80105fd2 <vector5>:
.globl vector5
vector5:
  pushl $0
80105fd2:	6a 00                	push   $0x0
  pushl $5
80105fd4:	6a 05                	push   $0x5
  jmp alltraps
80105fd6:	e9 df fa ff ff       	jmp    80105aba <alltraps>

80105fdb <vector6>:
.globl vector6
vector6:
  pushl $0
80105fdb:	6a 00                	push   $0x0
  pushl $6
80105fdd:	6a 06                	push   $0x6
  jmp alltraps
80105fdf:	e9 d6 fa ff ff       	jmp    80105aba <alltraps>

80105fe4 <vector7>:
.globl vector7
vector7:
  pushl $0
80105fe4:	6a 00                	push   $0x0
  pushl $7
80105fe6:	6a 07                	push   $0x7
  jmp alltraps
80105fe8:	e9 cd fa ff ff       	jmp    80105aba <alltraps>

80105fed <vector8>:
.globl vector8
vector8:
  pushl $8
80105fed:	6a 08                	push   $0x8
  jmp alltraps
80105fef:	e9 c6 fa ff ff       	jmp    80105aba <alltraps>

80105ff4 <vector9>:
.globl vector9
vector9:
  pushl $0
80105ff4:	6a 00                	push   $0x0
  pushl $9
80105ff6:	6a 09                	push   $0x9
  jmp alltraps
80105ff8:	e9 bd fa ff ff       	jmp    80105aba <alltraps>

80105ffd <vector10>:
.globl vector10
vector10:
  pushl $10
80105ffd:	6a 0a                	push   $0xa
  jmp alltraps
80105fff:	e9 b6 fa ff ff       	jmp    80105aba <alltraps>

80106004 <vector11>:
.globl vector11
vector11:
  pushl $11
80106004:	6a 0b                	push   $0xb
  jmp alltraps
80106006:	e9 af fa ff ff       	jmp    80105aba <alltraps>

8010600b <vector12>:
.globl vector12
vector12:
  pushl $12
8010600b:	6a 0c                	push   $0xc
  jmp alltraps
8010600d:	e9 a8 fa ff ff       	jmp    80105aba <alltraps>

80106012 <vector13>:
.globl vector13
vector13:
  pushl $13
80106012:	6a 0d                	push   $0xd
  jmp alltraps
80106014:	e9 a1 fa ff ff       	jmp    80105aba <alltraps>

80106019 <vector14>:
.globl vector14
vector14:
  pushl $14
80106019:	6a 0e                	push   $0xe
  jmp alltraps
8010601b:	e9 9a fa ff ff       	jmp    80105aba <alltraps>

80106020 <vector15>:
.globl vector15
vector15:
  pushl $0
80106020:	6a 00                	push   $0x0
  pushl $15
80106022:	6a 0f                	push   $0xf
  jmp alltraps
80106024:	e9 91 fa ff ff       	jmp    80105aba <alltraps>

80106029 <vector16>:
.globl vector16
vector16:
  pushl $0
80106029:	6a 00                	push   $0x0
  pushl $16
8010602b:	6a 10                	push   $0x10
  jmp alltraps
8010602d:	e9 88 fa ff ff       	jmp    80105aba <alltraps>

80106032 <vector17>:
.globl vector17
vector17:
  pushl $17
80106032:	6a 11                	push   $0x11
  jmp alltraps
80106034:	e9 81 fa ff ff       	jmp    80105aba <alltraps>

80106039 <vector18>:
.globl vector18
vector18:
  pushl $0
80106039:	6a 00                	push   $0x0
  pushl $18
8010603b:	6a 12                	push   $0x12
  jmp alltraps
8010603d:	e9 78 fa ff ff       	jmp    80105aba <alltraps>

80106042 <vector19>:
.globl vector19
vector19:
  pushl $0
80106042:	6a 00                	push   $0x0
  pushl $19
80106044:	6a 13                	push   $0x13
  jmp alltraps
80106046:	e9 6f fa ff ff       	jmp    80105aba <alltraps>

8010604b <vector20>:
.globl vector20
vector20:
  pushl $0
8010604b:	6a 00                	push   $0x0
  pushl $20
8010604d:	6a 14                	push   $0x14
  jmp alltraps
8010604f:	e9 66 fa ff ff       	jmp    80105aba <alltraps>

80106054 <vector21>:
.globl vector21
vector21:
  pushl $0
80106054:	6a 00                	push   $0x0
  pushl $21
80106056:	6a 15                	push   $0x15
  jmp alltraps
80106058:	e9 5d fa ff ff       	jmp    80105aba <alltraps>

8010605d <vector22>:
.globl vector22
vector22:
  pushl $0
8010605d:	6a 00                	push   $0x0
  pushl $22
8010605f:	6a 16                	push   $0x16
  jmp alltraps
80106061:	e9 54 fa ff ff       	jmp    80105aba <alltraps>

80106066 <vector23>:
.globl vector23
vector23:
  pushl $0
80106066:	6a 00                	push   $0x0
  pushl $23
80106068:	6a 17                	push   $0x17
  jmp alltraps
8010606a:	e9 4b fa ff ff       	jmp    80105aba <alltraps>

8010606f <vector24>:
.globl vector24
vector24:
  pushl $0
8010606f:	6a 00                	push   $0x0
  pushl $24
80106071:	6a 18                	push   $0x18
  jmp alltraps
80106073:	e9 42 fa ff ff       	jmp    80105aba <alltraps>

80106078 <vector25>:
.globl vector25
vector25:
  pushl $0
80106078:	6a 00                	push   $0x0
  pushl $25
8010607a:	6a 19                	push   $0x19
  jmp alltraps
8010607c:	e9 39 fa ff ff       	jmp    80105aba <alltraps>

80106081 <vector26>:
.globl vector26
vector26:
  pushl $0
80106081:	6a 00                	push   $0x0
  pushl $26
80106083:	6a 1a                	push   $0x1a
  jmp alltraps
80106085:	e9 30 fa ff ff       	jmp    80105aba <alltraps>

8010608a <vector27>:
.globl vector27
vector27:
  pushl $0
8010608a:	6a 00                	push   $0x0
  pushl $27
8010608c:	6a 1b                	push   $0x1b
  jmp alltraps
8010608e:	e9 27 fa ff ff       	jmp    80105aba <alltraps>

80106093 <vector28>:
.globl vector28
vector28:
  pushl $0
80106093:	6a 00                	push   $0x0
  pushl $28
80106095:	6a 1c                	push   $0x1c
  jmp alltraps
80106097:	e9 1e fa ff ff       	jmp    80105aba <alltraps>

8010609c <vector29>:
.globl vector29
vector29:
  pushl $0
8010609c:	6a 00                	push   $0x0
  pushl $29
8010609e:	6a 1d                	push   $0x1d
  jmp alltraps
801060a0:	e9 15 fa ff ff       	jmp    80105aba <alltraps>

801060a5 <vector30>:
.globl vector30
vector30:
  pushl $0
801060a5:	6a 00                	push   $0x0
  pushl $30
801060a7:	6a 1e                	push   $0x1e
  jmp alltraps
801060a9:	e9 0c fa ff ff       	jmp    80105aba <alltraps>

801060ae <vector31>:
.globl vector31
vector31:
  pushl $0
801060ae:	6a 00                	push   $0x0
  pushl $31
801060b0:	6a 1f                	push   $0x1f
  jmp alltraps
801060b2:	e9 03 fa ff ff       	jmp    80105aba <alltraps>

801060b7 <vector32>:
.globl vector32
vector32:
  pushl $0
801060b7:	6a 00                	push   $0x0
  pushl $32
801060b9:	6a 20                	push   $0x20
  jmp alltraps
801060bb:	e9 fa f9 ff ff       	jmp    80105aba <alltraps>

801060c0 <vector33>:
.globl vector33
vector33:
  pushl $0
801060c0:	6a 00                	push   $0x0
  pushl $33
801060c2:	6a 21                	push   $0x21
  jmp alltraps
801060c4:	e9 f1 f9 ff ff       	jmp    80105aba <alltraps>

801060c9 <vector34>:
.globl vector34
vector34:
  pushl $0
801060c9:	6a 00                	push   $0x0
  pushl $34
801060cb:	6a 22                	push   $0x22
  jmp alltraps
801060cd:	e9 e8 f9 ff ff       	jmp    80105aba <alltraps>

801060d2 <vector35>:
.globl vector35
vector35:
  pushl $0
801060d2:	6a 00                	push   $0x0
  pushl $35
801060d4:	6a 23                	push   $0x23
  jmp alltraps
801060d6:	e9 df f9 ff ff       	jmp    80105aba <alltraps>

801060db <vector36>:
.globl vector36
vector36:
  pushl $0
801060db:	6a 00                	push   $0x0
  pushl $36
801060dd:	6a 24                	push   $0x24
  jmp alltraps
801060df:	e9 d6 f9 ff ff       	jmp    80105aba <alltraps>

801060e4 <vector37>:
.globl vector37
vector37:
  pushl $0
801060e4:	6a 00                	push   $0x0
  pushl $37
801060e6:	6a 25                	push   $0x25
  jmp alltraps
801060e8:	e9 cd f9 ff ff       	jmp    80105aba <alltraps>

801060ed <vector38>:
.globl vector38
vector38:
  pushl $0
801060ed:	6a 00                	push   $0x0
  pushl $38
801060ef:	6a 26                	push   $0x26
  jmp alltraps
801060f1:	e9 c4 f9 ff ff       	jmp    80105aba <alltraps>

801060f6 <vector39>:
.globl vector39
vector39:
  pushl $0
801060f6:	6a 00                	push   $0x0
  pushl $39
801060f8:	6a 27                	push   $0x27
  jmp alltraps
801060fa:	e9 bb f9 ff ff       	jmp    80105aba <alltraps>

801060ff <vector40>:
.globl vector40
vector40:
  pushl $0
801060ff:	6a 00                	push   $0x0
  pushl $40
80106101:	6a 28                	push   $0x28
  jmp alltraps
80106103:	e9 b2 f9 ff ff       	jmp    80105aba <alltraps>

80106108 <vector41>:
.globl vector41
vector41:
  pushl $0
80106108:	6a 00                	push   $0x0
  pushl $41
8010610a:	6a 29                	push   $0x29
  jmp alltraps
8010610c:	e9 a9 f9 ff ff       	jmp    80105aba <alltraps>

80106111 <vector42>:
.globl vector42
vector42:
  pushl $0
80106111:	6a 00                	push   $0x0
  pushl $42
80106113:	6a 2a                	push   $0x2a
  jmp alltraps
80106115:	e9 a0 f9 ff ff       	jmp    80105aba <alltraps>

8010611a <vector43>:
.globl vector43
vector43:
  pushl $0
8010611a:	6a 00                	push   $0x0
  pushl $43
8010611c:	6a 2b                	push   $0x2b
  jmp alltraps
8010611e:	e9 97 f9 ff ff       	jmp    80105aba <alltraps>

80106123 <vector44>:
.globl vector44
vector44:
  pushl $0
80106123:	6a 00                	push   $0x0
  pushl $44
80106125:	6a 2c                	push   $0x2c
  jmp alltraps
80106127:	e9 8e f9 ff ff       	jmp    80105aba <alltraps>

8010612c <vector45>:
.globl vector45
vector45:
  pushl $0
8010612c:	6a 00                	push   $0x0
  pushl $45
8010612e:	6a 2d                	push   $0x2d
  jmp alltraps
80106130:	e9 85 f9 ff ff       	jmp    80105aba <alltraps>

80106135 <vector46>:
.globl vector46
vector46:
  pushl $0
80106135:	6a 00                	push   $0x0
  pushl $46
80106137:	6a 2e                	push   $0x2e
  jmp alltraps
80106139:	e9 7c f9 ff ff       	jmp    80105aba <alltraps>

8010613e <vector47>:
.globl vector47
vector47:
  pushl $0
8010613e:	6a 00                	push   $0x0
  pushl $47
80106140:	6a 2f                	push   $0x2f
  jmp alltraps
80106142:	e9 73 f9 ff ff       	jmp    80105aba <alltraps>

80106147 <vector48>:
.globl vector48
vector48:
  pushl $0
80106147:	6a 00                	push   $0x0
  pushl $48
80106149:	6a 30                	push   $0x30
  jmp alltraps
8010614b:	e9 6a f9 ff ff       	jmp    80105aba <alltraps>

80106150 <vector49>:
.globl vector49
vector49:
  pushl $0
80106150:	6a 00                	push   $0x0
  pushl $49
80106152:	6a 31                	push   $0x31
  jmp alltraps
80106154:	e9 61 f9 ff ff       	jmp    80105aba <alltraps>

80106159 <vector50>:
.globl vector50
vector50:
  pushl $0
80106159:	6a 00                	push   $0x0
  pushl $50
8010615b:	6a 32                	push   $0x32
  jmp alltraps
8010615d:	e9 58 f9 ff ff       	jmp    80105aba <alltraps>

80106162 <vector51>:
.globl vector51
vector51:
  pushl $0
80106162:	6a 00                	push   $0x0
  pushl $51
80106164:	6a 33                	push   $0x33
  jmp alltraps
80106166:	e9 4f f9 ff ff       	jmp    80105aba <alltraps>

8010616b <vector52>:
.globl vector52
vector52:
  pushl $0
8010616b:	6a 00                	push   $0x0
  pushl $52
8010616d:	6a 34                	push   $0x34
  jmp alltraps
8010616f:	e9 46 f9 ff ff       	jmp    80105aba <alltraps>

80106174 <vector53>:
.globl vector53
vector53:
  pushl $0
80106174:	6a 00                	push   $0x0
  pushl $53
80106176:	6a 35                	push   $0x35
  jmp alltraps
80106178:	e9 3d f9 ff ff       	jmp    80105aba <alltraps>

8010617d <vector54>:
.globl vector54
vector54:
  pushl $0
8010617d:	6a 00                	push   $0x0
  pushl $54
8010617f:	6a 36                	push   $0x36
  jmp alltraps
80106181:	e9 34 f9 ff ff       	jmp    80105aba <alltraps>

80106186 <vector55>:
.globl vector55
vector55:
  pushl $0
80106186:	6a 00                	push   $0x0
  pushl $55
80106188:	6a 37                	push   $0x37
  jmp alltraps
8010618a:	e9 2b f9 ff ff       	jmp    80105aba <alltraps>

8010618f <vector56>:
.globl vector56
vector56:
  pushl $0
8010618f:	6a 00                	push   $0x0
  pushl $56
80106191:	6a 38                	push   $0x38
  jmp alltraps
80106193:	e9 22 f9 ff ff       	jmp    80105aba <alltraps>

80106198 <vector57>:
.globl vector57
vector57:
  pushl $0
80106198:	6a 00                	push   $0x0
  pushl $57
8010619a:	6a 39                	push   $0x39
  jmp alltraps
8010619c:	e9 19 f9 ff ff       	jmp    80105aba <alltraps>

801061a1 <vector58>:
.globl vector58
vector58:
  pushl $0
801061a1:	6a 00                	push   $0x0
  pushl $58
801061a3:	6a 3a                	push   $0x3a
  jmp alltraps
801061a5:	e9 10 f9 ff ff       	jmp    80105aba <alltraps>

801061aa <vector59>:
.globl vector59
vector59:
  pushl $0
801061aa:	6a 00                	push   $0x0
  pushl $59
801061ac:	6a 3b                	push   $0x3b
  jmp alltraps
801061ae:	e9 07 f9 ff ff       	jmp    80105aba <alltraps>

801061b3 <vector60>:
.globl vector60
vector60:
  pushl $0
801061b3:	6a 00                	push   $0x0
  pushl $60
801061b5:	6a 3c                	push   $0x3c
  jmp alltraps
801061b7:	e9 fe f8 ff ff       	jmp    80105aba <alltraps>

801061bc <vector61>:
.globl vector61
vector61:
  pushl $0
801061bc:	6a 00                	push   $0x0
  pushl $61
801061be:	6a 3d                	push   $0x3d
  jmp alltraps
801061c0:	e9 f5 f8 ff ff       	jmp    80105aba <alltraps>

801061c5 <vector62>:
.globl vector62
vector62:
  pushl $0
801061c5:	6a 00                	push   $0x0
  pushl $62
801061c7:	6a 3e                	push   $0x3e
  jmp alltraps
801061c9:	e9 ec f8 ff ff       	jmp    80105aba <alltraps>

801061ce <vector63>:
.globl vector63
vector63:
  pushl $0
801061ce:	6a 00                	push   $0x0
  pushl $63
801061d0:	6a 3f                	push   $0x3f
  jmp alltraps
801061d2:	e9 e3 f8 ff ff       	jmp    80105aba <alltraps>

801061d7 <vector64>:
.globl vector64
vector64:
  pushl $0
801061d7:	6a 00                	push   $0x0
  pushl $64
801061d9:	6a 40                	push   $0x40
  jmp alltraps
801061db:	e9 da f8 ff ff       	jmp    80105aba <alltraps>

801061e0 <vector65>:
.globl vector65
vector65:
  pushl $0
801061e0:	6a 00                	push   $0x0
  pushl $65
801061e2:	6a 41                	push   $0x41
  jmp alltraps
801061e4:	e9 d1 f8 ff ff       	jmp    80105aba <alltraps>

801061e9 <vector66>:
.globl vector66
vector66:
  pushl $0
801061e9:	6a 00                	push   $0x0
  pushl $66
801061eb:	6a 42                	push   $0x42
  jmp alltraps
801061ed:	e9 c8 f8 ff ff       	jmp    80105aba <alltraps>

801061f2 <vector67>:
.globl vector67
vector67:
  pushl $0
801061f2:	6a 00                	push   $0x0
  pushl $67
801061f4:	6a 43                	push   $0x43
  jmp alltraps
801061f6:	e9 bf f8 ff ff       	jmp    80105aba <alltraps>

801061fb <vector68>:
.globl vector68
vector68:
  pushl $0
801061fb:	6a 00                	push   $0x0
  pushl $68
801061fd:	6a 44                	push   $0x44
  jmp alltraps
801061ff:	e9 b6 f8 ff ff       	jmp    80105aba <alltraps>

80106204 <vector69>:
.globl vector69
vector69:
  pushl $0
80106204:	6a 00                	push   $0x0
  pushl $69
80106206:	6a 45                	push   $0x45
  jmp alltraps
80106208:	e9 ad f8 ff ff       	jmp    80105aba <alltraps>

8010620d <vector70>:
.globl vector70
vector70:
  pushl $0
8010620d:	6a 00                	push   $0x0
  pushl $70
8010620f:	6a 46                	push   $0x46
  jmp alltraps
80106211:	e9 a4 f8 ff ff       	jmp    80105aba <alltraps>

80106216 <vector71>:
.globl vector71
vector71:
  pushl $0
80106216:	6a 00                	push   $0x0
  pushl $71
80106218:	6a 47                	push   $0x47
  jmp alltraps
8010621a:	e9 9b f8 ff ff       	jmp    80105aba <alltraps>

8010621f <vector72>:
.globl vector72
vector72:
  pushl $0
8010621f:	6a 00                	push   $0x0
  pushl $72
80106221:	6a 48                	push   $0x48
  jmp alltraps
80106223:	e9 92 f8 ff ff       	jmp    80105aba <alltraps>

80106228 <vector73>:
.globl vector73
vector73:
  pushl $0
80106228:	6a 00                	push   $0x0
  pushl $73
8010622a:	6a 49                	push   $0x49
  jmp alltraps
8010622c:	e9 89 f8 ff ff       	jmp    80105aba <alltraps>

80106231 <vector74>:
.globl vector74
vector74:
  pushl $0
80106231:	6a 00                	push   $0x0
  pushl $74
80106233:	6a 4a                	push   $0x4a
  jmp alltraps
80106235:	e9 80 f8 ff ff       	jmp    80105aba <alltraps>

8010623a <vector75>:
.globl vector75
vector75:
  pushl $0
8010623a:	6a 00                	push   $0x0
  pushl $75
8010623c:	6a 4b                	push   $0x4b
  jmp alltraps
8010623e:	e9 77 f8 ff ff       	jmp    80105aba <alltraps>

80106243 <vector76>:
.globl vector76
vector76:
  pushl $0
80106243:	6a 00                	push   $0x0
  pushl $76
80106245:	6a 4c                	push   $0x4c
  jmp alltraps
80106247:	e9 6e f8 ff ff       	jmp    80105aba <alltraps>

8010624c <vector77>:
.globl vector77
vector77:
  pushl $0
8010624c:	6a 00                	push   $0x0
  pushl $77
8010624e:	6a 4d                	push   $0x4d
  jmp alltraps
80106250:	e9 65 f8 ff ff       	jmp    80105aba <alltraps>

80106255 <vector78>:
.globl vector78
vector78:
  pushl $0
80106255:	6a 00                	push   $0x0
  pushl $78
80106257:	6a 4e                	push   $0x4e
  jmp alltraps
80106259:	e9 5c f8 ff ff       	jmp    80105aba <alltraps>

8010625e <vector79>:
.globl vector79
vector79:
  pushl $0
8010625e:	6a 00                	push   $0x0
  pushl $79
80106260:	6a 4f                	push   $0x4f
  jmp alltraps
80106262:	e9 53 f8 ff ff       	jmp    80105aba <alltraps>

80106267 <vector80>:
.globl vector80
vector80:
  pushl $0
80106267:	6a 00                	push   $0x0
  pushl $80
80106269:	6a 50                	push   $0x50
  jmp alltraps
8010626b:	e9 4a f8 ff ff       	jmp    80105aba <alltraps>

80106270 <vector81>:
.globl vector81
vector81:
  pushl $0
80106270:	6a 00                	push   $0x0
  pushl $81
80106272:	6a 51                	push   $0x51
  jmp alltraps
80106274:	e9 41 f8 ff ff       	jmp    80105aba <alltraps>

80106279 <vector82>:
.globl vector82
vector82:
  pushl $0
80106279:	6a 00                	push   $0x0
  pushl $82
8010627b:	6a 52                	push   $0x52
  jmp alltraps
8010627d:	e9 38 f8 ff ff       	jmp    80105aba <alltraps>

80106282 <vector83>:
.globl vector83
vector83:
  pushl $0
80106282:	6a 00                	push   $0x0
  pushl $83
80106284:	6a 53                	push   $0x53
  jmp alltraps
80106286:	e9 2f f8 ff ff       	jmp    80105aba <alltraps>

8010628b <vector84>:
.globl vector84
vector84:
  pushl $0
8010628b:	6a 00                	push   $0x0
  pushl $84
8010628d:	6a 54                	push   $0x54
  jmp alltraps
8010628f:	e9 26 f8 ff ff       	jmp    80105aba <alltraps>

80106294 <vector85>:
.globl vector85
vector85:
  pushl $0
80106294:	6a 00                	push   $0x0
  pushl $85
80106296:	6a 55                	push   $0x55
  jmp alltraps
80106298:	e9 1d f8 ff ff       	jmp    80105aba <alltraps>

8010629d <vector86>:
.globl vector86
vector86:
  pushl $0
8010629d:	6a 00                	push   $0x0
  pushl $86
8010629f:	6a 56                	push   $0x56
  jmp alltraps
801062a1:	e9 14 f8 ff ff       	jmp    80105aba <alltraps>

801062a6 <vector87>:
.globl vector87
vector87:
  pushl $0
801062a6:	6a 00                	push   $0x0
  pushl $87
801062a8:	6a 57                	push   $0x57
  jmp alltraps
801062aa:	e9 0b f8 ff ff       	jmp    80105aba <alltraps>

801062af <vector88>:
.globl vector88
vector88:
  pushl $0
801062af:	6a 00                	push   $0x0
  pushl $88
801062b1:	6a 58                	push   $0x58
  jmp alltraps
801062b3:	e9 02 f8 ff ff       	jmp    80105aba <alltraps>

801062b8 <vector89>:
.globl vector89
vector89:
  pushl $0
801062b8:	6a 00                	push   $0x0
  pushl $89
801062ba:	6a 59                	push   $0x59
  jmp alltraps
801062bc:	e9 f9 f7 ff ff       	jmp    80105aba <alltraps>

801062c1 <vector90>:
.globl vector90
vector90:
  pushl $0
801062c1:	6a 00                	push   $0x0
  pushl $90
801062c3:	6a 5a                	push   $0x5a
  jmp alltraps
801062c5:	e9 f0 f7 ff ff       	jmp    80105aba <alltraps>

801062ca <vector91>:
.globl vector91
vector91:
  pushl $0
801062ca:	6a 00                	push   $0x0
  pushl $91
801062cc:	6a 5b                	push   $0x5b
  jmp alltraps
801062ce:	e9 e7 f7 ff ff       	jmp    80105aba <alltraps>

801062d3 <vector92>:
.globl vector92
vector92:
  pushl $0
801062d3:	6a 00                	push   $0x0
  pushl $92
801062d5:	6a 5c                	push   $0x5c
  jmp alltraps
801062d7:	e9 de f7 ff ff       	jmp    80105aba <alltraps>

801062dc <vector93>:
.globl vector93
vector93:
  pushl $0
801062dc:	6a 00                	push   $0x0
  pushl $93
801062de:	6a 5d                	push   $0x5d
  jmp alltraps
801062e0:	e9 d5 f7 ff ff       	jmp    80105aba <alltraps>

801062e5 <vector94>:
.globl vector94
vector94:
  pushl $0
801062e5:	6a 00                	push   $0x0
  pushl $94
801062e7:	6a 5e                	push   $0x5e
  jmp alltraps
801062e9:	e9 cc f7 ff ff       	jmp    80105aba <alltraps>

801062ee <vector95>:
.globl vector95
vector95:
  pushl $0
801062ee:	6a 00                	push   $0x0
  pushl $95
801062f0:	6a 5f                	push   $0x5f
  jmp alltraps
801062f2:	e9 c3 f7 ff ff       	jmp    80105aba <alltraps>

801062f7 <vector96>:
.globl vector96
vector96:
  pushl $0
801062f7:	6a 00                	push   $0x0
  pushl $96
801062f9:	6a 60                	push   $0x60
  jmp alltraps
801062fb:	e9 ba f7 ff ff       	jmp    80105aba <alltraps>

80106300 <vector97>:
.globl vector97
vector97:
  pushl $0
80106300:	6a 00                	push   $0x0
  pushl $97
80106302:	6a 61                	push   $0x61
  jmp alltraps
80106304:	e9 b1 f7 ff ff       	jmp    80105aba <alltraps>

80106309 <vector98>:
.globl vector98
vector98:
  pushl $0
80106309:	6a 00                	push   $0x0
  pushl $98
8010630b:	6a 62                	push   $0x62
  jmp alltraps
8010630d:	e9 a8 f7 ff ff       	jmp    80105aba <alltraps>

80106312 <vector99>:
.globl vector99
vector99:
  pushl $0
80106312:	6a 00                	push   $0x0
  pushl $99
80106314:	6a 63                	push   $0x63
  jmp alltraps
80106316:	e9 9f f7 ff ff       	jmp    80105aba <alltraps>

8010631b <vector100>:
.globl vector100
vector100:
  pushl $0
8010631b:	6a 00                	push   $0x0
  pushl $100
8010631d:	6a 64                	push   $0x64
  jmp alltraps
8010631f:	e9 96 f7 ff ff       	jmp    80105aba <alltraps>

80106324 <vector101>:
.globl vector101
vector101:
  pushl $0
80106324:	6a 00                	push   $0x0
  pushl $101
80106326:	6a 65                	push   $0x65
  jmp alltraps
80106328:	e9 8d f7 ff ff       	jmp    80105aba <alltraps>

8010632d <vector102>:
.globl vector102
vector102:
  pushl $0
8010632d:	6a 00                	push   $0x0
  pushl $102
8010632f:	6a 66                	push   $0x66
  jmp alltraps
80106331:	e9 84 f7 ff ff       	jmp    80105aba <alltraps>

80106336 <vector103>:
.globl vector103
vector103:
  pushl $0
80106336:	6a 00                	push   $0x0
  pushl $103
80106338:	6a 67                	push   $0x67
  jmp alltraps
8010633a:	e9 7b f7 ff ff       	jmp    80105aba <alltraps>

8010633f <vector104>:
.globl vector104
vector104:
  pushl $0
8010633f:	6a 00                	push   $0x0
  pushl $104
80106341:	6a 68                	push   $0x68
  jmp alltraps
80106343:	e9 72 f7 ff ff       	jmp    80105aba <alltraps>

80106348 <vector105>:
.globl vector105
vector105:
  pushl $0
80106348:	6a 00                	push   $0x0
  pushl $105
8010634a:	6a 69                	push   $0x69
  jmp alltraps
8010634c:	e9 69 f7 ff ff       	jmp    80105aba <alltraps>

80106351 <vector106>:
.globl vector106
vector106:
  pushl $0
80106351:	6a 00                	push   $0x0
  pushl $106
80106353:	6a 6a                	push   $0x6a
  jmp alltraps
80106355:	e9 60 f7 ff ff       	jmp    80105aba <alltraps>

8010635a <vector107>:
.globl vector107
vector107:
  pushl $0
8010635a:	6a 00                	push   $0x0
  pushl $107
8010635c:	6a 6b                	push   $0x6b
  jmp alltraps
8010635e:	e9 57 f7 ff ff       	jmp    80105aba <alltraps>

80106363 <vector108>:
.globl vector108
vector108:
  pushl $0
80106363:	6a 00                	push   $0x0
  pushl $108
80106365:	6a 6c                	push   $0x6c
  jmp alltraps
80106367:	e9 4e f7 ff ff       	jmp    80105aba <alltraps>

8010636c <vector109>:
.globl vector109
vector109:
  pushl $0
8010636c:	6a 00                	push   $0x0
  pushl $109
8010636e:	6a 6d                	push   $0x6d
  jmp alltraps
80106370:	e9 45 f7 ff ff       	jmp    80105aba <alltraps>

80106375 <vector110>:
.globl vector110
vector110:
  pushl $0
80106375:	6a 00                	push   $0x0
  pushl $110
80106377:	6a 6e                	push   $0x6e
  jmp alltraps
80106379:	e9 3c f7 ff ff       	jmp    80105aba <alltraps>

8010637e <vector111>:
.globl vector111
vector111:
  pushl $0
8010637e:	6a 00                	push   $0x0
  pushl $111
80106380:	6a 6f                	push   $0x6f
  jmp alltraps
80106382:	e9 33 f7 ff ff       	jmp    80105aba <alltraps>

80106387 <vector112>:
.globl vector112
vector112:
  pushl $0
80106387:	6a 00                	push   $0x0
  pushl $112
80106389:	6a 70                	push   $0x70
  jmp alltraps
8010638b:	e9 2a f7 ff ff       	jmp    80105aba <alltraps>

80106390 <vector113>:
.globl vector113
vector113:
  pushl $0
80106390:	6a 00                	push   $0x0
  pushl $113
80106392:	6a 71                	push   $0x71
  jmp alltraps
80106394:	e9 21 f7 ff ff       	jmp    80105aba <alltraps>

80106399 <vector114>:
.globl vector114
vector114:
  pushl $0
80106399:	6a 00                	push   $0x0
  pushl $114
8010639b:	6a 72                	push   $0x72
  jmp alltraps
8010639d:	e9 18 f7 ff ff       	jmp    80105aba <alltraps>

801063a2 <vector115>:
.globl vector115
vector115:
  pushl $0
801063a2:	6a 00                	push   $0x0
  pushl $115
801063a4:	6a 73                	push   $0x73
  jmp alltraps
801063a6:	e9 0f f7 ff ff       	jmp    80105aba <alltraps>

801063ab <vector116>:
.globl vector116
vector116:
  pushl $0
801063ab:	6a 00                	push   $0x0
  pushl $116
801063ad:	6a 74                	push   $0x74
  jmp alltraps
801063af:	e9 06 f7 ff ff       	jmp    80105aba <alltraps>

801063b4 <vector117>:
.globl vector117
vector117:
  pushl $0
801063b4:	6a 00                	push   $0x0
  pushl $117
801063b6:	6a 75                	push   $0x75
  jmp alltraps
801063b8:	e9 fd f6 ff ff       	jmp    80105aba <alltraps>

801063bd <vector118>:
.globl vector118
vector118:
  pushl $0
801063bd:	6a 00                	push   $0x0
  pushl $118
801063bf:	6a 76                	push   $0x76
  jmp alltraps
801063c1:	e9 f4 f6 ff ff       	jmp    80105aba <alltraps>

801063c6 <vector119>:
.globl vector119
vector119:
  pushl $0
801063c6:	6a 00                	push   $0x0
  pushl $119
801063c8:	6a 77                	push   $0x77
  jmp alltraps
801063ca:	e9 eb f6 ff ff       	jmp    80105aba <alltraps>

801063cf <vector120>:
.globl vector120
vector120:
  pushl $0
801063cf:	6a 00                	push   $0x0
  pushl $120
801063d1:	6a 78                	push   $0x78
  jmp alltraps
801063d3:	e9 e2 f6 ff ff       	jmp    80105aba <alltraps>

801063d8 <vector121>:
.globl vector121
vector121:
  pushl $0
801063d8:	6a 00                	push   $0x0
  pushl $121
801063da:	6a 79                	push   $0x79
  jmp alltraps
801063dc:	e9 d9 f6 ff ff       	jmp    80105aba <alltraps>

801063e1 <vector122>:
.globl vector122
vector122:
  pushl $0
801063e1:	6a 00                	push   $0x0
  pushl $122
801063e3:	6a 7a                	push   $0x7a
  jmp alltraps
801063e5:	e9 d0 f6 ff ff       	jmp    80105aba <alltraps>

801063ea <vector123>:
.globl vector123
vector123:
  pushl $0
801063ea:	6a 00                	push   $0x0
  pushl $123
801063ec:	6a 7b                	push   $0x7b
  jmp alltraps
801063ee:	e9 c7 f6 ff ff       	jmp    80105aba <alltraps>

801063f3 <vector124>:
.globl vector124
vector124:
  pushl $0
801063f3:	6a 00                	push   $0x0
  pushl $124
801063f5:	6a 7c                	push   $0x7c
  jmp alltraps
801063f7:	e9 be f6 ff ff       	jmp    80105aba <alltraps>

801063fc <vector125>:
.globl vector125
vector125:
  pushl $0
801063fc:	6a 00                	push   $0x0
  pushl $125
801063fe:	6a 7d                	push   $0x7d
  jmp alltraps
80106400:	e9 b5 f6 ff ff       	jmp    80105aba <alltraps>

80106405 <vector126>:
.globl vector126
vector126:
  pushl $0
80106405:	6a 00                	push   $0x0
  pushl $126
80106407:	6a 7e                	push   $0x7e
  jmp alltraps
80106409:	e9 ac f6 ff ff       	jmp    80105aba <alltraps>

8010640e <vector127>:
.globl vector127
vector127:
  pushl $0
8010640e:	6a 00                	push   $0x0
  pushl $127
80106410:	6a 7f                	push   $0x7f
  jmp alltraps
80106412:	e9 a3 f6 ff ff       	jmp    80105aba <alltraps>

80106417 <vector128>:
.globl vector128
vector128:
  pushl $0
80106417:	6a 00                	push   $0x0
  pushl $128
80106419:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010641e:	e9 97 f6 ff ff       	jmp    80105aba <alltraps>

80106423 <vector129>:
.globl vector129
vector129:
  pushl $0
80106423:	6a 00                	push   $0x0
  pushl $129
80106425:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010642a:	e9 8b f6 ff ff       	jmp    80105aba <alltraps>

8010642f <vector130>:
.globl vector130
vector130:
  pushl $0
8010642f:	6a 00                	push   $0x0
  pushl $130
80106431:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106436:	e9 7f f6 ff ff       	jmp    80105aba <alltraps>

8010643b <vector131>:
.globl vector131
vector131:
  pushl $0
8010643b:	6a 00                	push   $0x0
  pushl $131
8010643d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106442:	e9 73 f6 ff ff       	jmp    80105aba <alltraps>

80106447 <vector132>:
.globl vector132
vector132:
  pushl $0
80106447:	6a 00                	push   $0x0
  pushl $132
80106449:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010644e:	e9 67 f6 ff ff       	jmp    80105aba <alltraps>

80106453 <vector133>:
.globl vector133
vector133:
  pushl $0
80106453:	6a 00                	push   $0x0
  pushl $133
80106455:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010645a:	e9 5b f6 ff ff       	jmp    80105aba <alltraps>

8010645f <vector134>:
.globl vector134
vector134:
  pushl $0
8010645f:	6a 00                	push   $0x0
  pushl $134
80106461:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106466:	e9 4f f6 ff ff       	jmp    80105aba <alltraps>

8010646b <vector135>:
.globl vector135
vector135:
  pushl $0
8010646b:	6a 00                	push   $0x0
  pushl $135
8010646d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106472:	e9 43 f6 ff ff       	jmp    80105aba <alltraps>

80106477 <vector136>:
.globl vector136
vector136:
  pushl $0
80106477:	6a 00                	push   $0x0
  pushl $136
80106479:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010647e:	e9 37 f6 ff ff       	jmp    80105aba <alltraps>

80106483 <vector137>:
.globl vector137
vector137:
  pushl $0
80106483:	6a 00                	push   $0x0
  pushl $137
80106485:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010648a:	e9 2b f6 ff ff       	jmp    80105aba <alltraps>

8010648f <vector138>:
.globl vector138
vector138:
  pushl $0
8010648f:	6a 00                	push   $0x0
  pushl $138
80106491:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106496:	e9 1f f6 ff ff       	jmp    80105aba <alltraps>

8010649b <vector139>:
.globl vector139
vector139:
  pushl $0
8010649b:	6a 00                	push   $0x0
  pushl $139
8010649d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801064a2:	e9 13 f6 ff ff       	jmp    80105aba <alltraps>

801064a7 <vector140>:
.globl vector140
vector140:
  pushl $0
801064a7:	6a 00                	push   $0x0
  pushl $140
801064a9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801064ae:	e9 07 f6 ff ff       	jmp    80105aba <alltraps>

801064b3 <vector141>:
.globl vector141
vector141:
  pushl $0
801064b3:	6a 00                	push   $0x0
  pushl $141
801064b5:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
801064ba:	e9 fb f5 ff ff       	jmp    80105aba <alltraps>

801064bf <vector142>:
.globl vector142
vector142:
  pushl $0
801064bf:	6a 00                	push   $0x0
  pushl $142
801064c1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801064c6:	e9 ef f5 ff ff       	jmp    80105aba <alltraps>

801064cb <vector143>:
.globl vector143
vector143:
  pushl $0
801064cb:	6a 00                	push   $0x0
  pushl $143
801064cd:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801064d2:	e9 e3 f5 ff ff       	jmp    80105aba <alltraps>

801064d7 <vector144>:
.globl vector144
vector144:
  pushl $0
801064d7:	6a 00                	push   $0x0
  pushl $144
801064d9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801064de:	e9 d7 f5 ff ff       	jmp    80105aba <alltraps>

801064e3 <vector145>:
.globl vector145
vector145:
  pushl $0
801064e3:	6a 00                	push   $0x0
  pushl $145
801064e5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801064ea:	e9 cb f5 ff ff       	jmp    80105aba <alltraps>

801064ef <vector146>:
.globl vector146
vector146:
  pushl $0
801064ef:	6a 00                	push   $0x0
  pushl $146
801064f1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801064f6:	e9 bf f5 ff ff       	jmp    80105aba <alltraps>

801064fb <vector147>:
.globl vector147
vector147:
  pushl $0
801064fb:	6a 00                	push   $0x0
  pushl $147
801064fd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106502:	e9 b3 f5 ff ff       	jmp    80105aba <alltraps>

80106507 <vector148>:
.globl vector148
vector148:
  pushl $0
80106507:	6a 00                	push   $0x0
  pushl $148
80106509:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010650e:	e9 a7 f5 ff ff       	jmp    80105aba <alltraps>

80106513 <vector149>:
.globl vector149
vector149:
  pushl $0
80106513:	6a 00                	push   $0x0
  pushl $149
80106515:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010651a:	e9 9b f5 ff ff       	jmp    80105aba <alltraps>

8010651f <vector150>:
.globl vector150
vector150:
  pushl $0
8010651f:	6a 00                	push   $0x0
  pushl $150
80106521:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106526:	e9 8f f5 ff ff       	jmp    80105aba <alltraps>

8010652b <vector151>:
.globl vector151
vector151:
  pushl $0
8010652b:	6a 00                	push   $0x0
  pushl $151
8010652d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106532:	e9 83 f5 ff ff       	jmp    80105aba <alltraps>

80106537 <vector152>:
.globl vector152
vector152:
  pushl $0
80106537:	6a 00                	push   $0x0
  pushl $152
80106539:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010653e:	e9 77 f5 ff ff       	jmp    80105aba <alltraps>

80106543 <vector153>:
.globl vector153
vector153:
  pushl $0
80106543:	6a 00                	push   $0x0
  pushl $153
80106545:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010654a:	e9 6b f5 ff ff       	jmp    80105aba <alltraps>

8010654f <vector154>:
.globl vector154
vector154:
  pushl $0
8010654f:	6a 00                	push   $0x0
  pushl $154
80106551:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106556:	e9 5f f5 ff ff       	jmp    80105aba <alltraps>

8010655b <vector155>:
.globl vector155
vector155:
  pushl $0
8010655b:	6a 00                	push   $0x0
  pushl $155
8010655d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106562:	e9 53 f5 ff ff       	jmp    80105aba <alltraps>

80106567 <vector156>:
.globl vector156
vector156:
  pushl $0
80106567:	6a 00                	push   $0x0
  pushl $156
80106569:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
8010656e:	e9 47 f5 ff ff       	jmp    80105aba <alltraps>

80106573 <vector157>:
.globl vector157
vector157:
  pushl $0
80106573:	6a 00                	push   $0x0
  pushl $157
80106575:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
8010657a:	e9 3b f5 ff ff       	jmp    80105aba <alltraps>

8010657f <vector158>:
.globl vector158
vector158:
  pushl $0
8010657f:	6a 00                	push   $0x0
  pushl $158
80106581:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106586:	e9 2f f5 ff ff       	jmp    80105aba <alltraps>

8010658b <vector159>:
.globl vector159
vector159:
  pushl $0
8010658b:	6a 00                	push   $0x0
  pushl $159
8010658d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106592:	e9 23 f5 ff ff       	jmp    80105aba <alltraps>

80106597 <vector160>:
.globl vector160
vector160:
  pushl $0
80106597:	6a 00                	push   $0x0
  pushl $160
80106599:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
8010659e:	e9 17 f5 ff ff       	jmp    80105aba <alltraps>

801065a3 <vector161>:
.globl vector161
vector161:
  pushl $0
801065a3:	6a 00                	push   $0x0
  pushl $161
801065a5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801065aa:	e9 0b f5 ff ff       	jmp    80105aba <alltraps>

801065af <vector162>:
.globl vector162
vector162:
  pushl $0
801065af:	6a 00                	push   $0x0
  pushl $162
801065b1:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
801065b6:	e9 ff f4 ff ff       	jmp    80105aba <alltraps>

801065bb <vector163>:
.globl vector163
vector163:
  pushl $0
801065bb:	6a 00                	push   $0x0
  pushl $163
801065bd:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
801065c2:	e9 f3 f4 ff ff       	jmp    80105aba <alltraps>

801065c7 <vector164>:
.globl vector164
vector164:
  pushl $0
801065c7:	6a 00                	push   $0x0
  pushl $164
801065c9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
801065ce:	e9 e7 f4 ff ff       	jmp    80105aba <alltraps>

801065d3 <vector165>:
.globl vector165
vector165:
  pushl $0
801065d3:	6a 00                	push   $0x0
  pushl $165
801065d5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
801065da:	e9 db f4 ff ff       	jmp    80105aba <alltraps>

801065df <vector166>:
.globl vector166
vector166:
  pushl $0
801065df:	6a 00                	push   $0x0
  pushl $166
801065e1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
801065e6:	e9 cf f4 ff ff       	jmp    80105aba <alltraps>

801065eb <vector167>:
.globl vector167
vector167:
  pushl $0
801065eb:	6a 00                	push   $0x0
  pushl $167
801065ed:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
801065f2:	e9 c3 f4 ff ff       	jmp    80105aba <alltraps>

801065f7 <vector168>:
.globl vector168
vector168:
  pushl $0
801065f7:	6a 00                	push   $0x0
  pushl $168
801065f9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
801065fe:	e9 b7 f4 ff ff       	jmp    80105aba <alltraps>

80106603 <vector169>:
.globl vector169
vector169:
  pushl $0
80106603:	6a 00                	push   $0x0
  pushl $169
80106605:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010660a:	e9 ab f4 ff ff       	jmp    80105aba <alltraps>

8010660f <vector170>:
.globl vector170
vector170:
  pushl $0
8010660f:	6a 00                	push   $0x0
  pushl $170
80106611:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106616:	e9 9f f4 ff ff       	jmp    80105aba <alltraps>

8010661b <vector171>:
.globl vector171
vector171:
  pushl $0
8010661b:	6a 00                	push   $0x0
  pushl $171
8010661d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106622:	e9 93 f4 ff ff       	jmp    80105aba <alltraps>

80106627 <vector172>:
.globl vector172
vector172:
  pushl $0
80106627:	6a 00                	push   $0x0
  pushl $172
80106629:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010662e:	e9 87 f4 ff ff       	jmp    80105aba <alltraps>

80106633 <vector173>:
.globl vector173
vector173:
  pushl $0
80106633:	6a 00                	push   $0x0
  pushl $173
80106635:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010663a:	e9 7b f4 ff ff       	jmp    80105aba <alltraps>

8010663f <vector174>:
.globl vector174
vector174:
  pushl $0
8010663f:	6a 00                	push   $0x0
  pushl $174
80106641:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106646:	e9 6f f4 ff ff       	jmp    80105aba <alltraps>

8010664b <vector175>:
.globl vector175
vector175:
  pushl $0
8010664b:	6a 00                	push   $0x0
  pushl $175
8010664d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106652:	e9 63 f4 ff ff       	jmp    80105aba <alltraps>

80106657 <vector176>:
.globl vector176
vector176:
  pushl $0
80106657:	6a 00                	push   $0x0
  pushl $176
80106659:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
8010665e:	e9 57 f4 ff ff       	jmp    80105aba <alltraps>

80106663 <vector177>:
.globl vector177
vector177:
  pushl $0
80106663:	6a 00                	push   $0x0
  pushl $177
80106665:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
8010666a:	e9 4b f4 ff ff       	jmp    80105aba <alltraps>

8010666f <vector178>:
.globl vector178
vector178:
  pushl $0
8010666f:	6a 00                	push   $0x0
  pushl $178
80106671:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106676:	e9 3f f4 ff ff       	jmp    80105aba <alltraps>

8010667b <vector179>:
.globl vector179
vector179:
  pushl $0
8010667b:	6a 00                	push   $0x0
  pushl $179
8010667d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106682:	e9 33 f4 ff ff       	jmp    80105aba <alltraps>

80106687 <vector180>:
.globl vector180
vector180:
  pushl $0
80106687:	6a 00                	push   $0x0
  pushl $180
80106689:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
8010668e:	e9 27 f4 ff ff       	jmp    80105aba <alltraps>

80106693 <vector181>:
.globl vector181
vector181:
  pushl $0
80106693:	6a 00                	push   $0x0
  pushl $181
80106695:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
8010669a:	e9 1b f4 ff ff       	jmp    80105aba <alltraps>

8010669f <vector182>:
.globl vector182
vector182:
  pushl $0
8010669f:	6a 00                	push   $0x0
  pushl $182
801066a1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801066a6:	e9 0f f4 ff ff       	jmp    80105aba <alltraps>

801066ab <vector183>:
.globl vector183
vector183:
  pushl $0
801066ab:	6a 00                	push   $0x0
  pushl $183
801066ad:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
801066b2:	e9 03 f4 ff ff       	jmp    80105aba <alltraps>

801066b7 <vector184>:
.globl vector184
vector184:
  pushl $0
801066b7:	6a 00                	push   $0x0
  pushl $184
801066b9:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
801066be:	e9 f7 f3 ff ff       	jmp    80105aba <alltraps>

801066c3 <vector185>:
.globl vector185
vector185:
  pushl $0
801066c3:	6a 00                	push   $0x0
  pushl $185
801066c5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
801066ca:	e9 eb f3 ff ff       	jmp    80105aba <alltraps>

801066cf <vector186>:
.globl vector186
vector186:
  pushl $0
801066cf:	6a 00                	push   $0x0
  pushl $186
801066d1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
801066d6:	e9 df f3 ff ff       	jmp    80105aba <alltraps>

801066db <vector187>:
.globl vector187
vector187:
  pushl $0
801066db:	6a 00                	push   $0x0
  pushl $187
801066dd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
801066e2:	e9 d3 f3 ff ff       	jmp    80105aba <alltraps>

801066e7 <vector188>:
.globl vector188
vector188:
  pushl $0
801066e7:	6a 00                	push   $0x0
  pushl $188
801066e9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
801066ee:	e9 c7 f3 ff ff       	jmp    80105aba <alltraps>

801066f3 <vector189>:
.globl vector189
vector189:
  pushl $0
801066f3:	6a 00                	push   $0x0
  pushl $189
801066f5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
801066fa:	e9 bb f3 ff ff       	jmp    80105aba <alltraps>

801066ff <vector190>:
.globl vector190
vector190:
  pushl $0
801066ff:	6a 00                	push   $0x0
  pushl $190
80106701:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106706:	e9 af f3 ff ff       	jmp    80105aba <alltraps>

8010670b <vector191>:
.globl vector191
vector191:
  pushl $0
8010670b:	6a 00                	push   $0x0
  pushl $191
8010670d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106712:	e9 a3 f3 ff ff       	jmp    80105aba <alltraps>

80106717 <vector192>:
.globl vector192
vector192:
  pushl $0
80106717:	6a 00                	push   $0x0
  pushl $192
80106719:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010671e:	e9 97 f3 ff ff       	jmp    80105aba <alltraps>

80106723 <vector193>:
.globl vector193
vector193:
  pushl $0
80106723:	6a 00                	push   $0x0
  pushl $193
80106725:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010672a:	e9 8b f3 ff ff       	jmp    80105aba <alltraps>

8010672f <vector194>:
.globl vector194
vector194:
  pushl $0
8010672f:	6a 00                	push   $0x0
  pushl $194
80106731:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106736:	e9 7f f3 ff ff       	jmp    80105aba <alltraps>

8010673b <vector195>:
.globl vector195
vector195:
  pushl $0
8010673b:	6a 00                	push   $0x0
  pushl $195
8010673d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106742:	e9 73 f3 ff ff       	jmp    80105aba <alltraps>

80106747 <vector196>:
.globl vector196
vector196:
  pushl $0
80106747:	6a 00                	push   $0x0
  pushl $196
80106749:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010674e:	e9 67 f3 ff ff       	jmp    80105aba <alltraps>

80106753 <vector197>:
.globl vector197
vector197:
  pushl $0
80106753:	6a 00                	push   $0x0
  pushl $197
80106755:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
8010675a:	e9 5b f3 ff ff       	jmp    80105aba <alltraps>

8010675f <vector198>:
.globl vector198
vector198:
  pushl $0
8010675f:	6a 00                	push   $0x0
  pushl $198
80106761:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106766:	e9 4f f3 ff ff       	jmp    80105aba <alltraps>

8010676b <vector199>:
.globl vector199
vector199:
  pushl $0
8010676b:	6a 00                	push   $0x0
  pushl $199
8010676d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106772:	e9 43 f3 ff ff       	jmp    80105aba <alltraps>

80106777 <vector200>:
.globl vector200
vector200:
  pushl $0
80106777:	6a 00                	push   $0x0
  pushl $200
80106779:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
8010677e:	e9 37 f3 ff ff       	jmp    80105aba <alltraps>

80106783 <vector201>:
.globl vector201
vector201:
  pushl $0
80106783:	6a 00                	push   $0x0
  pushl $201
80106785:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
8010678a:	e9 2b f3 ff ff       	jmp    80105aba <alltraps>

8010678f <vector202>:
.globl vector202
vector202:
  pushl $0
8010678f:	6a 00                	push   $0x0
  pushl $202
80106791:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106796:	e9 1f f3 ff ff       	jmp    80105aba <alltraps>

8010679b <vector203>:
.globl vector203
vector203:
  pushl $0
8010679b:	6a 00                	push   $0x0
  pushl $203
8010679d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801067a2:	e9 13 f3 ff ff       	jmp    80105aba <alltraps>

801067a7 <vector204>:
.globl vector204
vector204:
  pushl $0
801067a7:	6a 00                	push   $0x0
  pushl $204
801067a9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801067ae:	e9 07 f3 ff ff       	jmp    80105aba <alltraps>

801067b3 <vector205>:
.globl vector205
vector205:
  pushl $0
801067b3:	6a 00                	push   $0x0
  pushl $205
801067b5:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
801067ba:	e9 fb f2 ff ff       	jmp    80105aba <alltraps>

801067bf <vector206>:
.globl vector206
vector206:
  pushl $0
801067bf:	6a 00                	push   $0x0
  pushl $206
801067c1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
801067c6:	e9 ef f2 ff ff       	jmp    80105aba <alltraps>

801067cb <vector207>:
.globl vector207
vector207:
  pushl $0
801067cb:	6a 00                	push   $0x0
  pushl $207
801067cd:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
801067d2:	e9 e3 f2 ff ff       	jmp    80105aba <alltraps>

801067d7 <vector208>:
.globl vector208
vector208:
  pushl $0
801067d7:	6a 00                	push   $0x0
  pushl $208
801067d9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
801067de:	e9 d7 f2 ff ff       	jmp    80105aba <alltraps>

801067e3 <vector209>:
.globl vector209
vector209:
  pushl $0
801067e3:	6a 00                	push   $0x0
  pushl $209
801067e5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
801067ea:	e9 cb f2 ff ff       	jmp    80105aba <alltraps>

801067ef <vector210>:
.globl vector210
vector210:
  pushl $0
801067ef:	6a 00                	push   $0x0
  pushl $210
801067f1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
801067f6:	e9 bf f2 ff ff       	jmp    80105aba <alltraps>

801067fb <vector211>:
.globl vector211
vector211:
  pushl $0
801067fb:	6a 00                	push   $0x0
  pushl $211
801067fd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106802:	e9 b3 f2 ff ff       	jmp    80105aba <alltraps>

80106807 <vector212>:
.globl vector212
vector212:
  pushl $0
80106807:	6a 00                	push   $0x0
  pushl $212
80106809:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010680e:	e9 a7 f2 ff ff       	jmp    80105aba <alltraps>

80106813 <vector213>:
.globl vector213
vector213:
  pushl $0
80106813:	6a 00                	push   $0x0
  pushl $213
80106815:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010681a:	e9 9b f2 ff ff       	jmp    80105aba <alltraps>

8010681f <vector214>:
.globl vector214
vector214:
  pushl $0
8010681f:	6a 00                	push   $0x0
  pushl $214
80106821:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106826:	e9 8f f2 ff ff       	jmp    80105aba <alltraps>

8010682b <vector215>:
.globl vector215
vector215:
  pushl $0
8010682b:	6a 00                	push   $0x0
  pushl $215
8010682d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106832:	e9 83 f2 ff ff       	jmp    80105aba <alltraps>

80106837 <vector216>:
.globl vector216
vector216:
  pushl $0
80106837:	6a 00                	push   $0x0
  pushl $216
80106839:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010683e:	e9 77 f2 ff ff       	jmp    80105aba <alltraps>

80106843 <vector217>:
.globl vector217
vector217:
  pushl $0
80106843:	6a 00                	push   $0x0
  pushl $217
80106845:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010684a:	e9 6b f2 ff ff       	jmp    80105aba <alltraps>

8010684f <vector218>:
.globl vector218
vector218:
  pushl $0
8010684f:	6a 00                	push   $0x0
  pushl $218
80106851:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106856:	e9 5f f2 ff ff       	jmp    80105aba <alltraps>

8010685b <vector219>:
.globl vector219
vector219:
  pushl $0
8010685b:	6a 00                	push   $0x0
  pushl $219
8010685d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106862:	e9 53 f2 ff ff       	jmp    80105aba <alltraps>

80106867 <vector220>:
.globl vector220
vector220:
  pushl $0
80106867:	6a 00                	push   $0x0
  pushl $220
80106869:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
8010686e:	e9 47 f2 ff ff       	jmp    80105aba <alltraps>

80106873 <vector221>:
.globl vector221
vector221:
  pushl $0
80106873:	6a 00                	push   $0x0
  pushl $221
80106875:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
8010687a:	e9 3b f2 ff ff       	jmp    80105aba <alltraps>

8010687f <vector222>:
.globl vector222
vector222:
  pushl $0
8010687f:	6a 00                	push   $0x0
  pushl $222
80106881:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106886:	e9 2f f2 ff ff       	jmp    80105aba <alltraps>

8010688b <vector223>:
.globl vector223
vector223:
  pushl $0
8010688b:	6a 00                	push   $0x0
  pushl $223
8010688d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106892:	e9 23 f2 ff ff       	jmp    80105aba <alltraps>

80106897 <vector224>:
.globl vector224
vector224:
  pushl $0
80106897:	6a 00                	push   $0x0
  pushl $224
80106899:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
8010689e:	e9 17 f2 ff ff       	jmp    80105aba <alltraps>

801068a3 <vector225>:
.globl vector225
vector225:
  pushl $0
801068a3:	6a 00                	push   $0x0
  pushl $225
801068a5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801068aa:	e9 0b f2 ff ff       	jmp    80105aba <alltraps>

801068af <vector226>:
.globl vector226
vector226:
  pushl $0
801068af:	6a 00                	push   $0x0
  pushl $226
801068b1:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
801068b6:	e9 ff f1 ff ff       	jmp    80105aba <alltraps>

801068bb <vector227>:
.globl vector227
vector227:
  pushl $0
801068bb:	6a 00                	push   $0x0
  pushl $227
801068bd:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
801068c2:	e9 f3 f1 ff ff       	jmp    80105aba <alltraps>

801068c7 <vector228>:
.globl vector228
vector228:
  pushl $0
801068c7:	6a 00                	push   $0x0
  pushl $228
801068c9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
801068ce:	e9 e7 f1 ff ff       	jmp    80105aba <alltraps>

801068d3 <vector229>:
.globl vector229
vector229:
  pushl $0
801068d3:	6a 00                	push   $0x0
  pushl $229
801068d5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
801068da:	e9 db f1 ff ff       	jmp    80105aba <alltraps>

801068df <vector230>:
.globl vector230
vector230:
  pushl $0
801068df:	6a 00                	push   $0x0
  pushl $230
801068e1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
801068e6:	e9 cf f1 ff ff       	jmp    80105aba <alltraps>

801068eb <vector231>:
.globl vector231
vector231:
  pushl $0
801068eb:	6a 00                	push   $0x0
  pushl $231
801068ed:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
801068f2:	e9 c3 f1 ff ff       	jmp    80105aba <alltraps>

801068f7 <vector232>:
.globl vector232
vector232:
  pushl $0
801068f7:	6a 00                	push   $0x0
  pushl $232
801068f9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
801068fe:	e9 b7 f1 ff ff       	jmp    80105aba <alltraps>

80106903 <vector233>:
.globl vector233
vector233:
  pushl $0
80106903:	6a 00                	push   $0x0
  pushl $233
80106905:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010690a:	e9 ab f1 ff ff       	jmp    80105aba <alltraps>

8010690f <vector234>:
.globl vector234
vector234:
  pushl $0
8010690f:	6a 00                	push   $0x0
  pushl $234
80106911:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106916:	e9 9f f1 ff ff       	jmp    80105aba <alltraps>

8010691b <vector235>:
.globl vector235
vector235:
  pushl $0
8010691b:	6a 00                	push   $0x0
  pushl $235
8010691d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106922:	e9 93 f1 ff ff       	jmp    80105aba <alltraps>

80106927 <vector236>:
.globl vector236
vector236:
  pushl $0
80106927:	6a 00                	push   $0x0
  pushl $236
80106929:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010692e:	e9 87 f1 ff ff       	jmp    80105aba <alltraps>

80106933 <vector237>:
.globl vector237
vector237:
  pushl $0
80106933:	6a 00                	push   $0x0
  pushl $237
80106935:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010693a:	e9 7b f1 ff ff       	jmp    80105aba <alltraps>

8010693f <vector238>:
.globl vector238
vector238:
  pushl $0
8010693f:	6a 00                	push   $0x0
  pushl $238
80106941:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106946:	e9 6f f1 ff ff       	jmp    80105aba <alltraps>

8010694b <vector239>:
.globl vector239
vector239:
  pushl $0
8010694b:	6a 00                	push   $0x0
  pushl $239
8010694d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106952:	e9 63 f1 ff ff       	jmp    80105aba <alltraps>

80106957 <vector240>:
.globl vector240
vector240:
  pushl $0
80106957:	6a 00                	push   $0x0
  pushl $240
80106959:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
8010695e:	e9 57 f1 ff ff       	jmp    80105aba <alltraps>

80106963 <vector241>:
.globl vector241
vector241:
  pushl $0
80106963:	6a 00                	push   $0x0
  pushl $241
80106965:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
8010696a:	e9 4b f1 ff ff       	jmp    80105aba <alltraps>

8010696f <vector242>:
.globl vector242
vector242:
  pushl $0
8010696f:	6a 00                	push   $0x0
  pushl $242
80106971:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106976:	e9 3f f1 ff ff       	jmp    80105aba <alltraps>

8010697b <vector243>:
.globl vector243
vector243:
  pushl $0
8010697b:	6a 00                	push   $0x0
  pushl $243
8010697d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106982:	e9 33 f1 ff ff       	jmp    80105aba <alltraps>

80106987 <vector244>:
.globl vector244
vector244:
  pushl $0
80106987:	6a 00                	push   $0x0
  pushl $244
80106989:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
8010698e:	e9 27 f1 ff ff       	jmp    80105aba <alltraps>

80106993 <vector245>:
.globl vector245
vector245:
  pushl $0
80106993:	6a 00                	push   $0x0
  pushl $245
80106995:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
8010699a:	e9 1b f1 ff ff       	jmp    80105aba <alltraps>

8010699f <vector246>:
.globl vector246
vector246:
  pushl $0
8010699f:	6a 00                	push   $0x0
  pushl $246
801069a1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801069a6:	e9 0f f1 ff ff       	jmp    80105aba <alltraps>

801069ab <vector247>:
.globl vector247
vector247:
  pushl $0
801069ab:	6a 00                	push   $0x0
  pushl $247
801069ad:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
801069b2:	e9 03 f1 ff ff       	jmp    80105aba <alltraps>

801069b7 <vector248>:
.globl vector248
vector248:
  pushl $0
801069b7:	6a 00                	push   $0x0
  pushl $248
801069b9:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
801069be:	e9 f7 f0 ff ff       	jmp    80105aba <alltraps>

801069c3 <vector249>:
.globl vector249
vector249:
  pushl $0
801069c3:	6a 00                	push   $0x0
  pushl $249
801069c5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
801069ca:	e9 eb f0 ff ff       	jmp    80105aba <alltraps>

801069cf <vector250>:
.globl vector250
vector250:
  pushl $0
801069cf:	6a 00                	push   $0x0
  pushl $250
801069d1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
801069d6:	e9 df f0 ff ff       	jmp    80105aba <alltraps>

801069db <vector251>:
.globl vector251
vector251:
  pushl $0
801069db:	6a 00                	push   $0x0
  pushl $251
801069dd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
801069e2:	e9 d3 f0 ff ff       	jmp    80105aba <alltraps>

801069e7 <vector252>:
.globl vector252
vector252:
  pushl $0
801069e7:	6a 00                	push   $0x0
  pushl $252
801069e9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
801069ee:	e9 c7 f0 ff ff       	jmp    80105aba <alltraps>

801069f3 <vector253>:
.globl vector253
vector253:
  pushl $0
801069f3:	6a 00                	push   $0x0
  pushl $253
801069f5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
801069fa:	e9 bb f0 ff ff       	jmp    80105aba <alltraps>

801069ff <vector254>:
.globl vector254
vector254:
  pushl $0
801069ff:	6a 00                	push   $0x0
  pushl $254
80106a01:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106a06:	e9 af f0 ff ff       	jmp    80105aba <alltraps>

80106a0b <vector255>:
.globl vector255
vector255:
  pushl $0
80106a0b:	6a 00                	push   $0x0
  pushl $255
80106a0d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106a12:	e9 a3 f0 ff ff       	jmp    80105aba <alltraps>
80106a17:	66 90                	xchg   %ax,%ax
80106a19:	66 90                	xchg   %ax,%ax
80106a1b:	66 90                	xchg   %ax,%ax
80106a1d:	66 90                	xchg   %ax,%ax
80106a1f:	90                   	nop

80106a20 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a20:	55                   	push   %ebp
80106a21:	89 e5                	mov    %esp,%ebp
80106a23:	57                   	push   %edi
80106a24:	56                   	push   %esi
80106a25:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106a26:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
80106a2c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106a32:	83 ec 1c             	sub    $0x1c,%esp
  for(; a  < oldsz; a += PGSIZE){
80106a35:	39 d3                	cmp    %edx,%ebx
80106a37:	73 56                	jae    80106a8f <deallocuvm.part.0+0x6f>
80106a39:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80106a3c:	89 c6                	mov    %eax,%esi
80106a3e:	89 d7                	mov    %edx,%edi
80106a40:	eb 12                	jmp    80106a54 <deallocuvm.part.0+0x34>
80106a42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106a48:	83 c2 01             	add    $0x1,%edx
80106a4b:	89 d3                	mov    %edx,%ebx
80106a4d:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
80106a50:	39 fb                	cmp    %edi,%ebx
80106a52:	73 38                	jae    80106a8c <deallocuvm.part.0+0x6c>
  pde = &pgdir[PDX(va)];
80106a54:	89 da                	mov    %ebx,%edx
80106a56:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
80106a59:	8b 04 96             	mov    (%esi,%edx,4),%eax
80106a5c:	a8 01                	test   $0x1,%al
80106a5e:	74 e8                	je     80106a48 <deallocuvm.part.0+0x28>
  return &pgtab[PTX(va)];
80106a60:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106a62:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106a67:	c1 e9 0a             	shr    $0xa,%ecx
80106a6a:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
80106a70:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
80106a77:	85 c0                	test   %eax,%eax
80106a79:	74 cd                	je     80106a48 <deallocuvm.part.0+0x28>
    else if((*pte & PTE_P) != 0){
80106a7b:	8b 10                	mov    (%eax),%edx
80106a7d:	f6 c2 01             	test   $0x1,%dl
80106a80:	75 1e                	jne    80106aa0 <deallocuvm.part.0+0x80>
  for(; a  < oldsz; a += PGSIZE){
80106a82:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106a88:	39 fb                	cmp    %edi,%ebx
80106a8a:	72 c8                	jb     80106a54 <deallocuvm.part.0+0x34>
80106a8c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
80106a8f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106a92:	89 c8                	mov    %ecx,%eax
80106a94:	5b                   	pop    %ebx
80106a95:	5e                   	pop    %esi
80106a96:	5f                   	pop    %edi
80106a97:	5d                   	pop    %ebp
80106a98:	c3                   	ret
80106a99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(pa == 0)
80106aa0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80106aa6:	74 26                	je     80106ace <deallocuvm.part.0+0xae>
      kfree(v);
80106aa8:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
80106aab:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106ab1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106ab4:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
80106aba:	52                   	push   %edx
80106abb:	e8 50 bc ff ff       	call   80102710 <kfree>
      *pte = 0;
80106ac0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(; a  < oldsz; a += PGSIZE){
80106ac3:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80106ac6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80106acc:	eb 82                	jmp    80106a50 <deallocuvm.part.0+0x30>
        panic("kfree");
80106ace:	83 ec 0c             	sub    $0xc,%esp
80106ad1:	68 ac 75 10 80       	push   $0x801075ac
80106ad6:	e8 a5 98 ff ff       	call   80100380 <panic>
80106adb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80106ae0 <mappages>:
{
80106ae0:	55                   	push   %ebp
80106ae1:	89 e5                	mov    %esp,%ebp
80106ae3:	57                   	push   %edi
80106ae4:	56                   	push   %esi
80106ae5:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106ae6:	89 d3                	mov    %edx,%ebx
80106ae8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106aee:	83 ec 1c             	sub    $0x1c,%esp
80106af1:	89 45 e0             	mov    %eax,-0x20(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106af4:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106af8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106afd:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106b00:	8b 45 08             	mov    0x8(%ebp),%eax
80106b03:	29 d8                	sub    %ebx,%eax
80106b05:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106b08:	eb 3f                	jmp    80106b49 <mappages+0x69>
80106b0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106b10:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106b12:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106b17:	c1 ea 0a             	shr    $0xa,%edx
80106b1a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106b20:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106b27:	85 c0                	test   %eax,%eax
80106b29:	74 75                	je     80106ba0 <mappages+0xc0>
    if(*pte & PTE_P)
80106b2b:	f6 00 01             	testb  $0x1,(%eax)
80106b2e:	0f 85 86 00 00 00    	jne    80106bba <mappages+0xda>
    *pte = pa | perm | PTE_P;
80106b34:	0b 75 0c             	or     0xc(%ebp),%esi
80106b37:	83 ce 01             	or     $0x1,%esi
80106b3a:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106b3c:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106b3f:	39 c3                	cmp    %eax,%ebx
80106b41:	74 6d                	je     80106bb0 <mappages+0xd0>
    a += PGSIZE;
80106b43:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80106b49:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
80106b4c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80106b4f:	8d 34 03             	lea    (%ebx,%eax,1),%esi
80106b52:	89 d8                	mov    %ebx,%eax
80106b54:	c1 e8 16             	shr    $0x16,%eax
80106b57:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
80106b5a:	8b 07                	mov    (%edi),%eax
80106b5c:	a8 01                	test   $0x1,%al
80106b5e:	75 b0                	jne    80106b10 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106b60:	e8 6b bd ff ff       	call   801028d0 <kalloc>
80106b65:	85 c0                	test   %eax,%eax
80106b67:	74 37                	je     80106ba0 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
80106b69:	83 ec 04             	sub    $0x4,%esp
80106b6c:	68 00 10 00 00       	push   $0x1000
80106b71:	6a 00                	push   $0x0
80106b73:	50                   	push   %eax
80106b74:	89 45 d8             	mov    %eax,-0x28(%ebp)
80106b77:	e8 a4 dd ff ff       	call   80104920 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106b7c:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
80106b7f:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106b82:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80106b88:	83 c8 07             	or     $0x7,%eax
80106b8b:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
80106b8d:	89 d8                	mov    %ebx,%eax
80106b8f:	c1 e8 0a             	shr    $0xa,%eax
80106b92:	25 fc 0f 00 00       	and    $0xffc,%eax
80106b97:	01 d0                	add    %edx,%eax
80106b99:	eb 90                	jmp    80106b2b <mappages+0x4b>
80106b9b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
}
80106ba0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106ba3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106ba8:	5b                   	pop    %ebx
80106ba9:	5e                   	pop    %esi
80106baa:	5f                   	pop    %edi
80106bab:	5d                   	pop    %ebp
80106bac:	c3                   	ret
80106bad:	8d 76 00             	lea    0x0(%esi),%esi
80106bb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106bb3:	31 c0                	xor    %eax,%eax
}
80106bb5:	5b                   	pop    %ebx
80106bb6:	5e                   	pop    %esi
80106bb7:	5f                   	pop    %edi
80106bb8:	5d                   	pop    %ebp
80106bb9:	c3                   	ret
      panic("remap");
80106bba:	83 ec 0c             	sub    $0xc,%esp
80106bbd:	68 e0 77 10 80       	push   $0x801077e0
80106bc2:	e8 b9 97 ff ff       	call   80100380 <panic>
80106bc7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106bce:	00 
80106bcf:	90                   	nop

80106bd0 <seginit>:
{
80106bd0:	55                   	push   %ebp
80106bd1:	89 e5                	mov    %esp,%ebp
80106bd3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106bd6:	e8 e5 cf ff ff       	call   80103bc0 <cpuid>
  pd[0] = size-1;
80106bdb:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106be0:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106be6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
80106bea:	c7 80 58 19 11 80 ff 	movl   $0xffff,-0x7feee6a8(%eax)
80106bf1:	ff 00 00 
80106bf4:	c7 80 5c 19 11 80 00 	movl   $0xcf9a00,-0x7feee6a4(%eax)
80106bfb:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106bfe:	c7 80 60 19 11 80 ff 	movl   $0xffff,-0x7feee6a0(%eax)
80106c05:	ff 00 00 
80106c08:	c7 80 64 19 11 80 00 	movl   $0xcf9200,-0x7feee69c(%eax)
80106c0f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106c12:	c7 80 68 19 11 80 ff 	movl   $0xffff,-0x7feee698(%eax)
80106c19:	ff 00 00 
80106c1c:	c7 80 6c 19 11 80 00 	movl   $0xcffa00,-0x7feee694(%eax)
80106c23:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106c26:	c7 80 70 19 11 80 ff 	movl   $0xffff,-0x7feee690(%eax)
80106c2d:	ff 00 00 
80106c30:	c7 80 74 19 11 80 00 	movl   $0xcff200,-0x7feee68c(%eax)
80106c37:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106c3a:	05 50 19 11 80       	add    $0x80111950,%eax
  pd[1] = (uint)p;
80106c3f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106c43:	c1 e8 10             	shr    $0x10,%eax
80106c46:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106c4a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106c4d:	0f 01 10             	lgdtl  (%eax)
}
80106c50:	c9                   	leave
80106c51:	c3                   	ret
80106c52:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106c59:	00 
80106c5a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106c60 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106c60:	a1 04 46 11 80       	mov    0x80114604,%eax
80106c65:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106c6a:	0f 22 d8             	mov    %eax,%cr3
}
80106c6d:	c3                   	ret
80106c6e:	66 90                	xchg   %ax,%ax

80106c70 <switchuvm>:
{
80106c70:	55                   	push   %ebp
80106c71:	89 e5                	mov    %esp,%ebp
80106c73:	57                   	push   %edi
80106c74:	56                   	push   %esi
80106c75:	53                   	push   %ebx
80106c76:	83 ec 1c             	sub    $0x1c,%esp
80106c79:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106c7c:	85 f6                	test   %esi,%esi
80106c7e:	0f 84 cb 00 00 00    	je     80106d4f <switchuvm+0xdf>
  if(p->kstack == 0)
80106c84:	8b 46 08             	mov    0x8(%esi),%eax
80106c87:	85 c0                	test   %eax,%eax
80106c89:	0f 84 da 00 00 00    	je     80106d69 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106c8f:	8b 46 04             	mov    0x4(%esi),%eax
80106c92:	85 c0                	test   %eax,%eax
80106c94:	0f 84 c2 00 00 00    	je     80106d5c <switchuvm+0xec>
  pushcli();
80106c9a:	e8 31 da ff ff       	call   801046d0 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106c9f:	e8 bc ce ff ff       	call   80103b60 <mycpu>
80106ca4:	89 c3                	mov    %eax,%ebx
80106ca6:	e8 b5 ce ff ff       	call   80103b60 <mycpu>
80106cab:	89 c7                	mov    %eax,%edi
80106cad:	e8 ae ce ff ff       	call   80103b60 <mycpu>
80106cb2:	83 c7 08             	add    $0x8,%edi
80106cb5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106cb8:	e8 a3 ce ff ff       	call   80103b60 <mycpu>
80106cbd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106cc0:	ba 67 00 00 00       	mov    $0x67,%edx
80106cc5:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106ccc:	83 c0 08             	add    $0x8,%eax
80106ccf:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106cd6:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106cdb:	83 c1 08             	add    $0x8,%ecx
80106cde:	c1 e8 18             	shr    $0x18,%eax
80106ce1:	c1 e9 10             	shr    $0x10,%ecx
80106ce4:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106cea:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106cf0:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106cf5:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106cfc:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80106d01:	e8 5a ce ff ff       	call   80103b60 <mycpu>
80106d06:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106d0d:	e8 4e ce ff ff       	call   80103b60 <mycpu>
80106d12:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106d16:	8b 5e 08             	mov    0x8(%esi),%ebx
80106d19:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106d1f:	e8 3c ce ff ff       	call   80103b60 <mycpu>
80106d24:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106d27:	e8 34 ce ff ff       	call   80103b60 <mycpu>
80106d2c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106d30:	b8 28 00 00 00       	mov    $0x28,%eax
80106d35:	0f 00 d8             	ltr    %eax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106d38:	8b 46 04             	mov    0x4(%esi),%eax
80106d3b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106d40:	0f 22 d8             	mov    %eax,%cr3
}
80106d43:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106d46:	5b                   	pop    %ebx
80106d47:	5e                   	pop    %esi
80106d48:	5f                   	pop    %edi
80106d49:	5d                   	pop    %ebp
  popcli();
80106d4a:	e9 d1 d9 ff ff       	jmp    80104720 <popcli>
    panic("switchuvm: no process");
80106d4f:	83 ec 0c             	sub    $0xc,%esp
80106d52:	68 e6 77 10 80       	push   $0x801077e6
80106d57:	e8 24 96 ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
80106d5c:	83 ec 0c             	sub    $0xc,%esp
80106d5f:	68 11 78 10 80       	push   $0x80107811
80106d64:	e8 17 96 ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
80106d69:	83 ec 0c             	sub    $0xc,%esp
80106d6c:	68 fc 77 10 80       	push   $0x801077fc
80106d71:	e8 0a 96 ff ff       	call   80100380 <panic>
80106d76:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106d7d:	00 
80106d7e:	66 90                	xchg   %ax,%ax

80106d80 <inituvm>:
{
80106d80:	55                   	push   %ebp
80106d81:	89 e5                	mov    %esp,%ebp
80106d83:	57                   	push   %edi
80106d84:	56                   	push   %esi
80106d85:	53                   	push   %ebx
80106d86:	83 ec 1c             	sub    $0x1c,%esp
80106d89:	8b 45 08             	mov    0x8(%ebp),%eax
80106d8c:	8b 75 10             	mov    0x10(%ebp),%esi
80106d8f:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106d92:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106d95:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106d9b:	77 49                	ja     80106de6 <inituvm+0x66>
  mem = kalloc();
80106d9d:	e8 2e bb ff ff       	call   801028d0 <kalloc>
  memset(mem, 0, PGSIZE);
80106da2:	83 ec 04             	sub    $0x4,%esp
80106da5:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
80106daa:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106dac:	6a 00                	push   $0x0
80106dae:	50                   	push   %eax
80106daf:	e8 6c db ff ff       	call   80104920 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106db4:	58                   	pop    %eax
80106db5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106dbb:	5a                   	pop    %edx
80106dbc:	6a 06                	push   $0x6
80106dbe:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106dc3:	31 d2                	xor    %edx,%edx
80106dc5:	50                   	push   %eax
80106dc6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106dc9:	e8 12 fd ff ff       	call   80106ae0 <mappages>
  memmove(mem, init, sz);
80106dce:	83 c4 10             	add    $0x10,%esp
80106dd1:	89 75 10             	mov    %esi,0x10(%ebp)
80106dd4:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106dd7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106dda:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ddd:	5b                   	pop    %ebx
80106dde:	5e                   	pop    %esi
80106ddf:	5f                   	pop    %edi
80106de0:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106de1:	e9 ca db ff ff       	jmp    801049b0 <memmove>
    panic("inituvm: more than a page");
80106de6:	83 ec 0c             	sub    $0xc,%esp
80106de9:	68 25 78 10 80       	push   $0x80107825
80106dee:	e8 8d 95 ff ff       	call   80100380 <panic>
80106df3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106dfa:	00 
80106dfb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80106e00 <loaduvm>:
{
80106e00:	55                   	push   %ebp
80106e01:	89 e5                	mov    %esp,%ebp
80106e03:	57                   	push   %edi
80106e04:	56                   	push   %esi
80106e05:	53                   	push   %ebx
80106e06:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106e09:	8b 75 0c             	mov    0xc(%ebp),%esi
{
80106e0c:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
80106e0f:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
80106e15:	0f 85 a2 00 00 00    	jne    80106ebd <loaduvm+0xbd>
  for(i = 0; i < sz; i += PGSIZE){
80106e1b:	85 ff                	test   %edi,%edi
80106e1d:	74 7d                	je     80106e9c <loaduvm+0x9c>
80106e1f:	90                   	nop
  pde = &pgdir[PDX(va)];
80106e20:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80106e23:	8b 55 08             	mov    0x8(%ebp),%edx
80106e26:	01 f0                	add    %esi,%eax
  pde = &pgdir[PDX(va)];
80106e28:	89 c1                	mov    %eax,%ecx
80106e2a:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80106e2d:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
80106e30:	f6 c1 01             	test   $0x1,%cl
80106e33:	75 13                	jne    80106e48 <loaduvm+0x48>
      panic("loaduvm: address should exist");
80106e35:	83 ec 0c             	sub    $0xc,%esp
80106e38:	68 3f 78 10 80       	push   $0x8010783f
80106e3d:	e8 3e 95 ff ff       	call   80100380 <panic>
80106e42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106e48:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106e4b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80106e51:	25 fc 0f 00 00       	and    $0xffc,%eax
80106e56:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106e5d:	85 c9                	test   %ecx,%ecx
80106e5f:	74 d4                	je     80106e35 <loaduvm+0x35>
    if(sz - i < PGSIZE)
80106e61:	89 fb                	mov    %edi,%ebx
80106e63:	b8 00 10 00 00       	mov    $0x1000,%eax
80106e68:	29 f3                	sub    %esi,%ebx
80106e6a:	39 c3                	cmp    %eax,%ebx
80106e6c:	0f 47 d8             	cmova  %eax,%ebx
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106e6f:	53                   	push   %ebx
80106e70:	8b 45 14             	mov    0x14(%ebp),%eax
80106e73:	01 f0                	add    %esi,%eax
80106e75:	50                   	push   %eax
    pa = PTE_ADDR(*pte);
80106e76:	8b 01                	mov    (%ecx),%eax
80106e78:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106e7d:	05 00 00 00 80       	add    $0x80000000,%eax
80106e82:	50                   	push   %eax
80106e83:	ff 75 10             	push   0x10(%ebp)
80106e86:	e8 95 ae ff ff       	call   80101d20 <readi>
80106e8b:	83 c4 10             	add    $0x10,%esp
80106e8e:	39 d8                	cmp    %ebx,%eax
80106e90:	75 1e                	jne    80106eb0 <loaduvm+0xb0>
  for(i = 0; i < sz; i += PGSIZE){
80106e92:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106e98:	39 fe                	cmp    %edi,%esi
80106e9a:	72 84                	jb     80106e20 <loaduvm+0x20>
}
80106e9c:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106e9f:	31 c0                	xor    %eax,%eax
}
80106ea1:	5b                   	pop    %ebx
80106ea2:	5e                   	pop    %esi
80106ea3:	5f                   	pop    %edi
80106ea4:	5d                   	pop    %ebp
80106ea5:	c3                   	ret
80106ea6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106ead:	00 
80106eae:	66 90                	xchg   %ax,%ax
80106eb0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106eb3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106eb8:	5b                   	pop    %ebx
80106eb9:	5e                   	pop    %esi
80106eba:	5f                   	pop    %edi
80106ebb:	5d                   	pop    %ebp
80106ebc:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
80106ebd:	83 ec 0c             	sub    $0xc,%esp
80106ec0:	68 b0 7a 10 80       	push   $0x80107ab0
80106ec5:	e8 b6 94 ff ff       	call   80100380 <panic>
80106eca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106ed0 <allocuvm>:
{
80106ed0:	55                   	push   %ebp
80106ed1:	89 e5                	mov    %esp,%ebp
80106ed3:	57                   	push   %edi
80106ed4:	56                   	push   %esi
80106ed5:	53                   	push   %ebx
80106ed6:	83 ec 1c             	sub    $0x1c,%esp
80106ed9:	8b 75 10             	mov    0x10(%ebp),%esi
  if(newsz >= KERNBASE)
80106edc:	85 f6                	test   %esi,%esi
80106ede:	0f 88 98 00 00 00    	js     80106f7c <allocuvm+0xac>
80106ee4:	89 f2                	mov    %esi,%edx
  if(newsz < oldsz)
80106ee6:	3b 75 0c             	cmp    0xc(%ebp),%esi
80106ee9:	0f 82 a1 00 00 00    	jb     80106f90 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80106eef:	8b 45 0c             	mov    0xc(%ebp),%eax
80106ef2:	05 ff 0f 00 00       	add    $0xfff,%eax
80106ef7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106efc:	89 c7                	mov    %eax,%edi
  for(; a < newsz; a += PGSIZE){
80106efe:	39 f0                	cmp    %esi,%eax
80106f00:	0f 83 8d 00 00 00    	jae    80106f93 <allocuvm+0xc3>
80106f06:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80106f09:	eb 44                	jmp    80106f4f <allocuvm+0x7f>
80106f0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80106f10:	83 ec 04             	sub    $0x4,%esp
80106f13:	68 00 10 00 00       	push   $0x1000
80106f18:	6a 00                	push   $0x0
80106f1a:	50                   	push   %eax
80106f1b:	e8 00 da ff ff       	call   80104920 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106f20:	58                   	pop    %eax
80106f21:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106f27:	5a                   	pop    %edx
80106f28:	6a 06                	push   $0x6
80106f2a:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106f2f:	89 fa                	mov    %edi,%edx
80106f31:	50                   	push   %eax
80106f32:	8b 45 08             	mov    0x8(%ebp),%eax
80106f35:	e8 a6 fb ff ff       	call   80106ae0 <mappages>
80106f3a:	83 c4 10             	add    $0x10,%esp
80106f3d:	85 c0                	test   %eax,%eax
80106f3f:	78 5f                	js     80106fa0 <allocuvm+0xd0>
  for(; a < newsz; a += PGSIZE){
80106f41:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106f47:	39 f7                	cmp    %esi,%edi
80106f49:	0f 83 89 00 00 00    	jae    80106fd8 <allocuvm+0x108>
    mem = kalloc();
80106f4f:	e8 7c b9 ff ff       	call   801028d0 <kalloc>
80106f54:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80106f56:	85 c0                	test   %eax,%eax
80106f58:	75 b6                	jne    80106f10 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106f5a:	83 ec 0c             	sub    $0xc,%esp
80106f5d:	68 5d 78 10 80       	push   $0x8010785d
80106f62:	e8 d9 97 ff ff       	call   80100740 <cprintf>
  if(newsz >= oldsz)
80106f67:	83 c4 10             	add    $0x10,%esp
80106f6a:	3b 75 0c             	cmp    0xc(%ebp),%esi
80106f6d:	74 0d                	je     80106f7c <allocuvm+0xac>
80106f6f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106f72:	8b 45 08             	mov    0x8(%ebp),%eax
80106f75:	89 f2                	mov    %esi,%edx
80106f77:	e8 a4 fa ff ff       	call   80106a20 <deallocuvm.part.0>
    return 0;
80106f7c:	31 d2                	xor    %edx,%edx
}
80106f7e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f81:	89 d0                	mov    %edx,%eax
80106f83:	5b                   	pop    %ebx
80106f84:	5e                   	pop    %esi
80106f85:	5f                   	pop    %edi
80106f86:	5d                   	pop    %ebp
80106f87:	c3                   	ret
80106f88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106f8f:	00 
    return oldsz;
80106f90:	8b 55 0c             	mov    0xc(%ebp),%edx
}
80106f93:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106f96:	89 d0                	mov    %edx,%eax
80106f98:	5b                   	pop    %ebx
80106f99:	5e                   	pop    %esi
80106f9a:	5f                   	pop    %edi
80106f9b:	5d                   	pop    %ebp
80106f9c:	c3                   	ret
80106f9d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106fa0:	83 ec 0c             	sub    $0xc,%esp
80106fa3:	68 75 78 10 80       	push   $0x80107875
80106fa8:	e8 93 97 ff ff       	call   80100740 <cprintf>
  if(newsz >= oldsz)
80106fad:	83 c4 10             	add    $0x10,%esp
80106fb0:	3b 75 0c             	cmp    0xc(%ebp),%esi
80106fb3:	74 0d                	je     80106fc2 <allocuvm+0xf2>
80106fb5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106fb8:	8b 45 08             	mov    0x8(%ebp),%eax
80106fbb:	89 f2                	mov    %esi,%edx
80106fbd:	e8 5e fa ff ff       	call   80106a20 <deallocuvm.part.0>
      kfree(mem);
80106fc2:	83 ec 0c             	sub    $0xc,%esp
80106fc5:	53                   	push   %ebx
80106fc6:	e8 45 b7 ff ff       	call   80102710 <kfree>
      return 0;
80106fcb:	83 c4 10             	add    $0x10,%esp
    return 0;
80106fce:	31 d2                	xor    %edx,%edx
80106fd0:	eb ac                	jmp    80106f7e <allocuvm+0xae>
80106fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106fd8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
}
80106fdb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106fde:	5b                   	pop    %ebx
80106fdf:	5e                   	pop    %esi
80106fe0:	89 d0                	mov    %edx,%eax
80106fe2:	5f                   	pop    %edi
80106fe3:	5d                   	pop    %ebp
80106fe4:	c3                   	ret
80106fe5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106fec:	00 
80106fed:	8d 76 00             	lea    0x0(%esi),%esi

80106ff0 <deallocuvm>:
{
80106ff0:	55                   	push   %ebp
80106ff1:	89 e5                	mov    %esp,%ebp
80106ff3:	8b 55 0c             	mov    0xc(%ebp),%edx
80106ff6:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106ff9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106ffc:	39 d1                	cmp    %edx,%ecx
80106ffe:	73 10                	jae    80107010 <deallocuvm+0x20>
}
80107000:	5d                   	pop    %ebp
80107001:	e9 1a fa ff ff       	jmp    80106a20 <deallocuvm.part.0>
80107006:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010700d:	00 
8010700e:	66 90                	xchg   %ax,%ax
80107010:	89 d0                	mov    %edx,%eax
80107012:	5d                   	pop    %ebp
80107013:	c3                   	ret
80107014:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010701b:	00 
8010701c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107020 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107020:	55                   	push   %ebp
80107021:	89 e5                	mov    %esp,%ebp
80107023:	57                   	push   %edi
80107024:	56                   	push   %esi
80107025:	53                   	push   %ebx
80107026:	83 ec 0c             	sub    $0xc,%esp
80107029:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010702c:	85 f6                	test   %esi,%esi
8010702e:	74 59                	je     80107089 <freevm+0x69>
  if(newsz >= oldsz)
80107030:	31 c9                	xor    %ecx,%ecx
80107032:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107037:	89 f0                	mov    %esi,%eax
80107039:	89 f3                	mov    %esi,%ebx
8010703b:	e8 e0 f9 ff ff       	call   80106a20 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107040:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107046:	eb 0f                	jmp    80107057 <freevm+0x37>
80107048:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010704f:	00 
80107050:	83 c3 04             	add    $0x4,%ebx
80107053:	39 fb                	cmp    %edi,%ebx
80107055:	74 23                	je     8010707a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107057:	8b 03                	mov    (%ebx),%eax
80107059:	a8 01                	test   $0x1,%al
8010705b:	74 f3                	je     80107050 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010705d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107062:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107065:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107068:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010706d:	50                   	push   %eax
8010706e:	e8 9d b6 ff ff       	call   80102710 <kfree>
80107073:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107076:	39 fb                	cmp    %edi,%ebx
80107078:	75 dd                	jne    80107057 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010707a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010707d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107080:	5b                   	pop    %ebx
80107081:	5e                   	pop    %esi
80107082:	5f                   	pop    %edi
80107083:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107084:	e9 87 b6 ff ff       	jmp    80102710 <kfree>
    panic("freevm: no pgdir");
80107089:	83 ec 0c             	sub    $0xc,%esp
8010708c:	68 91 78 10 80       	push   $0x80107891
80107091:	e8 ea 92 ff ff       	call   80100380 <panic>
80107096:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010709d:	00 
8010709e:	66 90                	xchg   %ax,%ax

801070a0 <setupkvm>:
{
801070a0:	55                   	push   %ebp
801070a1:	89 e5                	mov    %esp,%ebp
801070a3:	56                   	push   %esi
801070a4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
801070a5:	e8 26 b8 ff ff       	call   801028d0 <kalloc>
801070aa:	85 c0                	test   %eax,%eax
801070ac:	74 5e                	je     8010710c <setupkvm+0x6c>
  memset(pgdir, 0, PGSIZE);
801070ae:	83 ec 04             	sub    $0x4,%esp
801070b1:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801070b3:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
801070b8:	68 00 10 00 00       	push   $0x1000
801070bd:	6a 00                	push   $0x0
801070bf:	50                   	push   %eax
801070c0:	e8 5b d8 ff ff       	call   80104920 <memset>
801070c5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
801070c8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801070cb:	83 ec 08             	sub    $0x8,%esp
801070ce:	8b 4b 08             	mov    0x8(%ebx),%ecx
801070d1:	8b 13                	mov    (%ebx),%edx
801070d3:	ff 73 0c             	push   0xc(%ebx)
801070d6:	50                   	push   %eax
801070d7:	29 c1                	sub    %eax,%ecx
801070d9:	89 f0                	mov    %esi,%eax
801070db:	e8 00 fa ff ff       	call   80106ae0 <mappages>
801070e0:	83 c4 10             	add    $0x10,%esp
801070e3:	85 c0                	test   %eax,%eax
801070e5:	78 19                	js     80107100 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801070e7:	83 c3 10             	add    $0x10,%ebx
801070ea:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
801070f0:	75 d6                	jne    801070c8 <setupkvm+0x28>
}
801070f2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801070f5:	89 f0                	mov    %esi,%eax
801070f7:	5b                   	pop    %ebx
801070f8:	5e                   	pop    %esi
801070f9:	5d                   	pop    %ebp
801070fa:	c3                   	ret
801070fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80107100:	83 ec 0c             	sub    $0xc,%esp
80107103:	56                   	push   %esi
80107104:	e8 17 ff ff ff       	call   80107020 <freevm>
      return 0;
80107109:	83 c4 10             	add    $0x10,%esp
}
8010710c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
8010710f:	31 f6                	xor    %esi,%esi
}
80107111:	89 f0                	mov    %esi,%eax
80107113:	5b                   	pop    %ebx
80107114:	5e                   	pop    %esi
80107115:	5d                   	pop    %ebp
80107116:	c3                   	ret
80107117:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010711e:	00 
8010711f:	90                   	nop

80107120 <kvmalloc>:
{
80107120:	55                   	push   %ebp
80107121:	89 e5                	mov    %esp,%ebp
80107123:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107126:	e8 75 ff ff ff       	call   801070a0 <setupkvm>
8010712b:	a3 04 46 11 80       	mov    %eax,0x80114604
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107130:	05 00 00 00 80       	add    $0x80000000,%eax
80107135:	0f 22 d8             	mov    %eax,%cr3
}
80107138:	c9                   	leave
80107139:	c3                   	ret
8010713a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107140 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107140:	55                   	push   %ebp
80107141:	89 e5                	mov    %esp,%ebp
80107143:	83 ec 08             	sub    $0x8,%esp
80107146:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107149:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
8010714c:	89 c1                	mov    %eax,%ecx
8010714e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80107151:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107154:	f6 c2 01             	test   $0x1,%dl
80107157:	75 17                	jne    80107170 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80107159:	83 ec 0c             	sub    $0xc,%esp
8010715c:	68 a2 78 10 80       	push   $0x801078a2
80107161:	e8 1a 92 ff ff       	call   80100380 <panic>
80107166:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010716d:	00 
8010716e:	66 90                	xchg   %ax,%ax
  return &pgtab[PTX(va)];
80107170:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107173:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80107179:	25 fc 0f 00 00       	and    $0xffc,%eax
8010717e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80107185:	85 c0                	test   %eax,%eax
80107187:	74 d0                	je     80107159 <clearpteu+0x19>
  *pte &= ~PTE_U;
80107189:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010718c:	c9                   	leave
8010718d:	c3                   	ret
8010718e:	66 90                	xchg   %ax,%ax

80107190 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107190:	55                   	push   %ebp
80107191:	89 e5                	mov    %esp,%ebp
80107193:	57                   	push   %edi
80107194:	56                   	push   %esi
80107195:	53                   	push   %ebx
80107196:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107199:	e8 02 ff ff ff       	call   801070a0 <setupkvm>
8010719e:	89 45 e0             	mov    %eax,-0x20(%ebp)
801071a1:	85 c0                	test   %eax,%eax
801071a3:	0f 84 e9 00 00 00    	je     80107292 <copyuvm+0x102>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
801071a9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801071ac:	85 c9                	test   %ecx,%ecx
801071ae:	0f 84 b2 00 00 00    	je     80107266 <copyuvm+0xd6>
801071b4:	31 f6                	xor    %esi,%esi
801071b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801071bd:	00 
801071be:	66 90                	xchg   %ax,%ax
  if(*pde & PTE_P){
801071c0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
801071c3:	89 f0                	mov    %esi,%eax
801071c5:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
801071c8:	8b 04 81             	mov    (%ecx,%eax,4),%eax
801071cb:	a8 01                	test   $0x1,%al
801071cd:	75 11                	jne    801071e0 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
801071cf:	83 ec 0c             	sub    $0xc,%esp
801071d2:	68 ac 78 10 80       	push   $0x801078ac
801071d7:	e8 a4 91 ff ff       	call   80100380 <panic>
801071dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
801071e0:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801071e2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801071e7:	c1 ea 0a             	shr    $0xa,%edx
801071ea:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
801071f0:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801071f7:	85 c0                	test   %eax,%eax
801071f9:	74 d4                	je     801071cf <copyuvm+0x3f>
    if(!(*pte & PTE_P))
801071fb:	8b 00                	mov    (%eax),%eax
801071fd:	a8 01                	test   $0x1,%al
801071ff:	0f 84 9f 00 00 00    	je     801072a4 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107205:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107207:	25 ff 0f 00 00       	and    $0xfff,%eax
8010720c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
8010720f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107215:	e8 b6 b6 ff ff       	call   801028d0 <kalloc>
8010721a:	89 c3                	mov    %eax,%ebx
8010721c:	85 c0                	test   %eax,%eax
8010721e:	74 64                	je     80107284 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107220:	83 ec 04             	sub    $0x4,%esp
80107223:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107229:	68 00 10 00 00       	push   $0x1000
8010722e:	57                   	push   %edi
8010722f:	50                   	push   %eax
80107230:	e8 7b d7 ff ff       	call   801049b0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107235:	58                   	pop    %eax
80107236:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010723c:	5a                   	pop    %edx
8010723d:	ff 75 e4             	push   -0x1c(%ebp)
80107240:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107245:	89 f2                	mov    %esi,%edx
80107247:	50                   	push   %eax
80107248:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010724b:	e8 90 f8 ff ff       	call   80106ae0 <mappages>
80107250:	83 c4 10             	add    $0x10,%esp
80107253:	85 c0                	test   %eax,%eax
80107255:	78 21                	js     80107278 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
80107257:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010725d:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107260:	0f 82 5a ff ff ff    	jb     801071c0 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
80107266:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107269:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010726c:	5b                   	pop    %ebx
8010726d:	5e                   	pop    %esi
8010726e:	5f                   	pop    %edi
8010726f:	5d                   	pop    %ebp
80107270:	c3                   	ret
80107271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107278:	83 ec 0c             	sub    $0xc,%esp
8010727b:	53                   	push   %ebx
8010727c:	e8 8f b4 ff ff       	call   80102710 <kfree>
      goto bad;
80107281:	83 c4 10             	add    $0x10,%esp
  freevm(d);
80107284:	83 ec 0c             	sub    $0xc,%esp
80107287:	ff 75 e0             	push   -0x20(%ebp)
8010728a:	e8 91 fd ff ff       	call   80107020 <freevm>
  return 0;
8010728f:	83 c4 10             	add    $0x10,%esp
    return 0;
80107292:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107299:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010729c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010729f:	5b                   	pop    %ebx
801072a0:	5e                   	pop    %esi
801072a1:	5f                   	pop    %edi
801072a2:	5d                   	pop    %ebp
801072a3:	c3                   	ret
      panic("copyuvm: page not present");
801072a4:	83 ec 0c             	sub    $0xc,%esp
801072a7:	68 c6 78 10 80       	push   $0x801078c6
801072ac:	e8 cf 90 ff ff       	call   80100380 <panic>
801072b1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801072b8:	00 
801072b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801072c0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
801072c0:	55                   	push   %ebp
801072c1:	89 e5                	mov    %esp,%ebp
801072c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
801072c6:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
801072c9:	89 c1                	mov    %eax,%ecx
801072cb:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
801072ce:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801072d1:	f6 c2 01             	test   $0x1,%dl
801072d4:	0f 84 f8 00 00 00    	je     801073d2 <uva2ka.cold>
  return &pgtab[PTX(va)];
801072da:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801072dd:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
801072e3:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
801072e4:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
801072e9:	8b 94 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%edx
  return (char*)P2V(PTE_ADDR(*pte));
801072f0:	89 d0                	mov    %edx,%eax
801072f2:	f7 d2                	not    %edx
801072f4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801072f9:	05 00 00 00 80       	add    $0x80000000,%eax
801072fe:	83 e2 05             	and    $0x5,%edx
80107301:	ba 00 00 00 00       	mov    $0x0,%edx
80107306:	0f 45 c2             	cmovne %edx,%eax
}
80107309:	c3                   	ret
8010730a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107310 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107310:	55                   	push   %ebp
80107311:	89 e5                	mov    %esp,%ebp
80107313:	57                   	push   %edi
80107314:	56                   	push   %esi
80107315:	53                   	push   %ebx
80107316:	83 ec 0c             	sub    $0xc,%esp
80107319:	8b 75 14             	mov    0x14(%ebp),%esi
8010731c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010731f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107322:	85 f6                	test   %esi,%esi
80107324:	75 51                	jne    80107377 <copyout+0x67>
80107326:	e9 9d 00 00 00       	jmp    801073c8 <copyout+0xb8>
8010732b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  return (char*)P2V(PTE_ADDR(*pte));
80107330:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107336:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
8010733c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80107342:	74 74                	je     801073b8 <copyout+0xa8>
      return -1;
    n = PGSIZE - (va - va0);
80107344:	89 fb                	mov    %edi,%ebx
80107346:	29 c3                	sub    %eax,%ebx
80107348:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
8010734e:	39 f3                	cmp    %esi,%ebx
80107350:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
80107353:	29 f8                	sub    %edi,%eax
80107355:	83 ec 04             	sub    $0x4,%esp
80107358:	01 c1                	add    %eax,%ecx
8010735a:	53                   	push   %ebx
8010735b:	52                   	push   %edx
8010735c:	89 55 10             	mov    %edx,0x10(%ebp)
8010735f:	51                   	push   %ecx
80107360:	e8 4b d6 ff ff       	call   801049b0 <memmove>
    len -= n;
    buf += n;
80107365:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
80107368:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
8010736e:	83 c4 10             	add    $0x10,%esp
    buf += n;
80107371:	01 da                	add    %ebx,%edx
  while(len > 0){
80107373:	29 de                	sub    %ebx,%esi
80107375:	74 51                	je     801073c8 <copyout+0xb8>
  if(*pde & PTE_P){
80107377:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
8010737a:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
8010737c:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
8010737e:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
80107381:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
80107387:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
8010738a:	f6 c1 01             	test   $0x1,%cl
8010738d:	0f 84 46 00 00 00    	je     801073d9 <copyout.cold>
  return &pgtab[PTX(va)];
80107393:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107395:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
8010739b:	c1 eb 0c             	shr    $0xc,%ebx
8010739e:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
801073a4:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
801073ab:	89 d9                	mov    %ebx,%ecx
801073ad:	f7 d1                	not    %ecx
801073af:	83 e1 05             	and    $0x5,%ecx
801073b2:	0f 84 78 ff ff ff    	je     80107330 <copyout+0x20>
  }
  return 0;
}
801073b8:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801073bb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801073c0:	5b                   	pop    %ebx
801073c1:	5e                   	pop    %esi
801073c2:	5f                   	pop    %edi
801073c3:	5d                   	pop    %ebp
801073c4:	c3                   	ret
801073c5:	8d 76 00             	lea    0x0(%esi),%esi
801073c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
801073cb:	31 c0                	xor    %eax,%eax
}
801073cd:	5b                   	pop    %ebx
801073ce:	5e                   	pop    %esi
801073cf:	5f                   	pop    %edi
801073d0:	5d                   	pop    %ebp
801073d1:	c3                   	ret

801073d2 <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
801073d2:	a1 00 00 00 00       	mov    0x0,%eax
801073d7:	0f 0b                	ud2

801073d9 <copyout.cold>:
801073d9:	a1 00 00 00 00       	mov    0x0,%eax
801073de:	0f 0b                	ud2
