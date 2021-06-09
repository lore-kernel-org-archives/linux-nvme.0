Return-Path: <SRS0=Wy35=LD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB95C48BD1
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 16:19:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3077D61375
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Jun 2021 16:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3077D61375
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=s+WZ+VHGT2DafwD7sHiHUtkIkvRxZehu4GiTvBU6/zk=; b=f793Ua/MkyT8cS
	F/2obP6X1APhYmcv1lwYJ9ETxbQWc9k3i6BVfwOOMx984TwO24NYgVhPBGkSWHXW5fHeW6TmbxRhk
	2uqw7Zosbfz1Rm/ayDekr6tctx9CHFNDxLdx4TIEIiPloEjrI7CH/ibqywhdJpFIcoDkMQkZ6dLPK
	mQ/4ekJY2u6M45DtfLs/qRdkrGvWyTKaoTmWvpkmT+3vIzU0HLsJ6UA7jc7LskJ7zDsedNJHKQvbJ
	WZJR0+RO52s2euynEuCKNVxhFHXrBQavOYu7i/AoUx5OAJKHBYFBfYCromKqQ8Rzhwvm0w2KusVZF
	Zdq2kuSZ5ovgzOnCrveA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lr0vY-00ErxE-5J; Wed, 09 Jun 2021 16:19:36 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqzht-00ETDI-F9
 for linux-nvme@lists.infradead.org; Wed, 09 Jun 2021 15:01:27 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 016EE219B1;
 Wed,  9 Jun 2021 15:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623250882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+uMG9FVWzLbrx2iBrVhmrm5C89hBkZ5askVuidmwVpE=;
 b=pMRnb2J9IAdg0UgoPnVgie95Wiqk5doJso1HWsk4oRuROmqYN3DRqLgEoA8XpxG0+jUzku
 aKZj75VFl1N/4Oqnu0vk1Z4esWeiZnlh90PfMkuKm9mNRzkvBXRKUBWTjvKawtU6S0t8D5
 XyHtiTpALXF1CLqqf2SJQE07Tv50a14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623250882;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+uMG9FVWzLbrx2iBrVhmrm5C89hBkZ5askVuidmwVpE=;
 b=in6PA+Aw63tVm00TbKTB8LXFyNR/4+QnlH3tnlItqtsruPkKZApclN9P8+EEVEjBfBsY/+
 Wn0ZQwKExIc+lgAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id C613BA3B90;
 Wed,  9 Jun 2021 15:01:21 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 035A1516FF9A; Wed,  9 Jun 2021 17:01:20 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv6] nvme: allow to re-attach namespaces after all paths are down
Date: Wed,  9 Jun 2021 17:01:18 +0200
Message-Id: <20210609150118.130650-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210609_080125_709205_73608080 
X-CRM114-Status: GOOD (  17.08  )
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
subsystem if the reference count drops to zero. That cleans up
reference counting, and allows us to call del_gendisk() once the last
path is removed (as then the ns_head should be removed anyway).
As this introduces a (theoretical) race condition where I/O might have
been requeued before the last path went down we also should be checking
if the gendisk is still present in nvme_ns_head_submit_bio(),
and failing I/O if so.

Changes to v5:
- Synchronize between nvme_init_ns_head() and nvme_mpath_check_last_path()
- Check for removed gendisk in nvme_ns_head_submit_bio()
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
 drivers/nvme/host/core.c      |  9 ++++-----
 drivers/nvme/host/multipath.c | 30 +++++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h      | 11 ++---------
 3 files changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 177cae44b612..6d7c2958b3e2 100644
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
@@ -3806,8 +3809,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
-	if (list_empty(&ns->head->list))
-		list_del_init(&ns->head->entry);
 	mutex_unlock(&ctrl->subsys->lock);
 	nvme_put_ns_head(ns->head);
  out_free_queue:
@@ -3828,8 +3829,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	mutex_lock(&ns->ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
-	if (list_empty(&ns->head->list))
-		list_del_init(&ns->head->entry);
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	synchronize_rcu(); /* guarantee not available in head->list */
@@ -3849,7 +3848,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	list_del_init(&ns->list);
 	up_write(&ns->ctrl->namespaces_rwsem);
 
-	nvme_mpath_check_last_path(ns);
+	nvme_mpath_check_last_path(ns->head);
 	nvme_put_ns(ns);
 }
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 23573fe3fc7d..31153f6ec582 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -266,6 +266,8 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 	int node = numa_node_id();
 	struct nvme_ns *ns;
 
+	if (!(head->disk->flags & GENHD_FL_UP))
+		return NULL;
 	ns = srcu_dereference(head->current_path[node], &head->srcu);
 	if (unlikely(!ns))
 		return __nvme_find_path(head, node);
@@ -281,6 +283,8 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 {
 	struct nvme_ns *ns;
 
+	if (!(head->disk->flags & GENHD_FL_UP))
+		return false;
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
 		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
 			continue;
@@ -771,20 +775,36 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 #endif
 }
 
-void nvme_mpath_remove_disk(struct nvme_ns_head *head)
+void nvme_mpath_check_last_path(struct nvme_ns_head *head)
 {
+	bool last_path = false;
 	if (!head->disk)
 		return;
-	if (head->disk->flags & GENHD_FL_UP) {
-		nvme_cdev_del(&head->cdev, &head->cdev_device);
-		del_gendisk(head->disk);
+
+	/* Synchronize with nvme_init_ns_head() */
+	mutex_lock(&head->subsys->lock);
+	if (list_empty(&head->list))
+		last_path = true;
+	mutex_unlock(&head->subsys->lock);
+	if (last_path) {
+		kblockd_schedule_work(&head->requeue_work);
+		if (head->disk->flags & GENHD_FL_UP) {
+			nvme_cdev_del(&head->cdev, &head->cdev_device);
+			del_gendisk(head->disk);
+		}
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
 	flush_work(&head->requeue_work);
 	blk_cleanup_queue(head->disk->queue);
-	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
+	if (!test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
 		/*
 		 * if device_add_disk wasn't called, prevent
 		 * disk release to put a bogus reference on the
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
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
