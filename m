Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A202C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 16:46:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EF8E60EBB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 16:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1EF8E60EBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K2XFsw89Ct+YGz1plTuDDIA0iCoY9HiEfLQp5goS8J4=; b=ALB5r0tn50SWKkcmj/rxB6d/3N
	O0CXi+qrf5de4itL1wuZ9YGIEo2apF0o/ckUomD/+Fz0IPw6O63zmQhJ4QkbTSUj1FslLAXt0956D
	/OfyW+tiGsTPigYtUYgvW0Sye2Q6aQVn5lkWMlvv5kKhExGQeA0zK++PSXLmtnQ4G++/Qbk/r9n7e
	6SlLE4qfZnGROpdj9bJZbLiEIOSVgVvJmOv5ab04yePLN+wEbk54gxG1bcHmR01maYPG4vaU/EzgD
	C//kLIOsUUyJZDLZLotVdatYE/nhwIXMmRwgWJYbZrQKMBGE9yW9y1yWtP/EmK9kTokMpXNkfqyLe
	wpDS6tjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mb3ru-003spr-DO; Thu, 14 Oct 2021 16:46:10 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mb3rY-003slx-O0
 for linux-nvme@lists.infradead.org; Thu, 14 Oct 2021 16:45:50 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id F1BB561108;
 Thu, 14 Oct 2021 16:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634229948;
 bh=4gijnBYRCIePuwUSVn/rP75hK5nwPkgGS4AwcO9lVBc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=NuCDJwHlla+h12Hd71q6Du9iVJQgjT9eRmkAvEzlxBNUbV6IQpcuM+MhhtsFTHDcG
 yNS35scPZPrTCKlNLIPYyplH1QJj6nTFKGt4jFCj1rLCkHZ4iiFhkARradrvPbJ3y6
 mO4cE8Wy79iWEVXkjojq8QOZ5pzdxjbOSnNeRrqTEBXXpNO4ceimBUf9wHHcosmBjr
 2QT5LEmZ45QgHMCQa+DvkVJsFuchTpn8nZhxk/WdO3qGw/sRhRfpr/Po71kgk95ZyC
 7X6E5Jg9f+4KkwX1jzm4zV/p4U6lWmw6JUhsdMKAGPYuOZO4PGZ+rKw3iF5O5dfdZA
 mdlq4UPRu1Cmg==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: John Levon <levon@movementarian.org>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 2/2] nvme-pci: remove cached shadow doorbell offsets
Date: Thu, 14 Oct 2021 09:45:43 -0700
Message-Id: <20211014164543.1821327-3-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20211014164543.1821327-1-kbusch@kernel.org>
References: <20211014164543.1821327-1-kbusch@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211014_094548_838867_DB13A5ED 
X-CRM114-Status: GOOD (  16.64  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Real nvme hardware doesn't support the shadow doorbell feature. Remove
the overhead of saving this special feature per-queue and instead obtain
the address offsets from device providing it.

And when this feature is in use, the specification requires all queue
updates use this mechanism, so don't don't treat the admin queue
differently.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 100 ++++++++++++++++------------------------
 1 file changed, 41 insertions(+), 59 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9dd173bfa57b..65c0e925944c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -209,10 +209,6 @@ struct nvme_queue {
 #define NVMEQ_SQ_CMB		1
 #define NVMEQ_DELETE_ERROR	2
 #define NVMEQ_POLLED		3
-	u32 *dbbuf_sq_db;
-	u32 *dbbuf_cq_db;
-	u32 *dbbuf_sq_ei;
-	u32 *dbbuf_cq_ei;
 	struct completion delete_done;
 };
 
@@ -289,29 +285,6 @@ static void nvme_dbbuf_dma_free(struct nvme_dev *dev)
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
-static void nvme_dbbuf_free(struct nvme_queue *nvmeq)
-{
-	if (!nvmeq->qid)
-		return;
-
-	nvmeq->dbbuf_sq_db = NULL;
-	nvmeq->dbbuf_cq_db = NULL;
-	nvmeq->dbbuf_sq_ei = NULL;
-	nvmeq->dbbuf_cq_ei = NULL;
-}
-
 static void nvme_dbbuf_set(struct nvme_dev *dev)
 {
 	struct nvme_command c = { };
@@ -328,13 +301,10 @@ static void nvme_dbbuf_set(struct nvme_dev *dev)
 		dev_warn(dev->ctrl.device, "unable to set dbbuf\n");
 		/* Free memory and continue on */
 		nvme_dbbuf_dma_free(dev);
-
-		for (i = 1; i <= dev->online_queues; i++)
-			nvme_dbbuf_free(&dev->queues[i]);
 	}
 }
 
-static inline int nvme_dbbuf_need_event(u16 event_idx, u16 new_idx, u16 old)
+static inline bool nvme_dbbuf_need_event(u16 event_idx, u16 new_idx, u16 old)
 {
 	return (u16)(new_idx - event_idx - 1) < (u16)(new_idx - old);
 }
@@ -343,31 +313,48 @@ static inline int nvme_dbbuf_need_event(u16 event_idx, u16 new_idx, u16 old)
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
@@ -494,8 +481,7 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
 			return;
 	}
 
-	if (nvme_dbbuf_update_and_check_event(nvmeq->sq_tail,
-			nvmeq->dbbuf_sq_db, nvmeq->dbbuf_sq_ei))
+	if (nvme_dbbuf_update_sq(nvmeq))
 		writel(nvmeq->sq_tail, nvmeq->q_db);
 	nvmeq->last_sq_tail = nvmeq->sq_tail;
 }
@@ -989,11 +975,8 @@ static inline bool nvme_cqe_pending(struct nvme_queue *nvmeq)
 
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
@@ -1556,7 +1539,6 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	memset((void *)nvmeq->cqes, 0, CQ_SIZE(nvmeq));
-	nvme_dbbuf_init(dev, nvmeq, qid);
 	dev->online_queues++;
 	wmb(); /* ensure the first interrupt sees the initialization */
 }
-- 
2.25.4


