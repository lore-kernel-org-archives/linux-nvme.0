From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 29 Jul 2016 16:40:40 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
Message-ID: <018301d1e9e1$da3b2e40$8eb18ac0$@opengridcomputing.com>

Running many fio jobs on 10 NVMF/RDMA ram disks, and bringing down and back up
the interfaces in a loop uncovers this crash.  I'm not sure if this has been
reported/fixed?  I'm using the for-linus branch of linux-block + sagi's 5
patches on the host.  

What this test tickles is keep-alive recovery in the presence of heavy
raw/direct IO.  Before the crash there are logs of these logged, which is
probably expected:

[  295.497642] blk_update_request: I/O error, dev nvme6n1, sector 21004
[  295.497643] nvme nvme6: nvme_rdma_post_send failed with error code -22
[  295.497644] blk_update_request: I/O error, dev nvme6n1, sector 10852
[  295.497646] nvme nvme6: nvme_rdma_post_send failed with error code -22
[  295.497647] blk_update_request: I/O error, dev nvme6n1, sector 32004
[  295.497653] nvme nvme6: nvme_rdma_post_send failed with error code -22
[  295.497655] nvme nvme6: nvme_rdma_post_send failed with error code -22
[  295.497658] nvme nvme6: nvme_rdma_post_send failed with error code -22
[  295.497660] nvme nvme6: nvme_rdma_post_send failed with error code -22

and these right before the crash:

[  295.591290] nvme nvme6: nvme_rdma_post_send failed with error code -22
[  295.591291] nvme nvme6: Queueing INV WR for rkey 0x2a26eee failed (-22)
[  295.591316] nvme nvme6: nvme_rdma_post_send failed with error code -22
[  295.591317] nvme nvme6: Queueing INV WR for rkey 0x2a26eef failed (-22)
[  295.591342] nvme nvme6: nvme_rdma_post_send failed with error code -22


The crash is a GPF because the qp has been freed, and due to debug kernel hacks,
the qp struct memory is 0x6b6b6b6b...

Any ideas?


Here's the log:

[  295.642191] general protection fault: 0000 [#1] SMP DEBUG_PAGEALLOC
[  295.642228] Modules linked in: nvme_rdma nvme_fabrics brd iw_cxgb4
ip6table_filter ip6_tables ebtable_nat ebtables ipt_MASQUERADE
nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4
nf_defrag_ipv4 xt_state nf_conntrack ipt_REJECT nf_reject_ipv4 cxgb4 xt_CHECKSUM
iptable_mangle iptable_filter ip_tables bridge 8021q mrp garp stp llc cachefiles
fscache rdma_ucm rdma_cm iw_cm ib_ipoib ib_cm ib_uverbs ib_umad ocrdma be2net
iw_nes libcrc32c iw_cxgb3 cxgb3 mdio ib_qib rdmavt mlx5_ib mlx5_core mlx4_ib
mlx4_en mlx4_core ib_mthca ib_core binfmt_misc dm_mirror dm_region_hash dm_log
vhost_net macvtap macvlan vhost tun kvm irqbypass uinput iTCO_wdt
iTCO_vendor_support mxm_wmi pcspkr dm_mod i2c_i801 sg lpc_ich mfd_core mei_me
mei nvme nvme_core igb dca ptp pps_core ipmi_si ipmi_msghandler wmi
[  295.642236]  ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E)
libata(E) mgag200(E) ttm(E) drm_kms_helper(E) drm(E) fb_sys_fops(E) sysimgblt(E)
sysfillrect(E) syscopyarea(E) i2c_algo_bit(E) i2c_core(E) [last unloaded: cxgb4]
[  295.642239] CPU: 8 PID: 18390 Comm: blkid Tainted: G            E
4.7.0-block-for-linus-debug+ #11
[  295.642240] Hardware name: Supermicro X9DR3-F/X9DR3-F, BIOS 3.2a 07/09/2015
[  295.642242] task: ffff880fb3418040 ti: ffff880fc06cc000 task.ti:
ffff880fc06cc000
[  295.642248] RIP: 0010:[<ffffffffa07fc083>]  [<ffffffffa07fc083>]
nvme_rdma_post_send+0x83/0xd0 [nvme_rdma]
[  295.642249] RSP: 0018:ffff880fc06cf7c8  EFLAGS: 00010286
[  295.642250] RAX: 6b6b6b6b6b6b6b6b RBX: ffff880fc37da698 RCX: 0000000000000001
[  295.642251] RDX: ffff880fc06cf7f0 RSI: ffff880fbf715d00 RDI: ffff880fc0afdfa8
[  295.642252] RBP: ffff880fc06cf808 R08: ffff880fbf715d00 R09: 0000000000000000
[  295.642253] R10: 0000000fb9f9b000 R11: ffff880fbf715d58 R12: ffff880fc37da698
[  295.642254] R13: ffff880fbf715cb0 R14: ffff880fee6522a8 R15: ffff880fbf6d1138
[  295.642255] FS:  00007f9abfe3e740(0000) GS:ffff881037000000(0000)
knlGS:0000000000000000
[  295.642256] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  295.642257] CR2: 0000003f691422e9 CR3: 0000000fcaab1000 CR4: 00000000000406e0
[  295.642258] Stack:
[  295.642260]  0000000000000000 ffff880fbf715cb8 ffff880fbf715cd0
0000000200000001
[  295.642262]  ffff880f00000000 ffff880fbf715cb0 ffff880fbf715b40
ffff880fc37da698
[  295.642264]  ffff880fc06cf858 ffffffffa07fdc92 ffff880fbf715b40
ffff880fc0eac748
[  295.642264] Call Trace:
[  295.642268]  [<ffffffffa07fdc92>] nvme_rdma_queue_rq+0x172/0x280 [nvme_rdma]
[  295.642273]  [<ffffffff81339e97>] blk_mq_make_request+0x2d7/0x560
[  295.642277]  [<ffffffff8119a5c5>] ? mempool_alloc_slab+0x15/0x20
[  295.642280]  [<ffffffff8132c6bc>] generic_make_request+0xfc/0x1d0
[  295.642282]  [<ffffffff8132c7f0>] submit_bio+0x60/0x130
[  295.642286]  [<ffffffff81264541>] submit_bh_wbc+0x161/0x1c0
[  295.642288]  [<ffffffff812645b3>] submit_bh+0x13/0x20
[  295.642291]  [<ffffffff81264eae>] block_read_full_page+0x20e/0x3e0
[  295.642293]  [<ffffffff81268c83>] ? __blkdev_get+0x193/0x420
[  295.642295]  [<ffffffff81266f60>] ? I_BDEV+0x20/0x20
[  295.642297]  [<ffffffff81199228>] ? pagecache_get_page+0x38/0x240
[  295.642300]  [<ffffffff811deae6>] ? page_add_file_rmap+0x56/0x160
[  295.642304]  [<ffffffff81111b3e>] ? is_module_text_address+0xe/0x20
[  295.642307]  [<ffffffff81267908>] blkdev_readpage+0x18/0x20
[  295.642309]  [<ffffffff81199b9a>] do_generic_file_read+0x20a/0x710
[  295.642314]  [<ffffffff8115566b>] ? rb_reserve_next_event+0xdb/0x230
[  295.642317]  [<ffffffff81040fbf>] ? save_stack_trace+0x2f/0x50
[  295.642319]  [<ffffffff81154baa>] ? rb_commit+0x10a/0x1a0
[  295.642321]  [<ffffffff8119a15c>] generic_file_read_iter+0xbc/0x110
[  295.642323]  [<ffffffff81154c64>] ? ring_buffer_unlock_commit+0x24/0xb0
[  295.642326]  [<ffffffff81267277>] blkdev_read_iter+0x37/0x40
[  295.642329]  [<ffffffff8122b37c>] __vfs_read+0xfc/0x120
[  295.642331]  [<ffffffff8122b44e>] vfs_read+0xae/0xf0
[  295.642335]  [<ffffffff812492a3>] ? __fdget+0x13/0x20
[  295.642337]  [<ffffffff8122bf56>] SyS_read+0x56/0xc0
[  295.642341]  [<ffffffff81003f5d>] do_syscall_64+0x7d/0x230
[  295.642345]  [<ffffffff8106f397>] ? do_page_fault+0x37/0x90
[  295.642350]  [<ffffffff816dbda1>] entry_SYSCALL64_slow_path+0x25/0x25
[  295.642367] Code: 47 08 83 c0 01 a8 1f 88 47 08 74 5b 45 84 c9 75 56 4d 85 c0
74 5a 48 8d 45 c0 49 89 00 48 8b 7b 30 48 8d 55 e8 4c 89 c6 48 8b 07 <ff> 90 c8
01 00 00 85 c0 41 89 c4 74 23 48 8b 43 18 44 89 e1 48
[  295.642371] RIP  [<ffffffffa07fc083>] nvme_rdma_post_send+0x83/0xd0
[nvme_rdma]
[  295.642371]  RSP <ffff880fc06cf7c8>
crash> mod -s nvme_rdma
     MODULE       NAME                      SIZE  OBJECT FILE
ffffffffa0801240  nvme_rdma                28672
/lib/modules/4.7.0-block-for-linus-debug+/kernel/drivers/nvme/host/nvme-rdma.ko
crash> gdb list *nvme_rdma_post_send+0x83
0xffffffffa07fc083 is in nvme_rdma_post_send (include/rdma/ib_verbs.h:2619).
2614     */
2615    static inline int ib_post_send(struct ib_qp *qp,
2616                                   struct ib_send_wr *send_wr,
2617                                   struct ib_send_wr **bad_send_wr)
2618    {
2619            return qp->device->post_send(qp, send_wr, bad_send_wr);
2620    }
2621
2622    /**
2623     * ib_post_recv - Posts a list of work requests to the receive queue of
crash>
