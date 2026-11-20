Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84410606A33E
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qZmp5Rhw;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=idvk1wIw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6pfiOLVsx6a+xlHnlgKgwj8VHd0k71QW3+Znh8XqTps=; b=qZmp5RhwiZW3KK
	6Rjrx2bmCW+2aQKBMFSnU1FV6JEzop61JOz1+d+pg2Xio9hAfmXvii7vLYe5tNOOr6ChOR6KHAzpu
	Ez6NGZO13/MgI3P8OJA0kQq1ZM1beufqceHqCjV6B7LtB0hoMclAo6Lmb55YI/MgDQH1N+iDWBlU0
	92qozBscdSglb7SaNDKAREdKU+7q79pJzuT/bVt2IqbK7JU2kNjlTNUPliT/PLbUZVez7mE3IEi5N
	LxzkGiR2qWkRgaAhidBt7jp/zzbED54tC41ugsnCrCm3AMQ8MbLfacPxuFMcH31n3eajxeXe8xbJ+
	6NV8kTc20EwgWa6pJo9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMZW-0000000Ekfa-0l6M;
	Fri, 20 Nov 2026 11:14:26 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMZU-0000000EkeV-05iP
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 11:14:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 494CF6185B;
	Fri, 20 Nov 2026 11:14:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABBDF1F000D2;
	Fri, 20 Nov 2026 11:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795173262;
	bh=6pfiOLVsx6a+xlHnlgKgwj8VHd0k71QW3+Znh8XqTps=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=idvk1wIw+66zpnNifEEvH5aSXuAel70uZULntvOfSz7MI3xD8uYrn/d5tWqAmsdZA
	 eWYLblR38CAC/94vxAufVcedkFRI53rzJxpxFwl2CFLMtU4h41NRQ2wLZgKBpU/Nj2
	 ZoCXMAEK1HSn0Zyf7GRrlz1bsYRcYCyNE18HZ1DSP0+V984NnTK7zSIAnmzlw9WBvi
	 r6jN6CiR28wBnOeqRtC8yn/hdksbkpNwCNLBVONUsaMh4HmAfvEMa7OBwj/XQ+wcI7
	 XkbjufcppKakY5bvxQ4k4AnTXgqugEXNXrIS1sx8r6RuHJQ/qayiSD6GvosCLifYo+
	 BRTL38j6wNGAA==
From: Hannes Reinecke <hare@kernel.org>
Date: Fri, 20 Nov 2026 12:14:01 +0100
Subject: [PATCH v4 2/9] nvme-keyring: add 'dhchap' key type
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-dhchap-keyring-v4-v4-2-5f8c7d9926ee@kernel.org>
References: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
In-Reply-To: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795173255; l=7582;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=Oz7bO/W9EWwoiOgBoW8Z8Y+IvOClD1k4X524K+Tict0=;
 b=q/NTp6LHMzOWxNy8jrwLlcv34rStGIQFeqb6WMBk10oGXRTbeywcoqOYbTWtNl/FSAc/Dol/f
 BvVmWRHgc84A1mhHd4KUCUSRbh4K1RYQwLQhrAYcadRMmypjCPtstfI
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

Add a 'dhchap' keytype to store DH-HMAC-CHAP secret keys.
Keys are stored with a 'user-type' compatible payload, such
that one can use 'user_read()' to access the raw contents
and the 'read()' callback to get the base64-encoded key
data in the DH-HMAC-CHAP secret representation.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/keyring.c | 216 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 216 insertions(+)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 87cb51e1f5a7f330af4705f4058f661d15f5984a..96561f2dd81b8152f3d320fb63cdd605c132260e 100644
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
@@ -253,6 +256,212 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
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
+ * Decode the DH-HMAC-CHAP key data passed in @prep and
+ * store the resulting binary data. The binary data includes
+ * space for the CRC, the version, and the hmac identifier,
+ * but the data length is just the key data without the CRC.
+ * This allows the user to read the key data via the
+ * 'user_read()' function. The additional 'version' ahd 'hmac'
+ * data is used in the ->read() callback to generate the
+ * base64 encoded key.
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
+	if (sscanf(prep->data, "DHHC-%01hhu:%02hhu:%*s",
+		   &version, &hmac) != 2) {
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
+	/*
+	 * payload is < key | version | hmac >
+	 * base64 decode will always return less data
+	 * than the encoded data, so allocating the size
+	 * of the encoded data will be large enough.
+	 */
+	upayload = kzalloc(sizeof(*upayload) + datalen, GFP_KERNEL);
+	if (!upayload) {
+		prep->payload.data[0] = NULL;
+		prep->quotalen = 0;
+		return -ENOMEM;
+	}
+
+	/* decode the data */
+	prep->quotalen = keylen;
+	prep->payload.data[0] = upayload;
+	ret = base64_decode(prep->data + 10, datalen, upayload->data,
+			    true, BASE64_STD);
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
+	/* append version and hmac to the payload */
+	upayload->data[ret + 4] = version;
+	upayload->data[ret + 5] = hmac;
+	upayload->datalen = ret;
+	return 0;
+}
+
+/**
+ * nvme_dhchap_decoded_key_size - Size of the base64-decoded key
+ * @size: size of the encoded key
+ *
+ * Returns the expected size of the key after base64 decoding.
+ */
+static inline int nvme_dhchap_decoded_key_size(int size)
+{
+	int keylen = -EINVAL;
+
+	switch (size) {
+	case 32:
+		keylen = 48;
+		break;
+	case 48:
+		keylen = 72;
+		break;
+	case 64:
+		keylen = 92;
+		break;
+	default:
+		break;
+	}
+	return keylen;
+}
+
+/**
+ * nvme_dhchap_psk_read - read callback for dhchap key types
+ * @key: key to read from
+ * @buffer: buffer for the key contents
+ * @buflen: length of @buffer
+ *
+ * Formets the DH-HMAC-CHAP key in base64-encoded form as
+ * defined in the NVM Express TCP Transport Specification Rev 1.1,
+ * Section 3.6.1.5 'PSK Interchange Format'. The payload of @key
+ * is assumed to be of 'struct user_key_payload', with the data
+ * consisting of the key data of length 'upayload->datalen', followed
+ * by four bytes of CRC, one byte version, and one byte hmac fields.
+ */
+static long nvme_dhchap_psk_read(const struct key *key,
+				 char *buffer, size_t buflen)
+{
+	const struct user_key_payload *upayload;
+	size_t datalen, keylen;
+	u8 version, hmac;
+	long ret;
+
+	upayload = user_key_payload_locked(key);
+	/*
+	 * Expected output string length:
+	 * strlen("DHHC-") +
+	 * version (= 1) +
+	 * ':' (= 1) +
+	 * hmac (= 2) +
+	 * ':' (= 1) +
+	 * encoded base64 key length +
+	 * CRC length (= 4) +
+	 * ':' (= 1)
+	 */
+	keylen = nvme_dhchap_decoded_key_size(upayload->datalen) + 15;
+	if (keylen < 0 || !buffer || buflen == 0)
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
+	ret += base64_encode(upayload->data, datalen, buffer + ret,
+			     true, BASE64_STD);
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
 static int __init nvme_keyring_init(void)
 {
 	int err;
@@ -271,11 +480,18 @@ static int __init nvme_keyring_init(void)
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

-- 
2.51.0


