Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB1F606A332
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=a85BEH8Q;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DlTb4Wd0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=kRbunCWh64X8sjPCCbsN6qVv/uy3p7pcuqx0kyRvjVY=; b=a85BEH8QEzQtpF
	wc+8tbxybkRl/0JG0CacllcZEUsrq9YghaBT2xDYh5xdXTGsTgy3MIPpao644fFagOeavbsaeGCE8
	+iftUOquQF52TjAiUwBEzLLpE9D6PN1icfhAuLcdurtxIgLOdCxUbkiAnMKMyigfHa4H5ht/BEKWL
	Jik/bkyIsrAReSTUiW21ZX2iiiQjRark8jEqrFP5/LdL0p2UkHEiNb/yEmfAwnDRrMrG+Y15WFBZZ
	QUNWF4eDyDZ3cOtN2l0XJFPtwK3KI9UXFAtcRX2GHeC5R6YQWjQHaDnVl6vNos9fo6MdSdkhdcDCT
	JNyLcQDpDR2BSbkvQ7IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXYZ-00000004ImJ-34P5;
	Mon, 23 Nov 2026 17:10:19 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXYX-00000004IlX-00Qg
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 17:10:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4E84D4016A;
	Mon, 23 Nov 2026 17:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF76C1F000C0;
	Mon, 23 Nov 2026 17:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795453815;
	bh=kRbunCWh64X8sjPCCbsN6qVv/uy3p7pcuqx0kyRvjVY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DlTb4Wd0oqkGYPghsbhtcLy0xibhmDBVBBNrSQrqdwD+drXvFVxmxR+tmjLRekm92
	 ZRzKeEv50Wenhg2G8y1/186Dhvhh2a48ZICUZsFEqKajOeoJ77a0kjYsauMgAFgRmQ
	 lxgh7F7isqnZWRfp5JSDfWl4VUNCvuTNYi5/1wLWHts5xricmPJAKMrweEYGJgVsq1
	 d9062nkYbl8xnbMOlWoye2mlJI5PrFlgTwuQU9Upvy8Gg/1I3Om6u44ePICwXYdnpc
	 4rB3gfD1cmLhZHNZ8CM/8MV1YI2haK9vBbvbiCjsU1dTGDTY3yV8l6WuwcAIDCal/K
	 7jhQ+GtxBdHJQ==
From: Hannes Reinecke <hare@kernel.org>
Date: Mon, 23 Nov 2026 18:10:01 +0100
Subject: [PATCH v6 1/9] nvme-auth: modify nvme_auth_transform_key() to
 return status
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-dhchap-keyring-v4-v6-1-5082a49715ab@kernel.org>
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
In-Reply-To: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795453811; l=9494;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=Ld7A5CpfR4qv5lsoGPUMMTLqr6yQkEMwmB6MKXTXMzQ=;
 b=DyD/rCQ2g1sk79Hd9sCcOUe3pd2MjXgaG7cgBSzcJXN1BYtOviu7s0Jo8argA6i4/A72pp7/I
 l/1DiUV6/oyD29zC01FK+Ym69Dcr8PCN3Ub1O50XX+RL2aykCNH1WUC
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In preparation for converting the DH-HMAC-CHAP code to use the
kernel keyring modify nvme_auth_transform_key() to return a status
and provide the transformed data as argument on the command line as
raw data.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/auth.c | 37 ++++++++++++++++++++-----------------
 drivers/nvme/host/auth.c   | 44 +++++++++++++++++++++++---------------------
 drivers/nvme/target/auth.c | 37 +++++++++++++++++++++----------------
 include/linux/nvme-auth.h  |  4 ++--
 4 files changed, 66 insertions(+), 56 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 1fdc4e4ed0b94d8a36aade033f19e17463f15632..308af3d7c7383acbfb327921c8a650898f0e15ea 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -317,37 +317,40 @@ static int nvme_auth_hash(u8 hmac_id, const u8 *data, size_t data_len, u8 *out)
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
+		if (!key_data)
+			return -ENOMEM;
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
+		return ret;
+	transformed_len = nvme_auth_hmac_hash_len(key->hash);
+	key_data = kzalloc(transformed_len, GFP_KERNEL);
+	if (!key_data) {
 		memzero_explicit(&hmac, sizeof(hmac));
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	}
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
index 9a3da74dec5aa818538dfbc36fd27f7f756cc059..295e0a9533c8995c32781324650d73b6bfedbf13 100644
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
@@ -436,22 +437,21 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
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
 
@@ -500,19 +500,20 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
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
@@ -565,7 +566,7 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
 	if (challenge != chap->c2)
 		kfree(challenge);
 	memzero_explicit(&hmac, sizeof(hmac));
-	nvme_auth_free_key(transformed_key);
+	kfree_sensitive(transformed_secret);
 	return ret;
 }
 
@@ -628,8 +629,9 @@ static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
 
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
index a4a2a5cfd823f921a9e9503f41de51b846c43296..150818d7009d8c2fca96e12fd54fdc1cb6b68882 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -295,17 +295,19 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
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
 
@@ -357,7 +359,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req, u8 *response,
 		kfree(challenge);
 out_free_response:
 	memzero_explicit(&hmac, sizeof(hmac));
-	nvme_auth_free_key(transformed_key);
+	kfree_sensitive(transformed_secret);
 	return ret;
 }
 
@@ -367,17 +369,20 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
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
 
@@ -426,7 +431,7 @@ int nvmet_auth_ctrl_hash(struct nvmet_req *req, u8 *response,
 		kfree(challenge);
 out_free_response:
 	memzero_explicit(&hmac, sizeof(hmac));
-	nvme_auth_free_key(transformed_key);
+	kfree_sensitive(transformed_secret);
 	return ret;
 }
 
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index d674d8ab26e6b3b4b297ebaefa3f33b8ec97bc0a..1c5ce635b169dd0747c1344e9adcc14839776cd1 100644
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
2.51.0


