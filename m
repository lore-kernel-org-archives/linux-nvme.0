From: Chaitanya.Kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 21 May 2019 17:23:20 +0000
Subject: [PATCH v2 1/4] nvme: Export get and set features
References: <1558454649-28783-1-git-send-email-akinobu.mita@gmail.com>
 <1558454649-28783-2-git-send-email-akinobu.mita@gmail.com>
Message-ID: <DM6PR04MB57543310310DD72F98E361AD86070@DM6PR04MB5754.namprd04.prod.outlook.com>

On 5/21/19 9:05 AM, Akinobu Mita wrote:
> From: Keith Busch <keith.busch at intel.com>
>
> Future use intends to make use of features, so export these functions. And
> since their implementation is identical except for the opcode, provide
> a new convenience function that implement each.
>
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/core.c | 22 +++++++++++++++++++---
>  drivers/nvme/host/nvme.h |  4 ++++
>  2 files changed, 23 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d352145..c04df80 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1113,15 +1113,15 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
>  	return id;
>  }
>  
> -static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
> -		      void *buffer, size_t buflen, u32 *result)
> +static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned fid,
> +		unsigned dword11, void *buffer, size_t buflen, u32 *result)

Your patch is generating warnings, can we please avoid these warnings ?

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#28: FILE: drivers/nvme/host/core.c:1116:
+static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned fid,

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#29: FILE: drivers/nvme/host/core.c:1117:
+        unsigned dword11, void *buffer, size_t buflen, u32 *result)

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#45: FILE: drivers/nvme/host/core.c:1135:
+int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned
dword11,

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#45: FILE: drivers/nvme/host/core.c:1135:
+int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned
dword11,

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#53: FILE: drivers/nvme/host/core.c:1143:
+int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned
dword11,

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#53: FILE: drivers/nvme/host/core.c:1143:
+int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned
dword11,

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#72: FILE: drivers/nvme/host/nvme.h:462:
+int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned
dword11,

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#72: FILE: drivers/nvme/host/nvme.h:462:
+int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned
dword11,

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#74: FILE: drivers/nvme/host/nvme.h:464:
+int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned
dword11,

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
#74: FILE: drivers/nvme/host/nvme.h:464:
+int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned
dword11,

total: 0 errors, 10 warnings, 50 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or
--fix-inplace.

0001-nvme-fix-memory-leak-for-power-latency-tolerance.patch has style
problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.

>  {
>  	struct nvme_command c;
>  	union nvme_result res;
>  	int ret;
>  
>  	memset(&c, 0, sizeof(c));
> -	c.features.opcode = nvme_admin_set_features;
> +	c.features.opcode = op;
>  	c.features.fid = cpu_to_le32(fid);
>  	c.features.dword11 = cpu_to_le32(dword11);
>  
> @@ -1132,6 +1132,22 @@ static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword
>  	return ret;
>  }
>  
> +int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
> +		      void *buffer, size_t buflen, u32 *result)
> +{
> +	return nvme_features(dev, nvme_admin_set_features, fid, dword11, buffer,
> +			     buflen, result);
> +}
> +EXPORT_SYMBOL_GPL(nvme_set_features);
> +
> +int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
> +		      void *buffer, size_t buflen, u32 *result)
> +{
> +	return nvme_features(dev, nvme_admin_get_features, fid, dword11, buffer,
> +			     buflen, result);
> +}
> +EXPORT_SYMBOL_GPL(nvme_get_features);
> +
>  int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
>  {
>  	u32 q_count = (*count - 1) | ((*count - 1) << 16);
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 56bba7a..bb673b8 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -459,6 +459,10 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>  		union nvme_result *result, void *buffer, unsigned bufflen,
>  		unsigned timeout, int qid, int at_head,
>  		blk_mq_req_flags_t flags, bool poll);
> +int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
> +		      void *buffer, size_t buflen, u32 *result);
> +int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
> +		      void *buffer, size_t buflen, u32 *result);
>  int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
>  void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
>  int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
