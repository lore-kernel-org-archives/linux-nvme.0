Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4ECCCF9F6
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Oct 2025 10:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ExH2mWp+TtRat+/Z2Sn0K+6uHuJUKGnny14cPSnH5Oc=; b=KJEZOxrv5AzxpdhUoUlcZDR6rs
	D5EjfxSYQVbXNIlm6Hg014H+faDbT8cCtoRpx7xTYQmLRtjm5bK5N68FjosVB4zeFVhhi/g9nKATq
	WomIvNv6GHu8MPJjpgVGK5DHRQZ5Uj775C01wnwMXYlyX27kbrHUORV7S6MeAhrOcJ/d/PWNjBZaG
	YQfLgoQ1rX5Kc0c6c98hH5odAgn6VrjrV2S0OdLLlU2fF/ru8Tdmk36Sn/XGV2+3EIEOJFFQM24Jy
	5+kcIJ2c05YNHWp3NKkbhN3czBjgT5d0xqqGkZILB4D0MWdSb2/f7d0YP6Yd1JXh3RKeQIX4nS6I6
	Gc3TZthg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE3Jl-00000000iJO-1E7o;
	Wed, 29 Oct 2025 10:22:13 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE3Jj-00000000iHa-0RPT
	for linux-nvme@lists.infradead.org;
	Wed, 29 Oct 2025 10:22:12 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-781206cce18so998788b3a.0
        for <linux-nvme@lists.infradead.org>; Wed, 29 Oct 2025 03:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1761733330; x=1762338130; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ExH2mWp+TtRat+/Z2Sn0K+6uHuJUKGnny14cPSnH5Oc=;
        b=OxOV9UJTaupin6Q/f0mVoPxpo1KmZvlSoXUwhJtEZhxShs511nkiEZYVPPsjGTF0Mi
         oKp/2cN5bJe3L8FlYBC4Ixcspn/SNNXzfUhdAytOBbf/u1N4nNqXL7wypQ+sB/Y6GhWC
         oX8VhWvR5c2bZ1QrDyNp0+UZXmXggMA6BzGniS5Z2wGtm6JVOjGja7mRtoOvVRAfUUCG
         yT0b1qoAjTGAqRAoJHZf8V+WAM6dyuJZeh7OQ+aMOPf950UU36onWe3Y4qm8OAbbjYiw
         3Hq5b2GZYVJUl9vSNj8OKNfAnBlHBN+cUcX3Ra6VtSpmeyHiB5lWwsJSyb2wzGC4RWva
         3ZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761733330; x=1762338130;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExH2mWp+TtRat+/Z2Sn0K+6uHuJUKGnny14cPSnH5Oc=;
        b=LIaykkhxpyk1A8VYTY+PlXOgjFfwzjF4eUufm5QI7TCpfxcE2RZzrKpJ16xxaMzLtV
         FQ5K1ArxyVPsfwKPSenzkvz0LovOfvf4u6kMlAnNVgTM/h6jOZE5AxL5KAUiQwQZS5/O
         CARC7+YUGkYfjhuLiYraoRBFSqpeXmXKTfaDL9Scf+xnCvVhgfSNTMn9LFeaNm5Y/105
         zjgPNEsVlKS1bt328Nv/t8A6upDhur//mNHB2q5fLMSnj51AOM/0eKTKrkCwuoaTBQpW
         R9FOXewApeCmsD59jfdMp1k329Mf/pw69F+V1QU4YLMQjcnu0wlBjCRJwIQP2JnlPV4n
         t7mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXPRrXTfOzleSSY/D4uAdJS1XZv0b8hQSYmuWmc14l5A+Ov0ZeIFEBalvkkeb1AO525DX8ihotX7l7Z@lists.infradead.org
X-Gm-Message-State: AOJu0Ywq4cw5+b4o1Z9NFD0oXC4Vl3JMVaaedAtqKe1r34Tm/IlDXQnr
	VYsMzTe113zhsX67wkMtMmQzP+bim7r9BukLXpKuOPcujon5xMLS9xmtFQLlOVYcDCs=
X-Gm-Gg: ASbGnctlNg8KKyGJVbWBRSr1JbXvkFDV04iqIYMQ+t1QHgtYsw0m2Q1yYWOwpUHA9V2
	sBQ9nCIsexVi0jPLnfphucaPWqMyZvXxh4iz3is5InTpyILYlvrb4fbSmhfx6MEcJkoWRzaA1Gx
	2P+P6o5uHrEK+vxNGsi3/iJP/qN7l9Kk6ojUz7XLHthNX12pvFnWF2vfWMZo5FViH9koWkVtky7
	KTzkdDk5eoxXOC796Qz5A0mmh8hx/eRtsJMlC3dc+dbA35bw22On+s/A+ffCtEJnUjWPK5+YXRm
	KTFj2+HDl3ixVDRVb8UtnITsacnl+MOyoXLuaOONqP9Y5/LvCfTexxvas0u5ytgdhz+qITG8d5N
	qkFhDBxrCNbeXZ+gpoS+y38wc4SNqhyBzlrDIDkw7ImFHVtJc2f3E5noxEMVrjobiGulUKJdAtZ
	vDNkEAOibT9uS3ii14OGBAY0fv
X-Google-Smtp-Source: AGHT+IEqYKX6PUZCvPQ43ID+NkdezuDDTSQSofgCTqlK+FDd2PcLeAZunAzA4UgtHlctwdsk1r5vIA==
X-Received: by 2002:a05:6a00:130f:b0:77f:43e6:ce65 with SMTP id d2e1a72fcca58-7a442cc2c03mr6912507b3a.0.1761733330060;
        Wed, 29 Oct 2025 03:22:10 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:3fc9:8c3c:5030:1b20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a41409f714sm14560993b3a.72.2025.10.29.03.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 03:22:09 -0700 (PDT)
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
Subject: [PATCH v4 6/6] ceph: replace local base64 helpers with lib/base64
Date: Wed, 29 Oct 2025 18:22:02 +0800
Message-Id: <20251029102202.544118-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
References: <20251029101725.541758-1-409411716@gms.tku.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251029_032211_151731_2996CE91 
X-CRM114-Status: GOOD (  20.06  )
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


