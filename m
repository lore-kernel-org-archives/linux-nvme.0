From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 10 Aug 2017 11:04:10 +0200
Subject: [PATCH 1/2] nvmet_fc: add defer_req callback for deferment of
 cmd buffer return
In-Reply-To: <20170802081617.GD4256@linux-x5ow.site>
References: <20170801221240.31723-1-jsmart2021@gmail.com>
 <20170801221240.31723-2-jsmart2021@gmail.com>
 <20170802081617.GD4256@linux-x5ow.site>
Message-ID: <20170810090410.x7xrk6dhml7ce7yh@infradead.org>

On Wed, Aug 02, 2017@10:16:17AM +0200, Johannes Thumshirn wrote:
> On Tue, Aug 01, 2017@03:12:39PM -0700, James Smart wrote:
> > @@ -463,9 +472,9 @@ static struct nvmet_fc_fcp_iod *
> >  nvmet_fc_alloc_fcp_iod(struct nvmet_fc_tgt_queue *queue)
> >  {
> >  	static struct nvmet_fc_fcp_iod *fod;
> > -	unsigned long flags;
> >  
> > -	spin_lock_irqsave(&queue->qlock, flags);
> > +	/* Caller must hold queue->qlock */
> +       lockped_assert_held(&queue->qlock); 
> So we can check if the caller really holds the queue lock.

I've added the assert after applying the patch to the nvme-4.13 tree.

> > +
> >  	fod = list_first_entry_or_null(&queue->fod_list,
> >  					struct nvmet_fc_fcp_iod, fcp_list);
> >  	if (fod) {
> 
> [...]
> 
> > +	for (;;) {
> > +		deferfcp = list_first_entry_or_null(&queue->pending_cmd_list,
> > +				struct nvmet_fc_defer_fcp_req, req_list);
> > +		if (!deferfcp)
> > +			break;
> 
>         while ((deferfcp = list_first_entry_or_null(&queue->pending_cmd_list,
> 				struct nvmet_fc_defer_fcp_req,
> 				req_list)) != NULL) {
> ?
> 
> Other than that,

I have to admit that I'd just prefer an opencoded list_empty +
container_of in both cases.  But given that all that is just personal
preference I've left the code as submitted by James.
