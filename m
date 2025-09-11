Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C692CA1016
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Sep 2025 07:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9sqCK5RjxgMvTS/KMSGZswVuHs/rB1hx6QH50USYYeg=; b=340Yxwk4hsN2Zuup1Z2C5BP30s
	CLNCP+Hwd7vCDAFsjdg2qELLBCmgq39XTiD42kY2sMXaFmHCoT4Rz5RrIlGTCqWBLEAB7A6oQ1zIv
	cFyadSTP5N4ChTRmUO0kier7/Wejwk0XdHUSoGB/yQrD4T3FTA9qB9Qx9URjTetWqljkAvkYsFoTv
	rgNTJBHDo/Hzte3jDqUkRw0UnYeiAin7xQw3gnsDRnnHSacsElSd03oFZKUFp9sPo7jwFzBg6bZnJ
	vQaNc+efcvhkDca278Vx9VtsN04i/hP4qvVXTI05OCDbYWpXY0Jwx/FBvmxthreBGg+eVuNIPVmlL
	NfRyxCVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwc0N-00000001aMS-2jZv;
	Thu, 11 Sep 2025 07:46:07 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwc0J-00000001aJR-1O2d
	for linux-nvme@lists.infradead.org;
	Thu, 11 Sep 2025 07:46:06 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-772301f8a4cso605672b3a.3
        for <linux-nvme@lists.infradead.org>; Thu, 11 Sep 2025 00:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1757576762; x=1758181562; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9sqCK5RjxgMvTS/KMSGZswVuHs/rB1hx6QH50USYYeg=;
        b=XwjNeMCAOelfhkVKFQkDNEJhXCaAOJcJtEK0CaWLmayjL2vzatuAbSmHLkJ0OKlHjp
         9QkXeNS1v6aFNermJcGd6avqt8TbWCRsaYUktyv7v+OwwZ4Wlj47lTj8oRYBEHxY0j6X
         DcOwRHxQWrCNbVyqnyOQODhEsqAN5EpYffiFOf84K98eZgR6RA5FH6svylrfZiksEDQO
         DQ9jzbyscijW+Ag1nzvQ3TXoLTcaHrUQVmcAq90yJRgK7pzXWxGbM17p6Dk6X1IVh2ff
         EKxUrXk5mlnT6JOSMkniaLKhBFevAX6wBv+n4eXXDFh5SawXqMwdQyzJgargqucQ3OU7
         iEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757576762; x=1758181562;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9sqCK5RjxgMvTS/KMSGZswVuHs/rB1hx6QH50USYYeg=;
        b=shrnoscYl3SYr6SB5HSAunC8V+vJGEPwJu5KiOFaX6rvvdQHcwydC78yoymssL8ZUW
         iKHxh1gtA0B7vSuh8dAJQUbrfngcq1GoDvRC1H/LOlzN9kboAiSiA9IjfsWaN/MVAYw1
         AAzFovnP0VYexu8yomgvOhJEdF5jS/c1SGbxLc7npow8Rq8d8Wq76kiNhLMdO3RpFLKY
         yIcwi1lAwkadjuNcVk3By1XQc64pCdUroyI/4YykiF0loprmXQczReN0D/bfFK33Be8B
         tfj5Oi03D3qqsLNiW6e31m8unEIT0A2C/H+Kqj78RAmWMTSsKYBDQmDkk5x7ixngv7sg
         UTrA==
X-Forwarded-Encrypted: i=1; AJvYcCUBIGxJlRuW+fGOMsb4i8GNH5wO06Vz1zi4MmuSxYTiviEJx3RRlPlPLVR7w50uYMtGUJUJ3VZ/l2xm@lists.infradead.org
X-Gm-Message-State: AOJu0YyzqT/Tr1rCI2zIuVlwEN799Ol1BysYnp2A4mZvP9Z8FVwfriir
	uq/nNJ9Nf0e1h19Bqifiyu1Gby1gskuNBygx6ykMWkn0gsDk8OuWCVui2wk9r3dkrGfLVp+YwX2
	rxAGlxoU=
X-Gm-Gg: ASbGncudZxDBEf3d2uP8gdzwrQbvVQ3JyxDLcmeE5/Jvqbvl79u5ojSeE6D3Mnr7stF
	Go+1q80Q9bdbClGwmwJ7pZrFjpn8bAqcLbUJ4qKKAGlEv0gvaHKnltoTcLrKZGc7zpsBjyk6kpF
	2W2rAv1CiBSc4KiN+pkJS4+p0owA87LGQxBVMBYdtBMMdIU2V/OBmYq/yKebPNrpq3NIQmjLnp8
	R1e0pTbKNtrheFytueIrWIQPQgwfgOMW1EIFSINdsK7Ppp4DBj0GP4hTv8JEieeYzqdvCjNtL62
	vZtQkDTCajXN3boc6ixgOVjiKwGbSuz4XeZbOGQkjPWzyZfRdHPWzh5Yxfb1dhwObXtGPNaUQL9
	/75Q4L8E4TJeiQK3kwRvVauyh1yeoF0Lqh/MpRlJnQ8aaHEZj3ctQ2WLxfxi/XD1zyjYB
X-Google-Smtp-Source: AGHT+IFTtCHwqNfIBOXwlFvy/P0nkEKjAL4uI3LrM5NYhtuUi4RxaoEj1xk7ImpRtf5RyJZJwkkNeg==
X-Received: by 2002:a05:6a00:1a8f:b0:772:2850:783d with SMTP id d2e1a72fcca58-7742dedf06emr24743666b3a.22.1757576762510;
        Thu, 11 Sep 2025 00:46:02 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:7811:c085:c184:85be])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607b18424sm1134273b3a.63.2025.09.11.00.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 00:46:01 -0700 (PDT)
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
Subject: [PATCH v2 4/5] fscrypt: replace local base64url helpers with generic lib/base64 helpers
Date: Thu, 11 Sep 2025 15:45:56 +0800
Message-Id: <20250911074556.691401-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_004603_368187_86206124 
X-CRM114-Status: GOOD (  21.45  )
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


