From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 31 Aug 2016 15:12:51 -0500
Subject: crash when connecting to targets using nr_io_queues < num cpus
Message-ID: <011401d203c4$0cdd78c0$26986a40$@opengridcomputing.com>

Hey all,

I'm testing smaller ioq sets with nvmf/rdma, and I see some issue.  If I connect
with 2, 4, 6, 8, 10, 16, or 32  for nr_io_queues, everything is happy.  It
seems, though, if I connect with a value of 12, or 28, or some other non power
of two, I get intermittent crashes in __blk_mq_get_reserved_tag() at line 337
when setting up a controller's IO queues.   I'm not sure exactly if this is
always non power of two, or something else, but it seems to never crash with
power of two values (could be a coincidence I guess).

Here:

crash> gdb list *blk_mq_get_tag+0x29
0xffffffff8133b239 is in blk_mq_get_tag (block/blk-mq-tag.c:337).
332
333     static unsigned int __blk_mq_get_reserved_tag(struct blk_mq_alloc_data
*data)
334     {
335             int tag, zero = 0;
336
337             if (unlikely(!data->hctx->tags->nr_reserved_tags)) { 
338                     WARN_ON_ONCE(1);
339                     return BLK_MQ_TAG_FAIL;
340             }
341

This is with linux-4.8-rc3.  Are there restrictions on the number of queues that
can be setup other than <= nr_cpus?

>From my initial debug, it is passed an hctx with a NULL tag pointer.  So
data->hctx->tags is NULL causing this crash:

[  125.225879] nvme nvme1: creating 26 I/O queues.
[  125.346655] BUG: unable to handle kernel NULL pointer dereference at
0000000000000004
[  125.355543] IP: [<ffffffff8133b239>] blk_mq_get_tag+0x29/0xc0
[  125.362332] PGD ff81e9067 PUD 1004ecc067 PMD 0
[  125.367955] Oops: 0000 [#1] SMP
[  125.372078] Modules linked in: nvme_rdma nvme_fabrics brd iw_cxgb4 cxgb4
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
[  125.475243] CPU: 0 PID: 11439 Comm: nvme Tainted: G            E
4.8.0-rc3-nvmf+block+reboot #26
[  125.485382] Hardware name: Supermicro X9DR3-F/X9DR3-F, BIOS 3.2a 07/09/2015
[  125.493530] task: ffff881034994140 task.stack: ffff8810319bc000
[  125.500667] RIP: 0010:[<ffffffff8133b239>]  [<ffffffff8133b239>]
blk_mq_get_tag+0x29/0xc0
[  125.510108] RSP: 0018:ffff8810319bfa58  EFLAGS: 00010202
[  125.516650] RAX: ffff880fe09c1800 RBX: ffff8810319bfae8 RCX: 0000000000000000
[  125.525038] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8810319bfae8
[  125.533423] RBP: ffff8810319bfa78 R08: 0000000000000000 R09: 0000000000000000
[  125.541814] R10: ffff88103e807200 R11: 0000000000000001 R12: 0000000000000001
[  125.550185] R13: 0000000000000000 R14: ffff880fe09c1800 R15: 0000000000000000
[  125.558548] FS:  00007fc764c0a700(0000) GS:ffff88103ee00000(0000)
knlGS:0000000000000000
[  125.567880] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  125.574873] CR2: 0000000000000004 CR3: 000000102869f000 CR4: 00000000000406f0
[  125.583264] Stack:
[  125.586547]  dead000000000200 0000000081332b5d 0000000000000001
ffff8810319bfae8
[  125.595292]  ffff8810319bfad8 ffffffff81336142 ffff881004ea35d0
ffff8810319bfc08
[  125.604062]  ffff8810319bfb48 ffffffff81332ccc 0000000000000000
ffff881004da91c0
[  125.612826] Call Trace:
[  125.616575]  [<ffffffff81336142>] __blk_mq_alloc_request+0x32/0x260
[  125.624142]  [<ffffffff81332ccc>] ? blk_execute_rq+0x8c/0x110
[  125.631187]  [<ffffffff81336d95>] blk_mq_alloc_request_hctx+0xb5/0x110
[  125.639012]  [<ffffffffa00affd7>] nvme_alloc_request+0x37/0x90 [nvme_core]
[  125.647170]  [<ffffffffa00b057c>] __nvme_submit_sync_cmd+0x3c/0xe0
[nvme_core]
[  125.655685]  [<ffffffffa065bdc4>] nvmf_connect_io_queue+0x114/0x160
[nvme_fabrics]
[  125.664551]  [<ffffffffa06388b7>] nvme_rdma_create_io_queues+0x1b7/0x210
[nvme_rdma]
[  125.673565]  [<ffffffffa0639643>] ?
nvme_rdma_configure_admin_queue+0x1e3/0x280 [nvme_rdma]
[  125.683198]  [<ffffffffa0639a83>] nvme_rdma_create_ctrl+0x3a3/0x4c0
[nvme_rdma]
[  125.691793]  [<ffffffff81205fcd>] ? kmem_cache_alloc_trace+0x14d/0x1a0
[  125.699582]  [<ffffffffa065bf92>] nvmf_create_ctrl+0x182/0x210 [nvme_fabrics]
[  125.707986]  [<ffffffffa065c0cc>] nvmf_dev_write+0xac/0x108 [nvme_fabrics]
[  125.716131]  [<ffffffff8122d144>] __vfs_write+0x34/0x120
[  125.722697]  [<ffffffff81003725>] ?
trace_event_raw_event_sys_enter+0xb5/0x130
[  125.731153]  [<ffffffff8122d2f1>] vfs_write+0xc1/0x130
[  125.737541]  [<ffffffff81249793>] ? __fdget+0x13/0x20
[  125.743813]  [<ffffffff8122d466>] SyS_write+0x56/0xc0
[  125.750070]  [<ffffffff81003e7d>] do_syscall_64+0x7d/0x230
[  125.756755]  [<ffffffff8106f057>] ? do_page_fault+0x37/0x90
[  125.763527]  [<ffffffff816e17e1>] entry_SYSCALL64_slow_path+0x25/0x25
[  125.771154] Code: 00 00 55 48 89 e5 53 48 83 ec 18 66 66 66 66 90 f6 47 08 02
48 89 fb 74 34 c7 45 ec 00 00 00 00 48 8b 47 18 4c 8b 80 90 01 00 00 <41> 8b 70
04 85 f6 74 5b 48 8d 4d ec 49 8d 70 38 31 d2 e8 80 fd
[  125.793923] RIP  [<ffffffff8133b239>] blk_mq_get_tag+0x29/0xc0
[  125.800957]  RSP <ffff8810319bfa58>
[  125.805583] CR2: 0000000000000004
