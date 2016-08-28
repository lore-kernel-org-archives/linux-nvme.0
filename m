From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 28 Aug 2016 16:09:56 +0300
Subject: [GIT PULL] another round of fabrics fixes for the next 4.8-rc
Message-ID: <1472389796-1868-1-git-send-email-sagi@grimberg.me>

Hey Jens,

Mostly stability fixes and cleanups:
- NQN endianess fix from Daniel
- possible use-after-free fix from Vincent
- nvme-rdma connect semantics fixes from Jay
- Remove redundant variables in rdma driver
- Kbuild fix from Christoph
- nvmf_host referencing fix from Christoph
- uninit variable fix from Colin


please pull from:

  git://git.infradead.org/nvme-fabrics.git nvmf-4.8-rc


----------------------------------------------------------------
Christoph Hellwig (2):
      nvme-fabrics: get a reference when reusing a nvme_host structure
      nvme: fabrics drivers don't need the nvme-pci driver

Colin Ian King (1):
      nvme-rdma: initialize ret to zero to avoid returning garbage

Daniel Verkamp (1):
      nvme-fabrics: change NQN UUID to big-endian format

Jay Freyensee (4):
      nvmet-rdma: +1 to *queue_size from hsqsize/hrqsize
      fabrics: define admin sqsize min default, per spec
      nvme-rdma: fix sqsize/hsqsize per spec
      nvme-loop: set sqsize to 0-based value, per spec

Sagi Grimberg (2):
      nvme-rdma: Get rid of duplicate variable
      nvme-rdma: Get rid of redundant defines

Vincent Stehl? (1):
      nvmet-rdma: Fix use after free

 drivers/nvme/host/Kconfig   |  2 +-
 drivers/nvme/host/fabrics.c | 23 ++++++++++++++++-------
 drivers/nvme/host/fabrics.h |  2 +-
 drivers/nvme/host/rdma.c    | 46 +++++++++++++++++++++++++++------------------
 drivers/nvme/target/Kconfig |  2 +-
 drivers/nvme/target/loop.c  |  4 ++--
 drivers/nvme/target/rdma.c  |  7 ++++---
 include/linux/nvme.h        |  2 +-
 8 files changed, 54 insertions(+), 34 deletions(-)
