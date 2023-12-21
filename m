Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D97C46CD2
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Dec 2023 17:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vO3HFBgPwUXxWie6G7dA6Lw6ZOoRQ2NZvwllpqt7Odw=; b=1QX+UMdRgfQ04kUKyNCdL2dexp
	biGCdqTZgVbcdM8LrOZpKOrg7nD1V58fDR4EdxbXkLT8BO62tRYwhFNtVFouvimeJkpPzXWgAnSO+
	ACACQPnbTiuEY2gp/x3mRmhUWMVW2wQGJQX5vutbkLN5b6K8FF+iSTuWwgirq8/SQ9x5kSGTStlwa
	G6IIu+ogH+COJt/JXpv1p8brC6HT5FT2wjmoew4UNm7a/IjxxHEiJaO2r44BQRlAUINrpX6fVr1S0
	/5dz4qomqEYr5agWjcxk7V31jrUI6qwkT+9Kr/lBBU/FEpc0R8k6YMBG/ejjdO/wWgWSrTBGTzkgZ
	b9X1qmtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rGMlT-003dnI-0e;
	Thu, 21 Dec 2023 17:23:19 +0000
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rGMlO-003diK-2M
	for linux-nvme@lists.infradead.org;
	Thu, 21 Dec 2023 17:23:17 +0000
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3bb82a52002so386472b6e.2
        for <linux-nvme@lists.infradead.org>; Thu, 21 Dec 2023 09:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1703179392; x=1703784192; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vO3HFBgPwUXxWie6G7dA6Lw6ZOoRQ2NZvwllpqt7Odw=;
        b=VE/QGaz7RlmDPHckHct4QO4wryCsnQ/jUM+D3kToJ+gw0qWcGlcYSKkoW9+6IPDxC/
         kyLEBBWV+YVmOjP9LGy5v37qwCGtdt8xp0Ngq5FQhWo3LvPusyWWNiWpcBCBRk7mtRWp
         vQ7+fHWceeGZ5R/VdogapcKWOcEr/ol2f5KWIGDT+gxmQjvk9h++P3kpXq7ut7WMDbml
         6L0VIW67taG+1oytZoMu3f/eS90MNIrm87eaRAy8a8T7Te9fBDmbtmz3y5HzRilUfiTi
         LmYYBM7T+fGUfsebQD61o9lIahhQ2usjrVfbH3PaS6VMiB4qMfZQ735ybPS8iGgjcLuQ
         przw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703179392; x=1703784192;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vO3HFBgPwUXxWie6G7dA6Lw6ZOoRQ2NZvwllpqt7Odw=;
        b=MBiYVAVKDFCCrfm+BjI//5ZPGRfoaTdcGhj5X83+/DtAQG0tTkP5Q/yUtRpZLRgAzJ
         EGYkuCxMfC059EvlB1wHId8FtNnDeVee7Ofd9FVYcdQT825+UWLA9rp+X4RnDx/oWJTg
         Wa2ZBf1BnptDJ1a3qBo+Qu7FuqJ5VUYUm3twvIRLaAvwppWyegmuRfhE0H2JgHyenXCy
         KUdbo3Lu1lxl5nhs1nC++p2Z6XKuz99NkFGzwp2+a3vNXQ2ZX8WUQ0lo4diw6IcNx0gK
         7pIm5XQ+Z0hQIf+/d5DfVvkXTICHMDlmRnNTk5vbdtfLSjSkoUvk4Kg+NSd14X9neQ92
         l5WQ==
X-Gm-Message-State: AOJu0YyFApT+/6cucaok6qbCYCNQpeX+wUNuPCD1HvlsxkDgKtzG7jzx
	HEFrC3v/UQmHdyNh8YvhUCf2krKAmlknkg==
X-Google-Smtp-Source: AGHT+IEI4rq1L+CYMKBLTemMc6NiVExusoryZtCNZv1C1YK5L1Q8w7Ica3wb9YEm80bJZ4tJaFeYpQ==
X-Received: by 2002:a05:6358:948b:b0:16b:c401:e714 with SMTP id i11-20020a056358948b00b0016bc401e714mr90481rwb.5.1703179392485;
        Thu, 21 Dec 2023 09:23:12 -0800 (PST)
Received: from localhost.localdomain (50-76-39-125-ip-static.hfc.comcastbusiness.net. [50.76.39.125])
        by smtp.gmail.com with ESMTPSA id t67-20020a625f46000000b006d6b91c6eb6sm1990744pfb.13.2023.12.21.09.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:23:12 -0800 (PST)
From: Jeremy Allison <jallison@ciq.com>
To: jallison@ciq.com,
	jra@samba.org,
	tansuresh@google.com,
	hch@lst.de,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	bhelgaas@google.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 3/4] Change 'bool shutdown' into an enum shutdown_type { NVME_DISABLE_RESET = 0, NVME_DISABLE_SHUTDOWN_SYNC = 1 }.
Date: Thu, 21 Dec 2023 09:22:56 -0800
Message-Id: <20231221172257.2234320-4-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231221172257.2234320-1-jallison@ciq.com>
References: <20231221172257.2234320-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231221_092314_799255_7FB41510 
X-CRM114-Status: GOOD (  20.66  )
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

Convert nvme_disable_ctrl() and nvme_dev_disable()
inside drivers/nvme/host/pci.c to use this

bool shutdown = false == NVME_DISABLE_RESET
bool shutdown = true == NVME_DISABLE_SHUTDOWN_SYNC.

This will make it easier to add a third request: NVME_DISABLE_SHUTDOWN_ASNYC
later.

As nvme_disable_ctrl() is used outside of drivers/nvme/host/pci.c,
convert the callers of nvme_disable_ctrl() to this convention too.

Signed-off-by: Jeremy Allison <jallison@ciq.com>
---
 drivers/nvme/host/apple.c  |  4 ++--
 drivers/nvme/host/core.c   |  6 +++---
 drivers/nvme/host/nvme.h   |  7 +++++-
 drivers/nvme/host/pci.c    | 44 +++++++++++++++++++-------------------
 drivers/nvme/host/rdma.c   |  3 ++-
 drivers/nvme/host/tcp.c    |  3 ++-
 drivers/nvme/target/loop.c |  2 +-
 7 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 596bb11eeba5..764639ede41d 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -844,8 +844,8 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
 		 * NVMe disabled state, after a clean shutdown).
 		 */
 		if (shutdown)
-			nvme_disable_ctrl(&anv->ctrl, shutdown);
-		nvme_disable_ctrl(&anv->ctrl, false);
+			nvme_disable_ctrl(&anv->ctrl, NVME_DISABLE_SHUTDOWN_SYNC);
+		nvme_disable_ctrl(&anv->ctrl, NVME_DISABLE_RESET);
 	}
 
 	WRITE_ONCE(anv->ioq.enabled, false);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d144d1acb09a..bc7040da8e74 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2211,12 +2211,12 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
 	return ret;
 }
 
-int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
+int nvme_disable_ctrl(struct nvme_ctrl *ctrl, enum shutdown_type shutdown_type)
 {
 	int ret;
 
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
-	if (shutdown)
+	if (shutdown_type == NVME_DISABLE_SHUTDOWN_SYNC)
 		ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
 	else
 		ctrl->ctrl_config &= ~NVME_CC_ENABLE;
@@ -2225,7 +2225,7 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 	if (ret)
 		return ret;
 
-	if (shutdown) {
+	if (shutdown_type == NVME_DISABLE_SHUTDOWN_SYNC) {
 		return nvme_wait_ready(ctrl, NVME_CSTS_SHST_MASK,
 				       NVME_CSTS_SHST_CMPLT,
 				       ctrl->shutdown_timeout, "shutdown");
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 3dbd187896d8..d880f1ee08d4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -187,6 +187,11 @@ enum {
 	NVME_MPATH_IO_STATS		= (1 << 2),
 };
 
+enum shutdown_type {
+	NVME_DISABLE_RESET = 0,
+	NVME_DISABLE_SHUTDOWN_SYNC = 1
+};
+
 static inline struct nvme_request *nvme_req(struct request *req)
 {
 	return blk_mq_rq_to_pdu(req);
@@ -750,7 +755,7 @@ void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
 void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
-int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);
+int nvme_disable_ctrl(struct nvme_ctrl *ctrl, enum shutdown_type shutdown_type);
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		const struct nvme_ctrl_ops *ops, unsigned long quirks);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 507bc149046d..77b015affb0b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -108,7 +108,7 @@ MODULE_PARM_DESC(noacpi, "disable acpi bios quirks");
 struct nvme_dev;
 struct nvme_queue;
 
-static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
+static void nvme_dev_disable(struct nvme_dev *dev, enum shutdown_type shutdown_type);
 static void nvme_delete_io_queues(struct nvme_dev *dev);
 static void nvme_update_attrs(struct nvme_dev *dev);
 
@@ -1330,7 +1330,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 			 "I/O %d QID %d timeout, disable controller\n",
 			 req->tag, nvmeq->qid);
 		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
-		nvme_dev_disable(dev, true);
+		nvme_dev_disable(dev, NVME_DISABLE_SHUTDOWN_SYNC);
 		return BLK_EH_DONE;
 	case NVME_CTRL_RESETTING:
 		return BLK_EH_RESET_TIMER;
@@ -1390,7 +1390,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
 		return BLK_EH_DONE;
 
-	nvme_dev_disable(dev, false);
+	nvme_dev_disable(dev, NVME_DISABLE_RESET);
 	if (nvme_try_sched_reset(&dev->ctrl))
 		nvme_unquiesce_io_queues(&dev->ctrl);
 	return BLK_EH_DONE;
@@ -1736,7 +1736,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 	 * commands to the admin queue ... and we don't know what memory that
 	 * might be pointing at!
 	 */
-	result = nvme_disable_ctrl(&dev->ctrl, false);
+	result = nvme_disable_ctrl(&dev->ctrl, NVME_DISABLE_RESET);
 	if (result < 0)
 		return result;
 
@@ -2571,7 +2571,7 @@ static bool nvme_pci_ctrl_is_dead(struct nvme_dev *dev)
 	return (csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY);
 }
 
-static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
+static void nvme_dev_disable(struct nvme_dev *dev, enum shutdown_type shutdown_type)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	bool dead;
@@ -2586,7 +2586,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		 * Give the controller a chance to complete all entered requests
 		 * if doing a safe shutdown.
 		 */
-		if (!dead && shutdown)
+		if (!dead && (shutdown_type == NVME_DISABLE_SHUTDOWN_SYNC))
 			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
 	}
 
@@ -2594,7 +2594,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 
 	if (!dead && dev->ctrl.queue_count > 0) {
 		nvme_delete_io_queues(dev);
-		nvme_disable_ctrl(&dev->ctrl, shutdown);
+		nvme_disable_ctrl(&dev->ctrl, shutdown_type);
 		nvme_poll_irqdisable(&dev->queues[0]);
 	}
 	nvme_suspend_io_queues(dev);
@@ -2612,7 +2612,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	 * must flush all entered requests to their failed completion to avoid
 	 * deadlocking blk-mq hot-cpu notifier.
 	 */
-	if (shutdown) {
+	if (shutdown_type == NVME_DISABLE_SHUTDOWN_SYNC) {
 		nvme_unquiesce_io_queues(&dev->ctrl);
 		if (dev->ctrl.admin_q && !blk_queue_dying(dev->ctrl.admin_q))
 			nvme_unquiesce_admin_queue(&dev->ctrl);
@@ -2620,11 +2620,11 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	mutex_unlock(&dev->shutdown_lock);
 }
 
-static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
+static int nvme_disable_prepare_reset(struct nvme_dev *dev, enum shutdown_type shutdown_type)
 {
 	if (!nvme_wait_reset(&dev->ctrl))
 		return -EBUSY;
-	nvme_dev_disable(dev, shutdown);
+	nvme_dev_disable(dev, shutdown_type);
 	return 0;
 }
 
@@ -2702,7 +2702,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 * moving on.
 	 */
 	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, NVME_DISABLE_RESET);
 	nvme_sync_queues(&dev->ctrl);
 
 	mutex_lock(&dev->shutdown_lock);
@@ -2780,7 +2780,7 @@ static void nvme_reset_work(struct work_struct *work)
 	dev_warn(dev->ctrl.device, "Disabling device after reset failure: %d\n",
 		 result);
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
-	nvme_dev_disable(dev, true);
+	nvme_dev_disable(dev, NVME_DISABLE_SHUTDOWN_SYNC);
 	nvme_sync_queues(&dev->ctrl);
 	nvme_mark_namespaces_dead(&dev->ctrl);
 	nvme_unquiesce_io_queues(&dev->ctrl);
@@ -3058,7 +3058,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 out_disable:
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
-	nvme_dev_disable(dev, true);
+	nvme_dev_disable(dev, NVME_DISABLE_SHUTDOWN_SYNC);
 	nvme_free_host_mem(dev);
 	nvme_dev_remove_admin(dev);
 	nvme_dbbuf_dma_free(dev);
@@ -3084,7 +3084,7 @@ static void nvme_reset_prepare(struct pci_dev *pdev)
 	 * state as pci_dev device lock is held, making it impossible to race
 	 * with ->remove().
 	 */
-	nvme_disable_prepare_reset(dev, false);
+	nvme_disable_prepare_reset(dev, NVME_DISABLE_RESET);
 	nvme_sync_queues(&dev->ctrl);
 }
 
@@ -3100,7 +3100,7 @@ static void nvme_shutdown(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
-	nvme_disable_prepare_reset(dev, true);
+	nvme_disable_prepare_reset(dev, NVME_DISABLE_SHUTDOWN_SYNC);
 }
 
 /*
@@ -3117,13 +3117,13 @@ static void nvme_remove(struct pci_dev *pdev)
 
 	if (!pci_device_is_present(pdev)) {
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
-		nvme_dev_disable(dev, true);
+		nvme_dev_disable(dev, NVME_DISABLE_SHUTDOWN_SYNC);
 	}
 
 	flush_work(&dev->ctrl.reset_work);
 	nvme_stop_ctrl(&dev->ctrl);
 	nvme_remove_namespaces(&dev->ctrl);
-	nvme_dev_disable(dev, true);
+	nvme_dev_disable(dev, NVME_DISABLE_SHUTDOWN_SYNC);
 	nvme_free_host_mem(dev);
 	nvme_dev_remove_admin(dev);
 	nvme_dbbuf_dma_free(dev);
@@ -3186,7 +3186,7 @@ static int nvme_suspend(struct device *dev)
 	if (pm_suspend_via_firmware() || !ctrl->npss ||
 	    !pcie_aspm_enabled(pdev) ||
 	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
-		return nvme_disable_prepare_reset(ndev, true);
+		return nvme_disable_prepare_reset(ndev, NVME_DISABLE_SHUTDOWN_SYNC);
 
 	nvme_start_freeze(ctrl);
 	nvme_wait_freeze(ctrl);
@@ -3229,7 +3229,7 @@ static int nvme_suspend(struct device *dev)
 		 * Clearing npss forces a controller reset on resume. The
 		 * correct value will be rediscovered then.
 		 */
-		ret = nvme_disable_prepare_reset(ndev, true);
+		ret = nvme_disable_prepare_reset(ndev, NVME_DISABLE_SHUTDOWN_SYNC);
 		ctrl->npss = 0;
 	}
 unfreeze:
@@ -3241,7 +3241,7 @@ static int nvme_simple_suspend(struct device *dev)
 {
 	struct nvme_dev *ndev = pci_get_drvdata(to_pci_dev(dev));
 
-	return nvme_disable_prepare_reset(ndev, true);
+	return nvme_disable_prepare_reset(ndev, NVME_DISABLE_SHUTDOWN_SYNC);
 }
 
 static int nvme_simple_resume(struct device *dev)
@@ -3279,10 +3279,10 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 		dev_warn(dev->ctrl.device,
 			"frozen state error detected, reset controller\n");
 		if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
-			nvme_dev_disable(dev, true);
+			nvme_dev_disable(dev, NVME_DISABLE_SHUTDOWN_SYNC);
 			return PCI_ERS_RESULT_DISCONNECT;
 		}
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, NVME_DISABLE_RESET);
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
 		dev_warn(dev->ctrl.device,
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index bc90ec3c51b0..b969ab23a55b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2136,7 +2136,8 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
 	nvme_rdma_teardown_io_queues(ctrl, shutdown);
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
-	nvme_disable_ctrl(&ctrl->ctrl, shutdown);
+	nvme_disable_ctrl(&ctrl->ctrl, shutdown ?
+		NVME_DISABLE_SHUTDOWN_SYNC : NVME_DISABLE_RESET);
 	nvme_rdma_teardown_admin_queue(ctrl, shutdown);
 }
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d79811cfa0ce..e3f4541abccd 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2292,7 +2292,8 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
 	nvme_tcp_teardown_io_queues(ctrl, shutdown);
 	nvme_quiesce_admin_queue(ctrl);
-	nvme_disable_ctrl(ctrl, shutdown);
+	nvme_disable_ctrl(ctrl, shutdown ?
+		NVME_DISABLE_SHUTDOWN_SYNC : NVME_DISABLE_RESET);
 	nvme_tcp_teardown_admin_queue(ctrl, shutdown);
 }
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 9cb434c58075..6cb6e7c6bdd1 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -401,7 +401,7 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
-		nvme_disable_ctrl(&ctrl->ctrl, true);
+		nvme_disable_ctrl(&ctrl->ctrl, NVME_DISABLE_SHUTDOWN_SYNC);
 
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	nvme_loop_destroy_admin_queue(ctrl);
-- 
2.39.3


