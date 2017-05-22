From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 22 May 2017 09:41:57 +0200
Subject: [PATCH v2 1/3] nvme: use blk_mq_start_hw_queues() in
 nvme_kill_queues()
In-Reply-To: <20170520035605.21785-2-ming.lei@redhat.com>
References: <20170520035605.21785-1-ming.lei@redhat.com>
 <20170520035605.21785-2-ming.lei@redhat.com>
Message-ID: <459b4b5f-fe3d-6013-27ff-acfe4de2792e@suse.de>

On 05/20/2017 05:56 AM, Ming Lei wrote:
> Inside nvme_kill_queues(), we have to start hw queues for
> draining requests in sw queues, .dispatch list and requeue list,
> so use blk_mq_start_hw_queues() instead of blk_mq_start_stopped_hw_queues()
> which only run queues if queues are stopped, but the queues may have
> been started already, for example nvme_start_queues() is called in reset work
> function.
> 
> blk_mq_start_hw_queues() run hw queues in current context, instead
> of running asynchronously like before. Given nvme_kill_queues() is
> run from either remove context or reset worker context, both are fine
> to run hw queue directly. And the mutex of namespaces_mutex isn't a
> problem too becasue nvme_start_freeze() runs hw queue in this way
> already.
> 
> Cc: stable at vger.kernel.org
> Reported-by: Zhang Yi <yizhan at redhat.com>
> Signed-off-by: Ming Lei <ming.lei at redhat.com>
> ---


Looks good,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>


-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
