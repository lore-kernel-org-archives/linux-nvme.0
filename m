From: james.smart@broadcom.com (James Smart)
Date: Sun, 23 Oct 2016 12:31:04 -0700
Subject: [PATCH v3 0/7] nvme-fabrics: Add FC-NVME Transport support
Message-ID: <580d0ff8.K6A8RkcLgUvO6/1z%james.smart@broadcom.com>


The patches in this set add support for the FC transport to the nvme
fabrics subsystem.  The set include header files with T11 transport
definitions and an api for the FC-NVME transport to talk with FC LLDDs.
It also includes host and target transport files. A FC loopback driver
is supplied to act as a FC LLDD to exercise the api.

Revised for review comments from earlier this week.

Cut against linux-block for-next branch as of 10/21

-- james


James Smart (7):
  Add type 0x28 NVME type code to scsi fc headers
  nvme-fabrics: Add FC transport error codes to nvme.h
  nvme-fabrics: Add FC transport FC-NVME definitions
  nvme-fabrics: Add FC transport LLDD api definitions
  nvme-fabrics: Add host support for FC transport
  nvme-fabrics: Add target support for FC transport
  nvme-fabrics: Add FC LLDD loopback driver to test FC-NVME

 MAINTAINERS                    |   10 +
 drivers/nvme/host/Kconfig      |   16 +
 drivers/nvme/host/Makefile     |    3 +
 drivers/nvme/host/fc.c         | 2351 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/Kconfig    |   23 +
 drivers/nvme/target/Makefile   |    4 +
 drivers/nvme/target/fc.c       | 2050 +++++++++++++++++++++++++++++++++++
 drivers/nvme/target/fcloop.c   | 1145 +++++++++++++++++++
 include/linux/nvme-fc-driver.h |  833 ++++++++++++++
 include/linux/nvme-fc.h        |  259 +++++
 include/linux/nvme.h           |   20 +
 include/uapi/scsi/fc/fc_fs.h   |    2 +
 12 files changed, 6716 insertions(+)
 create mode 100644 drivers/nvme/host/fc.c
 create mode 100644 drivers/nvme/target/fc.c
 create mode 100644 drivers/nvme/target/fcloop.c
 create mode 100644 include/linux/nvme-fc-driver.h
 create mode 100644 include/linux/nvme-fc.h

-- 
2.5.0
