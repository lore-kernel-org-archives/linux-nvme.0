From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 30 Aug 2016 09:26:50 -0700
Subject: [PATCH WIP/RFC v3 0/6] nvme-rdma device removal fixes
Message-ID: <cover.1472574410.git.swise@opengridcomputing.com>

This series is a Work In Progress (WIP) attempting to address several
problems when shutting down a nvme-rdma host when its controllers are
attempting to reconnect to a target that is no longer reachable.

I'm still testing but I welcome review.  Specifically the last patch
which solves the problem of always being able to detect a device removal.

To tickle these bugs:

1) attach over iw_cxgb4 to 10 devices on a target.
2) 'ifconfig down' the target's interface
3) wait for keep-alive to fire and begin reconnecting (~15-20 seconds)
4) do one of these on the host:
   - rmmod iw_cxgb4
   - reboot
   - reboot -f

Changes since v2:

- refactor/simplify the remove_one function.

- nvme-rdma module remove function doesn't need to explicitly
remove the controllers; they will be removed as part of
ib_client unregister.

- removed forward declarations.

Changes since v1:

- the big change was patch 6 rewrite - use client_ib API to handle
device removal instead of rdma_cm device removal events.

- tweaked patch 5 to avoid bisect issues

- small code rework on patch 3 based on Christoph's suggestion

- clear_bit() -> !test_and_clear_bit() in patch 4 (Christoph's comment)

- add reviewed-by tags.

---

Sagi Grimberg (1):
  nvme-rdma: add DELETING queue flag

Steve Wise (5):
  iw_cxgb4: call dev_put() on l2t allocation failure
  iw_cxgb4: block module unload until all ep resources are released
  nvme_rdma: keep a ref on the ctrl during delete/flush
  nvme-rdma: destroy nvme queue rdma resources on connect failure
  nvme-rdma: use ib_client API to detect device removal

 drivers/infiniband/hw/cxgb4/cm.c       |   6 +-
 drivers/infiniband/hw/cxgb4/device.c   |   5 ++
 drivers/infiniband/hw/cxgb4/iw_cxgb4.h |   1 +
 drivers/nvme/host/rdma.c               | 136 ++++++++++++++++-----------------
 4 files changed, 77 insertions(+), 71 deletions(-)

-- 
2.7.0
