From: hch@lst.de (Christoph Hellwig)
Date: Thu, 23 Feb 2017 16:16:54 +0100
Subject: [PATCH 5/5] nvme/pci: Complete all stuck requests
In-Reply-To: <20170223152140.GA5196@localhost.localdomain>
References: <1486768553-13738-1-git-send-email-keith.busch@intel.com>
 <1486768553-13738-6-git-send-email-keith.busch@intel.com>
 <20170217152713.GA27158@lst.de>
 <20170217163328.GC18275@localhost.localdomain>
 <20170220100515.GA20285@lst.de> <20170221155703.GA4619@localhost.localdomain>
 <20170222071754.GA17709@lst.de> <20170222144510.GB1362@localhost.localdomain>
 <20170223150651.GA3178@lst.de> <20170223152140.GA5196@localhost.localdomain>
Message-ID: <20170223151654.GA3328@lst.de>

On Thu, Feb 23, 2017@10:21:40AM -0500, Keith Busch wrote:
> I thought this would be non-obvious, so I put this detailed commend just
> before the unfreeze:
> 
> 	/*
> 	 * Waiting for frozen increases the freeze depth. Since we
> 	 * already start the freeze earlier in this function to stop
> 	 * incoming requests, we have to unfreeze after froze to get
> 	 * the depth back to the desired.
> 	 */
> 
> Assuming we are starting with a freeze depth of 0, the nvme_start_freeze
> gets us to 1. Then nvme_wait_freeze increases the freeze depth to 2
> (blk_mq_freeze_wait is not exported),

Oooh.  I didn't spot nvme_wait_freeze did not actually call
blk_mq_freeze_queue_wait.  Let's start by exporting that and beating
some sense into the sequence.
