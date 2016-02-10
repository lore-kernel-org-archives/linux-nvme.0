From: keith.busch@intel.com (Keith Busch)
Date: Wed, 10 Feb 2016 11:17:17 -0700
Subject: [PATCH for-4.5 00/13] NVMe fixups for 4.5 
Message-ID: <1455128250-5984-1-git-send-email-keith.busch@intel.com>

Sorry for the patch bomb in the middle of rc, though this is fixing
legit issues.

Patches 1 and 2 are already reviewed/acked, and added those to this
reviewers (thanks!).

Patches 3 and 4 are performance related and pretty straight forward.

The remaining are specifically for surprise removal and other controller
failure scenarios. I had all these in a single patch, but there was
too much going on, so I split at what appears to be reasonable and self
contained features.

To test what was previously broken: run buffered writes to an nvme drive,
remove the drive via sysfs, then pull the drive out.

Keith Busch (13):
  blk-mq: End unstarted requests on dying queue
  NVMe: Fix io incapable return values
  NVMe: Allow request merges
  NVMe: Set queue limits max_dev_sectors
  NVMe: Fix namespace removal deadlock
  NVMe: Remove WQ_MEM_RECLAIM from nvme work queue
  NVMe: Requeue requests on suspended queues
  NVMe: Poll device while still active during remove
  NVMe: Simplify device reset failure
  NVMe: Move error handling to failed reset handler
  NVMe: Dead namespace handling
  NVMe: Mark queues as dead on degraded controller
  NVMe: Rate limit nvme IO warnings

 block/blk-mq.c           |  6 ++--
 drivers/nvme/host/core.c | 74 ++++++++++++++++++++++-----------------
 drivers/nvme/host/nvme.h | 12 +++++--
 drivers/nvme/host/pci.c  | 91 ++++++++++++++++++++++++++++++------------------
 4 files changed, 113 insertions(+), 70 deletions(-)

-- 
2.6.2.307.g37023ba
