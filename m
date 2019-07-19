From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 19 Jul 2019 12:45:42 -0700
Subject: [PATCH 0/4] small set of nvme cleanups
Message-ID: <20190719194546.24229-1-sagi@grimberg.me>

Centralizes queue size settings for fabrics and
removes redundant argument to nvme_disable/enable_ctrl.

Sagi Grimberg (4):
  nvme: have nvme_init_identify set ctrl->cap
  nvme: move sqsize setting to the core
  nvme: don't pass cap to nvme_disable_ctrl
  nvme: don't pass cap to nvme_enable_ctrl

 drivers/nvme/host/core.c   | 19 ++++++++++---------
 drivers/nvme/host/fc.c     | 12 +-----------
 drivers/nvme/host/nvme.h   |  4 ++--
 drivers/nvme/host/pci.c    |  7 ++++---
 drivers/nvme/host/rdma.c   | 15 ++-------------
 drivers/nvme/host/tcp.c    | 13 ++-----------
 drivers/nvme/target/loop.c | 12 +-----------
 7 files changed, 22 insertions(+), 60 deletions(-)

-- 
2.17.1
