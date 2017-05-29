From: hch@lst.de (Christoph Hellwig)
Date: Mon, 29 May 2017 19:54:21 +0200
Subject: [PATCH v2 1/2] nvme: Adding support for FW Slot info log
In-Reply-To: <1496067458-26190-1-git-send-email-a.dawn@samsung.com>
References: <1496067391-26143-1-git-send-email-a.dawn@samsung.com>
 <CGME20170529141731epcas5p39667840c01555c7cf49527167535f82c@epcas5p3.samsung.com>
 <1496067458-26190-1-git-send-email-a.dawn@samsung.com>
Message-ID: <20170529175421.GA25061@lst.de>

On Mon, May 29, 2017@07:47:38PM +0530, Arnav Dawn wrote:
> +int nvme_get_log_page(struct nvme_ctrl *dev, int log_type, void *log)
>  {
>  	struct nvme_command c = { };
> +	int log_size;
>  
> +	if (!log)
> +		return -EINVAL;
>  
> +	c.common.opcode = nvme_admin_get_log_page;
>  
> +	switch (log_type) {
> +	case NVME_LOG_SMART:
> +		log_size = sizeof(struct nvme_smart_log);
> +		c.common.nsid = cpu_to_le32(0xFFFFFFFF);
> +		c.common.cdw10[0] = cpu_to_le32(
> +			(((log_size / 4) - 1) << 16) | NVME_LOG_SMART);
> +		break;
> +	case NVME_LOG_FW_SLOT:
> +		log_size = sizeof(struct nvme_fw_slot_info_log);
> +		c.common.nsid = cpu_to_le32(0xFFFFFFFF);
> +		c.common.cdw10[0] = cpu_to_le32(
> +			(((log_size / 4) - 1) << 16) | NVME_LOG_FW_SLOT);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return nvme_submit_sync_cmd(dev->admin_q, &c, log, log_size);

This functioin has basically no common code.  I think the current
nvme_get_log_page should be renamed to nvme_get_smart_log and moved
to scsi.c, and you'll just add a new helper for your log page or
even just open code it in the caller.  A little inline helper for
setting up dword10 would be nice, though.
