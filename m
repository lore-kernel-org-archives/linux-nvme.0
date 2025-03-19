Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EE8C35FFC
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Mar 2025 16:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YPxDfKiGwPpNmvGSyBoh4VSTQG+a8rXfseHb6N69v4o=; b=vPNMNlxlU6KffhVHX/mZqmRr0O
	4A78BRR9xfH3H34zjNpWpl6coixXHSKbP4IyvVNsoUlIQaf6qFjl1V9adm7oEgnv9wRptobuRJR8T
	l+HH7iGmWzy8YXTOlHqW436GP52UWdxLch3GnbCdin1HTgjlYBiH/VhcyRfbWAewTmJPxkQcO3hpT
	evIGqUr+GGzW0n46C6FLdGYIeVuN57yOs1VOTEyZniUaqEIJ5rpO7NoxF8UN/ZGMZr9XIOf7eohG4
	ehWP55gi4Gx9ZRITswZ7MnT3J20kJ55i3RzlydZZijQdCh3BYQxf7hEob/mf4KJJwCa7iLVBTSMYG
	7MPlHlRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tuwE4-00000009Xh3-411y;
	Wed, 19 Mar 2025 16:25:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tuwE2-00000009Xg1-1nHz
	for linux-nvme@lists.infradead.org;
	Wed, 19 Mar 2025 16:25:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742401501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YPxDfKiGwPpNmvGSyBoh4VSTQG+a8rXfseHb6N69v4o=;
	b=fdjyQn7Zl0m93Ykvx8kyqsCD6csjDNSvXI/UvpXxv5xdRrBchQCtq376QkOEFQ/uvg6WEW
	64VlHo9zuv2f0ZqUX69tir+C7nBSBvqQ5tNt135fqtMWJAhfnl+5h3el9d2E25HSC4+Rha
	TQ/oM6kXfOGz0N3YS2k0hcjXXFKUk0Q=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-K3kU0tzkMseT5JCVGNxGEA-1; Wed,
 19 Mar 2025 12:24:58 -0400
X-MC-Unique: K3kU0tzkMseT5JCVGNxGEA-1
X-Mimecast-MFC-AGG-ID: K3kU0tzkMseT5JCVGNxGEA_1742401497
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F12ED180AB19;
	Wed, 19 Mar 2025 16:24:56 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.77])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 681CA1956094;
	Wed, 19 Mar 2025 16:24:54 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: hare@suse.com
Cc: sagi@grimberg.me,
	mlombard@bsdbackstore.eu,
	linux-nvme@lists.infradead.org,
	kbusch@meta.com
Subject: [PATCH RFC 1/1] nvmet-tcp: add support for C2HTermReq
Date: Wed, 19 Mar 2025 17:24:49 +0100
Message-ID: <20250319162449.342649-2-mlombard@redhat.com>
In-Reply-To: <20250319162449.342649-1-mlombard@redhat.com>
References: <20250319162449.342649-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GltwEieePwQ7HOhpq3-u2eBG3aBMbrsa3uPywsves6w_1742401497
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250319_092502_537285_896BAB59 
X-CRM114-Status: GOOD (  14.16  )
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

Send a C2HTermReq PDU to the host when an header digest error is
detected, when receiving ICReq PDUs with invalid parameters or
when H2CData PDUs have invalid data offsets or sizes.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/tcp.c | 70 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 4f9cac8a5abe..c9aac35c90c3 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -217,6 +217,10 @@ static struct workqueue_struct *nvmet_tcp_wq;
 static const struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
+static void nvmet_send_c2h_term(struct nvmet_tcp_queue *queue,
+				void *pdu,
+				enum nvme_tcp_fatal_error_status fes,
+				u32 field_offset);
 
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd)
@@ -322,6 +326,8 @@ static int nvmet_tcp_verify_hdgst(struct nvmet_tcp_queue *queue,
 	nvmet_tcp_hdgst(queue->rcv_hash, pdu, len);
 	exp_digest = *(__le32 *)(pdu + hdr->hlen);
 	if (recv_digest != exp_digest) {
+		/* Restore the original value for C2HTermReq */
+		*(__le32 *)(pdu + hdr->hlen) = recv_digest;
 		pr_err("queue %d: header digest error: recv %#x expected %#x\n",
 			queue->idx, le32_to_cpu(recv_digest),
 			le32_to_cpu(exp_digest));
@@ -910,11 +916,17 @@ static int nvmet_tcp_handle_icreq(struct nvmet_tcp_queue *queue)
 	}
 
 	if (icreq->pfv != NVME_TCP_PFV_1_0) {
+		nvmet_send_c2h_term(queue, icreq,
+				    NVME_TCP_FES_UNSUPPORTED_PARAM,
+				    offsetof(struct nvme_tcp_icreq_pdu, pfv));
 		pr_err("queue %d: bad pfv %d\n", queue->idx, icreq->pfv);
 		return -EPROTO;
 	}
 
 	if (icreq->hpda != 0) {
+		nvmet_send_c2h_term(queue, icreq,
+				    NVME_TCP_FES_UNSUPPORTED_PARAM,
+				    offsetof(struct nvme_tcp_icreq_pdu, hpda));
 		pr_err("queue %d: unsupported hpda %d\n", queue->idx,
 			icreq->hpda);
 		return -EPROTO;
@@ -1006,6 +1018,8 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 		pr_err("ttag %u unexpected data offset %u (expected %u)\n",
 			data->ttag, le32_to_cpu(data->data_offset),
 			cmd->rbytes_done);
+		nvmet_send_c2h_term(queue, data,
+				    NVME_TCP_FES_DATA_OUT_OF_RANGE, 0);
 		goto err_proto;
 	}
 
@@ -1019,6 +1033,11 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_tcp_queue *queue)
 		     cmd->pdu_len == 0 ||
 		     cmd->pdu_len > NVMET_TCP_MAXH2CDATA)) {
 		pr_err("H2CData PDU len %u is invalid\n", cmd->pdu_len);
+		if (cmd->pdu_len > NVMET_TCP_MAXH2CDATA) {
+			nvmet_send_c2h_term(queue, data,
+					    NVME_TCP_FES_DATA_LIMIT_EXCEEDED,
+					    0);
+		}
 		goto err_proto;
 	}
 	cmd->pdu_recv = 0;
@@ -1180,6 +1199,55 @@ static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_queue *queue,
 	return ret;
 }
 
+static void nvmet_send_c2h_term(struct nvmet_tcp_queue *queue, void *pdu,
+				enum nvme_tcp_fatal_error_status fes,
+				u32 field_offset)
+{
+	struct nvme_tcp_term_pdu *term_pdu;
+	struct nvme_tcp_hdr *hdr = pdu;
+	size_t cmd_size = nvmet_tcp_pdu_size(hdr->type);
+	size_t pdu_size = sizeof(*term_pdu) + cmd_size;
+	struct msghdr msg = { .msg_flags = MSG_EOR | MSG_DONTWAIT };
+	struct bio_vec bvec;
+	__le32 fei;
+
+	if (!cmd_size)
+		return;
+
+	term_pdu = kzalloc(pdu_size, GFP_KERNEL);
+	if (!term_pdu)
+		return;
+
+	switch (fes) {
+	case NVME_TCP_FES_INVALID_PDU_HDR:
+	case NVME_TCP_FES_UNSUPPORTED_PARAM:
+		fei = field_offset;
+		break;
+	case NVME_TCP_FES_HDR_DIGEST_ERR:
+		fei = le32_to_cpu(*(__le32 *)((u8 *)hdr + hdr->hlen));
+		break;
+	default:
+		fei = 0;
+		break;
+	}
+	term_pdu->feil = cpu_to_le16(lower_16_bits(fei));
+	term_pdu->feiu = cpu_to_le16(upper_16_bits(fei));
+	term_pdu->fes  = cpu_to_le16(fes);
+
+	memcpy((u8 *)term_pdu + sizeof(*term_pdu), pdu, cmd_size);
+
+	term_pdu->hdr.type  = nvme_tcp_c2h_term;
+	term_pdu->hdr.flags = 0;
+	term_pdu->hdr.hlen  = sizeof(*term_pdu);
+	term_pdu->hdr.plen  = cpu_to_le32(pdu_size);
+
+	bvec_set_virt(&bvec, (void *)term_pdu, pdu_size);
+	iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, pdu_size);
+	sock_sendmsg(queue->sock, &msg);
+
+	kfree(term_pdu);
+}
+
 static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 {
 	struct nvme_tcp_hdr *hdr = &queue->pdu.cmd.hdr;
@@ -1230,6 +1298,8 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 
 	if (queue->hdr_digest &&
 	    nvmet_tcp_verify_hdgst(queue, &queue->pdu, hdr->hlen)) {
+		nvmet_send_c2h_term(queue, &queue->pdu,
+				NVME_TCP_FES_HDR_DIGEST_ERR, 0);
 		nvmet_tcp_fatal_error(queue); /* fatal */
 		return -EPROTO;
 	}
-- 
2.43.5


