Return-Path: <SRS0=peCB=2B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51399C43603
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 02:36:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CB892073B
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 02:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="saBUvm0e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CB892073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=MY2bdU3x13Fo+ItgWuIiBiN9RmPYC/J+R/FcZ6K1Rq8=; b=saBUvm0emGJpBy
	khOcIhDrDKcZq9d7X5AemdxHZvkbbc7i4J4UJGdekq24W6cy9sEmmT/nRhjdEOqVUpKo6Bf+Yh1Bj
	BuRGxXagSCUuXuhmaAncEy3BK8p+A6+OeYi9uT6bls5HDPIQzOBV6OeNWQtaY/X1LKFkpJgi5FMUV
	0YmtdUoiKAlX1OVD5f1LuREVRtsgLiDH7q3aA8cxTEd5yaeOJFee6aECEROLQhRPrvtnFCxVrGEwR
	YiSH9j6HN4EUXuN9UlCnyWo13rfwA68s3f3QypjKE6eJ0pMDd2p3TF/fBaOLSy81JJNxjYz1Isn30
	Po3H32YevmogYavnxpNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ierr3-0006c0-Px; Wed, 11 Dec 2019 02:35:57 +0000
Received: from mo-csw1514.securemx.jp ([210.130.202.153]
 helo=mo-csw.securemx.jp)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ierqH-00056g-Cm
 for linux-nvme@lists.infradead.org; Wed, 11 Dec 2019 02:35:12 +0000
Received: by mo-csw.securemx.jp (mx-mo-csw1514) id xBB2YxSo021224;
 Wed, 11 Dec 2019 11:34:59 +0900
X-Iguazu-Qid: 34tMdwKSzKurbDATlG
X-Iguazu-QSIG: v=2; s=0; t=1576031699; q=34tMdwKSzKurbDATlG;
 m=l9WIXYJdCM/NX8EnPH8YbXJaZ43j8tJdctK6Fl99SiE=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
 by relay.securemx.jp (mx-mr1510) id xBB2YwTg028393;
 Wed, 11 Dec 2019 11:34:59 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
 by imx12.toshiba.co.jp  with ESMTP id xBB2Yw8O017519;
 Wed, 11 Dec 2019 11:34:58 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
 by enc02.toshiba.co.jp  with ESMTP id xBB2YwZc018606;
 Wed, 11 Dec 2019 11:34:58 +0900
From: <tsutomu.owa@kioxia.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>, 
 <hch@infradead.org>
Subject: [RFC PATCH 5/5] nvme: to add support for nvme queue level reset
Thread-Topic: [RFC PATCH 5/5] nvme: to add support for nvme queue level reset
Thread-Index: AdWvygoTnLWS5nuZTE6d7SAUPjvZ2g==
Date: Wed, 11 Dec 2019 02:34:56 +0000
X-TSB-HOP: ON
Message-ID: <ea9caff8d3b242c3b2bd7f10e3f063a3@tgxml778.toshiba.local>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [133.118.176.119]
msscp.transfermailtomossagent: 103
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191210_183510_182160_1ABEF783 
X-CRM114-Status: GOOD (  14.38  )
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

This patch adds support for queue level reset function described in NVMe
spec 1.3c "7.3.3 Queue Level".

Signed-off-by: Tsutomu OWA <tsutomu.owa@kioxia.com>
---
 drivers/nvme/host/core.c        | 39 +++++++++++++++++++--
 drivers/nvme/host/nvme.h        |  5 +++
 drivers/nvme/host/pci.c         | 62 +++++++++++++++++++++++++++++++++
 include/uapi/linux/nvme_ioctl.h |  8 +++++
 4 files changed, 112 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 65e3ef820..b4bd90ef6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -94,13 +94,44 @@ static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
 
+#ifdef CONFIG_NVME_QUEUE_LEVEL_RESET
+static int queue_level_reset(struct nvme_ctrl *ctrl, unsigned int cmd)
+{
+	dev_info(ctrl->device, "reset %s\n", get_nvme_ioctl_name(cmd));
+
+	/* sanity check */
+	if (!ctrl->ops || !ctrl->ops->disable_io_queues ||
+	    !ctrl->ops->suspend_io_queues || !ctrl->ops->create_io_queues)
+		return -ENOTTY;
+
+	mutex_lock(&ctrl->scan_lock);
+	nvme_start_freeze(ctrl);
+	nvme_wait_freeze(ctrl);
+
+	/* delete sq/cq */
+	ctrl->ops->disable_io_queues(ctrl);
+
+	/* free irq. */
+	ctrl->ops->suspend_io_queues(ctrl);
+
+	/* alloc sq/cq, enable irq */
+	ctrl->ops->create_io_queues(ctrl);
+
+	nvme_unfreeze(ctrl);
+	mutex_unlock(&ctrl->scan_lock);
+
+	return 0;
+}
+#endif /* CONFIG_NVME_QUEUE_LEVEL_RESET */
+
 #ifdef CONFIG_NVME_PCI_RESET
 static int nvme_conventional_hot_reset(struct pci_dev *bridge)
 {
 	return pci_bridge_secondary_bus_reset(bridge);
 }
 
-#define PCIE_RESET_READY_POLL_MS	60000
+/* value 60000 taken from drivers/pci/pci.c. */
+#define NVME_PCIE_RESET_READY_LNK_MS	60000
 static int nvme_link_down_reset(struct pci_dev *pdev, struct pci_dev *bridge)
 {
 	/* link down */
@@ -111,7 +142,7 @@ static int nvme_link_down_reset(struct pci_dev *pdev, struct pci_dev *bridge)
 	/* link up */
 	pcie_capability_clear_word(bridge, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_LD);
 
-	return pci_dev_wait(pdev, "LNK", PCIE_RESET_READY_POLL_MS);
+	return pci_dev_wait(pdev, "LNK", NVME_PCIE_RESET_READY_LNK_MS);
 }
 
 static int __pci_reset_dev_locked(struct nvme_ctrl *ctrl,
@@ -3101,6 +3132,10 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 	case NVME_IOCTL_FUNCTION_LEVEL_RESET:
 		return nvme_pci_reset_common(ctrl, cmd);
 #endif /* CONFIG_NVME_PCI_RESET */
+#ifdef CONFIG_NVME_QUEUE_LEVEL_RESET
+	case NVME_IOCTL_QUEUE_LEVEL_RESET:
+		return queue_level_reset(ctrl, cmd);
+#endif /* CONFIG_NVME_QUEUE_LEVEL_RESET */
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0b5f59b50..c342a4c5c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -405,6 +405,11 @@ struct nvme_ctrl_ops {
 #ifdef CONFIG_NVME_PCI_RESET
 	struct pci_dev *(*pci_dev)(struct nvme_ctrl *ctrl);
 #endif /* CONFIG_NVME_PCI_RESET */
+#ifdef CONFIG_NVME_QUEUE_LEVEL_RESET
+	int (*create_io_queues)(struct nvme_ctrl *ctrl);
+	void (*suspend_io_queues)(struct nvme_ctrl *ctrl);
+	void (*disable_io_queues)(struct nvme_ctrl *ctrl);
+#endif /* CONFIG_NVME_QUEUE_LEVEL_RESET */
 };
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5a78165ec..6b199b082 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1399,6 +1399,15 @@ static void nvme_suspend_io_queues(struct nvme_dev *dev)
 		nvme_suspend_queue(&dev->queues[i]);
 }
 
+#ifdef CONFIG_NVME_QUEUE_LEVEL_RESET
+static void nvme_pci_suspend_io_queues(struct nvme_ctrl *ctrl)
+{
+	struct nvme_dev *dev = to_nvme_dev(ctrl);
+
+	nvme_suspend_io_queues(dev);
+}
+#endif /* CONFIG_NVME_QUEUE_LEVEL_RESET */
+
 static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 {
 	struct nvme_queue *nvmeq = &dev->queues[0];
@@ -1751,6 +1760,45 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 	return ret >= 0 ? 0 : ret;
 }
 
+#ifdef CONFIG_NVME_QUEUE_LEVEL_RESET
+/*
+ * code taken from nvme_create_io_queues()
+ * it could be better to cleanup nvme_create_io_queues() and
+ * nvme_pci_create_io_queues() to use common code if this
+ * queue level reset implementation is basically accepted.
+ *
+ */
+static int nvme_pci_create_io_queues(struct nvme_ctrl *ctrl)
+{
+	int i, max, rw_queues;
+	int ret = 0;
+	struct nvme_dev *dev = to_nvme_dev(ctrl);
+
+	max = min(dev->max_qid, dev->ctrl.queue_count - 1);
+	if (max != 1 && dev->io_queues[HCTX_TYPE_POLL]) {
+		rw_queues = dev->io_queues[HCTX_TYPE_DEFAULT] +
+				dev->io_queues[HCTX_TYPE_READ];
+	} else {
+		rw_queues = max;
+	}
+
+	for (i = dev->online_queues; i <= max; i++) {
+		bool polled = i > rw_queues;
+
+
+		ret = nvme_create_queue(&dev->queues[i], i, polled);
+		if (ret)
+			break;
+	}
+
+	if (ret)
+		dev_warn(ctrl->device,
+			"%s: err (i=%d, ret=%d)\n", __func__, i, ret);
+
+	return ret >= 0 ? 0 : ret;
+}
+#endif /* CONFIG_NVME_QUEUE_LEVEL_RESET */
+
 static ssize_t nvme_cmb_show(struct device *dev,
 			     struct device_attribute *attr,
 			     char *buf)
@@ -2097,6 +2145,15 @@ static void nvme_disable_io_queues(struct nvme_dev *dev)
 		__nvme_disable_io_queues(dev, nvme_admin_delete_cq);
 }
 
+#ifdef CONFIG_NVME_QUEUE_LEVEL_RESET
+static void nvme_pci_disable_io_queues(struct nvme_ctrl *ctrl)
+{
+	struct nvme_dev *dev = to_nvme_dev(ctrl);
+
+	nvme_disable_io_queues(dev);
+}
+#endif /* CONFIG_NVME_QUEUE_LEVEL_RESET */
+
 static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
 	struct nvme_queue *adminq = &dev->queues[0];
@@ -2716,6 +2773,11 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 #ifdef CONFIG_NVME_PCI_RESET
 	.pci_dev		= nvme_pci_to_pci_dev,
 #endif /* CONFIG_NVME_PCI_RESET */
+#ifdef CONFIG_NVME_QUEUE_LEVEL_RESET
+	.create_io_queues	= nvme_pci_create_io_queues,
+	.suspend_io_queues	= nvme_pci_suspend_io_queues,
+	.disable_io_queues	= nvme_pci_disable_io_queues,
+#endif /* CONFIG_NVME_QUEUE_LEVEL_RESET */
 };
 
 static int nvme_dev_map(struct nvme_dev *dev)
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index 36a77ff75..9f102397e 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -85,6 +85,10 @@ struct nvme_passthru_cmd64 {
 #define NVME_IOCTL_FUNCTION_LEVEL_RESET		_IO('N', 0x4b)
 #endif /* CONFIG_NVME_PCI_RESET */
 
+#ifdef CONFIG_NVME_QUEUE_LEVEL_RESET
+#define NVME_IOCTL_QUEUE_LEVEL_RESET		_IO('N', 0x4c)
+#endif /* CONFIG_NVME_QUEUE_LEVEL_RESET */
+
 static inline char *get_nvme_ioctl_name(unsigned int cmd)
 {
 	switch (cmd) {
@@ -114,6 +118,10 @@ static inline char *get_nvme_ioctl_name(unsigned int cmd)
 	case NVME_IOCTL_FUNCTION_LEVEL_RESET:
 		return "function level reset";
 #endif /* CONFIG_NVME_PCI_RESET */
+#ifdef CONFIG_NVME_QUEUE_LEVEL_RESET
+	case NVME_IOCTL_QUEUE_LEVEL_RESET:
+		return "queue level reset";
+#endif /* CONFIG_NVME_QUEUE_LEVEL_RESET */
 	default:
 		return "Unknown";
 	}
-- 
2.17.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
