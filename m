From: keith.busch@intel.com (Keith Busch)
Date: Wed, 20 Feb 2013 17:19:28 -0700
Subject: [PATCH 0/8] NVMe controller shutdown related patches
Message-ID: <1361405968-22085-1-git-send-email-keith.busch@intel.com>

These are all related to shutting down a controller for various reasons. We do
not want to take the gendisks down so that IO may continue. The nvme queues,
though, have to be deleted so the bio queueing had change so that it is not
queued on the nvme IO queues but on the device itself, which is what patch
[1/8] tries to do. 

The original motivation was to handle if the controller is in a temporary
failed state that a controller reset would clear up.

Another thread on the nvme mailing list pointed out potential issues that could
happen with the current IO timeout error handling should the controller end up
completing an IO the driver canceled internally, so it was adapted to address
that.

Resetting the controller for these situations is much the same as the
suspend/resume power management scenarios, and for a user controlled controller
reset for firmware activate, so more patches were added for these as well.

Keith Busch (8):
  NVMe: Queue bio requests on device
  NVMe: Controller reset from user
  NVMe: Suspend/resume power management
  NVMe: Add shutdown callback
  NVMe: End queued bio requests for removed disks
  NVMe: Wait for controller status ready to clear
  NVMe: Automatically reset failed controller
  NVMe: Use schedule_timeout for sync commands

 drivers/block/nvme.c |  313 ++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 264 insertions(+), 49 deletions(-)
