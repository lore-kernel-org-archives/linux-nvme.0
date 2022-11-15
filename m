Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 634B9C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Nov 2022 10:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+D4GykVLJDp6nvEvOdt/Id2biQUusHjV2bwil99tS6o=; b=xH4WqsbdBTB7uemg351E19rUO7
	hIsfmNhSaikQK92q/EFlHhX5h98AaiK6BahCgYpgDJFT3olzA2B0AXFzzPB5LQkAadbrBRxvsa4W+
	a91dAutdb4EG5hKaQz9AsOCtOcv3fbv3cKx/zA5CQl1W7MbGStTOR52w9IgruJ785Flsa+NL9QXKO
	xkl4Wrs/jzy1z3BSlIMxLAvaZaDxbjdx9BN/ZcwsTFN5hN+deYtq/ncDNRl2FGSb04qHJtSCZ4LUV
	aShbgqbQ27iV9WRV4qWMgxk/rN0x1mOOSIXgcpkgCdcy5RMRYIM7FQHVvtcWpBl93C4xAyeVcgC6c
	kE5eJTCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1outPl-00A5Vb-1m; Tue, 15 Nov 2022 10:43:37 +0000
Received: from [2001:4bb8:191:2606:160:4e5a:8508:c11d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1out6a-009sP4-R6; Tue, 15 Nov 2022 10:23:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me,
	james.smart@broadcom.com,
	kch@nvidia.com,
	marcan@marcan.st,
	sven@svenpeter.dev
Cc: asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: rename the queue quiescing helpers
Date: Tue, 15 Nov 2022 11:23:46 +0100
Message-Id: <20221115102346.1641696-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Naming the nvme helpers that wrap the block quiesce funtionality
start/stop is rather confusing.  Switch to using the quiesce naming
of the block layer instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/apple.c  | 12 ++++++------
 drivers/nvme/host/core.c   | 24 ++++++++++++------------
 drivers/nvme/host/fc.c     | 16 ++++++++--------
 drivers/nvme/host/nvme.h   |  8 ++++----
 drivers/nvme/host/pci.c    | 16 ++++++++--------
 drivers/nvme/host/rdma.c   | 26 +++++++++++++-------------
 drivers/nvme/host/tcp.c    | 28 ++++++++++++++--------------
 drivers/nvme/target/loop.c |  6 +++---
 8 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index a85349a7e938c..cab69516af5b8 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -821,7 +821,7 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
 	if (!dead && shutdown && freeze)
 		nvme_wait_freeze_timeout(&anv->ctrl, NVME_IO_TIMEOUT);
 
-	nvme_stop_queues(&anv->ctrl);
+	nvme_quiesce_io_queues(&anv->ctrl);
 
 	if (!dead) {
 		if (READ_ONCE(anv->ioq.enabled)) {
@@ -837,7 +837,7 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
 	WRITE_ONCE(anv->ioq.enabled, false);
 	WRITE_ONCE(anv->adminq.enabled, false);
 	mb(); /* ensure that nvme_queue_rq() sees that enabled is cleared */
-	nvme_stop_admin_queue(&anv->ctrl);
+	nvme_quiesce_admin_queue(&anv->ctrl);
 
 	/* last chance to complete any requests before nvme_cancel_request */
 	spin_lock_irqsave(&anv->lock, flags);
@@ -854,8 +854,8 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
 	 * deadlocking blk-mq hot-cpu notifier.
 	 */
 	if (shutdown) {
-		nvme_start_queues(&anv->ctrl);
-		nvme_start_admin_queue(&anv->ctrl);
+		nvme_unquiesce_io_queues(&anv->ctrl);
+		nvme_unquiesce_admin_queue(&anv->ctrl);
 	}
 }
 
@@ -1093,7 +1093,7 @@ static void apple_nvme_reset_work(struct work_struct *work)
 
 	dev_dbg(anv->dev, "Starting admin queue");
 	apple_nvme_init_queue(&anv->adminq);
-	nvme_start_admin_queue(&anv->ctrl);
+	nvme_unquiesce_admin_queue(&anv->ctrl);
 
 	if (!nvme_change_ctrl_state(&anv->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_warn(anv->ctrl.device,
@@ -1127,7 +1127,7 @@ static void apple_nvme_reset_work(struct work_struct *work)
 
 	anv->ctrl.queue_count = nr_io_queues + 1;
 
-	nvme_start_queues(&anv->ctrl);
+	nvme_unquiesce_io_queues(&anv->ctrl);
 	nvme_wait_freeze(&anv->ctrl);
 	blk_mq_update_nr_hw_queues(&anv->tagset, 1);
 	nvme_unfreeze(&anv->ctrl);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ca4d40996ac17..3195ae17df309 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4610,7 +4610,7 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 */
 	if (ctrl->state == NVME_CTRL_DEAD) {
 		nvme_mark_namespaces_dead(ctrl);
-		nvme_start_queues(ctrl);
+		nvme_unquiesce_io_queues(ctrl);
 	}
 
 	/* this is a no-op when called from the controller reset handler */
@@ -4737,7 +4737,7 @@ static void nvme_fw_act_work(struct work_struct *work)
 		fw_act_timeout = jiffies +
 				msecs_to_jiffies(admin_timeout * 1000);
 
-	nvme_stop_queues(ctrl);
+	nvme_quiesce_io_queues(ctrl);
 	while (nvme_ctrl_pp_status(ctrl)) {
 		if (time_after(jiffies, fw_act_timeout)) {
 			dev_warn(ctrl->device,
@@ -4751,7 +4751,7 @@ static void nvme_fw_act_work(struct work_struct *work)
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_LIVE))
 		return;
 
-	nvme_start_queues(ctrl);
+	nvme_unquiesce_io_queues(ctrl);
 	/* read FW slot information to clear the AER */
 	nvme_get_fw_slot_info(ctrl);
 
@@ -4996,7 +4996,7 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 
 	if (ctrl->queue_count > 1) {
 		nvme_queue_scan(ctrl);
-		nvme_start_queues(ctrl);
+		nvme_unquiesce_io_queues(ctrl);
 		nvme_mpath_update(ctrl);
 	}
 
@@ -5213,37 +5213,37 @@ void nvme_start_freeze(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_start_freeze);
 
-void nvme_stop_queues(struct nvme_ctrl *ctrl)
+void nvme_quiesce_io_queues(struct nvme_ctrl *ctrl)
 {
 	if (!test_and_set_bit(NVME_CTRL_STOPPED, &ctrl->flags))
 		blk_mq_quiesce_tagset(ctrl->tagset);
 	else
 		blk_mq_wait_quiesce_done(ctrl->tagset);
 }
-EXPORT_SYMBOL_GPL(nvme_stop_queues);
+EXPORT_SYMBOL_GPL(nvme_quiesce_io_queues);
 
-void nvme_start_queues(struct nvme_ctrl *ctrl)
+void nvme_unquiesce_io_queues(struct nvme_ctrl *ctrl)
 {
 	if (test_and_clear_bit(NVME_CTRL_STOPPED, &ctrl->flags))
 		blk_mq_unquiesce_tagset(ctrl->tagset);
 }
-EXPORT_SYMBOL_GPL(nvme_start_queues);
+EXPORT_SYMBOL_GPL(nvme_unquiesce_io_queues);
 
-void nvme_stop_admin_queue(struct nvme_ctrl *ctrl)
+void nvme_quiesce_admin_queue(struct nvme_ctrl *ctrl)
 {
 	if (!test_and_set_bit(NVME_CTRL_ADMIN_Q_STOPPED, &ctrl->flags))
 		blk_mq_quiesce_queue(ctrl->admin_q);
 	else
 		blk_mq_wait_quiesce_done(ctrl->admin_q->tag_set);
 }
-EXPORT_SYMBOL_GPL(nvme_stop_admin_queue);
+EXPORT_SYMBOL_GPL(nvme_quiesce_admin_queue);
 
-void nvme_start_admin_queue(struct nvme_ctrl *ctrl)
+void nvme_unquiesce_admin_queue(struct nvme_ctrl *ctrl)
 {
 	if (test_and_clear_bit(NVME_CTRL_ADMIN_Q_STOPPED, &ctrl->flags))
 		blk_mq_unquiesce_queue(ctrl->admin_q);
 }
-EXPORT_SYMBOL_GPL(nvme_start_admin_queue);
+EXPORT_SYMBOL_GPL(nvme_unquiesce_admin_queue);
 
 void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
 {
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 1f9f4075794b5..aa5fb56c07d99 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2392,7 +2392,7 @@ nvme_fc_ctrl_free(struct kref *ref)
 	list_del(&ctrl->ctrl_list);
 	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
 
-	nvme_start_admin_queue(&ctrl->ctrl);
+	nvme_unquiesce_admin_queue(&ctrl->ctrl);
 	nvme_remove_admin_tag_set(&ctrl->ctrl);
 
 	kfree(ctrl->queues);
@@ -2493,13 +2493,13 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 	 * (but with error status).
 	 */
 	if (ctrl->ctrl.queue_count > 1) {
-		nvme_stop_queues(&ctrl->ctrl);
+		nvme_quiesce_io_queues(&ctrl->ctrl);
 		nvme_sync_io_queues(&ctrl->ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
 		blk_mq_tagset_wait_completed_request(&ctrl->tag_set);
 		if (start_queues)
-			nvme_start_queues(&ctrl->ctrl);
+			nvme_unquiesce_io_queues(&ctrl->ctrl);
 	}
 
 	/*
@@ -2517,13 +2517,13 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 	/*
 	 * clean up the admin queue. Same thing as above.
 	 */
-	nvme_stop_admin_queue(&ctrl->ctrl);
+	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	blk_sync_queue(ctrl->ctrl.admin_q);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
 	blk_mq_tagset_wait_completed_request(&ctrl->admin_tag_set);
 	if (start_queues)
-		nvme_start_admin_queue(&ctrl->ctrl);
+		nvme_unquiesce_admin_queue(&ctrl->ctrl);
 }
 
 static void
@@ -3105,7 +3105,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	ctrl->ctrl.max_hw_sectors = ctrl->ctrl.max_segments <<
 						(ilog2(SZ_4K) - 9);
 
-	nvme_start_admin_queue(&ctrl->ctrl);
+	nvme_unquiesce_admin_queue(&ctrl->ctrl);
 
 	ret = nvme_init_ctrl_finish(&ctrl->ctrl, false);
 	if (ret || test_bit(ASSOC_FAILED, &ctrl->flags))
@@ -3251,10 +3251,10 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	nvme_fc_free_queue(&ctrl->queues[0]);
 
 	/* re-enable the admin_q so anything new can fast fail */
-	nvme_start_admin_queue(&ctrl->ctrl);
+	nvme_unquiesce_admin_queue(&ctrl->ctrl);
 
 	/* resume the io queues so that things will fast fail */
-	nvme_start_queues(&ctrl->ctrl);
+	nvme_unquiesce_io_queues(&ctrl->ctrl);
 
 	nvme_fc_ctlr_inactive_on_rport(ctrl);
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5965c70c5189c..f8d125822cbbd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -752,10 +752,10 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		volatile union nvme_result *res);
 
-void nvme_stop_queues(struct nvme_ctrl *ctrl);
-void nvme_start_queues(struct nvme_ctrl *ctrl);
-void nvme_stop_admin_queue(struct nvme_ctrl *ctrl);
-void nvme_start_admin_queue(struct nvme_ctrl *ctrl);
+void nvme_quiesce_io_queues(struct nvme_ctrl *ctrl);
+void nvme_unquiesce_io_queues(struct nvme_ctrl *ctrl);
+void nvme_quiesce_admin_queue(struct nvme_ctrl *ctrl);
+void nvme_unquiesce_admin_queue(struct nvme_ctrl *ctrl);
 void nvme_mark_namespaces_dead(struct nvme_ctrl *ctrl);
 void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_sync_io_queues(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fe21c9c153128..9e90209ddbdd2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1481,7 +1481,7 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 
 	nvmeq->dev->online_queues--;
 	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
-		nvme_stop_admin_queue(&nvmeq->dev->ctrl);
+		nvme_quiesce_admin_queue(&nvmeq->dev->ctrl);
 	if (!test_and_clear_bit(NVMEQ_POLLED, &nvmeq->flags))
 		pci_free_irq(to_pci_dev(nvmeq->dev->dev), nvmeq->cq_vector, nvmeq);
 	return 0;
@@ -1741,7 +1741,7 @@ static void nvme_dev_remove_admin(struct nvme_dev *dev)
 		 * user requests may be waiting on a stopped queue. Start the
 		 * queue to flush these to completion.
 		 */
-		nvme_start_admin_queue(&dev->ctrl);
+		nvme_unquiesce_admin_queue(&dev->ctrl);
 		blk_mq_destroy_queue(dev->ctrl.admin_q);
 		blk_put_queue(dev->ctrl.admin_q);
 		blk_mq_free_tag_set(&dev->admin_tagset);
@@ -2703,7 +2703,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	if (!dead && shutdown && freeze)
 		nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
 
-	nvme_stop_queues(&dev->ctrl);
+	nvme_quiesce_io_queues(&dev->ctrl);
 
 	if (!dead && dev->ctrl.queue_count > 0) {
 		nvme_disable_io_queues(dev);
@@ -2723,9 +2723,9 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	 * deadlocking blk-mq hot-cpu notifier.
 	 */
 	if (shutdown) {
-		nvme_start_queues(&dev->ctrl);
+		nvme_unquiesce_io_queues(&dev->ctrl);
 		if (dev->ctrl.admin_q && !blk_queue_dying(dev->ctrl.admin_q))
-			nvme_start_admin_queue(&dev->ctrl);
+			nvme_unquiesce_admin_queue(&dev->ctrl);
 	}
 	mutex_unlock(&dev->shutdown_lock);
 }
@@ -2822,7 +2822,7 @@ static void nvme_reset_work(struct work_struct *work)
 	result = nvme_pci_enable(dev);
 	if (result)
 		goto out_unlock;
-	nvme_start_admin_queue(&dev->ctrl);
+	nvme_unquiesce_admin_queue(&dev->ctrl);
 	mutex_unlock(&dev->shutdown_lock);
 
 	/*
@@ -2856,7 +2856,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 * controller around but remove all namespaces.
 	 */
 	if (dev->online_queues > 1) {
-		nvme_start_queues(&dev->ctrl);
+		nvme_unquiesce_io_queues(&dev->ctrl);
 		nvme_wait_freeze(&dev->ctrl);
 		nvme_pci_update_nr_queues(dev);
 		nvme_dbbuf_set(dev);
@@ -2864,7 +2864,7 @@ static void nvme_reset_work(struct work_struct *work)
 	} else {
 		dev_warn(dev->ctrl.device, "IO queues lost\n");
 		nvme_mark_namespaces_dead(&dev->ctrl);
-		nvme_start_queues(&dev->ctrl);
+		nvme_unquiesce_io_queues(&dev->ctrl);
 		nvme_remove_namespaces(&dev->ctrl);
 		nvme_free_tagset(dev);
 	}
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3d78278e47c53..de591cdf78f3b 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -869,7 +869,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	else
 		ctrl->ctrl.max_integrity_segments = 0;
 
-	nvme_start_admin_queue(&ctrl->ctrl);
+	nvme_unquiesce_admin_queue(&ctrl->ctrl);
 
 	error = nvme_init_ctrl_finish(&ctrl->ctrl, false);
 	if (error)
@@ -878,7 +878,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	return 0;
 
 out_quiesce_queue:
-	nvme_stop_admin_queue(&ctrl->ctrl);
+	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	blk_sync_queue(ctrl->ctrl.admin_q);
 out_stop_queue:
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
@@ -922,7 +922,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		goto out_cleanup_tagset;
 
 	if (!new) {
-		nvme_start_queues(&ctrl->ctrl);
+		nvme_unquiesce_io_queues(&ctrl->ctrl);
 		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
 			/*
 			 * If we timed out waiting for freeze we are likely to
@@ -949,7 +949,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 	return 0;
 
 out_wait_freeze_timed_out:
-	nvme_stop_queues(&ctrl->ctrl);
+	nvme_quiesce_io_queues(&ctrl->ctrl);
 	nvme_sync_io_queues(&ctrl->ctrl);
 	nvme_rdma_stop_io_queues(ctrl);
 out_cleanup_tagset:
@@ -964,12 +964,12 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 static void nvme_rdma_teardown_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
-	nvme_stop_admin_queue(&ctrl->ctrl);
+	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	blk_sync_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	if (remove) {
-		nvme_start_admin_queue(&ctrl->ctrl);
+		nvme_unquiesce_admin_queue(&ctrl->ctrl);
 		nvme_remove_admin_tag_set(&ctrl->ctrl);
 	}
 	nvme_rdma_destroy_admin_queue(ctrl);
@@ -980,12 +980,12 @@ static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
 {
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_start_freeze(&ctrl->ctrl);
-		nvme_stop_queues(&ctrl->ctrl);
+		nvme_quiesce_io_queues(&ctrl->ctrl);
 		nvme_sync_io_queues(&ctrl->ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
 		nvme_cancel_tagset(&ctrl->ctrl);
 		if (remove) {
-			nvme_start_queues(&ctrl->ctrl);
+			nvme_unquiesce_io_queues(&ctrl->ctrl);
 			nvme_remove_io_tag_set(&ctrl->ctrl);
 		}
 		nvme_rdma_free_io_queues(ctrl);
@@ -1106,7 +1106,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 
 destroy_io:
 	if (ctrl->ctrl.queue_count > 1) {
-		nvme_stop_queues(&ctrl->ctrl);
+		nvme_quiesce_io_queues(&ctrl->ctrl);
 		nvme_sync_io_queues(&ctrl->ctrl);
 		nvme_rdma_stop_io_queues(ctrl);
 		nvme_cancel_tagset(&ctrl->ctrl);
@@ -1115,7 +1115,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 		nvme_rdma_free_io_queues(ctrl);
 	}
 destroy_admin:
-	nvme_stop_admin_queue(&ctrl->ctrl);
+	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	blk_sync_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
@@ -1156,9 +1156,9 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	nvme_stop_keep_alive(&ctrl->ctrl);
 	flush_work(&ctrl->ctrl.async_event_work);
 	nvme_rdma_teardown_io_queues(ctrl, false);
-	nvme_start_queues(&ctrl->ctrl);
+	nvme_unquiesce_io_queues(&ctrl->ctrl);
 	nvme_rdma_teardown_admin_queue(ctrl, false);
-	nvme_start_admin_queue(&ctrl->ctrl);
+	nvme_unquiesce_admin_queue(&ctrl->ctrl);
 	nvme_auth_stop(&ctrl->ctrl);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
@@ -2207,7 +2207,7 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
 	nvme_rdma_teardown_io_queues(ctrl, shutdown);
-	nvme_stop_admin_queue(&ctrl->ctrl);
+	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	if (shutdown)
 		nvme_shutdown_ctrl(&ctrl->ctrl);
 	else
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3fedddf0aedc1..776b8d9dfca79 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1875,7 +1875,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 		goto out_cleanup_connect_q;
 
 	if (!new) {
-		nvme_start_queues(ctrl);
+		nvme_unquiesce_io_queues(ctrl);
 		if (!nvme_wait_freeze_timeout(ctrl, NVME_IO_TIMEOUT)) {
 			/*
 			 * If we timed out waiting for freeze we are likely to
@@ -1902,7 +1902,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 	return 0;
 
 out_wait_freeze_timed_out:
-	nvme_stop_queues(ctrl);
+	nvme_quiesce_io_queues(ctrl);
 	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
 out_cleanup_connect_q:
@@ -1947,7 +1947,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	if (error)
 		goto out_stop_queue;
 
-	nvme_start_admin_queue(ctrl);
+	nvme_unquiesce_admin_queue(ctrl);
 
 	error = nvme_init_ctrl_finish(ctrl, false);
 	if (error)
@@ -1956,7 +1956,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	return 0;
 
 out_quiesce_queue:
-	nvme_stop_admin_queue(ctrl);
+	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
 out_stop_queue:
 	nvme_tcp_stop_queue(ctrl, 0);
@@ -1972,12 +1972,12 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 		bool remove)
 {
-	nvme_stop_admin_queue(ctrl);
+	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
 	nvme_cancel_admin_tagset(ctrl);
 	if (remove)
-		nvme_start_admin_queue(ctrl);
+		nvme_unquiesce_admin_queue(ctrl);
 	nvme_tcp_destroy_admin_queue(ctrl, remove);
 }
 
@@ -1986,14 +1986,14 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 {
 	if (ctrl->queue_count <= 1)
 		return;
-	nvme_stop_admin_queue(ctrl);
+	nvme_quiesce_admin_queue(ctrl);
 	nvme_start_freeze(ctrl);
-	nvme_stop_queues(ctrl);
+	nvme_quiesce_io_queues(ctrl);
 	nvme_sync_io_queues(ctrl);
 	nvme_tcp_stop_io_queues(ctrl);
 	nvme_cancel_tagset(ctrl);
 	if (remove)
-		nvme_start_queues(ctrl);
+		nvme_unquiesce_io_queues(ctrl);
 	nvme_tcp_destroy_io_queues(ctrl, remove);
 }
 
@@ -2074,14 +2074,14 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 
 destroy_io:
 	if (ctrl->queue_count > 1) {
-		nvme_stop_queues(ctrl);
+		nvme_quiesce_io_queues(ctrl);
 		nvme_sync_io_queues(ctrl);
 		nvme_tcp_stop_io_queues(ctrl);
 		nvme_cancel_tagset(ctrl);
 		nvme_tcp_destroy_io_queues(ctrl, new);
 	}
 destroy_admin:
-	nvme_stop_admin_queue(ctrl);
+	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
 	nvme_cancel_admin_tagset(ctrl);
@@ -2123,9 +2123,9 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	flush_work(&ctrl->async_event_work);
 	nvme_tcp_teardown_io_queues(ctrl, false);
 	/* unquiesce to fail fast pending requests */
-	nvme_start_queues(ctrl);
+	nvme_unquiesce_io_queues(ctrl);
 	nvme_tcp_teardown_admin_queue(ctrl, false);
-	nvme_start_admin_queue(ctrl);
+	nvme_unquiesce_admin_queue(ctrl);
 	nvme_auth_stop(ctrl);
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
@@ -2141,7 +2141,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
 	nvme_tcp_teardown_io_queues(ctrl, shutdown);
-	nvme_stop_admin_queue(ctrl);
+	nvme_quiesce_admin_queue(ctrl);
 	if (shutdown)
 		nvme_shutdown_ctrl(ctrl);
 	else
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 893c50f365c4d..4173099ef9a45 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -375,7 +375,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	ctrl->ctrl.max_hw_sectors =
 		(NVME_LOOP_MAX_SEGMENTS - 1) << (PAGE_SHIFT - 9);
 
-	nvme_start_admin_queue(&ctrl->ctrl);
+	nvme_unquiesce_admin_queue(&ctrl->ctrl);
 
 	error = nvme_init_ctrl_finish(&ctrl->ctrl, false);
 	if (error)
@@ -394,12 +394,12 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 {
 	if (ctrl->ctrl.queue_count > 1) {
-		nvme_stop_queues(&ctrl->ctrl);
+		nvme_quiesce_io_queues(&ctrl->ctrl);
 		nvme_cancel_tagset(&ctrl->ctrl);
 		nvme_loop_destroy_io_queues(ctrl);
 	}
 
-	nvme_stop_admin_queue(&ctrl->ctrl);
+	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
 		nvme_shutdown_ctrl(&ctrl->ctrl);
 
-- 
2.30.2


