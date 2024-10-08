Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE435CEF148
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 09:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DkfX5nlC9Vf1PJBXPcfHMEN8X7b8kdaqhx69Nv9sxY4=; b=0S7h1LYQtwFArxZV2GUpyrLDZ/
	hCVHpTxa20TdjX9MutXfkiGyfi080VUq7rx+gvecOu2H2/NxT+rQ1ufQ04ee0FdlJeYolSrQUMHQ3
	ULIgVG1X+9fPNyQeg4o3KqsWY2T8Hdf5ls7FEwAu/ZkmLORu5dPImrBL6G4ecu3bRX8Q7/WR8tCJG
	EA/1hzm6LyWZmMt8unJj1M3T0Pgws3lz5g76n4LnImojqVQMSWVxE/7XF8HjVjHpkBDLwMvSTIDzI
	eq4w1yPXkwMInO50ffAFgULZRqe+t0/5Rd2UTk3EnMcDhaaRats+0cNDXviV64va9z53eT7KsiGBv
	qWuZixLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy6kF-00000005LVb-2LMk;
	Tue, 08 Oct 2024 09:43:07 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy6eb-00000005Kkf-0HNy
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 09:37:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728380233; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DkfX5nlC9Vf1PJBXPcfHMEN8X7b8kdaqhx69Nv9sxY4=;
	b=rnvzNY6/cYBUDOBQHzS1XE1613vXUrX0EWvk/XSkYeHZzsqOsVC7rErDQNh+Wp/FFSP9IWzdGjXWXZcwMgNbiBDn/fdkyEOPP49I8dC4L0q+wbdZJ3uJ7VCeXyNCq7eDZFCXYnrms2jbnPWFdSKnZtdlWbpJ+ZL47fOm9sywoKU=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WGd3ZeC_1728380228)
          by smtp.aliyun-inc.com;
          Tue, 08 Oct 2024 17:37:13 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvmet-rdma: use sbitmap to replace rsp free list
Date: Tue,  8 Oct 2024 17:37:08 +0800
Message-ID: <20241008093708.107392-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241008_023717_749487_1BBD3868 
X-CRM114-Status: GOOD (  17.89  )
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

In addition, performance has improved:
1. testing environment is local rxe rdma devie and mem-based
backstore device.
2. fio command, test the average 5 times:
fio -filename=/dev/nvme0n1 --ioengine=libaio -direct=1
-size=1G -name=1 -thread -runtime=60 -time_based -rw=read -numjobs=16
-iodepth=128 -bs=4k -group_reporting
3. Before: 241k IOPS, After: 256k IOPS, an increase of about 5%.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
Changes from v1 to v2:
- Add performance improvement expain.
- Add NVMET_RDMA_DISCRETE_RSP_TAG macro for -1 tag.
 drivers/nvme/target/rdma.c | 56 ++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 689bb5d3cfdc..34132520ebce 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -39,6 +39,8 @@
 
 #define NVMET_RDMA_BACKLOG 128
 
+#define NVMET_RDMA_DISCRETE_RSP_TAG		-1
+
 struct nvmet_rdma_srq;
 
 struct nvmet_rdma_cmd {
@@ -75,7 +77,7 @@ struct nvmet_rdma_rsp {
 	u32			invalidate_rkey;
 
 	struct list_head	wait_list;
-	struct list_head	free_list;
+	int			tag;
 };
 
 enum nvmet_rdma_queue_state {
@@ -98,8 +100,7 @@ struct nvmet_rdma_queue {
 	struct nvmet_sq		nvme_sq;
 
 	struct nvmet_rdma_rsp	*rsps;
-	struct list_head	free_rsps;
-	spinlock_t		rsps_lock;
+	struct sbitmap		rsp_tags;
 	struct nvmet_rdma_cmd	*cmds;
 
 	struct work_struct	release_work;
@@ -172,7 +173,8 @@ static void nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue);
 static void nvmet_rdma_free_rsp(struct nvmet_rdma_device *ndev,
 				struct nvmet_rdma_rsp *r);
 static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
-				struct nvmet_rdma_rsp *r);
+				struct nvmet_rdma_rsp *r,
+				int tag);
 
 static const struct nvmet_fabrics_ops nvmet_rdma_ops;
 
@@ -210,15 +212,12 @@ static inline bool nvmet_rdma_need_data_out(struct nvmet_rdma_rsp *rsp)
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
@@ -226,13 +225,12 @@ nvmet_rdma_get_rsp(struct nvmet_rdma_queue *queue)
 		rsp = kzalloc(sizeof(*rsp), GFP_KERNEL);
 		if (unlikely(!rsp))
 			return NULL;
-		ret = nvmet_rdma_alloc_rsp(queue->dev, rsp);
+		ret = nvmet_rdma_alloc_rsp(queue->dev, rsp,
+				NVMET_RDMA_DISCRETE_RSP_TAG);
 		if (unlikely(ret)) {
 			kfree(rsp);
 			return NULL;
 		}
-
-		rsp->allocated = true;
 	}
 
 	return rsp;
@@ -241,17 +239,13 @@ nvmet_rdma_get_rsp(struct nvmet_rdma_queue *queue)
 static inline void
 nvmet_rdma_put_rsp(struct nvmet_rdma_rsp *rsp)
 {
-	unsigned long flags;
-
-	if (unlikely(rsp->allocated)) {
+	if (unlikely(rsp->tag == NVMET_RDMA_DISCRETE_RSP_TAG)) {
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
@@ -404,7 +398,7 @@ static void nvmet_rdma_free_cmds(struct nvmet_rdma_device *ndev,
 }
 
 static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
-		struct nvmet_rdma_rsp *r)
+		struct nvmet_rdma_rsp *r, int tag)
 {
 	/* NVMe CQE / RDMA SEND */
 	r->req.cqe = kmalloc(sizeof(*r->req.cqe), GFP_KERNEL);
@@ -432,6 +426,7 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
 	r->read_cqe.done = nvmet_rdma_read_data_done;
 	/* Data Out / RDMA WRITE */
 	r->write_cqe.done = nvmet_rdma_write_data_done;
+	r->tag = tag;
 
 	return 0;
 
@@ -454,21 +449,23 @@ nvmet_rdma_alloc_rsps(struct nvmet_rdma_queue *queue)
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
@@ -477,6 +474,8 @@ nvmet_rdma_alloc_rsps(struct nvmet_rdma_queue *queue)
 	while (--i >= 0)
 		nvmet_rdma_free_rsp(ndev, &queue->rsps[i]);
 	kfree(queue->rsps);
+out_free_sbitmap:
+	sbitmap_free(&queue->rsp_tags);
 out:
 	return ret;
 }
@@ -489,6 +488,7 @@ static void nvmet_rdma_free_rsps(struct nvmet_rdma_queue *queue)
 	for (i = 0; i < nr_rsps; i++)
 		nvmet_rdma_free_rsp(ndev, &queue->rsps[i]);
 	kfree(queue->rsps);
+	sbitmap_free(&queue->rsp_tags);
 }
 
 static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
@@ -1447,8 +1447,6 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 	INIT_LIST_HEAD(&queue->rsp_wait_list);
 	INIT_LIST_HEAD(&queue->rsp_wr_wait_list);
 	spin_lock_init(&queue->rsp_wr_wait_lock);
-	INIT_LIST_HEAD(&queue->free_rsps);
-	spin_lock_init(&queue->rsps_lock);
 	INIT_LIST_HEAD(&queue->queue_list);
 
 	queue->idx = ida_alloc(&nvmet_rdma_queue_ida, GFP_KERNEL);
-- 
2.43.0


