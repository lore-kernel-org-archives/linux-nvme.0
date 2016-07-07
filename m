From: agordeev@redhat.com (Alexander Gordeev)
Date: Thu, 7 Jul 2016 21:30:19 +0200
Subject: [PATCH 12/13] nvme: switch to use pci_alloc_irq_vectors
In-Reply-To: <1467621574-8277-13-git-send-email-hch@lst.de>
References: <1467621574-8277-1-git-send-email-hch@lst.de>
 <1467621574-8277-13-git-send-email-hch@lst.de>
Message-ID: <20160707193019.GA8802@dhcp-27-118.brq.redhat.com>

On Mon, Jul 04, 2016@05:39:33PM +0900, Christoph Hellwig wrote:
> @@ -1575,6 +1546,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
>  		dev->tagset.cmd_size = nvme_cmd_size(dev);
>  		dev->tagset.flags = BLK_MQ_F_SHOULD_MERGE;
>  		dev->tagset.driver_data = dev;
> +		dev->tagset.affinity_mask = to_pci_dev(dev->dev)->irq_affinity;
>  
>  		if (blk_mq_alloc_tag_set(&dev->tagset))
>  			return 0;

Are there any post-init uses of blk_mq_tag_set::affinity_mask other than
calling to blk_mq_alloc_tag_set()? If no, blk_mq_tag_set::affinity_mask
is redundant, since the mask could be passed as a parameter.
