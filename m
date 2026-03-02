Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBCDD58E7B
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 08:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WEuGLTcNUGPTE1V4UG4RfpsiBoSp/G2JMJghyRKLg9s=; b=PYNFeuclgph0Xrdex+/kGGjN6D
	DCEIeGOwKjWnsKRaqSDn3uwv7k0s/hS3A3x0QQGxkJpiy2/vxVsL8d8DUfauPAja/HlGV2Vbiis9q
	9u9Zreip8ndjZLjmlIk3Z2Ce6NzGWdEshntlq8T/KmY1wNQcq3pa5uRei4twBoUO60Ffu3t+hZEnP
	emw9qVACgA9QRGeIdavlNJu+Ea/aJvbynBFyX4BGusDMn1nXTqjwj5smiYE4OIwKU7wIF9hj88aMZ
	Hx1VlvH11ZgqmWr1ssLaCq4cAKxtJpLG/SiGmHSkAA7rz8CV5+Vh0dE+vaVamdbM9pWCEmwDMuJum
	RucSWo4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDZ-0000000CSgz-2VyT;
	Mon, 02 Mar 2026 08:01:29 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDU-0000000CSZX-2AXN
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 08:01:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 34566408B9;
	Mon,  2 Mar 2026 08:01:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EF2C2BCB8;
	Mon,  2 Mar 2026 08:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772438484;
	bh=lXlkUJdiAWtnaXpdI44zQecmTOJvKYo7/F2Z3GU+sz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ueWLGJKOb5YFmXqQljaBuCRnZ/UhnHyPhE+hHyhNla2yUob0k4dkfm5U4aQ+5OzNn
	 5/jyiy+wtgMAmuIii6u5kgQL4eAfDXPUgkXe2mFNocix55a8VjMQTCq8hv/6ywYnFP
	 miQKajYhXcxYh4s2vSFciXgnqayNzIXzlUpCmX/PcKpB0u0uZ2xBV6JXg9j8CJiY2t
	 FMYkJbHrjSBx/GqbQSiTFNmmaYaKUx4hUoNtWL31AyGFwMIZ/rugogFAbf56LoHOk+
	 /0Jr2d3T5ExqKrpnBB2KPzw9lUX/c5O10rq+E4wy0nJL9Rw5d291I1h4kpu6E21lvF
	 ZLAJ+Sjkm8MJg==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 10/21] nvme-auth: common: use crypto library in nvme_auth_generate_psk()
Date: Sun,  1 Mar 2026 23:59:48 -0800
Message-ID: <20260302075959.338638-11-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302075959.338638-1-ebiggers@kernel.org>
References: <20260302075959.338638-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260302_000124_690954_D36386EB 
X-CRM114-Status: GOOD (  10.81  )
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

For the HMAC computation in nvme_auth_generate_psk(), use the crypto
library instead of crypto_shash.  This is simpler, faster, and more
reliable.  Notably, this eliminates the crypto transformation object
allocation for every call, which was very slow.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/nvme/common/auth.c | 63 +++++++++-----------------------------
 1 file changed, 14 insertions(+), 49 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index be5bc5fcafc63..781d1d5d46dd3 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -495,67 +495,32 @@ EXPORT_SYMBOL_GPL(nvme_auth_parse_key);
  */
 int nvme_auth_generate_psk(u8 hmac_id, const u8 *skey, size_t skey_len,
 			   const u8 *c1, const u8 *c2, size_t hash_len,
 			   u8 **ret_psk, size_t *ret_len)
 {
-	struct crypto_shash *tfm;
-	SHASH_DESC_ON_STACK(shash, tfm);
+	size_t psk_len = nvme_auth_hmac_hash_len(hmac_id);
+	struct nvme_auth_hmac_ctx hmac;
 	u8 *psk;
-	const char *hmac_name;
-	int ret, psk_len;
+	int ret;
 
 	if (!c1 || !c2)
 		return -EINVAL;
 
-	hmac_name = nvme_auth_hmac_name(hmac_id);
-	if (!hmac_name) {
-		pr_warn("%s: invalid hash algorithm %d\n",
-			__func__, hmac_id);
-		return -EINVAL;
-	}
-
-	tfm = crypto_alloc_shash(hmac_name, 0, 0);
-	if (IS_ERR(tfm))
-		return PTR_ERR(tfm);
-
-	psk_len = crypto_shash_digestsize(tfm);
+	ret = nvme_auth_hmac_init(&hmac, hmac_id, skey, skey_len);
+	if (ret)
+		return ret;
 	psk = kzalloc(psk_len, GFP_KERNEL);
 	if (!psk) {
-		ret = -ENOMEM;
-		goto out_free_tfm;
-	}
-
-	shash->tfm = tfm;
-	ret = crypto_shash_setkey(tfm, skey, skey_len);
-	if (ret)
-		goto out_free_psk;
-
-	ret = crypto_shash_init(shash);
-	if (ret)
-		goto out_free_psk;
-
-	ret = crypto_shash_update(shash, c1, hash_len);
-	if (ret)
-		goto out_free_psk;
-
-	ret = crypto_shash_update(shash, c2, hash_len);
-	if (ret)
-		goto out_free_psk;
-
-	ret = crypto_shash_final(shash, psk);
-	if (!ret) {
-		*ret_psk = psk;
-		*ret_len = psk_len;
+		memzero_explicit(&hmac, sizeof(hmac));
+		return -ENOMEM;
 	}
-
-out_free_psk:
-	if (ret)
-		kfree_sensitive(psk);
-out_free_tfm:
-	crypto_free_shash(tfm);
-
-	return ret;
+	nvme_auth_hmac_update(&hmac, c1, hash_len);
+	nvme_auth_hmac_update(&hmac, c2, hash_len);
+	nvme_auth_hmac_final(&hmac, psk);
+	*ret_psk = psk;
+	*ret_len = psk_len;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_generate_psk);
 
 /**
  * nvme_auth_generate_digest - Generate TLS PSK digest
-- 
2.53.0


