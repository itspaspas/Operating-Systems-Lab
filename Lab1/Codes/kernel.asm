
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
8010002d:	b8 00 31 10 80       	mov    $0x80103100,%eax
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
8010004c:	68 40 72 10 80       	push   $0x80107240
80100051:	68 20 a5 10 80       	push   $0x8010a520
80100056:	e8 25 44 00 00       	call   80104480 <initlock>
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
80100092:	68 47 72 10 80       	push   $0x80107247
80100097:	50                   	push   %eax
80100098:	e8 b3 42 00 00       	call   80104350 <initsleeplock>
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
801000e4:	e8 87 45 00 00       	call   80104670 <acquire>
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
80100162:	e8 a9 44 00 00       	call   80104610 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 1e 42 00 00       	call   80104390 <acquiresleep>
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
8010018c:	e8 0f 22 00 00       	call   801023a0 <iderw>
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
801001a1:	68 4e 72 10 80       	push   $0x8010724e
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
801001be:	e8 6d 42 00 00       	call   80104430 <holdingsleep>
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
801001d4:	e9 c7 21 00 00       	jmp    801023a0 <iderw>
    panic("bwrite");
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 5f 72 10 80       	push   $0x8010725f
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
801001ff:	e8 2c 42 00 00       	call   80104430 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 63                	je     8010026e <brelse+0x7e>
    panic("brelse");

  releasesleep(&b->lock);
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 dc 41 00 00       	call   801043f0 <releasesleep>

  acquire(&bcache.lock);
80100214:	c7 04 24 20 a5 10 80 	movl   $0x8010a520,(%esp)
8010021b:	e8 50 44 00 00       	call   80104670 <acquire>
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
80100269:	e9 a2 43 00 00       	jmp    80104610 <release>
    panic("brelse");
8010026e:	83 ec 0c             	sub    $0xc,%esp
80100271:	68 66 72 10 80       	push   $0x80107266
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
80100294:	e8 b7 16 00 00       	call   80101950 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 20 ef 10 80 	movl   $0x8010ef20,(%esp)
801002a0:	e8 cb 43 00 00       	call   80104670 <acquire>

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
801002cd:	e8 1e 3e 00 00       	call   801040f0 <sleep>
    while(input.r == input.w){
801002d2:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 49 37 00 00       	call   80103a30 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 20 ef 10 80       	push   $0x8010ef20
801002f6:	e8 15 43 00 00       	call   80104610 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 6c 15 00 00       	call   80101870 <ilock>
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
8010034c:	e8 bf 42 00 00       	call   80104610 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 16 15 00 00       	call   80101870 <ilock>
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
80100399:	e8 02 26 00 00       	call   801029a0 <lapicid>
8010039e:	83 ec 08             	sub    $0x8,%esp
801003a1:	50                   	push   %eax
801003a2:	68 6d 72 10 80       	push   $0x8010726d
801003a7:	e8 94 03 00 00       	call   80100740 <cprintf>
  cprintf(s);
801003ac:	58                   	pop    %eax
801003ad:	ff 75 08             	push   0x8(%ebp)
801003b0:	e8 8b 03 00 00       	call   80100740 <cprintf>
  cprintf("\n");
801003b5:	c7 04 24 ef 76 10 80 	movl   $0x801076ef,(%esp)
801003bc:	e8 7f 03 00 00       	call   80100740 <cprintf>
  getcallerpcs(&s, pcs);
801003c1:	8d 45 08             	lea    0x8(%ebp),%eax
801003c4:	5a                   	pop    %edx
801003c5:	59                   	pop    %ecx
801003c6:	53                   	push   %ebx
801003c7:	50                   	push   %eax
801003c8:	e8 d3 40 00 00       	call   801044a0 <getcallerpcs>
  for(i=0; i<10; i++)
801003cd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003d0:	83 ec 08             	sub    $0x8,%esp
801003d3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003d5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003d8:	68 81 72 10 80       	push   $0x80107281
801003dd:	e8 5e 03 00 00       	call   80100740 <cprintf>
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
8010050c:	e8 ef 42 00 00       	call   80104800 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100511:	b8 80 07 00 00       	mov    $0x780,%eax
80100516:	83 c4 0c             	add    $0xc,%esp
80100519:	29 f8                	sub    %edi,%eax
8010051b:	01 c0                	add    %eax,%eax
8010051d:	50                   	push   %eax
8010051e:	6a 00                	push   $0x0
80100520:	56                   	push   %esi
80100521:	e8 4a 42 00 00       	call   80104770 <memset>
  outb(CRTPORT+1, pos);
80100526:	83 c4 10             	add    $0x10,%esp
80100529:	c6 45 e4 07          	movb   $0x7,-0x1c(%ebp)
8010052d:	e9 51 ff ff ff       	jmp    80100483 <cgaputc+0x83>
    panic("pos under/overflow");
80100532:	83 ec 0c             	sub    $0xc,%esp
80100535:	68 85 72 10 80       	push   $0x80107285
8010053a:	e8 41 fe ff ff       	call   80100380 <panic>
8010053f:	90                   	nop

80100540 <consputc>:
  if (c == '\5') {
80100540:	83 f8 05             	cmp    $0x5,%eax
80100543:	74 3b                	je     80100580 <consputc+0x40>
  if (panicked) {
80100545:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
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
80100563:	e8 18 58 00 00       	call   80105d80 <uartputc>
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
80100580:	8b 0d 0c ef 10 80    	mov    0x8010ef0c,%ecx
80100586:	85 c9                	test   %ecx,%ecx
80100588:	75 15                	jne    8010059f <consputc+0x5f>
      stat = 1 ;
8010058a:	c7 05 0c ef 10 80 01 	movl   $0x1,0x8010ef0c
80100591:	00 00 00 
      attribute = 0x7100 ;
80100594:	c7 05 00 80 10 80 00 	movl   $0x7100,0x80108000
8010059b:	71 00 00 
8010059e:	c3                   	ret
      stat = 0 ;
8010059f:	c7 05 0c ef 10 80 00 	movl   $0x0,0x8010ef0c
801005a6:	00 00 00 
      attribute = 0x0700;
801005a9:	c7 05 00 80 10 80 00 	movl   $0x700,0x80108000
801005b0:	07 00 00 
801005b3:	c3                   	ret
    uartputc('\b');
801005b4:	83 ec 0c             	sub    $0xc,%esp
801005b7:	6a 08                	push   $0x8
801005b9:	e8 c2 57 00 00       	call   80105d80 <uartputc>
    uartputc(' ');
801005be:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801005c5:	e8 b6 57 00 00       	call   80105d80 <uartputc>
    uartputc('\b');
801005ca:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801005d1:	e8 aa 57 00 00       	call   80105d80 <uartputc>
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
8010061b:	0f b6 92 40 77 10 80 	movzbl -0x7fef88c0(%edx),%edx
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
8010068c:	e8 bf 12 00 00       	call   80101950 <iunlock>
  acquire(&cons.lock);
80100691:	c7 04 24 20 ef 10 80 	movl   $0x8010ef20,(%esp)
80100698:	e8 d3 3f 00 00       	call   80104670 <acquire>
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
801006b7:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
801006bd:	85 d2                	test   %edx,%edx
801006bf:	74 07                	je     801006c8 <consolewrite+0x48>
801006c1:	fa                   	cli
    for (;;) ;
801006c2:	eb fe                	jmp    801006c2 <consolewrite+0x42>
801006c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartputc(c);
801006c8:	83 ec 0c             	sub    $0xc,%esp
801006cb:	56                   	push   %esi
801006cc:	e8 af 56 00 00       	call   80105d80 <uartputc>
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
801006e5:	68 20 ef 10 80       	push   $0x8010ef20
801006ea:	e8 21 3f 00 00       	call   80104610 <release>
  ilock(ip);
801006ef:	58                   	pop    %eax
801006f0:	ff 75 08             	push   0x8(%ebp)
801006f3:	e8 78 11 00 00       	call   80101870 <ilock>

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
80100703:	8b 0d 0c ef 10 80    	mov    0x8010ef0c,%ecx
80100709:	85 c9                	test   %ecx,%ecx
8010070b:	75 16                	jne    80100723 <consolewrite+0xa3>
      stat = 1 ;
8010070d:	c7 05 0c ef 10 80 01 	movl   $0x1,0x8010ef0c
80100714:	00 00 00 
      attribute = 0x7100 ;
80100717:	c7 05 00 80 10 80 00 	movl   $0x7100,0x80108000
8010071e:	71 00 00 
80100721:	eb b8                	jmp    801006db <consolewrite+0x5b>
      stat = 0 ;
80100723:	c7 05 0c ef 10 80 00 	movl   $0x0,0x8010ef0c
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
80100749:	8b 3d 54 ef 10 80    	mov    0x8010ef54,%edi
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
801007ea:	a1 58 ef 10 80       	mov    0x8010ef58,%eax
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
80100821:	bf 98 72 10 80       	mov    $0x80107298,%edi
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
80100858:	8b 0d 58 ef 10 80    	mov    0x8010ef58,%ecx
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
80100870:	e8 0b 55 00 00       	call   80105d80 <uartputc>
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
801008a8:	e8 d3 54 00 00       	call   80105d80 <uartputc>
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
801008d3:	68 20 ef 10 80       	push   $0x8010ef20
801008d8:	e8 93 3d 00 00       	call   80104670 <acquire>
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
801008f2:	68 20 ef 10 80       	push   $0x8010ef20
801008f7:	e8 14 3d 00 00       	call   80104610 <release>
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
8010090a:	68 9f 72 10 80       	push   $0x8010729f
8010090f:	e8 6c fa ff ff       	call   80100380 <panic>
80100914:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010091b:	00 
8010091c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100920 <consoleintr>:
{
80100920:	55                   	push   %ebp
80100921:	89 e5                	mov    %esp,%ebp
80100923:	57                   	push   %edi
  int c, doprocdump = 0;
80100924:	31 ff                	xor    %edi,%edi
{
80100926:	56                   	push   %esi
80100927:	53                   	push   %ebx
80100928:	83 ec 18             	sub    $0x18,%esp
8010092b:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&cons.lock);
8010092e:	68 20 ef 10 80       	push   $0x8010ef20
80100933:	e8 38 3d 00 00       	call   80104670 <acquire>
  while((c = getc()) >= 0){
80100938:	83 c4 10             	add    $0x10,%esp
8010093b:	ff d6                	call   *%esi
8010093d:	89 c3                	mov    %eax,%ebx
8010093f:	85 c0                	test   %eax,%eax
80100941:	78 22                	js     80100965 <consoleintr+0x45>
    switch(c){
80100943:	83 fb 15             	cmp    $0x15,%ebx
80100946:	74 40                	je     80100988 <consoleintr+0x68>
80100948:	7f 76                	jg     801009c0 <consoleintr+0xa0>
8010094a:	83 fb 08             	cmp    $0x8,%ebx
8010094d:	74 76                	je     801009c5 <consoleintr+0xa5>
8010094f:	83 fb 10             	cmp    $0x10,%ebx
80100952:	0f 85 47 01 00 00    	jne    80100a9f <consoleintr+0x17f>
  while((c = getc()) >= 0){
80100958:	ff d6                	call   *%esi
    switch(c){
8010095a:	bf 01 00 00 00       	mov    $0x1,%edi
  while((c = getc()) >= 0){
8010095f:	89 c3                	mov    %eax,%ebx
80100961:	85 c0                	test   %eax,%eax
80100963:	79 de                	jns    80100943 <consoleintr+0x23>
  release(&cons.lock);
80100965:	83 ec 0c             	sub    $0xc,%esp
80100968:	68 20 ef 10 80       	push   $0x8010ef20
8010096d:	e8 9e 3c 00 00       	call   80104610 <release>
  if(doprocdump) {
80100972:	83 c4 10             	add    $0x10,%esp
80100975:	85 ff                	test   %edi,%edi
80100977:	0f 85 9d 01 00 00    	jne    80100b1a <consoleintr+0x1fa>
}
8010097d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100980:	5b                   	pop    %ebx
80100981:	5e                   	pop    %esi
80100982:	5f                   	pop    %edi
80100983:	5d                   	pop    %ebp
80100984:	c3                   	ret
80100985:	8d 76 00             	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100988:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
8010098d:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
80100993:	74 a6                	je     8010093b <consoleintr+0x1b>
            input.buf[(input.e) % INPUT_BUF] != '\n'){
80100995:	89 c2                	mov    %eax,%edx
80100997:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
8010099a:	80 ba 80 ee 10 80 0a 	cmpb   $0xa,-0x7fef1180(%edx)
801009a1:	74 98                	je     8010093b <consoleintr+0x1b>
  if (panicked) {
801009a3:	8b 15 58 ef 10 80    	mov    0x8010ef58,%edx
        input.e--;
801009a9:	83 e8 01             	sub    $0x1,%eax
801009ac:	a3 08 ef 10 80       	mov    %eax,0x8010ef08
  if (panicked) {
801009b1:	85 d2                	test   %edx,%edx
801009b3:	74 3b                	je     801009f0 <consoleintr+0xd0>
801009b5:	fa                   	cli
    for (;;) ;
801009b6:	eb fe                	jmp    801009b6 <consoleintr+0x96>
801009b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801009bf:	00 
    switch(c){
801009c0:	83 fb 7f             	cmp    $0x7f,%ebx
801009c3:	75 73                	jne    80100a38 <consoleintr+0x118>
      if(input.e != input.w){
801009c5:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
801009ca:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
801009d0:	0f 84 65 ff ff ff    	je     8010093b <consoleintr+0x1b>
        input.e--;
801009d6:	83 e8 01             	sub    $0x1,%eax
801009d9:	a3 08 ef 10 80       	mov    %eax,0x8010ef08
  if (panicked) {
801009de:	a1 58 ef 10 80       	mov    0x8010ef58,%eax
801009e3:	85 c0                	test   %eax,%eax
801009e5:	0f 84 fb 00 00 00    	je     80100ae6 <consoleintr+0x1c6>
801009eb:	fa                   	cli
    for (;;) ;
801009ec:	eb fe                	jmp    801009ec <consoleintr+0xcc>
801009ee:	66 90                	xchg   %ax,%ax
    uartputc('\b');
801009f0:	83 ec 0c             	sub    $0xc,%esp
801009f3:	6a 08                	push   $0x8
801009f5:	e8 86 53 00 00       	call   80105d80 <uartputc>
    uartputc(' ');
801009fa:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100a01:	e8 7a 53 00 00       	call   80105d80 <uartputc>
    uartputc('\b');
80100a06:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100a0d:	e8 6e 53 00 00       	call   80105d80 <uartputc>
    cgaputc(c);
80100a12:	b8 00 01 00 00       	mov    $0x100,%eax
80100a17:	e8 e4 f9 ff ff       	call   80100400 <cgaputc>
      while(input.e != input.w &&
80100a1c:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100a21:	83 c4 10             	add    $0x10,%esp
80100a24:	3b 05 04 ef 10 80    	cmp    0x8010ef04,%eax
80100a2a:	0f 85 65 ff ff ff    	jne    80100995 <consoleintr+0x75>
80100a30:	e9 06 ff ff ff       	jmp    8010093b <consoleintr+0x1b>
80100a35:	8d 76 00             	lea    0x0(%esi),%esi
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100a38:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100a3d:	89 c2                	mov    %eax,%edx
80100a3f:	2b 15 00 ef 10 80    	sub    0x8010ef00,%edx
80100a45:	83 fa 7f             	cmp    $0x7f,%edx
80100a48:	0f 87 ed fe ff ff    	ja     8010093b <consoleintr+0x1b>
        input.buf[input.e++ % INPUT_BUF] = c;
80100a4e:	8d 50 01             	lea    0x1(%eax),%edx
80100a51:	83 e0 7f             	and    $0x7f,%eax
80100a54:	88 98 80 ee 10 80    	mov    %bl,-0x7fef1180(%eax)
        consputc(c);
80100a5a:	89 d8                	mov    %ebx,%eax
        input.buf[input.e++ % INPUT_BUF] = c;
80100a5c:	89 15 08 ef 10 80    	mov    %edx,0x8010ef08
        consputc(c);
80100a62:	e8 d9 fa ff ff       	call   80100540 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100a67:	83 fb 0a             	cmp    $0xa,%ebx
80100a6a:	74 73                	je     80100adf <consoleintr+0x1bf>
80100a6c:	83 fb 04             	cmp    $0x4,%ebx
80100a6f:	74 6e                	je     80100adf <consoleintr+0x1bf>
80100a71:	a1 00 ef 10 80       	mov    0x8010ef00,%eax
80100a76:	83 e8 80             	sub    $0xffffff80,%eax
80100a79:	39 05 08 ef 10 80    	cmp    %eax,0x8010ef08
80100a7f:	0f 85 b6 fe ff ff    	jne    8010093b <consoleintr+0x1b>
          wakeup(&input.r);
80100a85:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
80100a88:	a3 04 ef 10 80       	mov    %eax,0x8010ef04
          wakeup(&input.r);
80100a8d:	68 00 ef 10 80       	push   $0x8010ef00
80100a92:	e8 19 37 00 00       	call   801041b0 <wakeup>
80100a97:	83 c4 10             	add    $0x10,%esp
80100a9a:	e9 9c fe ff ff       	jmp    8010093b <consoleintr+0x1b>
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100a9f:	85 db                	test   %ebx,%ebx
80100aa1:	0f 84 94 fe ff ff    	je     8010093b <consoleintr+0x1b>
80100aa7:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100aac:	89 c2                	mov    %eax,%edx
80100aae:	2b 15 00 ef 10 80    	sub    0x8010ef00,%edx
80100ab4:	83 fa 7f             	cmp    $0x7f,%edx
80100ab7:	0f 87 7e fe ff ff    	ja     8010093b <consoleintr+0x1b>
        input.buf[input.e++ % INPUT_BUF] = c;
80100abd:	8d 50 01             	lea    0x1(%eax),%edx
80100ac0:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
80100ac3:	83 fb 0d             	cmp    $0xd,%ebx
80100ac6:	75 8c                	jne    80100a54 <consoleintr+0x134>
        input.buf[input.e++ % INPUT_BUF] = c;
80100ac8:	c6 80 80 ee 10 80 0a 	movb   $0xa,-0x7fef1180(%eax)
        consputc(c);
80100acf:	b8 0a 00 00 00       	mov    $0xa,%eax
        input.buf[input.e++ % INPUT_BUF] = c;
80100ad4:	89 15 08 ef 10 80    	mov    %edx,0x8010ef08
        consputc(c);
80100ada:	e8 61 fa ff ff       	call   80100540 <consputc>
          input.w = input.e;
80100adf:	a1 08 ef 10 80       	mov    0x8010ef08,%eax
80100ae4:	eb 9f                	jmp    80100a85 <consoleintr+0x165>
    uartputc('\b');
80100ae6:	83 ec 0c             	sub    $0xc,%esp
80100ae9:	6a 08                	push   $0x8
80100aeb:	e8 90 52 00 00       	call   80105d80 <uartputc>
    uartputc(' ');
80100af0:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100af7:	e8 84 52 00 00       	call   80105d80 <uartputc>
    uartputc('\b');
80100afc:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100b03:	e8 78 52 00 00       	call   80105d80 <uartputc>
    cgaputc(c);
80100b08:	b8 00 01 00 00       	mov    $0x100,%eax
80100b0d:	e8 ee f8 ff ff       	call   80100400 <cgaputc>
80100b12:	83 c4 10             	add    $0x10,%esp
80100b15:	e9 21 fe ff ff       	jmp    8010093b <consoleintr+0x1b>
}
80100b1a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100b1d:	5b                   	pop    %ebx
80100b1e:	5e                   	pop    %esi
80100b1f:	5f                   	pop    %edi
80100b20:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100b21:	e9 6a 37 00 00       	jmp    80104290 <procdump>
80100b26:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100b2d:	00 
80100b2e:	66 90                	xchg   %ax,%ax

80100b30 <consoleinit>:

void
consoleinit(void)
{
80100b30:	55                   	push   %ebp
80100b31:	89 e5                	mov    %esp,%ebp
80100b33:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
80100b36:	68 a8 72 10 80       	push   $0x801072a8
80100b3b:	68 20 ef 10 80       	push   $0x8010ef20
80100b40:	e8 3b 39 00 00       	call   80104480 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
80100b45:	58                   	pop    %eax
80100b46:	5a                   	pop    %edx
80100b47:	6a 00                	push   $0x0
80100b49:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
80100b4b:	c7 05 0c f9 10 80 80 	movl   $0x80100680,0x8010f90c
80100b52:	06 10 80 
  devsw[CONSOLE].read = consoleread;
80100b55:	c7 05 08 f9 10 80 80 	movl   $0x80100280,0x8010f908
80100b5c:	02 10 80 
  cons.locking = 1;
80100b5f:	c7 05 54 ef 10 80 01 	movl   $0x1,0x8010ef54
80100b66:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80100b69:	e8 c2 19 00 00       	call   80102530 <ioapicenable>
}
80100b6e:	83 c4 10             	add    $0x10,%esp
80100b71:	c9                   	leave
80100b72:	c3                   	ret
80100b73:	66 90                	xchg   %ax,%ax
80100b75:	66 90                	xchg   %ax,%ax
80100b77:	66 90                	xchg   %ax,%ax
80100b79:	66 90                	xchg   %ax,%ax
80100b7b:	66 90                	xchg   %ax,%ax
80100b7d:	66 90                	xchg   %ax,%ax
80100b7f:	90                   	nop

80100b80 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100b80:	55                   	push   %ebp
80100b81:	89 e5                	mov    %esp,%ebp
80100b83:	57                   	push   %edi
80100b84:	56                   	push   %esi
80100b85:	53                   	push   %ebx
80100b86:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100b8c:	e8 9f 2e 00 00       	call   80103a30 <myproc>
80100b91:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)

  begin_op();
80100b97:	e8 74 22 00 00       	call   80102e10 <begin_op>

  if((ip = namei(path)) == 0){
80100b9c:	83 ec 0c             	sub    $0xc,%esp
80100b9f:	ff 75 08             	push   0x8(%ebp)
80100ba2:	e8 a9 15 00 00       	call   80102150 <namei>
80100ba7:	83 c4 10             	add    $0x10,%esp
80100baa:	85 c0                	test   %eax,%eax
80100bac:	0f 84 30 03 00 00    	je     80100ee2 <exec+0x362>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100bb2:	83 ec 0c             	sub    $0xc,%esp
80100bb5:	89 c7                	mov    %eax,%edi
80100bb7:	50                   	push   %eax
80100bb8:	e8 b3 0c 00 00       	call   80101870 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100bbd:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100bc3:	6a 34                	push   $0x34
80100bc5:	6a 00                	push   $0x0
80100bc7:	50                   	push   %eax
80100bc8:	57                   	push   %edi
80100bc9:	e8 b2 0f 00 00       	call   80101b80 <readi>
80100bce:	83 c4 20             	add    $0x20,%esp
80100bd1:	83 f8 34             	cmp    $0x34,%eax
80100bd4:	0f 85 01 01 00 00    	jne    80100cdb <exec+0x15b>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100bda:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100be1:	45 4c 46 
80100be4:	0f 85 f1 00 00 00    	jne    80100cdb <exec+0x15b>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100bea:	e8 01 63 00 00       	call   80106ef0 <setupkvm>
80100bef:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
80100bf5:	85 c0                	test   %eax,%eax
80100bf7:	0f 84 de 00 00 00    	je     80100cdb <exec+0x15b>
    goto bad;

  // Load program into memory.
  sz = 0;
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100bfd:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100c04:	00 
80100c05:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
80100c0b:	0f 84 a1 02 00 00    	je     80100eb2 <exec+0x332>
  sz = 0;
80100c11:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100c18:	00 00 00 
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c1b:	31 db                	xor    %ebx,%ebx
80100c1d:	e9 8c 00 00 00       	jmp    80100cae <exec+0x12e>
80100c22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100c28:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100c2f:	75 6c                	jne    80100c9d <exec+0x11d>
      continue;
    if(ph.memsz < ph.filesz)
80100c31:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100c37:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100c3d:	0f 82 87 00 00 00    	jb     80100cca <exec+0x14a>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100c43:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100c49:	72 7f                	jb     80100cca <exec+0x14a>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100c4b:	83 ec 04             	sub    $0x4,%esp
80100c4e:	50                   	push   %eax
80100c4f:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80100c55:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c5b:	e8 c0 60 00 00       	call   80106d20 <allocuvm>
80100c60:	83 c4 10             	add    $0x10,%esp
80100c63:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100c69:	85 c0                	test   %eax,%eax
80100c6b:	74 5d                	je     80100cca <exec+0x14a>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100c6d:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100c73:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100c78:	75 50                	jne    80100cca <exec+0x14a>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100c7a:	83 ec 0c             	sub    $0xc,%esp
80100c7d:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80100c83:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80100c89:	57                   	push   %edi
80100c8a:	50                   	push   %eax
80100c8b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100c91:	e8 ba 5f 00 00       	call   80106c50 <loaduvm>
80100c96:	83 c4 20             	add    $0x20,%esp
80100c99:	85 c0                	test   %eax,%eax
80100c9b:	78 2d                	js     80100cca <exec+0x14a>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c9d:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100ca4:	83 c3 01             	add    $0x1,%ebx
80100ca7:	83 c6 20             	add    $0x20,%esi
80100caa:	39 d8                	cmp    %ebx,%eax
80100cac:	7e 52                	jle    80100d00 <exec+0x180>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100cae:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100cb4:	6a 20                	push   $0x20
80100cb6:	56                   	push   %esi
80100cb7:	50                   	push   %eax
80100cb8:	57                   	push   %edi
80100cb9:	e8 c2 0e 00 00       	call   80101b80 <readi>
80100cbe:	83 c4 10             	add    $0x10,%esp
80100cc1:	83 f8 20             	cmp    $0x20,%eax
80100cc4:	0f 84 5e ff ff ff    	je     80100c28 <exec+0xa8>
  freevm(oldpgdir);
  return 0;

 bad:
  if(pgdir)
    freevm(pgdir);
80100cca:	83 ec 0c             	sub    $0xc,%esp
80100ccd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100cd3:	e8 98 61 00 00       	call   80106e70 <freevm>
  if(ip){
80100cd8:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80100cdb:	83 ec 0c             	sub    $0xc,%esp
80100cde:	57                   	push   %edi
80100cdf:	e8 1c 0e 00 00       	call   80101b00 <iunlockput>
    end_op();
80100ce4:	e8 97 21 00 00       	call   80102e80 <end_op>
80100ce9:	83 c4 10             	add    $0x10,%esp
    return -1;
80100cec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  return -1;
}
80100cf1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100cf4:	5b                   	pop    %ebx
80100cf5:	5e                   	pop    %esi
80100cf6:	5f                   	pop    %edi
80100cf7:	5d                   	pop    %ebp
80100cf8:	c3                   	ret
80100cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  sz = PGROUNDUP(sz);
80100d00:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100d06:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
80100d0c:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d12:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
  iunlockput(ip);
80100d18:	83 ec 0c             	sub    $0xc,%esp
80100d1b:	57                   	push   %edi
80100d1c:	e8 df 0d 00 00       	call   80101b00 <iunlockput>
  end_op();
80100d21:	e8 5a 21 00 00       	call   80102e80 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d26:	83 c4 0c             	add    $0xc,%esp
80100d29:	53                   	push   %ebx
80100d2a:	56                   	push   %esi
80100d2b:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
80100d31:	56                   	push   %esi
80100d32:	e8 e9 5f 00 00       	call   80106d20 <allocuvm>
80100d37:	83 c4 10             	add    $0x10,%esp
80100d3a:	89 c7                	mov    %eax,%edi
80100d3c:	85 c0                	test   %eax,%eax
80100d3e:	0f 84 86 00 00 00    	je     80100dca <exec+0x24a>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d44:	83 ec 08             	sub    $0x8,%esp
80100d47:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
  sp = sz;
80100d4d:	89 fb                	mov    %edi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d4f:	50                   	push   %eax
80100d50:	56                   	push   %esi
  for(argc = 0; argv[argc]; argc++) {
80100d51:	31 f6                	xor    %esi,%esi
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100d53:	e8 38 62 00 00       	call   80106f90 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100d58:	8b 45 0c             	mov    0xc(%ebp),%eax
80100d5b:	83 c4 10             	add    $0x10,%esp
80100d5e:	8b 10                	mov    (%eax),%edx
80100d60:	85 d2                	test   %edx,%edx
80100d62:	0f 84 56 01 00 00    	je     80100ebe <exec+0x33e>
80100d68:	89 bd f0 fe ff ff    	mov    %edi,-0x110(%ebp)
80100d6e:	8b 7d 0c             	mov    0xc(%ebp),%edi
80100d71:	eb 23                	jmp    80100d96 <exec+0x216>
80100d73:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100d78:	8d 46 01             	lea    0x1(%esi),%eax
    ustack[3+argc] = sp;
80100d7b:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
80100d82:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
  for(argc = 0; argv[argc]; argc++) {
80100d88:	8b 14 87             	mov    (%edi,%eax,4),%edx
80100d8b:	85 d2                	test   %edx,%edx
80100d8d:	74 51                	je     80100de0 <exec+0x260>
    if(argc >= MAXARG)
80100d8f:	83 f8 20             	cmp    $0x20,%eax
80100d92:	74 36                	je     80100dca <exec+0x24a>
80100d94:	89 c6                	mov    %eax,%esi
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100d96:	83 ec 0c             	sub    $0xc,%esp
80100d99:	52                   	push   %edx
80100d9a:	e8 c1 3b 00 00       	call   80104960 <strlen>
80100d9f:	29 c3                	sub    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100da1:	58                   	pop    %eax
80100da2:	ff 34 b7             	push   (%edi,%esi,4)
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100da5:	83 eb 01             	sub    $0x1,%ebx
80100da8:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100dab:	e8 b0 3b 00 00       	call   80104960 <strlen>
80100db0:	83 c0 01             	add    $0x1,%eax
80100db3:	50                   	push   %eax
80100db4:	ff 34 b7             	push   (%edi,%esi,4)
80100db7:	53                   	push   %ebx
80100db8:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100dbe:	e8 9d 63 00 00       	call   80107160 <copyout>
80100dc3:	83 c4 20             	add    $0x20,%esp
80100dc6:	85 c0                	test   %eax,%eax
80100dc8:	79 ae                	jns    80100d78 <exec+0x1f8>
    freevm(pgdir);
80100dca:	83 ec 0c             	sub    $0xc,%esp
80100dcd:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100dd3:	e8 98 60 00 00       	call   80106e70 <freevm>
80100dd8:	83 c4 10             	add    $0x10,%esp
80100ddb:	e9 0c ff ff ff       	jmp    80100cec <exec+0x16c>
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100de0:	8d 14 b5 08 00 00 00 	lea    0x8(,%esi,4),%edx
  ustack[3+argc] = 0;
80100de7:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
80100ded:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100df3:	8d 46 04             	lea    0x4(%esi),%eax
  sp -= (3+argc+1) * 4;
80100df6:	8d 72 0c             	lea    0xc(%edx),%esi
  ustack[3+argc] = 0;
80100df9:	c7 84 85 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%eax,4)
80100e00:	00 00 00 00 
  ustack[1] = argc;
80100e04:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
  ustack[0] = 0xffffffff;  // fake return PC
80100e0a:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100e11:	ff ff ff 
  ustack[1] = argc;
80100e14:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e1a:	89 d8                	mov    %ebx,%eax
  sp -= (3+argc+1) * 4;
80100e1c:	29 f3                	sub    %esi,%ebx
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100e1e:	29 d0                	sub    %edx,%eax
80100e20:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100e26:	56                   	push   %esi
80100e27:	51                   	push   %ecx
80100e28:	53                   	push   %ebx
80100e29:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80100e2f:	e8 2c 63 00 00       	call   80107160 <copyout>
80100e34:	83 c4 10             	add    $0x10,%esp
80100e37:	85 c0                	test   %eax,%eax
80100e39:	78 8f                	js     80100dca <exec+0x24a>
  for(last=s=path; *s; s++)
80100e3b:	8b 45 08             	mov    0x8(%ebp),%eax
80100e3e:	8b 55 08             	mov    0x8(%ebp),%edx
80100e41:	0f b6 00             	movzbl (%eax),%eax
80100e44:	84 c0                	test   %al,%al
80100e46:	74 17                	je     80100e5f <exec+0x2df>
80100e48:	89 d1                	mov    %edx,%ecx
80100e4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      last = s+1;
80100e50:	83 c1 01             	add    $0x1,%ecx
80100e53:	3c 2f                	cmp    $0x2f,%al
  for(last=s=path; *s; s++)
80100e55:	0f b6 01             	movzbl (%ecx),%eax
      last = s+1;
80100e58:	0f 44 d1             	cmove  %ecx,%edx
  for(last=s=path; *s; s++)
80100e5b:	84 c0                	test   %al,%al
80100e5d:	75 f1                	jne    80100e50 <exec+0x2d0>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100e5f:	83 ec 04             	sub    $0x4,%esp
80100e62:	6a 10                	push   $0x10
80100e64:	52                   	push   %edx
80100e65:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
80100e6b:	8d 46 6c             	lea    0x6c(%esi),%eax
80100e6e:	50                   	push   %eax
80100e6f:	e8 ac 3a 00 00       	call   80104920 <safestrcpy>
  curproc->pgdir = pgdir;
80100e74:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
  oldpgdir = curproc->pgdir;
80100e7a:	89 f0                	mov    %esi,%eax
80100e7c:	8b 76 04             	mov    0x4(%esi),%esi
  curproc->sz = sz;
80100e7f:	89 38                	mov    %edi,(%eax)
  curproc->pgdir = pgdir;
80100e81:	89 48 04             	mov    %ecx,0x4(%eax)
  curproc->tf->eip = elf.entry;  // main
80100e84:	89 c1                	mov    %eax,%ecx
80100e86:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100e8c:	8b 40 18             	mov    0x18(%eax),%eax
80100e8f:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100e92:	8b 41 18             	mov    0x18(%ecx),%eax
80100e95:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100e98:	89 0c 24             	mov    %ecx,(%esp)
80100e9b:	e8 20 5c 00 00       	call   80106ac0 <switchuvm>
  freevm(oldpgdir);
80100ea0:	89 34 24             	mov    %esi,(%esp)
80100ea3:	e8 c8 5f 00 00       	call   80106e70 <freevm>
  return 0;
80100ea8:	83 c4 10             	add    $0x10,%esp
80100eab:	31 c0                	xor    %eax,%eax
80100ead:	e9 3f fe ff ff       	jmp    80100cf1 <exec+0x171>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100eb2:	bb 00 20 00 00       	mov    $0x2000,%ebx
80100eb7:	31 f6                	xor    %esi,%esi
80100eb9:	e9 5a fe ff ff       	jmp    80100d18 <exec+0x198>
  for(argc = 0; argv[argc]; argc++) {
80100ebe:	be 10 00 00 00       	mov    $0x10,%esi
80100ec3:	ba 04 00 00 00       	mov    $0x4,%edx
80100ec8:	b8 03 00 00 00       	mov    $0x3,%eax
80100ecd:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80100ed4:	00 00 00 
80100ed7:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80100edd:	e9 17 ff ff ff       	jmp    80100df9 <exec+0x279>
    end_op();
80100ee2:	e8 99 1f 00 00       	call   80102e80 <end_op>
    cprintf("exec: fail\n");
80100ee7:	83 ec 0c             	sub    $0xc,%esp
80100eea:	68 b0 72 10 80       	push   $0x801072b0
80100eef:	e8 4c f8 ff ff       	call   80100740 <cprintf>
    return -1;
80100ef4:	83 c4 10             	add    $0x10,%esp
80100ef7:	e9 f0 fd ff ff       	jmp    80100cec <exec+0x16c>
80100efc:	66 90                	xchg   %ax,%ax
80100efe:	66 90                	xchg   %ax,%ax

80100f00 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100f00:	55                   	push   %ebp
80100f01:	89 e5                	mov    %esp,%ebp
80100f03:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100f06:	68 bc 72 10 80       	push   $0x801072bc
80100f0b:	68 60 ef 10 80       	push   $0x8010ef60
80100f10:	e8 6b 35 00 00       	call   80104480 <initlock>
}
80100f15:	83 c4 10             	add    $0x10,%esp
80100f18:	c9                   	leave
80100f19:	c3                   	ret
80100f1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100f20 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100f20:	55                   	push   %ebp
80100f21:	89 e5                	mov    %esp,%ebp
80100f23:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f24:	bb 94 ef 10 80       	mov    $0x8010ef94,%ebx
{
80100f29:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100f2c:	68 60 ef 10 80       	push   $0x8010ef60
80100f31:	e8 3a 37 00 00       	call   80104670 <acquire>
80100f36:	83 c4 10             	add    $0x10,%esp
80100f39:	eb 10                	jmp    80100f4b <filealloc+0x2b>
80100f3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100f40:	83 c3 18             	add    $0x18,%ebx
80100f43:	81 fb f4 f8 10 80    	cmp    $0x8010f8f4,%ebx
80100f49:	74 25                	je     80100f70 <filealloc+0x50>
    if(f->ref == 0){
80100f4b:	8b 43 04             	mov    0x4(%ebx),%eax
80100f4e:	85 c0                	test   %eax,%eax
80100f50:	75 ee                	jne    80100f40 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100f52:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100f55:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100f5c:	68 60 ef 10 80       	push   $0x8010ef60
80100f61:	e8 aa 36 00 00       	call   80104610 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100f66:	89 d8                	mov    %ebx,%eax
      return f;
80100f68:	83 c4 10             	add    $0x10,%esp
}
80100f6b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f6e:	c9                   	leave
80100f6f:	c3                   	ret
  release(&ftable.lock);
80100f70:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100f73:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100f75:	68 60 ef 10 80       	push   $0x8010ef60
80100f7a:	e8 91 36 00 00       	call   80104610 <release>
}
80100f7f:	89 d8                	mov    %ebx,%eax
  return 0;
80100f81:	83 c4 10             	add    $0x10,%esp
}
80100f84:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f87:	c9                   	leave
80100f88:	c3                   	ret
80100f89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100f90 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100f90:	55                   	push   %ebp
80100f91:	89 e5                	mov    %esp,%ebp
80100f93:	53                   	push   %ebx
80100f94:	83 ec 10             	sub    $0x10,%esp
80100f97:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100f9a:	68 60 ef 10 80       	push   $0x8010ef60
80100f9f:	e8 cc 36 00 00       	call   80104670 <acquire>
  if(f->ref < 1)
80100fa4:	8b 43 04             	mov    0x4(%ebx),%eax
80100fa7:	83 c4 10             	add    $0x10,%esp
80100faa:	85 c0                	test   %eax,%eax
80100fac:	7e 1a                	jle    80100fc8 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100fae:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100fb1:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100fb4:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100fb7:	68 60 ef 10 80       	push   $0x8010ef60
80100fbc:	e8 4f 36 00 00       	call   80104610 <release>
  return f;
}
80100fc1:	89 d8                	mov    %ebx,%eax
80100fc3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100fc6:	c9                   	leave
80100fc7:	c3                   	ret
    panic("filedup");
80100fc8:	83 ec 0c             	sub    $0xc,%esp
80100fcb:	68 c3 72 10 80       	push   $0x801072c3
80100fd0:	e8 ab f3 ff ff       	call   80100380 <panic>
80100fd5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100fdc:	00 
80100fdd:	8d 76 00             	lea    0x0(%esi),%esi

80100fe0 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100fe0:	55                   	push   %ebp
80100fe1:	89 e5                	mov    %esp,%ebp
80100fe3:	57                   	push   %edi
80100fe4:	56                   	push   %esi
80100fe5:	53                   	push   %ebx
80100fe6:	83 ec 28             	sub    $0x28,%esp
80100fe9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100fec:	68 60 ef 10 80       	push   $0x8010ef60
80100ff1:	e8 7a 36 00 00       	call   80104670 <acquire>
  if(f->ref < 1)
80100ff6:	8b 53 04             	mov    0x4(%ebx),%edx
80100ff9:	83 c4 10             	add    $0x10,%esp
80100ffc:	85 d2                	test   %edx,%edx
80100ffe:	0f 8e a5 00 00 00    	jle    801010a9 <fileclose+0xc9>
    panic("fileclose");
  if(--f->ref > 0){
80101004:	83 ea 01             	sub    $0x1,%edx
80101007:	89 53 04             	mov    %edx,0x4(%ebx)
8010100a:	75 44                	jne    80101050 <fileclose+0x70>
    release(&ftable.lock);
    return;
  }
  ff = *f;
8010100c:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
  f->ref = 0;
  f->type = FD_NONE;
  release(&ftable.lock);
80101010:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80101013:	8b 3b                	mov    (%ebx),%edi
  f->type = FD_NONE;
80101015:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
8010101b:	8b 73 0c             	mov    0xc(%ebx),%esi
8010101e:	88 45 e7             	mov    %al,-0x19(%ebp)
80101021:	8b 43 10             	mov    0x10(%ebx),%eax
80101024:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80101027:	68 60 ef 10 80       	push   $0x8010ef60
8010102c:	e8 df 35 00 00       	call   80104610 <release>

  if(ff.type == FD_PIPE)
80101031:	83 c4 10             	add    $0x10,%esp
80101034:	83 ff 01             	cmp    $0x1,%edi
80101037:	74 57                	je     80101090 <fileclose+0xb0>
    pipeclose(ff.pipe, ff.writable);
  else if(ff.type == FD_INODE){
80101039:	83 ff 02             	cmp    $0x2,%edi
8010103c:	74 2a                	je     80101068 <fileclose+0x88>
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
8010103e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101041:	5b                   	pop    %ebx
80101042:	5e                   	pop    %esi
80101043:	5f                   	pop    %edi
80101044:	5d                   	pop    %ebp
80101045:	c3                   	ret
80101046:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010104d:	00 
8010104e:	66 90                	xchg   %ax,%ax
    release(&ftable.lock);
80101050:	c7 45 08 60 ef 10 80 	movl   $0x8010ef60,0x8(%ebp)
}
80101057:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010105a:	5b                   	pop    %ebx
8010105b:	5e                   	pop    %esi
8010105c:	5f                   	pop    %edi
8010105d:	5d                   	pop    %ebp
    release(&ftable.lock);
8010105e:	e9 ad 35 00 00       	jmp    80104610 <release>
80101063:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    begin_op();
80101068:	e8 a3 1d 00 00       	call   80102e10 <begin_op>
    iput(ff.ip);
8010106d:	83 ec 0c             	sub    $0xc,%esp
80101070:	ff 75 e0             	push   -0x20(%ebp)
80101073:	e8 28 09 00 00       	call   801019a0 <iput>
    end_op();
80101078:	83 c4 10             	add    $0x10,%esp
}
8010107b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010107e:	5b                   	pop    %ebx
8010107f:	5e                   	pop    %esi
80101080:	5f                   	pop    %edi
80101081:	5d                   	pop    %ebp
    end_op();
80101082:	e9 f9 1d 00 00       	jmp    80102e80 <end_op>
80101087:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010108e:	00 
8010108f:	90                   	nop
    pipeclose(ff.pipe, ff.writable);
80101090:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101094:	83 ec 08             	sub    $0x8,%esp
80101097:	53                   	push   %ebx
80101098:	56                   	push   %esi
80101099:	e8 32 25 00 00       	call   801035d0 <pipeclose>
8010109e:	83 c4 10             	add    $0x10,%esp
}
801010a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010a4:	5b                   	pop    %ebx
801010a5:	5e                   	pop    %esi
801010a6:	5f                   	pop    %edi
801010a7:	5d                   	pop    %ebp
801010a8:	c3                   	ret
    panic("fileclose");
801010a9:	83 ec 0c             	sub    $0xc,%esp
801010ac:	68 cb 72 10 80       	push   $0x801072cb
801010b1:	e8 ca f2 ff ff       	call   80100380 <panic>
801010b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801010bd:	00 
801010be:	66 90                	xchg   %ax,%ax

801010c0 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
801010c0:	55                   	push   %ebp
801010c1:	89 e5                	mov    %esp,%ebp
801010c3:	53                   	push   %ebx
801010c4:	83 ec 04             	sub    $0x4,%esp
801010c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
801010ca:	83 3b 02             	cmpl   $0x2,(%ebx)
801010cd:	75 31                	jne    80101100 <filestat+0x40>
    ilock(f->ip);
801010cf:	83 ec 0c             	sub    $0xc,%esp
801010d2:	ff 73 10             	push   0x10(%ebx)
801010d5:	e8 96 07 00 00       	call   80101870 <ilock>
    stati(f->ip, st);
801010da:	58                   	pop    %eax
801010db:	5a                   	pop    %edx
801010dc:	ff 75 0c             	push   0xc(%ebp)
801010df:	ff 73 10             	push   0x10(%ebx)
801010e2:	e8 69 0a 00 00       	call   80101b50 <stati>
    iunlock(f->ip);
801010e7:	59                   	pop    %ecx
801010e8:	ff 73 10             	push   0x10(%ebx)
801010eb:	e8 60 08 00 00       	call   80101950 <iunlock>
    return 0;
  }
  return -1;
}
801010f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
801010f3:	83 c4 10             	add    $0x10,%esp
801010f6:	31 c0                	xor    %eax,%eax
}
801010f8:	c9                   	leave
801010f9:	c3                   	ret
801010fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101100:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80101103:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101108:	c9                   	leave
80101109:	c3                   	ret
8010110a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101110 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80101110:	55                   	push   %ebp
80101111:	89 e5                	mov    %esp,%ebp
80101113:	57                   	push   %edi
80101114:	56                   	push   %esi
80101115:	53                   	push   %ebx
80101116:	83 ec 0c             	sub    $0xc,%esp
80101119:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010111c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010111f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80101122:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80101126:	74 60                	je     80101188 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80101128:	8b 03                	mov    (%ebx),%eax
8010112a:	83 f8 01             	cmp    $0x1,%eax
8010112d:	74 41                	je     80101170 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010112f:	83 f8 02             	cmp    $0x2,%eax
80101132:	75 5b                	jne    8010118f <fileread+0x7f>
    ilock(f->ip);
80101134:	83 ec 0c             	sub    $0xc,%esp
80101137:	ff 73 10             	push   0x10(%ebx)
8010113a:	e8 31 07 00 00       	call   80101870 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
8010113f:	57                   	push   %edi
80101140:	ff 73 14             	push   0x14(%ebx)
80101143:	56                   	push   %esi
80101144:	ff 73 10             	push   0x10(%ebx)
80101147:	e8 34 0a 00 00       	call   80101b80 <readi>
8010114c:	83 c4 20             	add    $0x20,%esp
8010114f:	89 c6                	mov    %eax,%esi
80101151:	85 c0                	test   %eax,%eax
80101153:	7e 03                	jle    80101158 <fileread+0x48>
      f->off += r;
80101155:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80101158:	83 ec 0c             	sub    $0xc,%esp
8010115b:	ff 73 10             	push   0x10(%ebx)
8010115e:	e8 ed 07 00 00       	call   80101950 <iunlock>
    return r;
80101163:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80101166:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101169:	89 f0                	mov    %esi,%eax
8010116b:	5b                   	pop    %ebx
8010116c:	5e                   	pop    %esi
8010116d:	5f                   	pop    %edi
8010116e:	5d                   	pop    %ebp
8010116f:	c3                   	ret
    return piperead(f->pipe, addr, n);
80101170:	8b 43 0c             	mov    0xc(%ebx),%eax
80101173:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101176:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101179:	5b                   	pop    %ebx
8010117a:	5e                   	pop    %esi
8010117b:	5f                   	pop    %edi
8010117c:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
8010117d:	e9 0e 26 00 00       	jmp    80103790 <piperead>
80101182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80101188:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010118d:	eb d7                	jmp    80101166 <fileread+0x56>
  panic("fileread");
8010118f:	83 ec 0c             	sub    $0xc,%esp
80101192:	68 d5 72 10 80       	push   $0x801072d5
80101197:	e8 e4 f1 ff ff       	call   80100380 <panic>
8010119c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801011a0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801011a0:	55                   	push   %ebp
801011a1:	89 e5                	mov    %esp,%ebp
801011a3:	57                   	push   %edi
801011a4:	56                   	push   %esi
801011a5:	53                   	push   %ebx
801011a6:	83 ec 1c             	sub    $0x1c,%esp
801011a9:	8b 45 0c             	mov    0xc(%ebp),%eax
801011ac:	8b 5d 08             	mov    0x8(%ebp),%ebx
801011af:	89 45 dc             	mov    %eax,-0x24(%ebp)
801011b2:	8b 45 10             	mov    0x10(%ebp),%eax
  int r;

  if(f->writable == 0)
801011b5:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
{
801011b9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
801011bc:	0f 84 bb 00 00 00    	je     8010127d <filewrite+0xdd>
    return -1;
  if(f->type == FD_PIPE)
801011c2:	8b 03                	mov    (%ebx),%eax
801011c4:	83 f8 01             	cmp    $0x1,%eax
801011c7:	0f 84 bf 00 00 00    	je     8010128c <filewrite+0xec>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
801011cd:	83 f8 02             	cmp    $0x2,%eax
801011d0:	0f 85 c8 00 00 00    	jne    8010129e <filewrite+0xfe>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
801011d6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
801011d9:	31 f6                	xor    %esi,%esi
    while(i < n){
801011db:	85 c0                	test   %eax,%eax
801011dd:	7f 30                	jg     8010120f <filewrite+0x6f>
801011df:	e9 94 00 00 00       	jmp    80101278 <filewrite+0xd8>
801011e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
801011e8:	01 43 14             	add    %eax,0x14(%ebx)
      iunlock(f->ip);
801011eb:	83 ec 0c             	sub    $0xc,%esp
        f->off += r;
801011ee:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
801011f1:	ff 73 10             	push   0x10(%ebx)
801011f4:	e8 57 07 00 00       	call   80101950 <iunlock>
      end_op();
801011f9:	e8 82 1c 00 00       	call   80102e80 <end_op>

      if(r < 0)
        break;
      if(r != n1)
801011fe:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101201:	83 c4 10             	add    $0x10,%esp
80101204:	39 c7                	cmp    %eax,%edi
80101206:	75 5c                	jne    80101264 <filewrite+0xc4>
        panic("short filewrite");
      i += r;
80101208:	01 fe                	add    %edi,%esi
    while(i < n){
8010120a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010120d:	7e 69                	jle    80101278 <filewrite+0xd8>
      int n1 = n - i;
8010120f:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      if(n1 > max)
80101212:	b8 00 06 00 00       	mov    $0x600,%eax
      int n1 = n - i;
80101217:	29 f7                	sub    %esi,%edi
      if(n1 > max)
80101219:	39 c7                	cmp    %eax,%edi
8010121b:	0f 4f f8             	cmovg  %eax,%edi
      begin_op();
8010121e:	e8 ed 1b 00 00       	call   80102e10 <begin_op>
      ilock(f->ip);
80101223:	83 ec 0c             	sub    $0xc,%esp
80101226:	ff 73 10             	push   0x10(%ebx)
80101229:	e8 42 06 00 00       	call   80101870 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
8010122e:	57                   	push   %edi
8010122f:	ff 73 14             	push   0x14(%ebx)
80101232:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101235:	01 f0                	add    %esi,%eax
80101237:	50                   	push   %eax
80101238:	ff 73 10             	push   0x10(%ebx)
8010123b:	e8 40 0a 00 00       	call   80101c80 <writei>
80101240:	83 c4 20             	add    $0x20,%esp
80101243:	85 c0                	test   %eax,%eax
80101245:	7f a1                	jg     801011e8 <filewrite+0x48>
80101247:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
8010124a:	83 ec 0c             	sub    $0xc,%esp
8010124d:	ff 73 10             	push   0x10(%ebx)
80101250:	e8 fb 06 00 00       	call   80101950 <iunlock>
      end_op();
80101255:	e8 26 1c 00 00       	call   80102e80 <end_op>
      if(r < 0)
8010125a:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010125d:	83 c4 10             	add    $0x10,%esp
80101260:	85 c0                	test   %eax,%eax
80101262:	75 14                	jne    80101278 <filewrite+0xd8>
        panic("short filewrite");
80101264:	83 ec 0c             	sub    $0xc,%esp
80101267:	68 de 72 10 80       	push   $0x801072de
8010126c:	e8 0f f1 ff ff       	call   80100380 <panic>
80101271:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
    return i == n ? n : -1;
80101278:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
8010127b:	74 05                	je     80101282 <filewrite+0xe2>
8010127d:	be ff ff ff ff       	mov    $0xffffffff,%esi
  }
  panic("filewrite");
}
80101282:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101285:	89 f0                	mov    %esi,%eax
80101287:	5b                   	pop    %ebx
80101288:	5e                   	pop    %esi
80101289:	5f                   	pop    %edi
8010128a:	5d                   	pop    %ebp
8010128b:	c3                   	ret
    return pipewrite(f->pipe, addr, n);
8010128c:	8b 43 0c             	mov    0xc(%ebx),%eax
8010128f:	89 45 08             	mov    %eax,0x8(%ebp)
}
80101292:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101295:	5b                   	pop    %ebx
80101296:	5e                   	pop    %esi
80101297:	5f                   	pop    %edi
80101298:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
80101299:	e9 d2 23 00 00       	jmp    80103670 <pipewrite>
  panic("filewrite");
8010129e:	83 ec 0c             	sub    $0xc,%esp
801012a1:	68 e4 72 10 80       	push   $0x801072e4
801012a6:	e8 d5 f0 ff ff       	call   80100380 <panic>
801012ab:	66 90                	xchg   %ax,%ax
801012ad:	66 90                	xchg   %ax,%ax
801012af:	90                   	nop

801012b0 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801012b0:	55                   	push   %ebp
801012b1:	89 e5                	mov    %esp,%ebp
801012b3:	57                   	push   %edi
801012b4:	56                   	push   %esi
801012b5:	53                   	push   %ebx
801012b6:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
801012b9:	8b 0d b4 15 11 80    	mov    0x801115b4,%ecx
{
801012bf:	89 45 dc             	mov    %eax,-0x24(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801012c2:	85 c9                	test   %ecx,%ecx
801012c4:	0f 84 8c 00 00 00    	je     80101356 <balloc+0xa6>
801012ca:	31 ff                	xor    %edi,%edi
    bp = bread(dev, BBLOCK(b, sb));
801012cc:	89 f8                	mov    %edi,%eax
801012ce:	83 ec 08             	sub    $0x8,%esp
801012d1:	89 fe                	mov    %edi,%esi
801012d3:	c1 f8 0c             	sar    $0xc,%eax
801012d6:	03 05 cc 15 11 80    	add    0x801115cc,%eax
801012dc:	50                   	push   %eax
801012dd:	ff 75 dc             	push   -0x24(%ebp)
801012e0:	e8 eb ed ff ff       	call   801000d0 <bread>
801012e5:	83 c4 10             	add    $0x10,%esp
801012e8:	89 7d d8             	mov    %edi,-0x28(%ebp)
801012eb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801012ee:	a1 b4 15 11 80       	mov    0x801115b4,%eax
801012f3:	89 45 e0             	mov    %eax,-0x20(%ebp)
801012f6:	31 c0                	xor    %eax,%eax
801012f8:	eb 32                	jmp    8010132c <balloc+0x7c>
801012fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101300:	89 c1                	mov    %eax,%ecx
80101302:	bb 01 00 00 00       	mov    $0x1,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101307:	8b 7d e4             	mov    -0x1c(%ebp),%edi
      m = 1 << (bi % 8);
8010130a:	83 e1 07             	and    $0x7,%ecx
8010130d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010130f:	89 c1                	mov    %eax,%ecx
80101311:	c1 f9 03             	sar    $0x3,%ecx
80101314:	0f b6 7c 0f 5c       	movzbl 0x5c(%edi,%ecx,1),%edi
80101319:	89 fa                	mov    %edi,%edx
8010131b:	85 df                	test   %ebx,%edi
8010131d:	74 49                	je     80101368 <balloc+0xb8>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010131f:	83 c0 01             	add    $0x1,%eax
80101322:	83 c6 01             	add    $0x1,%esi
80101325:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010132a:	74 07                	je     80101333 <balloc+0x83>
8010132c:	8b 55 e0             	mov    -0x20(%ebp),%edx
8010132f:	39 d6                	cmp    %edx,%esi
80101331:	72 cd                	jb     80101300 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101333:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101336:	83 ec 0c             	sub    $0xc,%esp
80101339:	ff 75 e4             	push   -0x1c(%ebp)
  for(b = 0; b < sb.size; b += BPB){
8010133c:	81 c7 00 10 00 00    	add    $0x1000,%edi
    brelse(bp);
80101342:	e8 a9 ee ff ff       	call   801001f0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
80101347:	83 c4 10             	add    $0x10,%esp
8010134a:	3b 3d b4 15 11 80    	cmp    0x801115b4,%edi
80101350:	0f 82 76 ff ff ff    	jb     801012cc <balloc+0x1c>
  }
  panic("balloc: out of blocks");
80101356:	83 ec 0c             	sub    $0xc,%esp
80101359:	68 ee 72 10 80       	push   $0x801072ee
8010135e:	e8 1d f0 ff ff       	call   80100380 <panic>
80101363:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        bp->data[bi/8] |= m;  // Mark block in use.
80101368:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
8010136b:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
8010136e:	09 da                	or     %ebx,%edx
80101370:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
80101374:	57                   	push   %edi
80101375:	e8 76 1c 00 00       	call   80102ff0 <log_write>
        brelse(bp);
8010137a:	89 3c 24             	mov    %edi,(%esp)
8010137d:	e8 6e ee ff ff       	call   801001f0 <brelse>
  bp = bread(dev, bno);
80101382:	58                   	pop    %eax
80101383:	5a                   	pop    %edx
80101384:	56                   	push   %esi
80101385:	ff 75 dc             	push   -0x24(%ebp)
80101388:	e8 43 ed ff ff       	call   801000d0 <bread>
  memset(bp->data, 0, BSIZE);
8010138d:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, bno);
80101390:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
80101392:	8d 40 5c             	lea    0x5c(%eax),%eax
80101395:	68 00 02 00 00       	push   $0x200
8010139a:	6a 00                	push   $0x0
8010139c:	50                   	push   %eax
8010139d:	e8 ce 33 00 00       	call   80104770 <memset>
  log_write(bp);
801013a2:	89 1c 24             	mov    %ebx,(%esp)
801013a5:	e8 46 1c 00 00       	call   80102ff0 <log_write>
  brelse(bp);
801013aa:	89 1c 24             	mov    %ebx,(%esp)
801013ad:	e8 3e ee ff ff       	call   801001f0 <brelse>
}
801013b2:	8d 65 f4             	lea    -0xc(%ebp),%esp
801013b5:	89 f0                	mov    %esi,%eax
801013b7:	5b                   	pop    %ebx
801013b8:	5e                   	pop    %esi
801013b9:	5f                   	pop    %edi
801013ba:	5d                   	pop    %ebp
801013bb:	c3                   	ret
801013bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801013c0 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801013c0:	55                   	push   %ebp
801013c1:	89 e5                	mov    %esp,%ebp
801013c3:	57                   	push   %edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
801013c4:	31 ff                	xor    %edi,%edi
{
801013c6:	56                   	push   %esi
801013c7:	89 c6                	mov    %eax,%esi
801013c9:	53                   	push   %ebx
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013ca:	bb 94 f9 10 80       	mov    $0x8010f994,%ebx
{
801013cf:	83 ec 28             	sub    $0x28,%esp
801013d2:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
801013d5:	68 60 f9 10 80       	push   $0x8010f960
801013da:	e8 91 32 00 00       	call   80104670 <acquire>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013df:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  acquire(&icache.lock);
801013e2:	83 c4 10             	add    $0x10,%esp
801013e5:	eb 1b                	jmp    80101402 <iget+0x42>
801013e7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801013ee:	00 
801013ef:	90                   	nop
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801013f0:	39 33                	cmp    %esi,(%ebx)
801013f2:	74 6c                	je     80101460 <iget+0xa0>
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
801013f4:	81 c3 90 00 00 00    	add    $0x90,%ebx
801013fa:	81 fb b4 15 11 80    	cmp    $0x801115b4,%ebx
80101400:	74 26                	je     80101428 <iget+0x68>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101402:	8b 43 08             	mov    0x8(%ebx),%eax
80101405:	85 c0                	test   %eax,%eax
80101407:	7f e7                	jg     801013f0 <iget+0x30>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101409:	85 ff                	test   %edi,%edi
8010140b:	75 e7                	jne    801013f4 <iget+0x34>
8010140d:	85 c0                	test   %eax,%eax
8010140f:	75 76                	jne    80101487 <iget+0xc7>
      empty = ip;
80101411:	89 df                	mov    %ebx,%edi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101413:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101419:	81 fb b4 15 11 80    	cmp    $0x801115b4,%ebx
8010141f:	75 e1                	jne    80101402 <iget+0x42>
80101421:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101428:	85 ff                	test   %edi,%edi
8010142a:	74 79                	je     801014a5 <iget+0xe5>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
8010142c:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
8010142f:	89 37                	mov    %esi,(%edi)
  ip->inum = inum;
80101431:	89 57 04             	mov    %edx,0x4(%edi)
  ip->ref = 1;
80101434:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
  ip->valid = 0;
8010143b:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
  release(&icache.lock);
80101442:	68 60 f9 10 80       	push   $0x8010f960
80101447:	e8 c4 31 00 00       	call   80104610 <release>

  return ip;
8010144c:	83 c4 10             	add    $0x10,%esp
}
8010144f:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101452:	89 f8                	mov    %edi,%eax
80101454:	5b                   	pop    %ebx
80101455:	5e                   	pop    %esi
80101456:	5f                   	pop    %edi
80101457:	5d                   	pop    %ebp
80101458:	c3                   	ret
80101459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101460:	39 53 04             	cmp    %edx,0x4(%ebx)
80101463:	75 8f                	jne    801013f4 <iget+0x34>
      ip->ref++;
80101465:	83 c0 01             	add    $0x1,%eax
      release(&icache.lock);
80101468:	83 ec 0c             	sub    $0xc,%esp
      return ip;
8010146b:	89 df                	mov    %ebx,%edi
      ip->ref++;
8010146d:	89 43 08             	mov    %eax,0x8(%ebx)
      release(&icache.lock);
80101470:	68 60 f9 10 80       	push   $0x8010f960
80101475:	e8 96 31 00 00       	call   80104610 <release>
      return ip;
8010147a:	83 c4 10             	add    $0x10,%esp
}
8010147d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101480:	89 f8                	mov    %edi,%eax
80101482:	5b                   	pop    %ebx
80101483:	5e                   	pop    %esi
80101484:	5f                   	pop    %edi
80101485:	5d                   	pop    %ebp
80101486:	c3                   	ret
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101487:	81 c3 90 00 00 00    	add    $0x90,%ebx
8010148d:	81 fb b4 15 11 80    	cmp    $0x801115b4,%ebx
80101493:	74 10                	je     801014a5 <iget+0xe5>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101495:	8b 43 08             	mov    0x8(%ebx),%eax
80101498:	85 c0                	test   %eax,%eax
8010149a:	0f 8f 50 ff ff ff    	jg     801013f0 <iget+0x30>
801014a0:	e9 68 ff ff ff       	jmp    8010140d <iget+0x4d>
    panic("iget: no inodes");
801014a5:	83 ec 0c             	sub    $0xc,%esp
801014a8:	68 04 73 10 80       	push   $0x80107304
801014ad:	e8 ce ee ff ff       	call   80100380 <panic>
801014b2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801014b9:	00 
801014ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801014c0 <bfree>:
{
801014c0:	55                   	push   %ebp
801014c1:	89 c1                	mov    %eax,%ecx
  bp = bread(dev, BBLOCK(b, sb));
801014c3:	89 d0                	mov    %edx,%eax
801014c5:	c1 e8 0c             	shr    $0xc,%eax
{
801014c8:	89 e5                	mov    %esp,%ebp
801014ca:	56                   	push   %esi
801014cb:	53                   	push   %ebx
  bp = bread(dev, BBLOCK(b, sb));
801014cc:	03 05 cc 15 11 80    	add    0x801115cc,%eax
{
801014d2:	89 d3                	mov    %edx,%ebx
  bp = bread(dev, BBLOCK(b, sb));
801014d4:	83 ec 08             	sub    $0x8,%esp
801014d7:	50                   	push   %eax
801014d8:	51                   	push   %ecx
801014d9:	e8 f2 eb ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
801014de:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
801014e0:	c1 fb 03             	sar    $0x3,%ebx
801014e3:	83 c4 10             	add    $0x10,%esp
  bp = bread(dev, BBLOCK(b, sb));
801014e6:	89 c6                	mov    %eax,%esi
  m = 1 << (bi % 8);
801014e8:	83 e1 07             	and    $0x7,%ecx
801014eb:	b8 01 00 00 00       	mov    $0x1,%eax
  if((bp->data[bi/8] & m) == 0)
801014f0:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
  m = 1 << (bi % 8);
801014f6:	d3 e0                	shl    %cl,%eax
  if((bp->data[bi/8] & m) == 0)
801014f8:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
801014fd:	85 c1                	test   %eax,%ecx
801014ff:	74 23                	je     80101524 <bfree+0x64>
  bp->data[bi/8] &= ~m;
80101501:	f7 d0                	not    %eax
  log_write(bp);
80101503:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101506:	21 c8                	and    %ecx,%eax
80101508:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
  log_write(bp);
8010150c:	56                   	push   %esi
8010150d:	e8 de 1a 00 00       	call   80102ff0 <log_write>
  brelse(bp);
80101512:	89 34 24             	mov    %esi,(%esp)
80101515:	e8 d6 ec ff ff       	call   801001f0 <brelse>
}
8010151a:	83 c4 10             	add    $0x10,%esp
8010151d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101520:	5b                   	pop    %ebx
80101521:	5e                   	pop    %esi
80101522:	5d                   	pop    %ebp
80101523:	c3                   	ret
    panic("freeing free block");
80101524:	83 ec 0c             	sub    $0xc,%esp
80101527:	68 14 73 10 80       	push   $0x80107314
8010152c:	e8 4f ee ff ff       	call   80100380 <panic>
80101531:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101538:	00 
80101539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101540 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101540:	55                   	push   %ebp
80101541:	89 e5                	mov    %esp,%ebp
80101543:	57                   	push   %edi
80101544:	56                   	push   %esi
80101545:	89 c6                	mov    %eax,%esi
80101547:	53                   	push   %ebx
80101548:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
8010154b:	83 fa 0b             	cmp    $0xb,%edx
8010154e:	0f 86 8c 00 00 00    	jbe    801015e0 <bmap+0xa0>
    if((addr = ip->addrs[bn]) == 0)
      ip->addrs[bn] = addr = balloc(ip->dev);
    return addr;
  }
  bn -= NDIRECT;
80101554:	8d 5a f4             	lea    -0xc(%edx),%ebx

  if(bn < NINDIRECT){
80101557:	83 fb 7f             	cmp    $0x7f,%ebx
8010155a:	0f 87 a2 00 00 00    	ja     80101602 <bmap+0xc2>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101560:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101566:	85 c0                	test   %eax,%eax
80101568:	74 5e                	je     801015c8 <bmap+0x88>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    bp = bread(ip->dev, addr);
8010156a:	83 ec 08             	sub    $0x8,%esp
8010156d:	50                   	push   %eax
8010156e:	ff 36                	push   (%esi)
80101570:	e8 5b eb ff ff       	call   801000d0 <bread>
    a = (uint*)bp->data;
    if((addr = a[bn]) == 0){
80101575:	83 c4 10             	add    $0x10,%esp
80101578:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
    bp = bread(ip->dev, addr);
8010157c:	89 c2                	mov    %eax,%edx
    if((addr = a[bn]) == 0){
8010157e:	8b 3b                	mov    (%ebx),%edi
80101580:	85 ff                	test   %edi,%edi
80101582:	74 1c                	je     801015a0 <bmap+0x60>
      a[bn] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
80101584:	83 ec 0c             	sub    $0xc,%esp
80101587:	52                   	push   %edx
80101588:	e8 63 ec ff ff       	call   801001f0 <brelse>
8010158d:	83 c4 10             	add    $0x10,%esp
    return addr;
  }

  panic("bmap: out of range");
}
80101590:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101593:	89 f8                	mov    %edi,%eax
80101595:	5b                   	pop    %ebx
80101596:	5e                   	pop    %esi
80101597:	5f                   	pop    %edi
80101598:	5d                   	pop    %ebp
80101599:	c3                   	ret
8010159a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801015a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      a[bn] = addr = balloc(ip->dev);
801015a3:	8b 06                	mov    (%esi),%eax
801015a5:	e8 06 fd ff ff       	call   801012b0 <balloc>
      log_write(bp);
801015aa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801015ad:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
801015b0:	89 03                	mov    %eax,(%ebx)
801015b2:	89 c7                	mov    %eax,%edi
      log_write(bp);
801015b4:	52                   	push   %edx
801015b5:	e8 36 1a 00 00       	call   80102ff0 <log_write>
801015ba:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801015bd:	83 c4 10             	add    $0x10,%esp
801015c0:	eb c2                	jmp    80101584 <bmap+0x44>
801015c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801015c8:	8b 06                	mov    (%esi),%eax
801015ca:	e8 e1 fc ff ff       	call   801012b0 <balloc>
801015cf:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801015d5:	eb 93                	jmp    8010156a <bmap+0x2a>
801015d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801015de:	00 
801015df:	90                   	nop
    if((addr = ip->addrs[bn]) == 0)
801015e0:	8d 5a 14             	lea    0x14(%edx),%ebx
801015e3:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
801015e7:	85 ff                	test   %edi,%edi
801015e9:	75 a5                	jne    80101590 <bmap+0x50>
      ip->addrs[bn] = addr = balloc(ip->dev);
801015eb:	8b 00                	mov    (%eax),%eax
801015ed:	e8 be fc ff ff       	call   801012b0 <balloc>
801015f2:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
801015f6:	89 c7                	mov    %eax,%edi
}
801015f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801015fb:	5b                   	pop    %ebx
801015fc:	89 f8                	mov    %edi,%eax
801015fe:	5e                   	pop    %esi
801015ff:	5f                   	pop    %edi
80101600:	5d                   	pop    %ebp
80101601:	c3                   	ret
  panic("bmap: out of range");
80101602:	83 ec 0c             	sub    $0xc,%esp
80101605:	68 27 73 10 80       	push   $0x80107327
8010160a:	e8 71 ed ff ff       	call   80100380 <panic>
8010160f:	90                   	nop

80101610 <readsb>:
{
80101610:	55                   	push   %ebp
80101611:	89 e5                	mov    %esp,%ebp
80101613:	56                   	push   %esi
80101614:	53                   	push   %ebx
80101615:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
80101618:	83 ec 08             	sub    $0x8,%esp
8010161b:	6a 01                	push   $0x1
8010161d:	ff 75 08             	push   0x8(%ebp)
80101620:	e8 ab ea ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
80101625:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
80101628:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
8010162a:	8d 40 5c             	lea    0x5c(%eax),%eax
8010162d:	6a 1c                	push   $0x1c
8010162f:	50                   	push   %eax
80101630:	56                   	push   %esi
80101631:	e8 ca 31 00 00       	call   80104800 <memmove>
  brelse(bp);
80101636:	83 c4 10             	add    $0x10,%esp
80101639:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010163c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010163f:	5b                   	pop    %ebx
80101640:	5e                   	pop    %esi
80101641:	5d                   	pop    %ebp
  brelse(bp);
80101642:	e9 a9 eb ff ff       	jmp    801001f0 <brelse>
80101647:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010164e:	00 
8010164f:	90                   	nop

80101650 <iinit>:
{
80101650:	55                   	push   %ebp
80101651:	89 e5                	mov    %esp,%ebp
80101653:	53                   	push   %ebx
80101654:	bb a0 f9 10 80       	mov    $0x8010f9a0,%ebx
80101659:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010165c:	68 3a 73 10 80       	push   $0x8010733a
80101661:	68 60 f9 10 80       	push   $0x8010f960
80101666:	e8 15 2e 00 00       	call   80104480 <initlock>
  for(i = 0; i < NINODE; i++) {
8010166b:	83 c4 10             	add    $0x10,%esp
8010166e:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
80101670:	83 ec 08             	sub    $0x8,%esp
80101673:	68 41 73 10 80       	push   $0x80107341
80101678:	53                   	push   %ebx
  for(i = 0; i < NINODE; i++) {
80101679:	81 c3 90 00 00 00    	add    $0x90,%ebx
    initsleeplock(&icache.inode[i].lock, "inode");
8010167f:	e8 cc 2c 00 00       	call   80104350 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
80101684:	83 c4 10             	add    $0x10,%esp
80101687:	81 fb c0 15 11 80    	cmp    $0x801115c0,%ebx
8010168d:	75 e1                	jne    80101670 <iinit+0x20>
  bp = bread(dev, 1);
8010168f:	83 ec 08             	sub    $0x8,%esp
80101692:	6a 01                	push   $0x1
80101694:	ff 75 08             	push   0x8(%ebp)
80101697:	e8 34 ea ff ff       	call   801000d0 <bread>
  memmove(sb, bp->data, sizeof(*sb));
8010169c:	83 c4 0c             	add    $0xc,%esp
  bp = bread(dev, 1);
8010169f:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801016a1:	8d 40 5c             	lea    0x5c(%eax),%eax
801016a4:	6a 1c                	push   $0x1c
801016a6:	50                   	push   %eax
801016a7:	68 b4 15 11 80       	push   $0x801115b4
801016ac:	e8 4f 31 00 00       	call   80104800 <memmove>
  brelse(bp);
801016b1:	89 1c 24             	mov    %ebx,(%esp)
801016b4:	e8 37 eb ff ff       	call   801001f0 <brelse>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801016b9:	ff 35 cc 15 11 80    	push   0x801115cc
801016bf:	ff 35 c8 15 11 80    	push   0x801115c8
801016c5:	ff 35 c4 15 11 80    	push   0x801115c4
801016cb:	ff 35 c0 15 11 80    	push   0x801115c0
801016d1:	ff 35 bc 15 11 80    	push   0x801115bc
801016d7:	ff 35 b8 15 11 80    	push   0x801115b8
801016dd:	ff 35 b4 15 11 80    	push   0x801115b4
801016e3:	68 54 77 10 80       	push   $0x80107754
801016e8:	e8 53 f0 ff ff       	call   80100740 <cprintf>
}
801016ed:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801016f0:	83 c4 30             	add    $0x30,%esp
801016f3:	c9                   	leave
801016f4:	c3                   	ret
801016f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801016fc:	00 
801016fd:	8d 76 00             	lea    0x0(%esi),%esi

80101700 <ialloc>:
{
80101700:	55                   	push   %ebp
80101701:	89 e5                	mov    %esp,%ebp
80101703:	57                   	push   %edi
80101704:	56                   	push   %esi
80101705:	53                   	push   %ebx
80101706:	83 ec 1c             	sub    $0x1c,%esp
80101709:	8b 45 0c             	mov    0xc(%ebp),%eax
  for(inum = 1; inum < sb.ninodes; inum++){
8010170c:	83 3d bc 15 11 80 01 	cmpl   $0x1,0x801115bc
{
80101713:	8b 75 08             	mov    0x8(%ebp),%esi
80101716:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101719:	0f 86 91 00 00 00    	jbe    801017b0 <ialloc+0xb0>
8010171f:	bf 01 00 00 00       	mov    $0x1,%edi
80101724:	eb 21                	jmp    80101747 <ialloc+0x47>
80101726:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010172d:	00 
8010172e:	66 90                	xchg   %ax,%ax
    brelse(bp);
80101730:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101733:	83 c7 01             	add    $0x1,%edi
    brelse(bp);
80101736:	53                   	push   %ebx
80101737:	e8 b4 ea ff ff       	call   801001f0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010173c:	83 c4 10             	add    $0x10,%esp
8010173f:	3b 3d bc 15 11 80    	cmp    0x801115bc,%edi
80101745:	73 69                	jae    801017b0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101747:	89 f8                	mov    %edi,%eax
80101749:	83 ec 08             	sub    $0x8,%esp
8010174c:	c1 e8 03             	shr    $0x3,%eax
8010174f:	03 05 c8 15 11 80    	add    0x801115c8,%eax
80101755:	50                   	push   %eax
80101756:	56                   	push   %esi
80101757:	e8 74 e9 ff ff       	call   801000d0 <bread>
    if(dip->type == 0){  // a free inode
8010175c:	83 c4 10             	add    $0x10,%esp
    bp = bread(dev, IBLOCK(inum, sb));
8010175f:	89 c3                	mov    %eax,%ebx
    dip = (struct dinode*)bp->data + inum%IPB;
80101761:	89 f8                	mov    %edi,%eax
80101763:	83 e0 07             	and    $0x7,%eax
80101766:	c1 e0 06             	shl    $0x6,%eax
80101769:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010176d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101771:	75 bd                	jne    80101730 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101773:	83 ec 04             	sub    $0x4,%esp
80101776:	6a 40                	push   $0x40
80101778:	6a 00                	push   $0x0
8010177a:	51                   	push   %ecx
8010177b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010177e:	e8 ed 2f 00 00       	call   80104770 <memset>
      dip->type = type;
80101783:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101787:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010178a:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
8010178d:	89 1c 24             	mov    %ebx,(%esp)
80101790:	e8 5b 18 00 00       	call   80102ff0 <log_write>
      brelse(bp);
80101795:	89 1c 24             	mov    %ebx,(%esp)
80101798:	e8 53 ea ff ff       	call   801001f0 <brelse>
      return iget(dev, inum);
8010179d:	83 c4 10             	add    $0x10,%esp
}
801017a0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801017a3:	89 fa                	mov    %edi,%edx
}
801017a5:	5b                   	pop    %ebx
      return iget(dev, inum);
801017a6:	89 f0                	mov    %esi,%eax
}
801017a8:	5e                   	pop    %esi
801017a9:	5f                   	pop    %edi
801017aa:	5d                   	pop    %ebp
      return iget(dev, inum);
801017ab:	e9 10 fc ff ff       	jmp    801013c0 <iget>
  panic("ialloc: no inodes");
801017b0:	83 ec 0c             	sub    $0xc,%esp
801017b3:	68 47 73 10 80       	push   $0x80107347
801017b8:	e8 c3 eb ff ff       	call   80100380 <panic>
801017bd:	8d 76 00             	lea    0x0(%esi),%esi

801017c0 <iupdate>:
{
801017c0:	55                   	push   %ebp
801017c1:	89 e5                	mov    %esp,%ebp
801017c3:	56                   	push   %esi
801017c4:	53                   	push   %ebx
801017c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017c8:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017cb:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017ce:	83 ec 08             	sub    $0x8,%esp
801017d1:	c1 e8 03             	shr    $0x3,%eax
801017d4:	03 05 c8 15 11 80    	add    0x801115c8,%eax
801017da:	50                   	push   %eax
801017db:	ff 73 a4             	push   -0x5c(%ebx)
801017de:	e8 ed e8 ff ff       	call   801000d0 <bread>
  dip->type = ip->type;
801017e3:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801017e7:	83 c4 0c             	add    $0xc,%esp
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801017ea:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
801017ec:	8b 43 a8             	mov    -0x58(%ebx),%eax
801017ef:	83 e0 07             	and    $0x7,%eax
801017f2:	c1 e0 06             	shl    $0x6,%eax
801017f5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
801017f9:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
801017fc:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101800:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101803:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101807:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010180b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010180f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101813:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101817:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010181a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010181d:	6a 34                	push   $0x34
8010181f:	53                   	push   %ebx
80101820:	50                   	push   %eax
80101821:	e8 da 2f 00 00       	call   80104800 <memmove>
  log_write(bp);
80101826:	89 34 24             	mov    %esi,(%esp)
80101829:	e8 c2 17 00 00       	call   80102ff0 <log_write>
  brelse(bp);
8010182e:	83 c4 10             	add    $0x10,%esp
80101831:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101834:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101837:	5b                   	pop    %ebx
80101838:	5e                   	pop    %esi
80101839:	5d                   	pop    %ebp
  brelse(bp);
8010183a:	e9 b1 e9 ff ff       	jmp    801001f0 <brelse>
8010183f:	90                   	nop

80101840 <idup>:
{
80101840:	55                   	push   %ebp
80101841:	89 e5                	mov    %esp,%ebp
80101843:	53                   	push   %ebx
80101844:	83 ec 10             	sub    $0x10,%esp
80101847:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010184a:	68 60 f9 10 80       	push   $0x8010f960
8010184f:	e8 1c 2e 00 00       	call   80104670 <acquire>
  ip->ref++;
80101854:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101858:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
8010185f:	e8 ac 2d 00 00       	call   80104610 <release>
}
80101864:	89 d8                	mov    %ebx,%eax
80101866:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101869:	c9                   	leave
8010186a:	c3                   	ret
8010186b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101870 <ilock>:
{
80101870:	55                   	push   %ebp
80101871:	89 e5                	mov    %esp,%ebp
80101873:	56                   	push   %esi
80101874:	53                   	push   %ebx
80101875:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101878:	85 db                	test   %ebx,%ebx
8010187a:	0f 84 b7 00 00 00    	je     80101937 <ilock+0xc7>
80101880:	8b 53 08             	mov    0x8(%ebx),%edx
80101883:	85 d2                	test   %edx,%edx
80101885:	0f 8e ac 00 00 00    	jle    80101937 <ilock+0xc7>
  acquiresleep(&ip->lock);
8010188b:	83 ec 0c             	sub    $0xc,%esp
8010188e:	8d 43 0c             	lea    0xc(%ebx),%eax
80101891:	50                   	push   %eax
80101892:	e8 f9 2a 00 00       	call   80104390 <acquiresleep>
  if(ip->valid == 0){
80101897:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010189a:	83 c4 10             	add    $0x10,%esp
8010189d:	85 c0                	test   %eax,%eax
8010189f:	74 0f                	je     801018b0 <ilock+0x40>
}
801018a1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801018a4:	5b                   	pop    %ebx
801018a5:	5e                   	pop    %esi
801018a6:	5d                   	pop    %ebp
801018a7:	c3                   	ret
801018a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801018af:	00 
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018b0:	8b 43 04             	mov    0x4(%ebx),%eax
801018b3:	83 ec 08             	sub    $0x8,%esp
801018b6:	c1 e8 03             	shr    $0x3,%eax
801018b9:	03 05 c8 15 11 80    	add    0x801115c8,%eax
801018bf:	50                   	push   %eax
801018c0:	ff 33                	push   (%ebx)
801018c2:	e8 09 e8 ff ff       	call   801000d0 <bread>
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018c7:	83 c4 0c             	add    $0xc,%esp
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801018ca:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801018cc:	8b 43 04             	mov    0x4(%ebx),%eax
801018cf:	83 e0 07             	and    $0x7,%eax
801018d2:	c1 e0 06             	shl    $0x6,%eax
801018d5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801018d9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801018dc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801018df:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
801018e3:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
801018e7:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
801018eb:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
801018ef:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
801018f3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801018f7:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
801018fb:	8b 50 fc             	mov    -0x4(%eax),%edx
801018fe:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101901:	6a 34                	push   $0x34
80101903:	50                   	push   %eax
80101904:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101907:	50                   	push   %eax
80101908:	e8 f3 2e 00 00       	call   80104800 <memmove>
    brelse(bp);
8010190d:	89 34 24             	mov    %esi,(%esp)
80101910:	e8 db e8 ff ff       	call   801001f0 <brelse>
    if(ip->type == 0)
80101915:	83 c4 10             	add    $0x10,%esp
80101918:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010191d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101924:	0f 85 77 ff ff ff    	jne    801018a1 <ilock+0x31>
      panic("ilock: no type");
8010192a:	83 ec 0c             	sub    $0xc,%esp
8010192d:	68 5f 73 10 80       	push   $0x8010735f
80101932:	e8 49 ea ff ff       	call   80100380 <panic>
    panic("ilock");
80101937:	83 ec 0c             	sub    $0xc,%esp
8010193a:	68 59 73 10 80       	push   $0x80107359
8010193f:	e8 3c ea ff ff       	call   80100380 <panic>
80101944:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010194b:	00 
8010194c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101950 <iunlock>:
{
80101950:	55                   	push   %ebp
80101951:	89 e5                	mov    %esp,%ebp
80101953:	56                   	push   %esi
80101954:	53                   	push   %ebx
80101955:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101958:	85 db                	test   %ebx,%ebx
8010195a:	74 28                	je     80101984 <iunlock+0x34>
8010195c:	83 ec 0c             	sub    $0xc,%esp
8010195f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101962:	56                   	push   %esi
80101963:	e8 c8 2a 00 00       	call   80104430 <holdingsleep>
80101968:	83 c4 10             	add    $0x10,%esp
8010196b:	85 c0                	test   %eax,%eax
8010196d:	74 15                	je     80101984 <iunlock+0x34>
8010196f:	8b 43 08             	mov    0x8(%ebx),%eax
80101972:	85 c0                	test   %eax,%eax
80101974:	7e 0e                	jle    80101984 <iunlock+0x34>
  releasesleep(&ip->lock);
80101976:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101979:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010197c:	5b                   	pop    %ebx
8010197d:	5e                   	pop    %esi
8010197e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010197f:	e9 6c 2a 00 00       	jmp    801043f0 <releasesleep>
    panic("iunlock");
80101984:	83 ec 0c             	sub    $0xc,%esp
80101987:	68 6e 73 10 80       	push   $0x8010736e
8010198c:	e8 ef e9 ff ff       	call   80100380 <panic>
80101991:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101998:	00 
80101999:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801019a0 <iput>:
{
801019a0:	55                   	push   %ebp
801019a1:	89 e5                	mov    %esp,%ebp
801019a3:	57                   	push   %edi
801019a4:	56                   	push   %esi
801019a5:	53                   	push   %ebx
801019a6:	83 ec 28             	sub    $0x28,%esp
801019a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801019ac:	8d 7b 0c             	lea    0xc(%ebx),%edi
801019af:	57                   	push   %edi
801019b0:	e8 db 29 00 00       	call   80104390 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801019b5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801019b8:	83 c4 10             	add    $0x10,%esp
801019bb:	85 d2                	test   %edx,%edx
801019bd:	74 07                	je     801019c6 <iput+0x26>
801019bf:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801019c4:	74 32                	je     801019f8 <iput+0x58>
  releasesleep(&ip->lock);
801019c6:	83 ec 0c             	sub    $0xc,%esp
801019c9:	57                   	push   %edi
801019ca:	e8 21 2a 00 00       	call   801043f0 <releasesleep>
  acquire(&icache.lock);
801019cf:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
801019d6:	e8 95 2c 00 00       	call   80104670 <acquire>
  ip->ref--;
801019db:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801019df:	83 c4 10             	add    $0x10,%esp
801019e2:	c7 45 08 60 f9 10 80 	movl   $0x8010f960,0x8(%ebp)
}
801019e9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801019ec:	5b                   	pop    %ebx
801019ed:	5e                   	pop    %esi
801019ee:	5f                   	pop    %edi
801019ef:	5d                   	pop    %ebp
  release(&icache.lock);
801019f0:	e9 1b 2c 00 00       	jmp    80104610 <release>
801019f5:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
801019f8:	83 ec 0c             	sub    $0xc,%esp
801019fb:	68 60 f9 10 80       	push   $0x8010f960
80101a00:	e8 6b 2c 00 00       	call   80104670 <acquire>
    int r = ip->ref;
80101a05:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101a08:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
80101a0f:	e8 fc 2b 00 00       	call   80104610 <release>
    if(r == 1){
80101a14:	83 c4 10             	add    $0x10,%esp
80101a17:	83 fe 01             	cmp    $0x1,%esi
80101a1a:	75 aa                	jne    801019c6 <iput+0x26>
80101a1c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101a22:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101a25:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101a28:	89 df                	mov    %ebx,%edi
80101a2a:	89 cb                	mov    %ecx,%ebx
80101a2c:	eb 09                	jmp    80101a37 <iput+0x97>
80101a2e:	66 90                	xchg   %ax,%ax
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101a30:	83 c6 04             	add    $0x4,%esi
80101a33:	39 de                	cmp    %ebx,%esi
80101a35:	74 19                	je     80101a50 <iput+0xb0>
    if(ip->addrs[i]){
80101a37:	8b 16                	mov    (%esi),%edx
80101a39:	85 d2                	test   %edx,%edx
80101a3b:	74 f3                	je     80101a30 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
80101a3d:	8b 07                	mov    (%edi),%eax
80101a3f:	e8 7c fa ff ff       	call   801014c0 <bfree>
      ip->addrs[i] = 0;
80101a44:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80101a4a:	eb e4                	jmp    80101a30 <iput+0x90>
80101a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101a50:	89 fb                	mov    %edi,%ebx
80101a52:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101a55:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101a5b:	85 c0                	test   %eax,%eax
80101a5d:	75 2d                	jne    80101a8c <iput+0xec>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
80101a5f:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101a62:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101a69:	53                   	push   %ebx
80101a6a:	e8 51 fd ff ff       	call   801017c0 <iupdate>
      ip->type = 0;
80101a6f:	31 c0                	xor    %eax,%eax
80101a71:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101a75:	89 1c 24             	mov    %ebx,(%esp)
80101a78:	e8 43 fd ff ff       	call   801017c0 <iupdate>
      ip->valid = 0;
80101a7d:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80101a84:	83 c4 10             	add    $0x10,%esp
80101a87:	e9 3a ff ff ff       	jmp    801019c6 <iput+0x26>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101a8c:	83 ec 08             	sub    $0x8,%esp
80101a8f:	50                   	push   %eax
80101a90:	ff 33                	push   (%ebx)
80101a92:	e8 39 e6 ff ff       	call   801000d0 <bread>
    for(j = 0; j < NINDIRECT; j++){
80101a97:	83 c4 10             	add    $0x10,%esp
80101a9a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101a9d:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80101aa3:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101aa6:	8d 70 5c             	lea    0x5c(%eax),%esi
80101aa9:	89 cf                	mov    %ecx,%edi
80101aab:	eb 0a                	jmp    80101ab7 <iput+0x117>
80101aad:	8d 76 00             	lea    0x0(%esi),%esi
80101ab0:	83 c6 04             	add    $0x4,%esi
80101ab3:	39 fe                	cmp    %edi,%esi
80101ab5:	74 0f                	je     80101ac6 <iput+0x126>
      if(a[j])
80101ab7:	8b 16                	mov    (%esi),%edx
80101ab9:	85 d2                	test   %edx,%edx
80101abb:	74 f3                	je     80101ab0 <iput+0x110>
        bfree(ip->dev, a[j]);
80101abd:	8b 03                	mov    (%ebx),%eax
80101abf:	e8 fc f9 ff ff       	call   801014c0 <bfree>
80101ac4:	eb ea                	jmp    80101ab0 <iput+0x110>
    brelse(bp);
80101ac6:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101ac9:	83 ec 0c             	sub    $0xc,%esp
80101acc:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101acf:	50                   	push   %eax
80101ad0:	e8 1b e7 ff ff       	call   801001f0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101ad5:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101adb:	8b 03                	mov    (%ebx),%eax
80101add:	e8 de f9 ff ff       	call   801014c0 <bfree>
    ip->addrs[NDIRECT] = 0;
80101ae2:	83 c4 10             	add    $0x10,%esp
80101ae5:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101aec:	00 00 00 
80101aef:	e9 6b ff ff ff       	jmp    80101a5f <iput+0xbf>
80101af4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101afb:	00 
80101afc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101b00 <iunlockput>:
{
80101b00:	55                   	push   %ebp
80101b01:	89 e5                	mov    %esp,%ebp
80101b03:	56                   	push   %esi
80101b04:	53                   	push   %ebx
80101b05:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101b08:	85 db                	test   %ebx,%ebx
80101b0a:	74 34                	je     80101b40 <iunlockput+0x40>
80101b0c:	83 ec 0c             	sub    $0xc,%esp
80101b0f:	8d 73 0c             	lea    0xc(%ebx),%esi
80101b12:	56                   	push   %esi
80101b13:	e8 18 29 00 00       	call   80104430 <holdingsleep>
80101b18:	83 c4 10             	add    $0x10,%esp
80101b1b:	85 c0                	test   %eax,%eax
80101b1d:	74 21                	je     80101b40 <iunlockput+0x40>
80101b1f:	8b 43 08             	mov    0x8(%ebx),%eax
80101b22:	85 c0                	test   %eax,%eax
80101b24:	7e 1a                	jle    80101b40 <iunlockput+0x40>
  releasesleep(&ip->lock);
80101b26:	83 ec 0c             	sub    $0xc,%esp
80101b29:	56                   	push   %esi
80101b2a:	e8 c1 28 00 00       	call   801043f0 <releasesleep>
  iput(ip);
80101b2f:	83 c4 10             	add    $0x10,%esp
80101b32:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80101b35:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101b38:	5b                   	pop    %ebx
80101b39:	5e                   	pop    %esi
80101b3a:	5d                   	pop    %ebp
  iput(ip);
80101b3b:	e9 60 fe ff ff       	jmp    801019a0 <iput>
    panic("iunlock");
80101b40:	83 ec 0c             	sub    $0xc,%esp
80101b43:	68 6e 73 10 80       	push   $0x8010736e
80101b48:	e8 33 e8 ff ff       	call   80100380 <panic>
80101b4d:	8d 76 00             	lea    0x0(%esi),%esi

80101b50 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101b50:	55                   	push   %ebp
80101b51:	89 e5                	mov    %esp,%ebp
80101b53:	8b 55 08             	mov    0x8(%ebp),%edx
80101b56:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101b59:	8b 0a                	mov    (%edx),%ecx
80101b5b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
80101b5e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101b61:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101b64:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101b68:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
80101b6b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
80101b6f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101b73:	8b 52 58             	mov    0x58(%edx),%edx
80101b76:	89 50 10             	mov    %edx,0x10(%eax)
}
80101b79:	5d                   	pop    %ebp
80101b7a:	c3                   	ret
80101b7b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80101b80 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101b80:	55                   	push   %ebp
80101b81:	89 e5                	mov    %esp,%ebp
80101b83:	57                   	push   %edi
80101b84:	56                   	push   %esi
80101b85:	53                   	push   %ebx
80101b86:	83 ec 1c             	sub    $0x1c,%esp
80101b89:	8b 75 08             	mov    0x8(%ebp),%esi
80101b8c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101b8f:	8b 7d 10             	mov    0x10(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101b92:	66 83 7e 50 03       	cmpw   $0x3,0x50(%esi)
{
80101b97:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101b9a:	89 75 d8             	mov    %esi,-0x28(%ebp)
80101b9d:	8b 45 14             	mov    0x14(%ebp),%eax
  if(ip->type == T_DEV){
80101ba0:	0f 84 aa 00 00 00    	je     80101c50 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101ba6:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101ba9:	8b 56 58             	mov    0x58(%esi),%edx
80101bac:	39 fa                	cmp    %edi,%edx
80101bae:	0f 82 bd 00 00 00    	jb     80101c71 <readi+0xf1>
80101bb4:	89 f9                	mov    %edi,%ecx
80101bb6:	31 db                	xor    %ebx,%ebx
80101bb8:	01 c1                	add    %eax,%ecx
80101bba:	0f 92 c3             	setb   %bl
80101bbd:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80101bc0:	0f 82 ab 00 00 00    	jb     80101c71 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
80101bc6:	89 d3                	mov    %edx,%ebx
80101bc8:	29 fb                	sub    %edi,%ebx
80101bca:	39 ca                	cmp    %ecx,%edx
80101bcc:	0f 42 c3             	cmovb  %ebx,%eax

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101bcf:	85 c0                	test   %eax,%eax
80101bd1:	74 73                	je     80101c46 <readi+0xc6>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101bd3:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80101bd6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101be0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80101be3:	89 fa                	mov    %edi,%edx
80101be5:	c1 ea 09             	shr    $0x9,%edx
80101be8:	89 d8                	mov    %ebx,%eax
80101bea:	e8 51 f9 ff ff       	call   80101540 <bmap>
80101bef:	83 ec 08             	sub    $0x8,%esp
80101bf2:	50                   	push   %eax
80101bf3:	ff 33                	push   (%ebx)
80101bf5:	e8 d6 e4 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101bfa:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101bfd:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101c02:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
80101c04:	89 f8                	mov    %edi,%eax
80101c06:	25 ff 01 00 00       	and    $0x1ff,%eax
80101c0b:	29 f3                	sub    %esi,%ebx
80101c0d:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101c0f:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101c13:	39 d9                	cmp    %ebx,%ecx
80101c15:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101c18:	83 c4 0c             	add    $0xc,%esp
80101c1b:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c1c:	01 de                	add    %ebx,%esi
80101c1e:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101c20:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101c23:	50                   	push   %eax
80101c24:	ff 75 e0             	push   -0x20(%ebp)
80101c27:	e8 d4 2b 00 00       	call   80104800 <memmove>
    brelse(bp);
80101c2c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101c2f:	89 14 24             	mov    %edx,(%esp)
80101c32:	e8 b9 e5 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101c37:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101c3a:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101c3d:	83 c4 10             	add    $0x10,%esp
80101c40:	39 de                	cmp    %ebx,%esi
80101c42:	72 9c                	jb     80101be0 <readi+0x60>
80101c44:	89 d8                	mov    %ebx,%eax
  }
  return n;
}
80101c46:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c49:	5b                   	pop    %ebx
80101c4a:	5e                   	pop    %esi
80101c4b:	5f                   	pop    %edi
80101c4c:	5d                   	pop    %ebp
80101c4d:	c3                   	ret
80101c4e:	66 90                	xchg   %ax,%ax
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101c50:	0f bf 56 52          	movswl 0x52(%esi),%edx
80101c54:	66 83 fa 09          	cmp    $0x9,%dx
80101c58:	77 17                	ja     80101c71 <readi+0xf1>
80101c5a:	8b 14 d5 00 f9 10 80 	mov    -0x7fef0700(,%edx,8),%edx
80101c61:	85 d2                	test   %edx,%edx
80101c63:	74 0c                	je     80101c71 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101c65:	89 45 10             	mov    %eax,0x10(%ebp)
}
80101c68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c6b:	5b                   	pop    %ebx
80101c6c:	5e                   	pop    %esi
80101c6d:	5f                   	pop    %edi
80101c6e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101c6f:	ff e2                	jmp    *%edx
      return -1;
80101c71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101c76:	eb ce                	jmp    80101c46 <readi+0xc6>
80101c78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101c7f:	00 

80101c80 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101c80:	55                   	push   %ebp
80101c81:	89 e5                	mov    %esp,%ebp
80101c83:	57                   	push   %edi
80101c84:	56                   	push   %esi
80101c85:	53                   	push   %ebx
80101c86:	83 ec 1c             	sub    $0x1c,%esp
80101c89:	8b 45 08             	mov    0x8(%ebp),%eax
80101c8c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80101c8f:	8b 75 14             	mov    0x14(%ebp),%esi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101c92:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101c97:	89 7d dc             	mov    %edi,-0x24(%ebp)
80101c9a:	89 75 e0             	mov    %esi,-0x20(%ebp)
80101c9d:	8b 7d 10             	mov    0x10(%ebp),%edi
  if(ip->type == T_DEV){
80101ca0:	0f 84 ba 00 00 00    	je     80101d60 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101ca6:	39 78 58             	cmp    %edi,0x58(%eax)
80101ca9:	0f 82 ea 00 00 00    	jb     80101d99 <writei+0x119>
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101caf:	8b 75 e0             	mov    -0x20(%ebp),%esi
80101cb2:	89 f2                	mov    %esi,%edx
80101cb4:	01 fa                	add    %edi,%edx
80101cb6:	0f 82 dd 00 00 00    	jb     80101d99 <writei+0x119>
80101cbc:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
80101cc2:	0f 87 d1 00 00 00    	ja     80101d99 <writei+0x119>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101cc8:	85 f6                	test   %esi,%esi
80101cca:	0f 84 85 00 00 00    	je     80101d55 <writei+0xd5>
80101cd0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
    m = min(n - tot, BSIZE - off%BSIZE);
80101cd7:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ce0:	8b 75 d8             	mov    -0x28(%ebp),%esi
80101ce3:	89 fa                	mov    %edi,%edx
80101ce5:	c1 ea 09             	shr    $0x9,%edx
80101ce8:	89 f0                	mov    %esi,%eax
80101cea:	e8 51 f8 ff ff       	call   80101540 <bmap>
80101cef:	83 ec 08             	sub    $0x8,%esp
80101cf2:	50                   	push   %eax
80101cf3:	ff 36                	push   (%esi)
80101cf5:	e8 d6 e3 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101cfa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101cfd:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101d00:	b9 00 02 00 00       	mov    $0x200,%ecx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101d05:	89 c6                	mov    %eax,%esi
    m = min(n - tot, BSIZE - off%BSIZE);
80101d07:	89 f8                	mov    %edi,%eax
80101d09:	25 ff 01 00 00       	and    $0x1ff,%eax
80101d0e:	29 d3                	sub    %edx,%ebx
80101d10:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101d12:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101d16:	39 d9                	cmp    %ebx,%ecx
80101d18:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101d1b:	83 c4 0c             	add    $0xc,%esp
80101d1e:	53                   	push   %ebx
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d1f:	01 df                	add    %ebx,%edi
    memmove(bp->data + off%BSIZE, src, m);
80101d21:	ff 75 dc             	push   -0x24(%ebp)
80101d24:	50                   	push   %eax
80101d25:	e8 d6 2a 00 00       	call   80104800 <memmove>
    log_write(bp);
80101d2a:	89 34 24             	mov    %esi,(%esp)
80101d2d:	e8 be 12 00 00       	call   80102ff0 <log_write>
    brelse(bp);
80101d32:	89 34 24             	mov    %esi,(%esp)
80101d35:	e8 b6 e4 ff ff       	call   801001f0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101d3a:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101d3d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d40:	83 c4 10             	add    $0x10,%esp
80101d43:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101d46:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101d49:	39 d8                	cmp    %ebx,%eax
80101d4b:	72 93                	jb     80101ce0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101d4d:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101d50:	39 78 58             	cmp    %edi,0x58(%eax)
80101d53:	72 33                	jb     80101d88 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101d55:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101d58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d5b:	5b                   	pop    %ebx
80101d5c:	5e                   	pop    %esi
80101d5d:	5f                   	pop    %edi
80101d5e:	5d                   	pop    %ebp
80101d5f:	c3                   	ret
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101d60:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101d64:	66 83 f8 09          	cmp    $0x9,%ax
80101d68:	77 2f                	ja     80101d99 <writei+0x119>
80101d6a:	8b 04 c5 04 f9 10 80 	mov    -0x7fef06fc(,%eax,8),%eax
80101d71:	85 c0                	test   %eax,%eax
80101d73:	74 24                	je     80101d99 <writei+0x119>
    return devsw[ip->major].write(ip, src, n);
80101d75:	89 75 10             	mov    %esi,0x10(%ebp)
}
80101d78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d7b:	5b                   	pop    %ebx
80101d7c:	5e                   	pop    %esi
80101d7d:	5f                   	pop    %edi
80101d7e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101d7f:	ff e0                	jmp    *%eax
80101d81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    iupdate(ip);
80101d88:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101d8b:	89 78 58             	mov    %edi,0x58(%eax)
    iupdate(ip);
80101d8e:	50                   	push   %eax
80101d8f:	e8 2c fa ff ff       	call   801017c0 <iupdate>
80101d94:	83 c4 10             	add    $0x10,%esp
80101d97:	eb bc                	jmp    80101d55 <writei+0xd5>
      return -1;
80101d99:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101d9e:	eb b8                	jmp    80101d58 <writei+0xd8>

80101da0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101da0:	55                   	push   %ebp
80101da1:	89 e5                	mov    %esp,%ebp
80101da3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101da6:	6a 0e                	push   $0xe
80101da8:	ff 75 0c             	push   0xc(%ebp)
80101dab:	ff 75 08             	push   0x8(%ebp)
80101dae:	e8 bd 2a 00 00       	call   80104870 <strncmp>
}
80101db3:	c9                   	leave
80101db4:	c3                   	ret
80101db5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101dbc:	00 
80101dbd:	8d 76 00             	lea    0x0(%esi),%esi

80101dc0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101dc0:	55                   	push   %ebp
80101dc1:	89 e5                	mov    %esp,%ebp
80101dc3:	57                   	push   %edi
80101dc4:	56                   	push   %esi
80101dc5:	53                   	push   %ebx
80101dc6:	83 ec 1c             	sub    $0x1c,%esp
80101dc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101dcc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101dd1:	0f 85 85 00 00 00    	jne    80101e5c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101dd7:	8b 53 58             	mov    0x58(%ebx),%edx
80101dda:	31 ff                	xor    %edi,%edi
80101ddc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101ddf:	85 d2                	test   %edx,%edx
80101de1:	74 3e                	je     80101e21 <dirlookup+0x61>
80101de3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101de8:	6a 10                	push   $0x10
80101dea:	57                   	push   %edi
80101deb:	56                   	push   %esi
80101dec:	53                   	push   %ebx
80101ded:	e8 8e fd ff ff       	call   80101b80 <readi>
80101df2:	83 c4 10             	add    $0x10,%esp
80101df5:	83 f8 10             	cmp    $0x10,%eax
80101df8:	75 55                	jne    80101e4f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101dfa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101dff:	74 18                	je     80101e19 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101e01:	83 ec 04             	sub    $0x4,%esp
80101e04:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e07:	6a 0e                	push   $0xe
80101e09:	50                   	push   %eax
80101e0a:	ff 75 0c             	push   0xc(%ebp)
80101e0d:	e8 5e 2a 00 00       	call   80104870 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101e12:	83 c4 10             	add    $0x10,%esp
80101e15:	85 c0                	test   %eax,%eax
80101e17:	74 17                	je     80101e30 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e19:	83 c7 10             	add    $0x10,%edi
80101e1c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e1f:	72 c7                	jb     80101de8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101e21:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101e24:	31 c0                	xor    %eax,%eax
}
80101e26:	5b                   	pop    %ebx
80101e27:	5e                   	pop    %esi
80101e28:	5f                   	pop    %edi
80101e29:	5d                   	pop    %ebp
80101e2a:	c3                   	ret
80101e2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(poff)
80101e30:	8b 45 10             	mov    0x10(%ebp),%eax
80101e33:	85 c0                	test   %eax,%eax
80101e35:	74 05                	je     80101e3c <dirlookup+0x7c>
        *poff = off;
80101e37:	8b 45 10             	mov    0x10(%ebp),%eax
80101e3a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101e3c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101e40:	8b 03                	mov    (%ebx),%eax
80101e42:	e8 79 f5 ff ff       	call   801013c0 <iget>
}
80101e47:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e4a:	5b                   	pop    %ebx
80101e4b:	5e                   	pop    %esi
80101e4c:	5f                   	pop    %edi
80101e4d:	5d                   	pop    %ebp
80101e4e:	c3                   	ret
      panic("dirlookup read");
80101e4f:	83 ec 0c             	sub    $0xc,%esp
80101e52:	68 88 73 10 80       	push   $0x80107388
80101e57:	e8 24 e5 ff ff       	call   80100380 <panic>
    panic("dirlookup not DIR");
80101e5c:	83 ec 0c             	sub    $0xc,%esp
80101e5f:	68 76 73 10 80       	push   $0x80107376
80101e64:	e8 17 e5 ff ff       	call   80100380 <panic>
80101e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101e70 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101e70:	55                   	push   %ebp
80101e71:	89 e5                	mov    %esp,%ebp
80101e73:	57                   	push   %edi
80101e74:	56                   	push   %esi
80101e75:	53                   	push   %ebx
80101e76:	89 c3                	mov    %eax,%ebx
80101e78:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101e7b:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101e7e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101e81:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  if(*path == '/')
80101e84:	0f 84 9e 01 00 00    	je     80102028 <namex+0x1b8>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101e8a:	e8 a1 1b 00 00       	call   80103a30 <myproc>
  acquire(&icache.lock);
80101e8f:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101e92:	8b 70 68             	mov    0x68(%eax),%esi
  acquire(&icache.lock);
80101e95:	68 60 f9 10 80       	push   $0x8010f960
80101e9a:	e8 d1 27 00 00       	call   80104670 <acquire>
  ip->ref++;
80101e9f:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101ea3:	c7 04 24 60 f9 10 80 	movl   $0x8010f960,(%esp)
80101eaa:	e8 61 27 00 00       	call   80104610 <release>
80101eaf:	83 c4 10             	add    $0x10,%esp
80101eb2:	eb 07                	jmp    80101ebb <namex+0x4b>
80101eb4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101eb8:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101ebb:	0f b6 03             	movzbl (%ebx),%eax
80101ebe:	3c 2f                	cmp    $0x2f,%al
80101ec0:	74 f6                	je     80101eb8 <namex+0x48>
  if(*path == 0)
80101ec2:	84 c0                	test   %al,%al
80101ec4:	0f 84 06 01 00 00    	je     80101fd0 <namex+0x160>
  while(*path != '/' && *path != 0)
80101eca:	0f b6 03             	movzbl (%ebx),%eax
80101ecd:	84 c0                	test   %al,%al
80101ecf:	0f 84 10 01 00 00    	je     80101fe5 <namex+0x175>
80101ed5:	89 df                	mov    %ebx,%edi
80101ed7:	3c 2f                	cmp    $0x2f,%al
80101ed9:	0f 84 06 01 00 00    	je     80101fe5 <namex+0x175>
80101edf:	90                   	nop
80101ee0:	0f b6 47 01          	movzbl 0x1(%edi),%eax
    path++;
80101ee4:	83 c7 01             	add    $0x1,%edi
  while(*path != '/' && *path != 0)
80101ee7:	3c 2f                	cmp    $0x2f,%al
80101ee9:	74 04                	je     80101eef <namex+0x7f>
80101eeb:	84 c0                	test   %al,%al
80101eed:	75 f1                	jne    80101ee0 <namex+0x70>
  len = path - s;
80101eef:	89 f8                	mov    %edi,%eax
80101ef1:	29 d8                	sub    %ebx,%eax
  if(len >= DIRSIZ)
80101ef3:	83 f8 0d             	cmp    $0xd,%eax
80101ef6:	0f 8e ac 00 00 00    	jle    80101fa8 <namex+0x138>
    memmove(name, s, DIRSIZ);
80101efc:	83 ec 04             	sub    $0x4,%esp
80101eff:	6a 0e                	push   $0xe
80101f01:	53                   	push   %ebx
80101f02:	89 fb                	mov    %edi,%ebx
80101f04:	ff 75 e4             	push   -0x1c(%ebp)
80101f07:	e8 f4 28 00 00       	call   80104800 <memmove>
80101f0c:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101f0f:	80 3f 2f             	cmpb   $0x2f,(%edi)
80101f12:	75 0c                	jne    80101f20 <namex+0xb0>
80101f14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    path++;
80101f18:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101f1b:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101f1e:	74 f8                	je     80101f18 <namex+0xa8>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101f20:	83 ec 0c             	sub    $0xc,%esp
80101f23:	56                   	push   %esi
80101f24:	e8 47 f9 ff ff       	call   80101870 <ilock>
    if(ip->type != T_DIR){
80101f29:	83 c4 10             	add    $0x10,%esp
80101f2c:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101f31:	0f 85 b7 00 00 00    	jne    80101fee <namex+0x17e>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101f37:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101f3a:	85 c0                	test   %eax,%eax
80101f3c:	74 09                	je     80101f47 <namex+0xd7>
80101f3e:	80 3b 00             	cmpb   $0x0,(%ebx)
80101f41:	0f 84 f7 00 00 00    	je     8010203e <namex+0x1ce>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101f47:	83 ec 04             	sub    $0x4,%esp
80101f4a:	6a 00                	push   $0x0
80101f4c:	ff 75 e4             	push   -0x1c(%ebp)
80101f4f:	56                   	push   %esi
80101f50:	e8 6b fe ff ff       	call   80101dc0 <dirlookup>
80101f55:	83 c4 10             	add    $0x10,%esp
80101f58:	89 c7                	mov    %eax,%edi
80101f5a:	85 c0                	test   %eax,%eax
80101f5c:	0f 84 8c 00 00 00    	je     80101fee <namex+0x17e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101f62:	83 ec 0c             	sub    $0xc,%esp
80101f65:	8d 4e 0c             	lea    0xc(%esi),%ecx
80101f68:	51                   	push   %ecx
80101f69:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101f6c:	e8 bf 24 00 00       	call   80104430 <holdingsleep>
80101f71:	83 c4 10             	add    $0x10,%esp
80101f74:	85 c0                	test   %eax,%eax
80101f76:	0f 84 02 01 00 00    	je     8010207e <namex+0x20e>
80101f7c:	8b 56 08             	mov    0x8(%esi),%edx
80101f7f:	85 d2                	test   %edx,%edx
80101f81:	0f 8e f7 00 00 00    	jle    8010207e <namex+0x20e>
  releasesleep(&ip->lock);
80101f87:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101f8a:	83 ec 0c             	sub    $0xc,%esp
80101f8d:	51                   	push   %ecx
80101f8e:	e8 5d 24 00 00       	call   801043f0 <releasesleep>
  iput(ip);
80101f93:	89 34 24             	mov    %esi,(%esp)
      iunlockput(ip);
      return 0;
    }
    iunlockput(ip);
    ip = next;
80101f96:	89 fe                	mov    %edi,%esi
  iput(ip);
80101f98:	e8 03 fa ff ff       	call   801019a0 <iput>
80101f9d:	83 c4 10             	add    $0x10,%esp
  while(*path == '/')
80101fa0:	e9 16 ff ff ff       	jmp    80101ebb <namex+0x4b>
80101fa5:	8d 76 00             	lea    0x0(%esi),%esi
    name[len] = 0;
80101fa8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101fab:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
    memmove(name, s, len);
80101fae:	83 ec 04             	sub    $0x4,%esp
80101fb1:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101fb4:	50                   	push   %eax
80101fb5:	53                   	push   %ebx
    name[len] = 0;
80101fb6:	89 fb                	mov    %edi,%ebx
    memmove(name, s, len);
80101fb8:	ff 75 e4             	push   -0x1c(%ebp)
80101fbb:	e8 40 28 00 00       	call   80104800 <memmove>
    name[len] = 0;
80101fc0:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101fc3:	83 c4 10             	add    $0x10,%esp
80101fc6:	c6 01 00             	movb   $0x0,(%ecx)
80101fc9:	e9 41 ff ff ff       	jmp    80101f0f <namex+0x9f>
80101fce:	66 90                	xchg   %ax,%ax
  }
  if(nameiparent){
80101fd0:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101fd3:	85 c0                	test   %eax,%eax
80101fd5:	0f 85 93 00 00 00    	jne    8010206e <namex+0x1fe>
    iput(ip);
    return 0;
  }
  return ip;
}
80101fdb:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fde:	89 f0                	mov    %esi,%eax
80101fe0:	5b                   	pop    %ebx
80101fe1:	5e                   	pop    %esi
80101fe2:	5f                   	pop    %edi
80101fe3:	5d                   	pop    %ebp
80101fe4:	c3                   	ret
  while(*path != '/' && *path != 0)
80101fe5:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101fe8:	89 df                	mov    %ebx,%edi
80101fea:	31 c0                	xor    %eax,%eax
80101fec:	eb c0                	jmp    80101fae <namex+0x13e>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101fee:	83 ec 0c             	sub    $0xc,%esp
80101ff1:	8d 5e 0c             	lea    0xc(%esi),%ebx
80101ff4:	53                   	push   %ebx
80101ff5:	e8 36 24 00 00       	call   80104430 <holdingsleep>
80101ffa:	83 c4 10             	add    $0x10,%esp
80101ffd:	85 c0                	test   %eax,%eax
80101fff:	74 7d                	je     8010207e <namex+0x20e>
80102001:	8b 4e 08             	mov    0x8(%esi),%ecx
80102004:	85 c9                	test   %ecx,%ecx
80102006:	7e 76                	jle    8010207e <namex+0x20e>
  releasesleep(&ip->lock);
80102008:	83 ec 0c             	sub    $0xc,%esp
8010200b:	53                   	push   %ebx
8010200c:	e8 df 23 00 00       	call   801043f0 <releasesleep>
  iput(ip);
80102011:	89 34 24             	mov    %esi,(%esp)
      return 0;
80102014:	31 f6                	xor    %esi,%esi
  iput(ip);
80102016:	e8 85 f9 ff ff       	call   801019a0 <iput>
      return 0;
8010201b:	83 c4 10             	add    $0x10,%esp
}
8010201e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102021:	89 f0                	mov    %esi,%eax
80102023:	5b                   	pop    %ebx
80102024:	5e                   	pop    %esi
80102025:	5f                   	pop    %edi
80102026:	5d                   	pop    %ebp
80102027:	c3                   	ret
    ip = iget(ROOTDEV, ROOTINO);
80102028:	ba 01 00 00 00       	mov    $0x1,%edx
8010202d:	b8 01 00 00 00       	mov    $0x1,%eax
80102032:	e8 89 f3 ff ff       	call   801013c0 <iget>
80102037:	89 c6                	mov    %eax,%esi
80102039:	e9 7d fe ff ff       	jmp    80101ebb <namex+0x4b>
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
8010203e:	83 ec 0c             	sub    $0xc,%esp
80102041:	8d 5e 0c             	lea    0xc(%esi),%ebx
80102044:	53                   	push   %ebx
80102045:	e8 e6 23 00 00       	call   80104430 <holdingsleep>
8010204a:	83 c4 10             	add    $0x10,%esp
8010204d:	85 c0                	test   %eax,%eax
8010204f:	74 2d                	je     8010207e <namex+0x20e>
80102051:	8b 7e 08             	mov    0x8(%esi),%edi
80102054:	85 ff                	test   %edi,%edi
80102056:	7e 26                	jle    8010207e <namex+0x20e>
  releasesleep(&ip->lock);
80102058:	83 ec 0c             	sub    $0xc,%esp
8010205b:	53                   	push   %ebx
8010205c:	e8 8f 23 00 00       	call   801043f0 <releasesleep>
}
80102061:	83 c4 10             	add    $0x10,%esp
}
80102064:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102067:	89 f0                	mov    %esi,%eax
80102069:	5b                   	pop    %ebx
8010206a:	5e                   	pop    %esi
8010206b:	5f                   	pop    %edi
8010206c:	5d                   	pop    %ebp
8010206d:	c3                   	ret
    iput(ip);
8010206e:	83 ec 0c             	sub    $0xc,%esp
80102071:	56                   	push   %esi
      return 0;
80102072:	31 f6                	xor    %esi,%esi
    iput(ip);
80102074:	e8 27 f9 ff ff       	call   801019a0 <iput>
    return 0;
80102079:	83 c4 10             	add    $0x10,%esp
8010207c:	eb a0                	jmp    8010201e <namex+0x1ae>
    panic("iunlock");
8010207e:	83 ec 0c             	sub    $0xc,%esp
80102081:	68 6e 73 10 80       	push   $0x8010736e
80102086:	e8 f5 e2 ff ff       	call   80100380 <panic>
8010208b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102090 <dirlink>:
{
80102090:	55                   	push   %ebp
80102091:	89 e5                	mov    %esp,%ebp
80102093:	57                   	push   %edi
80102094:	56                   	push   %esi
80102095:	53                   	push   %ebx
80102096:	83 ec 20             	sub    $0x20,%esp
80102099:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
8010209c:	6a 00                	push   $0x0
8010209e:	ff 75 0c             	push   0xc(%ebp)
801020a1:	53                   	push   %ebx
801020a2:	e8 19 fd ff ff       	call   80101dc0 <dirlookup>
801020a7:	83 c4 10             	add    $0x10,%esp
801020aa:	85 c0                	test   %eax,%eax
801020ac:	75 67                	jne    80102115 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
801020ae:	8b 7b 58             	mov    0x58(%ebx),%edi
801020b1:	8d 75 d8             	lea    -0x28(%ebp),%esi
801020b4:	85 ff                	test   %edi,%edi
801020b6:	74 29                	je     801020e1 <dirlink+0x51>
801020b8:	31 ff                	xor    %edi,%edi
801020ba:	8d 75 d8             	lea    -0x28(%ebp),%esi
801020bd:	eb 09                	jmp    801020c8 <dirlink+0x38>
801020bf:	90                   	nop
801020c0:	83 c7 10             	add    $0x10,%edi
801020c3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801020c6:	73 19                	jae    801020e1 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801020c8:	6a 10                	push   $0x10
801020ca:	57                   	push   %edi
801020cb:	56                   	push   %esi
801020cc:	53                   	push   %ebx
801020cd:	e8 ae fa ff ff       	call   80101b80 <readi>
801020d2:	83 c4 10             	add    $0x10,%esp
801020d5:	83 f8 10             	cmp    $0x10,%eax
801020d8:	75 4e                	jne    80102128 <dirlink+0x98>
    if(de.inum == 0)
801020da:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801020df:	75 df                	jne    801020c0 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
801020e1:	83 ec 04             	sub    $0x4,%esp
801020e4:	8d 45 da             	lea    -0x26(%ebp),%eax
801020e7:	6a 0e                	push   $0xe
801020e9:	ff 75 0c             	push   0xc(%ebp)
801020ec:	50                   	push   %eax
801020ed:	e8 ce 27 00 00       	call   801048c0 <strncpy>
  de.inum = inum;
801020f2:	8b 45 10             	mov    0x10(%ebp),%eax
801020f5:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801020f9:	6a 10                	push   $0x10
801020fb:	57                   	push   %edi
801020fc:	56                   	push   %esi
801020fd:	53                   	push   %ebx
801020fe:	e8 7d fb ff ff       	call   80101c80 <writei>
80102103:	83 c4 20             	add    $0x20,%esp
80102106:	83 f8 10             	cmp    $0x10,%eax
80102109:	75 2a                	jne    80102135 <dirlink+0xa5>
  return 0;
8010210b:	31 c0                	xor    %eax,%eax
}
8010210d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102110:	5b                   	pop    %ebx
80102111:	5e                   	pop    %esi
80102112:	5f                   	pop    %edi
80102113:	5d                   	pop    %ebp
80102114:	c3                   	ret
    iput(ip);
80102115:	83 ec 0c             	sub    $0xc,%esp
80102118:	50                   	push   %eax
80102119:	e8 82 f8 ff ff       	call   801019a0 <iput>
    return -1;
8010211e:	83 c4 10             	add    $0x10,%esp
80102121:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102126:	eb e5                	jmp    8010210d <dirlink+0x7d>
      panic("dirlink read");
80102128:	83 ec 0c             	sub    $0xc,%esp
8010212b:	68 97 73 10 80       	push   $0x80107397
80102130:	e8 4b e2 ff ff       	call   80100380 <panic>
    panic("dirlink");
80102135:	83 ec 0c             	sub    $0xc,%esp
80102138:	68 f3 75 10 80       	push   $0x801075f3
8010213d:	e8 3e e2 ff ff       	call   80100380 <panic>
80102142:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102149:	00 
8010214a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102150 <namei>:

struct inode*
namei(char *path)
{
80102150:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102151:	31 d2                	xor    %edx,%edx
{
80102153:	89 e5                	mov    %esp,%ebp
80102155:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80102158:	8b 45 08             	mov    0x8(%ebp),%eax
8010215b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010215e:	e8 0d fd ff ff       	call   80101e70 <namex>
}
80102163:	c9                   	leave
80102164:	c3                   	ret
80102165:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010216c:	00 
8010216d:	8d 76 00             	lea    0x0(%esi),%esi

80102170 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102170:	55                   	push   %ebp
  return namex(path, 1, name);
80102171:	ba 01 00 00 00       	mov    $0x1,%edx
{
80102176:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80102178:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010217b:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010217e:	5d                   	pop    %ebp
  return namex(path, 1, name);
8010217f:	e9 ec fc ff ff       	jmp    80101e70 <namex>
80102184:	66 90                	xchg   %ax,%ax
80102186:	66 90                	xchg   %ax,%ax
80102188:	66 90                	xchg   %ax,%ax
8010218a:	66 90                	xchg   %ax,%ax
8010218c:	66 90                	xchg   %ax,%ax
8010218e:	66 90                	xchg   %ax,%ax

80102190 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80102190:	55                   	push   %ebp
80102191:	89 e5                	mov    %esp,%ebp
80102193:	57                   	push   %edi
80102194:	56                   	push   %esi
80102195:	53                   	push   %ebx
80102196:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80102199:	85 c0                	test   %eax,%eax
8010219b:	0f 84 b4 00 00 00    	je     80102255 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
801021a1:	8b 70 08             	mov    0x8(%eax),%esi
801021a4:	89 c3                	mov    %eax,%ebx
801021a6:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
801021ac:	0f 87 96 00 00 00    	ja     80102248 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801021b2:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
801021b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801021be:	00 
801021bf:	90                   	nop
801021c0:	89 ca                	mov    %ecx,%edx
801021c2:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801021c3:	83 e0 c0             	and    $0xffffffc0,%eax
801021c6:	3c 40                	cmp    $0x40,%al
801021c8:	75 f6                	jne    801021c0 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801021ca:	31 ff                	xor    %edi,%edi
801021cc:	ba f6 03 00 00       	mov    $0x3f6,%edx
801021d1:	89 f8                	mov    %edi,%eax
801021d3:	ee                   	out    %al,(%dx)
801021d4:	b8 01 00 00 00       	mov    $0x1,%eax
801021d9:	ba f2 01 00 00       	mov    $0x1f2,%edx
801021de:	ee                   	out    %al,(%dx)
801021df:	ba f3 01 00 00       	mov    $0x1f3,%edx
801021e4:	89 f0                	mov    %esi,%eax
801021e6:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
801021e7:	89 f0                	mov    %esi,%eax
801021e9:	ba f4 01 00 00       	mov    $0x1f4,%edx
801021ee:	c1 f8 08             	sar    $0x8,%eax
801021f1:	ee                   	out    %al,(%dx)
801021f2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801021f7:	89 f8                	mov    %edi,%eax
801021f9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801021fa:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
801021fe:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102203:	c1 e0 04             	shl    $0x4,%eax
80102206:	83 e0 10             	and    $0x10,%eax
80102209:	83 c8 e0             	or     $0xffffffe0,%eax
8010220c:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
8010220d:	f6 03 04             	testb  $0x4,(%ebx)
80102210:	75 16                	jne    80102228 <idestart+0x98>
80102212:	b8 20 00 00 00       	mov    $0x20,%eax
80102217:	89 ca                	mov    %ecx,%edx
80102219:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010221a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010221d:	5b                   	pop    %ebx
8010221e:	5e                   	pop    %esi
8010221f:	5f                   	pop    %edi
80102220:	5d                   	pop    %ebp
80102221:	c3                   	ret
80102222:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102228:	b8 30 00 00 00       	mov    $0x30,%eax
8010222d:	89 ca                	mov    %ecx,%edx
8010222f:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80102230:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80102235:	8d 73 5c             	lea    0x5c(%ebx),%esi
80102238:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010223d:	fc                   	cld
8010223e:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80102240:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102243:	5b                   	pop    %ebx
80102244:	5e                   	pop    %esi
80102245:	5f                   	pop    %edi
80102246:	5d                   	pop    %ebp
80102247:	c3                   	ret
    panic("incorrect blockno");
80102248:	83 ec 0c             	sub    $0xc,%esp
8010224b:	68 ad 73 10 80       	push   $0x801073ad
80102250:	e8 2b e1 ff ff       	call   80100380 <panic>
    panic("idestart");
80102255:	83 ec 0c             	sub    $0xc,%esp
80102258:	68 a4 73 10 80       	push   $0x801073a4
8010225d:	e8 1e e1 ff ff       	call   80100380 <panic>
80102262:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102269:	00 
8010226a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102270 <ideinit>:
{
80102270:	55                   	push   %ebp
80102271:	89 e5                	mov    %esp,%ebp
80102273:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102276:	68 bf 73 10 80       	push   $0x801073bf
8010227b:	68 00 16 11 80       	push   $0x80111600
80102280:	e8 fb 21 00 00       	call   80104480 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102285:	58                   	pop    %eax
80102286:	a1 84 17 11 80       	mov    0x80111784,%eax
8010228b:	5a                   	pop    %edx
8010228c:	83 e8 01             	sub    $0x1,%eax
8010228f:	50                   	push   %eax
80102290:	6a 0e                	push   $0xe
80102292:	e8 99 02 00 00       	call   80102530 <ioapicenable>
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102297:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010229a:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
8010229f:	90                   	nop
801022a0:	89 ca                	mov    %ecx,%edx
801022a2:	ec                   	in     (%dx),%al
801022a3:	83 e0 c0             	and    $0xffffffc0,%eax
801022a6:	3c 40                	cmp    $0x40,%al
801022a8:	75 f6                	jne    801022a0 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801022aa:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
801022af:	ba f6 01 00 00       	mov    $0x1f6,%edx
801022b4:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801022b5:	89 ca                	mov    %ecx,%edx
801022b7:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801022b8:	84 c0                	test   %al,%al
801022ba:	75 1e                	jne    801022da <ideinit+0x6a>
801022bc:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
801022c1:	ba f7 01 00 00       	mov    $0x1f7,%edx
801022c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801022cd:	00 
801022ce:	66 90                	xchg   %ax,%ax
  for(i=0; i<1000; i++){
801022d0:	83 e9 01             	sub    $0x1,%ecx
801022d3:	74 0f                	je     801022e4 <ideinit+0x74>
801022d5:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
801022d6:	84 c0                	test   %al,%al
801022d8:	74 f6                	je     801022d0 <ideinit+0x60>
      havedisk1 = 1;
801022da:	c7 05 e0 15 11 80 01 	movl   $0x1,0x801115e0
801022e1:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801022e4:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
801022e9:	ba f6 01 00 00       	mov    $0x1f6,%edx
801022ee:	ee                   	out    %al,(%dx)
}
801022ef:	c9                   	leave
801022f0:	c3                   	ret
801022f1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801022f8:	00 
801022f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102300 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102300:	55                   	push   %ebp
80102301:	89 e5                	mov    %esp,%ebp
80102303:	57                   	push   %edi
80102304:	56                   	push   %esi
80102305:	53                   	push   %ebx
80102306:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
80102309:	68 00 16 11 80       	push   $0x80111600
8010230e:	e8 5d 23 00 00       	call   80104670 <acquire>

  if((b = idequeue) == 0){
80102313:	8b 1d e4 15 11 80    	mov    0x801115e4,%ebx
80102319:	83 c4 10             	add    $0x10,%esp
8010231c:	85 db                	test   %ebx,%ebx
8010231e:	74 63                	je     80102383 <ideintr+0x83>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
80102320:	8b 43 58             	mov    0x58(%ebx),%eax
80102323:	a3 e4 15 11 80       	mov    %eax,0x801115e4

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
80102328:	8b 33                	mov    (%ebx),%esi
8010232a:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102330:	75 2f                	jne    80102361 <ideintr+0x61>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102332:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102337:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010233e:	00 
8010233f:	90                   	nop
80102340:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102341:	89 c1                	mov    %eax,%ecx
80102343:	83 e1 c0             	and    $0xffffffc0,%ecx
80102346:	80 f9 40             	cmp    $0x40,%cl
80102349:	75 f5                	jne    80102340 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
8010234b:	a8 21                	test   $0x21,%al
8010234d:	75 12                	jne    80102361 <ideintr+0x61>
    insl(0x1f0, b->data, BSIZE/4);
8010234f:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
80102352:	b9 80 00 00 00       	mov    $0x80,%ecx
80102357:	ba f0 01 00 00       	mov    $0x1f0,%edx
8010235c:	fc                   	cld
8010235d:	f3 6d                	rep insl (%dx),%es:(%edi)

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
8010235f:	8b 33                	mov    (%ebx),%esi
  b->flags &= ~B_DIRTY;
80102361:	83 e6 fb             	and    $0xfffffffb,%esi
  wakeup(b);
80102364:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102367:	83 ce 02             	or     $0x2,%esi
8010236a:	89 33                	mov    %esi,(%ebx)
  wakeup(b);
8010236c:	53                   	push   %ebx
8010236d:	e8 3e 1e 00 00       	call   801041b0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102372:	a1 e4 15 11 80       	mov    0x801115e4,%eax
80102377:	83 c4 10             	add    $0x10,%esp
8010237a:	85 c0                	test   %eax,%eax
8010237c:	74 05                	je     80102383 <ideintr+0x83>
    idestart(idequeue);
8010237e:	e8 0d fe ff ff       	call   80102190 <idestart>
    release(&idelock);
80102383:	83 ec 0c             	sub    $0xc,%esp
80102386:	68 00 16 11 80       	push   $0x80111600
8010238b:	e8 80 22 00 00       	call   80104610 <release>

  release(&idelock);
}
80102390:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102393:	5b                   	pop    %ebx
80102394:	5e                   	pop    %esi
80102395:	5f                   	pop    %edi
80102396:	5d                   	pop    %ebp
80102397:	c3                   	ret
80102398:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010239f:	00 

801023a0 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
801023a0:	55                   	push   %ebp
801023a1:	89 e5                	mov    %esp,%ebp
801023a3:	53                   	push   %ebx
801023a4:	83 ec 10             	sub    $0x10,%esp
801023a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
801023aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801023ad:	50                   	push   %eax
801023ae:	e8 7d 20 00 00       	call   80104430 <holdingsleep>
801023b3:	83 c4 10             	add    $0x10,%esp
801023b6:	85 c0                	test   %eax,%eax
801023b8:	0f 84 c3 00 00 00    	je     80102481 <iderw+0xe1>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
801023be:	8b 03                	mov    (%ebx),%eax
801023c0:	83 e0 06             	and    $0x6,%eax
801023c3:	83 f8 02             	cmp    $0x2,%eax
801023c6:	0f 84 a8 00 00 00    	je     80102474 <iderw+0xd4>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
801023cc:	8b 53 04             	mov    0x4(%ebx),%edx
801023cf:	85 d2                	test   %edx,%edx
801023d1:	74 0d                	je     801023e0 <iderw+0x40>
801023d3:	a1 e0 15 11 80       	mov    0x801115e0,%eax
801023d8:	85 c0                	test   %eax,%eax
801023da:	0f 84 87 00 00 00    	je     80102467 <iderw+0xc7>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
801023e0:	83 ec 0c             	sub    $0xc,%esp
801023e3:	68 00 16 11 80       	push   $0x80111600
801023e8:	e8 83 22 00 00       	call   80104670 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801023ed:	a1 e4 15 11 80       	mov    0x801115e4,%eax
  b->qnext = 0;
801023f2:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801023f9:	83 c4 10             	add    $0x10,%esp
801023fc:	85 c0                	test   %eax,%eax
801023fe:	74 60                	je     80102460 <iderw+0xc0>
80102400:	89 c2                	mov    %eax,%edx
80102402:	8b 40 58             	mov    0x58(%eax),%eax
80102405:	85 c0                	test   %eax,%eax
80102407:	75 f7                	jne    80102400 <iderw+0x60>
80102409:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
8010240c:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
8010240e:	39 1d e4 15 11 80    	cmp    %ebx,0x801115e4
80102414:	74 3a                	je     80102450 <iderw+0xb0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102416:	8b 03                	mov    (%ebx),%eax
80102418:	83 e0 06             	and    $0x6,%eax
8010241b:	83 f8 02             	cmp    $0x2,%eax
8010241e:	74 1b                	je     8010243b <iderw+0x9b>
    sleep(b, &idelock);
80102420:	83 ec 08             	sub    $0x8,%esp
80102423:	68 00 16 11 80       	push   $0x80111600
80102428:	53                   	push   %ebx
80102429:	e8 c2 1c 00 00       	call   801040f0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
8010242e:	8b 03                	mov    (%ebx),%eax
80102430:	83 c4 10             	add    $0x10,%esp
80102433:	83 e0 06             	and    $0x6,%eax
80102436:	83 f8 02             	cmp    $0x2,%eax
80102439:	75 e5                	jne    80102420 <iderw+0x80>
  }


  release(&idelock);
8010243b:	c7 45 08 00 16 11 80 	movl   $0x80111600,0x8(%ebp)
}
80102442:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102445:	c9                   	leave
  release(&idelock);
80102446:	e9 c5 21 00 00       	jmp    80104610 <release>
8010244b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    idestart(b);
80102450:	89 d8                	mov    %ebx,%eax
80102452:	e8 39 fd ff ff       	call   80102190 <idestart>
80102457:	eb bd                	jmp    80102416 <iderw+0x76>
80102459:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102460:	ba e4 15 11 80       	mov    $0x801115e4,%edx
80102465:	eb a5                	jmp    8010240c <iderw+0x6c>
    panic("iderw: ide disk 1 not present");
80102467:	83 ec 0c             	sub    $0xc,%esp
8010246a:	68 ee 73 10 80       	push   $0x801073ee
8010246f:	e8 0c df ff ff       	call   80100380 <panic>
    panic("iderw: nothing to do");
80102474:	83 ec 0c             	sub    $0xc,%esp
80102477:	68 d9 73 10 80       	push   $0x801073d9
8010247c:	e8 ff de ff ff       	call   80100380 <panic>
    panic("iderw: buf not locked");
80102481:	83 ec 0c             	sub    $0xc,%esp
80102484:	68 c3 73 10 80       	push   $0x801073c3
80102489:	e8 f2 de ff ff       	call   80100380 <panic>
8010248e:	66 90                	xchg   %ax,%ax

80102490 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102490:	55                   	push   %ebp
80102491:	89 e5                	mov    %esp,%ebp
80102493:	56                   	push   %esi
80102494:	53                   	push   %ebx
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102495:	c7 05 34 16 11 80 00 	movl   $0xfec00000,0x80111634
8010249c:	00 c0 fe 
  ioapic->reg = reg;
8010249f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
801024a6:	00 00 00 
  return ioapic->data;
801024a9:	8b 15 34 16 11 80    	mov    0x80111634,%edx
801024af:	8b 72 10             	mov    0x10(%edx),%esi
  ioapic->reg = reg;
801024b2:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
  return ioapic->data;
801024b8:	8b 1d 34 16 11 80    	mov    0x80111634,%ebx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
801024be:	0f b6 15 80 17 11 80 	movzbl 0x80111780,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
801024c5:	c1 ee 10             	shr    $0x10,%esi
801024c8:	89 f0                	mov    %esi,%eax
801024ca:	0f b6 f0             	movzbl %al,%esi
  return ioapic->data;
801024cd:	8b 43 10             	mov    0x10(%ebx),%eax
  id = ioapicread(REG_ID) >> 24;
801024d0:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
801024d3:	39 c2                	cmp    %eax,%edx
801024d5:	74 16                	je     801024ed <ioapicinit+0x5d>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
801024d7:	83 ec 0c             	sub    $0xc,%esp
801024da:	68 a8 77 10 80       	push   $0x801077a8
801024df:	e8 5c e2 ff ff       	call   80100740 <cprintf>
  ioapic->reg = reg;
801024e4:	8b 1d 34 16 11 80    	mov    0x80111634,%ebx
801024ea:	83 c4 10             	add    $0x10,%esp
{
801024ed:	ba 10 00 00 00       	mov    $0x10,%edx
801024f2:	31 c0                	xor    %eax,%eax
801024f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  ioapic->reg = reg;
801024f8:	89 13                	mov    %edx,(%ebx)
801024fa:	8d 48 20             	lea    0x20(%eax),%ecx
  ioapic->data = data;
801024fd:	8b 1d 34 16 11 80    	mov    0x80111634,%ebx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102503:	83 c0 01             	add    $0x1,%eax
80102506:	81 c9 00 00 01 00    	or     $0x10000,%ecx
  ioapic->data = data;
8010250c:	89 4b 10             	mov    %ecx,0x10(%ebx)
  ioapic->reg = reg;
8010250f:	8d 4a 01             	lea    0x1(%edx),%ecx
  for(i = 0; i <= maxintr; i++){
80102512:	83 c2 02             	add    $0x2,%edx
  ioapic->reg = reg;
80102515:	89 0b                	mov    %ecx,(%ebx)
  ioapic->data = data;
80102517:	8b 1d 34 16 11 80    	mov    0x80111634,%ebx
8010251d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
  for(i = 0; i <= maxintr; i++){
80102524:	39 c6                	cmp    %eax,%esi
80102526:	7d d0                	jge    801024f8 <ioapicinit+0x68>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
80102528:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010252b:	5b                   	pop    %ebx
8010252c:	5e                   	pop    %esi
8010252d:	5d                   	pop    %ebp
8010252e:	c3                   	ret
8010252f:	90                   	nop

80102530 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102530:	55                   	push   %ebp
  ioapic->reg = reg;
80102531:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
{
80102537:	89 e5                	mov    %esp,%ebp
80102539:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
8010253c:	8d 50 20             	lea    0x20(%eax),%edx
8010253f:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102543:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102545:	8b 0d 34 16 11 80    	mov    0x80111634,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010254b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010254e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102551:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102554:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102556:	a1 34 16 11 80       	mov    0x80111634,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010255b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010255e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102561:	5d                   	pop    %ebp
80102562:	c3                   	ret
80102563:	66 90                	xchg   %ax,%ax
80102565:	66 90                	xchg   %ax,%ax
80102567:	66 90                	xchg   %ax,%ax
80102569:	66 90                	xchg   %ax,%ax
8010256b:	66 90                	xchg   %ax,%ax
8010256d:	66 90                	xchg   %ax,%ax
8010256f:	90                   	nop

80102570 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102570:	55                   	push   %ebp
80102571:	89 e5                	mov    %esp,%ebp
80102573:	53                   	push   %ebx
80102574:	83 ec 04             	sub    $0x4,%esp
80102577:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010257a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102580:	75 76                	jne    801025f8 <kfree+0x88>
80102582:	81 fb d0 54 11 80    	cmp    $0x801154d0,%ebx
80102588:	72 6e                	jb     801025f8 <kfree+0x88>
8010258a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102590:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102595:	77 61                	ja     801025f8 <kfree+0x88>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102597:	83 ec 04             	sub    $0x4,%esp
8010259a:	68 00 10 00 00       	push   $0x1000
8010259f:	6a 01                	push   $0x1
801025a1:	53                   	push   %ebx
801025a2:	e8 c9 21 00 00       	call   80104770 <memset>

  if(kmem.use_lock)
801025a7:	8b 15 74 16 11 80    	mov    0x80111674,%edx
801025ad:	83 c4 10             	add    $0x10,%esp
801025b0:	85 d2                	test   %edx,%edx
801025b2:	75 1c                	jne    801025d0 <kfree+0x60>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
801025b4:	a1 78 16 11 80       	mov    0x80111678,%eax
801025b9:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
801025bb:	a1 74 16 11 80       	mov    0x80111674,%eax
  kmem.freelist = r;
801025c0:	89 1d 78 16 11 80    	mov    %ebx,0x80111678
  if(kmem.use_lock)
801025c6:	85 c0                	test   %eax,%eax
801025c8:	75 1e                	jne    801025e8 <kfree+0x78>
    release(&kmem.lock);
}
801025ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801025cd:	c9                   	leave
801025ce:	c3                   	ret
801025cf:	90                   	nop
    acquire(&kmem.lock);
801025d0:	83 ec 0c             	sub    $0xc,%esp
801025d3:	68 40 16 11 80       	push   $0x80111640
801025d8:	e8 93 20 00 00       	call   80104670 <acquire>
801025dd:	83 c4 10             	add    $0x10,%esp
801025e0:	eb d2                	jmp    801025b4 <kfree+0x44>
801025e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    release(&kmem.lock);
801025e8:	c7 45 08 40 16 11 80 	movl   $0x80111640,0x8(%ebp)
}
801025ef:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801025f2:	c9                   	leave
    release(&kmem.lock);
801025f3:	e9 18 20 00 00       	jmp    80104610 <release>
    panic("kfree");
801025f8:	83 ec 0c             	sub    $0xc,%esp
801025fb:	68 0c 74 10 80       	push   $0x8010740c
80102600:	e8 7b dd ff ff       	call   80100380 <panic>
80102605:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010260c:	00 
8010260d:	8d 76 00             	lea    0x0(%esi),%esi

80102610 <freerange>:
{
80102610:	55                   	push   %ebp
80102611:	89 e5                	mov    %esp,%ebp
80102613:	56                   	push   %esi
80102614:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102615:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102618:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010261b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102621:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102627:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010262d:	39 de                	cmp    %ebx,%esi
8010262f:	72 23                	jb     80102654 <freerange+0x44>
80102631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102638:	83 ec 0c             	sub    $0xc,%esp
8010263b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102641:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102647:	50                   	push   %eax
80102648:	e8 23 ff ff ff       	call   80102570 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010264d:	83 c4 10             	add    $0x10,%esp
80102650:	39 de                	cmp    %ebx,%esi
80102652:	73 e4                	jae    80102638 <freerange+0x28>
}
80102654:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102657:	5b                   	pop    %ebx
80102658:	5e                   	pop    %esi
80102659:	5d                   	pop    %ebp
8010265a:	c3                   	ret
8010265b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102660 <kinit2>:
{
80102660:	55                   	push   %ebp
80102661:	89 e5                	mov    %esp,%ebp
80102663:	56                   	push   %esi
80102664:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102665:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102668:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010266b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102671:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102677:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010267d:	39 de                	cmp    %ebx,%esi
8010267f:	72 23                	jb     801026a4 <kinit2+0x44>
80102681:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
80102688:	83 ec 0c             	sub    $0xc,%esp
8010268b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102691:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
80102697:	50                   	push   %eax
80102698:	e8 d3 fe ff ff       	call   80102570 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010269d:	83 c4 10             	add    $0x10,%esp
801026a0:	39 de                	cmp    %ebx,%esi
801026a2:	73 e4                	jae    80102688 <kinit2+0x28>
  kmem.use_lock = 1;
801026a4:	c7 05 74 16 11 80 01 	movl   $0x1,0x80111674
801026ab:	00 00 00 
}
801026ae:	8d 65 f8             	lea    -0x8(%ebp),%esp
801026b1:	5b                   	pop    %ebx
801026b2:	5e                   	pop    %esi
801026b3:	5d                   	pop    %ebp
801026b4:	c3                   	ret
801026b5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801026bc:	00 
801026bd:	8d 76 00             	lea    0x0(%esi),%esi

801026c0 <kinit1>:
{
801026c0:	55                   	push   %ebp
801026c1:	89 e5                	mov    %esp,%ebp
801026c3:	56                   	push   %esi
801026c4:	53                   	push   %ebx
801026c5:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
801026c8:	83 ec 08             	sub    $0x8,%esp
801026cb:	68 12 74 10 80       	push   $0x80107412
801026d0:	68 40 16 11 80       	push   $0x80111640
801026d5:	e8 a6 1d 00 00       	call   80104480 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
801026da:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026dd:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
801026e0:	c7 05 74 16 11 80 00 	movl   $0x0,0x80111674
801026e7:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
801026ea:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801026f0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801026f6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801026fc:	39 de                	cmp    %ebx,%esi
801026fe:	72 1c                	jb     8010271c <kinit1+0x5c>
    kfree(p);
80102700:	83 ec 0c             	sub    $0xc,%esp
80102703:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102709:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010270f:	50                   	push   %eax
80102710:	e8 5b fe ff ff       	call   80102570 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102715:	83 c4 10             	add    $0x10,%esp
80102718:	39 de                	cmp    %ebx,%esi
8010271a:	73 e4                	jae    80102700 <kinit1+0x40>
}
8010271c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010271f:	5b                   	pop    %ebx
80102720:	5e                   	pop    %esi
80102721:	5d                   	pop    %ebp
80102722:	c3                   	ret
80102723:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010272a:	00 
8010272b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102730 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102730:	55                   	push   %ebp
80102731:	89 e5                	mov    %esp,%ebp
80102733:	53                   	push   %ebx
80102734:	83 ec 04             	sub    $0x4,%esp
  struct run *r;

  if(kmem.use_lock)
80102737:	a1 74 16 11 80       	mov    0x80111674,%eax
8010273c:	85 c0                	test   %eax,%eax
8010273e:	75 20                	jne    80102760 <kalloc+0x30>
    acquire(&kmem.lock);
  r = kmem.freelist;
80102740:	8b 1d 78 16 11 80    	mov    0x80111678,%ebx
  if(r)
80102746:	85 db                	test   %ebx,%ebx
80102748:	74 07                	je     80102751 <kalloc+0x21>
    kmem.freelist = r->next;
8010274a:	8b 03                	mov    (%ebx),%eax
8010274c:	a3 78 16 11 80       	mov    %eax,0x80111678
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102751:	89 d8                	mov    %ebx,%eax
80102753:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102756:	c9                   	leave
80102757:	c3                   	ret
80102758:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010275f:	00 
    acquire(&kmem.lock);
80102760:	83 ec 0c             	sub    $0xc,%esp
80102763:	68 40 16 11 80       	push   $0x80111640
80102768:	e8 03 1f 00 00       	call   80104670 <acquire>
  r = kmem.freelist;
8010276d:	8b 1d 78 16 11 80    	mov    0x80111678,%ebx
  if(kmem.use_lock)
80102773:	a1 74 16 11 80       	mov    0x80111674,%eax
  if(r)
80102778:	83 c4 10             	add    $0x10,%esp
8010277b:	85 db                	test   %ebx,%ebx
8010277d:	74 08                	je     80102787 <kalloc+0x57>
    kmem.freelist = r->next;
8010277f:	8b 13                	mov    (%ebx),%edx
80102781:	89 15 78 16 11 80    	mov    %edx,0x80111678
  if(kmem.use_lock)
80102787:	85 c0                	test   %eax,%eax
80102789:	74 c6                	je     80102751 <kalloc+0x21>
    release(&kmem.lock);
8010278b:	83 ec 0c             	sub    $0xc,%esp
8010278e:	68 40 16 11 80       	push   $0x80111640
80102793:	e8 78 1e 00 00       	call   80104610 <release>
}
80102798:	89 d8                	mov    %ebx,%eax
    release(&kmem.lock);
8010279a:	83 c4 10             	add    $0x10,%esp
}
8010279d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801027a0:	c9                   	leave
801027a1:	c3                   	ret
801027a2:	66 90                	xchg   %ax,%ax
801027a4:	66 90                	xchg   %ax,%ax
801027a6:	66 90                	xchg   %ax,%ax
801027a8:	66 90                	xchg   %ax,%ax
801027aa:	66 90                	xchg   %ax,%ax
801027ac:	66 90                	xchg   %ax,%ax
801027ae:	66 90                	xchg   %ax,%ax

801027b0 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801027b0:	ba 64 00 00 00       	mov    $0x64,%edx
801027b5:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
801027b6:	a8 01                	test   $0x1,%al
801027b8:	0f 84 c2 00 00 00    	je     80102880 <kbdgetc+0xd0>
{
801027be:	55                   	push   %ebp
801027bf:	ba 60 00 00 00       	mov    $0x60,%edx
801027c4:	89 e5                	mov    %esp,%ebp
801027c6:	53                   	push   %ebx
801027c7:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);

  if(data == 0xE0){
    shift |= E0ESC;
801027c8:	8b 1d 7c 16 11 80    	mov    0x8011167c,%ebx
  data = inb(KBDATAP);
801027ce:	0f b6 c8             	movzbl %al,%ecx
  if(data == 0xE0){
801027d1:	3c e0                	cmp    $0xe0,%al
801027d3:	74 5b                	je     80102830 <kbdgetc+0x80>
    return 0;
  } else if(data & 0x80){
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
801027d5:	89 da                	mov    %ebx,%edx
801027d7:	83 e2 40             	and    $0x40,%edx
  } else if(data & 0x80){
801027da:	84 c0                	test   %al,%al
801027dc:	78 62                	js     80102840 <kbdgetc+0x90>
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
801027de:	85 d2                	test   %edx,%edx
801027e0:	74 09                	je     801027eb <kbdgetc+0x3b>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
801027e2:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
801027e5:	83 e3 bf             	and    $0xffffffbf,%ebx
    data |= 0x80;
801027e8:	0f b6 c8             	movzbl %al,%ecx
  }

  shift |= shiftcode[data];
801027eb:	0f b6 91 20 7a 10 80 	movzbl -0x7fef85e0(%ecx),%edx
  shift ^= togglecode[data];
801027f2:	0f b6 81 20 79 10 80 	movzbl -0x7fef86e0(%ecx),%eax
  shift |= shiftcode[data];
801027f9:	09 da                	or     %ebx,%edx
  shift ^= togglecode[data];
801027fb:	31 c2                	xor    %eax,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
801027fd:	89 d0                	mov    %edx,%eax
  shift ^= togglecode[data];
801027ff:	89 15 7c 16 11 80    	mov    %edx,0x8011167c
  c = charcode[shift & (CTL | SHIFT)][data];
80102805:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
80102808:	83 e2 08             	and    $0x8,%edx
  c = charcode[shift & (CTL | SHIFT)][data];
8010280b:	8b 04 85 00 79 10 80 	mov    -0x7fef8700(,%eax,4),%eax
80102812:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
  if(shift & CAPSLOCK){
80102816:	74 0b                	je     80102823 <kbdgetc+0x73>
    if('a' <= c && c <= 'z')
80102818:	8d 50 9f             	lea    -0x61(%eax),%edx
8010281b:	83 fa 19             	cmp    $0x19,%edx
8010281e:	77 48                	ja     80102868 <kbdgetc+0xb8>
      c += 'A' - 'a';
80102820:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
80102823:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102826:	c9                   	leave
80102827:	c3                   	ret
80102828:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010282f:	00 
    shift |= E0ESC;
80102830:	83 cb 40             	or     $0x40,%ebx
    return 0;
80102833:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
80102835:	89 1d 7c 16 11 80    	mov    %ebx,0x8011167c
}
8010283b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010283e:	c9                   	leave
8010283f:	c3                   	ret
    data = (shift & E0ESC ? data : data & 0x7F);
80102840:	83 e0 7f             	and    $0x7f,%eax
80102843:	85 d2                	test   %edx,%edx
80102845:	0f 44 c8             	cmove  %eax,%ecx
    shift &= ~(shiftcode[data] | E0ESC);
80102848:	0f b6 81 20 7a 10 80 	movzbl -0x7fef85e0(%ecx),%eax
8010284f:	83 c8 40             	or     $0x40,%eax
80102852:	0f b6 c0             	movzbl %al,%eax
80102855:	f7 d0                	not    %eax
80102857:	21 d8                	and    %ebx,%eax
80102859:	a3 7c 16 11 80       	mov    %eax,0x8011167c
    return 0;
8010285e:	31 c0                	xor    %eax,%eax
80102860:	eb d9                	jmp    8010283b <kbdgetc+0x8b>
80102862:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    else if('A' <= c && c <= 'Z')
80102868:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010286b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010286e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102871:	c9                   	leave
      c += 'a' - 'A';
80102872:	83 f9 1a             	cmp    $0x1a,%ecx
80102875:	0f 42 c2             	cmovb  %edx,%eax
}
80102878:	c3                   	ret
80102879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80102880:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102885:	c3                   	ret
80102886:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010288d:	00 
8010288e:	66 90                	xchg   %ax,%ax

80102890 <kbdintr>:

void
kbdintr(void)
{
80102890:	55                   	push   %ebp
80102891:	89 e5                	mov    %esp,%ebp
80102893:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102896:	68 b0 27 10 80       	push   $0x801027b0
8010289b:	e8 80 e0 ff ff       	call   80100920 <consoleintr>
}
801028a0:	83 c4 10             	add    $0x10,%esp
801028a3:	c9                   	leave
801028a4:	c3                   	ret
801028a5:	66 90                	xchg   %ax,%ax
801028a7:	66 90                	xchg   %ax,%ax
801028a9:	66 90                	xchg   %ax,%ax
801028ab:	66 90                	xchg   %ax,%ax
801028ad:	66 90                	xchg   %ax,%ax
801028af:	90                   	nop

801028b0 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
801028b0:	a1 80 16 11 80       	mov    0x80111680,%eax
801028b5:	85 c0                	test   %eax,%eax
801028b7:	0f 84 c3 00 00 00    	je     80102980 <lapicinit+0xd0>
  lapic[index] = value;
801028bd:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
801028c4:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028c7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028ca:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
801028d1:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801028d4:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028d7:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
801028de:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
801028e1:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028e4:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801028eb:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
801028ee:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028f1:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801028f8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801028fb:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801028fe:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
80102905:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102908:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
8010290b:	8b 50 30             	mov    0x30(%eax),%edx
8010290e:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
80102914:	75 72                	jne    80102988 <lapicinit+0xd8>
  lapic[index] = value;
80102916:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
8010291d:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102920:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102923:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
8010292a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010292d:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102930:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
80102937:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010293a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010293d:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102944:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102947:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010294a:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80102951:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102954:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102957:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
8010295e:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102961:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102964:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102968:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010296e:	80 e6 10             	and    $0x10,%dh
80102971:	75 f5                	jne    80102968 <lapicinit+0xb8>
  lapic[index] = value;
80102973:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
8010297a:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010297d:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102980:	c3                   	ret
80102981:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  lapic[index] = value;
80102988:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
8010298f:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
80102992:	8b 50 20             	mov    0x20(%eax),%edx
}
80102995:	e9 7c ff ff ff       	jmp    80102916 <lapicinit+0x66>
8010299a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801029a0 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
801029a0:	a1 80 16 11 80       	mov    0x80111680,%eax
801029a5:	85 c0                	test   %eax,%eax
801029a7:	74 07                	je     801029b0 <lapicid+0x10>
    return 0;
  return lapic[ID] >> 24;
801029a9:	8b 40 20             	mov    0x20(%eax),%eax
801029ac:	c1 e8 18             	shr    $0x18,%eax
801029af:	c3                   	ret
    return 0;
801029b0:	31 c0                	xor    %eax,%eax
}
801029b2:	c3                   	ret
801029b3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801029ba:	00 
801029bb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801029c0 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
801029c0:	a1 80 16 11 80       	mov    0x80111680,%eax
801029c5:	85 c0                	test   %eax,%eax
801029c7:	74 0d                	je     801029d6 <lapiceoi+0x16>
  lapic[index] = value;
801029c9:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801029d0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801029d3:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
801029d6:	c3                   	ret
801029d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801029de:	00 
801029df:	90                   	nop

801029e0 <microdelay>:
// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
}
801029e0:	c3                   	ret
801029e1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801029e8:	00 
801029e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801029f0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801029f0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801029f1:	b8 0f 00 00 00       	mov    $0xf,%eax
801029f6:	ba 70 00 00 00       	mov    $0x70,%edx
801029fb:	89 e5                	mov    %esp,%ebp
801029fd:	53                   	push   %ebx
801029fe:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80102a01:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102a04:	ee                   	out    %al,(%dx)
80102a05:	b8 0a 00 00 00       	mov    $0xa,%eax
80102a0a:	ba 71 00 00 00       	mov    $0x71,%edx
80102a0f:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
80102a10:	31 c0                	xor    %eax,%eax
  lapic[index] = value;
80102a12:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
80102a15:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
80102a1b:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
80102a1d:	c1 e9 0c             	shr    $0xc,%ecx
  lapic[index] = value;
80102a20:	89 da                	mov    %ebx,%edx
  wrv[1] = addr >> 4;
80102a22:	c1 e8 04             	shr    $0x4,%eax
    lapicw(ICRLO, STARTUP | (addr>>12));
80102a25:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
80102a28:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
80102a2e:	a1 80 16 11 80       	mov    0x80111680,%eax
80102a33:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a39:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102a3c:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80102a43:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a46:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102a49:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102a50:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102a53:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102a56:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a5c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102a5f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a65:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102a68:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a6e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102a71:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102a77:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
80102a7a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102a7d:	c9                   	leave
80102a7e:	c3                   	ret
80102a7f:	90                   	nop

80102a80 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102a80:	55                   	push   %ebp
80102a81:	b8 0b 00 00 00       	mov    $0xb,%eax
80102a86:	ba 70 00 00 00       	mov    $0x70,%edx
80102a8b:	89 e5                	mov    %esp,%ebp
80102a8d:	57                   	push   %edi
80102a8e:	56                   	push   %esi
80102a8f:	53                   	push   %ebx
80102a90:	83 ec 4c             	sub    $0x4c,%esp
80102a93:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102a94:	ba 71 00 00 00       	mov    $0x71,%edx
80102a99:	ec                   	in     (%dx),%al
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);

  bcd = (sb & (1 << 2)) == 0;
80102a9a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102a9d:	bf 70 00 00 00       	mov    $0x70,%edi
80102aa2:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102aa5:	8d 76 00             	lea    0x0(%esi),%esi
80102aa8:	31 c0                	xor    %eax,%eax
80102aaa:	89 fa                	mov    %edi,%edx
80102aac:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102aad:	b9 71 00 00 00       	mov    $0x71,%ecx
80102ab2:	89 ca                	mov    %ecx,%edx
80102ab4:	ec                   	in     (%dx),%al
80102ab5:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ab8:	89 fa                	mov    %edi,%edx
80102aba:	b8 02 00 00 00       	mov    $0x2,%eax
80102abf:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ac0:	89 ca                	mov    %ecx,%edx
80102ac2:	ec                   	in     (%dx),%al
80102ac3:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ac6:	89 fa                	mov    %edi,%edx
80102ac8:	b8 04 00 00 00       	mov    $0x4,%eax
80102acd:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102ace:	89 ca                	mov    %ecx,%edx
80102ad0:	ec                   	in     (%dx),%al
80102ad1:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ad4:	89 fa                	mov    %edi,%edx
80102ad6:	b8 07 00 00 00       	mov    $0x7,%eax
80102adb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102adc:	89 ca                	mov    %ecx,%edx
80102ade:	ec                   	in     (%dx),%al
80102adf:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ae2:	89 fa                	mov    %edi,%edx
80102ae4:	b8 08 00 00 00       	mov    $0x8,%eax
80102ae9:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102aea:	89 ca                	mov    %ecx,%edx
80102aec:	ec                   	in     (%dx),%al
80102aed:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102aef:	89 fa                	mov    %edi,%edx
80102af1:	b8 09 00 00 00       	mov    $0x9,%eax
80102af6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102af7:	89 ca                	mov    %ecx,%edx
80102af9:	ec                   	in     (%dx),%al
80102afa:	0f b6 d8             	movzbl %al,%ebx
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102afd:	89 fa                	mov    %edi,%edx
80102aff:	b8 0a 00 00 00       	mov    $0xa,%eax
80102b04:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b05:	89 ca                	mov    %ecx,%edx
80102b07:	ec                   	in     (%dx),%al

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
80102b08:	84 c0                	test   %al,%al
80102b0a:	78 9c                	js     80102aa8 <cmostime+0x28>
  return inb(CMOS_RETURN);
80102b0c:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
80102b10:	89 f2                	mov    %esi,%edx
80102b12:	89 5d cc             	mov    %ebx,-0x34(%ebp)
80102b15:	0f b6 f2             	movzbl %dl,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b18:	89 fa                	mov    %edi,%edx
80102b1a:	89 45 b8             	mov    %eax,-0x48(%ebp)
80102b1d:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
80102b21:	89 75 c8             	mov    %esi,-0x38(%ebp)
80102b24:	89 45 bc             	mov    %eax,-0x44(%ebp)
80102b27:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
80102b2b:	89 45 c0             	mov    %eax,-0x40(%ebp)
80102b2e:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
80102b32:	89 45 c4             	mov    %eax,-0x3c(%ebp)
80102b35:	31 c0                	xor    %eax,%eax
80102b37:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b38:	89 ca                	mov    %ecx,%edx
80102b3a:	ec                   	in     (%dx),%al
80102b3b:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b3e:	89 fa                	mov    %edi,%edx
80102b40:	89 45 d0             	mov    %eax,-0x30(%ebp)
80102b43:	b8 02 00 00 00       	mov    $0x2,%eax
80102b48:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b49:	89 ca                	mov    %ecx,%edx
80102b4b:	ec                   	in     (%dx),%al
80102b4c:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b4f:	89 fa                	mov    %edi,%edx
80102b51:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102b54:	b8 04 00 00 00       	mov    $0x4,%eax
80102b59:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b5a:	89 ca                	mov    %ecx,%edx
80102b5c:	ec                   	in     (%dx),%al
80102b5d:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b60:	89 fa                	mov    %edi,%edx
80102b62:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102b65:	b8 07 00 00 00       	mov    $0x7,%eax
80102b6a:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b6b:	89 ca                	mov    %ecx,%edx
80102b6d:	ec                   	in     (%dx),%al
80102b6e:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b71:	89 fa                	mov    %edi,%edx
80102b73:	89 45 dc             	mov    %eax,-0x24(%ebp)
80102b76:	b8 08 00 00 00       	mov    $0x8,%eax
80102b7b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b7c:	89 ca                	mov    %ecx,%edx
80102b7e:	ec                   	in     (%dx),%al
80102b7f:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102b82:	89 fa                	mov    %edi,%edx
80102b84:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102b87:	b8 09 00 00 00       	mov    $0x9,%eax
80102b8c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102b8d:	89 ca                	mov    %ecx,%edx
80102b8f:	ec                   	in     (%dx),%al
80102b90:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102b93:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
80102b96:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102b99:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102b9c:	6a 18                	push   $0x18
80102b9e:	50                   	push   %eax
80102b9f:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102ba2:	50                   	push   %eax
80102ba3:	e8 08 1c 00 00       	call   801047b0 <memcmp>
80102ba8:	83 c4 10             	add    $0x10,%esp
80102bab:	85 c0                	test   %eax,%eax
80102bad:	0f 85 f5 fe ff ff    	jne    80102aa8 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102bb3:	0f b6 75 b3          	movzbl -0x4d(%ebp),%esi
80102bb7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102bba:	89 f0                	mov    %esi,%eax
80102bbc:	84 c0                	test   %al,%al
80102bbe:	75 78                	jne    80102c38 <cmostime+0x1b8>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80102bc0:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102bc3:	89 c2                	mov    %eax,%edx
80102bc5:	83 e0 0f             	and    $0xf,%eax
80102bc8:	c1 ea 04             	shr    $0x4,%edx
80102bcb:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102bce:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102bd1:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102bd4:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102bd7:	89 c2                	mov    %eax,%edx
80102bd9:	83 e0 0f             	and    $0xf,%eax
80102bdc:	c1 ea 04             	shr    $0x4,%edx
80102bdf:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102be2:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102be5:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102be8:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102beb:	89 c2                	mov    %eax,%edx
80102bed:	83 e0 0f             	and    $0xf,%eax
80102bf0:	c1 ea 04             	shr    $0x4,%edx
80102bf3:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102bf6:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102bf9:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
80102bfc:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102bff:	89 c2                	mov    %eax,%edx
80102c01:	83 e0 0f             	and    $0xf,%eax
80102c04:	c1 ea 04             	shr    $0x4,%edx
80102c07:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c0a:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c0d:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
80102c10:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102c13:	89 c2                	mov    %eax,%edx
80102c15:	83 e0 0f             	and    $0xf,%eax
80102c18:	c1 ea 04             	shr    $0x4,%edx
80102c1b:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c1e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c21:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
80102c24:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102c27:	89 c2                	mov    %eax,%edx
80102c29:	83 e0 0f             	and    $0xf,%eax
80102c2c:	c1 ea 04             	shr    $0x4,%edx
80102c2f:	8d 14 92             	lea    (%edx,%edx,4),%edx
80102c32:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102c35:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
80102c38:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102c3b:	89 03                	mov    %eax,(%ebx)
80102c3d:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102c40:	89 43 04             	mov    %eax,0x4(%ebx)
80102c43:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102c46:	89 43 08             	mov    %eax,0x8(%ebx)
80102c49:	8b 45 c4             	mov    -0x3c(%ebp),%eax
80102c4c:	89 43 0c             	mov    %eax,0xc(%ebx)
80102c4f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102c52:	89 43 10             	mov    %eax,0x10(%ebx)
80102c55:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102c58:	89 43 14             	mov    %eax,0x14(%ebx)
  r->year += 2000;
80102c5b:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
}
80102c62:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102c65:	5b                   	pop    %ebx
80102c66:	5e                   	pop    %esi
80102c67:	5f                   	pop    %edi
80102c68:	5d                   	pop    %ebp
80102c69:	c3                   	ret
80102c6a:	66 90                	xchg   %ax,%ax
80102c6c:	66 90                	xchg   %ax,%ax
80102c6e:	66 90                	xchg   %ax,%ax

80102c70 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102c70:	8b 0d e8 16 11 80    	mov    0x801116e8,%ecx
80102c76:	85 c9                	test   %ecx,%ecx
80102c78:	0f 8e 8a 00 00 00    	jle    80102d08 <install_trans+0x98>
{
80102c7e:	55                   	push   %ebp
80102c7f:	89 e5                	mov    %esp,%ebp
80102c81:	57                   	push   %edi
  for (tail = 0; tail < log.lh.n; tail++) {
80102c82:	31 ff                	xor    %edi,%edi
{
80102c84:	56                   	push   %esi
80102c85:	53                   	push   %ebx
80102c86:	83 ec 0c             	sub    $0xc,%esp
80102c89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102c90:	a1 d4 16 11 80       	mov    0x801116d4,%eax
80102c95:	83 ec 08             	sub    $0x8,%esp
80102c98:	01 f8                	add    %edi,%eax
80102c9a:	83 c0 01             	add    $0x1,%eax
80102c9d:	50                   	push   %eax
80102c9e:	ff 35 e4 16 11 80    	push   0x801116e4
80102ca4:	e8 27 d4 ff ff       	call   801000d0 <bread>
80102ca9:	89 c6                	mov    %eax,%esi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102cab:	58                   	pop    %eax
80102cac:	5a                   	pop    %edx
80102cad:	ff 34 bd ec 16 11 80 	push   -0x7feee914(,%edi,4)
80102cb4:	ff 35 e4 16 11 80    	push   0x801116e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102cba:	83 c7 01             	add    $0x1,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102cbd:	e8 0e d4 ff ff       	call   801000d0 <bread>
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102cc2:	83 c4 0c             	add    $0xc,%esp
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102cc5:	89 c3                	mov    %eax,%ebx
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102cc7:	8d 46 5c             	lea    0x5c(%esi),%eax
80102cca:	68 00 02 00 00       	push   $0x200
80102ccf:	50                   	push   %eax
80102cd0:	8d 43 5c             	lea    0x5c(%ebx),%eax
80102cd3:	50                   	push   %eax
80102cd4:	e8 27 1b 00 00       	call   80104800 <memmove>
    bwrite(dbuf);  // write dst to disk
80102cd9:	89 1c 24             	mov    %ebx,(%esp)
80102cdc:	e8 cf d4 ff ff       	call   801001b0 <bwrite>
    brelse(lbuf);
80102ce1:	89 34 24             	mov    %esi,(%esp)
80102ce4:	e8 07 d5 ff ff       	call   801001f0 <brelse>
    brelse(dbuf);
80102ce9:	89 1c 24             	mov    %ebx,(%esp)
80102cec:	e8 ff d4 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102cf1:	83 c4 10             	add    $0x10,%esp
80102cf4:	39 3d e8 16 11 80    	cmp    %edi,0x801116e8
80102cfa:	7f 94                	jg     80102c90 <install_trans+0x20>
  }
}
80102cfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102cff:	5b                   	pop    %ebx
80102d00:	5e                   	pop    %esi
80102d01:	5f                   	pop    %edi
80102d02:	5d                   	pop    %ebp
80102d03:	c3                   	ret
80102d04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102d08:	c3                   	ret
80102d09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d10 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102d10:	55                   	push   %ebp
80102d11:	89 e5                	mov    %esp,%ebp
80102d13:	53                   	push   %ebx
80102d14:	83 ec 0c             	sub    $0xc,%esp
  struct buf *buf = bread(log.dev, log.start);
80102d17:	ff 35 d4 16 11 80    	push   0x801116d4
80102d1d:	ff 35 e4 16 11 80    	push   0x801116e4
80102d23:	e8 a8 d3 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
  for (i = 0; i < log.lh.n; i++) {
80102d28:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102d2b:	89 c3                	mov    %eax,%ebx
  hb->n = log.lh.n;
80102d2d:	a1 e8 16 11 80       	mov    0x801116e8,%eax
80102d32:	89 43 5c             	mov    %eax,0x5c(%ebx)
  for (i = 0; i < log.lh.n; i++) {
80102d35:	85 c0                	test   %eax,%eax
80102d37:	7e 19                	jle    80102d52 <write_head+0x42>
80102d39:	31 d2                	xor    %edx,%edx
80102d3b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    hb->block[i] = log.lh.block[i];
80102d40:	8b 0c 95 ec 16 11 80 	mov    -0x7feee914(,%edx,4),%ecx
80102d47:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102d4b:	83 c2 01             	add    $0x1,%edx
80102d4e:	39 d0                	cmp    %edx,%eax
80102d50:	75 ee                	jne    80102d40 <write_head+0x30>
  }
  bwrite(buf);
80102d52:	83 ec 0c             	sub    $0xc,%esp
80102d55:	53                   	push   %ebx
80102d56:	e8 55 d4 ff ff       	call   801001b0 <bwrite>
  brelse(buf);
80102d5b:	89 1c 24             	mov    %ebx,(%esp)
80102d5e:	e8 8d d4 ff ff       	call   801001f0 <brelse>
}
80102d63:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d66:	83 c4 10             	add    $0x10,%esp
80102d69:	c9                   	leave
80102d6a:	c3                   	ret
80102d6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102d70 <initlog>:
{
80102d70:	55                   	push   %ebp
80102d71:	89 e5                	mov    %esp,%ebp
80102d73:	53                   	push   %ebx
80102d74:	83 ec 2c             	sub    $0x2c,%esp
80102d77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102d7a:	68 17 74 10 80       	push   $0x80107417
80102d7f:	68 a0 16 11 80       	push   $0x801116a0
80102d84:	e8 f7 16 00 00       	call   80104480 <initlock>
  readsb(dev, &sb);
80102d89:	58                   	pop    %eax
80102d8a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102d8d:	5a                   	pop    %edx
80102d8e:	50                   	push   %eax
80102d8f:	53                   	push   %ebx
80102d90:	e8 7b e8 ff ff       	call   80101610 <readsb>
  log.start = sb.logstart;
80102d95:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102d98:	59                   	pop    %ecx
  log.dev = dev;
80102d99:	89 1d e4 16 11 80    	mov    %ebx,0x801116e4
  log.size = sb.nlog;
80102d9f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102da2:	a3 d4 16 11 80       	mov    %eax,0x801116d4
  log.size = sb.nlog;
80102da7:	89 15 d8 16 11 80    	mov    %edx,0x801116d8
  struct buf *buf = bread(log.dev, log.start);
80102dad:	5a                   	pop    %edx
80102dae:	50                   	push   %eax
80102daf:	53                   	push   %ebx
80102db0:	e8 1b d3 ff ff       	call   801000d0 <bread>
  for (i = 0; i < log.lh.n; i++) {
80102db5:	83 c4 10             	add    $0x10,%esp
  log.lh.n = lh->n;
80102db8:	8b 58 5c             	mov    0x5c(%eax),%ebx
80102dbb:	89 1d e8 16 11 80    	mov    %ebx,0x801116e8
  for (i = 0; i < log.lh.n; i++) {
80102dc1:	85 db                	test   %ebx,%ebx
80102dc3:	7e 1d                	jle    80102de2 <initlog+0x72>
80102dc5:	31 d2                	xor    %edx,%edx
80102dc7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102dce:	00 
80102dcf:	90                   	nop
    log.lh.block[i] = lh->block[i];
80102dd0:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80102dd4:	89 0c 95 ec 16 11 80 	mov    %ecx,-0x7feee914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
80102ddb:	83 c2 01             	add    $0x1,%edx
80102dde:	39 d3                	cmp    %edx,%ebx
80102de0:	75 ee                	jne    80102dd0 <initlog+0x60>
  brelse(buf);
80102de2:	83 ec 0c             	sub    $0xc,%esp
80102de5:	50                   	push   %eax
80102de6:	e8 05 d4 ff ff       	call   801001f0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102deb:	e8 80 fe ff ff       	call   80102c70 <install_trans>
  log.lh.n = 0;
80102df0:	c7 05 e8 16 11 80 00 	movl   $0x0,0x801116e8
80102df7:	00 00 00 
  write_head(); // clear the log
80102dfa:	e8 11 ff ff ff       	call   80102d10 <write_head>
}
80102dff:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e02:	83 c4 10             	add    $0x10,%esp
80102e05:	c9                   	leave
80102e06:	c3                   	ret
80102e07:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e0e:	00 
80102e0f:	90                   	nop

80102e10 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102e10:	55                   	push   %ebp
80102e11:	89 e5                	mov    %esp,%ebp
80102e13:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102e16:	68 a0 16 11 80       	push   $0x801116a0
80102e1b:	e8 50 18 00 00       	call   80104670 <acquire>
80102e20:	83 c4 10             	add    $0x10,%esp
80102e23:	eb 18                	jmp    80102e3d <begin_op+0x2d>
80102e25:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102e28:	83 ec 08             	sub    $0x8,%esp
80102e2b:	68 a0 16 11 80       	push   $0x801116a0
80102e30:	68 a0 16 11 80       	push   $0x801116a0
80102e35:	e8 b6 12 00 00       	call   801040f0 <sleep>
80102e3a:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102e3d:	a1 e0 16 11 80       	mov    0x801116e0,%eax
80102e42:	85 c0                	test   %eax,%eax
80102e44:	75 e2                	jne    80102e28 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102e46:	a1 dc 16 11 80       	mov    0x801116dc,%eax
80102e4b:	8b 15 e8 16 11 80    	mov    0x801116e8,%edx
80102e51:	83 c0 01             	add    $0x1,%eax
80102e54:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102e57:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102e5a:	83 fa 1e             	cmp    $0x1e,%edx
80102e5d:	7f c9                	jg     80102e28 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102e5f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102e62:	a3 dc 16 11 80       	mov    %eax,0x801116dc
      release(&log.lock);
80102e67:	68 a0 16 11 80       	push   $0x801116a0
80102e6c:	e8 9f 17 00 00       	call   80104610 <release>
      break;
    }
  }
}
80102e71:	83 c4 10             	add    $0x10,%esp
80102e74:	c9                   	leave
80102e75:	c3                   	ret
80102e76:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e7d:	00 
80102e7e:	66 90                	xchg   %ax,%ax

80102e80 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102e80:	55                   	push   %ebp
80102e81:	89 e5                	mov    %esp,%ebp
80102e83:	57                   	push   %edi
80102e84:	56                   	push   %esi
80102e85:	53                   	push   %ebx
80102e86:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102e89:	68 a0 16 11 80       	push   $0x801116a0
80102e8e:	e8 dd 17 00 00       	call   80104670 <acquire>
  log.outstanding -= 1;
80102e93:	a1 dc 16 11 80       	mov    0x801116dc,%eax
  if(log.committing)
80102e98:	8b 35 e0 16 11 80    	mov    0x801116e0,%esi
80102e9e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102ea1:	8d 58 ff             	lea    -0x1(%eax),%ebx
80102ea4:	89 1d dc 16 11 80    	mov    %ebx,0x801116dc
  if(log.committing)
80102eaa:	85 f6                	test   %esi,%esi
80102eac:	0f 85 22 01 00 00    	jne    80102fd4 <end_op+0x154>
    panic("log.committing");
  if(log.outstanding == 0){
80102eb2:	85 db                	test   %ebx,%ebx
80102eb4:	0f 85 f6 00 00 00    	jne    80102fb0 <end_op+0x130>
    do_commit = 1;
    log.committing = 1;
80102eba:	c7 05 e0 16 11 80 01 	movl   $0x1,0x801116e0
80102ec1:	00 00 00 
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102ec4:	83 ec 0c             	sub    $0xc,%esp
80102ec7:	68 a0 16 11 80       	push   $0x801116a0
80102ecc:	e8 3f 17 00 00       	call   80104610 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102ed1:	8b 0d e8 16 11 80    	mov    0x801116e8,%ecx
80102ed7:	83 c4 10             	add    $0x10,%esp
80102eda:	85 c9                	test   %ecx,%ecx
80102edc:	7f 42                	jg     80102f20 <end_op+0xa0>
    acquire(&log.lock);
80102ede:	83 ec 0c             	sub    $0xc,%esp
80102ee1:	68 a0 16 11 80       	push   $0x801116a0
80102ee6:	e8 85 17 00 00       	call   80104670 <acquire>
    log.committing = 0;
80102eeb:	c7 05 e0 16 11 80 00 	movl   $0x0,0x801116e0
80102ef2:	00 00 00 
    wakeup(&log);
80102ef5:	c7 04 24 a0 16 11 80 	movl   $0x801116a0,(%esp)
80102efc:	e8 af 12 00 00       	call   801041b0 <wakeup>
    release(&log.lock);
80102f01:	c7 04 24 a0 16 11 80 	movl   $0x801116a0,(%esp)
80102f08:	e8 03 17 00 00       	call   80104610 <release>
80102f0d:	83 c4 10             	add    $0x10,%esp
}
80102f10:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102f13:	5b                   	pop    %ebx
80102f14:	5e                   	pop    %esi
80102f15:	5f                   	pop    %edi
80102f16:	5d                   	pop    %ebp
80102f17:	c3                   	ret
80102f18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f1f:	00 
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102f20:	a1 d4 16 11 80       	mov    0x801116d4,%eax
80102f25:	83 ec 08             	sub    $0x8,%esp
80102f28:	01 d8                	add    %ebx,%eax
80102f2a:	83 c0 01             	add    $0x1,%eax
80102f2d:	50                   	push   %eax
80102f2e:	ff 35 e4 16 11 80    	push   0x801116e4
80102f34:	e8 97 d1 ff ff       	call   801000d0 <bread>
80102f39:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102f3b:	58                   	pop    %eax
80102f3c:	5a                   	pop    %edx
80102f3d:	ff 34 9d ec 16 11 80 	push   -0x7feee914(,%ebx,4)
80102f44:	ff 35 e4 16 11 80    	push   0x801116e4
  for (tail = 0; tail < log.lh.n; tail++) {
80102f4a:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102f4d:	e8 7e d1 ff ff       	call   801000d0 <bread>
    memmove(to->data, from->data, BSIZE);
80102f52:	83 c4 0c             	add    $0xc,%esp
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102f55:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102f57:	8d 40 5c             	lea    0x5c(%eax),%eax
80102f5a:	68 00 02 00 00       	push   $0x200
80102f5f:	50                   	push   %eax
80102f60:	8d 46 5c             	lea    0x5c(%esi),%eax
80102f63:	50                   	push   %eax
80102f64:	e8 97 18 00 00       	call   80104800 <memmove>
    bwrite(to);  // write the log
80102f69:	89 34 24             	mov    %esi,(%esp)
80102f6c:	e8 3f d2 ff ff       	call   801001b0 <bwrite>
    brelse(from);
80102f71:	89 3c 24             	mov    %edi,(%esp)
80102f74:	e8 77 d2 ff ff       	call   801001f0 <brelse>
    brelse(to);
80102f79:	89 34 24             	mov    %esi,(%esp)
80102f7c:	e8 6f d2 ff ff       	call   801001f0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102f81:	83 c4 10             	add    $0x10,%esp
80102f84:	3b 1d e8 16 11 80    	cmp    0x801116e8,%ebx
80102f8a:	7c 94                	jl     80102f20 <end_op+0xa0>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102f8c:	e8 7f fd ff ff       	call   80102d10 <write_head>
    install_trans(); // Now install writes to home locations
80102f91:	e8 da fc ff ff       	call   80102c70 <install_trans>
    log.lh.n = 0;
80102f96:	c7 05 e8 16 11 80 00 	movl   $0x0,0x801116e8
80102f9d:	00 00 00 
    write_head();    // Erase the transaction from the log
80102fa0:	e8 6b fd ff ff       	call   80102d10 <write_head>
80102fa5:	e9 34 ff ff ff       	jmp    80102ede <end_op+0x5e>
80102faa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&log);
80102fb0:	83 ec 0c             	sub    $0xc,%esp
80102fb3:	68 a0 16 11 80       	push   $0x801116a0
80102fb8:	e8 f3 11 00 00       	call   801041b0 <wakeup>
  release(&log.lock);
80102fbd:	c7 04 24 a0 16 11 80 	movl   $0x801116a0,(%esp)
80102fc4:	e8 47 16 00 00       	call   80104610 <release>
80102fc9:	83 c4 10             	add    $0x10,%esp
}
80102fcc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102fcf:	5b                   	pop    %ebx
80102fd0:	5e                   	pop    %esi
80102fd1:	5f                   	pop    %edi
80102fd2:	5d                   	pop    %ebp
80102fd3:	c3                   	ret
    panic("log.committing");
80102fd4:	83 ec 0c             	sub    $0xc,%esp
80102fd7:	68 1b 74 10 80       	push   $0x8010741b
80102fdc:	e8 9f d3 ff ff       	call   80100380 <panic>
80102fe1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102fe8:	00 
80102fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102ff0 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102ff0:	55                   	push   %ebp
80102ff1:	89 e5                	mov    %esp,%ebp
80102ff3:	53                   	push   %ebx
80102ff4:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102ff7:	8b 15 e8 16 11 80    	mov    0x801116e8,%edx
{
80102ffd:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103000:	83 fa 1d             	cmp    $0x1d,%edx
80103003:	7f 7d                	jg     80103082 <log_write+0x92>
80103005:	a1 d8 16 11 80       	mov    0x801116d8,%eax
8010300a:	83 e8 01             	sub    $0x1,%eax
8010300d:	39 c2                	cmp    %eax,%edx
8010300f:	7d 71                	jge    80103082 <log_write+0x92>
    panic("too big a transaction");
  if (log.outstanding < 1)
80103011:	a1 dc 16 11 80       	mov    0x801116dc,%eax
80103016:	85 c0                	test   %eax,%eax
80103018:	7e 75                	jle    8010308f <log_write+0x9f>
    panic("log_write outside of trans");

  acquire(&log.lock);
8010301a:	83 ec 0c             	sub    $0xc,%esp
8010301d:	68 a0 16 11 80       	push   $0x801116a0
80103022:	e8 49 16 00 00       	call   80104670 <acquire>
  for (i = 0; i < log.lh.n; i++) {
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103027:	8b 4b 08             	mov    0x8(%ebx),%ecx
  for (i = 0; i < log.lh.n; i++) {
8010302a:	83 c4 10             	add    $0x10,%esp
8010302d:	31 c0                	xor    %eax,%eax
8010302f:	8b 15 e8 16 11 80    	mov    0x801116e8,%edx
80103035:	85 d2                	test   %edx,%edx
80103037:	7f 0e                	jg     80103047 <log_write+0x57>
80103039:	eb 15                	jmp    80103050 <log_write+0x60>
8010303b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103040:	83 c0 01             	add    $0x1,%eax
80103043:	39 c2                	cmp    %eax,%edx
80103045:	74 29                	je     80103070 <log_write+0x80>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80103047:	39 0c 85 ec 16 11 80 	cmp    %ecx,-0x7feee914(,%eax,4)
8010304e:	75 f0                	jne    80103040 <log_write+0x50>
      break;
  }
  log.lh.block[i] = b->blockno;
80103050:	89 0c 85 ec 16 11 80 	mov    %ecx,-0x7feee914(,%eax,4)
  if (i == log.lh.n)
80103057:	39 c2                	cmp    %eax,%edx
80103059:	74 1c                	je     80103077 <log_write+0x87>
    log.lh.n++;
  b->flags |= B_DIRTY; // prevent eviction
8010305b:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
}
8010305e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  release(&log.lock);
80103061:	c7 45 08 a0 16 11 80 	movl   $0x801116a0,0x8(%ebp)
}
80103068:	c9                   	leave
  release(&log.lock);
80103069:	e9 a2 15 00 00       	jmp    80104610 <release>
8010306e:	66 90                	xchg   %ax,%ax
  log.lh.block[i] = b->blockno;
80103070:	89 0c 95 ec 16 11 80 	mov    %ecx,-0x7feee914(,%edx,4)
    log.lh.n++;
80103077:	83 c2 01             	add    $0x1,%edx
8010307a:	89 15 e8 16 11 80    	mov    %edx,0x801116e8
80103080:	eb d9                	jmp    8010305b <log_write+0x6b>
    panic("too big a transaction");
80103082:	83 ec 0c             	sub    $0xc,%esp
80103085:	68 2a 74 10 80       	push   $0x8010742a
8010308a:	e8 f1 d2 ff ff       	call   80100380 <panic>
    panic("log_write outside of trans");
8010308f:	83 ec 0c             	sub    $0xc,%esp
80103092:	68 40 74 10 80       	push   $0x80107440
80103097:	e8 e4 d2 ff ff       	call   80100380 <panic>
8010309c:	66 90                	xchg   %ax,%ax
8010309e:	66 90                	xchg   %ax,%ax

801030a0 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
801030a0:	55                   	push   %ebp
801030a1:	89 e5                	mov    %esp,%ebp
801030a3:	53                   	push   %ebx
801030a4:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
801030a7:	e8 64 09 00 00       	call   80103a10 <cpuid>
801030ac:	89 c3                	mov    %eax,%ebx
801030ae:	e8 5d 09 00 00       	call   80103a10 <cpuid>
801030b3:	83 ec 04             	sub    $0x4,%esp
801030b6:	53                   	push   %ebx
801030b7:	50                   	push   %eax
801030b8:	68 5b 74 10 80       	push   $0x8010745b
801030bd:	e8 7e d6 ff ff       	call   80100740 <cprintf>
  idtinit();       // load idt register
801030c2:	e8 e9 28 00 00       	call   801059b0 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
801030c7:	e8 e4 08 00 00       	call   801039b0 <mycpu>
801030cc:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
801030ce:	b8 01 00 00 00       	mov    $0x1,%eax
801030d3:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
801030da:	e8 01 0c 00 00       	call   80103ce0 <scheduler>
801030df:	90                   	nop

801030e0 <mpenter>:
{
801030e0:	55                   	push   %ebp
801030e1:	89 e5                	mov    %esp,%ebp
801030e3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
801030e6:	e8 c5 39 00 00       	call   80106ab0 <switchkvm>
  seginit();
801030eb:	e8 30 39 00 00       	call   80106a20 <seginit>
  lapicinit();
801030f0:	e8 bb f7 ff ff       	call   801028b0 <lapicinit>
  mpmain();
801030f5:	e8 a6 ff ff ff       	call   801030a0 <mpmain>
801030fa:	66 90                	xchg   %ax,%ax
801030fc:	66 90                	xchg   %ax,%ax
801030fe:	66 90                	xchg   %ax,%ax

80103100 <main>:
{
80103100:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80103104:	83 e4 f0             	and    $0xfffffff0,%esp
80103107:	ff 71 fc             	push   -0x4(%ecx)
8010310a:	55                   	push   %ebp
8010310b:	89 e5                	mov    %esp,%ebp
8010310d:	53                   	push   %ebx
8010310e:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010310f:	83 ec 08             	sub    $0x8,%esp
80103112:	68 00 00 40 80       	push   $0x80400000
80103117:	68 d0 54 11 80       	push   $0x801154d0
8010311c:	e8 9f f5 ff ff       	call   801026c0 <kinit1>
  kvmalloc();      // kernel page table
80103121:	e8 4a 3e 00 00       	call   80106f70 <kvmalloc>
  mpinit();        // detect other processors
80103126:	e8 85 01 00 00       	call   801032b0 <mpinit>
  lapicinit();     // interrupt controller
8010312b:	e8 80 f7 ff ff       	call   801028b0 <lapicinit>
  seginit();       // segment descriptors
80103130:	e8 eb 38 00 00       	call   80106a20 <seginit>
  picinit();       // disable pic
80103135:	e8 86 03 00 00       	call   801034c0 <picinit>
  ioapicinit();    // another interrupt controller
8010313a:	e8 51 f3 ff ff       	call   80102490 <ioapicinit>
  consoleinit();   // console hardware
8010313f:	e8 ec d9 ff ff       	call   80100b30 <consoleinit>
  uartinit();      // serial port
80103144:	e8 47 2b 00 00       	call   80105c90 <uartinit>
  pinit();         // process table
80103149:	e8 42 08 00 00       	call   80103990 <pinit>
  tvinit();        // trap vectors
8010314e:	e8 dd 27 00 00       	call   80105930 <tvinit>
  binit();         // buffer cache
80103153:	e8 e8 ce ff ff       	call   80100040 <binit>
  fileinit();      // file table
80103158:	e8 a3 dd ff ff       	call   80100f00 <fileinit>
  ideinit();       // disk 
8010315d:	e8 0e f1 ff ff       	call   80102270 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103162:	83 c4 0c             	add    $0xc,%esp
80103165:	68 8a 00 00 00       	push   $0x8a
8010316a:	68 8c a4 10 80       	push   $0x8010a48c
8010316f:	68 00 70 00 80       	push   $0x80007000
80103174:	e8 87 16 00 00       	call   80104800 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80103179:	83 c4 10             	add    $0x10,%esp
8010317c:	69 05 84 17 11 80 b0 	imul   $0xb0,0x80111784,%eax
80103183:	00 00 00 
80103186:	05 a0 17 11 80       	add    $0x801117a0,%eax
8010318b:	3d a0 17 11 80       	cmp    $0x801117a0,%eax
80103190:	76 7e                	jbe    80103210 <main+0x110>
80103192:	bb a0 17 11 80       	mov    $0x801117a0,%ebx
80103197:	eb 20                	jmp    801031b9 <main+0xb9>
80103199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801031a0:	69 05 84 17 11 80 b0 	imul   $0xb0,0x80111784,%eax
801031a7:	00 00 00 
801031aa:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
801031b0:	05 a0 17 11 80       	add    $0x801117a0,%eax
801031b5:	39 c3                	cmp    %eax,%ebx
801031b7:	73 57                	jae    80103210 <main+0x110>
    if(c == mycpu())  // We've started already.
801031b9:	e8 f2 07 00 00       	call   801039b0 <mycpu>
801031be:	39 c3                	cmp    %eax,%ebx
801031c0:	74 de                	je     801031a0 <main+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
801031c2:	e8 69 f5 ff ff       	call   80102730 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
    *(void(**)(void))(code-8) = mpenter;
    *(int**)(code-12) = (void *) V2P(entrypgdir);

    lapicstartap(c->apicid, V2P(code));
801031c7:	83 ec 08             	sub    $0x8,%esp
    *(void(**)(void))(code-8) = mpenter;
801031ca:	c7 05 f8 6f 00 80 e0 	movl   $0x801030e0,0x80006ff8
801031d1:	30 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801031d4:	c7 05 f4 6f 00 80 00 	movl   $0x109000,0x80006ff4
801031db:	90 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
801031de:	05 00 10 00 00       	add    $0x1000,%eax
801031e3:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
    lapicstartap(c->apicid, V2P(code));
801031e8:	0f b6 03             	movzbl (%ebx),%eax
801031eb:	68 00 70 00 00       	push   $0x7000
801031f0:	50                   	push   %eax
801031f1:	e8 fa f7 ff ff       	call   801029f0 <lapicstartap>

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801031f6:	83 c4 10             	add    $0x10,%esp
801031f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103200:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80103206:	85 c0                	test   %eax,%eax
80103208:	74 f6                	je     80103200 <main+0x100>
8010320a:	eb 94                	jmp    801031a0 <main+0xa0>
8010320c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80103210:	83 ec 08             	sub    $0x8,%esp
80103213:	68 00 00 00 8e       	push   $0x8e000000
80103218:	68 00 00 40 80       	push   $0x80400000
8010321d:	e8 3e f4 ff ff       	call   80102660 <kinit2>
  userinit();      // first user process
80103222:	e8 39 08 00 00       	call   80103a60 <userinit>
  mpmain();        // finish this processor's setup
80103227:	e8 74 fe ff ff       	call   801030a0 <mpmain>
8010322c:	66 90                	xchg   %ax,%ax
8010322e:	66 90                	xchg   %ax,%ax

80103230 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103230:	55                   	push   %ebp
80103231:	89 e5                	mov    %esp,%ebp
80103233:	57                   	push   %edi
80103234:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80103235:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
8010323b:	53                   	push   %ebx
  e = addr+len;
8010323c:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
8010323f:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80103242:	39 de                	cmp    %ebx,%esi
80103244:	72 10                	jb     80103256 <mpsearch1+0x26>
80103246:	eb 50                	jmp    80103298 <mpsearch1+0x68>
80103248:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010324f:	00 
80103250:	89 fe                	mov    %edi,%esi
80103252:	39 df                	cmp    %ebx,%edi
80103254:	73 42                	jae    80103298 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103256:	83 ec 04             	sub    $0x4,%esp
80103259:	8d 7e 10             	lea    0x10(%esi),%edi
8010325c:	6a 04                	push   $0x4
8010325e:	68 6f 74 10 80       	push   $0x8010746f
80103263:	56                   	push   %esi
80103264:	e8 47 15 00 00       	call   801047b0 <memcmp>
80103269:	83 c4 10             	add    $0x10,%esp
8010326c:	85 c0                	test   %eax,%eax
8010326e:	75 e0                	jne    80103250 <mpsearch1+0x20>
80103270:	89 f2                	mov    %esi,%edx
80103272:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103278:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
8010327b:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
8010327e:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103280:	39 fa                	cmp    %edi,%edx
80103282:	75 f4                	jne    80103278 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103284:	84 c0                	test   %al,%al
80103286:	75 c8                	jne    80103250 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103288:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010328b:	89 f0                	mov    %esi,%eax
8010328d:	5b                   	pop    %ebx
8010328e:	5e                   	pop    %esi
8010328f:	5f                   	pop    %edi
80103290:	5d                   	pop    %ebp
80103291:	c3                   	ret
80103292:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103298:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010329b:	31 f6                	xor    %esi,%esi
}
8010329d:	5b                   	pop    %ebx
8010329e:	89 f0                	mov    %esi,%eax
801032a0:	5e                   	pop    %esi
801032a1:	5f                   	pop    %edi
801032a2:	5d                   	pop    %ebp
801032a3:	c3                   	ret
801032a4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801032ab:	00 
801032ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801032b0 <mpinit>:
  return conf;
}

void
mpinit(void)
{
801032b0:	55                   	push   %ebp
801032b1:	89 e5                	mov    %esp,%ebp
801032b3:	57                   	push   %edi
801032b4:	56                   	push   %esi
801032b5:	53                   	push   %ebx
801032b6:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
801032b9:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
801032c0:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
801032c7:	c1 e0 08             	shl    $0x8,%eax
801032ca:	09 d0                	or     %edx,%eax
801032cc:	c1 e0 04             	shl    $0x4,%eax
801032cf:	75 1b                	jne    801032ec <mpinit+0x3c>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
801032d1:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
801032d8:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
801032df:	c1 e0 08             	shl    $0x8,%eax
801032e2:	09 d0                	or     %edx,%eax
801032e4:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
801032e7:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
801032ec:	ba 00 04 00 00       	mov    $0x400,%edx
801032f1:	e8 3a ff ff ff       	call   80103230 <mpsearch1>
801032f6:	89 c3                	mov    %eax,%ebx
801032f8:	85 c0                	test   %eax,%eax
801032fa:	0f 84 58 01 00 00    	je     80103458 <mpinit+0x1a8>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103300:	8b 73 04             	mov    0x4(%ebx),%esi
80103303:	85 f6                	test   %esi,%esi
80103305:	0f 84 3d 01 00 00    	je     80103448 <mpinit+0x198>
  if(memcmp(conf, "PCMP", 4) != 0)
8010330b:	83 ec 04             	sub    $0x4,%esp
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
8010330e:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80103314:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103317:	6a 04                	push   $0x4
80103319:	68 74 74 10 80       	push   $0x80107474
8010331e:	50                   	push   %eax
8010331f:	e8 8c 14 00 00       	call   801047b0 <memcmp>
80103324:	83 c4 10             	add    $0x10,%esp
80103327:	85 c0                	test   %eax,%eax
80103329:	0f 85 19 01 00 00    	jne    80103448 <mpinit+0x198>
  if(conf->version != 1 && conf->version != 4)
8010332f:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103336:	3c 01                	cmp    $0x1,%al
80103338:	74 08                	je     80103342 <mpinit+0x92>
8010333a:	3c 04                	cmp    $0x4,%al
8010333c:	0f 85 06 01 00 00    	jne    80103448 <mpinit+0x198>
  if(sum((uchar*)conf, conf->length) != 0)
80103342:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
  for(i=0; i<len; i++)
80103349:	66 85 d2             	test   %dx,%dx
8010334c:	74 22                	je     80103370 <mpinit+0xc0>
8010334e:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80103351:	89 f0                	mov    %esi,%eax
  sum = 0;
80103353:	31 d2                	xor    %edx,%edx
80103355:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103358:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
  for(i=0; i<len; i++)
8010335f:	83 c0 01             	add    $0x1,%eax
    sum += addr[i];
80103362:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103364:	39 f8                	cmp    %edi,%eax
80103366:	75 f0                	jne    80103358 <mpinit+0xa8>
  if(sum((uchar*)conf, conf->length) != 0)
80103368:	84 d2                	test   %dl,%dl
8010336a:	0f 85 d8 00 00 00    	jne    80103448 <mpinit+0x198>
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103370:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103376:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103379:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  lapic = (uint*)conf->lapicaddr;
8010337c:	a3 80 16 11 80       	mov    %eax,0x80111680
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103381:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103388:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
8010338e:	01 d7                	add    %edx,%edi
80103390:	89 fa                	mov    %edi,%edx
  ismp = 1;
80103392:	bf 01 00 00 00       	mov    $0x1,%edi
80103397:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010339e:	00 
8010339f:	90                   	nop
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801033a0:	39 d0                	cmp    %edx,%eax
801033a2:	73 19                	jae    801033bd <mpinit+0x10d>
    switch(*p){
801033a4:	0f b6 08             	movzbl (%eax),%ecx
801033a7:	80 f9 02             	cmp    $0x2,%cl
801033aa:	0f 84 80 00 00 00    	je     80103430 <mpinit+0x180>
801033b0:	77 6e                	ja     80103420 <mpinit+0x170>
801033b2:	84 c9                	test   %cl,%cl
801033b4:	74 3a                	je     801033f0 <mpinit+0x140>
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
801033b6:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
801033b9:	39 d0                	cmp    %edx,%eax
801033bb:	72 e7                	jb     801033a4 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
801033bd:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801033c0:	85 ff                	test   %edi,%edi
801033c2:	0f 84 dd 00 00 00    	je     801034a5 <mpinit+0x1f5>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
801033c8:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
801033cc:	74 15                	je     801033e3 <mpinit+0x133>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801033ce:	b8 70 00 00 00       	mov    $0x70,%eax
801033d3:	ba 22 00 00 00       	mov    $0x22,%edx
801033d8:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801033d9:	ba 23 00 00 00       	mov    $0x23,%edx
801033de:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
801033df:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801033e2:	ee                   	out    %al,(%dx)
  }
}
801033e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801033e6:	5b                   	pop    %ebx
801033e7:	5e                   	pop    %esi
801033e8:	5f                   	pop    %edi
801033e9:	5d                   	pop    %ebp
801033ea:	c3                   	ret
801033eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(ncpu < NCPU) {
801033f0:	8b 0d 84 17 11 80    	mov    0x80111784,%ecx
801033f6:	83 f9 07             	cmp    $0x7,%ecx
801033f9:	7f 19                	jg     80103414 <mpinit+0x164>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801033fb:	69 f1 b0 00 00 00    	imul   $0xb0,%ecx,%esi
80103401:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
        ncpu++;
80103405:	83 c1 01             	add    $0x1,%ecx
80103408:	89 0d 84 17 11 80    	mov    %ecx,0x80111784
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
8010340e:	88 9e a0 17 11 80    	mov    %bl,-0x7feee860(%esi)
      p += sizeof(struct mpproc);
80103414:	83 c0 14             	add    $0x14,%eax
      continue;
80103417:	eb 87                	jmp    801033a0 <mpinit+0xf0>
80103419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    switch(*p){
80103420:	83 e9 03             	sub    $0x3,%ecx
80103423:	80 f9 01             	cmp    $0x1,%cl
80103426:	76 8e                	jbe    801033b6 <mpinit+0x106>
80103428:	31 ff                	xor    %edi,%edi
8010342a:	e9 71 ff ff ff       	jmp    801033a0 <mpinit+0xf0>
8010342f:	90                   	nop
      ioapicid = ioapic->apicno;
80103430:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
      p += sizeof(struct mpioapic);
80103434:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
80103437:	88 0d 80 17 11 80    	mov    %cl,0x80111780
      continue;
8010343d:	e9 5e ff ff ff       	jmp    801033a0 <mpinit+0xf0>
80103442:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103448:	83 ec 0c             	sub    $0xc,%esp
8010344b:	68 79 74 10 80       	push   $0x80107479
80103450:	e8 2b cf ff ff       	call   80100380 <panic>
80103455:	8d 76 00             	lea    0x0(%esi),%esi
{
80103458:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
8010345d:	eb 0b                	jmp    8010346a <mpinit+0x1ba>
8010345f:	90                   	nop
  for(p = addr; p < e; p += sizeof(struct mp))
80103460:	89 f3                	mov    %esi,%ebx
80103462:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103468:	74 de                	je     80103448 <mpinit+0x198>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010346a:	83 ec 04             	sub    $0x4,%esp
8010346d:	8d 73 10             	lea    0x10(%ebx),%esi
80103470:	6a 04                	push   $0x4
80103472:	68 6f 74 10 80       	push   $0x8010746f
80103477:	53                   	push   %ebx
80103478:	e8 33 13 00 00       	call   801047b0 <memcmp>
8010347d:	83 c4 10             	add    $0x10,%esp
80103480:	85 c0                	test   %eax,%eax
80103482:	75 dc                	jne    80103460 <mpinit+0x1b0>
80103484:	89 da                	mov    %ebx,%edx
80103486:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010348d:	00 
8010348e:	66 90                	xchg   %ax,%ax
    sum += addr[i];
80103490:	0f b6 0a             	movzbl (%edx),%ecx
  for(i=0; i<len; i++)
80103493:	83 c2 01             	add    $0x1,%edx
    sum += addr[i];
80103496:	01 c8                	add    %ecx,%eax
  for(i=0; i<len; i++)
80103498:	39 d6                	cmp    %edx,%esi
8010349a:	75 f4                	jne    80103490 <mpinit+0x1e0>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
8010349c:	84 c0                	test   %al,%al
8010349e:	75 c0                	jne    80103460 <mpinit+0x1b0>
801034a0:	e9 5b fe ff ff       	jmp    80103300 <mpinit+0x50>
    panic("Didn't find a suitable machine");
801034a5:	83 ec 0c             	sub    $0xc,%esp
801034a8:	68 dc 77 10 80       	push   $0x801077dc
801034ad:	e8 ce ce ff ff       	call   80100380 <panic>
801034b2:	66 90                	xchg   %ax,%ax
801034b4:	66 90                	xchg   %ax,%ax
801034b6:	66 90                	xchg   %ax,%ax
801034b8:	66 90                	xchg   %ax,%ax
801034ba:	66 90                	xchg   %ax,%ax
801034bc:	66 90                	xchg   %ax,%ax
801034be:	66 90                	xchg   %ax,%ax

801034c0 <picinit>:
801034c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801034c5:	ba 21 00 00 00       	mov    $0x21,%edx
801034ca:	ee                   	out    %al,(%dx)
801034cb:	ba a1 00 00 00       	mov    $0xa1,%edx
801034d0:	ee                   	out    %al,(%dx)
picinit(void)
{
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
801034d1:	c3                   	ret
801034d2:	66 90                	xchg   %ax,%ax
801034d4:	66 90                	xchg   %ax,%ax
801034d6:	66 90                	xchg   %ax,%ax
801034d8:	66 90                	xchg   %ax,%ax
801034da:	66 90                	xchg   %ax,%ax
801034dc:	66 90                	xchg   %ax,%ax
801034de:	66 90                	xchg   %ax,%ax

801034e0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
801034e0:	55                   	push   %ebp
801034e1:	89 e5                	mov    %esp,%ebp
801034e3:	57                   	push   %edi
801034e4:	56                   	push   %esi
801034e5:	53                   	push   %ebx
801034e6:	83 ec 0c             	sub    $0xc,%esp
801034e9:	8b 75 08             	mov    0x8(%ebp),%esi
801034ec:	8b 7d 0c             	mov    0xc(%ebp),%edi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
801034ef:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
801034f5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
801034fb:	e8 20 da ff ff       	call   80100f20 <filealloc>
80103500:	89 06                	mov    %eax,(%esi)
80103502:	85 c0                	test   %eax,%eax
80103504:	0f 84 a5 00 00 00    	je     801035af <pipealloc+0xcf>
8010350a:	e8 11 da ff ff       	call   80100f20 <filealloc>
8010350f:	89 07                	mov    %eax,(%edi)
80103511:	85 c0                	test   %eax,%eax
80103513:	0f 84 84 00 00 00    	je     8010359d <pipealloc+0xbd>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103519:	e8 12 f2 ff ff       	call   80102730 <kalloc>
8010351e:	89 c3                	mov    %eax,%ebx
80103520:	85 c0                	test   %eax,%eax
80103522:	0f 84 a0 00 00 00    	je     801035c8 <pipealloc+0xe8>
    goto bad;
  p->readopen = 1;
80103528:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
8010352f:	00 00 00 
  p->writeopen = 1;
  p->nwrite = 0;
  p->nread = 0;
  initlock(&p->lock, "pipe");
80103532:	83 ec 08             	sub    $0x8,%esp
  p->writeopen = 1;
80103535:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
8010353c:	00 00 00 
  p->nwrite = 0;
8010353f:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103546:	00 00 00 
  p->nread = 0;
80103549:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103550:	00 00 00 
  initlock(&p->lock, "pipe");
80103553:	68 91 74 10 80       	push   $0x80107491
80103558:	50                   	push   %eax
80103559:	e8 22 0f 00 00       	call   80104480 <initlock>
  (*f0)->type = FD_PIPE;
8010355e:	8b 06                	mov    (%esi),%eax
  (*f0)->pipe = p;
  (*f1)->type = FD_PIPE;
  (*f1)->readable = 0;
  (*f1)->writable = 1;
  (*f1)->pipe = p;
  return 0;
80103560:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103563:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103569:	8b 06                	mov    (%esi),%eax
8010356b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
8010356f:	8b 06                	mov    (%esi),%eax
80103571:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103575:	8b 06                	mov    (%esi),%eax
80103577:	89 58 0c             	mov    %ebx,0xc(%eax)
  (*f1)->type = FD_PIPE;
8010357a:	8b 07                	mov    (%edi),%eax
8010357c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103582:	8b 07                	mov    (%edi),%eax
80103584:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103588:	8b 07                	mov    (%edi),%eax
8010358a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
8010358e:	8b 07                	mov    (%edi),%eax
80103590:	89 58 0c             	mov    %ebx,0xc(%eax)
  return 0;
80103593:	31 c0                	xor    %eax,%eax
  if(*f0)
    fileclose(*f0);
  if(*f1)
    fileclose(*f1);
  return -1;
}
80103595:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103598:	5b                   	pop    %ebx
80103599:	5e                   	pop    %esi
8010359a:	5f                   	pop    %edi
8010359b:	5d                   	pop    %ebp
8010359c:	c3                   	ret
  if(*f0)
8010359d:	8b 06                	mov    (%esi),%eax
8010359f:	85 c0                	test   %eax,%eax
801035a1:	74 1e                	je     801035c1 <pipealloc+0xe1>
    fileclose(*f0);
801035a3:	83 ec 0c             	sub    $0xc,%esp
801035a6:	50                   	push   %eax
801035a7:	e8 34 da ff ff       	call   80100fe0 <fileclose>
801035ac:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801035af:	8b 07                	mov    (%edi),%eax
801035b1:	85 c0                	test   %eax,%eax
801035b3:	74 0c                	je     801035c1 <pipealloc+0xe1>
    fileclose(*f1);
801035b5:	83 ec 0c             	sub    $0xc,%esp
801035b8:	50                   	push   %eax
801035b9:	e8 22 da ff ff       	call   80100fe0 <fileclose>
801035be:	83 c4 10             	add    $0x10,%esp
  return -1;
801035c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801035c6:	eb cd                	jmp    80103595 <pipealloc+0xb5>
  if(*f0)
801035c8:	8b 06                	mov    (%esi),%eax
801035ca:	85 c0                	test   %eax,%eax
801035cc:	75 d5                	jne    801035a3 <pipealloc+0xc3>
801035ce:	eb df                	jmp    801035af <pipealloc+0xcf>

801035d0 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
801035d0:	55                   	push   %ebp
801035d1:	89 e5                	mov    %esp,%ebp
801035d3:	56                   	push   %esi
801035d4:	53                   	push   %ebx
801035d5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801035d8:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
801035db:	83 ec 0c             	sub    $0xc,%esp
801035de:	53                   	push   %ebx
801035df:	e8 8c 10 00 00       	call   80104670 <acquire>
  if(writable){
801035e4:	83 c4 10             	add    $0x10,%esp
801035e7:	85 f6                	test   %esi,%esi
801035e9:	74 65                	je     80103650 <pipeclose+0x80>
    p->writeopen = 0;
    wakeup(&p->nread);
801035eb:	83 ec 0c             	sub    $0xc,%esp
801035ee:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
    p->writeopen = 0;
801035f4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
801035fb:	00 00 00 
    wakeup(&p->nread);
801035fe:	50                   	push   %eax
801035ff:	e8 ac 0b 00 00       	call   801041b0 <wakeup>
80103604:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103607:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
8010360d:	85 d2                	test   %edx,%edx
8010360f:	75 0a                	jne    8010361b <pipeclose+0x4b>
80103611:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103617:	85 c0                	test   %eax,%eax
80103619:	74 15                	je     80103630 <pipeclose+0x60>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
8010361b:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010361e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103621:	5b                   	pop    %ebx
80103622:	5e                   	pop    %esi
80103623:	5d                   	pop    %ebp
    release(&p->lock);
80103624:	e9 e7 0f 00 00       	jmp    80104610 <release>
80103629:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    release(&p->lock);
80103630:	83 ec 0c             	sub    $0xc,%esp
80103633:	53                   	push   %ebx
80103634:	e8 d7 0f 00 00       	call   80104610 <release>
    kfree((char*)p);
80103639:	83 c4 10             	add    $0x10,%esp
8010363c:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
8010363f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103642:	5b                   	pop    %ebx
80103643:	5e                   	pop    %esi
80103644:	5d                   	pop    %ebp
    kfree((char*)p);
80103645:	e9 26 ef ff ff       	jmp    80102570 <kfree>
8010364a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    wakeup(&p->nwrite);
80103650:	83 ec 0c             	sub    $0xc,%esp
80103653:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
    p->readopen = 0;
80103659:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103660:	00 00 00 
    wakeup(&p->nwrite);
80103663:	50                   	push   %eax
80103664:	e8 47 0b 00 00       	call   801041b0 <wakeup>
80103669:	83 c4 10             	add    $0x10,%esp
8010366c:	eb 99                	jmp    80103607 <pipeclose+0x37>
8010366e:	66 90                	xchg   %ax,%ax

80103670 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103670:	55                   	push   %ebp
80103671:	89 e5                	mov    %esp,%ebp
80103673:	57                   	push   %edi
80103674:	56                   	push   %esi
80103675:	53                   	push   %ebx
80103676:	83 ec 28             	sub    $0x28,%esp
80103679:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010367c:	8b 7d 10             	mov    0x10(%ebp),%edi
  int i;

  acquire(&p->lock);
8010367f:	53                   	push   %ebx
80103680:	e8 eb 0f 00 00       	call   80104670 <acquire>
  for(i = 0; i < n; i++){
80103685:	83 c4 10             	add    $0x10,%esp
80103688:	85 ff                	test   %edi,%edi
8010368a:	0f 8e ce 00 00 00    	jle    8010375e <pipewrite+0xee>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103690:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103696:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103699:	89 7d 10             	mov    %edi,0x10(%ebp)
8010369c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010369f:	8d 34 39             	lea    (%ecx,%edi,1),%esi
801036a2:	89 75 e0             	mov    %esi,-0x20(%ebp)
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
801036a5:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801036ab:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801036b1:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801036b7:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
801036bd:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
801036c0:	0f 85 b6 00 00 00    	jne    8010377c <pipewrite+0x10c>
801036c6:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801036c9:	eb 3b                	jmp    80103706 <pipewrite+0x96>
801036cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      if(p->readopen == 0 || myproc()->killed){
801036d0:	e8 5b 03 00 00       	call   80103a30 <myproc>
801036d5:	8b 48 24             	mov    0x24(%eax),%ecx
801036d8:	85 c9                	test   %ecx,%ecx
801036da:	75 34                	jne    80103710 <pipewrite+0xa0>
      wakeup(&p->nread);
801036dc:	83 ec 0c             	sub    $0xc,%esp
801036df:	56                   	push   %esi
801036e0:	e8 cb 0a 00 00       	call   801041b0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
801036e5:	58                   	pop    %eax
801036e6:	5a                   	pop    %edx
801036e7:	53                   	push   %ebx
801036e8:	57                   	push   %edi
801036e9:	e8 02 0a 00 00       	call   801040f0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801036ee:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
801036f4:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
801036fa:	83 c4 10             	add    $0x10,%esp
801036fd:	05 00 02 00 00       	add    $0x200,%eax
80103702:	39 c2                	cmp    %eax,%edx
80103704:	75 2a                	jne    80103730 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
80103706:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010370c:	85 c0                	test   %eax,%eax
8010370e:	75 c0                	jne    801036d0 <pipewrite+0x60>
        release(&p->lock);
80103710:	83 ec 0c             	sub    $0xc,%esp
80103713:	53                   	push   %ebx
80103714:	e8 f7 0e 00 00       	call   80104610 <release>
        return -1;
80103719:	83 c4 10             	add    $0x10,%esp
8010371c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
80103721:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103724:	5b                   	pop    %ebx
80103725:	5e                   	pop    %esi
80103726:	5f                   	pop    %edi
80103727:	5d                   	pop    %ebp
80103728:	c3                   	ret
80103729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103730:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
80103733:	8d 42 01             	lea    0x1(%edx),%eax
80103736:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  for(i = 0; i < n; i++){
8010373c:	83 c1 01             	add    $0x1,%ecx
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010373f:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103745:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103748:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
8010374c:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
80103750:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103753:	39 c1                	cmp    %eax,%ecx
80103755:	0f 85 50 ff ff ff    	jne    801036ab <pipewrite+0x3b>
8010375b:	8b 7d 10             	mov    0x10(%ebp),%edi
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
8010375e:	83 ec 0c             	sub    $0xc,%esp
80103761:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103767:	50                   	push   %eax
80103768:	e8 43 0a 00 00       	call   801041b0 <wakeup>
  release(&p->lock);
8010376d:	89 1c 24             	mov    %ebx,(%esp)
80103770:	e8 9b 0e 00 00       	call   80104610 <release>
  return n;
80103775:	83 c4 10             	add    $0x10,%esp
80103778:	89 f8                	mov    %edi,%eax
8010377a:	eb a5                	jmp    80103721 <pipewrite+0xb1>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
8010377c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010377f:	eb b2                	jmp    80103733 <pipewrite+0xc3>
80103781:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103788:	00 
80103789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103790 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103790:	55                   	push   %ebp
80103791:	89 e5                	mov    %esp,%ebp
80103793:	57                   	push   %edi
80103794:	56                   	push   %esi
80103795:	53                   	push   %ebx
80103796:	83 ec 18             	sub    $0x18,%esp
80103799:	8b 75 08             	mov    0x8(%ebp),%esi
8010379c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010379f:	56                   	push   %esi
801037a0:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
801037a6:	e8 c5 0e 00 00       	call   80104670 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801037ab:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801037b1:	83 c4 10             	add    $0x10,%esp
801037b4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801037ba:	74 2f                	je     801037eb <piperead+0x5b>
801037bc:	eb 37                	jmp    801037f5 <piperead+0x65>
801037be:	66 90                	xchg   %ax,%ax
    if(myproc()->killed){
801037c0:	e8 6b 02 00 00       	call   80103a30 <myproc>
801037c5:	8b 40 24             	mov    0x24(%eax),%eax
801037c8:	85 c0                	test   %eax,%eax
801037ca:	0f 85 80 00 00 00    	jne    80103850 <piperead+0xc0>
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
801037d0:	83 ec 08             	sub    $0x8,%esp
801037d3:	56                   	push   %esi
801037d4:	53                   	push   %ebx
801037d5:	e8 16 09 00 00       	call   801040f0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801037da:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
801037e0:	83 c4 10             	add    $0x10,%esp
801037e3:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
801037e9:	75 0a                	jne    801037f5 <piperead+0x65>
801037eb:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
801037f1:	85 d2                	test   %edx,%edx
801037f3:	75 cb                	jne    801037c0 <piperead+0x30>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801037f5:	8b 4d 10             	mov    0x10(%ebp),%ecx
801037f8:	31 db                	xor    %ebx,%ebx
801037fa:	85 c9                	test   %ecx,%ecx
801037fc:	7f 26                	jg     80103824 <piperead+0x94>
801037fe:	eb 2c                	jmp    8010382c <piperead+0x9c>
    if(p->nread == p->nwrite)
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
80103800:	8d 48 01             	lea    0x1(%eax),%ecx
80103803:	25 ff 01 00 00       	and    $0x1ff,%eax
80103808:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
8010380e:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103813:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
80103816:	83 c3 01             	add    $0x1,%ebx
80103819:	39 5d 10             	cmp    %ebx,0x10(%ebp)
8010381c:	74 0e                	je     8010382c <piperead+0x9c>
8010381e:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
    if(p->nread == p->nwrite)
80103824:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
8010382a:	75 d4                	jne    80103800 <piperead+0x70>
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
8010382c:	83 ec 0c             	sub    $0xc,%esp
8010382f:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103835:	50                   	push   %eax
80103836:	e8 75 09 00 00       	call   801041b0 <wakeup>
  release(&p->lock);
8010383b:	89 34 24             	mov    %esi,(%esp)
8010383e:	e8 cd 0d 00 00       	call   80104610 <release>
  return i;
80103843:	83 c4 10             	add    $0x10,%esp
}
80103846:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103849:	89 d8                	mov    %ebx,%eax
8010384b:	5b                   	pop    %ebx
8010384c:	5e                   	pop    %esi
8010384d:	5f                   	pop    %edi
8010384e:	5d                   	pop    %ebp
8010384f:	c3                   	ret
      release(&p->lock);
80103850:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103853:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
80103858:	56                   	push   %esi
80103859:	e8 b2 0d 00 00       	call   80104610 <release>
      return -1;
8010385e:	83 c4 10             	add    $0x10,%esp
}
80103861:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103864:	89 d8                	mov    %ebx,%eax
80103866:	5b                   	pop    %ebx
80103867:	5e                   	pop    %esi
80103868:	5f                   	pop    %edi
80103869:	5d                   	pop    %ebp
8010386a:	c3                   	ret
8010386b:	66 90                	xchg   %ax,%ax
8010386d:	66 90                	xchg   %ax,%ax
8010386f:	90                   	nop

80103870 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103870:	55                   	push   %ebp
80103871:	89 e5                	mov    %esp,%ebp
80103873:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103874:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
{
80103879:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010387c:	68 20 1d 11 80       	push   $0x80111d20
80103881:	e8 ea 0d 00 00       	call   80104670 <acquire>
80103886:	83 c4 10             	add    $0x10,%esp
80103889:	eb 10                	jmp    8010389b <allocproc+0x2b>
8010388b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103890:	83 c3 7c             	add    $0x7c,%ebx
80103893:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80103899:	74 75                	je     80103910 <allocproc+0xa0>
    if(p->state == UNUSED)
8010389b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010389e:	85 c0                	test   %eax,%eax
801038a0:	75 ee                	jne    80103890 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
801038a2:	a1 04 a0 10 80       	mov    0x8010a004,%eax

  release(&ptable.lock);
801038a7:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
801038aa:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
801038b1:	89 43 10             	mov    %eax,0x10(%ebx)
801038b4:	8d 50 01             	lea    0x1(%eax),%edx
  release(&ptable.lock);
801038b7:	68 20 1d 11 80       	push   $0x80111d20
  p->pid = nextpid++;
801038bc:	89 15 04 a0 10 80    	mov    %edx,0x8010a004
  release(&ptable.lock);
801038c2:	e8 49 0d 00 00       	call   80104610 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
801038c7:	e8 64 ee ff ff       	call   80102730 <kalloc>
801038cc:	83 c4 10             	add    $0x10,%esp
801038cf:	89 43 08             	mov    %eax,0x8(%ebx)
801038d2:	85 c0                	test   %eax,%eax
801038d4:	74 53                	je     80103929 <allocproc+0xb9>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801038d6:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
801038dc:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
801038df:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
801038e4:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
801038e7:	c7 40 14 22 59 10 80 	movl   $0x80105922,0x14(%eax)
  p->context = (struct context*)sp;
801038ee:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801038f1:	6a 14                	push   $0x14
801038f3:	6a 00                	push   $0x0
801038f5:	50                   	push   %eax
801038f6:	e8 75 0e 00 00       	call   80104770 <memset>
  p->context->eip = (uint)forkret;
801038fb:	8b 43 1c             	mov    0x1c(%ebx),%eax

  return p;
801038fe:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80103901:	c7 40 10 40 39 10 80 	movl   $0x80103940,0x10(%eax)
}
80103908:	89 d8                	mov    %ebx,%eax
8010390a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010390d:	c9                   	leave
8010390e:	c3                   	ret
8010390f:	90                   	nop
  release(&ptable.lock);
80103910:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103913:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103915:	68 20 1d 11 80       	push   $0x80111d20
8010391a:	e8 f1 0c 00 00       	call   80104610 <release>
  return 0;
8010391f:	83 c4 10             	add    $0x10,%esp
}
80103922:	89 d8                	mov    %ebx,%eax
80103924:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103927:	c9                   	leave
80103928:	c3                   	ret
    p->state = UNUSED;
80103929:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  return 0;
80103930:	31 db                	xor    %ebx,%ebx
80103932:	eb ee                	jmp    80103922 <allocproc+0xb2>
80103934:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010393b:	00 
8010393c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103940 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103940:	55                   	push   %ebp
80103941:	89 e5                	mov    %esp,%ebp
80103943:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103946:	68 20 1d 11 80       	push   $0x80111d20
8010394b:	e8 c0 0c 00 00       	call   80104610 <release>

  if (first) {
80103950:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80103955:	83 c4 10             	add    $0x10,%esp
80103958:	85 c0                	test   %eax,%eax
8010395a:	75 04                	jne    80103960 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010395c:	c9                   	leave
8010395d:	c3                   	ret
8010395e:	66 90                	xchg   %ax,%ax
    first = 0;
80103960:	c7 05 00 a0 10 80 00 	movl   $0x0,0x8010a000
80103967:	00 00 00 
    iinit(ROOTDEV);
8010396a:	83 ec 0c             	sub    $0xc,%esp
8010396d:	6a 01                	push   $0x1
8010396f:	e8 dc dc ff ff       	call   80101650 <iinit>
    initlog(ROOTDEV);
80103974:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010397b:	e8 f0 f3 ff ff       	call   80102d70 <initlog>
}
80103980:	83 c4 10             	add    $0x10,%esp
80103983:	c9                   	leave
80103984:	c3                   	ret
80103985:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010398c:	00 
8010398d:	8d 76 00             	lea    0x0(%esi),%esi

80103990 <pinit>:
{
80103990:	55                   	push   %ebp
80103991:	89 e5                	mov    %esp,%ebp
80103993:	83 ec 10             	sub    $0x10,%esp
  initlock(&ptable.lock, "ptable");
80103996:	68 96 74 10 80       	push   $0x80107496
8010399b:	68 20 1d 11 80       	push   $0x80111d20
801039a0:	e8 db 0a 00 00       	call   80104480 <initlock>
}
801039a5:	83 c4 10             	add    $0x10,%esp
801039a8:	c9                   	leave
801039a9:	c3                   	ret
801039aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801039b0 <mycpu>:
{
801039b0:	55                   	push   %ebp
801039b1:	89 e5                	mov    %esp,%ebp
801039b3:	56                   	push   %esi
801039b4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801039b5:	9c                   	pushf
801039b6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801039b7:	f6 c4 02             	test   $0x2,%ah
801039ba:	75 46                	jne    80103a02 <mycpu+0x52>
  apicid = lapicid();
801039bc:	e8 df ef ff ff       	call   801029a0 <lapicid>
  for (i = 0; i < ncpu; ++i) {
801039c1:	8b 35 84 17 11 80    	mov    0x80111784,%esi
801039c7:	85 f6                	test   %esi,%esi
801039c9:	7e 2a                	jle    801039f5 <mycpu+0x45>
801039cb:	31 d2                	xor    %edx,%edx
801039cd:	eb 08                	jmp    801039d7 <mycpu+0x27>
801039cf:	90                   	nop
801039d0:	83 c2 01             	add    $0x1,%edx
801039d3:	39 f2                	cmp    %esi,%edx
801039d5:	74 1e                	je     801039f5 <mycpu+0x45>
    if (cpus[i].apicid == apicid)
801039d7:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
801039dd:	0f b6 99 a0 17 11 80 	movzbl -0x7feee860(%ecx),%ebx
801039e4:	39 c3                	cmp    %eax,%ebx
801039e6:	75 e8                	jne    801039d0 <mycpu+0x20>
}
801039e8:	8d 65 f8             	lea    -0x8(%ebp),%esp
      return &cpus[i];
801039eb:	8d 81 a0 17 11 80    	lea    -0x7feee860(%ecx),%eax
}
801039f1:	5b                   	pop    %ebx
801039f2:	5e                   	pop    %esi
801039f3:	5d                   	pop    %ebp
801039f4:	c3                   	ret
  panic("unknown apicid\n");
801039f5:	83 ec 0c             	sub    $0xc,%esp
801039f8:	68 9d 74 10 80       	push   $0x8010749d
801039fd:	e8 7e c9 ff ff       	call   80100380 <panic>
    panic("mycpu called with interrupts enabled\n");
80103a02:	83 ec 0c             	sub    $0xc,%esp
80103a05:	68 fc 77 10 80       	push   $0x801077fc
80103a0a:	e8 71 c9 ff ff       	call   80100380 <panic>
80103a0f:	90                   	nop

80103a10 <cpuid>:
cpuid() {
80103a10:	55                   	push   %ebp
80103a11:	89 e5                	mov    %esp,%ebp
80103a13:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103a16:	e8 95 ff ff ff       	call   801039b0 <mycpu>
}
80103a1b:	c9                   	leave
  return mycpu()-cpus;
80103a1c:	2d a0 17 11 80       	sub    $0x801117a0,%eax
80103a21:	c1 f8 04             	sar    $0x4,%eax
80103a24:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
80103a2a:	c3                   	ret
80103a2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103a30 <myproc>:
myproc(void) {
80103a30:	55                   	push   %ebp
80103a31:	89 e5                	mov    %esp,%ebp
80103a33:	53                   	push   %ebx
80103a34:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103a37:	e8 e4 0a 00 00       	call   80104520 <pushcli>
  c = mycpu();
80103a3c:	e8 6f ff ff ff       	call   801039b0 <mycpu>
  p = c->proc;
80103a41:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103a47:	e8 24 0b 00 00       	call   80104570 <popcli>
}
80103a4c:	89 d8                	mov    %ebx,%eax
80103a4e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a51:	c9                   	leave
80103a52:	c3                   	ret
80103a53:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103a5a:	00 
80103a5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103a60 <userinit>:
{
80103a60:	55                   	push   %ebp
80103a61:	89 e5                	mov    %esp,%ebp
80103a63:	53                   	push   %ebx
80103a64:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103a67:	e8 04 fe ff ff       	call   80103870 <allocproc>
80103a6c:	89 c3                	mov    %eax,%ebx
  initproc = p;
80103a6e:	a3 54 3c 11 80       	mov    %eax,0x80113c54
  if((p->pgdir = setupkvm()) == 0)
80103a73:	e8 78 34 00 00       	call   80106ef0 <setupkvm>
80103a78:	89 43 04             	mov    %eax,0x4(%ebx)
80103a7b:	85 c0                	test   %eax,%eax
80103a7d:	0f 84 bd 00 00 00    	je     80103b40 <userinit+0xe0>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
80103a83:	83 ec 04             	sub    $0x4,%esp
80103a86:	68 2c 00 00 00       	push   $0x2c
80103a8b:	68 60 a4 10 80       	push   $0x8010a460
80103a90:	50                   	push   %eax
80103a91:	e8 3a 31 00 00       	call   80106bd0 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
80103a96:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
80103a99:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
80103a9f:	6a 4c                	push   $0x4c
80103aa1:	6a 00                	push   $0x0
80103aa3:	ff 73 18             	push   0x18(%ebx)
80103aa6:	e8 c5 0c 00 00       	call   80104770 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103aab:	8b 43 18             	mov    0x18(%ebx),%eax
80103aae:	ba 1b 00 00 00       	mov    $0x1b,%edx
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103ab3:	83 c4 0c             	add    $0xc,%esp
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103ab6:	b9 23 00 00 00       	mov    $0x23,%ecx
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
80103abb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
80103abf:	8b 43 18             	mov    0x18(%ebx),%eax
80103ac2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
80103ac6:	8b 43 18             	mov    0x18(%ebx),%eax
80103ac9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103acd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103ad1:	8b 43 18             	mov    0x18(%ebx),%eax
80103ad4:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103ad8:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103adc:	8b 43 18             	mov    0x18(%ebx),%eax
80103adf:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103ae6:	8b 43 18             	mov    0x18(%ebx),%eax
80103ae9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103af0:	8b 43 18             	mov    0x18(%ebx),%eax
80103af3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103afa:	8d 43 6c             	lea    0x6c(%ebx),%eax
80103afd:	6a 10                	push   $0x10
80103aff:	68 c6 74 10 80       	push   $0x801074c6
80103b04:	50                   	push   %eax
80103b05:	e8 16 0e 00 00       	call   80104920 <safestrcpy>
  p->cwd = namei("/");
80103b0a:	c7 04 24 cf 74 10 80 	movl   $0x801074cf,(%esp)
80103b11:	e8 3a e6 ff ff       	call   80102150 <namei>
80103b16:	89 43 68             	mov    %eax,0x68(%ebx)
  acquire(&ptable.lock);
80103b19:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103b20:	e8 4b 0b 00 00       	call   80104670 <acquire>
  p->state = RUNNABLE;
80103b25:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103b2c:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103b33:	e8 d8 0a 00 00       	call   80104610 <release>
}
80103b38:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103b3b:	83 c4 10             	add    $0x10,%esp
80103b3e:	c9                   	leave
80103b3f:	c3                   	ret
    panic("userinit: out of memory?");
80103b40:	83 ec 0c             	sub    $0xc,%esp
80103b43:	68 ad 74 10 80       	push   $0x801074ad
80103b48:	e8 33 c8 ff ff       	call   80100380 <panic>
80103b4d:	8d 76 00             	lea    0x0(%esi),%esi

80103b50 <growproc>:
{
80103b50:	55                   	push   %ebp
80103b51:	89 e5                	mov    %esp,%ebp
80103b53:	56                   	push   %esi
80103b54:	53                   	push   %ebx
80103b55:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103b58:	e8 c3 09 00 00       	call   80104520 <pushcli>
  c = mycpu();
80103b5d:	e8 4e fe ff ff       	call   801039b0 <mycpu>
  p = c->proc;
80103b62:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b68:	e8 03 0a 00 00       	call   80104570 <popcli>
  sz = curproc->sz;
80103b6d:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103b6f:	85 f6                	test   %esi,%esi
80103b71:	7f 1d                	jg     80103b90 <growproc+0x40>
  } else if(n < 0){
80103b73:	75 3b                	jne    80103bb0 <growproc+0x60>
  switchuvm(curproc);
80103b75:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103b78:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103b7a:	53                   	push   %ebx
80103b7b:	e8 40 2f 00 00       	call   80106ac0 <switchuvm>
  return 0;
80103b80:	83 c4 10             	add    $0x10,%esp
80103b83:	31 c0                	xor    %eax,%eax
}
80103b85:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103b88:	5b                   	pop    %ebx
80103b89:	5e                   	pop    %esi
80103b8a:	5d                   	pop    %ebp
80103b8b:	c3                   	ret
80103b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103b90:	83 ec 04             	sub    $0x4,%esp
80103b93:	01 c6                	add    %eax,%esi
80103b95:	56                   	push   %esi
80103b96:	50                   	push   %eax
80103b97:	ff 73 04             	push   0x4(%ebx)
80103b9a:	e8 81 31 00 00       	call   80106d20 <allocuvm>
80103b9f:	83 c4 10             	add    $0x10,%esp
80103ba2:	85 c0                	test   %eax,%eax
80103ba4:	75 cf                	jne    80103b75 <growproc+0x25>
      return -1;
80103ba6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103bab:	eb d8                	jmp    80103b85 <growproc+0x35>
80103bad:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103bb0:	83 ec 04             	sub    $0x4,%esp
80103bb3:	01 c6                	add    %eax,%esi
80103bb5:	56                   	push   %esi
80103bb6:	50                   	push   %eax
80103bb7:	ff 73 04             	push   0x4(%ebx)
80103bba:	e8 81 32 00 00       	call   80106e40 <deallocuvm>
80103bbf:	83 c4 10             	add    $0x10,%esp
80103bc2:	85 c0                	test   %eax,%eax
80103bc4:	75 af                	jne    80103b75 <growproc+0x25>
80103bc6:	eb de                	jmp    80103ba6 <growproc+0x56>
80103bc8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103bcf:	00 

80103bd0 <fork>:
{
80103bd0:	55                   	push   %ebp
80103bd1:	89 e5                	mov    %esp,%ebp
80103bd3:	57                   	push   %edi
80103bd4:	56                   	push   %esi
80103bd5:	53                   	push   %ebx
80103bd6:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103bd9:	e8 42 09 00 00       	call   80104520 <pushcli>
  c = mycpu();
80103bde:	e8 cd fd ff ff       	call   801039b0 <mycpu>
  p = c->proc;
80103be3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103be9:	e8 82 09 00 00       	call   80104570 <popcli>
  if((np = allocproc()) == 0){
80103bee:	e8 7d fc ff ff       	call   80103870 <allocproc>
80103bf3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103bf6:	85 c0                	test   %eax,%eax
80103bf8:	0f 84 d6 00 00 00    	je     80103cd4 <fork+0x104>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103bfe:	83 ec 08             	sub    $0x8,%esp
80103c01:	ff 33                	push   (%ebx)
80103c03:	89 c7                	mov    %eax,%edi
80103c05:	ff 73 04             	push   0x4(%ebx)
80103c08:	e8 d3 33 00 00       	call   80106fe0 <copyuvm>
80103c0d:	83 c4 10             	add    $0x10,%esp
80103c10:	89 47 04             	mov    %eax,0x4(%edi)
80103c13:	85 c0                	test   %eax,%eax
80103c15:	0f 84 9a 00 00 00    	je     80103cb5 <fork+0xe5>
  np->sz = curproc->sz;
80103c1b:	8b 03                	mov    (%ebx),%eax
80103c1d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103c20:	89 01                	mov    %eax,(%ecx)
  *np->tf = *curproc->tf;
80103c22:	8b 79 18             	mov    0x18(%ecx),%edi
  np->parent = curproc;
80103c25:	89 c8                	mov    %ecx,%eax
80103c27:	89 59 14             	mov    %ebx,0x14(%ecx)
  *np->tf = *curproc->tf;
80103c2a:	b9 13 00 00 00       	mov    $0x13,%ecx
80103c2f:	8b 73 18             	mov    0x18(%ebx),%esi
80103c32:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103c34:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103c36:	8b 40 18             	mov    0x18(%eax),%eax
80103c39:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103c40:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103c44:	85 c0                	test   %eax,%eax
80103c46:	74 13                	je     80103c5b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103c48:	83 ec 0c             	sub    $0xc,%esp
80103c4b:	50                   	push   %eax
80103c4c:	e8 3f d3 ff ff       	call   80100f90 <filedup>
80103c51:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103c54:	83 c4 10             	add    $0x10,%esp
80103c57:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103c5b:	83 c6 01             	add    $0x1,%esi
80103c5e:	83 fe 10             	cmp    $0x10,%esi
80103c61:	75 dd                	jne    80103c40 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103c63:	83 ec 0c             	sub    $0xc,%esp
80103c66:	ff 73 68             	push   0x68(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c69:	83 c3 6c             	add    $0x6c,%ebx
  np->cwd = idup(curproc->cwd);
80103c6c:	e8 cf db ff ff       	call   80101840 <idup>
80103c71:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c74:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103c77:	89 47 68             	mov    %eax,0x68(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103c7a:	8d 47 6c             	lea    0x6c(%edi),%eax
80103c7d:	6a 10                	push   $0x10
80103c7f:	53                   	push   %ebx
80103c80:	50                   	push   %eax
80103c81:	e8 9a 0c 00 00       	call   80104920 <safestrcpy>
  pid = np->pid;
80103c86:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103c89:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103c90:	e8 db 09 00 00       	call   80104670 <acquire>
  np->state = RUNNABLE;
80103c95:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103c9c:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103ca3:	e8 68 09 00 00       	call   80104610 <release>
  return pid;
80103ca8:	83 c4 10             	add    $0x10,%esp
}
80103cab:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103cae:	89 d8                	mov    %ebx,%eax
80103cb0:	5b                   	pop    %ebx
80103cb1:	5e                   	pop    %esi
80103cb2:	5f                   	pop    %edi
80103cb3:	5d                   	pop    %ebp
80103cb4:	c3                   	ret
    kfree(np->kstack);
80103cb5:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103cb8:	83 ec 0c             	sub    $0xc,%esp
80103cbb:	ff 73 08             	push   0x8(%ebx)
80103cbe:	e8 ad e8 ff ff       	call   80102570 <kfree>
    np->kstack = 0;
80103cc3:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
    return -1;
80103cca:	83 c4 10             	add    $0x10,%esp
    np->state = UNUSED;
80103ccd:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return -1;
80103cd4:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103cd9:	eb d0                	jmp    80103cab <fork+0xdb>
80103cdb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103ce0 <scheduler>:
{
80103ce0:	55                   	push   %ebp
80103ce1:	89 e5                	mov    %esp,%ebp
80103ce3:	57                   	push   %edi
80103ce4:	56                   	push   %esi
80103ce5:	53                   	push   %ebx
80103ce6:	83 ec 0c             	sub    $0xc,%esp
  struct cpu *c = mycpu();
80103ce9:	e8 c2 fc ff ff       	call   801039b0 <mycpu>
  c->proc = 0;
80103cee:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103cf5:	00 00 00 
  struct cpu *c = mycpu();
80103cf8:	89 c6                	mov    %eax,%esi
  c->proc = 0;
80103cfa:	8d 78 04             	lea    0x4(%eax),%edi
80103cfd:	8d 76 00             	lea    0x0(%esi),%esi
  asm volatile("sti");
80103d00:	fb                   	sti
    acquire(&ptable.lock);
80103d01:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d04:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
    acquire(&ptable.lock);
80103d09:	68 20 1d 11 80       	push   $0x80111d20
80103d0e:	e8 5d 09 00 00       	call   80104670 <acquire>
80103d13:	83 c4 10             	add    $0x10,%esp
80103d16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103d1d:	00 
80103d1e:	66 90                	xchg   %ax,%ax
      if(p->state != RUNNABLE)
80103d20:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
80103d24:	75 33                	jne    80103d59 <scheduler+0x79>
      switchuvm(p);
80103d26:	83 ec 0c             	sub    $0xc,%esp
      c->proc = p;
80103d29:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
      switchuvm(p);
80103d2f:	53                   	push   %ebx
80103d30:	e8 8b 2d 00 00       	call   80106ac0 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103d35:	58                   	pop    %eax
80103d36:	5a                   	pop    %edx
80103d37:	ff 73 1c             	push   0x1c(%ebx)
80103d3a:	57                   	push   %edi
      p->state = RUNNING;
80103d3b:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
      swtch(&(c->scheduler), p->context);
80103d42:	e8 34 0c 00 00       	call   8010497b <swtch>
      switchkvm();
80103d47:	e8 64 2d 00 00       	call   80106ab0 <switchkvm>
      c->proc = 0;
80103d4c:	83 c4 10             	add    $0x10,%esp
80103d4f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80103d56:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d59:	83 c3 7c             	add    $0x7c,%ebx
80103d5c:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80103d62:	75 bc                	jne    80103d20 <scheduler+0x40>
    release(&ptable.lock);
80103d64:	83 ec 0c             	sub    $0xc,%esp
80103d67:	68 20 1d 11 80       	push   $0x80111d20
80103d6c:	e8 9f 08 00 00       	call   80104610 <release>
    sti();
80103d71:	83 c4 10             	add    $0x10,%esp
80103d74:	eb 8a                	jmp    80103d00 <scheduler+0x20>
80103d76:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103d7d:	00 
80103d7e:	66 90                	xchg   %ax,%ax

80103d80 <sched>:
{
80103d80:	55                   	push   %ebp
80103d81:	89 e5                	mov    %esp,%ebp
80103d83:	56                   	push   %esi
80103d84:	53                   	push   %ebx
  pushcli();
80103d85:	e8 96 07 00 00       	call   80104520 <pushcli>
  c = mycpu();
80103d8a:	e8 21 fc ff ff       	call   801039b0 <mycpu>
  p = c->proc;
80103d8f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103d95:	e8 d6 07 00 00       	call   80104570 <popcli>
  if(!holding(&ptable.lock))
80103d9a:	83 ec 0c             	sub    $0xc,%esp
80103d9d:	68 20 1d 11 80       	push   $0x80111d20
80103da2:	e8 29 08 00 00       	call   801045d0 <holding>
80103da7:	83 c4 10             	add    $0x10,%esp
80103daa:	85 c0                	test   %eax,%eax
80103dac:	74 4f                	je     80103dfd <sched+0x7d>
  if(mycpu()->ncli != 1)
80103dae:	e8 fd fb ff ff       	call   801039b0 <mycpu>
80103db3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103dba:	75 68                	jne    80103e24 <sched+0xa4>
  if(p->state == RUNNING)
80103dbc:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103dc0:	74 55                	je     80103e17 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103dc2:	9c                   	pushf
80103dc3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103dc4:	f6 c4 02             	test   $0x2,%ah
80103dc7:	75 41                	jne    80103e0a <sched+0x8a>
  intena = mycpu()->intena;
80103dc9:	e8 e2 fb ff ff       	call   801039b0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103dce:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103dd1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103dd7:	e8 d4 fb ff ff       	call   801039b0 <mycpu>
80103ddc:	83 ec 08             	sub    $0x8,%esp
80103ddf:	ff 70 04             	push   0x4(%eax)
80103de2:	53                   	push   %ebx
80103de3:	e8 93 0b 00 00       	call   8010497b <swtch>
  mycpu()->intena = intena;
80103de8:	e8 c3 fb ff ff       	call   801039b0 <mycpu>
}
80103ded:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103df0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103df6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103df9:	5b                   	pop    %ebx
80103dfa:	5e                   	pop    %esi
80103dfb:	5d                   	pop    %ebp
80103dfc:	c3                   	ret
    panic("sched ptable.lock");
80103dfd:	83 ec 0c             	sub    $0xc,%esp
80103e00:	68 d1 74 10 80       	push   $0x801074d1
80103e05:	e8 76 c5 ff ff       	call   80100380 <panic>
    panic("sched interruptible");
80103e0a:	83 ec 0c             	sub    $0xc,%esp
80103e0d:	68 fd 74 10 80       	push   $0x801074fd
80103e12:	e8 69 c5 ff ff       	call   80100380 <panic>
    panic("sched running");
80103e17:	83 ec 0c             	sub    $0xc,%esp
80103e1a:	68 ef 74 10 80       	push   $0x801074ef
80103e1f:	e8 5c c5 ff ff       	call   80100380 <panic>
    panic("sched locks");
80103e24:	83 ec 0c             	sub    $0xc,%esp
80103e27:	68 e3 74 10 80       	push   $0x801074e3
80103e2c:	e8 4f c5 ff ff       	call   80100380 <panic>
80103e31:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103e38:	00 
80103e39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103e40 <exit>:
{
80103e40:	55                   	push   %ebp
80103e41:	89 e5                	mov    %esp,%ebp
80103e43:	57                   	push   %edi
80103e44:	56                   	push   %esi
80103e45:	53                   	push   %ebx
80103e46:	83 ec 0c             	sub    $0xc,%esp
  struct proc *curproc = myproc();
80103e49:	e8 e2 fb ff ff       	call   80103a30 <myproc>
  if(curproc == initproc)
80103e4e:	39 05 54 3c 11 80    	cmp    %eax,0x80113c54
80103e54:	0f 84 fd 00 00 00    	je     80103f57 <exit+0x117>
80103e5a:	89 c3                	mov    %eax,%ebx
80103e5c:	8d 70 28             	lea    0x28(%eax),%esi
80103e5f:	8d 78 68             	lea    0x68(%eax),%edi
80103e62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(curproc->ofile[fd]){
80103e68:	8b 06                	mov    (%esi),%eax
80103e6a:	85 c0                	test   %eax,%eax
80103e6c:	74 12                	je     80103e80 <exit+0x40>
      fileclose(curproc->ofile[fd]);
80103e6e:	83 ec 0c             	sub    $0xc,%esp
80103e71:	50                   	push   %eax
80103e72:	e8 69 d1 ff ff       	call   80100fe0 <fileclose>
      curproc->ofile[fd] = 0;
80103e77:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103e7d:	83 c4 10             	add    $0x10,%esp
  for(fd = 0; fd < NOFILE; fd++){
80103e80:	83 c6 04             	add    $0x4,%esi
80103e83:	39 f7                	cmp    %esi,%edi
80103e85:	75 e1                	jne    80103e68 <exit+0x28>
  begin_op();
80103e87:	e8 84 ef ff ff       	call   80102e10 <begin_op>
  iput(curproc->cwd);
80103e8c:	83 ec 0c             	sub    $0xc,%esp
80103e8f:	ff 73 68             	push   0x68(%ebx)
80103e92:	e8 09 db ff ff       	call   801019a0 <iput>
  end_op();
80103e97:	e8 e4 ef ff ff       	call   80102e80 <end_op>
  curproc->cwd = 0;
80103e9c:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
  acquire(&ptable.lock);
80103ea3:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80103eaa:	e8 c1 07 00 00       	call   80104670 <acquire>
  wakeup1(curproc->parent);
80103eaf:	8b 53 14             	mov    0x14(%ebx),%edx
80103eb2:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103eb5:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
80103eba:	eb 0e                	jmp    80103eca <exit+0x8a>
80103ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103ec0:	83 c0 7c             	add    $0x7c,%eax
80103ec3:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103ec8:	74 1c                	je     80103ee6 <exit+0xa6>
    if(p->state == SLEEPING && p->chan == chan)
80103eca:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103ece:	75 f0                	jne    80103ec0 <exit+0x80>
80103ed0:	3b 50 20             	cmp    0x20(%eax),%edx
80103ed3:	75 eb                	jne    80103ec0 <exit+0x80>
      p->state = RUNNABLE;
80103ed5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103edc:	83 c0 7c             	add    $0x7c,%eax
80103edf:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103ee4:	75 e4                	jne    80103eca <exit+0x8a>
      p->parent = initproc;
80103ee6:	8b 0d 54 3c 11 80    	mov    0x80113c54,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103eec:	ba 54 1d 11 80       	mov    $0x80111d54,%edx
80103ef1:	eb 10                	jmp    80103f03 <exit+0xc3>
80103ef3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103ef8:	83 c2 7c             	add    $0x7c,%edx
80103efb:	81 fa 54 3c 11 80    	cmp    $0x80113c54,%edx
80103f01:	74 3b                	je     80103f3e <exit+0xfe>
    if(p->parent == curproc){
80103f03:	39 5a 14             	cmp    %ebx,0x14(%edx)
80103f06:	75 f0                	jne    80103ef8 <exit+0xb8>
      if(p->state == ZOMBIE)
80103f08:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103f0c:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103f0f:	75 e7                	jne    80103ef8 <exit+0xb8>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f11:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
80103f16:	eb 12                	jmp    80103f2a <exit+0xea>
80103f18:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f1f:	00 
80103f20:	83 c0 7c             	add    $0x7c,%eax
80103f23:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80103f28:	74 ce                	je     80103ef8 <exit+0xb8>
    if(p->state == SLEEPING && p->chan == chan)
80103f2a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f2e:	75 f0                	jne    80103f20 <exit+0xe0>
80103f30:	3b 48 20             	cmp    0x20(%eax),%ecx
80103f33:	75 eb                	jne    80103f20 <exit+0xe0>
      p->state = RUNNABLE;
80103f35:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103f3c:	eb e2                	jmp    80103f20 <exit+0xe0>
  curproc->state = ZOMBIE;
80103f3e:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
  sched();
80103f45:	e8 36 fe ff ff       	call   80103d80 <sched>
  panic("zombie exit");
80103f4a:	83 ec 0c             	sub    $0xc,%esp
80103f4d:	68 1e 75 10 80       	push   $0x8010751e
80103f52:	e8 29 c4 ff ff       	call   80100380 <panic>
    panic("init exiting");
80103f57:	83 ec 0c             	sub    $0xc,%esp
80103f5a:	68 11 75 10 80       	push   $0x80107511
80103f5f:	e8 1c c4 ff ff       	call   80100380 <panic>
80103f64:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f6b:	00 
80103f6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103f70 <wait>:
{
80103f70:	55                   	push   %ebp
80103f71:	89 e5                	mov    %esp,%ebp
80103f73:	56                   	push   %esi
80103f74:	53                   	push   %ebx
  pushcli();
80103f75:	e8 a6 05 00 00       	call   80104520 <pushcli>
  c = mycpu();
80103f7a:	e8 31 fa ff ff       	call   801039b0 <mycpu>
  p = c->proc;
80103f7f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103f85:	e8 e6 05 00 00       	call   80104570 <popcli>
  acquire(&ptable.lock);
80103f8a:	83 ec 0c             	sub    $0xc,%esp
80103f8d:	68 20 1d 11 80       	push   $0x80111d20
80103f92:	e8 d9 06 00 00       	call   80104670 <acquire>
80103f97:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80103f9a:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f9c:	bb 54 1d 11 80       	mov    $0x80111d54,%ebx
80103fa1:	eb 10                	jmp    80103fb3 <wait+0x43>
80103fa3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103fa8:	83 c3 7c             	add    $0x7c,%ebx
80103fab:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80103fb1:	74 1b                	je     80103fce <wait+0x5e>
      if(p->parent != curproc)
80103fb3:	39 73 14             	cmp    %esi,0x14(%ebx)
80103fb6:	75 f0                	jne    80103fa8 <wait+0x38>
      if(p->state == ZOMBIE){
80103fb8:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
80103fbc:	74 62                	je     80104020 <wait+0xb0>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fbe:	83 c3 7c             	add    $0x7c,%ebx
      havekids = 1;
80103fc1:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103fc6:	81 fb 54 3c 11 80    	cmp    $0x80113c54,%ebx
80103fcc:	75 e5                	jne    80103fb3 <wait+0x43>
    if(!havekids || curproc->killed){
80103fce:	85 c0                	test   %eax,%eax
80103fd0:	0f 84 a0 00 00 00    	je     80104076 <wait+0x106>
80103fd6:	8b 46 24             	mov    0x24(%esi),%eax
80103fd9:	85 c0                	test   %eax,%eax
80103fdb:	0f 85 95 00 00 00    	jne    80104076 <wait+0x106>
  pushcli();
80103fe1:	e8 3a 05 00 00       	call   80104520 <pushcli>
  c = mycpu();
80103fe6:	e8 c5 f9 ff ff       	call   801039b0 <mycpu>
  p = c->proc;
80103feb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103ff1:	e8 7a 05 00 00       	call   80104570 <popcli>
  if(p == 0)
80103ff6:	85 db                	test   %ebx,%ebx
80103ff8:	0f 84 8f 00 00 00    	je     8010408d <wait+0x11d>
  p->chan = chan;
80103ffe:	89 73 20             	mov    %esi,0x20(%ebx)
  p->state = SLEEPING;
80104001:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104008:	e8 73 fd ff ff       	call   80103d80 <sched>
  p->chan = 0;
8010400d:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
80104014:	eb 84                	jmp    80103f9a <wait+0x2a>
80104016:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010401d:	00 
8010401e:	66 90                	xchg   %ax,%ax
        kfree(p->kstack);
80104020:	83 ec 0c             	sub    $0xc,%esp
        pid = p->pid;
80104023:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104026:	ff 73 08             	push   0x8(%ebx)
80104029:	e8 42 e5 ff ff       	call   80102570 <kfree>
        p->kstack = 0;
8010402e:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104035:	5a                   	pop    %edx
80104036:	ff 73 04             	push   0x4(%ebx)
80104039:	e8 32 2e 00 00       	call   80106e70 <freevm>
        p->pid = 0;
8010403e:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104045:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010404c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
        p->killed = 0;
80104050:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104057:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
8010405e:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
80104065:	e8 a6 05 00 00       	call   80104610 <release>
        return pid;
8010406a:	83 c4 10             	add    $0x10,%esp
}
8010406d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104070:	89 f0                	mov    %esi,%eax
80104072:	5b                   	pop    %ebx
80104073:	5e                   	pop    %esi
80104074:	5d                   	pop    %ebp
80104075:	c3                   	ret
      release(&ptable.lock);
80104076:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104079:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
8010407e:	68 20 1d 11 80       	push   $0x80111d20
80104083:	e8 88 05 00 00       	call   80104610 <release>
      return -1;
80104088:	83 c4 10             	add    $0x10,%esp
8010408b:	eb e0                	jmp    8010406d <wait+0xfd>
    panic("sleep");
8010408d:	83 ec 0c             	sub    $0xc,%esp
80104090:	68 2a 75 10 80       	push   $0x8010752a
80104095:	e8 e6 c2 ff ff       	call   80100380 <panic>
8010409a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801040a0 <yield>:
{
801040a0:	55                   	push   %ebp
801040a1:	89 e5                	mov    %esp,%ebp
801040a3:	53                   	push   %ebx
801040a4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
801040a7:	68 20 1d 11 80       	push   $0x80111d20
801040ac:	e8 bf 05 00 00       	call   80104670 <acquire>
  pushcli();
801040b1:	e8 6a 04 00 00       	call   80104520 <pushcli>
  c = mycpu();
801040b6:	e8 f5 f8 ff ff       	call   801039b0 <mycpu>
  p = c->proc;
801040bb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801040c1:	e8 aa 04 00 00       	call   80104570 <popcli>
  myproc()->state = RUNNABLE;
801040c6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
801040cd:	e8 ae fc ff ff       	call   80103d80 <sched>
  release(&ptable.lock);
801040d2:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
801040d9:	e8 32 05 00 00       	call   80104610 <release>
}
801040de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040e1:	83 c4 10             	add    $0x10,%esp
801040e4:	c9                   	leave
801040e5:	c3                   	ret
801040e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801040ed:	00 
801040ee:	66 90                	xchg   %ax,%ax

801040f0 <sleep>:
{
801040f0:	55                   	push   %ebp
801040f1:	89 e5                	mov    %esp,%ebp
801040f3:	57                   	push   %edi
801040f4:	56                   	push   %esi
801040f5:	53                   	push   %ebx
801040f6:	83 ec 0c             	sub    $0xc,%esp
801040f9:	8b 7d 08             	mov    0x8(%ebp),%edi
801040fc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
801040ff:	e8 1c 04 00 00       	call   80104520 <pushcli>
  c = mycpu();
80104104:	e8 a7 f8 ff ff       	call   801039b0 <mycpu>
  p = c->proc;
80104109:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010410f:	e8 5c 04 00 00       	call   80104570 <popcli>
  if(p == 0)
80104114:	85 db                	test   %ebx,%ebx
80104116:	0f 84 87 00 00 00    	je     801041a3 <sleep+0xb3>
  if(lk == 0)
8010411c:	85 f6                	test   %esi,%esi
8010411e:	74 76                	je     80104196 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104120:	81 fe 20 1d 11 80    	cmp    $0x80111d20,%esi
80104126:	74 50                	je     80104178 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104128:	83 ec 0c             	sub    $0xc,%esp
8010412b:	68 20 1d 11 80       	push   $0x80111d20
80104130:	e8 3b 05 00 00       	call   80104670 <acquire>
    release(lk);
80104135:	89 34 24             	mov    %esi,(%esp)
80104138:	e8 d3 04 00 00       	call   80104610 <release>
  p->chan = chan;
8010413d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104140:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104147:	e8 34 fc ff ff       	call   80103d80 <sched>
  p->chan = 0;
8010414c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104153:	c7 04 24 20 1d 11 80 	movl   $0x80111d20,(%esp)
8010415a:	e8 b1 04 00 00       	call   80104610 <release>
    acquire(lk);
8010415f:	83 c4 10             	add    $0x10,%esp
80104162:	89 75 08             	mov    %esi,0x8(%ebp)
}
80104165:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104168:	5b                   	pop    %ebx
80104169:	5e                   	pop    %esi
8010416a:	5f                   	pop    %edi
8010416b:	5d                   	pop    %ebp
    acquire(lk);
8010416c:	e9 ff 04 00 00       	jmp    80104670 <acquire>
80104171:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104178:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010417b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104182:	e8 f9 fb ff ff       	call   80103d80 <sched>
  p->chan = 0;
80104187:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010418e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104191:	5b                   	pop    %ebx
80104192:	5e                   	pop    %esi
80104193:	5f                   	pop    %edi
80104194:	5d                   	pop    %ebp
80104195:	c3                   	ret
    panic("sleep without lk");
80104196:	83 ec 0c             	sub    $0xc,%esp
80104199:	68 30 75 10 80       	push   $0x80107530
8010419e:	e8 dd c1 ff ff       	call   80100380 <panic>
    panic("sleep");
801041a3:	83 ec 0c             	sub    $0xc,%esp
801041a6:	68 2a 75 10 80       	push   $0x8010752a
801041ab:	e8 d0 c1 ff ff       	call   80100380 <panic>

801041b0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801041b0:	55                   	push   %ebp
801041b1:	89 e5                	mov    %esp,%ebp
801041b3:	53                   	push   %ebx
801041b4:	83 ec 10             	sub    $0x10,%esp
801041b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801041ba:	68 20 1d 11 80       	push   $0x80111d20
801041bf:	e8 ac 04 00 00       	call   80104670 <acquire>
801041c4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801041c7:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
801041cc:	eb 0c                	jmp    801041da <wakeup+0x2a>
801041ce:	66 90                	xchg   %ax,%ax
801041d0:	83 c0 7c             	add    $0x7c,%eax
801041d3:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
801041d8:	74 1c                	je     801041f6 <wakeup+0x46>
    if(p->state == SLEEPING && p->chan == chan)
801041da:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801041de:	75 f0                	jne    801041d0 <wakeup+0x20>
801041e0:	3b 58 20             	cmp    0x20(%eax),%ebx
801041e3:	75 eb                	jne    801041d0 <wakeup+0x20>
      p->state = RUNNABLE;
801041e5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801041ec:	83 c0 7c             	add    $0x7c,%eax
801041ef:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
801041f4:	75 e4                	jne    801041da <wakeup+0x2a>
  wakeup1(chan);
  release(&ptable.lock);
801041f6:	c7 45 08 20 1d 11 80 	movl   $0x80111d20,0x8(%ebp)
}
801041fd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104200:	c9                   	leave
  release(&ptable.lock);
80104201:	e9 0a 04 00 00       	jmp    80104610 <release>
80104206:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010420d:	00 
8010420e:	66 90                	xchg   %ax,%ax

80104210 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104210:	55                   	push   %ebp
80104211:	89 e5                	mov    %esp,%ebp
80104213:	53                   	push   %ebx
80104214:	83 ec 10             	sub    $0x10,%esp
80104217:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010421a:	68 20 1d 11 80       	push   $0x80111d20
8010421f:	e8 4c 04 00 00       	call   80104670 <acquire>
80104224:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104227:	b8 54 1d 11 80       	mov    $0x80111d54,%eax
8010422c:	eb 0c                	jmp    8010423a <kill+0x2a>
8010422e:	66 90                	xchg   %ax,%ax
80104230:	83 c0 7c             	add    $0x7c,%eax
80104233:	3d 54 3c 11 80       	cmp    $0x80113c54,%eax
80104238:	74 36                	je     80104270 <kill+0x60>
    if(p->pid == pid){
8010423a:	39 58 10             	cmp    %ebx,0x10(%eax)
8010423d:	75 f1                	jne    80104230 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
8010423f:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104243:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010424a:	75 07                	jne    80104253 <kill+0x43>
        p->state = RUNNABLE;
8010424c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104253:	83 ec 0c             	sub    $0xc,%esp
80104256:	68 20 1d 11 80       	push   $0x80111d20
8010425b:	e8 b0 03 00 00       	call   80104610 <release>
      return 0;
    }
  }
  release(&ptable.lock);
  return -1;
}
80104260:	8b 5d fc             	mov    -0x4(%ebp),%ebx
      return 0;
80104263:	83 c4 10             	add    $0x10,%esp
80104266:	31 c0                	xor    %eax,%eax
}
80104268:	c9                   	leave
80104269:	c3                   	ret
8010426a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  release(&ptable.lock);
80104270:	83 ec 0c             	sub    $0xc,%esp
80104273:	68 20 1d 11 80       	push   $0x80111d20
80104278:	e8 93 03 00 00       	call   80104610 <release>
}
8010427d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return -1;
80104280:	83 c4 10             	add    $0x10,%esp
80104283:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104288:	c9                   	leave
80104289:	c3                   	ret
8010428a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104290 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
80104290:	55                   	push   %ebp
80104291:	89 e5                	mov    %esp,%ebp
80104293:	57                   	push   %edi
80104294:	56                   	push   %esi
80104295:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104298:	53                   	push   %ebx
80104299:	bb c0 1d 11 80       	mov    $0x80111dc0,%ebx
8010429e:	83 ec 3c             	sub    $0x3c,%esp
801042a1:	eb 24                	jmp    801042c7 <procdump+0x37>
801042a3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801042a8:	83 ec 0c             	sub    $0xc,%esp
801042ab:	68 ef 76 10 80       	push   $0x801076ef
801042b0:	e8 8b c4 ff ff       	call   80100740 <cprintf>
801042b5:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042b8:	83 c3 7c             	add    $0x7c,%ebx
801042bb:	81 fb c0 3c 11 80    	cmp    $0x80113cc0,%ebx
801042c1:	0f 84 81 00 00 00    	je     80104348 <procdump+0xb8>
    if(p->state == UNUSED)
801042c7:	8b 43 a0             	mov    -0x60(%ebx),%eax
801042ca:	85 c0                	test   %eax,%eax
801042cc:	74 ea                	je     801042b8 <procdump+0x28>
      state = "???";
801042ce:	ba 41 75 10 80       	mov    $0x80107541,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
801042d3:	83 f8 05             	cmp    $0x5,%eax
801042d6:	77 11                	ja     801042e9 <procdump+0x59>
801042d8:	8b 14 85 20 7b 10 80 	mov    -0x7fef84e0(,%eax,4),%edx
      state = "???";
801042df:	b8 41 75 10 80       	mov    $0x80107541,%eax
801042e4:	85 d2                	test   %edx,%edx
801042e6:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
801042e9:	53                   	push   %ebx
801042ea:	52                   	push   %edx
801042eb:	ff 73 a4             	push   -0x5c(%ebx)
801042ee:	68 45 75 10 80       	push   $0x80107545
801042f3:	e8 48 c4 ff ff       	call   80100740 <cprintf>
    if(p->state == SLEEPING){
801042f8:	83 c4 10             	add    $0x10,%esp
801042fb:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
801042ff:	75 a7                	jne    801042a8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
80104301:	83 ec 08             	sub    $0x8,%esp
80104304:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104307:	8d 7d c0             	lea    -0x40(%ebp),%edi
8010430a:	50                   	push   %eax
8010430b:	8b 43 b0             	mov    -0x50(%ebx),%eax
8010430e:	8b 40 0c             	mov    0xc(%eax),%eax
80104311:	83 c0 08             	add    $0x8,%eax
80104314:	50                   	push   %eax
80104315:	e8 86 01 00 00       	call   801044a0 <getcallerpcs>
      for(i=0; i<10 && pc[i] != 0; i++)
8010431a:	83 c4 10             	add    $0x10,%esp
8010431d:	8d 76 00             	lea    0x0(%esi),%esi
80104320:	8b 17                	mov    (%edi),%edx
80104322:	85 d2                	test   %edx,%edx
80104324:	74 82                	je     801042a8 <procdump+0x18>
        cprintf(" %p", pc[i]);
80104326:	83 ec 08             	sub    $0x8,%esp
      for(i=0; i<10 && pc[i] != 0; i++)
80104329:	83 c7 04             	add    $0x4,%edi
        cprintf(" %p", pc[i]);
8010432c:	52                   	push   %edx
8010432d:	68 81 72 10 80       	push   $0x80107281
80104332:	e8 09 c4 ff ff       	call   80100740 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
80104337:	83 c4 10             	add    $0x10,%esp
8010433a:	39 f7                	cmp    %esi,%edi
8010433c:	75 e2                	jne    80104320 <procdump+0x90>
8010433e:	e9 65 ff ff ff       	jmp    801042a8 <procdump+0x18>
80104343:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  }
}
80104348:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010434b:	5b                   	pop    %ebx
8010434c:	5e                   	pop    %esi
8010434d:	5f                   	pop    %edi
8010434e:	5d                   	pop    %ebp
8010434f:	c3                   	ret

80104350 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104350:	55                   	push   %ebp
80104351:	89 e5                	mov    %esp,%ebp
80104353:	53                   	push   %ebx
80104354:	83 ec 0c             	sub    $0xc,%esp
80104357:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010435a:	68 78 75 10 80       	push   $0x80107578
8010435f:	8d 43 04             	lea    0x4(%ebx),%eax
80104362:	50                   	push   %eax
80104363:	e8 18 01 00 00       	call   80104480 <initlock>
  lk->name = name;
80104368:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010436b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104371:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104374:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010437b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010437e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104381:	c9                   	leave
80104382:	c3                   	ret
80104383:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010438a:	00 
8010438b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104390 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80104390:	55                   	push   %ebp
80104391:	89 e5                	mov    %esp,%ebp
80104393:	56                   	push   %esi
80104394:	53                   	push   %ebx
80104395:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104398:	8d 73 04             	lea    0x4(%ebx),%esi
8010439b:	83 ec 0c             	sub    $0xc,%esp
8010439e:	56                   	push   %esi
8010439f:	e8 cc 02 00 00       	call   80104670 <acquire>
  while (lk->locked) {
801043a4:	8b 13                	mov    (%ebx),%edx
801043a6:	83 c4 10             	add    $0x10,%esp
801043a9:	85 d2                	test   %edx,%edx
801043ab:	74 16                	je     801043c3 <acquiresleep+0x33>
801043ad:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801043b0:	83 ec 08             	sub    $0x8,%esp
801043b3:	56                   	push   %esi
801043b4:	53                   	push   %ebx
801043b5:	e8 36 fd ff ff       	call   801040f0 <sleep>
  while (lk->locked) {
801043ba:	8b 03                	mov    (%ebx),%eax
801043bc:	83 c4 10             	add    $0x10,%esp
801043bf:	85 c0                	test   %eax,%eax
801043c1:	75 ed                	jne    801043b0 <acquiresleep+0x20>
  }
  lk->locked = 1;
801043c3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801043c9:	e8 62 f6 ff ff       	call   80103a30 <myproc>
801043ce:	8b 40 10             	mov    0x10(%eax),%eax
801043d1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801043d4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801043d7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801043da:	5b                   	pop    %ebx
801043db:	5e                   	pop    %esi
801043dc:	5d                   	pop    %ebp
  release(&lk->lk);
801043dd:	e9 2e 02 00 00       	jmp    80104610 <release>
801043e2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801043e9:	00 
801043ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801043f0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
801043f0:	55                   	push   %ebp
801043f1:	89 e5                	mov    %esp,%ebp
801043f3:	56                   	push   %esi
801043f4:	53                   	push   %ebx
801043f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801043f8:	8d 73 04             	lea    0x4(%ebx),%esi
801043fb:	83 ec 0c             	sub    $0xc,%esp
801043fe:	56                   	push   %esi
801043ff:	e8 6c 02 00 00       	call   80104670 <acquire>
  lk->locked = 0;
80104404:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010440a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104411:	89 1c 24             	mov    %ebx,(%esp)
80104414:	e8 97 fd ff ff       	call   801041b0 <wakeup>
  release(&lk->lk);
80104419:	83 c4 10             	add    $0x10,%esp
8010441c:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010441f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104422:	5b                   	pop    %ebx
80104423:	5e                   	pop    %esi
80104424:	5d                   	pop    %ebp
  release(&lk->lk);
80104425:	e9 e6 01 00 00       	jmp    80104610 <release>
8010442a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104430 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104430:	55                   	push   %ebp
80104431:	89 e5                	mov    %esp,%ebp
80104433:	57                   	push   %edi
80104434:	31 ff                	xor    %edi,%edi
80104436:	56                   	push   %esi
80104437:	53                   	push   %ebx
80104438:	83 ec 18             	sub    $0x18,%esp
8010443b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010443e:	8d 73 04             	lea    0x4(%ebx),%esi
80104441:	56                   	push   %esi
80104442:	e8 29 02 00 00       	call   80104670 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104447:	8b 03                	mov    (%ebx),%eax
80104449:	83 c4 10             	add    $0x10,%esp
8010444c:	85 c0                	test   %eax,%eax
8010444e:	75 18                	jne    80104468 <holdingsleep+0x38>
  release(&lk->lk);
80104450:	83 ec 0c             	sub    $0xc,%esp
80104453:	56                   	push   %esi
80104454:	e8 b7 01 00 00       	call   80104610 <release>
  return r;
}
80104459:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010445c:	89 f8                	mov    %edi,%eax
8010445e:	5b                   	pop    %ebx
8010445f:	5e                   	pop    %esi
80104460:	5f                   	pop    %edi
80104461:	5d                   	pop    %ebp
80104462:	c3                   	ret
80104463:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  r = lk->locked && (lk->pid == myproc()->pid);
80104468:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
8010446b:	e8 c0 f5 ff ff       	call   80103a30 <myproc>
80104470:	39 58 10             	cmp    %ebx,0x10(%eax)
80104473:	0f 94 c0             	sete   %al
80104476:	0f b6 c0             	movzbl %al,%eax
80104479:	89 c7                	mov    %eax,%edi
8010447b:	eb d3                	jmp    80104450 <holdingsleep+0x20>
8010447d:	66 90                	xchg   %ax,%ax
8010447f:	90                   	nop

80104480 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80104480:	55                   	push   %ebp
80104481:	89 e5                	mov    %esp,%ebp
80104483:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
80104486:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
80104489:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
8010448f:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
80104492:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80104499:	5d                   	pop    %ebp
8010449a:	c3                   	ret
8010449b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801044a0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	53                   	push   %ebx
801044a4:	8b 45 08             	mov    0x8(%ebp),%eax
801044a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801044aa:	8d 50 f8             	lea    -0x8(%eax),%edx
  for(i = 0; i < 10; i++){
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801044ad:	05 f8 ff ff 7f       	add    $0x7ffffff8,%eax
801044b2:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
  for(i = 0; i < 10; i++){
801044b7:	b8 00 00 00 00       	mov    $0x0,%eax
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801044bc:	76 10                	jbe    801044ce <getcallerpcs+0x2e>
801044be:	eb 28                	jmp    801044e8 <getcallerpcs+0x48>
801044c0:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
801044c6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801044cc:	77 1a                	ja     801044e8 <getcallerpcs+0x48>
      break;
    pcs[i] = ebp[1];     // saved %eip
801044ce:	8b 5a 04             	mov    0x4(%edx),%ebx
801044d1:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
  for(i = 0; i < 10; i++){
801044d4:	83 c0 01             	add    $0x1,%eax
    ebp = (uint*)ebp[0]; // saved %ebp
801044d7:	8b 12                	mov    (%edx),%edx
  for(i = 0; i < 10; i++){
801044d9:	83 f8 0a             	cmp    $0xa,%eax
801044dc:	75 e2                	jne    801044c0 <getcallerpcs+0x20>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801044de:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801044e1:	c9                   	leave
801044e2:	c3                   	ret
801044e3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801044e8:	8d 04 81             	lea    (%ecx,%eax,4),%eax
801044eb:	83 c1 28             	add    $0x28,%ecx
801044ee:	89 ca                	mov    %ecx,%edx
801044f0:	29 c2                	sub    %eax,%edx
801044f2:	83 e2 04             	and    $0x4,%edx
801044f5:	74 11                	je     80104508 <getcallerpcs+0x68>
    pcs[i] = 0;
801044f7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801044fd:	83 c0 04             	add    $0x4,%eax
80104500:	39 c1                	cmp    %eax,%ecx
80104502:	74 da                	je     801044de <getcallerpcs+0x3e>
80104504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    pcs[i] = 0;
80104508:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
8010450e:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80104511:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80104518:	39 c1                	cmp    %eax,%ecx
8010451a:	75 ec                	jne    80104508 <getcallerpcs+0x68>
8010451c:	eb c0                	jmp    801044de <getcallerpcs+0x3e>
8010451e:	66 90                	xchg   %ax,%ax

80104520 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104520:	55                   	push   %ebp
80104521:	89 e5                	mov    %esp,%ebp
80104523:	53                   	push   %ebx
80104524:	83 ec 04             	sub    $0x4,%esp
80104527:	9c                   	pushf
80104528:	5b                   	pop    %ebx
  asm volatile("cli");
80104529:	fa                   	cli
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010452a:	e8 81 f4 ff ff       	call   801039b0 <mycpu>
8010452f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104535:	85 c0                	test   %eax,%eax
80104537:	74 17                	je     80104550 <pushcli+0x30>
    mycpu()->intena = eflags & FL_IF;
  mycpu()->ncli += 1;
80104539:	e8 72 f4 ff ff       	call   801039b0 <mycpu>
8010453e:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104545:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104548:	c9                   	leave
80104549:	c3                   	ret
8010454a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    mycpu()->intena = eflags & FL_IF;
80104550:	e8 5b f4 ff ff       	call   801039b0 <mycpu>
80104555:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010455b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104561:	eb d6                	jmp    80104539 <pushcli+0x19>
80104563:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010456a:	00 
8010456b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104570 <popcli>:

void
popcli(void)
{
80104570:	55                   	push   %ebp
80104571:	89 e5                	mov    %esp,%ebp
80104573:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104576:	9c                   	pushf
80104577:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104578:	f6 c4 02             	test   $0x2,%ah
8010457b:	75 35                	jne    801045b2 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010457d:	e8 2e f4 ff ff       	call   801039b0 <mycpu>
80104582:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104589:	78 34                	js     801045bf <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010458b:	e8 20 f4 ff ff       	call   801039b0 <mycpu>
80104590:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104596:	85 d2                	test   %edx,%edx
80104598:	74 06                	je     801045a0 <popcli+0x30>
    sti();
}
8010459a:	c9                   	leave
8010459b:	c3                   	ret
8010459c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
801045a0:	e8 0b f4 ff ff       	call   801039b0 <mycpu>
801045a5:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801045ab:	85 c0                	test   %eax,%eax
801045ad:	74 eb                	je     8010459a <popcli+0x2a>
  asm volatile("sti");
801045af:	fb                   	sti
}
801045b0:	c9                   	leave
801045b1:	c3                   	ret
    panic("popcli - interruptible");
801045b2:	83 ec 0c             	sub    $0xc,%esp
801045b5:	68 83 75 10 80       	push   $0x80107583
801045ba:	e8 c1 bd ff ff       	call   80100380 <panic>
    panic("popcli");
801045bf:	83 ec 0c             	sub    $0xc,%esp
801045c2:	68 9a 75 10 80       	push   $0x8010759a
801045c7:	e8 b4 bd ff ff       	call   80100380 <panic>
801045cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801045d0 <holding>:
{
801045d0:	55                   	push   %ebp
801045d1:	89 e5                	mov    %esp,%ebp
801045d3:	56                   	push   %esi
801045d4:	53                   	push   %ebx
801045d5:	8b 75 08             	mov    0x8(%ebp),%esi
801045d8:	31 db                	xor    %ebx,%ebx
  pushcli();
801045da:	e8 41 ff ff ff       	call   80104520 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801045df:	8b 06                	mov    (%esi),%eax
801045e1:	85 c0                	test   %eax,%eax
801045e3:	75 0b                	jne    801045f0 <holding+0x20>
  popcli();
801045e5:	e8 86 ff ff ff       	call   80104570 <popcli>
}
801045ea:	89 d8                	mov    %ebx,%eax
801045ec:	5b                   	pop    %ebx
801045ed:	5e                   	pop    %esi
801045ee:	5d                   	pop    %ebp
801045ef:	c3                   	ret
  r = lock->locked && lock->cpu == mycpu();
801045f0:	8b 5e 08             	mov    0x8(%esi),%ebx
801045f3:	e8 b8 f3 ff ff       	call   801039b0 <mycpu>
801045f8:	39 c3                	cmp    %eax,%ebx
801045fa:	0f 94 c3             	sete   %bl
  popcli();
801045fd:	e8 6e ff ff ff       	call   80104570 <popcli>
  r = lock->locked && lock->cpu == mycpu();
80104602:	0f b6 db             	movzbl %bl,%ebx
}
80104605:	89 d8                	mov    %ebx,%eax
80104607:	5b                   	pop    %ebx
80104608:	5e                   	pop    %esi
80104609:	5d                   	pop    %ebp
8010460a:	c3                   	ret
8010460b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104610 <release>:
{
80104610:	55                   	push   %ebp
80104611:	89 e5                	mov    %esp,%ebp
80104613:	56                   	push   %esi
80104614:	53                   	push   %ebx
80104615:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
80104618:	e8 03 ff ff ff       	call   80104520 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
8010461d:	8b 03                	mov    (%ebx),%eax
8010461f:	85 c0                	test   %eax,%eax
80104621:	75 15                	jne    80104638 <release+0x28>
  popcli();
80104623:	e8 48 ff ff ff       	call   80104570 <popcli>
    panic("release");
80104628:	83 ec 0c             	sub    $0xc,%esp
8010462b:	68 a1 75 10 80       	push   $0x801075a1
80104630:	e8 4b bd ff ff       	call   80100380 <panic>
80104635:	8d 76 00             	lea    0x0(%esi),%esi
  r = lock->locked && lock->cpu == mycpu();
80104638:	8b 73 08             	mov    0x8(%ebx),%esi
8010463b:	e8 70 f3 ff ff       	call   801039b0 <mycpu>
80104640:	39 c6                	cmp    %eax,%esi
80104642:	75 df                	jne    80104623 <release+0x13>
  popcli();
80104644:	e8 27 ff ff ff       	call   80104570 <popcli>
  lk->pcs[0] = 0;
80104649:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
80104650:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
80104657:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010465c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
80104662:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104665:	5b                   	pop    %ebx
80104666:	5e                   	pop    %esi
80104667:	5d                   	pop    %ebp
  popcli();
80104668:	e9 03 ff ff ff       	jmp    80104570 <popcli>
8010466d:	8d 76 00             	lea    0x0(%esi),%esi

80104670 <acquire>:
{
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	53                   	push   %ebx
80104674:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80104677:	e8 a4 fe ff ff       	call   80104520 <pushcli>
  if(holding(lk))
8010467c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pushcli();
8010467f:	e8 9c fe ff ff       	call   80104520 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80104684:	8b 03                	mov    (%ebx),%eax
80104686:	85 c0                	test   %eax,%eax
80104688:	0f 85 b2 00 00 00    	jne    80104740 <acquire+0xd0>
  popcli();
8010468e:	e8 dd fe ff ff       	call   80104570 <popcli>
  asm volatile("lock; xchgl %0, %1" :
80104693:	b9 01 00 00 00       	mov    $0x1,%ecx
80104698:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010469f:	00 
  while(xchg(&lk->locked, 1) != 0)
801046a0:	8b 55 08             	mov    0x8(%ebp),%edx
801046a3:	89 c8                	mov    %ecx,%eax
801046a5:	f0 87 02             	lock xchg %eax,(%edx)
801046a8:	85 c0                	test   %eax,%eax
801046aa:	75 f4                	jne    801046a0 <acquire+0x30>
  __sync_synchronize();
801046ac:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
801046b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801046b4:	e8 f7 f2 ff ff       	call   801039b0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
801046b9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  for(i = 0; i < 10; i++){
801046bc:	31 d2                	xor    %edx,%edx
  lk->cpu = mycpu();
801046be:	89 43 08             	mov    %eax,0x8(%ebx)
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801046c1:	8d 85 00 00 00 80    	lea    -0x80000000(%ebp),%eax
801046c7:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
801046cc:	77 32                	ja     80104700 <acquire+0x90>
  ebp = (uint*)v - 2;
801046ce:	89 e8                	mov    %ebp,%eax
801046d0:	eb 14                	jmp    801046e6 <acquire+0x76>
801046d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801046d8:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801046de:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801046e4:	77 1a                	ja     80104700 <acquire+0x90>
    pcs[i] = ebp[1];     // saved %eip
801046e6:	8b 58 04             	mov    0x4(%eax),%ebx
801046e9:	89 5c 91 0c          	mov    %ebx,0xc(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801046ed:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801046f0:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801046f2:	83 fa 0a             	cmp    $0xa,%edx
801046f5:	75 e1                	jne    801046d8 <acquire+0x68>
}
801046f7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801046fa:	c9                   	leave
801046fb:	c3                   	ret
801046fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104700:	8d 44 91 0c          	lea    0xc(%ecx,%edx,4),%eax
80104704:	83 c1 34             	add    $0x34,%ecx
80104707:	89 ca                	mov    %ecx,%edx
80104709:	29 c2                	sub    %eax,%edx
8010470b:	83 e2 04             	and    $0x4,%edx
8010470e:	74 10                	je     80104720 <acquire+0xb0>
    pcs[i] = 0;
80104710:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104716:	83 c0 04             	add    $0x4,%eax
80104719:	39 c1                	cmp    %eax,%ecx
8010471b:	74 da                	je     801046f7 <acquire+0x87>
8010471d:	8d 76 00             	lea    0x0(%esi),%esi
    pcs[i] = 0;
80104720:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
80104726:	83 c0 08             	add    $0x8,%eax
    pcs[i] = 0;
80104729:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
  for(; i < 10; i++)
80104730:	39 c1                	cmp    %eax,%ecx
80104732:	75 ec                	jne    80104720 <acquire+0xb0>
80104734:	eb c1                	jmp    801046f7 <acquire+0x87>
80104736:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010473d:	00 
8010473e:	66 90                	xchg   %ax,%ax
  r = lock->locked && lock->cpu == mycpu();
80104740:	8b 5b 08             	mov    0x8(%ebx),%ebx
80104743:	e8 68 f2 ff ff       	call   801039b0 <mycpu>
80104748:	39 c3                	cmp    %eax,%ebx
8010474a:	0f 85 3e ff ff ff    	jne    8010468e <acquire+0x1e>
  popcli();
80104750:	e8 1b fe ff ff       	call   80104570 <popcli>
    panic("acquire");
80104755:	83 ec 0c             	sub    $0xc,%esp
80104758:	68 a9 75 10 80       	push   $0x801075a9
8010475d:	e8 1e bc ff ff       	call   80100380 <panic>
80104762:	66 90                	xchg   %ax,%ax
80104764:	66 90                	xchg   %ax,%ax
80104766:	66 90                	xchg   %ax,%ax
80104768:	66 90                	xchg   %ax,%ax
8010476a:	66 90                	xchg   %ax,%ax
8010476c:	66 90                	xchg   %ax,%ax
8010476e:	66 90                	xchg   %ax,%ax

80104770 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80104770:	55                   	push   %ebp
80104771:	89 e5                	mov    %esp,%ebp
80104773:	57                   	push   %edi
80104774:	8b 55 08             	mov    0x8(%ebp),%edx
80104777:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
8010477a:	89 d0                	mov    %edx,%eax
8010477c:	09 c8                	or     %ecx,%eax
8010477e:	a8 03                	test   $0x3,%al
80104780:	75 1e                	jne    801047a0 <memset+0x30>
    c &= 0xFF;
80104782:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104786:	c1 e9 02             	shr    $0x2,%ecx
  asm volatile("cld; rep stosl" :
80104789:	89 d7                	mov    %edx,%edi
8010478b:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
80104791:	fc                   	cld
80104792:	f3 ab                	rep stos %eax,%es:(%edi)
  } else
    stosb(dst, c, n);
  return dst;
}
80104794:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104797:	89 d0                	mov    %edx,%eax
80104799:	c9                   	leave
8010479a:	c3                   	ret
8010479b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  asm volatile("cld; rep stosb" :
801047a0:	8b 45 0c             	mov    0xc(%ebp),%eax
801047a3:	89 d7                	mov    %edx,%edi
801047a5:	fc                   	cld
801047a6:	f3 aa                	rep stos %al,%es:(%edi)
801047a8:	8b 7d fc             	mov    -0x4(%ebp),%edi
801047ab:	89 d0                	mov    %edx,%eax
801047ad:	c9                   	leave
801047ae:	c3                   	ret
801047af:	90                   	nop

801047b0 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
801047b0:	55                   	push   %ebp
801047b1:	89 e5                	mov    %esp,%ebp
801047b3:	56                   	push   %esi
801047b4:	8b 75 10             	mov    0x10(%ebp),%esi
801047b7:	8b 45 08             	mov    0x8(%ebp),%eax
801047ba:	53                   	push   %ebx
801047bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
801047be:	85 f6                	test   %esi,%esi
801047c0:	74 2e                	je     801047f0 <memcmp+0x40>
801047c2:	01 c6                	add    %eax,%esi
801047c4:	eb 14                	jmp    801047da <memcmp+0x2a>
801047c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801047cd:	00 
801047ce:	66 90                	xchg   %ax,%ax
    if(*s1 != *s2)
      return *s1 - *s2;
    s1++, s2++;
801047d0:	83 c0 01             	add    $0x1,%eax
801047d3:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0){
801047d6:	39 f0                	cmp    %esi,%eax
801047d8:	74 16                	je     801047f0 <memcmp+0x40>
    if(*s1 != *s2)
801047da:	0f b6 08             	movzbl (%eax),%ecx
801047dd:	0f b6 1a             	movzbl (%edx),%ebx
801047e0:	38 d9                	cmp    %bl,%cl
801047e2:	74 ec                	je     801047d0 <memcmp+0x20>
      return *s1 - *s2;
801047e4:	0f b6 c1             	movzbl %cl,%eax
801047e7:	29 d8                	sub    %ebx,%eax
  }

  return 0;
}
801047e9:	5b                   	pop    %ebx
801047ea:	5e                   	pop    %esi
801047eb:	5d                   	pop    %ebp
801047ec:	c3                   	ret
801047ed:	8d 76 00             	lea    0x0(%esi),%esi
801047f0:	5b                   	pop    %ebx
  return 0;
801047f1:	31 c0                	xor    %eax,%eax
}
801047f3:	5e                   	pop    %esi
801047f4:	5d                   	pop    %ebp
801047f5:	c3                   	ret
801047f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801047fd:	00 
801047fe:	66 90                	xchg   %ax,%ax

80104800 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104800:	55                   	push   %ebp
80104801:	89 e5                	mov    %esp,%ebp
80104803:	57                   	push   %edi
80104804:	8b 55 08             	mov    0x8(%ebp),%edx
80104807:	8b 45 10             	mov    0x10(%ebp),%eax
8010480a:	56                   	push   %esi
8010480b:	8b 75 0c             	mov    0xc(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
8010480e:	39 d6                	cmp    %edx,%esi
80104810:	73 26                	jae    80104838 <memmove+0x38>
80104812:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104815:	39 ca                	cmp    %ecx,%edx
80104817:	73 1f                	jae    80104838 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104819:	85 c0                	test   %eax,%eax
8010481b:	74 0f                	je     8010482c <memmove+0x2c>
8010481d:	83 e8 01             	sub    $0x1,%eax
      *--d = *--s;
80104820:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104824:	88 0c 02             	mov    %cl,(%edx,%eax,1)
    while(n-- > 0)
80104827:	83 e8 01             	sub    $0x1,%eax
8010482a:	73 f4                	jae    80104820 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
8010482c:	5e                   	pop    %esi
8010482d:	89 d0                	mov    %edx,%eax
8010482f:	5f                   	pop    %edi
80104830:	5d                   	pop    %ebp
80104831:	c3                   	ret
80104832:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    while(n-- > 0)
80104838:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
8010483b:	89 d7                	mov    %edx,%edi
8010483d:	85 c0                	test   %eax,%eax
8010483f:	74 eb                	je     8010482c <memmove+0x2c>
80104841:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      *d++ = *s++;
80104848:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    while(n-- > 0)
80104849:	39 ce                	cmp    %ecx,%esi
8010484b:	75 fb                	jne    80104848 <memmove+0x48>
}
8010484d:	5e                   	pop    %esi
8010484e:	89 d0                	mov    %edx,%eax
80104850:	5f                   	pop    %edi
80104851:	5d                   	pop    %ebp
80104852:	c3                   	ret
80104853:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010485a:	00 
8010485b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104860 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
  return memmove(dst, src, n);
80104860:	eb 9e                	jmp    80104800 <memmove>
80104862:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104869:	00 
8010486a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104870 <strncmp>:
}

int
strncmp(const char *p, const char *q, uint n)
{
80104870:	55                   	push   %ebp
80104871:	89 e5                	mov    %esp,%ebp
80104873:	53                   	push   %ebx
80104874:	8b 55 10             	mov    0x10(%ebp),%edx
80104877:	8b 45 08             	mov    0x8(%ebp),%eax
8010487a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(n > 0 && *p && *p == *q)
8010487d:	85 d2                	test   %edx,%edx
8010487f:	75 16                	jne    80104897 <strncmp+0x27>
80104881:	eb 2d                	jmp    801048b0 <strncmp+0x40>
80104883:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104888:	3a 19                	cmp    (%ecx),%bl
8010488a:	75 12                	jne    8010489e <strncmp+0x2e>
    n--, p++, q++;
8010488c:	83 c0 01             	add    $0x1,%eax
8010488f:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104892:	83 ea 01             	sub    $0x1,%edx
80104895:	74 19                	je     801048b0 <strncmp+0x40>
80104897:	0f b6 18             	movzbl (%eax),%ebx
8010489a:	84 db                	test   %bl,%bl
8010489c:	75 ea                	jne    80104888 <strncmp+0x18>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
8010489e:	0f b6 00             	movzbl (%eax),%eax
801048a1:	0f b6 11             	movzbl (%ecx),%edx
}
801048a4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048a7:	c9                   	leave
  return (uchar)*p - (uchar)*q;
801048a8:	29 d0                	sub    %edx,%eax
}
801048aa:	c3                   	ret
801048ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801048b0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return 0;
801048b3:	31 c0                	xor    %eax,%eax
}
801048b5:	c9                   	leave
801048b6:	c3                   	ret
801048b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801048be:	00 
801048bf:	90                   	nop

801048c0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801048c0:	55                   	push   %ebp
801048c1:	89 e5                	mov    %esp,%ebp
801048c3:	57                   	push   %edi
801048c4:	56                   	push   %esi
801048c5:	8b 75 08             	mov    0x8(%ebp),%esi
801048c8:	53                   	push   %ebx
801048c9:	8b 55 10             	mov    0x10(%ebp),%edx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
801048cc:	89 f0                	mov    %esi,%eax
801048ce:	eb 15                	jmp    801048e5 <strncpy+0x25>
801048d0:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
801048d4:	8b 7d 0c             	mov    0xc(%ebp),%edi
801048d7:	83 c0 01             	add    $0x1,%eax
801048da:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
801048de:	88 48 ff             	mov    %cl,-0x1(%eax)
801048e1:	84 c9                	test   %cl,%cl
801048e3:	74 13                	je     801048f8 <strncpy+0x38>
801048e5:	89 d3                	mov    %edx,%ebx
801048e7:	83 ea 01             	sub    $0x1,%edx
801048ea:	85 db                	test   %ebx,%ebx
801048ec:	7f e2                	jg     801048d0 <strncpy+0x10>
    ;
  while(n-- > 0)
    *s++ = 0;
  return os;
}
801048ee:	5b                   	pop    %ebx
801048ef:	89 f0                	mov    %esi,%eax
801048f1:	5e                   	pop    %esi
801048f2:	5f                   	pop    %edi
801048f3:	5d                   	pop    %ebp
801048f4:	c3                   	ret
801048f5:	8d 76 00             	lea    0x0(%esi),%esi
  while(n-- > 0)
801048f8:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
801048fb:	83 e9 01             	sub    $0x1,%ecx
801048fe:	85 d2                	test   %edx,%edx
80104900:	74 ec                	je     801048ee <strncpy+0x2e>
80104902:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    *s++ = 0;
80104908:	83 c0 01             	add    $0x1,%eax
8010490b:	89 ca                	mov    %ecx,%edx
8010490d:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
  while(n-- > 0)
80104911:	29 c2                	sub    %eax,%edx
80104913:	85 d2                	test   %edx,%edx
80104915:	7f f1                	jg     80104908 <strncpy+0x48>
}
80104917:	5b                   	pop    %ebx
80104918:	89 f0                	mov    %esi,%eax
8010491a:	5e                   	pop    %esi
8010491b:	5f                   	pop    %edi
8010491c:	5d                   	pop    %ebp
8010491d:	c3                   	ret
8010491e:	66 90                	xchg   %ax,%ax

80104920 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104920:	55                   	push   %ebp
80104921:	89 e5                	mov    %esp,%ebp
80104923:	56                   	push   %esi
80104924:	8b 55 10             	mov    0x10(%ebp),%edx
80104927:	8b 75 08             	mov    0x8(%ebp),%esi
8010492a:	53                   	push   %ebx
8010492b:	8b 45 0c             	mov    0xc(%ebp),%eax
  char *os;

  os = s;
  if(n <= 0)
8010492e:	85 d2                	test   %edx,%edx
80104930:	7e 25                	jle    80104957 <safestrcpy+0x37>
80104932:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
80104936:	89 f2                	mov    %esi,%edx
80104938:	eb 16                	jmp    80104950 <safestrcpy+0x30>
8010493a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104940:	0f b6 08             	movzbl (%eax),%ecx
80104943:	83 c0 01             	add    $0x1,%eax
80104946:	83 c2 01             	add    $0x1,%edx
80104949:	88 4a ff             	mov    %cl,-0x1(%edx)
8010494c:	84 c9                	test   %cl,%cl
8010494e:	74 04                	je     80104954 <safestrcpy+0x34>
80104950:	39 d8                	cmp    %ebx,%eax
80104952:	75 ec                	jne    80104940 <safestrcpy+0x20>
    ;
  *s = 0;
80104954:	c6 02 00             	movb   $0x0,(%edx)
  return os;
}
80104957:	89 f0                	mov    %esi,%eax
80104959:	5b                   	pop    %ebx
8010495a:	5e                   	pop    %esi
8010495b:	5d                   	pop    %ebp
8010495c:	c3                   	ret
8010495d:	8d 76 00             	lea    0x0(%esi),%esi

80104960 <strlen>:

int
strlen(const char *s)
{
80104960:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104961:	31 c0                	xor    %eax,%eax
{
80104963:	89 e5                	mov    %esp,%ebp
80104965:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104968:	80 3a 00             	cmpb   $0x0,(%edx)
8010496b:	74 0c                	je     80104979 <strlen+0x19>
8010496d:	8d 76 00             	lea    0x0(%esi),%esi
80104970:	83 c0 01             	add    $0x1,%eax
80104973:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104977:	75 f7                	jne    80104970 <strlen+0x10>
    ;
  return n;
}
80104979:	5d                   	pop    %ebp
8010497a:	c3                   	ret

8010497b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
8010497b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
8010497f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104983:	55                   	push   %ebp
  pushl %ebx
80104984:	53                   	push   %ebx
  pushl %esi
80104985:	56                   	push   %esi
  pushl %edi
80104986:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104987:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104989:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
8010498b:	5f                   	pop    %edi
  popl %esi
8010498c:	5e                   	pop    %esi
  popl %ebx
8010498d:	5b                   	pop    %ebx
  popl %ebp
8010498e:	5d                   	pop    %ebp
  ret
8010498f:	c3                   	ret

80104990 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104990:	55                   	push   %ebp
80104991:	89 e5                	mov    %esp,%ebp
80104993:	53                   	push   %ebx
80104994:	83 ec 04             	sub    $0x4,%esp
80104997:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
8010499a:	e8 91 f0 ff ff       	call   80103a30 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010499f:	8b 00                	mov    (%eax),%eax
801049a1:	39 c3                	cmp    %eax,%ebx
801049a3:	73 1b                	jae    801049c0 <fetchint+0x30>
801049a5:	8d 53 04             	lea    0x4(%ebx),%edx
801049a8:	39 d0                	cmp    %edx,%eax
801049aa:	72 14                	jb     801049c0 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
801049ac:	8b 45 0c             	mov    0xc(%ebp),%eax
801049af:	8b 13                	mov    (%ebx),%edx
801049b1:	89 10                	mov    %edx,(%eax)
  return 0;
801049b3:	31 c0                	xor    %eax,%eax
}
801049b5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049b8:	c9                   	leave
801049b9:	c3                   	ret
801049ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801049c0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801049c5:	eb ee                	jmp    801049b5 <fetchint+0x25>
801049c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801049ce:	00 
801049cf:	90                   	nop

801049d0 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
801049d0:	55                   	push   %ebp
801049d1:	89 e5                	mov    %esp,%ebp
801049d3:	53                   	push   %ebx
801049d4:	83 ec 04             	sub    $0x4,%esp
801049d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
801049da:	e8 51 f0 ff ff       	call   80103a30 <myproc>

  if(addr >= curproc->sz)
801049df:	3b 18                	cmp    (%eax),%ebx
801049e1:	73 2d                	jae    80104a10 <fetchstr+0x40>
    return -1;
  *pp = (char*)addr;
801049e3:	8b 55 0c             	mov    0xc(%ebp),%edx
801049e6:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
801049e8:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
801049ea:	39 d3                	cmp    %edx,%ebx
801049ec:	73 22                	jae    80104a10 <fetchstr+0x40>
801049ee:	89 d8                	mov    %ebx,%eax
801049f0:	eb 0d                	jmp    801049ff <fetchstr+0x2f>
801049f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801049f8:	83 c0 01             	add    $0x1,%eax
801049fb:	39 d0                	cmp    %edx,%eax
801049fd:	73 11                	jae    80104a10 <fetchstr+0x40>
    if(*s == 0)
801049ff:	80 38 00             	cmpb   $0x0,(%eax)
80104a02:	75 f4                	jne    801049f8 <fetchstr+0x28>
      return s - *pp;
80104a04:	29 d8                	sub    %ebx,%eax
  }
  return -1;
}
80104a06:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a09:	c9                   	leave
80104a0a:	c3                   	ret
80104a0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a10:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
80104a13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104a18:	c9                   	leave
80104a19:	c3                   	ret
80104a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a20 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104a20:	55                   	push   %ebp
80104a21:	89 e5                	mov    %esp,%ebp
80104a23:	56                   	push   %esi
80104a24:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a25:	e8 06 f0 ff ff       	call   80103a30 <myproc>
80104a2a:	8b 55 08             	mov    0x8(%ebp),%edx
80104a2d:	8b 40 18             	mov    0x18(%eax),%eax
80104a30:	8b 40 44             	mov    0x44(%eax),%eax
80104a33:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104a36:	e8 f5 ef ff ff       	call   80103a30 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a3b:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104a3e:	8b 00                	mov    (%eax),%eax
80104a40:	39 c6                	cmp    %eax,%esi
80104a42:	73 1c                	jae    80104a60 <argint+0x40>
80104a44:	8d 53 08             	lea    0x8(%ebx),%edx
80104a47:	39 d0                	cmp    %edx,%eax
80104a49:	72 15                	jb     80104a60 <argint+0x40>
  *ip = *(int*)(addr);
80104a4b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a4e:	8b 53 04             	mov    0x4(%ebx),%edx
80104a51:	89 10                	mov    %edx,(%eax)
  return 0;
80104a53:	31 c0                	xor    %eax,%eax
}
80104a55:	5b                   	pop    %ebx
80104a56:	5e                   	pop    %esi
80104a57:	5d                   	pop    %ebp
80104a58:	c3                   	ret
80104a59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104a60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a65:	eb ee                	jmp    80104a55 <argint+0x35>
80104a67:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a6e:	00 
80104a6f:	90                   	nop

80104a70 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104a70:	55                   	push   %ebp
80104a71:	89 e5                	mov    %esp,%ebp
80104a73:	57                   	push   %edi
80104a74:	56                   	push   %esi
80104a75:	53                   	push   %ebx
80104a76:	83 ec 0c             	sub    $0xc,%esp
  int i;
  struct proc *curproc = myproc();
80104a79:	e8 b2 ef ff ff       	call   80103a30 <myproc>
80104a7e:	89 c6                	mov    %eax,%esi
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a80:	e8 ab ef ff ff       	call   80103a30 <myproc>
80104a85:	8b 55 08             	mov    0x8(%ebp),%edx
80104a88:	8b 40 18             	mov    0x18(%eax),%eax
80104a8b:	8b 40 44             	mov    0x44(%eax),%eax
80104a8e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104a91:	e8 9a ef ff ff       	call   80103a30 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104a96:	8d 7b 04             	lea    0x4(%ebx),%edi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104a99:	8b 00                	mov    (%eax),%eax
80104a9b:	39 c7                	cmp    %eax,%edi
80104a9d:	73 31                	jae    80104ad0 <argptr+0x60>
80104a9f:	8d 4b 08             	lea    0x8(%ebx),%ecx
80104aa2:	39 c8                	cmp    %ecx,%eax
80104aa4:	72 2a                	jb     80104ad0 <argptr+0x60>
 
  if(argint(n, &i) < 0)
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104aa6:	8b 55 10             	mov    0x10(%ebp),%edx
  *ip = *(int*)(addr);
80104aa9:	8b 43 04             	mov    0x4(%ebx),%eax
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104aac:	85 d2                	test   %edx,%edx
80104aae:	78 20                	js     80104ad0 <argptr+0x60>
80104ab0:	8b 16                	mov    (%esi),%edx
80104ab2:	39 d0                	cmp    %edx,%eax
80104ab4:	73 1a                	jae    80104ad0 <argptr+0x60>
80104ab6:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104ab9:	01 c3                	add    %eax,%ebx
80104abb:	39 da                	cmp    %ebx,%edx
80104abd:	72 11                	jb     80104ad0 <argptr+0x60>
    return -1;
  *pp = (char*)i;
80104abf:	8b 55 0c             	mov    0xc(%ebp),%edx
80104ac2:	89 02                	mov    %eax,(%edx)
  return 0;
80104ac4:	31 c0                	xor    %eax,%eax
}
80104ac6:	83 c4 0c             	add    $0xc,%esp
80104ac9:	5b                   	pop    %ebx
80104aca:	5e                   	pop    %esi
80104acb:	5f                   	pop    %edi
80104acc:	5d                   	pop    %ebp
80104acd:	c3                   	ret
80104ace:	66 90                	xchg   %ax,%ax
    return -1;
80104ad0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ad5:	eb ef                	jmp    80104ac6 <argptr+0x56>
80104ad7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104ade:	00 
80104adf:	90                   	nop

80104ae0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104ae0:	55                   	push   %ebp
80104ae1:	89 e5                	mov    %esp,%ebp
80104ae3:	56                   	push   %esi
80104ae4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104ae5:	e8 46 ef ff ff       	call   80103a30 <myproc>
80104aea:	8b 55 08             	mov    0x8(%ebp),%edx
80104aed:	8b 40 18             	mov    0x18(%eax),%eax
80104af0:	8b 40 44             	mov    0x44(%eax),%eax
80104af3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104af6:	e8 35 ef ff ff       	call   80103a30 <myproc>
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104afb:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104afe:	8b 00                	mov    (%eax),%eax
80104b00:	39 c6                	cmp    %eax,%esi
80104b02:	73 44                	jae    80104b48 <argstr+0x68>
80104b04:	8d 53 08             	lea    0x8(%ebx),%edx
80104b07:	39 d0                	cmp    %edx,%eax
80104b09:	72 3d                	jb     80104b48 <argstr+0x68>
  *ip = *(int*)(addr);
80104b0b:	8b 5b 04             	mov    0x4(%ebx),%ebx
  struct proc *curproc = myproc();
80104b0e:	e8 1d ef ff ff       	call   80103a30 <myproc>
  if(addr >= curproc->sz)
80104b13:	3b 18                	cmp    (%eax),%ebx
80104b15:	73 31                	jae    80104b48 <argstr+0x68>
  *pp = (char*)addr;
80104b17:	8b 55 0c             	mov    0xc(%ebp),%edx
80104b1a:	89 1a                	mov    %ebx,(%edx)
  ep = (char*)curproc->sz;
80104b1c:	8b 10                	mov    (%eax),%edx
  for(s = *pp; s < ep; s++){
80104b1e:	39 d3                	cmp    %edx,%ebx
80104b20:	73 26                	jae    80104b48 <argstr+0x68>
80104b22:	89 d8                	mov    %ebx,%eax
80104b24:	eb 11                	jmp    80104b37 <argstr+0x57>
80104b26:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b2d:	00 
80104b2e:	66 90                	xchg   %ax,%ax
80104b30:	83 c0 01             	add    $0x1,%eax
80104b33:	39 d0                	cmp    %edx,%eax
80104b35:	73 11                	jae    80104b48 <argstr+0x68>
    if(*s == 0)
80104b37:	80 38 00             	cmpb   $0x0,(%eax)
80104b3a:	75 f4                	jne    80104b30 <argstr+0x50>
      return s - *pp;
80104b3c:	29 d8                	sub    %ebx,%eax
  int addr;
  if(argint(n, &addr) < 0)
    return -1;
  return fetchstr(addr, pp);
}
80104b3e:	5b                   	pop    %ebx
80104b3f:	5e                   	pop    %esi
80104b40:	5d                   	pop    %ebp
80104b41:	c3                   	ret
80104b42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b48:	5b                   	pop    %ebx
    return -1;
80104b49:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104b4e:	5e                   	pop    %esi
80104b4f:	5d                   	pop    %ebp
80104b50:	c3                   	ret
80104b51:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b58:	00 
80104b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104b60 <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
80104b60:	55                   	push   %ebp
80104b61:	89 e5                	mov    %esp,%ebp
80104b63:	53                   	push   %ebx
80104b64:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104b67:	e8 c4 ee ff ff       	call   80103a30 <myproc>
80104b6c:	89 c3                	mov    %eax,%ebx

  num = curproc->tf->eax;
80104b6e:	8b 40 18             	mov    0x18(%eax),%eax
80104b71:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104b74:	8d 50 ff             	lea    -0x1(%eax),%edx
80104b77:	83 fa 14             	cmp    $0x14,%edx
80104b7a:	77 24                	ja     80104ba0 <syscall+0x40>
80104b7c:	8b 14 85 40 7b 10 80 	mov    -0x7fef84c0(,%eax,4),%edx
80104b83:	85 d2                	test   %edx,%edx
80104b85:	74 19                	je     80104ba0 <syscall+0x40>
    curproc->tf->eax = syscalls[num]();
80104b87:	ff d2                	call   *%edx
80104b89:	89 c2                	mov    %eax,%edx
80104b8b:	8b 43 18             	mov    0x18(%ebx),%eax
80104b8e:	89 50 1c             	mov    %edx,0x1c(%eax)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104b91:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b94:	c9                   	leave
80104b95:	c3                   	ret
80104b96:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b9d:	00 
80104b9e:	66 90                	xchg   %ax,%ax
    cprintf("%d %s: unknown sys call %d\n",
80104ba0:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104ba1:	8d 43 6c             	lea    0x6c(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104ba4:	50                   	push   %eax
80104ba5:	ff 73 10             	push   0x10(%ebx)
80104ba8:	68 b1 75 10 80       	push   $0x801075b1
80104bad:	e8 8e bb ff ff       	call   80100740 <cprintf>
    curproc->tf->eax = -1;
80104bb2:	8b 43 18             	mov    0x18(%ebx),%eax
80104bb5:	83 c4 10             	add    $0x10,%esp
80104bb8:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104bbf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104bc2:	c9                   	leave
80104bc3:	c3                   	ret
80104bc4:	66 90                	xchg   %ax,%ax
80104bc6:	66 90                	xchg   %ax,%ax
80104bc8:	66 90                	xchg   %ax,%ax
80104bca:	66 90                	xchg   %ax,%ax
80104bcc:	66 90                	xchg   %ax,%ax
80104bce:	66 90                	xchg   %ax,%ax

80104bd0 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104bd0:	55                   	push   %ebp
80104bd1:	89 e5                	mov    %esp,%ebp
80104bd3:	57                   	push   %edi
80104bd4:	56                   	push   %esi
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104bd5:	8d 7d da             	lea    -0x26(%ebp),%edi
{
80104bd8:	53                   	push   %ebx
80104bd9:	83 ec 34             	sub    $0x34,%esp
80104bdc:	89 4d d0             	mov    %ecx,-0x30(%ebp)
80104bdf:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104be2:	89 55 d4             	mov    %edx,-0x2c(%ebp)
80104be5:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104be8:	57                   	push   %edi
80104be9:	50                   	push   %eax
80104bea:	e8 81 d5 ff ff       	call   80102170 <nameiparent>
80104bef:	83 c4 10             	add    $0x10,%esp
80104bf2:	85 c0                	test   %eax,%eax
80104bf4:	74 5e                	je     80104c54 <create+0x84>
    return 0;
  ilock(dp);
80104bf6:	83 ec 0c             	sub    $0xc,%esp
80104bf9:	89 c3                	mov    %eax,%ebx
80104bfb:	50                   	push   %eax
80104bfc:	e8 6f cc ff ff       	call   80101870 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
80104c01:	83 c4 0c             	add    $0xc,%esp
80104c04:	6a 00                	push   $0x0
80104c06:	57                   	push   %edi
80104c07:	53                   	push   %ebx
80104c08:	e8 b3 d1 ff ff       	call   80101dc0 <dirlookup>
80104c0d:	83 c4 10             	add    $0x10,%esp
80104c10:	89 c6                	mov    %eax,%esi
80104c12:	85 c0                	test   %eax,%eax
80104c14:	74 4a                	je     80104c60 <create+0x90>
    iunlockput(dp);
80104c16:	83 ec 0c             	sub    $0xc,%esp
80104c19:	53                   	push   %ebx
80104c1a:	e8 e1 ce ff ff       	call   80101b00 <iunlockput>
    ilock(ip);
80104c1f:	89 34 24             	mov    %esi,(%esp)
80104c22:	e8 49 cc ff ff       	call   80101870 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104c27:	83 c4 10             	add    $0x10,%esp
80104c2a:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80104c2f:	75 17                	jne    80104c48 <create+0x78>
80104c31:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
80104c36:	75 10                	jne    80104c48 <create+0x78>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104c38:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c3b:	89 f0                	mov    %esi,%eax
80104c3d:	5b                   	pop    %ebx
80104c3e:	5e                   	pop    %esi
80104c3f:	5f                   	pop    %edi
80104c40:	5d                   	pop    %ebp
80104c41:	c3                   	ret
80104c42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(ip);
80104c48:	83 ec 0c             	sub    $0xc,%esp
80104c4b:	56                   	push   %esi
80104c4c:	e8 af ce ff ff       	call   80101b00 <iunlockput>
    return 0;
80104c51:	83 c4 10             	add    $0x10,%esp
}
80104c54:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80104c57:	31 f6                	xor    %esi,%esi
}
80104c59:	5b                   	pop    %ebx
80104c5a:	89 f0                	mov    %esi,%eax
80104c5c:	5e                   	pop    %esi
80104c5d:	5f                   	pop    %edi
80104c5e:	5d                   	pop    %ebp
80104c5f:	c3                   	ret
  if((ip = ialloc(dp->dev, type)) == 0)
80104c60:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80104c64:	83 ec 08             	sub    $0x8,%esp
80104c67:	50                   	push   %eax
80104c68:	ff 33                	push   (%ebx)
80104c6a:	e8 91 ca ff ff       	call   80101700 <ialloc>
80104c6f:	83 c4 10             	add    $0x10,%esp
80104c72:	89 c6                	mov    %eax,%esi
80104c74:	85 c0                	test   %eax,%eax
80104c76:	0f 84 bc 00 00 00    	je     80104d38 <create+0x168>
  ilock(ip);
80104c7c:	83 ec 0c             	sub    $0xc,%esp
80104c7f:	50                   	push   %eax
80104c80:	e8 eb cb ff ff       	call   80101870 <ilock>
  ip->major = major;
80104c85:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80104c89:	66 89 46 52          	mov    %ax,0x52(%esi)
  ip->minor = minor;
80104c8d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80104c91:	66 89 46 54          	mov    %ax,0x54(%esi)
  ip->nlink = 1;
80104c95:	b8 01 00 00 00       	mov    $0x1,%eax
80104c9a:	66 89 46 56          	mov    %ax,0x56(%esi)
  iupdate(ip);
80104c9e:	89 34 24             	mov    %esi,(%esp)
80104ca1:	e8 1a cb ff ff       	call   801017c0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104ca6:	83 c4 10             	add    $0x10,%esp
80104ca9:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80104cae:	74 30                	je     80104ce0 <create+0x110>
  if(dirlink(dp, name, ip->inum) < 0)
80104cb0:	83 ec 04             	sub    $0x4,%esp
80104cb3:	ff 76 04             	push   0x4(%esi)
80104cb6:	57                   	push   %edi
80104cb7:	53                   	push   %ebx
80104cb8:	e8 d3 d3 ff ff       	call   80102090 <dirlink>
80104cbd:	83 c4 10             	add    $0x10,%esp
80104cc0:	85 c0                	test   %eax,%eax
80104cc2:	78 67                	js     80104d2b <create+0x15b>
  iunlockput(dp);
80104cc4:	83 ec 0c             	sub    $0xc,%esp
80104cc7:	53                   	push   %ebx
80104cc8:	e8 33 ce ff ff       	call   80101b00 <iunlockput>
  return ip;
80104ccd:	83 c4 10             	add    $0x10,%esp
}
80104cd0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104cd3:	89 f0                	mov    %esi,%eax
80104cd5:	5b                   	pop    %ebx
80104cd6:	5e                   	pop    %esi
80104cd7:	5f                   	pop    %edi
80104cd8:	5d                   	pop    %ebp
80104cd9:	c3                   	ret
80104cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iupdate(dp);
80104ce0:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink++;  // for ".."
80104ce3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104ce8:	53                   	push   %ebx
80104ce9:	e8 d2 ca ff ff       	call   801017c0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104cee:	83 c4 0c             	add    $0xc,%esp
80104cf1:	ff 76 04             	push   0x4(%esi)
80104cf4:	68 e9 75 10 80       	push   $0x801075e9
80104cf9:	56                   	push   %esi
80104cfa:	e8 91 d3 ff ff       	call   80102090 <dirlink>
80104cff:	83 c4 10             	add    $0x10,%esp
80104d02:	85 c0                	test   %eax,%eax
80104d04:	78 18                	js     80104d1e <create+0x14e>
80104d06:	83 ec 04             	sub    $0x4,%esp
80104d09:	ff 73 04             	push   0x4(%ebx)
80104d0c:	68 e8 75 10 80       	push   $0x801075e8
80104d11:	56                   	push   %esi
80104d12:	e8 79 d3 ff ff       	call   80102090 <dirlink>
80104d17:	83 c4 10             	add    $0x10,%esp
80104d1a:	85 c0                	test   %eax,%eax
80104d1c:	79 92                	jns    80104cb0 <create+0xe0>
      panic("create dots");
80104d1e:	83 ec 0c             	sub    $0xc,%esp
80104d21:	68 dc 75 10 80       	push   $0x801075dc
80104d26:	e8 55 b6 ff ff       	call   80100380 <panic>
    panic("create: dirlink");
80104d2b:	83 ec 0c             	sub    $0xc,%esp
80104d2e:	68 eb 75 10 80       	push   $0x801075eb
80104d33:	e8 48 b6 ff ff       	call   80100380 <panic>
    panic("create: ialloc");
80104d38:	83 ec 0c             	sub    $0xc,%esp
80104d3b:	68 cd 75 10 80       	push   $0x801075cd
80104d40:	e8 3b b6 ff ff       	call   80100380 <panic>
80104d45:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d4c:	00 
80104d4d:	8d 76 00             	lea    0x0(%esi),%esi

80104d50 <sys_dup>:
{
80104d50:	55                   	push   %ebp
80104d51:	89 e5                	mov    %esp,%ebp
80104d53:	56                   	push   %esi
80104d54:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104d55:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80104d58:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104d5b:	50                   	push   %eax
80104d5c:	6a 00                	push   $0x0
80104d5e:	e8 bd fc ff ff       	call   80104a20 <argint>
80104d63:	83 c4 10             	add    $0x10,%esp
80104d66:	85 c0                	test   %eax,%eax
80104d68:	78 36                	js     80104da0 <sys_dup+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104d6a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104d6e:	77 30                	ja     80104da0 <sys_dup+0x50>
80104d70:	e8 bb ec ff ff       	call   80103a30 <myproc>
80104d75:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104d78:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104d7c:	85 f6                	test   %esi,%esi
80104d7e:	74 20                	je     80104da0 <sys_dup+0x50>
  struct proc *curproc = myproc();
80104d80:	e8 ab ec ff ff       	call   80103a30 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
80104d85:	31 db                	xor    %ebx,%ebx
80104d87:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d8e:	00 
80104d8f:	90                   	nop
    if(curproc->ofile[fd] == 0){
80104d90:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80104d94:	85 d2                	test   %edx,%edx
80104d96:	74 18                	je     80104db0 <sys_dup+0x60>
  for(fd = 0; fd < NOFILE; fd++){
80104d98:	83 c3 01             	add    $0x1,%ebx
80104d9b:	83 fb 10             	cmp    $0x10,%ebx
80104d9e:	75 f0                	jne    80104d90 <sys_dup+0x40>
}
80104da0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
80104da3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
80104da8:	89 d8                	mov    %ebx,%eax
80104daa:	5b                   	pop    %ebx
80104dab:	5e                   	pop    %esi
80104dac:	5d                   	pop    %ebp
80104dad:	c3                   	ret
80104dae:	66 90                	xchg   %ax,%ax
  filedup(f);
80104db0:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80104db3:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
80104db7:	56                   	push   %esi
80104db8:	e8 d3 c1 ff ff       	call   80100f90 <filedup>
  return fd;
80104dbd:	83 c4 10             	add    $0x10,%esp
}
80104dc0:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104dc3:	89 d8                	mov    %ebx,%eax
80104dc5:	5b                   	pop    %ebx
80104dc6:	5e                   	pop    %esi
80104dc7:	5d                   	pop    %ebp
80104dc8:	c3                   	ret
80104dc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104dd0 <sys_read>:
{
80104dd0:	55                   	push   %ebp
80104dd1:	89 e5                	mov    %esp,%ebp
80104dd3:	56                   	push   %esi
80104dd4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104dd5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104dd8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104ddb:	53                   	push   %ebx
80104ddc:	6a 00                	push   $0x0
80104dde:	e8 3d fc ff ff       	call   80104a20 <argint>
80104de3:	83 c4 10             	add    $0x10,%esp
80104de6:	85 c0                	test   %eax,%eax
80104de8:	78 5e                	js     80104e48 <sys_read+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104dea:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104dee:	77 58                	ja     80104e48 <sys_read+0x78>
80104df0:	e8 3b ec ff ff       	call   80103a30 <myproc>
80104df5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104df8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104dfc:	85 f6                	test   %esi,%esi
80104dfe:	74 48                	je     80104e48 <sys_read+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e00:	83 ec 08             	sub    $0x8,%esp
80104e03:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e06:	50                   	push   %eax
80104e07:	6a 02                	push   $0x2
80104e09:	e8 12 fc ff ff       	call   80104a20 <argint>
80104e0e:	83 c4 10             	add    $0x10,%esp
80104e11:	85 c0                	test   %eax,%eax
80104e13:	78 33                	js     80104e48 <sys_read+0x78>
80104e15:	83 ec 04             	sub    $0x4,%esp
80104e18:	ff 75 f0             	push   -0x10(%ebp)
80104e1b:	53                   	push   %ebx
80104e1c:	6a 01                	push   $0x1
80104e1e:	e8 4d fc ff ff       	call   80104a70 <argptr>
80104e23:	83 c4 10             	add    $0x10,%esp
80104e26:	85 c0                	test   %eax,%eax
80104e28:	78 1e                	js     80104e48 <sys_read+0x78>
  return fileread(f, p, n);
80104e2a:	83 ec 04             	sub    $0x4,%esp
80104e2d:	ff 75 f0             	push   -0x10(%ebp)
80104e30:	ff 75 f4             	push   -0xc(%ebp)
80104e33:	56                   	push   %esi
80104e34:	e8 d7 c2 ff ff       	call   80101110 <fileread>
80104e39:	83 c4 10             	add    $0x10,%esp
}
80104e3c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e3f:	5b                   	pop    %ebx
80104e40:	5e                   	pop    %esi
80104e41:	5d                   	pop    %ebp
80104e42:	c3                   	ret
80104e43:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80104e48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104e4d:	eb ed                	jmp    80104e3c <sys_read+0x6c>
80104e4f:	90                   	nop

80104e50 <sys_write>:
{
80104e50:	55                   	push   %ebp
80104e51:	89 e5                	mov    %esp,%ebp
80104e53:	56                   	push   %esi
80104e54:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104e55:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104e58:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104e5b:	53                   	push   %ebx
80104e5c:	6a 00                	push   $0x0
80104e5e:	e8 bd fb ff ff       	call   80104a20 <argint>
80104e63:	83 c4 10             	add    $0x10,%esp
80104e66:	85 c0                	test   %eax,%eax
80104e68:	78 5e                	js     80104ec8 <sys_write+0x78>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104e6a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104e6e:	77 58                	ja     80104ec8 <sys_write+0x78>
80104e70:	e8 bb eb ff ff       	call   80103a30 <myproc>
80104e75:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104e78:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104e7c:	85 f6                	test   %esi,%esi
80104e7e:	74 48                	je     80104ec8 <sys_write+0x78>
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80104e80:	83 ec 08             	sub    $0x8,%esp
80104e83:	8d 45 f0             	lea    -0x10(%ebp),%eax
80104e86:	50                   	push   %eax
80104e87:	6a 02                	push   $0x2
80104e89:	e8 92 fb ff ff       	call   80104a20 <argint>
80104e8e:	83 c4 10             	add    $0x10,%esp
80104e91:	85 c0                	test   %eax,%eax
80104e93:	78 33                	js     80104ec8 <sys_write+0x78>
80104e95:	83 ec 04             	sub    $0x4,%esp
80104e98:	ff 75 f0             	push   -0x10(%ebp)
80104e9b:	53                   	push   %ebx
80104e9c:	6a 01                	push   $0x1
80104e9e:	e8 cd fb ff ff       	call   80104a70 <argptr>
80104ea3:	83 c4 10             	add    $0x10,%esp
80104ea6:	85 c0                	test   %eax,%eax
80104ea8:	78 1e                	js     80104ec8 <sys_write+0x78>
  return filewrite(f, p, n);
80104eaa:	83 ec 04             	sub    $0x4,%esp
80104ead:	ff 75 f0             	push   -0x10(%ebp)
80104eb0:	ff 75 f4             	push   -0xc(%ebp)
80104eb3:	56                   	push   %esi
80104eb4:	e8 e7 c2 ff ff       	call   801011a0 <filewrite>
80104eb9:	83 c4 10             	add    $0x10,%esp
}
80104ebc:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104ebf:	5b                   	pop    %ebx
80104ec0:	5e                   	pop    %esi
80104ec1:	5d                   	pop    %ebp
80104ec2:	c3                   	ret
80104ec3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    return -1;
80104ec8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104ecd:	eb ed                	jmp    80104ebc <sys_write+0x6c>
80104ecf:	90                   	nop

80104ed0 <sys_close>:
{
80104ed0:	55                   	push   %ebp
80104ed1:	89 e5                	mov    %esp,%ebp
80104ed3:	56                   	push   %esi
80104ed4:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104ed5:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80104ed8:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104edb:	50                   	push   %eax
80104edc:	6a 00                	push   $0x0
80104ede:	e8 3d fb ff ff       	call   80104a20 <argint>
80104ee3:	83 c4 10             	add    $0x10,%esp
80104ee6:	85 c0                	test   %eax,%eax
80104ee8:	78 3e                	js     80104f28 <sys_close+0x58>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104eea:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104eee:	77 38                	ja     80104f28 <sys_close+0x58>
80104ef0:	e8 3b eb ff ff       	call   80103a30 <myproc>
80104ef5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104ef8:	8d 5a 08             	lea    0x8(%edx),%ebx
80104efb:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
80104eff:	85 f6                	test   %esi,%esi
80104f01:	74 25                	je     80104f28 <sys_close+0x58>
  myproc()->ofile[fd] = 0;
80104f03:	e8 28 eb ff ff       	call   80103a30 <myproc>
  fileclose(f);
80104f08:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
80104f0b:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
80104f12:	00 
  fileclose(f);
80104f13:	56                   	push   %esi
80104f14:	e8 c7 c0 ff ff       	call   80100fe0 <fileclose>
  return 0;
80104f19:	83 c4 10             	add    $0x10,%esp
80104f1c:	31 c0                	xor    %eax,%eax
}
80104f1e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f21:	5b                   	pop    %ebx
80104f22:	5e                   	pop    %esi
80104f23:	5d                   	pop    %ebp
80104f24:	c3                   	ret
80104f25:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80104f28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f2d:	eb ef                	jmp    80104f1e <sys_close+0x4e>
80104f2f:	90                   	nop

80104f30 <sys_fstat>:
{
80104f30:	55                   	push   %ebp
80104f31:	89 e5                	mov    %esp,%ebp
80104f33:	56                   	push   %esi
80104f34:	53                   	push   %ebx
  if(argint(n, &fd) < 0)
80104f35:	8d 5d f4             	lea    -0xc(%ebp),%ebx
{
80104f38:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104f3b:	53                   	push   %ebx
80104f3c:	6a 00                	push   $0x0
80104f3e:	e8 dd fa ff ff       	call   80104a20 <argint>
80104f43:	83 c4 10             	add    $0x10,%esp
80104f46:	85 c0                	test   %eax,%eax
80104f48:	78 46                	js     80104f90 <sys_fstat+0x60>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
80104f4a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80104f4e:	77 40                	ja     80104f90 <sys_fstat+0x60>
80104f50:	e8 db ea ff ff       	call   80103a30 <myproc>
80104f55:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104f58:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
80104f5c:	85 f6                	test   %esi,%esi
80104f5e:	74 30                	je     80104f90 <sys_fstat+0x60>
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
80104f60:	83 ec 04             	sub    $0x4,%esp
80104f63:	6a 14                	push   $0x14
80104f65:	53                   	push   %ebx
80104f66:	6a 01                	push   $0x1
80104f68:	e8 03 fb ff ff       	call   80104a70 <argptr>
80104f6d:	83 c4 10             	add    $0x10,%esp
80104f70:	85 c0                	test   %eax,%eax
80104f72:	78 1c                	js     80104f90 <sys_fstat+0x60>
  return filestat(f, st);
80104f74:	83 ec 08             	sub    $0x8,%esp
80104f77:	ff 75 f4             	push   -0xc(%ebp)
80104f7a:	56                   	push   %esi
80104f7b:	e8 40 c1 ff ff       	call   801010c0 <filestat>
80104f80:	83 c4 10             	add    $0x10,%esp
}
80104f83:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104f86:	5b                   	pop    %ebx
80104f87:	5e                   	pop    %esi
80104f88:	5d                   	pop    %ebp
80104f89:	c3                   	ret
80104f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80104f90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104f95:	eb ec                	jmp    80104f83 <sys_fstat+0x53>
80104f97:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f9e:	00 
80104f9f:	90                   	nop

80104fa0 <sys_link>:
{
80104fa0:	55                   	push   %ebp
80104fa1:	89 e5                	mov    %esp,%ebp
80104fa3:	57                   	push   %edi
80104fa4:	56                   	push   %esi
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104fa5:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80104fa8:	53                   	push   %ebx
80104fa9:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80104fac:	50                   	push   %eax
80104fad:	6a 00                	push   $0x0
80104faf:	e8 2c fb ff ff       	call   80104ae0 <argstr>
80104fb4:	83 c4 10             	add    $0x10,%esp
80104fb7:	85 c0                	test   %eax,%eax
80104fb9:	0f 88 fb 00 00 00    	js     801050ba <sys_link+0x11a>
80104fbf:	83 ec 08             	sub    $0x8,%esp
80104fc2:	8d 45 d0             	lea    -0x30(%ebp),%eax
80104fc5:	50                   	push   %eax
80104fc6:	6a 01                	push   $0x1
80104fc8:	e8 13 fb ff ff       	call   80104ae0 <argstr>
80104fcd:	83 c4 10             	add    $0x10,%esp
80104fd0:	85 c0                	test   %eax,%eax
80104fd2:	0f 88 e2 00 00 00    	js     801050ba <sys_link+0x11a>
  begin_op();
80104fd8:	e8 33 de ff ff       	call   80102e10 <begin_op>
  if((ip = namei(old)) == 0){
80104fdd:	83 ec 0c             	sub    $0xc,%esp
80104fe0:	ff 75 d4             	push   -0x2c(%ebp)
80104fe3:	e8 68 d1 ff ff       	call   80102150 <namei>
80104fe8:	83 c4 10             	add    $0x10,%esp
80104feb:	89 c3                	mov    %eax,%ebx
80104fed:	85 c0                	test   %eax,%eax
80104fef:	0f 84 df 00 00 00    	je     801050d4 <sys_link+0x134>
  ilock(ip);
80104ff5:	83 ec 0c             	sub    $0xc,%esp
80104ff8:	50                   	push   %eax
80104ff9:	e8 72 c8 ff ff       	call   80101870 <ilock>
  if(ip->type == T_DIR){
80104ffe:	83 c4 10             	add    $0x10,%esp
80105001:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105006:	0f 84 b5 00 00 00    	je     801050c1 <sys_link+0x121>
  iupdate(ip);
8010500c:	83 ec 0c             	sub    $0xc,%esp
  ip->nlink++;
8010500f:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  if((dp = nameiparent(new, name)) == 0)
80105014:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
80105017:	53                   	push   %ebx
80105018:	e8 a3 c7 ff ff       	call   801017c0 <iupdate>
  iunlock(ip);
8010501d:	89 1c 24             	mov    %ebx,(%esp)
80105020:	e8 2b c9 ff ff       	call   80101950 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
80105025:	58                   	pop    %eax
80105026:	5a                   	pop    %edx
80105027:	57                   	push   %edi
80105028:	ff 75 d0             	push   -0x30(%ebp)
8010502b:	e8 40 d1 ff ff       	call   80102170 <nameiparent>
80105030:	83 c4 10             	add    $0x10,%esp
80105033:	89 c6                	mov    %eax,%esi
80105035:	85 c0                	test   %eax,%eax
80105037:	74 5b                	je     80105094 <sys_link+0xf4>
  ilock(dp);
80105039:	83 ec 0c             	sub    $0xc,%esp
8010503c:	50                   	push   %eax
8010503d:	e8 2e c8 ff ff       	call   80101870 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80105042:	8b 03                	mov    (%ebx),%eax
80105044:	83 c4 10             	add    $0x10,%esp
80105047:	39 06                	cmp    %eax,(%esi)
80105049:	75 3d                	jne    80105088 <sys_link+0xe8>
8010504b:	83 ec 04             	sub    $0x4,%esp
8010504e:	ff 73 04             	push   0x4(%ebx)
80105051:	57                   	push   %edi
80105052:	56                   	push   %esi
80105053:	e8 38 d0 ff ff       	call   80102090 <dirlink>
80105058:	83 c4 10             	add    $0x10,%esp
8010505b:	85 c0                	test   %eax,%eax
8010505d:	78 29                	js     80105088 <sys_link+0xe8>
  iunlockput(dp);
8010505f:	83 ec 0c             	sub    $0xc,%esp
80105062:	56                   	push   %esi
80105063:	e8 98 ca ff ff       	call   80101b00 <iunlockput>
  iput(ip);
80105068:	89 1c 24             	mov    %ebx,(%esp)
8010506b:	e8 30 c9 ff ff       	call   801019a0 <iput>
  end_op();
80105070:	e8 0b de ff ff       	call   80102e80 <end_op>
  return 0;
80105075:	83 c4 10             	add    $0x10,%esp
80105078:	31 c0                	xor    %eax,%eax
}
8010507a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010507d:	5b                   	pop    %ebx
8010507e:	5e                   	pop    %esi
8010507f:	5f                   	pop    %edi
80105080:	5d                   	pop    %ebp
80105081:	c3                   	ret
80105082:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105088:	83 ec 0c             	sub    $0xc,%esp
8010508b:	56                   	push   %esi
8010508c:	e8 6f ca ff ff       	call   80101b00 <iunlockput>
    goto bad;
80105091:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105094:	83 ec 0c             	sub    $0xc,%esp
80105097:	53                   	push   %ebx
80105098:	e8 d3 c7 ff ff       	call   80101870 <ilock>
  ip->nlink--;
8010509d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801050a2:	89 1c 24             	mov    %ebx,(%esp)
801050a5:	e8 16 c7 ff ff       	call   801017c0 <iupdate>
  iunlockput(ip);
801050aa:	89 1c 24             	mov    %ebx,(%esp)
801050ad:	e8 4e ca ff ff       	call   80101b00 <iunlockput>
  end_op();
801050b2:	e8 c9 dd ff ff       	call   80102e80 <end_op>
  return -1;
801050b7:	83 c4 10             	add    $0x10,%esp
    return -1;
801050ba:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801050bf:	eb b9                	jmp    8010507a <sys_link+0xda>
    iunlockput(ip);
801050c1:	83 ec 0c             	sub    $0xc,%esp
801050c4:	53                   	push   %ebx
801050c5:	e8 36 ca ff ff       	call   80101b00 <iunlockput>
    end_op();
801050ca:	e8 b1 dd ff ff       	call   80102e80 <end_op>
    return -1;
801050cf:	83 c4 10             	add    $0x10,%esp
801050d2:	eb e6                	jmp    801050ba <sys_link+0x11a>
    end_op();
801050d4:	e8 a7 dd ff ff       	call   80102e80 <end_op>
    return -1;
801050d9:	eb df                	jmp    801050ba <sys_link+0x11a>
801050db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801050e0 <sys_unlink>:
{
801050e0:	55                   	push   %ebp
801050e1:	89 e5                	mov    %esp,%ebp
801050e3:	57                   	push   %edi
801050e4:	56                   	push   %esi
  if(argstr(0, &path) < 0)
801050e5:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
801050e8:	53                   	push   %ebx
801050e9:	83 ec 54             	sub    $0x54,%esp
  if(argstr(0, &path) < 0)
801050ec:	50                   	push   %eax
801050ed:	6a 00                	push   $0x0
801050ef:	e8 ec f9 ff ff       	call   80104ae0 <argstr>
801050f4:	83 c4 10             	add    $0x10,%esp
801050f7:	85 c0                	test   %eax,%eax
801050f9:	0f 88 54 01 00 00    	js     80105253 <sys_unlink+0x173>
  begin_op();
801050ff:	e8 0c dd ff ff       	call   80102e10 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80105104:	8d 5d ca             	lea    -0x36(%ebp),%ebx
80105107:	83 ec 08             	sub    $0x8,%esp
8010510a:	53                   	push   %ebx
8010510b:	ff 75 c0             	push   -0x40(%ebp)
8010510e:	e8 5d d0 ff ff       	call   80102170 <nameiparent>
80105113:	83 c4 10             	add    $0x10,%esp
80105116:	89 45 b4             	mov    %eax,-0x4c(%ebp)
80105119:	85 c0                	test   %eax,%eax
8010511b:	0f 84 58 01 00 00    	je     80105279 <sys_unlink+0x199>
  ilock(dp);
80105121:	8b 7d b4             	mov    -0x4c(%ebp),%edi
80105124:	83 ec 0c             	sub    $0xc,%esp
80105127:	57                   	push   %edi
80105128:	e8 43 c7 ff ff       	call   80101870 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
8010512d:	58                   	pop    %eax
8010512e:	5a                   	pop    %edx
8010512f:	68 e9 75 10 80       	push   $0x801075e9
80105134:	53                   	push   %ebx
80105135:	e8 66 cc ff ff       	call   80101da0 <namecmp>
8010513a:	83 c4 10             	add    $0x10,%esp
8010513d:	85 c0                	test   %eax,%eax
8010513f:	0f 84 fb 00 00 00    	je     80105240 <sys_unlink+0x160>
80105145:	83 ec 08             	sub    $0x8,%esp
80105148:	68 e8 75 10 80       	push   $0x801075e8
8010514d:	53                   	push   %ebx
8010514e:	e8 4d cc ff ff       	call   80101da0 <namecmp>
80105153:	83 c4 10             	add    $0x10,%esp
80105156:	85 c0                	test   %eax,%eax
80105158:	0f 84 e2 00 00 00    	je     80105240 <sys_unlink+0x160>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010515e:	83 ec 04             	sub    $0x4,%esp
80105161:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105164:	50                   	push   %eax
80105165:	53                   	push   %ebx
80105166:	57                   	push   %edi
80105167:	e8 54 cc ff ff       	call   80101dc0 <dirlookup>
8010516c:	83 c4 10             	add    $0x10,%esp
8010516f:	89 c3                	mov    %eax,%ebx
80105171:	85 c0                	test   %eax,%eax
80105173:	0f 84 c7 00 00 00    	je     80105240 <sys_unlink+0x160>
  ilock(ip);
80105179:	83 ec 0c             	sub    $0xc,%esp
8010517c:	50                   	push   %eax
8010517d:	e8 ee c6 ff ff       	call   80101870 <ilock>
  if(ip->nlink < 1)
80105182:	83 c4 10             	add    $0x10,%esp
80105185:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010518a:	0f 8e 0a 01 00 00    	jle    8010529a <sys_unlink+0x1ba>
  if(ip->type == T_DIR && !isdirempty(ip)){
80105190:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105195:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105198:	74 66                	je     80105200 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
8010519a:	83 ec 04             	sub    $0x4,%esp
8010519d:	6a 10                	push   $0x10
8010519f:	6a 00                	push   $0x0
801051a1:	57                   	push   %edi
801051a2:	e8 c9 f5 ff ff       	call   80104770 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801051a7:	6a 10                	push   $0x10
801051a9:	ff 75 c4             	push   -0x3c(%ebp)
801051ac:	57                   	push   %edi
801051ad:	ff 75 b4             	push   -0x4c(%ebp)
801051b0:	e8 cb ca ff ff       	call   80101c80 <writei>
801051b5:	83 c4 20             	add    $0x20,%esp
801051b8:	83 f8 10             	cmp    $0x10,%eax
801051bb:	0f 85 cc 00 00 00    	jne    8010528d <sys_unlink+0x1ad>
  if(ip->type == T_DIR){
801051c1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801051c6:	0f 84 94 00 00 00    	je     80105260 <sys_unlink+0x180>
  iunlockput(dp);
801051cc:	83 ec 0c             	sub    $0xc,%esp
801051cf:	ff 75 b4             	push   -0x4c(%ebp)
801051d2:	e8 29 c9 ff ff       	call   80101b00 <iunlockput>
  ip->nlink--;
801051d7:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
801051dc:	89 1c 24             	mov    %ebx,(%esp)
801051df:	e8 dc c5 ff ff       	call   801017c0 <iupdate>
  iunlockput(ip);
801051e4:	89 1c 24             	mov    %ebx,(%esp)
801051e7:	e8 14 c9 ff ff       	call   80101b00 <iunlockput>
  end_op();
801051ec:	e8 8f dc ff ff       	call   80102e80 <end_op>
  return 0;
801051f1:	83 c4 10             	add    $0x10,%esp
801051f4:	31 c0                	xor    %eax,%eax
}
801051f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801051f9:	5b                   	pop    %ebx
801051fa:	5e                   	pop    %esi
801051fb:	5f                   	pop    %edi
801051fc:	5d                   	pop    %ebp
801051fd:	c3                   	ret
801051fe:	66 90                	xchg   %ax,%ax
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80105200:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
80105204:	76 94                	jbe    8010519a <sys_unlink+0xba>
80105206:	be 20 00 00 00       	mov    $0x20,%esi
8010520b:	eb 0b                	jmp    80105218 <sys_unlink+0x138>
8010520d:	8d 76 00             	lea    0x0(%esi),%esi
80105210:	83 c6 10             	add    $0x10,%esi
80105213:	3b 73 58             	cmp    0x58(%ebx),%esi
80105216:	73 82                	jae    8010519a <sys_unlink+0xba>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105218:	6a 10                	push   $0x10
8010521a:	56                   	push   %esi
8010521b:	57                   	push   %edi
8010521c:	53                   	push   %ebx
8010521d:	e8 5e c9 ff ff       	call   80101b80 <readi>
80105222:	83 c4 10             	add    $0x10,%esp
80105225:	83 f8 10             	cmp    $0x10,%eax
80105228:	75 56                	jne    80105280 <sys_unlink+0x1a0>
    if(de.inum != 0)
8010522a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010522f:	74 df                	je     80105210 <sys_unlink+0x130>
    iunlockput(ip);
80105231:	83 ec 0c             	sub    $0xc,%esp
80105234:	53                   	push   %ebx
80105235:	e8 c6 c8 ff ff       	call   80101b00 <iunlockput>
    goto bad;
8010523a:	83 c4 10             	add    $0x10,%esp
8010523d:	8d 76 00             	lea    0x0(%esi),%esi
  iunlockput(dp);
80105240:	83 ec 0c             	sub    $0xc,%esp
80105243:	ff 75 b4             	push   -0x4c(%ebp)
80105246:	e8 b5 c8 ff ff       	call   80101b00 <iunlockput>
  end_op();
8010524b:	e8 30 dc ff ff       	call   80102e80 <end_op>
  return -1;
80105250:	83 c4 10             	add    $0x10,%esp
    return -1;
80105253:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105258:	eb 9c                	jmp    801051f6 <sys_unlink+0x116>
8010525a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    dp->nlink--;
80105260:	8b 45 b4             	mov    -0x4c(%ebp),%eax
    iupdate(dp);
80105263:	83 ec 0c             	sub    $0xc,%esp
    dp->nlink--;
80105266:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
    iupdate(dp);
8010526b:	50                   	push   %eax
8010526c:	e8 4f c5 ff ff       	call   801017c0 <iupdate>
80105271:	83 c4 10             	add    $0x10,%esp
80105274:	e9 53 ff ff ff       	jmp    801051cc <sys_unlink+0xec>
    end_op();
80105279:	e8 02 dc ff ff       	call   80102e80 <end_op>
    return -1;
8010527e:	eb d3                	jmp    80105253 <sys_unlink+0x173>
      panic("isdirempty: readi");
80105280:	83 ec 0c             	sub    $0xc,%esp
80105283:	68 0d 76 10 80       	push   $0x8010760d
80105288:	e8 f3 b0 ff ff       	call   80100380 <panic>
    panic("unlink: writei");
8010528d:	83 ec 0c             	sub    $0xc,%esp
80105290:	68 1f 76 10 80       	push   $0x8010761f
80105295:	e8 e6 b0 ff ff       	call   80100380 <panic>
    panic("unlink: nlink < 1");
8010529a:	83 ec 0c             	sub    $0xc,%esp
8010529d:	68 fb 75 10 80       	push   $0x801075fb
801052a2:	e8 d9 b0 ff ff       	call   80100380 <panic>
801052a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801052ae:	00 
801052af:	90                   	nop

801052b0 <sys_open>:

int
sys_open(void)
{
801052b0:	55                   	push   %ebp
801052b1:	89 e5                	mov    %esp,%ebp
801052b3:	57                   	push   %edi
801052b4:	56                   	push   %esi
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801052b5:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
801052b8:	53                   	push   %ebx
801052b9:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
801052bc:	50                   	push   %eax
801052bd:	6a 00                	push   $0x0
801052bf:	e8 1c f8 ff ff       	call   80104ae0 <argstr>
801052c4:	83 c4 10             	add    $0x10,%esp
801052c7:	85 c0                	test   %eax,%eax
801052c9:	0f 88 8e 00 00 00    	js     8010535d <sys_open+0xad>
801052cf:	83 ec 08             	sub    $0x8,%esp
801052d2:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801052d5:	50                   	push   %eax
801052d6:	6a 01                	push   $0x1
801052d8:	e8 43 f7 ff ff       	call   80104a20 <argint>
801052dd:	83 c4 10             	add    $0x10,%esp
801052e0:	85 c0                	test   %eax,%eax
801052e2:	78 79                	js     8010535d <sys_open+0xad>
    return -1;

  begin_op();
801052e4:	e8 27 db ff ff       	call   80102e10 <begin_op>

  if(omode & O_CREATE){
801052e9:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801052ed:	75 79                	jne    80105368 <sys_open+0xb8>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801052ef:	83 ec 0c             	sub    $0xc,%esp
801052f2:	ff 75 e0             	push   -0x20(%ebp)
801052f5:	e8 56 ce ff ff       	call   80102150 <namei>
801052fa:	83 c4 10             	add    $0x10,%esp
801052fd:	89 c6                	mov    %eax,%esi
801052ff:	85 c0                	test   %eax,%eax
80105301:	0f 84 7e 00 00 00    	je     80105385 <sys_open+0xd5>
      end_op();
      return -1;
    }
    ilock(ip);
80105307:	83 ec 0c             	sub    $0xc,%esp
8010530a:	50                   	push   %eax
8010530b:	e8 60 c5 ff ff       	call   80101870 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
80105310:	83 c4 10             	add    $0x10,%esp
80105313:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105318:	0f 84 ba 00 00 00    	je     801053d8 <sys_open+0x128>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010531e:	e8 fd bb ff ff       	call   80100f20 <filealloc>
80105323:	89 c7                	mov    %eax,%edi
80105325:	85 c0                	test   %eax,%eax
80105327:	74 23                	je     8010534c <sys_open+0x9c>
  struct proc *curproc = myproc();
80105329:	e8 02 e7 ff ff       	call   80103a30 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
8010532e:	31 db                	xor    %ebx,%ebx
    if(curproc->ofile[fd] == 0){
80105330:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105334:	85 d2                	test   %edx,%edx
80105336:	74 58                	je     80105390 <sys_open+0xe0>
  for(fd = 0; fd < NOFILE; fd++){
80105338:	83 c3 01             	add    $0x1,%ebx
8010533b:	83 fb 10             	cmp    $0x10,%ebx
8010533e:	75 f0                	jne    80105330 <sys_open+0x80>
    if(f)
      fileclose(f);
80105340:	83 ec 0c             	sub    $0xc,%esp
80105343:	57                   	push   %edi
80105344:	e8 97 bc ff ff       	call   80100fe0 <fileclose>
80105349:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
8010534c:	83 ec 0c             	sub    $0xc,%esp
8010534f:	56                   	push   %esi
80105350:	e8 ab c7 ff ff       	call   80101b00 <iunlockput>
    end_op();
80105355:	e8 26 db ff ff       	call   80102e80 <end_op>
    return -1;
8010535a:	83 c4 10             	add    $0x10,%esp
    return -1;
8010535d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105362:	eb 65                	jmp    801053c9 <sys_open+0x119>
80105364:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ip = create(path, T_FILE, 0, 0);
80105368:	83 ec 0c             	sub    $0xc,%esp
8010536b:	31 c9                	xor    %ecx,%ecx
8010536d:	ba 02 00 00 00       	mov    $0x2,%edx
80105372:	6a 00                	push   $0x0
80105374:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105377:	e8 54 f8 ff ff       	call   80104bd0 <create>
    if(ip == 0){
8010537c:	83 c4 10             	add    $0x10,%esp
    ip = create(path, T_FILE, 0, 0);
8010537f:	89 c6                	mov    %eax,%esi
    if(ip == 0){
80105381:	85 c0                	test   %eax,%eax
80105383:	75 99                	jne    8010531e <sys_open+0x6e>
      end_op();
80105385:	e8 f6 da ff ff       	call   80102e80 <end_op>
      return -1;
8010538a:	eb d1                	jmp    8010535d <sys_open+0xad>
8010538c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  }
  iunlock(ip);
80105390:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
80105393:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
80105397:	56                   	push   %esi
80105398:	e8 b3 c5 ff ff       	call   80101950 <iunlock>
  end_op();
8010539d:	e8 de da ff ff       	call   80102e80 <end_op>

  f->type = FD_INODE;
801053a2:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
801053a8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801053ab:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
801053ae:	89 77 10             	mov    %esi,0x10(%edi)
  f->readable = !(omode & O_WRONLY);
801053b1:	89 d0                	mov    %edx,%eax
  f->off = 0;
801053b3:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
801053ba:	f7 d0                	not    %eax
801053bc:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801053bf:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
801053c2:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801053c5:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
801053c9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053cc:	89 d8                	mov    %ebx,%eax
801053ce:	5b                   	pop    %ebx
801053cf:	5e                   	pop    %esi
801053d0:	5f                   	pop    %edi
801053d1:	5d                   	pop    %ebp
801053d2:	c3                   	ret
801053d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
801053d8:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801053db:	85 c9                	test   %ecx,%ecx
801053dd:	0f 84 3b ff ff ff    	je     8010531e <sys_open+0x6e>
801053e3:	e9 64 ff ff ff       	jmp    8010534c <sys_open+0x9c>
801053e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801053ef:	00 

801053f0 <sys_mkdir>:

int
sys_mkdir(void)
{
801053f0:	55                   	push   %ebp
801053f1:	89 e5                	mov    %esp,%ebp
801053f3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801053f6:	e8 15 da ff ff       	call   80102e10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801053fb:	83 ec 08             	sub    $0x8,%esp
801053fe:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105401:	50                   	push   %eax
80105402:	6a 00                	push   $0x0
80105404:	e8 d7 f6 ff ff       	call   80104ae0 <argstr>
80105409:	83 c4 10             	add    $0x10,%esp
8010540c:	85 c0                	test   %eax,%eax
8010540e:	78 30                	js     80105440 <sys_mkdir+0x50>
80105410:	83 ec 0c             	sub    $0xc,%esp
80105413:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105416:	31 c9                	xor    %ecx,%ecx
80105418:	ba 01 00 00 00       	mov    $0x1,%edx
8010541d:	6a 00                	push   $0x0
8010541f:	e8 ac f7 ff ff       	call   80104bd0 <create>
80105424:	83 c4 10             	add    $0x10,%esp
80105427:	85 c0                	test   %eax,%eax
80105429:	74 15                	je     80105440 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010542b:	83 ec 0c             	sub    $0xc,%esp
8010542e:	50                   	push   %eax
8010542f:	e8 cc c6 ff ff       	call   80101b00 <iunlockput>
  end_op();
80105434:	e8 47 da ff ff       	call   80102e80 <end_op>
  return 0;
80105439:	83 c4 10             	add    $0x10,%esp
8010543c:	31 c0                	xor    %eax,%eax
}
8010543e:	c9                   	leave
8010543f:	c3                   	ret
    end_op();
80105440:	e8 3b da ff ff       	call   80102e80 <end_op>
    return -1;
80105445:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010544a:	c9                   	leave
8010544b:	c3                   	ret
8010544c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105450 <sys_mknod>:

int
sys_mknod(void)
{
80105450:	55                   	push   %ebp
80105451:	89 e5                	mov    %esp,%ebp
80105453:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105456:	e8 b5 d9 ff ff       	call   80102e10 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010545b:	83 ec 08             	sub    $0x8,%esp
8010545e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105461:	50                   	push   %eax
80105462:	6a 00                	push   $0x0
80105464:	e8 77 f6 ff ff       	call   80104ae0 <argstr>
80105469:	83 c4 10             	add    $0x10,%esp
8010546c:	85 c0                	test   %eax,%eax
8010546e:	78 60                	js     801054d0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105470:	83 ec 08             	sub    $0x8,%esp
80105473:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105476:	50                   	push   %eax
80105477:	6a 01                	push   $0x1
80105479:	e8 a2 f5 ff ff       	call   80104a20 <argint>
  if((argstr(0, &path)) < 0 ||
8010547e:	83 c4 10             	add    $0x10,%esp
80105481:	85 c0                	test   %eax,%eax
80105483:	78 4b                	js     801054d0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105485:	83 ec 08             	sub    $0x8,%esp
80105488:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010548b:	50                   	push   %eax
8010548c:	6a 02                	push   $0x2
8010548e:	e8 8d f5 ff ff       	call   80104a20 <argint>
     argint(1, &major) < 0 ||
80105493:	83 c4 10             	add    $0x10,%esp
80105496:	85 c0                	test   %eax,%eax
80105498:	78 36                	js     801054d0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010549a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
8010549e:	83 ec 0c             	sub    $0xc,%esp
801054a1:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
801054a5:	ba 03 00 00 00       	mov    $0x3,%edx
801054aa:	50                   	push   %eax
801054ab:	8b 45 ec             	mov    -0x14(%ebp),%eax
801054ae:	e8 1d f7 ff ff       	call   80104bd0 <create>
     argint(2, &minor) < 0 ||
801054b3:	83 c4 10             	add    $0x10,%esp
801054b6:	85 c0                	test   %eax,%eax
801054b8:	74 16                	je     801054d0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
801054ba:	83 ec 0c             	sub    $0xc,%esp
801054bd:	50                   	push   %eax
801054be:	e8 3d c6 ff ff       	call   80101b00 <iunlockput>
  end_op();
801054c3:	e8 b8 d9 ff ff       	call   80102e80 <end_op>
  return 0;
801054c8:	83 c4 10             	add    $0x10,%esp
801054cb:	31 c0                	xor    %eax,%eax
}
801054cd:	c9                   	leave
801054ce:	c3                   	ret
801054cf:	90                   	nop
    end_op();
801054d0:	e8 ab d9 ff ff       	call   80102e80 <end_op>
    return -1;
801054d5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801054da:	c9                   	leave
801054db:	c3                   	ret
801054dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801054e0 <sys_chdir>:

int
sys_chdir(void)
{
801054e0:	55                   	push   %ebp
801054e1:	89 e5                	mov    %esp,%ebp
801054e3:	56                   	push   %esi
801054e4:	53                   	push   %ebx
801054e5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801054e8:	e8 43 e5 ff ff       	call   80103a30 <myproc>
801054ed:	89 c6                	mov    %eax,%esi
  
  begin_op();
801054ef:	e8 1c d9 ff ff       	call   80102e10 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801054f4:	83 ec 08             	sub    $0x8,%esp
801054f7:	8d 45 f4             	lea    -0xc(%ebp),%eax
801054fa:	50                   	push   %eax
801054fb:	6a 00                	push   $0x0
801054fd:	e8 de f5 ff ff       	call   80104ae0 <argstr>
80105502:	83 c4 10             	add    $0x10,%esp
80105505:	85 c0                	test   %eax,%eax
80105507:	78 77                	js     80105580 <sys_chdir+0xa0>
80105509:	83 ec 0c             	sub    $0xc,%esp
8010550c:	ff 75 f4             	push   -0xc(%ebp)
8010550f:	e8 3c cc ff ff       	call   80102150 <namei>
80105514:	83 c4 10             	add    $0x10,%esp
80105517:	89 c3                	mov    %eax,%ebx
80105519:	85 c0                	test   %eax,%eax
8010551b:	74 63                	je     80105580 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
8010551d:	83 ec 0c             	sub    $0xc,%esp
80105520:	50                   	push   %eax
80105521:	e8 4a c3 ff ff       	call   80101870 <ilock>
  if(ip->type != T_DIR){
80105526:	83 c4 10             	add    $0x10,%esp
80105529:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010552e:	75 30                	jne    80105560 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105530:	83 ec 0c             	sub    $0xc,%esp
80105533:	53                   	push   %ebx
80105534:	e8 17 c4 ff ff       	call   80101950 <iunlock>
  iput(curproc->cwd);
80105539:	58                   	pop    %eax
8010553a:	ff 76 68             	push   0x68(%esi)
8010553d:	e8 5e c4 ff ff       	call   801019a0 <iput>
  end_op();
80105542:	e8 39 d9 ff ff       	call   80102e80 <end_op>
  curproc->cwd = ip;
80105547:	89 5e 68             	mov    %ebx,0x68(%esi)
  return 0;
8010554a:	83 c4 10             	add    $0x10,%esp
8010554d:	31 c0                	xor    %eax,%eax
}
8010554f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105552:	5b                   	pop    %ebx
80105553:	5e                   	pop    %esi
80105554:	5d                   	pop    %ebp
80105555:	c3                   	ret
80105556:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010555d:	00 
8010555e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80105560:	83 ec 0c             	sub    $0xc,%esp
80105563:	53                   	push   %ebx
80105564:	e8 97 c5 ff ff       	call   80101b00 <iunlockput>
    end_op();
80105569:	e8 12 d9 ff ff       	call   80102e80 <end_op>
    return -1;
8010556e:	83 c4 10             	add    $0x10,%esp
    return -1;
80105571:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105576:	eb d7                	jmp    8010554f <sys_chdir+0x6f>
80105578:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010557f:	00 
    end_op();
80105580:	e8 fb d8 ff ff       	call   80102e80 <end_op>
    return -1;
80105585:	eb ea                	jmp    80105571 <sys_chdir+0x91>
80105587:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010558e:	00 
8010558f:	90                   	nop

80105590 <sys_exec>:

int
sys_exec(void)
{
80105590:	55                   	push   %ebp
80105591:	89 e5                	mov    %esp,%ebp
80105593:	57                   	push   %edi
80105594:	56                   	push   %esi
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105595:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010559b:	53                   	push   %ebx
8010559c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801055a2:	50                   	push   %eax
801055a3:	6a 00                	push   $0x0
801055a5:	e8 36 f5 ff ff       	call   80104ae0 <argstr>
801055aa:	83 c4 10             	add    $0x10,%esp
801055ad:	85 c0                	test   %eax,%eax
801055af:	0f 88 87 00 00 00    	js     8010563c <sys_exec+0xac>
801055b5:	83 ec 08             	sub    $0x8,%esp
801055b8:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
801055be:	50                   	push   %eax
801055bf:	6a 01                	push   $0x1
801055c1:	e8 5a f4 ff ff       	call   80104a20 <argint>
801055c6:	83 c4 10             	add    $0x10,%esp
801055c9:	85 c0                	test   %eax,%eax
801055cb:	78 6f                	js     8010563c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801055cd:	83 ec 04             	sub    $0x4,%esp
801055d0:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
  for(i=0;; i++){
801055d6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801055d8:	68 80 00 00 00       	push   $0x80
801055dd:	6a 00                	push   $0x0
801055df:	56                   	push   %esi
801055e0:	e8 8b f1 ff ff       	call   80104770 <memset>
801055e5:	83 c4 10             	add    $0x10,%esp
801055e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801055ef:	00 
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801055f0:	83 ec 08             	sub    $0x8,%esp
801055f3:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
801055f9:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80105600:	50                   	push   %eax
80105601:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105607:	01 f8                	add    %edi,%eax
80105609:	50                   	push   %eax
8010560a:	e8 81 f3 ff ff       	call   80104990 <fetchint>
8010560f:	83 c4 10             	add    $0x10,%esp
80105612:	85 c0                	test   %eax,%eax
80105614:	78 26                	js     8010563c <sys_exec+0xac>
      return -1;
    if(uarg == 0){
80105616:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
8010561c:	85 c0                	test   %eax,%eax
8010561e:	74 30                	je     80105650 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
80105620:	83 ec 08             	sub    $0x8,%esp
80105623:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80105626:	52                   	push   %edx
80105627:	50                   	push   %eax
80105628:	e8 a3 f3 ff ff       	call   801049d0 <fetchstr>
8010562d:	83 c4 10             	add    $0x10,%esp
80105630:	85 c0                	test   %eax,%eax
80105632:	78 08                	js     8010563c <sys_exec+0xac>
  for(i=0;; i++){
80105634:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
80105637:	83 fb 20             	cmp    $0x20,%ebx
8010563a:	75 b4                	jne    801055f0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010563c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010563f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105644:	5b                   	pop    %ebx
80105645:	5e                   	pop    %esi
80105646:	5f                   	pop    %edi
80105647:	5d                   	pop    %ebp
80105648:	c3                   	ret
80105649:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      argv[i] = 0;
80105650:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105657:	00 00 00 00 
  return exec(path, argv);
8010565b:	83 ec 08             	sub    $0x8,%esp
8010565e:	56                   	push   %esi
8010565f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80105665:	e8 16 b5 ff ff       	call   80100b80 <exec>
8010566a:	83 c4 10             	add    $0x10,%esp
}
8010566d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105670:	5b                   	pop    %ebx
80105671:	5e                   	pop    %esi
80105672:	5f                   	pop    %edi
80105673:	5d                   	pop    %ebp
80105674:	c3                   	ret
80105675:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010567c:	00 
8010567d:	8d 76 00             	lea    0x0(%esi),%esi

80105680 <sys_pipe>:

int
sys_pipe(void)
{
80105680:	55                   	push   %ebp
80105681:	89 e5                	mov    %esp,%ebp
80105683:	57                   	push   %edi
80105684:	56                   	push   %esi
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
80105685:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105688:	53                   	push   %ebx
80105689:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
8010568c:	6a 08                	push   $0x8
8010568e:	50                   	push   %eax
8010568f:	6a 00                	push   $0x0
80105691:	e8 da f3 ff ff       	call   80104a70 <argptr>
80105696:	83 c4 10             	add    $0x10,%esp
80105699:	85 c0                	test   %eax,%eax
8010569b:	0f 88 8b 00 00 00    	js     8010572c <sys_pipe+0xac>
    return -1;
  if(pipealloc(&rf, &wf) < 0)
801056a1:	83 ec 08             	sub    $0x8,%esp
801056a4:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801056a7:	50                   	push   %eax
801056a8:	8d 45 e0             	lea    -0x20(%ebp),%eax
801056ab:	50                   	push   %eax
801056ac:	e8 2f de ff ff       	call   801034e0 <pipealloc>
801056b1:	83 c4 10             	add    $0x10,%esp
801056b4:	85 c0                	test   %eax,%eax
801056b6:	78 74                	js     8010572c <sys_pipe+0xac>
    return -1;
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801056b8:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
801056bb:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801056bd:	e8 6e e3 ff ff       	call   80103a30 <myproc>
    if(curproc->ofile[fd] == 0){
801056c2:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801056c6:	85 f6                	test   %esi,%esi
801056c8:	74 16                	je     801056e0 <sys_pipe+0x60>
801056ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
801056d0:	83 c3 01             	add    $0x1,%ebx
801056d3:	83 fb 10             	cmp    $0x10,%ebx
801056d6:	74 3d                	je     80105715 <sys_pipe+0x95>
    if(curproc->ofile[fd] == 0){
801056d8:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801056dc:	85 f6                	test   %esi,%esi
801056de:	75 f0                	jne    801056d0 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
801056e0:	8d 73 08             	lea    0x8(%ebx),%esi
801056e3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801056e7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801056ea:	e8 41 e3 ff ff       	call   80103a30 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801056ef:	31 d2                	xor    %edx,%edx
801056f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd] == 0){
801056f8:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801056fc:	85 c9                	test   %ecx,%ecx
801056fe:	74 38                	je     80105738 <sys_pipe+0xb8>
  for(fd = 0; fd < NOFILE; fd++){
80105700:	83 c2 01             	add    $0x1,%edx
80105703:	83 fa 10             	cmp    $0x10,%edx
80105706:	75 f0                	jne    801056f8 <sys_pipe+0x78>
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
80105708:	e8 23 e3 ff ff       	call   80103a30 <myproc>
8010570d:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105714:	00 
    fileclose(rf);
80105715:	83 ec 0c             	sub    $0xc,%esp
80105718:	ff 75 e0             	push   -0x20(%ebp)
8010571b:	e8 c0 b8 ff ff       	call   80100fe0 <fileclose>
    fileclose(wf);
80105720:	58                   	pop    %eax
80105721:	ff 75 e4             	push   -0x1c(%ebp)
80105724:	e8 b7 b8 ff ff       	call   80100fe0 <fileclose>
    return -1;
80105729:	83 c4 10             	add    $0x10,%esp
    return -1;
8010572c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105731:	eb 16                	jmp    80105749 <sys_pipe+0xc9>
80105733:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      curproc->ofile[fd] = f;
80105738:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
  }
  fd[0] = fd0;
8010573c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010573f:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
80105741:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105744:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105747:	31 c0                	xor    %eax,%eax
}
80105749:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010574c:	5b                   	pop    %ebx
8010574d:	5e                   	pop    %esi
8010574e:	5f                   	pop    %edi
8010574f:	5d                   	pop    %ebp
80105750:	c3                   	ret
80105751:	66 90                	xchg   %ax,%ax
80105753:	66 90                	xchg   %ax,%ax
80105755:	66 90                	xchg   %ax,%ax
80105757:	66 90                	xchg   %ax,%ax
80105759:	66 90                	xchg   %ax,%ax
8010575b:	66 90                	xchg   %ax,%ax
8010575d:	66 90                	xchg   %ax,%ax
8010575f:	90                   	nop

80105760 <sys_fork>:
#include "proc.h"

int
sys_fork(void)
{
  return fork();
80105760:	e9 6b e4 ff ff       	jmp    80103bd0 <fork>
80105765:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010576c:	00 
8010576d:	8d 76 00             	lea    0x0(%esi),%esi

80105770 <sys_exit>:
}

int
sys_exit(void)
{
80105770:	55                   	push   %ebp
80105771:	89 e5                	mov    %esp,%ebp
80105773:	83 ec 08             	sub    $0x8,%esp
  exit();
80105776:	e8 c5 e6 ff ff       	call   80103e40 <exit>
  return 0;  // not reached
}
8010577b:	31 c0                	xor    %eax,%eax
8010577d:	c9                   	leave
8010577e:	c3                   	ret
8010577f:	90                   	nop

80105780 <sys_wait>:

int
sys_wait(void)
{
  return wait();
80105780:	e9 eb e7 ff ff       	jmp    80103f70 <wait>
80105785:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010578c:	00 
8010578d:	8d 76 00             	lea    0x0(%esi),%esi

80105790 <sys_kill>:
}

int
sys_kill(void)
{
80105790:	55                   	push   %ebp
80105791:	89 e5                	mov    %esp,%ebp
80105793:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105796:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105799:	50                   	push   %eax
8010579a:	6a 00                	push   $0x0
8010579c:	e8 7f f2 ff ff       	call   80104a20 <argint>
801057a1:	83 c4 10             	add    $0x10,%esp
801057a4:	85 c0                	test   %eax,%eax
801057a6:	78 18                	js     801057c0 <sys_kill+0x30>
    return -1;
  return kill(pid);
801057a8:	83 ec 0c             	sub    $0xc,%esp
801057ab:	ff 75 f4             	push   -0xc(%ebp)
801057ae:	e8 5d ea ff ff       	call   80104210 <kill>
801057b3:	83 c4 10             	add    $0x10,%esp
}
801057b6:	c9                   	leave
801057b7:	c3                   	ret
801057b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801057bf:	00 
801057c0:	c9                   	leave
    return -1;
801057c1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801057c6:	c3                   	ret
801057c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801057ce:	00 
801057cf:	90                   	nop

801057d0 <sys_getpid>:

int
sys_getpid(void)
{
801057d0:	55                   	push   %ebp
801057d1:	89 e5                	mov    %esp,%ebp
801057d3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
801057d6:	e8 55 e2 ff ff       	call   80103a30 <myproc>
801057db:	8b 40 10             	mov    0x10(%eax),%eax
}
801057de:	c9                   	leave
801057df:	c3                   	ret

801057e0 <sys_sbrk>:

int
sys_sbrk(void)
{
801057e0:	55                   	push   %ebp
801057e1:	89 e5                	mov    %esp,%ebp
801057e3:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
801057e4:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
801057e7:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
801057ea:	50                   	push   %eax
801057eb:	6a 00                	push   $0x0
801057ed:	e8 2e f2 ff ff       	call   80104a20 <argint>
801057f2:	83 c4 10             	add    $0x10,%esp
801057f5:	85 c0                	test   %eax,%eax
801057f7:	78 27                	js     80105820 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
801057f9:	e8 32 e2 ff ff       	call   80103a30 <myproc>
  if(growproc(n) < 0)
801057fe:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105801:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105803:	ff 75 f4             	push   -0xc(%ebp)
80105806:	e8 45 e3 ff ff       	call   80103b50 <growproc>
8010580b:	83 c4 10             	add    $0x10,%esp
8010580e:	85 c0                	test   %eax,%eax
80105810:	78 0e                	js     80105820 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105812:	89 d8                	mov    %ebx,%eax
80105814:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105817:	c9                   	leave
80105818:	c3                   	ret
80105819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105820:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105825:	eb eb                	jmp    80105812 <sys_sbrk+0x32>
80105827:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010582e:	00 
8010582f:	90                   	nop

80105830 <sys_sleep>:

int
sys_sleep(void)
{
80105830:	55                   	push   %ebp
80105831:	89 e5                	mov    %esp,%ebp
80105833:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105834:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105837:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
8010583a:	50                   	push   %eax
8010583b:	6a 00                	push   $0x0
8010583d:	e8 de f1 ff ff       	call   80104a20 <argint>
80105842:	83 c4 10             	add    $0x10,%esp
80105845:	85 c0                	test   %eax,%eax
80105847:	78 64                	js     801058ad <sys_sleep+0x7d>
    return -1;
  acquire(&tickslock);
80105849:	83 ec 0c             	sub    $0xc,%esp
8010584c:	68 80 3c 11 80       	push   $0x80113c80
80105851:	e8 1a ee ff ff       	call   80104670 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105856:	8b 55 f4             	mov    -0xc(%ebp),%edx
  ticks0 = ticks;
80105859:	8b 1d 60 3c 11 80    	mov    0x80113c60,%ebx
  while(ticks - ticks0 < n){
8010585f:	83 c4 10             	add    $0x10,%esp
80105862:	85 d2                	test   %edx,%edx
80105864:	75 2b                	jne    80105891 <sys_sleep+0x61>
80105866:	eb 58                	jmp    801058c0 <sys_sleep+0x90>
80105868:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010586f:	00 
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105870:	83 ec 08             	sub    $0x8,%esp
80105873:	68 80 3c 11 80       	push   $0x80113c80
80105878:	68 60 3c 11 80       	push   $0x80113c60
8010587d:	e8 6e e8 ff ff       	call   801040f0 <sleep>
  while(ticks - ticks0 < n){
80105882:	a1 60 3c 11 80       	mov    0x80113c60,%eax
80105887:	83 c4 10             	add    $0x10,%esp
8010588a:	29 d8                	sub    %ebx,%eax
8010588c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010588f:	73 2f                	jae    801058c0 <sys_sleep+0x90>
    if(myproc()->killed){
80105891:	e8 9a e1 ff ff       	call   80103a30 <myproc>
80105896:	8b 40 24             	mov    0x24(%eax),%eax
80105899:	85 c0                	test   %eax,%eax
8010589b:	74 d3                	je     80105870 <sys_sleep+0x40>
      release(&tickslock);
8010589d:	83 ec 0c             	sub    $0xc,%esp
801058a0:	68 80 3c 11 80       	push   $0x80113c80
801058a5:	e8 66 ed ff ff       	call   80104610 <release>
      return -1;
801058aa:	83 c4 10             	add    $0x10,%esp
  }
  release(&tickslock);
  return 0;
}
801058ad:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    return -1;
801058b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801058b5:	c9                   	leave
801058b6:	c3                   	ret
801058b7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801058be:	00 
801058bf:	90                   	nop
  release(&tickslock);
801058c0:	83 ec 0c             	sub    $0xc,%esp
801058c3:	68 80 3c 11 80       	push   $0x80113c80
801058c8:	e8 43 ed ff ff       	call   80104610 <release>
}
801058cd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  return 0;
801058d0:	83 c4 10             	add    $0x10,%esp
801058d3:	31 c0                	xor    %eax,%eax
}
801058d5:	c9                   	leave
801058d6:	c3                   	ret
801058d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801058de:	00 
801058df:	90                   	nop

801058e0 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801058e0:	55                   	push   %ebp
801058e1:	89 e5                	mov    %esp,%ebp
801058e3:	53                   	push   %ebx
801058e4:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
801058e7:	68 80 3c 11 80       	push   $0x80113c80
801058ec:	e8 7f ed ff ff       	call   80104670 <acquire>
  xticks = ticks;
801058f1:	8b 1d 60 3c 11 80    	mov    0x80113c60,%ebx
  release(&tickslock);
801058f7:	c7 04 24 80 3c 11 80 	movl   $0x80113c80,(%esp)
801058fe:	e8 0d ed ff ff       	call   80104610 <release>
  return xticks;
}
80105903:	89 d8                	mov    %ebx,%eax
80105905:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105908:	c9                   	leave
80105909:	c3                   	ret

8010590a <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
8010590a:	1e                   	push   %ds
  pushl %es
8010590b:	06                   	push   %es
  pushl %fs
8010590c:	0f a0                	push   %fs
  pushl %gs
8010590e:	0f a8                	push   %gs
  pushal
80105910:	60                   	pusha
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105911:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105915:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105917:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105919:	54                   	push   %esp
  call trap
8010591a:	e8 c1 00 00 00       	call   801059e0 <trap>
  addl $4, %esp
8010591f:	83 c4 04             	add    $0x4,%esp

80105922 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105922:	61                   	popa
  popl %gs
80105923:	0f a9                	pop    %gs
  popl %fs
80105925:	0f a1                	pop    %fs
  popl %es
80105927:	07                   	pop    %es
  popl %ds
80105928:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105929:	83 c4 08             	add    $0x8,%esp
  iret
8010592c:	cf                   	iret
8010592d:	66 90                	xchg   %ax,%ax
8010592f:	90                   	nop

80105930 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105930:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105931:	31 c0                	xor    %eax,%eax
{
80105933:	89 e5                	mov    %esp,%ebp
80105935:	83 ec 08             	sub    $0x8,%esp
80105938:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010593f:	00 
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105940:	8b 14 85 08 a0 10 80 	mov    -0x7fef5ff8(,%eax,4),%edx
80105947:	c7 04 c5 c2 3c 11 80 	movl   $0x8e000008,-0x7feec33e(,%eax,8)
8010594e:	08 00 00 8e 
80105952:	66 89 14 c5 c0 3c 11 	mov    %dx,-0x7feec340(,%eax,8)
80105959:	80 
8010595a:	c1 ea 10             	shr    $0x10,%edx
8010595d:	66 89 14 c5 c6 3c 11 	mov    %dx,-0x7feec33a(,%eax,8)
80105964:	80 
  for(i = 0; i < 256; i++)
80105965:	83 c0 01             	add    $0x1,%eax
80105968:	3d 00 01 00 00       	cmp    $0x100,%eax
8010596d:	75 d1                	jne    80105940 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
8010596f:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80105972:	a1 08 a1 10 80       	mov    0x8010a108,%eax
80105977:	c7 05 c2 3e 11 80 08 	movl   $0xef000008,0x80113ec2
8010597e:	00 00 ef 
  initlock(&tickslock, "time");
80105981:	68 2e 76 10 80       	push   $0x8010762e
80105986:	68 80 3c 11 80       	push   $0x80113c80
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010598b:	66 a3 c0 3e 11 80    	mov    %ax,0x80113ec0
80105991:	c1 e8 10             	shr    $0x10,%eax
80105994:	66 a3 c6 3e 11 80    	mov    %ax,0x80113ec6
  initlock(&tickslock, "time");
8010599a:	e8 e1 ea ff ff       	call   80104480 <initlock>
}
8010599f:	83 c4 10             	add    $0x10,%esp
801059a2:	c9                   	leave
801059a3:	c3                   	ret
801059a4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801059ab:	00 
801059ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801059b0 <idtinit>:

void
idtinit(void)
{
801059b0:	55                   	push   %ebp
  pd[0] = size-1;
801059b1:	b8 ff 07 00 00       	mov    $0x7ff,%eax
801059b6:	89 e5                	mov    %esp,%ebp
801059b8:	83 ec 10             	sub    $0x10,%esp
801059bb:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801059bf:	b8 c0 3c 11 80       	mov    $0x80113cc0,%eax
801059c4:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801059c8:	c1 e8 10             	shr    $0x10,%eax
801059cb:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
801059cf:	8d 45 fa             	lea    -0x6(%ebp),%eax
801059d2:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
801059d5:	c9                   	leave
801059d6:	c3                   	ret
801059d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801059de:	00 
801059df:	90                   	nop

801059e0 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801059e0:	55                   	push   %ebp
801059e1:	89 e5                	mov    %esp,%ebp
801059e3:	57                   	push   %edi
801059e4:	56                   	push   %esi
801059e5:	53                   	push   %ebx
801059e6:	83 ec 1c             	sub    $0x1c,%esp
801059e9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(tf->trapno == T_SYSCALL){
801059ec:	8b 43 30             	mov    0x30(%ebx),%eax
801059ef:	83 f8 40             	cmp    $0x40,%eax
801059f2:	0f 84 58 01 00 00    	je     80105b50 <trap+0x170>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
801059f8:	83 e8 20             	sub    $0x20,%eax
801059fb:	83 f8 1f             	cmp    $0x1f,%eax
801059fe:	0f 87 7c 00 00 00    	ja     80105a80 <trap+0xa0>
80105a04:	ff 24 85 98 7b 10 80 	jmp    *-0x7fef8468(,%eax,4)
80105a0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      release(&tickslock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80105a10:	e8 eb c8 ff ff       	call   80102300 <ideintr>
    lapiceoi();
80105a15:	e8 a6 cf ff ff       	call   801029c0 <lapiceoi>
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a1a:	e8 11 e0 ff ff       	call   80103a30 <myproc>
80105a1f:	85 c0                	test   %eax,%eax
80105a21:	74 1a                	je     80105a3d <trap+0x5d>
80105a23:	e8 08 e0 ff ff       	call   80103a30 <myproc>
80105a28:	8b 50 24             	mov    0x24(%eax),%edx
80105a2b:	85 d2                	test   %edx,%edx
80105a2d:	74 0e                	je     80105a3d <trap+0x5d>
80105a2f:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105a33:	f7 d0                	not    %eax
80105a35:	a8 03                	test   $0x3,%al
80105a37:	0f 84 db 01 00 00    	je     80105c18 <trap+0x238>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80105a3d:	e8 ee df ff ff       	call   80103a30 <myproc>
80105a42:	85 c0                	test   %eax,%eax
80105a44:	74 0f                	je     80105a55 <trap+0x75>
80105a46:	e8 e5 df ff ff       	call   80103a30 <myproc>
80105a4b:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80105a4f:	0f 84 ab 00 00 00    	je     80105b00 <trap+0x120>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105a55:	e8 d6 df ff ff       	call   80103a30 <myproc>
80105a5a:	85 c0                	test   %eax,%eax
80105a5c:	74 1a                	je     80105a78 <trap+0x98>
80105a5e:	e8 cd df ff ff       	call   80103a30 <myproc>
80105a63:	8b 40 24             	mov    0x24(%eax),%eax
80105a66:	85 c0                	test   %eax,%eax
80105a68:	74 0e                	je     80105a78 <trap+0x98>
80105a6a:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
80105a6e:	f7 d0                	not    %eax
80105a70:	a8 03                	test   $0x3,%al
80105a72:	0f 84 05 01 00 00    	je     80105b7d <trap+0x19d>
    exit();
}
80105a78:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a7b:	5b                   	pop    %ebx
80105a7c:	5e                   	pop    %esi
80105a7d:	5f                   	pop    %edi
80105a7e:	5d                   	pop    %ebp
80105a7f:	c3                   	ret
    if(myproc() == 0 || (tf->cs&3) == 0){
80105a80:	e8 ab df ff ff       	call   80103a30 <myproc>
80105a85:	8b 7b 38             	mov    0x38(%ebx),%edi
80105a88:	85 c0                	test   %eax,%eax
80105a8a:	0f 84 a2 01 00 00    	je     80105c32 <trap+0x252>
80105a90:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80105a94:	0f 84 98 01 00 00    	je     80105c32 <trap+0x252>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80105a9a:	0f 20 d1             	mov    %cr2,%ecx
80105a9d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105aa0:	e8 6b df ff ff       	call   80103a10 <cpuid>
80105aa5:	8b 73 30             	mov    0x30(%ebx),%esi
80105aa8:	89 45 dc             	mov    %eax,-0x24(%ebp)
80105aab:	8b 43 34             	mov    0x34(%ebx),%eax
80105aae:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            myproc()->pid, myproc()->name, tf->trapno,
80105ab1:	e8 7a df ff ff       	call   80103a30 <myproc>
80105ab6:	89 45 e0             	mov    %eax,-0x20(%ebp)
80105ab9:	e8 72 df ff ff       	call   80103a30 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105abe:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80105ac1:	51                   	push   %ecx
80105ac2:	57                   	push   %edi
80105ac3:	8b 55 dc             	mov    -0x24(%ebp),%edx
80105ac6:	52                   	push   %edx
80105ac7:	ff 75 e4             	push   -0x1c(%ebp)
80105aca:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
80105acb:	8b 75 e0             	mov    -0x20(%ebp),%esi
80105ace:	83 c6 6c             	add    $0x6c,%esi
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80105ad1:	56                   	push   %esi
80105ad2:	ff 70 10             	push   0x10(%eax)
80105ad5:	68 7c 78 10 80       	push   $0x8010787c
80105ada:	e8 61 ac ff ff       	call   80100740 <cprintf>
    myproc()->killed = 1;
80105adf:	83 c4 20             	add    $0x20,%esp
80105ae2:	e8 49 df ff ff       	call   80103a30 <myproc>
80105ae7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105aee:	e8 3d df ff ff       	call   80103a30 <myproc>
80105af3:	85 c0                	test   %eax,%eax
80105af5:	0f 85 28 ff ff ff    	jne    80105a23 <trap+0x43>
80105afb:	e9 3d ff ff ff       	jmp    80105a3d <trap+0x5d>
  if(myproc() && myproc()->state == RUNNING &&
80105b00:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
80105b04:	0f 85 4b ff ff ff    	jne    80105a55 <trap+0x75>
    yield();
80105b0a:	e8 91 e5 ff ff       	call   801040a0 <yield>
80105b0f:	e9 41 ff ff ff       	jmp    80105a55 <trap+0x75>
80105b14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80105b18:	8b 7b 38             	mov    0x38(%ebx),%edi
80105b1b:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
80105b1f:	e8 ec de ff ff       	call   80103a10 <cpuid>
80105b24:	57                   	push   %edi
80105b25:	56                   	push   %esi
80105b26:	50                   	push   %eax
80105b27:	68 24 78 10 80       	push   $0x80107824
80105b2c:	e8 0f ac ff ff       	call   80100740 <cprintf>
    lapiceoi();
80105b31:	e8 8a ce ff ff       	call   801029c0 <lapiceoi>
    break;
80105b36:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b39:	e8 f2 de ff ff       	call   80103a30 <myproc>
80105b3e:	85 c0                	test   %eax,%eax
80105b40:	0f 85 dd fe ff ff    	jne    80105a23 <trap+0x43>
80105b46:	e9 f2 fe ff ff       	jmp    80105a3d <trap+0x5d>
80105b4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    if(myproc()->killed)
80105b50:	e8 db de ff ff       	call   80103a30 <myproc>
80105b55:	8b 70 24             	mov    0x24(%eax),%esi
80105b58:	85 f6                	test   %esi,%esi
80105b5a:	0f 85 c8 00 00 00    	jne    80105c28 <trap+0x248>
    myproc()->tf = tf;
80105b60:	e8 cb de ff ff       	call   80103a30 <myproc>
80105b65:	89 58 18             	mov    %ebx,0x18(%eax)
    syscall();
80105b68:	e8 f3 ef ff ff       	call   80104b60 <syscall>
    if(myproc()->killed)
80105b6d:	e8 be de ff ff       	call   80103a30 <myproc>
80105b72:	8b 48 24             	mov    0x24(%eax),%ecx
80105b75:	85 c9                	test   %ecx,%ecx
80105b77:	0f 84 fb fe ff ff    	je     80105a78 <trap+0x98>
}
80105b7d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b80:	5b                   	pop    %ebx
80105b81:	5e                   	pop    %esi
80105b82:	5f                   	pop    %edi
80105b83:	5d                   	pop    %ebp
      exit();
80105b84:	e9 b7 e2 ff ff       	jmp    80103e40 <exit>
80105b89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80105b90:	e8 4b 02 00 00       	call   80105de0 <uartintr>
    lapiceoi();
80105b95:	e8 26 ce ff ff       	call   801029c0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105b9a:	e8 91 de ff ff       	call   80103a30 <myproc>
80105b9f:	85 c0                	test   %eax,%eax
80105ba1:	0f 85 7c fe ff ff    	jne    80105a23 <trap+0x43>
80105ba7:	e9 91 fe ff ff       	jmp    80105a3d <trap+0x5d>
80105bac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
80105bb0:	e8 db cc ff ff       	call   80102890 <kbdintr>
    lapiceoi();
80105bb5:	e8 06 ce ff ff       	call   801029c0 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80105bba:	e8 71 de ff ff       	call   80103a30 <myproc>
80105bbf:	85 c0                	test   %eax,%eax
80105bc1:	0f 85 5c fe ff ff    	jne    80105a23 <trap+0x43>
80105bc7:	e9 71 fe ff ff       	jmp    80105a3d <trap+0x5d>
80105bcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(cpuid() == 0){
80105bd0:	e8 3b de ff ff       	call   80103a10 <cpuid>
80105bd5:	85 c0                	test   %eax,%eax
80105bd7:	0f 85 38 fe ff ff    	jne    80105a15 <trap+0x35>
      acquire(&tickslock);
80105bdd:	83 ec 0c             	sub    $0xc,%esp
80105be0:	68 80 3c 11 80       	push   $0x80113c80
80105be5:	e8 86 ea ff ff       	call   80104670 <acquire>
      ticks++;
80105bea:	83 05 60 3c 11 80 01 	addl   $0x1,0x80113c60
      wakeup(&ticks);
80105bf1:	c7 04 24 60 3c 11 80 	movl   $0x80113c60,(%esp)
80105bf8:	e8 b3 e5 ff ff       	call   801041b0 <wakeup>
      release(&tickslock);
80105bfd:	c7 04 24 80 3c 11 80 	movl   $0x80113c80,(%esp)
80105c04:	e8 07 ea ff ff       	call   80104610 <release>
80105c09:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80105c0c:	e9 04 fe ff ff       	jmp    80105a15 <trap+0x35>
80105c11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    exit();
80105c18:	e8 23 e2 ff ff       	call   80103e40 <exit>
80105c1d:	e9 1b fe ff ff       	jmp    80105a3d <trap+0x5d>
80105c22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80105c28:	e8 13 e2 ff ff       	call   80103e40 <exit>
80105c2d:	e9 2e ff ff ff       	jmp    80105b60 <trap+0x180>
80105c32:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80105c35:	e8 d6 dd ff ff       	call   80103a10 <cpuid>
80105c3a:	83 ec 0c             	sub    $0xc,%esp
80105c3d:	56                   	push   %esi
80105c3e:	57                   	push   %edi
80105c3f:	50                   	push   %eax
80105c40:	ff 73 30             	push   0x30(%ebx)
80105c43:	68 48 78 10 80       	push   $0x80107848
80105c48:	e8 f3 aa ff ff       	call   80100740 <cprintf>
      panic("trap");
80105c4d:	83 c4 14             	add    $0x14,%esp
80105c50:	68 33 76 10 80       	push   $0x80107633
80105c55:	e8 26 a7 ff ff       	call   80100380 <panic>
80105c5a:	66 90                	xchg   %ax,%ax
80105c5c:	66 90                	xchg   %ax,%ax
80105c5e:	66 90                	xchg   %ax,%ax

80105c60 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80105c60:	a1 c0 44 11 80       	mov    0x801144c0,%eax
80105c65:	85 c0                	test   %eax,%eax
80105c67:	74 17                	je     80105c80 <uartgetc+0x20>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105c69:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105c6e:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80105c6f:	a8 01                	test   $0x1,%al
80105c71:	74 0d                	je     80105c80 <uartgetc+0x20>
80105c73:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105c78:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
80105c79:	0f b6 c0             	movzbl %al,%eax
80105c7c:	c3                   	ret
80105c7d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
80105c80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105c85:	c3                   	ret
80105c86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105c8d:	00 
80105c8e:	66 90                	xchg   %ax,%ax

80105c90 <uartinit>:
{
80105c90:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105c91:	31 c9                	xor    %ecx,%ecx
80105c93:	89 c8                	mov    %ecx,%eax
80105c95:	89 e5                	mov    %esp,%ebp
80105c97:	57                   	push   %edi
80105c98:	bf fa 03 00 00       	mov    $0x3fa,%edi
80105c9d:	56                   	push   %esi
80105c9e:	89 fa                	mov    %edi,%edx
80105ca0:	53                   	push   %ebx
80105ca1:	83 ec 1c             	sub    $0x1c,%esp
80105ca4:	ee                   	out    %al,(%dx)
80105ca5:	be fb 03 00 00       	mov    $0x3fb,%esi
80105caa:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
80105caf:	89 f2                	mov    %esi,%edx
80105cb1:	ee                   	out    %al,(%dx)
80105cb2:	b8 0c 00 00 00       	mov    $0xc,%eax
80105cb7:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105cbc:	ee                   	out    %al,(%dx)
80105cbd:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80105cc2:	89 c8                	mov    %ecx,%eax
80105cc4:	89 da                	mov    %ebx,%edx
80105cc6:	ee                   	out    %al,(%dx)
80105cc7:	b8 03 00 00 00       	mov    $0x3,%eax
80105ccc:	89 f2                	mov    %esi,%edx
80105cce:	ee                   	out    %al,(%dx)
80105ccf:	ba fc 03 00 00       	mov    $0x3fc,%edx
80105cd4:	89 c8                	mov    %ecx,%eax
80105cd6:	ee                   	out    %al,(%dx)
80105cd7:	b8 01 00 00 00       	mov    $0x1,%eax
80105cdc:	89 da                	mov    %ebx,%edx
80105cde:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105cdf:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105ce4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
80105ce5:	3c ff                	cmp    $0xff,%al
80105ce7:	0f 84 7c 00 00 00    	je     80105d69 <uartinit+0xd9>
  uart = 1;
80105ced:	c7 05 c0 44 11 80 01 	movl   $0x1,0x801144c0
80105cf4:	00 00 00 
80105cf7:	89 fa                	mov    %edi,%edx
80105cf9:	ec                   	in     (%dx),%al
80105cfa:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105cff:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
80105d00:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
80105d03:	bf 38 76 10 80       	mov    $0x80107638,%edi
80105d08:	be fd 03 00 00       	mov    $0x3fd,%esi
  ioapicenable(IRQ_COM1, 0);
80105d0d:	6a 00                	push   $0x0
80105d0f:	6a 04                	push   $0x4
80105d11:	e8 1a c8 ff ff       	call   80102530 <ioapicenable>
80105d16:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80105d19:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
80105d1d:	8d 76 00             	lea    0x0(%esi),%esi
  if(!uart)
80105d20:	a1 c0 44 11 80       	mov    0x801144c0,%eax
80105d25:	85 c0                	test   %eax,%eax
80105d27:	74 32                	je     80105d5b <uartinit+0xcb>
80105d29:	89 f2                	mov    %esi,%edx
80105d2b:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105d2c:	a8 20                	test   $0x20,%al
80105d2e:	75 21                	jne    80105d51 <uartinit+0xc1>
80105d30:	bb 80 00 00 00       	mov    $0x80,%ebx
80105d35:	8d 76 00             	lea    0x0(%esi),%esi
    microdelay(10);
80105d38:	83 ec 0c             	sub    $0xc,%esp
80105d3b:	6a 0a                	push   $0xa
80105d3d:	e8 9e cc ff ff       	call   801029e0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105d42:	83 c4 10             	add    $0x10,%esp
80105d45:	83 eb 01             	sub    $0x1,%ebx
80105d48:	74 07                	je     80105d51 <uartinit+0xc1>
80105d4a:	89 f2                	mov    %esi,%edx
80105d4c:	ec                   	in     (%dx),%al
80105d4d:	a8 20                	test   $0x20,%al
80105d4f:	74 e7                	je     80105d38 <uartinit+0xa8>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105d51:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105d56:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
80105d5a:	ee                   	out    %al,(%dx)
  for(p="xv6...\n"; *p; p++)
80105d5b:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80105d5f:	83 c7 01             	add    $0x1,%edi
80105d62:	88 45 e7             	mov    %al,-0x19(%ebp)
80105d65:	84 c0                	test   %al,%al
80105d67:	75 b7                	jne    80105d20 <uartinit+0x90>
}
80105d69:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105d6c:	5b                   	pop    %ebx
80105d6d:	5e                   	pop    %esi
80105d6e:	5f                   	pop    %edi
80105d6f:	5d                   	pop    %ebp
80105d70:	c3                   	ret
80105d71:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d78:	00 
80105d79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105d80 <uartputc>:
  if(!uart)
80105d80:	a1 c0 44 11 80       	mov    0x801144c0,%eax
80105d85:	85 c0                	test   %eax,%eax
80105d87:	74 4f                	je     80105dd8 <uartputc+0x58>
{
80105d89:	55                   	push   %ebp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80105d8a:	ba fd 03 00 00       	mov    $0x3fd,%edx
80105d8f:	89 e5                	mov    %esp,%ebp
80105d91:	56                   	push   %esi
80105d92:	53                   	push   %ebx
80105d93:	ec                   	in     (%dx),%al
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105d94:	a8 20                	test   $0x20,%al
80105d96:	75 29                	jne    80105dc1 <uartputc+0x41>
80105d98:	bb 80 00 00 00       	mov    $0x80,%ebx
80105d9d:	be fd 03 00 00       	mov    $0x3fd,%esi
80105da2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    microdelay(10);
80105da8:	83 ec 0c             	sub    $0xc,%esp
80105dab:	6a 0a                	push   $0xa
80105dad:	e8 2e cc ff ff       	call   801029e0 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80105db2:	83 c4 10             	add    $0x10,%esp
80105db5:	83 eb 01             	sub    $0x1,%ebx
80105db8:	74 07                	je     80105dc1 <uartputc+0x41>
80105dba:	89 f2                	mov    %esi,%edx
80105dbc:	ec                   	in     (%dx),%al
80105dbd:	a8 20                	test   $0x20,%al
80105dbf:	74 e7                	je     80105da8 <uartputc+0x28>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105dc1:	8b 45 08             	mov    0x8(%ebp),%eax
80105dc4:	ba f8 03 00 00       	mov    $0x3f8,%edx
80105dc9:	ee                   	out    %al,(%dx)
}
80105dca:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105dcd:	5b                   	pop    %ebx
80105dce:	5e                   	pop    %esi
80105dcf:	5d                   	pop    %ebp
80105dd0:	c3                   	ret
80105dd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105dd8:	c3                   	ret
80105dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105de0 <uartintr>:

void
uartintr(void)
{
80105de0:	55                   	push   %ebp
80105de1:	89 e5                	mov    %esp,%ebp
80105de3:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80105de6:	68 60 5c 10 80       	push   $0x80105c60
80105deb:	e8 30 ab ff ff       	call   80100920 <consoleintr>
}
80105df0:	83 c4 10             	add    $0x10,%esp
80105df3:	c9                   	leave
80105df4:	c3                   	ret

80105df5 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80105df5:	6a 00                	push   $0x0
  pushl $0
80105df7:	6a 00                	push   $0x0
  jmp alltraps
80105df9:	e9 0c fb ff ff       	jmp    8010590a <alltraps>

80105dfe <vector1>:
.globl vector1
vector1:
  pushl $0
80105dfe:	6a 00                	push   $0x0
  pushl $1
80105e00:	6a 01                	push   $0x1
  jmp alltraps
80105e02:	e9 03 fb ff ff       	jmp    8010590a <alltraps>

80105e07 <vector2>:
.globl vector2
vector2:
  pushl $0
80105e07:	6a 00                	push   $0x0
  pushl $2
80105e09:	6a 02                	push   $0x2
  jmp alltraps
80105e0b:	e9 fa fa ff ff       	jmp    8010590a <alltraps>

80105e10 <vector3>:
.globl vector3
vector3:
  pushl $0
80105e10:	6a 00                	push   $0x0
  pushl $3
80105e12:	6a 03                	push   $0x3
  jmp alltraps
80105e14:	e9 f1 fa ff ff       	jmp    8010590a <alltraps>

80105e19 <vector4>:
.globl vector4
vector4:
  pushl $0
80105e19:	6a 00                	push   $0x0
  pushl $4
80105e1b:	6a 04                	push   $0x4
  jmp alltraps
80105e1d:	e9 e8 fa ff ff       	jmp    8010590a <alltraps>

80105e22 <vector5>:
.globl vector5
vector5:
  pushl $0
80105e22:	6a 00                	push   $0x0
  pushl $5
80105e24:	6a 05                	push   $0x5
  jmp alltraps
80105e26:	e9 df fa ff ff       	jmp    8010590a <alltraps>

80105e2b <vector6>:
.globl vector6
vector6:
  pushl $0
80105e2b:	6a 00                	push   $0x0
  pushl $6
80105e2d:	6a 06                	push   $0x6
  jmp alltraps
80105e2f:	e9 d6 fa ff ff       	jmp    8010590a <alltraps>

80105e34 <vector7>:
.globl vector7
vector7:
  pushl $0
80105e34:	6a 00                	push   $0x0
  pushl $7
80105e36:	6a 07                	push   $0x7
  jmp alltraps
80105e38:	e9 cd fa ff ff       	jmp    8010590a <alltraps>

80105e3d <vector8>:
.globl vector8
vector8:
  pushl $8
80105e3d:	6a 08                	push   $0x8
  jmp alltraps
80105e3f:	e9 c6 fa ff ff       	jmp    8010590a <alltraps>

80105e44 <vector9>:
.globl vector9
vector9:
  pushl $0
80105e44:	6a 00                	push   $0x0
  pushl $9
80105e46:	6a 09                	push   $0x9
  jmp alltraps
80105e48:	e9 bd fa ff ff       	jmp    8010590a <alltraps>

80105e4d <vector10>:
.globl vector10
vector10:
  pushl $10
80105e4d:	6a 0a                	push   $0xa
  jmp alltraps
80105e4f:	e9 b6 fa ff ff       	jmp    8010590a <alltraps>

80105e54 <vector11>:
.globl vector11
vector11:
  pushl $11
80105e54:	6a 0b                	push   $0xb
  jmp alltraps
80105e56:	e9 af fa ff ff       	jmp    8010590a <alltraps>

80105e5b <vector12>:
.globl vector12
vector12:
  pushl $12
80105e5b:	6a 0c                	push   $0xc
  jmp alltraps
80105e5d:	e9 a8 fa ff ff       	jmp    8010590a <alltraps>

80105e62 <vector13>:
.globl vector13
vector13:
  pushl $13
80105e62:	6a 0d                	push   $0xd
  jmp alltraps
80105e64:	e9 a1 fa ff ff       	jmp    8010590a <alltraps>

80105e69 <vector14>:
.globl vector14
vector14:
  pushl $14
80105e69:	6a 0e                	push   $0xe
  jmp alltraps
80105e6b:	e9 9a fa ff ff       	jmp    8010590a <alltraps>

80105e70 <vector15>:
.globl vector15
vector15:
  pushl $0
80105e70:	6a 00                	push   $0x0
  pushl $15
80105e72:	6a 0f                	push   $0xf
  jmp alltraps
80105e74:	e9 91 fa ff ff       	jmp    8010590a <alltraps>

80105e79 <vector16>:
.globl vector16
vector16:
  pushl $0
80105e79:	6a 00                	push   $0x0
  pushl $16
80105e7b:	6a 10                	push   $0x10
  jmp alltraps
80105e7d:	e9 88 fa ff ff       	jmp    8010590a <alltraps>

80105e82 <vector17>:
.globl vector17
vector17:
  pushl $17
80105e82:	6a 11                	push   $0x11
  jmp alltraps
80105e84:	e9 81 fa ff ff       	jmp    8010590a <alltraps>

80105e89 <vector18>:
.globl vector18
vector18:
  pushl $0
80105e89:	6a 00                	push   $0x0
  pushl $18
80105e8b:	6a 12                	push   $0x12
  jmp alltraps
80105e8d:	e9 78 fa ff ff       	jmp    8010590a <alltraps>

80105e92 <vector19>:
.globl vector19
vector19:
  pushl $0
80105e92:	6a 00                	push   $0x0
  pushl $19
80105e94:	6a 13                	push   $0x13
  jmp alltraps
80105e96:	e9 6f fa ff ff       	jmp    8010590a <alltraps>

80105e9b <vector20>:
.globl vector20
vector20:
  pushl $0
80105e9b:	6a 00                	push   $0x0
  pushl $20
80105e9d:	6a 14                	push   $0x14
  jmp alltraps
80105e9f:	e9 66 fa ff ff       	jmp    8010590a <alltraps>

80105ea4 <vector21>:
.globl vector21
vector21:
  pushl $0
80105ea4:	6a 00                	push   $0x0
  pushl $21
80105ea6:	6a 15                	push   $0x15
  jmp alltraps
80105ea8:	e9 5d fa ff ff       	jmp    8010590a <alltraps>

80105ead <vector22>:
.globl vector22
vector22:
  pushl $0
80105ead:	6a 00                	push   $0x0
  pushl $22
80105eaf:	6a 16                	push   $0x16
  jmp alltraps
80105eb1:	e9 54 fa ff ff       	jmp    8010590a <alltraps>

80105eb6 <vector23>:
.globl vector23
vector23:
  pushl $0
80105eb6:	6a 00                	push   $0x0
  pushl $23
80105eb8:	6a 17                	push   $0x17
  jmp alltraps
80105eba:	e9 4b fa ff ff       	jmp    8010590a <alltraps>

80105ebf <vector24>:
.globl vector24
vector24:
  pushl $0
80105ebf:	6a 00                	push   $0x0
  pushl $24
80105ec1:	6a 18                	push   $0x18
  jmp alltraps
80105ec3:	e9 42 fa ff ff       	jmp    8010590a <alltraps>

80105ec8 <vector25>:
.globl vector25
vector25:
  pushl $0
80105ec8:	6a 00                	push   $0x0
  pushl $25
80105eca:	6a 19                	push   $0x19
  jmp alltraps
80105ecc:	e9 39 fa ff ff       	jmp    8010590a <alltraps>

80105ed1 <vector26>:
.globl vector26
vector26:
  pushl $0
80105ed1:	6a 00                	push   $0x0
  pushl $26
80105ed3:	6a 1a                	push   $0x1a
  jmp alltraps
80105ed5:	e9 30 fa ff ff       	jmp    8010590a <alltraps>

80105eda <vector27>:
.globl vector27
vector27:
  pushl $0
80105eda:	6a 00                	push   $0x0
  pushl $27
80105edc:	6a 1b                	push   $0x1b
  jmp alltraps
80105ede:	e9 27 fa ff ff       	jmp    8010590a <alltraps>

80105ee3 <vector28>:
.globl vector28
vector28:
  pushl $0
80105ee3:	6a 00                	push   $0x0
  pushl $28
80105ee5:	6a 1c                	push   $0x1c
  jmp alltraps
80105ee7:	e9 1e fa ff ff       	jmp    8010590a <alltraps>

80105eec <vector29>:
.globl vector29
vector29:
  pushl $0
80105eec:	6a 00                	push   $0x0
  pushl $29
80105eee:	6a 1d                	push   $0x1d
  jmp alltraps
80105ef0:	e9 15 fa ff ff       	jmp    8010590a <alltraps>

80105ef5 <vector30>:
.globl vector30
vector30:
  pushl $0
80105ef5:	6a 00                	push   $0x0
  pushl $30
80105ef7:	6a 1e                	push   $0x1e
  jmp alltraps
80105ef9:	e9 0c fa ff ff       	jmp    8010590a <alltraps>

80105efe <vector31>:
.globl vector31
vector31:
  pushl $0
80105efe:	6a 00                	push   $0x0
  pushl $31
80105f00:	6a 1f                	push   $0x1f
  jmp alltraps
80105f02:	e9 03 fa ff ff       	jmp    8010590a <alltraps>

80105f07 <vector32>:
.globl vector32
vector32:
  pushl $0
80105f07:	6a 00                	push   $0x0
  pushl $32
80105f09:	6a 20                	push   $0x20
  jmp alltraps
80105f0b:	e9 fa f9 ff ff       	jmp    8010590a <alltraps>

80105f10 <vector33>:
.globl vector33
vector33:
  pushl $0
80105f10:	6a 00                	push   $0x0
  pushl $33
80105f12:	6a 21                	push   $0x21
  jmp alltraps
80105f14:	e9 f1 f9 ff ff       	jmp    8010590a <alltraps>

80105f19 <vector34>:
.globl vector34
vector34:
  pushl $0
80105f19:	6a 00                	push   $0x0
  pushl $34
80105f1b:	6a 22                	push   $0x22
  jmp alltraps
80105f1d:	e9 e8 f9 ff ff       	jmp    8010590a <alltraps>

80105f22 <vector35>:
.globl vector35
vector35:
  pushl $0
80105f22:	6a 00                	push   $0x0
  pushl $35
80105f24:	6a 23                	push   $0x23
  jmp alltraps
80105f26:	e9 df f9 ff ff       	jmp    8010590a <alltraps>

80105f2b <vector36>:
.globl vector36
vector36:
  pushl $0
80105f2b:	6a 00                	push   $0x0
  pushl $36
80105f2d:	6a 24                	push   $0x24
  jmp alltraps
80105f2f:	e9 d6 f9 ff ff       	jmp    8010590a <alltraps>

80105f34 <vector37>:
.globl vector37
vector37:
  pushl $0
80105f34:	6a 00                	push   $0x0
  pushl $37
80105f36:	6a 25                	push   $0x25
  jmp alltraps
80105f38:	e9 cd f9 ff ff       	jmp    8010590a <alltraps>

80105f3d <vector38>:
.globl vector38
vector38:
  pushl $0
80105f3d:	6a 00                	push   $0x0
  pushl $38
80105f3f:	6a 26                	push   $0x26
  jmp alltraps
80105f41:	e9 c4 f9 ff ff       	jmp    8010590a <alltraps>

80105f46 <vector39>:
.globl vector39
vector39:
  pushl $0
80105f46:	6a 00                	push   $0x0
  pushl $39
80105f48:	6a 27                	push   $0x27
  jmp alltraps
80105f4a:	e9 bb f9 ff ff       	jmp    8010590a <alltraps>

80105f4f <vector40>:
.globl vector40
vector40:
  pushl $0
80105f4f:	6a 00                	push   $0x0
  pushl $40
80105f51:	6a 28                	push   $0x28
  jmp alltraps
80105f53:	e9 b2 f9 ff ff       	jmp    8010590a <alltraps>

80105f58 <vector41>:
.globl vector41
vector41:
  pushl $0
80105f58:	6a 00                	push   $0x0
  pushl $41
80105f5a:	6a 29                	push   $0x29
  jmp alltraps
80105f5c:	e9 a9 f9 ff ff       	jmp    8010590a <alltraps>

80105f61 <vector42>:
.globl vector42
vector42:
  pushl $0
80105f61:	6a 00                	push   $0x0
  pushl $42
80105f63:	6a 2a                	push   $0x2a
  jmp alltraps
80105f65:	e9 a0 f9 ff ff       	jmp    8010590a <alltraps>

80105f6a <vector43>:
.globl vector43
vector43:
  pushl $0
80105f6a:	6a 00                	push   $0x0
  pushl $43
80105f6c:	6a 2b                	push   $0x2b
  jmp alltraps
80105f6e:	e9 97 f9 ff ff       	jmp    8010590a <alltraps>

80105f73 <vector44>:
.globl vector44
vector44:
  pushl $0
80105f73:	6a 00                	push   $0x0
  pushl $44
80105f75:	6a 2c                	push   $0x2c
  jmp alltraps
80105f77:	e9 8e f9 ff ff       	jmp    8010590a <alltraps>

80105f7c <vector45>:
.globl vector45
vector45:
  pushl $0
80105f7c:	6a 00                	push   $0x0
  pushl $45
80105f7e:	6a 2d                	push   $0x2d
  jmp alltraps
80105f80:	e9 85 f9 ff ff       	jmp    8010590a <alltraps>

80105f85 <vector46>:
.globl vector46
vector46:
  pushl $0
80105f85:	6a 00                	push   $0x0
  pushl $46
80105f87:	6a 2e                	push   $0x2e
  jmp alltraps
80105f89:	e9 7c f9 ff ff       	jmp    8010590a <alltraps>

80105f8e <vector47>:
.globl vector47
vector47:
  pushl $0
80105f8e:	6a 00                	push   $0x0
  pushl $47
80105f90:	6a 2f                	push   $0x2f
  jmp alltraps
80105f92:	e9 73 f9 ff ff       	jmp    8010590a <alltraps>

80105f97 <vector48>:
.globl vector48
vector48:
  pushl $0
80105f97:	6a 00                	push   $0x0
  pushl $48
80105f99:	6a 30                	push   $0x30
  jmp alltraps
80105f9b:	e9 6a f9 ff ff       	jmp    8010590a <alltraps>

80105fa0 <vector49>:
.globl vector49
vector49:
  pushl $0
80105fa0:	6a 00                	push   $0x0
  pushl $49
80105fa2:	6a 31                	push   $0x31
  jmp alltraps
80105fa4:	e9 61 f9 ff ff       	jmp    8010590a <alltraps>

80105fa9 <vector50>:
.globl vector50
vector50:
  pushl $0
80105fa9:	6a 00                	push   $0x0
  pushl $50
80105fab:	6a 32                	push   $0x32
  jmp alltraps
80105fad:	e9 58 f9 ff ff       	jmp    8010590a <alltraps>

80105fb2 <vector51>:
.globl vector51
vector51:
  pushl $0
80105fb2:	6a 00                	push   $0x0
  pushl $51
80105fb4:	6a 33                	push   $0x33
  jmp alltraps
80105fb6:	e9 4f f9 ff ff       	jmp    8010590a <alltraps>

80105fbb <vector52>:
.globl vector52
vector52:
  pushl $0
80105fbb:	6a 00                	push   $0x0
  pushl $52
80105fbd:	6a 34                	push   $0x34
  jmp alltraps
80105fbf:	e9 46 f9 ff ff       	jmp    8010590a <alltraps>

80105fc4 <vector53>:
.globl vector53
vector53:
  pushl $0
80105fc4:	6a 00                	push   $0x0
  pushl $53
80105fc6:	6a 35                	push   $0x35
  jmp alltraps
80105fc8:	e9 3d f9 ff ff       	jmp    8010590a <alltraps>

80105fcd <vector54>:
.globl vector54
vector54:
  pushl $0
80105fcd:	6a 00                	push   $0x0
  pushl $54
80105fcf:	6a 36                	push   $0x36
  jmp alltraps
80105fd1:	e9 34 f9 ff ff       	jmp    8010590a <alltraps>

80105fd6 <vector55>:
.globl vector55
vector55:
  pushl $0
80105fd6:	6a 00                	push   $0x0
  pushl $55
80105fd8:	6a 37                	push   $0x37
  jmp alltraps
80105fda:	e9 2b f9 ff ff       	jmp    8010590a <alltraps>

80105fdf <vector56>:
.globl vector56
vector56:
  pushl $0
80105fdf:	6a 00                	push   $0x0
  pushl $56
80105fe1:	6a 38                	push   $0x38
  jmp alltraps
80105fe3:	e9 22 f9 ff ff       	jmp    8010590a <alltraps>

80105fe8 <vector57>:
.globl vector57
vector57:
  pushl $0
80105fe8:	6a 00                	push   $0x0
  pushl $57
80105fea:	6a 39                	push   $0x39
  jmp alltraps
80105fec:	e9 19 f9 ff ff       	jmp    8010590a <alltraps>

80105ff1 <vector58>:
.globl vector58
vector58:
  pushl $0
80105ff1:	6a 00                	push   $0x0
  pushl $58
80105ff3:	6a 3a                	push   $0x3a
  jmp alltraps
80105ff5:	e9 10 f9 ff ff       	jmp    8010590a <alltraps>

80105ffa <vector59>:
.globl vector59
vector59:
  pushl $0
80105ffa:	6a 00                	push   $0x0
  pushl $59
80105ffc:	6a 3b                	push   $0x3b
  jmp alltraps
80105ffe:	e9 07 f9 ff ff       	jmp    8010590a <alltraps>

80106003 <vector60>:
.globl vector60
vector60:
  pushl $0
80106003:	6a 00                	push   $0x0
  pushl $60
80106005:	6a 3c                	push   $0x3c
  jmp alltraps
80106007:	e9 fe f8 ff ff       	jmp    8010590a <alltraps>

8010600c <vector61>:
.globl vector61
vector61:
  pushl $0
8010600c:	6a 00                	push   $0x0
  pushl $61
8010600e:	6a 3d                	push   $0x3d
  jmp alltraps
80106010:	e9 f5 f8 ff ff       	jmp    8010590a <alltraps>

80106015 <vector62>:
.globl vector62
vector62:
  pushl $0
80106015:	6a 00                	push   $0x0
  pushl $62
80106017:	6a 3e                	push   $0x3e
  jmp alltraps
80106019:	e9 ec f8 ff ff       	jmp    8010590a <alltraps>

8010601e <vector63>:
.globl vector63
vector63:
  pushl $0
8010601e:	6a 00                	push   $0x0
  pushl $63
80106020:	6a 3f                	push   $0x3f
  jmp alltraps
80106022:	e9 e3 f8 ff ff       	jmp    8010590a <alltraps>

80106027 <vector64>:
.globl vector64
vector64:
  pushl $0
80106027:	6a 00                	push   $0x0
  pushl $64
80106029:	6a 40                	push   $0x40
  jmp alltraps
8010602b:	e9 da f8 ff ff       	jmp    8010590a <alltraps>

80106030 <vector65>:
.globl vector65
vector65:
  pushl $0
80106030:	6a 00                	push   $0x0
  pushl $65
80106032:	6a 41                	push   $0x41
  jmp alltraps
80106034:	e9 d1 f8 ff ff       	jmp    8010590a <alltraps>

80106039 <vector66>:
.globl vector66
vector66:
  pushl $0
80106039:	6a 00                	push   $0x0
  pushl $66
8010603b:	6a 42                	push   $0x42
  jmp alltraps
8010603d:	e9 c8 f8 ff ff       	jmp    8010590a <alltraps>

80106042 <vector67>:
.globl vector67
vector67:
  pushl $0
80106042:	6a 00                	push   $0x0
  pushl $67
80106044:	6a 43                	push   $0x43
  jmp alltraps
80106046:	e9 bf f8 ff ff       	jmp    8010590a <alltraps>

8010604b <vector68>:
.globl vector68
vector68:
  pushl $0
8010604b:	6a 00                	push   $0x0
  pushl $68
8010604d:	6a 44                	push   $0x44
  jmp alltraps
8010604f:	e9 b6 f8 ff ff       	jmp    8010590a <alltraps>

80106054 <vector69>:
.globl vector69
vector69:
  pushl $0
80106054:	6a 00                	push   $0x0
  pushl $69
80106056:	6a 45                	push   $0x45
  jmp alltraps
80106058:	e9 ad f8 ff ff       	jmp    8010590a <alltraps>

8010605d <vector70>:
.globl vector70
vector70:
  pushl $0
8010605d:	6a 00                	push   $0x0
  pushl $70
8010605f:	6a 46                	push   $0x46
  jmp alltraps
80106061:	e9 a4 f8 ff ff       	jmp    8010590a <alltraps>

80106066 <vector71>:
.globl vector71
vector71:
  pushl $0
80106066:	6a 00                	push   $0x0
  pushl $71
80106068:	6a 47                	push   $0x47
  jmp alltraps
8010606a:	e9 9b f8 ff ff       	jmp    8010590a <alltraps>

8010606f <vector72>:
.globl vector72
vector72:
  pushl $0
8010606f:	6a 00                	push   $0x0
  pushl $72
80106071:	6a 48                	push   $0x48
  jmp alltraps
80106073:	e9 92 f8 ff ff       	jmp    8010590a <alltraps>

80106078 <vector73>:
.globl vector73
vector73:
  pushl $0
80106078:	6a 00                	push   $0x0
  pushl $73
8010607a:	6a 49                	push   $0x49
  jmp alltraps
8010607c:	e9 89 f8 ff ff       	jmp    8010590a <alltraps>

80106081 <vector74>:
.globl vector74
vector74:
  pushl $0
80106081:	6a 00                	push   $0x0
  pushl $74
80106083:	6a 4a                	push   $0x4a
  jmp alltraps
80106085:	e9 80 f8 ff ff       	jmp    8010590a <alltraps>

8010608a <vector75>:
.globl vector75
vector75:
  pushl $0
8010608a:	6a 00                	push   $0x0
  pushl $75
8010608c:	6a 4b                	push   $0x4b
  jmp alltraps
8010608e:	e9 77 f8 ff ff       	jmp    8010590a <alltraps>

80106093 <vector76>:
.globl vector76
vector76:
  pushl $0
80106093:	6a 00                	push   $0x0
  pushl $76
80106095:	6a 4c                	push   $0x4c
  jmp alltraps
80106097:	e9 6e f8 ff ff       	jmp    8010590a <alltraps>

8010609c <vector77>:
.globl vector77
vector77:
  pushl $0
8010609c:	6a 00                	push   $0x0
  pushl $77
8010609e:	6a 4d                	push   $0x4d
  jmp alltraps
801060a0:	e9 65 f8 ff ff       	jmp    8010590a <alltraps>

801060a5 <vector78>:
.globl vector78
vector78:
  pushl $0
801060a5:	6a 00                	push   $0x0
  pushl $78
801060a7:	6a 4e                	push   $0x4e
  jmp alltraps
801060a9:	e9 5c f8 ff ff       	jmp    8010590a <alltraps>

801060ae <vector79>:
.globl vector79
vector79:
  pushl $0
801060ae:	6a 00                	push   $0x0
  pushl $79
801060b0:	6a 4f                	push   $0x4f
  jmp alltraps
801060b2:	e9 53 f8 ff ff       	jmp    8010590a <alltraps>

801060b7 <vector80>:
.globl vector80
vector80:
  pushl $0
801060b7:	6a 00                	push   $0x0
  pushl $80
801060b9:	6a 50                	push   $0x50
  jmp alltraps
801060bb:	e9 4a f8 ff ff       	jmp    8010590a <alltraps>

801060c0 <vector81>:
.globl vector81
vector81:
  pushl $0
801060c0:	6a 00                	push   $0x0
  pushl $81
801060c2:	6a 51                	push   $0x51
  jmp alltraps
801060c4:	e9 41 f8 ff ff       	jmp    8010590a <alltraps>

801060c9 <vector82>:
.globl vector82
vector82:
  pushl $0
801060c9:	6a 00                	push   $0x0
  pushl $82
801060cb:	6a 52                	push   $0x52
  jmp alltraps
801060cd:	e9 38 f8 ff ff       	jmp    8010590a <alltraps>

801060d2 <vector83>:
.globl vector83
vector83:
  pushl $0
801060d2:	6a 00                	push   $0x0
  pushl $83
801060d4:	6a 53                	push   $0x53
  jmp alltraps
801060d6:	e9 2f f8 ff ff       	jmp    8010590a <alltraps>

801060db <vector84>:
.globl vector84
vector84:
  pushl $0
801060db:	6a 00                	push   $0x0
  pushl $84
801060dd:	6a 54                	push   $0x54
  jmp alltraps
801060df:	e9 26 f8 ff ff       	jmp    8010590a <alltraps>

801060e4 <vector85>:
.globl vector85
vector85:
  pushl $0
801060e4:	6a 00                	push   $0x0
  pushl $85
801060e6:	6a 55                	push   $0x55
  jmp alltraps
801060e8:	e9 1d f8 ff ff       	jmp    8010590a <alltraps>

801060ed <vector86>:
.globl vector86
vector86:
  pushl $0
801060ed:	6a 00                	push   $0x0
  pushl $86
801060ef:	6a 56                	push   $0x56
  jmp alltraps
801060f1:	e9 14 f8 ff ff       	jmp    8010590a <alltraps>

801060f6 <vector87>:
.globl vector87
vector87:
  pushl $0
801060f6:	6a 00                	push   $0x0
  pushl $87
801060f8:	6a 57                	push   $0x57
  jmp alltraps
801060fa:	e9 0b f8 ff ff       	jmp    8010590a <alltraps>

801060ff <vector88>:
.globl vector88
vector88:
  pushl $0
801060ff:	6a 00                	push   $0x0
  pushl $88
80106101:	6a 58                	push   $0x58
  jmp alltraps
80106103:	e9 02 f8 ff ff       	jmp    8010590a <alltraps>

80106108 <vector89>:
.globl vector89
vector89:
  pushl $0
80106108:	6a 00                	push   $0x0
  pushl $89
8010610a:	6a 59                	push   $0x59
  jmp alltraps
8010610c:	e9 f9 f7 ff ff       	jmp    8010590a <alltraps>

80106111 <vector90>:
.globl vector90
vector90:
  pushl $0
80106111:	6a 00                	push   $0x0
  pushl $90
80106113:	6a 5a                	push   $0x5a
  jmp alltraps
80106115:	e9 f0 f7 ff ff       	jmp    8010590a <alltraps>

8010611a <vector91>:
.globl vector91
vector91:
  pushl $0
8010611a:	6a 00                	push   $0x0
  pushl $91
8010611c:	6a 5b                	push   $0x5b
  jmp alltraps
8010611e:	e9 e7 f7 ff ff       	jmp    8010590a <alltraps>

80106123 <vector92>:
.globl vector92
vector92:
  pushl $0
80106123:	6a 00                	push   $0x0
  pushl $92
80106125:	6a 5c                	push   $0x5c
  jmp alltraps
80106127:	e9 de f7 ff ff       	jmp    8010590a <alltraps>

8010612c <vector93>:
.globl vector93
vector93:
  pushl $0
8010612c:	6a 00                	push   $0x0
  pushl $93
8010612e:	6a 5d                	push   $0x5d
  jmp alltraps
80106130:	e9 d5 f7 ff ff       	jmp    8010590a <alltraps>

80106135 <vector94>:
.globl vector94
vector94:
  pushl $0
80106135:	6a 00                	push   $0x0
  pushl $94
80106137:	6a 5e                	push   $0x5e
  jmp alltraps
80106139:	e9 cc f7 ff ff       	jmp    8010590a <alltraps>

8010613e <vector95>:
.globl vector95
vector95:
  pushl $0
8010613e:	6a 00                	push   $0x0
  pushl $95
80106140:	6a 5f                	push   $0x5f
  jmp alltraps
80106142:	e9 c3 f7 ff ff       	jmp    8010590a <alltraps>

80106147 <vector96>:
.globl vector96
vector96:
  pushl $0
80106147:	6a 00                	push   $0x0
  pushl $96
80106149:	6a 60                	push   $0x60
  jmp alltraps
8010614b:	e9 ba f7 ff ff       	jmp    8010590a <alltraps>

80106150 <vector97>:
.globl vector97
vector97:
  pushl $0
80106150:	6a 00                	push   $0x0
  pushl $97
80106152:	6a 61                	push   $0x61
  jmp alltraps
80106154:	e9 b1 f7 ff ff       	jmp    8010590a <alltraps>

80106159 <vector98>:
.globl vector98
vector98:
  pushl $0
80106159:	6a 00                	push   $0x0
  pushl $98
8010615b:	6a 62                	push   $0x62
  jmp alltraps
8010615d:	e9 a8 f7 ff ff       	jmp    8010590a <alltraps>

80106162 <vector99>:
.globl vector99
vector99:
  pushl $0
80106162:	6a 00                	push   $0x0
  pushl $99
80106164:	6a 63                	push   $0x63
  jmp alltraps
80106166:	e9 9f f7 ff ff       	jmp    8010590a <alltraps>

8010616b <vector100>:
.globl vector100
vector100:
  pushl $0
8010616b:	6a 00                	push   $0x0
  pushl $100
8010616d:	6a 64                	push   $0x64
  jmp alltraps
8010616f:	e9 96 f7 ff ff       	jmp    8010590a <alltraps>

80106174 <vector101>:
.globl vector101
vector101:
  pushl $0
80106174:	6a 00                	push   $0x0
  pushl $101
80106176:	6a 65                	push   $0x65
  jmp alltraps
80106178:	e9 8d f7 ff ff       	jmp    8010590a <alltraps>

8010617d <vector102>:
.globl vector102
vector102:
  pushl $0
8010617d:	6a 00                	push   $0x0
  pushl $102
8010617f:	6a 66                	push   $0x66
  jmp alltraps
80106181:	e9 84 f7 ff ff       	jmp    8010590a <alltraps>

80106186 <vector103>:
.globl vector103
vector103:
  pushl $0
80106186:	6a 00                	push   $0x0
  pushl $103
80106188:	6a 67                	push   $0x67
  jmp alltraps
8010618a:	e9 7b f7 ff ff       	jmp    8010590a <alltraps>

8010618f <vector104>:
.globl vector104
vector104:
  pushl $0
8010618f:	6a 00                	push   $0x0
  pushl $104
80106191:	6a 68                	push   $0x68
  jmp alltraps
80106193:	e9 72 f7 ff ff       	jmp    8010590a <alltraps>

80106198 <vector105>:
.globl vector105
vector105:
  pushl $0
80106198:	6a 00                	push   $0x0
  pushl $105
8010619a:	6a 69                	push   $0x69
  jmp alltraps
8010619c:	e9 69 f7 ff ff       	jmp    8010590a <alltraps>

801061a1 <vector106>:
.globl vector106
vector106:
  pushl $0
801061a1:	6a 00                	push   $0x0
  pushl $106
801061a3:	6a 6a                	push   $0x6a
  jmp alltraps
801061a5:	e9 60 f7 ff ff       	jmp    8010590a <alltraps>

801061aa <vector107>:
.globl vector107
vector107:
  pushl $0
801061aa:	6a 00                	push   $0x0
  pushl $107
801061ac:	6a 6b                	push   $0x6b
  jmp alltraps
801061ae:	e9 57 f7 ff ff       	jmp    8010590a <alltraps>

801061b3 <vector108>:
.globl vector108
vector108:
  pushl $0
801061b3:	6a 00                	push   $0x0
  pushl $108
801061b5:	6a 6c                	push   $0x6c
  jmp alltraps
801061b7:	e9 4e f7 ff ff       	jmp    8010590a <alltraps>

801061bc <vector109>:
.globl vector109
vector109:
  pushl $0
801061bc:	6a 00                	push   $0x0
  pushl $109
801061be:	6a 6d                	push   $0x6d
  jmp alltraps
801061c0:	e9 45 f7 ff ff       	jmp    8010590a <alltraps>

801061c5 <vector110>:
.globl vector110
vector110:
  pushl $0
801061c5:	6a 00                	push   $0x0
  pushl $110
801061c7:	6a 6e                	push   $0x6e
  jmp alltraps
801061c9:	e9 3c f7 ff ff       	jmp    8010590a <alltraps>

801061ce <vector111>:
.globl vector111
vector111:
  pushl $0
801061ce:	6a 00                	push   $0x0
  pushl $111
801061d0:	6a 6f                	push   $0x6f
  jmp alltraps
801061d2:	e9 33 f7 ff ff       	jmp    8010590a <alltraps>

801061d7 <vector112>:
.globl vector112
vector112:
  pushl $0
801061d7:	6a 00                	push   $0x0
  pushl $112
801061d9:	6a 70                	push   $0x70
  jmp alltraps
801061db:	e9 2a f7 ff ff       	jmp    8010590a <alltraps>

801061e0 <vector113>:
.globl vector113
vector113:
  pushl $0
801061e0:	6a 00                	push   $0x0
  pushl $113
801061e2:	6a 71                	push   $0x71
  jmp alltraps
801061e4:	e9 21 f7 ff ff       	jmp    8010590a <alltraps>

801061e9 <vector114>:
.globl vector114
vector114:
  pushl $0
801061e9:	6a 00                	push   $0x0
  pushl $114
801061eb:	6a 72                	push   $0x72
  jmp alltraps
801061ed:	e9 18 f7 ff ff       	jmp    8010590a <alltraps>

801061f2 <vector115>:
.globl vector115
vector115:
  pushl $0
801061f2:	6a 00                	push   $0x0
  pushl $115
801061f4:	6a 73                	push   $0x73
  jmp alltraps
801061f6:	e9 0f f7 ff ff       	jmp    8010590a <alltraps>

801061fb <vector116>:
.globl vector116
vector116:
  pushl $0
801061fb:	6a 00                	push   $0x0
  pushl $116
801061fd:	6a 74                	push   $0x74
  jmp alltraps
801061ff:	e9 06 f7 ff ff       	jmp    8010590a <alltraps>

80106204 <vector117>:
.globl vector117
vector117:
  pushl $0
80106204:	6a 00                	push   $0x0
  pushl $117
80106206:	6a 75                	push   $0x75
  jmp alltraps
80106208:	e9 fd f6 ff ff       	jmp    8010590a <alltraps>

8010620d <vector118>:
.globl vector118
vector118:
  pushl $0
8010620d:	6a 00                	push   $0x0
  pushl $118
8010620f:	6a 76                	push   $0x76
  jmp alltraps
80106211:	e9 f4 f6 ff ff       	jmp    8010590a <alltraps>

80106216 <vector119>:
.globl vector119
vector119:
  pushl $0
80106216:	6a 00                	push   $0x0
  pushl $119
80106218:	6a 77                	push   $0x77
  jmp alltraps
8010621a:	e9 eb f6 ff ff       	jmp    8010590a <alltraps>

8010621f <vector120>:
.globl vector120
vector120:
  pushl $0
8010621f:	6a 00                	push   $0x0
  pushl $120
80106221:	6a 78                	push   $0x78
  jmp alltraps
80106223:	e9 e2 f6 ff ff       	jmp    8010590a <alltraps>

80106228 <vector121>:
.globl vector121
vector121:
  pushl $0
80106228:	6a 00                	push   $0x0
  pushl $121
8010622a:	6a 79                	push   $0x79
  jmp alltraps
8010622c:	e9 d9 f6 ff ff       	jmp    8010590a <alltraps>

80106231 <vector122>:
.globl vector122
vector122:
  pushl $0
80106231:	6a 00                	push   $0x0
  pushl $122
80106233:	6a 7a                	push   $0x7a
  jmp alltraps
80106235:	e9 d0 f6 ff ff       	jmp    8010590a <alltraps>

8010623a <vector123>:
.globl vector123
vector123:
  pushl $0
8010623a:	6a 00                	push   $0x0
  pushl $123
8010623c:	6a 7b                	push   $0x7b
  jmp alltraps
8010623e:	e9 c7 f6 ff ff       	jmp    8010590a <alltraps>

80106243 <vector124>:
.globl vector124
vector124:
  pushl $0
80106243:	6a 00                	push   $0x0
  pushl $124
80106245:	6a 7c                	push   $0x7c
  jmp alltraps
80106247:	e9 be f6 ff ff       	jmp    8010590a <alltraps>

8010624c <vector125>:
.globl vector125
vector125:
  pushl $0
8010624c:	6a 00                	push   $0x0
  pushl $125
8010624e:	6a 7d                	push   $0x7d
  jmp alltraps
80106250:	e9 b5 f6 ff ff       	jmp    8010590a <alltraps>

80106255 <vector126>:
.globl vector126
vector126:
  pushl $0
80106255:	6a 00                	push   $0x0
  pushl $126
80106257:	6a 7e                	push   $0x7e
  jmp alltraps
80106259:	e9 ac f6 ff ff       	jmp    8010590a <alltraps>

8010625e <vector127>:
.globl vector127
vector127:
  pushl $0
8010625e:	6a 00                	push   $0x0
  pushl $127
80106260:	6a 7f                	push   $0x7f
  jmp alltraps
80106262:	e9 a3 f6 ff ff       	jmp    8010590a <alltraps>

80106267 <vector128>:
.globl vector128
vector128:
  pushl $0
80106267:	6a 00                	push   $0x0
  pushl $128
80106269:	68 80 00 00 00       	push   $0x80
  jmp alltraps
8010626e:	e9 97 f6 ff ff       	jmp    8010590a <alltraps>

80106273 <vector129>:
.globl vector129
vector129:
  pushl $0
80106273:	6a 00                	push   $0x0
  pushl $129
80106275:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010627a:	e9 8b f6 ff ff       	jmp    8010590a <alltraps>

8010627f <vector130>:
.globl vector130
vector130:
  pushl $0
8010627f:	6a 00                	push   $0x0
  pushl $130
80106281:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106286:	e9 7f f6 ff ff       	jmp    8010590a <alltraps>

8010628b <vector131>:
.globl vector131
vector131:
  pushl $0
8010628b:	6a 00                	push   $0x0
  pushl $131
8010628d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106292:	e9 73 f6 ff ff       	jmp    8010590a <alltraps>

80106297 <vector132>:
.globl vector132
vector132:
  pushl $0
80106297:	6a 00                	push   $0x0
  pushl $132
80106299:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010629e:	e9 67 f6 ff ff       	jmp    8010590a <alltraps>

801062a3 <vector133>:
.globl vector133
vector133:
  pushl $0
801062a3:	6a 00                	push   $0x0
  pushl $133
801062a5:	68 85 00 00 00       	push   $0x85
  jmp alltraps
801062aa:	e9 5b f6 ff ff       	jmp    8010590a <alltraps>

801062af <vector134>:
.globl vector134
vector134:
  pushl $0
801062af:	6a 00                	push   $0x0
  pushl $134
801062b1:	68 86 00 00 00       	push   $0x86
  jmp alltraps
801062b6:	e9 4f f6 ff ff       	jmp    8010590a <alltraps>

801062bb <vector135>:
.globl vector135
vector135:
  pushl $0
801062bb:	6a 00                	push   $0x0
  pushl $135
801062bd:	68 87 00 00 00       	push   $0x87
  jmp alltraps
801062c2:	e9 43 f6 ff ff       	jmp    8010590a <alltraps>

801062c7 <vector136>:
.globl vector136
vector136:
  pushl $0
801062c7:	6a 00                	push   $0x0
  pushl $136
801062c9:	68 88 00 00 00       	push   $0x88
  jmp alltraps
801062ce:	e9 37 f6 ff ff       	jmp    8010590a <alltraps>

801062d3 <vector137>:
.globl vector137
vector137:
  pushl $0
801062d3:	6a 00                	push   $0x0
  pushl $137
801062d5:	68 89 00 00 00       	push   $0x89
  jmp alltraps
801062da:	e9 2b f6 ff ff       	jmp    8010590a <alltraps>

801062df <vector138>:
.globl vector138
vector138:
  pushl $0
801062df:	6a 00                	push   $0x0
  pushl $138
801062e1:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
801062e6:	e9 1f f6 ff ff       	jmp    8010590a <alltraps>

801062eb <vector139>:
.globl vector139
vector139:
  pushl $0
801062eb:	6a 00                	push   $0x0
  pushl $139
801062ed:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
801062f2:	e9 13 f6 ff ff       	jmp    8010590a <alltraps>

801062f7 <vector140>:
.globl vector140
vector140:
  pushl $0
801062f7:	6a 00                	push   $0x0
  pushl $140
801062f9:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
801062fe:	e9 07 f6 ff ff       	jmp    8010590a <alltraps>

80106303 <vector141>:
.globl vector141
vector141:
  pushl $0
80106303:	6a 00                	push   $0x0
  pushl $141
80106305:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010630a:	e9 fb f5 ff ff       	jmp    8010590a <alltraps>

8010630f <vector142>:
.globl vector142
vector142:
  pushl $0
8010630f:	6a 00                	push   $0x0
  pushl $142
80106311:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
80106316:	e9 ef f5 ff ff       	jmp    8010590a <alltraps>

8010631b <vector143>:
.globl vector143
vector143:
  pushl $0
8010631b:	6a 00                	push   $0x0
  pushl $143
8010631d:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
80106322:	e9 e3 f5 ff ff       	jmp    8010590a <alltraps>

80106327 <vector144>:
.globl vector144
vector144:
  pushl $0
80106327:	6a 00                	push   $0x0
  pushl $144
80106329:	68 90 00 00 00       	push   $0x90
  jmp alltraps
8010632e:	e9 d7 f5 ff ff       	jmp    8010590a <alltraps>

80106333 <vector145>:
.globl vector145
vector145:
  pushl $0
80106333:	6a 00                	push   $0x0
  pushl $145
80106335:	68 91 00 00 00       	push   $0x91
  jmp alltraps
8010633a:	e9 cb f5 ff ff       	jmp    8010590a <alltraps>

8010633f <vector146>:
.globl vector146
vector146:
  pushl $0
8010633f:	6a 00                	push   $0x0
  pushl $146
80106341:	68 92 00 00 00       	push   $0x92
  jmp alltraps
80106346:	e9 bf f5 ff ff       	jmp    8010590a <alltraps>

8010634b <vector147>:
.globl vector147
vector147:
  pushl $0
8010634b:	6a 00                	push   $0x0
  pushl $147
8010634d:	68 93 00 00 00       	push   $0x93
  jmp alltraps
80106352:	e9 b3 f5 ff ff       	jmp    8010590a <alltraps>

80106357 <vector148>:
.globl vector148
vector148:
  pushl $0
80106357:	6a 00                	push   $0x0
  pushl $148
80106359:	68 94 00 00 00       	push   $0x94
  jmp alltraps
8010635e:	e9 a7 f5 ff ff       	jmp    8010590a <alltraps>

80106363 <vector149>:
.globl vector149
vector149:
  pushl $0
80106363:	6a 00                	push   $0x0
  pushl $149
80106365:	68 95 00 00 00       	push   $0x95
  jmp alltraps
8010636a:	e9 9b f5 ff ff       	jmp    8010590a <alltraps>

8010636f <vector150>:
.globl vector150
vector150:
  pushl $0
8010636f:	6a 00                	push   $0x0
  pushl $150
80106371:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106376:	e9 8f f5 ff ff       	jmp    8010590a <alltraps>

8010637b <vector151>:
.globl vector151
vector151:
  pushl $0
8010637b:	6a 00                	push   $0x0
  pushl $151
8010637d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106382:	e9 83 f5 ff ff       	jmp    8010590a <alltraps>

80106387 <vector152>:
.globl vector152
vector152:
  pushl $0
80106387:	6a 00                	push   $0x0
  pushl $152
80106389:	68 98 00 00 00       	push   $0x98
  jmp alltraps
8010638e:	e9 77 f5 ff ff       	jmp    8010590a <alltraps>

80106393 <vector153>:
.globl vector153
vector153:
  pushl $0
80106393:	6a 00                	push   $0x0
  pushl $153
80106395:	68 99 00 00 00       	push   $0x99
  jmp alltraps
8010639a:	e9 6b f5 ff ff       	jmp    8010590a <alltraps>

8010639f <vector154>:
.globl vector154
vector154:
  pushl $0
8010639f:	6a 00                	push   $0x0
  pushl $154
801063a1:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
801063a6:	e9 5f f5 ff ff       	jmp    8010590a <alltraps>

801063ab <vector155>:
.globl vector155
vector155:
  pushl $0
801063ab:	6a 00                	push   $0x0
  pushl $155
801063ad:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
801063b2:	e9 53 f5 ff ff       	jmp    8010590a <alltraps>

801063b7 <vector156>:
.globl vector156
vector156:
  pushl $0
801063b7:	6a 00                	push   $0x0
  pushl $156
801063b9:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
801063be:	e9 47 f5 ff ff       	jmp    8010590a <alltraps>

801063c3 <vector157>:
.globl vector157
vector157:
  pushl $0
801063c3:	6a 00                	push   $0x0
  pushl $157
801063c5:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
801063ca:	e9 3b f5 ff ff       	jmp    8010590a <alltraps>

801063cf <vector158>:
.globl vector158
vector158:
  pushl $0
801063cf:	6a 00                	push   $0x0
  pushl $158
801063d1:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
801063d6:	e9 2f f5 ff ff       	jmp    8010590a <alltraps>

801063db <vector159>:
.globl vector159
vector159:
  pushl $0
801063db:	6a 00                	push   $0x0
  pushl $159
801063dd:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
801063e2:	e9 23 f5 ff ff       	jmp    8010590a <alltraps>

801063e7 <vector160>:
.globl vector160
vector160:
  pushl $0
801063e7:	6a 00                	push   $0x0
  pushl $160
801063e9:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
801063ee:	e9 17 f5 ff ff       	jmp    8010590a <alltraps>

801063f3 <vector161>:
.globl vector161
vector161:
  pushl $0
801063f3:	6a 00                	push   $0x0
  pushl $161
801063f5:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
801063fa:	e9 0b f5 ff ff       	jmp    8010590a <alltraps>

801063ff <vector162>:
.globl vector162
vector162:
  pushl $0
801063ff:	6a 00                	push   $0x0
  pushl $162
80106401:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106406:	e9 ff f4 ff ff       	jmp    8010590a <alltraps>

8010640b <vector163>:
.globl vector163
vector163:
  pushl $0
8010640b:	6a 00                	push   $0x0
  pushl $163
8010640d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106412:	e9 f3 f4 ff ff       	jmp    8010590a <alltraps>

80106417 <vector164>:
.globl vector164
vector164:
  pushl $0
80106417:	6a 00                	push   $0x0
  pushl $164
80106419:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
8010641e:	e9 e7 f4 ff ff       	jmp    8010590a <alltraps>

80106423 <vector165>:
.globl vector165
vector165:
  pushl $0
80106423:	6a 00                	push   $0x0
  pushl $165
80106425:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
8010642a:	e9 db f4 ff ff       	jmp    8010590a <alltraps>

8010642f <vector166>:
.globl vector166
vector166:
  pushl $0
8010642f:	6a 00                	push   $0x0
  pushl $166
80106431:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106436:	e9 cf f4 ff ff       	jmp    8010590a <alltraps>

8010643b <vector167>:
.globl vector167
vector167:
  pushl $0
8010643b:	6a 00                	push   $0x0
  pushl $167
8010643d:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106442:	e9 c3 f4 ff ff       	jmp    8010590a <alltraps>

80106447 <vector168>:
.globl vector168
vector168:
  pushl $0
80106447:	6a 00                	push   $0x0
  pushl $168
80106449:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
8010644e:	e9 b7 f4 ff ff       	jmp    8010590a <alltraps>

80106453 <vector169>:
.globl vector169
vector169:
  pushl $0
80106453:	6a 00                	push   $0x0
  pushl $169
80106455:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
8010645a:	e9 ab f4 ff ff       	jmp    8010590a <alltraps>

8010645f <vector170>:
.globl vector170
vector170:
  pushl $0
8010645f:	6a 00                	push   $0x0
  pushl $170
80106461:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106466:	e9 9f f4 ff ff       	jmp    8010590a <alltraps>

8010646b <vector171>:
.globl vector171
vector171:
  pushl $0
8010646b:	6a 00                	push   $0x0
  pushl $171
8010646d:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106472:	e9 93 f4 ff ff       	jmp    8010590a <alltraps>

80106477 <vector172>:
.globl vector172
vector172:
  pushl $0
80106477:	6a 00                	push   $0x0
  pushl $172
80106479:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
8010647e:	e9 87 f4 ff ff       	jmp    8010590a <alltraps>

80106483 <vector173>:
.globl vector173
vector173:
  pushl $0
80106483:	6a 00                	push   $0x0
  pushl $173
80106485:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
8010648a:	e9 7b f4 ff ff       	jmp    8010590a <alltraps>

8010648f <vector174>:
.globl vector174
vector174:
  pushl $0
8010648f:	6a 00                	push   $0x0
  pushl $174
80106491:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106496:	e9 6f f4 ff ff       	jmp    8010590a <alltraps>

8010649b <vector175>:
.globl vector175
vector175:
  pushl $0
8010649b:	6a 00                	push   $0x0
  pushl $175
8010649d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
801064a2:	e9 63 f4 ff ff       	jmp    8010590a <alltraps>

801064a7 <vector176>:
.globl vector176
vector176:
  pushl $0
801064a7:	6a 00                	push   $0x0
  pushl $176
801064a9:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
801064ae:	e9 57 f4 ff ff       	jmp    8010590a <alltraps>

801064b3 <vector177>:
.globl vector177
vector177:
  pushl $0
801064b3:	6a 00                	push   $0x0
  pushl $177
801064b5:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
801064ba:	e9 4b f4 ff ff       	jmp    8010590a <alltraps>

801064bf <vector178>:
.globl vector178
vector178:
  pushl $0
801064bf:	6a 00                	push   $0x0
  pushl $178
801064c1:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
801064c6:	e9 3f f4 ff ff       	jmp    8010590a <alltraps>

801064cb <vector179>:
.globl vector179
vector179:
  pushl $0
801064cb:	6a 00                	push   $0x0
  pushl $179
801064cd:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
801064d2:	e9 33 f4 ff ff       	jmp    8010590a <alltraps>

801064d7 <vector180>:
.globl vector180
vector180:
  pushl $0
801064d7:	6a 00                	push   $0x0
  pushl $180
801064d9:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
801064de:	e9 27 f4 ff ff       	jmp    8010590a <alltraps>

801064e3 <vector181>:
.globl vector181
vector181:
  pushl $0
801064e3:	6a 00                	push   $0x0
  pushl $181
801064e5:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
801064ea:	e9 1b f4 ff ff       	jmp    8010590a <alltraps>

801064ef <vector182>:
.globl vector182
vector182:
  pushl $0
801064ef:	6a 00                	push   $0x0
  pushl $182
801064f1:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
801064f6:	e9 0f f4 ff ff       	jmp    8010590a <alltraps>

801064fb <vector183>:
.globl vector183
vector183:
  pushl $0
801064fb:	6a 00                	push   $0x0
  pushl $183
801064fd:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106502:	e9 03 f4 ff ff       	jmp    8010590a <alltraps>

80106507 <vector184>:
.globl vector184
vector184:
  pushl $0
80106507:	6a 00                	push   $0x0
  pushl $184
80106509:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
8010650e:	e9 f7 f3 ff ff       	jmp    8010590a <alltraps>

80106513 <vector185>:
.globl vector185
vector185:
  pushl $0
80106513:	6a 00                	push   $0x0
  pushl $185
80106515:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
8010651a:	e9 eb f3 ff ff       	jmp    8010590a <alltraps>

8010651f <vector186>:
.globl vector186
vector186:
  pushl $0
8010651f:	6a 00                	push   $0x0
  pushl $186
80106521:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106526:	e9 df f3 ff ff       	jmp    8010590a <alltraps>

8010652b <vector187>:
.globl vector187
vector187:
  pushl $0
8010652b:	6a 00                	push   $0x0
  pushl $187
8010652d:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106532:	e9 d3 f3 ff ff       	jmp    8010590a <alltraps>

80106537 <vector188>:
.globl vector188
vector188:
  pushl $0
80106537:	6a 00                	push   $0x0
  pushl $188
80106539:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
8010653e:	e9 c7 f3 ff ff       	jmp    8010590a <alltraps>

80106543 <vector189>:
.globl vector189
vector189:
  pushl $0
80106543:	6a 00                	push   $0x0
  pushl $189
80106545:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
8010654a:	e9 bb f3 ff ff       	jmp    8010590a <alltraps>

8010654f <vector190>:
.globl vector190
vector190:
  pushl $0
8010654f:	6a 00                	push   $0x0
  pushl $190
80106551:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106556:	e9 af f3 ff ff       	jmp    8010590a <alltraps>

8010655b <vector191>:
.globl vector191
vector191:
  pushl $0
8010655b:	6a 00                	push   $0x0
  pushl $191
8010655d:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106562:	e9 a3 f3 ff ff       	jmp    8010590a <alltraps>

80106567 <vector192>:
.globl vector192
vector192:
  pushl $0
80106567:	6a 00                	push   $0x0
  pushl $192
80106569:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
8010656e:	e9 97 f3 ff ff       	jmp    8010590a <alltraps>

80106573 <vector193>:
.globl vector193
vector193:
  pushl $0
80106573:	6a 00                	push   $0x0
  pushl $193
80106575:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
8010657a:	e9 8b f3 ff ff       	jmp    8010590a <alltraps>

8010657f <vector194>:
.globl vector194
vector194:
  pushl $0
8010657f:	6a 00                	push   $0x0
  pushl $194
80106581:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106586:	e9 7f f3 ff ff       	jmp    8010590a <alltraps>

8010658b <vector195>:
.globl vector195
vector195:
  pushl $0
8010658b:	6a 00                	push   $0x0
  pushl $195
8010658d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106592:	e9 73 f3 ff ff       	jmp    8010590a <alltraps>

80106597 <vector196>:
.globl vector196
vector196:
  pushl $0
80106597:	6a 00                	push   $0x0
  pushl $196
80106599:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
8010659e:	e9 67 f3 ff ff       	jmp    8010590a <alltraps>

801065a3 <vector197>:
.globl vector197
vector197:
  pushl $0
801065a3:	6a 00                	push   $0x0
  pushl $197
801065a5:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
801065aa:	e9 5b f3 ff ff       	jmp    8010590a <alltraps>

801065af <vector198>:
.globl vector198
vector198:
  pushl $0
801065af:	6a 00                	push   $0x0
  pushl $198
801065b1:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
801065b6:	e9 4f f3 ff ff       	jmp    8010590a <alltraps>

801065bb <vector199>:
.globl vector199
vector199:
  pushl $0
801065bb:	6a 00                	push   $0x0
  pushl $199
801065bd:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
801065c2:	e9 43 f3 ff ff       	jmp    8010590a <alltraps>

801065c7 <vector200>:
.globl vector200
vector200:
  pushl $0
801065c7:	6a 00                	push   $0x0
  pushl $200
801065c9:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
801065ce:	e9 37 f3 ff ff       	jmp    8010590a <alltraps>

801065d3 <vector201>:
.globl vector201
vector201:
  pushl $0
801065d3:	6a 00                	push   $0x0
  pushl $201
801065d5:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
801065da:	e9 2b f3 ff ff       	jmp    8010590a <alltraps>

801065df <vector202>:
.globl vector202
vector202:
  pushl $0
801065df:	6a 00                	push   $0x0
  pushl $202
801065e1:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
801065e6:	e9 1f f3 ff ff       	jmp    8010590a <alltraps>

801065eb <vector203>:
.globl vector203
vector203:
  pushl $0
801065eb:	6a 00                	push   $0x0
  pushl $203
801065ed:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
801065f2:	e9 13 f3 ff ff       	jmp    8010590a <alltraps>

801065f7 <vector204>:
.globl vector204
vector204:
  pushl $0
801065f7:	6a 00                	push   $0x0
  pushl $204
801065f9:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
801065fe:	e9 07 f3 ff ff       	jmp    8010590a <alltraps>

80106603 <vector205>:
.globl vector205
vector205:
  pushl $0
80106603:	6a 00                	push   $0x0
  pushl $205
80106605:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
8010660a:	e9 fb f2 ff ff       	jmp    8010590a <alltraps>

8010660f <vector206>:
.globl vector206
vector206:
  pushl $0
8010660f:	6a 00                	push   $0x0
  pushl $206
80106611:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106616:	e9 ef f2 ff ff       	jmp    8010590a <alltraps>

8010661b <vector207>:
.globl vector207
vector207:
  pushl $0
8010661b:	6a 00                	push   $0x0
  pushl $207
8010661d:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106622:	e9 e3 f2 ff ff       	jmp    8010590a <alltraps>

80106627 <vector208>:
.globl vector208
vector208:
  pushl $0
80106627:	6a 00                	push   $0x0
  pushl $208
80106629:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
8010662e:	e9 d7 f2 ff ff       	jmp    8010590a <alltraps>

80106633 <vector209>:
.globl vector209
vector209:
  pushl $0
80106633:	6a 00                	push   $0x0
  pushl $209
80106635:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
8010663a:	e9 cb f2 ff ff       	jmp    8010590a <alltraps>

8010663f <vector210>:
.globl vector210
vector210:
  pushl $0
8010663f:	6a 00                	push   $0x0
  pushl $210
80106641:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106646:	e9 bf f2 ff ff       	jmp    8010590a <alltraps>

8010664b <vector211>:
.globl vector211
vector211:
  pushl $0
8010664b:	6a 00                	push   $0x0
  pushl $211
8010664d:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106652:	e9 b3 f2 ff ff       	jmp    8010590a <alltraps>

80106657 <vector212>:
.globl vector212
vector212:
  pushl $0
80106657:	6a 00                	push   $0x0
  pushl $212
80106659:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
8010665e:	e9 a7 f2 ff ff       	jmp    8010590a <alltraps>

80106663 <vector213>:
.globl vector213
vector213:
  pushl $0
80106663:	6a 00                	push   $0x0
  pushl $213
80106665:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
8010666a:	e9 9b f2 ff ff       	jmp    8010590a <alltraps>

8010666f <vector214>:
.globl vector214
vector214:
  pushl $0
8010666f:	6a 00                	push   $0x0
  pushl $214
80106671:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106676:	e9 8f f2 ff ff       	jmp    8010590a <alltraps>

8010667b <vector215>:
.globl vector215
vector215:
  pushl $0
8010667b:	6a 00                	push   $0x0
  pushl $215
8010667d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106682:	e9 83 f2 ff ff       	jmp    8010590a <alltraps>

80106687 <vector216>:
.globl vector216
vector216:
  pushl $0
80106687:	6a 00                	push   $0x0
  pushl $216
80106689:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
8010668e:	e9 77 f2 ff ff       	jmp    8010590a <alltraps>

80106693 <vector217>:
.globl vector217
vector217:
  pushl $0
80106693:	6a 00                	push   $0x0
  pushl $217
80106695:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
8010669a:	e9 6b f2 ff ff       	jmp    8010590a <alltraps>

8010669f <vector218>:
.globl vector218
vector218:
  pushl $0
8010669f:	6a 00                	push   $0x0
  pushl $218
801066a1:	68 da 00 00 00       	push   $0xda
  jmp alltraps
801066a6:	e9 5f f2 ff ff       	jmp    8010590a <alltraps>

801066ab <vector219>:
.globl vector219
vector219:
  pushl $0
801066ab:	6a 00                	push   $0x0
  pushl $219
801066ad:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
801066b2:	e9 53 f2 ff ff       	jmp    8010590a <alltraps>

801066b7 <vector220>:
.globl vector220
vector220:
  pushl $0
801066b7:	6a 00                	push   $0x0
  pushl $220
801066b9:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
801066be:	e9 47 f2 ff ff       	jmp    8010590a <alltraps>

801066c3 <vector221>:
.globl vector221
vector221:
  pushl $0
801066c3:	6a 00                	push   $0x0
  pushl $221
801066c5:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
801066ca:	e9 3b f2 ff ff       	jmp    8010590a <alltraps>

801066cf <vector222>:
.globl vector222
vector222:
  pushl $0
801066cf:	6a 00                	push   $0x0
  pushl $222
801066d1:	68 de 00 00 00       	push   $0xde
  jmp alltraps
801066d6:	e9 2f f2 ff ff       	jmp    8010590a <alltraps>

801066db <vector223>:
.globl vector223
vector223:
  pushl $0
801066db:	6a 00                	push   $0x0
  pushl $223
801066dd:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
801066e2:	e9 23 f2 ff ff       	jmp    8010590a <alltraps>

801066e7 <vector224>:
.globl vector224
vector224:
  pushl $0
801066e7:	6a 00                	push   $0x0
  pushl $224
801066e9:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
801066ee:	e9 17 f2 ff ff       	jmp    8010590a <alltraps>

801066f3 <vector225>:
.globl vector225
vector225:
  pushl $0
801066f3:	6a 00                	push   $0x0
  pushl $225
801066f5:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
801066fa:	e9 0b f2 ff ff       	jmp    8010590a <alltraps>

801066ff <vector226>:
.globl vector226
vector226:
  pushl $0
801066ff:	6a 00                	push   $0x0
  pushl $226
80106701:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106706:	e9 ff f1 ff ff       	jmp    8010590a <alltraps>

8010670b <vector227>:
.globl vector227
vector227:
  pushl $0
8010670b:	6a 00                	push   $0x0
  pushl $227
8010670d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106712:	e9 f3 f1 ff ff       	jmp    8010590a <alltraps>

80106717 <vector228>:
.globl vector228
vector228:
  pushl $0
80106717:	6a 00                	push   $0x0
  pushl $228
80106719:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
8010671e:	e9 e7 f1 ff ff       	jmp    8010590a <alltraps>

80106723 <vector229>:
.globl vector229
vector229:
  pushl $0
80106723:	6a 00                	push   $0x0
  pushl $229
80106725:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
8010672a:	e9 db f1 ff ff       	jmp    8010590a <alltraps>

8010672f <vector230>:
.globl vector230
vector230:
  pushl $0
8010672f:	6a 00                	push   $0x0
  pushl $230
80106731:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106736:	e9 cf f1 ff ff       	jmp    8010590a <alltraps>

8010673b <vector231>:
.globl vector231
vector231:
  pushl $0
8010673b:	6a 00                	push   $0x0
  pushl $231
8010673d:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106742:	e9 c3 f1 ff ff       	jmp    8010590a <alltraps>

80106747 <vector232>:
.globl vector232
vector232:
  pushl $0
80106747:	6a 00                	push   $0x0
  pushl $232
80106749:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
8010674e:	e9 b7 f1 ff ff       	jmp    8010590a <alltraps>

80106753 <vector233>:
.globl vector233
vector233:
  pushl $0
80106753:	6a 00                	push   $0x0
  pushl $233
80106755:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
8010675a:	e9 ab f1 ff ff       	jmp    8010590a <alltraps>

8010675f <vector234>:
.globl vector234
vector234:
  pushl $0
8010675f:	6a 00                	push   $0x0
  pushl $234
80106761:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106766:	e9 9f f1 ff ff       	jmp    8010590a <alltraps>

8010676b <vector235>:
.globl vector235
vector235:
  pushl $0
8010676b:	6a 00                	push   $0x0
  pushl $235
8010676d:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106772:	e9 93 f1 ff ff       	jmp    8010590a <alltraps>

80106777 <vector236>:
.globl vector236
vector236:
  pushl $0
80106777:	6a 00                	push   $0x0
  pushl $236
80106779:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
8010677e:	e9 87 f1 ff ff       	jmp    8010590a <alltraps>

80106783 <vector237>:
.globl vector237
vector237:
  pushl $0
80106783:	6a 00                	push   $0x0
  pushl $237
80106785:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
8010678a:	e9 7b f1 ff ff       	jmp    8010590a <alltraps>

8010678f <vector238>:
.globl vector238
vector238:
  pushl $0
8010678f:	6a 00                	push   $0x0
  pushl $238
80106791:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106796:	e9 6f f1 ff ff       	jmp    8010590a <alltraps>

8010679b <vector239>:
.globl vector239
vector239:
  pushl $0
8010679b:	6a 00                	push   $0x0
  pushl $239
8010679d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
801067a2:	e9 63 f1 ff ff       	jmp    8010590a <alltraps>

801067a7 <vector240>:
.globl vector240
vector240:
  pushl $0
801067a7:	6a 00                	push   $0x0
  pushl $240
801067a9:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
801067ae:	e9 57 f1 ff ff       	jmp    8010590a <alltraps>

801067b3 <vector241>:
.globl vector241
vector241:
  pushl $0
801067b3:	6a 00                	push   $0x0
  pushl $241
801067b5:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
801067ba:	e9 4b f1 ff ff       	jmp    8010590a <alltraps>

801067bf <vector242>:
.globl vector242
vector242:
  pushl $0
801067bf:	6a 00                	push   $0x0
  pushl $242
801067c1:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
801067c6:	e9 3f f1 ff ff       	jmp    8010590a <alltraps>

801067cb <vector243>:
.globl vector243
vector243:
  pushl $0
801067cb:	6a 00                	push   $0x0
  pushl $243
801067cd:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
801067d2:	e9 33 f1 ff ff       	jmp    8010590a <alltraps>

801067d7 <vector244>:
.globl vector244
vector244:
  pushl $0
801067d7:	6a 00                	push   $0x0
  pushl $244
801067d9:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
801067de:	e9 27 f1 ff ff       	jmp    8010590a <alltraps>

801067e3 <vector245>:
.globl vector245
vector245:
  pushl $0
801067e3:	6a 00                	push   $0x0
  pushl $245
801067e5:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
801067ea:	e9 1b f1 ff ff       	jmp    8010590a <alltraps>

801067ef <vector246>:
.globl vector246
vector246:
  pushl $0
801067ef:	6a 00                	push   $0x0
  pushl $246
801067f1:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
801067f6:	e9 0f f1 ff ff       	jmp    8010590a <alltraps>

801067fb <vector247>:
.globl vector247
vector247:
  pushl $0
801067fb:	6a 00                	push   $0x0
  pushl $247
801067fd:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106802:	e9 03 f1 ff ff       	jmp    8010590a <alltraps>

80106807 <vector248>:
.globl vector248
vector248:
  pushl $0
80106807:	6a 00                	push   $0x0
  pushl $248
80106809:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
8010680e:	e9 f7 f0 ff ff       	jmp    8010590a <alltraps>

80106813 <vector249>:
.globl vector249
vector249:
  pushl $0
80106813:	6a 00                	push   $0x0
  pushl $249
80106815:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
8010681a:	e9 eb f0 ff ff       	jmp    8010590a <alltraps>

8010681f <vector250>:
.globl vector250
vector250:
  pushl $0
8010681f:	6a 00                	push   $0x0
  pushl $250
80106821:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106826:	e9 df f0 ff ff       	jmp    8010590a <alltraps>

8010682b <vector251>:
.globl vector251
vector251:
  pushl $0
8010682b:	6a 00                	push   $0x0
  pushl $251
8010682d:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106832:	e9 d3 f0 ff ff       	jmp    8010590a <alltraps>

80106837 <vector252>:
.globl vector252
vector252:
  pushl $0
80106837:	6a 00                	push   $0x0
  pushl $252
80106839:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
8010683e:	e9 c7 f0 ff ff       	jmp    8010590a <alltraps>

80106843 <vector253>:
.globl vector253
vector253:
  pushl $0
80106843:	6a 00                	push   $0x0
  pushl $253
80106845:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
8010684a:	e9 bb f0 ff ff       	jmp    8010590a <alltraps>

8010684f <vector254>:
.globl vector254
vector254:
  pushl $0
8010684f:	6a 00                	push   $0x0
  pushl $254
80106851:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106856:	e9 af f0 ff ff       	jmp    8010590a <alltraps>

8010685b <vector255>:
.globl vector255
vector255:
  pushl $0
8010685b:	6a 00                	push   $0x0
  pushl $255
8010685d:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106862:	e9 a3 f0 ff ff       	jmp    8010590a <alltraps>
80106867:	66 90                	xchg   %ax,%ax
80106869:	66 90                	xchg   %ax,%ax
8010686b:	66 90                	xchg   %ax,%ax
8010686d:	66 90                	xchg   %ax,%ax
8010686f:	90                   	nop

80106870 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106870:	55                   	push   %ebp
80106871:	89 e5                	mov    %esp,%ebp
80106873:	57                   	push   %edi
80106874:	56                   	push   %esi
80106875:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80106876:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
8010687c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80106882:	83 ec 1c             	sub    $0x1c,%esp
  for(; a  < oldsz; a += PGSIZE){
80106885:	39 d3                	cmp    %edx,%ebx
80106887:	73 56                	jae    801068df <deallocuvm.part.0+0x6f>
80106889:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010688c:	89 c6                	mov    %eax,%esi
8010688e:	89 d7                	mov    %edx,%edi
80106890:	eb 12                	jmp    801068a4 <deallocuvm.part.0+0x34>
80106892:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80106898:	83 c2 01             	add    $0x1,%edx
8010689b:	89 d3                	mov    %edx,%ebx
8010689d:	c1 e3 16             	shl    $0x16,%ebx
  for(; a  < oldsz; a += PGSIZE){
801068a0:	39 fb                	cmp    %edi,%ebx
801068a2:	73 38                	jae    801068dc <deallocuvm.part.0+0x6c>
  pde = &pgdir[PDX(va)];
801068a4:	89 da                	mov    %ebx,%edx
801068a6:	c1 ea 16             	shr    $0x16,%edx
  if(*pde & PTE_P){
801068a9:	8b 04 96             	mov    (%esi,%edx,4),%eax
801068ac:	a8 01                	test   $0x1,%al
801068ae:	74 e8                	je     80106898 <deallocuvm.part.0+0x28>
  return &pgtab[PTX(va)];
801068b0:	89 d9                	mov    %ebx,%ecx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801068b2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
801068b7:	c1 e9 0a             	shr    $0xa,%ecx
801068ba:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
801068c0:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
    if(!pte)
801068c7:	85 c0                	test   %eax,%eax
801068c9:	74 cd                	je     80106898 <deallocuvm.part.0+0x28>
    else if((*pte & PTE_P) != 0){
801068cb:	8b 10                	mov    (%eax),%edx
801068cd:	f6 c2 01             	test   $0x1,%dl
801068d0:	75 1e                	jne    801068f0 <deallocuvm.part.0+0x80>
  for(; a  < oldsz; a += PGSIZE){
801068d2:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801068d8:	39 fb                	cmp    %edi,%ebx
801068da:	72 c8                	jb     801068a4 <deallocuvm.part.0+0x34>
801068dc:	8b 4d e0             	mov    -0x20(%ebp),%ecx
      kfree(v);
      *pte = 0;
    }
  }
  return newsz;
}
801068df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801068e2:	89 c8                	mov    %ecx,%eax
801068e4:	5b                   	pop    %ebx
801068e5:	5e                   	pop    %esi
801068e6:	5f                   	pop    %edi
801068e7:	5d                   	pop    %ebp
801068e8:	c3                   	ret
801068e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(pa == 0)
801068f0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801068f6:	74 26                	je     8010691e <deallocuvm.part.0+0xae>
      kfree(v);
801068f8:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
801068fb:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80106901:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80106904:	81 c3 00 10 00 00    	add    $0x1000,%ebx
      kfree(v);
8010690a:	52                   	push   %edx
8010690b:	e8 60 bc ff ff       	call   80102570 <kfree>
      *pte = 0;
80106910:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  for(; a  < oldsz; a += PGSIZE){
80106913:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
80106916:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010691c:	eb 82                	jmp    801068a0 <deallocuvm.part.0+0x30>
        panic("kfree");
8010691e:	83 ec 0c             	sub    $0xc,%esp
80106921:	68 0c 74 10 80       	push   $0x8010740c
80106926:	e8 55 9a ff ff       	call   80100380 <panic>
8010692b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80106930 <mappages>:
{
80106930:	55                   	push   %ebp
80106931:	89 e5                	mov    %esp,%ebp
80106933:	57                   	push   %edi
80106934:	56                   	push   %esi
80106935:	53                   	push   %ebx
  a = (char*)PGROUNDDOWN((uint)va);
80106936:	89 d3                	mov    %edx,%ebx
80106938:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
8010693e:	83 ec 1c             	sub    $0x1c,%esp
80106941:	89 45 e0             	mov    %eax,-0x20(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106944:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106948:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010694d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106950:	8b 45 08             	mov    0x8(%ebp),%eax
80106953:	29 d8                	sub    %ebx,%eax
80106955:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106958:	eb 3f                	jmp    80106999 <mappages+0x69>
8010695a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106960:	89 da                	mov    %ebx,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106962:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80106967:	c1 ea 0a             	shr    $0xa,%edx
8010696a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106970:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106977:	85 c0                	test   %eax,%eax
80106979:	74 75                	je     801069f0 <mappages+0xc0>
    if(*pte & PTE_P)
8010697b:	f6 00 01             	testb  $0x1,(%eax)
8010697e:	0f 85 86 00 00 00    	jne    80106a0a <mappages+0xda>
    *pte = pa | perm | PTE_P;
80106984:	0b 75 0c             	or     0xc(%ebp),%esi
80106987:	83 ce 01             	or     $0x1,%esi
8010698a:	89 30                	mov    %esi,(%eax)
    if(a == last)
8010698c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010698f:	39 c3                	cmp    %eax,%ebx
80106991:	74 6d                	je     80106a00 <mappages+0xd0>
    a += PGSIZE;
80106993:	81 c3 00 10 00 00    	add    $0x1000,%ebx
  for(;;){
80106999:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  pde = &pgdir[PDX(va)];
8010699c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010699f:	8d 34 03             	lea    (%ebx,%eax,1),%esi
801069a2:	89 d8                	mov    %ebx,%eax
801069a4:	c1 e8 16             	shr    $0x16,%eax
801069a7:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
  if(*pde & PTE_P){
801069aa:	8b 07                	mov    (%edi),%eax
801069ac:	a8 01                	test   $0x1,%al
801069ae:	75 b0                	jne    80106960 <mappages+0x30>
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
801069b0:	e8 7b bd ff ff       	call   80102730 <kalloc>
801069b5:	85 c0                	test   %eax,%eax
801069b7:	74 37                	je     801069f0 <mappages+0xc0>
    memset(pgtab, 0, PGSIZE);
801069b9:	83 ec 04             	sub    $0x4,%esp
801069bc:	68 00 10 00 00       	push   $0x1000
801069c1:	6a 00                	push   $0x0
801069c3:	50                   	push   %eax
801069c4:	89 45 d8             	mov    %eax,-0x28(%ebp)
801069c7:	e8 a4 dd ff ff       	call   80104770 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801069cc:	8b 55 d8             	mov    -0x28(%ebp),%edx
  return &pgtab[PTX(va)];
801069cf:	83 c4 10             	add    $0x10,%esp
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
801069d2:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
801069d8:	83 c8 07             	or     $0x7,%eax
801069db:	89 07                	mov    %eax,(%edi)
  return &pgtab[PTX(va)];
801069dd:	89 d8                	mov    %ebx,%eax
801069df:	c1 e8 0a             	shr    $0xa,%eax
801069e2:	25 fc 0f 00 00       	and    $0xffc,%eax
801069e7:	01 d0                	add    %edx,%eax
801069e9:	eb 90                	jmp    8010697b <mappages+0x4b>
801069eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
}
801069f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
801069f3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801069f8:	5b                   	pop    %ebx
801069f9:	5e                   	pop    %esi
801069fa:	5f                   	pop    %edi
801069fb:	5d                   	pop    %ebp
801069fc:	c3                   	ret
801069fd:	8d 76 00             	lea    0x0(%esi),%esi
80106a00:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106a03:	31 c0                	xor    %eax,%eax
}
80106a05:	5b                   	pop    %ebx
80106a06:	5e                   	pop    %esi
80106a07:	5f                   	pop    %edi
80106a08:	5d                   	pop    %ebp
80106a09:	c3                   	ret
      panic("remap");
80106a0a:	83 ec 0c             	sub    $0xc,%esp
80106a0d:	68 40 76 10 80       	push   $0x80107640
80106a12:	e8 69 99 ff ff       	call   80100380 <panic>
80106a17:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106a1e:	00 
80106a1f:	90                   	nop

80106a20 <seginit>:
{
80106a20:	55                   	push   %ebp
80106a21:	89 e5                	mov    %esp,%ebp
80106a23:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
80106a26:	e8 e5 cf ff ff       	call   80103a10 <cpuid>
  pd[0] = size-1;
80106a2b:	ba 2f 00 00 00       	mov    $0x2f,%edx
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
80106a30:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80106a36:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
80106a3a:	c7 80 18 18 11 80 ff 	movl   $0xffff,-0x7feee7e8(%eax)
80106a41:	ff 00 00 
80106a44:	c7 80 1c 18 11 80 00 	movl   $0xcf9a00,-0x7feee7e4(%eax)
80106a4b:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
80106a4e:	c7 80 20 18 11 80 ff 	movl   $0xffff,-0x7feee7e0(%eax)
80106a55:	ff 00 00 
80106a58:	c7 80 24 18 11 80 00 	movl   $0xcf9200,-0x7feee7dc(%eax)
80106a5f:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80106a62:	c7 80 28 18 11 80 ff 	movl   $0xffff,-0x7feee7d8(%eax)
80106a69:	ff 00 00 
80106a6c:	c7 80 2c 18 11 80 00 	movl   $0xcffa00,-0x7feee7d4(%eax)
80106a73:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80106a76:	c7 80 30 18 11 80 ff 	movl   $0xffff,-0x7feee7d0(%eax)
80106a7d:	ff 00 00 
80106a80:	c7 80 34 18 11 80 00 	movl   $0xcff200,-0x7feee7cc(%eax)
80106a87:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
80106a8a:	05 10 18 11 80       	add    $0x80111810,%eax
  pd[1] = (uint)p;
80106a8f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80106a93:	c1 e8 10             	shr    $0x10,%eax
80106a96:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
80106a9a:	8d 45 f2             	lea    -0xe(%ebp),%eax
80106a9d:	0f 01 10             	lgdtl  (%eax)
}
80106aa0:	c9                   	leave
80106aa1:	c3                   	ret
80106aa2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106aa9:	00 
80106aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106ab0 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106ab0:	a1 c4 44 11 80       	mov    0x801144c4,%eax
80106ab5:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106aba:	0f 22 d8             	mov    %eax,%cr3
}
80106abd:	c3                   	ret
80106abe:	66 90                	xchg   %ax,%ax

80106ac0 <switchuvm>:
{
80106ac0:	55                   	push   %ebp
80106ac1:	89 e5                	mov    %esp,%ebp
80106ac3:	57                   	push   %edi
80106ac4:	56                   	push   %esi
80106ac5:	53                   	push   %ebx
80106ac6:	83 ec 1c             	sub    $0x1c,%esp
80106ac9:	8b 75 08             	mov    0x8(%ebp),%esi
  if(p == 0)
80106acc:	85 f6                	test   %esi,%esi
80106ace:	0f 84 cb 00 00 00    	je     80106b9f <switchuvm+0xdf>
  if(p->kstack == 0)
80106ad4:	8b 46 08             	mov    0x8(%esi),%eax
80106ad7:	85 c0                	test   %eax,%eax
80106ad9:	0f 84 da 00 00 00    	je     80106bb9 <switchuvm+0xf9>
  if(p->pgdir == 0)
80106adf:	8b 46 04             	mov    0x4(%esi),%eax
80106ae2:	85 c0                	test   %eax,%eax
80106ae4:	0f 84 c2 00 00 00    	je     80106bac <switchuvm+0xec>
  pushcli();
80106aea:	e8 31 da ff ff       	call   80104520 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106aef:	e8 bc ce ff ff       	call   801039b0 <mycpu>
80106af4:	89 c3                	mov    %eax,%ebx
80106af6:	e8 b5 ce ff ff       	call   801039b0 <mycpu>
80106afb:	89 c7                	mov    %eax,%edi
80106afd:	e8 ae ce ff ff       	call   801039b0 <mycpu>
80106b02:	83 c7 08             	add    $0x8,%edi
80106b05:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106b08:	e8 a3 ce ff ff       	call   801039b0 <mycpu>
80106b0d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80106b10:	ba 67 00 00 00       	mov    $0x67,%edx
80106b15:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
80106b1c:	83 c0 08             	add    $0x8,%eax
80106b1f:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106b26:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80106b2b:	83 c1 08             	add    $0x8,%ecx
80106b2e:	c1 e8 18             	shr    $0x18,%eax
80106b31:	c1 e9 10             	shr    $0x10,%ecx
80106b34:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
80106b3a:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80106b40:	b9 99 40 00 00       	mov    $0x4099,%ecx
80106b45:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106b4c:	bb 10 00 00 00       	mov    $0x10,%ebx
  mycpu()->gdt[SEG_TSS].s = 0;
80106b51:	e8 5a ce ff ff       	call   801039b0 <mycpu>
80106b56:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80106b5d:	e8 4e ce ff ff       	call   801039b0 <mycpu>
80106b62:	66 89 58 10          	mov    %bx,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80106b66:	8b 5e 08             	mov    0x8(%esi),%ebx
80106b69:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80106b6f:	e8 3c ce ff ff       	call   801039b0 <mycpu>
80106b74:	89 58 0c             	mov    %ebx,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80106b77:	e8 34 ce ff ff       	call   801039b0 <mycpu>
80106b7c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80106b80:	b8 28 00 00 00       	mov    $0x28,%eax
80106b85:	0f 00 d8             	ltr    %eax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80106b88:	8b 46 04             	mov    0x4(%esi),%eax
80106b8b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80106b90:	0f 22 d8             	mov    %eax,%cr3
}
80106b93:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106b96:	5b                   	pop    %ebx
80106b97:	5e                   	pop    %esi
80106b98:	5f                   	pop    %edi
80106b99:	5d                   	pop    %ebp
  popcli();
80106b9a:	e9 d1 d9 ff ff       	jmp    80104570 <popcli>
    panic("switchuvm: no process");
80106b9f:	83 ec 0c             	sub    $0xc,%esp
80106ba2:	68 46 76 10 80       	push   $0x80107646
80106ba7:	e8 d4 97 ff ff       	call   80100380 <panic>
    panic("switchuvm: no pgdir");
80106bac:	83 ec 0c             	sub    $0xc,%esp
80106baf:	68 71 76 10 80       	push   $0x80107671
80106bb4:	e8 c7 97 ff ff       	call   80100380 <panic>
    panic("switchuvm: no kstack");
80106bb9:	83 ec 0c             	sub    $0xc,%esp
80106bbc:	68 5c 76 10 80       	push   $0x8010765c
80106bc1:	e8 ba 97 ff ff       	call   80100380 <panic>
80106bc6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106bcd:	00 
80106bce:	66 90                	xchg   %ax,%ax

80106bd0 <inituvm>:
{
80106bd0:	55                   	push   %ebp
80106bd1:	89 e5                	mov    %esp,%ebp
80106bd3:	57                   	push   %edi
80106bd4:	56                   	push   %esi
80106bd5:	53                   	push   %ebx
80106bd6:	83 ec 1c             	sub    $0x1c,%esp
80106bd9:	8b 45 08             	mov    0x8(%ebp),%eax
80106bdc:	8b 75 10             	mov    0x10(%ebp),%esi
80106bdf:	8b 7d 0c             	mov    0xc(%ebp),%edi
80106be2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
80106be5:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80106beb:	77 49                	ja     80106c36 <inituvm+0x66>
  mem = kalloc();
80106bed:	e8 3e bb ff ff       	call   80102730 <kalloc>
  memset(mem, 0, PGSIZE);
80106bf2:	83 ec 04             	sub    $0x4,%esp
80106bf5:	68 00 10 00 00       	push   $0x1000
  mem = kalloc();
80106bfa:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80106bfc:	6a 00                	push   $0x0
80106bfe:	50                   	push   %eax
80106bff:	e8 6c db ff ff       	call   80104770 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80106c04:	58                   	pop    %eax
80106c05:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106c0b:	5a                   	pop    %edx
80106c0c:	6a 06                	push   $0x6
80106c0e:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106c13:	31 d2                	xor    %edx,%edx
80106c15:	50                   	push   %eax
80106c16:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106c19:	e8 12 fd ff ff       	call   80106930 <mappages>
  memmove(mem, init, sz);
80106c1e:	83 c4 10             	add    $0x10,%esp
80106c21:	89 75 10             	mov    %esi,0x10(%ebp)
80106c24:	89 7d 0c             	mov    %edi,0xc(%ebp)
80106c27:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
80106c2a:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106c2d:	5b                   	pop    %ebx
80106c2e:	5e                   	pop    %esi
80106c2f:	5f                   	pop    %edi
80106c30:	5d                   	pop    %ebp
  memmove(mem, init, sz);
80106c31:	e9 ca db ff ff       	jmp    80104800 <memmove>
    panic("inituvm: more than a page");
80106c36:	83 ec 0c             	sub    $0xc,%esp
80106c39:	68 85 76 10 80       	push   $0x80107685
80106c3e:	e8 3d 97 ff ff       	call   80100380 <panic>
80106c43:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106c4a:	00 
80106c4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80106c50 <loaduvm>:
{
80106c50:	55                   	push   %ebp
80106c51:	89 e5                	mov    %esp,%ebp
80106c53:	57                   	push   %edi
80106c54:	56                   	push   %esi
80106c55:	53                   	push   %ebx
80106c56:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
80106c59:	8b 75 0c             	mov    0xc(%ebp),%esi
{
80106c5c:	8b 7d 18             	mov    0x18(%ebp),%edi
  if((uint) addr % PGSIZE != 0)
80106c5f:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
80106c65:	0f 85 a2 00 00 00    	jne    80106d0d <loaduvm+0xbd>
  for(i = 0; i < sz; i += PGSIZE){
80106c6b:	85 ff                	test   %edi,%edi
80106c6d:	74 7d                	je     80106cec <loaduvm+0x9c>
80106c6f:	90                   	nop
  pde = &pgdir[PDX(va)];
80106c70:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80106c73:	8b 55 08             	mov    0x8(%ebp),%edx
80106c76:	01 f0                	add    %esi,%eax
  pde = &pgdir[PDX(va)];
80106c78:	89 c1                	mov    %eax,%ecx
80106c7a:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80106c7d:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
80106c80:	f6 c1 01             	test   $0x1,%cl
80106c83:	75 13                	jne    80106c98 <loaduvm+0x48>
      panic("loaduvm: address should exist");
80106c85:	83 ec 0c             	sub    $0xc,%esp
80106c88:	68 9f 76 10 80       	push   $0x8010769f
80106c8d:	e8 ee 96 ff ff       	call   80100380 <panic>
80106c92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return &pgtab[PTX(va)];
80106c98:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106c9b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
80106ca1:	25 fc 0f 00 00       	and    $0xffc,%eax
80106ca6:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80106cad:	85 c9                	test   %ecx,%ecx
80106caf:	74 d4                	je     80106c85 <loaduvm+0x35>
    if(sz - i < PGSIZE)
80106cb1:	89 fb                	mov    %edi,%ebx
80106cb3:	b8 00 10 00 00       	mov    $0x1000,%eax
80106cb8:	29 f3                	sub    %esi,%ebx
80106cba:	39 c3                	cmp    %eax,%ebx
80106cbc:	0f 47 d8             	cmova  %eax,%ebx
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106cbf:	53                   	push   %ebx
80106cc0:	8b 45 14             	mov    0x14(%ebp),%eax
80106cc3:	01 f0                	add    %esi,%eax
80106cc5:	50                   	push   %eax
    pa = PTE_ADDR(*pte);
80106cc6:	8b 01                	mov    (%ecx),%eax
80106cc8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
80106ccd:	05 00 00 00 80       	add    $0x80000000,%eax
80106cd2:	50                   	push   %eax
80106cd3:	ff 75 10             	push   0x10(%ebp)
80106cd6:	e8 a5 ae ff ff       	call   80101b80 <readi>
80106cdb:	83 c4 10             	add    $0x10,%esp
80106cde:	39 d8                	cmp    %ebx,%eax
80106ce0:	75 1e                	jne    80106d00 <loaduvm+0xb0>
  for(i = 0; i < sz; i += PGSIZE){
80106ce2:	81 c6 00 10 00 00    	add    $0x1000,%esi
80106ce8:	39 fe                	cmp    %edi,%esi
80106cea:	72 84                	jb     80106c70 <loaduvm+0x20>
}
80106cec:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106cef:	31 c0                	xor    %eax,%eax
}
80106cf1:	5b                   	pop    %ebx
80106cf2:	5e                   	pop    %esi
80106cf3:	5f                   	pop    %edi
80106cf4:	5d                   	pop    %ebp
80106cf5:	c3                   	ret
80106cf6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106cfd:	00 
80106cfe:	66 90                	xchg   %ax,%ax
80106d00:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106d03:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106d08:	5b                   	pop    %ebx
80106d09:	5e                   	pop    %esi
80106d0a:	5f                   	pop    %edi
80106d0b:	5d                   	pop    %ebp
80106d0c:	c3                   	ret
    panic("loaduvm: addr must be page aligned");
80106d0d:	83 ec 0c             	sub    $0xc,%esp
80106d10:	68 c0 78 10 80       	push   $0x801078c0
80106d15:	e8 66 96 ff ff       	call   80100380 <panic>
80106d1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106d20 <allocuvm>:
{
80106d20:	55                   	push   %ebp
80106d21:	89 e5                	mov    %esp,%ebp
80106d23:	57                   	push   %edi
80106d24:	56                   	push   %esi
80106d25:	53                   	push   %ebx
80106d26:	83 ec 1c             	sub    $0x1c,%esp
80106d29:	8b 75 10             	mov    0x10(%ebp),%esi
  if(newsz >= KERNBASE)
80106d2c:	85 f6                	test   %esi,%esi
80106d2e:	0f 88 98 00 00 00    	js     80106dcc <allocuvm+0xac>
80106d34:	89 f2                	mov    %esi,%edx
  if(newsz < oldsz)
80106d36:	3b 75 0c             	cmp    0xc(%ebp),%esi
80106d39:	0f 82 a1 00 00 00    	jb     80106de0 <allocuvm+0xc0>
  a = PGROUNDUP(oldsz);
80106d3f:	8b 45 0c             	mov    0xc(%ebp),%eax
80106d42:	05 ff 0f 00 00       	add    $0xfff,%eax
80106d47:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106d4c:	89 c7                	mov    %eax,%edi
  for(; a < newsz; a += PGSIZE){
80106d4e:	39 f0                	cmp    %esi,%eax
80106d50:	0f 83 8d 00 00 00    	jae    80106de3 <allocuvm+0xc3>
80106d56:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80106d59:	eb 44                	jmp    80106d9f <allocuvm+0x7f>
80106d5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    memset(mem, 0, PGSIZE);
80106d60:	83 ec 04             	sub    $0x4,%esp
80106d63:	68 00 10 00 00       	push   $0x1000
80106d68:	6a 00                	push   $0x0
80106d6a:	50                   	push   %eax
80106d6b:	e8 00 da ff ff       	call   80104770 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80106d70:	58                   	pop    %eax
80106d71:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106d77:	5a                   	pop    %edx
80106d78:	6a 06                	push   $0x6
80106d7a:	b9 00 10 00 00       	mov    $0x1000,%ecx
80106d7f:	89 fa                	mov    %edi,%edx
80106d81:	50                   	push   %eax
80106d82:	8b 45 08             	mov    0x8(%ebp),%eax
80106d85:	e8 a6 fb ff ff       	call   80106930 <mappages>
80106d8a:	83 c4 10             	add    $0x10,%esp
80106d8d:	85 c0                	test   %eax,%eax
80106d8f:	78 5f                	js     80106df0 <allocuvm+0xd0>
  for(; a < newsz; a += PGSIZE){
80106d91:	81 c7 00 10 00 00    	add    $0x1000,%edi
80106d97:	39 f7                	cmp    %esi,%edi
80106d99:	0f 83 89 00 00 00    	jae    80106e28 <allocuvm+0x108>
    mem = kalloc();
80106d9f:	e8 8c b9 ff ff       	call   80102730 <kalloc>
80106da4:	89 c3                	mov    %eax,%ebx
    if(mem == 0){
80106da6:	85 c0                	test   %eax,%eax
80106da8:	75 b6                	jne    80106d60 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
80106daa:	83 ec 0c             	sub    $0xc,%esp
80106dad:	68 bd 76 10 80       	push   $0x801076bd
80106db2:	e8 89 99 ff ff       	call   80100740 <cprintf>
  if(newsz >= oldsz)
80106db7:	83 c4 10             	add    $0x10,%esp
80106dba:	3b 75 0c             	cmp    0xc(%ebp),%esi
80106dbd:	74 0d                	je     80106dcc <allocuvm+0xac>
80106dbf:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106dc2:	8b 45 08             	mov    0x8(%ebp),%eax
80106dc5:	89 f2                	mov    %esi,%edx
80106dc7:	e8 a4 fa ff ff       	call   80106870 <deallocuvm.part.0>
    return 0;
80106dcc:	31 d2                	xor    %edx,%edx
}
80106dce:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106dd1:	89 d0                	mov    %edx,%eax
80106dd3:	5b                   	pop    %ebx
80106dd4:	5e                   	pop    %esi
80106dd5:	5f                   	pop    %edi
80106dd6:	5d                   	pop    %ebp
80106dd7:	c3                   	ret
80106dd8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106ddf:	00 
    return oldsz;
80106de0:	8b 55 0c             	mov    0xc(%ebp),%edx
}
80106de3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106de6:	89 d0                	mov    %edx,%eax
80106de8:	5b                   	pop    %ebx
80106de9:	5e                   	pop    %esi
80106dea:	5f                   	pop    %edi
80106deb:	5d                   	pop    %ebp
80106dec:	c3                   	ret
80106ded:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80106df0:	83 ec 0c             	sub    $0xc,%esp
80106df3:	68 d5 76 10 80       	push   $0x801076d5
80106df8:	e8 43 99 ff ff       	call   80100740 <cprintf>
  if(newsz >= oldsz)
80106dfd:	83 c4 10             	add    $0x10,%esp
80106e00:	3b 75 0c             	cmp    0xc(%ebp),%esi
80106e03:	74 0d                	je     80106e12 <allocuvm+0xf2>
80106e05:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106e08:	8b 45 08             	mov    0x8(%ebp),%eax
80106e0b:	89 f2                	mov    %esi,%edx
80106e0d:	e8 5e fa ff ff       	call   80106870 <deallocuvm.part.0>
      kfree(mem);
80106e12:	83 ec 0c             	sub    $0xc,%esp
80106e15:	53                   	push   %ebx
80106e16:	e8 55 b7 ff ff       	call   80102570 <kfree>
      return 0;
80106e1b:	83 c4 10             	add    $0x10,%esp
    return 0;
80106e1e:	31 d2                	xor    %edx,%edx
80106e20:	eb ac                	jmp    80106dce <allocuvm+0xae>
80106e22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106e28:	8b 55 e4             	mov    -0x1c(%ebp),%edx
}
80106e2b:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106e2e:	5b                   	pop    %ebx
80106e2f:	5e                   	pop    %esi
80106e30:	89 d0                	mov    %edx,%eax
80106e32:	5f                   	pop    %edi
80106e33:	5d                   	pop    %ebp
80106e34:	c3                   	ret
80106e35:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106e3c:	00 
80106e3d:	8d 76 00             	lea    0x0(%esi),%esi

80106e40 <deallocuvm>:
{
80106e40:	55                   	push   %ebp
80106e41:	89 e5                	mov    %esp,%ebp
80106e43:	8b 55 0c             	mov    0xc(%ebp),%edx
80106e46:	8b 4d 10             	mov    0x10(%ebp),%ecx
80106e49:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
80106e4c:	39 d1                	cmp    %edx,%ecx
80106e4e:	73 10                	jae    80106e60 <deallocuvm+0x20>
}
80106e50:	5d                   	pop    %ebp
80106e51:	e9 1a fa ff ff       	jmp    80106870 <deallocuvm.part.0>
80106e56:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106e5d:	00 
80106e5e:	66 90                	xchg   %ax,%ax
80106e60:	89 d0                	mov    %edx,%eax
80106e62:	5d                   	pop    %ebp
80106e63:	c3                   	ret
80106e64:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106e6b:	00 
80106e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106e70 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80106e70:	55                   	push   %ebp
80106e71:	89 e5                	mov    %esp,%ebp
80106e73:	57                   	push   %edi
80106e74:	56                   	push   %esi
80106e75:	53                   	push   %ebx
80106e76:	83 ec 0c             	sub    $0xc,%esp
80106e79:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
80106e7c:	85 f6                	test   %esi,%esi
80106e7e:	74 59                	je     80106ed9 <freevm+0x69>
  if(newsz >= oldsz)
80106e80:	31 c9                	xor    %ecx,%ecx
80106e82:	ba 00 00 00 80       	mov    $0x80000000,%edx
80106e87:	89 f0                	mov    %esi,%eax
80106e89:	89 f3                	mov    %esi,%ebx
80106e8b:	e8 e0 f9 ff ff       	call   80106870 <deallocuvm.part.0>
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80106e90:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80106e96:	eb 0f                	jmp    80106ea7 <freevm+0x37>
80106e98:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106e9f:	00 
80106ea0:	83 c3 04             	add    $0x4,%ebx
80106ea3:	39 fb                	cmp    %edi,%ebx
80106ea5:	74 23                	je     80106eca <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80106ea7:	8b 03                	mov    (%ebx),%eax
80106ea9:	a8 01                	test   $0x1,%al
80106eab:	74 f3                	je     80106ea0 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106ead:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80106eb2:	83 ec 0c             	sub    $0xc,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106eb5:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80106eb8:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
80106ebd:	50                   	push   %eax
80106ebe:	e8 ad b6 ff ff       	call   80102570 <kfree>
80106ec3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80106ec6:	39 fb                	cmp    %edi,%ebx
80106ec8:	75 dd                	jne    80106ea7 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80106eca:	89 75 08             	mov    %esi,0x8(%ebp)
}
80106ecd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106ed0:	5b                   	pop    %ebx
80106ed1:	5e                   	pop    %esi
80106ed2:	5f                   	pop    %edi
80106ed3:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80106ed4:	e9 97 b6 ff ff       	jmp    80102570 <kfree>
    panic("freevm: no pgdir");
80106ed9:	83 ec 0c             	sub    $0xc,%esp
80106edc:	68 f1 76 10 80       	push   $0x801076f1
80106ee1:	e8 9a 94 ff ff       	call   80100380 <panic>
80106ee6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106eed:	00 
80106eee:	66 90                	xchg   %ax,%ax

80106ef0 <setupkvm>:
{
80106ef0:	55                   	push   %ebp
80106ef1:	89 e5                	mov    %esp,%ebp
80106ef3:	56                   	push   %esi
80106ef4:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80106ef5:	e8 36 b8 ff ff       	call   80102730 <kalloc>
80106efa:	85 c0                	test   %eax,%eax
80106efc:	74 5e                	je     80106f5c <setupkvm+0x6c>
  memset(pgdir, 0, PGSIZE);
80106efe:	83 ec 04             	sub    $0x4,%esp
80106f01:	89 c6                	mov    %eax,%esi
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106f03:	bb 20 a4 10 80       	mov    $0x8010a420,%ebx
  memset(pgdir, 0, PGSIZE);
80106f08:	68 00 10 00 00       	push   $0x1000
80106f0d:	6a 00                	push   $0x0
80106f0f:	50                   	push   %eax
80106f10:	e8 5b d8 ff ff       	call   80104770 <memset>
80106f15:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
80106f18:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80106f1b:	83 ec 08             	sub    $0x8,%esp
80106f1e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80106f21:	8b 13                	mov    (%ebx),%edx
80106f23:	ff 73 0c             	push   0xc(%ebx)
80106f26:	50                   	push   %eax
80106f27:	29 c1                	sub    %eax,%ecx
80106f29:	89 f0                	mov    %esi,%eax
80106f2b:	e8 00 fa ff ff       	call   80106930 <mappages>
80106f30:	83 c4 10             	add    $0x10,%esp
80106f33:	85 c0                	test   %eax,%eax
80106f35:	78 19                	js     80106f50 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80106f37:	83 c3 10             	add    $0x10,%ebx
80106f3a:	81 fb 60 a4 10 80    	cmp    $0x8010a460,%ebx
80106f40:	75 d6                	jne    80106f18 <setupkvm+0x28>
}
80106f42:	8d 65 f8             	lea    -0x8(%ebp),%esp
80106f45:	89 f0                	mov    %esi,%eax
80106f47:	5b                   	pop    %ebx
80106f48:	5e                   	pop    %esi
80106f49:	5d                   	pop    %ebp
80106f4a:	c3                   	ret
80106f4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
80106f50:	83 ec 0c             	sub    $0xc,%esp
80106f53:	56                   	push   %esi
80106f54:	e8 17 ff ff ff       	call   80106e70 <freevm>
      return 0;
80106f59:	83 c4 10             	add    $0x10,%esp
}
80106f5c:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return 0;
80106f5f:	31 f6                	xor    %esi,%esi
}
80106f61:	89 f0                	mov    %esi,%eax
80106f63:	5b                   	pop    %ebx
80106f64:	5e                   	pop    %esi
80106f65:	5d                   	pop    %ebp
80106f66:	c3                   	ret
80106f67:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106f6e:	00 
80106f6f:	90                   	nop

80106f70 <kvmalloc>:
{
80106f70:	55                   	push   %ebp
80106f71:	89 e5                	mov    %esp,%ebp
80106f73:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80106f76:	e8 75 ff ff ff       	call   80106ef0 <setupkvm>
80106f7b:	a3 c4 44 11 80       	mov    %eax,0x801144c4
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80106f80:	05 00 00 00 80       	add    $0x80000000,%eax
80106f85:	0f 22 d8             	mov    %eax,%cr3
}
80106f88:	c9                   	leave
80106f89:	c3                   	ret
80106f8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106f90 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80106f90:	55                   	push   %ebp
80106f91:	89 e5                	mov    %esp,%ebp
80106f93:	83 ec 08             	sub    $0x8,%esp
80106f96:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80106f99:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80106f9c:	89 c1                	mov    %eax,%ecx
80106f9e:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
80106fa1:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80106fa4:	f6 c2 01             	test   $0x1,%dl
80106fa7:	75 17                	jne    80106fc0 <clearpteu+0x30>
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
  if(pte == 0)
    panic("clearpteu");
80106fa9:	83 ec 0c             	sub    $0xc,%esp
80106fac:	68 02 77 10 80       	push   $0x80107702
80106fb1:	e8 ca 93 ff ff       	call   80100380 <panic>
80106fb6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106fbd:	00 
80106fbe:	66 90                	xchg   %ax,%ax
  return &pgtab[PTX(va)];
80106fc0:	c1 e8 0a             	shr    $0xa,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106fc3:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  return &pgtab[PTX(va)];
80106fc9:	25 fc 0f 00 00       	and    $0xffc,%eax
80106fce:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
  if(pte == 0)
80106fd5:	85 c0                	test   %eax,%eax
80106fd7:	74 d0                	je     80106fa9 <clearpteu+0x19>
  *pte &= ~PTE_U;
80106fd9:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
80106fdc:	c9                   	leave
80106fdd:	c3                   	ret
80106fde:	66 90                	xchg   %ax,%ax

80106fe0 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80106fe0:	55                   	push   %ebp
80106fe1:	89 e5                	mov    %esp,%ebp
80106fe3:	57                   	push   %edi
80106fe4:	56                   	push   %esi
80106fe5:	53                   	push   %ebx
80106fe6:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80106fe9:	e8 02 ff ff ff       	call   80106ef0 <setupkvm>
80106fee:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106ff1:	85 c0                	test   %eax,%eax
80106ff3:	0f 84 e9 00 00 00    	je     801070e2 <copyuvm+0x102>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80106ff9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106ffc:	85 c9                	test   %ecx,%ecx
80106ffe:	0f 84 b2 00 00 00    	je     801070b6 <copyuvm+0xd6>
80107004:	31 f6                	xor    %esi,%esi
80107006:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010700d:	00 
8010700e:	66 90                	xchg   %ax,%ax
  if(*pde & PTE_P){
80107010:	8b 4d 08             	mov    0x8(%ebp),%ecx
  pde = &pgdir[PDX(va)];
80107013:	89 f0                	mov    %esi,%eax
80107015:	c1 e8 16             	shr    $0x16,%eax
  if(*pde & PTE_P){
80107018:	8b 04 81             	mov    (%ecx,%eax,4),%eax
8010701b:	a8 01                	test   $0x1,%al
8010701d:	75 11                	jne    80107030 <copyuvm+0x50>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
      panic("copyuvm: pte should exist");
8010701f:	83 ec 0c             	sub    $0xc,%esp
80107022:	68 0c 77 10 80       	push   $0x8010770c
80107027:	e8 54 93 ff ff       	call   80100380 <panic>
8010702c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return &pgtab[PTX(va)];
80107030:	89 f2                	mov    %esi,%edx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80107032:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  return &pgtab[PTX(va)];
80107037:	c1 ea 0a             	shr    $0xa,%edx
8010703a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107040:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80107047:	85 c0                	test   %eax,%eax
80107049:	74 d4                	je     8010701f <copyuvm+0x3f>
    if(!(*pte & PTE_P))
8010704b:	8b 00                	mov    (%eax),%eax
8010704d:	a8 01                	test   $0x1,%al
8010704f:	0f 84 9f 00 00 00    	je     801070f4 <copyuvm+0x114>
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
80107055:	89 c7                	mov    %eax,%edi
    flags = PTE_FLAGS(*pte);
80107057:	25 ff 0f 00 00       	and    $0xfff,%eax
8010705c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    pa = PTE_ADDR(*pte);
8010705f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
    if((mem = kalloc()) == 0)
80107065:	e8 c6 b6 ff ff       	call   80102730 <kalloc>
8010706a:	89 c3                	mov    %eax,%ebx
8010706c:	85 c0                	test   %eax,%eax
8010706e:	74 64                	je     801070d4 <copyuvm+0xf4>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107070:	83 ec 04             	sub    $0x4,%esp
80107073:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107079:	68 00 10 00 00       	push   $0x1000
8010707e:	57                   	push   %edi
8010707f:	50                   	push   %eax
80107080:	e8 7b d7 ff ff       	call   80104800 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
80107085:	58                   	pop    %eax
80107086:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010708c:	5a                   	pop    %edx
8010708d:	ff 75 e4             	push   -0x1c(%ebp)
80107090:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107095:	89 f2                	mov    %esi,%edx
80107097:	50                   	push   %eax
80107098:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010709b:	e8 90 f8 ff ff       	call   80106930 <mappages>
801070a0:	83 c4 10             	add    $0x10,%esp
801070a3:	85 c0                	test   %eax,%eax
801070a5:	78 21                	js     801070c8 <copyuvm+0xe8>
  for(i = 0; i < sz; i += PGSIZE){
801070a7:	81 c6 00 10 00 00    	add    $0x1000,%esi
801070ad:	3b 75 0c             	cmp    0xc(%ebp),%esi
801070b0:	0f 82 5a ff ff ff    	jb     80107010 <copyuvm+0x30>
  return d;

bad:
  freevm(d);
  return 0;
}
801070b6:	8b 45 e0             	mov    -0x20(%ebp),%eax
801070b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070bc:	5b                   	pop    %ebx
801070bd:	5e                   	pop    %esi
801070be:	5f                   	pop    %edi
801070bf:	5d                   	pop    %ebp
801070c0:	c3                   	ret
801070c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
801070c8:	83 ec 0c             	sub    $0xc,%esp
801070cb:	53                   	push   %ebx
801070cc:	e8 9f b4 ff ff       	call   80102570 <kfree>
      goto bad;
801070d1:	83 c4 10             	add    $0x10,%esp
  freevm(d);
801070d4:	83 ec 0c             	sub    $0xc,%esp
801070d7:	ff 75 e0             	push   -0x20(%ebp)
801070da:	e8 91 fd ff ff       	call   80106e70 <freevm>
  return 0;
801070df:	83 c4 10             	add    $0x10,%esp
    return 0;
801070e2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
801070e9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801070ec:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070ef:	5b                   	pop    %ebx
801070f0:	5e                   	pop    %esi
801070f1:	5f                   	pop    %edi
801070f2:	5d                   	pop    %ebp
801070f3:	c3                   	ret
      panic("copyuvm: page not present");
801070f4:	83 ec 0c             	sub    $0xc,%esp
801070f7:	68 26 77 10 80       	push   $0x80107726
801070fc:	e8 7f 92 ff ff       	call   80100380 <panic>
80107101:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107108:	00 
80107109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107110 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107110:	55                   	push   %ebp
80107111:	89 e5                	mov    %esp,%ebp
80107113:	8b 45 0c             	mov    0xc(%ebp),%eax
  if(*pde & PTE_P){
80107116:	8b 55 08             	mov    0x8(%ebp),%edx
  pde = &pgdir[PDX(va)];
80107119:	89 c1                	mov    %eax,%ecx
8010711b:	c1 e9 16             	shr    $0x16,%ecx
  if(*pde & PTE_P){
8010711e:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107121:	f6 c2 01             	test   $0x1,%dl
80107124:	0f 84 f8 00 00 00    	je     80107222 <uva2ka.cold>
  return &pgtab[PTX(va)];
8010712a:	c1 e8 0c             	shr    $0xc,%eax
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
8010712d:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
  if((*pte & PTE_P) == 0)
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107133:	5d                   	pop    %ebp
  return &pgtab[PTX(va)];
80107134:	25 ff 03 00 00       	and    $0x3ff,%eax
  if((*pte & PTE_P) == 0)
80107139:	8b 94 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107140:	89 d0                	mov    %edx,%eax
80107142:	f7 d2                	not    %edx
80107144:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107149:	05 00 00 00 80       	add    $0x80000000,%eax
8010714e:	83 e2 05             	and    $0x5,%edx
80107151:	ba 00 00 00 00       	mov    $0x0,%edx
80107156:	0f 45 c2             	cmovne %edx,%eax
}
80107159:	c3                   	ret
8010715a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107160 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107160:	55                   	push   %ebp
80107161:	89 e5                	mov    %esp,%ebp
80107163:	57                   	push   %edi
80107164:	56                   	push   %esi
80107165:	53                   	push   %ebx
80107166:	83 ec 0c             	sub    $0xc,%esp
80107169:	8b 75 14             	mov    0x14(%ebp),%esi
8010716c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010716f:	8b 55 10             	mov    0x10(%ebp),%edx
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
80107172:	85 f6                	test   %esi,%esi
80107174:	75 51                	jne    801071c7 <copyout+0x67>
80107176:	e9 9d 00 00 00       	jmp    80107218 <copyout+0xb8>
8010717b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  return (char*)P2V(PTE_ADDR(*pte));
80107180:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107186:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
8010718c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80107192:	74 74                	je     80107208 <copyout+0xa8>
      return -1;
    n = PGSIZE - (va - va0);
80107194:	89 fb                	mov    %edi,%ebx
80107196:	29 c3                	sub    %eax,%ebx
80107198:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if(n > len)
8010719e:	39 f3                	cmp    %esi,%ebx
801071a0:	0f 47 de             	cmova  %esi,%ebx
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801071a3:	29 f8                	sub    %edi,%eax
801071a5:	83 ec 04             	sub    $0x4,%esp
801071a8:	01 c1                	add    %eax,%ecx
801071aa:	53                   	push   %ebx
801071ab:	52                   	push   %edx
801071ac:	89 55 10             	mov    %edx,0x10(%ebp)
801071af:	51                   	push   %ecx
801071b0:	e8 4b d6 ff ff       	call   80104800 <memmove>
    len -= n;
    buf += n;
801071b5:	8b 55 10             	mov    0x10(%ebp),%edx
    va = va0 + PGSIZE;
801071b8:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
  while(len > 0){
801071be:	83 c4 10             	add    $0x10,%esp
    buf += n;
801071c1:	01 da                	add    %ebx,%edx
  while(len > 0){
801071c3:	29 de                	sub    %ebx,%esi
801071c5:	74 51                	je     80107218 <copyout+0xb8>
  if(*pde & PTE_P){
801071c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  pde = &pgdir[PDX(va)];
801071ca:	89 c1                	mov    %eax,%ecx
    va0 = (uint)PGROUNDDOWN(va);
801071cc:	89 c7                	mov    %eax,%edi
  pde = &pgdir[PDX(va)];
801071ce:	c1 e9 16             	shr    $0x16,%ecx
    va0 = (uint)PGROUNDDOWN(va);
801071d1:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
  if(*pde & PTE_P){
801071d7:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
801071da:	f6 c1 01             	test   $0x1,%cl
801071dd:	0f 84 46 00 00 00    	je     80107229 <copyout.cold>
  return &pgtab[PTX(va)];
801071e3:	89 fb                	mov    %edi,%ebx
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
801071e5:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
  return &pgtab[PTX(va)];
801071eb:	c1 eb 0c             	shr    $0xc,%ebx
801071ee:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
  if((*pte & PTE_P) == 0)
801071f4:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
  if((*pte & PTE_U) == 0)
801071fb:	89 d9                	mov    %ebx,%ecx
801071fd:	f7 d1                	not    %ecx
801071ff:	83 e1 05             	and    $0x5,%ecx
80107202:	0f 84 78 ff ff ff    	je     80107180 <copyout+0x20>
  }
  return 0;
}
80107208:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
8010720b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107210:	5b                   	pop    %ebx
80107211:	5e                   	pop    %esi
80107212:	5f                   	pop    %edi
80107213:	5d                   	pop    %ebp
80107214:	c3                   	ret
80107215:	8d 76 00             	lea    0x0(%esi),%esi
80107218:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010721b:	31 c0                	xor    %eax,%eax
}
8010721d:	5b                   	pop    %ebx
8010721e:	5e                   	pop    %esi
8010721f:	5f                   	pop    %edi
80107220:	5d                   	pop    %ebp
80107221:	c3                   	ret

80107222 <uva2ka.cold>:
  if((*pte & PTE_P) == 0)
80107222:	a1 00 00 00 00       	mov    0x0,%eax
80107227:	0f 0b                	ud2

80107229 <copyout.cold>:
80107229:	a1 00 00 00 00       	mov    0x0,%eax
8010722e:	0f 0b                	ud2
