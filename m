From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 15 Sep 2016 12:53:52 +0300
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <022701d20d31$a9645850$fc2d08f0$@opengridcomputing.com>
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
Message-ID: <da2e918b-0f18-e032-272d-368c6ec49c62@grimberg.me>


> @@ -1408,6 +1412,8 @@ static int nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
>
>         WARN_ON_ONCE(rq->tag < 0);
>
> +       BUG_ON(hctx != queue->hctx);
> +       BUG_ON(test_bit(BLK_MQ_S_STOPPED, &hctx->state));
>         dev = queue->device->dev;
>         ib_dma_sync_single_for_cpu(dev, sqe->dma,
>                         sizeof(struct nvme_command), DMA_TO_DEVICE);
> ---
>
> When I reran the test forcing reconnects, I hit the BUG_ON(hctx != queue->hctx)
> in nvme_rdma_queue_rq() when doing the first reconnect (not when initially
> connecting the targets).   Here is the back trace.  Is my debug logic flawed?
> Or does this mean something is screwed up once we start reconnecting.

This is weird indeed.

The fact that you trigger this means that you successfully reconnect
correct?

If queue is corrupted it would explain the bogus post on a freed or
non-existing qp...
