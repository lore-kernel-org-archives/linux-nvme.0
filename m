From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 25 Mar 2019 05:14:07 +0000
Subject: [PATCH 05/15] nvme-pci: remove the unused iod->length field
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-6-hch@lst.de>
Message-ID: <SN6PR04MB4527CC0DD3A5963262C31F6A865E0@SN6PR04MB4527.namprd04.prod.outlook.com>

On 3/21/19 4:11 PM, Christoph Hellwig wrote:
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/pci.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index a90cf5d63aac..bf0d71fe243e 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -220,7 +220,6 @@ struct nvme_iod {
>   	int aborted;
>   	int npages;		/* In the PRP list. 0 means small pool in use */
>   	int nents;		/* Used in scatterlist */
> -	int length;		/* Of data, in bytes */
>   	dma_addr_t first_dma;
>   	struct scatterlist meta_sg; /* metadata requires single contiguous buffer */
>   	struct scatterlist *sg;
> @@ -603,7 +602,6 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
>   	iod->aborted = 0;
>   	iod->npages = -1;
>   	iod->nents = 0;
> -	iod->length = size;
>   
>   	return BLK_STS_OK;
>   }
> 

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
