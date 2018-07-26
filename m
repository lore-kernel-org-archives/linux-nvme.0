From: hch@lst.de (Christoph Hellwig)
Date: Thu, 26 Jul 2018 14:07:11 +0200
Subject: [PATCH] nvme: Register for ANA AEN
In-Reply-To: <06a3d125-0dd6-d288-bedd-8462d96c3b9d@suse.de>
References: <20180726105554.80437-1-hare@suse.de>
 <9a5908f1-92fe-e338-47e0-ad51837b3212@suse.de> <20180726115913.GA2187@lst.de>
 <20180726120113.GA2289@lst.de> <06a3d125-0dd6-d288-bedd-8462d96c3b9d@suse.de>
Message-ID: <20180726120711.GA2684@lst.de>

On Thu, Jul 26, 2018@02:02:38PM +0200, Hannes Reinecke wrote:
> On 07/26/2018 02:01 PM, Christoph Hellwig wrote:
> > On Thu, Jul 26, 2018@01:59:13PM +0200, Christoph Hellwig wrote:
> >> What target do you run against?  With the current 4004a TP
> >> NVME_AEN_CFG_ANA_CHANGE should be set in OAES, which at least the
> >> Linux target always did anyway.
> > 
> > Ah, but the patches I sent out are missing this host side fix:
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index e482f223f8fd..f6e52ffe6a6d 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1035,7 +1035,7 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
> >  EXPORT_SYMBOL_GPL(nvme_set_queue_count);
> >  
> >  #define NVME_AEN_SUPPORTED \
> > -	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT)
> > +	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | NVME_AEN_CFG_ANA_CHANGE)
> >  
> >  static void nvme_enable_aen(struct nvme_ctrl *ctrl)
> >  {
> > 
> Ah. Maybe we should fix it up for the final submission...

I'll send out another round later today.
