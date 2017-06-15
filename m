From: scott.bauer@intel.com (Scott Bauer)
Date: Thu, 15 Jun 2017 09:52:52 -0600
Subject: [nvme-4.13 V2] nvme: Implement NS Optimal IO Boundary from 1.3
 Spec
In-Reply-To: <20170615154726.8337-1-scott.bauer@intel.com>
References: <20170615154726.8337-1-scott.bauer@intel.com>
Message-ID: <20170615155251.dmmpfcd22vv2ozko@sbauer-Z170X-UD5>

On Thu, Jun 15, 2017@09:47:26AM -0600, Scott Bauer wrote:
> The NVMe 1.3 spec introduces Namespace Optimal IO Boundaries (NOIOB),
> which standardizes the stripe mechanism we currently have quirks for.
> This patch implements the necessary logic to handle this new feature.
> 
> Signed-off-by: Scott Bauer <scott.bauer at intel.com>
> ---
>  drivers/nvme/host/core.c | 9 +++++++++
>  drivers/nvme/host/nvme.h | 1 +
>  include/linux/nvme.h     | 2 +-
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 4ff5114f467d..dfa72bb2ef0c 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1080,6 +1080,12 @@ static void nvme_init_integrity(struct nvme_ns *ns)
>  }
>  #endif /* CONFIG_BLK_DEV_INTEGRITY */
>  
> +static void nvme_set_chunk_size(struct nvme_ns *ns)
> +{
> +	unsigned int chunk_size = (((u32)ns->noiob) << ns->lba_shift) >> 9;
> +	blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(chunk_size));
> +}
> +
>  static void nvme_config_discard(struct nvme_ns *ns)
>  {
>  	struct nvme_ctrl *ctrl = ns->ctrl;
> @@ -1139,12 +1145,15 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
>  	if (ns->lba_shift == 0)
>  		ns->lba_shift = 9;
>  	bs = 1 << ns->lba_shift;
> +	ns->noiob = le16_to_cpu(id->noiob);

I need to re-spin this one more time. I forgot to add the 1.3 version check before accessing the
register here.
