Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7538CC2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A9221D95
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="211Yv+WU";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mwqTCXWi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A9221D95
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jpLP3NZ6EoSTDqbxPK6+k5IoqwM82e87GGVef6I6eCI=; b=211Yv+WUMwmKooBpe+BZUtb3M
	s/BLceQRhE8HBAa4Pl1NdUdyt4yRtgy8Ys5CIgbuwPeF8LKdBIwoPH5sb3ILk3OAeTwuE5UVBP3XL
	o/tPnTbMFeZ+kDlX5kzMWo+Ja+1aMODPQDP7MDhTaKbUvmzyoSolAj0gvGS4IwHjRe/UcBu3dVifh
	OT+Le2MY85kH96LzkUbCUSL8ETnU6kXXZQcF1GKXpiKWDPMA7l86uKxHOwCBNppOUQQ62KtuZjKx7
	vLEGgTJNU0ad02MoCw5R9CLFKqL9X2ARW2p5tsk514YyBm/vlKntDKr4e/iQ9hSKV82d83xcoKi+C
	Ha+lQGCWQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMsNK-0002Qi-UZ; Mon, 28 Sep 2020 12:35:27 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsNA-0002MP-8G
 for linux-nvme@merlin.infradead.org; Mon, 28 Sep 2020 12:35:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=4e/jF8XH3A2qhMyvTdifsd2DbEXyC1AdGwT1LcxQ0AI=; b=mwqTCXWiUevWrrSY/fF8YLy7g7
 glmcnlA90znPOJ5cbYKHl9DM7Sa/mERJ0yme34eTW2zOQDHJ+SiiKaDf9qctL+DL/Tc+2VutCJ87Z
 VxJB5J1nUOS9Gq/4elTJbEHsTciNs0GGzTxeYKO1dZAOej+V/WXG4NvWR5UvWydjZ8rFI+q4hU2Zo
 C5viF2WTwpI2mu46MhKyoJ6oomRJGrx0QzpTRSdkBQILGvRc3/L9WpYujaL6lWzudw71ew1AQJpbv
 N3DriliMS/NH9CuOLC989TjDysouxEqmm69IXi2cAjJwvNXhGdwZNguCXrxoAlEZ0kmncbHhhy2GS
 sVTdhsGg==;
Received: from [2001:4bb8:180:7b62:3a1d:d74e:d75b:5fe7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsN9-0004jJ-3Y; Mon, 28 Sep 2020 12:35:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 08/20] nvme: call nvme_identify_ns as the first thing in
 nvme_alloc_ns_block
Date: Mon, 28 Sep 2020 14:34:50 +0200
Message-Id: <20200928123502.435373-9-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200928123502.435373-1-hch@lst.de>
References: <20200928123502.435373-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Check if the namespace actually exists as the very first thing and don't
bother with any extra work if not.  This should speed up and simplify
the sequential scanning for NVMe 1.0 devices.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7b1423c7e7fc58..4a5c4d45755b55 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3887,9 +3887,12 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	char disk_name[DISK_NAME_LEN];
 	int node = ctrl->numa_node, flags = GENHD_FL_EXT_DEVT, ret;
 
+	if (nvme_identify_ns(ctrl, nsid, &id))
+		return;
+
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
-		return;
+		goto out_free_id;
 
 	ns->queue = blk_mq_init_queue(ctrl->tagset);
 	if (IS_ERR(ns->queue))
@@ -3911,13 +3914,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 	nvme_set_queue_limits(ctrl, ns->queue);
 
-	ret = nvme_identify_ns(ctrl, nsid, &id);
-	if (ret)
-		goto out_free_queue;
-
 	ret = nvme_init_ns_head(ns, nsid, id);
 	if (ret)
-		goto out_free_id;
+		goto out_free_queue;
 	nvme_set_disk_name(disk_name, ns, ctrl, &flags);
 
 	disk = alloc_disk_node(0, node);
@@ -3968,12 +3967,12 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		list_del_init(&ns->head->entry);
 	mutex_unlock(&ctrl->subsys->lock);
 	nvme_put_ns_head(ns->head);
- out_free_id:
-	kfree(id);
  out_free_queue:
 	blk_cleanup_queue(ns->queue);
  out_free_ns:
 	kfree(ns);
+ out_free_id:
+	kfree(id);
 }
 
 static void nvme_ns_remove(struct nvme_ns *ns)
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
