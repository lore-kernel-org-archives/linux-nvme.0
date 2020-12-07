Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEB7EC4361B
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 21:07:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BB2C2388C
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 21:07:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB2C2388C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=1JtSHbBAKi9kVBXV8MRljaqVxQHrjnkEqxKJOjiljm4=; b=I0sNVSY7MXt+86vO5Ie+i5an7
	k7R/El+2VbUuMI3MAoiL9e9qCb7ucYxXusXuJN5ElUBek2j6ZIf92Y407NZm5Gzb0yUB4XmTzzMPo
	wlS6J5XDUhdt5JqLscHjiayJVTYVBW7aLapQpGRF8N9o2SGsKjo5hiXx5hhQ45Xco2N7DOJ64DPS0
	3iWz6T81YLAETmh1GDXecKO0xdhhRL7TDAksRoMo92fQ2hqXnL+tADDRyig/ZBTbi8upyihMBit6a
	g+/GtjYgIStN2dLdMfPmNkJxeCTFyDPzF5QcPiTa5kRbBfvgKKXtUYC3OP09ptHXBrUY1J0mvBdKE
	okLH08eXg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmNiu-000100-Bv; Mon, 07 Dec 2020 21:07:08 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmNik-0000ud-TO
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 21:07:02 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 borisp@mellanox.com) with SMTP; 7 Dec 2020 23:06:52 +0200
Received: from gen-l-vrt-133.mtl.labs.mlnx. (gen-l-vrt-133.mtl.labs.mlnx
 [10.237.11.160])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0B7L6qI9029788;
 Mon, 7 Dec 2020 23:06:52 +0200
From: Boris Pismenny <borisp@mellanox.com>
To: kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org,
 viro@zeniv.linux.org.uk, edumazet@google.com
Subject: [PATCH v1 net-next 01/15] iov_iter: Skip copy in memcpy_to_page if
 src==dst
Date: Mon,  7 Dec 2020 23:06:35 +0200
Message-Id: <20201207210649.19194-2-borisp@mellanox.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201207210649.19194-1-borisp@mellanox.com>
References: <20201207210649.19194-1-borisp@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_160659_491214_FD6A7E03 
X-CRM114-Status: GOOD (  12.82  )
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

This patch adds a check to avoid this copy, and a static_key to enabled
it when TCP direct data placement is possible.

Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Ben Ben-Ishay <benishay@mellanox.com>
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Yoray Zack <yorayz@mellanox.com>
---
 include/linux/uio.h |  2 ++
 lib/iov_iter.c      | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 72d88566694e..05573d848ff5 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -282,4 +282,6 @@ int iov_iter_for_each_range(struct iov_iter *i, size_t bytes,
 			    int (*f)(struct kvec *vec, void *context),
 			    void *context);
 
+extern struct static_key_false skip_copy_enabled;
+
 #endif
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 1635111c5bd2..206edb051135 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -15,6 +15,9 @@
 
 #define PIPE_PARANOIA /* for now */
 
+DEFINE_STATIC_KEY_FALSE(skip_copy_enabled);
+EXPORT_SYMBOL_GPL(skip_copy_enabled);
+
 #define iterate_iovec(i, n, __v, __p, skip, STEP) {	\
 	size_t left;					\
 	size_t wanted = n;				\
@@ -476,7 +479,13 @@ static void memcpy_from_page(char *to, struct page *page, size_t offset, size_t
 static void memcpy_to_page(struct page *page, size_t offset, const char *from, size_t len)
 {
 	char *to = kmap_atomic(page);
-	memcpy(to + offset, from, len);
+
+	if (static_branch_unlikely(&skip_copy_enabled)) {
+		if (to + offset != from)
+			memcpy(to + offset, from, len);
+	} else {
+		memcpy(to + offset, from, len);
+	}
 	kunmap_atomic(to);
 }
 
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
