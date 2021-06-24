Return-Path: <SRS0=KdjD=LS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE02C48BDF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 08:57:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0890561248
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 08:57:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0890561248
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=CneqN/ZMe1l5zzfGVs7zJMJZwhbot//+S7rUdqVXhC0=; b=RUspLkth/Xe9x3
	d465amc4oTd/8KG6IjBqAHHMjYuHMCAJVMR3scYeE+u9wDDkOePyoenQsS+/65VPY246Gk9ehnorB
	sZja8Wwxg4Jf9phskj6UNIc9xtqkcUVqTuVn6e7elJzUkc8aq2lC1b4PZXIghMy3Dif0fwVwUsnYd
	S/deC0In8c3+ZyxNKIP1QIuMaqZJY+ggreMJDSE5OINCQzlhhkcR5HubolXklhW42rk0dN6/p4jMm
	NJxXBoZ8WaG81rwEoS17J7/jOTkp/KVgFzN0MW5IKIkiSsYmy+QZBXlnlDpKnObixis0bDkRfzMLA
	qleWufwZtFjFq1VZUqiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwLAM-00DaBj-Vc; Thu, 24 Jun 2021 08:56:55 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwL9K-00DZVm-5o
 for linux-nvme@lists.infradead.org; Thu, 24 Jun 2021 08:55:51 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id BF4061FD66;
 Thu, 24 Jun 2021 08:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624524948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=f/7G+ykeEas98tuO3+X71ZIl6W1U/XnXWv8XbnKEUNg=;
 b=QMU3QfDtnt4CXhQz8fyxIS7HRCnofCl/VNx9MW2tFMZXx+RP4FztqlwsSdIS2cuyeRH3Ot
 4mvn3k+wdw6Dx0tH+4fDM+1Ds1EPIgAgAVyRD7GTHBnKhXgiJiRIEl+klORTJghBJghELT
 o7+s79lNP5BZUPhkShZlwAgTlRglAlE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624524948;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=f/7G+ykeEas98tuO3+X71ZIl6W1U/XnXWv8XbnKEUNg=;
 b=F3VbjIieHQXaPp0VewlXm+iqWZuRCbIq4T1Twtt3wN2uac4k+sNvhOs229aq8QSIvZzWQJ
 GwXnlTkwqpws+fBQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 90921A3BB2;
 Thu, 24 Jun 2021 08:55:48 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 7A2FC51708E7; Thu, 24 Jun 2021 10:55:48 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv8] nvme: fix refcounting imbalance when all paths are down
Date: Thu, 24 Jun 2021 10:55:46 +0200
Message-Id: <20210624085546.123824-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210624_015550_412719_1717BBCA 
X-CRM114-Status: GOOD (  15.95  )
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

When the last path to a ns_head drops the current code
removes the ns_head from the subsystem list, but will only
delete the disk itself if the last reference to the ns_head
drops. This is causing an refcounting imbalance eg when
applications have a reference to the disk, as then they'll
never get notified that the disk is in fact dead.
This patch moves the call 'del_gendisk' into nvme_mpath_check_last_path(),
ensuring that the disk can be properly removed and applications get the
appropriate notifications.

Changes to v7:
- Move the list_del() call outside of nvme_mpath_check_last_path()
Changes to v6:
- Move the list_del() into nvme_mpath_check_last_path()
- Drop the tests for GENHD_FL_UP
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
 drivers/nvme/host/core.c      | 14 +++++++++++---
 drivers/nvme/host/multipath.c | 11 +++++++++--
 drivers/nvme/host/nvme.h      | 11 ++---------
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c7ef0b6684b5..b7f25cdf91c8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3813,6 +3813,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 
 static void nvme_ns_remove(struct nvme_ns *ns)
 {
+	bool last_path = false;
+
 	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
 		return;
 
@@ -3821,8 +3823,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	mutex_lock(&ns->ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
-	if (list_empty(&ns->head->list))
-		list_del_init(&ns->head->entry);
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	synchronize_rcu(); /* guarantee not available in head->list */
@@ -3842,7 +3842,15 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	list_del_init(&ns->list);
 	up_write(&ns->ctrl->namespaces_rwsem);
 
-	nvme_mpath_check_last_path(ns);
+	/* Synchronize with nvme_init_ns_head() */
+	mutex_lock(&ns->head->subsys->lock);
+	if (list_empty(&ns->head->list)) {
+		list_del_init(&ns->head->entry);
+		last_path = true;
+	}
+	mutex_unlock(&ns->head->subsys->lock);
+	if (last_path)
+		nvme_mpath_check_last_path(ns->head);
 	nvme_put_ns(ns);
 }
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 23573fe3fc7d..04307638ffe7 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -771,20 +771,27 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 #endif
 }
 
-void nvme_mpath_remove_disk(struct nvme_ns_head *head)
+void nvme_mpath_check_last_path(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
+	kblockd_schedule_work(&head->requeue_work);
 	if (head->disk->flags & GENHD_FL_UP) {
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
 	flush_work(&head->requeue_work);
 	blk_cleanup_queue(head->disk->queue);
-	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
+	if (!test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
 		/*
 		 * if device_add_disk wasn't called, prevent
 		 * disk release to put a bogus reference on the
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 75420ceacc10..6b1caabe861b 100644
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
