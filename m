From: Stephen.Bates@pmcs.com (Stephen Bates)
Date: Wed, 1 Jul 2015 08:10:36 +0000
Subject: [PATCHv2 2/2] NVMe: Use CMB for the SQ if available
In-Reply-To: <1435098787-13083-3-git-send-email-jonathan.derrick@intel.com>
References: <1435098787-13083-1-git-send-email-jonathan.derrick@intel.com>
 <1435098787-13083-3-git-send-email-jonathan.derrick@intel.com>
Message-ID: <36F6EBABA23FEF4391AF72944D228901EB289031@BBYEXM02.pmc-sierra.internal>

Hi Jon

Thanks for starting the work on this.

> +static void nvme_alloc_sq_cmds(struct nvme_dev *dev, struct
> nvme_queue *nvmeq,
> +				int qid, int depth)
> +{
> +	if (qid && NVME_CMB_SQS(dev->cmbsz) && dev->cmb) {
> +		unsigned offset = (qid - 1) *
> +					roundup(SQ_SIZE(depth), dev-
> >page_size);
> +		nvmeq->cmb_mapped = true;

This seems a little backwards to me in the sense that if the drive advertises CMB with SQ support the host is forced into using the CMB for SQs. Surely the host should have some ability to over-ride what the drive says? At the very least an argument into the  module to ignore CMB capabilities seems appropriate. Ultimately it would be good to have the host have the ability to use its preference when a device is reset. Or am I missing something?

Aside from this the patch looks good to me.

Stephen
