From: drake@endlessm.com (Daniel Drake)
Date: Thu, 20 Jun 2019 13:13:28 +0800
Subject: [PATCH v2 0/5] Support Intel AHCI remapped NVMe devices
Message-ID: <20190620051333.2235-1-drake@endlessm.com>

Intel SATA AHCI controllers support a strange mode where NVMe devices
disappear from the PCI bus, and instead are remapped into AHCI PCI memory
space.

Many current and upcoming consumer products ship with the AHCI controller
in this "RAID" or "Intel RST Premium with Intel Optane System Acceleration"
mode by default. Without Linux support for this remapped mode,
the default out-of-the-box experience is that the NVMe storage device
is inaccessible (which in many cases is the only internal storage device).

In most cases, the SATA configuration can be changed in the BIOS menu to
"AHCI", resulting in the AHCI & NVMe devices appearing as separate
devices as you would ordinarily expect. Changing this configuration
is the recommendation for power users because there are several limitations
of the remapped mode (now documented in Kconfig help text).

However, it's also important to support the remapped mode given that
it is an increasingly common product default. We cannot expect ordinary
users of consumer PCs to find out about this situation and then
confidently go into the BIOS menu to change options.

This patch set implements support for the remapped mode.

v1 of these patches was originally posted by Dan Williams in 2016.
https://marc.info/?l=linux-ide&m=147709610621480&w=2
Since then:

 - Intel stopped developing these patches & hasn't been responding to
   my emails on this topic.

 - More register documentation appeared in
   https://www.intel.com/content/dam/www/public/us/en/documents/datasheets/300-series-chipset-pch-datasheet-vol-2.pdf

 - I tried Christoph's suggestion of exposing the devices on a fake PCI bus,
   hence not requiring NVMe driver changes, but Bjorn Helgaas does not think
   it's the right approach and instead recommends the approach taken here.
   https://marc.info/?l=linux-pci&m=156034736822205&w=2

 - More consumer devices have appeared with this setting as the default,
   and with the decreasing cost of NVMe storage, it appears that a whole
   bunch more consumer PC products currently in development are going to
   ship in RAID/remapped mode, with only a single NVMe disk, which Linux
   will otherwise be unable to access by default.

 - We heard from hardware vendors that this Linux incompatibility is
   causing them to consider discontinuing Linux support on affected
   products. Changing the BIOS setting is too much of a logistics
   challenge.

 - I updated Dan's patches for current kernels. I added docs and references
   and incorporated the new register info. I incorporated feedback to push
   the recommendation that the user goes back to AHCI mode via the BIOS
   setting (in kernel logs and Kconfig help). And made some misc minor
   changes that I think are sensible.

 - I investigated MSI-X support. Can't quite get it working, but I'm hopeful
   that we can figure it out and add it later. With these patches shared
   I'll follow up with more details about that. With the focus on
   compatibility with default configuration of common consumer products,
   I'm hoping we could land an initial version without MSI support before
   tending to those complications.

Dan Williams (2):
  nvme: rename "pci" operations to "mmio"
  nvme: move common definitions to pci.h

Daniel Drake (3):
  ahci: Discover Intel remapped NVMe devices
  nvme: introduce nvme_dev_ops
  nvme: Intel AHCI remap support

 drivers/ata/Kconfig                  |  33 ++
 drivers/ata/ahci.c                   | 173 ++++++++--
 drivers/ata/ahci.h                   |  14 +
 drivers/nvme/host/Kconfig            |   3 +
 drivers/nvme/host/Makefile           |   3 +
 drivers/nvme/host/intel-ahci-remap.c | 185 ++++++++++
 drivers/nvme/host/pci.c              | 490 ++++++++++++++-------------
 drivers/nvme/host/pci.h              | 145 ++++++++
 include/linux/ahci-remap.h           | 140 +++++++-
 9 files changed, 922 insertions(+), 264 deletions(-)
 create mode 100644 drivers/nvme/host/intel-ahci-remap.c
 create mode 100644 drivers/nvme/host/pci.h

-- 
2.20.1
