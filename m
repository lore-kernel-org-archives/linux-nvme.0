From: keith.busch@intel.com (Keith Busch)
Date: Tue,  7 Nov 2017 15:13:09 -0700
Subject: [PATCHv3 0/5] Asynchronous events for udev
Message-ID: <20171107221314.27822-1-keith.busch@intel.com>

This series updates asynchronous event notification throughout the driver
by centralizing common definitions, simplifying the code with a single
outstanding asynchronous event request, and ending with creating a change
uevent if the event result matches a whitelist of events to notify.

v2 -> v3:
  Merged to current nvme-4.15

  Use a whitelist instead of notifying all unhandled events

  Added define for the blk-mq tagset queue_depth (patch 1/5)

  Added reviews from previous round

Keith Busch (5):
  nvme: Centralize AEN defines
  nvme/fc: remove unused "queue_size" field
  nvme: Single AEN request
  nvme: Unexport starting async event work
  nvme: Send uevent for some asynchronous events

 drivers/nvme/host/core.c   | 62 ++++++++++++++++++++++++----------------------
 drivers/nvme/host/fc.c     | 47 ++++++++++++-----------------------
 drivers/nvme/host/nvme.h   |  6 ++---
 drivers/nvme/host/pci.c    | 18 +++-----------
 drivers/nvme/host/rdma.c   | 19 +++-----------
 drivers/nvme/target/loop.c | 16 +++---------
 include/linux/nvme.h       | 12 +++++++++
 7 files changed, 75 insertions(+), 105 deletions(-)

-- 
2.13.6
