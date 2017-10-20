From: keith.busch@intel.com (Keith Busch)
Date: Fri, 20 Oct 2017 16:19:19 -0600
Subject: [PATCHv2 0/5] AEN and userspace updates
Message-ID: <20171020221924.30659-1-keith.busch@intel.com>

This series cleans up some duplicate AEN code, and ultimately adds change
uevents for nvme devices that raise an AEN that the driver did not handle.

I have updated nvme-cli to have a more convenient way to retreive a log
based on the AEN result, and intend to provide a udev rule to wrap that
command when this goes through.

v1 -> v2;

  Merge with nvme-4.15.

  Squashed the AEN define centralization patches.

  Using kasprintf for the uevent.

  Removed async event helper function and made it inline.

  Filter AEN notification only for events the kernel does not handle.
  This would be useful to prevent userspace from reacting events and
  reading logs that may alter what the kernel sees.

Keith Busch (5):
  nvme: Centralize AEN defines
  nvme/fc: remove unused "queue_size" field
  nvme: Single AEN request
  nvme: Unexport starting async event work
  nvme: Send uevent for unhandled AEN completions

 drivers/nvme/host/core.c   | 57 ++++++++++++++++++++--------------------------
 drivers/nvme/host/fc.c     | 47 +++++++++++++-------------------------
 drivers/nvme/host/nvme.h   |  6 ++---
 drivers/nvme/host/pci.c    | 14 ++++--------
 drivers/nvme/host/rdma.c   | 19 ++++------------
 drivers/nvme/target/loop.c | 16 ++++---------
 include/linux/nvme.h       |  2 ++
 7 files changed, 57 insertions(+), 104 deletions(-)

-- 
2.13.6
