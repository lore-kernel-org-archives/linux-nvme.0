From: james.smart@broadcom.com (James Smart)
Date: Mon, 26 Sep 2016 08:14:56 -0700
Subject: [PATCH 0/2 v2] nvme-fabrics: infrastructure changes for fc
 protocol support
Message-ID: <57e93b70.oopX7Rt0+86+HCU9%james.smart@broadcom.com>


This patch set completes the patches to the fabrics layer for
FC protocol support.

Thanks Sagi, for pulling 3 of the prior patches in.

The first patch, patching target code, is unchanged from its prior
posting, which was reviewed and accepted.

The second patch, fixing sqe.command_id, is a repost of a prior patch
revised per review to fix pci.c and loop.c as well.


-- james



James Smart (2):
  nvme-fabrics: patch target code in prep for FC transport support
  nvme-fabrics: set sqe.command_id in core, not transports

 drivers/nvme/host/core.c       |  3 ++-
 drivers/nvme/host/pci.c        |  1 -
 drivers/nvme/host/rdma.c       |  1 -
 drivers/nvme/target/configfs.c | 14 ++++++++++++++
 drivers/nvme/target/loop.c     |  1 -
 5 files changed, 16 insertions(+), 4 deletions(-)

-- 
2.5.0
