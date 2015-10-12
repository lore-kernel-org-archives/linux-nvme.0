From: axboe@fb.com (Jens Axboe)
Date: Mon, 12 Oct 2015 14:08:04 -0600
Subject: [PATCH, RFC] blk-mq: use a delayed work item for timeouts
In-Reply-To: <561C0B3C.70004@fb.com>
References: <1444678154-24766-1-git-send-email-hch@lst.de>
 <561C0B3C.70004@fb.com>
Message-ID: <561C1324.3030800@fb.com>

On 10/12/2015 01:34 PM, Jens Axboe wrote:
> On 10/12/2015 01:29 PM, Christoph Hellwig wrote:
>> For some pending NVMe work I'd really love to be able to get my timeouts
>> from process context.  So far it seems only SCSI and NVMe use the blk-mq
>> timeout handler, and both don't seem to be particularly excited about
>> being called from time context.  Does anyone have an objection against
>> the patch below that switches it to use a delayed work item?  I could
>> make use of this quickly for NVMe, but for SCSI we still have to deal
>> with the old request code which can't be switched to a delayed work
>> as easily.
>
> No that's definitely fine with me, imho most error handling callbacks
> should be in process context for ease of use in the driver.

Took a closer look. The patch looks incomplete. The hot path for blk-mq 
is blk_add_timer(), looks like you left that one alone in the conversion?

Might be easier to just leave the timer alone, and if it actually fires 
_and_ we have to do something, punt to a workqueue instead of invoking 
the timeout handler directly.

-- 
Jens Axboe
