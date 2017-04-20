From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 20 Apr 2017 14:24:15 +0300
Subject: [PATCH v2 1/4] IB/core: Add inline function to get sg mr type
In-Reply-To: <1492098977-5231-2-git-send-email-maxg@mellanox.com>
References: <1492098977-5231-1-git-send-email-maxg@mellanox.com>
 <1492098977-5231-2-git-send-email-maxg@mellanox.com>
Message-ID: <37f3dbe9-77af-181c-0c5d-c35be0f13fa0@grimberg.me>


> +/**
> + * ib_get_sg_mr_type() - check if the device support arbitrary
> + *                       sg mapping and return a suitable mr type.
> + * @device: The device on which to check support.
> + *
> + * Return: IB_MR_TYPE_SG_GAPS if the device support.
> + *         Otherwise, return IB_MR_TYPE_MEM_REG.
> + */
> +static inline enum ib_mr_type ib_get_sg_mr_type(struct ib_device *device)
> +{
> +	if (device->attrs.device_cap_flags & IB_DEVICE_SG_GAPS_REG)
> +		return IB_MR_TYPE_SG_GAPS;
> +	else
> +		return IB_MR_TYPE_MEM_REG;
> +
> +}
> +

It does eliminate some code duplication, but will everyone prefer
the GAPS type? I guess they can just not use it, maybe the naming
should reflect that GAPS is preferred? (it doesn't come for free
as the device might need more resources to support GAPS)

Not sure...
