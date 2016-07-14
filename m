From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 14 Jul 2016 09:30:51 -0500
Subject: [PATCH 2/2] nvme-rdma: move admin queue cleanup to
 nvme_rdma_free_ctrl
In-Reply-To: <578758AA.5050908@grimberg.me>
References: <1468445196-6915-1-git-send-email-mlin@kernel.org>
 <1468445196-6915-3-git-send-email-mlin@kernel.org>
 <57875835.5050001@grimberg.me> <578758AA.5050908@grimberg.me>
Message-ID: <00b201d1dddc$524bad90$f6e308b0$@opengridcomputing.com>



> -----Original Message-----
> From: Sagi Grimberg [mailto:sagi at grimberg.me]
> Sent: Thursday, July 14, 2016 4:18 AM
> To: Ming Lin; linux-nvme at lists.infradead.org
> Cc: Christoph Hellwig; Steve Wise; Jens Axboe
> Subject: Re: [PATCH 2/2] nvme-rdma: move admin queue cleanup to
> nvme_rdma_free_ctrl
> 
> 
> > This patch introduces asymmetry between create and destroy
> > of the admin queue. Does this alternative patch solve
> > the problem?
> >
> > The patch changes the order of device removal flow from:
> > 1. delete controller
> > 2. destroy queue
> >
> > to:
> > 1. destroy queue
> > 2. delete controller
> >
> > Or more specifically:
> > 1. own the controller deletion (make sure we are not
> > competing with anyone)
> > 2. get rid of inflight reconnects (which also destroy and
> > create queues)
> > 3. destroy the queue
> > 4. safely queue controller deletion
> >
> > Thoughts?
> 
> Should mention that patch 1 is not needed as well with this...

Hey Sagi, This patch won't apply.  I think it is munged in the email.  Can you
please email me the patch as an attachment? 

Thanks,

Steve.
