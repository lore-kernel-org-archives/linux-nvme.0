Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B795AC4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Oct 2023 05:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8/2to7sxCZ/NumPWBHJ3HDLNhOoBHDROHfNECentdcE=; b=aCQvoNHt/pd0yHN+ttstdXqnkq
	gngbSD2qxXJ6t4DnFs/yr1M4qM37Q3ipiEv1uUpkcRSLe9I1CTRZAKDjc2U4ADHG6i3GoUYY/Pu1B
	wIZganvMrKYbbHXLusE2XOTEiw/6HMK+I7zcTbjJd+w+jNzVVz7MH4heUoHKEZbFprVz8+iy258WQ
	9qunYb6M/BVs9cyHcheeLfQx7E4XCC12Hma9xlbbruGrNbKSB1KupJNXbLaJFWqdb6lTqtaU+IMJV
	qWvMvm82InjPOzSaKh0UIUhnOPOLPguvijqv17PswObRHQ8lDChODFjAk8RMOjVINK0EBACX+6534
	HsAiPoAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qwxwK-001C9O-1u;
	Sun, 29 Oct 2023 05:02:20 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qwxwA-001C5M-2u
	for linux-nvme@lists.infradead.org;
	Sun, 29 Oct 2023 05:02:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 06734CE0B86;
	Sun, 29 Oct 2023 05:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0155CC433C8;
	Sun, 29 Oct 2023 05:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698555717;
	bh=H3TBMwFvCfUQgoAGADY26kx++WBeBqiO7bxMskx7gEc=;
	h=From:To:Cc:Subject:Date:From;
	b=VuCBLEMNOHwXeidEirGT6xTXDB2Ob2Pq66i9fh0+ThmJdmlhzHufY71R6xija2WFV
	 aad+OLamPGQ8qQQeQfFsIFOLCARklnzEy1udetiblVbRTPcQbXnwD644c0erqxdVj4
	 h9I5u+oIa86KorcPCRoAFMhcS4RajaLGWA8JxKOf3gSaBYraBzQxoKPYy33xhPTDrG
	 dZGW7WTRbi8vbdh65c8VB9UnCIpzKGkJaiMyGxewdyo7KxGpdyvgqs0ef2nUqIE/74
	 4YXXsf0/38eCw1+NXSs7exhnaryGu/T0enrJB+OIVVGtc8yzH7J6b4Csj8RW4eXLtI
	 O5GbgqWQNW7mw==
From: Eric Biggers <ebiggers@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: linux-crypto@vger.kernel.org
Subject: [PATCH] nvme-auth: use crypto_shash_tfm_digest()
Date: Sat, 28 Oct 2023 22:00:40 -0700
Message-ID: <20231029050040.154563-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231028_220211_136732_8BCE1E40 
X-CRM114-Status: GOOD (  11.06  )
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

From: Eric Biggers <ebiggers@google.com>

Simplify nvme_auth_augmented_challenge() by using
crypto_shash_tfm_digest() instead of an alloc+init+update+final
sequence.  This should also improve performance.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/nvme/common/auth.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index d90e4f0c08b7..54cffbc24b4a 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -324,21 +324,20 @@ static int nvme_auth_hash_skey(int hmac_id, u8 *skey, size_t skey_len, u8 *hkey)
 			 skey_len);
 
 	crypto_free_shash(tfm);
 	return ret;
 }
 
 int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
 		u8 *challenge, u8 *aug, size_t hlen)
 {
 	struct crypto_shash *tfm;
-	struct shash_desc *desc;
 	u8 *hashed_key;
 	const char *hmac_name;
 	int ret;
 
 	hashed_key = kmalloc(hlen, GFP_KERNEL);
 	if (!hashed_key)
 		return -ENOMEM;
 
 	ret = nvme_auth_hash_skey(hmac_id, skey,
 				  skey_len, hashed_key);
@@ -352,43 +351,25 @@ int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
 		ret = -EINVAL;
 		goto out_free_key;
 	}
 
 	tfm = crypto_alloc_shash(hmac_name, 0, 0);
 	if (IS_ERR(tfm)) {
 		ret = PTR_ERR(tfm);
 		goto out_free_key;
 	}
 
-	desc = kmalloc(sizeof(struct shash_desc) + crypto_shash_descsize(tfm),
-		       GFP_KERNEL);
-	if (!desc) {
-		ret = -ENOMEM;
-		goto out_free_hash;
-	}
-	desc->tfm = tfm;
-
 	ret = crypto_shash_setkey(tfm, hashed_key, hlen);
 	if (ret)
-		goto out_free_desc;
-
-	ret = crypto_shash_init(desc);
-	if (ret)
-		goto out_free_desc;
-
-	ret = crypto_shash_update(desc, challenge, hlen);
-	if (ret)
-		goto out_free_desc;
+		goto out_free_hash;
 
-	ret = crypto_shash_final(desc, aug);
-out_free_desc:
-	kfree_sensitive(desc);
+	ret = crypto_shash_tfm_digest(tfm, challenge, hlen, aug);
 out_free_hash:
 	crypto_free_shash(tfm);
 out_free_key:
 	kfree_sensitive(hashed_key);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_augmented_challenge);
 
 int nvme_auth_gen_privkey(struct crypto_kpp *dh_tfm, u8 dh_gid)
 {

base-commit: 2af9b20dbb39f6ebf9b9b6c090271594627d818e
-- 
2.42.0


