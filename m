From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 8 Sep 2016 15:47:02 -0500
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <7f09e373-6316-26a3-ae81-dab1205d88ab@grimberg.me>
References: <018301d1e9e1$da3b2e40$8eb18ac0$@opengridcomputing.com>
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
 <039401d2094c$084d64e0$18e82ea0$@opengridcomputing.com>
 <7f09e373-6316-26a3-ae81-dab1205d88ab@grimbe rg.me>
Message-ID: <020f01d20a12$26f846a0$74e8d3e0$@opengridcomputing.com>

> >> Does this happen if you change the reconnect delay to be something
> >> different than 10 seconds? (say 30?)
> >>
> >
> > Yes.  But I noticed something when performing this experiment that is an
> > important point, I think:  if I just bring the network interface down and
leave
> > it down, we don't crash.  During this state, I see the host continually
> > reconnecting after the reconnect delay time, timing out trying to reconnect,
and
> > retrying after another reconnect_delay period.  I see this for all 10
targets of
> > course.  The crash only happens when I bring the interface back up, and the
> > targets begin to reconnect.   So the process of successfully reconnecting
the
> > RDMA QPs, and restarting the nvme queues is somehow triggering running an
> nvme
> > request too soon (or perhaps on the wrong queue).
> 
> Interesting. Given this is easy to reproduce, can you record the:
> (request_tag, *queue, *qp) for each request submitted?
> 
> I'd like to see that the *queue stays the same for each tag
> but the *qp indeed changes.
> 

I tried this, and didn't hit the BUG_ON(), yet still hit the crash.  I believe
this verifies that  *queue never changed...

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index c075ea5..a77729e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -76,6 +76,7 @@ struct nvme_rdma_request {
        struct ib_reg_wr        reg_wr;
        struct ib_cqe           reg_cqe;
        struct nvme_rdma_queue  *queue;
+       struct nvme_rdma_queue  *save_queue;
        struct sg_table         sg_table;
        struct scatterlist      first_sgl[];
 };
@@ -354,6 +355,8 @@ static int __nvme_rdma_init_request(struct nvme_rdma_ctrl
*ctrl,
        }

        req->queue = queue;
+       if (!req->save_queue)
+               req->save_queue = queue;

        return 0;

@@ -1434,6 +1436,9 @@ static int nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,

        WARN_ON_ONCE(rq->tag < 0);

+       BUG_ON(queue != req->queue);
+       BUG_ON(queue != req->save_queue);
+
        dev = queue->device->dev;
        ib_dma_sync_single_for_cpu(dev, sqe->dma,
                        sizeof(struct nvme_command), DMA_TO_DEVICE);
