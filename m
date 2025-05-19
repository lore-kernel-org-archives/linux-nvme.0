Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55023C2D0CD
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 19:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZEb4bpHpA18iTlcJwGoqSTfUShPEtFVLTGTCGUo4Sf4=; b=KJvFfFvCumFLxv2Ts0WLorJvEv
	qjTIgBZWlwQBUfuQcjTMgeIjbLXI/gpxwVXkkQnd9UNX5JRVw6JD1Mr6CsZFp41z9KAw+b3kI6NfB
	X1MUXj0IxLJ1nmzIZAtZkLRACPWcw42fr/ZvsVwTRYN4tVJgF2GpRB7QZcDR4P9HigVj+uYr6SrUD
	7U0w+PWSo2DnXCikCwypJ3WNHJbtsKTdcCY/0zmpn+jQyc5gls+lSZHnJP4QXBGGDQeuRqtDwchP5
	MW6LkXt6MKyCgR+nyPDfGZGqubgl7HmeWjHivp8OmtKoWNcgwwcjdTSrpn7RTH2X+Hy/tMIXceyK8
	d2NXE4WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH6a4-0000000AHds-0Wu5;
	Mon, 19 May 2025 19:55:24 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH4ec-0000000A1ce-001y
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 17:51:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 34FF6A4E59E;
	Mon, 19 May 2025 17:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91366C4CEF1;
	Mon, 19 May 2025 17:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747677116;
	bh=X8dbjSHr2U6lQaQcWmgJZbE8GedZCYfvJMCrGbZTikY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mlY9EiFojWR3LwToOtmFKpKqswni2sODtLWJbQOJSCZyOK3D+ckVrbbhOgVWs2kBC
	 jVpl3rCL7kbqWbN28BQ2XXqsRU7IqUu4cAsoE2sOZfX5RL6xi/vudcPhnJa6MNKo9r
	 U1VvGoA6aSxgLm5UbwrFmZBSjHsroSYw01xEjP76EVYxZIRBLF6BzDT1HzmskXtGUq
	 GMCVwoYXrWKjOFGvTjVQUKtIVaAwLDLeM98s1sd7Cm+3lrVAajh7hQSnZo2SWEcyQa
	 igBEz3Dvjktpl3HwTfoRnmTv+fZ/uDuSFGVIzEkK3+KNNL2F6DrrKLX5qCsxBL9YDU
	 Xk/2zo2X+V+vw==
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
Subject: [PATCH v2 01/10] net: introduce CONFIG_NET_CRC32C
Date: Mon, 19 May 2025 10:50:03 -0700
Message-ID: <20250519175012.36581-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519175012.36581-1-ebiggers@kernel.org>
References: <20250519175012.36581-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_105158_105708_8A17D8B5 
X-CRM114-Status: GOOD (  11.23  )
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
index 202cc595e5e6f..5b71a52987d33 100644
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
index fccf2167b2352..d93bee5eb5d8c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3594,10 +3594,11 @@ int skb_checksum_help(struct sk_buff *skb)
 out:
 	return ret;
 }
 EXPORT_SYMBOL(skb_checksum_help);
 
+#ifdef CONFIG_NET_CRC32C
 int skb_crc32c_csum_help(struct sk_buff *skb)
 {
 	__le32 crc32c_csum;
 	int ret = 0, offset, start;
 
@@ -3633,10 +3634,11 @@ int skb_crc32c_csum_help(struct sk_buff *skb)
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
index d18a72df3654e..3669ba3518563 100644
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

base-commit: a8ae8a0e848e3506c95e45e7cb6e640502495f1a
-- 
2.49.0


