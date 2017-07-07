From: hch@lst.de (Christoph Hellwig)
Date: Fri, 7 Jul 2017 16:22:45 +0200
Subject: [PATCH v4 1/1] nvme: Add support for FW activation without reset
In-Reply-To: <1499427767-15891-1-git-send-email-a.dawn@samsung.com>
References: <1499427704-15785-1-git-send-email-a.dawn@samsung.com>
 <CGME20170707114212epcas5p20d9752501fcfb6a06c460c25a593b0e6@epcas5p2.samsung.com>
 <1499427767-15891-1-git-send-email-a.dawn@samsung.com>
Message-ID: <20170707142245.GA10818@lst.de>

Hi Arnav,

this looks mostly good to me, but a few style nitpicks below:

> +static int nvme_get_fw_slot_info(struct nvme_ctrl *dev,
> +				struct nvme_fw_slot_info_log *log)
> +{
> +	struct nvme_command c = { };
> +
> +	c.common.opcode = nvme_admin_get_log_page;
> +	c.common.nsid = cpu_to_le32(0xFFFFFFFF);
> +	c.common.cdw10[0] = cpu_to_le32(
> +		(((sizeof(struct nvme_fw_slot_info_log) / 4) - 1) << 16)
> +		| NVME_LOG_FW_SLOT);

In Linux we always try to place the operations at the end of previous
line, e.g. in this case:

	(((sizeof(struct nvme_fw_slot_info_log) / 4) - 1) << 16) |
		NVME_LOG_FW_SLOT);

Thay being said I think a little helper for this calculation would
be even better, e.g.:

static __le32 nvme_get_log_dw10(u8 lid, size_t len)
{
	return cpu_to_le32(lid | ((size / 4) - 1) << 16);
}

...

	c.common.cdw10[0] = nvme_get_log_dw10(NVME_LOG_FW_SLOT, sizeof(*log));


> +	/* read FW slot informationi to clear the AER*/
> +	log = kmalloc(sizeof(struct nvme_fw_slot_info_log), GFP_KERNEL);
> +	if (!log)
> +		return;
> +
> +	if (nvme_get_fw_slot_info(ctrl, log))
> +		dev_warn(ctrl->device,
> +				"Get FW SLOT INFO log error\n");
> +	kfree(log);

Please move the allocation and freeing of log into nvme_get_fw_slot_info.
Maybe the warning as well.

> +static inline bool nvme_ctrl_pp_status(struct nvme_ctrl *ctrl)

I don't think this should be inline, as it's not performane critical,
please move it to core.c.

> +	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CC,
> +				&ctrl->ctrl_config))

	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CC, &ctrl->ctrl_config))

> +	return  ((ctrl->ctrl_config & NVME_CC_ENABLE)
> +			&& (csts & NVME_CSTS_PP));

	return ((ctrl->ctrl_config & NVME_CC_ENABLE) && (csts & NVME_CSTS_PP));
