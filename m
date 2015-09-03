From: sagig@mellanox.com (Sagi Grimberg)
Date: Thu,  3 Sep 2015 19:28:22 +0300
Subject: [PATCH 3/4] block: Refuse adding appending a gaped integrity page to
 a bio
In-Reply-To: <1441297703-10753-1-git-send-email-sagig@mellanox.com>
References: <1441297703-10753-1-git-send-email-sagig@mellanox.com>
Message-ID: <1441297703-10753-4-git-send-email-sagig@mellanox.com>

This is only theoretical at the moment given that the only
subsystems that generate integrity payloads are the block layer
itself and the scsi target (which generate well aligned integrity
payloads). But when we will expose integrity meta-data to user-space,
we'll need to refuse appending a page with a gap (if the queue
virtual boundary is set).

Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
---
 block/bio-integrity.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 719b7152aed1..4e5a43465ddb 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -140,6 +140,11 @@ int bio_integrity_add_page(struct bio *bio, struct page *page,
 
 	iv = bip->bip_vec + bip->bip_vcnt;
 
+	if (bip->bip_vcnt &&
+	    bvec_gap_to_prev(bdev_get_queue(bio->bi_bdev),
+			     &bip->bip_vec[bip->bip_vcnt - 1], offset))
+		return 0;
+
 	iv->bv_page = page;
 	iv->bv_len = len;
 	iv->bv_offset = offset;
-- 
1.8.4.3
