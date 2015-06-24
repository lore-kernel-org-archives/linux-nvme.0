From: jonathan.derrick@intel.com (Jon Derrick)
Date: Wed, 24 Jun 2015 14:49:44 -0600
Subject: [PATCHv3 0/2] NVMe: Enable SQes on the CMB
Message-ID: <1435178986-1623-1-git-send-email-jonathan.derrick@intel.com>

This set unifies the command submission path, enables the cmb, and  maps
submission queues onto the controller memory buffer.

Jon Derrick (2):
  NVMe: Unify SQ entry writing and doorbell ringing
  NVMe: Use CMB for the SQ if available

 drivers/block/nvme-core.c | 192 ++++++++++++++++++++++++++++++++++------------
 include/linux/nvme.h      |  17 ++++
 2 files changed, 159 insertions(+), 50 deletions(-)

-- 
2.1.4
