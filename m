From: scott.bauer@intel.com (Scott Bauer)
Date: Thu, 29 Dec 2016 14:00:58 -0700
Subject: [PATCH v4 0/6] SED OPAL Library
In-Reply-To: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
References: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
Message-ID: <20161229210057.GA22802@sbauer-Z170X-UD5>

Apparently I can't insert in emacs to save my life, here is 1->4:



Changes from v3->v4:
1) Moved back from lib/ to block/
2) Files are hidden behind a CONFIG_ must be explicitly enabled in menuconfig
3) NVMe support is hidden behind a CONFIG_ that depends on the above CONFIG
4) Fixed Issues pointed out by Christoph and Jon in previous v3 review.
  4a) Tried to aggregate UAPI/In kernel structures/On-the-wire structures into
      seperate headers.
  4b) Renamed block/sed.c to block/sed-ioctl.c...
      There was discussion around trying to remove the sed to opal inderection.
      The code still has some inderection, but it's specifically for doing
      copy_from_user before going into the opal core. I want to keep the sed-opal.c
      a "Library" where it doesn't have to do any copy_from_user stuff. This way,
      when we have in-kernel users they don't have to do gross get_fs(), set_fs()
      calls.


On Thu, Dec 29, 2016@12:26:49PM -0700, Scott Bauer wrote:
> 5) Removed dependency on the file struct. We also do not add a new entry into the
>    block structures. We enter through the drivers block ioctl handler, which will
>    test if it's a sed ioctl. If it is, we pass a previously allocated sed_context
>    structure, cmd and arg, into the sed-ioctl.c which will dispatch it into the opal
>    core.
> 
> 6) The NVMe patch changed a bit:
>    The sed_context is now per-namespace for two reasons. First The spec says we have
>    to send a namespace ID for the security commands, even if TCG spec currently
>    ignores them. Second, there is public review for a modification to the spec where
>    the namespace ID will be vitally important:
>    https://www.trustedcomputinggroup.org/wp-content/uploads/TCG_Storage_Feature_Set_Namespaces_phase_1b_v1_00_r1_19_public-review.pdf
> 
> 7) To facilitate the above public review changes, and potentially future changes
>    the Opal core now exposes a new method which in-kernel users can call:
>    is_opal_supported().
>    The method is not exposed to userland, but will be used for drivers who wish to
>    see if their controller supports Opal. The function can save the entire disovery0
>    payload which the driver can then parse to find out more info.
> 
> 8) The NVMe driver now calls the new function above to see if the controller
>    supports opal. If it does not we free the structures. The current implementation
>    does not save the discovery0 payload. When the public review spec is finalized
>    and someone ships devices with multiple namespace multiple LR support they can
>    modify the code to save the payload and parse it to figure out what NS/LR mode
>    they're going to be operating in.
> 
> 
> ===============================================================================
> This Patch series implements a large portion of the Opal protocol for
> self encrypting devices. The driver has the capability of storing a
> locking range's password. The password can then be replayed
> during a resume from previous suspend-to-RAM.
> 
> The driver also supports logic to bring the device out of a factory
> default-inactive state into a functional Opal state.
> 
> The following logic is supported in order to bring the tper into a
> working state:
> 
> 1) Taking Ownership of the drive (Setting the Admin CPIN).
> 2) Activating the Locking SP (In Single User Mode or Normal Mode).
> 3) Setting up Locking Ranges (Single User or Normal Mode).
> 4) Adding users to Locking Ranges (Normal Mode Only).
> 5) Locking or Unlocking Locking Ranges (Single User Mode or Normal Mode).
> 6) Reverting the TPer (Restore to factory default).
> 7) Setting LR/User passwords (Single User Mode or Normal Mode).
> 8) Enabling/disabling Shadow MBR.
> 9) Enabling Users in the LockingSP (Normal Mode Only).
> 10) Saving Password for resume from suspend.
> 11) Erase and Secure erasing locking ranges.
> 
> Scott Bauer (6):
>   Include: Uapi: Add user ABI for Sed/Opal
>   block: Add Sed-opal library
>   block: add ioctl interface for interfacing with Opal library
>   block: Add Opal Files to Makefile & add config option to Kconfig
>   nvme: Add Support for Opal: Unlock from S3 & Opal Allocation/Ioctls
>   Maintainers: Add maintainer info for SED/Opal library
> 
>  MAINTAINERS                   |   11 +
>  block/Kconfig                 |    6 +
>  block/Makefile                |    1 +
>  block/opal_proto.h            |  588 ++++++++++
>  block/sed-ioctl.c             |  164 +++
>  block/sed-opal.c              | 2392 +++++++++++++++++++++++++++++++++++++++++
>  drivers/nvme/host/Kconfig     |    7 +
>  drivers/nvme/host/core.c      |   78 ++
>  drivers/nvme/host/nvme.h      |    9 +-
>  drivers/nvme/host/pci.c       |    4 +
>  include/linux/sed-opal.h      |   59 +
>  include/linux/sed.h           |   80 ++
>  include/uapi/linux/sed-opal.h |  107 ++
>  13 files changed, 3505 insertions(+), 1 deletion(-)
>  create mode 100644 block/opal_proto.h
>  create mode 100644 block/sed-ioctl.c
>  create mode 100644 block/sed-opal.c
>  create mode 100644 include/linux/sed-opal.h
>  create mode 100644 include/linux/sed.h
>  create mode 100644 include/uapi/linux/sed-opal.h
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
