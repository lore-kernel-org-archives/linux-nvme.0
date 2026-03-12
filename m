Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3DB103E2EB
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2026 13:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iQN41wOknlIInbmR9NmLdJHoVlTuScZFVtDN8z3cJxE=; b=1GJz+3aPgPkAjYC9cJXe5EI/A0
	Sg2o073MC3G2Ps1IC7MwTZ1N/oGU/bSQNcg6o0ZMBBZyhyu/v34jEid86lTSbzw67mKcG1cFsp11M
	QxQQ4Msu4yexEyAPpfgvnLRNNo35cP+2ijI4AJg/OhJv7/jPeKc1iYY1RIbj6Ui9qpWYiNycEEHdX
	qlOoo9i63yzQ1YxK5AmqTYg3W/ecHz+2woacnbh0NWqSsyyXOUuUCFVoY2ROxRVFnfP4dYvvd8PUb
	ZO/qjxBHwDc/gDN5/RlC5/akyQIGoQppc7eezBrpa6HSDX0mBjyuyNRF2vBMWH5xNLy6judRYpQmT
	Ex8/ZxNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0gHx-0000000E8xs-07MD;
	Thu, 12 Mar 2026 13:41:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0gHr-0000000E8wz-2UI6
	for linux-nvme@lists.infradead.org;
	Thu, 12 Mar 2026 13:41:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773322874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iQN41wOknlIInbmR9NmLdJHoVlTuScZFVtDN8z3cJxE=;
	b=d1ucDfrlGA9sc6am2lp0LJEZuAyOY25DzEj8sai0mT6sEaVYJpYkSIHa4wxFPLavYUZ6f5
	qyNZoSt8AKt1D0L+GQQLWHatQIFJzrCRpJA85HubczwE0uz1SctoahucBpbfqTG5QPHKPJ
	3uJiIF8O5eLEpHWgaeBAE+MRoXbQJus=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-5lqKO3wMOPajgCP6D91jdA-1; Thu,
 12 Mar 2026 09:41:11 -0400
X-MC-Unique: 5lqKO3wMOPajgCP6D91jdA-1
X-Mimecast-MFC-AGG-ID: 5lqKO3wMOPajgCP6D91jdA_1773322866
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A86718002DC;
	Thu, 12 Mar 2026 13:41:06 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.45.224.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ABEA519540C2;
	Thu, 12 Mar 2026 13:41:03 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	yjshin0438@gmail.com,
	hare@suse.de,
	sagi@grimberg.me,
	chaitanyak@nvidia.com,
	mlombard@arkamax.eu
Subject: [PATCH V2 1/2] nvmet-tcp: propagate nvmet_tcp_build_pdu_iovec() errors to its callers
Date: Thu, 12 Mar 2026 14:40:56 +0100
Message-ID: <20260312134057.110274-2-mlombard@redhat.com>
In-Reply-To: <20260312134057.110274-1-mlombard@redhat.com>
References: <20260312134057.110274-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: N5nHmc0Avi7VozHbJuwGeaWNochAPBbATCT6JyA1Xok_1773322866
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_064115_731481_5E2AF240 
X-CRM114-Status: GOOD (  15.15  )
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

Currently, when nvmet_tcp_build_pdu_iovec() detects an out-of-bounds
PDU length or offset, it triggers nvmet_tcp_fatal_error(cmd->queue)
and returns early. However, because the function returns void, the
callers are entirely unaware that a fatal error has occurred and
that the cmd->recv_msg.msg_iter was left uninitialized.

Callers such as nvmet_tcp_handle_h2c_data_pdu() proceed to blindly
overwrite the queue state with queue->rcv_state = NVMET_TCP_RECV_DATA
Consequently, the socket receiving loop may attempt to read incoming
network data into the uninitialized iterator.

Fix this by shifting the error handling responsibility to the callers.

Fixes: 52a0a9854934 ("nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec")
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/tcp.c | 51 ++++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index acc71a26733f..1fbf12df1183 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -351,7 +351,7 @@ static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd)
 
 static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue);
 
-static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
+static int nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 {
 	struct bio_vec *iov = cmd->iov;
 	struct scatterlist *sg;
@@ -364,22 +364,19 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	offset = cmd->rbytes_done;
 	cmd->sg_idx = offset / PAGE_SIZE;
 	sg_offset = offset % PAGE_SIZE;
-	if (!cmd->req.sg_cnt || cmd->sg_idx >= cmd->req.sg_cnt) {
-		nvmet_tcp_fatal_error(cmd->queue);
-		return;
-	}
+	if (!cmd->req.sg_cnt || cmd->sg_idx >= cmd->req.sg_cnt)
+		return -EPROTO;
+
 	sg = &cmd->req.sg[cmd->sg_idx];
 	sg_remaining = cmd->req.sg_cnt - cmd->sg_idx;
 
 	while (length) {
-		if (!sg_remaining) {
-			nvmet_tcp_fatal_error(cmd->queue);
-			return;
-		}
-		if (!sg->length || sg->length <= sg_offset) {
-			nvmet_tcp_fatal_error(cmd->queue);
-			return;
-		}
+		if (!sg_remaining)
+			return -EPROTO;
+
+		if (!sg->length || sg->length <= sg_offset)
+			return -EPROTO;
+
 		u32 iov_len = min_t(u32, length, sg->length - sg_offset);
 
 		bvec_set_page(iov, sg_page(sg), iov_len,
@@ -394,6 +391,7 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 
 	iov_iter_bvec(&cmd->recv_msg.msg_iter, ITER_DEST, cmd->iov,
 		      nr_pages, cmd->pdu_len);
+	return 0;
 }
 
 static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
@@ -931,7 +929,7 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 	return 0;
 }
 
-static void nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
+static int nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd, struct nvmet_req *req)
 {
 	size_t data_len = le32_to_cpu(req->cmd->common.dptr.sgl.length);
@@ -947,19 +945,23 @@ static void nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
 	if (!nvme_is_write(cmd->req.cmd) || !data_len ||
 	    data_len > cmd->req.port->inline_data_size) {
 		nvmet_prepare_receive_pdu(queue);
-		return;
+		return 0;
 	}
 
 	ret = nvmet_tcp_map_data(cmd);
 	if (unlikely(ret)) {
 		pr_err("queue %d: failed to map data\n", queue->idx);
 		nvmet_tcp_fatal_error(queue);
-		return;
+		return -EPROTO;
 	}
 
 	queue->rcv_state = NVMET_TCP_RECV_DATA;
-	nvmet_tcp_build_pdu_iovec(cmd);
 	cmd->flags |= NVMET_TCP_F_INIT_FAILED;
+	ret = nvmet_tcp_build_pdu_iovec(cmd);
+	if (unlikely(ret))
+		pr_err("queue %d: failed to build PDU iovec\n", queue->idx);
+
+	return ret;
 }
 
 static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
@@ -1011,7 +1013,10 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 		goto err_proto;
 	}
 	cmd->pdu_recv = 0;
-	nvmet_tcp_build_pdu_iovec(cmd);
+	if (unlikely(nvmet_tcp_build_pdu_iovec(cmd))) {
+		pr_err("queue %d: failed to build PDU iovec\n", queue->idx);
+		goto err_proto;
+	}
 	queue->cmd = cmd;
 	queue->rcv_state = NVMET_TCP_RECV_DATA;
 
@@ -1074,8 +1079,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 			le32_to_cpu(req->cmd->common.dptr.sgl.length),
 			le16_to_cpu(req->cqe->status));
 
-		nvmet_tcp_handle_req_failure(queue, queue->cmd, req);
-		return 0;
+		return nvmet_tcp_handle_req_failure(queue, queue->cmd, req);
 	}
 
 	ret = nvmet_tcp_map_data(queue->cmd);
@@ -1092,8 +1096,11 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 	if (nvmet_tcp_need_data_in(queue->cmd)) {
 		if (nvmet_tcp_has_inline_data(queue->cmd)) {
 			queue->rcv_state = NVMET_TCP_RECV_DATA;
-			nvmet_tcp_build_pdu_iovec(queue->cmd);
-			return 0;
+			ret = nvmet_tcp_build_pdu_iovec(queue->cmd);
+			if (unlikely(ret))
+				pr_err("queue %d: failed to build PDU iovec\n",
+					queue->idx);
+			return ret;
 		}
 		/* send back R2T */
 		nvmet_tcp_queue_response(&queue->cmd->req);
-- 
2.53.0


