From: keith.busch@intel.com (Keith Busch)
Date: Thu, 28 Jun 2018 15:49:52 -0600
Subject: [PATCHv2 0/4] nvme trace updates
Message-ID: <20180628214956.13877-1-keith.busch@intel.com>

This patch series based on/inspired by Johannes Thumshirn that improves
the nvme trace events.

The one from Sagi is saving the nvme_ctrl in the driver request data
so we can reference it in other places, both for this series and future
developments.

The others are adding and simplifying the nvme traces so we can see the
more useful information to uniquely identify what hardware the trace
event is showing, and filter events for specific hardware.

v1 -> v2:

  Dropped the blk-mq patch as there were pre-existing ways to get to the
  desired information without introducing a new API

  Changelog typo fixups

Keith Busch (3):
  nvme: trace nvme queue identifiers
  nvme: trace controller name
  nvme: add disk name to tracepoints

Sagi Grimberg (1):
  nvme: cache struct nvme_ctrl reference to struct nvme_request

 drivers/nvme/host/core.c   |  7 +++---
 drivers/nvme/host/fc.c     |  1 +
 drivers/nvme/host/nvme.h   |  1 +
 drivers/nvme/host/pci.c    |  2 ++
 drivers/nvme/host/rdma.c   |  1 +
 drivers/nvme/host/trace.c  | 11 +++++++++
 drivers/nvme/host/trace.h  | 61 ++++++++++++++++++++++------------------------
 drivers/nvme/target/loop.c |  1 +
 8 files changed, 49 insertions(+), 36 deletions(-)

-- 
2.14.3
