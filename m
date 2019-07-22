From: mark.wunderlich@intel.com (Wunderlich, Mark)
Date: Mon, 22 Jul 2019 21:27:08 +0000
Subject: nvme-tcp: 'page must not be a Slab one'
Message-ID: <B33B37937B7F3D4CB878107E305D4916D14FD1@ORSMSX104.amr.corp.intel.com>

New to this list, not to NVMe_oF.? Apologize up front if this is not an appropriate use of this forum, please slap wrist appropriately if so. 

Am developing for NVMe_oF/TCP, and seeing the failure message in subject line during kernel_sendpage.
This failure new to me starting with v5.1.? See it in v5.2 and stable 5.2.1

Wondering if this is related to 'nvme-tcp: replace sendpage calls with sendmsg calls for SLAB chunks'?.? If so, is there patch in the works to address it, or did I miss it.

Failure details from dmesg:
[? 149.087748] page must not be a Slab one [? 149.087768] WARNING: CPU: 0 PID: 1760 at net/ipv4/tcp.c:947 do_tcp_sendpages+0x5dd/0x600 [? 149.087783] CPU: 0 PID: 1760 Comm: kworker/0:1H Tainted: G?????????? O????? 5.1.0stable #4 [? 149.087784] Hardware name: Dell Inc. PowerEdge R740/00WGD1, BIOS 1.4.9 06/29/2018 [? 149.087786] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp] [? 149.087789] RIP: 0010:do_tcp_sendpages+0x5dd/0x600 [? 149.087790] Code: 19 d2 00 00 8b 04 24 e9 d5 fa ff ff 48 83 ef 01 e9 97 fe ff ff 48 c7 c7 86 a7 16 8b 31 c0 c6 05 42 b1 b9 00 01 e8 b3 86 88 ff <0f> 0b eb 99 48 83 e8 01 e9 bb fe ff ff 48 c7 c6 c8 21 09 8b e8 2a [? 149.087791] RSP: 0018:ffffbae348843cc8 EFLAGS: 00010282 [? 149.087792] RAX: 0000000000000000 RBX: ffff93bfffdda200 RCX: 0000000000000000 [? 149.087792] RDX: 000000000000001b RSI: ffffffff8ba7b59b RDI: 0000000000000246 [? 149.087793] RBP: fffff2fe40c5cdc0 R08: ffffffff8ba7b580 R09: fffeb64d287a9675 [? 149.087794] R10: 00000000000006e0 R11: 0000000000001a1b R12: 00000000000000c0 [? 149.087794] R13: fffff2fe40c5cdc0 R14: 0000000000000400 R15: 0000000000000001 [? 149.087796] FS:? 0000000000000000(0000) GS:ffff93c03f200000(0000) knlGS:0000000000000000 [? 149.087797] CS:? 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [? 149.087797] CR2: 00007faa5a037140 CR3: 000000067820e003 CR4: 00000000007606f0 [? 149.087798] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 [? 149.087799] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400 [? 149.087799] PKRU: 55555554 [? 149.087800] Call Trace:
[? 149.087804]? tcp_sendpage_locked+0x47/0x60 [? 149.087806]? tcp_sendpage+0x3d/0x60 [? 149.087808]? inet_sendpage+0x3f/0xf0 [? 149.087812]? kernel_sendpage+0x1a/0x30 [? 149.087815]? nvme_tcp_io_work+0x3cc/0x7f0 [nvme_tcp] [? 149.087819]? ? __switch_to_asm+0x34/0x70 [? 149.087824]? process_one_work+0x16c/0x380 [? 149.087825]? worker_thread+0x49/0x3e0 [? 149.087827]? kthread+0xf8/0x130 [? 149.087829]? ? max_active_store+0x80/0x80 [? 149.087830]? ? kthread_bind+0x10/0x10 [? 149.087831]? ret_from_fork+0x35/0x40 [? 149.087833] ---[ end trace 63a61a0696193cca ]--- [? 149.087836] nvme nvme0: failed to send request -22 [? 149.088070] nvme nvme0: Connect command failed, error wo/DNR bit: 4 [? 149.088367] nvme nvme0: failed to connect queue: 0 ret=4

Cheers --- Mark
