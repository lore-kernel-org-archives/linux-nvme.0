Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43C7BCDE006
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Nov 2025 06:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y3VNVy+UYeqY3IVTtkh/AbSvZ3E8GHu4GINXGK2iL3Y=; b=holaM45ZGzScgAFp9obHWzUoj9
	mNIboT5ZL773Q0ST44eNPq5Ti/Nk8FBujNkerGQioeE+4XgMv9JRsZbJ30HNdHdxTGK4mW+oLvLVb
	A/doNWXYuGcdyA21uoy91q3haWyR8UNqbbxUL9n/klado63JCbuTEvNccBk452CZKuvFzP9hbs/vf
	RkhH2VNfzKFQFq6oQOwH8NqUXFHtSuNuXxhnnixWDfO3dFVDtD2vWTls84PEEdSA0PV7oTRfUIanJ
	bJvxG4vgvo9/pQ54NBj4NkOss/mDM1ndZ3xPUfYONrexMOtQ9wkHnKcOu/N2mN3EY0b6RV4xby1JN
	sfwx3w5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJmtX-0000000Bd04-2oaF;
	Fri, 14 Nov 2025 06:02:51 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJmtU-0000000Bcz8-2GZl
	for linux-nvme@lists.infradead.org;
	Fri, 14 Nov 2025 06:02:50 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-7a9c64dfa8aso1434318b3a.3
        for <linux-nvme@lists.infradead.org>; Thu, 13 Nov 2025 22:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1763100168; x=1763704968; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y3VNVy+UYeqY3IVTtkh/AbSvZ3E8GHu4GINXGK2iL3Y=;
        b=JxdK1Qf2bfv2Ai0tXkzZMi02c3QmUvaH0rKt3MolT9hUfRGzgUtMRv1DH5walm49cM
         S4ZqZD+MLg7On3QxtMQtA599Wi7+BpFAsUVgQvIXzqOfL4jse5TZWv8di3pWLQJDh+2f
         e5NFYsdaFUA7H4/eM84ZOdWS7cFI4xqq9yJ7e/bND6vpV9VtzynUnNcNFDlnKDEYTTAN
         d8m6a6cF5VMdDe8yCiuKHA/2ktBbsLR1DGBCXMOfDC4IEQgXeW0u4CHvr3PCKxeBOdlr
         G96AcSCyt81pc7T21TmAYNcRZQTxU/n+UvB4CUNvCET6Af7tMPuhsTASqHCcEe427H0k
         6CxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763100168; x=1763704968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y3VNVy+UYeqY3IVTtkh/AbSvZ3E8GHu4GINXGK2iL3Y=;
        b=mByTGjWlUZRQkmYiS6uIRezm/tKKwTspzTNErf7Yj8LKO2xkTpZXtQwAntnGb1MAPP
         WUI81prNV7OBDrNtrq+T1RNdtCqHQSySD+SgpSsX3TlIRgU3fuYQwfq1aFgqs4rk1jvL
         52RyTQW8b2HT4tcTtKh6pRYXrExfQ43SZgubg0uErC4udaNHRopBaJC/73CjvlH1ST59
         YjHnnMZgwFRfyX+H7N3AgOoUHGuuP6xi8TFd7nEwD6jROGXlLanQAH5hlpwn7lBiX6BO
         fIFkL6bYgI/zI9bHpSTchmB38UJz3O1ESuDR6ziOcdtOcPD1Z8R8pcOZnlXc+Y5upUeH
         o+XA==
X-Forwarded-Encrypted: i=1; AJvYcCVqBQxqtiSQwKRDAKZhhqfvlDVg/bRtXejXO5QBLvU1vravJlexVsY1TmHbgTv0LLN01+AH3IfH6fey@lists.infradead.org
X-Gm-Message-State: AOJu0Yyf4UT3xKTJU+unIUEy30AMRZhIrC7SDt6sHfTKMI4nvFpO9fcW
	bzE8BT3FE8iN4o5LHroPkCTAzmitC6E2OHsbr4nr9XwOF0RA27xHaXnPVOeuy2Z+srA=
X-Gm-Gg: ASbGncu+lpMjkQySs9Ca3QcOww3xXJjC990uB+qHh8xCwFR1NmnQagfFjo288ANj9/F
	lV7JdYAw/x9frMGPquehKNYgiF8rkjxUgpbsdDEDIpv0otjVtOd4d7LQEv/4bzmV70YDyAMsuMJ
	PSxe0Wnd80LuStWhlDwENf5k73p3CUFC9AE+T2J1rO4GfqYvsHvoeqAN5scSPxSPCqz9jsbZkxn
	5IKtad+l1jrywRmrfoBdng2LgXesVM//8tTpBqf7Bh4KZ4XzWE/lEOLr2RD3SMFvoN59Ct4oiWi
	RV3FPCTVFifVjUeuPDJHQ0ico0yj558YV/ZPFfkqXk8SE2L+6+h82OX4H6UuTFwaXnFxXqSYDJN
	XhpKbigtpuBUGKInGpUTiFcp1qoCZTu5x7k4VkJa1a2O9I1AmR/MiTHaxTK0QezvnV1VK9iZ71D
	X2dfyS+wGo/PT55gR2yHaeQO0yTGfcVtGgz60=
X-Google-Smtp-Source: AGHT+IFu12NV5C3ZMb+GzTshy782WYZvWJoPnURdrRS7I9I9BogTqLlIkKyKPKA2EoshONrHEKmUHw==
X-Received: by 2002:a05:6a00:4b12:b0:7a4:f552:b522 with SMTP id d2e1a72fcca58-7ba3c669976mr2406190b3a.27.1763100167825;
        Thu, 13 Nov 2025 22:02:47 -0800 (PST)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:22d2:323c:497d:adbd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ba438bed8csm1236316b3a.53.2025.11.13.22.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 22:02:47 -0800 (PST)
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
Subject: [PATCH v5 6/6] ceph: replace local base64 helpers with lib/base64
Date: Fri, 14 Nov 2025 14:02:40 +0800
Message-Id: <20251114060240.89965-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251114055829.87814-1-409411716@gms.tku.edu.tw>
References: <20251114055829.87814-1-409411716@gms.tku.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251113_220248_589464_E84FDD82 
X-CRM114-Status: GOOD (  18.88  )
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
decoding achieves 43-52x speedups compared to the previous local
implementation.

Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Signed-off-by: Guan-Chun Wu <409411716@gms.tku.edu.tw>
---
 fs/ceph/crypto.c | 60 ++++--------------------------------------------
 fs/ceph/crypto.h |  6 +----
 fs/ceph/dir.c    |  5 ++--
 fs/ceph/inode.c  |  2 +-
 4 files changed, 9 insertions(+), 64 deletions(-)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 7026e794813c..b6016dcffbb6 100644
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
@@ -318,7 +265,7 @@ int ceph_encode_encrypted_dname(struct inode *parent, char *buf, int elen)
 	}
 
 	/* base64 encode the encrypted name */
-	elen = ceph_base64_encode(cryptbuf, len, p);
+	elen = base64_encode(cryptbuf, len, p, false, BASE64_IMAP);
 	doutc(cl, "base64-encoded ciphertext name = %.*s\n", elen, p);
 
 	/* To understand the 240 limit, see CEPH_NOHASH_NAME_MAX comments */
@@ -412,7 +359,8 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 			tname = &_tname;
 		}
 
-		declen = ceph_base64_decode(name, name_len, tname->name);
+		declen = base64_decode(name, name_len,
+				       tname->name, false, BASE64_IMAP);
 		if (declen <= 0) {
 			ret = -EIO;
 			goto out;
@@ -426,7 +374,7 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 
 	ret = fscrypt_fname_disk_to_usr(dir, 0, 0, &iname, oname);
 	if (!ret && (dir != fname->dir)) {
-		char tmp_buf[CEPH_BASE64_CHARS(NAME_MAX)];
+		char tmp_buf[BASE64_CHARS(NAME_MAX)];
 
 		name_len = snprintf(tmp_buf, sizeof(tmp_buf), "_%.*s_%ld",
 				    oname->len, oname->name, dir->i_ino);
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index 23612b2e9837..b748e2060bc9 100644
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
index d18c0eaef9b7..0fa7c7777242 100644
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
index a6e260d9e420..b691343cb7f1 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -958,7 +958,7 @@ static int decode_encrypted_symlink(struct ceph_mds_client *mdsc,
 	if (!sym)
 		return -ENOMEM;
 
-	declen = ceph_base64_decode(encsym, enclen, sym);
+	declen = base64_decode(encsym, enclen, sym, false, BASE64_IMAP);
 	if (declen < 0) {
 		pr_err_client(cl,
 			"can't decode symlink (%d). Content: %.*s\n",
-- 
2.34.1


