Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7399C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 10:15:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 860C064E08
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 10:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860C064E08
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gvAGCBz1t1/lVUtDkG5saItgIfPeM9tqDZiKVEaRTp8=; b=dTlzmwNV49t0A8mvhTT44+qxb
	xZiQU7opcK7idmG2P8r9ckZr8D+1cUch/O+P6QvEnQmTNiQaCD3WX71pseIh8oJK3PW6IyblF3HkY
	h8Weq82w7dpLz85Ln8pKC7BG+j9z7/eyrh2jYW13UHCQYNZESandQHEZC1Xk8+GHBwUaWh+Wku5oW
	yx9jMI7fXnbzfUWVViDFJhtsbhu+JbHeEPfrSA6RM/FeqUdeq/0BqIW/BKnaloFIkittpoYXUu0a+
	RtGPILegx16eChftt54FayeJU+qbfM4YLfGsPP+G+wRsu4ge08qFqdQjpFF8v+ywI0pP+qEkZ+isK
	FW+th/LMg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6WET-00086G-Fk; Mon, 01 Feb 2021 10:14:57 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6W59-00042S-PI
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 10:05:28 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 borisp@mellanox.com) with SMTP; 1 Feb 2021 12:05:13 +0200
Received: from gen-l-vrt-133.mtl.labs.mlnx. (gen-l-vrt-133.mtl.labs.mlnx
 [10.237.11.160])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 111A5Cxs029353;
 Mon, 1 Feb 2021 12:05:12 +0200
From: Boris Pismenny <borisp@mellanox.com>
To: dsahern@gmail.com, kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com,
 hch@lst.de, sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org,
 viro@zeniv.linux.org.uk, edumazet@google.com, smalin@marvell.com
Subject: [PATCH v3 net-next 01/21] iov_iter: Introduce new procedures for copy
 to iter/pages
Date: Mon,  1 Feb 2021 12:04:49 +0200
Message-Id: <20210201100509.27351-2-borisp@mellanox.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210201100509.27351-1-borisp@mellanox.com>
References: <20210201100509.27351-1-borisp@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_050520_370365_D3DEDBC3 
X-CRM114-Status: GOOD (  13.13  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Yoray Zack <yorayz@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 benishay@nvidia.com, linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When using direct data placement the NIC writes some of the payload
directly to the destination buffer, and constructs the SKB such that it
points to this data. As a result, the skb_copy datagram_iter call will
attempt to copy data when it is not necessary.

Introduce new procedures for copy to iter/pages in case that the
source of the copy operation might be identical to the destination,
in such cases the copy is skipped only for bio_vec, later commits
uses those functions to introduce new skb copy(+hash) functions.

Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Ben Ben-Ishay <benishay@mellanox.com>
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Yoray Zack <yorayz@mellanox.com>
---
 include/linux/uio.h | 12 ++++++++++++
 lib/iov_iter.c      | 47 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 72d88566694e..3c42125a7f24 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -123,6 +123,7 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
 
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
+size_t _ddp_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
 bool _copy_from_iter_full(void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i);
@@ -137,6 +138,15 @@ size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 		return _copy_to_iter(addr, bytes, i);
 }
 
+static __always_inline __must_check
+size_t ddp_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
+{
+	if (unlikely(!check_copy_size(addr, bytes, true)))
+		return 0;
+	else
+		return _ddp_copy_to_iter(addr, bytes, i);
+}
+
 static __always_inline __must_check
 size_t copy_from_iter(void *addr, size_t bytes, struct iov_iter *i)
 {
@@ -265,6 +275,8 @@ size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum, struct io
 bool csum_and_copy_from_iter_full(void *addr, size_t bytes, __wsum *csum, struct iov_iter *i);
 size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
 		struct iov_iter *i);
+size_t ddp_hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
+		struct iov_iter *i);
 
 struct iovec *iovec_from_user(const struct iovec __user *uvector,
 		unsigned long nr_segs, unsigned long fast_segs,
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index a21e6a5792c5..b8af1d3bbec0 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -473,6 +473,16 @@ static void memcpy_from_page(char *to, struct page *page, size_t offset, size_t
 	kunmap_atomic(from);
 }
 
+static void ddp_memcpy_to_page(struct page *page, size_t offset, const char *from, size_t len)
+{
+	char *to = kmap_atomic(page);
+
+	if (to + offset != from)
+		memcpy(to + offset, from, len);
+
+	kunmap_atomic(to);
+}
+
 static void memcpy_to_page(struct page *page, size_t offset, const char *from, size_t len)
 {
 	char *to = kmap_atomic(page);
@@ -625,6 +635,24 @@ static size_t csum_and_copy_to_pipe_iter(const void *addr, size_t bytes,
 	return bytes;
 }
 
+size_t _ddp_copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
+{
+	const char *from = addr;
+	if (unlikely(iov_iter_is_pipe(i)))
+		return copy_pipe_to_iter(addr, bytes, i);
+	if (iter_is_iovec(i))
+		might_fault();
+	iterate_and_advance(i, bytes, v,
+		copyout(v.iov_base, (from += v.iov_len) - v.iov_len, v.iov_len),
+		ddp_memcpy_to_page(v.bv_page, v.bv_offset,
+				   (from += v.bv_len) - v.bv_len, v.bv_len),
+		memcpy(v.iov_base, (from += v.iov_len) - v.iov_len, v.iov_len)
+		)
+
+	return bytes;
+}
+EXPORT_SYMBOL(_ddp_copy_to_iter);
+
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 {
 	const char *from = addr;
@@ -1566,6 +1594,25 @@ size_t csum_and_copy_to_iter(const void *addr, size_t bytes, void *csump,
 }
 EXPORT_SYMBOL(csum_and_copy_to_iter);
 
+size_t ddp_hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
+		struct iov_iter *i)
+{
+#ifdef CONFIG_CRYPTO_HASH
+	struct ahash_request *hash = hashp;
+	struct scatterlist sg;
+	size_t copied;
+
+	copied = ddp_copy_to_iter(addr, bytes, i);
+	sg_init_one(&sg, addr, copied);
+	ahash_request_set_crypt(hash, &sg, NULL, copied);
+	crypto_ahash_update(hash);
+	return copied;
+#else
+	return 0;
+#endif
+}
+EXPORT_SYMBOL(ddp_hash_and_copy_to_iter);
+
 size_t hash_and_copy_to_iter(const void *addr, size_t bytes, void *hashp,
 		struct iov_iter *i)
 {
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
