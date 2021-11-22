Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E387C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 11:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=l7y4nKG065tY8I7WHHK3iqGtTUt9pzPcwK9yC0J/6cg=; b=NORFhlyo5MJxYYlq4a7faVyMrA
	Tt/tHD4C2LzAWNfMrEVZ+wKBzko1OwFzYpsedGe6//8g/++C+NQZy9yw7t4I6Uhz7+ioUvruXdaRI
	V1cxCGTSh/DFfHdm0ebm026a+ED9M8CweIKJgSiexRGqyGWZsyOCVP53rr13Z6BfCDqmbXg/f6Vqq
	iQia36uw6AtvPq0b2D3SyxQNULRTreGcc6/ZbpKz08mVSFYOZbz6pbwyI279K+N3xKAVPWYnYpHic
	KuJq5QLeC/TC+H0xpXHQ3Y6dt5L9RUJWFsX1gR06D6uiS4AKZowYvdqCf7StfHyZe53UEnQsFq0DL
	AW08wahQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp7eR-00G5w8-Ae; Mon, 22 Nov 2021 11:38:23 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp6WL-00Fpx7-K4
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 10:25:59 +0000
Received: from fcoe-test11.asicdesigners.com
 (fcoe-test11.blr.asicdesigners.com [10.193.185.180])
 by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 1AMAPo4P008940;
 Mon, 22 Nov 2021 02:25:51 -0800
From: Varun Prakash <varun@chelsio.com>
To: sagi@grimberg.me, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, varun@chelsio.com
Subject: [PATCH v2 2/2] nvme-tcp: send H2CData PDUs based on MAXH2CDATA
Date: Mon, 22 Nov 2021 15:55:43 +0530
Message-Id: <1637576743-3341-1-git-send-email-varun@chelsio.com>
X-Mailer: git-send-email 2.0.2
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_022557_724397_D42BD9BC 
X-CRM114-Status: GOOD (  15.62  )
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
v2:
 removed nvme_tcp_update_h2c_data_pdu()
 used sock_no_sendpage() instead of kernel_sendmsg()

 drivers/nvme/host/tcp.c  | 41 +++++++++++++++++++++++++++++++++++------
 include/linux/nvme-tcp.h |  1 +
 2 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 92e07d2..82f8926 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -97,6 +97,7 @@ struct nvme_tcp_queue {
 	struct nvme_tcp_request *request;
 
 	int			queue_size;
+	u32			maxh2cdata;
 	size_t			cmnd_capsule_len;
 	struct nvme_tcp_ctrl	*ctrl;
 	unsigned long		flags;
@@ -582,7 +583,7 @@ static void nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req)
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	u8 ddgst = nvme_tcp_ddgst_len(queue);
 
-	req->pdu_len = req->h2cdata_left;
+	req->pdu_len = min(req->h2cdata_left, queue->maxh2cdata);
 	req->pdu_sent = 0;
 
 	memset(data, 0, sizeof(*data));
@@ -933,6 +934,7 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_queue *queue = req->queue;
 	int req_data_len = req->data_len;
+	u32 h2cdata_left = req->h2cdata_left;
 
 	while (true) {
 		struct page *page = nvme_tcp_req_cur_page(req);
@@ -977,7 +979,13 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 				req->state = NVME_TCP_SEND_DDGST;
 				req->offset = 0;
 			} else {
-				nvme_tcp_done_send_req(queue);
+				if (h2cdata_left) {
+					nvme_tcp_setup_h2c_data_pdu(req);
+					req->state = NVME_TCP_SEND_H2C_PDU;
+					req->offset = 0;
+				} else {
+					nvme_tcp_done_send_req(queue);
+				}
 			}
 			return 1;
 		}
@@ -1028,16 +1036,21 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_queue *queue = req->queue;
 	struct nvme_tcp_data_pdu *pdu = req->pdu;
+	struct page *page = virt_to_page(pdu);
+	size_t offset = offset_in_page(pdu) + req->offset;
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	int len = sizeof(*pdu) - req->offset + hdgst;
+	int flags = MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST;
 	int ret;
 
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
-	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
-			offset_in_page(pdu) + req->offset, len,
-			MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
+	if (req->h2cdata_left)
+		ret = sock_no_sendpage(queue->sock, page, offset, len, flags);
+	else
+		ret = kernel_sendpage(queue->sock, page, offset, len, flags);
+
 	if (unlikely(ret <= 0))
 		return ret;
 
@@ -1057,6 +1070,7 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_queue *queue = req->queue;
 	size_t offset = req->offset;
+	u32 h2cdata_left = req->h2cdata_left;
 	int ret;
 	struct msghdr msg = { .msg_flags = MSG_DONTWAIT };
 	struct kvec iov = {
@@ -1074,7 +1088,13 @@ static int nvme_tcp_try_send_ddgst(struct nvme_tcp_request *req)
 		return ret;
 
 	if (offset + ret == NVME_TCP_DIGEST_LENGTH) {
-		nvme_tcp_done_send_req(queue);
+		if (h2cdata_left) {
+			nvme_tcp_setup_h2c_data_pdu(req);
+			req->state = NVME_TCP_SEND_H2C_PDU;
+			req->offset = 0;
+		} else {
+			nvme_tcp_done_send_req(queue);
+		}
 		return 1;
 	}
 
@@ -1260,6 +1280,7 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	struct msghdr msg = {};
 	struct kvec iov;
 	bool ctrl_hdgst, ctrl_ddgst;
+	u32 maxh2cdata;
 	int ret;
 
 	icreq = kzalloc(sizeof(*icreq), GFP_KERNEL);
@@ -1343,6 +1364,14 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
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


