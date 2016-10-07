From: james.smart@broadcom.com (James Smart)
Date: Fri, 07 Oct 2016 16:09:01 -0700
Subject: [PATCH 0/7 v2] nvme-fabrics: Add FC-NVME Transport support
Message-ID: <57f82b0d.sLiRmQ0NSI2pLk2l%james.smart@broadcom.com>


The patches in this set add support for the FC transport to the nvme
fabrics subsystem.  The set include header files with T11 transport
definitions and an api for the FC-NVME transport to talk with FC LLDDs.
It also includes host and target transport files. A FC loopback driver
is supplied to act as a FC LLDD to exercise the api.

The patchset addresses the prior review comments. The largest impact
was the teardown paths and proper ref counting support.

Revised for review comments from earlier this week.

The patches were cut against the linux-block.git tree, for-next branch
as of 10/3 and are dependent on the following patches:

add u64 number parser
http://lists.infradead.org/pipermail/linux-nvme/2016-September/006371.html

patch tgt code for FC transport
http://lists.infradead.org/pipermail/linux-nvme/2016-September/006387.html

set sqe.command_id in core not transports
http://lists.infradead.org/pipermail/linux-nvme/2016-September/006386.html


-- james



James Smart (7):
  Add type 0x28 NVME type code to scsi fc headers
  nvme-fabrics: Add FC transport error codes to nvme.h
  nvme-fabrics: Add FC transport FC-NVME definitions
  nvme-fabrics: Add FC transport LLDD api definitions
  nvme-fabrics: Add host FC transport support
  nvme-fabrics: Add target FC transport support
  nvme-fabrics: Add FC LLDD loopback driver to test FC-NVME

 drivers/nvme/host/Kconfig      |   16 +
 drivers/nvme/host/Makefile     |    3 +
 drivers/nvme/host/fc.c         | 2304 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/Kconfig    |   23 +
 drivers/nvme/target/Makefile   |    4 +
 drivers/nvme/target/fc.c       | 1976 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/fcloop.c   | 1142 ++++++++++++++++++++
 include/linux/nvme-fc-driver.h |  834 +++++++++++++++
 include/linux/nvme-fc.h        |  255 +++++
 include/linux/nvme.h           |   20 +
 include/uapi/scsi/fc/fc_fs.h   |    2 +
 11 files changed, 6579 insertions(+)
 create mode 100644 drivers/nvme/host/fc.c
 create mode 100644 drivers/nvme/target/fc.c
 create mode 100644 drivers/nvme/target/fcloop.c
 create mode 100644 include/linux/nvme-fc-driver.h
 create mode 100644 include/linux/nvme-fc.h

-- 
2.5.0
