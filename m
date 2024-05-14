Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D71FC25B75
	for <linux-nvme@archiver.kernel.org>; Tue, 14 May 2024 17:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=spH1JDbuK4ZYnUhfY5CtXEY/+ATQ9QBw/vzumT0zZiI=; b=akTsAT8lRmvzcWDfmtiSbXob/E
	/T45TPgsE9Ykd+YVGF2Zd2ZkZzB2Gw9m7V0ikfwZruzw88d/OEN2kkSHnw1+jsXuawTNJy34ZAIOj
	LSvUZY3t3ftYiEU56uqqdRi0OjTVYeXCbnKLWrK+D2GWpEvkcfms7LSqo/wIQGdDT//5k/jFKjB30
	RSaiqLqCtncKv4ZXHFbDLtVDeRIoVy3y3Hu6rBeFVZ2YPm5SKMI7L3MnS6MU8+3D3RQYyqPiuClsW
	BDLWbUoCAZzEX35Finthh/CqKNY7OmQPkAJA9ej1eBPWwA4P3fy724I37CfXOc8pR0xmTXEJiYitj
	lqflXWvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6wLZ-0000000GjHo-1iGb;
	Tue, 14 May 2024 17:53:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6wLR-0000000Gj9q-27G2
	for linux-nvme@lists.infradead.org;
	Tue, 14 May 2024 17:53:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715709224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=spH1JDbuK4ZYnUhfY5CtXEY/+ATQ9QBw/vzumT0zZiI=;
	b=cMWrMQvMC5zwaft3oixjm00yvuuXvu6Y+Xda6XnB1Tgr97UU+c8f/e7vzsnUFmqMG3ePYd
	HSzgSN90O4rjM9wDYnYheRco9SxUpTHT5OzB2U6+7Vi+/n/aZnZyixDVm9ySiQdXv1HADx
	YW4y7Ditt6c0Qre9xXmPkYn8F+ezAt8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-vQ3kFgJwPRa0E5_slYnDiQ-1; Tue, 14 May 2024 13:53:30 -0400
X-MC-Unique: vQ3kFgJwPRa0E5_slYnDiQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9514C101A54F;
	Tue, 14 May 2024 17:53:29 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.2.17.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 79D3E4B400E;
	Tue, 14 May 2024 17:53:28 +0000 (UTC)
From: John Meneghini <jmeneghi@redhat.com>
To: tj@kernel.org,
	josef@toxicpanda.com,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	emilne@redhat.com,
	hare@kernel.org
Cc: linux-block@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	jmeneghi@redhat.com,
	jrani@purestorage.com,
	randyj@purestorage.com
Subject: [PATCH v4 1/6] nvme: multipath: Implemented new iopolicy "queue-depth"
Date: Tue, 14 May 2024 13:53:17 -0400
Message-Id: <20240514175322.19073-2-jmeneghi@redhat.com>
In-Reply-To: <20240514175322.19073-1-jmeneghi@redhat.com>
References: <20240514175322.19073-1-jmeneghi@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240514_105345_736586_181B50B6 
X-CRM114-Status: GOOD (  19.81  )
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

From: "Ewan D. Milne" <emilne@redhat.com>

The existing iopolicies are inefficient in some cases, such as
the presence of a path with high latency. The round-robin
policy would use that path equally with faster paths, which
results in sub-optimal performance.

The queue-depth policy instead sends I/O requests down the path
with the least amount of requests in its request queue. Paths
with lower latency will clear requests more quickly and have less
requests in their queues compared to "bad" paths. The aim is to
use those paths the most to bring down overall latency.

This implementation adds an atomic variable to the nvme_ctrl
struct to represent the queue depth. It is updated each time a
request specific to that controller starts or ends.

[edm: patch developed by Thomas Song @ Pure Storage, fixed whitespace
      and compilation warnings, updated MODULE_PARM description, and
      fixed potential issue with ->current_path[] being used]

Tested-by: John Meneghini <jmeneghi@redhat.com>
Co-developed-by: Thomas Song <tsong@purestorage.com>
Signed-off-by: Thomas Song <tsong@purestorage.com>
Signed-off-by: Ewan D. Milne <emilne@redhat.com>
---
 drivers/nvme/host/multipath.c | 59 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  2 ++
 2 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 5397fb428b24..9e36002d0831 100644
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
+	"Default multipath I/O policy; 'numa' (default) , 'round-robin' or 'queue-depth'");
 
 void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
 {
@@ -130,6 +133,7 @@ void nvme_mpath_start_request(struct request *rq)
 	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
 		return;
 
+	atomic_inc(&ns->ctrl->nr_active);
 	nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
 	nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, req_op(rq),
 						      jiffies);
@@ -142,6 +146,8 @@ void nvme_mpath_end_request(struct request *rq)
 
 	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
+
+	atomic_dec(&ns->ctrl->nr_active);
 	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
 			 blk_rq_bytes(rq) >> SECTOR_SHIFT,
 			 nvme_req(rq)->start_time);
@@ -330,6 +336,40 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
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
+
+		case NVME_ANA_NONOPTIMIZED:
+			if (depth < min_depth_nonopt) {
+				min_depth_nonopt = depth;
+				best_nonopt = ns;
+			}
+			break;
+		default:
+			break;
+		}
+	}
+
+	return best_opt ? best_opt : best_nonopt;
+}
+
 static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 {
 	return nvme_ctrl_state(ns->ctrl) == NVME_CTRL_LIVE &&
@@ -338,15 +378,27 @@ static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 
 inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 {
-	int node = numa_node_id();
+	int iopolicy = READ_ONCE(head->subsys->iopolicy);
+	int node;
 	struct nvme_ns *ns;
 
+	/*
+	 * queue-depth iopolicy does not need to reference ->current_path
+	 * but round-robin needs the last path used to advance to the
+	 * next one, and numa will continue to use the last path unless
+	 * it is or has become not optimized
+	 */
+	if (iopolicy == NVME_IOPOLICY_QD)
+		return nvme_queue_depth_path(head);
+
+	node = numa_node_id();
 	ns = srcu_dereference(head->current_path[node], &head->srcu);
 	if (unlikely(!ns))
 		return __nvme_find_path(head, node);
 
-	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
+	if (iopolicy == NVME_IOPOLICY_RR)
 		return nvme_round_robin_path(head, node, ns);
+
 	if (unlikely(!nvme_path_is_optimized(ns)))
 		return __nvme_find_path(head, node);
 	return ns;
@@ -905,6 +957,7 @@ void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl)
 	mutex_init(&ctrl->ana_lock);
 	timer_setup(&ctrl->anatt_timer, nvme_anatt_timeout, 0);
 	INIT_WORK(&ctrl->ana_work, nvme_ana_work);
+	atomic_set(&ctrl->nr_active, 0);
 }
 
 int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f243a5822c2b..e7d0a56d35d4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -354,6 +354,7 @@ struct nvme_ctrl {
 	size_t ana_log_size;
 	struct timer_list anatt_timer;
 	struct work_struct ana_work;
+	atomic_t nr_active;
 #endif
 
 #ifdef CONFIG_NVME_HOST_AUTH
@@ -402,6 +403,7 @@ static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
+	NVME_IOPOLICY_QD,
 };
 
 struct nvme_subsystem {
-- 
2.39.3


