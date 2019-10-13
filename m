Return-Path: <SRS0=ek/0=YG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D853BC4CECE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Oct 2019 16:59:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB2BD20679
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Oct 2019 16:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="d+2zern9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB2BD20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=UxNn2OZihvnihxkVafv7bmkvwyA2lshhpeY+KKKZ1sw=; b=d+2zern9ixrCmcXmFzfXXlekfv
	hy2PQ9im6FvJtaYW+GmB1W76UMcEigx1tlxUnQG96muR66G5Hi3cBooa1pzNVJJoPzRSMBf3S5e8m
	QSg9Ixqx89Ps2aynF6O62snriXlccAPQwaMPCHxhDr4sYQFgNUJF0rN0cYSe5M+2fYnwCnMgZcg9y
	V6oCnhVU6Gjz3txBSQsm5xbKaq2sJQOFp9ncprPUc5AQbHmyD5X3CUQZXF1SIOfFgaMyRJKzfhILC
	3sMGwzh3L3VegBuD2l1EMTpIvT/eaSmsYI2cJ7bL8LLdeSddtpnCPk4jzcIZm92TIRArgTJC+tlPC
	owtOkQcw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iJhDL-0006F0-Hl; Sun, 13 Oct 2019 16:59:27 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iJhBq-0004u6-CB
 for linux-nvme@lists.infradead.org; Sun, 13 Oct 2019 16:57:58 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 13 Oct 2019 18:57:40 +0200
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x9DGvdoR005965;
 Sun, 13 Oct 2019 19:57:40 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me
Subject: [PATCH 6/8] nvme: move common call to nvme_cleanup_cmd to core layer
Date: Sun, 13 Oct 2019 19:57:36 +0300
Message-Id: <1570985858-26805-7-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1570985858-26805-1-git-send-email-maxg@mellanox.com>
References: <1570985858-26805-1-git-send-email-maxg@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191013_095754_815706_9A65F9A5 
X-CRM114-Status: GOOD (  10.28  )
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
Cc: Max Gurtovoy <maxg@mellanox.com>, israelr@mellanox.com,
 james.smart@broadcom.com, shlomin@mellanox.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvme_cleanup_cmd should be called for each call to nvme_setup_cmd
(symmetrical functions). Move the call for nvme_cleanup_cmd to the common
core layer and call it during nvme_complete_rq for the good flow. For
error flow, each transport will call nvme_cleanup_cmd independently. Also
take care of a special case of path failure, where we call
nvme_complete_rq without doing nvme_setup_cmd.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/host/core.c   |  2 ++
 drivers/nvme/host/fc.c     |  3 +--
 drivers/nvme/host/pci.c    |  1 -
 drivers/nvme/host/rdma.c   | 12 +++++-------
 drivers/nvme/target/loop.c |  1 -
 5 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2203309..033b16c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -268,6 +268,8 @@ void nvme_complete_rq(struct request *req)
 
 	trace_nvme_complete_rq(req);
 
+	nvme_cleanup_cmd(req);
+
 	if (nvme_req(req)->ctrl->kas)
 		nvme_req(req)->ctrl->comp_seen = true;
 
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 265f89e..1e14dd6 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2173,8 +2173,6 @@ enum {
 	fc_dma_unmap_sg(ctrl->lport->dev, freq->sg_table.sgl, op->nents,
 			rq_dma_dir(rq));
 
-	nvme_cleanup_cmd(rq);
-
 	sg_free_table_chained(&freq->sg_table, SG_CHUNK_SIZE);
 
 	freq->sg_cnt = 0;
@@ -2305,6 +2303,7 @@ enum {
 		if (!(op->flags & FCOP_FLAGS_AEN))
 			nvme_fc_unmap_data(ctrl, op->rq, op);
 
+		nvme_cleanup_cmd(op->rq);
 		nvme_fc_ctrl_put(ctrl);
 
 		if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE &&
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f8f76a9..55939df 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -924,7 +924,6 @@ static void nvme_pci_complete_rq(struct request *req)
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_dev *dev = iod->nvmeq->dev;
 
-	nvme_cleanup_cmd(req);
 	if (blk_integrity_rq(req))
 		dma_unmap_page(dev->dev, iod->meta_dma,
 			       rq_integrity_vec(req)->bv_len, rq_data_dir(req));
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 154fa4e..05f2dfa 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1160,8 +1160,6 @@ static void nvme_rdma_unmap_data(struct nvme_rdma_queue *queue,
 	}
 
 	ib_dma_unmap_sg(ibdev, req->sg_table.sgl, req->nents, rq_dma_dir(rq));
-
-	nvme_cleanup_cmd(rq);
 	sg_free_table_chained(&req->sg_table, SG_CHUNK_SIZE);
 }
 
@@ -1760,7 +1758,6 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(err < 0)) {
 		dev_err(queue->ctrl->ctrl.device,
 			     "Failed to map data (%d)\n", err);
-		nvme_cleanup_cmd(rq);
 		goto err;
 	}
 
@@ -1771,18 +1768,19 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
 			req->mr ? &req->reg_wr.wr : NULL);
-	if (unlikely(err)) {
-		nvme_rdma_unmap_data(queue, rq);
-		goto err;
-	}
+	if (unlikely(err))
+		goto err_unmap;
 
 	return BLK_STS_OK;
 
+err_unmap:
+	nvme_rdma_unmap_data(queue, rq);
 err:
 	if (err == -ENOMEM || err == -EAGAIN)
 		ret = BLK_STS_RESOURCE;
 	else
 		ret = BLK_STS_IOERR;
+	nvme_cleanup_cmd(rq);
 unmap_qe:
 	ib_dma_unmap_single(dev, req->sqe.dma, sizeof(struct nvme_command),
 			    DMA_TO_DEVICE);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index bd1f81f..5b7b197 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -76,7 +76,6 @@ static void nvme_loop_complete_rq(struct request *req)
 {
 	struct nvme_loop_iod *iod = blk_mq_rq_to_pdu(req);
 
-	nvme_cleanup_cmd(req);
 	sg_free_table_chained(&iod->sg_table, SG_CHUNK_SIZE);
 	nvme_complete_rq(req);
 }
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
