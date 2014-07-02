From: willy@linux.intel.com (Matthew Wilcox)
Date: Wed, 2 Jul 2014 16:18:01 -0400
Subject: [PATCH] NVMe: Write CC before calling enable.
In-Reply-To: <alpine.LRH.2.03.1407021232240.4703@AMR>
References: <1404229914-6776-1-git-send-email-daniel.mcleran@intel.com>
 <alpine.LRH.2.03.1407021232240.4703@AMR>
Message-ID: <20140702201801.GZ12025@linux.intel.com>

On Wed, Jul 02, 2014@12:33:08PM -0600, Keith Busch wrote:
> On Tue, 1 Jul 2014, Dan McLeran wrote:
> >Write the controller configuration register to configure queue sizes,
> >memory page size, etc. from within nvme_configure_admin_queue before
> >calling nvme_enable_ctrl.
> 
> I can see that you're doing that, but why? Is this fixing something?

I think I have created this confusion.  In Dan's earlier patch, this
writel() was left in.  I took it out as part of merging his patch (as
Dan himself had done in an earlier version of this patch).  I didn't
see the point of writing everything but enable, then writing the enable
bit separately.

> >Signed-off-by: Dan McLeran <daniel.mcleran at intel.com>
> >---
> >drivers/block/nvme-core.c |    1 +
> >1 file changed, 1 insertion(+)
> >
> >diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> >index 28aec2d..58281d2 100644
> >--- a/drivers/block/nvme-core.c
> >+++ b/drivers/block/nvme-core.c
> >@@ -1512,6 +1512,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
> >	writel(aqa, &dev->bar->aqa);
> >	writeq(nvmeq->sq_dma_addr, &dev->bar->asq);
> >	writeq(nvmeq->cq_dma_addr, &dev->bar->acq);
> >+	writel(dev->ctrl_config, &dev->bar->cc);
> >
> >	result = nvme_enable_ctrl(dev, cap);
> >	if (result)
> >-- 
> >1.7.10.4
> >
> >
> >_______________________________________________
> >Linux-nvme mailing list
> >Linux-nvme at lists.infradead.org
> >http://lists.infradead.org/mailman/listinfo/linux-nvme
> >
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
