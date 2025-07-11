Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5465FC83F1D
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Jul 2025 11:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kMw2Cuaxlh63EApH3U8Zzz8V0/T8t6iiXh5U9SCMTV8=; b=rxG+OREx6EJ+aLX55483l1hJU0
	FJTpGz3tAs1K4nR1Ytfeu+6kH5Q5P7VERosUrhbAD91xIZYEqscTU39/yG/Dmmi1Lkdc2vi0Fb+Zs
	sdf3D0TTHKsNUKoI5mu10zgrq5/8iMlG1sBAGsXFQUU6gO1afFuYCnqTwpfVy+2Ek92CGjALxghtn
	bkf8JQFXVXgV5b0RM4GFP/y0QnUrGmr68dPWXb6aL/92D+937xHnNcWK76VNz2HxyMc8IcH2t3Nbj
	b2rMSXTZIwd/eSBrxMwEqzXXrlAjBgER60fboEzR4eSUxpYny1B83LNFU8exs343v7GI7Rx3DuT3c
	bLeho7wg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaC5m-0000000Ec5U-2QNU;
	Fri, 11 Jul 2025 11:39:02 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uaBqA-0000000Eao9-431W;
	Fri, 11 Jul 2025 11:22:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Klara Modin <klarasmodin@gmail.com>
Subject: [PATCH] nvme-pci: don't allocate dma_vec for IOVA mappings
Date: Fri, 11 Jul 2025 13:22:50 +0200
Message-ID: <20250711112250.633269-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Not only do IOVA mappings no need the separate dma_vec tracking, it
also won't free it and thus leak the allocations.

Fixes: 10f50d4127e2 ("nvme-pci: fix dma unmapping when using PRPs and not using the IOVA mapping")
Reported-by: Klara Modin <klarasmodin@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Klara Modin <klarasmodin@gmail.com>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6af184f2b73b..3290fd922efb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -745,7 +745,7 @@ static bool nvme_pci_prp_iter_next(struct request *req, struct device *dma_dev,
 		return true;
 	if (!blk_rq_dma_map_iter_next(req, dma_dev, &iod->dma_state, iter))
 		return false;
-	if (dma_need_unmap(dma_dev)) {
+	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(dma_dev)) {
 		iod->dma_vecs[iod->nr_dma_vecs].addr = iter->addr;
 		iod->dma_vecs[iod->nr_dma_vecs].len = iter->len;
 		iod->nr_dma_vecs++;
@@ -763,7 +763,7 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	unsigned int prp_len, i;
 	__le64 *prp_list;
 
-	if (dma_need_unmap(nvmeq->dev->dev)) {
+	if (!dma_use_iova(&iod->dma_state) && dma_need_unmap(nvmeq->dev->dev)) {
 		iod->dma_vecs = mempool_alloc(nvmeq->dev->dmavec_mempool,
 				GFP_ATOMIC);
 		if (!iod->dma_vecs)
-- 
2.47.2


