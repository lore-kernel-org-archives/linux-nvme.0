From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Fri,  5 Aug 2016 17:54:09 -0700
Subject: [PATCH 0/2] nvme-fabrics: sqsize bug fixes
Message-ID: <1470444851-7459-1-git-send-email-james_p_freyensee@linux.intel.com>

A few sqsize bugs have been discovered during the connect()
operation, basically the NVMe-fabrics layer being not-in-sync
with the implementation layer (RDMA).

As these bugs actually do break the NVMe-Fabrics spec, I'd like
to make the request to apply these fixes to the 4.8 kernel
(when approved).

Jay Freyensee (2):
  nvme-rdma: tell fabrics layer admin queue depth
  nvme-rdma: sqsize/hsqsize/hrqsize is 0-based val

 drivers/nvme/host/fabrics.c |  2 +-
 drivers/nvme/host/nvme.h    |  1 +
 drivers/nvme/host/rdma.c    | 20 +++++++++++++++++---
 3 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.7.4
