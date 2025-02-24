Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E16D6C021BC
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 13:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RUHsHOwleovYowyxgE6ts8SY5F+ZdR6VPGi9QqxIMfo=; b=F3Fg+pZ2U7UvmIB/8RNT3N3UQl
	n/9CcSt2hnbV0QjRFqMDGhdY9/53zPeF4+zVZEt1VRlHtE16E87POqGXBxEhKhGEv02EHZTtwI8Nv
	9dX7EFhKXyuneSvGfGEXV5ySVYrTCv9gIoBpTXUJbP1vbaEHDJKbSL48Z+i/laBB0xsAoYJzDQsuV
	02bB4eED6wYrCZY3jHgcZwIiO3pPnjT8D9prvb57bASx236XQOCetg6+Z6rr3Ta+FYZE+rxx7Lejd
	+FtRLomaapks8OBseXCGU6pag/xcXUqKQrPTST6gcpTlys9C2IEJVg+1y344NAPZdZLvhvE8a4dZw
	8X1SVbww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmYHz-0000000DoBe-0IDy;
	Mon, 24 Feb 2025 13:14:27 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmXjP-0000000DiZ1-3SX1
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 12:38:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 73798611AE;
	Mon, 24 Feb 2025 12:38:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF3FDC4CEE6;
	Mon, 24 Feb 2025 12:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740400722;
	bh=gRh6Kiy+QEVk1EMzA8e0Wwa3TRHhifoR9QpUc3aOvu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GuMPmuxjiTw6+lpwTMGAK0cb0sGKqoKDmitWlWGKgJh8JTpAn5dQwTPqjp9QZxaC0
	 xQbHt1Cn/Ze0qGjwpe/OILuTTsvsoEVX+bpSU7fsTwTYRbiAYj2SixvDR4z+UWNwSc
	 Od+X3DxO/ZVA5TTgMUH66yLK2OJvsUHloer2EFOCl+89gLqXKrG0/f/ujOw+kHGz0k
	 Rv2XtRO9tgp+4F2Zxpa0LweQGRy2EefFMX9J9aJqhYPEe9R25w4qY43PzabjCZnx9O
	 ZqS56DTimPXKheTmDpe+4ng5tdodXorfinyWpmFEQUhMa5k6MltUjh6yQYrwKpIi1L
	 j3+xF3t47omQA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 05/10] nvme-keyring: add nvme_tls_psk_refresh()
Date: Mon, 24 Feb 2025 13:38:13 +0100
Message-Id: <20250224123818.42218-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250224123818.42218-1-hare@kernel.org>
References: <20250224123818.42218-1-hare@kernel.org>
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

Add a function to refresh a generated PSK in the specified keyring.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/common/keyring.c | 65 ++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/tcp.c       |  1 -
 drivers/nvme/target/tcp.c     |  1 -
 include/linux/nvme-keyring.h  | 12 ++++++-
 4 files changed, 75 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index ed5167f942d8..32d16c53133b 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -5,7 +5,6 @@
 
 #include <linux/module.h>
 #include <linux/seq_file.h>
-#include <linux/key.h>
 #include <linux/key-type.h>
 #include <keys/user-type.h>
 #include <linux/nvme.h>
@@ -124,6 +123,70 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
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
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index dc5bbca58c6d..68769449d595 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -8,7 +8,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/err.h>
-#include <linux/key.h>
 #include <linux/nvme-tcp.h>
 #include <linux/nvme-keyring.h>
 #include <net/sock.h>
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7c51c2a8c109..fa59a7996efa 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -8,7 +8,6 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/err.h>
-#include <linux/key.h>
 #include <linux/nvme-tcp.h>
 #include <linux/nvme-keyring.h>
 #include <net/sock.h>
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index 19d2b256180f..ab8971afa973 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -6,15 +6,25 @@
 #ifndef _NVME_KEYRING_H
 #define _NVME_KEYRING_H
 
+#include <linux/key.h>
+
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


