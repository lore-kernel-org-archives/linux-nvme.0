Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7CEC369D5
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 11:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6lCS+ndGW2WApLq47VbMNaB9Og/pkmX+BmFH28FeMlM=; b=MREIq9zpZIQxaL27MmJKrueXH5
	pRJ04+uaUgze0xj/JCkwYXb75kC0nwfvbJea04Y1Qr/jRy5ty/5nsnxffRXZ43IkTQynneimbmDS3
	sQ92Qg+K61b6xQbbK2zc/e3d6/srIOMHr/5j03mFxpECzHtQdnGbG2GWXjUnesh+r74oTnat0/bDf
	N9DMMU7+c6GGUdEPFMwiixq8RPPZ25xCHu/U1iQ82WPhA3vAyfEdea2UhCtv9ZnZRDa8t6rzdVgUZ
	GsolbgEJyuEHnjho7cwmvSuLgINKHZZ7aJo2QYiHuj69EsLYVIA2cTm0g9QFnmVnu2ESqcMZVI3az
	tWaZOTjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8H0W-0000000GtYM-1vhG;
	Fri, 25 Apr 2025 11:14:12 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Fgx-0000000GbtY-33uV
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 09:49:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id C7B2CA4D119;
	Fri, 25 Apr 2025 09:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1DEC4CEE4;
	Fri, 25 Apr 2025 09:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745574594;
	bh=qOSOMsGEvj4+SpvQS+SEV/KanzSG+IylvwzfXJcCfAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MTZJqc0Asyz5c/DYzfMN9sEGex9Dg+XAMNksJ9/L2xaQnXkyjt5Tmo7rTqFNanAVY
	 EjDJBKTPaK+veMnFfnNQULFqtYs3IHVFnhRgNSXrXcVNDpeJmABqgVabZT55VeJQTF
	 /8R1sbgxlZC88twWeDbvctz4H0V3En3mUmCi/OYwMsAGY+bwg9OIKst3mobAM1lBo3
	 RcWfRRrXANLporkqgTnUzr6tK2FPRQa0RexbppK65bRcY6GCalBU9U9iRO/8g1mKYz
	 O6vKqBKYHcXo89HEZxmoCG53Kp7tgm2vbzPb+FaceZpRsogbFHfFI33KR+8+7ZBjnz
	 WW1TUhOXYas7A==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 07/12] nvme-auth: drop nvme_dhchap_key structure and unused functions
Date: Fri, 25 Apr 2025 11:49:22 +0200
Message-Id: <20250425094927.102656-8-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250425094927.102656-1-hare@kernel.org>
References: <20250425094927.102656-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_024955_828897_448EFA70 
X-CRM114-Status: UNSURE (   9.02  )
X-CRM114-Notice: Please train this message.
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

Drop the hand-crafted nvme_dhchap_key structure and the now unused
functions.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/auth.c | 29 -----------------------------
 include/linux/nvme-auth.h  |  9 ---------
 2 files changed, 38 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 74763de526c3..8c2ccbfb9986 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -155,14 +155,6 @@ size_t nvme_auth_hmac_hash_len(u8 hmac_id)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
 
-u32 nvme_auth_key_struct_size(u32 key_len)
-{
-	struct nvme_dhchap_key key;
-
-	return struct_size(&key, key, key_len);
-}
-EXPORT_SYMBOL_GPL(nvme_auth_key_struct_size);
-
 struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret,
 				  size_t secret_len)
 {
@@ -176,27 +168,6 @@ struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret,
 }
 EXPORT_SYMBOL_GPL(nvme_auth_extract_key);
 
-struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash)
-{
-	u32 num_bytes = nvme_auth_key_struct_size(len);
-	struct nvme_dhchap_key *key = kzalloc(num_bytes, GFP_KERNEL);
-
-	if (key) {
-		key->len = len;
-		key->hash = hash;
-	}
-	return key;
-}
-EXPORT_SYMBOL_GPL(nvme_auth_alloc_key);
-
-void nvme_auth_free_key(struct nvme_dhchap_key *key)
-{
-	if (!key)
-		return;
-	kfree_sensitive(key);
-}
-EXPORT_SYMBOL_GPL(nvme_auth_free_key);
-
 int nvme_auth_transform_key(struct key *key, char *nqn,
 			    u8 **transformed_secret)
 {
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index bb973b39fd79..4e53ef96eea7 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -8,12 +8,6 @@
 
 #include <crypto/kpp.h>
 
-struct nvme_dhchap_key {
-	size_t len;
-	u8 hash;
-	u8 key[];
-};
-
 u32 nvme_auth_get_seqnum(void);
 const char *nvme_auth_dhgroup_name(u8 dhgroup_id);
 const char *nvme_auth_dhgroup_kpp(u8 dhgroup_id);
@@ -24,10 +18,7 @@ const char *nvme_auth_digest_name(u8 hmac_id);
 size_t nvme_auth_hmac_hash_len(u8 hmac_id);
 u8 nvme_auth_hmac_id(const char *hmac_name);
 
-u32 nvme_auth_key_struct_size(u32 key_len);
 struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret, size_t secret_len);
-void nvme_auth_free_key(struct nvme_dhchap_key *key);
-struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash);
 int nvme_auth_transform_key(struct key *key, char *nqn,
 			    u8 **transformed_secret);
 int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
-- 
2.35.3


