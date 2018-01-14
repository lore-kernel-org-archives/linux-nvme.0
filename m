From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 14 Jan 2018 12:38:59 +0200
Subject: [PATCH resend 0/3] couple of nvme patches resend
Message-ID: <20180114103902.6413-1-sagi@grimberg.me>

Seems these got positive feedback (informally) but were left behind..

Roy Shterman (1):
  nvme-core/loop/rdma: Host delete_work and reset_work on separate
    workqueues

Sagi Grimberg (2):
  nvme-pci: serialize pci resets
  nvme-pci: allocate device queues storage space at probe

 drivers/nvme/host/core.c   | 47 ++++++++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h   |  3 +++
 drivers/nvme/host/pci.c    | 65 +++++++++++++++++++---------------------------
 drivers/nvme/host/rdma.c   |  2 +-
 drivers/nvme/target/loop.c |  2 +-
 5 files changed, 73 insertions(+), 46 deletions(-)

-- 
2.14.1
