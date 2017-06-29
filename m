From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 29 Jun 2017 14:09:05 +0300
Subject: [PATCH 0/7] Few patches extracted from the centralization set
Message-ID: <1498734552-14845-1-git-send-email-sagi@grimberg.me>

Feedback was that they made sense on their own.
Plus also few patches that I came up with.

The repetition of patches seem to highlight the fact that we
will benefit centralization of shared logic.

Sagi Grimberg (7):
  nvme: move queue_count to the nvme_ctrl
  nvme: move ctrl cap to struct nvme_ctrl
  nvme-pci: rename to nvme_pci_configure_admin_queue
  nvme-fc: don't override opts->nr_io_queues
  nvme-rdma: update tagset nr_hw_queues after reconnecting/resetting
  nvme-loop: update tagset nr_hw_queues after reconnecting/resetting
  nvme-fc: update tagset nr_hw_queues after queues reinit

 drivers/nvme/host/fc.c     | 55 ++++++++++++++++++++++++----------------------
 drivers/nvme/host/nvme.h   |  2 ++
 drivers/nvme/host/pci.c    | 37 ++++++++++++++-----------------
 drivers/nvme/host/rdma.c   | 55 +++++++++++++++++++++++++---------------------
 drivers/nvme/target/loop.c | 25 +++++++++++----------
 5 files changed, 91 insertions(+), 83 deletions(-)

-- 
2.7.4
