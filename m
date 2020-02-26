Return-Path: <SRS0=MxcY=4O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504C9C4BA13
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 14:14:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BAD72467B
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 14:14:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="bWLVk7sl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BAD72467B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=V3fdwk0watQrBa2bX92FPqqElcncP0AH0wRpSE60zUw=; b=bWLVk7slNKwICY
	OLKyyiIYQ73wKyeWn4zUq1wNSk93CRmlHPmYaWfjVAAQvbMdb7/+P+5hOZkn0eXf3+2H3RWxLMLxR
	rMDhzNYJ+ZkNn9ojBdnLRKSpW1cNT5gkulrQfK6SZ06F6tXeHi+wViL+f3jgwFGhdHq/JSdgtUBzQ
	mGfrccr2QbwAvXxuIW4JsquBDBG+vUXxhgzZRSxdhvngd/AMcjHJuUvzMHBYwl6/F9HFjEDgcBDQp
	LuHeR+hEM4jKljiqsw4foW0VilbB7JueM8VLDFOCXRd649sXn+q7yslb5CPRfkAjAKOZpLUfd87hv
	XwH1AWgVn2kd7XaPH3Qw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6xS9-00054A-1p; Wed, 26 Feb 2020 14:14:21 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6xS6-00053l-KS
 for linux-nvme@lists.infradead.org; Wed, 26 Feb 2020 14:14:20 +0000
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
 by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 01QEDYOm024545;
 Wed, 26 Feb 2020 06:13:35 -0800
From: Krishnamraju Eraparaju <krishna2@chelsio.com>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de
Subject: [PATCH for-rc] nvme-rdma/nvmet-rdma: Allocate sufficient RW ctxs to
 match hosts pgs len
Date: Wed, 26 Feb 2020 19:43:18 +0530
Message-Id: <20200226141318.28519-1-krishna2@chelsio.com>
X-Mailer: git-send-email 2.23.0.rc0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200226_061418_684203_A5BF283E 
X-CRM114-Status: GOOD (  12.62  )
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
Cc: linux-rdma@vger.kernel.org, krishna2@chelsio.com, bharat@chelsio.com,
 nirranjan@chelsio.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Current nvmet-rdma code allocates MR pool budget based on host's SQ
size, assuming both host and target use the same "max_pages_per_mr"
count. But if host's max_pages_per_mr is greater than target's, then
target can run out of MRs while processing larger IO WRITEs.

That is, say host's SQ size is 100, then the MR pool budget allocated
currently at target will also be 100 MRs. But 100 IO WRITE Requests
with 256 sg_count(IO size above 1MB) require 200 MRs when target's
"max_pages_per_mr" is 128.

The proposed patch enables host to advertise the max_fr_pages(via
nvme_rdma_cm_req) such that target can allocate that many number of
RW ctxs(if host's max_fr_pages is higher than target's).

Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
---
 drivers/nvme/host/rdma.c   |  2 ++
 drivers/nvme/target/rdma.c | 23 ++++++++++++++++++++---
 include/linux/nvme-rdma.h  |  4 +++-
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2a47c6c5007e..5970f0eedbd6 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1614,6 +1614,8 @@ static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
 		priv.hsqsize = cpu_to_le16(queue->ctrl->ctrl.sqsize);
 	}
 
+	priv.hmax_fr_pages = cpu_to_le32(ctrl->max_fr_pages);
+
 	ret = rdma_connect(queue->cm_id, &param);
 	if (ret) {
 		dev_err(ctrl->ctrl.device,
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 37d262a65877..2a3893e3c4e7 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -98,6 +98,7 @@ struct nvmet_rdma_queue {
 	int			host_qid;
 	int			recv_queue_size;
 	int			send_queue_size;
+	int			rdma_rw_ctxs_factor;
 
 	struct list_head	queue_list;
 };
@@ -1008,7 +1009,8 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 	qp_attr.qp_type = IB_QPT_RC;
 	/* +1 for drain */
 	qp_attr.cap.max_send_wr = queue->send_queue_size + 1;
-	qp_attr.cap.max_rdma_ctxs = queue->send_queue_size;
+	qp_attr.cap.max_rdma_ctxs = queue->send_queue_size *
+					queue->rdma_rw_ctxs_factor;
 	qp_attr.cap.max_send_sge = max(ndev->device->attrs.max_sge_rd,
 					ndev->device->attrs.max_send_sge);
 
@@ -1094,6 +1096,7 @@ nvmet_rdma_parse_cm_connect_req(struct rdma_conn_param *conn,
 				struct nvmet_rdma_queue *queue)
 {
 	struct nvme_rdma_cm_req *req;
+	u32 host_fr_pages_len, tgt_fr_pages_len;
 
 	req = (struct nvme_rdma_cm_req *)conn->private_data;
 	if (!req || conn->private_data_len == 0)
@@ -1111,6 +1114,19 @@ nvmet_rdma_parse_cm_connect_req(struct rdma_conn_param *conn,
 	queue->recv_queue_size = le16_to_cpu(req->hsqsize) + 1;
 	queue->send_queue_size = le16_to_cpu(req->hrqsize);
 
+	host_fr_pages_len = le32_to_cpu(req->hmax_fr_pages),
+	tgt_fr_pages_len = queue->dev->device->attrs.max_fast_reg_page_list_len;
+
+	if (host_fr_pages_len > tgt_fr_pages_len)
+		/*
+		 * Allocate more RW contexts as more MRs are required when
+		 * host_fr_pages_len is higher than target's.
+		 */
+		queue->rdma_rw_ctxs_factor =
+			DIV_ROUND_UP(host_fr_pages_len, tgt_fr_pages_len);
+	else
+		queue->rdma_rw_ctxs_factor = 1;
+
 	if (!queue->host_qid && queue->recv_queue_size > NVME_AQ_DEPTH)
 		return NVME_RDMA_CM_INVALID_HSQSIZE;
 
@@ -1147,6 +1163,9 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 		goto out_reject;
 	}
 
+	queue->dev = ndev;
+	queue->cm_id = cm_id;
+
 	ret = nvmet_sq_init(&queue->nvme_sq);
 	if (ret) {
 		ret = NVME_RDMA_CM_NO_RSC;
@@ -1162,8 +1181,6 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
 	 * inside a CM callback would trigger a deadlock. (great API design..)
 	 */
 	INIT_WORK(&queue->release_work, nvmet_rdma_release_queue_work);
-	queue->dev = ndev;
-	queue->cm_id = cm_id;
 
 	spin_lock_init(&queue->state_lock);
 	queue->state = NVMET_RDMA_Q_CONNECTING;
diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
index 3ec8e50efa16..2d6f2cf1e319 100644
--- a/include/linux/nvme-rdma.h
+++ b/include/linux/nvme-rdma.h
@@ -52,13 +52,15 @@ static inline const char *nvme_rdma_cm_msg(enum nvme_rdma_cm_status status)
  * @qid:           queue Identifier for the Admin or I/O Queue
  * @hrqsize:       host receive queue size to be created
  * @hsqsize:       host send queue size to be created
+ * @hmax_fr_pages: host maximum pages per fast reg
  */
 struct nvme_rdma_cm_req {
 	__le16		recfmt;
 	__le16		qid;
 	__le16		hrqsize;
 	__le16		hsqsize;
-	u8		rsvd[24];
+	__le32		hmax_fr_pages;
+	u8		rsvd[20];
 };
 
 /**
-- 
2.23.0.rc0


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
