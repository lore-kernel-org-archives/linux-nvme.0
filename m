From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Oct 2017 15:29:05 +0300
Subject: [PATCH 0/7] Some nvme-rdma host patches for 4.15
Message-ID: <1507724952-13917-1-git-send-email-sagi@grimberg.me>

A couple of minor fixes. Patch 6 is improving the reconnect
flow to not teardown the admin/io queues in every reconnect
(which doesn't really happen as we check a state on the queues).

Sagi Grimberg (7):
  nvme-rdma: pass tagset to directly nvme_rdma_free_tagset
  nvme-rdma: fix wrong logging message
  nvme-rdma: move assignment to declaration
  nvme-rdma: Check that reinit_request got a proper mr
  nvme-rdma: Don't local invalidate if the queue is not live
  nvme-rdma: teardown admin/io queues once on error recovery
  nvme-rdma: change queue flag semantics DELETING -> ALLOCATED

 drivers/nvme/host/rdma.c | 61 +++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 32 deletions(-)

-- 
2.7.4
