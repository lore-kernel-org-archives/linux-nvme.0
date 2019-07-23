From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 22 Jul 2019 17:06:51 -0700
Subject: [PATCH v2 0/3] small set of nvme cleanups
Message-ID: <20190723000654.6448-1-sagi@grimberg.me>

Centralizes queue size settings for fabrics and
removes redundant argument to nvme_disable/enable_ctrl.

Changes from v1:
- read cap register in nvme_enable_ctrl as it is referenced
  there first.

Sagi Grimberg (3):
  nvme: have nvme_init_identify set ctrl->cap
  nvme: move sqsize setting to the core
  nvme: don't pass cap to nvme_disable_ctrl

 drivers/nvme/host/core.c   | 29 +++++++++++++++--------------
 drivers/nvme/host/fc.c     | 12 +-----------
 drivers/nvme/host/nvme.h   |  4 ++--
 drivers/nvme/host/pci.c    |  7 ++++---
 drivers/nvme/host/rdma.c   | 15 ++-------------
 drivers/nvme/host/tcp.c    | 13 ++-----------
 drivers/nvme/target/loop.c | 12 +-----------
 7 files changed, 27 insertions(+), 65 deletions(-)

-- 
2.17.1
