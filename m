Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25DC8C54E5D
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 15:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=txnDXLQFClTrQQo21ealqBlGusd4BdYEaY+/jOe64ZU=; b=TL6UrT96872W0BxwuMLtbUDieP
	1W4jd7L4UNvDzN3Y0Kt36FHIP4hFfHPLRKF+r8cs+RbGoyh6VqUJpsOvGBS1USlIqMGQz4FJBEtCQ
	jP5hITMKvVGQ0iLnVEFv/FtsIY8mRX7l4h5kKINzjYDB1ZAuY+bqHk0IXmibz0SrezFHVCS3+uyXm
	Vfo4TrqzVrACKU6QLZ4ZOTDW1TOJOYgt8bjFCHUODDYGTB6ZlP3qnvn3qzT+r7kzdB+7C6ooUEwy8
	cEQb4718fZL8owJsnm5sU4UKxV7SP2LZCWLhuLuALqyMTFMc328ve6bkF0jy3iQqy6k7X3qJGEYcp
	vM9bmjXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWo-00000008uRk-186m;
	Mon, 18 Mar 2024 15:03:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWd-00000008uI2-0ZlA
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 15:03:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6DA8060BC0;
	Mon, 18 Mar 2024 15:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62F4C433F1;
	Mon, 18 Mar 2024 15:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710774222;
	bh=sL0e5TM9D7MWaR+Rid+nCU2DH3QINk6gtI9Mpl1mbbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VQm+bH+G5NSnjBVkkQYWp7AqK91Zq+wvq3QEgtoyGA639QxRWHuGEg072fPB5MY1f
	 fVLtFEjfNlg3hQGPVmzLPRu+/eKK6vpXrHL6CgQCwZpNl9XHDM4Bz8vCzKr4zV06sZ
	 vv7aeIQn3itfi3579k5fXM5I7MQp+16l/+6Va8shczegHltS25Sg/gMZCEED4DjGPW
	 OubaTGv0uAoUXQiOUqGr71FprX2n5v6BTgthmkuuYHOeGZlujU4WHlHs6cJGf6WxKY
	 s+Y3BLynlSU7YKGOiTbukEwduS2cXGO0y75MI01WhPKyyo2RBUNHPiBXmwzjmCUP0n
	 LY+AeHpTmYhCw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 07/17] nvme-keyring: add nvme_tls_psk_refresh()
Date: Mon, 18 Mar 2024 16:03:06 +0100
Message-Id: <20240318150316.138501-8-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240318150316.138501-1-hare@kernel.org>
References: <20240318150316.138501-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_080343_860087_C3CC5251 
X-CRM114-Status: GOOD (  12.48  )
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
index 2beac89b2246..d0e30e64d130 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -102,6 +102,56 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
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


