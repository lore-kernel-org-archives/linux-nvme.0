From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Thu, 10 May 2018 15:01:04 +0000
Subject: [PATCH V4 1/7] block: introduce blk_quiesce_timeout() and
 blk_unquiesce_timeout()
In-Reply-To: <20180505135905.18815-2-ming.lei@redhat.com>
References: <20180505135905.18815-1-ming.lei@redhat.com>
 <20180505135905.18815-2-ming.lei@redhat.com>
Message-ID: <4cf98f8d3d763ab3decb5f4bfaee6a4394de5caf.camel@wdc.com>

On Sat, 2018-05-05@21:58 +0800, Ming Lei wrote:
> Turns out the current way can't drain timout completely because mod_timer()
> can be triggered in the work func, which can be just run inside the synced
> timeout work:
> 
>         del_timer_sync(&q->timeout);
>         cancel_work_sync(&q->timeout_work);
> 
> This patch introduces one flag of 'timeout_off' for fixing this issue, turns
> out this simple way does work.
> 
> Also blk_quiesce_timeout() and blk_unquiesce_timeout() are introduced for
> draining timeout, which is needed by NVMe.

Hello Ming,

The description of the above patch does not motivate sufficiently why you think
that this change is necessary. As you know it is already possible to wait until
timeout handling has finished by calling blk_mq_freeze_queue() +
blk_mq_unfreeze_queue(). An explanation is needed of why you think that calling
blk_mq_freeze_queue() + blk_mq_unfreeze_queue() is not sufficient and why you
chose the solution implemented in this patch.

Thanks,

Bart.
