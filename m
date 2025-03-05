Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E12BEC28B24
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Mar 2025 14:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZFwFh02FLkFHGnry4OgJRSSnzYxGAK/C3dd8k6+1rXk=; b=K3B3MDaoTwAviAd61nT9Z4s/MZ
	K4QCRqPrbVHUykuRm62Gn2tclMrOBkyYWK6pp2mFFYfXVJWzEs+YtvFIy4mkPtZTdbs7ScWF4zw7C
	BY/Jb7uQrBWw3y7R3aYwuSwBTjmV0zituELs/dFulRHDRBgT8TIGd1P98TmYXzs4fHGv0vcr2pJhH
	COc/pJYZ0wrU1X1DTmF8yhHalgot37RaWeV8fQ9rg+WvI0qetwlx5VW0OBeUm1PrZDcB4GvxmWs1J
	g0CeNVy4sNsJ3SkZD6JPlBL2epHcmFqehEkoZNS+RRXY9MOXsWrur5FA2Ds4/FdpG4fIPoJZQsC5M
	AnluOKbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpq3F-00000008PD4-06k9;
	Wed, 05 Mar 2025 14:48:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpomC-00000008BkV-367O
	for linux-nvme@lists.infradead.org;
	Wed, 05 Mar 2025 13:27:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741181226;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZFwFh02FLkFHGnry4OgJRSSnzYxGAK/C3dd8k6+1rXk=;
	b=N73xi8HgTUuvty4t7NOlaSbE9WM4kqQuQH9WPKAmT9x35EsJJ/VN8qzTPlCzSo6P3rR9Ej
	2mYJ68glYKSSa4OKaW4MqnrIU3JTcpBxkksDTlMASsPt7cHutu8UhixWgfuUwHrsWj8a8I
	/DWW/H/sqlih0l/zXKNChlPJc0W62WA=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-12-_dBI4qGCMzKeTF8Vrl6qwQ-1; Wed,
 05 Mar 2025 08:27:04 -0500
X-MC-Unique: _dBI4qGCMzKeTF8Vrl6qwQ-1
X-Mimecast-MFC-AGG-ID: _dBI4qGCMzKeTF8Vrl6qwQ_1741181223
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 46B851955DBA;
	Wed,  5 Mar 2025 13:27:02 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.44.32.245])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E76651800255;
	Wed,  5 Mar 2025 13:26:58 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: sagi@grimberg.me
Cc: kch@nvidia.com,
	hare@suse.com,
	mlombard@bsdbackstore.eu,
	linux-nvme@lists.infradead.org,
	kbusch@meta.com
Subject: [PATCH] nvmet-tcp: remove redundant calls to nvmet_tcp_fatal_error()
Date: Wed,  5 Mar 2025 14:26:42 +0100
Message-ID: <20250305132642.1271523-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vNBV_u2cY02xifNNz-9wTUsndpWPUzijD-THXxpVEsE_1741181223
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_052708_844854_271F9ADF 
X-CRM114-Status: UNSURE (   8.77  )
X-CRM114-Notice: Please train this message.
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
of the caller (nvmet_tcp_try_recv); most other functions should
just return the error code, with minor exceptions where direct
handling is necessary.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/tcp.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7c51c2a8c109..50bb5c8737c9 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -898,7 +898,6 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 	if (le32_to_cpu(icreq->hdr.plen) != sizeof(struct nvme_tcp_icreq_pdu)) {
 		pr_err("bad nvme-tcp pdu length (%d)\n",
 			le32_to_cpu(icreq->hdr.plen));
-		nvmet_tcp_fatal_error(queue);
 		return -EPROTO;
 	}
 
@@ -1023,7 +1022,6 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 
 err_proto:
 	/* FIXME: use proper transport errors */
-	nvmet_tcp_fatal_error(queue);
 	return -EPROTO;
 }
 
@@ -1038,7 +1036,6 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 		if (hdr->type != nvme_tcp_icreq) {
 			pr_err("unexpected pdu type (%d) before icreq\n",
 				hdr->type);
-			nvmet_tcp_fatal_error(queue);
 			return -EPROTO;
 		}
 		return nvmet_tcp_handle_icreq(queue);
@@ -1047,7 +1044,6 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 	if (unlikely(hdr->type == nvme_tcp_icreq)) {
 		pr_err("queue %d: received icreq pdu in state %d\n",
 			queue->idx, queue->state);
-		nvmet_tcp_fatal_error(queue);
 		return -EPROTO;
 	}
 
@@ -1064,7 +1060,6 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 		pr_err("queue %d: out of commands (%d) send_list_len: %d, opcode: %d",
 			queue->idx, queue->nr_cmds, queue->send_list_len,
 			nvme_cmd->common.opcode);
-		nvmet_tcp_fatal_error(queue);
 		return -ENOMEM;
 	}
 
@@ -1208,7 +1203,6 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 
 		if (unlikely(!nvmet_tcp_pdu_valid(hdr->type))) {
 			pr_err("unexpected pdu type %d\n", hdr->type);
-			nvmet_tcp_fatal_error(queue);
 			return -EIO;
 		}
 
@@ -1223,13 +1217,11 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 
 	if (queue->hdr_digest &&
 	    nvmet_tcp_verify_hdgst(queue, &queue->pdu, hdr->hlen)) {
-		nvmet_tcp_fatal_error(queue); /* fatal */
 		return -EPROTO;
 	}
 
 	if (queue->data_digest &&
 	    nvmet_tcp_check_ddgst(queue, &queue->pdu)) {
-		nvmet_tcp_fatal_error(queue); /* fatal */
 		return -EPROTO;
 	}
 
@@ -1316,7 +1308,6 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 			le32_to_cpu(cmd->exp_ddgst));
 		nvmet_req_uninit(&cmd->req);
 		nvmet_tcp_free_cmd_buffers(cmd);
-		nvmet_tcp_fatal_error(queue);
 		ret = -EPROTO;
 		goto out;
 	}
-- 
2.43.5


