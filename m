Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7F6CCF9E9
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 10:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HbulqRf/JzdfAl/dtv+qftIvyvV8wiDVdKN2RHYy4TQ=; b=vZNeJtgqhaq1BWpVmfTfOebY8x
	ckPqPmU9oOM/JFf4+IgzKrDJnq2ZtGCfUTn5DZSH+Tc8t6b5WAm5BInDxESigx2VZjE6GWQ74GlIP
	6s8QeIu5mmxn9DyPlTtPQQ7tAwQJ+YUoTyXB/Y3+WI9Tf/XKsZkvL63Aa69s0MCb/6RqfPJ66cCjd
	kzQQeiCnH2w97PkcLzkzA0ZWFIjq454wGA6PHDTK8byr2H7ayYD3NMr1wF06LpslIX90hove7ubbg
	/kMZXD0MoHKrnyoajX6yRlqfYJnA7ZpHGyY2L9VQOp+udvDht7UWRbyjML5LiqGlYVHcYz2bevpNV
	unbsodbQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE3Ik-00000000hed-06xB;
	Wed, 29 Oct 2025 10:21:10 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE3Ih-00000000hdd-4BnV
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 10:21:09 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-7a226a0798cso5871945b3a.2
        for <linux-nvme@lists.infradead.org>; Wed, 29 Oct 2025 03:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1761733267; x=1762338067; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HbulqRf/JzdfAl/dtv+qftIvyvV8wiDVdKN2RHYy4TQ=;
        b=BP7/mXXQPgKjnDpc15YVYnFQk91D/h4WM0UuU2mHwUO7WQJerQ5OyxlwX87ImYbKmI
         kIvN2QrLx5euta7V+gsoyjtOahkUXhRpQOYbKeswnlsas3DU6ykSWIfPDkhzcCWLo+si
         VOc4piddeHadRy/zGUISXtBFIc3k85V1+CS7eJXQ2ms72KZW6mdNfHLCV7k2P5ja4PKD
         pMUnZUnFPIuQ64ZaaeAMFHE9lXmSynk1AqhMyTFtXhhuip1CrwJZnsou/gMXeSxv6c/e
         tW/nK56FEzKqgRv9nKwkzKNg9DDZkqEwSPERNupxd10HzZ8km9weveZKjVfyvWsCx8a2
         qw7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761733267; x=1762338067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HbulqRf/JzdfAl/dtv+qftIvyvV8wiDVdKN2RHYy4TQ=;
        b=U6xa5aHh9s16hV3Mmp4pAlSAjdTAOxI84x3ed6I20pDTzTkc3MWX0r3tUN7Uoi3jNl
         e7MvwcYobM43Vzah016bw6gp0Ur0fKmAwelGRrImOaLo5b3syEj7Zr9tDgc91aPhQwFM
         c1tZJDhzUl+YZNvnncYgwXVNB3UYnWUCu8jeL+D23DxXJflwm/YGV59skhVQp087BMj/
         VeutmpRFgut79mB0bL3fR5NhbtGD6J3IY6xmstllhK9mr39QuFMici2KiEuCiO0//Asu
         LyKA1Gdn+3a+JHD+0SHIIcchFXZQB64y4gisVvjjV2zQ4mhG0WFk1xNjIInHkD/WGLNf
         G//g==
X-Forwarded-Encrypted: i=1; AJvYcCXbuTaBI+DZRhOqxg+y/P1ifqhSP5ekiFO06xfFDPxalff3lH2M88XnnajhRbqFh8jAerZxeZ1rs8md@lists.infradead.org
X-Gm-Message-State: AOJu0Yw2lYcYGl6DFknB0c6PXvDdheGmmwytonbJ8Ckp+IoaJs2N1+ZY
	gzCLmVcWxfMEsLKrq6UB3IDVTY3NY7bxEeVpDuy46oXmqapSbQ2+0RCedQZn51D9dbtDVJA2Hci
	qVI/q
X-Gm-Gg: ASbGncsoBf5Gu2zkEyo601lv+RSe65lwt9Um9h5n/pGyFxRkWZ8BaGKogWvjDhJi44N
	91h2AwFjjEjP1kZ4UnE/SVpsg0hn4gS++qgdQTte2SptY15lJM0gubpgmhz7IjJxlNqg52um5Bg
	+5AR73B9Hsy6llGMg0s+lNHiR/+ocDZ9M1bbmkw3tx2svohQz5n4HgB/yGzE8Sh+kxURpan/Jvo
	4bIRPj4aRHOQh4kMjw9HUEL+K0zyuac6pFTr3OniWcnQVnavNuVIf7zZI736F/PO/mooKVY+JFu
	Sn2JKurw0mRozids9Bi/sNFI9M7H8HEvwed13/cA21sH8ORb8thL0dBpgdbwHV3PbrpMpDzj9Az
	Frv2uxT5HzcN0ou490gMaS+JJHCF5IlTxRPQQYRC9SVZqyzuehhhXUxPb9DRYNXUYCQoxUeCunE
	vsHWdRthMgIc42P2VsW6QtkakP
X-Google-Smtp-Source: AGHT+IHL0MICP1K9H4r8j+kOSzogqVuiVQjNGs4tt84n15SY6d/K/p8SfQsZ4RZjWKksxhhmDOquvA==
X-Received: by 2002:a05:6a00:2da5:b0:77f:4f3f:bfda with SMTP id d2e1a72fcca58-7a4e53f14dcmr2854006b3a.31.1761733267109;
        Wed, 29 Oct 2025 03:21:07 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:3fc9:8c3c:5030:1b20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414034661sm14888261b3a.26.2025.10.29.03.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:21:06 -0700 (PDT)
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: 409411716@gms.tku.edu.tw
Cc: akpm@linux-foundation.org,
	axboe@kernel.dk,
	ceph-devel@vger.kernel.org,
	ebiggers@kernel.org,
	hch@lst.de,
	home7438072@gmail.com,
	idryomov@gmail.com,
	jaegeuk@kernel.org,
	kbusch@kernel.org,
	linux-fscrypt@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	tytso@mit.edu,
	visitorckw@gmail.com,
	xiubli@redhat.com
Subject: [PATCH v4 3/6] lib/base64: rework encode/decode for speed and stricter validation
Date: Wed, 29 Oct 2025 18:21:00 +0800
Message-Id: <20251029102100.543446-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_032108_044634_63113922 
X-CRM114-Status: GOOD (  20.62  )
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

The old base64 implementation relied on a bit-accumulator loop, which was
slow for larger inputs and too permissive in validation. It would accept
extra '=', missing '=', or even '=' appearing in the middle of the input,
allowing malformed strings to pass. This patch reworks the internals to
improve performance and enforce stricter validation.

Changes:
 - Encoder:
   * Process input in 3-byte blocks, mapping 24 bits into four 6-bit
     symbols, avoiding bit-by-bit shifting and reducing loop iterations.
   * Handle the final 1-2 leftover bytes explicitly and emit '=' only when
     requested.
 - Decoder:
   * Based on the reverse lookup tables from the previous patch, decode
     input in 4-character groups.
   * Each group is looked up directly, converted into numeric values, and
     combined into 3 output bytes.
   * Explicitly handle padded and unpadded forms:
      - With padding: input length must be a multiple of 4, and '=' is
        allowed only in the last two positions. Reject stray or early '='.
      - Without padding: validate tail lengths (2 or 3 chars) and require
        unused low bits to be zero.
   * Removed the bit-accumulator style loop to reduce loop iterations.

Performance (x86_64, Intel Core i7-10700 @ 2.90GHz, avg over 1000 runs,
KUnit):

Encode:
  64B   ~90ns   -> ~32ns   (~2.8x)
  1KB  ~1332ns  -> ~510ns  (~2.6x)

Decode:
  64B  ~1530ns  -> ~35ns   (~43.7x)
  1KB ~27726ns  -> ~530ns  (~52.3x)

Co-developed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Co-developed-by: Yu-Sheng Huang <home7438072@gmail.com>
Signed-off-by: Yu-Sheng Huang <home7438072@gmail.com>
Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
---
 lib/base64.c | 110 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 69 insertions(+), 41 deletions(-)

diff --git a/lib/base64.c b/lib/base64.c
index 8a0d28908..bcdbd411d 100644
--- a/lib/base64.c
+++ b/lib/base64.c
@@ -51,28 +51,38 @@ static const s8 base64_rev_maps[][256] = {
 int base64_encode(const u8 *src, int srclen, char *dst, bool padding, enum base64_variant variant)
 {
 	u32 ac = 0;
-	int bits = 0;
-	int i;
 	char *cp = dst;
 	const char *base64_table = base64_tables[variant];
 
-	for (i = 0; i < srclen; i++) {
-		ac = (ac << 8) | src[i];
-		bits += 8;
-		do {
-			bits -= 6;
-			*cp++ = base64_table[(ac >> bits) & 0x3f];
-		} while (bits >= 6);
-	}
-	if (bits) {
-		*cp++ = base64_table[(ac << (6 - bits)) & 0x3f];
-		bits -= 6;
+	while (srclen >= 3) {
+		ac = (u32)src[0] << 16 | (u32)src[1] << 8 | (u32)src[2];
+		*cp++ = base64_table[ac >> 18];
+		*cp++ = base64_table[(ac >> 12) & 0x3f];
+		*cp++ = base64_table[(ac >> 6) & 0x3f];
+		*cp++ = base64_table[ac & 0x3f];
+
+		src += 3;
+		srclen -= 3;
 	}
-	if (padding) {
-		while (bits < 0) {
+
+	switch (srclen) {
+	case 2:
+		ac = (u32)src[0] << 16 | (u32)src[1] << 8;
+		*cp++ = base64_table[ac >> 18];
+		*cp++ = base64_table[(ac >> 12) & 0x3f];
+		*cp++ = base64_table[(ac >> 6) & 0x3f];
+		if (padding)
+			*cp++ = '=';
+		break;
+	case 1:
+		ac = (u32)src[0] << 16;
+		*cp++ = base64_table[ac >> 18];
+		*cp++ = base64_table[(ac >> 12) & 0x3f];
+		if (padding) {
+			*cp++ = '=';
 			*cp++ = '=';
-			bits += 2;
 		}
+		break;
 	}
 	return cp - dst;
 }
@@ -88,41 +98,59 @@ EXPORT_SYMBOL_GPL(base64_encode);
  *
  * Decodes a string using the selected Base64 variant.
  *
- * This implementation hasn't been optimized for performance.
- *
  * Return: the length of the resulting decoded binary data in bytes,
  *	   or -1 if the string isn't a valid Base64 string.
  */
 int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base64_variant variant)
 {
-	u32 ac = 0;
-	int bits = 0;
-	int i;
 	u8 *bp = dst;
-	s8 ch;
+	s8 input[4];
+	s32 val;
+	const u8 *s = (const u8 *)src;
+	const s8 *base64_rev_tables = base64_rev_maps[variant];
 
-	for (i = 0; i < srclen; i++) {
-		if (padding) {
-			if (src[i] == '=') {
-				ac = (ac << 6);
-				bits += 6;
-				if (bits >= 8)
-					bits -= 8;
-				continue;
-			}
-		}
-		ch = base64_rev_maps[variant][(u8)src[i]];
-		if (ch == -1)
-			return -1;
-		ac = (ac << 6) | ch;
-		bits += 6;
-		if (bits >= 8) {
-			bits -= 8;
-			*bp++ = (u8)(ac >> bits);
+	while (srclen >= 4) {
+		input[0] = base64_rev_tables[s[0]];
+		input[1] = base64_rev_tables[s[1]];
+		input[2] = base64_rev_tables[s[2]];
+		input[3] = base64_rev_tables[s[3]];
+
+		val = input[0] << 18 | input[1] << 12 | input[2] << 6 | input[3];
+
+		if (unlikely(val < 0)) {
+			if (!padding || srclen != 4 || s[3] != '=')
+				return -1;
+			padding = 0;
+			srclen = s[2] == '=' ? 2 : 3;
+			break;
 		}
+
+		*bp++ = val >> 16;
+		*bp++ = val >> 8;
+		*bp++ = val;
+
+		s += 4;
+		srclen -= 4;
 	}
-	if (ac & ((1 << bits) - 1))
+
+	if (likely(!srclen))
+		return bp - dst;
+	if (padding || srclen == 1)
 		return -1;
+
+	val = (base64_rev_tables[s[0]] << 12) | (base64_rev_tables[s[1]] << 6);
+	*bp++ = val >> 10;
+
+	if (srclen == 2) {
+		if (val & 0x800003ff)
+			return -1;
+	} else {
+		val |= base64_rev_tables[s[2]];
+		if (val & 0x80000003)
+			return -1;
+		*bp++ = val >> 2;
+	}
 	return bp - dst;
 }
 EXPORT_SYMBOL_GPL(base64_decode);
+
-- 
2.34.1


