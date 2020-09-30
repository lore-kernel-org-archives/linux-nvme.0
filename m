Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BF7C4741F
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 16:21:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 911DE2076B
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 16:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rZyoAZfC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911DE2076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2a/QHrsoFbcyczWcpsCiUWPq52M0sDpnAEtKbS6Jyug=; b=rZyoAZfCkRXaBd5PTBBPpAGAN
	pWjEEB9HQiax7Ia1AEKNUv18IDl3MNQTKWMuOmDpZPgblWEfP1gnss8d6mllosIr89VQnemdBBLrc
	KJ9C9Ri96+nTArC1oVWPz8rcyN2wsflfRlO8Ngzw6vzvMNMtZgc6DtZ1XDL1C6eiL5nvi6AjJ2B4W
	mSih6RamevoR/l91fbzbSwFj9zXTCH5IItIoYjp/k2vaaDaiKe+GR6QKpSR+FPGigZfeT+6tFV6YU
	CezMRCTkPaPRsiBD1W7yp19HF4rGYbgsrDqoS1BKm3/v+BYiV4xcr+z6QEQ7JVqvffmIQQh031TgW
	UXayegcug==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNeqi-0002Xs-Tk; Wed, 30 Sep 2020 16:21:01 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNeqI-0002Lq-39
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 16:20:38 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 borisp@mellanox.com) with SMTP; 30 Sep 2020 19:20:27 +0300
Received: from gen-l-vrt-133.mtl.labs.mlnx. (gen-l-vrt-133.mtl.labs.mlnx
 [10.237.11.160])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 08UGKR2C032498;
 Wed, 30 Sep 2020 19:20:27 +0300
From: Boris Pismenny <borisp@mellanox.com>
To: kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org,
 viro@zeniv.linux.org.uk, edumazet@google.com
Subject: [PATCH net-next RFC v1 01/10] iov_iter: Skip copy in memcpy_to_page
 if src==dst
Date: Wed, 30 Sep 2020 19:20:01 +0300
Message-Id: <20200930162010.21610-2-borisp@mellanox.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200930162010.21610-1-borisp@mellanox.com>
References: <20200930162010.21610-1-borisp@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_122034_643232_736020CB 
X-CRM114-Status: GOOD (  13.32  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Ben Ben-Ishay <benishay@mellanox.com>,
 boris.pismenny@gmail.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>
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
index 3835a8a8e9ea..036df4073737 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -284,4 +284,6 @@ int iov_iter_for_each_range(struct iov_iter *i, size_t bytes,
 			    int (*f)(struct kvec *vec, void *context),
 			    void *context);
 
+extern struct static_key_false skip_copy_enabled;
+
 #endif
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 5e40786c8f12..27856c3db28b 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -13,6 +13,9 @@
 
 #define PIPE_PARANOIA /* for now */
 
+DEFINE_STATIC_KEY_FALSE(skip_copy_enabled);
+EXPORT_SYMBOL_GPL(skip_copy_enabled);
+
 #define iterate_iovec(i, n, __v, __p, skip, STEP) {	\
 	size_t left;					\
 	size_t wanted = n;				\
@@ -470,7 +473,13 @@ static void memcpy_from_page(char *to, struct page *page, size_t offset, size_t
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
