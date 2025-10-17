Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83EECCD199
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Oct 2025 05:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cRrMepEq1zeeaviRiwhhYVERLVa5EzlijQm7EIJDu7g=; b=O8EtWgK/U9AA6Pe5kf3wcyrlBX
	08TUEuOjH7dgTXtxc1VXgD6GpjzKckiesRPwc9IrnnzYLOVY9kL9/rXHWOR0nECdfnpBgQ1axJ58+
	zlfvj4DNMZQH8jb/LUxTDv52+b8hjEOZ7xfrU4nuOh2rKeVwap9ovEIFaUuJQ0t21CkKmXfldjNrv
	Lly2xYg8KyiK4eFXeSUaFwRtfeOhuiIrHGAjaEH4jxf/8NfPYe2njGiqAzVSPAoSMAyRU9fcSH2BZ
	owNoDPNuwlx+TZpFU6ruCI6RZOyAewdvDDrkms5PHJFqndNlXP/hajnoC/35DWyKpRARh1kRb1fFJ
	7GRKwX8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9d4e-00000006cvS-1SkG;
	Fri, 17 Oct 2025 05:32:20 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9d4d-00000006cv1-0XQp
	for linux-nvme@lists.infradead.org;
	Fri, 17 Oct 2025 05:32:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8C7CA641DB;
	Fri, 17 Oct 2025 05:32:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF116C113D0;
	Fri, 17 Oct 2025 05:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760679138;
	bh=XPHX/eHvGPXhe7Cbw4X4FLHQozypPe//xTo6GQUz20c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gCjpkbiShSqT4gKgh1M2MEZbEZ2Vc/DNTaksMsNyGFGAB1tAEABTaYT2P/W8Ext8E
	 2sg1w2LFPRf+it0F42GOcnS+m75CoSGR2se6be0FYCunVEjzyOPeWtx5a0rDWv8Lg0
	 9HwGZIUIQL2t+K8t1djhHWLDh0fl74n7CXM1TzH8bqOZc25h92JFjisC7Gcel+0j2A
	 zU1+0C2NvTDryR7yu1HXF/cbyf7Em6FwtN95gzi4QgvGtquhvsSMFadA+g1bgQB3+f
	 8wrqPc4hdSmyuHfOey1noWZTc6v8WB6cpXFsWtiE2zaD4UoHr/5i6KCgG1YwOdICtT
	 VAvhY7B70Yl5Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] blk-mq-dma: migrate to dma_map_phys instead of map_page
Date: Fri, 17 Oct 2025 08:31:58 +0300
Message-ID: <20251017-block-with-mmio-v1-1-3f486904db5e@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com>
References: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev
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

From: Leon Romanovsky <leonro@nvidia.com>

After introduction of dma_map_phys(), there is no need to convert
from physical address to struct page in order to map page. So let's
use it directly.

Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 block/blk-mq-dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index 449950029872..4ba7b0323da4 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -93,8 +93,8 @@ static bool blk_dma_map_bus(struct blk_dma_iter *iter, struct phys_vec *vec)
 static bool blk_dma_map_direct(struct request *req, struct device *dma_dev,
 		struct blk_dma_iter *iter, struct phys_vec *vec)
 {
-	iter->addr = dma_map_page(dma_dev, phys_to_page(vec->paddr),
-			offset_in_page(vec->paddr), vec->len, rq_dma_dir(req));
+	iter->addr = dma_map_phys(dma_dev, vec->paddr, vec->len,
+			rq_dma_dir(req), 0);
 	if (dma_mapping_error(dma_dev, iter->addr)) {
 		iter->status = BLK_STS_RESOURCE;
 		return false;

-- 
2.51.0


