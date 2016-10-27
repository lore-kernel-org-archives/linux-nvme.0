From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Thu, 27 Oct 2016 08:40:13 -0700
Subject: [PATCH] nvme-loop: kfree(ctrl) on _create() error exit
In-Reply-To: <20161027124906.GA28200@infradead.org>
References: <1477513257-30474-1-git-send-email-james_p_freyensee@linux.intel.com>
 <20161027124906.GA28200@infradead.org>
Message-ID: <1477582813.2838.11.camel@linux.intel.com>

On Thu, 2016-10-27@05:49 -0700, Christoph Hellwig wrote:
> On Wed, Oct 26, 2016@01:20:57PM -0700, Jay Freyensee wrote:
> > 
> > diff --git a/drivers/nvme/target/loop.c
> > b/drivers/nvme/target/loop.c
> > index d5df77d..b0f9931 100644
> > --- a/drivers/nvme/target/loop.c
> > +++ b/drivers/nvme/target/loop.c
> > @@ -673,6 +673,7 @@ static struct nvme_ctrl
> > *nvme_loop_create_ctrl(struct device *dev,
> > ?	nvme_uninit_ctrl(&ctrl->ctrl);
> > ?out_put_ctrl:
> > ?	nvme_put_ctrl(&ctrl->ctrl);
> > +	kfree(ctrl);
> > ?	if (ret > 0)
> > ?		ret = -EIO;
> > ?	return ERR_PTR(ret);
> 
> This will give us a double free.??The final put in nvme_put_ctrl
> calls
> ->free_ctrl which will free the controller.

But doesn't nvme_put_ctrl() just take care of the nvme_ctrl? ?The
kfree(ctrl) is for nvme_loop_ctrl instance being kzalloc'ed at the
beginning of the function. ?I don't think this is any different than
what is done for the create_ctrl() implementation in host/rdma.c?:

host/rdma.c
===========
out_uninit_ctrl:
	nvme_uninit_ctrl(&ctrl->ctrl);
	nvme_put_ctrl(&ctrl->ctrl);
	if (ret > 0)
		ret = -EIO;
	return ERR_PTR(ret);
out_free_ctrl:
	kfree(ctrl); ? <-- this is for nvme_rdma_ctrl alloc
	return ERR_PTR(ret);

target/loop.c
========
out_uninit_ctrl:
	nvme_uninit_ctrl(&ctrl->ctrl);
out_put_ctrl:
	nvme_put_ctrl(&ctrl->ctrl);
	kfree(ctrl); ? <-- the proposed fix for nvme_loop_ctrl alloc
	if (ret > 0)
		ret = -EIO;
	return ERR_PTR(ret);
}
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
