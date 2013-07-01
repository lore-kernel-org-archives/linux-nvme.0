From: willy@linux.intel.com (Matthew Wilcox)
Date: Mon, 1 Jul 2013 17:00:16 -0400
Subject: [PATCH] NVMe: handle ioremap failure
In-Reply-To: <1372695820-30841-1-git-send-email-keith.busch@intel.com>
References: <1372695820-30841-1-git-send-email-keith.busch@intel.com>
Message-ID: <20130701210016.GB30142@linux.intel.com>

On Mon, Jul 01, 2013@10:23:40AM -0600, Keith Busch wrote:
> Decrement the number of queues required for doorbell remapping until
> the memory is successfully mapped for that size.

Cool, thanks!

> -		dev->bar = ioremap(pci_resource_start(pdev, 0), db_bar_size);
> +		while (nr_io_queues > 0) {
> +			dev->bar = ioremap(pci_resource_start(pdev, 0), db_bar_size);
*cough* *checkpatch* *line length*
> +			if (!dev->bar)
> +				nr_io_queues--;
> +			else
> +				break;

I think this might more naturally be written as:

			dev->bar = ioremap(pci_resource_start(pdev, 0),
								db_bar_size);
			if (dev->bar)
				break;

			nr_io_queues--;
> +			db_bar_size = 4096 + ((nr_io_queues + 1) << (dev->db_stride + 3));
> +		}
> +		if (!dev->bar)
> +			return -ENOMEM;
> +

Although maybe we should instead redo the entire thing as ...

static size_t db_bar_size(struct nvme_dev *dev, unsigned nr_io_queues)
{
	return 4096 + ((nr_io_queues + 1) << (dev->db_stride + 3));
}

	size = db_bar_size(dev, nr_io_queues);
	if (size > 8192) {
		iounmap(dev->bar);
		do {
			dev->bar = ioremap(pci_resource_start(pdev, 0), size);
			if (dev->bar)
				break;
			if (!--nr_io_queues)
				return -ENOMEM;
			size = db_bar_size(dev, --nr_io_queues);
		} while (1);
		dev->dbs = ((void __iomem *)dev->bar) + 4096;
		dev->queues[0]->q_db = dev->dbs;
	}

Although, now I'm wondering whether we free_irq() the admin queue exactly
the right number of times.  We might need to set ->queue_count to -1
while we've called free_irq() on the admin queue ... but then we'll need
to handle the queue memory freeing correctly.  Awkward ...
