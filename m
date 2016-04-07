From: keith.busch@intel.com (Keith Busch)
Date: Thu, 7 Apr 2016 14:24:50 +0000
Subject: [PATCH] Avoid reset work on watchdog timer function during
 error recovery
In-Reply-To: <20160407131131.GA2063@infradead.org>
References: <1459974635-16178-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
 <20160407131131.GA2063@infradead.org>
Message-ID: <20160407142449.GA9586@localhost.localdomain>

On Thu, Apr 07, 2016@06:11:31AM -0700, Christoph Hellwig wrote:
> static bool nvme_should_reset(struct nvme_dev *dev)
> {
> 	u32 csts = readl(dev->bar + NVME_REG_CSTS);
> 
> 	if (!(csts & NVME_CSTS_CFS) &&
> 	    !((dev->subsystem && (csts & NVME_CSTS_NSSRO))))
> 		return false;
> 
> 	if (work_pending(&dev->reset_work))
> 		return false;
> 	if (work_busy(&dev->reset_work))
> 		return false;

We could also skip checking work_pending since work_busy does that for us.
