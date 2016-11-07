From: jsmart2021@gmail.com (James Smart)
Date: Sun, 06 Nov 2016 22:23:42 -0800
Subject: [PATCH v5 0/7] nvme-fabrics: Add FC-NVME Transport support
Message-ID: <58201dee.UqykrnPGU60HF9Da%jsmart2021@gmail.com>


I'm reposting due to a change in my email address. My normal
broadcom.com address seems to be marked as spam when used as posting. 

This patchset has 2 minor mods over v4:
in target fc.c - added a check on RS LS processing to ensure LLDD
  forwarded LS via RS-specific callback.
in target fcloop.c - removed some spurious parens

--

The patches in this set add support for the FC transport to the nvme
fabrics subsystem.  The set include header files with T11 transport
definitions and an api for the FC-NVME transport to talk with FC LLDDs.
It also includes host and target transport files. A FC loopback driver
is supplied to act as a FC LLDD to exercise the api.

Revised for review comments from earlier this week.

Cut against linux-block for-next branch as of 11/03

This patchset is dependent upon the following patches:

add u64 number parser
https://groups.google.com/forum/#!msg/fa.linux.kernel/IKtbiXlp3-8/o_1VsNjvDwAJ

[PATCH 1/2] nvme: introduce struct nvme_request
http://lists.infradead.org/pipermail/linux-nvme/2016-October/006855.html

[PATCH 2/2] nvme: don't pass the full CQE to nvme_complete_async_event
http://lists.infradead.org/pipermail/linux-nvme/2016-October/006856.html

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
 drivers/nvme/host/fc.c         | 2441 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/Kconfig    |   24 +
 drivers/nvme/target/Makefile   |    4 +
 drivers/nvme/target/fc.c       | 2317 ++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/fcloop.c   | 1147 +++++++++++++++++++
 include/linux/nvme-fc-driver.h |  847 ++++++++++++++
 include/linux/nvme-fc.h        |  294 +++++
 include/linux/nvme.h           |   20 +
 include/uapi/scsi/fc/fc_fs.h   |    2 +
 12 files changed, 7126 insertions(+)
 create mode 100644 drivers/nvme/host/fc.c
 create mode 100644 drivers/nvme/target/fc.c
 create mode 100644 drivers/nvme/target/fcloop.c
 create mode 100644 include/linux/nvme-fc-driver.h
 create mode 100644 include/linux/nvme-fc.h

-- 
2.5.0
