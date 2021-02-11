Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97212C43381
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 21:11:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E4D564E42
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 21:11:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E4D564E42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6zGI2NOwcbEgGG7mzDX8mCGsihtXLLX4N5BQIEomYKk=; b=aw64AaMFHcCaaQTpfvxCy7/H8
	AJLNn+Tp/gTlxlEidP6pPP/aNmV7WtFftq5h3VRelUAo6yMC10pvgdVATfe62y5H0k4qH0JBnmwaa
	7U+ba2asFwBI/Rt3lR7ttq9E5eln0xogt40vYMyZtjZwVbUvI46/BvziJJRBwe5Mb23JdyYDnnZ7h
	boUXpyNU1W9WcPA4zsuUwOgteeXAPnCCz/z35Wt1fYah04m7fXdFEjZgFVVKFeW4BxkgE6xY9UVfO
	WGAVKDpCf7oyek5qGDJzta++YYifcstszYA1YDt9dr4puVC4HMlGvBTcOMwr5UUA7i5qxEqJG0pEX
	PElwir2Kw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAJFS-00047R-Sr; Thu, 11 Feb 2021 21:11:38 +0000
Received: from hqnvemgate25.nvidia.com ([216.228.121.64])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAJFD-00042Q-RE
 for linux-nvme@lists.infradead.org; Thu, 11 Feb 2021 21:11:26 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B60259d7a0001>; Thu, 11 Feb 2021 13:11:22 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 11 Feb
 2021 21:11:13 +0000
Received: from vdi.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 11 Feb 2021 21:11:08 +0000
From: Boris Pismenny <borisp@mellanox.com>
To: <dsahern@gmail.com>, <kuba@kernel.org>, <davem@davemloft.net>,
 <saeedm@nvidia.com>, <hch@lst.de>, <sagi@grimberg.me>, <axboe@fb.com>,
 <kbusch@kernel.org>, <viro@zeniv.linux.org.uk>, <edumazet@google.com>,
 <smalin@marvell.com>
Subject: [PATCH v4 net-next 04/21] net: skb copy(+hash) iterators for DDP
 offloads
Date: Thu, 11 Feb 2021 23:10:27 +0200
Message-ID: <20210211211044.32701-5-borisp@mellanox.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210211211044.32701-1-borisp@mellanox.com>
References: <20210211211044.32701-1-borisp@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210211_161124_156228_EE9E43D3 
X-CRM114-Status: GOOD (  12.95  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Boris Pismenny <borisp@mellanox.com>,
 yorayz@nvidia.com, boris.pismenny@gmail.com, benishay@nvidia.com,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This commit introduces new functions to support direct data placement
(DDP) NIC offloads that avoid copying data from SKBs.

Later patches will use this for nvme-tcp DDP offload.

Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Yoray Zack <yorayz@mellanox.com>
---
 include/linux/skbuff.h |  9 ++++++++
 net/core/datagram.c    | 48 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0d1be25574cc..0470eb3c9976 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3594,6 +3594,10 @@ __poll_t datagram_poll(struct file *file, struct socket *sock,
 			   struct poll_table_struct *wait);
 int skb_copy_datagram_iter(const struct sk_buff *from, int offset,
 			   struct iov_iter *to, int size);
+#ifdef CONFIG_TCP_DDP
+int skb_ddp_copy_datagram_iter(const struct sk_buff *from, int offset,
+			       struct iov_iter *to, int size);
+#endif
 static inline int skb_copy_datagram_msg(const struct sk_buff *from, int offset,
 					struct msghdr *msg, int size)
 {
@@ -3604,6 +3608,11 @@ int skb_copy_and_csum_datagram_msg(struct sk_buff *skb, int hlen,
 int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
 			   struct iov_iter *to, int len,
 			   struct ahash_request *hash);
+#ifdef CONFIG_TCP_DDP
+int skb_ddp_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
+					struct iov_iter *to, int len,
+					struct ahash_request *hash);
+#endif
 int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
 				 struct iov_iter *from, int len);
 int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *frm);
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 81809fa735a7..f386d4d82b1b 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -495,6 +495,27 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 	return 0;
 }
 
+#ifdef CONFIG_TCP_DDP
+/**
+ *	skb_ddp_copy_and_hash_datagram_iter - Copies datagrams from skb frags to
+ *	an iterator and update a hash. If the iterator and skb frag point to the
+ *	same page and offset, then the copy is skipped.
+ *	@skb: buffer to copy
+ *	@offset: offset in the buffer to start copying from
+ *	@to: iovec iterator to copy to
+ *	@len: amount of data to copy from buffer to iovec
+ *      @hash: hash request to update
+ */
+int skb_ddp_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
+					struct iov_iter *to, int len,
+					struct ahash_request *hash)
+{
+	return __skb_datagram_iter(skb, offset, to, len, true,
+			ddp_hash_and_copy_to_iter, hash);
+}
+EXPORT_SYMBOL(skb_ddp_copy_and_hash_datagram_iter);
+#endif
+
 /**
  *	skb_copy_and_hash_datagram_iter - Copy datagram to an iovec iterator
  *          and update a hash.
@@ -513,6 +534,33 @@ int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
 }
 EXPORT_SYMBOL(skb_copy_and_hash_datagram_iter);
 
+#ifdef CONFIG_TCP_DDP
+static size_t simple_ddp_copy_to_iter(const void *addr, size_t bytes,
+				      void *data __always_unused,
+				      struct iov_iter *i)
+{
+	return ddp_copy_to_iter(addr, bytes, i);
+}
+
+/**
+ *	skb_ddp_copy_datagram_iter - Copies datagrams from skb frags to an
+ *	iterator. If the iterator and skb frag point to the same page and
+ *	offset, then the copy is skipped.
+ *	@skb: buffer to copy
+ *	@offset: offset in the buffer to start copying from
+ *	@to: iovec iterator to copy to
+ *	@len: amount of data to copy from buffer to iovec
+ */
+int skb_ddp_copy_datagram_iter(const struct sk_buff *skb, int offset,
+			       struct iov_iter *to, int len)
+{
+	trace_skb_copy_datagram_iovec(skb, len);
+	return __skb_datagram_iter(skb, offset, to, len, false,
+			simple_ddp_copy_to_iter, NULL);
+}
+EXPORT_SYMBOL(skb_ddp_copy_datagram_iter);
+#endif
+
 static size_t simple_copy_to_iter(const void *addr, size_t bytes,
 		void *data __always_unused, struct iov_iter *i)
 {
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
