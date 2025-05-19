Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD21C5479B
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 19:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oDHdh8FErkagFg5pLUMUyU+1RI60AQrQ1bpsfiNSkjM=; b=qXQoRLe8PjQNhI6+TjhdrFMaMg
	SkwlvbAtNJI2CIXkYYSX90QZgGc+3SvyEWB1nStfL72roCyQ3xgqsSSib3XAJMu2NVmBNealDknDz
	VNwE5G6onbpEu4RwnHC8FS79Gvog89BWdNHXeLKGfP+l8xCuFyX2fAQVlfTJqBPisjdPszzo0xC+W
	ulAY3dpnMLgkL7m/hCCNXnBfXOqUkAchELiGaD30TKK845wn6r0ExxwQ8aFYbUzNLGRB+ed9sf7gs
	e9L7Jit7FeLI8XGbJ1735c766Dek8wHvKRZ/c+kMSH5dhrlAoOilzpcKh6kL7GSfq31Ki7LP7Mk13
	2GNIZ+Xg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH6a7-0000000AHh6-1OWe;
	Mon, 19 May 2025 19:55:27 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH4ee-0000000A1f4-2rzN
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 17:52:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id EB063A4E614;
	Mon, 19 May 2025 17:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D79C4CEF4;
	Mon, 19 May 2025 17:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747677119;
	bh=kKAbK/ihktd10bayLsP//PWEOGB9vYQ3zKxqoKSXAE8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Oq+0yzHgg/BE5fx8mWtvGsUZsDNEl+TglApCHMhKrDLYo7bdS+pUHN2mZTrEmoPHR
	 IM5pPe9XgnOziiQyvPwuQmseGRtl4SiOwhx9anLsXUMc8AL78m1bT13Mmc0zn/wx5o
	 523Ppp6ZmG6Gr3yiwa3AARwmMKgGpu7K/ufv0sduClRfWk7uM4mP81MuC/e7DLyrg1
	 eTPJmldloKsrqZbFspNXjm32F9V3C72jFsShlXfO3eQ4X7CpJoxLVybdT1lP5hDhSE
	 yug0J+IvMku+I7yPD/9hd2gS6l0LEACk5LD0XXVtvVf9oWTOSAssUAfQTi7NQneTDb
	 kFTNIJa5EehDg==
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
Subject: [PATCH v2 08/10] net: add skb_copy_and_crc32c_datagram_iter()
Date: Mon, 19 May 2025 10:50:10 -0700
Message-ID: <20250519175012.36581-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519175012.36581-1-ebiggers@kernel.org>
References: <20250519175012.36581-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_105200_862042_42C894B3 
X-CRM114-Status: GOOD (  15.44  )
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
 net/core/datagram.c    | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 018c072305133..510adf63c2113 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4135,10 +4135,12 @@ static inline int skb_copy_datagram_msg(const struct sk_buff *from, int offset,
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
index 9ef5442536f59..fa87abb666324 100644
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
@@ -517,10 +518,42 @@ int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
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
+ *
+ *	Return: 0 on success, -EFAULT if there was a fault during copy.
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


