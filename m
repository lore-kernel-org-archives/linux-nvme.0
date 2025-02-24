Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4E0C021BC
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 15:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OJbmtTlGE7snnRZu4OmMC0z9QMTqabIH71AU8wkyiWI=; b=pNJzhR/9hpsUTXKwg4k8T/dYhj
	KK9OQvZ+O89FZNP70Pxt/Wkz1vNu9qN2tCjMpew6o+9aFiTYOl5fdncjT3ad61Rouvr4WUsZUnSW8
	sc+s5G3Ir7pKkgHmR7moSRBLZCxogzYI6DLnjbfbWjF2RFG+w4ci72jDvSB6d7NgvM27xcqvcZ/aA
	k16baZ8Xw84ofnl0fabBPEzgQzdsel3LGgacug/H9qyaGocPuPuJalvlqvlua8UxO9CPmN15QCGPK
	JNkwdSqa2muFRfcQT1D5P+3t8CZ3Ml6uD6AeGSyS2GlSIIAQDdzenzzzXnTI1XkcsCowtBgufxuq5
	lwWsRm9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tma3C-0000000EDlL-1R2a;
	Mon, 24 Feb 2025 15:07:18 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmZbD-0000000E7vC-0j8n
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 14:38:25 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id e2c9ed53 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 24 Feb 2025 15:38:18 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Feb 2025 15:38:16 +0100
Message-Id: <D80R3XYM3OZ0.K8YLZIQ7XUDW@bsdbackstore.eu>
Cc: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
 <linux-nvme@lists.infradead.org>, <hare@kernel.org>
Subject: Re: [PATCH] nvme-tcp: add basic support for the C2HTermReq PDU
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Hannes Reinecke" <hare@suse.de>, "Maurizio Lombardi"
 <mlombard@redhat.com>, <kbusch@kernel.org>
X-Mailer: aerc
References: <20250214190012.311960-1-mlombard@redhat.com>
 <91041933-6a18-490c-8090-4e03d15d3cf3@suse.de>
In-Reply-To: <91041933-6a18-490c-8090-4e03d15d3cf3@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_063823_547531_5D2B826A 
X-CRM114-Status: GOOD (  12.99  )
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

On Mon Feb 17, 2025 at 11:56 AM CET, Hannes Reinecke wrote:
> Can you add support for nvmet, too, such that we can test the patch?
> (And maybe even a blktest script for it?)

Possible target-side implementation here.

Question is if it's acceptable to send the packet in
blocking mode (MSG_DONTWAIT unset).

Errors in nvmet_send_c2h_term() can be safely ignored because in any
case we are going to perform a fatal error recovery immediately after.

Example of dmesg in the target:
nvmet_tcp: queue 2: header digest error: recv 0xcf5f1cf7 expected 0x751607d=
3
nvmet: ctrl 1 fatal error occurred!

Example of dmesg in the host:
nvme nvme0: Received C2HTermReq (FES =3D Header Digest Error)
nvme nvme0: C2HTermReq: invalid digest =3D 0xcf5f1cf7


diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7c51c2a8c109..16438f2a624d 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -217,6 +217,9 @@ static struct workqueue_struct *nvmet_tcp_wq;
 static const struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_free_cmd_buffers(struct nvmet_tcp_cmd *cmd);
+static void nvmet_send_c2h_term(struct nvmet_tcp_queue *queue,
+				enum nvme_tcp_fatal_error_status fes,
+				u32 field_offset);
=20
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd)
@@ -322,6 +325,8 @@ static int nvmet_tcp_verify_hdgst(struct nvmet_tcp_queu=
e *queue,
 	nvmet_tcp_hdgst(queue->rcv_hash, pdu, len);
 	exp_digest =3D *(__le32 *)(pdu + hdr->hlen);
 	if (recv_digest !=3D exp_digest) {
+		/* Restore the original value for C2HTermReq */
+		*(__le32 *)(pdu + hdr->hlen) =3D recv_digest;
 		pr_err("queue %d: header digest error: recv %#x expected %#x\n",
 			queue->idx, le32_to_cpu(recv_digest),
 			le32_to_cpu(exp_digest));
@@ -999,6 +1004,7 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet_=
tcp_queue *queue)
 		pr_err("ttag %u unexpected data offset %u (expected %u)\n",
 			data->ttag, le32_to_cpu(data->data_offset),
 			cmd->rbytes_done);
+		nvmet_send_c2h_term(queue, NVME_TCP_FES_DATA_OUT_OF_RANGE, 0);
 		goto err_proto;
 	}
=20
@@ -1012,6 +1018,8 @@ static int nvmet_tcp_handle_h2c_data_pdu(struct nvmet=
_tcp_queue *queue)
 		     cmd->pdu_len =3D=3D 0 ||
 		     cmd->pdu_len > NVMET_TCP_MAXH2CDATA)) {
 		pr_err("H2CData PDU len %u is invalid\n", cmd->pdu_len);
+		if (cmd->pdu_len > NVMET_TCP_MAXH2CDATA)
+			nvmet_send_c2h_term(queue, NVME_TCP_FES_DATA_LIMIT_EXCEEDED, 0);
 		goto err_proto;
 	}
 	cmd->pdu_recv =3D 0;
@@ -1173,6 +1181,55 @@ static int nvmet_tcp_tls_record_ok(struct nvmet_tcp_=
queue *queue,
 	return ret;
 }
=20
+static void nvmet_send_c2h_term(struct nvmet_tcp_queue *queue,
+				enum nvme_tcp_fatal_error_status fes,
+				u32 field_offset)
+{
+	struct nvme_tcp_cmd_pdu *cmd =3D &queue->pdu.cmd;
+	struct nvme_tcp_term_pdu *term_pdu;
+	size_t cmd_size =3D nvmet_tcp_pdu_size(cmd->hdr.type);
+	size_t pdu_size =3D sizeof(*term_pdu) + cmd_size;
+	struct msghdr msg =3D { .msg_flags =3D MSG_EOR };
+	__le32 fei;
+	struct bio_vec bvec;
+
+	if (!cmd_size)
+		return;
+
+	term_pdu =3D kzalloc(pdu_size, GFP_KERNEL);
+	if (!term_pdu)
+		return;
+
+	switch (fes) {
+	case NVME_TCP_FES_INVALID_PDU_HDR:
+	case NVME_TCP_FES_UNSUPPORTED_PARAM:
+		fei =3D field_offset;
+		break;
+	case NVME_TCP_FES_HDR_DIGEST_ERR:
+		fei =3D le32_to_cpu(*(__le32 *)((u8 *)cmd + cmd->hdr.hlen));
+		break;
+	default:
+		fei =3D 0;
+		break;
+	}
+	term_pdu->feil =3D cpu_to_le16(lower_16_bits(fei));
+	term_pdu->feiu =3D cpu_to_le16(upper_16_bits(fei));
+	term_pdu->fes  =3D cpu_to_le16(fes);
+
+	memcpy((u8 *)term_pdu + sizeof(*term_pdu), cmd, cmd_size);
+
+	term_pdu->hdr.type  =3D nvme_tcp_c2h_term;
+	term_pdu->hdr.flags =3D 0;
+	term_pdu->hdr.hlen  =3D sizeof(*term_pdu);
+	term_pdu->hdr.plen  =3D cpu_to_le32(pdu_size);
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
 	struct nvme_tcp_hdr *hdr =3D &queue->pdu.cmd.hdr;
@@ -1223,6 +1280,7 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_qu=
eue *queue)
=20
 	if (queue->hdr_digest &&
 	    nvmet_tcp_verify_hdgst(queue, &queue->pdu, hdr->hlen)) {
+		nvmet_send_c2h_term(queue, NVME_TCP_FES_HDR_DIGEST_ERR, 0);
 		nvmet_tcp_fatal_error(queue); /* fatal */
 		return -EPROTO;
 	}
--=20
2.43.5




