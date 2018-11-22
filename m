From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 21 Nov 2018 17:56:00 -0800
Subject: [PATCH v3 02/13] datagram: open-code copy_page_to_iter
In-Reply-To: <20181122015615.15763-1-sagi@grimberg.me>
References: <20181122015615.15763-1-sagi@grimberg.me>
Message-ID: <20181122015615.15763-3-sagi@grimberg.me>

From: Sagi Grimberg <sagi@lightbitslabs.com>

This will be useful to consolidate skb_copy_and_hash_datagram_iter and
skb_copy_and_csum_datagram to a single code path.

Signed-off-by: Sagi Grimberg <sagi at lightbitslabs.com>
---
 net/core/datagram.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/core/datagram.c b/net/core/datagram.c
index 57f3a6fcfc1e..abe642181b64 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -445,11 +445,14 @@ int skb_copy_datagram_iter(const struct sk_buff *skb, int offset,
 
 		end = start + skb_frag_size(frag);
 		if ((copy = end - offset) > 0) {
+			struct page *page = skb_frag_page(frag);
+			u8 *vaddr = kmap(page);
+
 			if (copy > len)
 				copy = len;
-			n = copy_page_to_iter(skb_frag_page(frag),
-					      frag->page_offset + offset -
-					      start, copy, to);
+			n = copy_to_iter(vaddr + frag->page_offset +
+					 offset - start, copy, to);
+			kunmap(page);
 			offset += n;
 			if (n != copy)
 				goto short_copy;
-- 
2.17.1
