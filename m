From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 13 Feb 2019 08:04:38 +0100
Subject: [GIT PULL] nvme fix for 5.0
Message-ID: <20190213070438.GA11528@infradead.org>

The following changes since commit aef1897cd36dcf5e296f1d2bae7e0d268561b685:

  blk-mq: insert rq with DONTPREP to hctx dispatch list when requeue (2019-02-11 19:51:52 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.0

for you to fetch changes up to 4726bcf30fad37cc555cd9dcd6c73f2b2668c879:

  nvme-pci: add missing unlock for reset error (2019-02-12 09:29:07 +0100)

----------------------------------------------------------------
Keith Busch (1):
      nvme-pci: add missing unlock for reset error

 drivers/nvme/host/pci.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)
