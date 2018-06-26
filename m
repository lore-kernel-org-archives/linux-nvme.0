From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 26 Jun 2018 15:51:39 +0200
Subject: [PATCH v4 0/2] nvme: add controller id and disk name to tracepoints
Message-ID: <20180626135141.14088-1-jthumshirn@suse.de>

Patch one is a preparation patch from Sagi and caches the nvme_ctrl in
the nvme_request. This is not only useful for the tracepoints but for
further development as well.

The second patch adds the controller IDs and if applicable the disk
name to the tracepoints so we can distinguish between the individual
controllers and disks.

The patches are relative to the nvme-4.19 branch.

Johannes Thumshirn (1):
  nvme: trace: add disk name to tracepoints

Sagi Grimberg (1):
  nvme: cache struct nvme_ctrl reference to struct nvme_request

 drivers/nvme/host/core.c   | 10 ++++++----
 drivers/nvme/host/fc.c     |  2 +-
 drivers/nvme/host/nvme.h   |  5 +++--
 drivers/nvme/host/pci.c    |  2 +-
 drivers/nvme/host/rdma.c   |  2 +-
 drivers/nvme/host/trace.h  | 30 +++++++++++++++++++-----------
 drivers/nvme/target/loop.c |  2 +-
 7 files changed, 32 insertions(+), 21 deletions(-)

-- 
2.16.4
