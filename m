From: james_p_freyensee@linux.intel.com (Jay Freyensee)
Date: Mon, 15 Aug 2016 09:47:34 -0700
Subject: [PATCH v2 0/5] sqsize fixes
Message-ID: <1471279659-25951-1-git-send-email-james_p_freyensee@linux.intel.com>

This is the stable release of the sqsize fixes, based on making
sure sqsize is defined as a zero-based value throughout the code,
per NVMe-over-Fabrics spec.

Patch 1 assigns the admin sqsize to 32, minimum required per spec.
Patch 2-4 takes care of adjusting the code base to use sqsize as 0-based
Patch 5 adjusts hrqsize plus 1

Thus one can take their pick and decide if patch 5 is required based
on NVMe-over-Fabrics spec discussions...you can have your cake
and eat it too :-).

Changes from v1:
 - moved +1/+2 to outside le16_to_cpu() in patch 3 and 5

Changes from v0:
 - found all the sqsize dependencies and adjusted them accordingly
 - nvmf_connect_admin_queue() always uses NVMF_AQ_DEPTH for sqsize
 - final patch to adjust hrqsize only, so the series can be easily
   tested w/hrqsize == hrsqsize (patches 1-4) and hrqsize == hrsqsize+1
   (patch 5)

Jay Freyensee (5):
  fabrics: define admin sqsize min default, per spec
  nvme-rdma: fix sqsize/hsqsize per spec
  nvmet-rdma: +1 to *queue_size from hsqsize/hrqsize
  nvme-loop: set sqsize to 0-based value, per spec
  nvme-rdma: adjust hrqsize to plus 1

 drivers/nvme/host/fabrics.c |  9 ++++++++-
 drivers/nvme/host/rdma.c    | 19 ++++++++++++++-----
 drivers/nvme/target/loop.c  |  4 ++--
 drivers/nvme/target/rdma.c  |  9 +++++----
 4 files changed, 29 insertions(+), 12 deletions(-)

-- 
2.7.4
