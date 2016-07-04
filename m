From: tglx@linutronix.de (Thomas Gleixner)
Date: Mon, 4 Jul 2016 12:30:05 +0200 (CEST)
Subject: automatic interrupt affinity for MSI/MSI-X capable devices V3
In-Reply-To: <1467621574-8277-1-git-send-email-hch@lst.de>
References: <1467621574-8277-1-git-send-email-hch@lst.de>
Message-ID: <alpine.DEB.2.11.1607041227340.4083@nanos>

On Mon, 4 Jul 2016, Christoph Hellwig wrote:

> This series enhances the irq and PCI code to allow spreading around MSI and
> MSI-X vectors so that they have per-cpu affinity if possible, or at least
> per-node.  For that it takes the algorithm from blk-mq, moves it to
> a common place, and makes it available through a vastly simplified PCI
> interrupt allocation API.  It then switches blk-mq to be able to pick up
> the queue mapping from the device if available, and demonstrates all this
> using the NVMe driver.
> 
> Compared to the last posting the core IRQ changes are stable and it would
> be great to get them merged int the tip tree.  The two PCI patches have
> been completely rewritten after feedback from Alexander, while the block
> changes have also been stable.

I applied the first 6 patches. They are available in a seperate branch:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq/for-block

and integrated into the irq/core branch. irq/for-block can be pulled from the
block folks if required.

Thanks,

	tglx
