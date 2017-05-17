From: alex@vastdata.com (Alex Turin)
Date: Wed, 17 May 2017 19:08:04 +0300
Subject: NVMeoF: multipath stuck after bringing one ethernet port down
Message-ID: <CAK0KL7DPLw+0AB8cGop7jowfE1HV9wyXBmJhE90trpor-PcSYw@mail.gmail.com>

I am trying to test failure scenarios of NVMeoF + multipath. I bring
one of ports down and expect to see failed paths using "multipath
-ll". Instead I see that "multipath -ll" get stuck.

reproduce:
1. Connected to NVMeoF device through 2 ports.
2. Bind them with multipath.
3. Bring one port down (ifconfig eth3 down)
4. Execute "multipath -ll" command and it will get stuck.
>From strace I see that multipath is stuck in io_destroy() during
release of resources. As I understand io_destroy is stuck because of
io_cancel() that failed. And io_cancel() failed because of port that
was disabled in step 3.


environment:
Kernel: 4.11.1-1.el7.elrepo.x86_64
Network card: ConnectX-4 Lx
rdma-core: version 14 (commit 240c019)
nvme-cli: master - commit 4b5b4d2 (https://github.com/linux-nvme/nvme-cli.git)


/var/log/messages
May 17 11:15:00 localhost NetworkManager[1352]: <info>
[1495034100.7162] device (eth3): state change: activated ->
unavailable (reason 'carrier-changed') [100 20 40]
May 17 11:15:00 localhost dbus-daemon: dbus[1300]: [system] Activating
via systemd: service name='org.freedesktop.nm_dispatcher'
unit='dbus-org.freedesktop.nm-dispatcher.service'
May 17 11:15:00 localhost dbus[1300]: [system] Activating via systemd:
service name='org.freedesktop.nm_dispatcher'
unit='dbus-org.freedesktop.nm-dispatcher.service'
May 17 11:15:00 localhost systemd: Starting Network Manager Script
Dispatcher Service...
May 17 11:15:00 localhost dbus[1300]: [system] Successfully activated
service 'org.freedesktop.nm_dispatcher'
May 17 11:15:00 localhost dbus-daemon: dbus[1300]: [system]
Successfully activated service 'org.freedesktop.nm_dispatcher'
May 17 11:15:00 localhost systemd: Started Network Manager Script
Dispatcher Service.
May 17 11:15:00 localhost nm-dispatcher: req:1 'down' [eth3]: new
request (3 scripts)
May 17 11:15:00 localhost nm-dispatcher: req:1 'down' [eth3]: start
running ordered scripts...
May 17 11:15:09 localhost kernel: nvme nvme2: failed
nvme_keep_alive_end_io error=16391
May 17 11:15:09 localhost kernel: nvme nvme1: failed
nvme_keep_alive_end_io error=16391
May 17 11:15:09 localhost kernel: nvme nvme2: reconnecting in 10 seconds
May 17 11:15:09 localhost kernel: nvme nvme1: reconnecting in 10 seconds


# strace multipath -ll 2>&1 | grep  "io_\|open(\"/dev/nvme"
io_setup(1, {140204923695104})          = 0
io_submit(140204923695104, 1, {{pread, filedes:4, buf:0x1d14000,
nbytes:4096, offset:0}}) = 1
io_getevents(140204923695104, 1, 1, {{(nil), 0x1d11ba8, 4096, 0}}, {2, 0}) = 1
open("/dev/nvme0n1", O_RDONLY)          = 5
io_setup(1, {140204923682816})          = 0
io_submit(140204923682816, 1, {{pread, filedes:5, buf:0x1d22000,
nbytes:4096, offset:0}}) = 1
io_getevents(140204923682816, 1, 1, {{(nil), 0x1d21548, 4096, 0}}, {2, 0}) = 1
open("/dev/nvme1n1", O_RDONLY)          = 6
io_setup(1, {140204923670528})          = 0
io_submit(140204923670528, 1, {{pread, filedes:6, buf:0x1d25000,
nbytes:4096, offset:0}}) = 1
io_getevents(140204923670528, 1, 1, {}{2, 0}) = 0
io_cancel(140204923670528, {(nil), 0, 0, 0, 6}, {...}) = -1 EINVAL
(Invalid argument)
open("/dev/nvme2n1", O_RDONLY)          = 7
io_setup(1, {140204923355136})          = 0
io_submit(140204923355136, 1, {{pread, filedes:7, buf:0x1d29000,
nbytes:4096, offset:0}}) = 1
io_getevents(140204923355136, 1, 1, {}{2, 0}) = 0
io_cancel(140204923355136, {(nil), 0, 0, 0, 7}, {...}) = -1 EINVAL
(Invalid argument)
open("/dev/nvme3n1", O_RDONLY)          = 8
io_setup(1, {140204923342848})          = 0
io_submit(140204923342848, 1, {{pread, filedes:8, buf:0x1d2d000,
nbytes:4096, offset:0}}) = 1
io_getevents(140204923342848, 1, 1, {{(nil), 0x1d2af28, 4096, 0}}, {2, 0}) = 1
io_destroy(140204923695104)             = 0
io_destroy(140204923682816)             = 0
io_destroy(140204923670528
