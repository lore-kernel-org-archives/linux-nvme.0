From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 23 May 2016 12:06:52 -0500
Subject: [PATCH 2/2] nvme/pci: Enable SR-IOV capabilities
In-Reply-To: <1463521199-16604-2-git-send-email-keith.busch@intel.com>
References: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
 <1463521199-16604-2-git-send-email-keith.busch@intel.com>
Message-ID: <20160523170652.GA12826@localhost>

On Tue, May 17, 2016@03:39:59PM -0600, Keith Busch wrote:
> Registers a standard boiler-plate SR-IOV configure callback for NVMe.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/pci.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index fbe8cc2..8379b9a 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2033,6 +2033,18 @@ static void nvme_remove(struct pci_dev *pdev)
>  	nvme_put_ctrl(&dev->ctrl);
>  }
>  
> +static int nvme_sriov_configure(struct pci_dev *pdev, int numvfs)
> +{
> +	int ret = 0;
> +
> +	if (numvfs == 0)
> +		pci_disable_sriov(pdev);
> +	else
> +		ret = pci_enable_sriov(pdev, numvfs);
> +
> +	return ret ? ret : numvfs;
> +}

I do not subscribe to the belief that every function should have a
single exit.  In this case, I think it makes the function much harder
to understand than this:

  if (numvfs == 0)
    pci_disable_sriov(pdev);
    return 0;
  }

  return pci_enable_sriov(pdev, numvfs);

>  #ifdef CONFIG_PM_SLEEP
>  static int nvme_suspend(struct device *dev)
>  {
> @@ -2127,6 +2139,7 @@ static struct pci_driver nvme_driver = {
>  	.driver		= {
>  		.pm	= &nvme_dev_pm_ops,
>  	},
> +	.sriov_configure = nvme_sriov_configure,
>  	.err_handler	= &nvme_err_handler,
>  };
>  
> -- 
> 2.7.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
