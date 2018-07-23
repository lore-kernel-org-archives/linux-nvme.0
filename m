From: alex.williamson@redhat.com (Alex Williamson)
Date: Mon, 23 Jul 2018 16:24:14 -0600
Subject: [PATCH 0/2] PCI: NVMe reset quirk
Message-ID: <20180723221533.4371.90064.stgit@gimli.home>

As discussed in the 2nd patch, at least one NVMe controller sometimes
doesn't like being reset while enabled and another will timeout during
a subsequent re-enable if it happens too quickly after reset.
Introduce a device specific reset quirk for all NVMe class devices so
that we can try to get reliable behavior from them for device
assignment and any other users of the PCI subsystem reset interface.

Patches against current PCI next branch.  Thanks,

Alex

---

Alex Williamson (2):
      PCI: Export pcie_has_flr()
      PCI: NVMe device specific reset quirk


 drivers/pci/pci.c    |    3 +
 drivers/pci/quirks.c |  112 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h  |    1 
 3 files changed, 115 insertions(+), 1 deletion(-)
