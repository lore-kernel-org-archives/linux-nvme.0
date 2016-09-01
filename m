From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 1 Sep 2016 08:34:23 -0500
Subject: [PATCH WIP/RFC v3 5/6] nvme-rdma: add DELETING queue flag
In-Reply-To: <20160901084101.GE3703@lst.de>
References: <cover.1472574410.git.swise@opengridcomputing.com>
 <0893620168fb1fd904fa1ff8b4893ffdb44214e8.1472574410.git.swise@opengridcomputing.com>
 <20160901084101.GE3703@lst.de>
Message-ID: <004501d20455$8d3a38a0$a7aea9e0$@opengridcomputing.com>



> -----Original Message-----
> From: Christoph Hellwig [mailto:hch at lst.de]
> Sent: Thursday, September 01, 2016 3:41 AM
> To: swise at opengridcomputing.com; Sagi Grimberg
> Cc: hch at lst.de; linux-nvme at lists.infradead.org
> Subject: Re: [PATCH WIP/RFC v3 5/6] nvme-rdma: add DELETING queue flag
> 
> Steve,
> 
> this mail pretends to be from Sagi, which given the threading looks
> unlikely.  Can you fix up your patch mail scripts so that it appears
> from you and has another
> 
> From: Sagi Grimberg <sagi at grimberg.me>
> 
> line in the mail body?


Yes, I screwed up here.  I'll fix it in v4.



> 
> > diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> > index c2f6cc6..8036c23 100644
> > --- a/drivers/nvme/host/rdma.c
> > +++ b/drivers/nvme/host/rdma.c
> > @@ -88,6 +88,7 @@ struct nvme_rdma_request {
> >  enum nvme_rdma_queue_flags {
> >  	NVME_RDMA_Q_CONNECTED = (1 << 0),
> >  	NVME_RDMA_IB_QUEUE_ALLOCATED = (1 << 1),
> > +	NVME_RDMA_Q_DELETING = (1 << 2),
> 
> Can we please aligned these now that we have a few?
> 
> 	NVME_RDMA_Q_CONNECTED		= (1 << 0),
> 	NVME_RDMA_IB_QUEUE_ALLOCATED	= (1 << 1),
> 	NVME_RDMA_Q_DELETING		= (1 << 2),
> 
> 
> Otherwise this looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>
