Return-Path: <SRS0=adoP=K2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF3BC4708F
	for <linux-nvme@archiver.kernel.org>; Mon, 31 May 2021 07:09:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F35611CA
	for <linux-nvme@archiver.kernel.org>; Mon, 31 May 2021 07:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F35611CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=2fE+09nvgKzqBNMOy4XexiieuQJFHKY1ZCrfAWq8XwM=; b=12FPvws0WVon1i
	Rg0Lb8PwuebeYw7gGMaGA6U8MFJz+BiILonWovux5jp2dXQQjEKLEdejSKr2J5sN0XZBEuo1zUHWI
	GOKVFx4TJ91kwyWrSUih9btHMuTMxaz+f4GNSsdInxg2CNI+qisRd7Fh9ejRPoOzJsM2hSwNDNQfb
	TrRmvSSUjdAIE0rOAnLf62PfRwwkonTvm6NbzYcCP3UcLLT10qlulyZIrwkr5qkChLM8+SqA+ng2t
	Q66t4jjzPwM0Az+2NWZfaVJlf4sLYyyEqzYjojRAQaGPuZlWeu0ZIqsR8VjEttY3GStDGOmaMXkQm
	sAdaOadQ/Inq+YKk+XWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lnc3A-00B5C2-SD; Mon, 31 May 2021 07:09:24 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lnc37-00B585-Kw
 for linux-nvme@lists.infradead.org; Mon, 31 May 2021 07:09:23 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1622444958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T+WzBUQ862egYFus08WWXAiBCQx+8c/8gulSQoYPryQ=;
 b=kZiqHHmPSDiSJKLLZpunBiQa8OZ1gqC3c0yF5Gewo8o0/7W0ztWo0UFL6GC5UMJs4Mdtes
 pAoknrwUgEBa1uQ6pKelVjFytrufWgXG+x1eN3P/HS3XWLcthrQlFK34mlfg6ouE+hmCJL
 hBG8sJV8eEYnIMVSY5xu5eoMnwWV3pE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1622444958;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=T+WzBUQ862egYFus08WWXAiBCQx+8c/8gulSQoYPryQ=;
 b=+sXJqSN4hW3LJSXyQZ4LTN0JEM/awusjD9dlb+L5O0XM+FkCRod0F23lTNAxi4lr7/WVKR
 oMbRcMVEs7sbxIDw==
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 94F9CB2E9;
 Mon, 31 May 2021 07:09:18 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] nvme-multipath: call del_gendisk() in
 nvme_mpath_check_last_path()
Date: Mon, 31 May 2021 09:09:14 +0200
Message-Id: <20210531070914.102439-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210531_000921_995828_8DFC0E0A 
X-CRM114-Status: GOOD (  10.62  )
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
this might be called from blkdev_put(). Doing so will deadlock on bd_mutex():

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

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Tested-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/multipath.c | 13 +++++++++++--
 drivers/nvme/host/nvme.h      |  9 +--------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 127a17b4c13d..22e2febf86bc 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -776,14 +776,23 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 #endif
 }
 
-void nvme_mpath_remove_disk(struct nvme_ns_head *head)
+void nvme_mpath_check_last_path(struct nvme_ns *ns)
 {
+	struct nvme_ns_head *head = ns->head;
+
 	if (!head->disk)
 		return;
-	if (head->disk->flags & GENHD_FL_UP) {
+
+	if (list_empty(&head->list) && head->disk->flags & GENHD_FL_UP) {
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
index 1f397ecba16c..8a497a420ea2 100644
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
+void nvme_mpath_check_last_path(struct nvme_ns *ns);
 
 static inline void nvme_trace_bio_complete(struct request *req)
 {
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
