Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24961CAC5AC
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Sep 2025 06:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QX1AvjPYqPc07VyrXJLPNqN7Y76elCWsekCNrFr22Ew=; b=AxRIlDW2gA/13gFdBuh8bULLEE
	hbLmZSWT8efvrHkIAiDAZEj8X4iAPvnkezU5SZlFr1hxj8L+c2xwe/dnYhcx3if5wjZy/MuoLjlTb
	3Oaua97wZbNvz7IxYKAVuy37+NEbx43kF0TInrzfm3JXKfhaIRrRo6gqxxwQ1aWgyptZlraufB7mg
	wz7XTgI2LEnDliIxiYlUB81d7EDP/CW3pf/p55Y0ZPo1kvXdkJqK2jwd+zRrXLI5+8ykZYWAMRWAR
	IZxCNIbgsWwPCR8Th/Pl6u9MoskdHApOwuCH+5pL5Bvjn6NKwmUHwPWeVU4ThCBoarh6rJViHnlY4
	2Z6KPXKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v22O9-0000000GYWv-2JKb;
	Fri, 26 Sep 2025 06:57:05 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v22O7-0000000GYVK-117k
	for linux-nvme@lists.infradead.org;
	Fri, 26 Sep 2025 06:57:04 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-76e4fc419a9so2005946b3a.0
        for <linux-nvme@lists.infradead.org>; Thu, 25 Sep 2025 23:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1758869822; x=1759474622; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QX1AvjPYqPc07VyrXJLPNqN7Y76elCWsekCNrFr22Ew=;
        b=WH+2Zt+DGzPDFJNk0CGGgm1cYtb1oy4qN5Yn9F7parCC+SxsMeTUv0Ao+HJSdKLjQ3
         2NL/jkl/W/qo31rnVSpY5uq3MDxsaDyGaiMEjnrQpN7SxyMYvC0LUoKnwwHN/ev3vRGs
         p46tmxpa6PJYjO683WWHjYcdJrX0QgBfeOTc4mRhRlcROOXtzNyQuOdPUytqV70JN4BV
         BbXXVfQQVaO/mc33CVDwGlIjmcQGRLr9JOBI1CI33Wh9tPG2gjxA5ehuI0Wmdv9PqsKS
         SiV91lI2pCPdQSU1ozRldfil3M9upx3ogAU1ehQHcYMGTbM0LTihZIXbsVquZNYtDlME
         9UxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758869822; x=1759474622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QX1AvjPYqPc07VyrXJLPNqN7Y76elCWsekCNrFr22Ew=;
        b=DhfSWqMuaieUxTd/LqD7wpM1kzvXIYk9sR2x+plCkW15cmOec3b2OEsc/8iEP/cSJ3
         gXzKzLLj0oyL3OcLAw8nY46vavx+RdO3nBn6GvQ3TX4X5jIKnBeTohprkcwxvpWp1wK/
         PvLG8F4WBdbx/+TDlU06hGudEMmj/rBU18O/VUBtbeDQSaiPG3wLNfikJnWJ9KhHI6uD
         Qj133oSjzLgpB02cevelKA/rFsh4x4Hz3/H8xMlKkC4q2kDvgU06/PgULhzgMsQtTeDs
         l0H4Tr2hUv8sVCQUR7GHyQnlai7dMDxjRDGeb+KTujwdkr/lem/r1yTHAwlC1X7MTd45
         q2Uw==
X-Forwarded-Encrypted: i=1; AJvYcCV/mUw/2EUjeiAPPu89FuoxX9CGMtUpi4SmP6k0ZTeX8aO+0Ou0cmp5Le77udCXx1UYjJrJCSOu4gvM@lists.infradead.org
X-Gm-Message-State: AOJu0Yz23RbNPd4uf6TvOMF5FX4Aqh92Yb81Od2o+8gAnPdOMU/ahVgF
	IcYhA9IXz6e0zi/uQeyGCJdthGHu4JJV/Av4uP8U5Y6QHAMh5p3VySLE3C6haMrdOCY=
X-Gm-Gg: ASbGncvaolWvr29gDAYnEQuSTKg4dcjut4kULsW3zTWT7m1g1yyR3Ps4ehwC8u9kUuX
	52w+9YOc/HVF7ztIVWSI5A6W2nMFfmZM/oyuN43zgk7FGNLJuSVbb45VD2iyKsJs0CbpUZcdcdw
	7OxXuzRO8gxjOHkU8gawxZzkBK95PecK/80u7zP5GABhlmjH5OlU0Xmd2DHzYQHstBlSOE0ZhsG
	DGqNd9J/e7hgdQ0euvkP3jEJTFNzx5sOqsWU+o53tmCaF8IbXqx295vIXzJolnIB+lmYhhkJccG
	VycYsH9LNYWxhyJEYD7Dh0S1Ywi1RKvsGQTnAWF+BCyosoBagTLrePc0tRbTV8krIQN8ZyLLvBe
	CSjIjFYwIo9+10uuYVBWGPyoVPeAu8zz5VGodZlUHBm+BUrQbTFOJHRJJXw==
X-Google-Smtp-Source: AGHT+IEJuoFu3AqWz+6Ia84gW9VhTEjnQyT1iUNvqk+U9XhDT4f46dcSlDiMFRq3zQJq5LoCWNwKLA==
X-Received: by 2002:a05:6a00:853:b0:772:3ea3:3218 with SMTP id d2e1a72fcca58-780fcec0a66mr5554818b3a.23.1758869822399;
        Thu, 25 Sep 2025 23:57:02 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:94ad:363a:4161:464c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023c158fsm3654182b3a.24.2025.09.25.23.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 23:57:01 -0700 (PDT)
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
Subject: [PATCH v3 5/6] fscrypt: replace local base64url helpers with lib/base64
Date: Fri, 26 Sep 2025 14:56:56 +0800
Message-Id: <20250926065656.14522-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_235703_287015_A33C2C71 
X-CRM114-Status: GOOD (  20.82  )
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

Replace the base64url encoding and decoding functions in fscrypt with the
generic base64_encode() and base64_decode() helpers from lib/base64.

This removes the custom implementation in fscrypt, reduces code
duplication, and relies on the shared Base64 implementation in lib.
The helpers preserve RFC 4648-compliant URL-safe Base64 encoding without
padding, so there are no functional changes.

This change also improves performance: encoding is about 2.7x faster and
decoding achieves 23-28x speedups compared to the previous implementation.

Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 fs/crypto/fname.c | 89 ++++-------------------------------------------
 1 file changed, 6 insertions(+), 83 deletions(-)

diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
index f9f6713e1..dcf7cff70 100644
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
@@ -163,84 +164,6 @@ static int fname_decrypt(const struct inode *inode,
 	return 0;
 }
 
-static const char base64url_table[65] =
-	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_";
-
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
@@ -387,8 +310,8 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
 		       nokey_name.sha256);
 		size = FSCRYPT_NOKEY_NAME_MAX;
 	}
-	oname->len = fscrypt_base64url_encode((const u8 *)&nokey_name, size,
-					      oname->name);
+	oname->len = base64_encode((const u8 *)&nokey_name, size,
+				   oname->name, false, BASE64_URLSAFE);
 	return 0;
 }
 EXPORT_SYMBOL(fscrypt_fname_disk_to_usr);
@@ -467,8 +390,8 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
 	if (fname->crypto_buf.name == NULL)
 		return -ENOMEM;
 
-	ret = fscrypt_base64url_decode(iname->name, iname->len,
-				       fname->crypto_buf.name);
+	ret = base64_decode(iname->name, iname->len,
+			    fname->crypto_buf.name, false, BASE64_URLSAFE);
 	if (ret < (int)offsetof(struct fscrypt_nokey_name, bytes[1]) ||
 	    (ret > offsetof(struct fscrypt_nokey_name, sha256) &&
 	     ret != FSCRYPT_NOKEY_NAME_MAX)) {
-- 
2.34.1


