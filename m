From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 12 Dec 2018 15:11:36 -0800
Subject: [PATCH V2 00/12] nvmet: add error log page support
Message-ID: <20181212231148.4107-1-chaitanya.kulkarni@wdc.com>

Hi,

This patch series adds support for the NVMe Over Fabrics target error
log page.

For I/O backend when the namespace is configured with bdev we just map
the blk_status to NVMe error status and for file backend we just map
the errno to the NVMe error status.

We add new fields to the nvmet_req to hold the error log information and
to the nvmet_ctrl to hold the error log page. We update the error log
page in the request completion path in the nvmet_req_complete() and
implement admin command so that host can read the error log page.

Regards,
Chaitanya                

Changes since V1:-
1. Don't propagate the errors for PI.
2. Initialize req->error_loc to -1 and only update error log if error
   location is set.

Chaitanya Kulkarni (12):
  nvme: remove nvme_common command cdw10 array
  nvme: add error log page slot definition
  nvmet: add error-log definitions
  nvmet: add interface to update error-log page
  nvmet: add error log support in the core
  nvmet: add error log support for bdev backend
  nvmet: add error log support for file backend
  nvmet: add error log support for fabrics-cmd
  nvmet: add error log support for rdma backend
  nvmet: add error log support for admin-cmd
  nvmet: add error log page cmd handler
  nvmet: update smart log with num err log entries

 drivers/nvme/host/core.c          |  18 ++---
 drivers/nvme/host/trace.h         |   4 +-
 drivers/nvme/target/admin-cmd.c   |  76 ++++++++++++++++-----
 drivers/nvme/target/core.c        | 106 +++++++++++++++++++++++++++---
 drivers/nvme/target/discovery.c   |  14 +++-
 drivers/nvme/target/fabrics-cmd.c |  48 ++++++++++----
 drivers/nvme/target/io-cmd-bdev.c |  84 +++++++++++++++++++----
 drivers/nvme/target/io-cmd-file.c |  35 +++++-----
 drivers/nvme/target/nvmet.h       |  15 +++--
 drivers/nvme/target/rdma.c        |  10 ++-
 include/linux/nvme.h              |  21 +++++-
 11 files changed, 344 insertions(+), 87 deletions(-)

-- 
2.17.0
