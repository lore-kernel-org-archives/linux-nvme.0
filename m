Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98751C3ABB2
	for <linux-nvme@archiver.kernel.org>; Wed, 28 May 2025 14:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XVHKbEK8dWvfEZVcPiyCPWiB8j43qXSyjLlM622ndu4=; b=ncsVh0lWTA1OWf4hHGHZxgqJt9
	piz1WBia/WU38zqAGSHHTGA+5E9VykJfdTkNe6bmuaTBfrdWe4YqifUJ3yMQpfROPdyUWUTE/3WM2
	NWBBIwrz5BDuA/2CNPPpEoJvHezkT/cEna9jFQl1xx/hoLYy8Ldjgyko7y1mhdTlU3TKGtCGQUUPf
	3ISCMbhVHMBPURRhnXipl3OoDqEYfDqD6sNaIKnw+NMaiEIzYSkH7Sa3FKdpkds4JGLSSTsprS3hS
	rcVh+DZmcrmehBoGCuGRl8To7Vvv3benI/qSZ/2kjsbnSYHErKgrg890x6g0PTPceh4dXJx23Evqq
	grP6z/Iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKHbA-0000000DLo4-3KKK;
	Wed, 28 May 2025 14:17:40 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKHSN-0000000DKP3-2UrM
	for linux-nvme@lists.infradead.org;
	Wed, 28 May 2025 14:08:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 096375C55F4;
	Wed, 28 May 2025 14:06:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D290C4CEE3;
	Wed, 28 May 2025 14:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748441314;
	bh=g6xL/lGg72qo294B9kUi8+tq1ai2sENUKsbtvtcFm8c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lHCVmutMMoZ3BS6CKy8GRSde61W/3QCPQyUSowsr4o8Pd+qH9ZI23BCBG8AEwImbE
	 00tAIRIDrFFpqfUgDQmD7ynZsF5bhDaWcQjcBpACh1NGTfYCTrc1LFo/b7YuYXKSL2
	 sP5iBT3z44pKs8uObuB3gCOkCHMorn89hTampvfTJ+Z9GlE5uyRYI4W9q8YR5y9VXU
	 Dm0dD7t5EVIoN+ddisQ3BRLmPsJu9UvRqvZ94A4S/J846SInLWMdbMkEzu/is1m/Oc
	 WVCiJnh7rlqtN9Vpn19SgCFvMX9/mPRw3SIa/sMaXqAm6Rte5I69nKcEGobJ+VlWjC
	 vDwg3Zf241/SQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/9] nvme-auth: modify nvme_auth_transform_key() to return status
Date: Wed, 28 May 2025 16:05:09 +0200
Message-Id: <20250528140517.3284-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250528140517.3284-1-hare@kernel.org>
References: <20250528140517.3284-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250528_070835_721950_3AC0DB60 
X-CRM114-Status: GOOD (  16.19  )
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

Modify nvme_auth_transform_key() to return a status and provide
the transformed data as argument on the command line as raw data.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/auth.c | 72 +++++++++++++++++++++++---------------
 drivers/nvme/host/auth.c   | 40 +++++++++++----------
 drivers/nvme/target/auth.c | 36 +++++++++----------
 include/linux/nvme-auth.h  |  4 +--
 4 files changed, 85 insertions(+), 67 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 3b6d759bcdf2..918c92cbd8c5 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -237,70 +237,86 @@ void nvme_auth_free_key(struct nvme_dhchap_key *key)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_free_key);
 
-struct nvme_dhchap_key *nvme_auth_transform_key(
-		struct nvme_dhchap_key *key, char *nqn)
+int nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn,
+			    u8 **transformed_secret)
 {
 	const char *hmac_name;
 	struct crypto_shash *key_tfm;
 	SHASH_DESC_ON_STACK(shash, key_tfm);
-	struct nvme_dhchap_key *transformed_key;
-	int ret, key_len;
+	u8 *transformed_data;
+	u8 *key_data;
+	size_t transformed_len;
+	int ret;
 
 	if (!key) {
 		pr_warn("No key specified\n");
-		return ERR_PTR(-ENOKEY);
+		return -ENOKEY;
 	}
+	key_data = kzalloc(key->len, GFP_KERNEL);
+	if (!key_data)
+		return -ENOMEM;
+	memcpy(key_data, key->key, key->len);
 	if (key->hash == 0) {
-		key_len = nvme_auth_key_struct_size(key->len);
-		transformed_key = kmemdup(key, key_len, GFP_KERNEL);
-		if (!transformed_key)
-			return ERR_PTR(-ENOMEM);
-		return transformed_key;
+		*transformed_secret = key_data;
+		return key->len;
 	}
 	hmac_name = nvme_auth_hmac_name(key->hash);
 	if (!hmac_name) {
 		pr_warn("Invalid key hash id %d\n", key->hash);
-		return ERR_PTR(-EINVAL);
+		ret = -EINVAL;
+		goto out_free_data;
 	}
 
 	key_tfm = crypto_alloc_shash(hmac_name, 0, 0);
-	if (IS_ERR(key_tfm))
-		return ERR_CAST(key_tfm);
+	if (IS_ERR(key_tfm)) {
+		ret = PTR_ERR(key_tfm);
+		goto out_free_data;
+	}
 
-	key_len = crypto_shash_digestsize(key_tfm);
-	transformed_key = nvme_auth_alloc_key(key_len, key->hash);
-	if (!transformed_key) {
+	transformed_len = crypto_shash_digestsize(key_tfm);
+	if (transformed_len != key->len) {
+		pr_warn("incompatible digest size %ld for key (hash %s, len %ld)\n",
+			transformed_len, hmac_name, key->len);
+		ret = -EINVAL;
+		goto out_free_tfm;
+	}
+
+	transformed_data = kzalloc(transformed_len, GFP_KERNEL);
+	if (!transformed_data) {
 		ret = -ENOMEM;
-		goto out_free_key;
+		goto out_free_tfm;
 	}
 
 	shash->tfm = key_tfm;
 	ret = crypto_shash_setkey(key_tfm, key->key, key->len);
 	if (ret < 0)
-		goto out_free_transformed_key;
+		goto out_free_transformed_data;
 	ret = crypto_shash_init(shash);
 	if (ret < 0)
-		goto out_free_transformed_key;
+		goto out_free_transformed_data;
 	ret = crypto_shash_update(shash, nqn, strlen(nqn));
 	if (ret < 0)
-		goto out_free_transformed_key;
+		goto out_free_transformed_data;
 	ret = crypto_shash_update(shash, "NVMe-over-Fabrics", 17);
 	if (ret < 0)
-		goto out_free_transformed_key;
-	ret = crypto_shash_final(shash, transformed_key->key);
+		goto out_free_transformed_data;
+	ret = crypto_shash_final(shash, transformed_data);
 	if (ret < 0)
-		goto out_free_transformed_key;
+		goto out_free_transformed_data;
 
 	crypto_free_shash(key_tfm);
+	*transformed_secret = transformed_data;
 
-	return transformed_key;
+	return transformed_len;
 
-out_free_transformed_key:
-	nvme_auth_free_key(transformed_key);
-out_free_key:
+out_free_transformed_data:
+	kfree(transformed_data);
+out_free_tfm:
 	crypto_free_shash(key_tfm);
+out_free_data:
+	kfree(key_data);
 
-	return ERR_PTR(ret);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_transform_key);
 
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index f6ddbe553289..9e7c2e889ee0 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -24,7 +24,8 @@ struct nvme_dhchap_queue_context {
 	struct nvme_ctrl *ctrl;
 	struct crypto_shash *shash_tfm;
 	struct crypto_kpp *dh_tfm;
-	struct nvme_dhchap_key *transformed_key;
+	u8 *transformed_secret;
+	size_t transformed_len;
 	void *buf;
 	int qid;
 	int error;
@@ -437,21 +438,20 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 	dev_dbg(ctrl->device, "%s: qid %d host response seq %u transaction %d\n",
 		__func__, chap->qid, chap->s1, chap->transaction);
 
-	if (!chap->transformed_key) {
-		chap->transformed_key = nvme_auth_transform_key(ctrl->host_key,
-						ctrl->opts->host->nqn);
-		if (IS_ERR(chap->transformed_key)) {
-			ret = PTR_ERR(chap->transformed_key);
-			chap->transformed_key = NULL;
+	if (!chap->transformed_secret) {
+		ret = nvme_auth_transform_key(ctrl->host_key,
+					      ctrl->opts->host->nqn,
+					      &chap->transformed_secret);
+		if (ret < 0)
 			return ret;
-		}
+		chap->transformed_len = ret;
 	} else {
 		dev_dbg(ctrl->device, "%s: qid %d re-using host response\n",
 			__func__, chap->qid);
 	}
 
 	ret = crypto_shash_setkey(chap->shash_tfm,
-			chap->transformed_key->key, chap->transformed_key->len);
+			chap->transformed_secret, chap->transformed_len);
 	if (ret) {
 		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
 			 chap->qid, ret);
@@ -517,19 +517,20 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
 		struct nvme_dhchap_queue_context *chap)
 {
 	SHASH_DESC_ON_STACK(shash, chap->shash_tfm);
-	struct nvme_dhchap_key *transformed_key;
+	u8 *transformed_secret;
+	size_t transformed_len;
 	u8 buf[4], *challenge = chap->c2;
 	int ret;
 
-	transformed_key = nvme_auth_transform_key(ctrl->ctrl_key,
-				ctrl->opts->subsysnqn);
-	if (IS_ERR(transformed_key)) {
-		ret = PTR_ERR(transformed_key);
+	ret = nvme_auth_transform_key(ctrl->ctrl_key,
+			ctrl->opts->subsysnqn,
+			&transformed_secret);
+	if (ret < 0)
 		return ret;
-	}
+	transformed_len = ret;
 
 	ret = crypto_shash_setkey(chap->shash_tfm,
-			transformed_key->key, transformed_key->len);
+			transformed_secret, transformed_len);
 	if (ret) {
 		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
 			 chap->qid, ret);
@@ -595,7 +596,7 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
 out:
 	if (challenge != chap->c2)
 		kfree(challenge);
-	nvme_auth_free_key(transformed_key);
+	kfree(transformed_secret);
 	return ret;
 }
 
@@ -657,8 +658,9 @@ static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
 
 static void nvme_auth_reset_dhchap(struct nvme_dhchap_queue_context *chap)
 {
-	nvme_auth_free_key(chap->transformed_key);
-	chap->transformed_key = NULL;
+	kfree(chap->transformed_secret);
+	chap->transformed_secret = NULL;
+	chap->transformed_len = 0;
 	kfree_sensitive(chap->host_key);
 	chap->host_key = NULL;
 	chap->host_key_len = 0;
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index b340380f3892..c70d9d259a7f 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -297,7 +297,8 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	const char *hash_name;
 	u8 *challenge = req->sq->dhchap_c1;
-	struct nvme_dhchap_key *transformed_key;
+	u8 *transformed_secret;
+	size_t transformed_len;
 	u8 buf[4];
 	int ret;
 
@@ -321,15 +322,14 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 		goto out_free_tfm;
 	}
 
-	transformed_key = nvme_auth_transform_key(ctrl->host_key,
-						  ctrl->hostnqn);
-	if (IS_ERR(transformed_key)) {
-		ret = PTR_ERR(transformed_key);
+	ret = nvme_auth_transform_key(ctrl->host_key, ctrl->hostnqn,
+				      &transformed_secret);
+	if (ret < 0)
 		goto out_free_tfm;
-	}
 
-	ret = crypto_shash_setkey(shash_tfm, transformed_key->key,
-				  transformed_key->len);
+	transformed_len = ret;
+	ret = crypto_shash_setkey(shash_tfm, transformed_secret,
+				  transformed_len);
 	if (ret)
 		goto out_free_response;
 
@@ -389,7 +389,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	if (challenge != req->sq->dhchap_c1)
 		kfree(challenge);
 out_free_response:
-	nvme_auth_free_key(transformed_key);
+	kfree(transformed_secret);
 out_free_tfm:
 	crypto_free_shash(shash_tfm);
 	return ret;
@@ -403,7 +403,8 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	const char *hash_name;
 	u8 *challenge = req->sq->dhchap_c2;
-	struct nvme_dhchap_key *transformed_key;
+	u8 *transformed_secret;
+	size_t transformed_len;
 	u8 buf[4];
 	int ret;
 
@@ -427,15 +428,14 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 		goto out_free_tfm;
 	}
 
-	transformed_key = nvme_auth_transform_key(ctrl->ctrl_key,
-						ctrl->subsysnqn);
-	if (IS_ERR(transformed_key)) {
-		ret = PTR_ERR(transformed_key);
+	ret = nvme_auth_transform_key(ctrl->ctrl_key, ctrl->subsysnqn,
+				      &transformed_secret);
+	if (ret < 0)
 		goto out_free_tfm;
-	}
+	transformed_len = ret;
 
-	ret = crypto_shash_setkey(shash_tfm, transformed_key->key,
-				  transformed_key->len);
+	ret = crypto_shash_setkey(shash_tfm, transformed_secret,
+				  transformed_len);
 	if (ret)
 		goto out_free_response;
 
@@ -500,7 +500,7 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 	if (challenge != req->sq->dhchap_c2)
 		kfree(challenge);
 out_free_response:
-	nvme_auth_free_key(transformed_key);
+	kfree(transformed_secret);
 out_free_tfm:
 	crypto_free_shash(shash_tfm);
 	return ret;
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index 60e069a6757f..fd43fa042c88 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -29,8 +29,8 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 					      u8 key_hash);
 void nvme_auth_free_key(struct nvme_dhchap_key *key);
 struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash);
-struct nvme_dhchap_key *nvme_auth_transform_key(
-				struct nvme_dhchap_key *key, char *nqn);
+int nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn,
+			    u8 **transformed_secret) ;
 int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key);
 int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
 				  u8 *challenge, u8 *aug, size_t hlen);
-- 
2.35.3


