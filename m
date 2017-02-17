From: hch@lst.de (Christoph Hellwig)
Date: Fri, 17 Feb 2017 18:01:28 +0100
Subject: [PATCH 4/4] nvme: re-check security protocol support after reset
In-Reply-To: <20170217152651.GA18275@localhost.localdomain>
References: <20170217125941.14319-1-hch@lst.de>
 <20170217125941.14319-5-hch@lst.de>
 <20170217152651.GA18275@localhost.localdomain>
Message-ID: <20170217170128.GA29208@lst.de>

On Fri, Feb 17, 2017@10:26:51AM -0500, Keith Busch wrote:
> On Fri, Feb 17, 2017@01:59:41PM +0100, Christoph Hellwig wrote:
> > @@ -1789,7 +1789,8 @@ static void nvme_reset_work(struct work_struct *work)
> >  	if (result)
> >  		goto out;
> >  
> > -	if ((dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) && !dev->ctrl.opal_dev) {
> > +	kfree(dev->ctrl.opal_dev);
> > +	if (dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) {
> >  		dev->ctrl.opal_dev =
> >  			init_opal_dev(&dev->ctrl, &nvme_sec_submit);
> >  	}
> 
> A couple things.
> 
> This has a use-after-free in opal_unlock_from_suspend if the nvme
> device had an opal_dev before, but no longer support the capability
> after resume. So you'd want to set ctrl.opal_dev to NULL after the free.
> 
> But we don't want to unconditionally free it anyway during resume
> since opal_unlock_from_suspend requires the exisiting opal_dev state
> information saved in the 'unlk_list'.
> 
> Something like this instead:

Yes, that looks fine to me.  We'll probably also need the additional
fixup Scott pointed out.
