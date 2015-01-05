From: keith.busch@intel.com (Keith Busch)
Date: Mon, 5 Jan 2015 15:17:33 +0000 (UTC)
Subject: [PATCH 0/4] nvme-blkmq fixes
In-Reply-To: <54A4268A.6030504@fb.com>
References: <1419036856-16275-1-git-send-email-keith.busch@intel.com>
 <5495B2BF.8070602@fb.com> <5495CDFE.3060404@fb.com>
 <alpine.LNX.2.00.1412221543240.4026@localhost.lm.intel.com>
 <54984B10.6060907@fb.com>
 <alpine.LNX.2.00.1412221807560.4026@localhost.lm.intel.com>
 <549860A9.7060106@fb.com> <54987A43.9000807@fb.com>
 <alpine.LNX.2.00.1412222053120.4026@localhost.lm.intel.com>
 <alpine.LNX.2.00.1412222303100.4026@localhost.lm.intel.com>
 <5499AB17.6060805@fb.com> <5499AC69.2010706@fb.com>
 <alpine.LNX.2.00.1412232024530.4026@localhost.lm.intel.com>
 <alpine.LNX.2.00.1412232120410.4026@localhost.lm.intel.com>
 <5499DD9B.4020508@fb.com>
 <alpine.LNX.2.00.1412310215470.4026@localhost.lm.intel.com>
 <54A4268A.6030504@fb.com>
Message-ID: <alpine.LNX.2.00.1501051451440.4026@localhost.lm.intel.com>

On Wed, 31 Dec 2014, Jens Axboe wrote:
> On 12/30/2014 07:31 PM, Keith Busch wrote:
>> Abandon the whole series...  Too many corner cases where this falls
>> to pieces. I'm running high queue-depth IO with random error injection
>> that causes requests to get on lists from ctx->rq_list, hctx->dispatch,
>> and q->requeue_list. No matter what I do from the driver, there is
>> always a case in either reset or removal where a requests get lost and
>> blk_cleanup_queue never completes.
>
> Back to the drawing board, I'll drop the series. Still off from work here, 
> I'll take a look when I get back soon. I'm surprised it's this difficult, we 
> already went through most of this design/test hash out with scsi-mq.
>
> I'll drop this one:
>
> NVMe: Freeze queues on shutdown
>
> but keep this one:
>
> NVMe: Fix double free irq
>
> Agree?

Yep, that sounds good. Sorry I rushed out that last email without much
explanation.

We need the driver to temporarily block tasks allocating new requests but
let existing requests requeue. Freeze looked good, but unfreeze expects
the usage count to have been 0, which it's not guaranteed with when we
let failed requests requeue.

The only reason I need the freeze/unfreeze exports is for the IOCTL path
that submits commands outside the block layer. If I can change all those
usages to be "blk_execute_rq" or something like that, we don't need the
new exports, and can block requests at a different level, but that brings
me to the next issue.

We also need the driver to temporarily prevent the block layer from
submitting requests to the driver's hw queues. 'blk_mq_stop_hw_queues'
looked right, but anyone can restart them at the wrong time by kicking
the requeue list.
