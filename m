Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DC3C3ABDD
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 19:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MGKI6/bvQ9sr9xE9lPYN2q33gvI2DNbJp6LGVw3ywoA=; b=T3OyU0Na/z6uKJ88LoDGkwU3W/
	vHYx1wXNCbvTG25qLy7kQBV/tlbFNbD0cXcSvTNsG4BZUXxhEU6Z2ZGHDN2jbjvhYhwUilMW8BHNR
	OvEtW+mSSCDHeparudIHtxhi26cB2MoojYE+VBi2K6LNCh2AVRi0hJlkCKmAs9qtNgyrfTMnTy4wt
	reme1wu/Ty/LDP2E/0v9TfPuA1xWw7hBHpHuJTwNGiDee88I+O21jw8A0Lh7Sz9JOM93jtEpamKGy
	CU3gY69lRXnckLGW9cKiNVom/XyMADyMo8Jz4Tj/cquFTaIjkTeBpFDfJNRGYgB/+LlgKHn1L+EmV
	t+2h6pmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH6a2-0000000AHdT-3l42;
	Mon, 19 May 2025 19:55:22 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH4ec-0000000A1dQ-2PDG
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 17:51:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 01A8B614B6;
	Mon, 19 May 2025 17:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63DBFC4CEED;
	Mon, 19 May 2025 17:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747677117;
	bh=CZeHbIh3l9QIcf9yTA+bjElzQVy8LoKCuirQSGJR4qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g+NY6IHX2iV5SsY3RZYOow0Nztm2bCj7yjW+42uNiNSFXbjFwzEOzIa1yHobNoIhb
	 Jv+foKP87FEXKxWolLkrodJKpVSjv4B9H6I+GRogdRK2Z4nuyzhOckT+8nJ5ZDO6u6
	 bgTAfn5MWjHJOkFPnE22alDEqU8YZ7gFez4x/tPKtOifW0lsdtxFP/1nwDGl75C34T
	 DU6mk33vfWRZVLao7AKYFosr0dpXFaWcwaOcY/RaNbU9mKu+Wae54MLODBQcPKkMR9
	 oX6rrbKA+6GmCjpGtO2UdFB+En5qzUkjpnNSabxBiQDMB3ByfHC5K7WlUMoOQKfHsJ
	 uP2ZUx4JCFUoA==
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
Subject: [PATCH v2 03/10] net: use skb_crc32c() in skb_crc32c_csum_help()
Date: Mon, 19 May 2025 10:50:05 -0700
Message-ID: <20250519175012.36581-4-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519175012.36581-1-ebiggers@kernel.org>
References: <20250519175012.36581-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Instead of calling __skb_checksum() with a skb_checksum_ops struct that
does CRC32C, just call the new function skb_crc32c().  This is faster
and simpler.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 net/core/dev.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index d93bee5eb5d8c..430b3d3240d8f 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3597,11 +3597,11 @@ int skb_checksum_help(struct sk_buff *skb)
 EXPORT_SYMBOL(skb_checksum_help);
 
 #ifdef CONFIG_NET_CRC32C
 int skb_crc32c_csum_help(struct sk_buff *skb)
 {
-	__le32 crc32c_csum;
+	u32 crc;
 	int ret = 0, offset, start;
 
 	if (skb->ip_summed != CHECKSUM_PARTIAL)
 		goto out;
 
@@ -3625,14 +3625,12 @@ int skb_crc32c_csum_help(struct sk_buff *skb)
 
 	ret = skb_ensure_writable(skb, offset + sizeof(__le32));
 	if (ret)
 		goto out;
 
-	crc32c_csum = cpu_to_le32(~__skb_checksum(skb, start,
-						  skb->len - start, ~(__u32)0,
-						  crc32c_csum_stub));
-	*(__le32 *)(skb->data + offset) = crc32c_csum;
+	crc = ~skb_crc32c(skb, start, skb->len - start, ~0);
+	*(__le32 *)(skb->data + offset) = cpu_to_le32(crc);
 	skb_reset_csum_not_inet(skb);
 out:
 	return ret;
 }
 EXPORT_SYMBOL(skb_crc32c_csum_help);
-- 
2.49.0


