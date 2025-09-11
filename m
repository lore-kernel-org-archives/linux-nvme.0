Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1422CA1016
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Sep 2025 07:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/o5UYWtgC17zidQRxgu3di44p2yuLDtqoBTP3KdD9qk=; b=a2fKQNXcDyab0616CIiJbd/nhF
	FydWoTcPdyVg3oA9elu2WbC6mU6Bwj9+J0w2TdBPDpnEgl59KKthGUvFAZK6QBoxcvzjcmfSyiFrj
	boh0k4xprTC2knqCprb1xvFzSK4bIXFeshtV/FHOv+GNyd2mtvx95XTAT8Quru5vVw2miAmAbap/N
	m+t/Neglt3QzDhz/KMRuFcEsvgNssaIh9B295THtOkRv03ewSkiPFGA0rrGN2iqE/CYDWFcccwFYr
	NWUa2CCRGlQFmQkWgjiUYycHoVMfLAnLKUz5McWf+VdWYc0h5XHOXIfcGVaRqd/QgQ7KEP77Gslmi
	uf83j7YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwc0k-00000001aXA-0Qjn;
	Thu, 11 Sep 2025 07:46:30 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwc0i-00000001aWb-2BqJ
	for linux-nvme@lists.infradead.org;
	Thu, 11 Sep 2025 07:46:29 +0000
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-b4cf40cd0d1so387951a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 11 Sep 2025 00:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1757576788; x=1758181588; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/o5UYWtgC17zidQRxgu3di44p2yuLDtqoBTP3KdD9qk=;
        b=pT3fH8wPU8u+CnxPC7m967wnHptPwoPHjHN1empJUqVujqA8y3AcYRdettPlCjEKqH
         Nt2NJxQhQY9YwPowK+Jh/COOUobF19rE0a3dUQOZE4B0jvSePk9L5inxoTQ32vzCkoAN
         6/MeOybQgNDnYSkHKh0wRSsgZFBYyyoXAHlrC79JDavbBRo+Y7Zq1NwBaVVEvmO4Bl1F
         2E2Js2EedPwOkdtUfjmwabxgdwvkHKieymL16sPnJeG+qReuBuihcVvue7oOm1lXudb0
         aSsxj1f+u+eK7r6YTjdbBf+YpO/jSuSeVhKI5sUdFSbaR0x0L+YAoZzxbTr1iE3Sd6iD
         0cRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757576788; x=1758181588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/o5UYWtgC17zidQRxgu3di44p2yuLDtqoBTP3KdD9qk=;
        b=qXMAniXhs1YQ55tQdJgC6g6fdJ+vb7Rkp8QGG2u0h6CTLRm2en1bbgckd3smwQMIbc
         Xy+ffSmlzLeuIXpeAM6od5BCzNv/pkkygNte697qQT9PBBPBjEFJhYbw1X2Ra+9Is/Mj
         ToQOZwY1Q+KWe/J4Qsuwf0EBaj4FoFN98iPEOkg8iBgl2Ag7Ic/TsJ91tmK462qT5osd
         rddGYXdg336MlSXSH/8/A+s5r/KDO01+skK0zCfRHBiav8I0WozE/7rJjfFemlZqyH07
         HnEQ8+ml9itot8C0V1JHSfBbp9y8rS8u5Hi42Hfpd1dE1RPgh9a/lGUFkbJVrWobqedl
         oo7A==
X-Forwarded-Encrypted: i=1; AJvYcCW6c7vS+faDUmroTzIVladW2r8wEdvCd+SOO5MMq8E9dMqYYfcsMpayBm56pm87ifQ0Z4sqQIDu0g59@lists.infradead.org
X-Gm-Message-State: AOJu0YzcFG7htFYq9hZ8TVtL+6T8GX+HvCKNIm3hVlKQayxZw0kE8zC1
	tKqtbgq739HV9s52enXae5wMrBqBtEnq8zKwM3vB2BTWGk7EPUUVi5Fu7f8vsyRNbTM=
X-Gm-Gg: ASbGncsP9ARJL7icJIlCCnNL3p03IwsKeUltZ37h0F7iyIjbwuPd464nB1xFo9bWQbT
	zGPQaWCaBHYy+UoORimle8NWyoakjfE/nYyYNTQulsMgvXpgLpAKEn0r7kKpJeV2okCumz3sFw2
	9aSgymEwsW9ET3icDVHpxq9LMxQcxc1mnShN5KVyEshFMNthapsGVU6ZHAhietaUQzHcvtA47Yx
	Mf+8004tlIP8zNE2LhjPrvnenohU+sqWHVGZS0/CBycAb3cECPVO82CvX7hHYLwAEQy2Kjz+RHU
	WFz04nWGoGjYFKj29/t3cTtZO6+zl0Rr4BKXWcysanq7j6xYk+iXYPgCqZJdOBvmn5AiJOuDzGE
	rZGvw31+ilf3KTJ6htHqImT6OeZHQ7vQkhsEW/lvRURO3D86/z5eAIu0Qw6fsa0PwGJG/
X-Google-Smtp-Source: AGHT+IHUrbIDUjSvWXWDJnw2/rvjU/6tI+i+eOkABLbPn89zVIkTMb70/fAZWJUo/N9Zo8PVFcB0yA==
X-Received: by 2002:a05:6a20:939d:b0:24a:8315:7e2 with SMTP id adf61e73a8af0-2533fab6295mr27158794637.20.1757576787693;
        Thu, 11 Sep 2025 00:46:27 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:7811:c085:c184:85be])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a47c47sm1152799b3a.35.2025.09.11.00.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 00:46:26 -0700 (PDT)
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
Subject: [PATCH v2 5/5] ceph: replace local base64 encode/decode with generic lib/base64 helpers
Date: Thu, 11 Sep 2025 15:46:17 +0800
Message-Id: <20250911074617.694704-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
References: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250911_004628_559100_86C97787 
X-CRM114-Status: GOOD (  19.19  )
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

Remove the local ceph_base64_encode and ceph_base64_decode functions and
replace their usage with the generic base64_encode and base64_decode
helpers from the kernel's lib/base64 library.

This eliminates redundant implementations in Ceph, reduces code
duplication, and leverages the optimized and well-maintained
standard base64 code within the kernel.

The change keeps the existing encoding table and disables padding,
ensuring no functional or format changes. At the same time, Ceph also
benefits from the optimized encoder/decoder: encoding performance
improves by ~2.7x and decoding by ~12-15x compared to the previous
local implementation.

Overall, this improves maintainability, consistency with other kernel
components, and runtime performance.

Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 fs/ceph/crypto.c | 53 +++++-------------------------------------------
 fs/ceph/crypto.h |  6 ++----
 fs/ceph/dir.c    |  5 +++--
 fs/ceph/inode.c  |  2 +-
 4 files changed, 11 insertions(+), 55 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index cab722619..a3cb4ad99 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -21,53 +21,9 @@
  * used the base64 encoding defined for IMAP mailbox names (RFC 3501) instead,
  * which replaces '-' and '_' by '+' and ','.
  */
-static const char base64_table[65] =
+const char ceph_base64_table[65] =
 	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,";
 
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
@@ -316,7 +272,7 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
 	}
 
 	/* base64 encode the encrypted name */
-	elen = ceph_base64_encode(cryptbuf, len, p);
+	elen = base64_encode(cryptbuf, len, p, false, ceph_base64_table);
 	doutc(cl, "base64-encoded ciphertext name = %.*s\n", elen, p);
 
 	/* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comments */
@@ -410,7 +366,8 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 			tname = &_tname;
 		}
 
-		declen = ceph_base64_decode(name, name_len, tname->name);
+		declen = base64_decode(name, name_len,
+				       tname->name, false, ceph_base64_table);
 		if (declen <= 0) {
 			ret = -EIO;
 			goto out;
@@ -424,7 +381,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 
 	ret = fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, oname);
 	if (!ret && (dir != fname->dir)) {
-		char tmp_buf[CEPH_BASE64_CHARS(NAME_MAX)];
+		char tmp_buf[BASE64_CHARS(NAME_MAX)];
 
 		name_len = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
 				    oname->len, oname->name, dir->i_ino);
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index 23612b2e9..c94da3818 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -8,6 +8,7 @@
 
 #include <crypto/sha2.h>
 #include <linux/fscrypt.h>
+#include <linux/base64.h>
 
 #define CEPH_FSCRYPT_BLOCK_SHIFT   12
 #define CEPH_FSCRYPT_BLOCK_SIZE    (_AC(1, UL) << CEPH_FSCRYPT_BLOCK_SHIFT)
@@ -89,10 +90,7 @@ static inline u32 ceph_fscrypt_auth_len(struct ceph_fscrypt_auth *fa)
  */
 #define CEPH_NOHASH_NAME_MAX (180 - SHA256_DIGEST_SIZE)
 
-#define CEPH_BASE64_CHARS(nbytes) DIV_ROUND_UP((nbytes) * 4, 3)
-
-int ceph_base64_encode(const u8 *src, int srclen, char *dst);
-int ceph_base64_decode(const char *src, int srclen, u8 *dst);
+extern const char ceph_base64_table[65];
 
 void ceph_fscrypt_set_ops(struct super_block *sb);
 
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index 8478e7e75..830715988 100644
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
+			    req->r_path2, false, ceph_base64_table);
 	req->r_path2[len] = '\0';
 out:
 	fscrypt_fname_free_buffer(&osd_link);
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index fc543075b..94b729ccc 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -911,7 +911,7 @@ static int decode_encrypted_symlink(struct ceph_mds_client *mdsc,
 	if (!sym)
 		return -ENOMEM;
 
-	declen = ceph_base64_decode(encsym, enclen, sym);
+	declen = base64_decode(encsym, enclen, sym, false, ceph_base64_table);
 	if (declen < 0) {
 		pr_err_client(cl,
 			"can't decode symlink (%d). Content: %.*s\n",
-- 
2.34.1


