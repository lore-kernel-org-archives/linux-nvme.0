Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28386C27C43
	for <linux-nvme@archiver.kernel.org>; Wed, 29 May 2024 14:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Date:From:
	Message-Id:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=v1Aul/UsQ9ocNeZh7Ay7K//+f4JyViug5uIsIYN3gcA=; b=GwA30hkKf1QtJ+GE4O6A/ZTZZM
	ceOokuoG4R3emrST/Mn9TRSb8RBt7MAqawSFrAYfaRVZq5nQ41ogl5UQuDNwhsigyV97UHonVR2uc
	Y5xD90mXDfjQiN6xd6EU1cQsvboXnCkHZ/2goLYVyFdCWUWxjbSXH1e/CVE2xjUN4DzbwHxYSe6Yg
	71SSYjab7Gsh25GJkyTcW3p4yy2KsapL0o9mNq5ge6Bu1doaLYQUyiyGwxC1zMfrcUel63u38qUX1
	KiReKGtcICtsrI2GTu+5R/eEqnC7Gv9igdD/NFUTUEpVh/nHWhzDR3bMtB0xGPfsTNwRYggyaNcpp
	h4Sl2yVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCKUO-00000004WD7-4Ad6;
	Wed, 29 May 2024 14:41:17 +0000
Received: from bmailout3.hostsharing.net ([2a01:4f8:150:2161:1:b009:f23e:0])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCKUK-00000004W8J-1EWW
	for linux-nvme@lists.infradead.org;
	Wed, 29 May 2024 14:41:15 +0000
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 39E2D10195455;
	Wed, 29 May 2024 16:32:09 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E4FC6230885; Wed, 29 May 2024 16:32:08 +0200 (CEST)
Message-Id: <a1afaa12f341d146ecbea27c1743661c71683833.1716992815.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Wed, 29 May 2024 16:32:09 +0200
Subject: [PATCH] PCI: pciehp: Detect device replacement during system sleep
To: Bjorn Helgaas <helgaas@kernel.org>, Ricky Wu <ricky_wu@realtek.com>
Cc: Scott Murray <scott@spiteful.org>, Keith Busch <kbusch@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Aapo Vienamo <aapo.vienamo@linux.intel.com>, linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240529_074112_540956_A92179D5 
X-CRM114-Status: GOOD (  20.06  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ricky reports that replacing a device in a hotplug slot during ACPI
sleep state S3 does not cause re-enumeration on resume, as one would
expect.  Instead, the new device is treated as if it was the old one.

There is no bulletproof way to detect device replacement, but as a
heuristic, check whether the device identity in config space matches
cached data in struct pci_dev (Vendor ID, Device ID, Class Code,
Revision ID, Subsystem Vendor ID, Subsystem ID).  Additionally, cache
and compare the Device Serial Number (PCIe r6.2 sec 7.9.3).  If a
mismatch is detected, mark the old device disconnected (to prevent its
driver from accessing the new device) and synthesize a Presence Detect
Changed event.

The device identity in config space which is compared here is the same
as the one included in the signed Subject Alternative Name per PCIe r6.1
sec 6.31.3.  Thus, the present commit prevents attacks where a valid
device is replaced with a malicious device during system sleep and the
valid device's driver obliviously accesses the malicious device.

This is about as much as can be done at the PCI layer.  Drivers may have
additional ways to identify devices (such as reading a WWID from some
register) and may trigger re-enumeration when detecting an identity
change on resume.

Reported-by: Ricky Wu <ricky_wu@realtek.com>
Closes: https://lore.kernel.org/r/a608b5930d0a48f092f717c0e137454b@realtek.com
Tested-by: Ricky Wu <ricky_wu@realtek.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp.h      |  4 ++++
 drivers/pci/hotplug/pciehp_core.c | 42 ++++++++++++++++++++++++++++++++++++++-
 drivers/pci/hotplug/pciehp_hpc.c  |  5 +++++
 drivers/pci/hotplug/pciehp_pci.c  |  4 ++++
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index e0a614a..273dd8c 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -46,6 +46,9 @@
 /**
  * struct controller - PCIe hotplug controller
  * @pcie: pointer to the controller's PCIe port service device
+ * @dsn: cached copy of Device Serial Number of Function 0 in the hotplug slot
+ *	(PCIe r6.2 sec 7.9.3); used to determine whether a hotplugged device
+ *	was replaced with a different one during system sleep
  * @slot_cap: cached copy of the Slot Capabilities register
  * @inband_presence_disabled: In-Band Presence Detect Disable supported by
  *	controller and disabled per spec recommendation (PCIe r5.0, appendix I
@@ -87,6 +90,7 @@
  */
 struct controller {
 	struct pcie_device *pcie;
+	u64 dsn;
 
 	u32 slot_cap;				/* capabilities and quirks */
 	unsigned int inband_presence_disabled:1;
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index ddd55ad..ff458e6 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -284,6 +284,32 @@ static int pciehp_suspend(struct pcie_device *dev)
 	return 0;
 }
 
+static bool pciehp_device_replaced(struct controller *ctrl)
+{
+	struct pci_dev *pdev __free(pci_dev_put);
+	u32 reg;
+
+	pdev = pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0));
+	if (!pdev)
+		return true;
+
+	if (pci_read_config_dword(pdev, PCI_VENDOR_ID, &reg) ||
+	    reg != (pdev->vendor | (pdev->device << 16)) ||
+	    pci_read_config_dword(pdev, PCI_CLASS_REVISION, &reg) ||
+	    reg != (pdev->revision | (pdev->class << 8)))
+		return true;
+
+	if (pdev->hdr_type == PCI_HEADER_TYPE_NORMAL &&
+	    (pci_read_config_dword(pdev, PCI_SUBSYSTEM_VENDOR_ID, &reg) ||
+	     reg != (pdev->subsystem_vendor | (pdev->subsystem_device << 16))))
+		return true;
+
+	if (pci_get_dsn(pdev) != ctrl->dsn)
+		return true;
+
+	return false;
+}
+
 static int pciehp_resume_noirq(struct pcie_device *dev)
 {
 	struct controller *ctrl = get_service_data(dev);
@@ -293,9 +319,23 @@ static int pciehp_resume_noirq(struct pcie_device *dev)
 	ctrl->cmd_busy = true;
 
 	/* clear spurious events from rediscovery of inserted card */
-	if (ctrl->state == ON_STATE || ctrl->state == BLINKINGOFF_STATE)
+	if (ctrl->state == ON_STATE || ctrl->state == BLINKINGOFF_STATE) {
 		pcie_clear_hotplug_events(ctrl);
 
+		/*
+		 * If hotplugged device was replaced with a different one
+		 * during system sleep, mark the old device disconnected
+		 * (to prevent its driver from accessing the new device)
+		 * and synthesize a Presence Detect Changed event.
+		 */
+		if (pciehp_device_replaced(ctrl)) {
+			ctrl_dbg(ctrl, "device replaced during system sleep\n");
+			pci_walk_bus(ctrl->pcie->port->subordinate,
+				     pci_dev_set_disconnected, NULL);
+			pciehp_request(ctrl, PCI_EXP_SLTSTA_PDC);
+		}
+	}
+
 	return 0;
 }
 #endif
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index b1d0a1b3..061f01f 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -1055,6 +1055,11 @@ struct controller *pcie_init(struct pcie_device *dev)
 		}
 	}
 
+	pdev = pci_get_slot(subordinate, PCI_DEVFN(0, 0));
+	if (pdev)
+		ctrl->dsn = pci_get_dsn(pdev);
+	pci_dev_put(pdev);
+
 	return ctrl;
 }
 
diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index ad12515..65e50be 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -72,6 +72,10 @@ int pciehp_configure_device(struct controller *ctrl)
 	pci_bus_add_devices(parent);
 	down_read_nested(&ctrl->reset_lock, ctrl->depth);
 
+	dev = pci_get_slot(parent, PCI_DEVFN(0, 0));
+	ctrl->dsn = pci_get_dsn(dev);
+	pci_dev_put(dev);
+
  out:
 	pci_unlock_rescan_remove();
 	return ret;
-- 
2.43.0


