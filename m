From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 21 Nov 2018 17:56:03 -0800
Subject: [PATCH v3 05/13] iov_iter: introduce hash_and_copy_to_iter helper
In-Reply-To: <20181122015615.15763-1-sagi@grimberg.me>
References: <20181122015615.15763-1-sagi@grimberg.me>
Message-ID: <20181122015615.15763-6-sagi@grimberg.me>

From: Sagi Grimberg <sagi@lightbitslabs.com>

Allow consumers that want to use iov iterator helpers and also update
a predefined hash calculation online when copying data. This is useful
when copying incoming network buffers to a local iterator and calculate
a digest on the incoming stream. nvme-tcp host driver that will be
introduced in following patches is the first consumer via
skb_copy_and_hash_datagram_iter.

Signed-off-by: Sagi Grimberg <sagi at lightbitslabs.com>
---
 include/linux/uio.h |  3 +++
 lib/iov_iter.c      | 16 ++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 41d1f8d3313d..ecf584f6b82d 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -11,6 +11,7 @@
 
 #include <linux/kernel.h>
 #include <linux/thread_info.h>
+#include <crypto/hash.h>
 #include <uapi/linux/uio.h>
 
 struct page;
@@ -269,6 +270,8 @@ static inline void iov_iter_reexpand(struct iov_iter *i, size_t count)
 size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump, struct iov_iter *i);
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
 bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
+size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
+		struct iov_iter *i);
 
 int import_iovec(int type, const struct iovec __user * uvector,
 		 unsigned nr_segs, unsigned fast_segs,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index db93531ca3e3..8a5f7b2ae346 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -6,6 +6,7 @@
 #include <linux/vmalloc.h>
 #include <linux/splice.h>
 #include <net/checksum.h>
+#include <linux/scatterlist.h>
 
 #define PIPE_PARANOIA /* for now */
 
@@ -1475,6 +1476,21 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump,
 }
 EXPORT_SYMBOL(csum_and_copy_to_iter);
 
+size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
+		struct iov_iter *i)
+{
+	struct ahash_request *hash = hashp;
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
