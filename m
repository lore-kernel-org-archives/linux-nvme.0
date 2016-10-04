From: james.smart@broadcom.com (James Smart)
Date: Mon, 03 Oct 2016 23:26:56 -0700
Subject: [PATCH 0/7] nvme-fabrics: Add FC-NVME Transport support
Message-ID: <57f34bb0.NABAPMPHMx/CQT2r%james.smart@broadcom.com>


The patches in this set add support for the FC transport to the nvme
fabrics subsystem.  The set include header files with T11 transport
definitions and an api for the FC-NVME transport to talk with FC LLDDs.
It also includes host and target transport files. A FC loopback driver
is supplied to act as a FC LLDD to exercise the api.

The patchset addresses the prior review comments. The largest impact
was the teardown paths and proper ref counting support.

-- james


James Smart (7):
  nvme-fabrics: Add FC transport FC-NVME definitions
  nvme-fabrics: sync FC-NVME header with standard updates
  nvme-fabrics: Add FC transport LLDD api definitions
  nvme-fabrics: Updates to FC LLDD api
  nvme-fabrics: Add host FC transport support
  nvme-fabrics: Add target FC transport support
  nvme-fabrics: Add FC LLDD loopback driver to test FC-NVME

 drivers/nvme/host/Kconfig      |   15 +
 drivers/nvme/host/Makefile     |    3 +
 drivers/nvme/host/fc.c         | 2286 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/Kconfig    |   23 +
 drivers/nvme/target/Makefile   |    4 +
 drivers/nvme/target/fc.c       | 1969 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/fcloop.c   | 1131 ++++++++++++++++++++
 include/linux/nvme-fc-driver.h |  834 +++++++++++++++
 include/linux/nvme-fc.h        |  289 +++++
 9 files changed, 6554 insertions(+)
 create mode 100644 drivers/nvme/host/fc.c
 create mode 100644 drivers/nvme/target/fc.c
 create mode 100644 drivers/nvme/target/fcloop.c
 create mode 100644 include/linux/nvme-fc-driver.h
 create mode 100644 include/linux/nvme-fc.h

-- 
2.5.0
