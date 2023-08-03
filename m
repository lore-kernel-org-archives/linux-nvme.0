Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 989D3C001DF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Aug 2023 10:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=r1BWEP5cdmoEUOY2tFg2vml/WwFIA9RpduvtWjxLQLs=; b=ObL2SJ7//eFZGrKSBpcM+Tz+Dv
	1ATlA3C1Z/X3nxBCpk1hPtEpgXT9eoBKI54bd39JLVf/wZ7whFSG29omvsTPwf0n7FlbPD8b+enLz
	2rAMXOZegZ0m+3K5zmP5Gorf9HL36bWP6YuBq8UOQ816vNkq6bfQXTK3LBV1LfYyPp2p4PUcuGfj1
	/tJwKMgklI7Z8NlCnU/IMtmmlHqWY9DozK7pkaLWb7DbycC2LqUkPRMNDT/38Dx8slTLqJtbHO/L+
	zC20+sYf8d/VI1v1tsUYxWn/5qGn2pH9T30HO/rU5GxKiY/cGYc34UdDC6bbJTtFe19dd+UYnO6y6
	cu0TfjWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRVdu-007OMb-1N;
	Thu, 03 Aug 2023 10:33:18 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRVdp-007OIB-38
	for linux-nvme@lists.infradead.org;
	Thu, 03 Aug 2023 10:33:16 +0000
Received: from fcoe-test11.blr.asicdesigners.com (fcoe-test11.blr.asicdesigners.com [10.193.185.180])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 373AWmk1010174;
	Thu, 3 Aug 2023 03:32:49 -0700
From: Varun Prakash <varun@chelsio.com>
To: sagi@grimberg.me, hch@lst.de, kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, varun@chelsio.com,
        Rakshana Sridhar <rakshanas@chelsio.com>
Subject: [PATCH v2] nvmet-tcp: fix data digest calculation for multiple H2CData PDUs
Date: Thu,  3 Aug 2023 16:28:39 +0530
Message-Id: <20230803105839.6139-1-varun@chelsio.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_033314_109324_1F2C58C1 
X-CRM114-Status: GOOD (  12.44  )
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
unmaps iovec before calculating data digest and
commit 69b85e1f1d1d ("nvmet-tcp: add an helper to free the cmd buffers")
sets cmd->nr_mapped = 0 after unmapping iovec, both of these commits
caused regression in data digest calculation.

To fix this regression commit ed0691cf5514 ("nvmet-tcp: fix regression in
data_digest calculation") changed the logic to use sg directly instead of
iovec, it calculates data digest for the entire transfer length this
caused another regression for multiple H2CData PDU per cmd case.

Fixes: ed0691cf5514 ("nvmet-tcp: fix regression in data_digest calculation")
Signed-off-by: Rakshana Sridhar <rakshanas@chelsio.com>
Signed-off-by: Varun Prakash <varun@chelsio.com>
---

v2:
- used sg instead of iovec for data digest calculation
- updated commit message

 drivers/nvme/target/tcp.c | 42 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index cd92d7ddf5ed..4d72b4b2b205 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -415,7 +415,7 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 	return NVME_SC_INTERNAL;
 }
 
-static void nvmet_tcp_calc_ddgst(struct ahash_request *hash,
+static void nvmet_tcp_send_ddgst(struct ahash_request *hash,
 		struct nvmet_tcp_cmd *cmd)
 {
 	ahash_request_set_crypt(hash, cmd->req.sg,
@@ -447,7 +447,7 @@ static void nvmet_setup_c2h_data_pdu(struct nvmet_tcp_cmd *cmd)
 
 	if (queue->data_digest) {
 		pdu->hdr.flags |= NVME_TCP_F_DDGST;
-		nvmet_tcp_calc_ddgst(queue->snd_hash, cmd);
+		nvmet_tcp_send_ddgst(queue->snd_hash, cmd);
 	}
 
 	if (cmd->queue->hdr_digest) {
@@ -1152,11 +1152,47 @@ static int nvmet_tcp_try_recv_pdu(struct nvmet_tcp_queue *queue)
 	return nvmet_tcp_done_recv_pdu(queue);
 }
 
+static void nvmet_tcp_recv_ddgst(struct ahash_request *hash,
+		struct nvmet_tcp_cmd *cmd)
+{
+	struct scatterlist *sg = &cmd->req.sg[cmd->sg_idx];
+	struct bio_vec *iov = cmd->iov;
+	u32 data_length = cmd->pdu_len;
+
+	crypto_ahash_init(hash);
+
+	if (iov->bv_offset) {
+		struct scatterlist first_sg;
+
+		sg_init_table(&first_sg, 1);
+		sg_set_page(&first_sg, sg_page(sg), iov->bv_len,
+				iov->bv_offset);
+
+		data_length -= iov->bv_len;
+
+		if (data_length) {
+			ahash_request_set_crypt(hash, &first_sg, NULL,
+						iov->bv_len);
+			crypto_ahash_update(hash);
+			sg = sg_next(sg);
+		} else {
+			ahash_request_set_crypt(hash, &first_sg,
+					(void *)&cmd->exp_ddgst, iov->bv_len);
+			crypto_ahash_finup(hash);
+			return;
+		}
+	}
+
+	ahash_request_set_crypt(hash, sg, (void *)&cmd->exp_ddgst,
+				data_length);
+	crypto_ahash_finup(hash);
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


