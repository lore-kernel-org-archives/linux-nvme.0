From: hch@lst.de (Christoph Hellwig)
Date: Thu, 31 May 2018 19:05:10 +0200
Subject: [PATCH] nvmet: filter newlines from user input
In-Reply-To: <20180530231823.1883-1-sagi@grimberg.me>
References: <20180530231823.1883-1-sagi@grimberg.me>
Message-ID: <20180531170510.GA31826@lst.de>

On Thu, May 31, 2018@02:18:23AM +0300, Sagi Grimberg wrote:
> don't consume the annoying newlines in traddr, trsvcid and
> device_path as they appear when reading configfs or worse in
> discovery log pages. Add minimal processing to make sure they
> are gone.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/nvme/target/configfs.c | 34 ++++++++++++++++++++++++++++------
>  drivers/nvme/target/nvmet.h    |  2 +-
>  2 files changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index fd93c6a122d5..fe65c36557fa 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -126,6 +126,8 @@ static ssize_t nvmet_addr_traddr_store(struct config_item *item,
>  		const char *page, size_t count)
>  {
>  	struct nvmet_port *port = to_nvmet_port(item);
> +	char *s, *o, *traddr;
> +	int ret;
>  
>  	if (count > NVMF_TRADDR_SIZE) {
>  		pr_err("Invalid value '%s' for traddr\n", page);
> @@ -137,8 +139,16 @@ static ssize_t nvmet_addr_traddr_store(struct config_item *item,
>  		pr_err("Disable the address before modifying\n");
>  		return -EACCES;
>  	}
> -	return snprintf(port->disc_addr.traddr,
> -			sizeof(port->disc_addr.traddr), "%s", page);
> +
> +	o = s = kstrdup(page, GFP_KERNEL);
> +	if (!o)
> +		return -ENOMEM;
> +
> +	traddr = strsep(&s, "\n");
> +	ret = snprintf(port->disc_addr.traddr,
> +			sizeof(port->disc_addr.traddr), "%s", traddr);
> +	kfree(o);

Isn't scanf the best way to parse data like this?
