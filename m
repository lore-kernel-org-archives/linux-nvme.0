From: keith.busch@intel.com (Keith Busch)
Date: Mon, 5 Jan 2015 18:34:11 +0000 (UTC)
Subject: NVMe: Fix double free irq
In-Reply-To: <20150105161701.GA28353@mwanda>
References: <20150105161701.GA28353@mwanda>
Message-ID: <alpine.LNX.2.00.1501051831460.4026@localhost.lm.intel.com>

You're right, cq_vector should have changed from u16 to s16, or use a
different mechanism. I'll fix all this and more when I re-write the rest
of the series.

On Mon, 5 Jan 2015, Dan Carpenter wrote:
> Hello Keith Busch,
>
> The patch 2b25d981790b: "NVMe: Fix double free irq" from Dec 22,
> 2014, leads to the following static checker warning:
>
> 	drivers/block/nvme-core.c:1137 nvme_suspend_queue()
> 	warn: impossible condition '(nvmeq->cq_vector == -1) => (0-65535 == (-1))'
>
> drivers/block/nvme-core.c
>  1132  static int nvme_suspend_queue(struct nvme_queue *nvmeq)
>  1133  {
>  1134          int vector;
>  1135
>  1136          spin_lock_irq(&nvmeq->q_lock);
>  1137          if (nvmeq->cq_vector == -1) {
>                    ^^^^^^^^^^^^^^^^^^^^^^
> Unsigned short is never equal to -1.  This should be a define.
>
> 		if (nvmeq->cq_vector == SOMETHING_SOMETHING) {
>
>  1138                  spin_unlock_irq(&nvmeq->q_lock);
>  1139                  return 1;
>  1140          }
>  1141          vector = nvmeq->dev->entry[nvmeq->cq_vector].vector;
>  1142          nvmeq->dev->online_queues--;
>  1143          nvmeq->cq_vector = -1;
>  1144          spin_unlock_irq(&nvmeq->q_lock);
>  1145
>  1146          irq_set_affinity_hint(vector, NULL);
>  1147          free_irq(vector, nvmeq);
>  1148
>  1149          return 0;
>  1150  }
>
> regards,
> dan carpenter
