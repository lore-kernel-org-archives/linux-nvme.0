From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 15 Sep 2016 09:44:55 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <da2e918b-0f18-e032-272d-368c6ec49c62@grimberg.me>
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
 <da2e918b-0f18-e032-272d-368c6ec49c62@gri mberg.me>
Message-ID: <011501d20f5f$b94e6c80$2beb4580$@opengridcomputing.com>

> > @@ -1408,6 +1412,8 @@ static int nvme_rdma_queue_rq(struct blk_mq_hw_ctx
> *hctx,
> >
> >         WARN_ON_ONCE(rq->tag < 0);
> >
> > +       BUG_ON(hctx != queue->hctx);
> > +       BUG_ON(test_bit(BLK_MQ_S_STOPPED, &hctx->state));
> >         dev = queue->device->dev;
> >         ib_dma_sync_single_for_cpu(dev, sqe->dma,
> >                         sizeof(struct nvme_command), DMA_TO_DEVICE);
> > ---
> >
> > When I reran the test forcing reconnects, I hit the BUG_ON(hctx !=
queue->hctx)
> > in nvme_rdma_queue_rq() when doing the first reconnect (not when initially
> > connecting the targets).   Here is the back trace.  Is my debug logic
flawed?
> > Or does this mean something is screwed up once we start reconnecting.
> 
> This is weird indeed.
> 
> The fact that you trigger this means that you successfully reconnect
> correct?
>

The state of the controller is NVME_CTRL_RECONNECTING.  In fact, this BUG_ON()
happened on the reconnect worker thread.   Ah, this is probably the connect
command on the admin queue maybe?


PID: 1819   TASK: ffff88101d0217c0  CPU: 0   COMMAND: "kworker/0:2"
 #0 [ffff8810090d34b0] machine_kexec at ffffffff8105fbd0
 #1 [ffff8810090d3520] __crash_kexec at ffffffff81116998
 #2 [ffff8810090d35f0] crash_kexec at ffffffff81116a6d
 #3 [ffff8810090d3620] oops_end at ffffffff81032bd6
 #4 [ffff8810090d3650] die at ffffffff810330cb
 #5 [ffff8810090d3680] do_trap at ffffffff8102fff1
 #6 [ffff8810090d36e0] do_error_trap at ffffffff8103032d
 #7 [ffff8810090d37a0] do_invalid_op at ffffffff81030480
 #8 [ffff8810090d37b0] invalid_op at ffffffff816e47be
    [exception RIP: nvme_rdma_queue_rq+621]
    RIP: ffffffffa065ce3d  RSP: ffff8810090d3868  RFLAGS: 00010206
    RAX: 0000000000000000  RBX: ffff880e33640000  RCX: dead000000000200
    RDX: ffff8810090d3928  RSI: ffff8810090d38f8  RDI: ffff880e315cb528
    RBP: ffff8810090d38a8   R8: ffff880e33640000   R9: 0000000000000000
    R10: 0000000000000674  R11: ffff8810090d3a18  R12: ffff880e36ab91d0
    R13: ffff880e33640170  R14: ffff880e315cb528  R15: ffff880e36bc1138
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #9 [ffff8810090d38b0] __blk_mq_run_hw_queue at ffffffff81338b1b
#10 [ffff8810090d3a00] blk_mq_run_hw_queue at ffffffff81338ffe
#11 [ffff8810090d3a20] blk_mq_insert_request at ffffffff8133a130
#12 [ffff8810090d3a90] blk_execute_rq_nowait at ffffffff813342dd
#13 [ffff8810090d3ad0] blk_execute_rq at ffffffff8133442e
#14 [ffff8810090d3b80] __nvme_submit_sync_cmd at ffffffffa02715d5 [nvme_core]
#15 [ffff8810090d3bd0] nvmf_connect_io_queue at ffffffffa064d134 [nvme_fabrics]
#16 [ffff8810090d3c80] nvme_rdma_reconnect_ctrl_work at ffffffffa065cafb
[nvme_rdma]
#17 [ffff8810090d3cb0] process_one_work at ffffffff810a1613
#18 [ffff8810090d3d90] worker_thread at ffffffff810a22ad
#19 [ffff8810090d3ec0] kthread at ffffffff810a6dec
#20 [ffff8810090d3f50] ret_from_fork at ffffffff816e3bbf

 
