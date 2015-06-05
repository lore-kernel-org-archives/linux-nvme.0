From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Fri,  5 Jun 2015 14:54:26 +0200
Subject: [PATCH v4 4/8] bio: Introduce LightNVM payload
In-Reply-To: <1433508870-28251-1-git-send-email-m@bjorling.me>
References: <1433508870-28251-1-git-send-email-m@bjorling.me>
Message-ID: <1433508870-28251-5-git-send-email-m@bjorling.me>

LightNVM integrates on both sides of the block layer. The lower layer
implements mapping of logical to physical addressing, while the layer
above can string together multiple LightNVM devices and expose them as a
single block device.

Having multiple devices underneath requires a way to resolve where the
IO came from when submitted through the block layer. Extending bio with
a LightNVM payload solves this problem.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 include/linux/bio.h       | 9 +++++++++
 include/linux/blk_types.h | 4 +++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index f0291cf..1fe490e 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -368,6 +368,15 @@ static inline void bip_set_seed(struct bio_integrity_payload *bip,
 
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
+#if defined(CONFIG_NVM)
+
+/* bio open-channel ssd payload */
+struct bio_nvm_payload {
+	void *private;
+};
+
+#endif /* CONFIG_NVM */
+
 extern void bio_trim(struct bio *bio, int offset, int size);
 extern struct bio *bio_split(struct bio *bio, int sectors,
 			     gfp_t gfp, struct bio_set *bs);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 45a6be8..41d9ba1 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -83,7 +83,9 @@ struct bio {
 		struct bio_integrity_payload *bi_integrity; /* data integrity */
 #endif
 	};
-
+#if defined(CONFIG_NVM)
+	struct bio_nvm_payload *bi_nvm; /* open-channel ssd backend */
+#endif
 	unsigned short		bi_vcnt;	/* how many bio_vec's */
 
 	/*
-- 
2.1.4
