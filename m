Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F60C3ABD3
	for <linux-nvme@archiver.kernel.org>; Sun, 11 May 2025 00:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YBnUxj5b/XGP7a+7n0m4EJOjFuB1uOa9L54fzA3eCoQ=; b=JR/r1D8tnDLiuLK/PLp7aOm4xI
	298K++HKVQFwOQNHP6nYQEioj1AWLFA5OVfa50iunSpQH7NrDRLY62quw0zYPKyT+unsPKVyPXy7U
	LlxMo+i53toVDpZM7ihkdbhbfE9DYNHaUnWS8lUJmjMsEYYEDm7A7Ypn2y/7J0MEFRu5rw8KrE6qz
	M2drfoZ7WG2FTVkDjh7qD4cukh/mSBozEo85KTn13CgrmNTk+q29t4UDX8/R8FOJJpzaKFDwVBSAH
	0REv55Tb0Xpz+D1na2/RxsT19n9DJufrqNuqjKBC3o3CzOk0k5bavdUaSM+1bJeqT88SRyLqdTppz
	YaxlJ7Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDulF-00000006XiY-2vnv;
	Sun, 11 May 2025 00:41:45 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDulA-00000006XdA-38MT
	for linux-nvme@lists.infradead.org;
	Sun, 11 May 2025 00:41:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 66829443B3;
	Sun, 11 May 2025 00:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 631B4C4CEEE;
	Sun, 11 May 2025 00:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746924100;
	bh=1M/Uxj/GlzhwSrBWvWBpAp/iDXzpGWDqYvfOyMyRoL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NZOX/xwMxCnXrfMk9nmIM7VO+YI5DMYHUfROWZ/IvYpTGiJ3pS0j87VESZ6xW8kOs
	 A5uDYUAkFqYXzdpzyeng1AI6bchZZ6NmZKvS5t+WQWxNXX9a2yGCpeNKC8dB71eEyX
	 GpBvoEOACOz2AHtm9Y+hBGYNuikSYitAsXa0DpuuiD7xNb3RoKA2jsehoXky/JTvYR
	 9ptSMpk7mJu4rh3cg/h/r5l042QmusHMbSP5ulzjQMAZBc+UgSwtrcAPi714mInHtX
	 pi7Sqjxuu46+6wuIByHBS6WbVlsJnhDjcQ9CjSpFgfjY3DB5BlAaLJ3tFUyehKvot8
	 258DbM8dcgFoA==
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
Subject: [PATCH net-next 10/10] net: remove skb_copy_and_hash_datagram_iter()
Date: Sat, 10 May 2025 17:41:10 -0700
Message-ID: <20250511004110.145171-11-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250511004110.145171-1-ebiggers@kernel.org>
References: <20250511004110.145171-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250510_174140_845069_C6F83723 
X-CRM114-Status: GOOD (  11.71  )
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
index 0027f2977c02..98cecd3a2fb8 100644
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
@@ -4123,13 +4122,10 @@ static inline int skb_copy_datagram_msg(const struct sk_buff *from, int offset,
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
index 47a6eef83162..b83731f11fad 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -60,11 +60,10 @@
 #include <net/checksum.h>
 #include <net/sock.h>
 #include <net/tcp_states.h>
 #include <trace/events/skb.h>
 #include <net/busy_poll.h>
-#include <crypto/hash.h>
 
 /*
  *	Is a socket 'connection oriented' ?
  */
 static inline int connection_based(struct sock *sk)
@@ -480,46 +479,10 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
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


