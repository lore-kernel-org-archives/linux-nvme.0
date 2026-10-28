Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047F6606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 00:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Y/AfNd6P;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V4kOGlV9
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=SbDo/FtxogKJkv2z+Ra3BUUKwOLYjP3PXcdhiKWABBE=; b=Y/AfNd6Pz/PPDiDbbU+7tibp95
	q9ZTj6T5WK0c1NXgxxT5OAiEWXOYlAqDc+evrwIIzGknbcjp4vciPDl1hxlbqpAafBoYXhd3fNBTI
	jgiX7F282mcJfAF/5gRjpQVNmyNxN6OAj3RFIExk4N28XBeT3K4KObf4XrLN4HmX/Yg67NR0D54KW
	hvC7zMvoRmdU9zwDvK4A7O2FAGfOezRh7xgUUZZAg1UFLTMYmRdKQaYd1MDFjAPDPFeScihCbj9Zl
	b/Wox6P7vqr02oVgrP5PL1ccihE5OfNuR4VYAP+18DcSceuS/8rgNR90ME40Mk2Ov3dh7LELj8xrf
	9SVJyBRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLrVa-00000005z53-2bAZ;
	Wed, 28 Oct 2026 00:27:14 +0000
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLrVY-00000005z4d-0Ibm
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 00:27:13 +0000
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-9906034086cso165934241.1
        for <linux-nvme@lists.infradead.org>; Tue, 27 Oct 2026 17:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793147230; x=1793752030; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SbDo/FtxogKJkv2z+Ra3BUUKwOLYjP3PXcdhiKWABBE=;
        b=V4kOGlV9m4qdjATtZKznU+/3e0BItKeYXkx+FgKGg2Jli6WLmmnb95Z+FxkO3nAyhu
         EPjYyNl99xx/PQ9mB5YLYYSP1XfhLJd9Mec1NjMmPN3Sa4Skv4R6c7DyqA21DDiXMqQa
         nfiEWwxu4jeboSPgbx00UZ2BE/BTZzQXUe+yKg2BA60qaxuh2X8/O7CXapwpeFtjfT2f
         EJUELNvT08/PlIR/1tj7+heFC+iMLhVS40ejyShTFNkHKKGLivxjd7ctdoqRvlctW1d7
         dDqwy71kwj1uH0DNDAVQ7wu9dK8upHtFSQruHVxS6rdpXpIgo5ycM0LA4jSoUsQk/13n
         asKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793147230; x=1793752030;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SbDo/FtxogKJkv2z+Ra3BUUKwOLYjP3PXcdhiKWABBE=;
        b=w8JRBWWkIBskYYAP1Q8ZFqUGHx7QAItYGq+aIm4qtWAZn5/ukAvlDYXz95r67+4/Bf
         4YUSc3MPzrk61BPZpJjkEU0ruiPmq0OmwN7+a6bLqe0+67Y295jqc7XBHAJEP5UY8f8s
         Fp8IyzRTyJqXL87Isz1RuQd3+jXfUqLKv34szELMr2pgyVOwsRovYZRz9FoSE/0N//QE
         E38BabftZ2bZc9bLbDaB9pa5jaISOOKnpttFmMEk2K4e2tqqrUYLyqBYbuTZfyHnn6ew
         kwdfqHnfycvKhA0nMIKeF1O+fp3JSuMewnXFkkEnyq5qZzgind3Anam3njXuZqXeEtRd
         v+Mg==
X-Gm-Message-State: AFq9FYK5Ttrzv//wk/drwj2faHA78+uwrWt8oU6h66HK7B3mUgiqAsbm
	YbZNHfz+Q6yvPm02BS092mmjEVmCRqzqHQv1fI1Wi17Kp1z7/ICN5lhHSd4zRchd2P4=
X-Gm-Gg: AYBFou03lyQZu9irrH1eizk95FwQAmW+yNdmISt5OdusM7mSiu/KHzR1SgUroWG6zae
	e/LZMH9YvpcpsCPRCrITAmdQhNkoyChW+MMpusvCyuAxT6WpVx015PDgTzbz7kAseC3E5lRtwL9
	mZDfuDz2SbK/JceAj/2kftCzq4J0T3EtPRSytnnkW6Ct5DUmVaFkqzYnlWv8HDRxJxbYgEV0RLR
	aH+9u0z+PcnSxwJnScBa3PA9d2F4ps2OWJBxTUfck2IpSbPDlByb+wZm/sQ+kLor6AlomqP8XRG
	LmLlCHkUnP9W2KNAXUFY2cxW595VN/IARQBsBAn5amxW7QQnbFGyIaAKxp/mmN9jP8GTKcZZloa
	F9arguZESJ9GgqzY7dnSE91qLnlIGrX7ssfPhQzmkXq6uahqjf1d5tyXcLaEpvz7ikSD4kynEte
	CfobU9boBoh5NsN1Dc061CI8quyIOO0XlA1QR0OaJ9mIh4bHBjAgqJtvutQN8R19igL4glBa395
	IWE78LLb1L5ZC+1VY86l0Dpap2MQmDY68NNpXuJ9yskeRtAAVm17TyEwPgRKoc9dEZV2tB2SWFS
	jv2kcicjNnw=
X-Received: by 2002:a05:6102:f8b:b0:7c8:3b8c:82ba with SMTP id ada2fe7eead31-7d03a5ee504mr404653137.32.1793147230250;
        Tue, 27 Oct 2026 17:27:10 -0700 (PDT)
Received: from bridge.. ([2804:14d:ba6b:8339:260a:a9d6:ce02:aaa8])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cea3c3b00fsm4156770137.5.2026.10.27.17.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 17:27:09 -0700 (PDT)
From: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	hare@kernel.org,
	sgogte@purestorage.com,
	wagi@kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Subject: [PATCH] nvme-tcp: fix NULL queue->ctrl dereference on reconnect
Date: Tue, 27 Oct 2026 21:26:54 -0300
Message-ID: <20261028002654.1077190-1-christian.aurichzm@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261027_172712_156813_BE1667D6 
X-CRM114-Status: GOOD (  20.16  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Since commit 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation
and startup"), a reconnect that gets more I/O queues than before grows
the tag set before the new queues are allocated. queue->ctrl is only
set by nvme_tcp_alloc_queue(), so I/O submitted in between reaches
nvme_tcp_queue_rq() on a queue that was never allocated and
dereferences a NULL queue->ctrl:

  BUG: kernel NULL pointer dereference, address: 00000000000002ac
  RIP: 0010:nvme_tcp_queue_rq+0x33/0x3b0

Add nvme_tcp_init_queue() for the queue fields that do not depend on
the connection (ctrl, pf_cache_lock and both digests) and call it for
every queue when allocating the controller. Such requests are then
requeued like on any other queue that is not live.

Fixes: 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation and startup")
Suggested-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
---
Keith suggested the helper when applying "nvme-tcp: fix request PDU
size when header digest is enabled". Based on nvme-7.4 (9afc1b71d963)
with that patch on top.

Reproduced in QEMU with nvmet-tcp over loopback and
CONFIG_NVME_MULTIPATH=n: connect with attr_qid_max=2, keep direct reads
running on the CPUs that map to the new hw queues, then raise
attr_qid_max to 4. Before the patch the host oopsed as above within two
tries in each of three boots; after it, 8 of 8 tries went live. Digest
I/O, the 2 to 4 queue grow and 30 resets under I/O also pass, and the
grow and reset runs are clean with lockdep enabled.

 drivers/nvme/host/tcp.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 191e5811d25e..46816a9fb2bf 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1977,6 +1977,22 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	return ret;
 }
 
+/*
+ * The I/O tag set is allocated, and grown on reconnect, before the queues are
+ * connected, so blk-mq can initialize requests on a queue, and dispatch to it,
+ * before nvme_tcp_alloc_queue() has run for it. Set up the fields that do not
+ * depend on the connection once, when allocating the controller.
+ */
+static void nvme_tcp_init_queue(struct nvme_tcp_ctrl *ctrl, int qid)
+{
+	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
+
+	queue->ctrl = ctrl;
+	mutex_init(&queue->pf_cache_lock);
+	queue->hdr_digest = ctrl->ctrl.opts->hdr_digest;
+	queue->data_digest = ctrl->ctrl.opts->data_digest;
+}
+
 static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 				key_serial_t pskid)
 {
@@ -1986,7 +2002,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	struct file *sock_file;
 
 	mutex_init(&queue->queue_lock);
-	queue->ctrl = ctrl;
 	init_llist_head(&queue->req_list);
 	INIT_LIST_HEAD(&queue->send_list);
 	mutex_init(&queue->send_mutex);
@@ -2079,8 +2094,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 		}
 	}
 
-	queue->data_digest = nctrl->opts->data_digest;
-
 	rcv_pdu_size = sizeof(struct nvme_tcp_rsp_pdu) +
 			nvme_tcp_hdgst_len(queue);
 	queue->pdu = kmalloc(rcv_pdu_size, GFP_KERNEL);
@@ -3225,16 +3238,8 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
-	/*
-	 * The I/O tag set is allocated before the I/O queues, and initializing
-	 * its requests already allocates the PDUs from the page frag caches of
-	 * the queues, sized by their header digest setting, so set up the
-	 * locks and hdr_digest here.
-	 */
-	for (i = 0; i < ctrl->ctrl.queue_count; i++) {
-		mutex_init(&ctrl->queues[i].pf_cache_lock);
-		ctrl->queues[i].hdr_digest = opts->hdr_digest;
-	}
+	for (i = 0; i < ctrl->ctrl.queue_count; i++)
+		nvme_tcp_init_queue(ctrl, i);
 
 	ctrl->net = get_net(current->nsproxy->net_ns);
 
-- 
2.43.0


