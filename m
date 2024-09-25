Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29B32C369C7
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Sep 2024 10:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jW8Rdp3OEqJEORfLeYzsAHFK/D9fF3u3IeSRNTXceUA=; b=r3G17AMmt4WdtnW9OX7qlybvxJ
	iPwHflyKrG7q/znRpG+raeY0EUzaJUaomV6TDl1+5wz17Q3p9MKyPuDuRRC/ZD9wBvxl/3iPTtV7P
	9c0ZargPZ9vWBeqP43tToMstrwvDfA+T0/LAubihc185iMsB4quQS/SXTPRuQoleFsYMXxtR4uy78
	yE/FL1ya0/U+BL5TOQZxhGJrl+AU70KkOkFkvB/GwB/9Qvg1QNUQBvSyHNP8IVvr5fuXwanHqMz/I
	gabyIdRkS1jA7tCI+n/SpxPXDykIHl6G+ZleYlcmWmQKahTCaVaCXvJlUAvb8HykECmuP2QuyCrsj
	4AMiCvSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1stPc4-00000004mxr-13ri;
	Wed, 25 Sep 2024 10:51:16 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1stPbz-00000004mvJ-2lm6
	for linux-nvme@lists.infradead.org;
	Wed, 25 Sep 2024 10:51:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1727261467; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jW8Rdp3OEqJEORfLeYzsAHFK/D9fF3u3IeSRNTXceUA=;
	b=o4At5JXFlnPpYGY70RSWA/L6s98LIreMr9R0PLAt71bzDw/wTVpa4f4jNXYKAl+/oJbE8X39TKb8KFQfodjYq+W3tUU1AkAuuBONn/b58uKnR+CKJH09vN2eYe7YeowZd+xUdW9zwDtMNj9nki/WM+eQ+qp5vJ2oLlFpSUCtxGs=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WFjTpAn_1727261460)
          by smtp.aliyun-inc.com;
          Wed, 25 Sep 2024 18:51:05 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet-rdma: use sbitmap to replace rsp free list
Date: Wed, 25 Sep 2024 18:51:00 +0800
Message-ID: <20240925105100.88797-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240925_035112_481448_3F26353A 
X-CRM114-Status: GOOD (  15.71  )
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

We can use sbitmap to manage all the nvmet_rdma_rsp instead of using
free lists and spinlock, and we can use an additional tag to
determine whether the nvmet_rdma_rsp is extra allocated.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/rdma.c | 53 +++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 689bb5d3cfdc..4fa1aa0f46a7 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -75,7 +75,7 @@ struct nvmet_rdma_rsp {
 	u32			invalidate_rkey;
 
 	struct list_head	wait_list;
-	struct list_head	free_list;
+	int			tag;
 };
 
 enum nvmet_rdma_queue_state {
@@ -98,8 +98,7 @@ struct nvmet_rdma_queue {
 	struct nvmet_sq		nvme_sq;
 
 	struct nvmet_rdma_rsp	*rsps;
-	struct list_head	free_rsps;
-	spinlock_t		rsps_lock;
+	struct sbitmap		rsp_tags;
 	struct nvmet_rdma_cmd	*cmds;
 
 	struct work_struct	release_work;
@@ -172,7 +171,8 @@ static void nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue);
 static void nvmet_rdma_free_rsp(struct nvmet_rdma_device *ndev,
 				struct nvmet_rdma_rsp *r);
 static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
-				struct nvmet_rdma_rsp *r);
+				struct nvmet_rdma_rsp *r,
+				int tag);
 
 static const struct nvmet_fabrics_ops nvmet_rdma_ops;
 
@@ -210,15 +210,12 @@ static inline bool nvmet_rdma_need_data_out(struct nvmet_rdma_rsp *rsp)
 static inline struct nvmet_rdma_rsp *
 nvmet_rdma_get_rsp(struct nvmet_rdma_queue *queue)
 {
-	struct nvmet_rdma_rsp *rsp;
-	unsigned long flags;
+	struct nvmet_rdma_rsp *rsp = NULL;
+	int tag;
 
-	spin_lock_irqsave(&queue->rsps_lock, flags);
-	rsp = list_first_entry_or_null(&queue->free_rsps,
-				struct nvmet_rdma_rsp, free_list);
-	if (likely(rsp))
-		list_del(&rsp->free_list);
-	spin_unlock_irqrestore(&queue->rsps_lock, flags);
+	tag = sbitmap_get(&queue->rsp_tags);
+	if (tag >= 0)
+		rsp = &queue->rsps[tag];
 
 	if (unlikely(!rsp)) {
 		int ret;
@@ -226,13 +223,11 @@ nvmet_rdma_get_rsp(struct nvmet_rdma_queue *queue)
 		rsp = kzalloc(sizeof(*rsp), GFP_KERNEL);
 		if (unlikely(!rsp))
 			return NULL;
-		ret = nvmet_rdma_alloc_rsp(queue->dev, rsp);
+		ret = nvmet_rdma_alloc_rsp(queue->dev, rsp, -1);
 		if (unlikely(ret)) {
 			kfree(rsp);
 			return NULL;
 		}
-
-		rsp->allocated = true;
 	}
 
 	return rsp;
@@ -241,17 +236,13 @@ nvmet_rdma_get_rsp(struct nvmet_rdma_queue *queue)
 static inline void
 nvmet_rdma_put_rsp(struct nvmet_rdma_rsp *rsp)
 {
-	unsigned long flags;
-
-	if (unlikely(rsp->allocated)) {
+	if (unlikely(rsp->tag < 0)) {
 		nvmet_rdma_free_rsp(rsp->queue->dev, rsp);
 		kfree(rsp);
 		return;
 	}
 
-	spin_lock_irqsave(&rsp->queue->rsps_lock, flags);
-	list_add_tail(&rsp->free_list, &rsp->queue->free_rsps);
-	spin_unlock_irqrestore(&rsp->queue->rsps_lock, flags);
+	sbitmap_clear_bit(&rsp->queue->rsp_tags, rsp->tag);
 }
 
 static void nvmet_rdma_free_inline_pages(struct nvmet_rdma_device *ndev,
@@ -404,7 +395,7 @@ static void nvmet_rdma_free_cmds(struct nvmet_rdma_device *ndev,
 }
 
 static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
-		struct nvmet_rdma_rsp *r)
+		struct nvmet_rdma_rsp *r, int tag)
 {
 	/* NVMe CQE / RDMA SEND */
 	r->req.cqe = kmalloc(sizeof(*r->req.cqe), GFP_KERNEL);
@@ -432,6 +423,7 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
 	r->read_cqe.done = nvmet_rdma_read_data_done;
 	/* Data Out / RDMA WRITE */
 	r->write_cqe.done = nvmet_rdma_write_data_done;
+	r->tag = tag;
 
 	return 0;
 
@@ -454,21 +446,23 @@ nvmet_rdma_alloc_rsps(struct nvmet_rdma_queue *queue)
 {
 	struct nvmet_rdma_device *ndev = queue->dev;
 	int nr_rsps = queue->recv_queue_size * 2;
-	int ret = -EINVAL, i;
+	int ret = -ENOMEM, i;
+
+	if (sbitmap_init_node(&queue->rsp_tags, nr_rsps, -1, GFP_KERNEL,
+			NUMA_NO_NODE, false, true))
+		goto out;
 
 	queue->rsps = kcalloc(nr_rsps, sizeof(struct nvmet_rdma_rsp),
 			GFP_KERNEL);
 	if (!queue->rsps)
-		goto out;
+		goto out_free_sbitmap;
 
 	for (i = 0; i < nr_rsps; i++) {
 		struct nvmet_rdma_rsp *rsp = &queue->rsps[i];
 
-		ret = nvmet_rdma_alloc_rsp(ndev, rsp);
+		ret = nvmet_rdma_alloc_rsp(ndev, rsp, i);
 		if (ret)
 			goto out_free;
-
-		list_add_tail(&rsp->free_list, &queue->free_rsps);
 	}
 
 	return 0;
@@ -477,6 +471,8 @@ nvmet_rdma_alloc_rsps(struct nvmet_rdma_queue *queue)
 	while (--i >= 0)
 		nvmet_rdma_free_rsp(ndev, &queue->rsps[i]);
 	kfree(queue->rsps);
+out_free_sbitmap:
+	sbitmap_free(&queue->rsp_tags);
 out:
 	return ret;
 }
@@ -489,6 +485,7 @@ static void nvmet_rdma_free_rsps(struct nvmet_rdma_queue *queue)
 	for (i = 0; i < nr_rsps; i++)
 		nvmet_rdma_free_rsp(ndev, &queue->rsps[i]);
 	kfree(queue->rsps);
+	sbitmap_free(&queue->rsp_tags);
 }
 
 static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
@@ -1447,8 +1444,6 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 	INIT_LIST_HEAD(&queue->rsp_wait_list);
 	INIT_LIST_HEAD(&queue->rsp_wr_wait_list);
 	spin_lock_init(&queue->rsp_wr_wait_lock);
-	INIT_LIST_HEAD(&queue->free_rsps);
-	spin_lock_init(&queue->rsps_lock);
 	INIT_LIST_HEAD(&queue->queue_list);
 
 	queue->idx = ida_alloc(&nvmet_rdma_queue_ida, GFP_KERNEL);
-- 
2.43.0


