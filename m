From: hch@lst.de (Christoph Hellwig)
Date: Mon, 29 Aug 2016 12:53:26 +0200
Subject: blk-mq: allow passing in an external queue mapping V2
Message-ID: <1472468013-29936-1-git-send-email-hch@lst.de>

This series is one third of the earlier "automatic interrupt affinity for
MSI/MSI-X capable devices" series, and make uses of the new irq-level
interrupt / queue mapping code in blk-mq, as well as allowing the driver
to pass in such a mask obtained from the (PCI) interrupt code.  To fully
support this feature in drivers the final third in the PCI layer will
be needed as well.

Note that these patches are on top of Linux 4.8-rc4 and will need several
patches not yet in the block for-4.9 branch.

A git tree is available at:

   git://git.infradead.org/users/hch/block.git block-queue-mapping

Gitweb:

   http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/block-queue-mapping

Changes since V1:
 - rebased on top of Linux 4.8-rc4

Changes since automatic interrupt affinity for MSI/MSI-X capable devices V3:
 - a trivial cleanup in blk_mq_create_mq_map pointed out by Alexander
