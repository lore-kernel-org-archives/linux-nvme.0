Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91810C3DA59
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jul 2024 14:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bvOgnr4Gw8EpRBMKfiPqP4LRmntbA5g5d1IObyrEzME=; b=ldDCBL/hnehCKcf8suG27Rap9B
	pDeE9LXzI4mqXhg1AZ7UbR0CA/Wkf84WD7dhWWj2Xdmar3JOTbdna9KeNkYi6TM0FwPze3cIHoW0H
	eE1Gn/tgX0gzPFOpHskG8UrBQPNIN+ARJflcyluBS8ETq0wwAa9R09j5qvzKtJI8YJCwaoVmD1Muw
	t6UmVaj2Iq5KZOAf0wSV2/E9/TwE1pcWu4hToqeQ4MVRLmxmbJnu1h4LVDcT8DfgVLNwDh5Mo2joF
	8gZv4lLifI4nS8J+1qwrcrCBVSGxaa7FpaZRE3alxFwMYjJ4W3hJGSOjJWgoJHJiF6VI0fgW+A8Pj
	ITsac+tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVtvd-00000009lKT-3TE5;
	Mon, 22 Jul 2024 14:22:17 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVtvZ-00000009lH0-3N5h
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jul 2024 14:22:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 3003BCE0B62;
	Mon, 22 Jul 2024 14:22:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77B5C4AF10;
	Mon, 22 Jul 2024 14:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721658131;
	bh=sMr9tiA+0102TDd3S2l2O6+CIO9nX552Yu/m9m7VBBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UHr28Os42jES4BLpnjVkuS8GK/qtA8JXTjAhr2lnfQ1nf2rPRK5I1mNsnS/FyuP/F
	 OXa3Rdf5h0uoSWxdoNUuWZakwFJPS45LZMf/2h5DkUhQi8ERRGvhHHNtzoDd7AMpjS
	 6rUoM8mMOjAp9xs4U9Rhfoge0du7OSZXpTlWGOOyNVbQrngKD5t64fDOhVfZAWuM1W
	 Q+UolzEgKRTKFfWWx+hIne2S5aKZtDsKGQ3ZK/NnKWnmvOBAwUzfUvU9ylO+knLy9J
	 Egn5esqXugjd6ooCznTAny4MnC1zRj3XhZnevpI/0nzuDkfUN4RCedZ1CFbs/xYYIA
	 oenXdznffct3g==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 5/9] nvme-keyring: add nvme_tls_psk_refresh()
Date: Mon, 22 Jul 2024 16:21:18 +0200
Message-Id: <20240722142122.128258-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240722142122.128258-1-hare@kernel.org>
References: <20240722142122.128258-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_072214_228799_7909ECEB 
X-CRM114-Status: GOOD (  12.89  )
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
 drivers/nvme/common/keyring.c | 50 +++++++++++++++++++++++++++++++++++
 include/linux/nvme-keyring.h  |  7 +++++
 2 files changed, 57 insertions(+)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index ed5167f942d8..a8d378f41fcc 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -124,6 +124,56 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
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
index 19d2b256180f..84824facc1f8 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -8,6 +8,8 @@
 
 #if IS_ENABLED(CONFIG_NVME_KEYRING)
 
+struct key *nvme_tls_psk_refresh(struct key *keyring, char *hostnqn, char *subnqn,
+				 u8 hmac_id, bool generated, u8 *data, size_t data_len, char *digest);
 key_serial_t nvme_tls_psk_default(struct key *keyring,
 		const char *hostnqn, const char *subnqn);
 
@@ -15,6 +17,11 @@ key_serial_t nvme_keyring_id(void);
 struct key *nvme_tls_key_lookup(key_serial_t key_id);
 #else
 
+static struct key *nvme_tls_psk_refresh(struct key *keyring, char *hostnqn, char *subnqn,
+		u8 hmac_id, bool generated, u8 *data, size_t data_len, char *digest)
+{
+	return ERR_PTR(-ENOTSUPP);
+}
 static inline key_serial_t nvme_tls_psk_default(struct key *keyring,
 		const char *hostnqn, const char *subnqn)
 {
-- 
2.35.3


