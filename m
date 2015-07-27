From: keith.busch@intel.com (Keith Busch)
Date: Mon, 27 Jul 2015 14:41:35 +0000 (UTC)
Subject: [PATCH] nvme: Using PRACT bit to generate and verify PI by
 controller
In-Reply-To: <1437999794-31257-1-git-send-email-pandey.alok@samsung.com>
References: <1437999794-31257-1-git-send-email-pandey.alok@samsung.com>
Message-ID: <alpine.LNX.2.00.1507271420450.15930@localhost.lm.intel.com>

On Mon, 27 Jul 2015, Alok Pandey wrote:
> With the attached patch, I tested the nvme driver to make it work with PRACT = 1
>
> The patch considers if device is formatted with metadata support and CONFIG_BLK_DEV_INTEGRITY is disabled.
> The Host needs to
> a) set the PRACT bit to 1
> a) Provides the relevant PRCHK bits set for the supported PI type
> b) If CONFIG_BLK_DEV_INTEGRITY is not set then always set the device actual capacity (not zero).

Thanks for the patch.

> -	if (blk_integrity_rq(req)) {
> +	if (blk_integrity_rq(req))
> 		cmnd->rw.metadata = cpu_to_le64(sg_dma_address(iod->meta_sg));
> +	else if (ns->ms)
> +		control |= NVME_RW_PRINFO_PRACT;
> +
> +	if (ns->ms) {
> 		switch (ns->pi_type) {
> 		case NVME_NS_DPS_PI_TYPE3:
> 			control |= NVME_RW_PRINFO_PRCHK_GUARD;
> @@ -827,10 +831,8 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
> 					NVME_RW_PRINFO_PRCHK_REF;
> 			cmnd->rw.reftag = cpu_to_le32(
> 					nvme_block_nr(ns, blk_rq_pos(req)));
> -			break;
> 		}
> -	} else if (ns->ms)
> -		control |= NVME_RW_PRINFO_PRACT;
> +	}

This is turning on PRCHK and REFTAG with PRACT, and that's good. We can
simplify the branching a bit by moving the meta-data and PRACT settings
into the 'if (ns->ms)':

 	if (ns->ms) {
 		switch (ns->pi_type) {
 			...
 		}
 		if (blk_integrity_rq(req)
 	 		cmnd->rw.metadata = cpu_to_le64(sg_dma_address(iod->meta_sg));
 		else
 			control |= NVME_RW_PRINFO_PRACT;
 	}

> +#ifdef CONFIG_BLK_DEV_INTEGRITY
> 	if (ns->ms && !blk_get_integrity(disk))
> 		set_capacity(disk, 0);
> 	else
> +#endif

This would give a non-zero capacity on formats where PRACT is ignored
which we shouldn't do.  Instead of depending on the kernel config,
the capacity should be set to 0 based on the namespace's ability to use
PRACT. This check should be similar as the one in nvme_queue_rq, like:

 	if (ns->ms && !(ns->ms == 8 && ns->pi_type) && !blk_get_integrity(disk))
 		set_capacity(disk, 0);
