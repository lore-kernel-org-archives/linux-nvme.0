From: parav@mellanox.com (Parav Pandit)
Date: Thu, 12 Jan 2017 22:45:04 +0000
Subject: [PATCH] nvmet-rdma: Fix missing dma sync to nvme data structures
In-Reply-To: <1484260948-3227-1-git-send-email-parav@mellanox.com>
References: <1484260948-3227-1-git-send-email-parav@mellanox.com>
Message-ID: <VI1PR0502MB30082DF2A5D15C0AB8EB7E32D1790@VI1PR0502MB3008.eurprd05.prod.outlook.com>

Missed out Max's review signature. Resending it.

Parav

> -----Original Message-----
> From: Parav Pandit [mailto:parav at mellanox.com]
> Sent: Thursday, January 12, 2017 4:42 PM
> To: hch at lst.de; sagi at grimberg.me; linux-nvme at lists.infradead.org; linux-
> rdma at vger.kernel.org; dledford at redhat.com
> Cc: Parav Pandit <parav at mellanox.com>
> Subject: [PATCH] nvmet-rdma: Fix missing dma sync to nvme data structures
> 
> This patch performs dma sync operations on nvme_commmand, inline
> page(s) and nvme_completion.
> 
> nvme_command and write cmd inline data is synced
> (a) on receiving of the recv queue completion for cpu access.
> (b) before posting recv wqe back to rdma adapter for device access.
> 
> nvme_completion is synced
> (a) on receiving send completion for nvme_completion for cpu access.
> (b) before posting send wqe to rdma adapter for device access.
> 
> Pushing this patch through linux-rdma git tree as its more relavant with Bart's
> changes for dma_map_ops of[1].
> 
> [1] https://patchwork.kernel.org/patch/9514085/
> 
> Signed-off-by: Parav Pandit <parav at mellanox.com>
> ---
>  drivers/nvme/target/rdma.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c index
> 8c3760a..c6468b3 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -438,6 +438,14 @@ static int nvmet_rdma_post_recv(struct
> nvmet_rdma_device *ndev,  {
>  	struct ib_recv_wr *bad_wr;
> 
> +	dma_sync_single_for_device(ndev->device->dma_device,
> +			cmd->sge[0].addr, sizeof(*cmd->nvme_cmd),
> +			DMA_FROM_DEVICE);
> +
> +	if (cmd->sge[1].addr)
> +		dma_sync_single_for_device(ndev->device->dma_device,
> +				cmd->sge[1].addr,
> NVMET_RDMA_INLINE_DATA_SIZE,
> +				DMA_FROM_DEVICE);
>  	if (ndev->srq)
>  		return ib_post_srq_recv(ndev->srq, &cmd->wr, &bad_wr);
>  	return ib_post_recv(cmd->queue->cm_id->qp, &cmd->wr, &bad_wr);
> @@ -507,6 +515,10 @@ static void nvmet_rdma_send_done(struct ib_cq
> *cq, struct ib_wc *wc)
>  	struct nvmet_rdma_rsp *rsp =
>  		container_of(wc->wr_cqe, struct nvmet_rdma_rsp,
> send_cqe);
> 
> +	dma_sync_single_for_cpu(rsp->queue->dev->device->dma_device,
> +			rsp->send_sge.addr, sizeof(*rsp->req.rsp),
> +			DMA_TO_DEVICE);
> +
>  	nvmet_rdma_release_rsp(rsp);
> 
>  	if (unlikely(wc->status != IB_WC_SUCCESS && @@ -538,6 +550,11
> @@ static void nvmet_rdma_queue_response(struct nvmet_req *req)
>  		first_wr = &rsp->send_wr;
> 
>  	nvmet_rdma_post_recv(rsp->queue->dev, rsp->cmd);
> +
> +	dma_sync_single_for_device(rsp->queue->dev->device-
> >dma_device,
> +			rsp->send_sge.addr, sizeof(*rsp->req.rsp),
> +			DMA_TO_DEVICE);
> +
>  	if (ib_post_send(cm_id->qp, first_wr, &bad_wr)) {
>  		pr_err("sending cmd response failed\n");
>  		nvmet_rdma_release_rsp(rsp);
> @@ -698,6 +715,16 @@ static void nvmet_rdma_handle_command(struct
> nvmet_rdma_queue *queue,
>  	cmd->n_rdma = 0;
>  	cmd->req.port = queue->port;
> 
> +	dma_sync_single_for_cpu(queue->dev->device->dma_device,
> +			cmd->cmd->sge[0].addr, sizeof(*cmd->cmd-
> >nvme_cmd),
> +			DMA_FROM_DEVICE);
> +
> +	if (cmd->cmd->sge[1].addr)
> +		dma_sync_single_for_cpu(queue->dev->device-
> >dma_device,
> +				cmd->cmd->sge[1].addr,
> +				NVMET_RDMA_INLINE_DATA_SIZE,
> +				DMA_FROM_DEVICE);
> +
>  	if (!nvmet_req_init(&cmd->req, &queue->nvme_cq,
>  			&queue->nvme_sq, &nvmet_rdma_ops))
>  		return;
> --
> 1.8.3.1
