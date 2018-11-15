From: hch@lst.de (Christoph Hellwig)
Date: Thu, 15 Nov 2018 12:40:14 +0100
Subject: [PATCH v3 2/4] nvmet: don't override treq upon modification.
In-Reply-To: <20181114182534.28807-3-sagi@grimberg.me>
References: <20181114182534.28807-1-sagi@grimberg.me>
 <20181114182534.28807-3-sagi@grimberg.me>
Message-ID: <20181115114014.GA17319@lst.de>

> index 613a37683eae..abc603fa725d 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -56,6 +56,8 @@
>  #define IPO_IATTR_CONNECT_SQE(x)	\
>  	(cpu_to_le32(offsetof(struct nvmf_connect_command, x)))
>  
> +#define NVMET_TREQ_SECURE_CHANNEL_MASK 0x3

Shouldn't this go with the other NVMET_TREQ_ symbols in the enum?
