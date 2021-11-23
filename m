Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7E31C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 10:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fJj3MbSJ1NODl2hTpONnapRAXuUtQVZMMizCO7GvwBo=; b=2Fp7oeVSYkoQphER0hSrsGnyvp
	ZYRuRpFXL63Wu+91nm/FRmwgEuMWEFoP72REK3EhE7xrDntTUI/fAtN1M1sJ3ZNFYH2ePgXqTsIjM
	q3Akrx+bqQl9XmKZCuH23ZW1b8LZ/bw1akNwbGJEAExKUCiZSkUqu+7FHniVP/dcRjaaQYs9GiQzl
	xLEEq+z9+Tdpd2bQ9K/1VAIkBDv10sgzNyo9q9mXQWr0fvsyPRb5bNWqqA6G7hAFue+ygt+3jeRZY
	WUfoc3eNSL16S2uLMaDiGXd7Vwkj4MYQXoIDP7vHG8N+BJqt+3p1vzok8fGjwsP5YqaLxFvOflX/R
	UWvDv5GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpTWR-001oj6-3E; Tue, 23 Nov 2021 10:59:35 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpTWM-001oi9-Jd
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 10:59:32 +0000
Received: from fcoe-test11.asicdesigners.com
 (fcoe-test11.blr.asicdesigners.com [10.193.185.180])
 by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 1ANAxOCX011259;
 Tue, 23 Nov 2021 02:59:25 -0800
From: Varun Prakash <varun@chelsio.com>
To: sagi@grimberg.me, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, varun@chelsio.com
Subject: [PATCH v3 2/2] nvme-tcp: send H2CData PDUs based on MAXH2CDATA
Date: Tue, 23 Nov 2021 16:29:22 +0530
Message-Id: <1637665162-3609-1-git-send-email-varun@chelsio.com>
X-Mailer: git-send-email 2.0.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211123_025930_687392_7DF21D18 
X-CRM114-Status: GOOD (  17.14  )
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
data_length to min(req->h2cdata_left, queue->maxh2cdata).

Also validate MAXH2CDATA value returned by target in ICResp PDU,
if it is not a multiple of dword or if it is less than 4096 return
-EINVAL from nvme_tcp_init_connection().

Signed-off-by: Varun Prakash <varun@chelsio.com>
---

v3:
- added h2cdata_left, h2cdata_offset
- removed unnecessary local variables from nvme_tcp_try_send_data_pdu()

v2:
- removed nvme_tcp_update_h2c_data_pdu()
- used sock_no_sendpage() instead of kernel_sendmsg()

 drivers/nvme/host/tcp.c  | 63 +++++++++++++++++++++++++++++++++++++-----------
 include/linux/nvme-tcp.h |  1 +
 2 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 5f8ad4d..0065892 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -44,6 +44,8 @@ struct nvme_tcp_request {
 	u32			data_len;
 	u32			pdu_len;
 	u32			pdu_sent;
+	u32			h2cdata_left;
+	u32			h2cdata_offset;
 	u16			ttag;
 	__le16			status;
 	struct list_head	entry;
@@ -95,6 +97,7 @@ struct nvme_tcp_queue {
 	struct nvme_tcp_request *request;
 
 	int			queue_size;
+	u32			maxh2cdata;
 	size_t			cmnd_capsule_len;
 	struct nvme_tcp_ctrl	*ctrl;
 	unsigned long		flags;
@@ -572,23 +575,26 @@ static int nvme_tcp_handle_comp(struct nvme_tcp_queue *queue,
 	return ret;
 }
 
-static void nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
-		struct nvme_tcp_r2t_pdu *pdu)
+static void nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_data_pdu *data = req->pdu;
 	struct nvme_tcp_queue *queue = req->queue;
 	struct request *rq = blk_mq_rq_from_pdu(req);
+	u32 h2cdata_sent = req->pdu_len;
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	u8 ddgst = nvme_tcp_ddgst_len(queue);
 
 	req->state = NVME_TCP_SEND_H2C_PDU;
 	req->offset = 0;
-	req->pdu_len = le32_to_cpu(pdu->r2t_length);
+	req->pdu_len = min(req->h2cdata_left, queue->maxh2cdata);
 	req->pdu_sent = 0;
+	req->h2cdata_left -= req->pdu_len;
+	req->h2cdata_offset += h2cdata_sent;
 
 	memset(data, 0, sizeof(*data));
 	data->hdr.type = nvme_tcp_h2c_data;
-	data->hdr.flags = NVME_TCP_F_DATA_LAST;
+	if (!req->h2cdata_left)
+		data->hdr.flags = NVME_TCP_F_DATA_LAST;
 	if (queue->hdr_digest)
 		data->hdr.flags |= NVME_TCP_F_HDGST;
 	if (queue->data_digest)
@@ -597,9 +603,9 @@ static void nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
 	data->hdr.pdo = data->hdr.hlen + hdgst;
 	data->hdr.plen =
 		cpu_to_le32(data->hdr.hlen + hdgst + req->pdu_len + ddgst);
-	data->ttag = pdu->ttag;
+	data->ttag = req->ttag;
 	data->command_id = nvme_cid(rq);
-	data->data_offset = pdu->r2t_offset;
+	data->data_offset = cpu_to_le32(req->h2cdata_offset);
 	data->data_length = cpu_to_le32(req->pdu_len);
 }
 
@@ -609,6 +615,7 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 	struct nvme_tcp_request *req;
 	struct request *rq;
 	u32 r2t_length = le32_to_cpu(pdu->r2t_length);
+	u32 r2t_offset = le32_to_cpu(pdu->r2t_offset);
 
 	rq = nvme_find_rq(nvme_tcp_tagset(queue), pdu->command_id);
 	if (!rq) {
@@ -633,14 +640,19 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
 		return -EPROTO;
 	}
 
-	if (unlikely(le32_to_cpu(pdu->r2t_offset) < req->data_sent)) {
+	if (unlikely(r2t_offset < req->data_sent)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"req %d unexpected r2t offset %u (expected %zu)\n",
-			rq->tag, le32_to_cpu(pdu->r2t_offset), req->data_sent);
+			rq->tag, r2t_offset, req->data_sent);
 		return -EPROTO;
 	}
 
-	nvme_tcp_setup_h2c_data_pdu(req, pdu);
+	req->pdu_len = 0;
+	req->h2cdata_left = r2t_length;
+	req->h2cdata_offset = r2t_offset;
+	req->ttag = pdu->ttag;
+
+	nvme_tcp_setup_h2c_data_pdu(req);
 	nvme_tcp_queue_request(req, false, true);
 
 	return 0;
@@ -920,6 +932,7 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_queue *queue = req->queue;
 	int req_data_len = req->data_len;
+	u32 h2cdata_left = req->h2cdata_left;
 
 	while (true) {
 		struct page *page = nvme_tcp_req_cur_page(req);
@@ -964,7 +977,10 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 				req->state = NVME_TCP_SEND_DDGST;
 				req->offset = 0;
 			} else {
-				nvme_tcp_done_send_req(queue);
+				if (h2cdata_left)
+					nvme_tcp_setup_h2c_data_pdu(req);
+				else
+					nvme_tcp_done_send_req(queue);
 			}
 			return 1;
 		}
@@ -1022,9 +1038,14 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
-	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
-			offset_in_page(pdu) + req->offset, len,
-			MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
+	if (!req->h2cdata_left)
+		ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
+				offset_in_page(pdu) + req->offset, len,
+				MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
+	else
+		ret = sock_no_sendpage(queue->sock, virt_to_page(pdu),
+				offset_in_page(pdu) + req->offset, len,
+				MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
 	if (unlikely(ret <= 0))
 		return ret;
 
@@ -1044,6 +1065,7 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_queue *queue = req->queue;
 	size_t offset = req->offset;
+	u32 h2cdata_left = req->h2cdata_left;
 	int ret;
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
 	struct kvec iov = {
@@ -1061,7 +1083,10 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
 		return ret;
 
 	if (offset + ret == NVME_TCP_DIGEST_LENGTH) {
-		nvme_tcp_done_send_req(queue);
+		if (h2cdata_left)
+			nvme_tcp_setup_h2c_data_pdu(req);
+		else
+			nvme_tcp_done_send_req(queue);
 		return 1;
 	}
 
@@ -1247,6 +1272,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	struct msghdr msg = {};
 	struct kvec iov;
 	bool ctrl_hdgst, ctrl_ddgst;
+	u32 maxh2cdata;
 	int ret;
 
 	icreq = kzalloc(sizeof(*icreq), GFP_KERNEL);
@@ -1330,6 +1356,14 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
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
@@ -2314,6 +2348,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	req->data_sent = 0;
 	req->pdu_len = 0;
 	req->pdu_sent = 0;
+	req->h2cdata_left = 0;
 	req->data_len = blk_rq_nr_phys_segments(rq) ?
 				blk_rq_payload_bytes(rq) : 0;
 	req->curr_bio = rq->bio;
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


