Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B35CDB483
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Oct 2023 17:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TexFNDVeTBrtl14S2U2gJCltTKAQzntVEalOs/i1BXI=; b=SUR3c21KuBvEGsm2F43zw/v26L
	YRXIF/sj3ZxEbHeaA5bYdKNjQq8KcixVTyFTnxFBI0/wOsP6OuIt2D4XLnqssfa29ONumO4UpE5pB
	XbI3WKxlhOQk9Qtenlvw3XHHTTxqiGCHwImYamXlfWPAhVn6/cf9xnYL0yoIWDpqE7urdBTyQ9+Pd
	ddc8wZZQ2wMC/AMYVBsY0Hf8JQhXqgFZh0IOZJlZkoorDKRPR3+vRKZe2ExYQPOPiRS3jp7O8fRnF
	P1AtuaFk1UhErPI8CJWln0K/yesSH2U/d8jPe83X/d2Ye2Vn9czmRFHuIyvLyInYHVuEnTTZHN1Sd
	B7dZcvJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsnZg-00Cstf-0y;
	Tue, 17 Oct 2023 17:09:44 +0000
Received: from mout01.posteo.de ([185.67.36.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsnZb-00Csr2-0Y
	for linux-nvme@lists.infradead.org;
	Tue, 17 Oct 2023 17:09:41 +0000
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 5CE49240028
	for <linux-nvme@lists.infradead.org>; Tue, 17 Oct 2023 19:09:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1697562577; bh=NF1r+NLg51G1dFzc0PzoVKjUyD6Riw2yYir+JcEjJhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=QIzeHAFnXABFpH8xmay3ntYWPKL4KEEv1raICjR7XjnQQSqakku+vsK1tRjHEOUXL
	 xunTwLUqdm0GmvFjZOJykA+J/jH8YvQYEiW/obveAemRFCnfevfxSgqVeeQEWC3SAe
	 pPat4vWUmhXORM/4RqlUhswGVxetZ8uHoPHF1ffAW0aSpnnD1kwnhwnrcq+WcjUdO+
	 DN7kFuiDGfMOW3wSXuNB9NMOa4UytiLbEMNoYUDTjZxfmAIPFD5WCZVJdLXOKSumhT
	 JB4L0MVN47rvFS7g/bv2y7nFr59JF71VTVA6EFxRrldaxySXzgvep+2EtzbH1MAmgC
	 zcJGQQJhY/H5g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4S90p76xy3z9rxb;
	Tue, 17 Oct 2023 19:09:35 +0200 (CEST)
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
Subject: [PATCH v5 1/3] nvme-auth: alloc nvme_dhchap_key as single buffer
Date: Tue, 17 Oct 2023 17:09:17 +0000
Message-Id: <20231017170919.30358-2-shiftee@posteo.net>
In-Reply-To: <20231017170919.30358-1-shiftee@posteo.net>
References: <20231017170919.30358-1-shiftee@posteo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231017_100939_497602_7BF009C1 
X-CRM114-Status: GOOD (  11.94  )
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
V2 -> V3: initial version

V3 -> V4: added function to get size of key struct

V4 -> V5: removed newly redundant check found by kernel test robot

 drivers/nvme/common/auth.c | 37 +++++++++++++++++++++++++------------
 include/linux/nvme-auth.h  |  4 +++-
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index d90e4f0c08b7..16a071448d54 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -150,6 +150,14 @@ size_t nvme_auth_hmac_hash_len(u8 hmac_id)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
 
+u32 nvme_auth_key_struct_size(u32 key_len)
+{
+	struct nvme_dhchap_key key;
+
+	return struct_size(&key, key, key_len);
+}
+EXPORT_SYMBOL_GPL(nvme_auth_key_struct_size);
+
 struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 					      u8 key_hash)
 {
@@ -163,14 +171,9 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
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
@@ -213,19 +216,29 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
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
+	u32 num_bytes = nvme_auth_key_struct_size(len);
+	struct nvme_dhchap_key *key = kzalloc(num_bytes, GFP_KERNEL);
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
 
@@ -237,7 +250,7 @@ u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn)
 	u8 *transformed_key;
 	int ret;
 
-	if (!key || !key->key) {
+	if (!key) {
 		pr_warn("No key specified\n");
 		return ERR_PTR(-ENOKEY);
 	}
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index dcb8030062dd..a5ae9abe1ef6 100644
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
@@ -24,9 +24,11 @@ const char *nvme_auth_digest_name(u8 hmac_id);
 size_t nvme_auth_hmac_hash_len(u8 hmac_id);
 u8 nvme_auth_hmac_id(const char *hmac_name);
 
+u32 nvme_auth_key_struct_size(u32 key_len);
 struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 					      u8 key_hash);
 void nvme_auth_free_key(struct nvme_dhchap_key *key);
+struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash);
 u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn);
 int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key);
 int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
-- 
2.39.2


