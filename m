From: scott.bauer@intel.com (Scott Bauer)
Date: Tue, 20 Dec 2016 14:55:10 -0700
Subject: [PATCH v3 2/5] lib: Add Sed-opal library
In-Reply-To: <20161220072847.GA11946@infradead.org>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-3-git-send-email-scott.bauer@intel.com>
 <20161220072847.GA11946@infradead.org>
Message-ID: <20161220215509.GA2462@sbauer-Z170X-UD5>

> > +
> > +int fdev_sed_ioctl(struct file *filep, unsigned int cmd,
> > +		   unsigned long arg)
> > +{
> > +	struct sed_key key;
> > +	struct sed_context *sed_ctx;
> > +
> > +	if (!capable(CAP_SYS_ADMIN))
> > +		return -EACCES;
> > +
> > +	if (!filep->f_sedctx || !filep->f_sedctx->ops || !filep->f_sedctx->dev)
> > +		return -ENODEV;
> 
> In the previous version this was called from the block driver which
> could pass in the context (and ops).  Why was this changed?
> 

Do you mean from nvme_ioctl? or from blk_ioctl? It was removed from  blk_ioctl
because I must have misinterpreted your comments here:
http://lists.infradead.org/pipermail/linux-nvme/2016-December/007364.html

Copied from the link: 
>
> > and directly use
> > block_device. Then if we add the security send/receive operations to the
> > block_device_operations, that will simplify chaining the security request
> > to the driver without needing to thread the driver's requested callback
> > and data the way you have to here since all the necessary information
> > is encapsulated in the block_device.

> Maybe.  I need to look at the TCG spec again (oh my good, what a fucking
> mess), but if I remember the context if it is the whole nvme controller
> and not just a namespace, so a block_device might be the wrong context.
> Then again we can always go from the block_device to the controller
> fairly easily.  So instead of adding the security operation to the
> block_device_operations which we don't really need for now maybe we
> should add a security_conext to the block device so that we can avoid
> all the lookup code?

I took your hesitation about the block_device to mean try something new,
that combined with my concern about having namespaces have the ability to
lock the global range which can span ourside their LBA ranges lead me to
remove it from block and put it in the char dev world.

On the same note there is a public review of
TCG Storage Opal SSC Feature Set: Configurable Namespace Locking:
Which Jon Derrick found for us:
https://www.trustedcomputinggroup.org/wp-content/uploads/TCG_Storage_Feature_Set_Namespaces_phase_1b_v1_00_r1_19_public-review.pdf

Where they are thinking about doing a complete 180 from:
https://www.trustedcomputinggroup.org/wp-content/uploads/TCG_SWG_SIIS_Version_1_05_Revision_1_00.pdf

And now Namespaces can have their own global locking range as well as locking
objects within them. 
