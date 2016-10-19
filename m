From: hch@lst.de (Christoph Hellwig)
Date: Wed, 19 Oct 2016 12:39:39 +0200
Subject: [PATCH 5/6] nvme-fabrics: Print network address if address
 resolution fails
In-Reply-To: <020cf76d-b63e-af62-07d0-c41ff51277ec@sandisk.com>
References: <e96f7b21-9686-c24f-9c64-e6fb4b44fea0@sandisk.com>
 <020cf76d-b63e-af62-07d0-c41ff51277ec@sandisk.com>
Message-ID: <20161019103939.GC1191@lst.de>

On Tue, Oct 18, 2016@01:11:28PM -0700, Bart Van Assche wrote:
> Signed-off-by: Bart Van Assche <bart.vanassche at sandisk.com>
> ---
>  drivers/nvme/host/rdma.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 5a83881..9612ea0 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -568,14 +568,16 @@ static int nvme_rdma_init_queue(struct nvme_rdma_ctrl *ctrl,
>  			NVME_RDMA_CONNECT_TIMEOUT_MS);
>  	if (ret) {
>  		dev_info(ctrl->ctrl.device,
> -			"rdma_resolve_addr failed (%d).\n", ret);
> +			 "rdma_resolve_addr(%pISpc) failed (%d).\n",
> +			 &ctrl->addr, ret);
>  		goto out_destroy_cm_id;
>  	}
>  
>  	ret = nvme_rdma_wait_for_cm(queue);
>  	if (ret) {
>  		dev_info(ctrl->ctrl.device,
> -			"rdma_resolve_addr wait failed (%d).\n", ret);
> +			 "rdma_resolve_addr(%pISpc) wait failed (%d).\n",
> +			 &ctrl->addr, ret);

Can you skip the indentation change?  Also once have the address how
about:

		"Failed to resolve %pISpc (instant), error %d).\n"

		"Failed to resolve %pISpc (wait), error %d.\n"
