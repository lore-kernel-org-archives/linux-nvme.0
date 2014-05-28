From: vishal.l.verma@linux.intel.com (Vishal Verma)
Date: Wed, 28 May 2014 10:40:28 -0600
Subject: [PATCH] Fix log page buffer size passed in GetLogPage(CDW10.NUMD).
In-Reply-To: <1401281903-25143-1-git-send-email-indraneel.m@samsung.com>
References: <1401281903-25143-1-git-send-email-indraneel.m@samsung.com>
Message-ID: <1401295228.13425.8.camel@omniknight.lm.intel.com>

On Wed, 2014-05-28@18:28 +0530, Indraneel Mukherjee wrote:
> diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
> index da3b252..0d9805b 100644
> --- a/drivers/block/nvme-scsi.c
> +++ b/drivers/block/nvme-scsi.c
> @@ -1014,8 +1014,8 @@ static int nvme_trans_log_info_exceptions(struct nvme_ns *ns,
>  	c.common.opcode = nvme_admin_get_log_page;
>  	c.common.nsid = cpu_to_le32(0xFFFFFFFF);
>  	c.common.prp1 = cpu_to_le64(dma_addr);
> -	c.common.cdw10[0] = cpu_to_le32(((sizeof(struct nvme_smart_log) /
> -			BYTES_TO_DWORDS) << 16) | NVME_GET_SMART_LOG_PAGE);
> +	c.common.cdw10[0] = cpu_to_le32((((sizeof(struct nvme_smart_log) /
> +			BYTES_TO_DWORDS)-1) << 16) | NVME_GET_SMART_LOG_PAGE);

Documentation/CodingStyle says both these changes should read ") - 1)"
instead of ")-1)" (spacing difference).

>  	res = nvme_submit_admin_cmd(dev, &c, NULL);
>  	if (res != NVME_SC_SUCCESS) {
>  		temp_c = LOG_TEMP_UNKNOWN;
> @@ -1082,8 +1082,8 @@ static int nvme_trans_log_temperature(struct nvme_ns *ns, struct sg_io_hdr *hdr,
>  	c.common.opcode = nvme_admin_get_log_page;
>  	c.common.nsid = cpu_to_le32(0xFFFFFFFF);
>  	c.common.prp1 = cpu_to_le64(dma_addr);
> -	c.common.cdw10[0] = cpu_to_le32(((sizeof(struct nvme_smart_log) /
> -			BYTES_TO_DWORDS) << 16) | NVME_GET_SMART_LOG_PAGE);
> +	c.common.cdw10[0] = cpu_to_le32((((sizeof(struct nvme_smart_log) /
> +			BYTES_TO_DWORDS)-1) << 16) | NVME_GET_SMART_LOG_PAGE);
>  	res = nvme_submit_admin_cmd(dev, &c, NULL);
>  	if (res != NVME_SC_SUCCESS) {
>  		temp_c_cur = LOG_TEMP_UNKNOWN;


In principle, the patch is good, thanks for submitting this. I'd be
happy to ack this once you resend with the changes.

	-Vishal
