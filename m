Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CDFC54799
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 19:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GjqesA6f2+d9K6/Azq45L8qHEeHhLGflIKntvNiCtbI=; b=Hv2Irnk9Z4w7VGCz+RjkraF8Mo
	GySbJQSadqeu9HQdwcuTgQtnHI7VMWVUtzDFR5UH8pUEC6f1kR1M9z2ZemxrCx0NVxGZTCummaMeg
	Ya2exzYGS9dfefEFh+rxtE1X/W6/58+jvnc9FzyZXrgvGES9yUTwz9f0/rcPYODSQORptkJ9nxyUa
	psuqNd3sK6ZeWAmqRWGXK4WaZFwzVv9l6kWTpaqJ4VDctaZ7ZgpGvADc6Hjzrmof+rrPGyZL6FWKp
	KCAcWF3OVXUWVHkhXv6A9rIda8JPCFm5IspTg+sfFD2CdVqbgyh+wN67uBfsrkF1CpBSFPoWAP91w
	aU8ljB+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH6a5-0000000AHfU-1RvG;
	Mon, 19 May 2025 19:55:25 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH4ed-0000000A1e1-18dQ
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 17:52:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7BB075C5581;
	Mon, 19 May 2025 17:49:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D035C4CEF5;
	Mon, 19 May 2025 17:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747677118;
	bh=QEzyKZNR9hWHlDwB+VK93Xjz4V0tHxsun14G4o7oHVg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cxsxIwb4LAiva1ctYTyPPgd7NXR/uYyeTelWi32wxcysl7WfQhp5EizqLbpHLCUUN
	 xciri2xmBTGIy2ZB41A+Dt0jJAV0GDeKgudaztvEmhfoni7vBQZjdawtU87+4nRegy
	 L8tYKVgC4MLoP1ad5ft/YlCJ5xNqtcYwmj+PhMfHTm7jYTwfW0qfVLL/8HGrsOfAfj
	 xjlCeoDtGe919W5IFcvTotuafAgszX1zBtf2yzlRHeHhqskjdUkvQQWvhFbx1QPSfB
	 3xVK+t3a0uy2pJTiBMSFClUR6kKtOD7Jl1Hy6czJBZ787QSdCB2I9bTK/ziCESuaOY
	 oJfXzxczVvYBg==
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
Subject: [PATCH v2 05/10] sctp: use skb_crc32c() instead of __skb_checksum()
Date: Mon, 19 May 2025 10:50:07 -0700
Message-ID: <20250519175012.36581-6-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519175012.36581-1-ebiggers@kernel.org>
References: <20250519175012.36581-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_105159_396437_60AAF155 
X-CRM114-Status: GOOD (  17.67  )
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

Make sctp_compute_cksum() just use the new function skb_crc32c(),
instead of calling __skb_checksum() with a skb_checksum_ops struct that
does CRC32C.  This is faster and simpler.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/net/sctp/checksum.h | 29 +++--------------------------
 net/netfilter/Kconfig       |  4 ++--
 net/netfilter/ipvs/Kconfig  |  2 +-
 net/openvswitch/Kconfig     |  2 +-
 net/sched/Kconfig           |  2 +-
 net/sctp/Kconfig            |  1 -
 net/sctp/offload.c          |  1 -
 7 files changed, 8 insertions(+), 33 deletions(-)

diff --git a/include/net/sctp/checksum.h b/include/net/sctp/checksum.h
index 291465c258102..654d37ec04029 100644
--- a/include/net/sctp/checksum.h
+++ b/include/net/sctp/checksum.h
@@ -13,51 +13,28 @@
  *
  * Written or modified by:
  *    Dinakaran Joseph
  *    Jon Grimm <jgrimm@us.ibm.com>
  *    Sridhar Samudrala <sri@us.ibm.com>
- *
- * Rewritten to use libcrc32c by:
  *    Vlad Yasevich <vladislav.yasevich@hp.com>
  */
 
 #ifndef __sctp_checksum_h__
 #define __sctp_checksum_h__
 
 #include <linux/types.h>
 #include <linux/sctp.h>
-#include <linux/crc32c.h>
-#include <linux/crc32.h>
-
-static inline __wsum sctp_csum_update(const void *buff, int len, __wsum sum)
-{
-	return (__force __wsum)crc32c((__force __u32)sum, buff, len);
-}
-
-static inline __wsum sctp_csum_combine(__wsum csum, __wsum csum2,
-				       int offset, int len)
-{
-	return (__force __wsum)crc32c_combine((__force __u32)csum,
-					      (__force __u32)csum2, len);
-}
-
-static const struct skb_checksum_ops sctp_csum_ops = {
-	.update  = sctp_csum_update,
-	.combine = sctp_csum_combine,
-};
 
 static inline __le32 sctp_compute_cksum(const struct sk_buff *skb,
 					unsigned int offset)
 {
 	struct sctphdr *sh = (struct sctphdr *)(skb->data + offset);
 	__le32 old = sh->checksum;
-	__wsum new;
+	u32 new;
 
 	sh->checksum = 0;
-	new = ~__skb_checksum(skb, offset, skb->len - offset, ~(__wsum)0,
-			      &sctp_csum_ops);
+	new = ~skb_crc32c(skb, offset, skb->len - offset, ~0);
 	sh->checksum = old;
-
-	return cpu_to_le32((__force __u32)new);
+	return cpu_to_le32(new);
 }
 
 #endif /* __sctp_checksum_h__ */
diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index 3b2183fc7e563..2560416218d07 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -210,11 +210,11 @@ config NF_CT_PROTO_GRE
 
 config NF_CT_PROTO_SCTP
 	bool 'SCTP protocol connection tracking support'
 	depends on NETFILTER_ADVANCED
 	default y
-	select CRC32
+	select NET_CRC32C
 	help
 	  With this option enabled, the layer 3 independent connection
 	  tracking code will be able to do state tracking on SCTP connections.
 
 	  If unsure, say Y.
@@ -473,11 +473,11 @@ config NETFILTER_SYNPROXY
 
 endif # NF_CONNTRACK
 
 config NF_TABLES
 	select NETFILTER_NETLINK
-	select CRC32
+	select NET_CRC32C
 	tristate "Netfilter nf_tables support"
 	help
 	  nftables is the new packet classification framework that intends to
 	  replace the existing {ip,ip6,arp,eb}_tables infrastructure. It
 	  provides a pseudo-state machine with an extensible instruction-set
diff --git a/net/netfilter/ipvs/Kconfig b/net/netfilter/ipvs/Kconfig
index 8c5b1fe12d078..c203252e856d8 100644
--- a/net/netfilter/ipvs/Kconfig
+++ b/net/netfilter/ipvs/Kconfig
@@ -103,11 +103,11 @@ config	IP_VS_PROTO_AH
 	  This option enables support for load balancing AH (Authentication
 	  Header) transport protocol. Say Y if unsure.
 
 config  IP_VS_PROTO_SCTP
 	bool "SCTP load balancing support"
-	select CRC32
+	select NET_CRC32C
 	help
 	  This option enables support for load balancing SCTP transport
 	  protocol. Say Y if unsure.
 
 comment "IPVS scheduler"
diff --git a/net/openvswitch/Kconfig b/net/openvswitch/Kconfig
index 5481bd561eb41..e6aaee92dba48 100644
--- a/net/openvswitch/Kconfig
+++ b/net/openvswitch/Kconfig
@@ -9,12 +9,12 @@ config OPENVSWITCH
 	depends on !NF_CONNTRACK || \
 		   (NF_CONNTRACK && ((!NF_DEFRAG_IPV6 || NF_DEFRAG_IPV6) && \
 				     (!NF_NAT || NF_NAT) && \
 				     (!NETFILTER_CONNCOUNT || NETFILTER_CONNCOUNT)))
 	depends on PSAMPLE || !PSAMPLE
-	select CRC32
 	select MPLS
+	select NET_CRC32C
 	select NET_MPLS_GSO
 	select DST_CACHE
 	select NET_NSH
 	select NF_CONNTRACK_OVS if NF_CONNTRACK
 	select NF_NAT_OVS if NF_NAT
diff --git a/net/sched/Kconfig b/net/sched/Kconfig
index 9f0b3f943fca8..ad914d2b2e221 100644
--- a/net/sched/Kconfig
+++ b/net/sched/Kconfig
@@ -794,11 +794,11 @@ config NET_ACT_SKBEDIT
 	  module will be called act_skbedit.
 
 config NET_ACT_CSUM
 	tristate "Checksum Updating"
 	depends on NET_CLS_ACT && INET
-	select CRC32
+	select NET_CRC32C
 	help
 	  Say Y here to update some common checksum after some direct
 	  packet alterations.
 
 	  To compile this code as a module, choose M here: the
diff --git a/net/sctp/Kconfig b/net/sctp/Kconfig
index 3669ba3518563..24d5a35ce894a 100644
--- a/net/sctp/Kconfig
+++ b/net/sctp/Kconfig
@@ -5,11 +5,10 @@
 
 menuconfig IP_SCTP
 	tristate "The SCTP Protocol"
 	depends on INET
 	depends on IPV6 || IPV6=n
-	select CRC32
 	select CRYPTO
 	select CRYPTO_HMAC
 	select CRYPTO_SHA1
 	select NET_CRC32C
 	select NET_UDP_TUNNEL
diff --git a/net/sctp/offload.c b/net/sctp/offload.c
index 502095173d885..e6f863c031b4c 100644
--- a/net/sctp/offload.c
+++ b/net/sctp/offload.c
@@ -109,11 +109,10 @@ int __init sctp_offload_init(void)
 
 	ret = inet6_add_offload(&sctp6_offload, IPPROTO_SCTP);
 	if (ret)
 		goto ipv4;
 
-	crc32c_csum_stub = &sctp_csum_ops;
 	return ret;
 
 ipv4:
 	inet_del_offload(&sctp_offload, IPPROTO_SCTP);
 out:
-- 
2.49.0


