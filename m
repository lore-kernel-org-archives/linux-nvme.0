Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF9DFD8763
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GmB+FgOhiPeWXh24O4b2cTvFuXV+Y+VfCbCyUwTkib8=; b=LRpq36Ypf1bk3pW/xd422LYBfQ
	U2j9RStV69ApzuiFWD/AXL9X2tl2gUoX1obj8ZQzbZpGiLvzdq7cm/cSsFacxtP58kTMcxBIxmcjZ
	rvfaVlF9ZERV1xP+HTt1MTmmoc0QTT5i4OSdehFzAnsAdoaEHlMCbUIvR3kHkTWXje4PHtg7eK6pL
	ByFaLN8LZrv9roqMALmkO2ZCn9IU42Yvy4Pa1deDwTimAFDEI5xOObrMIeX7GItnEwEvPFEizIQOu
	fWHElUwDN+e/y/jJ0dNHUJODcXn4e8+4sdJ7w0FHuCcYvLh1tHflmYKxdklgp5bOF7amxdzHMlIS/
	h93KlKIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2U2z-00000006LdZ-1fy4;
	Tue, 17 Mar 2026 13:01:21 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2U2x-00000006LdB-2vh4
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 13:01:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CA53F6013C;
	Tue, 17 Mar 2026 13:01:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B72C4CEF7;
	Tue, 17 Mar 2026 13:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773752478;
	bh=h01zmG42KeWzVni1tjIgUErUcZECW7XmM0IKWvO8g2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FSd5niBOJiCPKmbFK7ONDZuoAxC2Lc7vZw8cxMgggFwrcr66FYroHJpWZHv+qeAO1
	 TW8xklfLhoMIqUliNUvL7KrCKmz49gyyaCKMKqlDKkF6aH2nwr7+IikOKEeUIWRV9e
	 gzSR4P+ZV6b40sJwRmePTWwc4IsDsSC+b8aYPKKX90L0xOFD8U7NQ3evVoW7Lf295l
	 /8Gght5HZWnEr380/0Fs18ehcTXoO2yyPQ8s4tRS8fHSNc6TUAMOvqhq48rSRHlJ5j
	 c+7TQANROJj+uGHryGsHA0iEsrtS/g94eKgYOSqmB70GlNdY1U1MQ69f5fxn3FyvI2
	 EzJ7BdwmraScA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/8] nvme-auth: modify nvme_auth_transform_key() to return status
Date: Tue, 17 Mar 2026 14:00:56 +0100
Message-ID: <20260317130103.107360-2-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317130103.107360-1-hare@kernel.org>
References: <20260317130103.107360-1-hare@kernel.org>
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

In preparation for converting the DH-HMAC-CHAP code to use the
kernel keyring modify nvme_auth_transform_key() to return a status
and provide the transformed data as argument on the command line as
raw data.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/auth.c | 38 ++++++++++++++++----------------
 drivers/nvme/host/auth.c   | 44 ++++++++++++++++++++------------------
 drivers/nvme/target/auth.c | 37 ++++++++++++++++++--------------
 include/linux/nvme-auth.h  |  4 ++--
 4 files changed, 65 insertions(+), 58 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 2d325fb93083..772af9b6dccd 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -317,37 +317,37 @@ static int nvme_auth_hash(u8 hmac_id, const u8 *data, size_t data_len, u8 *out)
 	return -EINVAL;
 }
 
-struct nvme_dhchap_key *nvme_auth_transform_key(
-		const struct nvme_dhchap_key *key, const char *nqn)
+int nvme_auth_transform_key(const struct nvme_dhchap_key *key, const char *nqn,
+			    u8 **transformed_secret)
 {
 	struct nvme_auth_hmac_ctx hmac;
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
 	if (key->hash == 0) {
-		key_len = nvme_auth_key_struct_size(key->len);
-		transformed_key = kmemdup(key, key_len, GFP_KERNEL);
-		if (!transformed_key)
-			return ERR_PTR(-ENOMEM);
-		return transformed_key;
+		key_data = kzalloc(key->len, GFP_KERNEL);
+		memcpy(key_data, key->key, key->len);
+		*transformed_secret = key_data;
+		return key->len;
 	}
 	ret = nvme_auth_hmac_init(&hmac, key->hash, key->key, key->len);
 	if (ret)
-		return ERR_PTR(ret);
-	key_len = nvme_auth_hmac_hash_len(key->hash);
-	transformed_key = nvme_auth_alloc_key(key_len, key->hash);
-	if (!transformed_key) {
-		memzero_explicit(&hmac, sizeof(hmac));
-		return ERR_PTR(-ENOMEM);
-	}
+		return ret;
+	transformed_len = nvme_auth_hmac_hash_len(key->hash);
+	key_data = kzalloc(transformed_len, GFP_KERNEL);
+	if (!key_data)
+		return -ENOMEM;
 	nvme_auth_hmac_update(&hmac, nqn, strlen(nqn));
 	nvme_auth_hmac_update(&hmac, "NVMe-over-Fabrics", 17);
-	nvme_auth_hmac_final(&hmac, transformed_key->key);
-	return transformed_key;
+	nvme_auth_hmac_final(&hmac, key_data);
+	*transformed_secret = key_data;
+	return transformed_len;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_transform_key);
 
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index a85646891656..2065b3301326 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -22,7 +22,8 @@ struct nvme_dhchap_queue_context {
 	struct work_struct auth_work;
 	struct nvme_ctrl *ctrl;
 	struct crypto_kpp *dh_tfm;
-	struct nvme_dhchap_key *transformed_key;
+	u8 *transformed_secret;
+	size_t transformed_len;
 	void *buf;
 	int qid;
 	int error;
@@ -421,22 +422,21 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
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
 
 	ret = nvme_auth_hmac_init(&hmac, chap->hash_id,
-				  chap->transformed_key->key,
-				  chap->transformed_key->len);
+				  chap->transformed_secret,
+				  chap->transformed_len);
 	if (ret)
 		goto out;
 
@@ -485,19 +485,20 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
 		struct nvme_dhchap_queue_context *chap)
 {
 	struct nvme_auth_hmac_ctx hmac;
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
+				      ctrl->opts->subsysnqn,
+				      &transformed_secret);
+	if (ret < 0)
 		return ret;
-	}
+	transformed_len = ret;
 
-	ret = nvme_auth_hmac_init(&hmac, chap->hash_id, transformed_key->key,
-				  transformed_key->len);
+	ret = nvme_auth_hmac_init(&hmac, chap->hash_id, transformed_secret,
+				  transformed_len);
 	if (ret) {
 		dev_warn(ctrl->device, "qid %d: failed to init hmac, error %d\n",
 			 chap->qid, ret);
@@ -549,7 +550,7 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
 	if (challenge != chap->c2)
 		kfree(challenge);
 	memzero_explicit(&hmac, sizeof(hmac));
-	nvme_auth_free_key(transformed_key);
+	kfree_sensitive(transformed_secret);
 	return ret;
 }
 
@@ -611,8 +612,9 @@ static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
 
 static void nvme_auth_reset_dhchap(struct nvme_dhchap_queue_context *chap)
 {
-	nvme_auth_free_key(chap->transformed_key);
-	chap->transformed_key = NULL;
+	kfree_sensitive(chap->transformed_secret);
+	chap->transformed_secret = NULL;
+	chap->transformed_len = 0;
 	kfree_sensitive(chap->host_key);
 	chap->host_key = NULL;
 	chap->host_key_len = 0;
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index b34610e2f19d..baf4c8223fd5 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -285,17 +285,19 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 	struct nvme_auth_hmac_ctx hmac;
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	u8 *challenge = req->sq->dhchap_c1;
-	struct nvme_dhchap_key *transformed_key;
+	u8 *transformed_secret;
+	size_t transformed_len;
 	u8 buf[4];
 	int ret;
 
-	transformed_key = nvme_auth_transform_key(ctrl->host_key,
-						  ctrl->hostnqn);
-	if (IS_ERR(transformed_key))
-		return PTR_ERR(transformed_key);
+	ret = nvme_auth_transform_key(ctrl->host_key, ctrl->hostnqn,
+				      &transformed_secret);
+	if (ret < 0)
+		return ret;
+	transformed_len = ret;
 
-	ret = nvme_auth_hmac_init(&hmac, ctrl->shash_id, transformed_key->key,
-				  transformed_key->len);
+	ret = nvme_auth_hmac_init(&hmac, ctrl->shash_id, transformed_secret,
+				  transformed_len);
 	if (ret)
 		goto out_free_response;
 
@@ -348,7 +350,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 		kfree(challenge);
 out_free_response:
 	memzero_explicit(&hmac, sizeof(hmac));
-	nvme_auth_free_key(transformed_key);
+	kfree_sensitive(transformed_secret);
 	return ret;
 }
 
@@ -358,17 +360,20 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 	struct nvme_auth_hmac_ctx hmac;
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	u8 *challenge = req->sq->dhchap_c2;
-	struct nvme_dhchap_key *transformed_key;
+	u8 *transformed_secret;
+	size_t transformed_len;
 	u8 buf[4];
 	int ret;
 
-	transformed_key = nvme_auth_transform_key(ctrl->ctrl_key,
-						ctrl->subsys->subsysnqn);
-	if (IS_ERR(transformed_key))
-		return PTR_ERR(transformed_key);
+	ret = nvme_auth_transform_key(ctrl->ctrl_key,
+				      ctrl->subsys->subsysnqn,
+				      &transformed_secret);
+	if (ret < 0)
+		return ret;
+	transformed_len = ret;
 
-	ret = nvme_auth_hmac_init(&hmac, ctrl->shash_id, transformed_key->key,
-				  transformed_key->len);
+	ret = nvme_auth_hmac_init(&hmac, ctrl->shash_id, transformed_secret,
+				  transformed_len);
 	if (ret)
 		goto out_free_response;
 
@@ -416,7 +421,7 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 		kfree(challenge);
 out_free_response:
 	memzero_explicit(&hmac, sizeof(hmac));
-	nvme_auth_free_key(transformed_key);
+	kfree_sensitive(transformed_secret);
 	return ret;
 }
 
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index 184a1f9510fa..37cc8abaf06d 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -41,8 +41,8 @@ u32 nvme_auth_key_struct_size(u32 key_len);
 struct nvme_dhchap_key *nvme_auth_extract_key(const char *secret, u8 key_hash);
 void nvme_auth_free_key(struct nvme_dhchap_key *key);
 struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash);
-struct nvme_dhchap_key *nvme_auth_transform_key(
-		const struct nvme_dhchap_key *key, const char *nqn);
+int nvme_auth_transform_key(const struct nvme_dhchap_key *key,
+			    const char *nqn, u8 **transformed_secret);
 int nvme_auth_parse_key(const char *secret, struct nvme_dhchap_key **ret_key);
 int nvme_auth_augmented_challenge(u8 hmac_id, const u8 *skey, size_t skey_len,
 				  const u8 *challenge, u8 *aug, size_t hlen);
-- 
2.43.0


