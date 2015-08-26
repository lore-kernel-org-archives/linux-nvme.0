From: pandey.alok@samsung.com (Alok)
Date: Wed, 26 Aug 2015 10:16:33 +0530
Subject: [PATCH V2] NVMe: Using PRACT bit to generate and verify PI by
 controller
In-Reply-To: <alpine.LNX.2.00.1507301956330.15930@localhost.lm.intel.com>
References: <1438094033-2693-1-git-send-email-pandey.alok@samsung.com>
 <alpine.LNX.2.00.1507301956330.15930@localhost.lm.intel.com>
Message-ID: <000001d0dfba$7ad40210$707c0630$@samsung.com>

Can it be picked up.

Thanks,
Alok

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf
Of Keith Busch
Sent: Friday, July 31, 2015 1:30 AM
To: Alok Pandey
Cc: keith.busch at intel.com; linux-nvme at lists.infradead.org
Subject: Re: [PATCH V2] NVMe: Using PRACT bit to generate and verify PI by
controller

On Tue, 28 Jul 2015, Alok Pandey wrote:
> This patch enables the PRCHK and reftag support when PRACT bit is set, 
> and block layer integrity is disabled.

Thanks!

Reviewed-by: Keith Busch <keith.busch at intel.com>

> Signed-off-by: Alok Pandey <pandey.alok at samsung.com>
> ---
> @@ -815,11 +815,10 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq,
struct nvme_iod *iod,
> 	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
> 	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) -

> 1);
>
> -	if (blk_integrity_rq(req)) {
> -		cmnd->rw.metadata =
cpu_to_le64(sg_dma_address(iod->meta_sg));
> +	if (ns->ms) {
> 		switch (ns->pi_type) {
> 		case NVME_NS_DPS_PI_TYPE3:
> -			control |= NVME_RW_PRINFO_PRCHK_GUARD;
> +		control |= NVME_RW_PRINFO_PRCHK_GUARD;
> 			break;

Though the tab change here must have been an accident.

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
