Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4043AC61DE4
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2026 02:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7CZQSk3Q+9/NlXG0Gbm4GxE5qEmtwIEL8XUKhJcRTio=; b=ubVpABD/x3gxHhN6XxIkckpZua
	iPvOHt0Ft+xdAZxCGJWb/vY/mQL9bbgKqNcpkvsHHIF5qkcyX/zxQS0UyOtSU3ulDi++eZzmrwF/S
	+4d7nnpjbEETUmk35XhNcRcawMAzDK/SbkUIFLM+fkfZYP7RZy0FQ/AXOaskyWwTS+BTdfyb6+GtB
	q1R7a0oe0PtkIsnmaAacFkOGfSDehXqKxNsbuvUZbUPJWHNrh8u8Q1BZv6f7gYapZbdZU+bWdwCQw
	o9gVmzVon0pSD1JsTO/VYIhwhpuNYdk1pzYXmPXomocFJh6BWSRYTgvqe3XJNQ5keu3L3Aiv67fd4
	2kNOs9HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0rKO-00000008Krk-3pIV;
	Mon, 31 Aug 2026 02:00:52 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x0rKM-00000008KqI-3Xny
	for linux-nvme@lists.infradead.org;
	Mon, 31 Aug 2026 02:00:52 +0000
X-UUID: c764ec92a4df11f19a56ed5b684f684d-20260831
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:8d3a2742-6bee-4e8a-82b2-cc399daf22b3,IP:0,U
	RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-5
X-CID-META: VersionHash:7db8b62,CLOUDID:a63a8ec35f7506c60f878af16df13271,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|865|898,TC:nil,Content:0|15|50,EDM:-3,IP
	:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,
	LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c764ec92a4df11f19a56ed5b684f684d-20260831
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1718384454; Mon, 31 Aug 2026 10:00:45 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, hare@suse.de, dwagner@suse.de, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v3 1/1] nvme-tcp: fix wrong status on deferred digest error
Date: Mon, 31 Aug 2026 10:10:00 +0800
Message-ID: <1.nvme-tcp-req-status.v3.git.liuxixin@kylinos.cn>
In-Reply-To: <cover.nvme-tcp-req-status.v3.git.liuxixin@kylinos.cn>
References: <cover.nvme-tcp-req-status.v2.git.liuxixin@kylinos.cn> <cover.nvme-tcp-req-status.v3.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: patches/scripts/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260830_190051_185034_664D3CF8 
X-CRM114-Status: GOOD (  11.98  )
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

A C2HData digest error stores a host status code in req->status. Without
DATA_SUCCESS completion goes through the rsp path, which passed that host
value straight into complete as CQE Status wire encoding.

On the rsp path, pick host status from the CQE status field or from the
stored deferred error, then complete through nvme_tcp_end_request with
the CQE result.

Fixes: 1ba2e507f55c ("nvme-tcp: Do not reset transport on data digest errors")
Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 36 +++++++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 15 deletions(-)

--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -612,11 +612,19 @@ static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
 }
 
+static inline void nvme_tcp_end_request(struct request *rq, u16 status,
+					union nvme_result result)
+{
+	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), result))
+		nvme_complete_rq(rq);
+}
+
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		struct nvme_completion *cqe)
 {
 	struct nvme_tcp_request *req;
 	struct request *rq;
+	u16 status;
 
 	rq = nvme_find_rq(nvme_tcp_tagset(queue), cqe->command_id);
 	if (!rq) {
@@ -629,10 +637,11 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 
 	req = blk_mq_rq_to_pdu(rq);
 	if (req->status == cpu_to_le16(NVME_SC_SUCCESS))
-		req->status = cqe->status;
+		status = le16_to_cpu(cqe->status) >> 1;
+	else
+		status = le16_to_cpu(req->status);
 
-	if (!nvme_try_complete_req(rq, req->status, cqe->result))
-		nvme_complete_rq(rq);
+	nvme_tcp_end_request(rq, status, cqe->result);
 	queue->nr_cqe++;
 
 	return 0;
@@ -893,14 +902,6 @@ static int nvme_tcp_recv_pdu(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	return -EINVAL;
 }
 
-static inline void nvme_tcp_end_request(struct request *rq, u16 status)
-{
-	union nvme_result res = {};
-
-	if (!nvme_try_complete_req(rq, cpu_to_le16(status << 1), res))
-		nvme_complete_rq(rq);
-}
-
 static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			      unsigned int *offset, size_t *len)
 {
@@ -961,8 +962,9 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			queue->ddgst_remaining = NVME_TCP_DIGEST_LENGTH;
 		} else {
 			if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS) {
-				nvme_tcp_end_request(rq,
-						le16_to_cpu(req->status));
+				union nvme_result res = {};
+
+				nvme_tcp_end_request(rq, le16_to_cpu(req->status), res);
 				queue->nr_cqe++;
 			}
 			nvme_tcp_init_recv_ctx(queue);
@@ -1009,7 +1011,9 @@ static int nvme_tcp_recv_ddgst(struct nvme_tcp_queue *queue,
 					pdu->command_id);
 		struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 
-		nvme_tcp_end_request(rq, le16_to_cpu(req->status));
+		union nvme_result res = {};
+
+		nvme_tcp_end_request(rq, le16_to_cpu(req->status), res);
 		queue->nr_cqe++;
 	}
 
@@ -1124,8 +1128,10 @@ static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
 		nvme_complete_async_event(&req->queue->ctrl->ctrl,
 				cpu_to_le16(NVME_SC_HOST_PATH_ERROR), &res);
 	} else {
+		union nvme_result res = {};
+
 		nvme_tcp_end_request(blk_mq_rq_from_pdu(req),
-				NVME_SC_HOST_PATH_ERROR);
+				NVME_SC_HOST_PATH_ERROR, res);
 	}
 }
 
-- 
2.53.0


