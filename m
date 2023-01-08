Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5636DC54EBD
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Jan 2023 18:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sebHY3sQ1HDhO7FkqUZs41GTzC3KvFXfrsJ3EoARmdA=; b=KIbKn3zSqjSRgu4ywOOu65VS6e
	5RvjtwdWKvEg6G+uaQBOVOXnyVf2bXtqjYXNpjIG21g8P/zCXDF7qVCWIDQw0hp2ZQpcotyXNSwx6
	YM8ZXeaLKkItcIYd47hmA1rNV9o1W4iBn9RMgwRtg+Vwha1jO/tubv/Knqp8ojyEC8CZ0VIv4vyCE
	JO4j1sdRzCs1mSqItfgNHtAc5sD+Ot7Px0e1BmHKFREd4tJYlaW/JIMcz4nAetA4PgtZ8PNR5Fczx
	Fu3ccaMfWiauCzHvmCix3dzY0oPSb3NQSgD5ooX3uCqY5qcRwq0qxmW/fIZ/6RBUVOJPfqN03Q6Wu
	ENpr3v5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEabn-00FJqc-Lp; Sun, 08 Jan 2023 18:41:27 +0000
Received: from [2001:4bb8:198:a591:1c7c:bf66:af15:b282] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEabl-00FJoh-K4; Sun, 08 Jan 2023 18:41:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me,
	hare@suse.de
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-common: simplify nvme_auth_generate_key
Date: Sun,  8 Jan 2023 19:41:23 +0100
Message-Id: <20230108184123.393727-1-hch@lst.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Return the key or NULL on success, and an ERR_PTR on failure
instead of passing a separate ret_key argument to return the key.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/common/auth.c | 20 +++++---------------
 drivers/nvme/host/auth.c   | 22 +++++++++++++---------
 drivers/nvme/host/core.c   | 14 ++++++--------
 include/linux/nvme-auth.h  |  2 +-
 4 files changed, 25 insertions(+), 33 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index d90e4f0c08b7b9..a07eb4cd9ce173 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -455,28 +455,18 @@ int nvme_auth_gen_shared_secret(struct crypto_kpp *dh_tfm,
 }
 EXPORT_SYMBOL_GPL(nvme_auth_gen_shared_secret);
 
-int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key)
+struct nvme_dhchap_key *nvme_auth_generate_key(u8 *secret)
 {
-	struct nvme_dhchap_key *key;
 	u8 key_hash;
 
-	if (!secret) {
-		*ret_key = NULL;
-		return 0;
-	}
+	if (!secret)
+		return NULL;
 
 	if (sscanf(secret, "DHHC-1:%hhd:%*s:", &key_hash) != 1)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	/* Pass in the secret without the 'DHHC-1:XX:' prefix */
-	key = nvme_auth_extract_key(secret + 10, key_hash);
-	if (IS_ERR(key)) {
-		*ret_key = NULL;
-		return PTR_ERR(key);
-	}
-
-	*ret_key = key;
-	return 0;
+	return nvme_auth_extract_key(secret + 10, key_hash);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_generate_key);
 
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 787537454f7fbb..d18c1d49159c99 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -943,16 +943,19 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
 	if (!ctrl->opts)
 		return 0;
-	ret = nvme_auth_generate_key(ctrl->opts->dhchap_secret,
-			&ctrl->host_key);
-	if (ret)
-		return ret;
-	ret = nvme_auth_generate_key(ctrl->opts->dhchap_ctrl_secret,
-			&ctrl->ctrl_key);
-	if (ret)
+
+	ctrl->host_key = nvme_auth_generate_key(ctrl->opts->dhchap_secret);
+	if (IS_ERR(ctrl->host_key)) {
+		ret = PTR_ERR(ctrl->host_key);
+		goto out;
+	}
+	ctrl->ctrl_key = nvme_auth_generate_key(ctrl->opts->dhchap_ctrl_secret);
+	if (IS_ERR(ctrl->ctrl_key)) {
+		ret = PTR_ERR(ctrl->ctrl_key);
 		goto err_free_dhchap_secret;
+	}
 
-	if (!ctrl->opts->dhchap_secret && !ctrl->opts->dhchap_ctrl_secret)
+	if (!ctrl->host_key && !ctrl->ctrl_key)
 		return 0;
 
 	ctrl->dhchap_ctxs = kvcalloc(ctrl_max_dhchaps(ctrl),
@@ -972,9 +975,10 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 	return 0;
 err_free_dhchap_ctrl_secret:
 	nvme_auth_free_key(ctrl->ctrl_key);
-	ctrl->ctrl_key = NULL;
 err_free_dhchap_secret:
+	ctrl->ctrl_key = NULL;
 	nvme_auth_free_key(ctrl->host_key);
+out:
 	ctrl->host_key = NULL;
 	return ret;
 }
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7be562a4e1aa72..276ac825cca12e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3800,11 +3800,10 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	nvme_auth_stop(ctrl);
 	if (strcmp(dhchap_secret, opts->dhchap_secret)) {
 		struct nvme_dhchap_key *key, *host_key;
-		int ret;
 
-		ret = nvme_auth_generate_key(dhchap_secret, &key);
-		if (ret)
-			return ret;
+		key = nvme_auth_generate_key(dhchap_secret);
+		if (IS_ERR(key))
+			return PTR_ERR(key);
 		kfree(opts->dhchap_secret);
 		opts->dhchap_secret = dhchap_secret;
 		host_key = ctrl->host_key;
@@ -3854,11 +3853,10 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 	nvme_auth_stop(ctrl);
 	if (strcmp(dhchap_secret, opts->dhchap_ctrl_secret)) {
 		struct nvme_dhchap_key *key, *ctrl_key;
-		int ret;
 
-		ret = nvme_auth_generate_key(dhchap_secret, &key);
-		if (ret)
-			return ret;
+		key = nvme_auth_generate_key(dhchap_secret);
+		if (IS_ERR(key))
+			return PTR_ERR(key);
 		kfree(opts->dhchap_ctrl_secret);
 		opts->dhchap_ctrl_secret = dhchap_secret;
 		ctrl_key = ctrl->ctrl_key;
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index dcb8030062ddaf..df82d7950ee204 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -28,7 +28,7 @@ struct nvme_dhchap_key *nvme_auth_extract_key(unsigned char *secret,
 					      u8 key_hash);
 void nvme_auth_free_key(struct nvme_dhchap_key *key);
 u8 *nvme_auth_transform_key(struct nvme_dhchap_key *key, char *nqn);
-int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key);
+struct nvme_dhchap_key *nvme_auth_generate_key(u8 *secret);
 int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
 				  u8 *challenge, u8 *aug, size_t hlen);
 int nvme_auth_gen_privkey(struct crypto_kpp *dh_tfm, u8 dh_gid);
-- 
2.35.1


