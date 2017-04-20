From: luto@kernel.org (Andy Lutomirski)
Date: Wed, 19 Apr 2017 20:02:17 -0700
Subject: [PATCH 4/5] nvme: Adjust the Samsung APST quirk
In-Reply-To: <cover.1492656278.git.luto@kernel.org>
References: <cover.1492656278.git.luto@kernel.org>
Message-ID: <a3e55fbb6afca363fcae66ca7d30f1175793594b.1492656278.git.luto@kernel.org>

I got a couple more reports: the Samsung APST issues appears to
affect multiple 950-series devices in Dell XPS 15 9550 and Precision
5510 laptops.  Change the quirk: rather than blacklisting the
firmware on the first problematic SSD that was reported, disable
APST on all 144d:a802 devices if they're installed in the two
affected Dell models.  While we're at it, disable only the deepest
sleep state instead of all of them -- the reporters say that this is
sufficient to fix the problem.

(I have a device that appears to be entirely identical to one of the
affected devices, but I have a different Dell laptop, so it's not
the case that all Samsung devices with firmware BXW75D0Q are broken
under all circumstances.)

Samsung engineers have an affected system, and hopefully they'll
give us a better workaround some time soon.  In the mean time, this
should minimize regressions.

See https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1678184

Cc: Kai-Heng Feng <kai.heng.feng at canonical.com>
Cc: Niranjan Sivakumar <ns253 at cornell.edu>
Signed-off-by: Andy Lutomirski <luto at kernel.org>
---
 drivers/nvme/host/core.c | 23 +++++++++++++----------
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  | 26 +++++++++++++++++++++++++-
 3 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b422996f88ed..bec8c6973ae5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1323,6 +1323,14 @@ static void nvme_configure_apst(struct nvme_ctrl *ctrl)
 				table->entries[state] = target;
 
 			/*
+			 * Don't allow transitions to the deepest state
+			 * if it's quirked off.
+			 */
+			if (state == ctrl->npss &&
+			    (ctrl->quirks & NVME_QUIRK_NO_DEEPEST_PS))
+				continue;
+
+			/*
 			 * Is this state a useful non-operational state for
 			 * higher-power states to autonomously transition to?
 			 */
@@ -1407,16 +1415,6 @@ struct nvme_core_quirk_entry {
 };
 
 static const struct nvme_core_quirk_entry core_quirks[] = {
-	/*
-	 * Seen on a Samsung "SM951 NVMe SAMSUNG 256GB": using APST causes
-	 * the controller to go out to lunch.  It dies when the watchdog
-	 * timer reads CSTS and gets 0xffffffff.
-	 */
-	{
-		.vid = 0x144d,
-		.fr = "BXW75D0Q",
-		.quirks = NVME_QUIRK_NO_APST,
-	},
 };
 
 /* match is null-terminated but idstr is space-padded. */
@@ -1501,6 +1499,11 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		}
 	}
 
+	if (force_apst && (ctrl->quirks & NVME_QUIRK_NO_DEEPEST_PS)) {
+		dev_warn(ctrl->dev, "forcibly allowing all power states due to nvme_core.force_apst -- use at your own risk\n");
+		ctrl->quirks &= ~NVME_QUIRK_NO_DEEPEST_PS;
+	}
+
 	ctrl->oacs = le16_to_cpu(id->oacs);
 	ctrl->vid = le16_to_cpu(id->vid);
 	ctrl->oncs = le16_to_cpup(&id->oncs);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2aa20e3e5675..ab2d6ec7eb5c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -83,6 +83,11 @@ enum nvme_quirks {
 	 * APST should not be used.
 	 */
 	NVME_QUIRK_NO_APST			= (1 << 4),
+
+	/*
+	 * The deepest sleep state should not be used.
+	 */
+	NVME_QUIRK_NO_DEEPEST_PS		= (1 << 5),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 26a5fd05fe88..5d309535abbd 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -19,6 +19,7 @@
 #include <linux/blk-mq-pci.h>
 #include <linux/cpu.h>
 #include <linux/delay.h>
+#include <linux/dmi.h>
 #include <linux/errno.h>
 #include <linux/fs.h>
 #include <linux/genhd.h>
@@ -1943,10 +1944,31 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	return -ENODEV;
 }
 
+static unsigned long check_dell_samsung_bug(struct pci_dev *pdev)
+{
+	if (pdev->vendor == 0x144d && pdev->device == 0xa802) {
+		/*
+		 * Several Samsung devices seem to drop off the PCIe bus
+		 * randomly when APST is on and uses the deepest sleep state.
+		 * This has been observed on a Samsung "SM951 NVMe SAMSUNG
+		 * 256GB", a "PM951 NVMe SAMSUNG 512GB", and a "Samsung SSD
+		 * 950 PRO 256GB", but it seems to be restricted to two Dell
+		 * laptops.
+		 */
+		if (dmi_match(DMI_SYS_VENDOR, "Dell Inc.") &&
+		    (dmi_match(DMI_PRODUCT_NAME, "XPS 15 9550") ||
+		     dmi_match(DMI_PRODUCT_NAME, "Precision 5510")))
+			return NVME_QUIRK_NO_DEEPEST_PS;
+	}
+
+	return 0;
+}
+
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int node, result = -ENOMEM;
 	struct nvme_dev *dev;
+	unsigned long quirks = id->driver_data;
 
 	node = dev_to_node(&pdev->dev);
 	if (node == NUMA_NO_NODE)
@@ -1978,8 +2000,10 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto put_pci;
 
+	quirks |= check_dell_samsung_bug(pdev);
+
 	result = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
-			id->driver_data);
+			quirks);
 	if (result)
 		goto release_pools;
 
-- 
2.9.3
