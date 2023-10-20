Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C46ADC001DF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Oct 2023 14:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=THN6vBTlbjSR9BzWWN0AcWpLZs3DnEVCxUdAHnXDR2M=; b=IQwe23TvizR4V9+wpjeZE/4FOU
	OOH3nu6uU0VbiJUJ/sJZLIaM6piMc+wp5rPAQAl6jbIexmD/3rDbnIsBy1hXJ/r5ES0giRRhUTzPJ
	Du6zPws37CMhSJmcxAj+bXr3Fo9zASOH2cqBtFNC6efpgoW1UUhzBJ62wV5Zi2yhY4gTNj3gi5rZ6
	xMiauQMV0IZ9t7xihKQPqfOakA7XYyoQZ7ef1zTNpdIBN7Oxqoq5YUipgqSsj72ETQULomdD39GjZ
	6OwMQg2555TKKBRnDdlMuiNGC8juseA2q3S4oAfty1QdKKbE3hrzcKSsgLKHCYLND0Al4qgkvZ6jw
	YIavFsTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtqS6-002UPD-22;
	Fri, 20 Oct 2023 14:26:14 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtqRw-002UKj-1b
	for linux-nvme@lists.infradead.org;
	Fri, 20 Oct 2023 14:26:10 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 66C341F891;
	Fri, 20 Oct 2023 14:26:02 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 30CA72C8AB;
	Fri, 20 Oct 2023 14:26:02 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 5F20851EC195; Fri, 20 Oct 2023 16:26:02 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/4] nvme: start keep-alive after admin queue setup
Date: Fri, 20 Oct 2023 16:26:00 +0200
Message-Id: <20231020142600.47246-5-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231020142600.47246-1-hare@suse.de>
References: <20231020142600.47246-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [2.49 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(0.20)[suse.de];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(0.60)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[5];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 66C341F891
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_072604_864594_69E57FD6 
X-CRM114-Status: GOOD (  14.08  )
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

Setting up I/O queues might take quite some time on larger and/or
busy setups, so KATO might expire before all I/O queues could be
set up.
Fix this by moving starting and stopping keep-alive into the calls
to nvme_unquiesce_admin_queue() and nvme_quiesce_admin_queue().

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/apple.c  | 4 ++--
 drivers/nvme/host/core.c   | 7 ++++---
 drivers/nvme/host/fc.c     | 8 ++++----
 drivers/nvme/host/nvme.h   | 2 +-
 drivers/nvme/host/pci.c    | 8 ++++----
 drivers/nvme/host/rdma.c   | 6 +++---
 drivers/nvme/host/tcp.c    | 6 +++---
 drivers/nvme/target/loop.c | 2 +-
 8 files changed, 22 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 596bb11eeba5..91d3b1341723 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -869,7 +869,7 @@ static void apple_nvme_disable(struct apple_nvme *anv, bool shutdown)
 	 */
 	if (shutdown) {
 		nvme_unquiesce_io_queues(&anv->ctrl);
-		nvme_unquiesce_admin_queue(&anv->ctrl);
+		nvme_unquiesce_admin_queue(&anv->ctrl, false);
 	}
 }
 
@@ -1107,7 +1107,7 @@ static void apple_nvme_reset_work(struct work_struct *work)
 
 	dev_dbg(anv->dev, "Starting admin queue");
 	apple_nvme_init_queue(&anv->adminq);
-	nvme_unquiesce_admin_queue(&anv->ctrl);
+	nvme_unquiesce_admin_queue(&anv->ctrl, true);
 
 	if (!nvme_change_ctrl_state(&anv->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_warn(anv->ctrl.device,
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 62612f87aafa..070912e1601a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4344,8 +4344,6 @@ EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
 
 void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 {
-	nvme_start_keep_alive(ctrl);
-
 	nvme_enable_aen(ctrl);
 
 	/*
@@ -4602,6 +4600,7 @@ EXPORT_SYMBOL_GPL(nvme_unquiesce_io_queues);
 
 void nvme_quiesce_admin_queue(struct nvme_ctrl *ctrl)
 {
+	nvme_stop_keep_alive(ctrl);
 	if (!test_and_set_bit(NVME_CTRL_ADMIN_Q_STOPPED, &ctrl->flags))
 		blk_mq_quiesce_queue(ctrl->admin_q);
 	else
@@ -4609,10 +4608,12 @@ void nvme_quiesce_admin_queue(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_quiesce_admin_queue);
 
-void nvme_unquiesce_admin_queue(struct nvme_ctrl *ctrl)
+void nvme_unquiesce_admin_queue(struct nvme_ctrl *ctrl, bool start_ka)
 {
 	if (test_and_clear_bit(NVME_CTRL_ADMIN_Q_STOPPED, &ctrl->flags))
 		blk_mq_unquiesce_queue(ctrl->admin_q);
+	if (start_ka)
+		nvme_start_keep_alive(ctrl);
 }
 EXPORT_SYMBOL_GPL(nvme_unquiesce_admin_queue);
 
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 17b6c9238d68..3ac749bf34de 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2404,7 +2404,7 @@ nvme_fc_ctrl_free(struct kref *ref)
 	list_del(&ctrl->ctrl_list);
 	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
 
-	nvme_unquiesce_admin_queue(&ctrl->ctrl);
+	nvme_unquiesce_admin_queue(&ctrl->ctrl, false);
 	nvme_remove_admin_tag_set(&ctrl->ctrl);
 
 	kfree(ctrl->queues);
@@ -2535,7 +2535,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
 	blk_mq_tagset_wait_completed_request(&ctrl->admin_tag_set);
 	if (start_queues)
-		nvme_unquiesce_admin_queue(&ctrl->ctrl);
+		nvme_unquiesce_admin_queue(&ctrl->ctrl, true);
 }
 
 static void
@@ -3129,7 +3129,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	ctrl->ctrl.max_hw_sectors = ctrl->ctrl.max_segments <<
 						(ilog2(SZ_4K) - 9);
 
-	nvme_unquiesce_admin_queue(&ctrl->ctrl);
+	nvme_unquiesce_admin_queue(&ctrl->ctrl, true);
 
 	ret = nvme_init_ctrl_finish(&ctrl->ctrl, false);
 	if (!ret && test_bit(ASSOC_FAILED, &ctrl->flags))
@@ -3288,7 +3288,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	nvme_fc_free_queue(&ctrl->queues[0]);
 
 	/* re-enable the admin_q so anything new can fast fail */
-	nvme_unquiesce_admin_queue(&ctrl->ctrl);
+	nvme_unquiesce_admin_queue(&ctrl->ctrl, false);
 
 	/* resume the io queues so that things will fast fail */
 	nvme_unquiesce_io_queues(&ctrl->ctrl);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 39a90b7cb125..1aba30600b4a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -770,7 +770,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 void nvme_quiesce_io_queues(struct nvme_ctrl *ctrl);
 void nvme_unquiesce_io_queues(struct nvme_ctrl *ctrl);
 void nvme_quiesce_admin_queue(struct nvme_ctrl *ctrl);
-void nvme_unquiesce_admin_queue(struct nvme_ctrl *ctrl);
+void nvme_unquiesce_admin_queue(struct nvme_ctrl *ctrl, bool start_ka);
 void nvme_mark_namespaces_dead(struct nvme_ctrl *ctrl);
 void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_sync_io_queues(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5b6dec052dfe..b9a6abe3fd33 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1681,7 +1681,7 @@ static void nvme_dev_remove_admin(struct nvme_dev *dev)
 		 * user requests may be waiting on a stopped queue. Start the
 		 * queue to flush these to completion.
 		 */
-		nvme_unquiesce_admin_queue(&dev->ctrl);
+		nvme_unquiesce_admin_queue(&dev->ctrl, false);
 		nvme_remove_admin_tag_set(&dev->ctrl);
 	}
 }
@@ -2615,7 +2615,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	if (shutdown) {
 		nvme_unquiesce_io_queues(&dev->ctrl);
 		if (dev->ctrl.admin_q && !blk_queue_dying(dev->ctrl.admin_q))
-			nvme_unquiesce_admin_queue(&dev->ctrl);
+			nvme_unquiesce_admin_queue(&dev->ctrl, false);
 	}
 	mutex_unlock(&dev->shutdown_lock);
 }
@@ -2722,7 +2722,7 @@ static void nvme_reset_work(struct work_struct *work)
 		goto out;
 	}
 
-	nvme_unquiesce_admin_queue(&dev->ctrl);
+	nvme_unquiesce_admin_queue(&dev->ctrl, true);
 
 	result = nvme_init_ctrl_finish(&dev->ctrl, was_suspend);
 	if (result)
@@ -3020,7 +3020,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto out_disable;
 	}
 
-	nvme_unquiesce_admin_queue(&dev->ctrl);
+	nvme_unquiesce_admin_queue(&ctrl->ctrl, true);
 
 	result = nvme_init_ctrl_finish(&dev->ctrl, false);
 	if (result)
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 337a624a537c..a9368767560f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -830,7 +830,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	else
 		ctrl->ctrl.max_integrity_segments = 0;
 
-	nvme_unquiesce_admin_queue(&ctrl->ctrl);
+	nvme_unquiesce_admin_queue(&ctrl->ctrl, true);
 
 	error = nvme_init_ctrl_finish(&ctrl->ctrl, false);
 	if (error)
@@ -932,7 +932,7 @@ static void nvme_rdma_teardown_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	if (remove) {
-		nvme_unquiesce_admin_queue(&ctrl->ctrl);
+		nvme_unquiesce_admin_queue(&ctrl->ctrl, false);
 		nvme_remove_admin_tag_set(&ctrl->ctrl);
 	}
 	nvme_rdma_destroy_admin_queue(ctrl);
@@ -1120,7 +1120,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	nvme_rdma_teardown_io_queues(ctrl, false);
 	nvme_unquiesce_io_queues(&ctrl->ctrl);
 	nvme_rdma_teardown_admin_queue(ctrl, false);
-	nvme_unquiesce_admin_queue(&ctrl->ctrl);
+	nvme_unquiesce_admin_queue(&ctrl->ctrl, false);
 	nvme_auth_stop(&ctrl->ctrl);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4714a902f4ca..a3c3ef843dca 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2103,7 +2103,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	if (error)
 		goto out_stop_queue;
 
-	nvme_unquiesce_admin_queue(ctrl);
+	nvme_unquiesce_admin_queue(ctrl, true);
 
 	error = nvme_init_ctrl_finish(ctrl, false);
 	if (error)
@@ -2133,7 +2133,7 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 	nvme_tcp_stop_queue(ctrl, 0);
 	nvme_cancel_admin_tagset(ctrl);
 	if (remove)
-		nvme_unquiesce_admin_queue(ctrl);
+		nvme_unquiesce_admin_queue(ctrl, false);
 	nvme_tcp_destroy_admin_queue(ctrl, remove);
 }
 
@@ -2280,7 +2280,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	/* unquiesce to fail fast pending requests */
 	nvme_unquiesce_io_queues(ctrl);
 	nvme_tcp_teardown_admin_queue(ctrl, false);
-	nvme_unquiesce_admin_queue(ctrl);
+	nvme_unquiesce_admin_queue(ctrl, false);
 	nvme_auth_stop(ctrl);
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index e1b8ead94575..6237f6baba4f 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -375,7 +375,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	ctrl->ctrl.max_hw_sectors =
 		(NVME_LOOP_MAX_SEGMENTS - 1) << PAGE_SECTORS_SHIFT;
 
-	nvme_unquiesce_admin_queue(&ctrl->ctrl);
+	nvme_unquiesce_admin_queue(&ctrl->ctrl, true);
 
 	error = nvme_init_ctrl_finish(&ctrl->ctrl, false);
 	if (error)
-- 
2.35.3


