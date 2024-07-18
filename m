Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57123C3DA49
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 14:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IObcVW1TfaE10TMnRMNmeU6Lcc3/T4KtGdcWTCupPic=; b=DJyG7SWdY7BvwryGquVA6pCzzf
	PK2ewdPVhxTkLMUZt6dfvv1Yo1FrFme9n6+ZoFFbGlw3oKWSLM3zN9wo325fHW8Xlbduue24JTv0O
	cnKbIRMLwVljtkvhv4ZeEzTRV+yZIzIaxnjennKO3he4IxV15qLIjc/Ghm27sYgeOgnmPPIyz4MAi
	oZVbxmugu0HQ6WRAimjQVJIf8Ckf2ie0KHq2YD4WxIvo2OmzrLyyyTotHQIg4MwbEeNwfZ8j78aiY
	9gFo8Tfc2J4dE3FRiqkc2fDrmezIqrpe3Eak6Wy3yT2AX5G4LYRW/hdwdyOjFetd+i9WyNTBIfuK2
	/RSsXzYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSRd-0000000HKM5-0iO9;
	Thu, 18 Jul 2024 14:49:21 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSRa-0000000HKL9-17nt
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 14:49:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8EE9E61B8A;
	Thu, 18 Jul 2024 14:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AD1C4AF0A;
	Thu, 18 Jul 2024 14:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721314157;
	bh=D06q7VmFz0+qhJMZwCqD7ljku6z7O03McmfKWIfZThM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AqmuWScz/MYVZEpgdxFbBXNwe1+FfnAr3SNVgaxSf3juPMI61Xllq9b5e6mAWgKx2
	 g6Cq082g7KK9tB542SR3roVMNhZVl+QFubELUybxfSDm2b5Zesi/2eyiVxcjgE5rCA
	 e4YP7246EvuD+e2bQ4W+r6zaRx/cpYHoXQwQlmluo1un/OEICXPaNZJXauFRUWro3B
	 o3d5G7ogNXRwnIr3KqIxUyT+kf7vCDws/cUNNn0mpwPG4bHQ9H4S9govXeTqS51CID
	 IJkFirXPfhhU7PE+gtNhtndfL+J8WDI+B+WvssoYTlvN6+2g/fDKYiHTA12P18D+o1
	 M+fijm/njJLog==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 1/8] nvme-keyring: restrict match length for version '1' identifiers
Date: Thu, 18 Jul 2024 16:48:51 +0200
Message-Id: <20240718144858.19074-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240718144858.19074-1-hare@kernel.org>
References: <20240718144858.19074-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_074918_458374_2A86CC7A 
X-CRM114-Status: GOOD (  13.74  )
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
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


