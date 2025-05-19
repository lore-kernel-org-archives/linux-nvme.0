Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37155C2D0CD
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 19:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B4lJAFsCRBkptLShOfLsaWJhElxK74VGN/ZjYHOKv4o=; b=DJ8e28dnQa6S8g1J0RraVJgeyh
	NRHe0JGMupSYv9ZV8N7Ke8FNCZOdlaSRvjCFtXCO+k79jzzKGHJR3Bihs2Q2x5UToRsj7aAWbe8NP
	oGXAIaKAVRPt9hyMUMvVFau8LobgS5sdixcfe/FhNdMWZOP6UJhxCZ41rSOf7ARJE/sgR9d+s12mv
	lvFPvG0W189l8efC0cxGMvEfUlDHEaXuIRfKbrOsaDW2yeP8g3THS1ndWdhZqIad14k0d+kUrH7qK
	2LjtEIyectzlEaObqQ8ChplGhp3vObsAc9itI2+iNfAdCDSwwrhBcPbLCDKoTdq1k/r1z4D9mkxAD
	2BRlo2hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH6a8-0000000AHj2-2s7J;
	Mon, 19 May 2025 19:55:28 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH4ef-0000000A1g7-2p55
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 17:52:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id F1F23A4E3ED;
	Mon, 19 May 2025 17:52:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F53C4CEF1;
	Mon, 19 May 2025 17:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747677120;
	bh=mIsfiVI45v2VPTWBozlSjRtw4VqrI/GcVcTcOwb4ZRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QR2+iVWKJqeHqPio6M358dZ6cQUWbOX/PBRAO2eoWIddik+He5js4DXnq6aqPbeYC
	 6x+To/VR2K2WcczMELmWTmH2uhqmvKf9Ge4oKVWuJrZhPiZgZ4xAl34/1FENmTSEIe
	 P5c8E3xZSsSx+Et92DossoX9+FwAlX7/23r2kUxcCQ9eiNGcjZH6nAgYvrI9UZxBmB
	 qKSfwx/i2h7c5g7THDj7SPzNsg2zNqCqQVmW9CB5Ay+YoFCZbrvUXZ021BFfmkpBSD
	 V+155XQBuNbNnmaTsxGZ08hIfgzf+MmGtyY1z1ND0UtLvq/iYbjAf8ccvf2cPmNuRw
	 3/bMDyqVcqqiw==
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
Subject: [PATCH v2 10/10] net: remove skb_copy_and_hash_datagram_iter()
Date: Mon, 19 May 2025 10:50:12 -0700
Message-ID: <20250519175012.36581-11-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519175012.36581-1-ebiggers@kernel.org>
References: <20250519175012.36581-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_105201_854117_BBD89CC3 
X-CRM114-Status: GOOD (  12.89  )
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

Now that skb_copy_and_hash_datagram_iter() is no longer used, remove it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/skbuff.h |  4 ----
 net/core/datagram.c    | 37 -------------------------------------
 2 files changed, 41 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 510adf63c2113..5520524c93bff 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -272,11 +272,10 @@
 /* return minimum truesize of one skb containing X bytes of data */
 #define SKB_TRUESIZE(X) ((X) +						\
 			 SKB_DATA_ALIGN(sizeof(struct sk_buff)) +	\
 			 SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 
-struct ahash_request;
 struct net_device;
 struct scatterlist;
 struct pipe_inode_info;
 struct iov_iter;
 struct napi_struct;
@@ -4132,13 +4131,10 @@ static inline int skb_copy_datagram_msg(const struct sk_buff *from, int offset,
 {
 	return skb_copy_datagram_iter(from, offset, &msg->msg_iter, size);
 }
 int skb_copy_and_csum_datagram_msg(struct sk_buff *skb, int hlen,
 				   struct msghdr *msg);
-int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
-			   struct iov_iter *to, int len,
-			   struct ahash_request *hash);
 int skb_copy_and_crc32c_datagram_iter(const struct sk_buff *skb, int offset,
 				      struct iov_iter *to, int len, u32 *crcp);
 int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
 				 struct iov_iter *from, int len);
 int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *frm);
diff --git a/net/core/datagram.c b/net/core/datagram.c
index fa87abb666324..b352a10093041 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -60,11 +60,10 @@
 #include <net/checksum.h>
 #include <net/sock.h>
 #include <net/tcp_states.h>
 #include <trace/events/skb.h>
 #include <net/busy_poll.h>
-#include <crypto/hash.h>
 
 #include "devmem.h"
 
 /*
  *	Is a socket 'connection oriented' ?
@@ -482,46 +481,10 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 		goto fault;
 
 	return 0;
 }
 
-static size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
-				    struct iov_iter *i)
-{
-#ifdef CONFIG_CRYPTO_HASH
-	struct ahash_request *hash = hashp;
-	struct scatterlist sg;
-	size_t copied;
-
-	copied = copy_to_iter(addr, bytes, i);
-	sg_init_one(&sg, addr, copied);
-	ahash_request_set_crypt(hash, &sg, NULL, copied);
-	crypto_ahash_update(hash);
-	return copied;
-#else
-	return 0;
-#endif
-}
-
-/**
- *	skb_copy_and_hash_datagram_iter - Copy datagram to an iovec iterator
- *          and update a hash.
- *	@skb: buffer to copy
- *	@offset: offset in the buffer to start copying from
- *	@to: iovec iterator to copy to
- *	@len: amount of data to copy from buffer to iovec
- *      @hash: hash request to update
- */
-int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
-			   struct iov_iter *to, int len,
-			   struct ahash_request *hash)
-{
-	return __skb_datagram_iter(skb, offset, to, len, true,
-			hash_and_copy_to_iter, hash);
-}
-EXPORT_SYMBOL(skb_copy_and_hash_datagram_iter);
-
 #ifdef CONFIG_NET_CRC32C
 static size_t crc32c_and_copy_to_iter(const void *addr, size_t bytes,
 				      void *_crcp, struct iov_iter *i)
 {
 	u32 *crcp = _crcp;
-- 
2.49.0


