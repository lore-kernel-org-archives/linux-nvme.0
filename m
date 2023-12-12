Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A889C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Dec 2023 18:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qhFeidWBuKukkRd/DfR03yQ0PU+/y8525rh84VnKjck=; b=gACvHx3v0B80q9qXzK05S3Elhv
	z2auArMypnMjgWxKqFyQ/otTX4i/3I4nW5Eokw5X4gqj0h4nXtsmP/2OheKncr8y9ozsxoPhG+i3k
	J35VN6KW6s1HzAgcQVUfEWLawgMxYyoq0//AweSo3IpGOs5nCfq4VDKD65OLx9VGUkHnrtC200eNS
	vLaKGj2r1+2oRYL4J6s2eNV75tOLId2G3n2/GttTdVz3LH2qipnpVXxTTZlD8BXufq9IS232OiSvc
	Q9fln4+57bz8yyexLgJExSRXuIZpEojrdsz4JPlgXtYYwMEzIv70hNqo9fjmNivXHMV8DUHnKkiac
	e3yiMHag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rD7Cd-00CSiC-0q;
	Tue, 12 Dec 2023 18:09:55 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rD7CZ-00CSgr-1l
	for linux-nvme@lists.infradead.org;
	Tue, 12 Dec 2023 18:09:53 +0000
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-5c699b44dddso3018146a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 12 Dec 2023 10:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ciq.com; s=s1; t=1702404590; x=1703009390; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhFeidWBuKukkRd/DfR03yQ0PU+/y8525rh84VnKjck=;
        b=p5Uh2BIxwHNs5lCKoME5DiuZzODRY5gdhbHQ7KbYjM0LD+K4SZ/iF7zoCfbgnI7eNd
         pj3ZoHvJQ03OzncNBLNvdlVuJINZXbkp285vq07vtKVmxIt6dR4EEG4gT4NdtYvIiizm
         aIZmclg/kpGaAFHZyBljfN5IPbQFZPDYXovLbSC/+LTnAvzhb1j+T0LmztmC5bQbv1Gi
         GzzT0VxOayg1gOttQKdfIZGC1fUvL7A9AiMV+cYST9+uckAe5XFpN8ddhkaAOZoY3mRF
         XbfrGjV/ZjOTMW0dFi88fhABltZvIRBUoiqU5zOghCDOD/8Fe9Tlmiykx94bpBmBF7Wv
         lb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702404590; x=1703009390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhFeidWBuKukkRd/DfR03yQ0PU+/y8525rh84VnKjck=;
        b=mVW5gyBgoHkn5snH+ensYazo3usiivfJDWLotXTd2ipSYjs6V6RJYz+K9eUL2yB/+y
         fuxr/JP8CQ2h/KqFZgqTS1xKzoluOBqYQxrRazMvFzwinYPHMdgOINX5CBmkXObH4f8I
         QhId5PoiuB41fDWiP0jBwKeljlX5Vrp6IrSXXX5tF9+Up2DlhaGkYqsWUyZ68DfsKGTh
         KSDi+TEpGu23i8QMQiXH1oUhuR0axzY9pJ0DiDVhVVMFyKYx74tUG52syyLRTbpGf5Rk
         m0DRGa9UY8EEjYuBROqlyobAXNfCUBC06WhXhOKBLe3DzsQBDQuAAGwMWHh892XOpKCT
         DeIA==
X-Gm-Message-State: AOJu0YyibrHQeHK0fAkIu8bjzlSdAkba3AfHLnDo0C5dyk968qGnodF4
	638f8iWGtPyuk+7I2TcwumVwQg==
X-Google-Smtp-Source: AGHT+IFGTm5IXuO31EUnPWMJY3CQFVRgvoZQo6EbeBW3f/XxAveEZ7PycDK1s/7fFa5ix2nUWJPkPA==
X-Received: by 2002:a05:6a20:bf10:b0:18f:97c:4f62 with SMTP id gc16-20020a056a20bf1000b0018f097c4f62mr3527550pzb.110.1702404590005;
        Tue, 12 Dec 2023 10:09:50 -0800 (PST)
Received: from localhost.localdomain (50-76-39-125-ip-static.hfc.comcastbusiness.net. [50.76.39.125])
        by smtp.gmail.com with ESMTPSA id x3-20020a636303000000b005a9b20408a7sm8419861pgb.23.2023.12.12.10.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 10:09:49 -0800 (PST)
From: Jeremy Allison <jallison@ciq.com>
To: jallison@ciq.com,
	jra@samba.org,
	tansuresh@google.com,
	hch@lst.de
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] nvme: Add async shutdown support
Date: Tue, 12 Dec 2023 10:09:38 -0800
Message-Id: <20231212180938.397403-4-jallison@ciq.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231212180938.397403-1-jallison@ciq.com>
References: <20231212180938.397403-1-jallison@ciq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231212_100951_585327_ACC38FC3 
X-CRM114-Status: GOOD (  25.98  )
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

From: Tanjore Suresh <tansuresh@google.com>

This works with the asynchronous shutdown mechanism setup for the PCI
drivers and participates to provide both pre and post shutdown
routines at pci_driver structure level.

The shutdown_pre routine starts the shutdown and does not wait for the
shutdown to complete.  The shutdown_post routine waits for the shutdown
to complete on individual controllers that this driver instance
controls. This mechanism optimizes to speed up the shutdown in a
system which host many controllers.

Signed-off-by: Tanjore Suresh <tansuresh@google.com>
Signed-off-by: Jeremy Allison <jallison@ciq.com>
---
 drivers/nvme/host/core.c   | 31 +++++++++++++++--
 drivers/nvme/host/nvme.h   |  9 ++++-
 drivers/nvme/host/pci.c    | 68 ++++++++++++++++++++++++--------------
 drivers/nvme/host/rdma.c   |  3 +-
 drivers/nvme/host/tcp.c    |  2 +-
 drivers/nvme/target/loop.c |  2 +-
 6 files changed, 84 insertions(+), 31 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 590cd4f097c2..45645af41586 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2201,12 +2201,12 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
 	return ret;
 }
 
-int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
+int nvme_disable_ctrl(struct nvme_ctrl *ctrl, enum shutdown_type shutdown_type)
 {
 	int ret;
 
 	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
-	if (shutdown)
+	if (shutdown_type != DO_NOT_SHUTDOWN)
 		ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
 	else
 		ctrl->ctrl_config &= ~NVME_CC_ENABLE;
@@ -2215,10 +2215,24 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 	if (ret)
 		return ret;
 
-	if (shutdown) {
+	switch (shutdown_type) {
+	case SHUTDOWN_TYPE_ASYNC:
+		/*
+		 * nvme_wait_for_shutdown_cmpl() will read the reply for this.
+		 */
+		return ret;
+	case SHUTDOWN_TYPE_SYNC:
+		/*
+		 * Spin on the read of the control register.
+		 */
 		return nvme_wait_ready(ctrl, NVME_CSTS_SHST_MASK,
 				       NVME_CSTS_SHST_CMPLT,
 				       ctrl->shutdown_timeout, "shutdown");
+	case DO_NOT_SHUTDOWN:
+		/*
+		 * Doing a reset here. Handle below.
+		 */
+		break;
 	}
 	if (ctrl->quirks & NVME_QUIRK_DELAY_BEFORE_CHK_RDY)
 		msleep(NVME_QUIRK_DELAY_AMOUNT);
@@ -2227,6 +2241,17 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 }
 EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
 
+int nvme_wait_for_shutdown_cmpl(struct nvme_ctrl *ctrl)
+{
+	ctrl->ctrl_config &= ~NVME_CC_SHN_MASK;
+	ctrl->ctrl_config |= NVME_CC_SHN_NORMAL;
+
+	return nvme_wait_ready(ctrl, NVME_CSTS_SHST_MASK,
+			       NVME_CSTS_SHST_CMPLT,
+			       ctrl->shutdown_timeout, "shutdown");
+}
+EXPORT_SYMBOL_GPL(nvme_wait_for_shutdown_cmpl);
+
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 {
 	unsigned dev_page_min;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 39a90b7cb125..1ce034185000 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -186,6 +186,12 @@ enum {
 	NVME_MPATH_IO_STATS		= (1 << 2),
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
@@ -746,7 +752,8 @@ void nvme_cancel_tagset(struct nvme_ctrl *ctrl);
 void nvme_cancel_admin_tagset(struct nvme_ctrl *ctrl);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
-int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown);
+int nvme_disable_ctrl(struct nvme_ctrl *ctrl, enum shutdown_type shutdown_type);
+int nvme_wait_for_shutdown_cmpl(struct nvme_ctrl *ctrl);
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		const struct nvme_ctrl_ops *ops, unsigned long quirks);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 507bc149046d..5379ce6dd21a 100644
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
+		nvme_dev_disable(dev, SHUTDOWN_TYPE_SYNC);
 		return BLK_EH_DONE;
 	case NVME_CTRL_RESETTING:
 		return BLK_EH_RESET_TIMER;
@@ -1390,7 +1390,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
 		return BLK_EH_DONE;
 
-	nvme_dev_disable(dev, false);
+	nvme_dev_disable(dev, DO_NOT_SHUTDOWN);
 	if (nvme_try_sched_reset(&dev->ctrl))
 		nvme_unquiesce_io_queues(&dev->ctrl);
 	return BLK_EH_DONE;
@@ -1736,7 +1736,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 	 * commands to the admin queue ... and we don't know what memory that
 	 * might be pointing at!
 	 */
-	result = nvme_disable_ctrl(&dev->ctrl, false);
+	result = nvme_disable_ctrl(&dev->ctrl, DO_NOT_SHUTDOWN);
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
+		if (!dead && (shutdown_type != DO_NOT_SHUTDOWN))
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
+	if (shutdown_type == SHUTDOWN_TYPE_SYNC) {
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
+		nvme_dev_disable(dev, DO_NOT_SHUTDOWN);
 	nvme_sync_queues(&dev->ctrl);
 
 	mutex_lock(&dev->shutdown_lock);
@@ -2780,7 +2780,7 @@ static void nvme_reset_work(struct work_struct *work)
 	dev_warn(dev->ctrl.device, "Disabling device after reset failure: %d\n",
 		 result);
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
-	nvme_dev_disable(dev, true);
+	nvme_dev_disable(dev, SHUTDOWN_TYPE_SYNC);
 	nvme_sync_queues(&dev->ctrl);
 	nvme_mark_namespaces_dead(&dev->ctrl);
 	nvme_unquiesce_io_queues(&dev->ctrl);
@@ -3058,7 +3058,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 out_disable:
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
-	nvme_dev_disable(dev, true);
+	nvme_dev_disable(dev, SHUTDOWN_TYPE_SYNC);
 	nvme_free_host_mem(dev);
 	nvme_dev_remove_admin(dev);
 	nvme_dbbuf_dma_free(dev);
@@ -3084,7 +3084,7 @@ static void nvme_reset_prepare(struct pci_dev *pdev)
 	 * state as pci_dev device lock is held, making it impossible to race
 	 * with ->remove().
 	 */
-	nvme_disable_prepare_reset(dev, false);
+	nvme_disable_prepare_reset(dev, DO_NOT_SHUTDOWN);
 	nvme_sync_queues(&dev->ctrl);
 }
 
@@ -3096,11 +3096,30 @@ static void nvme_reset_done(struct pci_dev *pdev)
 		flush_work(&dev->ctrl.reset_work);
 }
 
-static void nvme_shutdown(struct pci_dev *pdev)
+static void nvme_shutdown_pre(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 
-	nvme_disable_prepare_reset(dev, true);
+	nvme_disable_prepare_reset(dev, SHUTDOWN_TYPE_ASYNC);
+}
+
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
+	nvme_unquiesce_io_queues(&dev->ctrl);
+	if (dev->ctrl.admin_q && !blk_queue_dying(dev->ctrl.admin_q))
+		nvme_unquiesce_admin_queue(&dev->ctrl);
+
+	mutex_unlock(&dev->shutdown_lock);
 }
 
 /*
@@ -3117,13 +3136,13 @@ static void nvme_remove(struct pci_dev *pdev)
 
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
 	nvme_free_host_mem(dev);
 	nvme_dev_remove_admin(dev);
 	nvme_dbbuf_dma_free(dev);
@@ -3186,7 +3205,7 @@ static int nvme_suspend(struct device *dev)
 	if (pm_suspend_via_firmware() || !ctrl->npss ||
 	    !pcie_aspm_enabled(pdev) ||
 	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
-		return nvme_disable_prepare_reset(ndev, true);
+		return nvme_disable_prepare_reset(ndev, SHUTDOWN_TYPE_SYNC);
 
 	nvme_start_freeze(ctrl);
 	nvme_wait_freeze(ctrl);
@@ -3229,7 +3248,7 @@ static int nvme_suspend(struct device *dev)
 		 * Clearing npss forces a controller reset on resume. The
 		 * correct value will be rediscovered then.
 		 */
-		ret = nvme_disable_prepare_reset(ndev, true);
+		ret = nvme_disable_prepare_reset(ndev, SHUTDOWN_TYPE_SYNC);
 		ctrl->npss = 0;
 	}
 unfreeze:
@@ -3241,7 +3260,7 @@ static int nvme_simple_suspend(struct device *dev)
 {
 	struct nvme_dev *ndev = pci_get_drvdata(to_pci_dev(dev));
 
-	return nvme_disable_prepare_reset(ndev, true);
+	return nvme_disable_prepare_reset(ndev, SHUTDOWN_TYPE_SYNC);
 }
 
 static int nvme_simple_resume(struct device *dev)
@@ -3279,10 +3298,10 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 		dev_warn(dev->ctrl.device,
 			"frozen state error detected, reset controller\n");
 		if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
-			nvme_dev_disable(dev, true);
+			nvme_dev_disable(dev, SHUTDOWN_TYPE_SYNC);
 			return PCI_ERS_RESULT_DISCONNECT;
 		}
-		nvme_dev_disable(dev, false);
+		nvme_dev_disable(dev, DO_NOT_SHUTDOWN);
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
 		dev_warn(dev->ctrl.device,
@@ -3491,7 +3510,8 @@ static struct pci_driver nvme_driver = {
 	.id_table	= nvme_id_table,
 	.probe		= nvme_probe,
 	.remove		= nvme_remove,
-	.shutdown	= nvme_shutdown,
+	.shutdown_pre	= nvme_shutdown_pre,
+	.shutdown_post	= nvme_shutdown_post,
 	.driver		= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 #ifdef CONFIG_PM_SLEEP
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6d178d555920..5a5bef40ed2a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2136,7 +2136,8 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
 	nvme_rdma_teardown_io_queues(ctrl, shutdown);
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
-	nvme_disable_ctrl(&ctrl->ctrl, shutdown);
+	nvme_disable_ctrl(&ctrl->ctrl,
+			  shutdown ? SHUTDOWN_TYPE_SYNC : DO_NOT_SHUTDOWN);
 	nvme_rdma_teardown_admin_queue(ctrl, shutdown);
 }
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d79811cfa0ce..a1e33ee14f5b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2292,7 +2292,7 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
 	nvme_tcp_teardown_io_queues(ctrl, shutdown);
 	nvme_quiesce_admin_queue(ctrl);
-	nvme_disable_ctrl(ctrl, shutdown);
+	nvme_disable_ctrl(ctrl, shutdown ? SHUTDOWN_TYPE_SYNC : DO_NOT_SHUTDOWN);
 	nvme_tcp_teardown_admin_queue(ctrl, shutdown);
 }
 
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 9cb434c58075..9d1221c77061 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -401,7 +401,7 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
-		nvme_disable_ctrl(&ctrl->ctrl, true);
+		nvme_disable_ctrl(&ctrl->ctrl, SHUTDOWN_TYPE_SYNC);
 
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	nvme_loop_destroy_admin_queue(ctrl);
-- 
2.39.3


