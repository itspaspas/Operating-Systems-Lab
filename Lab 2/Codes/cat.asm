
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  }
}

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
   f:	be 01 00 00 00       	mov    $0x1,%esi
  14:	53                   	push   %ebx
  15:	51                   	push   %ecx
  16:	83 ec 18             	sub    $0x18,%esp
  19:	8b 01                	mov    (%ecx),%eax
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  21:	83 c3 04             	add    $0x4,%ebx
  int fd, i;

  if(argc <= 1){
  24:	83 f8 01             	cmp    $0x1,%eax
  27:	7f 26                	jg     4f <main+0x4f>
  29:	eb 52                	jmp    7d <main+0x7d>
  2b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  30:	83 ec 0c             	sub    $0xc,%esp
  for(i = 1; i < argc; i++){
  33:	83 c6 01             	add    $0x1,%esi
  36:	83 c3 04             	add    $0x4,%ebx
    cat(fd);
  39:	50                   	push   %eax
  3a:	e8 51 00 00 00       	call   90 <cat>
    close(fd);
  3f:	89 3c 24             	mov    %edi,(%esp)
  42:	e8 34 03 00 00       	call   37b <close>
  for(i = 1; i < argc; i++){
  47:	83 c4 10             	add    $0x10,%esp
  4a:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  4d:	74 29                	je     78 <main+0x78>
    if((fd = open(argv[i], 0)) < 0){
  4f:	83 ec 08             	sub    $0x8,%esp
  52:	6a 00                	push   $0x0
  54:	ff 33                	push   (%ebx)
  56:	e8 38 03 00 00       	call   393 <open>
  5b:	83 c4 10             	add    $0x10,%esp
  5e:	89 c7                	mov    %eax,%edi
  60:	85 c0                	test   %eax,%eax
  62:	79 cc                	jns    30 <main+0x30>
      printf(1, "cat: cannot open %s\n", argv[i]);
  64:	50                   	push   %eax
  65:	ff 33                	push   (%ebx)
  67:	68 fb 07 00 00       	push   $0x7fb
  6c:	6a 01                	push   $0x1
  6e:	e8 5d 04 00 00       	call   4d0 <printf>
      exit();
  73:	e8 db 02 00 00       	call   353 <exit>
  }
  exit();
  78:	e8 d6 02 00 00       	call   353 <exit>
    cat(0);
  7d:	83 ec 0c             	sub    $0xc,%esp
  80:	6a 00                	push   $0x0
  82:	e8 09 00 00 00       	call   90 <cat>
    exit();
  87:	e8 c7 02 00 00       	call   353 <exit>
  8c:	66 90                	xchg   %ax,%ax
  8e:	66 90                	xchg   %ax,%ax

00000090 <cat>:
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	56                   	push   %esi
  94:	53                   	push   %ebx
  95:	8b 75 08             	mov    0x8(%ebp),%esi
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  98:	eb 1d                	jmp    b7 <cat+0x27>
  9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if (write(1, buf, n) != n) {
  a0:	83 ec 04             	sub    $0x4,%esp
  a3:	53                   	push   %ebx
  a4:	68 60 0b 00 00       	push   $0xb60
  a9:	6a 01                	push   $0x1
  ab:	e8 c3 02 00 00       	call   373 <write>
  b0:	83 c4 10             	add    $0x10,%esp
  b3:	39 d8                	cmp    %ebx,%eax
  b5:	75 25                	jne    dc <cat+0x4c>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  b7:	83 ec 04             	sub    $0x4,%esp
  ba:	68 00 02 00 00       	push   $0x200
  bf:	68 60 0b 00 00       	push   $0xb60
  c4:	56                   	push   %esi
  c5:	e8 a1 02 00 00       	call   36b <read>
  ca:	83 c4 10             	add    $0x10,%esp
  cd:	89 c3                	mov    %eax,%ebx
  cf:	85 c0                	test   %eax,%eax
  d1:	7f cd                	jg     a0 <cat+0x10>
  if(n < 0){
  d3:	75 1b                	jne    f0 <cat+0x60>
}
  d5:	8d 65 f8             	lea    -0x8(%ebp),%esp
  d8:	5b                   	pop    %ebx
  d9:	5e                   	pop    %esi
  da:	5d                   	pop    %ebp
  db:	c3                   	ret
      printf(1, "cat: write error\n");
  dc:	83 ec 08             	sub    $0x8,%esp
  df:	68 d8 07 00 00       	push   $0x7d8
  e4:	6a 01                	push   $0x1
  e6:	e8 e5 03 00 00       	call   4d0 <printf>
      exit();
  eb:	e8 63 02 00 00       	call   353 <exit>
    printf(1, "cat: read error\n");
  f0:	50                   	push   %eax
  f1:	50                   	push   %eax
  f2:	68 ea 07 00 00       	push   $0x7ea
  f7:	6a 01                	push   $0x1
  f9:	e8 d2 03 00 00       	call   4d0 <printf>
    exit();
  fe:	e8 50 02 00 00       	call   353 <exit>
 103:	66 90                	xchg   %ax,%ax
 105:	66 90                	xchg   %ax,%ax
 107:	66 90                	xchg   %ax,%ax
 109:	66 90                	xchg   %ax,%ax
 10b:	66 90                	xchg   %ax,%ax
 10d:	66 90                	xchg   %ax,%ax
 10f:	90                   	nop

00000110 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 110:	55                   	push   %ebp
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 111:	31 c0                	xor    %eax,%eax
{
 113:	89 e5                	mov    %esp,%ebp
 115:	53                   	push   %ebx
 116:	8b 4d 08             	mov    0x8(%ebp),%ecx
 119:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 11c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while((*s++ = *t++) != 0)
 120:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 124:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 127:	83 c0 01             	add    $0x1,%eax
 12a:	84 d2                	test   %dl,%dl
 12c:	75 f2                	jne    120 <strcpy+0x10>
    ;
  return os;
}
 12e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 131:	89 c8                	mov    %ecx,%eax
 133:	c9                   	leave
 134:	c3                   	ret
 135:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 13c:	00 
 13d:	8d 76 00             	lea    0x0(%esi),%esi

00000140 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	53                   	push   %ebx
 144:	8b 55 08             	mov    0x8(%ebp),%edx
 147:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 14a:	0f b6 02             	movzbl (%edx),%eax
 14d:	84 c0                	test   %al,%al
 14f:	75 17                	jne    168 <strcmp+0x28>
 151:	eb 3a                	jmp    18d <strcmp+0x4d>
 153:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 158:	0f b6 42 01          	movzbl 0x1(%edx),%eax
    p++, q++;
 15c:	83 c2 01             	add    $0x1,%edx
 15f:	8d 59 01             	lea    0x1(%ecx),%ebx
  while(*p && *p == *q)
 162:	84 c0                	test   %al,%al
 164:	74 1a                	je     180 <strcmp+0x40>
 166:	89 d9                	mov    %ebx,%ecx
 168:	0f b6 19             	movzbl (%ecx),%ebx
 16b:	38 c3                	cmp    %al,%bl
 16d:	74 e9                	je     158 <strcmp+0x18>
  return (uchar)*p - (uchar)*q;
 16f:	29 d8                	sub    %ebx,%eax
}
 171:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 174:	c9                   	leave
 175:	c3                   	ret
 176:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 17d:	00 
 17e:	66 90                	xchg   %ax,%ax
  return (uchar)*p - (uchar)*q;
 180:	0f b6 59 01          	movzbl 0x1(%ecx),%ebx
 184:	31 c0                	xor    %eax,%eax
 186:	29 d8                	sub    %ebx,%eax
}
 188:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 18b:	c9                   	leave
 18c:	c3                   	ret
  return (uchar)*p - (uchar)*q;
 18d:	0f b6 19             	movzbl (%ecx),%ebx
 190:	31 c0                	xor    %eax,%eax
 192:	eb db                	jmp    16f <strcmp+0x2f>
 194:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 19b:	00 
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000001a0 <strlen>:

uint
strlen(const char *s)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1a6:	80 3a 00             	cmpb   $0x0,(%edx)
 1a9:	74 15                	je     1c0 <strlen+0x20>
 1ab:	31 c0                	xor    %eax,%eax
 1ad:	8d 76 00             	lea    0x0(%esi),%esi
 1b0:	83 c0 01             	add    $0x1,%eax
 1b3:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1b7:	89 c1                	mov    %eax,%ecx
 1b9:	75 f5                	jne    1b0 <strlen+0x10>
    ;
  return n;
}
 1bb:	89 c8                	mov    %ecx,%eax
 1bd:	5d                   	pop    %ebp
 1be:	c3                   	ret
 1bf:	90                   	nop
  for(n = 0; s[n]; n++)
 1c0:	31 c9                	xor    %ecx,%ecx
}
 1c2:	5d                   	pop    %ebp
 1c3:	89 c8                	mov    %ecx,%eax
 1c5:	c3                   	ret
 1c6:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 1cd:	00 
 1ce:	66 90                	xchg   %ax,%ax

000001d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	57                   	push   %edi
 1d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1da:	8b 45 0c             	mov    0xc(%ebp),%eax
 1dd:	89 d7                	mov    %edx,%edi
 1df:	fc                   	cld
 1e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1e2:	8b 7d fc             	mov    -0x4(%ebp),%edi
 1e5:	89 d0                	mov    %edx,%eax
 1e7:	c9                   	leave
 1e8:	c3                   	ret
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000001f0 <strchr>:

char*
strchr(const char *s, char c)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	8b 45 08             	mov    0x8(%ebp),%eax
 1f6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1fa:	0f b6 10             	movzbl (%eax),%edx
 1fd:	84 d2                	test   %dl,%dl
 1ff:	75 12                	jne    213 <strchr+0x23>
 201:	eb 1d                	jmp    220 <strchr+0x30>
 203:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 208:	0f b6 50 01          	movzbl 0x1(%eax),%edx
 20c:	83 c0 01             	add    $0x1,%eax
 20f:	84 d2                	test   %dl,%dl
 211:	74 0d                	je     220 <strchr+0x30>
    if(*s == c)
 213:	38 d1                	cmp    %dl,%cl
 215:	75 f1                	jne    208 <strchr+0x18>
      return (char*)s;
  return 0;
}
 217:	5d                   	pop    %ebp
 218:	c3                   	ret
 219:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return 0;
 220:	31 c0                	xor    %eax,%eax
}
 222:	5d                   	pop    %ebp
 223:	c3                   	ret
 224:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 22b:	00 
 22c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000230 <gets>:

char*
gets(char *buf, int max)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	57                   	push   %edi
 234:	56                   	push   %esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    cc = read(0, &c, 1);
 235:	8d 75 e7             	lea    -0x19(%ebp),%esi
{
 238:	53                   	push   %ebx
  for(i=0; i+1 < max; ){
 239:	31 db                	xor    %ebx,%ebx
{
 23b:	83 ec 1c             	sub    $0x1c,%esp
  for(i=0; i+1 < max; ){
 23e:	eb 27                	jmp    267 <gets+0x37>
    cc = read(0, &c, 1);
 240:	83 ec 04             	sub    $0x4,%esp
 243:	6a 01                	push   $0x1
 245:	56                   	push   %esi
 246:	6a 00                	push   $0x0
 248:	e8 1e 01 00 00       	call   36b <read>
    if(cc < 1)
 24d:	83 c4 10             	add    $0x10,%esp
 250:	85 c0                	test   %eax,%eax
 252:	7e 1d                	jle    271 <gets+0x41>
      break;
    buf[i++] = c;
 254:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 258:	8b 55 08             	mov    0x8(%ebp),%edx
 25b:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
    if(c == '\n' || c == '\r')
 25f:	3c 0a                	cmp    $0xa,%al
 261:	74 10                	je     273 <gets+0x43>
 263:	3c 0d                	cmp    $0xd,%al
 265:	74 0c                	je     273 <gets+0x43>
  for(i=0; i+1 < max; ){
 267:	89 df                	mov    %ebx,%edi
 269:	83 c3 01             	add    $0x1,%ebx
 26c:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 26f:	7c cf                	jl     240 <gets+0x10>
 271:	89 fb                	mov    %edi,%ebx
      break;
  }
  buf[i] = '\0';
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	c6 04 18 00          	movb   $0x0,(%eax,%ebx,1)
  return buf;
}
 27a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 27d:	5b                   	pop    %ebx
 27e:	5e                   	pop    %esi
 27f:	5f                   	pop    %edi
 280:	5d                   	pop    %ebp
 281:	c3                   	ret
 282:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 289:	00 
 28a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000290 <stat>:

int
stat(const char *n, struct stat *st)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	56                   	push   %esi
 294:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 295:	83 ec 08             	sub    $0x8,%esp
 298:	6a 00                	push   $0x0
 29a:	ff 75 08             	push   0x8(%ebp)
 29d:	e8 f1 00 00 00       	call   393 <open>
  if(fd < 0)
 2a2:	83 c4 10             	add    $0x10,%esp
 2a5:	85 c0                	test   %eax,%eax
 2a7:	78 27                	js     2d0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2a9:	83 ec 08             	sub    $0x8,%esp
 2ac:	ff 75 0c             	push   0xc(%ebp)
 2af:	89 c3                	mov    %eax,%ebx
 2b1:	50                   	push   %eax
 2b2:	e8 f4 00 00 00       	call   3ab <fstat>
  close(fd);
 2b7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2ba:	89 c6                	mov    %eax,%esi
  close(fd);
 2bc:	e8 ba 00 00 00       	call   37b <close>
  return r;
 2c1:	83 c4 10             	add    $0x10,%esp
}
 2c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2c7:	89 f0                	mov    %esi,%eax
 2c9:	5b                   	pop    %ebx
 2ca:	5e                   	pop    %esi
 2cb:	5d                   	pop    %ebp
 2cc:	c3                   	ret
 2cd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2d0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2d5:	eb ed                	jmp    2c4 <stat+0x34>
 2d7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2de:	00 
 2df:	90                   	nop

000002e0 <atoi>:

int
atoi(const char *s)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	53                   	push   %ebx
 2e4:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2e7:	0f be 02             	movsbl (%edx),%eax
 2ea:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2ed:	80 f9 09             	cmp    $0x9,%cl
  n = 0;
 2f0:	b9 00 00 00 00       	mov    $0x0,%ecx
  while('0' <= *s && *s <= '9')
 2f5:	77 1e                	ja     315 <atoi+0x35>
 2f7:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 2fe:	00 
 2ff:	90                   	nop
    n = n*10 + *s++ - '0';
 300:	83 c2 01             	add    $0x1,%edx
 303:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 306:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 30a:	0f be 02             	movsbl (%edx),%eax
 30d:	8d 58 d0             	lea    -0x30(%eax),%ebx
 310:	80 fb 09             	cmp    $0x9,%bl
 313:	76 eb                	jbe    300 <atoi+0x20>
  return n;
}
 315:	8b 5d fc             	mov    -0x4(%ebp),%ebx
 318:	89 c8                	mov    %ecx,%eax
 31a:	c9                   	leave
 31b:	c3                   	ret
 31c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000320 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	57                   	push   %edi
 324:	8b 45 10             	mov    0x10(%ebp),%eax
 327:	8b 55 08             	mov    0x8(%ebp),%edx
 32a:	56                   	push   %esi
 32b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 32e:	85 c0                	test   %eax,%eax
 330:	7e 13                	jle    345 <memmove+0x25>
 332:	01 d0                	add    %edx,%eax
  dst = vdst;
 334:	89 d7                	mov    %edx,%edi
 336:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 33d:	00 
 33e:	66 90                	xchg   %ax,%ax
    *dst++ = *src++;
 340:	a4                   	movsb  %ds:(%esi),%es:(%edi)
  while(n-- > 0)
 341:	39 f8                	cmp    %edi,%eax
 343:	75 fb                	jne    340 <memmove+0x20>
  return vdst;
}
 345:	5e                   	pop    %esi
 346:	89 d0                	mov    %edx,%eax
 348:	5f                   	pop    %edi
 349:	5d                   	pop    %ebp
 34a:	c3                   	ret

0000034b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 34b:	b8 01 00 00 00       	mov    $0x1,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret

00000353 <exit>:
SYSCALL(exit)
 353:	b8 02 00 00 00       	mov    $0x2,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret

0000035b <wait>:
SYSCALL(wait)
 35b:	b8 03 00 00 00       	mov    $0x3,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret

00000363 <pipe>:
SYSCALL(pipe)
 363:	b8 04 00 00 00       	mov    $0x4,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret

0000036b <read>:
SYSCALL(read)
 36b:	b8 05 00 00 00       	mov    $0x5,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret

00000373 <write>:
SYSCALL(write)
 373:	b8 10 00 00 00       	mov    $0x10,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret

0000037b <close>:
SYSCALL(close)
 37b:	b8 15 00 00 00       	mov    $0x15,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret

00000383 <kill>:
SYSCALL(kill)
 383:	b8 06 00 00 00       	mov    $0x6,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret

0000038b <exec>:
SYSCALL(exec)
 38b:	b8 07 00 00 00       	mov    $0x7,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret

00000393 <open>:
SYSCALL(open)
 393:	b8 0f 00 00 00       	mov    $0xf,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret

0000039b <mknod>:
SYSCALL(mknod)
 39b:	b8 11 00 00 00       	mov    $0x11,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret

000003a3 <unlink>:
SYSCALL(unlink)
 3a3:	b8 12 00 00 00       	mov    $0x12,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret

000003ab <fstat>:
SYSCALL(fstat)
 3ab:	b8 08 00 00 00       	mov    $0x8,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret

000003b3 <link>:
SYSCALL(link)
 3b3:	b8 13 00 00 00       	mov    $0x13,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret

000003bb <mkdir>:
SYSCALL(mkdir)
 3bb:	b8 14 00 00 00       	mov    $0x14,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret

000003c3 <chdir>:
SYSCALL(chdir)
 3c3:	b8 09 00 00 00       	mov    $0x9,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret

000003cb <dup>:
SYSCALL(dup)
 3cb:	b8 0a 00 00 00       	mov    $0xa,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret

000003d3 <getpid>:
SYSCALL(getpid)
 3d3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret

000003db <sbrk>:
SYSCALL(sbrk)
 3db:	b8 0c 00 00 00       	mov    $0xc,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret

000003e3 <sleep>:
SYSCALL(sleep)
 3e3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret

000003eb <uptime>:
SYSCALL(uptime)
 3eb:	b8 0e 00 00 00       	mov    $0xe,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret

000003f3 <make_user>:
SYSCALL(make_user)
 3f3:	b8 16 00 00 00       	mov    $0x16,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret

000003fb <login>:
SYSCALL(login)
 3fb:	b8 17 00 00 00       	mov    $0x17,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret

00000403 <logout>:
SYSCALL(logout)
 403:	b8 18 00 00 00       	mov    $0x18,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret

0000040b <get_log>:
SYSCALL(get_log)
 40b:	b8 19 00 00 00       	mov    $0x19,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret

00000413 <diff>:
SYSCALL(diff)
 413:	b8 1a 00 00 00       	mov    $0x1a,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret

0000041b <set_sleep>:
SYSCALL(set_sleep)
 41b:	b8 1b 00 00 00       	mov    $0x1b,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret

00000423 <getcmostime>:
 423:	b8 1c 00 00 00       	mov    $0x1c,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret
 42b:	66 90                	xchg   %ax,%ax
 42d:	66 90                	xchg   %ax,%ax
 42f:	90                   	nop

00000430 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	57                   	push   %edi
 434:	56                   	push   %esi
 435:	53                   	push   %ebx
 436:	89 cb                	mov    %ecx,%ebx
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 438:	89 d1                	mov    %edx,%ecx
{
 43a:	83 ec 3c             	sub    $0x3c,%esp
 43d:	89 45 c0             	mov    %eax,-0x40(%ebp)
  if(sgn && xx < 0){
 440:	85 d2                	test   %edx,%edx
 442:	0f 89 80 00 00 00    	jns    4c8 <printint+0x98>
 448:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 44c:	74 7a                	je     4c8 <printint+0x98>
    x = -xx;
 44e:	f7 d9                	neg    %ecx
    neg = 1;
 450:	b8 01 00 00 00       	mov    $0x1,%eax
  } else {
    x = xx;
  }

  i = 0;
 455:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 458:	31 f6                	xor    %esi,%esi
 45a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  do{
    buf[i++] = digits[x % base];
 460:	89 c8                	mov    %ecx,%eax
 462:	31 d2                	xor    %edx,%edx
 464:	89 f7                	mov    %esi,%edi
 466:	f7 f3                	div    %ebx
 468:	8d 76 01             	lea    0x1(%esi),%esi
 46b:	0f b6 92 70 08 00 00 	movzbl 0x870(%edx),%edx
 472:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 476:	89 ca                	mov    %ecx,%edx
 478:	89 c1                	mov    %eax,%ecx
 47a:	39 da                	cmp    %ebx,%edx
 47c:	73 e2                	jae    460 <printint+0x30>
  if(neg)
 47e:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 481:	85 c0                	test   %eax,%eax
 483:	74 07                	je     48c <printint+0x5c>
    buf[i++] = '-';
 485:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)

  while(--i >= 0)
 48a:	89 f7                	mov    %esi,%edi
 48c:	8d 5d d8             	lea    -0x28(%ebp),%ebx
 48f:	8b 75 c0             	mov    -0x40(%ebp),%esi
 492:	01 df                	add    %ebx,%edi
 494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    putc(fd, buf[i]);
 498:	0f b6 07             	movzbl (%edi),%eax
  write(fd, &c, 1);
 49b:	83 ec 04             	sub    $0x4,%esp
 49e:	88 45 d7             	mov    %al,-0x29(%ebp)
 4a1:	8d 45 d7             	lea    -0x29(%ebp),%eax
 4a4:	6a 01                	push   $0x1
 4a6:	50                   	push   %eax
 4a7:	56                   	push   %esi
 4a8:	e8 c6 fe ff ff       	call   373 <write>
  while(--i >= 0)
 4ad:	89 f8                	mov    %edi,%eax
 4af:	83 c4 10             	add    $0x10,%esp
 4b2:	83 ef 01             	sub    $0x1,%edi
 4b5:	39 c3                	cmp    %eax,%ebx
 4b7:	75 df                	jne    498 <printint+0x68>
}
 4b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4bc:	5b                   	pop    %ebx
 4bd:	5e                   	pop    %esi
 4be:	5f                   	pop    %edi
 4bf:	5d                   	pop    %ebp
 4c0:	c3                   	ret
 4c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 4c8:	31 c0                	xor    %eax,%eax
 4ca:	eb 89                	jmp    455 <printint+0x25>
 4cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000004d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4d0:	55                   	push   %ebp
 4d1:	89 e5                	mov    %esp,%ebp
 4d3:	57                   	push   %edi
 4d4:	56                   	push   %esi
 4d5:	53                   	push   %ebx
 4d6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4d9:	8b 75 0c             	mov    0xc(%ebp),%esi
{
 4dc:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i = 0; fmt[i]; i++){
 4df:	0f b6 1e             	movzbl (%esi),%ebx
 4e2:	83 c6 01             	add    $0x1,%esi
 4e5:	84 db                	test   %bl,%bl
 4e7:	74 67                	je     550 <printf+0x80>
 4e9:	8d 4d 10             	lea    0x10(%ebp),%ecx
 4ec:	31 d2                	xor    %edx,%edx
 4ee:	89 4d d0             	mov    %ecx,-0x30(%ebp)
 4f1:	eb 34                	jmp    527 <printf+0x57>
 4f3:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
 4f8:	89 55 d4             	mov    %edx,-0x2c(%ebp)
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 4fb:	ba 25 00 00 00       	mov    $0x25,%edx
      if(c == '%'){
 500:	83 f8 25             	cmp    $0x25,%eax
 503:	74 18                	je     51d <printf+0x4d>
  write(fd, &c, 1);
 505:	83 ec 04             	sub    $0x4,%esp
 508:	8d 45 e7             	lea    -0x19(%ebp),%eax
 50b:	88 5d e7             	mov    %bl,-0x19(%ebp)
 50e:	6a 01                	push   $0x1
 510:	50                   	push   %eax
 511:	57                   	push   %edi
 512:	e8 5c fe ff ff       	call   373 <write>
 517:	8b 55 d4             	mov    -0x2c(%ebp),%edx
      } else {
        putc(fd, c);
 51a:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 51d:	0f b6 1e             	movzbl (%esi),%ebx
 520:	83 c6 01             	add    $0x1,%esi
 523:	84 db                	test   %bl,%bl
 525:	74 29                	je     550 <printf+0x80>
    c = fmt[i] & 0xff;
 527:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 52a:	85 d2                	test   %edx,%edx
 52c:	74 ca                	je     4f8 <printf+0x28>
      }
    } else if(state == '%'){
 52e:	83 fa 25             	cmp    $0x25,%edx
 531:	75 ea                	jne    51d <printf+0x4d>
      if(c == 'd'){
 533:	83 f8 25             	cmp    $0x25,%eax
 536:	0f 84 04 01 00 00    	je     640 <printf+0x170>
 53c:	83 e8 63             	sub    $0x63,%eax
 53f:	83 f8 15             	cmp    $0x15,%eax
 542:	77 1c                	ja     560 <printf+0x90>
 544:	ff 24 85 18 08 00 00 	jmp    *0x818(,%eax,4)
 54b:	2e 8d 74 26 00       	lea    %cs:0x0(%esi,%eiz,1),%esi
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 550:	8d 65 f4             	lea    -0xc(%ebp),%esp
 553:	5b                   	pop    %ebx
 554:	5e                   	pop    %esi
 555:	5f                   	pop    %edi
 556:	5d                   	pop    %ebp
 557:	c3                   	ret
 558:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 55f:	00 
  write(fd, &c, 1);
 560:	83 ec 04             	sub    $0x4,%esp
 563:	8d 55 e7             	lea    -0x19(%ebp),%edx
 566:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 56a:	6a 01                	push   $0x1
 56c:	52                   	push   %edx
 56d:	89 55 d4             	mov    %edx,-0x2c(%ebp)
 570:	57                   	push   %edi
 571:	e8 fd fd ff ff       	call   373 <write>
 576:	83 c4 0c             	add    $0xc,%esp
 579:	88 5d e7             	mov    %bl,-0x19(%ebp)
 57c:	6a 01                	push   $0x1
 57e:	8b 55 d4             	mov    -0x2c(%ebp),%edx
 581:	52                   	push   %edx
 582:	57                   	push   %edi
 583:	e8 eb fd ff ff       	call   373 <write>
        putc(fd, c);
 588:	83 c4 10             	add    $0x10,%esp
      state = 0;
 58b:	31 d2                	xor    %edx,%edx
 58d:	eb 8e                	jmp    51d <printf+0x4d>
 58f:	90                   	nop
        printint(fd, *ap, 16, 0);
 590:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 593:	83 ec 0c             	sub    $0xc,%esp
 596:	b9 10 00 00 00       	mov    $0x10,%ecx
 59b:	8b 13                	mov    (%ebx),%edx
 59d:	6a 00                	push   $0x0
 59f:	89 f8                	mov    %edi,%eax
        ap++;
 5a1:	83 c3 04             	add    $0x4,%ebx
        printint(fd, *ap, 16, 0);
 5a4:	e8 87 fe ff ff       	call   430 <printint>
        ap++;
 5a9:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 5ac:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5af:	31 d2                	xor    %edx,%edx
 5b1:	e9 67 ff ff ff       	jmp    51d <printf+0x4d>
        s = (char*)*ap;
 5b6:	8b 45 d0             	mov    -0x30(%ebp),%eax
 5b9:	8b 18                	mov    (%eax),%ebx
        ap++;
 5bb:	83 c0 04             	add    $0x4,%eax
 5be:	89 45 d0             	mov    %eax,-0x30(%ebp)
        if(s == 0)
 5c1:	85 db                	test   %ebx,%ebx
 5c3:	0f 84 87 00 00 00    	je     650 <printf+0x180>
        while(*s != 0){
 5c9:	0f b6 03             	movzbl (%ebx),%eax
      state = 0;
 5cc:	31 d2                	xor    %edx,%edx
        while(*s != 0){
 5ce:	84 c0                	test   %al,%al
 5d0:	0f 84 47 ff ff ff    	je     51d <printf+0x4d>
 5d6:	8d 55 e7             	lea    -0x19(%ebp),%edx
 5d9:	89 75 d4             	mov    %esi,-0x2c(%ebp)
 5dc:	89 de                	mov    %ebx,%esi
 5de:	89 d3                	mov    %edx,%ebx
  write(fd, &c, 1);
 5e0:	83 ec 04             	sub    $0x4,%esp
 5e3:	88 45 e7             	mov    %al,-0x19(%ebp)
          s++;
 5e6:	83 c6 01             	add    $0x1,%esi
  write(fd, &c, 1);
 5e9:	6a 01                	push   $0x1
 5eb:	53                   	push   %ebx
 5ec:	57                   	push   %edi
 5ed:	e8 81 fd ff ff       	call   373 <write>
        while(*s != 0){
 5f2:	0f b6 06             	movzbl (%esi),%eax
 5f5:	83 c4 10             	add    $0x10,%esp
 5f8:	84 c0                	test   %al,%al
 5fa:	75 e4                	jne    5e0 <printf+0x110>
      state = 0;
 5fc:	8b 75 d4             	mov    -0x2c(%ebp),%esi
 5ff:	31 d2                	xor    %edx,%edx
 601:	e9 17 ff ff ff       	jmp    51d <printf+0x4d>
        printint(fd, *ap, 10, 1);
 606:	8b 5d d0             	mov    -0x30(%ebp),%ebx
 609:	83 ec 0c             	sub    $0xc,%esp
 60c:	b9 0a 00 00 00       	mov    $0xa,%ecx
 611:	8b 13                	mov    (%ebx),%edx
 613:	6a 01                	push   $0x1
 615:	eb 88                	jmp    59f <printf+0xcf>
        putc(fd, *ap);
 617:	8b 5d d0             	mov    -0x30(%ebp),%ebx
  write(fd, &c, 1);
 61a:	83 ec 04             	sub    $0x4,%esp
 61d:	8d 55 e7             	lea    -0x19(%ebp),%edx
        putc(fd, *ap);
 620:	8b 03                	mov    (%ebx),%eax
        ap++;
 622:	83 c3 04             	add    $0x4,%ebx
        putc(fd, *ap);
 625:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 628:	6a 01                	push   $0x1
 62a:	52                   	push   %edx
 62b:	57                   	push   %edi
 62c:	e8 42 fd ff ff       	call   373 <write>
        ap++;
 631:	89 5d d0             	mov    %ebx,-0x30(%ebp)
 634:	83 c4 10             	add    $0x10,%esp
      state = 0;
 637:	31 d2                	xor    %edx,%edx
 639:	e9 df fe ff ff       	jmp    51d <printf+0x4d>
 63e:	66 90                	xchg   %ax,%ax
  write(fd, &c, 1);
 640:	83 ec 04             	sub    $0x4,%esp
 643:	88 5d e7             	mov    %bl,-0x19(%ebp)
 646:	8d 55 e7             	lea    -0x19(%ebp),%edx
 649:	6a 01                	push   $0x1
 64b:	e9 31 ff ff ff       	jmp    581 <printf+0xb1>
 650:	b8 28 00 00 00       	mov    $0x28,%eax
          s = "(null)";
 655:	bb 10 08 00 00       	mov    $0x810,%ebx
 65a:	e9 77 ff ff ff       	jmp    5d6 <printf+0x106>
 65f:	90                   	nop

00000660 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 660:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 661:	a1 60 0d 00 00       	mov    0xd60,%eax
{
 666:	89 e5                	mov    %esp,%ebp
 668:	57                   	push   %edi
 669:	56                   	push   %esi
 66a:	53                   	push   %ebx
 66b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 66e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 671:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 678:	8b 10                	mov    (%eax),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 67a:	39 c8                	cmp    %ecx,%eax
 67c:	73 32                	jae    6b0 <free+0x50>
 67e:	39 d1                	cmp    %edx,%ecx
 680:	72 04                	jb     686 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 682:	39 d0                	cmp    %edx,%eax
 684:	72 32                	jb     6b8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 686:	8b 73 fc             	mov    -0x4(%ebx),%esi
 689:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 68c:	39 fa                	cmp    %edi,%edx
 68e:	74 30                	je     6c0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
 690:	89 53 f8             	mov    %edx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 693:	8b 50 04             	mov    0x4(%eax),%edx
 696:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 699:	39 f1                	cmp    %esi,%ecx
 69b:	74 3a                	je     6d7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
 69d:	89 08                	mov    %ecx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
}
 69f:	5b                   	pop    %ebx
  freep = p;
 6a0:	a3 60 0d 00 00       	mov    %eax,0xd60
}
 6a5:	5e                   	pop    %esi
 6a6:	5f                   	pop    %edi
 6a7:	5d                   	pop    %ebp
 6a8:	c3                   	ret
 6a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6b0:	39 d0                	cmp    %edx,%eax
 6b2:	72 04                	jb     6b8 <free+0x58>
 6b4:	39 d1                	cmp    %edx,%ecx
 6b6:	72 ce                	jb     686 <free+0x26>
{
 6b8:	89 d0                	mov    %edx,%eax
 6ba:	eb bc                	jmp    678 <free+0x18>
 6bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 6c0:	03 72 04             	add    0x4(%edx),%esi
 6c3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6c6:	8b 10                	mov    (%eax),%edx
 6c8:	8b 12                	mov    (%edx),%edx
 6ca:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6cd:	8b 50 04             	mov    0x4(%eax),%edx
 6d0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6d3:	39 f1                	cmp    %esi,%ecx
 6d5:	75 c6                	jne    69d <free+0x3d>
    p->s.size += bp->s.size;
 6d7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 6da:	a3 60 0d 00 00       	mov    %eax,0xd60
    p->s.size += bp->s.size;
 6df:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6e2:	8b 4b f8             	mov    -0x8(%ebx),%ecx
 6e5:	89 08                	mov    %ecx,(%eax)
}
 6e7:	5b                   	pop    %ebx
 6e8:	5e                   	pop    %esi
 6e9:	5f                   	pop    %edi
 6ea:	5d                   	pop    %ebp
 6eb:	c3                   	ret
 6ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000006f0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6f0:	55                   	push   %ebp
 6f1:	89 e5                	mov    %esp,%ebp
 6f3:	57                   	push   %edi
 6f4:	56                   	push   %esi
 6f5:	53                   	push   %ebx
 6f6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6f9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 6fc:	8b 15 60 0d 00 00    	mov    0xd60,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 702:	8d 78 07             	lea    0x7(%eax),%edi
 705:	c1 ef 03             	shr    $0x3,%edi
 708:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 70b:	85 d2                	test   %edx,%edx
 70d:	0f 84 8d 00 00 00    	je     7a0 <malloc+0xb0>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 713:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 715:	8b 48 04             	mov    0x4(%eax),%ecx
 718:	39 f9                	cmp    %edi,%ecx
 71a:	73 64                	jae    780 <malloc+0x90>
  if(nu < 4096)
 71c:	bb 00 10 00 00       	mov    $0x1000,%ebx
 721:	39 df                	cmp    %ebx,%edi
 723:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 726:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 72d:	eb 0a                	jmp    739 <malloc+0x49>
 72f:	90                   	nop
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 730:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 732:	8b 48 04             	mov    0x4(%eax),%ecx
 735:	39 f9                	cmp    %edi,%ecx
 737:	73 47                	jae    780 <malloc+0x90>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 739:	89 c2                	mov    %eax,%edx
 73b:	3b 05 60 0d 00 00    	cmp    0xd60,%eax
 741:	75 ed                	jne    730 <malloc+0x40>
  p = sbrk(nu * sizeof(Header));
 743:	83 ec 0c             	sub    $0xc,%esp
 746:	56                   	push   %esi
 747:	e8 8f fc ff ff       	call   3db <sbrk>
  if(p == (char*)-1)
 74c:	83 c4 10             	add    $0x10,%esp
 74f:	83 f8 ff             	cmp    $0xffffffff,%eax
 752:	74 1c                	je     770 <malloc+0x80>
  hp->s.size = nu;
 754:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 757:	83 ec 0c             	sub    $0xc,%esp
 75a:	83 c0 08             	add    $0x8,%eax
 75d:	50                   	push   %eax
 75e:	e8 fd fe ff ff       	call   660 <free>
  return freep;
 763:	8b 15 60 0d 00 00    	mov    0xd60,%edx
      if((p = morecore(nunits)) == 0)
 769:	83 c4 10             	add    $0x10,%esp
 76c:	85 d2                	test   %edx,%edx
 76e:	75 c0                	jne    730 <malloc+0x40>
        return 0;
  }
}
 770:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 773:	31 c0                	xor    %eax,%eax
}
 775:	5b                   	pop    %ebx
 776:	5e                   	pop    %esi
 777:	5f                   	pop    %edi
 778:	5d                   	pop    %ebp
 779:	c3                   	ret
 77a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 780:	39 cf                	cmp    %ecx,%edi
 782:	74 4c                	je     7d0 <malloc+0xe0>
        p->s.size -= nunits;
 784:	29 f9                	sub    %edi,%ecx
 786:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 789:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 78c:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 78f:	89 15 60 0d 00 00    	mov    %edx,0xd60
}
 795:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 798:	83 c0 08             	add    $0x8,%eax
}
 79b:	5b                   	pop    %ebx
 79c:	5e                   	pop    %esi
 79d:	5f                   	pop    %edi
 79e:	5d                   	pop    %ebp
 79f:	c3                   	ret
    base.s.ptr = freep = prevp = &base;
 7a0:	c7 05 60 0d 00 00 64 	movl   $0xd64,0xd60
 7a7:	0d 00 00 
    base.s.size = 0;
 7aa:	b8 64 0d 00 00       	mov    $0xd64,%eax
    base.s.ptr = freep = prevp = &base;
 7af:	c7 05 64 0d 00 00 64 	movl   $0xd64,0xd64
 7b6:	0d 00 00 
    base.s.size = 0;
 7b9:	c7 05 68 0d 00 00 00 	movl   $0x0,0xd68
 7c0:	00 00 00 
    if(p->s.size >= nunits){
 7c3:	e9 54 ff ff ff       	jmp    71c <malloc+0x2c>
 7c8:	2e 8d b4 26 00 00 00 	lea    %cs:0x0(%esi,%eiz,1),%esi
 7cf:	00 
        prevp->s.ptr = p->s.ptr;
 7d0:	8b 08                	mov    (%eax),%ecx
 7d2:	89 0a                	mov    %ecx,(%edx)
 7d4:	eb b9                	jmp    78f <malloc+0x9f>
