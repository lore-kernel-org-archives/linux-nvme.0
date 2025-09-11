Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1839CAC58D
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Sep 2025 07:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9sqCK5RjxgMvTS/KMSGZswVuHs/rB1hx6QH50USYYeg=; b=Qtr0IUEQOGBVAROMI5PG7AHiyr
	XsFZ9rdphC2qAAZiUM1IFZNACn65FvlUVy+I1r2iZQHzfTmFVZFtIZ/CVzloryO4HYWq/czHhwosh
	K+gjhognOTs5TzzwJm2nG4l7PnL75aMBofd2IN7TuTXI82MNlNlfDQD6Z1/Ja8g66SXz/RTAeKsId
	az9Mq+COm5L3WhEG77Ii3t3EFdRU9b4P6jvpNGIJb5B0K72A0MVa7BLfjfcu5XfXbU6EHC1+b0sRH
	HlRbJTb83wAlDqLMKyYoE1Y4ZdrQi5I+nBAwk4IYE5TtFCYOksfelR8NuWAJ0R5yXhEuikHth+e6f
	LGumxebw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwbnl-00000001VlJ-0LKQ;
	Thu, 11 Sep 2025 07:33:05 +0000
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwbnj-00000001VjX-0jcR
	for linux-nvme@lists.infradead.org;
	Thu, 11 Sep 2025 07:33:04 +0000
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-24cde6c65d1so2910005ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 11 Sep 2025 00:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1757575982; x=1758180782; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9sqCK5RjxgMvTS/KMSGZswVuHs/rB1hx6QH50USYYeg=;
        b=LK0XsTyeE+HVgeG00THYU3MwNY4aiwCTR2KOWAOROk36SSg0R55blZdaqMQQxqpgNm
         l4/XN0TLCGijB+cqQ6C+JjpLkF4r9uFMtPu/cbprsk8OYtUbbX2/JtFkneOMinqOxx9+
         Je/dyWQaKCFkoTiMM4Vs12acN70THxvpftUMf6TZhgX0STDJqUQkbkuwTFdbjVJtJpbO
         G5NfPBDuwCdYW2FK9k3AtRwi9RyuwdJv3lqKv1hmK9c2ZpKhm0LJ7wwQKAiF6PA6aQK6
         vUePbLQozckYSRg6l01FQ3Cz92LdqMe2wld2GJM8Lx6lNvpOmpkVRLhTiEa0h/vQ9i9o
         n8xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757575982; x=1758180782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9sqCK5RjxgMvTS/KMSGZswVuHs/rB1hx6QH50USYYeg=;
        b=dmV0cCKRuXuCOYEwNnVa9ooUjqPgfz0zTdCtQsrX1tDZtokPwmoltUE6GdCQcAOTAC
         nlWWs4PuoHOpiTuod4kQdoMlSGr4EncreEdt4xrXRaj9vdgC5p+e8XVmmAdqhS5xqhEI
         XfQ5Ym0iPXWkBa3QhPKZ0WqVMnSfh92y6u1nEMaOSmbDWHwMKil3mI70wi6QDTD8pzj/
         kt1gLcIQCUeSaMW4ByyL1pEa3ZBPAny5ItflQ3cfSxuxW+TFTorWf9Zcv81z/888hvvG
         Eu9FJHfKx9TybsaW/LipOO0F4Ic7w3xGQRhiNTQx1xE09puwpAfBZb5gvb9800X8VJSb
         exhA==
X-Forwarded-Encrypted: i=1; AJvYcCUATaPeHrLIs+ZfwfozP/uQHDCHb4xBdAQHVeyD9y9cpBXWMpKpTWJiVfNDShu+SP4L72CZVGQpWDmg@lists.infradead.org
X-Gm-Message-State: AOJu0Yz/htwRfalzaPQjB2mbsJFtoEoLCBglvS4+T5FWBqXEDVGtbjh+
	sFThXOCTtP8K+tbpsVg7BkTiwqikmQfUmNc2oqf36r8Dm+nSQ1MWhvsf4k1HJi+RUjs=
X-Gm-Gg: ASbGncuXzfv6In6VBVDwlYWSxPnuFdhjsyTel8S/oyXe5qPj5sFxCU1sMRcXptA6R5f
	swMr0o7RtNYd7DYqUeRiD0pXz2XmCbyg0lqaeG2onD+CgXV+BXMNYMqHM0i4DRWKU8ls/VymjTC
	naW6THWYMZ7Vb3jEsCetDO0mcYJnWEwKM3Ujk1eXbXPLyppAt5xoPRohvzHLInoAua6cv+RMPEy
	GJkzl2eTumjpZ/ce2lEQKJXUwIRjthJqQIQySpyrVSztQa/JL5v6N42aw1d4AeAER8QqZqDsy1h
	G2o1YDHOG0LnLBwx1CJ742CO+QDGbjryzhePMPnBRT7MSo/LE1JrrNanmLvULjCZdVLZ85qXnbY
	3Zo5dhwqEOWy0c257ujr0cvOD1VRmI8dzLMLsIJY544rIhvKF1yTaVwhMBg==
X-Google-Smtp-Source: AGHT+IFD9aePnHBtB13DZnlZ8Ibfo6GnzucKKeZU8KCH9/Ow9xL5SQ7qcnFeRVs1LbSv8OFB76dPGQ==
X-Received: by 2002:a17:902:d511:b0:250:643e:c947 with SMTP id d9443c01a7336-251715f34e4mr234231735ad.28.1757575982336;
        Thu, 11 Sep 2025 00:33:02 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:7811:c085:c184:85be])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c36cc6c2csm9959415ad.11.2025.09.11.00.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 00:33:01 -0700 (PDT)
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	xiubli@redhat.com,
	idryomov@gmail.com,
	ebiggers@kernel.org,
	tytso@mit.edu,
	jaegeuk@kernel.org,
	akpm@linux-foundation.org
Cc: visitorckw@gmail.com,
	home7438072@gmail.com,
	409411716@gms.tku.edu.tw,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	ceph-devel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: [PATCH v2 4/5] fscrypt: replace local base64url helpers with generic lib/base64 helpers
Date: Thu, 11 Sep 2025 15:32:54 +0800
Message-Id: <20250911073254.581898-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_003303_230373_C501E532 
X-CRM114-Status: GOOD (  21.37  )
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

Replace the existing local base64url encoding and decoding functions in
fscrypt with the generic base64_encode_custom and base64_decode_custom
helpers from the kernel's lib/base64 library.

This removes custom implementations in fscrypt, reduces code duplication,
and leverages the well-maintained, standard base64 code within the kernel.

The new helpers preserve RFC 4648-compliant URL-safe Base64 encoding
without padding behavior, ensuring no functional changes.

At the same time, they also deliver significant performance gains: with the
optimized encoder and decoder, encoding runs about 2.7x faster and decoding
achieves 12-15x improvements over the previous implementation.

This improves maintainability and aligns fscrypt with other kernel
components using the generic base64 helpers.

Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 fs/crypto/fname.c | 86 ++++-------------------------------------------
 1 file changed, 6 insertions(+), 80 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index f9f6713e1..38be85cd5 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -17,6 +17,7 @@
 #include <linux/export.h>
 #include <linux/namei.h>
 #include <linux/scatterlist.h>
+#include <linux/base64.h>
 
 #include "fscrypt_private.h"
 
@@ -72,7 +73,7 @@ struct fscrypt_nokey_name {
 
 /* Encoded size of max-size no-key name */
 #define FSCRYPT_NOKEY_NAME_MAX_ENCODED \
-		FSCRYPT_BASE64URL_CHARS(FSCRYPT_NOKEY_NAME_MAX)
+		BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX)
 
 static inline bool fscrypt_is_dot_dotdot(const struct qstr *str)
 {
@@ -166,81 +167,6 @@ static int fname_decrypt(const struct inode *inode,
 static const char base64url_table[65] =
 	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
 
-#define FSCRYPT_BASE64URL_CHARS(nbytes)	DIV_ROUND_UP((nbytes) * 4, 3)
-
-/**
- * fscrypt_base64url_encode() - base64url-encode some binary data
- * @src: the binary data to encode
- * @srclen: the length of @src in bytes
- * @dst: (output) the base64url-encoded string.  Not NUL-terminated.
- *
- * Encodes data using base64url encoding, i.e. the "Base 64 Encoding with URL
- * and Filename Safe Alphabet" specified by RFC 4648.  '='-padding isn't used,
- * as it's unneeded and not required by the RFC.  base64url is used instead of
- * base64 to avoid the '/' character, which isn't allowed in filenames.
- *
- * Return: the length of the resulting base64url-encoded string in bytes.
- *	   This will be equal to FSCRYPT_BASE64URL_CHARS(srclen).
- */
-static int fscrypt_base64url_encode(const u8 *src, int srclen, char *dst)
-{
-	u32 ac = 0;
-	int bits = 0;
-	int i;
-	char *cp = dst;
-
-	for (i = 0; i < srclen; i++) {
-		ac = (ac << 8) | src[i];
-		bits += 8;
-		do {
-			bits -= 6;
-			*cp++ = base64url_table[(ac >> bits) & 0x3f];
-		} while (bits >= 6);
-	}
-	if (bits)
-		*cp++ = base64url_table[(ac << (6 - bits)) & 0x3f];
-	return cp - dst;
-}
-
-/**
- * fscrypt_base64url_decode() - base64url-decode a string
- * @src: the string to decode.  Doesn't need to be NUL-terminated.
- * @srclen: the length of @src in bytes
- * @dst: (output) the decoded binary data
- *
- * Decodes a string using base64url encoding, i.e. the "Base 64 Encoding with
- * URL and Filename Safe Alphabet" specified by RFC 4648.  '='-padding isn't
- * accepted, nor are non-encoding characters such as whitespace.
- *
- * This implementation hasn't been optimized for performance.
- *
- * Return: the length of the resulting decoded binary data in bytes,
- *	   or -1 if the string isn't a valid base64url string.
- */
-static int fscrypt_base64url_decode(const char *src, int srclen, u8 *dst)
-{
-	u32 ac = 0;
-	int bits = 0;
-	int i;
-	u8 *bp = dst;
-
-	for (i = 0; i < srclen; i++) {
-		const char *p = strchr(base64url_table, src[i]);
-
-		if (p == NULL || src[i] == 0)
-			return -1;
-		ac = (ac << 6) | (p - base64url_table);
-		bits += 6;
-		if (bits >= 8) {
-			bits -= 8;
-			*bp++ = (u8)(ac >> bits);
-		}
-	}
-	if (ac & ((1 << bits) - 1))
-		return -1;
-	return bp - dst;
-}
-
 bool __fscrypt_fname_encrypted_size(const union fscrypt_policy *policy,
 				    u32 orig_len, u32 max_len,
 				    u32 *encrypted_len_ret)
@@ -387,8 +313,8 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 		       nokey_name.sha256);
 		size = FSCRYPT_NOKEY_NAME_MAX;
 	}
-	oname->len = fscrypt_base64url_encode((const u8 *)&nokey_name, size,
-					      oname->name);
+	oname->len = base64_encode((const u8 *)&nokey_name, size,
+				   oname->name, false, base64url_table);
 	return 0;
 }
 EXPORT_SYMBOL(fscrypt_fname_disk_to_usr);
@@ -467,8 +393,8 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 	if (fname->crypto_buf.name == NULL)
 		return -ENOMEM;
 
-	ret = fscrypt_base64url_decode(iname->name, iname->len,
-				       fname->crypto_buf.name);
+	ret = base64_decode(iname->name, iname->len,
+			    fname->crypto_buf.name, false, base64url_table);
 	if (ret < (int)offsetof(struct fscrypt_nokey_name, bytes[1]) ||
 	    (ret > offsetof(struct fscrypt_nokey_name, sha256) &&
 	     ret != FSCRYPT_NOKEY_NAME_MAX)) {
-- 
2.34.1


