Return-Path: <SRS0=ZZT4=DF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5FF3C2D0A8
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DAF62158C
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Sep 2020 12:35:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jN469R9W";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YhogGeQy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DAF62158C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5OzUu4fzucJvLd7DfnLcPbLocd1TnCnrKDqHR75bk8c=; b=jN469R9WyOY61fpgry2tMfHkz
	IeGYm1EykFMnDzsCEuKhcqzEbRS3xDG4BgCGsg8eZeo1KDG4dV9ZnlCKnV8kNfdgxIPKIigDYPbIf
	QKFobdo9W4sVM00V2QBClrD9I+j6m/5XO9u77rMh4ORTdc0zxRKzIMj4ricB57plJC/SJ0n7C3/wv
	HW5W9pJ+i9zUAbwMsxMGhm7bmoLQRofMWMAnAY7G1CjRNik1/EbgynqgfCb+q4sY+15cqFRGFlUHT
	yvCWTi8x8u8vzDaWgWI9LGNMLqnrVxaipGCiAQMXhKp8lfJhr632nAhq2S7k2OlYV3Y8BfB1Gopba
	dGHOJbEcg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kMsNh-0002bL-4u; Mon, 28 Sep 2020 12:35:49 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsNI-0002PH-2c
 for linux-nvme@merlin.infradead.org; Mon, 28 Sep 2020 12:35:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=jlV5sSof+2jZ5wFRZ0gVuAzHFu7HrFKkgGIBCc/eiIY=; b=YhogGeQytUz1RmxLZHIioWQPnp
 Ck6lOx2W0v1kxRicm83ugprNb2/6Ejkx03MILwo5hsBtA6QGppLtkQgPVZUfWxnCmZof4H7p/oZYr
 JuljsxG3dKCgjheNxDBODdR1ENOLOz03NTdVVc/nFcPWb5gLHk/h/jLpMNGcbKbys0QbZDxN+RzKF
 g1vinRVch/pYmU/h66T8Zx2dioyAUFHR3xzuZbrIfnFRJ6Y3yG2EYZLSCj8zEJQNPfzqXNxHVNEQX
 L1XCeJfpNpR6BDvkLc1uNtqdaGrfGb4JxA2Lzjjl9Nqk+yXaSPY/55KFi0GqfxijCmz5nPP+dE6TY
 EH0YnJQg==;
Received: from [2001:4bb8:180:7b62:3a1d:d74e:d75b:5fe7] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kMsNG-0004lf-SO; Mon, 28 Sep 2020 12:35:23 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 13/20] nvme: set the queue limits in nvme_update_ns_info
Date: Mon, 28 Sep 2020 14:34:55 +0200
Message-Id: <20200928123502.435373-14-hch@lst.de>
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

Only set the queue limits once we have the real block size.  This also
updates the limits on a rescan if needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 46 ++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 910198c3e0bbd1..bb630d5fcb9647 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2010,6 +2010,26 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 	return 0;
 }
 
+static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
+		struct request_queue *q)
+{
+	bool vwc = false;
+
+	if (ctrl->max_hw_sectors) {
+		u32 max_segments =
+			(ctrl->max_hw_sectors / (NVME_CTRL_PAGE_SIZE >> 9)) + 1;
+
+		max_segments = min_not_zero(max_segments, ctrl->max_segments);
+		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
+		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
+	}
+	blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
+	blk_queue_dma_alignment(q, 7);
+	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
+		vwc = true;
+	blk_queue_write_cache(q, vwc, vwc);
+}
+
 static void nvme_update_disk_info(struct gendisk *disk,
 		struct nvme_ns *ns, struct nvme_id_ns *id)
 {
@@ -2130,6 +2150,7 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 
 	blk_mq_freeze_queue(ns->disk->queue);
 	ns->lba_shift = id->lbaf[lbaf].ds;
+	nvme_set_queue_limits(ctrl, ns->queue);
 
 	switch (ns->head->ids.csi) {
 	case NVME_CSI_NVM:
@@ -2495,26 +2516,6 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_shutdown_ctrl);
 
-static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
-		struct request_queue *q)
-{
-	bool vwc = false;
-
-	if (ctrl->max_hw_sectors) {
-		u32 max_segments =
-			(ctrl->max_hw_sectors / (NVME_CTRL_PAGE_SIZE >> 9)) + 1;
-
-		max_segments = min_not_zero(max_segments, ctrl->max_segments);
-		blk_queue_max_hw_sectors(q, ctrl->max_hw_sectors);
-		blk_queue_max_segments(q, min_t(u32, max_segments, USHRT_MAX));
-	}
-	blk_queue_virt_boundary(q, NVME_CTRL_PAGE_SIZE - 1);
-	blk_queue_dma_alignment(q, 7);
-	if (ctrl->vwc & NVME_CTRL_VWC_PRESENT)
-		vwc = true;
-	blk_queue_write_cache(q, vwc, vwc);
-}
-
 static int nvme_configure_timestamp(struct nvme_ctrl *ctrl)
 {
 	__le64 ts;
@@ -3922,12 +3923,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	ns->queue->queuedata = ns;
 	ns->ctrl = ctrl;
-
 	kref_init(&ns->kref);
-	ns->lba_shift = 9; /* set to a default value for 512 until disk is validated */
-
-	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
-	nvme_set_queue_limits(ctrl, ns->queue);
 
 	ret = nvme_init_ns_head(ns, nsid, id);
 	if (ret)
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
