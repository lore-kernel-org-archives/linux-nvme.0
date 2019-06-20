From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 20 Jun 2019 10:12:16 -0600
Subject: [RFC PATCH 04/28] block: Never bounce dma-direct bios
In-Reply-To: <20190620161240.22738-1-logang@deltatee.com>
References: <20190620161240.22738-1-logang@deltatee.com>
Message-ID: <20190620161240.22738-5-logang@deltatee.com>

It is expected the creator of the dma-direct bio will ensure the
target device can access the DMA address it's creating bios for.
It's also not possible to bounce a dma-direct bio seeing the block
layer doesn't have any way to access the underlying data behind
the DMA address.

Thus, never bounce dma-direct bios.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 block/bounce.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/block/bounce.c b/block/bounce.c
index f8ed677a1bf7..17e020a40cca 100644
--- a/block/bounce.c
+++ b/block/bounce.c
@@ -367,6 +367,14 @@ void blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
 	if (!bio_has_data(*bio_orig))
 		return;
 
+	/*
+	 * For DMA direct bios, Upper layers are expected to ensure
+	 * the device in question can access the DMA addresses. So
+	 * it never makes sense to bounce a DMA direct bio.
+	 */
+	if (bio_is_dma_direct(*bio_orig))
+		return;
+
 	/*
 	 * for non-isa bounce case, just check if the bounce pfn is equal
 	 * to or bigger than the highest pfn in the system -- in that case,
-- 
2.20.1
