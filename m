From: keith.busch@intel.com (Keith Busch)
Date: Wed, 28 Mar 2018 14:38:03 -0600
Subject: [PATCH 3/3] nvme-pci: Separate IO and admin queue IRQ vectors
In-Reply-To: <20180328073214.GA18726@lst.de>
References: <20180327153908.3732-1-keith.busch@intel.com>
 <20180327153908.3732-3-keith.busch@intel.com>
 <20180328073214.GA18726@lst.de>
Message-ID: <20180328203803.GL13039@localhost.localdomain>

On Wed, Mar 28, 2018@09:32:14AM +0200, Christoph Hellwig wrote:
> On Tue, Mar 27, 2018@09:39:08AM -0600, Keith Busch wrote:
> > -	return blk_mq_pci_map_queues(set, to_pci_dev(dev->dev), 0);
> > +	return blk_mq_pci_map_queues(set, to_pci_dev(dev->dev),
> > +				     dev->num_vecs > 1);
> 
> Can you turn this into:
> 
> -	return blk_mq_pci_map_queues(set, to_pci_dev(dev->dev), 0);
> 			     dev->num_vecs > 1 ? 1 /* admin queue */ : 0);
> 
> no functional change, but much easier to understand.
> 
> Except for that the whole series looks good:

Sounds good, thanks for the reviews, Christoph and Ming.

Updated with your suggestion and applied (Jens picked up the blk-mq part;
nvme-4.17 is rebased to that).
