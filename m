Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3960C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 21:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:From:
	Subject:Mime-Version:Message-Id:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=U2UsEOCuyQdXUBkWl9OvzHBcW14+L57yo/FD6yBa+sk=; b=0ZQtoUPrI6mhkJPsMJCQ9VEjQ+
	TiQAB0Uya3EXuvqt3KDMfR4IJ8shIV08CPcfA+y9OIfWBO8jHdhRXx969hCX0+zCb/Dy/ON8BiMyv
	Qikws85cF377RAhSGo6lFU0eo8D3UHx+sYTJI+55BU0pPKxP9D/asMRk3F2EG7HWh0Vh8g1T5xYcG
	hmUlncgn8l+arzS9q1SfGVZy1ji6IKDLVBXvecmH93BHLUgjn/iT+RCAqkAjpOwBDHu5jYiVeUoDk
	xtAETxHx+pBwACMKe29c4k/ViryQMX3Qnf0xqhIIhD+C3t8CjY4WcoHQVlzpA48/LzJUJbSjJ3Zr8
	zrYjkz2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXVEX-000MIh-LJ; Thu, 24 Mar 2022 21:43:05 +0000
Received: from mail-yw1-x114a.google.com ([2607:f8b0:4864:20::114a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXVEU-000MGs-4N
 for linux-nvme@lists.infradead.org; Thu, 24 Mar 2022 21:43:04 +0000
Received: by mail-yw1-x114a.google.com with SMTP id
 00721157ae682-2e689dfe112so46171047b3.20
 for <linux-nvme@lists.infradead.org>; Thu, 24 Mar 2022 14:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:message-id:mime-version:subject:from:to:cc;
 bh=U2UsEOCuyQdXUBkWl9OvzHBcW14+L57yo/FD6yBa+sk=;
 b=VpZQn37kX+bDmxwH5dh/r/ZkW9vEij5mteLmnugI6uXPvUhksffdeBlQhJhmKk9lCn
 twNpR2Xvkd8v2z576bpgpX9+i5VdYnG4l2lz7CZ3xU2ukKufuStV8B0J8lnD+dnuLT77
 eAzDZoRV8zTQD+DVpbH1nMiBH7QFXqlBxiI718+2GvfTmOeep1gewF5HKc4J190GIkiA
 mR40EDtoRkEao3ZalrUJYSM7N90WZX8ahph0nds8x/bgN/L6cOS5HUe4JBq0AQ5VzaUi
 tr8t8DX/T+mmSw5oMsoVfqGo6Wd89y1Z1VFwAsfQ0rdrzQeR52W/3kI4YC251CDstBXJ
 YPKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
 bh=U2UsEOCuyQdXUBkWl9OvzHBcW14+L57yo/FD6yBa+sk=;
 b=lbtkFcPpR4MM0Ig77kYgjMFckrEI0q/BIwwUrgBjO4jZ7gMZ1/j1MImDxXe70pVmjm
 S/4cbEyg+KC+3nQqm7HwHUsKZWJdKFPKk/kqo7dNNBbN7Ay3oR6sIAb9EqaSSYMu8/ca
 cUCZQTBlc7ACDLWf6DH77HAFADtCmieR2gdkzNJFW5VP8RxWz7wXRmfanjLR1lOQPJW9
 iGR7eiAm5c/XeRnh/GsXqT8s3vi7vxxcDE/sg3P2PJez8PBZY88noHT/GgsZS1dYEnqj
 jMek3wyKJoO4DUbZKOX+64eTLhf4ksOxJxBaM27VC7PM9HoiO5M6M3AY7+joo43zI4g3
 qADw==
X-Gm-Message-State: AOAM531SBj6vPnILJnp2ifZzC7i9vuLGtir9uDtEa1K99aXiNWNQfSj3
 wRJ2B25bdB6URGakv1njW3ObXyiUCW7ZNSY=
X-Google-Smtp-Source: ABdhPJxdcK9gFjaV4Hz83fNZ2qJV4X4j9eizfzmmrWZd1s+BjK/ZD5JOs/299ZMUkneGWhy3BVFsZoYi4KYzeo0=
X-Received: from tansuresh.svl.corp.google.com
 ([2620:15c:2c5:13:849f:5cb9:7db8:508a])
 (user=tansuresh job=sendgmr) by 2002:a25:d7d7:0:b0:633:c348:31d3 with SMTP id
 o206-20020a25d7d7000000b00633c34831d3mr6608767ybg.298.1648158177249; Thu, 24
 Mar 2022 14:42:57 -0700 (PDT)
Date: Thu, 24 Mar 2022 14:42:51 -0700
Message-Id: <20220324214251.3057957-1-tansuresh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.1021.g381101b075-goog
Subject: [PATCH 3/3] nvme: Add async shutdown support
From: Tanjore Suresh <tansuresh@google.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Tanjore Suresh <tansuresh@google.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220324_144302_209945_A0FB8FD5 
X-CRM114-Status: GOOD (  24.97  )
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

This works with the asynchronous shutdown mechanism setup for the PCI
drivers and participates to provide both pre and post shutdown
routines at pci_driver structure level.

The shutdown_pre routine starts the shutdown and does not wait for the
shutdown to complete.  The shutdown_post routine waits for the shutdown
to complete on individual controllers that this driver instance
controls. This mechanism optimizes to speed up the shutdown in a
system which host many controllers.

Signed-off-by: Tanjore Suresh <tansuresh@google.com>
---
 drivers/nvme/host/core.c | 28 ++++++++++----
 drivers/nvme/host/nvme.h |  8 ++++
 drivers/nvme/host/pci.c  | 80 +++++++++++++++++++++++++---------------
 3 files changed, 80 insertions(+), 36 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cd6eac8e3dd6..3ada8f5163eb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2210,16 +2210,30 @@ EXPORT_SYMBOL_GPL(nvme_enable_ctrl);
 
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 {
-	unsigned long timeout = jiffies + (ctrl->shutdown_timeout * HZ);
-	u32 csts;
 	int ret;
 
+	ret = nvme_shutdown_ctrl_start(ctrl);
+	if (ret)
+		return ret;
+	return nvme_wait_for_shutdown_cmpl(ctrl);
+}
+EXPORT_SYMBOL_GPL(nvme_shutdown_ctrl);
+
+int nvme_shutdown_ctrl_start(struct nvme_ctrl *ctrl)
+{
+
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
 	ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
 
-	ret = ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
-	if (ret)
-		return ret;
+	return ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config);
+}
+EXPORT_SYMBOL_GPL(nvme_shutdown_ctrl_start);
+
+int nvme_wait_for_shutdown_cmpl(struct nvme_ctrl *ctrl)
+{
+	unsigned long deadline = jiffies + (ctrl->shutdown_timeout * HZ);
+	u32 csts;
+	int ret;
 
 	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
 		if ((csts & NVME_CSTS_SHST_MASK) == NVME_CSTS_SHST_CMPLT)
@@ -2228,7 +2242,7 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 		msleep(100);
 		if (fatal_signal_pending(current))
 			return -EINTR;
-		if (time_after(jiffies, timeout)) {
+		if (time_after(jiffies, deadline)) {
 			dev_err(ctrl->device,
 				"Device shutdown incomplete; abort shutdown\n");
 			return -ENODEV;
@@ -2237,7 +2251,7 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(nvme_shutdown_ctrl);
+EXPORT_SYMBOL_GPL(nvme_wait_for_shutdown_cmpl);
 
 static int nvme_configure_timestamp(struct nvme_ctrl *ctrl)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1ea908d43e17..9491bda2e38a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -170,6 +170,12 @@ enum {
 	NVME_REQ_USERCMD		= (1 << 1),
 };
 
+enum shutdown_type {
+	DO_NOT_SHUTDOWN = 0,
+	SHUTDOWN_TYPE_SYNC = 1,
+	SHUTDOWN_TYPE_ASYNC = 2,
+};
+
 static inline struct nvme_request *nvme_req(struct request *req)
 {
 	return blk_mq_rq_to_pdu(req);
@@ -671,6 +677,8 @@ bool nvme_wait_reset(struct nvme_ctrl *ctrl);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl);
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl);
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
+int nvme_shutdown_ctrl_start(struct nvme_ctrl *ctrl);
+int nvme_wait_for_shutdown_cmpl(struct nvme_ctrl *ctrl);
 int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		const struct nvme_ctrl_ops *ops, unsigned long quirks);
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2e98ac3f3ad6..dc72fe7d8994 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -107,7 +107,7 @@ MODULE_PARM_DESC(noacpi, "disable acpi bios quirks");
 struct nvme_dev;
 struct nvme_queue;
 
-static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
+static void nvme_dev_disable(struct nvme_dev *dev, int shutdown_type);
 static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode);
 
 /*
@@ -1357,7 +1357,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	 */
 	if (nvme_should_reset(dev, csts)) {
 		nvme_warn_reset(dev, csts);
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, DO_NOT_SHUTDOWN);
 		nvme_reset_ctrl(&dev->ctrl);
 		return BLK_EH_DONE;
 	}
@@ -1392,7 +1392,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 			 "I/O %d QID %d timeout, disable controller\n",
 			 req->tag, nvmeq->qid);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
-		nvme_dev_disable(dev, true);
+		nvme_dev_disable(dev, SHUTDOWN_TYPE_SYNC);
 		return BLK_EH_DONE;
 	case NVME_CTRL_RESETTING:
 		return BLK_EH_RESET_TIMER;
@@ -1410,7 +1410,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 			 "I/O %d QID %d timeout, reset controller\n",
 			 req->tag, nvmeq->qid);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, DO_NOT_SHUTDOWN);
 		nvme_reset_ctrl(&dev->ctrl);
 
 		return BLK_EH_DONE;
@@ -1503,11 +1503,13 @@ static void nvme_suspend_io_queues(struct nvme_dev *dev)
 		nvme_suspend_queue(&dev->queues[i]);
 }
 
-static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
+static void nvme_disable_admin_queue(struct nvme_dev *dev, int shutdown_type)
 {
 	struct nvme_queue *nvmeq = &dev->queues[0];
 
-	if (shutdown)
+	if (shutdown_type == SHUTDOWN_TYPE_ASYNC)
+		nvme_shutdown_ctrl_start(&dev->ctrl);
+	else if (shutdown_type == SHUTDOWN_TYPE_SYNC)
 		nvme_shutdown_ctrl(&dev->ctrl);
 	else
 		nvme_disable_ctrl(&dev->ctrl);
@@ -2669,7 +2671,7 @@ static void nvme_pci_disable(struct nvme_dev *dev)
 	}
 }
 
-static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
+static void nvme_dev_disable(struct nvme_dev *dev, int shutdown_type)
 {
 	bool dead = true, freeze = false;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
@@ -2691,14 +2693,14 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	 * Give the controller a chance to complete all entered requests if
 	 * doing a safe shutdown.
 	 */
-	if (!dead && shutdown && freeze)
+	if (!dead && (shutdown_type != DO_NOT_SHUTDOWN) && freeze)
 		nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
 
 	nvme_stop_queues(&dev->ctrl);
 
 	if (!dead && dev->ctrl.queue_count > 0) {
 		nvme_disable_io_queues(dev);
-		nvme_disable_admin_queue(dev, shutdown);
+		nvme_disable_admin_queue(dev, shutdown_type);
 	}
 	nvme_suspend_io_queues(dev);
 	nvme_suspend_queue(&dev->queues[0]);
@@ -2710,12 +2712,12 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	blk_mq_tagset_wait_completed_request(&dev->tagset);
 	blk_mq_tagset_wait_completed_request(&dev->admin_tagset);
 
-	/*
-	 * The driver will not be starting up queues again if shutting down so
-	 * must flush all entered requests to their failed completion to avoid
-	 * deadlocking blk-mq hot-cpu notifier.
-	 */
-	if (shutdown) {
+	if (shutdown_type == SHUTDOWN_TYPE_SYNC) {
+		/*
+		 * The driver will not be starting up queues again if shutting down so
+		 * must flush all entered requests to their failed completion to avoid
+		 * deadlocking blk-mq hot-cpu notifier.
+		 */
 		nvme_start_queues(&dev->ctrl);
 		if (dev->ctrl.admin_q && !blk_queue_dying(dev->ctrl.admin_q))
 			nvme_start_admin_queue(&dev->ctrl);
@@ -2723,11 +2725,11 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	mutex_unlock(&dev->shutdown_lock);
 }
 
-static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
+static int nvme_disable_prepare_reset(struct nvme_dev *dev, int type)
 {
 	if (!nvme_wait_reset(&dev->ctrl))
 		return -EBUSY;
-	nvme_dev_disable(dev, shutdown);
+	nvme_dev_disable(dev, type);
 	return 0;
 }
 
@@ -2785,7 +2787,7 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
 	 */
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 	nvme_get_ctrl(&dev->ctrl);
-	nvme_dev_disable(dev, false);
+	nvme_dev_disable(dev, DO_NOT_SHUTDOWN);
 	nvme_kill_queues(&dev->ctrl);
 	if (!queue_work(nvme_wq, &dev->remove_work))
 		nvme_put_ctrl(&dev->ctrl);
@@ -2810,7 +2812,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 * moving on.
 	 */
 	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, DO_NOT_SHUTDOWN);
 	nvme_sync_queues(&dev->ctrl);
 
 	mutex_lock(&dev->shutdown_lock);
@@ -3151,7 +3153,7 @@ static void nvme_reset_prepare(struct pci_dev *pdev)
 	 * state as pci_dev device lock is held, making it impossible to race
 	 * with ->remove().
 	 */
-	nvme_disable_prepare_reset(dev, false);
+	nvme_disable_prepare_reset(dev, DO_NOT_SHUTDOWN);
 	nvme_sync_queues(&dev->ctrl);
 }
 
@@ -3163,13 +3165,32 @@ static void nvme_reset_done(struct pci_dev *pdev)
 		flush_work(&dev->ctrl.reset_work);
 }
 
-static void nvme_shutdown(struct pci_dev *pdev)
+static void nvme_shutdown_pre(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
-	nvme_disable_prepare_reset(dev, true);
+	nvme_disable_prepare_reset(dev, SHUTDOWN_TYPE_ASYNC);
 }
 
+static void nvme_shutdown_post(struct pci_dev *pdev)
+{
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	mutex_lock(&dev->shutdown_lock);
+	nvme_wait_for_shutdown_cmpl(&dev->ctrl);
+
+	/*
+	 * The driver will not be starting up queues again if shutting down so
+	 * must flush all entered requests to their failed completion to avoid
+	 * deadlocking blk-mq hot-cpu notifier.
+	 */
+	nvme_start_queues(&dev->ctrl);
+	if (dev->ctrl.admin_q && !blk_queue_dying(dev->ctrl.admin_q))
+		nvme_start_admin_queue(&dev->ctrl);
+
+	mutex_unlock(&dev->shutdown_lock);
+
+}
 static void nvme_remove_attrs(struct nvme_dev *dev)
 {
 	if (dev->attrs_added)
@@ -3191,13 +3212,13 @@ static void nvme_remove(struct pci_dev *pdev)
 
 	if (!pci_device_is_present(pdev)) {
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
-		nvme_dev_disable(dev, true);
+		nvme_dev_disable(dev, SHUTDOWN_TYPE_SYNC);
 	}
 
 	flush_work(&dev->ctrl.reset_work);
 	nvme_stop_ctrl(&dev->ctrl);
 	nvme_remove_namespaces(&dev->ctrl);
-	nvme_dev_disable(dev, true);
+	nvme_dev_disable(dev, SHUTDOWN_TYPE_SYNC);
 	nvme_remove_attrs(dev);
 	nvme_free_host_mem(dev);
 	nvme_dev_remove_admin(dev);
@@ -3259,7 +3280,7 @@ static int nvme_suspend(struct device *dev)
 	if (pm_suspend_via_firmware() || !ctrl->npss ||
 	    !pcie_aspm_enabled(pdev) ||
 	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
-		return nvme_disable_prepare_reset(ndev, true);
+		return nvme_disable_prepare_reset(ndev, SHUTDOWN_TYPE_SYNC);
 
 	nvme_start_freeze(ctrl);
 	nvme_wait_freeze(ctrl);
@@ -3302,7 +3323,7 @@ static int nvme_suspend(struct device *dev)
 		 * Clearing npss forces a controller reset on resume. The
 		 * correct value will be rediscovered then.
 		 */
-		ret = nvme_disable_prepare_reset(ndev, true);
+		ret = nvme_disable_prepare_reset(ndev, SHUTDOWN_TYPE_SYNC);
 		ctrl->npss = 0;
 	}
 unfreeze:
@@ -3314,7 +3335,7 @@ static int nvme_simple_suspend(struct device *dev)
 {
 	struct nvme_dev *ndev = pci_get_drvdata(to_pci_dev(dev));
 
-	return nvme_disable_prepare_reset(ndev, true);
+	return nvme_disable_prepare_reset(ndev, SHUTDOWN_TYPE_SYNC);
 }
 
 static int nvme_simple_resume(struct device *dev)
@@ -3351,7 +3372,7 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 	case pci_channel_io_frozen:
 		dev_warn(dev->ctrl.device,
 			"frozen state error detected, reset controller\n");
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, DO_NOT_SHUTDOWN);
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
 		dev_warn(dev->ctrl.device,
@@ -3478,7 +3499,8 @@ static struct pci_driver nvme_driver = {
 	.id_table	= nvme_id_table,
 	.probe		= nvme_probe,
 	.remove		= nvme_remove,
-	.shutdown	= nvme_shutdown,
+	.shutdown_pre   = nvme_shutdown_pre,
+	.shutdown_post  = nvme_shutdown_post,
 #ifdef CONFIG_PM_SLEEP
 	.driver		= {
 		.pm	= &nvme_dev_pm_ops,
-- 
2.35.1.1021.g381101b075-goog


