From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 13 Jun 2016 16:14:11 -0500
Subject: [PATCH 1/2] pci: Error disabling SR-IOV if in VFs assigned
In-Reply-To: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
References: <1463521199-16604-1-git-send-email-keith.busch@intel.com>
Message-ID: <20160613211411.GC18747@localhost>

On Tue, May 17, 2016@03:39:58PM -0600, Keith Busch wrote:
> Every sriov capable driver has to check if any guest is using a virtual
> function prior to disabling, so let's make it common code.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>

If I understand the discussion correctly, this is still racy but
nobody objects to adding this until we have a better, non-racy
solution.

However, you added this in common code and took advantage of it in
nvme.  Good so far.  But we have about a dozen other drivers that call
pci_vfs_assigned().  I assume some of those places could be changed so
they take advantage of this check in the core instead?

Can we do that at the same time?  If we add good new stuff and only
use it one place, there's not as much overall goodness as there would
be if we updated everybody to do it similarly.

> ---
>  drivers/pci/pci-sysfs.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 342b691..5011fa9 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -487,6 +487,11 @@ static ssize_t sriov_numvfs_store(struct device *dev,
>  
>  	if (num_vfs == 0) {
>  		/* disable VFs */
> +		if (pci_vfs_assigned(pdev)) {
> +			dev_warn(&pdev->dev,
> +				"Cannot disable SR-IOV VFs while assigned\n");
> +			return -EPERM;
> +		}
>  		ret = pdev->driver->sriov_configure(pdev, 0);
>  		if (ret < 0)
>  			return ret;
> -- 
> 2.7.2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
