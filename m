Return-Path: <SRS0=qSsZ=6M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934E1C83004
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 00:32:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60CBB2070B
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 00:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rWqx79zD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CBB2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=HW2Qz00mZGmXh/8HyCNd13EWVbpP5FH1uNEn/ibxM/c=; b=rWqx79zDBe278Q
	Z9UI8mLwzV2OYUNgsLAz1OAzqn1I2reZWNT8uLT0ANAsBz+rUNB6DtGsE+cbV1Gl4rgmVztmVe3ck
	z/176cZWPBzkE6uS+x8hYaQjvivO5/B56U+a2SAG2XPi7AyP1AdIKX3VItBmUyBcg/C61LNlA2fst
	7a9pLTSiiw2Ngb7f3/eINu1++Xwcv+J8wUb+c0rXNjdo9SBM+H/evU+LrskKx9I2NcY22SHEI/Olq
	foUwDxtqV6MGT9jbSxQ80nyWQMbK/SMQ6vAhY80ATJnbdCmMtqSIywjvtV4VW6+nIop27MXhOFDS0
	FPgkThQT0geE5fClP7dQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jTEBC-0000jU-3N; Tue, 28 Apr 2020 00:32:54 +0000
Received: from mga02.intel.com ([134.134.136.20])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTEB9-0000iP-01
 for linux-nvme@lists.infradead.org; Tue, 28 Apr 2020 00:32:52 +0000
IronPort-SDR: YGzlMy0Z85V3zIXrqXKmNDHBXG33q0tPmHnvAyPRCXgPBr3M1LLOLRev+PUBfj3PsFTUvsd6Ur
 TVz4SWIS7flA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 17:32:50 -0700
IronPort-SDR: 34+iHEPkybRq6Oeh47PcPNcKJ8fWXXno08aPz344bOPHq5SVrhIh3DMLCn6PJmSUzsfjGxRxp6
 5ZUEZjy9VZXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; d="scan'208";a="336470353"
Received: from linux.intel.com ([10.54.29.200])
 by orsmga001.jf.intel.com with ESMTP; 27 Apr 2020 17:32:49 -0700
Received: from debox1-hc.jf.intel.com (debox1-hc.jf.intel.com [10.54.75.159])
 by linux.intel.com (Postfix) with ESMTP id C1097580820;
 Mon, 27 Apr 2020 17:32:49 -0700 (PDT)
From: "David E. Box" <david.e.box@linux.intel.com>
To: rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com, kbusch@kernel.org,
 axboe@fb.com, hch@lst.de, sagi@grimberg.me
Subject: [PATCH 1/2] pci: Add ACPI StorageD3Enable _DSD support
Date: Mon, 27 Apr 2020 17:32:13 -0700
Message-Id: <20200428003214.3764-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428003214.3764-1-david.e.box@linux.intel.com>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200427_173251_087281_E171E6D8 
X-CRM114-Status: GOOD (  19.42  )
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
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-acpi@vger.kernel.org,
 "David E. Box" <david.e.box@linux.intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

NVMe storage power management during suspend-to-idle, particularly on
laptops, has been inconsistent with some devices working with D3 while
others must rely on NVMe APST in order for power savings to be realized.
Currently the default is to use APST unless quirked to do otherwise.
However newer platforms, like Intel Comet Lake systems, may require NVMe
drives to use D3 in order for the PCIe ports to be properly power managed.
To make it easier for drivers to choose, these platforms may supply a
special "StorageD3Enable" _DSD property under the root port that the device
is attached to. If supplied, the driver must use D3 in order for the
platform to realize the deepest power savings in suspend-to-idle.

Adds support for the _DSD to the pci/acpi layer.

Acked-by: Dan Williams <dan.j.williams@intel.com>
Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/acpi/property.c |  3 +++
 drivers/pci/pci-acpi.c  | 47 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c       |  6 ++++++
 drivers/pci/pci.h       |  4 ++++
 include/linux/pci.h     |  1 +
 5 files changed, 61 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index e601c4511a8b..f09375ab40e4 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -45,6 +45,9 @@ static const guid_t prp_guids[] = {
 	/* Thunderbolt GUID for WAKE_SUPPORTED: 6c501103-c189-4296-ba72-9bf5a26ebe5d */
 	GUID_INIT(0x6c501103, 0xc189, 0x4296,
 		  0xba, 0x72, 0x9b, 0xf5, 0xa2, 0x6e, 0xbe, 0x5d),
+	/* D3 Support for storage devivce: 5025030f-842f-4ab4-a561-99a5189762d0 */
+	GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
+		  0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
 };
 
 /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index d21969fba6ab..5df249ebf022 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -972,6 +972,52 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	return val == 1;
 }
 
+static bool acpi_pci_storage_d3(struct pci_dev *dev)
+{
+	const struct fwnode_handle *fwnode;
+	struct acpi_device *adev;
+	struct pci_dev *root;
+	acpi_handle handle;
+	acpi_status status;
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
+	if (root == dev) {
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
+		return val == 1;
+
+	return false;
+}
+
 static bool acpi_pci_power_manageable(struct pci_dev *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
@@ -1100,6 +1146,7 @@ static bool acpi_pci_need_resume(struct pci_dev *dev)
 
 static const struct pci_platform_pm_ops acpi_pci_platform_pm = {
 	.bridge_d3 = acpi_pci_bridge_d3,
+	.storage_d3 = acpi_pci_storage_d3,
 	.is_manageable = acpi_pci_power_manageable,
 	.set_state = acpi_pci_set_power_state,
 	.get_state = acpi_pci_get_power_state,
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 595fcf59843f..217d89f31e8b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -871,6 +871,11 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 	return pci_platform_pm ? pci_platform_pm->bridge_d3(dev) : false;
 }
 
+static inline bool platform_pci_storage_d3(struct pci_dev *dev)
+{
+	return pci_platform_pm->storage_d3(dev);
+}
+
 /**
  * pci_raw_set_power_state - Use PCI PM registers to set the power state of
  *			     given PCI device
@@ -2903,6 +2908,7 @@ void pci_pm_init(struct pci_dev *dev)
 	dev->d3_delay = PCI_PM_D3_WAIT;
 	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
 	dev->bridge_d3 = pci_bridge_d3_possible(dev);
+	dev->storage_d3 = platform_pci_storage_d3(dev);
 	dev->d3cold_allowed = true;
 
 	dev->d1_support = false;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6d3f75867106..4dc4d05da810 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -53,6 +53,9 @@ int pci_bus_error_reset(struct pci_dev *dev);
  *
  * @bridge_d3: Does the bridge allow entering into D3
  *
+ * @storage_d3: 'true' if the bridge contains a storage device that must use D3
+ *		to support platform s2idle
+ *
  * @is_manageable: returns 'true' if given device is power manageable by the
  *		   platform firmware
  *
@@ -77,6 +80,7 @@ int pci_bus_error_reset(struct pci_dev *dev);
  */
 struct pci_platform_pm_ops {
 	bool (*bridge_d3)(struct pci_dev *dev);
+	bool (*storage_d3)(struct pci_dev *dev);
 	bool (*is_manageable)(struct pci_dev *dev);
 	int (*set_state)(struct pci_dev *dev, pci_power_t state);
 	pci_power_t (*get_state)(struct pci_dev *dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 83ce1cdf5676..cbba1555020b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -346,6 +346,7 @@ struct pci_dev {
 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
 	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
 	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
+	unsigned int	storage_d3:1;	/* Storage dev must use D3 for s2idle */
 	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
 	unsigned int	mmio_always_on:1;	/* Disallow turning off io/mem
 						   decoding during BAR sizing */
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
