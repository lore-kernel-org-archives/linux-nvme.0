Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FBEF506DA
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Mar 2026 14:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Al3sF7y/HAkM5/P8DHNVoK8rqXBGABJepl8NnguyaQw=; b=NFyABia5yQQcW7O8pnnr0Z9dj6
	6lakOH1fqyz8n8I81sSLFMuWrnGGWTXz5/rQ71gJZDrtN5C8rCOkCtXnART5Ucw+Ri8KvLRpO9Um5
	13w0RE5joS5hmSxQM1avQZaiL4pRg58jJHzxGKK5S2rZFUZcIxakrtzpI+IjD8imo0lbqcF9Bx9AX
	BZLSdeS1MtQ22l++7pPamyAmyaKJ18HahgrCniVqIyBuuVq9fYE3cnNUN5EscUCD+XAxtrxcIX+/n
	OZ+eEI9p/X5ZCAWbT/HXRf69tLthlOnUkfeeZdhICRJJBhhDRq7kI4RkV2Hzb4umCjOnb/T7TeeT2
	lLXk+uGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w296w-00000004Cg5-1ncf;
	Mon, 16 Mar 2026 14:40:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w296q-00000004Ccm-1Psw
	for linux-nvme@lists.infradead.org;
	Mon, 16 Mar 2026 14:40:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773671995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Al3sF7y/HAkM5/P8DHNVoK8rqXBGABJepl8NnguyaQw=;
	b=LEQZonxN00omY4hX3Ng+ORmLxX9OTNLgPrsy7O/4NGBGCeQnLdAXM3bV2ov0VrzRwciko1
	1bFVhKiHi+JjuFJOff2epIC5kUHxca4Vo1vlSJK9wbLg0wDDgX2K3XLkv2qbk1vgDIiIXq
	znOq2TJerY4ivQPDHA4nWRSMWtibcPY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-421-epiXdGV8NSOjN6obdOVOSg-1; Mon,
 16 Mar 2026 10:39:50 -0400
X-MC-Unique: epiXdGV8NSOjN6obdOVOSg-1
X-Mimecast-MFC-AGG-ID: epiXdGV8NSOjN6obdOVOSg_1773671989
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 78B76195605E;
	Mon, 16 Mar 2026 14:39:48 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.45.224.106])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 973A119560B1;
	Mon, 16 Mar 2026 14:39:45 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	yjshin0438@gmail.com,
	hare@suse.de,
	sagi@grimberg.me,
	chaitanyak@nvidia.com,
	mlombard@arkamax.eu
Subject: [PATCH V3 2/2] nvmet-tcp: remove redundant calls to nvmet_tcp_fatal_error()
Date: Mon, 16 Mar 2026 15:39:36 +0100
Message-ID: <20260316143936.120999-3-mlombard@redhat.com>
In-Reply-To: <20260316143936.120999-1-mlombard@redhat.com>
References: <20260316143936.120999-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: z17OngTrT1kaKOLqhQufDmoDZoB3B7jai9DyYtDAask_1773671989
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260316_073956_448021_E90FF231 
X-CRM114-Status: GOOD (  12.15  )
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

Executing nvmet_tcp_fatal_error() is generally the responsibility
of the caller (nvmet_tcp_try_recv); all other functions should
just return the error code.

Remove the nvmet_tcp_fatal_error() function, it's not needed
anymore.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/tcp.c | 37 +++++++------------------------------
 1 file changed, 7 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 1fbf12df1183..462010654059 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -349,8 +349,6 @@ static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd)
 	cmd->req.sg = NULL;
 }
 
-static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue);
-
 static int nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 {
 	struct bio_vec *iov = cmd->iov;
@@ -394,22 +392,13 @@ static int nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
 	return 0;
 }
 
-static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)
-{
-	queue->rcv_state = NVMET_TCP_RECV_ERR;
-	if (queue->nvme_sq.ctrl)
-		nvmet_ctrl_fatal_error(queue->nvme_sq.ctrl);
-	else
-		kernel_sock_shutdown(queue->sock, SHUT_RDWR);
-}
-
 static void nvmet_tcp_socket_error(struct nvmet_tcp_queue *queue, int status)
 {
 	queue->rcv_state = NVMET_TCP_RECV_ERR;
-	if (status == -EPIPE || status == -ECONNRESET)
+	if (status == -EPIPE || status == -ECONNRESET || !queue->nvme_sq.ctrl)
 		kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	else
-		nvmet_tcp_fatal_error(queue);
+		nvmet_ctrl_fatal_error(queue->nvme_sq.ctrl);
 }
 
 static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
@@ -885,7 +874,6 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 	if (le32_to_cpu(icreq->hdr.plen) != sizeof(struct nvme_tcp_icreq_pdu)) {
 		pr_err("bad nvme-tcp pdu length (%d)\n",
 			le32_to_cpu(icreq->hdr.plen));
-		nvmet_tcp_fatal_error(queue);
 		return -EPROTO;
 	}
 
@@ -951,7 +939,6 @@ static int nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
 	ret = nvmet_tcp_map_data(cmd);
 	if (unlikely(ret)) {
 		pr_err("queue %d: failed to map data\n", queue->idx);
-		nvmet_tcp_fatal_error(queue);
 		return -EPROTO;
 	}
 
@@ -1024,7 +1011,6 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 
 err_proto:
 	/* FIXME: use proper transport errors */
-	nvmet_tcp_fatal_error(queue);
 	return -EPROTO;
 }
 
@@ -1039,7 +1025,6 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 		if (hdr->type != nvme_tcp_icreq) {
 			pr_err("unexpected pdu type (%d) before icreq\n",
 				hdr->type);
-			nvmet_tcp_fatal_error(queue);
 			return -EPROTO;
 		}
 		return nvmet_tcp_handle_icreq(queue);
@@ -1048,7 +1033,6 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 	if (unlikely(hdr->type == nvme_tcp_icreq)) {
 		pr_err("queue %d: received icreq pdu in state %d\n",
 			queue->idx, queue->state);
-		nvmet_tcp_fatal_error(queue);
 		return -EPROTO;
 	}
 
@@ -1065,7 +1049,6 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 		pr_err("queue %d: out of commands (%d) send_list_len: %d, opcode: %d",
 			queue->idx, queue->nr_cmds, queue->send_list_len,
 			nvme_cmd->common.opcode);
-		nvmet_tcp_fatal_error(queue);
 		return -ENOMEM;
 	}
 
@@ -1086,9 +1069,9 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 	if (unlikely(ret)) {
 		pr_err("queue %d: failed to map data\n", queue->idx);
 		if (nvmet_tcp_has_inline_data(queue->cmd))
-			nvmet_tcp_fatal_error(queue);
-		else
-			nvmet_req_complete(req, ret);
+			return -EPROTO;
+
+		nvmet_req_complete(req, ret);
 		ret = -EAGAIN;
 		goto out;
 	}
@@ -1211,7 +1194,6 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 
 		if (unlikely(!nvmet_tcp_pdu_valid(hdr->type))) {
 			pr_err("unexpected pdu type %d\n", hdr->type);
-			nvmet_tcp_fatal_error(queue);
 			return -EIO;
 		}
 
@@ -1225,16 +1207,12 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 	}
 
 	if (queue->hdr_digest &&
-	    nvmet_tcp_verify_hdgst(queue, &queue->pdu, hdr->hlen)) {
-		nvmet_tcp_fatal_error(queue); /* fatal */
+	    nvmet_tcp_verify_hdgst(queue, &queue->pdu, hdr->hlen))
 		return -EPROTO;
-	}
 
 	if (queue->data_digest &&
-	    nvmet_tcp_check_ddgst(queue, &queue->pdu)) {
-		nvmet_tcp_fatal_error(queue); /* fatal */
+	    nvmet_tcp_check_ddgst(queue, &queue->pdu))
 		return -EPROTO;
-	}
 
 	return nvmet_tcp_done_recv_pdu(queue);
 }
@@ -1319,7 +1297,6 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 			le32_to_cpu(cmd->exp_ddgst));
 		nvmet_req_uninit(&cmd->req);
 		nvmet_tcp_free_cmd_buffers(cmd);
-		nvmet_tcp_fatal_error(queue);
 		ret = -EPROTO;
 		goto out;
 	}
-- 
2.53.0


