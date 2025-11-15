Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CCFCEB2DF
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Nov 2025 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H3RWva32Z4Qu1ErGZjvTPrX0JY+tc/26I8OMGLwZf0U=; b=SexZ6e0lUyMbhYIuTM5AbnvQcy
	asuSFYtxoB6hatny5FyG4kLl3/caegjXDfLVjenIow+f9P7M8CLxCZJQNbAI0zNmQdoTpFA55gAgH
	Y5Gk18F5w0PIMn/1RgzeKYFzHDYOumjK8wLUmuUHemaFC82dZJ9etRSrD45JwqNXxow8IWE03Yc9K
	9HHs4rhyJGnQSrxMIVw10o9qA1I3DJaj2jFGYZ3l/SUJbn8kNo+LS+C9/xhOV/hW59g0d0QMbB+Dy
	OrbQRegx243WGkonddysdAiyaf7Zt/PXfUPsCLaxsdvsIXMLKjGhUrrhXoT2yZLzest8nIjCSHS+u
	EMJkg8DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKJ3L-0000000Duki-0MQI;
	Sat, 15 Nov 2025 16:23:07 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKJ3I-0000000Duje-1pqu
	for linux-nvme@lists.infradead.org;
	Sat, 15 Nov 2025 16:23:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1CA1C443CE;
	Sat, 15 Nov 2025 16:23:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AFCC2BC87;
	Sat, 15 Nov 2025 16:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763223784;
	bh=HDXPNdXppJb1pAbOT94cDsK4rTiYS3j0SclK6olru+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K+Idzc3xOAQ4zjNNlGS128lm1BpGU5tU4lceLk1ExeffmXaAFkIoms2ig9/D5Iak/
	 MxK6bJ4tbCsH5rKN0NFUyxHqqVyKxYeNW5Jkqb/0k5NmG9WTlFKPqrwyPB5ksQrvYC
	 5fjWxRCzvVWPVCAZgHSPvzBGAqKLXK1ZvtBKnth20w8tb1oAbOkvuU+dHkE5n2hkDE
	 aoCGwzBGlG1VrQ7G/U6ixotTmPBx7S0WdalleEa9pe1IJOo6IJCmLyMbsBaStFhNB3
	 KbMPIgY75yCWq6OV0sP8UBKT7LlF17KA8p5jjGQixSFcBOLVyWAELChD9IPxEXEmpf
	 0Ma2rrb/+T/8Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] types: move phys_vec definition to common header
Date: Sat, 15 Nov 2025 18:22:46 +0200
Message-ID: <20251115-nvme-phys-types-v1-2-c0f2e5e9163d@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org>
References: <20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-a6db3
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251115_082304_497561_8D55EF29 
X-CRM114-Status: GOOD (  12.39  )
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
---
 block/blk-mq-dma.c    | 5 -----
 include/linux/types.h | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index cc3e2548cc30..ba7e77bbe7fa 100644
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


