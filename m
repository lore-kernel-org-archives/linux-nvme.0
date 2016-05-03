From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 3 May 2016 01:03:59 -0700
Subject: [PATCH-4.7 3/3] NVMe: Set capacity to 0 on all unusable namespaces
In-Reply-To: <1462209128-12376-4-git-send-email-keith.busch@intel.com>
References: <1462209128-12376-1-git-send-email-keith.busch@intel.com>
 <1462209128-12376-4-git-send-email-keith.busch@intel.com>
Message-ID: <20160503080359.GC31768@infradead.org>

On Mon, May 02, 2016@11:12:08AM -0600, Keith Busch wrote:
> Set the disk capacity to 0 if unable to identify a namespace for any
> reason. This way revalidating detached namespaces will be deleted quicker
> since dirty data can't be sync'ed.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/core.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 9f1f318..b9de770 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -771,31 +771,27 @@ static void nvme_config_discard(struct nvme_ns *ns)
>  static int nvme_revalidate_disk(struct gendisk *disk)
>  {
>  	struct nvme_ns *ns = disk->private_data;
> -	struct nvme_id_ns *id;
> +	struct nvme_id_ns *id = NULL;
>  	u8 lbaf, pi_type;
>  	u16 old_ms;
>  	unsigned short bs;
>  
> -	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
> -		set_capacity(disk, 0);
> -		return -ENODEV;
> -	}
> +	if (test_bit(NVME_NS_DEAD, &ns->flags))
> +		goto no_dev;
> +
>  	if (nvme_identify_ns(ns->ctrl, ns->ns_id, &id)) {
>  		dev_warn(disk_to_dev(ns->disk), "%s: Identify failure\n",
>  				__func__);
> -		return -ENODEV;
> -	}
> -	if (id->ncap == 0) {
> -		kfree(id);
> -		return -ENODEV;
> +		goto no_dev;
>  	}
> +	if (id->ncap == 0)
> +		goto no_dev;
>  
>  	if (nvme_nvm_ns_supported(ns, id) && ns->type != NVME_NS_LIGHTNVM) {
>  		if (nvme_nvm_register(ns->queue, disk->disk_name)) {
>  			dev_warn(disk_to_dev(ns->disk),
>  				"%s: LightNVM init failure\n", __func__);
> -			kfree(id);
> -			return -ENODEV;
> +			goto no_dev;

Not related to this patch, but: the lightnvm code really needs to go away
here - the NVMe spec is clear that the Identify Namespace structure is
NVM Command set specific, and our whole block device implementation
shouldn't even be called for lightnvm.  

Otherwise this looks fine to me,

Reviewed-by: Christoph Hellwig <hch at lst.de>
