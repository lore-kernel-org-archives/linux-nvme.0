From: scott.bauer@intel.com (Scott Bauer)
Date: Mon, 19 Dec 2016 12:35:44 -0700
Subject: [PATCH v3 0/5] SED OPAL Library
Message-ID: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>


Changes from v2->v3:

1) Removed the necessity of passing around block devices into the opal
   code. We now pass around a sed_context structure which contains a
   previously allocated opal_dev structure, sec_ops fn pointers, and
   opaque data for the send/recv functions to use.
2) Removed the allocation of the opal_dev structure from the opal_code
   to the driver wishing to use opal. The driver will use a sed_context,
   structure and allocate an opal_dev structure for each device. In the
   case of NVMe we store the sed_context structure in the control struct.
   When someone wishes to issue opal commands down to the controller they
   open the char dev. In the NVMe open implementation we assign our
   sed_context into the file structure.

   Pushing the burden of allocating and storing the opal_dev into the
   driver alleviates a bunch of look up code we had in v1/v2. Now by the
   time we get into the sed-opal code the driver has assigned us a
   sed_context and we operate directly on that.

   This should help with in-kernel use cases as well.
3) Since Opal will operate on the entire device, not per-namespace,
   we moved from block/ to fs/ and will operate on the nvme character
   driver. Because of that  the sed "guts" have moved from block/ back
   to lib/.
4) Numerous code clean ups in sed-opal.c to shorten the file. ~700
   lines reduced
5) Removed the variadic test_and_add_va for a hopefully easier to understand
   and maintain ADD_TOKEN macro that assigns values into the flat buffer
   and does error checking.

--------------------------------------------------------------------

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

All commands are exported through the Fs ioctl.

Scott Bauer (5):
  include: Add definitions for sed
  lib: Add Sed-opal library
  fs: Wire up SED/Opal to ioctl
  nvme: Implement resume_from_suspend and SED Allocation code.
  Maintainers: Add Information for SED Opal library

 MAINTAINERS                   |   10 +
 drivers/nvme/host/core.c      |   67 ++
 drivers/nvme/host/nvme.h      |    8 +-
 drivers/nvme/host/pci.c       |   10 +-
 fs/ioctl.c                    |    3 +
 include/linux/fs.h            |    2 +
 include/linux/sed-opal.h      |   38 +
 include/linux/sed.h           |   76 ++
 include/uapi/linux/sed-opal.h |   94 ++
 include/uapi/linux/sed.h      |   64 ++
 lib/Makefile                  |    2 +-
 lib/sed-opal.c                | 2376 +++++++++++++++++++++++++++++++++++++++++
 lib/sed-opal_internal.h       |  601 +++++++++++
 lib/sed.c                     |  197 ++++
 14 files changed, 3545 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/sed-opal.h
 create mode 100644 include/linux/sed.h
 create mode 100644 include/uapi/linux/sed-opal.h
 create mode 100644 include/uapi/linux/sed.h
 create mode 100644 lib/sed-opal.c
 create mode 100644 lib/sed-opal_internal.h
 create mode 100644 lib/sed.c
