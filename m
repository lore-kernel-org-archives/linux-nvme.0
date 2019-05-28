From: John.P.Donnelly@Oracle.com (John Donnelly)
Date: Tue, 28 May 2019 11:28:52 -0500
Subject: [GIT PULL] nvme fixes for 5.2
In-Reply-To: <20190516082541.GA19383@infradead.org>
References: <20190516082541.GA19383@infradead.org>
Message-ID: <5175ce5c-1943-a167-52f5-094a3d2dc4a4@Oracle.com>

On 5/16/19 3:25 AM, Christoph Hellwig wrote:
> The following changes since commit 936b33f7243fa1e54c8f4f2febd3472cc00e66fd:
> 
>    brd: add cond_resched to brd_free_pages (2019-05-09 12:51:27 -0600)
> 
> are available in the Git repository at:
> 
>    git://git.infradead.org/nvme.git nvme-5.2
> 
> for you to fetch changes up to 1b1031ca63b2ce1d3b664b35b77ec94e458693e9:
> 
>    nvme: validate cntlid during controller initialisation (2019-05-14 17:19:50 +0200)
> 
> ----------------------------------------------------------------
> Chaitanya Kulkarni (1):
>        nvme: trace all async notice events
> 
> Christoph Hellwig (2):
>        nvme: change locking for the per-subsystem controller list
>    **     nvme: validate cntlid during controller initialisation
> 
> Gustavo A. R. Silva (1):
>        nvme-pci: mark expected switch fall-through
> 
> Hannes Reinecke (2):
>        nvme-fc: use separate work queue to avoid warning
>     **   nvme-multipath: avoid crash on invalid subsystem cntlid enumeration



Hi
   In testing these commits denoted by "**"  I encountered another 
failure during fail-over of two name-spaces:


May 24 21:09:31 interop-57-161 kernel: RIP 0010:kernfs_remove_by_name_ns 
+ 0x7e/0x87
May 24 21:09:31 interop-57-161 kernel: RSP: 0018:ffffb7528937fd70 EFLAGS:
00010246
May 24 21:09:31 interop-57-161 kernel: RAX: 000000000000002c RBX:
0000000000000000 RCX: 0000000000000006
May 24 21:09:31 interop-57-161 kernel: RDX: 0000000000000000 RSI:
0000000000000086 RDI: ffff984560396930
May 24 21:09:31 interop-57-161 kernel: RBP: ffffb7528937fd88 R08:
ffffffff95972a84 R09: 00000000000013b1
May 24 21:09:31 interop-57-161 kernel: R10: 0000000000000000 R11:
0000000000000004 R12: ffff98455e3aa648
May 24 21:09:31 interop-57-161 kernel: R13: ffff9845605be310 R14:
ffff98455f03bc00 R15: ffff9845605be710
May 24 21:09:31 interop-57-161 kernel: FS:  0000000000000000(0000)
GS:ffff984560380000(0000) knlGS:0000000000000000
May 24 21:09:31 interop-57-161 kernel: CS:  0010 DS: 0000 ES: 0000 CR0:
0000000080050033
May 24 21:09:31 interop-57-161 kernel: CR2: 00007f44fa788000 CR3:
000000104940a005 CR4: 00000000007606e0
May 24 21:09:31 interop-57-161 kernel: DR0: 0000000000000000 DR1:
0000000000000000 DR2: 0000000000000000
May 24 21:09:31 interop-57-161 kernel: DR3: 0000000000000000 DR6:
00000000fffe0ff0 DR7: 0000000000000400
May 24 21:09:31 interop-57-161 kernel: PKRU: 55555554
May 24 21:09:31 interop-57-161 kernel: Call Trace:
May 24 21:09:31 interop-57-161 kernel: sysfs_remove_link+0x19/0x2b
May 24 21:09:31 interop-57-161 kernel: nvme_free_ctrl+0xaf/0x120 [nvme_core]
May 24 21:09:31 interop-57-161 kernel: device_release+0x35/0x8b
May 24 21:09:31 interop-57-161 kernel: kobject_cleanup+0x66/0x172
May 24 21:09:31 interop-57-161 kernel: kobject_put+0x2a/0x45
May 24 21:09:31 interop-57-161 kernel: put_device+0x17/0x1a
May 24 21:09:31 interop-57-161 kernel: nvme_delete_ctrl_work+0x86/0x90
[nvme_core]
May 24 21:09:31 interop-57-161 kernel: process_one_work+0x169/0x3a6
May 24 21:09:31 interop-57-161 kernel: worker_thread+0x4d/0x3e5
May 24 21:09:31 interop-57-161 kernel: kthread+0x105/0x138
May 24 21:09:31 interop-57-161 kernel: ? rescuer_thread+0x380/0x375
May 24 21:09:31 interop-57-161 kernel: ? kthread_bind+0x20/0x15
May 24 21:09:31 interop-57-161 kernel: ret_from_fork+0x24/0x49


Does this look familiar ?

Thank you,

John.
