Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1027E606A33A
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 12:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wvzF+XX7;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PCBJvvHE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=H1VX15X7s6gnlyzP+X7RQzUIJ1M0gCd2SzmjPfgOdKM=; b=wvzF+XX7Koymxi
	GZQtI0a7VEpGvsuvDRgqGBvHIYkqJFLM8wwy9MfH++ppeiDAqV+v+UiWOxRd+pBZ2ZHpuZ9liEooY
	/WRKmz/yIY+fxayrNDH7SwxDbTRuhBn+IrS332WtpEiH/hhQyU626xALLoXOA+zmOJhFt2n6Y5bsn
	vmZSJBIYuzA/L2d7TV6VUYiFsUJUxtv66KG5bv4mCHOEzK1MLN7FSsG+EPNtrp2SJpyIlGyuLjQAt
	t37Wpn1B1XBB2ZWKm0czDhExFCOEOAKYgbSyjdIyyqUB7fZ8Ue9HGzY1cYcsC8b8jbJjk+c1bFgLM
	2Byn+Y89CwrSUwaytdDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVSwt-00000003JMF-2l71;
	Mon, 23 Nov 2026 12:15:07 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVSws-00000003JLc-1ZWh
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 12:15:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E98E9419B5;
	Mon, 23 Nov 2026 12:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1EA1F000CA;
	Mon, 23 Nov 2026 12:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795436105;
	bh=H1VX15X7s6gnlyzP+X7RQzUIJ1M0gCd2SzmjPfgOdKM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PCBJvvHElJRzDsNQM6R40iysgA2SiE20uSvCDrwYyS+b4aZsGxxup4QWwOqOKaf5c
	 IG4OP5ok/Z280+anuJJplci7nLpz+gt5rFsOE6wETqHIzrDMf5Z+ckExtNaMp9nKTF
	 jxBp8sTwFfWxZMY4tD01WVdPZWnqijTqRSKjkWpeJ9j4BDOXc/iiDvCLFvrWgLQr9L
	 UDwuyrLykcCXPUly3/QRklGSECEXI5ozRXEP1XH3REoIMD0c6fTr+1d7c/LHcB3sZo
	 8pybMuX0YHg/ABbHZngAqxkJKnYn2V5qHekumL3Oq5Bk0vwQ1hbbxHRe/VsKyg/yST
	 t2ILWztLDrL6g==
From: Hannes Reinecke <hare@kernel.org>
Date: Mon, 23 Nov 2026 13:14:48 +0100
Subject: [PATCH v5 3/9] nvme-auth: switch to use 'struct key'
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-dhchap-keyring-v4-v5-3-81eefb4c0724@kernel.org>
References: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
In-Reply-To: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795436094; l=26103;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=CyRrNtEscPLOXrd/TRbrcZTLBrUV04h3gtBDhNve5+w=;
 b=Oy0d000V9DbAWuij3AXk/XHlkxHuVMrHhbe1EJBrwJZjy62wVvoC+MhZuNbp5edU3klohTgK/
 2tsQ0nwPb4QCNwj1KD8oh0sRZs0zIv5qRgX9adaL8CEmrWcpwPL8DgE
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

Use the new key type 'dhchap' to store the DH-HMAC-CHAP keys and modify
handling function to use 'struct key'. With that we can drop the now
unused 'struct nvme_dhchap_key' definitions.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/Kconfig    |   1 +
 drivers/nvme/common/auth.c     | 197 ++++++++++++++++-------------------------
 drivers/nvme/common/keyring.c  |  98 ++++++++++++++++++++
 drivers/nvme/host/Kconfig      |   1 -
 drivers/nvme/host/auth.c       |  28 ++++--
 drivers/nvme/host/nvme.h       |   4 +-
 drivers/nvme/host/sysfs.c      |  26 +++---
 drivers/nvme/target/Kconfig    |   1 -
 drivers/nvme/target/auth.c     |  52 +++++------
 drivers/nvme/target/configfs.c |   4 +-
 drivers/nvme/target/nvmet.h    |   8 +-
 include/linux/nvme-auth.h      |  17 +---
 include/linux/nvme-keyring.h   |  26 +++++-
 13 files changed, 268 insertions(+), 195 deletions(-)

diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
index f1639db65fd38abde01832a7404cbc48cf49a93e..9f72c2668f2f6b71f20d737f9849f1bb9cd88dc6 100644
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
index 308af3d7c7383acbfb327921c8a650898f0e15ea..ee26fb416ee6281ca9b101a5b00847736fd75b98 100644
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
@@ -138,89 +140,31 @@ size_t nvme_auth_hmac_hash_len(u8 hmac_id)
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
+ * @keyring: keyring to be used for the resulting key
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
@@ -317,11 +261,13 @@ static int nvme_auth_hash(u8 hmac_id, const u8 *data, size_t data_len, u8 *out)
 	return -EINVAL;
 }
 
-int nvme_auth_transform_key(const struct nvme_dhchap_key *key, const char *nqn,
+int nvme_auth_transform_key(struct key *key, const char *nqn,
 			    u8 **transformed_secret)
 {
 	struct nvme_auth_hmac_ctx hmac;
-	u8 *key_data;
+	long key_len = 0;
+	u8 *transformed_data;
+	u8 *key_data, key_hash;
 	size_t transformed_len;
 	int ret;
 
@@ -329,28 +275,64 @@ int nvme_auth_transform_key(const struct nvme_dhchap_key *key, const char *nqn,
 		pr_warn("No key specified\n");
 		return -ENOKEY;
 	}
-	if (key->hash == 0) {
-		key_data = kzalloc(key->len, GFP_KERNEL);
-		if (!key_data)
-			return -ENOMEM;
-		memcpy(key_data, key->key, key->len);
-		*transformed_secret = key_data;
-		return key->len;
-	}
-	ret = nvme_auth_hmac_init(&hmac, key->hash, key->key, key->len);
-	if (ret)
+	down_read(&key->sem);
+	ret = key_validate(key);
+	if (ret) {
+		pr_warn("%s: key %08x invalidated\n",
+			__func__, key_serial(key));
+		up_read(&key->sem);
 		return ret;
-	transformed_len = nvme_auth_hmac_hash_len(key->hash);
-	key_data = kzalloc(transformed_len, GFP_KERNEL);
+	}
+	key_len = user_read(key, NULL, 0);
+	if (key_len <= 0) {
+		pr_warn("failed to get length from key %08x: error %ld\n",
+			key_serial(key), key_len);
+		up_read(&key->sem);
+		return key_len < 0 ? key_len : -ENOKEY;
+	}
+
+	key_data = kzalloc(key_len, GFP_KERNEL);
 	if (!key_data) {
-		memzero_explicit(&hmac, sizeof(hmac));
+		up_read(&key->sem);
 		return -ENOMEM;
 	}
+	ret = user_read(key, (char *)key_data, key_len);
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
+		*transformed_secret = key_data;
+		return key_len;
+	}
+
+	ret = nvme_auth_hmac_init(&hmac, key_hash, key_data, key_len);
+	if (ret)
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
 
@@ -488,33 +470,6 @@ int nvme_auth_gen_session_key(struct crypto_kpp *dh_tfm,
 }
 EXPORT_SYMBOL_GPL(nvme_auth_gen_session_key);
 
-int nvme_auth_parse_key(const char *secret, struct nvme_dhchap_key **ret_key)
-{
-	struct nvme_dhchap_key *key;
-	u8 key_hash;
-	int offset = 0;
-
-	if (!secret) {
-		*ret_key = NULL;
-		return 0;
-	}
-
-	if (sscanf(secret, "DHHC-1:%hhd:%n", &key_hash, &offset) != 1 ||
-	    !offset)
-		return -EINVAL;
-
-	/* Pass in the secret without the 'DHHC-1:XX:' prefix */
-	key = nvme_auth_extract_key(secret + offset, key_hash);
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
index d0c36d153afdb39ae698cf86cefe53f82af34907..08e2a8e39faac92a076f39e11f053ef330a44f07 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -481,6 +481,104 @@ static struct key_type nvme_dhchap_psk_key_type = {
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
+		const char *data, size_t data_len)
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
index 31974c7dd20c9174961eac91e3823e939d325daa..6d350ef617bfb47770ebce48c3abb25a4b6a4c8c 100644
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
index 295e0a9533c8995c32781324650d73b6bfedbf13..0ddf3834f4ea2bfedaf08b901db282b79df32879 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -1038,13 +1038,23 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
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
@@ -1065,10 +1075,10 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 
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
@@ -1090,11 +1100,11 @@ void nvme_auth_free(struct nvme_ctrl *ctrl)
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
index 2543e52d6358a635623fab925167bea7ac4a24a2..434e3612c996a969075aa5844c51906c605e6f56 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -461,8 +461,8 @@ struct nvme_ctrl {
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
index 35f871e3e0c0ae49b390f0fb64c538796207a98f..a5c1511e49ac275e75a70ff89958ed8f0cb2c633 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -836,8 +836,6 @@ static ssize_t dhchap_secret_store(struct device *dev,
 		return -EINVAL;
 	if (count < 7)
 		return -EINVAL;
-	if (memcmp(buf, "DHHC-1:", 7))
-		return -EINVAL;
 
 	dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
 	if (!dhchap_secret)
@@ -845,13 +843,13 @@ static ssize_t dhchap_secret_store(struct device *dev,
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
 			kfree_sensitive(dhchap_secret);
-			return ret;
+			return PTR_ERR(key);
 		}
 		kfree_sensitive(opts->dhchap_secret);
 		opts->dhchap_secret = dhchap_secret;
@@ -859,7 +857,7 @@ static ssize_t dhchap_secret_store(struct device *dev,
 		mutex_lock(&ctrl->dhchap_auth_mutex);
 		ctrl->host_key = key;
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		nvme_auth_free_key(host_key);
+		key_put(host_key);
 	} else
 		kfree_sensitive(dhchap_secret);
 	/* Start re-authentication */
@@ -902,13 +900,13 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
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
 			kfree_sensitive(dhchap_secret);
-			return ret;
+			return PTR_ERR(key);
 		}
 		kfree_sensitive(opts->dhchap_ctrl_secret);
 		opts->dhchap_ctrl_secret = dhchap_secret;
@@ -916,7 +914,7 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 		mutex_lock(&ctrl->dhchap_auth_mutex);
 		ctrl->ctrl_key = key;
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		nvme_auth_free_key(ctrl_key);
+		key_put(ctrl_key);
 	} else
 		kfree_sensitive(dhchap_secret);
 	/* Start re-authentication */
diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 69bde270115e29bc8c89f4f58791190932dbe852..700e87d9e610e2532a871ad8af90573a1931c30b 100644
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
index 150818d7009d8c2fca96e12fd54fdc1cb6b68882..26457ce4acc2a8664ec9c2a9ed6d66fed93b61fa 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -150,7 +150,10 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
 	int ret = 0;
 	struct nvmet_host_link *p;
 	struct nvmet_host *host = NULL;
-	struct nvme_dhchap_key *host_key, *ctrl_key = NULL;
+	struct key *host_key, *ctrl_key = NULL;
+#ifdef CONFIG_NVME_TARGET_AUTH_DEBUG
+	u8 host_hash, ctrl_hash;
+#endif
 
 	down_read(&nvmet_config_sem);
 	if (nvmet_is_disc_subsys(ctrl->subsys))
@@ -188,42 +191,39 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
 		goto out_unlock;
 	}
 
-	/*
-	 * Skip the 'DHHC-1:XX:' prefix. Keep the old keys until the new ones
-	 * are there: a controller without a host key needs no authentication.
-	 */
-	host_key = nvme_auth_extract_key(host->dhchap_secret +
-					 host->dhchap_key_offset,
-					 host->dhchap_key_hash);
+	host_key = nvme_auth_extract_key(NULL, host->dhchap_secret,
+					 strlen(host->dhchap_secret));
 	if (IS_ERR(host_key)) {
 		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
 		goto out_unlock;
 	}
 	if (host->dhchap_ctrl_secret) {
-		ctrl_key = nvme_auth_extract_key(host->dhchap_ctrl_secret +
-						 host->dhchap_ctrl_key_offset,
-						 host->dhchap_ctrl_key_hash);
+		ctrl_key = nvme_auth_extract_key(NULL, host->dhchap_ctrl_secret,
+						 strlen(host->dhchap_ctrl_secret));
 		if (IS_ERR(ctrl_key)) {
-			nvme_auth_free_key(host_key);
+			key_put(host_key);
 			ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
 			goto out_unlock;
 		}
 	}
-	nvme_auth_free_key(ctrl->host_key);
+	key_put(ctrl->host_key);
 	ctrl->host_key = host_key;
-	nvme_auth_free_key(ctrl->ctrl_key);
+	key_put(ctrl->ctrl_key);
 	ctrl->ctrl_key = ctrl_key;
 	ctrl->shash_id = host->dhchap_hash_id;
 #ifdef CONFIG_NVME_TARGET_AUTH_DEBUG
-	pr_debug("%s: using hash %s key %*ph\n", __func__,
-		 ctrl->host_key->hash > 0 ?
-		 nvme_auth_hmac_name(ctrl->host_key->hash) : "none",
-		 (int)ctrl->host_key->len, ctrl->host_key->key);
-	if (ctrl->ctrl_key)
-		pr_debug("%s: using ctrl hash %s key %*ph\n", __func__,
-			 ctrl->ctrl_key->hash > 0 ?
-			 nvme_auth_hmac_name(ctrl->ctrl_key->hash) : "none",
-			 (int)ctrl->ctrl_key->len, ctrl->ctrl_key->key);
+	host_hash = nvme_dhchap_psk_hash(ctrl->host_key);
+	pr_debug("%s: using hash %s key %u\n", __func__,
+		 ctrl_hash > 0 ?
+		 nvme_auth_hmac_name(ctrl_hash) : "none",
+		 key_serial(ctrl->host_key));
+	if (ctrl->ctrl_key) {
+		ctrl_hash = nvme_dhchap_psk_hash(ctrl->ctrl_key);
+		pr_debug("%s: using ctrl hash %s key %u\n", __func__,
+			 ctrl_hash > 0 ?
+			 nvme_auth_hmac_name(ctrl_hash) : "none",
+			 key_serial(ctrl->ctrl_key));
+	}
 #endif
 out_unlock:
 	up_read(&nvmet_config_sem);
@@ -263,11 +263,13 @@ void nvmet_destroy_auth(struct nvmet_ctrl *ctrl)
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
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 27c50fa533e70e443a2eb3fed5e31e730fb0ce3c..ff3a8d74de59966952a3991542077feebae10770 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -2234,7 +2234,7 @@ static struct config_group nvmet_ports_group;
 static ssize_t nvmet_host_dhchap_key_show(struct config_item *item,
 		char *page)
 {
-	u8 *dhchap_secret;
+	char *dhchap_secret;
 	ssize_t ret;
 
 	down_read(&nvmet_config_sem);
@@ -2267,7 +2267,7 @@ CONFIGFS_ATTR(nvmet_host_, dhchap_key);
 static ssize_t nvmet_host_dhchap_ctrl_key_show(struct config_item *item,
 		char *page)
 {
-	u8 *dhchap_secret = to_host(item)->dhchap_ctrl_secret;
+	char *dhchap_secret = to_host(item)->dhchap_ctrl_secret;
 	ssize_t ret;
 
 	down_read(&nvmet_config_sem);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e33884a81efc9f96cdc5d0120e0701f06ce7d873..1dfdac159dab044566aac47862665784feddec0a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -309,8 +309,8 @@ struct nvmet_ctrl {
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
@@ -399,8 +399,8 @@ static inline struct nvmet_subsys *namespaces_to_subsys(
 
 struct nvmet_host {
 	struct config_group	group;
-	u8			*dhchap_secret;
-	u8			*dhchap_ctrl_secret;
+	char			*dhchap_secret;
+	char			*dhchap_ctrl_secret;
 	int			dhchap_key_offset;
 	int			dhchap_ctrl_key_offset;
 	u8			dhchap_key_hash;
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index 1c5ce635b169dd0747c1344e9adcc14839776cd1..75e1e75e298e1c3b408ea234705edd7abf788d1d 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -9,12 +9,6 @@
 #include <crypto/kpp.h>
 #include <crypto/sha2.h>
 
-struct nvme_dhchap_key {
-	size_t len;
-	u8 hash;
-	u8 key[] __counted_by(len);
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
index ab8971afa9734a276d9197076b780321460dddc2..a2ba7588e2d736c405b7c15666a85e500783a91c 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -18,12 +18,18 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
 
 key_serial_t nvme_keyring_id(void);
 struct key *nvme_tls_key_lookup(key_serial_t key_id);
+
+struct key *nvme_dhchap_psk_create(struct key *keyring,
+		const char *data, size_t data_len);
+struct key *nvme_dhchap_psk_lookup(struct key *keyring, const char *identity);
+u8 nvme_dhchap_psk_hash(struct key *key);
+
 #else
 static inline struct key *nvme_tls_psk_refresh(struct key *keyring,
-		const char *hostnqn, char *subnqn, u8 hmac_id,
+		const char *hostnqn, const char *subnqn, *data, u8 hmac_id,
 		u8 *data, size_t data_len, const char *digest)
 {
-	return ERR_PTR(-ENOTSUPP);
+	return ERR_PTR(-EOPNOTSUPP);
 }
 static inline key_serial_t nvme_tls_psk_default(struct key *keyring,
 		const char *hostnqn, const char *subnqn)
@@ -36,7 +42,21 @@ static inline key_serial_t nvme_keyring_id(void)
 }
 static inline struct key *nvme_tls_key_lookup(key_serial_t key_id)
 {
-	return ERR_PTR(-ENOTSUPP);
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct key *nvme_dhchap_psk_create(struct key *keyring,
+		const char *data, size_t data_len)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+static inline struct key *nvme_dhchap_psk_lookup(struct key *keyring,
+		const char *identity)
+{
+	return ERR_PTR(-EOPNOTSUPP);
+}
+u8 nvme_dhchap_psk_hash(struct key *key)
+{
+	return 0;
 }
 #endif /* !CONFIG_NVME_KEYRING */
 #endif /* _NVME_KEYRING_H */

-- 
2.51.0


