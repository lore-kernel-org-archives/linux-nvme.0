From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 23 Jan 2018 15:09:40 +0200
Subject: [PATCH 2/5] nvme: Ending failed unstarted requests
In-Reply-To: <20180122215630.13697-2-keith.busch@intel.com>
References: <20180122215630.13697-1-keith.busch@intel.com>
 <20180122215630.13697-2-keith.busch@intel.com>
Message-ID: <9ef17f8b-d01d-74ef-32a5-e77f5dd669fd@grimberg.me>


> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 71070eedb773..e51a84d1d732 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -966,11 +966,9 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
>   	nvme_rdma_destroy_admin_queue(ctrl, false);
>   
>   	/*
> -	 * queues are not a live anymore, so restart the queues to fail fast
> -	 * new IO
> +	 * queues are not a live anymore, so end all unstarted requests.
>   	 */
> -	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
> -	nvme_start_queues(&ctrl->ctrl);
> +	nvme_end_requests(&ctrl->ctrl);
>   
>   	nvme_rdma_reconnect_or_remove(ctrl);
>   }
> @@ -1730,7 +1728,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
>   
>   	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
>   	nvme_cancel_admin_requests(&ctrl->ctrl);
> -	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
> +	nvme_end_admin_requests(&ctrl->ctrl);
>   	nvme_rdma_destroy_admin_queue(ctrl, shutdown);
>   }

I think we need to end_io_requests a little above as well.
