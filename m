From: hch@lst.de (Christoph Hellwig)
Date: Wed, 28 Mar 2018 09:32:14 +0200
Subject: [PATCH 3/3] nvme-pci: Separate IO and admin queue IRQ vectors
In-Reply-To: <20180327153908.3732-3-keith.busch@intel.com>
References: <20180327153908.3732-1-keith.busch@intel.com>
 <20180327153908.3732-3-keith.busch@intel.com>
Message-ID: <20180328073214.GA18726@lst.de>

On Tue, Mar 27, 2018@09:39:08AM -0600, Keith Busch wrote:
> -	return blk_mq_pci_map_queues(set, to_pci_dev(dev->dev), 0);
> +	return blk_mq_pci_map_queues(set, to_pci_dev(dev->dev),
> +				     dev->num_vecs > 1);

Can you turn this into:

-	return blk_mq_pci_map_queues(set, to_pci_dev(dev->dev), 0);
			     dev->num_vecs > 1 ? 1 /* admin queue */ : 0);

no functional change, but much easier to understand.

Except for that the whole series looks good:

Reviewed-by: Christoph Hellwig <hch at lst.de>
