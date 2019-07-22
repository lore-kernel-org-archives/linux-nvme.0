From: bvanassche@acm.org (Bart Van Assche)
Date: Mon, 22 Jul 2019 08:25:07 -0700
Subject: [PATCH 2/5] blk-mq: introduce
 blk_mq_tagset_wait_completed_request()
In-Reply-To: <20190722053954.25423-3-ming.lei@redhat.com>
References: <20190722053954.25423-1-ming.lei@redhat.com>
 <20190722053954.25423-3-ming.lei@redhat.com>
Message-ID: <c2722892-9cbf-0747-58a8-91a99b72bc53@acm.org>

On 7/21/19 10:39 PM, Ming Lei wrote:
> blk-mq may schedule to call queue's complete function on remote CPU via
> IPI, but doesn't provide any way to synchronize the request's complete
> fn.
> 
> In some driver's EH(such as NVMe), hardware queue's resource may be freed &
> re-allocated. If the completed request's complete fn is run finally after the
> hardware queue's resource is released, kernel crash will be triggered.
> 
> Prepare for fixing this kind of issue by introducing
> blk_mq_tagset_wait_completed_request().

An explanation is missing of why the block layer is modified to fix this 
instead of the NVMe driver.

Thanks,

Bart.
