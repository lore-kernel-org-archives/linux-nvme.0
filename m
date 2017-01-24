From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Mon, 23 Jan 2017 16:20:03 -0800
Subject: [PATCH v4 2/6] block: Add Sed-opal library
In-Reply-To: <20170119182839.GB9228@sbauer-Z170X-UD5>
References: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
 <1483039615-22407-3-git-send-email-scott.bauer@intel.com>
 <20170119182839.GB9228@sbauer-Z170X-UD5>
Message-ID: <1485217203.2574.4.camel@linux.intel.com>

On Thu, 2017-01-19@11:28 -0700, Scott Bauer wrote:
> > 
> > +struct opal_dev *alloc_opal_dev(struct request_queue *q)
> > +{
> > +	struct opal_dev *opal_dev;
> > +	unsigned long dma_align;
> > +	struct opal_cmd *cmd;
> > +
> > +	opal_dev = kzalloc(sizeof(*opal_dev), GFP_KERNEL);
> > +	if (!opal_dev)
> > +		return opal_dev;
> > +
> > +	cmd = &opal_dev->cmd;
> > +	cmd->cmd = cmd->cmd_buf;
> > +	cmd->resp = cmd->resp_buf;
> > +
> > +	dma_align = (queue_dma_alignment(q) | q->dma_pad_mask) + 1;
> > +	cmd->cmd = (u8 *)round_up((uintptr_t)cmd->cmd, dma_align);
> > +	cmd->resp = (u8 *)round_up((uintptr_t)cmd->resp, dma_align);
> > +
> > +	INIT_LIST_HEAD(&opal_dev->unlk_lst);
> > +	opal_dev->state = 0;
> > +
> > +	mutex_init(&opal_dev->dev_lock);
> > +
> > +	return opal_dev;
> > +
> > +}
> > +EXPORT_SYMBOL(alloc_opal_dev);
> 
> Internally we've been discussing this function. We don't like the requirement
> that we have to pass in a request_queue just to allocate an opal dev.
> 
> We have a few ideas and wanted to toss them out here and see if anyone has
> one they love or one they hate.
> 
> So Idea one:
> 
> Pass in the alignment insetead of the request_queue. This pushes the burden
> onto the driver calling alloc_opal_dev instead of the opal core. It also
> removes
> the requirement of passing in a request_queue to something we think should be
> agnostic to any blocklayer/lower level structures/knowledge.
> 
> 

I would think it would be easier to support and validate and guarantee working
operation of opal if the driver controlled the alignment instead relying on
someone else in the kernel to make sure it's aligned. ?Plus wouldn't this also
supply a more optimized solution?


> Idea two:
> 
> Just let alloc_opal_dev kzalloc normally and do no alignment. It would then
> be up to the drivers to move the data from the buffer to a bounce buffer,
> that is aligned, in the send/recv functions before sending down to the
> controller.
> 
> Both are easy to implement but we wanted to see if anyone had other ideas or
> liked
> one over the other.
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
