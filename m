Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D785C52D7C
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Aug 2024 11:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CWCCfmhvABiZMY3Rq6RwVd35lrGJT2ijfx6WU/sYOpI=; b=weN86xLc9dpURiXUaVCc5tpXpp
	+NqEOCvyg7sv9AK6T3r60o5q03j0oyzOC+zMO7Fx7XHf7tNJ97akeQSvk2mCw/Gl2mnmt1tnlA4BL
	FlHnPbzhH3Ef2A4Kbv8ZTWLb2AUHsqyQaC3g28a1d9UR6FAca2XTxxGKGRomTg0TlMwTSzBish3z/
	q+lcADlmszy5LBCSQp0aPEJRiXW3wiLYDdM72lyi7AjJ18O5IFoIU/AZssYYa7T0jS2mg045dGjp0
	pQm9KJDjsvvYbP+dPIt1MUnyg7KIXKLMLSQ7fb773nlZrCsiEPY+PP1DWbsvWcQdk9+9tQ5vwlhzM
	oFT44MHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdpVA-00000003TP9-3x3L;
	Tue, 13 Aug 2024 11:15:44 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdpV7-00000003TN9-2vP5
	for linux-nvme@lists.infradead.org;
	Tue, 13 Aug 2024 11:15:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0884961642;
	Tue, 13 Aug 2024 11:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F69BC4AF16;
	Tue, 13 Aug 2024 11:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723547740;
	bh=FvaAP/PZSe5da8Br0cOgaV4n77+sOCWgAbrcmYowNpw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RQy2YdceYUV/VtsPibuUkBwNrbwHb3o0k2mZPXtpaVfQUay2Iqsrgzfwb+Ihj0QKF
	 cGDcsdREzIhXO5p7e7m8FhovUp1XPeLyY5FTYG57T8LFfmiFDW9GFHsKJwxb5epEPz
	 SvBQ1QBmooWVgmxAGteZSQAP5WkxVLWRHdBwhkuMRmhtr9j4edw2+SEUOd6oZ30Yy6
	 6metfeh+naLczAV3UyVXQHBsag5kw5zTWBK6SWh1U7H6QATXEBLVdJKRub8ZqrZuZc
	 kLnUt1Smoe8ip41s4EjqB1aGLMv4nQPj0q++sdf/+dTJ/ISZrAH4NoAi+PZFVbxnWH
	 hSpZs1QnhPoiw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 5/9] nvme-keyring: add nvme_tls_psk_refresh()
Date: Tue, 13 Aug 2024 13:15:08 +0200
Message-Id: <20240813111512.135634-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240813111512.135634-1-hare@kernel.org>
References: <20240813111512.135634-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240813_041541_902060_56AE9270 
X-CRM114-Status: GOOD (  13.00  )
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

Add a function to refresh a generated PSK in the specified keyring.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/common/keyring.c | 64 +++++++++++++++++++++++++++++++++++
 include/linux/nvme-keyring.h  |  9 +++++
 2 files changed, 73 insertions(+)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index ed5167f942d8..8cb253fcd586 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -124,6 +124,70 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
 	return key_ref_to_ptr(keyref);
 }
 
+/**
+ * nvme_tls_psk_refresh - Refresh TLS PSK
+ * @keyring: Keyring holding the TLS PSK
+ * @hostnqn: Host NQN to use
+ * @subnqn: Subsystem NQN to use
+ * @hmac_id: Hash function identifier
+ * @data: TLS PSK key material
+ * @data_len: Length of @data
+ * @digest: TLS PSK digest
+ *
+ * Refresh a generated version 1 TLS PSK with the identity generated
+ * from @hmac_id, @hostnqn, @subnqn, and @digest in the keyring given
+ * by @keyring.
+ *
+ * Returns the updated key success or an error pointer otherwise.
+ */
+struct key *nvme_tls_psk_refresh(struct key *keyring,
+		const char *hostnqn, const char *subnqn, u8 hmac_id,
+		u8 *data, size_t data_len, const char *digest)
+{
+	key_perm_t keyperm =
+		KEY_POS_SEARCH | KEY_POS_VIEW | KEY_POS_READ |
+		KEY_POS_WRITE | KEY_POS_LINK | KEY_POS_SETATTR |
+		KEY_USR_SEARCH | KEY_USR_VIEW | KEY_USR_READ;
+	char *identity;
+	key_ref_t keyref;
+	key_serial_t keyring_id;
+	struct key *key;
+
+	if (!hostnqn || !subnqn || !data || !data_len)
+		return ERR_PTR(-EINVAL);
+
+	identity = kasprintf(GFP_KERNEL, "NVMe1G%02d %s %s %s",
+		 hmac_id, hostnqn, subnqn, digest);
+	if (!identity)
+		return ERR_PTR(-ENOMEM);
+
+	if (!keyring)
+		keyring = nvme_keyring;
+	keyring_id = key_serial(keyring);
+	pr_debug("keyring %x refresh tls psk '%s'\n",
+		 keyring_id, identity);
+	keyref = key_create_or_update(make_key_ref(keyring, true),
+				"psk", identity, data, data_len,
+				keyperm, KEY_ALLOC_NOT_IN_QUOTA |
+				      KEY_ALLOC_BUILT_IN |
+				      KEY_ALLOC_BYPASS_RESTRICTION);
+	if (IS_ERR(keyref)) {
+		pr_debug("refresh tls psk '%s' failed, error %ld\n",
+			 identity, PTR_ERR(keyref));
+		kfree(identity);
+		return ERR_PTR(-ENOKEY);
+	}
+	kfree(identity);
+	/*
+	 * Set the default timeout to 1 hour
+	 * as suggested in TP8018.
+	 */
+	key = key_ref_to_ptr(keyref);
+	key_set_timeout(key, 3600);
+	return key;
+}
+EXPORT_SYMBOL_GPL(nvme_tls_psk_refresh);
+
 /*
  * NVMe PSK priority list
  *
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index 19d2b256180f..351a02b1bbc3 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -8,6 +8,9 @@
 
 #if IS_ENABLED(CONFIG_NVME_KEYRING)
 
+struct key *nvme_tls_psk_refresh(struct key *keyring,
+		const char *hostnqn, const char *subnqn, u8 hmac_id,
+		u8 *data, size_t data_len, const char *digest);
 key_serial_t nvme_tls_psk_default(struct key *keyring,
 		const char *hostnqn, const char *subnqn);
 
@@ -15,6 +18,12 @@ key_serial_t nvme_keyring_id(void);
 struct key *nvme_tls_key_lookup(key_serial_t key_id);
 #else
 
+static struct key *nvme_tls_psk_refresh(struct key *keyring,
+		const char *hostnqn, char *subnqn, u8 hmac_id,
+		u8 *data, size_t data_len, const char *digest)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
 static inline key_serial_t nvme_tls_psk_default(struct key *keyring,
 		const char *hostnqn, const char *subnqn)
 {
-- 
2.35.3


