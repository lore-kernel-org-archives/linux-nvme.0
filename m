From: jonathan.derrick@intel.com (Jon Derrick)
Date: Tue, 27 Sep 2016 17:17:04 -0600
Subject: [PATCH 1/1] nvme : Add sysfs entry for NVMe CMBs when appropriate
In-Reply-To: <1475014513-18083-2-git-send-email-sbates@raithlin.com>
References: <1475014513-18083-1-git-send-email-sbates@raithlin.com>
 <1475014513-18083-2-git-send-email-sbates@raithlin.com>
Message-ID: <20160927231703.GA6694@localhost.localdomain>

Hi Stephen,

Thanks for reviving the CMB discussions. Everything seems reasonable to
me, but I must question if we want a 'show' without a 'control'.
Consider if the 'control' ends up requiring an API that supercedes the
'show' in a more natural way.

Otherwise I'm for this.

>  	}
> 
> -	if (readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 2))
> +	/*
> +	 * CMBs can currently only exist on >=1.2 PCIe devices. We only
> +	 * populate sysfs if a CMB is implemented. Note that we add the
> +	 * CMB attribute to the nvme_ctrl kobj which removes the need to remove
> +	 * it on exit. Since nvme_dev_attrs_group has no name we can pass
> +	 * NULL as final argument to sysfs_add_file_to_group.
> +	 */
> +
> +	if (readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 2)) {
>  		dev->cmb = nvme_map_cmb(dev);
> 
> +		if (readl(dev->bar + NVME_REG_CMBSZ)) {
Small nit: we have this value cached in dev->cmbsz. So unless something
has changed in the configuration, we could use that instead.
