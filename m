Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD6ED58E73
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Mar 2026 08:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=553Fov1cOE8cpSCcA9jZJ4KLxNFV04uXKHOfjpQAxVU=; b=PO5uzmVrWGNarOzLQFE3TOr+/d
	1RFAoiWUXkxAVun39GtBipI441bWKpGf/RMHus+xiup9a27PIys7YqLSnPBJoMW8foWT3TdCDQhOw
	sxMA/AMXgqli+jDOUtQCznRSOCaySRhss2lEf6mRU3nJExtexlUxd+/6fW8cUGhdNj6NNHCva73CX
	YQRD1BdYaTKjtqMi4Ue3v/PMhnbxQbU2/Zp/GR99esbhpN/jtI3zv5KU3URAXZ4rXLLP2kZuUbv42
	eG1fDgG/A1kGOFg/UOrnQKutTH2/xPz1uhCCOGJoAPjztvtIDMLQuT5+b/tVFYU7DrOFMHWtFiAFx
	Du1yrHkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDT-0000000CSYt-2aWc;
	Mon, 02 Mar 2026 08:01:23 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vwyDR-0000000CSY0-3O9i
	for linux-nvme@lists.infradead.org;
	Mon, 02 Mar 2026 08:01:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2570560133;
	Mon,  2 Mar 2026 08:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96AF8C2BCAF;
	Mon,  2 Mar 2026 08:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772438480;
	bh=9/nRd4mgsPYnCTk0pCNNblsCpNBVeIGSFW6efgLYF44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jGJpsX7/nILOfvMLJ5meZzQVwoK1Yf3N1NSQn2KoUJgNGrkFmB8e/YhcmJtP2aYpo
	 tD6kvp20Fwr2hom6xkcjw/2xda37qowr6NH/xa6i5kdM91eW4nlQev3WAmM7dfOW85
	 uwNFFVQUsITZcehRLL5lUdnvsUKFg/XoWGF/gdPgmcaNy5/NJfpzim4I3IEs+0VX6d
	 /obqI463qJypFU/V8CEbTGKPCnLncRKlXNdCRp/9QTGpZ5ouvBhiy5JYhwZqm3Or+n
	 kaj8OoIAHrWK54cEnxVy0GKosy4TPvUSd30u/zk0/sDHhtp40oZ4svZ6lUkd54Ljm4
	 3bZf5edCAghvw==
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
Subject: [PATCH 03/21] nvme-auth: use proper argument types
Date: Sun,  1 Mar 2026 23:59:41 -0800
Message-ID: <20260302075959.338638-4-ebiggers@kernel.org>
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

For input parameters, use pointer to const.  This makes it easier to
understand which parameters are inputs and which are outputs.

In addition, consistently use char for strings and u8 for binary.  This
makes it easier to understand what is a string and what is binary data.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/nvme/common/auth.c  | 47 ++++++++++++++++++++-----------------
 drivers/nvme/host/auth.c    |  3 ++-
 drivers/nvme/target/auth.c  |  5 ++--
 drivers/nvme/target/nvmet.h |  2 +-
 include/linux/nvme-auth.h   | 26 ++++++++++----------
 5 files changed, 44 insertions(+), 39 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 9e5cee217ff5c..d35523d0a017b 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -157,15 +157,14 @@ u32 nvme_auth_key_struct_size(u32 key_len)
 
 	return struct_size(&key, key, key_len);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_key_struct_size);
 
-struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
-					      u8 key_hash)
+struct nvme_dhchap_key *nvme_auth_extract_key(const char *secret, u8 key_hash)
 {
 	struct nvme_dhchap_key *key;
-	unsigned char *p;
+	const char *p;
 	u32 crc;
 	int ret, key_len;
 	size_t allocated_len = strlen(secret);
 
 	/* Secret might be affixed with a ':' */
@@ -179,18 +178,18 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 	key_len = base64_decode(secret, allocated_len, key->key, true, BASE64_STD);
 	if (key_len < 0) {
 		pr_debug("base64 key decoding error %d\n",
 			 key_len);
 		ret = key_len;
-		goto out_free_secret;
+		goto out_free_key;
 	}
 
 	if (key_len != 36 && key_len != 52 &&
 	    key_len != 68) {
 		pr_err("Invalid key len %d\n", key_len);
 		ret = -EINVAL;
-		goto out_free_secret;
+		goto out_free_key;
 	}
 
 	/* The last four bytes is the CRC in little-endian format */
 	key_len -= 4;
 	/*
@@ -201,16 +200,16 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 
 	if (get_unaligned_le32(key->key + key_len) != crc) {
 		pr_err("key crc mismatch (key %08x, crc %08x)\n",
 		       get_unaligned_le32(key->key + key_len), crc);
 		ret = -EKEYREJECTED;
-		goto out_free_secret;
+		goto out_free_key;
 	}
 	key->len = key_len;
 	key->hash = key_hash;
 	return key;
-out_free_secret:
+out_free_key:
 	nvme_auth_free_key(key);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_extract_key);
 
@@ -234,11 +233,11 @@ void nvme_auth_free_key(struct nvme_dhchap_key *key)
 	kfree_sensitive(key);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_free_key);
 
 struct nvme_dhchap_key *nvme_auth_transform_key(
-		struct nvme_dhchap_key *key, char *nqn)
+		const struct nvme_dhchap_key *key, const char *nqn)
 {
 	const char *hmac_name;
 	struct crypto_shash *key_tfm;
 	SHASH_DESC_ON_STACK(shash, key_tfm);
 	struct nvme_dhchap_key *transformed_key;
@@ -300,11 +299,12 @@ struct nvme_dhchap_key *nvme_auth_transform_key(
 
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_transform_key);
 
-static int nvme_auth_hash_skey(int hmac_id, u8 *skey, size_t skey_len, u8 *hkey)
+static int nvme_auth_hash_skey(int hmac_id, const u8 *skey, size_t skey_len,
+			       u8 *hkey)
 {
 	const char *digest_name;
 	struct crypto_shash *tfm;
 	int ret;
 
@@ -325,12 +325,12 @@ static int nvme_auth_hash_skey(int hmac_id, u8 *skey, size_t skey_len, u8 *hkey)
 
 	crypto_free_shash(tfm);
 	return ret;
 }
 
-int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
-		u8 *challenge, u8 *aug, size_t hlen)
+int nvme_auth_augmented_challenge(u8 hmac_id, const u8 *skey, size_t skey_len,
+				  const u8 *challenge, u8 *aug, size_t hlen)
 {
 	struct crypto_shash *tfm;
 	u8 *hashed_key;
 	const char *hmac_name;
 	int ret;
@@ -407,11 +407,11 @@ int nvme_auth_gen_pubkey(struct crypto_kpp *dh_tfm,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_gen_pubkey);
 
 int nvme_auth_gen_shared_secret(struct crypto_kpp *dh_tfm,
-		u8 *ctrl_key, size_t ctrl_key_len,
+		const u8 *ctrl_key, size_t ctrl_key_len,
 		u8 *sess_key, size_t sess_key_len)
 {
 	struct kpp_request *req;
 	struct crypto_wait wait;
 	struct scatterlist src, dst;
@@ -434,11 +434,11 @@ int nvme_auth_gen_shared_secret(struct crypto_kpp *dh_tfm,
 	kpp_request_free(req);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_gen_shared_secret);
 
-int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key)
+int nvme_auth_generate_key(const char *secret, struct nvme_dhchap_key **ret_key)
 {
 	struct nvme_dhchap_key *key;
 	u8 key_hash;
 
 	if (!secret) {
@@ -482,12 +482,13 @@ EXPORT_SYMBOL_GPL(nvme_auth_generate_key);
  * PSK = HMAC(KS, C1 || C2)).
  *
  * Returns 0 on success with a valid generated PSK pointer in @ret_psk and
  * the length of @ret_psk in @ret_len, or a negative error number otherwise.
  */
-int nvme_auth_generate_psk(u8 hmac_id, u8 *skey, size_t skey_len,
-		u8 *c1, u8 *c2, size_t hash_len, u8 **ret_psk, size_t *ret_len)
+int nvme_auth_generate_psk(u8 hmac_id, const u8 *skey, size_t skey_len,
+			   const u8 *c1, const u8 *c2, size_t hash_len,
+			   u8 **ret_psk, size_t *ret_len)
 {
 	struct crypto_shash *tfm;
 	SHASH_DESC_ON_STACK(shash, tfm);
 	u8 *psk;
 	const char *hmac_name;
@@ -580,16 +581,18 @@ EXPORT_SYMBOL_GPL(nvme_auth_generate_psk);
  *   characters long.
  *
  * Returns 0 on success with a valid digest pointer in @ret_digest, or a
  * negative error number on failure.
  */
-int nvme_auth_generate_digest(u8 hmac_id, u8 *psk, size_t psk_len,
-		char *subsysnqn, char *hostnqn, u8 **ret_digest)
+int nvme_auth_generate_digest(u8 hmac_id, const u8 *psk, size_t psk_len,
+			      const char *subsysnqn, const char *hostnqn,
+			      char **ret_digest)
 {
 	struct crypto_shash *tfm;
 	SHASH_DESC_ON_STACK(shash, tfm);
-	u8 *digest, *enc;
+	u8 *digest;
+	char *enc;
 	const char *hmac_name;
 	size_t digest_len, hmac_len;
 	int ret;
 
 	if (WARN_ON(!subsysnqn || !hostnqn))
@@ -759,20 +762,20 @@ static int hkdf_expand_label(struct crypto_shash *hmac_tfm,
  * and 48 for SHA-384).
  *
  * Returns 0 on success with a valid psk pointer in @ret_psk or a negative
  * error number otherwise.
  */
-int nvme_auth_derive_tls_psk(int hmac_id, u8 *psk, size_t psk_len,
-		u8 *psk_digest, u8 **ret_psk)
+int nvme_auth_derive_tls_psk(int hmac_id, const u8 *psk, size_t psk_len,
+			     const char *psk_digest, u8 **ret_psk)
 {
 	struct crypto_shash *hmac_tfm;
 	const char *hmac_name;
 	const char *label = "nvme-tls-psk";
-	static const char default_salt[NVME_AUTH_MAX_DIGEST_SIZE];
+	static const u8 default_salt[NVME_AUTH_MAX_DIGEST_SIZE];
 	size_t prk_len;
 	const char *ctx;
-	unsigned char *prk, *tls_key;
+	u8 *prk, *tls_key;
 	int ret;
 
 	hmac_name = nvme_auth_hmac_name(hmac_id);
 	if (!hmac_name) {
 		pr_warn("%s: invalid hash algorithm %d\n",
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 301c858b7c577..d0d0a9d5a8717 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -706,11 +706,12 @@ void nvme_auth_revoke_tls_key(struct nvme_ctrl *ctrl)
 EXPORT_SYMBOL_GPL(nvme_auth_revoke_tls_key);
 
 static int nvme_auth_secure_concat(struct nvme_ctrl *ctrl,
 				   struct nvme_dhchap_queue_context *chap)
 {
-	u8 *psk, *digest, *tls_psk;
+	u8 *psk, *tls_psk;
+	char *digest;
 	struct key *tls_key;
 	size_t psk_len;
 	int ret = 0;
 
 	if (!chap->sess_key) {
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 2eadeb7e06f26..f483e1fd48acc 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -529,11 +529,11 @@ int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
 
 	return ret;
 }
 
 int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
-			    u8 *pkey, int pkey_size)
+			    const u8 *pkey, int pkey_size)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	int ret;
 
 	req->sq->dhchap_skey_len = ctrl->dh_keysize;
@@ -555,11 +555,12 @@ int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
 }
 
 void nvmet_auth_insert_psk(struct nvmet_sq *sq)
 {
 	int hash_len = nvme_auth_hmac_hash_len(sq->ctrl->shash_id);
-	u8 *psk, *digest, *tls_psk;
+	u8 *psk, *tls_psk;
+	char *digest;
 	size_t psk_len;
 	int ret;
 #ifdef CONFIG_NVME_TARGET_TCP_TLS
 	struct key *tls_key = NULL;
 #endif
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index b664b584fdc8e..986d4c7bd734b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -910,11 +910,11 @@ static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
 	return ctrl->host_key != NULL && !nvmet_queue_tls_keyid(sq);
 }
 int nvmet_auth_ctrl_exponential(struct nvmet_req *req,
 				u8 *buf, int buf_size);
 int nvmet_auth_ctrl_sesskey(struct nvmet_req *req,
-			    u8 *buf, int buf_size);
+			    const u8 *pkey, int pkey_size);
 void nvmet_auth_insert_psk(struct nvmet_sq *sq);
 #else
 static inline u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl,
 				  struct nvmet_sq *sq)
 {
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index 60e069a6757ff..a4b248c24ccf6 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -23,29 +23,29 @@ const char *nvme_auth_hmac_name(u8 hmac_id);
 const char *nvme_auth_digest_name(u8 hmac_id);
 size_t nvme_auth_hmac_hash_len(u8 hmac_id);
 u8 nvme_auth_hmac_id(const char *hmac_name);
 
 u32 nvme_auth_key_struct_size(u32 key_len);
-struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
-					      u8 key_hash);
+struct nvme_dhchap_key *nvme_auth_extract_key(const char *secret, u8 key_hash);
 void nvme_auth_free_key(struct nvme_dhchap_key *key);
 struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash);
 struct nvme_dhchap_key *nvme_auth_transform_key(
-				struct nvme_dhchap_key *key, char *nqn);
-int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key);
-int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
-				  u8 *challenge, u8 *aug, size_t hlen);
+		const struct nvme_dhchap_key *key, const char *nqn);
+int nvme_auth_generate_key(const char *secret, struct nvme_dhchap_key **ret_key);
+int nvme_auth_augmented_challenge(u8 hmac_id, const u8 *skey, size_t skey_len,
+				  const u8 *challenge, u8 *aug, size_t hlen);
 int nvme_auth_gen_privkey(struct crypto_kpp *dh_tfm, u8 dh_gid);
 int nvme_auth_gen_pubkey(struct crypto_kpp *dh_tfm,
 			 u8 *host_key, size_t host_key_len);
 int nvme_auth_gen_shared_secret(struct crypto_kpp *dh_tfm,
-				u8 *ctrl_key, size_t ctrl_key_len,
+				const u8 *ctrl_key, size_t ctrl_key_len,
 				u8 *sess_key, size_t sess_key_len);
-int nvme_auth_generate_psk(u8 hmac_id, u8 *skey, size_t skey_len,
-			   u8 *c1, u8 *c2, size_t hash_len,
+int nvme_auth_generate_psk(u8 hmac_id, const u8 *skey, size_t skey_len,
+			   const u8 *c1, const u8 *c2, size_t hash_len,
 			   u8 **ret_psk, size_t *ret_len);
-int nvme_auth_generate_digest(u8 hmac_id, u8 *psk, size_t psk_len,
-		char *subsysnqn, char *hostnqn, u8 **ret_digest);
-int nvme_auth_derive_tls_psk(int hmac_id, u8 *psk, size_t psk_len,
-		u8 *psk_digest, u8 **ret_psk);
+int nvme_auth_generate_digest(u8 hmac_id, const u8 *psk, size_t psk_len,
+			      const char *subsysnqn, const char *hostnqn,
+			      char **ret_digest);
+int nvme_auth_derive_tls_psk(int hmac_id, const u8 *psk, size_t psk_len,
+			     const char *psk_digest, u8 **ret_psk);
 
 #endif /* _NVME_AUTH_H */
-- 
2.53.0


