Return-Path: <SRS0=8pqL=PP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7AEC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 12:24:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06D41610A0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Oct 2021 12:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 06D41610A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0nDHIbFCHGPL96YRWX9gylhVLDei3pWgOWoDnKRxsyU=; b=FMbx+4iPWPxOj+J0AtiVs/sYvO
	etCrgBLc4TeOmR5Q2ejtkoHEIeaQTxuXJ2xj5FqjOaJWRV9+sEdSkfnlPiThYZu4v6h077wAME9ze
	5FVX6OP//VvNzcSkzt0kFP3O8AY6zlXojFt3vionSsHm50ROGlmgd5CLQL1R0mXQcu3ocQo+UfaKk
	ybm7XH3mN+ShwgNf72/UqtNyMX1JscFgYdLuOuRQvRK6frUHEMVKJJ9HCVtg5CDwDiQPhry4zRcP/
	kOktG5Vj3GqpG1okVsVsMhyBmdzDjlDECp2aEJAMJePZw57EjTOSyQ5gWjWitcPgnHczymnBfvHS7
	f+r2Ma3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mfhyj-004rfu-KR; Wed, 27 Oct 2021 12:24:25 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mfhyf-004rfH-U5
 for linux-nvme@lists.infradead.org; Wed, 27 Oct 2021 12:24:23 +0000
Received: from fcoe-test11.asicdesigners.com
 (fcoe-test11.blr.asicdesigners.com [10.193.185.180])
 by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 19RCO3vN008080;
 Wed, 27 Oct 2021 05:24:04 -0700
From: Varun Prakash <varun@chelsio.com>
To: sagi@grimberg.me, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, varun@chelsio.com
Subject: [PATCH] nvme-tcp: send H2CData PDUs based on MAXH2CDATA
Date: Wed, 27 Oct 2021 17:53:59 +0530
Message-Id: <1635337439-4311-1-git-send-email-varun@chelsio.com>
X-Mailer: git-send-email 2.0.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211027_052422_011881_FDAA53A7 
X-CRM114-Status: GOOD (  17.16  )
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

As per NVMe/TCP specification (revision 1.0a, section 3.6.2.3)
Maximum Host to Controller Data length (MAXH2CDATA): Specifies the
maximum number of PDU-Data bytes per H2CData PDU in bytes. This value
is a multiple of dwords and should be no less than 4,096.

Current code sets H2CData PDU data_length to r2t_length,
it does not check MAXH2CDATA value. Fix this by setting H2CData PDU
data_length to min(req->rem_r2t_len, queue->maxh2cdata).

Also validate MAXH2CDATA value returned by target in ICResp PDU,
if it is not a multiple of dword or if it is less than 4096 return
-EINVAL from nvme_tcp_init_connection().

Signed-off-by: Varun Prakash <varun@chelsio.com>
---
 drivers/nvme/host/tcp.c  | 86 ++++++++++++++++++++++++++++++++++++++++--------
 include/linux/nvme-tcp.h |  1 +
 2 files changed, 74 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 22da856..d7a7d85 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -42,6 +42,7 @@ struct nvme_tcp_request {
 	void			*pdu;
 	struct nvme_tcp_queue	*queue;
 	u32			data_len;
+	u32			rem_r2t_len;
 	u32			pdu_len;
 	u32			pdu_sent;
 	u16			ttag;
@@ -95,6 +96,7 @@ struct nvme_tcp_queue {
 	struct nvme_tcp_request *request;
 
 	int			queue_size;
+	u32			maxh2cdata;
 	size_t			cmnd_capsule_len;
 	struct nvme_tcp_ctrl	*ctrl;
 	unsigned long		flags;
@@ -578,23 +580,21 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
 	struct nvme_tcp_data_pdu *data = req->pdu;
 	struct nvme_tcp_queue *queue = req->queue;
 	struct request *rq = blk_mq_rq_from_pdu(req);
+	u32 r2t_length = le32_to_cpu(pdu->r2t_length);
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	u8 ddgst = nvme_tcp_ddgst_len(queue);
 
-	req->pdu_len = le32_to_cpu(pdu->r2t_length);
-	req->pdu_sent = 0;
-
-	if (unlikely(!req->pdu_len)) {
+	if (unlikely(!r2t_length)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"req %d r2t len is %u, probably a bug...\n",
-			rq->tag, req->pdu_len);
+			rq->tag, r2t_length);
 		return -EPROTO;
 	}
 
-	if (unlikely(req->data_sent + req->pdu_len > req->data_len)) {
+	if (unlikely(req->data_sent + r2t_length > req->data_len)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
-			rq->tag, req->pdu_len, req->data_len,
+			rq->tag, r2t_length, req->data_len,
 			req->data_sent);
 		return -EPROTO;
 	}
@@ -607,9 +607,15 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
 		return -EPROTO;
 	}
 
+	req->rem_r2t_len = r2t_length;
+	req->pdu_len = min(req->rem_r2t_len, queue->maxh2cdata);
+	req->pdu_sent = 0;
+	req->rem_r2t_len -= req->pdu_len;
+
 	memset(data, 0, sizeof(*data));
 	data->hdr.type = nvme_tcp_h2c_data;
-	data->hdr.flags = NVME_TCP_F_DATA_LAST;
+	if (!req->rem_r2t_len)
+		data->hdr.flags = NVME_TCP_F_DATA_LAST;
 	if (queue->hdr_digest)
 		data->hdr.flags |= NVME_TCP_F_HDGST;
 	if (queue->data_digest)
@@ -923,9 +929,34 @@ static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
 	nvme_tcp_end_request(blk_mq_rq_from_pdu(req), NVME_SC_HOST_PATH_ERROR);
 }
 
+static void nvme_tcp_update_h2c_data_pdu(struct nvme_tcp_request *req)
+{
+	struct nvme_tcp_queue *queue = req->queue;
+	struct nvme_tcp_data_pdu *data = req->pdu;
+	u8 hdgst = nvme_tcp_hdgst_len(queue);
+	u8 ddgst = nvme_tcp_ddgst_len(queue);
+	u32 pdu_sent = req->pdu_len;
+
+	req->pdu_len = min(req->rem_r2t_len, queue->maxh2cdata);
+	req->pdu_sent = 0;
+	req->rem_r2t_len -= req->pdu_len;
+
+	if (!req->rem_r2t_len)
+		data->hdr.flags |= NVME_TCP_F_DATA_LAST;
+	data->hdr.plen =
+		cpu_to_le32(data->hdr.hlen + hdgst + req->pdu_len + ddgst);
+	data->data_offset =
+		cpu_to_le32(le32_to_cpu(data->data_offset) + pdu_sent);
+	data->data_length = cpu_to_le32(req->pdu_len);
+
+	req->state = NVME_TCP_SEND_H2C_PDU;
+	req->offset = 0;
+}
+
 static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_queue *queue = req->queue;
+	u32 rem_r2t_len = req->rem_r2t_len;
 
 	while (true) {
 		struct page *page = nvme_tcp_req_cur_page(req);
@@ -969,7 +1000,10 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 				req->state = NVME_TCP_SEND_DDGST;
 				req->offset = 0;
 			} else {
-				nvme_tcp_done_send_req(queue);
+				if (rem_r2t_len)
+					nvme_tcp_update_h2c_data_pdu(req);
+				else
+					nvme_tcp_done_send_req(queue);
 			}
 			return 1;
 		}
@@ -1022,14 +1056,26 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 	struct nvme_tcp_data_pdu *pdu = req->pdu;
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	int len = sizeof(*pdu) - req->offset + hdgst;
+	int flags = MSG_DONTWAIT | MSG_MORE;
 	int ret;
 
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
-	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
-			offset_in_page(pdu) + req->offset, len,
-			MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
+	if (req->rem_r2t_len) {
+		struct msghdr msg = { .msg_flags = flags };
+		struct kvec iov = {
+			.iov_base = (u8 *)pdu + req->offset,
+			.iov_len = len
+		};
+
+		ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
+	} else {
+		ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
+				      offset_in_page(pdu) + req->offset, len,
+				      flags | MSG_SENDPAGE_NOTLAST);
+	}
+
 	if (unlikely(ret <= 0))
 		return ret;
 
@@ -1048,6 +1094,7 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_queue *queue = req->queue;
+	u32 rem_r2t_len = req->rem_r2t_len;
 	int ret;
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
 	struct kvec iov = {
@@ -1065,7 +1112,10 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
 		return ret;
 
 	if (req->offset + ret == NVME_TCP_DIGEST_LENGTH) {
-		nvme_tcp_done_send_req(queue);
+		if (rem_r2t_len)
+			nvme_tcp_update_h2c_data_pdu(req);
+		else
+			nvme_tcp_done_send_req(queue);
 		return 1;
 	}
 
@@ -1251,6 +1301,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	struct msghdr msg = {};
 	struct kvec iov;
 	bool ctrl_hdgst, ctrl_ddgst;
+	u32 maxh2cdata;
 	int ret;
 
 	icreq = kzalloc(sizeof(*icreq), GFP_KERNEL);
@@ -1334,6 +1385,14 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 		goto free_icresp;
 	}
 
+	maxh2cdata = le32_to_cpu(icresp->maxdata);
+	if ((maxh2cdata % 4) || (maxh2cdata < NVME_TCP_MIN_MAXH2CDATA)) {
+		pr_err("queue %d: invalid maxh2cdata returned %u\n",
+		       nvme_tcp_queue_id(queue), maxh2cdata);
+		goto free_icresp;
+	}
+	queue->maxh2cdata = maxh2cdata;
+
 	ret = 0;
 free_icresp:
 	kfree(icresp);
@@ -2316,6 +2375,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	req->status = cpu_to_le16(NVME_SC_SUCCESS);
 	req->offset = 0;
 	req->data_sent = 0;
+	req->rem_r2t_len = 0;
 	req->pdu_len = 0;
 	req->pdu_sent = 0;
 	req->data_len = blk_rq_nr_phys_segments(rq) ?
diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
index 959e0bd..7547015 100644
--- a/include/linux/nvme-tcp.h
+++ b/include/linux/nvme-tcp.h
@@ -12,6 +12,7 @@
 #define NVME_TCP_DISC_PORT	8009
 #define NVME_TCP_ADMIN_CCSZ	SZ_8K
 #define NVME_TCP_DIGEST_LENGTH	4
+#define NVME_TCP_MIN_MAXH2CDATA 4096
 
 enum nvme_tcp_pfv {
 	NVME_TCP_PFV_1_0 = 0x0,
-- 
2.0.2


