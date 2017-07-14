From: hch@lst.de (Christoph Hellwig)
Date: Fri, 14 Jul 2017 14:31:01 +0200
Subject: [PATCH v2 1/2] nvmet: Move serial number from controller to
 subsystem
In-Reply-To: <20170714120517.13552-2-jthumshirn@suse.de>
References: <20170714120517.13552-1-jthumshirn@suse.de>
 <20170714120517.13552-2-jthumshirn@suse.de>
Message-ID: <20170714123100.GD26187@lst.de>

> -	/* generate a random serial number as our controllers are ephemeral: */
> -	get_random_bytes(&ctrl->serial, sizeof(ctrl->serial));
> -
>  	kref_init(&ctrl->ref);
>  	ctrl->subsys = subsys;
>  
> @@ -928,6 +925,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
>  		return NULL;
>  
>  	subsys->ver = NVME_VS(1, 3, 0); /* NVMe 1.3.0 */
> +	get_random_bytes(&subsys->serial, sizeof(subsys->serial));

This removes the comment, which I think is fairly useful.
