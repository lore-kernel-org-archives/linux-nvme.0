From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 25 May 2018 17:30:43 -0500
Subject: [PATCH] PCI/sysfs: do not allow enabling/disabling a device with
 a driver
In-Reply-To: <20180518165624.13993-1-hch@lst.de>
References: <20180518165624.13993-1-hch@lst.de>
Message-ID: <20180525223043.GC63280@bhelgaas-glaptop.roam.corp.google.com>

On Fri, May 18, 2018@06:56:24PM +0200, Christoph Hellwig wrote:
> Manpulating the enable_cnt behind the back of the driver will wreck
> complete havok with the kernel state, so disallow it.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

Applied to pci/enumeration for v4.18, thanks!

> ---
>  drivers/pci/pci-sysfs.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 366d93af051d..788a200fb2dc 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -288,13 +288,16 @@ static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
>  	if (!capable(CAP_SYS_ADMIN))
>  		return -EPERM;
>  
> -	if (!val) {
> -		if (pci_is_enabled(pdev))
> -			pci_disable_device(pdev);
> -		else
> -			result = -EIO;
> -	} else
> +	device_lock(dev);
> +	if (dev->driver)
> +		result = -EBUSY;
> +	else if (val)
>  		result = pci_enable_device(pdev);
> +	else if (pci_is_enabled(pdev))
> +		pci_disable_device(pdev);
> +	else
> +		result = -EIO;
> +	device_unlock(dev);
>  
>  	return result < 0 ? result : count;
>  }
> -- 
> 2.17.0
> 
