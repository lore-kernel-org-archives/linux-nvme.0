Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C55B0CAC5AC
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Sep 2025 06:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ThTjOOxGShK1kR2Ph7c8m2+KgdD3vN1MOztiSeQNOJs=; b=BYaMSTLEIi8rhBrB6EYe5kwoF8
	kxIrZ+ijsvvk/6IBHfCM4A9KGwmH/lL2Uk2Xc+fV0+V4ssWEzzISwnsdET1HcVg4RayW0eiVMxJGE
	nVRVcRpRkqDOhMU2rGMWv+5gkTLOPRv2otQoqRr7dukD0VX6BxYzc69Sa6yufEE9gfayeBz1rfQB0
	zAS6yzCgEoPfWMP+fvqQdksXKfeClf0dEvJAa0xSqpI+2LLRsMSbyF5LzC89uDxYnkjGlL35RZjw9
	GHyV2vconkvAsdpUGNR15bKSmlSgVdHB9Lw1q077WOPNLa56KzvmQo3JOHz25pVqsBaFeUPOYYsTB
	XuYfcrhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v22Nd-0000000GYDz-1CgK;
	Fri, 26 Sep 2025 06:56:33 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v22Na-0000000GYCU-3rEm
	for linux-nvme@lists.infradead.org;
	Fri, 26 Sep 2025 06:56:32 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-271067d66fbso19869695ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 25 Sep 2025 23:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1758869790; x=1759474590; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ThTjOOxGShK1kR2Ph7c8m2+KgdD3vN1MOztiSeQNOJs=;
        b=hMjM77n0r7PkbXo02pv/v/7ea+DIInoeUpHEUXm879X/j129bfwr8eBMKdLLPKyzYF
         3dSS5cogPXMsVCeyNHkGVsYQ8CVZX/xpvywlw6M+Vqb8obw37wQDBBEAzON2m34RFcnY
         LeBbiKGWNXLPCTXb6sy6MhmMJGnJ4rySKgztOnQG/TcAzxglcB9G9SfmwKz4RLM6ed19
         UpC5jTj6TCtdWsBi8+gfko20ULK43nRP5Y0bRtnWLtLGEzSlvfzM0QQKOLHMNhoP3S1g
         ZHVDjT3FPKKQ8vwuVqLspJVkTKFMNQO/48Dm40slI5ywDp1svXhf90wO0yklJa/yfEuj
         8uQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758869790; x=1759474590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ThTjOOxGShK1kR2Ph7c8m2+KgdD3vN1MOztiSeQNOJs=;
        b=FZRISg+0J+vB92WQ8EHPr0Yptzo92snDSi/r42Fg1Cjgl8yIpirIwqNkA2HVO3IksH
         AO729Pf4YGhdcnv+j4T+ywVblC++Y/M0T1zG9ZIG9kLXvBbmkpTYs001HjnSoXo75cy8
         Cd72aIFv2ZkVnE6rWhC48i5ol+u+jBe1vC8n/RX/EOV+2zdvBcUFuddzV4ueeTcVMEQw
         p3plFKziaggN+DfMHTRgd5HtR5hJk4SssthwW6Ym2PRvx9RWVocAcUHmvm6Fb7W648a1
         UIouoGohG/o+JJIO2uj42h4h/4miAdbF3bJ5B1nWet+YiGcqRVXKFn9o/XFcmBDiIMyZ
         Ve3A==
X-Forwarded-Encrypted: i=1; AJvYcCWDsOpH/36JV62e83kRGe2oHbnD++ahTbTo+5Dentok6EiDB37DwwzbiJS+8/y6PpS0e0Hfjg2n4Htx@lists.infradead.org
X-Gm-Message-State: AOJu0Yzykz9I7Y25xr46lFTgaV0imO9IC2jk4jVlv7b25feY6+yLKfiW
	EpD8/0514X6fHiopkbzJgikjbIxaUOBzegUchm7ML5bfQ83yM1012zq/zP5dnqxuWtk=
X-Gm-Gg: ASbGncsRSnFZW9qxUI3+0Pe2x35b0g7iUBvuiMKfcj5fzj8CmFnmA32SUIAlSfz9c8O
	l1pSmOOuVGI+CYGRTOBgEgH26bUIlfJqYJE7Fy7pXIfRpyKTQPtBeUZGlVDRBlAS+IfuGtfH+Q+
	34LfmCS1DLxeRTGt4fvDs0fNvP8BjgLEVtqb5jOwVOAzi06ChxopnyjrMTDgIUjpkmqkwpyadKC
	n6lk2/nDpzc54lxYbBVT8Vc5tjU27tJNAKEhFr4QHFCW9tThm/TfN1pe3saJ3bXSGbwJyvF8SNG
	M0CWKDCzflicooXUeLq1Q+K9qaCLg7Q8cZWdEtEwBRaZGi1MvYpFQ1Z/lwdbilHY52qtc6zw0/o
	7AFWtMGEgO6Sbk02zSZvKbEeoNF1kV6Q1tggby0A7xyN+vZc=
X-Google-Smtp-Source: AGHT+IGNpOwteifS+VbNOKUqfaBSeov0n2k+u3WDmS4hQZBlmCUZXdh+j4DU1NlYFPlw0rxIClUO8A==
X-Received: by 2002:a17:902:e5c9:b0:24b:e55:360 with SMTP id d9443c01a7336-27ed4a0a053mr69081205ad.23.1758869783030;
        Thu, 25 Sep 2025 23:56:23 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:94ad:363a:4161:464c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66cfdcfsm45203655ad.26.2025.09.25.23.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 23:56:22 -0700 (PDT)
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
Subject: [PATCH v3 3/6] lib/base64: rework encode/decode for speed and stricter validation
Date: Fri, 26 Sep 2025 14:56:17 +0800
Message-Id: <20250926065617.14361-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_235630_964476_85B15F5D 
X-CRM114-Status: GOOD (  22.97  )
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
  64B  ~1530ns  -> ~64ns   (~23.9x)
  1KB ~27726ns  -> ~982ns  (~28.3x)

Co-developed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Co-developed-by: Yu-Sheng Huang <home7438072@gmail.com>
Signed-off-by: Yu-Sheng Huang <home7438072@gmail.com>
Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
---
 lib/base64.c | 150 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 110 insertions(+), 40 deletions(-)

diff --git a/lib/base64.c b/lib/base64.c
index b20fdf168..fd1db4611 100644
--- a/lib/base64.c
+++ b/lib/base64.c
@@ -93,26 +93,43 @@ static const s8 base64_rev_tables[][256] = {
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
+		ac = ((u32)src[0] << 16) |
+			 ((u32)src[1] << 8) |
+			 (u32)src[2];
+
+		*cp++ = base64_table[ac >> 18];
+		*cp++ = base64_table[(ac >> 12) & 0x3f];
+		*cp++ = base64_table[(ac >> 6) & 0x3f];
+		*cp++ = base64_table[ac & 0x3f];
+
+		src += 3;
+		srclen -= 3;
 	}
-	while (bits < 0) {
-		*cp++ = '=';
-		bits += 2;
+
+	switch (srclen) {
+	case 2:
+		ac = ((u32)src[0] << 16) |
+		     ((u32)src[1] << 8);
+
+		*cp++ = base64_table[ac >> 18];
+		*cp++ = base64_table[(ac >> 12) & 0x3f];
+		*cp++ = base64_table[(ac >> 6) & 0x3f];
+		if (padding)
+			*cp++ = '=';
+		break;
+	case 1:
+		ac = ((u32)src[0] << 16);
+		*cp++ = base64_table[ac >> 18];
+		*cp++ = base64_table[(ac >> 12) & 0x3f];
+		if (padding) {
+			*cp++ = '=';
+			*cp++ = '=';
+		}
+		break;
 	}
 	return cp - dst;
 }
@@ -128,39 +145,92 @@ EXPORT_SYMBOL_GPL(base64_encode);
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
-
-	for (i = 0; i < srclen; i++) {
-		if (src[i] == '=') {
-			ac = (ac << 6);
-			bits += 6;
-			if (bits >= 8)
-				bits -= 8;
-			continue;
-		}
-		ch = base64_rev_tables[variant][(u8)src[i]];
-		if (ch == -1)
+	s8 input1, input2, input3, input4;
+	u32 val;
+
+	if (srclen == 0)
+		return 0;
+
+	/* Validate the input length for padding */
+	if (unlikely(padding && (srclen & 0x03) != 0))
+		return -1;
+
+	while (srclen >= 4) {
+		/* Decode the next 4 characters */
+		input1 = base64_rev_tables[variant][(u8)src[0]];
+		input2 = base64_rev_tables[variant][(u8)src[1]];
+		input3 = base64_rev_tables[variant][(u8)src[2]];
+		input4 = base64_rev_tables[variant][(u8)src[3]];
+
+		/* Return error if any Base64 character is invalid */
+		if (unlikely(input1 < 0 || input2 < 0 || (!padding && (input3 < 0 || input4 < 0))))
+			return -1;
+
+		/* Handle padding */
+		if (unlikely(padding && ((input3 < 0 && input4 >= 0) ||
+					 (input3 < 0 && src[2] != '=') ||
+					 (input4 < 0 && src[3] != '=') ||
+					 (srclen > 4 && (input3 < 0 || input4 < 0)))))
+			return -1;
+		val = ((u32)input1 << 18) |
+		      ((u32)input2 << 12) |
+		      ((u32)((input3 < 0) ? 0 : input3) << 6) |
+		      (u32)((input4 < 0) ? 0 : input4);
+
+		*bp++ = (u8)(val >> 16);
+
+		if (input3 >= 0)
+			*bp++ = (u8)(val >> 8);
+		if (input4 >= 0)
+			*bp++ = (u8)val;
+
+		src += 4;
+		srclen -= 4;
+	}
+
+	/* Handle leftover characters when padding is not used */
+	if (!padding && srclen > 0) {
+		switch (srclen) {
+		case 2:
+			input1 = base64_rev_tables[variant][(u8)src[0]];
+			input2 = base64_rev_tables[variant][(u8)src[1]];
+			if (unlikely(input1 < 0 || input2 < 0))
+				return -1;
+
+			val = ((u32)input1 << 6) | (u32)input2; /* 12 bits */
+			if (unlikely(val & 0x0F))
+				return -1; /* low 4 bits must be zero */
+
+			*bp++ = (u8)(val >> 4);
+			break;
+		case 3:
+			input1 = base64_rev_tables[variant][(u8)src[0]];
+			input2 = base64_rev_tables[variant][(u8)src[1]];
+			input3 = base64_rev_tables[variant][(u8)src[2]];
+			if (unlikely(input1 < 0 || input2 < 0 || input3 < 0))
+				return -1;
+
+			val = ((u32)input1 << 12) |
+			      ((u32)input2 << 6) |
+			      (u32)input3; /* 18 bits */
+
+			if (unlikely(val & 0x03))
+				return -1; /* low 2 bits must be zero */
+
+			*bp++ = (u8)(val >> 10);
+			*bp++ = (u8)((val >> 2) & 0xFF);
+			break;
+		default:
 			return -1;
-		ac = (ac << 6) | ch;
-		bits += 6;
-		if (bits >= 8) {
-			bits -= 8;
-			*bp++ = (u8)(ac >> bits);
 		}
 	}
-	if (ac & ((1 << bits) - 1))
-		return -1;
+
 	return bp - dst;
 }
 EXPORT_SYMBOL_GPL(base64_decode);
-- 
2.34.1


