From: vishal.l.verma@linux.intel.com (Vishal Verma)
Date: Mon, 29 Apr 2013 10:24:52 -0600
Subject: [PATCH] NVMe: queue usage fixes in nvme-scsi
In-Reply-To: <1366922367-18619-1-git-send-email-keith.busch@intel.com>
References: <1366922367-18619-1-git-send-email-keith.busch@intel.com>
Message-ID: <1367252692.21521.10.camel@teamfortress>

Acked-by: Vishal Verma <vishal.l.verma at linux.intel.com>

On Thu, 2013-04-25@14:39 -0600, Keith Busch wrote:
> Fixes nvme queue usages in scsi-to-nvme translation code to not get
> a queue more often than it is being put, and not use the queue in an
> unsafe way without it being locked.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/block/nvme-scsi.c |   25 ++++++++++++++++++++-----
>  1 files changed, 20 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/block/nvme-scsi.c b/drivers/block/nvme-scsi.c
> index bbfb288..913de0a 100644
> --- a/drivers/block/nvme-scsi.c
> +++ b/drivers/block/nvme-scsi.c
> @@ -2039,7 +2039,7 @@ static int nvme_trans_do_nvme_io(struct nvme_ns *ns, struct sg_io_hdr *hdr,
>  	int res = SNTI_TRANSLATION_SUCCESS;
>  	int nvme_sc;
>  	struct nvme_dev *dev = ns->dev;
> -	struct nvme_queue *nvmeq = get_nvmeq(ns->dev);
> +	struct nvme_queue *nvmeq;
>  	u32 num_cmds;
>  	struct nvme_iod *iod;
>  	u64 unit_len;
> @@ -2653,7 +2653,8 @@ static int nvme_trans_start_stop(struct nvme_ns *ns, struct sg_io_hdr *hdr,
>  {
>  	int res = SNTI_TRANSLATION_SUCCESS;
>  	int nvme_sc;
> -	struct nvme_queue *nvmeq = get_nvmeq(ns->dev);
> +	struct nvme_queue *nvmeq;
> +	struct nvme_command c;
>  	u8 immed, pcmod, pc, no_flush, start;
>  
>  	immed = GET_U8_FROM_CDB(cmd, START_STOP_UNIT_CDB_IMMED_OFFSET);
> @@ -2675,8 +2676,14 @@ static int nvme_trans_start_stop(struct nvme_ns *ns, struct sg_io_hdr *hdr,
>  	} else {
>  		if (no_flush == 0) {
>  			/* Issue NVME FLUSH command prior to START STOP UNIT */
> -			nvme_sc = nvme_submit_flush_data(nvmeq, ns);
> +			memset(&c, 0, sizeof(c));
> +			c.common.opcode = nvme_cmd_flush;
> +			c.common.nsid = cpu_to_le32(ns->ns_id);
> +			
> +			nvmeq = get_nvmeq(ns->dev);
>  			put_nvmeq(nvmeq);
> +			nvme_sc = nvme_submit_sync_cmd(nvmeq, &c, NULL, NVME_IO_TIMEOUT);
> +
>  			res = nvme_trans_status_code(hdr, nvme_sc);
>  			if (res)
>  				goto out;
> @@ -2698,9 +2705,17 @@ static int nvme_trans_synchronize_cache(struct nvme_ns *ns,
>  {
>  	int res = SNTI_TRANSLATION_SUCCESS;
>  	int nvme_sc;
> -	struct nvme_queue *nvmeq = get_nvmeq(ns->dev);
> +	struct nvme_command c;
> +	struct nvme_queue *nvmeq;
> +
> +	memset(&c, 0, sizeof(c));
> +	c.common.opcode = nvme_cmd_flush;
> +	c.common.nsid = cpu_to_le32(ns->ns_id);
> +
> +	nvmeq = get_nvmeq(ns->dev);
>  	put_nvmeq(nvmeq);
> -	nvme_sc = nvme_submit_flush_data(nvmeq, ns);
> +	nvme_sc = nvme_submit_sync_cmd(nvmeq, &c, NULL, NVME_IO_TIMEOUT);
> +
>  	res = nvme_trans_status_code(hdr, nvme_sc);
>  	if (res)
>  		goto out;
