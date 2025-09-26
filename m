Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF8FCAC5AC
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Sep 2025 06:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eoUrxrA1gUNwCBEXabdQA4Jiv6vtYFchaTivJjmbSzM=; b=1NM4mO7paqpXgjDppk3J7GsVEJ
	0VZvMmluxC8tdXqrLrYuvwibXwXYx8OtZ3kfYOqlzgdpgptFY2C2nNqY85Zl1S+nlUkbI3iDzymYw
	L9O6iNw0DaxLJ5NDjc7RGoMX/601UoZcFnn9MVOCIIjOQnqF154ohpYlYMxJHEo6c1ZnFgDM+NOSM
	KMa2X3GBFlVIpAW2ULun/oQ/6i49XvCvcdBByAUgoxLEPMEurYPXx3v4iQ0X0rzbEVNDLqoQMjO/Q
	81yFAxvoGWmkoB/75vC1+C1Tzi5xDcok8teiOLuv1rgcQ8Htp3SLz5PcHi+lAushYVFt5/rWfDOxR
	oK9LVoqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v22NB-0000000GXvZ-3u36;
	Fri, 26 Sep 2025 06:56:05 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v22NA-0000000GXt2-0e4N
	for linux-nvme@lists.infradead.org;
	Fri, 26 Sep 2025 06:56:05 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso1667246b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 25 Sep 2025 23:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1758869763; x=1759474563; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoUrxrA1gUNwCBEXabdQA4Jiv6vtYFchaTivJjmbSzM=;
        b=rvncPS1vE4XeofpraC0d87/mdTjhRGe4/hF5A5qx0J28T41uexcrWFiPRpSsIyH4bs
         3HphUrdkP/dJT/WdoN1ExV4fBqm7JcPtb6K8iyUU4ZY+eJdPCBWDQnqF0sM+miHpj46+
         HKy0PzGf8ZYzADeOIR5Pj2GYBJFaN6mU+rZK8IQdzO1tqUT5xRUsVv81kBBK/WUzMYL2
         iVVC1QNvzbDntDT69IzqJuASbp/sumjDldo6BNcmgzAAStbzJyhdggRUrf35FAty/M5x
         z2CuvM8+PKXp7TyqZ+XJGgrBUXCEO1dgj2scI911GNQ5f91tdx07trGf8/wNfIPa6Pd8
         T/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758869763; x=1759474563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoUrxrA1gUNwCBEXabdQA4Jiv6vtYFchaTivJjmbSzM=;
        b=OQg+ydNP44UwRmFuKOC+G/LuiJ9qIBfyhLKGS42aoZIFNlk4EjlrX/rTTcrKGr5xO4
         j5xNSzfafTuusir+SVKI/U5Y4o3w3EeLFqbxBjyYYx37yuegMQ6ngJKdayFBonIyrDSj
         NWpJFBTZY40m8g9/UzbB3FEofLbrY2PNNg3CZYmrAfWCtkjZJn1kmmNiYUOZnC/j8R2a
         xj2zgX/lpD04XOrlDraxcBnosl/3CYYIVtmnUYl88sFjgO6MLm3b+Yn23bpbiFxaiVuC
         2u/bYFPfjYiYEjZlVmjzqq46n710Bq2Ed8kLF0i8CdUzp8fMhOgz9uMMfq0TMN9YWnje
         5Lsg==
X-Forwarded-Encrypted: i=1; AJvYcCUO+CzMXWHMPmMG5UvgTAcX+UPKCl1loG5OFrB4bE02yj4xeKHiIdtERRWJYLmv8vNqys/IIEOLMt7u@lists.infradead.org
X-Gm-Message-State: AOJu0YwCODgWwmbuMKYjML6TCKCoIbRP+RXVGUarhpAIQUnvz7NzVJHB
	sEahZWdr3zkr3M4Kh+8IBfR7Hj46bXp9jbbDK0liJtzQMMqGcRHnJfEvcnmMVqPMBgo=
X-Gm-Gg: ASbGncs/pRODtJU/iHHtdO72i76dk7zsDSBOytL9GurAgjDqcIlMBZVOnka5WqckkVt
	TfDEoQnVW2XkPxYrSnT+DcYjFuAiyW97pfsyrquRwMqnZJe5XI0aI6tFJRXAyuEfOvfRT8s2xTU
	vQyVtzqqcl2VCkkVHeRSI+6OrUHfPrrh3hzkGrwcVgHhfpNiU3QEFYk8qgWU1HSCgvKx1GcFysj
	chOVRI92IyElZQqnJFegeXnPcPqNmAyhvCaDkcXEij0Wut1LuJqYDufFogAwei/TAllgNSQj40q
	XKugg/RvhIjaIws1onWwQiHpGI0/8dWf9/wPa5K5Wt5Fd1G02alwFu/c4JachblyZxVuGYA2p1p
	Nml7lN3mHrHAptSkLEIwde/eh4Rvf1DiT3PeuKVeRvvX6nFY=
X-Google-Smtp-Source: AGHT+IGYm5AiCHUG81wKjmGsOZM0oMcXTABlIBjc3hApVwgc3SyeCPuiUQVrAgnYuzKJCyjqVgplKg==
X-Received: by 2002:a17:902:d4c8:b0:24c:ed95:2725 with SMTP id d9443c01a7336-27ed4a06ca7mr77835285ad.4.1758869763210;
        Thu, 25 Sep 2025 23:56:03 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:94ad:363a:4161:464c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed672aa0asm45307415ad.62.2025.09.25.23.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 23:56:02 -0700 (PDT)
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
Subject: [PATCH v3 2/6] lib/base64: Optimize base64_decode() with reverse lookup tables
Date: Fri, 26 Sep 2025 14:55:56 +0800
Message-Id: <20250926065556.14250-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_235604_207614_BEBA9663 
X-CRM114-Status: GOOD (  12.68  )
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

From: Kuan-Wei Chiu <visitorckw@gmail.com>

Replace the use of strchr() in base64_decode() with precomputed reverse
lookup tables for each variant. This avoids repeated string scans and
improves performance. Use -1 in the tables to mark invalid characters.

Decode:
  64B   ~1530ns  ->  ~75ns    (~20.4x)
  1KB  ~27726ns  -> ~1165ns   (~23.8x)

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
---
 lib/base64.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 61 insertions(+), 5 deletions(-)

diff --git a/lib/base64.c b/lib/base64.c
index 1af557785..b20fdf168 100644
--- a/lib/base64.c
+++ b/lib/base64.c
@@ -21,6 +21,63 @@ static const char base64_tables[][65] = {
 	[BASE64_IMAP] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,",
 };
 
+static const s8 base64_rev_tables[][256] = {
+	[BASE64_STD] = {
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,  -1,  -1,  -1,  63,
+	 52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,
+	 15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  -1,  -1,  -1,  -1,
+	 -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,
+	 41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	},
+	[BASE64_URLSAFE] = {
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,  -1,  -1,
+	 52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,
+	 15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  -1,  -1,  -1,  63,
+	 -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,
+	 41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	},
+	[BASE64_IMAP] = {
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  62,  63,  -1,  -1,  -1,
+	 52,  53,  54,  55,  56,  57,  58,  59,  60,  61,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,   0,   1,   2,   3,   4,   5,   6,   7,   8,   9,  10,  11,  12,  13,  14,
+	 15,  16,  17,  18,  19,  20,  21,  22,  23,  24,  25,  -1,  -1,  -1,  -1,  -1,
+	 -1,  26,  27,  28,  29,  30,  31,  32,  33,  34,  35,  36,  37,  38,  39,  40,
+	 41,  42,  43,  44,  45,  46,  47,  48,  49,  50,  51,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	 -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,  -1,
+	},
+};
+
 /**
  * base64_encode() - Base64-encode some binary data
  * @src: the binary data to encode
@@ -82,11 +139,9 @@ int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base6
 	int bits = 0;
 	int i;
 	u8 *bp = dst;
-	const char *base64_table = base64_tables[variant];
+	s8 ch;
 
 	for (i = 0; i < srclen; i++) {
-		const char *p = strchr(base64_table, src[i]);
-
 		if (src[i] == '=') {
 			ac = (ac << 6);
 			bits += 6;
@@ -94,9 +149,10 @@ int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base6
 				bits -= 8;
 			continue;
 		}
-		if (p == NULL || src[i] == 0)
+		ch = base64_rev_tables[variant][(u8)src[i]];
+		if (ch == -1)
 			return -1;
-		ac = (ac << 6) | (p - base64_table);
+		ac = (ac << 6) | ch;
 		bits += 6;
 		if (bits >= 8) {
 			bits -= 8;
-- 
2.34.1


