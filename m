From: sbradshaw@micron.com (Sam Bradshaw (sbradshaw))
Date: Mon, 16 Feb 2015 18:53:22 +0000
Subject: [PATCH] NVMe: Metadata and PI format support
In-Reply-To: <1422670317-23420-1-git-send-email-keith.busch@intel.com>
References: <1422670317-23420-1-git-send-email-keith.busch@intel.com>
Message-ID: <80B89753B40C5141A3E2D53FE7A2A8A99979435A@NTXBOIMBX02.micron.com>


> +/**
> + * nvme_dif_remap - remaps ref tags to bip seed and physical lba
> + *
> + * The virtual start sector is the one that was originally submitted
> by
> +the
> + * block layer. Due to partitioning, MD/DM cloning, etc. the actual
> +physical
> + * start sector may be different. Remap protection information to
> match
> +the
> + * physical LBA on writes, and back to the original seed on reads.
> + *
> + * Type 0 and 3 do not have a ref tag, so no remapping required.
> + */
> +static void nvme_dif_remap(struct request *req,
> +			void (*dif_swap)(u32 p, u32 v, struct t10_pi_tuple
> *pi)) {
> +	struct nvme_ns *ns = req->rq_disk->private_data;
> +	struct bio_integrity_payload *bip;
> +	struct t10_pi_tuple *pi;
> +	void *p;
> +	u32 i, nlb, ts, phys, virt;
> +
> +	if (!ns->pi_type || ns->pi_type == NVME_NS_DPS_PI_TYPE3)
> +		return;
> +
> +	bip = bio_integrity(req->bio);
> +	if (!bip)
> +		return;
> +
> +	p = kmap_atomic(bip->bip_vec->bv_page);

I think you want:
p = kmap_atomic(bip->bip_vec->bv_page) + bip->bip_vec->bv_offset;


> @@ -1840,16 +1997,50 @@ static int nvme_revalidate_disk(struct gendisk
> *disk)
>  								__func__);
>  		return 0;
>  	}
> +	if (nvme_identify(dev, ns->ns_id, 0, dma_addr)) {
> +		dev_warn(&dev->pci_dev->dev,
> +			"identify failed ns:%d, setting capacity to 0\n",
> +			ns->ns_id);
> +		memset(id, 0, sizeof(*id));
> +	}
> 
> -	if (nvme_identify(dev, ns->ns_id, 0, dma_addr))
> -		goto free;
> -
> -	lbaf = id->flbas & 0xf;
> +	old_ms = ns->ms;
> +	lbaf = id->flbas & NVME_NS_FLBAS_LBA_MASK;
>  	ns->lba_shift = id->lbaf[lbaf].ds;
> +	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
> +
> +	/*
> +	 * If identify namespace failed, use default 512 byte block size
> so
> +	 * block layer can use before failing read/write for 0 capacity.
> +	 */
> +	if (ns->lba_shift == 0)
> +		ns->lba_shift = 9;
> +	bs = 1 << ns->lba_shift;
> +
> +	/* XXX: PI implementation requires metadata equal t10 pi tuple
> size */
> +	pi_type = ns->ms == sizeof(struct t10_pi_tuple) ?
> +					id->dps & NVME_NS_DPS_PI_MASK : 0;

If there is interest in incorporating this support, we can provide
a patch on top of this that enables 16b/32b/64b metadata with PI and
supports PIL={0,1}

-Sam
