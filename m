From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 11 Jul 2019 13:20:31 +0200
Subject: [GIT PULL] nvme updates for 5.3
Message-ID: <20190711112031.GA5031@infradead.org>


Lof of fixes all over the place, and two very minor features that
were in the nvme tree by the end of the merge window, but hadn't made
it out to Jens yet.


The following changes since commit c9b3007feca018d3f7061f5d5a14cb00766ffe9b:

  blk-iolatency: fix STS_AGAIN handling (2019-07-05 15:14:00 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.3

for you to fetch changes up to 420dc733f980246f2179e0144f9cedab9ad4a91e:

  nvme: fix regression upon hot device removal and insertion (2019-07-10 09:36:16 -0700)

----------------------------------------------------------------
Alan Mikhak (2):
      nvme-pci: don't create a read hctx mapping without read queues
      nvme-pci: check for NULL return from pci_alloc_p2pmem()

Bart Van Assche (3):
      nvmet: export I/O characteristics attributes in Identify
      nvme: add I/O characteristics fields
      nvme: set physical block size and optimal I/O size

Christoph Hellwig (2):
      nvme-pci: don't fall back to a 32-bit DMA mask
      nvme-pci: limit max_hw_sectors based on the DMA max mapping size

Colin Ian King (1):
      nvme-trace: fix spelling mistake "spcecific" -> "specific"

Hannes Reinecke (3):
      nvme-multipath: factor out a nvme_path_is_disabled helper
      nvme-multipath: also check for a disabled path if there is a single sibling
      nvme-multipath: do not select namespaces which are about to be removed

James Smart (3):
      nvme-fcloop: fix inconsistent lock state warnings
      nvme-fcloop: resolve warnings on RCU usage and sleep warnings
      nvme-fc: fix module unloads while lports still pending

Mikhail Skorzhinskii (3):
      nvmet: print a hint while rejecting NSID 0 or 0xffffffff
      nvme-tcp: set the STABLE_WRITES flag when data digests are enabled
      nvme-tcp: don't use sendpage for SLAB pages

Sagi Grimberg (1):
      nvme: fix regression upon hot device removal and insertion

Tom Wu (1):
      nvme-trace: add delete completion and submission queue to admin cmds tracer

YueHaibing (1):
      nvme-pci: make nvme_dev_pm_ops static

 drivers/nvme/host/core.c          | 43 ++++++++++++++++++++++++++++++---
 drivers/nvme/host/fc.c            | 51 ++++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/multipath.c     | 18 ++++++++++----
 drivers/nvme/host/nvme.h          |  1 +
 drivers/nvme/host/pci.c           | 26 ++++++++++++--------
 drivers/nvme/host/tcp.c           |  9 ++++++-
 drivers/nvme/host/trace.c         | 28 ++++++++++++++++++++-
 drivers/nvme/target/admin-cmd.c   |  3 +++
 drivers/nvme/target/configfs.c    |  4 ++-
 drivers/nvme/target/fcloop.c      | 44 ++++++++++++++++-----------------
 drivers/nvme/target/io-cmd-bdev.c | 39 ++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h       |  8 ++++++
 drivers/nvme/target/trace.c       |  2 +-
 include/linux/nvme.h              | 12 ++++++---
 14 files changed, 237 insertions(+), 51 deletions(-)
