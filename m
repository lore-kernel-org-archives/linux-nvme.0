From: keith.busch@intel.com (Busch, Keith)
Date: Wed, 21 Oct 2015 22:51:00 +0000
Subject: [PATCH 06/18] nvme: split a new struct nvme_ctrl out of struct
 nvme_dev
In-Reply-To: <1445462626.3307.64.camel@linux.intel.com>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-7-git-send-email-hch@lst.de>
 <1445462626.3307.64.camel@linux.intel.com>
Message-ID: <20151021225059.GA21840@localhost.localdomain>

On Wed, Oct 21, 2015@02:23:46PM -0700, J Freyensee wrote:
> >  	char firmware_rev[8];
> > -	bool subsystem;
> 
> Also, this is something probably a bit more far visioned, but I think
> struct nvme_ctrl would need a mechanism to know what NVMe subsystem it
> sits in.  Even if 'subsystem' stayed in the struct, I'm not sure how a
> bool would work for this.

The bool is not to identify a specific subsystem. It's only to notify
the driver that this controller is subsystem capable. In other words,
please periodically check the subsystem reset notification since that
can happen at anytime externally from host connected to the controller,
and we want to know when such events occur.

> > @@ -78,7 +48,7 @@ struct nvme_dev {
> >  struct nvme_ns {
> >  	struct list_head list;
> >  
> > -	struct nvme_dev *dev;
> > +	struct nvme_ctrl *ctrl;
> 
> This seems a bit backwards to me.  It's the controller (cntlid) that is
> going to tell the host how many namespaces are associated with it via
> the NVMe Identify commands.  Thus, I would have thought that a list of
> struct nvme_ns instances would be in a struct nvme_ctrl definition, not
> vice-versa.  Unless '*ctrl' is going to be used as a back pointer?  But
> then in 'struct nvme_ctrl' I didn't see initially see anything that
> associates itself to the namespaces attached to it.

The 'ctrl' pointer is a back pointer to the owning controller.

The controller itself contains a list_head appropriately called
'namespaces' to hold a reference to all its namespaces. The nvme_ns
list_head 'list' is simply the entry item for that list.
