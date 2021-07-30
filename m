Return-Path: <SRS0=PlbO=MW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6987AC4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jul 2021 07:11:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 176BF60F01
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jul 2021 07:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 176BF60F01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=km8h9QldgWBM+7d0TkTsfDKdwK9aGx89trdadOyFl3U=; b=OcDbNlxRdpV6VA
	CXB0QLFEkEgw8/ZlV6Hag0vJtgBb2X4NaDJjOwe6eGMXryopmEhb7kCM698HCjPlafsttcPsrXWEY
	XJfuP7kHcxlchS1qbZpFrPHdMv1+ZUrMkIbOqsMRG0+jAktSqruVu4XuFxdrw9GLPlIiFf59usJr2
	LOej3yV8ig7iQJNCGs1jnllFo+GY009KvvkkgfVC+5ot8i5hEczdREy249FkaiP+FadXPXbsTP33F
	tKnqREyvSHa3+9oaqd4I853EOwI4oMvEGFlG8+o+X8ez8XtAqdtnA4eOLnBzDesEf+4QDkw/O0i9K
	OIJhR+LJWxzwVx/luO+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m9Mfm-007apQ-9t; Fri, 30 Jul 2021 07:11:10 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m9Mfi-007aou-MA
 for linux-nvme@lists.infradead.org; Fri, 30 Jul 2021 07:11:08 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 8C338223AB
 for <linux-nvme@lists.infradead.org>; Fri, 30 Jul 2021 07:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627629063; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4vHnjDDBaMLY4/5VtiYtq4YN8pgNavhButTYnEXbS3Q=;
 b=aMy0/qGM3xucfQoex6jPnUAXJLuWPfwy4aH1mWtGOb8UNjjPPw2nTTRHV224zejYH0r6vx
 14O8bM9Z9v4OwvSRrfSlmn+Z7k916ikR8lDB0wQM3ecNTDaDYk1LCYSwbyaDMV8/LfqvB5
 iACVohYmTKpTemleVwGA0o5BEfcA04g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627629063;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=4vHnjDDBaMLY4/5VtiYtq4YN8pgNavhButTYnEXbS3Q=;
 b=aD6qCbjpqtC9EiGdk3kXPmlN44e/IU77NQ4iUoXMGXn1cNd+NCPkezGSED7+glk/HOSbSc
 HnF0LMtPkJAAs6DQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 86DE1A3B87;
 Fri, 30 Jul 2021 07:11:03 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id 7952451861DA; Fri, 30 Jul 2021 09:11:03 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2] nvme: invalidate paths during rescan
Date: Fri, 30 Jul 2021 09:10:59 +0200
Message-Id: <20210730071059.124347-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210730_001106_927809_229384B9 
X-CRM114-Status: GOOD (  15.11  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Hannes Reinecke <hare@suse.de>

When triggering a rescan due to a namespace resize we will be
receiving AENs on every controller, triggering a rescan of all
attached namespaces. If multipath is active only the current path and
the ns_head disk will be updated, the other paths will still refer to
the old size until AENs for the remaining controllers are received.

If I/O comes in before that it might be routed to one of the old
paths, triggering an I/O failure with 'access beyond end of device'.
With this patch the old paths are skipped from multipath path
selection until the controller serving these paths has been rescanned.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Tested-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
v2:
  - removed churn from failed rebase.
v1:
  - https://lore.kernel.org/linux-nvme/20210729194630.i5mhvvgb73duojqq@beryllium.lan/

 drivers/nvme/host/core.c      |  2 ++
 drivers/nvme/host/multipath.c | 16 ++++++++++++++++
 drivers/nvme/host/nvme.h      |  5 +++++
 3 files changed, 23 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dfd9dec0c1f6..20a079083129 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1877,6 +1877,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 			goto out_unfreeze;
 	}
 
+	clear_bit(NVME_NS_INVALIDATED, &ns->flags);
 	blk_mq_unfreeze_queue(ns->disk->queue);
 
 	if (blk_queue_is_zoned(ns->queue)) {
@@ -1888,6 +1889,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	if (nvme_ns_head_multipath(ns->head)) {
 		blk_mq_freeze_queue(ns->head->disk->queue);
 		nvme_update_disk_info(ns->head->disk, ns, id);
+		nvme_mpath_invalidate_paths(ns);
 		blk_stack_limits(&ns->head->disk->queue->limits,
 				 &ns->queue->limits, 0);
 		blk_queue_update_readahead(ns->head->disk->queue);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 3f32c5e86bfc..579020ae058d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -147,6 +147,21 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 	mutex_unlock(&ctrl->scan_lock);
 }
 
+void nvme_mpath_invalidate_paths(struct nvme_ns *ns)
+{
+	struct nvme_ns_head *head = ns->head;
+	sector_t capacity = get_capacity(head->disk);
+	int node;
+
+	for_each_node(node)
+		rcu_assign_pointer(head->current_path[node], NULL);
+
+	list_for_each_entry_rcu(ns, &head->list, siblings) {
+		if (capacity != get_capacity(ns->disk))
+			set_bit(NVME_NS_INVALIDATED, &ns->flags);
+	}
+}
+
 static bool nvme_path_is_disabled(struct nvme_ns *ns)
 {
 	/*
@@ -158,6 +173,7 @@ static bool nvme_path_is_disabled(struct nvme_ns *ns)
 	    ns->ctrl->state != NVME_CTRL_DELETING)
 		return true;
 	if (test_bit(NVME_NS_ANA_PENDING, &ns->flags) ||
+	    test_bit(NVME_NS_INVALIDATED, &ns->flags) ||
 	    test_bit(NVME_NS_REMOVING, &ns->flags))
 		return true;
 	return false;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5cd1fa3b8464..b72c891907f7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -467,6 +467,7 @@ struct nvme_ns {
 #define NVME_NS_DEAD     	1
 #define NVME_NS_ANA_PENDING	2
 #define NVME_NS_FORCE_RO	3
+#define NVME_NS_INVALIDATED	4
 
 	struct cdev		cdev;
 	struct device		cdev_device;
@@ -715,6 +716,7 @@ void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl);
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl);
 void nvme_mpath_stop(struct nvme_ctrl *ctrl);
 bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
+void nvme_mpath_invalidate_paths(struct nvme_ns *ns);
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
 void nvme_mpath_shutdown_disk(struct nvme_ns_head *head);
 
@@ -762,6 +764,9 @@ static inline bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
 	return false;
 }
+static inline void nvme_mpath_invalidate_paths(struct nvme_ns *ns)
+{
+}
 static inline void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 {
 }
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
