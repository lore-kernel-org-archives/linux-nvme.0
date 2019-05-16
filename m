From: kbusch@kernel.org (Keith Busch)
Date: Thu, 16 May 2019 08:14:36 -0600
Subject: [PATCH 3/6] nvme-pci: Unblock reset_work on IO failure
In-Reply-To: <20190516031333.GC16342@ming.t460p>
References: <20190515163625.21776-1-keith.busch@intel.com>
 <20190515163625.21776-3-keith.busch@intel.com>
 <20190516031333.GC16342@ming.t460p>
Message-ID: <20190516141435.GB23333@localhost.localdomain>

On Wed, May 15, 2019@08:13:35PM -0700, Ming Lei wrote:
> On Wed, May 15, 2019@10:36:22AM -0600, Keith Busch wrote:
> > +		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
> > +		/* fall through */
> > +	case NVME_CTRL_DELETING:
> >  		dev_warn_ratelimited(dev->ctrl.device,
> >  			 "I/O %d QID %d timeout, disable controller\n",
> >  			 req->tag, nvmeq->qid);
> > -		nvme_dev_disable(dev, shutdown);
> > +		nvme_dev_disable(dev, true);
> >  		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
> >  		return BLK_EH_DONE;
> >  	case NVME_CTRL_RESETTING:
> 
> Then the controller is dead, and can't work any more together with data
> loss. I guess this way is too violent from user view.

Indeed, it is a bit harsh; however, it is definitely better than having a
stuck controller unable to make forward progress. We may be able to do
better, but I think this patch is a step in the right direction.
