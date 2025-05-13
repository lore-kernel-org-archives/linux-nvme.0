Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73155C3ABC3
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 07:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5io4WHUwTf0a/dsX7XjiVz2g1Z0oLmYNb5WcFBsCXH4=; b=CNqP+FHvGWeSvqb+JJ8Jz5jCve
	RoKf/JbCJEcZAH94sKW4YooN/Q1yjxq5MURLe7DIgUbiPj0XkNS2Mv15anR1w2KMlb6qk1BGNy1Ex
	6V1+dkykqiZitcXBXV+7fAS9GoPdxqscQV2vKyTGBGnmnCzhFuZFjv8DVGjM0uwokRuXna5KDuIZd
	McAhZKwxanucvTpHCS8crJgxCYuG4q1NtDDSEe0gf9J4NDZmOd+XeXs750R7pVv/q44UqmllF8mg+
	oZ9ZrcMF1UCuTRpf2Pjgu2tLUoEndAwxO4qq8kCKOzroTCuiaeGSE60qBnvWtWt7c0G1mTWvwQs+b
	Ql/93Bog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEjd9-0000000BZ6L-0Dxl;
	Tue, 13 May 2025 07:00:47 +0000
Received: from 2a02-8389-2341-5b80-3c00-8f88-6e38-56f1.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3c00:8f88:6e38:56f1] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEjd7-0000000BZ3Y-2FyF;
	Tue, 13 May 2025 07:00:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 6/7] nvme-pci: add a symolic name for the small pool size
Date: Tue, 13 May 2025 09:00:22 +0200
Message-ID: <20250513070025.830930-7-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513070025.830930-1-hch@lst.de>
References: <20250513070025.830930-1-hch@lst.de>
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

From: Leon Romanovsky <leon@kernel.org>

Open coding magic numbers in multiple places is never a good idea.

Signed-off-by: Leon Romanovsky <leon@kernel.org>
[hch: split from a larger patch]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 16e2ce25da83..5396fe30eb94 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -37,6 +37,8 @@
 
 #define SGES_PER_PAGE	(NVME_CTRL_PAGE_SIZE / sizeof(struct nvme_sgl_desc))
 
+#define NVME_SMALL_POOL_SIZE	256
+
 /*
  * These can be higher, but we need to ensure that any command doesn't
  * require an sg allocation that needs more than a page of data.
@@ -407,7 +409,7 @@ static struct nvme_descriptor_pools *
 nvme_setup_descriptor_pools(struct nvme_dev *dev, unsigned numa_node)
 {
 	struct nvme_descriptor_pools *pools = &dev->descriptor_pools[numa_node];
-	size_t small_align = 256;
+	size_t small_align = NVME_SMALL_POOL_SIZE;
 
 	if (pools->small)
 		return pools; /* already initialized */
@@ -422,7 +424,7 @@ nvme_setup_descriptor_pools(struct nvme_dev *dev, unsigned numa_node)
 
 	/* Optimisation for I/Os between 4k and 128k */
 	pools->small = dma_pool_create_node("nvme descriptor 256", dev->dev,
-			256, small_align, 0, numa_node);
+			NVME_SMALL_POOL_SIZE, small_align, 0, numa_node);
 	if (!pools->small) {
 		dma_pool_destroy(pools->large);
 		pools->large = NULL;
@@ -689,7 +691,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_queue *nvmeq,
 	}
 
 	if (DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE) <=
-	    256 / sizeof(__le64))
+	    NVME_SMALL_POOL_SIZE / sizeof(__le64))
 		iod->flags |= IOD_SMALL_DESCRIPTOR;
 
 	prp_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
@@ -774,7 +776,7 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_queue *nvmeq,
 		return BLK_STS_OK;
 	}
 
-	if (entries <= 256 / sizeof(*sg_list))
+	if (entries <= NVME_SMALL_POOL_SIZE / sizeof(*sg_list))
 		iod->flags |= IOD_SMALL_DESCRIPTOR;
 
 	sg_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
-- 
2.47.2


