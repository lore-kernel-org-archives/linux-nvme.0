Return-Path: <SRS0=tyWw=HF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF6CFC433DB
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 23:00:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D62A64E38
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Feb 2021 23:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D62A64E38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/hepSBuuCHoic2Iz3xHMbrsh/M0a5v/xWRbTltUWnWs=; b=AlRoXu8Wn32kHU00EWWiJMJIN0
	G2CLPL9Czo1a76vFCDh0oQwfpG+D6MiZkmLQOcHUgjj7yKd36yhGlQfAbc+yICGa6NkzYRV/aCZtI
	4WMCjGTGwyud4+69HC7eLPkbe982+7OIggLMpznzWAtMUukbK5o1lgwxaAmIVmK6wdnI6nel1xek7
	qeXdiv5+AWV4ONRXav2Ajw8pt4JjqtbSgCkTsVl5uaqR6i9pZ0EFaVy1KMBAam3EChJegal6afmWv
	1EgGsixsKjH+2tXKCRm/1NhHApmGLYPmQ+N0YsAY5VthUTloIbWGCV1xcYyHixEa3iZZSX9my1D3E
	6fmIQ7fg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l7R85-0005nY-G4; Wed, 03 Feb 2021 23:00:09 +0000
Received: from mail-pg1-f174.google.com ([209.85.215.174])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l7R82-0005mz-Ea
 for linux-nvme@lists.infradead.org; Wed, 03 Feb 2021 23:00:07 +0000
Received: by mail-pg1-f174.google.com with SMTP id t25so802693pga.2
 for <linux-nvme@lists.infradead.org>; Wed, 03 Feb 2021 15:00:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=XMvEsWJvrot3HcnxSpzBWpMpv8v/mB5ZCe7bohSxnHk=;
 b=dYUD8S5G8iyHadbUzdr8ks94Uy7FIVAS7UKR8Tr7HMbARuBzw3HdXuScfsgXRQcxNd
 kTJJxXPctz77EjjUvTUE0y7nNxja/18YDzJ4G4oEyioGudJMANWTDy0WLUtxUPCod76y
 pWQUNuMkBeGxHiHB6P9V1MX+Oo5wI/Usv9HLAicv8NChKS2HQkAY1wXMM+CTsg1yH7vG
 MTp9hwpJgVH6pnegAkUBU47RCdbj8fOQLqEKRjvae3QhK4JxUtMuXuANSEbjdFs7VHb3
 aVf5bYD8yv4hb+YrbWan3LJzmn/CAcAdQFMi8WMNpAso9Z7Otmu+CdgExLQ4HiKgAfBa
 y8lw==
X-Gm-Message-State: AOAM533ihHXsvIiQ/9PWLE8FEHtBP1qL2m+0226DaMIKsqb0Xxu/ymCP
 jcDtJ1htb74BgdLydUC33Y6KVYzRr6M=
X-Google-Smtp-Source: ABdhPJz9UOXkUNgpW+tgb2t1D+rUvub/iLXyHztzoxNV1CyFWTQlyaa5VKHdWb0Tqwbop9hmYLHxFQ==
X-Received: by 2002:a63:375d:: with SMTP id g29mr2045800pgn.226.1612393204192; 
 Wed, 03 Feb 2021 15:00:04 -0800 (PST)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:cd99:e813:1dae:a15a])
 by smtp.gmail.com with ESMTPSA id a21sm4007768pgd.57.2021.02.03.15.00.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Feb 2021 15:00:03 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH] nvmet-tcp: Fix receive data digest calculation for multiple
 h2cdata PDUs
Date: Wed,  3 Feb 2021 15:00:01 -0800
Message-Id: <20210203230001.18797-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210203_180006_503954_46D4B875 
X-CRM114-Status: GOOD (  14.69  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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

When a host sends multiple h2cdata PDUs for a single command, we
should verify the data digest calculation per PDU and not
per command.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Reported-by: Narayan Ayalasomayajula <Narayan.Ayalasomayajula@wdc.com>
Tested-by: Narayan Ayalasomayajula <Narayan.Ayalasomayajula@wdc.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index aacf06f0b431..577ce7d403ae 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -379,7 +379,7 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 	return NVME_SC_INTERNAL;
 }
 
-static void nvmet_tcp_ddgst(struct ahash_request *hash,
+static void nvmet_tcp_send_ddgst(struct ahash_request *hash,
 		struct nvmet_tcp_cmd *cmd)
 {
 	ahash_request_set_crypt(hash, cmd->req.sg,
@@ -387,6 +387,23 @@ static void nvmet_tcp_ddgst(struct ahash_request *hash,
 	crypto_ahash_digest(hash);
 }
 
+static void nvmet_tcp_recv_ddgst(struct ahash_request *hash,
+		struct nvmet_tcp_cmd *cmd)
+{
+	struct scatterlist sg;
+	struct kvec *iov;
+	int i;
+
+	crypto_ahash_init(hash);
+	for (i = 0, iov = cmd->iov; i < cmd->nr_mapped; i++, iov++) {
+		sg_init_one(&sg, iov->iov_base, iov->iov_len);
+		ahash_request_set_crypt(hash, &sg, NULL, iov->iov_len);
+		crypto_ahash_update(hash);
+	}
+	ahash_request_set_crypt(hash, NULL, (void *)&cmd->exp_ddgst, 0);
+	crypto_ahash_final(hash);
+}
+
 static void nvmet_setup_c2h_data_pdu(struct nvmet_tcp_cmd *cmd)
 {
 	struct nvme_tcp_data_pdu *pdu = cmd->data_pdu;
@@ -411,7 +428,7 @@ static void nvmet_setup_c2h_data_pdu(struct nvmet_tcp_cmd *cmd)
 
 	if (queue->data_digest) {
 		pdu->hdr.flags |= NVME_TCP_F_DDGST;
-		nvmet_tcp_ddgst(queue->snd_hash, cmd);
+		nvmet_tcp_send_ddgst(queue->snd_hash, cmd);
 	}
 
 	if (cmd->queue->hdr_digest) {
@@ -1060,7 +1077,7 @@ static void nvmet_tcp_prep_recv_ddgst(struct nvmet_tcp_cmd *cmd)
 {
 	struct nvmet_tcp_queue *queue = cmd->queue;
 
-	nvmet_tcp_ddgst(queue->rcv_hash, cmd);
+	nvmet_tcp_recv_ddgst(queue->rcv_hash, cmd);
 	queue->offset = 0;
 	queue->left = NVME_TCP_DIGEST_LENGTH;
 	queue->rcv_state = NVMET_TCP_RECV_DDGST;
@@ -1081,14 +1098,14 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 		cmd->rbytes_done += ret;
 	}
 
+	if (queue->data_digest) {
+		nvmet_tcp_prep_recv_ddgst(cmd);
+		return 0;
+	}
 	nvmet_tcp_unmap_pdu_iovec(cmd);
 
 	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
 	    cmd->rbytes_done == cmd->req.transfer_len) {
-		if (queue->data_digest) {
-			nvmet_tcp_prep_recv_ddgst(cmd);
-			return 0;
-		}
 		cmd->req.execute(&cmd->req);
 	}
 
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
