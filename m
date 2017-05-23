From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 23 May 2017 18:44:17 +0300
Subject: [PATCH v2] nvme/pci: remap BAR0 to cover admin CQ doorbell for
 large stride
In-Reply-To: <1495429761-19820-1-git-send-email-yu.a.xu@intel.com>
References: <1495429761-19820-1-git-send-email-yu.a.xu@intel.com>
Message-ID: <ab162e65-c20c-c88d-7f00-f2d7d5570291@mellanox.com>

Hi,

>
> +static unsigned long db_bar_size(struct nvme_dev *dev, unsigned nr_io_queues)
> +{
> +	return NVME_REG_DBS + ((nr_io_queues + 1) * 8 * dev->db_stride);
> +}
> +
> +static int nvme_remap_bar(struct nvme_dev *dev, unsigned long size)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev->dev);
> +
> +	if (size <= dev->bar_mapped_size)
> +		return 0;
> +	if (dev->bar)
> +		iounmap(dev->bar);
> +	dev->bar = ioremap(pci_resource_start(pdev, 0), size);

if we are here, shouldn't we save the result of pci_resource_start(pdev, 
0) instead of calling it over and over again ?


> +	if (!dev->bar) {
> +		dev->bar_mapped_size = 0;
> +		return -ENOMEM;
> +	}
> +	dev->bar_mapped_size = size;
> +	dev->dbs = dev->bar + NVME_REG_DBS;
> +
> +	return 0;
> +}
> +
