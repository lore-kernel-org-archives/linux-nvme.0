From: hch@lst.de (Christoph Hellwig)
Date: Tue, 17 Jul 2018 15:48:41 +0200
Subject: [PATCH 2/5] nvmet: fixup crash on NULL device path
In-Reply-To: <20180716105837.101125-3-hare@suse.de>
References: <20180716105837.101125-1-hare@suse.de>
 <20180716105837.101125-3-hare@suse.de>
Message-ID: <20180717134841.GA16604@lst.de>

On Mon, Jul 16, 2018@12:58:34PM +0200, Hannes Reinecke wrote:
> index 094d216ae62a..76efc8120c00 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -295,6 +295,12 @@ static ssize_t nvmet_ns_device_path_store(struct config_item *item,
>  	ns->device_path = kstrndup(page, strcspn(page, "\n"), GFP_KERNEL);
>  	if (!ns->device_path)
>  		goto out_unlock;
> +	if (!strlen(ns->device_path)) {
> +		kfree(ns->device_path);
> +		ns->device_path = NULL;
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}

I think this should rather be:

	ret = -EINVAL;
	len = strcspn(page, "\n");
	if (len == 0)
		goto out_unlock;
	ret = -ENOMEM;
	ns->device_path = kstrndup(page, len, GFP_KERNEL);
	if (!ns->device_path)
		goto out_unlock;

> index 0aeccbddd716..956d293d293d 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -373,8 +373,12 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>  	if (ns->enabled)
>  		goto out_unlock;
>  
> +	if (!ns->device_path) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}

I don't think we should need this fix.

>  	ret = nvmet_bdev_ns_enable(ns);
> -	if (ret)
> +	if (ret == -ENOTBLK)
>  		ret = nvmet_file_ns_enable(ns);

Looks sensible, but please split this into a separate patch.
