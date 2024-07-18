Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E990AC3DA63
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 15:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FTTZ75YWD8emxgjghZQJrAXeoAGmIQU9cmdIvAsOXpE=; b=SgCh+zVdc4jcikULWRbB8Rz1Du
	OdseC+jHzwObpuQuEKT6kBXcKGwahjU+ViY8DjePcrQMepeImNk0DEWGosKLsEAiEf6dNMMOI//Xk
	SsB0wB3oITiqOof5DHR2f3bejA5i9yUgPV1N3/FHlSeRF1TANgw09MONGxXHijwFuhu0TrXfGk8QI
	vKGEmkU/QcBpJYOScMDt/DbqlWkxybzxfDc91B3scb6s1QjKts3JnvJal7yXatUv+mmqqYPiHchym
	fJdlsW3o5XVSFOQ8bAMh09W0Y7y12Ys7Qg7Iuyr0MDg9ixmyS8HGfTB67uTd9SfDRMXbeFE12kLFJ
	s35pqIxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSj9-0000000HO61-04rf;
	Thu, 18 Jul 2024 15:07:27 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSj5-0000000HO0M-05AL
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 15:07:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CBE786132F;
	Thu, 18 Jul 2024 15:07:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C61AC4AF12;
	Thu, 18 Jul 2024 15:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721315242;
	bh=Kz6t8QHGsL1k83Nzwb4v/wR+JKXkW8BHMXW4LA3lMHk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pw3t733Uj6SADDD/ONCMWJx8M0GhfQQ8a8Dor5bjzGPW4Hi3A3c7AEC5f0tnqzAkc
	 8H34KXpb8657VVlXsnDobqDbem/VVkOnUiXOa2zs0/lZxnnd2jqEkW3xXtlhG+OLPx
	 16QQnKoqL+kheYsFySjoi4HDSVmToHYCvshoNtKkKANYAixU+JlSDPrEicY4xv3Nbc
	 SjTMsv45khyNnCFtbPyhYeY+f1LWmq85aJdDK0bnt/+heM8KUR+1z40iZGiLP9nfh7
	 A8XGW2XQ8x7cp2089swVt9iJC8jqZ8waz4//6lEU/qhCr3n06DOVt3Ki03JSZuc5Ep
	 RKrlnlyFSEmAg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 5/8] nvme-keyring: add nvme_tls_psk_refresh()
Date: Thu, 18 Jul 2024 17:06:55 +0200
Message-Id: <20240718150658.99580-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240718150658.99580-1-hare@kernel.org>
References: <20240718150658.99580-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_080723_211441_F338AD2B 
X-CRM114-Status: GOOD (  12.47  )
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
index 5b886fd6c3e7..9e847c3ee820 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -123,6 +123,56 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
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
index e092e3e6ffb2..65400c89bde5 100644
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


