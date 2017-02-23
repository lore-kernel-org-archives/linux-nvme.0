From: hch@lst.de (Christoph Hellwig)
Date: Thu, 23 Feb 2017 16:06:51 +0100
Subject: [PATCH 5/5] nvme/pci: Complete all stuck requests
In-Reply-To: <20170222144510.GB1362@localhost.localdomain>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
 <1486768553-13738-6-git-send-email-keith.busch@intel.com>
 <20170217152713.GA27158@lst.de>
 <20170217163328.GC18275@localhost.localdomain>
 <20170220100515.GA20285@lst.de> <20170221155703.GA4619@localhost.localdomain>
 <20170222071754.GA17709@lst.de> <20170222144510.GB1362@localhost.localdomain>
Message-ID: <20170223150651.GA3178@lst.de>

On Wed, Feb 22, 2017@09:45:11AM -0500, Keith Busch wrote:
> > with your five patches applied and there is no suspend argument anywhere
> > in pci.c.
> 
> Err, I meant 'shutdown == true' for nvme_dev_disable, not suspend. That's
> in the nvme tree. The part that isn't is the tree is the 'was_suspend' in
> nvme_reset_work. That was part of the opal series directly in Jens' tree.

I still don't understand it.  nvme_dev_disable has no early return,
and it does the nvme_start_freeze, nvme_wait_freeze and nvme_unfreeze
calls under exactly the same conditionals:

	if (drain_queue) {
		if (shutdown)
			nvme_start_freeze(&dev->ctrl);
		nvme_stop_queues(&dev->ctrl);
		...
	}

	..

	if (drain_queue && shutdown) {
		nvme_start_queues(&dev->ctrl);
		nvme_wait_freeze(&dev->ctrl);
		nvme_unfreeze(&dev->ctrl);
		nvme_stop_queues(&dev->ctrl);
	}

so where is the pairing for the unfreeze in nvme_reset_work
coming from?
