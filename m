Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B09C369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 11:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I3tiz+Iubo3/MHJJJiKsBUAqKwCDkp1ZTrOVSCpeDSI=; b=AsTwwzPICpcL7b0+pmsL1hFC9I
	XcFT3q8FMquZDYhKcmgiK1yuTH29iLbE0PPLToi45mFDvhs1zJslHRGAlPeL6Z0hkOQTMHZOX8+/T
	IcrTYoy7SlCQRvF/ym5YlVNh4XMmARyAjiOkfyUp87PAaH3H3MEc0VDc8Fxqwn/E/wW2Fsy5O/ZSK
	6f+72jIVyI8bmwQ49yQhKAjSbNo40AsRX+wAcWXAh7N2Vt1H7LecsIJttLJQsqJtinxP5EsfsqZE+
	pkpbW9RaJAICcTgMSteLpOBV0Kuem91cMYk4Vu5MlW+zeSQBPe51vdUj0NwY0xjsZE0QkOeMAIHyP
	uyrHduRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8H0U-0000000GtWM-3Znt;
	Fri, 25 Apr 2025 11:14:10 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Fgu-0000000Gbt3-04AG
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 09:49:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 1765C60007;
	Fri, 25 Apr 2025 09:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC47BC4CEEA;
	Fri, 25 Apr 2025 09:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745574591;
	bh=CuQDDYyPtPr2KWCQ8SrDPeD+1WKuVwurTVOnmrRxFc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dGY3iqvjWQ2JDwC8DEYtMHA6MMEW/276ML21bPeJrG7avE/LM3ah6RuT/8mZc3A8I
	 efFek7fY9Fo92epWCwTLCeZqKPOLdWfR7MxN05ow3gSQNvHb/UPTQYGUC4JkpmN7Q0
	 w3QcCYgfPq00ytynoJ4XvYfVhn3yVMkFOy7/BpNemlw2SCovvYuaxZzNzIV3/9ebIy
	 O5txIHWmydmgvEkhMi0+7xn9jKtUOj7nVlInGs+ngu7f4MTH0fq8pHD6Nrxrz1XaVv
	 QBwi+/hRSmjWUj0H4qWUxzDyeKsG+5a+76/KMJqwZ/IE8KZ0f6EIeX1z42XlnRevRw
	 NLinl5+nurAPQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 05/12] nvme-keyring: add 'dhchap' key type
Date: Fri, 25 Apr 2025 11:49:20 +0200
Message-Id: <20250425094927.102656-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250425094927.102656-1-hare@kernel.org>
References: <20250425094927.102656-1-hare@kernel.org>
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

Add a 'dhchap' keytype to store DH-HMAC-CHAP secret keys.
Keys are stored with a 'user-type' compatible payload, such
that one can use 'user_read()' to access the raw contents
and the 'read()' callback to get the base64-encoded key
data in the DH-HMAC-CHAP secret representation.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/keyring.c | 266 ++++++++++++++++++++++++++++++++++
 include/linux/nvme-keyring.h  |  22 ++-
 2 files changed, 287 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 32d16c53133b..a58c93c6d495 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -4,6 +4,9 @@
  */
 
 #include <linux/module.h>
+#include <linux/crc32.h>
+#include <linux/base64.h>
+#include <linux/unaligned.h>
 #include <linux/seq_file.h>
 #include <linux/key-type.h>
 #include <keys/user-type.h>
@@ -252,6 +255,262 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
 }
 EXPORT_SYMBOL_GPL(nvme_tls_psk_default);
 
+static void nvme_dhchap_psk_describe(const struct key *key, struct seq_file *m)
+{
+	seq_puts(m, key->description);
+	seq_printf(m, ": %u", key->datalen);
+}
+
+static bool nvme_dhchap_psk_match(const struct key *key,
+				  const struct key_match_data *match_data)
+{
+	const char *match_id;
+	size_t match_len;
+
+	if (!key->description) {
+		pr_debug("%s: no key description\n", __func__);
+		return false;
+	}
+	if (!match_data->raw_data) {
+		pr_debug("%s: no match data\n", __func__);
+		return false;
+	}
+	match_id = match_data->raw_data;
+	match_len = strlen(match_id);
+	pr_debug("%s: match '%s' '%s' len %zd\n",
+		 __func__, match_id, key->description, match_len);
+
+	return !memcmp(key->description, match_id, match_len);
+}
+
+static int nvme_dhchap_psk_match_preparse(struct key_match_data *match_data)
+{
+	match_data->lookup_type = KEYRING_SEARCH_LOOKUP_ITERATE;
+	match_data->cmp = nvme_dhchap_psk_match;
+	return 0;
+}
+
+/**
+ * nvme_dhchap_psk_preparse - prepare DH-HMAC-CHAP key data
+ * @prep: preparsed payload of the key data
+ *
+ * Decode the DH-HMAC-CHAP key data passed in in @prep and
+ * store the resulting binary data. The binary data includes
+ * space for the CRC, the version, and the hmac identifier,
+ * but the data length is just the key data without the CRC.
+ * This allows the user to read the key data via the
+ * 'user_read()' function, but also to export the full
+ * key data including CRC via the 'read' callback from the key type.
+ */
+static int nvme_dhchap_psk_preparse(struct key_preparsed_payload *prep)
+{
+	struct user_key_payload *upayload;
+	size_t datalen = prep->datalen, keylen;
+	int ret;
+	u32 crc;
+	u8 version, hmac;
+
+	if (!prep->data) {
+		pr_debug("%s: Empty data", __func__);
+		prep->payload.data[0] = NULL;
+		prep->quotalen = 0;
+		return -EINVAL;
+	}
+
+	if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%*s", &version, &hmac) != 2) {
+		pr_debug("%s: invalid key data '%s'\n", __func__,
+			 (char *)prep->data);
+		prep->payload.data[0] = NULL;
+		prep->quotalen = 0;
+		return -EINVAL;
+	}
+
+	/* skip header and final ':' character */
+	datalen -= 11;
+
+	/* keylen is the key length, 4 bytes CRC, 1 byte version, and 1 byte HMAC identifier */
+	switch (datalen) {
+	case 48:
+		keylen = 38;
+		break;
+	case 72:
+		keylen = 54;
+		break;
+	case 92:
+		keylen = 70;
+		break;
+	default:
+		pr_debug("%s: Invalid data length %lu\n", __func__, datalen);
+		prep->payload.data[0] = NULL;
+		prep->quotalen = 0;
+		return -EINVAL;
+	}
+
+	upayload = kzalloc(sizeof(*upayload) + keylen, GFP_KERNEL);
+	if (!upayload) {
+		prep->payload.data[0] = NULL;
+		prep->quotalen = 0;
+		return -ENOMEM;
+	}
+
+	/* decode the data */
+	prep->quotalen = keylen;
+	prep->payload.data[0] = upayload;
+	ret = base64_decode(prep->data + 10, datalen, upayload->data);
+	if (ret < 0) {
+		pr_debug("%s: Failed to decode key %s\n",
+			 __func__, (char *)prep->data + 10);
+		return ret;
+	}
+	ret -= 4;
+	crc = ~crc32(~0, upayload->data, ret);
+	if (get_unaligned_le32(upayload->data + ret) != crc) {
+		pr_debug("%s: CRC mismatch for key\n", __func__);
+		/* CRC mismatch */
+		return -EKEYREJECTED;
+	}
+	upayload->data[ret + 4] = version;
+	upayload->data[ret + 5] = hmac;
+	upayload->datalen = ret;
+	return 0;
+}
+
+static long nvme_dhchap_psk_read(const struct key *key, char *buffer, size_t buflen)
+{
+	const struct user_key_payload *upayload;
+	size_t datalen, keylen;
+	u8 version, hmac;
+	long ret;
+
+	upayload = user_key_payload_locked(key);
+	switch (upayload->datalen) {
+	    case 32:
+		keylen = 59;
+		break;
+	    case 48:
+		keylen = 83;
+		break;
+	    case 64:
+		keylen = 103;
+		break;
+	    default:
+		return -EINVAL;
+	}
+
+	if (!buffer || buflen == 0)
+		return keylen;
+
+	if (buflen < keylen)
+		return -EINVAL;
+
+	memset(buffer, 0, buflen);
+	version = upayload->data[upayload->datalen + 4];
+	hmac = upayload->data[upayload->datalen + 5];
+	ret = sprintf(buffer, "DHHC-%01hhu:%02hhu:", version, hmac);
+	if (ret < 0)
+		return -ENOKEY;
+	/* Include the trailing CRC */
+	datalen = upayload->datalen + 4;
+	ret += base64_encode(upayload->data, datalen, buffer + ret);
+	buffer[ret] = ':';
+	ret++;
+	return ret;
+}
+
+static struct key_type nvme_dhchap_psk_key_type = {
+	.name           = "dhchap",
+	.flags          = KEY_TYPE_NET_DOMAIN,
+	.preparse       = nvme_dhchap_psk_preparse,
+	.free_preparse  = user_free_preparse,
+	.match_preparse = nvme_dhchap_psk_match_preparse,
+	.instantiate    = generic_key_instantiate,
+	.revoke         = user_revoke,
+	.destroy        = user_destroy,
+	.describe       = nvme_dhchap_psk_describe,
+	.read           = nvme_dhchap_psk_read,
+};
+
+struct key *nvme_dhchap_psk_refresh(struct key *keyring,
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
+EXPORT_SYMBOL_GPL(nvme_dhchap_psk_refresh);
+
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
@@ -270,11 +529,18 @@ static int __init nvme_keyring_init(void)
 		key_put(nvme_keyring);
 		return err;
 	}
+	err = register_key_type(&nvme_dhchap_psk_key_type);
+	if (err) {
+		unregister_key_type(&nvme_tls_psk_key_type);
+		key_put(nvme_keyring);
+		return err;
+	}
 	return 0;
 }
 
 static void __exit nvme_keyring_exit(void)
 {
+	unregister_key_type(&nvme_dhchap_psk_key_type);
 	unregister_key_type(&nvme_tls_psk_key_type);
 	key_revoke(nvme_keyring);
 	key_put(nvme_keyring);
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index ab8971afa973..d8baa71f061d 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -18,9 +18,14 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
 
 key_serial_t nvme_keyring_id(void);
 struct key *nvme_tls_key_lookup(key_serial_t key_id);
+
+struct key *nvme_dhchap_psk_refresh(struct key *keyring,
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
2.35.3


