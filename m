From: jonathan.derrick@intel.com (Jon Derrick)
Date: Tue, 23 Jun 2015 16:33:05 -0600
Subject: [PATCHv2 0/2] NVMe: Enable SQes on the CMB
Message-ID: <1435098787-13083-1-git-send-email-jonathan.derrick@intel.com>

This set unifies the command submission path, enables the cmb, and  maps
submission queues onto the controller memory buffer.

Jon Derrick (2):
  NVMe: Unify SQ entry writing and doorbell ringing
  NVMe: Use CMB for the SQ if available

 drivers/block/nvme-core.c | 197 ++++++++++++++++++++++++++++++++++------------
 include/linux/nvme.h      |  17 ++++
 2 files changed, 164 insertions(+), 50 deletions(-)

-- 
2.1.4
