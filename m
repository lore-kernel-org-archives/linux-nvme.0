From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Feb 2016 13:05:37 -0700
Subject: [PATCHv2-4.5 00/10] NVMe fixes
Message-ID: <1455221147-24228-1-git-send-email-keith.busch@intel.com>

Thank you everyone for the earlier review comments.

The entire series is here, though most of the code is not changing from
the previous.

I'll gladly handle merging this with the 4.6 branch if/when this goes
through.

v1 -> v2:

  Added all recieved "Reviewed-by".

  Dropped patch for NVMe's max_dev_sectors. This is fixed in the block
  layer with a different and generic patch external to this series.

  Dropped patch removing nvme_workq's WQ_MEM_RECLAIM. The flush sync
  warning that patch was trying to address is fixed by moving the
  namespace cleanup from the nvme_workq to an existing nvme callback
  scheduled on the system workqueue.

  Implemented Sagi's suggestion to move the "nvme_kill_ns_queues" to from
  pci to core. There was no real dependency on PCI after a very minor
  modification. Also added code comments to explain the function usage.

  Combined the "NS_DEAD" state patch with the namespace queue cleanup
  handling in the reset_work. The first really counted on the second to
  actually be useful, so making it a single commit.

  Fixed an error code to be negative, pointed out in review.

  Commented the requirement for nvme_remove()'s necessity to handle a
  partially initialized.

  Made nvme's "Cancelling I/O ..." message debug level, in addition to
  rate limted.

Keith Busch (10):
  blk-mq: End unstarted requests on dying queue
  NVMe: Fix io incapable return values
  NVMe: Allow request merges
  NVMe: Fix namespace removal deadlock
  NVMe: Requeue requests on suspended queues
  NVMe: Poll device while still active during remove
  NVMe: Simplify device reset failure
  NVMe: Move error handling to failed reset handler
  NVMe: Mark queues as dead on degraded controller
  NVMe: Rate limit nvme IO warnings

 block/blk-mq.c           |   6 ++-
 drivers/nvme/host/core.c | 105 ++++++++++++++++++++++++++++++++---------------
 drivers/nvme/host/nvme.h |  13 +++++-
 drivers/nvme/host/pci.c  |  66 ++++++++++++++---------------
 4 files changed, 121 insertions(+), 69 deletions(-)

-- 
2.6.2.307.g37023ba
