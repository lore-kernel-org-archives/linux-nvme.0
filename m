Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FA01125853
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2026 13:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+2lg2vqV+nQfewIUx587QPOo0dYSDL4oItj4qHsS6lU=; b=AgIXuShwpo9iKaqcNWHOX3Vsua
	ib6IJuqzBm5LIkOBwthNJxvlRXzRju+nB4XtbFV8PpU+alO7JqggAcXg9L9SBobNr12LAnSA3bMc4
	qW+pOhApLIiSIALj0mNwOr6jBI32o5czfw233uCQKaqXmpVEcz2tQZ62nv3gejlXE5WBTgZuwj7Xx
	TxDvyYZh90+dOIyF+bHOOYyBwD7QUFmRUI209zlok08KdLsa4xmpnmIH3WB6xy1UhMK0OppKlPewl
	WIre7PV1ne758ePtW7Lc58aSzTsVsh7ps4kcAfKHYm15Chsttrs1Uf2M73uUzzxQvL+NHwNXCPJvJ
	EVVIXXOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0gI4-0000000E8zS-1Q0W;
	Thu, 12 Mar 2026 13:41:28 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0gI2-0000000E8yo-1eeq
	for linux-nvme@lists.infradead.org;
	Thu, 12 Mar 2026 13:41:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773322885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+2lg2vqV+nQfewIUx587QPOo0dYSDL4oItj4qHsS6lU=;
	b=PJtQqyaJmwb1CItldVinXjss4XKG87yEpFYUylF3kutcKtpr8PkIRQ8axWvMq6XnaYL73R
	iAHJ03VWL/ts3Tvi/Or2+RfupAU3Vpy5aceAYYOwUQmTzUAmowuGiyjVW70JNcnuTJsVh/
	2oDIPoeQQwK9mdwOZSnhzLG9L0LLP8w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-Af-sezeEPw22NJNqirj5aQ-1; Thu,
 12 Mar 2026 09:41:20 -0400
X-MC-Unique: Af-sezeEPw22NJNqirj5aQ-1
X-Mimecast-MFC-AGG-ID: Af-sezeEPw22NJNqirj5aQ_1773322870
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3AE2019560B7;
	Thu, 12 Mar 2026 13:41:10 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.45.224.57])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A7B819540C2;
	Thu, 12 Mar 2026 13:41:06 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	yjshin0438@gmail.com,
	hare@suse.de,
	sagi@grimberg.me,
	chaitanyak@nvidia.com,
	mlombard@arkamax.eu
Subject: [PATCH V2 2/2] nvmet-tcp: remove redundant calls to nvmet_tcp_fatal_error()
Date: Thu, 12 Mar 2026 14:40:57 +0100
Message-ID: <20260312134057.110274-3-mlombard@redhat.com>
In-Reply-To: <20260312134057.110274-1-mlombard@redhat.com>
References: <20260312134057.110274-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3PDuSuTNiWNLWny_JRQ8jPlfoLZLr5DHkyEW9st1mnE_1773322870
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260312_064126_503496_92386D36 
X-CRM114-Status: GOOD (  11.04  )
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
index 1fbf12df1183..b250b13854b4 100644
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
 
@@ -1024,7 +1022,6 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 
 err_proto:
 	/* FIXME: use proper transport errors */
-	nvmet_tcp_fatal_error(queue);
 	return -EPROTO;
 }
 
@@ -1039,7 +1036,6 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 		if (hdr->type != nvme_tcp_icreq) {
 			pr_err("unexpected pdu type (%d) before icreq\n",
 				hdr->type);
-			nvmet_tcp_fatal_error(queue);
 			return -EPROTO;
 		}
 		return nvmet_tcp_handle_icreq(queue);
@@ -1048,7 +1044,6 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 	if (unlikely(hdr->type == nvme_tcp_icreq)) {
 		pr_err("queue %d: received icreq pdu in state %d\n",
 			queue->idx, queue->state);
-		nvmet_tcp_fatal_error(queue);
 		return -EPROTO;
 	}
 
@@ -1065,7 +1060,6 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 		pr_err("queue %d: out of commands (%d) send_list_len: %d, opcode: %d",
 			queue->idx, queue->nr_cmds, queue->send_list_len,
 			nvme_cmd->common.opcode);
-		nvmet_tcp_fatal_error(queue);
 		return -ENOMEM;
 	}
 
@@ -1086,9 +1080,9 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
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
@@ -1211,7 +1205,6 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 
 		if (unlikely(!nvmet_tcp_pdu_valid(hdr->type))) {
 			pr_err("unexpected pdu type %d\n", hdr->type);
-			nvmet_tcp_fatal_error(queue);
 			return -EIO;
 		}
 
@@ -1225,16 +1218,12 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
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
@@ -1319,7 +1308,6 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 			le32_to_cpu(cmd->exp_ddgst));
 		nvmet_req_uninit(&cmd->req);
 		nvmet_tcp_free_cmd_buffers(cmd);
-		nvmet_tcp_fatal_error(queue);
 		ret = -EPROTO;
 		goto out;
 	}
-- 
2.53.0


