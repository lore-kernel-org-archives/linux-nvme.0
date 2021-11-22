Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED13AC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 11:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=q9K6X1bY/fRMhfAOtzfOHsNX+gvS/0CRgzY1fJIV6Fo=; b=IxuAyvQ8ScjMcd/R/mYa7Uv6Nl
	DporPC7BGhF3Cmhw32DOLhOr766i1jP6LVXSm8ryRfbjVsNc67yGfKjSGlLtkl7DCZ23Fz/XoJPvL
	WyfcnmYQvbcIxu91cR1GYnIFTO+gwU+neYVRcjCeK78Afo/Ux7ZeiEFUY6jir/Qqvn8xfdolxCkuI
	G3QsgkmFnUVrnwICRMd+0KcxhmV5WBpgVU4Jy7O1oHU9IWj8vlrnPJ5UrsrYLpt+n+dA1WxdtIVfF
	psnkBi3kcI4xOl3m8SOtvnXAso3E2f0UrqUM7+u0IXe7FVrv/h741474IaxAGnv470WqilsvKxPb7
	NbQA5EWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp7UR-00G3DD-NK; Mon, 22 Nov 2021 11:28:03 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp6JW-00FmtZ-S2
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 10:12:44 +0000
Received: from fcoe-test11.asicdesigners.com
 (fcoe-test11.blr.asicdesigners.com [10.193.185.180])
 by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 1AMACaUS008920;
 Mon, 22 Nov 2021 02:12:37 -0800
From: Varun Prakash <varun@chelsio.com>
To: sagi@grimberg.me, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, varun@chelsio.com
Subject: [PATCH 1/2] nvme-tcp: validate R2T PDU in nvme_tcp_handle_r2t()
Date: Mon, 22 Nov 2021 15:42:33 +0530
Message-Id: <1637575953-3143-1-git-send-email-varun@chelsio.com>
X-Mailer: git-send-email 2.0.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_021242_992350_DDFF33F0 
X-CRM114-Status: GOOD (  13.00  )
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

If maxh2cdata < r2t_length then driver will form multiple
H2CData PDUs, validate R2T PDU in nvme_tcp_handle_r2t() to
reuse nvme_tcp_setup_h2c_data_pdu().

Signed-off-by: Varun Prakash <varun@chelsio.com>
---
 drivers/nvme/host/tcp.c | 79 +++++++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 33bc83d..92e07d2 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -44,7 +44,9 @@ struct nvme_tcp_request {
 	u32			data_len;
 	u32			pdu_len;
 	u32			pdu_sent;
-	u16			ttag;
+	u32			h2cdata_left;
+	u32			h2cdata_offset;
+	u16			h2cdata_ttag;
 	__le16			status;
 	struct list_head	entry;
 	struct llist_node	lentry;
@@ -572,8 +574,7 @@ static int nvme_tcp_handle_comp(struct nvme_tcp_queue *queue,
 	return ret;
 }
 
-static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
-		struct nvme_tcp_r2t_pdu *pdu)
+static void nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_data_pdu *data = req->pdu;
 	struct nvme_tcp_queue *queue = req->queue;
@@ -581,35 +582,11 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	u8 ddgst = nvme_tcp_ddgst_len(queue);
 
-	req->pdu_len = le32_to_cpu(pdu->r2t_length);
+	req->pdu_len = req->h2cdata_left;
 	req->pdu_sent = 0;
 
-	if (unlikely(!req->pdu_len)) {
-		dev_err(queue->ctrl->ctrl.device,
-			"req %d r2t len is %u, probably a bug...\n",
-			rq->tag, req->pdu_len);
-		return -EPROTO;
-	}
-
-	if (unlikely(req->data_sent + req->pdu_len > req->data_len)) {
-		dev_err(queue->ctrl->ctrl.device,
-			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
-			rq->tag, req->pdu_len, req->data_len,
-			req->data_sent);
-		return -EPROTO;
-	}
-
-	if (unlikely(le32_to_cpu(pdu->r2t_offset) < req->data_sent)) {
-		dev_err(queue->ctrl->ctrl.device,
-			"req %d unexpected r2t offset %u (expected %zu)\n",
-			rq->tag, le32_to_cpu(pdu->r2t_offset),
-			req->data_sent);
-		return -EPROTO;
-	}
-
 	memset(data, 0, sizeof(*data));
 	data->hdr.type = nvme_tcp_h2c_data;
-	data->hdr.flags = NVME_TCP_F_DATA_LAST;
 	if (queue->hdr_digest)
 		data->hdr.flags |= NVME_TCP_F_HDGST;
 	if (queue->data_digest)
@@ -618,11 +595,16 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
 	data->hdr.pdo = data->hdr.hlen + hdgst;
 	data->hdr.plen =
 		cpu_to_le32(data->hdr.hlen + hdgst + req->pdu_len + ddgst);
-	data->ttag = pdu->ttag;
+	data->ttag = req->h2cdata_ttag;
 	data->command_id = nvme_cid(rq);
-	data->data_offset = pdu->r2t_offset;
+	data->data_offset = cpu_to_le32(req->h2cdata_offset);
 	data->data_length = cpu_to_le32(req->pdu_len);
-	return 0;
+
+	req->h2cdata_left -= req->pdu_len;
+	req->h2cdata_offset += req->pdu_len;
+
+	if (!req->h2cdata_left)
+		data->hdr.flags |= NVME_TCP_F_DATA_LAST;
 }
 
 static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
@@ -630,7 +612,8 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 {
 	struct nvme_tcp_request *req;
 	struct request *rq;
-	int ret;
+	u32 r2t_length = le32_to_cpu(pdu->r2t_length);
+	u32 r2t_offset = le32_to_cpu(pdu->r2t_offset);
 
 	rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	if (!rq) {
@@ -641,10 +624,33 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	}
 	req = blk_mq_rq_to_pdu(rq);
 
-	ret = nvme_tcp_setup_h2c_data_pdu(req, pdu);
-	if (unlikely(ret))
-		return ret;
+	if (unlikely(!r2t_length)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d r2t len is %u, probably a bug...\n",
+			rq->tag, r2t_length);
+		return -EPROTO;
+	}
+
+	if (unlikely(req->data_sent + r2t_length > req->data_len)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
+			rq->tag, r2t_length, req->data_len,
+			req->data_sent);
+		return -EPROTO;
+	}
+
+	if (unlikely(r2t_offset < req->data_sent)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"req %d unexpected r2t offset %u (expected %zu)\n",
+			rq->tag, r2t_offset, req->data_sent);
+		return -EPROTO;
+	}
+
+	req->h2cdata_left = r2t_length;
+	req->h2cdata_offset = r2t_offset;
+	req->h2cdata_ttag = pdu->ttag;
 
+	nvme_tcp_setup_h2c_data_pdu(req);
 	req->state = NVME_TCP_SEND_H2C_PDU;
 	req->offset = 0;
 
@@ -2321,6 +2327,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	req->data_sent = 0;
 	req->pdu_len = 0;
 	req->pdu_sent = 0;
+	req->h2cdata_left = 0;
+	req->h2cdata_offset = 0;
+	req->h2cdata_ttag = 0;
 	req->data_len = blk_rq_nr_phys_segments(rq) ?
 				blk_rq_payload_bytes(rq) : 0;
 	req->curr_bio = rq->bio;
-- 
2.0.2


