Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09045112584F
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2026 16:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hFTKkmgStbpruWvWnD8RMzpGwh+Vvjn72pyx4wQH9l8=; b=CCqiWCxkFZZApvNxKi+RRCPL4h
	qlSgFsbG+ms8jxmJg2rSheERRinV9il2Rd3id1dlAAMJ2OEtj+RZTu3tSj891f91czDx8MsGB/Aks
	Xm2kIi5yU7tfpIBG+20mh4+tyLv/ucRw9dZxG/r9tn1WApOg9iObghIFdm1h7tX1VpemCaSxHUwqK
	Y2lbqbqGcrOuDifu1o1q697jN0xr2oVPnwpwij9PrDwWXcuxE3+fYkujQaiAQqCJvFd2g8ezfaTdR
	B4opwgHybj/zTjvqFNchqaxQBAK8rhVUEl58ea4Ln5pWmDbYcErLlhAeM+hprMOhflhq9cu7vBIEY
	pkffnHkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0M83-0000000BtMv-1XRr;
	Wed, 11 Mar 2026 16:09:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0M7v-0000000BtHg-0qlg
	for linux-nvme@lists.infradead.org;
	Wed, 11 Mar 2026 16:09:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773245378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFTKkmgStbpruWvWnD8RMzpGwh+Vvjn72pyx4wQH9l8=;
	b=WxrcJMw9cQNAtVxphh1nYPqe1KHrvJ/YzAQmvnXKx9Wmww3XGAZenZ+cy77e8hiMivUIRt
	pU+FsJVm8aOS3JZqsMfDK2QGtCg6FLfjX4svYcU7xq9261zU4OcYb8acEwhgpLoFhcztU9
	7gZtxMaGYuF5rlVmkU8FSGZLg2c5l40=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-27-2XWaAPM4PF-_slNODkF-KA-1; Wed,
 11 Mar 2026 12:09:33 -0400
X-MC-Unique: 2XWaAPM4PF-_slNODkF-KA-1
X-Mimecast-MFC-AGG-ID: 2XWaAPM4PF-_slNODkF-KA_1773245372
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0B1A81800611;
	Wed, 11 Mar 2026 16:09:32 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.138])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 339143000223;
	Wed, 11 Mar 2026 16:09:28 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	yjshin0438@gmail.com,
	hare@suse.de,
	sagi@grimberg.me,
	chaitanyak@nvidia.com,
	mlombard@arkamax.eu
Subject: [PATCH 2/2] nvmet-tcp: remove redundant calls to nvmet_tcp_fatal_error()
Date: Wed, 11 Mar 2026 17:09:20 +0100
Message-ID: <20260311160920.465209-3-mlombard@redhat.com>
In-Reply-To: <20260311160920.465209-1-mlombard@redhat.com>
References: <20260311160920.465209-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ltpZ8YAh-hYU3aLS9LlLpzIM0Fu49Ud1ZPDVB8roYLo_1773245372
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260311_090939_325738_11234D64 
X-CRM114-Status: GOOD (  11.16  )
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

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/tcp.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index dc1311cde04c..3e70fafd9359 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -885,7 +885,6 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 	if (le32_to_cpu(icreq->hdr.plen) != sizeof(struct nvme_tcp_icreq_pdu)) {
 		pr_err("bad nvme-tcp pdu length (%d)\n",
 			le32_to_cpu(icreq->hdr.plen));
-		nvmet_tcp_fatal_error(queue);
 		return -EPROTO;
 	}
 
@@ -951,7 +950,6 @@ static int nvmet_tcp_handle_req_failure(struct nvmet_tcp_queue *queue,
 	ret = nvmet_tcp_map_data(cmd);
 	if (unlikely(ret)) {
 		pr_err("queue %d: failed to map data\n", queue->idx);
-		nvmet_tcp_fatal_error(queue);
 		return -EPROTO;
 	}
 
@@ -1026,7 +1024,6 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 
 err_proto:
 	/* FIXME: use proper transport errors */
-	nvmet_tcp_fatal_error(queue);
 	return -EPROTO;
 }
 
@@ -1041,7 +1038,6 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 		if (hdr->type != nvme_tcp_icreq) {
 			pr_err("unexpected pdu type (%d) before icreq\n",
 				hdr->type);
-			nvmet_tcp_fatal_error(queue);
 			return -EPROTO;
 		}
 		return nvmet_tcp_handle_icreq(queue);
@@ -1050,7 +1046,6 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 	if (unlikely(hdr->type == nvme_tcp_icreq)) {
 		pr_err("queue %d: received icreq pdu in state %d\n",
 			queue->idx, queue->state);
-		nvmet_tcp_fatal_error(queue);
 		return -EPROTO;
 	}
 
@@ -1067,7 +1062,6 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 		pr_err("queue %d: out of commands (%d) send_list_len: %d, opcode: %d",
 			queue->idx, queue->nr_cmds, queue->send_list_len,
 			nvme_cmd->common.opcode);
-		nvmet_tcp_fatal_error(queue);
 		return -ENOMEM;
 	}
 
@@ -1088,9 +1082,9 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
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
@@ -1215,7 +1209,6 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 
 		if (unlikely(!nvmet_tcp_pdu_valid(hdr->type))) {
 			pr_err("unexpected pdu type %d\n", hdr->type);
-			nvmet_tcp_fatal_error(queue);
 			return -EIO;
 		}
 
@@ -1229,16 +1222,12 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
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
@@ -1323,7 +1312,6 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 			le32_to_cpu(cmd->exp_ddgst));
 		nvmet_req_uninit(&cmd->req);
 		nvmet_tcp_free_cmd_buffers(cmd);
-		nvmet_tcp_fatal_error(queue);
 		ret = -EPROTO;
 		goto out;
 	}
-- 
2.53.0


