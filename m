From: ichavero@chavero.com.mx (=?ISO-8859-1?Q?Iv=E1n?= Chavero)
Date: Wed, 15 May 2019 19:20:43 -0500
Subject: nvme drive kernel 5.0 problem
Message-ID: <4a0dda5365f24e7223d1672233d7f1ac64640d31.camel@chavero.com.mx>

Hello,

I have a macbook air with a nvme drive and Fedora installed. 
Since kernel 4.16.11 it wouldn't boot properly, now with kernel 5.0
I started tampering with the nvme driver settings and managed to boot
but there's a problem with this settings, the driver shows this errors:

print_req_error: operation not supported error, dev nvme01...

And then the dm driver has problems writing to the device and the ext4
filesystem
remounts the root partition as read only which is no good.

The other partitions end up being mounted properly and are writable so
i have the hypotesis 
that there's a timing/initialization/queue problem while booting with
the driver that causes
problems writing to the device. 

I'm not very familiar with the driver so i'm not sure if the problem is
on my settings or
there's a problem with the driver in kernel 5.0.

This are the settings i'm using:
options $kernelopts nvme.poll_queues=2 nvme.io_queue_depth=2
nvme.max_host_mem_size_mb=128 nvme.
sgl_threshold=32768 nvme.use_cmb_sqes=Y
nvme_core.default_ps_max_latency_us=100000 nvme_core.for
ce_apst=Y nvme_core.io_timeout=30 nvme_core.max_retries=5
nvme_core.shutdown_timeout=5 nvme_core
.streams=N  systemd.unit=multi-user.target 

This are the relevant lines from the dmesg output:

[    2.330023] nvme nvme0: pci function 0000:04:00.0
[    2.332179] nvme nvme0: detected Apple NVMe controller, set queue
depth=2 to work around controller resets
[    2.335047] nvme nvme0: 1/0/0 default/read/poll queues
[    2.336944] WARNING: CPU: 3 PID: 46 at drivers/pci/msi.c:1278
pci_irq_get_affinity+0x66/0x90
[    2.338834] Modules linked in: nvme(+) drm ghash_clmulni_intel(+)
nvme_core video hid_apple fuse ecryptfs
[    2.340743] CPU: 3 PID: 46 Comm: kworker/u8:1 Not tainted 5.0.10-
300.fc30.x86_64 #1
[    2.342681] Hardware name: Apple Inc. MacBookAir7,1/Mac-
9F18E312C5C2BF0B, BIOS MBA71.88Z.0166.B09.1510261436 10/26/2015
[    2.344666] Workqueue: nvme-reset-wq nvme_reset_work [nvme]
[    2.346639] RIP: 0010:pci_irq_get_affinity+0x66/0x90
[    2.348616] Code: 0b 31 c0 c3 83 e2 02 48 c7 c0 a0 18 37 8f 74 30 48
8b 87 c0 02 00 00 48 85 c0 74 0e 48 8b 50 30 48 85 d2 74 05 39 70 14 77
05 <0f> 0b 31 c0 c3 48 63 f6 48 89 f0 48 c1 e0 04 48 01 c6 48 8d 04 f2
[    2.352395] usb 1-3.3: new full-speed USB device number 6 using
xhci_hcd
[    2.352706] RSP: 0000:ffffb83700e13cd8 EFLAGS: 00010246
[    2.356747] RAX: ffff9fbbde10d540 RBX: 0000000000000000 RCX:
0000000000000004
[    2.358758] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
ffff9fbbe4e28000
[    2.360793] RBP: 0000000000000000 R08: 0000000000000003 R09:
ffff9fbbe5342a90
[    2.362806] R10: ffff9fbbe6403b00 R11: 0000000000000000 R12:
ffff9fbbe4e28000
[    2.364793] R13: 0000000000000000 R14: ffff9fbbdd5f9008 R15:
0000000000000000
[    2.366720] FS:  0000000000000000(0000) GS:ffff9fbbe6b80000(0000)
knlGS:0000000000000000
[    2.368651] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.370580] CR2: 000055a44841a000 CR3: 000000025e96c001 CR4:
00000000003606e0
[    2.372490] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
0000000000000000
[    2.374359] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
0000000000000400
[    2.375888] Call Trace:
[    2.377577]  blk_mq_pci_map_queues+0x2d/0xb0
[    2.379473]  nvme_pci_map_queues+0x80/0xb0 [nvme]
[    2.381375]  blk_mq_alloc_tag_set+0x118/0x2c0
[    2.381380]  nvme_reset_work+0x13ca/0x1882 [nvme]
[    2.384415]  process_one_work+0x19d/0x380
[    2.384417]  worker_thread+0x1db/0x3b0
[    2.387711]  kthread+0xfb/0x130
[    2.387715]  ? process_one_work+0x380/0x380
[    2.391100]  ? kthread_park+0x90/0x90
[    2.391103]  ret_from_fork+0x35/0x40
[    2.393794] ---[ end trace a39c0e715c7be61d ]---
[    2.399294]  nvme0n1: p1 p2 p3 p4 p5 p6
[    2.472772] usb 1-3.3: New USB device found, idVendor=05ac,
idProduct=828f, bcdDevice= 1.12
[    2.474186] usb 1-3.3: New USB device strings: Mfr=1, Product=2,
SerialNumber=0
[    2.475734] usb 1-3.3: Product: Bluetooth USB Host Controller
[    2.477272] usb 1-3.3: Manufacturer: Apple Inc.

...

[   11.561741] print_req_error: operation not supported error, dev
nvme0n1, sector 437502136 flags 801
[   11.561760] EXT4-fs warning (device dm-1): ext4_end_bio:317: I/O
error 1 writing to inode 1974013 (offset 25288704 size 237568 starting
block 6516759)
[   11.561762] Buffer I/O error on device dm-1, logical block 6516759

...

[   11.561801] EXT4-fs (dm-1): Delayed block allocation failed for
inode 1974013 at logical offset 6234 with max blocks 2 with error 95
[   11.561804] EXT4-fs (dm-1): This should not happen!! Data will be
lost

...

[   11.649053] print_req_error: operation not supported error, dev
nvme0n1, sector 437502744 flags 801
[   11.649066] EXT4-fs warning (device dm-1): ext4_end_bio:317: I/O
error 1 writing to inode 1974013 (offset 25571328 size 266240 starting
block 6516835)

...

[   11.714748] print_req_error: operation not supported error, dev
nvme0n1, sector 435962536 flags 801
[   11.714908] Aborting journal on device dm-1-8.
[   11.715472] EXT4-fs error (device dm-1):
ext4_journal_check_start:61: Detected aborted journal 
[   11.715474] EXT4-fs (dm-1): Remounting filesystem read-only


Thanks for the help!
Iv?n
