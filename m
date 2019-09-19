Return-Path: <SRS0=DlcY=XO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D249DC3A5A6
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Sep 2019 21:36:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BD98206C2
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Sep 2019 21:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fbeP7SlX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRoTRrbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BD98206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+DQwaAzeEc6yZZQuGv0cEYnTKG1R6ijWX/BPrnum/P8=; b=fbeP7SlX7JFozf
	CoImTd8sfZaSrr5gxnT71mQBhv9w8d974x3uHx4gqkWF5AL8migdub+v61JaLlTNHo9FsFrrLU1Bk
	nv3LcUV0PNKXitNn60NYRUMBKmMI3LeXTM0quUbcRjsy8hivLLFOJqXcKm/IT8GOYoof7TLX6L7gI
	ELy71ekTh03P70/DVNHxymCVWhEUYyJJSe31cfKVkoW1yUK5Zb6JaH7UMNvq65UWYVTEQzZ6JRicR
	Q2DJw8dzL3GAConWrkM6WuF3aLrr1FnxTuCDOThwMCxDDx5WWk0jEsxmZ6vzFrpAg+hYqnzQNCjRg
	F6i8RdKqc5vitNVJfMng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iB460-0004cc-Fr; Thu, 19 Sep 2019 21:36:12 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iB44a-0002FH-U4
 for linux-nvme@lists.infradead.org; Thu, 19 Sep 2019 21:34:46 +0000
Received: from washi1.fujisawa.hgst.com (unknown [199.255.47.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D6DA32196F;
 Thu, 19 Sep 2019 21:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1568928884;
 bh=x4utuQrdsugQJ1ljDaXlDyQbFnzhfzNcog/mTt8dDck=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XRoTRrbUdfesbaDVs1p804ix2K/2hNXO8HZkPmsnZs2C/vDG08ZhleQ3ViksC3v9Z
 nsYbT7l4eZb1nOvdb/3/s6edUVRcKktAfjCOGAnxJ4hDlTj2So15Dee6zeCxpu8Gto
 jORd+FWSC6Hf25ZezoIA2Ds+egSiuKMT5+73ij5U=
From: kbusch@kernel.org
To: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCHv2 6/6] nvme: Wait for reset state when required
Date: Fri, 20 Sep 2019 06:34:31 +0900
Message-Id: <20190919213431.7864-7-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190919213431.7864-1-kbusch@kernel.org>
References: <20190919213431.7864-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190919_143445_374642_F5673BE1 
X-CRM114-Status: GOOD (  18.70  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Edmund Nadolski <edmund.nadolski@intel.com>,
 James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Keith Busch <kbusch@kernel.org>

Provide a method to block until we've successfully entered the
RESETTING state so that we can ensure disabling the controller can
not be interrupted by another one of the various controller reset
paths. Otherwise, these simultaneous controller disabling/enabling tasks
may interfere with each other and leave the controller in the wrong state.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 36 ++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  4 ++++
 drivers/nvme/host/pci.c  | 46 +++++++++++++++++++++++++++-------------
 3 files changed, 70 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 33b5729763c2..3c75459c28bb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -374,8 +374,10 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		break;
 	}
 
-	if (changed)
+	if (changed) {
 		ctrl->state = new_state;
+		wake_up_all(&ctrl->state_wq);
+	}
 
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 	if (changed && ctrl->state == NVME_CTRL_LIVE)
@@ -384,6 +386,37 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 }
 EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
 
+/*
+ * Returns false for sink states that can't ever transition back to live.
+ */
+static bool nvme_state_transient(struct nvme_ctrl *ctrl)
+{
+	switch (ctrl->state) {
+	case NVME_CTRL_NEW:
+	case NVME_CTRL_LIVE:
+	case NVME_CTRL_RESETTING:
+	case NVME_CTRL_CONNECTING:
+		return true;
+	case NVME_CTRL_DELETING:
+	case NVME_CTRL_DEAD:
+	default:
+		return false;
+	}
+}
+
+/*
+ * Waits for the controller state to be resetting, or returns false if it is
+ * not possible to ever transition to that state.
+ */
+bool nvme_wait_reset(struct nvme_ctrl *ctrl)
+{
+	wait_event(ctrl->state_wq,
+		   nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING) ||
+		   !nvme_state_transient(ctrl));
+	return ctrl->state == NVME_CTRL_RESETTING;
+}
+EXPORT_SYMBOL_GPL(nvme_wait_reset);
+
 static void nvme_free_ns_head(struct kref *ref)
 {
 	struct nvme_ns_head *head =
@@ -3891,6 +3924,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
 	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
 	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
+	init_waitqueue_head(&ctrl->state_wq);
 
 	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
 	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 3ad16a81370b..43ac1244c4f7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -15,6 +15,7 @@
 #include <linux/sed-opal.h>
 #include <linux/fault-inject.h>
 #include <linux/rcupdate.h>
+#include <linux/wait.h>
 
 #include <trace/events/block.h>
 
@@ -198,6 +199,7 @@ struct nvme_ctrl {
 	struct cdev cdev;
 	struct work_struct reset_work;
 	struct work_struct delete_work;
+	wait_queue_head_t state_wq;
 
 	struct nvme_subsystem *subsys;
 	struct list_head subsys_entry;
@@ -448,6 +450,7 @@ void nvme_complete_rq(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data, bool reserved);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
+bool nvme_wait_reset(struct nvme_ctrl *ctrl);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl);
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl);
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
@@ -499,6 +502,7 @@ void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
 int nvme_reset_continue(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
+int nvme_reset_continue(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 
 int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9a9e90efcc95..41eb89bf0be3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2461,6 +2461,14 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	mutex_unlock(&dev->shutdown_lock);
 }
 
+static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
+{
+	if (!nvme_wait_reset(&dev->ctrl))
+		return -EBUSY;
+	nvme_dev_disable(dev, shutdown);
+	return 0;
+}
+
 static int nvme_setup_prp_pools(struct nvme_dev *dev)
 {
 	dev->prp_page_pool = dma_pool_create("prp list page", dev->dev,
@@ -2508,6 +2516,11 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 
 static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
 {
+	/*
+	 * Set state to deleting now to avoid blocking nvme_wait_reset(), which
+	 * may be holding this pci_dev's device lock.
+	 */
+	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 	nvme_get_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, false);
 	nvme_kill_queues(&dev->ctrl);
@@ -2833,19 +2846,28 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void nvme_reset_prepare(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
-	nvme_dev_disable(dev, false);
+
+	/*
+	 * We don't need to check the return value from waiting for the reset
+	 * state as pci_dev device lock is held, making it impossible to race
+	 * with ->remove().
+	 */
+	nvme_disable_prepare_reset(dev, false);
+	nvme_sync_queues(&dev->ctrl);
 }
 
 static void nvme_reset_done(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
-	nvme_reset_ctrl_sync(&dev->ctrl);
+
+	if (!nvme_reset_continue(&dev->ctrl))
+		flush_work(&dev->ctrl.reset_work);
 }
 
 static void nvme_shutdown(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
-	nvme_dev_disable(dev, true);
+	nvme_disable_prepare_reset(dev, true);
 }
 
 /*
@@ -2898,7 +2920,7 @@ static int nvme_resume(struct device *dev)
 
 	if (ndev->last_ps == U32_MAX ||
 	    nvme_set_power_state(ctrl, ndev->last_ps) != 0)
-		nvme_reset_ctrl(ctrl);
+		return nvme_reset_continue(&ndev->ctrl);
 	return 0;
 }
 
@@ -2926,10 +2948,8 @@ static int nvme_suspend(struct device *dev)
 	 */
 	if (pm_suspend_via_firmware() || !ctrl->npss ||
 	    !pcie_aspm_enabled(pdev) ||
-	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND)) {
-		nvme_dev_disable(ndev, true);
-		return 0;
-	}
+	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
+		return nvme_disable_prepare_reset(ndev, true);
 
 	nvme_start_freeze(ctrl);
 	nvme_wait_freeze(ctrl);
@@ -2951,9 +2971,8 @@ static int nvme_suspend(struct device *dev)
 		 * Clearing npss forces a controller reset on resume. The
 		 * correct value will be resdicovered then.
 		 */
-		nvme_dev_disable(ndev, true);
+		ret = nvme_disable_prepare_reset(ndev, true);
 		ctrl->npss = 0;
-		ret = 0;
 		goto unfreeze;
 	}
 	/*
@@ -2970,9 +2989,7 @@ static int nvme_suspend(struct device *dev)
 static int nvme_simple_suspend(struct device *dev)
 {
 	struct nvme_dev *ndev = pci_get_drvdata(to_pci_dev(dev));
-
-	nvme_dev_disable(ndev, true);
-	return 0;
+	return nvme_disable_prepare_reset(ndev, true);
 }
 
 static int nvme_simple_resume(struct device *dev)
@@ -2980,8 +2997,7 @@ static int nvme_simple_resume(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
-	nvme_reset_ctrl(&ndev->ctrl);
-	return 0;
+	return nvme_reset_continue(&ndev->ctrl);
 }
 
 static const struct dev_pm_ops nvme_dev_pm_ops = {
-- 
2.21.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
