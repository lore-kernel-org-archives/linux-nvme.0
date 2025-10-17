Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C793CCD19E
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Oct 2025 05:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ARabr6i4Yk5w8HGMrRruPT+BEYRViYHkNjX/jX3dsxw=; b=0hXSLLFvds0f+7E7dbvp9T+hk7
	Szc99k/gOl2aFSM91pIWH2CFkZbNLxWGBBGReA3LkTfMTAAs9U+PG58w+LMBuWG4ZIfsJHP1yHFPH
	RBQ2gb6xy4MtE3i8BtalNnYyjvVz4PDKzJIL4gPFj8QoOvtXqz83H8r2onYf/iLhqI6XIOzEiGSB3
	JcSer6aeyOwyR0J0U3Gvm7w021zCO2sjL8zfiehpwCI3d0KHFIi3DkfDvYBeAzcIVq/Jppwb5nQJk
	1IyzdhKNwqTDLxyTfxM+Q6BTdakubCz/r9CCWKiYocKmh0eYN2IeLTnlqakT4jKItWEAIdn7t/FkE
	RhGEFssw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9d4b-00000006ctj-0AbP;
	Fri, 17 Oct 2025 05:32:17 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9d4Y-00000006csm-3ClQ
	for linux-nvme@lists.infradead.org;
	Fri, 17 Oct 2025 05:32:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 73F1C4ABC0;
	Fri, 17 Oct 2025 05:32:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE324C4CEE7;
	Fri, 17 Oct 2025 05:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760679134;
	bh=OpQMzB0nbAikwEUSyrTHgexMEqRPz+w6Ig5EcaTjQpM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oUM1GpBbrGzpY2Jrl/xtzB5Oyh5OU5OZdGN6XE9sfqSsGy+oMMYeIMxzWEY/2MT8l
	 AnKE4QXwhdS6vBhSTQ2rCLKYgXDwDJFDdNM2h1sMyY1VR+lXBCALudTSZFR/cyvBmH
	 +N2bE33Mk6vxd5NZ+cu+R5uQ3wtPS9fkVX0SIDaXalkclSzIlht+HNmq3fY/vSH5qn
	 CaZk8595crpdBFs7AAV/TcbtdqWHqfMEhVSINA2AALZDJ6iYGiu+cHe8d3SOsjNQLg
	 0zaehXlK8KHPSCWUDL4ZkaHKXsCIfUUYYjrUQdaFBAVQh05eDTZvnY6AtcGmmysbNs
	 xT3r46MEIh9Wg==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/3] nvme-pci: unmap MMIO pages with appropriate interface
Date: Fri, 17 Oct 2025 08:31:59 +0300
Message-ID: <20251017-block-with-mmio-v1-2-3f486904db5e@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com>
References: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251016_223214_824686_334156B2 
X-CRM114-Status: GOOD (  12.83  )
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


