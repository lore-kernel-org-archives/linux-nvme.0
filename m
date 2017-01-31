From: scott.bauer@intel.com (Scott Bauer)
Date: Tue, 31 Jan 2017 03:17:20 -0700
Subject: [PATCH v5 0/4] SED OPAL Library
Message-ID: <1485857844-15130-1-git-send-email-scott.bauer@intel.com>

Changes from v4->v5:
0) Fixed single user mode Locking Range activation.
 0a) You can now activate mutltiple SUM ranges. This required a small refactoring
     of the userland ABI and thus the tooling has changed which is available here:
     https://github.com/ScottyBauer/sed-opal-temp
     For those who want to audit the new userland->kernel entry see the
     sed-opal.c:2230:opal_activate_lsp
1) Removed the sed_context and merged it into struct opal_dev
 1a) We now pass around opal_devs
2) Removed some more "dead code" that wasn't really being used and didn't
   have any potential use in the future.
3) Moved the sed_context -- now the opal_dev from one per namespace to one
   per controller. Once Multi namespace locking comes around we can switch back.
   This means there is a opal_dev structure in the nvme_ctrl structure.
4) Per some discussion we will now pass a namespace id of 0 to sec_send/sec_recv
   until either a TCG errata or NVMe errata is available.
5) Removed the BIT/GENMASK stuff from opal_proto and replaced with hex.
6) Moved variable declarations from opal_proto.h to sed-opal.c
7) Removed include/linux/sed.h -- no longer needed
9) Removed sed-ioctl.c and pushed the ioctls into the bottom sed-opal.c
8) Refactored some code in opal_proto.h to be __be types.
10) Did *not* remove the save_discovery bool from opal dev as it's needed
11) did some small refactoring around unlock and unlock_sum there are now
    "private" helper functions __opal_lock_unlock_sum and __opal_lock_unlock
    which allow us to not have the function table in the global scope, but on
    the stack.
12) nvme opal support is only dependent on the config in block/Kconfig
    now

===============================================================================
This Patch series implements a large portion of the Opal protocol for
self encrypting devices. The driver has the capability of storing a
locking range's password. The password can then be replayed
during a resume from previous suspend-to-RAM.

The driver also supports logic to bring the device out of a factory
default-inactive state into a functional Opal state.

The following logic is supported in order to bring the tper into a
working state:

1) Taking Ownership of the drive (Setting the Admin CPIN).
2) Activating the Locking SP (In Single User Mode or Normal Mode).
3) Setting up Locking Ranges (Single User or Normal Mode).
4) Adding users to Locking Ranges (Normal Mode Only).
5) Locking or Unlocking Locking Ranges (Single User Mode or Normal Mode).
6) Reverting the TPer (Restore to factory default).
7) Setting LR/User passwords (Single User Mode or Normal Mode).
8) Enabling/disabling Shadow MBR.
9) Enabling Users in the LockingSP (Normal Mode Only).
10) Saving Password for resume from suspend.
11) Erase and Secure erasing locking ranges.

Scott Bauer (4):
  Include: Uapi: Add user ABI for Sed/Opal
  block: Add Sed-opal library
  nvme: Add Support for Opal: Unlock from S3 & Opal Allocation/Ioctls
  Maintainers: Add maintainer info for SED/Opal code

 MAINTAINERS                   |   11 +
 block/Kconfig                 |    9 +
 block/Makefile                |    1 +
 block/opal_proto.h            |  434 ++++++++
 block/sed-opal.c              | 2476 +++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c      |   50 +
 drivers/nvme/host/nvme.h      |   20 +-
 drivers/nvme/host/pci.c       |    8 +
 include/linux/sed-opal.h      |  181 +++
 include/uapi/linux/sed-opal.h |  115 ++
 10 files changed, 3304 insertions(+), 1 deletion(-)
 create mode 100644 block/opal_proto.h
 create mode 100644 block/sed-opal.c
 create mode 100644 include/linux/sed-opal.h
 create mode 100644 include/uapi/linux/sed-opal.h

-- 
2.7.4
