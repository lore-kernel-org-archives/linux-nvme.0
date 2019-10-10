Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1EF3C4360C
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 16:06:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A20B020B7C
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 16:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BdcPZng2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IUMgIxP2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A20B020B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7hFQ7eQUYETqnmGJ35AMRubP3rq0q/i9w1hNDSQA27E=; b=BdcPZng2KWlEQt
	fRvUZwsvwyMLfunoEAYynpsdsTrrrvYAaehz+A/OuNV39zG/pENlpK1z4sxMDja2HG8iX0JiRPfZW
	x8vFTgLtrZeWRail0Qyr+v1oEsd4wOnPSFDZ6UXUVSFbKS7gewr9F43pCrl5bUIHO6E3Vxt1QfmJs
	+m4bFmObsSdESWyvdjCOGdnJnLT+B1D990Xy4SbZxlQbch6rHjC32aODLC/uwrqrQigVk/KwXRJh1
	rou7VpnqnvMnVO+/aCavkJkccQejQ1rnNpM2iaMTT5X6XHl4TYHDHwebGVqUm6jwDJmmss51XmPSc
	hWWPjRmTUjb16jtTLeOg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIaxe-0002s5-Ra; Thu, 10 Oct 2019 16:06:43 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIawc-00021W-4Z
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 16:05:40 +0000
Received: from washi1.fujisawa.hgst.com (unknown [199.255.47.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D19FA21A4C;
 Thu, 10 Oct 2019 16:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570723537;
 bh=7gVS0glxFWzKmQafkdZ2JhE0zEBJDxqXjAVn4WFb9E0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IUMgIxP2ZZhFuFDQXw61zGHJ7dfmo067gB/LHqktmuFz1ONManw92O7tiK/1i4OOI
 zD5MhLhP6rZH3l1EjEVwVOiFGGo8BLFreon29mnflp6KYcfj6ZK8cpahwJOrQayM6+
 FKihH//tsMlxEWdn2oRQRiDcJ+NpQ6lbeEjSJqt8=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCHv3 5/5] nvme: Wait for reset state when required
Date: Fri, 11 Oct 2019 01:05:27 +0900
Message-Id: <20191010160527.22376-6-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191010160527.22376-1-kbusch@kernel.org>
References: <20191010160527.22376-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_090538_227589_B73B9E17 
X-CRM114-Status: GOOD (  20.97  )
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
Cc: Keith Busch <kbusch@kernel.org>, Judy Brock <judy.brock@samsung.com>,
 Edmund Nadolski <edmund.nadolski@intel.com>,
 James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Prevent simultaneous controller disabling/enabling tasks from interfering
with each other through a method to wait until the task successfully
transitioned the controller to the RESETTING state. This ensures disabling
the controller will not be interrupted by another reset path, otherwise
a concurrent reset would leave the controller in the wrong state.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 41 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h |  4 ++++
 drivers/nvme/host/pci.c  | 46 +++++++++++++++++++++++++++-------------
 3 files changed, 74 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f09093fc1030..10a9647cfc1f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -125,7 +125,7 @@ static void nvme_queue_scan(struct nvme_ctrl *ctrl)
  * that had previously been set to the resetting state. This is intended for
  * code paths that can't be interrupted by other reset attempts.
  */
-static int nvme_reset_schedule(struct nvme_ctrl *ctrl)
+int nvme_reset_schedule(struct nvme_ctrl *ctrl)
 {
 	if (ctrl->state != NVME_CTRL_RESETTING)
 		return -EBUSY;
@@ -133,6 +133,7 @@ static int nvme_reset_schedule(struct nvme_ctrl *ctrl)
 		return -EBUSY;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(nvme_reset_schedule);
 
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -383,8 +384,10 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		break;
 	}
 
-	if (changed)
+	if (changed) {
 		ctrl->state = new_state;
+		wake_up_all(&ctrl->state_wq);
+	}
 
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 	if (changed && ctrl->state == NVME_CTRL_LIVE)
@@ -393,6 +396,39 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 }
 EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
 
+/*
+ * Returns true for sink states that can't ever transition back to live.
+ */
+static bool nvme_state_terminal(struct nvme_ctrl *ctrl)
+{
+	switch (ctrl->state) {
+	case NVME_CTRL_NEW:
+	case NVME_CTRL_LIVE:
+	case NVME_CTRL_RESETTING:
+	case NVME_CTRL_CONNECTING:
+		return false;
+	case NVME_CTRL_DELETING:
+	case NVME_CTRL_DEAD:
+		return true;
+	default:
+		WARN_ONCE(1, "Unhandled ctrl state:%d", ctrl->state);
+		return true;
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
+		   nvme_state_terminal(ctrl));
+	return ctrl->state == NVME_CTRL_RESETTING;
+}
+EXPORT_SYMBOL_GPL(nvme_wait_reset);
+
 static void nvme_free_ns_head(struct kref *ref)
 {
 	struct nvme_ns_head *head =
@@ -3998,6 +4034,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
 	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
 	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
+	init_waitqueue_head(&ctrl->state_wq);
 
 	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
 	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2ba577271ada..9b1c3f661b78 100644
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
@@ -498,6 +501,7 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
+int nvme_reset_schedule(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 
 int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7d0de87d733d..b08a69a6bc56 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2463,6 +2463,14 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
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
@@ -2510,6 +2518,11 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 
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
@@ -2835,19 +2848,28 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
+	if (!nvme_reset_schedule(&dev->ctrl))
+		flush_work(&dev->ctrl.reset_work);
 }
 
 static void nvme_shutdown(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
-	nvme_dev_disable(dev, true);
+	nvme_disable_prepare_reset(dev, true);
 }
 
 /*
@@ -2900,7 +2922,7 @@ static int nvme_resume(struct device *dev)
 
 	if (ndev->last_ps == U32_MAX ||
 	    nvme_set_power_state(ctrl, ndev->last_ps) != 0)
-		nvme_reset_ctrl(ctrl);
+		return nvme_reset_schedule(&ndev->ctrl);
 	return 0;
 }
 
@@ -2928,10 +2950,8 @@ static int nvme_suspend(struct device *dev)
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
@@ -2963,9 +2983,8 @@ static int nvme_suspend(struct device *dev)
 		 * Clearing npss forces a controller reset on resume. The
 		 * correct value will be resdicovered then.
 		 */
-		nvme_dev_disable(ndev, true);
+		ret = nvme_disable_prepare_reset(ndev, true);
 		ctrl->npss = 0;
-		ret = 0;
 	}
 unfreeze:
 	nvme_unfreeze(ctrl);
@@ -2975,9 +2994,7 @@ static int nvme_suspend(struct device *dev)
 static int nvme_simple_suspend(struct device *dev)
 {
 	struct nvme_dev *ndev = pci_get_drvdata(to_pci_dev(dev));
-
-	nvme_dev_disable(ndev, true);
-	return 0;
+	return nvme_disable_prepare_reset(ndev, true);
 }
 
 static int nvme_simple_resume(struct device *dev)
@@ -2985,8 +3002,7 @@ static int nvme_simple_resume(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
-	nvme_reset_ctrl(&ndev->ctrl);
-	return 0;
+	return nvme_reset_schedule(&ndev->ctrl);
 }
 
 static const struct dev_pm_ops nvme_dev_pm_ops = {
-- 
2.21.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
