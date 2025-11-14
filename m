Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1745FCDE006
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 06:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q1IGQOBRzs6BjZdUR3pYUPttP+jjYEqCfWUHv2cldxw=; b=WkA9rsAKIynDGA8yUUCrYEWJ5P
	A06RNjy8oV1WEe2LtywRpnT8z7y3GhjbFwILGzYpiP/zP29bTx6cl7/sjy6sBXZbI2ZCQEPc5iGYJ
	Ks36a3gk82159k91/kcIAwpSQ2meB/QFyzkL33gvRkmE12rhtFewNZNHJwQk2HoImIWFgBBvb88ul
	s2vIua+p9xiz3dQPMv+TBOxWPQueYe7vCl65Gf+jiuSUhFZA/nPtceKPBAjfAy3MLp+LVdfdgd/+y
	Z3fGGZj+xQp1OfM1g6jM3V6wFLBL0e9X4KDQY9vV/qd8ez+VmfrBw1Zso2bfx3677B81t9Gh1sHxt
	RjL3GWZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJmsR-0000000BcdF-0JcQ;
	Fri, 14 Nov 2025 06:01:43 +0000
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJmsO-0000000BccW-1waq
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 06:01:41 +0000
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-3418ad69672so1196278a91.3
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 22:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1763100100; x=1763704900; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q1IGQOBRzs6BjZdUR3pYUPttP+jjYEqCfWUHv2cldxw=;
        b=e4qio34lNzjcgyvRHFAMDbsHD9GR7nwy0vzMAY3jYWuyo4zyLSFS37UJJX4GwnKipo
         3JZTikM/f1thgDg0xo3K4l0D3R6jT6zlpciKQQfFCYK8UjoBrX+djTQ4c5QuHytJF07h
         h5HPbb51Pe2iOZbfAKIlp+HvXfu/B897Sy58ah1VOOGzAjhaSYJPSn+fOUOreA5T1lLL
         Dho0TxMlSuWjQMeMAuQAiur8kr5OrfDZpQj/vYV6hlcRvrC1frezMOEBwN5Xh371A1g2
         hSKKLE2Lkb4GIyqGTLM1Rkf577ji0WF2P2jXyWt3qVF5yct149I0Fh7ZlDe2JCGIDciC
         QYog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763100100; x=1763704900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q1IGQOBRzs6BjZdUR3pYUPttP+jjYEqCfWUHv2cldxw=;
        b=ICAuOkcfzl9N/xeKOrB4fNyt2dBdWH+Fzk8LndJ8JlQ8QBAEbkbxaHpSa3yzoU4gNa
         oJvwujXbAewvyT7HL3YM4qJpIUEYZPqBeGIkX+ombSzSyLUf2g5j4IZ+WpX0QyCZPhG7
         ns4lJzghqhPsXoZ4eID7NCxjeYMjUFPKUUVv34dqT7GfZtslLypifDrqHSKB5Cf0i6Y5
         1DLu8jhK5fo/qUif6RqlR+iivxTLZvchCi49n2QiXV4/DVMBX4nqS8nmibnh5OMO5Y80
         SwCeW5b+60KMvUjeW7eSyDZsRNr3d14VvlTTHZJKrTK5x8WT5DhbsOyBtbBtSvTG4F/m
         2OAw==
X-Forwarded-Encrypted: i=1; AJvYcCVDBoiBKbIDm2nlBWI8jkV9gTt/I7Vh9WZhIjFEnoZIaVFHchpIK188iKysKR0z6yNsAbie+IeJXil7@lists.infradead.org
X-Gm-Message-State: AOJu0YyJ2bwQtltIVbrlKpdR18+2/YNGm2o8ZugshO8fLB3K3a6Nlvwv
	saeWeltvcxmYHTexox6vSf0bEIccfeqOg/+m/y0NHI46f51IbTFjHdUnLCydznhD6QQ=
X-Gm-Gg: ASbGncu7zN+JQMz4GjEZT1BdcPC+24WXdZjL//yAa6o60ACC18hSSO5ep/z+I4czhS4
	L2WmD4BzY0mevX7M6jGctPNK78+LybqKo4AMbCR7ymuZbsnXkj/+Kc6MQ/Op2C5ysY7TOGRatFl
	y0a292q/d2uvfCeXaayR5bAqQn9rVOhbfDoQ/LmkdGJQUycn7g6j4eX3OOX2AKqwad0PlwxvKmM
	ZpX5BpMQ3sFmDfXTZI0zSBaHldF523nYfOBZLO4Witadvmt8AiftcQ44qapyPWWQubcqhhjGywJ
	gKS4HO6ESj7ZPSZIUTSYlcB5SjrNu2S65JkfrHG/zPdpBsyTllUHR0qzTlAOHbdFoUJhECejmpx
	TvZ4vbjblQBiKZ5/xGTHFdIQ6ZlsuYjFCxlkc+HZSliqKTaLizQb3z6rdP4pMETAG5A1zLWmzw6
	fVckEgoNO1KzP11Zk10d2EiOvG
X-Google-Smtp-Source: AGHT+IGm/DcFCjii9Cj0HeKdnayirMai9hbtcC7DKvoxz9MTk6adf+dWGrkM2fl+VogccyRz+p4CTA==
X-Received: by 2002:a17:90b:3b4b:b0:343:a631:28a8 with SMTP id 98e67ed59e1d1-343fa754b6emr2387408a91.37.1763100098951;
        Thu, 13 Nov 2025 22:01:38 -0800 (PST)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:22d2:323c:497d:adbd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ed55564dsm4354199a91.13.2025.11.13.22.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 22:01:38 -0800 (PST)
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: 409411716@gms.tku.edu.tw
Cc: akpm@linux-foundation.org,
	andriy.shevchenko@intel.com,
	axboe@kernel.dk,
	ceph-devel@vger.kernel.org,
	david.laight.linux@gmail.com,
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
Subject: [PATCH v5 3/6] lib/base64: rework encode/decode for speed and stricter validation
Date: Fri, 14 Nov 2025 14:01:32 +0800
Message-Id: <20251114060132.89279-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114055829.87814-1-409411716@gms.tku.edu.tw>
References: <20251114055829.87814-1-409411716@gms.tku.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_220140_503912_191AF5DE 
X-CRM114-Status: GOOD (  19.61  )
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
 lib/base64.c | 109 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 68 insertions(+), 41 deletions(-)

diff --git a/lib/base64.c b/lib/base64.c
index 9d1074bb821c..1a6d8fe37eda 100644
--- a/lib/base64.c
+++ b/lib/base64.c
@@ -79,28 +79,38 @@ static const s8 base64_rev_maps[][256] = {
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
@@ -116,41 +126,58 @@ EXPORT_SYMBOL_GPL(base64_encode);
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
-- 
2.34.1


