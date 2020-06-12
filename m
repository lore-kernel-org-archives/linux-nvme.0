Return-Path: <SRS0=+Z1J=7Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B246C433E0
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jun 2020 20:48:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF04207ED
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jun 2020 20:48:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EHN7Njt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF04207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SHAZYJLaVSXphse/ypH2Dbvt7SwENsuIh2bQSegb7no=; b=EHN7Njt48GbF2a
	LD/TFahFowVbgRCr+bbcet5qaAOVpBrDU31ikGyWcQdHw49M5wXahJHBs4uh2lUlW+zUEUau+jD0G
	znONTCb2NYPs1E3q5YyHOoNcdPOhnklasjJtuxAfkYTINk8J8f7tQxDO/zfR88/IA/5TBTKWj5vCi
	iCzTbRDlhZg3XVQP3xXCtPA9pS2GBe42iNNTc/6HuOafOI+oqhIOmAKAJm+nZ1ZXoOMM/5AYh4xYD
	8Cj6O2yeKZyD+E5gPyBTQO+9pBWnaMW/VAOlnkGeUxOEw7kzDzOxWcrQHLCVy1UEFHzKM4Qq/+l4j
	ALfXxccq8kNAXfnDr1Sw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jjqb5-00080u-Ub; Fri, 12 Jun 2020 20:48:19 +0000
Received: from mga01.intel.com ([192.55.52.88])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jjqb2-0007wZ-7Z
 for linux-nvme@lists.infradead.org; Fri, 12 Jun 2020 20:48:18 +0000
IronPort-SDR: YttGqVVaJsV5gxpmPR8wiNWte2kTJMLRqweez1v06+2Fz/vVPO7i+SCxEkJGtR+gdDD2jdlUxd
 g/6y/RsEWsWg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2020 13:48:15 -0700
IronPort-SDR: 4NjQm8C+pO5dahmYLr9aLSNxsQI3iPrulmY0iZIV1TRQ+RfaIf8wugJooB1goa9bH+hO+N2gkq
 l4xr+WQwfPhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,504,1583222400"; d="scan'208";a="448426985"
Received: from linux.intel.com ([10.54.29.200])
 by orsmga005.jf.intel.com with ESMTP; 12 Jun 2020 13:48:14 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com
 [10.54.75.16])
 by linux.intel.com (Postfix) with ESMTP id DE0F95803C5;
 Fri, 12 Jun 2020 13:48:14 -0700 (PDT)
From: "David E. Box" <david.e.box@linux.intel.com>
To: shyjumon.n@intel.com, rjw@rjwysocki.net, lenb@kernel.org,
 bhelgaas@google.com, dan.j.williams@intel.com, kbusch@kernel.org,
 axboe@fb.com, hch@lst.de, sagi@grimberg.me
Subject: [PATCH V2 1/2] PCI: Add ACPI StorageD3Enable _DSD support
Date: Fri, 12 Jun 2020 13:48:19 -0700
Message-Id: <20200612204820.20111-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428003214.3764-1-david.e.box@linux.intel.com>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200612_134816_300446_94CD0D53 
X-CRM114-Status: GOOD (  16.52  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-acpi@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>,
 linux-pci@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

StorageD3Enable is a boolean property that indicates that the platform
wants to use D3 for PCIe storage drives during suspend-to-idle. It is a
BIOS work around that is currently in use on shipping systems like some
Intel Comet Lake platforms. It is meant to change default driver policy for
suspend that may cause higher power consumption.

Add the DSD property for recognition by fwnode calls and provide an
exported symbol for device drivers to use to read the property as needed.

Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/acpi/property.c |  3 +++
 drivers/pci/pci-acpi.c  | 59 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h     |  2 ++
 3 files changed, 64 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index e601c4511a8b..c2e2ae774a19 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -45,6 +45,9 @@ static const guid_t prp_guids[] = {
 	/* Thunderbolt GUID for WAKE_SUPPORTED: 6c501103-c189-4296-ba72-9bf5a26ebe5d */
 	GUID_INIT(0x6c501103, 0xc189, 0x4296,
 		  0xba, 0x72, 0x9b, 0xf5, 0xa2, 0x6e, 0xbe, 0x5d),
+	/* Storage device needs D3 GUID: 5025030f-842f-4ab4-a561-99a5189762d0 */
+	GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
+		  0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
 };
 
 /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index d21969fba6ab..732df524e09c 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -972,6 +972,65 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	return val == 1;
 }
 
+/**
+ * pci_acpi_storage_d3 - whether root port requests D3 for idle suspend
+ * @pdev: PCI device to check
+ *
+ * Returns true if the ACPI companion device contains the "StorageD3Enable"
+ * _DSD property and the value is 1. This indicates that the root port is
+ * used by a storage device and the platform is requesting D3 for the
+ * device during suspend to idle in order to support platform pm.
+ */
+bool pci_acpi_storage_d3(struct pci_dev *dev)
+{
+	const struct fwnode_handle *fwnode;
+	struct acpi_device *adev;
+	struct pci_dev *root;
+	acpi_handle handle;
+	acpi_status status;
+	bool ret = false;
+	u8 val;
+
+	/*
+	 * Look for _DSD property specifying that the storage device on
+	 * the port must use D3 to support deep platform power savings during
+	 * suspend-to-idle
+	 */
+	root = pci_find_pcie_root_port(dev);
+	if (!root)
+		return false;
+
+	adev = ACPI_COMPANION(&root->dev);
+	if (!adev) {
+		/*
+		 * It is possible that the ACPI companion is not yet bound
+		 * for the root port so look it up manually here.
+		 */
+		if (!adev && !pci_dev_is_added(root))
+			adev = acpi_pci_find_companion(&root->dev);
+	}
+
+	if (!adev)
+		return false;
+
+	status = acpi_get_handle(adev->handle, "PXSX", &handle);
+	if (ACPI_FAILURE(status))
+		return false;
+
+	adev = acpi_bus_get_acpi_device(handle);
+	if (!adev)
+		return false;
+
+	fwnode = acpi_fwnode_handle(adev);
+	if (!fwnode_property_read_u8(fwnode, "StorageD3Enable", &val))
+		ret = (val == 1);
+
+	acpi_bus_put_acpi_device(adev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_acpi_storage_d3);
+
 static bool acpi_pci_power_manageable(struct pci_dev *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 83ce1cdf5676..396fcb269a60 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2318,10 +2318,12 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
 void
 pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
 bool pci_pr3_present(struct pci_dev *pdev);
+bool pci_acpi_storage_d3(struct pci_dev *dev);
 #else
 static inline struct irq_domain *
 pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
 static inline bool pci_pr3_present(struct pci_dev *pdev) { return false; }
+static inline bool pci_acpi_storage_d3(struct pci_dev *dev) { return false; }
 #endif
 
 #ifdef CONFIG_EEH
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
