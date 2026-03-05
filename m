Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC05F30948
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Mar 2026 11:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=c4ZrF0xXthlDdfFn6ZdluOcER4YdQnfKjs2jmlZgnQ8=; b=i0zSABmG9XOXW1lhWtWfNJXTpr
	7OoVXOC/xNSZuNUxuO9ShvfdiEoWYGikPAXc3ZPFLelZ1OuG0E+HPJHJom87980NGiD2Pf4GfcTq3
	TSkkRnPBz53pGe+u1IvUMOw0k5DgT1Ph68bQ4t+6jSJecqmihcEhpNdvfpMF4cYIZRZZVFm4c7MfF
	0BHjNdDhCWxrf60EoiAaYPRLVbc4WwRUqbiyncxLyp+ALqxvt+Jre3SHp52DhmpDsrb2t0ts1Sl8Y
	j93kZvrsCaENr18dMsqCjkI+EqBV4ZCdRyXke4kJFK3kPoeC6MkSs7N2Q+imPzGNwjLRzZOcrF8wf
	aZMPomUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vy72Y-00000001gvY-26Et;
	Thu, 05 Mar 2026 11:38:50 +0000
Received: from out-171.mta0.migadu.com ([2001:41d0:1004:224b::ab])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vy72V-00000001guz-0NN8
	for linux-nvme@lists.infradead.org;
	Thu, 05 Mar 2026 11:38:48 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772710719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=c4ZrF0xXthlDdfFn6ZdluOcER4YdQnfKjs2jmlZgnQ8=;
	b=kfSdmYwwp0qMlFqwoRteizsCWun7t76utQlgsTdlSEixKa7RmIRbeKWsUBRbeMQndvAOmS
	NP9JnVwIYAqHTEPOohN4Q9chQjuUpi4PGX09imJtofM91/ngkVjHfIRND/Z5+rTEqz4pJH
	ePOMxFdih5wnpjdvjDCaAGWKcCH3t/0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-auth: use kzalloc_flex() in nvme_auth_alloc_key()
Date: Thu,  5 Mar 2026 12:37:31 +0100
Message-ID: <20260305113730.201680-3-thorsten.blum@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260305_033847_270060_B813F74F 
X-CRM114-Status: GOOD (  11.04  )
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

Use kzalloc_flex() in nvme_auth_alloc_key() and remove the helper
nvme_auth_key_struct_size(). In nvme_auth_transform_key(), use
struct_size() directly.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/nvme/common/auth.c | 14 +++-----------
 include/linux/nvme-auth.h  |  1 -
 2 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index e07e7d4bf8b6..20aac5e29ca4 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -153,14 +153,6 @@ size_t nvme_auth_hmac_hash_len(u8 hmac_id)
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
 struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 					      u8 key_hash)
 {
@@ -218,9 +210,9 @@ EXPORT_SYMBOL_GPL(nvme_auth_extract_key);
 
 struct nvme_dhchap_key *nvme_auth_alloc_key(u32 len, u8 hash)
 {
-	u32 num_bytes = nvme_auth_key_struct_size(len);
-	struct nvme_dhchap_key *key = kzalloc(num_bytes, GFP_KERNEL);
+	struct nvme_dhchap_key *key;
 
+	key = kzalloc_flex(*key, key, len);
 	if (key) {
 		key->len = len;
 		key->hash = hash;
@@ -251,7 +243,7 @@ struct nvme_dhchap_key *nvme_auth_transform_key(
 		return ERR_PTR(-ENOKEY);
 	}
 	if (key->hash == 0) {
-		key_len = nvme_auth_key_struct_size(key->len);
+		key_len = struct_size(key, key, key->len);
 		transformed_key = kmemdup(key, key_len, GFP_KERNEL);
 		if (!transformed_key)
 			return ERR_PTR(-ENOMEM);
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index 60e069a6757f..f508cce5ed83 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -24,7 +24,6 @@ const char *nvme_auth_digest_name(u8 hmac_id);
 size_t nvme_auth_hmac_hash_len(u8 hmac_id);
 u8 nvme_auth_hmac_id(const char *hmac_name);
 
-u32 nvme_auth_key_struct_size(u32 key_len);
 struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 					      u8 key_hash);
 void nvme_auth_free_key(struct nvme_dhchap_key *key);

base-commit: c107785c7e8dbabd1c18301a1c362544b5786282
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


