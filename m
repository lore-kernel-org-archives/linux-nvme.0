Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC23C001B0
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Aug 2023 11:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WjT692Jn8Xrdk3PT1gq84Yi3mE29QCmBhJcZKh1x2gs=; b=q9+RPU9ZmuFOYoEh/ptgKlK0tI
	f6Xx81+noPu5q8PfqEuTDGrTNbM5T2JHGHqjyR3YflfAxLdx9rDngsVxYR/Plrm+HTa1HmNyBVEFd
	UPSLnMLImuAJqKZk7uIeFjbcvS4N5G526PXfR1sHaqCXua7Nm6djZTts9jVlbnP8qcrIJvKRBZQyS
	NjYpTkFfQck3wmHM0tKRd/1YQUc+OzGYjUi2+g0opJTSMOqqpXGKKL+8pFWpGPblCJAMFCMEDouBX
	p4IUY4sxug+OJ4iizOxnYIvjPF7g2qYI7TxC9U7Xpr2DtFBZ1Dh5fV2G8LGJfsErjAeDl/TNV8UA6
	n7iIwVWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVsXY-001YNm-2z;
	Tue, 15 Aug 2023 11:48:48 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVsXV-001YNE-1r
	for linux-nvme@lists.infradead.org;
	Tue, 15 Aug 2023 11:48:47 +0000
Received: from lanta.blr.asicdesigners.com (lanta.blr.asicdesigners.com [10.193.186.249])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 37FBmKW9016955;
	Tue, 15 Aug 2023 04:48:21 -0700
From: Varun Prakash <varun@chelsio.com>
To: sagi@grimberg.me, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, varun@chelsio.com,
        Rakshana Sridhar <rakshanas@chelsio.com>
Subject: [PATCH v4] nvmet-tcp: fix data digest calculation for multiple H2CData PDUs
Date: Tue, 15 Aug 2023 17:12:00 +0530
Message-Id: <20230815114200.50705-1-varun@chelsio.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230815_044845_654048_C28DF076 
X-CRM114-Status: GOOD (  12.02  )
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

On receiving H2CData PDU current code calculates data digest for the entire
transfer length, it works if host sends only one H2CData PDU per cmd, if
host sends multiple H2CData PDU per cmd then target reports data digest
error.

This issue was fixed in commit fda871c0ba5d ("nvmet-tcp: fix receive data
digest calculation for multiple h2cdata PDUs").

commit bac04454ef9f ("nvmet-tcp: fix kmap leak when data digest in use")
unmaps sg page before calculating data digest and
commit 69b85e1f1d1d ("nvmet-tcp: add an helper to free the cmd buffers")
sets cmd->nr_mapped = 0 after unmapping iovec, both of these commits
caused regression in data digest calculation.

To fix this regression commit ed0691cf5514 ("nvmet-tcp: fix regression in
data_digest calculation") changed the logic to use sg directly instead of
iovec, this commit calculates data digest for the entire transfer length
so it caused another regression for multiple H2CData PDU per cmd case.

commit 5bfaba275ae6 ("nvmet-tcp: don't map pages which can't come from
HIGHMEM") removed sg page mapping code and added bio_vec so now nvmet-tcp
driver can use bio_vec for calculating data digest.

Fixes: ed0691cf5514 ("nvmet-tcp: fix regression in data_digest calculation")
Signed-off-by: Rakshana Sridhar <rakshanas@chelsio.com>
Signed-off-by: Varun Prakash <varun@chelsio.com>
---
 drivers/nvme/target/tcp.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index cd92d7ddf5ed..49cc96ace4a7 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -415,7 +415,7 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 	return NVME_SC_INTERNAL;
 }
 
-static void nvmet_tcp_calc_ddgst(struct ahash_request *hash,
+static void nvmet_tcp_calc_send_ddgst(struct ahash_request *hash,
 		struct nvmet_tcp_cmd *cmd)
 {
 	ahash_request_set_crypt(hash, cmd->req.sg,
@@ -447,7 +447,7 @@ static void nvmet_setup_c2h_data_pdu(struct nvmet_tcp_cmd *cmd)
 
 	if (queue->data_digest) {
 		pdu->hdr.flags |= NVME_TCP_F_DDGST;
-		nvmet_tcp_calc_ddgst(queue->snd_hash, cmd);
+		nvmet_tcp_calc_send_ddgst(queue->snd_hash, cmd);
 	}
 
 	if (cmd->queue->hdr_digest) {
@@ -1152,11 +1152,34 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 	return nvmet_tcp_done_recv_pdu(queue);
 }
 
+static void nvmet_tcp_calc_recv_ddgst(struct ahash_request *hash,
+		struct nvmet_tcp_cmd *cmd)
+{
+	struct bio_vec *iov = cmd->iov;
+	struct scatterlist sg;
+	u32 data_length = cmd->pdu_len;
+
+	sg_init_table(&sg, 1);
+	crypto_ahash_init(hash);
+
+	while (data_length) {
+		sg_set_page(&sg, iov->bv_page, iov->bv_len, iov->bv_offset);
+		ahash_request_set_crypt(hash, &sg, NULL, iov->bv_len);
+		crypto_ahash_update(hash);
+
+		data_length -= iov->bv_len;
+		iov++;
+	}
+
+	ahash_request_set_crypt(hash, NULL, (void *)&cmd->exp_ddgst, 0);
+	crypto_ahash_final(hash);
+}
+
 static void nvmet_tcp_prep_recv_ddgst(struct nvmet_tcp_cmd *cmd)
 {
 	struct nvmet_tcp_queue *queue = cmd->queue;
 
-	nvmet_tcp_calc_ddgst(queue->rcv_hash, cmd);
+	nvmet_tcp_calc_recv_ddgst(queue->rcv_hash, cmd);
 	queue->offset = 0;
 	queue->left = NVME_TCP_DIGEST_LENGTH;
 	queue->rcv_state = NVMET_TCP_RECV_DDGST;
-- 
2.27.0


