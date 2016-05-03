From: keith.busch@intel.com (Busch, Keith)
Date: Tue, 3 May 2016 14:04:16 +0000
Subject: [PATCH] NVMe: eliminate potential deadlock by
 nvme_get_ns_from_disk invoking nvme_free_ns
In-Reply-To: <1462263954-2475-1-git-send-email-shhuiw@foxmail.com>
References: <1462263954-2475-1-git-send-email-shhuiw@foxmail.com>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B93D578BBE@fmsmsx104.amr.corp.intel.com>

> -----Original Message-----
> From: Wang Sheng-Hui [mailto:shhuiw at foxmail.com]
> Sent: Tuesday, May 03, 2016 2:26 AM
> To: hch at lst.de; sagig at mellanox.com; Busch, Keith; axboe at fb.com; linux-nvme at lists.infradead.org
> Subject: [PATCH] NVMe: eliminate potential deadlock by nvme_get_ns_from_disk invoking nvme_free_ns
> 
> Release dev_list_lock before enter nvme_free_ns from
> nvme_get_ns_from_disk to avoid potential deadlock.
> 
> Signed-off-by: Wang Sheng-Hui <shhuiw at foxmail.com>
> ---
>  drivers/nvme/host/core.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 49bc4c0..81e397b 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -87,20 +87,19 @@ static struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk)
>  	spin_lock(&dev_list_lock);
>  	ns = disk->private_data;
>  	if (ns) {
> -		if (!kref_get_unless_zero(&ns->kref))
> -			goto fail;
> -		if (!try_module_get(ns->ctrl->ops->module))
> -			goto fail_put_ns;
> +		if (!kref_get_unless_zero(&ns->kref)) {
> +			ns = NULL;
> +			goto out;
> +		}
> +		if (!try_module_get(ns->ctrl->ops->module)) {
> +			spin_unlock(&dev_list_lock);
> +			kref_put(&ns->kref, nvme_free_ns);
> +			return NULL;
> +		}
>  	}

Swapping the ns and module reference gets order would have been simpler.
