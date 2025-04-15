
_cmos_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"
#include "date.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	31 db                	xor    %ebx,%ebx
  12:	51                   	push   %ecx
  13:	83 ec 40             	sub    $0x40,%esp
  uint start_ticks, end_ticks;
  struct rtcdate time1, time2;
  int i, j, loops = 1000000000;  // Increased loops to be much longer
  
  printf(1, "Testing time measurements...\n");
  16:	68 d8 08 00 00       	push   $0x8d8
  1b:	6a 01                	push   $0x1
  1d:	e8 ae 05 00 00       	call   5d0 <printf>
  printf(1, "Running a busy loop - this will take several seconds...\n");
  22:	5e                   	pop    %esi
  23:	5f                   	pop    %edi
  24:	68 d0 09 00 00       	push   $0x9d0
  29:	6a 01                	push   $0x1
  2b:	e8 a0 05 00 00       	call   5d0 <printf>
  
  // Measure using uptime (ticks)
  start_ticks = uptime();
  30:	e8 b6 04 00 00       	call   4eb <uptime>
  35:	89 c6                	mov    %eax,%esi
  
  // Get starting CMOS time
  if (getcmostime(&time1) < 0) {
  37:	8d 45 b8             	lea    -0x48(%ebp),%eax
  3a:	89 04 24             	mov    %eax,(%esp)
  3d:	e8 e1 04 00 00       	call   523 <getcmostime>
  42:	83 c4 10             	add    $0x10,%esp
  45:	85 c0                	test   %eax,%eax
  47:	79 0f                	jns    58 <main+0x58>
  49:	e9 7f 01 00 00       	jmp    1cd <main+0x1cd>
  4e:	66 90                	xchg   %ax,%ax
    printf(2, "getcmostime failed\n");
    exit();
  }
  
  // Busy loop with nested loops to consume more CPU time
  for(i = 0; i < 50; i++) {
  50:	83 c3 01             	add    $0x1,%ebx
  53:	83 fb 32             	cmp    $0x32,%ebx
  56:	74 29                	je     81 <main+0x81>
    exit();
  58:	69 c3 cd cc cc cc    	imul   $0xcccccccd,%ebx,%eax
  5e:	d1 c8                	ror    $1,%eax
    for(j = 0; j < loops; j++) {
      // Empty nested loop to consume more CPU cycles
    }
    // Print a progress indicator every few iterations
    if(i % 10 == 0) {
  60:	3d 99 99 99 19       	cmp    $0x19999999,%eax
  65:	77 e9                	ja     50 <main+0x50>
      printf(1, ".");
  67:	83 ec 08             	sub    $0x8,%esp
  for(i = 0; i < 50; i++) {
  6a:	83 c3 01             	add    $0x1,%ebx
      printf(1, ".");
  6d:	68 0a 09 00 00       	push   $0x90a
  72:	6a 01                	push   $0x1
  74:	e8 57 05 00 00       	call   5d0 <printf>
  79:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 50; i++) {
  7c:	83 fb 32             	cmp    $0x32,%ebx
  7f:	75 d7                	jne    58 <main+0x58>
    }
  }
  printf(1, "\n");
  81:	83 ec 08             	sub    $0x8,%esp
  84:	68 f4 08 00 00       	push   $0x8f4
  89:	6a 01                	push   $0x1
  8b:	e8 40 05 00 00       	call   5d0 <printf>
  
  // Get ending time
  end_ticks = uptime();
  90:	e8 56 04 00 00       	call   4eb <uptime>
  95:	89 c7                	mov    %eax,%edi
  
  if (getcmostime(&time2) < 0) {
  97:	8d 45 d0             	lea    -0x30(%ebp),%eax
  9a:	89 04 24             	mov    %eax,(%esp)
  9d:	e8 81 04 00 00       	call   523 <getcmostime>
  a2:	83 c4 10             	add    $0x10,%esp
  a5:	85 c0                	test   %eax,%eax
  a7:	0f 88 20 01 00 00    	js     1cd <main+0x1cd>
    printf(2, "getcmostime failed\n");
    exit();
  }
  
  printf(1, "Uptime measurement:\n");
  ad:	50                   	push   %eax
  ae:	50                   	push   %eax
  af:	68 0c 09 00 00       	push   $0x90c
  b4:	6a 01                	push   $0x1
  b6:	e8 15 05 00 00       	call   5d0 <printf>
  printf(1, "  Start: %d ticks\n", start_ticks);
  bb:	83 c4 0c             	add    $0xc,%esp
  be:	56                   	push   %esi
  bf:	68 21 09 00 00       	push   $0x921
  c4:	6a 01                	push   $0x1
  c6:	e8 05 05 00 00       	call   5d0 <printf>
  printf(1, "  End:   %d ticks\n", end_ticks);
  cb:	83 c4 0c             	add    $0xc,%esp
  ce:	57                   	push   %edi
  printf(1, "  Diff:  %d ticks\n", end_ticks - start_ticks);
  cf:	29 f7                	sub    %esi,%edi
  printf(1, "  End:   %d ticks\n", end_ticks);
  d1:	68 34 09 00 00       	push   $0x934
  d6:	6a 01                	push   $0x1
  d8:	e8 f3 04 00 00       	call   5d0 <printf>
  printf(1, "  Diff:  %d ticks\n", end_ticks - start_ticks);
  dd:	83 c4 0c             	add    $0xc,%esp
  e0:	57                   	push   %edi
  e1:	68 47 09 00 00       	push   $0x947
  e6:	6a 01                	push   $0x1
  e8:	e8 e3 04 00 00       	call   5d0 <printf>
  
  printf(1, "\nCMOS time measurement:\n");
  ed:	58                   	pop    %eax
  ee:	5a                   	pop    %edx
  ef:	68 5a 09 00 00       	push   $0x95a
  f4:	6a 01                	push   $0x1
  f6:	e8 d5 04 00 00       	call   5d0 <printf>
  printf(1, "  Start: %d:%d:%d\n", time1.hour, time1.minute, time1.second);
  fb:	59                   	pop    %ecx
  fc:	ff 75 b8             	push   -0x48(%ebp)
  ff:	ff 75 bc             	push   -0x44(%ebp)
 102:	ff 75 c0             	push   -0x40(%ebp)
 105:	68 73 09 00 00       	push   $0x973
 10a:	6a 01                	push   $0x1
 10c:	e8 bf 04 00 00       	call   5d0 <printf>
  printf(1, "  End:   %d:%d:%d\n", time2.hour, time2.minute, time2.second);
 111:	83 c4 14             	add    $0x14,%esp
 114:	ff 75 d0             	push   -0x30(%ebp)
 117:	ff 75 d4             	push   -0x2c(%ebp)
 11a:	ff 75 d8             	push   -0x28(%ebp)
 11d:	68 86 09 00 00       	push   $0x986
 122:	6a 01                	push   $0x1
 124:	e8 a7 04 00 00       	call   5d0 <printf>
  
  // Calculate elapsed seconds
  int start_secs = time1.hour * 3600 + time1.minute * 60 + time1.second;
  int end_secs = time2.hour * 3600 + time2.minute * 60 + time2.second;
 129:	6b 45 d4 3c          	imul   $0x3c,-0x2c(%ebp),%eax
  int elapsed_secs = end_secs - start_secs;
  if (elapsed_secs < 0) {
 12d:	83 c4 20             	add    $0x20,%esp
  int end_secs = time2.hour * 3600 + time2.minute * 60 + time2.second;
 130:	69 5d d8 10 0e 00 00 	imul   $0xe10,-0x28(%ebp),%ebx
  int start_secs = time1.hour * 3600 + time1.minute * 60 + time1.second;
 137:	6b 55 bc 3c          	imul   $0x3c,-0x44(%ebp),%edx
  int end_secs = time2.hour * 3600 + time2.minute * 60 + time2.second;
 13b:	01 c3                	add    %eax,%ebx
  int start_secs = time1.hour * 3600 + time1.minute * 60 + time1.second;
 13d:	69 45 c0 10 0e 00 00 	imul   $0xe10,-0x40(%ebp),%eax
  int end_secs = time2.hour * 3600 + time2.minute * 60 + time2.second;
 144:	03 5d d0             	add    -0x30(%ebp),%ebx
  int start_secs = time1.hour * 3600 + time1.minute * 60 + time1.second;
 147:	01 d0                	add    %edx,%eax
 149:	03 45 b8             	add    -0x48(%ebp),%eax
  if (elapsed_secs < 0) {
 14c:	29 c3                	sub    %eax,%ebx
 14e:	79 06                	jns    156 <main+0x156>
    elapsed_secs += 24 * 3600; // Adjust for day wrap
 150:	81 c3 80 51 01 00    	add    $0x15180,%ebx
  }
  
  printf(1, "  Diff:  %d seconds\n", elapsed_secs);
 156:	50                   	push   %eax
 157:	53                   	push   %ebx
 158:	68 99 09 00 00       	push   $0x999
 15d:	6a 01                	push   $0x1
 15f:	e8 6c 04 00 00       	call   5d0 <printf>
  
  if (elapsed_secs > 0) {
 164:	83 c4 10             	add    $0x10,%esp
 167:	85 db                	test   %ebx,%ebx
 169:	7e 75                	jle    1e0 <main+0x1e0>
    printf(1, "\nEstimated ticks per second: %d\n", (end_ticks - start_ticks) / elapsed_secs);
 16b:	31 d2                	xor    %edx,%edx
 16d:	50                   	push   %eax
 16e:	89 f8                	mov    %edi,%eax
 170:	f7 f3                	div    %ebx
 172:	50                   	push   %eax
 173:	68 0c 0a 00 00       	push   $0xa0c
 178:	6a 01                	push   $0x1
 17a:	e8 51 04 00 00       	call   5d0 <printf>
 17f:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(1, "\nWARNING: The test completed too quickly to measure with second-level granularity.\n");
    printf(1, "Try increasing the loop count for a more meaningful test.\n");
  }
  
  printf(1, "\nDifferences explained:\n");
 182:	50                   	push   %eax
 183:	50                   	push   %eax
 184:	68 ae 09 00 00       	push   $0x9ae
 189:	6a 01                	push   $0x1
 18b:	e8 40 04 00 00       	call   5d0 <printf>
  printf(1, "1. Ticks are based on timer interrupts (typically 100Hz)\n");
 190:	5a                   	pop    %edx
 191:	59                   	pop    %ecx
 192:	68 c0 0a 00 00       	push   $0xac0
 197:	6a 01                	push   $0x1
 199:	e8 32 04 00 00       	call   5d0 <printf>
  printf(1, "2. CMOS time is based on the hardware real-time clock\n");
 19e:	5b                   	pop    %ebx
 19f:	5e                   	pop    %esi
 1a0:	68 fc 0a 00 00       	push   $0xafc
 1a5:	6a 01                	push   $0x1
 1a7:	e8 24 04 00 00       	call   5d0 <printf>
  printf(1, "3. CMOS time has lower precision (1 second) but keeps time across reboots\n");
 1ac:	5f                   	pop    %edi
 1ad:	58                   	pop    %eax
 1ae:	68 34 0b 00 00       	push   $0xb34
 1b3:	6a 01                	push   $0x1
 1b5:	e8 16 04 00 00       	call   5d0 <printf>
  printf(1, "4. Uptime (ticks) is more precise for short intervals\n");
 1ba:	58                   	pop    %eax
 1bb:	5a                   	pop    %edx
 1bc:	68 80 0b 00 00       	push   $0xb80
 1c1:	6a 01                	push   $0x1
 1c3:	e8 08 04 00 00       	call   5d0 <printf>
  
  exit();
 1c8:	e8 86 02 00 00       	call   453 <exit>
    printf(2, "getcmostime failed\n");
 1cd:	53                   	push   %ebx
 1ce:	53                   	push   %ebx
 1cf:	68 f6 08 00 00       	push   $0x8f6
 1d4:	6a 02                	push   $0x2
 1d6:	e8 f5 03 00 00       	call   5d0 <printf>
    exit();
 1db:	e8 73 02 00 00       	call   453 <exit>
    printf(1, "\nWARNING: The test completed too quickly to measure with second-level granularity.\n");
 1e0:	51                   	push   %ecx
 1e1:	51                   	push   %ecx
 1e2:	68 30 0a 00 00       	push   $0xa30
 1e7:	6a 01                	push   $0x1
 1e9:	e8 e2 03 00 00       	call   5d0 <printf>
    printf(1, "Try increasing the loop count for a more meaningful test.\n");
 1ee:	5b                   	pop    %ebx
 1ef:	5e                   	pop    %esi
 1f0:	68 84 0a 00 00       	push   $0xa84
 1f5:	6a 01                	push   $0x1
 1f7:	e8 d4 03 00 00       	call   5d0 <printf>
 1fc:	83 c4 10             	add    $0x10,%esp
 1ff:	eb 81                	jmp    182 <main+0x182>
 201:	66 90                	xchg   %ax,%ax
 203:	66 90                	xchg   %ax,%ax
 205:	66 90                	xchg   %ax,%ax
 207:	66 90                	xchg   %ax,%ax
 209:	66 90                	xchg   %ax,%ax
 20b:	66 90                	xchg   %ax,%ax
 20d:	66 90                	xchg   %ax,%ax
 20f:	90                   	nop

00000210 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 210:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 211:	31 c0                	xor    %eax,%eax
{
 213:	89 e5                	mov    %esp,%ebp
 215:	53                   	push   %ebx
 216:	8b 4d 08             	mov    0x8(%ebp),%ecx
 219:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 220:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 224:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 227:	83 c0 01             	add    $0x1,%eax
 22a:	84 d2                	test   %dl,%dl
 22c:	75 f2                	jne    220 <strcpy+0x10>
    ;
  return os;
}
 22e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 231:	89 c8                	mov    %ecx,%eax
 233:	c9                   	leave
 234:	c3                   	ret
 235:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 23c:	00 
 23d:	8d 76 00             	lea    0x0(%esi),%esi

00000240 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	53                   	push   %ebx
 244:	8b 55 08             	mov    0x8(%ebp),%edx
 247:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 24a:	0f b6 02             	movzbl (%edx),%eax
 24d:	84 c0                	test   %al,%al
 24f:	75 17                	jne    268 <strcmp+0x28>
 251:	eb 3a                	jmp    28d <strcmp+0x4d>
 253:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 258:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 25c:	83 c2 01             	add    $0x1,%edx
 25f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 262:	84 c0                	test   %al,%al
 264:	74 1a                	je     280 <strcmp+0x40>
 266:	89 d9                	mov    %ebx,%ecx
 268:	0f b6 19             	movzbl (%ecx),%ebx
 26b:	38 c3                	cmp    %al,%bl
 26d:	74 e9                	je     258 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 26f:	29 d8                	sub    %ebx,%eax
}
 271:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 274:	c9                   	leave
 275:	c3                   	ret
 276:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 27d:	00 
 27e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 280:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 284:	31 c0                	xor    %eax,%eax
 286:	29 d8                	sub    %ebx,%eax
}
 288:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 28b:	c9                   	leave
 28c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 28d:	0f b6 19             	movzbl (%ecx),%ebx
 290:	31 c0                	xor    %eax,%eax
 292:	eb db                	jmp    26f <strcmp+0x2f>
 294:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 29b:	00 
 29c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000002a0 <strlen>:

uint
strlen(const char *s)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 2a6:	80 3a 00             	cmpb   $0x0,(%edx)
 2a9:	74 15                	je     2c0 <strlen+0x20>
 2ab:	31 c0                	xor    %eax,%eax
 2ad:	8d 76 00             	lea    0x0(%esi),%esi
 2b0:	83 c0 01             	add    $0x1,%eax
 2b3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 2b7:	89 c1                	mov    %eax,%ecx
 2b9:	75 f5                	jne    2b0 <strlen+0x10>
    ;
  return n;
}
 2bb:	89 c8                	mov    %ecx,%eax
 2bd:	5d                   	pop    %ebp
 2be:	c3                   	ret
 2bf:	90                   	nop
  for(n = 0; s[n]; n++)
 2c0:	31 c9                	xor    %ecx,%ecx
}
 2c2:	5d                   	pop    %ebp
 2c3:	89 c8                	mov    %ecx,%eax
 2c5:	c3                   	ret
 2c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2cd:	00 
 2ce:	66 90                	xchg   %ax,%ax

000002d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	57                   	push   %edi
 2d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2da:	8b 45 0c             	mov    0xc(%ebp),%eax
 2dd:	89 d7                	mov    %edx,%edi
 2df:	fc                   	cld
 2e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2e2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 2e5:	89 d0                	mov    %edx,%eax
 2e7:	c9                   	leave
 2e8:	c3                   	ret
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002f0 <strchr>:

char*
strchr(const char *s, char c)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	8b 45 08             	mov    0x8(%ebp),%eax
 2f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 2fa:	0f b6 10             	movzbl (%eax),%edx
 2fd:	84 d2                	test   %dl,%dl
 2ff:	75 12                	jne    313 <strchr+0x23>
 301:	eb 1d                	jmp    320 <strchr+0x30>
 303:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 308:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 30c:	83 c0 01             	add    $0x1,%eax
 30f:	84 d2                	test   %dl,%dl
 311:	74 0d                	je     320 <strchr+0x30>
    if(*s == c)
 313:	38 d1                	cmp    %dl,%cl
 315:	75 f1                	jne    308 <strchr+0x18>
      return (char*)s;
  return 0;
}
 317:	5d                   	pop    %ebp
 318:	c3                   	ret
 319:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 320:	31 c0                	xor    %eax,%eax
}
 322:	5d                   	pop    %ebp
 323:	c3                   	ret
 324:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 32b:	00 
 32c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000330 <gets>:

char*
gets(char *buf, int max)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	57                   	push   %edi
 334:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 335:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 338:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 339:	31 db                	xor    %ebx,%ebx
{
 33b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 33e:	eb 27                	jmp    367 <gets+0x37>
    cc = read(0, &c, 1);
 340:	83 ec 04             	sub    $0x4,%esp
 343:	6a 01                	push   $0x1
 345:	56                   	push   %esi
 346:	6a 00                	push   $0x0
 348:	e8 1e 01 00 00       	call   46b <read>
    if(cc < 1)
 34d:	83 c4 10             	add    $0x10,%esp
 350:	85 c0                	test   %eax,%eax
 352:	7e 1d                	jle    371 <gets+0x41>
      break;
    buf[i++] = c;
 354:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 358:	8b 55 08             	mov    0x8(%ebp),%edx
 35b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 35f:	3c 0a                	cmp    $0xa,%al
 361:	74 10                	je     373 <gets+0x43>
 363:	3c 0d                	cmp    $0xd,%al
 365:	74 0c                	je     373 <gets+0x43>
  for(i=0; i+1 < max; ){
 367:	89 df                	mov    %ebx,%edi
 369:	83 c3 01             	add    $0x1,%ebx
 36c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 36f:	7c cf                	jl     340 <gets+0x10>
 371:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 373:	8b 45 08             	mov    0x8(%ebp),%eax
 376:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 37a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 37d:	5b                   	pop    %ebx
 37e:	5e                   	pop    %esi
 37f:	5f                   	pop    %edi
 380:	5d                   	pop    %ebp
 381:	c3                   	ret
 382:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 389:	00 
 38a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000390 <stat>:

int
stat(const char *n, struct stat *st)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	56                   	push   %esi
 394:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 395:	83 ec 08             	sub    $0x8,%esp
 398:	6a 00                	push   $0x0
 39a:	ff 75 08             	push   0x8(%ebp)
 39d:	e8 f1 00 00 00       	call   493 <open>
  if(fd < 0)
 3a2:	83 c4 10             	add    $0x10,%esp
 3a5:	85 c0                	test   %eax,%eax
 3a7:	78 27                	js     3d0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 3a9:	83 ec 08             	sub    $0x8,%esp
 3ac:	ff 75 0c             	push   0xc(%ebp)
 3af:	89 c3                	mov    %eax,%ebx
 3b1:	50                   	push   %eax
 3b2:	e8 f4 00 00 00       	call   4ab <fstat>
  close(fd);
 3b7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 3ba:	89 c6                	mov    %eax,%esi
  close(fd);
 3bc:	e8 ba 00 00 00       	call   47b <close>
  return r;
 3c1:	83 c4 10             	add    $0x10,%esp
}
 3c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3c7:	89 f0                	mov    %esi,%eax
 3c9:	5b                   	pop    %ebx
 3ca:	5e                   	pop    %esi
 3cb:	5d                   	pop    %ebp
 3cc:	c3                   	ret
 3cd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 3d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 3d5:	eb ed                	jmp    3c4 <stat+0x34>
 3d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3de:	00 
 3df:	90                   	nop

000003e0 <atoi>:

int
atoi(const char *s)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	53                   	push   %ebx
 3e4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3e7:	0f be 02             	movsbl (%edx),%eax
 3ea:	8d 48 d0             	lea    -0x30(%eax),%ecx
 3ed:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 3f0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 3f5:	77 1e                	ja     415 <atoi+0x35>
 3f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3fe:	00 
 3ff:	90                   	nop
    n = n*10 + *s++ - '0';
 400:	83 c2 01             	add    $0x1,%edx
 403:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 406:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 40a:	0f be 02             	movsbl (%edx),%eax
 40d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 410:	80 fb 09             	cmp    $0x9,%bl
 413:	76 eb                	jbe    400 <atoi+0x20>
  return n;
}
 415:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 418:	89 c8                	mov    %ecx,%eax
 41a:	c9                   	leave
 41b:	c3                   	ret
 41c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000420 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	8b 45 10             	mov    0x10(%ebp),%eax
 427:	8b 55 08             	mov    0x8(%ebp),%edx
 42a:	56                   	push   %esi
 42b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 42e:	85 c0                	test   %eax,%eax
 430:	7e 13                	jle    445 <memmove+0x25>
 432:	01 d0                	add    %edx,%eax
  dst = vdst;
 434:	89 d7                	mov    %edx,%edi
 436:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 43d:	00 
 43e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 440:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 441:	39 f8                	cmp    %edi,%eax
 443:	75 fb                	jne    440 <memmove+0x20>
  return vdst;
}
 445:	5e                   	pop    %esi
 446:	89 d0                	mov    %edx,%eax
 448:	5f                   	pop    %edi
 449:	5d                   	pop    %ebp
 44a:	c3                   	ret

0000044b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 44b:	b8 01 00 00 00       	mov    $0x1,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret

00000453 <exit>:
SYSCALL(exit)
 453:	b8 02 00 00 00       	mov    $0x2,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret

0000045b <wait>:
SYSCALL(wait)
 45b:	b8 03 00 00 00       	mov    $0x3,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret

00000463 <pipe>:
SYSCALL(pipe)
 463:	b8 04 00 00 00       	mov    $0x4,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret

0000046b <read>:
SYSCALL(read)
 46b:	b8 05 00 00 00       	mov    $0x5,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret

00000473 <write>:
SYSCALL(write)
 473:	b8 10 00 00 00       	mov    $0x10,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret

0000047b <close>:
SYSCALL(close)
 47b:	b8 15 00 00 00       	mov    $0x15,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret

00000483 <kill>:
SYSCALL(kill)
 483:	b8 06 00 00 00       	mov    $0x6,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret

0000048b <exec>:
SYSCALL(exec)
 48b:	b8 07 00 00 00       	mov    $0x7,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret

00000493 <open>:
SYSCALL(open)
 493:	b8 0f 00 00 00       	mov    $0xf,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret

0000049b <mknod>:
SYSCALL(mknod)
 49b:	b8 11 00 00 00       	mov    $0x11,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret

000004a3 <unlink>:
SYSCALL(unlink)
 4a3:	b8 12 00 00 00       	mov    $0x12,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret

000004ab <fstat>:
SYSCALL(fstat)
 4ab:	b8 08 00 00 00       	mov    $0x8,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret

000004b3 <link>:
SYSCALL(link)
 4b3:	b8 13 00 00 00       	mov    $0x13,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret

000004bb <mkdir>:
SYSCALL(mkdir)
 4bb:	b8 14 00 00 00       	mov    $0x14,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret

000004c3 <chdir>:
SYSCALL(chdir)
 4c3:	b8 09 00 00 00       	mov    $0x9,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret

000004cb <dup>:
SYSCALL(dup)
 4cb:	b8 0a 00 00 00       	mov    $0xa,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret

000004d3 <getpid>:
SYSCALL(getpid)
 4d3:	b8 0b 00 00 00       	mov    $0xb,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret

000004db <sbrk>:
SYSCALL(sbrk)
 4db:	b8 0c 00 00 00       	mov    $0xc,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret

000004e3 <sleep>:
SYSCALL(sleep)
 4e3:	b8 0d 00 00 00       	mov    $0xd,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret

000004eb <uptime>:
SYSCALL(uptime)
 4eb:	b8 0e 00 00 00       	mov    $0xe,%eax
 4f0:	cd 40                	int    $0x40
 4f2:	c3                   	ret

000004f3 <make_user>:
SYSCALL(make_user)
 4f3:	b8 16 00 00 00       	mov    $0x16,%eax
 4f8:	cd 40                	int    $0x40
 4fa:	c3                   	ret

000004fb <login>:
SYSCALL(login)
 4fb:	b8 17 00 00 00       	mov    $0x17,%eax
 500:	cd 40                	int    $0x40
 502:	c3                   	ret

00000503 <logout>:
SYSCALL(logout)
 503:	b8 18 00 00 00       	mov    $0x18,%eax
 508:	cd 40                	int    $0x40
 50a:	c3                   	ret

0000050b <get_log>:
SYSCALL(get_log)
 50b:	b8 19 00 00 00       	mov    $0x19,%eax
 510:	cd 40                	int    $0x40
 512:	c3                   	ret

00000513 <diff>:
SYSCALL(diff)
 513:	b8 1a 00 00 00       	mov    $0x1a,%eax
 518:	cd 40                	int    $0x40
 51a:	c3                   	ret

0000051b <set_sleep>:
SYSCALL(set_sleep)
 51b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 520:	cd 40                	int    $0x40
 522:	c3                   	ret

00000523 <getcmostime>:
 523:	b8 1c 00 00 00       	mov    $0x1c,%eax
 528:	cd 40                	int    $0x40
 52a:	c3                   	ret
 52b:	66 90                	xchg   %ax,%ax
 52d:	66 90                	xchg   %ax,%ax
 52f:	90                   	nop

00000530 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	57                   	push   %edi
 534:	56                   	push   %esi
 535:	53                   	push   %ebx
 536:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 538:	89 d1                	mov    %edx,%ecx
{
 53a:	83 ec 3c             	sub    $0x3c,%esp
 53d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 540:	85 d2                	test   %edx,%edx
 542:	0f 89 80 00 00 00    	jns    5c8 <printint+0x98>
 548:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 54c:	74 7a                	je     5c8 <printint+0x98>
    x = -xx;
 54e:	f7 d9                	neg    %ecx
    neg = 1;
 550:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 555:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 558:	31 f6                	xor    %esi,%esi
 55a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 560:	89 c8                	mov    %ecx,%eax
 562:	31 d2                	xor    %edx,%edx
 564:	89 f7                	mov    %esi,%edi
 566:	f7 f3                	div    %ebx
 568:	8d 76 01             	lea    0x1(%esi),%esi
 56b:	0f b6 92 10 0c 00 00 	movzbl 0xc10(%edx),%edx
 572:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 576:	89 ca                	mov    %ecx,%edx
 578:	89 c1                	mov    %eax,%ecx
 57a:	39 da                	cmp    %ebx,%edx
 57c:	73 e2                	jae    560 <printint+0x30>
  if(neg)
 57e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 581:	85 c0                	test   %eax,%eax
 583:	74 07                	je     58c <printint+0x5c>
    buf[i++] = '-';
 585:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 58a:	89 f7                	mov    %esi,%edi
 58c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 58f:	8b 75 c0             	mov    -0x40(%ebp),%esi
 592:	01 df                	add    %ebx,%edi
 594:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 598:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 59b:	83 ec 04             	sub    $0x4,%esp
 59e:	88 45 d7             	mov    %al,-0x29(%ebp)
 5a1:	8d 45 d7             	lea    -0x29(%ebp),%eax
 5a4:	6a 01                	push   $0x1
 5a6:	50                   	push   %eax
 5a7:	56                   	push   %esi
 5a8:	e8 c6 fe ff ff       	call   473 <write>
  while(--i >= 0)
 5ad:	89 f8                	mov    %edi,%eax
 5af:	83 c4 10             	add    $0x10,%esp
 5b2:	83 ef 01             	sub    $0x1,%edi
 5b5:	39 c3                	cmp    %eax,%ebx
 5b7:	75 df                	jne    598 <printint+0x68>
}
 5b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5bc:	5b                   	pop    %ebx
 5bd:	5e                   	pop    %esi
 5be:	5f                   	pop    %edi
 5bf:	5d                   	pop    %ebp
 5c0:	c3                   	ret
 5c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 5c8:	31 c0                	xor    %eax,%eax
 5ca:	eb 89                	jmp    555 <printint+0x25>
 5cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000005d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5d0:	55                   	push   %ebp
 5d1:	89 e5                	mov    %esp,%ebp
 5d3:	57                   	push   %edi
 5d4:	56                   	push   %esi
 5d5:	53                   	push   %ebx
 5d6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5d9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 5dc:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 5df:	0f b6 1e             	movzbl (%esi),%ebx
 5e2:	83 c6 01             	add    $0x1,%esi
 5e5:	84 db                	test   %bl,%bl
 5e7:	74 67                	je     650 <printf+0x80>
 5e9:	8d 4d 10             	lea    0x10(%ebp),%ecx
 5ec:	31 d2                	xor    %edx,%edx
 5ee:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 5f1:	eb 34                	jmp    627 <printf+0x57>
 5f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 5f8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 5fb:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 600:	83 f8 25             	cmp    $0x25,%eax
 603:	74 18                	je     61d <printf+0x4d>
  write(fd, &c, 1);
 605:	83 ec 04             	sub    $0x4,%esp
 608:	8d 45 e7             	lea    -0x19(%ebp),%eax
 60b:	88 5d e7             	mov    %bl,-0x19(%ebp)
 60e:	6a 01                	push   $0x1
 610:	50                   	push   %eax
 611:	57                   	push   %edi
 612:	e8 5c fe ff ff       	call   473 <write>
 617:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 61a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 61d:	0f b6 1e             	movzbl (%esi),%ebx
 620:	83 c6 01             	add    $0x1,%esi
 623:	84 db                	test   %bl,%bl
 625:	74 29                	je     650 <printf+0x80>
    c = fmt[i] & 0xff;
 627:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 62a:	85 d2                	test   %edx,%edx
 62c:	74 ca                	je     5f8 <printf+0x28>
      }
    } else if(state == '%'){
 62e:	83 fa 25             	cmp    $0x25,%edx
 631:	75 ea                	jne    61d <printf+0x4d>
      if(c == 'd'){
 633:	83 f8 25             	cmp    $0x25,%eax
 636:	0f 84 04 01 00 00    	je     740 <printf+0x170>
 63c:	83 e8 63             	sub    $0x63,%eax
 63f:	83 f8 15             	cmp    $0x15,%eax
 642:	77 1c                	ja     660 <printf+0x90>
 644:	ff 24 85 b8 0b 00 00 	jmp    *0xbb8(,%eax,4)
 64b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 650:	8d 65 f4             	lea    -0xc(%ebp),%esp
 653:	5b                   	pop    %ebx
 654:	5e                   	pop    %esi
 655:	5f                   	pop    %edi
 656:	5d                   	pop    %ebp
 657:	c3                   	ret
 658:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 65f:	00 
  write(fd, &c, 1);
 660:	83 ec 04             	sub    $0x4,%esp
 663:	8d 55 e7             	lea    -0x19(%ebp),%edx
 666:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 66a:	6a 01                	push   $0x1
 66c:	52                   	push   %edx
 66d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 670:	57                   	push   %edi
 671:	e8 fd fd ff ff       	call   473 <write>
 676:	83 c4 0c             	add    $0xc,%esp
 679:	88 5d e7             	mov    %bl,-0x19(%ebp)
 67c:	6a 01                	push   $0x1
 67e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 681:	52                   	push   %edx
 682:	57                   	push   %edi
 683:	e8 eb fd ff ff       	call   473 <write>
        putc(fd, c);
 688:	83 c4 10             	add    $0x10,%esp
      state = 0;
 68b:	31 d2                	xor    %edx,%edx
 68d:	eb 8e                	jmp    61d <printf+0x4d>
 68f:	90                   	nop
        printint(fd, *ap, 16, 0);
 690:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 693:	83 ec 0c             	sub    $0xc,%esp
 696:	b9 10 00 00 00       	mov    $0x10,%ecx
 69b:	8b 13                	mov    (%ebx),%edx
 69d:	6a 00                	push   $0x0
 69f:	89 f8                	mov    %edi,%eax
        ap++;
 6a1:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 6a4:	e8 87 fe ff ff       	call   530 <printint>
        ap++;
 6a9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 6ac:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6af:	31 d2                	xor    %edx,%edx
 6b1:	e9 67 ff ff ff       	jmp    61d <printf+0x4d>
        s = (char*)*ap;
 6b6:	8b 45 d0             	mov    -0x30(%ebp),%eax
 6b9:	8b 18                	mov    (%eax),%ebx
        ap++;
 6bb:	83 c0 04             	add    $0x4,%eax
 6be:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 6c1:	85 db                	test   %ebx,%ebx
 6c3:	0f 84 87 00 00 00    	je     750 <printf+0x180>
        while(*s != 0){
 6c9:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 6cc:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 6ce:	84 c0                	test   %al,%al
 6d0:	0f 84 47 ff ff ff    	je     61d <printf+0x4d>
 6d6:	8d 55 e7             	lea    -0x19(%ebp),%edx
 6d9:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6dc:	89 de                	mov    %ebx,%esi
 6de:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 6e0:	83 ec 04             	sub    $0x4,%esp
 6e3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 6e6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 6e9:	6a 01                	push   $0x1
 6eb:	53                   	push   %ebx
 6ec:	57                   	push   %edi
 6ed:	e8 81 fd ff ff       	call   473 <write>
        while(*s != 0){
 6f2:	0f b6 06             	movzbl (%esi),%eax
 6f5:	83 c4 10             	add    $0x10,%esp
 6f8:	84 c0                	test   %al,%al
 6fa:	75 e4                	jne    6e0 <printf+0x110>
      state = 0;
 6fc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 6ff:	31 d2                	xor    %edx,%edx
 701:	e9 17 ff ff ff       	jmp    61d <printf+0x4d>
        printint(fd, *ap, 10, 1);
 706:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 709:	83 ec 0c             	sub    $0xc,%esp
 70c:	b9 0a 00 00 00       	mov    $0xa,%ecx
 711:	8b 13                	mov    (%ebx),%edx
 713:	6a 01                	push   $0x1
 715:	eb 88                	jmp    69f <printf+0xcf>
        putc(fd, *ap);
 717:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 71a:	83 ec 04             	sub    $0x4,%esp
 71d:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 720:	8b 03                	mov    (%ebx),%eax
        ap++;
 722:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 725:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 728:	6a 01                	push   $0x1
 72a:	52                   	push   %edx
 72b:	57                   	push   %edi
 72c:	e8 42 fd ff ff       	call   473 <write>
        ap++;
 731:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 734:	83 c4 10             	add    $0x10,%esp
      state = 0;
 737:	31 d2                	xor    %edx,%edx
 739:	e9 df fe ff ff       	jmp    61d <printf+0x4d>
 73e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 740:	83 ec 04             	sub    $0x4,%esp
 743:	88 5d e7             	mov    %bl,-0x19(%ebp)
 746:	8d 55 e7             	lea    -0x19(%ebp),%edx
 749:	6a 01                	push   $0x1
 74b:	e9 31 ff ff ff       	jmp    681 <printf+0xb1>
 750:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 755:	bb c7 09 00 00       	mov    $0x9c7,%ebx
 75a:	e9 77 ff ff ff       	jmp    6d6 <printf+0x106>
 75f:	90                   	nop

00000760 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 760:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 761:	a1 bc 0e 00 00       	mov    0xebc,%eax
{
 766:	89 e5                	mov    %esp,%ebp
 768:	57                   	push   %edi
 769:	56                   	push   %esi
 76a:	53                   	push   %ebx
 76b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 76e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 771:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 778:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 77a:	39 c8                	cmp    %ecx,%eax
 77c:	73 32                	jae    7b0 <free+0x50>
 77e:	39 d1                	cmp    %edx,%ecx
 780:	72 04                	jb     786 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 782:	39 d0                	cmp    %edx,%eax
 784:	72 32                	jb     7b8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 786:	8b 73 fc             	mov    -0x4(%ebx),%esi
 789:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 78c:	39 fa                	cmp    %edi,%edx
 78e:	74 30                	je     7c0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 790:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 793:	8b 50 04             	mov    0x4(%eax),%edx
 796:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 799:	39 f1                	cmp    %esi,%ecx
 79b:	74 3a                	je     7d7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 79d:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 79f:	5b                   	pop    %ebx
  freep = p;
 7a0:	a3 bc 0e 00 00       	mov    %eax,0xebc
}
 7a5:	5e                   	pop    %esi
 7a6:	5f                   	pop    %edi
 7a7:	5d                   	pop    %ebp
 7a8:	c3                   	ret
 7a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7b0:	39 d0                	cmp    %edx,%eax
 7b2:	72 04                	jb     7b8 <free+0x58>
 7b4:	39 d1                	cmp    %edx,%ecx
 7b6:	72 ce                	jb     786 <free+0x26>
{
 7b8:	89 d0                	mov    %edx,%eax
 7ba:	eb bc                	jmp    778 <free+0x18>
 7bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 7c0:	03 72 04             	add    0x4(%edx),%esi
 7c3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7c6:	8b 10                	mov    (%eax),%edx
 7c8:	8b 12                	mov    (%edx),%edx
 7ca:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7cd:	8b 50 04             	mov    0x4(%eax),%edx
 7d0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7d3:	39 f1                	cmp    %esi,%ecx
 7d5:	75 c6                	jne    79d <free+0x3d>
    p->s.size += bp->s.size;
 7d7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 7da:	a3 bc 0e 00 00       	mov    %eax,0xebc
    p->s.size += bp->s.size;
 7df:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7e2:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 7e5:	89 08                	mov    %ecx,(%eax)
}
 7e7:	5b                   	pop    %ebx
 7e8:	5e                   	pop    %esi
 7e9:	5f                   	pop    %edi
 7ea:	5d                   	pop    %ebp
 7eb:	c3                   	ret
 7ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7f0:	55                   	push   %ebp
 7f1:	89 e5                	mov    %esp,%ebp
 7f3:	57                   	push   %edi
 7f4:	56                   	push   %esi
 7f5:	53                   	push   %ebx
 7f6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7fc:	8b 15 bc 0e 00 00    	mov    0xebc,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 802:	8d 78 07             	lea    0x7(%eax),%edi
 805:	c1 ef 03             	shr    $0x3,%edi
 808:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 80b:	85 d2                	test   %edx,%edx
 80d:	0f 84 8d 00 00 00    	je     8a0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 813:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 815:	8b 48 04             	mov    0x4(%eax),%ecx
 818:	39 f9                	cmp    %edi,%ecx
 81a:	73 64                	jae    880 <malloc+0x90>
  if(nu < 4096)
 81c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 821:	39 df                	cmp    %ebx,%edi
 823:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 826:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 82d:	eb 0a                	jmp    839 <malloc+0x49>
 82f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 830:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 832:	8b 48 04             	mov    0x4(%eax),%ecx
 835:	39 f9                	cmp    %edi,%ecx
 837:	73 47                	jae    880 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 839:	89 c2                	mov    %eax,%edx
 83b:	3b 05 bc 0e 00 00    	cmp    0xebc,%eax
 841:	75 ed                	jne    830 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 843:	83 ec 0c             	sub    $0xc,%esp
 846:	56                   	push   %esi
 847:	e8 8f fc ff ff       	call   4db <sbrk>
  if(p == (char*)-1)
 84c:	83 c4 10             	add    $0x10,%esp
 84f:	83 f8 ff             	cmp    $0xffffffff,%eax
 852:	74 1c                	je     870 <malloc+0x80>
  hp->s.size = nu;
 854:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 857:	83 ec 0c             	sub    $0xc,%esp
 85a:	83 c0 08             	add    $0x8,%eax
 85d:	50                   	push   %eax
 85e:	e8 fd fe ff ff       	call   760 <free>
  return freep;
 863:	8b 15 bc 0e 00 00    	mov    0xebc,%edx
      if((p = morecore(nunits)) == 0)
 869:	83 c4 10             	add    $0x10,%esp
 86c:	85 d2                	test   %edx,%edx
 86e:	75 c0                	jne    830 <malloc+0x40>
        return 0;
  }
}
 870:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 873:	31 c0                	xor    %eax,%eax
}
 875:	5b                   	pop    %ebx
 876:	5e                   	pop    %esi
 877:	5f                   	pop    %edi
 878:	5d                   	pop    %ebp
 879:	c3                   	ret
 87a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 880:	39 cf                	cmp    %ecx,%edi
 882:	74 4c                	je     8d0 <malloc+0xe0>
        p->s.size -= nunits;
 884:	29 f9                	sub    %edi,%ecx
 886:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 889:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 88c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 88f:	89 15 bc 0e 00 00    	mov    %edx,0xebc
}
 895:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 898:	83 c0 08             	add    $0x8,%eax
}
 89b:	5b                   	pop    %ebx
 89c:	5e                   	pop    %esi
 89d:	5f                   	pop    %edi
 89e:	5d                   	pop    %ebp
 89f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 8a0:	c7 05 bc 0e 00 00 c0 	movl   $0xec0,0xebc
 8a7:	0e 00 00 
    base.s.size = 0;
 8aa:	b8 c0 0e 00 00       	mov    $0xec0,%eax
    base.s.ptr = freep = prevp = &base;
 8af:	c7 05 c0 0e 00 00 c0 	movl   $0xec0,0xec0
 8b6:	0e 00 00 
    base.s.size = 0;
 8b9:	c7 05 c4 0e 00 00 00 	movl   $0x0,0xec4
 8c0:	00 00 00 
    if(p->s.size >= nunits){
 8c3:	e9 54 ff ff ff       	jmp    81c <malloc+0x2c>
 8c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 8cf:	00 
        prevp->s.ptr = p->s.ptr;
 8d0:	8b 08                	mov    (%eax),%ecx
 8d2:	89 0a                	mov    %ecx,(%edx)
 8d4:	eb b9                	jmp    88f <malloc+0x9f>
