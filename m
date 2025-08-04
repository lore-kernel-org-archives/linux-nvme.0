Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32FABC87FCF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Aug 2025 11:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zIzjh21TIvtwh4LihNzZE23J9ejYW1RekzDfRhbbJR0=; b=YvNLdDf0eIOTX/aRW7J8F3Lmx1
	xLAjB+c+qh44EZKjwEgD4DXN9HA62lLQUf6BuTyCEg/j0faOJieZrpiOfXoV1LBrUCuHXyoqHel8S
	q3iSeYFjHmDbVPdxhMT6VxByZgaUZOZ5vM+mQ/6ipwhrhjErZFJ61ab8/xqn6edSPLTBwPvOwxhOu
	c1Y0T8Q5xru8sG/ry2+LY5KpTVleDuFDBitp1B2p+/k0jaPEkcfWLNQr/Tl2OMRn0uPyVLtoMQTAN
	KOrP+DfKj8XdupZayJF5HBmcIdEEKpvJ+Bht6xj+pFl9jneIIIxTMDgT4kPHnaSS2mlcgDuB2fr6O
	yp9ANz+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uitc2-0000000AJ6O-3kVE;
	Mon, 04 Aug 2025 11:44:18 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uitbv-0000000AJ5N-0usB
	for linux-nvme@lists.infradead.org;
	Mon, 04 Aug 2025 11:44:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754307850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zIzjh21TIvtwh4LihNzZE23J9ejYW1RekzDfRhbbJR0=;
	b=CPkqFJ2N2FZ7ecF2FSMPyU39494U1NgEVxpdME58Dfvb84LETQgt72Ufsq0Kg4gWv8uRv1
	1LJLNo0Khqtdd4LKsMSFO+ByyFttEHiQgm3lwtm4zHSYE/6R9f9KDRIIxo3aGizo4eaJFJ
	Xj3KjSXPVblhlzwDf7gI8vGBIAvAFhE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-113-2a1JftEFPXaOTqxdaHFIEA-1; Mon,
 04 Aug 2025 07:44:07 -0400
X-MC-Unique: 2a1JftEFPXaOTqxdaHFIEA-1
X-Mimecast-MFC-AGG-ID: 2a1JftEFPXaOTqxdaHFIEA_1754307846
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 701141800446;
	Mon,  4 Aug 2025 11:44:05 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.15])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC2F230002C6;
	Mon,  4 Aug 2025 11:44:01 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	hare@suse.de,
	mlombard@bsdbackstore.eu,
	linux-nvme@lists.infradead.org
Subject: [PATCH RFC 1/1] nvme-core: register namespaces in order during async scan
Date: Mon,  4 Aug 2025 13:43:55 +0200
Message-ID: <20250804114355.30212-2-mlombard@redhat.com>
In-Reply-To: <20250804114355.30212-1-mlombard@redhat.com>
References: <20250804114355.30212-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0QLfR_Q05_yRMGZUDmt2iLkVN5dTmphothm5-VEG7dE_1754307846
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250804_044411_341734_7689EDA5 
X-CRM114-Status: GOOD (  25.53  )
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

The fully asynchronous namespace scanning, while fast,
can result in namespaces being allocated and registered
out of order. This leads to unpredictable device naming
which can be confusing for users.

Introduce a dependency chain to the asynchronous
scanning process to ensure namespaces are allocated sequentially.
It replaces the simple atomic counter with a linked list of
`async_scan_task` structures. Each task, representing a
namespace to be scanned, waits for the completion of the
previous task in the list before it proceeds to allocate its own namespace.

This approach preserves the performance benefits of asynchronous
identification while guaranteeing that the final device
registration occurs in the correct order.

Performance testing shows that this change has no noticeable impact
on scan times compared to the fully asynchronous method.

High latency NVMe/TCP, ~100ms ping, 100 namespaces

Synchronous namespace scan (RHEL-10.1): 31175ms
Fully async namespace scan (6.16-rc7):   2563ms
Async namespace scan with dependency chain (6.16-rc7): 2599ms

Low latency NVMe/TCP, ~0.2ms ping, 100 namespaces

Synchronous namespace scan (RHEL-10.1): 335ms
Fully async namespace scan (6.16-rc7):  156ms
Async namespace scan with dependency chain (6.16-rc7): 116ms

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c | 145 ++++++++++++++++++++++++++++-----------
 drivers/nvme/host/nvme.h |   2 +
 2 files changed, 108 insertions(+), 39 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9d988f4cb87a..2a58a2b3c173 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4080,17 +4080,83 @@ static void nvme_ns_add_to_ctrl_list(struct nvme_ns *ns)
 	list_add_rcu(&ns->list, &ns->ctrl->namespaces);
 }
 
-static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
+/**
+ * struct async_scan_task - keeps track of controller & NSID to scan
+ * @ctrl:		Controller on which namespaces are being scanned
+ * @nsid:		The NSID to scan
+ * @prev_finished:	Set when the previous namespace scan has been completed
+ * @head:		Linked list of the scan asynchronous tasks
+ */
+struct async_scan_task {
+	struct nvme_ctrl *ctrl;
+	u32 nsid;
+	struct completion prev_finished;
+	struct list_head head;
+};
+
+static struct async_scan_task *async_scan_task_init(struct nvme_ctrl *ctrl,
+							u32 nsid)
+{
+	struct async_scan_task *task = kzalloc(sizeof(*task), GFP_KERNEL);
+	if (!task)
+		return NULL;
+
+	task->ctrl = ctrl;
+	task->nsid = nsid;
+	init_completion(&task->prev_finished);
+	INIT_LIST_HEAD(&task->head);
+
+	spin_lock(&ctrl->scan_list_lock);
+	if (list_empty(&ctrl->scan_list))
+		complete_all(&task->prev_finished);
+	list_add_tail(&task->head, &ctrl->scan_list);
+	spin_unlock(&ctrl->scan_list_lock);
+
+	return task;
+}
+
+static void async_scan_prev_task_wait(struct async_scan_task *task)
+{
+	if (!task)
+		return;
+
+	wait_for_completion(&task->prev_finished);
+}
+
+static void async_scan_task_complete(struct async_scan_task *task)
+{
+	struct nvme_ctrl *ctrl;
+
+	if (!task)
+		return;
+
+	async_scan_prev_task_wait(task);
+
+	ctrl = task->ctrl;
+	spin_lock(&ctrl->scan_list_lock);
+	list_del(&task->head);
+	if (!list_empty(&ctrl->scan_list)) {
+		struct async_scan_task *next = list_entry(ctrl->scan_list.next,
+			struct async_scan_task, head);
+		complete_all(&next->prev_finished);
+	}
+	spin_unlock(&ctrl->scan_list_lock);
+	kfree(task);
+}
+
+static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info,
+				struct async_scan_task *task)
 {
 	struct queue_limits lim = { };
 	struct nvme_ns *ns;
 	struct gendisk *disk;
 	int node = ctrl->numa_node;
 	bool last_path = false;
+	int r;
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
-		return;
+		goto out_complete_async;
 
 	if (ctrl->opts && ctrl->opts->data_digest)
 		lim.features |= BLK_FEAT_STABLE_WRITES;
@@ -4109,7 +4175,16 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	ns->ctrl = ctrl;
 	kref_init(&ns->kref);
 
-	if (nvme_init_ns_head(ns, info))
+	/*
+	 * Wait for the previous async task to finish before
+	 * allocating the namespace.
+	 */
+	async_scan_prev_task_wait(task);
+	r = nvme_init_ns_head(ns, info);
+	async_scan_task_complete(task);
+	task = NULL;
+
+	if (r)
 		goto out_cleanup_disk;
 
 	/*
@@ -4200,6 +4275,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	put_disk(disk);
  out_free_ns:
 	kfree(ns);
+ out_complete_async:
+	async_scan_task_complete(task);
 }
 
 static void nvme_ns_remove(struct nvme_ns *ns)
@@ -4284,19 +4361,20 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 		nvme_ns_remove(ns);
 }
 
-static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid,
+				struct async_scan_task *task)
 {
 	struct nvme_ns_info info = { .nsid = nsid };
 	struct nvme_ns *ns;
 	int ret = 1;
 
 	if (nvme_identify_ns_descs(ctrl, &info))
-		return;
+		goto exit;
 
 	if (info.ids.csi != NVME_CSI_NVM && !nvme_multi_css(ctrl)) {
 		dev_warn(ctrl->device,
 			"command set not reported for nsid: %d\n", nsid);
-		return;
+		goto exit;
 	}
 
 	/*
@@ -4319,44 +4397,27 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	 * becomes ready and restart the scan.
 	 */
 	if (ret || !info.is_ready)
-		return;
+		goto exit;
 
 	ns = nvme_find_get_ns(ctrl, nsid);
 	if (ns) {
+		async_scan_task_complete(task);
 		nvme_validate_ns(ns, &info);
 		nvme_put_ns(ns);
 	} else {
-		nvme_alloc_ns(ctrl, &info);
+		nvme_alloc_ns(ctrl, &info, task);
 	}
-}
+	return;
 
-/**
- * struct async_scan_info - keeps track of controller & NSIDs to scan
- * @ctrl:	Controller on which namespaces are being scanned
- * @next_nsid:	Index of next NSID to scan in ns_list
- * @ns_list:	Pointer to list of NSIDs to scan
- *
- * Note: There is a single async_scan_info structure shared by all instances
- * of nvme_scan_ns_async() scanning a given controller, so the atomic
- * operations on next_nsid are critical to ensure each instance scans a unique
- * NSID.
- */
-struct async_scan_info {
-	struct nvme_ctrl *ctrl;
-	atomic_t next_nsid;
-	__le32 *ns_list;
-};
+exit:
+	async_scan_task_complete(task);
+}
 
 static void nvme_scan_ns_async(void *data, async_cookie_t cookie)
 {
-	struct async_scan_info *scan_info = data;
-	int idx;
-	u32 nsid;
+	struct async_scan_task *task = data;
 
-	idx = (u32)atomic_fetch_inc(&scan_info->next_nsid);
-	nsid = le32_to_cpu(scan_info->ns_list[idx]);
-
-	nvme_scan_ns(scan_info->ctrl, nsid);
+	nvme_scan_ns(task->ctrl, task->nsid, task);
 }
 
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
@@ -4386,14 +4447,12 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 	u32 prev = 0;
 	int ret = 0, i;
 	ASYNC_DOMAIN(domain);
-	struct async_scan_info scan_info;
+	struct async_scan_task *task;
 
 	ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
 	if (!ns_list)
 		return -ENOMEM;
 
-	scan_info.ctrl = ctrl;
-	scan_info.ns_list = ns_list;
 	for (;;) {
 		struct nvme_command cmd = {
 			.identify.opcode	= nvme_admin_identify,
@@ -4409,20 +4468,26 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
 			goto free;
 		}
 
-		atomic_set(&scan_info.next_nsid, 0);
 		for (i = 0; i < nr_entries; i++) {
 			u32 nsid = le32_to_cpu(ns_list[i]);
 
 			if (!nsid)	/* end of the list? */
 				goto out;
-			async_schedule_domain(nvme_scan_ns_async, &scan_info,
+
+			task = async_scan_task_init(ctrl, nsid);
+			if (!task) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			async_schedule_domain(nvme_scan_ns_async, task,
 						&domain);
 			while (++prev < nsid)
 				nvme_ns_remove_by_nsid(ctrl, prev);
 		}
-		async_synchronize_full_domain(&domain);
 	}
  out:
+	async_synchronize_full_domain(&domain);
 	nvme_remove_invalid_namespaces(ctrl, prev);
  free:
 	async_synchronize_full_domain(&domain);
@@ -4441,7 +4506,7 @@ static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl)
 	kfree(id);
 
 	for (i = 1; i <= nn; i++)
-		nvme_scan_ns(ctrl, i);
+		nvme_scan_ns(ctrl, i, NULL);
 
 	nvme_remove_invalid_namespaces(ctrl, nn);
 }
@@ -5062,6 +5127,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
+	INIT_LIST_HEAD(&ctrl->scan_list);
+	spin_lock_init(&ctrl->scan_list_lock);
 	xa_init(&ctrl->cels);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cfd2b5b90b91..841126dc526f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -294,6 +294,8 @@ struct nvme_ctrl {
 	struct blk_mq_tag_set *tagset;
 	struct blk_mq_tag_set *admin_tagset;
 	struct list_head namespaces;
+	struct list_head scan_list;
+	spinlock_t scan_list_lock;
 	struct mutex namespaces_lock;
 	struct srcu_struct srcu;
 	struct device ctrl_device;
-- 
2.47.3


