From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Jul 2017 14:56:12 +0200
Subject: [PATCH v3 3/3] nvmet: preserve controller serial number
 between reboots
In-Reply-To: <20170714125329.18430-4-jthumshirn@suse.de>
References: <20170714125329.18430-1-jthumshirn@suse.de>
 <20170714125329.18430-4-jthumshirn@suse.de>
Message-ID: <20170714125612.GC27181@lst.de>

> +	down_write(&nvmet_config_sem);
>  	subsys->ver = NVME_VS(1, 3, 0); /* NVMe 1.3.0 */
>  	/* generate a random serial number as our controllers are ephemeral: */
>  	get_random_bytes(&subsys->serial, sizeof(subsys->serial));
> +	up_write(&nvmet_config_sem);

no need for the lock here, the subsystems isn't visible at this point.

Otherwise:

Reviewed-by: Christoph Hellwig <hch at lst.de>
