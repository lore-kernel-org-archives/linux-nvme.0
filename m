From: jonathan.derrick@intel.com (Jon Derrick)
Date: Fri, 7 Oct 2016 09:26:05 -0600
Subject: [PATCH v1 1/1] nvme : Add sysfs entry for NVMe CMBs when
 appropriate
In-Reply-To: <1475719272-8370-2-git-send-email-sbates@raithlin.com>
References: <1475719272-8370-1-git-send-email-sbates@raithlin.com>
 <1475719272-8370-2-git-send-email-sbates@raithlin.com>
Message-ID: <20161007152605.GA2815@localhost.localdomain>

Looks good. Thanks for working on this. I'm looking forward to seeing more CMB
code.

Acked-by Jon Derrick: <jonathan.derrick at intel.com>

On Wed, Oct 05, 2016@08:01:12PM -0600, Stephen Bates wrote:
> Add a sysfs attribute that contains salient information about the NVMe
> Controller Memory Buffer when one is present. For now, just display the
> information about the CMB available from the control registers. We attach
> the CMB attribute file to the existing nvme_ctrl sysfs group so it can
> handle the sysfs teardown.
> 
> Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
> Reviewed-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
> Signed-off-by: Stephen Bates <sbates at raithlin.com>
> ---
>  drivers/nvme/host/pci.c | 46 ++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 8dcf5a9..d4c7bac 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -99,6 +99,7 @@ struct nvme_dev {
>  	dma_addr_t cmb_dma_addr;
>  	u64 cmb_size;
>  	u32 cmbsz;
> +	u32 cmbloc;
>  	struct nvme_ctrl ctrl;
>  	struct completion ioq_wait;
>  };
> @@ -1321,28 +1322,37 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
>  	return ret >= 0 ? 0 : ret;
>  }
> 
> +static ssize_t nvme_cmb_show(struct device *dev,
> +			     struct device_attribute *attr,
> +			     char *buf)
> +{
> +	struct nvme_dev *ndev = to_nvme_dev(dev_get_drvdata(dev));
> +
> +	return snprintf(buf, PAGE_SIZE, "cmbloc : x%08x\ncmbsz  : x%08x\n",
> +		       ndev->cmbloc, ndev->cmbsz);
> +}
> +static DEVICE_ATTR(cmb, S_IRUGO, nvme_cmb_show, NULL);
> +
>  static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
>  {
>  	u64 szu, size, offset;
> -	u32 cmbloc;
>  	resource_size_t bar_size;
>  	struct pci_dev *pdev = to_pci_dev(dev->dev);
>  	void __iomem *cmb;
>  	dma_addr_t dma_addr;
> 
> -	if (!use_cmb_sqes)
> -		return NULL;
> -
>  	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
>  	if (!(NVME_CMB_SZ(dev->cmbsz)))
>  		return NULL;
> +	dev->cmbloc = readl(dev->bar + NVME_REG_CMBLOC);
> 
> -	cmbloc = readl(dev->bar + NVME_REG_CMBLOC);
> +	if (!use_cmb_sqes)
> +		return NULL;
> 
>  	szu = (u64)1 << (12 + 4 * NVME_CMB_SZU(dev->cmbsz));
>  	size = szu * NVME_CMB_SZ(dev->cmbsz);
> -	offset = szu * NVME_CMB_OFST(cmbloc);
> -	bar_size = pci_resource_len(pdev, NVME_CMB_BIR(cmbloc));
> +	offset = szu * NVME_CMB_OFST(dev->cmbloc);
> +	bar_size = pci_resource_len(pdev, NVME_CMB_BIR(dev->cmbloc));
> 
>  	if (offset > bar_size)
>  		return NULL;
> @@ -1355,7 +1365,7 @@ static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
>  	if (size > bar_size - offset)
>  		size = bar_size - offset;
> 
> -	dma_addr = pci_resource_start(pdev, NVME_CMB_BIR(cmbloc)) + offset;
> +	dma_addr = pci_resource_start(pdev, NVME_CMB_BIR(dev->cmbloc)) + offset;
>  	cmb = ioremap_wc(dma_addr, size);
>  	if (!cmb)
>  		return NULL;
> @@ -1642,9 +1652,25 @@ static int nvme_pci_enable(struct nvme_dev *dev)
>  			dev->q_depth);
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
> +		if (dev->cmbsz) {
> +			if (sysfs_add_file_to_group(&dev->ctrl.device->kobj,
> +						    &dev_attr_cmb.attr, NULL))
> +				dev_warn(dev->dev,
> +					 "failed to add sysfs attribute for CMB\n");
> +		}
> +	}
> +
>  	pci_enable_pcie_error_reporting(pdev);
>  	pci_save_state(pdev);
>  	return 0;
> --
> 2.1.4
