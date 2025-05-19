Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62047C3ABDD
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 19:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QqLH5mogqTsi2vyu75aSR0HpeRpxgMsyl3ijf3vYbAw=; b=O1auQq2ROKdZMWzryACBqSCpm+
	YqxepQxgtDCUFhAZEvN1lFhRAb6RzwOPOfPan0MsNccSCSYzif0qgoWLq9yX6BSOPSMwwfbwsD55i
	viwPUkRYuyd1bxf/AuEF4y6vT0Q0zRtQJEC3pe/WviFIbfJy2xuMZCe9DvG/+UYvwnD0k2M00KdEN
	1QIQn68EgbJAE6Kb4wtVt9GEpMAqy/7tV7NPjtheLYUSv9JKyRAAucU4fkN3t3DxBVuSVd4OPznpM
	Av+uYrFFQFIejzmDqBmXZJEzCkg5b4NZxmYyVT+5KP0zErNY8HNrtgXVFGV+0LA+JIWqSGkMTmZy1
	Cds91IXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH6a6-0000000AHgZ-2jzO;
	Mon, 19 May 2025 19:55:26 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uH4ee-0000000A1ef-0uHE
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 17:52:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 871C1A4E5DF;
	Mon, 19 May 2025 17:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1503EC4CEED;
	Mon, 19 May 2025 17:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747677119;
	bh=Oo53xf+vPT0XtWshqsuhuWmUJl5Op5w9Tt26Wx4wMsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S0fI/+ymiRyCNifQz3w6CL5IrooEnfvl2XmRIp3GzU7Uz8tECZaFU1C7/yjE2x3Rx
	 mASFqRafI7kBpTNDdValHZy34XNWOpD0q3sotIZDeRlQDTNXCCeV4eqW8z0W6q0z+F
	 SDZwVRBuBKNvMa+bbsxIGADFCF44JFhMEncbJGaHI0xKPFWTyKh1x89MqZNqMipAcp
	 Qpe3UCxUO1Y1C2PnUYb1CjDycIIx8k1f80NKyxJEfIcwyv/7qEZYJsR4DndwJVxDd7
	 bP+Kl7+W4R3CAIxaQB0LZpz7AMzodl6esgFeBDGYtcrhKTdggH3HQN2XJAHhyUJ9YA
	 yCj6Pu/KIIdYQ==
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
Subject: [PATCH v2 07/10] lib/crc32: remove unused support for CRC32C combination
Date: Mon, 19 May 2025 10:50:09 -0700
Message-ID: <20250519175012.36581-8-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519175012.36581-1-ebiggers@kernel.org>
References: <20250519175012.36581-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250519_105200_392943_644B2E54 
X-CRM114-Status: GOOD (  12.96  )
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

crc32c_combine() and crc32c_shift() are no longer used (except by the
KUnit test that tests them), and their current implementation is very
slow.  Remove them.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 include/linux/crc32.h | 23 -----------------------
 lib/crc32.c           |  6 ------
 lib/tests/crc_kunit.c |  6 ------
 3 files changed, 35 deletions(-)

diff --git a/include/linux/crc32.h b/include/linux/crc32.h
index 69c2e8bb37829..7f7d0be8a0acc 100644
--- a/include/linux/crc32.h
+++ b/include/linux/crc32.h
@@ -74,33 +74,10 @@ u32 crc32_le_shift(u32 crc, size_t len);
 static inline u32 crc32_le_combine(u32 crc1, u32 crc2, size_t len2)
 {
 	return crc32_le_shift(crc1, len2) ^ crc2;
 }
 
-u32 crc32c_shift(u32 crc, size_t len);
-
-/**
- * crc32c_combine - Combine two crc32c check values into one. For two sequences
- *		    of bytes, seq1 and seq2 with lengths len1 and len2, crc32c()
- *		    check values were calculated for each, crc1 and crc2.
- *
- * @crc1: crc32c of the first block
- * @crc2: crc32c of the second block
- * @len2: length of the second block
- *
- * Return: The crc32c() check value of seq1 and seq2 concatenated, requiring
- *	   only crc1, crc2, and len2. Note: If seq_full denotes the concatenated
- *	   memory area of seq1 with seq2, and crc_full the crc32c() value of
- *	   seq_full, then crc_full == crc32c_combine(crc1, crc2, len2) when
- *	   crc_full was seeded with the same initializer as crc1, and crc2 seed
- *	   was 0. See also crc_combine_test().
- */
-static inline u32 crc32c_combine(u32 crc1, u32 crc2, size_t len2)
-{
-	return crc32c_shift(crc1, len2) ^ crc2;
-}
-
 #define crc32(seed, data, length)  crc32_le(seed, (unsigned char const *)(data), length)
 
 /*
  * Helpers for hash table generation of ethernet nics:
  *
diff --git a/lib/crc32.c b/lib/crc32.c
index fddd424ff2245..ade48bbb00834 100644
--- a/lib/crc32.c
+++ b/lib/crc32.c
@@ -117,16 +117,10 @@ u32 crc32_le_shift(u32 crc, size_t len)
 {
 	return crc32_generic_shift(crc, len, CRC32_POLY_LE);
 }
 EXPORT_SYMBOL(crc32_le_shift);
 
-u32 crc32c_shift(u32 crc, size_t len)
-{
-	return crc32_generic_shift(crc, len, CRC32C_POLY_LE);
-}
-EXPORT_SYMBOL(crc32c_shift);
-
 u32 crc32_be_base(u32 crc, const u8 *p, size_t len)
 {
 	while (len--)
 		crc = (crc << 8) ^ crc32table_be[(crc >> 24) ^ *p++];
 	return crc;
diff --git a/lib/tests/crc_kunit.c b/lib/tests/crc_kunit.c
index 585c48b65cefd..064c2d5815579 100644
--- a/lib/tests/crc_kunit.c
+++ b/lib/tests/crc_kunit.c
@@ -389,21 +389,15 @@ static void crc32_be_benchmark(struct kunit *test)
 static u64 crc32c_wrapper(u64 crc, const u8 *p, size_t len)
 {
 	return crc32c(crc, p, len);
 }
 
-static u64 crc32c_combine_wrapper(u64 crc1, u64 crc2, size_t len2)
-{
-	return crc32c_combine(crc1, crc2, len2);
-}
-
 static const struct crc_variant crc_variant_crc32c = {
 	.bits = 32,
 	.le = true,
 	.poly = 0x82f63b78,
 	.func = crc32c_wrapper,
-	.combine_func = crc32c_combine_wrapper,
 };
 
 static void crc32c_test(struct kunit *test)
 {
 	crc_test(test, &crc_variant_crc32c);
-- 
2.49.0


