Return-Path: <SRS0=k+Rq=MI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E75C07E95
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 11:31:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B273D613FB
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 11:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B273D613FB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=S+TDsvZ9BVf79ogKQD/PnreLuHbmkvKUYRAVkavHgms=; b=3Fy6TsM414Nm+U
	SG7aWvPEUjYDyd0AiEffw5CJ+WDZnS9P0XFiziebDu+FWioKxJBlYvnWLD6NrUTEh/+yt2fwPxqLR
	AXCVc9aWK9vKAWNbCoSZvb0nBZmPRkmHdBFKwBRyU9zmNQqJLZUSv6N7EXaBeK7SaIEZg8xoml7TA
	KZSMpjun2/RaQTwDT3q9p6roJDTqzuvg0/oR+pQL69rvTLMxdMOO/ai9NN5X9zgOPrc/oMNDqp2K2
	6/b8ykXL2/L1wYWGxM7+JlHTSw13VHbRQ41ta3lZPe/Us06WUX0rTdlO6P0onUaMACUDahmGYzn4K
	DjozaBv7gssBezYEd3SQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4M3H-004IYV-8o; Fri, 16 Jul 2021 11:30:43 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4M3E-004IYA-0p
 for linux-nvme@lists.infradead.org; Fri, 16 Jul 2021 11:30:41 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id B1B4B1FD29;
 Fri, 16 Jul 2021 11:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626435038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=d8Lb4Rpp3gpgK3T4SgYDJPDT9S8eQJc+qttTrDqczyI=;
 b=iksAAP4Lzya4wYg0Pks1eVbfNuNhYDskgnZDOemh5a9unU4vFctW//w/ISZhyz2u38r58X
 AB4vbvIe+xRD/e0wXH/gpBi3wOoqcs+2bDpsgLrTP/LvogTXq9mQaGvnrW/ph+FpzESsCr
 YvKY3fbm8Nzj2K5RsqSuvKhLJwLQmPs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626435038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=d8Lb4Rpp3gpgK3T4SgYDJPDT9S8eQJc+qttTrDqczyI=;
 b=QF8cbiuGxvRgh/uRFkNtryJjAfQkJxohbMU+UTa+T1AjBlqXhczLMVjb5/EIuxrXK4wZEw
 jb2na4IkUdDi+dAQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 8742CA3BB1;
 Fri, 16 Jul 2021 11:30:38 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 78921517161E; Fri, 16 Jul 2021 13:30:38 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCHv8] nvme: fix refcounting imbalance when all paths are down
Date: Fri, 16 Jul 2021 13:30:35 +0200
Message-Id: <20210716113035.45885-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210716_043040_261239_A0A50735 
X-CRM114-Status: GOOD (  15.55  )
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

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
Changes to v8:
- Rebase to 5.14
- Rename nvme_mpath_check_last_path() to nvme_mpath_shutdown_disk()
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

 drivers/nvme/host/core.c      | 14 +++++++++++---
 drivers/nvme/host/multipath.c |  9 ++++++++-
 drivers/nvme/host/nvme.h      | 11 ++---------
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 11779be42186..17c05a4595f0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3807,6 +3807,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 
 static void nvme_ns_remove(struct nvme_ns *ns)
 {
+	bool last_path = false;
+
 	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
 		return;
 
@@ -3815,8 +3817,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	mutex_lock(&ns->ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
-	if (list_empty(&ns->head->list))
-		list_del_init(&ns->head->entry);
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	synchronize_rcu(); /* guarantee not available in head->list */
@@ -3836,7 +3836,15 @@ static void nvme_ns_remove(struct nvme_ns *ns)
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
+		nvme_mpath_shutdown_disk(ns->head);
 	nvme_put_ns(ns);
 }
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0ea5298469c3..3f32c5e86bfc 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -760,14 +760,21 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 #endif
 }
 
-void nvme_mpath_remove_disk(struct nvme_ns_head *head)
+void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
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
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 18ef8dd03a90..5cd1fa3b8464 100644
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
+void nvme_mpath_shutdown_disk(struct nvme_ns_head *head);
 
 static inline void nvme_trace_bio_complete(struct request *req)
 {
@@ -772,7 +765,7 @@ static inline bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
 static inline void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 {
 }
-static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
+static inline void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
 {
 }
 static inline void nvme_trace_bio_complete(struct request *req)
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
