From: hch@lst.de (Christoph Hellwig)
Date: Mon, 20 Feb 2017 11:05:15 +0100
Subject: [PATCH 5/5] nvme/pci: Complete all stuck requests
In-Reply-To: <20170217163328.GC18275@localhost.localdomain>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
 <1486768553-13738-6-git-send-email-keith.busch@intel.com>
 <20170217152713.GA27158@lst.de>
 <20170217163328.GC18275@localhost.localdomain>
Message-ID: <20170220100515.GA20285@lst.de>

> > > +		 * If we are resuming from suspend, the queue was set to freeze
> > > +		 * to prevent blk-mq's hot CPU notifier from getting stuck on
> > > +		 * requests that entered the queue that NVMe had quiesced. Now
> > > +		 * that we are resuming and have notified blk-mq of the new h/w
> > > +		 * context queue count, it is safe to unfreeze the queues.
> > > +		 */
> > > +		if (was_suspend)
> > > +			nvme_unfreeze(&dev->ctrl);
> > 
> > And this change I don't understand at all.  It doesn't seem to pair
> > up with anything else in the patch.
> 
> If we had done a controller shutdown, as would happen on a system suspend,
> the resume needs to restore the queue freeze depth. That's all this
> is doing.

I've spent tons of times trying to understand this, but still fail
to.  Where is the nvme_start_freeze / nvme_wait_freeze that this
pairs with?
