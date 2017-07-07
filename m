From: keith.busch@intel.com (Keith Busch)
Date: Fri, 7 Jul 2017 15:54:29 -0400
Subject: [PATCH 6/7] nvme: Unexport starting async event work
In-Reply-To: <20170707181146.GB24427@lst.de>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
 <1499444581-28268-7-git-send-email-keith.busch@intel.com>
 <20170707181146.GB24427@lst.de>
Message-ID: <20170707195428.GC14788@localhost.localdomain>

On Fri, Jul 07, 2017@08:11:46PM +0200, Christoph Hellwig wrote:
> > +static void nvme_queue_async_events(struct nvme_ctrl *ctrl)
> >  {
> >  	queue_work(nvme_wq, &ctrl->async_event_work);
> >  }
> > -EXPORT_SYMBOL_GPL(nvme_queue_async_events);
> 
> I'd just kill this helper now that it's not even exported.

Agreed, I'll take that out for v2. I'll wait till next week to see if
there's any comments on the previous patches before sending.
