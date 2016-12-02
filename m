From: jsmart2021@gmail.com (James Smart)
Date: Fri, 02 Dec 2016 00:28:37 -0800
Subject: [PATCH v6 0/7] nvme-fabrics: Add FC-NVME Transport support
Message-ID: <584130b5.Mgm5p4389WtizRvR%jsmart2021@gmail.com>


The patches in this set add support for the FC transport to the nvme
fabrics subsystem.  The set include header files with T11 transport
definitions and an api for the FC-NVME transport to talk with FC LLDDs.
It also includes host and target transport files. A FC loopback driver
is supplied to act as a FC LLDD to exercise the api.

Revised for review comments from last month.

Cut against linux-block for-next branch as of 12/01

This patchset is dependent upon the following patches:

add u64 number parser
https://groups.google.com/forum/#!msg/fa.linux.kernel/IKtbiXlp3-8/o_1VsNjvDwAJ

and this patch set:

[PATCH 0/2 v2] nvme-fabrics: infrastructure changes for fc protocol support
http://lists.infradead.org/pipermail/linux-nvme/2016-September/006385.html

[PATCH 1/2 v2] nvme-fabrics: patch target code in prep for FC transport support
http://lists.infradead.org/pipermail/linux-nvme/2016-September/006387.html

[PATCH 2/2 v2] nvme-fabrics: set sqe.command_id in core not transports
http://lists.infradead.org/pipermail/linux-nvme/2016-September/006386.html


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
 drivers/nvme/host/Kconfig      |   17 +
 drivers/nvme/host/Makefile     |    3 +
 drivers/nvme/host/fc.c         | 2585 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/Kconfig    |   24 +
 drivers/nvme/target/Makefile   |    4 +
 drivers/nvme/target/fc.c       | 2286 +++++++++++++++++++++++++++++++++++
 drivers/nvme/target/fcloop.c   | 1148 ++++++++++++++++++
 include/linux/nvme-fc-driver.h |  851 +++++++++++++
 include/linux/nvme-fc.h        |  268 +++++
 include/linux/nvme.h           |   13 +
 include/uapi/scsi/fc/fc_fs.h   |    2 +
 12 files changed, 7211 insertions(+)
 create mode 100644 drivers/nvme/host/fc.c
 create mode 100644 drivers/nvme/target/fc.c
 create mode 100644 drivers/nvme/target/fcloop.c
 create mode 100644 include/linux/nvme-fc-driver.h
 create mode 100644 include/linux/nvme-fc.h

-- 
2.5.0
