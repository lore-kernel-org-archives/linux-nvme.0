From: keith.busch@intel.com (Keith Busch)
Date: Fri, 29 Jun 2018 13:59:56 -0600
Subject: [PATCHv3 0/4] nvme trace updates
Message-ID: <20180629200000.16171-1-keith.busch@intel.com>

This patch series is based on/inspired by Johannes Thumshirn that
improves the nvme trace events.

The first one from Sagi is saving the nvme_ctrl in the driver request data
so we can reference it in other places, both for this series and future
developments.

The others are adding and simplifying the nvme traces so we can see
information to uniquely identify what hardware the trace event is showing,
and filter events for specific hardware.

v2 -> v3:

  Removed unrelated code that leaked into the previous series

  Added helpers for setting the qid and disk name fields

  Simplified printing the disk name: it's already null terminated, so
  don't need to define the limit.

  Updated change logs

  Minor code formatting updates

  Added Reviewed-by for Sagi's patch

v1 -> v2:

  Dropped the blk-mq patch as there were pre-existing ways to get to the
  desired information without introducing a new API

  Changelog typo fixups

Keith Busch (3):
  nvme: use hw qid in trace events
  nvme: add controller name to trace events
  nvme: add disk name to trace events

Sagi Grimberg (1):
  nvme: cache struct nvme_ctrl reference to struct nvme_request

 drivers/nvme/host/core.c   |   5 +-
 drivers/nvme/host/fc.c     |   1 +
 drivers/nvme/host/nvme.h   |   1 +
 drivers/nvme/host/pci.c    |   2 +
 drivers/nvme/host/rdma.c   |   1 +
 drivers/nvme/host/trace.c  |  11 ++++
 drivers/nvme/host/trace.h  | 137 +++++++++++++++++++++++++--------------------
 drivers/nvme/target/loop.c |   1 +
 8 files changed, 93 insertions(+), 66 deletions(-)

-- 
2.14.3
