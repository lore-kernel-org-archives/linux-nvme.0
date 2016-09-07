From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 7 Sep 2016 16:08:50 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <0c159abb-24ee-21bf-09d2-9fe7d269a2eb@grimberg.me>
References: <018301d1e9e1$da3b2e40$8eb18ac0$@opengridcomputing.com>
 <20160801110658.GF16141@lst.de>
 <008801d1ec00$a0bcfbf0$e236f3d0$@opengridcomputing.com>
 <015801d1ec3d$0ca07ea0$25e17be0$@opengridcomputing.com>
 <010f01d1f31e$50c8cb40$f25a61c0$@opengridcomputing.com>
 <013701d1f320$57b185d0$07149170$@opengridcomputing.com>
 <018401d1f32b$792cfdb0$6b86f910$@opengridcomputing.com>
 <01a301d1f339$55ba8e70$012fab50$@opengridcomputing.com>
 <2fb1129c-424d-8b2d-7101-b9471e897dc8@grimberg.me>
 <004701d1f3d8$760660b0$62132210$@opengridcomputing.com>
 <008101d1f3de$557d2850$007778f0$@opengridcomputing.com>
 <00fe01d1f3e8$8992b330$9cb81990$@opengridcomputing.com>
 <01c301d1f702$d28c7270$77a55750$@opengridcomputing.com>
 <6ef9b0d1-ce84-4598-74db-7adeed313bb6@grimberg.me>
 <045601d1f803$a9d73a20$fd85ae60$@opengridcomputing.com>
 <69c0e819-76d9-286b-c4fb-22f087f36ff1@grimberg.me>
 <08b701d1f8ba$a709ae10$f51d0a30$@opengridcomputing.com>
 <01c301d20485$0dfcd2c0$29f67840$@opengridcomputing.com> <0c159abb
 -24ee-21bf-09d2-9fe7d2 69a2eb@grimberg.me>
Message-ID: <039401d2094c$084d64e0$18e82ea0$@opengridcomputing.com>

> Hey Steve,
> 
> > Ok, back to this issue. :)
> >
> > The same crash happens with mlx4_ib, so this isn't related to cxgb4.  To sum
up:
> >
> > With pending NVME IO on the nvme-rdma host, and in the presence of kato
> > recovery/reconnect due to the target going away, some NVME requests get
> > restarted that are referencing nvmf controllers that have freed queues.  I
see
> > this also with my recent v4 series that corrects the recovery problems with
> > nvme-rdma when the target is down, but without pending IO.
> >
> > So the crash in this email is yet another issue that we see when the nvme
host
> > has lots of pending IO requests during kato recovery/reconnect...
> >
> > My findings to date:  the IO is not an admin queue IO.  It is not the kato
> > messages.  The io queue has been stopped, yet the request is attempted and
> > causes the crash.
> >
> > Any help is appreciated...
> 
> So in the current state, my impression is that we are seeing a request
> queued when we shouldn't (or at least assume we won't).
> 
> Given that you run heavy load to reproduce this, I can only suspect that
> this is a race condition.
> 
> Does this happen if you change the reconnect delay to be something
> different than 10 seconds? (say 30?)
>

Yes.  But I noticed something when performing this experiment that is an
important point, I think:  if I just bring the network interface down and leave
it down, we don't crash.  During this state, I see the host continually
reconnecting after the reconnect delay time, timing out trying to reconnect, and
retrying after another reconnect_delay period.  I see this for all 10 targets of
course.  The crash only happens when I bring the interface back up, and the
targets begin to reconnect.   So the process of successfully reconnecting the
RDMA QPs, and restarting the nvme queues is somehow triggering running an nvme
request too soon (or perhaps on the wrong queue).   
 
> Can you also give patch [1] a try? It's not a solution, but I want
> to see if it hides the problem...
> 

hmm.  I ran the experiment once with [1] and it didn't crash.  I ran it a 2nd
time and hit a new crash.  Maybe a problem with [1]?

[  379.864950] BUG: unable to handle kernel NULL pointer dereference at
0000000000000024
[  379.874330] IP: [<ffffffffa0307ad1>] ib_destroy_qp+0x21/0x1a0 [ib_core]
[  379.882489] PGD 1002571067 PUD fa121f067 PMD 0
[  379.888561] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC
[  379.894526] Modules linked in: nvme_rdma nvme_fabrics brd iw_cxgb4 cxgb4
ip6table_filter ip6_tables ebtable_nat ebtables ipt_MASQUERADE
nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4
nf_defrag_ipv4 xt_state nf_conntrack ipt_REJECT nf_reject_ipv4 xt_CHECKSUM
iptable_mangle iptable_filter ip_tables bridge 8021q mrp garp stp llc cachefiles
fscache rdma_ucm rdma_cm iw_cm ib_ipoib ib_cm ib_uverbs ib_umad ocrdma be2net
iw_nes libcrc32c iw_cxgb3 cxgb3 mdio ib_qib rdmavt mlx5_ib mlx5_core mlx4_ib
mlx4_en mlx4_core ib_mthca ib_core binfmt_misc dm_mirror dm_region_hash dm_log
vhost_net macvtap macvlan vhost tun kvm irqbypass uinput iTCO_wdt
iTCO_vendor_support mxm_wmi pcspkr dm_mod i2c_i801 i2c_smbus sg lpc_ich mfd_core
mei_me mei nvme nvme_core igb dca ptp pps_core ipmi_si ipmi_msghandler wmi
ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) libata(E) mgag200(E)
ttm(E) drm_kms_helper(E) drm(E) fb_sys_fops(E) sysimgblt(E) sysfillrect(E)
syscopyarea(E) i2c_algo_bit(E) i2c_core(E) [last unloaded: cxgb4]
[  380.005238] CPU: 30 PID: 10981 Comm: kworker/30:2 Tainted: G            E
4.8.0-rc4-block-for-linus-dbg+ #32
[  380.017596] Hardware name: Supermicro X9DR3-F/X9DR3-F, BIOS 3.2a 07/09/2015
[  380.027002] Workqueue: nvme_rdma_wq nvme_rdma_reconnect_ctrl_work [nvme_rdma]
[  380.036664] task: ffff880fd014af40 task.stack: ffff881013b38000
[  380.045082] RIP: 0010:[<ffffffffa0307ad1>]  [<ffffffffa0307ad1>]
ib_destroy_qp+0x21/0x1a0 [ib_core]
[  380.056562] RSP: 0018:ffff881013b3bb88  EFLAGS: 00010286
[  380.064291] RAX: ffff880fd014af40 RBX: ffff880fba6d3a78 RCX: 0000000000000000
[  380.073733] RDX: ffff881037593d20 RSI: ffff88103758dfc8 RDI: 0000000000000000
[  380.083030] RBP: ffff881013b3bbe8 R08: 0000000000000000 R09: 0000000000000000
[  380.092230] R10: ffffffffa0030060 R11: 0000000000000000 R12: ffff880fba6d3c98
[  380.101442] R13: 00000000ffffff98 R14: ffff88101ce78008 R15: ffff88100507c968
[  380.110541] FS:  0000000000000000(0000) GS:ffff881037580000(0000)
knlGS:0000000000000000
[  380.120507] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  380.128048] CR2: 0000000000000024 CR3: 0000000fa12f6000 CR4: 00000000000406e0
[  380.136990] Stack:
[  380.140714]  ffff881013b3bb98 0000000000000246 000003e800000286
ffffffffa0733fe0
[  380.149939]  ffff881013b3bbd8 ffffffffa0274588 ffff881013b3bbe8
ffff880fba6d3a78
[  380.159113]  ffff880fba6d3c98 00000000ffffff98 ffff88101ce78008
ffff88100507c968
[  380.168205] Call Trace:
[  380.172280]  [<ffffffffa0733fe0>] ? cma_work_handler+0xa0/0xa0 [rdma_cm]
[  380.180546]  [<ffffffffa0731611>] rdma_destroy_qp+0x31/0x50 [rdma_cm]
[  380.188483]  [<ffffffffa0661e92>] nvme_rdma_destroy_queue_ib+0x52/0xb0
[nvme_rdma]
[  380.197566]  [<ffffffffa0662678>] nvme_rdma_init_queue+0x128/0x180
[nvme_rdma]
[  380.206264]  [<ffffffffa0662a09>] nvme_rdma_reconnect_ctrl_work+0x79/0x220
[nvme_rdma]
[  380.215606]  [<ffffffff810a15e3>] process_one_work+0x183/0x4d0
[  380.222820]  [<ffffffff816de9f0>] ? __schedule+0x1f0/0x5b0
[  380.229680]  [<ffffffff816deeb0>] ? schedule+0x40/0xb0
[  380.236147]  [<ffffffff810a227d>] worker_thread+0x16d/0x530
[  380.243051]  [<ffffffff810b43d5>] ?
trace_event_raw_event_sched_switch+0xe5/0x130
[  380.251821]  [<ffffffff816de9f0>] ? __schedule+0x1f0/0x5b0
[  380.258600]  [<ffffffff810cba86>] ? __wake_up_common+0x56/0x90
[  380.265676]  [<ffffffff810a2110>] ? maybe_create_worker+0x120/0x120
[  380.273153]  [<ffffffff816deeb0>] ? schedule+0x40/0xb0
[  380.279504]  [<ffffffff810a2110>] ? maybe_create_worker+0x120/0x120
[  380.286993]  [<ffffffff810a6dbc>] kthread+0xcc/0xf0
[  380.293078]  [<ffffffff810b177e>] ? schedule_tail+0x1e/0xc0
[  380.299857]  [<ffffffff816e2b7f>] ret_from_fork+0x1f/0x40
