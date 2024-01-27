Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F5DC47DDB
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jan 2024 09:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZfzkJApSFva+erVYpopbXEbf/8BmeCaYGaZSQB+l/88=; b=rpyPsqNCBXKYUzO8qEBX5IQR+Q
	sGzF4e6f5G+F8SqBLB0i6WrrEQOI7nE4T0YsQS+nR+eu6hkZxWXrV9WMapdMiacInTMgcEdCP60SB
	14yiebPfa0muCl6zI6SgvkPQk53o7h0tqlZlcdEtQKaq4hJ4wYiYKInONIaFvRAk9rqpqdNip5gbA
	N3kKJfBPFFUDl9ZqdJFW8Odrp3YsmvlAGOzYWNgt9eTEJ/md0XIuHIaMwIYe5ckKw1YsvCaiK5MqO
	gI5OQXIC3M4r7N2ROgR7/FUuf50oYiNg49I1pGIhdK9aOZu3Dr125xTKNl9X/hCF6FaHws8TfSodY
	IRAwoJQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf24-00000007FdC-0opH;
	Sat, 27 Jan 2024 09:31:24 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf1u-00000007FSr-1FsR
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jan 2024 09:31:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 569B2CE3859;
	Sat, 27 Jan 2024 09:31:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BD8C433F1;
	Sat, 27 Jan 2024 09:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706347871;
	bh=xpF84CDuwskauc7Zjru5Yx/Bbr0rCpz6JXbuWzp43C0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sw21ITn4vhWhoTWtu1qWqpwG6iR9/wO+a5MPNHP+QQxjWk3RLsKJiDfe60uW7vgyJ
	 I083rCfxL8/7LNmn/6ppokmZWxUD5uxSAMlPGd3EkOfT0Eb1/dPye24Ep4rfLuvsjB
	 eu6t0zoWXFwN3zbYXX2Zeu4Gdx5e60eo6bFSEcTwMnQkiXcTO8BboMj6q7drcJvnYc
	 kYG/YdxJVL+btL4YahKBD2wfbNZlKJz+H1IGYd7CF+wNFwx7t6DXLu1RbQDYqHwe8C
	 PNUkZcKF/t+OZ0kIhqe1YJD9gxRSdSg2gJ5dO0Hz8Hc7NUAewy3GwPjA5aWVi2YEoT
	 /nrdevHA+kmIA==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 05/13] nvme-keyring: add nvme_tls_psk_refresh()
Date: Sat, 27 Jan 2024 10:30:50 +0100
Message-Id: <20240127093058.15699-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240127093058.15699-1-hare@kernel.org>
References: <20240127093058.15699-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240127_013114_738737_5DEE95C0 
X-CRM114-Status: GOOD (  12.20  )
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

From: Hannes Reinecke <hare@suse.de>

Add a function to refresh a generated PSK in the specified keyring.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/common/keyring.c | 50 +++++++++++++++++++++++++++++++++++
 include/linux/nvme-keyring.h  |  7 +++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index a5c0431c101c..c16f9496643f 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -104,6 +104,56 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
 	return key_ref_to_ptr(keyref);
 }
 
+struct key *nvme_tls_psk_refresh(struct key *keyring, char *hostnqn, char *subnqn,
+		u8 hmac_id, bool generated, u8 *data, size_t data_len, char *digest)
+{
+	key_perm_t keyperm =
+		KEY_POS_SEARCH | KEY_POS_VIEW | KEY_POS_READ |
+		KEY_POS_WRITE | KEY_POS_LINK | KEY_POS_SETATTR |
+		KEY_USR_SEARCH | KEY_USR_VIEW | KEY_USR_READ;
+	char *identity;
+	size_t identity_len = (NVMF_NQN_SIZE) * 2 + 77;
+	key_ref_t keyref;
+	key_serial_t keyring_id;
+	struct key *key;
+
+	if (!hostnqn || !subnqn || !data || !data_len)
+		return ERR_PTR(-EINVAL);
+
+	identity = kzalloc(identity_len, GFP_KERNEL);
+	if (!identity)
+		return ERR_PTR(-ENOMEM);
+
+	snprintf(identity, identity_len, "NVMe1%c%02d %s %s %s",
+		 generated ? 'G' : 'R', hmac_id, hostnqn, subnqn, digest);
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
index e10333d78dbb..d2b8a0783ad7 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -8,6 +8,8 @@
 
 #if IS_ENABLED(CONFIG_NVME_KEYRING)
 
+struct key *nvme_tls_psk_refresh(struct key *keyring, char *hostnqn, char *subnqn,
+				 u8 hmac_id, bool generated, u8 *data, size_t data_len, char *digest);
 key_serial_t nvme_tls_psk_default(struct key *keyring,
 		const char *hostnqn, const char *subnqn);
 
@@ -15,6 +17,11 @@ key_serial_t nvme_keyring_id(void);
 
 #else
 
+static struct key *nvme_tls_psk_refresh(struct key *keyring, char *hostnqn, char *subnqn,
+		u8 hmac_id, bool generated, u8 *data, size_t data_len, char *digest)
+{
+	return -ENOTSUPP;
+}
 static inline key_serial_t nvme_tls_psk_default(struct key *keyring,
 		const char *hostnqn, const char *subnqn)
 {
-- 
2.35.3


