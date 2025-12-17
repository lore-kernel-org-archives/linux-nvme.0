Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C3DAD65521
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Dec 2025 09:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o/NqHXd25769s49ffyuION3DtDE8J32buv+dLzLWLxE=; b=Wad9yyo0ZhJEDFVUZbSwjOLbaq
	2f1fha+dA12jB131aLyLFETnyPazu1UfBG9MCfl5qTERmsyFCbdCRnuquS0NbxnYRAVnBqcGkpLPO
	pUHXupwXU7YCYZNZDYvKKtCeO/C4QS2ExZPIzVxujeHGzSDfHNCruDRpeZ09nGYL26CoSMreLXJJ3
	Rwt0mcEFq/xlaCu2/38wsXASksnSvD5JDdZxEQJvR3xZSwfVyNXTJ8vkZfSFI18ahibd6fxo+DV3n
	xDdoF60dFR8dJmFv1QX4CqSvGIa7++VPnXM1vQ+eKjxxNSDZJc5Ya949bxZpz2dqWdVVAkmcaCV6+
	jNNEm4bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVo2U-00000006SOB-3g3e;
	Wed, 17 Dec 2025 09:41:46 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVo2T-00000006SNS-2Mbt
	for linux-nvme@lists.infradead.org;
	Wed, 17 Dec 2025 09:41:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AB4466055B;
	Wed, 17 Dec 2025 09:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01BDC4CEF5;
	Wed, 17 Dec 2025 09:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765964504;
	bh=b/Jh6xjZVFYW/BZ/jwrPDpIcfQ2LNGIe6zTiBVWKzZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MtazOCT9Qnl2xJPI5agV4eVL6iRrG+kqSMaMtyvq0gYmgG8Zo/TfBGJUoi0vCi43Y
	 9YkvLyujwckc0uJxn5MVbUj/+8rUCRT5NTe+Swi1rRg1ZfdAeyi7RJ4oC/ehSKX6RK
	 dfXfUq9PfTxwb3AINQ0RYfaiY6+G2lxaI23k+Y4uO42sz5PfTPaTwF9adTr9keCdXb
	 p6nYRkc6apnSdWBNG9M+J9HmCNPaxpoFeRUlsseOd/jeTWBztvOdA5kJi2z1ZQkgr7
	 3RxypPG28DnhVwjQLHjaeaJh2qgXWtj2xHjJfIYHDtrs/hR3YIGjYSSjMpvClRcjfo
	 PPFgP1FS35Nwg==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v3 2/2] types: move phys_vec definition to common header
Date: Wed, 17 Dec 2025 11:41:24 +0200
Message-ID: <20251217-nvme-phys-types-v3-2-f27fd1608f48@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a6db3
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

Move the struct phys_vec definition from block/blk-mq-dma.c to
include/linux/types.h to make it available for use across the kernel.

The phys_vec structure represents a physical address range with a
length, which is used by the new physical address-based DMA mapping
API. This structure is already used by the block layer and will be
needed for DMA phys API users.

Moving this definition to types.h provides a centralized location
for this common data structure and eliminates code duplication
across subsystems that need to work with physical address ranges.

Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-mq-dma.c    | 5 -----
 include/linux/types.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index a2bedc8f8666..752060d7261c 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -6,11 +6,6 @@
 #include <linux/blk-mq-dma.h>
 #include "blk.h"
 
-struct phys_vec {
-	phys_addr_t	paddr;
-	size_t		len;
-};
-
 static bool __blk_map_iter_next(struct blk_map_iter *iter)
 {
 	if (iter->iter.bi_size)
diff --git a/include/linux/types.h b/include/linux/types.h
index d4437e9c452c..d673747eda8a 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -171,6 +171,11 @@ typedef u64 phys_addr_t;
 typedef u32 phys_addr_t;
 #endif
 
+struct phys_vec {
+	phys_addr_t	paddr;
+	size_t		len;
+};
+
 typedef phys_addr_t resource_size_t;
 
 /*

-- 
2.51.1


