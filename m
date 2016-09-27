From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 27 Sep 2016 10:11:05 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <20160926222906.GA28881@lst.de>
References: <012001d20f63$5c8f7490$15ae5db0$@opengridcomputing.com>
 <01d201d20f69$449abce0$cdd036a0$@opengridcomputing.com>
 <020001d20f70$9998fde0$cccaf9a0$@opengridcomputing.com>
 <02c001d20f93$e6a88a60$b3f99f20$@opengridcomputing.com>
 <20160916110412.GC5476@lst.de>
 <8fc2cefe-76b6-b0a3-12af-701833c286f7@grimberg.me>
 <02db01d2128b$e9244c70$bb6ce550$@opengridcomputing.com>
 <02c601d2144d$ff453a50$fdcfaef0$@opengridcomputing.com>
 <cea94562-b0d6-fbc0-998d-9597b8969998@grimberg.me>
 <20160926151242.GA16873@lst.de> <20160926222906.GA28881@lst.de>
Message-ID: <00fd01d218d1$5e49ebe0$1addc3a0$@opengridcomputing.com>

> 
> Steve,
> 
> can you retest with the "Introduce blk_quiesce_queue() and blk_resume_queue()"
> series from Bart applied?
> 

Hey Christoph,

To apply Bart's series, I needed to use Jens' for-4.9/block branch.  But I also
wanted the latest nvme fixes in linux-4.8-rc8, so I rebased Jens' branch onto
rc8, then applied Bart's series (which needed a small tweak to patch 2). On top
of this I have some debug patches that will BUG_ON() if it detects freed RDMA
objects (requires mem debug on so freed memory has the 0x6b6b... stamp).   This
code base can be perused at:

https://github.com/larrystevenwise/nvme-fabrics/commits/block-for-4.9

I then tried to reproduce, and still hit a crash.  I'm debugging now.  

[  414.649731] nvme_rdma: nvme_rdma_queue_rq BAZINGA! hctx ffff880fb8fc1548 ns
ffff88101f049798 queue ffff880fbc1443a8 hctx1 ffff880fba47ca68 hctx2
ffff880fb8fc1548 rq ffff880fbb1736c0 req ffff880fbb173830
[  414.649830] nvme_rdma: nvme_rdma_queue_rq BAZINGA! hctx ffff880fbc1164f8 ns
ffff88101f049798 queue ffff880fbc144328 hctx1 ffff880fba47afd8 hctx2
ffff880fbc1164f8 rq ffff880fbb031240 req ffff880fbb0313b0
[  414.649869] ------------[ cut here ]------------
[  414.649870] kernel BUG at drivers/nvme/host/rdma.c:1434!
[  414.649872] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC
[  414.649907] Modules linked in: nvme_rdma nvme_fabrics brd iw_cxgb4 cxgb4
ip6table_filter ip6_tables ebtable_nat ebtables ipt_MASQUERADE
nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4
nf_defrag_ipv4 xt_state nf_conntrack ipt_REJECT nf_reject_ipv4 xt_CHECKSUM
iptable_mangle iptable_filter ip_tables bridge 8021q mrp garp stp llc cachefiles
fscache rdma_ucm rdma_cm iw_cm ib_ipoib ib_cm ib_uverbs ib_umad ocrdma be2net
iw_nes libcrc32c iw_cxgb3 cxgb3 mdio ib_qib rdmavt mlx5_ib mlx5_core mlx4_ib
mlx4_en mlx4_core ib_mthca ib_core binfmt_misc dm_mirror dm_region_hash dm_log
vhost_net macvtap macvlan vhost tun kvm irqbypass uinput iTCO_wdt
iTCO_vendor_support mxm_wmi pcspkr ipmi_si ipmi_msghandler dm_mod i2c_i801
i2c_smbus sg lpc_ich mfd_core mei_me mei nvme nvme_core igb dca ptp
[  414.649916]  pps_core wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E)
libahci(E) libata(E) mgag200(E) ttm(E) drm_kms_helper(E) drm(E) fb_sys_fops(E)
sysimgblt(E) sysfillrect(E) syscopyarea(E) i2c_algo_bit(E) i2c_core(E) [last
unloaded: cxgb4]
[  414.649918] CPU: 0 PID: 14173 Comm: fio Tainted: G        W   E
4.8.0-rc8-stevo-for-harsha-dbg+ #48
[  414.649919] Hardware name: Supermicro X9DR3-F/X9DR3-F, BIOS 3.2a 07/09/2015
[  414.649920] task: ffff880fa4410040 task.stack: ffff880fa44fc000
[  414.649926] RIP: 0010:[<ffffffffa065eef0>]  [<ffffffffa065eef0>]
nvme_rdma_queue_rq+0x2d0/0x360 [nvme_rdma]
[  414.649927] RSP: 0018:ffff880fa44ff9a8  EFLAGS: 00010296
[  414.649928] RAX: 00000000000000be RBX: ffff880fbc144328 RCX: 0000000000000000
[  414.649929] RDX: 0000000000000001 RSI: 0000000000000286 RDI: 0000000000000286
[  414.649930] RBP: ffff880fa44ffa08 R08: 000000000005aeb2 R09: ffffffff820360de
[  414.649931] R10: 00000000000000e0 R11: 000000000000000f R12: ffff880fbb031240
[  414.649932] R13: ffff880fbc1164f8 R14: ffff880fbb0313b0 R15: ffff88101f049798
[  414.649933] FS:  00007ffb2afc5720(0000) GS:ffff881036e00000(0000)
knlGS:0000000000000000
[  414.649934] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  414.649935] CR2: 00007ffb0942e194 CR3: 0000000fa3636000 CR4: 00000000000406f0
[  414.649936] Stack:
[  414.649939]  ffff880fbc1164f8 ffff880fbb031240 ffff880fbb0313b0
ffff88103681f3f8
[  414.649941]  ffff880fa44ffa08 ffff880fbb7dcc88 ffff880fbb031240
ffff880fbb031240
[  414.649942]  ffff880fa44ffa78 0000000000000000 ffff880fb8f073e0
0000000000000001
[  414.649943] Call Trace:
[  414.649948]  [<ffffffff813394d1>] __blk_mq_run_hw_queue+0x251/0x400
[  414.649952]  [<ffffffff8115aa58>] ? trace_buffer_unlock_commit_regs+0x68/0x80
[  414.649956]  [<ffffffff8116c796>] ? trace_event_buffer_commit+0x146/0x1d0
[  414.649959]  [<ffffffff81330676>] ?
trace_event_raw_event_block_rq+0x116/0x180
[  414.649961]  [<ffffffff81339742>] blk_mq_run_hw_queue+0x72/0x80
[  414.649962]  [<ffffffff81339cd2>] blk_mq_insert_requests+0x112/0x1d0
[  414.649965]  [<ffffffff81197991>] ? __generic_file_write_iter+0xd1/0x1f0
[  414.649969]  [<ffffffff81204cdc>] ? alloc_debug_processing+0x6c/0x1a0
[  414.649971]  [<ffffffff81339f16>] blk_mq_flush_plug_list+0x186/0x1a0
[  414.649974]  [<ffffffff8127c326>] ? aio_run_iocb+0x126/0x2d0
[  414.649976]  [<ffffffff8132f2c2>] blk_flush_plug_list+0x132/0x2e0
[  414.649979]  [<ffffffff812086e5>] ? kmem_cache_alloc+0x165/0x1e0
[  414.649981]  [<ffffffff8127c731>] ? io_submit_one+0x261/0x530
[  414.649983]  [<ffffffff8116c796>] ? trace_event_buffer_commit+0x146/0x1d0
[  414.649984]  [<ffffffff8132f674>] blk_finish_plug+0x34/0x50
[  414.649986]  [<ffffffff8127cb32>] do_io_submit+0x132/0x210
[  414.649988]  [<ffffffff8127cc20>] SyS_io_submit+0x10/0x20
[  414.649992]  [<ffffffff81003e7d>] do_syscall_64+0x7d/0x230
[  414.649997]  [<ffffffff8106f097>] ? do_page_fault+0x37/0x90
[  414.650001]  [<ffffffff816e3f61>] entry_SYSCALL64_slow_path+0x25/0x25
[  414.650020] Code: 49 89 d8 4c 89 64 24 08 48 8b 43 78 4c 89 f9 4c 89 ea 48 c7
c6 50 11 66 a0 48 c7 c7 38 14 66 a0 48 89 04 24 31 c0 e8 d2 68 b3 e0 <0f> 0b eb
fe 80 3d 39 33 00 00 01 0f 84 6d fd ff ff be 8f 05 00
[  414.650023] RIP  [<ffffffffa065eef0>] nvme_rdma_queue_rq+0x2d0/0x360
[nvme_rdma]
[  414.650023]  RSP <ffff880fa44ff9a8>
crash> gdb list *nvme_rdma_queue_rq+0x2d0
0xffffffffa065eef0 is in nvme_rdma_queue_rq (drivers/nvme/host/rdma.c:1434).
1429            if ((uintptr_t)queue->qp->device ==
(uintptr_t)(0x6b6b6b6b6b6b6b6bUL) ||
1430                (uintptr_t)queue->qp->qp_num ==
(uintptr_t)(0x6b6b6b6b6b6b6b6bUL) ||
1431                (uintptr_t)queue->ib_cq->comp_handler ==
(uintptr_t)(0x6b6b6b6b6b6b6b6bUL) ||
1432                (uintptr_t)queue->ib_cq->device ==
(uintptr_t)(0x6b6b6b6b6b6b6b6bUL)) {
1433                    pr_err("%s BAZINGA! hctx %p ns %p queue %p hctx1 %p
hctx2 %p rq %p req %p\n", __func__, hctx, ns, queue, queue->hctx1, queue->hctx2,
rq, req);
1434                    BUG_ON(1);
1435            }
1436            dev = queue->device->dev;
1437            ib_dma_sync_single_for_cpu(dev, sqe->dma,
1438                            sizeof(struct nvme_command), DMA_TO_DEVICE);
crash> nvme_rdma_request ffff880fbb0313b0
struct nvme_rdma_request {
  mr = 0xffff880fbb7d9ad8,
  sqe = {
    cqe = {
      done = 0xffffffffa065d670 <nvme_rdma_send_done>
    },
    data = 0xffff880fbb7dcc88,
    dma = 67570093192
  },
  sge = {{
      addr = 67570093192,
      length = 64,
      lkey = 0
    }, {
      addr = 67902048256,
      length = 2048,
      lkey = 0
    }},
  num_sge = 2,
  nents = 1,
  inline_data = true,
  reg_wr = {
    wr = {
      next = 0xffff880fb65bf518,
      {
        wr_id = 18446612199876269112,
        wr_cqe = 0xffff880fbb031438
      },
      sg_list = 0x0,
      num_sge = 0,
      opcode = IB_WR_REG_MR,
      send_flags = 0,
      ex = {
        imm_data = 0,
        invalidate_rkey = 0
      }
    },
    mr = 0xffff880fbb7d9ad8,
    key = 40554307,
    access = 7
  },
  reg_cqe = {
    done = 0xffffffffa065d6b0 <nvme_rdma_memreg_done>
  },
  queue = 0xffff880fbc144328,
  sg_table = {
    sgl = 0xffff880fbb031458,
    nents = 1,
    orig_nents = 1
  },
  first_sgl = 0xffff880fbb031458
}
crash> nvme_rdma_queue 0xffff880fbc144328
struct nvme_rdma_queue {
  rsp_ring = 0xffff880fbe81c548,
  sig_count = 60 '<',
  queue_size = 128,
  cmnd_capsule_len = 4160,
  ctrl = 0xffff880fc98eca88,
  device = 0xffff880ff0b304b8,
  ib_cq = 0xffff880fbcac3508,
  qp = 0xffff880fbc1874e8,
  flags = 16,
  cm_id = 0xffff880fbc181548,
  cm_error = 0,
  cm_done = {
    done = 0,
    wait = {
      lock = {
        {
          rlock = {
            raw_lock = {
              val = {
                counter = 0
              }
            }
          }
        }
      },
      task_list = {
        next = 0xffff880fbc144388,
        prev = 0xffff880fbc144388
      }
    }
  },
  hctx1 = 0xffff880fba47afd8,
  hctx2 = 0xffff880fbc1164f8
}
crash> gdb x/1g 0xffff880fbcac3508
0xffff880fbcac3508:     0x6b6b6b6b6b6b6b6b
crash>
