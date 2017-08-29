From: keith.busch@intel.com (Keith Busch)
Date: Tue, 29 Aug 2017 17:46:00 -0400
Subject: [PATCHv2 0/4] nvme user metadata updates
Message-ID: <1504043164-5398-1-git-send-email-keith.busch@intel.com>

A few minor updates to the nvme user metadata handling, culminating in
actually making use of it for the NVME_IOCTL_IO_CMD.

Christoph Hellwig (1):
  nvme: factor metadata handling out of __nvme_submit_user_cmd

Keith Busch (3):
  nvme/pci: Use req_op to determine DIF remapping
  nvme: Make nvme user functions static
  nvme: Use metadata for passthrough commands

 drivers/nvme/host/core.c | 99 +++++++++++++++++++++++-------------------------
 drivers/nvme/host/nvme.h |  7 ----
 drivers/nvme/host/pci.c  |  4 +-
 3 files changed, 50 insertions(+), 60 deletions(-)

-- 
2.5.5
