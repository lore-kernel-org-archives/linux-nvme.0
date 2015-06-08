From: keith.busch@intel.com (Keith Busch)
Date: Mon,  8 Jun 2015 10:08:12 -0600
Subject: [PATCH 0/3] NVMe: Initialization error handling fixups
Message-ID: <1433779695-15866-1-git-send-email-keith.busch@intel.com>

The asynchronous device probe created some interesting deadlocks and
accessing unallocated resources if the device failed during probe. This
series checks for resources allocated and owned by the driver for proper
cleanup, returns the expected errors on driver aborted commands, and
fixes the deadlocks between the probe and reset workers.

Keith Busch (3):
  NVMe: Fix device cleanup on initialization failure
  NVMe: Don't return fake status on cancelled
  NVMe: Unify controller probe and resume

 drivers/block/nvme-core.c |   75 +++++++++++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 26 deletions(-)

-- 
1.7.10.4
