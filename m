From: hch@lst.de (Christoph Hellwig)
Date: Mon, 16 Jan 2017 16:31:09 +0100
Subject: [PATCH] nvmet-rdma: Fix missing dma sync to nvme data structures
In-Reply-To: <1484412337-10860-1-git-send-email-parav@mellanox.com>
References: <1484412337-10860-1-git-send-email-parav@mellanox.com>
Message-ID: <20170116153109.GA16170@lst.de>

> +++ b/drivers/nvme/target/rdma.c
> @@ -438,6 +438,14 @@ static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
>  {
>  	struct ib_recv_wr *bad_wr;
>  
> +	ib_dma_sync_single_for_device(ndev->device,
> +			cmd->sge[0].addr, sizeof(*cmd->nvme_cmd),
> +			DMA_FROM_DEVICE);
> +
> +	if (cmd->sge[1].addr)

0 can be a valid address returned from dma_map_single on some
architectures. 
