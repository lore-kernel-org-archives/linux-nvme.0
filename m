Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A9A3C46CA1
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Oct 2023 23:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6/WfLtWJ8SSAzBorKpSrBXyPEPnT0M4T7RZHpiUYJc8=; b=rQPUjiFvzs/sqMmDF743r1thiu
	ajIzijNMRjnZ3V4CeLGXDvk6alNtLPDMp0lEOizKIItwASDEldVHdzd9VYXnvafZ3yF65HJY4Rv6E
	2fSBwPspjavkit5JbQ1rCwW5t0KJFQep7Uwmkt/BTgFEflil/3ozWoH5VRkqnoXDdgsEFIjly1RbI
	GTN+5k9W2WWgcI/TkxwKG//oRo95vuEN+cWUj0TDMh6nv9J//elUkI76WjDg0tpAj0u/pZnO1P1L9
	wfxyop7+4qaf6mWL9SNYKGzhYkaHRP3cZST4qq3UW8I1HVUuzeQ9MzIuZ2v3gP6XLLfq2VoWK6KnC
	QRZV2Usw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsWZ7-00AmRo-35;
	Mon, 16 Oct 2023 23:00:01 +0000
Received: from mout02.posteo.de ([185.67.36.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsWZ4-00AmPo-0A
	for linux-nvme@lists.infradead.org;
	Mon, 16 Oct 2023 22:59:59 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id EFD3F240101
	for <linux-nvme@lists.infradead.org>; Tue, 17 Oct 2023 00:59:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1697497196; bh=rnbADe6m90A07GERJn789AJyLmRj2m+LZ1+95wztGA4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=Jh5UDJJDwz543riptIZiaIlXKxwqO2SN1Q1V4cGEbYu1Agz/0ga4sKyIegpitZdnN
	 MQZXCjVcZans1EzSX9QLZ1MyhbX8wrfGn5qEUOI+BXTvthMCFdCEJVEPx6F0nH8J5z
	 udKowcI8GDPfQNUGyMw8jULBGKNijrF2IP6wvMFMKrBZpRjd9kDu8zYP9ZWPnhiMYi
	 TziYQT8sxADAQxTxE6Htmcn/+B6MKcwE9QUH/VNRJHyiczu0CD5ooOaSrryBvpz0PA
	 cQnJJq+VVGBlSM/r3sAKexhOHeoEE3QOSAA18pFDxz7i4CBJUiLW4WlH8xgJZDiHc5
	 HF4qQjPO3j60g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4S8Xcp34TVz9rxK;
	Tue, 17 Oct 2023 00:59:54 +0200 (CEST)
From: Mark O'Donovan <shiftee@posteo.net>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de,
	axboe@kernel.dk,
	kbusch@kernel.org,
	hare@suse.de,
	Mark O'Donovan <shiftee@posteo.net>,
	Akash Appaiah <Akash.Appaiah@dell.com>
Subject: [PATCH v3 1/3] nvme-auth: alloc nvme_dhchap_key as single buffer
Date: Mon, 16 Oct 2023 22:58:55 +0000
Message-Id: <20231016225857.3085234-2-shiftee@posteo.net>
In-Reply-To: <20231016225857.3085234-1-shiftee@posteo.net>
References: <20231016225857.3085234-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_155958_407452_C077CD3D 
X-CRM114-Status: GOOD (  10.88  )
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

Co-developed-by: Akash Appaiah <Akash.Appaiah@dell.com>
Signed-off-by: Akash Appaiah <Akash.Appaiah@dell.com>
Signed-off-by: Mark O'Donovan <shiftee@posteo.net>
---
 drivers/nvme/common/auth.c | 26 +++++++++++++++-----------
 include/linux/nvme-auth.h  |  3 ++-
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index d90e4f0c08b7..225fc474e34a 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -163,14 +163,9 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 	p = strrchr(secret, ':');
 	if (p)
 		allocated_len = p - secret;
-	key = kzalloc(sizeof(*key), GFP_KERNEL);
+	key = nvme_auth_alloc_key(allocated_len, 0);
 	if (!key)
 		return ERR_PTR(-ENOMEM);
-	key->key = kzalloc(allocated_len, GFP_KERNEL);
-	if (!key->key) {
-		ret = -ENOMEM;
-		goto out_free_key;
-	}
 
 	key_len = base64_decode(secret, allocated_len, key->key);
 	if (key_len < 0) {
@@ -213,19 +208,28 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 	key->hash = key_hash;
 	return key;
 out_free_secret:
-	kfree_sensitive(key->key);
-out_free_key:
-	kfree(key);
+	nvme_auth_free_key(key);
 	return ERR_PTR(ret);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_extract_key);
 
+struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash)
+{
+	struct nvme_dhchap_key *key = kzalloc(len + sizeof(*key), GFP_KERNEL);
+
+	if (key) {
+		key->len = len;
+		key->hash = hash;
+	}
+	return key;
+}
+EXPORT_SYMBOL_GPL(nvme_auth_alloc_key);
+
 void nvme_auth_free_key(struct nvme_dhchap_key *key)
 {
 	if (!key)
 		return;
-	kfree_sensitive(key->key);
-	kfree(key);
+	kfree_sensitive(key);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_free_key);
 
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index dcb8030062dd..df96940be930 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -9,9 +9,9 @@
 #include <crypto/kpp.h>
 
 struct nvme_dhchap_key {
-	u8 *key;
 	size_t len;
 	u8 hash;
+	u8 key[];
 };
 
 u32 nvme_auth_get_seqnum(void);
@@ -27,6 +27,7 @@ u8 nvme_auth_hmac_id(const char *hmac_name);
 struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 					      u8 key_hash);
 void nvme_auth_free_key(struct nvme_dhchap_key *key);
+struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash);
 u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn);
 int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key);
 int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
-- 
2.39.2


