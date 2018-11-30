From: hch@lst.de (Christoph Hellwig)
Date: Fri, 30 Nov 2018 09:16:29 +0100
Subject: [PATCH 08/13] nvme-pci: remove the CQ lock for interrupt
 driven queues
In-Reply-To: <20181129210840.GG9377@localhost.localdomain>
References: <20181129191310.9795-1-hch@lst.de>
 <20181129191310.9795-9-hch@lst.de>
 <20181129210840.GG9377@localhost.localdomain>
Message-ID: <20181130081629.GD18936@lst.de>

On Thu, Nov 29, 2018@02:08:40PM -0700, Keith Busch wrote:
> On Thu, Nov 29, 2018@08:13:05PM +0100, Christoph Hellwig wrote:
> > @@ -1050,12 +1051,16 @@ static irqreturn_t nvme_irq(int irq, void *data)
> >  	irqreturn_t ret = IRQ_NONE;
> >  	u16 start, end;
> >  
> > -	spin_lock(&nvmeq->cq_lock);
> > +	/*
> > +	 * The rmb/wmb pair ensures we see all updates from a previous run of
> > +	 * the irq handler, even if that was on another CPU.
> > +	 */
> > +	rmb();
> >  	if (nvmeq->cq_head != nvmeq->last_cq_head)
> >  		ret = IRQ_HANDLED;
> >  	nvme_process_cq(nvmeq, &start, &end, -1);
> >  	nvmeq->last_cq_head = nvmeq->cq_head;
> > -	spin_unlock(&nvmeq->cq_lock);
> > +	wmb();
> >  
> >  	if (start != end) {
> >  		nvme_complete_cqes(nvmeq, start, end);
> 
> We saved the "start, end" only so we could do the real completion
> without holding a queue lock. Since you're not using a lock anymore,
> a further optimization can complete the CQE inline with moving the cq
> head so that we don't go through queue twice.
> 
> That can be a follow on, though, this patch looks fine.

We still hold the lock for the polling case.
