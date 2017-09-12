From: james.smart@broadcom.com (James Smart)
Date: Tue, 12 Sep 2017 08:48:58 -0700
Subject: [PATCH 02/10] RDMA timeout triggers failover.
In-Reply-To: <20170912042226.bwdalyhvqd5xc24n@haynes>
References: <20170912042226.bwdalyhvqd5xc24n@haynes>
Message-ID: <970e4fc8-398a-c42f-6a1e-67a8955b371b@broadcom.com>

I don't know this is a good idea - just because there's a controller 
reset we need to failover a path ? Also putting failover smarts in the 
transport doesn't seem like a great idea. Also, there's more than just 
an rdma transport....

-- james



On 9/11/2017 9:22 PM, Anish M Jhaveri wrote:
> Trigger failover functionality will be called on any RDMA timeout. This timeout can occur due failure for an IO to be returned from Target. This could be caused due to interface going down while leads to failover functionality being triggered.
>
> Signed-off-by: Anish M Jhaveri <anish.jhaveri at paviliondata.com>
> ---
>   drivers/nvme/host/rdma.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index a03299d..cb6a5f8 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -174,6 +174,7 @@ static void nvme_rdma_free_qe(struct ib_device *ibdev, struct nvme_rdma_qe *qe,
>   {
>   	ib_dma_unmap_single(ibdev, qe->dma, capsule_size, dir);
>   	kfree(qe->data);
> +	qe->data = NULL;
>   }
>   
>   static int nvme_rdma_alloc_qe(struct ib_device *ibdev, struct nvme_rdma_qe *qe,
> @@ -766,6 +767,8 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
>   
>   	nvme_stop_ctrl(&ctrl->ctrl);
>   
> +	nvme_trigger_failover(&ctrl->ctrl);
> +
>   	for (i = 0; i < ctrl->ctrl.queue_count; i++)
>   		clear_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[i].flags);
>   
