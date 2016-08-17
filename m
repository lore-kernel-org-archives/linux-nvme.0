From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Wed, 17 Aug 2016 15:00:24 -0700
Subject: [PATCH v4 0/4] sqsize fixes
Message-ID: <1471471228-15818-1-git-send-email-james_p_freyensee@linux.intel.com>

This patch series is based on making sure sqsize is defined as a
zero-based value throughout the code, per NVMe-over-Fabrics spec.

Changes from v3:
 - assigning hrqsize to internal one's based field, queue->queue_size.

Changes from v2:
 - patch 5, adding 1 to hrsqsize in target dropped
 - using ...opts->queue_depth to set various queue sizes over sqsize.

Changes from v1:
 - moved +1/+2 to outside le16_to_cpu() in patch 3 and 5

Changes from v0:
 - found all the sqsize dependencies and adjusted them accordingly
 - nvmf_connect_admin_queue() always uses NVMF_AQ_DEPTH for sqsize
 - final patch to adjust hrqsize only, so the series can be easily
   tested w/hrqsize == hrsqsize (patches 1-4) and hrqsize == hrsqsize+1
   (patch 5)

Jay Freyensee (4):
  nvmet-rdma: +1 to *queue_size from hsqsize/hrqsize
  fabrics: define admin sqsize min default, per spec
  nvme-rdma: fix sqsize/hsqsize per spec
  nvme-loop: set sqsize to 0-based value, per spec

 drivers/nvme/host/fabrics.c |  9 ++++++++-
 drivers/nvme/host/rdma.c    | 25 ++++++++++++++++++++-----
 drivers/nvme/target/loop.c  |  4 ++--
 drivers/nvme/target/rdma.c  |  8 ++++----
 4 files changed, 34 insertions(+), 12 deletions(-)

-- 
2.7.4
