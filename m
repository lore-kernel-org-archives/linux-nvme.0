From: sagi@lightbitslabs.com (Sagi Grimberg)
Date: Thu, 15 Nov 2018 09:16:14 -0800
Subject: [PATCH 02/11] iov_iter: introduce hash_and_copy iter helpers
In-Reply-To: <20181115171626.9306-1-sagi@lightbitslabs.com>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
Message-ID: <20181115171626.9306-3-sagi@lightbitslabs.com>

Allow consumers that want to use iov iterator helpers and also update
a predefined hash calculation online when copying data. This is useful
when copying incoming network buffers to a local iterator and calculate
a digest on the incoming stream. nvme-tcp host driver that will be
introduced in following patches is the first consumer via
skb_copy_and_hash_datagram_iter.

Signed-off-by: Sagi Grimberg <sagi at lightbitslabs.com>
---
 include/linux/uio.h |  5 +++++
 lib/iov_iter.c      | 31 +++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 55ce99ddb912..c299ea1037a7 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -11,6 +11,7 @@
 
 #include <linux/kernel.h>
 #include <linux/thread_info.h>
+#include <crypto/hash.h>
 #include <uapi/linux/uio.h>
 
 struct page;
@@ -127,6 +128,8 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
+size_t hash_and_copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
+			 struct iov_iter *i, struct ahash_request *hash);
 
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
@@ -269,6 +272,8 @@ static inline void iov_iter_reexpand(struct iov_iter *i, size_t count)
 size_t csum_and_copy_to_iter(const void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
 bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
+size_t hash_and_copy_to_iter(const void *addr, size_t bytes,
+		struct iov_iter *i, struct ahash_request *hash);
 
 int import_iovec(int type, const struct iovec __user * uvector,
 		 unsigned nr_segs, unsigned fast_segs,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 7ebccb5c1637..f15cc4f93ecc 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -6,6 +6,7 @@
 #include <linux/vmalloc.h>
 #include <linux/splice.h>
 #include <net/checksum.h>
+#include <linux/scatterlist.h>
 
 #define PIPE_PARANOIA /* for now */
 
@@ -850,6 +851,22 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 }
 EXPORT_SYMBOL(copy_page_to_iter);
 
+size_t hash_and_copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
+			 struct iov_iter *i, struct ahash_request *hash)
+{
+	struct scatterlist sg;
+	size_t copied;
+
+	copied = copy_page_to_iter(page, offset, bytes, i);
+	sg_init_marker(&sg, 1);
+	sg_set_page(&sg, page, bytes, offset);
+	ahash_request_set_crypt(hash, &sg, NULL, copied);
+	crypto_ahash_update(hash);
+
+	return copied;
+}
+EXPORT_SYMBOL(hash_and_copy_page_to_iter);
+
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i)
 {
@@ -1474,6 +1491,20 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, __wsum *csum,
 }
 EXPORT_SYMBOL(csum_and_copy_to_iter);
 
+size_t hash_and_copy_to_iter(const void *addr, size_t bytes,
+		struct iov_iter *i, struct ahash_request *hash)
+{
+	struct scatterlist sg;
+	size_t copied;
+
+	copied = copy_to_iter(addr, bytes, i);
+	sg_init_one(&sg, addr, copied);
+	ahash_request_set_crypt(hash, &sg, NULL, copied);
+	crypto_ahash_update(hash);
+	return copied;
+}
+EXPORT_SYMBOL(hash_and_copy_to_iter);
+
 int iov_iter_npages(const struct iov_iter *i, int maxpages)
 {
 	size_t size = i->count;
-- 
2.17.1
