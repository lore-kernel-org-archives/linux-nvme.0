From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Oct 2015 09:45:29 +0200
Subject: [PATCH 18/18] nvme: move chardev and sysfs interface to common
 code
In-Reply-To: <1445472671.3307.111.camel@linux.intel.com>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
 <1444975128-8768-19-git-send-email-hch@lst.de>
 <1445472671.3307.111.camel@linux.intel.com>
Message-ID: <20151022074529.GE20076@lst.de>

On Wed, Oct 21, 2015@05:11:11PM -0700, J Freyensee wrote:
> > +	spin_lock(&dev_list_lock);
> > +	list_for_each_entry(ctrl, &nvme_ctrl_list, node) {
> 
> list_for_each_entry_safe() and/or some type of lock access?

list_for_each_entry_safe does not synchronize, it just ensures you
can continue to iterate after deleting the current item.

And the spin_lock() call above provides the required synchronization.

> > +	if (result < 0)
> > +		goto unregister_blkdev;
> > +	else if (result > 0)
> > +		nvme_char_major = result;
> > +
> > +	nvme_class = class_create(THIS_MODULE, "nvme");
> 
> It would be better to have "nvme" as a #define somewhere, probably in
> the .h?

Why?

> >  	char name[12];
> >  	char serial[20];
> > @@ -60,6 +59,8 @@ struct nvme_ctrl {
> >  	u16 abort_limit;
> >  	u8 event_limit;
> >  	u8 vwc;
> > +	u32 vs;
> > +	bool subsystem;
> 
> OK, so 'bool subsystem' got added back in.  Not sure still how a bool
> helps define a controller into a given subsystem.  Isn't the definition
> of an NVM subsystem 1 or more controllers?  So every new 'struct
> nvme_ctrl' instance is going to set this to 'true'?

In NVMe 1.0 the concept of subsystems didn't exist.  Now strictly speaking
what we care about here is if a subsystem _reset_ is supported, but I've
kept the name from the existing code for now.

> Or looking into the future, say if this is on a future fabric
> connection, there could be lots of controllers under lots of distinct
> subsystems.  Then I don't know how 'bool subsystem' makes sense and
> distinguishes a controller in a given NVM subsystem.

That's not what the flag is used for.  It just indicates if we can do
a subsystem reset.

> > @@ -87,7 +88,9 @@ struct nvme_ns {
> >  struct nvme_ctrl_ops {
> >  	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 
> > *val);
> >  	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 
> > *val);
> > +	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 
> > val);
> 
> I don't think they are being used currently, but the ACQ and ASQ 8-byte
> registers do have RW fields.  Maybe add "int (*reg_write64)()" as well?

We can do that once we actually need it.  But at least ACQ and ASQ are
deeply tied to PCI specific initialization so right now there is no need
for that.

> >  	bool (*io_incapable)(struct nvme_ctrl *ctrl);
> > +	int (*reset_ctrl)(struct nvme_ctrl *ctrl);
> 
> Probably would want a "(*shutdown_ctrl)()" as well?

We currently don't shut the controller down from generic code, so until
we have a state machine that might do that there's no need for that.

> 
> > +	return ctrl->ops->reg_write32(ctrl, NVME_REG_NSSR, 
> > 0x4E564D65);
> 
> It would be really good to have the hex value in a #define, most likely
> located in the nvme.h file.

Feel free to send incremental patches for these sorts of cleanups!
