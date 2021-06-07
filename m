Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF22DC4743F
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 10:32:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C370B61260
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 10:32:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C370B61260
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+JbfP9whYawxtkriKljcwP9/4MtNt69r01d4R5Ql3Wk=; b=rMo5YytKlH0Dpz
	zFtoEukzoFF3PhSu4yuv/VKLOLgpqy7RCp9VRoOrn7BMZYm0Lk5k4KxYXfpTOfyZoxyWEcQ3OW1aZ
	rEG8MtbZg0t/LL5fkhEB8UQ9zrlQ3l9Q1RfVmpio/QwHa6WPgvo9uGPphbjBpYY9qoIcSgZpfxO/s
	XaSOhs8kt9bmuhAd5301CM4rFEFzj0YJ0f676pjMk/04d2JjzLhxBAoA7KUwv09XcIKcxWVSLRrdv
	L3JPvfymFqoarnoAQ5brPY9n/x1mr1YFGEIDz9kru39vB4OuLG9yDFEeTmu7sN5hqvrPkYPw7jsWu
	q97kZMtt2BWlDPpoj02g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqCXw-002wCl-Px; Mon, 07 Jun 2021 10:31:52 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqBwZ-002jD4-G1
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 09:53:19 +0000
Received: from relay2.suse.de (unknown [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0FFF71FDC5;
 Mon,  7 Jun 2021 09:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623059594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NUI9KjImzrONDX5eqH7NPNpw7TGJjM9zhrkmG709/os=;
 b=Jb6DPJ96/UMhpG80PPPbs48sdqkvT2Swoo64z9OCFmOfP9LiqjeeP7n2EDqkYnjBOYTzJo
 RNgTJdccpRNzYNDDCLDkLWL5DTFrg3wBiC0iFtuBDUXRGG8iN+XjVY9FhC+4mKal5MkPqo
 TXax40VQNjxvJ6QLifHjlst7vI83ViA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623059594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NUI9KjImzrONDX5eqH7NPNpw7TGJjM9zhrkmG709/os=;
 b=I9FPiA2GMddc+UGbNnu5P54WOx/n285gRg/mWhefTXNJmrxMP/3JmGXrj+TRtFX9NJt6EJ
 w8x78w8nwx1G73Ag==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id D40BBA3B8A;
 Mon,  7 Jun 2021 09:53:13 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 07484516FDFE; Mon,  7 Jun 2021 11:53:13 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 Yi Zhang <yi.zhang@redhat.com>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2] nvme-multipath: call del_gendisk() in
 nvme_mpath_check_last_path()
Date: Mon,  7 Jun 2021 11:53:10 +0200
Message-Id: <20210607095310.131310-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_025315_723280_BC0603DD 
X-CRM114-Status: GOOD (  11.65  )
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

We cannot call del_gendisk() during the final nvme_put_ns_head(), as
this might be called from blkdev_put(). Doing so will deadlock on
bd_mutex:

[ 1108.529767]  __mutex_lock.constprop.0+0x2a4/0x470
[ 1108.534472]  ? __kernfs_remove.part.0+0x174/0x1f0
[ 1108.539178]  ? kernfs_remove_by_name_ns+0x5c/0x90
[ 1108.543885]  del_gendisk+0x99/0x230
[ 1108.547378]  nvme_mpath_remove_disk+0x97/0xb0 [nvme_core]
[ 1108.552787]  nvme_put_ns_head+0x2a/0xb0 [nvme_core]
[ 1108.557664]  __blkdev_put+0x115/0x160
[ 1108.561339]  blkdev_put+0x4c/0x130
[ 1108.564745]  blkdev_close+0x22/0x30
[ 1108.568238]  __fput+0x94/0x240

So call 'del_gendisk()' when checking if the last path has been removed
to avoid this deadlock.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c | 12 ++++++++++--
 drivers/nvme/host/nvme.h      | 11 ++---------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cb1a76a3d42a..41a8c1de7e15 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3856,7 +3856,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
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
