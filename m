From: keith.busch@intel.com (Keith Busch)
Date: Fri, 17 Mar 2017 18:28:44 -0400
Subject: [PATCH v4 RFC] nvme: improve performance for virtual NVMe devices
In-Reply-To: <1489787099-2049-1-git-send-email-helen.koike@collabora.com>
References: <c738f3d3c14907a9074a40b1658461e008fbed9e.1471308889.git.helen.koike@collabora.co.uk>
 <1489787099-2049-1-git-send-email-helen.koike@collabora.com>
Message-ID: <20170317222843.GD13709@localhost.localdomain>

On Fri, Mar 17, 2017@06:44:59PM -0300, Helen Koike wrote:
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index 90745a6..7ada6f3 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -59,4 +59,13 @@ config NVME_FC
>  	  To configure a NVMe over Fabrics controller use the nvme-cli tool
>  	  from https://github.com/linux-nvme/nvme-cli.
>  
> +config NVME_DBBUF
> +	bool "NVM Express Doorbell Buffer Config Command"
> +	depends on NVME_CORE
> +	---help---
> +	  This provides support for the Doorbell Buffer Config Command, which
> +	  reduces the number of required MMIOs to ring doorbells, improving
> +	  performance for virtualised environments where MMIO causes a high
> +	  overhead.
> +
>  	  If unsure, say N.

It looks like you took the last line from NVME_FC's help. But I don't
think this capabilty should enabled through kernel config, though. Just
have the driver react based on the device's advertised capabilities, ya?
