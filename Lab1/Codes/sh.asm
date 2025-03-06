
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
      1b:	0f 8f 57 01 00 00    	jg     178 <main+0x178>
  while((fd = open("console", O_RDWR)) >= 0){
      21:	83 ec 08             	sub    $0x8,%esp
      24:	6a 02                	push   $0x2
      26:	68 c6 15 00 00       	push   $0x15c6
      2b:	e8 b3 10 00 00       	call   10e3 <open>
      30:	83 c4 10             	add    $0x10,%esp
      33:	85 c0                	test   %eax,%eax
      35:	79 e1                	jns    18 <main+0x18>
      37:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
      3e:	00 
      3f:	90                   	nop
  printf(1, "majid-sadeghinejad|parsa-ahmadi|aria-azem $ ");
      40:	83 ec 08             	sub    $0x8,%esp
      43:	68 f8 14 00 00       	push   $0x14f8
      48:	6a 01                	push   $0x1
      4a:	e8 a1 11 00 00       	call   11f0 <printf>
  memset(buf, 0, nbuf);
      4f:	83 c4 0c             	add    $0xc,%esp
      52:	6a 64                	push   $0x64
      54:	6a 00                	push   $0x0
      56:	68 20 1d 00 00       	push   $0x1d20
      5b:	e8 c0 0e 00 00       	call   f20 <memset>
  gets(buf, nbuf);
      60:	58                   	pop    %eax
      61:	5a                   	pop    %edx
      62:	6a 64                	push   $0x64
      64:	68 20 1d 00 00       	push   $0x1d20
      69:	e8 12 0f 00 00       	call   f80 <gets>
  if(buf[0] == 0) // EOF
      6e:	0f b6 05 20 1d 00 00 	movzbl 0x1d20,%eax
      75:	83 c4 10             	add    $0x10,%esp
      78:	84 c0                	test   %al,%al
      7a:	0f 84 f3 00 00 00    	je     173 <main+0x173>
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
      88:	e8 0e 10 00 00       	call   109b <fork>
  if(pid == -1)
      8d:	83 f8 ff             	cmp    $0xffffffff,%eax
      90:	0f 84 08 01 00 00    	je     19e <main+0x19e>
    if(fork1() == 0)
      96:	85 c0                	test   %eax,%eax
      98:	0f 84 eb 00 00 00    	je     189 <main+0x189>
    wait();
      9e:	e8 08 10 00 00       	call   10ab <wait>
      a3:	eb 9b                	jmp    40 <main+0x40>
      a5:	8d 76 00             	lea    0x0(%esi),%esi
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      a8:	80 3d 21 1d 00 00 64 	cmpb   $0x64,0x1d21
      af:	75 d7                	jne    88 <main+0x88>
      b1:	80 3d 22 1d 00 00 20 	cmpb   $0x20,0x1d22
      b8:	75 ce                	jne    88 <main+0x88>
      buf[strlen(buf)-1] = 0;  // chop \n
      ba:	83 ec 0c             	sub    $0xc,%esp
      bd:	68 20 1d 00 00       	push   $0x1d20
      c2:	e8 29 0e 00 00       	call   ef0 <strlen>
      if(chdir(buf+3) < 0)
      c7:	c7 04 24 23 1d 00 00 	movl   $0x1d23,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      ce:	c6 80 1f 1d 00 00 00 	movb   $0x0,0x1d1f(%eax)
      if(chdir(buf+3) < 0)
      d5:	e8 39 10 00 00       	call   1113 <chdir>
      da:	83 c4 10             	add    $0x10,%esp
      dd:	85 c0                	test   %eax,%eax
      df:	0f 89 5b ff ff ff    	jns    40 <main+0x40>
        printf(2, "cannot cd %s\n", buf+3);
      e5:	50                   	push   %eax
      e6:	68 23 1d 00 00       	push   $0x1d23
      eb:	68 ce 15 00 00       	push   $0x15ce
      f0:	6a 02                	push   $0x2
      f2:	e8 f9 10 00 00       	call   11f0 <printf>
      f7:	83 c4 10             	add    $0x10,%esp
      fa:	e9 41 ff ff ff       	jmp    40 <main+0x40>
      ff:	90                   	nop
  while (buf[i] != '\n') {
     100:	0f b6 05 21 1d 00 00 	movzbl 0x1d21,%eax
  int i = 1, j = 0;
     107:	31 db                	xor    %ebx,%ebx
     109:	ba 01 00 00 00       	mov    $0x1,%edx
  int in_hash_block = 0;
     10e:	31 c9                	xor    %ecx,%ecx
  while (buf[i] != '\n') {
     110:	3c 0a                	cmp    $0xa,%al
     112:	75 24                	jne    138 <main+0x138>
     114:	eb 3a                	jmp    150 <main+0x150>
     116:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     11d:	00 
     11e:	66 90                	xchg   %ax,%ax
    if (!in_hash_block)
     120:	85 c9                	test   %ecx,%ecx
     122:	75 09                	jne    12d <main+0x12d>
      cleaned_input[j++] = buf[i];
     124:	88 83 a0 1d 00 00    	mov    %al,0x1da0(%ebx)
     12a:	83 c3 01             	add    $0x1,%ebx
  while (buf[i] != '\n') {
     12d:	0f b6 82 20 1d 00 00 	movzbl 0x1d20(%edx),%eax
     134:	3c 0a                	cmp    $0xa,%al
     136:	74 18                	je     150 <main+0x150>
      i++;
     138:	83 c2 01             	add    $0x1,%edx
    if (buf[i] == '#') {
     13b:	3c 23                	cmp    $0x23,%al
     13d:	75 e1                	jne    120 <main+0x120>
  while (buf[i] != '\n') {
     13f:	0f b6 82 20 1d 00 00 	movzbl 0x1d20(%edx),%eax
     146:	83 f1 01             	xor    $0x1,%ecx
     149:	3c 0a                	cmp    $0xa,%al
     14b:	75 eb                	jne    138 <main+0x138>
     14d:	8d 76 00             	lea    0x0(%esi),%esi
      print_special(process_input(buf));
     150:	83 ec 0c             	sub    $0xc,%esp
     153:	68 a0 1d 00 00       	push   $0x1da0
     158:	e8 43 01 00 00       	call   2a0 <print_special>
      printf(1,"\n");
     15d:	59                   	pop    %ecx
     15e:	5b                   	pop    %ebx
     15f:	68 42 15 00 00       	push   $0x1542
     164:	6a 01                	push   $0x1
     166:	e8 85 10 00 00       	call   11f0 <printf>
      continue;
     16b:	83 c4 10             	add    $0x10,%esp
     16e:	e9 cd fe ff ff       	jmp    40 <main+0x40>
  exit();
     173:	e8 2b 0f 00 00       	call   10a3 <exit>
      close(fd);
     178:	83 ec 0c             	sub    $0xc,%esp
     17b:	50                   	push   %eax
     17c:	e8 4a 0f 00 00       	call   10cb <close>
      break;
     181:	83 c4 10             	add    $0x10,%esp
     184:	e9 b7 fe ff ff       	jmp    40 <main+0x40>
      runcmd(parsecmd(buf));
     189:	83 ec 0c             	sub    $0xc,%esp
     18c:	68 20 1d 00 00       	push   $0x1d20
     191:	e8 5a 0c 00 00       	call   df0 <parsecmd>
     196:	89 04 24             	mov    %eax,(%esp)
     199:	e8 a2 02 00 00       	call   440 <runcmd>
    panic("fork");
     19e:	83 ec 0c             	sub    $0xc,%esp
     1a1:	68 28 15 00 00       	push   $0x1528
     1a6:	e8 55 02 00 00       	call   400 <panic>
     1ab:	66 90                	xchg   %ax,%ax
     1ad:	66 90                	xchg   %ax,%ax
     1af:	90                   	nop

000001b0 <getcmd>:
{
     1b0:	55                   	push   %ebp
     1b1:	89 e5                	mov    %esp,%ebp
     1b3:	56                   	push   %esi
     1b4:	53                   	push   %ebx
     1b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
     1b8:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(1, "majid-sadeghinejad|parsa-ahmadi|aria-azem $ ");
     1bb:	83 ec 08             	sub    $0x8,%esp
     1be:	68 f8 14 00 00       	push   $0x14f8
     1c3:	6a 01                	push   $0x1
     1c5:	e8 26 10 00 00       	call   11f0 <printf>
  memset(buf, 0, nbuf);
     1ca:	83 c4 0c             	add    $0xc,%esp
     1cd:	56                   	push   %esi
     1ce:	6a 00                	push   $0x0
     1d0:	53                   	push   %ebx
     1d1:	e8 4a 0d 00 00       	call   f20 <memset>
  gets(buf, nbuf);
     1d6:	58                   	pop    %eax
     1d7:	5a                   	pop    %edx
     1d8:	56                   	push   %esi
     1d9:	53                   	push   %ebx
     1da:	e8 a1 0d 00 00       	call   f80 <gets>
  if(buf[0] == 0) // EOF
     1df:	83 c4 10             	add    $0x10,%esp
     1e2:	80 3b 01             	cmpb   $0x1,(%ebx)
     1e5:	19 c0                	sbb    %eax,%eax
}
     1e7:	8d 65 f8             	lea    -0x8(%ebp),%esp
     1ea:	5b                   	pop    %ebx
     1eb:	5e                   	pop    %esi
     1ec:	5d                   	pop    %ebp
     1ed:	c3                   	ret
     1ee:	66 90                	xchg   %ax,%ax

000001f0 <process_input>:
char* process_input(char* buf) {
     1f0:	55                   	push   %ebp
     1f1:	89 e5                	mov    %esp,%ebp
     1f3:	53                   	push   %ebx
     1f4:	8b 55 08             	mov    0x8(%ebp),%edx
  while (buf[i] != '\n') {
     1f7:	0f b6 42 01          	movzbl 0x1(%edx),%eax
     1fb:	83 c2 02             	add    $0x2,%edx
     1fe:	3c 0a                	cmp    $0xa,%al
     200:	74 36                	je     238 <process_input+0x48>
     202:	31 c9                	xor    %ecx,%ecx
     204:	31 db                	xor    %ebx,%ebx
     206:	eb 1f                	jmp    227 <process_input+0x37>
     208:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     20f:	00 
    if (!in_hash_block)
     210:	85 c9                	test   %ecx,%ecx
     212:	75 09                	jne    21d <process_input+0x2d>
      cleaned_input[j++] = buf[i];
     214:	88 83 a0 1d 00 00    	mov    %al,0x1da0(%ebx)
     21a:	83 c3 01             	add    $0x1,%ebx
  while (buf[i] != '\n') {
     21d:	0f b6 02             	movzbl (%edx),%eax
     220:	83 c2 01             	add    $0x1,%edx
     223:	3c 0a                	cmp    $0xa,%al
     225:	74 11                	je     238 <process_input+0x48>
    if (buf[i] == '#') {
     227:	3c 23                	cmp    $0x23,%al
     229:	75 e5                	jne    210 <process_input+0x20>
  while (buf[i] != '\n') {
     22b:	0f b6 02             	movzbl (%edx),%eax
     22e:	83 c2 01             	add    $0x1,%edx
     231:	83 f1 01             	xor    $0x1,%ecx
     234:	3c 0a                	cmp    $0xa,%al
     236:	75 ef                	jne    227 <process_input+0x37>
}
     238:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     23b:	b8 a0 1d 00 00       	mov    $0x1da0,%eax
     240:	c9                   	leave
     241:	c3                   	ret
     242:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     249:	00 
     24a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000250 <color_print>:
void color_print(char* text){
     250:	55                   	push   %ebp
  temp[0] = '\5';
     251:	b8 05 00 00 00       	mov    $0x5,%eax
void color_print(char* text){
     256:	89 e5                	mov    %esp,%ebp
     258:	53                   	push   %ebx
  printf(1, "%s", temp);
     259:	8d 5d f6             	lea    -0xa(%ebp),%ebx
void color_print(char* text){
     25c:	83 ec 18             	sub    $0x18,%esp
  temp[0] = '\5';
     25f:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  printf(1, "%s", temp);
     263:	53                   	push   %ebx
     264:	68 25 15 00 00       	push   $0x1525
     269:	6a 01                	push   $0x1
     26b:	e8 80 0f 00 00       	call   11f0 <printf>
  printf(1,"%s",text);
     270:	83 c4 0c             	add    $0xc,%esp
     273:	ff 75 08             	push   0x8(%ebp)
     276:	68 25 15 00 00       	push   $0x1525
     27b:	6a 01                	push   $0x1
     27d:	e8 6e 0f 00 00       	call   11f0 <printf>
  printf(1,"%s",temp);
     282:	83 c4 0c             	add    $0xc,%esp
     285:	53                   	push   %ebx
     286:	68 25 15 00 00       	push   $0x1525
     28b:	6a 01                	push   $0x1
     28d:	e8 5e 0f 00 00       	call   11f0 <printf>
}
     292:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     295:	83 c4 10             	add    $0x10,%esp
     298:	c9                   	leave
     299:	c3                   	ret
     29a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

000002a0 <print_special>:
void print_special(char* cleaned_string) {
     2a0:	55                   	push   %ebp
     2a1:	89 e5                	mov    %esp,%ebp
     2a3:	57                   	push   %edi
     2a4:	56                   	push   %esi
     2a5:	53                   	push   %ebx
     2a6:	81 ec 8c 00 00 00    	sub    $0x8c,%esp
  for (int i=0 ; i < strlen(cleaned_string) ; i++) {
     2ac:	c7 85 74 ff ff ff 00 	movl   $0x0,-0x8c(%ebp)
     2b3:	00 00 00 
     2b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     2bd:	00 
     2be:	66 90                	xchg   %ax,%ax
     2c0:	83 ec 0c             	sub    $0xc,%esp
     2c3:	ff 75 08             	push   0x8(%ebp)
     2c6:	e8 25 0c 00 00       	call   ef0 <strlen>
     2cb:	83 c4 10             	add    $0x10,%esp
     2ce:	39 85 74 ff ff ff    	cmp    %eax,-0x8c(%ebp)
     2d4:	0f 83 16 01 00 00    	jae    3f0 <print_special+0x150>
    if ((cleaned_string[i] >= 'a' && cleaned_string[i] <= 'z') || (cleaned_string[i] >= 'A' && cleaned_string[i] <= 'Z') || cleaned_string[i] == '_') {
     2da:	8b bd 74 ff ff ff    	mov    -0x8c(%ebp),%edi
     2e0:	03 7d 08             	add    0x8(%ebp),%edi
     2e3:	0f b6 17             	movzbl (%edi),%edx
     2e6:	89 d0                	mov    %edx,%eax
     2e8:	83 e0 df             	and    $0xffffffdf,%eax
     2eb:	83 e8 41             	sub    $0x41,%eax
     2ee:	3c 19                	cmp    $0x19,%al
     2f0:	76 2e                	jbe    320 <print_special+0x80>
     2f2:	80 fa 5f             	cmp    $0x5f,%dl
     2f5:	74 29                	je     320 <print_special+0x80>
      printf(1,"%s", temp);
     2f7:	83 ec 04             	sub    $0x4,%esp
     2fa:	8d 45 82             	lea    -0x7e(%ebp),%eax
  for (int i=0 ; i < strlen(cleaned_string) ; i++) {
     2fd:	83 85 74 ff ff ff 01 	addl   $0x1,-0x8c(%ebp)
      temp[0] = cleaned_string[i];
     304:	88 55 82             	mov    %dl,-0x7e(%ebp)
      temp[1] = '\0';
     307:	c6 45 83 00          	movb   $0x0,-0x7d(%ebp)
      printf(1,"%s", temp);
     30b:	50                   	push   %eax
     30c:	68 25 15 00 00       	push   $0x1525
     311:	6a 01                	push   $0x1
     313:	e8 d8 0e 00 00       	call   11f0 <printf>
     318:	83 c4 10             	add    $0x10,%esp
  for (int i=0 ; i < strlen(cleaned_string) ; i++) {
     31b:	eb a3                	jmp    2c0 <print_special+0x20>
     31d:	8d 76 00             	lea    0x0(%esi),%esi
     320:	31 c9                	xor    %ecx,%ecx
     322:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        temp_word[j++] = cleaned_string[i++];
     328:	89 ce                	mov    %ecx,%esi
     32a:	8d 49 01             	lea    0x1(%ecx),%ecx
     32d:	88 54 0d 83          	mov    %dl,-0x7d(%ebp,%ecx,1)
      while ((cleaned_string[i] >= 'a' && cleaned_string[i] <= 'z') || (cleaned_string[i] >= 'A' && cleaned_string[i] <= 'Z') || cleaned_string[i] == '_') {
     331:	0f b6 54 37 01       	movzbl 0x1(%edi,%esi,1),%edx
     336:	89 d0                	mov    %edx,%eax
     338:	83 e0 df             	and    $0xffffffdf,%eax
     33b:	83 e8 41             	sub    $0x41,%eax
     33e:	3c 19                	cmp    $0x19,%al
     340:	76 e6                	jbe    328 <print_special+0x88>
     342:	80 fa 5f             	cmp    $0x5f,%dl
     345:	74 e1                	je     328 <print_special+0x88>
      temp_word[j] = '\0';
     347:	c6 44 0d 84 00       	movb   $0x0,-0x7c(%ebp,%ecx,1)
      for (int k = 0; k < NUM_KEYWORDS; k++) {
     34c:	31 db                	xor    %ebx,%ebx
     34e:	8d 7d 84             	lea    -0x7c(%ebp),%edi
     351:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        if (strcmp(temp_word, keywords[k]) == 0) {
     358:	83 ec 08             	sub    $0x8,%esp
     35b:	ff 34 9d e0 1c 00 00 	push   0x1ce0(,%ebx,4)
     362:	57                   	push   %edi
     363:	e8 28 0b 00 00       	call   e90 <strcmp>
     368:	83 c4 10             	add    $0x10,%esp
     36b:	85 c0                	test   %eax,%eax
     36d:	74 31                	je     3a0 <print_special+0x100>
      for (int k = 0; k < NUM_KEYWORDS; k++) {
     36f:	83 c3 01             	add    $0x1,%ebx
     372:	83 fb 07             	cmp    $0x7,%ebx
     375:	75 e1                	jne    358 <print_special+0xb8>
        printf(1,"%s",temp_word);
     377:	83 ec 04             	sub    $0x4,%esp
  printf(1,"%s",temp);
     37a:	57                   	push   %edi
     37b:	68 25 15 00 00       	push   $0x1525
     380:	6a 01                	push   $0x1
     382:	e8 69 0e 00 00       	call   11f0 <printf>
        temp_word[j++] = cleaned_string[i++];
     387:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
}
     38d:	83 c4 10             	add    $0x10,%esp
        temp_word[j++] = cleaned_string[i++];
     390:	8d 44 06 01          	lea    0x1(%esi,%eax,1),%eax
     394:	89 85 74 ff ff ff    	mov    %eax,-0x8c(%ebp)
     39a:	e9 21 ff ff ff       	jmp    2c0 <print_special+0x20>
     39f:	90                   	nop
          color_print(keywords[k]);
     3a0:	8b 04 9d e0 1c 00 00 	mov    0x1ce0(,%ebx,4),%eax
  printf(1, "%s", temp);
     3a7:	83 ec 04             	sub    $0x4,%esp
     3aa:	8d 7d 82             	lea    -0x7e(%ebp),%edi
          color_print(keywords[k]);
     3ad:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
  temp[0] = '\5';
     3b3:	0f b7 05 38 16 00 00 	movzwl 0x1638,%eax
     3ba:	66 89 45 82          	mov    %ax,-0x7e(%ebp)
  printf(1, "%s", temp);
     3be:	57                   	push   %edi
     3bf:	68 25 15 00 00       	push   $0x1525
     3c4:	6a 01                	push   $0x1
     3c6:	e8 25 0e 00 00       	call   11f0 <printf>
  printf(1,"%s",text);
     3cb:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
     3d1:	83 c4 0c             	add    $0xc,%esp
     3d4:	50                   	push   %eax
     3d5:	68 25 15 00 00       	push   $0x1525
     3da:	6a 01                	push   $0x1
     3dc:	e8 0f 0e 00 00       	call   11f0 <printf>
  printf(1,"%s",temp);
     3e1:	83 c4 0c             	add    $0xc,%esp
     3e4:	eb 94                	jmp    37a <print_special+0xda>
     3e6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     3ed:	00 
     3ee:	66 90                	xchg   %ax,%ax
}
     3f0:	8d 65 f4             	lea    -0xc(%ebp),%esp
     3f3:	5b                   	pop    %ebx
     3f4:	5e                   	pop    %esi
     3f5:	5f                   	pop    %edi
     3f6:	5d                   	pop    %ebp
     3f7:	c3                   	ret
     3f8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     3ff:	00 

00000400 <panic>:
{
     400:	55                   	push   %ebp
     401:	89 e5                	mov    %esp,%ebp
     403:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     406:	ff 75 08             	push   0x8(%ebp)
     409:	68 c2 15 00 00       	push   $0x15c2
     40e:	6a 02                	push   $0x2
     410:	e8 db 0d 00 00       	call   11f0 <printf>
  exit();
     415:	e8 89 0c 00 00       	call   10a3 <exit>
     41a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000420 <fork1>:
{
     420:	55                   	push   %ebp
     421:	89 e5                	mov    %esp,%ebp
     423:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     426:	e8 70 0c 00 00       	call   109b <fork>
  if(pid == -1)
     42b:	83 f8 ff             	cmp    $0xffffffff,%eax
     42e:	74 02                	je     432 <fork1+0x12>
  return pid;
}
     430:	c9                   	leave
     431:	c3                   	ret
    panic("fork");
     432:	83 ec 0c             	sub    $0xc,%esp
     435:	68 28 15 00 00       	push   $0x1528
     43a:	e8 c1 ff ff ff       	call   400 <panic>
     43f:	90                   	nop

00000440 <runcmd>:
{
     440:	55                   	push   %ebp
     441:	89 e5                	mov    %esp,%ebp
     443:	53                   	push   %ebx
     444:	83 ec 14             	sub    $0x14,%esp
     447:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     44a:	85 db                	test   %ebx,%ebx
     44c:	74 42                	je     490 <runcmd+0x50>
  switch(cmd->type){
     44e:	83 3b 05             	cmpl   $0x5,(%ebx)
     451:	0f 87 e3 00 00 00    	ja     53a <runcmd+0xfa>
     457:	8b 03                	mov    (%ebx),%eax
     459:	ff 24 85 08 16 00 00 	jmp    *0x1608(,%eax,4)
    if(ecmd->argv[0] == 0)
     460:	8b 43 04             	mov    0x4(%ebx),%eax
     463:	85 c0                	test   %eax,%eax
     465:	74 29                	je     490 <runcmd+0x50>
    exec(ecmd->argv[0], ecmd->argv);
     467:	8d 53 04             	lea    0x4(%ebx),%edx
     46a:	51                   	push   %ecx
     46b:	51                   	push   %ecx
     46c:	52                   	push   %edx
     46d:	50                   	push   %eax
     46e:	e8 68 0c 00 00       	call   10db <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     473:	83 c4 0c             	add    $0xc,%esp
     476:	ff 73 04             	push   0x4(%ebx)
     479:	68 34 15 00 00       	push   $0x1534
     47e:	6a 02                	push   $0x2
     480:	e8 6b 0d 00 00       	call   11f0 <printf>
    break;
     485:	83 c4 10             	add    $0x10,%esp
     488:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     48f:	00 
    exit();
     490:	e8 0e 0c 00 00       	call   10a3 <exit>
    if(fork1() == 0)
     495:	e8 86 ff ff ff       	call   420 <fork1>
     49a:	85 c0                	test   %eax,%eax
     49c:	75 f2                	jne    490 <runcmd+0x50>
     49e:	e9 8c 00 00 00       	jmp    52f <runcmd+0xef>
    if(pipe(p) < 0)
     4a3:	83 ec 0c             	sub    $0xc,%esp
     4a6:	8d 45 f0             	lea    -0x10(%ebp),%eax
     4a9:	50                   	push   %eax
     4aa:	e8 04 0c 00 00       	call   10b3 <pipe>
     4af:	83 c4 10             	add    $0x10,%esp
     4b2:	85 c0                	test   %eax,%eax
     4b4:	0f 88 a2 00 00 00    	js     55c <runcmd+0x11c>
    if(fork1() == 0){
     4ba:	e8 61 ff ff ff       	call   420 <fork1>
     4bf:	85 c0                	test   %eax,%eax
     4c1:	0f 84 a2 00 00 00    	je     569 <runcmd+0x129>
    if(fork1() == 0){
     4c7:	e8 54 ff ff ff       	call   420 <fork1>
     4cc:	85 c0                	test   %eax,%eax
     4ce:	0f 84 c3 00 00 00    	je     597 <runcmd+0x157>
    close(p[0]);
     4d4:	83 ec 0c             	sub    $0xc,%esp
     4d7:	ff 75 f0             	push   -0x10(%ebp)
     4da:	e8 ec 0b 00 00       	call   10cb <close>
    close(p[1]);
     4df:	58                   	pop    %eax
     4e0:	ff 75 f4             	push   -0xc(%ebp)
     4e3:	e8 e3 0b 00 00       	call   10cb <close>
    wait();
     4e8:	e8 be 0b 00 00       	call   10ab <wait>
    wait();
     4ed:	e8 b9 0b 00 00       	call   10ab <wait>
    break;
     4f2:	83 c4 10             	add    $0x10,%esp
     4f5:	eb 99                	jmp    490 <runcmd+0x50>
    if(fork1() == 0)
     4f7:	e8 24 ff ff ff       	call   420 <fork1>
     4fc:	85 c0                	test   %eax,%eax
     4fe:	74 2f                	je     52f <runcmd+0xef>
    wait();
     500:	e8 a6 0b 00 00       	call   10ab <wait>
    runcmd(lcmd->right);
     505:	83 ec 0c             	sub    $0xc,%esp
     508:	ff 73 08             	push   0x8(%ebx)
     50b:	e8 30 ff ff ff       	call   440 <runcmd>
    close(rcmd->fd);
     510:	83 ec 0c             	sub    $0xc,%esp
     513:	ff 73 14             	push   0x14(%ebx)
     516:	e8 b0 0b 00 00       	call   10cb <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     51b:	58                   	pop    %eax
     51c:	5a                   	pop    %edx
     51d:	ff 73 10             	push   0x10(%ebx)
     520:	ff 73 08             	push   0x8(%ebx)
     523:	e8 bb 0b 00 00       	call   10e3 <open>
     528:	83 c4 10             	add    $0x10,%esp
     52b:	85 c0                	test   %eax,%eax
     52d:	78 18                	js     547 <runcmd+0x107>
      runcmd(bcmd->cmd);
     52f:	83 ec 0c             	sub    $0xc,%esp
     532:	ff 73 04             	push   0x4(%ebx)
     535:	e8 06 ff ff ff       	call   440 <runcmd>
    panic("runcmd");
     53a:	83 ec 0c             	sub    $0xc,%esp
     53d:	68 2d 15 00 00       	push   $0x152d
     542:	e8 b9 fe ff ff       	call   400 <panic>
      printf(2, "open %s failed\n", rcmd->file);
     547:	51                   	push   %ecx
     548:	ff 73 08             	push   0x8(%ebx)
     54b:	68 44 15 00 00       	push   $0x1544
     550:	6a 02                	push   $0x2
     552:	e8 99 0c 00 00       	call   11f0 <printf>
      exit();
     557:	e8 47 0b 00 00       	call   10a3 <exit>
      panic("pipe");
     55c:	83 ec 0c             	sub    $0xc,%esp
     55f:	68 54 15 00 00       	push   $0x1554
     564:	e8 97 fe ff ff       	call   400 <panic>
      close(1);
     569:	83 ec 0c             	sub    $0xc,%esp
     56c:	6a 01                	push   $0x1
     56e:	e8 58 0b 00 00       	call   10cb <close>
      dup(p[1]);
     573:	58                   	pop    %eax
     574:	ff 75 f4             	push   -0xc(%ebp)
     577:	e8 9f 0b 00 00       	call   111b <dup>
      close(p[0]);
     57c:	58                   	pop    %eax
     57d:	ff 75 f0             	push   -0x10(%ebp)
     580:	e8 46 0b 00 00       	call   10cb <close>
      close(p[1]);
     585:	58                   	pop    %eax
     586:	ff 75 f4             	push   -0xc(%ebp)
     589:	e8 3d 0b 00 00       	call   10cb <close>
      runcmd(pcmd->left);
     58e:	5a                   	pop    %edx
     58f:	ff 73 04             	push   0x4(%ebx)
     592:	e8 a9 fe ff ff       	call   440 <runcmd>
      close(0);
     597:	83 ec 0c             	sub    $0xc,%esp
     59a:	6a 00                	push   $0x0
     59c:	e8 2a 0b 00 00       	call   10cb <close>
      dup(p[0]);
     5a1:	5a                   	pop    %edx
     5a2:	ff 75 f0             	push   -0x10(%ebp)
     5a5:	e8 71 0b 00 00       	call   111b <dup>
      close(p[0]);
     5aa:	59                   	pop    %ecx
     5ab:	ff 75 f0             	push   -0x10(%ebp)
     5ae:	e8 18 0b 00 00       	call   10cb <close>
      close(p[1]);
     5b3:	58                   	pop    %eax
     5b4:	ff 75 f4             	push   -0xc(%ebp)
     5b7:	e8 0f 0b 00 00       	call   10cb <close>
      runcmd(pcmd->right);
     5bc:	58                   	pop    %eax
     5bd:	ff 73 08             	push   0x8(%ebx)
     5c0:	e8 7b fe ff ff       	call   440 <runcmd>
     5c5:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     5cc:	00 
     5cd:	8d 76 00             	lea    0x0(%esi),%esi

000005d0 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     5d0:	55                   	push   %ebp
     5d1:	89 e5                	mov    %esp,%ebp
     5d3:	53                   	push   %ebx
     5d4:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     5d7:	6a 54                	push   $0x54
     5d9:	e8 32 0e 00 00       	call   1410 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     5de:	83 c4 0c             	add    $0xc,%esp
     5e1:	6a 54                	push   $0x54
  cmd = malloc(sizeof(*cmd));
     5e3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     5e5:	6a 00                	push   $0x0
     5e7:	50                   	push   %eax
     5e8:	e8 33 09 00 00       	call   f20 <memset>
  cmd->type = EXEC;
     5ed:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     5f3:	89 d8                	mov    %ebx,%eax
     5f5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     5f8:	c9                   	leave
     5f9:	c3                   	ret
     5fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000600 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     600:	55                   	push   %ebp
     601:	89 e5                	mov    %esp,%ebp
     603:	53                   	push   %ebx
     604:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     607:	6a 18                	push   $0x18
     609:	e8 02 0e 00 00       	call   1410 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     60e:	83 c4 0c             	add    $0xc,%esp
     611:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     613:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     615:	6a 00                	push   $0x0
     617:	50                   	push   %eax
     618:	e8 03 09 00 00       	call   f20 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     61d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     620:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     626:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     629:	8b 45 0c             	mov    0xc(%ebp),%eax
     62c:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     62f:	8b 45 10             	mov    0x10(%ebp),%eax
     632:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     635:	8b 45 14             	mov    0x14(%ebp),%eax
     638:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     63b:	8b 45 18             	mov    0x18(%ebp),%eax
     63e:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     641:	89 d8                	mov    %ebx,%eax
     643:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     646:	c9                   	leave
     647:	c3                   	ret
     648:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     64f:	00 

00000650 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     650:	55                   	push   %ebp
     651:	89 e5                	mov    %esp,%ebp
     653:	53                   	push   %ebx
     654:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     657:	6a 0c                	push   $0xc
     659:	e8 b2 0d 00 00       	call   1410 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     65e:	83 c4 0c             	add    $0xc,%esp
     661:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     663:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     665:	6a 00                	push   $0x0
     667:	50                   	push   %eax
     668:	e8 b3 08 00 00       	call   f20 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     66d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     670:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     676:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     679:	8b 45 0c             	mov    0xc(%ebp),%eax
     67c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     67f:	89 d8                	mov    %ebx,%eax
     681:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     684:	c9                   	leave
     685:	c3                   	ret
     686:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     68d:	00 
     68e:	66 90                	xchg   %ax,%ax

00000690 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     690:	55                   	push   %ebp
     691:	89 e5                	mov    %esp,%ebp
     693:	53                   	push   %ebx
     694:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     697:	6a 0c                	push   $0xc
     699:	e8 72 0d 00 00       	call   1410 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     69e:	83 c4 0c             	add    $0xc,%esp
     6a1:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     6a3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     6a5:	6a 00                	push   $0x0
     6a7:	50                   	push   %eax
     6a8:	e8 73 08 00 00       	call   f20 <memset>
  cmd->type = LIST;
  cmd->left = left;
     6ad:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     6b0:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     6b6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     6b9:	8b 45 0c             	mov    0xc(%ebp),%eax
     6bc:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     6bf:	89 d8                	mov    %ebx,%eax
     6c1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     6c4:	c9                   	leave
     6c5:	c3                   	ret
     6c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     6cd:	00 
     6ce:	66 90                	xchg   %ax,%ax

000006d0 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     6d0:	55                   	push   %ebp
     6d1:	89 e5                	mov    %esp,%ebp
     6d3:	53                   	push   %ebx
     6d4:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     6d7:	6a 08                	push   $0x8
     6d9:	e8 32 0d 00 00       	call   1410 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     6de:	83 c4 0c             	add    $0xc,%esp
     6e1:	6a 08                	push   $0x8
  cmd = malloc(sizeof(*cmd));
     6e3:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     6e5:	6a 00                	push   $0x0
     6e7:	50                   	push   %eax
     6e8:	e8 33 08 00 00       	call   f20 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     6ed:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     6f0:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     6f6:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     6f9:	89 d8                	mov    %ebx,%eax
     6fb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     6fe:	c9                   	leave
     6ff:	c3                   	ret

00000700 <gettoken>:

char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     700:	55                   	push   %ebp
     701:	89 e5                	mov    %esp,%ebp
     703:	57                   	push   %edi
     704:	56                   	push   %esi
     705:	53                   	push   %ebx
     706:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     709:	8b 45 08             	mov    0x8(%ebp),%eax
{
     70c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     70f:	8b 75 10             	mov    0x10(%ebp),%esi
  s = *ps;
     712:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     714:	39 df                	cmp    %ebx,%edi
     716:	72 0f                	jb     727 <gettoken+0x27>
     718:	eb 25                	jmp    73f <gettoken+0x3f>
     71a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     720:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     723:	39 fb                	cmp    %edi,%ebx
     725:	74 18                	je     73f <gettoken+0x3f>
     727:	0f be 07             	movsbl (%edi),%eax
     72a:	83 ec 08             	sub    $0x8,%esp
     72d:	50                   	push   %eax
     72e:	68 fc 1c 00 00       	push   $0x1cfc
     733:	e8 08 08 00 00       	call   f40 <strchr>
     738:	83 c4 10             	add    $0x10,%esp
     73b:	85 c0                	test   %eax,%eax
     73d:	75 e1                	jne    720 <gettoken+0x20>
  if(q)
     73f:	85 f6                	test   %esi,%esi
     741:	74 02                	je     745 <gettoken+0x45>
    *q = s;
     743:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     745:	0f b6 07             	movzbl (%edi),%eax
  switch(*s){
     748:	3c 3c                	cmp    $0x3c,%al
     74a:	0f 8f c8 00 00 00    	jg     818 <gettoken+0x118>
     750:	3c 3a                	cmp    $0x3a,%al
     752:	7f 5a                	jg     7ae <gettoken+0xae>
     754:	84 c0                	test   %al,%al
     756:	75 48                	jne    7a0 <gettoken+0xa0>
     758:	31 f6                	xor    %esi,%esi
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     75a:	8b 4d 14             	mov    0x14(%ebp),%ecx
     75d:	85 c9                	test   %ecx,%ecx
     75f:	74 05                	je     766 <gettoken+0x66>
    *eq = s;
     761:	8b 45 14             	mov    0x14(%ebp),%eax
     764:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     766:	39 df                	cmp    %ebx,%edi
     768:	72 0d                	jb     777 <gettoken+0x77>
     76a:	eb 23                	jmp    78f <gettoken+0x8f>
     76c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    s++;
     770:	83 c7 01             	add    $0x1,%edi
  while(s < es && strchr(whitespace, *s))
     773:	39 fb                	cmp    %edi,%ebx
     775:	74 18                	je     78f <gettoken+0x8f>
     777:	0f be 07             	movsbl (%edi),%eax
     77a:	83 ec 08             	sub    $0x8,%esp
     77d:	50                   	push   %eax
     77e:	68 fc 1c 00 00       	push   $0x1cfc
     783:	e8 b8 07 00 00       	call   f40 <strchr>
     788:	83 c4 10             	add    $0x10,%esp
     78b:	85 c0                	test   %eax,%eax
     78d:	75 e1                	jne    770 <gettoken+0x70>
  *ps = s;
     78f:	8b 45 08             	mov    0x8(%ebp),%eax
     792:	89 38                	mov    %edi,(%eax)
  return ret;
}
     794:	8d 65 f4             	lea    -0xc(%ebp),%esp
     797:	89 f0                	mov    %esi,%eax
     799:	5b                   	pop    %ebx
     79a:	5e                   	pop    %esi
     79b:	5f                   	pop    %edi
     79c:	5d                   	pop    %ebp
     79d:	c3                   	ret
     79e:	66 90                	xchg   %ax,%ax
  switch(*s){
     7a0:	78 22                	js     7c4 <gettoken+0xc4>
     7a2:	3c 26                	cmp    $0x26,%al
     7a4:	74 08                	je     7ae <gettoken+0xae>
     7a6:	8d 48 d8             	lea    -0x28(%eax),%ecx
     7a9:	80 f9 01             	cmp    $0x1,%cl
     7ac:	77 16                	ja     7c4 <gettoken+0xc4>
  ret = *s;
     7ae:	0f be f0             	movsbl %al,%esi
    s++;
     7b1:	83 c7 01             	add    $0x1,%edi
    break;
     7b4:	eb a4                	jmp    75a <gettoken+0x5a>
     7b6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     7bd:	00 
     7be:	66 90                	xchg   %ax,%ax
  switch(*s){
     7c0:	3c 7c                	cmp    $0x7c,%al
     7c2:	74 ea                	je     7ae <gettoken+0xae>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     7c4:	39 df                	cmp    %ebx,%edi
     7c6:	72 27                	jb     7ef <gettoken+0xef>
     7c8:	e9 87 00 00 00       	jmp    854 <gettoken+0x154>
     7cd:	8d 76 00             	lea    0x0(%esi),%esi
     7d0:	0f be 07             	movsbl (%edi),%eax
     7d3:	83 ec 08             	sub    $0x8,%esp
     7d6:	50                   	push   %eax
     7d7:	68 d8 1c 00 00       	push   $0x1cd8
     7dc:	e8 5f 07 00 00       	call   f40 <strchr>
     7e1:	83 c4 10             	add    $0x10,%esp
     7e4:	85 c0                	test   %eax,%eax
     7e6:	75 1f                	jne    807 <gettoken+0x107>
      s++;
     7e8:	83 c7 01             	add    $0x1,%edi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     7eb:	39 fb                	cmp    %edi,%ebx
     7ed:	74 4d                	je     83c <gettoken+0x13c>
     7ef:	0f be 07             	movsbl (%edi),%eax
     7f2:	83 ec 08             	sub    $0x8,%esp
     7f5:	50                   	push   %eax
     7f6:	68 fc 1c 00 00       	push   $0x1cfc
     7fb:	e8 40 07 00 00       	call   f40 <strchr>
     800:	83 c4 10             	add    $0x10,%esp
     803:	85 c0                	test   %eax,%eax
     805:	74 c9                	je     7d0 <gettoken+0xd0>
    ret = 'a';
     807:	be 61 00 00 00       	mov    $0x61,%esi
     80c:	e9 49 ff ff ff       	jmp    75a <gettoken+0x5a>
     811:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     818:	3c 3e                	cmp    $0x3e,%al
     81a:	75 a4                	jne    7c0 <gettoken+0xc0>
    if(*s == '>'){
     81c:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
     820:	74 0d                	je     82f <gettoken+0x12f>
    s++;
     822:	83 c7 01             	add    $0x1,%edi
  ret = *s;
     825:	be 3e 00 00 00       	mov    $0x3e,%esi
     82a:	e9 2b ff ff ff       	jmp    75a <gettoken+0x5a>
      s++;
     82f:	83 c7 02             	add    $0x2,%edi
      ret = '+';
     832:	be 2b 00 00 00       	mov    $0x2b,%esi
     837:	e9 1e ff ff ff       	jmp    75a <gettoken+0x5a>
  if(eq)
     83c:	8b 45 14             	mov    0x14(%ebp),%eax
     83f:	85 c0                	test   %eax,%eax
     841:	74 05                	je     848 <gettoken+0x148>
    *eq = s;
     843:	8b 45 14             	mov    0x14(%ebp),%eax
     846:	89 18                	mov    %ebx,(%eax)
  while(s < es && strchr(whitespace, *s))
     848:	89 df                	mov    %ebx,%edi
    ret = 'a';
     84a:	be 61 00 00 00       	mov    $0x61,%esi
     84f:	e9 3b ff ff ff       	jmp    78f <gettoken+0x8f>
  if(eq)
     854:	8b 55 14             	mov    0x14(%ebp),%edx
     857:	85 d2                	test   %edx,%edx
     859:	74 ef                	je     84a <gettoken+0x14a>
    *eq = s;
     85b:	8b 45 14             	mov    0x14(%ebp),%eax
     85e:	89 38                	mov    %edi,(%eax)
  while(s < es && strchr(whitespace, *s))
     860:	eb e8                	jmp    84a <gettoken+0x14a>
     862:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     869:	00 
     86a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000870 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     870:	55                   	push   %ebp
     871:	89 e5                	mov    %esp,%ebp
     873:	57                   	push   %edi
     874:	56                   	push   %esi
     875:	53                   	push   %ebx
     876:	83 ec 0c             	sub    $0xc,%esp
     879:	8b 7d 08             	mov    0x8(%ebp),%edi
     87c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     87f:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     881:	39 f3                	cmp    %esi,%ebx
     883:	72 12                	jb     897 <peek+0x27>
     885:	eb 28                	jmp    8af <peek+0x3f>
     887:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     88e:	00 
     88f:	90                   	nop
    s++;
     890:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     893:	39 de                	cmp    %ebx,%esi
     895:	74 18                	je     8af <peek+0x3f>
     897:	0f be 03             	movsbl (%ebx),%eax
     89a:	83 ec 08             	sub    $0x8,%esp
     89d:	50                   	push   %eax
     89e:	68 fc 1c 00 00       	push   $0x1cfc
     8a3:	e8 98 06 00 00       	call   f40 <strchr>
     8a8:	83 c4 10             	add    $0x10,%esp
     8ab:	85 c0                	test   %eax,%eax
     8ad:	75 e1                	jne    890 <peek+0x20>
  *ps = s;
     8af:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     8b1:	0f be 03             	movsbl (%ebx),%eax
     8b4:	31 d2                	xor    %edx,%edx
     8b6:	84 c0                	test   %al,%al
     8b8:	75 0e                	jne    8c8 <peek+0x58>
}
     8ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8bd:	89 d0                	mov    %edx,%eax
     8bf:	5b                   	pop    %ebx
     8c0:	5e                   	pop    %esi
     8c1:	5f                   	pop    %edi
     8c2:	5d                   	pop    %ebp
     8c3:	c3                   	ret
     8c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  return *s && strchr(toks, *s);
     8c8:	83 ec 08             	sub    $0x8,%esp
     8cb:	50                   	push   %eax
     8cc:	ff 75 10             	push   0x10(%ebp)
     8cf:	e8 6c 06 00 00       	call   f40 <strchr>
     8d4:	83 c4 10             	add    $0x10,%esp
     8d7:	31 d2                	xor    %edx,%edx
     8d9:	85 c0                	test   %eax,%eax
     8db:	0f 95 c2             	setne  %dl
}
     8de:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8e1:	5b                   	pop    %ebx
     8e2:	89 d0                	mov    %edx,%eax
     8e4:	5e                   	pop    %esi
     8e5:	5f                   	pop    %edi
     8e6:	5d                   	pop    %ebp
     8e7:	c3                   	ret
     8e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     8ef:	00 

000008f0 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     8f0:	55                   	push   %ebp
     8f1:	89 e5                	mov    %esp,%ebp
     8f3:	57                   	push   %edi
     8f4:	56                   	push   %esi
     8f5:	53                   	push   %ebx
     8f6:	83 ec 2c             	sub    $0x2c,%esp
     8f9:	8b 75 0c             	mov    0xc(%ebp),%esi
     8fc:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     8ff:	90                   	nop
     900:	83 ec 04             	sub    $0x4,%esp
     903:	68 76 15 00 00       	push   $0x1576
     908:	53                   	push   %ebx
     909:	56                   	push   %esi
     90a:	e8 61 ff ff ff       	call   870 <peek>
     90f:	83 c4 10             	add    $0x10,%esp
     912:	85 c0                	test   %eax,%eax
     914:	0f 84 f6 00 00 00    	je     a10 <parseredirs+0x120>
    tok = gettoken(ps, es, 0, 0);
     91a:	6a 00                	push   $0x0
     91c:	6a 00                	push   $0x0
     91e:	53                   	push   %ebx
     91f:	56                   	push   %esi
     920:	e8 db fd ff ff       	call   700 <gettoken>
     925:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     927:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     92a:	50                   	push   %eax
     92b:	8d 45 e0             	lea    -0x20(%ebp),%eax
     92e:	50                   	push   %eax
     92f:	53                   	push   %ebx
     930:	56                   	push   %esi
     931:	e8 ca fd ff ff       	call   700 <gettoken>
     936:	83 c4 20             	add    $0x20,%esp
     939:	83 f8 61             	cmp    $0x61,%eax
     93c:	0f 85 d9 00 00 00    	jne    a1b <parseredirs+0x12b>
      panic("missing file for redirection");
    switch(tok){
     942:	83 ff 3c             	cmp    $0x3c,%edi
     945:	74 69                	je     9b0 <parseredirs+0xc0>
     947:	83 ff 3e             	cmp    $0x3e,%edi
     94a:	74 05                	je     951 <parseredirs+0x61>
     94c:	83 ff 2b             	cmp    $0x2b,%edi
     94f:	75 af                	jne    900 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     951:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     954:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     957:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     95a:	89 55 d0             	mov    %edx,-0x30(%ebp)
     95d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     960:	6a 18                	push   $0x18
     962:	e8 a9 0a 00 00       	call   1410 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     967:	83 c4 0c             	add    $0xc,%esp
     96a:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     96c:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     96e:	6a 00                	push   $0x0
     970:	50                   	push   %eax
     971:	e8 aa 05 00 00       	call   f20 <memset>
  cmd->type = REDIR;
     976:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     97c:	8b 45 08             	mov    0x8(%ebp),%eax
      break;
     97f:	83 c4 10             	add    $0x10,%esp
  cmd->cmd = subcmd;
     982:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     985:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
     988:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     98b:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->mode = mode;
     98e:	c7 47 10 01 02 00 00 	movl   $0x201,0x10(%edi)
  cmd->efile = efile;
     995:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->fd = fd;
     998:	c7 47 14 01 00 00 00 	movl   $0x1,0x14(%edi)
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     99f:	89 7d 08             	mov    %edi,0x8(%ebp)
      break;
     9a2:	e9 59 ff ff ff       	jmp    900 <parseredirs+0x10>
     9a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     9ae:	00 
     9af:	90                   	nop
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     9b0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
     9b3:	8b 4d e0             	mov    -0x20(%ebp),%ecx
  cmd = malloc(sizeof(*cmd));
     9b6:	83 ec 0c             	sub    $0xc,%esp
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     9b9:	89 55 d0             	mov    %edx,-0x30(%ebp)
     9bc:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  cmd = malloc(sizeof(*cmd));
     9bf:	6a 18                	push   $0x18
     9c1:	e8 4a 0a 00 00       	call   1410 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     9c6:	83 c4 0c             	add    $0xc,%esp
     9c9:	6a 18                	push   $0x18
  cmd = malloc(sizeof(*cmd));
     9cb:	89 c7                	mov    %eax,%edi
  memset(cmd, 0, sizeof(*cmd));
     9cd:	6a 00                	push   $0x0
     9cf:	50                   	push   %eax
     9d0:	e8 4b 05 00 00       	call   f20 <memset>
  cmd->cmd = subcmd;
     9d5:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->file = file;
     9d8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
      break;
     9db:	83 c4 10             	add    $0x10,%esp
  cmd->efile = efile;
     9de:	8b 55 d0             	mov    -0x30(%ebp),%edx
  cmd->type = REDIR;
     9e1:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  cmd->cmd = subcmd;
     9e7:	89 47 04             	mov    %eax,0x4(%edi)
  cmd->file = file;
     9ea:	89 4f 08             	mov    %ecx,0x8(%edi)
  cmd->efile = efile;
     9ed:	89 57 0c             	mov    %edx,0xc(%edi)
  cmd->mode = mode;
     9f0:	c7 47 10 00 00 00 00 	movl   $0x0,0x10(%edi)
  cmd->fd = fd;
     9f7:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     9fe:	89 7d 08             	mov    %edi,0x8(%ebp)
      break;
     a01:	e9 fa fe ff ff       	jmp    900 <parseredirs+0x10>
     a06:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     a0d:	00 
     a0e:	66 90                	xchg   %ax,%ax
    }
  }
  return cmd;
}
     a10:	8b 45 08             	mov    0x8(%ebp),%eax
     a13:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a16:	5b                   	pop    %ebx
     a17:	5e                   	pop    %esi
     a18:	5f                   	pop    %edi
     a19:	5d                   	pop    %ebp
     a1a:	c3                   	ret
      panic("missing file for redirection");
     a1b:	83 ec 0c             	sub    $0xc,%esp
     a1e:	68 59 15 00 00       	push   $0x1559
     a23:	e8 d8 f9 ff ff       	call   400 <panic>
     a28:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     a2f:	00 

00000a30 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     a30:	55                   	push   %ebp
     a31:	89 e5                	mov    %esp,%ebp
     a33:	57                   	push   %edi
     a34:	56                   	push   %esi
     a35:	53                   	push   %ebx
     a36:	83 ec 30             	sub    $0x30,%esp
     a39:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a3c:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     a3f:	68 79 15 00 00       	push   $0x1579
     a44:	56                   	push   %esi
     a45:	53                   	push   %ebx
     a46:	e8 25 fe ff ff       	call   870 <peek>
     a4b:	83 c4 10             	add    $0x10,%esp
     a4e:	85 c0                	test   %eax,%eax
     a50:	0f 85 aa 00 00 00    	jne    b00 <parseexec+0xd0>
  cmd = malloc(sizeof(*cmd));
     a56:	83 ec 0c             	sub    $0xc,%esp
     a59:	89 c7                	mov    %eax,%edi
     a5b:	6a 54                	push   $0x54
     a5d:	e8 ae 09 00 00       	call   1410 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     a62:	83 c4 0c             	add    $0xc,%esp
     a65:	6a 54                	push   $0x54
     a67:	6a 00                	push   $0x0
     a69:	89 45 d0             	mov    %eax,-0x30(%ebp)
     a6c:	50                   	push   %eax
     a6d:	e8 ae 04 00 00       	call   f20 <memset>
  cmd->type = EXEC;
     a72:	8b 45 d0             	mov    -0x30(%ebp),%eax

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     a75:	83 c4 0c             	add    $0xc,%esp
  cmd->type = EXEC;
     a78:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  ret = parseredirs(ret, ps, es);
     a7e:	56                   	push   %esi
     a7f:	53                   	push   %ebx
     a80:	50                   	push   %eax
     a81:	e8 6a fe ff ff       	call   8f0 <parseredirs>

  while(!peek(ps, es, "|)&;")){
     a86:	83 c4 10             	add    $0x10,%esp
  ret = parseredirs(ret, ps, es);
     a89:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     a8c:	eb 15                	jmp    aa3 <parseexec+0x73>
     a8e:	66 90                	xchg   %ax,%ax
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     a90:	83 ec 04             	sub    $0x4,%esp
     a93:	56                   	push   %esi
     a94:	53                   	push   %ebx
     a95:	ff 75 d4             	push   -0x2c(%ebp)
     a98:	e8 53 fe ff ff       	call   8f0 <parseredirs>
     a9d:	83 c4 10             	add    $0x10,%esp
     aa0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     aa3:	83 ec 04             	sub    $0x4,%esp
     aa6:	68 90 15 00 00       	push   $0x1590
     aab:	56                   	push   %esi
     aac:	53                   	push   %ebx
     aad:	e8 be fd ff ff       	call   870 <peek>
     ab2:	83 c4 10             	add    $0x10,%esp
     ab5:	85 c0                	test   %eax,%eax
     ab7:	75 5f                	jne    b18 <parseexec+0xe8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     ab9:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     abc:	50                   	push   %eax
     abd:	8d 45 e0             	lea    -0x20(%ebp),%eax
     ac0:	50                   	push   %eax
     ac1:	56                   	push   %esi
     ac2:	53                   	push   %ebx
     ac3:	e8 38 fc ff ff       	call   700 <gettoken>
     ac8:	83 c4 10             	add    $0x10,%esp
     acb:	85 c0                	test   %eax,%eax
     acd:	74 49                	je     b18 <parseexec+0xe8>
    if(tok != 'a')
     acf:	83 f8 61             	cmp    $0x61,%eax
     ad2:	75 62                	jne    b36 <parseexec+0x106>
    cmd->argv[argc] = q;
     ad4:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ad7:	8b 55 d0             	mov    -0x30(%ebp),%edx
     ada:	89 44 ba 04          	mov    %eax,0x4(%edx,%edi,4)
    cmd->eargv[argc] = eq;
     ade:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     ae1:	89 44 ba 2c          	mov    %eax,0x2c(%edx,%edi,4)
    argc++;
     ae5:	83 c7 01             	add    $0x1,%edi
    if(argc >= MAXARGS)
     ae8:	83 ff 0a             	cmp    $0xa,%edi
     aeb:	75 a3                	jne    a90 <parseexec+0x60>
      panic("too many args");
     aed:	83 ec 0c             	sub    $0xc,%esp
     af0:	68 82 15 00 00       	push   $0x1582
     af5:	e8 06 f9 ff ff       	call   400 <panic>
     afa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     b00:	89 75 0c             	mov    %esi,0xc(%ebp)
     b03:	89 5d 08             	mov    %ebx,0x8(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     b06:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b09:	5b                   	pop    %ebx
     b0a:	5e                   	pop    %esi
     b0b:	5f                   	pop    %edi
     b0c:	5d                   	pop    %ebp
    return parseblock(ps, es);
     b0d:	e9 ae 01 00 00       	jmp    cc0 <parseblock>
     b12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  cmd->argv[argc] = 0;
     b18:	8b 45 d0             	mov    -0x30(%ebp),%eax
     b1b:	c7 44 b8 04 00 00 00 	movl   $0x0,0x4(%eax,%edi,4)
     b22:	00 
  cmd->eargv[argc] = 0;
     b23:	c7 44 b8 2c 00 00 00 	movl   $0x0,0x2c(%eax,%edi,4)
     b2a:	00 
}
     b2b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     b2e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b31:	5b                   	pop    %ebx
     b32:	5e                   	pop    %esi
     b33:	5f                   	pop    %edi
     b34:	5d                   	pop    %ebp
     b35:	c3                   	ret
      panic("syntax");
     b36:	83 ec 0c             	sub    $0xc,%esp
     b39:	68 7b 15 00 00       	push   $0x157b
     b3e:	e8 bd f8 ff ff       	call   400 <panic>
     b43:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     b4a:	00 
     b4b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000b50 <parsepipe>:
{
     b50:	55                   	push   %ebp
     b51:	89 e5                	mov    %esp,%ebp
     b53:	57                   	push   %edi
     b54:	56                   	push   %esi
     b55:	53                   	push   %ebx
     b56:	83 ec 14             	sub    $0x14,%esp
     b59:	8b 75 08             	mov    0x8(%ebp),%esi
     b5c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parseexec(ps, es);
     b5f:	57                   	push   %edi
     b60:	56                   	push   %esi
     b61:	e8 ca fe ff ff       	call   a30 <parseexec>
  if(peek(ps, es, "|")){
     b66:	83 c4 0c             	add    $0xc,%esp
     b69:	68 95 15 00 00       	push   $0x1595
  cmd = parseexec(ps, es);
     b6e:	89 c3                	mov    %eax,%ebx
  if(peek(ps, es, "|")){
     b70:	57                   	push   %edi
     b71:	56                   	push   %esi
     b72:	e8 f9 fc ff ff       	call   870 <peek>
     b77:	83 c4 10             	add    $0x10,%esp
     b7a:	85 c0                	test   %eax,%eax
     b7c:	75 12                	jne    b90 <parsepipe+0x40>
}
     b7e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     b81:	89 d8                	mov    %ebx,%eax
     b83:	5b                   	pop    %ebx
     b84:	5e                   	pop    %esi
     b85:	5f                   	pop    %edi
     b86:	5d                   	pop    %ebp
     b87:	c3                   	ret
     b88:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     b8f:	00 
    gettoken(ps, es, 0, 0);
     b90:	6a 00                	push   $0x0
     b92:	6a 00                	push   $0x0
     b94:	57                   	push   %edi
     b95:	56                   	push   %esi
     b96:	e8 65 fb ff ff       	call   700 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     b9b:	58                   	pop    %eax
     b9c:	5a                   	pop    %edx
     b9d:	57                   	push   %edi
     b9e:	56                   	push   %esi
     b9f:	e8 ac ff ff ff       	call   b50 <parsepipe>
  cmd = malloc(sizeof(*cmd));
     ba4:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = pipecmd(cmd, parsepipe(ps, es));
     bab:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     bad:	e8 5e 08 00 00       	call   1410 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     bb2:	83 c4 0c             	add    $0xc,%esp
     bb5:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     bb7:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     bb9:	6a 00                	push   $0x0
     bbb:	50                   	push   %eax
     bbc:	e8 5f 03 00 00       	call   f20 <memset>
  cmd->left = left;
     bc1:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     bc4:	83 c4 10             	add    $0x10,%esp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     bc7:	89 f3                	mov    %esi,%ebx
  cmd->type = PIPE;
     bc9:	c7 06 03 00 00 00    	movl   $0x3,(%esi)
}
     bcf:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     bd1:	89 7e 08             	mov    %edi,0x8(%esi)
}
     bd4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     bd7:	5b                   	pop    %ebx
     bd8:	5e                   	pop    %esi
     bd9:	5f                   	pop    %edi
     bda:	5d                   	pop    %ebp
     bdb:	c3                   	ret
     bdc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000be0 <parseline>:
{
     be0:	55                   	push   %ebp
     be1:	89 e5                	mov    %esp,%ebp
     be3:	57                   	push   %edi
     be4:	56                   	push   %esi
     be5:	53                   	push   %ebx
     be6:	83 ec 24             	sub    $0x24,%esp
     be9:	8b 75 08             	mov    0x8(%ebp),%esi
     bec:	8b 7d 0c             	mov    0xc(%ebp),%edi
  cmd = parsepipe(ps, es);
     bef:	57                   	push   %edi
     bf0:	56                   	push   %esi
     bf1:	e8 5a ff ff ff       	call   b50 <parsepipe>
  while(peek(ps, es, "&")){
     bf6:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
     bf9:	89 c3                	mov    %eax,%ebx
  while(peek(ps, es, "&")){
     bfb:	eb 3b                	jmp    c38 <parseline+0x58>
     bfd:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     c00:	6a 00                	push   $0x0
     c02:	6a 00                	push   $0x0
     c04:	57                   	push   %edi
     c05:	56                   	push   %esi
     c06:	e8 f5 fa ff ff       	call   700 <gettoken>
  cmd = malloc(sizeof(*cmd));
     c0b:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     c12:	e8 f9 07 00 00       	call   1410 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     c17:	83 c4 0c             	add    $0xc,%esp
     c1a:	6a 08                	push   $0x8
     c1c:	6a 00                	push   $0x0
     c1e:	50                   	push   %eax
     c1f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
     c22:	e8 f9 02 00 00       	call   f20 <memset>
  cmd->type = BACK;
     c27:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  cmd->cmd = subcmd;
     c2a:	83 c4 10             	add    $0x10,%esp
  cmd->type = BACK;
     c2d:	c7 02 05 00 00 00    	movl   $0x5,(%edx)
  cmd->cmd = subcmd;
     c33:	89 5a 04             	mov    %ebx,0x4(%edx)
    cmd = backcmd(cmd);
     c36:	89 d3                	mov    %edx,%ebx
  while(peek(ps, es, "&")){
     c38:	83 ec 04             	sub    $0x4,%esp
     c3b:	68 97 15 00 00       	push   $0x1597
     c40:	57                   	push   %edi
     c41:	56                   	push   %esi
     c42:	e8 29 fc ff ff       	call   870 <peek>
     c47:	83 c4 10             	add    $0x10,%esp
     c4a:	85 c0                	test   %eax,%eax
     c4c:	75 b2                	jne    c00 <parseline+0x20>
  if(peek(ps, es, ";")){
     c4e:	83 ec 04             	sub    $0x4,%esp
     c51:	68 93 15 00 00       	push   $0x1593
     c56:	57                   	push   %edi
     c57:	56                   	push   %esi
     c58:	e8 13 fc ff ff       	call   870 <peek>
     c5d:	83 c4 10             	add    $0x10,%esp
     c60:	85 c0                	test   %eax,%eax
     c62:	75 0c                	jne    c70 <parseline+0x90>
}
     c64:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c67:	89 d8                	mov    %ebx,%eax
     c69:	5b                   	pop    %ebx
     c6a:	5e                   	pop    %esi
     c6b:	5f                   	pop    %edi
     c6c:	5d                   	pop    %ebp
     c6d:	c3                   	ret
     c6e:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     c70:	6a 00                	push   $0x0
     c72:	6a 00                	push   $0x0
     c74:	57                   	push   %edi
     c75:	56                   	push   %esi
     c76:	e8 85 fa ff ff       	call   700 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     c7b:	58                   	pop    %eax
     c7c:	5a                   	pop    %edx
     c7d:	57                   	push   %edi
     c7e:	56                   	push   %esi
     c7f:	e8 5c ff ff ff       	call   be0 <parseline>
  cmd = malloc(sizeof(*cmd));
     c84:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
    cmd = listcmd(cmd, parseline(ps, es));
     c8b:	89 c7                	mov    %eax,%edi
  cmd = malloc(sizeof(*cmd));
     c8d:	e8 7e 07 00 00       	call   1410 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     c92:	83 c4 0c             	add    $0xc,%esp
     c95:	6a 0c                	push   $0xc
  cmd = malloc(sizeof(*cmd));
     c97:	89 c6                	mov    %eax,%esi
  memset(cmd, 0, sizeof(*cmd));
     c99:	6a 00                	push   $0x0
     c9b:	50                   	push   %eax
     c9c:	e8 7f 02 00 00       	call   f20 <memset>
  cmd->left = left;
     ca1:	89 5e 04             	mov    %ebx,0x4(%esi)
  cmd->right = right;
     ca4:	83 c4 10             	add    $0x10,%esp
    cmd = listcmd(cmd, parseline(ps, es));
     ca7:	89 f3                	mov    %esi,%ebx
  cmd->type = LIST;
     ca9:	c7 06 04 00 00 00    	movl   $0x4,(%esi)
}
     caf:	89 d8                	mov    %ebx,%eax
  cmd->right = right;
     cb1:	89 7e 08             	mov    %edi,0x8(%esi)
}
     cb4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cb7:	5b                   	pop    %ebx
     cb8:	5e                   	pop    %esi
     cb9:	5f                   	pop    %edi
     cba:	5d                   	pop    %ebp
     cbb:	c3                   	ret
     cbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000cc0 <parseblock>:
{
     cc0:	55                   	push   %ebp
     cc1:	89 e5                	mov    %esp,%ebp
     cc3:	57                   	push   %edi
     cc4:	56                   	push   %esi
     cc5:	53                   	push   %ebx
     cc6:	83 ec 10             	sub    $0x10,%esp
     cc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
     ccc:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     ccf:	68 79 15 00 00       	push   $0x1579
     cd4:	56                   	push   %esi
     cd5:	53                   	push   %ebx
     cd6:	e8 95 fb ff ff       	call   870 <peek>
     cdb:	83 c4 10             	add    $0x10,%esp
     cde:	85 c0                	test   %eax,%eax
     ce0:	74 4a                	je     d2c <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     ce2:	6a 00                	push   $0x0
     ce4:	6a 00                	push   $0x0
     ce6:	56                   	push   %esi
     ce7:	53                   	push   %ebx
     ce8:	e8 13 fa ff ff       	call   700 <gettoken>
  cmd = parseline(ps, es);
     ced:	58                   	pop    %eax
     cee:	5a                   	pop    %edx
     cef:	56                   	push   %esi
     cf0:	53                   	push   %ebx
     cf1:	e8 ea fe ff ff       	call   be0 <parseline>
  if(!peek(ps, es, ")"))
     cf6:	83 c4 0c             	add    $0xc,%esp
     cf9:	68 b5 15 00 00       	push   $0x15b5
  cmd = parseline(ps, es);
     cfe:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     d00:	56                   	push   %esi
     d01:	53                   	push   %ebx
     d02:	e8 69 fb ff ff       	call   870 <peek>
     d07:	83 c4 10             	add    $0x10,%esp
     d0a:	85 c0                	test   %eax,%eax
     d0c:	74 2b                	je     d39 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
     d0e:	6a 00                	push   $0x0
     d10:	6a 00                	push   $0x0
     d12:	56                   	push   %esi
     d13:	53                   	push   %ebx
     d14:	e8 e7 f9 ff ff       	call   700 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     d19:	83 c4 0c             	add    $0xc,%esp
     d1c:	56                   	push   %esi
     d1d:	53                   	push   %ebx
     d1e:	57                   	push   %edi
     d1f:	e8 cc fb ff ff       	call   8f0 <parseredirs>
}
     d24:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d27:	5b                   	pop    %ebx
     d28:	5e                   	pop    %esi
     d29:	5f                   	pop    %edi
     d2a:	5d                   	pop    %ebp
     d2b:	c3                   	ret
    panic("parseblock");
     d2c:	83 ec 0c             	sub    $0xc,%esp
     d2f:	68 99 15 00 00       	push   $0x1599
     d34:	e8 c7 f6 ff ff       	call   400 <panic>
    panic("syntax - missing )");
     d39:	83 ec 0c             	sub    $0xc,%esp
     d3c:	68 a4 15 00 00       	push   $0x15a4
     d41:	e8 ba f6 ff ff       	call   400 <panic>
     d46:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     d4d:	00 
     d4e:	66 90                	xchg   %ax,%ax

00000d50 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     d50:	55                   	push   %ebp
     d51:	89 e5                	mov    %esp,%ebp
     d53:	53                   	push   %ebx
     d54:	83 ec 04             	sub    $0x4,%esp
     d57:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     d5a:	85 db                	test   %ebx,%ebx
     d5c:	74 29                	je     d87 <nulterminate+0x37>
    return 0;

  switch(cmd->type){
     d5e:	83 3b 05             	cmpl   $0x5,(%ebx)
     d61:	77 24                	ja     d87 <nulterminate+0x37>
     d63:	8b 03                	mov    (%ebx),%eax
     d65:	ff 24 85 20 16 00 00 	jmp    *0x1620(,%eax,4)
     d6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     d70:	83 ec 0c             	sub    $0xc,%esp
     d73:	ff 73 04             	push   0x4(%ebx)
     d76:	e8 d5 ff ff ff       	call   d50 <nulterminate>
    nulterminate(lcmd->right);
     d7b:	58                   	pop    %eax
     d7c:	ff 73 08             	push   0x8(%ebx)
     d7f:	e8 cc ff ff ff       	call   d50 <nulterminate>
    break;
     d84:	83 c4 10             	add    $0x10,%esp
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     d87:	89 d8                	mov    %ebx,%eax
     d89:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     d8c:	c9                   	leave
     d8d:	c3                   	ret
     d8e:	66 90                	xchg   %ax,%ax
    nulterminate(bcmd->cmd);
     d90:	83 ec 0c             	sub    $0xc,%esp
     d93:	ff 73 04             	push   0x4(%ebx)
     d96:	e8 b5 ff ff ff       	call   d50 <nulterminate>
}
     d9b:	89 d8                	mov    %ebx,%eax
    break;
     d9d:	83 c4 10             	add    $0x10,%esp
}
     da0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     da3:	c9                   	leave
     da4:	c3                   	ret
     da5:	8d 76 00             	lea    0x0(%esi),%esi
    for(i=0; ecmd->argv[i]; i++)
     da8:	8b 4b 04             	mov    0x4(%ebx),%ecx
     dab:	85 c9                	test   %ecx,%ecx
     dad:	74 d8                	je     d87 <nulterminate+0x37>
     daf:	8d 43 08             	lea    0x8(%ebx),%eax
     db2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     db8:	8b 50 24             	mov    0x24(%eax),%edx
    for(i=0; ecmd->argv[i]; i++)
     dbb:	83 c0 04             	add    $0x4,%eax
      *ecmd->eargv[i] = 0;
     dbe:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     dc1:	8b 50 fc             	mov    -0x4(%eax),%edx
     dc4:	85 d2                	test   %edx,%edx
     dc6:	75 f0                	jne    db8 <nulterminate+0x68>
}
     dc8:	89 d8                	mov    %ebx,%eax
     dca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     dcd:	c9                   	leave
     dce:	c3                   	ret
     dcf:	90                   	nop
    nulterminate(rcmd->cmd);
     dd0:	83 ec 0c             	sub    $0xc,%esp
     dd3:	ff 73 04             	push   0x4(%ebx)
     dd6:	e8 75 ff ff ff       	call   d50 <nulterminate>
    *rcmd->efile = 0;
     ddb:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     dde:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     de1:	c6 00 00             	movb   $0x0,(%eax)
}
     de4:	89 d8                	mov    %ebx,%eax
     de6:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     de9:	c9                   	leave
     dea:	c3                   	ret
     deb:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi

00000df0 <parsecmd>:
{
     df0:	55                   	push   %ebp
     df1:	89 e5                	mov    %esp,%ebp
     df3:	57                   	push   %edi
     df4:	56                   	push   %esi
  cmd = parseline(&s, es);
     df5:	8d 7d 08             	lea    0x8(%ebp),%edi
{
     df8:	53                   	push   %ebx
     df9:	83 ec 18             	sub    $0x18,%esp
  es = s + strlen(s);
     dfc:	8b 5d 08             	mov    0x8(%ebp),%ebx
     dff:	53                   	push   %ebx
     e00:	e8 eb 00 00 00       	call   ef0 <strlen>
  cmd = parseline(&s, es);
     e05:	59                   	pop    %ecx
     e06:	5e                   	pop    %esi
  es = s + strlen(s);
     e07:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     e09:	53                   	push   %ebx
     e0a:	57                   	push   %edi
     e0b:	e8 d0 fd ff ff       	call   be0 <parseline>
  peek(&s, es, "");
     e10:	83 c4 0c             	add    $0xc,%esp
     e13:	68 43 15 00 00       	push   $0x1543
  cmd = parseline(&s, es);
     e18:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     e1a:	53                   	push   %ebx
     e1b:	57                   	push   %edi
     e1c:	e8 4f fa ff ff       	call   870 <peek>
  if(s != es){
     e21:	8b 45 08             	mov    0x8(%ebp),%eax
     e24:	83 c4 10             	add    $0x10,%esp
     e27:	39 d8                	cmp    %ebx,%eax
     e29:	75 13                	jne    e3e <parsecmd+0x4e>
  nulterminate(cmd);
     e2b:	83 ec 0c             	sub    $0xc,%esp
     e2e:	56                   	push   %esi
     e2f:	e8 1c ff ff ff       	call   d50 <nulterminate>
}
     e34:	8d 65 f4             	lea    -0xc(%ebp),%esp
     e37:	89 f0                	mov    %esi,%eax
     e39:	5b                   	pop    %ebx
     e3a:	5e                   	pop    %esi
     e3b:	5f                   	pop    %edi
     e3c:	5d                   	pop    %ebp
     e3d:	c3                   	ret
    printf(2, "leftovers: %s\n", s);
     e3e:	52                   	push   %edx
     e3f:	50                   	push   %eax
     e40:	68 b7 15 00 00       	push   $0x15b7
     e45:	6a 02                	push   $0x2
     e47:	e8 a4 03 00 00       	call   11f0 <printf>
    panic("syntax");
     e4c:	c7 04 24 7b 15 00 00 	movl   $0x157b,(%esp)
     e53:	e8 a8 f5 ff ff       	call   400 <panic>
     e58:	66 90                	xchg   %ax,%ax
     e5a:	66 90                	xchg   %ax,%ax
     e5c:	66 90                	xchg   %ax,%ax
     e5e:	66 90                	xchg   %ax,%ax

00000e60 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     e60:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     e61:	31 c0                	xor    %eax,%eax
{
     e63:	89 e5                	mov    %esp,%ebp
     e65:	53                   	push   %ebx
     e66:	8b 4d 08             	mov    0x8(%ebp),%ecx
     e69:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     e6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
     e70:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
     e74:	88 14 01             	mov    %dl,(%ecx,%eax,1)
     e77:	83 c0 01             	add    $0x1,%eax
     e7a:	84 d2                	test   %dl,%dl
     e7c:	75 f2                	jne    e70 <strcpy+0x10>
    ;
  return os;
}
     e7e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     e81:	89 c8                	mov    %ecx,%eax
     e83:	c9                   	leave
     e84:	c3                   	ret
     e85:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     e8c:	00 
     e8d:	8d 76 00             	lea    0x0(%esi),%esi

00000e90 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     e90:	55                   	push   %ebp
     e91:	89 e5                	mov    %esp,%ebp
     e93:	53                   	push   %ebx
     e94:	8b 55 08             	mov    0x8(%ebp),%edx
     e97:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     e9a:	0f b6 02             	movzbl (%edx),%eax
     e9d:	84 c0                	test   %al,%al
     e9f:	75 17                	jne    eb8 <strcmp+0x28>
     ea1:	eb 3a                	jmp    edd <strcmp+0x4d>
     ea3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
     ea8:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
     eac:	83 c2 01             	add    $0x1,%edx
     eaf:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
     eb2:	84 c0                	test   %al,%al
     eb4:	74 1a                	je     ed0 <strcmp+0x40>
     eb6:	89 d9                	mov    %ebx,%ecx
     eb8:	0f b6 19             	movzbl (%ecx),%ebx
     ebb:	38 c3                	cmp    %al,%bl
     ebd:	74 e9                	je     ea8 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
     ebf:	29 d8                	sub    %ebx,%eax
}
     ec1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     ec4:	c9                   	leave
     ec5:	c3                   	ret
     ec6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     ecd:	00 
     ece:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
     ed0:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
     ed4:	31 c0                	xor    %eax,%eax
     ed6:	29 d8                	sub    %ebx,%eax
}
     ed8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     edb:	c9                   	leave
     edc:	c3                   	ret
  return (uchar)*p - (uchar)*q;
     edd:	0f b6 19             	movzbl (%ecx),%ebx
     ee0:	31 c0                	xor    %eax,%eax
     ee2:	eb db                	jmp    ebf <strcmp+0x2f>
     ee4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     eeb:	00 
     eec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000ef0 <strlen>:

uint
strlen(const char *s)
{
     ef0:	55                   	push   %ebp
     ef1:	89 e5                	mov    %esp,%ebp
     ef3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
     ef6:	80 3a 00             	cmpb   $0x0,(%edx)
     ef9:	74 15                	je     f10 <strlen+0x20>
     efb:	31 c0                	xor    %eax,%eax
     efd:	8d 76 00             	lea    0x0(%esi),%esi
     f00:	83 c0 01             	add    $0x1,%eax
     f03:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
     f07:	89 c1                	mov    %eax,%ecx
     f09:	75 f5                	jne    f00 <strlen+0x10>
    ;
  return n;
}
     f0b:	89 c8                	mov    %ecx,%eax
     f0d:	5d                   	pop    %ebp
     f0e:	c3                   	ret
     f0f:	90                   	nop
  for(n = 0; s[n]; n++)
     f10:	31 c9                	xor    %ecx,%ecx
}
     f12:	5d                   	pop    %ebp
     f13:	89 c8                	mov    %ecx,%eax
     f15:	c3                   	ret
     f16:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     f1d:	00 
     f1e:	66 90                	xchg   %ax,%ax

00000f20 <memset>:

void*
memset(void *dst, int c, uint n)
{
     f20:	55                   	push   %ebp
     f21:	89 e5                	mov    %esp,%ebp
     f23:	57                   	push   %edi
     f24:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     f27:	8b 4d 10             	mov    0x10(%ebp),%ecx
     f2a:	8b 45 0c             	mov    0xc(%ebp),%eax
     f2d:	89 d7                	mov    %edx,%edi
     f2f:	fc                   	cld
     f30:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     f32:	8b 7d fc             	mov    -0x4(%ebp),%edi
     f35:	89 d0                	mov    %edx,%eax
     f37:	c9                   	leave
     f38:	c3                   	ret
     f39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000f40 <strchr>:

char*
strchr(const char *s, char c)
{
     f40:	55                   	push   %ebp
     f41:	89 e5                	mov    %esp,%ebp
     f43:	8b 45 08             	mov    0x8(%ebp),%eax
     f46:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
     f4a:	0f b6 10             	movzbl (%eax),%edx
     f4d:	84 d2                	test   %dl,%dl
     f4f:	75 12                	jne    f63 <strchr+0x23>
     f51:	eb 1d                	jmp    f70 <strchr+0x30>
     f53:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
     f58:	0f b6 50 01          	movzbl 0x1(%eax),%edx
     f5c:	83 c0 01             	add    $0x1,%eax
     f5f:	84 d2                	test   %dl,%dl
     f61:	74 0d                	je     f70 <strchr+0x30>
    if(*s == c)
     f63:	38 d1                	cmp    %dl,%cl
     f65:	75 f1                	jne    f58 <strchr+0x18>
      return (char*)s;
  return 0;
}
     f67:	5d                   	pop    %ebp
     f68:	c3                   	ret
     f69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
     f70:	31 c0                	xor    %eax,%eax
}
     f72:	5d                   	pop    %ebp
     f73:	c3                   	ret
     f74:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     f7b:	00 
     f7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000f80 <gets>:

char*
gets(char *buf, int max)
{
     f80:	55                   	push   %ebp
     f81:	89 e5                	mov    %esp,%ebp
     f83:	57                   	push   %edi
     f84:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
     f85:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
     f88:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
     f89:	31 db                	xor    %ebx,%ebx
{
     f8b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
     f8e:	eb 27                	jmp    fb7 <gets+0x37>
    cc = read(0, &c, 1);
     f90:	83 ec 04             	sub    $0x4,%esp
     f93:	6a 01                	push   $0x1
     f95:	56                   	push   %esi
     f96:	6a 00                	push   $0x0
     f98:	e8 1e 01 00 00       	call   10bb <read>
    if(cc < 1)
     f9d:	83 c4 10             	add    $0x10,%esp
     fa0:	85 c0                	test   %eax,%eax
     fa2:	7e 1d                	jle    fc1 <gets+0x41>
      break;
    buf[i++] = c;
     fa4:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     fa8:	8b 55 08             	mov    0x8(%ebp),%edx
     fab:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
     faf:	3c 0a                	cmp    $0xa,%al
     fb1:	74 10                	je     fc3 <gets+0x43>
     fb3:	3c 0d                	cmp    $0xd,%al
     fb5:	74 0c                	je     fc3 <gets+0x43>
  for(i=0; i+1 < max; ){
     fb7:	89 df                	mov    %ebx,%edi
     fb9:	83 c3 01             	add    $0x1,%ebx
     fbc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     fbf:	7c cf                	jl     f90 <gets+0x10>
     fc1:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
     fc3:	8b 45 08             	mov    0x8(%ebp),%eax
     fc6:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
     fca:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fcd:	5b                   	pop    %ebx
     fce:	5e                   	pop    %esi
     fcf:	5f                   	pop    %edi
     fd0:	5d                   	pop    %ebp
     fd1:	c3                   	ret
     fd2:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
     fd9:	00 
     fda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000fe0 <stat>:

int
stat(const char *n, struct stat *st)
{
     fe0:	55                   	push   %ebp
     fe1:	89 e5                	mov    %esp,%ebp
     fe3:	56                   	push   %esi
     fe4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     fe5:	83 ec 08             	sub    $0x8,%esp
     fe8:	6a 00                	push   $0x0
     fea:	ff 75 08             	push   0x8(%ebp)
     fed:	e8 f1 00 00 00       	call   10e3 <open>
  if(fd < 0)
     ff2:	83 c4 10             	add    $0x10,%esp
     ff5:	85 c0                	test   %eax,%eax
     ff7:	78 27                	js     1020 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     ff9:	83 ec 08             	sub    $0x8,%esp
     ffc:	ff 75 0c             	push   0xc(%ebp)
     fff:	89 c3                	mov    %eax,%ebx
    1001:	50                   	push   %eax
    1002:	e8 f4 00 00 00       	call   10fb <fstat>
  close(fd);
    1007:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    100a:	89 c6                	mov    %eax,%esi
  close(fd);
    100c:	e8 ba 00 00 00       	call   10cb <close>
  return r;
    1011:	83 c4 10             	add    $0x10,%esp
}
    1014:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1017:	89 f0                	mov    %esi,%eax
    1019:	5b                   	pop    %ebx
    101a:	5e                   	pop    %esi
    101b:	5d                   	pop    %ebp
    101c:	c3                   	ret
    101d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1020:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1025:	eb ed                	jmp    1014 <stat+0x34>
    1027:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    102e:	00 
    102f:	90                   	nop

00001030 <atoi>:

int
atoi(const char *s)
{
    1030:	55                   	push   %ebp
    1031:	89 e5                	mov    %esp,%ebp
    1033:	53                   	push   %ebx
    1034:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1037:	0f be 02             	movsbl (%edx),%eax
    103a:	8d 48 d0             	lea    -0x30(%eax),%ecx
    103d:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
    1040:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
    1045:	77 1e                	ja     1065 <atoi+0x35>
    1047:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    104e:	00 
    104f:	90                   	nop
    n = n*10 + *s++ - '0';
    1050:	83 c2 01             	add    $0x1,%edx
    1053:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
    1056:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
    105a:	0f be 02             	movsbl (%edx),%eax
    105d:	8d 58 d0             	lea    -0x30(%eax),%ebx
    1060:	80 fb 09             	cmp    $0x9,%bl
    1063:	76 eb                	jbe    1050 <atoi+0x20>
  return n;
}
    1065:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1068:	89 c8                	mov    %ecx,%eax
    106a:	c9                   	leave
    106b:	c3                   	ret
    106c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001070 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1070:	55                   	push   %ebp
    1071:	89 e5                	mov    %esp,%ebp
    1073:	57                   	push   %edi
    1074:	8b 45 10             	mov    0x10(%ebp),%eax
    1077:	8b 55 08             	mov    0x8(%ebp),%edx
    107a:	56                   	push   %esi
    107b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    107e:	85 c0                	test   %eax,%eax
    1080:	7e 13                	jle    1095 <memmove+0x25>
    1082:	01 d0                	add    %edx,%eax
  dst = vdst;
    1084:	89 d7                	mov    %edx,%edi
    1086:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    108d:	00 
    108e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
    1090:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
    1091:	39 f8                	cmp    %edi,%eax
    1093:	75 fb                	jne    1090 <memmove+0x20>
  return vdst;
}
    1095:	5e                   	pop    %esi
    1096:	89 d0                	mov    %edx,%eax
    1098:	5f                   	pop    %edi
    1099:	5d                   	pop    %ebp
    109a:	c3                   	ret

0000109b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    109b:	b8 01 00 00 00       	mov    $0x1,%eax
    10a0:	cd 40                	int    $0x40
    10a2:	c3                   	ret

000010a3 <exit>:
SYSCALL(exit)
    10a3:	b8 02 00 00 00       	mov    $0x2,%eax
    10a8:	cd 40                	int    $0x40
    10aa:	c3                   	ret

000010ab <wait>:
SYSCALL(wait)
    10ab:	b8 03 00 00 00       	mov    $0x3,%eax
    10b0:	cd 40                	int    $0x40
    10b2:	c3                   	ret

000010b3 <pipe>:
SYSCALL(pipe)
    10b3:	b8 04 00 00 00       	mov    $0x4,%eax
    10b8:	cd 40                	int    $0x40
    10ba:	c3                   	ret

000010bb <read>:
SYSCALL(read)
    10bb:	b8 05 00 00 00       	mov    $0x5,%eax
    10c0:	cd 40                	int    $0x40
    10c2:	c3                   	ret

000010c3 <write>:
SYSCALL(write)
    10c3:	b8 10 00 00 00       	mov    $0x10,%eax
    10c8:	cd 40                	int    $0x40
    10ca:	c3                   	ret

000010cb <close>:
SYSCALL(close)
    10cb:	b8 15 00 00 00       	mov    $0x15,%eax
    10d0:	cd 40                	int    $0x40
    10d2:	c3                   	ret

000010d3 <kill>:
SYSCALL(kill)
    10d3:	b8 06 00 00 00       	mov    $0x6,%eax
    10d8:	cd 40                	int    $0x40
    10da:	c3                   	ret

000010db <exec>:
SYSCALL(exec)
    10db:	b8 07 00 00 00       	mov    $0x7,%eax
    10e0:	cd 40                	int    $0x40
    10e2:	c3                   	ret

000010e3 <open>:
SYSCALL(open)
    10e3:	b8 0f 00 00 00       	mov    $0xf,%eax
    10e8:	cd 40                	int    $0x40
    10ea:	c3                   	ret

000010eb <mknod>:
SYSCALL(mknod)
    10eb:	b8 11 00 00 00       	mov    $0x11,%eax
    10f0:	cd 40                	int    $0x40
    10f2:	c3                   	ret

000010f3 <unlink>:
SYSCALL(unlink)
    10f3:	b8 12 00 00 00       	mov    $0x12,%eax
    10f8:	cd 40                	int    $0x40
    10fa:	c3                   	ret

000010fb <fstat>:
SYSCALL(fstat)
    10fb:	b8 08 00 00 00       	mov    $0x8,%eax
    1100:	cd 40                	int    $0x40
    1102:	c3                   	ret

00001103 <link>:
SYSCALL(link)
    1103:	b8 13 00 00 00       	mov    $0x13,%eax
    1108:	cd 40                	int    $0x40
    110a:	c3                   	ret

0000110b <mkdir>:
SYSCALL(mkdir)
    110b:	b8 14 00 00 00       	mov    $0x14,%eax
    1110:	cd 40                	int    $0x40
    1112:	c3                   	ret

00001113 <chdir>:
SYSCALL(chdir)
    1113:	b8 09 00 00 00       	mov    $0x9,%eax
    1118:	cd 40                	int    $0x40
    111a:	c3                   	ret

0000111b <dup>:
SYSCALL(dup)
    111b:	b8 0a 00 00 00       	mov    $0xa,%eax
    1120:	cd 40                	int    $0x40
    1122:	c3                   	ret

00001123 <getpid>:
SYSCALL(getpid)
    1123:	b8 0b 00 00 00       	mov    $0xb,%eax
    1128:	cd 40                	int    $0x40
    112a:	c3                   	ret

0000112b <sbrk>:
SYSCALL(sbrk)
    112b:	b8 0c 00 00 00       	mov    $0xc,%eax
    1130:	cd 40                	int    $0x40
    1132:	c3                   	ret

00001133 <sleep>:
SYSCALL(sleep)
    1133:	b8 0d 00 00 00       	mov    $0xd,%eax
    1138:	cd 40                	int    $0x40
    113a:	c3                   	ret

0000113b <uptime>:
SYSCALL(uptime)
    113b:	b8 0e 00 00 00       	mov    $0xe,%eax
    1140:	cd 40                	int    $0x40
    1142:	c3                   	ret
    1143:	66 90                	xchg   %ax,%ax
    1145:	66 90                	xchg   %ax,%ax
    1147:	66 90                	xchg   %ax,%ax
    1149:	66 90                	xchg   %ax,%ax
    114b:	66 90                	xchg   %ax,%ax
    114d:	66 90                	xchg   %ax,%ax
    114f:	90                   	nop

00001150 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	57                   	push   %edi
    1154:	56                   	push   %esi
    1155:	53                   	push   %ebx
    1156:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    1158:	89 d1                	mov    %edx,%ecx
{
    115a:	83 ec 3c             	sub    $0x3c,%esp
    115d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
    1160:	85 d2                	test   %edx,%edx
    1162:	0f 89 80 00 00 00    	jns    11e8 <printint+0x98>
    1168:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    116c:	74 7a                	je     11e8 <printint+0x98>
    x = -xx;
    116e:	f7 d9                	neg    %ecx
    neg = 1;
    1170:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
    1175:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    1178:	31 f6                	xor    %esi,%esi
    117a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
    1180:	89 c8                	mov    %ecx,%eax
    1182:	31 d2                	xor    %edx,%edx
    1184:	89 f7                	mov    %esi,%edi
    1186:	f7 f3                	div    %ebx
    1188:	8d 76 01             	lea    0x1(%esi),%esi
    118b:	0f b6 92 94 16 00 00 	movzbl 0x1694(%edx),%edx
    1192:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
    1196:	89 ca                	mov    %ecx,%edx
    1198:	89 c1                	mov    %eax,%ecx
    119a:	39 da                	cmp    %ebx,%edx
    119c:	73 e2                	jae    1180 <printint+0x30>
  if(neg)
    119e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    11a1:	85 c0                	test   %eax,%eax
    11a3:	74 07                	je     11ac <printint+0x5c>
    buf[i++] = '-';
    11a5:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
    11aa:	89 f7                	mov    %esi,%edi
    11ac:	8d 5d d8             	lea    -0x28(%ebp),%ebx
    11af:	8b 75 c0             	mov    -0x40(%ebp),%esi
    11b2:	01 df                	add    %ebx,%edi
    11b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
    11b8:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
    11bb:	83 ec 04             	sub    $0x4,%esp
    11be:	88 45 d7             	mov    %al,-0x29(%ebp)
    11c1:	8d 45 d7             	lea    -0x29(%ebp),%eax
    11c4:	6a 01                	push   $0x1
    11c6:	50                   	push   %eax
    11c7:	56                   	push   %esi
    11c8:	e8 f6 fe ff ff       	call   10c3 <write>
  while(--i >= 0)
    11cd:	89 f8                	mov    %edi,%eax
    11cf:	83 c4 10             	add    $0x10,%esp
    11d2:	83 ef 01             	sub    $0x1,%edi
    11d5:	39 c3                	cmp    %eax,%ebx
    11d7:	75 df                	jne    11b8 <printint+0x68>
}
    11d9:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11dc:	5b                   	pop    %ebx
    11dd:	5e                   	pop    %esi
    11de:	5f                   	pop    %edi
    11df:	5d                   	pop    %ebp
    11e0:	c3                   	ret
    11e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    11e8:	31 c0                	xor    %eax,%eax
    11ea:	eb 89                	jmp    1175 <printint+0x25>
    11ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000011f0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    11f0:	55                   	push   %ebp
    11f1:	89 e5                	mov    %esp,%ebp
    11f3:	57                   	push   %edi
    11f4:	56                   	push   %esi
    11f5:	53                   	push   %ebx
    11f6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    11f9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
    11fc:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
    11ff:	0f b6 1e             	movzbl (%esi),%ebx
    1202:	83 c6 01             	add    $0x1,%esi
    1205:	84 db                	test   %bl,%bl
    1207:	74 67                	je     1270 <printf+0x80>
    1209:	8d 4d 10             	lea    0x10(%ebp),%ecx
    120c:	31 d2                	xor    %edx,%edx
    120e:	89 4d d0             	mov    %ecx,-0x30(%ebp)
    1211:	eb 34                	jmp    1247 <printf+0x57>
    1213:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
    1218:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    121b:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
    1220:	83 f8 25             	cmp    $0x25,%eax
    1223:	74 18                	je     123d <printf+0x4d>
  write(fd, &c, 1);
    1225:	83 ec 04             	sub    $0x4,%esp
    1228:	8d 45 e7             	lea    -0x19(%ebp),%eax
    122b:	88 5d e7             	mov    %bl,-0x19(%ebp)
    122e:	6a 01                	push   $0x1
    1230:	50                   	push   %eax
    1231:	57                   	push   %edi
    1232:	e8 8c fe ff ff       	call   10c3 <write>
    1237:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
    123a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    123d:	0f b6 1e             	movzbl (%esi),%ebx
    1240:	83 c6 01             	add    $0x1,%esi
    1243:	84 db                	test   %bl,%bl
    1245:	74 29                	je     1270 <printf+0x80>
    c = fmt[i] & 0xff;
    1247:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    124a:	85 d2                	test   %edx,%edx
    124c:	74 ca                	je     1218 <printf+0x28>
      }
    } else if(state == '%'){
    124e:	83 fa 25             	cmp    $0x25,%edx
    1251:	75 ea                	jne    123d <printf+0x4d>
      if(c == 'd'){
    1253:	83 f8 25             	cmp    $0x25,%eax
    1256:	0f 84 04 01 00 00    	je     1360 <printf+0x170>
    125c:	83 e8 63             	sub    $0x63,%eax
    125f:	83 f8 15             	cmp    $0x15,%eax
    1262:	77 1c                	ja     1280 <printf+0x90>
    1264:	ff 24 85 3c 16 00 00 	jmp    *0x163c(,%eax,4)
    126b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    1270:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1273:	5b                   	pop    %ebx
    1274:	5e                   	pop    %esi
    1275:	5f                   	pop    %edi
    1276:	5d                   	pop    %ebp
    1277:	c3                   	ret
    1278:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    127f:	00 
  write(fd, &c, 1);
    1280:	83 ec 04             	sub    $0x4,%esp
    1283:	8d 55 e7             	lea    -0x19(%ebp),%edx
    1286:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    128a:	6a 01                	push   $0x1
    128c:	52                   	push   %edx
    128d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    1290:	57                   	push   %edi
    1291:	e8 2d fe ff ff       	call   10c3 <write>
    1296:	83 c4 0c             	add    $0xc,%esp
    1299:	88 5d e7             	mov    %bl,-0x19(%ebp)
    129c:	6a 01                	push   $0x1
    129e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
    12a1:	52                   	push   %edx
    12a2:	57                   	push   %edi
    12a3:	e8 1b fe ff ff       	call   10c3 <write>
        putc(fd, c);
    12a8:	83 c4 10             	add    $0x10,%esp
      state = 0;
    12ab:	31 d2                	xor    %edx,%edx
    12ad:	eb 8e                	jmp    123d <printf+0x4d>
    12af:	90                   	nop
        printint(fd, *ap, 16, 0);
    12b0:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    12b3:	83 ec 0c             	sub    $0xc,%esp
    12b6:	b9 10 00 00 00       	mov    $0x10,%ecx
    12bb:	8b 13                	mov    (%ebx),%edx
    12bd:	6a 00                	push   $0x0
    12bf:	89 f8                	mov    %edi,%eax
        ap++;
    12c1:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
    12c4:	e8 87 fe ff ff       	call   1150 <printint>
        ap++;
    12c9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    12cc:	83 c4 10             	add    $0x10,%esp
      state = 0;
    12cf:	31 d2                	xor    %edx,%edx
    12d1:	e9 67 ff ff ff       	jmp    123d <printf+0x4d>
        s = (char*)*ap;
    12d6:	8b 45 d0             	mov    -0x30(%ebp),%eax
    12d9:	8b 18                	mov    (%eax),%ebx
        ap++;
    12db:	83 c0 04             	add    $0x4,%eax
    12de:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
    12e1:	85 db                	test   %ebx,%ebx
    12e3:	0f 84 87 00 00 00    	je     1370 <printf+0x180>
        while(*s != 0){
    12e9:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
    12ec:	31 d2                	xor    %edx,%edx
        while(*s != 0){
    12ee:	84 c0                	test   %al,%al
    12f0:	0f 84 47 ff ff ff    	je     123d <printf+0x4d>
    12f6:	8d 55 e7             	lea    -0x19(%ebp),%edx
    12f9:	89 75 d4             	mov    %esi,-0x2c(%ebp)
    12fc:	89 de                	mov    %ebx,%esi
    12fe:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
    1300:	83 ec 04             	sub    $0x4,%esp
    1303:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
    1306:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
    1309:	6a 01                	push   $0x1
    130b:	53                   	push   %ebx
    130c:	57                   	push   %edi
    130d:	e8 b1 fd ff ff       	call   10c3 <write>
        while(*s != 0){
    1312:	0f b6 06             	movzbl (%esi),%eax
    1315:	83 c4 10             	add    $0x10,%esp
    1318:	84 c0                	test   %al,%al
    131a:	75 e4                	jne    1300 <printf+0x110>
      state = 0;
    131c:	8b 75 d4             	mov    -0x2c(%ebp),%esi
    131f:	31 d2                	xor    %edx,%edx
    1321:	e9 17 ff ff ff       	jmp    123d <printf+0x4d>
        printint(fd, *ap, 10, 1);
    1326:	8b 5d d0             	mov    -0x30(%ebp),%ebx
    1329:	83 ec 0c             	sub    $0xc,%esp
    132c:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1331:	8b 13                	mov    (%ebx),%edx
    1333:	6a 01                	push   $0x1
    1335:	eb 88                	jmp    12bf <printf+0xcf>
        putc(fd, *ap);
    1337:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
    133a:	83 ec 04             	sub    $0x4,%esp
    133d:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
    1340:	8b 03                	mov    (%ebx),%eax
        ap++;
    1342:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
    1345:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
    1348:	6a 01                	push   $0x1
    134a:	52                   	push   %edx
    134b:	57                   	push   %edi
    134c:	e8 72 fd ff ff       	call   10c3 <write>
        ap++;
    1351:	89 5d d0             	mov    %ebx,-0x30(%ebp)
    1354:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1357:	31 d2                	xor    %edx,%edx
    1359:	e9 df fe ff ff       	jmp    123d <printf+0x4d>
    135e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
    1360:	83 ec 04             	sub    $0x4,%esp
    1363:	88 5d e7             	mov    %bl,-0x19(%ebp)
    1366:	8d 55 e7             	lea    -0x19(%ebp),%edx
    1369:	6a 01                	push   $0x1
    136b:	e9 31 ff ff ff       	jmp    12a1 <printf+0xb1>
    1370:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
    1375:	bb fe 15 00 00       	mov    $0x15fe,%ebx
    137a:	e9 77 ff ff ff       	jmp    12f6 <printf+0x106>
    137f:	90                   	nop

00001380 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1380:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1381:	a1 04 1e 00 00       	mov    0x1e04,%eax
{
    1386:	89 e5                	mov    %esp,%ebp
    1388:	57                   	push   %edi
    1389:	56                   	push   %esi
    138a:	53                   	push   %ebx
    138b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    138e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1391:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1398:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    139a:	39 c8                	cmp    %ecx,%eax
    139c:	73 32                	jae    13d0 <free+0x50>
    139e:	39 d1                	cmp    %edx,%ecx
    13a0:	72 04                	jb     13a6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    13a2:	39 d0                	cmp    %edx,%eax
    13a4:	72 32                	jb     13d8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    13a6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    13a9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    13ac:	39 fa                	cmp    %edi,%edx
    13ae:	74 30                	je     13e0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
    13b0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    13b3:	8b 50 04             	mov    0x4(%eax),%edx
    13b6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    13b9:	39 f1                	cmp    %esi,%ecx
    13bb:	74 3a                	je     13f7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
    13bd:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
    13bf:	5b                   	pop    %ebx
  freep = p;
    13c0:	a3 04 1e 00 00       	mov    %eax,0x1e04
}
    13c5:	5e                   	pop    %esi
    13c6:	5f                   	pop    %edi
    13c7:	5d                   	pop    %ebp
    13c8:	c3                   	ret
    13c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    13d0:	39 d0                	cmp    %edx,%eax
    13d2:	72 04                	jb     13d8 <free+0x58>
    13d4:	39 d1                	cmp    %edx,%ecx
    13d6:	72 ce                	jb     13a6 <free+0x26>
{
    13d8:	89 d0                	mov    %edx,%eax
    13da:	eb bc                	jmp    1398 <free+0x18>
    13dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    13e0:	03 72 04             	add    0x4(%edx),%esi
    13e3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    13e6:	8b 10                	mov    (%eax),%edx
    13e8:	8b 12                	mov    (%edx),%edx
    13ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    13ed:	8b 50 04             	mov    0x4(%eax),%edx
    13f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    13f3:	39 f1                	cmp    %esi,%ecx
    13f5:	75 c6                	jne    13bd <free+0x3d>
    p->s.size += bp->s.size;
    13f7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    13fa:	a3 04 1e 00 00       	mov    %eax,0x1e04
    p->s.size += bp->s.size;
    13ff:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1402:	8b 4b f8             	mov    -0x8(%ebx),%ecx
    1405:	89 08                	mov    %ecx,(%eax)
}
    1407:	5b                   	pop    %ebx
    1408:	5e                   	pop    %esi
    1409:	5f                   	pop    %edi
    140a:	5d                   	pop    %ebp
    140b:	c3                   	ret
    140c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001410 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1410:	55                   	push   %ebp
    1411:	89 e5                	mov    %esp,%ebp
    1413:	57                   	push   %edi
    1414:	56                   	push   %esi
    1415:	53                   	push   %ebx
    1416:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1419:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    141c:	8b 15 04 1e 00 00    	mov    0x1e04,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1422:	8d 78 07             	lea    0x7(%eax),%edi
    1425:	c1 ef 03             	shr    $0x3,%edi
    1428:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    142b:	85 d2                	test   %edx,%edx
    142d:	0f 84 8d 00 00 00    	je     14c0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1433:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1435:	8b 48 04             	mov    0x4(%eax),%ecx
    1438:	39 f9                	cmp    %edi,%ecx
    143a:	73 64                	jae    14a0 <malloc+0x90>
  if(nu < 4096)
    143c:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1441:	39 df                	cmp    %ebx,%edi
    1443:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    1446:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    144d:	eb 0a                	jmp    1459 <malloc+0x49>
    144f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1450:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    1452:	8b 48 04             	mov    0x4(%eax),%ecx
    1455:	39 f9                	cmp    %edi,%ecx
    1457:	73 47                	jae    14a0 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1459:	89 c2                	mov    %eax,%edx
    145b:	3b 05 04 1e 00 00    	cmp    0x1e04,%eax
    1461:	75 ed                	jne    1450 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
    1463:	83 ec 0c             	sub    $0xc,%esp
    1466:	56                   	push   %esi
    1467:	e8 bf fc ff ff       	call   112b <sbrk>
  if(p == (char*)-1)
    146c:	83 c4 10             	add    $0x10,%esp
    146f:	83 f8 ff             	cmp    $0xffffffff,%eax
    1472:	74 1c                	je     1490 <malloc+0x80>
  hp->s.size = nu;
    1474:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    1477:	83 ec 0c             	sub    $0xc,%esp
    147a:	83 c0 08             	add    $0x8,%eax
    147d:	50                   	push   %eax
    147e:	e8 fd fe ff ff       	call   1380 <free>
  return freep;
    1483:	8b 15 04 1e 00 00    	mov    0x1e04,%edx
      if((p = morecore(nunits)) == 0)
    1489:	83 c4 10             	add    $0x10,%esp
    148c:	85 d2                	test   %edx,%edx
    148e:	75 c0                	jne    1450 <malloc+0x40>
        return 0;
  }
}
    1490:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    1493:	31 c0                	xor    %eax,%eax
}
    1495:	5b                   	pop    %ebx
    1496:	5e                   	pop    %esi
    1497:	5f                   	pop    %edi
    1498:	5d                   	pop    %ebp
    1499:	c3                   	ret
    149a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    14a0:	39 cf                	cmp    %ecx,%edi
    14a2:	74 4c                	je     14f0 <malloc+0xe0>
        p->s.size -= nunits;
    14a4:	29 f9                	sub    %edi,%ecx
    14a6:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    14a9:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    14ac:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    14af:	89 15 04 1e 00 00    	mov    %edx,0x1e04
}
    14b5:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    14b8:	83 c0 08             	add    $0x8,%eax
}
    14bb:	5b                   	pop    %ebx
    14bc:	5e                   	pop    %esi
    14bd:	5f                   	pop    %edi
    14be:	5d                   	pop    %ebp
    14bf:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
    14c0:	c7 05 04 1e 00 00 08 	movl   $0x1e08,0x1e04
    14c7:	1e 00 00 
    base.s.size = 0;
    14ca:	b8 08 1e 00 00       	mov    $0x1e08,%eax
    base.s.ptr = freep = prevp = &base;
    14cf:	c7 05 08 1e 00 00 08 	movl   $0x1e08,0x1e08
    14d6:	1e 00 00 
    base.s.size = 0;
    14d9:	c7 05 0c 1e 00 00 00 	movl   $0x0,0x1e0c
    14e0:	00 00 00 
    if(p->s.size >= nunits){
    14e3:	e9 54 ff ff ff       	jmp    143c <malloc+0x2c>
    14e8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
    14ef:	00 
        prevp->s.ptr = p->s.ptr;
    14f0:	8b 08                	mov    (%eax),%ecx
    14f2:	89 0a                	mov    %ecx,(%edx)
    14f4:	eb b9                	jmp    14af <malloc+0x9f>
