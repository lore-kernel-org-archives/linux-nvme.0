From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue,  4 Jul 2017 10:57:28 +0300
Subject: [PATCH v2 0/8] Few patches extracted from the centralization set
Message-ID: <1499155056-11241-1-git-send-email-sagi@grimberg.me>

Feedback was that they made sense on their own.
Plus also few patches that I came up with.

The repetition of patches seem to highlight the fact that we
will benefit centralization of shared logic.

Changes from v1:
- collected review tags
- take minimum of nr_io_queues and lport->max_hw_queues in nvme-fc
- added patch to reuse blk_mq_delay_run_hw_queue in nvme-fc 

Sagi Grimberg (8):
  nvme: move queue_count to the nvme_ctrl
  nvme: move ctrl cap to struct nvme_ctrl
  nvme-pci: rename to nvme_pci_configure_admin_queue
  nvme-fc: don't override opts->nr_io_queues
  nvme-rdma: update tagset nr_hw_queues after reconnecting/resetting
  nvme-loop: update tagset nr_hw_queues after reconnecting/resetting
  nvme-fc: update tagset nr_hw_queues after queues reinit
  nvme-fc: use blk_mq_delay_run_hw_queue instead of open-coding it

 drivers/nvme/host/fc.c     | 64 ++++++++++++++++++++++++----------------------
 drivers/nvme/host/nvme.h   |  2 ++
 drivers/nvme/host/pci.c    | 39 +++++++++++++---------------
 drivers/nvme/host/rdma.c   | 55 +++++++++++++++++++++------------------
 drivers/nvme/target/loop.c | 25 +++++++++---------
 5 files changed, 97 insertions(+), 88 deletions(-)

-- 
2.7.4
