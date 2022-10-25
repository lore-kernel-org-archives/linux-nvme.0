Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B422AFA3740
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 16:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8UflhIVB7Or34p+cX4xFC3iVcjIHmCn/s1dokLQhBNA=; b=uBENFa/cyFECAEEW6SGTwwDScY
	vfD8rleBD2wdy9NJCNsAuWX9GIL/fqV10CwnL4qUdDMRxJNj2nFooKIgHoxtVcJvaW9xe47Fb4WyJ
	VmdtyHUuFwMn4OYjwr3mGQm0rGV+MOP/0ZGdN1nSFvSKO0QpTnFnxLLJPkrHhFkxiazJOLDgBTLeK
	D2WQdFVaanzk9tFHOD7h4yGXRQaRmyMLCVK7ef3AoWrzEV4RQrhody7g4mKu6sC9uJknotIlil1th
	u1j1yX+51dJHNBx8xXBmNUcaUSIFXJ6ZFk3pxuhfnn0Svy0Eo8HToEd8Rgn7LXEJWZunNRWSip5tk
	8mHmhvpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onMYA-006FOr-9U; Tue, 25 Oct 2022 16:13:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onMY6-006FMx-T5
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 16:13:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1726468B05; Tue, 25 Oct 2022 18:12:59 +0200 (CEST)
Date: Tue, 25 Oct 2022 18:12:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Aurelien Aptel <aaptel@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
	tariqt@nvidia.com, leon@kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
	chaitanyak@nvidia.com, smalin@nvidia.com, ogerlitz@nvidia.com,
	yorayz@nvidia.com, borisp@nvidia.com, aurelien.aptel@gmail.com,
	malin1024@gmail.com
Subject: Re: [PATCH v7 03/23] net/tls: export get_netdev_for_sock
Message-ID: <20221025161258.GC26372@lst.de>
References: <20221025135958.6242-1-aaptel@nvidia.com> <20221025135958.6242-4-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025135958.6242-4-aaptel@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_091307_100399_13C0AD1C 
X-CRM114-Status: GOOD (  14.07  )
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

Any reason to not just fold netdev_sk_get_lowest_dev into
get_netdev_for_sock?

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index eddf8ee270e74..10f47b157c683 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3040,8 +3040,7 @@ int init_dummy_netdev(struct net_device *dev);
 struct net_device *netdev_get_xmit_slave(struct net_device *dev,
 					 struct sk_buff *skb,
 					 bool all_slaves);
-struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
-					    struct sock *sk);
+struct net_device *get_netdev_for_sock(struct sock *sk);
 struct net_device *dev_get_by_index(struct net *net, int ifindex);
 struct net_device *__dev_get_by_index(struct net *net, int ifindex);
 struct net_device *dev_get_by_index_rcu(struct net *net, int ifindex);
diff --git a/net/core/dev.c b/net/core/dev.c
index 3be256051e99b..c180773e3dfd4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8165,27 +8165,27 @@ static struct net_device *netdev_sk_get_lower_dev(struct net_device *dev,
 }
 
 /**
- * netdev_sk_get_lowest_dev - Get the lowest device in chain given device and socket
- * @dev: device
+ * netdev_sk_get_lowest_dev - Get the lowest device in socket
  * @sk: the socket
  *
- * %NULL is returned if no lower device is found.
+ * Assumes that the socket is already connected.
+ * Returns the lower device or %NULL if no lower device is found.
  */
-
-struct net_device *netdev_sk_get_lowest_dev(struct net_device *dev,
-					    struct sock *sk)
+struct net_device *get_netdev_for_sock(struct sock *sk)
 {
-	struct net_device *lower;
+	struct dst_entry *dst = sk_dst_get(sk);
+	struct net_device *dev, *lower;
 
-	lower = netdev_sk_get_lower_dev(dev, sk);
-	while (lower) {
+	if (unlikely(!dst))
+		return NULL;
+	dev = dst->dev;
+	while ((lower = netdev_sk_get_lower_dev(dev, sk)))
 		dev = lower;
-		lower = netdev_sk_get_lower_dev(dev, sk);
-	}
-
+	dev_hold(dev);
+	dst_release(dst);
 	return dev;
 }
-EXPORT_SYMBOL(netdev_sk_get_lowest_dev);
+EXPORT_SYMBOL_GPL(get_netdev_for_sock);
 
 static void netdev_adjacent_add_links(struct net_device *dev)
 {
diff --git a/net/tls/tls_device.c b/net/tls/tls_device.c
index a03d66046ca32..1eb92dab4f34f 100644
--- a/net/tls/tls_device.c
+++ b/net/tls/tls_device.c
@@ -120,22 +120,6 @@ static void tls_device_queue_ctx_destruction(struct tls_context *ctx)
 		tls_device_free_ctx(ctx);
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

