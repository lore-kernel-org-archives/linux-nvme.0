From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 6 Oct 2016 00:55:07 +0300
Subject: [PATCH rfc 0/6] convert nvme pci to use irq-poll service
In-Reply-To: <20161005214730.GA1053@localhost.localdomain>
References: <1475660534-16681-1-git-send-email-sagi@grimberg.me>
 <20161005214730.GA1053@localhost.localdomain>
Message-ID: <a66d99fb-15d3-2620-5eb6-e6bb4a0a80bc@grimberg.me>


>> I ran some tests with this and it seemed to work pretty well with
>> my low-end nvme devices. One phenomenon I've encountered was that
>> for single core long queue-depth'ed randread workload I saw around
>> ~8-10% iops decrease. However when running multi-core IO I didn't
>> see any noticeable performance degradation. non-polling Canonical
>> randread latency doesn't seem to be affected as well. And also
>> polling mode IO is not affected as expected.
>>
>> So in addition for review and feedback, this is a call for testing
>> and benchmarking as this touches the critical data path.
>
> Hi Sagi,
>
> Just reconfirming your findings with another data point, I ran this on
> controllers with 3D Xpoint media, and single depth 4k random read latency
> increased almost 7%. I'll try see if there's anything else we can do to
> bring that in.

Actually I didn't notice latency increase with QD=1 but I'm using
low-end devices so I might have missed it.
Did you use libaio or psync (for polling mode)?

I'm a bit surprised that scheduling soft-irq (on the same core) is
so expensive (the networking folks are using it all over...)
Perhaps we need to look into napi and see if we're doing something
wrong there...

I wander if we kept the cq processing in queue_rq but budget it to
something normally balanced? maybe poll budget to 4 completions?

Does this have any effect with your Xpoint?
--
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 150941a1a730..28b33f518a3d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -608,6 +608,7 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
                 goto out;
         }
         __nvme_submit_cmd(nvmeq, &cmnd);
+       __nvme_process_cq(nvmeq, 4);
         spin_unlock_irq(&nvmeq->q_lock);
         return BLK_MQ_RQ_QUEUE_OK;
  out:
--
