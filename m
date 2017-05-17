From: alex@vastdata.com (Alex Turin)
Date: Wed, 17 May 2017 17:42:11 +0300
Subject: NVMeoF + 1 port down => nvme cli stuck
Message-ID: <CAK0KL7DLT=aNNV=R3pWfbi7Q29xNbExmEQ2Hza7NWk_6QBwXgw@mail.gmail.com>

1. Connected to one NVMeoF device.
2. Bring the port that NVMeoF is connected through down (ifconfig eth3 down)
3. Execute nvme-cli command like: "nvme list".
In this case I expect that "nvme list" will do the job or will return an error.
But in this case "nvme list" becomes stuck and even "kill -9" cannot release it.
4. Bringing port up doesn't release "nvme list".

Thanks in advance

environment:
Kernel: 4.11.1-1.el7.elrepo.x86_64
Network card: ConnectX-4 Lx
rdma-core: version 14 (commit 240c019)
nvme-cli: commit 4b5b4d2 (https://github.com/linux-nvme/nvme-cli.git)


$ strace nvme list
execve("/sbin/nvme", ["nvme", "list"], [/* 25 vars */]) = 0
brk(0)                                  = 0xd49000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7f981b120000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=34068, ...}) = 0
mmap(NULL, 34068, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f981b117000
close(3)                                = 0
open("/lib64/libc.so.6", O_RDONLY|O_CLOEXEC) = 3
read(3, "\177ELF\2\1\1\3\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0@\34\2\0\0\0\0\0"...,
832) = 832
fstat(3, {st_mode=S_IFREG|0755, st_size=2118128, ...}) = 0
mmap(NULL, 3932672, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0x7f981ab41000
mprotect(0x7f981acf7000, 2097152, PROT_NONE) = 0
mmap(0x7f981aef7000, 24576, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1b6000) = 0x7f981aef7000
mmap(0x7f981aefd000, 16896, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7f981aefd000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7f981b116000
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0x7f981b114000
arch_prctl(ARCH_SET_FS, 0x7f981b114740) = 0
mprotect(0x7f981aef7000, 16384, PROT_READ) = 0
mprotect(0x629000, 4096, PROT_READ)     = 0
mprotect(0x7f981b121000, 4096, PROT_READ) = 0
munmap(0x7f981b117000, 34068)           = 0
brk(0)                                  = 0xd49000
brk(0xd6a000)                           = 0xd6a000
brk(0)                                  = 0xd6a000
open("/usr/lib/locale/locale-archive", O_RDONLY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size=106070960, ...}) = 0
mmap(NULL, 106070960, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7f9814618000
close(3)                                = 0
openat(AT_FDCWD, "/dev/", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 3
getdents(3, /* 164 entries */, 32768)   = 4800
stat("/etc/sysconfig/64bit_strstr_via_64bit_strstr_sse2_unaligned",
0x7ffc2b837f70) = -1 ENOENT (No such file or directory)
stat("/dev/nvme1n1", {st_mode=S_IFBLK|0660, st_rdev=makedev(259, 1), ...}) = 0
stat("/dev/nvme1", {st_mode=S_IFCHR|0600, st_rdev=makedev(240, 1), ...}) = 0
stat("/dev/nvme0n1", {st_mode=S_IFBLK|0660, st_rdev=makedev(259, 0), ...}) = 0
stat("/dev/nvme0", {st_mode=S_IFCHR|0600, st_rdev=makedev(240, 0), ...}) = 0
stat("/dev/nvme-fabrics", {st_mode=S_IFCHR|0600, st_rdev=makedev(10,
57), ...}) = 0
getdents(3, /* 0 entries */, 32768)     = 0
close(3)                                = 0
open("/dev/nvme0n1", O_RDONLY)          = 3
ioctl(3, 0xc0484e41
