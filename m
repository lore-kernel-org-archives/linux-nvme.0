From: keith.busch@intel.com (Keith Busch)
Date: Thu, 23 Feb 2017 10:21:40 -0500
Subject: [PATCH 5/5] nvme/pci: Complete all stuck requests
In-Reply-To: <20170223150651.GA3178@lst.de>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
 <1486768553-13738-6-git-send-email-keith.busch@intel.com>
 <20170217152713.GA27158@lst.de>
 <20170217163328.GC18275@localhost.localdomain>
 <20170220100515.GA20285@lst.de>
 <20170221155703.GA4619@localhost.localdomain>
 <20170222071754.GA17709@lst.de>
 <20170222144510.GB1362@localhost.localdomain>
 <20170223150651.GA3178@lst.de>
Message-ID: <20170223152140.GA5196@localhost.localdomain>

On Thu, Feb 23, 2017@04:06:51PM +0100, Christoph Hellwig wrote:
> I still don't understand it.  nvme_dev_disable has no early return,
> and it does the nvme_start_freeze, nvme_wait_freeze and nvme_unfreeze
> calls under exactly the same conditionals:
> 
> 	if (drain_queue) {
> 		if (shutdown)
> 			nvme_start_freeze(&dev->ctrl);
> 		nvme_stop_queues(&dev->ctrl);
> 		...
> 	}
> 
> 	..
> 
> 	if (drain_queue && shutdown) {
> 		nvme_start_queues(&dev->ctrl);
> 		nvme_wait_freeze(&dev->ctrl);
> 		nvme_unfreeze(&dev->ctrl);
> 		nvme_stop_queues(&dev->ctrl);
> 	}
> 
> so where is the pairing for the unfreeze in nvme_reset_work
> coming from?

I thought this would be non-obvious, so I put this detailed commend just
before the unfreeze:

	/*
	 * Waiting for frozen increases the freeze depth. Since we
	 * already start the freeze earlier in this function to stop
	 * incoming requests, we have to unfreeze after froze to get
	 * the depth back to the desired.
	 */

Assuming we are starting with a freeze depth of 0, the nvme_start_freeze
gets us to 1. Then nvme_wait_freeze increases the freeze depth to 2
(blk_mq_freeze_wait is not exported), so we need to unfreeze after frozen
to get us back to 1. Then the nvme_reset_work does the final unfreeze
to get the depth back to 0 so new requests may enter.
