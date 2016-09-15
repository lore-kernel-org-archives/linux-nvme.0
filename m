From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 15 Sep 2016 10:10:57 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <011501d20f5f$b94e6c80$2beb4580$@opengridcomputing.com>
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
Message-ID: <012001d20f63$5c8f7490$15ae5db0$@opengridcomputing.com>

> The state of the controller is NVME_CTRL_RECONNECTING.  In fact, this BUG_ON()
> happened on the reconnect worker thread.   Ah, this is probably the connect
> command on the admin queue maybe?
> 
> 
> 

The queue being used at the crash is nvme_rdma_ctrl->queues[1].  IE not the
admin queue.  The reconnect work thread is connecting the io queues here:

crash> gdb list *nvme_rdma_reconnect_ctrl_work+0x14b
0xffffffffa065cafb is in nvme_rdma_reconnect_ctrl_work
(drivers/nvme/host/rdma.c:647).
642     {
643             int i, ret = 0;
644
645             for (i = 1; i < ctrl->queue_count; i++) {
646                     ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
647                     if (ret)
648                             break;
649             }
650
651             return ret;


nvmf_connect_io_queue() is here:

crash> gdb list *nvmf_connect_io_queue+0x114
0xffffffffa064d134 is in nvmf_connect_io_queue
(drivers/nvme/host/fabrics.c:454).
449             strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
450
451             ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &cqe,
452                             data, sizeof(*data), 0, qid, 1,
453                             BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
454             if (ret) {
455                     nvmf_log_connect_error(ctrl, ret,
le32_to_cpu(cqe.result),
456                                            &cmd, data);
457             }
458             kfree(data);


The hctx passed into nvme_rdma_queue_rq() is in state BLK_MQ_S_TAG_ACTIVE.  And
hctx->driver_data is the nvme_rdma_queue to be used.  That nvme_rdma_queue has a
different hctx pointer (from my debug code) and that's why we hit the BUG_ON().
Anyway, nvme_rdma_queue->hctx->state is BLK_MQ_S_STOPPED.  So this is more
evidence that somehow an hctx is using an nvme_rdma_queue that wasn't originally
assigned to that hctx...
