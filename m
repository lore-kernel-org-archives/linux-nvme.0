From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 25 Sep 2015 15:11:37 -0700
Subject: [PATCH 2/7] nvme: switch AEN processing to use
 blk_execute_rq_nowait
In-Reply-To: <alpine.LNX.2.00.1509241346570.23840@localhost.lm.intel.com>
References: <1442860853-26447-1-git-send-email-hch@lst.de>
 <1442860853-26447-3-git-send-email-hch@lst.de>
 <alpine.LNX.2.00.1509232128470.23840@localhost.lm.intel.com>
 <20150924133850.GA6350@lst.de>
 <alpine.LNX.2.00.1509241346570.23840@localhost.lm.intel.com>
Message-ID: <20150925221137.GA17965@infradead.org>

On Thu, Sep 24, 2015@01:51:33PM +0000, Keith Busch wrote:
> >Yigal, is there a nice easy way to trigger the CPU hotplug migration
> >through sysfs or another userspace interface?  I think I can solve
> >this without freeing the AEN early with a little more thought.
> 
> To take a cpu offline and trigger a removal:
> 
>   echo 0 > /sys/devices/system/cpu/cpu1/online

That is already broken in 4.3-rc2 unfortunately:

[  149.094678] Failed to recover vector for irq 104
[  149.144128] BUG: unable to handle kernel NULL pointer dereference at 00000000
[  149.152022] IP: [<ffffffff8131e0b1>] blk_mq_map_swqueue+0xf1/0x260
[  149.158239] PGD c9d59067 PUD c78ac067 PMD 0 
[  149.162556] Oops: 0002 [#1] SMP DEBUG_PAGEALLOC 
[  149.167222] Modules linked in: nfsd auth_rpcgss oid_registry nfs_acl nfs loc2
[  149.249367] CPU: 7 PID: 1192 Comm: bash Tainted: G          I 4.3.0-rc2+9
[  149.256788] Hardware name: Dell Inc. PowerEdge R710/00NH4P, BIOS 3.0.0 01/311
[  149.264295] task: ffff8806115f8040 ti: ffff880613124000 task.ti: ffff88061310
[  149.271805] RIP: 0010:[<ffffffff8131e0b1>]  [<ffffffff8131e0b1>] blk_mq_map_0
[  149.280461] RSP: 0018:ffff880613127c28  EFLAGS: 00010282
[  149.285789] RAX: ffff880604b9ac00 RBX: ffffe8fcf6f06a80 RCX: ffff8803234edf00
[  149.292946] RDX: 0000000000000000 RSI: 0000000000000009 RDI: ffff8806049c12e0
[  149.300103] RBP: ffff880613127c60 R08: 0000000000000007 R09: 0000000000000000
[  149.307261] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000009
[  149.314419] R13: ffff8806049c12e0 R14: ffff880607fcdc20 R15: ffffffff81d2ad00
[  149.321577] FS:  00007fa17ee79700(0000) GS:ffff880323ac0000(0000) knlGS:00000
[  149.329694] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  149.335457] CR2: 0000000000000080 CR3: 00000000caf51000 CR4: 00000000000006e0
[  149.342616] Stack:
[  149.344633]  0000000000000000 0000000000000000 ffff8806049c12e0 ffffffff81cc0
[  149.352101]  ffffffff81cfaa00 0000000000000000 0000000000000001 ffff880613120
[  149.359567]  ffffffff81320227 ffffffff81cc4740 00000000ffffffe1 ffff880613120
[  149.367034] Call Trace:
[  149.369491]  [<ffffffff81320227>] blk_mq_queue_reinit_notify+0x137/0x1d0
[  149.376216]  [<ffffffff810a16fd>] notifier_call_chain+0x5d/0x80
[  149.382156]  [<ffffffff810a172e>] __raw_notifier_call_chain+0xe/0x10
[  149.388533]  [<ffffffff8107ba13>] cpu_notify+0x23/0x40
[  149.393687]  [<ffffffff8107bb3e>] cpu_notify_nofail+0xe/0x20
[  149.399365]  [<ffffffff8107be05>] _cpu_down+0x1b5/0x2b0
[  149.404607]  [<ffffffff8107bf36>] cpu_down+0x36/0x50
[  149.409589]  [<ffffffff8146b9a4>] cpu_subsys_offline+0x14/0x20
[  149.415443]  [<ffffffff81466478>] device_offline+0x88/0xb0
[  149.420947]  [<ffffffff8146656d>] online_store+0x3d/0x80
[  149.426277]  [<ffffffff81463798>] dev_attr_store+0x18/0x30
[  149.431782]  [<ffffffff81296765>] sysfs_kf_write+0x45/0x60
[  149.437286]  [<ffffffff81296111>] kernfs_fop_write+0x141/0x190
[  149.443140]  [<ffffffff8120e8b8>] __vfs_write+0x28/0xe0
[  149.448385]  [<ffffffff810cb92f>] ? percpu_down_read+0x5f/0xa0
[  149.455461]  [<ffffffff81211cc1>] ? __sb_start_write+0xf1/0x110
[  149.462610]  [<ffffffff81211cc1>] ? __sb_start_write+0xf1/0x110
[  149.469747]  [<ffffffff8120efa9>] vfs_write+0xa9/0x190
[  149.476074]  [<ffffffff8122ff96>] ? __fget_light+0x66/0x90
[  149.482726]  [<ffffffff8120fcb9>] SyS_write+0x49/0xa0
[  149.488935]  [<ffffffff81618236>] entry_SYSCALL_64_fastpath+0x16/0x7a
