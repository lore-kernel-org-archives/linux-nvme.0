Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D296C001DC
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jul 2023 14:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NEP5RHp+44Am9mepgR/rTljtRvfb91FNKmGb72PF2aU=; b=Uwrs1aswuJ+8U6fOZe1E0JFL8g
	rP8LHwZMC6FFDQndu3YCe6VZKSIU6IF4b4aCs0kYxPSLa9BNCEYM0bbCIFuCTIDBW6hHms8++FRYh
	MGq0VtTmDur5dSRLmH2Pj/phAyteWTtW0JDTZ5BxGK8DZUv0uV7mA3Ua9Kv6M5F4Q+1wFOaFbmWA1
	fjxN/PqpJ8laRe7cjxzCpAzOLj1cqAiwciZwRDw0GWUYNulwLUDas5T4ju8V/+ofvN9KYoo5vuppF
	prAiI3PKZyr9MV1ULD/UZvpEa9ggc5MMhMnpha2ZaKSP7gJ/6cKVQ/NbWpU3FoHgZi+Y31lO4XdMg
	+12oxLjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qP2Be-00FKZd-0P;
	Thu, 27 Jul 2023 14:41:54 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qP2BY-00FKVS-1N
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jul 2023 14:41:52 +0000
Received: from fcoe-test11.blr.asicdesigners.com (fcoe-test11.blr.asicdesigners.com [10.193.185.180])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 36REfgh5006329;
	Thu, 27 Jul 2023 07:41:43 -0700
From: Varun Prakash <varun@chelsio.com>
To: sagi@grimberg.me, hch@lst.de
Cc: linux-nvme@lists.infradead.org, varun@chelsio.com,
        Rakshana Sridhar <rakshanas@chelsio.com>
Subject: [PATCH] nvmet-tcp: fix data digest calculation for multiple H2CData PDUs
Date: Thu, 27 Jul 2023 20:37:31 +0530
Message-Id: <20230727150731.5905-1-varun@chelsio.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230727_074151_065359_529B061E 
X-CRM114-Status: GOOD (  11.10  )
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

commit ed0691cf5514 ("nvmet-tcp: fix regression in data_digest
calculation") reverted the fix done in the above commit.

Fixes: ed0691cf5514 ("nvmet-tcp: fix regression in data_digest calculation")
Signed-off-by: Rakshana Sridhar <rakshanas@chelsio.com>
Signed-off-by: Varun Prakash <varun@chelsio.com>
---
 drivers/nvme/target/tcp.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 05163751f2e5..e5e3498675af 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -415,8 +415,8 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 	return NVME_SC_INTERNAL;
 }
 
-static void nvmet_tcp_calc_ddgst(struct ahash_request *hash,
-		struct nvmet_tcp_cmd *cmd)
+static void nvmet_tcp_send_ddgst(struct ahash_request *hash,
+				 struct nvmet_tcp_cmd *cmd)
 {
 	ahash_request_set_crypt(hash, cmd->req.sg,
 		(void *)&cmd->exp_ddgst, cmd->req.transfer_len);
@@ -447,7 +447,7 @@ static void nvmet_setup_c2h_data_pdu(struct nvmet_tcp_cmd *cmd)
 
 	if (queue->data_digest) {
 		pdu->hdr.flags |= NVME_TCP_F_DDGST;
-		nvmet_tcp_calc_ddgst(queue->snd_hash, cmd);
+		nvmet_tcp_send_ddgst(queue->snd_hash, cmd);
 	}
 
 	if (cmd->queue->hdr_digest) {
@@ -1152,11 +1152,34 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 	return nvmet_tcp_done_recv_pdu(queue);
 }
 
+static void nvmet_tcp_recv_ddgst(struct ahash_request *hash,
+				 struct nvmet_tcp_cmd *cmd)
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
+	nvmet_tcp_recv_ddgst(queue->rcv_hash, cmd);
 	queue->offset = 0;
 	queue->left = NVME_TCP_DIGEST_LENGTH;
 	queue->rcv_state = NVMET_TCP_RECV_DDGST;
-- 
2.31.1


