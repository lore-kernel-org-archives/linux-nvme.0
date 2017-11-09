From: keith.busch@intel.com (Keith Busch)
Date: Thu, 9 Nov 2017 09:18:46 -0700
Subject: [PATCHv3 5/5] nvme: Send uevent for some asynchronous events
In-Reply-To: <20171109092702.GE17120@lst.de>
References: <20171107221314.27822-1-keith.busch@intel.com>
 <20171107221314.27822-6-keith.busch@intel.com>
 <20171109092702.GE17120@lst.de>
Message-ID: <20171109161846.GE25017@localhost.localdomain>

On Thu, Nov 09, 2017@10:27:03AM +0100, Christoph Hellwig wrote:
> On Tue, Nov 07, 2017@03:13:14PM -0700, Keith Busch wrote:
> > +static void nvme_aen_uevent(struct nvme_ctrl *ctrl)
> > +{
> > +	char *envp[2] = {NULL, NULL};
> > +	u32 aen = ctrl->aen;
> > +
> > +	ctrl->aen = 0;
> 
> Seems like we should use cmpxchg on aen.

> > +		ctrl->aen = result;
> 
> Can we call the field aen_result?
> 
> Given that the rest of the series looks good I'd be tempted to just
> fix that up and apply it.  Are you ok with that?

Thanks, the suggestions sound good to me. If you want to edit the commit
when applying, I would much appreciate.
