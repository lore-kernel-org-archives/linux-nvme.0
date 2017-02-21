From: keith.busch@intel.com (Keith Busch)
Date: Tue, 21 Feb 2017 10:57:04 -0500
Subject: [PATCH 5/5] nvme/pci: Complete all stuck requests
In-Reply-To: <20170220100515.GA20285@lst.de>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
 <1486768553-13738-6-git-send-email-keith.busch@intel.com>
 <20170217152713.GA27158@lst.de>
 <20170217163328.GC18275@localhost.localdomain>
 <20170220100515.GA20285@lst.de>
Message-ID: <20170221155703.GA4619@localhost.localdomain>

On Mon, Feb 20, 2017@11:05:15AM +0100, Christoph Hellwig wrote:
> > > > +		 * If we are resuming from suspend, the queue was set to freeze
> > > > +		 * to prevent blk-mq's hot CPU notifier from getting stuck on
> > > > +		 * requests that entered the queue that NVMe had quiesced. Now
> > > > +		 * that we are resuming and have notified blk-mq of the new h/w
> > > > +		 * context queue count, it is safe to unfreeze the queues.
> > > > +		 */
> > > > +		if (was_suspend)
> > > > +			nvme_unfreeze(&dev->ctrl);
> > > 
> > > And this change I don't understand at all.  It doesn't seem to pair
> > > up with anything else in the patch.
> > 
> > If we had done a controller shutdown, as would happen on a system suspend,
> > the resume needs to restore the queue freeze depth. That's all this
> > is doing.
> 
> I've spent tons of times trying to understand this, but still fail
> to.  Where is the nvme_start_freeze / nvme_wait_freeze that this
> pairs with?

This is for suspend/resume. The freeze start is done during the suspend
phase, and the unfreeze on resume. Power management calls nvme_suspend,
which calls nvme_dev_disable with 'suspend == true', and that sets the
freeze depth. Power management later calls nvme_resume, which queues
the reset work that will observe 'was_suspend == true', and that pairs
the unfreeze.
