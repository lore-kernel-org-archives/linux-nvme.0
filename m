Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC1AC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 21:11:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 344D964E3E
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 21:11:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 344D964E3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-ID:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rjwZlSodviwD6ecYpNS3BMN6uxqSc2nXVEzTBohZY9Q=; b=lQf5F3eJmH22V0i6zZwqEue+d
	0EnEZCAfoh/u1TA9PHlzKQLJDBsMLsYSisTTLbs2A/IZYYWG+PFZJNSo/xFyrqlpCfKyFrM3ztV1C
	e7Erw5SV5+wi2pR5oWOBwgozU889Re9lIB532nlhifFNPGLbtNIwdAn2HObQM9DXGe7KMLH3kdLfT
	F7y4DLjUylCiJ4s1lraZ+HP130hpve69/uLZQrVRymyWKvtl8XFL97WN8lIZfFLPnZkVQFPNWSJhL
	5ZymaulV9eWtexkgEE9KMZb3o8iBgBbwQs/pX1vKKOCEEZnxg9+6L3YckVEFgkBOKIQqFBGVcve1X
	WZTL1ZQUA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAJFY-00049W-7K; Thu, 11 Feb 2021 21:11:44 +0000
Received: from hqnvemgate24.nvidia.com ([216.228.121.143])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAJFG-000433-3c
 for linux-nvme@lists.infradead.org; Thu, 11 Feb 2021 21:11:28 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B60259d7d0000>; Thu, 11 Feb 2021 13:11:25 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 11 Feb
 2021 21:11:17 +0000
Received: from vdi.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 11 Feb 2021 21:11:13 +0000
From: Boris Pismenny <borisp@mellanox.com>
To: <dsahern@gmail.com>, <kuba@kernel.org>, <davem@davemloft.net>,
 <saeedm@nvidia.com>, <hch@lst.de>, <sagi@grimberg.me>, <axboe@fb.com>,
 <kbusch@kernel.org>, <viro@zeniv.linux.org.uk>, <edumazet@google.com>,
 <smalin@marvell.com>
Subject: [PATCH v4 net-next  05/21] net/tls: expose get_netdev_for_sock
Date: Thu, 11 Feb 2021 23:10:28 +0200
Message-ID: <20210211211044.32701-6-borisp@mellanox.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210211211044.32701-1-borisp@mellanox.com>
References: <20210211211044.32701-1-borisp@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210211_161126_369974_268D74AA 
X-CRM114-Status: GOOD (  12.56  )
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
Cc: Boris Pismenny <borisp@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, benishay@nvidia.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

get_netdev_for_sock is a utility that is used to obtain
the net_device structure from a connected socket.

Later patches will use this for nvme-tcp DDP and DDP CRC offloads.

Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 include/net/sock.h   | 17 +++++++++++++++++
 net/tls/tls_device.c | 20 ++------------------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 690e496a0e79..f6d70f689bd1 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2732,4 +2732,21 @@ void sock_set_sndtimeo(struct sock *sk, s64 secs);
 
 int sock_bind_add(struct sock *sk, struct sockaddr *addr, int addr_len);
 
+/* Assume that the socket is already connected */
+static inline struct net_device *get_netdev_for_sock(struct sock *sk, bool hold)
+{
+	struct dst_entry *dst = sk_dst_get(sk);
+	struct net_device *netdev = NULL;
+
+	if (likely(dst)) {
+		netdev = dst->dev;
+		if (hold)
+			dev_hold(netdev);
+	}
+
+	dst_release(dst);
+
+	return netdev;
+}
+
 #endif	/* _SOCK_H */
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index d9cd229aa111..792c0a477850 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -106,22 +106,6 @@ static void tls_device_queue_ctx_destruction(struct tls_context *ctx)
 	spin_unlock_irqrestore(&tls_device_lock, flags);
 }
 
-/* We assume that the socket is already connected */
-static struct net_device *get_netdev_for_sock(struct sock *sk)
-{
-	struct dst_entry *dst = sk_dst_get(sk);
-	struct net_device *netdev = NULL;
-
-	if (likely(dst)) {
-		netdev = netdev_sk_get_lowest_dev(dst->dev, sk);
-		dev_hold(netdev);
-	}
-
-	dst_release(dst);
-
-	return netdev;
-}
-
 static void destroy_record(struct tls_record_info *record)
 {
 	int i;
@@ -1106,7 +1090,7 @@ int tls_set_device_offload(struct sock *sk, struct tls_context *ctx)
 	if (skb)
 		TCP_SKB_CB(skb)->eor = 1;
 
-	netdev = get_netdev_for_sock(sk);
+	netdev = get_netdev_for_sock(sk, true);
 	if (!netdev) {
 		pr_err_ratelimited("%s: netdev not found\n", __func__);
 		rc = -EINVAL;
@@ -1182,7 +1166,7 @@ int tls_set_device_offload_rx(struct sock *sk, struct tls_context *ctx)
 	if (ctx->crypto_recv.info.version != TLS_1_2_VERSION)
 		return -EOPNOTSUPP;
 
-	netdev = get_netdev_for_sock(sk);
+	netdev = get_netdev_for_sock(sk, true);
 	if (!netdev) {
 		pr_err_ratelimited("%s: netdev not found\n", __func__);
 		return -EINVAL;
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
