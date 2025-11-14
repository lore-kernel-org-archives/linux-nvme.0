Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9E4CDE006
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 06:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ERv4XtgoXPP2dPnpwcSEeS4AUqPV+CdFVlWhf34t39A=; b=TV1JsnOO2LvLzneEeuGqiFFqCv
	OizVRlrY4eW4dRV7akFQT90Xp6sKQMV3FVtcOKlOQYFtvXThmd2A+0dgpxMODkC8T1Hk+owIjSZoU
	vrwXURdyL5mPpdEXzDLMWeOqloTomDuHmNhh7FtvG+H6kxiM860Ss6B5nk+Wvzyk8KoOS4uiBdRGF
	+qBrkNioxXfID5ieZmLesygDl2eWsr6HjS9PUiE5Dfo4fHfups31uCITUuosxBP+fUArg68wtsHLj
	8++nPNTAT/226Q+ywh6SfwWMFlxdmkZF7jiRECWGBVYQjk3Aoaa7wesb/BDh9ie+3X8nwdnWjUhnw
	VQhHw3lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJmtC-0000000Bcsv-1PwR;
	Fri, 14 Nov 2025 06:02:30 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJmt9-0000000Bcrh-3751
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 06:02:28 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2956d816c10so17473175ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 22:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1763100147; x=1763704947; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERv4XtgoXPP2dPnpwcSEeS4AUqPV+CdFVlWhf34t39A=;
        b=Gdn502GNCJaVkxTBmUKWw1snYCLhhNChbbe6NrT+soZjGIcobfc33Fq6Ps+tHzIwiE
         w9o+YXUXZVilMMp1IHE+dtUZ7+ILmMsRKdA+dyoF2MoUGwcfH3R+Vnzq3J0APIBpvpLO
         5cIuKirLkJEALFy1kKYE4u8ZdhaDX93QauytGe5pRqyRpfktj41eZtdxw0tgCftPRLnS
         i1QzBKdCeDTPBfrP6AWXxZdScaAybWsZBx1Edrls/NNU21hyvfbZqNA5wajdeRGkLJMc
         scfY5X6GWY3KWn8hYmMzyFNHZt1FtOtjkzbXYkWGcArIy07hvIKkOJ3rffMvWZlOZN0W
         GxSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763100147; x=1763704947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ERv4XtgoXPP2dPnpwcSEeS4AUqPV+CdFVlWhf34t39A=;
        b=CK7RaDUfqKta9rMBAw4mTS1USwfNbjG2Hy7UnlYgU/U6l+2ANCRESPzymP3CzSqnAu
         YnVjKPkrYASlYvSbyfEHmKJPXCPPpgTFELzf87JQ9ZVARFMOJTOOG5mSOMwJURTSxeCk
         rJNgZgB6p4NAle8v0JNoA9R6a0oMZZo9RAmVGlD/Ikdb1i8nWmkPVdfY/jNJoSx2QMwJ
         aOp4tnO4dBdAj2N7k+93EzkWT9Gb+6QwLEoeX9KDRRnZu/uI3D4THTBNu7KSpfNB2BpN
         KUlG2HS3Gqi/9r4bb24L3779pHi9QBdfvxAu5ks2OxlN4f9wemqqS/3PNyKxqTh2xOmd
         Kw9A==
X-Forwarded-Encrypted: i=1; AJvYcCVj8pdTMpAKFQ4+Ax6kaGDaLP4mgQjAzju5s/1DA8yJBfFP9r+82hdSHXocSC1Cpvz9HvbJGiAJFdwV@lists.infradead.org
X-Gm-Message-State: AOJu0YwdUr4bf+1hQMoYHIQkkILI5wfSp2FQzJpJxUIhhwV+voPkaEUM
	iuUA1hy2fIN0CjuNLfX9iHQq5LbLVZHRQ0KlxlZBfOquw5ZKaHBOO2pN4scpUgbcysk=
X-Gm-Gg: ASbGnctBBev1PD39LLnoASXhDaGeKCH6YrxmzHSgGV/sB4BAczijElBoUEtOjJBiTYj
	sFmNWSNwtPjyKpPcJ0TuuNK0Ics5+tD4wuhyw1DBXJ4VsFc1iT091PssmTDzHyebt53UbL37szu
	lJ//XKJJOKSyveZMHZ18ljaEZH9SPJOW396zOxJVKAOsSKZCeh8z2a0MEFsnn4DNP5ZEsu8274F
	HYdhy3Fx5CJyoLH1wmosuKzGUazU1YnoWM/taaDffnY8KgV/NgdNNJ9SpSDNu3nWdx/EKvAXxCY
	5txlIAhLxycQ40Vlz36Yh2xIU7CJZxmck+1pWXCHmcikGkwhdH7IoccEftQAc7lUnFko8mqj6AI
	BoGNELeQQBMZr8ERzWGKg0+1bTJOKuD91RMa2Q6wRj2tMXGVJb318gi26afv3/I9OEgCuvjevaP
	SNuxvUfJhVI9y9CA5wFs8pYfSY
X-Google-Smtp-Source: AGHT+IFs317cxuw2DDSKPoB1op+RLqXuzE2pstLiig2tLA8KeXhRrXBdYzwc2MB74Tur9nS/jMyR0Q==
X-Received: by 2002:a17:902:cf08:b0:265:47:a7bd with SMTP id d9443c01a7336-2986a6bcff3mr20918665ad.4.1763100146747;
        Thu, 13 Nov 2025 22:02:26 -0800 (PST)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:22d2:323c:497d:adbd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2bf17dsm42818665ad.94.2025.11.13.22.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 22:02:26 -0800 (PST)
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
Subject: [PATCH v5 5/6] fscrypt: replace local base64url helpers with lib/base64
Date: Fri, 14 Nov 2025 14:02:21 +0800
Message-Id: <20251114060221.89734-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114055829.87814-1-409411716@gms.tku.edu.tw>
References: <20251114055829.87814-1-409411716@gms.tku.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_220227_784301_0C4B6CD0 
X-CRM114-Status: GOOD (  20.31  )
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
index 8e4c213d418b..a9a4432d12ba 100644
--- a/fs/crypto/fname.c
+++ b/fs/crypto/fname.c
@@ -16,6 +16,7 @@
 #include <linux/export.h>
 #include <linux/namei.h>
 #include <linux/scatterlist.h>
+#include <linux/base64.h>
 
 #include "fscrypt_private.h"
 
@@ -71,7 +72,7 @@ struct fscrypt_nokey_name {
 
 /* Encoded size of max-size no-key name */
 #define FSCRYPT_NOKEY_NAME_MAX_ENCODED \
-		FSCRYPT_BASE64URL_CHARS(FSCRYPT_NOKEY_NAME_MAX)
+		BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX)
 
 static inline bool fscrypt_is_dot_dotdot(const struct qstr *str)
 {
@@ -162,84 +163,6 @@ static int fname_decrypt(const struct inode *inode,
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


