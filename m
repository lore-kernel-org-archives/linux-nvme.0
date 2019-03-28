From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 28 Mar 2019 18:19:28 +0100
Subject: [GIT PULL] nvme fixes for 5.1
Message-ID: <20190328171928.GA26641@infradead.org>

A few accumulated small fixes:

 - fix an endianess misannotation that sneaked in this merge window in
   nvme-tcp (me)
 - fix nvme-loop to handle multi-page segments (Ming)
 - fix error handling in the nvmet configfs code (Max)
 - add a missing requeue point in the multipath code (Martin George)

The following changes since commit dd08a8d9a66de4b54575c294a92630299f7e0fe7:

  libata: fix using DMA buffers on stack (2019-03-28 08:16:04 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.1

for you to fetch changes up to a536b49785759bf99465fdf6e248d34322123fcd:

  nvmet: fix error flow during ns enable (2019-03-28 18:15:03 +0100)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme-tcp: fix an endianess miss-annotation

Martin George (1):
      nvme-multipath: relax ANA state check

Max Gurtovoy (1):
      nvmet: fix error flow during ns enable

Ming Lei (1):
      nvmet: fix building bvec from sg list

 drivers/nvme/host/multipath.c     |  5 +----
 drivers/nvme/host/tcp.c           |  2 +-
 drivers/nvme/target/core.c        |  4 ++--
 drivers/nvme/target/io-cmd-file.c | 20 ++++++++++----------
 4 files changed, 14 insertions(+), 17 deletions(-)
