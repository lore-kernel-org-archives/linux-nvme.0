From: james.smart@broadcom.com (James Smart)
Date: Fri, 22 Jul 2016 17:23:54 -0700
Subject: [PATCH 0/5] nvme-fabrics: add FC Transport support
Message-ID: <5792b91a.69rgMrTc0CeqbnSV%james.smart@broadcom.com>


This patchset adds FC transport support to nvme fabrics.   Adds both
initiator and target.  The transport utilizes a lower-level api with
FC hbas to actually perform FC link traffic. The drivers are mostly
ignorant of the actual NVME transport implementation, and provide
hooks to send/receive FC-4 LS request/responses or to perform FCP IO
operations.

Patches are cut against the linux-nvme for-4.8/drivers branch

Also dependent on the u64 parser being pulled in.

Note: these patches had been posted to the prior nvme fabrics code but
not merged before being brought over to linux-nvme.


-- james

Signed-off-by: James Smart <james.smart at broadcom.com>


James Smart (5):
  nvme-fabrics: Add FC transport FC-NVME definitions
  nvme-fabrics: Add FC transport LLDD api definitions
  nvme-fabrics: Add host FC transport support
  nvme-fabrics: Add target FC transport support
  nvme-fabrics: Add FC LLDD loopback driver to test FC host and target
    transport

 drivers/nvme/host/Kconfig      |   15 +
 drivers/nvme/host/Makefile     |    3 +
 drivers/nvme/host/fc.c         | 2113 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/Kconfig    |   23 +
 drivers/nvme/target/Makefile   |    4 +
 drivers/nvme/target/fc.c       | 1881 +++++++++++++++++++++++++++++++++++
 drivers/nvme/target/fcloop.c   |  803 +++++++++++++++
 include/linux/nvme-fc-driver.h |  823 ++++++++++++++++
 include/linux/nvme-fc.h        |  296 ++++++
 9 files changed, 5961 insertions(+)
 create mode 100644 drivers/nvme/host/fc.c
 create mode 100644 drivers/nvme/target/fc.c
 create mode 100644 drivers/nvme/target/fcloop.c
 create mode 100644 include/linux/nvme-fc-driver.h
 create mode 100644 include/linux/nvme-fc.h

-- 
2.5.0
