From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 27 Feb 2017 16:39:03 +0200
Subject: nvmf regression with mq-deadline
In-Reply-To: <34fb43d6-37e7-feb3-73c6-63140993ba7c@grimberg.me>
References: <8384a5c8-c8e6-4e46-65d6-208b802f6957@grimberg.me>
 <34fb43d6-37e7-feb3-73c6-63140993ba7c@grimberg.me>
Message-ID: <0f06d732-fe32-bca0-8a4d-299a6cce7a6e@grimberg.me>


> Now I'm getting a NULL deref with nvme-rdma [1].
>
> For some reason blk_mq_tag_to_rq() is returning NULL on
> tag 0x0 which is io queue connect.
>
> I'll try to see where this is coming from.
> This does not happen with loop though...

That's because the loop driver does not rely on the
cqe.command_id to resolve the submitted request (I'll
fix that).

Looks like blk_mq_alloc_request_hctx was overlooked when
the back assignment of the request to the rq_map...

This patch solves the issue for fabrics:
--
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d84c66fb37b7..9611cd9920e9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -312,6 +312,7 @@ struct request *blk_mq_alloc_request_hctx(struct 
request_queue *q, int rw,
                 ret = -EWOULDBLOCK;
                 goto out_queue_exit;
         }
+       alloc_data.hctx->tags->rqs[rq->tag] = rq;

         return rq;
--

If its agreed with everyone I'll send a proper patch
for this and the blk_mq_sched_setup fix?
