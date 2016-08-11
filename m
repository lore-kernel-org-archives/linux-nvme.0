From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Thu, 11 Aug 2016 16:24:45 -0700
Subject: [PATCH RFC 2/4] nvme-rdma: fix sqsize/hsqsize/hrqsize per spec
In-Reply-To: <20160811152154.GB19738@lst.de>
References: <1470888438-823-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1470888438-823-3-git-send-email-james_p_freyensee@linux.intel.com>
 <20160811152154.GB19738@lst.de>
Message-ID: <1470957885.4474.30.camel@linux.intel.com>

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

So what I'm understanding is to keep ctrl->ctrl.sqsize as ones-based in
the code but when we actually do something like a connect() send
sqsize-1 in the connect() command.

That almost works, but is still a tad ugly because there are code lines
such as:

ctrl->ctrl.sqsize =
????????????????min_t(int, NVME_CAP_MQES(ctrl->cap) + 1, ctrl-
>ctrl.sqsize);

in which also need to be adjusted because what is currently going on
here is NVME_CAP_MQES() is a zero-based value but ctrl->ctrl.sqsize is
currently implemented as a one's-based value.
