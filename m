From: keith.busch@intel.com (Keith Busch)
Date: Tue, 23 Dec 2014 21:23:41 +0000 (UTC)
Subject: [PATCH 0/4] nvme-blkmq fixes
In-Reply-To: <alpine.LNX.2.00.1412232024530.4026@localhost.lm.intel.com>
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
Message-ID: <alpine.LNX.2.00.1412232120410.4026@localhost.lm.intel.com>

On Tue, 23 Dec 2014, Keith Busch wrote:
> @@ -432,7 +432,8 @@ static void req_completion(struct nvme_queue *nvmeq, void 
> *ctx,
> 		if (!(status & NVME_SC_DNR || blk_noretry_request(req))
> 		    && (jiffies - req->start_time) < req->timeout) {
> 			blk_mq_requeue_request(req);
> -			blk_mq_kick_requeue_list(req->q);
> +			if (!blk_queue_stopped(req->q))
> +				blk_mq_kick_requeue_list(req->q);
> 			return;
> 		}

Oops, experimenting with different things, took the wrong snapshot of
the patch. Should be:

+			if (nvmeq->cq_vector != -1)

rather than:

+			if (!blk_queue_stopped(req->q))

Anyway, I'm going to keep messing with this until I can either hit the
other failures I mentioned or convince myself it's safe before sending
something for official consideration.
