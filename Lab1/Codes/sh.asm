
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	push   -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	53                   	push   %ebx
       e:	51                   	push   %ecx
       f:	eb 10                	jmp    21 <main+0x21>
      11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      18:	83 f8 02             	cmp    $0x2,%eax
      1b:	0f 8f 5e 01 00 00    	jg     17f <main+0x17f>
      21:	83 ec 08             	sub    $0x8,%esp
      24:	6a 02                	push   $0x2
      26:	68 e6 15 00 00       	push   $0x15e6
      2b:	e8 d3 10 00 00       	call   1103 <open>
      30:	83 c4 10             	add    $0x10,%esp
      33:	85 c0                	test   %eax,%eax
      35:	79 e1                	jns    18 <main+0x18>
      37:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
      3e:	00 
      3f:	90                   	nop
      40:	83 ec 08             	sub    $0x8,%esp
      43:	68 18 15 00 00       	push   $0x1518
      48:	6a 01                	push   $0x1
      4a:	e8 c1 11 00 00       	call   1210 <printf>
      4f:	83 c4 0c             	add    $0xc,%esp
      52:	6a 64                	push   $0x64
      54:	6a 00                	push   $0x0
      56:	68 40 1d 00 00       	push   $0x1d40
      5b:	e8 e0 0e 00 00       	call   f40 <memset>
      60:	58                   	pop    %eax
      61:	5a                   	pop    %edx
      62:	6a 64                	push   $0x64
      64:	68 40 1d 00 00       	push   $0x1d40
      69:	e8 32 0f 00 00       	call   fa0 <gets>
      6e:	0f b6 05 40 1d 00 00 	movzbl 0x1d40,%eax
      75:	83 c4 10             	add    $0x10,%esp
      78:	84 c0                	test   %al,%al
      7a:	0f 84 fa 00 00 00    	je     17a <main+0x17a>
      80:	3c 63                	cmp    $0x63,%al
      82:	74 24                	je     a8 <main+0xa8>
      84:	3c 21                	cmp    $0x21,%al
      86:	74 78                	je     100 <main+0x100>
      88:	e8 2e 10 00 00       	call   10bb <fork>
      8d:	83 f8 ff             	cmp    $0xffffffff,%eax
      90:	0f 84 0f 01 00 00    	je     1a5 <main+0x1a5>
      96:	85 c0                	test   %eax,%eax
      98:	0f 84 f2 00 00 00    	je     190 <main+0x190>
      9e:	e8 28 10 00 00       	call   10cb <wait>
      a3:	eb 9b                	jmp    40 <main+0x40>
      a5:	8d 76 00             	lea    0x0(%esi),%esi
      a8:	80 3d 41 1d 00 00 64 	cmpb   $0x64,0x1d41
      af:	75 d7                	jne    88 <main+0x88>
      b1:	80 3d 42 1d 00 00 20 	cmpb   $0x20,0x1d42
      b8:	75 ce                	jne    88 <main+0x88>
      ba:	83 ec 0c             	sub    $0xc,%esp
      bd:	68 40 1d 00 00       	push   $0x1d40
      c2:	e8 49 0e 00 00       	call   f10 <strlen>
      c7:	c7 04 24 43 1d 00 00 	movl   $0x1d43,(%esp)
      ce:	c6 80 3f 1d 00 00 00 	movb   $0x0,0x1d3f(%eax)
      d5:	e8 59 10 00 00       	call   1133 <chdir>
      da:	83 c4 10             	add    $0x10,%esp
      dd:	85 c0                	test   %eax,%eax
      df:	0f 89 5b ff ff ff    	jns    40 <main+0x40>
      e5:	50                   	push   %eax
      e6:	68 43 1d 00 00       	push   $0x1d43
      eb:	68 ee 15 00 00       	push   $0x15ee
      f0:	6a 02                	push   $0x2
      f2:	e8 19 11 00 00       	call   1210 <printf>
      f7:	83 c4 10             	add    $0x10,%esp
      fa:	e9 41 ff ff ff       	jmp    40 <main+0x40>
      ff:	90                   	nop
     100:	0f b6 05 41 1d 00 00 	movzbl 0x1d41,%eax
     107:	31 c9                	xor    %ecx,%ecx
     109:	3c 0a                	cmp    $0xa,%al
     10b:	74 43                	je     150 <main+0x150>
     10d:	ba 01 00 00 00       	mov    $0x1,%edx
     112:	31 db                	xor    %ebx,%ebx
     114:	eb 22                	jmp    138 <main+0x138>
     116:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     11d:	00 
     11e:	66 90                	xchg   %ax,%ax
     120:	85 db                	test   %ebx,%ebx
     122:	75 09                	jne    12d <main+0x12d>
     124:	88 81 c0 1d 00 00    	mov    %al,0x1dc0(%ecx)
     12a:	83 c1 01             	add    $0x1,%ecx
     12d:	0f b6 82 40 1d 00 00 	movzbl 0x1d40(%edx),%eax
     134:	3c 0a                	cmp    $0xa,%al
     136:	74 18                	je     150 <main+0x150>
     138:	83 c2 01             	add    $0x1,%edx
     13b:	3c 23                	cmp    $0x23,%al
     13d:	75 e1                	jne    120 <main+0x120>
     13f:	0f b6 82 40 1d 00 00 	movzbl 0x1d40(%edx),%eax
     146:	83 f3 01             	xor    $0x1,%ebx
     149:	3c 0a                	cmp    $0xa,%al
     14b:	75 eb                	jne    138 <main+0x138>
     14d:	8d 76 00             	lea    0x0(%esi),%esi
     150:	83 ec 0c             	sub    $0xc,%esp
     153:	c6 81 c0 1d 00 00 00 	movb   $0x0,0x1dc0(%ecx)
     15a:	68 c0 1d 00 00       	push   $0x1dc0
     15f:	e8 5c 01 00 00       	call   2c0 <print_special>
     164:	59                   	pop    %ecx
     165:	5b                   	pop    %ebx
     166:	68 62 15 00 00       	push   $0x1562
     16b:	6a 01                	push   $0x1
     16d:	e8 9e 10 00 00       	call   1210 <printf>
     172:	83 c4 10             	add    $0x10,%esp
     175:	e9 c6 fe ff ff       	jmp    40 <main+0x40>
     17a:	e8 44 0f 00 00       	call   10c3 <exit>
     17f:	83 ec 0c             	sub    $0xc,%esp
     182:	50                   	push   %eax
     183:	e8 63 0f 00 00       	call   10eb <close>
     188:	83 c4 10             	add    $0x10,%esp
     18b:	e9 b0 fe ff ff       	jmp    40 <main+0x40>
     190:	83 ec 0c             	sub    $0xc,%esp
     193:	68 40 1d 00 00       	push   $0x1d40
     198:	e8 73 0c 00 00       	call   e10 <parsecmd>
     19d:	89 04 24             	mov    %eax,(%esp)
     1a0:	e8 bb 02 00 00       	call   460 <runcmd>
     1a5:	83 ec 0c             	sub    $0xc,%esp
     1a8:	68 48 15 00 00       	push   $0x1548
     1ad:	e8 6e 02 00 00       	call   420 <panic>
     1b2:	66 90                	xchg   %ax,%ax
     1b4:	66 90                	xchg   %ax,%ax
     1b6:	66 90                	xchg   %ax,%ax
     1b8:	66 90                	xchg   %ax,%ax
     1ba:	66 90                	xchg   %ax,%ax
     1bc:	66 90                	xchg   %ax,%ax
     1be:	66 90                	xchg   %ax,%ax

000001c0 <getcmd>:
     1c0:	55                   	push   %ebp
     1c1:	89 e5                	mov    %esp,%ebp
     1c3:	56                   	push   %esi
     1c4:	53                   	push   %ebx
     1c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
     1c8:	8b 75 0c             	mov    0xc(%ebp),%esi
     1cb:	83 ec 08             	sub    $0x8,%esp
     1ce:	68 18 15 00 00       	push   $0x1518
     1d3:	6a 01                	push   $0x1
     1d5:	e8 36 10 00 00       	call   1210 <printf>
     1da:	83 c4 0c             	add    $0xc,%esp
     1dd:	56                   	push   %esi
     1de:	6a 00                	push   $0x0
     1e0:	53                   	push   %ebx
     1e1:	e8 5a 0d 00 00       	call   f40 <memset>
     1e6:	58                   	pop    %eax
     1e7:	5a                   	pop    %edx
     1e8:	56                   	push   %esi
     1e9:	53                   	push   %ebx
     1ea:	e8 b1 0d 00 00       	call   fa0 <gets>
     1ef:	83 c4 10             	add    $0x10,%esp
     1f2:	80 3b 01             	cmpb   $0x1,(%ebx)
     1f5:	19 c0                	sbb    %eax,%eax
     1f7:	8d 65 f8             	lea    -0x8(%ebp),%esp
     1fa:	5b                   	pop    %ebx
     1fb:	5e                   	pop    %esi
     1fc:	5d                   	pop    %ebp
     1fd:	c3                   	ret
     1fe:	66 90                	xchg   %ax,%ax

00000200 <process_input>:
     200:	55                   	push   %ebp
     201:	89 e5                	mov    %esp,%ebp
     203:	53                   	push   %ebx
     204:	8b 55 08             	mov    0x8(%ebp),%edx
     207:	0f b6 42 01          	movzbl 0x1(%edx),%eax
     20b:	3c 0a                	cmp    $0xa,%al
     20d:	74 51                	je     260 <process_input+0x60>
     20f:	83 c2 02             	add    $0x2,%edx
     212:	31 db                	xor    %ebx,%ebx
     214:	31 c9                	xor    %ecx,%ecx
     216:	eb 1f                	jmp    237 <process_input+0x37>
     218:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     21f:	00 
     220:	85 db                	test   %ebx,%ebx
     222:	75 09                	jne    22d <process_input+0x2d>
     224:	88 81 c0 1d 00 00    	mov    %al,0x1dc0(%ecx)
     22a:	83 c1 01             	add    $0x1,%ecx
     22d:	0f b6 02             	movzbl (%edx),%eax
     230:	83 c2 01             	add    $0x1,%edx
     233:	3c 0a                	cmp    $0xa,%al
     235:	74 11                	je     248 <process_input+0x48>
     237:	3c 23                	cmp    $0x23,%al
     239:	75 e5                	jne    220 <process_input+0x20>
     23b:	0f b6 02             	movzbl (%edx),%eax
     23e:	83 c2 01             	add    $0x1,%edx
     241:	83 f3 01             	xor    $0x1,%ebx
     244:	3c 0a                	cmp    $0xa,%al
     246:	75 ef                	jne    237 <process_input+0x37>
     248:	c6 81 c0 1d 00 00 00 	movb   $0x0,0x1dc0(%ecx)
     24f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     252:	b8 c0 1d 00 00       	mov    $0x1dc0,%eax
     257:	c9                   	leave
     258:	c3                   	ret
     259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     260:	31 c9                	xor    %ecx,%ecx
     262:	eb e4                	jmp    248 <process_input+0x48>
     264:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     26b:	00 
     26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000270 <color_print>:
     270:	55                   	push   %ebp
     271:	b8 05 00 00 00       	mov    $0x5,%eax
     276:	89 e5                	mov    %esp,%ebp
     278:	53                   	push   %ebx
     279:	8d 5d f6             	lea    -0xa(%ebp),%ebx
     27c:	83 ec 18             	sub    $0x18,%esp
     27f:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
     283:	53                   	push   %ebx
     284:	68 45 15 00 00       	push   $0x1545
     289:	6a 01                	push   $0x1
     28b:	e8 80 0f 00 00       	call   1210 <printf>
     290:	83 c4 0c             	add    $0xc,%esp
     293:	ff 75 08             	push   0x8(%ebp)
     296:	68 45 15 00 00       	push   $0x1545
     29b:	6a 01                	push   $0x1
     29d:	e8 6e 0f 00 00       	call   1210 <printf>
     2a2:	83 c4 0c             	add    $0xc,%esp
     2a5:	53                   	push   %ebx
     2a6:	68 45 15 00 00       	push   $0x1545
     2ab:	6a 01                	push   $0x1
     2ad:	e8 5e 0f 00 00       	call   1210 <printf>
     2b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     2b5:	83 c4 10             	add    $0x10,%esp
     2b8:	c9                   	leave
     2b9:	c3                   	ret
     2ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002c0 <print_special>:
     2c0:	55                   	push   %ebp
     2c1:	89 e5                	mov    %esp,%ebp
     2c3:	57                   	push   %edi
     2c4:	56                   	push   %esi
     2c5:	53                   	push   %ebx
     2c6:	81 ec 8c 00 00 00    	sub    $0x8c,%esp
     2cc:	c7 85 74 ff ff ff 00 	movl   $0x0,-0x8c(%ebp)
     2d3:	00 00 00 
     2d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     2dd:	00 
     2de:	66 90                	xchg   %ax,%ax
     2e0:	83 ec 0c             	sub    $0xc,%esp
     2e3:	ff 75 08             	push   0x8(%ebp)
     2e6:	e8 25 0c 00 00       	call   f10 <strlen>
     2eb:	83 c4 10             	add    $0x10,%esp
     2ee:	39 85 74 ff ff ff    	cmp    %eax,-0x8c(%ebp)
     2f4:	0f 83 16 01 00 00    	jae    410 <print_special+0x150>
     2fa:	8b bd 74 ff ff ff    	mov    -0x8c(%ebp),%edi
     300:	03 7d 08             	add    0x8(%ebp),%edi
     303:	0f b6 17             	movzbl (%edi),%edx
     306:	89 d0                	mov    %edx,%eax
     308:	83 e0 df             	and    $0xffffffdf,%eax
     30b:	83 e8 41             	sub    $0x41,%eax
     30e:	3c 19                	cmp    $0x19,%al
     310:	76 2e                	jbe    340 <print_special+0x80>
     312:	80 fa 5f             	cmp    $0x5f,%dl
     315:	74 29                	je     340 <print_special+0x80>
     317:	83 ec 04             	sub    $0x4,%esp
     31a:	8d 45 82             	lea    -0x7e(%ebp),%eax
     31d:	83 85 74 ff ff ff 01 	addl   $0x1,-0x8c(%ebp)
     324:	88 55 82             	mov    %dl,-0x7e(%ebp)
     327:	c6 45 83 00          	movb   $0x0,-0x7d(%ebp)
     32b:	50                   	push   %eax
     32c:	68 45 15 00 00       	push   $0x1545
     331:	6a 01                	push   $0x1
     333:	e8 d8 0e 00 00       	call   1210 <printf>
     338:	83 c4 10             	add    $0x10,%esp
     33b:	eb a3                	jmp    2e0 <print_special+0x20>
     33d:	8d 76 00             	lea    0x0(%esi),%esi
     340:	31 c9                	xor    %ecx,%ecx
     342:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     348:	89 ce                	mov    %ecx,%esi
     34a:	8d 49 01             	lea    0x1(%ecx),%ecx
     34d:	88 54 0d 83          	mov    %dl,-0x7d(%ebp,%ecx,1)
     351:	0f b6 54 37 01       	movzbl 0x1(%edi,%esi,1),%edx
     356:	89 d0                	mov    %edx,%eax
     358:	83 e0 df             	and    $0xffffffdf,%eax
     35b:	83 e8 41             	sub    $0x41,%eax
     35e:	3c 19                	cmp    $0x19,%al
     360:	76 e6                	jbe    348 <print_special+0x88>
     362:	80 fa 5f             	cmp    $0x5f,%dl
     365:	74 e1                	je     348 <print_special+0x88>
     367:	c6 44 0d 84 00       	movb   $0x0,-0x7c(%ebp,%ecx,1)
     36c:	31 db                	xor    %ebx,%ebx
     36e:	8d 7d 84             	lea    -0x7c(%ebp),%edi
     371:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     378:	83 ec 08             	sub    $0x8,%esp
     37b:	ff 34 9d 04 1d 00 00 	push   0x1d04(,%ebx,4)
     382:	57                   	push   %edi
     383:	e8 28 0b 00 00       	call   eb0 <strcmp>
     388:	83 c4 10             	add    $0x10,%esp
     38b:	85 c0                	test   %eax,%eax
     38d:	74 31                	je     3c0 <print_special+0x100>
     38f:	83 c3 01             	add    $0x1,%ebx
     392:	83 fb 07             	cmp    $0x7,%ebx
     395:	75 e1                	jne    378 <print_special+0xb8>
     397:	83 ec 04             	sub    $0x4,%esp
     39a:	57                   	push   %edi
     39b:	68 45 15 00 00       	push   $0x1545
     3a0:	6a 01                	push   $0x1
     3a2:	e8 69 0e 00 00       	call   1210 <printf>
     3a7:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
     3ad:	83 c4 10             	add    $0x10,%esp
     3b0:	8d 44 06 01          	lea    0x1(%esi,%eax,1),%eax
     3b4:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
     3ba:	e9 21 ff ff ff       	jmp    2e0 <print_special+0x20>
     3bf:	90                   	nop
     3c0:	8b 04 9d 04 1d 00 00 	mov    0x1d04(,%ebx,4),%eax
     3c7:	83 ec 04             	sub    $0x4,%esp
     3ca:	8d 7d 82             	lea    -0x7e(%ebp),%edi
     3cd:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
     3d3:	0f b7 05 58 16 00 00 	movzwl 0x1658,%eax
     3da:	66 89 45 82          	mov    %ax,-0x7e(%ebp)
     3de:	57                   	push   %edi
     3df:	68 45 15 00 00       	push   $0x1545
     3e4:	6a 01                	push   $0x1
     3e6:	e8 25 0e 00 00       	call   1210 <printf>
     3eb:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
     3f1:	83 c4 0c             	add    $0xc,%esp
     3f4:	50                   	push   %eax
     3f5:	68 45 15 00 00       	push   $0x1545
     3fa:	6a 01                	push   $0x1
     3fc:	e8 0f 0e 00 00       	call   1210 <printf>
     401:	83 c4 0c             	add    $0xc,%esp
     404:	eb 94                	jmp    39a <print_special+0xda>
     406:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     40d:	00 
     40e:	66 90                	xchg   %ax,%ax
     410:	8d 65 f4             	lea    -0xc(%ebp),%esp
     413:	5b                   	pop    %ebx
     414:	5e                   	pop    %esi
     415:	5f                   	pop    %edi
     416:	5d                   	pop    %ebp
     417:	c3                   	ret
     418:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     41f:	00 

00000420 <panic>:
     420:	55                   	push   %ebp
     421:	89 e5                	mov    %esp,%ebp
     423:	83 ec 0c             	sub    $0xc,%esp
     426:	ff 75 08             	push   0x8(%ebp)
     429:	68 e2 15 00 00       	push   $0x15e2
     42e:	6a 02                	push   $0x2
     430:	e8 db 0d 00 00       	call   1210 <printf>
     435:	e8 89 0c 00 00       	call   10c3 <exit>
     43a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000440 <fork1>:
     440:	55                   	push   %ebp
     441:	89 e5                	mov    %esp,%ebp
     443:	83 ec 08             	sub    $0x8,%esp
     446:	e8 70 0c 00 00       	call   10bb <fork>
     44b:	83 f8 ff             	cmp    $0xffffffff,%eax
     44e:	74 02                	je     452 <fork1+0x12>
     450:	c9                   	leave
     451:	c3                   	ret
     452:	83 ec 0c             	sub    $0xc,%esp
     455:	68 48 15 00 00       	push   $0x1548
     45a:	e8 c1 ff ff ff       	call   420 <panic>
     45f:	90                   	nop

00000460 <runcmd>:
     460:	55                   	push   %ebp
     461:	89 e5                	mov    %esp,%ebp
     463:	53                   	push   %ebx
     464:	83 ec 14             	sub    $0x14,%esp
     467:	8b 5d 08             	mov    0x8(%ebp),%ebx
     46a:	85 db                	test   %ebx,%ebx
     46c:	74 42                	je     4b0 <runcmd+0x50>
     46e:	83 3b 05             	cmpl   $0x5,(%ebx)
     471:	0f 87 e3 00 00 00    	ja     55a <runcmd+0xfa>
     477:	8b 03                	mov    (%ebx),%eax
     479:	ff 24 85 28 16 00 00 	jmp    *0x1628(,%eax,4)
     480:	8b 43 04             	mov    0x4(%ebx),%eax
     483:	85 c0                	test   %eax,%eax
     485:	74 29                	je     4b0 <runcmd+0x50>
     487:	8d 53 04             	lea    0x4(%ebx),%edx
     48a:	51                   	push   %ecx
     48b:	51                   	push   %ecx
     48c:	52                   	push   %edx
     48d:	50                   	push   %eax
     48e:	e8 68 0c 00 00       	call   10fb <exec>
     493:	83 c4 0c             	add    $0xc,%esp
     496:	ff 73 04             	push   0x4(%ebx)
     499:	68 54 15 00 00       	push   $0x1554
     49e:	6a 02                	push   $0x2
     4a0:	e8 6b 0d 00 00       	call   1210 <printf>
     4a5:	83 c4 10             	add    $0x10,%esp
     4a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     4af:	00 
     4b0:	e8 0e 0c 00 00       	call   10c3 <exit>
     4b5:	e8 86 ff ff ff       	call   440 <fork1>
     4ba:	85 c0                	test   %eax,%eax
     4bc:	75 f2                	jne    4b0 <runcmd+0x50>
     4be:	e9 8c 00 00 00       	jmp    54f <runcmd+0xef>
     4c3:	83 ec 0c             	sub    $0xc,%esp
     4c6:	8d 45 f0             	lea    -0x10(%ebp),%eax
     4c9:	50                   	push   %eax
     4ca:	e8 04 0c 00 00       	call   10d3 <pipe>
     4cf:	83 c4 10             	add    $0x10,%esp
     4d2:	85 c0                	test   %eax,%eax
     4d4:	0f 88 a2 00 00 00    	js     57c <runcmd+0x11c>
     4da:	e8 61 ff ff ff       	call   440 <fork1>
     4df:	85 c0                	test   %eax,%eax
     4e1:	0f 84 a2 00 00 00    	je     589 <runcmd+0x129>
     4e7:	e8 54 ff ff ff       	call   440 <fork1>
     4ec:	85 c0                	test   %eax,%eax
     4ee:	0f 84 c3 00 00 00    	je     5b7 <runcmd+0x157>
     4f4:	83 ec 0c             	sub    $0xc,%esp
     4f7:	ff 75 f0             	push   -0x10(%ebp)
     4fa:	e8 ec 0b 00 00       	call   10eb <close>
     4ff:	58                   	pop    %eax
     500:	ff 75 f4             	push   -0xc(%ebp)
     503:	e8 e3 0b 00 00       	call   10eb <close>
     508:	e8 be 0b 00 00       	call   10cb <wait>
     50d:	e8 b9 0b 00 00       	call   10cb <wait>
     512:	83 c4 10             	add    $0x10,%esp
     515:	eb 99                	jmp    4b0 <runcmd+0x50>
     517:	e8 24 ff ff ff       	call   440 <fork1>
     51c:	85 c0                	test   %eax,%eax
     51e:	74 2f                	je     54f <runcmd+0xef>
     520:	e8 a6 0b 00 00       	call   10cb <wait>
     525:	83 ec 0c             	sub    $0xc,%esp
     528:	ff 73 08             	push   0x8(%ebx)
     52b:	e8 30 ff ff ff       	call   460 <runcmd>
     530:	83 ec 0c             	sub    $0xc,%esp
     533:	ff 73 14             	push   0x14(%ebx)
     536:	e8 b0 0b 00 00       	call   10eb <close>
     53b:	58                   	pop    %eax
     53c:	5a                   	pop    %edx
     53d:	ff 73 10             	push   0x10(%ebx)
     540:	ff 73 08             	push   0x8(%ebx)
     543:	e8 bb 0b 00 00       	call   1103 <open>
     548:	83 c4 10             	add    $0x10,%esp
     54b:	85 c0                	test   %eax,%eax
     54d:	78 18                	js     567 <runcmd+0x107>
     54f:	83 ec 0c             	sub    $0xc,%esp
     552:	ff 73 04             	push   0x4(%ebx)
     555:	e8 06 ff ff ff       	call   460 <runcmd>
     55a:	83 ec 0c             	sub    $0xc,%esp
     55d:	68 4d 15 00 00       	push   $0x154d
     562:	e8 b9 fe ff ff       	call   420 <panic>
     567:	51                   	push   %ecx
     568:	ff 73 08             	push   0x8(%ebx)
     56b:	68 64 15 00 00       	push   $0x1564
     570:	6a 02                	push   $0x2
     572:	e8 99 0c 00 00       	call   1210 <printf>
     577:	e8 47 0b 00 00       	call   10c3 <exit>
     57c:	83 ec 0c             	sub    $0xc,%esp
     57f:	68 74 15 00 00       	push   $0x1574
     584:	e8 97 fe ff ff       	call   420 <panic>
     589:	83 ec 0c             	sub    $0xc,%esp
     58c:	6a 01                	push   $0x1
     58e:	e8 58 0b 00 00       	call   10eb <close>
     593:	58                   	pop    %eax
     594:	ff 75 f4             	push   -0xc(%ebp)
     597:	e8 9f 0b 00 00       	call   113b <dup>
     59c:	58                   	pop    %eax
     59d:	ff 75 f0             	push   -0x10(%ebp)
     5a0:	e8 46 0b 00 00       	call   10eb <close>
     5a5:	58                   	pop    %eax
     5a6:	ff 75 f4             	push   -0xc(%ebp)
     5a9:	e8 3d 0b 00 00       	call   10eb <close>
     5ae:	5a                   	pop    %edx
     5af:	ff 73 04             	push   0x4(%ebx)
     5b2:	e8 a9 fe ff ff       	call   460 <runcmd>
     5b7:	83 ec 0c             	sub    $0xc,%esp
     5ba:	6a 00                	push   $0x0
     5bc:	e8 2a 0b 00 00       	call   10eb <close>
     5c1:	5a                   	pop    %edx
     5c2:	ff 75 f0             	push   -0x10(%ebp)
     5c5:	e8 71 0b 00 00       	call   113b <dup>
     5ca:	59                   	pop    %ecx
     5cb:	ff 75 f0             	push   -0x10(%ebp)
     5ce:	e8 18 0b 00 00       	call   10eb <close>
     5d3:	58                   	pop    %eax
     5d4:	ff 75 f4             	push   -0xc(%ebp)
     5d7:	e8 0f 0b 00 00       	call   10eb <close>
     5dc:	58                   	pop    %eax
     5dd:	ff 73 08             	push   0x8(%ebx)
     5e0:	e8 7b fe ff ff       	call   460 <runcmd>
     5e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     5ec:	00 
     5ed:	8d 76 00             	lea    0x0(%esi),%esi

000005f0 <execcmd>:
     5f0:	55                   	push   %ebp
     5f1:	89 e5                	mov    %esp,%ebp
     5f3:	53                   	push   %ebx
     5f4:	83 ec 10             	sub    $0x10,%esp
     5f7:	6a 54                	push   $0x54
     5f9:	e8 32 0e 00 00       	call   1430 <malloc>
     5fe:	83 c4 0c             	add    $0xc,%esp
     601:	6a 54                	push   $0x54
     603:	89 c3                	mov    %eax,%ebx
     605:	6a 00                	push   $0x0
     607:	50                   	push   %eax
     608:	e8 33 09 00 00       	call   f40 <memset>
     60d:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
     613:	89 d8                	mov    %ebx,%eax
     615:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     618:	c9                   	leave
     619:	c3                   	ret
     61a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000620 <redircmd>:
     620:	55                   	push   %ebp
     621:	89 e5                	mov    %esp,%ebp
     623:	53                   	push   %ebx
     624:	83 ec 10             	sub    $0x10,%esp
     627:	6a 18                	push   $0x18
     629:	e8 02 0e 00 00       	call   1430 <malloc>
     62e:	83 c4 0c             	add    $0xc,%esp
     631:	6a 18                	push   $0x18
     633:	89 c3                	mov    %eax,%ebx
     635:	6a 00                	push   $0x0
     637:	50                   	push   %eax
     638:	e8 03 09 00 00       	call   f40 <memset>
     63d:	8b 45 08             	mov    0x8(%ebp),%eax
     640:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
     646:	89 43 04             	mov    %eax,0x4(%ebx)
     649:	8b 45 0c             	mov    0xc(%ebp),%eax
     64c:	89 43 08             	mov    %eax,0x8(%ebx)
     64f:	8b 45 10             	mov    0x10(%ebp),%eax
     652:	89 43 0c             	mov    %eax,0xc(%ebx)
     655:	8b 45 14             	mov    0x14(%ebp),%eax
     658:	89 43 10             	mov    %eax,0x10(%ebx)
     65b:	8b 45 18             	mov    0x18(%ebp),%eax
     65e:	89 43 14             	mov    %eax,0x14(%ebx)
     661:	89 d8                	mov    %ebx,%eax
     663:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     666:	c9                   	leave
     667:	c3                   	ret
     668:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     66f:	00 

00000670 <pipecmd>:
     670:	55                   	push   %ebp
     671:	89 e5                	mov    %esp,%ebp
     673:	53                   	push   %ebx
     674:	83 ec 10             	sub    $0x10,%esp
     677:	6a 0c                	push   $0xc
     679:	e8 b2 0d 00 00       	call   1430 <malloc>
     67e:	83 c4 0c             	add    $0xc,%esp
     681:	6a 0c                	push   $0xc
     683:	89 c3                	mov    %eax,%ebx
     685:	6a 00                	push   $0x0
     687:	50                   	push   %eax
     688:	e8 b3 08 00 00       	call   f40 <memset>
     68d:	8b 45 08             	mov    0x8(%ebp),%eax
     690:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
     696:	89 43 04             	mov    %eax,0x4(%ebx)
     699:	8b 45 0c             	mov    0xc(%ebp),%eax
     69c:	89 43 08             	mov    %eax,0x8(%ebx)
     69f:	89 d8                	mov    %ebx,%eax
     6a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     6a4:	c9                   	leave
     6a5:	c3                   	ret
     6a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     6ad:	00 
     6ae:	66 90                	xchg   %ax,%ax

000006b0 <listcmd>:
     6b0:	55                   	push   %ebp
     6b1:	89 e5                	mov    %esp,%ebp
     6b3:	53                   	push   %ebx
     6b4:	83 ec 10             	sub    $0x10,%esp
     6b7:	6a 0c                	push   $0xc
     6b9:	e8 72 0d 00 00       	call   1430 <malloc>
     6be:	83 c4 0c             	add    $0xc,%esp
     6c1:	6a 0c                	push   $0xc
     6c3:	89 c3                	mov    %eax,%ebx
     6c5:	6a 00                	push   $0x0
     6c7:	50                   	push   %eax
     6c8:	e8 73 08 00 00       	call   f40 <memset>
     6cd:	8b 45 08             	mov    0x8(%ebp),%eax
     6d0:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
     6d6:	89 43 04             	mov    %eax,0x4(%ebx)
     6d9:	8b 45 0c             	mov    0xc(%ebp),%eax
     6dc:	89 43 08             	mov    %eax,0x8(%ebx)
     6df:	89 d8                	mov    %ebx,%eax
     6e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     6e4:	c9                   	leave
     6e5:	c3                   	ret
     6e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     6ed:	00 
     6ee:	66 90                	xchg   %ax,%ax

000006f0 <backcmd>:
     6f0:	55                   	push   %ebp
     6f1:	89 e5                	mov    %esp,%ebp
     6f3:	53                   	push   %ebx
     6f4:	83 ec 10             	sub    $0x10,%esp
     6f7:	6a 08                	push   $0x8
     6f9:	e8 32 0d 00 00       	call   1430 <malloc>
     6fe:	83 c4 0c             	add    $0xc,%esp
     701:	6a 08                	push   $0x8
     703:	89 c3                	mov    %eax,%ebx
     705:	6a 00                	push   $0x0
     707:	50                   	push   %eax
     708:	e8 33 08 00 00       	call   f40 <memset>
     70d:	8b 45 08             	mov    0x8(%ebp),%eax
     710:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
     716:	89 43 04             	mov    %eax,0x4(%ebx)
     719:	89 d8                	mov    %ebx,%eax
     71b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     71e:	c9                   	leave
     71f:	c3                   	ret

00000720 <gettoken>:
     720:	55                   	push   %ebp
     721:	89 e5                	mov    %esp,%ebp
     723:	57                   	push   %edi
     724:	56                   	push   %esi
     725:	53                   	push   %ebx
     726:	83 ec 0c             	sub    $0xc,%esp
     729:	8b 45 08             	mov    0x8(%ebp),%eax
     72c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     72f:	8b 75 10             	mov    0x10(%ebp),%esi
     732:	8b 38                	mov    (%eax),%edi
     734:	39 df                	cmp    %ebx,%edi
     736:	72 0f                	jb     747 <gettoken+0x27>
     738:	eb 25                	jmp    75f <gettoken+0x3f>
     73a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     740:	83 c7 01             	add    $0x1,%edi
     743:	39 fb                	cmp    %edi,%ebx
     745:	74 18                	je     75f <gettoken+0x3f>
     747:	0f be 07             	movsbl (%edi),%eax
     74a:	83 ec 08             	sub    $0x8,%esp
     74d:	50                   	push   %eax
     74e:	68 20 1d 00 00       	push   $0x1d20
     753:	e8 08 08 00 00       	call   f60 <strchr>
     758:	83 c4 10             	add    $0x10,%esp
     75b:	85 c0                	test   %eax,%eax
     75d:	75 e1                	jne    740 <gettoken+0x20>
     75f:	85 f6                	test   %esi,%esi
     761:	74 02                	je     765 <gettoken+0x45>
     763:	89 3e                	mov    %edi,(%esi)
     765:	0f b6 07             	movzbl (%edi),%eax
     768:	3c 3c                	cmp    $0x3c,%al
     76a:	0f 8f c8 00 00 00    	jg     838 <gettoken+0x118>
     770:	3c 3a                	cmp    $0x3a,%al
     772:	7f 5a                	jg     7ce <gettoken+0xae>
     774:	84 c0                	test   %al,%al
     776:	75 48                	jne    7c0 <gettoken+0xa0>
     778:	31 f6                	xor    %esi,%esi
     77a:	8b 4d 14             	mov    0x14(%ebp),%ecx
     77d:	85 c9                	test   %ecx,%ecx
     77f:	74 05                	je     786 <gettoken+0x66>
     781:	8b 45 14             	mov    0x14(%ebp),%eax
     784:	89 38                	mov    %edi,(%eax)
     786:	39 df                	cmp    %ebx,%edi
     788:	72 0d                	jb     797 <gettoken+0x77>
     78a:	eb 23                	jmp    7af <gettoken+0x8f>
     78c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     790:	83 c7 01             	add    $0x1,%edi
     793:	39 fb                	cmp    %edi,%ebx
     795:	74 18                	je     7af <gettoken+0x8f>
     797:	0f be 07             	movsbl (%edi),%eax
     79a:	83 ec 08             	sub    $0x8,%esp
     79d:	50                   	push   %eax
     79e:	68 20 1d 00 00       	push   $0x1d20
     7a3:	e8 b8 07 00 00       	call   f60 <strchr>
     7a8:	83 c4 10             	add    $0x10,%esp
     7ab:	85 c0                	test   %eax,%eax
     7ad:	75 e1                	jne    790 <gettoken+0x70>
     7af:	8b 45 08             	mov    0x8(%ebp),%eax
     7b2:	89 38                	mov    %edi,(%eax)
     7b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7b7:	89 f0                	mov    %esi,%eax
     7b9:	5b                   	pop    %ebx
     7ba:	5e                   	pop    %esi
     7bb:	5f                   	pop    %edi
     7bc:	5d                   	pop    %ebp
     7bd:	c3                   	ret
     7be:	66 90                	xchg   %ax,%ax
     7c0:	78 22                	js     7e4 <gettoken+0xc4>
     7c2:	3c 26                	cmp    $0x26,%al
     7c4:	74 08                	je     7ce <gettoken+0xae>
     7c6:	8d 48 d8             	lea    -0x28(%eax),%ecx
     7c9:	80 f9 01             	cmp    $0x1,%cl
     7cc:	77 16                	ja     7e4 <gettoken+0xc4>
     7ce:	0f be f0             	movsbl %al,%esi
     7d1:	83 c7 01             	add    $0x1,%edi
     7d4:	eb a4                	jmp    77a <gettoken+0x5a>
     7d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     7dd:	00 
     7de:	66 90                	xchg   %ax,%ax
     7e0:	3c 7c                	cmp    $0x7c,%al
     7e2:	74 ea                	je     7ce <gettoken+0xae>
     7e4:	39 df                	cmp    %ebx,%edi
     7e6:	72 27                	jb     80f <gettoken+0xef>
     7e8:	e9 87 00 00 00       	jmp    874 <gettoken+0x154>
     7ed:	8d 76 00             	lea    0x0(%esi),%esi
     7f0:	0f be 07             	movsbl (%edi),%eax
     7f3:	83 ec 08             	sub    $0x8,%esp
     7f6:	50                   	push   %eax
     7f7:	68 fc 1c 00 00       	push   $0x1cfc
     7fc:	e8 5f 07 00 00       	call   f60 <strchr>
     801:	83 c4 10             	add    $0x10,%esp
     804:	85 c0                	test   %eax,%eax
     806:	75 1f                	jne    827 <gettoken+0x107>
     808:	83 c7 01             	add    $0x1,%edi
     80b:	39 fb                	cmp    %edi,%ebx
     80d:	74 4d                	je     85c <gettoken+0x13c>
     80f:	0f be 07             	movsbl (%edi),%eax
     812:	83 ec 08             	sub    $0x8,%esp
     815:	50                   	push   %eax
     816:	68 20 1d 00 00       	push   $0x1d20
     81b:	e8 40 07 00 00       	call   f60 <strchr>
     820:	83 c4 10             	add    $0x10,%esp
     823:	85 c0                	test   %eax,%eax
     825:	74 c9                	je     7f0 <gettoken+0xd0>
     827:	be 61 00 00 00       	mov    $0x61,%esi
     82c:	e9 49 ff ff ff       	jmp    77a <gettoken+0x5a>
     831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     838:	3c 3e                	cmp    $0x3e,%al
     83a:	75 a4                	jne    7e0 <gettoken+0xc0>
     83c:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
     840:	74 0d                	je     84f <gettoken+0x12f>
     842:	83 c7 01             	add    $0x1,%edi
     845:	be 3e 00 00 00       	mov    $0x3e,%esi
     84a:	e9 2b ff ff ff       	jmp    77a <gettoken+0x5a>
     84f:	83 c7 02             	add    $0x2,%edi
     852:	be 2b 00 00 00       	mov    $0x2b,%esi
     857:	e9 1e ff ff ff       	jmp    77a <gettoken+0x5a>
     85c:	8b 45 14             	mov    0x14(%ebp),%eax
     85f:	85 c0                	test   %eax,%eax
     861:	74 05                	je     868 <gettoken+0x148>
     863:	8b 45 14             	mov    0x14(%ebp),%eax
     866:	89 18                	mov    %ebx,(%eax)
     868:	89 df                	mov    %ebx,%edi
     86a:	be 61 00 00 00       	mov    $0x61,%esi
     86f:	e9 3b ff ff ff       	jmp    7af <gettoken+0x8f>
     874:	8b 55 14             	mov    0x14(%ebp),%edx
     877:	85 d2                	test   %edx,%edx
     879:	74 ef                	je     86a <gettoken+0x14a>
     87b:	8b 45 14             	mov    0x14(%ebp),%eax
     87e:	89 38                	mov    %edi,(%eax)
     880:	eb e8                	jmp    86a <gettoken+0x14a>
     882:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     889:	00 
     88a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000890 <peek>:
     890:	55                   	push   %ebp
     891:	89 e5                	mov    %esp,%ebp
     893:	57                   	push   %edi
     894:	56                   	push   %esi
     895:	53                   	push   %ebx
     896:	83 ec 0c             	sub    $0xc,%esp
     899:	8b 7d 08             	mov    0x8(%ebp),%edi
     89c:	8b 75 0c             	mov    0xc(%ebp),%esi
     89f:	8b 1f                	mov    (%edi),%ebx
     8a1:	39 f3                	cmp    %esi,%ebx
     8a3:	72 12                	jb     8b7 <peek+0x27>
     8a5:	eb 28                	jmp    8cf <peek+0x3f>
     8a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     8ae:	00 
     8af:	90                   	nop
     8b0:	83 c3 01             	add    $0x1,%ebx
     8b3:	39 de                	cmp    %ebx,%esi
     8b5:	74 18                	je     8cf <peek+0x3f>
     8b7:	0f be 03             	movsbl (%ebx),%eax
     8ba:	83 ec 08             	sub    $0x8,%esp
     8bd:	50                   	push   %eax
     8be:	68 20 1d 00 00       	push   $0x1d20
     8c3:	e8 98 06 00 00       	call   f60 <strchr>
     8c8:	83 c4 10             	add    $0x10,%esp
     8cb:	85 c0                	test   %eax,%eax
     8cd:	75 e1                	jne    8b0 <peek+0x20>
     8cf:	89 1f                	mov    %ebx,(%edi)
     8d1:	0f be 03             	movsbl (%ebx),%eax
     8d4:	31 d2                	xor    %edx,%edx
     8d6:	84 c0                	test   %al,%al
     8d8:	75 0e                	jne    8e8 <peek+0x58>
     8da:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8dd:	89 d0                	mov    %edx,%eax
     8df:	5b                   	pop    %ebx
     8e0:	5e                   	pop    %esi
     8e1:	5f                   	pop    %edi
     8e2:	5d                   	pop    %ebp
     8e3:	c3                   	ret
     8e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     8e8:	83 ec 08             	sub    $0x8,%esp
     8eb:	50                   	push   %eax
     8ec:	ff 75 10             	push   0x10(%ebp)
     8ef:	e8 6c 06 00 00       	call   f60 <strchr>
     8f4:	83 c4 10             	add    $0x10,%esp
     8f7:	31 d2                	xor    %edx,%edx
     8f9:	85 c0                	test   %eax,%eax
     8fb:	0f 95 c2             	setne  %dl
     8fe:	8d 65 f4             	lea    -0xc(%ebp),%esp
     901:	5b                   	pop    %ebx
     902:	89 d0                	mov    %edx,%eax
     904:	5e                   	pop    %esi
     905:	5f                   	pop    %edi
     906:	5d                   	pop    %ebp
     907:	c3                   	ret
     908:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     90f:	00 

00000910 <parseredirs>:
     910:	55                   	push   %ebp
     911:	89 e5                	mov    %esp,%ebp
     913:	57                   	push   %edi
     914:	56                   	push   %esi
     915:	53                   	push   %ebx
     916:	83 ec 2c             	sub    $0x2c,%esp
     919:	8b 75 0c             	mov    0xc(%ebp),%esi
     91c:	8b 5d 10             	mov    0x10(%ebp),%ebx
     91f:	90                   	nop
     920:	83 ec 04             	sub    $0x4,%esp
     923:	68 96 15 00 00       	push   $0x1596
     928:	53                   	push   %ebx
     929:	56                   	push   %esi
     92a:	e8 61 ff ff ff       	call   890 <peek>
     92f:	83 c4 10             	add    $0x10,%esp
     932:	85 c0                	test   %eax,%eax
     934:	0f 84 f6 00 00 00    	je     a30 <parseredirs+0x120>
     93a:	6a 00                	push   $0x0
     93c:	6a 00                	push   $0x0
     93e:	53                   	push   %ebx
     93f:	56                   	push   %esi
     940:	e8 db fd ff ff       	call   720 <gettoken>
     945:	89 c7                	mov    %eax,%edi
     947:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     94a:	50                   	push   %eax
     94b:	8d 45 e0             	lea    -0x20(%ebp),%eax
     94e:	50                   	push   %eax
     94f:	53                   	push   %ebx
     950:	56                   	push   %esi
     951:	e8 ca fd ff ff       	call   720 <gettoken>
     956:	83 c4 20             	add    $0x20,%esp
     959:	83 f8 61             	cmp    $0x61,%eax
     95c:	0f 85 d9 00 00 00    	jne    a3b <parseredirs+0x12b>
     962:	83 ff 3c             	cmp    $0x3c,%edi
     965:	74 69                	je     9d0 <parseredirs+0xc0>
     967:	83 ff 3e             	cmp    $0x3e,%edi
     96a:	74 05                	je     971 <parseredirs+0x61>
     96c:	83 ff 2b             	cmp    $0x2b,%edi
     96f:	75 af                	jne    920 <parseredirs+0x10>
     971:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     974:	8b 4d e0             	mov    -0x20(%ebp),%ecx
     977:	83 ec 0c             	sub    $0xc,%esp
     97a:	89 55 d0             	mov    %edx,-0x30(%ebp)
     97d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
     980:	6a 18                	push   $0x18
     982:	e8 a9 0a 00 00       	call   1430 <malloc>
     987:	83 c4 0c             	add    $0xc,%esp
     98a:	6a 18                	push   $0x18
     98c:	89 c7                	mov    %eax,%edi
     98e:	6a 00                	push   $0x0
     990:	50                   	push   %eax
     991:	e8 aa 05 00 00       	call   f40 <memset>
     996:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
     99c:	8b 45 08             	mov    0x8(%ebp),%eax
     99f:	83 c4 10             	add    $0x10,%esp
     9a2:	89 47 04             	mov    %eax,0x4(%edi)
     9a5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     9a8:	89 4f 08             	mov    %ecx,0x8(%edi)
     9ab:	8b 55 d0             	mov    -0x30(%ebp),%edx
     9ae:	c7 47 10 01 02 00 00 	movl   $0x201,0x10(%edi)
     9b5:	89 57 0c             	mov    %edx,0xc(%edi)
     9b8:	c7 47 14 01 00 00 00 	movl   $0x1,0x14(%edi)
     9bf:	89 7d 08             	mov    %edi,0x8(%ebp)
     9c2:	e9 59 ff ff ff       	jmp    920 <parseredirs+0x10>
     9c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     9ce:	00 
     9cf:	90                   	nop
     9d0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     9d3:	8b 4d e0             	mov    -0x20(%ebp),%ecx
     9d6:	83 ec 0c             	sub    $0xc,%esp
     9d9:	89 55 d0             	mov    %edx,-0x30(%ebp)
     9dc:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
     9df:	6a 18                	push   $0x18
     9e1:	e8 4a 0a 00 00       	call   1430 <malloc>
     9e6:	83 c4 0c             	add    $0xc,%esp
     9e9:	6a 18                	push   $0x18
     9eb:	89 c7                	mov    %eax,%edi
     9ed:	6a 00                	push   $0x0
     9ef:	50                   	push   %eax
     9f0:	e8 4b 05 00 00       	call   f40 <memset>
     9f5:	8b 45 08             	mov    0x8(%ebp),%eax
     9f8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     9fb:	83 c4 10             	add    $0x10,%esp
     9fe:	8b 55 d0             	mov    -0x30(%ebp),%edx
     a01:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
     a07:	89 47 04             	mov    %eax,0x4(%edi)
     a0a:	89 4f 08             	mov    %ecx,0x8(%edi)
     a0d:	89 57 0c             	mov    %edx,0xc(%edi)
     a10:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
     a17:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
     a1e:	89 7d 08             	mov    %edi,0x8(%ebp)
     a21:	e9 fa fe ff ff       	jmp    920 <parseredirs+0x10>
     a26:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     a2d:	00 
     a2e:	66 90                	xchg   %ax,%ax
     a30:	8b 45 08             	mov    0x8(%ebp),%eax
     a33:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a36:	5b                   	pop    %ebx
     a37:	5e                   	pop    %esi
     a38:	5f                   	pop    %edi
     a39:	5d                   	pop    %ebp
     a3a:	c3                   	ret
     a3b:	83 ec 0c             	sub    $0xc,%esp
     a3e:	68 79 15 00 00       	push   $0x1579
     a43:	e8 d8 f9 ff ff       	call   420 <panic>
     a48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     a4f:	00 

00000a50 <parseexec>:
     a50:	55                   	push   %ebp
     a51:	89 e5                	mov    %esp,%ebp
     a53:	57                   	push   %edi
     a54:	56                   	push   %esi
     a55:	53                   	push   %ebx
     a56:	83 ec 30             	sub    $0x30,%esp
     a59:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a5c:	8b 75 0c             	mov    0xc(%ebp),%esi
     a5f:	68 99 15 00 00       	push   $0x1599
     a64:	56                   	push   %esi
     a65:	53                   	push   %ebx
     a66:	e8 25 fe ff ff       	call   890 <peek>
     a6b:	83 c4 10             	add    $0x10,%esp
     a6e:	85 c0                	test   %eax,%eax
     a70:	0f 85 aa 00 00 00    	jne    b20 <parseexec+0xd0>
     a76:	83 ec 0c             	sub    $0xc,%esp
     a79:	89 c7                	mov    %eax,%edi
     a7b:	6a 54                	push   $0x54
     a7d:	e8 ae 09 00 00       	call   1430 <malloc>
     a82:	83 c4 0c             	add    $0xc,%esp
     a85:	6a 54                	push   $0x54
     a87:	6a 00                	push   $0x0
     a89:	89 45 d0             	mov    %eax,-0x30(%ebp)
     a8c:	50                   	push   %eax
     a8d:	e8 ae 04 00 00       	call   f40 <memset>
     a92:	8b 45 d0             	mov    -0x30(%ebp),%eax
     a95:	83 c4 0c             	add    $0xc,%esp
     a98:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
     a9e:	56                   	push   %esi
     a9f:	53                   	push   %ebx
     aa0:	50                   	push   %eax
     aa1:	e8 6a fe ff ff       	call   910 <parseredirs>
     aa6:	83 c4 10             	add    $0x10,%esp
     aa9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     aac:	eb 15                	jmp    ac3 <parseexec+0x73>
     aae:	66 90                	xchg   %ax,%ax
     ab0:	83 ec 04             	sub    $0x4,%esp
     ab3:	56                   	push   %esi
     ab4:	53                   	push   %ebx
     ab5:	ff 75 d4             	push   -0x2c(%ebp)
     ab8:	e8 53 fe ff ff       	call   910 <parseredirs>
     abd:	83 c4 10             	add    $0x10,%esp
     ac0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     ac3:	83 ec 04             	sub    $0x4,%esp
     ac6:	68 b0 15 00 00       	push   $0x15b0
     acb:	56                   	push   %esi
     acc:	53                   	push   %ebx
     acd:	e8 be fd ff ff       	call   890 <peek>
     ad2:	83 c4 10             	add    $0x10,%esp
     ad5:	85 c0                	test   %eax,%eax
     ad7:	75 5f                	jne    b38 <parseexec+0xe8>
     ad9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     adc:	50                   	push   %eax
     add:	8d 45 e0             	lea    -0x20(%ebp),%eax
     ae0:	50                   	push   %eax
     ae1:	56                   	push   %esi
     ae2:	53                   	push   %ebx
     ae3:	e8 38 fc ff ff       	call   720 <gettoken>
     ae8:	83 c4 10             	add    $0x10,%esp
     aeb:	85 c0                	test   %eax,%eax
     aed:	74 49                	je     b38 <parseexec+0xe8>
     aef:	83 f8 61             	cmp    $0x61,%eax
     af2:	75 62                	jne    b56 <parseexec+0x106>
     af4:	8b 45 e0             	mov    -0x20(%ebp),%eax
     af7:	8b 55 d0             	mov    -0x30(%ebp),%edx
     afa:	89 44 ba 04          	mov    %eax,0x4(%edx,%edi,4)
     afe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b01:	89 44 ba 2c          	mov    %eax,0x2c(%edx,%edi,4)
     b05:	83 c7 01             	add    $0x1,%edi
     b08:	83 ff 0a             	cmp    $0xa,%edi
     b0b:	75 a3                	jne    ab0 <parseexec+0x60>
     b0d:	83 ec 0c             	sub    $0xc,%esp
     b10:	68 a2 15 00 00       	push   $0x15a2
     b15:	e8 06 f9 ff ff       	call   420 <panic>
     b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b20:	89 75 0c             	mov    %esi,0xc(%ebp)
     b23:	89 5d 08             	mov    %ebx,0x8(%ebp)
     b26:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b29:	5b                   	pop    %ebx
     b2a:	5e                   	pop    %esi
     b2b:	5f                   	pop    %edi
     b2c:	5d                   	pop    %ebp
     b2d:	e9 ae 01 00 00       	jmp    ce0 <parseblock>
     b32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b38:	8b 45 d0             	mov    -0x30(%ebp),%eax
     b3b:	c7 44 b8 04 00 00 00 	movl   $0x0,0x4(%eax,%edi,4)
     b42:	00 
     b43:	c7 44 b8 2c 00 00 00 	movl   $0x0,0x2c(%eax,%edi,4)
     b4a:	00 
     b4b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     b4e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b51:	5b                   	pop    %ebx
     b52:	5e                   	pop    %esi
     b53:	5f                   	pop    %edi
     b54:	5d                   	pop    %ebp
     b55:	c3                   	ret
     b56:	83 ec 0c             	sub    $0xc,%esp
     b59:	68 9b 15 00 00       	push   $0x159b
     b5e:	e8 bd f8 ff ff       	call   420 <panic>
     b63:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     b6a:	00 
     b6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000b70 <parsepipe>:
     b70:	55                   	push   %ebp
     b71:	89 e5                	mov    %esp,%ebp
     b73:	57                   	push   %edi
     b74:	56                   	push   %esi
     b75:	53                   	push   %ebx
     b76:	83 ec 14             	sub    $0x14,%esp
     b79:	8b 75 08             	mov    0x8(%ebp),%esi
     b7c:	8b 7d 0c             	mov    0xc(%ebp),%edi
     b7f:	57                   	push   %edi
     b80:	56                   	push   %esi
     b81:	e8 ca fe ff ff       	call   a50 <parseexec>
     b86:	83 c4 0c             	add    $0xc,%esp
     b89:	68 b5 15 00 00       	push   $0x15b5
     b8e:	89 c3                	mov    %eax,%ebx
     b90:	57                   	push   %edi
     b91:	56                   	push   %esi
     b92:	e8 f9 fc ff ff       	call   890 <peek>
     b97:	83 c4 10             	add    $0x10,%esp
     b9a:	85 c0                	test   %eax,%eax
     b9c:	75 12                	jne    bb0 <parsepipe+0x40>
     b9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ba1:	89 d8                	mov    %ebx,%eax
     ba3:	5b                   	pop    %ebx
     ba4:	5e                   	pop    %esi
     ba5:	5f                   	pop    %edi
     ba6:	5d                   	pop    %ebp
     ba7:	c3                   	ret
     ba8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     baf:	00 
     bb0:	6a 00                	push   $0x0
     bb2:	6a 00                	push   $0x0
     bb4:	57                   	push   %edi
     bb5:	56                   	push   %esi
     bb6:	e8 65 fb ff ff       	call   720 <gettoken>
     bbb:	58                   	pop    %eax
     bbc:	5a                   	pop    %edx
     bbd:	57                   	push   %edi
     bbe:	56                   	push   %esi
     bbf:	e8 ac ff ff ff       	call   b70 <parsepipe>
     bc4:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     bcb:	89 c7                	mov    %eax,%edi
     bcd:	e8 5e 08 00 00       	call   1430 <malloc>
     bd2:	83 c4 0c             	add    $0xc,%esp
     bd5:	6a 0c                	push   $0xc
     bd7:	89 c6                	mov    %eax,%esi
     bd9:	6a 00                	push   $0x0
     bdb:	50                   	push   %eax
     bdc:	e8 5f 03 00 00       	call   f40 <memset>
     be1:	89 5e 04             	mov    %ebx,0x4(%esi)
     be4:	83 c4 10             	add    $0x10,%esp
     be7:	89 f3                	mov    %esi,%ebx
     be9:	c7 06 03 00 00 00    	movl   $0x3,(%esi)
     bef:	89 d8                	mov    %ebx,%eax
     bf1:	89 7e 08             	mov    %edi,0x8(%esi)
     bf4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     bf7:	5b                   	pop    %ebx
     bf8:	5e                   	pop    %esi
     bf9:	5f                   	pop    %edi
     bfa:	5d                   	pop    %ebp
     bfb:	c3                   	ret
     bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000c00 <parseline>:
     c00:	55                   	push   %ebp
     c01:	89 e5                	mov    %esp,%ebp
     c03:	57                   	push   %edi
     c04:	56                   	push   %esi
     c05:	53                   	push   %ebx
     c06:	83 ec 24             	sub    $0x24,%esp
     c09:	8b 75 08             	mov    0x8(%ebp),%esi
     c0c:	8b 7d 0c             	mov    0xc(%ebp),%edi
     c0f:	57                   	push   %edi
     c10:	56                   	push   %esi
     c11:	e8 5a ff ff ff       	call   b70 <parsepipe>
     c16:	83 c4 10             	add    $0x10,%esp
     c19:	89 c3                	mov    %eax,%ebx
     c1b:	eb 3b                	jmp    c58 <parseline+0x58>
     c1d:	8d 76 00             	lea    0x0(%esi),%esi
     c20:	6a 00                	push   $0x0
     c22:	6a 00                	push   $0x0
     c24:	57                   	push   %edi
     c25:	56                   	push   %esi
     c26:	e8 f5 fa ff ff       	call   720 <gettoken>
     c2b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     c32:	e8 f9 07 00 00       	call   1430 <malloc>
     c37:	83 c4 0c             	add    $0xc,%esp
     c3a:	6a 08                	push   $0x8
     c3c:	6a 00                	push   $0x0
     c3e:	50                   	push   %eax
     c3f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     c42:	e8 f9 02 00 00       	call   f40 <memset>
     c47:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     c4a:	83 c4 10             	add    $0x10,%esp
     c4d:	c7 02 05 00 00 00    	movl   $0x5,(%edx)
     c53:	89 5a 04             	mov    %ebx,0x4(%edx)
     c56:	89 d3                	mov    %edx,%ebx
     c58:	83 ec 04             	sub    $0x4,%esp
     c5b:	68 b7 15 00 00       	push   $0x15b7
     c60:	57                   	push   %edi
     c61:	56                   	push   %esi
     c62:	e8 29 fc ff ff       	call   890 <peek>
     c67:	83 c4 10             	add    $0x10,%esp
     c6a:	85 c0                	test   %eax,%eax
     c6c:	75 b2                	jne    c20 <parseline+0x20>
     c6e:	83 ec 04             	sub    $0x4,%esp
     c71:	68 b3 15 00 00       	push   $0x15b3
     c76:	57                   	push   %edi
     c77:	56                   	push   %esi
     c78:	e8 13 fc ff ff       	call   890 <peek>
     c7d:	83 c4 10             	add    $0x10,%esp
     c80:	85 c0                	test   %eax,%eax
     c82:	75 0c                	jne    c90 <parseline+0x90>
     c84:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c87:	89 d8                	mov    %ebx,%eax
     c89:	5b                   	pop    %ebx
     c8a:	5e                   	pop    %esi
     c8b:	5f                   	pop    %edi
     c8c:	5d                   	pop    %ebp
     c8d:	c3                   	ret
     c8e:	66 90                	xchg   %ax,%ax
     c90:	6a 00                	push   $0x0
     c92:	6a 00                	push   $0x0
     c94:	57                   	push   %edi
     c95:	56                   	push   %esi
     c96:	e8 85 fa ff ff       	call   720 <gettoken>
     c9b:	58                   	pop    %eax
     c9c:	5a                   	pop    %edx
     c9d:	57                   	push   %edi
     c9e:	56                   	push   %esi
     c9f:	e8 5c ff ff ff       	call   c00 <parseline>
     ca4:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     cab:	89 c7                	mov    %eax,%edi
     cad:	e8 7e 07 00 00       	call   1430 <malloc>
     cb2:	83 c4 0c             	add    $0xc,%esp
     cb5:	6a 0c                	push   $0xc
     cb7:	89 c6                	mov    %eax,%esi
     cb9:	6a 00                	push   $0x0
     cbb:	50                   	push   %eax
     cbc:	e8 7f 02 00 00       	call   f40 <memset>
     cc1:	89 5e 04             	mov    %ebx,0x4(%esi)
     cc4:	83 c4 10             	add    $0x10,%esp
     cc7:	89 f3                	mov    %esi,%ebx
     cc9:	c7 06 04 00 00 00    	movl   $0x4,(%esi)
     ccf:	89 d8                	mov    %ebx,%eax
     cd1:	89 7e 08             	mov    %edi,0x8(%esi)
     cd4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cd7:	5b                   	pop    %ebx
     cd8:	5e                   	pop    %esi
     cd9:	5f                   	pop    %edi
     cda:	5d                   	pop    %ebp
     cdb:	c3                   	ret
     cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ce0 <parseblock>:
     ce0:	55                   	push   %ebp
     ce1:	89 e5                	mov    %esp,%ebp
     ce3:	57                   	push   %edi
     ce4:	56                   	push   %esi
     ce5:	53                   	push   %ebx
     ce6:	83 ec 10             	sub    $0x10,%esp
     ce9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     cec:	8b 75 0c             	mov    0xc(%ebp),%esi
     cef:	68 99 15 00 00       	push   $0x1599
     cf4:	56                   	push   %esi
     cf5:	53                   	push   %ebx
     cf6:	e8 95 fb ff ff       	call   890 <peek>
     cfb:	83 c4 10             	add    $0x10,%esp
     cfe:	85 c0                	test   %eax,%eax
     d00:	74 4a                	je     d4c <parseblock+0x6c>
     d02:	6a 00                	push   $0x0
     d04:	6a 00                	push   $0x0
     d06:	56                   	push   %esi
     d07:	53                   	push   %ebx
     d08:	e8 13 fa ff ff       	call   720 <gettoken>
     d0d:	58                   	pop    %eax
     d0e:	5a                   	pop    %edx
     d0f:	56                   	push   %esi
     d10:	53                   	push   %ebx
     d11:	e8 ea fe ff ff       	call   c00 <parseline>
     d16:	83 c4 0c             	add    $0xc,%esp
     d19:	68 d5 15 00 00       	push   $0x15d5
     d1e:	89 c7                	mov    %eax,%edi
     d20:	56                   	push   %esi
     d21:	53                   	push   %ebx
     d22:	e8 69 fb ff ff       	call   890 <peek>
     d27:	83 c4 10             	add    $0x10,%esp
     d2a:	85 c0                	test   %eax,%eax
     d2c:	74 2b                	je     d59 <parseblock+0x79>
     d2e:	6a 00                	push   $0x0
     d30:	6a 00                	push   $0x0
     d32:	56                   	push   %esi
     d33:	53                   	push   %ebx
     d34:	e8 e7 f9 ff ff       	call   720 <gettoken>
     d39:	83 c4 0c             	add    $0xc,%esp
     d3c:	56                   	push   %esi
     d3d:	53                   	push   %ebx
     d3e:	57                   	push   %edi
     d3f:	e8 cc fb ff ff       	call   910 <parseredirs>
     d44:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d47:	5b                   	pop    %ebx
     d48:	5e                   	pop    %esi
     d49:	5f                   	pop    %edi
     d4a:	5d                   	pop    %ebp
     d4b:	c3                   	ret
     d4c:	83 ec 0c             	sub    $0xc,%esp
     d4f:	68 b9 15 00 00       	push   $0x15b9
     d54:	e8 c7 f6 ff ff       	call   420 <panic>
     d59:	83 ec 0c             	sub    $0xc,%esp
     d5c:	68 c4 15 00 00       	push   $0x15c4
     d61:	e8 ba f6 ff ff       	call   420 <panic>
     d66:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     d6d:	00 
     d6e:	66 90                	xchg   %ax,%ax

00000d70 <nulterminate>:
     d70:	55                   	push   %ebp
     d71:	89 e5                	mov    %esp,%ebp
     d73:	53                   	push   %ebx
     d74:	83 ec 04             	sub    $0x4,%esp
     d77:	8b 5d 08             	mov    0x8(%ebp),%ebx
     d7a:	85 db                	test   %ebx,%ebx
     d7c:	74 29                	je     da7 <nulterminate+0x37>
     d7e:	83 3b 05             	cmpl   $0x5,(%ebx)
     d81:	77 24                	ja     da7 <nulterminate+0x37>
     d83:	8b 03                	mov    (%ebx),%eax
     d85:	ff 24 85 40 16 00 00 	jmp    *0x1640(,%eax,4)
     d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d90:	83 ec 0c             	sub    $0xc,%esp
     d93:	ff 73 04             	push   0x4(%ebx)
     d96:	e8 d5 ff ff ff       	call   d70 <nulterminate>
     d9b:	58                   	pop    %eax
     d9c:	ff 73 08             	push   0x8(%ebx)
     d9f:	e8 cc ff ff ff       	call   d70 <nulterminate>
     da4:	83 c4 10             	add    $0x10,%esp
     da7:	89 d8                	mov    %ebx,%eax
     da9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     dac:	c9                   	leave
     dad:	c3                   	ret
     dae:	66 90                	xchg   %ax,%ax
     db0:	83 ec 0c             	sub    $0xc,%esp
     db3:	ff 73 04             	push   0x4(%ebx)
     db6:	e8 b5 ff ff ff       	call   d70 <nulterminate>
     dbb:	89 d8                	mov    %ebx,%eax
     dbd:	83 c4 10             	add    $0x10,%esp
     dc0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     dc3:	c9                   	leave
     dc4:	c3                   	ret
     dc5:	8d 76 00             	lea    0x0(%esi),%esi
     dc8:	8b 4b 04             	mov    0x4(%ebx),%ecx
     dcb:	85 c9                	test   %ecx,%ecx
     dcd:	74 d8                	je     da7 <nulterminate+0x37>
     dcf:	8d 43 08             	lea    0x8(%ebx),%eax
     dd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     dd8:	8b 50 24             	mov    0x24(%eax),%edx
     ddb:	83 c0 04             	add    $0x4,%eax
     dde:	c6 02 00             	movb   $0x0,(%edx)
     de1:	8b 50 fc             	mov    -0x4(%eax),%edx
     de4:	85 d2                	test   %edx,%edx
     de6:	75 f0                	jne    dd8 <nulterminate+0x68>
     de8:	89 d8                	mov    %ebx,%eax
     dea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ded:	c9                   	leave
     dee:	c3                   	ret
     def:	90                   	nop
     df0:	83 ec 0c             	sub    $0xc,%esp
     df3:	ff 73 04             	push   0x4(%ebx)
     df6:	e8 75 ff ff ff       	call   d70 <nulterminate>
     dfb:	8b 43 0c             	mov    0xc(%ebx),%eax
     dfe:	83 c4 10             	add    $0x10,%esp
     e01:	c6 00 00             	movb   $0x0,(%eax)
     e04:	89 d8                	mov    %ebx,%eax
     e06:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     e09:	c9                   	leave
     e0a:	c3                   	ret
     e0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000e10 <parsecmd>:
     e10:	55                   	push   %ebp
     e11:	89 e5                	mov    %esp,%ebp
     e13:	57                   	push   %edi
     e14:	56                   	push   %esi
     e15:	8d 7d 08             	lea    0x8(%ebp),%edi
     e18:	53                   	push   %ebx
     e19:	83 ec 18             	sub    $0x18,%esp
     e1c:	8b 5d 08             	mov    0x8(%ebp),%ebx
     e1f:	53                   	push   %ebx
     e20:	e8 eb 00 00 00       	call   f10 <strlen>
     e25:	59                   	pop    %ecx
     e26:	5e                   	pop    %esi
     e27:	01 c3                	add    %eax,%ebx
     e29:	53                   	push   %ebx
     e2a:	57                   	push   %edi
     e2b:	e8 d0 fd ff ff       	call   c00 <parseline>
     e30:	83 c4 0c             	add    $0xc,%esp
     e33:	68 63 15 00 00       	push   $0x1563
     e38:	89 c6                	mov    %eax,%esi
     e3a:	53                   	push   %ebx
     e3b:	57                   	push   %edi
     e3c:	e8 4f fa ff ff       	call   890 <peek>
     e41:	8b 45 08             	mov    0x8(%ebp),%eax
     e44:	83 c4 10             	add    $0x10,%esp
     e47:	39 d8                	cmp    %ebx,%eax
     e49:	75 13                	jne    e5e <parsecmd+0x4e>
     e4b:	83 ec 0c             	sub    $0xc,%esp
     e4e:	56                   	push   %esi
     e4f:	e8 1c ff ff ff       	call   d70 <nulterminate>
     e54:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e57:	89 f0                	mov    %esi,%eax
     e59:	5b                   	pop    %ebx
     e5a:	5e                   	pop    %esi
     e5b:	5f                   	pop    %edi
     e5c:	5d                   	pop    %ebp
     e5d:	c3                   	ret
     e5e:	52                   	push   %edx
     e5f:	50                   	push   %eax
     e60:	68 d7 15 00 00       	push   $0x15d7
     e65:	6a 02                	push   $0x2
     e67:	e8 a4 03 00 00       	call   1210 <printf>
     e6c:	c7 04 24 9b 15 00 00 	movl   $0x159b,(%esp)
     e73:	e8 a8 f5 ff ff       	call   420 <panic>
     e78:	66 90                	xchg   %ax,%ax
     e7a:	66 90                	xchg   %ax,%ax
     e7c:	66 90                	xchg   %ax,%ax
     e7e:	66 90                	xchg   %ax,%ax

00000e80 <strcpy>:
     e80:	55                   	push   %ebp
     e81:	31 c0                	xor    %eax,%eax
     e83:	89 e5                	mov    %esp,%ebp
     e85:	53                   	push   %ebx
     e86:	8b 4d 08             	mov    0x8(%ebp),%ecx
     e89:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e90:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     e94:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     e97:	83 c0 01             	add    $0x1,%eax
     e9a:	84 d2                	test   %dl,%dl
     e9c:	75 f2                	jne    e90 <strcpy+0x10>
     e9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ea1:	89 c8                	mov    %ecx,%eax
     ea3:	c9                   	leave
     ea4:	c3                   	ret
     ea5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     eac:	00 
     ead:	8d 76 00             	lea    0x0(%esi),%esi

00000eb0 <strcmp>:
     eb0:	55                   	push   %ebp
     eb1:	89 e5                	mov    %esp,%ebp
     eb3:	53                   	push   %ebx
     eb4:	8b 55 08             	mov    0x8(%ebp),%edx
     eb7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
     eba:	0f b6 02             	movzbl (%edx),%eax
     ebd:	84 c0                	test   %al,%al
     ebf:	75 17                	jne    ed8 <strcmp+0x28>
     ec1:	eb 3a                	jmp    efd <strcmp+0x4d>
     ec3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
     ec8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
     ecc:	83 c2 01             	add    $0x1,%edx
     ecf:	8d 59 01             	lea    0x1(%ecx),%ebx
     ed2:	84 c0                	test   %al,%al
     ed4:	74 1a                	je     ef0 <strcmp+0x40>
     ed6:	89 d9                	mov    %ebx,%ecx
     ed8:	0f b6 19             	movzbl (%ecx),%ebx
     edb:	38 c3                	cmp    %al,%bl
     edd:	74 e9                	je     ec8 <strcmp+0x18>
     edf:	29 d8                	sub    %ebx,%eax
     ee1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ee4:	c9                   	leave
     ee5:	c3                   	ret
     ee6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     eed:	00 
     eee:	66 90                	xchg   %ax,%ax
     ef0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     ef4:	31 c0                	xor    %eax,%eax
     ef6:	29 d8                	sub    %ebx,%eax
     ef8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     efb:	c9                   	leave
     efc:	c3                   	ret
     efd:	0f b6 19             	movzbl (%ecx),%ebx
     f00:	31 c0                	xor    %eax,%eax
     f02:	eb db                	jmp    edf <strcmp+0x2f>
     f04:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     f0b:	00 
     f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000f10 <strlen>:
     f10:	55                   	push   %ebp
     f11:	89 e5                	mov    %esp,%ebp
     f13:	8b 55 08             	mov    0x8(%ebp),%edx
     f16:	80 3a 00             	cmpb   $0x0,(%edx)
     f19:	74 15                	je     f30 <strlen+0x20>
     f1b:	31 c0                	xor    %eax,%eax
     f1d:	8d 76 00             	lea    0x0(%esi),%esi
     f20:	83 c0 01             	add    $0x1,%eax
     f23:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     f27:	89 c1                	mov    %eax,%ecx
     f29:	75 f5                	jne    f20 <strlen+0x10>
     f2b:	89 c8                	mov    %ecx,%eax
     f2d:	5d                   	pop    %ebp
     f2e:	c3                   	ret
     f2f:	90                   	nop
     f30:	31 c9                	xor    %ecx,%ecx
     f32:	5d                   	pop    %ebp
     f33:	89 c8                	mov    %ecx,%eax
     f35:	c3                   	ret
     f36:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     f3d:	00 
     f3e:	66 90                	xchg   %ax,%ax

00000f40 <memset>:
     f40:	55                   	push   %ebp
     f41:	89 e5                	mov    %esp,%ebp
     f43:	57                   	push   %edi
     f44:	8b 55 08             	mov    0x8(%ebp),%edx
     f47:	8b 4d 10             	mov    0x10(%ebp),%ecx
     f4a:	8b 45 0c             	mov    0xc(%ebp),%eax
     f4d:	89 d7                	mov    %edx,%edi
     f4f:	fc                   	cld
     f50:	f3 aa                	rep stos %al,%es:(%edi)
     f52:	8b 7d fc             	mov    -0x4(%ebp),%edi
     f55:	89 d0                	mov    %edx,%eax
     f57:	c9                   	leave
     f58:	c3                   	ret
     f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000f60 <strchr>:
     f60:	55                   	push   %ebp
     f61:	89 e5                	mov    %esp,%ebp
     f63:	8b 45 08             	mov    0x8(%ebp),%eax
     f66:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
     f6a:	0f b6 10             	movzbl (%eax),%edx
     f6d:	84 d2                	test   %dl,%dl
     f6f:	75 12                	jne    f83 <strchr+0x23>
     f71:	eb 1d                	jmp    f90 <strchr+0x30>
     f73:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
     f78:	0f b6 50 01          	movzbl 0x1(%eax),%edx
     f7c:	83 c0 01             	add    $0x1,%eax
     f7f:	84 d2                	test   %dl,%dl
     f81:	74 0d                	je     f90 <strchr+0x30>
     f83:	38 d1                	cmp    %dl,%cl
     f85:	75 f1                	jne    f78 <strchr+0x18>
     f87:	5d                   	pop    %ebp
     f88:	c3                   	ret
     f89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     f90:	31 c0                	xor    %eax,%eax
     f92:	5d                   	pop    %ebp
     f93:	c3                   	ret
     f94:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     f9b:	00 
     f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000fa0 <gets>:
     fa0:	55                   	push   %ebp
     fa1:	89 e5                	mov    %esp,%ebp
     fa3:	57                   	push   %edi
     fa4:	56                   	push   %esi
     fa5:	8d 75 e7             	lea    -0x19(%ebp),%esi
     fa8:	53                   	push   %ebx
     fa9:	31 db                	xor    %ebx,%ebx
     fab:	83 ec 1c             	sub    $0x1c,%esp
     fae:	eb 27                	jmp    fd7 <gets+0x37>
     fb0:	83 ec 04             	sub    $0x4,%esp
     fb3:	6a 01                	push   $0x1
     fb5:	56                   	push   %esi
     fb6:	6a 00                	push   $0x0
     fb8:	e8 1e 01 00 00       	call   10db <read>
     fbd:	83 c4 10             	add    $0x10,%esp
     fc0:	85 c0                	test   %eax,%eax
     fc2:	7e 1d                	jle    fe1 <gets+0x41>
     fc4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     fc8:	8b 55 08             	mov    0x8(%ebp),%edx
     fcb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
     fcf:	3c 0a                	cmp    $0xa,%al
     fd1:	74 10                	je     fe3 <gets+0x43>
     fd3:	3c 0d                	cmp    $0xd,%al
     fd5:	74 0c                	je     fe3 <gets+0x43>
     fd7:	89 df                	mov    %ebx,%edi
     fd9:	83 c3 01             	add    $0x1,%ebx
     fdc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     fdf:	7c cf                	jl     fb0 <gets+0x10>
     fe1:	89 fb                	mov    %edi,%ebx
     fe3:	8b 45 08             	mov    0x8(%ebp),%eax
     fe6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
     fea:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fed:	5b                   	pop    %ebx
     fee:	5e                   	pop    %esi
     fef:	5f                   	pop    %edi
     ff0:	5d                   	pop    %ebp
     ff1:	c3                   	ret
     ff2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     ff9:	00 
     ffa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00001000 <stat>:
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	56                   	push   %esi
    1004:	53                   	push   %ebx
    1005:	83 ec 08             	sub    $0x8,%esp
    1008:	6a 00                	push   $0x0
    100a:	ff 75 08             	push   0x8(%ebp)
    100d:	e8 f1 00 00 00       	call   1103 <open>
    1012:	83 c4 10             	add    $0x10,%esp
    1015:	85 c0                	test   %eax,%eax
    1017:	78 27                	js     1040 <stat+0x40>
    1019:	83 ec 08             	sub    $0x8,%esp
    101c:	ff 75 0c             	push   0xc(%ebp)
    101f:	89 c3                	mov    %eax,%ebx
    1021:	50                   	push   %eax
    1022:	e8 f4 00 00 00       	call   111b <fstat>
    1027:	89 1c 24             	mov    %ebx,(%esp)
    102a:	89 c6                	mov    %eax,%esi
    102c:	e8 ba 00 00 00       	call   10eb <close>
    1031:	83 c4 10             	add    $0x10,%esp
    1034:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1037:	89 f0                	mov    %esi,%eax
    1039:	5b                   	pop    %ebx
    103a:	5e                   	pop    %esi
    103b:	5d                   	pop    %ebp
    103c:	c3                   	ret
    103d:	8d 76 00             	lea    0x0(%esi),%esi
    1040:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1045:	eb ed                	jmp    1034 <stat+0x34>
    1047:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    104e:	00 
    104f:	90                   	nop

00001050 <atoi>:
    1050:	55                   	push   %ebp
    1051:	89 e5                	mov    %esp,%ebp
    1053:	53                   	push   %ebx
    1054:	8b 55 08             	mov    0x8(%ebp),%edx
    1057:	0f be 02             	movsbl (%edx),%eax
    105a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    105d:	80 f9 09             	cmp    $0x9,%cl
    1060:	b9 00 00 00 00       	mov    $0x0,%ecx
    1065:	77 1e                	ja     1085 <atoi+0x35>
    1067:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    106e:	00 
    106f:	90                   	nop
    1070:	83 c2 01             	add    $0x1,%edx
    1073:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    1076:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
    107a:	0f be 02             	movsbl (%edx),%eax
    107d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    1080:	80 fb 09             	cmp    $0x9,%bl
    1083:	76 eb                	jbe    1070 <atoi+0x20>
    1085:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1088:	89 c8                	mov    %ecx,%eax
    108a:	c9                   	leave
    108b:	c3                   	ret
    108c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001090 <memmove>:
    1090:	55                   	push   %ebp
    1091:	89 e5                	mov    %esp,%ebp
    1093:	57                   	push   %edi
    1094:	8b 45 10             	mov    0x10(%ebp),%eax
    1097:	8b 55 08             	mov    0x8(%ebp),%edx
    109a:	56                   	push   %esi
    109b:	8b 75 0c             	mov    0xc(%ebp),%esi
    109e:	85 c0                	test   %eax,%eax
    10a0:	7e 13                	jle    10b5 <memmove+0x25>
    10a2:	01 d0                	add    %edx,%eax
    10a4:	89 d7                	mov    %edx,%edi
    10a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    10ad:	00 
    10ae:	66 90                	xchg   %ax,%ax
    10b0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
    10b1:	39 f8                	cmp    %edi,%eax
    10b3:	75 fb                	jne    10b0 <memmove+0x20>
    10b5:	5e                   	pop    %esi
    10b6:	89 d0                	mov    %edx,%eax
    10b8:	5f                   	pop    %edi
    10b9:	5d                   	pop    %ebp
    10ba:	c3                   	ret

000010bb <fork>:
    10bb:	b8 01 00 00 00       	mov    $0x1,%eax
    10c0:	cd 40                	int    $0x40
    10c2:	c3                   	ret

000010c3 <exit>:
    10c3:	b8 02 00 00 00       	mov    $0x2,%eax
    10c8:	cd 40                	int    $0x40
    10ca:	c3                   	ret

000010cb <wait>:
    10cb:	b8 03 00 00 00       	mov    $0x3,%eax
    10d0:	cd 40                	int    $0x40
    10d2:	c3                   	ret

000010d3 <pipe>:
    10d3:	b8 04 00 00 00       	mov    $0x4,%eax
    10d8:	cd 40                	int    $0x40
    10da:	c3                   	ret

000010db <read>:
    10db:	b8 05 00 00 00       	mov    $0x5,%eax
    10e0:	cd 40                	int    $0x40
    10e2:	c3                   	ret

000010e3 <write>:
    10e3:	b8 10 00 00 00       	mov    $0x10,%eax
    10e8:	cd 40                	int    $0x40
    10ea:	c3                   	ret

000010eb <close>:
    10eb:	b8 15 00 00 00       	mov    $0x15,%eax
    10f0:	cd 40                	int    $0x40
    10f2:	c3                   	ret

000010f3 <kill>:
    10f3:	b8 06 00 00 00       	mov    $0x6,%eax
    10f8:	cd 40                	int    $0x40
    10fa:	c3                   	ret

000010fb <exec>:
    10fb:	b8 07 00 00 00       	mov    $0x7,%eax
    1100:	cd 40                	int    $0x40
    1102:	c3                   	ret

00001103 <open>:
    1103:	b8 0f 00 00 00       	mov    $0xf,%eax
    1108:	cd 40                	int    $0x40
    110a:	c3                   	ret

0000110b <mknod>:
    110b:	b8 11 00 00 00       	mov    $0x11,%eax
    1110:	cd 40                	int    $0x40
    1112:	c3                   	ret

00001113 <unlink>:
    1113:	b8 12 00 00 00       	mov    $0x12,%eax
    1118:	cd 40                	int    $0x40
    111a:	c3                   	ret

0000111b <fstat>:
    111b:	b8 08 00 00 00       	mov    $0x8,%eax
    1120:	cd 40                	int    $0x40
    1122:	c3                   	ret

00001123 <link>:
    1123:	b8 13 00 00 00       	mov    $0x13,%eax
    1128:	cd 40                	int    $0x40
    112a:	c3                   	ret

0000112b <mkdir>:
    112b:	b8 14 00 00 00       	mov    $0x14,%eax
    1130:	cd 40                	int    $0x40
    1132:	c3                   	ret

00001133 <chdir>:
    1133:	b8 09 00 00 00       	mov    $0x9,%eax
    1138:	cd 40                	int    $0x40
    113a:	c3                   	ret

0000113b <dup>:
    113b:	b8 0a 00 00 00       	mov    $0xa,%eax
    1140:	cd 40                	int    $0x40
    1142:	c3                   	ret

00001143 <getpid>:
    1143:	b8 0b 00 00 00       	mov    $0xb,%eax
    1148:	cd 40                	int    $0x40
    114a:	c3                   	ret

0000114b <sbrk>:
    114b:	b8 0c 00 00 00       	mov    $0xc,%eax
    1150:	cd 40                	int    $0x40
    1152:	c3                   	ret

00001153 <sleep>:
    1153:	b8 0d 00 00 00       	mov    $0xd,%eax
    1158:	cd 40                	int    $0x40
    115a:	c3                   	ret

0000115b <uptime>:
    115b:	b8 0e 00 00 00       	mov    $0xe,%eax
    1160:	cd 40                	int    $0x40
    1162:	c3                   	ret
    1163:	66 90                	xchg   %ax,%ax
    1165:	66 90                	xchg   %ax,%ax
    1167:	66 90                	xchg   %ax,%ax
    1169:	66 90                	xchg   %ax,%ax
    116b:	66 90                	xchg   %ax,%ax
    116d:	66 90                	xchg   %ax,%ax
    116f:	90                   	nop

00001170 <printint>:
    1170:	55                   	push   %ebp
    1171:	89 e5                	mov    %esp,%ebp
    1173:	57                   	push   %edi
    1174:	56                   	push   %esi
    1175:	53                   	push   %ebx
    1176:	89 cb                	mov    %ecx,%ebx
    1178:	89 d1                	mov    %edx,%ecx
    117a:	83 ec 3c             	sub    $0x3c,%esp
    117d:	89 45 c0             	mov    %eax,-0x40(%ebp)
    1180:	85 d2                	test   %edx,%edx
    1182:	0f 89 80 00 00 00    	jns    1208 <printint+0x98>
    1188:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    118c:	74 7a                	je     1208 <printint+0x98>
    118e:	f7 d9                	neg    %ecx
    1190:	b8 01 00 00 00       	mov    $0x1,%eax
    1195:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    1198:	31 f6                	xor    %esi,%esi
    119a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    11a0:	89 c8                	mov    %ecx,%eax
    11a2:	31 d2                	xor    %edx,%edx
    11a4:	89 f7                	mov    %esi,%edi
    11a6:	f7 f3                	div    %ebx
    11a8:	8d 76 01             	lea    0x1(%esi),%esi
    11ab:	0f b6 92 b4 16 00 00 	movzbl 0x16b4(%edx),%edx
    11b2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
    11b6:	89 ca                	mov    %ecx,%edx
    11b8:	89 c1                	mov    %eax,%ecx
    11ba:	39 da                	cmp    %ebx,%edx
    11bc:	73 e2                	jae    11a0 <printint+0x30>
    11be:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    11c1:	85 c0                	test   %eax,%eax
    11c3:	74 07                	je     11cc <printint+0x5c>
    11c5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
    11ca:	89 f7                	mov    %esi,%edi
    11cc:	8d 5d d8             	lea    -0x28(%ebp),%ebx
    11cf:	8b 75 c0             	mov    -0x40(%ebp),%esi
    11d2:	01 df                	add    %ebx,%edi
    11d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11d8:	0f b6 07             	movzbl (%edi),%eax
    11db:	83 ec 04             	sub    $0x4,%esp
    11de:	88 45 d7             	mov    %al,-0x29(%ebp)
    11e1:	8d 45 d7             	lea    -0x29(%ebp),%eax
    11e4:	6a 01                	push   $0x1
    11e6:	50                   	push   %eax
    11e7:	56                   	push   %esi
    11e8:	e8 f6 fe ff ff       	call   10e3 <write>
    11ed:	89 f8                	mov    %edi,%eax
    11ef:	83 c4 10             	add    $0x10,%esp
    11f2:	83 ef 01             	sub    $0x1,%edi
    11f5:	39 c3                	cmp    %eax,%ebx
    11f7:	75 df                	jne    11d8 <printint+0x68>
    11f9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11fc:	5b                   	pop    %ebx
    11fd:	5e                   	pop    %esi
    11fe:	5f                   	pop    %edi
    11ff:	5d                   	pop    %ebp
    1200:	c3                   	ret
    1201:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1208:	31 c0                	xor    %eax,%eax
    120a:	eb 89                	jmp    1195 <printint+0x25>
    120c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001210 <printf>:
    1210:	55                   	push   %ebp
    1211:	89 e5                	mov    %esp,%ebp
    1213:	57                   	push   %edi
    1214:	56                   	push   %esi
    1215:	53                   	push   %ebx
    1216:	83 ec 2c             	sub    $0x2c,%esp
    1219:	8b 75 0c             	mov    0xc(%ebp),%esi
    121c:	8b 7d 08             	mov    0x8(%ebp),%edi
    121f:	0f b6 1e             	movzbl (%esi),%ebx
    1222:	83 c6 01             	add    $0x1,%esi
    1225:	84 db                	test   %bl,%bl
    1227:	74 67                	je     1290 <printf+0x80>
    1229:	8d 4d 10             	lea    0x10(%ebp),%ecx
    122c:	31 d2                	xor    %edx,%edx
    122e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
    1231:	eb 34                	jmp    1267 <printf+0x57>
    1233:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    1238:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    123b:	ba 25 00 00 00       	mov    $0x25,%edx
    1240:	83 f8 25             	cmp    $0x25,%eax
    1243:	74 18                	je     125d <printf+0x4d>
    1245:	83 ec 04             	sub    $0x4,%esp
    1248:	8d 45 e7             	lea    -0x19(%ebp),%eax
    124b:	88 5d e7             	mov    %bl,-0x19(%ebp)
    124e:	6a 01                	push   $0x1
    1250:	50                   	push   %eax
    1251:	57                   	push   %edi
    1252:	e8 8c fe ff ff       	call   10e3 <write>
    1257:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    125a:	83 c4 10             	add    $0x10,%esp
    125d:	0f b6 1e             	movzbl (%esi),%ebx
    1260:	83 c6 01             	add    $0x1,%esi
    1263:	84 db                	test   %bl,%bl
    1265:	74 29                	je     1290 <printf+0x80>
    1267:	0f b6 c3             	movzbl %bl,%eax
    126a:	85 d2                	test   %edx,%edx
    126c:	74 ca                	je     1238 <printf+0x28>
    126e:	83 fa 25             	cmp    $0x25,%edx
    1271:	75 ea                	jne    125d <printf+0x4d>
    1273:	83 f8 25             	cmp    $0x25,%eax
    1276:	0f 84 04 01 00 00    	je     1380 <printf+0x170>
    127c:	83 e8 63             	sub    $0x63,%eax
    127f:	83 f8 15             	cmp    $0x15,%eax
    1282:	77 1c                	ja     12a0 <printf+0x90>
    1284:	ff 24 85 5c 16 00 00 	jmp    *0x165c(,%eax,4)
    128b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    1290:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1293:	5b                   	pop    %ebx
    1294:	5e                   	pop    %esi
    1295:	5f                   	pop    %edi
    1296:	5d                   	pop    %ebp
    1297:	c3                   	ret
    1298:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    129f:	00 
    12a0:	83 ec 04             	sub    $0x4,%esp
    12a3:	8d 55 e7             	lea    -0x19(%ebp),%edx
    12a6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    12aa:	6a 01                	push   $0x1
    12ac:	52                   	push   %edx
    12ad:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    12b0:	57                   	push   %edi
    12b1:	e8 2d fe ff ff       	call   10e3 <write>
    12b6:	83 c4 0c             	add    $0xc,%esp
    12b9:	88 5d e7             	mov    %bl,-0x19(%ebp)
    12bc:	6a 01                	push   $0x1
    12be:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    12c1:	52                   	push   %edx
    12c2:	57                   	push   %edi
    12c3:	e8 1b fe ff ff       	call   10e3 <write>
    12c8:	83 c4 10             	add    $0x10,%esp
    12cb:	31 d2                	xor    %edx,%edx
    12cd:	eb 8e                	jmp    125d <printf+0x4d>
    12cf:	90                   	nop
    12d0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    12d3:	83 ec 0c             	sub    $0xc,%esp
    12d6:	b9 10 00 00 00       	mov    $0x10,%ecx
    12db:	8b 13                	mov    (%ebx),%edx
    12dd:	6a 00                	push   $0x0
    12df:	89 f8                	mov    %edi,%eax
    12e1:	83 c3 04             	add    $0x4,%ebx
    12e4:	e8 87 fe ff ff       	call   1170 <printint>
    12e9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    12ec:	83 c4 10             	add    $0x10,%esp
    12ef:	31 d2                	xor    %edx,%edx
    12f1:	e9 67 ff ff ff       	jmp    125d <printf+0x4d>
    12f6:	8b 45 d0             	mov    -0x30(%ebp),%eax
    12f9:	8b 18                	mov    (%eax),%ebx
    12fb:	83 c0 04             	add    $0x4,%eax
    12fe:	89 45 d0             	mov    %eax,-0x30(%ebp)
    1301:	85 db                	test   %ebx,%ebx
    1303:	0f 84 87 00 00 00    	je     1390 <printf+0x180>
    1309:	0f b6 03             	movzbl (%ebx),%eax
    130c:	31 d2                	xor    %edx,%edx
    130e:	84 c0                	test   %al,%al
    1310:	0f 84 47 ff ff ff    	je     125d <printf+0x4d>
    1316:	8d 55 e7             	lea    -0x19(%ebp),%edx
    1319:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    131c:	89 de                	mov    %ebx,%esi
    131e:	89 d3                	mov    %edx,%ebx
    1320:	83 ec 04             	sub    $0x4,%esp
    1323:	88 45 e7             	mov    %al,-0x19(%ebp)
    1326:	83 c6 01             	add    $0x1,%esi
    1329:	6a 01                	push   $0x1
    132b:	53                   	push   %ebx
    132c:	57                   	push   %edi
    132d:	e8 b1 fd ff ff       	call   10e3 <write>
    1332:	0f b6 06             	movzbl (%esi),%eax
    1335:	83 c4 10             	add    $0x10,%esp
    1338:	84 c0                	test   %al,%al
    133a:	75 e4                	jne    1320 <printf+0x110>
    133c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    133f:	31 d2                	xor    %edx,%edx
    1341:	e9 17 ff ff ff       	jmp    125d <printf+0x4d>
    1346:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    1349:	83 ec 0c             	sub    $0xc,%esp
    134c:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1351:	8b 13                	mov    (%ebx),%edx
    1353:	6a 01                	push   $0x1
    1355:	eb 88                	jmp    12df <printf+0xcf>
    1357:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    135a:	83 ec 04             	sub    $0x4,%esp
    135d:	8d 55 e7             	lea    -0x19(%ebp),%edx
    1360:	8b 03                	mov    (%ebx),%eax
    1362:	83 c3 04             	add    $0x4,%ebx
    1365:	88 45 e7             	mov    %al,-0x19(%ebp)
    1368:	6a 01                	push   $0x1
    136a:	52                   	push   %edx
    136b:	57                   	push   %edi
    136c:	e8 72 fd ff ff       	call   10e3 <write>
    1371:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    1374:	83 c4 10             	add    $0x10,%esp
    1377:	31 d2                	xor    %edx,%edx
    1379:	e9 df fe ff ff       	jmp    125d <printf+0x4d>
    137e:	66 90                	xchg   %ax,%ax
    1380:	83 ec 04             	sub    $0x4,%esp
    1383:	88 5d e7             	mov    %bl,-0x19(%ebp)
    1386:	8d 55 e7             	lea    -0x19(%ebp),%edx
    1389:	6a 01                	push   $0x1
    138b:	e9 31 ff ff ff       	jmp    12c1 <printf+0xb1>
    1390:	b8 28 00 00 00       	mov    $0x28,%eax
    1395:	bb 1e 16 00 00       	mov    $0x161e,%ebx
    139a:	e9 77 ff ff ff       	jmp    1316 <printf+0x106>
    139f:	90                   	nop

000013a0 <free>:
    13a0:	55                   	push   %ebp
    13a1:	a1 24 1e 00 00       	mov    0x1e24,%eax
    13a6:	89 e5                	mov    %esp,%ebp
    13a8:	57                   	push   %edi
    13a9:	56                   	push   %esi
    13aa:	53                   	push   %ebx
    13ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
    13ae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    13b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13b8:	8b 10                	mov    (%eax),%edx
    13ba:	39 c8                	cmp    %ecx,%eax
    13bc:	73 32                	jae    13f0 <free+0x50>
    13be:	39 d1                	cmp    %edx,%ecx
    13c0:	72 04                	jb     13c6 <free+0x26>
    13c2:	39 d0                	cmp    %edx,%eax
    13c4:	72 32                	jb     13f8 <free+0x58>
    13c6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    13c9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    13cc:	39 fa                	cmp    %edi,%edx
    13ce:	74 30                	je     1400 <free+0x60>
    13d0:	89 53 f8             	mov    %edx,-0x8(%ebx)
    13d3:	8b 50 04             	mov    0x4(%eax),%edx
    13d6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    13d9:	39 f1                	cmp    %esi,%ecx
    13db:	74 3a                	je     1417 <free+0x77>
    13dd:	89 08                	mov    %ecx,(%eax)
    13df:	5b                   	pop    %ebx
    13e0:	a3 24 1e 00 00       	mov    %eax,0x1e24
    13e5:	5e                   	pop    %esi
    13e6:	5f                   	pop    %edi
    13e7:	5d                   	pop    %ebp
    13e8:	c3                   	ret
    13e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    13f0:	39 d0                	cmp    %edx,%eax
    13f2:	72 04                	jb     13f8 <free+0x58>
    13f4:	39 d1                	cmp    %edx,%ecx
    13f6:	72 ce                	jb     13c6 <free+0x26>
    13f8:	89 d0                	mov    %edx,%eax
    13fa:	eb bc                	jmp    13b8 <free+0x18>
    13fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1400:	03 72 04             	add    0x4(%edx),%esi
    1403:	89 73 fc             	mov    %esi,-0x4(%ebx)
    1406:	8b 10                	mov    (%eax),%edx
    1408:	8b 12                	mov    (%edx),%edx
    140a:	89 53 f8             	mov    %edx,-0x8(%ebx)
    140d:	8b 50 04             	mov    0x4(%eax),%edx
    1410:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1413:	39 f1                	cmp    %esi,%ecx
    1415:	75 c6                	jne    13dd <free+0x3d>
    1417:	03 53 fc             	add    -0x4(%ebx),%edx
    141a:	a3 24 1e 00 00       	mov    %eax,0x1e24
    141f:	89 50 04             	mov    %edx,0x4(%eax)
    1422:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    1425:	89 08                	mov    %ecx,(%eax)
    1427:	5b                   	pop    %ebx
    1428:	5e                   	pop    %esi
    1429:	5f                   	pop    %edi
    142a:	5d                   	pop    %ebp
    142b:	c3                   	ret
    142c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001430 <malloc>:
    1430:	55                   	push   %ebp
    1431:	89 e5                	mov    %esp,%ebp
    1433:	57                   	push   %edi
    1434:	56                   	push   %esi
    1435:	53                   	push   %ebx
    1436:	83 ec 0c             	sub    $0xc,%esp
    1439:	8b 45 08             	mov    0x8(%ebp),%eax
    143c:	8b 15 24 1e 00 00    	mov    0x1e24,%edx
    1442:	8d 78 07             	lea    0x7(%eax),%edi
    1445:	c1 ef 03             	shr    $0x3,%edi
    1448:	83 c7 01             	add    $0x1,%edi
    144b:	85 d2                	test   %edx,%edx
    144d:	0f 84 8d 00 00 00    	je     14e0 <malloc+0xb0>
    1453:	8b 02                	mov    (%edx),%eax
    1455:	8b 48 04             	mov    0x4(%eax),%ecx
    1458:	39 f9                	cmp    %edi,%ecx
    145a:	73 64                	jae    14c0 <malloc+0x90>
    145c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1461:	39 df                	cmp    %ebx,%edi
    1463:	0f 43 df             	cmovae %edi,%ebx
    1466:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    146d:	eb 0a                	jmp    1479 <malloc+0x49>
    146f:	90                   	nop
    1470:	8b 02                	mov    (%edx),%eax
    1472:	8b 48 04             	mov    0x4(%eax),%ecx
    1475:	39 f9                	cmp    %edi,%ecx
    1477:	73 47                	jae    14c0 <malloc+0x90>
    1479:	89 c2                	mov    %eax,%edx
    147b:	3b 05 24 1e 00 00    	cmp    0x1e24,%eax
    1481:	75 ed                	jne    1470 <malloc+0x40>
    1483:	83 ec 0c             	sub    $0xc,%esp
    1486:	56                   	push   %esi
    1487:	e8 bf fc ff ff       	call   114b <sbrk>
    148c:	83 c4 10             	add    $0x10,%esp
    148f:	83 f8 ff             	cmp    $0xffffffff,%eax
    1492:	74 1c                	je     14b0 <malloc+0x80>
    1494:	89 58 04             	mov    %ebx,0x4(%eax)
    1497:	83 ec 0c             	sub    $0xc,%esp
    149a:	83 c0 08             	add    $0x8,%eax
    149d:	50                   	push   %eax
    149e:	e8 fd fe ff ff       	call   13a0 <free>
    14a3:	8b 15 24 1e 00 00    	mov    0x1e24,%edx
    14a9:	83 c4 10             	add    $0x10,%esp
    14ac:	85 d2                	test   %edx,%edx
    14ae:	75 c0                	jne    1470 <malloc+0x40>
    14b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14b3:	31 c0                	xor    %eax,%eax
    14b5:	5b                   	pop    %ebx
    14b6:	5e                   	pop    %esi
    14b7:	5f                   	pop    %edi
    14b8:	5d                   	pop    %ebp
    14b9:	c3                   	ret
    14ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    14c0:	39 cf                	cmp    %ecx,%edi
    14c2:	74 4c                	je     1510 <malloc+0xe0>
    14c4:	29 f9                	sub    %edi,%ecx
    14c6:	89 48 04             	mov    %ecx,0x4(%eax)
    14c9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
    14cc:	89 78 04             	mov    %edi,0x4(%eax)
    14cf:	89 15 24 1e 00 00    	mov    %edx,0x1e24
    14d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14d8:	83 c0 08             	add    $0x8,%eax
    14db:	5b                   	pop    %ebx
    14dc:	5e                   	pop    %esi
    14dd:	5f                   	pop    %edi
    14de:	5d                   	pop    %ebp
    14df:	c3                   	ret
    14e0:	c7 05 24 1e 00 00 28 	movl   $0x1e28,0x1e24
    14e7:	1e 00 00 
    14ea:	b8 28 1e 00 00       	mov    $0x1e28,%eax
    14ef:	c7 05 28 1e 00 00 28 	movl   $0x1e28,0x1e28
    14f6:	1e 00 00 
    14f9:	c7 05 2c 1e 00 00 00 	movl   $0x0,0x1e2c
    1500:	00 00 00 
    1503:	e9 54 ff ff ff       	jmp    145c <malloc+0x2c>
    1508:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    150f:	00 
    1510:	8b 08                	mov    (%eax),%ecx
    1512:	89 0a                	mov    %ecx,(%edx)
    1514:	eb b9                	jmp    14cf <malloc+0x9f>
