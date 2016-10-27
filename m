From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 27 Oct 2016 09:00:17 -0700
Subject: [PATCH] nvme-loop: kfree(ctrl) on _create() error exit
In-Reply-To: <1477582813.2838.11.camel@linux.intel.com>
References: <1477513257-30474-1-git-send-email-james_p_freyensee@linux.intel.com>
 <20161027124906.GA28200@infradead.org>
 <1477582813.2838.11.camel@linux.intel.com>
Message-ID: <20161027160017.GA15393@infradead.org>

On Thu, Oct 27, 2016@08:40:13AM -0700, J Freyensee wrote:
> But doesn't nvme_put_ctrl() just take care of the nvme_ctrl? ?The
> kfree(ctrl) is for nvme_loop_ctrl instance being kzalloc'ed at the
> beginning of the function.

The nvmet_ctrl structure is embedded into the nvme_loop_ctrl structure,
it's not a separate allocation.

> ?I don't think this is any different than
> what is done for the create_ctrl() implementation in host/rdma.c?:
> 
> host/rdma.c
> ===========
> out_uninit_ctrl:
> 	nvme_uninit_ctrl(&ctrl->ctrl);
> 	nvme_put_ctrl(&ctrl->ctrl);
> 	if (ret > 0)
> 		ret = -EIO;
> 	return ERR_PTR(ret);

This is the case after nvme_init_ctrl and we just do the put and then
return.

> out_free_ctrl:
> 	kfree(ctrl); ? <-- this is for nvme_rdma_ctrl alloc
> 	return ERR_PTR(ret);

And this is the case before we did nvme_init_ctrl and we just kfree the
ctrl.
