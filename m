Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D043FFCE081
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 13:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ScEf/UjzJu4SVAF1Ly8BRZm4tWFDWyrZM6SsTsPF4Nc=; b=wm69Z1xBVv7dKEgOaZvWCB834x
	eqXiYDiFWSnkww4TaUfSTlSwCemUJRm6NPgi9D7fQCecMr+OVlLnv1v4pEg8Wz6IBqIQh0L0zEytN
	1m0QPaZG9ybVckNjpqeTLhJOC5r5zcpJdmSB10LqGolphpV/AI9Ob2H/D44EB+puu3+aYVr2SBToS
	MmZO4Qi1tpf6F/vV+3NPWREwCciLWmBJPrq8ecSM4hxQllMNzYHWdYGhq1ND9NbWF6QOjeiUAkdiE
	TyxxGfRJXnS9YVd8MVv+5JJtyAc2FDAdqDXgZAQ/xmDfQKjB0VE+PPVKsTWk5uvxOkIryir3RUeCq
	aJ9H2cRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvbby-00000006Emi-3jym;
	Thu, 26 Feb 2026 13:41:02 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvbbx-00000006ElU-3hZA
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 13:41:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id E84CD60122;
	Thu, 26 Feb 2026 13:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFB8C19422;
	Thu, 26 Feb 2026 13:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113260;
	bh=uEwx2TPo5bfwJfl0eBFkq0lqqN7InLdCO/Qn2mw7YgI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AQ8BujHVTKAinfaFgOcgtKPuftXbumYS0fdhV1gpVwRr+jjblOn7IAu2xNO09I03r
	 YhjU45iMhqyEpQkeDLU+zKgSrw9hd8FTPt9qzZnUgV3akMPwMRl4+jwGWyVFaxgN3Y
	 rpBFELtzgXBK6UHYaJTtSGBiAkJ3Y5zoDnyOr00hmMx+MpVRpYLd8vzYqbkSJCsBFY
	 eObkNluFAkD0k9SiMInSynrHmn8UYAa9qG06qEIyY2OomkgZ9RIrD3+PeuMAEEkInE
	 a2zSQdR/X4diIf1kjseHcOh283KzewT5qw2LLMOgeLvfHI4LDPMI81gveF5aLMYnnc
	 MSbWfgdW9Fxbw==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 26 Feb 2026 14:40:36 +0100
Subject: [PATCH 2/3] blk-mq: add handshake for offlinig hw queues
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-revert-cpu-read-lock-v1-2-eb005072566e@kernel.org>
References: <20260226-revert-cpu-read-lock-v1-0-eb005072566e@kernel.org>
In-Reply-To: <20260226-revert-cpu-read-lock-v1-0-eb005072566e@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc: Guangwu Zhang <guazhang@redhat.com>, 
 Chengming Zhou <zhouchengming@bytedance.com>, 
 Thomas Gleixner <tglx@kernel.org>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3
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

The CPU hotplug offline handler in the block layer checks for any
in-flight requests on a CPU going offline. It prevents the CPU hotplug
state engine from progressing as long as there are pending requests.

This is done by checking for any allocated requests on the hardware
context that is going offline. The driver is responsible for completing
all in-flight requests.

However, the driver might be performing error recovery simultaneously.
Therefore, the request queue might be in a frozen or quiesced state. In
this case, requests may not make progress (see
blk_mq_sched_dispatch_requests for an example).

Introduce an explicit handshake protocol between the driver and the
block layer. This allows the driver to signal when it is safe to ignore
any remaining pending requests.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/blk-mq-debugfs.c   |  1 +
 block/blk-mq.c           | 36 ++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c | 28 ++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/pci.c  |  3 +++
 include/linux/blk-mq.h   |  3 +++
 6 files changed, 73 insertions(+)

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 28167c9baa55..a312cb6b6127 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -162,6 +162,7 @@ static const char *const hctx_state_name[] = {
 	HCTX_STATE_NAME(TAG_ACTIVE),
 	HCTX_STATE_NAME(SCHED_RESTART),
 	HCTX_STATE_NAME(INACTIVE),
+	HCTX_STATE_NAME(IDLE),
 };
 #undef HCTX_STATE_NAME
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9af8c3dec3f6..359f19b8238a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -112,6 +112,31 @@ void blk_mq_in_driver_rw(struct block_device *part, unsigned int inflight[2])
 	inflight[WRITE] = mi.inflight[WRITE];
 }
 
+static void __blk_update_hw_queue_idle(struct request_queue *q, bool idle)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned long i;
+
+	queue_for_each_hw_ctx(q, hctx, i) {
+		if (idle)
+			set_bit(BLK_MQ_S_IDLE, &hctx->state);
+		else
+			clear_bit(BLK_MQ_S_IDLE, &hctx->state);
+	}
+}
+
+void blk_mq_set_hw_queues_idle(struct request_queue *q)
+{
+	__blk_update_hw_queue_idle(q, true);
+}
+EXPORT_SYMBOL_GPL(blk_mq_set_hw_queues_idle);
+
+void blk_mq_clear_hw_queues_idle(struct request_queue *q)
+{
+	__blk_update_hw_queue_idle(q, false);
+}
+EXPORT_SYMBOL_GPL(blk_mq_clear_hw_queues_idle);
+
 #ifdef CONFIG_LOCKDEP
 static bool blk_freeze_set_owner(struct request_queue *q,
 				 struct task_struct *owner)
@@ -3679,6 +3704,17 @@ static bool blk_mq_has_request(struct request *rq, void *data)
 
 	if (rq->mq_hctx != iter_data->hctx)
 		return true;
+
+	/*
+	 * The driver ensures that all hardware queue resources are freed, even
+	 * if a request has a tag allocated to a CPU that is going offline. This
+	 * applies to requests not yet handed to the hardware. Essentially those
+	 * 'in-flight' between the block layer and the hardware (e.g., a request
+	 * blocked because the queue is quiesced).
+	 */
+	if (test_bit(BLK_MQ_S_IDLE, &iter_data->hctx->state))
+		return false;
+
 	iter_data->has_rq = true;
 	return false;
 }
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e84df1a2d321..1b736a58e467 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5354,6 +5354,34 @@ void nvme_unquiesce_admin_queue(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_unquiesce_admin_queue);
 
+static void __nvme_set_hw_queues_idle(struct nvme_ctrl *ctrl, bool idle)
+{
+	struct nvme_ns *ns;
+	int srcu_idx;
+
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+				 srcu_read_lock_held(&ctrl->srcu)) {
+		if (idle)
+			blk_mq_set_hw_queues_idle(ns->queue);
+		else
+			blk_mq_clear_hw_queues_idle(ns->queue);
+	}
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
+}
+
+void nvme_set_hw_queues_idle(struct nvme_ctrl *ctrl)
+{
+	__nvme_set_hw_queues_idle(ctrl, true);
+}
+EXPORT_SYMBOL_GPL(nvme_set_hw_queues_idle);
+
+void nvme_clear_hw_queues_idle(struct nvme_ctrl *ctrl)
+{
+	__nvme_set_hw_queues_idle(ctrl, false);
+}
+EXPORT_SYMBOL_GPL(nvme_clear_hw_queues_idle);
+
 void nvme_sync_io_queues(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index dbd063413da9..d199009982f1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -834,6 +834,8 @@ void nvme_quiesce_io_queues(struct nvme_ctrl *ctrl);
 void nvme_unquiesce_io_queues(struct nvme_ctrl *ctrl);
 void nvme_quiesce_admin_queue(struct nvme_ctrl *ctrl);
 void nvme_unquiesce_admin_queue(struct nvme_ctrl *ctrl);
+void nvme_set_hw_queues_idle(struct nvme_ctrl *ctrl);
+void nvme_clear_hw_queues_idle(struct nvme_ctrl *ctrl);
 void nvme_mark_namespaces_dead(struct nvme_ctrl *ctrl);
 void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_sync_io_queues(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2f0c05719316..0097a4f71f97 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3211,6 +3211,8 @@ static void nvme_reset_work(struct work_struct *work)
 	nvme_unquiesce_admin_queue(&dev->ctrl);
 	mutex_unlock(&dev->shutdown_lock);
 
+	nvme_set_hw_queues_idle(&dev->ctrl);
+
 	/*
 	 * Introduce CONNECTING state from nvme-fc/rdma transports to mark the
 	 * initializing procedure here.
@@ -3243,6 +3245,7 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
+	nvme_clear_hw_queues_idle(&dev->ctrl);
 	/*
 	 * Freeze and update the number of I/O queues as those might have
 	 * changed.  If there are no I/O queues left after this reset, keep the
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 18a2388ba581..8885e84a7889 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -721,6 +721,7 @@ enum {
 	BLK_MQ_S_SCHED_RESTART,
 	/* hw queue is inactive after all its CPUs become offline */
 	BLK_MQ_S_INACTIVE,
+	BLK_MQ_S_IDLE,
 	BLK_MQ_S_MAX
 };
 
@@ -934,6 +935,8 @@ void blk_mq_stop_hw_queues(struct request_queue *q);
 void blk_mq_start_hw_queues(struct request_queue *q);
 void blk_mq_start_stopped_hw_queue(struct blk_mq_hw_ctx *hctx, bool async);
 void blk_mq_start_stopped_hw_queues(struct request_queue *q, bool async);
+void blk_mq_set_hw_queues_idle(struct request_queue *q);
+void blk_mq_clear_hw_queues_idle(struct request_queue *q);
 void blk_mq_quiesce_queue(struct request_queue *q);
 void blk_mq_wait_quiesce_done(struct blk_mq_tag_set *set);
 void blk_mq_quiesce_tagset(struct blk_mq_tag_set *set);

-- 
2.53.0


