From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 27 May 2014 11:19:15 -0600
Subject: [PATCHv2 1/2] PCI: Device driver reset notification
In-Reply-To: <1399048843-9376-1-git-send-email-keith.busch@intel.com>
References: <1399048843-9376-1-git-send-email-keith.busch@intel.com>
Message-ID: <20140527171915.GA14005@google.com>

On Fri, May 02, 2014@10:40:42AM -0600, Keith Busch wrote:
> Notifies a pci device driver when its device's access is about to be
> disabled for an impending reset attempt, then after the attempt completes
> and device access is restored.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

I applied both of these to my pci/hotplug branch for v3.16.  Let me know if
you want me to drop the NVMe patch and have it go via another tree.

Bjorn

> ---
> v1 -> v2:
> 
> Call the reset notification in all cases before device access is disabled
> and after device access is restored.
> 
>  drivers/pci/pci.c   |   21 +++++++++++++++++++++
>  include/linux/pci.h |    3 +++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 7325d43..43d87b2 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3305,8 +3305,27 @@ static void pci_dev_unlock(struct pci_dev *dev)
>  	pci_cfg_access_unlock(dev);
>  }
>  
> +/**
> + * pci_reset_notify - notify device driver of reset
> + * @dev: device to be notified of reset
> + * @prepare: 'true' if device is about to be reset; 'false' if reset attempt
> + *           completed
> + *
> + * Must be called prior to device access being disabled and after device
> + * access is restored.
> + */
> +static void pci_reset_notify(struct pci_dev *dev, bool prepare)
> +{
> +	const struct pci_error_handlers *err_handler =
> +			dev->driver ? dev->driver->err_handler : NULL;
> +	if (err_handler && err_handler->reset_notify)
> +		err_handler->reset_notify(dev, prepare);
> +}
> +
>  static void pci_dev_save_and_disable(struct pci_dev *dev)
>  {
> +	pci_reset_notify(dev, true);
> +
>  	/*
>  	 * Wake-up device prior to save.  PM registers default to D0 after
>  	 * reset and a simple register restore doesn't reliably return
> @@ -3328,6 +3347,7 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
>  static void pci_dev_restore(struct pci_dev *dev)
>  {
>  	pci_restore_state(dev);
> +	pci_reset_notify(dev, false);
>  }
>  
>  static int pci_dev_reset(struct pci_dev *dev, int probe)
> @@ -3344,6 +3364,7 @@ static int pci_dev_reset(struct pci_dev *dev, int probe)
>  
>  	return rc;
>  }
> +
>  /**
>   * __pci_reset_function - reset a PCI device function
>   * @dev: PCI device to reset
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index aab57b4..31c4309 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -603,6 +603,9 @@ struct pci_error_handlers {
>  	/* PCI slot has been reset */
>  	pci_ers_result_t (*slot_reset)(struct pci_dev *dev);
>  
> +	/* PCI function reset prepare or completed */
> +	void (*reset_notify)(struct pci_dev *dev, bool prepare);
> +
>  	/* Device driver may resume normal operations */
>  	void (*resume)(struct pci_dev *dev);
>  };
> -- 
> 1.7.10.4
> 
