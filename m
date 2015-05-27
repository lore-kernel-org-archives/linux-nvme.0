From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Wed, 27 May 2015 13:47:15 +0300
Subject: nvme: submit internal commands through the block layer
In-Reply-To: <20150527075652.GA24737@lst.de>
References: <20150526090815.GA32137@mwanda>
 <20150527075652.GA24737@lst.de>
Message-ID: <20150527104715.GH11734@mwanda>

On Wed, May 27, 2015@09:56:52AM +0200, Christoph Hellwig wrote:
> On Tue, May 26, 2015@12:08:15PM +0300, Dan Carpenter wrote:
> > drivers/block/nvme-core.c
> >    853		 */
> >    854		if (ns && ns->ms && !blk_integrity_rq(req)) {
> >                     ^^
> > Patch adds a new check.
> 
> Correctly so ..
> 
> >    912		nvme_set_info(cmd, iod, req_completion);
> >    913		spin_lock_irq(&nvmeq->q_lock);
> >    914		if (req->cmd_type == REQ_TYPE_DRV_PRIV)
> >    915			nvme_submit_priv(nvmeq, req, iod);
> >    916		else if (req->cmd_flags & REQ_DISCARD)
> >    917			nvme_submit_discard(nvmeq, ns, req, iod);
> >                                                    ^^
> > Dereferenced inside function.
> > 
> >    918		else if (req->cmd_flags & REQ_FLUSH)
> >    919			nvme_submit_flush(nvmeq, ns, req->tag);
> 
> We'll only get REQ_TYPE_DRV_PRIV requests through the passthrough
> interface, so this is unrechable.

Thanks for looking into this, Christoph.

regards,
dan carpenter
