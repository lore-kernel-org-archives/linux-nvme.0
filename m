From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 14 Aug 2019 17:31:45 +0300
Subject: [PATCH v7 05/14] nvmet-passthru: update KConfig with config
 passthru option
In-Reply-To: <20190801234514.7941-6-logang@deltatee.com>
References: <20190801234514.7941-1-logang@deltatee.com>
 <20190801234514.7941-6-logang@deltatee.com>
Message-ID: <68173412-f3e3-df6f-78f0-296b03eaaf13@mellanox.com>


On 8/2/2019 2:45 AM, Logan Gunthorpe wrote:
> From: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
>
> This patch updates KConfig file for the NVMeOF target where we add new
> option so that user can selectively enable/disable passthru code.
>
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
> [logang at deltatee.com: fixed some of the wording in the help message]
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> ---
>   drivers/nvme/target/Kconfig | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
> index d7f48c0fb311..2478cb5a932d 100644
> --- a/drivers/nvme/target/Kconfig
> +++ b/drivers/nvme/target/Kconfig
> @@ -15,6 +15,16 @@ config NVME_TARGET
>   	  To configure the NVMe target you probably want to use the nvmetcli
>   	  tool from http://git.infradead.org/users/hch/nvmetcli.git.
>   
> +config NVME_TARGET_PASSTHRU
> +	bool "NVMe Target Passthrough support"
> +	depends on NVME_CORE
> +	depends on NVME_TARGET
> +	help
> +	  This enables target side NVMe passthru controller support for the
> +	  NVMe Over Fabrics protocol. It allows for hosts to manage and
> +	  directly access an actual NVMe controller residing on the target
> +	  side, incuding executing Vendor Unique Commands.
> +
>   config NVME_TARGET_LOOP
>   	tristate "NVMe loopback device support"
>   	depends on NVME_TARGET


Looks good,

Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
