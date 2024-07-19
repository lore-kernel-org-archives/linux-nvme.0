Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 334D4C3DA59
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 08:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wn6gvqL117m7iHZnz2A5rXQ12R2zJY6efojGHouPQgI=; b=WKyP7ykKsF/HqdKca7aR9wgrkN
	i82XTpYdbzXR5JdGDOn0FpmpmPNu9sHvpwXQA6fyR61one4xUDMBgkY6JsjPZOb/meyC9OdBZLdxr
	eVQYoXHHSaG2k3EEsEW7fYZmWgn7VeuoNJXwpHwAngjY3DKMvW7kuu9lNcb7F1WzbAQ5YxGKizied
	HNV4GFm23C3vN3gAGP52G+1kld0Or8lAGMiH8egatdSNe0C1bOYCTCmcfFdPEd4fNV6C5SU8tJ0Cm
	KXBFAzwub+26cteREcPWasvQYc84t9K1KdsOxj+He30qU0B/y92wuhvS2SDKdcoWM/DhcxPDY2MsA
	R5kb5mLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUj96-000000026Dq-442R;
	Fri, 19 Jul 2024 08:39:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUj92-000000026CI-454o
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 08:39:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1DC1C61C3A;
	Fri, 19 Jul 2024 08:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8492EC32782;
	Fri, 19 Jul 2024 08:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721378355;
	bh=g4p7QAgZiXZ18GnTV24ezqWyOj4Bh1akAhrXWAD6S2A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m1nCzXrPDL86G+pkKi6NwIvumWEkXyYeofJGzjQl95ATKj8spw5aEO6xmY9b26VNT
	 AqUTpKiI2S9lb3gzNynmY/c1H6aRgjzQ98UujaSkgHBY1qdTxvp0hTw9nH98/Du4WY
	 XABjC5Rn76CGnbBZ6IOGcLeR7kfvnmkCy2rppwm7wc5k3ZycN+XU6HzfmslrJIem2E
	 vfDWpac+qzp+S2d0d4ZLC0+jv02FeD2mdcyps1pZPMzcVDIjitCz1MS76+YvBMb88c
	 kdrs6wzqbwPcNEzGLp2flxXlM/jwXlzngCJ8mOZWumatfnsGhao2apUiJKHEju0TiD
	 G+ujFHzG9dK3Q==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/9] nvme-keyring: restrict match length for version '1' identifiers
Date: Fri, 19 Jul 2024 10:38:53 +0200
Message-Id: <20240719083901.35399-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240719083901.35399-1-hare@kernel.org>
References: <20240719083901.35399-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240719_013917_134275_B091F3BF 
X-CRM114-Status: GOOD (  15.10  )
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

TP8018 introduced a new TLS PSK identifier version (version 1), which appended
a PSK hash value to the existing identifier (cf NVMe TCP specification v1.1,
section 3.6.1.3 'TLS PSK and PSK Identity Derivation').
An original (version 0) identifier has the form:

NVMe0<type><hmac> <hostnqn> <subsysnqn>

and a version 1 identifier has the form:

NVMe1<type><hmac> <hostnqn> <subsysnqn> <hash>

This patch modifies the lookup algorthm to compare only the first part
of the identifier (excluding the hash value) to handle both version 0 and
version 1 identifiers.
And the spec declares 'version 0' identifiers obsolete, so the lookup
algorithm is modified to prever v1 identifiers.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/common/keyring.c | 36 +++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 6f7e7a8fa5ae..05e89307c8aa 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -36,14 +36,12 @@ static bool nvme_tls_psk_match(const struct key *key,
 		pr_debug("%s: no key description\n", __func__);
 		return false;
 	}
-	match_len = strlen(key->description);
-	pr_debug("%s: id %s len %zd\n", __func__, key->description, match_len);
-
 	if (!match_data->raw_data) {
 		pr_debug("%s: no match data\n", __func__);
 		return false;
 	}
 	match_id = match_data->raw_data;
+	match_len = strlen(match_id);
 	pr_debug("%s: match '%s' '%s' len %zd\n",
 		 __func__, match_id, key->description, match_len);
 	return !memcmp(key->description, match_id, match_len);
@@ -71,7 +69,7 @@ static struct key_type nvme_tls_psk_key_type = {
 
 static struct key *nvme_tls_psk_lookup(struct key *keyring,
 		const char *hostnqn, const char *subnqn,
-		int hmac, bool generated)
+		u8 hmac, u8 psk_ver, bool generated)
 {
 	char *identity;
 	size_t identity_len = (NVMF_NQN_SIZE) * 2 + 11;
@@ -82,8 +80,8 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
 	if (!identity)
 		return ERR_PTR(-ENOMEM);
 
-	snprintf(identity, identity_len, "NVMe0%c%02d %s %s",
-		 generated ? 'G' : 'R', hmac, hostnqn, subnqn);
+	snprintf(identity, identity_len, "NVMe%u%c%02u %s %s",
+		 psk_ver, generated ? 'G' : 'R', hmac, hostnqn, subnqn);
 
 	if (!keyring)
 		keyring = nvme_keyring;
@@ -107,21 +105,38 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
 /*
  * NVMe PSK priority list
  *
- * 'Retained' PSKs (ie 'generated == false')
- * should be preferred to 'generated' PSKs,
- * and SHA-384 should be preferred to SHA-256.
+ * 'Retained' PSKs (ie 'generated == false') should be preferred to 'generated'
+ * PSKs, PSKs with hash (psk_ver 1) should be preferred to PSKs without hash
+ * (psk_ver 0), and SHA-384 should be preferred to SHA-256.
  */
 static struct nvme_tls_psk_priority_list {
 	bool generated;
+	u8 psk_ver;
 	enum nvme_tcp_tls_cipher cipher;
 } nvme_tls_psk_prio[] = {
 	{ .generated = false,
+	  .psk_ver = 1,
+	  .cipher = NVME_TCP_TLS_CIPHER_SHA384, },
+	{ .generated = false,
+	  .psk_ver = 1,
+	  .cipher = NVME_TCP_TLS_CIPHER_SHA256, },
+	{ .generated = false,
+	  .psk_ver = 0,
 	  .cipher = NVME_TCP_TLS_CIPHER_SHA384, },
 	{ .generated = false,
+	  .psk_ver = 0,
+	  .cipher = NVME_TCP_TLS_CIPHER_SHA256, },
+	{ .generated = true,
+	  .psk_ver = 1,
+	  .cipher = NVME_TCP_TLS_CIPHER_SHA384, },
+	{ .generated = true,
+	  .psk_ver = 1,
 	  .cipher = NVME_TCP_TLS_CIPHER_SHA256, },
 	{ .generated = true,
+	  .psk_ver = 0,
 	  .cipher = NVME_TCP_TLS_CIPHER_SHA384, },
 	{ .generated = true,
+	  .psk_ver = 0,
 	  .cipher = NVME_TCP_TLS_CIPHER_SHA256, },
 };
 
@@ -137,10 +152,11 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
 
 	for (prio = 0; prio < ARRAY_SIZE(nvme_tls_psk_prio); prio++) {
 		bool generated = nvme_tls_psk_prio[prio].generated;
+		u8 ver = nvme_tls_psk_prio[prio].psk_ver;
 		enum nvme_tcp_tls_cipher cipher = nvme_tls_psk_prio[prio].cipher;
 
 		tls_key = nvme_tls_psk_lookup(keyring, hostnqn, subnqn,
-					      cipher, generated);
+					      cipher, ver, generated);
 		if (!IS_ERR(tls_key)) {
 			tls_key_id = tls_key->serial;
 			key_put(tls_key);
-- 
2.35.3


