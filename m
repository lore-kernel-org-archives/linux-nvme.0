Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 482EACAC5AE
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Sep 2025 06:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=igTUGl2eyyaTZ+rlOxfJOLC6Xg0h3npTvJ/qhTpvyus=; b=QoP9cYIw90WVapdn1552ibuDt2
	ROM/ClCn+D2RYo5REPDyTPX1haZ7l731HKxKjnVEJ1jCI/KtrGuPgQinQvlXyU+MccXkRktkRvReZ
	LI/F7DnAH1uaJXpFpkS5854rERimSZ88bSEDUyQkpVhl2ZWiWp2KCk3Q8WlQ9/u7AsVlzgDhOOrss
	RSwHZckOnOsRrQlcp38mrgKLc4q416KOee3YQQtvvjpBAj0DDCDfCT+u5yHDfynOFTuSBkQuWcqiH
	kbrRXD0yaBZ2Hhj2Mj4jTZr+lpZd9w46AF/PPYtFQpSTAkH75N787fuhmMpqReddos7cwT+PIlFBD
	YwIl/LtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v22OQ-0000000GYhT-2TRu;
	Fri, 26 Sep 2025 06:57:22 +0000
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v22OM-0000000GYeZ-3TwI
	for linux-nvme@lists.infradead.org;
	Fri, 26 Sep 2025 06:57:20 +0000
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-b57f361a8fdso344515a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 25 Sep 2025 23:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1758869838; x=1759474638; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igTUGl2eyyaTZ+rlOxfJOLC6Xg0h3npTvJ/qhTpvyus=;
        b=wd2FAyatYPi8HjeZahryfioJwrGuN7ld8S894qCxdCISCng1eIq4T+8PiwVceqYnxr
         T6xHFpDa6AyrWdQKRE2YqAXXJu5p30YZK/otbGnT/kyqUwj4G1mfO7pGXJSpcrJ9qSZn
         mt4CXeE731AArQCBLQFvaVunbd4RfPeLmzi7qW4bQtS3P5TmrawqZT262lb/p7oISrnc
         dl9y0bhkinm+DP0rnORmYFCyorXsX4G7uQCbvIfMRYeN9qnfHFATAqM/Cdbs484ULmby
         FLORNzyFXnMzO3FSZgHNdaVoOsDtszA6ZWgWq8nR6dx7GP9xsYOfpFIGgwjq1QM6+BEZ
         XqxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758869838; x=1759474638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igTUGl2eyyaTZ+rlOxfJOLC6Xg0h3npTvJ/qhTpvyus=;
        b=wiTBiWUZqYe9JVHAm9ARK+u02WZMmV9uVuLz6Js5v6/b4D9UCsJd9ri3IulVzyp5lr
         OegHGGOjotyYPKrYXYeU23bkJ+JEVxCxatGaDKqGt7qmFRpd3akKCjMDU/oA5fljzTvu
         LE9suqRGIri1lETi9+PQO+BiXpKOC4WghMT4b3cUwbA3l0r+Toj0eiTwlX4NwE4RLiv0
         NJdBMRSZAEhXbzMg+o1f9usiB4e+I08KDJ7e0L0biDx2Qjjv4Y0WJngRsXQ9LoIje2em
         56SJs6v/ltD8LYiVey02pPWm5CYDWF+X8GpWLaa13qysKSw55oWS/mJEd/ZYPxOKFya1
         l7ng==
X-Forwarded-Encrypted: i=1; AJvYcCXxAomKmRcFwPXJ80jvO3hYJ0PbvjesLfdGJ43+OsGy+1L6WRLk595CuNTM2XkxzzVPSq0KyMPumCc/@lists.infradead.org
X-Gm-Message-State: AOJu0YzIuPEd66uqgTtiF15MedL7FMX2uZirHobzGdgTozUdZj/SdeiC
	TFa7hmcNGnPOff1ZVzq2UBrh3C3aD7mSXEbHdD7BzDqrYs2yHyAtIQ0xfASToRgC51o=
X-Gm-Gg: ASbGncvsnTDaxpbu8Khr4XdYSFXHeHvmd+sncJ70b7Gyg/Ong94DX5e18AqXbyl5WZp
	BrnZjWqTPwkmfwGhitnCvYLYpGPDaQF4ogFDMgMnnLRZbQZG1PPj1QBL1x5aZ47HCgH7QrBRDCG
	XfqivAUUELoJcRIel6GbQnkpEkQr9hetOlLMVUiRNPsln1wR7GjdSdc0Ww4qvhqN6CQIY1FJ4HO
	0t8rLHEo+h9pADjBC6M6vqsBNjXMzmhjv4jC1z6nuDWVsEnWDVi7ZI1X7cZISsZV6ZcAoYl/DTb
	fxHBl53bb2dRDV1uZl7OkkuAAYyCqf88WKpfg7+AmEfWU6jwAeqRllldLmDNltEe+7xI1j7U6bV
	f41DIaJuKFqtAO2836/dulBYm9cScqTmEdnqaOzBYsPBVFr4=
X-Google-Smtp-Source: AGHT+IGsJ29z77Si0Jc2Vb5pCBLTmliotaWTgWM2zePJsxVuTaOzYIGurW3Xrr0Nqo5g1PeamIKvSw==
X-Received: by 2002:a17:902:d54e:b0:24a:a6c8:d6c4 with SMTP id d9443c01a7336-27ed4a0e8d9mr69217065ad.26.1758869838002;
        Thu, 25 Sep 2025 23:57:18 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:94ad:363a:4161:464c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed688238esm44612135ad.94.2025.09.25.23.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 23:57:17 -0700 (PDT)
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
Subject: [PATCH v3 6/6] ceph: replace local base64 helpers with lib/base64
Date: Fri, 26 Sep 2025 14:57:11 +0800
Message-Id: <20250926065711.14620-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
References: <20250926065235.13623-1-409411716@gms.tku.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250925_235718_878676_CE7EC508 
X-CRM114-Status: GOOD (  19.60  )
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

Remove the ceph_base64_encode() and ceph_base64_decode() functions and
replace their usage with the generic base64_encode() and base64_decode()
helpers from lib/base64.

This eliminates the custom implementation in Ceph, reduces code
duplication, and relies on the shared Base64 code in lib.
The helpers preserve RFC 3501-compliant Base64 encoding without padding,
so there are no functional changes.

This change also improves performance: encoding is about 2.7x faster and
decoding achieves 23-28x speedups compared to the previous local
implementation.

Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 fs/ceph/crypto.c | 60 ++++--------------------------------------------
 fs/ceph/crypto.h |  6 +----
 fs/ceph/dir.c    |  5 ++--
 fs/ceph/inode.c  |  2 +-
 4 files changed, 9 insertions(+), 64 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index cab722619..9bb0f320b 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -15,59 +15,6 @@
 #include "mds_client.h"
 #include "crypto.h"
 
-/*
- * The base64url encoding used by fscrypt includes the '_' character, which may
- * cause problems in snapshot names (which can not start with '_').  Thus, we
- * used the base64 encoding defined for IMAP mailbox names (RFC 3501) instead,
- * which replaces '-' and '_' by '+' and ','.
- */
-static const char base64_table[65] =
-	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,";
-
-int ceph_base64_encode(const u8 *src, int srclen, char *dst)
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
-			*cp++ = base64_table[(ac >> bits) & 0x3f];
-		} while (bits >= 6);
-	}
-	if (bits)
-		*cp++ = base64_table[(ac << (6 - bits)) & 0x3f];
-	return cp - dst;
-}
-
-int ceph_base64_decode(const char *src, int srclen, u8 *dst)
-{
-	u32 ac = 0;
-	int bits = 0;
-	int i;
-	u8 *bp = dst;
-
-	for (i = 0; i < srclen; i++) {
-		const char *p = strchr(base64_table, src[i]);
-
-		if (p == NULL || src[i] == 0)
-			return -1;
-		ac = (ac << 6) | (p - base64_table);
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
 static int ceph_crypt_get_context(struct inode *inode, void *ctx, size_t len)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
@@ -316,7 +263,7 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
 	}
 
 	/* base64 encode the encrypted name */
-	elen = ceph_base64_encode(cryptbuf, len, p);
+	elen = base64_encode(cryptbuf, len, p, false, BASE64_IMAP);
 	doutc(cl, "base64-encoded ciphertext name = %.*s\n", elen, p);
 
 	/* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comments */
@@ -410,7 +357,8 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 			tname = &_tname;
 		}
 
-		declen = ceph_base64_decode(name, name_len, tname->name);
+		declen = base64_decode(name, name_len,
+				       tname->name, false, BASE64_IMAP);
 		if (declen <= 0) {
 			ret = -EIO;
 			goto out;
@@ -424,7 +372,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 
 	ret = fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, oname);
 	if (!ret && (dir != fname->dir)) {
-		char tmp_buf[CEPH_BASE64_CHARS(NAME_MAX)];
+		char tmp_buf[BASE64_CHARS(NAME_MAX)];
 
 		name_len = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
 				    oname->len, oname->name, dir->i_ino);
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index 23612b2e9..b748e2060 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -8,6 +8,7 @@
 
 #include <crypto/sha2.h>
 #include <linux/fscrypt.h>
+#include <linux/base64.h>
 
 #define CEPH_FSCRYPT_BLOCK_SHIFT   12
 #define CEPH_FSCRYPT_BLOCK_SIZE    (_AC(1, UL) << CEPH_FSCRYPT_BLOCK_SHIFT)
@@ -89,11 +90,6 @@ static inline u32 ceph_fscrypt_auth_len(struct ceph_fscrypt_auth *fa)
  */
 #define CEPH_NOHASH_NAME_MAX (180 - SHA256_DIGEST_SIZE)
 
-#define CEPH_BASE64_CHARS(nbytes) DIV_ROUND_UP((nbytes) * 4, 3)
-
-int ceph_base64_encode(const u8 *src, int srclen, char *dst);
-int ceph_base64_decode(const char *src, int srclen, u8 *dst);
-
 void ceph_fscrypt_set_ops(struct super_block *sb);
 
 void ceph_fscrypt_free_dummy_policy(struct ceph_fs_client *fsc);
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 8478e7e75..25045d817 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -998,13 +998,14 @@ static int prep_encrypted_symlink_target(struct ceph_mds_request *req,
 	if (err)
 		goto out;
 
-	req->r_path2 = kmalloc(CEPH_BASE64_CHARS(osd_link.len) + 1, GFP_KERNEL);
+	req->r_path2 = kmalloc(BASE64_CHARS(osd_link.len) + 1, GFP_KERNEL);
 	if (!req->r_path2) {
 		err = -ENOMEM;
 		goto out;
 	}
 
-	len = ceph_base64_encode(osd_link.name, osd_link.len, req->r_path2);
+	len = base64_encode(osd_link.name, osd_link.len,
+			    req->r_path2, false, BASE64_IMAP);
 	req->r_path2[len] = '\0';
 out:
 	fscrypt_fname_free_buffer(&osd_link);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index fc543075b..d06fb76fc 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -911,7 +911,7 @@ static int decode_encrypted_symlink(struct ceph_mds_client *mdsc,
 	if (!sym)
 		return -ENOMEM;
 
-	declen = ceph_base64_decode(encsym, enclen, sym);
+	declen = base64_decode(encsym, enclen, sym, false, BASE64_IMAP);
 	if (declen < 0) {
 		pr_err_client(cl,
 			"can't decode symlink (%d). Content: %.*s\n",
-- 
2.34.1


