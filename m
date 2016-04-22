From: rafael.antognolli@intel.com (Rafael Antognolli)
Date: Fri, 22 Apr 2016 16:12:10 -0700
Subject: [PATCH 0/2] Add Opal unlock support to NVMe.
Message-ID: <1461366732-31779-1-git-send-email-rafael.antognolli@intel.com>

This patch series implement a small set of the Opal protocol for self
encrypting devices. It's implemented only what is needed for saving a password
and unlocking a given "locking range". The password is saved on the driver and
replayed back to the device on resume from suspend to RAM. It is specifically
supporting the single user mode.

It is not planned to implement the full Opal protocol (at least not for now).

Rafael Antognolli (2):
  Add optane OPAL unlocking code.
  NVMe: Add ioctls to save and unlock an Opal locking range.

 drivers/nvme/host/Kconfig         |    7 +
 drivers/nvme/host/Makefile        |    1 +
 drivers/nvme/host/core.c          |    9 +
 drivers/nvme/host/opal.c          | 1270 +++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/opal.h          |   73 +++
 drivers/nvme/host/opal_internal.h |  501 +++++++++++++++
 include/uapi/linux/nvme_ioctl.h   |    7 +
 7 files changed, 1868 insertions(+)
 create mode 100644 drivers/nvme/host/opal.c
 create mode 100644 drivers/nvme/host/opal.h
 create mode 100644 drivers/nvme/host/opal_internal.h

-- 
1.9.1
