Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E69606A324
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2026 20:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ep3r6Eg6;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BUnNgSjz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=FkN83yy1WD4qiKYRQgrYbDYfmEGJAV4efcLDG1rAZ94=; b=ep3r6Eg6mYAbhd
	zQ+wgPVVSM+CnO2BfhHrwfX94IsVLAhynKsa+rMUl1Y7wKf0R5V7wGIME3QB6Ym187X9fnzCiUPN9
	4AkO6lo7vCoTDUG7Mx6fRsjrcsJOXXi+1U4atwZEtzc3aOb5JKuKLfKqvBLXahbbGKLjnNcNKzQxn
	3OpvcFiW/UrrYdUg2NyVbiAIhfjQpoDTxNr7NxkI3ikhhIvfIhlO9nBSkHNvpk1eGpna2CnASQRkE
	ATHwRfUsM5T7sHOokQstbftuYTVh1p5oX0zs+dcq783zItrTycsjEls7qGWWTC3s7M5DChkG3/Feh
	OFoeWaOtQnpl6ptrxezw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRF9X-00000007fI9-2HAy;
	Wed, 11 Nov 2026 20:42:43 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRF9W-00000007fHO-2s67
	for linux-nvme@lists.infradead.org;
	Wed, 11 Nov 2026 20:42:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id ED0D461356;
	Wed, 11 Nov 2026 20:42:41 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794429761;
	b=Wf3zfFA1F5mGvXrst1uzCp02riRYOVQphksjnIq3N5afH2JqRXkYvZeXGoN5YxYoKIL1
	 YnKissn7GTEBOmActeC2jyqSvtJMOTZaffrv8/JqBVFLk9Gd8Eh8Nq+ngrH0soWVeHd/P
	 AjBiTOExKx8x1vY+wo8dOKBQknWgmmMV4B3i9xO83E9u5T4oKANd2jBwQ1M6ggI/YJpFb
	 yhi5hPsGWh6UKKnLKlYkCTI5KxPHc1sEMwtjT3Sei9Z1ylVzZ+MmoEsQjkw2fLbwjZXcS
	 0HunBOCYSgjmY8KzEWZgdnA/AW+O2e8zyRwaaK3Dczvg77eEyBKrh5zic7cgfVaEGdA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794429761;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=FkN83yy1WD4qiKYRQgrYbDYfmEGJAV4efcLDG1rAZ94=;
	b=TzfnAPRSwJ96efIVYgpYRjAZByKrb/IX8BYlQiHrvm/Ja2ljO+qOTVvJhsHbq3Kb5bSz
	 /xqXXU5dJVdVIfPPEgDlVYzq0d0KWtDf9yQ9rHENo5V89NOgoqe4CpehzHOylYrGPaP0L
	 8wxMgS48FD9QU3mbO8H0BMzsMTHNJPwjLw7CnKqKLFIVnCGCmPptT4e0UAr5CK/vVc6Sd
	 cyXbs8qeguwoW8ftnSwoLijPCRzIq4C1MMHrxk/CiJdOO//VbLgZvjNKjhLP1mrvzoHko
	 D6wX83HtZKjvlMxc5mcFoj24SM9PZ1zcCXhtFfH8HMM41JBiJmk0q5Lk+4f+M6lDxKA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 1BA661F00A06;
	Wed, 11 Nov 2026 20:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794429761;
	bh=FkN83yy1WD4qiKYRQgrYbDYfmEGJAV4efcLDG1rAZ94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BUnNgSjzOLRdv8ucQUrixpAOzbqslSFpzv0QHJmDKr8rUUxFaTt/n4WAYMGlbjqk3
	 D77TYCgbSJMRTGuTluXE3WKd9yTSwAilktVVjXdfZz+LMJTAYw+7dNymPWGASzt7uU
	 UOhtTi9yfNO3j+jyEocU3vpoNW1U9zE0OMiAjfwY4SDYKuZrYIk0ttuAKIJGadboQl
	 TEYSWLb7deeftglApJ6fflqU6t1ohzPHTEltr8JE204YGTJTWFQAyKddecA+8ieV/f
	 lEO8zEtDV9WgHEy6b8Or6NNh0RD5hO/xC/4DNo9mUUGA1GN8z1zZZ8ukT72V0MtkyL
	 APgXMILjEqPpw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 94CC2490F8;
	Wed, 11 Nov 2026 20:42:40 +0000 (UTC)
From: Martin Belanger via B4 Relay <devnull+martin.nvme.dev.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 15:42:39 -0500
Subject: [PATCH v2 1/3] nvme-tcp: use an aligned buffer for the TLS record
 type
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261111-nvme-tcp-live-ctrlrec-v2-1-6295202b84de@gmail.com>
References: <20261111-nvme-tcp-live-ctrlrec-v2-0-6295202b84de@gmail.com>
In-Reply-To: <20261111-nvme-tcp-live-ctrlrec-v2-0-6295202b84de@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@kernel.org>
Cc: Martin Belanger <martin.nvme.dev@gmail.com>, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Martin Belanger <martin.belanger@dell.com>, stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794429760; l=2965;
 i=martin.nvme.dev@gmail.com; s=20261014; h=from:subject:message-id;
 bh=dSfexLwo67gflGLyNcBaaPITAwXJ0vNQ1LHo8u5k2cI=;
 b=CE/SMiI50fYM2KLpbRvPoeTipY7fRKGrogVnilfikot6baI7SWjq8ZPpW+hTM+r4ti4jsDTpr
 MYuWLqeeVx1BF3cbKn+/vVjvdhnfyeI1ZFzUdJPDmsyyg/qrt5YhUe7
X-Developer-Key: i=martin.nvme.dev@gmail.com; a=ed25519;
 pk=4K+XXetGK35w2LzRRddd/bbHawZU222BN+YZRuSpN+k=
X-Endpoint-Received: by B4 Relay for martin.nvme.dev@gmail.com/20261014
 with auth_id=1176
X-Original-From: Martin Belanger <martin.nvme.dev@gmail.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: martin.nvme.dev@gmail.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Martin Belanger <martin.belanger@dell.com>

The buffers that receive the TLS record type are char arrays.
put_cmsg() and tls_get_record_type() access them as struct cmsghdr,
which needs a stricter alignment than a char array has.

Use a union with struct cmsghdr, sized with CMSG_SPACE(), as
svc_tcp_recv_cmsg() and xs_tls_read_record() in sunrpc do.

Fixes: 2837966ab2a8 ("nvme-tcp: control message handling for recvmsg()")
Cc: stable@vger.kernel.org
Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 drivers/nvme/host/tcp.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7ecc6c007f8d..749d77b4e172 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -77,6 +77,12 @@ MODULE_PARM_DESC(tls_handshake_timeout,
 /* TLS records read while waiting for the ICResp, the ICResp included */
 #define NVME_TCP_ICRESP_MAX_RECORDS 8
 
+/* control message buffer for the TLS record type */
+union nvme_tcp_tls_cmsg {
+	struct cmsghdr	cmsg;
+	u8		buf[CMSG_SPACE(sizeof(u8))];
+};
+
 static int nvme_tcp_cpu_queues[NR_CPUS];
 static DEFINE_SPINLOCK(nvme_tcp_cpu_queues_lock);
 
@@ -1653,11 +1659,11 @@ static int nvme_tcp_skip_tls_record(struct nvme_tcp_queue *queue,
 			.iov_base = buf,
 			.iov_len = sizeof(buf),
 		};
-		char cbuf[CMSG_LEN(sizeof(char))] = {};
+		union nvme_tcp_tls_cmsg u = {};
 		/* kTLS fails a control record read without a cmsg buffer */
 		struct msghdr drain = {
-			.msg_control = cbuf,
-			.msg_controllen = sizeof(cbuf),
+			.msg_control = &u,
+			.msg_controllen = sizeof(u),
 		};
 
 		ret = kernel_recvmsg(queue->sock, &drain, &iov, 1, sizeof(buf),
@@ -1682,7 +1688,7 @@ static int nvme_tcp_skip_tls_record(struct nvme_tcp_queue *queue,
 static int nvme_tcp_recv_icresp(struct nvme_tcp_queue *queue,
 				struct nvme_tcp_icresp_pdu *icresp)
 {
-	char cbuf[CMSG_LEN(sizeof(char))];
+	union nvme_tcp_tls_cmsg u;
 	struct msghdr msg;
 	struct kvec iov;
 	u8 ctype;
@@ -1690,12 +1696,12 @@ static int nvme_tcp_recv_icresp(struct nvme_tcp_queue *queue,
 
 	for (i = 0; i < NVME_TCP_ICRESP_MAX_RECORDS; i++) {
 		memset(&msg, 0, sizeof(msg));
-		memset(cbuf, 0, sizeof(cbuf));
+		memset(&u, 0, sizeof(u));
 		iov.iov_base = icresp;
 		iov.iov_len = sizeof(*icresp);
 		if (nvme_tcp_queue_tls(queue)) {
-			msg.msg_control = cbuf;
-			msg.msg_controllen = sizeof(cbuf);
+			msg.msg_control = &u;
+			msg.msg_controllen = sizeof(u);
 		}
 		msg.msg_flags = MSG_WAITALL;
 		ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
@@ -1703,8 +1709,7 @@ static int nvme_tcp_recv_icresp(struct nvme_tcp_queue *queue,
 		if (ret <= 0 || !nvme_tcp_queue_tls(queue))
 			return ret;
 
-		ctype = tls_get_record_type(queue->sock->sk,
-					    (struct cmsghdr *)cbuf);
+		ctype = tls_get_record_type(queue->sock->sk, &u.cmsg);
 		if (ctype == TLS_RECORD_TYPE_DATA)
 			return ret;
 

-- 
2.53.0



