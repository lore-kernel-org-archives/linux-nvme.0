From: hch@lst.de (Christoph Hellwig)
Date: Wed, 28 Jun 2017 01:40:19 +0200
Subject: [PATCH for-4.12] nvme/pci: Fix stuck nvme reset
In-Reply-To: <1498607018-1277-1-git-send-email-keith.busch@intel.com>
References: <1498607018-1277-1-git-send-email-keith.busch@intel.com>
Message-ID: <20170627234019.GA13688@lst.de>

On Tue, Jun 27, 2017@07:43:38PM -0400, Keith Busch wrote:
> The controller state is set to resetting prior to disabling the
> controller, so this patch accounts for that state when deciding if it
> needs to freeze the queues. Without this, an 'nvme reset /dev/nvme0'
> blocks forever because the queues were never frozen.

Ouch.

> -		if (dev->ctrl.state == NVME_CTRL_LIVE)
> +		if (dev->ctrl.state == NVME_CTRL_LIVE ||
> +				dev->ctrl.state == NVME_CTRL_RESETTING)

Can you align this a little nicer:

		if (dev->ctrl.state == NVME_CTRL_LIVE ||
		    dev->ctrl.state == NVME_CTRL_RESETTING)

Otherwise this looks fine:

Reviewed-by: Christoph Hellwig <hch at lst.de>

Maybe Jens should pick this up directly for the block tree?  No
point in a nvme pull request just for this.
