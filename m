Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD564C001DC
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 13:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TmvvgLZyT72jnbZrgLlWUcgvUoxUPFUQN3cneGnzMNY=; b=ADcYYo9Z3jTFbo4VJT8qEG1a0n
	TTP7h+J+2AMZhlnG4vk5EK+3oOzTDCRG9OHsgZM5Fu5Sop9bvqFgtcEQTTHeLZ6WOFI84NREEr3m9
	DOOWSQRu+pnvjXueHqX5UBdOm5P6/PzodfSiU49tjV91fOFAJ6l6AX56bXJOepKaOa43WJ7Ghzk5n
	Klvd9NX7BHYIHzR5b45L9pyWZYpMIUaGbLYmkvkwC/Ex/YaADGnruKAtG1OZps93qYD1puB6k7EGz
	l5AT3vL7uPSzMNYUScffRSECMjIilMwT24AMHFLyNbjXl5Z7OoLkACOP0E84sJc8qwzKsLFd9PC3D
	1BogTI7g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOeU6-00AWcH-06;
	Wed, 26 Jul 2023 13:23:22 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOeU1-00AWZY-2Z
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 13:23:20 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id CD83C21D55;
	Wed, 26 Jul 2023 13:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1690377794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TmvvgLZyT72jnbZrgLlWUcgvUoxUPFUQN3cneGnzMNY=;
	b=hOglfyUPqTruE3maSmtporrBMKIoi8ENFBn5Q5HDPZKs5K+mzIqQ2crYeHzSFDm7QiUjLP
	pN6c3s7yn4r4bIVy0uwo0rC0NNMD9i9WYYX4EvhhhpLnQxB6UqrIBBqqgmIhPfHWDI77MP
	SVZo5RIYYw9zFpLuMVOUieu2yv40wig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1690377794;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TmvvgLZyT72jnbZrgLlWUcgvUoxUPFUQN3cneGnzMNY=;
	b=6+KYnx17XjJgOc3SU5A8N50sDFarFDw4wbq6QX/YhSWc59DfeFUF51RHyAqD2hGu2GP+nF
	Vs75PlXVvqRholBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id ADB7C2C145;
	Wed, 26 Jul 2023 13:23:14 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 979F651CA306; Wed, 26 Jul 2023 15:23:14 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Ewan Milne <emilne@redhat.com>,
	Uday Shankar <ushankar@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/2] nvme-multipath: add additional iopolicies
Date: Wed, 26 Jul 2023 15:23:04 +0200
Message-Id: <20230726132305.33739-2-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230726132305.33739-1-hare@suse.de>
References: <20230726132305.33739-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_062317_986726_6868569E 
X-CRM114-Status: GOOD (  20.74  )
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

Add a several new iopolicies, 'bandwidth' and 'ewma',
to direct I/O better in case of complex fabrics.
The current 'round-robin' I/O policy suffers from the 'buffer bloat'
symptom, where I/O will be piling on the slow paths for
asymmetric fabrics.
With these iopolicies I/O is directed to the path with the
smallest 'load', where the load is calculated either as the
smallest number of bytes transmitted (the 'bandwidth' iopolicy),
or the least busy path (the 'ewma' iopolicy).

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/multipath.c | 54 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  3 ++
 2 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0a88d7bdc5e3..7813608038bc 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -17,6 +17,8 @@ MODULE_PARM_DESC(multipath,
 static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_NUMA]	= "numa",
 	[NVME_IOPOLICY_RR]	= "round-robin",
+	[NVME_IOPOLICY_BW]	= "bandwidth",
+	[NVME_IOPOLICY_EWMA]	= "ewma",
 };
 
 static int iopolicy = NVME_IOPOLICY_NUMA;
@@ -29,6 +31,10 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
 		iopolicy = NVME_IOPOLICY_NUMA;
 	else if (!strncmp(val, "round-robin", 11))
 		iopolicy = NVME_IOPOLICY_RR;
+	else if (!strncmp(val, "bandwidth", 9))
+		iopolicy = NVME_IOPOLICY_BW;
+	else if (!strncmp(val, "ewma", 4))
+		iopolicy = NVME_IOPOLICY_EWMA;
 	else
 		return -EINVAL;
 
@@ -43,7 +49,7 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
 module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
 	&iopolicy, 0644);
 MODULE_PARM_DESC(iopolicy,
-	"Default multipath I/O policy; 'numa' (default) or 'round-robin'");
+	"Default multipath I/O policy; 'numa' (default), 'round-robin', 'bandwidth', or 'ewma'");
 
 void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
 {
@@ -237,17 +243,34 @@ static bool nvme_path_is_disabled(struct nvme_ns *ns)
 	return false;
 }
 
+static unsigned int nvme_path_ewma(struct nvme_ns *ns)
+{
+	struct blk_mq_hw_ctx *hctx;
+	unsigned long i;
+	unsigned int ewma = 0;
+
+	queue_for_each_hw_ctx(ns->queue, hctx, i)
+		ewma += hctx->dispatch_busy;
+
+	return ewma;
+}
+
 static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 {
 	int found_distance = INT_MAX, fallback_distance = INT_MAX, distance;
 	struct nvme_ns *found = NULL, *fallback = NULL, *ns;
+	int iopolicy = READ_ONCE(head->subsys->iopolicy);
 
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
 		if (nvme_path_is_disabled(ns))
 			continue;
 
-		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
+		if (iopolicy == NVME_IOPOLICY_NUMA)
 			distance = node_distance(node, ns->ctrl->numa_node);
+		else if (iopolicy == NVME_IOPOLICY_BW)
+			distance = ns->path_weight;
+		else if (iopolicy == NVME_IOPOLICY_EWMA)
+			distance = nvme_path_ewma(ns);
 		else
 			distance = LOCAL_DISTANCE;
 
@@ -329,6 +352,26 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 	return found;
 }
 
+static inline void nvme_path_weight(struct nvme_ns *ns, struct bio *bio)
+{
+	int iopolicy;
+
+	iopolicy = READ_ONCE(ns->head->subsys->iopolicy);
+	if (iopolicy == NVME_IOPOLICY_BW)
+		ns->path_weight += bio_sectors(bio);
+}
+
+static void nvme_reset_weight(struct nvme_ns_head *head)
+{
+	int srcu_idx;
+	struct nvme_ns *ns;
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	list_for_each_entry_rcu(ns, &head->list, siblings)
+		WRITE_ONCE(ns->path_weight, 0);
+	srcu_read_unlock(&head->srcu, srcu_idx);
+}
+
 static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 {
 	return ns->ctrl->state == NVME_CTRL_LIVE &&
@@ -390,6 +433,7 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 	srcu_idx = srcu_read_lock(&head->srcu);
 	ns = nvme_find_path(head);
 	if (likely(ns)) {
+		nvme_path_weight(ns, bio);
 		bio_set_dev(bio, ns->disk->part0);
 		bio->bi_opf |= REQ_NVME_MPATH;
 		trace_block_bio_remap(bio, disk_devt(ns->head->disk),
@@ -657,6 +701,7 @@ static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
 	ns->ana_grpid = le32_to_cpu(desc->grpid);
 	ns->ana_state = desc->state;
 	clear_bit(NVME_NS_ANA_PENDING, &ns->flags);
+	ns->path_weight = 0;
 	/*
 	 * nvme_mpath_set_live() will trigger I/O to the multipath path device
 	 * and in turn to this path device.  However we cannot accept this I/O
@@ -805,7 +850,12 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 
 	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
 		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
+			struct nvme_ns_head *h;
 			WRITE_ONCE(subsys->iopolicy, i);
+			mutex_lock(&subsys->lock);
+			list_for_each_entry(h, &subsys->nsheads, entry)
+				nvme_reset_weight(h);
+			mutex_unlock(&subsys->lock);
 			return count;
 		}
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6fe7966f720b..4eabb6ee563a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -390,6 +390,8 @@ struct nvme_ctrl {
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
+	NVME_IOPOLICY_BW,
+	NVME_IOPOLICY_EWMA,
 };
 
 struct nvme_subsystem {
@@ -482,6 +484,7 @@ struct nvme_ns {
 #ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_ana_state ana_state;
 	u32 ana_grpid;
+	u32 path_weight;
 #endif
 	struct list_head siblings;
 	struct kref kref;
-- 
2.35.3


