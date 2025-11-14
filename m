Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83493CDE008
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 06:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lWS11xsgkFrNsAXlptIvYpGHMFNUcuv3AuLz0xI70Ao=; b=V67D0PiB1GHQKGzS6QPP/TsjxH
	LYLPlc0rfTaLPSMrMTMhBpBGp3pHHKbjWQaEoITMdOZiytc4rM6UFWCKb9INxoCAXpE4NoLFnfm+B
	VXjTtSfrvPnPzb0mbOaPaGYgiC+pTNZj6w5wzHxuM3BWG7gjbxFKX9P8sYQcxg2JWsXXdWhfED/3v
	iRzUfgT4D/fGilJ6RIpZyignn35wws6RHjlvyGP8kSZD1IkSdYD+UvpnGVwwP3Bg1GrRTaORbcgjN
	YuonDqNSv98ngPa/GL40kWb4TRIgBFF/Wh+vq2xmWmPR7br4T674nSOfJ/OPhCgrKa+OYe7PwrlWa
	iDP6cUMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJms1-0000000BcYD-33Sj;
	Fri, 14 Nov 2025 06:01:17 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJmrz-0000000BcXd-0wex
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 06:01:16 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so1843233b3a.2
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 22:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1763100074; x=1763704874; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lWS11xsgkFrNsAXlptIvYpGHMFNUcuv3AuLz0xI70Ao=;
        b=0IHjcYLGiPKURYskZY9LMm4L9MHH02qpgDk5RS7gTdOzBq4W/Ei4BRLrd1Aw65GH1I
         3earBC+7pL4iXQP8Q1yZKF3y96lTaxpBdOZEpE3M4XopdtaXTqbQQUgyF9fvcuCM1RkS
         QFfjXn2Li0lZ3I5T+s0vjK/lESXbz1izvNxiYfFD3C4doYyZtDy09NjprSJqIBxPtMmq
         ZqT5FhvxgXuHJ1fxe1dIoo12DFlXZMSz5oPVWmjac0J7EdPGnyPX4uZ9AtLmyHbx8S/5
         Bke/hmQtTgZHJRnYS3Oi678X4fMS5c5Yz5q9Sls9pMaTMAZ2y3Ld3JOK9WSIcsGWTnR5
         LugA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763100074; x=1763704874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lWS11xsgkFrNsAXlptIvYpGHMFNUcuv3AuLz0xI70Ao=;
        b=SMvlHsrET9+ttzY/X0UmMco5mBjtJEhg4KrGDpaZK1usoWvYty6oyLc+DpvBLbipWR
         oRjvCoMjAf7CGjs/NNs6iii0r8H5D2wVPbW0SeJbsTLiJNtkuFtVx9PVdlqzXtDlduUz
         qd1WOmbL7gStFPpYHtX8kRwhD2UQplpapx2Z+FqtDtN9NdMBvpGCfcFR5uRR8oCb1rmc
         v3edwkdWBHpvXov/q6/N8yYQWGXP6M7X0J2PQ6OUc8oA/S0Kt9YWcRTr1VFpQy8POOI3
         gYKRxbUSAuy7gzfRrUeqESz976OBPHQsA50cmjJ1/RQ+uZuZ7HpmrVIWutAtHiPKESd3
         5/Ew==
X-Forwarded-Encrypted: i=1; AJvYcCU6aSgownpRhCQuORajU4651j9jZxxB7DFlKEEZ+uL8ngXjRhtbOYSdBIGWs/sXsW8hYF52fx6JL3ll@lists.infradead.org
X-Gm-Message-State: AOJu0YyyLkCo0vndD8AIVGW/RruDgko7w1EA25BbRsQkAQdovQIP/hK8
	XrhUsXSjR9Zh8exhDDGqdwwm0g2blx9XlZNxCE3jiofB07GOiVZYLkJbUqFLp9pXf1k=
X-Gm-Gg: ASbGncueRNP8rO0beClIC35VNgJn0Gk/FclcIfUMdQZlToJy0ANUulOkgCjVVpqZV9p
	o0EkOYnNE/pH9xDQ4vciWRsXPiOarSUwUeDKi+9zJhOA6nC5o4B0nqHP2+YMqfoRtxdxR2G4E+L
	HD4KC5i9a47IxKp6Wn4xXgHouJ+1LxYFRGaMdDEjh1rf0gNGYKSYN6tykrqutkyd8drM5yPHqqL
	nhQ/WYm9aO8xgTjLKKIoq+ls3pCyNmN4DAuXbUhwFrcsvVblx5qYzbaJFTLCpX42i1xvJhmknRW
	rCcoH1hjg1JQMh9YS80v23Y7kX7ai0xnzF7MvjmFMtGYA675+9lUZX7P+LOGEIkpz2y/djEchV4
	MbVjF4vrXylKP8TEjGKtXfIjITYlRZT0J1adwZ4s6Ban7Q4EIn4O6DzgjDKc4wnJpJe90MBBffb
	/zWz9PzbkN7Ln3dyHxuwyKCIcZLe9n9XNPQYA=
X-Google-Smtp-Source: AGHT+IH5zqaJvOCHGyW2FJR2JlFHMBKlTKF05FN81/22NWKlZaSd+Pgu/afzXFlbWF1Pxh5Ir24tyA==
X-Received: by 2002:a05:6a00:198d:b0:7b8:9d86:6d44 with SMTP id d2e1a72fcca58-7ba3a0be249mr2401481b3a.9.1763100074344;
        Thu, 13 Nov 2025 22:01:14 -0800 (PST)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:22d2:323c:497d:adbd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b924be368bsm4075198b3a.9.2025.11.13.22.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 22:01:14 -0800 (PST)
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
Subject: [PATCH v5 2/6] lib/base64: Optimize base64_decode() with reverse lookup tables
Date: Fri, 14 Nov 2025 14:01:07 +0800
Message-Id: <20251114060107.89026-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114055829.87814-1-409411716@gms.tku.edu.tw>
References: <20251114055829.87814-1-409411716@gms.tku.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_220115_269795_0E863540 
X-CRM114-Status: GOOD (  14.53  )
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
  64B   ~1530ns  ->  ~80ns    (~19.1x)
  1KB  ~27726ns  -> ~1239ns   (~22.4x)

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
---
 lib/base64.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/lib/base64.c b/lib/base64.c
index a7c20a8e8e98..9d1074bb821c 100644
--- a/lib/base64.c
+++ b/lib/base64.c
@@ -21,6 +21,49 @@ static const char base64_tables[][65] = {
 	[BASE64_IMAP] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,",
 };
 
+/**
+ * Initialize the base64 reverse mapping for a single character
+ * This macro maps a character to its corresponding base64 value,
+ * returning -1 if the character is invalid.
+ * char 'A'-'Z' maps to 0-25, 'a'-'z' maps to 26-51, '0'-'9' maps to 52-61,
+ * ch_62 maps to 62, ch_63 maps to 63, and other characters return -1
+ */
+#define INIT_1(v, ch_62, ch_63) \
+	[v] = (v) >= 'A' && (v) <= 'Z' ? (v) - 'A' \
+		: (v) >= 'a' && (v) <= 'z' ? (v) - 'a' + 26 \
+		: (v) >= '0' && (v) <= '9' ? (v) - '0' + 52 \
+		: (v) == (ch_62) ? 62 : (v) == (ch_63) ? 63 : -1
+/**
+ * Recursive macros to generate multiple Base64 reverse mapping table entries.
+ * Each macro generates a sequence of entries in the lookup table:
+ * INIT_2 generates 2 entries, INIT_4 generates 4, INIT_8 generates 8, and so on up to INIT_32.
+ */
+#define INIT_2(v, ...) INIT_1(v, __VA_ARGS__), INIT_1((v) + 1, __VA_ARGS__)
+#define INIT_4(v, ...) INIT_2(v, __VA_ARGS__), INIT_2((v) + 2, __VA_ARGS__)
+#define INIT_8(v, ...) INIT_4(v, __VA_ARGS__), INIT_4((v) + 4, __VA_ARGS__)
+#define INIT_16(v, ...) INIT_8(v, __VA_ARGS__), INIT_8((v) + 8, __VA_ARGS__)
+#define INIT_32(v, ...) INIT_16(v, __VA_ARGS__), INIT_16((v) + 16, __VA_ARGS__)
+
+#define BASE64_REV_INIT(ch_62, ch_63) { \
+	[0 ... 0x1f] = -1, \
+	INIT_32(0x20, ch_62, ch_63), \
+	INIT_32(0x40, ch_62, ch_63), \
+	INIT_32(0x60, ch_62, ch_63), \
+	[0x80 ... 0xff] = -1 }
+
+static const s8 base64_rev_maps[][256] = {
+	[BASE64_STD] = BASE64_REV_INIT('+', '/'),
+	[BASE64_URLSAFE] = BASE64_REV_INIT('-', '_'),
+	[BASE64_IMAP] = BASE64_REV_INIT('+', ',')
+};
+
+#undef BASE64_REV_INIT
+#undef INIT_32
+#undef INIT_16
+#undef INIT_8
+#undef INIT_4
+#undef INIT_2
+#undef INIT_1
 /**
  * base64_encode() - Base64-encode some binary data
  * @src: the binary data to encode
@@ -84,10 +127,9 @@ int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base6
 	int bits = 0;
 	int i;
 	u8 *bp = dst;
-	const char *base64_table = base64_tables[variant];
+	s8 ch;
 
 	for (i = 0; i < srclen; i++) {
-		const char *p = strchr(base64_table, src[i]);
 		if (padding) {
 			if (src[i] == '=') {
 				ac = (ac << 6);
@@ -97,9 +139,10 @@ int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base6
 				continue;
 			}
 		}
-		if (p == NULL || src[i] == 0)
+		ch = base64_rev_maps[variant][(u8)src[i]];
+		if (ch == -1)
 			return -1;
-		ac = (ac << 6) | (p - base64_table);
+		ac = (ac << 6) | ch;
 		bits += 6;
 		if (bits >= 8) {
 			bits -= 8;
-- 
2.34.1


