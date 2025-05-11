Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51669C3ABC9
	for <linux-nvme@archiver.kernel.org>; Sun, 11 May 2025 00:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2eOY0O36MvbUYAsTeZyhaJiDgOn91uflEmhBkzbCki0=; b=GmjYIdLWtjk1zz3RZDJ67RILAW
	sWt14QKMxIKcojVitpRCN1wwFhM0eRGUj8bTkZgLnc8txRn481/YBCarJbI1A2IfHavVhlERDhvDG
	FSV/O5LsXxSU0MwwFD2f3UTQStXURfa2TyvAv3rSa/l4yJY2C8LPCFj88mduJ5/7LOsiBT6J+GX7x
	3mG8WfDP7r08942U1XIFtvtGX8QkumAXYdlFwjM3SZHMw/Xu/z7HeKSKVAMwiRnTUW7ByLS2ue/qo
	Wc5LBBvjZY8uMr5dG9SmdzjtATVi8uFhKt8jmj2CSH1EFBnZvRBddTS2hOyY0UnzJx0DUtvKVcMmb
	eiBhbOmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDul8-00000006XbG-3flY;
	Sun, 11 May 2025 00:41:38 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDul2-00000006XXR-1FuM
	for linux-nvme@lists.infradead.org;
	Sun, 11 May 2025 00:41:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4A8F0A4C66C;
	Sun, 11 May 2025 00:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7173C4CEF2;
	Sun, 11 May 2025 00:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746924090;
	bh=Er5gc2hUENA4gCdJhtwjHn21KMcLdvxvQg5p2KS53YU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tscoOcsq7YtK4+n3cVHEr3de+HfaNOpYztWa9Umb5OukdiQO7MTKvPIKjnN3YiL8G
	 Truwd0tO3gJoUvEuYwi2LlghvslZ4Gcuykja8KiO6PmNBLguFwNrZRfagm/7Ug5eJY
	 0zfccwrKcbUVJf3A32FZHOFMJUiFs0EIuKOYRX0X1nDP79Y33AjhOkWVTWj9MQIH21
	 vkIpbidhbGefydXm8iPEJEUgnwAFMJKNAijRvfCxh8brkpqOLXyx2a7yYKx4Qyo+q5
	 eS+IEz1otWLeACSjUsfy6vKdtFAuq8ZjW38lfLWMpZcNOKLIIqlpFWQ9B465Lvte5V
	 xf/NuyBFuaUWA==
From: Eric Biggers <ebiggers@kernel.org>
To: netdev@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	linux-sctp@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH net-next 02/10] net: add skb_crc32c()
Date: Sat, 10 May 2025 17:41:02 -0700
Message-ID: <20250511004110.145171-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250511004110.145171-1-ebiggers@kernel.org>
References: <20250511004110.145171-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250510_174132_477528_BDF1DD8D 
X-CRM114-Status: GOOD (  18.87  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Eric Biggers <ebiggers@google.com>

Add skb_crc32c(), which calculates the CRC32C of a sk_buff.  It will
replace __skb_checksum(), which unnecessarily supports arbitrary
checksums.  Compared to __skb_checksum(), skb_crc32c():

   - Uses the correct type for CRC32C values (u32, not __wsum).

   - Does not require the caller to provide a skb_checksum_ops struct.

   - Is faster because it does not use indirect calls and does not use
     the very slow crc32c_combine().

According to commit 2817a336d4d5 ("net: skb_checksum: allow custom
update/combine for walking skb") which added __skb_checksum(), the
original motivation for the abstraction layer was to avoid code
duplication for CRC32C and other checksums in the future.  However:

   - No additional checksums showed up after CRC32C.  __skb_checksum()
     is only used with the "regular" net checksum and CRC32C.

   - Indirect calls are expensive.  Commit 2544af0344ba ("net: avoid
     indirect calls in L4 checksum calculation") worked around this
     using the INDIRECT_CALL_1 macro. But that only avoided the indirect
     call for the net checksum, and at the cost of an extra branch.

   - The checksums use different types (__wsum and u32), causing casts
     to be needed.

   - It made the checksums of fragments be combined (rather than
     chained) for both checksums, despite this being highly
     counterproductive for CRC32C due to how slow crc32c_combine() is.
     This can clearly be seen in commit 4c2f24549644 ("sctp: linearize
     early if it's not GSO") which tried to work around this performance
     bug.  With a dedicated function for each checksum, we can instead
     just use the proper strategy for each checksum.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/skbuff.h |  1 +
 net/core/skbuff.c      | 73 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 74 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index f3e72be6f634..33b33bb18aa6 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4192,10 +4192,11 @@ extern const struct skb_checksum_ops *crc32c_csum_stub __read_mostly;
 
 __wsum __skb_checksum(const struct sk_buff *skb, int offset, int len,
 		      __wsum csum, const struct skb_checksum_ops *ops);
 __wsum skb_checksum(const struct sk_buff *skb, int offset, int len,
 		    __wsum csum);
+u32 skb_crc32c(const struct sk_buff *skb, int offset, int len, u32 crc);
 
 static inline void * __must_check
 __skb_header_pointer(const struct sk_buff *skb, int offset, int len,
 		     const void *data, int hlen, void *buffer)
 {
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d73ad79fe739..b9900cc16a24 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -62,10 +62,11 @@
 #include <linux/bitfield.h>
 #include <linux/if_vlan.h>
 #include <linux/mpls.h>
 #include <linux/kcov.h>
 #include <linux/iov_iter.h>
+#include <linux/crc32.h>
 
 #include <net/protocol.h>
 #include <net/dst.h>
 #include <net/sock.h>
 #include <net/checksum.h>
@@ -3626,10 +3627,82 @@ __wsum skb_copy_and_csum_bits(const struct sk_buff *skb, int offset,
 	BUG_ON(len);
 	return csum;
 }
 EXPORT_SYMBOL(skb_copy_and_csum_bits);
 
+#ifdef CONFIG_NET_CRC32C
+u32 skb_crc32c(const struct sk_buff *skb, int offset, int len, u32 crc)
+{
+	int start = skb_headlen(skb);
+	int i, copy = start - offset;
+	struct sk_buff *frag_iter;
+
+	if (copy > 0) {
+		copy = min(copy, len);
+		crc = crc32c(crc, skb->data + offset, copy);
+		len -= copy;
+		if (len == 0)
+			return crc;
+		offset += copy;
+	}
+
+	if (WARN_ON_ONCE(!skb_frags_readable(skb)))
+		return 0;
+
+	for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
+		int end;
+		skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
+
+		WARN_ON(start > offset + len);
+
+		end = start + skb_frag_size(frag);
+		copy = end - offset;
+		if (copy > 0) {
+			u32 p_off, p_len, copied;
+			struct page *p;
+			u8 *vaddr;
+
+			copy = min(copy, len);
+			skb_frag_foreach_page(frag,
+					      skb_frag_off(frag) + offset - start,
+					      copy, p, p_off, p_len, copied) {
+				vaddr = kmap_atomic(p);
+				crc = crc32c(crc, vaddr + p_off, p_len);
+				kunmap_atomic(vaddr);
+			}
+			len -= copy;
+			if (len == 0)
+				return crc;
+			offset += copy;
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
+		copy = end - offset;
+		if (copy > 0) {
+			copy = min(copy, len);
+			crc = skb_crc32c(frag_iter, offset - start, copy, crc);
+			len -= copy;
+			if (len == 0)
+				return crc;
+			offset += copy;
+		}
+		start = end;
+	}
+	BUG_ON(len);
+
+	return crc;
+}
+EXPORT_SYMBOL(skb_crc32c);
+#endif /* CONFIG_NET_CRC32C */
+
 __sum16 __skb_checksum_complete_head(struct sk_buff *skb, int len)
 {
 	__sum16 sum;
 
 	sum = csum_fold(skb_checksum(skb, 0, len, skb->csum));
-- 
2.49.0


