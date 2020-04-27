Return-Path: <SRS0=LwVW=6L=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C23C83002
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2020 23:52:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B24CA2072D
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Apr 2020 23:52:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r6U3xPsZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mCPYLs3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B24CA2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kM/vo1g0rHraFwGGtu3641ghCalZYVOx9Ksi/cR6Eek=; b=r6U3xPsZUEdcxl
	g2qrHAJ+S11t3U1JBnW/93vqgCD8Q9ZYroDJJqeOrCL3+RDq3igDcGdyDkJjzfR8QdEVftd6F98og
	GRR9qhta1GsRhD1839oRrNFskKYS8CYine9beORD++vEW/5plwixmJJAnSLtwUThOUIi2oNn5YM12
	0x55b3fLQ8ddgNjo5J4sdcrIu60vBC2x9mwig6Fqa2dDe8uJUhuskQ0JTEgFwEvzIKmCMUU3TRSQ0
	E83IXVjmMO7noEqH+PCF2BKj/S3DpAUG72cT2zyP8bsBw1XO0p1jY+Fk+O8wVjhonPn75zu9Hb7Jz
	4uKnSWz29euecZ1H0arA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jTDYR-0004nY-0X; Mon, 27 Apr 2020 23:52:51 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTDYM-0004kP-W1
 for linux-nvme@lists.infradead.org; Mon, 27 Apr 2020 23:52:48 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5694A20775;
 Mon, 27 Apr 2020 23:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588031566;
 bh=TsFnP7Yejl+zQyN9TaTj0kbNo6FDJstcppdk1WzG7AA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mCPYLs3FB7f1illS5HOCMJro4G8nYL5mXBsC8lg7fwuPddmnAesYEQVJ29wXaeA/C
 6bPklkkCH9PJEm5fv9BL/dtod3f3cKC2h/4LaYb4zhb/TTCmKP3yOILLtUsjQUE64T
 wJWoXLOuvSb5EzIPZNGvjSpQ+h0sHwYcD8Prmf48=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Subject: [PATCH 2/3] nvme-pci: remove cached shadow doorbell offsets
Date: Mon, 27 Apr 2020 16:52:42 -0700
Message-Id: <20200427235243.2268765-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200427235243.2268765-1-kbusch@kernel.org>
References: <20200427235243.2268765-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200427_165247_122386_1BB754F5 
X-CRM114-Status: GOOD (  16.55  )
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

Real nvme hardware doesn't support the shadow doorbell feature. Remove
the overhead of saving this special feature and instead obtain the
address offsets from device providing it.

And when this feature is in use, the specification requires all queue
updates use this mechanism, so don't don't treat the admin queue
differently.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 86 ++++++++++++++++++++---------------------
 1 file changed, 41 insertions(+), 45 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d388fff9c358..6d91fc5ee4d1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -182,10 +182,6 @@ struct nvme_queue {
 #define NVMEQ_SQ_CMB		1
 #define NVMEQ_DELETE_ERROR	2
 #define NVMEQ_POLLED		3
-	u32 *dbbuf_sq_db;
-	u32 *dbbuf_cq_db;
-	u32 *dbbuf_sq_ei;
-	u32 *dbbuf_cq_ei;
 	struct completion delete_done;
 };
 
@@ -268,18 +264,6 @@ static void nvme_dbbuf_dma_free(struct nvme_dev *dev)
 	}
 }
 
-static void nvme_dbbuf_init(struct nvme_dev *dev,
-			    struct nvme_queue *nvmeq, int qid)
-{
-	if (!dev->dbbuf_dbs || !qid)
-		return;
-
-	nvmeq->dbbuf_sq_db = &dev->dbbuf_dbs[sq_idx(qid, dev->db_stride)];
-	nvmeq->dbbuf_cq_db = &dev->dbbuf_dbs[cq_idx(qid, dev->db_stride)];
-	nvmeq->dbbuf_sq_ei = &dev->dbbuf_eis[sq_idx(qid, dev->db_stride)];
-	nvmeq->dbbuf_cq_ei = &dev->dbbuf_eis[cq_idx(qid, dev->db_stride)];
-}
-
 static void nvme_dbbuf_set(struct nvme_dev *dev)
 {
 	struct nvme_command c;
@@ -299,7 +283,7 @@ static void nvme_dbbuf_set(struct nvme_dev *dev)
 	}
 }
 
-static inline int nvme_dbbuf_need_event(u16 event_idx, u16 new_idx, u16 old)
+static inline bool nvme_dbbuf_need_event(u16 event_idx, u16 new_idx, u16 old)
 {
 	return (u16)(new_idx - event_idx - 1) < (u16)(new_idx - old);
 }
@@ -308,31 +292,48 @@ static inline int nvme_dbbuf_need_event(u16 event_idx, u16 new_idx, u16 old)
 static bool nvme_dbbuf_update_and_check_event(u16 value, u32 *dbbuf_db,
 					      volatile u32 *dbbuf_ei)
 {
-	if (dbbuf_db) {
-		u16 old_value;
+	u16 old_value;
 
-		/*
-		 * Ensure that the queue is written before updating
-		 * the doorbell in memory
-		 */
-		wmb();
+	/*
+	 * Ensure that the queue is written before updating the doorbell in
+	 * memory
+	 */
+	wmb();
 
-		old_value = *dbbuf_db;
-		*dbbuf_db = value;
+	old_value = *dbbuf_db;
+	*dbbuf_db = value;
 
-		/*
-		 * Ensure that the doorbell is updated before reading the event
-		 * index from memory.  The controller needs to provide similar
-		 * ordering to ensure the envent index is updated before reading
-		 * the doorbell.
-		 */
-		mb();
+	/*
+	 * Ensure that the doorbell is updated before reading the event index
+	 * from memory.  The controller needs to provide similar ordering to
+	 * ensure the envent index is updated before reading the doorbell.
+	 */
+	mb();
+	return nvme_dbbuf_need_event(*dbbuf_ei, value, old_value);
+}
 
-		if (!nvme_dbbuf_need_event(*dbbuf_ei, value, old_value))
-			return false;
-	}
+static bool nvme_dbbuf_update_sq(struct nvme_queue *nvmeq)
+{
+	struct nvme_dev *dev = nvmeq->dev;
 
-	return true;
+	if (!dev->dbbuf_dbs)
+		return true;
+
+	return nvme_dbbuf_update_and_check_event(nvmeq->sq_tail,
+		&dev->dbbuf_dbs[sq_idx(nvmeq->qid, dev->db_stride)],
+		&dev->dbbuf_eis[sq_idx(nvmeq->qid, dev->db_stride)]);
+}
+
+static bool nvme_dbbuf_update_cq(struct nvme_queue *nvmeq)
+{
+	struct nvme_dev *dev = nvmeq->dev;
+
+	if (!dev->dbbuf_dbs)
+		return true;
+
+	return nvme_dbbuf_update_and_check_event(nvmeq->cq_head,
+		&dev->dbbuf_dbs[cq_idx(nvmeq->qid, dev->db_stride)],
+		&dev->dbbuf_eis[cq_idx(nvmeq->qid, dev->db_stride)]);
 }
 
 /*
@@ -450,8 +451,7 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 
 static inline void nvme_write_sq_db(struct nvme_queue *nvmeq)
 {
-	if (nvme_dbbuf_update_and_check_event(nvmeq->sq_tail,
-			nvmeq->dbbuf_sq_db, nvmeq->dbbuf_sq_ei))
+	if (nvme_dbbuf_update_sq(nvmeq))
 		writel(nvmeq->sq_tail, nvmeq->q_db);
 }
 
@@ -918,11 +918,8 @@ static inline bool nvme_cqe_pending(struct nvme_queue *nvmeq)
 
 static inline void nvme_ring_cq_doorbell(struct nvme_queue *nvmeq)
 {
-	u16 head = nvmeq->cq_head;
-
-	if (nvme_dbbuf_update_and_check_event(head, nvmeq->dbbuf_cq_db,
-					      nvmeq->dbbuf_cq_ei))
-		writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
+	if (nvme_dbbuf_update_cq(nvmeq))
+		writel(nvmeq->cq_head, nvmeq->q_db + nvmeq->dev->db_stride);
 }
 
 static inline struct blk_mq_tags *nvme_queue_tagset(struct nvme_queue *nvmeq)
@@ -1483,7 +1480,6 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq));
-	nvme_dbbuf_init(dev, nvmeq, qid);
 	dev->online_queues++;
 	wmb(); /* ensure the first interrupt sees the initialization */
 }
-- 
2.24.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
