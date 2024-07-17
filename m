Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27B1C3DA5E
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 09:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6ec+XCjxdXNHB8ze60moCXP//kcVNH1MGcGIb3quWek=; b=W4aQ4dxuQrrWSE8ILtvhAcmxEj
	CFJOlbDbcmOKTEJp2VVcucDLneJKvIVGKsgDRO39z7B5pdb7Oo6sv52URGZORo4Vg0hMlYzeUeC8w
	V1nnDZ7cIfoNO6228mb8yiZuZww9qRCZEHEzdr7y4ITM/IuOq6bw3+fhx0licX5JjRxHF9IECu1V+
	Irh6vzGJoQB756Msc5aG94OpH2i0TMS22gL8LQ1NWGd6IwbI8ck6mM6q5mAd7UtoLAuBgPjlS+qEn
	ap9JpIRjE6IW0w+8Hy0JOaxgg8fba6m3rg1b1A2Nzxd7m5WyBCQPH3lJJGlvyjgQsCd/4CCSrUIyN
	zol18lXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0gU-0000000DFnT-2B1m;
	Wed, 17 Jul 2024 09:10:50 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0gP-0000000DFkp-1uh7
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 09:10:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id AD133CE1412;
	Wed, 17 Jul 2024 09:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A83C1C4AF0C;
	Wed, 17 Jul 2024 09:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721207442;
	bh=x7QNzqD1alj+sVP8O5TofornRkgITPT7OTgUdGe4t1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NMg3pCUf/pnsp59DAk+jXPdkEM7XkcSTFqDjMR1rb9t4eyWCR6jQ65chi6n1FKfOZ
	 WGWqrhYLazPAwGrmQwnXjXCg+khHe9Z5O4v9+InoaDPieJhHI7+Z5CYo/0KUJu6kzs
	 MBBniycnWeGSFs1ZbBH0pKW7krJ4VRfH0505YtG6bUgpNcxD3oPpda0Ti1U9HHrEgZ
	 LClqCG5e6jWoj49UDvaGb2qhJmiRFeugVKJUf+iPlsjAXKwoZ15TU7/pTwPK3veFfT
	 PtUQd9je2Ld8aJ2urYWKau439V9lrTIgYNEyB9/McdHtP4ldcWaC/Lvpb2uzviMhvS
	 EtunIRtSE1LhA==
From: Hannes Reinecke <hare@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 01/16] nvme-keyring: restrict match length for version '1' identifiers
Date: Wed, 17 Jul 2024 11:10:16 +0200
Message-Id: <20240717091031.143188-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240717091031.143188-1-hare@kernel.org>
References: <20240717091031.143188-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_021045_869162_E29D3A8D 
X-CRM114-Status: GOOD (  14.36  )
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

TP8018 changed the TLS PSK identifiers to append a PSK hash value,
so to lookup identifiers we should just consider the length of
the match value, not the length of the identifiers to compare
against.
And we should modify the PSK lookup algorithm to prefer v1 identifiers
as they can be uniquely identified.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/keyring.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 6f7e7a8fa5ae..c60ebbdc52b8 100644
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


