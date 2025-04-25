Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDA6C369D1
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 11:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kyXZk/AwiTkBre2CGDN9eR/Bykz0YGCnV2R3ipz68Yg=; b=PZ/hBCxIEXbClvlZR6YE38F4Ke
	LnjWEUK2oVWN2FDHeYaRyIjc051zWCAjGUvPOJgz0rXvUg+BXrB/LMrApo5Ny5VJAyvWvRl8mS2zo
	+cdgH3YoZRN8cJgtn9c67BsCBAswF7rNVXFBKCSM4CJ2ev4O1CBSwnvHbvOU6FooRMtfFavbdXTfg
	WxKoZhcS2FemmH+DoCos/25dquZAmtNNsR7LXHAq5BqNNIONbf5hCyxeI5VmHidxsaY5pA/DzuI3O
	thZUPup7fM5rRTXImYlvc99xAQam3Q1ml4I08UStLYUxFu/iMVMUV5QSRkyW4bxBL8NJLt5dnmuq1
	oH8VRMhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8H0V-0000000GtX7-2WKf;
	Fri, 25 Apr 2025 11:14:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Fgv-0000000Gbt9-2gPe
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 09:49:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 04D8F5C63D2;
	Fri, 25 Apr 2025 09:47:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E1E7C4CEEA;
	Fri, 25 Apr 2025 09:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745574592;
	bh=UrnVZ/MJ6hjYKrKJME4fu2hoQDupjNaWN43Q7xl1cys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sem0BHDQzgP9RKp7df3Julpz6EJlqEULryMr93UPbx9Nm7DwskijHvH5BzIf5A0EW
	 jqv1cHanQ2DaqYTIlbp7HlFBSDcKSKObovkuLGjewkasTEqZVT80qoG1HkyV0S6ITd
	 +pM9Q6GugykEZ16lZyG30W+OprUMA+rgnbBlLQSoMq9nI5COdz0TVU6K93J6FoWIDg
	 8rAz7B/0hWFbRg+hP2iTVd4hkr0tBDyk2i5arUsgXIEYU8JgMY04XSXLp6oEL8NABn
	 MxCWUHiQNkoZsmWUi+AakUNJG++QK0nK90eLH9r5odoG+H7UN+aww3OvZTDRTdz12r
	 UxqmwarD8Ucfg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 06/12] nvme-auth: switch to use 'struct key'
Date: Fri, 25 Apr 2025 11:49:21 +0200
Message-Id: <20250425094927.102656-7-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250425094927.102656-1-hare@kernel.org>
References: <20250425094927.102656-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_024953_761576_1A592F99 
X-CRM114-Status: GOOD (  26.23  )
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
handling function to use 'struct key'.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/Kconfig |   1 +
 drivers/nvme/common/auth.c  | 141 ++++++++++++++----------------------
 drivers/nvme/host/Kconfig   |   1 -
 drivers/nvme/host/auth.c    |  28 ++++---
 drivers/nvme/host/nvme.h    |   4 +-
 drivers/nvme/host/sysfs.c   |  25 +++----
 drivers/nvme/target/Kconfig |   1 -
 drivers/nvme/target/auth.c  |  40 +++++-----
 drivers/nvme/target/nvmet.h |   4 +-
 include/linux/nvme-auth.h   |   8 +-
 10 files changed, 113 insertions(+), 140 deletions(-)

diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
index da963e4f3f1f..8a5521c038c5 100644
--- a/drivers/nvme/common/Kconfig
+++ b/drivers/nvme/common/Kconfig
@@ -13,3 +13,4 @@ config NVME_AUTH
 	select CRYPTO_DH
 	select CRYPTO_DH_RFC7919_GROUPS
 	select CRYPTO_HKDF
+	select NVME_KEYRING
diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 918c92cbd8c5..74763de526c3 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -14,6 +14,8 @@
 #include <crypto/hkdf.h>
 #include <linux/nvme.h>
 #include <linux/nvme-auth.h>
+#include <linux/nvme-keyring.h>
+#include <keys/user-type.h>
 
 #define HKDF_MAX_HASHLEN 64
 
@@ -161,58 +163,16 @@ u32 nvme_auth_key_struct_size(u32 key_len)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_key_struct_size);
 
-struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
-					      u8 key_hash)
+struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret,
+				  size_t secret_len)
 {
-	struct nvme_dhchap_key *key;
-	unsigned char *p;
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
-	key_len = base64_decode(secret, allocated_len, key->key);
-	if (key_len < 0) {
-		pr_debug("base64 key decoding error %d\n",
-			 key_len);
-		ret = key_len;
-		goto out_free_secret;
-	}
-
-	if (key_len != 36 && key_len != 52 &&
-	    key_len != 68) {
-		pr_err("Invalid key len %d\n", key_len);
-		ret = -EINVAL;
-		goto out_free_secret;
-	}
+	struct key *key;
 
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
-		goto out_free_secret;
-	}
-	key->len = key_len;
-	key->hash = key_hash;
+	key = nvme_dhchap_psk_refresh(keyring, secret, secret_len);
+	if (!IS_ERR(key))
+		pr_debug("generated dhchap key %08x\n",
+			 key_serial(key));
 	return key;
-out_free_secret:
-	nvme_auth_free_key(key);
-	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_extract_key);
 
@@ -237,14 +197,15 @@ void nvme_auth_free_key(struct nvme_dhchap_key *key)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_free_key);
 
-int nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn,
+int nvme_auth_transform_key(struct key *key, char *nqn,
 			    u8 **transformed_secret)
 {
 	const char *hmac_name;
 	struct crypto_shash *key_tfm;
 	SHASH_DESC_ON_STACK(shash, key_tfm);
+	long key_len = 0;
 	u8 *transformed_data;
-	u8 *key_data;
+	u8 *key_data, key_hash;
 	size_t transformed_len;
 	int ret;
 
@@ -252,17 +213,47 @@ int nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn,
 		pr_warn("No key specified\n");
 		return -ENOKEY;
 	}
-	key_data = kzalloc(key->len, GFP_KERNEL);
-	if (!key_data)
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
+	key_data = kzalloc(key_len, GFP_KERNEL);
+	if (!key_data) {
+		up_read(&key->sem);
 		return -ENOMEM;
-	memcpy(key_data, key->key, key->len);
-	if (key->hash == 0) {
+	}
+
+	ret = user_read(key, key_data, key_len);
+	key_hash = nvme_dhchap_psk_hash(key);
+	up_read(&key->sem);
+	if (ret != key_len) {
+		if (ret < 0) {
+			pr_warn("failed to read data from key %08x: error %d\n",
+				key_serial(key), ret);
+		} else {
+			pr_warn("only read %d of %ld bytes from key %08x\n",
+				ret, key_len, key_serial(key));
+		}
+		goto out_free_data;
+	}
+	if (key_hash == 0) {
 		*transformed_secret = key_data;
-		return key->len;
+		return key_len;
 	}
-	hmac_name = nvme_auth_hmac_name(key->hash);
+	hmac_name = nvme_auth_hmac_name(key_hash);
 	if (!hmac_name) {
-		pr_warn("Invalid key hash id %d\n", key->hash);
+		pr_warn("Invalid key hash id %d\n", key_hash);
 		ret = -EINVAL;
 		goto out_free_data;
 	}
@@ -274,9 +265,9 @@ int nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn,
 	}
 
 	transformed_len = crypto_shash_digestsize(key_tfm);
-	if (transformed_len != key->len) {
+	if (transformed_len != key_len) {
 		pr_warn("incompatible digest size %ld for key (hash %s, len %ld)\n",
-			transformed_len, hmac_name, key->len);
+			transformed_len, hmac_name, key_len);
 		ret = -EINVAL;
 		goto out_free_tfm;
 	}
@@ -288,7 +279,7 @@ int nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn,
 	}
 
 	shash->tfm = key_tfm;
-	ret = crypto_shash_setkey(key_tfm, key->key, key->len);
+	ret = crypto_shash_setkey(key_tfm, key_data, key_len);
 	if (ret < 0)
 		goto out_free_transformed_data;
 	ret = crypto_shash_init(shash);
@@ -304,8 +295,9 @@ int nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn,
 	if (ret < 0)
 		goto out_free_transformed_data;
 
-	crypto_free_shash(key_tfm);
 	*transformed_secret = transformed_data;
+	crypto_free_shash(key_tfm);
+	kfree(key_data);
 
 	return transformed_len;
 
@@ -454,31 +446,6 @@ int nvme_auth_gen_shared_secret(struct crypto_kpp *dh_tfm,
 }
 EXPORT_SYMBOL_GPL(nvme_auth_gen_shared_secret);
 
-int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key)
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
-EXPORT_SYMBOL_GPL(nvme_auth_generate_key);
-
 /**
  * nvme_auth_generate_psk - Generate a PSK for TLS
  * @hmac_id: Hash function identifier
diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index d47dfa80fb95..e7fb34fdc28b 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -114,7 +114,6 @@ config NVME_HOST_AUTH
 	bool "NVMe over Fabrics In-Band Authentication in host side"
 	depends on NVME_CORE
 	select NVME_AUTH
-	select NVME_KEYRING
 	help
 	  This provides support for NVMe over Fabrics In-Band Authentication in
 	  host side.
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 4e30a491e677..f04bc5d807d8 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -1048,14 +1048,22 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
 	if (!ctrl->opts)
 		return 0;
-	ret = nvme_auth_generate_key(ctrl->opts->dhchap_secret,
-			&ctrl->host_key);
-	if (ret)
+	ctrl->host_key = nvme_auth_extract_key(ctrl->opts->keyring,
+					       ctrl->opts->dhchap_secret,
+					       strlen(ctrl->opts->dhchap_secret));
+	if (IS_ERR(ctrl->host_key)) {
+		ret = PTR_ERR(ctrl->host_key);
+		ctrl->host_key = NULL;
 		return ret;
-	ret = nvme_auth_generate_key(ctrl->opts->dhchap_ctrl_secret,
-			&ctrl->ctrl_key);
-	if (ret)
+	}
+	ctrl->ctrl_key = nvme_auth_extract_key(ctrl->opts->keyring,
+					       ctrl->opts->dhchap_ctrl_secret,
+					       strlen(ctrl->opts->dhchap_ctrl_secret));
+	if (IS_ERR(ctrl->ctrl_key)) {
+		ret = PTR_ERR(ctrl->ctrl_key);
+		ctrl->ctrl_key = NULL;
 		goto err_free_dhchap_secret;
+	}
 
 	if (!ctrl->opts->dhchap_secret && !ctrl->opts->dhchap_ctrl_secret)
 		return 0;
@@ -1076,10 +1084,10 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 
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
@@ -1101,11 +1109,11 @@ void nvme_auth_free(struct nvme_ctrl *ctrl)
 		kfree(ctrl->dhchap_ctxs);
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
index 51e078642127..89c84220e340 100644
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
index 6d31226f7a4f..888f2d836704 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -589,8 +589,6 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 		return -EINVAL;
 	if (count < 7)
 		return -EINVAL;
-	if (memcmp(buf, "DHHC-1:", 7))
-		return -EINVAL;
 
 	dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
 	if (!dhchap_secret)
@@ -598,13 +596,12 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	memcpy(dhchap_secret, buf, count);
 	nvme_auth_stop(ctrl);
 	if (strcmp(dhchap_secret, opts->dhchap_secret)) {
-		struct nvme_dhchap_key *key, *host_key;
-		int ret;
+		struct key *key, *host_key;
 
-		ret = nvme_auth_generate_key(dhchap_secret, &key);
-		if (ret) {
+		key = nvme_auth_extract_key(opts->keyring, dhchap_secret, count);
+		if (IS_ERR(key)) {
 			kfree(dhchap_secret);
-			return ret;
+			return PTR_ERR(key);
 		}
 		kfree(opts->dhchap_secret);
 		opts->dhchap_secret = dhchap_secret;
@@ -612,7 +609,7 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 		mutex_lock(&ctrl->dhchap_auth_mutex);
 		ctrl->host_key = key;
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		nvme_auth_free_key(host_key);
+		key_put(host_key);
 	} else
 		kfree(dhchap_secret);
 	/* Start re-authentication */
@@ -656,13 +653,13 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 	memcpy(dhchap_secret, buf, count);
 	nvme_auth_stop(ctrl);
 	if (strcmp(dhchap_secret, opts->dhchap_ctrl_secret)) {
-		struct nvme_dhchap_key *key, *ctrl_key;
-		int ret;
+		struct key *key, *ctrl_key;
 
-		ret = nvme_auth_generate_key(dhchap_secret, &key);
-		if (ret) {
+		key = nvme_auth_extract_key(opts->keyring,
+					    dhchap_secret, count);
+		if (IS_ERR(key)) {
 			kfree(dhchap_secret);
-			return ret;
+			return PTR_ERR(key);
 		}
 		kfree(opts->dhchap_ctrl_secret);
 		opts->dhchap_ctrl_secret = dhchap_secret;
@@ -670,7 +667,7 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 		mutex_lock(&ctrl->dhchap_auth_mutex);
 		ctrl->ctrl_key = key;
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		nvme_auth_free_key(ctrl_key);
+		key_put(ctrl_key);
 	} else
 		kfree(dhchap_secret);
 	/* Start re-authentication */
diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index fb7446d6d682..28b5229c48e2 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -5,7 +5,6 @@ config NVME_TARGET
 	depends on BLOCK
 	depends on CONFIGFS_FS
 	select NVME_KEYRING if NVME_TARGET_TCP_TLS
-	select KEYS if NVME_TARGET_TCP_TLS
 	select SGL_ALLOC
 	help
 	  This enabled target side support for the NVMe protocol, that is
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index bb2b7bda308b..8afe571ea0ce 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -145,6 +145,7 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
 	int ret = 0;
 	struct nvmet_host_link *p;
 	struct nvmet_host *host = NULL;
+	u8 host_hash, ctrl_hash;
 
 	down_read(&nvmet_config_sem);
 	if (nvmet_is_disc_subsys(ctrl->subsys))
@@ -190,42 +191,43 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
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
@@ -263,11 +265,13 @@ void nvmet_destroy_auth(struct nvmet_ctrl *ctrl)
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
index b6db8b74dc4a..1aa9d2176f75 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -294,8 +294,8 @@ struct nvmet_ctrl {
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
index fd43fa042c88..bb973b39fd79 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -25,13 +25,11 @@ size_t nvme_auth_hmac_hash_len(u8 hmac_id);
 u8 nvme_auth_hmac_id(const char *hmac_name);
 
 u32 nvme_auth_key_struct_size(u32 key_len);
-struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
-					      u8 key_hash);
+struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret, size_t secret_len);
 void nvme_auth_free_key(struct nvme_dhchap_key *key);
 struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash);
-int nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn,
-			    u8 **transformed_secret) ;
-int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key);
+int nvme_auth_transform_key(struct key *key, char *nqn,
+			    u8 **transformed_secret);
 int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
 				  u8 *challenge, u8 *aug, size_t hlen);
 int nvme_auth_gen_privkey(struct crypto_kpp *dh_tfm, u8 dh_gid);
-- 
2.35.3


