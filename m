From: ks0204.kim@samsung.com (=?ks_c_5601-1987?B?seiw5rvq?=)
Date: Thu, 03 Sep 2015 09:33:19 +0900
Subject: setting nvme irq per cpu affinity in device driver
References: <003c01d0e569$dd9a7b40$98cf71c0$@samsung.com>
 <alpine.LNX.2.00.1509021905520.23840@localhost.lm.intel.com>
Message-ID: <007301d0e5e0$220062b0$66012810$@samsung.com>

Hello, Keith Busch.
Thank you for your opinion. Yes, we've already considered the approach.

However, there were two issues regarding the way.
1. In our tests, setting affinity hint is not working on 4.2-rc6 driver.
Please find below code. It is current implementation (4.2-rc6)for setting
affinity hint.

static void nvme_set_irq_hints(struct nvme_dev *dev) {
        struct nvme_queue *nvmeq;
        int i;

        for (i = 0; i < dev->online_queues; i++) {
                nvmeq = dev->queues[i];

                if (!nvmeq->tags || !(*nvmeq->tags))
                        continue;    

                /*kyungsan : <- not reach here from second loop*/

                irq_set_affinity_hint(dev->entry[nvmeq->cq_vector].vector,
                                        blk_mq_tags_cpumask(*nvmeq->tags));
        }
}

As tags information is not properly configured, setting affinity for IO CQs
is not applied. 
It is only applied on Admin CQ.

2. Even with lower version of linux drivers which are able to set affinity
hint properly, we've noticed that '--hintpolicy=exact' does not work on
some linux distros such as debian.
Maybe there are some differences in irqbalance daemon regarding how to
handle hint information even with 'exact' policy.

Kindly Regards
Kyungsan Kim


-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf
Of Keith Busch
Sent: Thursday, September 03, 2015 4:08 AM
To: ???
Cc: Linux-nvme at lists.infradead.org
Subject: Re: setting nvme irq per cpu affinity in device driver

On Wed, 2 Sep 2015, ??? wrote:
> Actually, in current status, device driver already tries to set 
> affinity_hint for IRQs during Q initialization.
> But in our tests, it does not guarantee the CPU distribution on 
> system-wide even with irqbalance daemon working, failing to resolve above
issues.

Are you running irqbalance with '--hintpolicy=exact'? It Seems to do the
right thing over here.
