From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 21 Dec 2017 12:07:49 +0200
Subject: [PATCH 4.15-rc 0/3] few fabrics fixes targeted to 4.15
Message-ID: <20171221100752.18386-1-sagi@grimberg.me>

First two patches address possible hangs when deleting controllers
under heavy workqueue activities such as inflight ns scans, reconnects,
and resets. Lockdep complains about circular locking and rightfully so
as the lock dependency of in-workqueue flush hangs were observed.

The third fix is protecting against fabrics controller creation during
transport driver module unload.

Let's consider these for 4.15-rc

Roy Shterman (3):
  nvme-core: Don't set nvme_wq as MEM_RECLAIM
  nvme-core/loop/rdma: Host delete_work and reset_work on system
    workqueues
  nvme-fabrics: Protect against module unload during create_ctrl

 drivers/nvme/host/core.c    |  6 +++---
 drivers/nvme/host/fabrics.c | 16 ++++++++++++----
 drivers/nvme/host/fabrics.h |  2 ++
 drivers/nvme/host/fc.c      |  1 +
 drivers/nvme/host/rdma.c    |  3 ++-
 drivers/nvme/target/loop.c  |  3 ++-
 6 files changed, 22 insertions(+), 9 deletions(-)

-- 
2.14.1
