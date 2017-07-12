From: hch@lst.de (Christoph Hellwig)
Date: Wed, 12 Jul 2017 09:34:21 +0200
Subject: [PATCH v5 1/1] nvme: Add support for FW activation without reset
In-Reply-To: <1499780912-10253-1-git-send-email-a.dawn@samsung.com>
References: <1499780675-9869-1-git-send-email-a.dawn@samsung.com>
 <CGME20170711134755epcas1p1d699b8c70dab6fcde72ea92d03f76079@epcas1p1.samsung.com>
 <1499780912-10253-1-git-send-email-a.dawn@samsung.com>
Message-ID: <20170712073421.GA6469@lst.de>

>  }
>  
> +
> +static bool nvme_ctrl_pp_status(struct nvme_ctrl *ctrl)

This adds a duplicate empty line.

> +{
> +
> +	u32 csts;
> +
> +	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts))
> +		return false;
> +
> +	if (csts == ~0)
> +		return false;
> +
> +	return ((ctrl->ctrl_config & NVME_CC_ENABLE)
> +			&& (csts & NVME_CSTS_PP));

These should be on one line, and if if they weren't the "&&" placement
is wrong.

> +}

> +static __le32 nvme_get_log_dw10(u8 lid, int size)
> +{
> +	return cpu_to_le32((((size / 4) - 1) << 16) | lid);
> +}

Can you move this up the file a bit so that it's not hidden inside
the FW activation bits.  Also size should be of type size_t.

> +	c.common.nsid = cpu_to_le32(0xFFFFFFFF);

Except for one weird spot we use lower-cases hex numbers.  But in
the longer run we really should have an NVME_NSID_ALL define for this
constant..

Otherwise this looks fine to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>
