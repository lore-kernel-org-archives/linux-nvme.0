Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F12D1C02182
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jan 2025 16:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p6wyxjUEriur0DHMiNaoVXke9r3DMBJKqbBlg8aDUVw=; b=22GJc4DCuMRlt3kuiqhVxvz21v
	C54ZDQi17fkD1zO+OZhyFbWnBlH7c4di/YB4XGtqT5udyGEhmkbdI2+ysK3P67Wbx54MLQeOTCaYk
	nWTdV7tTrH6WtDf5FDmcP6cuI+cJYb+BsnIqEqOFKcp0eXSquEsUnTTGpe5ldbxLxLrUlyOEgA112
	4ayHc/HNBIzgSvoKIxcE8rcBRoN1QYJBUVKisG4mTZRw+usGeh7ldCfB7XJhONpfSp+lyrXlpidp3
	3bfzDD7B4XLbuqwU8cQ+X+3b/h1E4enn8qs5Mzn1pBOCWeVKvY2I8CkzZGqd2bi9XMOHphwUW1DrS
	uynWtJFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tae4N-0000000An3A-07kE;
	Wed, 22 Jan 2025 16:59:11 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tae4J-0000000An00-1bZM
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jan 2025 16:59:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 270E95C5D81;
	Wed, 22 Jan 2025 16:58:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FAEC4CED2;
	Wed, 22 Jan 2025 16:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737565146;
	bh=uNTM3mfcC8n8xFcKb0O6XGynrlWkv7SXX3XHz7IPLRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d8lyhBsEqGMPGnkClx6IlMQsgcRl4ozSylrLuDwszdYZpl8s9dn8KvqC1SYIw/kMJ
	 VeOvWLTJ5uAI9fL6Tyl36rD6u/RL1ge7LnP3NSuixIbe3TQEtKmtKsnKbfx8R3TBuP
	 1qJUNBNl/+uQhZ+muo/zcHCSAr2It9vW2El5gEySh5RHHuYX2AFqDL+rHkxHZQpmR7
	 M8X8Q8RFRG8U04gOTt1ejhPh+hBuCZtNyZPVbMlOYPB5RM42HTSDNPHveQHpxRmmvs
	 xQtU2nblVQDeeFun2+w3RM62F92sv+eZ3kHxu1vxEC7nx5dwgjXgf8bdUYiL6RKzeM
	 gtAasY/4gC/kg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 05/10] nvme-keyring: add nvme_tls_psk_refresh()
Date: Wed, 22 Jan 2025 17:58:24 +0100
Message-Id: <20250122165829.11603-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250122165829.11603-1-hare@kernel.org>
References: <20250122165829.11603-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250122_085908_089558_CECA125D 
X-CRM114-Status: GOOD (  14.01  )
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
 include/linux/nvme-keyring.h  | 10 +++++-
 2 files changed, 73 insertions(+), 1 deletion(-)

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
index 19d2b256180f..f7bbcbeb4b13 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -8,13 +8,21 @@
 
 #if IS_ENABLED(CONFIG_NVME_KEYRING)
 
+struct key *nvme_tls_psk_refresh(struct key *keyring,
+		const char *hostnqn, const char *subnqn, u8 hmac_id,
+		u8 *data, size_t data_len, const char *digest);
 key_serial_t nvme_tls_psk_default(struct key *keyring,
 		const char *hostnqn, const char *subnqn);
 
 key_serial_t nvme_keyring_id(void);
 struct key *nvme_tls_key_lookup(key_serial_t key_id);
 #else
-
+static inline struct key *nvme_tls_psk_refresh(struct key *keyring,
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


