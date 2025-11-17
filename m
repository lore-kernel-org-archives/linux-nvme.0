Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9265CEACEF
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Nov 2025 19:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uZ/zy5A0fKVNIITkirKAWa1Tz2J/reSYQtu8MERMGmY=; b=hMFqfCqT+FMOea3QpbwFIsOAs+
	CbmsjUvE6ZrUYFXNGUrDqVkTIYGHabMInin4lg9LKGk0b9K/zT8CZVAKQDdLTbrPuywe8ZuV223J9
	9uCYhbASkOkXA5uhLY37asC2PTWUdfw/IcHdrXVdEU7MU9LZZsv63kv4vCz4OVvu5t4ghv8jnU1cR
	r9mtaAiHA6+wO/takbslnpOtAVhT1WbiKPOkhIlxpfyUmN02zC8ebTXNZCWt7ratUjNYG3lty6C1Z
	jJd/FWV+3f7yc4NT7XRjqxxklYMYJIF7dM3Cta+gEl460PleoLjTUxkTdhStI2gE3l35TKXPBtNVQ
	106ibMng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL4oY-0000000GkAT-1d6f;
	Mon, 17 Nov 2025 19:23:02 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL4oW-0000000GkA2-2KLt
	for linux-nvme@lists.infradead.org;
	Mon, 17 Nov 2025 19:23:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8F55360250;
	Mon, 17 Nov 2025 19:22:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF9EC2BCB0;
	Mon, 17 Nov 2025 19:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763407379;
	bh=EEyesgsiG54ob2krMXcOxgW1MQE8gG2p/1YYRAn3wos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHaJYLMJuXsq90w4WM5RT+iGeIz56hG81clfHld9xfs6uIP9Gfo/ua133vNPaoc81
	 7o5t5aMJK9AFuI4urLjefRYGSXgZWJ/Aj5MjDF69M33fGLWX3jhJTcqhcQztlwtQfa
	 eSNSx/KFZRYZDOjUO3sDPHT+EMvzuk8HUsnRro5eZqTHeAQkxTPReCCU9JUBeCbXEn
	 4XX7u2knu/jo8KTUkDRN5mZujmUTauLVbb+e94OiOca51bbYqOb12nqWShSK2I6GnV
	 z0DgTcaL+kpNwZtbkHkZly8KLDcPaFrN6Duu0y3N0MlN+L2lVZsLWl4GWDIuqxRFId
	 LvNlhCdx6w8XQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v2 2/2] types: move phys_vec definition to common header
Date: Mon, 17 Nov 2025 21:22:44 +0200
Message-ID: <20251117-nvme-phys-types-v2-2-c75a60a2c468@nvidia.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
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
index e7d9b54c3eed..be2ccf224f9c 100644
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
index 6dfdb8e8e4c3..6cc2d7cba9b3 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -170,6 +170,11 @@ typedef u64 phys_addr_t;
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


