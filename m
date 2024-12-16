Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB344E7717F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 17:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=II/W3XQSyf8V1rjVnW5zsar5Ibjn2AXYaz7cQ/wCfd0=; b=u4XrySAaZgBllrXV7TxrHCF3u8
	a9X+/sS6P7n1FuRuKbszhEi9szJcIdGD1dcFtsledcDxmuNVYo783uME5UJIKioRYfD93Toh6OvHv
	MYLrLMvPKfEUaaccxqHTHHQGFFXZvQ6d2F7IWneV8uUH+DIiDXaHxADFxwWyYJh1bbbF1+n6MYKgX
	z1hZDjmFIqpnSrz1VxNHEHVq5pl64XGkfBZRwQuA4mxNYeBq0JtOzN9JiXaFGG9X+oKFZafwH4uXA
	uSMnTKv3r0ezR81HEsoawkfM9g586LjHwkJBWF3s1sjPaXhk/by3tzXbvOf9erYe2+OgFF15G+pYa
	5GwhwU2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNF8b-0000000AoAP-1DBN;
	Mon, 16 Dec 2024 17:44:09 +0000
Received: from guitar.tkos.co.il ([84.110.109.230] helo=mail.tkos.co.il)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNF8X-0000000Ao9y-2moO
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 17:44:07 +0000
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 69B2D440887;
	Mon, 16 Dec 2024 19:39:52 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1734370792;
	bh=qujAqnAzysIZHA77M0d03BTRGDYOnFEDAbNmM0pWmNw=;
	h=From:To:Cc:Subject:Date:From;
	b=HugTKd9Gri0sAd61kIIpyTv6f8Eg7jENXrScksiXwsLWsrBEuKr69pbHBk+nt+c2n
	 7aB0rpE6hIYDA4+JjwSL8JZ3Kf8W7+FZ2LJFcAq3YMUBpThDnmIQG3a+zPsW1+V60m
	 Xuy+xB4UW6XvYUcXiC6hy26btCwRTRjI/wTWSUK3OVh8Q8t88wwV7++hpOWPL4qUOr
	 1JS/hB9XnhgSlYPbKGe7TrRdnWbdLhTV8RY+Zau/Ra1dnjLHYqP3WLcL1BXVq5V+En
	 ThhalHS53nVsaJlTNf1R6fB+5XsnQpdWVIAWV0TBlk0tpNSUnVlLZZ/MuNm8jkYNRx
	 4YnsYrMnZd7OQ==
From: Baruch Siach <baruch@tkos.co.il>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v2] nvme: use dev_err() to make message more useful
Date: Mon, 16 Dec 2024 19:44:00 +0200
Message-ID: <29637ab5b312249da0b0cfc5e138e2aa7f6cddfe.1734371040.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_094406_095413_BD144B04 
X-CRM114-Status: GOOD (  15.11  )
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

pr_err() produces no prefix when called from pci.c, and only generic
prefix on other call sites. Switch to use dev_err() for more pleasant
debugging experience.

Since we now pass nvme_ctrl to nvme_find_rq() directly, nvme_find_rq()
can figure blk_mq_tags by itself. Remove local helpers that are all
almost identical.

Suggested-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20241212062241.GA5586@lst.de
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---

v2: Pass qid to nvme_find_rq() instead of tags (Christoph)
---
 drivers/nvme/host/apple.c  | 11 +----------
 drivers/nvme/host/nvme.h   |  8 +++++---
 drivers/nvme/host/pci.c    |  9 +--------
 drivers/nvme/host/rdma.c   | 12 ++----------
 drivers/nvme/host/tcp.c    |  9 ++++++---
 drivers/nvme/target/loop.c | 12 ++----------
 6 files changed, 17 insertions(+), 44 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 4319ab50c10d..207924003068 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -573,15 +573,6 @@ static inline bool apple_nvme_cqe_pending(struct apple_nvme_queue *q)
 	return (le16_to_cpu(READ_ONCE(hcqe->status)) & 1) == q->cq_phase;
 }
 
-static inline struct blk_mq_tags *
-apple_nvme_queue_tagset(struct apple_nvme *anv, struct apple_nvme_queue *q)
-{
-	if (q->is_adminq)
-		return anv->admin_tagset.tags[0];
-	else
-		return anv->tagset.tags[0];
-}
-
 static inline void apple_nvme_handle_cqe(struct apple_nvme_queue *q,
 					 struct io_comp_batch *iob, u16 idx)
 {
@@ -592,7 +583,7 @@ static inline void apple_nvme_handle_cqe(struct apple_nvme_queue *q,
 
 	apple_nvmmu_inval(q, command_id);
 
-	req = nvme_find_rq(apple_nvme_queue_tagset(anv, q), command_id);
+	req = nvme_find_rq(&anv->ctrl, q->is_adminq ? 0 : 1, command_id);
 	if (unlikely(!req)) {
 		dev_warn(anv->dev, "invalid id %d completed", command_id);
 		return;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 611b02c8a8b3..52039a7ec58c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -583,16 +583,18 @@ static inline u16 nvme_cid(struct request *rq)
 	return nvme_cid_install_genctr(nvme_req(rq)->genctr) | rq->tag;
 }
 
-static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
-		u16 command_id)
+static inline struct request *nvme_find_rq(struct nvme_ctrl *ctrl,
+		u32 qid, u16 command_id)
 {
 	u8 genctr = nvme_genctr_from_cid(command_id);
 	u16 tag = nvme_tag_from_cid(command_id);
+	struct blk_mq_tags *tags;
 	struct request *rq;
 
+	tags = qid ? ctrl->tagset->tags[qid - 1] : ctrl->admin_tagset->tags[0];
 	rq = blk_mq_tag_to_rq(tags, tag);
 	if (unlikely(!rq)) {
-		pr_err("could not locate request for tag %#x\n",
+		dev_err(ctrl->device, "could not locate request for tag %#x\n",
 			tag);
 		return NULL;
 	}
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 049ec18c037a..a2d81294d948 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1096,13 +1096,6 @@ static inline void nvme_ring_cq_doorbell(struct nvme_queue *nvmeq)
 		writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
 }
 
-static inline struct blk_mq_tags *nvme_queue_tagset(struct nvme_queue *nvmeq)
-{
-	if (!nvmeq->qid)
-		return nvmeq->dev->admin_tagset.tags[0];
-	return nvmeq->dev->tagset.tags[nvmeq->qid - 1];
-}
-
 static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 				   struct io_comp_batch *iob, u16 idx)
 {
@@ -1122,7 +1115,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 		return;
 	}
 
-	req = nvme_find_rq(nvme_queue_tagset(nvmeq), command_id);
+	req = nvme_find_rq(&nvmeq->dev->ctrl, nvmeq->qid, command_id);
 	if (unlikely(!req)) {
 		dev_warn(nvmeq->dev->ctrl.device,
 			"invalid id %d completed on queue %d\n",
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 86a2891d9bcc..df33715660bf 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1646,15 +1646,6 @@ static int nvme_rdma_post_recv(struct nvme_rdma_queue *queue,
 	return ret;
 }
 
-static struct blk_mq_tags *nvme_rdma_tagset(struct nvme_rdma_queue *queue)
-{
-	u32 queue_idx = nvme_rdma_queue_idx(queue);
-
-	if (queue_idx == 0)
-		return queue->ctrl->admin_tag_set.tags[queue_idx];
-	return queue->ctrl->tag_set.tags[queue_idx - 1];
-}
-
 static void nvme_rdma_async_done(struct ib_cq *cq, struct ib_wc *wc)
 {
 	if (unlikely(wc->status != IB_WC_SUCCESS))
@@ -1694,7 +1685,8 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 	struct request *rq;
 	struct nvme_rdma_request *req;
 
-	rq = nvme_find_rq(nvme_rdma_tagset(queue), cqe->command_id);
+	rq = nvme_find_rq(&queue->ctrl->ctrl, nvme_rdma_queue_idx(queue),
+			cqe->command_id);
 	if (!rq) {
 		dev_err(queue->ctrl->ctrl.device,
 			"got bad command_id %#x on QP %#x\n",
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 28c76a3e1bd2..e47646fd53ad 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -601,7 +601,8 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 	struct nvme_tcp_request *req;
 	struct request *rq;
 
-	rq = nvme_find_rq(nvme_tcp_tagset(queue), cqe->command_id);
+	rq = nvme_find_rq(&queue->ctrl->ctrl, nvme_tcp_queue_id(queue),
+			cqe->command_id);
 	if (!rq) {
 		dev_err(queue->ctrl->ctrl.device,
 			"got bad cqe.command_id %#x on queue %d\n",
@@ -626,7 +627,8 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 {
 	struct request *rq;
 
-	rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
+	rq = nvme_find_rq(&queue->ctrl->ctrl, nvme_tcp_queue_id(queue),
+			pdu->command_id);
 	if (!rq) {
 		dev_err(queue->ctrl->ctrl.device,
 			"got bad c2hdata.command_id %#x on queue %d\n",
@@ -719,7 +721,8 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	u32 r2t_length = le32_to_cpu(pdu->r2t_length);
 	u32 r2t_offset = le32_to_cpu(pdu->r2t_offset);
 
-	rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
+	rq = nvme_find_rq(&queue->ctrl->ctrl, nvme_tcp_queue_id(queue),
+			pdu->command_id);
 	if (!rq) {
 		dev_err(queue->ctrl->ctrl.device,
 			"got bad r2t.command_id %#x on queue %d\n",
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index a9d112d34d4f..64469e1ef806 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -79,15 +79,6 @@ static void nvme_loop_complete_rq(struct request *req)
 	nvme_complete_rq(req);
 }
 
-static struct blk_mq_tags *nvme_loop_tagset(struct nvme_loop_queue *queue)
-{
-	u32 queue_idx = nvme_loop_queue_idx(queue);
-
-	if (queue_idx == 0)
-		return queue->ctrl->admin_tag_set.tags[queue_idx];
-	return queue->ctrl->tag_set.tags[queue_idx - 1];
-}
-
 static void nvme_loop_queue_response(struct nvmet_req *req)
 {
 	struct nvme_loop_queue *queue =
@@ -107,7 +98,8 @@ static void nvme_loop_queue_response(struct nvmet_req *req)
 	} else {
 		struct request *rq;
 
-		rq = nvme_find_rq(nvme_loop_tagset(queue), cqe->command_id);
+		rq = nvme_find_rq(&queue->ctrl->ctrl,
+				nvme_loop_queue_idx(queue), cqe->command_id);
 		if (!rq) {
 			dev_err(queue->ctrl->ctrl.device,
 				"got bad command_id %#x on queue %d\n",
-- 
2.45.2


