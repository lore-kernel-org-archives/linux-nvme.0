From: keith.busch@intel.com (Keith Busch)
Date: Fri,  7 Jul 2017 12:22:54 -0400
Subject: [PATCH 0/7] NVMe Async Event Notification updates
Message-ID: <1499444581-28268-1-git-send-email-keith.busch@intel.com>

This culminates with udev handling for AEN, but implementing this was much
easier without all the unreachable handling for multiple AEN requests.

Some background on why single AEN's are used today: we can't tell blk-mq
about those reserved tags lest we deadlock a freeze. These requests
are not worth the trouble to implement tag accounting required for
multiple requests outstanding, and one AEN request is sufficient for
all uses anyway.

I don't have a setup to try the nvme/fc parts, so while I think this
looks correct, it's only compile tested.

Keith Busch (7):
  nvme/fc: There is only one AEN request
  nvme/fc: Fix admin queue depth setup
  nvme/fc: remove unused "queue_size" field
  nvme: Centralize blk-mq tag and AEN counts
  nvme: Only one AEN request
  nvme: Unexport starting async event work
  nvme: Send change uevent when AEN completes

 drivers/nvme/host/core.c   |  46 ++++++------
 drivers/nvme/host/fc.c     | 175 ++++++++++++++++++---------------------------
 drivers/nvme/host/nvme.h   |   6 +-
 drivers/nvme/host/pci.c    |  10 +--
 drivers/nvme/host/rdma.c   |  19 ++---
 drivers/nvme/target/loop.c |  16 ++---
 include/linux/nvme.h       |   7 ++
 7 files changed, 107 insertions(+), 172 deletions(-)

-- 
2.5.5
