Return-Path: <SRS0=qJQi=GX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CE3C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 09:49:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE39D22227
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Jan 2021 09:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE39D22227
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=73ZmcVBS8L2IV5YlSwh5pUXTBOS3J93+9yqjgW5iGAE=; b=BiU67kZLgaaUucMSNY2JkgwqK
	AD/anmZ7nrGEVsoR5sw2mliWpXuhg1PTr0JFgZtc+2wJSBXCsEacTYewUsAjYDUDkuqbN4wtyz0wC
	U+wmv2oKAI5poPqxp1vKxrqhL2kmJG+Jbn9SgsrZxW96pCRP5ZW6lkHqbFjWR1qK5m4Wjz1lN+f0A
	NDQ3YlREN+NmcPFNao4FV28l8AUSIHMueCnZPkop4a4WErsMSxmRQfZCI005RQDtlF/KLWQyT33yE
	2XfATGQNcJnoBTG7r7qAZ3x/OmrHyeN1C4Y1pt7vG+DukwvHY/udUDBND3dc1tGgWsl4tBdNIQN77
	uugDsYkcg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2A7D-0004LQ-4R; Wed, 20 Jan 2021 09:49:27 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2A7B-0004Kk-2T
 for linux-nvme@merlin.infradead.org; Wed, 20 Jan 2021 09:49:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=cums3YSkimeRQeCo2bS0Q+qbEjT0TSG2DVJU9en/38w=; b=tVhiW/g/vI/Dejym5/ImpQvanR
 jIktnp+10j2aZ3jwOySom7NJt/mZqnOXHrkPd2G2BuDTRP/0uTD2sDEqBET6SG/5EGeF3wZ3dmGlH
 2QW17nVzoRnAVI2csytgIPcXpS14OhEcUQ0Lpfduxh81vXDZ4+ynwLmv9s2aOWhFn8ifjLthNoPsl
 P7ViNFxHpHn2NuCrTrqiaXyrkS3+o52HkIaGh3z4VY9Cj1DF6pDkveUybg+UDOeYoVVc/EW5FsELt
 WT4/Yt6Cg/aRj8H0RdsgF7RL68eNQVxMn0WRWN30+hqIDaGgYKAj2FIl/NTLhdhofF49RcGHtmrtX
 lBq0khSA==;
Received: from [2001:4bb8:188:1954:9564:b169:fdf4:9927] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l2A76-00FUsu-RX; Wed, 20 Jan 2021 09:49:22 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme-pci: refactor nvme_unmap_data
Date: Wed, 20 Jan 2021 10:49:14 +0100
Message-Id: <20210120094915.3198346-2-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210120094915.3198346-1-hch@lst.de>
References: <20210120094915.3198346-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Marc Orr <marcorr@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Split out three helpers from nvme_unmap_data that will allow finer grained
unwinding from nvme_map_data.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 77 ++++++++++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 25456d02eddb8c..e29ece9e4d4b8e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -543,50 +543,71 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req)
 	return true;
 }
 
-static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
+static void nvme_free_prps(struct nvme_dev *dev, struct request *req)
 {
-	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	const int last_prp = NVME_CTRL_PAGE_SIZE / sizeof(__le64) - 1;
-	dma_addr_t dma_addr = iod->first_dma, next_dma_addr;
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	dma_addr_t dma_addr = iod->first_dma;
 	int i;
 
-	if (iod->dma_len) {
-		dma_unmap_page(dev->dev, dma_addr, iod->dma_len,
-			       rq_dma_dir(req));
-		return;
+	for (i = 0; i < iod->npages; i++) {
+		__le64 *prp_list = nvme_pci_iod_list(req)[i];
+		dma_addr_t next_dma_addr = le64_to_cpu(prp_list[last_prp]);
+
+		dma_pool_free(dev->prp_page_pool, prp_list, dma_addr);
+		dma_addr = next_dma_addr;
 	}
 
-	WARN_ON_ONCE(!iod->nents);
+}
 
-	if (is_pci_p2pdma_page(sg_page(iod->sg)))
-		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
-				    rq_dma_dir(req));
-	else
-		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
+static void nvme_free_sgls(struct nvme_dev *dev, struct request *req)
+{
+	const int last_sg = SGES_PER_PAGE - 1;
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	dma_addr_t dma_addr = iod->first_dma;
+	int i;
 
+	for (i = 0; i < iod->npages; i++) {
+		struct nvme_sgl_desc *sg_list = nvme_pci_iod_list(req)[i];
+		dma_addr_t next_dma_addr = le64_to_cpu((sg_list[last_sg]).addr);
 
-	if (iod->npages == 0)
-		dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],
-			dma_addr);
+		dma_pool_free(dev->prp_page_pool, sg_list, dma_addr);
+		dma_addr = next_dma_addr;
+	}
 
-	for (i = 0; i < iod->npages; i++) {
-		void *addr = nvme_pci_iod_list(req)[i];
+}
 
-		if (iod->use_sgl) {
-			struct nvme_sgl_desc *sg_list = addr;
+static void nvme_unmap_sg(struct nvme_dev *dev, struct request *req)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
-			next_dma_addr =
-			    le64_to_cpu((sg_list[SGES_PER_PAGE - 1]).addr);
-		} else {
-			__le64 *prp_list = addr;
+	if (is_pci_p2pdma_page(sg_page(iod->sg)))
+		pci_p2pdma_unmap_sg(dev->dev, iod->sg, iod->nents,
+				    rq_dma_dir(req));
+	else
+		dma_unmap_sg(dev->dev, iod->sg, iod->nents, rq_dma_dir(req));
+}
 
-			next_dma_addr = le64_to_cpu(prp_list[last_prp]);
-		}
+static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
-		dma_pool_free(dev->prp_page_pool, addr, dma_addr);
-		dma_addr = next_dma_addr;
+	if (iod->dma_len) {
+		dma_unmap_page(dev->dev, iod->first_dma, iod->dma_len,
+			       rq_dma_dir(req));
+		return;
 	}
 
+	WARN_ON_ONCE(!iod->nents);
+
+	nvme_unmap_sg(dev, req);
+	if (iod->npages == 0)
+		dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],
+			      iod->first_dma);
+	else if (iod->use_sgl)
+		nvme_free_sgls(dev, req);
+	else
+		nvme_free_prps(dev, req);
 	mempool_free(iod->sg, dev->iod_mempool);
 }
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
