Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88CFDC54E58
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 15:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Jtr+9Y8ROMUdpKWPnjKANyOam/EHL6pREUmS/AWnCbY=; b=kUGIdsx+keP78Copg4IXzJ1voM
	EnKlkNTv3BOmDvFsfATQZwmysJcAXWwtbQUPmZk3wGma3/dIme7Q7/7pq8f4N7RJpABlqPXBLv0oR
	iJy06mATcIGL14IbrIAIHVD8mkiAPcBpvcvuyxLiPWnwfOp+Sdz+X+euaU/vaDhtO/koK2vWKSBP5
	2kHol1vQ4WCirBEO3x18ITgOjPaD4JTJj96YKgZWJhj0lx2mlmVHlTEoTRU3FYHlD/N5XZbG8wha2
	rPCDgpoBzmRb2WkwIUYAFDWc1+86uivD/nOvg87By0zygvnvpu3qMwBRtXDQE8yPhZapvJ2BhJLqp
	VQUQVyUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWZ-00000008uFg-07AK;
	Mon, 18 Mar 2024 15:03:39 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWV-00000008uDc-3qQA
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 15:03:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 48456CE0A3C;
	Mon, 18 Mar 2024 15:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A43C43394;
	Mon, 18 Mar 2024 15:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710774211;
	bh=MrqVKVgC3eAH1AinVcVev0XUyD7okPyJQj3a0RlmNN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aVL/bU7YZxeUHfueT3dkg+vae9gJ/W+GZOZdAmBYfGzoqLWJ0ngy7WNVdMYyltkqz
	 4MTO6YY3SdQvt++Je0dnhwlKdgwglOYqmpVyoXnnRvwukoacSOBHQ40A0X4UtkHETx
	 M1CWenSXGRW30W1f60qY+TVzcw32S09UnavvLr1LZg7NFPmwOdcygj4vqEeBWss9ni
	 29fhxruAZlv2u44mt/ng68nGe4/CK/OjshB7yC3DL0TRC4rbDREp9AzTgYUbwGwh1r
	 C4Zfkj4uh7Gk9tmULPvrk+uB6FzH4G0OG9H7BzmiSj/S2+TTUGNT4CQEzR0QOVH8SI
	 F2XmDvBwzFFOg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 01/17] nvme-keyring: restrict match length for version '1' identifiers
Date: Mon, 18 Mar 2024 16:03:00 +0100
Message-Id: <20240318150316.138501-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240318150316.138501-1-hare@kernel.org>
References: <20240318150316.138501-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_080336_393194_63791FBE 
X-CRM114-Status: GOOD (  14.73  )
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

TP8018 changed the TLS PSK identifiers to append a PSK hash value,
so to lookup any version '1' identifiers we need to restrict the
match length to exclude the PSK hash value (which we don't have
when looking up keys).

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/common/keyring.c | 34 ++++++++++++++++++++++++++--------
 1 file changed, 26 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 6f7e7a8fa5ae..2beac89b2246 100644
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
@@ -79,11 +77,11 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
 	key_serial_t keyring_id;
 
 	identity = kzalloc(identity_len, GFP_KERNEL);
-	if (!identity)
+	if (WARN_ON(!identity))
 		return ERR_PTR(-ENOMEM);
 
-	snprintf(identity, identity_len, "NVMe0%c%02d %s %s",
-		 generated ? 'G' : 'R', hmac, hostnqn, subnqn);
+	snprintf(identity, identity_len, "NVMe%u%c%02u %s %s",
+		 psk_ver, generated ? 'G' : 'R', hmac, hostnqn, subnqn);
 
 	if (!keyring)
 		keyring = nvme_keyring;
@@ -109,19 +107,38 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
  *
  * 'Retained' PSKs (ie 'generated == false')
  * should be preferred to 'generated' PSKs,
+ * PSKs with hash (psk_ver 1) should be
+ * preferred to PSKs without (psk_ver 0),
  * and SHA-384 should be preferred to SHA-256.
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
 
@@ -137,10 +154,11 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
 
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


