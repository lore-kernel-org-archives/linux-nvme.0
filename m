From: alex.williamson@redhat.com (Alex Williamson)
Date: Thu, 09 Aug 2018 14:04:14 -0600
Subject: [PATCH v4 1/3] PCI: Export pcie_has_flr()
In-Reply-To: <153384487209.15793.15203778129263981368.stgit@gimli.home>
References: <153384487209.15793.15203778129263981368.stgit@gimli.home>
Message-ID: <153384505430.15793.4988988835441214121.stgit@gimli.home>

pcie_flr() suggests pcie_has_flr() to ensure that PCIe FLR support is
present prior to calling.  pcie_flr() is exported while pcie_has_flr()
is not.  Resolve this.

Signed-off-by: Alex Williamson <alex.williamson at redhat.com>
---
 drivers/pci/pci.c   |    3 ++-
 include/linux/pci.h |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 2bec76c9d9a7..52fe2d72a99c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4071,7 +4071,7 @@ static int pci_dev_wait(struct pci_dev *dev, char *reset_type, int timeout)
  * Returns true if the device advertises support for PCIe function level
  * resets.
  */
-static bool pcie_has_flr(struct pci_dev *dev)
+bool pcie_has_flr(struct pci_dev *dev)
 {
 	u32 cap;
 
@@ -4081,6 +4081,7 @@ static bool pcie_has_flr(struct pci_dev *dev)
 	pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
 	return cap & PCI_EXP_DEVCAP_FLR;
 }
+EXPORT_SYMBOL_GPL(pcie_has_flr);
 
 /**
  * pcie_flr - initiate a PCIe function level reset
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 04c7ea6ed67b..bbe030d7814f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1092,6 +1092,7 @@ u32 pcie_bandwidth_available(struct pci_dev *dev, struct pci_dev **limiting_dev,
 			     enum pci_bus_speed *speed,
 			     enum pcie_link_width *width);
 void pcie_print_link_status(struct pci_dev *dev);
+bool pcie_has_flr(struct pci_dev *dev);
 int pcie_flr(struct pci_dev *dev);
 int __pci_reset_function_locked(struct pci_dev *dev);
 int pci_reset_function(struct pci_dev *dev);
