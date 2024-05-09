Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE5FC25B74
	for <linux-nvme@archiver.kernel.org>; Thu,  9 May 2024 20:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bKx0S7FzwqaZ25i9u3aRmby5t1CJ8YR9Zqwq3RwKUt4=; b=Kv6X0vdRq9N17qbC0RzrQOlv69
	kMvwE8dB1FiAk/ON4APgVOCs9RmK2bzr7RV2gwUsFBRcHOqiwtEGcpcjBql+DMeJPT7CdAGlGFYpU
	XyAvXoH8H6zA1kuM2eRbLSzt4Ex9gbS5Vk0hQjGnfZgikyrsBSW/3C3jdhLUBFe+R/eglsDcVvzfI
	ybrks6MI5L8xbIScUsKZUgvlmZ2LSiXyEE9qTl1OVDxfQSBIAWSyoGI6j1nIa6wjsfmv5/4CuesKf
	cgrRx4IoP8poxsa3UED78xtJMd7CmoLwLsP4DTOn4/JkxsOl0AxnAyCkm86LIjTuwo1SqKzaKB9yX
	RJwXZG2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Acw-00000002oxO-2q0w;
	Thu, 09 May 2024 20:44:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5Act-00000002ovZ-0sJK
	for linux-nvme@lists.infradead.org;
	Thu, 09 May 2024 20:44:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715287466;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bKx0S7FzwqaZ25i9u3aRmby5t1CJ8YR9Zqwq3RwKUt4=;
	b=Kor5zMkda5ZM/Ne53WAea2daJ7zbsrqzLr8oq9AcWj+rsGhUx+7IPqKLE0cJyF+sfZBU2s
	h990nFkxQGtH3j0E6A3TgadoLl/1C/Rb1REJB36XqnGaRBveTajZpWbAYwSaPsLyETzbze
	QVbBeOQlEXQoklezk//APRpJRJg1+yU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-oQ-iO5sKMVeULXi4UoE1Nw-1; Thu, 09 May 2024 16:43:29 -0400
X-MC-Unique: oQ-iO5sKMVeULXi4UoE1Nw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3F3F800A03;
	Thu,  9 May 2024 20:43:28 +0000 (UTC)
Received: from jmeneghi.bos.com (unknown [10.22.16.53])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3FBF61D69461;
	Thu,  9 May 2024 20:43:28 +0000 (UTC)
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
	randyj@purestorage.com,
	aviv.coro@ibm.com
Subject: [PATCH v3 2/3] nvme: add 'latency' iopolicy
Date: Thu,  9 May 2024 16:43:23 -0400
Message-Id: <20240509204324.832846-3-jmeneghi@redhat.com>
In-Reply-To: <20240403141756.88233-1-hare@kernel.org>
References: <20240403141756.88233-1-hare@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240509_134427_334138_7187A2A1 
X-CRM114-Status: GOOD (  19.25  )
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

From: Hannes Reinecke <hare@kernel.org>

Add a latency-based I/O policy for multipathing. It uses the blk-nodelat
latency tracker to provide latencies for each node, and schedules
I/O on the path with the least latency for the submitting node.

Signed-off-by: Hannes Reinecke <hare@kernel.org>

Make this compile when CONFIG_BLK_NODE_LATENCY is not set.
Advertise the 'latency' iopolicy in modinfo.

Signed-off-by: John Meneghini <jmeneghi@redhat.com>
---
 drivers/nvme/host/multipath.c | 63 ++++++++++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h      |  1 +
 2 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d916a5ddf5d4..e9330bb1990b 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -18,6 +18,7 @@ static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_NUMA]	= "numa",
 	[NVME_IOPOLICY_RR]	= "round-robin",
 	[NVME_IOPOLICY_QD]      = "queue-depth",
+	[NVME_IOPOLICY_LAT]	= "latency",
 };
 
 static int iopolicy = NVME_IOPOLICY_NUMA;
@@ -32,6 +33,10 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
 		iopolicy = NVME_IOPOLICY_RR;
 	else if (!strncmp(val, "queue-depth", 11))
 		iopolicy = NVME_IOPOLICY_QD;
+#ifdef CONFIG_BLK_NODE_LATENCY
+	else if (!strncmp(val, "latency", 7))
+		iopolicy = NVME_IOPOLICY_LAT;
+#endif
 	else
 		return -EINVAL;
 
@@ -43,10 +48,36 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
 	return sprintf(buf, "%s\n", nvme_iopolicy_names[iopolicy]);
 }
 
+static int nvme_activate_iopolicy(struct nvme_subsystem *subsys, int iopolicy)
+{
+	struct nvme_ns_head *h;
+	struct nvme_ns *ns;
+	bool enable = iopolicy == NVME_IOPOLICY_LAT;
+	int ret = 0;
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(h, &subsys->nsheads, entry) {
+		list_for_each_entry_rcu(ns, &h->list, siblings) {
+			if (enable) {
+				ret = blk_nlat_enable(ns->disk);
+				if (ret)
+					break;
+			} else
+				blk_nlat_disable(ns->disk);
+		}
+	}
+	mutex_unlock(&subsys->lock);
+	return ret;
+}
+
 module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
 	&iopolicy, 0644);
 MODULE_PARM_DESC(iopolicy,
+#if defined(CONFIG_BLK_NODE_LATENCY)
+	"Default multipath I/O policy; 'numa' (default) , 'round-robin', 'queue-depth' or 'latency'");
+#else
 	"Default multipath I/O policy; 'numa' (default) , 'round-robin' or 'queue-depth'");
+#endif
 
 void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
 {
@@ -250,14 +281,16 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 {
 	int found_distance = INT_MAX, fallback_distance = INT_MAX, distance;
 	struct nvme_ns *found = NULL, *fallback = NULL, *ns;
+	int iopolicy = READ_ONCE(head->subsys->iopolicy);
 
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
 		if (nvme_path_is_disabled(ns))
 			continue;
 
-		if (ns->ctrl->numa_node != NUMA_NO_NODE &&
-		    READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
+		if (iopolicy == NVME_IOPOLICY_NUMA)
 			distance = node_distance(node, ns->ctrl->numa_node);
+		else if (iopolicy == NVME_IOPOLICY_LAT)
+			distance = blk_nlat_latency(ns->disk, node);
 		else
 			distance = LOCAL_DISTANCE;
 
@@ -381,8 +414,8 @@ static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 
 inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 {
-	int iopolicy = READ_ONCE(head->subsys->iopolicy);
 	int node;
+	int iopolicy = READ_ONCE(head->subsys->iopolicy);
 	struct nvme_ns *ns;
 
 	/*
@@ -401,8 +434,8 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 
 	if (iopolicy == NVME_IOPOLICY_RR)
 		return nvme_round_robin_path(head, node, ns);
-
-	if (unlikely(!nvme_path_is_optimized(ns)))
+	if (iopolicy == NVME_IOPOLICY_LAT ||
+	    unlikely(!nvme_path_is_optimized(ns)))
 		return __nvme_find_path(head, node);
 	return ns;
 }
@@ -872,15 +905,18 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 {
 	struct nvme_subsystem *subsys =
 		container_of(dev, struct nvme_subsystem, dev);
-	int i;
+	int i, ret;
 
 	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
 		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
-			nvme_subsys_iopolicy_update(subsys, i);
-			return count;
+			ret = nvme_activate_iopolicy(subsys, i);
+			if (!ret) {
+				nvme_subsys_iopolicy_update(subsys, i);
+				return count;
+			}
+			return ret;
 		}
 	}
-
 	return -EINVAL;
 }
 SUBSYS_ATTR_RW(iopolicy, S_IRUGO | S_IWUSR,
@@ -916,6 +952,15 @@ static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
 
 void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 {
+	if (!blk_nlat_init(ns->disk) &&
+	    READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_LAT) {
+		int ret = blk_nlat_enable(ns->disk);
+
+		if (unlikely(ret))
+			pr_warn("%s: Failed to enable latency tracking, error %d\n",
+				ns->disk->disk_name, ret);
+	}
+
 	if (nvme_ctrl_use_ana(ns->ctrl)) {
 		struct nvme_ana_group_desc desc = {
 			.grpid = anagrpid,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a557b4577c01..66bf003a6c48 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -411,6 +411,7 @@ enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
 	NVME_IOPOLICY_QD,
+	NVME_IOPOLICY_LAT,
 };
 
 struct nvme_subsystem {
-- 
2.39.3


