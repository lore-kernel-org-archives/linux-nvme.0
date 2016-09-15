From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 15 Sep 2016 10:53:14 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <012001d20f63$5c8f7490$15ae5db0$@opengridcomputing.com>
References: <018301d1e9e1$da3b2e40$8eb18ac0$@opengridcomputing.com>
 <008101d1f3de$557d2850$007778f0$@opengridcomputing.com>
 <00fe01d1f3e8$8992b330$9cb81990$@opengridcomputing.com>
 <01c301d1f702$d28c7270$77a55750$@opengridcomputing.com>
 <6ef9b0d1-ce84-4598-74db-7adeed313bb6@grimberg.me>
 <045601d1f803$a9d73a20$fd85ae60$@opengridcomputing.com>
 <69c0e819-76d9-286b-c4fb-22f087f36ff1@grimberg.me>
 <08b701d1f8ba$a709ae10$f51d0a30$@opengridcomputing.com>
 <01c301d20485$0dfcd2c0$29f67840$@opengridcomputing.com> <0c159abb
 -24ee-21bf-09d2-9fe7d2 69a2eb@grimberg.me>
 <039401d2094c$084d64e0$18e82ea0$@opengridcomputing.com>
 <7f09e373-6316-26a3-ae81-dab1205d88ab@grimbe rg.me> <021201d20a14$ 0
 f203b80$2d60b280$@opengridcomputing.com>
 <021401d20a16$ed60d470$c8227d50$@opengridcomputing.com>
 <021501d20a19$327ba5b0$9772f110$@opengridcomputing.com>
 <00ab01d20ab1$ed212ff0$c7638fd0$@opengridcomputing.com>
 <022701d20d31$a9645850$fc2d08f0$@opengridcomputing.com>
 <da2e918b-0f18-e032-272d-368c6ec49c62@gri mberg.me> <011501d20f
 5f$b94e6c80$2beb4580$@opengridcomputing.com>
 <012001d20f63$5c8f7490$15ae5db0$@opengridcomputing.com>
Message-ID: <01d201d20f69$449abce0$cdd036a0$@opengridcomputing.com>

> 
> The hctx passed into nvme_rdma_queue_rq() is in state BLK_MQ_S_TAG_ACTIVE.
> And
> hctx->driver_data is the nvme_rdma_queue to be used.  That nvme_rdma_queue
> has a
> different hctx pointer (from my debug code) and that's why we hit the
BUG_ON().
> Anyway, nvme_rdma_queue->hctx->state is BLK_MQ_S_STOPPED.  So this is more
> evidence that somehow an hctx is using an nvme_rdma_queue that wasn't
> originally
> assigned to that hctx...
> 

I added this to my debug patch.  I will warn on if an hctx is initialized twice
or if it a 2nd hctx is bound to an nvme_rdma_queue that is already bound to
another hctx:

@@ -383,7 +384,12 @@ static int nvme_rdma_init_hctx(struct blk_mq_hw_ctx *hctx,
void *data,

        BUG_ON(hctx_idx >= ctrl->queue_count);

+       dev_warn(ctrl->ctrl.device, "%s hctx_idx %u hctx %p hctx->driver_data %p
queue %p queue->hctx %p\n",
+               __func__, hctx_idx, hctx, hctx->driver_data, queue,
queue->hctx);
+       WARN_ON_ONCE(hctx->driver_data);
        hctx->driver_data = queue;
+       WARN_ON_ONCE(queue->hctx);
+       queue->hctx = hctx;
        return 0;
 }

And I see that 2 sets of blk_mq_hw_ctx structs get assigned to the same 32
queues.  Here is the output for 1 target connect with 32 cores.  So is it
expected that the 32 nvme_rdma IO queues get assigned to 2 sets of hw_ctx
structs?  The 2nd set is getting initialized as part of namespace scanning...

[  652.782267] nvme nvme1: creating 32 I/O queues.
[  653.373979] nvme nvme1: nvme_rdma_init_hctx hctx_idx 0 hctx ffff880e75dd0ff8
hctx->driver_data           (null) queue ffff880fce71e860 queue->hctx
(null)
[  653.394416] nvme nvme1: nvme_rdma_init_hctx hctx_idx 1 hctx ffff880e75dd6a48
hctx->driver_data           (null) queue ffff880fce71e8d8 queue->hctx
(null)
[  653.414415] nvme nvme1: nvme_rdma_init_hctx hctx_idx 2 hctx ffff880e75dd1548
hctx->driver_data           (null) queue ffff880fce71e950 queue->hctx
(null)
[  653.434027] nvme nvme1: nvme_rdma_init_hctx hctx_idx 3 hctx ffff880e75dd64f8
hctx->driver_data           (null) queue ffff880fce71e9c8 queue->hctx
(null)
[  653.453489] nvme nvme1: nvme_rdma_init_hctx hctx_idx 4 hctx ffff880e75dd5fa8
hctx->driver_data           (null) queue ffff880fce71ea40 queue->hctx
(null)
[  653.472782] nvme nvme1: nvme_rdma_init_hctx hctx_idx 5 hctx ffff880e75dd1a98
hctx->driver_data           (null) queue ffff880fce71eab8 queue->hctx
(null)
[  653.491934] nvme nvme1: nvme_rdma_init_hctx hctx_idx 6 hctx ffff880e75dd1fe8
hctx->driver_data           (null) queue ffff880fce71eb30 queue->hctx
(null)
[  653.510957] nvme nvme1: nvme_rdma_init_hctx hctx_idx 7 hctx ffff880e75dd5a58
hctx->driver_data           (null) queue ffff880fce71eba8 queue->hctx
(null)
[  653.530070] nvme nvme1: nvme_rdma_init_hctx hctx_idx 8 hctx ffff880e75dd5508
hctx->driver_data           (null) queue ffff880fce71ec20 queue->hctx
(null)
[  653.551448] nvme nvme1: nvme_rdma_init_hctx hctx_idx 9 hctx ffff880e75dd2538
hctx->driver_data           (null) queue ffff880fce71ec98 queue->hctx
(null)
[  653.572524] nvme nvme1: nvme_rdma_init_hctx hctx_idx 10 hctx ffff880e75dd4fb8
hctx->driver_data           (null) queue ffff880fce71ed10 queue->hctx
(null)
[  653.593434] nvme nvme1: nvme_rdma_init_hctx hctx_idx 11 hctx ffff880e75dd4a68
hctx->driver_data           (null) queue ffff880fce71ed88 queue->hctx
(null)
[  653.614228] nvme nvme1: nvme_rdma_init_hctx hctx_idx 12 hctx ffff880e743e0008
hctx->driver_data           (null) queue ffff880fce71ee00 queue->hctx
(null)
[  653.634809] nvme nvme1: nvme_rdma_init_hctx hctx_idx 13 hctx ffff880e743e7a38
hctx->driver_data           (null) queue ffff880fce71ee78 queue->hctx
(null)
[  653.655223] nvme nvme1: nvme_rdma_init_hctx hctx_idx 14 hctx ffff880e743e74e8
hctx->driver_data           (null) queue ffff880fce71eef0 queue->hctx
(null)
[  653.675474] nvme nvme1: nvme_rdma_init_hctx hctx_idx 15 hctx ffff880e743e0558
hctx->driver_data           (null) queue ffff880fce71ef68 queue->hctx
(null)
[  653.695558] nvme nvme1: nvme_rdma_init_hctx hctx_idx 16 hctx ffff880e743e0aa8
hctx->driver_data           (null) queue ffff880fce71efe0 queue->hctx
(null)
[  653.715577] nvme nvme1: nvme_rdma_init_hctx hctx_idx 17 hctx ffff880e743e6f98
hctx->driver_data           (null) queue ffff880fce71f058 queue->hctx
(null)
[  653.735383] nvme nvme1: nvme_rdma_init_hctx hctx_idx 18 hctx ffff880e743e6a48
hctx->driver_data           (null) queue ffff880fce71f0d0 queue->hctx
(null)
[  653.755053] nvme nvme1: nvme_rdma_init_hctx hctx_idx 19 hctx ffff880e743e0ff8
hctx->driver_data           (null) queue ffff880fce71f148 queue->hctx
(null)
[  653.774627] nvme nvme1: nvme_rdma_init_hctx hctx_idx 20 hctx ffff880e743e1548
hctx->driver_data           (null) queue ffff880fce71f1c0 queue->hctx
(null)
[  653.794081] nvme nvme1: nvme_rdma_init_hctx hctx_idx 21 hctx ffff880e743e64f8
hctx->driver_data           (null) queue ffff880fce71f238 queue->hctx
(null)
[  653.813415] nvme nvme1: nvme_rdma_init_hctx hctx_idx 22 hctx ffff880e743e5fa8
hctx->driver_data           (null) queue ffff880fce71f2b0 queue->hctx
(null)
[  653.832665] nvme nvme1: nvme_rdma_init_hctx hctx_idx 23 hctx ffff880e743e1a98
hctx->driver_data           (null) queue ffff880fce71f328 queue->hctx
(null)
[  653.851791] nvme nvme1: nvme_rdma_init_hctx hctx_idx 24 hctx ffff880e743e1fe8
hctx->driver_data           (null) queue ffff880fce71f3a0 queue->hctx
(null)
[  653.870780] nvme nvme1: nvme_rdma_init_hctx hctx_idx 25 hctx ffff880e743e5a58
hctx->driver_data           (null) queue ffff880fce71f418 queue->hctx
(null)
[  653.889632] nvme nvme1: nvme_rdma_init_hctx hctx_idx 26 hctx ffff880e743e5508
hctx->driver_data           (null) queue ffff880fce71f490 queue->hctx
(null)
[  653.908318] nvme nvme1: nvme_rdma_init_hctx hctx_idx 27 hctx ffff880e743e2538
hctx->driver_data           (null) queue ffff880fce71f508 queue->hctx
(null)
[  653.927036] nvme nvme1: nvme_rdma_init_hctx hctx_idx 28 hctx ffff880e743e2a88
hctx->driver_data           (null) queue ffff880fce71f580 queue->hctx
(null)
[  653.945760] nvme nvme1: nvme_rdma_init_hctx hctx_idx 29 hctx ffff880e743e4fb8
hctx->driver_data           (null) queue ffff880fce71f5f8 queue->hctx
(null)
[  653.964475] nvme nvme1: nvme_rdma_init_hctx hctx_idx 30 hctx ffff880e743e4a68
hctx->driver_data           (null) queue ffff880fce71f670 queue->hctx
(null)
[  653.983174] nvme nvme1: nvme_rdma_init_hctx hctx_idx 31 hctx ffff880e743e2fd8
hctx->driver_data           (null) queue ffff880fce71f6e8 queue->hctx
(null)
[  654.192720] nvme nvme1: new ctrl: NQN "test-ram0", addr 10.0.1.14:4420
[  654.205669] nvme nvme1: nvme_rdma_init_hctx hctx_idx 0 hctx ffff880e75dd2a88
hctx->driver_data           (null) queue ffff880fce71e860 queue->hctx
ffff880e75dd0ff8
[  654.228208] ------------[ cut here ]------------
[  654.236514] WARNING: CPU: 31 PID: 279 at drivers/nvme/host/rdma.c:391
nvme_rdma_init_hctx+0xb7/0xe0 [nvme_rdma]
[  654.250060] Modules linked in: nvme_rdma nvme_fabrics brd iw_cxgb4 cxgb4
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
[  654.368142] CPU: 31 PID: 279 Comm: kworker/31:1 Tainted: G            E
4.8.0-rc5-nvmf+block2-dbg+ #34
[  654.379719] Hardware name: Supermicro X9DR3-F/X9DR3-F, BIOS 3.2a 07/09/2015
[  654.388779] Workqueue: events nvme_scan_work [nvme_core]
[  654.396097]  0000000000000000 ffff881020dbb8b8 ffffffff8135b8b7
0000000000000117
[  654.405476]  0000000000000000 0000000000000000 0000000000000000
ffff881020dbb908
[  654.414792]  ffffffff81086eed ffff881020dbb8e8 00000187d3748534
ffffffffa066d200
[  654.424081] Call Trace:
[  654.428333]  [<ffffffff8135b8b7>] dump_stack+0x67/0x90
[  654.435266]  [<ffffffff81086eed>] __warn+0xfd/0x120
[  654.441894]  [<ffffffff81086f2d>] warn_slowpath_null+0x1d/0x20
[  654.449447]  [<ffffffffa0669407>] nvme_rdma_init_hctx+0xb7/0xe0 [nvme_rdma]
[  654.458118]  [<ffffffff8133a52e>] blk_mq_init_hctx+0x21e/0x2e0
[  654.465625]  [<ffffffff8133a6ea>] blk_mq_realloc_hw_ctxs+0xfa/0x240
[  654.473542]  [<ffffffff8133b342>] blk_mq_init_allocated_queue+0x92/0x410
[  654.481885]  [<ffffffff8132a969>] ? blk_alloc_queue_node+0x259/0x2c0
[  654.489833]  [<ffffffff8135ce84>] ? ida_pre_get+0xb4/0xe0
[  654.496798]  [<ffffffff8133b6ff>] blk_mq_init_queue+0x3f/0x70
[  654.504097]  [<ffffffffa0272998>] nvme_alloc_ns+0x88/0x240 [nvme_core]
[  654.512155]  [<ffffffffa02728bc>] ? nvme_find_get_ns+0x5c/0xb0 [nvme_core]
[  654.520533]  [<ffffffffa0273059>] nvme_validate_ns+0x79/0x90 [nvme_core]
[  654.528718]  [<ffffffffa0273166>] nvme_scan_ns_list+0xf6/0x1f0 [nvme_core]
[  654.537059]  [<ffffffffa027338b>] nvme_scan_work+0x12b/0x140 [nvme_core]
[  654.545199]  [<ffffffff810a1613>] process_one_work+0x183/0x4d0
[  654.552448]  [<ffffffff816dfa40>] ? __schedule+0x1f0/0x5b0
[  654.559314]  [<ffffffff816dff00>] ? schedule+0x40/0xb0
[  654.565810]  [<ffffffff810a22ad>] worker_thread+0x16d/0x530
[  654.572709]  [<ffffffff810a2140>] ? maybe_create_worker+0x120/0x120
[  654.580279]  [<ffffffff816dfa40>] ? __schedule+0x1f0/0x5b0
[  654.587061]  [<ffffffff810cbab6>] ? __wake_up_common+0x56/0x90
[  654.594146]  [<ffffffff810a2140>] ? maybe_create_worker+0x120/0x120
[  654.601644]  [<ffffffff816dff00>] ? schedule+0x40/0xb0
[  654.607998]  [<ffffffff810a2140>] ? maybe_create_worker+0x120/0x120
[  654.615459]  [<ffffffff810a6dec>] kthread+0xcc/0xf0
[  654.621505]  [<ffffffff810b17ae>] ? schedule_tail+0x1e/0xc0
[  654.628218]  [<ffffffff816e3bbf>] ret_from_fork+0x1f/0x40
[  654.634738]  [<ffffffff810a6d20>] ? kthread_freezable_should_stop+0x70/0x70
[  654.642845] ---[ end trace 83cb452b9aa631ae ]---
[  654.648809] nvme nvme1: nvme_rdma_init_hctx hctx_idx 1 hctx ffff880e75dd2fd8
hctx->driver_data           (null) queue ffff880fce71e8d8 queue->hctx
ffff880e75dd6a48
[  654.665803] nvme nvme1: nvme_rdma_init_hctx hctx_idx 2 hctx ffff880e75dd4518
hctx->driver_data           (null) queue ffff880fce71e950 queue->hctx
ffff880e75dd1548
[  654.682808] nvme nvme1: nvme_rdma_init_hctx hctx_idx 3 hctx ffff880e75dd3528
hctx->driver_data           (null) queue ffff880fce71e9c8 queue->hctx
ffff880e75dd64f8
[  654.699807] nvme nvme1: nvme_rdma_init_hctx hctx_idx 4 hctx ffff880e75dd3a78
hctx->driver_data           (null) queue ffff880fce71ea40 queue->hctx
ffff880e75dd5fa8
[  654.716822] nvme nvme1: nvme_rdma_init_hctx hctx_idx 5 hctx ffff880ff084ea48
hctx->driver_data           (null) queue ffff880fce71eab8 queue->hctx
ffff880e75dd1a98
[  654.733809] nvme nvme1: nvme_rdma_init_hctx hctx_idx 6 hctx ffff880e71c78008
hctx->driver_data           (null) queue ffff880fce71eb30 queue->hctx
ffff880e75dd1fe8
[  654.750808] nvme nvme1: nvme_rdma_init_hctx hctx_idx 7 hctx ffff880e71c7fa38
hctx->driver_data           (null) queue ffff880fce71eba8 queue->hctx
ffff880e75dd5a58
[  654.767860] nvme nvme1: nvme_rdma_init_hctx hctx_idx 8 hctx ffff880e71c7f4e8
hctx->driver_data           (null) queue ffff880fce71ec20 queue->hctx
ffff880e75dd5508
[  654.785002] nvme nvme1: nvme_rdma_init_hctx hctx_idx 9 hctx ffff880e71c78558
hctx->driver_data           (null) queue ffff880fce71ec98 queue->hctx
ffff880e75dd2538
[  654.802337] nvme nvme1: nvme_rdma_init_hctx hctx_idx 10 hctx ffff880e71c78aa8
hctx->driver_data           (null) queue ffff880fce71ed10 queue->hctx
ffff880e75dd4fb8
[  654.819704] nvme nvme1: nvme_rdma_init_hctx hctx_idx 11 hctx ffff880e71c7ef98
hctx->driver_data           (null) queue ffff880fce71ed88 queue->hctx
ffff880e75dd4a68
[  654.837312] nvme nvme1: nvme_rdma_init_hctx hctx_idx 12 hctx ffff880e71c7ea48
hctx->driver_data           (null) queue ffff880fce71ee00 queue->hctx
ffff880e743e0008
[  654.854892] nvme nvme1: nvme_rdma_init_hctx hctx_idx 13 hctx ffff880e71c78ff8
hctx->driver_data           (null) queue ffff880fce71ee78 queue->hctx
ffff880e743e7a38
[  654.872556] nvme nvme1: nvme_rdma_init_hctx hctx_idx 14 hctx ffff880e71c79548
hctx->driver_data           (null) queue ffff880fce71eef0 queue->hctx
ffff880e743e74e8
[  654.890332] nvme nvme1: nvme_rdma_init_hctx hctx_idx 15 hctx ffff880e71c7e4f8
hctx->driver_data           (null) queue ffff880fce71ef68 queue->hctx
ffff880e743e0558
[  654.908328] nvme nvme1: nvme_rdma_init_hctx hctx_idx 16 hctx ffff880e71c7dfa8
hctx->driver_data           (null) queue ffff880fce71efe0 queue->hctx
ffff880e743e0aa8
[  654.926268] nvme nvme1: nvme_rdma_init_hctx hctx_idx 17 hctx ffff880e71c79a98
hctx->driver_data           (null) queue ffff880fce71f058 queue->hctx
ffff880e743e6f98
[  654.944313] nvme nvme1: nvme_rdma_init_hctx hctx_idx 18 hctx ffff880e71c7da58
hctx->driver_data           (null) queue ffff880fce71f0d0 queue->hctx
ffff880e743e6a48
[  654.962455] nvme nvme1: nvme_rdma_init_hctx hctx_idx 19 hctx ffff880e71c79fe8
hctx->driver_data           (null) queue ffff880fce71f148 queue->hctx
ffff880e743e0ff8
[  654.980701] nvme nvme1: nvme_rdma_init_hctx hctx_idx 20 hctx ffff880e71c7a538
hctx->driver_data           (null) queue ffff880fce71f1c0 queue->hctx
ffff880e743e1548
[  654.999107] nvme nvme1: nvme_rdma_init_hctx hctx_idx 21 hctx ffff880e71c7d508
hctx->driver_data           (null) queue ffff880fce71f238 queue->hctx
ffff880e743e64f8
[  655.017552] nvme nvme1: nvme_rdma_init_hctx hctx_idx 22 hctx ffff880e71c7aa88
hctx->driver_data           (null) queue ffff880fce71f2b0 queue->hctx
ffff880e743e5fa8
[  655.036101] nvme nvme1: nvme_rdma_init_hctx hctx_idx 23 hctx ffff880e71c7afd8
hctx->driver_data           (null) queue ffff880fce71f328 queue->hctx
ffff880e743e1a98
[  655.054759] nvme nvme1: nvme_rdma_init_hctx hctx_idx 24 hctx ffff880e71c7cfb8
hctx->driver_data           (null) queue ffff880fce71f3a0 queue->hctx
ffff880e743e1fe8
[  655.073480] nvme nvme1: nvme_rdma_init_hctx hctx_idx 25 hctx ffff880e71c7ca68
hctx->driver_data           (null) queue ffff880fce71f418 queue->hctx
ffff880e743e5a58
[  655.092201] nvme nvme1: nvme_rdma_init_hctx hctx_idx 26 hctx ffff880e71c7b528
hctx->driver_data           (null) queue ffff880fce71f490 queue->hctx
ffff880e743e5508
[  655.110921] nvme nvme1: nvme_rdma_init_hctx hctx_idx 27 hctx ffff880e71c7ba78
hctx->driver_data           (null) queue ffff880fce71f508 queue->hctx
ffff880e743e2538
[  655.129659] nvme nvme1: nvme_rdma_init_hctx hctx_idx 28 hctx ffff880e71c7c518
hctx->driver_data           (null) queue ffff880fce71f580 queue->hctx
ffff880e743e2a88
[  655.148357] nvme nvme1: nvme_rdma_init_hctx hctx_idx 29 hctx ffff880e71c7bfc8
hctx->driver_data           (null) queue ffff880fce71f5f8 queue->hctx
ffff880e743e4fb8
[  655.167104] nvme nvme1: nvme_rdma_init_hctx hctx_idx 30 hctx ffff880e71cc8008
hctx->driver_data           (null) queue ffff880fce71f670 queue->hctx
ffff880e743e4a68
[  655.185814] nvme nvme1: nvme_rdma_init_hctx hctx_idx 31 hctx ffff880e71cc8558
hctx->driver_data           (null) queue ffff880fce71f6e8 queue->hctx
ffff880e743e2fd8
