From: keith.busch@intel.com (Busch, Keith)
Date: Mon, 22 Jul 2013 15:00:35 +0000
Subject: [PATCHv2] NVMe: Async event request
In-Reply-To: <20130719204158.GH4855@linux.intel.com>
References: <1374257615-19201-1-git-send-email-keith.busch@intel.com>
 <20130719204158.GH4855@linux.intel.com>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B93AEE4022@FMSMSX104.amr.corp.intel.com>

On Fri Jul 19, 2013@2:42 PM, Matthew Wilcox wrote:
> > +static void nvme_async_completion(struct nvme_dev *dev, void *ctx,
> > +						struct nvme_completion *cqe)
> > +{
> > +	u32 result = le32_to_cpup(&cqe->result);
> > +	u16 status = le16_to_cpup(&cqe->status) >> 1;
> > +
> > +	if (status == NVME_SC_SUCCESS) {
> > +		struct nvme_async_completion event;
> > +
> > +		if (kfifo_is_full(&dev->event_fifo))
> > +			kfifo_out(&dev->event_fifo, &event, sizeof(event));
> > +
> > +		memset(&event, 0, sizeof(event));
> > +		event.status = status;
> 
> Open question ... should we report the status in the bottom 15 bits of
> this field or the top 15 bits of this field?  I kind of like reporting
> it in the bottom 15 bits so we can set the top bit and report a
> completely different set of status events that way.  On the other hand,
> it's then different from an NVMe completion, and we could accomplish
> the same effect by setting the bottom bit to indicate a Linux-private
> event.

I actually wasn't sure why we want to report the status in the first place. A non-zero status means something went wrong with the command that user space couldn't handle, right? This implementation doesn't even enqueue an event for reading if the command failed, so if my assumption is wrong, then I can definitely change that.
