Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF72FCCF9E9
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 10:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BlnFareBsbb11YH09aBxV9jcp59svMC58VGTOIUCegI=; b=HB9h8UOuqwpdHomeqJkowm0FY8
	Sokbh+hoSVShjN4Fu934q3vX/oOfqnzvJvdJwgmYMDfkUAfQ5IFhr0cGmIhJxbeCnvVhgdOlNVTvd
	oF6M+7VF/CbJSmr486FuNJJbYceHa2IFN3za9J7Vo/Rmp6YAmoBGKeWlsylAcCYbirIfv0kzHtpKO
	lGcvGlXIfh4okfBYeVeLmD0D4/A4747LCJqUUp26XuN9Ih1k+z/vDwvk7MxMGGJsJK9OIMli64gUl
	IwyyV/Z2XNuo36RTAWNzSm7R1viiNcN+/1pN1HpjKCaQEjzK7bzLKshZ+zYRhuMt77kGAGSesuOo7
	yU3N870w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE3JL-00000000i0k-1e0R;
	Wed, 29 Oct 2025 10:21:47 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE3JJ-00000000hz5-0EAV
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 10:21:46 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-27d3540a43fso76915315ad.3
        for <linux-nvme@lists.infradead.org>; Wed, 29 Oct 2025 03:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1761733304; x=1762338104; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BlnFareBsbb11YH09aBxV9jcp59svMC58VGTOIUCegI=;
        b=yYQjYlULrZSBHcRLaHyxVOx1IoaxaJm9jI3KxSIwcjFca/IPjjxVp3gPpUV3RKeLQG
         D4FlYwud15Bt+ygHiIcK9XticlTd6FuC2ROKT0gcZHXgHNHZKhQbkVynWQFy7Me+NHgu
         iph2CKKcpo5cadTkiye6f3r8vSSePpQmB3pdKyp/0aOpeCJH5yYOJRDlFJmhdHhxMj1B
         z1JAL1vkMSwVotQrsvJggbs90i/9kUGsXGEfT6+uNdLngtokYijhtRVcwYhxR4SGTObD
         /jrFMH0UboilGs9ZF68ZXUXfyIO22LYGy/3DOK7xq2Ax5czU83JGSZzVItAagJTQBJFD
         oElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761733304; x=1762338104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BlnFareBsbb11YH09aBxV9jcp59svMC58VGTOIUCegI=;
        b=tSUM9FOleQvRY+BUHcoQV3bHd5dHWMKgrgZFWtwQ7+yQEDOzjLQtyNiPLNk+2zgSXq
         YitbscV0M9mHyIBbqDgvbhiQT1wdYyEZgpFRp2VuA0AuttlCMwgx2aZLKd7wDELwwk5s
         enhwcvVgjPUgdGYVpXhmw+/hWcfjqiPe576Nq0AqefQceiWyys58kQAoIe2mIFKyxQQp
         foQns8KZDC1f0glHurgMrSYQDwKd3U8cbMQJmIE6I9hzIvAKFlYmMUVKo3rqt8VRed1p
         9wBBQO9xfYgbr/0SBg3JjeCtohCEu9a1UVXJNFK53427wPdrETSRa9nbe1qDtC6ZDyYp
         2GZw==
X-Forwarded-Encrypted: i=1; AJvYcCVHV9vTRRpAfjsiFBMaqrxQRHxXDGqdMyJhDJTLcE1YZ3S4wdaxU1jSZvtRYDtpan8fOo9Roy+nPHVL@lists.infradead.org
X-Gm-Message-State: AOJu0Yx89UV6WUGTX1sy9ra5N+BC0M4TDTr2Nx4nCcU2JDrI4epvIJ/K
	l3g2FZ5d6lE4zIpYYO9VXyUVrvDBM2jKjhCAnjohXSpO177XUO5jreUca6gGR8jjRZ0=
X-Gm-Gg: ASbGncv4m01KhX8AuoYx+xh6O+3mvYZGmFaNqAl6LYoWwnPhqV0VQ5PeOj/XBCBQJFe
	/+aNOyTRP9SHacConO5s+dF0s3Ck+wW9xi3Gndoe7speNxziPEztcEAKdFI67FyJlJ2HgUzgmNz
	5fbWmt5vzxK6YcMiU4r+WmHETrPFjX7/Tuxte/03xR+xVQXADxeJXUKfj2jZ0W69obNlQFD5ueK
	Da9zXM+qAfMNwW7rEmABdzH/zgtMxLR65QfR71YTt+AXC3FAvYaUJdX0YXC1D1hZeSrR0EGCPD7
	6qZWj76MvsowLc9Ejm/VSLNnLjeGfYtUdLGbbPV+Q89tW0hGOGvTctdEWiJmyPGVIFITtVJeWqa
	t9S79NxNBN4mtVma/vycMtrI/y4WFCvm6ctrvBctwn3x7kGOzByk5iMBY+Calh2zonDNRPO8Nwv
	DWSGuIolq3JRC5tDqiXvcrL2Am
X-Google-Smtp-Source: AGHT+IGM6v5wwL0QkZAKN6UIiQju9YhkO8h6NCZdmJ7iG19cg1e2QNUJaBTWOg7ESy9etZho85VIOA==
X-Received: by 2002:a17:903:42cc:b0:275:81ca:2c5 with SMTP id d9443c01a7336-294def2fe9amr24144575ad.59.1761733304103;
        Wed, 29 Oct 2025 03:21:44 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:3fc9:8c3c:5030:1b20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf4b17sm149959545ad.5.2025.10.29.03.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:21:43 -0700 (PDT)
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
Subject: [PATCH v4 5/6] fscrypt: replace local base64url helpers with lib/base64
Date: Wed, 29 Oct 2025 18:21:38 +0800
Message-Id: <20251029102138.543870-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_032145_103256_6CBEE9D9 
X-CRM114-Status: GOOD (  21.38  )
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
decoding achieves 43-52x speedups compared to the previous implementation.

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
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


