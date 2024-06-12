Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD55C27C78
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 00:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iML5TLUglLqW2tZ5OAvVZsst1S3AdfY0rYX1JvandRw=; b=B4u/l7dX7+9dp0BZMob9a/dIa7
	8GxIzWAbvoIF7lcYIg1HT5GZzOfXKR2ZgulPN9XR2dCoEXXqwKTxpcUQ5Zxl7YbzClxN9sqLVwfAu
	TL2Y+QHDumG0UJ+sTRAr2QnayvqnIpouM3eJ1sMc48lPGGmM4jHX5bLs+qNJpZNN+yPhYWG7dGd64
	XHy9gQZEwRmbkUFSUbY3L1yQ9cQSCrzoMQ3ILkfLGuARqpUeSo1N4BsdRBgfDhXP7USUsT1cUCfpP
	7yathg1KQOwl7GvMqimxJdPKh2SVFUN6NqdMK3qPnB1tPH6UlXT0G99WGFK4XacUopao01ds4Wpqk
	6oULOfGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHBjR-0000000Aa1Z-2ahq;
	Wed, 12 Jun 2024 00:20:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHBjO-0000000Aa0e-37rG
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 00:20:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718151647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iML5TLUglLqW2tZ5OAvVZsst1S3AdfY0rYX1JvandRw=;
	b=FFwbgHYKj8Mid6BCzVbcwx9xUK7CGeMyYHikCA+0G7nER9SKUN2eH8VDxKar1BtV3QIIdK
	WzH9+yfyWkOj7AoI9Tx9H113ynTbwHx0R+HrBCfvHoE0twm9eANnPkBr3xjus8AWtM6yde
	mV3cwMsvB+j8GeJNVtCGcj14EYAusko=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-7PtU74nbNJW5tBHEFrwJGA-1; Tue,
 11 Jun 2024 20:20:44 -0400
X-MC-Unique: 7PtU74nbNJW5tBHEFrwJGA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 922F61956086;
	Wed, 12 Jun 2024 00:20:42 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.22.8.210])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7FF4B1955E84;
	Wed, 12 Jun 2024 00:20:40 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	emilne@redhat.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com,
	hare@kernel.org
Subject: [PATCH v6 1/1] nvme-multipath: implement "queue-depth" iopolicy
Date: Tue, 11 Jun 2024 20:20:34 -0400
Message-Id: <20240612002034.1299922-2-jmeneghi@redhat.com>
In-Reply-To: <20240612002034.1299922-1-jmeneghi@redhat.com>
References: <20240612002034.1299922-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_172050_895732_E7ABCB21 
X-CRM114-Status: GOOD (  22.41  )
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

From: Thomas Song <tsong@purestorage.com>

The round-robin path selector is inefficient in cases where there is a
difference in latency between paths.  In the presence of one or more
high latency paths the round-robin selector continues to use the high
latency path equally. This results in a bias towards the highest latency
path and can cause a significant decrease in overall performance as IOs
pile on the highest latency path. This problem is acute with NVMe-oF
controllers.

The queue-depth policy instead sends I/O requests down the path with the
least amount of requests in its request queue. Paths with lower latency
will clear requests more quickly and have less requests in their queues
compared to higher latency paths. The goal of this path selector is to
make more use of lower latency paths which will bring down overall IO
latency and increase throughput and performance.

Signed-off-by: Thomas Song <tsong@purestorage.com>
[emilne: patch developed by Thomas Song @ Pure Storage, fixed whitespace
      and compilation warnings, updated MODULE_PARM description, and
      fixed potential issue with ->current_path[] being used]
Co-developed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
[jmeneghi: vairious changes and improvements, addressed review comments]
Co-developed-by: John Meneghini <jmeneghi@redhat.com>
Signed-off-by: John Meneghini <jmeneghi@redhat.com>
Link: https://lore.kernel.org/linux-nvme/20240509202929.831680-1-jmeneghi@redhat.com/
Tested-by: Marco Patalano <mpatalan@redhat.com>
Reviewed-by: Randy Jennings <randyj@purestorage.com>
Tested-by: Jyoti Rani <jrani@purestorage.com>
---
 drivers/nvme/host/core.c      |   2 +-
 drivers/nvme/host/multipath.c | 108 +++++++++++++++++++++++++++++++---
 drivers/nvme/host/nvme.h      |   5 ++
 3 files changed, 106 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7c9f91314d36..c10ff8815d82 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -110,7 +110,7 @@ struct workqueue_struct *nvme_delete_wq;
 EXPORT_SYMBOL_GPL(nvme_delete_wq);
 
 static LIST_HEAD(nvme_subsystems);
-static DEFINE_MUTEX(nvme_subsystems_lock);
+DEFINE_MUTEX(nvme_subsystems_lock);
 
 static DEFINE_IDA(nvme_instance_ida);
 static dev_t nvme_ctrl_base_chr_devt;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 03a6868f4dbc..fe10e0cebcf0 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -17,6 +17,7 @@ MODULE_PARM_DESC(multipath,
 static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_NUMA]	= "numa",
 	[NVME_IOPOLICY_RR]	= "round-robin",
+	[NVME_IOPOLICY_QD]      = "queue-depth",
 };
 
 static int iopolicy = NVME_IOPOLICY_NUMA;
@@ -29,6 +30,8 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
 		iopolicy = NVME_IOPOLICY_NUMA;
 	else if (!strncmp(val, "round-robin", 11))
 		iopolicy = NVME_IOPOLICY_RR;
+	else if (!strncmp(val, "queue-depth", 11))
+		iopolicy = NVME_IOPOLICY_QD;
 	else
 		return -EINVAL;
 
@@ -43,7 +46,7 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
 module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
 	&iopolicy, 0644);
 MODULE_PARM_DESC(iopolicy,
-	"Default multipath I/O policy; 'numa' (default) or 'round-robin'");
+	"Default multipath I/O policy; 'numa' (default), 'round-robin' or 'queue-depth'");
 
 void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
 {
@@ -128,6 +131,11 @@ void nvme_mpath_start_request(struct request *rq)
 	struct nvme_ns *ns = rq->q->queuedata;
 	struct gendisk *disk = ns->head->disk;
 
+	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
+		atomic_inc(&ns->ctrl->nr_active);
+		nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
+	}
+
 	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
 		return;
 
@@ -140,6 +148,12 @@ EXPORT_SYMBOL_GPL(nvme_mpath_start_request);
 void nvme_mpath_end_request(struct request *rq)
 {
 	struct nvme_ns *ns = rq->q->queuedata;
+	int result;
+
+	if ((nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)) {
+		result = atomic_dec_if_positive(&ns->ctrl->nr_active);
+		WARN_ON_ONCE(result < 0);
+	}
 
 	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
@@ -291,10 +305,15 @@ static struct nvme_ns *nvme_next_ns(struct nvme_ns_head *head,
 	return list_first_or_null_rcu(&head->list, struct nvme_ns, siblings);
 }
 
-static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
-		int node, struct nvme_ns *old)
+static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
 {
-	struct nvme_ns *ns, *found = NULL;
+	struct nvme_ns *ns, *old, *found = NULL;
+	int node = numa_node_id();
+
+	old = srcu_dereference(head->current_path[node], &head->srcu);
+
+	if (unlikely(!old))
+		return __nvme_find_path(head, node);
 
 	if (list_is_singular(&head->list)) {
 		if (nvme_path_is_disabled(old))
@@ -334,13 +353,49 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 	return found;
 }
 
+static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
+{
+	struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
+	unsigned int min_depth_opt = UINT_MAX, min_depth_nonopt = UINT_MAX;
+	unsigned int depth;
+
+	list_for_each_entry_rcu(ns, &head->list, siblings) {
+		if (nvme_path_is_disabled(ns))
+			continue;
+
+		depth = atomic_read(&ns->ctrl->nr_active);
+
+		switch (ns->ana_state) {
+		case NVME_ANA_OPTIMIZED:
+			if (depth < min_depth_opt) {
+				min_depth_opt = depth;
+				best_opt = ns;
+			}
+			break;
+		case NVME_ANA_NONOPTIMIZED:
+			if (depth < min_depth_nonopt) {
+				min_depth_nonopt = depth;
+				best_nonopt = ns;
+			}
+			break;
+		default:
+			break;
+		}
+
+		if (min_depth_opt == 0)
+			return best_opt;
+	}
+
+	return best_opt ? best_opt : best_nonopt;
+}
+
 static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 {
 	return nvme_ctrl_state(ns->ctrl) == NVME_CTRL_LIVE &&
 		ns->ana_state == NVME_ANA_OPTIMIZED;
 }
 
-inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
+static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
 {
 	int node = numa_node_id();
 	struct nvme_ns *ns;
@@ -349,13 +404,25 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 	if (unlikely(!ns))
 		return __nvme_find_path(head, node);
 
-	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
-		return nvme_round_robin_path(head, node, ns);
 	if (unlikely(!nvme_path_is_optimized(ns)))
 		return __nvme_find_path(head, node);
+
 	return ns;
 }
 
+
+inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
+{
+	switch (READ_ONCE(head->subsys->iopolicy)) {
+	case NVME_IOPOLICY_QD:
+		return nvme_queue_depth_path(head);
+	case NVME_IOPOLICY_RR:
+		return nvme_round_robin_path(head);
+	default:
+		return nvme_numa_path(head);
+	}
+}
+
 static bool nvme_available_path(struct nvme_ns_head *head)
 {
 	struct nvme_ns *ns;
@@ -803,6 +870,28 @@ static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
 			  nvme_iopolicy_names[READ_ONCE(subsys->iopolicy)]);
 }
 
+static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys,
+		int iopolicy)
+{
+	struct nvme_ctrl *ctrl;
+	int old_iopolicy = READ_ONCE(subsys->iopolicy);
+
+	if (old_iopolicy == iopolicy)
+		return;
+
+	WRITE_ONCE(subsys->iopolicy, iopolicy);
+
+	/* iopolicy changes clear the mpath by design */
+	mutex_lock(&nvme_subsystems_lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
+		nvme_mpath_clear_ctrl_paths(ctrl);
+	mutex_unlock(&nvme_subsystems_lock);
+
+	pr_notice("%s: changed from %s to %s for subsysnqn %s\n", __func__,
+			nvme_iopolicy_names[old_iopolicy], nvme_iopolicy_names[iopolicy],
+			subsys->subnqn);
+}
+
 static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
@@ -812,7 +901,7 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 
 	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
 		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
-			WRITE_ONCE(subsys->iopolicy, i);
+			nvme_subsys_iopolicy_update(subsys, i);
 			return count;
 		}
 	}
@@ -923,6 +1012,9 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	    !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
 		return 0;
 
+	/* initialize this in the identify path to cover controller resets */
+	atomic_set(&ctrl->nr_active, 0);
+
 	if (!ctrl->max_namespaces ||
 	    ctrl->max_namespaces > le32_to_cpu(id->nn)) {
 		dev_err(ctrl->device,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 73442d3f504b..d6c1fe3e2832 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -50,6 +50,8 @@ extern struct workqueue_struct *nvme_wq;
 extern struct workqueue_struct *nvme_reset_wq;
 extern struct workqueue_struct *nvme_delete_wq;
 
+extern struct mutex nvme_subsystems_lock;
+
 /*
  * List of workarounds for devices that required behavior not specified in
  * the standard.
@@ -195,6 +197,7 @@ enum {
 	NVME_REQ_CANCELLED		= (1 << 0),
 	NVME_REQ_USERCMD		= (1 << 1),
 	NVME_MPATH_IO_STATS		= (1 << 2),
+	NVME_MPATH_CNT_ACTIVE	= (1 << 3),
 };
 
 static inline struct nvme_request *nvme_req(struct request *req)
@@ -360,6 +363,7 @@ struct nvme_ctrl {
 	size_t ana_log_size;
 	struct timer_list anatt_timer;
 	struct work_struct ana_work;
+	atomic_t nr_active;
 #endif
 
 #ifdef CONFIG_NVME_HOST_AUTH
@@ -408,6 +412,7 @@ static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
+	NVME_IOPOLICY_QD,
 };
 
 struct nvme_subsystem {
-- 
2.39.3


