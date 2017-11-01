From: keith.busch@intel.com (Keith Busch)
Date: Wed, 1 Nov 2017 10:21:47 -0600
Subject: [PATCH] nvme: freeze IO accesses around format
In-Reply-To: <20171101155603.GC25317@infradead.org>
References: <6951d74c-e765-1b5d-6e39-d88d261bf9b9@kernel.dk>
 <20171027230756.GA17245@localhost.localdomain>
 <20171101155603.GC25317@infradead.org>
Message-ID: <20171101162147.GA26245@localhost.localdomain>

On Wed, Nov 01, 2017@08:56:03AM -0700, Christoph Hellwig wrote:
> >     If the controller does not support the command effects log page, the
> >     driver will define the effects for known opcodes. The nvme format is
> >     the only such command in this patch with known effects.
> 
> Sanitize is another one.  Also Format might either affect a single
> namespace or the whole controller depending on what it advertises in
> FNA.

Okay, we can freeze single nvme namespace's request queues if desired.
It's only a little more code to do that.
 
> static u32 nvme_get_admin_effects((struct nvme_ctrl *ctrl, u8 opcode)
> {
> 	if (ctrl->effects)
> 		return le32_to_cpu(ctrl->effects->acs[opcode]);
> 
> 	switch (opcode) {
> 		...
> 	}
> }
> 
> That is: a) return the value instead of pass by reference, and
> b) if the controller supports the log page rely on it.

Agreed, that's better.
 
> Also don't we need to also handle this for I/O commands?  While
> non of the currently defined I/O commands would need anything, the
> spec defines the mechanism? and it might be useful for vendor
> specific commands

That gets tricky. What if the IO command effects says it needs to run
exclusively? We don't have a way to quiesce IO queues and then issue our
exclusive IO through the frozen queue. We'd deadlock trying to allocate
a request from it.

If it's okay, I'd like to handle the IO command effects separately for
future work.

> > +static void nvme_passthru_start(struct nvme_ctrl *ctrl, u32 effects)
> > +{
> > +	if (effects & (NVME_CMD_FX_LBCC | NVME_CMD_FX_CSE_MASK)) {
> > +		nvme_start_freeze(ctrl);
> > +		nvme_wait_freeze(ctrl);
> > +	}
> > +}
> 
> I'd move the nvme_get_admin_effects call into this, and return the
> value from this function to keep the caller a little more uncluttered.

Sounds good.
 
> > +static int nvme_get_log(struct nvme_ctrl *ctrl, u8 log_page, void *log, size_t size)
> 
> To loong line again.  Also I think adding this helper should probably
> be a preparation patch.

Will do.
 
> > +static void nvme_scan_work(struct work_struct *work)
> > +{
> > +	struct nvme_ctrl *ctrl =
> > +		container_of(work, struct nvme_ctrl, scan_work);
> > +
> > +	nvme_scan(ctrl);
> > +}
> 
> Why do we do the scan inline here, but not in any other place?

Huh, not sure. I wanted the driver to react to the command's effects
before returning from the ioctl. I don't know why I thought that was
important, though. Will queue it as normal.

> >  enum {
> > +	NVME_CMD_FX_CSUPP	= 1 << 0,
> > +	NVME_CMD_FX_LBCC	= 1 << 1,
> > +	NVME_CMD_FX_NCC		= 1 << 2,
> > +	NVME_CMD_FX_NIC		= 1 << 3,
> > +	NVME_CMD_FX_CCC		= 1 << 4,
> > +	NVME_CMD_FX_CSE_MASK	= 3 << 16,
> 
> s/NVME_CMD_FX/NVME_CMD_EFFECTS/g ?

Just trying to shorten the name with an abbreviation. Will spell it out
in the next patch.

Thanks for the feedback.
