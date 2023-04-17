Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3999C77B72
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 13:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LDukVeTcAcyShCFS4ee6afRX8c+3sxfriXRpHY74zEU=; b=QUdBErx4IucLMPvz7FmBRzm8fD
	VTtFufoKhPLu4LLi5tx1kaLrrKVf88OjXDXRlclhRNRRxUOQZ0wjIwZz08yTHCQcQRz6CRzBQNznL
	/P8luD9ZwzkuErgHyteZEVL6ZN0Jan2nVu3wjXYHfS/MSO3y7SIIfmQDTk/a7ENEHmMd1ixs5NDvG
	B5hUuLxQx0va2XI3TCxjLgpHCEcf1ovhI1PcrgG0sIi1n5JKL/uFG8sK4uJtkSgyVmU9mvoCP90Gz
	DI49UDcGFlspx8DwJmaXJoXFGXj0xEzgEDBNk1k1K8s3Yf3E3fRC78oLn7WOYtjOQHpOX1KeFxlwH
	26hWyNSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poOVz-00GI6u-3D;
	Mon, 17 Apr 2023 13:03:28 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poOVi-00GHps-0R
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 13:03:18 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 2F5261FE0D;
	Mon, 17 Apr 2023 13:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681736584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDukVeTcAcyShCFS4ee6afRX8c+3sxfriXRpHY74zEU=;
	b=mX7+YKsxVz/20yxg7jCG26B/Qmh0zHJzF+iP3EXK+cOKPJZuphjYskBmItzhp9EoX1glKA
	xT4PoynjiNTr34shxqc/ohK9KafRKQfU5Eplb29RfjM7R4zfNYrElB1+r6v1Jp6/0c0G7L
	YAnIOGxKqlb57Ud63mDLZIUbgXWljOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681736584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LDukVeTcAcyShCFS4ee6afRX8c+3sxfriXRpHY74zEU=;
	b=f83ee9do47L1ZQqgs60Jj3W8U4a1SftvqEBKjTRqHMFEKWyQ+Aei4pNyoft9L4SbQvG2Yg
	rysbhFBwseZ+wFAg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 1B2592C14E;
	Mon, 17 Apr 2023 13:03:04 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 0A07E51C25A4; Mon, 17 Apr 2023 15:03:04 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 05/18] nvme-keyring: implement nvme_tls_psk_default()
Date: Mon, 17 Apr 2023 15:02:49 +0200
Message-Id: <20230417130302.86274-6-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230417130302.86274-1-hare@suse.de>
References: <20230417130302.86274-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_060310_340508_BE54CEC8 
X-CRM114-Status: GOOD (  13.89  )
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

Signed-off-by: Hannes Reinecke <hare@suse.de>
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


