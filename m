From: hch@lst.de (Christoph Hellwig)
Date: Fri, 30 Nov 2018 09:08:09 +0100
Subject: [PATCH 07/13] nvme-pci: don't poll from irq context when
 deleting queues
In-Reply-To: <20181129203632.GE9377@localhost.localdomain>
References: <20181129191310.9795-1-hch@lst.de>
 <20181129191310.9795-8-hch@lst.de>
 <20181129203632.GE9377@localhost.localdomain>
Message-ID: <20181130080809.GC18936@lst.de>

On Thu, Nov 29, 2018@01:36:32PM -0700, Keith Busch wrote:
> On Thu, Nov 29, 2018@08:13:04PM +0100, Christoph Hellwig wrote:
> > This is the last place outside of nvme_irq that handles CQEs from
> > interrupt context, and thus is in the way of removing the cq_lock for
> > normal queues, and avoiding lockdep warnings on the poll queues, for
> > which we already take it without IRQ disabling.
> > 
> > Signed-off-by: Christoph Hellwig <hch at lst.de>
> > ---
> >  drivers/nvme/host/pci.c | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 9ceba9900ca3..fb8db7d8170a 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -203,6 +203,7 @@ struct nvme_queue {
> >  	unsigned long flags;
> >  #define NVMEQ_ENABLED		0
> >  #define NVMEQ_SQ_CMB		1
> > +#define NVMEQ_DELETE_ERROR	2
> >  	u32 *dbbuf_sq_db;
> >  	u32 *dbbuf_cq_db;
> >  	u32 *dbbuf_sq_ei;
> > @@ -2216,7 +2217,7 @@ static void nvme_del_cq_end(struct request *req, blk_status_t error)
> >  	struct nvme_queue *nvmeq = req->end_io_data;
> >  
> >  	if (!error)
> > -		nvme_poll_irqdisable(nvmeq, -1);
> > +		set_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags);
> >  
> >  	nvme_del_queue_end(req, error);
> >  }
> > @@ -2258,11 +2259,20 @@ static bool nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
> >  		nr_queues--;
> >  		sent++;
> >  	}
> > -	while (sent--) {
> > +	while (sent) {
> > +		struct nvme_queue *nvmeq = &dev->queues[nr_queues + sent];
> > +
> >  		timeout = wait_for_completion_io_timeout(&dev->ioq_wait,
> >  				timeout);
> >  		if (timeout == 0)
> >  			return false;
> > +
> > +		/* handle any remaining CQEs */
> > +		if (opcode == nvme_admin_delete_cq &&
> > +		    !test_bit(NVMEQ_DELETE_ERROR, &nvmeq->flags))
> > +			nvme_poll_irqdisable(nvmeq, -1);
> 
> We're dispatchig lots of queue deletions in parallel, and they may
> complete in any order. I don't see how you can guarantee that the
> wait_for_completion() will return for the nvmeq that you're polling.

True.  I thought about moving the completion to the queue so that
we have one completion per queue, and I should have done that after
all.  Note sure how I got the idea that not doing it is fine.

> You also need to clear NVMEQ_DELETE_ERROR somewhere later, maybe in
> nvme_init_queue().

Indeed.
