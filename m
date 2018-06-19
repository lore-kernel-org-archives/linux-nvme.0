From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 19 Jun 2018 15:34:08 +0300
Subject: [PATCH 0/7] few nvme-rdma fixes for 4.18
Message-ID: <20180619123415.25077-1-sagi@grimberg.me>

Patches 1-5 fixes some allocation/free glitches reported. patches
6-7 try to centralize some setup/teardown logic such that fixes
can be applied in a single location (which can probably go to
4.19).

Israel Rukshin (1):
  nvme-rdma: Fix command completion race at error recovery

Sagi Grimberg (6):
  nvme-rdma: fix possible double free condition when failing to create a
    controller
  nvme-rdma: fix possible free non-allocated async event buffer
  nvme-rdma: unquiesce queues when deleting the controller
  nvme-rdma: don't override opts->queue_size
  nvme-rdma: centralize controller setup sequence
  nvme-rdma: centralize admin/io queue teardown sequence

 drivers/nvme/host/rdma.c | 242 +++++++++++++++++++++--------------------------
 1 file changed, 109 insertions(+), 133 deletions(-)

-- 
2.14.1
