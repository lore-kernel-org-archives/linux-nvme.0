From: kbusch@kernel.org (Keith Busch)
Date: Mon, 18 Mar 2019 08:40:42 -0600
Subject: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
In-Reply-To: <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
 <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>
Message-ID: <20190318144042.GA23473@localhost.localdomain>

On Sun, Mar 17, 2019@09:09:09PM -0700, Bart Van Assche wrote:
> On 3/17/19 8:29 PM, Ming Lei wrote:
> > In NVMe's error handler, follows the typical steps for tearing down
> > hardware:
> > 
> > 1) stop blk_mq hw queues
> > 2) stop the real hw queues
> > 3) cancel in-flight requests via
> > 	blk_mq_tagset_busy_iter(tags, cancel_request, ...)
> > cancel_request():
> > 	mark the request as abort
> > 	blk_mq_complete_request(req);
> > 4) destroy real hw queues
> > 
> > However, there may be race between #3 and #4, because blk_mq_complete_request()
> > actually completes the request asynchronously.
> > 
> > This patch introduces blk_mq_complete_request_sync() for fixing the
> > above race.
> 
> Other block drivers wait until outstanding requests have completed by
> calling blk_cleanup_queue() before hardware queues are destroyed. Why can't
> the NVMe driver follow that approach?

You can't just wait for an outstanding request indefinitely. We have to
safely make forward progress when we've determined it's not going to be
completed.
