From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 4 Jun 2017 18:08:42 +0300
Subject: [PATCH v4 7/8] nvmet: allow overriding the NVMe VS via configfs
In-Reply-To: <20170604103649.22130-8-jthumshirn@suse.de>
References: <20170604103649.22130-1-jthumshirn@suse.de>
 <20170604103649.22130-8-jthumshirn@suse.de>
Message-ID: <aed83b35-b1fd-d469-73a5-412175b65179@grimberg.me>



On 04/06/17 13:36, Johannes Thumshirn wrote:
> Allow overriding the announced NVMe Version of a via configfs.
> 
> This is particularly helpful when debugging new features for the host
> or target side without bumping the hard coded version (as the target
> might not be fully compliant to the announced version yet).
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>   drivers/nvme/target/configfs.c | 34 ++++++++++++++++++++++++++++++++++
>   include/linux/nvme.h           |  4 ++++
>   2 files changed, 38 insertions(+)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index 16f9f6e3a084..45421d4308a4 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -650,8 +650,42 @@ static ssize_t nvmet_subsys_attr_allow_any_host_store(struct config_item *item,
>   
>   CONFIGFS_ATTR(nvmet_subsys_, attr_allow_any_host);
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

Nit: maybe a dot separator would be better? e.g. "1.3.0" rather than
"1 3 0"

Otherwise looks good,

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
