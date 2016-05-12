From: hch@lst.de (Christoph Hellwig)
Date: Thu, 12 May 2016 13:04:29 +0200
Subject: [PATCH 1/2] PCI: Provide sensible irq vector alloc/free routines
In-Reply-To: <20160512110456.GA8681@agordeev.lab.eng.brq.redhat.com>
References: <1462457096-19795-1-git-send-email-hch@lst.de>
 <1462457096-19795-2-git-send-email-hch@lst.de>
 <20160512110456.GA8681@agordeev.lab.eng.brq.redhat.com>
Message-ID: <20160512110429.GA9352@lst.de>

On Thu, May 12, 2016@01:04:58PM +0200, Alexander Gordeev wrote:
> Because MSI vectors are allocated sequentially we do not really
> need pdev->irqs[] for MSI. It is 32 items at most, but still.

The allocator itself doesn't "need" it.  Any driver that doesn't want
to special case MSI vs MSI-X all through the code needs it, though.


(oh, and please don't full quote the whole email, thank you!)
