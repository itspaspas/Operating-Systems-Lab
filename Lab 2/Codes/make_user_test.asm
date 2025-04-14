
_make_user_test:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	56                   	push   %esi
    int ret;
    printf(1, "hiiiiiii\n");
    printf(1, "Creating users...\n");
  
    ret = make_user(1, "password1");
    printf(1, "Create user 1: %s\n", ret == 0 ? "SUCCESS" : "FAILED");
   e:	be a8 08 00 00       	mov    $0x8a8,%esi
{
  13:	53                   	push   %ebx
  14:	51                   	push   %ecx
  15:	83 ec 14             	sub    $0x14,%esp
    printf(1, "hiiiiiii\n");
  18:	68 b7 08 00 00       	push   $0x8b7
  1d:	6a 01                	push   $0x1
  1f:	e8 7c 05 00 00       	call   5a0 <printf>
    printf(1, "Creating users...\n");
  24:	58                   	pop    %eax
  25:	5a                   	pop    %edx
  26:	68 c1 08 00 00       	push   $0x8c1
  2b:	6a 01                	push   $0x1
  2d:	e8 6e 05 00 00       	call   5a0 <printf>
    ret = make_user(1, "password1");
  32:	59                   	pop    %ecx
  33:	5b                   	pop    %ebx
  34:	68 d4 08 00 00       	push   $0x8d4
  39:	6a 01                	push   $0x1
    printf(1, "Create user 1: %s\n", ret == 0 ? "SUCCESS" : "FAILED");
  3b:	bb b0 08 00 00       	mov    $0x8b0,%ebx
    ret = make_user(1, "password1");
  40:	e8 7e 04 00 00       	call   4c3 <make_user>
    printf(1, "Create user 1: %s\n", ret == 0 ? "SUCCESS" : "FAILED");
  45:	83 c4 0c             	add    $0xc,%esp
  48:	85 c0                	test   %eax,%eax
  4a:	89 f0                	mov    %esi,%eax
  4c:	0f 45 c3             	cmovne %ebx,%eax
  4f:	50                   	push   %eax
  50:	68 de 08 00 00       	push   $0x8de
  55:	6a 01                	push   $0x1
  57:	e8 44 05 00 00       	call   5a0 <printf>
  
    ret = make_user(2, "password2");
  5c:	58                   	pop    %eax
  5d:	5a                   	pop    %edx
  5e:	68 f1 08 00 00       	push   $0x8f1
  63:	6a 02                	push   $0x2
  65:	e8 59 04 00 00       	call   4c3 <make_user>
    printf(1, "Create user 2: %s\n", ret == 0 ? "SUCCESS" : "FAILED");
  6a:	83 c4 0c             	add    $0xc,%esp
  6d:	85 c0                	test   %eax,%eax
  6f:	89 f0                	mov    %esi,%eax
  71:	0f 45 c3             	cmovne %ebx,%eax
  74:	50                   	push   %eax
  75:	68 fb 08 00 00       	push   $0x8fb
  7a:	6a 01                	push   $0x1
  7c:	e8 1f 05 00 00       	call   5a0 <printf>
  
    ret = make_user(1, "password3");
  81:	59                   	pop    %ecx
  82:	58                   	pop    %eax
  83:	68 0e 09 00 00       	push   $0x90e
  88:	6a 01                	push   $0x1
  8a:	e8 34 04 00 00       	call   4c3 <make_user>
  printf(1, "Create duplicate user: %s (expected to fail)\n", ret == 0 ? "SUCCESS" : "FAILED");
  8f:	83 c4 0c             	add    $0xc,%esp
  92:	85 c0                	test   %eax,%eax
  94:	89 f0                	mov    %esi,%eax
  96:	0f 45 c3             	cmovne %ebx,%eax
  99:	50                   	push   %eax
  9a:	68 88 09 00 00       	push   $0x988
  9f:	6a 01                	push   $0x1
  a1:	e8 fa 04 00 00       	call   5a0 <printf>
  
  printf(1, "\nTesting login...\n");
  a6:	58                   	pop    %eax
  a7:	5a                   	pop    %edx
  a8:	68 18 09 00 00       	push   $0x918
  ad:	6a 01                	push   $0x1
  af:	e8 ec 04 00 00       	call   5a0 <printf>
  
  ret = login(1, "password1");
  b4:	59                   	pop    %ecx
  b5:	58                   	pop    %eax
  b6:	68 d4 08 00 00       	push   $0x8d4
  bb:	6a 01                	push   $0x1
  bd:	e8 09 04 00 00       	call   4cb <login>
  printf(1, "Login user 1: %s\n", ret == 0 ? "SUCCESS" : "FAILED");
  c2:	83 c4 0c             	add    $0xc,%esp
  c5:	85 c0                	test   %eax,%eax
  c7:	89 f0                	mov    %esi,%eax
  c9:	0f 45 c3             	cmovne %ebx,%eax
  cc:	50                   	push   %eax
  cd:	68 2b 09 00 00       	push   $0x92b
  d2:	6a 01                	push   $0x1
  d4:	e8 c7 04 00 00       	call   5a0 <printf>
  
  ret = login(2, "password2");
  d9:	58                   	pop    %eax
  da:	5a                   	pop    %edx
  db:	68 f1 08 00 00       	push   $0x8f1
  e0:	6a 02                	push   $0x2
  e2:	e8 e4 03 00 00       	call   4cb <login>
  printf(1, "Login while logged in: %s (expected to fail)\n", ret == 0 ? "SUCCESS" : "FAILED");
  e7:	83 c4 0c             	add    $0xc,%esp
  ea:	85 c0                	test   %eax,%eax
  ec:	89 f0                	mov    %esi,%eax
  ee:	0f 45 c3             	cmovne %ebx,%eax
  f1:	50                   	push   %eax
  f2:	68 b8 09 00 00       	push   $0x9b8
  f7:	6a 01                	push   $0x1
  f9:	e8 a2 04 00 00       	call   5a0 <printf>
  
  printf(1, "\nGetting system call log for current user...\n");
  fe:	59                   	pop    %ecx
  ff:	58                   	pop    %eax
 100:	68 e8 09 00 00       	push   $0x9e8
 105:	6a 01                	push   $0x1
 107:	e8 94 04 00 00       	call   5a0 <printf>
  get_log();
 10c:	e8 ca 03 00 00       	call   4db <get_log>
  
  printf(1, "\nTesting logout...\n");
 111:	58                   	pop    %eax
 112:	5a                   	pop    %edx
 113:	68 3d 09 00 00       	push   $0x93d
 118:	6a 01                	push   $0x1
 11a:	e8 81 04 00 00       	call   5a0 <printf>
  ret = logout();
 11f:	e8 af 03 00 00       	call   4d3 <logout>
  printf(1, "Logout: %s\n", ret == 0 ? "SUCCESS" : "FAILED");
 124:	83 c4 0c             	add    $0xc,%esp
 127:	85 c0                	test   %eax,%eax
 129:	89 f0                	mov    %esi,%eax
 12b:	0f 45 c3             	cmovne %ebx,%eax
 12e:	50                   	push   %eax
 12f:	68 73 09 00 00       	push   $0x973
 134:	6a 01                	push   $0x1
 136:	e8 65 04 00 00       	call   5a0 <printf>
  
  // Login with incorrect password
  ret = login(2, "wrong_password");
 13b:	59                   	pop    %ecx
 13c:	58                   	pop    %eax
 13d:	68 51 09 00 00       	push   $0x951
 142:	6a 02                	push   $0x2
 144:	e8 82 03 00 00       	call   4cb <login>
  printf(1, "Login with wrong password: %s (expected to fail)\n", ret == 0 ? "SUCCESS" : "FAILED");
 149:	83 c4 0c             	add    $0xc,%esp
 14c:	85 c0                	test   %eax,%eax
 14e:	89 f0                	mov    %esi,%eax
 150:	0f 45 c3             	cmovne %ebx,%eax
 153:	50                   	push   %eax
 154:	68 18 0a 00 00       	push   $0xa18
 159:	6a 01                	push   $0x1
 15b:	e8 40 04 00 00       	call   5a0 <printf>
  
  // Login correctly after logout
  ret = login(2, "password2");
 160:	58                   	pop    %eax
 161:	5a                   	pop    %edx
 162:	68 f1 08 00 00       	push   $0x8f1
 167:	6a 02                	push   $0x2
 169:	e8 5d 03 00 00       	call   4cb <login>
  printf(1, "Login user 2: %s\n", ret == 0 ? "SUCCESS" : "FAILED");
 16e:	83 c4 0c             	add    $0xc,%esp
 171:	85 c0                	test   %eax,%eax
 173:	89 f0                	mov    %esi,%eax
 175:	0f 45 c3             	cmovne %ebx,%eax
 178:	50                   	push   %eax
 179:	68 60 09 00 00       	push   $0x960
 17e:	6a 01                	push   $0x1
 180:	e8 1b 04 00 00       	call   5a0 <printf>
  
  // Test get_log again
  printf(1, "\nGetting system call log for user 2...\n");
 185:	59                   	pop    %ecx
 186:	58                   	pop    %eax
 187:	68 4c 0a 00 00       	push   $0xa4c
 18c:	6a 01                	push   $0x1
 18e:	e8 0d 04 00 00       	call   5a0 <printf>
  get_log();
 193:	e8 43 03 00 00       	call   4db <get_log>
  
  // Logout and show global log
  ret = logout();
 198:	e8 36 03 00 00       	call   4d3 <logout>
  printf(1, "\nLogout: %s\n", ret == 0 ? "SUCCESS" : "FAILED");
 19d:	83 c4 0c             	add    $0xc,%esp
 1a0:	85 c0                	test   %eax,%eax
 1a2:	0f 44 de             	cmove  %esi,%ebx
 1a5:	53                   	push   %ebx
 1a6:	68 72 09 00 00       	push   $0x972
 1ab:	6a 01                	push   $0x1
 1ad:	e8 ee 03 00 00       	call   5a0 <printf>
  
  printf(1, "\nGetting global system call log...\n");
 1b2:	58                   	pop    %eax
 1b3:	5a                   	pop    %edx
 1b4:	68 74 0a 00 00       	push   $0xa74
 1b9:	6a 01                	push   $0x1
 1bb:	e8 e0 03 00 00       	call   5a0 <printf>
  get_log();
 1c0:	e8 16 03 00 00       	call   4db <get_log>
  
  printf(1, "\nUser management test complete.\n");
 1c5:	59                   	pop    %ecx
 1c6:	5b                   	pop    %ebx
 1c7:	68 98 0a 00 00       	push   $0xa98
 1cc:	6a 01                	push   $0x1
 1ce:	e8 cd 03 00 00       	call   5a0 <printf>
  exit();
 1d3:	e8 4b 02 00 00       	call   423 <exit>
 1d8:	66 90                	xchg   %ax,%ax
 1da:	66 90                	xchg   %ax,%ax
 1dc:	66 90                	xchg   %ax,%ax
 1de:	66 90                	xchg   %ax,%ax

000001e0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1e0:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 1e1:	31 c0                	xor    %eax,%eax
{
 1e3:	89 e5                	mov    %esp,%ebp
 1e5:	53                   	push   %ebx
 1e6:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1e9:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 1f0:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 1f4:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 1f7:	83 c0 01             	add    $0x1,%eax
 1fa:	84 d2                	test   %dl,%dl
 1fc:	75 f2                	jne    1f0 <strcpy+0x10>
    ;
  return os;
}
 1fe:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 201:	89 c8                	mov    %ecx,%eax
 203:	c9                   	leave
 204:	c3                   	ret
 205:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 20c:	00 
 20d:	8d 76 00             	lea    0x0(%esi),%esi

00000210 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	53                   	push   %ebx
 214:	8b 55 08             	mov    0x8(%ebp),%edx
 217:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 21a:	0f b6 02             	movzbl (%edx),%eax
 21d:	84 c0                	test   %al,%al
 21f:	75 17                	jne    238 <strcmp+0x28>
 221:	eb 3a                	jmp    25d <strcmp+0x4d>
 223:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 228:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 22c:	83 c2 01             	add    $0x1,%edx
 22f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 232:	84 c0                	test   %al,%al
 234:	74 1a                	je     250 <strcmp+0x40>
 236:	89 d9                	mov    %ebx,%ecx
 238:	0f b6 19             	movzbl (%ecx),%ebx
 23b:	38 c3                	cmp    %al,%bl
 23d:	74 e9                	je     228 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 23f:	29 d8                	sub    %ebx,%eax
}
 241:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 244:	c9                   	leave
 245:	c3                   	ret
 246:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 24d:	00 
 24e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 250:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 254:	31 c0                	xor    %eax,%eax
 256:	29 d8                	sub    %ebx,%eax
}
 258:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 25b:	c9                   	leave
 25c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 25d:	0f b6 19             	movzbl (%ecx),%ebx
 260:	31 c0                	xor    %eax,%eax
 262:	eb db                	jmp    23f <strcmp+0x2f>
 264:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 26b:	00 
 26c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000270 <strlen>:

uint
strlen(const char *s)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 276:	80 3a 00             	cmpb   $0x0,(%edx)
 279:	74 15                	je     290 <strlen+0x20>
 27b:	31 c0                	xor    %eax,%eax
 27d:	8d 76 00             	lea    0x0(%esi),%esi
 280:	83 c0 01             	add    $0x1,%eax
 283:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 287:	89 c1                	mov    %eax,%ecx
 289:	75 f5                	jne    280 <strlen+0x10>
    ;
  return n;
}
 28b:	89 c8                	mov    %ecx,%eax
 28d:	5d                   	pop    %ebp
 28e:	c3                   	ret
 28f:	90                   	nop
  for(n = 0; s[n]; n++)
 290:	31 c9                	xor    %ecx,%ecx
}
 292:	5d                   	pop    %ebp
 293:	89 c8                	mov    %ecx,%eax
 295:	c3                   	ret
 296:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 29d:	00 
 29e:	66 90                	xchg   %ax,%ax

000002a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 2a0:	55                   	push   %ebp
 2a1:	89 e5                	mov    %esp,%ebp
 2a3:	57                   	push   %edi
 2a4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 2a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 2aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ad:	89 d7                	mov    %edx,%edi
 2af:	fc                   	cld
 2b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 2b2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 2b5:	89 d0                	mov    %edx,%eax
 2b7:	c9                   	leave
 2b8:	c3                   	ret
 2b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002c0 <strchr>:

char*
strchr(const char *s, char c)
{
 2c0:	55                   	push   %ebp
 2c1:	89 e5                	mov    %esp,%ebp
 2c3:	8b 45 08             	mov    0x8(%ebp),%eax
 2c6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 2ca:	0f b6 10             	movzbl (%eax),%edx
 2cd:	84 d2                	test   %dl,%dl
 2cf:	75 12                	jne    2e3 <strchr+0x23>
 2d1:	eb 1d                	jmp    2f0 <strchr+0x30>
 2d3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 2d8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 2dc:	83 c0 01             	add    $0x1,%eax
 2df:	84 d2                	test   %dl,%dl
 2e1:	74 0d                	je     2f0 <strchr+0x30>
    if(*s == c)
 2e3:	38 d1                	cmp    %dl,%cl
 2e5:	75 f1                	jne    2d8 <strchr+0x18>
      return (char*)s;
  return 0;
}
 2e7:	5d                   	pop    %ebp
 2e8:	c3                   	ret
 2e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 2f0:	31 c0                	xor    %eax,%eax
}
 2f2:	5d                   	pop    %ebp
 2f3:	c3                   	ret
 2f4:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2fb:	00 
 2fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000300 <gets>:

char*
gets(char *buf, int max)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	57                   	push   %edi
 304:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 305:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 308:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 309:	31 db                	xor    %ebx,%ebx
{
 30b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 30e:	eb 27                	jmp    337 <gets+0x37>
    cc = read(0, &c, 1);
 310:	83 ec 04             	sub    $0x4,%esp
 313:	6a 01                	push   $0x1
 315:	56                   	push   %esi
 316:	6a 00                	push   $0x0
 318:	e8 1e 01 00 00       	call   43b <read>
    if(cc < 1)
 31d:	83 c4 10             	add    $0x10,%esp
 320:	85 c0                	test   %eax,%eax
 322:	7e 1d                	jle    341 <gets+0x41>
      break;
    buf[i++] = c;
 324:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 328:	8b 55 08             	mov    0x8(%ebp),%edx
 32b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 32f:	3c 0a                	cmp    $0xa,%al
 331:	74 10                	je     343 <gets+0x43>
 333:	3c 0d                	cmp    $0xd,%al
 335:	74 0c                	je     343 <gets+0x43>
  for(i=0; i+1 < max; ){
 337:	89 df                	mov    %ebx,%edi
 339:	83 c3 01             	add    $0x1,%ebx
 33c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 33f:	7c cf                	jl     310 <gets+0x10>
 341:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 343:	8b 45 08             	mov    0x8(%ebp),%eax
 346:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 34a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 34d:	5b                   	pop    %ebx
 34e:	5e                   	pop    %esi
 34f:	5f                   	pop    %edi
 350:	5d                   	pop    %ebp
 351:	c3                   	ret
 352:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 359:	00 
 35a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000360 <stat>:

int
stat(const char *n, struct stat *st)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	56                   	push   %esi
 364:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 365:	83 ec 08             	sub    $0x8,%esp
 368:	6a 00                	push   $0x0
 36a:	ff 75 08             	push   0x8(%ebp)
 36d:	e8 f1 00 00 00       	call   463 <open>
  if(fd < 0)
 372:	83 c4 10             	add    $0x10,%esp
 375:	85 c0                	test   %eax,%eax
 377:	78 27                	js     3a0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 379:	83 ec 08             	sub    $0x8,%esp
 37c:	ff 75 0c             	push   0xc(%ebp)
 37f:	89 c3                	mov    %eax,%ebx
 381:	50                   	push   %eax
 382:	e8 f4 00 00 00       	call   47b <fstat>
  close(fd);
 387:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 38a:	89 c6                	mov    %eax,%esi
  close(fd);
 38c:	e8 ba 00 00 00       	call   44b <close>
  return r;
 391:	83 c4 10             	add    $0x10,%esp
}
 394:	8d 65 f8             	lea    -0x8(%ebp),%esp
 397:	89 f0                	mov    %esi,%eax
 399:	5b                   	pop    %ebx
 39a:	5e                   	pop    %esi
 39b:	5d                   	pop    %ebp
 39c:	c3                   	ret
 39d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 3a0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 3a5:	eb ed                	jmp    394 <stat+0x34>
 3a7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3ae:	00 
 3af:	90                   	nop

000003b0 <atoi>:

int
atoi(const char *s)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	53                   	push   %ebx
 3b4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3b7:	0f be 02             	movsbl (%edx),%eax
 3ba:	8d 48 d0             	lea    -0x30(%eax),%ecx
 3bd:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 3c0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 3c5:	77 1e                	ja     3e5 <atoi+0x35>
 3c7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 3ce:	00 
 3cf:	90                   	nop
    n = n*10 + *s++ - '0';
 3d0:	83 c2 01             	add    $0x1,%edx
 3d3:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 3d6:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 3da:	0f be 02             	movsbl (%edx),%eax
 3dd:	8d 58 d0             	lea    -0x30(%eax),%ebx
 3e0:	80 fb 09             	cmp    $0x9,%bl
 3e3:	76 eb                	jbe    3d0 <atoi+0x20>
  return n;
}
 3e5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 3e8:	89 c8                	mov    %ecx,%eax
 3ea:	c9                   	leave
 3eb:	c3                   	ret
 3ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000003f0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3f0:	55                   	push   %ebp
 3f1:	89 e5                	mov    %esp,%ebp
 3f3:	57                   	push   %edi
 3f4:	8b 45 10             	mov    0x10(%ebp),%eax
 3f7:	8b 55 08             	mov    0x8(%ebp),%edx
 3fa:	56                   	push   %esi
 3fb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3fe:	85 c0                	test   %eax,%eax
 400:	7e 13                	jle    415 <memmove+0x25>
 402:	01 d0                	add    %edx,%eax
  dst = vdst;
 404:	89 d7                	mov    %edx,%edi
 406:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 40d:	00 
 40e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 410:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 411:	39 f8                	cmp    %edi,%eax
 413:	75 fb                	jne    410 <memmove+0x20>
  return vdst;
}
 415:	5e                   	pop    %esi
 416:	89 d0                	mov    %edx,%eax
 418:	5f                   	pop    %edi
 419:	5d                   	pop    %ebp
 41a:	c3                   	ret

0000041b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 41b:	b8 01 00 00 00       	mov    $0x1,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <exit>:
SYSCALL(exit)
 423:	b8 02 00 00 00       	mov    $0x2,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret

0000042b <wait>:
SYSCALL(wait)
 42b:	b8 03 00 00 00       	mov    $0x3,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret

00000433 <pipe>:
SYSCALL(pipe)
 433:	b8 04 00 00 00       	mov    $0x4,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret

0000043b <read>:
SYSCALL(read)
 43b:	b8 05 00 00 00       	mov    $0x5,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret

00000443 <write>:
SYSCALL(write)
 443:	b8 10 00 00 00       	mov    $0x10,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret

0000044b <close>:
SYSCALL(close)
 44b:	b8 15 00 00 00       	mov    $0x15,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret

00000453 <kill>:
SYSCALL(kill)
 453:	b8 06 00 00 00       	mov    $0x6,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret

0000045b <exec>:
SYSCALL(exec)
 45b:	b8 07 00 00 00       	mov    $0x7,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret

00000463 <open>:
SYSCALL(open)
 463:	b8 0f 00 00 00       	mov    $0xf,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret

0000046b <mknod>:
SYSCALL(mknod)
 46b:	b8 11 00 00 00       	mov    $0x11,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret

00000473 <unlink>:
SYSCALL(unlink)
 473:	b8 12 00 00 00       	mov    $0x12,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret

0000047b <fstat>:
SYSCALL(fstat)
 47b:	b8 08 00 00 00       	mov    $0x8,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret

00000483 <link>:
SYSCALL(link)
 483:	b8 13 00 00 00       	mov    $0x13,%eax
 488:	cd 40                	int    $0x40
 48a:	c3                   	ret

0000048b <mkdir>:
SYSCALL(mkdir)
 48b:	b8 14 00 00 00       	mov    $0x14,%eax
 490:	cd 40                	int    $0x40
 492:	c3                   	ret

00000493 <chdir>:
SYSCALL(chdir)
 493:	b8 09 00 00 00       	mov    $0x9,%eax
 498:	cd 40                	int    $0x40
 49a:	c3                   	ret

0000049b <dup>:
SYSCALL(dup)
 49b:	b8 0a 00 00 00       	mov    $0xa,%eax
 4a0:	cd 40                	int    $0x40
 4a2:	c3                   	ret

000004a3 <getpid>:
SYSCALL(getpid)
 4a3:	b8 0b 00 00 00       	mov    $0xb,%eax
 4a8:	cd 40                	int    $0x40
 4aa:	c3                   	ret

000004ab <sbrk>:
SYSCALL(sbrk)
 4ab:	b8 0c 00 00 00       	mov    $0xc,%eax
 4b0:	cd 40                	int    $0x40
 4b2:	c3                   	ret

000004b3 <sleep>:
SYSCALL(sleep)
 4b3:	b8 0d 00 00 00       	mov    $0xd,%eax
 4b8:	cd 40                	int    $0x40
 4ba:	c3                   	ret

000004bb <uptime>:
SYSCALL(uptime)
 4bb:	b8 0e 00 00 00       	mov    $0xe,%eax
 4c0:	cd 40                	int    $0x40
 4c2:	c3                   	ret

000004c3 <make_user>:
SYSCALL(make_user)
 4c3:	b8 16 00 00 00       	mov    $0x16,%eax
 4c8:	cd 40                	int    $0x40
 4ca:	c3                   	ret

000004cb <login>:
SYSCALL(login)
 4cb:	b8 17 00 00 00       	mov    $0x17,%eax
 4d0:	cd 40                	int    $0x40
 4d2:	c3                   	ret

000004d3 <logout>:
SYSCALL(logout)
 4d3:	b8 18 00 00 00       	mov    $0x18,%eax
 4d8:	cd 40                	int    $0x40
 4da:	c3                   	ret

000004db <get_log>:
SYSCALL(get_log)
 4db:	b8 19 00 00 00       	mov    $0x19,%eax
 4e0:	cd 40                	int    $0x40
 4e2:	c3                   	ret

000004e3 <diff>:
SYSCALL(diff)
 4e3:	b8 1a 00 00 00       	mov    $0x1a,%eax
 4e8:	cd 40                	int    $0x40
 4ea:	c3                   	ret

000004eb <set_sleep>:
SYSCALL(set_sleep)
 4eb:	b8 1b 00 00 00       	mov    $0x1b,%eax
 4f0:	cd 40                	int    $0x40
 4f2:	c3                   	ret

000004f3 <getcmostime>:
 4f3:	b8 1c 00 00 00       	mov    $0x1c,%eax
 4f8:	cd 40                	int    $0x40
 4fa:	c3                   	ret
 4fb:	66 90                	xchg   %ax,%ax
 4fd:	66 90                	xchg   %ax,%ax
 4ff:	90                   	nop

00000500 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 500:	55                   	push   %ebp
 501:	89 e5                	mov    %esp,%ebp
 503:	57                   	push   %edi
 504:	56                   	push   %esi
 505:	53                   	push   %ebx
 506:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 508:	89 d1                	mov    %edx,%ecx
{
 50a:	83 ec 3c             	sub    $0x3c,%esp
 50d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 510:	85 d2                	test   %edx,%edx
 512:	0f 89 80 00 00 00    	jns    598 <printint+0x98>
 518:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 51c:	74 7a                	je     598 <printint+0x98>
    x = -xx;
 51e:	f7 d9                	neg    %ecx
    neg = 1;
 520:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 525:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 528:	31 f6                	xor    %esi,%esi
 52a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 530:	89 c8                	mov    %ecx,%eax
 532:	31 d2                	xor    %edx,%edx
 534:	89 f7                	mov    %esi,%edi
 536:	f7 f3                	div    %ebx
 538:	8d 76 01             	lea    0x1(%esi),%esi
 53b:	0f b6 92 14 0b 00 00 	movzbl 0xb14(%edx),%edx
 542:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 546:	89 ca                	mov    %ecx,%edx
 548:	89 c1                	mov    %eax,%ecx
 54a:	39 da                	cmp    %ebx,%edx
 54c:	73 e2                	jae    530 <printint+0x30>
  if(neg)
 54e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 551:	85 c0                	test   %eax,%eax
 553:	74 07                	je     55c <printint+0x5c>
    buf[i++] = '-';
 555:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 55a:	89 f7                	mov    %esi,%edi
 55c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 55f:	8b 75 c0             	mov    -0x40(%ebp),%esi
 562:	01 df                	add    %ebx,%edi
 564:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 568:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 56b:	83 ec 04             	sub    $0x4,%esp
 56e:	88 45 d7             	mov    %al,-0x29(%ebp)
 571:	8d 45 d7             	lea    -0x29(%ebp),%eax
 574:	6a 01                	push   $0x1
 576:	50                   	push   %eax
 577:	56                   	push   %esi
 578:	e8 c6 fe ff ff       	call   443 <write>
  while(--i >= 0)
 57d:	89 f8                	mov    %edi,%eax
 57f:	83 c4 10             	add    $0x10,%esp
 582:	83 ef 01             	sub    $0x1,%edi
 585:	39 c3                	cmp    %eax,%ebx
 587:	75 df                	jne    568 <printint+0x68>
}
 589:	8d 65 f4             	lea    -0xc(%ebp),%esp
 58c:	5b                   	pop    %ebx
 58d:	5e                   	pop    %esi
 58e:	5f                   	pop    %edi
 58f:	5d                   	pop    %ebp
 590:	c3                   	ret
 591:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 598:	31 c0                	xor    %eax,%eax
 59a:	eb 89                	jmp    525 <printint+0x25>
 59c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000005a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5a0:	55                   	push   %ebp
 5a1:	89 e5                	mov    %esp,%ebp
 5a3:	57                   	push   %edi
 5a4:	56                   	push   %esi
 5a5:	53                   	push   %ebx
 5a6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5a9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 5ac:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 5af:	0f b6 1e             	movzbl (%esi),%ebx
 5b2:	83 c6 01             	add    $0x1,%esi
 5b5:	84 db                	test   %bl,%bl
 5b7:	74 67                	je     620 <printf+0x80>
 5b9:	8d 4d 10             	lea    0x10(%ebp),%ecx
 5bc:	31 d2                	xor    %edx,%edx
 5be:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 5c1:	eb 34                	jmp    5f7 <printf+0x57>
 5c3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 5c8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 5cb:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 5d0:	83 f8 25             	cmp    $0x25,%eax
 5d3:	74 18                	je     5ed <printf+0x4d>
  write(fd, &c, 1);
 5d5:	83 ec 04             	sub    $0x4,%esp
 5d8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5db:	88 5d e7             	mov    %bl,-0x19(%ebp)
 5de:	6a 01                	push   $0x1
 5e0:	50                   	push   %eax
 5e1:	57                   	push   %edi
 5e2:	e8 5c fe ff ff       	call   443 <write>
 5e7:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 5ea:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 5ed:	0f b6 1e             	movzbl (%esi),%ebx
 5f0:	83 c6 01             	add    $0x1,%esi
 5f3:	84 db                	test   %bl,%bl
 5f5:	74 29                	je     620 <printf+0x80>
    c = fmt[i] & 0xff;
 5f7:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 5fa:	85 d2                	test   %edx,%edx
 5fc:	74 ca                	je     5c8 <printf+0x28>
      }
    } else if(state == '%'){
 5fe:	83 fa 25             	cmp    $0x25,%edx
 601:	75 ea                	jne    5ed <printf+0x4d>
      if(c == 'd'){
 603:	83 f8 25             	cmp    $0x25,%eax
 606:	0f 84 04 01 00 00    	je     710 <printf+0x170>
 60c:	83 e8 63             	sub    $0x63,%eax
 60f:	83 f8 15             	cmp    $0x15,%eax
 612:	77 1c                	ja     630 <printf+0x90>
 614:	ff 24 85 bc 0a 00 00 	jmp    *0xabc(,%eax,4)
 61b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 620:	8d 65 f4             	lea    -0xc(%ebp),%esp
 623:	5b                   	pop    %ebx
 624:	5e                   	pop    %esi
 625:	5f                   	pop    %edi
 626:	5d                   	pop    %ebp
 627:	c3                   	ret
 628:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 62f:	00 
  write(fd, &c, 1);
 630:	83 ec 04             	sub    $0x4,%esp
 633:	8d 55 e7             	lea    -0x19(%ebp),%edx
 636:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 63a:	6a 01                	push   $0x1
 63c:	52                   	push   %edx
 63d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 640:	57                   	push   %edi
 641:	e8 fd fd ff ff       	call   443 <write>
 646:	83 c4 0c             	add    $0xc,%esp
 649:	88 5d e7             	mov    %bl,-0x19(%ebp)
 64c:	6a 01                	push   $0x1
 64e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 651:	52                   	push   %edx
 652:	57                   	push   %edi
 653:	e8 eb fd ff ff       	call   443 <write>
        putc(fd, c);
 658:	83 c4 10             	add    $0x10,%esp
      state = 0;
 65b:	31 d2                	xor    %edx,%edx
 65d:	eb 8e                	jmp    5ed <printf+0x4d>
 65f:	90                   	nop
        printint(fd, *ap, 16, 0);
 660:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 663:	83 ec 0c             	sub    $0xc,%esp
 666:	b9 10 00 00 00       	mov    $0x10,%ecx
 66b:	8b 13                	mov    (%ebx),%edx
 66d:	6a 00                	push   $0x0
 66f:	89 f8                	mov    %edi,%eax
        ap++;
 671:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 674:	e8 87 fe ff ff       	call   500 <printint>
        ap++;
 679:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 67c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 67f:	31 d2                	xor    %edx,%edx
 681:	e9 67 ff ff ff       	jmp    5ed <printf+0x4d>
        s = (char*)*ap;
 686:	8b 45 d0             	mov    -0x30(%ebp),%eax
 689:	8b 18                	mov    (%eax),%ebx
        ap++;
 68b:	83 c0 04             	add    $0x4,%eax
 68e:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 691:	85 db                	test   %ebx,%ebx
 693:	0f 84 87 00 00 00    	je     720 <printf+0x180>
        while(*s != 0){
 699:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 69c:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 69e:	84 c0                	test   %al,%al
 6a0:	0f 84 47 ff ff ff    	je     5ed <printf+0x4d>
 6a6:	8d 55 e7             	lea    -0x19(%ebp),%edx
 6a9:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 6ac:	89 de                	mov    %ebx,%esi
 6ae:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 6b0:	83 ec 04             	sub    $0x4,%esp
 6b3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 6b6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 6b9:	6a 01                	push   $0x1
 6bb:	53                   	push   %ebx
 6bc:	57                   	push   %edi
 6bd:	e8 81 fd ff ff       	call   443 <write>
        while(*s != 0){
 6c2:	0f b6 06             	movzbl (%esi),%eax
 6c5:	83 c4 10             	add    $0x10,%esp
 6c8:	84 c0                	test   %al,%al
 6ca:	75 e4                	jne    6b0 <printf+0x110>
      state = 0;
 6cc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 6cf:	31 d2                	xor    %edx,%edx
 6d1:	e9 17 ff ff ff       	jmp    5ed <printf+0x4d>
        printint(fd, *ap, 10, 1);
 6d6:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 6d9:	83 ec 0c             	sub    $0xc,%esp
 6dc:	b9 0a 00 00 00       	mov    $0xa,%ecx
 6e1:	8b 13                	mov    (%ebx),%edx
 6e3:	6a 01                	push   $0x1
 6e5:	eb 88                	jmp    66f <printf+0xcf>
        putc(fd, *ap);
 6e7:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 6ea:	83 ec 04             	sub    $0x4,%esp
 6ed:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 6f0:	8b 03                	mov    (%ebx),%eax
        ap++;
 6f2:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 6f5:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 6f8:	6a 01                	push   $0x1
 6fa:	52                   	push   %edx
 6fb:	57                   	push   %edi
 6fc:	e8 42 fd ff ff       	call   443 <write>
        ap++;
 701:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 704:	83 c4 10             	add    $0x10,%esp
      state = 0;
 707:	31 d2                	xor    %edx,%edx
 709:	e9 df fe ff ff       	jmp    5ed <printf+0x4d>
 70e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 710:	83 ec 04             	sub    $0x4,%esp
 713:	88 5d e7             	mov    %bl,-0x19(%ebp)
 716:	8d 55 e7             	lea    -0x19(%ebp),%edx
 719:	6a 01                	push   $0x1
 71b:	e9 31 ff ff ff       	jmp    651 <printf+0xb1>
 720:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 725:	bb 7f 09 00 00       	mov    $0x97f,%ebx
 72a:	e9 77 ff ff ff       	jmp    6a6 <printf+0x106>
 72f:	90                   	nop

00000730 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 730:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 731:	a1 b8 0d 00 00       	mov    0xdb8,%eax
{
 736:	89 e5                	mov    %esp,%ebp
 738:	57                   	push   %edi
 739:	56                   	push   %esi
 73a:	53                   	push   %ebx
 73b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 73e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 741:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 748:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 74a:	39 c8                	cmp    %ecx,%eax
 74c:	73 32                	jae    780 <free+0x50>
 74e:	39 d1                	cmp    %edx,%ecx
 750:	72 04                	jb     756 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 752:	39 d0                	cmp    %edx,%eax
 754:	72 32                	jb     788 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 756:	8b 73 fc             	mov    -0x4(%ebx),%esi
 759:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 75c:	39 fa                	cmp    %edi,%edx
 75e:	74 30                	je     790 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 760:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 763:	8b 50 04             	mov    0x4(%eax),%edx
 766:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 769:	39 f1                	cmp    %esi,%ecx
 76b:	74 3a                	je     7a7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 76d:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 76f:	5b                   	pop    %ebx
  freep = p;
 770:	a3 b8 0d 00 00       	mov    %eax,0xdb8
}
 775:	5e                   	pop    %esi
 776:	5f                   	pop    %edi
 777:	5d                   	pop    %ebp
 778:	c3                   	ret
 779:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 780:	39 d0                	cmp    %edx,%eax
 782:	72 04                	jb     788 <free+0x58>
 784:	39 d1                	cmp    %edx,%ecx
 786:	72 ce                	jb     756 <free+0x26>
{
 788:	89 d0                	mov    %edx,%eax
 78a:	eb bc                	jmp    748 <free+0x18>
 78c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 790:	03 72 04             	add    0x4(%edx),%esi
 793:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 796:	8b 10                	mov    (%eax),%edx
 798:	8b 12                	mov    (%edx),%edx
 79a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 79d:	8b 50 04             	mov    0x4(%eax),%edx
 7a0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7a3:	39 f1                	cmp    %esi,%ecx
 7a5:	75 c6                	jne    76d <free+0x3d>
    p->s.size += bp->s.size;
 7a7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 7aa:	a3 b8 0d 00 00       	mov    %eax,0xdb8
    p->s.size += bp->s.size;
 7af:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7b2:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 7b5:	89 08                	mov    %ecx,(%eax)
}
 7b7:	5b                   	pop    %ebx
 7b8:	5e                   	pop    %esi
 7b9:	5f                   	pop    %edi
 7ba:	5d                   	pop    %ebp
 7bb:	c3                   	ret
 7bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000007c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7c0:	55                   	push   %ebp
 7c1:	89 e5                	mov    %esp,%ebp
 7c3:	57                   	push   %edi
 7c4:	56                   	push   %esi
 7c5:	53                   	push   %ebx
 7c6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 7cc:	8b 15 b8 0d 00 00    	mov    0xdb8,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7d2:	8d 78 07             	lea    0x7(%eax),%edi
 7d5:	c1 ef 03             	shr    $0x3,%edi
 7d8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 7db:	85 d2                	test   %edx,%edx
 7dd:	0f 84 8d 00 00 00    	je     870 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e3:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 7e5:	8b 48 04             	mov    0x4(%eax),%ecx
 7e8:	39 f9                	cmp    %edi,%ecx
 7ea:	73 64                	jae    850 <malloc+0x90>
  if(nu < 4096)
 7ec:	bb 00 10 00 00       	mov    $0x1000,%ebx
 7f1:	39 df                	cmp    %ebx,%edi
 7f3:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 7f6:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 7fd:	eb 0a                	jmp    809 <malloc+0x49>
 7ff:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 800:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 802:	8b 48 04             	mov    0x4(%eax),%ecx
 805:	39 f9                	cmp    %edi,%ecx
 807:	73 47                	jae    850 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 809:	89 c2                	mov    %eax,%edx
 80b:	3b 05 b8 0d 00 00    	cmp    0xdb8,%eax
 811:	75 ed                	jne    800 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 813:	83 ec 0c             	sub    $0xc,%esp
 816:	56                   	push   %esi
 817:	e8 8f fc ff ff       	call   4ab <sbrk>
  if(p == (char*)-1)
 81c:	83 c4 10             	add    $0x10,%esp
 81f:	83 f8 ff             	cmp    $0xffffffff,%eax
 822:	74 1c                	je     840 <malloc+0x80>
  hp->s.size = nu;
 824:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 827:	83 ec 0c             	sub    $0xc,%esp
 82a:	83 c0 08             	add    $0x8,%eax
 82d:	50                   	push   %eax
 82e:	e8 fd fe ff ff       	call   730 <free>
  return freep;
 833:	8b 15 b8 0d 00 00    	mov    0xdb8,%edx
      if((p = morecore(nunits)) == 0)
 839:	83 c4 10             	add    $0x10,%esp
 83c:	85 d2                	test   %edx,%edx
 83e:	75 c0                	jne    800 <malloc+0x40>
        return 0;
  }
}
 840:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 843:	31 c0                	xor    %eax,%eax
}
 845:	5b                   	pop    %ebx
 846:	5e                   	pop    %esi
 847:	5f                   	pop    %edi
 848:	5d                   	pop    %ebp
 849:	c3                   	ret
 84a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 850:	39 cf                	cmp    %ecx,%edi
 852:	74 4c                	je     8a0 <malloc+0xe0>
        p->s.size -= nunits;
 854:	29 f9                	sub    %edi,%ecx
 856:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 859:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 85c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 85f:	89 15 b8 0d 00 00    	mov    %edx,0xdb8
}
 865:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 868:	83 c0 08             	add    $0x8,%eax
}
 86b:	5b                   	pop    %ebx
 86c:	5e                   	pop    %esi
 86d:	5f                   	pop    %edi
 86e:	5d                   	pop    %ebp
 86f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 870:	c7 05 b8 0d 00 00 bc 	movl   $0xdbc,0xdb8
 877:	0d 00 00 
    base.s.size = 0;
 87a:	b8 bc 0d 00 00       	mov    $0xdbc,%eax
    base.s.ptr = freep = prevp = &base;
 87f:	c7 05 bc 0d 00 00 bc 	movl   $0xdbc,0xdbc
 886:	0d 00 00 
    base.s.size = 0;
 889:	c7 05 c0 0d 00 00 00 	movl   $0x0,0xdc0
 890:	00 00 00 
    if(p->s.size >= nunits){
 893:	e9 54 ff ff ff       	jmp    7ec <malloc+0x2c>
 898:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 89f:	00 
        prevp->s.ptr = p->s.ptr;
 8a0:	8b 08                	mov    (%eax),%ecx
 8a2:	89 0a                	mov    %ecx,(%edx)
 8a4:	eb b9                	jmp    85f <malloc+0x9f>
