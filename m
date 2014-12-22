From: keith.busch@intel.com (Keith Busch)
Date: Mon, 22 Dec 2014 21:01:22 +0000 (UTC)
Subject: [PATCH 0/4] nvme-blkmq fixes
In-Reply-To: <54987A43.9000807@fb.com>
References: <1419036856-16275-1-git-send-email-keith.busch@intel.com>
 <5495B2BF.8070602@fb.com> <5495CDFE.3060404@fb.com>
 <alpine.LNX.2.00.1412221543240.4026@localhost.lm.intel.com>
 <54984B10.6060907@fb.com>
 <alpine.LNX.2.00.1412221807560.4026@localhost.lm.intel.com>
 <549860A9.7060106@fb.com> <54987A43.9000807@fb.com>
Message-ID: <alpine.LNX.2.00.1412222053120.4026@localhost.lm.intel.com>

On Mon, 22 Dec 2014, Jens Axboe wrote:
> Should be enough to just check for ->rq_pool being initialized or not - if it 
> is, we could have waiters and we know the waitqueues have been setup, etc.
>
> V2 attached.

Yep, that fixes the bug.

I'm not sure I follow your suggestion for forcing bt_get() to abandon
allocating a request tag when the queue is dying. If hctx_may_queue()
fails, it returns a generic error and bt_get() reschedules itself. Should
a different error than -1 be returned if the queue is dying?
