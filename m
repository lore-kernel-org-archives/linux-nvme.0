Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B47CCCD183
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Oct 2025 15:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=18dP741miOGiNN9KZ0RuBcIyVGpE0okBpt9XAQHjb78=; b=Rz5egXOBlvof2fCjVQdApFBNH5
	jVV3EMV9SY1tfiq4n3Z01/scfn1fJJBA2jBkvgXGJPY1mg3DLHojD4Q99WlNNULehr2Hb5jEG/Ldm
	Pl7YwbX0sAGCmxAi1IP2Rfhd0L1Ono3ScX0MzMlXBBCvudbFkCvDO6IYOUcVFbXrDUgJ2fov6GJ1C
	Hy4cnQSfacKkZa2QJ9uk7XaPyQdL5WRkUMTDDhnbhoFPncVot3dcaEnMLokV9zQqzOBiBca1Ooiv3
	4m7ZnHtYMcVnhoKCTA3xXMm7glSIKWLeRn4gobhI6enUZttMvcAikwvmZioRbQ1b+/GirKgwi0mpQ
	Xqo6JBHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8KZK-0000000Dhae-3xLm;
	Mon, 13 Oct 2025 15:34:38 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8KZJ-0000000DhZ5-01t5
	for linux-nvme@lists.infradead.org;
	Mon, 13 Oct 2025 15:34:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A8841403DD;
	Mon, 13 Oct 2025 15:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 108DAC4CEE7;
	Mon, 13 Oct 2025 15:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760369676;
	bh=cTfVUlcIZmB2VTW1tCVb8Ovby/1S+8U9GtrGTaQ5l08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oXU+QPQhMsdd3GMO5wxISxbQdnoHt4rFW9wze89jVxeWTZO8xSkdGVK/A2amY9VVk
	 +hEf3LfvGn3znYRQpFXnXtdeWt/DeFXzCnIB5gKUr/uJeMMsR+IM3d43T8NbSJ8ats
	 XhAvnsmtLk+cAQCOeSHjpM94vBWbkUjmKOqf7ipzrL7Y6PBBROo0ZnMC5rImj1fXkB
	 kys909uRqRTmgUs8Z5nKOy1rHy1TqNDLnP2OrzSE/flEUn8ajRP2t2EUq/+ivs19de
	 E5+CbZKAnwPaTQbrywVVwzVorrNNoPJbTX0kCBOdBnsvglahM45Fiu6lC2RwDNkRDl
	 hHdfbA5P5/5Nw==
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH 4/4] nvme-pci: unmap MMIO pages with appropriate interface
Date: Mon, 13 Oct 2025 18:34:12 +0300
Message-ID: <6522567376d50f71425ccc4950552fca48e4f57f.1760369219.git.leon@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760369219.git.leon@kernel.org>
References: <cover.1760369219.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_083437_067717_CA8E62F8 
X-CRM114-Status: GOOD (  11.55  )
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

From: Leon Romanovsky <leonro@nvidia.com>

Block layer maps MMIO memory through dma_map_phys() interface
with help of DMA_ATTR_MMIO attribute. There is a need to unmap
that memory with the appropriate unmap function, something which
wasn't possible before adding new REQ attribute to block layer in
previous patch.

Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/nvme/host/pci.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c916176bd9f0..2e9fb3c7bc09 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -689,11 +689,15 @@ static void nvme_free_prps(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
+	unsigned int attrs = 0;
 	unsigned int i;
 
+	if (req->cmd_flags & REQ_MMIO)
+		attrs |= DMA_ATTR_MMIO;
+
 	for (i = 0; i < iod->nr_dma_vecs; i++)
-		dma_unmap_page(nvmeq->dev->dev, iod->dma_vecs[i].addr,
-				iod->dma_vecs[i].len, rq_dma_dir(req));
+		dma_unmap_phys(nvmeq->dev->dev, iod->dma_vecs[i].addr,
+				iod->dma_vecs[i].len, rq_dma_dir(req), attrs);
 	mempool_free(iod->dma_vecs, nvmeq->dev->dmavec_mempool);
 }
 
@@ -704,16 +708,20 @@ static void nvme_free_sgls(struct request *req, struct nvme_sgl_desc *sge,
 	enum dma_data_direction dir = rq_dma_dir(req);
 	unsigned int len = le32_to_cpu(sge->length);
 	struct device *dma_dev = nvmeq->dev->dev;
+	unsigned int attrs = 0;
 	unsigned int i;
 
+	if (req->cmd_flags & REQ_MMIO)
+		attrs |= DMA_ATTR_MMIO;
+
 	if (sge->type == (NVME_SGL_FMT_DATA_DESC << 4)) {
-		dma_unmap_page(dma_dev, le64_to_cpu(sge->addr), len, dir);
+		dma_unmap_phys(dma_dev, le64_to_cpu(sge->addr), len, dir, attrs);
 		return;
 	}
 
 	for (i = 0; i < len / sizeof(*sg_list); i++)
-		dma_unmap_page(dma_dev, le64_to_cpu(sg_list[i].addr),
-			le32_to_cpu(sg_list[i].length), dir);
+		dma_unmap_phys(dma_dev, le64_to_cpu(sg_list[i].addr),
+			le32_to_cpu(sg_list[i].length), dir, attrs);
 }
 
 static void nvme_unmap_metadata(struct request *req)
-- 
2.51.0


