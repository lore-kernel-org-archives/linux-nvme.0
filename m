Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42834C47094
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 13:35:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E126461153
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 13:35:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E126461153
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=qSJJvoDQ/In8YS63pUNotBj6de/aFRtLWgBM38yca2M=; b=g1OREaIOHgfdGJ
	4ESo4kvFLIGeiytXDXJBS4Xb+niUPMmeQESvIRuKHPsEfMRh3Z2AR4yhgLt4sVWOrpKyynDXgm30p
	cNT4Tbu6i0g7wuRqZ+ksW7F//Me3BeAO0ONMYFP8wLZo+aevJFlgtVKUppDDcAFd65PWdbLjKu28p
	frttur85os5hTmgvhvNeKGs0qTJNbOMlEeEt/Q3sCqzFuuwoDK2UP3ZN/KmWTqKd/cKmXZf5T4Q1b
	2vKms7huCvnzU543E5jO3wbw+5cvQHV91rK4bz2Q1XokNJTv1q62yY360HrFBBn9+BweoVMFWbqW9
	oxkE+r9oWcaEfVEGiNdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqFOy-003pZ5-NS; Mon, 07 Jun 2021 13:34:48 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqFOs-003pWM-QZ
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 13:34:47 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id E074A1FDA1;
 Mon,  7 Jun 2021 13:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623072880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WxbKRHBRTkta3Rin2bIqrmKQLTSqdNZovxU5DUk/HPk=;
 b=zYSp3HrDVBN0yGE0Y+SJ8m7jPdHim1U2wrHax5DZFPb2c8PZ2awPqpivCVNyEOBSnjUFtP
 hbPmGGdbj22vF6lF1PNMKIZzmpyFKw2MP8VxSoxhCoETLcanJvJWXhO5u7CaEJr17eZuaM
 09237n4J5q+H4uqndHEfseGPU/6a8uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623072880;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WxbKRHBRTkta3Rin2bIqrmKQLTSqdNZovxU5DUk/HPk=;
 b=DasFgGMjxG08Gd1rJybVqNYWf+NMCE5nTcIC16nK9zED/Lyg5g/ZePedt8+gxaghEFRwS/
 L6CVIG480RPq8vBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id B48F5A3B83;
 Mon,  7 Jun 2021 13:34:40 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 9BDD0516FE16; Mon,  7 Jun 2021 15:34:40 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv5] nvme: allow to re-attach namespaces after all paths are down
Date: Mon,  7 Jun 2021 15:34:35 +0200
Message-Id: <20210607133435.138525-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_063443_035410_A1A1E05A 
X-CRM114-Status: GOOD (  14.72  )
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

We should only remove the ns head from the list of heads per
subsystem if the reference count drops to zero. Removing it
at the start of nvme_ns_remove() will prevent us from reattaching
the namespace to the correct ns head once a path becomes available
again.

Changes to v4:
- Call del_gendisk() in nvme_mpath_check_last_path() to avoid deadlock
Changes to v3:
- Simplify if() clause to detect duplicate namespaces
Changes to v2:
- Drop memcpy() statement
Changes to v1:
- Always check NSIDs after reattach

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c      | 13 +++++++++----
 drivers/nvme/host/multipath.c | 12 ++++++++++--
 drivers/nvme/host/nvme.h      | 11 ++---------
 3 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 177cae44b612..065edf20bef4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -566,6 +566,9 @@ static void nvme_free_ns_head(struct kref *ref)
 	struct nvme_ns_head *head =
 		container_of(ref, struct nvme_ns_head, ref);
 
+	mutex_lock(&head->subsys->lock);
+	list_del_init(&head->entry);
+	mutex_unlock(&head->subsys->lock);
 	nvme_mpath_remove_disk(head);
 	ida_simple_remove(&head->subsys->ns_ida, head->instance);
 	cleanup_srcu_struct(&head->srcu);
@@ -3669,7 +3672,11 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 		head->shared = is_shared;
 	} else {
 		ret = -EINVAL;
-		if (!is_shared || !head->shared) {
+		/*
+		 * If multipath is enabled we might hit an ns head with no
+		 * paths, but that doesn't indicate it's a shared namespace.
+		 */
+		if (!list_empty(&head->list) && (!is_shared || !head->shared)) {
 			dev_err(ctrl->device,
 				"Duplicate unshared namespace %d\n", nsid);
 			goto out_put_ns_head;
@@ -3828,8 +3835,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	mutex_lock(&ns->ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
-	if (list_empty(&ns->head->list))
-		list_del_init(&ns->head->entry);
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	synchronize_rcu(); /* guarantee not available in head->list */
@@ -3849,7 +3854,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	list_del_init(&ns->list);
 	up_write(&ns->ctrl->namespaces_rwsem);
 
-	nvme_mpath_check_last_path(ns);
+	nvme_mpath_check_last_path(ns->head);
 	nvme_put_ns(ns);
 }
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 127a17b4c13d..de74650cdb2d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -776,14 +776,22 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 #endif
 }
 
-void nvme_mpath_remove_disk(struct nvme_ns_head *head)
+void nvme_mpath_check_last_path(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
-	if (head->disk->flags & GENHD_FL_UP) {
+
+	if (list_empty(&head->list) && (head->disk->flags & GENHD_FL_UP)) {
+		kblockd_schedule_work(&head->requeue_work);
 		nvme_cdev_del(&head->cdev, &head->cdev_device);
 		del_gendisk(head->disk);
 	}
+}
+
+void nvme_mpath_remove_disk(struct nvme_ns_head *head)
+{
+	if (!head->disk)
+		return;
 	blk_set_queue_dying(head->disk->queue);
 	/* make sure all pending bios are cleaned up */
 	kblockd_schedule_work(&head->requeue_work);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1f397ecba16c..812fc1d273e3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -716,14 +716,7 @@ void nvme_mpath_uninit(struct nvme_ctrl *ctrl);
 void nvme_mpath_stop(struct nvme_ctrl *ctrl);
 bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
-
-static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
-{
-	struct nvme_ns_head *head = ns->head;
-
-	if (head->disk && list_empty(&head->list))
-		kblockd_schedule_work(&head->requeue_work);
-}
+void nvme_mpath_check_last_path(struct nvme_ns_head *head);
 
 static inline void nvme_trace_bio_complete(struct request *req)
 {
@@ -772,7 +765,7 @@ static inline bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
 static inline void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 {
 }
-static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
+static inline void nvme_mpath_check_last_path(struct nvme_ns_head *head)
 {
 }
 static inline void nvme_trace_bio_complete(struct request *req)
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
