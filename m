From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 17 Oct 2018 13:14:14 -0600
Subject: [PATCH] nvme-pci: remove duplicate check
In-Reply-To: <20181017183415.3373-1-chaitanya.kulkarni@wdc.com>
References: <20181017183415.3373-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20181017191414.GB20375@localhost.localdomain>

On Wed, Oct 17, 2018@11:34:15AM -0700, Chaitanya Kulkarni wrote:
> This is a cleanup patch doesn't change any functionality. It removes
> the duplicate call to the blk_integrity_rq() in the nvme_map_data().
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>

> ---
>  drivers/nvme/host/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 72737009b82d..4e023cd007e1 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -772,10 +772,10 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
>  
>  		if (!dma_map_sg(dev->dev, &iod->meta_sg, 1, dma_dir))
>  			goto out_unmap;
> -	}
>  
> -	if (blk_integrity_rq(req))
>  		cmnd->rw.metadata = cpu_to_le64(sg_dma_address(&iod->meta_sg));
> +	}
> +
>  	return BLK_STS_OK;
>  
>  out_unmap:
> -- 
