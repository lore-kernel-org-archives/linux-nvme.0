Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B667CD6E43
	for <linux-nvme@archiver.kernel.org>; Fri, 29 May 2026 00:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=h4NRSqy35jt5KU4/CdP7Ksm0GS/daEYEZ96rcO4Wdkw=; b=aDy+Rv0ZP7HfQNb1UanP/QjndF
	QLsaJvlxfDnTTKxMFo+LuM/BTLuvUFpujLamYejAfjewrgHiaiTjtzSWpSSfB5IkJgjSAM5EnuuCz
	QIGMBijpwZsKmo+jl3N0AbbcxjaZwjTyfh8OVYakwnMm93pMi8BR0MMxn8GUojHuC6+CUB4qNh/DH
	y7PZ40covs+Q6NhRQwhqxW3suOBIOSRlT1gb58uMOgKHJo8vEJV8TnlZ2zKw8jXkkLkr9P1JurPV9
	uGN31Pb00lWLw+PSoeWcvJCnzJGyD4kkQTXDUtmk3IMRdH+xdans2YhPsDvYWjw7eSDcYXc88Evuv
	/agF3s+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSkrm-00000006ZR3-1dat;
	Fri, 29 May 2026 00:14:22 +0000
Received: from mail-ot1-x363.google.com ([2607:f8b0:4864:20::363])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSkri-00000006ZQN-3Mi5
	for linux-nvme@lists.infradead.org;
	Fri, 29 May 2026 00:14:20 +0000
Received: by mail-ot1-x363.google.com with SMTP id 46e09a7af769-7dcd17e19b6so7529270a34.1
        for <linux-nvme@lists.infradead.org>; Thu, 28 May 2026 17:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1780013657; x=1780618457; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h4NRSqy35jt5KU4/CdP7Ksm0GS/daEYEZ96rcO4Wdkw=;
        b=d+WE7Uu1V/BwW/tDAuBJGQHyOy2ahJsQWSZiyn1SMOXIPortSnQYHhk/ScO9W0EJRm
         2zATmQjqNIYBXUj+NeNxPq9wAHgderZyRTpKrkQY60VVBqaz2I5gDmr7nSDcvuFM3ZR+
         h6cAXDBEikKm3bjRNDygM03+ZZY7yxU6cVE+uULw7l87TZ6li1lqDiM0W5iWTQc0kDpq
         IYwz99XDD170+O0Bi4cNpUkEuDt5uIYvUVydmaJyT8t+XnUnkYz10LC8ZPUW3SyKDMZo
         9V76Pa1rEIZDbijB3ostSOt2Ox1ja7KjRaD4i4nbCzsm/VVgMgx2ti7my06uCxxFiM2j
         +hBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780013657; x=1780618457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4NRSqy35jt5KU4/CdP7Ksm0GS/daEYEZ96rcO4Wdkw=;
        b=gKoQNgQai7mz6d8P0FzoHkdlSBWpX23t5TFIdaWsX2dNsn6Xt3hIi0uzUrEjyUdzCk
         as2E6RiyFh9LTE1PexlIy2yv/XVn8fpC5kVJKayGhmyU3M3gLLvZ7OFlyCgIMw4jidrW
         wd/tp0LiHbMReR2wbMfxwl9G+ujVPis54bXNTNr+uobDAGStaC6oEB59vyEdI6eBueux
         5QAGnpM0yZdD8V6WFi4S2W1pMUfzcezaIrdw1RFZQRp/C4oMmn39jt9LjKLuvK428vgB
         h105tVd/TMZk2na6aHYYwJxA9dMB6kvwQApmBudzLPfWW1h21RQ8gmXm03OblmhBmu3T
         flEQ==
X-Gm-Message-State: AOJu0YyQ/ulYxjR4qU4a4t3ALJCqpMy3Uo+MZWVPvVOAUX7PMdUcydML
	kVpSrGqVO+0foLtyXLex8gkGg1P2YTvtGV64WGMwDUg+nfyAGB9vpipkMXnUlFVOU1zjG6+nkr/
	oLQxzvwvGac8ACpfvtS3qRLwIbfJYNj2OQqABSmUH2i1swTRdwtaI
X-Gm-Gg: Acq92OEvNT9/Om3kbEb8C4kRO2Jy8bhb/j5Gi52QFZvUZ4LA4/VYEwHbEJiaWWz5PpV
	zNdYsovQDQZiILkVB2tPWrOFthMRzkx1oWJokuKWkqsocQbnWQOrXiPPXiIc3Ce7uDhufF+uqyz
	97bkapQieCFooUcY1zolgsFSZOZekv1nFvy3QVhCMhqWMVeResis8MQH/QS64tuM+U6xOXQtgV6
	xINgtGesDDwwmERt1GWWtIs6miShu6RtXfQQrlc9tABoUyccIgYpeAmMAh8gxZ+wpSLhptfn2Gl
	1U44lQv9J4dCSpctetOSVpqhDPbf7PLWoJ4+pqIsyuDzvAW5PzqzX5kbyyv2myhRu7zDrFk/D36
	JorLexG7oIbj1SNteevbYk/Of3yz9fb32wRH7tjRasH/owsch
X-Received: by 2002:a05:6820:134f:b0:69d:7ce9:ac52 with SMTP id 006d021491bc7-69e03f0f7cfmr423899eaf.16.1780013657087;
        Thu, 28 May 2026 17:14:17 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-69e03f9ebe1sm35768eaf.3.2026.05.28.17.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 17:14:17 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-sgogte.dev.purestorage.com (dev-sgogte.dev.purestorage.com [10.112.19.91])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 5827A3401A2;
	Thu, 28 May 2026 18:14:16 -0600 (MDT)
Received: by dev-sgogte.dev.purestorage.com (Postfix, from userid 1557734945)
	id 4664A5122F; Thu, 28 May 2026 18:14:16 -0600 (MDT)
From: Surabhi Gogte <sgogte@purestorage.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com,
	randyj@purestorage.com,
	Surabhi Gogte <sgogte@purestorage.com>
Subject: [PATCH] nvme-rdma: parallelize I/O queue allocation and startup
Date: Thu, 28 May 2026 18:13:54 -0600
Message-ID: <20260529001354.1003640-1-sgogte@purestorage.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260528_171419_048836_18D70725 
X-CRM114-Status: GOOD (  24.18  )
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

Refactor nvme rdma I/O queue setup to use parallel work queues,
combining allocation and startup into a single parallel operation per
queue. This reduces connection and reconnection setup time when there
are delays in establishing connections, which is especially important
for high-core-count hosts.

Key changes:
- Use a dedicated nvme_setup_wq for per-queue setup work instead of
  nvme_wq or nvme_reset_wq. Since reconnect and reset paths run as
  workers on those queues, calling flush_work() on setup items queued
  to the same workqueue would trigger lockdep's recursive-flush
  detection and risk deadlock under worker-pool exhaustion.
- Add setup_work and queue_idx fields to nvme_rdma_queue to enable
  per-queue workqueue dispatch; add qsetup_err atomic to
  nvme_rdma_ctrl for collecting errors across parallel workers.
- Refactor nvme_rdma_alloc_queue() to accept a pre-initialized queue
  pointer instead of (ctrl, idx, queue_size), updating all call sites
  including the admin queue path.
- Remove nvme_rdma_alloc_io_queues() and nvme_rdma_start_io_queues();
  their logic is folded into nvme_rdma_setup_io_queues() and
  nvme_rdma_configure_io_queues().
- Move queue count negotiation (nvme_set_queue_count,
  nvmf_set_io_queues) from the removed nvme_rdma_alloc_io_queues()
  into nvme_rdma_configure_io_queues().
- Introduce nvme_rdma_setup_io_queues() to dispatch alloc+start per
  queue in parallel and collect errors atomically.

Testing on a 64-core host with 64 IO-queues shows
nvme-rdma connection time reduced from ~1.4s to 416ms.

Signed-off-by: Surabhi Gogte <sgogte@purestorage.com>
---
 drivers/nvme/host/core.c |  15 ++++-
 drivers/nvme/host/nvme.h |   1 +
 drivers/nvme/host/rdma.c | 127 ++++++++++++++++++++++-----------------
 3 files changed, 86 insertions(+), 57 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dc388e24caad..f1247a61c797 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -107,7 +107,8 @@ MODULE_PARM_DESC(disable_pi_offsets,
 	"disable protection information if it has an offset");
 
 /*
- * nvme_wq - hosts nvme related works that are not reset or delete
+ * nvme_wq - hosts nvme related works that are not queue setup, reset or delete
+ * nvme_setup_wq - hosts nvme queue setup works
  * nvme_reset_wq - hosts nvme reset works
  * nvme_delete_wq - hosts nvme delete works
  *
@@ -126,6 +127,9 @@ EXPORT_SYMBOL_GPL(nvme_reset_wq);
 struct workqueue_struct *nvme_delete_wq;
 EXPORT_SYMBOL_GPL(nvme_delete_wq);
 
+struct workqueue_struct *nvme_setup_wq;
+EXPORT_SYMBOL_GPL(nvme_setup_wq);
+
 static LIST_HEAD(nvme_subsystems);
 DEFINE_MUTEX(nvme_subsystems_lock);
 
@@ -5415,10 +5419,14 @@ static int __init nvme_core_init(void)
 	if (!nvme_delete_wq)
 		goto destroy_reset_wq;
 
+	nvme_setup_wq = alloc_workqueue("nvme-setup-wq", wq_flags, 0);
+	if (!nvme_setup_wq)
+		goto destroy_delete_wq;
+
 	result = alloc_chrdev_region(&nvme_ctrl_base_chr_devt, 0,
 			NVME_MINORS, "nvme");
 	if (result < 0)
-		goto destroy_delete_wq;
+		goto destroy_setup_wq;
 
 	result = class_register(&nvme_class);
 	if (result)
@@ -5452,6 +5460,8 @@ static int __init nvme_core_init(void)
 	class_unregister(&nvme_class);
 unregister_chrdev:
 	unregister_chrdev_region(nvme_ctrl_base_chr_devt, NVME_MINORS);
+destroy_setup_wq:
+	destroy_workqueue(nvme_setup_wq);
 destroy_delete_wq:
 	destroy_workqueue(nvme_delete_wq);
 destroy_reset_wq:
@@ -5470,6 +5480,7 @@ static void __exit nvme_core_exit(void)
 	class_unregister(&nvme_class);
 	unregister_chrdev_region(nvme_ns_chr_devt, NVME_MINORS);
 	unregister_chrdev_region(nvme_ctrl_base_chr_devt, NVME_MINORS);
+	destroy_workqueue(nvme_setup_wq);
 	destroy_workqueue(nvme_delete_wq);
 	destroy_workqueue(nvme_reset_wq);
 	destroy_workqueue(nvme_wq);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ccd5e05dac98..9cc49f5ad8af 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -49,6 +49,7 @@ extern unsigned int admin_timeout;
 extern struct workqueue_struct *nvme_wq;
 extern struct workqueue_struct *nvme_reset_wq;
 extern struct workqueue_struct *nvme_delete_wq;
+extern struct workqueue_struct *nvme_setup_wq;
 extern struct mutex nvme_subsystems_lock;
 
 /*
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f77c960f7632..b2db43bd6e84 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -98,6 +98,8 @@ struct nvme_rdma_queue {
 	bool			pi_support;
 	int			cq_size;
 	struct mutex		queue_lock;
+	struct work_struct	setup_work;
+	int			queue_idx;
 };
 
 struct nvme_rdma_ctrl {
@@ -125,6 +127,7 @@ struct nvme_rdma_ctrl {
 	struct nvme_ctrl	ctrl;
 	bool			use_inline_data;
 	u32			io_queues[HCTX_MAX_TYPES];
+	atomic_t		qsetup_err;
 };
 
 static inline struct nvme_rdma_ctrl *to_rdma_ctrl(struct nvme_ctrl *ctrl)
@@ -566,16 +569,14 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	return ret;
 }
 
-static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
-		int idx, size_t queue_size)
+static int nvme_rdma_alloc_queue(struct nvme_rdma_queue *queue)
 {
-	struct nvme_rdma_queue *queue;
+	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
+	int idx = nvme_rdma_queue_idx(queue);
 	struct sockaddr *src_addr = NULL;
 	int ret;
 
-	queue = &ctrl->queues[idx];
 	mutex_init(&queue->queue_lock);
-	queue->ctrl = ctrl;
 	if (idx && ctrl->ctrl.max_integrity_segments)
 		queue->pi_support = true;
 	else
@@ -587,8 +588,6 @@ static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 	else
 		queue->cmnd_capsule_len = sizeof(struct nvme_command);
 
-	queue->queue_size = queue_size;
-
 	queue->cm_id = rdma_create_id(&init_net, nvme_rdma_cm_handler, queue,
 			RDMA_PS_TCP, IB_QPT_RC);
 	if (IS_ERR(queue->cm_id)) {
@@ -694,59 +693,59 @@ static int nvme_rdma_start_queue(struct nvme_rdma_ctrl *ctrl, int idx)
 	return ret;
 }
 
-static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl,
-				     int first, int last)
+static void nvme_rdma_setup_queue_work(struct work_struct *work)
 {
-	int i, ret = 0;
+	struct nvme_rdma_queue *queue =
+		container_of(work, struct nvme_rdma_queue, setup_work);
+	int ret;
 
-	for (i = first; i < last; i++) {
-		ret = nvme_rdma_start_queue(ctrl, i);
-		if (ret)
-			goto out_stop_queues;
-	}
+	ret = nvme_rdma_alloc_queue(queue);
+	if (ret)
+		goto out_err;
 
-	return 0;
+	ret = nvme_rdma_start_queue(queue->ctrl, queue->queue_idx);
+	if (ret)
+		goto out_err;
 
-out_stop_queues:
-	for (i--; i >= first; i--)
-		nvme_rdma_stop_queue(&ctrl->queues[i]);
-	return ret;
+	return;
+
+out_err:
+	atomic_cmpxchg(&queue->ctrl->qsetup_err, 0, ret);
 }
 
-static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
+static int nvme_rdma_setup_io_queues(struct nvme_rdma_ctrl *ctrl, int first,
+				     int last, size_t queue_size)
 {
-	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
-	unsigned int nr_io_queues;
-	int i, ret;
+	int nr_queues = last - first;
+	int ret, i;
 
-	nr_io_queues = nvmf_nr_io_queues(opts);
-	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
-	if (ret)
-		return ret;
+	atomic_set(&ctrl->qsetup_err, 0);
 
-	if (nr_io_queues == 0) {
-		dev_err(ctrl->ctrl.device,
-			"unable to set any I/O queues\n");
-		return -ENOMEM;
-	}
-
-	ctrl->ctrl.queue_count = nr_io_queues + 1;
-	dev_info(ctrl->ctrl.device,
-		"creating %d I/O queues.\n", nr_io_queues);
+	for (i = 0; i < nr_queues; i++) {
+		struct nvme_rdma_queue *queue = &ctrl->queues[first + i];
 
-	nvmf_set_io_queues(opts, nr_io_queues, ctrl->io_queues);
-	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
-		ret = nvme_rdma_alloc_queue(ctrl, i,
-				ctrl->ctrl.sqsize + 1);
-		if (ret)
-			goto out_free_queues;
+		queue->ctrl = ctrl;
+		queue->queue_idx = first + i;
+		queue->queue_size = queue_size;
+		INIT_WORK(&queue->setup_work, nvme_rdma_setup_queue_work);
+		queue_work(nvme_setup_wq, &queue->setup_work);
 	}
 
-	return 0;
+	for (i = 0; i < nr_queues; i++)
+		flush_work(&ctrl->queues[first + i].setup_work);
 
-out_free_queues:
-	for (i--; i >= 1; i--)
-		nvme_rdma_free_queue(&ctrl->queues[i]);
+	ret = atomic_read(&ctrl->qsetup_err);
+	if (ret) {
+		for (i = 0; i < nr_queues; i++) {
+			struct nvme_rdma_queue *queue =
+				&ctrl->queues[first + i];
+
+			if (test_bit(NVME_RDMA_Q_LIVE, &queue->flags))
+				nvme_rdma_stop_queue(queue);
+			if (test_bit(NVME_RDMA_Q_ALLOCATED, &queue->flags))
+				nvme_rdma_free_queue(queue);
+		}
+	}
 
 	return ret;
 }
@@ -783,7 +782,9 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	bool pi_capable = false;
 	int error;
 
-	error = nvme_rdma_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
+	ctrl->queues[0].ctrl = ctrl;
+	ctrl->queues[0].queue_size = NVME_AQ_DEPTH;
+	error = nvme_rdma_alloc_queue(&ctrl->queues[0]);
 	if (error)
 		return error;
 
@@ -864,11 +865,22 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 {
 	int ret, nr_queues;
+	unsigned int nr_io_queues;
 
-	ret = nvme_rdma_alloc_io_queues(ctrl);
+	nr_io_queues = nvmf_nr_io_queues(ctrl->ctrl.opts);
+	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret)
 		return ret;
 
+	if (nr_io_queues == 0) {
+		dev_err(ctrl->ctrl.device, "unable to set any I/O queues\n");
+		return -ENOMEM;
+	}
+
+	ctrl->ctrl.queue_count = nr_io_queues + 1;
+	dev_info(ctrl->ctrl.device, "creating %d I/O queues.\n", nr_io_queues);
+	nvmf_set_io_queues(ctrl->ctrl.opts, nr_io_queues, ctrl->io_queues);
+
 	if (new) {
 		ret = nvme_rdma_alloc_tag_set(&ctrl->ctrl);
 		if (ret)
@@ -881,7 +893,9 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 	 * queue number might have changed.
 	 */
 	nr_queues = min(ctrl->tag_set.nr_hw_queues + 1, ctrl->ctrl.queue_count);
-	ret = nvme_rdma_start_io_queues(ctrl, 1, nr_queues);
+	ret = nvme_rdma_setup_io_queues(ctrl, 1, nr_queues,
+					ctrl->ctrl.sqsize + 1);
+
 	if (ret)
 		goto out_cleanup_tagset;
 
@@ -905,12 +919,15 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 	/*
 	 * If the number of queues has increased (reconnect case)
-	 * start all new queues now.
+	 * setup all new queues now.
 	 */
-	ret = nvme_rdma_start_io_queues(ctrl, nr_queues,
-					ctrl->tag_set.nr_hw_queues + 1);
-	if (ret)
-		goto out_wait_freeze_timed_out;
+	if (ctrl->tag_set.nr_hw_queues + 1 > nr_queues) {
+		ret = nvme_rdma_setup_io_queues(ctrl, nr_queues,
+						ctrl->tag_set.nr_hw_queues + 1,
+						ctrl->ctrl.sqsize + 1);
+		if (ret)
+			goto out_wait_freeze_timed_out;
+	}
 
 	return 0;
 
-- 
2.54.0


