From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 27 Jun 2018 14:53:22 +0200
Subject: [PATCH v5 0/2] nvme: add controller id and disk name to tracepoints
Message-ID: <20180627125324.22064-1-jthumshirn@suse.de>

Patch one is a preparation patch from Sagi and caches the nvme_ctrl in
the nvme_request. This is not only useful for the tracepoints but for
further development as well.

The second patch adds the controller IDs and if applicable the disk
name to the tracepoints so we can distinguish between the individual
controllers and disks.

The patches are relative to the nvme-4.19 branch.

Changes to v4:
* Move nvme_ctrl caching into init_request callouts
* I decided against renaming the qid tag in the tracepints but opt-in
  for a hwqid once we have all the infor available

Johannes Thumshirn (1):
  nvme: trace: add disk name to tracepoints

Sagi Grimberg (1):
  nvme: cache struct nvme_ctrl reference to struct nvme_request

 drivers/nvme/host/core.c   |  5 +++--
 drivers/nvme/host/fc.c     |  1 +
 drivers/nvme/host/nvme.h   |  1 +
 drivers/nvme/host/pci.c    |  2 ++
 drivers/nvme/host/rdma.c   |  1 +
 drivers/nvme/host/trace.h  | 39 +++++++++++++++++++++++++--------------
 drivers/nvme/target/loop.c |  1 +
 7 files changed, 34 insertions(+), 16 deletions(-)

-- 
2.16.4
