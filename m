From: sagi@lightbitslabs.com (Sagi Grimberg)
Date: Thu, 15 Nov 2018 09:16:15 -0800
Subject: [PATCH 03/11] datagram: introduce skb_copy_and_hash_datagram_iter
 helper
In-Reply-To: <20181115171626.9306-1-sagi@lightbitslabs.com>
References: <20181115171626.9306-1-sagi@lightbitslabs.com>
Message-ID: <20181115171626.9306-4-sagi@lightbitslabs.com>

Introduce a helper to copy datagram into an iovec iterator
but also update a predefined hash. This is useful for
consumers of skb_copy_datagram_iter to also support inflight
data digest without having to finish to copy and only then
traverse the iovec and calculate the digest hash.

Signed-off-by: Sagi Grimberg <sagi at lightbitslabs.com>
---
 include/linux/skbuff.h |  3 ++
 net/core/datagram.c    | 90 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0ba687454267..4d89bb14c2fc 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3311,6 +3311,9 @@ int skb_copy_and_csum_datagram_msg(struct sk_buff *skb, int hlen,
 				   struct msghdr *msg);
 int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
 				 struct iov_iter *from, int len);
+int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
+			   struct iov_iter *to, int len,
+			   struct ahash_request *hash);
 int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *frm);
 void skb_free_datagram(struct sock *sk, struct sk_buff *skb);
 void __skb_free_datagram_locked(struct sock *sk, struct sk_buff *skb, int len);
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 57f3a6fcfc1e..9c81741c1bae 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -497,6 +497,96 @@ int skb_copy_datagram_iter(const struct sk_buff *skb, int offset,
 }
 EXPORT_SYMBOL(skb_copy_datagram_iter);
 
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
+	int start = skb_headlen(skb);
+	int i, copy = start - offset, start_off = offset, n;
+	struct sk_buff *frag_iter;
+
+	/* Copy header. */
+	if (copy > 0) {
+		if (copy > len)
+			copy = len;
+		n = hash_and_copy_to_iter(skb->data + offset, copy, to, hash);
+		offset += n;
+		if (n != copy)
+			goto short_copy;
+		if ((len -= copy) == 0)
+			return 0;
+	}
+
+	/* Copy paged appendix. Hmm... why does this look so complicated? */
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		int end;
+		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+
+		WARN_ON(start > offset + len);
+
+		end = start + skb_frag_size(frag);
+		if ((copy = end - offset) > 0) {
+			if (copy > len)
+				copy = len;
+			n = hash_and_copy_page_to_iter(skb_frag_page(frag),
+					      frag->page_offset + offset -
+					      start, copy, to, hash);
+			offset += n;
+			if (n != copy)
+				goto short_copy;
+			if (!(len -= copy))
+				return 0;
+		}
+		start = end;
+	}
+
+	skb_walk_frags(skb, frag_iter) {
+		int end;
+
+		WARN_ON(start > offset + len);
+
+		end = start + frag_iter->len;
+		if ((copy = end - offset) > 0) {
+			if (copy > len)
+				copy = len;
+			if (skb_copy_and_hash_datagram_iter(frag_iter,
+					offset - start, to, copy, hash))
+				goto fault;
+			if ((len -= copy) == 0)
+				return 0;
+			offset += copy;
+		}
+		start = end;
+	}
+	if (!len)
+		return 0;
+
+	/* This is not really a user copy fault, but rather someone
+	 * gave us a bogus length on the skb.  We should probably
+	 * print a warning here as it may indicate a kernel bug.
+	 */
+
+fault:
+	iov_iter_revert(to, offset - start_off);
+	return -EFAULT;
+
+short_copy:
+	if (iov_iter_count(to))
+		goto fault;
+
+	return 0;
+}
+EXPORT_SYMBOL(skb_copy_and_hash_datagram_iter);
+
 /**
  *	skb_copy_datagram_from_iter - Copy a datagram from an iov_iter.
  *	@skb: buffer to copy
-- 
2.17.1
