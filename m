From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 27 Nov 2018 15:16:08 -0800
Subject: [PATCH v4 06/13] datagram: introduce skb_copy_and_hash_datagram_iter
 helper
In-Reply-To: <20181127231615.9446-1-sagi@grimberg.me>
References: <20181127231615.9446-1-sagi@grimberg.me>
Message-ID: <20181127231615.9446-7-sagi@grimberg.me>

From: Sagi Grimberg <sagi@lightbitslabs.com>

Introduce a helper to copy datagram into an iovec iterator
but also update a predefined hash. This is useful for
consumers of skb_copy_datagram_iter to also support inflight
data digest without having to finish to copy and only then
traverse the iovec and calculate the digest hash.

Signed-off-by: Sagi Grimberg <sagi at lightbitslabs.com>
---
 include/linux/skbuff.h |  3 +++
 net/core/datagram.c    | 20 +++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0ba687454267..b0b8d5653f0d 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3309,6 +3309,9 @@ static inline int skb_copy_datagram_msg(const struct sk_buff *from, int offset,
 }
 int skb_copy_and_csum_datagram_msg(struct sk_buff *skb, int hlen,
 				   struct msghdr *msg);
+int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
+			   struct iov_iter *to, int len,
+			   struct ahash_request *hash);
 int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
 				 struct iov_iter *from, int len);
 int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *frm);
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 382543302ae5..ef262282c8be 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -465,7 +465,7 @@ int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 			if (copy > len)
 				copy = len;
 			if (__skb_datagram_iter(frag_iter, offset - start,
-						to, copy, short_copy, cb, data))
+						to, copy, fault_short, cb, data))
 				goto fault;
 			if ((len -= copy) == 0)
 				return 0;
@@ -492,6 +492,24 @@ int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 	return 0;
 }
 
+/**
+ *	skb_copy_and_hash_datagram_iter - Copy datagram to an iovec iterator
+ *          and update a hash.
+ *	@skb: buffer to copy
+ *	@offset: offset in the buffer to start copying from
+ *	@to: iovec iterator to copy to
+ *	@len: amount of data to copy from buffer to iovec
+ *      @hash: hash request to update
+ */
+int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
+			   struct iov_iter *to, int len,
+			   struct ahash_request *hash)
+{
+	return __skb_datagram_iter(skb, offset, to, len, true,
+			hash_and_copy_to_iter, hash);
+}
+EXPORT_SYMBOL(skb_copy_and_hash_datagram_iter);
+
 static size_t simple_copy_to_iter(const void *addr, size_t bytes,
 		void *data __always_unused, struct iov_iter *i)
 {
-- 
2.17.1
