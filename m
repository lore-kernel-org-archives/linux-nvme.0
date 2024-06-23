Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CF47C27C4F
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Jun 2024 13:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rtWmf6RFeRgktEHehV7asT1dAHp8yFNsHJtsQCDrMQQ=; b=joYRN7j57L7aCZU9XPSGiHFDqU
	nrqNbnQS2ZudXxUBe20LF2ONUlzHCXBL+2EofQGD61hjNmYFrMHm2D0EJRXWl7yCLpGbTs6nXclQy
	QV4/F7nTIR+5XlNCaD/yz0CUaVZdfaqL0wPdMkcIsW6jJF2zI0Ugr7MUq2U8UeHMOlOKhyWYcaHcJ
	gDRR9XE6HS/pVrvpg7w2P2ABnSngUC2ZTHKm99MtB1XVtG6q1dUn4/DVLCiMJ+44lNeNCUpbasEuq
	vtf64xcPpfVxdd1rtlPuJvo+5j/rpNJNe8kymsnmbJsbVtdCGjZJ02EOrm4l8IvomfWUASHq+AlPA
	RsqaVf0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLNXQ-0000000E5u9-13ut;
	Sun, 23 Jun 2024 13:45:48 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLNXI-0000000E5o5-0J1D
	for linux-nvme@lists.infradead.org;
	Sun, 23 Jun 2024 13:45:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0D9FBCE0E89;
	Sun, 23 Jun 2024 13:45:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081A0C4AF09;
	Sun, 23 Jun 2024 13:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719150337;
	bh=yZc3eAsmn69vQqaVj3P/DeKrGp7vPL3/p1Lmf0OJ4J4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mcSj77oEPC3bATMVEHydB/DVIzG5QBmmMjScnXeXZ2/JxTg8sKkYDAr4pArPjbp7k
	 o4UtzlISdhvo9FMYGX5iVEFQNqvtHNcnmnx1l3I684rPznTLuF8Ig2JTDK6xvXIVc0
	 l+k0Smtb3ocrUFWL1eqr6FcvDjVfd0alORoj0iRyJMdCGChGCbam7t7YO6hOQRNDCM
	 XWfTUYm5rs0VX9r/taAESEpC5AVigICiY0CpY80dC7efETNjf/PJeZlQ4AvnNjLLy9
	 5Zz7cIQ5BdsupXrT4YcbdBi3m/JeLzodUqQJE3xqYivxkd5zp7IzPDOAHr2sPhvj73
	 mxAuJ/64cnq5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	kch@nvidia.com,
	hare@suse.de,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 12/12] nvmet: always initialize cqe.result
Date: Sun, 23 Jun 2024 09:45:15 -0400
Message-ID: <20240623134518.809802-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623134518.809802-1-sashal@kernel.org>
References: <20240623134518.809802-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.95
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240623_064540_940847_00D7E762 
X-CRM114-Status: GOOD (  14.71  )
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

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit cd0c1b8e045a8d2785342b385cb2684d9b48e426 ]

The spec doesn't mandate that the first two double words (aka results)
for the command queue entry need to be set to 0 when they are not
used (not specified). Though, the target implemention returns 0 for TCP
and FC but not for RDMA.

Let's make RDMA behave the same and thus explicitly initializing the
result field. This prevents leaking any data from the stack.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/core.c             | 1 +
 drivers/nvme/target/fabrics-cmd-auth.c | 3 ---
 drivers/nvme/target/fabrics-cmd.c      | 6 ------
 3 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 7b74926c50f9b..eeb46fec7b856 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -935,6 +935,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->metadata_sg_cnt = 0;
 	req->transfer_len = 0;
 	req->metadata_len = 0;
+	req->cqe->result.u64 = 0;
 	req->cqe->status = 0;
 	req->cqe->sq_head = 0;
 	req->ns = NULL;
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index fbae76cdc2546..e0dc22fea086d 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -336,7 +336,6 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 		pr_debug("%s: ctrl %d qid %d nvme status %x error loc %d\n",
 			 __func__, ctrl->cntlid, req->sq->qid,
 			 status, req->error_loc);
-	req->cqe->result.u64 = 0;
 	if (req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2 &&
 	    req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
 		unsigned long auth_expire_secs = ctrl->kato ? ctrl->kato : 120;
@@ -528,8 +527,6 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 	status = nvmet_copy_to_sgl(req, 0, d, al);
 	kfree(d);
 done:
-	req->cqe->result.u64 = 0;
-
 	if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2)
 		nvmet_auth_sq_free(req->sq);
 	else if (req->sq->dhchap_step == NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index d8da840a1c0ed..fa9e8dc921539 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -225,9 +225,6 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	if (status)
 		goto out;
 
-	/* zero out initial completion result, assign values as needed */
-	req->cqe->result.u32 = 0;
-
 	if (c->recfmt != 0) {
 		pr_warn("invalid connect version (%d).\n",
 			le16_to_cpu(c->recfmt));
@@ -305,9 +302,6 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	if (status)
 		goto out;
 
-	/* zero out initial completion result, assign values as needed */
-	req->cqe->result.u32 = 0;
-
 	if (c->recfmt != 0) {
 		pr_warn("invalid connect version (%d).\n",
 			le16_to_cpu(c->recfmt));
-- 
2.43.0


