Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A0DC761A6
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 14:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zIlKBCvZnnFSpLxdtSMe21cs7oxaIKNwHC0FhDvCxgM=; b=dz8eS6ugFxrzrQQgK/VY710ns6
	Dc44JXzW10fjiRCVufm/TfhrRqnD230jYdOJT0Zk8CxEUUFquJYlNFIJNplqfI0fy9yxnlgI1wuA7
	VyIbUFTwuKN5XdGALDAHsgocA2LiuaFhBkh9kSdjw3S7uYcTHZ5u48tNGuF61hLTQL86h/1EYCPJR
	e5C7keRznebHYvUAu8Frh/O4QYmzOyKxzlrLL6Hn6XE+/1soawzHgQN/YpmpmrdxNnR3Kr9yx1L/c
	dskzZkYMwHLhioVf8y2dDo+/PIkSLy6LswdZqSRsDLNBEM67EY048IBWWOgQZFnpiay+bavSNy4Y8
	VHkg29dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLP-000UsA-0z;
	Wed, 29 Mar 2023 14:00:07 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLD-000Uh2-2T
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 13:59:58 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id BE0541FDDF;
	Wed, 29 Mar 2023 13:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680098389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zIlKBCvZnnFSpLxdtSMe21cs7oxaIKNwHC0FhDvCxgM=;
	b=MQLgKsOXCRoKiYcE6kVujeEIuyQ6YPFEoOLFH5MOgFxgWLIChP25RkqFrq528gb/dmc8L/
	7wFEBoIaMT+kyGZugZNRgy6CDZj6hRym4+M7H+jkKWBC4bk+EHGkSqxt0yNGbAZGZwh3wn
	TPg9B66xJFakXsGfRtn6vPEf+Yq8/CU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680098389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zIlKBCvZnnFSpLxdtSMe21cs7oxaIKNwHC0FhDvCxgM=;
	b=Zpmyuse0XwYv4T/D0b9OEVKhfqTvSd1RXVdLCyvNhNln6gQ00wyd2dJLN1unPzLCIjjhGw
	Qp+Hhr9WBQ1Wi9Dg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id A94FA2C177;
	Wed, 29 Mar 2023 13:59:49 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id A340851BF380; Wed, 29 Mar 2023 15:59:49 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 07/18] nvme-keyring: implement nvme_tls_psk_default()
Date: Wed, 29 Mar 2023 15:59:27 +0200
Message-Id: <20230329135938.46905-8-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329135938.46905-1-hare@suse.de>
References: <20230329135938.46905-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_065955_998518_98CF4582 
X-CRM114-Status: GOOD (  12.42  )
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

Implement a function to select the 'best' PSK for TLS.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/common/keyring.c | 47 +++++++++++++++++++++++++++++++++++
 include/linux/nvme-keyring.h  |  2 ++
 2 files changed, 49 insertions(+)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 4ac33538f839..ca36a061bd48 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -103,6 +103,53 @@ struct key *nvme_tls_psk_lookup(struct key *keyring,
 }
 EXPORT_SYMBOL_GPL(nvme_tls_psk_lookup);
 
+/*
+ * NVMe PSK priority list
+ *
+ * 'Retained' PSKs (ie 'generated == false')
+ * should be preferred to 'generated' PSKs,
+ * and SHA-384 should be preferred to SHA-256.
+ */
+struct nvme_psk_priority_list {
+	bool generated;
+	enum nvme_tcp_tls_cipher cipher;
+} nvme_psk_prio[] = {
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
+ * nvme_tls_psk_default - Return 'best' PSK to use for TLS ClientHello
+ */
+key_serial_t nvme_tls_psk_default(struct key *keyring,
+		      const char *hostnqn, const char *subnqn)
+{
+	struct key *tls_key;
+	key_serial_t tls_key_id;
+	int prio;
+
+	for (prio = 0; prio < ARRAY_SIZE(nvme_psk_prio); prio++) {
+		bool generated = nvme_psk_prio[prio].generated;
+		enum nvme_tcp_tls_cipher cipher = nvme_psk_prio[prio].cipher;
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
index 5be60485ddfa..5293e0a90167 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -9,6 +9,8 @@
 struct key *nvme_tls_psk_lookup(struct key *keyring,
 				const char *hostnqn, const char *subnqn,
 				int hmac, bool generated);
+key_serial_t nvme_tls_psk_default(struct key *keyring,
+				  const char *hostnqn, const char *subnqn);
 
 key_serial_t nvme_keyring_id(void);
 
-- 
2.35.3


