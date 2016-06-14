From: hch@lst.de (Christoph Hellwig)
Date: Tue, 14 Jun 2016 21:58:53 +0200
Subject: automatic interrupt affinity for MSI/MSI-X capable devices V2
Message-ID: <1465934346-20648-1-git-send-email-hch@lst.de>

This series enhances the irq and PCI code to allow spreading around MSI and
MSI-X vectors so that they have per-cpu affinity if possible, or at least
per-node.  For that it takes the algorithm from blk-mq, moves it to
a common place, and makes it available through a vastly simplified PCI
interrupt allocation API.  It then switches blk-mq to be able to pick up
the queue mapping from the device if available, and demonstrates all this
using the NVMe driver.

There also is a git tree available at:

   git://git.infradead.org/users/hch/block.git

Gitweb:

   http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/msix-spreading.4

Changes since V1:
 - irq core improvements to properly assign the affinity before
   request_irq (tglx)
 - better handling of the MSI vs MSI-X differences in the low level
   MSI allocator (hch and tglx)
 - various improvements to pci_alloc_irq_vectors (hch)
 - remove blk-mq hardware queue reassigned on hotplug cpu events (hch)
 - forward ported to Jens' current for-next tree (hch)
