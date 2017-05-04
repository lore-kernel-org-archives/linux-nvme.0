From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  4 May 2017 13:33:04 +0300
Subject: [PATCH 00/11] a few useful nvme fixes and cleanups
Message-ID: <1493893995-27063-1-git-send-email-sagi@grimberg.me>

Some patches I've been sitting on for that past two weeks.

Sagi Grimberg (11):
  nvme-loop: get rid of unused controller lock
  nvme-rdma: get rid of unused ctrl lock
  nvme-rdma: Make queue flags bit numbers and not shifts
  nvme-rdma: Don't rearm the CQ when polling directly
  nvme-rdma: make nvme_rdma_[create|destroy]_queue_ib symmetrical
  nvme-rdma: rework rdma connection establishment error path
  nvme-rdma: Get rid of CONNECTED state
  nvme: Don't allow to reset a reconnecting controller
  nvme: Move transports to use nvme-core workqueue
  nvme: queue ns scanning and async request from nvme_wq
  nvme: move nr_reconnects to nvme_ctrl

 drivers/nvme/host/core.c    |  22 +++++++---
 drivers/nvme/host/fabrics.c |   2 +-
 drivers/nvme/host/fabrics.h |   2 -
 drivers/nvme/host/fc.c      |  34 ++++-----------
 drivers/nvme/host/nvme.h    |   3 ++
 drivers/nvme/host/pci.c     |  18 ++------
 drivers/nvme/host/rdma.c    | 100 ++++++++++++++++----------------------------
 drivers/nvme/target/loop.c  |  11 ++---
 8 files changed, 72 insertions(+), 120 deletions(-)

-- 
2.7.4
