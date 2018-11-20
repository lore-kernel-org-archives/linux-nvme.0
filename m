From: keith.busch@intel.com (Keith Busch)
Date: Tue, 20 Nov 2018 11:47:49 -0700
Subject: [PATCH 1/3] nvme: enable multipathing by default
In-Reply-To: <20181120162734.2013-2-hch@lst.de>
References: <20181120162734.2013-1-hch@lst.de>
 <20181120162734.2013-2-hch@lst.de>
Message-ID: <20181120184749.GF26707@localhost.localdomain>

On Tue, Nov 20, 2018@05:27:32PM +0100, Christoph Hellwig wrote:
> And make it a little more clear that the only reason to disable it is
> to optimize for size in constrained environment.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/Kconfig | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index 88a8b5916624..d2ae6954ce7e 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -16,12 +16,20 @@ config BLK_DEV_NVME
>  config NVME_MULTIPATH
>  	bool "NVMe multipath support"
>  	depends on NVME_CORE
> +	default y
>  	---help---
>  	   This option enables support for multipath access to NVMe
>  	   subsystems.  If this option is enabled only a single
>  	   /dev/nvmeXnY device will show up for each NVMe namespaces,
>  	   even if it is accessible through multiple controllers.
>  
> +	   Say Y here unless you need to optimize for size in embedded
> +	   systems that are never going to see multi-port NVMe devices.
> +
> +	   If you say N multiple ports of the same subsystem will show
> +	   up as separate devices, and none of the normal block device
> +	   exclusion mechanisms will work.
> +
>  config NVME_FABRICS
>  	tristate

This is okay with me, but I have one little follow-on I'd like to RFC here:

The /dev/nvme naming convention with multiplath has broken people's
minds, and making it default will invite a lot of repeat questions on
how to match up block to admin handles.

Could we promote /dev/nvme0 to be a subsystem handle instead of a
controller handle, and add new per-controller handles, like /dev/nvme0c1,
nvme0c2, etc...? The subsystem handle's management interface can just use
the first active controller to forward admin commands, and per-controller
specific administration can be taught to use the new handles as needed.

Tooling shouldn't care about the names, but I am not sure if this could
possibly break productino scripts. The naming disconnect has broken
some things, though, so I hope this doesn't end up being a pick your
poision suggestion...
