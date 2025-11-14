Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE523CDE008
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 06:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WmGe/VGuYfrow1+cTg8GsPpK6vNwvcURmH5IbRl3Ggw=; b=zLifrGfL8IRTywHVyRaQ5lfOSH
	3EPDkY1+U3/HHdyxcDQaE5eFtTLNcPor7mXSp2g93VCwHRtUU0IbJwX7FaBB5Ft4CUvEG+H0hJGAJ
	UQv1u5LrK+XMnOxwO9BT6BpsEHyf5BnW45xBDCrpl6totH0afbVa848RLpgBMW6FroRN6aQfP43IN
	q/Btfw44oxSLXn16hWtex8FXLHfLtP1/NwdK+sxz5y+UDTp1grmYYuKxUzIJpbghbfAPNcc0QsPB3
	HBQMLJ3SAM9z2+B81s02VNwVuXhDQdFZ1y30Rct1TGXjSC6Z3hmRkn1PFAFe0g+nmIJ6ry53tWxbY
	zWvdOqRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJmrf-0000000BcTJ-3c7S;
	Fri, 14 Nov 2025 06:00:55 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJmrd-0000000BcSr-0UDB
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 06:00:54 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-297e264528aso16331275ad.2
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 22:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1763100052; x=1763704852; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WmGe/VGuYfrow1+cTg8GsPpK6vNwvcURmH5IbRl3Ggw=;
        b=F5/RTqlzULjkCH2NbXZmHfYpdfEvpCDrPMGjXHoQLqt9e94FM5s7dLzc/ELkFGSoMg
         qJIPlHDxkjBNkVwiEQmUcdB9tMUc0mt1zfQ7nKuJgx4UxMh0Kv/j0mBA1PC5j3v19K6o
         aYY6ELj4SJH+NGWkF6kUywCn8vYMDXIHkMUSIoC52sBo/bN/Jn/3z0BqX/Zc3kgDXcuX
         PgppXDKXyEZY1ny5wsLE9w9drcDYD6Caz8dn1KuaHXTUx6CuVOjDLW4QL7XeoXEJSOtG
         tQ1aZB39oeE05tvYSP9z6JNK1Hbuf6R9jY8nDKp0WGmpeBYe2cD68E77AoYt8bqYT7a/
         lqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763100052; x=1763704852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WmGe/VGuYfrow1+cTg8GsPpK6vNwvcURmH5IbRl3Ggw=;
        b=SMWnCBHE+fdioLiQm01TFlbNPHh8Byza/WgdLLK2ByWDvwOfrngDw9iBEiAO+tiEqW
         iugKIL5T6AYM9Hm0vtoNm7a0deyygQV9oVJ8jQbsMUNW8dAQzW0A98Gt7nYINm3HW9Zv
         MOjqSRwSv1ryBOzByXfj0RgRPE2uaSyl5rqNWCHtY6meRBXyqphX5xRwHt7DD52BeLh4
         hJgCCNTv2OThfiCkNeyMG/nYEDpdhM74I9ogYv6JtoNyLXzs1JCDziK9AM0hK8cojRYO
         jbx8riYpTpFWN3ZHZef1tgAs0+eaIXUdsC/H+0XVmL9iVAyvjgkLX58jD/bNs78LUGd7
         TKwA==
X-Forwarded-Encrypted: i=1; AJvYcCXqm+xEAHueut/OuJa1jjnBTm9k0Ti+RbA7HPhVb4nQEyKYD+VGy5oYXUgEDW4I/pPCW/VluPIBr7o+@lists.infradead.org
X-Gm-Message-State: AOJu0Yy/Y0WbJBayAuw5STmka8Kv4yu32X/CFfFFwvqud/qb1lOUgU54
	TmvG8VJ6bGZx5M5iIT8eQ5lmQVRGwFIDC553GQM9mbRZKljvaUtGdDWUE1XS0Qf+0jY=
X-Gm-Gg: ASbGncuxvas06phDKkFr0j7oQWnoWccN4LxGKxb36enFrjCBtACclSJsRoOJ1J1ILHM
	KmSs/UHa/Uv1THXpVQnfjzGENcUIp9vAotttdbg0jph7iKWdmKmzN30L89ux5HUU2IP/9OSUzxV
	t9YNqFk8BQ6j3j9THGp9dkmSg73GK+YjPR88MxJblMd1T23VXlpsi43ZvBa5RQTo0DQMO2ggJMh
	eN5gHZgcfuU86hUYfIscyTPEFeTzQcM/1INKN43wjNKhLAVnWM+4Yv7N7wgzg24P6PxJwSy/f1s
	NzyD71Gue0Drf7thg+40llB9fXSTGJRcCUqZzYhU8n0KaGvlNQBjD3Vrl1qPMyzIb/LwIjAhxW4
	YhyspLzOcjMJgeI9DbazYLEqfCnwvDaZMu45y4JnfNn1CNC1Rt7cKMNmJxeqiJayVZgyLuynBRt
	8Iy6ai0B7uvNcq2epbwLtY8919
X-Google-Smtp-Source: AGHT+IE7lHXKbSg0FY2N6GECOYDuJxXFgUxUajs+hyWaWoZbadwsoEmHcwEF6EJwnMXpyL4EQeUVcA==
X-Received: by 2002:a17:903:2f0e:b0:298:485d:5571 with SMTP id d9443c01a7336-2986a75f1f6mr19001495ad.54.1763100052199;
        Thu, 13 Nov 2025 22:00:52 -0800 (PST)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:22d2:323c:497d:adbd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e07b4b23sm7858577a91.13.2025.11.13.22.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 22:00:51 -0800 (PST)
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
Subject: [PATCH v5 1/6] lib/base64: Add support for multiple variants
Date: Fri, 14 Nov 2025 14:00:45 +0800
Message-Id: <20251114060045.88792-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114055829.87814-1-409411716@gms.tku.edu.tw>
References: <20251114055829.87814-1-409411716@gms.tku.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_220053_181478_AFE55C7B 
X-CRM114-Status: GOOD (  22.74  )
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
index 1f51fbebd9fa..e07e7d4bf8b6 100644
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
index 660d4cb1ef31..a2c6c9222da3 100644
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
index b736a7a431c5..a7c20a8e8e98 100644
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


