Return-Path: <SRS0=peCB=2B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB66C43603
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 02:35:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D90CB2073B
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 02:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KqqiGEHU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D90CB2073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=IRThONVTF86nOAiZunBamv/coOkAMZ0ilLOVMHVkHsw=; b=KqqiGEHU9CoRS8
	rRrK03c7CirDXHLBAhXGr1L6JDNlk+QOtMnJNNMTHidNIzLcbpGEJsNvOV1vXYQI71xp1+zaSoqts
	tWUIaHnZB4sCMC3v1rPTCf/vc/c1iZ9RJiPtSJs+5ahnz3UNSgCPrXCuOHkWoCOXoMwDTvG5N6rt3
	vEIcRgjcJsFIouzYTp1f5wGsqBhtNHPuzOtHJF/MGtpFQvyDLqlaXJpANudPXgiOW2QsXjarCqG94
	ZnJtg84t83voSh7+TByVd0wJd9+pyPe2bBnFwjzHDBzCPPodgyZKHaQYaAX1hWdEl3Ft3fwNfn0Lv
	ljpEDvl4EOpR1597ryxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ierqp-0006RQ-3A; Wed, 11 Dec 2019 02:35:43 +0000
Received: from mo-csw1515.securemx.jp ([210.130.202.154]
 helo=mo-csw.securemx.jp)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ierqB-0004oR-J8
 for linux-nvme@lists.infradead.org; Wed, 11 Dec 2019 02:35:05 +0000
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id xBB2YicU019547;
 Wed, 11 Dec 2019 11:34:44 +0900
X-Iguazu-Qid: 34tKPkPWIw0DXPerBK
X-Iguazu-QSIG: v=2; s=0; t=1576031684; q=34tKPkPWIw0DXPerBK;
 m=xhT1B7+D9uEHNdxM4C40YMkF8QwjGE/ztVRPW+Pfln0=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
 by relay.securemx.jp (mx-mr1512) id xBB2Ygp7001405;
 Wed, 11 Dec 2019 11:34:42 +0900
Received: from enc01.localdomain ([106.186.93.100])
 by imx2.toshiba.co.jp  with ESMTP id xBB2YgFS012217;
 Wed, 11 Dec 2019 11:34:42 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
 by enc01.localdomain  with ESMTP id xBB2YfTN015257;
 Wed, 11 Dec 2019 11:34:41 +0900
From: <tsutomu.owa@kioxia.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>, 
 <hch@infradead.org>
Subject: [RFC PATCH 3/5] nvme: to add support for nvme reset functions
Thread-Topic: [RFC PATCH 3/5] nvme: to add support for nvme reset functions
Thread-Index: AdWvycx6nkq0X+gWTUeHvRDR+pcujA==
Date: Wed, 11 Dec 2019 02:34:40 +0000
X-TSB-HOP: ON
Message-ID: <246650b70a704700b0f5da570ca6578f@tgxml778.toshiba.local>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [133.118.176.119]
msscp.transfermailtomossagent: 103
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191210_183503_872117_00756BAD 
X-CRM114-Status: GOOD (  13.40  )
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
Cc: tsutomu.owa@kioxia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch adds support for nvme reset functions described in NVMe spec
1.3c "7.3.2 Controller Level Reset" (conventional hot reset,
link down reset and function level reset).

Signed-off-by: Tsutomu OWA <tsutomu.owa@kioxia.com>
---
 drivers/nvme/host/core.c        | 122 ++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h        |   4 ++
 drivers/nvme/host/pci.c         |  11 +++
 include/linux/nvme.h            |   4 ++
 include/uapi/linux/nvme_ioctl.h |  43 +++++++++++
 5 files changed, 184 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dfe37a525..65e3ef820 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -94,6 +94,113 @@ static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
 
+#ifdef CONFIG_NVME_PCI_RESET
+static int nvme_conventional_hot_reset(struct pci_dev *bridge)
+{
+	return pci_bridge_secondary_bus_reset(bridge);
+}
+
+#define PCIE_RESET_READY_POLL_MS	60000
+static int nvme_link_down_reset(struct pci_dev *pdev, struct pci_dev *bridge)
+{
+	/* link down */
+	pcie_capability_set_word(bridge, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_LD);
+
+	msleep(100);
+
+	/* link up */
+	pcie_capability_clear_word(bridge, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_LD);
+
+	return pci_dev_wait(pdev, "LNK", PCIE_RESET_READY_POLL_MS);
+}
+
+static int __pci_reset_dev_locked(struct nvme_ctrl *ctrl,
+					struct pci_dev *pdev, unsigned int cmd)
+{
+	int rc;
+	struct pci_dev *bridge = pci_upstream_bridge(pdev);
+
+	might_sleep();
+
+	if (!pci_is_pcie(pdev) || !bridge || !pci_is_pcie(bridge)) {
+		dev_err(ctrl->device,
+				"  no bridge found (or not PCIe dev)\n");
+		return -ENOTTY;
+	}
+
+	if (!pci_wait_for_pending_transaction(pdev))
+		dev_warn(ctrl->device,
+			"timed out waiting for pending transaction\n");
+	switch (cmd) {
+	case NVME_IOCTL_CONVENTIONAL_HOT_RESET:
+		rc = nvme_conventional_hot_reset(bridge);
+		break;
+	case NVME_IOCTL_LINK_DOWN_RESET:
+		rc = nvme_link_down_reset(pdev, bridge);
+		break;
+	default:
+		dev_err(ctrl->device,
+			"%s- unknown reset (%u)\n", __func__, cmd);
+		rc = -ENOTTY;
+	}
+
+	if (rc) {
+		dev_err(ctrl->device,
+			"%s: reset (%s) failed. rc=%d\n",
+			__func__, get_nvme_ioctl_name(cmd), rc);
+		return rc;
+	}
+
+	/* to reset mps (and misc.) */
+	pci_configure_device(pdev);
+
+	return rc;
+}
+
+static int nvme_pci_reset_dev(struct nvme_ctrl *ctrl,
+					struct pci_dev *pdev, unsigned int cmd)
+{
+	int rc;
+
+	pci_dev_lock(pdev);
+
+	/*
+	 * do not disable the device
+	 * as pci_dev_save_and_disable() calls nvme_disable_device().
+	 */
+	ctrl->ctrl_config |= NVME_CC_NO_ENABLE;
+
+	pci_dev_save_and_disable(pdev);		/* to save pcie status */
+
+	rc = __pci_reset_dev_locked(ctrl, pdev, cmd);
+
+	pci_dev_restore(pdev);
+
+	/* play safe */
+	ctrl->ctrl_config &= ~NVME_CC_NO_ENABLE;
+	pci_dev_unlock(pdev);
+
+	return rc;
+}
+
+static int nvme_pci_reset_common(struct nvme_ctrl *ctrl, unsigned int cmd)
+{
+	struct pci_dev *pdev;
+
+	dev_info(ctrl->device, "reset %s\n", get_nvme_ioctl_name(cmd));
+
+	if (!ctrl->ops->pci_dev)
+		return -ENOTTY;
+
+	pdev = ctrl->ops->pci_dev(ctrl);
+	if (cmd == NVME_IOCTL_FUNCTION_LEVEL_RESET)
+		return pci_reset_function(pdev);
+	else
+		return nvme_pci_reset_dev(ctrl, pdev, cmd);
+}
+
+#endif /* CONFIG_NVME_PCI_RESET */
+
 static void nvme_set_queue_dying(struct nvme_ns *ns)
 {
 	/*
@@ -2097,6 +2204,15 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl)
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
 	ctrl->ctrl_config &= ~NVME_CC_ENABLE;
 
+#ifdef CONFIG_NVME_PCI_RESET
+	if (ctrl->ctrl_config & NVME_CC_NO_ENABLE) {
+		dev_dbg(ctrl->device,
+				"%s: NVME_CC_NO_ENABLE set\n", __func__);
+		ctrl->ctrl_config &= ~NVME_CC_NO_ENABLE;
+		return 0;
+	}
+#endif /* CONFIG_NVME_PCI_RESET */
+
 	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
 	if (ret)
 		return ret;
@@ -2979,6 +3095,12 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 	case NVME_IOCTL_RESCAN:
 		nvme_queue_scan(ctrl);
 		return 0;
+#ifdef CONFIG_NVME_PCI_RESET
+	case NVME_IOCTL_CONVENTIONAL_HOT_RESET:		/* fall thru */
+	case NVME_IOCTL_LINK_DOWN_RESET:
+	case NVME_IOCTL_FUNCTION_LEVEL_RESET:
+		return nvme_pci_reset_common(ctrl, cmd);
+#endif /* CONFIG_NVME_PCI_RESET */
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 3b9cbe066..0b5f59b50 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -401,6 +401,10 @@ struct nvme_ctrl_ops {
 	void (*submit_async_event)(struct nvme_ctrl *ctrl);
 	void (*delete_ctrl)(struct nvme_ctrl *ctrl);
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
+
+#ifdef CONFIG_NVME_PCI_RESET
+	struct pci_dev *(*pci_dev)(struct nvme_ctrl *ctrl);
+#endif /* CONFIG_NVME_PCI_RESET */
 };
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index dcaad5831..5a78165ec 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2694,6 +2694,13 @@ static int nvme_pci_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 	return snprintf(buf, size, "%s", dev_name(&pdev->dev));
 }
 
+#ifdef CONFIG_NVME_PCI_RESET
+static struct pci_dev *nvme_pci_to_pci_dev(struct nvme_ctrl *ctrl)
+{
+	return to_pci_dev(to_nvme_dev(ctrl)->dev);
+}
+#endif /* CONFIG_NVME_PCI_RESET */
+
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.name			= "pcie",
 	.module			= THIS_MODULE,
@@ -2705,6 +2712,10 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.free_ctrl		= nvme_pci_free_ctrl,
 	.submit_async_event	= nvme_pci_submit_async_event,
 	.get_address		= nvme_pci_get_address,
+
+#ifdef CONFIG_NVME_PCI_RESET
+	.pci_dev		= nvme_pci_to_pci_dev,
+#endif /* CONFIG_NVME_PCI_RESET */
 };
 
 static int nvme_dev_map(struct nvme_dev *dev)
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 3d5189f46..5c2ce7374 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -160,6 +160,10 @@ enum {
 
 enum {
 	NVME_CC_ENABLE		= 1 << 0,
+#ifdef CONFIG_NVME_PCI_RESET
+	NVME_CC_NO_ENABLE	= 1 << 30,	/* conventional hot reset or */
+						/* link down reset is going. */
+#endif /* CONFIG_NVME_PCI_RESET */
 	NVME_CC_CSS_NVM		= 0 << 4,
 	NVME_CC_EN_SHIFT	= 0,
 	NVME_CC_CSS_SHIFT	= 4,
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index d99b5a772..36a77ff75 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -79,4 +79,47 @@ struct nvme_passthru_cmd64 {
 #define NVME_IOCTL_ADMIN64_CMD	_IOWR('N', 0x47, struct nvme_passthru_cmd64)
 #define NVME_IOCTL_IO64_CMD	_IOWR('N', 0x48, struct nvme_passthru_cmd64)
 
+#ifdef CONFIG_NVME_PCI_RESET
+#define NVME_IOCTL_CONVENTIONAL_HOT_RESET	_IO('N', 0x49)
+#define NVME_IOCTL_LINK_DOWN_RESET		_IO('N', 0x4a)
+#define NVME_IOCTL_FUNCTION_LEVEL_RESET		_IO('N', 0x4b)
+#endif /* CONFIG_NVME_PCI_RESET */
+
+static inline char *get_nvme_ioctl_name(unsigned int cmd)
+{
+	switch (cmd) {
+	case NVME_IOCTL_ID:
+		return "id";
+	case NVME_IOCTL_ADMIN_CMD:
+		return "admin cmd";
+	case NVME_IOCTL_SUBMIT_IO:
+		return "submit io";
+	case NVME_IOCTL_IO_CMD:
+		return "io cmd";
+	case NVME_IOCTL_RESET:
+		return "controller reset";
+	case NVME_IOCTL_SUBSYS_RESET:
+		return "subsystem reset";
+	case NVME_IOCTL_RESCAN:
+		return "rescan";
+	case NVME_IOCTL_ADMIN64_CMD:
+		return "admin64 cmd";
+	case NVME_IOCTL_IO64_CMD:
+		return "io64 cmd";
+#ifdef CONFIG_NVME_PCI_RESET
+	case NVME_IOCTL_CONVENTIONAL_HOT_RESET:
+		return "conventional hot reset";
+	case NVME_IOCTL_LINK_DOWN_RESET:
+		return "link down reset";
+	case NVME_IOCTL_FUNCTION_LEVEL_RESET:
+		return "function level reset";
+#endif /* CONFIG_NVME_PCI_RESET */
+	default:
+		return "Unknown";
+	}
+
+	// should not reach here
+	return "Unknown";
+}
+
 #endif /* _UAPI_LINUX_NVME_IOCTL_H */
-- 
2.17.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
