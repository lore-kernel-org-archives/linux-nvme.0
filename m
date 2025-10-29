Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C9ECCF9EB
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 10:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SFMCoYg6OZGdoPrg44aEfWpYsmxT09LG0Bx5eG4s0NA=; b=E49QH4jDd5tKJ4dSMRDDYiUsu2
	TF90MuBacezeVMkaXBGgua6vFtrJfLSVgf2e2iyvKiJ46wJXUhh58ZY4NRgi+p9TNVglFWqvT+KOu
	/vUOjjEAaG1PLF4IcU5Hb6/wCmz7k1o+3agsEs6Xq0SVszBrYEWAFZKANbHEZDI556Cj6pup4Pvfm
	5yOi0wyq4ntMP6cQZtbsD3bpKDnXBd74f9SP0HE+ZPp7KU841geqv7UxMJsWc4bbEHzP/Yg6Qy5LH
	wfF9bikkKMF5nJ9l6ZqNWsd+xVxyDRCqL2l4BRIWFBvqDUer3gwxlYyWW+iihQmcoSzZcSD2j4lKL
	XMk1GA9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE3Hz-00000000hRK-1Zb8;
	Wed, 29 Oct 2025 10:20:23 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE3Hw-00000000hPY-2V7s
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 10:20:21 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-290ab379d48so66450605ad.2
        for <linux-nvme@lists.infradead.org>; Wed, 29 Oct 2025 03:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1761733220; x=1762338020; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SFMCoYg6OZGdoPrg44aEfWpYsmxT09LG0Bx5eG4s0NA=;
        b=2/C2m1nw12AaoEm7l/WLHHVeBp3okA0b2HrN/r38S01JQ9fHseJf+ZN/IPAwPMLNCc
         DUSKRg7UcT4rth0sbhtML9MoApjjtsA8xUr7gYxN+3eKzFccq4n7c3EgneYI+KLb3K0M
         t0Gn62h5syiDu8kRdyQsUbDkVrgpV0LzU87oKr3KxI4tDtpngOj+V3QTB52WYbE6/fto
         kc6Zf0x69Vnv4tVX6i2p2b/suV0UIJcOMlrlWJ3fVUVOKrdOMeCQE43YZQwGsoyruLYp
         jQmHmPTODoT7hCQiVpxN7E1n0c+vQhUKk/eOJE0DCMcn45WAuqs7oNVm+6ZZfURIgqT9
         i/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761733220; x=1762338020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SFMCoYg6OZGdoPrg44aEfWpYsmxT09LG0Bx5eG4s0NA=;
        b=qdvAqmST2uVVVwbOvsRXs9zCT5ewEA5RkIvNHIw5G+9ZFASSkxcaTvQsI/XAZPeB+f
         z5aTW+srv6YzyGxa8cno9WzBDmsYtRmKYJ+um4mLd6WJqVOeIH01kGNhQZWHrbrvsKj7
         51xERn6cu0v8vROf6N0MC3Wm+MvAdqcoRGWYbp4lQu8MPgE5PmW7iIjPPghcrpTUpFDC
         W4W0fh+nRD8xHqtVheI+LSP2aXPtUiwMoI9xXCJ6iUyomVwh54X/Uu3Z9Mb6uGfeMlhh
         exiPNEawFZy3wLWZTzsj7jGFkRHNzKyfRXu6lCDCz3Yi6g+YXJL0TvL9jt2n0zRff7v0
         yLoA==
X-Forwarded-Encrypted: i=1; AJvYcCUrhQGKljT9IiWpujKUiPoSjDHJk7bSqpwCwNM21pPWP12TeQmN7HDA+zJ2hwOG93vQHYLhpExwhGRG@lists.infradead.org
X-Gm-Message-State: AOJu0YyYNFBTXgPCqco+wAOnDCaW1h+Qy32LiQoq1tLdCIXUDF6H6J9Z
	VCZH7lVQEFtxcPzBWtE7HKtueYLmmBugupr3ULZTpbvA2Xe1f7rfONPVcTinZOdKnWE=
X-Gm-Gg: ASbGncswiNO00Gj3KPjGP2KrLY10kwDYnksWaY4cLnIjex5eDwTSyZiHsczxOTH1M/E
	s5eoFlleTaGEQ12+rp4GUdonL/TEdL5tfF0gZKT73xelZPhQc/sNaL6K9gKIcA8t3Yuwedzksxw
	390tcUw4LVbz02dYtysZ4YslccVXAFyolkyny/5zgPET6Pr74NtHMNGkGOkr4ArbtJtK0smmZ43
	aZfLfcjjg4QG2cqFrLT9GBANj1T51TSGLKRcrLsv+PhHuHF7p0guftZG02k4S9nodJ5IhSjRfpO
	wqGllGEAZTtugNTS25MuN/5aKbGvtUoNGciTv6X35Z9OV5u81JJJJRAIlTucwKvtHUESp6jOUAT
	EzeQrZHtGZC0TOQUyClUmfb8gY4sqTDjpfiRAqliHMOeXfgArBZFPreyJNSac02Hc9wVIrLBXbg
	5F5XoPMMwO/usnWQVA13s2VYXqwI3jkm84bCE=
X-Google-Smtp-Source: AGHT+IH1SB6k0AoIpHs1QgMXDfWchgJ8uAEd6sDYAB2V3Ti9M2biGYW6sBZaYhSxBbUY7EdsjCAVwA==
X-Received: by 2002:a17:903:32d0:b0:270:e595:a440 with SMTP id d9443c01a7336-294deea9fe0mr23697295ad.25.1761733219623;
        Wed, 29 Oct 2025 03:20:19 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:3fc9:8c3c:5030:1b20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d39048sm146426775ad.66.2025.10.29.03.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:20:19 -0700 (PDT)
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
Subject: [PATCH v4 1/6] lib/base64: Add support for multiple variants
Date: Wed, 29 Oct 2025 18:20:12 +0800
Message-Id: <20251029102012.542970-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_032020_647309_0F511A1D 
X-CRM114-Status: GOOD (  23.80  )
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

Extend the base64 API to support multiple variants (standard, URL-safe,
and IMAP) as defined in RFC 4648 and RFC 3501. The API now takes a
variant parameter and an option to control padding. Update NVMe auth
code to use the new interface with BASE64_STD.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Co-developed-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
---
 drivers/nvme/common/auth.c |  4 +--
 include/linux/base64.h     | 10 ++++--
 lib/base64.c               | 62 ++++++++++++++++++++++----------------
 3 files changed, 46 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 91e273b89..5fecb53cb 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -178,7 +178,7 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 	if (!key)
 		return ERR_PTR(-ENOMEM);
 
-	key_len = base64_decode(secret, allocated_len, key->key);
+	key_len = base64_decode(secret, allocated_len, key->key, true, BASE64_STD);
 	if (key_len < 0) {
 		pr_debug("base64 key decoding error %d\n",
 			 key_len);
@@ -663,7 +663,7 @@ int nvme_auth_generate_digest(u8 hmac_id, u8 *psk, size_t psk_len,
 	if (ret)
 		goto out_free_digest;
 
-	ret = base64_encode(digest, digest_len, enc);
+	ret = base64_encode(digest, digest_len, enc, true, BASE64_STD);
 	if (ret < hmac_len) {
 		ret = -ENOKEY;
 		goto out_free_digest;
diff --git a/include/linux/base64.h b/include/linux/base64.h
index 660d4cb1e..a2c6c9222 100644
--- a/include/linux/base64.h
+++ b/include/linux/base64.h
@@ -8,9 +8,15 @@
 
 #include <linux/types.h>
 
+enum base64_variant {
+	BASE64_STD,       /* RFC 4648 (standard) */
+	BASE64_URLSAFE,   /* RFC 4648 (base64url) */
+	BASE64_IMAP,      /* RFC 3501 */
+};
+
 #define BASE64_CHARS(nbytes)   DIV_ROUND_UP((nbytes) * 4, 3)
 
-int base64_encode(const u8 *src, int len, char *dst);
-int base64_decode(const char *src, int len, u8 *dst);
+int base64_encode(const u8 *src, int len, char *dst, bool padding, enum base64_variant variant);
+int base64_decode(const char *src, int len, u8 *dst, bool padding, enum base64_variant variant);
 
 #endif /* _LINUX_BASE64_H */
diff --git a/lib/base64.c b/lib/base64.c
index b736a7a43..a7c20a8e8 100644
--- a/lib/base64.c
+++ b/lib/base64.c
@@ -1,12 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * base64.c - RFC4648-compliant base64 encoding
+ * base64.c - Base64 with support for multiple variants
  *
  * Copyright (c) 2020 Hannes Reinecke, SUSE
  *
  * Based on the base64url routines from fs/crypto/fname.c
- * (which are using the URL-safe base64 encoding),
- * modified to use the standard coding table from RFC4648 section 4.
+ * (which are using the URL-safe Base64 encoding),
+ * modified to support multiple Base64 variants.
  */
 
 #include <linux/kernel.h>
@@ -15,26 +15,31 @@
 #include <linux/string.h>
 #include <linux/base64.h>
 
-static const char base64_table[65] =
-	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
+static const char base64_tables[][65] = {
+	[BASE64_STD] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/",
+	[BASE64_URLSAFE] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_",
+	[BASE64_IMAP] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,",
+};
 
 /**
- * base64_encode() - base64-encode some binary data
+ * base64_encode() - Base64-encode some binary data
  * @src: the binary data to encode
  * @srclen: the length of @src in bytes
- * @dst: (output) the base64-encoded string.  Not NUL-terminated.
+ * @dst: (output) the Base64-encoded string.  Not NUL-terminated.
+ * @padding: whether to append '=' padding characters
+ * @variant: which base64 variant to use
  *
- * Encodes data using base64 encoding, i.e. the "Base 64 Encoding" specified
- * by RFC 4648, including the  '='-padding.
+ * Encodes data using the selected Base64 variant.
  *
- * Return: the length of the resulting base64-encoded string in bytes.
+ * Return: the length of the resulting Base64-encoded string in bytes.
  */
-int base64_encode(const u8 *src, int srclen, char *dst)
+int base64_encode(const u8 *src, int srclen, char *dst, bool padding, enum base64_variant variant)
 {
 	u32 ac = 0;
 	int bits = 0;
 	int i;
 	char *cp = dst;
+	const char *base64_table = base64_tables[variant];
 
 	for (i = 0; i < srclen; i++) {
 		ac = (ac << 8) | src[i];
@@ -48,44 +53,49 @@ int base64_encode(const u8 *src, int srclen, char *dst)
 		*cp++ = base64_table[(ac << (6 - bits)) & 0x3f];
 		bits -= 6;
 	}
-	while (bits < 0) {
-		*cp++ = '=';
-		bits += 2;
+	if (padding) {
+		while (bits < 0) {
+			*cp++ = '=';
+			bits += 2;
+		}
 	}
 	return cp - dst;
 }
 EXPORT_SYMBOL_GPL(base64_encode);
 
 /**
- * base64_decode() - base64-decode a string
+ * base64_decode() - Base64-decode a string
  * @src: the string to decode.  Doesn't need to be NUL-terminated.
  * @srclen: the length of @src in bytes
  * @dst: (output) the decoded binary data
+ * @padding: whether to append '=' padding characters
+ * @variant: which base64 variant to use
  *
- * Decodes a string using base64 encoding, i.e. the "Base 64 Encoding"
- * specified by RFC 4648, including the  '='-padding.
+ * Decodes a string using the selected Base64 variant.
  *
  * This implementation hasn't been optimized for performance.
  *
  * Return: the length of the resulting decoded binary data in bytes,
- *	   or -1 if the string isn't a valid base64 string.
+ *	   or -1 if the string isn't a valid Base64 string.
  */
-int base64_decode(const char *src, int srclen, u8 *dst)
+int base64_decode(const char *src, int srclen, u8 *dst, bool padding, enum base64_variant variant)
 {
 	u32 ac = 0;
 	int bits = 0;
 	int i;
 	u8 *bp = dst;
+	const char *base64_table = base64_tables[variant];
 
 	for (i = 0; i < srclen; i++) {
 		const char *p = strchr(base64_table, src[i]);
-
-		if (src[i] == '=') {
-			ac = (ac << 6);
-			bits += 6;
-			if (bits >= 8)
-				bits -= 8;
-			continue;
+		if (padding) {
+			if (src[i] == '=') {
+				ac = (ac << 6);
+				bits += 6;
+				if (bits >= 8)
+					bits -= 8;
+				continue;
+			}
 		}
 		if (p == NULL || src[i] == 0)
 			return -1;
-- 
2.34.1


