Return-Path: <SRS0=LwVW=6L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 921B8C4CECC
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2020 18:54:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A3C3208FE
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2020 18:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="WoXIWjbQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="brT4dH7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A3C3208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Pakb8oP7/2RkWqkw4yH99oc0oaHgIy34mfWHphB6wLQ=; b=WoXIWjbQJIvsjl
	bDtP1IhhzvVhWzKQPzK3kegT8LmAGFKwSaZ7NoCchaEiphPV6iBOW1mY6GNsgf75aSf3nVPYryXCk
	HNjvfkZaWX8ZeuYpPSCVzLrGmoDPZFAAIR05BNhtwYiLXTTnKyeIzzyI98diskOnfmMR/S/ChIMjH
	/IlKU8owNToO2L/TD9XTLWSoWaVNKQbpBonrJl5Io8A6n63Wrqd5MxiBa0kt6YxyRSUErio8Y/Y65
	EemglMUqdbyMzOUbZjL8//txL11O+0kf4xRMu+zdB6oruMQReO0lrYf1AH5XzL49Aovc2IfpvTeTc
	UDa0RpoYpoK+OUNAO4RQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jT8u6-0005AQ-3q; Mon, 27 Apr 2020 18:54:54 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jT8u3-00059V-0E
 for linux-nvme@lists.infradead.org; Mon, 27 Apr 2020 18:54:52 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 0218620775;
 Mon, 27 Apr 2020 18:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588013690;
 bh=tbZCnuRBKlyP2Fl6SOSgnsqjhNQyVhSDD2byO5UNCrU=;
 h=From:To:Cc:Subject:Date:From;
 b=brT4dH7Vg1NoW9MTzdN88kLBfgWe28kFSJPzEbNEYcTeQuMB9O4vFVORXHTNgpbbD
 PGnimT0lD3y1mR+gZ0yNTT8epdn9d+y9oG3ezpDXfqiTvp93X5OHfa5zxySvoB/tWL
 5h6Ajm1zrlU1WVArAiLvbfy56BCvxzaMlSV+4n1Q=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH] nvme-pci: remove last_sq_tail
Date: Mon, 27 Apr 2020 11:54:46 -0700
Message-Id: <20200427185446.2139232-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200427_115451_063363_D4C09DB8 
X-CRM114-Status: GOOD (  12.03  )
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
Cc: Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The nvme driver does not have enough tags to wrap the queue, and blk-mq
will no longer call commit_rqs() when there are no new submissions to
notify.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4e79e412b276..8ebcf40f04fe 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -173,7 +173,6 @@ struct nvme_queue {
 	u16 q_depth;
 	u16 cq_vector;
 	u16 sq_tail;
-	u16 last_sq_tail;
 	u16 cq_head;
 	u16 qid;
 	u8 cq_phase;
@@ -446,24 +445,11 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 	return 0;
 }
 
-/*
- * Write sq tail if we are asked to, or if the next command would wrap.
- */
-static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
+static inline void nvme_write_sq_db(struct nvme_queue *nvmeq)
 {
-	if (!write_sq) {
-		u16 next_tail = nvmeq->sq_tail + 1;
-
-		if (next_tail == nvmeq->q_depth)
-			next_tail = 0;
-		if (next_tail != nvmeq->last_sq_tail)
-			return;
-	}
-
 	if (nvme_dbbuf_update_and_check_event(nvmeq->sq_tail,
 			nvmeq->dbbuf_sq_db, nvmeq->dbbuf_sq_ei))
 		writel(nvmeq->sq_tail, nvmeq->q_db);
-	nvmeq->last_sq_tail = nvmeq->sq_tail;
 }
 
 /**
@@ -480,7 +466,8 @@ static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
 	       cmd, sizeof(*cmd));
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
-	nvme_write_sq_db(nvmeq, write_sq);
+	if (write_sq)
+		nvme_write_sq_db(nvmeq);
 	spin_unlock(&nvmeq->sq_lock);
 }
 
@@ -489,8 +476,7 @@ static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
 	struct nvme_queue *nvmeq = hctx->driver_data;
 
 	spin_lock(&nvmeq->sq_lock);
-	if (nvmeq->sq_tail != nvmeq->last_sq_tail)
-		nvme_write_sq_db(nvmeq, true);
+	nvme_write_sq_db(nvmeq);
 	spin_unlock(&nvmeq->sq_lock);
 }
 
@@ -1489,7 +1475,6 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	struct nvme_dev *dev = nvmeq->dev;
 
 	nvmeq->sq_tail = 0;
-	nvmeq->last_sq_tail = 0;
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
