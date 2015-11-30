From: hch@lst.de (Christoph Hellwig)
Date: Mon, 30 Nov 2015 09:36:10 +0100
Subject: NVMe driver split for Linux 4.5
Message-ID: <1448872593-4096-1-git-send-email-hch@lst.de>

This series contains a the split of the NVMe driver into a common core part
and a PCIe specific fontend.
nvme driver split to show how I want to get started.

To make testing easier I've pushed out a git tree with this and all
dependencies:

    git://git.infradead.org/users/hch/block.git nvme-split.6

or in gitweb:

    http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/nvme-split.6

Chances since the previous post from the patchbomb:
  - use vendor ID from Identify data in the SCSI translation layer
  - add common enable/shutdown code from the NVMe loop series
