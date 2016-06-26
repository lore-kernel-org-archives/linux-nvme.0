From: agordeev@redhat.com (Alexander Gordeev)
Date: Sun, 26 Jun 2016 21:40:23 +0200
Subject: automatic interrupt affinity for MSI/MSI-X capable devices V2
In-Reply-To: <1465934346-20648-1-git-send-email-hch@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
Message-ID: <20160626194023.GB20915@agordeev.lab.eng.brq.redhat.com>

On Tue, Jun 14, 2016@09:58:53PM +0200, Christoph Hellwig wrote:
> This series enhances the irq and PCI code to allow spreading around MSI and
> MSI-X vectors so that they have per-cpu affinity if possible, or at least
> per-node.  For that it takes the algorithm from blk-mq, moves it to
> a common place, and makes it available through a vastly simplified PCI
> interrupt allocation API.  It then switches blk-mq to be able to pick up
> the queue mapping from the device if available, and demonstrates all this
> using the NVMe driver.

Hi Christoph,

One general comment. As result of this series there will be
three locations to store/point to affinities: IRQ descriptor,
MSI descriptor and PCI device descriptor.

IRQ and MSI descriptors merely refer to duplicate masks while
the PCI device mask is the sum of all its MSI interrupts' masks.

Besides, MSI descriptors and PCI device affinity masks are only
used just once - at MSI initialization.

Overall, it looks like some cleanup is possible here.
