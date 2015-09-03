From: keith.busch@intel.com (Keith Busch)
Date: Thu, 3 Sep 2015 14:14:41 +0000 (UTC)
Subject: setting nvme irq per cpu affinity in device driver
In-Reply-To: <007301d0e5e0$220062b0$66012810$@samsung.com>
References: <003c01d0e569$dd9a7b40$98cf71c0$@samsung.com>
 <alpine.LNX.2.00.1509021905520.23840@localhost.lm.intel.com>
 <007301d0e5e0$220062b0$66012810$@samsung.com>
Message-ID: <alpine.LNX.2.00.1509031408380.23840@localhost.lm.intel.com>

On Wed, 2 Sep 2015, ??? wrote:
> Hello, Keith Busch.
> Thank you for your opinion. Yes, we've already considered the approach.
>
> However, there were two issues regarding the way.
> 1. In our tests, setting affinity hint is not working on 4.2-rc6 driver.
> Please find below code. It is current implementation (4.2-rc6)for setting
> affinity hint.
>
> static void nvme_set_irq_hints(struct nvme_dev *dev) {
>        struct nvme_queue *nvmeq;
>        int i;
>
>        for (i = 0; i < dev->online_queues; i++) {
>                nvmeq = dev->queues[i];
>
>                if (!nvmeq->tags || !(*nvmeq->tags))
>                        continue; 
>
>                /*kyungsan : <- not reach here from second loop*/
>
>                irq_set_affinity_hint(dev->entry[nvmeq->cq_vector].vector,
>                                        blk_mq_tags_cpumask(*nvmeq->tags));
>        }
> }
>
> As tags information is not properly configured, setting affinity for IO CQs
> is not applied. 
> It is only applied on Admin CQ.

Ok, that's a bug. We can't set the hints before the nvmeq's tagset hw
context initialized. That doesn't happen until after a request queue is
allocated, which happens aynchronously now, but it's an easy fix.
