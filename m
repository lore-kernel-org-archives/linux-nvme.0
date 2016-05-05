From: hch@lst.de (Christoph Hellwig)
Date: Thu,  5 May 2016 16:04:54 +0200
Subject: PCI: Provide sensible irq vector alloc/free routines
Message-ID: <1462457096-19795-1-git-send-email-hch@lst.de>

Hi Bjorn,

find my revisted patch for the MSI-X allocator API.  There has been
some rework to use lower level APIs now that it has been moved to
msi.c.  The second patch converts nvme over to it.  If Keith and Jens
are fine with merging it through the PCI tree I'd be all for it,
if not we'll either need a common branch for it, or just defer it
until the next merge window.
