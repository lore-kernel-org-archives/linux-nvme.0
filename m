From: ming.lei@redhat.com (Ming Lei)
Date: Tue, 4 Jul 2017 16:15:42 +0800
Subject: [PATCH 1/8] nvme-rdma: quiesce/unquiesce admin_q instead of
 start/stop its hw queues
In-Reply-To: <1499154912-10420-2-git-send-email-sagi@grimberg.me>
References: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
 <1499154912-10420-2-git-send-email-sagi@grimberg.me>
Message-ID: <20170704081541.GC29053@ming.t460p>

On Tue, Jul 04, 2017@10:55:05AM +0300, Sagi Grimberg wrote:
> unlike blk_mq_stop_hw_queues and blk_mq_start_stopped_hw_queues
> quiescing/unquiescing respects the submission path rcu grace.
> Also make sure to kick the requeue list when appropriate.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/nvme/host/rdma.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index cfb22531fc16..cec2c89cc8da 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -778,7 +778,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
>  
>  	if (ctrl->ctrl.queue_count > 1)
>  		nvme_stop_queues(&ctrl->ctrl);
> -	blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
> +	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
>  
>  	/* We must take care of fastfail/requeue all our inflight requests */
>  	if (ctrl->ctrl.queue_count > 1)
> @@ -791,7 +791,8 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
>  	 * queues are not a live anymore, so restart the queues to fail fast
>  	 * new IO
>  	 */
> -	blk_mq_start_stopped_hw_queues(ctrl->ctrl.admin_q, true);
> +	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
> +	blk_mq_kick_requeue_list(ctrl->ctrl.admin_q);

Now the queue won't be stopped via blk_mq_quiesce_queue(), so why do
you add blk_mq_kick_requeue_list() here?


Thanks,
Ming
