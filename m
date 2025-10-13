Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5436CCD18E
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Oct 2025 15:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sN+F2A4RFAtgsDM7TNFE/XjJjsrWUVoxajNpA+40HW0=; b=VkAPe5jHnCzHtF18+lPKbIiP9J
	0LXI4u/rK8bu2yKxh+lBOnf1Fo6N4inx7vtEq029gRXUZ5zY0SmAfnk3whdq04VgN1E63TUuvhyfJ
	qS7k6t97a/Hw8089pWBbJfIUkGUHqZNTcT+pveWNsyy/n7JijpKEZBwOV30kDeKNbQw5FgopQBPRH
	L9BnMfNel75xOtgjitQAZ0IQ4y8urY67xIT8Fe2NIzfmdbiFQHQ12q18CW6mlrtCH3N6LST4jNJil
	DTrwg/fX+a++g/DF4FozVFuV7EI/UAmjM8zKXd2vLJlJ4o+a2xZEO1wvWYZ8kHupBMKgsXd0tQFRE
	RGkH8LbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8KZ9-0000000DhWE-1Q4A;
	Mon, 13 Oct 2025 15:34:27 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8KZ7-0000000DhUv-0G8c
	for linux-nvme@lists.infradead.org;
	Mon, 13 Oct 2025 15:34:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C32BC4013F;
	Mon, 13 Oct 2025 15:34:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10EFEC4CEE7;
	Mon, 13 Oct 2025 15:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760369664;
	bh=hzuVFe8nCL+iIBGDL2sXtfGJ2m3xwMmUvUxsg09OtX4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ibwLtD0LulBqDzZDpXozjmI/P7HtfW8A0lH49aPinhSgG3HSCoEEoZXb2hbxV2WLc
	 FH1cVDnlg+phv3I8c7Ghc+cHQ9PmdD8gkheuTWpQA1IH21QA+gEIC4fcm+fd8MgN8t
	 0GL9zSmux/bfE2MuX0+pDpD2Kx3kE07VwzSzAaSRTf2PcirYz/IJA4hsKcq4kvEPIs
	 otRWBmUPabNrJCqWSlCnpty6Y25PN1bxifAG1pIRWu3vwI9Dk7P+Y6oV4GLGjo2K8b
	 EdfvMk73E4gdf6ZKbWTinKiZD57GDIyc0LsMDrgyeqzzVTYJcTYKlhdB+Etd8RnOUB
	 7RmbzimrVtqAw==
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
Subject: [PATCH 1/4] blk-mq-dma: migrate to dma_map_phys instead of map_page
Date: Mon, 13 Oct 2025 18:34:09 +0300
Message-ID: <a40705f38a9f3c757f30228b9b848ce0a87cbcdd.1760369219.git.leon@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1760369219.git.leon@kernel.org>
References: <cover.1760369219.git.leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251013_083425_118577_1E65EA6A 
X-CRM114-Status: GOOD (  11.25  )
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


