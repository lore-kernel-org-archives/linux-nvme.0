From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 21 Jun 2018 12:57:43 +0300
Subject: [PATCH 4/7] nvme-rdma: unquiesce queues when deleting the
 controller
In-Reply-To: <20180619123415.25077-5-sagi@grimberg.me>
References: <20180619123415.25077-1-sagi@grimberg.me>
 <20180619123415.25077-5-sagi@grimberg.me>
Message-ID: <d739f7bd-a3ee-4d5a-db88-325d7bfc33f1@mellanox.com>



On 6/19/2018 3:34 PM, Sagi Grimberg wrote:
> If the controller is going away, we need to unquiesce the io
> queues so that all pending request can fail gracefully before
> moving forward with controller deletion.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/rdma.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 15e897ac2506..edf63cd106ff 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1741,10 +1741,12 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
>   		nvme_rdma_destroy_io_queues(ctrl, shutdown);
>   	}
>   
> -	if (shutdown)
> +	if (shutdown) {
> +		nvme_start_queues(&ctrl->ctrl);

any reason we unquiesce IO queues after destroying them and unquiesce 
Admin queue before the destruction ?

>   		nvme_shutdown_ctrl(&ctrl->ctrl);
> -	else
> +	} else {
>   		nvme_disable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
> +	}
>   
>   	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
>   	nvme_rdma_stop_queue(&ctrl->queues[0]);
> 
