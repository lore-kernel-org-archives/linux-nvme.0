Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B4AE77180
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 07:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zHJQ2vTnYM86opNCbMeXbjGRDg0jFC5Dv6m++koxEW8=; b=Trh7uvvKSvhwUpSLcwh8BTaUur
	WhjpzjrUpbegWDs65Gq34gYP++LeAPN3L+C9/UZCC4Wtt/M3EoES1zLvnTx1D5+N3WwwnelzT0jEL
	5oxRd1kGqcJQTbzk0e+Sf3T9l1uD8ztkpDpSEBPnVXKFz5L5I9TE+qdFqfRsMdJx0ZnLjVfLE8O27
	Nx9U5R53PCQsWo7lBUAas236OY5ojTXUbQtmts+f4yVYuYbvGKYR+5797cyoYSYUM33PQgKWJjn/K
	qqT3odEecvofQ/RXvJPJQvtBaMTdk9NTeFhhydzGDPSQKzE4cBEWQlyJ28u22oVzMHA9cMcc8zxuc
	d/RfHvZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLdWk-0000000H9Je-1hxH;
	Thu, 12 Dec 2024 07:22:26 +0000
Received: from hours.tkos.co.il ([84.110.109.230] helo=mail.tkos.co.il)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLdVG-0000000H975-1BA3
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 07:20:56 +0000
Received: from tarshish.tkos.co.il (unknown [10.0.8.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 8C43744048F;
	Thu, 12 Dec 2024 09:16:41 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1733987801;
	bh=JwLpFRcHe9tGibYmkUgDLXV0rTirJkDEBOnTkHVOaaM=;
	h=From:To:Cc:Subject:Date:From;
	b=Air1nkvM2flgtxhFp9dDM+Sb2BrIB9Tqu7kmP6niY3ySDBGCwFOlt1QZTrXLKpj3T
	 pi0jhIFQW1aIHHkXhVW2JsG8OuyJDdr1rxUprwo86SKXNVm/A/jneoHjqs8OiQeraL
	 7cH1uQqSPq0ml7KL43ewTRgTXHXupMxmI+XGz7huGOzwRBNeUb4eFIiR+Vv/KOEpBe
	 /AAG6AEwn6o2CBb690HPTBA99nNdocNTKOnU7hzYJUVzAuMUGxdKJCZnZpj5u04aw2
	 eUaL7Aw3YmwR9wlwfOTiPl4n4Ztazc6lZg6cI9wJVRq4cMSjuIIScQD9rr2FeAcYXD
	 3rZ6dIbifPN0A==
From: Baruch Siach <baruch@tkos.co.il>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] nvme: use dev_err() to make message more useful
Date: Thu, 12 Dec 2024 09:20:12 +0200
Message-ID: <551518fe326d5cff08aa2df1b7d69fcd689fdd96.1733988012.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_232054_999853_6FF187C1 
X-CRM114-Status: GOOD (  13.75  )
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

Suggested-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20241212062241.GA5586@lst.de
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/nvme/host/apple.c  | 2 +-
 drivers/nvme/host/nvme.h   | 6 +++---
 drivers/nvme/host/pci.c    | 2 +-
 drivers/nvme/host/rdma.c   | 2 +-
 drivers/nvme/host/tcp.c    | 6 +++---
 drivers/nvme/target/loop.c | 3 ++-
 6 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 4319ab50c10d..a70a167ab8f4 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -592,7 +592,7 @@ static inline void apple_nvme_handle_cqe(struct apple_nvme_queue *q,
 
 	apple_nvmmu_inval(q, command_id);
 
-	req = nvme_find_rq(apple_nvme_queue_tagset(anv, q), command_id);
+	req = nvme_find_rq(&anv->ctrl, apple_nvme_queue_tagset(anv, q), command_id);
 	if (unlikely(!req)) {
 		dev_warn(anv->dev, "invalid id %d completed", command_id);
 		return;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 611b02c8a8b3..dbdf8bc45f0e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -583,8 +583,8 @@ static inline u16 nvme_cid(struct request *rq)
 	return nvme_cid_install_genctr(nvme_req(rq)->genctr) | rq->tag;
 }
 
-static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
-		u16 command_id)
+static inline struct request *nvme_find_rq(struct nvme_ctrl *ctrl,
+		struct blk_mq_tags *tags, u16 command_id)
 {
 	u8 genctr = nvme_genctr_from_cid(command_id);
 	u16 tag = nvme_tag_from_cid(command_id);
@@ -592,7 +592,7 @@ static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
 
 	rq = blk_mq_tag_to_rq(tags, tag);
 	if (unlikely(!rq)) {
-		pr_err("could not locate request for tag %#x\n",
+		dev_err(ctrl->device, "could not locate request for tag %#x\n",
 			tag);
 		return NULL;
 	}
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 049ec18c037a..43fc557a85ab 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1122,7 +1122,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 		return;
 	}
 
-	req = nvme_find_rq(nvme_queue_tagset(nvmeq), command_id);
+	req = nvme_find_rq(&nvmeq->dev->ctrl, nvme_queue_tagset(nvmeq), command_id);
 	if (unlikely(!req)) {
 		dev_warn(nvmeq->dev->ctrl.device,
 			"invalid id %d completed on queue %d\n",
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 86a2891d9bcc..d991ff7860b3 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1694,7 +1694,7 @@ static void nvme_rdma_process_nvme_rsp(struct nvme_rdma_queue *queue,
 	struct request *rq;
 	struct nvme_rdma_request *req;
 
-	rq = nvme_find_rq(nvme_rdma_tagset(queue), cqe->command_id);
+	rq = nvme_find_rq(&queue->ctrl->ctrl, nvme_rdma_tagset(queue), cqe->command_id);
 	if (!rq) {
 		dev_err(queue->ctrl->ctrl.device,
 			"got bad command_id %#x on QP %#x\n",
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 28c76a3e1bd2..6e9c03ceeee0 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -601,7 +601,7 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 	struct nvme_tcp_request *req;
 	struct request *rq;
 
-	rq = nvme_find_rq(nvme_tcp_tagset(queue), cqe->command_id);
+	rq = nvme_find_rq(&queue->ctrl->ctrl, nvme_tcp_tagset(queue), cqe->command_id);
 	if (!rq) {
 		dev_err(queue->ctrl->ctrl.device,
 			"got bad cqe.command_id %#x on queue %d\n",
@@ -626,7 +626,7 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 {
 	struct request *rq;
 
-	rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
+	rq = nvme_find_rq(&queue->ctrl->ctrl, nvme_tcp_tagset(queue), pdu->command_id);
 	if (!rq) {
 		dev_err(queue->ctrl->ctrl.device,
 			"got bad c2hdata.command_id %#x on queue %d\n",
@@ -719,7 +719,7 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	u32 r2t_length = le32_to_cpu(pdu->r2t_length);
 	u32 r2t_offset = le32_to_cpu(pdu->r2t_offset);
 
-	rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
+	rq = nvme_find_rq(&queue->ctrl->ctrl, nvme_tcp_tagset(queue), pdu->command_id);
 	if (!rq) {
 		dev_err(queue->ctrl->ctrl.device,
 			"got bad r2t.command_id %#x on queue %d\n",
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index a9d112d34d4f..c6dfb5b796ec 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -107,7 +107,8 @@ static void nvme_loop_queue_response(struct nvmet_req *req)
 	} else {
 		struct request *rq;
 
-		rq = nvme_find_rq(nvme_loop_tagset(queue), cqe->command_id);
+		rq = nvme_find_rq(&queue->ctrl->ctrl, nvme_loop_tagset(queue),
+				cqe->command_id);
 		if (!rq) {
 			dev_err(queue->ctrl->ctrl.device,
 				"got bad command_id %#x on queue %d\n",
-- 
2.45.2


