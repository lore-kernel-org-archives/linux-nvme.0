From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 21 Nov 2018 17:56:01 -0800
Subject: [PATCH v3 03/13] iov_iter: pass void csum pointer to
 csum_and_copy_to_iter
In-Reply-To: <20181122015615.15763-1-sagi@grimberg.me>
References: <20181122015615.15763-1-sagi@grimberg.me>
Message-ID: <20181122015615.15763-4-sagi@grimberg.me>

From: Sagi Grimberg <sagi@lightbitslabs.com>

The single caller to csum_and_copy_to_iter is skb_copy_and_csum_datagram
and we are trying to unite its logic with skb_copy_datagram_iter by passing
a callback to the copy function that we want to apply. Thus, we need
to make the checksum pointer private to the function.

Signed-off-by: Sagi Grimberg <sagi at lightbitslabs.com>
---
 include/linux/uio.h | 2 +-
 lib/iov_iter.c      | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 55ce99ddb912..41d1f8d3313d 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -266,7 +266,7 @@ static inline void iov_iter_reexpand(struct iov_iter *i, size_t count)
 {
 	i->count = count;
 }
-size_t csum_and_copy_to_iter(const void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
+size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump, struct iov_iter *i);
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
 bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
 
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 7ebccb5c1637..db93531ca3e3 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1432,10 +1432,11 @@ bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum,
 }
 EXPORT_SYMBOL(csum_and_copy_from_iter_full);
 
-size_t csum_and_copy_to_iter(const void *addr, size_t bytes, __wsum *csum,
+size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump,
 			     struct iov_iter *i)
 {
 	const char *from = addr;
+	__wsum *csum = csump;
 	__wsum sum, next;
 	size_t off = 0;
 	sum = *csum;
-- 
2.17.1
