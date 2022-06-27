Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF92C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jun 2022 09:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XyTAEw1W7jlO5bTxozq10suyKCPLfFPmDchzoPQX9P4=; b=3lSidVNkM52g8it5JMJiUCCm+I
	bnG/QVoT4Lw1VlZygtGl5nTJHFRX+lUXDrwWYmINGngfus2Y3QvYKO+3C5w8BXOZYM9VkSWxCqw6J
	nKV50rya2XOI6TDmTY7EPUzQdBJHEFgNOSdaqz3kWoMPy6VDDB6Jx3ZVhW8hDWBIuXkCG8VKMC1v6
	P0WUtIP4EQU5amrxbdaHViDNZE/rqxWKX0rM50oljOHsqfI1sdPGHhzk8tfDULflj4sSBdjn/ycHy
	cUEZ2FmqSGAb1dY+Omn51pBdK6jDcSW2oaDFAiRf+9Cqb1wpbKnKt5v2Q3XhrPAikSSGix31DifZe
	m7fJSNeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5lRH-00HV00-2V; Mon, 27 Jun 2022 09:53:51 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5lPp-00HUC5-3h
	for linux-nvme@lists.infradead.org; Mon, 27 Jun 2022 09:52:30 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id ECAAA21CC4;
	Mon, 27 Jun 2022 09:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1656323537; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyTAEw1W7jlO5bTxozq10suyKCPLfFPmDchzoPQX9P4=;
	b=bPtIHK9TYFGx7sHN+M7L4XuJDbm32FHH3dYp4+6fTDkVcY1u5uxl4nLRl8/zXygbUfMBrv
	mS+XFtZWX0vN0kl6alPeUiuTAGD+BQKDjvacfnaYf4z/PFCBY8Ff0pNHQ4lUov6Tz7BIHc
	fdx1pkiYeXDLiGk+cKCgAoY6WjvEgKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1656323537;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyTAEw1W7jlO5bTxozq10suyKCPLfFPmDchzoPQX9P4=;
	b=TYcZwM49XuxQyJD6Fonpy+xgSQ/IwlYLZm4lNra6wJncz0qW83uz0ApCXAM8DU/Gf77qvj
	YOnw3Sz5TZrn5VCQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id E5A252C149;
	Mon, 27 Jun 2022 09:52:17 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id E322D5198319; Mon, 27 Jun 2022 11:52:17 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 07/11] nvme-auth: Diffie-Hellman key exchange support
Date: Mon, 27 Jun 2022 11:52:03 +0200
Message-Id: <20220627095207.105201-8-hare@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220627095207.105201-1-hare@suse.de>
References: <20220627095207.105201-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_025221_538376_B334EF62 
X-CRM114-Status: GOOD (  21.12  )
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

Implement Diffie-Hellman key exchange using FFDHE groups
for NVMe In-Band Authentication.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/common/auth.c | 153 ++++++++++++++++++++++++++++
 drivers/nvme/host/Kconfig  |   2 +
 drivers/nvme/host/auth.c   | 201 +++++++++++++++++++++++++++++++++++--
 include/linux/nvme-auth.h  |   8 ++
 4 files changed, 358 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 01adb29947d4..0c86ebce59d2 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -301,6 +301,159 @@ u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_transform_key);
 
+static int nvme_auth_hash_skey(int hmac_id, u8 *skey, size_t skey_len, u8 *hkey)
+{
+	const char *digest_name;
+	struct crypto_shash *tfm;
+	int ret;
+
+	digest_name = nvme_auth_digest_name(hmac_id);
+	if (!digest_name) {
+		pr_debug("%s: failed to get digest for %d\n", __func__,
+			 hmac_id);
+		return -EINVAL;
+	}
+	tfm = crypto_alloc_shash(digest_name, 0, 0);
+	if (IS_ERR(tfm))
+		return -ENOMEM;
+
+	ret = crypto_shash_tfm_digest(tfm, skey, skey_len, hkey);
+	if (ret < 0)
+		pr_debug("%s: Failed to hash digest len %zu\n", __func__,
+			 skey_len);
+
+	crypto_free_shash(tfm);
+	return ret;
+}
+
+int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
+		u8 *challenge, u8 *aug, size_t hlen)
+{
+	struct crypto_shash *tfm;
+	struct shash_desc *desc;
+	u8 *hashed_key;
+	const char *hmac_name;
+	int ret;
+
+	hashed_key = kmalloc(hlen, GFP_KERNEL);
+	if (!hashed_key)
+		return -ENOMEM;
+
+	ret = nvme_auth_hash_skey(hmac_id, skey,
+				  skey_len, hashed_key);
+	if (ret < 0)
+		goto out_free_key;
+
+	hmac_name = nvme_auth_hmac_name(hmac_id);
+	if (!hmac_name) {
+		pr_warn("%s: invalid hash algoritm %d\n",
+			__func__, hmac_id);
+		ret = -EINVAL;
+		goto out_free_key;
+	}
+
+	tfm = crypto_alloc_shash(hmac_name, 0, 0);
+	if (IS_ERR(tfm)) {
+		ret = PTR_ERR(tfm);
+		goto out_free_key;
+	}
+
+	desc = kmalloc(sizeof(struct shash_desc) + crypto_shash_descsize(tfm),
+		       GFP_KERNEL);
+	if (!desc) {
+		ret = -ENOMEM;
+		goto out_free_hash;
+	}
+	desc->tfm = tfm;
+
+	ret = crypto_shash_setkey(tfm, hashed_key, hlen);
+	if (ret)
+		goto out_free_desc;
+
+	ret = crypto_shash_init(desc);
+	if (ret)
+		goto out_free_desc;
+
+	ret = crypto_shash_update(desc, challenge, hlen);
+	if (ret)
+		goto out_free_desc;
+
+	ret = crypto_shash_final(desc, aug);
+out_free_desc:
+	kfree_sensitive(desc);
+out_free_hash:
+	crypto_free_shash(tfm);
+out_free_key:
+	kfree_sensitive(hashed_key);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_augmented_challenge);
+
+int nvme_auth_gen_privkey(struct crypto_kpp *dh_tfm, u8 dh_gid)
+{
+	int ret;
+
+	ret = crypto_kpp_set_secret(dh_tfm, NULL, 0);
+	if (ret)
+		pr_debug("failed to set private key, error %d\n", ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_gen_privkey);
+
+int nvme_auth_gen_pubkey(struct crypto_kpp *dh_tfm,
+		u8 *host_key, size_t host_key_len)
+{
+	struct kpp_request *req;
+	struct crypto_wait wait;
+	struct scatterlist dst;
+	int ret;
+
+	req = kpp_request_alloc(dh_tfm, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	crypto_init_wait(&wait);
+	kpp_request_set_input(req, NULL, 0);
+	sg_init_one(&dst, host_key, host_key_len);
+	kpp_request_set_output(req, &dst, host_key_len);
+	kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				 crypto_req_done, &wait);
+
+	ret = crypto_wait_req(crypto_kpp_generate_public_key(req), &wait);
+	kpp_request_free(req);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_gen_pubkey);
+
+int nvme_auth_gen_shared_secret(struct crypto_kpp *dh_tfm,
+		u8 *ctrl_key, size_t ctrl_key_len,
+		u8 *sess_key, size_t sess_key_len)
+{
+	struct kpp_request *req;
+	struct crypto_wait wait;
+	struct scatterlist src, dst;
+	int ret;
+
+	req = kpp_request_alloc(dh_tfm, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	crypto_init_wait(&wait);
+	sg_init_one(&src, ctrl_key, ctrl_key_len);
+	kpp_request_set_input(req, &src, ctrl_key_len);
+	sg_init_one(&dst, sess_key, sess_key_len);
+	kpp_request_set_output(req, &dst, sess_key_len);
+	kpp_request_set_callback(req, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				 crypto_req_done, &wait);
+
+	ret = crypto_wait_req(crypto_kpp_compute_shared_secret(req), &wait);
+
+	kpp_request_free(req);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_gen_shared_secret);
+
 int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key)
 {
 	struct nvme_dhchap_key *key;
diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 6c503f42f3c6..2f6a7f8c94e8 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -100,6 +100,8 @@ config NVME_AUTH
 	select CRYPTO_HMAC
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
+	select CRYPTO_DH
+	select CRYPTO_DH_RFC7919_GROUPS
 	help
 	  This provides support for NVMe over Fabrics In-Band Authentication.
 
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 9766bfffecac..c8a6db7c4498 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -18,6 +18,7 @@ struct nvme_dhchap_queue_context {
 	struct work_struct auth_work;
 	struct nvme_ctrl *ctrl;
 	struct crypto_shash *shash_tfm;
+	struct crypto_kpp *dh_tfm;
 	void *buf;
 	size_t buf_size;
 	int qid;
@@ -33,6 +34,12 @@ struct nvme_dhchap_queue_context {
 	u8 c2[64];
 	u8 response[64];
 	u8 *host_response;
+	u8 *ctrl_key;
+	int ctrl_key_len;
+	u8 *host_key;
+	int host_key_len;
+	u8 *sess_key;
+	int sess_key_len;
 };
 
 #define nvme_auth_flags_from_qid(qid) \
@@ -137,6 +144,7 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 	struct nvmf_auth_dhchap_challenge_data *data = chap->buf;
 	u16 dhvlen = le16_to_cpu(data->dhvlen);
 	size_t size = sizeof(*data) + data->hl + dhvlen;
+	const char *gid_name = nvme_auth_dhgroup_name(data->dhgid);
 	const char *hmac_name, *kpp_name;
 
 	if (chap->buf_size < size) {
@@ -207,15 +215,54 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 			 "qid %d: invalid DH group id %d\n",
 			 chap->qid, data->dhgid);
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
+		/* Leave previous dh_tfm intact */
 		return NVME_SC_AUTH_REQUIRED;
 	}
 
+	/* Clear host and controller key to avoid accidental reuse */
+	kfree_sensitive(chap->host_key);
+	chap->host_key = NULL;
+	chap->host_key_len = 0;
+	kfree_sensitive(chap->ctrl_key);
+	chap->ctrl_key = NULL;
+	chap->ctrl_key_len = 0;
+
+	if (chap->dhgroup_id == data->dhgid &&
+	    (data->dhgid == NVME_AUTH_DHGROUP_NULL || chap->dh_tfm)) {
+		dev_dbg(ctrl->device,
+			"qid %d: reuse existing DH group %s\n",
+			chap->qid, gid_name);
+		goto skip_kpp;
+	}
+
+	/* Reset dh_tfm if it can't be reused */
+	if (chap->dh_tfm) {
+		crypto_free_kpp(chap->dh_tfm);
+		chap->dh_tfm = NULL;
+	}
+
 	if (data->dhgid != NVME_AUTH_DHGROUP_NULL) {
-		dev_warn(ctrl->device,
-			 "qid %d: unsupported DH group %s\n",
-			 chap->qid, kpp_name);
-		chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
-		return NVME_SC_AUTH_REQUIRED;
+		if (dhvlen == 0) {
+			dev_warn(ctrl->device,
+				 "qid %d: empty DH value\n",
+				 chap->qid);
+			chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
+			return NVME_SC_INVALID_FIELD;
+		}
+
+		chap->dh_tfm = crypto_alloc_kpp(kpp_name, 0, 0);
+		if (IS_ERR(chap->dh_tfm)) {
+			int ret = PTR_ERR(chap->dh_tfm);
+
+			dev_warn(ctrl->device,
+				 "qid %d: error %d initializing DH group %s\n",
+				 chap->qid, ret, gid_name);
+			chap->status = NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
+			chap->dh_tfm = NULL;
+			return NVME_SC_AUTH_REQUIRED;
+		}
+		dev_dbg(ctrl->device, "qid %d: selected DH group %s\n",
+			chap->qid, gid_name);
 	} else if (dhvlen != 0) {
 		dev_warn(ctrl->device,
 			 "qid %d: invalid DH value for NULL DH\n",
@@ -225,8 +272,21 @@ static int nvme_auth_process_dhchap_challenge(struct nvme_ctrl *ctrl,
 	}
 	chap->dhgroup_id = data->dhgid;
 
+skip_kpp:
 	chap->s1 = le32_to_cpu(data->seqnum);
 	memcpy(chap->c1, data->cval, chap->hash_len);
+	if (dhvlen) {
+		chap->ctrl_key = kmalloc(dhvlen, GFP_KERNEL);
+		if (!chap->ctrl_key) {
+			chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
+			return NVME_SC_AUTH_REQUIRED;
+		}
+		chap->ctrl_key_len = dhvlen;
+		memcpy(chap->ctrl_key, data->cval + chap->hash_len,
+		       dhvlen);
+		dev_dbg(ctrl->device, "ctrl public key %*ph\n",
+			 (int)chap->ctrl_key_len, chap->ctrl_key);
+	}
 
 	return 0;
 }
@@ -239,6 +299,9 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
 
 	size += 2 * chap->hash_len;
 
+	if (chap->host_key_len)
+		size += chap->host_key_len;
+
 	if (chap->buf_size < size) {
 		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
 		return -EINVAL;
@@ -249,7 +312,7 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
 	data->auth_id = NVME_AUTH_DHCHAP_MESSAGE_REPLY;
 	data->t_id = cpu_to_le16(chap->transaction);
 	data->hl = chap->hash_len;
-	data->dhvlen = 0;
+	data->dhvlen = cpu_to_le16(chap->host_key_len);
 	memcpy(data->rval, chap->response, chap->hash_len);
 	if (ctrl->ctrl_key) {
 		get_random_bytes(chap->c2, chap->hash_len);
@@ -264,6 +327,14 @@ static int nvme_auth_set_dhchap_reply_data(struct nvme_ctrl *ctrl,
 		chap->s2 = 0;
 	}
 	data->seqnum = cpu_to_le32(chap->s2);
+	if (chap->host_key_len) {
+		dev_dbg(ctrl->device, "%s: qid %d host public key %*ph\n",
+			__func__, chap->qid,
+			chap->host_key_len, chap->host_key);
+		memcpy(data->rval + 2 * chap->hash_len, chap->host_key,
+		       chap->host_key_len);
+	}
+
 	return size;
 }
 
@@ -381,6 +452,21 @@ static int nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
 		goto out;
 	}
 
+	if (chap->dh_tfm) {
+		challenge = kmalloc(chap->hash_len, GFP_KERNEL);
+		if (!challenge) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		ret = nvme_auth_augmented_challenge(chap->hash_id,
+						    chap->sess_key,
+						    chap->sess_key_len,
+						    chap->c1, challenge,
+						    chap->hash_len);
+		if (ret)
+			goto out;
+	}
+
 	shash->tfm = chap->shash_tfm;
 	ret = crypto_shash_init(shash);
 	if (ret)
@@ -443,6 +529,20 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
 		goto out;
 	}
 
+	if (chap->dh_tfm) {
+		challenge = kmalloc(chap->hash_len, GFP_KERNEL);
+		if (!challenge) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		ret = nvme_auth_augmented_challenge(chap->hash_id,
+						    chap->sess_key,
+						    chap->sess_key_len,
+						    chap->c2, challenge,
+						    chap->hash_len);
+		if (ret)
+			goto out;
+	}
 	dev_dbg(ctrl->device, "%s: qid %d ctrl response seq %u transaction %d\n",
 		__func__, chap->qid, chap->s2, chap->transaction);
 	dev_dbg(ctrl->device, "%s: qid %d challenge %*ph\n",
@@ -492,8 +592,81 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
 	return ret;
 }
 
+static int nvme_auth_dhchap_exponential(struct nvme_ctrl *ctrl,
+		struct nvme_dhchap_queue_context *chap)
+{
+	int ret;
+
+	if (chap->host_key && chap->host_key_len) {
+		dev_dbg(ctrl->device,
+			"qid %d: reusing host key\n", chap->qid);
+		goto gen_sesskey;
+	}
+	ret = nvme_auth_gen_privkey(chap->dh_tfm, chap->dhgroup_id);
+	if (ret < 0) {
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+		return ret;
+	}
+
+	chap->host_key_len = crypto_kpp_maxsize(chap->dh_tfm);
+
+	chap->host_key = kzalloc(chap->host_key_len, GFP_KERNEL);
+	if (!chap->host_key) {
+		chap->host_key_len = 0;
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
+		return -ENOMEM;
+	}
+	ret = nvme_auth_gen_pubkey(chap->dh_tfm,
+				   chap->host_key, chap->host_key_len);
+	if (ret) {
+		dev_dbg(ctrl->device,
+			"failed to generate public key, error %d\n", ret);
+		kfree(chap->host_key);
+		chap->host_key = NULL;
+		chap->host_key_len = 0;
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+		return ret;
+	}
+
+gen_sesskey:
+	chap->sess_key_len = chap->host_key_len;
+	chap->sess_key = kmalloc(chap->sess_key_len, GFP_KERNEL);
+	if (!chap->sess_key) {
+		chap->sess_key_len = 0;
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
+		return -ENOMEM;
+	}
+
+	ret = nvme_auth_gen_shared_secret(chap->dh_tfm,
+					  chap->ctrl_key, chap->ctrl_key_len,
+					  chap->sess_key, chap->sess_key_len);
+	if (ret) {
+		dev_dbg(ctrl->device,
+			"failed to generate shared secret, error %d\n", ret);
+		kfree_sensitive(chap->sess_key);
+		chap->sess_key = NULL;
+		chap->sess_key_len = 0;
+		chap->status = NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
+		return ret;
+	}
+	dev_dbg(ctrl->device, "shared secret %*ph\n",
+		(int)chap->sess_key_len, chap->sess_key);
+	return 0;
+}
+
 static void __nvme_auth_reset(struct nvme_dhchap_queue_context *chap)
 {
+	kfree_sensitive(chap->host_response);
+	chap->host_response = NULL;
+	kfree_sensitive(chap->host_key);
+	chap->host_key = NULL;
+	chap->host_key_len = 0;
+	kfree_sensitive(chap->ctrl_key);
+	chap->ctrl_key = NULL;
+	chap->ctrl_key_len = 0;
+	kfree_sensitive(chap->sess_key);
+	chap->sess_key = NULL;
+	chap->sess_key_len = 0;
 	chap->status = 0;
 	chap->error = 0;
 	chap->s1 = 0;
@@ -508,6 +681,11 @@ static void __nvme_auth_free(struct nvme_dhchap_queue_context *chap)
 	__nvme_auth_reset(chap);
 	if (chap->shash_tfm)
 		crypto_free_shash(chap->shash_tfm);
+	if (chap->dh_tfm)
+		crypto_free_kpp(chap->dh_tfm);
+	kfree_sensitive(chap->ctrl_key);
+	kfree_sensitive(chap->host_key);
+	kfree_sensitive(chap->sess_key);
 	kfree_sensitive(chap->host_response);
 	kfree(chap->buf);
 	kfree(chap);
@@ -566,6 +744,17 @@ static void __nvme_auth_work(struct work_struct *work)
 		goto fail2;
 	}
 
+	if (chap->ctrl_key_len) {
+		dev_dbg(ctrl->device,
+			"%s: qid %d DH exponential\n",
+			__func__, chap->qid);
+		ret = nvme_auth_dhchap_exponential(ctrl, chap);
+		if (ret) {
+			chap->error = ret;
+			goto fail2;
+		}
+	}
+
 	dev_dbg(ctrl->device, "%s: qid %d host response\n",
 		__func__, chap->qid);
 	ret = nvme_auth_dhchap_setup_host_response(ctrl, chap);
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index 354456826221..dcb8030062dd 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -29,5 +29,13 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 void nvme_auth_free_key(struct nvme_dhchap_key *key);
 u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn);
 int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key);
+int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
+				  u8 *challenge, u8 *aug, size_t hlen);
+int nvme_auth_gen_privkey(struct crypto_kpp *dh_tfm, u8 dh_gid);
+int nvme_auth_gen_pubkey(struct crypto_kpp *dh_tfm,
+			 u8 *host_key, size_t host_key_len);
+int nvme_auth_gen_shared_secret(struct crypto_kpp *dh_tfm,
+				u8 *ctrl_key, size_t ctrl_key_len,
+				u8 *sess_key, size_t sess_key_len);
 
 #endif /* _NVME_AUTH_H */
-- 
2.29.2


