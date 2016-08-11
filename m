From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Thu, 11 Aug 2016 09:40:55 -0700
Subject: [PATCH RFC 2/4] nvme-rdma: fix sqsize/hsqsize/hrqsize per spec
In-Reply-To: <20160811152154.GB19738@lst.de>
References: <1470888438-823-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1470888438-823-3-git-send-email-james_p_freyensee@linux.intel.com>
 <20160811152154.GB19738@lst.de>
Message-ID: <1470933655.2796.7.camel@linux.intel.com>

On Thu, 2016-08-11@17:21 +0200, Christoph Hellwig wrote:
> I think having different notations for hsqsize vs hrqsize is highly
> confusing, and I've asked for a clarification of the hrqsize
> definition
> which is ambious at it's best at the moment.??But independent of
> that a few more comments:
> 
> > 
> > @@ -1907,7 +1920,7 @@ static struct nvme_ctrl
> > *nvme_rdma_create_ctrl(struct device *dev,
> > ?	spin_lock_init(&ctrl->lock);
> > ?
> > ?	ctrl->queue_count = opts->nr_io_queues + 1; /* +1 for
> > admin queue */
> > -	ctrl->ctrl.sqsize = opts->queue_size;
> > +	ctrl->ctrl.sqsize = opts->queue_size-1;
> 
> We should keep our own sqsize in normal notation in core, and just
> convert to strange notations on the wire.??Especially as we use it
> to driver all the resource allocation as Sagi said.
> 
> 
> > 
> > +	if (priv.qid == 0) {
> > +		priv.hsqsize = cpu_to_le16(queue->ctrl-
> > >ctrl.admin_sqsize);
> > +		priv.hrqsize = cpu_to_le16(queue->ctrl-
> > >ctrl.admin_sqsize+1);
> 
> Based on that priv.hsqsize should have a - 1 here??and hrqsize should
> be kept as-is.??Also always use spaces around the operators.

Hmmm, not sure I understand. ?In this current patch series
implementation, admin_sqsize will be NVMF_AQ_DEPTH-1 (31), so it
doesn't need a -1.

Then you are saying do NOT add hrqsize? ?Thus, hsqsize == hrqsize??

> 
> And while we're at it - the fix to use the separate AQ values should
> go into the first patch.

It will get re-worked anyways based on the interest to not have a
variable at the moment at someone's disposal to create variable-sized
admin queue depths.
