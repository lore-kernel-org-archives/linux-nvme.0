Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1B2C3ABC9
	for <linux-nvme@archiver.kernel.org>; Sun, 11 May 2025 00:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UwSVZMo7Yv4RcXl8OCjoIE5mskAUL6md5A1ye6CNWSg=; b=UowlRk3xbCmDqkCK1q+xsc/wpo
	D9EwLzgm3J/GxamavS+FORPx3B+csIMLXnNuSzVhyRVWtCjpc4HCiKvmxOuFKt+HKoW1hXKJ0vbv6
	nYgkH2zm+ldDUv7TggEpQw6fNji4dvd5ecYvJbFr8YGwhwtcqEvu+ZJwdujDz2r7QlZwp5MmpwJJ3
	T0AjQxuVkybxdAD0THaXHD/CYICN5wYd4pBsKJHgFZqFOW3xmP9S8wdmcCHenTrce6YM6ErA+SO6k
	CMgcZK1wFQM2Q0Lir6aFRo5MN3xLEBw8djOCjsDPeYDiNwbpm+W+/qnjAicPncX9d08VlvJGV71Ul
	q9kAMWHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDulA-00000006Xc2-0ido;
	Sun, 11 May 2025 00:41:40 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDul3-00000006XY4-29jf
	for linux-nvme@lists.infradead.org;
	Sun, 11 May 2025 00:41:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 47D794A871;
	Sun, 11 May 2025 00:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CADEC4CEE2;
	Sun, 11 May 2025 00:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746924093;
	bh=IwN0x6l2VckNHXEEglHCnVHt/6hl+HXCt3jiyh026og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SJemVLpI1SUn8x/itxDunpJJSTPHgSrvU7okEl2jVOzcEmKGHFuJEYaek3TfkG/37
	 7H5LtY6qDtcPgB/uPA94WF00BzSm3cPQkSIZAy76OQ5GwjdtwAd9vD9+QFAYMruF/E
	 6PjPCY/oTm2bcITyxO5cSMwJ+s7cVi1XdM9EU76ax+ODQ8j1XEClds82ensWXTDuXz
	 JsTPrFfin6XR5bt+LvJM5U2KYo5VBaAcNqRayfiOHqTmm0VzSpIxr/jI4nAPw0n3zo
	 oXkQVutteDPHb4aVsup7jD9XMotu4BmggbwVlH3qVsiLcrJmnhOD0beWJaWp5T2TXV
	 /ztmrEfidVbJg==
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
Subject: [PATCH net-next 04/10] RDMA/siw: use skb_crc32c() instead of __skb_checksum()
Date: Sat, 10 May 2025 17:41:04 -0700
Message-ID: <20250511004110.145171-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250511004110.145171-1-ebiggers@kernel.org>
References: <20250511004110.145171-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250510_174133_576995_DEF145D8 
X-CRM114-Status: GOOD (  11.55  )
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
 drivers/infiniband/sw/siw/Kconfig |  1 +
 drivers/infiniband/sw/siw/siw.h   | 22 +---------------------
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/infiniband/sw/siw/Kconfig b/drivers/infiniband/sw/siw/Kconfig
index ae4a953e2a03..186f182b80e7 100644
--- a/drivers/infiniband/sw/siw/Kconfig
+++ b/drivers/infiniband/sw/siw/Kconfig
@@ -1,10 +1,11 @@
 config RDMA_SIW
 	tristate "Software RDMA over TCP/IP (iWARP) driver"
 	depends on INET && INFINIBAND
 	depends on INFINIBAND_VIRT_DMA
 	select CRC32
+	select NET_CRC32C
 	help
 	This driver implements the iWARP RDMA transport over
 	the Linux TCP/IP network stack. It enables a system with a
 	standard Ethernet adapter to interoperate with a iWARP
 	adapter or with another system running the SIW driver.
diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
index 385067e07faf..d9e5a2e4c471 100644
--- a/drivers/infiniband/sw/siw/siw.h
+++ b/drivers/infiniband/sw/siw/siw.h
@@ -691,33 +691,13 @@ static inline void siw_crc_oneshot(const void *data, size_t len, u8 out[4])
 	siw_crc_init(&crc);
 	siw_crc_update(&crc, data, len);
 	return siw_crc_final(&crc, out);
 }
 
-static inline __wsum siw_csum_update(const void *buff, int len, __wsum sum)
-{
-	return (__force __wsum)crc32c((__force __u32)sum, buff, len);
-}
-
-static inline __wsum siw_csum_combine(__wsum csum, __wsum csum2, int offset,
-				      int len)
-{
-	return (__force __wsum)crc32c_combine((__force __u32)csum,
-					      (__force __u32)csum2, len);
-}
-
 static inline void siw_crc_skb(struct siw_rx_stream *srx, unsigned int len)
 {
-	const struct skb_checksum_ops siw_cs_ops = {
-		.update = siw_csum_update,
-		.combine = siw_csum_combine,
-	};
-	__wsum crc = (__force __wsum)srx->mpa_crc;
-
-	crc = __skb_checksum(srx->skb, srx->skb_offset, len, crc,
-			     &siw_cs_ops);
-	srx->mpa_crc = (__force u32)crc;
+	srx->mpa_crc = skb_crc32c(srx->skb, srx->skb_offset, len, srx->mpa_crc);
 }
 
 #define siw_dbg(ibdev, fmt, ...)                                               \
 	ibdev_dbg(ibdev, "%s: " fmt, __func__, ##__VA_ARGS__)
 
-- 
2.49.0


