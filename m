From: jonathan.derrick@intel.com (Jon Derrick)
Date: Mon, 20 Jul 2015 10:14:07 -0600
Subject: [PATCHv5 0/2] NVMe: Enable SQes on the CMB
Message-ID: <1437408849-4099-1-git-send-email-jonathan.derrick@intel.com>

This set unifies the command submission path, enables the cmb, and  maps
submission queues onto the controller memory buffer.

Applies against axboe's linux-block/master

v5: Changed module_param to bool. Changed nvme_alloc_sq_cmds to return
error code per Christoph's suggestion.

v4: Fixed shift-overflow with cmbszu having 4GB+ units (Reported by
Stephen Bates). Added module parameter to disable cmb sqes mapping, which
will also disable cmb mapping as there are no other users of the cmb.

v3: Added separate __iomem sq_cmds_io pointer

v2: Removed nvme_{get,put}_cmd and added __iomem sq_cmds pointer

v1: Initial


Jon Derrick (2):
  NVMe: Unify SQ entry writing and doorbell ringing
  NVMe: Use CMB for the IO SQes if available

 drivers/block/nvme-core.c | 202 ++++++++++++++++++++++++++++++++++------------
 include/linux/nvme.h      |  17 ++++
 2 files changed, 169 insertions(+), 50 deletions(-)

-- 
2.1.4
