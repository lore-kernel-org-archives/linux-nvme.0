Return-Path: <SRS0=B4mB=DH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FD0C4727C
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 16:21:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0015D2072E
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Sep 2020 16:21:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="xSsWBUNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0015D2072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5+uowtHlxjM87SLr93MZlIvOsNZybtcjmaaKwSNYQmE=; b=xSsWBUNCJn86JZxXuP12MFMN0
	fdkmTs236HsGb3yMEFwc5ltnsXm8If8WAmB2PFerGWDDPhqCqkR+AYptSw7GG/mYsc5LjDhWodAvJ
	SqyT4f/yxn2Gd0dERGQ6D8L4OFHD3WDMm+e00ln2UMHA0ChsTdojQW8o/PQML3Yso2jRM0WTOjvCV
	mmMYhBlBhJ2qe3/YRlLzCw7uSBnJeaNuEoGfiQR9BiXzSWXYC7iEAZXvbvlALWbsX+HBTlJmVRmie
	bCoJedx78Dbs7CA/emPyj60SqxwFQLm1jymgGfx6ZluEHmeaDQl5NJRPl7dr8kV3TliUgGrEXUIqc
	aSWH2OoPw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kNeqy-0002ch-A9; Wed, 30 Sep 2020 16:21:16 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kNeqI-0002Ls-38
 for linux-nvme@lists.infradead.org; Wed, 30 Sep 2020 16:20:39 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 borisp@mellanox.com) with SMTP; 30 Sep 2020 19:20:27 +0300
Received: from gen-l-vrt-133.mtl.labs.mlnx. (gen-l-vrt-133.mtl.labs.mlnx
 [10.237.11.160])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 08UGKR2E032498;
 Wed, 30 Sep 2020 19:20:27 +0300
From: Boris Pismenny <borisp@mellanox.com>
To: kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org,
 viro@zeniv.linux.org.uk, edumazet@google.com
Subject: [PATCH net-next RFC v1 03/10] net: Introduce crc offload for tcp ddp
 ulp
Date: Wed, 30 Sep 2020 19:20:03 +0300
Message-Id: <20200930162010.21610-4-borisp@mellanox.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200930162010.21610-1-borisp@mellanox.com>
References: <20200930162010.21610-1-borisp@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200930_122034_633520_FBB33129 
X-CRM114-Status: GOOD (  17.27  )
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

This commit itroduces support for CRC offload to direct data placement
ULP on the receive side. Both DDP and CRC share a common API to
initialize the offload for a TCP socket. But otherwise, both can
be executed independently.

On the receive side, CRC offload requires a new SKB bit that
indicates that no CRC error was encountered while processing this packet.
If all packets of a ULP message have this bit set, then the CRC
verification for the message can be skipped, as hardware already checked
it.

The following patches will set and use this bit to perform NVME-TCP
CRC offload.

A subsequent series, will add NVMe-TCP transmit side CRC support.

Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Ben Ben-Ishay <benishay@mellanox.com>
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Yoray Zack <yorayz@mellanox.com>
---
 include/linux/netdev_features.h | 2 ++
 include/linux/skbuff.h          | 4 ++++
 net/Kconfig                     | 8 ++++++++
 net/ethtool/common.c            | 1 +
 net/ipv4/tcp_input.c            | 7 +++++++
 net/ipv4/tcp_ipv4.c             | 3 +++
 net/ipv4/tcp_offload.c          | 3 +++
 7 files changed, 28 insertions(+)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index a0074b244372..27001f5c0be1 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -85,6 +85,7 @@ enum {
 
 	NETIF_F_HW_MACSEC_BIT,		/* Offload MACsec operations */
 	NETIF_F_HW_TCP_DDP_BIT,		/* TCP direct data placement offload */
+	NETIF_F_HW_TCP_DDP_CRC_BIT,	/* TCP DDP CRC offload */
 
 	/*
 	 * Add your fresh new feature above and remember to update
@@ -159,6 +160,7 @@ enum {
 #define NETIF_F_GSO_FRAGLIST	__NETIF_F(GSO_FRAGLIST)
 #define NETIF_F_HW_MACSEC	__NETIF_F(HW_MACSEC)
 #define NETIF_F_HW_TCP_DDP	__NETIF_F(HW_TCP_DDP)
+#define NETIF_F_HW_TCP_DDP_CRC	__NETIF_F(HW_TCP_DDP_CRC)
 
 /* Finds the next feature with the highest number of the range of start till 0.
  */
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 04a18e01b362..0530d849ebf2 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -858,6 +858,10 @@ struct sk_buff {
 #ifdef CONFIG_TLS_DEVICE
 	__u8			decrypted:1;
 #endif
+#ifdef CONFIG_TCP_DDP_CRC
+	__u8                    ddp_crc:1;
+#endif
+
 
 #ifdef CONFIG_NET_SCHED
 	__u16			tc_index;	/* traffic control index */
diff --git a/net/Kconfig b/net/Kconfig
index 346e9fa7a6ec..7891b4380e56 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -468,6 +468,14 @@ config TCP_DDP
 	  NVMe-TCP/iSCSI, to request the NIC to place TCP payload data
 	  of a command response directly into kernel pages.
 
+config TCP_DDP_CRC
+	bool "TCP direct data placement CRC offload"
+	default n
+	help
+	  Direct Data Placement (DDP) CRC32C offload for TCP enables ULP, such as
+	  NVMe-TCP/iSCSI, to request the NIC to calculate/verify the data digest
+	  of commands as they go through the NIC. Thus avoiding the costly
+	  per-byte overhead.
 
 endif   # if NET
 
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index a2ff7a4a6bbf..4941670dd25d 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -69,6 +69,7 @@ const char netdev_features_strings[NETDEV_FEATURE_COUNT][ETH_GSTRING_LEN] = {
 	[NETIF_F_GRO_FRAGLIST_BIT] =	 "rx-gro-list",
 	[NETIF_F_HW_MACSEC_BIT] =	 "macsec-hw-offload",
 	[NETIF_F_HW_TCP_DDP_BIT] =	 "tcp-ddp-offload",
+	[NETIF_F_HW_TCP_DDP_CRC_BIT] =	 "tcp-ddp-crc-offload",
 };
 
 const char
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index f7b3e37d2198..f8e1e8ebef2c 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5099,6 +5099,9 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 		memcpy(nskb->cb, skb->cb, sizeof(skb->cb));
 #ifdef CONFIG_TLS_DEVICE
 		nskb->decrypted = skb->decrypted;
+#endif
+#ifdef CONFIG_TCP_DDP_CRC
+		nskb->ddp_crc = skb->ddp_crc;
 #endif
 		TCP_SKB_CB(nskb)->seq = TCP_SKB_CB(nskb)->end_seq = start;
 		if (list)
@@ -5132,6 +5135,10 @@ tcp_collapse(struct sock *sk, struct sk_buff_head *list, struct rb_root *root,
 #ifdef CONFIG_TLS_DEVICE
 				if (skb->decrypted != nskb->decrypted)
 					goto end;
+#endif
+#ifdef CONFIG_TCP_DDP_CRC
+				if (skb->ddp_crc != nskb->ddp_crc)
+					goto end;
 #endif
 			}
 		}
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index ace48b2790ff..2693029e6ee7 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1791,6 +1791,9 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb)
 	      TCP_SKB_CB(skb)->tcp_flags) & (TCPHDR_ECE | TCPHDR_CWR)) ||
 #ifdef CONFIG_TLS_DEVICE
 	    tail->decrypted != skb->decrypted ||
+#endif
+#ifdef CONFIG_TCP_DDP_CRC
+	    tail->ddp_crc != skb->ddp_crc ||
 #endif
 	    thtail->doff != th->doff ||
 	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index e09147ac9a99..39f5f0bcf181 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -262,6 +262,9 @@ struct sk_buff *tcp_gro_receive(struct list_head *head, struct sk_buff *skb)
 #ifdef CONFIG_TLS_DEVICE
 	flush |= p->decrypted ^ skb->decrypted;
 #endif
+#ifdef CONFIG_TCP_DDP_CRC
+	flush |= p->ddp_crc ^ skb->ddp_crc;
+#endif
 
 	if (flush || skb_gro_receive(p, skb)) {
 		mss = 1;
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
