From: bvanassche@acm.org (Bart Van Assche)
Date: Sun, 17 Mar 2019 21:09:09 -0700
Subject: [PATCH 1/2] blk-mq: introduce blk_mq_complete_request_sync()
In-Reply-To: <20190318032950.17770-2-ming.lei@redhat.com>
References: <20190318032950.17770-1-ming.lei@redhat.com>
 <20190318032950.17770-2-ming.lei@redhat.com>
Message-ID: <f708ee0c-dfa4-0bca-f996-8d834471f1fd@acm.org>

On 3/17/19 8:29 PM, Ming Lei wrote:
> In NVMe's error handler, follows the typical steps for tearing down
> hardware:
> 
> 1) stop blk_mq hw queues
> 2) stop the real hw queues
> 3) cancel in-flight requests via
> 	blk_mq_tagset_busy_iter(tags, cancel_request, ...)
> cancel_request():
> 	mark the request as abort
> 	blk_mq_complete_request(req);
> 4) destroy real hw queues
> 
> However, there may be race between #3 and #4, because blk_mq_complete_request()
> actually completes the request asynchronously.
> 
> This patch introduces blk_mq_complete_request_sync() for fixing the
> above race.

Other block drivers wait until outstanding requests have completed by 
calling blk_cleanup_queue() before hardware queues are destroyed. Why 
can't the NVMe driver follow that approach?

Thanks,

Bart.
