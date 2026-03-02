Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07879D58E78
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 08:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uiTjk2uFp82vqg8vMs6u94c+P+ZJab8IvzBIzl2BMBw=; b=gj322vmHKxVykj7c7D7+lzB+4I
	rdTaqjFoqRxS/f02j0wzagFYl8NwyRycTncxWbcrSPgoH8UbYF6igPoupI/J3VevbLNkMSuRYMw1p
	GNpy8JKYnraubQMEr4dGwb1arCa+6bCHGy6Q4xBUSaxLCAo5ZowlNhiBEvoYMJErTLxM9W51hWavQ
	CcrzExE6OXmLEs8dWUKyZldvztJdbhZnK+nNojqPy/O4CmHnvLzqQYctf82nkpSE0Ey+WD03KLKdj
	xmR8OB7KZaCCx+dkwuC2jnSSDR4WA+CWrJq0n1Aj7VJxCGMT3HPWy5eOO9ii1l7DTFsWyfU396EP7
	gHaiP0hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDb-0000000CSkk-1Yx4;
	Mon, 02 Mar 2026 08:01:31 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDW-0000000CScj-2jpN
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 08:01:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 172E16057A;
	Mon,  2 Mar 2026 08:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBDBC2BC87;
	Mon,  2 Mar 2026 08:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772438485;
	bh=Baj84wAItyGbuhZFMViAVPg9/GpQvbnC2i2OfoH9Krc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQwcaAKCvB1wtwPYtEHFOsAqAeayy37/TnVqpkQNJ0wMWXgZuUPYkkGagbqKkp5yL
	 H77f5a6KGM8HS2GaIa4bjzG9LqvVHnHFapNwQ5kHQU5ErhQaUsMWO24tIjI5NomNs5
	 hm8f53xKu++sRwKf2OU7C5SO3TA6MNB716ELj/JulWCb6cDpFsWNRFjp6H4rsyJHIM
	 0PwUWG4ppC2pKgDFSRd1/DiMT4wslwiAxeAqmBnhKqhU7hA/nTrMzQMb8dT+TUxvZ9
	 iU6AgpdkX43qDPnGNbrQUC8iOahpxKY9+dLmZTYJh1bYfcYfxS+s1xV8VtmDiNhgti
	 WebrTMEK/98IA==
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
Subject: [PATCH 14/21] nvme-auth: host: use crypto library in nvme_auth_dhchap_setup_ctrl_response()
Date: Sun,  1 Mar 2026 23:59:52 -0800
Message-ID: <20260302075959.338638-15-ebiggers@kernel.org>
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

For the HMAC computation in nvme_auth_dhchap_setup_ctrl_response(), use
the crypto library instead of crypto_shash.  This is simpler, faster,
and more reliable.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/nvme/host/auth.c | 56 +++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 35 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index f22f17ad7e2f4..2f27f550a7442 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -502,11 +502,11 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 }
 
 static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
 		struct nvme_dhchap_queue_context *chap)
 {
-	SHASH_DESC_ON_STACK(shash, chap->shash_tfm);
+	struct nvme_auth_hmac_ctx hmac;
 	struct nvme_dhchap_key *transformed_key;
 	u8 buf[4], *challenge = chap->c2;
 	int ret;
 
 	transformed_key = nvme_auth_transform_key(ctrl->ctrl_key,
@@ -514,14 +514,14 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
 	if (IS_ERR(transformed_key)) {
 		ret = PTR_ERR(transformed_key);
 		return ret;
 	}
 
-	ret = crypto_shash_setkey(chap->shash_tfm,
-			transformed_key->key, transformed_key->len);
+	ret = nvme_auth_hmac_init(&hmac, chap->hash_id, transformed_key->key,
+				  transformed_key->len);
 	if (ret) {
-		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
+		dev_warn(ctrl->device, "qid %d: failed to init hmac, error %d\n",
 			 chap->qid, ret);
 		goto out;
 	}
 
 	if (chap->dh_tfm) {
@@ -544,47 +544,33 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
 		__func__, chap->qid, (int)chap->hash_len, challenge);
 	dev_dbg(ctrl->device, "%s: qid %d subsysnqn %s\n",
 		__func__, chap->qid, ctrl->opts->subsysnqn);
 	dev_dbg(ctrl->device, "%s: qid %d hostnqn %s\n",
 		__func__, chap->qid, ctrl->opts->host->nqn);
-	shash->tfm = chap->shash_tfm;
-	ret = crypto_shash_init(shash);
-	if (ret)
-		goto out;
-	ret = crypto_shash_update(shash, challenge, chap->hash_len);
-	if (ret)
-		goto out;
+
+	nvme_auth_hmac_update(&hmac, challenge, chap->hash_len);
+
 	put_unaligned_le32(chap->s2, buf);
-	ret = crypto_shash_update(shash, buf, 4);
-	if (ret)
-		goto out;
+	nvme_auth_hmac_update(&hmac, buf, 4);
+
 	put_unaligned_le16(chap->transaction, buf);
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
-	ret = crypto_shash_update(shash, ctrl->opts->subsysnqn,
-				  strlen(ctrl->opts->subsysnqn));
-	if (ret)
-		goto out;
-	ret = crypto_shash_update(shash, buf, 1);
-	if (ret)
-		goto out;
-	ret = crypto_shash_update(shash, ctrl->opts->host->nqn,
-				  strlen(ctrl->opts->host->nqn));
-	if (ret)
-		goto out;
-	ret = crypto_shash_final(shash, chap->response);
+	nvme_auth_hmac_update(&hmac, buf, 1);
+	nvme_auth_hmac_update(&hmac, "Controller", 10);
+	nvme_auth_hmac_update(&hmac, ctrl->opts->subsysnqn,
+			      strlen(ctrl->opts->subsysnqn));
+	nvme_auth_hmac_update(&hmac, buf, 1);
+	nvme_auth_hmac_update(&hmac, ctrl->opts->host->nqn,
+			      strlen(ctrl->opts->host->nqn));
+	nvme_auth_hmac_final(&hmac, chap->response);
+	ret = 0;
 out:
 	if (challenge != chap->c2)
 		kfree(challenge);
+	memzero_explicit(&hmac, sizeof(hmac));
 	nvme_auth_free_key(transformed_key);
 	return ret;
 }
 
 static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
-- 
2.53.0


