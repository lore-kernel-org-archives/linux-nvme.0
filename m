Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692C8C3ABCE
	for <linux-nvme@archiver.kernel.org>; Sun, 11 May 2025 00:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l3Y/BaxX6+vhQdBFQDlhAZzhb5aBQZgvFAcHMHps/Hc=; b=mTlO7CTmh18MUueWOKzbHPRR+2
	o8x65+oZfpHeOrnVyQ2N2beX6aydM8DMRh20pXD47HXzJvkyl316320fsENBwhNbg8r1oiGnfo4In
	7kBX9kC0ble+fVc/ceAcNnWqLkea3NHQuEnJ5mccrY7MS342rNjp5RF4h5vRCrU/3pZzF8ZZUc9LT
	mUwgR19QbUGzxOVfyl7vtWrIuDVjyzz/Xf8JvclwsCasBda2+zUoNlCwOo8YbiDwKzERwcO0+IdWs
	U7OsQwUCf3Awx2Gz+27WcKDM1G4nXDO77fqBiSCDi1ywGQ/e2eKC8q8MusHWDv3XDlmlIkuuJ9HVi
	NetedZsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDul8-00000006Xau-0oNV;
	Sun, 11 May 2025 00:41:38 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDul1-00000006XWy-1HNZ
	for linux-nvme@lists.infradead.org;
	Sun, 11 May 2025 00:41:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 0C717A4C672;
	Sun, 11 May 2025 00:41:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A479BC4CEE7;
	Sun, 11 May 2025 00:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746924089;
	bh=y+V5sqoQHeK8LApRzwTSNGThMks43WhP9Yn3FOEf8Eo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l0y1n+I7LS4gxWUEW9UGJENJf8q05kPt14AA+vOjXvPSld21FBsxDTrngmhW6ds9N
	 tNT/l2LtTU/Xb2/E1IMyJa1O1Ik3Tq22x9etKzp4elyOyULegjzrqxh8LqsSveZmoE
	 5aJWy990axz8FFX4bpgK333gBTiL63N4H+JBq2aP9gLpKve61soSVwMvbQBHeHilEe
	 E06Q51UbJiuMdrNEc2Ccg2Y5ES8nPgRT2hg7KiZViZ1OS4qbHLPIDxNR0xzOz9qssQ
	 x4w8YtgvS0wTrAiRvj8S5qUevItSur4VK5ulS/MjwAi195cZHdwXXxlyElSlFI6JOQ
	 IOI1ZpNS9qCaw==
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
Subject: [PATCH net-next 01/10] net: introduce CONFIG_NET_CRC32C
Date: Sat, 10 May 2025 17:41:01 -0700
Message-ID: <20250511004110.145171-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250511004110.145171-1-ebiggers@kernel.org>
References: <20250511004110.145171-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250510_174131_407131_ABF24C72 
X-CRM114-Status: GOOD (  10.05  )
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

Add a hidden kconfig symbol NET_CRC32C that will group together the
functions that calculate CRC32C checksums of packets, so that these
don't have to be built into NET-enabled kernels that don't need them.

Make skb_crc32c_csum_help() (which is called only when IP_SCTP is
enabled) conditional on this symbol, and make IP_SCTP select it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 net/Kconfig      | 4 ++++
 net/core/dev.c   | 2 ++
 net/sctp/Kconfig | 1 +
 3 files changed, 7 insertions(+)

diff --git a/net/Kconfig b/net/Kconfig
index 202cc595e5e6..5b71a52987d3 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -73,10 +73,14 @@ config NET_DEVMEM
 	depends on PAGE_POOL
 
 config NET_SHAPER
 	bool
 
+config NET_CRC32C
+	bool
+	select CRC32
+
 menu "Networking options"
 
 source "net/packet/Kconfig"
 source "net/unix/Kconfig"
 source "net/tls/Kconfig"
diff --git a/net/core/dev.c b/net/core/dev.c
index c9013632296f..51606b2d17bb 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3592,10 +3592,11 @@ int skb_checksum_help(struct sk_buff *skb)
 out:
 	return ret;
 }
 EXPORT_SYMBOL(skb_checksum_help);
 
+#ifdef CONFIG_NET_CRC32C
 int skb_crc32c_csum_help(struct sk_buff *skb)
 {
 	__le32 crc32c_csum;
 	int ret = 0, offset, start;
 
@@ -3631,10 +3632,11 @@ int skb_crc32c_csum_help(struct sk_buff *skb)
 	skb_reset_csum_not_inet(skb);
 out:
 	return ret;
 }
 EXPORT_SYMBOL(skb_crc32c_csum_help);
+#endif /* CONFIG_NET_CRC32C */
 
 __be16 skb_network_protocol(struct sk_buff *skb, int *depth)
 {
 	__be16 type = skb->protocol;
 
diff --git a/net/sctp/Kconfig b/net/sctp/Kconfig
index d18a72df3654..3669ba351856 100644
--- a/net/sctp/Kconfig
+++ b/net/sctp/Kconfig
@@ -9,10 +9,11 @@ menuconfig IP_SCTP
 	depends on IPV6 || IPV6=n
 	select CRC32
 	select CRYPTO
 	select CRYPTO_HMAC
 	select CRYPTO_SHA1
+	select NET_CRC32C
 	select NET_UDP_TUNNEL
 	help
 	  Stream Control Transmission Protocol
 
 	  From RFC 2960 <http://www.ietf.org/rfc/rfc2960.txt>.

base-commit: 0b28182c73a3d013bcabbb890dc1070a8388f55a
-- 
2.49.0


