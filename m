From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 13 Sep 2016 16:34:54 +0300
Subject: [GIT PULL] yet another round of fabrics fixes for the next 4.8-rc
Message-ID: <1473773694-17296-1-git-send-email-sagi@grimberg.me>

Hey Jens,

Here we have:
- Kconfig dependencies fix from Arnd
- nvme-rdma device removal fixes from Steve
- possible bad deref fix from Colin

please pull (again) from:

  git://git.infradead.org/nvme-fabrics.git nvmf-4.8-rc

----------------------------------------------------------------
Arnd Bergmann (1):
      nvme-rdma: add back dependency on CONFIG_BLOCK

Colin Ian King (1):
      nvme-rdma: fix null pointer dereference on req->mr

Sagi Grimberg (1):
      nvme-rdma: add DELETING queue flag

Steve Wise (5):
      iw_cxgb4: call dev_put() on l2t allocation failure
      iw_cxgb4: block module unload until all ep resources are released
      nvme_rdma: keep a ref on the ctrl during delete/flush
      nvme-rdma: destroy nvme queue rdma resources on connect failure
      nvme-rdma: use ib_client API to detect device removal

 drivers/infiniband/hw/cxgb4/cm.c       |   6 +-
 drivers/infiniband/hw/cxgb4/device.c   |   5 ++
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h |   1 +
 drivers/nvme/host/Kconfig              |   1 +
 drivers/nvme/host/rdma.c               | 144 ++++++++++++++++-----------------
 5 files changed, 83 insertions(+), 74 deletions(-)
