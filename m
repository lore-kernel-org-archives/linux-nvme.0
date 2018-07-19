From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 19 Jul 2018 15:28:34 +0200
Subject: [PATCH 0/4] Rework NVMe abort handling
Message-ID: <20180719132838.15556-1-jthumshirn@suse.de>

PCI currently is the only transport we have which is doing more than
queueing a transport reset but trying to abort the command first.

This series brings the other transports we currently have up to the
same level.

On FC we can prepend a third escalation level by first to abort the FC
operation before trying to abort the NVMe command.

Johannes Thumshirn (4):
  nvme: factor out pci abort handling into core
  nvme: rdma: abort commands before resetting controller
  nvmet: loop: abort commands before resetting controller
  nvme: fc: abort commands before resetting controller

 drivers/nvme/host/core.c   | 47 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/fc.c     |  9 +++++++
 drivers/nvme/host/nvme.h   |  1 +
 drivers/nvme/host/pci.c    | 61 +++++++++-------------------------------------
 drivers/nvme/host/rdma.c   | 22 ++++++++++++++---
 drivers/nvme/target/loop.c | 17 ++++++++++++-
 6 files changed, 104 insertions(+), 53 deletions(-)

-- 
2.16.4
