Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 098DAC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jun 2022 21:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=55Ow6rZ0I1kyS2p6lWsXoIBLC2UPKt0ZmhKakVoU6gk=; b=Inz7LHkYdbpQWZi8oByrvv80np
	LYz6nkAdKWiZwfqQYZMDnAn6uXG8SG8EsUq/5O7Rw9fFMABh9Z0Mxpi4h3aw52++X0m/cSEqn5hAc
	B3gG0Uco9RStNZZY9ZrafktkIhfYy+R1gz2LdyXdI9a5a1NUxD92Qh826mwRPjuJ9yHEeppGkMbVM
	/uNIdpzjs15a8pEuGkwCr6bQMk1psRnS+3pa5GzTGS31C7Vm03OgbWshLIgmcOIW6j5Zl3w13puQF
	c04UguGjUOasD+qBh1OiF095mJ6D+9Adz0l4qWbtzjvUkiiRv/ib3r1qTBTov2jJpV7MHIwIxLVd7
	bp5AIa0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4UiB-00Gtt3-9R; Thu, 23 Jun 2022 21:50:03 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4Ui8-00GtqT-1L
	for linux-nvme@lists.infradead.org; Thu, 23 Jun 2022 21:50:01 +0000
Received: by mail-wr1-f41.google.com with SMTP id k22so608672wrd.6
        for <linux-nvme@lists.infradead.org>; Thu, 23 Jun 2022 14:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=55Ow6rZ0I1kyS2p6lWsXoIBLC2UPKt0ZmhKakVoU6gk=;
        b=xfr3q+FEh6Kl6Pgo5yPBE3J+JL9wb6WyVBRtXPMxnW8vSQwz/010CBX9yd4L1W1Z7K
         Hn0t3gjdAakGBljg5nHDlq5hwrwnfwGGWGljmI0AKJe6hqN4wBBqsjnc6H9f3SfDjOwM
         Z0WeEsuNddkXRPA1wUZLbp/YhcGnRXfORo1bIrL3qlt+vwjCIBkssC3hRyj7PJAYa0dp
         2UPYTFkNySUW/wUSCwLK14Nu7ajgpRM6FDxxR4yZDT8T7sq5UXf9oQ8VapaKT4Dv2MsG
         VEpIQ2iIVnxA4ZioO0y/wj7hy4SJ3kQJYxYCAgNkRygfOEWJt3xc4Nwl1K1Nz5FqPZWP
         FhHQ==
X-Gm-Message-State: AJIora8Mt07EKmc9NnXBGlY0ds3gsKwQldHxRJ/d7AKuZtUc8BOTMw9P
	0zUxflk/c6kWTqdMDNDW2MaVs/ZSy6Q=
X-Google-Smtp-Source: AGRyM1sxnt5tSed4WBoapWmpbGgpAT5Q+IuANEHdDB5ElDbgjH741UdEioTL90IFRBbXOfdfQyx8Jg==
X-Received: by 2002:a5d:5145:0:b0:21b:940d:45d1 with SMTP id u5-20020a5d5145000000b0021b940d45d1mr10065894wrt.308.1656020995613;
        Thu, 23 Jun 2022 14:49:55 -0700 (PDT)
Received: from localhost.localdomain (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id p17-20020a7bcc91000000b0039c4ec6fdacsm505481wma.40.2022.06.23.14.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 14:49:55 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvmet-tcp: fix regression in data_digest calculation
Date: Fri, 24 Jun 2022 00:49:53 +0300
Message-Id: <20220623214953.1347335-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220623_145000_116304_E04ACC6D 
X-CRM114-Status: GOOD (  12.77  )
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

Data digest calculation iterates over command mapped iovec. However
since commit bac04454ef9f we unmap the iovec before we handle the data
digest, and since commit 69b85e1f1d1d we clear nr_mapped when we unmap
the iov.

Instead of open-coding the command iov traversal, simply call
crypto_ahash_digest with the command sg that is already allocated (we
already do that for the send path). Rename nvmet_tcp_send_ddgst to
nvmet_tcp_calc_ddgst and call it from send and recv paths.

Fixes: 69b85e1f1d1d ("nvmet-tcp: add an helper to free the cmd buffers")
Fixes: bac04454ef9f ("nvmet-tcp: fix kmap leak when data digest in use")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 2793554e622e..0a9542599ad1 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -405,7 +405,7 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 	return NVME_SC_INTERNAL;
 }
 
-static void nvmet_tcp_send_ddgst(struct ahash_request *hash,
+static void nvmet_tcp_calc_ddgst(struct ahash_request *hash,
 		struct nvmet_tcp_cmd *cmd)
 {
 	ahash_request_set_crypt(hash, cmd->req.sg,
@@ -413,23 +413,6 @@ static void nvmet_tcp_send_ddgst(struct ahash_request *hash,
 	crypto_ahash_digest(hash);
 }
 
-static void nvmet_tcp_recv_ddgst(struct ahash_request *hash,
-		struct nvmet_tcp_cmd *cmd)
-{
-	struct scatterlist sg;
-	struct kvec *iov;
-	int i;
-
-	crypto_ahash_init(hash);
-	for (i = 0, iov = cmd->iov; i < cmd->nr_mapped; i++, iov++) {
-		sg_init_one(&sg, iov->iov_base, iov->iov_len);
-		ahash_request_set_crypt(hash, &sg, NULL, iov->iov_len);
-		crypto_ahash_update(hash);
-	}
-	ahash_request_set_crypt(hash, NULL, (void *)&cmd->exp_ddgst, 0);
-	crypto_ahash_final(hash);
-}
-
 static void nvmet_setup_c2h_data_pdu(struct nvmet_tcp_cmd *cmd)
 {
 	struct nvme_tcp_data_pdu *pdu = cmd->data_pdu;
@@ -454,7 +437,7 @@ static void nvmet_setup_c2h_data_pdu(struct nvmet_tcp_cmd *cmd)
 
 	if (queue->data_digest) {
 		pdu->hdr.flags |= NVME_TCP_F_DDGST;
-		nvmet_tcp_send_ddgst(queue->snd_hash, cmd);
+		nvmet_tcp_calc_ddgst(queue->snd_hash, cmd);
 	}
 
 	if (cmd->queue->hdr_digest) {
@@ -1137,7 +1120,7 @@ static void nvmet_tcp_prep_recv_ddgst(struct nvmet_tcp_cmd *cmd)
 {
 	struct nvmet_tcp_queue *queue = cmd->queue;
 
-	nvmet_tcp_recv_ddgst(queue->rcv_hash, cmd);
+	nvmet_tcp_calc_ddgst(queue->rcv_hash, cmd);
 	queue->offset = 0;
 	queue->left = NVME_TCP_DIGEST_LENGTH;
 	queue->rcv_state = NVMET_TCP_RECV_DDGST;
-- 
2.34.1


