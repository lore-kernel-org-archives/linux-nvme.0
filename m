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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA143C433E6
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 10:14:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E9FA64DB2
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 10:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9FA64DB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=T91//PCQVzVAY+HV2ZrI0qfFiB2qkF95Icppw8RWzV8=; b=i5BTsdo1v6Ek/ufOOcU3AcnBk
	JVMKqhFF/5/IIcocXWlKhJakhJ1ny740xOAKxxHq+SrYt/aEXKAZjxfCvS/wsXj1EEalqASVEuyqt
	Gb1KXt0VNkkJySS9nYl5nzIVLqsFKrKiHiOq7hg/GKFwAM1hXmtUz65tSVLTzrqCnIvUTdgALjZhI
	yXuw1sL0tqrXonNSKg4cZEV/cBhHm5je8hSnBaSHegZhZ/faN5N+K2Q+LnXf4z3a0FaZurpAT4uXE
	7e4tYQWfN43jjj5lPBPIxR/85sCCYiikD0ZYN+9DwZ8Yx+zk6nbDJ7FZxkO4p6+k4oVz67kb47uG/
	e03jAZdiA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6WE3-0007r7-6Y; Mon, 01 Feb 2021 10:14:31 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6W59-00042R-9F
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 10:05:25 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 borisp@mellanox.com) with SMTP; 1 Feb 2021 12:05:13 +0200
Received: from gen-l-vrt-133.mtl.labs.mlnx. (gen-l-vrt-133.mtl.labs.mlnx
 [10.237.11.160])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 111A5Cxv029353;
 Mon, 1 Feb 2021 12:05:13 +0200
From: Boris Pismenny <borisp@mellanox.com>
To: dsahern@gmail.com, kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com,
 hch@lst.de, sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org,
 viro@zeniv.linux.org.uk, edumazet@google.com, smalin@marvell.com
Subject: [PATCH v3 net-next 04/21] net: SKB copy(+hash) iterators for DDP
 offloads
Date: Mon,  1 Feb 2021 12:04:52 +0200
Message-Id: <20210201100509.27351-5-borisp@mellanox.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210201100509.27351-1-borisp@mellanox.com>
References: <20210201100509.27351-1-borisp@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_050519_987934_AA87A77E 
X-CRM114-Status: GOOD (  14.17  )
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
 boris.pismenny@gmail.com, benishay@nvidia.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
 ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Ben Ben-ishay <benishay@nvidia.com>

This commit introduces new functions to support direct data placement
operation, when using direct data placement the copy of the data from
the SKB to the destination buffer might be unnecessary and thus the
copy should be skipped, those functions take care of it in cases that
the destination buffer is represented by bio_vec.

Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Yoray Zack <yorayz@mellanox.com>
---
 include/linux/skbuff.h |  5 +++++
 net/core/datagram.c    | 44 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 32c5ab8e2f67..79fdcdd1261b 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3546,6 +3546,8 @@ __poll_t datagram_poll(struct file *file, struct socket *sock,
 			   struct poll_table_struct *wait);
 int skb_copy_datagram_iter(const struct sk_buff *from, int offset,
 			   struct iov_iter *to, int size);
+int skb_ddp_copy_datagram_iter(const struct sk_buff *from, int offset,
+			       struct iov_iter *to, int size);
 static inline int skb_copy_datagram_msg(const struct sk_buff *from, int offset,
 					struct msghdr *msg, int size)
 {
@@ -3556,6 +3558,9 @@ int skb_copy_and_csum_datagram_msg(struct sk_buff *skb, int hlen,
 int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
 			   struct iov_iter *to, int len,
 			   struct ahash_request *hash);
+int skb_ddp_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
+					struct iov_iter *to, int len,
+					struct ahash_request *hash);
 int skb_copy_datagram_from_iter(struct sk_buff *skb, int offset,
 				 struct iov_iter *from, int len);
 int zerocopy_sg_from_iter(struct sk_buff *skb, struct iov_iter *frm);
diff --git a/net/core/datagram.c b/net/core/datagram.c
index 81809fa735a7..bbc476cadc71 100644
--- a/net/core/datagram.c
+++ b/net/core/datagram.c
@@ -495,6 +495,25 @@ static int __skb_datagram_iter(const struct sk_buff *skb, int offset,
 	return 0;
 }
 
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
+
 /**
  *	skb_copy_and_hash_datagram_iter - Copy datagram to an iovec iterator
  *          and update a hash.
@@ -513,6 +532,31 @@ int skb_copy_and_hash_datagram_iter(const struct sk_buff *skb, int offset,
 }
 EXPORT_SYMBOL(skb_copy_and_hash_datagram_iter);
 
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
