From: jonathan.derrick@intel.com (Jon Derrick)
Date: Thu, 16 Jul 2015 16:51:26 -0600
Subject: [PATCHv4 0/2] NVMe: Enable SQes on the CMB
Message-ID: <1437087088-1628-1-git-send-email-jonathan.derrick@intel.com>

This set unifies the command submission path, enables the cmb, and  maps
submission queues onto the controller memory buffer.

Applies against axboe's linux-block/master

v4: Fixed shift-overflow with cmbszu having 4GB+ units (Reported by
Stephen Bates). Added module parameter to disable cmb sqes mapping, which
will also disable cmb mapping as there are no other users of the cmb.

v3: Added separate __iomem sq_cmds_io pointer

v2: Removed nvme_{get,put}_cmd and added __iomem sq_cmds pointer

v1: Initial


Jon Derrick (2):
  NVMe: Unify SQ entry writing and doorbell ringing
  NVMe: Use CMB for the IO SQes if available

 drivers/block/nvme-core.c | 199 ++++++++++++++++++++++++++++++++++------------
 include/linux/nvme.h      |  17 ++++
 2 files changed, 166 insertions(+), 50 deletions(-)

-- 
2.1.4
