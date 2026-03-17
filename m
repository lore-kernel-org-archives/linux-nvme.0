Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48350FD8766
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 13:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SVoRdn/YextM5hWfTruEnqPUFgqV1h9usjNsQJ4Q0j4=; b=heS5B4dpqSivmOzxih9A2r6p/v
	AtVkFj9xjeyqvDtlvH0Fl/Ae//sZ6o/Nc52ysRbondpTbyJhPc4WhJwir/Z8KhRQdOcz4740wtJx4
	T5YARAmYVY3ltCskSmP8oXD5RYaFHeWxF8j/Z5g5czvyb1iq4Sw8GPkR2UMYfISCwy0PZP0PaldCi
	dNXoYop6YPNXwVojTpA7agBI2HOYXPuPuatPiXlyT2D6EHzm0iLwg26yDp2OCr9uxl1fWXJQ1f0SY
	YHg/WUIxn507DtKG76ODsUqRDqbr5d+V7VPIVXlJVHovKWQJD7KJIwpwo7rysB2dUy48S9fcSNuI7
	zCuDPjyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2U32-00000006Lf6-0FaR;
	Tue, 17 Mar 2026 13:01:24 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2U30-00000006Le9-3zsw
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 13:01:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3D71A60018;
	Tue, 17 Mar 2026 13:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B76C2BC86;
	Tue, 17 Mar 2026 13:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773752481;
	bh=AxDUSIAFF3XCJraGSxjs/CpuM1hBEUjJejTc/Uq9aBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CmtzMab21CJaIY/75BRlTWkP+xolExVzWJ9S4BdHKKbVfDcH7cN0ZY//M2anFis8P
	 XWjmOTO8x0dODLSTVwQPldPJFnaAfktNkaUV58Zq8m2CAOEsvhKRRFC5SS+OT5ferz
	 Ew3zmnlFw1gRJ4OlefcZJKdcoq5xyzw1B43BwEcxuU1g8daE9KQTrpAYCm/WA9WQMW
	 yqL+6znQWe1Xk0ZwvKUjFq74+8UqvMkPB6gukdz2Dc5RQNr6ygY64Zla+dDzvsdwJH
	 cE5jCXbKE34IbAP/ep1bKPg1/ymWv9wYK0hF07o50MmHypVQ0dKz6u/CVtkT/tnmnv
	 SYjRQjDfqkTAw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/8] nvme-auth: switch to use 'struct key'
Date: Tue, 17 Mar 2026 14:00:58 +0100
Message-ID: <20260317130103.107360-4-hare@kernel.org>
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

Use the new key type 'dhchap' to store the DH-HMAC-CHAP keys and modify
handling function to use 'struct key'. With that we can drop the now
unused 'struct nvme_dhchap_key' definitions.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/Kconfig   |   1 +
 drivers/nvme/common/auth.c    | 191 +++++++++++++---------------------
 drivers/nvme/common/keyring.c |  98 +++++++++++++++++
 drivers/nvme/host/Kconfig     |   1 -
 drivers/nvme/host/auth.c      |  28 +++--
 drivers/nvme/host/nvme.h      |   4 +-
 drivers/nvme/host/sysfs.c     |  26 +++--
 drivers/nvme/target/Kconfig   |   1 -
 drivers/nvme/target/auth.c    |  40 +++----
 drivers/nvme/target/nvmet.h   |   4 +-
 include/linux/nvme-auth.h     |  17 +--
 include/linux/nvme-keyring.h  |  22 +++-
 12 files changed, 256 insertions(+), 177 deletions(-)

diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
index f1639db65fd3..9f72c2668f2f 100644
--- a/drivers/nvme/common/Kconfig
+++ b/drivers/nvme/common/Kconfig
@@ -11,6 +11,7 @@ config NVME_AUTH
 	select CRYPTO_DH_RFC7919_GROUPS
 	select CRYPTO_LIB_SHA256
 	select CRYPTO_LIB_SHA512
+	select NVME_KEYRING
 
 config NVME_AUTH_KUNIT_TEST
 	tristate "KUnit tests for NVMe authentication" if !KUNIT_ALL_TESTS
diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 772af9b6dccd..9879d2bee59e 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -13,6 +13,8 @@
 #include <crypto/sha2.h>
 #include <linux/nvme.h>
 #include <linux/nvme-auth.h>
+#include <linux/nvme-keyring.h>
+#include <keys/user-type.h>
 
 static u32 nvme_dhchap_seqnum;
 static DEFINE_MUTEX(nvme_dhchap_mutex);
@@ -138,89 +140,30 @@ size_t nvme_auth_hmac_hash_len(u8 hmac_id)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
 
-u32 nvme_auth_key_struct_size(u32 key_len)
-{
-	struct nvme_dhchap_key key;
-
-	return struct_size(&key, key, key_len);
-}
-EXPORT_SYMBOL_GPL(nvme_auth_key_struct_size);
-
-struct nvme_dhchap_key *nvme_auth_extract_key(const char *secret, u8 key_hash)
+/**
+ * nvme_auth_extract_key - extract the DH-HMAC-CHAP key
+ *
+ * @secret: key data
+ * @secret_len: length of @secret
+ *
+ * Extracts a dhchap key from @secret.
+ *
+ * Returns the dhchap key or an error pointer on failure.
+ */
+struct key *nvme_auth_extract_key(struct key *keyring, const char *secret,
+				  size_t secret_len)
 {
-	struct nvme_dhchap_key *key;
-	const char *p;
-	u32 crc;
-	int ret, key_len;
-	size_t allocated_len = strlen(secret);
-
-	/* Secret might be affixed with a ':' */
-	p = strrchr(secret, ':');
-	if (p)
-		allocated_len = p - secret;
-	key = nvme_auth_alloc_key(allocated_len, 0);
-	if (!key)
-		return ERR_PTR(-ENOMEM);
-
-	key_len = base64_decode(secret, allocated_len, key->key, true, BASE64_STD);
-	if (key_len < 0) {
-		pr_debug("base64 key decoding error %d\n",
-			 key_len);
-		ret = key_len;
-		goto out_free_key;
-	}
+	struct key *key;
 
-	if (key_len != 36 && key_len != 52 &&
-	    key_len != 68) {
-		pr_err("Invalid key len %d\n", key_len);
-		ret = -EINVAL;
-		goto out_free_key;
+	key = nvme_dhchap_psk_create(keyring, secret, secret_len);
+	if (!IS_ERR(key)) {
+		pr_debug("generated dhchap key %s\n",
+			 key->description);
 	}
-
-	/* The last four bytes is the CRC in little-endian format */
-	key_len -= 4;
-	/*
-	 * The linux implementation doesn't do pre- and post-increments,
-	 * so we have to do it manually.
-	 */
-	crc = ~crc32(~0, key->key, key_len);
-
-	if (get_unaligned_le32(key->key + key_len) != crc) {
-		pr_err("key crc mismatch (key %08x, crc %08x)\n",
-		       get_unaligned_le32(key->key + key_len), crc);
-		ret = -EKEYREJECTED;
-		goto out_free_key;
-	}
-	key->len = key_len;
-	key->hash = key_hash;
 	return key;
-out_free_key:
-	nvme_auth_free_key(key);
-	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_extract_key);
 
-struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash)
-{
-	u32 num_bytes = nvme_auth_key_struct_size(len);
-	struct nvme_dhchap_key *key = kzalloc(num_bytes, GFP_KERNEL);
-
-	if (key) {
-		key->len = len;
-		key->hash = hash;
-	}
-	return key;
-}
-EXPORT_SYMBOL_GPL(nvme_auth_alloc_key);
-
-void nvme_auth_free_key(struct nvme_dhchap_key *key)
-{
-	if (!key)
-		return;
-	kfree_sensitive(key);
-}
-EXPORT_SYMBOL_GPL(nvme_auth_free_key);
-
 /*
  * Start computing an HMAC value, given the algorithm ID and raw key.
  *
@@ -317,12 +260,13 @@ static int nvme_auth_hash(u8 hmac_id, const u8 *data, size_t data_len, u8 *out)
 	return -EINVAL;
 }
 
-int nvme_auth_transform_key(const struct nvme_dhchap_key *key, const char *nqn,
+int nvme_auth_transform_key(struct key *key, const char *nqn,
 			    u8 **transformed_secret)
 {
 	struct nvme_auth_hmac_ctx hmac;
+	long key_len = 0;
 	u8 *transformed_data;
-	u8 *key_data;
+	u8 *key_data, key_hash;
 	size_t transformed_len;
 	int ret;
 
@@ -330,24 +274,64 @@ int nvme_auth_transform_key(const struct nvme_dhchap_key *key, const char *nqn,
 		pr_warn("No key specified\n");
 		return -ENOKEY;
 	}
-	if (key->hash == 0) {
-		key_data = kzalloc(key->len, GFP_KERNEL);
-		memcpy(key_data, key->key, key->len);
+	down_read(&key->sem);
+	ret = key_validate(key);
+	if (ret) {
+		pr_warn("%s: key %08x invalidated\n",
+			__func__, key_serial(key));
+		up_read(&key->sem);
+		return ret;
+	}
+	key_len = user_read(key, NULL, 0);
+	if (key_len <= 0) {
+		pr_warn("failed to get length from key %08x: error %ld\n",
+			key_serial(key), key_len);
+		up_read(&key->sem);
+		return key_len;
+	}
+
+	key_data = kzalloc(key_len, GFP_KERNEL);
+	if (!key_data) {
+		up_read(&key->sem);
+		return -ENOMEM;
+	}
+	ret = user_read(key, key_data, key_len);
+	key_hash = nvme_dhchap_psk_hash(key);
+	up_read(&key->sem);
+	if (ret != key_len) {
+		if (ret < 0) {
+			pr_warn("failed to read from key %08x: error %d\n",
+				key_serial(key), ret);
+		} else {
+			pr_warn("only read %d of %ld bytes from key %08x\n",
+				ret, key_len, key_serial(key));
+			ret = -ENOKEY;
+		}
+		goto out_free_data;
+	}
+	if (key_hash == 0) {
 		*transformed_secret = key_data;
-		return key->len;
+		return key_len;
 	}
-	ret = nvme_auth_hmac_init(&hmac, key->hash, key->key, key->len);
+
+	ret = nvme_auth_hmac_init(&hmac, key_hash, key_data, key_len);
 	if (ret)
-		return ret;
-	transformed_len = nvme_auth_hmac_hash_len(key->hash);
-	key_data = kzalloc(transformed_len, GFP_KERNEL);
-	if (!key_data)
-		return -ENOMEM;
+		goto out_free_data;
+	transformed_len = nvme_auth_hmac_hash_len(key_hash);
+	transformed_data = kzalloc(transformed_len, GFP_KERNEL);
+	if (!transformed_data) {
+		ret = -ENOMEM;
+		goto out_free_data;
+	}
+
 	nvme_auth_hmac_update(&hmac, nqn, strlen(nqn));
 	nvme_auth_hmac_update(&hmac, "NVMe-over-Fabrics", 17);
-	nvme_auth_hmac_final(&hmac, key_data);
-	*transformed_secret = key_data;
-	return transformed_len;
+	nvme_auth_hmac_final(&hmac, transformed_data);
+	*transformed_secret = transformed_data;
+	ret = transformed_len;
+out_free_data:
+	kfree_sensitive(key_data);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_transform_key);
 
@@ -431,31 +415,6 @@ int nvme_auth_gen_shared_secret(struct crypto_kpp *dh_tfm,
 }
 EXPORT_SYMBOL_GPL(nvme_auth_gen_shared_secret);
 
-int nvme_auth_parse_key(const char *secret, struct nvme_dhchap_key **ret_key)
-{
-	struct nvme_dhchap_key *key;
-	u8 key_hash;
-
-	if (!secret) {
-		*ret_key = NULL;
-		return 0;
-	}
-
-	if (sscanf(secret, "DHHC-1:%hhd:%*s:", &key_hash) != 1)
-		return -EINVAL;
-
-	/* Pass in the secret without the 'DHHC-1:XX:' prefix */
-	key = nvme_auth_extract_key(secret + 10, key_hash);
-	if (IS_ERR(key)) {
-		*ret_key = NULL;
-		return PTR_ERR(key);
-	}
-
-	*ret_key = key;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(nvme_auth_parse_key);
-
 /**
  * nvme_auth_generate_psk - Generate a PSK for TLS
  * @hmac_id: Hash function identifier
diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index f7e18df438e6..da99e5a6f301 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -461,6 +461,104 @@ static struct key_type nvme_dhchap_psk_key_type = {
 	.read           = nvme_dhchap_psk_read,
 };
 
+/**
+ * nvme_dhchap_psk_create - Create DH-HMAC-CHAP key
+ * @keyring: keyring for the new key or NULL for the default keyring
+ * @data: Key data
+ * @data_len: Length of @data
+ *
+ * Creates a new DH-HMAC-CHAP key with a random UUID as the key identity.
+ * Returns the new key or an error pointer on failure.
+ */
+struct key *nvme_dhchap_psk_create(struct key *keyring,
+		const u8 *data, size_t data_len)
+{
+	key_perm_t keyperm =
+		KEY_POS_SEARCH | KEY_POS_VIEW | KEY_POS_READ |
+		KEY_POS_WRITE | KEY_POS_LINK | KEY_POS_SETATTR |
+		KEY_USR_SEARCH | KEY_USR_VIEW | KEY_USR_READ;
+	char *identity;
+	key_ref_t keyref;
+	key_serial_t keyring_id;
+	struct key *key;
+	uuid_t key_uuid;
+
+	if (data == NULL || !data_len)
+		return ERR_PTR(-EINVAL);
+
+	generate_random_uuid(key_uuid.b);
+	identity = kasprintf(GFP_KERNEL, "%pU", &key_uuid);
+	if (!identity)
+		return ERR_PTR(-ENOMEM);
+	if (!keyring)
+		keyring = nvme_keyring;
+	keyring_id = key_serial(keyring);
+
+	pr_debug("keyring %x generate dhchap psk '%s'\n",
+		 keyring_id, identity);
+	keyref = key_create(make_key_ref(keyring, true),
+			    "dhchap", identity, data, data_len,
+			    keyperm, KEY_ALLOC_NOT_IN_QUOTA |
+			    KEY_ALLOC_BUILT_IN |
+			    KEY_ALLOC_BYPASS_RESTRICTION);
+	if (IS_ERR(keyref)) {
+		pr_warn("refresh dhchap psk '%s' failed, error %ld\n",
+			identity, PTR_ERR(keyref));
+		kfree(identity);
+		return ERR_PTR(-ENOKEY);
+	}
+	key = key_ref_to_ptr(keyref);
+	pr_debug("generated dhchap psk %08x\n", key_serial(key));
+	kfree(identity);
+	return key;
+}
+EXPORT_SYMBOL_GPL(nvme_dhchap_psk_create);
+
+/**
+ * nvme_dhchap_psk_lookup - Lookup DH-HMAC-CHAP key
+ * @keyring: keyring to use or NULL for default keyring
+ * @identity: key identity to search
+ *
+ * Looks up a key with identity @identity from keyring @keyring.
+ * Returns the key or an error pointer if not found.
+ */
+struct key *nvme_dhchap_psk_lookup(struct key *keyring, const char *identity)
+{
+	key_ref_t keyref;
+	key_serial_t keyring_id;
+
+	if (!keyring)
+		keyring = nvme_keyring;
+	keyring_id = key_serial(keyring);
+	pr_debug("keyring %x lookup dhchap psk '%s'\n",
+		 keyring_id, identity);
+
+	keyref = keyring_search(make_key_ref(keyring, true),
+				&nvme_dhchap_psk_key_type,
+				identity, false);
+	if (IS_ERR(keyref)) {
+		pr_debug("lookup dhchap psk '%s' failed, error %ld\n",
+			 identity, PTR_ERR(keyref));
+		return ERR_PTR(-ENOKEY);
+	}
+
+	return key_ref_to_ptr(keyref);
+}
+EXPORT_SYMBOL_GPL(nvme_dhchap_psk_lookup);
+
+u8 nvme_dhchap_psk_hash(struct key *key)
+{
+	const struct user_key_payload *upayload;
+	u8 hmac;
+
+	if (!key)
+		return 0;
+	upayload = user_key_payload_locked(key);
+	hmac = upayload->data[upayload->datalen + 5];
+	return hmac;
+}
+EXPORT_SYMBOL_GPL(nvme_dhchap_psk_hash);
+
 static int __init nvme_keyring_init(void)
 {
 	int err;
diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 31974c7dd20c..6d350ef617bf 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -115,7 +115,6 @@ config NVME_HOST_AUTH
 	bool "NVMe over Fabrics In-Band Authentication in host side"
 	depends on NVME_CORE
 	select NVME_AUTH
-	select NVME_KEYRING
 	help
 	  This provides support for NVMe over Fabrics In-Band Authentication in
 	  host side.
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 2065b3301326..e7c0ed55e2ba 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -1021,13 +1021,23 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
 	if (!ctrl->opts)
 		return 0;
-	ret = nvme_auth_parse_key(ctrl->opts->dhchap_secret, &ctrl->host_key);
-	if (ret)
+	ctrl->host_key = nvme_auth_extract_key(ctrl->opts->keyring,
+				ctrl->opts->dhchap_secret,
+				strlen(ctrl->opts->dhchap_secret));
+	if (IS_ERR(ctrl->host_key)) {
+		ret = PTR_ERR(ctrl->host_key);
+		ctrl->host_key = NULL;
 		return ret;
-	ret = nvme_auth_parse_key(ctrl->opts->dhchap_ctrl_secret,
-				  &ctrl->ctrl_key);
-	if (ret)
+	}
+
+	ctrl->ctrl_key = nvme_auth_extract_key(ctrl->opts->keyring,
+				ctrl->opts->dhchap_ctrl_secret,
+				strlen(ctrl->opts->dhchap_ctrl_secret));
+	if (IS_ERR(ctrl->ctrl_key)) {
+		ret = PTR_ERR(ctrl->ctrl_key);
+		ctrl->ctrl_key = NULL;
 		goto err_free_dhchap_secret;
+	}
 
 	if (!ctrl->opts->dhchap_secret && !ctrl->opts->dhchap_ctrl_secret)
 		return 0;
@@ -1048,10 +1058,10 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 
 	return 0;
 err_free_dhchap_ctrl_secret:
-	nvme_auth_free_key(ctrl->ctrl_key);
+	key_put(ctrl->ctrl_key);
 	ctrl->ctrl_key = NULL;
 err_free_dhchap_secret:
-	nvme_auth_free_key(ctrl->host_key);
+	key_put(ctrl->host_key);
 	ctrl->host_key = NULL;
 	return ret;
 }
@@ -1073,11 +1083,11 @@ void nvme_auth_free(struct nvme_ctrl *ctrl)
 		kvfree(ctrl->dhchap_ctxs);
 	}
 	if (ctrl->host_key) {
-		nvme_auth_free_key(ctrl->host_key);
+		key_put(ctrl->host_key);
 		ctrl->host_key = NULL;
 	}
 	if (ctrl->ctrl_key) {
-		nvme_auth_free_key(ctrl->ctrl_key);
+		key_put(ctrl->ctrl_key);
 		ctrl->ctrl_key = NULL;
 	}
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 4a08ae4eca14..d16495e177cf 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -378,8 +378,8 @@ struct nvme_ctrl {
 	struct work_struct dhchap_auth_work;
 	struct mutex dhchap_auth_mutex;
 	struct nvme_dhchap_queue_context *dhchap_ctxs;
-	struct nvme_dhchap_key *host_key;
-	struct nvme_dhchap_key *ctrl_key;
+	struct key *host_key;
+	struct key *ctrl_key;
 	u16 transaction;
 #endif
 	key_serial_t tls_pskid;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 94d11a68e316..f0b8156725e9 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -624,8 +624,6 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 		return -EINVAL;
 	if (count < 7)
 		return -EINVAL;
-	if (memcmp(buf, "DHHC-1:", 7))
-		return -EINVAL;
 
 	dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
 	if (!dhchap_secret)
@@ -633,13 +631,13 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	memcpy(dhchap_secret, buf, count);
 	nvme_auth_stop(ctrl);
 	if (strcmp(dhchap_secret, opts->dhchap_secret)) {
-		struct nvme_dhchap_key *key, *host_key;
-		int ret;
+		struct key *key, *host_key;
 
-		ret = nvme_auth_parse_key(dhchap_secret, &key);
-		if (ret) {
+		key = nvme_auth_extract_key(opts->keyring, dhchap_secret,
+					    count);
+		if (IS_ERR(key)) {
 			kfree(dhchap_secret);
-			return ret;
+			return PTR_ERR(key);
 		}
 		kfree(opts->dhchap_secret);
 		opts->dhchap_secret = dhchap_secret;
@@ -647,7 +645,7 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 		mutex_lock(&ctrl->dhchap_auth_mutex);
 		ctrl->host_key = key;
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		nvme_auth_free_key(host_key);
+		key_put(host_key);
 	} else
 		kfree(dhchap_secret);
 	/* Start re-authentication */
@@ -691,13 +689,13 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 	memcpy(dhchap_secret, buf, count);
 	nvme_auth_stop(ctrl);
 	if (strcmp(dhchap_secret, opts->dhchap_ctrl_secret)) {
-		struct nvme_dhchap_key *key, *ctrl_key;
-		int ret;
+		struct key *key, *ctrl_key;
 
-		ret = nvme_auth_parse_key(dhchap_secret, &key);
-		if (ret) {
+		key = nvme_auth_extract_key(opts->keyring, dhchap_secret,
+					    count);
+		if (IS_ERR(key)) {
 			kfree(dhchap_secret);
-			return ret;
+			return PTR_ERR(key);
 		}
 		kfree(opts->dhchap_ctrl_secret);
 		opts->dhchap_ctrl_secret = dhchap_secret;
@@ -705,7 +703,7 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 		mutex_lock(&ctrl->dhchap_auth_mutex);
 		ctrl->ctrl_key = key;
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		nvme_auth_free_key(ctrl_key);
+		key_put(ctrl_key);
 	} else
 		kfree(dhchap_secret);
 	/* Start re-authentication */
diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 4904097dfd49..3edb089a89e8 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -5,7 +5,6 @@ config NVME_TARGET
 	depends on BLOCK
 	select CONFIGFS_FS
 	select NVME_KEYRING if NVME_TARGET_TCP_TLS
-	select KEYS if NVME_TARGET_TCP_TLS
 	select SGL_ALLOC
 	help
 	  This enabled target side support for the NVMe protocol, that is
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index baf4c8223fd5..3cb829df964c 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -135,6 +135,7 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
 	int ret = 0;
 	struct nvmet_host_link *p;
 	struct nvmet_host *host = NULL;
+	u8 host_hash, ctrl_hash;
 
 	down_read(&nvmet_config_sem);
 	if (nvmet_is_disc_subsys(ctrl->subsys))
@@ -180,42 +181,43 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
 		ctrl->shash_id = host->dhchap_hash_id;
 	}
 
-	/* Skip the 'DHHC-1:XX:' prefix */
-	nvme_auth_free_key(ctrl->host_key);
-	ctrl->host_key = nvme_auth_extract_key(host->dhchap_secret + 10,
-					       host->dhchap_key_hash);
+	key_put(ctrl->host_key);
+	ctrl->host_key = nvme_auth_extract_key(NULL, host->dhchap_secret,
+					       strlen(host->dhchap_secret));
 	if (IS_ERR(ctrl->host_key)) {
 		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
 		ctrl->host_key = NULL;
 		goto out_free_hash;
 	}
-	pr_debug("%s: using hash %s key %*ph\n", __func__,
-		 ctrl->host_key->hash > 0 ?
-		 nvme_auth_hmac_name(ctrl->host_key->hash) : "none",
-		 (int)ctrl->host_key->len, ctrl->host_key->key);
+	host_hash = nvme_dhchap_psk_hash(ctrl->host_key);
+	pr_debug("%s: using hash %s key %u\n", __func__,
+		 ctrl_hash > 0 ?
+		 nvme_auth_hmac_name(ctrl_hash) : "none",
+		 key_serial(ctrl->host_key));
 
-	nvme_auth_free_key(ctrl->ctrl_key);
+	key_put(ctrl->ctrl_key);
 	if (!host->dhchap_ctrl_secret) {
 		ctrl->ctrl_key = NULL;
 		goto out_unlock;
 	}
 
-	ctrl->ctrl_key = nvme_auth_extract_key(host->dhchap_ctrl_secret + 10,
-					       host->dhchap_ctrl_key_hash);
+	ctrl->ctrl_key = nvme_auth_extract_key(NULL, host->dhchap_ctrl_secret,
+					       strlen(host->dhchap_ctrl_secret));
 	if (IS_ERR(ctrl->ctrl_key)) {
 		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
 		ctrl->ctrl_key = NULL;
 		goto out_free_hash;
 	}
-	pr_debug("%s: using ctrl hash %s key %*ph\n", __func__,
-		 ctrl->ctrl_key->hash > 0 ?
-		 nvme_auth_hmac_name(ctrl->ctrl_key->hash) : "none",
-		 (int)ctrl->ctrl_key->len, ctrl->ctrl_key->key);
+	ctrl_hash = nvme_dhchap_psk_hash(ctrl->ctrl_key);
+	pr_debug("%s: using ctrl hash %s key %u\n", __func__,
+		 ctrl_hash > 0 ?
+		 nvme_auth_hmac_name(ctrl_hash) : "none",
+		 key_serial(ctrl->ctrl_key));
 
 out_free_hash:
 	if (ret) {
 		if (ctrl->host_key) {
-			nvme_auth_free_key(ctrl->host_key);
+			key_put(ctrl->host_key);
 			ctrl->host_key = NULL;
 		}
 		ctrl->shash_id = 0;
@@ -253,11 +255,13 @@ void nvmet_destroy_auth(struct nvmet_ctrl *ctrl)
 	ctrl->dh_key = NULL;
 
 	if (ctrl->host_key) {
-		nvme_auth_free_key(ctrl->host_key);
+		key_revoke(ctrl->host_key);
+		key_put(ctrl->host_key);
 		ctrl->host_key = NULL;
 	}
 	if (ctrl->ctrl_key) {
-		nvme_auth_free_key(ctrl->ctrl_key);
+		key_revoke(ctrl->ctrl_key);
+		key_put(ctrl->ctrl_key);
 		ctrl->ctrl_key = NULL;
 	}
 #ifdef CONFIG_NVME_TARGET_TCP_TLS
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 5db8f0d6e3f2..f9f281060ac1 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -298,8 +298,8 @@ struct nvmet_ctrl {
 	bool			pi_support;
 	bool			concat;
 #ifdef CONFIG_NVME_TARGET_AUTH
-	struct nvme_dhchap_key	*host_key;
-	struct nvme_dhchap_key	*ctrl_key;
+	struct key		*host_key;
+	struct key		*ctrl_key;
 	u8			shash_id;
 	struct crypto_kpp	*dh_tfm;
 	u8			dh_gid;
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index 37cc8abaf06d..9dc7f520c4bd 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -9,12 +9,6 @@
 #include <crypto/kpp.h>
 #include <crypto/sha2.h>
 
-struct nvme_dhchap_key {
-	size_t len;
-	u8 hash;
-	u8 key[];
-};
-
 u32 nvme_auth_get_seqnum(void);
 const char *nvme_auth_dhgroup_name(u8 dhgroup_id);
 const char *nvme_auth_dhgroup_kpp(u8 dhgroup_id);
@@ -37,13 +31,10 @@ void nvme_auth_hmac_update(struct nvme_auth_hmac_ctx *hmac, const u8 *data,
 			   size_t data_len);
 void nvme_auth_hmac_final(struct nvme_auth_hmac_ctx *hmac, u8 *out);
 
-u32 nvme_auth_key_struct_size(u32 key_len);
-struct nvme_dhchap_key *nvme_auth_extract_key(const char *secret, u8 key_hash);
-void nvme_auth_free_key(struct nvme_dhchap_key *key);
-struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash);
-int nvme_auth_transform_key(const struct nvme_dhchap_key *key,
-			    const char *nqn, u8 **transformed_secret);
-int nvme_auth_parse_key(const char *secret, struct nvme_dhchap_key **ret_key);
+struct key *nvme_auth_extract_key(struct key *keyring, const char *secret,
+				  size_t secret_len);
+int nvme_auth_transform_key(struct key *key, const char *nqn,
+			    u8 **transformed_secret);
 int nvme_auth_augmented_challenge(u8 hmac_id, const u8 *skey, size_t skey_len,
 				  const u8 *challenge, u8 *aug, size_t hlen);
 int nvme_auth_gen_privkey(struct crypto_kpp *dh_tfm, u8 dh_gid);
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index ab8971afa973..9715022c92b3 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -18,9 +18,14 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
 
 key_serial_t nvme_keyring_id(void);
 struct key *nvme_tls_key_lookup(key_serial_t key_id);
+
+struct key *nvme_dhchap_psk_create(struct key *keyring,
+		const u8 *data, size_t data_len);
+struct key *nvme_dhchap_psk_lookup(struct key *keyring, const char *identity);
+u8 nvme_dhchap_psk_hash(struct key *key);
+
 #else
 static inline struct key *nvme_tls_psk_refresh(struct key *keyring,
-		const char *hostnqn, char *subnqn, u8 hmac_id,
 		u8 *data, size_t data_len, const char *digest)
 {
 	return ERR_PTR(-ENOTSUPP);
@@ -38,5 +43,20 @@ static inline struct key *nvme_tls_key_lookup(key_serial_t key_id)
 {
 	return ERR_PTR(-ENOTSUPP);
 }
+static inline struct key *nvme_dhchap_psk_refresh(struct key *keyring,
+		const char *hostnqn, const char *subnqn,
+		u8 *data, size_t data_len)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+static inline struct key *nvme_dhchap_psk_lookup(struct key *keyring,
+		const char *hostnqn, const char *subnqn, u8 hmac);
+{
+	return ERR_PTR(-ENOTSUPP);
+}
+u8 nvme_dhchap_psk_hash(struct key *key)
+{
+	return 0;
+}
 #endif /* !CONFIG_NVME_KEYRING */
 #endif /* _NVME_KEYRING_H */
-- 
2.43.0


