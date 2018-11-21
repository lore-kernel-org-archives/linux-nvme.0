From: hch@lst.de (Christoph Hellwig)
Date: Wed, 21 Nov 2018 14:07:12 +0100
Subject: [PATCH v2 13/14] nvmet-tcp: add NVMe over TCP target driver
In-Reply-To: <20181120030019.31738-15-sagi@grimberg.me>
References: <20181120030019.31738-1-sagi@grimberg.me>
 <20181120030019.31738-15-sagi@grimberg.me>
Message-ID: <20181121130712.GG1373@lst.de>

> diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
> index 33c8afaf63bd..685780d1ed04 100644
> --- a/include/linux/nvme-tcp.h
> +++ b/include/linux/nvme-tcp.h
> @@ -11,6 +11,7 @@
>  
>  #define NVME_TCP_DISC_PORT	8009
>  #define NVME_TCP_ADMIN_CCSZ	SZ_8K
> +#define NVME_TCP_DIGEST_LENGTH	4

This should go into the previous patch.
