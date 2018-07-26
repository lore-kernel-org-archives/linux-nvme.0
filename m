From: hch@lst.de (Christoph Hellwig)
Date: Thu, 26 Jul 2018 13:59:13 +0200
Subject: [PATCH] nvme: Register for ANA AEN
In-Reply-To: <9a5908f1-92fe-e338-47e0-ad51837b3212@suse.de>
References: <20180726105554.80437-1-hare@suse.de>
 <9a5908f1-92fe-e338-47e0-ad51837b3212@suse.de>
Message-ID: <20180726115913.GA2187@lst.de>

On Thu, Jul 26, 2018@12:58:19PM +0200, Hannes Reinecke wrote:
> On 07/26/2018 12:55 PM, Hannes Reinecke wrote:
> > We need to register for ANA AENs as we rely on them for our ANA implementation.
> > Patch is relative to hch nvme-ana tree.
> > 
> > Signed-off-by: Hannes Reinecke <hare at suse.com>
> > ---
> >  drivers/nvme/host/core.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> > index 3b96ace1f86d..99910497acdc 100644
> > --- a/drivers/nvme/host/core.c
> > +++ b/drivers/nvme/host/core.c
> > @@ -1042,6 +1042,10 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)
> >  	u32 supported = ctrl->oaes & NVME_AEN_SUPPORTED, result;
> >  	int status;
> >  
> > +#ifdef CONFIG_NVME_MULTIPATH
> > +	if (ctrl->subsys->cmic & (1 << 3))
> > +		supported |= NVME_AEN_CFG_ANA_CHANGE;
> > +#endif
> >  	status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT, supported, NULL,
> >  			0, &result);
> >  	if (status)
> > 
> Christoph,
> 
> this patch fixes the hang I've seen when running my ANA blktest.

What target do you run against?  With the current 4004a TP
NVME_AEN_CFG_ANA_CHANGE should be set in OAES, which at least the
Linux target always did anyway.

We could work around this bug in the original TP4004, but I'd rather
not accumulate hacks like this.
