
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc 10 6c 11 80       	mov    $0x80116c10,%esp
8010002d:	b8 c0 38 10 80       	mov    $0x801038c0,%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx
80100044:	bb 54 b5 10 80       	mov    $0x8010b554,%ebx
80100049:	83 ec 0c             	sub    $0xc,%esp
8010004c:	68 00 7a 10 80       	push   $0x80107a00
80100051:	68 20 b5 10 80       	push   $0x8010b520
80100056:	e8 e5 4b 00 00       	call   80104c40 <initlock>
8010005b:	83 c4 10             	add    $0x10,%esp
8010005e:	b8 1c fc 10 80       	mov    $0x8010fc1c,%eax
80100063:	c7 05 6c fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc6c
8010006a:	fc 10 80 
8010006d:	c7 05 70 fc 10 80 1c 	movl   $0x8010fc1c,0x8010fc70
80100074:	fc 10 80 
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 d3                	mov    %edx,%ebx
80100082:	89 43 54             	mov    %eax,0x54(%ebx)
80100085:	83 ec 08             	sub    $0x8,%esp
80100088:	8d 43 0c             	lea    0xc(%ebx),%eax
8010008b:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
80100092:	68 07 7a 10 80       	push   $0x80107a07
80100097:	50                   	push   %eax
80100098:	e8 73 4a 00 00       	call   80104b10 <initsleeplock>
8010009d:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
801000a2:	8d 93 5c 02 00 00    	lea    0x25c(%ebx),%edx
801000a8:	83 c4 10             	add    $0x10,%esp
801000ab:	89 58 50             	mov    %ebx,0x50(%eax)
801000ae:	89 d8                	mov    %ebx,%eax
801000b0:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
801000b6:	81 fb c0 f9 10 80    	cmp    $0x8010f9c0,%ebx
801000bc:	75 c2                	jne    80100080 <binit+0x40>
801000be:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c1:	c9                   	leave
801000c2:	c3                   	ret
801000c3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801000ca:	00 
801000cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801000d0 <bread>:
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
801000df:	68 20 b5 10 80       	push   $0x8010b520
801000e4:	e8 47 4d 00 00       	call   80104e30 <acquire>
801000e9:	8b 1d 70 fc 10 80    	mov    0x8010fc70,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80100120:	8b 1d 6c fc 10 80    	mov    0x8010fc6c,%ebx
80100126:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 6e                	jmp    8010019e <bread+0xce>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 1c fc 10 80    	cmp    $0x8010fc1c,%ebx
80100139:	74 63                	je     8010019e <bread+0xce>
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 20 b5 10 80       	push   $0x8010b520
80100162:	e8 69 4c 00 00       	call   80104dd0 <release>
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 de 49 00 00       	call   80104b50 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	74 0e                	je     80100188 <bread+0xb8>
8010017a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010017d:	89 d8                	mov    %ebx,%eax
8010017f:	5b                   	pop    %ebx
80100180:	5e                   	pop    %esi
80100181:	5f                   	pop    %edi
80100182:	5d                   	pop    %ebp
80100183:	c3                   	ret
80100184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100188:	83 ec 0c             	sub    $0xc,%esp
8010018b:	53                   	push   %ebx
8010018c:	e8 bf 29 00 00       	call   80102b50 <iderw>
80100191:	83 c4 10             	add    $0x10,%esp
80100194:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100197:	89 d8                	mov    %ebx,%eax
80100199:	5b                   	pop    %ebx
8010019a:	5e                   	pop    %esi
8010019b:	5f                   	pop    %edi
8010019c:	5d                   	pop    %ebp
8010019d:	c3                   	ret
8010019e:	83 ec 0c             	sub    $0xc,%esp
801001a1:	68 0e 7a 10 80       	push   $0x80107a0e
801001a6:	e8 f5 01 00 00       	call   801003a0 <panic>
801001ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801001b0 <bwrite>:
801001b0:	55                   	push   %ebp
801001b1:	89 e5                	mov    %esp,%ebp
801001b3:	53                   	push   %ebx
801001b4:	83 ec 10             	sub    $0x10,%esp
801001b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001ba:	8d 43 0c             	lea    0xc(%ebx),%eax
801001bd:	50                   	push   %eax
801001be:	e8 2d 4a 00 00       	call   80104bf0 <holdingsleep>
801001c3:	83 c4 10             	add    $0x10,%esp
801001c6:	85 c0                	test   %eax,%eax
801001c8:	74 0f                	je     801001d9 <bwrite+0x29>
801001ca:	83 0b 04             	orl    $0x4,(%ebx)
801001cd:	89 5d 08             	mov    %ebx,0x8(%ebp)
801001d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001d3:	c9                   	leave
801001d4:	e9 77 29 00 00       	jmp    80102b50 <iderw>
801001d9:	83 ec 0c             	sub    $0xc,%esp
801001dc:	68 1f 7a 10 80       	push   $0x80107a1f
801001e1:	e8 ba 01 00 00       	call   801003a0 <panic>
801001e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801001ed:	00 
801001ee:	66 90                	xchg   %ax,%ax

801001f0 <brelse>:
801001f0:	55                   	push   %ebp
801001f1:	89 e5                	mov    %esp,%ebp
801001f3:	56                   	push   %esi
801001f4:	53                   	push   %ebx
801001f5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801001f8:	8d 73 0c             	lea    0xc(%ebx),%esi
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 ec 49 00 00       	call   80104bf0 <holdingsleep>
80100204:	83 c4 10             	add    $0x10,%esp
80100207:	85 c0                	test   %eax,%eax
80100209:	74 63                	je     8010026e <brelse+0x7e>
8010020b:	83 ec 0c             	sub    $0xc,%esp
8010020e:	56                   	push   %esi
8010020f:	e8 9c 49 00 00       	call   80104bb0 <releasesleep>
80100214:	c7 04 24 20 b5 10 80 	movl   $0x8010b520,(%esp)
8010021b:	e8 10 4c 00 00       	call   80104e30 <acquire>
80100220:	8b 43 4c             	mov    0x4c(%ebx),%eax
80100223:	83 c4 10             	add    $0x10,%esp
80100226:	83 e8 01             	sub    $0x1,%eax
80100229:	89 43 4c             	mov    %eax,0x4c(%ebx)
8010022c:	85 c0                	test   %eax,%eax
8010022e:	75 2c                	jne    8010025c <brelse+0x6c>
80100230:	8b 53 54             	mov    0x54(%ebx),%edx
80100233:	8b 43 50             	mov    0x50(%ebx),%eax
80100236:	89 42 50             	mov    %eax,0x50(%edx)
80100239:	8b 53 54             	mov    0x54(%ebx),%edx
8010023c:	89 50 54             	mov    %edx,0x54(%eax)
8010023f:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100244:	c7 43 50 1c fc 10 80 	movl   $0x8010fc1c,0x50(%ebx)
8010024b:	89 43 54             	mov    %eax,0x54(%ebx)
8010024e:	a1 70 fc 10 80       	mov    0x8010fc70,%eax
80100253:	89 58 50             	mov    %ebx,0x50(%eax)
80100256:	89 1d 70 fc 10 80    	mov    %ebx,0x8010fc70
8010025c:	c7 45 08 20 b5 10 80 	movl   $0x8010b520,0x8(%ebp)
80100263:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100266:	5b                   	pop    %ebx
80100267:	5e                   	pop    %esi
80100268:	5d                   	pop    %ebp
80100269:	e9 62 4b 00 00       	jmp    80104dd0 <release>
8010026e:	83 ec 0c             	sub    $0xc,%esp
80100271:	68 26 7a 10 80       	push   $0x80107a26
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
80100294:	e8 67 1e 00 00       	call   80102100 <iunlock>
  acquire(&cons.lock);
80100299:	c7 04 24 60 05 11 80 	movl   $0x80110560,(%esp)
801002a0:	e8 8b 4b 00 00       	call   80104e30 <acquire>

  while(n > 0){
801002a5:	83 c4 10             	add    $0x10,%esp
801002a8:	85 db                	test   %ebx,%ebx
801002aa:	0f 8e 94 00 00 00    	jle    80100344 <consoleread+0xc4>

    while(input.r == input.w){
801002b0:	a1 28 05 11 80       	mov    0x80110528,%eax
801002b5:	39 05 2c 05 11 80    	cmp    %eax,0x8011052c
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
801002c3:	68 60 05 11 80       	push   $0x80110560
801002c8:	68 28 05 11 80       	push   $0x80110528
801002cd:	e8 de 45 00 00       	call   801048b0 <sleep>
    while(input.r == input.w){
801002d2:	a1 28 05 11 80       	mov    0x80110528,%eax
801002d7:	83 c4 10             	add    $0x10,%esp
801002da:	3b 05 2c 05 11 80    	cmp    0x8011052c,%eax
801002e0:	75 36                	jne    80100318 <consoleread+0x98>
      if(myproc()->killed){
801002e2:	e8 09 3f 00 00       	call   801041f0 <myproc>
801002e7:	8b 48 24             	mov    0x24(%eax),%ecx
801002ea:	85 c9                	test   %ecx,%ecx
801002ec:	74 d2                	je     801002c0 <consoleread+0x40>
        release(&cons.lock);
801002ee:	83 ec 0c             	sub    $0xc,%esp
801002f1:	68 60 05 11 80       	push   $0x80110560
801002f6:	e8 d5 4a 00 00       	call   80104dd0 <release>
        ilock(ip);
801002fb:	5a                   	pop    %edx
801002fc:	ff 75 08             	push   0x8(%ebp)
801002ff:	e8 1c 1d 00 00       	call   80102020 <ilock>
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
8010031b:	89 15 28 05 11 80    	mov    %edx,0x80110528
80100321:	89 c2                	mov    %eax,%edx
80100323:	83 e2 7f             	and    $0x7f,%edx
80100326:	0f be 8a a0 fe 10 80 	movsbl -0x7fef0160(%edx),%ecx
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
80100347:	68 60 05 11 80       	push   $0x80110560
8010034c:	e8 7f 4a 00 00       	call   80104dd0 <release>
  ilock(ip);
80100351:	58                   	pop    %eax
80100352:	ff 75 08             	push   0x8(%ebp)
80100355:	e8 c6 1c 00 00       	call   80102020 <ilock>
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
8010036d:	a3 28 05 11 80       	mov    %eax,0x80110528
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
801003a9:	c7 05 94 05 11 80 00 	movl   $0x0,0x80110594
801003b0:	00 00 00 
  getcallerpcs(&s, pcs);
801003b3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003b6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003b9:	e8 a2 2d 00 00       	call   80103160 <lapicid>
801003be:	83 ec 08             	sub    $0x8,%esp
801003c1:	50                   	push   %eax
801003c2:	68 2d 7a 10 80       	push   $0x80107a2d
801003c7:	e8 74 08 00 00       	call   80100c40 <cprintf>
  cprintf(s);
801003cc:	58                   	pop    %eax
801003cd:	ff 75 08             	push   0x8(%ebp)
801003d0:	e8 6b 08 00 00       	call   80100c40 <cprintf>
  cprintf("\n");
801003d5:	c7 04 24 af 7e 10 80 	movl   $0x80107eaf,(%esp)
801003dc:	e8 5f 08 00 00       	call   80100c40 <cprintf>
  getcallerpcs(&s, pcs);
801003e1:	8d 45 08             	lea    0x8(%ebp),%eax
801003e4:	5a                   	pop    %edx
801003e5:	59                   	pop    %ecx
801003e6:	53                   	push   %ebx
801003e7:	50                   	push   %eax
801003e8:	e8 73 48 00 00       	call   80104c60 <getcallerpcs>
  for(i=0; i<10; i++)
801003ed:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003f0:	83 ec 08             	sub    $0x8,%esp
801003f3:	ff 33                	push   (%ebx)
  for(i=0; i<10; i++)
801003f5:	83 c3 04             	add    $0x4,%ebx
    cprintf(" %p", pcs[i]);
801003f8:	68 41 7a 10 80       	push   $0x80107a41
801003fd:	e8 3e 08 00 00       	call   80100c40 <cprintf>
  for(i=0; i<10; i++)
80100402:	83 c4 10             	add    $0x10,%esp
80100405:	39 f3                	cmp    %esi,%ebx
80100407:	75 e7                	jne    801003f0 <panic+0x50>
  panicked = 1; // freeze other CPU
80100409:	c7 05 98 05 11 80 01 	movl   $0x1,0x80110598
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
8010046a:	66 0b 0d 00 90 10 80 	or     0x80109000,%cx
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
8010052c:	e8 8f 4a 00 00       	call   80104fc0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100531:	b8 80 07 00 00       	mov    $0x780,%eax
80100536:	83 c4 0c             	add    $0xc,%esp
80100539:	29 f8                	sub    %edi,%eax
8010053b:	01 c0                	add    %eax,%eax
8010053d:	50                   	push   %eax
8010053e:	6a 00                	push   $0x0
80100540:	56                   	push   %esi
80100541:	e8 ea 49 00 00       	call   80104f30 <memset>
  outb(CRTPORT+1, pos);
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	c6 45 e4 07          	movb   $0x7,-0x1c(%ebp)
8010054d:	e9 51 ff ff ff       	jmp    801004a3 <cgaputc+0x83>
    panic("pos under/overflow");
80100552:	83 ec 0c             	sub    $0xc,%esp
80100555:	68 45 7a 10 80       	push   $0x80107a45
8010055a:	e8 41 fe ff ff       	call   801003a0 <panic>
8010055f:	90                   	nop

80100560 <consputc>:
  if (c == '\5') {
80100560:	83 f8 05             	cmp    $0x5,%eax
80100563:	74 3b                	je     801005a0 <consputc+0x40>
  if (panicked) {
80100565:	8b 15 98 05 11 80    	mov    0x80110598,%edx
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
80100583:	e8 b8 5f 00 00       	call   80106540 <uartputc>
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
801005a0:	8b 0d 48 05 11 80    	mov    0x80110548,%ecx
801005a6:	85 c9                	test   %ecx,%ecx
801005a8:	75 15                	jne    801005bf <consputc+0x5f>
      stat = 1 ;
801005aa:	c7 05 48 05 11 80 01 	movl   $0x1,0x80110548
801005b1:	00 00 00 
      attribute = 0x7100 ;
801005b4:	c7 05 00 90 10 80 00 	movl   $0x7100,0x80109000
801005bb:	71 00 00 
801005be:	c3                   	ret
      stat = 0 ;
801005bf:	c7 05 48 05 11 80 00 	movl   $0x0,0x80110548
801005c6:	00 00 00 
      attribute = 0x0700;
801005c9:	c7 05 00 90 10 80 00 	movl   $0x700,0x80109000
801005d0:	07 00 00 
801005d3:	c3                   	ret
    uartputc('\b');
801005d4:	83 ec 0c             	sub    $0xc,%esp
801005d7:	6a 08                	push   $0x8
801005d9:	e8 62 5f 00 00       	call   80106540 <uartputc>
    uartputc(' ');
801005de:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801005e5:	e8 56 5f 00 00       	call   80106540 <uartputc>
    uartputc('\b');
801005ea:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801005f1:	e8 4a 5f 00 00       	call   80106540 <uartputc>
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
8010063b:	0f b6 92 50 7f 10 80 	movzbl -0x7fef80b0(%edx),%edx
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
801006ac:	8b 15 2c 05 11 80    	mov    0x8011052c,%edx
801006b2:	8b 35 30 05 11 80    	mov    0x80110530,%esi
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
801006e0:	0f b6 89 a0 fe 10 80 	movzbl -0x7fef0160(%ecx),%ecx
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
801006fd:	a1 20 05 11 80       	mov    0x80110520,%eax
80100702:	85 c0                	test   %eax,%eax
80100704:	7e 77                	jle    8010077d <handle_tab_completion+0xdd>
80100706:	bf 20 ff 10 80       	mov    $0x8010ff20,%edi
8010070b:	31 db                	xor    %ebx,%ebx
8010070d:	eb 0f                	jmp    8010071e <handle_tab_completion+0x7e>
8010070f:	90                   	nop
80100710:	83 c3 01             	add    $0x1,%ebx
80100713:	83 ef 80             	sub    $0xffffff80,%edi
80100716:	39 1d 20 05 11 80    	cmp    %ebx,0x80110520
8010071c:	7e 5f                	jle    8010077d <handle_tab_completion+0xdd>
    if (strncmp(input.history[i], current_input, current_len) == 0) {
8010071e:	83 ec 04             	sub    $0x4,%esp
80100721:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80100727:	56                   	push   %esi
80100728:	50                   	push   %eax
80100729:	57                   	push   %edi
8010072a:	e8 01 49 00 00       	call   80105030 <strncmp>
8010072f:	83 c4 10             	add    $0x10,%esp
80100732:	85 c0                	test   %eax,%eax
80100734:	75 da                	jne    80100710 <handle_tab_completion+0x70>
  int match_len = strlen(match);
80100736:	83 ec 0c             	sub    $0xc,%esp
80100739:	57                   	push   %edi
8010073a:	e8 e1 49 00 00       	call   80105120 <strlen>
  for (int i = current_len; i < match_len; i++) {
8010073f:	83 c4 10             	add    $0x10,%esp
80100742:	39 c6                	cmp    %eax,%esi
80100744:	7d 37                	jge    8010077d <handle_tab_completion+0xdd>
    input.buf[input.e++ % INPUT_BUF] = match[i];
80100746:	8b 15 30 05 11 80    	mov    0x80110530,%edx
8010074c:	01 fe                	add    %edi,%esi
8010074e:	01 c7                	add    %eax,%edi
80100750:	8d 42 01             	lea    0x1(%edx),%eax
80100753:	83 e2 7f             	and    $0x7f,%edx
  for (int i = current_len; i < match_len; i++) {
80100756:	83 c6 01             	add    $0x1,%esi
    input.buf[input.e++ % INPUT_BUF] = match[i];
80100759:	a3 30 05 11 80       	mov    %eax,0x80110530
8010075e:	0f be 46 ff          	movsbl -0x1(%esi),%eax
80100762:	88 82 a0 fe 10 80    	mov    %al,-0x7fef0160(%edx)
    consputc(match[i]);
80100768:	e8 f3 fd ff ff       	call   80100560 <consputc>
    select_e = input.e;
8010076d:	8b 15 30 05 11 80    	mov    0x80110530,%edx
80100773:	89 15 84 fe 10 80    	mov    %edx,0x8010fe84
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
8010083d:	8b 0d 98 05 11 80    	mov    0x80110598,%ecx
80100843:	85 c9                	test   %ecx,%ecx
80100845:	74 09                	je     80100850 <print_row_index+0x20>
80100847:	fa                   	cli
    for (;;) ;
80100848:	eb fe                	jmp    80100848 <print_row_index+0x18>
8010084a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    uartputc(c);
80100850:	83 ec 0c             	sub    $0xc,%esp
80100853:	6a 20                	push   $0x20
80100855:	e8 e6 5c 00 00       	call   80106540 <uartputc>
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
8010087a:	8b 15 98 05 11 80    	mov    0x80110598,%edx
80100880:	85 d2                	test   %edx,%edx
80100882:	75 3d                	jne    801008c1 <print_row_index+0x91>
    uartputc(c);
80100884:	83 ec 0c             	sub    $0xc,%esp
80100887:	6a 20                	push   $0x20
80100889:	e8 b2 5c 00 00       	call   80106540 <uartputc>
    cgaputc(c);
8010088e:	b8 20 00 00 00       	mov    $0x20,%eax
80100893:	e8 88 fb ff ff       	call   80100420 <cgaputc>
  if (panicked) {
80100898:	a1 98 05 11 80       	mov    0x80110598,%eax
8010089d:	83 c4 10             	add    $0x10,%esp
801008a0:	85 c0                	test   %eax,%eax
801008a2:	75 1d                	jne    801008c1 <print_row_index+0x91>
    uartputc(c);
801008a4:	83 ec 0c             	sub    $0xc,%esp
801008a7:	6a 20                	push   $0x20
801008a9:	e8 92 5c 00 00       	call   80106540 <uartputc>
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
801008dc:	e8 1f 18 00 00       	call   80102100 <iunlock>
  acquire(&cons.lock);
801008e1:	c7 04 24 60 05 11 80 	movl   $0x80110560,(%esp)
801008e8:	e8 43 45 00 00       	call   80104e30 <acquire>
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
80100907:	8b 15 98 05 11 80    	mov    0x80110598,%edx
8010090d:	85 d2                	test   %edx,%edx
8010090f:	74 07                	je     80100918 <consolewrite+0x48>
80100911:	fa                   	cli
    for (;;) ;
80100912:	eb fe                	jmp    80100912 <consolewrite+0x42>
80100914:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartputc(c);
80100918:	83 ec 0c             	sub    $0xc,%esp
8010091b:	56                   	push   %esi
8010091c:	e8 1f 5c 00 00       	call   80106540 <uartputc>
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
80100935:	68 60 05 11 80       	push   $0x80110560
8010093a:	e8 91 44 00 00       	call   80104dd0 <release>
  ilock(ip);
8010093f:	58                   	pop    %eax
80100940:	ff 75 08             	push   0x8(%ebp)
80100943:	e8 d8 16 00 00       	call   80102020 <ilock>

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
80100953:	8b 0d 48 05 11 80    	mov    0x80110548,%ecx
80100959:	85 c9                	test   %ecx,%ecx
8010095b:	75 16                	jne    80100973 <consolewrite+0xa3>
      stat = 1 ;
8010095d:	c7 05 48 05 11 80 01 	movl   $0x1,0x80110548
80100964:	00 00 00 
      attribute = 0x7100 ;
80100967:	c7 05 00 90 10 80 00 	movl   $0x7100,0x80109000
8010096e:	71 00 00 
80100971:	eb b8                	jmp    8010092b <consolewrite+0x5b>
      stat = 0 ;
80100973:	c7 05 48 05 11 80 00 	movl   $0x0,0x80110548
8010097a:	00 00 00 
      attribute = 0x0700;
8010097d:	c7 05 00 90 10 80 00 	movl   $0x700,0x80109000
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
801009b1:	a1 98 05 11 80       	mov    0x80110598,%eax
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
801009d3:	e8 68 5b 00 00       	call   80106540 <uartputc>
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
801009f2:	c7 05 48 05 11 80 00 	movl   $0x0,0x80110548
801009f9:	00 00 00 
  for (int i = 0; i < count; i++)
801009fc:	83 c6 01             	add    $0x1,%esi
      attribute = 0x0700;
801009ff:	c7 05 00 90 10 80 00 	movl   $0x700,0x80109000
80100a06:	07 00 00 
  for (int i = 0; i < count; i++)
80100a09:	39 f7                	cmp    %esi,%edi
80100a0b:	74 dd                	je     801009ea <write_repeated+0x5a>
    if (!stat) {
80100a0d:	8b 15 48 05 11 80    	mov    0x80110548,%edx
80100a13:	85 d2                	test   %edx,%edx
80100a15:	75 db                	jne    801009f2 <write_repeated+0x62>
      stat = 1 ;
80100a17:	c7 05 48 05 11 80 01 	movl   $0x1,0x80110548
80100a1e:	00 00 00 
  for (int i = 0; i < count; i++)
80100a21:	83 c6 01             	add    $0x1,%esi
      attribute = 0x7100 ;
80100a24:	c7 05 00 90 10 80 00 	movl   $0x7100,0x80109000
80100a2b:	71 00 00 
  for (int i = 0; i < count; i++)
80100a2e:	39 f7                	cmp    %esi,%edi
80100a30:	74 b8                	je     801009ea <write_repeated+0x5a>
    if (!stat) {
80100a32:	8b 15 48 05 11 80    	mov    0x80110548,%edx
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
80100a7c:	e8 bf 5a 00 00       	call   80106540 <uartputc>
    uartputc(' ');
80100a81:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
80100a88:	e8 b3 5a 00 00       	call   80106540 <uartputc>
    uartputc('\b');
80100a8d:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100a94:	e8 a7 5a 00 00       	call   80106540 <uartputc>
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
80100ab9:	8b 35 98 05 11 80    	mov    0x80110598,%esi
  if (count > input.last_line_count)
80100abf:	8b 1d 20 05 11 80    	mov    0x80110520,%ebx
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
80100ad5:	e8 66 5a 00 00       	call   80106540 <uartputc>
    cgaputc(c);
80100ada:	b8 0a 00 00 00       	mov    $0xa,%eax
80100adf:	e8 3c f9 ff ff       	call   80100420 <cgaputc>
  for (int i = 0; i <= count; i++)
80100ae4:	83 c4 10             	add    $0x10,%esp
80100ae7:	85 db                	test   %ebx,%ebx
80100ae9:	0f 88 ec 00 00 00    	js     80100bdb <show_last_five_commands+0x12b>
  if (count > input.last_line_count)
80100aef:	b8 05 00 00 00       	mov    $0x5,%eax
80100af4:	bf 20 ff 10 80       	mov    $0x8010ff20,%edi
80100af9:	39 c3                	cmp    %eax,%ebx
80100afb:	0f 4e c3             	cmovle %ebx,%eax
80100afe:	89 45 e4             	mov    %eax,-0x1c(%ebp)
{
80100b01:	bb 03 00 00 00       	mov    $0x3,%ebx
  if (panicked) {
80100b06:	a1 98 05 11 80       	mov    0x80110598,%eax
80100b0b:	85 c0                	test   %eax,%eax
80100b0d:	74 09                	je     80100b18 <show_last_five_commands+0x68>
80100b0f:	fa                   	cli
    for (;;) ;
80100b10:	eb fe                	jmp    80100b10 <show_last_five_commands+0x60>
80100b12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    uartputc(c);
80100b18:	83 ec 0c             	sub    $0xc,%esp
80100b1b:	6a 20                	push   $0x20
80100b1d:	e8 1e 5a 00 00       	call   80106540 <uartputc>
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
80100b42:	a1 98 05 11 80       	mov    0x80110598,%eax
80100b47:	85 c0                	test   %eax,%eax
80100b49:	0f 85 c1 00 00 00    	jne    80100c10 <show_last_five_commands+0x160>
    uartputc(c);
80100b4f:	83 ec 0c             	sub    $0xc,%esp
80100b52:	6a 20                	push   $0x20
80100b54:	e8 e7 59 00 00       	call   80106540 <uartputc>
    cgaputc(c);
80100b59:	b8 20 00 00 00       	mov    $0x20,%eax
80100b5e:	e8 bd f8 ff ff       	call   80100420 <cgaputc>
  if (panicked) {
80100b63:	8b 1d 98 05 11 80    	mov    0x80110598,%ebx
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
80100b81:	e8 ba 59 00 00       	call   80106540 <uartputc>
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
80100ba8:	8b 0d 98 05 11 80    	mov    0x80110598,%ecx
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
80100bc0:	e8 7b 59 00 00       	call   80106540 <uartputc>
    cgaputc(c);
80100bc5:	b8 0a 00 00 00       	mov    $0xa,%eax
80100bca:	e8 51 f8 ff ff       	call   80100420 <cgaputc>
  for (int i = 0; i <= count; i++)
80100bcf:	83 c4 10             	add    $0x10,%esp
80100bd2:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80100bd5:	0f 8d 26 ff ff ff    	jge    80100b01 <show_last_five_commands+0x51>
  if (panicked) {
80100bdb:	8b 15 98 05 11 80    	mov    0x80110598,%edx
80100be1:	85 d2                	test   %edx,%edx
80100be3:	75 33                	jne    80100c18 <show_last_five_commands+0x168>
    uartputc(c);
80100be5:	83 ec 0c             	sub    $0xc,%esp
80100be8:	6a 24                	push   $0x24
80100bea:	e8 51 59 00 00       	call   80106540 <uartputc>
    cgaputc(c);
80100bef:	b8 24 00 00 00       	mov    $0x24,%eax
80100bf4:	e8 27 f8 ff ff       	call   80100420 <cgaputc>
  if (panicked) {
80100bf9:	a1 98 05 11 80       	mov    0x80110598,%eax
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
80100c25:	e8 16 59 00 00       	call   80106540 <uartputc>
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
80100c49:	8b 3d 94 05 11 80    	mov    0x80110594,%edi
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
80100cea:	a1 98 05 11 80       	mov    0x80110598,%eax
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
80100d21:	bf 58 7a 10 80       	mov    $0x80107a58,%edi
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
80100d58:	8b 0d 98 05 11 80    	mov    0x80110598,%ecx
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
80100d70:	e8 cb 57 00 00       	call   80106540 <uartputc>
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
80100da8:	e8 93 57 00 00       	call   80106540 <uartputc>
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
80100dd3:	68 60 05 11 80       	push   $0x80110560
80100dd8:	e8 53 40 00 00       	call   80104e30 <acquire>
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
80100df2:	68 60 05 11 80       	push   $0x80110560
80100df7:	e8 d4 3f 00 00       	call   80104dd0 <release>
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
80100e0a:	68 5f 7a 10 80       	push   $0x80107a5f
80100e0f:	e8 8c f5 ff ff       	call   801003a0 <panic>
80100e14:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80100e1b:	00 
80100e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100e20 <reverse_buff>:
  for (int i = 0; i < select_in; i++)
80100e20:	8b 0d 88 fe 10 80    	mov    0x8010fe88,%ecx
80100e26:	85 c9                	test   %ecx,%ecx
80100e28:	74 3e                	je     80100e68 <reverse_buff+0x48>
void reverse_buff(){
80100e2a:	55                   	push   %ebp
80100e2b:	31 c0                	xor    %eax,%eax
80100e2d:	89 e5                	mov    %esp,%ebp
80100e2f:	53                   	push   %ebx
80100e30:	8d 99 20 06 11 80    	lea    -0x7feef9e0(%ecx),%ebx
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
80100e4c:	88 90 9f 05 11 80    	mov    %dl,-0x7feefa61(%eax)
  for (int i = 0; i < select_in; i++)
80100e52:	39 c8                	cmp    %ecx,%eax
80100e54:	75 ea                	jne    80100e40 <reverse_buff+0x20>
  reversed_buffer[select_in] = '\0';
80100e56:	c6 81 a0 05 11 80 00 	movb   $0x0,-0x7feefa60(%ecx)
}
80100e5d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e60:	c9                   	leave
80100e61:	c3                   	ret
80100e62:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  reversed_buffer[select_in] = '\0';
80100e68:	c6 81 a0 05 11 80 00 	movb   $0x0,-0x7feefa60(%ecx)
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
80100e7a:	8b 35 30 05 11 80    	mov    0x80110530,%esi
80100e80:	8b 15 2c 05 11 80    	mov    0x8011052c,%edx
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
80100eb9:	0f b6 80 a0 fe 10 80 	movzbl -0x7fef0160(%eax),%eax
80100ec0:	3c 0a                	cmp    $0xa,%al
80100ec2:	75 d4                	jne    80100e98 <store_command_in_history+0x28>
    current_cmd[cmd_len] = '\0';
80100ec4:	c6 84 1d 78 ff ff ff 	movb   $0x0,-0x88(%ebp,%ebx,1)
80100ecb:	00 
    if (should_exclude_from_history(current_cmd))
80100ecc:	80 bd 78 ff ff ff 21 	cmpb   $0x21,-0x88(%ebp)
80100ed3:	bb a0 04 11 80       	mov    $0x801104a0,%ebx
80100ed8:	74 b0                	je     80100e8a <store_command_in_history+0x1a>
80100eda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      memmove(input.history[i], input.history[i-1], INPUT_BUF);
80100ee0:	83 ec 04             	sub    $0x4,%esp
80100ee3:	89 d8                	mov    %ebx,%eax
80100ee5:	83 c3 80             	add    $0xffffff80,%ebx
80100ee8:	68 80 00 00 00       	push   $0x80
80100eed:	53                   	push   %ebx
80100eee:	50                   	push   %eax
80100eef:	e8 cc 40 00 00       	call   80104fc0 <memmove>
    for (int i = HISTORY_BUF-1; i > 0; i--) {
80100ef4:	83 c4 10             	add    $0x10,%esp
80100ef7:	81 fb 20 ff 10 80    	cmp    $0x8010ff20,%ebx
80100efd:	75 e1                	jne    80100ee0 <store_command_in_history+0x70>
    for (int i = input.w; i < input.e && input.buf[i % INPUT_BUF] != '\n'; i++) {
80100eff:	8b 15 2c 05 11 80    	mov    0x8011052c,%edx
80100f05:	8b 35 30 05 11 80    	mov    0x80110530,%esi
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
80100f1e:	88 83 1f ff 10 80    	mov    %al,-0x7fef00e1(%ebx)
    for (int i = input.w; i < input.e && input.buf[i % INPUT_BUF] != '\n'; i++) {
80100f24:	39 f2                	cmp    %esi,%edx
80100f26:	73 1b                	jae    80100f43 <store_command_in_history+0xd3>
80100f28:	89 d1                	mov    %edx,%ecx
80100f2a:	c1 f9 1f             	sar    $0x1f,%ecx
80100f2d:	c1 e9 19             	shr    $0x19,%ecx
80100f30:	8d 04 0a             	lea    (%edx,%ecx,1),%eax
80100f33:	83 e0 7f             	and    $0x7f,%eax
80100f36:	29 c8                	sub    %ecx,%eax
80100f38:	0f b6 80 a0 fe 10 80 	movzbl -0x7fef0160(%eax),%eax
80100f3f:	3c 0a                	cmp    $0xa,%al
80100f41:	75 d5                	jne    80100f18 <store_command_in_history+0xa8>
    if (input.last_line_count < HISTORY_BUF)
80100f43:	a1 20 05 11 80       	mov    0x80110520,%eax
    input.history[0][j] = '\0';
80100f48:	c6 83 20 ff 10 80 00 	movb   $0x0,-0x7fef00e0(%ebx)
    if (input.last_line_count < HISTORY_BUF)
80100f4f:	83 f8 0b             	cmp    $0xb,%eax
80100f52:	0f 8f 32 ff ff ff    	jg     80100e8a <store_command_in_history+0x1a>
      input.last_line_count++;
80100f58:	83 c0 01             	add    $0x1,%eax
80100f5b:	a3 20 05 11 80       	mov    %eax,0x80110520
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
80100f7e:	68 60 05 11 80       	push   $0x80110560
80100f83:	e8 a8 3e 00 00       	call   80104e30 <acquire>
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
80100fb5:	ff 24 85 00 7f 10 80 	jmp    *-0x7fef8100(,%eax,4)
        while(reversed_buffer[i] != '\0'){
80100fbc:	0f b6 15 a0 05 11 80 	movzbl 0x801105a0,%edx
        while (input.e != input.w && input.buf[(input.e) % INPUT_BUF] != '\n') {
80100fc3:	a1 30 05 11 80       	mov    0x80110530,%eax
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
80100fd9:	88 90 a0 fe 10 80    	mov    %dl,-0x7fef0160(%eax)
          consputc(reversed_buffer[i]);
80100fdf:	0f be c2             	movsbl %dl,%eax
          input.buf[input.e++ % INPUT_BUF] = reversed_buffer[i];
80100fe2:	89 0d 30 05 11 80    	mov    %ecx,0x80110530
          consputc(reversed_buffer[i]);
80100fe8:	e8 73 f5 ff ff       	call   80100560 <consputc>
          select_e = input.e ;
80100fed:	a1 30 05 11 80       	mov    0x80110530,%eax
        while(reversed_buffer[i] != '\0'){
80100ff2:	0f b6 93 a0 05 11 80 	movzbl -0x7feefa60(%ebx),%edx
          select_e = input.e ;
80100ff9:	a3 84 fe 10 80       	mov    %eax,0x8010fe84
        while(reversed_buffer[i] != '\0'){
80100ffe:	84 d2                	test   %dl,%dl
80101000:	75 ce                	jne    80100fd0 <consoleintr+0x60>
80101002:	eb 87                	jmp    80100f8b <consoleintr+0x1b>
        while (input.e != input.w && input.buf[(input.e) % INPUT_BUF] != '\n') {
80101004:	a1 30 05 11 80       	mov    0x80110530,%eax
80101009:	3b 05 2c 05 11 80    	cmp    0x8011052c,%eax
8010100f:	0f 84 76 ff ff ff    	je     80100f8b <consoleintr+0x1b>
80101015:	89 c2                	mov    %eax,%edx
80101017:	83 e2 7f             	and    $0x7f,%edx
8010101a:	80 ba a0 fe 10 80 0a 	cmpb   $0xa,-0x7fef0160(%edx)
80101021:	0f 84 64 ff ff ff    	je     80100f8b <consoleintr+0x1b>
  if (panicked) {
80101027:	8b 1d 98 05 11 80    	mov    0x80110598,%ebx
          input.e--;
8010102d:	83 e8 01             	sub    $0x1,%eax
80101030:	a3 30 05 11 80       	mov    %eax,0x80110530
          select_e = input.e ;
80101035:	a3 84 fe 10 80       	mov    %eax,0x8010fe84
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
80101063:	68 60 05 11 80       	push   $0x80110560
80101068:	e8 63 3d 00 00       	call   80104dd0 <release>
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
8010108a:	a1 48 05 11 80       	mov    0x80110548,%eax
8010108f:	85 c0                	test   %eax,%eax
80101091:	0f 85 69 01 00 00    	jne    80101200 <consoleintr+0x290>
          stat = 1 ;
80101097:	c7 05 48 05 11 80 01 	movl   $0x1,0x80110548
8010109e:	00 00 00 
          attribute = 0x7100 ;
801010a1:	c7 05 00 90 10 80 00 	movl   $0x7100,0x80109000
801010a8:	71 00 00 
801010ab:	e9 db fe ff ff       	jmp    80100f8b <consoleintr+0x1b>
        if (!copy_mode)
801010b0:	8b 15 80 fe 10 80    	mov    0x8010fe80,%edx
801010b6:	85 d2                	test   %edx,%edx
801010b8:	0f 85 d1 01 00 00    	jne    8010128f <consoleintr+0x31f>
          copy_mode = 1 ;
801010be:	c7 05 80 fe 10 80 01 	movl   $0x1,0x8010fe80
801010c5:	00 00 00 
          select_in = 0 ;
801010c8:	c7 05 88 fe 10 80 00 	movl   $0x0,0x8010fe88
801010cf:	00 00 00 
801010d2:	e9 b4 fe ff ff       	jmp    80100f8b <consoleintr+0x1b>
801010d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801010de:	00 
801010df:	90                   	nop
    switch (c) {
801010e0:	81 fb 4b e0 00 00    	cmp    $0xe04b,%ebx
801010e6:	0f 85 37 01 00 00    	jne    80101223 <consoleintr+0x2b3>
        if (input.e > input.w && select_e > input.w) {
801010ec:	a1 2c 05 11 80       	mov    0x8011052c,%eax
801010f1:	3b 05 30 05 11 80    	cmp    0x80110530,%eax
801010f7:	0f 83 8e fe ff ff    	jae    80100f8b <consoleintr+0x1b>
801010fd:	8b 15 84 fe 10 80    	mov    0x8010fe84,%edx
80101103:	39 d0                	cmp    %edx,%eax
80101105:	0f 83 80 fe ff ff    	jae    80100f8b <consoleintr+0x1b>
          if (copy_mode){
8010110b:	8b 0d 80 fe 10 80    	mov    0x8010fe80,%ecx
          select_e--;
80101111:	83 ea 01             	sub    $0x1,%edx
80101114:	89 15 84 fe 10 80    	mov    %edx,0x8010fe84
          if (copy_mode){
8010111a:	85 c9                	test   %ecx,%ecx
8010111c:	0f 84 69 fe ff ff    	je     80100f8b <consoleintr+0x1b>
            selected_buffer[select_in++] = input.buf[select_e % INPUT_BUF];
80101122:	a1 88 fe 10 80       	mov    0x8010fe88,%eax
80101127:	83 e2 7f             	and    $0x7f,%edx
8010112a:	0f b6 92 a0 fe 10 80 	movzbl -0x7fef0160(%edx),%edx
80101131:	8d 48 01             	lea    0x1(%eax),%ecx
80101134:	89 0d 88 fe 10 80    	mov    %ecx,0x8010fe88
8010113a:	88 90 20 06 11 80    	mov    %dl,-0x7feef9e0(%eax)
80101140:	e9 46 fe ff ff       	jmp    80100f8b <consoleintr+0x1b>
80101145:	8d 76 00             	lea    0x0(%esi),%esi
        if (c != 0 && input.e - input.r < INPUT_BUF) {
80101148:	85 db                	test   %ebx,%ebx
8010114a:	0f 84 3b fe ff ff    	je     80100f8b <consoleintr+0x1b>
80101150:	a1 30 05 11 80       	mov    0x80110530,%eax
80101155:	89 c2                	mov    %eax,%edx
80101157:	2b 15 28 05 11 80    	sub    0x80110528,%edx
8010115d:	83 fa 7f             	cmp    $0x7f,%edx
80101160:	0f 87 25 fe ff ff    	ja     80100f8b <consoleintr+0x1b>
          input.buf[input.e++ % INPUT_BUF] = c;
80101166:	8d 50 01             	lea    0x1(%eax),%edx
80101169:	83 e0 7f             	and    $0x7f,%eax
          c = (c == '\r') ? '\n' : c;
8010116c:	83 fb 0d             	cmp    $0xd,%ebx
8010116f:	0f 85 ca 00 00 00    	jne    8010123f <consoleintr+0x2cf>
          input.buf[input.e++ % INPUT_BUF] = c;
80101175:	c6 80 a0 fe 10 80 0a 	movb   $0xa,-0x7fef0160(%eax)
          consputc(c);
8010117c:	b8 0a 00 00 00       	mov    $0xa,%eax
          input.buf[input.e++ % INPUT_BUF] = c;
80101181:	89 15 30 05 11 80    	mov    %edx,0x80110530
          consputc(c);
80101187:	e8 d4 f3 ff ff       	call   80100560 <consputc>
          select_e = input.e ;
8010118c:	a1 30 05 11 80       	mov    0x80110530,%eax
80101191:	a3 84 fe 10 80       	mov    %eax,0x8010fe84
              store_command_in_history();
80101196:	e8 d5 fc ff ff       	call   80100e70 <store_command_in_history>
            input.w = input.e;
8010119b:	a1 30 05 11 80       	mov    0x80110530,%eax
            wakeup(&input.r);
801011a0:	83 ec 0c             	sub    $0xc,%esp
            input.w = input.e;
801011a3:	a3 2c 05 11 80       	mov    %eax,0x8011052c
            wakeup(&input.r);
801011a8:	68 28 05 11 80       	push   $0x80110528
801011ad:	e8 be 37 00 00       	call   80104970 <wakeup>
801011b2:	83 c4 10             	add    $0x10,%esp
801011b5:	e9 d1 fd ff ff       	jmp    80100f8b <consoleintr+0x1b>
    uartputc('\b');
801011ba:	83 ec 0c             	sub    $0xc,%esp
801011bd:	6a 08                	push   $0x8
801011bf:	e8 7c 53 00 00       	call   80106540 <uartputc>
    uartputc(' ');
801011c4:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801011cb:	e8 70 53 00 00       	call   80106540 <uartputc>
    uartputc('\b');
801011d0:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
801011d7:	e8 64 53 00 00       	call   80106540 <uartputc>
    cgaputc(c);
801011dc:	b8 00 01 00 00       	mov    $0x100,%eax
801011e1:	e8 3a f2 ff ff       	call   80100420 <cgaputc>
        while (input.e != input.w && input.buf[(input.e) % INPUT_BUF] != '\n') {
801011e6:	a1 30 05 11 80       	mov    0x80110530,%eax
801011eb:	83 c4 10             	add    $0x10,%esp
801011ee:	3b 05 2c 05 11 80    	cmp    0x8011052c,%eax
801011f4:	0f 85 1b fe ff ff    	jne    80101015 <consoleintr+0xa5>
801011fa:	e9 8c fd ff ff       	jmp    80100f8b <consoleintr+0x1b>
801011ff:	90                   	nop
          stat = 0 ;
80101200:	c7 05 48 05 11 80 00 	movl   $0x0,0x80110548
80101207:	00 00 00 
          attribute = 0x0700;
8010120a:	c7 05 00 90 10 80 00 	movl   $0x700,0x80109000
80101211:	07 00 00 
80101214:	e9 72 fd ff ff       	jmp    80100f8b <consoleintr+0x1b>
    switch (c) {
80101219:	bf 01 00 00 00       	mov    $0x1,%edi
8010121e:	e9 68 fd ff ff       	jmp    80100f8b <consoleintr+0x1b>
        if (c != 0 && input.e - input.r < INPUT_BUF) {
80101223:	a1 30 05 11 80       	mov    0x80110530,%eax
80101228:	89 c2                	mov    %eax,%edx
8010122a:	2b 15 28 05 11 80    	sub    0x80110528,%edx
80101230:	83 fa 7f             	cmp    $0x7f,%edx
80101233:	0f 87 52 fd ff ff    	ja     80100f8b <consoleintr+0x1b>
          input.buf[input.e++ % INPUT_BUF] = c;
80101239:	8d 50 01             	lea    0x1(%eax),%edx
8010123c:	83 e0 7f             	and    $0x7f,%eax
8010123f:	88 98 a0 fe 10 80    	mov    %bl,-0x7fef0160(%eax)
          consputc(c);
80101245:	89 d8                	mov    %ebx,%eax
          input.buf[input.e++ % INPUT_BUF] = c;
80101247:	89 15 30 05 11 80    	mov    %edx,0x80110530
          consputc(c);
8010124d:	e8 0e f3 ff ff       	call   80100560 <consputc>
          select_e = input.e ;
80101252:	a1 30 05 11 80       	mov    0x80110530,%eax
80101257:	a3 84 fe 10 80       	mov    %eax,0x8010fe84
          if (c == '\n' || c == C('D') || input.e == input.r + INPUT_BUF) {
8010125c:	83 fb 0a             	cmp    $0xa,%ebx
8010125f:	0f 84 31 ff ff ff    	je     80101196 <consoleintr+0x226>
80101265:	83 fb 04             	cmp    $0x4,%ebx
80101268:	74 68                	je     801012d2 <consoleintr+0x362>
8010126a:	8b 0d 28 05 11 80    	mov    0x80110528,%ecx
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
8010128a:	e9 c1 37 00 00       	jmp    80104a50 <procdump>
  for (int i = 0; i < select_in; i++)
8010128f:	8b 0d 88 fe 10 80    	mov    0x8010fe88,%ecx
80101295:	31 c0                	xor    %eax,%eax
          copy_mode = 0;
80101297:	c7 05 80 fe 10 80 00 	movl   $0x0,0x8010fe80
8010129e:	00 00 00 
  for (int i = 0; i < select_in; i++)
801012a1:	8d 99 20 06 11 80    	lea    -0x7feef9e0(%ecx),%ebx
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
801012bc:	88 90 9f 05 11 80    	mov    %dl,-0x7feefa61(%eax)
  for (int i = 0; i < select_in; i++)
801012c2:	39 c8                	cmp    %ecx,%eax
801012c4:	75 ea                	jne    801012b0 <consoleintr+0x340>
  reversed_buffer[select_in] = '\0';
801012c6:	c6 81 a0 05 11 80 00 	movb   $0x0,-0x7feefa60(%ecx)
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
801012e6:	68 68 7a 10 80       	push   $0x80107a68
801012eb:	68 60 05 11 80       	push   $0x80110560
801012f0:	e8 4b 39 00 00       	call   80104c40 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801012f5:	58                   	pop    %eax
801012f6:	5a                   	pop    %edx
801012f7:	6a 00                	push   $0x0
801012f9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801012fb:	c7 05 4c 10 11 80 d0 	movl   $0x801008d0,0x8011104c
80101302:	08 10 80 
  devsw[CONSOLE].read = consoleread;
80101305:	c7 05 48 10 11 80 80 	movl   $0x80100280,0x80111048
8010130c:	02 10 80 
  cons.locking = 1;
8010130f:	c7 05 94 05 11 80 01 	movl   $0x1,0x80110594
80101316:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
80101319:	e8 c2 19 00 00       	call   80102ce0 <ioapicenable>
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
80101330:	55                   	push   %ebp
80101331:	89 e5                	mov    %esp,%ebp
80101333:	57                   	push   %edi
80101334:	56                   	push   %esi
80101335:	53                   	push   %ebx
80101336:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
8010133c:	e8 af 2e 00 00       	call   801041f0 <myproc>
80101341:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80101347:	e8 84 22 00 00       	call   801035d0 <begin_op>
8010134c:	83 ec 0c             	sub    $0xc,%esp
8010134f:	ff 75 08             	push   0x8(%ebp)
80101352:	e8 a9 15 00 00       	call   80102900 <namei>
80101357:	83 c4 10             	add    $0x10,%esp
8010135a:	85 c0                	test   %eax,%eax
8010135c:	0f 84 30 03 00 00    	je     80101692 <exec+0x362>
80101362:	83 ec 0c             	sub    $0xc,%esp
80101365:	89 c7                	mov    %eax,%edi
80101367:	50                   	push   %eax
80101368:	e8 b3 0c 00 00       	call   80102020 <ilock>
8010136d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80101373:	6a 34                	push   $0x34
80101375:	6a 00                	push   $0x0
80101377:	50                   	push   %eax
80101378:	57                   	push   %edi
80101379:	e8 b2 0f 00 00       	call   80102330 <readi>
8010137e:	83 c4 20             	add    $0x20,%esp
80101381:	83 f8 34             	cmp    $0x34,%eax
80101384:	0f 85 01 01 00 00    	jne    8010148b <exec+0x15b>
8010138a:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80101391:	45 4c 46 
80101394:	0f 85 f1 00 00 00    	jne    8010148b <exec+0x15b>
8010139a:	e8 11 63 00 00       	call   801076b0 <setupkvm>
8010139f:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)
801013a5:	85 c0                	test   %eax,%eax
801013a7:	0f 84 de 00 00 00    	je     8010148b <exec+0x15b>
801013ad:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
801013b4:	00 
801013b5:	8b b5 40 ff ff ff    	mov    -0xc0(%ebp),%esi
801013bb:	0f 84 a1 02 00 00    	je     80101662 <exec+0x332>
801013c1:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
801013c8:	00 00 00 
801013cb:	31 db                	xor    %ebx,%ebx
801013cd:	e9 8c 00 00 00       	jmp    8010145e <exec+0x12e>
801013d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801013d8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
801013df:	75 6c                	jne    8010144d <exec+0x11d>
801013e1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
801013e7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
801013ed:	0f 82 87 00 00 00    	jb     8010147a <exec+0x14a>
801013f3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
801013f9:	72 7f                	jb     8010147a <exec+0x14a>
801013fb:	83 ec 04             	sub    $0x4,%esp
801013fe:	50                   	push   %eax
801013ff:	ff b5 f0 fe ff ff    	push   -0x110(%ebp)
80101405:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
8010140b:	e8 d0 60 00 00       	call   801074e0 <allocuvm>
80101410:	83 c4 10             	add    $0x10,%esp
80101413:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80101419:	85 c0                	test   %eax,%eax
8010141b:	74 5d                	je     8010147a <exec+0x14a>
8010141d:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80101423:	a9 ff 0f 00 00       	test   $0xfff,%eax
80101428:	75 50                	jne    8010147a <exec+0x14a>
8010142a:	83 ec 0c             	sub    $0xc,%esp
8010142d:	ff b5 14 ff ff ff    	push   -0xec(%ebp)
80101433:	ff b5 08 ff ff ff    	push   -0xf8(%ebp)
80101439:	57                   	push   %edi
8010143a:	50                   	push   %eax
8010143b:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101441:	e8 ca 5f 00 00       	call   80107410 <loaduvm>
80101446:	83 c4 20             	add    $0x20,%esp
80101449:	85 c0                	test   %eax,%eax
8010144b:	78 2d                	js     8010147a <exec+0x14a>
8010144d:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80101454:	83 c3 01             	add    $0x1,%ebx
80101457:	83 c6 20             	add    $0x20,%esi
8010145a:	39 d8                	cmp    %ebx,%eax
8010145c:	7e 52                	jle    801014b0 <exec+0x180>
8010145e:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80101464:	6a 20                	push   $0x20
80101466:	56                   	push   %esi
80101467:	50                   	push   %eax
80101468:	57                   	push   %edi
80101469:	e8 c2 0e 00 00       	call   80102330 <readi>
8010146e:	83 c4 10             	add    $0x10,%esp
80101471:	83 f8 20             	cmp    $0x20,%eax
80101474:	0f 84 5e ff ff ff    	je     801013d8 <exec+0xa8>
8010147a:	83 ec 0c             	sub    $0xc,%esp
8010147d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101483:	e8 a8 61 00 00       	call   80107630 <freevm>
80101488:	83 c4 10             	add    $0x10,%esp
8010148b:	83 ec 0c             	sub    $0xc,%esp
8010148e:	57                   	push   %edi
8010148f:	e8 1c 0e 00 00       	call   801022b0 <iunlockput>
80101494:	e8 a7 21 00 00       	call   80103640 <end_op>
80101499:	83 c4 10             	add    $0x10,%esp
8010149c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801014a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801014a4:	5b                   	pop    %ebx
801014a5:	5e                   	pop    %esi
801014a6:	5f                   	pop    %edi
801014a7:	5d                   	pop    %ebp
801014a8:	c3                   	ret
801014a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801014b0:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
801014b6:	81 c6 ff 0f 00 00    	add    $0xfff,%esi
801014bc:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
801014c2:	8d 9e 00 20 00 00    	lea    0x2000(%esi),%ebx
801014c8:	83 ec 0c             	sub    $0xc,%esp
801014cb:	57                   	push   %edi
801014cc:	e8 df 0d 00 00       	call   801022b0 <iunlockput>
801014d1:	e8 6a 21 00 00       	call   80103640 <end_op>
801014d6:	83 c4 0c             	add    $0xc,%esp
801014d9:	53                   	push   %ebx
801014da:	56                   	push   %esi
801014db:	8b b5 f4 fe ff ff    	mov    -0x10c(%ebp),%esi
801014e1:	56                   	push   %esi
801014e2:	e8 f9 5f 00 00       	call   801074e0 <allocuvm>
801014e7:	83 c4 10             	add    $0x10,%esp
801014ea:	89 c7                	mov    %eax,%edi
801014ec:	85 c0                	test   %eax,%eax
801014ee:	0f 84 86 00 00 00    	je     8010157a <exec+0x24a>
801014f4:	83 ec 08             	sub    $0x8,%esp
801014f7:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
801014fd:	89 fb                	mov    %edi,%ebx
801014ff:	50                   	push   %eax
80101500:	56                   	push   %esi
80101501:	31 f6                	xor    %esi,%esi
80101503:	e8 48 62 00 00       	call   80107750 <clearpteu>
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
8010152b:	89 9c b5 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%esi,4)
80101532:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
80101538:	8b 14 87             	mov    (%edi,%eax,4),%edx
8010153b:	85 d2                	test   %edx,%edx
8010153d:	74 51                	je     80101590 <exec+0x260>
8010153f:	83 f8 20             	cmp    $0x20,%eax
80101542:	74 36                	je     8010157a <exec+0x24a>
80101544:	89 c6                	mov    %eax,%esi
80101546:	83 ec 0c             	sub    $0xc,%esp
80101549:	52                   	push   %edx
8010154a:	e8 d1 3b 00 00       	call   80105120 <strlen>
8010154f:	29 c3                	sub    %eax,%ebx
80101551:	58                   	pop    %eax
80101552:	ff 34 b7             	push   (%edi,%esi,4)
80101555:	83 eb 01             	sub    $0x1,%ebx
80101558:	83 e3 fc             	and    $0xfffffffc,%ebx
8010155b:	e8 c0 3b 00 00       	call   80105120 <strlen>
80101560:	83 c0 01             	add    $0x1,%eax
80101563:	50                   	push   %eax
80101564:	ff 34 b7             	push   (%edi,%esi,4)
80101567:	53                   	push   %ebx
80101568:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
8010156e:	e8 ad 63 00 00       	call   80107920 <copyout>
80101573:	83 c4 20             	add    $0x20,%esp
80101576:	85 c0                	test   %eax,%eax
80101578:	79 ae                	jns    80101528 <exec+0x1f8>
8010157a:	83 ec 0c             	sub    $0xc,%esp
8010157d:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
80101583:	e8 a8 60 00 00       	call   80107630 <freevm>
80101588:	83 c4 10             	add    $0x10,%esp
8010158b:	e9 0c ff ff ff       	jmp    8010149c <exec+0x16c>
80101590:	8d 14 b5 08 00 00 00 	lea    0x8(,%esi,4),%edx
80101597:	8b bd f0 fe ff ff    	mov    -0x110(%ebp),%edi
8010159d:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
801015a3:	8d 46 04             	lea    0x4(%esi),%eax
801015a6:	8d 72 0c             	lea    0xc(%edx),%esi
801015a9:	c7 84 85 58 ff ff ff 	movl   $0x0,-0xa8(%ebp,%eax,4)
801015b0:	00 00 00 00 
801015b4:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
801015ba:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
801015c1:	ff ff ff 
801015c4:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
801015ca:	89 d8                	mov    %ebx,%eax
801015cc:	29 f3                	sub    %esi,%ebx
801015ce:	29 d0                	sub    %edx,%eax
801015d0:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
801015d6:	56                   	push   %esi
801015d7:	51                   	push   %ecx
801015d8:	53                   	push   %ebx
801015d9:	ff b5 f4 fe ff ff    	push   -0x10c(%ebp)
801015df:	e8 3c 63 00 00       	call   80107920 <copyout>
801015e4:	83 c4 10             	add    $0x10,%esp
801015e7:	85 c0                	test   %eax,%eax
801015e9:	78 8f                	js     8010157a <exec+0x24a>
801015eb:	8b 45 08             	mov    0x8(%ebp),%eax
801015ee:	8b 55 08             	mov    0x8(%ebp),%edx
801015f1:	0f b6 00             	movzbl (%eax),%eax
801015f4:	84 c0                	test   %al,%al
801015f6:	74 17                	je     8010160f <exec+0x2df>
801015f8:	89 d1                	mov    %edx,%ecx
801015fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101600:	83 c1 01             	add    $0x1,%ecx
80101603:	3c 2f                	cmp    $0x2f,%al
80101605:	0f b6 01             	movzbl (%ecx),%eax
80101608:	0f 44 d1             	cmove  %ecx,%edx
8010160b:	84 c0                	test   %al,%al
8010160d:	75 f1                	jne    80101600 <exec+0x2d0>
8010160f:	83 ec 04             	sub    $0x4,%esp
80101612:	6a 10                	push   $0x10
80101614:	52                   	push   %edx
80101615:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
8010161b:	8d 46 6c             	lea    0x6c(%esi),%eax
8010161e:	50                   	push   %eax
8010161f:	e8 bc 3a 00 00       	call   801050e0 <safestrcpy>
80101624:	8b 8d f4 fe ff ff    	mov    -0x10c(%ebp),%ecx
8010162a:	89 f0                	mov    %esi,%eax
8010162c:	8b 76 04             	mov    0x4(%esi),%esi
8010162f:	89 38                	mov    %edi,(%eax)
80101631:	89 48 04             	mov    %ecx,0x4(%eax)
80101634:	89 c1                	mov    %eax,%ecx
80101636:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
8010163c:	8b 40 18             	mov    0x18(%eax),%eax
8010163f:	89 50 38             	mov    %edx,0x38(%eax)
80101642:	8b 41 18             	mov    0x18(%ecx),%eax
80101645:	89 58 44             	mov    %ebx,0x44(%eax)
80101648:	89 0c 24             	mov    %ecx,(%esp)
8010164b:	e8 30 5c 00 00       	call   80107280 <switchuvm>
80101650:	89 34 24             	mov    %esi,(%esp)
80101653:	e8 d8 5f 00 00       	call   80107630 <freevm>
80101658:	83 c4 10             	add    $0x10,%esp
8010165b:	31 c0                	xor    %eax,%eax
8010165d:	e9 3f fe ff ff       	jmp    801014a1 <exec+0x171>
80101662:	bb 00 20 00 00       	mov    $0x2000,%ebx
80101667:	31 f6                	xor    %esi,%esi
80101669:	e9 5a fe ff ff       	jmp    801014c8 <exec+0x198>
8010166e:	be 10 00 00 00       	mov    $0x10,%esi
80101673:	ba 04 00 00 00       	mov    $0x4,%edx
80101678:	b8 03 00 00 00       	mov    $0x3,%eax
8010167d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
80101684:	00 00 00 
80101687:	8d 8d 58 ff ff ff    	lea    -0xa8(%ebp),%ecx
8010168d:	e9 17 ff ff ff       	jmp    801015a9 <exec+0x279>
80101692:	e8 a9 1f 00 00       	call   80103640 <end_op>
80101697:	83 ec 0c             	sub    $0xc,%esp
8010169a:	68 70 7a 10 80       	push   $0x80107a70
8010169f:	e8 9c f5 ff ff       	call   80100c40 <cprintf>
801016a4:	83 c4 10             	add    $0x10,%esp
801016a7:	e9 f0 fd ff ff       	jmp    8010149c <exec+0x16c>
801016ac:	66 90                	xchg   %ax,%ax
801016ae:	66 90                	xchg   %ax,%ax

801016b0 <fileinit>:
801016b0:	55                   	push   %ebp
801016b1:	89 e5                	mov    %esp,%ebp
801016b3:	83 ec 10             	sub    $0x10,%esp
801016b6:	68 7c 7a 10 80       	push   $0x80107a7c
801016bb:	68 a0 06 11 80       	push   $0x801106a0
801016c0:	e8 7b 35 00 00       	call   80104c40 <initlock>
801016c5:	83 c4 10             	add    $0x10,%esp
801016c8:	c9                   	leave
801016c9:	c3                   	ret
801016ca:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801016d0 <filealloc>:
801016d0:	55                   	push   %ebp
801016d1:	89 e5                	mov    %esp,%ebp
801016d3:	53                   	push   %ebx
801016d4:	bb d4 06 11 80       	mov    $0x801106d4,%ebx
801016d9:	83 ec 10             	sub    $0x10,%esp
801016dc:	68 a0 06 11 80       	push   $0x801106a0
801016e1:	e8 4a 37 00 00       	call   80104e30 <acquire>
801016e6:	83 c4 10             	add    $0x10,%esp
801016e9:	eb 10                	jmp    801016fb <filealloc+0x2b>
801016eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801016f0:	83 c3 18             	add    $0x18,%ebx
801016f3:	81 fb 34 10 11 80    	cmp    $0x80111034,%ebx
801016f9:	74 25                	je     80101720 <filealloc+0x50>
801016fb:	8b 43 04             	mov    0x4(%ebx),%eax
801016fe:	85 c0                	test   %eax,%eax
80101700:	75 ee                	jne    801016f0 <filealloc+0x20>
80101702:	83 ec 0c             	sub    $0xc,%esp
80101705:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
8010170c:	68 a0 06 11 80       	push   $0x801106a0
80101711:	e8 ba 36 00 00       	call   80104dd0 <release>
80101716:	89 d8                	mov    %ebx,%eax
80101718:	83 c4 10             	add    $0x10,%esp
8010171b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010171e:	c9                   	leave
8010171f:	c3                   	ret
80101720:	83 ec 0c             	sub    $0xc,%esp
80101723:	31 db                	xor    %ebx,%ebx
80101725:	68 a0 06 11 80       	push   $0x801106a0
8010172a:	e8 a1 36 00 00       	call   80104dd0 <release>
8010172f:	89 d8                	mov    %ebx,%eax
80101731:	83 c4 10             	add    $0x10,%esp
80101734:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101737:	c9                   	leave
80101738:	c3                   	ret
80101739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101740 <filedup>:
80101740:	55                   	push   %ebp
80101741:	89 e5                	mov    %esp,%ebp
80101743:	53                   	push   %ebx
80101744:	83 ec 10             	sub    $0x10,%esp
80101747:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010174a:	68 a0 06 11 80       	push   $0x801106a0
8010174f:	e8 dc 36 00 00       	call   80104e30 <acquire>
80101754:	8b 43 04             	mov    0x4(%ebx),%eax
80101757:	83 c4 10             	add    $0x10,%esp
8010175a:	85 c0                	test   %eax,%eax
8010175c:	7e 1a                	jle    80101778 <filedup+0x38>
8010175e:	83 c0 01             	add    $0x1,%eax
80101761:	83 ec 0c             	sub    $0xc,%esp
80101764:	89 43 04             	mov    %eax,0x4(%ebx)
80101767:	68 a0 06 11 80       	push   $0x801106a0
8010176c:	e8 5f 36 00 00       	call   80104dd0 <release>
80101771:	89 d8                	mov    %ebx,%eax
80101773:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101776:	c9                   	leave
80101777:	c3                   	ret
80101778:	83 ec 0c             	sub    $0xc,%esp
8010177b:	68 83 7a 10 80       	push   $0x80107a83
80101780:	e8 1b ec ff ff       	call   801003a0 <panic>
80101785:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010178c:	00 
8010178d:	8d 76 00             	lea    0x0(%esi),%esi

80101790 <fileclose>:
80101790:	55                   	push   %ebp
80101791:	89 e5                	mov    %esp,%ebp
80101793:	57                   	push   %edi
80101794:	56                   	push   %esi
80101795:	53                   	push   %ebx
80101796:	83 ec 28             	sub    $0x28,%esp
80101799:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010179c:	68 a0 06 11 80       	push   $0x801106a0
801017a1:	e8 8a 36 00 00       	call   80104e30 <acquire>
801017a6:	8b 53 04             	mov    0x4(%ebx),%edx
801017a9:	83 c4 10             	add    $0x10,%esp
801017ac:	85 d2                	test   %edx,%edx
801017ae:	0f 8e a5 00 00 00    	jle    80101859 <fileclose+0xc9>
801017b4:	83 ea 01             	sub    $0x1,%edx
801017b7:	89 53 04             	mov    %edx,0x4(%ebx)
801017ba:	75 44                	jne    80101800 <fileclose+0x70>
801017bc:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
801017c0:	83 ec 0c             	sub    $0xc,%esp
801017c3:	8b 3b                	mov    (%ebx),%edi
801017c5:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
801017cb:	8b 73 0c             	mov    0xc(%ebx),%esi
801017ce:	88 45 e7             	mov    %al,-0x19(%ebp)
801017d1:	8b 43 10             	mov    0x10(%ebx),%eax
801017d4:	89 45 e0             	mov    %eax,-0x20(%ebp)
801017d7:	68 a0 06 11 80       	push   $0x801106a0
801017dc:	e8 ef 35 00 00       	call   80104dd0 <release>
801017e1:	83 c4 10             	add    $0x10,%esp
801017e4:	83 ff 01             	cmp    $0x1,%edi
801017e7:	74 57                	je     80101840 <fileclose+0xb0>
801017e9:	83 ff 02             	cmp    $0x2,%edi
801017ec:	74 2a                	je     80101818 <fileclose+0x88>
801017ee:	8d 65 f4             	lea    -0xc(%ebp),%esp
801017f1:	5b                   	pop    %ebx
801017f2:	5e                   	pop    %esi
801017f3:	5f                   	pop    %edi
801017f4:	5d                   	pop    %ebp
801017f5:	c3                   	ret
801017f6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801017fd:	00 
801017fe:	66 90                	xchg   %ax,%ax
80101800:	c7 45 08 a0 06 11 80 	movl   $0x801106a0,0x8(%ebp)
80101807:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010180a:	5b                   	pop    %ebx
8010180b:	5e                   	pop    %esi
8010180c:	5f                   	pop    %edi
8010180d:	5d                   	pop    %ebp
8010180e:	e9 bd 35 00 00       	jmp    80104dd0 <release>
80101813:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80101818:	e8 b3 1d 00 00       	call   801035d0 <begin_op>
8010181d:	83 ec 0c             	sub    $0xc,%esp
80101820:	ff 75 e0             	push   -0x20(%ebp)
80101823:	e8 28 09 00 00       	call   80102150 <iput>
80101828:	83 c4 10             	add    $0x10,%esp
8010182b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010182e:	5b                   	pop    %ebx
8010182f:	5e                   	pop    %esi
80101830:	5f                   	pop    %edi
80101831:	5d                   	pop    %ebp
80101832:	e9 09 1e 00 00       	jmp    80103640 <end_op>
80101837:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010183e:	00 
8010183f:	90                   	nop
80101840:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80101844:	83 ec 08             	sub    $0x8,%esp
80101847:	53                   	push   %ebx
80101848:	56                   	push   %esi
80101849:	e8 42 25 00 00       	call   80103d90 <pipeclose>
8010184e:	83 c4 10             	add    $0x10,%esp
80101851:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101854:	5b                   	pop    %ebx
80101855:	5e                   	pop    %esi
80101856:	5f                   	pop    %edi
80101857:	5d                   	pop    %ebp
80101858:	c3                   	ret
80101859:	83 ec 0c             	sub    $0xc,%esp
8010185c:	68 8b 7a 10 80       	push   $0x80107a8b
80101861:	e8 3a eb ff ff       	call   801003a0 <panic>
80101866:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010186d:	00 
8010186e:	66 90                	xchg   %ax,%ax

80101870 <filestat>:
80101870:	55                   	push   %ebp
80101871:	89 e5                	mov    %esp,%ebp
80101873:	53                   	push   %ebx
80101874:	83 ec 04             	sub    $0x4,%esp
80101877:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010187a:	83 3b 02             	cmpl   $0x2,(%ebx)
8010187d:	75 31                	jne    801018b0 <filestat+0x40>
8010187f:	83 ec 0c             	sub    $0xc,%esp
80101882:	ff 73 10             	push   0x10(%ebx)
80101885:	e8 96 07 00 00       	call   80102020 <ilock>
8010188a:	58                   	pop    %eax
8010188b:	5a                   	pop    %edx
8010188c:	ff 75 0c             	push   0xc(%ebp)
8010188f:	ff 73 10             	push   0x10(%ebx)
80101892:	e8 69 0a 00 00       	call   80102300 <stati>
80101897:	59                   	pop    %ecx
80101898:	ff 73 10             	push   0x10(%ebx)
8010189b:	e8 60 08 00 00       	call   80102100 <iunlock>
801018a0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801018a3:	83 c4 10             	add    $0x10,%esp
801018a6:	31 c0                	xor    %eax,%eax
801018a8:	c9                   	leave
801018a9:	c3                   	ret
801018aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801018b0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801018b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801018b8:	c9                   	leave
801018b9:	c3                   	ret
801018ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801018c0 <fileread>:
801018c0:	55                   	push   %ebp
801018c1:	89 e5                	mov    %esp,%ebp
801018c3:	57                   	push   %edi
801018c4:	56                   	push   %esi
801018c5:	53                   	push   %ebx
801018c6:	83 ec 0c             	sub    $0xc,%esp
801018c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801018cc:	8b 75 0c             	mov    0xc(%ebp),%esi
801018cf:	8b 7d 10             	mov    0x10(%ebp),%edi
801018d2:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
801018d6:	74 60                	je     80101938 <fileread+0x78>
801018d8:	8b 03                	mov    (%ebx),%eax
801018da:	83 f8 01             	cmp    $0x1,%eax
801018dd:	74 41                	je     80101920 <fileread+0x60>
801018df:	83 f8 02             	cmp    $0x2,%eax
801018e2:	75 5b                	jne    8010193f <fileread+0x7f>
801018e4:	83 ec 0c             	sub    $0xc,%esp
801018e7:	ff 73 10             	push   0x10(%ebx)
801018ea:	e8 31 07 00 00       	call   80102020 <ilock>
801018ef:	57                   	push   %edi
801018f0:	ff 73 14             	push   0x14(%ebx)
801018f3:	56                   	push   %esi
801018f4:	ff 73 10             	push   0x10(%ebx)
801018f7:	e8 34 0a 00 00       	call   80102330 <readi>
801018fc:	83 c4 20             	add    $0x20,%esp
801018ff:	89 c6                	mov    %eax,%esi
80101901:	85 c0                	test   %eax,%eax
80101903:	7e 03                	jle    80101908 <fileread+0x48>
80101905:	01 43 14             	add    %eax,0x14(%ebx)
80101908:	83 ec 0c             	sub    $0xc,%esp
8010190b:	ff 73 10             	push   0x10(%ebx)
8010190e:	e8 ed 07 00 00       	call   80102100 <iunlock>
80101913:	83 c4 10             	add    $0x10,%esp
80101916:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101919:	89 f0                	mov    %esi,%eax
8010191b:	5b                   	pop    %ebx
8010191c:	5e                   	pop    %esi
8010191d:	5f                   	pop    %edi
8010191e:	5d                   	pop    %ebp
8010191f:	c3                   	ret
80101920:	8b 43 0c             	mov    0xc(%ebx),%eax
80101923:	89 45 08             	mov    %eax,0x8(%ebp)
80101926:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101929:	5b                   	pop    %ebx
8010192a:	5e                   	pop    %esi
8010192b:	5f                   	pop    %edi
8010192c:	5d                   	pop    %ebp
8010192d:	e9 1e 26 00 00       	jmp    80103f50 <piperead>
80101932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101938:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010193d:	eb d7                	jmp    80101916 <fileread+0x56>
8010193f:	83 ec 0c             	sub    $0xc,%esp
80101942:	68 95 7a 10 80       	push   $0x80107a95
80101947:	e8 54 ea ff ff       	call   801003a0 <panic>
8010194c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101950 <filewrite>:
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
80101965:	80 7b 09 00          	cmpb   $0x0,0x9(%ebx)
80101969:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010196c:	0f 84 bb 00 00 00    	je     80101a2d <filewrite+0xdd>
80101972:	8b 03                	mov    (%ebx),%eax
80101974:	83 f8 01             	cmp    $0x1,%eax
80101977:	0f 84 bf 00 00 00    	je     80101a3c <filewrite+0xec>
8010197d:	83 f8 02             	cmp    $0x2,%eax
80101980:	0f 85 c8 00 00 00    	jne    80101a4e <filewrite+0xfe>
80101986:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101989:	31 f6                	xor    %esi,%esi
8010198b:	85 c0                	test   %eax,%eax
8010198d:	7f 30                	jg     801019bf <filewrite+0x6f>
8010198f:	e9 94 00 00 00       	jmp    80101a28 <filewrite+0xd8>
80101994:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101998:	01 43 14             	add    %eax,0x14(%ebx)
8010199b:	83 ec 0c             	sub    $0xc,%esp
8010199e:	89 45 e0             	mov    %eax,-0x20(%ebp)
801019a1:	ff 73 10             	push   0x10(%ebx)
801019a4:	e8 57 07 00 00       	call   80102100 <iunlock>
801019a9:	e8 92 1c 00 00       	call   80103640 <end_op>
801019ae:	8b 45 e0             	mov    -0x20(%ebp),%eax
801019b1:	83 c4 10             	add    $0x10,%esp
801019b4:	39 c7                	cmp    %eax,%edi
801019b6:	75 5c                	jne    80101a14 <filewrite+0xc4>
801019b8:	01 fe                	add    %edi,%esi
801019ba:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
801019bd:	7e 69                	jle    80101a28 <filewrite+0xd8>
801019bf:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019c2:	b8 00 06 00 00       	mov    $0x600,%eax
801019c7:	29 f7                	sub    %esi,%edi
801019c9:	39 c7                	cmp    %eax,%edi
801019cb:	0f 4f f8             	cmovg  %eax,%edi
801019ce:	e8 fd 1b 00 00       	call   801035d0 <begin_op>
801019d3:	83 ec 0c             	sub    $0xc,%esp
801019d6:	ff 73 10             	push   0x10(%ebx)
801019d9:	e8 42 06 00 00       	call   80102020 <ilock>
801019de:	57                   	push   %edi
801019df:	ff 73 14             	push   0x14(%ebx)
801019e2:	8b 45 dc             	mov    -0x24(%ebp),%eax
801019e5:	01 f0                	add    %esi,%eax
801019e7:	50                   	push   %eax
801019e8:	ff 73 10             	push   0x10(%ebx)
801019eb:	e8 40 0a 00 00       	call   80102430 <writei>
801019f0:	83 c4 20             	add    $0x20,%esp
801019f3:	85 c0                	test   %eax,%eax
801019f5:	7f a1                	jg     80101998 <filewrite+0x48>
801019f7:	89 45 e0             	mov    %eax,-0x20(%ebp)
801019fa:	83 ec 0c             	sub    $0xc,%esp
801019fd:	ff 73 10             	push   0x10(%ebx)
80101a00:	e8 fb 06 00 00       	call   80102100 <iunlock>
80101a05:	e8 36 1c 00 00       	call   80103640 <end_op>
80101a0a:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101a0d:	83 c4 10             	add    $0x10,%esp
80101a10:	85 c0                	test   %eax,%eax
80101a12:	75 14                	jne    80101a28 <filewrite+0xd8>
80101a14:	83 ec 0c             	sub    $0xc,%esp
80101a17:	68 9e 7a 10 80       	push   $0x80107a9e
80101a1c:	e8 7f e9 ff ff       	call   801003a0 <panic>
80101a21:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101a28:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80101a2b:	74 05                	je     80101a32 <filewrite+0xe2>
80101a2d:	be ff ff ff ff       	mov    $0xffffffff,%esi
80101a32:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a35:	89 f0                	mov    %esi,%eax
80101a37:	5b                   	pop    %ebx
80101a38:	5e                   	pop    %esi
80101a39:	5f                   	pop    %edi
80101a3a:	5d                   	pop    %ebp
80101a3b:	c3                   	ret
80101a3c:	8b 43 0c             	mov    0xc(%ebx),%eax
80101a3f:	89 45 08             	mov    %eax,0x8(%ebp)
80101a42:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a45:	5b                   	pop    %ebx
80101a46:	5e                   	pop    %esi
80101a47:	5f                   	pop    %edi
80101a48:	5d                   	pop    %ebp
80101a49:	e9 e2 23 00 00       	jmp    80103e30 <pipewrite>
80101a4e:	83 ec 0c             	sub    $0xc,%esp
80101a51:	68 a4 7a 10 80       	push   $0x80107aa4
80101a56:	e8 45 e9 ff ff       	call   801003a0 <panic>
80101a5b:	66 90                	xchg   %ax,%ax
80101a5d:	66 90                	xchg   %ax,%ax
80101a5f:	90                   	nop

80101a60 <balloc>:
80101a60:	55                   	push   %ebp
80101a61:	89 e5                	mov    %esp,%ebp
80101a63:	57                   	push   %edi
80101a64:	56                   	push   %esi
80101a65:	53                   	push   %ebx
80101a66:	83 ec 1c             	sub    $0x1c,%esp
80101a69:	8b 0d f4 2c 11 80    	mov    0x80112cf4,%ecx
80101a6f:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101a72:	85 c9                	test   %ecx,%ecx
80101a74:	0f 84 8c 00 00 00    	je     80101b06 <balloc+0xa6>
80101a7a:	31 ff                	xor    %edi,%edi
80101a7c:	89 f8                	mov    %edi,%eax
80101a7e:	83 ec 08             	sub    $0x8,%esp
80101a81:	89 fe                	mov    %edi,%esi
80101a83:	c1 f8 0c             	sar    $0xc,%eax
80101a86:	03 05 0c 2d 11 80    	add    0x80112d0c,%eax
80101a8c:	50                   	push   %eax
80101a8d:	ff 75 dc             	push   -0x24(%ebp)
80101a90:	e8 3b e6 ff ff       	call   801000d0 <bread>
80101a95:	83 c4 10             	add    $0x10,%esp
80101a98:	89 7d d8             	mov    %edi,-0x28(%ebp)
80101a9b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101a9e:	a1 f4 2c 11 80       	mov    0x80112cf4,%eax
80101aa3:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101aa6:	31 c0                	xor    %eax,%eax
80101aa8:	eb 32                	jmp    80101adc <balloc+0x7c>
80101aaa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101ab0:	89 c1                	mov    %eax,%ecx
80101ab2:	bb 01 00 00 00       	mov    $0x1,%ebx
80101ab7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101aba:	83 e1 07             	and    $0x7,%ecx
80101abd:	d3 e3                	shl    %cl,%ebx
80101abf:	89 c1                	mov    %eax,%ecx
80101ac1:	c1 f9 03             	sar    $0x3,%ecx
80101ac4:	0f b6 7c 0f 5c       	movzbl 0x5c(%edi,%ecx,1),%edi
80101ac9:	89 fa                	mov    %edi,%edx
80101acb:	85 df                	test   %ebx,%edi
80101acd:	74 49                	je     80101b18 <balloc+0xb8>
80101acf:	83 c0 01             	add    $0x1,%eax
80101ad2:	83 c6 01             	add    $0x1,%esi
80101ad5:	3d 00 10 00 00       	cmp    $0x1000,%eax
80101ada:	74 07                	je     80101ae3 <balloc+0x83>
80101adc:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101adf:	39 d6                	cmp    %edx,%esi
80101ae1:	72 cd                	jb     80101ab0 <balloc+0x50>
80101ae3:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101ae6:	83 ec 0c             	sub    $0xc,%esp
80101ae9:	ff 75 e4             	push   -0x1c(%ebp)
80101aec:	81 c7 00 10 00 00    	add    $0x1000,%edi
80101af2:	e8 f9 e6 ff ff       	call   801001f0 <brelse>
80101af7:	83 c4 10             	add    $0x10,%esp
80101afa:	3b 3d f4 2c 11 80    	cmp    0x80112cf4,%edi
80101b00:	0f 82 76 ff ff ff    	jb     80101a7c <balloc+0x1c>
80101b06:	83 ec 0c             	sub    $0xc,%esp
80101b09:	68 ae 7a 10 80       	push   $0x80107aae
80101b0e:	e8 8d e8 ff ff       	call   801003a0 <panic>
80101b13:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80101b18:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101b1b:	83 ec 0c             	sub    $0xc,%esp
80101b1e:	09 da                	or     %ebx,%edx
80101b20:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
80101b24:	57                   	push   %edi
80101b25:	e8 86 1c 00 00       	call   801037b0 <log_write>
80101b2a:	89 3c 24             	mov    %edi,(%esp)
80101b2d:	e8 be e6 ff ff       	call   801001f0 <brelse>
80101b32:	58                   	pop    %eax
80101b33:	5a                   	pop    %edx
80101b34:	56                   	push   %esi
80101b35:	ff 75 dc             	push   -0x24(%ebp)
80101b38:	e8 93 e5 ff ff       	call   801000d0 <bread>
80101b3d:	83 c4 0c             	add    $0xc,%esp
80101b40:	89 c3                	mov    %eax,%ebx
80101b42:	8d 40 5c             	lea    0x5c(%eax),%eax
80101b45:	68 00 02 00 00       	push   $0x200
80101b4a:	6a 00                	push   $0x0
80101b4c:	50                   	push   %eax
80101b4d:	e8 de 33 00 00       	call   80104f30 <memset>
80101b52:	89 1c 24             	mov    %ebx,(%esp)
80101b55:	e8 56 1c 00 00       	call   801037b0 <log_write>
80101b5a:	89 1c 24             	mov    %ebx,(%esp)
80101b5d:	e8 8e e6 ff ff       	call   801001f0 <brelse>
80101b62:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b65:	89 f0                	mov    %esi,%eax
80101b67:	5b                   	pop    %ebx
80101b68:	5e                   	pop    %esi
80101b69:	5f                   	pop    %edi
80101b6a:	5d                   	pop    %ebp
80101b6b:	c3                   	ret
80101b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101b70 <iget>:
80101b70:	55                   	push   %ebp
80101b71:	89 e5                	mov    %esp,%ebp
80101b73:	57                   	push   %edi
80101b74:	31 ff                	xor    %edi,%edi
80101b76:	56                   	push   %esi
80101b77:	89 c6                	mov    %eax,%esi
80101b79:	53                   	push   %ebx
80101b7a:	bb d4 10 11 80       	mov    $0x801110d4,%ebx
80101b7f:	83 ec 28             	sub    $0x28,%esp
80101b82:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101b85:	68 a0 10 11 80       	push   $0x801110a0
80101b8a:	e8 a1 32 00 00       	call   80104e30 <acquire>
80101b8f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101b92:	83 c4 10             	add    $0x10,%esp
80101b95:	eb 1b                	jmp    80101bb2 <iget+0x42>
80101b97:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101b9e:	00 
80101b9f:	90                   	nop
80101ba0:	39 33                	cmp    %esi,(%ebx)
80101ba2:	74 6c                	je     80101c10 <iget+0xa0>
80101ba4:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101baa:	81 fb f4 2c 11 80    	cmp    $0x80112cf4,%ebx
80101bb0:	74 26                	je     80101bd8 <iget+0x68>
80101bb2:	8b 43 08             	mov    0x8(%ebx),%eax
80101bb5:	85 c0                	test   %eax,%eax
80101bb7:	7f e7                	jg     80101ba0 <iget+0x30>
80101bb9:	85 ff                	test   %edi,%edi
80101bbb:	75 e7                	jne    80101ba4 <iget+0x34>
80101bbd:	85 c0                	test   %eax,%eax
80101bbf:	75 76                	jne    80101c37 <iget+0xc7>
80101bc1:	89 df                	mov    %ebx,%edi
80101bc3:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101bc9:	81 fb f4 2c 11 80    	cmp    $0x80112cf4,%ebx
80101bcf:	75 e1                	jne    80101bb2 <iget+0x42>
80101bd1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101bd8:	85 ff                	test   %edi,%edi
80101bda:	74 79                	je     80101c55 <iget+0xe5>
80101bdc:	83 ec 0c             	sub    $0xc,%esp
80101bdf:	89 37                	mov    %esi,(%edi)
80101be1:	89 57 04             	mov    %edx,0x4(%edi)
80101be4:	c7 47 08 01 00 00 00 	movl   $0x1,0x8(%edi)
80101beb:	c7 47 4c 00 00 00 00 	movl   $0x0,0x4c(%edi)
80101bf2:	68 a0 10 11 80       	push   $0x801110a0
80101bf7:	e8 d4 31 00 00       	call   80104dd0 <release>
80101bfc:	83 c4 10             	add    $0x10,%esp
80101bff:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c02:	89 f8                	mov    %edi,%eax
80101c04:	5b                   	pop    %ebx
80101c05:	5e                   	pop    %esi
80101c06:	5f                   	pop    %edi
80101c07:	5d                   	pop    %ebp
80101c08:	c3                   	ret
80101c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101c10:	39 53 04             	cmp    %edx,0x4(%ebx)
80101c13:	75 8f                	jne    80101ba4 <iget+0x34>
80101c15:	83 c0 01             	add    $0x1,%eax
80101c18:	83 ec 0c             	sub    $0xc,%esp
80101c1b:	89 df                	mov    %ebx,%edi
80101c1d:	89 43 08             	mov    %eax,0x8(%ebx)
80101c20:	68 a0 10 11 80       	push   $0x801110a0
80101c25:	e8 a6 31 00 00       	call   80104dd0 <release>
80101c2a:	83 c4 10             	add    $0x10,%esp
80101c2d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c30:	89 f8                	mov    %edi,%eax
80101c32:	5b                   	pop    %ebx
80101c33:	5e                   	pop    %esi
80101c34:	5f                   	pop    %edi
80101c35:	5d                   	pop    %ebp
80101c36:	c3                   	ret
80101c37:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101c3d:	81 fb f4 2c 11 80    	cmp    $0x80112cf4,%ebx
80101c43:	74 10                	je     80101c55 <iget+0xe5>
80101c45:	8b 43 08             	mov    0x8(%ebx),%eax
80101c48:	85 c0                	test   %eax,%eax
80101c4a:	0f 8f 50 ff ff ff    	jg     80101ba0 <iget+0x30>
80101c50:	e9 68 ff ff ff       	jmp    80101bbd <iget+0x4d>
80101c55:	83 ec 0c             	sub    $0xc,%esp
80101c58:	68 c4 7a 10 80       	push   $0x80107ac4
80101c5d:	e8 3e e7 ff ff       	call   801003a0 <panic>
80101c62:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101c69:	00 
80101c6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80101c70 <bfree>:
80101c70:	55                   	push   %ebp
80101c71:	89 c1                	mov    %eax,%ecx
80101c73:	89 d0                	mov    %edx,%eax
80101c75:	c1 e8 0c             	shr    $0xc,%eax
80101c78:	89 e5                	mov    %esp,%ebp
80101c7a:	56                   	push   %esi
80101c7b:	53                   	push   %ebx
80101c7c:	03 05 0c 2d 11 80    	add    0x80112d0c,%eax
80101c82:	89 d3                	mov    %edx,%ebx
80101c84:	83 ec 08             	sub    $0x8,%esp
80101c87:	50                   	push   %eax
80101c88:	51                   	push   %ecx
80101c89:	e8 42 e4 ff ff       	call   801000d0 <bread>
80101c8e:	89 d9                	mov    %ebx,%ecx
80101c90:	c1 fb 03             	sar    $0x3,%ebx
80101c93:	83 c4 10             	add    $0x10,%esp
80101c96:	89 c6                	mov    %eax,%esi
80101c98:	83 e1 07             	and    $0x7,%ecx
80101c9b:	b8 01 00 00 00       	mov    $0x1,%eax
80101ca0:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
80101ca6:	d3 e0                	shl    %cl,%eax
80101ca8:	0f b6 4c 1e 5c       	movzbl 0x5c(%esi,%ebx,1),%ecx
80101cad:	85 c1                	test   %eax,%ecx
80101caf:	74 23                	je     80101cd4 <bfree+0x64>
80101cb1:	f7 d0                	not    %eax
80101cb3:	83 ec 0c             	sub    $0xc,%esp
80101cb6:	21 c8                	and    %ecx,%eax
80101cb8:	88 44 1e 5c          	mov    %al,0x5c(%esi,%ebx,1)
80101cbc:	56                   	push   %esi
80101cbd:	e8 ee 1a 00 00       	call   801037b0 <log_write>
80101cc2:	89 34 24             	mov    %esi,(%esp)
80101cc5:	e8 26 e5 ff ff       	call   801001f0 <brelse>
80101cca:	83 c4 10             	add    $0x10,%esp
80101ccd:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101cd0:	5b                   	pop    %ebx
80101cd1:	5e                   	pop    %esi
80101cd2:	5d                   	pop    %ebp
80101cd3:	c3                   	ret
80101cd4:	83 ec 0c             	sub    $0xc,%esp
80101cd7:	68 d4 7a 10 80       	push   $0x80107ad4
80101cdc:	e8 bf e6 ff ff       	call   801003a0 <panic>
80101ce1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101ce8:	00 
80101ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101cf0 <bmap>:
80101cf0:	55                   	push   %ebp
80101cf1:	89 e5                	mov    %esp,%ebp
80101cf3:	57                   	push   %edi
80101cf4:	56                   	push   %esi
80101cf5:	89 c6                	mov    %eax,%esi
80101cf7:	53                   	push   %ebx
80101cf8:	83 ec 1c             	sub    $0x1c,%esp
80101cfb:	83 fa 0b             	cmp    $0xb,%edx
80101cfe:	0f 86 8c 00 00 00    	jbe    80101d90 <bmap+0xa0>
80101d04:	8d 5a f4             	lea    -0xc(%edx),%ebx
80101d07:	83 fb 7f             	cmp    $0x7f,%ebx
80101d0a:	0f 87 a2 00 00 00    	ja     80101db2 <bmap+0xc2>
80101d10:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101d16:	85 c0                	test   %eax,%eax
80101d18:	74 5e                	je     80101d78 <bmap+0x88>
80101d1a:	83 ec 08             	sub    $0x8,%esp
80101d1d:	50                   	push   %eax
80101d1e:	ff 36                	push   (%esi)
80101d20:	e8 ab e3 ff ff       	call   801000d0 <bread>
80101d25:	83 c4 10             	add    $0x10,%esp
80101d28:	8d 5c 98 5c          	lea    0x5c(%eax,%ebx,4),%ebx
80101d2c:	89 c2                	mov    %eax,%edx
80101d2e:	8b 3b                	mov    (%ebx),%edi
80101d30:	85 ff                	test   %edi,%edi
80101d32:	74 1c                	je     80101d50 <bmap+0x60>
80101d34:	83 ec 0c             	sub    $0xc,%esp
80101d37:	52                   	push   %edx
80101d38:	e8 b3 e4 ff ff       	call   801001f0 <brelse>
80101d3d:	83 c4 10             	add    $0x10,%esp
80101d40:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101d43:	89 f8                	mov    %edi,%eax
80101d45:	5b                   	pop    %ebx
80101d46:	5e                   	pop    %esi
80101d47:	5f                   	pop    %edi
80101d48:	5d                   	pop    %ebp
80101d49:	c3                   	ret
80101d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101d50:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d53:	8b 06                	mov    (%esi),%eax
80101d55:	e8 06 fd ff ff       	call   80101a60 <balloc>
80101d5a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101d5d:	83 ec 0c             	sub    $0xc,%esp
80101d60:	89 03                	mov    %eax,(%ebx)
80101d62:	89 c7                	mov    %eax,%edi
80101d64:	52                   	push   %edx
80101d65:	e8 46 1a 00 00       	call   801037b0 <log_write>
80101d6a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101d6d:	83 c4 10             	add    $0x10,%esp
80101d70:	eb c2                	jmp    80101d34 <bmap+0x44>
80101d72:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101d78:	8b 06                	mov    (%esi),%eax
80101d7a:	e8 e1 fc ff ff       	call   80101a60 <balloc>
80101d7f:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
80101d85:	eb 93                	jmp    80101d1a <bmap+0x2a>
80101d87:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101d8e:	00 
80101d8f:	90                   	nop
80101d90:	8d 5a 14             	lea    0x14(%edx),%ebx
80101d93:	8b 7c 98 0c          	mov    0xc(%eax,%ebx,4),%edi
80101d97:	85 ff                	test   %edi,%edi
80101d99:	75 a5                	jne    80101d40 <bmap+0x50>
80101d9b:	8b 00                	mov    (%eax),%eax
80101d9d:	e8 be fc ff ff       	call   80101a60 <balloc>
80101da2:	89 44 9e 0c          	mov    %eax,0xc(%esi,%ebx,4)
80101da6:	89 c7                	mov    %eax,%edi
80101da8:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dab:	5b                   	pop    %ebx
80101dac:	89 f8                	mov    %edi,%eax
80101dae:	5e                   	pop    %esi
80101daf:	5f                   	pop    %edi
80101db0:	5d                   	pop    %ebp
80101db1:	c3                   	ret
80101db2:	83 ec 0c             	sub    $0xc,%esp
80101db5:	68 e7 7a 10 80       	push   $0x80107ae7
80101dba:	e8 e1 e5 ff ff       	call   801003a0 <panic>
80101dbf:	90                   	nop

80101dc0 <readsb>:
80101dc0:	55                   	push   %ebp
80101dc1:	89 e5                	mov    %esp,%ebp
80101dc3:	56                   	push   %esi
80101dc4:	53                   	push   %ebx
80101dc5:	8b 75 0c             	mov    0xc(%ebp),%esi
80101dc8:	83 ec 08             	sub    $0x8,%esp
80101dcb:	6a 01                	push   $0x1
80101dcd:	ff 75 08             	push   0x8(%ebp)
80101dd0:	e8 fb e2 ff ff       	call   801000d0 <bread>
80101dd5:	83 c4 0c             	add    $0xc,%esp
80101dd8:	89 c3                	mov    %eax,%ebx
80101dda:	8d 40 5c             	lea    0x5c(%eax),%eax
80101ddd:	6a 1c                	push   $0x1c
80101ddf:	50                   	push   %eax
80101de0:	56                   	push   %esi
80101de1:	e8 da 31 00 00       	call   80104fc0 <memmove>
80101de6:	83 c4 10             	add    $0x10,%esp
80101de9:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101dec:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101def:	5b                   	pop    %ebx
80101df0:	5e                   	pop    %esi
80101df1:	5d                   	pop    %ebp
80101df2:	e9 f9 e3 ff ff       	jmp    801001f0 <brelse>
80101df7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101dfe:	00 
80101dff:	90                   	nop

80101e00 <iinit>:
80101e00:	55                   	push   %ebp
80101e01:	89 e5                	mov    %esp,%ebp
80101e03:	53                   	push   %ebx
80101e04:	bb e0 10 11 80       	mov    $0x801110e0,%ebx
80101e09:	83 ec 0c             	sub    $0xc,%esp
80101e0c:	68 fa 7a 10 80       	push   $0x80107afa
80101e11:	68 a0 10 11 80       	push   $0x801110a0
80101e16:	e8 25 2e 00 00       	call   80104c40 <initlock>
80101e1b:	83 c4 10             	add    $0x10,%esp
80101e1e:	66 90                	xchg   %ax,%ax
80101e20:	83 ec 08             	sub    $0x8,%esp
80101e23:	68 01 7b 10 80       	push   $0x80107b01
80101e28:	53                   	push   %ebx
80101e29:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101e2f:	e8 dc 2c 00 00       	call   80104b10 <initsleeplock>
80101e34:	83 c4 10             	add    $0x10,%esp
80101e37:	81 fb 00 2d 11 80    	cmp    $0x80112d00,%ebx
80101e3d:	75 e1                	jne    80101e20 <iinit+0x20>
80101e3f:	83 ec 08             	sub    $0x8,%esp
80101e42:	6a 01                	push   $0x1
80101e44:	ff 75 08             	push   0x8(%ebp)
80101e47:	e8 84 e2 ff ff       	call   801000d0 <bread>
80101e4c:	83 c4 0c             	add    $0xc,%esp
80101e4f:	89 c3                	mov    %eax,%ebx
80101e51:	8d 40 5c             	lea    0x5c(%eax),%eax
80101e54:	6a 1c                	push   $0x1c
80101e56:	50                   	push   %eax
80101e57:	68 f4 2c 11 80       	push   $0x80112cf4
80101e5c:	e8 5f 31 00 00       	call   80104fc0 <memmove>
80101e61:	89 1c 24             	mov    %ebx,(%esp)
80101e64:	e8 87 e3 ff ff       	call   801001f0 <brelse>
80101e69:	ff 35 0c 2d 11 80    	push   0x80112d0c
80101e6f:	ff 35 08 2d 11 80    	push   0x80112d08
80101e75:	ff 35 04 2d 11 80    	push   0x80112d04
80101e7b:	ff 35 00 2d 11 80    	push   0x80112d00
80101e81:	ff 35 fc 2c 11 80    	push   0x80112cfc
80101e87:	ff 35 f8 2c 11 80    	push   0x80112cf8
80101e8d:	ff 35 f4 2c 11 80    	push   0x80112cf4
80101e93:	68 64 7f 10 80       	push   $0x80107f64
80101e98:	e8 a3 ed ff ff       	call   80100c40 <cprintf>
80101e9d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101ea0:	83 c4 30             	add    $0x30,%esp
80101ea3:	c9                   	leave
80101ea4:	c3                   	ret
80101ea5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101eac:	00 
80101ead:	8d 76 00             	lea    0x0(%esi),%esi

80101eb0 <ialloc>:
80101eb0:	55                   	push   %ebp
80101eb1:	89 e5                	mov    %esp,%ebp
80101eb3:	57                   	push   %edi
80101eb4:	56                   	push   %esi
80101eb5:	53                   	push   %ebx
80101eb6:	83 ec 1c             	sub    $0x1c,%esp
80101eb9:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ebc:	83 3d fc 2c 11 80 01 	cmpl   $0x1,0x80112cfc
80101ec3:	8b 75 08             	mov    0x8(%ebp),%esi
80101ec6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101ec9:	0f 86 91 00 00 00    	jbe    80101f60 <ialloc+0xb0>
80101ecf:	bf 01 00 00 00       	mov    $0x1,%edi
80101ed4:	eb 21                	jmp    80101ef7 <ialloc+0x47>
80101ed6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80101edd:	00 
80101ede:	66 90                	xchg   %ax,%ax
80101ee0:	83 ec 0c             	sub    $0xc,%esp
80101ee3:	83 c7 01             	add    $0x1,%edi
80101ee6:	53                   	push   %ebx
80101ee7:	e8 04 e3 ff ff       	call   801001f0 <brelse>
80101eec:	83 c4 10             	add    $0x10,%esp
80101eef:	3b 3d fc 2c 11 80    	cmp    0x80112cfc,%edi
80101ef5:	73 69                	jae    80101f60 <ialloc+0xb0>
80101ef7:	89 f8                	mov    %edi,%eax
80101ef9:	83 ec 08             	sub    $0x8,%esp
80101efc:	c1 e8 03             	shr    $0x3,%eax
80101eff:	03 05 08 2d 11 80    	add    0x80112d08,%eax
80101f05:	50                   	push   %eax
80101f06:	56                   	push   %esi
80101f07:	e8 c4 e1 ff ff       	call   801000d0 <bread>
80101f0c:	83 c4 10             	add    $0x10,%esp
80101f0f:	89 c3                	mov    %eax,%ebx
80101f11:	89 f8                	mov    %edi,%eax
80101f13:	83 e0 07             	and    $0x7,%eax
80101f16:	c1 e0 06             	shl    $0x6,%eax
80101f19:	8d 4c 03 5c          	lea    0x5c(%ebx,%eax,1),%ecx
80101f1d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101f21:	75 bd                	jne    80101ee0 <ialloc+0x30>
80101f23:	83 ec 04             	sub    $0x4,%esp
80101f26:	6a 40                	push   $0x40
80101f28:	6a 00                	push   $0x0
80101f2a:	51                   	push   %ecx
80101f2b:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101f2e:	e8 fd 2f 00 00       	call   80104f30 <memset>
80101f33:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80101f37:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80101f3a:	66 89 01             	mov    %ax,(%ecx)
80101f3d:	89 1c 24             	mov    %ebx,(%esp)
80101f40:	e8 6b 18 00 00       	call   801037b0 <log_write>
80101f45:	89 1c 24             	mov    %ebx,(%esp)
80101f48:	e8 a3 e2 ff ff       	call   801001f0 <brelse>
80101f4d:	83 c4 10             	add    $0x10,%esp
80101f50:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101f53:	89 fa                	mov    %edi,%edx
80101f55:	5b                   	pop    %ebx
80101f56:	89 f0                	mov    %esi,%eax
80101f58:	5e                   	pop    %esi
80101f59:	5f                   	pop    %edi
80101f5a:	5d                   	pop    %ebp
80101f5b:	e9 10 fc ff ff       	jmp    80101b70 <iget>
80101f60:	83 ec 0c             	sub    $0xc,%esp
80101f63:	68 07 7b 10 80       	push   $0x80107b07
80101f68:	e8 33 e4 ff ff       	call   801003a0 <panic>
80101f6d:	8d 76 00             	lea    0x0(%esi),%esi

80101f70 <iupdate>:
80101f70:	55                   	push   %ebp
80101f71:	89 e5                	mov    %esp,%ebp
80101f73:	56                   	push   %esi
80101f74:	53                   	push   %ebx
80101f75:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101f78:	8b 43 04             	mov    0x4(%ebx),%eax
80101f7b:	83 c3 5c             	add    $0x5c,%ebx
80101f7e:	83 ec 08             	sub    $0x8,%esp
80101f81:	c1 e8 03             	shr    $0x3,%eax
80101f84:	03 05 08 2d 11 80    	add    0x80112d08,%eax
80101f8a:	50                   	push   %eax
80101f8b:	ff 73 a4             	push   -0x5c(%ebx)
80101f8e:	e8 3d e1 ff ff       	call   801000d0 <bread>
80101f93:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
80101f97:	83 c4 0c             	add    $0xc,%esp
80101f9a:	89 c6                	mov    %eax,%esi
80101f9c:	8b 43 a8             	mov    -0x58(%ebx),%eax
80101f9f:	83 e0 07             	and    $0x7,%eax
80101fa2:	c1 e0 06             	shl    $0x6,%eax
80101fa5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
80101fa9:	66 89 10             	mov    %dx,(%eax)
80101fac:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
80101fb0:	83 c0 0c             	add    $0xc,%eax
80101fb3:	66 89 50 f6          	mov    %dx,-0xa(%eax)
80101fb7:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
80101fbb:	66 89 50 f8          	mov    %dx,-0x8(%eax)
80101fbf:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101fc3:	66 89 50 fa          	mov    %dx,-0x6(%eax)
80101fc7:	8b 53 fc             	mov    -0x4(%ebx),%edx
80101fca:	89 50 fc             	mov    %edx,-0x4(%eax)
80101fcd:	6a 34                	push   $0x34
80101fcf:	53                   	push   %ebx
80101fd0:	50                   	push   %eax
80101fd1:	e8 ea 2f 00 00       	call   80104fc0 <memmove>
80101fd6:	89 34 24             	mov    %esi,(%esp)
80101fd9:	e8 d2 17 00 00       	call   801037b0 <log_write>
80101fde:	83 c4 10             	add    $0x10,%esp
80101fe1:	89 75 08             	mov    %esi,0x8(%ebp)
80101fe4:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101fe7:	5b                   	pop    %ebx
80101fe8:	5e                   	pop    %esi
80101fe9:	5d                   	pop    %ebp
80101fea:	e9 01 e2 ff ff       	jmp    801001f0 <brelse>
80101fef:	90                   	nop

80101ff0 <idup>:
80101ff0:	55                   	push   %ebp
80101ff1:	89 e5                	mov    %esp,%ebp
80101ff3:	53                   	push   %ebx
80101ff4:	83 ec 10             	sub    $0x10,%esp
80101ff7:	8b 5d 08             	mov    0x8(%ebp),%ebx
80101ffa:	68 a0 10 11 80       	push   $0x801110a0
80101fff:	e8 2c 2e 00 00       	call   80104e30 <acquire>
80102004:	83 43 08 01          	addl   $0x1,0x8(%ebx)
80102008:	c7 04 24 a0 10 11 80 	movl   $0x801110a0,(%esp)
8010200f:	e8 bc 2d 00 00       	call   80104dd0 <release>
80102014:	89 d8                	mov    %ebx,%eax
80102016:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102019:	c9                   	leave
8010201a:	c3                   	ret
8010201b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102020 <ilock>:
80102020:	55                   	push   %ebp
80102021:	89 e5                	mov    %esp,%ebp
80102023:	56                   	push   %esi
80102024:	53                   	push   %ebx
80102025:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102028:	85 db                	test   %ebx,%ebx
8010202a:	0f 84 b7 00 00 00    	je     801020e7 <ilock+0xc7>
80102030:	8b 53 08             	mov    0x8(%ebx),%edx
80102033:	85 d2                	test   %edx,%edx
80102035:	0f 8e ac 00 00 00    	jle    801020e7 <ilock+0xc7>
8010203b:	83 ec 0c             	sub    $0xc,%esp
8010203e:	8d 43 0c             	lea    0xc(%ebx),%eax
80102041:	50                   	push   %eax
80102042:	e8 09 2b 00 00       	call   80104b50 <acquiresleep>
80102047:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010204a:	83 c4 10             	add    $0x10,%esp
8010204d:	85 c0                	test   %eax,%eax
8010204f:	74 0f                	je     80102060 <ilock+0x40>
80102051:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102054:	5b                   	pop    %ebx
80102055:	5e                   	pop    %esi
80102056:	5d                   	pop    %ebp
80102057:	c3                   	ret
80102058:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010205f:	00 
80102060:	8b 43 04             	mov    0x4(%ebx),%eax
80102063:	83 ec 08             	sub    $0x8,%esp
80102066:	c1 e8 03             	shr    $0x3,%eax
80102069:	03 05 08 2d 11 80    	add    0x80112d08,%eax
8010206f:	50                   	push   %eax
80102070:	ff 33                	push   (%ebx)
80102072:	e8 59 e0 ff ff       	call   801000d0 <bread>
80102077:	83 c4 0c             	add    $0xc,%esp
8010207a:	89 c6                	mov    %eax,%esi
8010207c:	8b 43 04             	mov    0x4(%ebx),%eax
8010207f:	83 e0 07             	and    $0x7,%eax
80102082:	c1 e0 06             	shl    $0x6,%eax
80102085:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
80102089:	0f b7 10             	movzwl (%eax),%edx
8010208c:	83 c0 0c             	add    $0xc,%eax
8010208f:	66 89 53 50          	mov    %dx,0x50(%ebx)
80102093:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80102097:	66 89 53 52          	mov    %dx,0x52(%ebx)
8010209b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010209f:	66 89 53 54          	mov    %dx,0x54(%ebx)
801020a3:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
801020a7:	66 89 53 56          	mov    %dx,0x56(%ebx)
801020ab:	8b 50 fc             	mov    -0x4(%eax),%edx
801020ae:	89 53 58             	mov    %edx,0x58(%ebx)
801020b1:	6a 34                	push   $0x34
801020b3:	50                   	push   %eax
801020b4:	8d 43 5c             	lea    0x5c(%ebx),%eax
801020b7:	50                   	push   %eax
801020b8:	e8 03 2f 00 00       	call   80104fc0 <memmove>
801020bd:	89 34 24             	mov    %esi,(%esp)
801020c0:	e8 2b e1 ff ff       	call   801001f0 <brelse>
801020c5:	83 c4 10             	add    $0x10,%esp
801020c8:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
801020cd:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
801020d4:	0f 85 77 ff ff ff    	jne    80102051 <ilock+0x31>
801020da:	83 ec 0c             	sub    $0xc,%esp
801020dd:	68 1f 7b 10 80       	push   $0x80107b1f
801020e2:	e8 b9 e2 ff ff       	call   801003a0 <panic>
801020e7:	83 ec 0c             	sub    $0xc,%esp
801020ea:	68 19 7b 10 80       	push   $0x80107b19
801020ef:	e8 ac e2 ff ff       	call   801003a0 <panic>
801020f4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801020fb:	00 
801020fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102100 <iunlock>:
80102100:	55                   	push   %ebp
80102101:	89 e5                	mov    %esp,%ebp
80102103:	56                   	push   %esi
80102104:	53                   	push   %ebx
80102105:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102108:	85 db                	test   %ebx,%ebx
8010210a:	74 28                	je     80102134 <iunlock+0x34>
8010210c:	83 ec 0c             	sub    $0xc,%esp
8010210f:	8d 73 0c             	lea    0xc(%ebx),%esi
80102112:	56                   	push   %esi
80102113:	e8 d8 2a 00 00       	call   80104bf0 <holdingsleep>
80102118:	83 c4 10             	add    $0x10,%esp
8010211b:	85 c0                	test   %eax,%eax
8010211d:	74 15                	je     80102134 <iunlock+0x34>
8010211f:	8b 43 08             	mov    0x8(%ebx),%eax
80102122:	85 c0                	test   %eax,%eax
80102124:	7e 0e                	jle    80102134 <iunlock+0x34>
80102126:	89 75 08             	mov    %esi,0x8(%ebp)
80102129:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010212c:	5b                   	pop    %ebx
8010212d:	5e                   	pop    %esi
8010212e:	5d                   	pop    %ebp
8010212f:	e9 7c 2a 00 00       	jmp    80104bb0 <releasesleep>
80102134:	83 ec 0c             	sub    $0xc,%esp
80102137:	68 2e 7b 10 80       	push   $0x80107b2e
8010213c:	e8 5f e2 ff ff       	call   801003a0 <panic>
80102141:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102148:	00 
80102149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102150 <iput>:
80102150:	55                   	push   %ebp
80102151:	89 e5                	mov    %esp,%ebp
80102153:	57                   	push   %edi
80102154:	56                   	push   %esi
80102155:	53                   	push   %ebx
80102156:	83 ec 28             	sub    $0x28,%esp
80102159:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010215c:	8d 7b 0c             	lea    0xc(%ebx),%edi
8010215f:	57                   	push   %edi
80102160:	e8 eb 29 00 00       	call   80104b50 <acquiresleep>
80102165:	8b 53 4c             	mov    0x4c(%ebx),%edx
80102168:	83 c4 10             	add    $0x10,%esp
8010216b:	85 d2                	test   %edx,%edx
8010216d:	74 07                	je     80102176 <iput+0x26>
8010216f:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80102174:	74 32                	je     801021a8 <iput+0x58>
80102176:	83 ec 0c             	sub    $0xc,%esp
80102179:	57                   	push   %edi
8010217a:	e8 31 2a 00 00       	call   80104bb0 <releasesleep>
8010217f:	c7 04 24 a0 10 11 80 	movl   $0x801110a0,(%esp)
80102186:	e8 a5 2c 00 00       	call   80104e30 <acquire>
8010218b:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
8010218f:	83 c4 10             	add    $0x10,%esp
80102192:	c7 45 08 a0 10 11 80 	movl   $0x801110a0,0x8(%ebp)
80102199:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010219c:	5b                   	pop    %ebx
8010219d:	5e                   	pop    %esi
8010219e:	5f                   	pop    %edi
8010219f:	5d                   	pop    %ebp
801021a0:	e9 2b 2c 00 00       	jmp    80104dd0 <release>
801021a5:	8d 76 00             	lea    0x0(%esi),%esi
801021a8:	83 ec 0c             	sub    $0xc,%esp
801021ab:	68 a0 10 11 80       	push   $0x801110a0
801021b0:	e8 7b 2c 00 00       	call   80104e30 <acquire>
801021b5:	8b 73 08             	mov    0x8(%ebx),%esi
801021b8:	c7 04 24 a0 10 11 80 	movl   $0x801110a0,(%esp)
801021bf:	e8 0c 2c 00 00       	call   80104dd0 <release>
801021c4:	83 c4 10             	add    $0x10,%esp
801021c7:	83 fe 01             	cmp    $0x1,%esi
801021ca:	75 aa                	jne    80102176 <iput+0x26>
801021cc:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
801021d2:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801021d5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801021d8:	89 df                	mov    %ebx,%edi
801021da:	89 cb                	mov    %ecx,%ebx
801021dc:	eb 09                	jmp    801021e7 <iput+0x97>
801021de:	66 90                	xchg   %ax,%ax
801021e0:	83 c6 04             	add    $0x4,%esi
801021e3:	39 de                	cmp    %ebx,%esi
801021e5:	74 19                	je     80102200 <iput+0xb0>
801021e7:	8b 16                	mov    (%esi),%edx
801021e9:	85 d2                	test   %edx,%edx
801021eb:	74 f3                	je     801021e0 <iput+0x90>
801021ed:	8b 07                	mov    (%edi),%eax
801021ef:	e8 7c fa ff ff       	call   80101c70 <bfree>
801021f4:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
801021fa:	eb e4                	jmp    801021e0 <iput+0x90>
801021fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102200:	89 fb                	mov    %edi,%ebx
80102202:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80102205:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
8010220b:	85 c0                	test   %eax,%eax
8010220d:	75 2d                	jne    8010223c <iput+0xec>
8010220f:	83 ec 0c             	sub    $0xc,%esp
80102212:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
80102219:	53                   	push   %ebx
8010221a:	e8 51 fd ff ff       	call   80101f70 <iupdate>
8010221f:	31 c0                	xor    %eax,%eax
80102221:	66 89 43 50          	mov    %ax,0x50(%ebx)
80102225:	89 1c 24             	mov    %ebx,(%esp)
80102228:	e8 43 fd ff ff       	call   80101f70 <iupdate>
8010222d:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
80102234:	83 c4 10             	add    $0x10,%esp
80102237:	e9 3a ff ff ff       	jmp    80102176 <iput+0x26>
8010223c:	83 ec 08             	sub    $0x8,%esp
8010223f:	50                   	push   %eax
80102240:	ff 33                	push   (%ebx)
80102242:	e8 89 de ff ff       	call   801000d0 <bread>
80102247:	83 c4 10             	add    $0x10,%esp
8010224a:	89 7d e4             	mov    %edi,-0x1c(%ebp)
8010224d:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
80102253:	89 45 e0             	mov    %eax,-0x20(%ebp)
80102256:	8d 70 5c             	lea    0x5c(%eax),%esi
80102259:	89 cf                	mov    %ecx,%edi
8010225b:	eb 0a                	jmp    80102267 <iput+0x117>
8010225d:	8d 76 00             	lea    0x0(%esi),%esi
80102260:	83 c6 04             	add    $0x4,%esi
80102263:	39 fe                	cmp    %edi,%esi
80102265:	74 0f                	je     80102276 <iput+0x126>
80102267:	8b 16                	mov    (%esi),%edx
80102269:	85 d2                	test   %edx,%edx
8010226b:	74 f3                	je     80102260 <iput+0x110>
8010226d:	8b 03                	mov    (%ebx),%eax
8010226f:	e8 fc f9 ff ff       	call   80101c70 <bfree>
80102274:	eb ea                	jmp    80102260 <iput+0x110>
80102276:	8b 45 e0             	mov    -0x20(%ebp),%eax
80102279:	83 ec 0c             	sub    $0xc,%esp
8010227c:	8b 7d e4             	mov    -0x1c(%ebp),%edi
8010227f:	50                   	push   %eax
80102280:	e8 6b df ff ff       	call   801001f0 <brelse>
80102285:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
8010228b:	8b 03                	mov    (%ebx),%eax
8010228d:	e8 de f9 ff ff       	call   80101c70 <bfree>
80102292:	83 c4 10             	add    $0x10,%esp
80102295:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
8010229c:	00 00 00 
8010229f:	e9 6b ff ff ff       	jmp    8010220f <iput+0xbf>
801022a4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801022ab:	00 
801022ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801022b0 <iunlockput>:
801022b0:	55                   	push   %ebp
801022b1:	89 e5                	mov    %esp,%ebp
801022b3:	56                   	push   %esi
801022b4:	53                   	push   %ebx
801022b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
801022b8:	85 db                	test   %ebx,%ebx
801022ba:	74 34                	je     801022f0 <iunlockput+0x40>
801022bc:	83 ec 0c             	sub    $0xc,%esp
801022bf:	8d 73 0c             	lea    0xc(%ebx),%esi
801022c2:	56                   	push   %esi
801022c3:	e8 28 29 00 00       	call   80104bf0 <holdingsleep>
801022c8:	83 c4 10             	add    $0x10,%esp
801022cb:	85 c0                	test   %eax,%eax
801022cd:	74 21                	je     801022f0 <iunlockput+0x40>
801022cf:	8b 43 08             	mov    0x8(%ebx),%eax
801022d2:	85 c0                	test   %eax,%eax
801022d4:	7e 1a                	jle    801022f0 <iunlockput+0x40>
801022d6:	83 ec 0c             	sub    $0xc,%esp
801022d9:	56                   	push   %esi
801022da:	e8 d1 28 00 00       	call   80104bb0 <releasesleep>
801022df:	83 c4 10             	add    $0x10,%esp
801022e2:	89 5d 08             	mov    %ebx,0x8(%ebp)
801022e5:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022e8:	5b                   	pop    %ebx
801022e9:	5e                   	pop    %esi
801022ea:	5d                   	pop    %ebp
801022eb:	e9 60 fe ff ff       	jmp    80102150 <iput>
801022f0:	83 ec 0c             	sub    $0xc,%esp
801022f3:	68 2e 7b 10 80       	push   $0x80107b2e
801022f8:	e8 a3 e0 ff ff       	call   801003a0 <panic>
801022fd:	8d 76 00             	lea    0x0(%esi),%esi

80102300 <stati>:
80102300:	55                   	push   %ebp
80102301:	89 e5                	mov    %esp,%ebp
80102303:	8b 55 08             	mov    0x8(%ebp),%edx
80102306:	8b 45 0c             	mov    0xc(%ebp),%eax
80102309:	8b 0a                	mov    (%edx),%ecx
8010230b:	89 48 04             	mov    %ecx,0x4(%eax)
8010230e:	8b 4a 04             	mov    0x4(%edx),%ecx
80102311:	89 48 08             	mov    %ecx,0x8(%eax)
80102314:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80102318:	66 89 08             	mov    %cx,(%eax)
8010231b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010231f:	66 89 48 0c          	mov    %cx,0xc(%eax)
80102323:	8b 52 58             	mov    0x58(%edx),%edx
80102326:	89 50 10             	mov    %edx,0x10(%eax)
80102329:	5d                   	pop    %ebp
8010232a:	c3                   	ret
8010232b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102330 <readi>:
80102330:	55                   	push   %ebp
80102331:	89 e5                	mov    %esp,%ebp
80102333:	57                   	push   %edi
80102334:	56                   	push   %esi
80102335:	53                   	push   %ebx
80102336:	83 ec 1c             	sub    $0x1c,%esp
80102339:	8b 75 08             	mov    0x8(%ebp),%esi
8010233c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010233f:	8b 7d 10             	mov    0x10(%ebp),%edi
80102342:	66 83 7e 50 03       	cmpw   $0x3,0x50(%esi)
80102347:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010234a:	89 75 d8             	mov    %esi,-0x28(%ebp)
8010234d:	8b 45 14             	mov    0x14(%ebp),%eax
80102350:	0f 84 aa 00 00 00    	je     80102400 <readi+0xd0>
80102356:	8b 75 d8             	mov    -0x28(%ebp),%esi
80102359:	8b 56 58             	mov    0x58(%esi),%edx
8010235c:	39 fa                	cmp    %edi,%edx
8010235e:	0f 82 bd 00 00 00    	jb     80102421 <readi+0xf1>
80102364:	89 f9                	mov    %edi,%ecx
80102366:	31 db                	xor    %ebx,%ebx
80102368:	01 c1                	add    %eax,%ecx
8010236a:	0f 92 c3             	setb   %bl
8010236d:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80102370:	0f 82 ab 00 00 00    	jb     80102421 <readi+0xf1>
80102376:	89 d3                	mov    %edx,%ebx
80102378:	29 fb                	sub    %edi,%ebx
8010237a:	39 ca                	cmp    %ecx,%edx
8010237c:	0f 42 c3             	cmovb  %ebx,%eax
8010237f:	85 c0                	test   %eax,%eax
80102381:	74 73                	je     801023f6 <readi+0xc6>
80102383:	8b 75 e4             	mov    -0x1c(%ebp),%esi
80102386:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80102389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102390:	8b 5d d8             	mov    -0x28(%ebp),%ebx
80102393:	89 fa                	mov    %edi,%edx
80102395:	c1 ea 09             	shr    $0x9,%edx
80102398:	89 d8                	mov    %ebx,%eax
8010239a:	e8 51 f9 ff ff       	call   80101cf0 <bmap>
8010239f:	83 ec 08             	sub    $0x8,%esp
801023a2:	50                   	push   %eax
801023a3:	ff 33                	push   (%ebx)
801023a5:	e8 26 dd ff ff       	call   801000d0 <bread>
801023aa:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801023ad:	b9 00 02 00 00       	mov    $0x200,%ecx
801023b2:	89 c2                	mov    %eax,%edx
801023b4:	89 f8                	mov    %edi,%eax
801023b6:	25 ff 01 00 00       	and    $0x1ff,%eax
801023bb:	29 f3                	sub    %esi,%ebx
801023bd:	29 c1                	sub    %eax,%ecx
801023bf:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
801023c3:	39 d9                	cmp    %ebx,%ecx
801023c5:	0f 46 d9             	cmovbe %ecx,%ebx
801023c8:	83 c4 0c             	add    $0xc,%esp
801023cb:	53                   	push   %ebx
801023cc:	01 de                	add    %ebx,%esi
801023ce:	01 df                	add    %ebx,%edi
801023d0:	89 55 dc             	mov    %edx,-0x24(%ebp)
801023d3:	50                   	push   %eax
801023d4:	ff 75 e0             	push   -0x20(%ebp)
801023d7:	e8 e4 2b 00 00       	call   80104fc0 <memmove>
801023dc:	8b 55 dc             	mov    -0x24(%ebp),%edx
801023df:	89 14 24             	mov    %edx,(%esp)
801023e2:	e8 09 de ff ff       	call   801001f0 <brelse>
801023e7:	01 5d e0             	add    %ebx,-0x20(%ebp)
801023ea:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801023ed:	83 c4 10             	add    $0x10,%esp
801023f0:	39 de                	cmp    %ebx,%esi
801023f2:	72 9c                	jb     80102390 <readi+0x60>
801023f4:	89 d8                	mov    %ebx,%eax
801023f6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801023f9:	5b                   	pop    %ebx
801023fa:	5e                   	pop    %esi
801023fb:	5f                   	pop    %edi
801023fc:	5d                   	pop    %ebp
801023fd:	c3                   	ret
801023fe:	66 90                	xchg   %ax,%ax
80102400:	0f bf 56 52          	movswl 0x52(%esi),%edx
80102404:	66 83 fa 09          	cmp    $0x9,%dx
80102408:	77 17                	ja     80102421 <readi+0xf1>
8010240a:	8b 14 d5 40 10 11 80 	mov    -0x7feeefc0(,%edx,8),%edx
80102411:	85 d2                	test   %edx,%edx
80102413:	74 0c                	je     80102421 <readi+0xf1>
80102415:	89 45 10             	mov    %eax,0x10(%ebp)
80102418:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010241b:	5b                   	pop    %ebx
8010241c:	5e                   	pop    %esi
8010241d:	5f                   	pop    %edi
8010241e:	5d                   	pop    %ebp
8010241f:	ff e2                	jmp    *%edx
80102421:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102426:	eb ce                	jmp    801023f6 <readi+0xc6>
80102428:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010242f:	00 

80102430 <writei>:
80102430:	55                   	push   %ebp
80102431:	89 e5                	mov    %esp,%ebp
80102433:	57                   	push   %edi
80102434:	56                   	push   %esi
80102435:	53                   	push   %ebx
80102436:	83 ec 1c             	sub    $0x1c,%esp
80102439:	8b 45 08             	mov    0x8(%ebp),%eax
8010243c:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010243f:	8b 75 14             	mov    0x14(%ebp),%esi
80102442:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
80102447:	89 7d dc             	mov    %edi,-0x24(%ebp)
8010244a:	89 75 e0             	mov    %esi,-0x20(%ebp)
8010244d:	8b 7d 10             	mov    0x10(%ebp),%edi
80102450:	0f 84 ba 00 00 00    	je     80102510 <writei+0xe0>
80102456:	39 78 58             	cmp    %edi,0x58(%eax)
80102459:	0f 82 ea 00 00 00    	jb     80102549 <writei+0x119>
8010245f:	8b 75 e0             	mov    -0x20(%ebp),%esi
80102462:	89 f2                	mov    %esi,%edx
80102464:	01 fa                	add    %edi,%edx
80102466:	0f 82 dd 00 00 00    	jb     80102549 <writei+0x119>
8010246c:	81 fa 00 18 01 00    	cmp    $0x11800,%edx
80102472:	0f 87 d1 00 00 00    	ja     80102549 <writei+0x119>
80102478:	85 f6                	test   %esi,%esi
8010247a:	0f 84 85 00 00 00    	je     80102505 <writei+0xd5>
80102480:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80102487:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010248a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102490:	8b 75 d8             	mov    -0x28(%ebp),%esi
80102493:	89 fa                	mov    %edi,%edx
80102495:	c1 ea 09             	shr    $0x9,%edx
80102498:	89 f0                	mov    %esi,%eax
8010249a:	e8 51 f8 ff ff       	call   80101cf0 <bmap>
8010249f:	83 ec 08             	sub    $0x8,%esp
801024a2:	50                   	push   %eax
801024a3:	ff 36                	push   (%esi)
801024a5:	e8 26 dc ff ff       	call   801000d0 <bread>
801024aa:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801024ad:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801024b0:	b9 00 02 00 00       	mov    $0x200,%ecx
801024b5:	89 c6                	mov    %eax,%esi
801024b7:	89 f8                	mov    %edi,%eax
801024b9:	25 ff 01 00 00       	and    $0x1ff,%eax
801024be:	29 d3                	sub    %edx,%ebx
801024c0:	29 c1                	sub    %eax,%ecx
801024c2:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
801024c6:	39 d9                	cmp    %ebx,%ecx
801024c8:	0f 46 d9             	cmovbe %ecx,%ebx
801024cb:	83 c4 0c             	add    $0xc,%esp
801024ce:	53                   	push   %ebx
801024cf:	01 df                	add    %ebx,%edi
801024d1:	ff 75 dc             	push   -0x24(%ebp)
801024d4:	50                   	push   %eax
801024d5:	e8 e6 2a 00 00       	call   80104fc0 <memmove>
801024da:	89 34 24             	mov    %esi,(%esp)
801024dd:	e8 ce 12 00 00       	call   801037b0 <log_write>
801024e2:	89 34 24             	mov    %esi,(%esp)
801024e5:	e8 06 dd ff ff       	call   801001f0 <brelse>
801024ea:	01 5d e4             	add    %ebx,-0x1c(%ebp)
801024ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801024f0:	83 c4 10             	add    $0x10,%esp
801024f3:	01 5d dc             	add    %ebx,-0x24(%ebp)
801024f6:	8b 5d e0             	mov    -0x20(%ebp),%ebx
801024f9:	39 d8                	cmp    %ebx,%eax
801024fb:	72 93                	jb     80102490 <writei+0x60>
801024fd:	8b 45 d8             	mov    -0x28(%ebp),%eax
80102500:	39 78 58             	cmp    %edi,0x58(%eax)
80102503:	72 33                	jb     80102538 <writei+0x108>
80102505:	8b 45 e0             	mov    -0x20(%ebp),%eax
80102508:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010250b:	5b                   	pop    %ebx
8010250c:	5e                   	pop    %esi
8010250d:	5f                   	pop    %edi
8010250e:	5d                   	pop    %ebp
8010250f:	c3                   	ret
80102510:	0f bf 40 52          	movswl 0x52(%eax),%eax
80102514:	66 83 f8 09          	cmp    $0x9,%ax
80102518:	77 2f                	ja     80102549 <writei+0x119>
8010251a:	8b 04 c5 44 10 11 80 	mov    -0x7feeefbc(,%eax,8),%eax
80102521:	85 c0                	test   %eax,%eax
80102523:	74 24                	je     80102549 <writei+0x119>
80102525:	89 75 10             	mov    %esi,0x10(%ebp)
80102528:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010252b:	5b                   	pop    %ebx
8010252c:	5e                   	pop    %esi
8010252d:	5f                   	pop    %edi
8010252e:	5d                   	pop    %ebp
8010252f:	ff e0                	jmp    *%eax
80102531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102538:	83 ec 0c             	sub    $0xc,%esp
8010253b:	89 78 58             	mov    %edi,0x58(%eax)
8010253e:	50                   	push   %eax
8010253f:	e8 2c fa ff ff       	call   80101f70 <iupdate>
80102544:	83 c4 10             	add    $0x10,%esp
80102547:	eb bc                	jmp    80102505 <writei+0xd5>
80102549:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010254e:	eb b8                	jmp    80102508 <writei+0xd8>

80102550 <namecmp>:
80102550:	55                   	push   %ebp
80102551:	89 e5                	mov    %esp,%ebp
80102553:	83 ec 0c             	sub    $0xc,%esp
80102556:	6a 0e                	push   $0xe
80102558:	ff 75 0c             	push   0xc(%ebp)
8010255b:	ff 75 08             	push   0x8(%ebp)
8010255e:	e8 cd 2a 00 00       	call   80105030 <strncmp>
80102563:	c9                   	leave
80102564:	c3                   	ret
80102565:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010256c:	00 
8010256d:	8d 76 00             	lea    0x0(%esi),%esi

80102570 <dirlookup>:
80102570:	55                   	push   %ebp
80102571:	89 e5                	mov    %esp,%ebp
80102573:	57                   	push   %edi
80102574:	56                   	push   %esi
80102575:	53                   	push   %ebx
80102576:	83 ec 1c             	sub    $0x1c,%esp
80102579:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010257c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80102581:	0f 85 85 00 00 00    	jne    8010260c <dirlookup+0x9c>
80102587:	8b 53 58             	mov    0x58(%ebx),%edx
8010258a:	31 ff                	xor    %edi,%edi
8010258c:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010258f:	85 d2                	test   %edx,%edx
80102591:	74 3e                	je     801025d1 <dirlookup+0x61>
80102593:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102598:	6a 10                	push   $0x10
8010259a:	57                   	push   %edi
8010259b:	56                   	push   %esi
8010259c:	53                   	push   %ebx
8010259d:	e8 8e fd ff ff       	call   80102330 <readi>
801025a2:	83 c4 10             	add    $0x10,%esp
801025a5:	83 f8 10             	cmp    $0x10,%eax
801025a8:	75 55                	jne    801025ff <dirlookup+0x8f>
801025aa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801025af:	74 18                	je     801025c9 <dirlookup+0x59>
801025b1:	83 ec 04             	sub    $0x4,%esp
801025b4:	8d 45 da             	lea    -0x26(%ebp),%eax
801025b7:	6a 0e                	push   $0xe
801025b9:	50                   	push   %eax
801025ba:	ff 75 0c             	push   0xc(%ebp)
801025bd:	e8 6e 2a 00 00       	call   80105030 <strncmp>
801025c2:	83 c4 10             	add    $0x10,%esp
801025c5:	85 c0                	test   %eax,%eax
801025c7:	74 17                	je     801025e0 <dirlookup+0x70>
801025c9:	83 c7 10             	add    $0x10,%edi
801025cc:	3b 7b 58             	cmp    0x58(%ebx),%edi
801025cf:	72 c7                	jb     80102598 <dirlookup+0x28>
801025d1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801025d4:	31 c0                	xor    %eax,%eax
801025d6:	5b                   	pop    %ebx
801025d7:	5e                   	pop    %esi
801025d8:	5f                   	pop    %edi
801025d9:	5d                   	pop    %ebp
801025da:	c3                   	ret
801025db:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801025e0:	8b 45 10             	mov    0x10(%ebp),%eax
801025e3:	85 c0                	test   %eax,%eax
801025e5:	74 05                	je     801025ec <dirlookup+0x7c>
801025e7:	8b 45 10             	mov    0x10(%ebp),%eax
801025ea:	89 38                	mov    %edi,(%eax)
801025ec:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
801025f0:	8b 03                	mov    (%ebx),%eax
801025f2:	e8 79 f5 ff ff       	call   80101b70 <iget>
801025f7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801025fa:	5b                   	pop    %ebx
801025fb:	5e                   	pop    %esi
801025fc:	5f                   	pop    %edi
801025fd:	5d                   	pop    %ebp
801025fe:	c3                   	ret
801025ff:	83 ec 0c             	sub    $0xc,%esp
80102602:	68 48 7b 10 80       	push   $0x80107b48
80102607:	e8 94 dd ff ff       	call   801003a0 <panic>
8010260c:	83 ec 0c             	sub    $0xc,%esp
8010260f:	68 36 7b 10 80       	push   $0x80107b36
80102614:	e8 87 dd ff ff       	call   801003a0 <panic>
80102619:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102620 <namex>:
80102620:	55                   	push   %ebp
80102621:	89 e5                	mov    %esp,%ebp
80102623:	57                   	push   %edi
80102624:	56                   	push   %esi
80102625:	53                   	push   %ebx
80102626:	89 c3                	mov    %eax,%ebx
80102628:	83 ec 1c             	sub    $0x1c,%esp
8010262b:	80 38 2f             	cmpb   $0x2f,(%eax)
8010262e:	89 55 dc             	mov    %edx,-0x24(%ebp)
80102631:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80102634:	0f 84 9e 01 00 00    	je     801027d8 <namex+0x1b8>
8010263a:	e8 b1 1b 00 00       	call   801041f0 <myproc>
8010263f:	83 ec 0c             	sub    $0xc,%esp
80102642:	8b 70 68             	mov    0x68(%eax),%esi
80102645:	68 a0 10 11 80       	push   $0x801110a0
8010264a:	e8 e1 27 00 00       	call   80104e30 <acquire>
8010264f:	83 46 08 01          	addl   $0x1,0x8(%esi)
80102653:	c7 04 24 a0 10 11 80 	movl   $0x801110a0,(%esp)
8010265a:	e8 71 27 00 00       	call   80104dd0 <release>
8010265f:	83 c4 10             	add    $0x10,%esp
80102662:	eb 07                	jmp    8010266b <namex+0x4b>
80102664:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102668:	83 c3 01             	add    $0x1,%ebx
8010266b:	0f b6 03             	movzbl (%ebx),%eax
8010266e:	3c 2f                	cmp    $0x2f,%al
80102670:	74 f6                	je     80102668 <namex+0x48>
80102672:	84 c0                	test   %al,%al
80102674:	0f 84 06 01 00 00    	je     80102780 <namex+0x160>
8010267a:	0f b6 03             	movzbl (%ebx),%eax
8010267d:	84 c0                	test   %al,%al
8010267f:	0f 84 10 01 00 00    	je     80102795 <namex+0x175>
80102685:	89 df                	mov    %ebx,%edi
80102687:	3c 2f                	cmp    $0x2f,%al
80102689:	0f 84 06 01 00 00    	je     80102795 <namex+0x175>
8010268f:	90                   	nop
80102690:	0f b6 47 01          	movzbl 0x1(%edi),%eax
80102694:	83 c7 01             	add    $0x1,%edi
80102697:	3c 2f                	cmp    $0x2f,%al
80102699:	74 04                	je     8010269f <namex+0x7f>
8010269b:	84 c0                	test   %al,%al
8010269d:	75 f1                	jne    80102690 <namex+0x70>
8010269f:	89 f8                	mov    %edi,%eax
801026a1:	29 d8                	sub    %ebx,%eax
801026a3:	83 f8 0d             	cmp    $0xd,%eax
801026a6:	0f 8e ac 00 00 00    	jle    80102758 <namex+0x138>
801026ac:	83 ec 04             	sub    $0x4,%esp
801026af:	6a 0e                	push   $0xe
801026b1:	53                   	push   %ebx
801026b2:	89 fb                	mov    %edi,%ebx
801026b4:	ff 75 e4             	push   -0x1c(%ebp)
801026b7:	e8 04 29 00 00       	call   80104fc0 <memmove>
801026bc:	83 c4 10             	add    $0x10,%esp
801026bf:	80 3f 2f             	cmpb   $0x2f,(%edi)
801026c2:	75 0c                	jne    801026d0 <namex+0xb0>
801026c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801026c8:	83 c3 01             	add    $0x1,%ebx
801026cb:	80 3b 2f             	cmpb   $0x2f,(%ebx)
801026ce:	74 f8                	je     801026c8 <namex+0xa8>
801026d0:	83 ec 0c             	sub    $0xc,%esp
801026d3:	56                   	push   %esi
801026d4:	e8 47 f9 ff ff       	call   80102020 <ilock>
801026d9:	83 c4 10             	add    $0x10,%esp
801026dc:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801026e1:	0f 85 b7 00 00 00    	jne    8010279e <namex+0x17e>
801026e7:	8b 45 dc             	mov    -0x24(%ebp),%eax
801026ea:	85 c0                	test   %eax,%eax
801026ec:	74 09                	je     801026f7 <namex+0xd7>
801026ee:	80 3b 00             	cmpb   $0x0,(%ebx)
801026f1:	0f 84 f7 00 00 00    	je     801027ee <namex+0x1ce>
801026f7:	83 ec 04             	sub    $0x4,%esp
801026fa:	6a 00                	push   $0x0
801026fc:	ff 75 e4             	push   -0x1c(%ebp)
801026ff:	56                   	push   %esi
80102700:	e8 6b fe ff ff       	call   80102570 <dirlookup>
80102705:	83 c4 10             	add    $0x10,%esp
80102708:	89 c7                	mov    %eax,%edi
8010270a:	85 c0                	test   %eax,%eax
8010270c:	0f 84 8c 00 00 00    	je     8010279e <namex+0x17e>
80102712:	83 ec 0c             	sub    $0xc,%esp
80102715:	8d 4e 0c             	lea    0xc(%esi),%ecx
80102718:	51                   	push   %ecx
80102719:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010271c:	e8 cf 24 00 00       	call   80104bf0 <holdingsleep>
80102721:	83 c4 10             	add    $0x10,%esp
80102724:	85 c0                	test   %eax,%eax
80102726:	0f 84 02 01 00 00    	je     8010282e <namex+0x20e>
8010272c:	8b 56 08             	mov    0x8(%esi),%edx
8010272f:	85 d2                	test   %edx,%edx
80102731:	0f 8e f7 00 00 00    	jle    8010282e <namex+0x20e>
80102737:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010273a:	83 ec 0c             	sub    $0xc,%esp
8010273d:	51                   	push   %ecx
8010273e:	e8 6d 24 00 00       	call   80104bb0 <releasesleep>
80102743:	89 34 24             	mov    %esi,(%esp)
80102746:	89 fe                	mov    %edi,%esi
80102748:	e8 03 fa ff ff       	call   80102150 <iput>
8010274d:	83 c4 10             	add    $0x10,%esp
80102750:	e9 16 ff ff ff       	jmp    8010266b <namex+0x4b>
80102755:	8d 76 00             	lea    0x0(%esi),%esi
80102758:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010275b:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
8010275e:	83 ec 04             	sub    $0x4,%esp
80102761:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80102764:	50                   	push   %eax
80102765:	53                   	push   %ebx
80102766:	89 fb                	mov    %edi,%ebx
80102768:	ff 75 e4             	push   -0x1c(%ebp)
8010276b:	e8 50 28 00 00       	call   80104fc0 <memmove>
80102770:	8b 4d e0             	mov    -0x20(%ebp),%ecx
80102773:	83 c4 10             	add    $0x10,%esp
80102776:	c6 01 00             	movb   $0x0,(%ecx)
80102779:	e9 41 ff ff ff       	jmp    801026bf <namex+0x9f>
8010277e:	66 90                	xchg   %ax,%ax
80102780:	8b 45 dc             	mov    -0x24(%ebp),%eax
80102783:	85 c0                	test   %eax,%eax
80102785:	0f 85 93 00 00 00    	jne    8010281e <namex+0x1fe>
8010278b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010278e:	89 f0                	mov    %esi,%eax
80102790:	5b                   	pop    %ebx
80102791:	5e                   	pop    %esi
80102792:	5f                   	pop    %edi
80102793:	5d                   	pop    %ebp
80102794:	c3                   	ret
80102795:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80102798:	89 df                	mov    %ebx,%edi
8010279a:	31 c0                	xor    %eax,%eax
8010279c:	eb c0                	jmp    8010275e <namex+0x13e>
8010279e:	83 ec 0c             	sub    $0xc,%esp
801027a1:	8d 5e 0c             	lea    0xc(%esi),%ebx
801027a4:	53                   	push   %ebx
801027a5:	e8 46 24 00 00       	call   80104bf0 <holdingsleep>
801027aa:	83 c4 10             	add    $0x10,%esp
801027ad:	85 c0                	test   %eax,%eax
801027af:	74 7d                	je     8010282e <namex+0x20e>
801027b1:	8b 4e 08             	mov    0x8(%esi),%ecx
801027b4:	85 c9                	test   %ecx,%ecx
801027b6:	7e 76                	jle    8010282e <namex+0x20e>
801027b8:	83 ec 0c             	sub    $0xc,%esp
801027bb:	53                   	push   %ebx
801027bc:	e8 ef 23 00 00       	call   80104bb0 <releasesleep>
801027c1:	89 34 24             	mov    %esi,(%esp)
801027c4:	31 f6                	xor    %esi,%esi
801027c6:	e8 85 f9 ff ff       	call   80102150 <iput>
801027cb:	83 c4 10             	add    $0x10,%esp
801027ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
801027d1:	89 f0                	mov    %esi,%eax
801027d3:	5b                   	pop    %ebx
801027d4:	5e                   	pop    %esi
801027d5:	5f                   	pop    %edi
801027d6:	5d                   	pop    %ebp
801027d7:	c3                   	ret
801027d8:	ba 01 00 00 00       	mov    $0x1,%edx
801027dd:	b8 01 00 00 00       	mov    $0x1,%eax
801027e2:	e8 89 f3 ff ff       	call   80101b70 <iget>
801027e7:	89 c6                	mov    %eax,%esi
801027e9:	e9 7d fe ff ff       	jmp    8010266b <namex+0x4b>
801027ee:	83 ec 0c             	sub    $0xc,%esp
801027f1:	8d 5e 0c             	lea    0xc(%esi),%ebx
801027f4:	53                   	push   %ebx
801027f5:	e8 f6 23 00 00       	call   80104bf0 <holdingsleep>
801027fa:	83 c4 10             	add    $0x10,%esp
801027fd:	85 c0                	test   %eax,%eax
801027ff:	74 2d                	je     8010282e <namex+0x20e>
80102801:	8b 7e 08             	mov    0x8(%esi),%edi
80102804:	85 ff                	test   %edi,%edi
80102806:	7e 26                	jle    8010282e <namex+0x20e>
80102808:	83 ec 0c             	sub    $0xc,%esp
8010280b:	53                   	push   %ebx
8010280c:	e8 9f 23 00 00       	call   80104bb0 <releasesleep>
80102811:	83 c4 10             	add    $0x10,%esp
80102814:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102817:	89 f0                	mov    %esi,%eax
80102819:	5b                   	pop    %ebx
8010281a:	5e                   	pop    %esi
8010281b:	5f                   	pop    %edi
8010281c:	5d                   	pop    %ebp
8010281d:	c3                   	ret
8010281e:	83 ec 0c             	sub    $0xc,%esp
80102821:	56                   	push   %esi
80102822:	31 f6                	xor    %esi,%esi
80102824:	e8 27 f9 ff ff       	call   80102150 <iput>
80102829:	83 c4 10             	add    $0x10,%esp
8010282c:	eb a0                	jmp    801027ce <namex+0x1ae>
8010282e:	83 ec 0c             	sub    $0xc,%esp
80102831:	68 2e 7b 10 80       	push   $0x80107b2e
80102836:	e8 65 db ff ff       	call   801003a0 <panic>
8010283b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102840 <dirlink>:
80102840:	55                   	push   %ebp
80102841:	89 e5                	mov    %esp,%ebp
80102843:	57                   	push   %edi
80102844:	56                   	push   %esi
80102845:	53                   	push   %ebx
80102846:	83 ec 20             	sub    $0x20,%esp
80102849:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010284c:	6a 00                	push   $0x0
8010284e:	ff 75 0c             	push   0xc(%ebp)
80102851:	53                   	push   %ebx
80102852:	e8 19 fd ff ff       	call   80102570 <dirlookup>
80102857:	83 c4 10             	add    $0x10,%esp
8010285a:	85 c0                	test   %eax,%eax
8010285c:	75 67                	jne    801028c5 <dirlink+0x85>
8010285e:	8b 7b 58             	mov    0x58(%ebx),%edi
80102861:	8d 75 d8             	lea    -0x28(%ebp),%esi
80102864:	85 ff                	test   %edi,%edi
80102866:	74 29                	je     80102891 <dirlink+0x51>
80102868:	31 ff                	xor    %edi,%edi
8010286a:	8d 75 d8             	lea    -0x28(%ebp),%esi
8010286d:	eb 09                	jmp    80102878 <dirlink+0x38>
8010286f:	90                   	nop
80102870:	83 c7 10             	add    $0x10,%edi
80102873:	3b 7b 58             	cmp    0x58(%ebx),%edi
80102876:	73 19                	jae    80102891 <dirlink+0x51>
80102878:	6a 10                	push   $0x10
8010287a:	57                   	push   %edi
8010287b:	56                   	push   %esi
8010287c:	53                   	push   %ebx
8010287d:	e8 ae fa ff ff       	call   80102330 <readi>
80102882:	83 c4 10             	add    $0x10,%esp
80102885:	83 f8 10             	cmp    $0x10,%eax
80102888:	75 4e                	jne    801028d8 <dirlink+0x98>
8010288a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
8010288f:	75 df                	jne    80102870 <dirlink+0x30>
80102891:	83 ec 04             	sub    $0x4,%esp
80102894:	8d 45 da             	lea    -0x26(%ebp),%eax
80102897:	6a 0e                	push   $0xe
80102899:	ff 75 0c             	push   0xc(%ebp)
8010289c:	50                   	push   %eax
8010289d:	e8 de 27 00 00       	call   80105080 <strncpy>
801028a2:	8b 45 10             	mov    0x10(%ebp),%eax
801028a5:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
801028a9:	6a 10                	push   $0x10
801028ab:	57                   	push   %edi
801028ac:	56                   	push   %esi
801028ad:	53                   	push   %ebx
801028ae:	e8 7d fb ff ff       	call   80102430 <writei>
801028b3:	83 c4 20             	add    $0x20,%esp
801028b6:	83 f8 10             	cmp    $0x10,%eax
801028b9:	75 2a                	jne    801028e5 <dirlink+0xa5>
801028bb:	31 c0                	xor    %eax,%eax
801028bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
801028c0:	5b                   	pop    %ebx
801028c1:	5e                   	pop    %esi
801028c2:	5f                   	pop    %edi
801028c3:	5d                   	pop    %ebp
801028c4:	c3                   	ret
801028c5:	83 ec 0c             	sub    $0xc,%esp
801028c8:	50                   	push   %eax
801028c9:	e8 82 f8 ff ff       	call   80102150 <iput>
801028ce:	83 c4 10             	add    $0x10,%esp
801028d1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801028d6:	eb e5                	jmp    801028bd <dirlink+0x7d>
801028d8:	83 ec 0c             	sub    $0xc,%esp
801028db:	68 57 7b 10 80       	push   $0x80107b57
801028e0:	e8 bb da ff ff       	call   801003a0 <panic>
801028e5:	83 ec 0c             	sub    $0xc,%esp
801028e8:	68 b3 7d 10 80       	push   $0x80107db3
801028ed:	e8 ae da ff ff       	call   801003a0 <panic>
801028f2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801028f9:	00 
801028fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102900 <namei>:
80102900:	55                   	push   %ebp
80102901:	31 d2                	xor    %edx,%edx
80102903:	89 e5                	mov    %esp,%ebp
80102905:	83 ec 18             	sub    $0x18,%esp
80102908:	8b 45 08             	mov    0x8(%ebp),%eax
8010290b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
8010290e:	e8 0d fd ff ff       	call   80102620 <namex>
80102913:	c9                   	leave
80102914:	c3                   	ret
80102915:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010291c:	00 
8010291d:	8d 76 00             	lea    0x0(%esi),%esi

80102920 <nameiparent>:
80102920:	55                   	push   %ebp
80102921:	ba 01 00 00 00       	mov    $0x1,%edx
80102926:	89 e5                	mov    %esp,%ebp
80102928:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010292b:	8b 45 08             	mov    0x8(%ebp),%eax
8010292e:	5d                   	pop    %ebp
8010292f:	e9 ec fc ff ff       	jmp    80102620 <namex>
80102934:	66 90                	xchg   %ax,%ax
80102936:	66 90                	xchg   %ax,%ax
80102938:	66 90                	xchg   %ax,%ax
8010293a:	66 90                	xchg   %ax,%ax
8010293c:	66 90                	xchg   %ax,%ax
8010293e:	66 90                	xchg   %ax,%ax

80102940 <idestart>:
80102940:	55                   	push   %ebp
80102941:	89 e5                	mov    %esp,%ebp
80102943:	57                   	push   %edi
80102944:	56                   	push   %esi
80102945:	53                   	push   %ebx
80102946:	83 ec 0c             	sub    $0xc,%esp
80102949:	85 c0                	test   %eax,%eax
8010294b:	0f 84 b4 00 00 00    	je     80102a05 <idestart+0xc5>
80102951:	8b 70 08             	mov    0x8(%eax),%esi
80102954:	89 c3                	mov    %eax,%ebx
80102956:	81 fe e7 03 00 00    	cmp    $0x3e7,%esi
8010295c:	0f 87 96 00 00 00    	ja     801029f8 <idestart+0xb8>
80102962:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102967:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010296e:	00 
8010296f:	90                   	nop
80102970:	89 ca                	mov    %ecx,%edx
80102972:	ec                   	in     (%dx),%al
80102973:	83 e0 c0             	and    $0xffffffc0,%eax
80102976:	3c 40                	cmp    $0x40,%al
80102978:	75 f6                	jne    80102970 <idestart+0x30>
8010297a:	31 ff                	xor    %edi,%edi
8010297c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80102981:	89 f8                	mov    %edi,%eax
80102983:	ee                   	out    %al,(%dx)
80102984:	b8 01 00 00 00       	mov    $0x1,%eax
80102989:	ba f2 01 00 00       	mov    $0x1f2,%edx
8010298e:	ee                   	out    %al,(%dx)
8010298f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80102994:	89 f0                	mov    %esi,%eax
80102996:	ee                   	out    %al,(%dx)
80102997:	89 f0                	mov    %esi,%eax
80102999:	ba f4 01 00 00       	mov    $0x1f4,%edx
8010299e:	c1 f8 08             	sar    $0x8,%eax
801029a1:	ee                   	out    %al,(%dx)
801029a2:	ba f5 01 00 00       	mov    $0x1f5,%edx
801029a7:	89 f8                	mov    %edi,%eax
801029a9:	ee                   	out    %al,(%dx)
801029aa:	0f b6 43 04          	movzbl 0x4(%ebx),%eax
801029ae:	ba f6 01 00 00       	mov    $0x1f6,%edx
801029b3:	c1 e0 04             	shl    $0x4,%eax
801029b6:	83 e0 10             	and    $0x10,%eax
801029b9:	83 c8 e0             	or     $0xffffffe0,%eax
801029bc:	ee                   	out    %al,(%dx)
801029bd:	f6 03 04             	testb  $0x4,(%ebx)
801029c0:	75 16                	jne    801029d8 <idestart+0x98>
801029c2:	b8 20 00 00 00       	mov    $0x20,%eax
801029c7:	89 ca                	mov    %ecx,%edx
801029c9:	ee                   	out    %al,(%dx)
801029ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801029cd:	5b                   	pop    %ebx
801029ce:	5e                   	pop    %esi
801029cf:	5f                   	pop    %edi
801029d0:	5d                   	pop    %ebp
801029d1:	c3                   	ret
801029d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801029d8:	b8 30 00 00 00       	mov    $0x30,%eax
801029dd:	89 ca                	mov    %ecx,%edx
801029df:	ee                   	out    %al,(%dx)
801029e0:	b9 80 00 00 00       	mov    $0x80,%ecx
801029e5:	8d 73 5c             	lea    0x5c(%ebx),%esi
801029e8:	ba f0 01 00 00       	mov    $0x1f0,%edx
801029ed:	fc                   	cld
801029ee:	f3 6f                	rep outsl %ds:(%esi),(%dx)
801029f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801029f3:	5b                   	pop    %ebx
801029f4:	5e                   	pop    %esi
801029f5:	5f                   	pop    %edi
801029f6:	5d                   	pop    %ebp
801029f7:	c3                   	ret
801029f8:	83 ec 0c             	sub    $0xc,%esp
801029fb:	68 6d 7b 10 80       	push   $0x80107b6d
80102a00:	e8 9b d9 ff ff       	call   801003a0 <panic>
80102a05:	83 ec 0c             	sub    $0xc,%esp
80102a08:	68 64 7b 10 80       	push   $0x80107b64
80102a0d:	e8 8e d9 ff ff       	call   801003a0 <panic>
80102a12:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102a19:	00 
80102a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102a20 <ideinit>:
80102a20:	55                   	push   %ebp
80102a21:	89 e5                	mov    %esp,%ebp
80102a23:	83 ec 10             	sub    $0x10,%esp
80102a26:	68 7f 7b 10 80       	push   $0x80107b7f
80102a2b:	68 40 2d 11 80       	push   $0x80112d40
80102a30:	e8 0b 22 00 00       	call   80104c40 <initlock>
80102a35:	58                   	pop    %eax
80102a36:	a1 c4 2e 11 80       	mov    0x80112ec4,%eax
80102a3b:	5a                   	pop    %edx
80102a3c:	83 e8 01             	sub    $0x1,%eax
80102a3f:	50                   	push   %eax
80102a40:	6a 0e                	push   $0xe
80102a42:	e8 99 02 00 00       	call   80102ce0 <ioapicenable>
80102a47:	83 c4 10             	add    $0x10,%esp
80102a4a:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80102a4f:	90                   	nop
80102a50:	89 ca                	mov    %ecx,%edx
80102a52:	ec                   	in     (%dx),%al
80102a53:	83 e0 c0             	and    $0xffffffc0,%eax
80102a56:	3c 40                	cmp    $0x40,%al
80102a58:	75 f6                	jne    80102a50 <ideinit+0x30>
80102a5a:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
80102a5f:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102a64:	ee                   	out    %al,(%dx)
80102a65:	89 ca                	mov    %ecx,%edx
80102a67:	ec                   	in     (%dx),%al
80102a68:	84 c0                	test   %al,%al
80102a6a:	75 1e                	jne    80102a8a <ideinit+0x6a>
80102a6c:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
80102a71:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102a76:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102a7d:	00 
80102a7e:	66 90                	xchg   %ax,%ax
80102a80:	83 e9 01             	sub    $0x1,%ecx
80102a83:	74 0f                	je     80102a94 <ideinit+0x74>
80102a85:	ec                   	in     (%dx),%al
80102a86:	84 c0                	test   %al,%al
80102a88:	74 f6                	je     80102a80 <ideinit+0x60>
80102a8a:	c7 05 20 2d 11 80 01 	movl   $0x1,0x80112d20
80102a91:	00 00 00 
80102a94:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102a99:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102a9e:	ee                   	out    %al,(%dx)
80102a9f:	c9                   	leave
80102aa0:	c3                   	ret
80102aa1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102aa8:	00 
80102aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102ab0 <ideintr>:
80102ab0:	55                   	push   %ebp
80102ab1:	89 e5                	mov    %esp,%ebp
80102ab3:	57                   	push   %edi
80102ab4:	56                   	push   %esi
80102ab5:	53                   	push   %ebx
80102ab6:	83 ec 18             	sub    $0x18,%esp
80102ab9:	68 40 2d 11 80       	push   $0x80112d40
80102abe:	e8 6d 23 00 00       	call   80104e30 <acquire>
80102ac3:	8b 1d 24 2d 11 80    	mov    0x80112d24,%ebx
80102ac9:	83 c4 10             	add    $0x10,%esp
80102acc:	85 db                	test   %ebx,%ebx
80102ace:	74 63                	je     80102b33 <ideintr+0x83>
80102ad0:	8b 43 58             	mov    0x58(%ebx),%eax
80102ad3:	a3 24 2d 11 80       	mov    %eax,0x80112d24
80102ad8:	8b 33                	mov    (%ebx),%esi
80102ada:	f7 c6 04 00 00 00    	test   $0x4,%esi
80102ae0:	75 2f                	jne    80102b11 <ideintr+0x61>
80102ae2:	ba f7 01 00 00       	mov    $0x1f7,%edx
80102ae7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102aee:	00 
80102aef:	90                   	nop
80102af0:	ec                   	in     (%dx),%al
80102af1:	89 c1                	mov    %eax,%ecx
80102af3:	83 e1 c0             	and    $0xffffffc0,%ecx
80102af6:	80 f9 40             	cmp    $0x40,%cl
80102af9:	75 f5                	jne    80102af0 <ideintr+0x40>
80102afb:	a8 21                	test   $0x21,%al
80102afd:	75 12                	jne    80102b11 <ideintr+0x61>
80102aff:	8d 7b 5c             	lea    0x5c(%ebx),%edi
80102b02:	b9 80 00 00 00       	mov    $0x80,%ecx
80102b07:	ba f0 01 00 00       	mov    $0x1f0,%edx
80102b0c:	fc                   	cld
80102b0d:	f3 6d                	rep insl (%dx),%es:(%edi)
80102b0f:	8b 33                	mov    (%ebx),%esi
80102b11:	83 e6 fb             	and    $0xfffffffb,%esi
80102b14:	83 ec 0c             	sub    $0xc,%esp
80102b17:	83 ce 02             	or     $0x2,%esi
80102b1a:	89 33                	mov    %esi,(%ebx)
80102b1c:	53                   	push   %ebx
80102b1d:	e8 4e 1e 00 00       	call   80104970 <wakeup>
80102b22:	a1 24 2d 11 80       	mov    0x80112d24,%eax
80102b27:	83 c4 10             	add    $0x10,%esp
80102b2a:	85 c0                	test   %eax,%eax
80102b2c:	74 05                	je     80102b33 <ideintr+0x83>
80102b2e:	e8 0d fe ff ff       	call   80102940 <idestart>
80102b33:	83 ec 0c             	sub    $0xc,%esp
80102b36:	68 40 2d 11 80       	push   $0x80112d40
80102b3b:	e8 90 22 00 00       	call   80104dd0 <release>
80102b40:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102b43:	5b                   	pop    %ebx
80102b44:	5e                   	pop    %esi
80102b45:	5f                   	pop    %edi
80102b46:	5d                   	pop    %ebp
80102b47:	c3                   	ret
80102b48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102b4f:	00 

80102b50 <iderw>:
80102b50:	55                   	push   %ebp
80102b51:	89 e5                	mov    %esp,%ebp
80102b53:	53                   	push   %ebx
80102b54:	83 ec 10             	sub    $0x10,%esp
80102b57:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102b5a:	8d 43 0c             	lea    0xc(%ebx),%eax
80102b5d:	50                   	push   %eax
80102b5e:	e8 8d 20 00 00       	call   80104bf0 <holdingsleep>
80102b63:	83 c4 10             	add    $0x10,%esp
80102b66:	85 c0                	test   %eax,%eax
80102b68:	0f 84 c3 00 00 00    	je     80102c31 <iderw+0xe1>
80102b6e:	8b 03                	mov    (%ebx),%eax
80102b70:	83 e0 06             	and    $0x6,%eax
80102b73:	83 f8 02             	cmp    $0x2,%eax
80102b76:	0f 84 a8 00 00 00    	je     80102c24 <iderw+0xd4>
80102b7c:	8b 53 04             	mov    0x4(%ebx),%edx
80102b7f:	85 d2                	test   %edx,%edx
80102b81:	74 0d                	je     80102b90 <iderw+0x40>
80102b83:	a1 20 2d 11 80       	mov    0x80112d20,%eax
80102b88:	85 c0                	test   %eax,%eax
80102b8a:	0f 84 87 00 00 00    	je     80102c17 <iderw+0xc7>
80102b90:	83 ec 0c             	sub    $0xc,%esp
80102b93:	68 40 2d 11 80       	push   $0x80112d40
80102b98:	e8 93 22 00 00       	call   80104e30 <acquire>
80102b9d:	a1 24 2d 11 80       	mov    0x80112d24,%eax
80102ba2:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
80102ba9:	83 c4 10             	add    $0x10,%esp
80102bac:	85 c0                	test   %eax,%eax
80102bae:	74 60                	je     80102c10 <iderw+0xc0>
80102bb0:	89 c2                	mov    %eax,%edx
80102bb2:	8b 40 58             	mov    0x58(%eax),%eax
80102bb5:	85 c0                	test   %eax,%eax
80102bb7:	75 f7                	jne    80102bb0 <iderw+0x60>
80102bb9:	83 c2 58             	add    $0x58,%edx
80102bbc:	89 1a                	mov    %ebx,(%edx)
80102bbe:	39 1d 24 2d 11 80    	cmp    %ebx,0x80112d24
80102bc4:	74 3a                	je     80102c00 <iderw+0xb0>
80102bc6:	8b 03                	mov    (%ebx),%eax
80102bc8:	83 e0 06             	and    $0x6,%eax
80102bcb:	83 f8 02             	cmp    $0x2,%eax
80102bce:	74 1b                	je     80102beb <iderw+0x9b>
80102bd0:	83 ec 08             	sub    $0x8,%esp
80102bd3:	68 40 2d 11 80       	push   $0x80112d40
80102bd8:	53                   	push   %ebx
80102bd9:	e8 d2 1c 00 00       	call   801048b0 <sleep>
80102bde:	8b 03                	mov    (%ebx),%eax
80102be0:	83 c4 10             	add    $0x10,%esp
80102be3:	83 e0 06             	and    $0x6,%eax
80102be6:	83 f8 02             	cmp    $0x2,%eax
80102be9:	75 e5                	jne    80102bd0 <iderw+0x80>
80102beb:	c7 45 08 40 2d 11 80 	movl   $0x80112d40,0x8(%ebp)
80102bf2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bf5:	c9                   	leave
80102bf6:	e9 d5 21 00 00       	jmp    80104dd0 <release>
80102bfb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102c00:	89 d8                	mov    %ebx,%eax
80102c02:	e8 39 fd ff ff       	call   80102940 <idestart>
80102c07:	eb bd                	jmp    80102bc6 <iderw+0x76>
80102c09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102c10:	ba 24 2d 11 80       	mov    $0x80112d24,%edx
80102c15:	eb a5                	jmp    80102bbc <iderw+0x6c>
80102c17:	83 ec 0c             	sub    $0xc,%esp
80102c1a:	68 ae 7b 10 80       	push   $0x80107bae
80102c1f:	e8 7c d7 ff ff       	call   801003a0 <panic>
80102c24:	83 ec 0c             	sub    $0xc,%esp
80102c27:	68 99 7b 10 80       	push   $0x80107b99
80102c2c:	e8 6f d7 ff ff       	call   801003a0 <panic>
80102c31:	83 ec 0c             	sub    $0xc,%esp
80102c34:	68 83 7b 10 80       	push   $0x80107b83
80102c39:	e8 62 d7 ff ff       	call   801003a0 <panic>
80102c3e:	66 90                	xchg   %ax,%ax

80102c40 <ioapicinit>:
80102c40:	55                   	push   %ebp
80102c41:	89 e5                	mov    %esp,%ebp
80102c43:	56                   	push   %esi
80102c44:	53                   	push   %ebx
80102c45:	c7 05 74 2d 11 80 00 	movl   $0xfec00000,0x80112d74
80102c4c:	00 c0 fe 
80102c4f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102c56:	00 00 00 
80102c59:	8b 15 74 2d 11 80    	mov    0x80112d74,%edx
80102c5f:	8b 72 10             	mov    0x10(%edx),%esi
80102c62:	c7 02 00 00 00 00    	movl   $0x0,(%edx)
80102c68:	8b 1d 74 2d 11 80    	mov    0x80112d74,%ebx
80102c6e:	0f b6 15 c0 2e 11 80 	movzbl 0x80112ec0,%edx
80102c75:	c1 ee 10             	shr    $0x10,%esi
80102c78:	89 f0                	mov    %esi,%eax
80102c7a:	0f b6 f0             	movzbl %al,%esi
80102c7d:	8b 43 10             	mov    0x10(%ebx),%eax
80102c80:	c1 e8 18             	shr    $0x18,%eax
80102c83:	39 c2                	cmp    %eax,%edx
80102c85:	74 16                	je     80102c9d <ioapicinit+0x5d>
80102c87:	83 ec 0c             	sub    $0xc,%esp
80102c8a:	68 b8 7f 10 80       	push   $0x80107fb8
80102c8f:	e8 ac df ff ff       	call   80100c40 <cprintf>
80102c94:	8b 1d 74 2d 11 80    	mov    0x80112d74,%ebx
80102c9a:	83 c4 10             	add    $0x10,%esp
80102c9d:	ba 10 00 00 00       	mov    $0x10,%edx
80102ca2:	31 c0                	xor    %eax,%eax
80102ca4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102ca8:	89 13                	mov    %edx,(%ebx)
80102caa:	8d 48 20             	lea    0x20(%eax),%ecx
80102cad:	8b 1d 74 2d 11 80    	mov    0x80112d74,%ebx
80102cb3:	83 c0 01             	add    $0x1,%eax
80102cb6:	81 c9 00 00 01 00    	or     $0x10000,%ecx
80102cbc:	89 4b 10             	mov    %ecx,0x10(%ebx)
80102cbf:	8d 4a 01             	lea    0x1(%edx),%ecx
80102cc2:	83 c2 02             	add    $0x2,%edx
80102cc5:	89 0b                	mov    %ecx,(%ebx)
80102cc7:	8b 1d 74 2d 11 80    	mov    0x80112d74,%ebx
80102ccd:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
80102cd4:	39 c6                	cmp    %eax,%esi
80102cd6:	7d d0                	jge    80102ca8 <ioapicinit+0x68>
80102cd8:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102cdb:	5b                   	pop    %ebx
80102cdc:	5e                   	pop    %esi
80102cdd:	5d                   	pop    %ebp
80102cde:	c3                   	ret
80102cdf:	90                   	nop

80102ce0 <ioapicenable>:
80102ce0:	55                   	push   %ebp
80102ce1:	8b 0d 74 2d 11 80    	mov    0x80112d74,%ecx
80102ce7:	89 e5                	mov    %esp,%ebp
80102ce9:	8b 45 08             	mov    0x8(%ebp),%eax
80102cec:	8d 50 20             	lea    0x20(%eax),%edx
80102cef:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
80102cf3:	89 01                	mov    %eax,(%ecx)
80102cf5:	8b 0d 74 2d 11 80    	mov    0x80112d74,%ecx
80102cfb:	83 c0 01             	add    $0x1,%eax
80102cfe:	89 51 10             	mov    %edx,0x10(%ecx)
80102d01:	8b 55 0c             	mov    0xc(%ebp),%edx
80102d04:	89 01                	mov    %eax,(%ecx)
80102d06:	a1 74 2d 11 80       	mov    0x80112d74,%eax
80102d0b:	c1 e2 18             	shl    $0x18,%edx
80102d0e:	89 50 10             	mov    %edx,0x10(%eax)
80102d11:	5d                   	pop    %ebp
80102d12:	c3                   	ret
80102d13:	66 90                	xchg   %ax,%ax
80102d15:	66 90                	xchg   %ax,%ax
80102d17:	66 90                	xchg   %ax,%ax
80102d19:	66 90                	xchg   %ax,%ax
80102d1b:	66 90                	xchg   %ax,%ax
80102d1d:	66 90                	xchg   %ax,%ax
80102d1f:	90                   	nop

80102d20 <kfree>:
80102d20:	55                   	push   %ebp
80102d21:	89 e5                	mov    %esp,%ebp
80102d23:	53                   	push   %ebx
80102d24:	83 ec 04             	sub    $0x4,%esp
80102d27:	8b 5d 08             	mov    0x8(%ebp),%ebx
80102d2a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102d30:	75 76                	jne    80102da8 <kfree+0x88>
80102d32:	81 fb 10 6c 11 80    	cmp    $0x80116c10,%ebx
80102d38:	72 6e                	jb     80102da8 <kfree+0x88>
80102d3a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102d40:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102d45:	77 61                	ja     80102da8 <kfree+0x88>
80102d47:	83 ec 04             	sub    $0x4,%esp
80102d4a:	68 00 10 00 00       	push   $0x1000
80102d4f:	6a 01                	push   $0x1
80102d51:	53                   	push   %ebx
80102d52:	e8 d9 21 00 00       	call   80104f30 <memset>
80102d57:	8b 15 b4 2d 11 80    	mov    0x80112db4,%edx
80102d5d:	83 c4 10             	add    $0x10,%esp
80102d60:	85 d2                	test   %edx,%edx
80102d62:	75 1c                	jne    80102d80 <kfree+0x60>
80102d64:	a1 b8 2d 11 80       	mov    0x80112db8,%eax
80102d69:	89 03                	mov    %eax,(%ebx)
80102d6b:	a1 b4 2d 11 80       	mov    0x80112db4,%eax
80102d70:	89 1d b8 2d 11 80    	mov    %ebx,0x80112db8
80102d76:	85 c0                	test   %eax,%eax
80102d78:	75 1e                	jne    80102d98 <kfree+0x78>
80102d7a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102d7d:	c9                   	leave
80102d7e:	c3                   	ret
80102d7f:	90                   	nop
80102d80:	83 ec 0c             	sub    $0xc,%esp
80102d83:	68 80 2d 11 80       	push   $0x80112d80
80102d88:	e8 a3 20 00 00       	call   80104e30 <acquire>
80102d8d:	83 c4 10             	add    $0x10,%esp
80102d90:	eb d2                	jmp    80102d64 <kfree+0x44>
80102d92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102d98:	c7 45 08 80 2d 11 80 	movl   $0x80112d80,0x8(%ebp)
80102d9f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102da2:	c9                   	leave
80102da3:	e9 28 20 00 00       	jmp    80104dd0 <release>
80102da8:	83 ec 0c             	sub    $0xc,%esp
80102dab:	68 cc 7b 10 80       	push   $0x80107bcc
80102db0:	e8 eb d5 ff ff       	call   801003a0 <panic>
80102db5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102dbc:	00 
80102dbd:	8d 76 00             	lea    0x0(%esi),%esi

80102dc0 <freerange>:
80102dc0:	55                   	push   %ebp
80102dc1:	89 e5                	mov    %esp,%ebp
80102dc3:	56                   	push   %esi
80102dc4:	53                   	push   %ebx
80102dc5:	8b 45 08             	mov    0x8(%ebp),%eax
80102dc8:	8b 75 0c             	mov    0xc(%ebp),%esi
80102dcb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102dd1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80102dd7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102ddd:	39 de                	cmp    %ebx,%esi
80102ddf:	72 23                	jb     80102e04 <freerange+0x44>
80102de1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102de8:	83 ec 0c             	sub    $0xc,%esp
80102deb:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102df1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102df7:	50                   	push   %eax
80102df8:	e8 23 ff ff ff       	call   80102d20 <kfree>
80102dfd:	83 c4 10             	add    $0x10,%esp
80102e00:	39 de                	cmp    %ebx,%esi
80102e02:	73 e4                	jae    80102de8 <freerange+0x28>
80102e04:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102e07:	5b                   	pop    %ebx
80102e08:	5e                   	pop    %esi
80102e09:	5d                   	pop    %ebp
80102e0a:	c3                   	ret
80102e0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102e10 <kinit2>:
80102e10:	55                   	push   %ebp
80102e11:	89 e5                	mov    %esp,%ebp
80102e13:	56                   	push   %esi
80102e14:	53                   	push   %ebx
80102e15:	8b 45 08             	mov    0x8(%ebp),%eax
80102e18:	8b 75 0c             	mov    0xc(%ebp),%esi
80102e1b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102e21:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80102e27:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102e2d:	39 de                	cmp    %ebx,%esi
80102e2f:	72 23                	jb     80102e54 <kinit2+0x44>
80102e31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e38:	83 ec 0c             	sub    $0xc,%esp
80102e3b:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102e41:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102e47:	50                   	push   %eax
80102e48:	e8 d3 fe ff ff       	call   80102d20 <kfree>
80102e4d:	83 c4 10             	add    $0x10,%esp
80102e50:	39 de                	cmp    %ebx,%esi
80102e52:	73 e4                	jae    80102e38 <kinit2+0x28>
80102e54:	c7 05 b4 2d 11 80 01 	movl   $0x1,0x80112db4
80102e5b:	00 00 00 
80102e5e:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102e61:	5b                   	pop    %ebx
80102e62:	5e                   	pop    %esi
80102e63:	5d                   	pop    %ebp
80102e64:	c3                   	ret
80102e65:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102e6c:	00 
80102e6d:	8d 76 00             	lea    0x0(%esi),%esi

80102e70 <kinit1>:
80102e70:	55                   	push   %ebp
80102e71:	89 e5                	mov    %esp,%ebp
80102e73:	56                   	push   %esi
80102e74:	53                   	push   %ebx
80102e75:	8b 75 0c             	mov    0xc(%ebp),%esi
80102e78:	83 ec 08             	sub    $0x8,%esp
80102e7b:	68 d2 7b 10 80       	push   $0x80107bd2
80102e80:	68 80 2d 11 80       	push   $0x80112d80
80102e85:	e8 b6 1d 00 00       	call   80104c40 <initlock>
80102e8a:	8b 45 08             	mov    0x8(%ebp),%eax
80102e8d:	83 c4 10             	add    $0x10,%esp
80102e90:	c7 05 b4 2d 11 80 00 	movl   $0x0,0x80112db4
80102e97:	00 00 00 
80102e9a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102ea0:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80102ea6:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102eac:	39 de                	cmp    %ebx,%esi
80102eae:	72 1c                	jb     80102ecc <kinit1+0x5c>
80102eb0:	83 ec 0c             	sub    $0xc,%esp
80102eb3:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102eb9:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80102ebf:	50                   	push   %eax
80102ec0:	e8 5b fe ff ff       	call   80102d20 <kfree>
80102ec5:	83 c4 10             	add    $0x10,%esp
80102ec8:	39 de                	cmp    %ebx,%esi
80102eca:	73 e4                	jae    80102eb0 <kinit1+0x40>
80102ecc:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102ecf:	5b                   	pop    %ebx
80102ed0:	5e                   	pop    %esi
80102ed1:	5d                   	pop    %ebp
80102ed2:	c3                   	ret
80102ed3:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102eda:	00 
80102edb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80102ee0 <kalloc>:
80102ee0:	55                   	push   %ebp
80102ee1:	89 e5                	mov    %esp,%ebp
80102ee3:	53                   	push   %ebx
80102ee4:	83 ec 04             	sub    $0x4,%esp
80102ee7:	a1 b4 2d 11 80       	mov    0x80112db4,%eax
80102eec:	85 c0                	test   %eax,%eax
80102eee:	75 20                	jne    80102f10 <kalloc+0x30>
80102ef0:	8b 1d b8 2d 11 80    	mov    0x80112db8,%ebx
80102ef6:	85 db                	test   %ebx,%ebx
80102ef8:	74 07                	je     80102f01 <kalloc+0x21>
80102efa:	8b 03                	mov    (%ebx),%eax
80102efc:	a3 b8 2d 11 80       	mov    %eax,0x80112db8
80102f01:	89 d8                	mov    %ebx,%eax
80102f03:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f06:	c9                   	leave
80102f07:	c3                   	ret
80102f08:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80102f0f:	00 
80102f10:	83 ec 0c             	sub    $0xc,%esp
80102f13:	68 80 2d 11 80       	push   $0x80112d80
80102f18:	e8 13 1f 00 00       	call   80104e30 <acquire>
80102f1d:	8b 1d b8 2d 11 80    	mov    0x80112db8,%ebx
80102f23:	a1 b4 2d 11 80       	mov    0x80112db4,%eax
80102f28:	83 c4 10             	add    $0x10,%esp
80102f2b:	85 db                	test   %ebx,%ebx
80102f2d:	74 08                	je     80102f37 <kalloc+0x57>
80102f2f:	8b 13                	mov    (%ebx),%edx
80102f31:	89 15 b8 2d 11 80    	mov    %edx,0x80112db8
80102f37:	85 c0                	test   %eax,%eax
80102f39:	74 c6                	je     80102f01 <kalloc+0x21>
80102f3b:	83 ec 0c             	sub    $0xc,%esp
80102f3e:	68 80 2d 11 80       	push   $0x80112d80
80102f43:	e8 88 1e 00 00       	call   80104dd0 <release>
80102f48:	89 d8                	mov    %ebx,%eax
80102f4a:	83 c4 10             	add    $0x10,%esp
80102f4d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102f50:	c9                   	leave
80102f51:	c3                   	ret
80102f52:	66 90                	xchg   %ax,%ax
80102f54:	66 90                	xchg   %ax,%ax
80102f56:	66 90                	xchg   %ax,%ax
80102f58:	66 90                	xchg   %ax,%ax
80102f5a:	66 90                	xchg   %ax,%ax
80102f5c:	66 90                	xchg   %ax,%ax
80102f5e:	66 90                	xchg   %ax,%ax

80102f60 <kbdgetc>:
80102f60:	ba 64 00 00 00       	mov    $0x64,%edx
80102f65:	ec                   	in     (%dx),%al
80102f66:	a8 01                	test   $0x1,%al
80102f68:	0f 84 d2 00 00 00    	je     80103040 <kbdgetc+0xe0>
80102f6e:	55                   	push   %ebp
80102f6f:	ba 60 00 00 00       	mov    $0x60,%edx
80102f74:	89 e5                	mov    %esp,%ebp
80102f76:	53                   	push   %ebx
80102f77:	ec                   	in     (%dx),%al
80102f78:	8b 1d bc 2d 11 80    	mov    0x80112dbc,%ebx
80102f7e:	0f b6 c8             	movzbl %al,%ecx
80102f81:	3c e0                	cmp    $0xe0,%al
80102f83:	74 5b                	je     80102fe0 <kbdgetc+0x80>
80102f85:	89 da                	mov    %ebx,%edx
80102f87:	83 e2 40             	and    $0x40,%edx
80102f8a:	84 c0                	test   %al,%al
80102f8c:	78 62                	js     80102ff0 <kbdgetc+0x90>
80102f8e:	85 d2                	test   %edx,%edx
80102f90:	74 0c                	je     80102f9e <kbdgetc+0x3e>
80102f92:	83 f9 4b             	cmp    $0x4b,%ecx
80102f95:	0f 84 95 00 00 00    	je     80103030 <kbdgetc+0xd0>
80102f9b:	83 e3 bf             	and    $0xffffffbf,%ebx
80102f9e:	0f b6 91 20 82 10 80 	movzbl -0x7fef7de0(%ecx),%edx
80102fa5:	0f b6 81 20 81 10 80 	movzbl -0x7fef7ee0(%ecx),%eax
80102fac:	09 da                	or     %ebx,%edx
80102fae:	31 c2                	xor    %eax,%edx
80102fb0:	89 d0                	mov    %edx,%eax
80102fb2:	89 15 bc 2d 11 80    	mov    %edx,0x80112dbc
80102fb8:	83 e0 03             	and    $0x3,%eax
80102fbb:	83 e2 08             	and    $0x8,%edx
80102fbe:	8b 04 85 00 81 10 80 	mov    -0x7fef7f00(,%eax,4),%eax
80102fc5:	0f b6 04 08          	movzbl (%eax,%ecx,1),%eax
80102fc9:	74 0b                	je     80102fd6 <kbdgetc+0x76>
80102fcb:	8d 50 9f             	lea    -0x61(%eax),%edx
80102fce:	83 fa 19             	cmp    $0x19,%edx
80102fd1:	77 45                	ja     80103018 <kbdgetc+0xb8>
80102fd3:	83 e8 20             	sub    $0x20,%eax
80102fd6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102fd9:	c9                   	leave
80102fda:	c3                   	ret
80102fdb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80102fe0:	83 cb 40             	or     $0x40,%ebx
80102fe3:	31 c0                	xor    %eax,%eax
80102fe5:	89 1d bc 2d 11 80    	mov    %ebx,0x80112dbc
80102feb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102fee:	c9                   	leave
80102fef:	c3                   	ret
80102ff0:	83 e0 7f             	and    $0x7f,%eax
80102ff3:	85 d2                	test   %edx,%edx
80102ff5:	0f 44 c8             	cmove  %eax,%ecx
80102ff8:	0f b6 81 20 82 10 80 	movzbl -0x7fef7de0(%ecx),%eax
80102fff:	83 c8 40             	or     $0x40,%eax
80103002:	0f b6 c0             	movzbl %al,%eax
80103005:	f7 d0                	not    %eax
80103007:	21 d8                	and    %ebx,%eax
80103009:	a3 bc 2d 11 80       	mov    %eax,0x80112dbc
8010300e:	31 c0                	xor    %eax,%eax
80103010:	eb d9                	jmp    80102feb <kbdgetc+0x8b>
80103012:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103018:	8d 48 bf             	lea    -0x41(%eax),%ecx
8010301b:	8d 50 20             	lea    0x20(%eax),%edx
8010301e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103021:	c9                   	leave
80103022:	83 f9 1a             	cmp    $0x1a,%ecx
80103025:	0f 42 c2             	cmovb  %edx,%eax
80103028:	c3                   	ret
80103029:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103030:	b8 4b e0 00 00       	mov    $0xe04b,%eax
80103035:	eb 9f                	jmp    80102fd6 <kbdgetc+0x76>
80103037:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010303e:	00 
8010303f:	90                   	nop
80103040:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103045:	c3                   	ret
80103046:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010304d:	00 
8010304e:	66 90                	xchg   %ax,%ax

80103050 <kbdintr>:
80103050:	55                   	push   %ebp
80103051:	89 e5                	mov    %esp,%ebp
80103053:	83 ec 14             	sub    $0x14,%esp
80103056:	68 60 2f 10 80       	push   $0x80102f60
8010305b:	e8 10 df ff ff       	call   80100f70 <consoleintr>
80103060:	83 c4 10             	add    $0x10,%esp
80103063:	c9                   	leave
80103064:	c3                   	ret
80103065:	66 90                	xchg   %ax,%ax
80103067:	66 90                	xchg   %ax,%ax
80103069:	66 90                	xchg   %ax,%ax
8010306b:	66 90                	xchg   %ax,%ax
8010306d:	66 90                	xchg   %ax,%ax
8010306f:	90                   	nop

80103070 <lapicinit>:
80103070:	a1 c0 2d 11 80       	mov    0x80112dc0,%eax
80103075:	85 c0                	test   %eax,%eax
80103077:	0f 84 c3 00 00 00    	je     80103140 <lapicinit+0xd0>
8010307d:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80103084:	01 00 00 
80103087:	8b 50 20             	mov    0x20(%eax),%edx
8010308a:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80103091:	00 00 00 
80103094:	8b 50 20             	mov    0x20(%eax),%edx
80103097:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
8010309e:	00 02 00 
801030a1:	8b 50 20             	mov    0x20(%eax),%edx
801030a4:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
801030ab:	96 98 00 
801030ae:	8b 50 20             	mov    0x20(%eax),%edx
801030b1:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
801030b8:	00 01 00 
801030bb:	8b 50 20             	mov    0x20(%eax),%edx
801030be:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801030c5:	00 01 00 
801030c8:	8b 50 20             	mov    0x20(%eax),%edx
801030cb:	8b 50 30             	mov    0x30(%eax),%edx
801030ce:	81 e2 00 00 fc 00    	and    $0xfc0000,%edx
801030d4:	75 72                	jne    80103148 <lapicinit+0xd8>
801030d6:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801030dd:	00 00 00 
801030e0:	8b 50 20             	mov    0x20(%eax),%edx
801030e3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801030ea:	00 00 00 
801030ed:	8b 50 20             	mov    0x20(%eax),%edx
801030f0:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801030f7:	00 00 00 
801030fa:	8b 50 20             	mov    0x20(%eax),%edx
801030fd:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103104:	00 00 00 
80103107:	8b 50 20             	mov    0x20(%eax),%edx
8010310a:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
80103111:	00 00 00 
80103114:	8b 50 20             	mov    0x20(%eax),%edx
80103117:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
8010311e:	85 08 00 
80103121:	8b 50 20             	mov    0x20(%eax),%edx
80103124:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103128:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
8010312e:	80 e6 10             	and    $0x10,%dh
80103131:	75 f5                	jne    80103128 <lapicinit+0xb8>
80103133:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
8010313a:	00 00 00 
8010313d:	8b 40 20             	mov    0x20(%eax),%eax
80103140:	c3                   	ret
80103141:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103148:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
8010314f:	00 01 00 
80103152:	8b 50 20             	mov    0x20(%eax),%edx
80103155:	e9 7c ff ff ff       	jmp    801030d6 <lapicinit+0x66>
8010315a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103160 <lapicid>:
80103160:	a1 c0 2d 11 80       	mov    0x80112dc0,%eax
80103165:	85 c0                	test   %eax,%eax
80103167:	74 07                	je     80103170 <lapicid+0x10>
80103169:	8b 40 20             	mov    0x20(%eax),%eax
8010316c:	c1 e8 18             	shr    $0x18,%eax
8010316f:	c3                   	ret
80103170:	31 c0                	xor    %eax,%eax
80103172:	c3                   	ret
80103173:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010317a:	00 
8010317b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103180 <lapiceoi>:
80103180:	a1 c0 2d 11 80       	mov    0x80112dc0,%eax
80103185:	85 c0                	test   %eax,%eax
80103187:	74 0d                	je     80103196 <lapiceoi+0x16>
80103189:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80103190:	00 00 00 
80103193:	8b 40 20             	mov    0x20(%eax),%eax
80103196:	c3                   	ret
80103197:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010319e:	00 
8010319f:	90                   	nop

801031a0 <microdelay>:
801031a0:	c3                   	ret
801031a1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801031a8:	00 
801031a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801031b0 <lapicstartap>:
801031b0:	55                   	push   %ebp
801031b1:	b8 0f 00 00 00       	mov    $0xf,%eax
801031b6:	ba 70 00 00 00       	mov    $0x70,%edx
801031bb:	89 e5                	mov    %esp,%ebp
801031bd:	53                   	push   %ebx
801031be:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801031c1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801031c4:	ee                   	out    %al,(%dx)
801031c5:	b8 0a 00 00 00       	mov    $0xa,%eax
801031ca:	ba 71 00 00 00       	mov    $0x71,%edx
801031cf:	ee                   	out    %al,(%dx)
801031d0:	31 c0                	xor    %eax,%eax
801031d2:	c1 e3 18             	shl    $0x18,%ebx
801031d5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
801031db:	89 c8                	mov    %ecx,%eax
801031dd:	c1 e9 0c             	shr    $0xc,%ecx
801031e0:	89 da                	mov    %ebx,%edx
801031e2:	c1 e8 04             	shr    $0x4,%eax
801031e5:	80 cd 06             	or     $0x6,%ch
801031e8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
801031ee:	a1 c0 2d 11 80       	mov    0x80112dc0,%eax
801031f3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
801031f9:	8b 58 20             	mov    0x20(%eax),%ebx
801031fc:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
80103203:	c5 00 00 
80103206:	8b 58 20             	mov    0x20(%eax),%ebx
80103209:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80103210:	85 00 00 
80103213:	8b 58 20             	mov    0x20(%eax),%ebx
80103216:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
8010321c:	8b 58 20             	mov    0x20(%eax),%ebx
8010321f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
80103225:	8b 58 20             	mov    0x20(%eax),%ebx
80103228:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
8010322e:	8b 50 20             	mov    0x20(%eax),%edx
80103231:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
80103237:	8b 40 20             	mov    0x20(%eax),%eax
8010323a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010323d:	c9                   	leave
8010323e:	c3                   	ret
8010323f:	90                   	nop

80103240 <cmostime>:
80103240:	55                   	push   %ebp
80103241:	b8 0b 00 00 00       	mov    $0xb,%eax
80103246:	ba 70 00 00 00       	mov    $0x70,%edx
8010324b:	89 e5                	mov    %esp,%ebp
8010324d:	57                   	push   %edi
8010324e:	56                   	push   %esi
8010324f:	53                   	push   %ebx
80103250:	83 ec 4c             	sub    $0x4c,%esp
80103253:	ee                   	out    %al,(%dx)
80103254:	ba 71 00 00 00       	mov    $0x71,%edx
80103259:	ec                   	in     (%dx),%al
8010325a:	83 e0 04             	and    $0x4,%eax
8010325d:	bf 70 00 00 00       	mov    $0x70,%edi
80103262:	88 45 b3             	mov    %al,-0x4d(%ebp)
80103265:	8d 76 00             	lea    0x0(%esi),%esi
80103268:	31 c0                	xor    %eax,%eax
8010326a:	89 fa                	mov    %edi,%edx
8010326c:	ee                   	out    %al,(%dx)
8010326d:	b9 71 00 00 00       	mov    $0x71,%ecx
80103272:	89 ca                	mov    %ecx,%edx
80103274:	ec                   	in     (%dx),%al
80103275:	88 45 b7             	mov    %al,-0x49(%ebp)
80103278:	89 fa                	mov    %edi,%edx
8010327a:	b8 02 00 00 00       	mov    $0x2,%eax
8010327f:	ee                   	out    %al,(%dx)
80103280:	89 ca                	mov    %ecx,%edx
80103282:	ec                   	in     (%dx),%al
80103283:	88 45 b6             	mov    %al,-0x4a(%ebp)
80103286:	89 fa                	mov    %edi,%edx
80103288:	b8 04 00 00 00       	mov    $0x4,%eax
8010328d:	ee                   	out    %al,(%dx)
8010328e:	89 ca                	mov    %ecx,%edx
80103290:	ec                   	in     (%dx),%al
80103291:	88 45 b5             	mov    %al,-0x4b(%ebp)
80103294:	89 fa                	mov    %edi,%edx
80103296:	b8 07 00 00 00       	mov    $0x7,%eax
8010329b:	ee                   	out    %al,(%dx)
8010329c:	89 ca                	mov    %ecx,%edx
8010329e:	ec                   	in     (%dx),%al
8010329f:	88 45 b4             	mov    %al,-0x4c(%ebp)
801032a2:	89 fa                	mov    %edi,%edx
801032a4:	b8 08 00 00 00       	mov    $0x8,%eax
801032a9:	ee                   	out    %al,(%dx)
801032aa:	89 ca                	mov    %ecx,%edx
801032ac:	ec                   	in     (%dx),%al
801032ad:	89 c6                	mov    %eax,%esi
801032af:	89 fa                	mov    %edi,%edx
801032b1:	b8 09 00 00 00       	mov    $0x9,%eax
801032b6:	ee                   	out    %al,(%dx)
801032b7:	89 ca                	mov    %ecx,%edx
801032b9:	ec                   	in     (%dx),%al
801032ba:	0f b6 d8             	movzbl %al,%ebx
801032bd:	89 fa                	mov    %edi,%edx
801032bf:	b8 0a 00 00 00       	mov    $0xa,%eax
801032c4:	ee                   	out    %al,(%dx)
801032c5:	89 ca                	mov    %ecx,%edx
801032c7:	ec                   	in     (%dx),%al
801032c8:	84 c0                	test   %al,%al
801032ca:	78 9c                	js     80103268 <cmostime+0x28>
801032cc:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
801032d0:	89 f2                	mov    %esi,%edx
801032d2:	89 5d cc             	mov    %ebx,-0x34(%ebp)
801032d5:	0f b6 f2             	movzbl %dl,%esi
801032d8:	89 fa                	mov    %edi,%edx
801032da:	89 45 b8             	mov    %eax,-0x48(%ebp)
801032dd:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
801032e1:	89 75 c8             	mov    %esi,-0x38(%ebp)
801032e4:	89 45 bc             	mov    %eax,-0x44(%ebp)
801032e7:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
801032eb:	89 45 c0             	mov    %eax,-0x40(%ebp)
801032ee:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801032f2:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801032f5:	31 c0                	xor    %eax,%eax
801032f7:	ee                   	out    %al,(%dx)
801032f8:	89 ca                	mov    %ecx,%edx
801032fa:	ec                   	in     (%dx),%al
801032fb:	0f b6 c0             	movzbl %al,%eax
801032fe:	89 fa                	mov    %edi,%edx
80103300:	89 45 d0             	mov    %eax,-0x30(%ebp)
80103303:	b8 02 00 00 00       	mov    $0x2,%eax
80103308:	ee                   	out    %al,(%dx)
80103309:	89 ca                	mov    %ecx,%edx
8010330b:	ec                   	in     (%dx),%al
8010330c:	0f b6 c0             	movzbl %al,%eax
8010330f:	89 fa                	mov    %edi,%edx
80103311:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80103314:	b8 04 00 00 00       	mov    $0x4,%eax
80103319:	ee                   	out    %al,(%dx)
8010331a:	89 ca                	mov    %ecx,%edx
8010331c:	ec                   	in     (%dx),%al
8010331d:	0f b6 c0             	movzbl %al,%eax
80103320:	89 fa                	mov    %edi,%edx
80103322:	89 45 d8             	mov    %eax,-0x28(%ebp)
80103325:	b8 07 00 00 00       	mov    $0x7,%eax
8010332a:	ee                   	out    %al,(%dx)
8010332b:	89 ca                	mov    %ecx,%edx
8010332d:	ec                   	in     (%dx),%al
8010332e:	0f b6 c0             	movzbl %al,%eax
80103331:	89 fa                	mov    %edi,%edx
80103333:	89 45 dc             	mov    %eax,-0x24(%ebp)
80103336:	b8 08 00 00 00       	mov    $0x8,%eax
8010333b:	ee                   	out    %al,(%dx)
8010333c:	89 ca                	mov    %ecx,%edx
8010333e:	ec                   	in     (%dx),%al
8010333f:	0f b6 c0             	movzbl %al,%eax
80103342:	89 fa                	mov    %edi,%edx
80103344:	89 45 e0             	mov    %eax,-0x20(%ebp)
80103347:	b8 09 00 00 00       	mov    $0x9,%eax
8010334c:	ee                   	out    %al,(%dx)
8010334d:	89 ca                	mov    %ecx,%edx
8010334f:	ec                   	in     (%dx),%al
80103350:	0f b6 c0             	movzbl %al,%eax
80103353:	83 ec 04             	sub    $0x4,%esp
80103356:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103359:	8d 45 d0             	lea    -0x30(%ebp),%eax
8010335c:	6a 18                	push   $0x18
8010335e:	50                   	push   %eax
8010335f:	8d 45 b8             	lea    -0x48(%ebp),%eax
80103362:	50                   	push   %eax
80103363:	e8 08 1c 00 00       	call   80104f70 <memcmp>
80103368:	83 c4 10             	add    $0x10,%esp
8010336b:	85 c0                	test   %eax,%eax
8010336d:	0f 85 f5 fe ff ff    	jne    80103268 <cmostime+0x28>
80103373:	0f b6 75 b3          	movzbl -0x4d(%ebp),%esi
80103377:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010337a:	89 f0                	mov    %esi,%eax
8010337c:	84 c0                	test   %al,%al
8010337e:	75 78                	jne    801033f8 <cmostime+0x1b8>
80103380:	8b 45 b8             	mov    -0x48(%ebp),%eax
80103383:	89 c2                	mov    %eax,%edx
80103385:	83 e0 0f             	and    $0xf,%eax
80103388:	c1 ea 04             	shr    $0x4,%edx
8010338b:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010338e:	8d 04 50             	lea    (%eax,%edx,2),%eax
80103391:	89 45 b8             	mov    %eax,-0x48(%ebp)
80103394:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103397:	89 c2                	mov    %eax,%edx
80103399:	83 e0 0f             	and    $0xf,%eax
8010339c:	c1 ea 04             	shr    $0x4,%edx
8010339f:	8d 14 92             	lea    (%edx,%edx,4),%edx
801033a2:	8d 04 50             	lea    (%eax,%edx,2),%eax
801033a5:	89 45 bc             	mov    %eax,-0x44(%ebp)
801033a8:	8b 45 c0             	mov    -0x40(%ebp),%eax
801033ab:	89 c2                	mov    %eax,%edx
801033ad:	83 e0 0f             	and    $0xf,%eax
801033b0:	c1 ea 04             	shr    $0x4,%edx
801033b3:	8d 14 92             	lea    (%edx,%edx,4),%edx
801033b6:	8d 04 50             	lea    (%eax,%edx,2),%eax
801033b9:	89 45 c0             	mov    %eax,-0x40(%ebp)
801033bc:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801033bf:	89 c2                	mov    %eax,%edx
801033c1:	83 e0 0f             	and    $0xf,%eax
801033c4:	c1 ea 04             	shr    $0x4,%edx
801033c7:	8d 14 92             	lea    (%edx,%edx,4),%edx
801033ca:	8d 04 50             	lea    (%eax,%edx,2),%eax
801033cd:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801033d0:	8b 45 c8             	mov    -0x38(%ebp),%eax
801033d3:	89 c2                	mov    %eax,%edx
801033d5:	83 e0 0f             	and    $0xf,%eax
801033d8:	c1 ea 04             	shr    $0x4,%edx
801033db:	8d 14 92             	lea    (%edx,%edx,4),%edx
801033de:	8d 04 50             	lea    (%eax,%edx,2),%eax
801033e1:	89 45 c8             	mov    %eax,-0x38(%ebp)
801033e4:	8b 45 cc             	mov    -0x34(%ebp),%eax
801033e7:	89 c2                	mov    %eax,%edx
801033e9:	83 e0 0f             	and    $0xf,%eax
801033ec:	c1 ea 04             	shr    $0x4,%edx
801033ef:	8d 14 92             	lea    (%edx,%edx,4),%edx
801033f2:	8d 04 50             	lea    (%eax,%edx,2),%eax
801033f5:	89 45 cc             	mov    %eax,-0x34(%ebp)
801033f8:	8b 45 b8             	mov    -0x48(%ebp),%eax
801033fb:	89 03                	mov    %eax,(%ebx)
801033fd:	8b 45 bc             	mov    -0x44(%ebp),%eax
80103400:	89 43 04             	mov    %eax,0x4(%ebx)
80103403:	8b 45 c0             	mov    -0x40(%ebp),%eax
80103406:	89 43 08             	mov    %eax,0x8(%ebx)
80103409:	8b 45 c4             	mov    -0x3c(%ebp),%eax
8010340c:	89 43 0c             	mov    %eax,0xc(%ebx)
8010340f:	8b 45 c8             	mov    -0x38(%ebp),%eax
80103412:	89 43 10             	mov    %eax,0x10(%ebx)
80103415:	8b 45 cc             	mov    -0x34(%ebp),%eax
80103418:	89 43 14             	mov    %eax,0x14(%ebx)
8010341b:	81 43 14 d0 07 00 00 	addl   $0x7d0,0x14(%ebx)
80103422:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103425:	5b                   	pop    %ebx
80103426:	5e                   	pop    %esi
80103427:	5f                   	pop    %edi
80103428:	5d                   	pop    %ebp
80103429:	c3                   	ret
8010342a:	66 90                	xchg   %ax,%ax
8010342c:	66 90                	xchg   %ax,%ax
8010342e:	66 90                	xchg   %ax,%ax

80103430 <install_trans>:
80103430:	8b 0d 28 2e 11 80    	mov    0x80112e28,%ecx
80103436:	85 c9                	test   %ecx,%ecx
80103438:	0f 8e 8a 00 00 00    	jle    801034c8 <install_trans+0x98>
8010343e:	55                   	push   %ebp
8010343f:	89 e5                	mov    %esp,%ebp
80103441:	57                   	push   %edi
80103442:	31 ff                	xor    %edi,%edi
80103444:	56                   	push   %esi
80103445:	53                   	push   %ebx
80103446:	83 ec 0c             	sub    $0xc,%esp
80103449:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103450:	a1 14 2e 11 80       	mov    0x80112e14,%eax
80103455:	83 ec 08             	sub    $0x8,%esp
80103458:	01 f8                	add    %edi,%eax
8010345a:	83 c0 01             	add    $0x1,%eax
8010345d:	50                   	push   %eax
8010345e:	ff 35 24 2e 11 80    	push   0x80112e24
80103464:	e8 67 cc ff ff       	call   801000d0 <bread>
80103469:	89 c6                	mov    %eax,%esi
8010346b:	58                   	pop    %eax
8010346c:	5a                   	pop    %edx
8010346d:	ff 34 bd 2c 2e 11 80 	push   -0x7feed1d4(,%edi,4)
80103474:	ff 35 24 2e 11 80    	push   0x80112e24
8010347a:	83 c7 01             	add    $0x1,%edi
8010347d:	e8 4e cc ff ff       	call   801000d0 <bread>
80103482:	83 c4 0c             	add    $0xc,%esp
80103485:	89 c3                	mov    %eax,%ebx
80103487:	8d 46 5c             	lea    0x5c(%esi),%eax
8010348a:	68 00 02 00 00       	push   $0x200
8010348f:	50                   	push   %eax
80103490:	8d 43 5c             	lea    0x5c(%ebx),%eax
80103493:	50                   	push   %eax
80103494:	e8 27 1b 00 00       	call   80104fc0 <memmove>
80103499:	89 1c 24             	mov    %ebx,(%esp)
8010349c:	e8 0f cd ff ff       	call   801001b0 <bwrite>
801034a1:	89 34 24             	mov    %esi,(%esp)
801034a4:	e8 47 cd ff ff       	call   801001f0 <brelse>
801034a9:	89 1c 24             	mov    %ebx,(%esp)
801034ac:	e8 3f cd ff ff       	call   801001f0 <brelse>
801034b1:	83 c4 10             	add    $0x10,%esp
801034b4:	39 3d 28 2e 11 80    	cmp    %edi,0x80112e28
801034ba:	7f 94                	jg     80103450 <install_trans+0x20>
801034bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801034bf:	5b                   	pop    %ebx
801034c0:	5e                   	pop    %esi
801034c1:	5f                   	pop    %edi
801034c2:	5d                   	pop    %ebp
801034c3:	c3                   	ret
801034c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801034c8:	c3                   	ret
801034c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801034d0 <write_head>:
801034d0:	55                   	push   %ebp
801034d1:	89 e5                	mov    %esp,%ebp
801034d3:	53                   	push   %ebx
801034d4:	83 ec 0c             	sub    $0xc,%esp
801034d7:	ff 35 14 2e 11 80    	push   0x80112e14
801034dd:	ff 35 24 2e 11 80    	push   0x80112e24
801034e3:	e8 e8 cb ff ff       	call   801000d0 <bread>
801034e8:	83 c4 10             	add    $0x10,%esp
801034eb:	89 c3                	mov    %eax,%ebx
801034ed:	a1 28 2e 11 80       	mov    0x80112e28,%eax
801034f2:	89 43 5c             	mov    %eax,0x5c(%ebx)
801034f5:	85 c0                	test   %eax,%eax
801034f7:	7e 19                	jle    80103512 <write_head+0x42>
801034f9:	31 d2                	xor    %edx,%edx
801034fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103500:	8b 0c 95 2c 2e 11 80 	mov    -0x7feed1d4(,%edx,4),%ecx
80103507:	89 4c 93 60          	mov    %ecx,0x60(%ebx,%edx,4)
8010350b:	83 c2 01             	add    $0x1,%edx
8010350e:	39 d0                	cmp    %edx,%eax
80103510:	75 ee                	jne    80103500 <write_head+0x30>
80103512:	83 ec 0c             	sub    $0xc,%esp
80103515:	53                   	push   %ebx
80103516:	e8 95 cc ff ff       	call   801001b0 <bwrite>
8010351b:	89 1c 24             	mov    %ebx,(%esp)
8010351e:	e8 cd cc ff ff       	call   801001f0 <brelse>
80103523:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103526:	83 c4 10             	add    $0x10,%esp
80103529:	c9                   	leave
8010352a:	c3                   	ret
8010352b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80103530 <initlog>:
80103530:	55                   	push   %ebp
80103531:	89 e5                	mov    %esp,%ebp
80103533:	53                   	push   %ebx
80103534:	83 ec 2c             	sub    $0x2c,%esp
80103537:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010353a:	68 d7 7b 10 80       	push   $0x80107bd7
8010353f:	68 e0 2d 11 80       	push   $0x80112de0
80103544:	e8 f7 16 00 00       	call   80104c40 <initlock>
80103549:	58                   	pop    %eax
8010354a:	8d 45 dc             	lea    -0x24(%ebp),%eax
8010354d:	5a                   	pop    %edx
8010354e:	50                   	push   %eax
8010354f:	53                   	push   %ebx
80103550:	e8 6b e8 ff ff       	call   80101dc0 <readsb>
80103555:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103558:	59                   	pop    %ecx
80103559:	89 1d 24 2e 11 80    	mov    %ebx,0x80112e24
8010355f:	8b 55 e8             	mov    -0x18(%ebp),%edx
80103562:	a3 14 2e 11 80       	mov    %eax,0x80112e14
80103567:	89 15 18 2e 11 80    	mov    %edx,0x80112e18
8010356d:	5a                   	pop    %edx
8010356e:	50                   	push   %eax
8010356f:	53                   	push   %ebx
80103570:	e8 5b cb ff ff       	call   801000d0 <bread>
80103575:	83 c4 10             	add    $0x10,%esp
80103578:	8b 58 5c             	mov    0x5c(%eax),%ebx
8010357b:	89 1d 28 2e 11 80    	mov    %ebx,0x80112e28
80103581:	85 db                	test   %ebx,%ebx
80103583:	7e 1d                	jle    801035a2 <initlog+0x72>
80103585:	31 d2                	xor    %edx,%edx
80103587:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010358e:	00 
8010358f:	90                   	nop
80103590:	8b 4c 90 60          	mov    0x60(%eax,%edx,4),%ecx
80103594:	89 0c 95 2c 2e 11 80 	mov    %ecx,-0x7feed1d4(,%edx,4)
8010359b:	83 c2 01             	add    $0x1,%edx
8010359e:	39 d3                	cmp    %edx,%ebx
801035a0:	75 ee                	jne    80103590 <initlog+0x60>
801035a2:	83 ec 0c             	sub    $0xc,%esp
801035a5:	50                   	push   %eax
801035a6:	e8 45 cc ff ff       	call   801001f0 <brelse>
801035ab:	e8 80 fe ff ff       	call   80103430 <install_trans>
801035b0:	c7 05 28 2e 11 80 00 	movl   $0x0,0x80112e28
801035b7:	00 00 00 
801035ba:	e8 11 ff ff ff       	call   801034d0 <write_head>
801035bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801035c2:	83 c4 10             	add    $0x10,%esp
801035c5:	c9                   	leave
801035c6:	c3                   	ret
801035c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801035ce:	00 
801035cf:	90                   	nop

801035d0 <begin_op>:
801035d0:	55                   	push   %ebp
801035d1:	89 e5                	mov    %esp,%ebp
801035d3:	83 ec 14             	sub    $0x14,%esp
801035d6:	68 e0 2d 11 80       	push   $0x80112de0
801035db:	e8 50 18 00 00       	call   80104e30 <acquire>
801035e0:	83 c4 10             	add    $0x10,%esp
801035e3:	eb 18                	jmp    801035fd <begin_op+0x2d>
801035e5:	8d 76 00             	lea    0x0(%esi),%esi
801035e8:	83 ec 08             	sub    $0x8,%esp
801035eb:	68 e0 2d 11 80       	push   $0x80112de0
801035f0:	68 e0 2d 11 80       	push   $0x80112de0
801035f5:	e8 b6 12 00 00       	call   801048b0 <sleep>
801035fa:	83 c4 10             	add    $0x10,%esp
801035fd:	a1 20 2e 11 80       	mov    0x80112e20,%eax
80103602:	85 c0                	test   %eax,%eax
80103604:	75 e2                	jne    801035e8 <begin_op+0x18>
80103606:	a1 1c 2e 11 80       	mov    0x80112e1c,%eax
8010360b:	8b 15 28 2e 11 80    	mov    0x80112e28,%edx
80103611:	83 c0 01             	add    $0x1,%eax
80103614:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80103617:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
8010361a:	83 fa 1e             	cmp    $0x1e,%edx
8010361d:	7f c9                	jg     801035e8 <begin_op+0x18>
8010361f:	83 ec 0c             	sub    $0xc,%esp
80103622:	a3 1c 2e 11 80       	mov    %eax,0x80112e1c
80103627:	68 e0 2d 11 80       	push   $0x80112de0
8010362c:	e8 9f 17 00 00       	call   80104dd0 <release>
80103631:	83 c4 10             	add    $0x10,%esp
80103634:	c9                   	leave
80103635:	c3                   	ret
80103636:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010363d:	00 
8010363e:	66 90                	xchg   %ax,%ax

80103640 <end_op>:
80103640:	55                   	push   %ebp
80103641:	89 e5                	mov    %esp,%ebp
80103643:	57                   	push   %edi
80103644:	56                   	push   %esi
80103645:	53                   	push   %ebx
80103646:	83 ec 18             	sub    $0x18,%esp
80103649:	68 e0 2d 11 80       	push   $0x80112de0
8010364e:	e8 dd 17 00 00       	call   80104e30 <acquire>
80103653:	a1 1c 2e 11 80       	mov    0x80112e1c,%eax
80103658:	8b 35 20 2e 11 80    	mov    0x80112e20,%esi
8010365e:	83 c4 10             	add    $0x10,%esp
80103661:	8d 58 ff             	lea    -0x1(%eax),%ebx
80103664:	89 1d 1c 2e 11 80    	mov    %ebx,0x80112e1c
8010366a:	85 f6                	test   %esi,%esi
8010366c:	0f 85 22 01 00 00    	jne    80103794 <end_op+0x154>
80103672:	85 db                	test   %ebx,%ebx
80103674:	0f 85 f6 00 00 00    	jne    80103770 <end_op+0x130>
8010367a:	c7 05 20 2e 11 80 01 	movl   $0x1,0x80112e20
80103681:	00 00 00 
80103684:	83 ec 0c             	sub    $0xc,%esp
80103687:	68 e0 2d 11 80       	push   $0x80112de0
8010368c:	e8 3f 17 00 00       	call   80104dd0 <release>
80103691:	8b 0d 28 2e 11 80    	mov    0x80112e28,%ecx
80103697:	83 c4 10             	add    $0x10,%esp
8010369a:	85 c9                	test   %ecx,%ecx
8010369c:	7f 42                	jg     801036e0 <end_op+0xa0>
8010369e:	83 ec 0c             	sub    $0xc,%esp
801036a1:	68 e0 2d 11 80       	push   $0x80112de0
801036a6:	e8 85 17 00 00       	call   80104e30 <acquire>
801036ab:	c7 05 20 2e 11 80 00 	movl   $0x0,0x80112e20
801036b2:	00 00 00 
801036b5:	c7 04 24 e0 2d 11 80 	movl   $0x80112de0,(%esp)
801036bc:	e8 af 12 00 00       	call   80104970 <wakeup>
801036c1:	c7 04 24 e0 2d 11 80 	movl   $0x80112de0,(%esp)
801036c8:	e8 03 17 00 00       	call   80104dd0 <release>
801036cd:	83 c4 10             	add    $0x10,%esp
801036d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801036d3:	5b                   	pop    %ebx
801036d4:	5e                   	pop    %esi
801036d5:	5f                   	pop    %edi
801036d6:	5d                   	pop    %ebp
801036d7:	c3                   	ret
801036d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801036df:	00 
801036e0:	a1 14 2e 11 80       	mov    0x80112e14,%eax
801036e5:	83 ec 08             	sub    $0x8,%esp
801036e8:	01 d8                	add    %ebx,%eax
801036ea:	83 c0 01             	add    $0x1,%eax
801036ed:	50                   	push   %eax
801036ee:	ff 35 24 2e 11 80    	push   0x80112e24
801036f4:	e8 d7 c9 ff ff       	call   801000d0 <bread>
801036f9:	89 c6                	mov    %eax,%esi
801036fb:	58                   	pop    %eax
801036fc:	5a                   	pop    %edx
801036fd:	ff 34 9d 2c 2e 11 80 	push   -0x7feed1d4(,%ebx,4)
80103704:	ff 35 24 2e 11 80    	push   0x80112e24
8010370a:	83 c3 01             	add    $0x1,%ebx
8010370d:	e8 be c9 ff ff       	call   801000d0 <bread>
80103712:	83 c4 0c             	add    $0xc,%esp
80103715:	89 c7                	mov    %eax,%edi
80103717:	8d 40 5c             	lea    0x5c(%eax),%eax
8010371a:	68 00 02 00 00       	push   $0x200
8010371f:	50                   	push   %eax
80103720:	8d 46 5c             	lea    0x5c(%esi),%eax
80103723:	50                   	push   %eax
80103724:	e8 97 18 00 00       	call   80104fc0 <memmove>
80103729:	89 34 24             	mov    %esi,(%esp)
8010372c:	e8 7f ca ff ff       	call   801001b0 <bwrite>
80103731:	89 3c 24             	mov    %edi,(%esp)
80103734:	e8 b7 ca ff ff       	call   801001f0 <brelse>
80103739:	89 34 24             	mov    %esi,(%esp)
8010373c:	e8 af ca ff ff       	call   801001f0 <brelse>
80103741:	83 c4 10             	add    $0x10,%esp
80103744:	3b 1d 28 2e 11 80    	cmp    0x80112e28,%ebx
8010374a:	7c 94                	jl     801036e0 <end_op+0xa0>
8010374c:	e8 7f fd ff ff       	call   801034d0 <write_head>
80103751:	e8 da fc ff ff       	call   80103430 <install_trans>
80103756:	c7 05 28 2e 11 80 00 	movl   $0x0,0x80112e28
8010375d:	00 00 00 
80103760:	e8 6b fd ff ff       	call   801034d0 <write_head>
80103765:	e9 34 ff ff ff       	jmp    8010369e <end_op+0x5e>
8010376a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103770:	83 ec 0c             	sub    $0xc,%esp
80103773:	68 e0 2d 11 80       	push   $0x80112de0
80103778:	e8 f3 11 00 00       	call   80104970 <wakeup>
8010377d:	c7 04 24 e0 2d 11 80 	movl   $0x80112de0,(%esp)
80103784:	e8 47 16 00 00       	call   80104dd0 <release>
80103789:	83 c4 10             	add    $0x10,%esp
8010378c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010378f:	5b                   	pop    %ebx
80103790:	5e                   	pop    %esi
80103791:	5f                   	pop    %edi
80103792:	5d                   	pop    %ebp
80103793:	c3                   	ret
80103794:	83 ec 0c             	sub    $0xc,%esp
80103797:	68 db 7b 10 80       	push   $0x80107bdb
8010379c:	e8 ff cb ff ff       	call   801003a0 <panic>
801037a1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801037a8:	00 
801037a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801037b0 <log_write>:
801037b0:	55                   	push   %ebp
801037b1:	89 e5                	mov    %esp,%ebp
801037b3:	53                   	push   %ebx
801037b4:	83 ec 04             	sub    $0x4,%esp
801037b7:	8b 15 28 2e 11 80    	mov    0x80112e28,%edx
801037bd:	8b 5d 08             	mov    0x8(%ebp),%ebx
801037c0:	83 fa 1d             	cmp    $0x1d,%edx
801037c3:	7f 7d                	jg     80103842 <log_write+0x92>
801037c5:	a1 18 2e 11 80       	mov    0x80112e18,%eax
801037ca:	83 e8 01             	sub    $0x1,%eax
801037cd:	39 c2                	cmp    %eax,%edx
801037cf:	7d 71                	jge    80103842 <log_write+0x92>
801037d1:	a1 1c 2e 11 80       	mov    0x80112e1c,%eax
801037d6:	85 c0                	test   %eax,%eax
801037d8:	7e 75                	jle    8010384f <log_write+0x9f>
801037da:	83 ec 0c             	sub    $0xc,%esp
801037dd:	68 e0 2d 11 80       	push   $0x80112de0
801037e2:	e8 49 16 00 00       	call   80104e30 <acquire>
801037e7:	8b 4b 08             	mov    0x8(%ebx),%ecx
801037ea:	83 c4 10             	add    $0x10,%esp
801037ed:	31 c0                	xor    %eax,%eax
801037ef:	8b 15 28 2e 11 80    	mov    0x80112e28,%edx
801037f5:	85 d2                	test   %edx,%edx
801037f7:	7f 0e                	jg     80103807 <log_write+0x57>
801037f9:	eb 15                	jmp    80103810 <log_write+0x60>
801037fb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103800:	83 c0 01             	add    $0x1,%eax
80103803:	39 c2                	cmp    %eax,%edx
80103805:	74 29                	je     80103830 <log_write+0x80>
80103807:	39 0c 85 2c 2e 11 80 	cmp    %ecx,-0x7feed1d4(,%eax,4)
8010380e:	75 f0                	jne    80103800 <log_write+0x50>
80103810:	89 0c 85 2c 2e 11 80 	mov    %ecx,-0x7feed1d4(,%eax,4)
80103817:	39 c2                	cmp    %eax,%edx
80103819:	74 1c                	je     80103837 <log_write+0x87>
8010381b:	83 0b 04             	orl    $0x4,(%ebx)
8010381e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103821:	c7 45 08 e0 2d 11 80 	movl   $0x80112de0,0x8(%ebp)
80103828:	c9                   	leave
80103829:	e9 a2 15 00 00       	jmp    80104dd0 <release>
8010382e:	66 90                	xchg   %ax,%ax
80103830:	89 0c 95 2c 2e 11 80 	mov    %ecx,-0x7feed1d4(,%edx,4)
80103837:	83 c2 01             	add    $0x1,%edx
8010383a:	89 15 28 2e 11 80    	mov    %edx,0x80112e28
80103840:	eb d9                	jmp    8010381b <log_write+0x6b>
80103842:	83 ec 0c             	sub    $0xc,%esp
80103845:	68 ea 7b 10 80       	push   $0x80107bea
8010384a:	e8 51 cb ff ff       	call   801003a0 <panic>
8010384f:	83 ec 0c             	sub    $0xc,%esp
80103852:	68 00 7c 10 80       	push   $0x80107c00
80103857:	e8 44 cb ff ff       	call   801003a0 <panic>
8010385c:	66 90                	xchg   %ax,%ax
8010385e:	66 90                	xchg   %ax,%ax

80103860 <mpmain>:
80103860:	55                   	push   %ebp
80103861:	89 e5                	mov    %esp,%ebp
80103863:	53                   	push   %ebx
80103864:	83 ec 04             	sub    $0x4,%esp
80103867:	e8 64 09 00 00       	call   801041d0 <cpuid>
8010386c:	89 c3                	mov    %eax,%ebx
8010386e:	e8 5d 09 00 00       	call   801041d0 <cpuid>
80103873:	83 ec 04             	sub    $0x4,%esp
80103876:	53                   	push   %ebx
80103877:	50                   	push   %eax
80103878:	68 1b 7c 10 80       	push   $0x80107c1b
8010387d:	e8 be d3 ff ff       	call   80100c40 <cprintf>
80103882:	e8 e9 28 00 00       	call   80106170 <idtinit>
80103887:	e8 e4 08 00 00       	call   80104170 <mycpu>
8010388c:	89 c2                	mov    %eax,%edx
8010388e:	b8 01 00 00 00       	mov    $0x1,%eax
80103893:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
8010389a:	e8 01 0c 00 00       	call   801044a0 <scheduler>
8010389f:	90                   	nop

801038a0 <mpenter>:
801038a0:	55                   	push   %ebp
801038a1:	89 e5                	mov    %esp,%ebp
801038a3:	83 ec 08             	sub    $0x8,%esp
801038a6:	e8 c5 39 00 00       	call   80107270 <switchkvm>
801038ab:	e8 30 39 00 00       	call   801071e0 <seginit>
801038b0:	e8 bb f7 ff ff       	call   80103070 <lapicinit>
801038b5:	e8 a6 ff ff ff       	call   80103860 <mpmain>
801038ba:	66 90                	xchg   %ax,%ax
801038bc:	66 90                	xchg   %ax,%ax
801038be:	66 90                	xchg   %ax,%ax

801038c0 <main>:
801038c0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
801038c4:	83 e4 f0             	and    $0xfffffff0,%esp
801038c7:	ff 71 fc             	push   -0x4(%ecx)
801038ca:	55                   	push   %ebp
801038cb:	89 e5                	mov    %esp,%ebp
801038cd:	53                   	push   %ebx
801038ce:	51                   	push   %ecx
801038cf:	83 ec 08             	sub    $0x8,%esp
801038d2:	68 00 00 40 80       	push   $0x80400000
801038d7:	68 10 6c 11 80       	push   $0x80116c10
801038dc:	e8 8f f5 ff ff       	call   80102e70 <kinit1>
801038e1:	e8 4a 3e 00 00       	call   80107730 <kvmalloc>
801038e6:	e8 85 01 00 00       	call   80103a70 <mpinit>
801038eb:	e8 80 f7 ff ff       	call   80103070 <lapicinit>
801038f0:	e8 eb 38 00 00       	call   801071e0 <seginit>
801038f5:	e8 86 03 00 00       	call   80103c80 <picinit>
801038fa:	e8 41 f3 ff ff       	call   80102c40 <ioapicinit>
801038ff:	e8 dc d9 ff ff       	call   801012e0 <consoleinit>
80103904:	e8 47 2b 00 00       	call   80106450 <uartinit>
80103909:	e8 42 08 00 00       	call   80104150 <pinit>
8010390e:	e8 dd 27 00 00       	call   801060f0 <tvinit>
80103913:	e8 28 c7 ff ff       	call   80100040 <binit>
80103918:	e8 93 dd ff ff       	call   801016b0 <fileinit>
8010391d:	e8 fe f0 ff ff       	call   80102a20 <ideinit>
80103922:	83 c4 0c             	add    $0xc,%esp
80103925:	68 8a 00 00 00       	push   $0x8a
8010392a:	68 8c b4 10 80       	push   $0x8010b48c
8010392f:	68 00 70 00 80       	push   $0x80007000
80103934:	e8 87 16 00 00       	call   80104fc0 <memmove>
80103939:	83 c4 10             	add    $0x10,%esp
8010393c:	69 05 c4 2e 11 80 b0 	imul   $0xb0,0x80112ec4,%eax
80103943:	00 00 00 
80103946:	05 e0 2e 11 80       	add    $0x80112ee0,%eax
8010394b:	3d e0 2e 11 80       	cmp    $0x80112ee0,%eax
80103950:	76 7e                	jbe    801039d0 <main+0x110>
80103952:	bb e0 2e 11 80       	mov    $0x80112ee0,%ebx
80103957:	eb 20                	jmp    80103979 <main+0xb9>
80103959:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103960:	69 05 c4 2e 11 80 b0 	imul   $0xb0,0x80112ec4,%eax
80103967:	00 00 00 
8010396a:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80103970:	05 e0 2e 11 80       	add    $0x80112ee0,%eax
80103975:	39 c3                	cmp    %eax,%ebx
80103977:	73 57                	jae    801039d0 <main+0x110>
80103979:	e8 f2 07 00 00       	call   80104170 <mycpu>
8010397e:	39 c3                	cmp    %eax,%ebx
80103980:	74 de                	je     80103960 <main+0xa0>
80103982:	e8 59 f5 ff ff       	call   80102ee0 <kalloc>
80103987:	83 ec 08             	sub    $0x8,%esp
8010398a:	c7 05 f8 6f 00 80 a0 	movl   $0x801038a0,0x80006ff8
80103991:	38 10 80 
80103994:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
8010399b:	a0 10 00 
8010399e:	05 00 10 00 00       	add    $0x1000,%eax
801039a3:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc
801039a8:	0f b6 03             	movzbl (%ebx),%eax
801039ab:	68 00 70 00 00       	push   $0x7000
801039b0:	50                   	push   %eax
801039b1:	e8 fa f7 ff ff       	call   801031b0 <lapicstartap>
801039b6:	83 c4 10             	add    $0x10,%esp
801039b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801039c0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
801039c6:	85 c0                	test   %eax,%eax
801039c8:	74 f6                	je     801039c0 <main+0x100>
801039ca:	eb 94                	jmp    80103960 <main+0xa0>
801039cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801039d0:	83 ec 08             	sub    $0x8,%esp
801039d3:	68 00 00 00 8e       	push   $0x8e000000
801039d8:	68 00 00 40 80       	push   $0x80400000
801039dd:	e8 2e f4 ff ff       	call   80102e10 <kinit2>
801039e2:	e8 39 08 00 00       	call   80104220 <userinit>
801039e7:	e8 74 fe ff ff       	call   80103860 <mpmain>
801039ec:	66 90                	xchg   %ax,%ax
801039ee:	66 90                	xchg   %ax,%ax

801039f0 <mpsearch1>:
801039f0:	55                   	push   %ebp
801039f1:	89 e5                	mov    %esp,%ebp
801039f3:	57                   	push   %edi
801039f4:	56                   	push   %esi
801039f5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
801039fb:	53                   	push   %ebx
801039fc:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
801039ff:	83 ec 0c             	sub    $0xc,%esp
80103a02:	39 de                	cmp    %ebx,%esi
80103a04:	72 10                	jb     80103a16 <mpsearch1+0x26>
80103a06:	eb 50                	jmp    80103a58 <mpsearch1+0x68>
80103a08:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103a0f:	00 
80103a10:	89 fe                	mov    %edi,%esi
80103a12:	39 df                	cmp    %ebx,%edi
80103a14:	73 42                	jae    80103a58 <mpsearch1+0x68>
80103a16:	83 ec 04             	sub    $0x4,%esp
80103a19:	8d 7e 10             	lea    0x10(%esi),%edi
80103a1c:	6a 04                	push   $0x4
80103a1e:	68 2f 7c 10 80       	push   $0x80107c2f
80103a23:	56                   	push   %esi
80103a24:	e8 47 15 00 00       	call   80104f70 <memcmp>
80103a29:	83 c4 10             	add    $0x10,%esp
80103a2c:	85 c0                	test   %eax,%eax
80103a2e:	75 e0                	jne    80103a10 <mpsearch1+0x20>
80103a30:	89 f2                	mov    %esi,%edx
80103a32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103a38:	0f b6 0a             	movzbl (%edx),%ecx
80103a3b:	83 c2 01             	add    $0x1,%edx
80103a3e:	01 c8                	add    %ecx,%eax
80103a40:	39 fa                	cmp    %edi,%edx
80103a42:	75 f4                	jne    80103a38 <mpsearch1+0x48>
80103a44:	84 c0                	test   %al,%al
80103a46:	75 c8                	jne    80103a10 <mpsearch1+0x20>
80103a48:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a4b:	89 f0                	mov    %esi,%eax
80103a4d:	5b                   	pop    %ebx
80103a4e:	5e                   	pop    %esi
80103a4f:	5f                   	pop    %edi
80103a50:	5d                   	pop    %ebp
80103a51:	c3                   	ret
80103a52:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103a58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103a5b:	31 f6                	xor    %esi,%esi
80103a5d:	5b                   	pop    %ebx
80103a5e:	89 f0                	mov    %esi,%eax
80103a60:	5e                   	pop    %esi
80103a61:	5f                   	pop    %edi
80103a62:	5d                   	pop    %ebp
80103a63:	c3                   	ret
80103a64:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103a6b:	00 
80103a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103a70 <mpinit>:
80103a70:	55                   	push   %ebp
80103a71:	89 e5                	mov    %esp,%ebp
80103a73:	57                   	push   %edi
80103a74:	56                   	push   %esi
80103a75:	53                   	push   %ebx
80103a76:	83 ec 1c             	sub    $0x1c,%esp
80103a79:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103a80:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103a87:	c1 e0 08             	shl    $0x8,%eax
80103a8a:	09 d0                	or     %edx,%eax
80103a8c:	c1 e0 04             	shl    $0x4,%eax
80103a8f:	75 1b                	jne    80103aac <mpinit+0x3c>
80103a91:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
80103a98:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103a9f:	c1 e0 08             	shl    $0x8,%eax
80103aa2:	09 d0                	or     %edx,%eax
80103aa4:	c1 e0 0a             	shl    $0xa,%eax
80103aa7:	2d 00 04 00 00       	sub    $0x400,%eax
80103aac:	ba 00 04 00 00       	mov    $0x400,%edx
80103ab1:	e8 3a ff ff ff       	call   801039f0 <mpsearch1>
80103ab6:	89 c3                	mov    %eax,%ebx
80103ab8:	85 c0                	test   %eax,%eax
80103aba:	0f 84 58 01 00 00    	je     80103c18 <mpinit+0x1a8>
80103ac0:	8b 73 04             	mov    0x4(%ebx),%esi
80103ac3:	85 f6                	test   %esi,%esi
80103ac5:	0f 84 3d 01 00 00    	je     80103c08 <mpinit+0x198>
80103acb:	83 ec 04             	sub    $0x4,%esp
80103ace:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80103ad4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103ad7:	6a 04                	push   $0x4
80103ad9:	68 34 7c 10 80       	push   $0x80107c34
80103ade:	50                   	push   %eax
80103adf:	e8 8c 14 00 00       	call   80104f70 <memcmp>
80103ae4:	83 c4 10             	add    $0x10,%esp
80103ae7:	85 c0                	test   %eax,%eax
80103ae9:	0f 85 19 01 00 00    	jne    80103c08 <mpinit+0x198>
80103aef:	0f b6 86 06 00 00 80 	movzbl -0x7ffffffa(%esi),%eax
80103af6:	3c 01                	cmp    $0x1,%al
80103af8:	74 08                	je     80103b02 <mpinit+0x92>
80103afa:	3c 04                	cmp    $0x4,%al
80103afc:	0f 85 06 01 00 00    	jne    80103c08 <mpinit+0x198>
80103b02:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103b09:	66 85 d2             	test   %dx,%dx
80103b0c:	74 22                	je     80103b30 <mpinit+0xc0>
80103b0e:	8d 3c 32             	lea    (%edx,%esi,1),%edi
80103b11:	89 f0                	mov    %esi,%eax
80103b13:	31 d2                	xor    %edx,%edx
80103b15:	8d 76 00             	lea    0x0(%esi),%esi
80103b18:	0f b6 88 00 00 00 80 	movzbl -0x80000000(%eax),%ecx
80103b1f:	83 c0 01             	add    $0x1,%eax
80103b22:	01 ca                	add    %ecx,%edx
80103b24:	39 f8                	cmp    %edi,%eax
80103b26:	75 f0                	jne    80103b18 <mpinit+0xa8>
80103b28:	84 d2                	test   %dl,%dl
80103b2a:	0f 85 d8 00 00 00    	jne    80103c08 <mpinit+0x198>
80103b30:	8b 86 24 00 00 80    	mov    -0x7fffffdc(%esi),%eax
80103b36:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103b39:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80103b3c:	a3 c0 2d 11 80       	mov    %eax,0x80112dc0
80103b41:	0f b7 96 04 00 00 80 	movzwl -0x7ffffffc(%esi),%edx
80103b48:	8d 86 2c 00 00 80    	lea    -0x7fffffd4(%esi),%eax
80103b4e:	01 d7                	add    %edx,%edi
80103b50:	89 fa                	mov    %edi,%edx
80103b52:	bf 01 00 00 00       	mov    $0x1,%edi
80103b57:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103b5e:	00 
80103b5f:	90                   	nop
80103b60:	39 d0                	cmp    %edx,%eax
80103b62:	73 19                	jae    80103b7d <mpinit+0x10d>
80103b64:	0f b6 08             	movzbl (%eax),%ecx
80103b67:	80 f9 02             	cmp    $0x2,%cl
80103b6a:	0f 84 80 00 00 00    	je     80103bf0 <mpinit+0x180>
80103b70:	77 6e                	ja     80103be0 <mpinit+0x170>
80103b72:	84 c9                	test   %cl,%cl
80103b74:	74 3a                	je     80103bb0 <mpinit+0x140>
80103b76:	83 c0 08             	add    $0x8,%eax
80103b79:	39 d0                	cmp    %edx,%eax
80103b7b:	72 e7                	jb     80103b64 <mpinit+0xf4>
80103b7d:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80103b80:	85 ff                	test   %edi,%edi
80103b82:	0f 84 dd 00 00 00    	je     80103c65 <mpinit+0x1f5>
80103b88:	80 7b 0c 00          	cmpb   $0x0,0xc(%ebx)
80103b8c:	74 15                	je     80103ba3 <mpinit+0x133>
80103b8e:	b8 70 00 00 00       	mov    $0x70,%eax
80103b93:	ba 22 00 00 00       	mov    $0x22,%edx
80103b98:	ee                   	out    %al,(%dx)
80103b99:	ba 23 00 00 00       	mov    $0x23,%edx
80103b9e:	ec                   	in     (%dx),%al
80103b9f:	83 c8 01             	or     $0x1,%eax
80103ba2:	ee                   	out    %al,(%dx)
80103ba3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ba6:	5b                   	pop    %ebx
80103ba7:	5e                   	pop    %esi
80103ba8:	5f                   	pop    %edi
80103ba9:	5d                   	pop    %ebp
80103baa:	c3                   	ret
80103bab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103bb0:	8b 0d c4 2e 11 80    	mov    0x80112ec4,%ecx
80103bb6:	83 f9 07             	cmp    $0x7,%ecx
80103bb9:	7f 19                	jg     80103bd4 <mpinit+0x164>
80103bbb:	69 f1 b0 00 00 00    	imul   $0xb0,%ecx,%esi
80103bc1:	0f b6 58 01          	movzbl 0x1(%eax),%ebx
80103bc5:	83 c1 01             	add    $0x1,%ecx
80103bc8:	89 0d c4 2e 11 80    	mov    %ecx,0x80112ec4
80103bce:	88 9e e0 2e 11 80    	mov    %bl,-0x7feed120(%esi)
80103bd4:	83 c0 14             	add    $0x14,%eax
80103bd7:	eb 87                	jmp    80103b60 <mpinit+0xf0>
80103bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103be0:	83 e9 03             	sub    $0x3,%ecx
80103be3:	80 f9 01             	cmp    $0x1,%cl
80103be6:	76 8e                	jbe    80103b76 <mpinit+0x106>
80103be8:	31 ff                	xor    %edi,%edi
80103bea:	e9 71 ff ff ff       	jmp    80103b60 <mpinit+0xf0>
80103bef:	90                   	nop
80103bf0:	0f b6 48 01          	movzbl 0x1(%eax),%ecx
80103bf4:	83 c0 08             	add    $0x8,%eax
80103bf7:	88 0d c0 2e 11 80    	mov    %cl,0x80112ec0
80103bfd:	e9 5e ff ff ff       	jmp    80103b60 <mpinit+0xf0>
80103c02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103c08:	83 ec 0c             	sub    $0xc,%esp
80103c0b:	68 39 7c 10 80       	push   $0x80107c39
80103c10:	e8 8b c7 ff ff       	call   801003a0 <panic>
80103c15:	8d 76 00             	lea    0x0(%esi),%esi
80103c18:	bb 00 00 0f 80       	mov    $0x800f0000,%ebx
80103c1d:	eb 0b                	jmp    80103c2a <mpinit+0x1ba>
80103c1f:	90                   	nop
80103c20:	89 f3                	mov    %esi,%ebx
80103c22:	81 fe 00 00 10 80    	cmp    $0x80100000,%esi
80103c28:	74 de                	je     80103c08 <mpinit+0x198>
80103c2a:	83 ec 04             	sub    $0x4,%esp
80103c2d:	8d 73 10             	lea    0x10(%ebx),%esi
80103c30:	6a 04                	push   $0x4
80103c32:	68 2f 7c 10 80       	push   $0x80107c2f
80103c37:	53                   	push   %ebx
80103c38:	e8 33 13 00 00       	call   80104f70 <memcmp>
80103c3d:	83 c4 10             	add    $0x10,%esp
80103c40:	85 c0                	test   %eax,%eax
80103c42:	75 dc                	jne    80103c20 <mpinit+0x1b0>
80103c44:	89 da                	mov    %ebx,%edx
80103c46:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103c4d:	00 
80103c4e:	66 90                	xchg   %ax,%ax
80103c50:	0f b6 0a             	movzbl (%edx),%ecx
80103c53:	83 c2 01             	add    $0x1,%edx
80103c56:	01 c8                	add    %ecx,%eax
80103c58:	39 d6                	cmp    %edx,%esi
80103c5a:	75 f4                	jne    80103c50 <mpinit+0x1e0>
80103c5c:	84 c0                	test   %al,%al
80103c5e:	75 c0                	jne    80103c20 <mpinit+0x1b0>
80103c60:	e9 5b fe ff ff       	jmp    80103ac0 <mpinit+0x50>
80103c65:	83 ec 0c             	sub    $0xc,%esp
80103c68:	68 ec 7f 10 80       	push   $0x80107fec
80103c6d:	e8 2e c7 ff ff       	call   801003a0 <panic>
80103c72:	66 90                	xchg   %ax,%ax
80103c74:	66 90                	xchg   %ax,%ax
80103c76:	66 90                	xchg   %ax,%ax
80103c78:	66 90                	xchg   %ax,%ax
80103c7a:	66 90                	xchg   %ax,%ax
80103c7c:	66 90                	xchg   %ax,%ax
80103c7e:	66 90                	xchg   %ax,%ax

80103c80 <picinit>:
80103c80:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103c85:	ba 21 00 00 00       	mov    $0x21,%edx
80103c8a:	ee                   	out    %al,(%dx)
80103c8b:	ba a1 00 00 00       	mov    $0xa1,%edx
80103c90:	ee                   	out    %al,(%dx)
80103c91:	c3                   	ret
80103c92:	66 90                	xchg   %ax,%ax
80103c94:	66 90                	xchg   %ax,%ax
80103c96:	66 90                	xchg   %ax,%ax
80103c98:	66 90                	xchg   %ax,%ax
80103c9a:	66 90                	xchg   %ax,%ax
80103c9c:	66 90                	xchg   %ax,%ax
80103c9e:	66 90                	xchg   %ax,%ax

80103ca0 <pipealloc>:
80103ca0:	55                   	push   %ebp
80103ca1:	89 e5                	mov    %esp,%ebp
80103ca3:	57                   	push   %edi
80103ca4:	56                   	push   %esi
80103ca5:	53                   	push   %ebx
80103ca6:	83 ec 0c             	sub    $0xc,%esp
80103ca9:	8b 75 08             	mov    0x8(%ebp),%esi
80103cac:	8b 7d 0c             	mov    0xc(%ebp),%edi
80103caf:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
80103cb5:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103cbb:	e8 10 da ff ff       	call   801016d0 <filealloc>
80103cc0:	89 06                	mov    %eax,(%esi)
80103cc2:	85 c0                	test   %eax,%eax
80103cc4:	0f 84 a5 00 00 00    	je     80103d6f <pipealloc+0xcf>
80103cca:	e8 01 da ff ff       	call   801016d0 <filealloc>
80103ccf:	89 07                	mov    %eax,(%edi)
80103cd1:	85 c0                	test   %eax,%eax
80103cd3:	0f 84 84 00 00 00    	je     80103d5d <pipealloc+0xbd>
80103cd9:	e8 02 f2 ff ff       	call   80102ee0 <kalloc>
80103cde:	89 c3                	mov    %eax,%ebx
80103ce0:	85 c0                	test   %eax,%eax
80103ce2:	0f 84 a0 00 00 00    	je     80103d88 <pipealloc+0xe8>
80103ce8:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103cef:	00 00 00 
80103cf2:	83 ec 08             	sub    $0x8,%esp
80103cf5:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103cfc:	00 00 00 
80103cff:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103d06:	00 00 00 
80103d09:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103d10:	00 00 00 
80103d13:	68 51 7c 10 80       	push   $0x80107c51
80103d18:	50                   	push   %eax
80103d19:	e8 22 0f 00 00       	call   80104c40 <initlock>
80103d1e:	8b 06                	mov    (%esi),%eax
80103d20:	83 c4 10             	add    $0x10,%esp
80103d23:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
80103d29:	8b 06                	mov    (%esi),%eax
80103d2b:	c6 40 08 01          	movb   $0x1,0x8(%eax)
80103d2f:	8b 06                	mov    (%esi),%eax
80103d31:	c6 40 09 00          	movb   $0x0,0x9(%eax)
80103d35:	8b 06                	mov    (%esi),%eax
80103d37:	89 58 0c             	mov    %ebx,0xc(%eax)
80103d3a:	8b 07                	mov    (%edi),%eax
80103d3c:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
80103d42:	8b 07                	mov    (%edi),%eax
80103d44:	c6 40 08 00          	movb   $0x0,0x8(%eax)
80103d48:	8b 07                	mov    (%edi),%eax
80103d4a:	c6 40 09 01          	movb   $0x1,0x9(%eax)
80103d4e:	8b 07                	mov    (%edi),%eax
80103d50:	89 58 0c             	mov    %ebx,0xc(%eax)
80103d53:	31 c0                	xor    %eax,%eax
80103d55:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103d58:	5b                   	pop    %ebx
80103d59:	5e                   	pop    %esi
80103d5a:	5f                   	pop    %edi
80103d5b:	5d                   	pop    %ebp
80103d5c:	c3                   	ret
80103d5d:	8b 06                	mov    (%esi),%eax
80103d5f:	85 c0                	test   %eax,%eax
80103d61:	74 1e                	je     80103d81 <pipealloc+0xe1>
80103d63:	83 ec 0c             	sub    $0xc,%esp
80103d66:	50                   	push   %eax
80103d67:	e8 24 da ff ff       	call   80101790 <fileclose>
80103d6c:	83 c4 10             	add    $0x10,%esp
80103d6f:	8b 07                	mov    (%edi),%eax
80103d71:	85 c0                	test   %eax,%eax
80103d73:	74 0c                	je     80103d81 <pipealloc+0xe1>
80103d75:	83 ec 0c             	sub    $0xc,%esp
80103d78:	50                   	push   %eax
80103d79:	e8 12 da ff ff       	call   80101790 <fileclose>
80103d7e:	83 c4 10             	add    $0x10,%esp
80103d81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103d86:	eb cd                	jmp    80103d55 <pipealloc+0xb5>
80103d88:	8b 06                	mov    (%esi),%eax
80103d8a:	85 c0                	test   %eax,%eax
80103d8c:	75 d5                	jne    80103d63 <pipealloc+0xc3>
80103d8e:	eb df                	jmp    80103d6f <pipealloc+0xcf>

80103d90 <pipeclose>:
80103d90:	55                   	push   %ebp
80103d91:	89 e5                	mov    %esp,%ebp
80103d93:	56                   	push   %esi
80103d94:	53                   	push   %ebx
80103d95:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103d98:	8b 75 0c             	mov    0xc(%ebp),%esi
80103d9b:	83 ec 0c             	sub    $0xc,%esp
80103d9e:	53                   	push   %ebx
80103d9f:	e8 8c 10 00 00       	call   80104e30 <acquire>
80103da4:	83 c4 10             	add    $0x10,%esp
80103da7:	85 f6                	test   %esi,%esi
80103da9:	74 65                	je     80103e10 <pipeclose+0x80>
80103dab:	83 ec 0c             	sub    $0xc,%esp
80103dae:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103db4:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
80103dbb:	00 00 00 
80103dbe:	50                   	push   %eax
80103dbf:	e8 ac 0b 00 00       	call   80104970 <wakeup>
80103dc4:	83 c4 10             	add    $0x10,%esp
80103dc7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
80103dcd:	85 d2                	test   %edx,%edx
80103dcf:	75 0a                	jne    80103ddb <pipeclose+0x4b>
80103dd1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
80103dd7:	85 c0                	test   %eax,%eax
80103dd9:	74 15                	je     80103df0 <pipeclose+0x60>
80103ddb:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103dde:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103de1:	5b                   	pop    %ebx
80103de2:	5e                   	pop    %esi
80103de3:	5d                   	pop    %ebp
80103de4:	e9 e7 0f 00 00       	jmp    80104dd0 <release>
80103de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103df0:	83 ec 0c             	sub    $0xc,%esp
80103df3:	53                   	push   %ebx
80103df4:	e8 d7 0f 00 00       	call   80104dd0 <release>
80103df9:	83 c4 10             	add    $0x10,%esp
80103dfc:	89 5d 08             	mov    %ebx,0x8(%ebp)
80103dff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e02:	5b                   	pop    %ebx
80103e03:	5e                   	pop    %esi
80103e04:	5d                   	pop    %ebp
80103e05:	e9 16 ef ff ff       	jmp    80102d20 <kfree>
80103e0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103e10:	83 ec 0c             	sub    $0xc,%esp
80103e13:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
80103e19:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
80103e20:	00 00 00 
80103e23:	50                   	push   %eax
80103e24:	e8 47 0b 00 00       	call   80104970 <wakeup>
80103e29:	83 c4 10             	add    $0x10,%esp
80103e2c:	eb 99                	jmp    80103dc7 <pipeclose+0x37>
80103e2e:	66 90                	xchg   %ax,%ax

80103e30 <pipewrite>:
80103e30:	55                   	push   %ebp
80103e31:	89 e5                	mov    %esp,%ebp
80103e33:	57                   	push   %edi
80103e34:	56                   	push   %esi
80103e35:	53                   	push   %ebx
80103e36:	83 ec 28             	sub    $0x28,%esp
80103e39:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103e3c:	8b 7d 10             	mov    0x10(%ebp),%edi
80103e3f:	53                   	push   %ebx
80103e40:	e8 eb 0f 00 00       	call   80104e30 <acquire>
80103e45:	83 c4 10             	add    $0x10,%esp
80103e48:	85 ff                	test   %edi,%edi
80103e4a:	0f 8e ce 00 00 00    	jle    80103f1e <pipewrite+0xee>
80103e50:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
80103e56:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103e59:	89 7d 10             	mov    %edi,0x10(%ebp)
80103e5c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103e5f:	8d 34 39             	lea    (%ecx,%edi,1),%esi
80103e62:	89 75 e0             	mov    %esi,-0x20(%ebp)
80103e65:	8d b3 34 02 00 00    	lea    0x234(%ebx),%esi
80103e6b:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103e71:	8d bb 38 02 00 00    	lea    0x238(%ebx),%edi
80103e77:	8d 90 00 02 00 00    	lea    0x200(%eax),%edx
80103e7d:	39 55 e4             	cmp    %edx,-0x1c(%ebp)
80103e80:	0f 85 b6 00 00 00    	jne    80103f3c <pipewrite+0x10c>
80103e86:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103e89:	eb 3b                	jmp    80103ec6 <pipewrite+0x96>
80103e8b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80103e90:	e8 5b 03 00 00       	call   801041f0 <myproc>
80103e95:	8b 48 24             	mov    0x24(%eax),%ecx
80103e98:	85 c9                	test   %ecx,%ecx
80103e9a:	75 34                	jne    80103ed0 <pipewrite+0xa0>
80103e9c:	83 ec 0c             	sub    $0xc,%esp
80103e9f:	56                   	push   %esi
80103ea0:	e8 cb 0a 00 00       	call   80104970 <wakeup>
80103ea5:	58                   	pop    %eax
80103ea6:	5a                   	pop    %edx
80103ea7:	53                   	push   %ebx
80103ea8:	57                   	push   %edi
80103ea9:	e8 02 0a 00 00       	call   801048b0 <sleep>
80103eae:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103eb4:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
80103eba:	83 c4 10             	add    $0x10,%esp
80103ebd:	05 00 02 00 00       	add    $0x200,%eax
80103ec2:	39 c2                	cmp    %eax,%edx
80103ec4:	75 2a                	jne    80103ef0 <pipewrite+0xc0>
80103ec6:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
80103ecc:	85 c0                	test   %eax,%eax
80103ece:	75 c0                	jne    80103e90 <pipewrite+0x60>
80103ed0:	83 ec 0c             	sub    $0xc,%esp
80103ed3:	53                   	push   %ebx
80103ed4:	e8 f7 0e 00 00       	call   80104dd0 <release>
80103ed9:	83 c4 10             	add    $0x10,%esp
80103edc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103ee1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103ee4:	5b                   	pop    %ebx
80103ee5:	5e                   	pop    %esi
80103ee6:	5f                   	pop    %edi
80103ee7:	5d                   	pop    %ebp
80103ee8:	c3                   	ret
80103ee9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103ef0:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103ef3:	8d 42 01             	lea    0x1(%edx),%eax
80103ef6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
80103efc:	83 c1 01             	add    $0x1,%ecx
80103eff:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
80103f05:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103f08:	0f b6 41 ff          	movzbl -0x1(%ecx),%eax
80103f0c:	88 44 13 34          	mov    %al,0x34(%ebx,%edx,1)
80103f10:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103f13:	39 c1                	cmp    %eax,%ecx
80103f15:	0f 85 50 ff ff ff    	jne    80103e6b <pipewrite+0x3b>
80103f1b:	8b 7d 10             	mov    0x10(%ebp),%edi
80103f1e:	83 ec 0c             	sub    $0xc,%esp
80103f21:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103f27:	50                   	push   %eax
80103f28:	e8 43 0a 00 00       	call   80104970 <wakeup>
80103f2d:	89 1c 24             	mov    %ebx,(%esp)
80103f30:	e8 9b 0e 00 00       	call   80104dd0 <release>
80103f35:	83 c4 10             	add    $0x10,%esp
80103f38:	89 f8                	mov    %edi,%eax
80103f3a:	eb a5                	jmp    80103ee1 <pipewrite+0xb1>
80103f3c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103f3f:	eb b2                	jmp    80103ef3 <pipewrite+0xc3>
80103f41:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80103f48:	00 
80103f49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103f50 <piperead>:
80103f50:	55                   	push   %ebp
80103f51:	89 e5                	mov    %esp,%ebp
80103f53:	57                   	push   %edi
80103f54:	56                   	push   %esi
80103f55:	53                   	push   %ebx
80103f56:	83 ec 18             	sub    $0x18,%esp
80103f59:	8b 75 08             	mov    0x8(%ebp),%esi
80103f5c:	8b 7d 0c             	mov    0xc(%ebp),%edi
80103f5f:	56                   	push   %esi
80103f60:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
80103f66:	e8 c5 0e 00 00       	call   80104e30 <acquire>
80103f6b:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103f71:	83 c4 10             	add    $0x10,%esp
80103f74:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103f7a:	74 2f                	je     80103fab <piperead+0x5b>
80103f7c:	eb 37                	jmp    80103fb5 <piperead+0x65>
80103f7e:	66 90                	xchg   %ax,%ax
80103f80:	e8 6b 02 00 00       	call   801041f0 <myproc>
80103f85:	8b 40 24             	mov    0x24(%eax),%eax
80103f88:	85 c0                	test   %eax,%eax
80103f8a:	0f 85 80 00 00 00    	jne    80104010 <piperead+0xc0>
80103f90:	83 ec 08             	sub    $0x8,%esp
80103f93:	56                   	push   %esi
80103f94:	53                   	push   %ebx
80103f95:	e8 16 09 00 00       	call   801048b0 <sleep>
80103f9a:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103fa0:	83 c4 10             	add    $0x10,%esp
80103fa3:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103fa9:	75 0a                	jne    80103fb5 <piperead+0x65>
80103fab:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103fb1:	85 d2                	test   %edx,%edx
80103fb3:	75 cb                	jne    80103f80 <piperead+0x30>
80103fb5:	8b 4d 10             	mov    0x10(%ebp),%ecx
80103fb8:	31 db                	xor    %ebx,%ebx
80103fba:	85 c9                	test   %ecx,%ecx
80103fbc:	7f 26                	jg     80103fe4 <piperead+0x94>
80103fbe:	eb 2c                	jmp    80103fec <piperead+0x9c>
80103fc0:	8d 48 01             	lea    0x1(%eax),%ecx
80103fc3:	25 ff 01 00 00       	and    $0x1ff,%eax
80103fc8:	89 8e 34 02 00 00    	mov    %ecx,0x234(%esi)
80103fce:	0f b6 44 06 34       	movzbl 0x34(%esi,%eax,1),%eax
80103fd3:	88 04 1f             	mov    %al,(%edi,%ebx,1)
80103fd6:	83 c3 01             	add    $0x1,%ebx
80103fd9:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80103fdc:	74 0e                	je     80103fec <piperead+0x9c>
80103fde:	8b 86 34 02 00 00    	mov    0x234(%esi),%eax
80103fe4:	3b 86 38 02 00 00    	cmp    0x238(%esi),%eax
80103fea:	75 d4                	jne    80103fc0 <piperead+0x70>
80103fec:	83 ec 0c             	sub    $0xc,%esp
80103fef:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
80103ff5:	50                   	push   %eax
80103ff6:	e8 75 09 00 00       	call   80104970 <wakeup>
80103ffb:	89 34 24             	mov    %esi,(%esp)
80103ffe:	e8 cd 0d 00 00       	call   80104dd0 <release>
80104003:	83 c4 10             	add    $0x10,%esp
80104006:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104009:	89 d8                	mov    %ebx,%eax
8010400b:	5b                   	pop    %ebx
8010400c:	5e                   	pop    %esi
8010400d:	5f                   	pop    %edi
8010400e:	5d                   	pop    %ebp
8010400f:	c3                   	ret
80104010:	83 ec 0c             	sub    $0xc,%esp
80104013:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104018:	56                   	push   %esi
80104019:	e8 b2 0d 00 00       	call   80104dd0 <release>
8010401e:	83 c4 10             	add    $0x10,%esp
80104021:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104024:	89 d8                	mov    %ebx,%eax
80104026:	5b                   	pop    %ebx
80104027:	5e                   	pop    %esi
80104028:	5f                   	pop    %edi
80104029:	5d                   	pop    %ebp
8010402a:	c3                   	ret
8010402b:	66 90                	xchg   %ax,%ax
8010402d:	66 90                	xchg   %ax,%ax
8010402f:	90                   	nop

80104030 <allocproc>:
80104030:	55                   	push   %ebp
80104031:	89 e5                	mov    %esp,%ebp
80104033:	53                   	push   %ebx
80104034:	bb 94 34 11 80       	mov    $0x80113494,%ebx
80104039:	83 ec 10             	sub    $0x10,%esp
8010403c:	68 60 34 11 80       	push   $0x80113460
80104041:	e8 ea 0d 00 00       	call   80104e30 <acquire>
80104046:	83 c4 10             	add    $0x10,%esp
80104049:	eb 10                	jmp    8010405b <allocproc+0x2b>
8010404b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104050:	83 c3 7c             	add    $0x7c,%ebx
80104053:	81 fb 94 53 11 80    	cmp    $0x80115394,%ebx
80104059:	74 75                	je     801040d0 <allocproc+0xa0>
8010405b:	8b 43 0c             	mov    0xc(%ebx),%eax
8010405e:	85 c0                	test   %eax,%eax
80104060:	75 ee                	jne    80104050 <allocproc+0x20>
80104062:	a1 04 b0 10 80       	mov    0x8010b004,%eax
80104067:	83 ec 0c             	sub    $0xc,%esp
8010406a:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
80104071:	89 43 10             	mov    %eax,0x10(%ebx)
80104074:	8d 50 01             	lea    0x1(%eax),%edx
80104077:	68 60 34 11 80       	push   $0x80113460
8010407c:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
80104082:	e8 49 0d 00 00       	call   80104dd0 <release>
80104087:	e8 54 ee ff ff       	call   80102ee0 <kalloc>
8010408c:	83 c4 10             	add    $0x10,%esp
8010408f:	89 43 08             	mov    %eax,0x8(%ebx)
80104092:	85 c0                	test   %eax,%eax
80104094:	74 53                	je     801040e9 <allocproc+0xb9>
80104096:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
8010409c:	83 ec 04             	sub    $0x4,%esp
8010409f:	05 9c 0f 00 00       	add    $0xf9c,%eax
801040a4:	89 53 18             	mov    %edx,0x18(%ebx)
801040a7:	c7 40 14 e2 60 10 80 	movl   $0x801060e2,0x14(%eax)
801040ae:	89 43 1c             	mov    %eax,0x1c(%ebx)
801040b1:	6a 14                	push   $0x14
801040b3:	6a 00                	push   $0x0
801040b5:	50                   	push   %eax
801040b6:	e8 75 0e 00 00       	call   80104f30 <memset>
801040bb:	8b 43 1c             	mov    0x1c(%ebx),%eax
801040be:	83 c4 10             	add    $0x10,%esp
801040c1:	c7 40 10 00 41 10 80 	movl   $0x80104100,0x10(%eax)
801040c8:	89 d8                	mov    %ebx,%eax
801040ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040cd:	c9                   	leave
801040ce:	c3                   	ret
801040cf:	90                   	nop
801040d0:	83 ec 0c             	sub    $0xc,%esp
801040d3:	31 db                	xor    %ebx,%ebx
801040d5:	68 60 34 11 80       	push   $0x80113460
801040da:	e8 f1 0c 00 00       	call   80104dd0 <release>
801040df:	83 c4 10             	add    $0x10,%esp
801040e2:	89 d8                	mov    %ebx,%eax
801040e4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040e7:	c9                   	leave
801040e8:	c3                   	ret
801040e9:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
801040f0:	31 db                	xor    %ebx,%ebx
801040f2:	eb ee                	jmp    801040e2 <allocproc+0xb2>
801040f4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801040fb:	00 
801040fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104100 <forkret>:
80104100:	55                   	push   %ebp
80104101:	89 e5                	mov    %esp,%ebp
80104103:	83 ec 14             	sub    $0x14,%esp
80104106:	68 60 34 11 80       	push   $0x80113460
8010410b:	e8 c0 0c 00 00       	call   80104dd0 <release>
80104110:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80104115:	83 c4 10             	add    $0x10,%esp
80104118:	85 c0                	test   %eax,%eax
8010411a:	75 04                	jne    80104120 <forkret+0x20>
8010411c:	c9                   	leave
8010411d:	c3                   	ret
8010411e:	66 90                	xchg   %ax,%ax
80104120:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
80104127:	00 00 00 
8010412a:	83 ec 0c             	sub    $0xc,%esp
8010412d:	6a 01                	push   $0x1
8010412f:	e8 cc dc ff ff       	call   80101e00 <iinit>
80104134:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010413b:	e8 f0 f3 ff ff       	call   80103530 <initlog>
80104140:	83 c4 10             	add    $0x10,%esp
80104143:	c9                   	leave
80104144:	c3                   	ret
80104145:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010414c:	00 
8010414d:	8d 76 00             	lea    0x0(%esi),%esi

80104150 <pinit>:
80104150:	55                   	push   %ebp
80104151:	89 e5                	mov    %esp,%ebp
80104153:	83 ec 10             	sub    $0x10,%esp
80104156:	68 56 7c 10 80       	push   $0x80107c56
8010415b:	68 60 34 11 80       	push   $0x80113460
80104160:	e8 db 0a 00 00       	call   80104c40 <initlock>
80104165:	83 c4 10             	add    $0x10,%esp
80104168:	c9                   	leave
80104169:	c3                   	ret
8010416a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104170 <mycpu>:
80104170:	55                   	push   %ebp
80104171:	89 e5                	mov    %esp,%ebp
80104173:	56                   	push   %esi
80104174:	53                   	push   %ebx
80104175:	9c                   	pushf
80104176:	58                   	pop    %eax
80104177:	f6 c4 02             	test   $0x2,%ah
8010417a:	75 46                	jne    801041c2 <mycpu+0x52>
8010417c:	e8 df ef ff ff       	call   80103160 <lapicid>
80104181:	8b 35 c4 2e 11 80    	mov    0x80112ec4,%esi
80104187:	85 f6                	test   %esi,%esi
80104189:	7e 2a                	jle    801041b5 <mycpu+0x45>
8010418b:	31 d2                	xor    %edx,%edx
8010418d:	eb 08                	jmp    80104197 <mycpu+0x27>
8010418f:	90                   	nop
80104190:	83 c2 01             	add    $0x1,%edx
80104193:	39 f2                	cmp    %esi,%edx
80104195:	74 1e                	je     801041b5 <mycpu+0x45>
80104197:	69 ca b0 00 00 00    	imul   $0xb0,%edx,%ecx
8010419d:	0f b6 99 e0 2e 11 80 	movzbl -0x7feed120(%ecx),%ebx
801041a4:	39 c3                	cmp    %eax,%ebx
801041a6:	75 e8                	jne    80104190 <mycpu+0x20>
801041a8:	8d 65 f8             	lea    -0x8(%ebp),%esp
801041ab:	8d 81 e0 2e 11 80    	lea    -0x7feed120(%ecx),%eax
801041b1:	5b                   	pop    %ebx
801041b2:	5e                   	pop    %esi
801041b3:	5d                   	pop    %ebp
801041b4:	c3                   	ret
801041b5:	83 ec 0c             	sub    $0xc,%esp
801041b8:	68 5d 7c 10 80       	push   $0x80107c5d
801041bd:	e8 de c1 ff ff       	call   801003a0 <panic>
801041c2:	83 ec 0c             	sub    $0xc,%esp
801041c5:	68 0c 80 10 80       	push   $0x8010800c
801041ca:	e8 d1 c1 ff ff       	call   801003a0 <panic>
801041cf:	90                   	nop

801041d0 <cpuid>:
801041d0:	55                   	push   %ebp
801041d1:	89 e5                	mov    %esp,%ebp
801041d3:	83 ec 08             	sub    $0x8,%esp
801041d6:	e8 95 ff ff ff       	call   80104170 <mycpu>
801041db:	c9                   	leave
801041dc:	2d e0 2e 11 80       	sub    $0x80112ee0,%eax
801041e1:	c1 f8 04             	sar    $0x4,%eax
801041e4:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
801041ea:	c3                   	ret
801041eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801041f0 <myproc>:
801041f0:	55                   	push   %ebp
801041f1:	89 e5                	mov    %esp,%ebp
801041f3:	53                   	push   %ebx
801041f4:	83 ec 04             	sub    $0x4,%esp
801041f7:	e8 e4 0a 00 00       	call   80104ce0 <pushcli>
801041fc:	e8 6f ff ff ff       	call   80104170 <mycpu>
80104201:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80104207:	e8 24 0b 00 00       	call   80104d30 <popcli>
8010420c:	89 d8                	mov    %ebx,%eax
8010420e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104211:	c9                   	leave
80104212:	c3                   	ret
80104213:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010421a:	00 
8010421b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104220 <userinit>:
80104220:	55                   	push   %ebp
80104221:	89 e5                	mov    %esp,%ebp
80104223:	53                   	push   %ebx
80104224:	83 ec 04             	sub    $0x4,%esp
80104227:	e8 04 fe ff ff       	call   80104030 <allocproc>
8010422c:	89 c3                	mov    %eax,%ebx
8010422e:	a3 94 53 11 80       	mov    %eax,0x80115394
80104233:	e8 78 34 00 00       	call   801076b0 <setupkvm>
80104238:	89 43 04             	mov    %eax,0x4(%ebx)
8010423b:	85 c0                	test   %eax,%eax
8010423d:	0f 84 bd 00 00 00    	je     80104300 <userinit+0xe0>
80104243:	83 ec 04             	sub    $0x4,%esp
80104246:	68 2c 00 00 00       	push   $0x2c
8010424b:	68 60 b4 10 80       	push   $0x8010b460
80104250:	50                   	push   %eax
80104251:	e8 3a 31 00 00       	call   80107390 <inituvm>
80104256:	83 c4 0c             	add    $0xc,%esp
80104259:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
8010425f:	6a 4c                	push   $0x4c
80104261:	6a 00                	push   $0x0
80104263:	ff 73 18             	push   0x18(%ebx)
80104266:	e8 c5 0c 00 00       	call   80104f30 <memset>
8010426b:	8b 43 18             	mov    0x18(%ebx),%eax
8010426e:	ba 1b 00 00 00       	mov    $0x1b,%edx
80104273:	83 c4 0c             	add    $0xc,%esp
80104276:	b9 23 00 00 00       	mov    $0x23,%ecx
8010427b:	66 89 50 3c          	mov    %dx,0x3c(%eax)
8010427f:	8b 43 18             	mov    0x18(%ebx),%eax
80104282:	66 89 48 2c          	mov    %cx,0x2c(%eax)
80104286:	8b 43 18             	mov    0x18(%ebx),%eax
80104289:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
8010428d:	66 89 50 28          	mov    %dx,0x28(%eax)
80104291:	8b 43 18             	mov    0x18(%ebx),%eax
80104294:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80104298:	66 89 50 48          	mov    %dx,0x48(%eax)
8010429c:	8b 43 18             	mov    0x18(%ebx),%eax
8010429f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
801042a6:	8b 43 18             	mov    0x18(%ebx),%eax
801042a9:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
801042b0:	8b 43 18             	mov    0x18(%ebx),%eax
801042b3:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
801042ba:	8d 43 6c             	lea    0x6c(%ebx),%eax
801042bd:	6a 10                	push   $0x10
801042bf:	68 86 7c 10 80       	push   $0x80107c86
801042c4:	50                   	push   %eax
801042c5:	e8 16 0e 00 00       	call   801050e0 <safestrcpy>
801042ca:	c7 04 24 8f 7c 10 80 	movl   $0x80107c8f,(%esp)
801042d1:	e8 2a e6 ff ff       	call   80102900 <namei>
801042d6:	89 43 68             	mov    %eax,0x68(%ebx)
801042d9:	c7 04 24 60 34 11 80 	movl   $0x80113460,(%esp)
801042e0:	e8 4b 0b 00 00       	call   80104e30 <acquire>
801042e5:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
801042ec:	c7 04 24 60 34 11 80 	movl   $0x80113460,(%esp)
801042f3:	e8 d8 0a 00 00       	call   80104dd0 <release>
801042f8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042fb:	83 c4 10             	add    $0x10,%esp
801042fe:	c9                   	leave
801042ff:	c3                   	ret
80104300:	83 ec 0c             	sub    $0xc,%esp
80104303:	68 6d 7c 10 80       	push   $0x80107c6d
80104308:	e8 93 c0 ff ff       	call   801003a0 <panic>
8010430d:	8d 76 00             	lea    0x0(%esi),%esi

80104310 <growproc>:
80104310:	55                   	push   %ebp
80104311:	89 e5                	mov    %esp,%ebp
80104313:	56                   	push   %esi
80104314:	53                   	push   %ebx
80104315:	8b 75 08             	mov    0x8(%ebp),%esi
80104318:	e8 c3 09 00 00       	call   80104ce0 <pushcli>
8010431d:	e8 4e fe ff ff       	call   80104170 <mycpu>
80104322:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80104328:	e8 03 0a 00 00       	call   80104d30 <popcli>
8010432d:	8b 03                	mov    (%ebx),%eax
8010432f:	85 f6                	test   %esi,%esi
80104331:	7f 1d                	jg     80104350 <growproc+0x40>
80104333:	75 3b                	jne    80104370 <growproc+0x60>
80104335:	83 ec 0c             	sub    $0xc,%esp
80104338:	89 03                	mov    %eax,(%ebx)
8010433a:	53                   	push   %ebx
8010433b:	e8 40 2f 00 00       	call   80107280 <switchuvm>
80104340:	83 c4 10             	add    $0x10,%esp
80104343:	31 c0                	xor    %eax,%eax
80104345:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104348:	5b                   	pop    %ebx
80104349:	5e                   	pop    %esi
8010434a:	5d                   	pop    %ebp
8010434b:	c3                   	ret
8010434c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104350:	83 ec 04             	sub    $0x4,%esp
80104353:	01 c6                	add    %eax,%esi
80104355:	56                   	push   %esi
80104356:	50                   	push   %eax
80104357:	ff 73 04             	push   0x4(%ebx)
8010435a:	e8 81 31 00 00       	call   801074e0 <allocuvm>
8010435f:	83 c4 10             	add    $0x10,%esp
80104362:	85 c0                	test   %eax,%eax
80104364:	75 cf                	jne    80104335 <growproc+0x25>
80104366:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010436b:	eb d8                	jmp    80104345 <growproc+0x35>
8010436d:	8d 76 00             	lea    0x0(%esi),%esi
80104370:	83 ec 04             	sub    $0x4,%esp
80104373:	01 c6                	add    %eax,%esi
80104375:	56                   	push   %esi
80104376:	50                   	push   %eax
80104377:	ff 73 04             	push   0x4(%ebx)
8010437a:	e8 81 32 00 00       	call   80107600 <deallocuvm>
8010437f:	83 c4 10             	add    $0x10,%esp
80104382:	85 c0                	test   %eax,%eax
80104384:	75 af                	jne    80104335 <growproc+0x25>
80104386:	eb de                	jmp    80104366 <growproc+0x56>
80104388:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010438f:	00 

80104390 <fork>:
80104390:	55                   	push   %ebp
80104391:	89 e5                	mov    %esp,%ebp
80104393:	57                   	push   %edi
80104394:	56                   	push   %esi
80104395:	53                   	push   %ebx
80104396:	83 ec 1c             	sub    $0x1c,%esp
80104399:	e8 42 09 00 00       	call   80104ce0 <pushcli>
8010439e:	e8 cd fd ff ff       	call   80104170 <mycpu>
801043a3:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
801043a9:	e8 82 09 00 00       	call   80104d30 <popcli>
801043ae:	e8 7d fc ff ff       	call   80104030 <allocproc>
801043b3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801043b6:	85 c0                	test   %eax,%eax
801043b8:	0f 84 d6 00 00 00    	je     80104494 <fork+0x104>
801043be:	83 ec 08             	sub    $0x8,%esp
801043c1:	ff 33                	push   (%ebx)
801043c3:	89 c7                	mov    %eax,%edi
801043c5:	ff 73 04             	push   0x4(%ebx)
801043c8:	e8 d3 33 00 00       	call   801077a0 <copyuvm>
801043cd:	83 c4 10             	add    $0x10,%esp
801043d0:	89 47 04             	mov    %eax,0x4(%edi)
801043d3:	85 c0                	test   %eax,%eax
801043d5:	0f 84 9a 00 00 00    	je     80104475 <fork+0xe5>
801043db:	8b 03                	mov    (%ebx),%eax
801043dd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801043e0:	89 01                	mov    %eax,(%ecx)
801043e2:	8b 79 18             	mov    0x18(%ecx),%edi
801043e5:	89 c8                	mov    %ecx,%eax
801043e7:	89 59 14             	mov    %ebx,0x14(%ecx)
801043ea:	b9 13 00 00 00       	mov    $0x13,%ecx
801043ef:	8b 73 18             	mov    0x18(%ebx),%esi
801043f2:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
801043f4:	31 f6                	xor    %esi,%esi
801043f6:	8b 40 18             	mov    0x18(%eax),%eax
801043f9:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
80104400:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80104404:	85 c0                	test   %eax,%eax
80104406:	74 13                	je     8010441b <fork+0x8b>
80104408:	83 ec 0c             	sub    $0xc,%esp
8010440b:	50                   	push   %eax
8010440c:	e8 2f d3 ff ff       	call   80101740 <filedup>
80104411:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80104414:	83 c4 10             	add    $0x10,%esp
80104417:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
8010441b:	83 c6 01             	add    $0x1,%esi
8010441e:	83 fe 10             	cmp    $0x10,%esi
80104421:	75 dd                	jne    80104400 <fork+0x70>
80104423:	83 ec 0c             	sub    $0xc,%esp
80104426:	ff 73 68             	push   0x68(%ebx)
80104429:	83 c3 6c             	add    $0x6c,%ebx
8010442c:	e8 bf db ff ff       	call   80101ff0 <idup>
80104431:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80104434:	83 c4 0c             	add    $0xc,%esp
80104437:	89 47 68             	mov    %eax,0x68(%edi)
8010443a:	8d 47 6c             	lea    0x6c(%edi),%eax
8010443d:	6a 10                	push   $0x10
8010443f:	53                   	push   %ebx
80104440:	50                   	push   %eax
80104441:	e8 9a 0c 00 00       	call   801050e0 <safestrcpy>
80104446:	8b 5f 10             	mov    0x10(%edi),%ebx
80104449:	c7 04 24 60 34 11 80 	movl   $0x80113460,(%esp)
80104450:	e8 db 09 00 00       	call   80104e30 <acquire>
80104455:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
8010445c:	c7 04 24 60 34 11 80 	movl   $0x80113460,(%esp)
80104463:	e8 68 09 00 00       	call   80104dd0 <release>
80104468:	83 c4 10             	add    $0x10,%esp
8010446b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010446e:	89 d8                	mov    %ebx,%eax
80104470:	5b                   	pop    %ebx
80104471:	5e                   	pop    %esi
80104472:	5f                   	pop    %edi
80104473:	5d                   	pop    %ebp
80104474:	c3                   	ret
80104475:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80104478:	83 ec 0c             	sub    $0xc,%esp
8010447b:	ff 73 08             	push   0x8(%ebx)
8010447e:	e8 9d e8 ff ff       	call   80102d20 <kfree>
80104483:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
8010448a:	83 c4 10             	add    $0x10,%esp
8010448d:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80104494:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80104499:	eb d0                	jmp    8010446b <fork+0xdb>
8010449b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801044a0 <scheduler>:
801044a0:	55                   	push   %ebp
801044a1:	89 e5                	mov    %esp,%ebp
801044a3:	57                   	push   %edi
801044a4:	56                   	push   %esi
801044a5:	53                   	push   %ebx
801044a6:	83 ec 0c             	sub    $0xc,%esp
801044a9:	e8 c2 fc ff ff       	call   80104170 <mycpu>
801044ae:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
801044b5:	00 00 00 
801044b8:	89 c6                	mov    %eax,%esi
801044ba:	8d 78 04             	lea    0x4(%eax),%edi
801044bd:	8d 76 00             	lea    0x0(%esi),%esi
801044c0:	fb                   	sti
801044c1:	83 ec 0c             	sub    $0xc,%esp
801044c4:	bb 94 34 11 80       	mov    $0x80113494,%ebx
801044c9:	68 60 34 11 80       	push   $0x80113460
801044ce:	e8 5d 09 00 00       	call   80104e30 <acquire>
801044d3:	83 c4 10             	add    $0x10,%esp
801044d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801044dd:	00 
801044de:	66 90                	xchg   %ax,%ax
801044e0:	83 7b 0c 03          	cmpl   $0x3,0xc(%ebx)
801044e4:	75 33                	jne    80104519 <scheduler+0x79>
801044e6:	83 ec 0c             	sub    $0xc,%esp
801044e9:	89 9e ac 00 00 00    	mov    %ebx,0xac(%esi)
801044ef:	53                   	push   %ebx
801044f0:	e8 8b 2d 00 00       	call   80107280 <switchuvm>
801044f5:	58                   	pop    %eax
801044f6:	5a                   	pop    %edx
801044f7:	ff 73 1c             	push   0x1c(%ebx)
801044fa:	57                   	push   %edi
801044fb:	c7 43 0c 04 00 00 00 	movl   $0x4,0xc(%ebx)
80104502:	e8 34 0c 00 00       	call   8010513b <swtch>
80104507:	e8 64 2d 00 00       	call   80107270 <switchkvm>
8010450c:	83 c4 10             	add    $0x10,%esp
8010450f:	c7 86 ac 00 00 00 00 	movl   $0x0,0xac(%esi)
80104516:	00 00 00 
80104519:	83 c3 7c             	add    $0x7c,%ebx
8010451c:	81 fb 94 53 11 80    	cmp    $0x80115394,%ebx
80104522:	75 bc                	jne    801044e0 <scheduler+0x40>
80104524:	83 ec 0c             	sub    $0xc,%esp
80104527:	68 60 34 11 80       	push   $0x80113460
8010452c:	e8 9f 08 00 00       	call   80104dd0 <release>
80104531:	83 c4 10             	add    $0x10,%esp
80104534:	eb 8a                	jmp    801044c0 <scheduler+0x20>
80104536:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010453d:	00 
8010453e:	66 90                	xchg   %ax,%ax

80104540 <sched>:
80104540:	55                   	push   %ebp
80104541:	89 e5                	mov    %esp,%ebp
80104543:	56                   	push   %esi
80104544:	53                   	push   %ebx
80104545:	e8 96 07 00 00       	call   80104ce0 <pushcli>
8010454a:	e8 21 fc ff ff       	call   80104170 <mycpu>
8010454f:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80104555:	e8 d6 07 00 00       	call   80104d30 <popcli>
8010455a:	83 ec 0c             	sub    $0xc,%esp
8010455d:	68 60 34 11 80       	push   $0x80113460
80104562:	e8 29 08 00 00       	call   80104d90 <holding>
80104567:	83 c4 10             	add    $0x10,%esp
8010456a:	85 c0                	test   %eax,%eax
8010456c:	74 4f                	je     801045bd <sched+0x7d>
8010456e:	e8 fd fb ff ff       	call   80104170 <mycpu>
80104573:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
8010457a:	75 68                	jne    801045e4 <sched+0xa4>
8010457c:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80104580:	74 55                	je     801045d7 <sched+0x97>
80104582:	9c                   	pushf
80104583:	58                   	pop    %eax
80104584:	f6 c4 02             	test   $0x2,%ah
80104587:	75 41                	jne    801045ca <sched+0x8a>
80104589:	e8 e2 fb ff ff       	call   80104170 <mycpu>
8010458e:	83 c3 1c             	add    $0x1c,%ebx
80104591:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
80104597:	e8 d4 fb ff ff       	call   80104170 <mycpu>
8010459c:	83 ec 08             	sub    $0x8,%esp
8010459f:	ff 70 04             	push   0x4(%eax)
801045a2:	53                   	push   %ebx
801045a3:	e8 93 0b 00 00       	call   8010513b <swtch>
801045a8:	e8 c3 fb ff ff       	call   80104170 <mycpu>
801045ad:	83 c4 10             	add    $0x10,%esp
801045b0:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
801045b6:	8d 65 f8             	lea    -0x8(%ebp),%esp
801045b9:	5b                   	pop    %ebx
801045ba:	5e                   	pop    %esi
801045bb:	5d                   	pop    %ebp
801045bc:	c3                   	ret
801045bd:	83 ec 0c             	sub    $0xc,%esp
801045c0:	68 91 7c 10 80       	push   $0x80107c91
801045c5:	e8 d6 bd ff ff       	call   801003a0 <panic>
801045ca:	83 ec 0c             	sub    $0xc,%esp
801045cd:	68 bd 7c 10 80       	push   $0x80107cbd
801045d2:	e8 c9 bd ff ff       	call   801003a0 <panic>
801045d7:	83 ec 0c             	sub    $0xc,%esp
801045da:	68 af 7c 10 80       	push   $0x80107caf
801045df:	e8 bc bd ff ff       	call   801003a0 <panic>
801045e4:	83 ec 0c             	sub    $0xc,%esp
801045e7:	68 a3 7c 10 80       	push   $0x80107ca3
801045ec:	e8 af bd ff ff       	call   801003a0 <panic>
801045f1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801045f8:	00 
801045f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104600 <exit>:
80104600:	55                   	push   %ebp
80104601:	89 e5                	mov    %esp,%ebp
80104603:	57                   	push   %edi
80104604:	56                   	push   %esi
80104605:	53                   	push   %ebx
80104606:	83 ec 0c             	sub    $0xc,%esp
80104609:	e8 e2 fb ff ff       	call   801041f0 <myproc>
8010460e:	39 05 94 53 11 80    	cmp    %eax,0x80115394
80104614:	0f 84 fd 00 00 00    	je     80104717 <exit+0x117>
8010461a:	89 c3                	mov    %eax,%ebx
8010461c:	8d 70 28             	lea    0x28(%eax),%esi
8010461f:	8d 78 68             	lea    0x68(%eax),%edi
80104622:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104628:	8b 06                	mov    (%esi),%eax
8010462a:	85 c0                	test   %eax,%eax
8010462c:	74 12                	je     80104640 <exit+0x40>
8010462e:	83 ec 0c             	sub    $0xc,%esp
80104631:	50                   	push   %eax
80104632:	e8 59 d1 ff ff       	call   80101790 <fileclose>
80104637:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010463d:	83 c4 10             	add    $0x10,%esp
80104640:	83 c6 04             	add    $0x4,%esi
80104643:	39 f7                	cmp    %esi,%edi
80104645:	75 e1                	jne    80104628 <exit+0x28>
80104647:	e8 84 ef ff ff       	call   801035d0 <begin_op>
8010464c:	83 ec 0c             	sub    $0xc,%esp
8010464f:	ff 73 68             	push   0x68(%ebx)
80104652:	e8 f9 da ff ff       	call   80102150 <iput>
80104657:	e8 e4 ef ff ff       	call   80103640 <end_op>
8010465c:	c7 43 68 00 00 00 00 	movl   $0x0,0x68(%ebx)
80104663:	c7 04 24 60 34 11 80 	movl   $0x80113460,(%esp)
8010466a:	e8 c1 07 00 00       	call   80104e30 <acquire>
8010466f:	8b 53 14             	mov    0x14(%ebx),%edx
80104672:	83 c4 10             	add    $0x10,%esp
80104675:	b8 94 34 11 80       	mov    $0x80113494,%eax
8010467a:	eb 0e                	jmp    8010468a <exit+0x8a>
8010467c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104680:	83 c0 7c             	add    $0x7c,%eax
80104683:	3d 94 53 11 80       	cmp    $0x80115394,%eax
80104688:	74 1c                	je     801046a6 <exit+0xa6>
8010468a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010468e:	75 f0                	jne    80104680 <exit+0x80>
80104690:	3b 50 20             	cmp    0x20(%eax),%edx
80104693:	75 eb                	jne    80104680 <exit+0x80>
80104695:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
8010469c:	83 c0 7c             	add    $0x7c,%eax
8010469f:	3d 94 53 11 80       	cmp    $0x80115394,%eax
801046a4:	75 e4                	jne    8010468a <exit+0x8a>
801046a6:	8b 0d 94 53 11 80    	mov    0x80115394,%ecx
801046ac:	ba 94 34 11 80       	mov    $0x80113494,%edx
801046b1:	eb 10                	jmp    801046c3 <exit+0xc3>
801046b3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801046b8:	83 c2 7c             	add    $0x7c,%edx
801046bb:	81 fa 94 53 11 80    	cmp    $0x80115394,%edx
801046c1:	74 3b                	je     801046fe <exit+0xfe>
801046c3:	39 5a 14             	cmp    %ebx,0x14(%edx)
801046c6:	75 f0                	jne    801046b8 <exit+0xb8>
801046c8:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
801046cc:	89 4a 14             	mov    %ecx,0x14(%edx)
801046cf:	75 e7                	jne    801046b8 <exit+0xb8>
801046d1:	b8 94 34 11 80       	mov    $0x80113494,%eax
801046d6:	eb 12                	jmp    801046ea <exit+0xea>
801046d8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801046df:	00 
801046e0:	83 c0 7c             	add    $0x7c,%eax
801046e3:	3d 94 53 11 80       	cmp    $0x80115394,%eax
801046e8:	74 ce                	je     801046b8 <exit+0xb8>
801046ea:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801046ee:	75 f0                	jne    801046e0 <exit+0xe0>
801046f0:	3b 48 20             	cmp    0x20(%eax),%ecx
801046f3:	75 eb                	jne    801046e0 <exit+0xe0>
801046f5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801046fc:	eb e2                	jmp    801046e0 <exit+0xe0>
801046fe:	c7 43 0c 05 00 00 00 	movl   $0x5,0xc(%ebx)
80104705:	e8 36 fe ff ff       	call   80104540 <sched>
8010470a:	83 ec 0c             	sub    $0xc,%esp
8010470d:	68 de 7c 10 80       	push   $0x80107cde
80104712:	e8 89 bc ff ff       	call   801003a0 <panic>
80104717:	83 ec 0c             	sub    $0xc,%esp
8010471a:	68 d1 7c 10 80       	push   $0x80107cd1
8010471f:	e8 7c bc ff ff       	call   801003a0 <panic>
80104724:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010472b:	00 
8010472c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104730 <wait>:
80104730:	55                   	push   %ebp
80104731:	89 e5                	mov    %esp,%ebp
80104733:	56                   	push   %esi
80104734:	53                   	push   %ebx
80104735:	e8 a6 05 00 00       	call   80104ce0 <pushcli>
8010473a:	e8 31 fa ff ff       	call   80104170 <mycpu>
8010473f:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
80104745:	e8 e6 05 00 00       	call   80104d30 <popcli>
8010474a:	83 ec 0c             	sub    $0xc,%esp
8010474d:	68 60 34 11 80       	push   $0x80113460
80104752:	e8 d9 06 00 00       	call   80104e30 <acquire>
80104757:	83 c4 10             	add    $0x10,%esp
8010475a:	31 c0                	xor    %eax,%eax
8010475c:	bb 94 34 11 80       	mov    $0x80113494,%ebx
80104761:	eb 10                	jmp    80104773 <wait+0x43>
80104763:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104768:	83 c3 7c             	add    $0x7c,%ebx
8010476b:	81 fb 94 53 11 80    	cmp    $0x80115394,%ebx
80104771:	74 1b                	je     8010478e <wait+0x5e>
80104773:	39 73 14             	cmp    %esi,0x14(%ebx)
80104776:	75 f0                	jne    80104768 <wait+0x38>
80104778:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
8010477c:	74 62                	je     801047e0 <wait+0xb0>
8010477e:	83 c3 7c             	add    $0x7c,%ebx
80104781:	b8 01 00 00 00       	mov    $0x1,%eax
80104786:	81 fb 94 53 11 80    	cmp    $0x80115394,%ebx
8010478c:	75 e5                	jne    80104773 <wait+0x43>
8010478e:	85 c0                	test   %eax,%eax
80104790:	0f 84 a0 00 00 00    	je     80104836 <wait+0x106>
80104796:	8b 46 24             	mov    0x24(%esi),%eax
80104799:	85 c0                	test   %eax,%eax
8010479b:	0f 85 95 00 00 00    	jne    80104836 <wait+0x106>
801047a1:	e8 3a 05 00 00       	call   80104ce0 <pushcli>
801047a6:	e8 c5 f9 ff ff       	call   80104170 <mycpu>
801047ab:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
801047b1:	e8 7a 05 00 00       	call   80104d30 <popcli>
801047b6:	85 db                	test   %ebx,%ebx
801047b8:	0f 84 8f 00 00 00    	je     8010484d <wait+0x11d>
801047be:	89 73 20             	mov    %esi,0x20(%ebx)
801047c1:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
801047c8:	e8 73 fd ff ff       	call   80104540 <sched>
801047cd:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
801047d4:	eb 84                	jmp    8010475a <wait+0x2a>
801047d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801047dd:	00 
801047de:	66 90                	xchg   %ax,%ax
801047e0:	83 ec 0c             	sub    $0xc,%esp
801047e3:	8b 73 10             	mov    0x10(%ebx),%esi
801047e6:	ff 73 08             	push   0x8(%ebx)
801047e9:	e8 32 e5 ff ff       	call   80102d20 <kfree>
801047ee:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
801047f5:	5a                   	pop    %edx
801047f6:	ff 73 04             	push   0x4(%ebx)
801047f9:	e8 32 2e 00 00       	call   80107630 <freevm>
801047fe:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
80104805:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
8010480c:	c6 43 6c 00          	movb   $0x0,0x6c(%ebx)
80104810:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
80104817:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
8010481e:	c7 04 24 60 34 11 80 	movl   $0x80113460,(%esp)
80104825:	e8 a6 05 00 00       	call   80104dd0 <release>
8010482a:	83 c4 10             	add    $0x10,%esp
8010482d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104830:	89 f0                	mov    %esi,%eax
80104832:	5b                   	pop    %ebx
80104833:	5e                   	pop    %esi
80104834:	5d                   	pop    %ebp
80104835:	c3                   	ret
80104836:	83 ec 0c             	sub    $0xc,%esp
80104839:	be ff ff ff ff       	mov    $0xffffffff,%esi
8010483e:	68 60 34 11 80       	push   $0x80113460
80104843:	e8 88 05 00 00       	call   80104dd0 <release>
80104848:	83 c4 10             	add    $0x10,%esp
8010484b:	eb e0                	jmp    8010482d <wait+0xfd>
8010484d:	83 ec 0c             	sub    $0xc,%esp
80104850:	68 ea 7c 10 80       	push   $0x80107cea
80104855:	e8 46 bb ff ff       	call   801003a0 <panic>
8010485a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104860 <yield>:
80104860:	55                   	push   %ebp
80104861:	89 e5                	mov    %esp,%ebp
80104863:	53                   	push   %ebx
80104864:	83 ec 10             	sub    $0x10,%esp
80104867:	68 60 34 11 80       	push   $0x80113460
8010486c:	e8 bf 05 00 00       	call   80104e30 <acquire>
80104871:	e8 6a 04 00 00       	call   80104ce0 <pushcli>
80104876:	e8 f5 f8 ff ff       	call   80104170 <mycpu>
8010487b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
80104881:	e8 aa 04 00 00       	call   80104d30 <popcli>
80104886:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
8010488d:	e8 ae fc ff ff       	call   80104540 <sched>
80104892:	c7 04 24 60 34 11 80 	movl   $0x80113460,(%esp)
80104899:	e8 32 05 00 00       	call   80104dd0 <release>
8010489e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801048a1:	83 c4 10             	add    $0x10,%esp
801048a4:	c9                   	leave
801048a5:	c3                   	ret
801048a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801048ad:	00 
801048ae:	66 90                	xchg   %ax,%ax

801048b0 <sleep>:
801048b0:	55                   	push   %ebp
801048b1:	89 e5                	mov    %esp,%ebp
801048b3:	57                   	push   %edi
801048b4:	56                   	push   %esi
801048b5:	53                   	push   %ebx
801048b6:	83 ec 0c             	sub    $0xc,%esp
801048b9:	8b 7d 08             	mov    0x8(%ebp),%edi
801048bc:	8b 75 0c             	mov    0xc(%ebp),%esi
801048bf:	e8 1c 04 00 00       	call   80104ce0 <pushcli>
801048c4:	e8 a7 f8 ff ff       	call   80104170 <mycpu>
801048c9:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
801048cf:	e8 5c 04 00 00       	call   80104d30 <popcli>
801048d4:	85 db                	test   %ebx,%ebx
801048d6:	0f 84 87 00 00 00    	je     80104963 <sleep+0xb3>
801048dc:	85 f6                	test   %esi,%esi
801048de:	74 76                	je     80104956 <sleep+0xa6>
801048e0:	81 fe 60 34 11 80    	cmp    $0x80113460,%esi
801048e6:	74 50                	je     80104938 <sleep+0x88>
801048e8:	83 ec 0c             	sub    $0xc,%esp
801048eb:	68 60 34 11 80       	push   $0x80113460
801048f0:	e8 3b 05 00 00       	call   80104e30 <acquire>
801048f5:	89 34 24             	mov    %esi,(%esp)
801048f8:	e8 d3 04 00 00       	call   80104dd0 <release>
801048fd:	89 7b 20             	mov    %edi,0x20(%ebx)
80104900:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
80104907:	e8 34 fc ff ff       	call   80104540 <sched>
8010490c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
80104913:	c7 04 24 60 34 11 80 	movl   $0x80113460,(%esp)
8010491a:	e8 b1 04 00 00       	call   80104dd0 <release>
8010491f:	83 c4 10             	add    $0x10,%esp
80104922:	89 75 08             	mov    %esi,0x8(%ebp)
80104925:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104928:	5b                   	pop    %ebx
80104929:	5e                   	pop    %esi
8010492a:	5f                   	pop    %edi
8010492b:	5d                   	pop    %ebp
8010492c:	e9 ff 04 00 00       	jmp    80104e30 <acquire>
80104931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104938:	89 7b 20             	mov    %edi,0x20(%ebx)
8010493b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
80104942:	e8 f9 fb ff ff       	call   80104540 <sched>
80104947:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
8010494e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104951:	5b                   	pop    %ebx
80104952:	5e                   	pop    %esi
80104953:	5f                   	pop    %edi
80104954:	5d                   	pop    %ebp
80104955:	c3                   	ret
80104956:	83 ec 0c             	sub    $0xc,%esp
80104959:	68 f0 7c 10 80       	push   $0x80107cf0
8010495e:	e8 3d ba ff ff       	call   801003a0 <panic>
80104963:	83 ec 0c             	sub    $0xc,%esp
80104966:	68 ea 7c 10 80       	push   $0x80107cea
8010496b:	e8 30 ba ff ff       	call   801003a0 <panic>

80104970 <wakeup>:
80104970:	55                   	push   %ebp
80104971:	89 e5                	mov    %esp,%ebp
80104973:	53                   	push   %ebx
80104974:	83 ec 10             	sub    $0x10,%esp
80104977:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010497a:	68 60 34 11 80       	push   $0x80113460
8010497f:	e8 ac 04 00 00       	call   80104e30 <acquire>
80104984:	83 c4 10             	add    $0x10,%esp
80104987:	b8 94 34 11 80       	mov    $0x80113494,%eax
8010498c:	eb 0c                	jmp    8010499a <wakeup+0x2a>
8010498e:	66 90                	xchg   %ax,%ax
80104990:	83 c0 7c             	add    $0x7c,%eax
80104993:	3d 94 53 11 80       	cmp    $0x80115394,%eax
80104998:	74 1c                	je     801049b6 <wakeup+0x46>
8010499a:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
8010499e:	75 f0                	jne    80104990 <wakeup+0x20>
801049a0:	3b 58 20             	cmp    0x20(%eax),%ebx
801049a3:	75 eb                	jne    80104990 <wakeup+0x20>
801049a5:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
801049ac:	83 c0 7c             	add    $0x7c,%eax
801049af:	3d 94 53 11 80       	cmp    $0x80115394,%eax
801049b4:	75 e4                	jne    8010499a <wakeup+0x2a>
801049b6:	c7 45 08 60 34 11 80 	movl   $0x80113460,0x8(%ebp)
801049bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049c0:	c9                   	leave
801049c1:	e9 0a 04 00 00       	jmp    80104dd0 <release>
801049c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801049cd:	00 
801049ce:	66 90                	xchg   %ax,%ax

801049d0 <kill>:
801049d0:	55                   	push   %ebp
801049d1:	89 e5                	mov    %esp,%ebp
801049d3:	53                   	push   %ebx
801049d4:	83 ec 10             	sub    $0x10,%esp
801049d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
801049da:	68 60 34 11 80       	push   $0x80113460
801049df:	e8 4c 04 00 00       	call   80104e30 <acquire>
801049e4:	83 c4 10             	add    $0x10,%esp
801049e7:	b8 94 34 11 80       	mov    $0x80113494,%eax
801049ec:	eb 0c                	jmp    801049fa <kill+0x2a>
801049ee:	66 90                	xchg   %ax,%ax
801049f0:	83 c0 7c             	add    $0x7c,%eax
801049f3:	3d 94 53 11 80       	cmp    $0x80115394,%eax
801049f8:	74 36                	je     80104a30 <kill+0x60>
801049fa:	39 58 10             	cmp    %ebx,0x10(%eax)
801049fd:	75 f1                	jne    801049f0 <kill+0x20>
801049ff:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80104a03:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80104a0a:	75 07                	jne    80104a13 <kill+0x43>
80104a0c:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80104a13:	83 ec 0c             	sub    $0xc,%esp
80104a16:	68 60 34 11 80       	push   $0x80113460
80104a1b:	e8 b0 03 00 00       	call   80104dd0 <release>
80104a20:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a23:	83 c4 10             	add    $0x10,%esp
80104a26:	31 c0                	xor    %eax,%eax
80104a28:	c9                   	leave
80104a29:	c3                   	ret
80104a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104a30:	83 ec 0c             	sub    $0xc,%esp
80104a33:	68 60 34 11 80       	push   $0x80113460
80104a38:	e8 93 03 00 00       	call   80104dd0 <release>
80104a3d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104a40:	83 c4 10             	add    $0x10,%esp
80104a43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104a48:	c9                   	leave
80104a49:	c3                   	ret
80104a4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104a50 <procdump>:
80104a50:	55                   	push   %ebp
80104a51:	89 e5                	mov    %esp,%ebp
80104a53:	57                   	push   %edi
80104a54:	56                   	push   %esi
80104a55:	8d 75 e8             	lea    -0x18(%ebp),%esi
80104a58:	53                   	push   %ebx
80104a59:	bb 00 35 11 80       	mov    $0x80113500,%ebx
80104a5e:	83 ec 3c             	sub    $0x3c,%esp
80104a61:	eb 24                	jmp    80104a87 <procdump+0x37>
80104a63:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104a68:	83 ec 0c             	sub    $0xc,%esp
80104a6b:	68 af 7e 10 80       	push   $0x80107eaf
80104a70:	e8 cb c1 ff ff       	call   80100c40 <cprintf>
80104a75:	83 c4 10             	add    $0x10,%esp
80104a78:	83 c3 7c             	add    $0x7c,%ebx
80104a7b:	81 fb 00 54 11 80    	cmp    $0x80115400,%ebx
80104a81:	0f 84 81 00 00 00    	je     80104b08 <procdump+0xb8>
80104a87:	8b 43 a0             	mov    -0x60(%ebx),%eax
80104a8a:	85 c0                	test   %eax,%eax
80104a8c:	74 ea                	je     80104a78 <procdump+0x28>
80104a8e:	ba 01 7d 10 80       	mov    $0x80107d01,%edx
80104a93:	83 f8 05             	cmp    $0x5,%eax
80104a96:	77 11                	ja     80104aa9 <procdump+0x59>
80104a98:	8b 14 85 20 83 10 80 	mov    -0x7fef7ce0(,%eax,4),%edx
80104a9f:	b8 01 7d 10 80       	mov    $0x80107d01,%eax
80104aa4:	85 d2                	test   %edx,%edx
80104aa6:	0f 44 d0             	cmove  %eax,%edx
80104aa9:	53                   	push   %ebx
80104aaa:	52                   	push   %edx
80104aab:	ff 73 a4             	push   -0x5c(%ebx)
80104aae:	68 05 7d 10 80       	push   $0x80107d05
80104ab3:	e8 88 c1 ff ff       	call   80100c40 <cprintf>
80104ab8:	83 c4 10             	add    $0x10,%esp
80104abb:	83 7b a0 02          	cmpl   $0x2,-0x60(%ebx)
80104abf:	75 a7                	jne    80104a68 <procdump+0x18>
80104ac1:	83 ec 08             	sub    $0x8,%esp
80104ac4:	8d 45 c0             	lea    -0x40(%ebp),%eax
80104ac7:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104aca:	50                   	push   %eax
80104acb:	8b 43 b0             	mov    -0x50(%ebx),%eax
80104ace:	8b 40 0c             	mov    0xc(%eax),%eax
80104ad1:	83 c0 08             	add    $0x8,%eax
80104ad4:	50                   	push   %eax
80104ad5:	e8 86 01 00 00       	call   80104c60 <getcallerpcs>
80104ada:	83 c4 10             	add    $0x10,%esp
80104add:	8d 76 00             	lea    0x0(%esi),%esi
80104ae0:	8b 17                	mov    (%edi),%edx
80104ae2:	85 d2                	test   %edx,%edx
80104ae4:	74 82                	je     80104a68 <procdump+0x18>
80104ae6:	83 ec 08             	sub    $0x8,%esp
80104ae9:	83 c7 04             	add    $0x4,%edi
80104aec:	52                   	push   %edx
80104aed:	68 41 7a 10 80       	push   $0x80107a41
80104af2:	e8 49 c1 ff ff       	call   80100c40 <cprintf>
80104af7:	83 c4 10             	add    $0x10,%esp
80104afa:	39 f7                	cmp    %esi,%edi
80104afc:	75 e2                	jne    80104ae0 <procdump+0x90>
80104afe:	e9 65 ff ff ff       	jmp    80104a68 <procdump+0x18>
80104b03:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104b0b:	5b                   	pop    %ebx
80104b0c:	5e                   	pop    %esi
80104b0d:	5f                   	pop    %edi
80104b0e:	5d                   	pop    %ebp
80104b0f:	c3                   	ret

80104b10 <initsleeplock>:
80104b10:	55                   	push   %ebp
80104b11:	89 e5                	mov    %esp,%ebp
80104b13:	53                   	push   %ebx
80104b14:	83 ec 0c             	sub    $0xc,%esp
80104b17:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104b1a:	68 38 7d 10 80       	push   $0x80107d38
80104b1f:	8d 43 04             	lea    0x4(%ebx),%eax
80104b22:	50                   	push   %eax
80104b23:	e8 18 01 00 00       	call   80104c40 <initlock>
80104b28:	8b 45 0c             	mov    0xc(%ebp),%eax
80104b2b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104b31:	83 c4 10             	add    $0x10,%esp
80104b34:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
80104b3b:	89 43 38             	mov    %eax,0x38(%ebx)
80104b3e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104b41:	c9                   	leave
80104b42:	c3                   	ret
80104b43:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104b4a:	00 
80104b4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104b50 <acquiresleep>:
80104b50:	55                   	push   %ebp
80104b51:	89 e5                	mov    %esp,%ebp
80104b53:	56                   	push   %esi
80104b54:	53                   	push   %ebx
80104b55:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104b58:	8d 73 04             	lea    0x4(%ebx),%esi
80104b5b:	83 ec 0c             	sub    $0xc,%esp
80104b5e:	56                   	push   %esi
80104b5f:	e8 cc 02 00 00       	call   80104e30 <acquire>
80104b64:	8b 13                	mov    (%ebx),%edx
80104b66:	83 c4 10             	add    $0x10,%esp
80104b69:	85 d2                	test   %edx,%edx
80104b6b:	74 16                	je     80104b83 <acquiresleep+0x33>
80104b6d:	8d 76 00             	lea    0x0(%esi),%esi
80104b70:	83 ec 08             	sub    $0x8,%esp
80104b73:	56                   	push   %esi
80104b74:	53                   	push   %ebx
80104b75:	e8 36 fd ff ff       	call   801048b0 <sleep>
80104b7a:	8b 03                	mov    (%ebx),%eax
80104b7c:	83 c4 10             	add    $0x10,%esp
80104b7f:	85 c0                	test   %eax,%eax
80104b81:	75 ed                	jne    80104b70 <acquiresleep+0x20>
80104b83:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
80104b89:	e8 62 f6 ff ff       	call   801041f0 <myproc>
80104b8e:	8b 40 10             	mov    0x10(%eax),%eax
80104b91:	89 43 3c             	mov    %eax,0x3c(%ebx)
80104b94:	89 75 08             	mov    %esi,0x8(%ebp)
80104b97:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104b9a:	5b                   	pop    %ebx
80104b9b:	5e                   	pop    %esi
80104b9c:	5d                   	pop    %ebp
80104b9d:	e9 2e 02 00 00       	jmp    80104dd0 <release>
80104ba2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104ba9:	00 
80104baa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104bb0 <releasesleep>:
80104bb0:	55                   	push   %ebp
80104bb1:	89 e5                	mov    %esp,%ebp
80104bb3:	56                   	push   %esi
80104bb4:	53                   	push   %ebx
80104bb5:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104bb8:	8d 73 04             	lea    0x4(%ebx),%esi
80104bbb:	83 ec 0c             	sub    $0xc,%esp
80104bbe:	56                   	push   %esi
80104bbf:	e8 6c 02 00 00       	call   80104e30 <acquire>
80104bc4:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104bca:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
80104bd1:	89 1c 24             	mov    %ebx,(%esp)
80104bd4:	e8 97 fd ff ff       	call   80104970 <wakeup>
80104bd9:	83 c4 10             	add    $0x10,%esp
80104bdc:	89 75 08             	mov    %esi,0x8(%ebp)
80104bdf:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104be2:	5b                   	pop    %ebx
80104be3:	5e                   	pop    %esi
80104be4:	5d                   	pop    %ebp
80104be5:	e9 e6 01 00 00       	jmp    80104dd0 <release>
80104bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104bf0 <holdingsleep>:
80104bf0:	55                   	push   %ebp
80104bf1:	89 e5                	mov    %esp,%ebp
80104bf3:	57                   	push   %edi
80104bf4:	31 ff                	xor    %edi,%edi
80104bf6:	56                   	push   %esi
80104bf7:	53                   	push   %ebx
80104bf8:	83 ec 18             	sub    $0x18,%esp
80104bfb:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104bfe:	8d 73 04             	lea    0x4(%ebx),%esi
80104c01:	56                   	push   %esi
80104c02:	e8 29 02 00 00       	call   80104e30 <acquire>
80104c07:	8b 03                	mov    (%ebx),%eax
80104c09:	83 c4 10             	add    $0x10,%esp
80104c0c:	85 c0                	test   %eax,%eax
80104c0e:	75 18                	jne    80104c28 <holdingsleep+0x38>
80104c10:	83 ec 0c             	sub    $0xc,%esp
80104c13:	56                   	push   %esi
80104c14:	e8 b7 01 00 00       	call   80104dd0 <release>
80104c19:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104c1c:	89 f8                	mov    %edi,%eax
80104c1e:	5b                   	pop    %ebx
80104c1f:	5e                   	pop    %esi
80104c20:	5f                   	pop    %edi
80104c21:	5d                   	pop    %ebp
80104c22:	c3                   	ret
80104c23:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104c28:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104c2b:	e8 c0 f5 ff ff       	call   801041f0 <myproc>
80104c30:	39 58 10             	cmp    %ebx,0x10(%eax)
80104c33:	0f 94 c0             	sete   %al
80104c36:	0f b6 c0             	movzbl %al,%eax
80104c39:	89 c7                	mov    %eax,%edi
80104c3b:	eb d3                	jmp    80104c10 <holdingsleep+0x20>
80104c3d:	66 90                	xchg   %ax,%ax
80104c3f:	90                   	nop

80104c40 <initlock>:
80104c40:	55                   	push   %ebp
80104c41:	89 e5                	mov    %esp,%ebp
80104c43:	8b 45 08             	mov    0x8(%ebp),%eax
80104c46:	8b 55 0c             	mov    0xc(%ebp),%edx
80104c49:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104c4f:	89 50 04             	mov    %edx,0x4(%eax)
80104c52:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
80104c59:	5d                   	pop    %ebp
80104c5a:	c3                   	ret
80104c5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104c60 <getcallerpcs>:
80104c60:	55                   	push   %ebp
80104c61:	89 e5                	mov    %esp,%ebp
80104c63:	53                   	push   %ebx
80104c64:	8b 45 08             	mov    0x8(%ebp),%eax
80104c67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104c6a:	8d 50 f8             	lea    -0x8(%eax),%edx
80104c6d:	05 f8 ff ff 7f       	add    $0x7ffffff8,%eax
80104c72:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
80104c77:	b8 00 00 00 00       	mov    $0x0,%eax
80104c7c:	76 10                	jbe    80104c8e <getcallerpcs+0x2e>
80104c7e:	eb 28                	jmp    80104ca8 <getcallerpcs+0x48>
80104c80:	8d 9a 00 00 00 80    	lea    -0x80000000(%edx),%ebx
80104c86:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104c8c:	77 1a                	ja     80104ca8 <getcallerpcs+0x48>
80104c8e:	8b 5a 04             	mov    0x4(%edx),%ebx
80104c91:	89 1c 81             	mov    %ebx,(%ecx,%eax,4)
80104c94:	83 c0 01             	add    $0x1,%eax
80104c97:	8b 12                	mov    (%edx),%edx
80104c99:	83 f8 0a             	cmp    $0xa,%eax
80104c9c:	75 e2                	jne    80104c80 <getcallerpcs+0x20>
80104c9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104ca1:	c9                   	leave
80104ca2:	c3                   	ret
80104ca3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104ca8:	8d 04 81             	lea    (%ecx,%eax,4),%eax
80104cab:	83 c1 28             	add    $0x28,%ecx
80104cae:	89 ca                	mov    %ecx,%edx
80104cb0:	29 c2                	sub    %eax,%edx
80104cb2:	83 e2 04             	and    $0x4,%edx
80104cb5:	74 11                	je     80104cc8 <getcallerpcs+0x68>
80104cb7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104cbd:	83 c0 04             	add    $0x4,%eax
80104cc0:	39 c1                	cmp    %eax,%ecx
80104cc2:	74 da                	je     80104c9e <getcallerpcs+0x3e>
80104cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104cc8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104cce:	83 c0 08             	add    $0x8,%eax
80104cd1:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
80104cd8:	39 c1                	cmp    %eax,%ecx
80104cda:	75 ec                	jne    80104cc8 <getcallerpcs+0x68>
80104cdc:	eb c0                	jmp    80104c9e <getcallerpcs+0x3e>
80104cde:	66 90                	xchg   %ax,%ax

80104ce0 <pushcli>:
80104ce0:	55                   	push   %ebp
80104ce1:	89 e5                	mov    %esp,%ebp
80104ce3:	53                   	push   %ebx
80104ce4:	83 ec 04             	sub    $0x4,%esp
80104ce7:	9c                   	pushf
80104ce8:	5b                   	pop    %ebx
80104ce9:	fa                   	cli
80104cea:	e8 81 f4 ff ff       	call   80104170 <mycpu>
80104cef:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104cf5:	85 c0                	test   %eax,%eax
80104cf7:	74 17                	je     80104d10 <pushcli+0x30>
80104cf9:	e8 72 f4 ff ff       	call   80104170 <mycpu>
80104cfe:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
80104d05:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104d08:	c9                   	leave
80104d09:	c3                   	ret
80104d0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104d10:	e8 5b f4 ff ff       	call   80104170 <mycpu>
80104d15:	81 e3 00 02 00 00    	and    $0x200,%ebx
80104d1b:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
80104d21:	eb d6                	jmp    80104cf9 <pushcli+0x19>
80104d23:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104d2a:	00 
80104d2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104d30 <popcli>:
80104d30:	55                   	push   %ebp
80104d31:	89 e5                	mov    %esp,%ebp
80104d33:	83 ec 08             	sub    $0x8,%esp
80104d36:	9c                   	pushf
80104d37:	58                   	pop    %eax
80104d38:	f6 c4 02             	test   $0x2,%ah
80104d3b:	75 35                	jne    80104d72 <popcli+0x42>
80104d3d:	e8 2e f4 ff ff       	call   80104170 <mycpu>
80104d42:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104d49:	78 34                	js     80104d7f <popcli+0x4f>
80104d4b:	e8 20 f4 ff ff       	call   80104170 <mycpu>
80104d50:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104d56:	85 d2                	test   %edx,%edx
80104d58:	74 06                	je     80104d60 <popcli+0x30>
80104d5a:	c9                   	leave
80104d5b:	c3                   	ret
80104d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104d60:	e8 0b f4 ff ff       	call   80104170 <mycpu>
80104d65:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
80104d6b:	85 c0                	test   %eax,%eax
80104d6d:	74 eb                	je     80104d5a <popcli+0x2a>
80104d6f:	fb                   	sti
80104d70:	c9                   	leave
80104d71:	c3                   	ret
80104d72:	83 ec 0c             	sub    $0xc,%esp
80104d75:	68 43 7d 10 80       	push   $0x80107d43
80104d7a:	e8 21 b6 ff ff       	call   801003a0 <panic>
80104d7f:	83 ec 0c             	sub    $0xc,%esp
80104d82:	68 5a 7d 10 80       	push   $0x80107d5a
80104d87:	e8 14 b6 ff ff       	call   801003a0 <panic>
80104d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104d90 <holding>:
80104d90:	55                   	push   %ebp
80104d91:	89 e5                	mov    %esp,%ebp
80104d93:	56                   	push   %esi
80104d94:	53                   	push   %ebx
80104d95:	8b 75 08             	mov    0x8(%ebp),%esi
80104d98:	31 db                	xor    %ebx,%ebx
80104d9a:	e8 41 ff ff ff       	call   80104ce0 <pushcli>
80104d9f:	8b 06                	mov    (%esi),%eax
80104da1:	85 c0                	test   %eax,%eax
80104da3:	75 0b                	jne    80104db0 <holding+0x20>
80104da5:	e8 86 ff ff ff       	call   80104d30 <popcli>
80104daa:	89 d8                	mov    %ebx,%eax
80104dac:	5b                   	pop    %ebx
80104dad:	5e                   	pop    %esi
80104dae:	5d                   	pop    %ebp
80104daf:	c3                   	ret
80104db0:	8b 5e 08             	mov    0x8(%esi),%ebx
80104db3:	e8 b8 f3 ff ff       	call   80104170 <mycpu>
80104db8:	39 c3                	cmp    %eax,%ebx
80104dba:	0f 94 c3             	sete   %bl
80104dbd:	e8 6e ff ff ff       	call   80104d30 <popcli>
80104dc2:	0f b6 db             	movzbl %bl,%ebx
80104dc5:	89 d8                	mov    %ebx,%eax
80104dc7:	5b                   	pop    %ebx
80104dc8:	5e                   	pop    %esi
80104dc9:	5d                   	pop    %ebp
80104dca:	c3                   	ret
80104dcb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80104dd0 <release>:
80104dd0:	55                   	push   %ebp
80104dd1:	89 e5                	mov    %esp,%ebp
80104dd3:	56                   	push   %esi
80104dd4:	53                   	push   %ebx
80104dd5:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104dd8:	e8 03 ff ff ff       	call   80104ce0 <pushcli>
80104ddd:	8b 03                	mov    (%ebx),%eax
80104ddf:	85 c0                	test   %eax,%eax
80104de1:	75 15                	jne    80104df8 <release+0x28>
80104de3:	e8 48 ff ff ff       	call   80104d30 <popcli>
80104de8:	83 ec 0c             	sub    $0xc,%esp
80104deb:	68 61 7d 10 80       	push   $0x80107d61
80104df0:	e8 ab b5 ff ff       	call   801003a0 <panic>
80104df5:	8d 76 00             	lea    0x0(%esi),%esi
80104df8:	8b 73 08             	mov    0x8(%ebx),%esi
80104dfb:	e8 70 f3 ff ff       	call   80104170 <mycpu>
80104e00:	39 c6                	cmp    %eax,%esi
80104e02:	75 df                	jne    80104de3 <release+0x13>
80104e04:	e8 27 ff ff ff       	call   80104d30 <popcli>
80104e09:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
80104e10:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
80104e17:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
80104e1c:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80104e22:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104e25:	5b                   	pop    %ebx
80104e26:	5e                   	pop    %esi
80104e27:	5d                   	pop    %ebp
80104e28:	e9 03 ff ff ff       	jmp    80104d30 <popcli>
80104e2d:	8d 76 00             	lea    0x0(%esi),%esi

80104e30 <acquire>:
80104e30:	55                   	push   %ebp
80104e31:	89 e5                	mov    %esp,%ebp
80104e33:	53                   	push   %ebx
80104e34:	83 ec 04             	sub    $0x4,%esp
80104e37:	e8 a4 fe ff ff       	call   80104ce0 <pushcli>
80104e3c:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104e3f:	e8 9c fe ff ff       	call   80104ce0 <pushcli>
80104e44:	8b 03                	mov    (%ebx),%eax
80104e46:	85 c0                	test   %eax,%eax
80104e48:	0f 85 b2 00 00 00    	jne    80104f00 <acquire+0xd0>
80104e4e:	e8 dd fe ff ff       	call   80104d30 <popcli>
80104e53:	b9 01 00 00 00       	mov    $0x1,%ecx
80104e58:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104e5f:	00 
80104e60:	8b 55 08             	mov    0x8(%ebp),%edx
80104e63:	89 c8                	mov    %ecx,%eax
80104e65:	f0 87 02             	lock xchg %eax,(%edx)
80104e68:	85 c0                	test   %eax,%eax
80104e6a:	75 f4                	jne    80104e60 <acquire+0x30>
80104e6c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
80104e71:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104e74:	e8 f7 f2 ff ff       	call   80104170 <mycpu>
80104e79:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104e7c:	31 d2                	xor    %edx,%edx
80104e7e:	89 43 08             	mov    %eax,0x8(%ebx)
80104e81:	8d 85 00 00 00 80    	lea    -0x80000000(%ebp),%eax
80104e87:	3d fe ff ff 7f       	cmp    $0x7ffffffe,%eax
80104e8c:	77 32                	ja     80104ec0 <acquire+0x90>
80104e8e:	89 e8                	mov    %ebp,%eax
80104e90:	eb 14                	jmp    80104ea6 <acquire+0x76>
80104e92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104e98:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
80104e9e:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
80104ea4:	77 1a                	ja     80104ec0 <acquire+0x90>
80104ea6:	8b 58 04             	mov    0x4(%eax),%ebx
80104ea9:	89 5c 91 0c          	mov    %ebx,0xc(%ecx,%edx,4)
80104ead:	83 c2 01             	add    $0x1,%edx
80104eb0:	8b 00                	mov    (%eax),%eax
80104eb2:	83 fa 0a             	cmp    $0xa,%edx
80104eb5:	75 e1                	jne    80104e98 <acquire+0x68>
80104eb7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104eba:	c9                   	leave
80104ebb:	c3                   	ret
80104ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104ec0:	8d 44 91 0c          	lea    0xc(%ecx,%edx,4),%eax
80104ec4:	83 c1 34             	add    $0x34,%ecx
80104ec7:	89 ca                	mov    %ecx,%edx
80104ec9:	29 c2                	sub    %eax,%edx
80104ecb:	83 e2 04             	and    $0x4,%edx
80104ece:	74 10                	je     80104ee0 <acquire+0xb0>
80104ed0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104ed6:	83 c0 04             	add    $0x4,%eax
80104ed9:	39 c1                	cmp    %eax,%ecx
80104edb:	74 da                	je     80104eb7 <acquire+0x87>
80104edd:	8d 76 00             	lea    0x0(%esi),%esi
80104ee0:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104ee6:	83 c0 08             	add    $0x8,%eax
80104ee9:	c7 40 fc 00 00 00 00 	movl   $0x0,-0x4(%eax)
80104ef0:	39 c1                	cmp    %eax,%ecx
80104ef2:	75 ec                	jne    80104ee0 <acquire+0xb0>
80104ef4:	eb c1                	jmp    80104eb7 <acquire+0x87>
80104ef6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104efd:	00 
80104efe:	66 90                	xchg   %ax,%ax
80104f00:	8b 5b 08             	mov    0x8(%ebx),%ebx
80104f03:	e8 68 f2 ff ff       	call   80104170 <mycpu>
80104f08:	39 c3                	cmp    %eax,%ebx
80104f0a:	0f 85 3e ff ff ff    	jne    80104e4e <acquire+0x1e>
80104f10:	e8 1b fe ff ff       	call   80104d30 <popcli>
80104f15:	83 ec 0c             	sub    $0xc,%esp
80104f18:	68 69 7d 10 80       	push   $0x80107d69
80104f1d:	e8 7e b4 ff ff       	call   801003a0 <panic>
80104f22:	66 90                	xchg   %ax,%ax
80104f24:	66 90                	xchg   %ax,%ax
80104f26:	66 90                	xchg   %ax,%ax
80104f28:	66 90                	xchg   %ax,%ax
80104f2a:	66 90                	xchg   %ax,%ax
80104f2c:	66 90                	xchg   %ax,%ax
80104f2e:	66 90                	xchg   %ax,%ax

80104f30 <memset>:
80104f30:	55                   	push   %ebp
80104f31:	89 e5                	mov    %esp,%ebp
80104f33:	57                   	push   %edi
80104f34:	8b 55 08             	mov    0x8(%ebp),%edx
80104f37:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104f3a:	89 d0                	mov    %edx,%eax
80104f3c:	09 c8                	or     %ecx,%eax
80104f3e:	a8 03                	test   $0x3,%al
80104f40:	75 1e                	jne    80104f60 <memset+0x30>
80104f42:	0f b6 45 0c          	movzbl 0xc(%ebp),%eax
80104f46:	c1 e9 02             	shr    $0x2,%ecx
80104f49:	89 d7                	mov    %edx,%edi
80104f4b:	69 c0 01 01 01 01    	imul   $0x1010101,%eax,%eax
80104f51:	fc                   	cld
80104f52:	f3 ab                	rep stos %eax,%es:(%edi)
80104f54:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104f57:	89 d0                	mov    %edx,%eax
80104f59:	c9                   	leave
80104f5a:	c3                   	ret
80104f5b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f60:	8b 45 0c             	mov    0xc(%ebp),%eax
80104f63:	89 d7                	mov    %edx,%edi
80104f65:	fc                   	cld
80104f66:	f3 aa                	rep stos %al,%es:(%edi)
80104f68:	8b 7d fc             	mov    -0x4(%ebp),%edi
80104f6b:	89 d0                	mov    %edx,%eax
80104f6d:	c9                   	leave
80104f6e:	c3                   	ret
80104f6f:	90                   	nop

80104f70 <memcmp>:
80104f70:	55                   	push   %ebp
80104f71:	89 e5                	mov    %esp,%ebp
80104f73:	56                   	push   %esi
80104f74:	8b 75 10             	mov    0x10(%ebp),%esi
80104f77:	8b 45 08             	mov    0x8(%ebp),%eax
80104f7a:	53                   	push   %ebx
80104f7b:	8b 55 0c             	mov    0xc(%ebp),%edx
80104f7e:	85 f6                	test   %esi,%esi
80104f80:	74 2e                	je     80104fb0 <memcmp+0x40>
80104f82:	01 c6                	add    %eax,%esi
80104f84:	eb 14                	jmp    80104f9a <memcmp+0x2a>
80104f86:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104f8d:	00 
80104f8e:	66 90                	xchg   %ax,%ax
80104f90:	83 c0 01             	add    $0x1,%eax
80104f93:	83 c2 01             	add    $0x1,%edx
80104f96:	39 f0                	cmp    %esi,%eax
80104f98:	74 16                	je     80104fb0 <memcmp+0x40>
80104f9a:	0f b6 08             	movzbl (%eax),%ecx
80104f9d:	0f b6 1a             	movzbl (%edx),%ebx
80104fa0:	38 d9                	cmp    %bl,%cl
80104fa2:	74 ec                	je     80104f90 <memcmp+0x20>
80104fa4:	0f b6 c1             	movzbl %cl,%eax
80104fa7:	29 d8                	sub    %ebx,%eax
80104fa9:	5b                   	pop    %ebx
80104faa:	5e                   	pop    %esi
80104fab:	5d                   	pop    %ebp
80104fac:	c3                   	ret
80104fad:	8d 76 00             	lea    0x0(%esi),%esi
80104fb0:	5b                   	pop    %ebx
80104fb1:	31 c0                	xor    %eax,%eax
80104fb3:	5e                   	pop    %esi
80104fb4:	5d                   	pop    %ebp
80104fb5:	c3                   	ret
80104fb6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80104fbd:	00 
80104fbe:	66 90                	xchg   %ax,%ax

80104fc0 <memmove>:
80104fc0:	55                   	push   %ebp
80104fc1:	89 e5                	mov    %esp,%ebp
80104fc3:	57                   	push   %edi
80104fc4:	8b 55 08             	mov    0x8(%ebp),%edx
80104fc7:	8b 45 10             	mov    0x10(%ebp),%eax
80104fca:	56                   	push   %esi
80104fcb:	8b 75 0c             	mov    0xc(%ebp),%esi
80104fce:	39 d6                	cmp    %edx,%esi
80104fd0:	73 26                	jae    80104ff8 <memmove+0x38>
80104fd2:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104fd5:	39 ca                	cmp    %ecx,%edx
80104fd7:	73 1f                	jae    80104ff8 <memmove+0x38>
80104fd9:	85 c0                	test   %eax,%eax
80104fdb:	74 0f                	je     80104fec <memmove+0x2c>
80104fdd:	83 e8 01             	sub    $0x1,%eax
80104fe0:	0f b6 0c 06          	movzbl (%esi,%eax,1),%ecx
80104fe4:	88 0c 02             	mov    %cl,(%edx,%eax,1)
80104fe7:	83 e8 01             	sub    $0x1,%eax
80104fea:	73 f4                	jae    80104fe0 <memmove+0x20>
80104fec:	5e                   	pop    %esi
80104fed:	89 d0                	mov    %edx,%eax
80104fef:	5f                   	pop    %edi
80104ff0:	5d                   	pop    %ebp
80104ff1:	c3                   	ret
80104ff2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104ff8:	8d 0c 06             	lea    (%esi,%eax,1),%ecx
80104ffb:	89 d7                	mov    %edx,%edi
80104ffd:	85 c0                	test   %eax,%eax
80104fff:	74 eb                	je     80104fec <memmove+0x2c>
80105001:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105008:	a4                   	movsb  %ds:(%esi),%es:(%edi)
80105009:	39 ce                	cmp    %ecx,%esi
8010500b:	75 fb                	jne    80105008 <memmove+0x48>
8010500d:	5e                   	pop    %esi
8010500e:	89 d0                	mov    %edx,%eax
80105010:	5f                   	pop    %edi
80105011:	5d                   	pop    %ebp
80105012:	c3                   	ret
80105013:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010501a:	00 
8010501b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80105020 <memcpy>:
80105020:	eb 9e                	jmp    80104fc0 <memmove>
80105022:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105029:	00 
8010502a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105030 <strncmp>:
80105030:	55                   	push   %ebp
80105031:	89 e5                	mov    %esp,%ebp
80105033:	53                   	push   %ebx
80105034:	8b 55 10             	mov    0x10(%ebp),%edx
80105037:	8b 45 08             	mov    0x8(%ebp),%eax
8010503a:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010503d:	85 d2                	test   %edx,%edx
8010503f:	75 16                	jne    80105057 <strncmp+0x27>
80105041:	eb 2d                	jmp    80105070 <strncmp+0x40>
80105043:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105048:	3a 19                	cmp    (%ecx),%bl
8010504a:	75 12                	jne    8010505e <strncmp+0x2e>
8010504c:	83 c0 01             	add    $0x1,%eax
8010504f:	83 c1 01             	add    $0x1,%ecx
80105052:	83 ea 01             	sub    $0x1,%edx
80105055:	74 19                	je     80105070 <strncmp+0x40>
80105057:	0f b6 18             	movzbl (%eax),%ebx
8010505a:	84 db                	test   %bl,%bl
8010505c:	75 ea                	jne    80105048 <strncmp+0x18>
8010505e:	0f b6 00             	movzbl (%eax),%eax
80105061:	0f b6 11             	movzbl (%ecx),%edx
80105064:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105067:	c9                   	leave
80105068:	29 d0                	sub    %edx,%eax
8010506a:	c3                   	ret
8010506b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105070:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105073:	31 c0                	xor    %eax,%eax
80105075:	c9                   	leave
80105076:	c3                   	ret
80105077:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010507e:	00 
8010507f:	90                   	nop

80105080 <strncpy>:
80105080:	55                   	push   %ebp
80105081:	89 e5                	mov    %esp,%ebp
80105083:	57                   	push   %edi
80105084:	56                   	push   %esi
80105085:	8b 75 08             	mov    0x8(%ebp),%esi
80105088:	53                   	push   %ebx
80105089:	8b 55 10             	mov    0x10(%ebp),%edx
8010508c:	89 f0                	mov    %esi,%eax
8010508e:	eb 15                	jmp    801050a5 <strncpy+0x25>
80105090:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
80105094:	8b 7d 0c             	mov    0xc(%ebp),%edi
80105097:	83 c0 01             	add    $0x1,%eax
8010509a:	0f b6 4f ff          	movzbl -0x1(%edi),%ecx
8010509e:	88 48 ff             	mov    %cl,-0x1(%eax)
801050a1:	84 c9                	test   %cl,%cl
801050a3:	74 13                	je     801050b8 <strncpy+0x38>
801050a5:	89 d3                	mov    %edx,%ebx
801050a7:	83 ea 01             	sub    $0x1,%edx
801050aa:	85 db                	test   %ebx,%ebx
801050ac:	7f e2                	jg     80105090 <strncpy+0x10>
801050ae:	5b                   	pop    %ebx
801050af:	89 f0                	mov    %esi,%eax
801050b1:	5e                   	pop    %esi
801050b2:	5f                   	pop    %edi
801050b3:	5d                   	pop    %ebp
801050b4:	c3                   	ret
801050b5:	8d 76 00             	lea    0x0(%esi),%esi
801050b8:	8d 0c 18             	lea    (%eax,%ebx,1),%ecx
801050bb:	83 e9 01             	sub    $0x1,%ecx
801050be:	85 d2                	test   %edx,%edx
801050c0:	74 ec                	je     801050ae <strncpy+0x2e>
801050c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801050c8:	83 c0 01             	add    $0x1,%eax
801050cb:	89 ca                	mov    %ecx,%edx
801050cd:	c6 40 ff 00          	movb   $0x0,-0x1(%eax)
801050d1:	29 c2                	sub    %eax,%edx
801050d3:	85 d2                	test   %edx,%edx
801050d5:	7f f1                	jg     801050c8 <strncpy+0x48>
801050d7:	5b                   	pop    %ebx
801050d8:	89 f0                	mov    %esi,%eax
801050da:	5e                   	pop    %esi
801050db:	5f                   	pop    %edi
801050dc:	5d                   	pop    %ebp
801050dd:	c3                   	ret
801050de:	66 90                	xchg   %ax,%ax

801050e0 <safestrcpy>:
801050e0:	55                   	push   %ebp
801050e1:	89 e5                	mov    %esp,%ebp
801050e3:	56                   	push   %esi
801050e4:	8b 55 10             	mov    0x10(%ebp),%edx
801050e7:	8b 75 08             	mov    0x8(%ebp),%esi
801050ea:	53                   	push   %ebx
801050eb:	8b 45 0c             	mov    0xc(%ebp),%eax
801050ee:	85 d2                	test   %edx,%edx
801050f0:	7e 25                	jle    80105117 <safestrcpy+0x37>
801050f2:	8d 5c 10 ff          	lea    -0x1(%eax,%edx,1),%ebx
801050f6:	89 f2                	mov    %esi,%edx
801050f8:	eb 16                	jmp    80105110 <safestrcpy+0x30>
801050fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105100:	0f b6 08             	movzbl (%eax),%ecx
80105103:	83 c0 01             	add    $0x1,%eax
80105106:	83 c2 01             	add    $0x1,%edx
80105109:	88 4a ff             	mov    %cl,-0x1(%edx)
8010510c:	84 c9                	test   %cl,%cl
8010510e:	74 04                	je     80105114 <safestrcpy+0x34>
80105110:	39 d8                	cmp    %ebx,%eax
80105112:	75 ec                	jne    80105100 <safestrcpy+0x20>
80105114:	c6 02 00             	movb   $0x0,(%edx)
80105117:	89 f0                	mov    %esi,%eax
80105119:	5b                   	pop    %ebx
8010511a:	5e                   	pop    %esi
8010511b:	5d                   	pop    %ebp
8010511c:	c3                   	ret
8010511d:	8d 76 00             	lea    0x0(%esi),%esi

80105120 <strlen>:
80105120:	55                   	push   %ebp
80105121:	31 c0                	xor    %eax,%eax
80105123:	89 e5                	mov    %esp,%ebp
80105125:	8b 55 08             	mov    0x8(%ebp),%edx
80105128:	80 3a 00             	cmpb   $0x0,(%edx)
8010512b:	74 0c                	je     80105139 <strlen+0x19>
8010512d:	8d 76 00             	lea    0x0(%esi),%esi
80105130:	83 c0 01             	add    $0x1,%eax
80105133:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80105137:	75 f7                	jne    80105130 <strlen+0x10>
80105139:	5d                   	pop    %ebp
8010513a:	c3                   	ret

8010513b <swtch>:
8010513b:	8b 44 24 04          	mov    0x4(%esp),%eax
8010513f:	8b 54 24 08          	mov    0x8(%esp),%edx
80105143:	55                   	push   %ebp
80105144:	53                   	push   %ebx
80105145:	56                   	push   %esi
80105146:	57                   	push   %edi
80105147:	89 20                	mov    %esp,(%eax)
80105149:	89 d4                	mov    %edx,%esp
8010514b:	5f                   	pop    %edi
8010514c:	5e                   	pop    %esi
8010514d:	5b                   	pop    %ebx
8010514e:	5d                   	pop    %ebp
8010514f:	c3                   	ret

80105150 <fetchint>:
80105150:	55                   	push   %ebp
80105151:	89 e5                	mov    %esp,%ebp
80105153:	53                   	push   %ebx
80105154:	83 ec 04             	sub    $0x4,%esp
80105157:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010515a:	e8 91 f0 ff ff       	call   801041f0 <myproc>
8010515f:	8b 00                	mov    (%eax),%eax
80105161:	39 c3                	cmp    %eax,%ebx
80105163:	73 1b                	jae    80105180 <fetchint+0x30>
80105165:	8d 53 04             	lea    0x4(%ebx),%edx
80105168:	39 d0                	cmp    %edx,%eax
8010516a:	72 14                	jb     80105180 <fetchint+0x30>
8010516c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010516f:	8b 13                	mov    (%ebx),%edx
80105171:	89 10                	mov    %edx,(%eax)
80105173:	31 c0                	xor    %eax,%eax
80105175:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105178:	c9                   	leave
80105179:	c3                   	ret
8010517a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105180:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105185:	eb ee                	jmp    80105175 <fetchint+0x25>
80105187:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010518e:	00 
8010518f:	90                   	nop

80105190 <fetchstr>:
80105190:	55                   	push   %ebp
80105191:	89 e5                	mov    %esp,%ebp
80105193:	53                   	push   %ebx
80105194:	83 ec 04             	sub    $0x4,%esp
80105197:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010519a:	e8 51 f0 ff ff       	call   801041f0 <myproc>
8010519f:	3b 18                	cmp    (%eax),%ebx
801051a1:	73 2d                	jae    801051d0 <fetchstr+0x40>
801051a3:	8b 55 0c             	mov    0xc(%ebp),%edx
801051a6:	89 1a                	mov    %ebx,(%edx)
801051a8:	8b 10                	mov    (%eax),%edx
801051aa:	39 d3                	cmp    %edx,%ebx
801051ac:	73 22                	jae    801051d0 <fetchstr+0x40>
801051ae:	89 d8                	mov    %ebx,%eax
801051b0:	eb 0d                	jmp    801051bf <fetchstr+0x2f>
801051b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801051b8:	83 c0 01             	add    $0x1,%eax
801051bb:	39 d0                	cmp    %edx,%eax
801051bd:	73 11                	jae    801051d0 <fetchstr+0x40>
801051bf:	80 38 00             	cmpb   $0x0,(%eax)
801051c2:	75 f4                	jne    801051b8 <fetchstr+0x28>
801051c4:	29 d8                	sub    %ebx,%eax
801051c6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801051c9:	c9                   	leave
801051ca:	c3                   	ret
801051cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801051d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801051d3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801051d8:	c9                   	leave
801051d9:	c3                   	ret
801051da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801051e0 <argint>:
801051e0:	55                   	push   %ebp
801051e1:	89 e5                	mov    %esp,%ebp
801051e3:	56                   	push   %esi
801051e4:	53                   	push   %ebx
801051e5:	e8 06 f0 ff ff       	call   801041f0 <myproc>
801051ea:	8b 55 08             	mov    0x8(%ebp),%edx
801051ed:	8b 40 18             	mov    0x18(%eax),%eax
801051f0:	8b 40 44             	mov    0x44(%eax),%eax
801051f3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
801051f6:	e8 f5 ef ff ff       	call   801041f0 <myproc>
801051fb:	8d 73 04             	lea    0x4(%ebx),%esi
801051fe:	8b 00                	mov    (%eax),%eax
80105200:	39 c6                	cmp    %eax,%esi
80105202:	73 1c                	jae    80105220 <argint+0x40>
80105204:	8d 53 08             	lea    0x8(%ebx),%edx
80105207:	39 d0                	cmp    %edx,%eax
80105209:	72 15                	jb     80105220 <argint+0x40>
8010520b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010520e:	8b 53 04             	mov    0x4(%ebx),%edx
80105211:	89 10                	mov    %edx,(%eax)
80105213:	31 c0                	xor    %eax,%eax
80105215:	5b                   	pop    %ebx
80105216:	5e                   	pop    %esi
80105217:	5d                   	pop    %ebp
80105218:	c3                   	ret
80105219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105220:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105225:	eb ee                	jmp    80105215 <argint+0x35>
80105227:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010522e:	00 
8010522f:	90                   	nop

80105230 <argptr>:
80105230:	55                   	push   %ebp
80105231:	89 e5                	mov    %esp,%ebp
80105233:	57                   	push   %edi
80105234:	56                   	push   %esi
80105235:	53                   	push   %ebx
80105236:	83 ec 0c             	sub    $0xc,%esp
80105239:	e8 b2 ef ff ff       	call   801041f0 <myproc>
8010523e:	89 c6                	mov    %eax,%esi
80105240:	e8 ab ef ff ff       	call   801041f0 <myproc>
80105245:	8b 55 08             	mov    0x8(%ebp),%edx
80105248:	8b 40 18             	mov    0x18(%eax),%eax
8010524b:	8b 40 44             	mov    0x44(%eax),%eax
8010524e:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
80105251:	e8 9a ef ff ff       	call   801041f0 <myproc>
80105256:	8d 7b 04             	lea    0x4(%ebx),%edi
80105259:	8b 00                	mov    (%eax),%eax
8010525b:	39 c7                	cmp    %eax,%edi
8010525d:	73 31                	jae    80105290 <argptr+0x60>
8010525f:	8d 4b 08             	lea    0x8(%ebx),%ecx
80105262:	39 c8                	cmp    %ecx,%eax
80105264:	72 2a                	jb     80105290 <argptr+0x60>
80105266:	8b 55 10             	mov    0x10(%ebp),%edx
80105269:	8b 43 04             	mov    0x4(%ebx),%eax
8010526c:	85 d2                	test   %edx,%edx
8010526e:	78 20                	js     80105290 <argptr+0x60>
80105270:	8b 16                	mov    (%esi),%edx
80105272:	39 d0                	cmp    %edx,%eax
80105274:	73 1a                	jae    80105290 <argptr+0x60>
80105276:	8b 5d 10             	mov    0x10(%ebp),%ebx
80105279:	01 c3                	add    %eax,%ebx
8010527b:	39 da                	cmp    %ebx,%edx
8010527d:	72 11                	jb     80105290 <argptr+0x60>
8010527f:	8b 55 0c             	mov    0xc(%ebp),%edx
80105282:	89 02                	mov    %eax,(%edx)
80105284:	31 c0                	xor    %eax,%eax
80105286:	83 c4 0c             	add    $0xc,%esp
80105289:	5b                   	pop    %ebx
8010528a:	5e                   	pop    %esi
8010528b:	5f                   	pop    %edi
8010528c:	5d                   	pop    %ebp
8010528d:	c3                   	ret
8010528e:	66 90                	xchg   %ax,%ax
80105290:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105295:	eb ef                	jmp    80105286 <argptr+0x56>
80105297:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010529e:	00 
8010529f:	90                   	nop

801052a0 <argstr>:
801052a0:	55                   	push   %ebp
801052a1:	89 e5                	mov    %esp,%ebp
801052a3:	56                   	push   %esi
801052a4:	53                   	push   %ebx
801052a5:	e8 46 ef ff ff       	call   801041f0 <myproc>
801052aa:	8b 55 08             	mov    0x8(%ebp),%edx
801052ad:	8b 40 18             	mov    0x18(%eax),%eax
801052b0:	8b 40 44             	mov    0x44(%eax),%eax
801052b3:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
801052b6:	e8 35 ef ff ff       	call   801041f0 <myproc>
801052bb:	8d 73 04             	lea    0x4(%ebx),%esi
801052be:	8b 00                	mov    (%eax),%eax
801052c0:	39 c6                	cmp    %eax,%esi
801052c2:	73 44                	jae    80105308 <argstr+0x68>
801052c4:	8d 53 08             	lea    0x8(%ebx),%edx
801052c7:	39 d0                	cmp    %edx,%eax
801052c9:	72 3d                	jb     80105308 <argstr+0x68>
801052cb:	8b 5b 04             	mov    0x4(%ebx),%ebx
801052ce:	e8 1d ef ff ff       	call   801041f0 <myproc>
801052d3:	3b 18                	cmp    (%eax),%ebx
801052d5:	73 31                	jae    80105308 <argstr+0x68>
801052d7:	8b 55 0c             	mov    0xc(%ebp),%edx
801052da:	89 1a                	mov    %ebx,(%edx)
801052dc:	8b 10                	mov    (%eax),%edx
801052de:	39 d3                	cmp    %edx,%ebx
801052e0:	73 26                	jae    80105308 <argstr+0x68>
801052e2:	89 d8                	mov    %ebx,%eax
801052e4:	eb 11                	jmp    801052f7 <argstr+0x57>
801052e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801052ed:	00 
801052ee:	66 90                	xchg   %ax,%ax
801052f0:	83 c0 01             	add    $0x1,%eax
801052f3:	39 d0                	cmp    %edx,%eax
801052f5:	73 11                	jae    80105308 <argstr+0x68>
801052f7:	80 38 00             	cmpb   $0x0,(%eax)
801052fa:	75 f4                	jne    801052f0 <argstr+0x50>
801052fc:	29 d8                	sub    %ebx,%eax
801052fe:	5b                   	pop    %ebx
801052ff:	5e                   	pop    %esi
80105300:	5d                   	pop    %ebp
80105301:	c3                   	ret
80105302:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105308:	5b                   	pop    %ebx
80105309:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010530e:	5e                   	pop    %esi
8010530f:	5d                   	pop    %ebp
80105310:	c3                   	ret
80105311:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105318:	00 
80105319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105320 <syscall>:
80105320:	55                   	push   %ebp
80105321:	89 e5                	mov    %esp,%ebp
80105323:	53                   	push   %ebx
80105324:	83 ec 04             	sub    $0x4,%esp
80105327:	e8 c4 ee ff ff       	call   801041f0 <myproc>
8010532c:	89 c3                	mov    %eax,%ebx
8010532e:	8b 40 18             	mov    0x18(%eax),%eax
80105331:	8b 40 1c             	mov    0x1c(%eax),%eax
80105334:	8d 50 ff             	lea    -0x1(%eax),%edx
80105337:	83 fa 14             	cmp    $0x14,%edx
8010533a:	77 24                	ja     80105360 <syscall+0x40>
8010533c:	8b 14 85 40 83 10 80 	mov    -0x7fef7cc0(,%eax,4),%edx
80105343:	85 d2                	test   %edx,%edx
80105345:	74 19                	je     80105360 <syscall+0x40>
80105347:	ff d2                	call   *%edx
80105349:	89 c2                	mov    %eax,%edx
8010534b:	8b 43 18             	mov    0x18(%ebx),%eax
8010534e:	89 50 1c             	mov    %edx,0x1c(%eax)
80105351:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105354:	c9                   	leave
80105355:	c3                   	ret
80105356:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010535d:	00 
8010535e:	66 90                	xchg   %ax,%ax
80105360:	50                   	push   %eax
80105361:	8d 43 6c             	lea    0x6c(%ebx),%eax
80105364:	50                   	push   %eax
80105365:	ff 73 10             	push   0x10(%ebx)
80105368:	68 71 7d 10 80       	push   $0x80107d71
8010536d:	e8 ce b8 ff ff       	call   80100c40 <cprintf>
80105372:	8b 43 18             	mov    0x18(%ebx),%eax
80105375:	83 c4 10             	add    $0x10,%esp
80105378:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
8010537f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105382:	c9                   	leave
80105383:	c3                   	ret
80105384:	66 90                	xchg   %ax,%ax
80105386:	66 90                	xchg   %ax,%ax
80105388:	66 90                	xchg   %ax,%ax
8010538a:	66 90                	xchg   %ax,%ax
8010538c:	66 90                	xchg   %ax,%ax
8010538e:	66 90                	xchg   %ax,%ax

80105390 <create>:
80105390:	55                   	push   %ebp
80105391:	89 e5                	mov    %esp,%ebp
80105393:	57                   	push   %edi
80105394:	56                   	push   %esi
80105395:	8d 7d da             	lea    -0x26(%ebp),%edi
80105398:	53                   	push   %ebx
80105399:	83 ec 34             	sub    $0x34,%esp
8010539c:	89 4d d0             	mov    %ecx,-0x30(%ebp)
8010539f:	8b 4d 08             	mov    0x8(%ebp),%ecx
801053a2:	89 55 d4             	mov    %edx,-0x2c(%ebp)
801053a5:	89 4d cc             	mov    %ecx,-0x34(%ebp)
801053a8:	57                   	push   %edi
801053a9:	50                   	push   %eax
801053aa:	e8 71 d5 ff ff       	call   80102920 <nameiparent>
801053af:	83 c4 10             	add    $0x10,%esp
801053b2:	85 c0                	test   %eax,%eax
801053b4:	74 5e                	je     80105414 <create+0x84>
801053b6:	83 ec 0c             	sub    $0xc,%esp
801053b9:	89 c3                	mov    %eax,%ebx
801053bb:	50                   	push   %eax
801053bc:	e8 5f cc ff ff       	call   80102020 <ilock>
801053c1:	83 c4 0c             	add    $0xc,%esp
801053c4:	6a 00                	push   $0x0
801053c6:	57                   	push   %edi
801053c7:	53                   	push   %ebx
801053c8:	e8 a3 d1 ff ff       	call   80102570 <dirlookup>
801053cd:	83 c4 10             	add    $0x10,%esp
801053d0:	89 c6                	mov    %eax,%esi
801053d2:	85 c0                	test   %eax,%eax
801053d4:	74 4a                	je     80105420 <create+0x90>
801053d6:	83 ec 0c             	sub    $0xc,%esp
801053d9:	53                   	push   %ebx
801053da:	e8 d1 ce ff ff       	call   801022b0 <iunlockput>
801053df:	89 34 24             	mov    %esi,(%esp)
801053e2:	e8 39 cc ff ff       	call   80102020 <ilock>
801053e7:	83 c4 10             	add    $0x10,%esp
801053ea:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
801053ef:	75 17                	jne    80105408 <create+0x78>
801053f1:	66 83 7e 50 02       	cmpw   $0x2,0x50(%esi)
801053f6:	75 10                	jne    80105408 <create+0x78>
801053f8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801053fb:	89 f0                	mov    %esi,%eax
801053fd:	5b                   	pop    %ebx
801053fe:	5e                   	pop    %esi
801053ff:	5f                   	pop    %edi
80105400:	5d                   	pop    %ebp
80105401:	c3                   	ret
80105402:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105408:	83 ec 0c             	sub    $0xc,%esp
8010540b:	56                   	push   %esi
8010540c:	e8 9f ce ff ff       	call   801022b0 <iunlockput>
80105411:	83 c4 10             	add    $0x10,%esp
80105414:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105417:	31 f6                	xor    %esi,%esi
80105419:	5b                   	pop    %ebx
8010541a:	89 f0                	mov    %esi,%eax
8010541c:	5e                   	pop    %esi
8010541d:	5f                   	pop    %edi
8010541e:	5d                   	pop    %ebp
8010541f:	c3                   	ret
80105420:	0f bf 45 d4          	movswl -0x2c(%ebp),%eax
80105424:	83 ec 08             	sub    $0x8,%esp
80105427:	50                   	push   %eax
80105428:	ff 33                	push   (%ebx)
8010542a:	e8 81 ca ff ff       	call   80101eb0 <ialloc>
8010542f:	83 c4 10             	add    $0x10,%esp
80105432:	89 c6                	mov    %eax,%esi
80105434:	85 c0                	test   %eax,%eax
80105436:	0f 84 bc 00 00 00    	je     801054f8 <create+0x168>
8010543c:	83 ec 0c             	sub    $0xc,%esp
8010543f:	50                   	push   %eax
80105440:	e8 db cb ff ff       	call   80102020 <ilock>
80105445:	0f b7 45 d0          	movzwl -0x30(%ebp),%eax
80105449:	66 89 46 52          	mov    %ax,0x52(%esi)
8010544d:	0f b7 45 cc          	movzwl -0x34(%ebp),%eax
80105451:	66 89 46 54          	mov    %ax,0x54(%esi)
80105455:	b8 01 00 00 00       	mov    $0x1,%eax
8010545a:	66 89 46 56          	mov    %ax,0x56(%esi)
8010545e:	89 34 24             	mov    %esi,(%esp)
80105461:	e8 0a cb ff ff       	call   80101f70 <iupdate>
80105466:	83 c4 10             	add    $0x10,%esp
80105469:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
8010546e:	74 30                	je     801054a0 <create+0x110>
80105470:	83 ec 04             	sub    $0x4,%esp
80105473:	ff 76 04             	push   0x4(%esi)
80105476:	57                   	push   %edi
80105477:	53                   	push   %ebx
80105478:	e8 c3 d3 ff ff       	call   80102840 <dirlink>
8010547d:	83 c4 10             	add    $0x10,%esp
80105480:	85 c0                	test   %eax,%eax
80105482:	78 67                	js     801054eb <create+0x15b>
80105484:	83 ec 0c             	sub    $0xc,%esp
80105487:	53                   	push   %ebx
80105488:	e8 23 ce ff ff       	call   801022b0 <iunlockput>
8010548d:	83 c4 10             	add    $0x10,%esp
80105490:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105493:	89 f0                	mov    %esi,%eax
80105495:	5b                   	pop    %ebx
80105496:	5e                   	pop    %esi
80105497:	5f                   	pop    %edi
80105498:	5d                   	pop    %ebp
80105499:	c3                   	ret
8010549a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801054a0:	83 ec 0c             	sub    $0xc,%esp
801054a3:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
801054a8:	53                   	push   %ebx
801054a9:	e8 c2 ca ff ff       	call   80101f70 <iupdate>
801054ae:	83 c4 0c             	add    $0xc,%esp
801054b1:	ff 76 04             	push   0x4(%esi)
801054b4:	68 a9 7d 10 80       	push   $0x80107da9
801054b9:	56                   	push   %esi
801054ba:	e8 81 d3 ff ff       	call   80102840 <dirlink>
801054bf:	83 c4 10             	add    $0x10,%esp
801054c2:	85 c0                	test   %eax,%eax
801054c4:	78 18                	js     801054de <create+0x14e>
801054c6:	83 ec 04             	sub    $0x4,%esp
801054c9:	ff 73 04             	push   0x4(%ebx)
801054cc:	68 a8 7d 10 80       	push   $0x80107da8
801054d1:	56                   	push   %esi
801054d2:	e8 69 d3 ff ff       	call   80102840 <dirlink>
801054d7:	83 c4 10             	add    $0x10,%esp
801054da:	85 c0                	test   %eax,%eax
801054dc:	79 92                	jns    80105470 <create+0xe0>
801054de:	83 ec 0c             	sub    $0xc,%esp
801054e1:	68 9c 7d 10 80       	push   $0x80107d9c
801054e6:	e8 b5 ae ff ff       	call   801003a0 <panic>
801054eb:	83 ec 0c             	sub    $0xc,%esp
801054ee:	68 ab 7d 10 80       	push   $0x80107dab
801054f3:	e8 a8 ae ff ff       	call   801003a0 <panic>
801054f8:	83 ec 0c             	sub    $0xc,%esp
801054fb:	68 8d 7d 10 80       	push   $0x80107d8d
80105500:	e8 9b ae ff ff       	call   801003a0 <panic>
80105505:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010550c:	00 
8010550d:	8d 76 00             	lea    0x0(%esi),%esi

80105510 <sys_dup>:
80105510:	55                   	push   %ebp
80105511:	89 e5                	mov    %esp,%ebp
80105513:	56                   	push   %esi
80105514:	53                   	push   %ebx
80105515:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105518:	83 ec 18             	sub    $0x18,%esp
8010551b:	50                   	push   %eax
8010551c:	6a 00                	push   $0x0
8010551e:	e8 bd fc ff ff       	call   801051e0 <argint>
80105523:	83 c4 10             	add    $0x10,%esp
80105526:	85 c0                	test   %eax,%eax
80105528:	78 36                	js     80105560 <sys_dup+0x50>
8010552a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010552e:	77 30                	ja     80105560 <sys_dup+0x50>
80105530:	e8 bb ec ff ff       	call   801041f0 <myproc>
80105535:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105538:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010553c:	85 f6                	test   %esi,%esi
8010553e:	74 20                	je     80105560 <sys_dup+0x50>
80105540:	e8 ab ec ff ff       	call   801041f0 <myproc>
80105545:	31 db                	xor    %ebx,%ebx
80105547:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010554e:	00 
8010554f:	90                   	nop
80105550:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105554:	85 d2                	test   %edx,%edx
80105556:	74 18                	je     80105570 <sys_dup+0x60>
80105558:	83 c3 01             	add    $0x1,%ebx
8010555b:	83 fb 10             	cmp    $0x10,%ebx
8010555e:	75 f0                	jne    80105550 <sys_dup+0x40>
80105560:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105563:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105568:	89 d8                	mov    %ebx,%eax
8010556a:	5b                   	pop    %ebx
8010556b:	5e                   	pop    %esi
8010556c:	5d                   	pop    %ebp
8010556d:	c3                   	ret
8010556e:	66 90                	xchg   %ax,%ax
80105570:	83 ec 0c             	sub    $0xc,%esp
80105573:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
80105577:	56                   	push   %esi
80105578:	e8 c3 c1 ff ff       	call   80101740 <filedup>
8010557d:	83 c4 10             	add    $0x10,%esp
80105580:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105583:	89 d8                	mov    %ebx,%eax
80105585:	5b                   	pop    %ebx
80105586:	5e                   	pop    %esi
80105587:	5d                   	pop    %ebp
80105588:	c3                   	ret
80105589:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105590 <sys_read>:
80105590:	55                   	push   %ebp
80105591:	89 e5                	mov    %esp,%ebp
80105593:	56                   	push   %esi
80105594:	53                   	push   %ebx
80105595:	8d 5d f4             	lea    -0xc(%ebp),%ebx
80105598:	83 ec 18             	sub    $0x18,%esp
8010559b:	53                   	push   %ebx
8010559c:	6a 00                	push   $0x0
8010559e:	e8 3d fc ff ff       	call   801051e0 <argint>
801055a3:	83 c4 10             	add    $0x10,%esp
801055a6:	85 c0                	test   %eax,%eax
801055a8:	78 5e                	js     80105608 <sys_read+0x78>
801055aa:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801055ae:	77 58                	ja     80105608 <sys_read+0x78>
801055b0:	e8 3b ec ff ff       	call   801041f0 <myproc>
801055b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801055b8:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
801055bc:	85 f6                	test   %esi,%esi
801055be:	74 48                	je     80105608 <sys_read+0x78>
801055c0:	83 ec 08             	sub    $0x8,%esp
801055c3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801055c6:	50                   	push   %eax
801055c7:	6a 02                	push   $0x2
801055c9:	e8 12 fc ff ff       	call   801051e0 <argint>
801055ce:	83 c4 10             	add    $0x10,%esp
801055d1:	85 c0                	test   %eax,%eax
801055d3:	78 33                	js     80105608 <sys_read+0x78>
801055d5:	83 ec 04             	sub    $0x4,%esp
801055d8:	ff 75 f0             	push   -0x10(%ebp)
801055db:	53                   	push   %ebx
801055dc:	6a 01                	push   $0x1
801055de:	e8 4d fc ff ff       	call   80105230 <argptr>
801055e3:	83 c4 10             	add    $0x10,%esp
801055e6:	85 c0                	test   %eax,%eax
801055e8:	78 1e                	js     80105608 <sys_read+0x78>
801055ea:	83 ec 04             	sub    $0x4,%esp
801055ed:	ff 75 f0             	push   -0x10(%ebp)
801055f0:	ff 75 f4             	push   -0xc(%ebp)
801055f3:	56                   	push   %esi
801055f4:	e8 c7 c2 ff ff       	call   801018c0 <fileread>
801055f9:	83 c4 10             	add    $0x10,%esp
801055fc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801055ff:	5b                   	pop    %ebx
80105600:	5e                   	pop    %esi
80105601:	5d                   	pop    %ebp
80105602:	c3                   	ret
80105603:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105608:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010560d:	eb ed                	jmp    801055fc <sys_read+0x6c>
8010560f:	90                   	nop

80105610 <sys_write>:
80105610:	55                   	push   %ebp
80105611:	89 e5                	mov    %esp,%ebp
80105613:	56                   	push   %esi
80105614:	53                   	push   %ebx
80105615:	8d 5d f4             	lea    -0xc(%ebp),%ebx
80105618:	83 ec 18             	sub    $0x18,%esp
8010561b:	53                   	push   %ebx
8010561c:	6a 00                	push   $0x0
8010561e:	e8 bd fb ff ff       	call   801051e0 <argint>
80105623:	83 c4 10             	add    $0x10,%esp
80105626:	85 c0                	test   %eax,%eax
80105628:	78 5e                	js     80105688 <sys_write+0x78>
8010562a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010562e:	77 58                	ja     80105688 <sys_write+0x78>
80105630:	e8 bb eb ff ff       	call   801041f0 <myproc>
80105635:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105638:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010563c:	85 f6                	test   %esi,%esi
8010563e:	74 48                	je     80105688 <sys_write+0x78>
80105640:	83 ec 08             	sub    $0x8,%esp
80105643:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105646:	50                   	push   %eax
80105647:	6a 02                	push   $0x2
80105649:	e8 92 fb ff ff       	call   801051e0 <argint>
8010564e:	83 c4 10             	add    $0x10,%esp
80105651:	85 c0                	test   %eax,%eax
80105653:	78 33                	js     80105688 <sys_write+0x78>
80105655:	83 ec 04             	sub    $0x4,%esp
80105658:	ff 75 f0             	push   -0x10(%ebp)
8010565b:	53                   	push   %ebx
8010565c:	6a 01                	push   $0x1
8010565e:	e8 cd fb ff ff       	call   80105230 <argptr>
80105663:	83 c4 10             	add    $0x10,%esp
80105666:	85 c0                	test   %eax,%eax
80105668:	78 1e                	js     80105688 <sys_write+0x78>
8010566a:	83 ec 04             	sub    $0x4,%esp
8010566d:	ff 75 f0             	push   -0x10(%ebp)
80105670:	ff 75 f4             	push   -0xc(%ebp)
80105673:	56                   	push   %esi
80105674:	e8 d7 c2 ff ff       	call   80101950 <filewrite>
80105679:	83 c4 10             	add    $0x10,%esp
8010567c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010567f:	5b                   	pop    %ebx
80105680:	5e                   	pop    %esi
80105681:	5d                   	pop    %ebp
80105682:	c3                   	ret
80105683:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105688:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010568d:	eb ed                	jmp    8010567c <sys_write+0x6c>
8010568f:	90                   	nop

80105690 <sys_close>:
80105690:	55                   	push   %ebp
80105691:	89 e5                	mov    %esp,%ebp
80105693:	56                   	push   %esi
80105694:	53                   	push   %ebx
80105695:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105698:	83 ec 18             	sub    $0x18,%esp
8010569b:	50                   	push   %eax
8010569c:	6a 00                	push   $0x0
8010569e:	e8 3d fb ff ff       	call   801051e0 <argint>
801056a3:	83 c4 10             	add    $0x10,%esp
801056a6:	85 c0                	test   %eax,%eax
801056a8:	78 3e                	js     801056e8 <sys_close+0x58>
801056aa:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801056ae:	77 38                	ja     801056e8 <sys_close+0x58>
801056b0:	e8 3b eb ff ff       	call   801041f0 <myproc>
801056b5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801056b8:	8d 5a 08             	lea    0x8(%edx),%ebx
801056bb:	8b 74 98 08          	mov    0x8(%eax,%ebx,4),%esi
801056bf:	85 f6                	test   %esi,%esi
801056c1:	74 25                	je     801056e8 <sys_close+0x58>
801056c3:	e8 28 eb ff ff       	call   801041f0 <myproc>
801056c8:	83 ec 0c             	sub    $0xc,%esp
801056cb:	c7 44 98 08 00 00 00 	movl   $0x0,0x8(%eax,%ebx,4)
801056d2:	00 
801056d3:	56                   	push   %esi
801056d4:	e8 b7 c0 ff ff       	call   80101790 <fileclose>
801056d9:	83 c4 10             	add    $0x10,%esp
801056dc:	31 c0                	xor    %eax,%eax
801056de:	8d 65 f8             	lea    -0x8(%ebp),%esp
801056e1:	5b                   	pop    %ebx
801056e2:	5e                   	pop    %esi
801056e3:	5d                   	pop    %ebp
801056e4:	c3                   	ret
801056e5:	8d 76 00             	lea    0x0(%esi),%esi
801056e8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801056ed:	eb ef                	jmp    801056de <sys_close+0x4e>
801056ef:	90                   	nop

801056f0 <sys_fstat>:
801056f0:	55                   	push   %ebp
801056f1:	89 e5                	mov    %esp,%ebp
801056f3:	56                   	push   %esi
801056f4:	53                   	push   %ebx
801056f5:	8d 5d f4             	lea    -0xc(%ebp),%ebx
801056f8:	83 ec 18             	sub    $0x18,%esp
801056fb:	53                   	push   %ebx
801056fc:	6a 00                	push   $0x0
801056fe:	e8 dd fa ff ff       	call   801051e0 <argint>
80105703:	83 c4 10             	add    $0x10,%esp
80105706:	85 c0                	test   %eax,%eax
80105708:	78 46                	js     80105750 <sys_fstat+0x60>
8010570a:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
8010570e:	77 40                	ja     80105750 <sys_fstat+0x60>
80105710:	e8 db ea ff ff       	call   801041f0 <myproc>
80105715:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105718:	8b 74 90 28          	mov    0x28(%eax,%edx,4),%esi
8010571c:	85 f6                	test   %esi,%esi
8010571e:	74 30                	je     80105750 <sys_fstat+0x60>
80105720:	83 ec 04             	sub    $0x4,%esp
80105723:	6a 14                	push   $0x14
80105725:	53                   	push   %ebx
80105726:	6a 01                	push   $0x1
80105728:	e8 03 fb ff ff       	call   80105230 <argptr>
8010572d:	83 c4 10             	add    $0x10,%esp
80105730:	85 c0                	test   %eax,%eax
80105732:	78 1c                	js     80105750 <sys_fstat+0x60>
80105734:	83 ec 08             	sub    $0x8,%esp
80105737:	ff 75 f4             	push   -0xc(%ebp)
8010573a:	56                   	push   %esi
8010573b:	e8 30 c1 ff ff       	call   80101870 <filestat>
80105740:	83 c4 10             	add    $0x10,%esp
80105743:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105746:	5b                   	pop    %ebx
80105747:	5e                   	pop    %esi
80105748:	5d                   	pop    %ebp
80105749:	c3                   	ret
8010574a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105750:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105755:	eb ec                	jmp    80105743 <sys_fstat+0x53>
80105757:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010575e:	00 
8010575f:	90                   	nop

80105760 <sys_link>:
80105760:	55                   	push   %ebp
80105761:	89 e5                	mov    %esp,%ebp
80105763:	57                   	push   %edi
80105764:	56                   	push   %esi
80105765:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80105768:	53                   	push   %ebx
80105769:	83 ec 34             	sub    $0x34,%esp
8010576c:	50                   	push   %eax
8010576d:	6a 00                	push   $0x0
8010576f:	e8 2c fb ff ff       	call   801052a0 <argstr>
80105774:	83 c4 10             	add    $0x10,%esp
80105777:	85 c0                	test   %eax,%eax
80105779:	0f 88 fb 00 00 00    	js     8010587a <sys_link+0x11a>
8010577f:	83 ec 08             	sub    $0x8,%esp
80105782:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105785:	50                   	push   %eax
80105786:	6a 01                	push   $0x1
80105788:	e8 13 fb ff ff       	call   801052a0 <argstr>
8010578d:	83 c4 10             	add    $0x10,%esp
80105790:	85 c0                	test   %eax,%eax
80105792:	0f 88 e2 00 00 00    	js     8010587a <sys_link+0x11a>
80105798:	e8 33 de ff ff       	call   801035d0 <begin_op>
8010579d:	83 ec 0c             	sub    $0xc,%esp
801057a0:	ff 75 d4             	push   -0x2c(%ebp)
801057a3:	e8 58 d1 ff ff       	call   80102900 <namei>
801057a8:	83 c4 10             	add    $0x10,%esp
801057ab:	89 c3                	mov    %eax,%ebx
801057ad:	85 c0                	test   %eax,%eax
801057af:	0f 84 df 00 00 00    	je     80105894 <sys_link+0x134>
801057b5:	83 ec 0c             	sub    $0xc,%esp
801057b8:	50                   	push   %eax
801057b9:	e8 62 c8 ff ff       	call   80102020 <ilock>
801057be:	83 c4 10             	add    $0x10,%esp
801057c1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801057c6:	0f 84 b5 00 00 00    	je     80105881 <sys_link+0x121>
801057cc:	83 ec 0c             	sub    $0xc,%esp
801057cf:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
801057d4:	8d 7d da             	lea    -0x26(%ebp),%edi
801057d7:	53                   	push   %ebx
801057d8:	e8 93 c7 ff ff       	call   80101f70 <iupdate>
801057dd:	89 1c 24             	mov    %ebx,(%esp)
801057e0:	e8 1b c9 ff ff       	call   80102100 <iunlock>
801057e5:	58                   	pop    %eax
801057e6:	5a                   	pop    %edx
801057e7:	57                   	push   %edi
801057e8:	ff 75 d0             	push   -0x30(%ebp)
801057eb:	e8 30 d1 ff ff       	call   80102920 <nameiparent>
801057f0:	83 c4 10             	add    $0x10,%esp
801057f3:	89 c6                	mov    %eax,%esi
801057f5:	85 c0                	test   %eax,%eax
801057f7:	74 5b                	je     80105854 <sys_link+0xf4>
801057f9:	83 ec 0c             	sub    $0xc,%esp
801057fc:	50                   	push   %eax
801057fd:	e8 1e c8 ff ff       	call   80102020 <ilock>
80105802:	8b 03                	mov    (%ebx),%eax
80105804:	83 c4 10             	add    $0x10,%esp
80105807:	39 06                	cmp    %eax,(%esi)
80105809:	75 3d                	jne    80105848 <sys_link+0xe8>
8010580b:	83 ec 04             	sub    $0x4,%esp
8010580e:	ff 73 04             	push   0x4(%ebx)
80105811:	57                   	push   %edi
80105812:	56                   	push   %esi
80105813:	e8 28 d0 ff ff       	call   80102840 <dirlink>
80105818:	83 c4 10             	add    $0x10,%esp
8010581b:	85 c0                	test   %eax,%eax
8010581d:	78 29                	js     80105848 <sys_link+0xe8>
8010581f:	83 ec 0c             	sub    $0xc,%esp
80105822:	56                   	push   %esi
80105823:	e8 88 ca ff ff       	call   801022b0 <iunlockput>
80105828:	89 1c 24             	mov    %ebx,(%esp)
8010582b:	e8 20 c9 ff ff       	call   80102150 <iput>
80105830:	e8 0b de ff ff       	call   80103640 <end_op>
80105835:	83 c4 10             	add    $0x10,%esp
80105838:	31 c0                	xor    %eax,%eax
8010583a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010583d:	5b                   	pop    %ebx
8010583e:	5e                   	pop    %esi
8010583f:	5f                   	pop    %edi
80105840:	5d                   	pop    %ebp
80105841:	c3                   	ret
80105842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105848:	83 ec 0c             	sub    $0xc,%esp
8010584b:	56                   	push   %esi
8010584c:	e8 5f ca ff ff       	call   801022b0 <iunlockput>
80105851:	83 c4 10             	add    $0x10,%esp
80105854:	83 ec 0c             	sub    $0xc,%esp
80105857:	53                   	push   %ebx
80105858:	e8 c3 c7 ff ff       	call   80102020 <ilock>
8010585d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
80105862:	89 1c 24             	mov    %ebx,(%esp)
80105865:	e8 06 c7 ff ff       	call   80101f70 <iupdate>
8010586a:	89 1c 24             	mov    %ebx,(%esp)
8010586d:	e8 3e ca ff ff       	call   801022b0 <iunlockput>
80105872:	e8 c9 dd ff ff       	call   80103640 <end_op>
80105877:	83 c4 10             	add    $0x10,%esp
8010587a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010587f:	eb b9                	jmp    8010583a <sys_link+0xda>
80105881:	83 ec 0c             	sub    $0xc,%esp
80105884:	53                   	push   %ebx
80105885:	e8 26 ca ff ff       	call   801022b0 <iunlockput>
8010588a:	e8 b1 dd ff ff       	call   80103640 <end_op>
8010588f:	83 c4 10             	add    $0x10,%esp
80105892:	eb e6                	jmp    8010587a <sys_link+0x11a>
80105894:	e8 a7 dd ff ff       	call   80103640 <end_op>
80105899:	eb df                	jmp    8010587a <sys_link+0x11a>
8010589b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801058a0 <sys_unlink>:
801058a0:	55                   	push   %ebp
801058a1:	89 e5                	mov    %esp,%ebp
801058a3:	57                   	push   %edi
801058a4:	56                   	push   %esi
801058a5:	8d 45 c0             	lea    -0x40(%ebp),%eax
801058a8:	53                   	push   %ebx
801058a9:	83 ec 54             	sub    $0x54,%esp
801058ac:	50                   	push   %eax
801058ad:	6a 00                	push   $0x0
801058af:	e8 ec f9 ff ff       	call   801052a0 <argstr>
801058b4:	83 c4 10             	add    $0x10,%esp
801058b7:	85 c0                	test   %eax,%eax
801058b9:	0f 88 54 01 00 00    	js     80105a13 <sys_unlink+0x173>
801058bf:	e8 0c dd ff ff       	call   801035d0 <begin_op>
801058c4:	8d 5d ca             	lea    -0x36(%ebp),%ebx
801058c7:	83 ec 08             	sub    $0x8,%esp
801058ca:	53                   	push   %ebx
801058cb:	ff 75 c0             	push   -0x40(%ebp)
801058ce:	e8 4d d0 ff ff       	call   80102920 <nameiparent>
801058d3:	83 c4 10             	add    $0x10,%esp
801058d6:	89 45 b4             	mov    %eax,-0x4c(%ebp)
801058d9:	85 c0                	test   %eax,%eax
801058db:	0f 84 58 01 00 00    	je     80105a39 <sys_unlink+0x199>
801058e1:	8b 7d b4             	mov    -0x4c(%ebp),%edi
801058e4:	83 ec 0c             	sub    $0xc,%esp
801058e7:	57                   	push   %edi
801058e8:	e8 33 c7 ff ff       	call   80102020 <ilock>
801058ed:	58                   	pop    %eax
801058ee:	5a                   	pop    %edx
801058ef:	68 a9 7d 10 80       	push   $0x80107da9
801058f4:	53                   	push   %ebx
801058f5:	e8 56 cc ff ff       	call   80102550 <namecmp>
801058fa:	83 c4 10             	add    $0x10,%esp
801058fd:	85 c0                	test   %eax,%eax
801058ff:	0f 84 fb 00 00 00    	je     80105a00 <sys_unlink+0x160>
80105905:	83 ec 08             	sub    $0x8,%esp
80105908:	68 a8 7d 10 80       	push   $0x80107da8
8010590d:	53                   	push   %ebx
8010590e:	e8 3d cc ff ff       	call   80102550 <namecmp>
80105913:	83 c4 10             	add    $0x10,%esp
80105916:	85 c0                	test   %eax,%eax
80105918:	0f 84 e2 00 00 00    	je     80105a00 <sys_unlink+0x160>
8010591e:	83 ec 04             	sub    $0x4,%esp
80105921:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105924:	50                   	push   %eax
80105925:	53                   	push   %ebx
80105926:	57                   	push   %edi
80105927:	e8 44 cc ff ff       	call   80102570 <dirlookup>
8010592c:	83 c4 10             	add    $0x10,%esp
8010592f:	89 c3                	mov    %eax,%ebx
80105931:	85 c0                	test   %eax,%eax
80105933:	0f 84 c7 00 00 00    	je     80105a00 <sys_unlink+0x160>
80105939:	83 ec 0c             	sub    $0xc,%esp
8010593c:	50                   	push   %eax
8010593d:	e8 de c6 ff ff       	call   80102020 <ilock>
80105942:	83 c4 10             	add    $0x10,%esp
80105945:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
8010594a:	0f 8e 0a 01 00 00    	jle    80105a5a <sys_unlink+0x1ba>
80105950:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105955:	8d 7d d8             	lea    -0x28(%ebp),%edi
80105958:	74 66                	je     801059c0 <sys_unlink+0x120>
8010595a:	83 ec 04             	sub    $0x4,%esp
8010595d:	6a 10                	push   $0x10
8010595f:	6a 00                	push   $0x0
80105961:	57                   	push   %edi
80105962:	e8 c9 f5 ff ff       	call   80104f30 <memset>
80105967:	6a 10                	push   $0x10
80105969:	ff 75 c4             	push   -0x3c(%ebp)
8010596c:	57                   	push   %edi
8010596d:	ff 75 b4             	push   -0x4c(%ebp)
80105970:	e8 bb ca ff ff       	call   80102430 <writei>
80105975:	83 c4 20             	add    $0x20,%esp
80105978:	83 f8 10             	cmp    $0x10,%eax
8010597b:	0f 85 cc 00 00 00    	jne    80105a4d <sys_unlink+0x1ad>
80105981:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105986:	0f 84 94 00 00 00    	je     80105a20 <sys_unlink+0x180>
8010598c:	83 ec 0c             	sub    $0xc,%esp
8010598f:	ff 75 b4             	push   -0x4c(%ebp)
80105992:	e8 19 c9 ff ff       	call   801022b0 <iunlockput>
80105997:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
8010599c:	89 1c 24             	mov    %ebx,(%esp)
8010599f:	e8 cc c5 ff ff       	call   80101f70 <iupdate>
801059a4:	89 1c 24             	mov    %ebx,(%esp)
801059a7:	e8 04 c9 ff ff       	call   801022b0 <iunlockput>
801059ac:	e8 8f dc ff ff       	call   80103640 <end_op>
801059b1:	83 c4 10             	add    $0x10,%esp
801059b4:	31 c0                	xor    %eax,%eax
801059b6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801059b9:	5b                   	pop    %ebx
801059ba:	5e                   	pop    %esi
801059bb:	5f                   	pop    %edi
801059bc:	5d                   	pop    %ebp
801059bd:	c3                   	ret
801059be:	66 90                	xchg   %ax,%ax
801059c0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801059c4:	76 94                	jbe    8010595a <sys_unlink+0xba>
801059c6:	be 20 00 00 00       	mov    $0x20,%esi
801059cb:	eb 0b                	jmp    801059d8 <sys_unlink+0x138>
801059cd:	8d 76 00             	lea    0x0(%esi),%esi
801059d0:	83 c6 10             	add    $0x10,%esi
801059d3:	3b 73 58             	cmp    0x58(%ebx),%esi
801059d6:	73 82                	jae    8010595a <sys_unlink+0xba>
801059d8:	6a 10                	push   $0x10
801059da:	56                   	push   %esi
801059db:	57                   	push   %edi
801059dc:	53                   	push   %ebx
801059dd:	e8 4e c9 ff ff       	call   80102330 <readi>
801059e2:	83 c4 10             	add    $0x10,%esp
801059e5:	83 f8 10             	cmp    $0x10,%eax
801059e8:	75 56                	jne    80105a40 <sys_unlink+0x1a0>
801059ea:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801059ef:	74 df                	je     801059d0 <sys_unlink+0x130>
801059f1:	83 ec 0c             	sub    $0xc,%esp
801059f4:	53                   	push   %ebx
801059f5:	e8 b6 c8 ff ff       	call   801022b0 <iunlockput>
801059fa:	83 c4 10             	add    $0x10,%esp
801059fd:	8d 76 00             	lea    0x0(%esi),%esi
80105a00:	83 ec 0c             	sub    $0xc,%esp
80105a03:	ff 75 b4             	push   -0x4c(%ebp)
80105a06:	e8 a5 c8 ff ff       	call   801022b0 <iunlockput>
80105a0b:	e8 30 dc ff ff       	call   80103640 <end_op>
80105a10:	83 c4 10             	add    $0x10,%esp
80105a13:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a18:	eb 9c                	jmp    801059b6 <sys_unlink+0x116>
80105a1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105a20:	8b 45 b4             	mov    -0x4c(%ebp),%eax
80105a23:	83 ec 0c             	sub    $0xc,%esp
80105a26:	66 83 68 56 01       	subw   $0x1,0x56(%eax)
80105a2b:	50                   	push   %eax
80105a2c:	e8 3f c5 ff ff       	call   80101f70 <iupdate>
80105a31:	83 c4 10             	add    $0x10,%esp
80105a34:	e9 53 ff ff ff       	jmp    8010598c <sys_unlink+0xec>
80105a39:	e8 02 dc ff ff       	call   80103640 <end_op>
80105a3e:	eb d3                	jmp    80105a13 <sys_unlink+0x173>
80105a40:	83 ec 0c             	sub    $0xc,%esp
80105a43:	68 cd 7d 10 80       	push   $0x80107dcd
80105a48:	e8 53 a9 ff ff       	call   801003a0 <panic>
80105a4d:	83 ec 0c             	sub    $0xc,%esp
80105a50:	68 df 7d 10 80       	push   $0x80107ddf
80105a55:	e8 46 a9 ff ff       	call   801003a0 <panic>
80105a5a:	83 ec 0c             	sub    $0xc,%esp
80105a5d:	68 bb 7d 10 80       	push   $0x80107dbb
80105a62:	e8 39 a9 ff ff       	call   801003a0 <panic>
80105a67:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105a6e:	00 
80105a6f:	90                   	nop

80105a70 <sys_open>:
80105a70:	55                   	push   %ebp
80105a71:	89 e5                	mov    %esp,%ebp
80105a73:	57                   	push   %edi
80105a74:	56                   	push   %esi
80105a75:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105a78:	53                   	push   %ebx
80105a79:	83 ec 24             	sub    $0x24,%esp
80105a7c:	50                   	push   %eax
80105a7d:	6a 00                	push   $0x0
80105a7f:	e8 1c f8 ff ff       	call   801052a0 <argstr>
80105a84:	83 c4 10             	add    $0x10,%esp
80105a87:	85 c0                	test   %eax,%eax
80105a89:	0f 88 8e 00 00 00    	js     80105b1d <sys_open+0xad>
80105a8f:	83 ec 08             	sub    $0x8,%esp
80105a92:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105a95:	50                   	push   %eax
80105a96:	6a 01                	push   $0x1
80105a98:	e8 43 f7 ff ff       	call   801051e0 <argint>
80105a9d:	83 c4 10             	add    $0x10,%esp
80105aa0:	85 c0                	test   %eax,%eax
80105aa2:	78 79                	js     80105b1d <sys_open+0xad>
80105aa4:	e8 27 db ff ff       	call   801035d0 <begin_op>
80105aa9:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
80105aad:	75 79                	jne    80105b28 <sys_open+0xb8>
80105aaf:	83 ec 0c             	sub    $0xc,%esp
80105ab2:	ff 75 e0             	push   -0x20(%ebp)
80105ab5:	e8 46 ce ff ff       	call   80102900 <namei>
80105aba:	83 c4 10             	add    $0x10,%esp
80105abd:	89 c6                	mov    %eax,%esi
80105abf:	85 c0                	test   %eax,%eax
80105ac1:	0f 84 7e 00 00 00    	je     80105b45 <sys_open+0xd5>
80105ac7:	83 ec 0c             	sub    $0xc,%esp
80105aca:	50                   	push   %eax
80105acb:	e8 50 c5 ff ff       	call   80102020 <ilock>
80105ad0:	83 c4 10             	add    $0x10,%esp
80105ad3:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80105ad8:	0f 84 ba 00 00 00    	je     80105b98 <sys_open+0x128>
80105ade:	e8 ed bb ff ff       	call   801016d0 <filealloc>
80105ae3:	89 c7                	mov    %eax,%edi
80105ae5:	85 c0                	test   %eax,%eax
80105ae7:	74 23                	je     80105b0c <sys_open+0x9c>
80105ae9:	e8 02 e7 ff ff       	call   801041f0 <myproc>
80105aee:	31 db                	xor    %ebx,%ebx
80105af0:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105af4:	85 d2                	test   %edx,%edx
80105af6:	74 58                	je     80105b50 <sys_open+0xe0>
80105af8:	83 c3 01             	add    $0x1,%ebx
80105afb:	83 fb 10             	cmp    $0x10,%ebx
80105afe:	75 f0                	jne    80105af0 <sys_open+0x80>
80105b00:	83 ec 0c             	sub    $0xc,%esp
80105b03:	57                   	push   %edi
80105b04:	e8 87 bc ff ff       	call   80101790 <fileclose>
80105b09:	83 c4 10             	add    $0x10,%esp
80105b0c:	83 ec 0c             	sub    $0xc,%esp
80105b0f:	56                   	push   %esi
80105b10:	e8 9b c7 ff ff       	call   801022b0 <iunlockput>
80105b15:	e8 26 db ff ff       	call   80103640 <end_op>
80105b1a:	83 c4 10             	add    $0x10,%esp
80105b1d:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105b22:	eb 65                	jmp    80105b89 <sys_open+0x119>
80105b24:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b28:	83 ec 0c             	sub    $0xc,%esp
80105b2b:	31 c9                	xor    %ecx,%ecx
80105b2d:	ba 02 00 00 00       	mov    $0x2,%edx
80105b32:	6a 00                	push   $0x0
80105b34:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105b37:	e8 54 f8 ff ff       	call   80105390 <create>
80105b3c:	83 c4 10             	add    $0x10,%esp
80105b3f:	89 c6                	mov    %eax,%esi
80105b41:	85 c0                	test   %eax,%eax
80105b43:	75 99                	jne    80105ade <sys_open+0x6e>
80105b45:	e8 f6 da ff ff       	call   80103640 <end_op>
80105b4a:	eb d1                	jmp    80105b1d <sys_open+0xad>
80105b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105b50:	83 ec 0c             	sub    $0xc,%esp
80105b53:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
80105b57:	56                   	push   %esi
80105b58:	e8 a3 c5 ff ff       	call   80102100 <iunlock>
80105b5d:	e8 de da ff ff       	call   80103640 <end_op>
80105b62:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
80105b68:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105b6b:	83 c4 10             	add    $0x10,%esp
80105b6e:	89 77 10             	mov    %esi,0x10(%edi)
80105b71:	89 d0                	mov    %edx,%eax
80105b73:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
80105b7a:	f7 d0                	not    %eax
80105b7c:	83 e0 01             	and    $0x1,%eax
80105b7f:	83 e2 03             	and    $0x3,%edx
80105b82:	88 47 08             	mov    %al,0x8(%edi)
80105b85:	0f 95 47 09          	setne  0x9(%edi)
80105b89:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b8c:	89 d8                	mov    %ebx,%eax
80105b8e:	5b                   	pop    %ebx
80105b8f:	5e                   	pop    %esi
80105b90:	5f                   	pop    %edi
80105b91:	5d                   	pop    %ebp
80105b92:	c3                   	ret
80105b93:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105b98:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105b9b:	85 c9                	test   %ecx,%ecx
80105b9d:	0f 84 3b ff ff ff    	je     80105ade <sys_open+0x6e>
80105ba3:	e9 64 ff ff ff       	jmp    80105b0c <sys_open+0x9c>
80105ba8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105baf:	00 

80105bb0 <sys_mkdir>:
80105bb0:	55                   	push   %ebp
80105bb1:	89 e5                	mov    %esp,%ebp
80105bb3:	83 ec 18             	sub    $0x18,%esp
80105bb6:	e8 15 da ff ff       	call   801035d0 <begin_op>
80105bbb:	83 ec 08             	sub    $0x8,%esp
80105bbe:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105bc1:	50                   	push   %eax
80105bc2:	6a 00                	push   $0x0
80105bc4:	e8 d7 f6 ff ff       	call   801052a0 <argstr>
80105bc9:	83 c4 10             	add    $0x10,%esp
80105bcc:	85 c0                	test   %eax,%eax
80105bce:	78 30                	js     80105c00 <sys_mkdir+0x50>
80105bd0:	83 ec 0c             	sub    $0xc,%esp
80105bd3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bd6:	31 c9                	xor    %ecx,%ecx
80105bd8:	ba 01 00 00 00       	mov    $0x1,%edx
80105bdd:	6a 00                	push   $0x0
80105bdf:	e8 ac f7 ff ff       	call   80105390 <create>
80105be4:	83 c4 10             	add    $0x10,%esp
80105be7:	85 c0                	test   %eax,%eax
80105be9:	74 15                	je     80105c00 <sys_mkdir+0x50>
80105beb:	83 ec 0c             	sub    $0xc,%esp
80105bee:	50                   	push   %eax
80105bef:	e8 bc c6 ff ff       	call   801022b0 <iunlockput>
80105bf4:	e8 47 da ff ff       	call   80103640 <end_op>
80105bf9:	83 c4 10             	add    $0x10,%esp
80105bfc:	31 c0                	xor    %eax,%eax
80105bfe:	c9                   	leave
80105bff:	c3                   	ret
80105c00:	e8 3b da ff ff       	call   80103640 <end_op>
80105c05:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c0a:	c9                   	leave
80105c0b:	c3                   	ret
80105c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105c10 <sys_mknod>:
80105c10:	55                   	push   %ebp
80105c11:	89 e5                	mov    %esp,%ebp
80105c13:	83 ec 18             	sub    $0x18,%esp
80105c16:	e8 b5 d9 ff ff       	call   801035d0 <begin_op>
80105c1b:	83 ec 08             	sub    $0x8,%esp
80105c1e:	8d 45 ec             	lea    -0x14(%ebp),%eax
80105c21:	50                   	push   %eax
80105c22:	6a 00                	push   $0x0
80105c24:	e8 77 f6 ff ff       	call   801052a0 <argstr>
80105c29:	83 c4 10             	add    $0x10,%esp
80105c2c:	85 c0                	test   %eax,%eax
80105c2e:	78 60                	js     80105c90 <sys_mknod+0x80>
80105c30:	83 ec 08             	sub    $0x8,%esp
80105c33:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105c36:	50                   	push   %eax
80105c37:	6a 01                	push   $0x1
80105c39:	e8 a2 f5 ff ff       	call   801051e0 <argint>
80105c3e:	83 c4 10             	add    $0x10,%esp
80105c41:	85 c0                	test   %eax,%eax
80105c43:	78 4b                	js     80105c90 <sys_mknod+0x80>
80105c45:	83 ec 08             	sub    $0x8,%esp
80105c48:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105c4b:	50                   	push   %eax
80105c4c:	6a 02                	push   $0x2
80105c4e:	e8 8d f5 ff ff       	call   801051e0 <argint>
80105c53:	83 c4 10             	add    $0x10,%esp
80105c56:	85 c0                	test   %eax,%eax
80105c58:	78 36                	js     80105c90 <sys_mknod+0x80>
80105c5a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
80105c5e:	83 ec 0c             	sub    $0xc,%esp
80105c61:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
80105c65:	ba 03 00 00 00       	mov    $0x3,%edx
80105c6a:	50                   	push   %eax
80105c6b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105c6e:	e8 1d f7 ff ff       	call   80105390 <create>
80105c73:	83 c4 10             	add    $0x10,%esp
80105c76:	85 c0                	test   %eax,%eax
80105c78:	74 16                	je     80105c90 <sys_mknod+0x80>
80105c7a:	83 ec 0c             	sub    $0xc,%esp
80105c7d:	50                   	push   %eax
80105c7e:	e8 2d c6 ff ff       	call   801022b0 <iunlockput>
80105c83:	e8 b8 d9 ff ff       	call   80103640 <end_op>
80105c88:	83 c4 10             	add    $0x10,%esp
80105c8b:	31 c0                	xor    %eax,%eax
80105c8d:	c9                   	leave
80105c8e:	c3                   	ret
80105c8f:	90                   	nop
80105c90:	e8 ab d9 ff ff       	call   80103640 <end_op>
80105c95:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105c9a:	c9                   	leave
80105c9b:	c3                   	ret
80105c9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105ca0 <sys_chdir>:
80105ca0:	55                   	push   %ebp
80105ca1:	89 e5                	mov    %esp,%ebp
80105ca3:	56                   	push   %esi
80105ca4:	53                   	push   %ebx
80105ca5:	83 ec 10             	sub    $0x10,%esp
80105ca8:	e8 43 e5 ff ff       	call   801041f0 <myproc>
80105cad:	89 c6                	mov    %eax,%esi
80105caf:	e8 1c d9 ff ff       	call   801035d0 <begin_op>
80105cb4:	83 ec 08             	sub    $0x8,%esp
80105cb7:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105cba:	50                   	push   %eax
80105cbb:	6a 00                	push   $0x0
80105cbd:	e8 de f5 ff ff       	call   801052a0 <argstr>
80105cc2:	83 c4 10             	add    $0x10,%esp
80105cc5:	85 c0                	test   %eax,%eax
80105cc7:	78 77                	js     80105d40 <sys_chdir+0xa0>
80105cc9:	83 ec 0c             	sub    $0xc,%esp
80105ccc:	ff 75 f4             	push   -0xc(%ebp)
80105ccf:	e8 2c cc ff ff       	call   80102900 <namei>
80105cd4:	83 c4 10             	add    $0x10,%esp
80105cd7:	89 c3                	mov    %eax,%ebx
80105cd9:	85 c0                	test   %eax,%eax
80105cdb:	74 63                	je     80105d40 <sys_chdir+0xa0>
80105cdd:	83 ec 0c             	sub    $0xc,%esp
80105ce0:	50                   	push   %eax
80105ce1:	e8 3a c3 ff ff       	call   80102020 <ilock>
80105ce6:	83 c4 10             	add    $0x10,%esp
80105ce9:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105cee:	75 30                	jne    80105d20 <sys_chdir+0x80>
80105cf0:	83 ec 0c             	sub    $0xc,%esp
80105cf3:	53                   	push   %ebx
80105cf4:	e8 07 c4 ff ff       	call   80102100 <iunlock>
80105cf9:	58                   	pop    %eax
80105cfa:	ff 76 68             	push   0x68(%esi)
80105cfd:	e8 4e c4 ff ff       	call   80102150 <iput>
80105d02:	e8 39 d9 ff ff       	call   80103640 <end_op>
80105d07:	89 5e 68             	mov    %ebx,0x68(%esi)
80105d0a:	83 c4 10             	add    $0x10,%esp
80105d0d:	31 c0                	xor    %eax,%eax
80105d0f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105d12:	5b                   	pop    %ebx
80105d13:	5e                   	pop    %esi
80105d14:	5d                   	pop    %ebp
80105d15:	c3                   	ret
80105d16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d1d:	00 
80105d1e:	66 90                	xchg   %ax,%ax
80105d20:	83 ec 0c             	sub    $0xc,%esp
80105d23:	53                   	push   %ebx
80105d24:	e8 87 c5 ff ff       	call   801022b0 <iunlockput>
80105d29:	e8 12 d9 ff ff       	call   80103640 <end_op>
80105d2e:	83 c4 10             	add    $0x10,%esp
80105d31:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105d36:	eb d7                	jmp    80105d0f <sys_chdir+0x6f>
80105d38:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d3f:	00 
80105d40:	e8 fb d8 ff ff       	call   80103640 <end_op>
80105d45:	eb ea                	jmp    80105d31 <sys_chdir+0x91>
80105d47:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105d4e:	00 
80105d4f:	90                   	nop

80105d50 <sys_exec>:
80105d50:	55                   	push   %ebp
80105d51:	89 e5                	mov    %esp,%ebp
80105d53:	57                   	push   %edi
80105d54:	56                   	push   %esi
80105d55:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
80105d5b:	53                   	push   %ebx
80105d5c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
80105d62:	50                   	push   %eax
80105d63:	6a 00                	push   $0x0
80105d65:	e8 36 f5 ff ff       	call   801052a0 <argstr>
80105d6a:	83 c4 10             	add    $0x10,%esp
80105d6d:	85 c0                	test   %eax,%eax
80105d6f:	0f 88 87 00 00 00    	js     80105dfc <sys_exec+0xac>
80105d75:	83 ec 08             	sub    $0x8,%esp
80105d78:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
80105d7e:	50                   	push   %eax
80105d7f:	6a 01                	push   $0x1
80105d81:	e8 5a f4 ff ff       	call   801051e0 <argint>
80105d86:	83 c4 10             	add    $0x10,%esp
80105d89:	85 c0                	test   %eax,%eax
80105d8b:	78 6f                	js     80105dfc <sys_exec+0xac>
80105d8d:	83 ec 04             	sub    $0x4,%esp
80105d90:	8d b5 68 ff ff ff    	lea    -0x98(%ebp),%esi
80105d96:	31 db                	xor    %ebx,%ebx
80105d98:	68 80 00 00 00       	push   $0x80
80105d9d:	6a 00                	push   $0x0
80105d9f:	56                   	push   %esi
80105da0:	e8 8b f1 ff ff       	call   80104f30 <memset>
80105da5:	83 c4 10             	add    $0x10,%esp
80105da8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105daf:	00 
80105db0:	83 ec 08             	sub    $0x8,%esp
80105db3:	8d 85 64 ff ff ff    	lea    -0x9c(%ebp),%eax
80105db9:	8d 3c 9d 00 00 00 00 	lea    0x0(,%ebx,4),%edi
80105dc0:	50                   	push   %eax
80105dc1:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105dc7:	01 f8                	add    %edi,%eax
80105dc9:	50                   	push   %eax
80105dca:	e8 81 f3 ff ff       	call   80105150 <fetchint>
80105dcf:	83 c4 10             	add    $0x10,%esp
80105dd2:	85 c0                	test   %eax,%eax
80105dd4:	78 26                	js     80105dfc <sys_exec+0xac>
80105dd6:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
80105ddc:	85 c0                	test   %eax,%eax
80105dde:	74 30                	je     80105e10 <sys_exec+0xc0>
80105de0:	83 ec 08             	sub    $0x8,%esp
80105de3:	8d 14 3e             	lea    (%esi,%edi,1),%edx
80105de6:	52                   	push   %edx
80105de7:	50                   	push   %eax
80105de8:	e8 a3 f3 ff ff       	call   80105190 <fetchstr>
80105ded:	83 c4 10             	add    $0x10,%esp
80105df0:	85 c0                	test   %eax,%eax
80105df2:	78 08                	js     80105dfc <sys_exec+0xac>
80105df4:	83 c3 01             	add    $0x1,%ebx
80105df7:	83 fb 20             	cmp    $0x20,%ebx
80105dfa:	75 b4                	jne    80105db0 <sys_exec+0x60>
80105dfc:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105dff:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105e04:	5b                   	pop    %ebx
80105e05:	5e                   	pop    %esi
80105e06:	5f                   	pop    %edi
80105e07:	5d                   	pop    %ebp
80105e08:	c3                   	ret
80105e09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105e10:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105e17:	00 00 00 00 
80105e1b:	83 ec 08             	sub    $0x8,%esp
80105e1e:	56                   	push   %esi
80105e1f:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80105e25:	e8 06 b5 ff ff       	call   80101330 <exec>
80105e2a:	83 c4 10             	add    $0x10,%esp
80105e2d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105e30:	5b                   	pop    %ebx
80105e31:	5e                   	pop    %esi
80105e32:	5f                   	pop    %edi
80105e33:	5d                   	pop    %ebp
80105e34:	c3                   	ret
80105e35:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105e3c:	00 
80105e3d:	8d 76 00             	lea    0x0(%esi),%esi

80105e40 <sys_pipe>:
80105e40:	55                   	push   %ebp
80105e41:	89 e5                	mov    %esp,%ebp
80105e43:	57                   	push   %edi
80105e44:	56                   	push   %esi
80105e45:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105e48:	53                   	push   %ebx
80105e49:	83 ec 20             	sub    $0x20,%esp
80105e4c:	6a 08                	push   $0x8
80105e4e:	50                   	push   %eax
80105e4f:	6a 00                	push   $0x0
80105e51:	e8 da f3 ff ff       	call   80105230 <argptr>
80105e56:	83 c4 10             	add    $0x10,%esp
80105e59:	85 c0                	test   %eax,%eax
80105e5b:	0f 88 8b 00 00 00    	js     80105eec <sys_pipe+0xac>
80105e61:	83 ec 08             	sub    $0x8,%esp
80105e64:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105e67:	50                   	push   %eax
80105e68:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105e6b:	50                   	push   %eax
80105e6c:	e8 2f de ff ff       	call   80103ca0 <pipealloc>
80105e71:	83 c4 10             	add    $0x10,%esp
80105e74:	85 c0                	test   %eax,%eax
80105e76:	78 74                	js     80105eec <sys_pipe+0xac>
80105e78:	8b 7d e0             	mov    -0x20(%ebp),%edi
80105e7b:	31 db                	xor    %ebx,%ebx
80105e7d:	e8 6e e3 ff ff       	call   801041f0 <myproc>
80105e82:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105e86:	85 f6                	test   %esi,%esi
80105e88:	74 16                	je     80105ea0 <sys_pipe+0x60>
80105e8a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105e90:	83 c3 01             	add    $0x1,%ebx
80105e93:	83 fb 10             	cmp    $0x10,%ebx
80105e96:	74 3d                	je     80105ed5 <sys_pipe+0x95>
80105e98:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
80105e9c:	85 f6                	test   %esi,%esi
80105e9e:	75 f0                	jne    80105e90 <sys_pipe+0x50>
80105ea0:	8d 73 08             	lea    0x8(%ebx),%esi
80105ea3:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
80105ea7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80105eaa:	e8 41 e3 ff ff       	call   801041f0 <myproc>
80105eaf:	31 d2                	xor    %edx,%edx
80105eb1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105eb8:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
80105ebc:	85 c9                	test   %ecx,%ecx
80105ebe:	74 38                	je     80105ef8 <sys_pipe+0xb8>
80105ec0:	83 c2 01             	add    $0x1,%edx
80105ec3:	83 fa 10             	cmp    $0x10,%edx
80105ec6:	75 f0                	jne    80105eb8 <sys_pipe+0x78>
80105ec8:	e8 23 e3 ff ff       	call   801041f0 <myproc>
80105ecd:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105ed4:	00 
80105ed5:	83 ec 0c             	sub    $0xc,%esp
80105ed8:	ff 75 e0             	push   -0x20(%ebp)
80105edb:	e8 b0 b8 ff ff       	call   80101790 <fileclose>
80105ee0:	58                   	pop    %eax
80105ee1:	ff 75 e4             	push   -0x1c(%ebp)
80105ee4:	e8 a7 b8 ff ff       	call   80101790 <fileclose>
80105ee9:	83 c4 10             	add    $0x10,%esp
80105eec:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105ef1:	eb 16                	jmp    80105f09 <sys_pipe+0xc9>
80105ef3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80105ef8:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
80105efc:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105eff:	89 18                	mov    %ebx,(%eax)
80105f01:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105f04:	89 50 04             	mov    %edx,0x4(%eax)
80105f07:	31 c0                	xor    %eax,%eax
80105f09:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105f0c:	5b                   	pop    %ebx
80105f0d:	5e                   	pop    %esi
80105f0e:	5f                   	pop    %edi
80105f0f:	5d                   	pop    %ebp
80105f10:	c3                   	ret
80105f11:	66 90                	xchg   %ax,%ax
80105f13:	66 90                	xchg   %ax,%ax
80105f15:	66 90                	xchg   %ax,%ax
80105f17:	66 90                	xchg   %ax,%ax
80105f19:	66 90                	xchg   %ax,%ax
80105f1b:	66 90                	xchg   %ax,%ax
80105f1d:	66 90                	xchg   %ax,%ax
80105f1f:	90                   	nop

80105f20 <sys_fork>:
80105f20:	e9 6b e4 ff ff       	jmp    80104390 <fork>
80105f25:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105f2c:	00 
80105f2d:	8d 76 00             	lea    0x0(%esi),%esi

80105f30 <sys_exit>:
80105f30:	55                   	push   %ebp
80105f31:	89 e5                	mov    %esp,%ebp
80105f33:	83 ec 08             	sub    $0x8,%esp
80105f36:	e8 c5 e6 ff ff       	call   80104600 <exit>
80105f3b:	31 c0                	xor    %eax,%eax
80105f3d:	c9                   	leave
80105f3e:	c3                   	ret
80105f3f:	90                   	nop

80105f40 <sys_wait>:
80105f40:	e9 eb e7 ff ff       	jmp    80104730 <wait>
80105f45:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105f4c:	00 
80105f4d:	8d 76 00             	lea    0x0(%esi),%esi

80105f50 <sys_kill>:
80105f50:	55                   	push   %ebp
80105f51:	89 e5                	mov    %esp,%ebp
80105f53:	83 ec 20             	sub    $0x20,%esp
80105f56:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f59:	50                   	push   %eax
80105f5a:	6a 00                	push   $0x0
80105f5c:	e8 7f f2 ff ff       	call   801051e0 <argint>
80105f61:	83 c4 10             	add    $0x10,%esp
80105f64:	85 c0                	test   %eax,%eax
80105f66:	78 18                	js     80105f80 <sys_kill+0x30>
80105f68:	83 ec 0c             	sub    $0xc,%esp
80105f6b:	ff 75 f4             	push   -0xc(%ebp)
80105f6e:	e8 5d ea ff ff       	call   801049d0 <kill>
80105f73:	83 c4 10             	add    $0x10,%esp
80105f76:	c9                   	leave
80105f77:	c3                   	ret
80105f78:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105f7f:	00 
80105f80:	c9                   	leave
80105f81:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105f86:	c3                   	ret
80105f87:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105f8e:	00 
80105f8f:	90                   	nop

80105f90 <sys_getpid>:
80105f90:	55                   	push   %ebp
80105f91:	89 e5                	mov    %esp,%ebp
80105f93:	83 ec 08             	sub    $0x8,%esp
80105f96:	e8 55 e2 ff ff       	call   801041f0 <myproc>
80105f9b:	8b 40 10             	mov    0x10(%eax),%eax
80105f9e:	c9                   	leave
80105f9f:	c3                   	ret

80105fa0 <sys_sbrk>:
80105fa0:	55                   	push   %ebp
80105fa1:	89 e5                	mov    %esp,%ebp
80105fa3:	53                   	push   %ebx
80105fa4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105fa7:	83 ec 1c             	sub    $0x1c,%esp
80105faa:	50                   	push   %eax
80105fab:	6a 00                	push   $0x0
80105fad:	e8 2e f2 ff ff       	call   801051e0 <argint>
80105fb2:	83 c4 10             	add    $0x10,%esp
80105fb5:	85 c0                	test   %eax,%eax
80105fb7:	78 27                	js     80105fe0 <sys_sbrk+0x40>
80105fb9:	e8 32 e2 ff ff       	call   801041f0 <myproc>
80105fbe:	83 ec 0c             	sub    $0xc,%esp
80105fc1:	8b 18                	mov    (%eax),%ebx
80105fc3:	ff 75 f4             	push   -0xc(%ebp)
80105fc6:	e8 45 e3 ff ff       	call   80104310 <growproc>
80105fcb:	83 c4 10             	add    $0x10,%esp
80105fce:	85 c0                	test   %eax,%eax
80105fd0:	78 0e                	js     80105fe0 <sys_sbrk+0x40>
80105fd2:	89 d8                	mov    %ebx,%eax
80105fd4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105fd7:	c9                   	leave
80105fd8:	c3                   	ret
80105fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105fe0:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105fe5:	eb eb                	jmp    80105fd2 <sys_sbrk+0x32>
80105fe7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80105fee:	00 
80105fef:	90                   	nop

80105ff0 <sys_sleep>:
80105ff0:	55                   	push   %ebp
80105ff1:	89 e5                	mov    %esp,%ebp
80105ff3:	53                   	push   %ebx
80105ff4:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ff7:	83 ec 1c             	sub    $0x1c,%esp
80105ffa:	50                   	push   %eax
80105ffb:	6a 00                	push   $0x0
80105ffd:	e8 de f1 ff ff       	call   801051e0 <argint>
80106002:	83 c4 10             	add    $0x10,%esp
80106005:	85 c0                	test   %eax,%eax
80106007:	78 64                	js     8010606d <sys_sleep+0x7d>
80106009:	83 ec 0c             	sub    $0xc,%esp
8010600c:	68 c0 53 11 80       	push   $0x801153c0
80106011:	e8 1a ee ff ff       	call   80104e30 <acquire>
80106016:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106019:	8b 1d a0 53 11 80    	mov    0x801153a0,%ebx
8010601f:	83 c4 10             	add    $0x10,%esp
80106022:	85 d2                	test   %edx,%edx
80106024:	75 2b                	jne    80106051 <sys_sleep+0x61>
80106026:	eb 58                	jmp    80106080 <sys_sleep+0x90>
80106028:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010602f:	00 
80106030:	83 ec 08             	sub    $0x8,%esp
80106033:	68 c0 53 11 80       	push   $0x801153c0
80106038:	68 a0 53 11 80       	push   $0x801153a0
8010603d:	e8 6e e8 ff ff       	call   801048b0 <sleep>
80106042:	a1 a0 53 11 80       	mov    0x801153a0,%eax
80106047:	83 c4 10             	add    $0x10,%esp
8010604a:	29 d8                	sub    %ebx,%eax
8010604c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
8010604f:	73 2f                	jae    80106080 <sys_sleep+0x90>
80106051:	e8 9a e1 ff ff       	call   801041f0 <myproc>
80106056:	8b 40 24             	mov    0x24(%eax),%eax
80106059:	85 c0                	test   %eax,%eax
8010605b:	74 d3                	je     80106030 <sys_sleep+0x40>
8010605d:	83 ec 0c             	sub    $0xc,%esp
80106060:	68 c0 53 11 80       	push   $0x801153c0
80106065:	e8 66 ed ff ff       	call   80104dd0 <release>
8010606a:	83 c4 10             	add    $0x10,%esp
8010606d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106070:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106075:	c9                   	leave
80106076:	c3                   	ret
80106077:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010607e:	00 
8010607f:	90                   	nop
80106080:	83 ec 0c             	sub    $0xc,%esp
80106083:	68 c0 53 11 80       	push   $0x801153c0
80106088:	e8 43 ed ff ff       	call   80104dd0 <release>
8010608d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106090:	83 c4 10             	add    $0x10,%esp
80106093:	31 c0                	xor    %eax,%eax
80106095:	c9                   	leave
80106096:	c3                   	ret
80106097:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010609e:	00 
8010609f:	90                   	nop

801060a0 <sys_uptime>:
801060a0:	55                   	push   %ebp
801060a1:	89 e5                	mov    %esp,%ebp
801060a3:	53                   	push   %ebx
801060a4:	83 ec 10             	sub    $0x10,%esp
801060a7:	68 c0 53 11 80       	push   $0x801153c0
801060ac:	e8 7f ed ff ff       	call   80104e30 <acquire>
801060b1:	8b 1d a0 53 11 80    	mov    0x801153a0,%ebx
801060b7:	c7 04 24 c0 53 11 80 	movl   $0x801153c0,(%esp)
801060be:	e8 0d ed ff ff       	call   80104dd0 <release>
801060c3:	89 d8                	mov    %ebx,%eax
801060c5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801060c8:	c9                   	leave
801060c9:	c3                   	ret

801060ca <alltraps>:
801060ca:	1e                   	push   %ds
801060cb:	06                   	push   %es
801060cc:	0f a0                	push   %fs
801060ce:	0f a8                	push   %gs
801060d0:	60                   	pusha
801060d1:	66 b8 10 00          	mov    $0x10,%ax
801060d5:	8e d8                	mov    %eax,%ds
801060d7:	8e c0                	mov    %eax,%es
801060d9:	54                   	push   %esp
801060da:	e8 c1 00 00 00       	call   801061a0 <trap>
801060df:	83 c4 04             	add    $0x4,%esp

801060e2 <trapret>:
801060e2:	61                   	popa
801060e3:	0f a9                	pop    %gs
801060e5:	0f a1                	pop    %fs
801060e7:	07                   	pop    %es
801060e8:	1f                   	pop    %ds
801060e9:	83 c4 08             	add    $0x8,%esp
801060ec:	cf                   	iret
801060ed:	66 90                	xchg   %ax,%ax
801060ef:	90                   	nop

801060f0 <tvinit>:
801060f0:	55                   	push   %ebp
801060f1:	31 c0                	xor    %eax,%eax
801060f3:	89 e5                	mov    %esp,%ebp
801060f5:	83 ec 08             	sub    $0x8,%esp
801060f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801060ff:	00 
80106100:	8b 14 85 08 b0 10 80 	mov    -0x7fef4ff8(,%eax,4),%edx
80106107:	c7 04 c5 02 54 11 80 	movl   $0x8e000008,-0x7feeabfe(,%eax,8)
8010610e:	08 00 00 8e 
80106112:	66 89 14 c5 00 54 11 	mov    %dx,-0x7feeac00(,%eax,8)
80106119:	80 
8010611a:	c1 ea 10             	shr    $0x10,%edx
8010611d:	66 89 14 c5 06 54 11 	mov    %dx,-0x7feeabfa(,%eax,8)
80106124:	80 
80106125:	83 c0 01             	add    $0x1,%eax
80106128:	3d 00 01 00 00       	cmp    $0x100,%eax
8010612d:	75 d1                	jne    80106100 <tvinit+0x10>
8010612f:	83 ec 08             	sub    $0x8,%esp
80106132:	a1 08 b1 10 80       	mov    0x8010b108,%eax
80106137:	c7 05 02 56 11 80 08 	movl   $0xef000008,0x80115602
8010613e:	00 00 ef 
80106141:	68 ee 7d 10 80       	push   $0x80107dee
80106146:	68 c0 53 11 80       	push   $0x801153c0
8010614b:	66 a3 00 56 11 80    	mov    %ax,0x80115600
80106151:	c1 e8 10             	shr    $0x10,%eax
80106154:	66 a3 06 56 11 80    	mov    %ax,0x80115606
8010615a:	e8 e1 ea ff ff       	call   80104c40 <initlock>
8010615f:	83 c4 10             	add    $0x10,%esp
80106162:	c9                   	leave
80106163:	c3                   	ret
80106164:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010616b:	00 
8010616c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106170 <idtinit>:
80106170:	55                   	push   %ebp
80106171:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106176:	89 e5                	mov    %esp,%ebp
80106178:	83 ec 10             	sub    $0x10,%esp
8010617b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
8010617f:	b8 00 54 11 80       	mov    $0x80115400,%eax
80106184:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80106188:	c1 e8 10             	shr    $0x10,%eax
8010618b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
8010618f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106192:	0f 01 18             	lidtl  (%eax)
80106195:	c9                   	leave
80106196:	c3                   	ret
80106197:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010619e:	00 
8010619f:	90                   	nop

801061a0 <trap>:
801061a0:	55                   	push   %ebp
801061a1:	89 e5                	mov    %esp,%ebp
801061a3:	57                   	push   %edi
801061a4:	56                   	push   %esi
801061a5:	53                   	push   %ebx
801061a6:	83 ec 1c             	sub    $0x1c,%esp
801061a9:	8b 5d 08             	mov    0x8(%ebp),%ebx
801061ac:	8b 43 30             	mov    0x30(%ebx),%eax
801061af:	83 f8 40             	cmp    $0x40,%eax
801061b2:	0f 84 58 01 00 00    	je     80106310 <trap+0x170>
801061b8:	83 e8 20             	sub    $0x20,%eax
801061bb:	83 f8 1f             	cmp    $0x1f,%eax
801061be:	0f 87 7c 00 00 00    	ja     80106240 <trap+0xa0>
801061c4:	ff 24 85 98 83 10 80 	jmp    *-0x7fef7c68(,%eax,4)
801061cb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801061d0:	e8 db c8 ff ff       	call   80102ab0 <ideintr>
801061d5:	e8 a6 cf ff ff       	call   80103180 <lapiceoi>
801061da:	e8 11 e0 ff ff       	call   801041f0 <myproc>
801061df:	85 c0                	test   %eax,%eax
801061e1:	74 1a                	je     801061fd <trap+0x5d>
801061e3:	e8 08 e0 ff ff       	call   801041f0 <myproc>
801061e8:	8b 50 24             	mov    0x24(%eax),%edx
801061eb:	85 d2                	test   %edx,%edx
801061ed:	74 0e                	je     801061fd <trap+0x5d>
801061ef:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
801061f3:	f7 d0                	not    %eax
801061f5:	a8 03                	test   $0x3,%al
801061f7:	0f 84 db 01 00 00    	je     801063d8 <trap+0x238>
801061fd:	e8 ee df ff ff       	call   801041f0 <myproc>
80106202:	85 c0                	test   %eax,%eax
80106204:	74 0f                	je     80106215 <trap+0x75>
80106206:	e8 e5 df ff ff       	call   801041f0 <myproc>
8010620b:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
8010620f:	0f 84 ab 00 00 00    	je     801062c0 <trap+0x120>
80106215:	e8 d6 df ff ff       	call   801041f0 <myproc>
8010621a:	85 c0                	test   %eax,%eax
8010621c:	74 1a                	je     80106238 <trap+0x98>
8010621e:	e8 cd df ff ff       	call   801041f0 <myproc>
80106223:	8b 40 24             	mov    0x24(%eax),%eax
80106226:	85 c0                	test   %eax,%eax
80106228:	74 0e                	je     80106238 <trap+0x98>
8010622a:	0f b7 43 3c          	movzwl 0x3c(%ebx),%eax
8010622e:	f7 d0                	not    %eax
80106230:	a8 03                	test   $0x3,%al
80106232:	0f 84 05 01 00 00    	je     8010633d <trap+0x19d>
80106238:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010623b:	5b                   	pop    %ebx
8010623c:	5e                   	pop    %esi
8010623d:	5f                   	pop    %edi
8010623e:	5d                   	pop    %ebp
8010623f:	c3                   	ret
80106240:	e8 ab df ff ff       	call   801041f0 <myproc>
80106245:	8b 7b 38             	mov    0x38(%ebx),%edi
80106248:	85 c0                	test   %eax,%eax
8010624a:	0f 84 a2 01 00 00    	je     801063f2 <trap+0x252>
80106250:	f6 43 3c 03          	testb  $0x3,0x3c(%ebx)
80106254:	0f 84 98 01 00 00    	je     801063f2 <trap+0x252>
8010625a:	0f 20 d1             	mov    %cr2,%ecx
8010625d:	89 4d d8             	mov    %ecx,-0x28(%ebp)
80106260:	e8 6b df ff ff       	call   801041d0 <cpuid>
80106265:	8b 73 30             	mov    0x30(%ebx),%esi
80106268:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010626b:	8b 43 34             	mov    0x34(%ebx),%eax
8010626e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80106271:	e8 7a df ff ff       	call   801041f0 <myproc>
80106276:	89 45 e0             	mov    %eax,-0x20(%ebp)
80106279:	e8 72 df ff ff       	call   801041f0 <myproc>
8010627e:	8b 4d d8             	mov    -0x28(%ebp),%ecx
80106281:	51                   	push   %ecx
80106282:	57                   	push   %edi
80106283:	8b 55 dc             	mov    -0x24(%ebp),%edx
80106286:	52                   	push   %edx
80106287:	ff 75 e4             	push   -0x1c(%ebp)
8010628a:	56                   	push   %esi
8010628b:	8b 75 e0             	mov    -0x20(%ebp),%esi
8010628e:	83 c6 6c             	add    $0x6c,%esi
80106291:	56                   	push   %esi
80106292:	ff 70 10             	push   0x10(%eax)
80106295:	68 8c 80 10 80       	push   $0x8010808c
8010629a:	e8 a1 a9 ff ff       	call   80100c40 <cprintf>
8010629f:	83 c4 20             	add    $0x20,%esp
801062a2:	e8 49 df ff ff       	call   801041f0 <myproc>
801062a7:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
801062ae:	e8 3d df ff ff       	call   801041f0 <myproc>
801062b3:	85 c0                	test   %eax,%eax
801062b5:	0f 85 28 ff ff ff    	jne    801061e3 <trap+0x43>
801062bb:	e9 3d ff ff ff       	jmp    801061fd <trap+0x5d>
801062c0:	83 7b 30 20          	cmpl   $0x20,0x30(%ebx)
801062c4:	0f 85 4b ff ff ff    	jne    80106215 <trap+0x75>
801062ca:	e8 91 e5 ff ff       	call   80104860 <yield>
801062cf:	e9 41 ff ff ff       	jmp    80106215 <trap+0x75>
801062d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801062d8:	8b 7b 38             	mov    0x38(%ebx),%edi
801062db:	0f b7 73 3c          	movzwl 0x3c(%ebx),%esi
801062df:	e8 ec de ff ff       	call   801041d0 <cpuid>
801062e4:	57                   	push   %edi
801062e5:	56                   	push   %esi
801062e6:	50                   	push   %eax
801062e7:	68 34 80 10 80       	push   $0x80108034
801062ec:	e8 4f a9 ff ff       	call   80100c40 <cprintf>
801062f1:	e8 8a ce ff ff       	call   80103180 <lapiceoi>
801062f6:	83 c4 10             	add    $0x10,%esp
801062f9:	e8 f2 de ff ff       	call   801041f0 <myproc>
801062fe:	85 c0                	test   %eax,%eax
80106300:	0f 85 dd fe ff ff    	jne    801061e3 <trap+0x43>
80106306:	e9 f2 fe ff ff       	jmp    801061fd <trap+0x5d>
8010630b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80106310:	e8 db de ff ff       	call   801041f0 <myproc>
80106315:	8b 70 24             	mov    0x24(%eax),%esi
80106318:	85 f6                	test   %esi,%esi
8010631a:	0f 85 c8 00 00 00    	jne    801063e8 <trap+0x248>
80106320:	e8 cb de ff ff       	call   801041f0 <myproc>
80106325:	89 58 18             	mov    %ebx,0x18(%eax)
80106328:	e8 f3 ef ff ff       	call   80105320 <syscall>
8010632d:	e8 be de ff ff       	call   801041f0 <myproc>
80106332:	8b 48 24             	mov    0x24(%eax),%ecx
80106335:	85 c9                	test   %ecx,%ecx
80106337:	0f 84 fb fe ff ff    	je     80106238 <trap+0x98>
8010633d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106340:	5b                   	pop    %ebx
80106341:	5e                   	pop    %esi
80106342:	5f                   	pop    %edi
80106343:	5d                   	pop    %ebp
80106344:	e9 b7 e2 ff ff       	jmp    80104600 <exit>
80106349:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106350:	e8 4b 02 00 00       	call   801065a0 <uartintr>
80106355:	e8 26 ce ff ff       	call   80103180 <lapiceoi>
8010635a:	e8 91 de ff ff       	call   801041f0 <myproc>
8010635f:	85 c0                	test   %eax,%eax
80106361:	0f 85 7c fe ff ff    	jne    801061e3 <trap+0x43>
80106367:	e9 91 fe ff ff       	jmp    801061fd <trap+0x5d>
8010636c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106370:	e8 db cc ff ff       	call   80103050 <kbdintr>
80106375:	e8 06 ce ff ff       	call   80103180 <lapiceoi>
8010637a:	e8 71 de ff ff       	call   801041f0 <myproc>
8010637f:	85 c0                	test   %eax,%eax
80106381:	0f 85 5c fe ff ff    	jne    801061e3 <trap+0x43>
80106387:	e9 71 fe ff ff       	jmp    801061fd <trap+0x5d>
8010638c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80106390:	e8 3b de ff ff       	call   801041d0 <cpuid>
80106395:	85 c0                	test   %eax,%eax
80106397:	0f 85 38 fe ff ff    	jne    801061d5 <trap+0x35>
8010639d:	83 ec 0c             	sub    $0xc,%esp
801063a0:	68 c0 53 11 80       	push   $0x801153c0
801063a5:	e8 86 ea ff ff       	call   80104e30 <acquire>
801063aa:	83 05 a0 53 11 80 01 	addl   $0x1,0x801153a0
801063b1:	c7 04 24 a0 53 11 80 	movl   $0x801153a0,(%esp)
801063b8:	e8 b3 e5 ff ff       	call   80104970 <wakeup>
801063bd:	c7 04 24 c0 53 11 80 	movl   $0x801153c0,(%esp)
801063c4:	e8 07 ea ff ff       	call   80104dd0 <release>
801063c9:	83 c4 10             	add    $0x10,%esp
801063cc:	e9 04 fe ff ff       	jmp    801061d5 <trap+0x35>
801063d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801063d8:	e8 23 e2 ff ff       	call   80104600 <exit>
801063dd:	e9 1b fe ff ff       	jmp    801061fd <trap+0x5d>
801063e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801063e8:	e8 13 e2 ff ff       	call   80104600 <exit>
801063ed:	e9 2e ff ff ff       	jmp    80106320 <trap+0x180>
801063f2:	0f 20 d6             	mov    %cr2,%esi
801063f5:	e8 d6 dd ff ff       	call   801041d0 <cpuid>
801063fa:	83 ec 0c             	sub    $0xc,%esp
801063fd:	56                   	push   %esi
801063fe:	57                   	push   %edi
801063ff:	50                   	push   %eax
80106400:	ff 73 30             	push   0x30(%ebx)
80106403:	68 58 80 10 80       	push   $0x80108058
80106408:	e8 33 a8 ff ff       	call   80100c40 <cprintf>
8010640d:	83 c4 14             	add    $0x14,%esp
80106410:	68 f3 7d 10 80       	push   $0x80107df3
80106415:	e8 86 9f ff ff       	call   801003a0 <panic>
8010641a:	66 90                	xchg   %ax,%ax
8010641c:	66 90                	xchg   %ax,%ax
8010641e:	66 90                	xchg   %ax,%ax

80106420 <uartgetc>:
80106420:	a1 00 5c 11 80       	mov    0x80115c00,%eax
80106425:	85 c0                	test   %eax,%eax
80106427:	74 17                	je     80106440 <uartgetc+0x20>
80106429:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010642e:	ec                   	in     (%dx),%al
8010642f:	a8 01                	test   $0x1,%al
80106431:	74 0d                	je     80106440 <uartgetc+0x20>
80106433:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106438:	ec                   	in     (%dx),%al
80106439:	0f b6 c0             	movzbl %al,%eax
8010643c:	c3                   	ret
8010643d:	8d 76 00             	lea    0x0(%esi),%esi
80106440:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106445:	c3                   	ret
80106446:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010644d:	00 
8010644e:	66 90                	xchg   %ax,%ax

80106450 <uartinit>:
80106450:	55                   	push   %ebp
80106451:	31 c9                	xor    %ecx,%ecx
80106453:	89 c8                	mov    %ecx,%eax
80106455:	89 e5                	mov    %esp,%ebp
80106457:	57                   	push   %edi
80106458:	bf fa 03 00 00       	mov    $0x3fa,%edi
8010645d:	56                   	push   %esi
8010645e:	89 fa                	mov    %edi,%edx
80106460:	53                   	push   %ebx
80106461:	83 ec 1c             	sub    $0x1c,%esp
80106464:	ee                   	out    %al,(%dx)
80106465:	be fb 03 00 00       	mov    $0x3fb,%esi
8010646a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010646f:	89 f2                	mov    %esi,%edx
80106471:	ee                   	out    %al,(%dx)
80106472:	b8 0c 00 00 00       	mov    $0xc,%eax
80106477:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010647c:	ee                   	out    %al,(%dx)
8010647d:	bb f9 03 00 00       	mov    $0x3f9,%ebx
80106482:	89 c8                	mov    %ecx,%eax
80106484:	89 da                	mov    %ebx,%edx
80106486:	ee                   	out    %al,(%dx)
80106487:	b8 03 00 00 00       	mov    $0x3,%eax
8010648c:	89 f2                	mov    %esi,%edx
8010648e:	ee                   	out    %al,(%dx)
8010648f:	ba fc 03 00 00       	mov    $0x3fc,%edx
80106494:	89 c8                	mov    %ecx,%eax
80106496:	ee                   	out    %al,(%dx)
80106497:	b8 01 00 00 00       	mov    $0x1,%eax
8010649c:	89 da                	mov    %ebx,%edx
8010649e:	ee                   	out    %al,(%dx)
8010649f:	ba fd 03 00 00       	mov    $0x3fd,%edx
801064a4:	ec                   	in     (%dx),%al
801064a5:	3c ff                	cmp    $0xff,%al
801064a7:	0f 84 7c 00 00 00    	je     80106529 <uartinit+0xd9>
801064ad:	c7 05 00 5c 11 80 01 	movl   $0x1,0x80115c00
801064b4:	00 00 00 
801064b7:	89 fa                	mov    %edi,%edx
801064b9:	ec                   	in     (%dx),%al
801064ba:	ba f8 03 00 00       	mov    $0x3f8,%edx
801064bf:	ec                   	in     (%dx),%al
801064c0:	83 ec 08             	sub    $0x8,%esp
801064c3:	bf f8 7d 10 80       	mov    $0x80107df8,%edi
801064c8:	be fd 03 00 00       	mov    $0x3fd,%esi
801064cd:	6a 00                	push   $0x0
801064cf:	6a 04                	push   $0x4
801064d1:	e8 0a c8 ff ff       	call   80102ce0 <ioapicenable>
801064d6:	83 c4 10             	add    $0x10,%esp
801064d9:	c6 45 e7 78          	movb   $0x78,-0x19(%ebp)
801064dd:	8d 76 00             	lea    0x0(%esi),%esi
801064e0:	a1 00 5c 11 80       	mov    0x80115c00,%eax
801064e5:	85 c0                	test   %eax,%eax
801064e7:	74 32                	je     8010651b <uartinit+0xcb>
801064e9:	89 f2                	mov    %esi,%edx
801064eb:	ec                   	in     (%dx),%al
801064ec:	a8 20                	test   $0x20,%al
801064ee:	75 21                	jne    80106511 <uartinit+0xc1>
801064f0:	bb 80 00 00 00       	mov    $0x80,%ebx
801064f5:	8d 76 00             	lea    0x0(%esi),%esi
801064f8:	83 ec 0c             	sub    $0xc,%esp
801064fb:	6a 0a                	push   $0xa
801064fd:	e8 9e cc ff ff       	call   801031a0 <microdelay>
80106502:	83 c4 10             	add    $0x10,%esp
80106505:	83 eb 01             	sub    $0x1,%ebx
80106508:	74 07                	je     80106511 <uartinit+0xc1>
8010650a:	89 f2                	mov    %esi,%edx
8010650c:	ec                   	in     (%dx),%al
8010650d:	a8 20                	test   $0x20,%al
8010650f:	74 e7                	je     801064f8 <uartinit+0xa8>
80106511:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106516:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
8010651a:	ee                   	out    %al,(%dx)
8010651b:	0f b6 47 01          	movzbl 0x1(%edi),%eax
8010651f:	83 c7 01             	add    $0x1,%edi
80106522:	88 45 e7             	mov    %al,-0x19(%ebp)
80106525:	84 c0                	test   %al,%al
80106527:	75 b7                	jne    801064e0 <uartinit+0x90>
80106529:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010652c:	5b                   	pop    %ebx
8010652d:	5e                   	pop    %esi
8010652e:	5f                   	pop    %edi
8010652f:	5d                   	pop    %ebp
80106530:	c3                   	ret
80106531:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80106538:	00 
80106539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106540 <uartputc>:
80106540:	a1 00 5c 11 80       	mov    0x80115c00,%eax
80106545:	85 c0                	test   %eax,%eax
80106547:	74 4f                	je     80106598 <uartputc+0x58>
80106549:	55                   	push   %ebp
8010654a:	ba fd 03 00 00       	mov    $0x3fd,%edx
8010654f:	89 e5                	mov    %esp,%ebp
80106551:	56                   	push   %esi
80106552:	53                   	push   %ebx
80106553:	ec                   	in     (%dx),%al
80106554:	a8 20                	test   $0x20,%al
80106556:	75 29                	jne    80106581 <uartputc+0x41>
80106558:	bb 80 00 00 00       	mov    $0x80,%ebx
8010655d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106562:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80106568:	83 ec 0c             	sub    $0xc,%esp
8010656b:	6a 0a                	push   $0xa
8010656d:	e8 2e cc ff ff       	call   801031a0 <microdelay>
80106572:	83 c4 10             	add    $0x10,%esp
80106575:	83 eb 01             	sub    $0x1,%ebx
80106578:	74 07                	je     80106581 <uartputc+0x41>
8010657a:	89 f2                	mov    %esi,%edx
8010657c:	ec                   	in     (%dx),%al
8010657d:	a8 20                	test   $0x20,%al
8010657f:	74 e7                	je     80106568 <uartputc+0x28>
80106581:	8b 45 08             	mov    0x8(%ebp),%eax
80106584:	ba f8 03 00 00       	mov    $0x3f8,%edx
80106589:	ee                   	out    %al,(%dx)
8010658a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010658d:	5b                   	pop    %ebx
8010658e:	5e                   	pop    %esi
8010658f:	5d                   	pop    %ebp
80106590:	c3                   	ret
80106591:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106598:	c3                   	ret
80106599:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801065a0 <uartintr>:
801065a0:	55                   	push   %ebp
801065a1:	89 e5                	mov    %esp,%ebp
801065a3:	83 ec 14             	sub    $0x14,%esp
801065a6:	68 20 64 10 80       	push   $0x80106420
801065ab:	e8 c0 a9 ff ff       	call   80100f70 <consoleintr>
801065b0:	83 c4 10             	add    $0x10,%esp
801065b3:	c9                   	leave
801065b4:	c3                   	ret

801065b5 <vector0>:
801065b5:	6a 00                	push   $0x0
801065b7:	6a 00                	push   $0x0
801065b9:	e9 0c fb ff ff       	jmp    801060ca <alltraps>

801065be <vector1>:
801065be:	6a 00                	push   $0x0
801065c0:	6a 01                	push   $0x1
801065c2:	e9 03 fb ff ff       	jmp    801060ca <alltraps>

801065c7 <vector2>:
801065c7:	6a 00                	push   $0x0
801065c9:	6a 02                	push   $0x2
801065cb:	e9 fa fa ff ff       	jmp    801060ca <alltraps>

801065d0 <vector3>:
801065d0:	6a 00                	push   $0x0
801065d2:	6a 03                	push   $0x3
801065d4:	e9 f1 fa ff ff       	jmp    801060ca <alltraps>

801065d9 <vector4>:
801065d9:	6a 00                	push   $0x0
801065db:	6a 04                	push   $0x4
801065dd:	e9 e8 fa ff ff       	jmp    801060ca <alltraps>

801065e2 <vector5>:
801065e2:	6a 00                	push   $0x0
801065e4:	6a 05                	push   $0x5
801065e6:	e9 df fa ff ff       	jmp    801060ca <alltraps>

801065eb <vector6>:
801065eb:	6a 00                	push   $0x0
801065ed:	6a 06                	push   $0x6
801065ef:	e9 d6 fa ff ff       	jmp    801060ca <alltraps>

801065f4 <vector7>:
801065f4:	6a 00                	push   $0x0
801065f6:	6a 07                	push   $0x7
801065f8:	e9 cd fa ff ff       	jmp    801060ca <alltraps>

801065fd <vector8>:
801065fd:	6a 08                	push   $0x8
801065ff:	e9 c6 fa ff ff       	jmp    801060ca <alltraps>

80106604 <vector9>:
80106604:	6a 00                	push   $0x0
80106606:	6a 09                	push   $0x9
80106608:	e9 bd fa ff ff       	jmp    801060ca <alltraps>

8010660d <vector10>:
8010660d:	6a 0a                	push   $0xa
8010660f:	e9 b6 fa ff ff       	jmp    801060ca <alltraps>

80106614 <vector11>:
80106614:	6a 0b                	push   $0xb
80106616:	e9 af fa ff ff       	jmp    801060ca <alltraps>

8010661b <vector12>:
8010661b:	6a 0c                	push   $0xc
8010661d:	e9 a8 fa ff ff       	jmp    801060ca <alltraps>

80106622 <vector13>:
80106622:	6a 0d                	push   $0xd
80106624:	e9 a1 fa ff ff       	jmp    801060ca <alltraps>

80106629 <vector14>:
80106629:	6a 0e                	push   $0xe
8010662b:	e9 9a fa ff ff       	jmp    801060ca <alltraps>

80106630 <vector15>:
80106630:	6a 00                	push   $0x0
80106632:	6a 0f                	push   $0xf
80106634:	e9 91 fa ff ff       	jmp    801060ca <alltraps>

80106639 <vector16>:
80106639:	6a 00                	push   $0x0
8010663b:	6a 10                	push   $0x10
8010663d:	e9 88 fa ff ff       	jmp    801060ca <alltraps>

80106642 <vector17>:
80106642:	6a 11                	push   $0x11
80106644:	e9 81 fa ff ff       	jmp    801060ca <alltraps>

80106649 <vector18>:
80106649:	6a 00                	push   $0x0
8010664b:	6a 12                	push   $0x12
8010664d:	e9 78 fa ff ff       	jmp    801060ca <alltraps>

80106652 <vector19>:
80106652:	6a 00                	push   $0x0
80106654:	6a 13                	push   $0x13
80106656:	e9 6f fa ff ff       	jmp    801060ca <alltraps>

8010665b <vector20>:
8010665b:	6a 00                	push   $0x0
8010665d:	6a 14                	push   $0x14
8010665f:	e9 66 fa ff ff       	jmp    801060ca <alltraps>

80106664 <vector21>:
80106664:	6a 00                	push   $0x0
80106666:	6a 15                	push   $0x15
80106668:	e9 5d fa ff ff       	jmp    801060ca <alltraps>

8010666d <vector22>:
8010666d:	6a 00                	push   $0x0
8010666f:	6a 16                	push   $0x16
80106671:	e9 54 fa ff ff       	jmp    801060ca <alltraps>

80106676 <vector23>:
80106676:	6a 00                	push   $0x0
80106678:	6a 17                	push   $0x17
8010667a:	e9 4b fa ff ff       	jmp    801060ca <alltraps>

8010667f <vector24>:
8010667f:	6a 00                	push   $0x0
80106681:	6a 18                	push   $0x18
80106683:	e9 42 fa ff ff       	jmp    801060ca <alltraps>

80106688 <vector25>:
80106688:	6a 00                	push   $0x0
8010668a:	6a 19                	push   $0x19
8010668c:	e9 39 fa ff ff       	jmp    801060ca <alltraps>

80106691 <vector26>:
80106691:	6a 00                	push   $0x0
80106693:	6a 1a                	push   $0x1a
80106695:	e9 30 fa ff ff       	jmp    801060ca <alltraps>

8010669a <vector27>:
8010669a:	6a 00                	push   $0x0
8010669c:	6a 1b                	push   $0x1b
8010669e:	e9 27 fa ff ff       	jmp    801060ca <alltraps>

801066a3 <vector28>:
801066a3:	6a 00                	push   $0x0
801066a5:	6a 1c                	push   $0x1c
801066a7:	e9 1e fa ff ff       	jmp    801060ca <alltraps>

801066ac <vector29>:
801066ac:	6a 00                	push   $0x0
801066ae:	6a 1d                	push   $0x1d
801066b0:	e9 15 fa ff ff       	jmp    801060ca <alltraps>

801066b5 <vector30>:
801066b5:	6a 00                	push   $0x0
801066b7:	6a 1e                	push   $0x1e
801066b9:	e9 0c fa ff ff       	jmp    801060ca <alltraps>

801066be <vector31>:
801066be:	6a 00                	push   $0x0
801066c0:	6a 1f                	push   $0x1f
801066c2:	e9 03 fa ff ff       	jmp    801060ca <alltraps>

801066c7 <vector32>:
801066c7:	6a 00                	push   $0x0
801066c9:	6a 20                	push   $0x20
801066cb:	e9 fa f9 ff ff       	jmp    801060ca <alltraps>

801066d0 <vector33>:
801066d0:	6a 00                	push   $0x0
801066d2:	6a 21                	push   $0x21
801066d4:	e9 f1 f9 ff ff       	jmp    801060ca <alltraps>

801066d9 <vector34>:
801066d9:	6a 00                	push   $0x0
801066db:	6a 22                	push   $0x22
801066dd:	e9 e8 f9 ff ff       	jmp    801060ca <alltraps>

801066e2 <vector35>:
801066e2:	6a 00                	push   $0x0
801066e4:	6a 23                	push   $0x23
801066e6:	e9 df f9 ff ff       	jmp    801060ca <alltraps>

801066eb <vector36>:
801066eb:	6a 00                	push   $0x0
801066ed:	6a 24                	push   $0x24
801066ef:	e9 d6 f9 ff ff       	jmp    801060ca <alltraps>

801066f4 <vector37>:
801066f4:	6a 00                	push   $0x0
801066f6:	6a 25                	push   $0x25
801066f8:	e9 cd f9 ff ff       	jmp    801060ca <alltraps>

801066fd <vector38>:
801066fd:	6a 00                	push   $0x0
801066ff:	6a 26                	push   $0x26
80106701:	e9 c4 f9 ff ff       	jmp    801060ca <alltraps>

80106706 <vector39>:
80106706:	6a 00                	push   $0x0
80106708:	6a 27                	push   $0x27
8010670a:	e9 bb f9 ff ff       	jmp    801060ca <alltraps>

8010670f <vector40>:
8010670f:	6a 00                	push   $0x0
80106711:	6a 28                	push   $0x28
80106713:	e9 b2 f9 ff ff       	jmp    801060ca <alltraps>

80106718 <vector41>:
80106718:	6a 00                	push   $0x0
8010671a:	6a 29                	push   $0x29
8010671c:	e9 a9 f9 ff ff       	jmp    801060ca <alltraps>

80106721 <vector42>:
80106721:	6a 00                	push   $0x0
80106723:	6a 2a                	push   $0x2a
80106725:	e9 a0 f9 ff ff       	jmp    801060ca <alltraps>

8010672a <vector43>:
8010672a:	6a 00                	push   $0x0
8010672c:	6a 2b                	push   $0x2b
8010672e:	e9 97 f9 ff ff       	jmp    801060ca <alltraps>

80106733 <vector44>:
80106733:	6a 00                	push   $0x0
80106735:	6a 2c                	push   $0x2c
80106737:	e9 8e f9 ff ff       	jmp    801060ca <alltraps>

8010673c <vector45>:
8010673c:	6a 00                	push   $0x0
8010673e:	6a 2d                	push   $0x2d
80106740:	e9 85 f9 ff ff       	jmp    801060ca <alltraps>

80106745 <vector46>:
80106745:	6a 00                	push   $0x0
80106747:	6a 2e                	push   $0x2e
80106749:	e9 7c f9 ff ff       	jmp    801060ca <alltraps>

8010674e <vector47>:
8010674e:	6a 00                	push   $0x0
80106750:	6a 2f                	push   $0x2f
80106752:	e9 73 f9 ff ff       	jmp    801060ca <alltraps>

80106757 <vector48>:
80106757:	6a 00                	push   $0x0
80106759:	6a 30                	push   $0x30
8010675b:	e9 6a f9 ff ff       	jmp    801060ca <alltraps>

80106760 <vector49>:
80106760:	6a 00                	push   $0x0
80106762:	6a 31                	push   $0x31
80106764:	e9 61 f9 ff ff       	jmp    801060ca <alltraps>

80106769 <vector50>:
80106769:	6a 00                	push   $0x0
8010676b:	6a 32                	push   $0x32
8010676d:	e9 58 f9 ff ff       	jmp    801060ca <alltraps>

80106772 <vector51>:
80106772:	6a 00                	push   $0x0
80106774:	6a 33                	push   $0x33
80106776:	e9 4f f9 ff ff       	jmp    801060ca <alltraps>

8010677b <vector52>:
8010677b:	6a 00                	push   $0x0
8010677d:	6a 34                	push   $0x34
8010677f:	e9 46 f9 ff ff       	jmp    801060ca <alltraps>

80106784 <vector53>:
80106784:	6a 00                	push   $0x0
80106786:	6a 35                	push   $0x35
80106788:	e9 3d f9 ff ff       	jmp    801060ca <alltraps>

8010678d <vector54>:
8010678d:	6a 00                	push   $0x0
8010678f:	6a 36                	push   $0x36
80106791:	e9 34 f9 ff ff       	jmp    801060ca <alltraps>

80106796 <vector55>:
80106796:	6a 00                	push   $0x0
80106798:	6a 37                	push   $0x37
8010679a:	e9 2b f9 ff ff       	jmp    801060ca <alltraps>

8010679f <vector56>:
8010679f:	6a 00                	push   $0x0
801067a1:	6a 38                	push   $0x38
801067a3:	e9 22 f9 ff ff       	jmp    801060ca <alltraps>

801067a8 <vector57>:
801067a8:	6a 00                	push   $0x0
801067aa:	6a 39                	push   $0x39
801067ac:	e9 19 f9 ff ff       	jmp    801060ca <alltraps>

801067b1 <vector58>:
801067b1:	6a 00                	push   $0x0
801067b3:	6a 3a                	push   $0x3a
801067b5:	e9 10 f9 ff ff       	jmp    801060ca <alltraps>

801067ba <vector59>:
801067ba:	6a 00                	push   $0x0
801067bc:	6a 3b                	push   $0x3b
801067be:	e9 07 f9 ff ff       	jmp    801060ca <alltraps>

801067c3 <vector60>:
801067c3:	6a 00                	push   $0x0
801067c5:	6a 3c                	push   $0x3c
801067c7:	e9 fe f8 ff ff       	jmp    801060ca <alltraps>

801067cc <vector61>:
801067cc:	6a 00                	push   $0x0
801067ce:	6a 3d                	push   $0x3d
801067d0:	e9 f5 f8 ff ff       	jmp    801060ca <alltraps>

801067d5 <vector62>:
801067d5:	6a 00                	push   $0x0
801067d7:	6a 3e                	push   $0x3e
801067d9:	e9 ec f8 ff ff       	jmp    801060ca <alltraps>

801067de <vector63>:
801067de:	6a 00                	push   $0x0
801067e0:	6a 3f                	push   $0x3f
801067e2:	e9 e3 f8 ff ff       	jmp    801060ca <alltraps>

801067e7 <vector64>:
801067e7:	6a 00                	push   $0x0
801067e9:	6a 40                	push   $0x40
801067eb:	e9 da f8 ff ff       	jmp    801060ca <alltraps>

801067f0 <vector65>:
801067f0:	6a 00                	push   $0x0
801067f2:	6a 41                	push   $0x41
801067f4:	e9 d1 f8 ff ff       	jmp    801060ca <alltraps>

801067f9 <vector66>:
801067f9:	6a 00                	push   $0x0
801067fb:	6a 42                	push   $0x42
801067fd:	e9 c8 f8 ff ff       	jmp    801060ca <alltraps>

80106802 <vector67>:
80106802:	6a 00                	push   $0x0
80106804:	6a 43                	push   $0x43
80106806:	e9 bf f8 ff ff       	jmp    801060ca <alltraps>

8010680b <vector68>:
8010680b:	6a 00                	push   $0x0
8010680d:	6a 44                	push   $0x44
8010680f:	e9 b6 f8 ff ff       	jmp    801060ca <alltraps>

80106814 <vector69>:
80106814:	6a 00                	push   $0x0
80106816:	6a 45                	push   $0x45
80106818:	e9 ad f8 ff ff       	jmp    801060ca <alltraps>

8010681d <vector70>:
8010681d:	6a 00                	push   $0x0
8010681f:	6a 46                	push   $0x46
80106821:	e9 a4 f8 ff ff       	jmp    801060ca <alltraps>

80106826 <vector71>:
80106826:	6a 00                	push   $0x0
80106828:	6a 47                	push   $0x47
8010682a:	e9 9b f8 ff ff       	jmp    801060ca <alltraps>

8010682f <vector72>:
8010682f:	6a 00                	push   $0x0
80106831:	6a 48                	push   $0x48
80106833:	e9 92 f8 ff ff       	jmp    801060ca <alltraps>

80106838 <vector73>:
80106838:	6a 00                	push   $0x0
8010683a:	6a 49                	push   $0x49
8010683c:	e9 89 f8 ff ff       	jmp    801060ca <alltraps>

80106841 <vector74>:
80106841:	6a 00                	push   $0x0
80106843:	6a 4a                	push   $0x4a
80106845:	e9 80 f8 ff ff       	jmp    801060ca <alltraps>

8010684a <vector75>:
8010684a:	6a 00                	push   $0x0
8010684c:	6a 4b                	push   $0x4b
8010684e:	e9 77 f8 ff ff       	jmp    801060ca <alltraps>

80106853 <vector76>:
80106853:	6a 00                	push   $0x0
80106855:	6a 4c                	push   $0x4c
80106857:	e9 6e f8 ff ff       	jmp    801060ca <alltraps>

8010685c <vector77>:
8010685c:	6a 00                	push   $0x0
8010685e:	6a 4d                	push   $0x4d
80106860:	e9 65 f8 ff ff       	jmp    801060ca <alltraps>

80106865 <vector78>:
80106865:	6a 00                	push   $0x0
80106867:	6a 4e                	push   $0x4e
80106869:	e9 5c f8 ff ff       	jmp    801060ca <alltraps>

8010686e <vector79>:
8010686e:	6a 00                	push   $0x0
80106870:	6a 4f                	push   $0x4f
80106872:	e9 53 f8 ff ff       	jmp    801060ca <alltraps>

80106877 <vector80>:
80106877:	6a 00                	push   $0x0
80106879:	6a 50                	push   $0x50
8010687b:	e9 4a f8 ff ff       	jmp    801060ca <alltraps>

80106880 <vector81>:
80106880:	6a 00                	push   $0x0
80106882:	6a 51                	push   $0x51
80106884:	e9 41 f8 ff ff       	jmp    801060ca <alltraps>

80106889 <vector82>:
80106889:	6a 00                	push   $0x0
8010688b:	6a 52                	push   $0x52
8010688d:	e9 38 f8 ff ff       	jmp    801060ca <alltraps>

80106892 <vector83>:
80106892:	6a 00                	push   $0x0
80106894:	6a 53                	push   $0x53
80106896:	e9 2f f8 ff ff       	jmp    801060ca <alltraps>

8010689b <vector84>:
8010689b:	6a 00                	push   $0x0
8010689d:	6a 54                	push   $0x54
8010689f:	e9 26 f8 ff ff       	jmp    801060ca <alltraps>

801068a4 <vector85>:
801068a4:	6a 00                	push   $0x0
801068a6:	6a 55                	push   $0x55
801068a8:	e9 1d f8 ff ff       	jmp    801060ca <alltraps>

801068ad <vector86>:
801068ad:	6a 00                	push   $0x0
801068af:	6a 56                	push   $0x56
801068b1:	e9 14 f8 ff ff       	jmp    801060ca <alltraps>

801068b6 <vector87>:
801068b6:	6a 00                	push   $0x0
801068b8:	6a 57                	push   $0x57
801068ba:	e9 0b f8 ff ff       	jmp    801060ca <alltraps>

801068bf <vector88>:
801068bf:	6a 00                	push   $0x0
801068c1:	6a 58                	push   $0x58
801068c3:	e9 02 f8 ff ff       	jmp    801060ca <alltraps>

801068c8 <vector89>:
801068c8:	6a 00                	push   $0x0
801068ca:	6a 59                	push   $0x59
801068cc:	e9 f9 f7 ff ff       	jmp    801060ca <alltraps>

801068d1 <vector90>:
801068d1:	6a 00                	push   $0x0
801068d3:	6a 5a                	push   $0x5a
801068d5:	e9 f0 f7 ff ff       	jmp    801060ca <alltraps>

801068da <vector91>:
801068da:	6a 00                	push   $0x0
801068dc:	6a 5b                	push   $0x5b
801068de:	e9 e7 f7 ff ff       	jmp    801060ca <alltraps>

801068e3 <vector92>:
801068e3:	6a 00                	push   $0x0
801068e5:	6a 5c                	push   $0x5c
801068e7:	e9 de f7 ff ff       	jmp    801060ca <alltraps>

801068ec <vector93>:
801068ec:	6a 00                	push   $0x0
801068ee:	6a 5d                	push   $0x5d
801068f0:	e9 d5 f7 ff ff       	jmp    801060ca <alltraps>

801068f5 <vector94>:
801068f5:	6a 00                	push   $0x0
801068f7:	6a 5e                	push   $0x5e
801068f9:	e9 cc f7 ff ff       	jmp    801060ca <alltraps>

801068fe <vector95>:
801068fe:	6a 00                	push   $0x0
80106900:	6a 5f                	push   $0x5f
80106902:	e9 c3 f7 ff ff       	jmp    801060ca <alltraps>

80106907 <vector96>:
80106907:	6a 00                	push   $0x0
80106909:	6a 60                	push   $0x60
8010690b:	e9 ba f7 ff ff       	jmp    801060ca <alltraps>

80106910 <vector97>:
80106910:	6a 00                	push   $0x0
80106912:	6a 61                	push   $0x61
80106914:	e9 b1 f7 ff ff       	jmp    801060ca <alltraps>

80106919 <vector98>:
80106919:	6a 00                	push   $0x0
8010691b:	6a 62                	push   $0x62
8010691d:	e9 a8 f7 ff ff       	jmp    801060ca <alltraps>

80106922 <vector99>:
80106922:	6a 00                	push   $0x0
80106924:	6a 63                	push   $0x63
80106926:	e9 9f f7 ff ff       	jmp    801060ca <alltraps>

8010692b <vector100>:
8010692b:	6a 00                	push   $0x0
8010692d:	6a 64                	push   $0x64
8010692f:	e9 96 f7 ff ff       	jmp    801060ca <alltraps>

80106934 <vector101>:
80106934:	6a 00                	push   $0x0
80106936:	6a 65                	push   $0x65
80106938:	e9 8d f7 ff ff       	jmp    801060ca <alltraps>

8010693d <vector102>:
8010693d:	6a 00                	push   $0x0
8010693f:	6a 66                	push   $0x66
80106941:	e9 84 f7 ff ff       	jmp    801060ca <alltraps>

80106946 <vector103>:
80106946:	6a 00                	push   $0x0
80106948:	6a 67                	push   $0x67
8010694a:	e9 7b f7 ff ff       	jmp    801060ca <alltraps>

8010694f <vector104>:
8010694f:	6a 00                	push   $0x0
80106951:	6a 68                	push   $0x68
80106953:	e9 72 f7 ff ff       	jmp    801060ca <alltraps>

80106958 <vector105>:
80106958:	6a 00                	push   $0x0
8010695a:	6a 69                	push   $0x69
8010695c:	e9 69 f7 ff ff       	jmp    801060ca <alltraps>

80106961 <vector106>:
80106961:	6a 00                	push   $0x0
80106963:	6a 6a                	push   $0x6a
80106965:	e9 60 f7 ff ff       	jmp    801060ca <alltraps>

8010696a <vector107>:
8010696a:	6a 00                	push   $0x0
8010696c:	6a 6b                	push   $0x6b
8010696e:	e9 57 f7 ff ff       	jmp    801060ca <alltraps>

80106973 <vector108>:
80106973:	6a 00                	push   $0x0
80106975:	6a 6c                	push   $0x6c
80106977:	e9 4e f7 ff ff       	jmp    801060ca <alltraps>

8010697c <vector109>:
8010697c:	6a 00                	push   $0x0
8010697e:	6a 6d                	push   $0x6d
80106980:	e9 45 f7 ff ff       	jmp    801060ca <alltraps>

80106985 <vector110>:
80106985:	6a 00                	push   $0x0
80106987:	6a 6e                	push   $0x6e
80106989:	e9 3c f7 ff ff       	jmp    801060ca <alltraps>

8010698e <vector111>:
8010698e:	6a 00                	push   $0x0
80106990:	6a 6f                	push   $0x6f
80106992:	e9 33 f7 ff ff       	jmp    801060ca <alltraps>

80106997 <vector112>:
80106997:	6a 00                	push   $0x0
80106999:	6a 70                	push   $0x70
8010699b:	e9 2a f7 ff ff       	jmp    801060ca <alltraps>

801069a0 <vector113>:
801069a0:	6a 00                	push   $0x0
801069a2:	6a 71                	push   $0x71
801069a4:	e9 21 f7 ff ff       	jmp    801060ca <alltraps>

801069a9 <vector114>:
801069a9:	6a 00                	push   $0x0
801069ab:	6a 72                	push   $0x72
801069ad:	e9 18 f7 ff ff       	jmp    801060ca <alltraps>

801069b2 <vector115>:
801069b2:	6a 00                	push   $0x0
801069b4:	6a 73                	push   $0x73
801069b6:	e9 0f f7 ff ff       	jmp    801060ca <alltraps>

801069bb <vector116>:
801069bb:	6a 00                	push   $0x0
801069bd:	6a 74                	push   $0x74
801069bf:	e9 06 f7 ff ff       	jmp    801060ca <alltraps>

801069c4 <vector117>:
801069c4:	6a 00                	push   $0x0
801069c6:	6a 75                	push   $0x75
801069c8:	e9 fd f6 ff ff       	jmp    801060ca <alltraps>

801069cd <vector118>:
801069cd:	6a 00                	push   $0x0
801069cf:	6a 76                	push   $0x76
801069d1:	e9 f4 f6 ff ff       	jmp    801060ca <alltraps>

801069d6 <vector119>:
801069d6:	6a 00                	push   $0x0
801069d8:	6a 77                	push   $0x77
801069da:	e9 eb f6 ff ff       	jmp    801060ca <alltraps>

801069df <vector120>:
801069df:	6a 00                	push   $0x0
801069e1:	6a 78                	push   $0x78
801069e3:	e9 e2 f6 ff ff       	jmp    801060ca <alltraps>

801069e8 <vector121>:
801069e8:	6a 00                	push   $0x0
801069ea:	6a 79                	push   $0x79
801069ec:	e9 d9 f6 ff ff       	jmp    801060ca <alltraps>

801069f1 <vector122>:
801069f1:	6a 00                	push   $0x0
801069f3:	6a 7a                	push   $0x7a
801069f5:	e9 d0 f6 ff ff       	jmp    801060ca <alltraps>

801069fa <vector123>:
801069fa:	6a 00                	push   $0x0
801069fc:	6a 7b                	push   $0x7b
801069fe:	e9 c7 f6 ff ff       	jmp    801060ca <alltraps>

80106a03 <vector124>:
80106a03:	6a 00                	push   $0x0
80106a05:	6a 7c                	push   $0x7c
80106a07:	e9 be f6 ff ff       	jmp    801060ca <alltraps>

80106a0c <vector125>:
80106a0c:	6a 00                	push   $0x0
80106a0e:	6a 7d                	push   $0x7d
80106a10:	e9 b5 f6 ff ff       	jmp    801060ca <alltraps>

80106a15 <vector126>:
80106a15:	6a 00                	push   $0x0
80106a17:	6a 7e                	push   $0x7e
80106a19:	e9 ac f6 ff ff       	jmp    801060ca <alltraps>

80106a1e <vector127>:
80106a1e:	6a 00                	push   $0x0
80106a20:	6a 7f                	push   $0x7f
80106a22:	e9 a3 f6 ff ff       	jmp    801060ca <alltraps>

80106a27 <vector128>:
80106a27:	6a 00                	push   $0x0
80106a29:	68 80 00 00 00       	push   $0x80
80106a2e:	e9 97 f6 ff ff       	jmp    801060ca <alltraps>

80106a33 <vector129>:
80106a33:	6a 00                	push   $0x0
80106a35:	68 81 00 00 00       	push   $0x81
80106a3a:	e9 8b f6 ff ff       	jmp    801060ca <alltraps>

80106a3f <vector130>:
80106a3f:	6a 00                	push   $0x0
80106a41:	68 82 00 00 00       	push   $0x82
80106a46:	e9 7f f6 ff ff       	jmp    801060ca <alltraps>

80106a4b <vector131>:
80106a4b:	6a 00                	push   $0x0
80106a4d:	68 83 00 00 00       	push   $0x83
80106a52:	e9 73 f6 ff ff       	jmp    801060ca <alltraps>

80106a57 <vector132>:
80106a57:	6a 00                	push   $0x0
80106a59:	68 84 00 00 00       	push   $0x84
80106a5e:	e9 67 f6 ff ff       	jmp    801060ca <alltraps>

80106a63 <vector133>:
80106a63:	6a 00                	push   $0x0
80106a65:	68 85 00 00 00       	push   $0x85
80106a6a:	e9 5b f6 ff ff       	jmp    801060ca <alltraps>

80106a6f <vector134>:
80106a6f:	6a 00                	push   $0x0
80106a71:	68 86 00 00 00       	push   $0x86
80106a76:	e9 4f f6 ff ff       	jmp    801060ca <alltraps>

80106a7b <vector135>:
80106a7b:	6a 00                	push   $0x0
80106a7d:	68 87 00 00 00       	push   $0x87
80106a82:	e9 43 f6 ff ff       	jmp    801060ca <alltraps>

80106a87 <vector136>:
80106a87:	6a 00                	push   $0x0
80106a89:	68 88 00 00 00       	push   $0x88
80106a8e:	e9 37 f6 ff ff       	jmp    801060ca <alltraps>

80106a93 <vector137>:
80106a93:	6a 00                	push   $0x0
80106a95:	68 89 00 00 00       	push   $0x89
80106a9a:	e9 2b f6 ff ff       	jmp    801060ca <alltraps>

80106a9f <vector138>:
80106a9f:	6a 00                	push   $0x0
80106aa1:	68 8a 00 00 00       	push   $0x8a
80106aa6:	e9 1f f6 ff ff       	jmp    801060ca <alltraps>

80106aab <vector139>:
80106aab:	6a 00                	push   $0x0
80106aad:	68 8b 00 00 00       	push   $0x8b
80106ab2:	e9 13 f6 ff ff       	jmp    801060ca <alltraps>

80106ab7 <vector140>:
80106ab7:	6a 00                	push   $0x0
80106ab9:	68 8c 00 00 00       	push   $0x8c
80106abe:	e9 07 f6 ff ff       	jmp    801060ca <alltraps>

80106ac3 <vector141>:
80106ac3:	6a 00                	push   $0x0
80106ac5:	68 8d 00 00 00       	push   $0x8d
80106aca:	e9 fb f5 ff ff       	jmp    801060ca <alltraps>

80106acf <vector142>:
80106acf:	6a 00                	push   $0x0
80106ad1:	68 8e 00 00 00       	push   $0x8e
80106ad6:	e9 ef f5 ff ff       	jmp    801060ca <alltraps>

80106adb <vector143>:
80106adb:	6a 00                	push   $0x0
80106add:	68 8f 00 00 00       	push   $0x8f
80106ae2:	e9 e3 f5 ff ff       	jmp    801060ca <alltraps>

80106ae7 <vector144>:
80106ae7:	6a 00                	push   $0x0
80106ae9:	68 90 00 00 00       	push   $0x90
80106aee:	e9 d7 f5 ff ff       	jmp    801060ca <alltraps>

80106af3 <vector145>:
80106af3:	6a 00                	push   $0x0
80106af5:	68 91 00 00 00       	push   $0x91
80106afa:	e9 cb f5 ff ff       	jmp    801060ca <alltraps>

80106aff <vector146>:
80106aff:	6a 00                	push   $0x0
80106b01:	68 92 00 00 00       	push   $0x92
80106b06:	e9 bf f5 ff ff       	jmp    801060ca <alltraps>

80106b0b <vector147>:
80106b0b:	6a 00                	push   $0x0
80106b0d:	68 93 00 00 00       	push   $0x93
80106b12:	e9 b3 f5 ff ff       	jmp    801060ca <alltraps>

80106b17 <vector148>:
80106b17:	6a 00                	push   $0x0
80106b19:	68 94 00 00 00       	push   $0x94
80106b1e:	e9 a7 f5 ff ff       	jmp    801060ca <alltraps>

80106b23 <vector149>:
80106b23:	6a 00                	push   $0x0
80106b25:	68 95 00 00 00       	push   $0x95
80106b2a:	e9 9b f5 ff ff       	jmp    801060ca <alltraps>

80106b2f <vector150>:
80106b2f:	6a 00                	push   $0x0
80106b31:	68 96 00 00 00       	push   $0x96
80106b36:	e9 8f f5 ff ff       	jmp    801060ca <alltraps>

80106b3b <vector151>:
80106b3b:	6a 00                	push   $0x0
80106b3d:	68 97 00 00 00       	push   $0x97
80106b42:	e9 83 f5 ff ff       	jmp    801060ca <alltraps>

80106b47 <vector152>:
80106b47:	6a 00                	push   $0x0
80106b49:	68 98 00 00 00       	push   $0x98
80106b4e:	e9 77 f5 ff ff       	jmp    801060ca <alltraps>

80106b53 <vector153>:
80106b53:	6a 00                	push   $0x0
80106b55:	68 99 00 00 00       	push   $0x99
80106b5a:	e9 6b f5 ff ff       	jmp    801060ca <alltraps>

80106b5f <vector154>:
80106b5f:	6a 00                	push   $0x0
80106b61:	68 9a 00 00 00       	push   $0x9a
80106b66:	e9 5f f5 ff ff       	jmp    801060ca <alltraps>

80106b6b <vector155>:
80106b6b:	6a 00                	push   $0x0
80106b6d:	68 9b 00 00 00       	push   $0x9b
80106b72:	e9 53 f5 ff ff       	jmp    801060ca <alltraps>

80106b77 <vector156>:
80106b77:	6a 00                	push   $0x0
80106b79:	68 9c 00 00 00       	push   $0x9c
80106b7e:	e9 47 f5 ff ff       	jmp    801060ca <alltraps>

80106b83 <vector157>:
80106b83:	6a 00                	push   $0x0
80106b85:	68 9d 00 00 00       	push   $0x9d
80106b8a:	e9 3b f5 ff ff       	jmp    801060ca <alltraps>

80106b8f <vector158>:
80106b8f:	6a 00                	push   $0x0
80106b91:	68 9e 00 00 00       	push   $0x9e
80106b96:	e9 2f f5 ff ff       	jmp    801060ca <alltraps>

80106b9b <vector159>:
80106b9b:	6a 00                	push   $0x0
80106b9d:	68 9f 00 00 00       	push   $0x9f
80106ba2:	e9 23 f5 ff ff       	jmp    801060ca <alltraps>

80106ba7 <vector160>:
80106ba7:	6a 00                	push   $0x0
80106ba9:	68 a0 00 00 00       	push   $0xa0
80106bae:	e9 17 f5 ff ff       	jmp    801060ca <alltraps>

80106bb3 <vector161>:
80106bb3:	6a 00                	push   $0x0
80106bb5:	68 a1 00 00 00       	push   $0xa1
80106bba:	e9 0b f5 ff ff       	jmp    801060ca <alltraps>

80106bbf <vector162>:
80106bbf:	6a 00                	push   $0x0
80106bc1:	68 a2 00 00 00       	push   $0xa2
80106bc6:	e9 ff f4 ff ff       	jmp    801060ca <alltraps>

80106bcb <vector163>:
80106bcb:	6a 00                	push   $0x0
80106bcd:	68 a3 00 00 00       	push   $0xa3
80106bd2:	e9 f3 f4 ff ff       	jmp    801060ca <alltraps>

80106bd7 <vector164>:
80106bd7:	6a 00                	push   $0x0
80106bd9:	68 a4 00 00 00       	push   $0xa4
80106bde:	e9 e7 f4 ff ff       	jmp    801060ca <alltraps>

80106be3 <vector165>:
80106be3:	6a 00                	push   $0x0
80106be5:	68 a5 00 00 00       	push   $0xa5
80106bea:	e9 db f4 ff ff       	jmp    801060ca <alltraps>

80106bef <vector166>:
80106bef:	6a 00                	push   $0x0
80106bf1:	68 a6 00 00 00       	push   $0xa6
80106bf6:	e9 cf f4 ff ff       	jmp    801060ca <alltraps>

80106bfb <vector167>:
80106bfb:	6a 00                	push   $0x0
80106bfd:	68 a7 00 00 00       	push   $0xa7
80106c02:	e9 c3 f4 ff ff       	jmp    801060ca <alltraps>

80106c07 <vector168>:
80106c07:	6a 00                	push   $0x0
80106c09:	68 a8 00 00 00       	push   $0xa8
80106c0e:	e9 b7 f4 ff ff       	jmp    801060ca <alltraps>

80106c13 <vector169>:
80106c13:	6a 00                	push   $0x0
80106c15:	68 a9 00 00 00       	push   $0xa9
80106c1a:	e9 ab f4 ff ff       	jmp    801060ca <alltraps>

80106c1f <vector170>:
80106c1f:	6a 00                	push   $0x0
80106c21:	68 aa 00 00 00       	push   $0xaa
80106c26:	e9 9f f4 ff ff       	jmp    801060ca <alltraps>

80106c2b <vector171>:
80106c2b:	6a 00                	push   $0x0
80106c2d:	68 ab 00 00 00       	push   $0xab
80106c32:	e9 93 f4 ff ff       	jmp    801060ca <alltraps>

80106c37 <vector172>:
80106c37:	6a 00                	push   $0x0
80106c39:	68 ac 00 00 00       	push   $0xac
80106c3e:	e9 87 f4 ff ff       	jmp    801060ca <alltraps>

80106c43 <vector173>:
80106c43:	6a 00                	push   $0x0
80106c45:	68 ad 00 00 00       	push   $0xad
80106c4a:	e9 7b f4 ff ff       	jmp    801060ca <alltraps>

80106c4f <vector174>:
80106c4f:	6a 00                	push   $0x0
80106c51:	68 ae 00 00 00       	push   $0xae
80106c56:	e9 6f f4 ff ff       	jmp    801060ca <alltraps>

80106c5b <vector175>:
80106c5b:	6a 00                	push   $0x0
80106c5d:	68 af 00 00 00       	push   $0xaf
80106c62:	e9 63 f4 ff ff       	jmp    801060ca <alltraps>

80106c67 <vector176>:
80106c67:	6a 00                	push   $0x0
80106c69:	68 b0 00 00 00       	push   $0xb0
80106c6e:	e9 57 f4 ff ff       	jmp    801060ca <alltraps>

80106c73 <vector177>:
80106c73:	6a 00                	push   $0x0
80106c75:	68 b1 00 00 00       	push   $0xb1
80106c7a:	e9 4b f4 ff ff       	jmp    801060ca <alltraps>

80106c7f <vector178>:
80106c7f:	6a 00                	push   $0x0
80106c81:	68 b2 00 00 00       	push   $0xb2
80106c86:	e9 3f f4 ff ff       	jmp    801060ca <alltraps>

80106c8b <vector179>:
80106c8b:	6a 00                	push   $0x0
80106c8d:	68 b3 00 00 00       	push   $0xb3
80106c92:	e9 33 f4 ff ff       	jmp    801060ca <alltraps>

80106c97 <vector180>:
80106c97:	6a 00                	push   $0x0
80106c99:	68 b4 00 00 00       	push   $0xb4
80106c9e:	e9 27 f4 ff ff       	jmp    801060ca <alltraps>

80106ca3 <vector181>:
80106ca3:	6a 00                	push   $0x0
80106ca5:	68 b5 00 00 00       	push   $0xb5
80106caa:	e9 1b f4 ff ff       	jmp    801060ca <alltraps>

80106caf <vector182>:
80106caf:	6a 00                	push   $0x0
80106cb1:	68 b6 00 00 00       	push   $0xb6
80106cb6:	e9 0f f4 ff ff       	jmp    801060ca <alltraps>

80106cbb <vector183>:
80106cbb:	6a 00                	push   $0x0
80106cbd:	68 b7 00 00 00       	push   $0xb7
80106cc2:	e9 03 f4 ff ff       	jmp    801060ca <alltraps>

80106cc7 <vector184>:
80106cc7:	6a 00                	push   $0x0
80106cc9:	68 b8 00 00 00       	push   $0xb8
80106cce:	e9 f7 f3 ff ff       	jmp    801060ca <alltraps>

80106cd3 <vector185>:
80106cd3:	6a 00                	push   $0x0
80106cd5:	68 b9 00 00 00       	push   $0xb9
80106cda:	e9 eb f3 ff ff       	jmp    801060ca <alltraps>

80106cdf <vector186>:
80106cdf:	6a 00                	push   $0x0
80106ce1:	68 ba 00 00 00       	push   $0xba
80106ce6:	e9 df f3 ff ff       	jmp    801060ca <alltraps>

80106ceb <vector187>:
80106ceb:	6a 00                	push   $0x0
80106ced:	68 bb 00 00 00       	push   $0xbb
80106cf2:	e9 d3 f3 ff ff       	jmp    801060ca <alltraps>

80106cf7 <vector188>:
80106cf7:	6a 00                	push   $0x0
80106cf9:	68 bc 00 00 00       	push   $0xbc
80106cfe:	e9 c7 f3 ff ff       	jmp    801060ca <alltraps>

80106d03 <vector189>:
80106d03:	6a 00                	push   $0x0
80106d05:	68 bd 00 00 00       	push   $0xbd
80106d0a:	e9 bb f3 ff ff       	jmp    801060ca <alltraps>

80106d0f <vector190>:
80106d0f:	6a 00                	push   $0x0
80106d11:	68 be 00 00 00       	push   $0xbe
80106d16:	e9 af f3 ff ff       	jmp    801060ca <alltraps>

80106d1b <vector191>:
80106d1b:	6a 00                	push   $0x0
80106d1d:	68 bf 00 00 00       	push   $0xbf
80106d22:	e9 a3 f3 ff ff       	jmp    801060ca <alltraps>

80106d27 <vector192>:
80106d27:	6a 00                	push   $0x0
80106d29:	68 c0 00 00 00       	push   $0xc0
80106d2e:	e9 97 f3 ff ff       	jmp    801060ca <alltraps>

80106d33 <vector193>:
80106d33:	6a 00                	push   $0x0
80106d35:	68 c1 00 00 00       	push   $0xc1
80106d3a:	e9 8b f3 ff ff       	jmp    801060ca <alltraps>

80106d3f <vector194>:
80106d3f:	6a 00                	push   $0x0
80106d41:	68 c2 00 00 00       	push   $0xc2
80106d46:	e9 7f f3 ff ff       	jmp    801060ca <alltraps>

80106d4b <vector195>:
80106d4b:	6a 00                	push   $0x0
80106d4d:	68 c3 00 00 00       	push   $0xc3
80106d52:	e9 73 f3 ff ff       	jmp    801060ca <alltraps>

80106d57 <vector196>:
80106d57:	6a 00                	push   $0x0
80106d59:	68 c4 00 00 00       	push   $0xc4
80106d5e:	e9 67 f3 ff ff       	jmp    801060ca <alltraps>

80106d63 <vector197>:
80106d63:	6a 00                	push   $0x0
80106d65:	68 c5 00 00 00       	push   $0xc5
80106d6a:	e9 5b f3 ff ff       	jmp    801060ca <alltraps>

80106d6f <vector198>:
80106d6f:	6a 00                	push   $0x0
80106d71:	68 c6 00 00 00       	push   $0xc6
80106d76:	e9 4f f3 ff ff       	jmp    801060ca <alltraps>

80106d7b <vector199>:
80106d7b:	6a 00                	push   $0x0
80106d7d:	68 c7 00 00 00       	push   $0xc7
80106d82:	e9 43 f3 ff ff       	jmp    801060ca <alltraps>

80106d87 <vector200>:
80106d87:	6a 00                	push   $0x0
80106d89:	68 c8 00 00 00       	push   $0xc8
80106d8e:	e9 37 f3 ff ff       	jmp    801060ca <alltraps>

80106d93 <vector201>:
80106d93:	6a 00                	push   $0x0
80106d95:	68 c9 00 00 00       	push   $0xc9
80106d9a:	e9 2b f3 ff ff       	jmp    801060ca <alltraps>

80106d9f <vector202>:
80106d9f:	6a 00                	push   $0x0
80106da1:	68 ca 00 00 00       	push   $0xca
80106da6:	e9 1f f3 ff ff       	jmp    801060ca <alltraps>

80106dab <vector203>:
80106dab:	6a 00                	push   $0x0
80106dad:	68 cb 00 00 00       	push   $0xcb
80106db2:	e9 13 f3 ff ff       	jmp    801060ca <alltraps>

80106db7 <vector204>:
80106db7:	6a 00                	push   $0x0
80106db9:	68 cc 00 00 00       	push   $0xcc
80106dbe:	e9 07 f3 ff ff       	jmp    801060ca <alltraps>

80106dc3 <vector205>:
80106dc3:	6a 00                	push   $0x0
80106dc5:	68 cd 00 00 00       	push   $0xcd
80106dca:	e9 fb f2 ff ff       	jmp    801060ca <alltraps>

80106dcf <vector206>:
80106dcf:	6a 00                	push   $0x0
80106dd1:	68 ce 00 00 00       	push   $0xce
80106dd6:	e9 ef f2 ff ff       	jmp    801060ca <alltraps>

80106ddb <vector207>:
80106ddb:	6a 00                	push   $0x0
80106ddd:	68 cf 00 00 00       	push   $0xcf
80106de2:	e9 e3 f2 ff ff       	jmp    801060ca <alltraps>

80106de7 <vector208>:
80106de7:	6a 00                	push   $0x0
80106de9:	68 d0 00 00 00       	push   $0xd0
80106dee:	e9 d7 f2 ff ff       	jmp    801060ca <alltraps>

80106df3 <vector209>:
80106df3:	6a 00                	push   $0x0
80106df5:	68 d1 00 00 00       	push   $0xd1
80106dfa:	e9 cb f2 ff ff       	jmp    801060ca <alltraps>

80106dff <vector210>:
80106dff:	6a 00                	push   $0x0
80106e01:	68 d2 00 00 00       	push   $0xd2
80106e06:	e9 bf f2 ff ff       	jmp    801060ca <alltraps>

80106e0b <vector211>:
80106e0b:	6a 00                	push   $0x0
80106e0d:	68 d3 00 00 00       	push   $0xd3
80106e12:	e9 b3 f2 ff ff       	jmp    801060ca <alltraps>

80106e17 <vector212>:
80106e17:	6a 00                	push   $0x0
80106e19:	68 d4 00 00 00       	push   $0xd4
80106e1e:	e9 a7 f2 ff ff       	jmp    801060ca <alltraps>

80106e23 <vector213>:
80106e23:	6a 00                	push   $0x0
80106e25:	68 d5 00 00 00       	push   $0xd5
80106e2a:	e9 9b f2 ff ff       	jmp    801060ca <alltraps>

80106e2f <vector214>:
80106e2f:	6a 00                	push   $0x0
80106e31:	68 d6 00 00 00       	push   $0xd6
80106e36:	e9 8f f2 ff ff       	jmp    801060ca <alltraps>

80106e3b <vector215>:
80106e3b:	6a 00                	push   $0x0
80106e3d:	68 d7 00 00 00       	push   $0xd7
80106e42:	e9 83 f2 ff ff       	jmp    801060ca <alltraps>

80106e47 <vector216>:
80106e47:	6a 00                	push   $0x0
80106e49:	68 d8 00 00 00       	push   $0xd8
80106e4e:	e9 77 f2 ff ff       	jmp    801060ca <alltraps>

80106e53 <vector217>:
80106e53:	6a 00                	push   $0x0
80106e55:	68 d9 00 00 00       	push   $0xd9
80106e5a:	e9 6b f2 ff ff       	jmp    801060ca <alltraps>

80106e5f <vector218>:
80106e5f:	6a 00                	push   $0x0
80106e61:	68 da 00 00 00       	push   $0xda
80106e66:	e9 5f f2 ff ff       	jmp    801060ca <alltraps>

80106e6b <vector219>:
80106e6b:	6a 00                	push   $0x0
80106e6d:	68 db 00 00 00       	push   $0xdb
80106e72:	e9 53 f2 ff ff       	jmp    801060ca <alltraps>

80106e77 <vector220>:
80106e77:	6a 00                	push   $0x0
80106e79:	68 dc 00 00 00       	push   $0xdc
80106e7e:	e9 47 f2 ff ff       	jmp    801060ca <alltraps>

80106e83 <vector221>:
80106e83:	6a 00                	push   $0x0
80106e85:	68 dd 00 00 00       	push   $0xdd
80106e8a:	e9 3b f2 ff ff       	jmp    801060ca <alltraps>

80106e8f <vector222>:
80106e8f:	6a 00                	push   $0x0
80106e91:	68 de 00 00 00       	push   $0xde
80106e96:	e9 2f f2 ff ff       	jmp    801060ca <alltraps>

80106e9b <vector223>:
80106e9b:	6a 00                	push   $0x0
80106e9d:	68 df 00 00 00       	push   $0xdf
80106ea2:	e9 23 f2 ff ff       	jmp    801060ca <alltraps>

80106ea7 <vector224>:
80106ea7:	6a 00                	push   $0x0
80106ea9:	68 e0 00 00 00       	push   $0xe0
80106eae:	e9 17 f2 ff ff       	jmp    801060ca <alltraps>

80106eb3 <vector225>:
80106eb3:	6a 00                	push   $0x0
80106eb5:	68 e1 00 00 00       	push   $0xe1
80106eba:	e9 0b f2 ff ff       	jmp    801060ca <alltraps>

80106ebf <vector226>:
80106ebf:	6a 00                	push   $0x0
80106ec1:	68 e2 00 00 00       	push   $0xe2
80106ec6:	e9 ff f1 ff ff       	jmp    801060ca <alltraps>

80106ecb <vector227>:
80106ecb:	6a 00                	push   $0x0
80106ecd:	68 e3 00 00 00       	push   $0xe3
80106ed2:	e9 f3 f1 ff ff       	jmp    801060ca <alltraps>

80106ed7 <vector228>:
80106ed7:	6a 00                	push   $0x0
80106ed9:	68 e4 00 00 00       	push   $0xe4
80106ede:	e9 e7 f1 ff ff       	jmp    801060ca <alltraps>

80106ee3 <vector229>:
80106ee3:	6a 00                	push   $0x0
80106ee5:	68 e5 00 00 00       	push   $0xe5
80106eea:	e9 db f1 ff ff       	jmp    801060ca <alltraps>

80106eef <vector230>:
80106eef:	6a 00                	push   $0x0
80106ef1:	68 e6 00 00 00       	push   $0xe6
80106ef6:	e9 cf f1 ff ff       	jmp    801060ca <alltraps>

80106efb <vector231>:
80106efb:	6a 00                	push   $0x0
80106efd:	68 e7 00 00 00       	push   $0xe7
80106f02:	e9 c3 f1 ff ff       	jmp    801060ca <alltraps>

80106f07 <vector232>:
80106f07:	6a 00                	push   $0x0
80106f09:	68 e8 00 00 00       	push   $0xe8
80106f0e:	e9 b7 f1 ff ff       	jmp    801060ca <alltraps>

80106f13 <vector233>:
80106f13:	6a 00                	push   $0x0
80106f15:	68 e9 00 00 00       	push   $0xe9
80106f1a:	e9 ab f1 ff ff       	jmp    801060ca <alltraps>

80106f1f <vector234>:
80106f1f:	6a 00                	push   $0x0
80106f21:	68 ea 00 00 00       	push   $0xea
80106f26:	e9 9f f1 ff ff       	jmp    801060ca <alltraps>

80106f2b <vector235>:
80106f2b:	6a 00                	push   $0x0
80106f2d:	68 eb 00 00 00       	push   $0xeb
80106f32:	e9 93 f1 ff ff       	jmp    801060ca <alltraps>

80106f37 <vector236>:
80106f37:	6a 00                	push   $0x0
80106f39:	68 ec 00 00 00       	push   $0xec
80106f3e:	e9 87 f1 ff ff       	jmp    801060ca <alltraps>

80106f43 <vector237>:
80106f43:	6a 00                	push   $0x0
80106f45:	68 ed 00 00 00       	push   $0xed
80106f4a:	e9 7b f1 ff ff       	jmp    801060ca <alltraps>

80106f4f <vector238>:
80106f4f:	6a 00                	push   $0x0
80106f51:	68 ee 00 00 00       	push   $0xee
80106f56:	e9 6f f1 ff ff       	jmp    801060ca <alltraps>

80106f5b <vector239>:
80106f5b:	6a 00                	push   $0x0
80106f5d:	68 ef 00 00 00       	push   $0xef
80106f62:	e9 63 f1 ff ff       	jmp    801060ca <alltraps>

80106f67 <vector240>:
80106f67:	6a 00                	push   $0x0
80106f69:	68 f0 00 00 00       	push   $0xf0
80106f6e:	e9 57 f1 ff ff       	jmp    801060ca <alltraps>

80106f73 <vector241>:
80106f73:	6a 00                	push   $0x0
80106f75:	68 f1 00 00 00       	push   $0xf1
80106f7a:	e9 4b f1 ff ff       	jmp    801060ca <alltraps>

80106f7f <vector242>:
80106f7f:	6a 00                	push   $0x0
80106f81:	68 f2 00 00 00       	push   $0xf2
80106f86:	e9 3f f1 ff ff       	jmp    801060ca <alltraps>

80106f8b <vector243>:
80106f8b:	6a 00                	push   $0x0
80106f8d:	68 f3 00 00 00       	push   $0xf3
80106f92:	e9 33 f1 ff ff       	jmp    801060ca <alltraps>

80106f97 <vector244>:
80106f97:	6a 00                	push   $0x0
80106f99:	68 f4 00 00 00       	push   $0xf4
80106f9e:	e9 27 f1 ff ff       	jmp    801060ca <alltraps>

80106fa3 <vector245>:
80106fa3:	6a 00                	push   $0x0
80106fa5:	68 f5 00 00 00       	push   $0xf5
80106faa:	e9 1b f1 ff ff       	jmp    801060ca <alltraps>

80106faf <vector246>:
80106faf:	6a 00                	push   $0x0
80106fb1:	68 f6 00 00 00       	push   $0xf6
80106fb6:	e9 0f f1 ff ff       	jmp    801060ca <alltraps>

80106fbb <vector247>:
80106fbb:	6a 00                	push   $0x0
80106fbd:	68 f7 00 00 00       	push   $0xf7
80106fc2:	e9 03 f1 ff ff       	jmp    801060ca <alltraps>

80106fc7 <vector248>:
80106fc7:	6a 00                	push   $0x0
80106fc9:	68 f8 00 00 00       	push   $0xf8
80106fce:	e9 f7 f0 ff ff       	jmp    801060ca <alltraps>

80106fd3 <vector249>:
80106fd3:	6a 00                	push   $0x0
80106fd5:	68 f9 00 00 00       	push   $0xf9
80106fda:	e9 eb f0 ff ff       	jmp    801060ca <alltraps>

80106fdf <vector250>:
80106fdf:	6a 00                	push   $0x0
80106fe1:	68 fa 00 00 00       	push   $0xfa
80106fe6:	e9 df f0 ff ff       	jmp    801060ca <alltraps>

80106feb <vector251>:
80106feb:	6a 00                	push   $0x0
80106fed:	68 fb 00 00 00       	push   $0xfb
80106ff2:	e9 d3 f0 ff ff       	jmp    801060ca <alltraps>

80106ff7 <vector252>:
80106ff7:	6a 00                	push   $0x0
80106ff9:	68 fc 00 00 00       	push   $0xfc
80106ffe:	e9 c7 f0 ff ff       	jmp    801060ca <alltraps>

80107003 <vector253>:
80107003:	6a 00                	push   $0x0
80107005:	68 fd 00 00 00       	push   $0xfd
8010700a:	e9 bb f0 ff ff       	jmp    801060ca <alltraps>

8010700f <vector254>:
8010700f:	6a 00                	push   $0x0
80107011:	68 fe 00 00 00       	push   $0xfe
80107016:	e9 af f0 ff ff       	jmp    801060ca <alltraps>

8010701b <vector255>:
8010701b:	6a 00                	push   $0x0
8010701d:	68 ff 00 00 00       	push   $0xff
80107022:	e9 a3 f0 ff ff       	jmp    801060ca <alltraps>
80107027:	66 90                	xchg   %ax,%ax
80107029:	66 90                	xchg   %ax,%ax
8010702b:	66 90                	xchg   %ax,%ax
8010702d:	66 90                	xchg   %ax,%ax
8010702f:	90                   	nop

80107030 <deallocuvm.part.0>:
80107030:	55                   	push   %ebp
80107031:	89 e5                	mov    %esp,%ebp
80107033:	57                   	push   %edi
80107034:	56                   	push   %esi
80107035:	53                   	push   %ebx
80107036:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
8010703c:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107042:	83 ec 1c             	sub    $0x1c,%esp
80107045:	39 d3                	cmp    %edx,%ebx
80107047:	73 56                	jae    8010709f <deallocuvm.part.0+0x6f>
80107049:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010704c:	89 c6                	mov    %eax,%esi
8010704e:	89 d7                	mov    %edx,%edi
80107050:	eb 12                	jmp    80107064 <deallocuvm.part.0+0x34>
80107052:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107058:	83 c2 01             	add    $0x1,%edx
8010705b:	89 d3                	mov    %edx,%ebx
8010705d:	c1 e3 16             	shl    $0x16,%ebx
80107060:	39 fb                	cmp    %edi,%ebx
80107062:	73 38                	jae    8010709c <deallocuvm.part.0+0x6c>
80107064:	89 da                	mov    %ebx,%edx
80107066:	c1 ea 16             	shr    $0x16,%edx
80107069:	8b 04 96             	mov    (%esi,%edx,4),%eax
8010706c:	a8 01                	test   $0x1,%al
8010706e:	74 e8                	je     80107058 <deallocuvm.part.0+0x28>
80107070:	89 d9                	mov    %ebx,%ecx
80107072:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107077:	c1 e9 0a             	shr    $0xa,%ecx
8010707a:	81 e1 fc 0f 00 00    	and    $0xffc,%ecx
80107080:	8d 84 08 00 00 00 80 	lea    -0x80000000(%eax,%ecx,1),%eax
80107087:	85 c0                	test   %eax,%eax
80107089:	74 cd                	je     80107058 <deallocuvm.part.0+0x28>
8010708b:	8b 10                	mov    (%eax),%edx
8010708d:	f6 c2 01             	test   $0x1,%dl
80107090:	75 1e                	jne    801070b0 <deallocuvm.part.0+0x80>
80107092:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107098:	39 fb                	cmp    %edi,%ebx
8010709a:	72 c8                	jb     80107064 <deallocuvm.part.0+0x34>
8010709c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010709f:	8d 65 f4             	lea    -0xc(%ebp),%esp
801070a2:	89 c8                	mov    %ecx,%eax
801070a4:	5b                   	pop    %ebx
801070a5:	5e                   	pop    %esi
801070a6:	5f                   	pop    %edi
801070a7:	5d                   	pop    %ebp
801070a8:	c3                   	ret
801070a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801070b0:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801070b6:	74 26                	je     801070de <deallocuvm.part.0+0xae>
801070b8:	83 ec 0c             	sub    $0xc,%esp
801070bb:	81 c2 00 00 00 80    	add    $0x80000000,%edx
801070c1:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801070c4:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801070ca:	52                   	push   %edx
801070cb:	e8 50 bc ff ff       	call   80102d20 <kfree>
801070d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801070d3:	83 c4 10             	add    $0x10,%esp
801070d6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801070dc:	eb 82                	jmp    80107060 <deallocuvm.part.0+0x30>
801070de:	83 ec 0c             	sub    $0xc,%esp
801070e1:	68 cc 7b 10 80       	push   $0x80107bcc
801070e6:	e8 b5 92 ff ff       	call   801003a0 <panic>
801070eb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

801070f0 <mappages>:
801070f0:	55                   	push   %ebp
801070f1:	89 e5                	mov    %esp,%ebp
801070f3:	57                   	push   %edi
801070f4:	56                   	push   %esi
801070f5:	53                   	push   %ebx
801070f6:	89 d3                	mov    %edx,%ebx
801070f8:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
801070fe:	83 ec 1c             	sub    $0x1c,%esp
80107101:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107104:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80107108:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010710d:	89 45 dc             	mov    %eax,-0x24(%ebp)
80107110:	8b 45 08             	mov    0x8(%ebp),%eax
80107113:	29 d8                	sub    %ebx,%eax
80107115:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107118:	eb 3f                	jmp    80107159 <mappages+0x69>
8010711a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107120:	89 da                	mov    %ebx,%edx
80107122:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107127:	c1 ea 0a             	shr    $0xa,%edx
8010712a:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107130:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
80107137:	85 c0                	test   %eax,%eax
80107139:	74 75                	je     801071b0 <mappages+0xc0>
8010713b:	f6 00 01             	testb  $0x1,(%eax)
8010713e:	0f 85 86 00 00 00    	jne    801071ca <mappages+0xda>
80107144:	0b 75 0c             	or     0xc(%ebp),%esi
80107147:	83 ce 01             	or     $0x1,%esi
8010714a:	89 30                	mov    %esi,(%eax)
8010714c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010714f:	39 c3                	cmp    %eax,%ebx
80107151:	74 6d                	je     801071c0 <mappages+0xd0>
80107153:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107159:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010715c:	8b 4d e0             	mov    -0x20(%ebp),%ecx
8010715f:	8d 34 03             	lea    (%ebx,%eax,1),%esi
80107162:	89 d8                	mov    %ebx,%eax
80107164:	c1 e8 16             	shr    $0x16,%eax
80107167:	8d 3c 81             	lea    (%ecx,%eax,4),%edi
8010716a:	8b 07                	mov    (%edi),%eax
8010716c:	a8 01                	test   $0x1,%al
8010716e:	75 b0                	jne    80107120 <mappages+0x30>
80107170:	e8 6b bd ff ff       	call   80102ee0 <kalloc>
80107175:	85 c0                	test   %eax,%eax
80107177:	74 37                	je     801071b0 <mappages+0xc0>
80107179:	83 ec 04             	sub    $0x4,%esp
8010717c:	68 00 10 00 00       	push   $0x1000
80107181:	6a 00                	push   $0x0
80107183:	50                   	push   %eax
80107184:	89 45 d8             	mov    %eax,-0x28(%ebp)
80107187:	e8 a4 dd ff ff       	call   80104f30 <memset>
8010718c:	8b 55 d8             	mov    -0x28(%ebp),%edx
8010718f:	83 c4 10             	add    $0x10,%esp
80107192:	8d 82 00 00 00 80    	lea    -0x80000000(%edx),%eax
80107198:	83 c8 07             	or     $0x7,%eax
8010719b:	89 07                	mov    %eax,(%edi)
8010719d:	89 d8                	mov    %ebx,%eax
8010719f:	c1 e8 0a             	shr    $0xa,%eax
801071a2:	25 fc 0f 00 00       	and    $0xffc,%eax
801071a7:	01 d0                	add    %edx,%eax
801071a9:	eb 90                	jmp    8010713b <mappages+0x4b>
801071ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
801071b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801071b3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801071b8:	5b                   	pop    %ebx
801071b9:	5e                   	pop    %esi
801071ba:	5f                   	pop    %edi
801071bb:	5d                   	pop    %ebp
801071bc:	c3                   	ret
801071bd:	8d 76 00             	lea    0x0(%esi),%esi
801071c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801071c3:	31 c0                	xor    %eax,%eax
801071c5:	5b                   	pop    %ebx
801071c6:	5e                   	pop    %esi
801071c7:	5f                   	pop    %edi
801071c8:	5d                   	pop    %ebp
801071c9:	c3                   	ret
801071ca:	83 ec 0c             	sub    $0xc,%esp
801071cd:	68 00 7e 10 80       	push   $0x80107e00
801071d2:	e8 c9 91 ff ff       	call   801003a0 <panic>
801071d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801071de:	00 
801071df:	90                   	nop

801071e0 <seginit>:
801071e0:	55                   	push   %ebp
801071e1:	89 e5                	mov    %esp,%ebp
801071e3:	83 ec 18             	sub    $0x18,%esp
801071e6:	e8 e5 cf ff ff       	call   801041d0 <cpuid>
801071eb:	ba 2f 00 00 00       	mov    $0x2f,%edx
801071f0:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
801071f6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
801071fa:	c7 80 58 2f 11 80 ff 	movl   $0xffff,-0x7feed0a8(%eax)
80107201:	ff 00 00 
80107204:	c7 80 5c 2f 11 80 00 	movl   $0xcf9a00,-0x7feed0a4(%eax)
8010720b:	9a cf 00 
8010720e:	c7 80 60 2f 11 80 ff 	movl   $0xffff,-0x7feed0a0(%eax)
80107215:	ff 00 00 
80107218:	c7 80 64 2f 11 80 00 	movl   $0xcf9200,-0x7feed09c(%eax)
8010721f:	92 cf 00 
80107222:	c7 80 68 2f 11 80 ff 	movl   $0xffff,-0x7feed098(%eax)
80107229:	ff 00 00 
8010722c:	c7 80 6c 2f 11 80 00 	movl   $0xcffa00,-0x7feed094(%eax)
80107233:	fa cf 00 
80107236:	c7 80 70 2f 11 80 ff 	movl   $0xffff,-0x7feed090(%eax)
8010723d:	ff 00 00 
80107240:	c7 80 74 2f 11 80 00 	movl   $0xcff200,-0x7feed08c(%eax)
80107247:	f2 cf 00 
8010724a:	05 50 2f 11 80       	add    $0x80112f50,%eax
8010724f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
80107253:	c1 e8 10             	shr    $0x10,%eax
80107256:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
8010725a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010725d:	0f 01 10             	lgdtl  (%eax)
80107260:	c9                   	leave
80107261:	c3                   	ret
80107262:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
80107269:	00 
8010726a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107270 <switchkvm>:
80107270:	a1 04 5c 11 80       	mov    0x80115c04,%eax
80107275:	05 00 00 00 80       	add    $0x80000000,%eax
8010727a:	0f 22 d8             	mov    %eax,%cr3
8010727d:	c3                   	ret
8010727e:	66 90                	xchg   %ax,%ax

80107280 <switchuvm>:
80107280:	55                   	push   %ebp
80107281:	89 e5                	mov    %esp,%ebp
80107283:	57                   	push   %edi
80107284:	56                   	push   %esi
80107285:	53                   	push   %ebx
80107286:	83 ec 1c             	sub    $0x1c,%esp
80107289:	8b 75 08             	mov    0x8(%ebp),%esi
8010728c:	85 f6                	test   %esi,%esi
8010728e:	0f 84 cb 00 00 00    	je     8010735f <switchuvm+0xdf>
80107294:	8b 46 08             	mov    0x8(%esi),%eax
80107297:	85 c0                	test   %eax,%eax
80107299:	0f 84 da 00 00 00    	je     80107379 <switchuvm+0xf9>
8010729f:	8b 46 04             	mov    0x4(%esi),%eax
801072a2:	85 c0                	test   %eax,%eax
801072a4:	0f 84 c2 00 00 00    	je     8010736c <switchuvm+0xec>
801072aa:	e8 31 da ff ff       	call   80104ce0 <pushcli>
801072af:	e8 bc ce ff ff       	call   80104170 <mycpu>
801072b4:	89 c3                	mov    %eax,%ebx
801072b6:	e8 b5 ce ff ff       	call   80104170 <mycpu>
801072bb:	89 c7                	mov    %eax,%edi
801072bd:	e8 ae ce ff ff       	call   80104170 <mycpu>
801072c2:	83 c7 08             	add    $0x8,%edi
801072c5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801072c8:	e8 a3 ce ff ff       	call   80104170 <mycpu>
801072cd:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801072d0:	ba 67 00 00 00       	mov    $0x67,%edx
801072d5:	66 89 bb 9a 00 00 00 	mov    %di,0x9a(%ebx)
801072dc:	83 c0 08             	add    $0x8,%eax
801072df:	66 89 93 98 00 00 00 	mov    %dx,0x98(%ebx)
801072e6:	bf ff ff ff ff       	mov    $0xffffffff,%edi
801072eb:	83 c1 08             	add    $0x8,%ecx
801072ee:	c1 e8 18             	shr    $0x18,%eax
801072f1:	c1 e9 10             	shr    $0x10,%ecx
801072f4:	88 83 9f 00 00 00    	mov    %al,0x9f(%ebx)
801072fa:	88 8b 9c 00 00 00    	mov    %cl,0x9c(%ebx)
80107300:	b9 99 40 00 00       	mov    $0x4099,%ecx
80107305:	66 89 8b 9d 00 00 00 	mov    %cx,0x9d(%ebx)
8010730c:	bb 10 00 00 00       	mov    $0x10,%ebx
80107311:	e8 5a ce ff ff       	call   80104170 <mycpu>
80107316:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
8010731d:	e8 4e ce ff ff       	call   80104170 <mycpu>
80107322:	66 89 58 10          	mov    %bx,0x10(%eax)
80107326:	8b 5e 08             	mov    0x8(%esi),%ebx
80107329:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010732f:	e8 3c ce ff ff       	call   80104170 <mycpu>
80107334:	89 58 0c             	mov    %ebx,0xc(%eax)
80107337:	e8 34 ce ff ff       	call   80104170 <mycpu>
8010733c:	66 89 78 6e          	mov    %di,0x6e(%eax)
80107340:	b8 28 00 00 00       	mov    $0x28,%eax
80107345:	0f 00 d8             	ltr    %eax
80107348:	8b 46 04             	mov    0x4(%esi),%eax
8010734b:	05 00 00 00 80       	add    $0x80000000,%eax
80107350:	0f 22 d8             	mov    %eax,%cr3
80107353:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107356:	5b                   	pop    %ebx
80107357:	5e                   	pop    %esi
80107358:	5f                   	pop    %edi
80107359:	5d                   	pop    %ebp
8010735a:	e9 d1 d9 ff ff       	jmp    80104d30 <popcli>
8010735f:	83 ec 0c             	sub    $0xc,%esp
80107362:	68 06 7e 10 80       	push   $0x80107e06
80107367:	e8 34 90 ff ff       	call   801003a0 <panic>
8010736c:	83 ec 0c             	sub    $0xc,%esp
8010736f:	68 31 7e 10 80       	push   $0x80107e31
80107374:	e8 27 90 ff ff       	call   801003a0 <panic>
80107379:	83 ec 0c             	sub    $0xc,%esp
8010737c:	68 1c 7e 10 80       	push   $0x80107e1c
80107381:	e8 1a 90 ff ff       	call   801003a0 <panic>
80107386:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010738d:	00 
8010738e:	66 90                	xchg   %ax,%ax

80107390 <inituvm>:
80107390:	55                   	push   %ebp
80107391:	89 e5                	mov    %esp,%ebp
80107393:	57                   	push   %edi
80107394:	56                   	push   %esi
80107395:	53                   	push   %ebx
80107396:	83 ec 1c             	sub    $0x1c,%esp
80107399:	8b 45 08             	mov    0x8(%ebp),%eax
8010739c:	8b 75 10             	mov    0x10(%ebp),%esi
8010739f:	8b 7d 0c             	mov    0xc(%ebp),%edi
801073a2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801073a5:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
801073ab:	77 49                	ja     801073f6 <inituvm+0x66>
801073ad:	e8 2e bb ff ff       	call   80102ee0 <kalloc>
801073b2:	83 ec 04             	sub    $0x4,%esp
801073b5:	68 00 10 00 00       	push   $0x1000
801073ba:	89 c3                	mov    %eax,%ebx
801073bc:	6a 00                	push   $0x0
801073be:	50                   	push   %eax
801073bf:	e8 6c db ff ff       	call   80104f30 <memset>
801073c4:	58                   	pop    %eax
801073c5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801073cb:	5a                   	pop    %edx
801073cc:	6a 06                	push   $0x6
801073ce:	b9 00 10 00 00       	mov    $0x1000,%ecx
801073d3:	31 d2                	xor    %edx,%edx
801073d5:	50                   	push   %eax
801073d6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801073d9:	e8 12 fd ff ff       	call   801070f0 <mappages>
801073de:	83 c4 10             	add    $0x10,%esp
801073e1:	89 75 10             	mov    %esi,0x10(%ebp)
801073e4:	89 7d 0c             	mov    %edi,0xc(%ebp)
801073e7:	89 5d 08             	mov    %ebx,0x8(%ebp)
801073ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
801073ed:	5b                   	pop    %ebx
801073ee:	5e                   	pop    %esi
801073ef:	5f                   	pop    %edi
801073f0:	5d                   	pop    %ebp
801073f1:	e9 ca db ff ff       	jmp    80104fc0 <memmove>
801073f6:	83 ec 0c             	sub    $0xc,%esp
801073f9:	68 45 7e 10 80       	push   $0x80107e45
801073fe:	e8 9d 8f ff ff       	call   801003a0 <panic>
80107403:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010740a:	00 
8010740b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

80107410 <loaduvm>:
80107410:	55                   	push   %ebp
80107411:	89 e5                	mov    %esp,%ebp
80107413:	57                   	push   %edi
80107414:	56                   	push   %esi
80107415:	53                   	push   %ebx
80107416:	83 ec 0c             	sub    $0xc,%esp
80107419:	8b 75 0c             	mov    0xc(%ebp),%esi
8010741c:	8b 7d 18             	mov    0x18(%ebp),%edi
8010741f:	81 e6 ff 0f 00 00    	and    $0xfff,%esi
80107425:	0f 85 a2 00 00 00    	jne    801074cd <loaduvm+0xbd>
8010742b:	85 ff                	test   %edi,%edi
8010742d:	74 7d                	je     801074ac <loaduvm+0x9c>
8010742f:	90                   	nop
80107430:	8b 45 0c             	mov    0xc(%ebp),%eax
80107433:	8b 55 08             	mov    0x8(%ebp),%edx
80107436:	01 f0                	add    %esi,%eax
80107438:	89 c1                	mov    %eax,%ecx
8010743a:	c1 e9 16             	shr    $0x16,%ecx
8010743d:	8b 0c 8a             	mov    (%edx,%ecx,4),%ecx
80107440:	f6 c1 01             	test   $0x1,%cl
80107443:	75 13                	jne    80107458 <loaduvm+0x48>
80107445:	83 ec 0c             	sub    $0xc,%esp
80107448:	68 5f 7e 10 80       	push   $0x80107e5f
8010744d:	e8 4e 8f ff ff       	call   801003a0 <panic>
80107452:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107458:	c1 e8 0a             	shr    $0xa,%eax
8010745b:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
80107461:	25 fc 0f 00 00       	and    $0xffc,%eax
80107466:	8d 8c 01 00 00 00 80 	lea    -0x80000000(%ecx,%eax,1),%ecx
8010746d:	85 c9                	test   %ecx,%ecx
8010746f:	74 d4                	je     80107445 <loaduvm+0x35>
80107471:	89 fb                	mov    %edi,%ebx
80107473:	b8 00 10 00 00       	mov    $0x1000,%eax
80107478:	29 f3                	sub    %esi,%ebx
8010747a:	39 c3                	cmp    %eax,%ebx
8010747c:	0f 47 d8             	cmova  %eax,%ebx
8010747f:	53                   	push   %ebx
80107480:	8b 45 14             	mov    0x14(%ebp),%eax
80107483:	01 f0                	add    %esi,%eax
80107485:	50                   	push   %eax
80107486:	8b 01                	mov    (%ecx),%eax
80107488:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010748d:	05 00 00 00 80       	add    $0x80000000,%eax
80107492:	50                   	push   %eax
80107493:	ff 75 10             	push   0x10(%ebp)
80107496:	e8 95 ae ff ff       	call   80102330 <readi>
8010749b:	83 c4 10             	add    $0x10,%esp
8010749e:	39 d8                	cmp    %ebx,%eax
801074a0:	75 1e                	jne    801074c0 <loaduvm+0xb0>
801074a2:	81 c6 00 10 00 00    	add    $0x1000,%esi
801074a8:	39 fe                	cmp    %edi,%esi
801074aa:	72 84                	jb     80107430 <loaduvm+0x20>
801074ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074af:	31 c0                	xor    %eax,%eax
801074b1:	5b                   	pop    %ebx
801074b2:	5e                   	pop    %esi
801074b3:	5f                   	pop    %edi
801074b4:	5d                   	pop    %ebp
801074b5:	c3                   	ret
801074b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801074bd:	00 
801074be:	66 90                	xchg   %ax,%ax
801074c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801074c8:	5b                   	pop    %ebx
801074c9:	5e                   	pop    %esi
801074ca:	5f                   	pop    %edi
801074cb:	5d                   	pop    %ebp
801074cc:	c3                   	ret
801074cd:	83 ec 0c             	sub    $0xc,%esp
801074d0:	68 d0 80 10 80       	push   $0x801080d0
801074d5:	e8 c6 8e ff ff       	call   801003a0 <panic>
801074da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801074e0 <allocuvm>:
801074e0:	55                   	push   %ebp
801074e1:	89 e5                	mov    %esp,%ebp
801074e3:	57                   	push   %edi
801074e4:	56                   	push   %esi
801074e5:	53                   	push   %ebx
801074e6:	83 ec 1c             	sub    $0x1c,%esp
801074e9:	8b 75 10             	mov    0x10(%ebp),%esi
801074ec:	85 f6                	test   %esi,%esi
801074ee:	0f 88 98 00 00 00    	js     8010758c <allocuvm+0xac>
801074f4:	89 f2                	mov    %esi,%edx
801074f6:	3b 75 0c             	cmp    0xc(%ebp),%esi
801074f9:	0f 82 a1 00 00 00    	jb     801075a0 <allocuvm+0xc0>
801074ff:	8b 45 0c             	mov    0xc(%ebp),%eax
80107502:	05 ff 0f 00 00       	add    $0xfff,%eax
80107507:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010750c:	89 c7                	mov    %eax,%edi
8010750e:	39 f0                	cmp    %esi,%eax
80107510:	0f 83 8d 00 00 00    	jae    801075a3 <allocuvm+0xc3>
80107516:	89 75 e4             	mov    %esi,-0x1c(%ebp)
80107519:	eb 44                	jmp    8010755f <allocuvm+0x7f>
8010751b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80107520:	83 ec 04             	sub    $0x4,%esp
80107523:	68 00 10 00 00       	push   $0x1000
80107528:	6a 00                	push   $0x0
8010752a:	50                   	push   %eax
8010752b:	e8 00 da ff ff       	call   80104f30 <memset>
80107530:	58                   	pop    %eax
80107531:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80107537:	5a                   	pop    %edx
80107538:	6a 06                	push   $0x6
8010753a:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010753f:	89 fa                	mov    %edi,%edx
80107541:	50                   	push   %eax
80107542:	8b 45 08             	mov    0x8(%ebp),%eax
80107545:	e8 a6 fb ff ff       	call   801070f0 <mappages>
8010754a:	83 c4 10             	add    $0x10,%esp
8010754d:	85 c0                	test   %eax,%eax
8010754f:	78 5f                	js     801075b0 <allocuvm+0xd0>
80107551:	81 c7 00 10 00 00    	add    $0x1000,%edi
80107557:	39 f7                	cmp    %esi,%edi
80107559:	0f 83 89 00 00 00    	jae    801075e8 <allocuvm+0x108>
8010755f:	e8 7c b9 ff ff       	call   80102ee0 <kalloc>
80107564:	89 c3                	mov    %eax,%ebx
80107566:	85 c0                	test   %eax,%eax
80107568:	75 b6                	jne    80107520 <allocuvm+0x40>
8010756a:	83 ec 0c             	sub    $0xc,%esp
8010756d:	68 7d 7e 10 80       	push   $0x80107e7d
80107572:	e8 c9 96 ff ff       	call   80100c40 <cprintf>
80107577:	83 c4 10             	add    $0x10,%esp
8010757a:	3b 75 0c             	cmp    0xc(%ebp),%esi
8010757d:	74 0d                	je     8010758c <allocuvm+0xac>
8010757f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80107582:	8b 45 08             	mov    0x8(%ebp),%eax
80107585:	89 f2                	mov    %esi,%edx
80107587:	e8 a4 fa ff ff       	call   80107030 <deallocuvm.part.0>
8010758c:	31 d2                	xor    %edx,%edx
8010758e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107591:	89 d0                	mov    %edx,%eax
80107593:	5b                   	pop    %ebx
80107594:	5e                   	pop    %esi
80107595:	5f                   	pop    %edi
80107596:	5d                   	pop    %ebp
80107597:	c3                   	ret
80107598:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010759f:	00 
801075a0:	8b 55 0c             	mov    0xc(%ebp),%edx
801075a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801075a6:	89 d0                	mov    %edx,%eax
801075a8:	5b                   	pop    %ebx
801075a9:	5e                   	pop    %esi
801075aa:	5f                   	pop    %edi
801075ab:	5d                   	pop    %ebp
801075ac:	c3                   	ret
801075ad:	8d 76 00             	lea    0x0(%esi),%esi
801075b0:	83 ec 0c             	sub    $0xc,%esp
801075b3:	68 95 7e 10 80       	push   $0x80107e95
801075b8:	e8 83 96 ff ff       	call   80100c40 <cprintf>
801075bd:	83 c4 10             	add    $0x10,%esp
801075c0:	3b 75 0c             	cmp    0xc(%ebp),%esi
801075c3:	74 0d                	je     801075d2 <allocuvm+0xf2>
801075c5:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801075c8:	8b 45 08             	mov    0x8(%ebp),%eax
801075cb:	89 f2                	mov    %esi,%edx
801075cd:	e8 5e fa ff ff       	call   80107030 <deallocuvm.part.0>
801075d2:	83 ec 0c             	sub    $0xc,%esp
801075d5:	53                   	push   %ebx
801075d6:	e8 45 b7 ff ff       	call   80102d20 <kfree>
801075db:	83 c4 10             	add    $0x10,%esp
801075de:	31 d2                	xor    %edx,%edx
801075e0:	eb ac                	jmp    8010758e <allocuvm+0xae>
801075e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801075e8:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801075eb:	8d 65 f4             	lea    -0xc(%ebp),%esp
801075ee:	5b                   	pop    %ebx
801075ef:	5e                   	pop    %esi
801075f0:	89 d0                	mov    %edx,%eax
801075f2:	5f                   	pop    %edi
801075f3:	5d                   	pop    %ebp
801075f4:	c3                   	ret
801075f5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801075fc:	00 
801075fd:	8d 76 00             	lea    0x0(%esi),%esi

80107600 <deallocuvm>:
80107600:	55                   	push   %ebp
80107601:	89 e5                	mov    %esp,%ebp
80107603:	8b 55 0c             	mov    0xc(%ebp),%edx
80107606:	8b 4d 10             	mov    0x10(%ebp),%ecx
80107609:	8b 45 08             	mov    0x8(%ebp),%eax
8010760c:	39 d1                	cmp    %edx,%ecx
8010760e:	73 10                	jae    80107620 <deallocuvm+0x20>
80107610:	5d                   	pop    %ebp
80107611:	e9 1a fa ff ff       	jmp    80107030 <deallocuvm.part.0>
80107616:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010761d:	00 
8010761e:	66 90                	xchg   %ax,%ax
80107620:	89 d0                	mov    %edx,%eax
80107622:	5d                   	pop    %ebp
80107623:	c3                   	ret
80107624:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010762b:	00 
8010762c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80107630 <freevm>:
80107630:	55                   	push   %ebp
80107631:	89 e5                	mov    %esp,%ebp
80107633:	57                   	push   %edi
80107634:	56                   	push   %esi
80107635:	53                   	push   %ebx
80107636:	83 ec 0c             	sub    $0xc,%esp
80107639:	8b 75 08             	mov    0x8(%ebp),%esi
8010763c:	85 f6                	test   %esi,%esi
8010763e:	74 59                	je     80107699 <freevm+0x69>
80107640:	31 c9                	xor    %ecx,%ecx
80107642:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107647:	89 f0                	mov    %esi,%eax
80107649:	89 f3                	mov    %esi,%ebx
8010764b:	e8 e0 f9 ff ff       	call   80107030 <deallocuvm.part.0>
80107650:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107656:	eb 0f                	jmp    80107667 <freevm+0x37>
80107658:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010765f:	00 
80107660:	83 c3 04             	add    $0x4,%ebx
80107663:	39 fb                	cmp    %edi,%ebx
80107665:	74 23                	je     8010768a <freevm+0x5a>
80107667:	8b 03                	mov    (%ebx),%eax
80107669:	a8 01                	test   $0x1,%al
8010766b:	74 f3                	je     80107660 <freevm+0x30>
8010766d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107672:	83 ec 0c             	sub    $0xc,%esp
80107675:	83 c3 04             	add    $0x4,%ebx
80107678:	05 00 00 00 80       	add    $0x80000000,%eax
8010767d:	50                   	push   %eax
8010767e:	e8 9d b6 ff ff       	call   80102d20 <kfree>
80107683:	83 c4 10             	add    $0x10,%esp
80107686:	39 fb                	cmp    %edi,%ebx
80107688:	75 dd                	jne    80107667 <freevm+0x37>
8010768a:	89 75 08             	mov    %esi,0x8(%ebp)
8010768d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107690:	5b                   	pop    %ebx
80107691:	5e                   	pop    %esi
80107692:	5f                   	pop    %edi
80107693:	5d                   	pop    %ebp
80107694:	e9 87 b6 ff ff       	jmp    80102d20 <kfree>
80107699:	83 ec 0c             	sub    $0xc,%esp
8010769c:	68 b1 7e 10 80       	push   $0x80107eb1
801076a1:	e8 fa 8c ff ff       	call   801003a0 <panic>
801076a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801076ad:	00 
801076ae:	66 90                	xchg   %ax,%ax

801076b0 <setupkvm>:
801076b0:	55                   	push   %ebp
801076b1:	89 e5                	mov    %esp,%ebp
801076b3:	56                   	push   %esi
801076b4:	53                   	push   %ebx
801076b5:	e8 26 b8 ff ff       	call   80102ee0 <kalloc>
801076ba:	85 c0                	test   %eax,%eax
801076bc:	74 5e                	je     8010771c <setupkvm+0x6c>
801076be:	83 ec 04             	sub    $0x4,%esp
801076c1:	89 c6                	mov    %eax,%esi
801076c3:	bb 20 b4 10 80       	mov    $0x8010b420,%ebx
801076c8:	68 00 10 00 00       	push   $0x1000
801076cd:	6a 00                	push   $0x0
801076cf:	50                   	push   %eax
801076d0:	e8 5b d8 ff ff       	call   80104f30 <memset>
801076d5:	83 c4 10             	add    $0x10,%esp
801076d8:	8b 43 04             	mov    0x4(%ebx),%eax
801076db:	83 ec 08             	sub    $0x8,%esp
801076de:	8b 4b 08             	mov    0x8(%ebx),%ecx
801076e1:	8b 13                	mov    (%ebx),%edx
801076e3:	ff 73 0c             	push   0xc(%ebx)
801076e6:	50                   	push   %eax
801076e7:	29 c1                	sub    %eax,%ecx
801076e9:	89 f0                	mov    %esi,%eax
801076eb:	e8 00 fa ff ff       	call   801070f0 <mappages>
801076f0:	83 c4 10             	add    $0x10,%esp
801076f3:	85 c0                	test   %eax,%eax
801076f5:	78 19                	js     80107710 <setupkvm+0x60>
801076f7:	83 c3 10             	add    $0x10,%ebx
801076fa:	81 fb 60 b4 10 80    	cmp    $0x8010b460,%ebx
80107700:	75 d6                	jne    801076d8 <setupkvm+0x28>
80107702:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107705:	89 f0                	mov    %esi,%eax
80107707:	5b                   	pop    %ebx
80107708:	5e                   	pop    %esi
80107709:	5d                   	pop    %ebp
8010770a:	c3                   	ret
8010770b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80107710:	83 ec 0c             	sub    $0xc,%esp
80107713:	56                   	push   %esi
80107714:	e8 17 ff ff ff       	call   80107630 <freevm>
80107719:	83 c4 10             	add    $0x10,%esp
8010771c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010771f:	31 f6                	xor    %esi,%esi
80107721:	89 f0                	mov    %esi,%eax
80107723:	5b                   	pop    %ebx
80107724:	5e                   	pop    %esi
80107725:	5d                   	pop    %ebp
80107726:	c3                   	ret
80107727:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010772e:	00 
8010772f:	90                   	nop

80107730 <kvmalloc>:
80107730:	55                   	push   %ebp
80107731:	89 e5                	mov    %esp,%ebp
80107733:	83 ec 08             	sub    $0x8,%esp
80107736:	e8 75 ff ff ff       	call   801076b0 <setupkvm>
8010773b:	a3 04 5c 11 80       	mov    %eax,0x80115c04
80107740:	05 00 00 00 80       	add    $0x80000000,%eax
80107745:	0f 22 d8             	mov    %eax,%cr3
80107748:	c9                   	leave
80107749:	c3                   	ret
8010774a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107750 <clearpteu>:
80107750:	55                   	push   %ebp
80107751:	89 e5                	mov    %esp,%ebp
80107753:	83 ec 08             	sub    $0x8,%esp
80107756:	8b 45 0c             	mov    0xc(%ebp),%eax
80107759:	8b 55 08             	mov    0x8(%ebp),%edx
8010775c:	89 c1                	mov    %eax,%ecx
8010775e:	c1 e9 16             	shr    $0x16,%ecx
80107761:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
80107764:	f6 c2 01             	test   $0x1,%dl
80107767:	75 17                	jne    80107780 <clearpteu+0x30>
80107769:	83 ec 0c             	sub    $0xc,%esp
8010776c:	68 c2 7e 10 80       	push   $0x80107ec2
80107771:	e8 2a 8c ff ff       	call   801003a0 <panic>
80107776:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
8010777d:	00 
8010777e:	66 90                	xchg   %ax,%ax
80107780:	c1 e8 0a             	shr    $0xa,%eax
80107783:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107789:	25 fc 0f 00 00       	and    $0xffc,%eax
8010778e:	8d 84 02 00 00 00 80 	lea    -0x80000000(%edx,%eax,1),%eax
80107795:	85 c0                	test   %eax,%eax
80107797:	74 d0                	je     80107769 <clearpteu+0x19>
80107799:	83 20 fb             	andl   $0xfffffffb,(%eax)
8010779c:	c9                   	leave
8010779d:	c3                   	ret
8010779e:	66 90                	xchg   %ax,%ax

801077a0 <copyuvm>:
801077a0:	55                   	push   %ebp
801077a1:	89 e5                	mov    %esp,%ebp
801077a3:	57                   	push   %edi
801077a4:	56                   	push   %esi
801077a5:	53                   	push   %ebx
801077a6:	83 ec 1c             	sub    $0x1c,%esp
801077a9:	e8 02 ff ff ff       	call   801076b0 <setupkvm>
801077ae:	89 45 e0             	mov    %eax,-0x20(%ebp)
801077b1:	85 c0                	test   %eax,%eax
801077b3:	0f 84 e9 00 00 00    	je     801078a2 <copyuvm+0x102>
801077b9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801077bc:	85 c9                	test   %ecx,%ecx
801077be:	0f 84 b2 00 00 00    	je     80107876 <copyuvm+0xd6>
801077c4:	31 f6                	xor    %esi,%esi
801077c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801077cd:	00 
801077ce:	66 90                	xchg   %ax,%ax
801077d0:	8b 4d 08             	mov    0x8(%ebp),%ecx
801077d3:	89 f0                	mov    %esi,%eax
801077d5:	c1 e8 16             	shr    $0x16,%eax
801077d8:	8b 04 81             	mov    (%ecx,%eax,4),%eax
801077db:	a8 01                	test   $0x1,%al
801077dd:	75 11                	jne    801077f0 <copyuvm+0x50>
801077df:	83 ec 0c             	sub    $0xc,%esp
801077e2:	68 cc 7e 10 80       	push   $0x80107ecc
801077e7:	e8 b4 8b ff ff       	call   801003a0 <panic>
801077ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801077f0:	89 f2                	mov    %esi,%edx
801077f2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801077f7:	c1 ea 0a             	shr    $0xa,%edx
801077fa:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80107800:	8d 84 10 00 00 00 80 	lea    -0x80000000(%eax,%edx,1),%eax
80107807:	85 c0                	test   %eax,%eax
80107809:	74 d4                	je     801077df <copyuvm+0x3f>
8010780b:	8b 00                	mov    (%eax),%eax
8010780d:	a8 01                	test   $0x1,%al
8010780f:	0f 84 9f 00 00 00    	je     801078b4 <copyuvm+0x114>
80107815:	89 c7                	mov    %eax,%edi
80107817:	25 ff 0f 00 00       	and    $0xfff,%eax
8010781c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010781f:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80107825:	e8 b6 b6 ff ff       	call   80102ee0 <kalloc>
8010782a:	89 c3                	mov    %eax,%ebx
8010782c:	85 c0                	test   %eax,%eax
8010782e:	74 64                	je     80107894 <copyuvm+0xf4>
80107830:	83 ec 04             	sub    $0x4,%esp
80107833:	81 c7 00 00 00 80    	add    $0x80000000,%edi
80107839:	68 00 10 00 00       	push   $0x1000
8010783e:	57                   	push   %edi
8010783f:	50                   	push   %eax
80107840:	e8 7b d7 ff ff       	call   80104fc0 <memmove>
80107845:	58                   	pop    %eax
80107846:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
8010784c:	5a                   	pop    %edx
8010784d:	ff 75 e4             	push   -0x1c(%ebp)
80107850:	b9 00 10 00 00       	mov    $0x1000,%ecx
80107855:	89 f2                	mov    %esi,%edx
80107857:	50                   	push   %eax
80107858:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010785b:	e8 90 f8 ff ff       	call   801070f0 <mappages>
80107860:	83 c4 10             	add    $0x10,%esp
80107863:	85 c0                	test   %eax,%eax
80107865:	78 21                	js     80107888 <copyuvm+0xe8>
80107867:	81 c6 00 10 00 00    	add    $0x1000,%esi
8010786d:	3b 75 0c             	cmp    0xc(%ebp),%esi
80107870:	0f 82 5a ff ff ff    	jb     801077d0 <copyuvm+0x30>
80107876:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107879:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010787c:	5b                   	pop    %ebx
8010787d:	5e                   	pop    %esi
8010787e:	5f                   	pop    %edi
8010787f:	5d                   	pop    %ebp
80107880:	c3                   	ret
80107881:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107888:	83 ec 0c             	sub    $0xc,%esp
8010788b:	53                   	push   %ebx
8010788c:	e8 8f b4 ff ff       	call   80102d20 <kfree>
80107891:	83 c4 10             	add    $0x10,%esp
80107894:	83 ec 0c             	sub    $0xc,%esp
80107897:	ff 75 e0             	push   -0x20(%ebp)
8010789a:	e8 91 fd ff ff       	call   80107630 <freevm>
8010789f:	83 c4 10             	add    $0x10,%esp
801078a2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
801078a9:	8b 45 e0             	mov    -0x20(%ebp),%eax
801078ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
801078af:	5b                   	pop    %ebx
801078b0:	5e                   	pop    %esi
801078b1:	5f                   	pop    %edi
801078b2:	5d                   	pop    %ebp
801078b3:	c3                   	ret
801078b4:	83 ec 0c             	sub    $0xc,%esp
801078b7:	68 e6 7e 10 80       	push   $0x80107ee6
801078bc:	e8 df 8a ff ff       	call   801003a0 <panic>
801078c1:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
801078c8:	00 
801078c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801078d0 <uva2ka>:
801078d0:	55                   	push   %ebp
801078d1:	89 e5                	mov    %esp,%ebp
801078d3:	8b 45 0c             	mov    0xc(%ebp),%eax
801078d6:	8b 55 08             	mov    0x8(%ebp),%edx
801078d9:	89 c1                	mov    %eax,%ecx
801078db:	c1 e9 16             	shr    $0x16,%ecx
801078de:	8b 14 8a             	mov    (%edx,%ecx,4),%edx
801078e1:	f6 c2 01             	test   $0x1,%dl
801078e4:	0f 84 f8 00 00 00    	je     801079e2 <uva2ka.cold>
801078ea:	c1 e8 0c             	shr    $0xc,%eax
801078ed:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
801078f3:	5d                   	pop    %ebp
801078f4:	25 ff 03 00 00       	and    $0x3ff,%eax
801078f9:	8b 94 82 00 00 00 80 	mov    -0x80000000(%edx,%eax,4),%edx
80107900:	89 d0                	mov    %edx,%eax
80107902:	f7 d2                	not    %edx
80107904:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80107909:	05 00 00 00 80       	add    $0x80000000,%eax
8010790e:	83 e2 05             	and    $0x5,%edx
80107911:	ba 00 00 00 00       	mov    $0x0,%edx
80107916:	0f 45 c2             	cmovne %edx,%eax
80107919:	c3                   	ret
8010791a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107920 <copyout>:
80107920:	55                   	push   %ebp
80107921:	89 e5                	mov    %esp,%ebp
80107923:	57                   	push   %edi
80107924:	56                   	push   %esi
80107925:	53                   	push   %ebx
80107926:	83 ec 0c             	sub    $0xc,%esp
80107929:	8b 75 14             	mov    0x14(%ebp),%esi
8010792c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010792f:	8b 55 10             	mov    0x10(%ebp),%edx
80107932:	85 f6                	test   %esi,%esi
80107934:	75 51                	jne    80107987 <copyout+0x67>
80107936:	e9 9d 00 00 00       	jmp    801079d8 <copyout+0xb8>
8010793b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
80107940:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
80107946:	8d 8b 00 00 00 80    	lea    -0x80000000(%ebx),%ecx
8010794c:	81 fb 00 00 00 80    	cmp    $0x80000000,%ebx
80107952:	74 74                	je     801079c8 <copyout+0xa8>
80107954:	89 fb                	mov    %edi,%ebx
80107956:	29 c3                	sub    %eax,%ebx
80107958:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010795e:	39 f3                	cmp    %esi,%ebx
80107960:	0f 47 de             	cmova  %esi,%ebx
80107963:	29 f8                	sub    %edi,%eax
80107965:	83 ec 04             	sub    $0x4,%esp
80107968:	01 c1                	add    %eax,%ecx
8010796a:	53                   	push   %ebx
8010796b:	52                   	push   %edx
8010796c:	89 55 10             	mov    %edx,0x10(%ebp)
8010796f:	51                   	push   %ecx
80107970:	e8 4b d6 ff ff       	call   80104fc0 <memmove>
80107975:	8b 55 10             	mov    0x10(%ebp),%edx
80107978:	8d 87 00 10 00 00    	lea    0x1000(%edi),%eax
8010797e:	83 c4 10             	add    $0x10,%esp
80107981:	01 da                	add    %ebx,%edx
80107983:	29 de                	sub    %ebx,%esi
80107985:	74 51                	je     801079d8 <copyout+0xb8>
80107987:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010798a:	89 c1                	mov    %eax,%ecx
8010798c:	89 c7                	mov    %eax,%edi
8010798e:	c1 e9 16             	shr    $0x16,%ecx
80107991:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80107997:	8b 0c 8b             	mov    (%ebx,%ecx,4),%ecx
8010799a:	f6 c1 01             	test   $0x1,%cl
8010799d:	0f 84 46 00 00 00    	je     801079e9 <copyout.cold>
801079a3:	89 fb                	mov    %edi,%ebx
801079a5:	81 e1 00 f0 ff ff    	and    $0xfffff000,%ecx
801079ab:	c1 eb 0c             	shr    $0xc,%ebx
801079ae:	81 e3 ff 03 00 00    	and    $0x3ff,%ebx
801079b4:	8b 9c 99 00 00 00 80 	mov    -0x80000000(%ecx,%ebx,4),%ebx
801079bb:	89 d9                	mov    %ebx,%ecx
801079bd:	f7 d1                	not    %ecx
801079bf:	83 e1 05             	and    $0x5,%ecx
801079c2:	0f 84 78 ff ff ff    	je     80107940 <copyout+0x20>
801079c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801079cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801079d0:	5b                   	pop    %ebx
801079d1:	5e                   	pop    %esi
801079d2:	5f                   	pop    %edi
801079d3:	5d                   	pop    %ebp
801079d4:	c3                   	ret
801079d5:	8d 76 00             	lea    0x0(%esi),%esi
801079d8:	8d 65 f4             	lea    -0xc(%ebp),%esp
801079db:	31 c0                	xor    %eax,%eax
801079dd:	5b                   	pop    %ebx
801079de:	5e                   	pop    %esi
801079df:	5f                   	pop    %edi
801079e0:	5d                   	pop    %ebp
801079e1:	c3                   	ret

801079e2 <uva2ka.cold>:
801079e2:	a1 00 00 00 00       	mov    0x0,%eax
801079e7:	0f 0b                	ud2

801079e9 <copyout.cold>:
801079e9:	a1 00 00 00 00       	mov    0x0,%eax
801079ee:	0f 0b                	ud2
