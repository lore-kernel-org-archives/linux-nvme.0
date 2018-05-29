From: hch@lst.de (Christoph Hellwig)
Date: Tue, 29 May 2018 14:50:36 +0200
Subject: [PATCH 07/10] nvmet: make ANATT configurable
In-Reply-To: <20180529101431.62271-8-hare@suse.de>
References: <20180529101431.62271-1-hare@suse.de>
 <20180529101431.62271-8-hare@suse.de>
Message-ID: <20180529125036.GG7376@lst.de>

On Tue, May 29, 2018@12:14:28PM +0200, Hannes Reinecke wrote:
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index ddc3fa9fd92f..2c6de9961ef4 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -738,10 +738,38 @@ static ssize_t nvmet_subsys_attr_serial_store(struct config_item *item,
>  }
>  CONFIGFS_ATTR(nvmet_subsys_, attr_serial);
>  
> +static ssize_t nvmet_subsys_attr_anatt_show(struct config_item *item,
> +					    char *page)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item);
> +
> +	return snprintf(page, PAGE_SIZE, "%d\n", subsys->anatt);
> +}
> +
> +static ssize_t nvmet_subsys_attr_anatt_store(struct config_item *item,
> +					     const char *page, size_t count)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item);
> +	int ret;
> +	u8 ana_tt;
> +
> +	ret = kstrtou8(page, 0, &ana_tt);
> +	if (ret || ana_tt == 0) {
> +		return -EINVAL;
> +	}

No need for the braces and please propagate the original return value.

Otherwise this looks ok.
