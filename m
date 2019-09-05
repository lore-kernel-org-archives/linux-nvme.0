Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E6EC43331
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 14:28:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C347206CD
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 14:28:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jopfMPpZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C347206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=80+ooLAOeVdz12K9w2mnzjnBodGF6+3zPqDlFmnemn0=; b=jopfMPpZC6rxsv8eK6UkZiZeMi
	L+XTV1VF/q0dlwS0F6/GWZzUYUn7L7XpQuXdxreK72+Ai5eYpSUD+B1vs4qki0QlUqSfK6nUejuFj
	+vNrVTX+Ny7DkyReptgJRj8ppa+SoxFEMhgTI7DJGHn1ExERYow0a4d8BusMVXm9nSBaoSq7mRQhB
	07PhmtGBYDUUHv03jJrREsDnsIwEk9xRMUqvGJMwqvtd8SHiqS+RdFivhiKAFs+XVLsD9Gse3xEfV
	no1UvD7cgBrorXbJYMFY5xAYAmW0iJnW7z4eg62/HI7G1nUhVG7fUwqfBlcw4zjlhqeCQaFZ2OZWR
	OpTGT/PQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5skf-0007rR-BZ; Thu, 05 Sep 2019 14:28:45 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i5sju-0007Di-8Y
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 14:28:00 +0000
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Sep 2019 07:27:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,470,1559545200"; d="scan'208";a="187991065"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.112.69])
 by orsmga006.jf.intel.com with ESMTP; 05 Sep 2019 07:27:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 5/5] nvme: Wait for reset state when required
Date: Thu,  5 Sep 2019 08:26:07 -0600
Message-Id: <20190905142607.24897-5-kbusch@kernel.org>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20190905142607.24897-1-kbusch@kernel.org>
References: <20190905142607.24897-1-kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_072758_312893_B255C12C 
X-CRM114-Status: GOOD (  19.11  )
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
 Edmund Nadolski <edmund.nadolski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Disabling a controller in a path that resets it in a different
context needs to fence off other resets from occuring between these
actions. Provide a method to block until we've successfully entered a
reset state prior to disabling so that we can perform the controller
disabling without racing with another reset. Otherwise, that other reset
may either undo our teardown, or our teardown may undo the in-progress
reset's bringup.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 36 +++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  3 +++
 drivers/nvme/host/pci.c  | 43 ++++++++++++++++++++++++++++++++-----------
 3 files changed, 70 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d3920c1e54b9..995daa20a410 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -367,8 +367,10 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		break;
 	}
 
-	if (changed)
+	if (changed) {
 		ctrl->state = new_state;
+		wake_up_all(&ctrl->state_wq);
+	}
 
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 	if (changed && ctrl->state == NVME_CTRL_LIVE)
@@ -377,6 +379,37 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 }
 EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
 
+/*
+ * Returns false for sink states that can't ever transition back to live
+ */
+static bool nvme_state_transient(struct nvme_ctrl *ctrl)
+{
+	switch (ctrl->state) {
+	case NVME_CTRL_NEW:
+	case NVME_CTRL_LIVE:
+	case NVME_CTRL_RESETTING:
+	case NVME_CTRL_CONNECTING:
+		return true;;
+	case NVME_CTRL_DELETING:
+	case NVME_CTRL_DEAD:
+	default:
+		return false;
+	}
+}
+
+/*
+ * Waits for the controller state to be reset, or returns false if it is not
+ * possible to ever transition to reset.
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
@@ -3841,6 +3874,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
 	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
 	INIT_WORK(&ctrl->delete_work, nvme_delete_ctrl_work);
+	init_waitqueue_head(&ctrl->state_wq);
 
 	INIT_DELAYED_WORK(&ctrl->ka_work, nvme_keep_alive_work);
 	memset(&ctrl->ka_cmd, 0, sizeof(ctrl->ka_cmd));
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a9fc25c3b64d..dc1c95008748 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -15,6 +15,7 @@
 #include <linux/sed-opal.h>
 #include <linux/fault-inject.h>
 #include <linux/rcupdate.h>
+#include <linux/wait.h>
 
 #include <trace/events/block.h>
 
@@ -193,6 +194,7 @@ struct nvme_ctrl {
 	struct cdev cdev;
 	struct work_struct reset_work;
 	struct work_struct delete_work;
+	wait_queue_head_t state_wq;
 
 	struct nvme_subsystem *subsys;
 	struct list_head subsys_entry;
@@ -443,6 +445,7 @@ void nvme_complete_rq(struct request *req);
 bool nvme_cancel_request(struct request *req, void *data, bool reserved);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
+bool nvme_wait_reset(struct nvme_ctrl *ctrl);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl);
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl);
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 95411f53f159..b3a89ca37ead 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2462,6 +2462,14 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
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
@@ -2509,6 +2517,11 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 
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
@@ -2833,19 +2846,27 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
+	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_LIVE);
 	nvme_reset_ctrl_sync(&dev->ctrl);
 }
 
 static void nvme_shutdown(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
-	nvme_dev_disable(dev, true);
+	nvme_disable_prepare_reset(dev, true);
 }
 
 /*
@@ -2897,8 +2918,10 @@ static int nvme_resume(struct device *dev)
 	struct nvme_ctrl *ctrl = &ndev->ctrl;
 
 	if (pm_resume_via_firmware() || !ctrl->npss ||
-	    nvme_set_power_state(ctrl, ndev->last_ps) != 0)
-		nvme_reset_ctrl(ctrl);
+	    nvme_set_power_state(ctrl, ndev->last_ps) != 0) {
+		if (nvme_change_ctrl_state(&ndev->ctrl, NVME_CTRL_LIVE))
+			nvme_reset_ctrl(ctrl);
+	}
 	return 0;
 }
 
@@ -2917,10 +2940,8 @@ static int nvme_suspend(struct device *dev)
 	 * device does not support any non-default power states, shut down the
 	 * device fully.
 	 */
-	if (pm_suspend_via_firmware() || !ctrl->npss) {
-		nvme_dev_disable(ndev, true);
-		return 0;
-	}
+	if (pm_suspend_via_firmware() || !ctrl->npss)
+		return nvme_disable_prepare_reset(ndev, true);
 
 	nvme_start_freeze(ctrl);
 	nvme_wait_freeze(ctrl);
@@ -2943,9 +2964,8 @@ static int nvme_suspend(struct device *dev)
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
@@ -2963,7 +2983,7 @@ static int nvme_simple_suspend(struct device *dev)
 {
 	struct nvme_dev *ndev = pci_get_drvdata(to_pci_dev(dev));
 
-	nvme_dev_disable(ndev, true);
+	nvme_disable_prepare_reset(ndev, true);
 	return 0;
 }
 
@@ -2972,6 +2992,7 @@ static int nvme_simple_resume(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
+	nvme_change_ctrl_state(&ndev->ctrl, NVME_CTRL_LIVE);
 	nvme_reset_ctrl(&ndev->ctrl);
 	return 0;
 }
-- 
2.14.5


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
