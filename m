From: scott.bauer@intel.com (Scott Bauer)
Date: Thu, 29 Dec 2016 12:26:49 -0700
Subject: [PATCH v4 0/6] SED OPAL Library
Message-ID: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>

5) Removed dependency on the file struct. We also do not add a new entry into the
   block structures. We enter through the drivers block ioctl handler, which will
   test if it's a sed ioctl. If it is, we pass a previously allocated sed_context
   structure, cmd and arg, into the sed-ioctl.c which will dispatch it into the opal
   core.

6) The NVMe patch changed a bit:
   The sed_context is now per-namespace for two reasons. First The spec says we have
   to send a namespace ID for the security commands, even if TCG spec currently
   ignores them. Second, there is public review for a modification to the spec where
   the namespace ID will be vitally important:
   https://www.trustedcomputinggroup.org/wp-content/uploads/TCG_Storage_Feature_Set_Namespaces_phase_1b_v1_00_r1_19_public-review.pdf

7) To facilitate the above public review changes, and potentially future changes
   the Opal core now exposes a new method which in-kernel users can call:
   is_opal_supported().
   The method is not exposed to userland, but will be used for drivers who wish to
   see if their controller supports Opal. The function can save the entire disovery0
   payload which the driver can then parse to find out more info.

8) The NVMe driver now calls the new function above to see if the controller
   supports opal. If it does not we free the structures. The current implementation
   does not save the discovery0 payload. When the public review spec is finalized
   and someone ships devices with multiple namespace multiple LR support they can
   modify the code to save the payload and parse it to figure out what NS/LR mode
   they're going to be operating in.


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

Scott Bauer (6):
  Include: Uapi: Add user ABI for Sed/Opal
  block: Add Sed-opal library
  block: add ioctl interface for interfacing with Opal library
  block: Add Opal Files to Makefile & add config option to Kconfig
  nvme: Add Support for Opal: Unlock from S3 & Opal Allocation/Ioctls
  Maintainers: Add maintainer info for SED/Opal library

 MAINTAINERS                   |   11 +
 block/Kconfig                 |    6 +
 block/Makefile                |    1 +
 block/opal_proto.h            |  588 ++++++++++
 block/sed-ioctl.c             |  164 +++
 block/sed-opal.c              | 2392 +++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/Kconfig     |    7 +
 drivers/nvme/host/core.c      |   78 ++
 drivers/nvme/host/nvme.h      |    9 +-
 drivers/nvme/host/pci.c       |    4 +
 include/linux/sed-opal.h      |   59 +
 include/linux/sed.h           |   80 ++
 include/uapi/linux/sed-opal.h |  107 ++
 13 files changed, 3505 insertions(+), 1 deletion(-)
 create mode 100644 block/opal_proto.h
 create mode 100644 block/sed-ioctl.c
 create mode 100644 block/sed-opal.c
 create mode 100644 include/linux/sed-opal.h
 create mode 100644 include/linux/sed.h
 create mode 100644 include/uapi/linux/sed-opal.h
