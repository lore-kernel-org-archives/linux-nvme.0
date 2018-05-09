From: emilne@redhat.com (Ewan D. Milne)
Date: Wed, 09 May 2018 11:43:19 -0400
Subject: [PATCH 1/5] nvmet: EUI64 support
In-Reply-To: <20180504112845.38820-2-hare@suse.de>
References: <20180504112845.38820-1-hare@suse.de>
 <20180504112845.38820-2-hare@suse.de>
Message-ID: <1525880599.30724.265.camel@localhost.localdomain>

On Fri, 2018-05-04@13:28 +0200, Hannes Reinecke wrote:
> Allow the setting of an IEEE Extended Unique Identifier (EUI64) for
> each namespace. As the OUI is per subsystem ensure that the OUI
> part of the EUI64 value (ie the top 3 bytes) are matching for each
> namespace.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>  drivers/nvme/target/admin-cmd.c |  6 ++---
>  drivers/nvme/target/configfs.c  | 58 +++++++++++++++++++++++++++++++++++++++++
>  drivers/nvme/target/nvmet.h     |  2 ++
>  3 files changed, 62 insertions(+), 4 deletions(-)
> 
...
> diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
> index ad9ff27234b5..3dc2b2ae56e5 100644
> --- a/drivers/nvme/target/configfs.c
> +++ b/drivers/nvme/target/configfs.c
> @@ -378,6 +378,49 @@ static ssize_t nvmet_ns_device_nguid_store(struct config_item *item,
>  
>  CONFIGFS_ATTR(nvmet_ns_, device_nguid);
>  
> +static ssize_t nvmet_ns_device_eui64_show(struct config_item *item, char *page)
> +{
> +	return sprintf(page, "%llx\n",
> +		       (unsigned long long)&to_nvmet_ns(item)->eui64);
> +}

Notwithstanding Christoph's comment, patch 3/5 changes the above line
again to remove the "&", so you should do that here in the first place
if you keep it.

-Ewan
