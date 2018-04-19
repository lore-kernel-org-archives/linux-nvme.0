From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 19 Apr 2018 16:05:19 -0500
Subject: [PATCH v1 0/2] PCI/ASPM: Tighten up ASPM L1.2 and LTR usage
Message-ID: <152417080402.76853.4258398181136860884.stgit@bhelgaas-glaptop.roam.corp.google.com>

The ASPM L1.2 substate depends on LTR information.  Per the PCI
Firmware spec, the OS is supposed to negotiate with the platform for
control of the LTR feature, but previously we didn't do that.

In addition, we must not enable LTR in an endpoint unless the Root
Complex and all intermediate switches also support LTR.  We already
took care of that in pci_configure_ltr(), but we didn't ensure that
LTR was enabled before allowing ASPM L1.2 to be enabled.

These patches fix both of these issues.  Or rather, they *should* fix
them.  I don't have hardware to test them, so any help with testing
would be appreciated.

I think the most likely issue would be a platform where the hardware
supports LTR and the ASPM L1.2 substate, but the BIOS doesn't support
LTR in _OSC.  In that case, we previously could have enabled ASPM L1.2
(though it probably wouldn't work correctly), and after these patches,
we should not enable ASPM L1.2.

You can look for issues by comparing dmesg and "lspci -vv" output
before and after these patches.

It would also be interesting to collect an acpidump from platforms
that support LTR, even if there's no endpoint that supports ASPM L1.2.
The acpidump should show that _OSC supports LTR.

I included some NVMe folks because these were motivated by Srinath's
recent report of LTR and ASPM issues with a Samsung NVMe SSD
Controller SM961/PM961 device, so this is sort of FYI in case you see
similar issues or are in a position to test these.

---

Bjorn Helgaas (2):
      PCI/ASPM: Disable ASPM L1.2 Substate if we don't have LTR
      PCI/ACPI: Request LTR control from platform before using it


 drivers/acpi/pci_root.c |    7 +++++++
 drivers/pci/pcie/aspm.c |    9 +++++++++
 drivers/pci/probe.c     |    5 +++++
 include/linux/acpi.h    |    3 ++-
 include/linux/pci.h     |    1 +
 5 files changed, 24 insertions(+), 1 deletion(-)
