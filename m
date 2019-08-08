From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 08 Aug 2019 23:55:07 +0200
Subject: [PATCH v3 1/2] PCI: PCIe: ASPM: Introduce pcie_aspm_enabled()
In-Reply-To: <2184247.yL3mcj2FRQ@kreacher>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <20190731221956.GB15795@localhost.localdomain> <2184247.yL3mcj2FRQ@kreacher>
Message-ID: <1618955.HVa0YQSOW5@kreacher>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a function checking whether or not PCIe ASPM has been enabled for
a given device.

It will be used by the NVMe driver to decide how to handle the
device during system suspend.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki at intel.com>
---

v2 -> v3:
  * Make the new function return bool.
  * Change its name back to pcie_aspm_enabled().
  * Fix kerneldoc comment formatting.

-> v2:
  * Move the PCI/PCIe ASPM changes to a separate patch.
  * Add the _mask suffix to the new function name.
  * Add EXPORT_SYMBOL_GPL() to the new function.
  * Avoid adding an unnecessary blank line.

---
 drivers/pci/pcie/aspm.c |   20 ++++++++++++++++++++
 include/linux/pci.h     |    3 +++
 2 files changed, 23 insertions(+)

Index: linux-pm/drivers/pci/pcie/aspm.c
===================================================================
--- linux-pm.orig/drivers/pci/pcie/aspm.c
+++ linux-pm/drivers/pci/pcie/aspm.c
@@ -1170,6 +1170,26 @@ static int pcie_aspm_get_policy(char *bu
 module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
 	NULL, 0644);
 
+/**
+ * pcie_aspm_enabled - Check if PCIe ASPM has been enabled for a device.
+ * @pci_device: Target device.
+ */
+bool pcie_aspm_enabled(struct pci_dev *pci_device)
+{
+	struct pci_dev *bridge = pci_upstream_bridge(pci_device);
+	bool ret;
+
+	if (!bridge)
+		return false;
+
+	mutex_lock(&aspm_lock);
+	ret = bridge->link_state ? !!bridge->link_state->aspm_enabled : false;
+	mutex_unlock(&aspm_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pcie_aspm_enabled);
+
 #ifdef CONFIG_PCIEASPM_DEBUG
 static ssize_t link_state_show(struct device *dev,
 		struct device_attribute *attr,
Index: linux-pm/include/linux/pci.h
===================================================================
--- linux-pm.orig/include/linux/pci.h
+++ linux-pm/include/linux/pci.h
@@ -1567,8 +1567,11 @@ extern bool pcie_ports_native;
 
 #ifdef CONFIG_PCIEASPM
 bool pcie_aspm_support_enabled(void);
+bool pcie_aspm_enabled(struct pci_dev *pci_device);
 #else
 static inline bool pcie_aspm_support_enabled(void) { return false; }
+static inline bool pcie_aspm_enabled(struct pci_dev *pci_device)
+{ return false; }
 #endif
 
 #ifdef CONFIG_PCIEAER
