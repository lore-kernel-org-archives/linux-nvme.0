From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 11 Jul 2019 09:05:28 -0700
Subject: [PATCH] nvme: tcp: depends on CRYPTO_HASH2 for nvme-tcp
In-Reply-To: <20190711151338.16810-1-minwoo.im.dev@gmail.com>
References: <20190711151338.16810-1-minwoo.im.dev@gmail.com>
Message-ID: <d67b7a73-0061-202c-457d-93bc4cd06122@grimberg.me>

Hi Minwoo,

> The tcp host module is now taking those APIs from crypto ahash:
> 	(1) crypto_ahash_final()
> 	(2) crypto_ahash_digest()
> 	(3) crypto_alloc_ahash()
> 
> nvme-tcp should depends on CRYPTO_HASH2.

It actually should depend on CRYPTO_CRC32C because
it needs CRC32C.

> 
> Cc: Christoph Hellwig <hch at lst.de>
> Cc: Keith Busch <kbusch at kernel.org>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: Jens Axboe <axboe at fb.com>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>   drivers/nvme/host/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
> index ec43ac9199e2..711d3ea5143f 100644
> --- a/drivers/nvme/host/Kconfig
> +++ b/drivers/nvme/host/Kconfig
> @@ -63,6 +63,7 @@ config NVME_TCP
>   	tristate "NVM Express over Fabrics TCP host driver"
>   	depends on INET
>   	depends on BLK_DEV_NVME
> +	depends on CRYPTO_HASH2

Lets make it select instead.

>   	select NVME_FABRICS
>   	help
>   	  This provides support for the NVMe over Fabrics protocol using
> 
