Return-Path: <SRS0=skSE=KC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDD4C433B4
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 15:12:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12141613C0
	for <linux-nvme@archiver.kernel.org>; Fri,  7 May 2021 15:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12141613C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BGkJR9XhKU9pUYjm2tiODS/8fkGb5hkRdcDKjNlLVx4=; b=bLmhNU47CV2U0O/NooxizfodP1
	u4KjJpHtAjKE3FRxcVMSl9rZ+QxA6M3dkU2dsmtEmuqPqnenR5BsaySf7AYPrgftDTaT0SJ2tuxqu
	lRaCNbSwhTTHnDXV+pusHA7pZwgP5clTsa0oPK8ozjY2bdsGMQ9T9jQE9DaPWU6izB3zE+CK2e62H
	Jc/u+O4x//qNKbIm+G1nYfYvjjI805XRIM7g6DvJFmDgxI+Ww3IOUvCr83TTmDbYF3qNeLTUqZv8g
	Ojw3fJoytuUlMGONU9kn8XG2qllUKvD5vEGjsNb3uEs0FS3pHU9xv7XXELR5aCpqOE6HX8S3EWsHI
	dAVd9izg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lf292-007ORE-OD; Fri, 07 May 2021 15:12:00 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lf290-007OQz-To
 for linux-nvme@desiato.infradead.org; Fri, 07 May 2021 15:11:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=U/V3rvWNVdBumP0RfbiO7SIgW/fwuBRNFIbIPNdq5r4=; b=kDhVnzjmkB4va924B0iSCJIik8
 Eq2FqDkmK5mwUFx2SozI0ozWPLBc3Xe7kgfw9zbzaUTc3zo5jGcKf/Qs2Hxo+7L1XywfKSlDj9TNL
 WRrAZoVpEHgUba9JcydcSiV49p2mc+I+k1IyKBBdhVvyXHMlKJ8fFvUfMwvwHU+WEv8nWbi8EpFzu
 cwUOssPUg38iI6QU72dv449YlGci314eRxIeaq4XQzrGH9N71KozP45eROH7P1wXojtOTLMStpK0t
 r6qdDpiR7uJ5OYuoTmq+YVxDWgfaWlDtS4A7AsP6OJH+SwMOrVLVHzTZSPMcmutZxFlZ5dh7OuK1d
 prakreLA==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lf28x-006xE9-IX
 for linux-nvme@lists.infradead.org; Fri, 07 May 2021 15:11:57 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8165613C0;
 Fri,  7 May 2021 15:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1620400313;
 bh=6w1R+EOqCN/HXN21GgJNmOMmkIfbXmsgdoUeS2qQg0c=;
 h=From:To:Cc:Subject:Date:From;
 b=jebvx+xaBtcqKb5zcj8kwAX27HEb4RYd1chmL9upqVX5oxzVKRDkZihPU/cCxIo4M
 MBgRBUSrHnwCH12OKWSaJHTo9zolus42xq3gioNg/sK3C1GZHyINpqxlCKzCeJPo6Z
 1pCxi8pIBkeMhieniayiNJ2mDkXPx3UzVzlMmN6plCibwtCnFQholm/yd8HaNkbn7K
 nE7cqoxY0nwcqNiyBuqmU1w/qpmPQgppGdNDzBlJ+tv23jc3cn9vOltGAlWefhFcfs
 gT8ajV/Xx/mOQKr0d4AOq/c8yC68afe2cV9fVD1NJZnZ46qMaLKibVPJ1ckKuIaTkj
 i7TgAo4XP9ISQ==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de,
	sagi@grimberg.me
Cc: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-tcp: add command tracking trace events
Date: Fri,  7 May 2021 08:11:50 -0700
Message-Id: <20210507151150.1278374-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210507_081155_716214_6230172A 
X-CRM114-Status: GOOD (  16.58  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Debugging nvme-tcp issues can be difficult due to lack of visibility
into the driver's execution flow for any particular command. Add trace
events that detail the command cycle. Also add details to existing error
messages so they can more readily be matched up with those traces.

There is no functional change in this patch.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/tcp.c       |  46 +++++---
 drivers/nvme/host/trace-tcp.h | 209 ++++++++++++++++++++++++++++++++++
 2 files changed, 240 insertions(+), 15 deletions(-)
 create mode 100644 drivers/nvme/host/trace-tcp.h

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 0222e23f5936..bbcf48f6345e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -218,6 +218,9 @@ static inline size_t nvme_tcp_pdu_last_send(struct nvme_tcp_request *req,
 	return nvme_tcp_pdu_data_left(req) <= len;
 }
 
+#define CREATE_TRACE_POINTS
+#include "trace-tcp.h"
+
 static void nvme_tcp_init_iter(struct nvme_tcp_request *req,
 		unsigned int dir)
 {
@@ -525,6 +528,7 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 
 	queue->data_remaining = le32_to_cpu(pdu->data_length);
 
+	trace_nvme_tcp_c2h(rq, pdu);
 	if (pdu->hdr.flags & NVME_TCP_F_DATA_SUCCESS &&
 	    unlikely(!(pdu->hdr.flags & NVME_TCP_F_DATA_LAST))) {
 		dev_err(queue->ctrl->ctrl.device,
@@ -567,10 +571,13 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
 	struct request *rq = blk_mq_rq_from_pdu(req);
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	u8 ddgst = nvme_tcp_ddgst_len(queue);
+	unsigned r2t_offset = le32_to_cpu(pdu->r2t_offset);
 
 	req->pdu_len = le32_to_cpu(pdu->r2t_length);
 	req->pdu_sent = 0;
 
+	trace_nvme_tcp_r2t(rq, req, r2t_offset);
+
 	if (unlikely(!req->pdu_len)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"req %d r2t len is %u, probably a bug...\n",
@@ -580,17 +587,16 @@ static int nvme_tcp_setup_h2c_data_pdu(struct nvme_tcp_request *req,
 
 	if (unlikely(req->data_sent + req->pdu_len > req->data_len)) {
 		dev_err(queue->ctrl->ctrl.device,
-			"req %d r2t len %u exceeded data len %u (%zu sent)\n",
-			rq->tag, req->pdu_len, req->data_len,
-			req->data_sent);
+			"req %d op %d r2t len %u exceeded data len %u (%zu sent) pdu offset %u\n",
+			rq->tag, req_op(rq), req->pdu_len, req->data_len,
+			req->data_sent, r2t_offset);
 		return -EPROTO;
 	}
 
-	if (unlikely(le32_to_cpu(pdu->r2t_offset) < req->data_sent)) {
+	if (unlikely(r2t_offset < req->data_sent)) {
 		dev_err(queue->ctrl->ctrl.device,
 			"req %d unexpected r2t offset %u (expected %zu)\n",
-			rq->tag, le32_to_cpu(pdu->r2t_offset),
-			req->data_sent);
+			rq->tag, r2t_offset, req->data_sent);
 		return -EPROTO;
 	}
 
@@ -714,6 +720,7 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 	}
 	req = blk_mq_rq_to_pdu(rq);
 
+	trace_nvme_tcp_recv_data(rq, queue, pdu, *offset, *len);
 	while (true) {
 		int recv_len, ret;
 
@@ -730,8 +737,9 @@ static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct sk_buff *skb,
 			 */
 			if (!req->curr_bio) {
 				dev_err(queue->ctrl->ctrl.device,
-					"queue %d no space in request %#x",
-					nvme_tcp_queue_id(queue), rq->tag);
+					"queue %d no space in request %#x data_remaining %lu",
+					nvme_tcp_queue_id(queue), rq->tag,
+					queue->data_remaining);
 				nvme_tcp_init_recv_ctx(queue);
 				return -EIO;
 			}
@@ -920,6 +928,7 @@ static void nvme_tcp_fail_request(struct nvme_tcp_request *req)
 static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 {
 	struct nvme_tcp_queue *queue = req->queue;
+	struct request *rq = blk_mq_rq_from_pdu(req);
 
 	while (true) {
 		struct page *page = nvme_tcp_req_cur_page(req);
@@ -933,6 +942,7 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 		else
 			flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
 
+		trace_nvme_tcp_data(rq, req, offset, len, last);
 		if (sendpage_ok(page)) {
 			ret = kernel_sendpage(queue->sock, page, offset, len,
 					flags);
@@ -972,7 +982,8 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	int len = sizeof(*pdu) + hdgst - req->offset;
 	int flags = MSG_DONTWAIT;
-	int ret;
+	struct request *rq = blk_mq_rq_from_pdu(req);
+	int offset, ret;
 
 	if (inline_data || nvme_tcp_queue_more(queue))
 		flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
@@ -982,8 +993,10 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
-	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
-			offset_in_page(pdu) + req->offset, len,  flags);
+	offset = offset_in_page(pdu) + req->offset;
+	trace_nvme_tcp_cmd_pdu(rq, req, offset, len);
+	ret = kernel_sendpage(queue->sock, virt_to_page(pdu), offset,
+			len,  flags);
 	if (unlikely(ret <= 0))
 		return ret;
 
@@ -1009,14 +1022,16 @@ static int nvme_tcp_try_send_data_pdu(struct nvme_tcp_request *req)
 	struct nvme_tcp_data_pdu *pdu = req->pdu;
 	u8 hdgst = nvme_tcp_hdgst_len(queue);
 	int len = sizeof(*pdu) - req->offset + hdgst;
-	int ret;
+	struct request *rq = blk_mq_rq_from_pdu(req);
+	int offset, ret;
 
 	if (queue->hdr_digest && !req->offset)
 		nvme_tcp_hdgst(queue->snd_hash, pdu, sizeof(*pdu));
 
-	ret = kernel_sendpage(queue->sock, virt_to_page(pdu),
-			offset_in_page(pdu) + req->offset, len,
-			MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
+	offset = offset_in_page(pdu) + req->offset;
+	trace_nvme_tcp_h2c_pdu(rq, req, offset, len);
+	ret = kernel_sendpage(queue->sock, virt_to_page(pdu), offset,
+			len, MSG_DONTWAIT | MSG_MORE | MSG_SENDPAGE_NOTLAST);
 	if (unlikely(ret <= 0))
 		return ret;
 
@@ -2341,6 +2356,7 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (!nvme_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
 		return nvme_fail_nonready_command(&queue->ctrl->ctrl, rq);
 
+	trace_nvme_tcp_queue_rq(rq);
 	ret = nvme_tcp_setup_cmd_pdu(ns, rq);
 	if (unlikely(ret))
 		return ret;
diff --git a/drivers/nvme/host/trace-tcp.h b/drivers/nvme/host/trace-tcp.h
new file mode 100644
index 000000000000..4c720c8d32c3
--- /dev/null
+++ b/drivers/nvme/host/trace-tcp.h
@@ -0,0 +1,209 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM nvme_tcp
+
+#if !defined(_TRACE_NVME_TCP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_NVME_TCP_H
+
+#include <linux/nvme.h>
+#include <linux/tracepoint.h>
+#include <linux/trace_seq.h>
+
+#include "nvme.h"
+
+TRACE_EVENT(nvme_tcp_queue_rq,
+	TP_PROTO(struct request *rq),
+	TP_ARGS(rq),
+	TP_STRUCT__entry(
+		__field(unsigned, ctrl_id)
+		__field(unsigned, qid)
+		__field(unsigned, op)
+		__field(unsigned, tag)
+		__field(unsigned, len)
+	),
+	TP_fast_assign(
+		__entry->ctrl_id = nvme_req(rq)->ctrl->instance;
+		__entry->qid = nvme_req_qid(rq);
+		__entry->op = req_op(rq);
+		__entry->tag = rq->tag;
+		__entry->len = blk_rq_payload_bytes(rq);
+	),
+	TP_printk("nvme%u: qid=%u tag=%x op=%x data_len=%u",
+		__entry->ctrl_id, __entry->qid, __entry->tag, __entry->op,
+		__entry->len
+	)
+);
+
+TRACE_EVENT(nvme_tcp_cmd_pdu,
+	TP_PROTO(struct request *rq, struct nvme_tcp_request *req, unsigned offset, unsigned len),
+	TP_ARGS(rq, req, offset, len),
+	TP_STRUCT__entry(
+		__field(unsigned, ctrl_id)
+		__field(unsigned, qid)
+		__field(unsigned, op)
+		__field(unsigned, tag)
+		__field(unsigned, page_offset)
+		__field(unsigned, len)
+	),
+	TP_fast_assign(
+		__entry->ctrl_id = nvme_req(rq)->ctrl->instance;
+		__entry->qid = nvme_req_qid(rq);
+		__entry->op = req_op(rq);
+		__entry->tag = rq->tag;
+		__entry->page_offset = offset;
+		__entry->len = len;
+	),
+	TP_printk("nvme%u: qid=%u tag=%x op=%x page_offset=%u send_len=%u",
+		__entry->ctrl_id, __entry->qid, __entry->tag, __entry->op,
+		__entry->page_offset, __entry->len
+	)
+);
+
+TRACE_EVENT(nvme_tcp_h2c_pdu,
+	TP_PROTO(struct request *rq, struct nvme_tcp_request *req, unsigned offset, unsigned len),
+	TP_ARGS(rq, req, offset, len),
+	TP_STRUCT__entry(
+		__field(unsigned, ctrl_id)
+		__field(unsigned, qid)
+		__field(unsigned, op)
+		__field(unsigned, tag)
+		__field(unsigned, page_offset)
+		__field(unsigned, len)
+	),
+	TP_fast_assign(
+		__entry->ctrl_id = nvme_req(rq)->ctrl->instance;
+		__entry->qid = nvme_req_qid(rq);
+		__entry->op = req_op(rq);
+		__entry->tag = rq->tag;
+		__entry->page_offset = offset;
+		__entry->len = len;
+	),
+	TP_printk("nvme%u: qid=%u tag=%x op=%x page_offset=%u send_len=%u",
+		__entry->ctrl_id, __entry->qid, __entry->tag, __entry->op,
+		__entry->page_offset, __entry->len
+	)
+);
+
+TRACE_EVENT(nvme_tcp_data,
+	TP_PROTO(struct request *rq, struct nvme_tcp_request *req, unsigned offset, unsigned len, bool last),
+	TP_ARGS(rq, req, offset, len, last),
+	TP_STRUCT__entry(
+		__field(unsigned, ctrl_id)
+		__field(unsigned, qid)
+		__field(unsigned, op)
+		__field(unsigned, tag)
+		__field(unsigned, page_offset)
+		__field(unsigned, len)
+		__field(unsigned, sent)
+		__field(bool, last)
+	),
+	TP_fast_assign(
+		__entry->ctrl_id = nvme_req(rq)->ctrl->instance;
+		__entry->qid = nvme_req_qid(rq);
+		__entry->op = req_op(rq);
+		__entry->tag = rq->tag;
+		__entry->page_offset = offset;
+		__entry->len = len;
+		__entry->sent = req->pdu_sent;
+		__entry->last = last;
+	),
+	TP_printk("nvme%u: qid=%u tag=%x op=%x page_offset=%u send_len=%u pdu_sent=%u last=%u",
+		__entry->ctrl_id, __entry->qid, __entry->tag, __entry->op,
+		__entry->page_offset, __entry->len, __entry->sent, __entry->last
+	)
+);
+
+TRACE_EVENT(nvme_tcp_r2t,
+	TP_PROTO(struct request *rq, struct nvme_tcp_request *req, unsigned offset),
+	TP_ARGS(rq, req, offset),
+	TP_STRUCT__entry(
+		__field(unsigned, ctrl_id)
+		__field(unsigned, qid)
+		__field(unsigned, op)
+		__field(unsigned, tag)
+		__field(unsigned, len)
+		__field(unsigned, offset)
+		__field(unsigned, sent)
+		__field(unsigned, data_len)
+	),
+	TP_fast_assign(
+		__entry->ctrl_id = nvme_req(rq)->ctrl->instance;
+		__entry->qid = nvme_req_qid(rq);
+		__entry->op = req_op(rq);
+		__entry->tag = rq->tag;
+		__entry->len = req->pdu_len;
+		__entry->offset = offset;
+		__entry->sent = req->data_sent;
+		__entry->data_len = req->data_len;
+	),
+	TP_printk("nvme%u: qid=%u tag=%x op=%x r2t_len=%u r2t_offset=%u data_sent=%u data_len=%u",
+		__entry->ctrl_id, __entry->qid, __entry->tag, __entry->op,
+		__entry->len, __entry->offset, __entry->sent, __entry->data_len
+	)
+);
+
+TRACE_EVENT(nvme_tcp_c2h,
+	TP_PROTO(struct request *rq, struct nvme_tcp_data_pdu *pdu),
+	TP_ARGS(rq, pdu),
+	TP_STRUCT__entry(
+		__field(unsigned, ctrl_id)
+		__field(unsigned, qid)
+		__field(unsigned, op)
+		__field(unsigned, tag)
+		__field(unsigned, flags)
+		__field(unsigned, data_len)
+	),
+	TP_fast_assign(
+		__entry->ctrl_id = nvme_req(rq)->ctrl->instance;
+		__entry->qid = nvme_req_qid(rq);
+		__entry->op = req_op(rq);
+		__entry->tag = rq->tag;
+		__entry->flags = pdu->hdr.flags;
+		__entry->data_len = le32_to_cpu(pdu->data_length);
+	),
+	TP_printk("nvme%u: qid=%u tag=%x op=%x data_len=%u flags=%#x",
+		__entry->ctrl_id, __entry->qid, __entry->tag, __entry->op,
+		__entry->data_len, __entry->flags
+	)
+);
+
+TRACE_EVENT(nvme_tcp_recv_data,
+	TP_PROTO(struct request *rq, struct nvme_tcp_queue *queue, struct nvme_tcp_data_pdu *pdu, unsigned offset, unsigned len),
+	TP_ARGS(rq, queue, pdu, offset, len),
+	TP_STRUCT__entry(
+		__field(unsigned, ctrl_id)
+		__field(unsigned, qid)
+		__field(unsigned, op)
+		__field(unsigned, tag)
+		__field(unsigned, flags)
+		__field(unsigned, data_len)
+		__field(unsigned, offset)
+		__field(unsigned, data_remaining)
+	),
+	TP_fast_assign(
+		__entry->ctrl_id = nvme_req(rq)->ctrl->instance;
+		__entry->qid = nvme_req_qid(rq);
+		__entry->op = req_op(rq);
+		__entry->tag = rq->tag;
+		__entry->flags = pdu->hdr.flags;
+		__entry->data_len = len;
+		__entry->offset = offset;
+		__entry->data_remaining = queue->data_remaining;
+	),
+	TP_printk("nvme%u: qid=%u tag=%x op=%x data_len=%u offset=%u flags=%#x data_remaining=%u",
+		__entry->ctrl_id, __entry->qid, __entry->tag, __entry->op,
+		__entry->data_len, __entry->offset, __entry->flags,
+		__entry->data_remaining
+	)
+);
+
+#endif /* _TRACE_NVME_TCP_H */
+
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_FILE trace-tcp
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
