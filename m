From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 20 Jun 2019 10:12:17 -0600
Subject: [RFC PATCH 05/28] block: Skip dma-direct bios in bio_integrity_prep()
In-Reply-To: <20190620161240.22738-1-logang@deltatee.com>
References: <20190620161240.22738-1-logang@deltatee.com>
Message-ID: <20190620161240.22738-6-logang@deltatee.com>

The block layer will not be able to handle integrity for dma-direct
bios seeing it does not have access to the underlying data.

If users of dma-direct require integrity, they will have to handle it
in the layer creating the bios. This is left as future work should
somebody care about handling such a case.

Thus, bio_integrity_prep() should ignore dma-direct bios.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 block/bio-integrity.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 4db620849515..10fdf456fcd8 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -221,6 +221,10 @@ bool bio_integrity_prep(struct bio *bio)
 	if (bio_integrity(bio))
 		return true;
 
+	/* The block layer cannot handle integrity for dma-direct bios */
+	if (bio_is_dma_direct(bio))
+		return true;
+
 	if (bio_data_dir(bio) == READ) {
 		if (!bi->profile->verify_fn ||
 		    !(bi->flags & BLK_INTEGRITY_VERIFY))
-- 
2.20.1
