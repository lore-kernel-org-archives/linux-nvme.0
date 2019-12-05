Return-Path: <SRS0=qSen=Z3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B903C43603
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2019 20:08:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BCBD206D9
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2019 20:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sRtKoiR3";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yyzHyxxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BCBD206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=V8MnoQ1FCKGc3+0RcdiDioqlZQnSL/TgyKzg9uhFqKA=; b=sRtKoiR3quObTe
	OS8mIZDZbk2K2CaRoxJ3NVqCwH8AQ0RhG1Rus4EHOEswugbb2i0NThQNJx+amJN52915yLdfIM3Sb
	xSJjPhrLveORPpOfsjLXGzRj5tgVSZm/J6JgpUAEXU/740K6+3kX8L+5qS01zhiHtelbg0Q04DDUS
	i/Gl2VXCYCrcbYuyM+0mrWeGcTfZq4xj1yrELL3ZBAymUtBCeixP+1T+4OIo8KILdUR/uhMvxfZri
	G5hVblOO8JySFUZw6PwEYSPForIFsdBReiN8owP1lp/AQEvVhWWxg915b5fXE9iPehfLEZFgc6U1Y
	4XVMRuT2X5LhWd+2C3cg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1icxQT-0003Lk-Lf; Thu, 05 Dec 2019 20:08:37 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icxQR-0003LR-A3
 for linux-nvme@lists.infradead.org; Thu, 05 Dec 2019 20:08:36 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4C318206D9;
 Thu,  5 Dec 2019 20:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575576514;
 bh=vj/yjt05OT21L2T26hhwC8aVFsfs3CeonyUsGFgi7Es=;
 h=From:To:Cc:Subject:Date:From;
 b=yyzHyxxR+Z1qvjB7c0w6zyQiqg1RHkT2eErCQqtWkLwej6cFmhki3OMsef3BiSb4d
 YgW/adtibJN78Kob5lmal8zJ0gR+u3/31VzqH1oWVu3iPaySAs5ytVa2mvOrbsuj7J
 qMqaGbYVWaIGdhrelo3cIqFOgfrqrHHsfJBC+BUo=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH] nvme/pci: Remove last_sq_tail
Date: Fri,  6 Dec 2019 05:08:25 +0900
Message-Id: <20191205200825.27651-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191205_120835_369163_420369B2 
X-CRM114-Status: GOOD (  10.88  )
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

We don't allocate enough tags to wrap the submission queue. Remove
tracking for this condition.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0590640ba62c..3acd1b4d7735 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -174,7 +174,6 @@ struct nvme_queue {
 	u16 q_depth;
 	u16 cq_vector;
 	u16 sq_tail;
-	u16 last_sq_tail;
 	u16 cq_head;
 	u16 qid;
 	u8 cq_phase;
@@ -462,21 +461,11 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 /*
  * Write sq tail if we are asked to, or if the next command would wrap.
  */
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
@@ -493,7 +482,8 @@ static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
 	       cmd, sizeof(*cmd));
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
-	nvme_write_sq_db(nvmeq, write_sq);
+	if (write_sq)
+		nvme_write_sq_db(nvmeq);
 	spin_unlock(&nvmeq->sq_lock);
 }
 
@@ -502,8 +492,7 @@ static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
 	struct nvme_queue *nvmeq = hctx->driver_data;
 
 	spin_lock(&nvmeq->sq_lock);
-	if (nvmeq->sq_tail != nvmeq->last_sq_tail)
-		nvme_write_sq_db(nvmeq, true);
+	nvme_write_sq_db(nvmeq);
 	spin_unlock(&nvmeq->sq_lock);
 }
 
@@ -1511,7 +1500,6 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	struct nvme_dev *dev = nvmeq->dev;
 
 	nvmeq->sq_tail = 0;
-	nvmeq->last_sq_tail = 0;
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
-- 
2.21.0


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
