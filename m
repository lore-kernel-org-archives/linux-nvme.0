From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 28 Jun 2017 09:48:59 +0300
Subject: [PATCH for-4.12] nvme/pci: Fix stuck nvme reset
In-Reply-To: <20170627234019.GA13688@lst.de>
References: <1498607018-1277-1-git-send-email-keith.busch@intel.com>
 <20170627234019.GA13688@lst.de>
Message-ID: <327ad0bd-cd12-b606-b93f-3264ea2ebc1e@grimberg.me>


> Can you align this a little nicer:
> 
> 		if (dev->ctrl.state == NVME_CTRL_LIVE ||
> 		    dev->ctrl.state == NVME_CTRL_RESETTING)
> 
> Otherwise this looks fine:
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Same here,

Reviewed-by: Sagi Grimberg <sagi at grimbeg.me>
