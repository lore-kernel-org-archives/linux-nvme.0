From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Oct 2015 09:37:14 +0200
Subject: [PATCH 06/18] nvme: split a new struct nvme_ctrl out of struct
 nvme_dev
In-Reply-To: <1445462626.3307.64.camel@linux.intel.com>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-7-git-send-email-hch@lst.de>
 <1445462626.3307.64.camel@linux.intel.com>
Message-ID: <20151022073714.GB20076@lst.de>

On Wed, Oct 21, 2015@02:23:46PM -0700, J Freyensee wrote:
> > -struct nvme_dev {
> > -	struct list_head node;
> > -	struct nvme_queue **queues;
> > +struct nvme_ctrl {
> 
> Whether it is a PCIe NVMe device with multiple controllers or something
> beyond PCIe, I think an instance of struct nvme_ctrl is going to need
> to know its cntlid.  How does this struct know its cntlid?  I'm not
> initially seeing it.  I think it would make more sense to have struct
> nvme_ctrl have a member that stores its cntlid value.  It would
> basically be the "name" of the specific nvme_ctrl instance allocated.

Right now nothing in the Linux PCIe driver knows the cntlid.  At least
for PCIe it's also fairly uninteresting for the driver.  Remeber this
is just a simple split for now, additional functionality will be built
on top of it.

> > -	bool subsystem;
> 
> Also, this is something probably a bit more far visioned, but I think
> struct nvme_ctrl would need a mechanism to know what NVMe subsystem it
> sits in.  Even if 'subsystem' stayed in the struct, I'm not sure how a
> bool would work for this.

See the reply for Keith on what this field does.  But at least for PCIe
the containing subsystem isn't all that interesting for the driver.  Maybe
as an additional safety check for the Namespae GUIDs in a multipathing
setup, but that's about it.

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

The namespace lists moves to nvme_ctrl in this list, and the dev field
has always been a backpointer that's now replaced with a backpointer to
the nvme_ctrl structure.
