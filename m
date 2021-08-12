Return-Path: <SRS0=ZjMq=ND=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19E77C4338F
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Aug 2021 07:50:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89CC560FC4
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Aug 2021 07:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89CC560FC4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XrWQM8sxSJVR6ifCZ582BM+M1l3dEB8BCdJNNYdL1SQ=; b=HdqPyqrozVKCoX
	qvpO5DRHHIiLuJt/HQP0mfZJ1NRNIUh8UpUaPEPkKi+8Okiyr01PipW8ILtTb2VxAxSYH9dGme2Mf
	AiJ68siyClTUiwL2K4HB0YtWl9A8scPB1usk0KUH8R1hjFMc943+UdL4zqn1yubpwFnVfBSj4+RsY
	G0MHtBcQaB5Ffq8Xni/X+JAPk+JLmMwO5T36sTgFCe/M8CIGo6hMjGpw6386KpdpyqwiueqCT1B20
	CoYTRwZE0+uzgK7OtkbAom3A4No5Oe9DK7eWbVbGFm5ChRi1CMgpUdyFJ/aha3iRqTmENmBEUgl5c
	6Ud/MChGfxufJmkhDsoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mE5Tl-008z9h-As; Thu, 12 Aug 2021 07:50:17 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mE5Rp-008yoS-0b
 for linux-nvme@bombadil.infradead.org; Thu, 12 Aug 2021 07:48:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=qrqINKx/pIKIjST1oisE3ozmHc4lciwrBwhfjJb45VA=; b=R1IGYmi8e5eCfOeb8AN5WSab6n
 nqmIzXkv8UqB/uVv1swxzSdKV4Q5M6g6OhJ92ZtqbNGNd5LhKZQviWOyNtmiTEJr3sgvs16tBVblS
 zoIomFfBWgEp4R2YV8/HBnYuHKRB//87kCvegZNLGBozB8d78T3LxJLKwhXULA0hz6DlIc/nxM4F8
 aBIcsF8cKaXMBRL7L7zSkb9uqiydH0twieuZAPvdgDK7bJYVDygVzoP9v7JvGiN/49GwzyMSvQ0dQ
 D59LNRpQQPrC+Klkwq+qAT++airvREu+BVz1KjKdQZe7C/5CwrSbMHu7dBPX9evIdL9LVhNss8PNc
 LkgtUZLQ==;
Received: from [2001:4bb8:184:6215:d7d:1904:40de:694d] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mE5R5-00EIoG-K9; Thu, 12 Aug 2021 07:47:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Doug Gilbert <dgilbert@interlog.com>,
 =?UTF-8?q?Kai=20M=C3=A4kisara?= <Kai.Makisara@kolumbus.fi>,
 Luis Chamberlain <mcgrof@kernel.org>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org
Subject: [PATCH 1/8] nvme: use blk_mq_alloc_disk
Date: Thu, 12 Aug 2021 09:46:35 +0200
Message-Id: <20210812074642.18592-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210812074642.18592-1-hch@lst.de>
References: <20210812074642.18592-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

Switch to use the blk_mq_alloc_disk helper for allocating the
request_queue and gendisk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cb12d8b94e82..1fd199a8168f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3729,9 +3729,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (!ns)
 		goto out_free_id;
 
-	ns->queue = blk_mq_init_queue(ctrl->tagset);
-	if (IS_ERR(ns->queue))
+	disk = blk_mq_alloc_disk(ctrl->tagset, ns);
+	if (IS_ERR(disk))
 		goto out_free_ns;
+	disk->fops = &nvme_bdev_ops;
+	disk->private_data = ns;
+
+	ns->disk = disk;
+	ns->queue = disk->queue;
 
 	if (ctrl->opts && ctrl->opts->data_digest)
 		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, ns->queue);
@@ -3740,20 +3745,12 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
 		blk_queue_flag_set(QUEUE_FLAG_PCI_P2PDMA, ns->queue);
 
-	ns->queue->queuedata = ns;
 	ns->ctrl = ctrl;
 	kref_init(&ns->kref);
 
 	if (nvme_init_ns_head(ns, nsid, ids, id->nmic & NVME_NS_NMIC_SHARED))
-		goto out_free_queue;
+		goto out_cleanup_disk;
 
-	disk = alloc_disk_node(0, node);
-	if (!disk)
-		goto out_unlink_ns;
-
-	disk->fops = &nvme_bdev_ops;
-	disk->private_data = ns;
-	disk->queue = ns->queue;
 	/*
 	 * Without the multipath code enabled, multiple controller per
 	 * subsystems are visible as devices and thus we cannot use the
@@ -3762,15 +3759,14 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (!nvme_mpath_set_disk_name(ns, disk->disk_name, &disk->flags))
 		sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
 			ns->head->instance);
-	ns->disk = disk;
 
 	if (nvme_update_ns_info(ns, id))
-		goto out_put_disk;
+		goto out_unlink_ns;
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		if (nvme_nvm_register(ns, disk->disk_name, node)) {
 			dev_warn(ctrl->device, "LightNVM init failure\n");
-			goto out_put_disk;
+			goto out_unlink_ns;
 		}
 	}
 
@@ -3789,10 +3785,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	kfree(id);
 
 	return;
- out_put_disk:
-	/* prevent double queue cleanup */
-	ns->disk->queue = NULL;
-	put_disk(ns->disk);
+
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
@@ -3800,8 +3793,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 		list_del_init(&ns->head->entry);
 	mutex_unlock(&ctrl->subsys->lock);
 	nvme_put_ns_head(ns->head);
- out_free_queue:
-	blk_cleanup_queue(ns->queue);
+ out_cleanup_disk:
+	blk_cleanup_disk(disk);
  out_free_ns:
 	kfree(ns);
  out_free_id:
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
