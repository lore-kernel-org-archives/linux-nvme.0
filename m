From: hch@lst.de (Christoph Hellwig)
Date: Mon, 5 Jun 2017 07:45:11 +0200
Subject: [PATCH v4 7/8] nvmet: allow overriding the NVMe VS via configfs
In-Reply-To: <20170604103649.22130-8-jthumshirn@suse.de>
References: <20170604103649.22130-1-jthumshirn@suse.de>
 <20170604103649.22130-8-jthumshirn@suse.de>
Message-ID: <20170605054511.GF19480@lst.de>

On Sun, Jun 04, 2017@12:36:48PM +0200, Johannes Thumshirn wrote:
> Allow overriding the announced NVMe Version of a via configfs.
> 
> This is particularly helpful when debugging new features for the host
> or target side without bumping the hard coded version (as the target
> might not be fully compliant to the announced version yet).
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/target/configfs.c | 34 ++++++++++++++++++++++++++++++++++
>  include/linux/nvme.h           |  4 ++++
>  2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 16f9f6e3a084..45421d4308a4 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -650,8 +650,42 @@ static ssize_t nvmet_subsys_attr_allow_any_host_store(struct config_item *item,
>  
>  CONFIGFS_ATTR(nvmet_subsys_, attr_allow_any_host);
>  
> +static ssize_t nvmet_subsys_version_show(struct config_item *item,
> +					      char *page)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item);
> +	int major, minor, tertiary;
> +	u32 ver;
> +
> +	ver = subsys->ver;
> +	major = NVME_MAJOR(ver);
> +	minor = NVME_MINOR(ver);
> +	tertiary = NVME_TERRIARY(ver);
> +
> +	return snprintf(page, PAGE_SIZE, "%d %d %d\n", major, minor, tertiary);

Nit Dop we really need all these variables?  Why not:

	return snprintf(page, PAGE_SIZE, "%d %d %d\n", NVME_MAJOR(subsys->ver), 
			NVME_MINOR(subsys->ver),  NVME_TERRIARY(subsys->ver));

?

Also except for the 1.2.1 oddbackk NVMe versions usually have two
components, and should be printed as such if the tertiary version is
0.


> +static ssize_t nvmet_subsys_version_store(struct config_item *item,
> +					       const char *page, size_t count)
> +{
> +	struct nvmet_subsys *subsys = to_subsys(item);
> +	int major, minor, tertiary;
> +	int ret;
> +
> +
> +	ret = sscanf(page, "%d %d %d\n", &major, &minor, &tertiary);
> +	if (ret != 3)
> +		return -EINVAL;

Same issue here.  I also have to say I'm a bit sceptical about
just being able to set versions as there are various dependencies
on it.  E.g. for 1.0 the version field in identify namespace doesn't
even exists and should be cleared to 0.

> +
> +	subsys->ver = NVME_VS(major, minor, tertiary);

locking?

> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index afa6ef484e50..0d6e307a7aa4 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -1069,4 +1069,8 @@ struct nvme_completion {
>  #define NVME_VS(major, minor, tertiary) \
>  	(((major) << 16) | ((minor) << 8) | (tertiary))
>  
> +#define NVME_MAJOR(ver)		((ver) >> 16)
> +#define NVME_MINOR(ver)		(((ver) >> 8) & 0xff)
> +#define NVME_TERRIARY(ver)	((ver) & 0xff)

I think TERRIARY should be TERTIARY.
