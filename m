From: keith.busch@intel.com (Keith Busch)
Date: Tue, 23 Dec 2014 01:34:32 +0000 (UTC)
Subject: [PATCH 0/4] nvme-blkmq fixes
In-Reply-To: <alpine.LNX.2.00.1412222053120.4026@localhost.lm.intel.com>
References: <1419036856-16275-1-git-send-email-keith.busch@intel.com>
 <5495B2BF.8070602@fb.com> <5495CDFE.3060404@fb.com>
 <alpine.LNX.2.00.1412221543240.4026@localhost.lm.intel.com>
 <54984B10.6060907@fb.com>
 <alpine.LNX.2.00.1412221807560.4026@localhost.lm.intel.com>
 <549860A9.7060106@fb.com> <54987A43.9000807@fb.com>
 <alpine.LNX.2.00.1412222053120.4026@localhost.lm.intel.com>
Message-ID: <alpine.LNX.2.00.1412222303100.4026@localhost.lm.intel.com>

On Mon, 22 Dec 2014, Keith Busch wrote:
> On Mon, 22 Dec 2014, Jens Axboe wrote:
>> Should be enough to just check for ->rq_pool being initialized or not - if 
>> it is, we could have waiters and we know the waitqueues have been setup, 
>> etc.
>> 
>> V2 attached.
>
> Yep, that fixes the bug.
>
> I'm not sure I follow your suggestion for forcing bt_get() to abandon
> allocating a request tag when the queue is dying. If hctx_may_queue()
> fails, it returns a generic error and bt_get() reschedules itself. Should
> a different error than -1 be returned if the queue is dying?

We're making good incremental improvements, but finding oddities the
more I test this. This one's a doozy.

Requeued IO's are automatically dispatched, and I don't see an immediately
available way stop them. It causes a bug because the queue doorbells are
unmapped during reset, so you can't touch them when the queue should be
quiesced. I could fix that by having the driver not kick the requeue_list
when it knows a reset is in progress, but there's no immediate way
to drain the list if the reset fails and the device requires removal,
and blk_cleanup_queue() will be stuck.

Is there something available to call that I'm missing or do I need to
add more removal handling?
