From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 25 Mar 2019 05:21:02 +0000
Subject: [PATCH 07/15] nvme-pci: move the call to nvme_cleanup_cmd out of
 nvme_unmap_data
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-8-hch@lst.de>
Message-ID: <SN6PR04MB45271823D8B8FAF177224155865E0@SN6PR04MB4527.namprd04.prod.outlook.com>

On 3/21/19 4:11 PM, Christoph Hellwig wrote:
> Cleaning up the command setup isn't related to unmapping data, and
> disentangling them will simplify error handling a bit down the road.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 3f06e942fb47..2fb35d44010a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -888,7 +888,6 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
>   			dma_unmap_sg(dev->dev, &iod->meta_sg, 1, dma_dir);
>   	}
>   
> -	nvme_cleanup_cmd(req);
>   	nvme_free_iod(dev, req);
>   }
>   
> @@ -939,6 +938,7 @@ static void nvme_pci_complete_rq(struct request *req)
>   {
>   	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>   
> +	nvme_cleanup_cmd(req);
>   	nvme_unmap_data(iod->nvmeq->dev, req);
>   	nvme_complete_rq(req);
>   }
> 

Also it is much easier to debug now that it is separated.

Looks good.

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
