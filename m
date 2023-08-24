Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E816DC7EE2C
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Aug 2023 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oa36kjhIvJTxwAHm0GK8Afk1tL9+tuRbCuSsAg+bQ6g=; b=2ChvI8UrdcbarftstUMOc7l1Hq
	qLA6FlXeGiQAPD3GsP2XzroqBjwxjU8P9ZcaxucYmOR3jgAeRsOgbgKJqSQtEZI6DvEeI/CstFpWj
	qzd9uj/NOMhH68nKwa5+RSZAMh/F9tkvzcqIQpJpdi/WI3qoMvWVb/II2iLF7EPUQb2I1z3beWs6n
	YwYtFGAuQ6c715OTBREGbtrk8UORIXo7y4LnjRr/5PZWlrlpgwA8cSuLd58qzJ0ym7HwKzr8JTbnd
	xIj870QPyK+eMjYIHVpR0Q7J3gGsDGjO1sPvWmAT30xDlrE4VWgWOsspWU614icxn2QqXD/esVIcD
	KwrULOKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qZBUr-003FM8-0E;
	Thu, 24 Aug 2023 14:39:41 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qZBUi-003FCw-1O
	for linux-nvme@lists.infradead.org;
	Thu, 24 Aug 2023 14:39:34 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id BB91020732;
	Thu, 24 Aug 2023 14:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692887966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oa36kjhIvJTxwAHm0GK8Afk1tL9+tuRbCuSsAg+bQ6g=;
	b=O1ZU50VREt9WMHNSxzMH3QHqG1+896302nyamG5Cqg0u4ijwDWMxjEiUcsiAiuUxvCmeag
	nap5XateFOgwu6Td/bq6mBtYGd9V3kKBm7woA3XNDWH0D6nLD9Ny4YcR/2R7J8PiFdEV0v
	FkLGJM/FGKYB5RZFmzLyYSFTS2Bc1Vk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692887966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oa36kjhIvJTxwAHm0GK8Afk1tL9+tuRbCuSsAg+bQ6g=;
	b=IuyVvxVo6iFQoWfBCWAiUUpI8OJcamzxwlVv7Ij36p9Gi/i3UnjxjKG6BldRD8YtnDV19B
	eOEKsNgQj14G0bCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id B2E2A2C14E;
	Thu, 24 Aug 2023 14:39:26 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id AD3AF51CB8C1; Thu, 24 Aug 2023 16:39:26 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 05/18] nvme-keyring: implement nvme_tls_psk_default()
Date: Thu, 24 Aug 2023 16:39:12 +0200
Message-Id: <20230824143925.9098-6-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230824143925.9098-1-hare@suse.de>
References: <20230824143925.9098-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230824_073932_634009_63AB135B 
X-CRM114-Status: GOOD (  13.32  )
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

Implement a function to select the preferred PSK for TLS.
A 'retained' PSK should be preferred over a 'generated' PSK,
and SHA-384 should be preferred to SHA-256.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/common/keyring.c | 48 +++++++++++++++++++++++++++++++++++
 include/linux/nvme-keyring.h  |  8 ++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 494dd365052e..f8d9a208397b 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -5,6 +5,7 @@
 
 #include <linux/module.h>
 #include <linux/seq_file.h>
+#include <linux/key.h>
 #include <linux/key-type.h>
 #include <keys/user-type.h>
 #include <linux/nvme.h>
@@ -103,6 +104,53 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
 	return key_ref_to_ptr(keyref);
 }
 
+/*
+ * NVMe PSK priority list
+ *
+ * 'Retained' PSKs (ie 'generated == false')
+ * should be preferred to 'generated' PSKs,
+ * and SHA-384 should be preferred to SHA-256.
+ */
+struct nvme_tls_psk_priority_list {
+	bool generated;
+	enum nvme_tcp_tls_cipher cipher;
+} nvme_tls_psk_prio[] = {
+	{ .generated = false,
+	  .cipher = NVME_TCP_TLS_CIPHER_SHA384, },
+	{ .generated = false,
+	  .cipher = NVME_TCP_TLS_CIPHER_SHA256, },
+	{ .generated = true,
+	  .cipher = NVME_TCP_TLS_CIPHER_SHA384, },
+	{ .generated = true,
+	  .cipher = NVME_TCP_TLS_CIPHER_SHA256, },
+};
+
+/*
+ * nvme_tls_psk_default - Return the preferred PSK to use for TLS ClientHello
+ */
+key_serial_t nvme_tls_psk_default(struct key *keyring,
+		      const char *hostnqn, const char *subnqn)
+{
+	struct key *tls_key;
+	key_serial_t tls_key_id;
+	int prio;
+
+	for (prio = 0; prio < ARRAY_SIZE(nvme_tls_psk_prio); prio++) {
+		bool generated = nvme_tls_psk_prio[prio].generated;
+		enum nvme_tcp_tls_cipher cipher = nvme_tls_psk_prio[prio].cipher;
+
+		tls_key = nvme_tls_psk_lookup(keyring, hostnqn, subnqn,
+					      cipher, generated);
+		if (!IS_ERR(tls_key)) {
+			tls_key_id = tls_key->serial;
+			key_put(tls_key);
+			return tls_key_id;
+		}
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_tls_psk_default);
+
 int nvme_keyring_init(void)
 {
 	int err;
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index 32bd264a71e6..4efea9dd967c 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -8,12 +8,20 @@
 
 #ifdef CONFIG_NVME_KEYRING
 
+key_serial_t nvme_tls_psk_default(struct key *keyring,
+		const char *hostnqn, const char *subnqn);
+
 key_serial_t nvme_keyring_id(void);
 int nvme_keyring_init(void);
 void nvme_keyring_exit(void);
 
 #else
 
+static inline key_serial_t nvme_tls_psk_default(struct key *keyring,
+		const char *hostnqn, const char *subnqn)
+{
+	return 0;
+}
 static inline key_serial_t nvme_keyring_id(void)
 {
 	return 0;
-- 
2.35.3


