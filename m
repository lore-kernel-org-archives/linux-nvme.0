From: keith.busch@intel.com (Keith Busch)
Date: Mon, 23 May 2016 11:22:09 -0400
Subject: [PATCH v2 1/2] nvme: switch to RCU freeing the namespace
In-Reply-To: <20160523103858.GA21986@lst.de>
References: <20160517152359.GC14260@localhost.localdomain>
 <20160517153003.GA18529@localhost.localdomain>
 <CAF1ivSaEg2wiH3hwpRmeK7ua69ERT5MP8MqZyuc6Dtb2fes6gg@mail.gmail.com>
 <20160517210706.GB19325@localhost.localdomain>
 <CAF1ivSbi8rXgsM885w0EMyzMnDuiGOUUfu3o+RKbz1KG2jJW6Q@mail.gmail.com>
 <20160517212542.GC19325@localhost.localdomain>
 <1463637146.8610.4.camel@kernel.org>
 <20160519204829.GB28795@localhost.localdomain>
 <20160520141649.GC28795@localhost.localdomain>
 <20160523103858.GA21986@lst.de>
Message-ID: <20160523152209.GC17208@localhost.localdomain>

On Mon, May 23, 2016@12:38:58PM +0200, Christoph Hellwig wrote:
> On Fri, May 20, 2016@10:16:50AM -0400, Keith Busch wrote:
> > +static int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
> > +{
> > +	ctrl->state = NVME_CTRL_NEW;
> 
> Please always go through nvme_change_ctrl_state for state machine
> changes - this function documents the possible ?tate transitions.
> 
> Also I don't think returning to state called _new is a good idea,
> I'd rather have a different name for a state like that.  That being
> said I thinkg we absolutely need a state for the time between
> scheduling a reset and changing the state to NVME_CTRL_RESETTING
> in nvme_reset_work.  I just can't think of a really food name for it.
> NVME_CTRL_PRE_RESET?  NVME_CTRL_RESET_PENDING?

Thanks for the suggestions. I'll fix it up as a proper patch and send
for consideration.

NVME_CTRL_SCHED_RESET? Naming is hard ...
