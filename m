From: axboe@fb.com (Jens Axboe)
Date: Mon, 12 Oct 2015 13:34:20 -0600
Subject: [PATCH, RFC] blk-mq: use a delayed work item for timeouts
In-Reply-To: <1444678154-24766-1-git-send-email-hch@lst.de>
References: <1444678154-24766-1-git-send-email-hch@lst.de>
Message-ID: <561C0B3C.70004@fb.com>

On 10/12/2015 01:29 PM, Christoph Hellwig wrote:
> For some pending NVMe work I'd really love to be able to get my timeouts
> from process context.  So far it seems only SCSI and NVMe use the blk-mq
> timeout handler, and both don't seem to be particularly excited about
> being called from time context.  Does anyone have an objection against
> the patch below that switches it to use a delayed work item?  I could
> make use of this quickly for NVMe, but for SCSI we still have to deal
> with the old request code which can't be switched to a delayed work
> as easily.

No that's definitely fine with me, imho most error handling callbacks 
should be in process context for ease of use in the driver.


-- 
Jens Axboe
