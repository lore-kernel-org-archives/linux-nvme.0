From: hare@suse.de (Hannes Reinecke)
Date: Fri, 14 Jul 2017 15:41:14 +0200
Subject: [PATCH v3 1/3] nvmet: prefix version configfs file with attr
In-Reply-To: <20170714125329.18430-2-jthumshirn@suse.de>
References: <20170714125329.18430-1-jthumshirn@suse.de>
 <20170714125329.18430-2-jthumshirn@suse.de>
Message-ID: <c1ef357e-8e10-9053-ea23-44ee51fe2274@suse.de>

On 07/14/2017 02:53 PM, Johannes Thumshirn wrote:
> The NVMe target's attribute files need an attr prefix in order to have
> nvmetcli recognize them. Add this attribute.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/target/configfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index a358ecd93e11..ceee57bb0c24 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -650,7 +650,7 @@ static ssize_t nvmet_subsys_attr_allow_any_host_store(struct config_item *item,
>  
>  CONFIGFS_ATTR(nvmet_subsys_, attr_allow_any_host);
>  
> -static ssize_t nvmet_subsys_version_show(struct config_item *item,
> +static ssize_t nvmet_subsys_attr_version_show(struct config_item *item,
>  					      char *page)
>  {
>  	struct nvmet_subsys *subsys = to_subsys(item);
> @@ -666,7 +666,7 @@ static ssize_t nvmet_subsys_version_show(struct config_item *item,
>  				(int)NVME_MINOR(subsys->ver));
>  }
>  
> -static ssize_t nvmet_subsys_version_store(struct config_item *item,
> +static ssize_t nvmet_subsys_attr_version_store(struct config_item *item,
>  					       const char *page, size_t count)
>  {
>  	struct nvmet_subsys *subsys = to_subsys(item);
> @@ -684,11 +684,11 @@ static ssize_t nvmet_subsys_version_store(struct config_item *item,
>  
>  	return count;
>  }
> -CONFIGFS_ATTR(nvmet_subsys_, version);
> +CONFIGFS_ATTR(nvmet_subsys_, attr_version);
>  
>  static struct configfs_attribute *nvmet_subsys_attrs[] = {
>  	&nvmet_subsys_attr_attr_allow_any_host,
> -	&nvmet_subsys_attr_version,
> +	&nvmet_subsys_attr_attr_version,
>  	NULL,
>  };
>  
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
