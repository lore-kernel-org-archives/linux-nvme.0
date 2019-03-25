From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 25 Mar 2019 05:23:17 +0000
Subject: [PATCH 09/15] nvme-pci: only call nvme_unmap_data for requests
 transferring data
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-10-hch@lst.de>
Message-ID: <SN6PR04MB45270446075043E2A7079A76865E0@SN6PR04MB4527.namprd04.prod.outlook.com>

On 3/21/19 4:11 PM, Christoph Hellwig wrote:
> This mirrors how nvme_map_pci is called and will allow simplifying some
> checks in nvme_unmap_pci later on.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/pci.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index ce8bdc15ec3c..bc4ee869fe82 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -929,7 +929,8 @@ static void nvme_pci_complete_rq(struct request *req)
>   	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>   
>   	nvme_cleanup_cmd(req);
> -	nvme_unmap_data(iod->nvmeq->dev, req);
> +	if (blk_rq_nr_phys_segments(req))
> +		nvme_unmap_data(iod->nvmeq->dev, req);
>   	nvme_complete_rq(req);
>   }
>   
> 

Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
