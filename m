Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B6B1C61DA4
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Mar 2023 09:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ocZ9K4SEqaRqBtnUjq/j+Sfm0upl2N58Lx8O/K4YAkc=; b=a3GkCzJ5RzwAl+Qk5KpSX2PeJh
	7S88GXUVSiTe68WUQ3VhaWykJdnhXh1aFjM0vg0KYzlzrJCnWfABQ1MriAmqjcx1rqJOCzs5P3y+z
	JFbDaaJaTVwC1BZxOcoL2p5g6eBxUxS6s8p/zctkn4f+wIFUfQpIViVQW7qR/A7mgXuG46jX1XRtH
	5b4wICcefW+ek1OywmSIipS65mD5ILS7R0dBo2FELG8rgBhhul4ALWfg46bmY8ekJv8J80w75wYmp
	C3eT16T4dgO2ip9pdbCYN4nX7MFfQrxdlR0cVHgT7llCWrOmqKkoUWkA0NxoYl17naLDO3yE1JIhR
	BGukKwuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ7Dh-00C6EK-40; Mon, 06 Mar 2023 09:33:25 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZ7DA-00C63g-0W
	for linux-nvme@lists.infradead.org; Mon, 06 Mar 2023 09:32:56 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C87E71FDE5;
	Mon,  6 Mar 2023 09:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1678095170; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ocZ9K4SEqaRqBtnUjq/j+Sfm0upl2N58Lx8O/K4YAkc=;
	b=QgleiBFKEt54vlnmzkzthPmBgfEdvoqWlhJWcmcq0l8GW735QdeyrdXzavY69uQB8UbgrE
	ocWmxNiIJZLF+9fo07NT00yQ6q/gsosnAk7TY59uznQ6Navhh2iwHjAC3SwuAvmFybais5
	2KThOfcad4YL4S5CmsfC8esW1Chz05o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1678095170;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ocZ9K4SEqaRqBtnUjq/j+Sfm0upl2N58Lx8O/K4YAkc=;
	b=HNeTKbwMK+rew2hs2jLn7sIdk7rLcEvhGj+lHzJ2H2WMmKDYfjQwD+wp7C+KgWA07w6Uvx
	sRXY43JXHlGlNiBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA69E13513;
	Mon,  6 Mar 2023 09:32:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id kyWALUKzBWSAYAAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 06 Mar 2023 09:32:50 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Daniel Wagner <dwagner@suse.de>
Subject: [RFC v2 6/6] nvme-rdma: use ctrl state machine from frabrics
Date: Mon,  6 Mar 2023 10:32:44 +0100
Message-Id: <20230306093244.20775-7-dwagner@suse.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306093244.20775-1-dwagner@suse.de>
References: <20230306093244.20775-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230306_013252_382547_CD2C0822 
X-CRM114-Status: GOOD (  20.34  )
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

Use common state machine code from fabrics.c.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/rdma.c | 428 ++++-----------------------------------
 1 file changed, 39 insertions(+), 389 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 902506a5a255..18c176581e6e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -665,6 +665,13 @@ static void nvme_rdma_free_queue(struct nvme_ctrl *nctrl, int qid)
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 	struct nvme_rdma_queue *queue = &ctrl->queues[qid];
 
+	if (qid == 0 &&ctrl->async_event_sqe.data) {
+		cancel_work_sync(&ctrl->ctrl.async_event_work);
+		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
+				sizeof(struct nvme_command), DMA_TO_DEVICE);
+		ctrl->async_event_sqe.data = NULL;
+	}
+
 	if (!test_and_clear_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
 		return;
 
@@ -673,22 +680,6 @@ static void nvme_rdma_free_queue(struct nvme_ctrl *nctrl, int qid)
 	mutex_destroy(&queue->queue_lock);
 }
 
-static void nvme_rdma_free_io_queues(struct nvme_rdma_ctrl *ctrl)
-{
-	int i;
-
-	for (i = 1; i < ctrl->ctrl.queue_count; i++)
-		nvme_rdma_free_queue(&ctrl->ctrl, i);
-}
-
-static void nvme_rdma_stop_io_queues(struct nvme_rdma_ctrl *ctrl)
-{
-	int i;
-
-	for (i = 1; i < ctrl->ctrl.queue_count; i++)
-		nvme_rdma_stop_queue(&ctrl->ctrl, i);
-}
-
 static int nvme_rdma_start_queue(struct nvme_ctrl *nctrl, int idx)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
@@ -711,53 +702,35 @@ static int nvme_rdma_start_queue(struct nvme_ctrl *nctrl, int idx)
 	return ret;
 }
 
-static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl,
-				     int first, int last)
+static unsigned int nvme_rdma_nr_io_queues(struct nvme_ctrl *ctrl)
 {
-	int i, ret = 0;
+	struct ib_device *ibdev = to_rdma_ctrl(ctrl)->device->dev;
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+	unsigned int nr_io_queues;
 
-	for (i = first; i < last; i++) {
-		ret = nvme_rdma_start_queue(&ctrl->ctrl, i);
-		if (ret)
-			goto out_stop_queues;
-	}
+	nr_io_queues = min_t(unsigned int, ibdev->num_comp_vectors,
+			     min(opts->nr_io_queues, num_online_cpus()));
+	nr_io_queues += min_t(unsigned int, ibdev->num_comp_vectors,
+			      min(opts->nr_write_queues, num_online_cpus()));
+	nr_io_queues += min(opts->nr_poll_queues, num_online_cpus());
 
-	return 0;
-
-out_stop_queues:
-	for (i--; i >= first; i--)
-		nvme_rdma_stop_queue(&ctrl->ctrl, i);
-	return ret;
+	return nr_io_queues;
 }
 
-static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
+static void nvme_rdma_set_io_queues(struct nvme_ctrl *nctrl,
+		unsigned int nr_io_queues)
 {
-	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 	struct ib_device *ibdev = ctrl->device->dev;
-	unsigned int nr_io_queues, nr_default_queues;
+	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
+	unsigned int nr_default_queues;
 	unsigned int nr_read_queues, nr_poll_queues;
-	int i, ret;
 
 	nr_read_queues = min_t(unsigned int, ibdev->num_comp_vectors,
 				min(opts->nr_io_queues, num_online_cpus()));
 	nr_default_queues =  min_t(unsigned int, ibdev->num_comp_vectors,
 				min(opts->nr_write_queues, num_online_cpus()));
 	nr_poll_queues = min(opts->nr_poll_queues, num_online_cpus());
-	nr_io_queues = nr_read_queues + nr_default_queues + nr_poll_queues;
-
-	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
-	if (ret)
-		return ret;
-
-	if (nr_io_queues == 0) {
-		dev_err(ctrl->ctrl.device,
-			"unable to set any I/O queues\n");
-		return -ENOMEM;
-	}
-
-	ctrl->ctrl.queue_count = nr_io_queues + 1;
-	dev_info(ctrl->ctrl.device,
-		"creating %d I/O queues.\n", nr_io_queues);
 
 	if (opts->nr_write_queues && nr_read_queues < nr_io_queues) {
 		/*
@@ -786,20 +759,6 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 		ctrl->io_queues[HCTX_TYPE_POLL] =
 			min(nr_poll_queues, nr_io_queues);
 	}
-
-	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
-		ret = nvme_rdma_alloc_queue(&ctrl->ctrl, i);
-		if (ret)
-			goto out_free_queues;
-	}
-
-	return 0;
-
-out_free_queues:
-	for (i--; i >= 1; i--)
-		nvme_rdma_free_queue(&ctrl->ctrl, i);
-
-	return ret;
 }
 
 static int nvme_rdma_alloc_tag_set(struct nvme_ctrl *ctrl)
@@ -817,17 +776,6 @@ static int nvme_rdma_alloc_tag_set(struct nvme_ctrl *ctrl)
 			cmd_size);
 }
 
-static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl)
-{
-	if (ctrl->async_event_sqe.data) {
-		cancel_work_sync(&ctrl->ctrl.async_event_work);
-		nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
-				sizeof(struct nvme_command), DMA_TO_DEVICE);
-		ctrl->async_event_sqe.data = NULL;
-	}
-	nvme_rdma_free_queue(&ctrl->ctrl, 0);
-}
-
 static int nvme_rdma_init_queue(struct nvme_ctrl *nctrl, int qid)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
@@ -884,109 +832,6 @@ static void nvme_rdma_deinit_queue(struct nvme_ctrl *nctrl, int qid)
 	}
 }
 
-static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
-{
-	int ret, nr_queues;
-
-	ret = nvme_rdma_alloc_io_queues(ctrl);
-	if (ret)
-		return ret;
-
-	if (new) {
-		ret = nvme_rdma_alloc_tag_set(&ctrl->ctrl);
-		if (ret)
-			goto out_free_io_queues;
-	}
-
-	/*
-	 * Only start IO queues for which we have allocated the tagset
-	 * and limitted it to the available queues. On reconnects, the
-	 * queue number might have changed.
-	 */
-	nr_queues = min(ctrl->tag_set.nr_hw_queues + 1, ctrl->ctrl.queue_count);
-	ret = nvme_rdma_start_io_queues(ctrl, 1, nr_queues);
-	if (ret)
-		goto out_cleanup_tagset;
-
-	if (!new) {
-		nvme_unquiesce_io_queues(&ctrl->ctrl);
-		if (!nvme_wait_freeze_timeout(&ctrl->ctrl, NVME_IO_TIMEOUT)) {
-			/*
-			 * If we timed out waiting for freeze we are likely to
-			 * be stuck.  Fail the controller initialization just
-			 * to be safe.
-			 */
-			ret = -ENODEV;
-			goto out_wait_freeze_timed_out;
-		}
-		blk_mq_update_nr_hw_queues(ctrl->ctrl.tagset,
-			ctrl->ctrl.queue_count - 1);
-		nvme_unfreeze(&ctrl->ctrl);
-	}
-
-	/*
-	 * If the number of queues has increased (reconnect case)
-	 * start all new queues now.
-	 */
-	ret = nvme_rdma_start_io_queues(ctrl, nr_queues,
-					ctrl->tag_set.nr_hw_queues + 1);
-	if (ret)
-		goto out_wait_freeze_timed_out;
-
-	return 0;
-
-out_wait_freeze_timed_out:
-	nvme_quiesce_io_queues(&ctrl->ctrl);
-	nvme_sync_io_queues(&ctrl->ctrl);
-	nvme_rdma_stop_io_queues(ctrl);
-out_cleanup_tagset:
-	nvme_cancel_tagset(&ctrl->ctrl);
-	if (new)
-		nvme_remove_io_tag_set(&ctrl->ctrl);
-out_free_io_queues:
-	nvme_rdma_free_io_queues(ctrl);
-	return ret;
-}
-
-static void nvme_rdma_teardown_admin_queue(struct nvme_rdma_ctrl *ctrl,
-		bool remove)
-{
-	nvme_quiesce_admin_queue(&ctrl->ctrl);
-	blk_sync_queue(ctrl->ctrl.admin_q);
-	nvme_rdma_stop_queue(&ctrl->ctrl, 0);
-	nvme_cancel_admin_tagset(&ctrl->ctrl);
-	if (remove) {
-		nvme_unquiesce_admin_queue(&ctrl->ctrl);
-		nvme_remove_admin_tag_set(&ctrl->ctrl);
-	}
-	nvme_rdma_destroy_admin_queue(ctrl);
-}
-
-static void nvme_rdma_teardown_io_queues(struct nvme_rdma_ctrl *ctrl,
-		bool remove)
-{
-	if (ctrl->ctrl.queue_count > 1) {
-		nvme_start_freeze(&ctrl->ctrl);
-		nvme_quiesce_io_queues(&ctrl->ctrl);
-		nvme_sync_io_queues(&ctrl->ctrl);
-		nvme_rdma_stop_io_queues(ctrl);
-		nvme_cancel_tagset(&ctrl->ctrl);
-		if (remove) {
-			nvme_unquiesce_io_queues(&ctrl->ctrl);
-			nvme_remove_io_tag_set(&ctrl->ctrl);
-		}
-		nvme_rdma_free_io_queues(ctrl);
-	}
-}
-
-static void nvme_rdma_stop_ctrl(struct nvme_ctrl *nctrl)
-{
-	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
-
-	flush_work(&ctrl->ctrl.err_work);
-	cancel_delayed_work_sync(&ctrl->ctrl.connect_work);
-}
-
 static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
@@ -1004,25 +849,6 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 	kfree(ctrl);
 }
 
-static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
-{
-	/* If we are resetting/deleting then do nothing */
-	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING) {
-		WARN_ON_ONCE(ctrl->ctrl.state == NVME_CTRL_NEW ||
-			ctrl->ctrl.state == NVME_CTRL_LIVE);
-		return;
-	}
-
-	if (nvmf_should_reconnect(&ctrl->ctrl)) {
-		dev_info(ctrl->ctrl.device, "Reconnecting in %d seconds...\n",
-			ctrl->ctrl.opts->reconnect_delay);
-		queue_delayed_work(nvme_wq, &ctrl->ctrl.connect_work,
-				ctrl->ctrl.opts->reconnect_delay * HZ);
-	} else {
-		nvme_delete_ctrl(&ctrl->ctrl);
-	}
-}
-
 static int nvme_rdma_alloc_admin_tag_set(struct nvme_ctrl *ctrl)
 {
 
@@ -1032,152 +858,6 @@ static int nvme_rdma_alloc_admin_tag_set(struct nvme_ctrl *ctrl)
 					   NVME_RDMA_DATA_SGL_SIZE);
 }
 
-static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
-{
-	int ret;
-	bool changed;
-
-	ret = nvmf_configure_admin_queue(&ctrl->ctrl, new);
-	if (ret)
-		return ret;
-
-	if (ctrl->ctrl.icdoff) {
-		ret = -EOPNOTSUPP;
-		dev_err(ctrl->ctrl.device, "icdoff is not supported!\n");
-		goto destroy_admin;
-	}
-
-	if (!(ctrl->ctrl.sgls & (1 << 2))) {
-		ret = -EOPNOTSUPP;
-		dev_err(ctrl->ctrl.device,
-			"Mandatory keyed sgls are not supported!\n");
-		goto destroy_admin;
-	}
-
-	if (ctrl->ctrl.opts->queue_size > ctrl->ctrl.sqsize + 1) {
-		dev_warn(ctrl->ctrl.device,
-			"queue_size %zu > ctrl sqsize %u, clamping down\n",
-			ctrl->ctrl.opts->queue_size, ctrl->ctrl.sqsize + 1);
-	}
-
-	if (ctrl->ctrl.sqsize + 1 > NVME_RDMA_MAX_QUEUE_SIZE) {
-		dev_warn(ctrl->ctrl.device,
-			"ctrl sqsize %u > max queue size %u, clamping down\n",
-			ctrl->ctrl.sqsize + 1, NVME_RDMA_MAX_QUEUE_SIZE);
-		ctrl->ctrl.sqsize = NVME_RDMA_MAX_QUEUE_SIZE - 1;
-	}
-
-	if (ctrl->ctrl.sqsize + 1 > ctrl->ctrl.maxcmd) {
-		dev_warn(ctrl->ctrl.device,
-			"sqsize %u > ctrl maxcmd %u, clamping down\n",
-			ctrl->ctrl.sqsize + 1, ctrl->ctrl.maxcmd);
-		ctrl->ctrl.sqsize = ctrl->ctrl.maxcmd - 1;
-	}
-
-	if (ctrl->ctrl.sgls & (1 << 20))
-		ctrl->use_inline_data = true;
-
-	if (ctrl->ctrl.queue_count > 1) {
-		ret = nvme_rdma_configure_io_queues(ctrl, new);
-		if (ret)
-			goto destroy_admin;
-	}
-
-	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
-	if (!changed) {
-		/*
-		 * state change failure is ok if we started ctrl delete,
-		 * unless we're during creation of a new controller to
-		 * avoid races with teardown flow.
-		 */
-		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING &&
-			     ctrl->ctrl.state != NVME_CTRL_DELETING_NOIO);
-		WARN_ON_ONCE(new);
-		ret = -EINVAL;
-		goto destroy_io;
-	}
-
-	nvme_start_ctrl(&ctrl->ctrl);
-	return 0;
-
-destroy_io:
-	if (ctrl->ctrl.queue_count > 1) {
-		nvme_quiesce_io_queues(&ctrl->ctrl);
-		nvme_sync_io_queues(&ctrl->ctrl);
-		nvme_rdma_stop_io_queues(ctrl);
-		nvme_cancel_tagset(&ctrl->ctrl);
-		if (new)
-			nvme_remove_io_tag_set(&ctrl->ctrl);
-		nvme_rdma_free_io_queues(ctrl);
-	}
-destroy_admin:
-	nvme_quiesce_admin_queue(&ctrl->ctrl);
-	blk_sync_queue(ctrl->ctrl.admin_q);
-	nvme_rdma_stop_queue(&ctrl->ctrl, 0);
-	nvme_cancel_admin_tagset(&ctrl->ctrl);
-	if (new)
-		nvme_remove_admin_tag_set(&ctrl->ctrl);
-	nvme_rdma_destroy_admin_queue(ctrl);
-	return ret;
-}
-
-static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
-{
-	struct nvme_ctrl *nctrl = container_of(to_delayed_work(work),
-			struct nvme_ctrl, connect_work);
-	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
-
-	++ctrl->ctrl.nr_reconnects;
-
-	if (nvme_rdma_setup_ctrl(ctrl, false))
-		goto requeue;
-
-	dev_info(ctrl->ctrl.device, "Successfully reconnected (%d attempts)\n",
-			ctrl->ctrl.nr_reconnects);
-
-	ctrl->ctrl.nr_reconnects = 0;
-
-	return;
-
-requeue:
-	dev_info(ctrl->ctrl.device, "Failed reconnect attempt %d\n",
-			ctrl->ctrl.nr_reconnects);
-	nvme_rdma_reconnect_or_remove(ctrl);
-}
-
-static void nvme_rdma_error_recovery_work(struct work_struct *work)
-{
-	struct nvme_ctrl *nctrl = container_of(work,
-			struct nvme_ctrl, err_work);
-	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
-
-	nvme_stop_keep_alive(&ctrl->ctrl);
-	flush_work(&ctrl->ctrl.async_event_work);
-	nvme_rdma_teardown_io_queues(ctrl, false);
-	nvme_unquiesce_io_queues(&ctrl->ctrl);
-	nvme_rdma_teardown_admin_queue(ctrl, false);
-	nvme_unquiesce_admin_queue(&ctrl->ctrl);
-	nvme_auth_stop(&ctrl->ctrl);
-
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
-		/* state change failure is ok if we started ctrl delete */
-		WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING &&
-			     ctrl->ctrl.state != NVME_CTRL_DELETING_NOIO);
-		return;
-	}
-
-	nvme_rdma_reconnect_or_remove(ctrl);
-}
-
-static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
-{
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
-		return;
-
-	dev_warn(ctrl->ctrl.device, "starting error recovery\n");
-	queue_work(nvme_reset_wq, &ctrl->ctrl.err_work);
-}
-
 static void nvme_rdma_end_request(struct nvme_rdma_request *req)
 {
 	struct request *rq = blk_mq_rq_from_pdu(req);
@@ -1199,7 +879,7 @@ static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
 			     "%s for CQE 0x%p failed with status %s (%d)\n",
 			     op, wc->wr_cqe,
 			     ib_wc_status_msg(wc->status), wc->status);
-	nvme_rdma_error_recovery(ctrl);
+	nvmf_error_recovery(&ctrl->ctrl);
 }
 
 static void nvme_rdma_memreg_done(struct ib_cq *cq, struct ib_wc *wc)
@@ -1718,7 +1398,7 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 		dev_err(queue->ctrl->ctrl.device,
 			"got bad command_id %#x on QP %#x\n",
 			cqe->command_id, queue->qp->qp_num);
-		nvme_rdma_error_recovery(queue->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		return;
 	}
 	req = blk_mq_rq_to_pdu(rq);
@@ -1732,7 +1412,7 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 			dev_err(queue->ctrl->ctrl.device,
 				"Bogus remote invalidation for rkey %#x\n",
 				req->mr ? req->mr->rkey : 0);
-			nvme_rdma_error_recovery(queue->ctrl);
+			nvmf_error_recovery(&queue->ctrl->ctrl);
 		}
 	} else if (req->mr) {
 		int ret;
@@ -1742,7 +1422,7 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 			dev_err(queue->ctrl->ctrl.device,
 				"Queueing INV WR for rkey %#x failed (%d)\n",
 				req->mr->rkey, ret);
-			nvme_rdma_error_recovery(queue->ctrl);
+			nvmf_error_recovery(&queue->ctrl->ctrl);
 		}
 		/* the local invalidation completion will end the request */
 		return;
@@ -1769,7 +1449,7 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	if (unlikely(wc->byte_len < len)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"Unexpected nvme completion length(%d)\n", wc->byte_len);
-		nvme_rdma_error_recovery(queue->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		return;
 	}
 
@@ -1939,7 +1619,7 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
 		dev_dbg(queue->ctrl->ctrl.device,
 			"disconnect received - connection closed\n");
-		nvme_rdma_error_recovery(queue->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		break;
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		/* device removal is handled via the ib_client API */
@@ -1947,7 +1627,7 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 	default:
 		dev_err(queue->ctrl->ctrl.device,
 			"Unexpected RDMA CM event (%d)\n", ev->event);
-		nvme_rdma_error_recovery(queue->ctrl);
+		nvmf_error_recovery(&queue->ctrl->ctrl);
 		break;
 	}
 
@@ -2000,7 +1680,7 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
 	 * LIVE state should trigger the normal error recovery which will
 	 * handle completing this request.
 	 */
-	nvme_rdma_error_recovery(ctrl);
+	nvmf_error_recovery(&ctrl->ctrl);
 	return BLK_EH_RESET_TIMER;
 }
 
@@ -2203,41 +1883,9 @@ static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
 	.timeout	= nvme_rdma_timeout,
 };
 
-static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
-{
-	nvme_rdma_teardown_io_queues(ctrl, shutdown);
-	nvme_quiesce_admin_queue(&ctrl->ctrl);
-	nvme_disable_ctrl(&ctrl->ctrl, shutdown);
-	nvme_rdma_teardown_admin_queue(ctrl, shutdown);
-}
-
 static void nvme_rdma_delete_ctrl(struct nvme_ctrl *ctrl)
 {
-	nvme_rdma_shutdown_ctrl(to_rdma_ctrl(ctrl), true);
-}
-
-static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
-{
-	struct nvme_rdma_ctrl *ctrl =
-		container_of(work, struct nvme_rdma_ctrl, ctrl.reset_work);
-
-	nvme_stop_ctrl(&ctrl->ctrl);
-	nvme_rdma_shutdown_ctrl(ctrl, false);
-
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
-		/* state change failure should never happen */
-		WARN_ON_ONCE(1);
-		return;
-	}
-
-	if (nvme_rdma_setup_ctrl(ctrl, false))
-		goto out_fail;
-
-	return;
-
-out_fail:
-	++ctrl->ctrl.nr_reconnects;
-	nvme_rdma_reconnect_or_remove(ctrl);
+	nvmf_teardown_ctrl(ctrl, true);
 }
 
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
@@ -2251,7 +1899,7 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.submit_async_event	= nvme_rdma_submit_async_event,
 	.delete_ctrl		= nvme_rdma_delete_ctrl,
 	.get_address		= nvmf_get_address,
-	.stop_ctrl		= nvme_rdma_stop_ctrl,
+	.stop_ctrl		= nvmf_stop_ctrl,
 };
 
 /*
@@ -2291,6 +1939,9 @@ static struct nvme_fabrics_ops nvme_rdma_fabrics_ops = {
 	.start_queue		= nvme_rdma_start_queue,
 	.stop_queue		= nvme_rdma_stop_queue,
 	.alloc_admin_tag_set	= nvme_rdma_alloc_admin_tag_set,
+	.alloc_tag_set		= nvme_rdma_alloc_tag_set,
+	.nr_io_queues		= nvme_rdma_nr_io_queues,
+	.set_io_queues		= nvme_rdma_set_io_queues,
 };
 
 static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
@@ -2341,10 +1992,9 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	}
 
 	INIT_DELAYED_WORK(&ctrl->ctrl.connect_work,
-			nvme_rdma_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->ctrl.err_work, nvme_rdma_error_recovery_work);
-	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
-
+			nvmf_reconnect_ctrl_work);
+	INIT_WORK(&ctrl->ctrl.err_work, nvmf_error_recovery_work);
+	INIT_WORK(&ctrl->ctrl.reset_work, nvmf_reset_ctrl_work);
 	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
 				opts->nr_poll_queues + 1;
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
@@ -2364,7 +2014,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING);
 	WARN_ON_ONCE(!changed);
 
-	ret = nvme_rdma_setup_ctrl(ctrl, true);
+	ret = nvmf_setup_ctrl(&ctrl->ctrl, true);
 	if (ret)
 		goto out_uninit_ctrl;
 
-- 
2.39.2


