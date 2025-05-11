Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16846C3ABC9
	for <linux-nvme@archiver.kernel.org>; Sun, 11 May 2025 00:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p/AMrzifePx9sIWFcg1Zwi76xpA7tfjr7r5OkhMy3aE=; b=N8V//oaQOPjzGkIACL2o9AKrxY
	nMJmuIa9wKVm5PXMvzz3UcPl4gOhbOUSVZReu0zODXKuNstGMmHZADeRFH523+lfIfhL/2eIGKQN0
	b4kNM2rE2pC3m/ZV2dLYBC/nsnhcC05OfLkVUWHOPUcfYpxT/XYJ6VmZSPzbi21d29dPQjCO+E56R
	HdAZlKG0SpGLYkUDBqLUbTiTpM6VHiTwuIoMpZ/Fzkifddw8YiLYrBBKG0GQugz1TI6aKw12e0hjy
	a66WkDgjhvjHJE+fxt0e/lZqjW22p/h7hIjfN/Bgcm2FcIr4PEPigb0kULOqVDemj6CMTs659mMzH
	SDeyIULA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDulD-00000006Xfs-2P4t;
	Sun, 11 May 2025 00:41:43 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDul9-00000006Xb4-21OF
	for linux-nvme@lists.infradead.org;
	Sun, 11 May 2025 00:41:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3F4D361126;
	Sun, 11 May 2025 00:41:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 180BBC4CEEE;
	Sun, 11 May 2025 00:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746924097;
	bh=LyWew4r7C8/s4G5rA7UFXiI52nXjAIqNl5KwWhIs7mU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oV1P3UPxoSVSGXQHgQoCgxQxJfnGE9kH5epMt277/kKhANGjbgtMM1DFdm4rIsSS4
	 TnqojLLfFjobtF4Q71jGxB0fWr/mtuVa8bD54vddcKJX3zFoYSvOFokidXlrJSQxBd
	 N8KAuZAcGjDhA53zHmLcWxQ419JOB0h5aM46AgVj/JXtv85HaFzbPl952PqFtWtcCG
	 qOP47npu4FmQUYlvlZnrcatvjepKQFdB3TsehGMLv2FgrV+8Dd6g1AYGbFPaV+uZpX
	 CWOCT2fkIgnWxKg2w3yg/yEvNkNvuXOo2ZiY8ekqJVAOxhmnz63kyMtqLjRGHgnLAD
	 EfxeNQc950JnQ==
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
Subject: [PATCH net-next 08/10] net: add skb_copy_and_crc32c_datagram_iter()
Date: Sat, 10 May 2025 17:41:08 -0700
Message-ID: <20250511004110.145171-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250511004110.145171-1-ebiggers@kernel.org>
References: <20250511004110.145171-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Since skb_copy_and_hash_datagram_iter() is used only with CRC32C, the
crypto_ahash abstraction provides no value.  Add
skb_copy_and_crc32c_datagram_iter() which just calls crc32c() directly.

This is faster and simpler.  It also doesn't have the weird dependency
issue where skb_copy_and_hash_datagram_iter() depends on
CONFIG_CRYPTO_HASH=y without that being expressed explicitly in the
kconfig (presumably because it was too heavyweight for NET to select).
The new function is conditional on the hidden boolean symbol NET_CRC32C,
which selects CRC32.  So it gets compiled only when something that
actually needs CRC32C packet checksums is enabled, it has no implicit
dependency, and it doesn't depend on the heavyweight crypto layer.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/skbuff.h |  2 ++
 net/core/datagram.c    | 31 +++++++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index eac5c8dde4a5..0027f2977c02 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4126,10 +4126,12 @@ static inline int skb_copy_datagram_msg(const struct sk_buff *from, int offset,
 int skb_copy_and_csum_datagram_msg(struct sk_buff *skb, int hlen,
 				   struct msghdr *msg);
 int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
 			   struct iov_iter *to, int len,
 			   struct ahash_request *hash);
+int skb_copy_and_crc32c_datagram_iter(const struct sk_buff *skb, int offset,
+				      struct iov_iter *to, int len, u32 *crcp);
 int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
 				 struct iov_iter *from, int len);
 int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *frm);
 void skb_free_datagram(struct sock *sk, struct sk_buff *skb);
 int skb_kill_datagram(struct sock *sk, struct sk_buff *skb, unsigned int flags);
diff --git a/net/core/datagram.c b/net/core/datagram.c
index f0634f0cb834..47a6eef83162 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -50,10 +50,11 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <linux/iov_iter.h>
 #include <linux/indirect_call_wrapper.h>
+#include <linux/crc32.h>
 
 #include <net/protocol.h>
 #include <linux/skbuff.h>
 
 #include <net/checksum.h>
@@ -515,10 +516,40 @@ int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
 	return __skb_datagram_iter(skb, offset, to, len, true,
 			hash_and_copy_to_iter, hash);
 }
 EXPORT_SYMBOL(skb_copy_and_hash_datagram_iter);
 
+#ifdef CONFIG_NET_CRC32C
+static size_t crc32c_and_copy_to_iter(const void *addr, size_t bytes,
+				      void *_crcp, struct iov_iter *i)
+{
+	u32 *crcp = _crcp;
+	size_t copied;
+
+	copied = copy_to_iter(addr, bytes, i);
+	*crcp = crc32c(*crcp, addr, copied);
+	return copied;
+}
+
+/**
+ *	skb_copy_and_crc32c_datagram_iter - Copy datagram to an iovec iterator
+ *		and update a CRC32C value.
+ *	@skb: buffer to copy
+ *	@offset: offset in the buffer to start copying from
+ *	@to: iovec iterator to copy to
+ *	@len: amount of data to copy from buffer to iovec
+ *	@crcp: pointer to CRC32C value to update
+ */
+int skb_copy_and_crc32c_datagram_iter(const struct sk_buff *skb, int offset,
+				      struct iov_iter *to, int len, u32 *crcp)
+{
+	return __skb_datagram_iter(skb, offset, to, len, true,
+				   crc32c_and_copy_to_iter, crcp);
+}
+EXPORT_SYMBOL(skb_copy_and_crc32c_datagram_iter);
+#endif /* CONFIG_NET_CRC32C */
+
 static size_t simple_copy_to_iter(const void *addr, size_t bytes,
 		void *data __always_unused, struct iov_iter *i)
 {
 	return copy_to_iter(addr, bytes, i);
 }
-- 
2.49.0


