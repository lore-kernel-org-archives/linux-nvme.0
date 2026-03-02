Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E75D58E7B
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 08:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k9e2D359KUx7MoQhof1aYsIpEjjwsSS1ExOHPn+k2yc=; b=EqYVYvVlsOWRv0d1/ZGfblBHPp
	QBNr/dWBAGeN2hCnpR82L7g4B34O42EP84/XajN1PLSyR7m7BZTOx4sYirbB8euIARgEaS5tcFuY/
	CeBFr4KmmeJBn476b1ZwlCN/P9eIfhi/bihiqWtDkES26QHFl9WpkVKNXONWlkzHbxSOJsMkPOf9U
	2yMuN0n7DhntFVxz7xc8Zc35w1xg3cEcN5jIM7Dtb3m5eq65Q4+GAPqbeaGi6Cdhkdno30n7TBrLH
	k01FyW8WlThvluB6ry9t0eo4tpIfSC86yjLCYsKATDdaCrub59j/SanqZVWgXaNi7c4Tn3xEBOM9y
	/t60rYCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDd-0000000CSpE-2rfY;
	Mon, 02 Mar 2026 08:01:33 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDY-0000000CSfQ-32qU
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 08:01:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 18FE9600AD;
	Mon,  2 Mar 2026 08:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2FEC2BCC7;
	Mon,  2 Mar 2026 08:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772438487;
	bh=W9H2LPxBxHj30YbFlkwn9HuR3K0Ej7ZCT6eTTeVS5QI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hn2O7+MbmRIEWUexO3ReOLCk6SrJje4UHyJ4o5mMr8kkUnBklg/QM6EEt9plIMvbd
	 SePZnRxSElmr6D1p5wrYz0wMJXQVJwhrDfUeHyLG/Fubvve2glqQ8b+x/2XMqUjSC1
	 r3x2V6vv3yaDX2d+ivZgOgtCZidMWIdZPn7W8pUh0a8mpIFnDLSbFw02MPcYnqCcIE
	 29cX7Vf/JX0isM37BbwSgrKL5XU9QkNaR6zJuXK6bPDCnUa3qS4YTJUaw8YaHqyJiK
	 53AmKr8SoJ1mSqwVQVRooKBXYYW1zbSRtnEMVrGu81riWpsllO8WXyNUkIL7xwu+eN
	 +h+M+j6VaYBxQ==
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
Subject: [PATCH 18/21] nvme-auth: target: use crypto library in nvmet_auth_ctrl_hash()
Date: Sun,  1 Mar 2026 23:59:56 -0800
Message-ID: <20260302075959.338638-19-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302075959.338638-1-ebiggers@kernel.org>
References: <20260302075959.338638-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

For the HMAC computation in nvmet_auth_ctrl_hash(), use the crypto
library instead of crypto_shash.  This is simpler, faster, and more
reliable.  Notably, this eliminates the crypto transformation object
allocation for every call, which was very slow.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/nvme/target/auth.c | 94 ++++++++++----------------------------
 1 file changed, 25 insertions(+), 69 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index fc56ce74d20f2..b7417ab6b035f 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -7,11 +7,10 @@
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/err.h>
-#include <crypto/hash.h>
 #include <linux/crc32.h>
 #include <linux/base64.h>
 #include <linux/ctype.h>
 #include <linux/random.h>
 #include <linux/nvme-auth.h>
@@ -354,51 +353,34 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 }
 
 int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 			 unsigned int shash_len)
 {
-	struct crypto_shash *shash_tfm;
-	struct shash_desc *shash;
+	struct nvme_auth_hmac_ctx hmac;
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
-	const char *hash_name;
 	u8 *challenge = req->sq->dhchap_c2;
 	struct nvme_dhchap_key *transformed_key;
 	u8 buf[4];
 	int ret;
 
-	hash_name = nvme_auth_hmac_name(ctrl->shash_id);
-	if (!hash_name) {
-		pr_warn("Hash ID %d invalid\n", ctrl->shash_id);
-		return -EINVAL;
-	}
-
-	shash_tfm = crypto_alloc_shash(hash_name, 0, 0);
-	if (IS_ERR(shash_tfm)) {
-		pr_err("failed to allocate shash %s\n", hash_name);
-		return PTR_ERR(shash_tfm);
-	}
-
-	if (shash_len != crypto_shash_digestsize(shash_tfm)) {
-		pr_debug("%s: hash len mismatch (len %d digest %d)\n",
-			 __func__, shash_len,
-			 crypto_shash_digestsize(shash_tfm));
-		ret = -EINVAL;
-		goto out_free_tfm;
-	}
-
 	transformed_key = nvme_auth_transform_key(ctrl->ctrl_key,
 						ctrl->subsys->subsysnqn);
-	if (IS_ERR(transformed_key)) {
-		ret = PTR_ERR(transformed_key);
-		goto out_free_tfm;
-	}
+	if (IS_ERR(transformed_key))
+		return PTR_ERR(transformed_key);
 
-	ret = crypto_shash_setkey(shash_tfm, transformed_key->key,
+	ret = nvme_auth_hmac_init(&hmac, ctrl->shash_id, transformed_key->key,
 				  transformed_key->len);
 	if (ret)
 		goto out_free_response;
 
+	if (shash_len != nvme_auth_hmac_hash_len(ctrl->shash_id)) {
+		pr_err("%s: hash len mismatch (len %u digest %zu)\n", __func__,
+		       shash_len, nvme_auth_hmac_hash_len(ctrl->shash_id));
+		ret = -EINVAL;
+		goto out_free_response;
+	}
+
 	if (ctrl->dh_gid != NVME_AUTH_DHGROUP_NULL) {
 		challenge = kmalloc(shash_len, GFP_KERNEL);
 		if (!challenge) {
 			ret = -ENOMEM;
 			goto out_free_response;
@@ -410,59 +392,33 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 						    challenge, shash_len);
 		if (ret)
 			goto out_free_challenge;
 	}
 
-	shash = kzalloc(sizeof(*shash) + crypto_shash_descsize(shash_tfm),
-			GFP_KERNEL);
-	if (!shash) {
-		ret = -ENOMEM;
-		goto out_free_challenge;
-	}
-	shash->tfm = shash_tfm;
+	nvme_auth_hmac_update(&hmac, challenge, shash_len);
 
-	ret = crypto_shash_init(shash);
-	if (ret)
-		goto out;
-	ret = crypto_shash_update(shash, challenge, shash_len);
-	if (ret)
-		goto out;
 	put_unaligned_le32(req->sq->dhchap_s2, buf);
-	ret = crypto_shash_update(shash, buf, 4);
-	if (ret)
-		goto out;
+	nvme_auth_hmac_update(&hmac, buf, 4);
+
 	put_unaligned_le16(req->sq->dhchap_tid, buf);
-	ret = crypto_shash_update(shash, buf, 2);
-	if (ret)
-		goto out;
+	nvme_auth_hmac_update(&hmac, buf, 2);
+
 	memset(buf, 0, 4);
-	ret = crypto_shash_update(shash, buf, 1);
-	if (ret)
-		goto out;
-	ret = crypto_shash_update(shash, "Controller", 10);
-	if (ret)
-		goto out;
-	ret = crypto_shash_update(shash, ctrl->subsys->subsysnqn,
-			    strlen(ctrl->subsys->subsysnqn));
-	if (ret)
-		goto out;
-	ret = crypto_shash_update(shash, buf, 1);
-	if (ret)
-		goto out;
-	ret = crypto_shash_update(shash, ctrl->hostnqn, strlen(ctrl->hostnqn));
-	if (ret)
-		goto out;
-	ret = crypto_shash_final(shash, response);
-out:
-	kfree(shash);
+	nvme_auth_hmac_update(&hmac, buf, 1);
+	nvme_auth_hmac_update(&hmac, "Controller", 10);
+	nvme_auth_hmac_update(&hmac, ctrl->subsys->subsysnqn,
+			      strlen(ctrl->subsys->subsysnqn));
+	nvme_auth_hmac_update(&hmac, buf, 1);
+	nvme_auth_hmac_update(&hmac, ctrl->hostnqn, strlen(ctrl->hostnqn));
+	nvme_auth_hmac_final(&hmac, response);
+	ret = 0;
 out_free_challenge:
 	if (challenge != req->sq->dhchap_c2)
 		kfree(challenge);
 out_free_response:
+	memzero_explicit(&hmac, sizeof(hmac));
 	nvme_auth_free_key(transformed_key);
-out_free_tfm:
-	crypto_free_shash(shash_tfm);
 	return ret;
 }
 
 int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
 				u8 *buf, int buf_size)
-- 
2.53.0


