
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	push   -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	53                   	push   %ebx
       e:	51                   	push   %ecx
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
       f:	eb 10                	jmp    21 <main+0x21>
      11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(fd >= 3){
      18:	83 f8 02             	cmp    $0x2,%eax
      1b:	0f 8f 5e 01 00 00    	jg     17f <main+0x17f>
  while((fd = open("console", O_RDWR)) >= 0){
      21:	83 ec 08             	sub    $0x8,%esp
      24:	6a 02                	push   $0x2
      26:	68 06 16 00 00       	push   $0x1606
      2b:	e8 d3 10 00 00       	call   1103 <open>
      30:	83 c4 10             	add    $0x10,%esp
      33:	85 c0                	test   %eax,%eax
      35:	79 e1                	jns    18 <main+0x18>
      37:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
      3e:	00 
      3f:	90                   	nop
  printf(1, "majid-sadeghinejad|parsa-ahmadi|aria-azem $ ");
      40:	83 ec 08             	sub    $0x8,%esp
      43:	68 38 15 00 00       	push   $0x1538
      48:	6a 01                	push   $0x1
      4a:	e8 e1 11 00 00       	call   1230 <printf>
  memset(buf, 0, nbuf);
      4f:	83 c4 0c             	add    $0xc,%esp
      52:	6a 64                	push   $0x64
      54:	6a 00                	push   $0x0
      56:	68 60 1d 00 00       	push   $0x1d60
      5b:	e8 e0 0e 00 00       	call   f40 <memset>
  gets(buf, nbuf);
      60:	58                   	pop    %eax
      61:	5a                   	pop    %edx
      62:	6a 64                	push   $0x64
      64:	68 60 1d 00 00       	push   $0x1d60
      69:	e8 32 0f 00 00       	call   fa0 <gets>
  if(buf[0] == 0) // EOF
      6e:	0f b6 05 60 1d 00 00 	movzbl 0x1d60,%eax
      75:	83 c4 10             	add    $0x10,%esp
      78:	84 c0                	test   %al,%al
      7a:	0f 84 fa 00 00 00    	je     17a <main+0x17a>
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){

    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      80:	3c 63                	cmp    $0x63,%al
      82:	74 24                	je     a8 <main+0xa8>
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }

    if(buf[0] == '!')
      84:	3c 21                	cmp    $0x21,%al
      86:	74 78                	je     100 <main+0x100>
int
fork1(void)
{
  int pid;

  pid = fork();
      88:	e8 2e 10 00 00       	call   10bb <fork>
  if(pid == -1)
      8d:	83 f8 ff             	cmp    $0xffffffff,%eax
      90:	0f 84 0f 01 00 00    	je     1a5 <main+0x1a5>
    if(fork1() == 0)
      96:	85 c0                	test   %eax,%eax
      98:	0f 84 f2 00 00 00    	je     190 <main+0x190>
    wait();
      9e:	e8 28 10 00 00       	call   10cb <wait>
      a3:	eb 9b                	jmp    40 <main+0x40>
      a5:	8d 76 00             	lea    0x0(%esi),%esi
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      a8:	80 3d 61 1d 00 00 64 	cmpb   $0x64,0x1d61
      af:	75 d7                	jne    88 <main+0x88>
      b1:	80 3d 62 1d 00 00 20 	cmpb   $0x20,0x1d62
      b8:	75 ce                	jne    88 <main+0x88>
      buf[strlen(buf)-1] = 0;  // chop \n
      ba:	83 ec 0c             	sub    $0xc,%esp
      bd:	68 60 1d 00 00       	push   $0x1d60
      c2:	e8 49 0e 00 00       	call   f10 <strlen>
      if(chdir(buf+3) < 0)
      c7:	c7 04 24 63 1d 00 00 	movl   $0x1d63,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      ce:	c6 80 5f 1d 00 00 00 	movb   $0x0,0x1d5f(%eax)
      if(chdir(buf+3) < 0)
      d5:	e8 59 10 00 00       	call   1133 <chdir>
      da:	83 c4 10             	add    $0x10,%esp
      dd:	85 c0                	test   %eax,%eax
      df:	0f 89 5b ff ff ff    	jns    40 <main+0x40>
        printf(2, "cannot cd %s\n", buf+3);
      e5:	50                   	push   %eax
      e6:	68 63 1d 00 00       	push   $0x1d63
      eb:	68 0e 16 00 00       	push   $0x160e
      f0:	6a 02                	push   $0x2
      f2:	e8 39 11 00 00       	call   1230 <printf>
      f7:	83 c4 10             	add    $0x10,%esp
      fa:	e9 41 ff ff ff       	jmp    40 <main+0x40>
      ff:	90                   	nop
  while (buf[i] != '\n') {
     100:	0f b6 05 61 1d 00 00 	movzbl 0x1d61,%eax
  int i = 1, j = 0;
     107:	31 c9                	xor    %ecx,%ecx
  while (buf[i] != '\n') {
     109:	3c 0a                	cmp    $0xa,%al
     10b:	74 43                	je     150 <main+0x150>
  int i = 1, j = 0;
     10d:	ba 01 00 00 00       	mov    $0x1,%edx
  int in_hash_block = 0;
     112:	31 db                	xor    %ebx,%ebx
     114:	eb 22                	jmp    138 <main+0x138>
     116:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     11d:	00 
     11e:	66 90                	xchg   %ax,%ax
    if (!in_hash_block)
     120:	85 db                	test   %ebx,%ebx
     122:	75 09                	jne    12d <main+0x12d>
      cleaned_input[j++] = buf[i];
     124:	88 81 e0 1d 00 00    	mov    %al,0x1de0(%ecx)
     12a:	83 c1 01             	add    $0x1,%ecx
  while (buf[i] != '\n') {
     12d:	0f b6 82 60 1d 00 00 	movzbl 0x1d60(%edx),%eax
     134:	3c 0a                	cmp    $0xa,%al
     136:	74 18                	je     150 <main+0x150>
      i++;
     138:	83 c2 01             	add    $0x1,%edx
    if (buf[i] == '#') {
     13b:	3c 23                	cmp    $0x23,%al
     13d:	75 e1                	jne    120 <main+0x120>
  while (buf[i] != '\n') {
     13f:	0f b6 82 60 1d 00 00 	movzbl 0x1d60(%edx),%eax
     146:	83 f3 01             	xor    $0x1,%ebx
     149:	3c 0a                	cmp    $0xa,%al
     14b:	75 eb                	jne    138 <main+0x138>
     14d:	8d 76 00             	lea    0x0(%esi),%esi
      print_special(process_input(buf));
     150:	83 ec 0c             	sub    $0xc,%esp
  cleaned_input[j] = '\0';
     153:	c6 81 e0 1d 00 00 00 	movb   $0x0,0x1de0(%ecx)
      print_special(process_input(buf));
     15a:	68 e0 1d 00 00       	push   $0x1de0
     15f:	e8 5c 01 00 00       	call   2c0 <print_special>
      printf(1,"\n");
     164:	59                   	pop    %ecx
     165:	5b                   	pop    %ebx
     166:	68 82 15 00 00       	push   $0x1582
     16b:	6a 01                	push   $0x1
     16d:	e8 be 10 00 00       	call   1230 <printf>
      continue;
     172:	83 c4 10             	add    $0x10,%esp
     175:	e9 c6 fe ff ff       	jmp    40 <main+0x40>
  exit();
     17a:	e8 44 0f 00 00       	call   10c3 <exit>
      close(fd);
     17f:	83 ec 0c             	sub    $0xc,%esp
     182:	50                   	push   %eax
     183:	e8 63 0f 00 00       	call   10eb <close>
      break;
     188:	83 c4 10             	add    $0x10,%esp
     18b:	e9 b0 fe ff ff       	jmp    40 <main+0x40>
      runcmd(parsecmd(buf));
     190:	83 ec 0c             	sub    $0xc,%esp
     193:	68 60 1d 00 00       	push   $0x1d60
     198:	e8 73 0c 00 00       	call   e10 <parsecmd>
     19d:	89 04 24             	mov    %eax,(%esp)
     1a0:	e8 bb 02 00 00       	call   460 <runcmd>
    panic("fork");
     1a5:	83 ec 0c             	sub    $0xc,%esp
     1a8:	68 68 15 00 00       	push   $0x1568
     1ad:	e8 6e 02 00 00       	call   420 <panic>
     1b2:	66 90                	xchg   %ax,%ax
     1b4:	66 90                	xchg   %ax,%ax
     1b6:	66 90                	xchg   %ax,%ax
     1b8:	66 90                	xchg   %ax,%ax
     1ba:	66 90                	xchg   %ax,%ax
     1bc:	66 90                	xchg   %ax,%ax
     1be:	66 90                	xchg   %ax,%ax

000001c0 <getcmd>:
{
     1c0:	55                   	push   %ebp
     1c1:	89 e5                	mov    %esp,%ebp
     1c3:	56                   	push   %esi
     1c4:	53                   	push   %ebx
     1c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
     1c8:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(1, "majid-sadeghinejad|parsa-ahmadi|aria-azem $ ");
     1cb:	83 ec 08             	sub    $0x8,%esp
     1ce:	68 38 15 00 00       	push   $0x1538
     1d3:	6a 01                	push   $0x1
     1d5:	e8 56 10 00 00       	call   1230 <printf>
  memset(buf, 0, nbuf);
     1da:	83 c4 0c             	add    $0xc,%esp
     1dd:	56                   	push   %esi
     1de:	6a 00                	push   $0x0
     1e0:	53                   	push   %ebx
     1e1:	e8 5a 0d 00 00       	call   f40 <memset>
  gets(buf, nbuf);
     1e6:	58                   	pop    %eax
     1e7:	5a                   	pop    %edx
     1e8:	56                   	push   %esi
     1e9:	53                   	push   %ebx
     1ea:	e8 b1 0d 00 00       	call   fa0 <gets>
  if(buf[0] == 0) // EOF
     1ef:	83 c4 10             	add    $0x10,%esp
     1f2:	80 3b 01             	cmpb   $0x1,(%ebx)
     1f5:	19 c0                	sbb    %eax,%eax
}
     1f7:	8d 65 f8             	lea    -0x8(%ebp),%esp
     1fa:	5b                   	pop    %ebx
     1fb:	5e                   	pop    %esi
     1fc:	5d                   	pop    %ebp
     1fd:	c3                   	ret
     1fe:	66 90                	xchg   %ax,%ax

00000200 <process_input>:
char* process_input(char* buf) {
     200:	55                   	push   %ebp
     201:	89 e5                	mov    %esp,%ebp
     203:	53                   	push   %ebx
     204:	8b 55 08             	mov    0x8(%ebp),%edx
  while (buf[i] != '\n') {
     207:	0f b6 42 01          	movzbl 0x1(%edx),%eax
     20b:	3c 0a                	cmp    $0xa,%al
     20d:	74 51                	je     260 <process_input+0x60>
     20f:	83 c2 02             	add    $0x2,%edx
  int in_hash_block = 0;
     212:	31 db                	xor    %ebx,%ebx
  int i = 1, j = 0;
     214:	31 c9                	xor    %ecx,%ecx
     216:	eb 1f                	jmp    237 <process_input+0x37>
     218:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     21f:	00 
    if (!in_hash_block)
     220:	85 db                	test   %ebx,%ebx
     222:	75 09                	jne    22d <process_input+0x2d>
      cleaned_input[j++] = buf[i];
     224:	88 81 e0 1d 00 00    	mov    %al,0x1de0(%ecx)
     22a:	83 c1 01             	add    $0x1,%ecx
  while (buf[i] != '\n') {
     22d:	0f b6 02             	movzbl (%edx),%eax
     230:	83 c2 01             	add    $0x1,%edx
     233:	3c 0a                	cmp    $0xa,%al
     235:	74 11                	je     248 <process_input+0x48>
    if (buf[i] == '#') {
     237:	3c 23                	cmp    $0x23,%al
     239:	75 e5                	jne    220 <process_input+0x20>
  while (buf[i] != '\n') {
     23b:	0f b6 02             	movzbl (%edx),%eax
     23e:	83 c2 01             	add    $0x1,%edx
     241:	83 f3 01             	xor    $0x1,%ebx
     244:	3c 0a                	cmp    $0xa,%al
     246:	75 ef                	jne    237 <process_input+0x37>
  cleaned_input[j] = '\0';
     248:	c6 81 e0 1d 00 00 00 	movb   $0x0,0x1de0(%ecx)
}
     24f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     252:	b8 e0 1d 00 00       	mov    $0x1de0,%eax
     257:	c9                   	leave
     258:	c3                   	ret
     259:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  int i = 1, j = 0;
     260:	31 c9                	xor    %ecx,%ecx
     262:	eb e4                	jmp    248 <process_input+0x48>
     264:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     26b:	00 
     26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000270 <color_print>:
void color_print(char* text){
     270:	55                   	push   %ebp
  temp[0] = '\5';
     271:	b8 05 00 00 00       	mov    $0x5,%eax
void color_print(char* text){
     276:	89 e5                	mov    %esp,%ebp
     278:	53                   	push   %ebx
  printf(1, "%s", temp);
     279:	8d 5d f6             	lea    -0xa(%ebp),%ebx
void color_print(char* text){
     27c:	83 ec 18             	sub    $0x18,%esp
  temp[0] = '\5';
     27f:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  printf(1, "%s", temp);
     283:	53                   	push   %ebx
     284:	68 65 15 00 00       	push   $0x1565
     289:	6a 01                	push   $0x1
     28b:	e8 a0 0f 00 00       	call   1230 <printf>
  printf(1,"%s",text);
     290:	83 c4 0c             	add    $0xc,%esp
     293:	ff 75 08             	push   0x8(%ebp)
     296:	68 65 15 00 00       	push   $0x1565
     29b:	6a 01                	push   $0x1
     29d:	e8 8e 0f 00 00       	call   1230 <printf>
  printf(1,"%s",temp);
     2a2:	83 c4 0c             	add    $0xc,%esp
     2a5:	53                   	push   %ebx
     2a6:	68 65 15 00 00       	push   $0x1565
     2ab:	6a 01                	push   $0x1
     2ad:	e8 7e 0f 00 00       	call   1230 <printf>
}
     2b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     2b5:	83 c4 10             	add    $0x10,%esp
     2b8:	c9                   	leave
     2b9:	c3                   	ret
     2ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002c0 <print_special>:
void print_special(char* cleaned_string) {
     2c0:	55                   	push   %ebp
     2c1:	89 e5                	mov    %esp,%ebp
     2c3:	57                   	push   %edi
     2c4:	56                   	push   %esi
     2c5:	53                   	push   %ebx
     2c6:	81 ec 8c 00 00 00    	sub    $0x8c,%esp
  for (int i=0 ; i < strlen(cleaned_string) ; i++) {
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
    if ((cleaned_string[i] >= 'a' && cleaned_string[i] <= 'z') || (cleaned_string[i] >= 'A' && cleaned_string[i] <= 'Z') || cleaned_string[i] == '_') {
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
      printf(1,"%s", temp);
     317:	83 ec 04             	sub    $0x4,%esp
     31a:	8d 45 82             	lea    -0x7e(%ebp),%eax
  for (int i=0 ; i < strlen(cleaned_string) ; i++) {
     31d:	83 85 74 ff ff ff 01 	addl   $0x1,-0x8c(%ebp)
      temp[0] = cleaned_string[i];
     324:	88 55 82             	mov    %dl,-0x7e(%ebp)
      temp[1] = '\0';
     327:	c6 45 83 00          	movb   $0x0,-0x7d(%ebp)
      printf(1,"%s", temp);
     32b:	50                   	push   %eax
     32c:	68 65 15 00 00       	push   $0x1565
     331:	6a 01                	push   $0x1
     333:	e8 f8 0e 00 00       	call   1230 <printf>
     338:	83 c4 10             	add    $0x10,%esp
  for (int i=0 ; i < strlen(cleaned_string) ; i++) {
     33b:	eb a3                	jmp    2e0 <print_special+0x20>
     33d:	8d 76 00             	lea    0x0(%esi),%esi
     340:	31 c9                	xor    %ecx,%ecx
     342:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        temp_word[j++] = cleaned_string[i++];
     348:	89 ce                	mov    %ecx,%esi
     34a:	8d 49 01             	lea    0x1(%ecx),%ecx
     34d:	88 54 0d 83          	mov    %dl,-0x7d(%ebp,%ecx,1)
      while ((cleaned_string[i] >= 'a' && cleaned_string[i] <= 'z') || (cleaned_string[i] >= 'A' && cleaned_string[i] <= 'Z') || cleaned_string[i] == '_') {
     351:	0f b6 54 37 01       	movzbl 0x1(%edi,%esi,1),%edx
     356:	89 d0                	mov    %edx,%eax
     358:	83 e0 df             	and    $0xffffffdf,%eax
     35b:	83 e8 41             	sub    $0x41,%eax
     35e:	3c 19                	cmp    $0x19,%al
     360:	76 e6                	jbe    348 <print_special+0x88>
     362:	80 fa 5f             	cmp    $0x5f,%dl
     365:	74 e1                	je     348 <print_special+0x88>
      temp_word[j] = '\0';
     367:	c6 44 0d 84 00       	movb   $0x0,-0x7c(%ebp,%ecx,1)
      for (int k = 0; k < NUM_KEYWORDS; k++) {
     36c:	31 db                	xor    %ebx,%ebx
     36e:	8d 7d 84             	lea    -0x7c(%ebp),%edi
     371:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if (strcmp(temp_word, keywords[k]) == 0) {
     378:	83 ec 08             	sub    $0x8,%esp
     37b:	ff 34 9d 24 1d 00 00 	push   0x1d24(,%ebx,4)
     382:	57                   	push   %edi
     383:	e8 28 0b 00 00       	call   eb0 <strcmp>
     388:	83 c4 10             	add    $0x10,%esp
     38b:	85 c0                	test   %eax,%eax
     38d:	74 31                	je     3c0 <print_special+0x100>
      for (int k = 0; k < NUM_KEYWORDS; k++) {
     38f:	83 c3 01             	add    $0x1,%ebx
     392:	83 fb 07             	cmp    $0x7,%ebx
     395:	75 e1                	jne    378 <print_special+0xb8>
        printf(1,"%s",temp_word);
     397:	83 ec 04             	sub    $0x4,%esp
  printf(1,"%s",temp);
     39a:	57                   	push   %edi
     39b:	68 65 15 00 00       	push   $0x1565
     3a0:	6a 01                	push   $0x1
     3a2:	e8 89 0e 00 00       	call   1230 <printf>
        temp_word[j++] = cleaned_string[i++];
     3a7:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
}
     3ad:	83 c4 10             	add    $0x10,%esp
        temp_word[j++] = cleaned_string[i++];
     3b0:	8d 44 06 01          	lea    0x1(%esi,%eax,1),%eax
     3b4:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
     3ba:	e9 21 ff ff ff       	jmp    2e0 <print_special+0x20>
     3bf:	90                   	nop
          color_print(keywords[k]);
     3c0:	8b 04 9d 24 1d 00 00 	mov    0x1d24(,%ebx,4),%eax
  printf(1, "%s", temp);
     3c7:	83 ec 04             	sub    $0x4,%esp
     3ca:	8d 7d 82             	lea    -0x7e(%ebp),%edi
          color_print(keywords[k]);
     3cd:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
  temp[0] = '\5';
     3d3:	0f b7 05 78 16 00 00 	movzwl 0x1678,%eax
     3da:	66 89 45 82          	mov    %ax,-0x7e(%ebp)
  printf(1, "%s", temp);
     3de:	57                   	push   %edi
     3df:	68 65 15 00 00       	push   $0x1565
     3e4:	6a 01                	push   $0x1
     3e6:	e8 45 0e 00 00       	call   1230 <printf>
  printf(1,"%s",text);
     3eb:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
     3f1:	83 c4 0c             	add    $0xc,%esp
     3f4:	50                   	push   %eax
     3f5:	68 65 15 00 00       	push   $0x1565
     3fa:	6a 01                	push   $0x1
     3fc:	e8 2f 0e 00 00       	call   1230 <printf>
  printf(1,"%s",temp);
     401:	83 c4 0c             	add    $0xc,%esp
     404:	eb 94                	jmp    39a <print_special+0xda>
     406:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     40d:	00 
     40e:	66 90                	xchg   %ax,%ax
}
     410:	8d 65 f4             	lea    -0xc(%ebp),%esp
     413:	5b                   	pop    %ebx
     414:	5e                   	pop    %esi
     415:	5f                   	pop    %edi
     416:	5d                   	pop    %ebp
     417:	c3                   	ret
     418:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     41f:	00 

00000420 <panic>:
{
     420:	55                   	push   %ebp
     421:	89 e5                	mov    %esp,%ebp
     423:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     426:	ff 75 08             	push   0x8(%ebp)
     429:	68 02 16 00 00       	push   $0x1602
     42e:	6a 02                	push   $0x2
     430:	e8 fb 0d 00 00       	call   1230 <printf>
  exit();
     435:	e8 89 0c 00 00       	call   10c3 <exit>
     43a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000440 <fork1>:
{
     440:	55                   	push   %ebp
     441:	89 e5                	mov    %esp,%ebp
     443:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     446:	e8 70 0c 00 00       	call   10bb <fork>
  if(pid == -1)
     44b:	83 f8 ff             	cmp    $0xffffffff,%eax
     44e:	74 02                	je     452 <fork1+0x12>
  return pid;
}
     450:	c9                   	leave
     451:	c3                   	ret
    panic("fork");
     452:	83 ec 0c             	sub    $0xc,%esp
     455:	68 68 15 00 00       	push   $0x1568
     45a:	e8 c1 ff ff ff       	call   420 <panic>
     45f:	90                   	nop

00000460 <runcmd>:
{
     460:	55                   	push   %ebp
     461:	89 e5                	mov    %esp,%ebp
     463:	53                   	push   %ebx
     464:	83 ec 14             	sub    $0x14,%esp
     467:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     46a:	85 db                	test   %ebx,%ebx
     46c:	74 42                	je     4b0 <runcmd+0x50>
  switch(cmd->type){
     46e:	83 3b 05             	cmpl   $0x5,(%ebx)
     471:	0f 87 e3 00 00 00    	ja     55a <runcmd+0xfa>
     477:	8b 03                	mov    (%ebx),%eax
     479:	ff 24 85 48 16 00 00 	jmp    *0x1648(,%eax,4)
    if(ecmd->argv[0] == 0)
     480:	8b 43 04             	mov    0x4(%ebx),%eax
     483:	85 c0                	test   %eax,%eax
     485:	74 29                	je     4b0 <runcmd+0x50>
    exec(ecmd->argv[0], ecmd->argv);
     487:	8d 53 04             	lea    0x4(%ebx),%edx
     48a:	51                   	push   %ecx
     48b:	51                   	push   %ecx
     48c:	52                   	push   %edx
     48d:	50                   	push   %eax
     48e:	e8 68 0c 00 00       	call   10fb <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     493:	83 c4 0c             	add    $0xc,%esp
     496:	ff 73 04             	push   0x4(%ebx)
     499:	68 74 15 00 00       	push   $0x1574
     49e:	6a 02                	push   $0x2
     4a0:	e8 8b 0d 00 00       	call   1230 <printf>
    break;
     4a5:	83 c4 10             	add    $0x10,%esp
     4a8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     4af:	00 
    exit();
     4b0:	e8 0e 0c 00 00       	call   10c3 <exit>
    if(fork1() == 0)
     4b5:	e8 86 ff ff ff       	call   440 <fork1>
     4ba:	85 c0                	test   %eax,%eax
     4bc:	75 f2                	jne    4b0 <runcmd+0x50>
     4be:	e9 8c 00 00 00       	jmp    54f <runcmd+0xef>
    if(pipe(p) < 0)
     4c3:	83 ec 0c             	sub    $0xc,%esp
     4c6:	8d 45 f0             	lea    -0x10(%ebp),%eax
     4c9:	50                   	push   %eax
     4ca:	e8 04 0c 00 00       	call   10d3 <pipe>
     4cf:	83 c4 10             	add    $0x10,%esp
     4d2:	85 c0                	test   %eax,%eax
     4d4:	0f 88 a2 00 00 00    	js     57c <runcmd+0x11c>
    if(fork1() == 0){
     4da:	e8 61 ff ff ff       	call   440 <fork1>
     4df:	85 c0                	test   %eax,%eax
     4e1:	0f 84 a2 00 00 00    	je     589 <runcmd+0x129>
    if(fork1() == 0){
     4e7:	e8 54 ff ff ff       	call   440 <fork1>
     4ec:	85 c0                	test   %eax,%eax
     4ee:	0f 84 c3 00 00 00    	je     5b7 <runcmd+0x157>
    close(p[0]);
     4f4:	83 ec 0c             	sub    $0xc,%esp
     4f7:	ff 75 f0             	push   -0x10(%ebp)
     4fa:	e8 ec 0b 00 00       	call   10eb <close>
    close(p[1]);
     4ff:	58                   	pop    %eax
     500:	ff 75 f4             	push   -0xc(%ebp)
     503:	e8 e3 0b 00 00       	call   10eb <close>
    wait();
     508:	e8 be 0b 00 00       	call   10cb <wait>
    wait();
     50d:	e8 b9 0b 00 00       	call   10cb <wait>
    break;
     512:	83 c4 10             	add    $0x10,%esp
     515:	eb 99                	jmp    4b0 <runcmd+0x50>
    if(fork1() == 0)
     517:	e8 24 ff ff ff       	call   440 <fork1>
     51c:	85 c0                	test   %eax,%eax
     51e:	74 2f                	je     54f <runcmd+0xef>
    wait();
     520:	e8 a6 0b 00 00       	call   10cb <wait>
    runcmd(lcmd->right);
     525:	83 ec 0c             	sub    $0xc,%esp
     528:	ff 73 08             	push   0x8(%ebx)
     52b:	e8 30 ff ff ff       	call   460 <runcmd>
    close(rcmd->fd);
     530:	83 ec 0c             	sub    $0xc,%esp
     533:	ff 73 14             	push   0x14(%ebx)
     536:	e8 b0 0b 00 00       	call   10eb <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     53b:	58                   	pop    %eax
     53c:	5a                   	pop    %edx
     53d:	ff 73 10             	push   0x10(%ebx)
     540:	ff 73 08             	push   0x8(%ebx)
     543:	e8 bb 0b 00 00       	call   1103 <open>
     548:	83 c4 10             	add    $0x10,%esp
     54b:	85 c0                	test   %eax,%eax
     54d:	78 18                	js     567 <runcmd+0x107>
      runcmd(bcmd->cmd);
     54f:	83 ec 0c             	sub    $0xc,%esp
     552:	ff 73 04             	push   0x4(%ebx)
     555:	e8 06 ff ff ff       	call   460 <runcmd>
    panic("runcmd");
     55a:	83 ec 0c             	sub    $0xc,%esp
     55d:	68 6d 15 00 00       	push   $0x156d
     562:	e8 b9 fe ff ff       	call   420 <panic>
      printf(2, "open %s failed\n", rcmd->file);
     567:	51                   	push   %ecx
     568:	ff 73 08             	push   0x8(%ebx)
     56b:	68 84 15 00 00       	push   $0x1584
     570:	6a 02                	push   $0x2
     572:	e8 b9 0c 00 00       	call   1230 <printf>
      exit();
     577:	e8 47 0b 00 00       	call   10c3 <exit>
      panic("pipe");
     57c:	83 ec 0c             	sub    $0xc,%esp
     57f:	68 94 15 00 00       	push   $0x1594
     584:	e8 97 fe ff ff       	call   420 <panic>
      close(1);
     589:	83 ec 0c             	sub    $0xc,%esp
     58c:	6a 01                	push   $0x1
     58e:	e8 58 0b 00 00       	call   10eb <close>
      dup(p[1]);
     593:	58                   	pop    %eax
     594:	ff 75 f4             	push   -0xc(%ebp)
     597:	e8 9f 0b 00 00       	call   113b <dup>
      close(p[0]);
     59c:	58                   	pop    %eax
     59d:	ff 75 f0             	push   -0x10(%ebp)
     5a0:	e8 46 0b 00 00       	call   10eb <close>
      close(p[1]);
     5a5:	58                   	pop    %eax
     5a6:	ff 75 f4             	push   -0xc(%ebp)
     5a9:	e8 3d 0b 00 00       	call   10eb <close>
      runcmd(pcmd->left);
     5ae:	5a                   	pop    %edx
     5af:	ff 73 04             	push   0x4(%ebx)
     5b2:	e8 a9 fe ff ff       	call   460 <runcmd>
      close(0);
     5b7:	83 ec 0c             	sub    $0xc,%esp
     5ba:	6a 00                	push   $0x0
     5bc:	e8 2a 0b 00 00       	call   10eb <close>
      dup(p[0]);
     5c1:	5a                   	pop    %edx
     5c2:	ff 75 f0             	push   -0x10(%ebp)
     5c5:	e8 71 0b 00 00       	call   113b <dup>
      close(p[0]);
     5ca:	59                   	pop    %ecx
     5cb:	ff 75 f0             	push   -0x10(%ebp)
     5ce:	e8 18 0b 00 00       	call   10eb <close>
      close(p[1]);
     5d3:	58                   	pop    %eax
     5d4:	ff 75 f4             	push   -0xc(%ebp)
     5d7:	e8 0f 0b 00 00       	call   10eb <close>
      runcmd(pcmd->right);
     5dc:	58                   	pop    %eax
     5dd:	ff 73 08             	push   0x8(%ebx)
     5e0:	e8 7b fe ff ff       	call   460 <runcmd>
     5e5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     5ec:	00 
     5ed:	8d 76 00             	lea    0x0(%esi),%esi

000005f0 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     5f0:	55                   	push   %ebp
     5f1:	89 e5                	mov    %esp,%ebp
     5f3:	53                   	push   %ebx
     5f4:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     5f7:	6a 54                	push   $0x54
     5f9:	e8 52 0e 00 00       	call   1450 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     5fe:	83 c4 0c             	add    $0xc,%esp
     601:	6a 54                	push   $0x54
  cmd = malloc(sizeof(*cmd));
     603:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     605:	6a 00                	push   $0x0
     607:	50                   	push   %eax
     608:	e8 33 09 00 00       	call   f40 <memset>
  cmd->type = EXEC;
     60d:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     613:	89 d8                	mov    %ebx,%eax
     615:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     618:	c9                   	leave
     619:	c3                   	ret
     61a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000620 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     620:	55                   	push   %ebp
     621:	89 e5                	mov    %esp,%ebp
     623:	53                   	push   %ebx
     624:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     627:	6a 18                	push   $0x18
     629:	e8 22 0e 00 00       	call   1450 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     62e:	83 c4 0c             	add    $0xc,%esp
     631:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     633:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     635:	6a 00                	push   $0x0
     637:	50                   	push   %eax
     638:	e8 03 09 00 00       	call   f40 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     63d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     640:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     646:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     649:	8b 45 0c             	mov    0xc(%ebp),%eax
     64c:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     64f:	8b 45 10             	mov    0x10(%ebp),%eax
     652:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     655:	8b 45 14             	mov    0x14(%ebp),%eax
     658:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     65b:	8b 45 18             	mov    0x18(%ebp),%eax
     65e:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     661:	89 d8                	mov    %ebx,%eax
     663:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     666:	c9                   	leave
     667:	c3                   	ret
     668:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     66f:	00 

00000670 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     670:	55                   	push   %ebp
     671:	89 e5                	mov    %esp,%ebp
     673:	53                   	push   %ebx
     674:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     677:	6a 0c                	push   $0xc
     679:	e8 d2 0d 00 00       	call   1450 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     67e:	83 c4 0c             	add    $0xc,%esp
     681:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     683:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     685:	6a 00                	push   $0x0
     687:	50                   	push   %eax
     688:	e8 b3 08 00 00       	call   f40 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     68d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     690:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     696:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     699:	8b 45 0c             	mov    0xc(%ebp),%eax
     69c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     69f:	89 d8                	mov    %ebx,%eax
     6a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     6a4:	c9                   	leave
     6a5:	c3                   	ret
     6a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     6ad:	00 
     6ae:	66 90                	xchg   %ax,%ax

000006b0 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     6b0:	55                   	push   %ebp
     6b1:	89 e5                	mov    %esp,%ebp
     6b3:	53                   	push   %ebx
     6b4:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     6b7:	6a 0c                	push   $0xc
     6b9:	e8 92 0d 00 00       	call   1450 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     6be:	83 c4 0c             	add    $0xc,%esp
     6c1:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     6c3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     6c5:	6a 00                	push   $0x0
     6c7:	50                   	push   %eax
     6c8:	e8 73 08 00 00       	call   f40 <memset>
  cmd->type = LIST;
  cmd->left = left;
     6cd:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     6d0:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     6d6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     6d9:	8b 45 0c             	mov    0xc(%ebp),%eax
     6dc:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     6df:	89 d8                	mov    %ebx,%eax
     6e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     6e4:	c9                   	leave
     6e5:	c3                   	ret
     6e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     6ed:	00 
     6ee:	66 90                	xchg   %ax,%ax

000006f0 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     6f0:	55                   	push   %ebp
     6f1:	89 e5                	mov    %esp,%ebp
     6f3:	53                   	push   %ebx
     6f4:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     6f7:	6a 08                	push   $0x8
     6f9:	e8 52 0d 00 00       	call   1450 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     6fe:	83 c4 0c             	add    $0xc,%esp
     701:	6a 08                	push   $0x8
  cmd = malloc(sizeof(*cmd));
     703:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     705:	6a 00                	push   $0x0
     707:	50                   	push   %eax
     708:	e8 33 08 00 00       	call   f40 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     70d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     710:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     716:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     719:	89 d8                	mov    %ebx,%eax
     71b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     71e:	c9                   	leave
     71f:	c3                   	ret

00000720 <gettoken>:

char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     720:	55                   	push   %ebp
     721:	89 e5                	mov    %esp,%ebp
     723:	57                   	push   %edi
     724:	56                   	push   %esi
     725:	53                   	push   %ebx
     726:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     729:	8b 45 08             	mov    0x8(%ebp),%eax
{
     72c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     72f:	8b 75 10             	mov    0x10(%ebp),%esi
  s = *ps;
     732:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     734:	39 df                	cmp    %ebx,%edi
     736:	72 0f                	jb     747 <gettoken+0x27>
     738:	eb 25                	jmp    75f <gettoken+0x3f>
     73a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     740:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     743:	39 fb                	cmp    %edi,%ebx
     745:	74 18                	je     75f <gettoken+0x3f>
     747:	0f be 07             	movsbl (%edi),%eax
     74a:	83 ec 08             	sub    $0x8,%esp
     74d:	50                   	push   %eax
     74e:	68 40 1d 00 00       	push   $0x1d40
     753:	e8 08 08 00 00       	call   f60 <strchr>
     758:	83 c4 10             	add    $0x10,%esp
     75b:	85 c0                	test   %eax,%eax
     75d:	75 e1                	jne    740 <gettoken+0x20>
  if(q)
     75f:	85 f6                	test   %esi,%esi
     761:	74 02                	je     765 <gettoken+0x45>
    *q = s;
     763:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     765:	0f b6 07             	movzbl (%edi),%eax
  switch(*s){
     768:	3c 3c                	cmp    $0x3c,%al
     76a:	0f 8f c8 00 00 00    	jg     838 <gettoken+0x118>
     770:	3c 3a                	cmp    $0x3a,%al
     772:	7f 5a                	jg     7ce <gettoken+0xae>
     774:	84 c0                	test   %al,%al
     776:	75 48                	jne    7c0 <gettoken+0xa0>
     778:	31 f6                	xor    %esi,%esi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     77a:	8b 4d 14             	mov    0x14(%ebp),%ecx
     77d:	85 c9                	test   %ecx,%ecx
     77f:	74 05                	je     786 <gettoken+0x66>
    *eq = s;
     781:	8b 45 14             	mov    0x14(%ebp),%eax
     784:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     786:	39 df                	cmp    %ebx,%edi
     788:	72 0d                	jb     797 <gettoken+0x77>
     78a:	eb 23                	jmp    7af <gettoken+0x8f>
     78c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s++;
     790:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     793:	39 fb                	cmp    %edi,%ebx
     795:	74 18                	je     7af <gettoken+0x8f>
     797:	0f be 07             	movsbl (%edi),%eax
     79a:	83 ec 08             	sub    $0x8,%esp
     79d:	50                   	push   %eax
     79e:	68 40 1d 00 00       	push   $0x1d40
     7a3:	e8 b8 07 00 00       	call   f60 <strchr>
     7a8:	83 c4 10             	add    $0x10,%esp
     7ab:	85 c0                	test   %eax,%eax
     7ad:	75 e1                	jne    790 <gettoken+0x70>
  *ps = s;
     7af:	8b 45 08             	mov    0x8(%ebp),%eax
     7b2:	89 38                	mov    %edi,(%eax)
  return ret;
}
     7b4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7b7:	89 f0                	mov    %esi,%eax
     7b9:	5b                   	pop    %ebx
     7ba:	5e                   	pop    %esi
     7bb:	5f                   	pop    %edi
     7bc:	5d                   	pop    %ebp
     7bd:	c3                   	ret
     7be:	66 90                	xchg   %ax,%ax
  switch(*s){
     7c0:	78 22                	js     7e4 <gettoken+0xc4>
     7c2:	3c 26                	cmp    $0x26,%al
     7c4:	74 08                	je     7ce <gettoken+0xae>
     7c6:	8d 48 d8             	lea    -0x28(%eax),%ecx
     7c9:	80 f9 01             	cmp    $0x1,%cl
     7cc:	77 16                	ja     7e4 <gettoken+0xc4>
  ret = *s;
     7ce:	0f be f0             	movsbl %al,%esi
    s++;
     7d1:	83 c7 01             	add    $0x1,%edi
    break;
     7d4:	eb a4                	jmp    77a <gettoken+0x5a>
     7d6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     7dd:	00 
     7de:	66 90                	xchg   %ax,%ax
  switch(*s){
     7e0:	3c 7c                	cmp    $0x7c,%al
     7e2:	74 ea                	je     7ce <gettoken+0xae>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     7e4:	39 df                	cmp    %ebx,%edi
     7e6:	72 27                	jb     80f <gettoken+0xef>
     7e8:	e9 87 00 00 00       	jmp    874 <gettoken+0x154>
     7ed:	8d 76 00             	lea    0x0(%esi),%esi
     7f0:	0f be 07             	movsbl (%edi),%eax
     7f3:	83 ec 08             	sub    $0x8,%esp
     7f6:	50                   	push   %eax
     7f7:	68 1c 1d 00 00       	push   $0x1d1c
     7fc:	e8 5f 07 00 00       	call   f60 <strchr>
     801:	83 c4 10             	add    $0x10,%esp
     804:	85 c0                	test   %eax,%eax
     806:	75 1f                	jne    827 <gettoken+0x107>
      s++;
     808:	83 c7 01             	add    $0x1,%edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     80b:	39 fb                	cmp    %edi,%ebx
     80d:	74 4d                	je     85c <gettoken+0x13c>
     80f:	0f be 07             	movsbl (%edi),%eax
     812:	83 ec 08             	sub    $0x8,%esp
     815:	50                   	push   %eax
     816:	68 40 1d 00 00       	push   $0x1d40
     81b:	e8 40 07 00 00       	call   f60 <strchr>
     820:	83 c4 10             	add    $0x10,%esp
     823:	85 c0                	test   %eax,%eax
     825:	74 c9                	je     7f0 <gettoken+0xd0>
    ret = 'a';
     827:	be 61 00 00 00       	mov    $0x61,%esi
     82c:	e9 49 ff ff ff       	jmp    77a <gettoken+0x5a>
     831:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     838:	3c 3e                	cmp    $0x3e,%al
     83a:	75 a4                	jne    7e0 <gettoken+0xc0>
    if(*s == '>'){
     83c:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
     840:	74 0d                	je     84f <gettoken+0x12f>
    s++;
     842:	83 c7 01             	add    $0x1,%edi
  ret = *s;
     845:	be 3e 00 00 00       	mov    $0x3e,%esi
     84a:	e9 2b ff ff ff       	jmp    77a <gettoken+0x5a>
      s++;
     84f:	83 c7 02             	add    $0x2,%edi
      ret = '+';
     852:	be 2b 00 00 00       	mov    $0x2b,%esi
     857:	e9 1e ff ff ff       	jmp    77a <gettoken+0x5a>
  if(eq)
     85c:	8b 45 14             	mov    0x14(%ebp),%eax
     85f:	85 c0                	test   %eax,%eax
     861:	74 05                	je     868 <gettoken+0x148>
    *eq = s;
     863:	8b 45 14             	mov    0x14(%ebp),%eax
     866:	89 18                	mov    %ebx,(%eax)
  while(s < es && strchr(whitespace, *s))
     868:	89 df                	mov    %ebx,%edi
    ret = 'a';
     86a:	be 61 00 00 00       	mov    $0x61,%esi
     86f:	e9 3b ff ff ff       	jmp    7af <gettoken+0x8f>
  if(eq)
     874:	8b 55 14             	mov    0x14(%ebp),%edx
     877:	85 d2                	test   %edx,%edx
     879:	74 ef                	je     86a <gettoken+0x14a>
    *eq = s;
     87b:	8b 45 14             	mov    0x14(%ebp),%eax
     87e:	89 38                	mov    %edi,(%eax)
  while(s < es && strchr(whitespace, *s))
     880:	eb e8                	jmp    86a <gettoken+0x14a>
     882:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     889:	00 
     88a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000890 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     890:	55                   	push   %ebp
     891:	89 e5                	mov    %esp,%ebp
     893:	57                   	push   %edi
     894:	56                   	push   %esi
     895:	53                   	push   %ebx
     896:	83 ec 0c             	sub    $0xc,%esp
     899:	8b 7d 08             	mov    0x8(%ebp),%edi
     89c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     89f:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     8a1:	39 f3                	cmp    %esi,%ebx
     8a3:	72 12                	jb     8b7 <peek+0x27>
     8a5:	eb 28                	jmp    8cf <peek+0x3f>
     8a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     8ae:	00 
     8af:	90                   	nop
    s++;
     8b0:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     8b3:	39 de                	cmp    %ebx,%esi
     8b5:	74 18                	je     8cf <peek+0x3f>
     8b7:	0f be 03             	movsbl (%ebx),%eax
     8ba:	83 ec 08             	sub    $0x8,%esp
     8bd:	50                   	push   %eax
     8be:	68 40 1d 00 00       	push   $0x1d40
     8c3:	e8 98 06 00 00       	call   f60 <strchr>
     8c8:	83 c4 10             	add    $0x10,%esp
     8cb:	85 c0                	test   %eax,%eax
     8cd:	75 e1                	jne    8b0 <peek+0x20>
  *ps = s;
     8cf:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     8d1:	0f be 03             	movsbl (%ebx),%eax
     8d4:	31 d2                	xor    %edx,%edx
     8d6:	84 c0                	test   %al,%al
     8d8:	75 0e                	jne    8e8 <peek+0x58>
}
     8da:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8dd:	89 d0                	mov    %edx,%eax
     8df:	5b                   	pop    %ebx
     8e0:	5e                   	pop    %esi
     8e1:	5f                   	pop    %edi
     8e2:	5d                   	pop    %ebp
     8e3:	c3                   	ret
     8e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return *s && strchr(toks, *s);
     8e8:	83 ec 08             	sub    $0x8,%esp
     8eb:	50                   	push   %eax
     8ec:	ff 75 10             	push   0x10(%ebp)
     8ef:	e8 6c 06 00 00       	call   f60 <strchr>
     8f4:	83 c4 10             	add    $0x10,%esp
     8f7:	31 d2                	xor    %edx,%edx
     8f9:	85 c0                	test   %eax,%eax
     8fb:	0f 95 c2             	setne  %dl
}
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
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     910:	55                   	push   %ebp
     911:	89 e5                	mov    %esp,%ebp
     913:	57                   	push   %edi
     914:	56                   	push   %esi
     915:	53                   	push   %ebx
     916:	83 ec 2c             	sub    $0x2c,%esp
     919:	8b 75 0c             	mov    0xc(%ebp),%esi
     91c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     91f:	90                   	nop
     920:	83 ec 04             	sub    $0x4,%esp
     923:	68 b6 15 00 00       	push   $0x15b6
     928:	53                   	push   %ebx
     929:	56                   	push   %esi
     92a:	e8 61 ff ff ff       	call   890 <peek>
     92f:	83 c4 10             	add    $0x10,%esp
     932:	85 c0                	test   %eax,%eax
     934:	0f 84 f6 00 00 00    	je     a30 <parseredirs+0x120>
    tok = gettoken(ps, es, 0, 0);
     93a:	6a 00                	push   $0x0
     93c:	6a 00                	push   $0x0
     93e:	53                   	push   %ebx
     93f:	56                   	push   %esi
     940:	e8 db fd ff ff       	call   720 <gettoken>
     945:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
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
      panic("missing file for redirection");
    switch(tok){
     962:	83 ff 3c             	cmp    $0x3c,%edi
     965:	74 69                	je     9d0 <parseredirs+0xc0>
     967:	83 ff 3e             	cmp    $0x3e,%edi
     96a:	74 05                	je     971 <parseredirs+0x61>
     96c:	83 ff 2b             	cmp    $0x2b,%edi
     96f:	75 af                	jne    920 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     971:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     974:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     977:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     97a:	89 55 d0             	mov    %edx,-0x30(%ebp)
     97d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     980:	6a 18                	push   $0x18
     982:	e8 c9 0a 00 00       	call   1450 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     987:	83 c4 0c             	add    $0xc,%esp
     98a:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     98c:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     98e:	6a 00                	push   $0x0
     990:	50                   	push   %eax
     991:	e8 aa 05 00 00       	call   f40 <memset>
  cmd->type = REDIR;
     996:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     99c:	8b 45 08             	mov    0x8(%ebp),%eax
      break;
     99f:	83 c4 10             	add    $0x10,%esp
  cmd->cmd = subcmd;
     9a2:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     9a5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     9a8:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     9ab:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->mode = mode;
     9ae:	c7 47 10 01 02 00 00 	movl   $0x201,0x10(%edi)
  cmd->efile = efile;
     9b5:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->fd = fd;
     9b8:	c7 47 14 01 00 00 00 	movl   $0x1,0x14(%edi)
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     9bf:	89 7d 08             	mov    %edi,0x8(%ebp)
      break;
     9c2:	e9 59 ff ff ff       	jmp    920 <parseredirs+0x10>
     9c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     9ce:	00 
     9cf:	90                   	nop
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     9d0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     9d3:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     9d6:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     9d9:	89 55 d0             	mov    %edx,-0x30(%ebp)
     9dc:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     9df:	6a 18                	push   $0x18
     9e1:	e8 6a 0a 00 00       	call   1450 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     9e6:	83 c4 0c             	add    $0xc,%esp
     9e9:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     9eb:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     9ed:	6a 00                	push   $0x0
     9ef:	50                   	push   %eax
     9f0:	e8 4b 05 00 00       	call   f40 <memset>
  cmd->cmd = subcmd;
     9f5:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->file = file;
     9f8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      break;
     9fb:	83 c4 10             	add    $0x10,%esp
  cmd->efile = efile;
     9fe:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->type = REDIR;
     a01:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     a07:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     a0a:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     a0d:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->mode = mode;
     a10:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
  cmd->fd = fd;
     a17:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     a1e:	89 7d 08             	mov    %edi,0x8(%ebp)
      break;
     a21:	e9 fa fe ff ff       	jmp    920 <parseredirs+0x10>
     a26:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     a2d:	00 
     a2e:	66 90                	xchg   %ax,%ax
    }
  }
  return cmd;
}
     a30:	8b 45 08             	mov    0x8(%ebp),%eax
     a33:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a36:	5b                   	pop    %ebx
     a37:	5e                   	pop    %esi
     a38:	5f                   	pop    %edi
     a39:	5d                   	pop    %ebp
     a3a:	c3                   	ret
      panic("missing file for redirection");
     a3b:	83 ec 0c             	sub    $0xc,%esp
     a3e:	68 99 15 00 00       	push   $0x1599
     a43:	e8 d8 f9 ff ff       	call   420 <panic>
     a48:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     a4f:	00 

00000a50 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     a50:	55                   	push   %ebp
     a51:	89 e5                	mov    %esp,%ebp
     a53:	57                   	push   %edi
     a54:	56                   	push   %esi
     a55:	53                   	push   %ebx
     a56:	83 ec 30             	sub    $0x30,%esp
     a59:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a5c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     a5f:	68 b9 15 00 00       	push   $0x15b9
     a64:	56                   	push   %esi
     a65:	53                   	push   %ebx
     a66:	e8 25 fe ff ff       	call   890 <peek>
     a6b:	83 c4 10             	add    $0x10,%esp
     a6e:	85 c0                	test   %eax,%eax
     a70:	0f 85 aa 00 00 00    	jne    b20 <parseexec+0xd0>
  cmd = malloc(sizeof(*cmd));
     a76:	83 ec 0c             	sub    $0xc,%esp
     a79:	89 c7                	mov    %eax,%edi
     a7b:	6a 54                	push   $0x54
     a7d:	e8 ce 09 00 00       	call   1450 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     a82:	83 c4 0c             	add    $0xc,%esp
     a85:	6a 54                	push   $0x54
     a87:	6a 00                	push   $0x0
     a89:	89 45 d0             	mov    %eax,-0x30(%ebp)
     a8c:	50                   	push   %eax
     a8d:	e8 ae 04 00 00       	call   f40 <memset>
  cmd->type = EXEC;
     a92:	8b 45 d0             	mov    -0x30(%ebp),%eax

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     a95:	83 c4 0c             	add    $0xc,%esp
  cmd->type = EXEC;
     a98:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  ret = parseredirs(ret, ps, es);
     a9e:	56                   	push   %esi
     a9f:	53                   	push   %ebx
     aa0:	50                   	push   %eax
     aa1:	e8 6a fe ff ff       	call   910 <parseredirs>

  while(!peek(ps, es, "|)&;")){
     aa6:	83 c4 10             	add    $0x10,%esp
  ret = parseredirs(ret, ps, es);
     aa9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     aac:	eb 15                	jmp    ac3 <parseexec+0x73>
     aae:	66 90                	xchg   %ax,%ax
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     ab0:	83 ec 04             	sub    $0x4,%esp
     ab3:	56                   	push   %esi
     ab4:	53                   	push   %ebx
     ab5:	ff 75 d4             	push   -0x2c(%ebp)
     ab8:	e8 53 fe ff ff       	call   910 <parseredirs>
     abd:	83 c4 10             	add    $0x10,%esp
     ac0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     ac3:	83 ec 04             	sub    $0x4,%esp
     ac6:	68 d0 15 00 00       	push   $0x15d0
     acb:	56                   	push   %esi
     acc:	53                   	push   %ebx
     acd:	e8 be fd ff ff       	call   890 <peek>
     ad2:	83 c4 10             	add    $0x10,%esp
     ad5:	85 c0                	test   %eax,%eax
     ad7:	75 5f                	jne    b38 <parseexec+0xe8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
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
    if(tok != 'a')
     aef:	83 f8 61             	cmp    $0x61,%eax
     af2:	75 62                	jne    b56 <parseexec+0x106>
    cmd->argv[argc] = q;
     af4:	8b 45 e0             	mov    -0x20(%ebp),%eax
     af7:	8b 55 d0             	mov    -0x30(%ebp),%edx
     afa:	89 44 ba 04          	mov    %eax,0x4(%edx,%edi,4)
    cmd->eargv[argc] = eq;
     afe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b01:	89 44 ba 2c          	mov    %eax,0x2c(%edx,%edi,4)
    argc++;
     b05:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARGS)
     b08:	83 ff 0a             	cmp    $0xa,%edi
     b0b:	75 a3                	jne    ab0 <parseexec+0x60>
      panic("too many args");
     b0d:	83 ec 0c             	sub    $0xc,%esp
     b10:	68 c2 15 00 00       	push   $0x15c2
     b15:	e8 06 f9 ff ff       	call   420 <panic>
     b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     b20:	89 75 0c             	mov    %esi,0xc(%ebp)
     b23:	89 5d 08             	mov    %ebx,0x8(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     b26:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b29:	5b                   	pop    %ebx
     b2a:	5e                   	pop    %esi
     b2b:	5f                   	pop    %edi
     b2c:	5d                   	pop    %ebp
    return parseblock(ps, es);
     b2d:	e9 ae 01 00 00       	jmp    ce0 <parseblock>
     b32:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  cmd->argv[argc] = 0;
     b38:	8b 45 d0             	mov    -0x30(%ebp),%eax
     b3b:	c7 44 b8 04 00 00 00 	movl   $0x0,0x4(%eax,%edi,4)
     b42:	00 
  cmd->eargv[argc] = 0;
     b43:	c7 44 b8 2c 00 00 00 	movl   $0x0,0x2c(%eax,%edi,4)
     b4a:	00 
}
     b4b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     b4e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b51:	5b                   	pop    %ebx
     b52:	5e                   	pop    %esi
     b53:	5f                   	pop    %edi
     b54:	5d                   	pop    %ebp
     b55:	c3                   	ret
      panic("syntax");
     b56:	83 ec 0c             	sub    $0xc,%esp
     b59:	68 bb 15 00 00       	push   $0x15bb
     b5e:	e8 bd f8 ff ff       	call   420 <panic>
     b63:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     b6a:	00 
     b6b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000b70 <parsepipe>:
{
     b70:	55                   	push   %ebp
     b71:	89 e5                	mov    %esp,%ebp
     b73:	57                   	push   %edi
     b74:	56                   	push   %esi
     b75:	53                   	push   %ebx
     b76:	83 ec 14             	sub    $0x14,%esp
     b79:	8b 75 08             	mov    0x8(%ebp),%esi
     b7c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parseexec(ps, es);
     b7f:	57                   	push   %edi
     b80:	56                   	push   %esi
     b81:	e8 ca fe ff ff       	call   a50 <parseexec>
  if(peek(ps, es, "|")){
     b86:	83 c4 0c             	add    $0xc,%esp
     b89:	68 d5 15 00 00       	push   $0x15d5
  cmd = parseexec(ps, es);
     b8e:	89 c3                	mov    %eax,%ebx
  if(peek(ps, es, "|")){
     b90:	57                   	push   %edi
     b91:	56                   	push   %esi
     b92:	e8 f9 fc ff ff       	call   890 <peek>
     b97:	83 c4 10             	add    $0x10,%esp
     b9a:	85 c0                	test   %eax,%eax
     b9c:	75 12                	jne    bb0 <parsepipe+0x40>
}
     b9e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ba1:	89 d8                	mov    %ebx,%eax
     ba3:	5b                   	pop    %ebx
     ba4:	5e                   	pop    %esi
     ba5:	5f                   	pop    %edi
     ba6:	5d                   	pop    %ebp
     ba7:	c3                   	ret
     ba8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     baf:	00 
    gettoken(ps, es, 0, 0);
     bb0:	6a 00                	push   $0x0
     bb2:	6a 00                	push   $0x0
     bb4:	57                   	push   %edi
     bb5:	56                   	push   %esi
     bb6:	e8 65 fb ff ff       	call   720 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     bbb:	58                   	pop    %eax
     bbc:	5a                   	pop    %edx
     bbd:	57                   	push   %edi
     bbe:	56                   	push   %esi
     bbf:	e8 ac ff ff ff       	call   b70 <parsepipe>
  cmd = malloc(sizeof(*cmd));
     bc4:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = pipecmd(cmd, parsepipe(ps, es));
     bcb:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     bcd:	e8 7e 08 00 00       	call   1450 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     bd2:	83 c4 0c             	add    $0xc,%esp
     bd5:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     bd7:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     bd9:	6a 00                	push   $0x0
     bdb:	50                   	push   %eax
     bdc:	e8 5f 03 00 00       	call   f40 <memset>
  cmd->left = left;
     be1:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     be4:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     be7:	89 f3                	mov    %esi,%ebx
  cmd->type = PIPE;
     be9:	c7 06 03 00 00 00    	movl   $0x3,(%esi)
}
     bef:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     bf1:	89 7e 08             	mov    %edi,0x8(%esi)
}
     bf4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     bf7:	5b                   	pop    %ebx
     bf8:	5e                   	pop    %esi
     bf9:	5f                   	pop    %edi
     bfa:	5d                   	pop    %ebp
     bfb:	c3                   	ret
     bfc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000c00 <parseline>:
{
     c00:	55                   	push   %ebp
     c01:	89 e5                	mov    %esp,%ebp
     c03:	57                   	push   %edi
     c04:	56                   	push   %esi
     c05:	53                   	push   %ebx
     c06:	83 ec 24             	sub    $0x24,%esp
     c09:	8b 75 08             	mov    0x8(%ebp),%esi
     c0c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parsepipe(ps, es);
     c0f:	57                   	push   %edi
     c10:	56                   	push   %esi
     c11:	e8 5a ff ff ff       	call   b70 <parsepipe>
  while(peek(ps, es, "&")){
     c16:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
     c19:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
     c1b:	eb 3b                	jmp    c58 <parseline+0x58>
     c1d:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     c20:	6a 00                	push   $0x0
     c22:	6a 00                	push   $0x0
     c24:	57                   	push   %edi
     c25:	56                   	push   %esi
     c26:	e8 f5 fa ff ff       	call   720 <gettoken>
  cmd = malloc(sizeof(*cmd));
     c2b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     c32:	e8 19 08 00 00       	call   1450 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     c37:	83 c4 0c             	add    $0xc,%esp
     c3a:	6a 08                	push   $0x8
     c3c:	6a 00                	push   $0x0
     c3e:	50                   	push   %eax
     c3f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     c42:	e8 f9 02 00 00       	call   f40 <memset>
  cmd->type = BACK;
     c47:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  cmd->cmd = subcmd;
     c4a:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     c4d:	c7 02 05 00 00 00    	movl   $0x5,(%edx)
  cmd->cmd = subcmd;
     c53:	89 5a 04             	mov    %ebx,0x4(%edx)
    cmd = backcmd(cmd);
     c56:	89 d3                	mov    %edx,%ebx
  while(peek(ps, es, "&")){
     c58:	83 ec 04             	sub    $0x4,%esp
     c5b:	68 d7 15 00 00       	push   $0x15d7
     c60:	57                   	push   %edi
     c61:	56                   	push   %esi
     c62:	e8 29 fc ff ff       	call   890 <peek>
     c67:	83 c4 10             	add    $0x10,%esp
     c6a:	85 c0                	test   %eax,%eax
     c6c:	75 b2                	jne    c20 <parseline+0x20>
  if(peek(ps, es, ";")){
     c6e:	83 ec 04             	sub    $0x4,%esp
     c71:	68 d3 15 00 00       	push   $0x15d3
     c76:	57                   	push   %edi
     c77:	56                   	push   %esi
     c78:	e8 13 fc ff ff       	call   890 <peek>
     c7d:	83 c4 10             	add    $0x10,%esp
     c80:	85 c0                	test   %eax,%eax
     c82:	75 0c                	jne    c90 <parseline+0x90>
}
     c84:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c87:	89 d8                	mov    %ebx,%eax
     c89:	5b                   	pop    %ebx
     c8a:	5e                   	pop    %esi
     c8b:	5f                   	pop    %edi
     c8c:	5d                   	pop    %ebp
     c8d:	c3                   	ret
     c8e:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     c90:	6a 00                	push   $0x0
     c92:	6a 00                	push   $0x0
     c94:	57                   	push   %edi
     c95:	56                   	push   %esi
     c96:	e8 85 fa ff ff       	call   720 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     c9b:	58                   	pop    %eax
     c9c:	5a                   	pop    %edx
     c9d:	57                   	push   %edi
     c9e:	56                   	push   %esi
     c9f:	e8 5c ff ff ff       	call   c00 <parseline>
  cmd = malloc(sizeof(*cmd));
     ca4:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = listcmd(cmd, parseline(ps, es));
     cab:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     cad:	e8 9e 07 00 00       	call   1450 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     cb2:	83 c4 0c             	add    $0xc,%esp
     cb5:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     cb7:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     cb9:	6a 00                	push   $0x0
     cbb:	50                   	push   %eax
     cbc:	e8 7f 02 00 00       	call   f40 <memset>
  cmd->left = left;
     cc1:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     cc4:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
     cc7:	89 f3                	mov    %esi,%ebx
  cmd->type = LIST;
     cc9:	c7 06 04 00 00 00    	movl   $0x4,(%esi)
}
     ccf:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     cd1:	89 7e 08             	mov    %edi,0x8(%esi)
}
     cd4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cd7:	5b                   	pop    %ebx
     cd8:	5e                   	pop    %esi
     cd9:	5f                   	pop    %edi
     cda:	5d                   	pop    %ebp
     cdb:	c3                   	ret
     cdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ce0 <parseblock>:
{
     ce0:	55                   	push   %ebp
     ce1:	89 e5                	mov    %esp,%ebp
     ce3:	57                   	push   %edi
     ce4:	56                   	push   %esi
     ce5:	53                   	push   %ebx
     ce6:	83 ec 10             	sub    $0x10,%esp
     ce9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     cec:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     cef:	68 b9 15 00 00       	push   $0x15b9
     cf4:	56                   	push   %esi
     cf5:	53                   	push   %ebx
     cf6:	e8 95 fb ff ff       	call   890 <peek>
     cfb:	83 c4 10             	add    $0x10,%esp
     cfe:	85 c0                	test   %eax,%eax
     d00:	74 4a                	je     d4c <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     d02:	6a 00                	push   $0x0
     d04:	6a 00                	push   $0x0
     d06:	56                   	push   %esi
     d07:	53                   	push   %ebx
     d08:	e8 13 fa ff ff       	call   720 <gettoken>
  cmd = parseline(ps, es);
     d0d:	58                   	pop    %eax
     d0e:	5a                   	pop    %edx
     d0f:	56                   	push   %esi
     d10:	53                   	push   %ebx
     d11:	e8 ea fe ff ff       	call   c00 <parseline>
  if(!peek(ps, es, ")"))
     d16:	83 c4 0c             	add    $0xc,%esp
     d19:	68 f5 15 00 00       	push   $0x15f5
  cmd = parseline(ps, es);
     d1e:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     d20:	56                   	push   %esi
     d21:	53                   	push   %ebx
     d22:	e8 69 fb ff ff       	call   890 <peek>
     d27:	83 c4 10             	add    $0x10,%esp
     d2a:	85 c0                	test   %eax,%eax
     d2c:	74 2b                	je     d59 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
     d2e:	6a 00                	push   $0x0
     d30:	6a 00                	push   $0x0
     d32:	56                   	push   %esi
     d33:	53                   	push   %ebx
     d34:	e8 e7 f9 ff ff       	call   720 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     d39:	83 c4 0c             	add    $0xc,%esp
     d3c:	56                   	push   %esi
     d3d:	53                   	push   %ebx
     d3e:	57                   	push   %edi
     d3f:	e8 cc fb ff ff       	call   910 <parseredirs>
}
     d44:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d47:	5b                   	pop    %ebx
     d48:	5e                   	pop    %esi
     d49:	5f                   	pop    %edi
     d4a:	5d                   	pop    %ebp
     d4b:	c3                   	ret
    panic("parseblock");
     d4c:	83 ec 0c             	sub    $0xc,%esp
     d4f:	68 d9 15 00 00       	push   $0x15d9
     d54:	e8 c7 f6 ff ff       	call   420 <panic>
    panic("syntax - missing )");
     d59:	83 ec 0c             	sub    $0xc,%esp
     d5c:	68 e4 15 00 00       	push   $0x15e4
     d61:	e8 ba f6 ff ff       	call   420 <panic>
     d66:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     d6d:	00 
     d6e:	66 90                	xchg   %ax,%ax

00000d70 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     d70:	55                   	push   %ebp
     d71:	89 e5                	mov    %esp,%ebp
     d73:	53                   	push   %ebx
     d74:	83 ec 04             	sub    $0x4,%esp
     d77:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     d7a:	85 db                	test   %ebx,%ebx
     d7c:	74 29                	je     da7 <nulterminate+0x37>
    return 0;

  switch(cmd->type){
     d7e:	83 3b 05             	cmpl   $0x5,(%ebx)
     d81:	77 24                	ja     da7 <nulterminate+0x37>
     d83:	8b 03                	mov    (%ebx),%eax
     d85:	ff 24 85 60 16 00 00 	jmp    *0x1660(,%eax,4)
     d8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     d90:	83 ec 0c             	sub    $0xc,%esp
     d93:	ff 73 04             	push   0x4(%ebx)
     d96:	e8 d5 ff ff ff       	call   d70 <nulterminate>
    nulterminate(lcmd->right);
     d9b:	58                   	pop    %eax
     d9c:	ff 73 08             	push   0x8(%ebx)
     d9f:	e8 cc ff ff ff       	call   d70 <nulterminate>
    break;
     da4:	83 c4 10             	add    $0x10,%esp
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     da7:	89 d8                	mov    %ebx,%eax
     da9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     dac:	c9                   	leave
     dad:	c3                   	ret
     dae:	66 90                	xchg   %ax,%ax
    nulterminate(bcmd->cmd);
     db0:	83 ec 0c             	sub    $0xc,%esp
     db3:	ff 73 04             	push   0x4(%ebx)
     db6:	e8 b5 ff ff ff       	call   d70 <nulterminate>
}
     dbb:	89 d8                	mov    %ebx,%eax
    break;
     dbd:	83 c4 10             	add    $0x10,%esp
}
     dc0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     dc3:	c9                   	leave
     dc4:	c3                   	ret
     dc5:	8d 76 00             	lea    0x0(%esi),%esi
    for(i=0; ecmd->argv[i]; i++)
     dc8:	8b 4b 04             	mov    0x4(%ebx),%ecx
     dcb:	85 c9                	test   %ecx,%ecx
     dcd:	74 d8                	je     da7 <nulterminate+0x37>
     dcf:	8d 43 08             	lea    0x8(%ebx),%eax
     dd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     dd8:	8b 50 24             	mov    0x24(%eax),%edx
    for(i=0; ecmd->argv[i]; i++)
     ddb:	83 c0 04             	add    $0x4,%eax
      *ecmd->eargv[i] = 0;
     dde:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     de1:	8b 50 fc             	mov    -0x4(%eax),%edx
     de4:	85 d2                	test   %edx,%edx
     de6:	75 f0                	jne    dd8 <nulterminate+0x68>
}
     de8:	89 d8                	mov    %ebx,%eax
     dea:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ded:	c9                   	leave
     dee:	c3                   	ret
     def:	90                   	nop
    nulterminate(rcmd->cmd);
     df0:	83 ec 0c             	sub    $0xc,%esp
     df3:	ff 73 04             	push   0x4(%ebx)
     df6:	e8 75 ff ff ff       	call   d70 <nulterminate>
    *rcmd->efile = 0;
     dfb:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     dfe:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     e01:	c6 00 00             	movb   $0x0,(%eax)
}
     e04:	89 d8                	mov    %ebx,%eax
     e06:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     e09:	c9                   	leave
     e0a:	c3                   	ret
     e0b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000e10 <parsecmd>:
{
     e10:	55                   	push   %ebp
     e11:	89 e5                	mov    %esp,%ebp
     e13:	57                   	push   %edi
     e14:	56                   	push   %esi
  cmd = parseline(&s, es);
     e15:	8d 7d 08             	lea    0x8(%ebp),%edi
{
     e18:	53                   	push   %ebx
     e19:	83 ec 18             	sub    $0x18,%esp
  es = s + strlen(s);
     e1c:	8b 5d 08             	mov    0x8(%ebp),%ebx
     e1f:	53                   	push   %ebx
     e20:	e8 eb 00 00 00       	call   f10 <strlen>
  cmd = parseline(&s, es);
     e25:	59                   	pop    %ecx
     e26:	5e                   	pop    %esi
  es = s + strlen(s);
     e27:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     e29:	53                   	push   %ebx
     e2a:	57                   	push   %edi
     e2b:	e8 d0 fd ff ff       	call   c00 <parseline>
  peek(&s, es, "");
     e30:	83 c4 0c             	add    $0xc,%esp
     e33:	68 83 15 00 00       	push   $0x1583
  cmd = parseline(&s, es);
     e38:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     e3a:	53                   	push   %ebx
     e3b:	57                   	push   %edi
     e3c:	e8 4f fa ff ff       	call   890 <peek>
  if(s != es){
     e41:	8b 45 08             	mov    0x8(%ebp),%eax
     e44:	83 c4 10             	add    $0x10,%esp
     e47:	39 d8                	cmp    %ebx,%eax
     e49:	75 13                	jne    e5e <parsecmd+0x4e>
  nulterminate(cmd);
     e4b:	83 ec 0c             	sub    $0xc,%esp
     e4e:	56                   	push   %esi
     e4f:	e8 1c ff ff ff       	call   d70 <nulterminate>
}
     e54:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e57:	89 f0                	mov    %esi,%eax
     e59:	5b                   	pop    %ebx
     e5a:	5e                   	pop    %esi
     e5b:	5f                   	pop    %edi
     e5c:	5d                   	pop    %ebp
     e5d:	c3                   	ret
    printf(2, "leftovers: %s\n", s);
     e5e:	52                   	push   %edx
     e5f:	50                   	push   %eax
     e60:	68 f7 15 00 00       	push   $0x15f7
     e65:	6a 02                	push   $0x2
     e67:	e8 c4 03 00 00       	call   1230 <printf>
    panic("syntax");
     e6c:	c7 04 24 bb 15 00 00 	movl   $0x15bb,(%esp)
     e73:	e8 a8 f5 ff ff       	call   420 <panic>
     e78:	66 90                	xchg   %ax,%ax
     e7a:	66 90                	xchg   %ax,%ax
     e7c:	66 90                	xchg   %ax,%ax
     e7e:	66 90                	xchg   %ax,%ax

00000e80 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     e80:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     e81:	31 c0                	xor    %eax,%eax
{
     e83:	89 e5                	mov    %esp,%ebp
     e85:	53                   	push   %ebx
     e86:	8b 4d 08             	mov    0x8(%ebp),%ecx
     e89:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     e8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
     e90:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     e94:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     e97:	83 c0 01             	add    $0x1,%eax
     e9a:	84 d2                	test   %dl,%dl
     e9c:	75 f2                	jne    e90 <strcpy+0x10>
    ;
  return os;
}
     e9e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ea1:	89 c8                	mov    %ecx,%eax
     ea3:	c9                   	leave
     ea4:	c3                   	ret
     ea5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     eac:	00 
     ead:	8d 76 00             	lea    0x0(%esi),%esi

00000eb0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     eb0:	55                   	push   %ebp
     eb1:	89 e5                	mov    %esp,%ebp
     eb3:	53                   	push   %ebx
     eb4:	8b 55 08             	mov    0x8(%ebp),%edx
     eb7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     eba:	0f b6 02             	movzbl (%edx),%eax
     ebd:	84 c0                	test   %al,%al
     ebf:	75 17                	jne    ed8 <strcmp+0x28>
     ec1:	eb 3a                	jmp    efd <strcmp+0x4d>
     ec3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
     ec8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
     ecc:	83 c2 01             	add    $0x1,%edx
     ecf:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
     ed2:	84 c0                	test   %al,%al
     ed4:	74 1a                	je     ef0 <strcmp+0x40>
     ed6:	89 d9                	mov    %ebx,%ecx
     ed8:	0f b6 19             	movzbl (%ecx),%ebx
     edb:	38 c3                	cmp    %al,%bl
     edd:	74 e9                	je     ec8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
     edf:	29 d8                	sub    %ebx,%eax
}
     ee1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ee4:	c9                   	leave
     ee5:	c3                   	ret
     ee6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     eed:	00 
     eee:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
     ef0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     ef4:	31 c0                	xor    %eax,%eax
     ef6:	29 d8                	sub    %ebx,%eax
}
     ef8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     efb:	c9                   	leave
     efc:	c3                   	ret
  return (uchar)*p - (uchar)*q;
     efd:	0f b6 19             	movzbl (%ecx),%ebx
     f00:	31 c0                	xor    %eax,%eax
     f02:	eb db                	jmp    edf <strcmp+0x2f>
     f04:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     f0b:	00 
     f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000f10 <strlen>:

uint
strlen(const char *s)
{
     f10:	55                   	push   %ebp
     f11:	89 e5                	mov    %esp,%ebp
     f13:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     f16:	80 3a 00             	cmpb   $0x0,(%edx)
     f19:	74 15                	je     f30 <strlen+0x20>
     f1b:	31 c0                	xor    %eax,%eax
     f1d:	8d 76 00             	lea    0x0(%esi),%esi
     f20:	83 c0 01             	add    $0x1,%eax
     f23:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     f27:	89 c1                	mov    %eax,%ecx
     f29:	75 f5                	jne    f20 <strlen+0x10>
    ;
  return n;
}
     f2b:	89 c8                	mov    %ecx,%eax
     f2d:	5d                   	pop    %ebp
     f2e:	c3                   	ret
     f2f:	90                   	nop
  for(n = 0; s[n]; n++)
     f30:	31 c9                	xor    %ecx,%ecx
}
     f32:	5d                   	pop    %ebp
     f33:	89 c8                	mov    %ecx,%eax
     f35:	c3                   	ret
     f36:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     f3d:	00 
     f3e:	66 90                	xchg   %ax,%ax

00000f40 <memset>:

void*
memset(void *dst, int c, uint n)
{
     f40:	55                   	push   %ebp
     f41:	89 e5                	mov    %esp,%ebp
     f43:	57                   	push   %edi
     f44:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     f47:	8b 4d 10             	mov    0x10(%ebp),%ecx
     f4a:	8b 45 0c             	mov    0xc(%ebp),%eax
     f4d:	89 d7                	mov    %edx,%edi
     f4f:	fc                   	cld
     f50:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     f52:	8b 7d fc             	mov    -0x4(%ebp),%edi
     f55:	89 d0                	mov    %edx,%eax
     f57:	c9                   	leave
     f58:	c3                   	ret
     f59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000f60 <strchr>:

char*
strchr(const char *s, char c)
{
     f60:	55                   	push   %ebp
     f61:	89 e5                	mov    %esp,%ebp
     f63:	8b 45 08             	mov    0x8(%ebp),%eax
     f66:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     f6a:	0f b6 10             	movzbl (%eax),%edx
     f6d:	84 d2                	test   %dl,%dl
     f6f:	75 12                	jne    f83 <strchr+0x23>
     f71:	eb 1d                	jmp    f90 <strchr+0x30>
     f73:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
     f78:	0f b6 50 01          	movzbl 0x1(%eax),%edx
     f7c:	83 c0 01             	add    $0x1,%eax
     f7f:	84 d2                	test   %dl,%dl
     f81:	74 0d                	je     f90 <strchr+0x30>
    if(*s == c)
     f83:	38 d1                	cmp    %dl,%cl
     f85:	75 f1                	jne    f78 <strchr+0x18>
      return (char*)s;
  return 0;
}
     f87:	5d                   	pop    %ebp
     f88:	c3                   	ret
     f89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
     f90:	31 c0                	xor    %eax,%eax
}
     f92:	5d                   	pop    %ebp
     f93:	c3                   	ret
     f94:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     f9b:	00 
     f9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000fa0 <gets>:

char*
gets(char *buf, int max)
{
     fa0:	55                   	push   %ebp
     fa1:	89 e5                	mov    %esp,%ebp
     fa3:	57                   	push   %edi
     fa4:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
     fa5:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
     fa8:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
     fa9:	31 db                	xor    %ebx,%ebx
{
     fab:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
     fae:	eb 27                	jmp    fd7 <gets+0x37>
    cc = read(0, &c, 1);
     fb0:	83 ec 04             	sub    $0x4,%esp
     fb3:	6a 01                	push   $0x1
     fb5:	56                   	push   %esi
     fb6:	6a 00                	push   $0x0
     fb8:	e8 1e 01 00 00       	call   10db <read>
    if(cc < 1)
     fbd:	83 c4 10             	add    $0x10,%esp
     fc0:	85 c0                	test   %eax,%eax
     fc2:	7e 1d                	jle    fe1 <gets+0x41>
      break;
    buf[i++] = c;
     fc4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     fc8:	8b 55 08             	mov    0x8(%ebp),%edx
     fcb:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     fcf:	3c 0a                	cmp    $0xa,%al
     fd1:	74 10                	je     fe3 <gets+0x43>
     fd3:	3c 0d                	cmp    $0xd,%al
     fd5:	74 0c                	je     fe3 <gets+0x43>
  for(i=0; i+1 < max; ){
     fd7:	89 df                	mov    %ebx,%edi
     fd9:	83 c3 01             	add    $0x1,%ebx
     fdc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     fdf:	7c cf                	jl     fb0 <gets+0x10>
     fe1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
     fe3:	8b 45 08             	mov    0x8(%ebp),%eax
     fe6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
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

int
stat(const char *n, struct stat *st)
{
    1000:	55                   	push   %ebp
    1001:	89 e5                	mov    %esp,%ebp
    1003:	56                   	push   %esi
    1004:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1005:	83 ec 08             	sub    $0x8,%esp
    1008:	6a 00                	push   $0x0
    100a:	ff 75 08             	push   0x8(%ebp)
    100d:	e8 f1 00 00 00       	call   1103 <open>
  if(fd < 0)
    1012:	83 c4 10             	add    $0x10,%esp
    1015:	85 c0                	test   %eax,%eax
    1017:	78 27                	js     1040 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1019:	83 ec 08             	sub    $0x8,%esp
    101c:	ff 75 0c             	push   0xc(%ebp)
    101f:	89 c3                	mov    %eax,%ebx
    1021:	50                   	push   %eax
    1022:	e8 f4 00 00 00       	call   111b <fstat>
  close(fd);
    1027:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    102a:	89 c6                	mov    %eax,%esi
  close(fd);
    102c:	e8 ba 00 00 00       	call   10eb <close>
  return r;
    1031:	83 c4 10             	add    $0x10,%esp
}
    1034:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1037:	89 f0                	mov    %esi,%eax
    1039:	5b                   	pop    %ebx
    103a:	5e                   	pop    %esi
    103b:	5d                   	pop    %ebp
    103c:	c3                   	ret
    103d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1040:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1045:	eb ed                	jmp    1034 <stat+0x34>
    1047:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    104e:	00 
    104f:	90                   	nop

00001050 <atoi>:

int
atoi(const char *s)
{
    1050:	55                   	push   %ebp
    1051:	89 e5                	mov    %esp,%ebp
    1053:	53                   	push   %ebx
    1054:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1057:	0f be 02             	movsbl (%edx),%eax
    105a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    105d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    1060:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    1065:	77 1e                	ja     1085 <atoi+0x35>
    1067:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    106e:	00 
    106f:	90                   	nop
    n = n*10 + *s++ - '0';
    1070:	83 c2 01             	add    $0x1,%edx
    1073:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    1076:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    107a:	0f be 02             	movsbl (%edx),%eax
    107d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    1080:	80 fb 09             	cmp    $0x9,%bl
    1083:	76 eb                	jbe    1070 <atoi+0x20>
  return n;
}
    1085:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1088:	89 c8                	mov    %ecx,%eax
    108a:	c9                   	leave
    108b:	c3                   	ret
    108c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001090 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1090:	55                   	push   %ebp
    1091:	89 e5                	mov    %esp,%ebp
    1093:	57                   	push   %edi
    1094:	8b 45 10             	mov    0x10(%ebp),%eax
    1097:	8b 55 08             	mov    0x8(%ebp),%edx
    109a:	56                   	push   %esi
    109b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    109e:	85 c0                	test   %eax,%eax
    10a0:	7e 13                	jle    10b5 <memmove+0x25>
    10a2:	01 d0                	add    %edx,%eax
  dst = vdst;
    10a4:	89 d7                	mov    %edx,%edi
    10a6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    10ad:	00 
    10ae:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
    10b0:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    10b1:	39 f8                	cmp    %edi,%eax
    10b3:	75 fb                	jne    10b0 <memmove+0x20>
  return vdst;
}
    10b5:	5e                   	pop    %esi
    10b6:	89 d0                	mov    %edx,%eax
    10b8:	5f                   	pop    %edi
    10b9:	5d                   	pop    %ebp
    10ba:	c3                   	ret

000010bb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    10bb:	b8 01 00 00 00       	mov    $0x1,%eax
    10c0:	cd 40                	int    $0x40
    10c2:	c3                   	ret

000010c3 <exit>:
SYSCALL(exit)
    10c3:	b8 02 00 00 00       	mov    $0x2,%eax
    10c8:	cd 40                	int    $0x40
    10ca:	c3                   	ret

000010cb <wait>:
SYSCALL(wait)
    10cb:	b8 03 00 00 00       	mov    $0x3,%eax
    10d0:	cd 40                	int    $0x40
    10d2:	c3                   	ret

000010d3 <pipe>:
SYSCALL(pipe)
    10d3:	b8 04 00 00 00       	mov    $0x4,%eax
    10d8:	cd 40                	int    $0x40
    10da:	c3                   	ret

000010db <read>:
SYSCALL(read)
    10db:	b8 05 00 00 00       	mov    $0x5,%eax
    10e0:	cd 40                	int    $0x40
    10e2:	c3                   	ret

000010e3 <write>:
SYSCALL(write)
    10e3:	b8 10 00 00 00       	mov    $0x10,%eax
    10e8:	cd 40                	int    $0x40
    10ea:	c3                   	ret

000010eb <close>:
SYSCALL(close)
    10eb:	b8 15 00 00 00       	mov    $0x15,%eax
    10f0:	cd 40                	int    $0x40
    10f2:	c3                   	ret

000010f3 <kill>:
SYSCALL(kill)
    10f3:	b8 06 00 00 00       	mov    $0x6,%eax
    10f8:	cd 40                	int    $0x40
    10fa:	c3                   	ret

000010fb <exec>:
SYSCALL(exec)
    10fb:	b8 07 00 00 00       	mov    $0x7,%eax
    1100:	cd 40                	int    $0x40
    1102:	c3                   	ret

00001103 <open>:
SYSCALL(open)
    1103:	b8 0f 00 00 00       	mov    $0xf,%eax
    1108:	cd 40                	int    $0x40
    110a:	c3                   	ret

0000110b <mknod>:
SYSCALL(mknod)
    110b:	b8 11 00 00 00       	mov    $0x11,%eax
    1110:	cd 40                	int    $0x40
    1112:	c3                   	ret

00001113 <unlink>:
SYSCALL(unlink)
    1113:	b8 12 00 00 00       	mov    $0x12,%eax
    1118:	cd 40                	int    $0x40
    111a:	c3                   	ret

0000111b <fstat>:
SYSCALL(fstat)
    111b:	b8 08 00 00 00       	mov    $0x8,%eax
    1120:	cd 40                	int    $0x40
    1122:	c3                   	ret

00001123 <link>:
SYSCALL(link)
    1123:	b8 13 00 00 00       	mov    $0x13,%eax
    1128:	cd 40                	int    $0x40
    112a:	c3                   	ret

0000112b <mkdir>:
SYSCALL(mkdir)
    112b:	b8 14 00 00 00       	mov    $0x14,%eax
    1130:	cd 40                	int    $0x40
    1132:	c3                   	ret

00001133 <chdir>:
SYSCALL(chdir)
    1133:	b8 09 00 00 00       	mov    $0x9,%eax
    1138:	cd 40                	int    $0x40
    113a:	c3                   	ret

0000113b <dup>:
SYSCALL(dup)
    113b:	b8 0a 00 00 00       	mov    $0xa,%eax
    1140:	cd 40                	int    $0x40
    1142:	c3                   	ret

00001143 <getpid>:
SYSCALL(getpid)
    1143:	b8 0b 00 00 00       	mov    $0xb,%eax
    1148:	cd 40                	int    $0x40
    114a:	c3                   	ret

0000114b <sbrk>:
SYSCALL(sbrk)
    114b:	b8 0c 00 00 00       	mov    $0xc,%eax
    1150:	cd 40                	int    $0x40
    1152:	c3                   	ret

00001153 <sleep>:
SYSCALL(sleep)
    1153:	b8 0d 00 00 00       	mov    $0xd,%eax
    1158:	cd 40                	int    $0x40
    115a:	c3                   	ret

0000115b <uptime>:
SYSCALL(uptime)
    115b:	b8 0e 00 00 00       	mov    $0xe,%eax
    1160:	cd 40                	int    $0x40
    1162:	c3                   	ret

00001163 <make_user>:
SYSCALL(make_user)
    1163:	b8 16 00 00 00       	mov    $0x16,%eax
    1168:	cd 40                	int    $0x40
    116a:	c3                   	ret

0000116b <login>:
SYSCALL(login)
    116b:	b8 17 00 00 00       	mov    $0x17,%eax
    1170:	cd 40                	int    $0x40
    1172:	c3                   	ret

00001173 <logout>:
SYSCALL(logout)
    1173:	b8 18 00 00 00       	mov    $0x18,%eax
    1178:	cd 40                	int    $0x40
    117a:	c3                   	ret

0000117b <get_log>:
    117b:	b8 19 00 00 00       	mov    $0x19,%eax
    1180:	cd 40                	int    $0x40
    1182:	c3                   	ret
    1183:	66 90                	xchg   %ax,%ax
    1185:	66 90                	xchg   %ax,%ax
    1187:	66 90                	xchg   %ax,%ax
    1189:	66 90                	xchg   %ax,%ax
    118b:	66 90                	xchg   %ax,%ax
    118d:	66 90                	xchg   %ax,%ax
    118f:	90                   	nop

00001190 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1190:	55                   	push   %ebp
    1191:	89 e5                	mov    %esp,%ebp
    1193:	57                   	push   %edi
    1194:	56                   	push   %esi
    1195:	53                   	push   %ebx
    1196:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    1198:	89 d1                	mov    %edx,%ecx
{
    119a:	83 ec 3c             	sub    $0x3c,%esp
    119d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
    11a0:	85 d2                	test   %edx,%edx
    11a2:	0f 89 80 00 00 00    	jns    1228 <printint+0x98>
    11a8:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    11ac:	74 7a                	je     1228 <printint+0x98>
    x = -xx;
    11ae:	f7 d9                	neg    %ecx
    neg = 1;
    11b0:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
    11b5:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    11b8:	31 f6                	xor    %esi,%esi
    11ba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    11c0:	89 c8                	mov    %ecx,%eax
    11c2:	31 d2                	xor    %edx,%edx
    11c4:	89 f7                	mov    %esi,%edi
    11c6:	f7 f3                	div    %ebx
    11c8:	8d 76 01             	lea    0x1(%esi),%esi
    11cb:	0f b6 92 d4 16 00 00 	movzbl 0x16d4(%edx),%edx
    11d2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
    11d6:	89 ca                	mov    %ecx,%edx
    11d8:	89 c1                	mov    %eax,%ecx
    11da:	39 da                	cmp    %ebx,%edx
    11dc:	73 e2                	jae    11c0 <printint+0x30>
  if(neg)
    11de:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    11e1:	85 c0                	test   %eax,%eax
    11e3:	74 07                	je     11ec <printint+0x5c>
    buf[i++] = '-';
    11e5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
    11ea:	89 f7                	mov    %esi,%edi
    11ec:	8d 5d d8             	lea    -0x28(%ebp),%ebx
    11ef:	8b 75 c0             	mov    -0x40(%ebp),%esi
    11f2:	01 df                	add    %ebx,%edi
    11f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
    11f8:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
    11fb:	83 ec 04             	sub    $0x4,%esp
    11fe:	88 45 d7             	mov    %al,-0x29(%ebp)
    1201:	8d 45 d7             	lea    -0x29(%ebp),%eax
    1204:	6a 01                	push   $0x1
    1206:	50                   	push   %eax
    1207:	56                   	push   %esi
    1208:	e8 d6 fe ff ff       	call   10e3 <write>
  while(--i >= 0)
    120d:	89 f8                	mov    %edi,%eax
    120f:	83 c4 10             	add    $0x10,%esp
    1212:	83 ef 01             	sub    $0x1,%edi
    1215:	39 c3                	cmp    %eax,%ebx
    1217:	75 df                	jne    11f8 <printint+0x68>
}
    1219:	8d 65 f4             	lea    -0xc(%ebp),%esp
    121c:	5b                   	pop    %ebx
    121d:	5e                   	pop    %esi
    121e:	5f                   	pop    %edi
    121f:	5d                   	pop    %ebp
    1220:	c3                   	ret
    1221:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1228:	31 c0                	xor    %eax,%eax
    122a:	eb 89                	jmp    11b5 <printint+0x25>
    122c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001230 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1230:	55                   	push   %ebp
    1231:	89 e5                	mov    %esp,%ebp
    1233:	57                   	push   %edi
    1234:	56                   	push   %esi
    1235:	53                   	push   %ebx
    1236:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1239:	8b 75 0c             	mov    0xc(%ebp),%esi
{
    123c:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
    123f:	0f b6 1e             	movzbl (%esi),%ebx
    1242:	83 c6 01             	add    $0x1,%esi
    1245:	84 db                	test   %bl,%bl
    1247:	74 67                	je     12b0 <printf+0x80>
    1249:	8d 4d 10             	lea    0x10(%ebp),%ecx
    124c:	31 d2                	xor    %edx,%edx
    124e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
    1251:	eb 34                	jmp    1287 <printf+0x57>
    1253:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    1258:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    125b:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    1260:	83 f8 25             	cmp    $0x25,%eax
    1263:	74 18                	je     127d <printf+0x4d>
  write(fd, &c, 1);
    1265:	83 ec 04             	sub    $0x4,%esp
    1268:	8d 45 e7             	lea    -0x19(%ebp),%eax
    126b:	88 5d e7             	mov    %bl,-0x19(%ebp)
    126e:	6a 01                	push   $0x1
    1270:	50                   	push   %eax
    1271:	57                   	push   %edi
    1272:	e8 6c fe ff ff       	call   10e3 <write>
    1277:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    127a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    127d:	0f b6 1e             	movzbl (%esi),%ebx
    1280:	83 c6 01             	add    $0x1,%esi
    1283:	84 db                	test   %bl,%bl
    1285:	74 29                	je     12b0 <printf+0x80>
    c = fmt[i] & 0xff;
    1287:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    128a:	85 d2                	test   %edx,%edx
    128c:	74 ca                	je     1258 <printf+0x28>
      }
    } else if(state == '%'){
    128e:	83 fa 25             	cmp    $0x25,%edx
    1291:	75 ea                	jne    127d <printf+0x4d>
      if(c == 'd'){
    1293:	83 f8 25             	cmp    $0x25,%eax
    1296:	0f 84 04 01 00 00    	je     13a0 <printf+0x170>
    129c:	83 e8 63             	sub    $0x63,%eax
    129f:	83 f8 15             	cmp    $0x15,%eax
    12a2:	77 1c                	ja     12c0 <printf+0x90>
    12a4:	ff 24 85 7c 16 00 00 	jmp    *0x167c(,%eax,4)
    12ab:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    12b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12b3:	5b                   	pop    %ebx
    12b4:	5e                   	pop    %esi
    12b5:	5f                   	pop    %edi
    12b6:	5d                   	pop    %ebp
    12b7:	c3                   	ret
    12b8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    12bf:	00 
  write(fd, &c, 1);
    12c0:	83 ec 04             	sub    $0x4,%esp
    12c3:	8d 55 e7             	lea    -0x19(%ebp),%edx
    12c6:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    12ca:	6a 01                	push   $0x1
    12cc:	52                   	push   %edx
    12cd:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    12d0:	57                   	push   %edi
    12d1:	e8 0d fe ff ff       	call   10e3 <write>
    12d6:	83 c4 0c             	add    $0xc,%esp
    12d9:	88 5d e7             	mov    %bl,-0x19(%ebp)
    12dc:	6a 01                	push   $0x1
    12de:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    12e1:	52                   	push   %edx
    12e2:	57                   	push   %edi
    12e3:	e8 fb fd ff ff       	call   10e3 <write>
        putc(fd, c);
    12e8:	83 c4 10             	add    $0x10,%esp
      state = 0;
    12eb:	31 d2                	xor    %edx,%edx
    12ed:	eb 8e                	jmp    127d <printf+0x4d>
    12ef:	90                   	nop
        printint(fd, *ap, 16, 0);
    12f0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    12f3:	83 ec 0c             	sub    $0xc,%esp
    12f6:	b9 10 00 00 00       	mov    $0x10,%ecx
    12fb:	8b 13                	mov    (%ebx),%edx
    12fd:	6a 00                	push   $0x0
    12ff:	89 f8                	mov    %edi,%eax
        ap++;
    1301:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
    1304:	e8 87 fe ff ff       	call   1190 <printint>
        ap++;
    1309:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    130c:	83 c4 10             	add    $0x10,%esp
      state = 0;
    130f:	31 d2                	xor    %edx,%edx
    1311:	e9 67 ff ff ff       	jmp    127d <printf+0x4d>
        s = (char*)*ap;
    1316:	8b 45 d0             	mov    -0x30(%ebp),%eax
    1319:	8b 18                	mov    (%eax),%ebx
        ap++;
    131b:	83 c0 04             	add    $0x4,%eax
    131e:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    1321:	85 db                	test   %ebx,%ebx
    1323:	0f 84 87 00 00 00    	je     13b0 <printf+0x180>
        while(*s != 0){
    1329:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    132c:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    132e:	84 c0                	test   %al,%al
    1330:	0f 84 47 ff ff ff    	je     127d <printf+0x4d>
    1336:	8d 55 e7             	lea    -0x19(%ebp),%edx
    1339:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    133c:	89 de                	mov    %ebx,%esi
    133e:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
    1340:	83 ec 04             	sub    $0x4,%esp
    1343:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
    1346:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    1349:	6a 01                	push   $0x1
    134b:	53                   	push   %ebx
    134c:	57                   	push   %edi
    134d:	e8 91 fd ff ff       	call   10e3 <write>
        while(*s != 0){
    1352:	0f b6 06             	movzbl (%esi),%eax
    1355:	83 c4 10             	add    $0x10,%esp
    1358:	84 c0                	test   %al,%al
    135a:	75 e4                	jne    1340 <printf+0x110>
      state = 0;
    135c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    135f:	31 d2                	xor    %edx,%edx
    1361:	e9 17 ff ff ff       	jmp    127d <printf+0x4d>
        printint(fd, *ap, 10, 1);
    1366:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    1369:	83 ec 0c             	sub    $0xc,%esp
    136c:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1371:	8b 13                	mov    (%ebx),%edx
    1373:	6a 01                	push   $0x1
    1375:	eb 88                	jmp    12ff <printf+0xcf>
        putc(fd, *ap);
    1377:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    137a:	83 ec 04             	sub    $0x4,%esp
    137d:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
    1380:	8b 03                	mov    (%ebx),%eax
        ap++;
    1382:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
    1385:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1388:	6a 01                	push   $0x1
    138a:	52                   	push   %edx
    138b:	57                   	push   %edi
    138c:	e8 52 fd ff ff       	call   10e3 <write>
        ap++;
    1391:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    1394:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1397:	31 d2                	xor    %edx,%edx
    1399:	e9 df fe ff ff       	jmp    127d <printf+0x4d>
    139e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
    13a0:	83 ec 04             	sub    $0x4,%esp
    13a3:	88 5d e7             	mov    %bl,-0x19(%ebp)
    13a6:	8d 55 e7             	lea    -0x19(%ebp),%edx
    13a9:	6a 01                	push   $0x1
    13ab:	e9 31 ff ff ff       	jmp    12e1 <printf+0xb1>
    13b0:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
    13b5:	bb 3e 16 00 00       	mov    $0x163e,%ebx
    13ba:	e9 77 ff ff ff       	jmp    1336 <printf+0x106>
    13bf:	90                   	nop

000013c0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    13c0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    13c1:	a1 44 1e 00 00       	mov    0x1e44,%eax
{
    13c6:	89 e5                	mov    %esp,%ebp
    13c8:	57                   	push   %edi
    13c9:	56                   	push   %esi
    13ca:	53                   	push   %ebx
    13cb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    13ce:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    13d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    13d8:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    13da:	39 c8                	cmp    %ecx,%eax
    13dc:	73 32                	jae    1410 <free+0x50>
    13de:	39 d1                	cmp    %edx,%ecx
    13e0:	72 04                	jb     13e6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    13e2:	39 d0                	cmp    %edx,%eax
    13e4:	72 32                	jb     1418 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    13e6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    13e9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    13ec:	39 fa                	cmp    %edi,%edx
    13ee:	74 30                	je     1420 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    13f0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    13f3:	8b 50 04             	mov    0x4(%eax),%edx
    13f6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    13f9:	39 f1                	cmp    %esi,%ecx
    13fb:	74 3a                	je     1437 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    13fd:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    13ff:	5b                   	pop    %ebx
  freep = p;
    1400:	a3 44 1e 00 00       	mov    %eax,0x1e44
}
    1405:	5e                   	pop    %esi
    1406:	5f                   	pop    %edi
    1407:	5d                   	pop    %ebp
    1408:	c3                   	ret
    1409:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1410:	39 d0                	cmp    %edx,%eax
    1412:	72 04                	jb     1418 <free+0x58>
    1414:	39 d1                	cmp    %edx,%ecx
    1416:	72 ce                	jb     13e6 <free+0x26>
{
    1418:	89 d0                	mov    %edx,%eax
    141a:	eb bc                	jmp    13d8 <free+0x18>
    141c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1420:	03 72 04             	add    0x4(%edx),%esi
    1423:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1426:	8b 10                	mov    (%eax),%edx
    1428:	8b 12                	mov    (%edx),%edx
    142a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    142d:	8b 50 04             	mov    0x4(%eax),%edx
    1430:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1433:	39 f1                	cmp    %esi,%ecx
    1435:	75 c6                	jne    13fd <free+0x3d>
    p->s.size += bp->s.size;
    1437:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    143a:	a3 44 1e 00 00       	mov    %eax,0x1e44
    p->s.size += bp->s.size;
    143f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1442:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    1445:	89 08                	mov    %ecx,(%eax)
}
    1447:	5b                   	pop    %ebx
    1448:	5e                   	pop    %esi
    1449:	5f                   	pop    %edi
    144a:	5d                   	pop    %ebp
    144b:	c3                   	ret
    144c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001450 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1450:	55                   	push   %ebp
    1451:	89 e5                	mov    %esp,%ebp
    1453:	57                   	push   %edi
    1454:	56                   	push   %esi
    1455:	53                   	push   %ebx
    1456:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1459:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    145c:	8b 15 44 1e 00 00    	mov    0x1e44,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1462:	8d 78 07             	lea    0x7(%eax),%edi
    1465:	c1 ef 03             	shr    $0x3,%edi
    1468:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    146b:	85 d2                	test   %edx,%edx
    146d:	0f 84 8d 00 00 00    	je     1500 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1473:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1475:	8b 48 04             	mov    0x4(%eax),%ecx
    1478:	39 f9                	cmp    %edi,%ecx
    147a:	73 64                	jae    14e0 <malloc+0x90>
  if(nu < 4096)
    147c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1481:	39 df                	cmp    %ebx,%edi
    1483:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    1486:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    148d:	eb 0a                	jmp    1499 <malloc+0x49>
    148f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1490:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1492:	8b 48 04             	mov    0x4(%eax),%ecx
    1495:	39 f9                	cmp    %edi,%ecx
    1497:	73 47                	jae    14e0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1499:	89 c2                	mov    %eax,%edx
    149b:	3b 05 44 1e 00 00    	cmp    0x1e44,%eax
    14a1:	75 ed                	jne    1490 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
    14a3:	83 ec 0c             	sub    $0xc,%esp
    14a6:	56                   	push   %esi
    14a7:	e8 9f fc ff ff       	call   114b <sbrk>
  if(p == (char*)-1)
    14ac:	83 c4 10             	add    $0x10,%esp
    14af:	83 f8 ff             	cmp    $0xffffffff,%eax
    14b2:	74 1c                	je     14d0 <malloc+0x80>
  hp->s.size = nu;
    14b4:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    14b7:	83 ec 0c             	sub    $0xc,%esp
    14ba:	83 c0 08             	add    $0x8,%eax
    14bd:	50                   	push   %eax
    14be:	e8 fd fe ff ff       	call   13c0 <free>
  return freep;
    14c3:	8b 15 44 1e 00 00    	mov    0x1e44,%edx
      if((p = morecore(nunits)) == 0)
    14c9:	83 c4 10             	add    $0x10,%esp
    14cc:	85 d2                	test   %edx,%edx
    14ce:	75 c0                	jne    1490 <malloc+0x40>
        return 0;
  }
}
    14d0:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    14d3:	31 c0                	xor    %eax,%eax
}
    14d5:	5b                   	pop    %ebx
    14d6:	5e                   	pop    %esi
    14d7:	5f                   	pop    %edi
    14d8:	5d                   	pop    %ebp
    14d9:	c3                   	ret
    14da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    14e0:	39 cf                	cmp    %ecx,%edi
    14e2:	74 4c                	je     1530 <malloc+0xe0>
        p->s.size -= nunits;
    14e4:	29 f9                	sub    %edi,%ecx
    14e6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    14e9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    14ec:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    14ef:	89 15 44 1e 00 00    	mov    %edx,0x1e44
}
    14f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    14f8:	83 c0 08             	add    $0x8,%eax
}
    14fb:	5b                   	pop    %ebx
    14fc:	5e                   	pop    %esi
    14fd:	5f                   	pop    %edi
    14fe:	5d                   	pop    %ebp
    14ff:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
    1500:	c7 05 44 1e 00 00 48 	movl   $0x1e48,0x1e44
    1507:	1e 00 00 
    base.s.size = 0;
    150a:	b8 48 1e 00 00       	mov    $0x1e48,%eax
    base.s.ptr = freep = prevp = &base;
    150f:	c7 05 48 1e 00 00 48 	movl   $0x1e48,0x1e48
    1516:	1e 00 00 
    base.s.size = 0;
    1519:	c7 05 4c 1e 00 00 00 	movl   $0x0,0x1e4c
    1520:	00 00 00 
    if(p->s.size >= nunits){
    1523:	e9 54 ff ff ff       	jmp    147c <malloc+0x2c>
    1528:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    152f:	00 
        prevp->s.ptr = p->s.ptr;
    1530:	8b 08                	mov    (%eax),%ecx
    1532:	89 0a                	mov    %ecx,(%edx)
    1534:	eb b9                	jmp    14ef <malloc+0x9f>
