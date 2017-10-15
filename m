From: nitzanc@mellanox.com (Nitzan Carmi)
Date: Sun, 15 Oct 2017 11:05:50 +0300
Subject: [PATCH 6/7] nvme-rdma: teardown admin/io queues once on error
 recovery
In-Reply-To: <1507724952-13917-7-git-send-email-sagi@grimberg.me>
References: <1507724952-13917-1-git-send-email-sagi@grimberg.me>
 <1507724952-13917-7-git-send-email-sagi@grimberg.me>
Message-ID: <cee6d667-af6c-71c4-e996-96f907e8ef29@mellanox.com>



On 11/10/2017 15:29, Sagi Grimberg wrote:
> Relying on the queue state while tearing down on every reconnect
> attempt is not a good design. We should do it once in err_work
> and simply try to establish the queues for each reconnect attempt.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/rdma.c | 27 ++++++++++++---------------
>   1 file changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index e3fe57011fcb..2a18465bf361 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -925,10 +925,6 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
>   
>   	++ctrl->ctrl.nr_reconnects;
>   
> -	if (ctrl->ctrl.queue_count > 1)
> -		nvme_rdma_destroy_io_queues(ctrl, false);
> -
> -	nvme_rdma_destroy_admin_queue(ctrl, false);
>   	ret = nvme_rdma_configure_admin_queue(ctrl, false);
>   	if (ret)
>   		goto requeue;
> @@ -936,7 +932,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
>   	if (ctrl->ctrl.queue_count > 1) {
>   		ret = nvme_rdma_configure_io_queues(ctrl, false);
>   		if (ret)
> -			goto requeue;
> +			goto destroy_admin;
>   	}
>   
>   	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
> @@ -946,14 +942,17 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
>   		return;
>   	}
>   
> -	ctrl->ctrl.nr_reconnects = 0;
> -
>   	nvme_start_ctrl(&ctrl->ctrl);
>   
> -	dev_info(ctrl->ctrl.device, "Successfully reconnected\n");
> +	dev_info(ctrl->ctrl.device, "Successfully reconnected (%d attepmpt)\n",
typo :)
> +			ctrl->ctrl.nr_reconnects);
> +
> +	ctrl->ctrl.nr_reconnects = 0;
>   
>   	return;
>   
> +destroy_admin:
> +	nvme_rdma_destroy_admin_queue(ctrl, false);
>   requeue:
>   	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
>   			ctrl->ctrl.nr_reconnects);
> @@ -969,17 +968,15 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
>   
>   	if (ctrl->ctrl.queue_count > 1) {
>   		nvme_stop_queues(&ctrl->ctrl);
> -		nvme_rdma_stop_io_queues(ctrl);
> -	}
> -	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
> -	nvme_rdma_stop_queue(&ctrl->queues[0]);
> -
> -	/* We must take care of fastfail/requeue all our inflight requests */
> -	if (ctrl->ctrl.queue_count > 1)
>   		blk_mq_tagset_busy_iter(&ctrl->tag_set,
>   					nvme_cancel_request, &ctrl->ctrl);
> +		nvme_rdma_destroy_io_queues(ctrl, false);
> +	}
> +
> +	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
>   	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
>   				nvme_cancel_request, &ctrl->ctrl);
> +	nvme_rdma_destroy_admin_queue(ctrl, false);
>   
>   	/*
>   	 * queues are not a live anymore, so restart the queues to fail fast
