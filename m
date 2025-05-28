Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FAFC5B543
	for <linux-nvme@archiver.kernel.org>; Wed, 28 May 2025 14:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AcuJPlumVZFBoASDxr8+pWPCQcALd4P0MBVpA9BULhM=; b=WrC1tnU953d5niOjIiStBrWUXV
	JPm1JEZIGr/Pc3RAubL2zJJVIUqTpy1pmHrUxr30UbvdG9IF/EosXk0gFj5PtFMbaWHkAwCTOgDNy
	DS3QROtQIJADWvBxkfYGMw+QaPwo28pa/Lx7XoGCoPN5yd0PQYqFhvYGccdXry0jnSx2ujenXMXEu
	rNb/r60olXPtN2LKFGp6cEzJX22J3D2zKTMe0w5mF9GxW/1U3SZrm20brUQcjjLZENn6tYa6WQqN8
	N3jHvFZfNAINNMef8iZcN59tswzcgDt7MwGEuam7Fn7TJJJyP2sA5ogmFl4ki5FC7IFDz2zMWwytW
	pMidP88A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKHdH-0000000DN3i-3kI0;
	Wed, 28 May 2025 14:19:51 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKHSV-0000000DKQn-0CQB
	for linux-nvme@lists.infradead.org;
	Wed, 28 May 2025 14:08:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6F96C5C55F2;
	Wed, 28 May 2025 14:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3E82C4CEEF;
	Wed, 28 May 2025 14:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748441322;
	bh=GvSfExI/JgUr43ixkk/cNyftTuUvHMsTHSyLk43cf4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jaWAqAnHUzJLC8rQXBq2HLBlI81v+Qs2VRm3da4yaf1a7Aq48kp8oPWKJMQlBWOkd
	 A+gjhAK/p5orksGuo5XvdTqb83WWHXPQs9by9u1bODA8dMsCmXmmrqPDFHLWnZyY0d
	 ox4I3DQcbekApvm1YTHawaMg3rlnq1hct7joQAAY3YlrYtIOISlgsu+DEjhN1zwr2j
	 O+N+uxcUTpsSbj/JNnxFFc2nnNiIOsgqxfA5Gh9P6hT0n9uA/rKRsiYAfRkHNolDOk
	 6IsGNN4mS/VRqrlA1NTk/PoHEnsUJz/wAY2noHCHqXh8g1oKTLYJnr6bmdwTgVUT/T
	 fkiFJDevNGhww==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 5/9] nvmet-auth: parse dhchap key from configfs attribute
Date: Wed, 28 May 2025 16:05:13 +0200
Message-Id: <20250528140517.3284-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250528140517.3284-1-hare@kernel.org>
References: <20250528140517.3284-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250528_070843_170698_240DEEC0 
X-CRM114-Status: GOOD (  18.77  )
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

When writing a new dhchap key to the 'dhchap_secret' attribute
we should be parsing it directly and only use the pointer to the
inserted key. This avoids having to pass around a pointer with the
actual key material.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/auth.c     | 176 +++++++++++++++++++++------------
 drivers/nvme/target/configfs.c |  84 +++++++++++++---
 drivers/nvme/target/nvmet.h    |   7 +-
 3 files changed, 182 insertions(+), 85 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 7f87dc39a2de..2058e35908f8 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -20,54 +20,76 @@
 
 #include "nvmet.h"
 
+void nvmet_auth_revoke_key(struct nvmet_host *host, bool set_ctrl)
+{
+	struct key *key = ERR_PTR(-ENOKEY);
+
+	if (set_ctrl) {
+		if (host->dhchap_ctrl_key) {
+			key = host->dhchap_ctrl_key;
+			host->dhchap_ctrl_key = NULL;
+		}
+	} else {
+		if (host->dhchap_key) {
+			key = host->dhchap_key;
+			host->dhchap_key = NULL;
+		}
+	}
+	if (!IS_ERR(key)) {
+		pr_debug("%s: revoke %s key %08x\n",
+			 __func__, set_ctrl ? "ctrl" : "host",
+			 key_serial(key));
+		key_revoke(key);
+		key_put(key);
+	}
+}
+
 int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl)
 {
 	unsigned char key_hash;
-	char *dhchap_secret;
+	struct key *key;
+	size_t len;
 
 	if (!strlen(secret)) {
-		if (set_ctrl) {
-			kfree(host->dhchap_ctrl_secret);
-			host->dhchap_ctrl_secret = NULL;
-			host->dhchap_ctrl_key_hash = 0;
-		} else {
-			kfree(host->dhchap_secret);
-			host->dhchap_secret = NULL;
-			host->dhchap_key_hash = 0;
-		}
+		nvmet_auth_revoke_key(host, set_ctrl);
 		return 0;
 	}
-	if (sscanf(secret, "DHHC-1:%hhd:%*s", &key_hash) != 1)
-		return -EINVAL;
-	if (key_hash > 3) {
-		pr_warn("Invalid DH-HMAC-CHAP hash id %d\n",
-			 key_hash);
-		return -EINVAL;
+
+	len = strcspn(secret, "\n");
+	key = nvme_auth_extract_key(NULL, secret, len);
+	if (IS_ERR(key)) {
+		pr_debug("%s: invalid key specification\n", __func__);
+		return PTR_ERR(key);
+	}
+	down_read(&key->sem);
+	if (key_validate(key)) {
+		pr_warn("%s: key %08x invalidated\n",
+			__func__, key_serial(key));
+		up_read(&key->sem);
+		key_put(key);
+		return -EKEYREVOKED;
 	}
+
+	key_hash = nvme_dhchap_psk_hash(key);
 	if (key_hash > 0) {
 		/* Validate selected hash algorithm */
 		const char *hmac = nvme_auth_hmac_name(key_hash);
 
 		if (!crypto_has_shash(hmac, 0, 0)) {
 			pr_err("DH-HMAC-CHAP hash %s unsupported\n", hmac);
+			up_read(&key->sem);
+			key_put(key);
 			return -ENOTSUPP;
 		}
 	}
-	dhchap_secret = kstrdup(secret, GFP_KERNEL);
-	if (!dhchap_secret)
-		return -ENOMEM;
-	down_write(&nvmet_config_sem);
+	up_read(&key->sem);
+	nvmet_auth_revoke_key(host, set_ctrl);
 	if (set_ctrl) {
-		kfree(host->dhchap_ctrl_secret);
-		host->dhchap_ctrl_secret = strim(dhchap_secret);
-		host->dhchap_ctrl_key_hash = key_hash;
+		host->dhchap_ctrl_key = key;
 	} else {
-		kfree(host->dhchap_secret);
-		host->dhchap_secret = strim(dhchap_secret);
-		host->dhchap_key_hash = key_hash;
+		host->dhchap_key = key;
 	}
-	up_write(&nvmet_config_sem);
 	return 0;
 }
 
@@ -145,7 +167,8 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
 	int ret = 0;
 	struct nvmet_host_link *p;
 	struct nvmet_host *host = NULL;
-	u8 host_hash, ctrl_hash;
+	struct key *key;
+	key_serial_t key_id;
 
 	down_read(&nvmet_config_sem);
 	if (nvmet_is_disc_subsys(ctrl->subsys))
@@ -179,7 +202,7 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
 		goto out_unlock;
 	}
 
-	if (!host->dhchap_secret) {
+	if (!host->dhchap_key) {
 		pr_debug("No authentication provided\n");
 		goto out_unlock;
 	}
@@ -191,47 +214,68 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq)
 		ctrl->shash_id = host->dhchap_hash_id;
 	}
 
-	key_put(ctrl->host_key);
-	ctrl->host_key = nvme_auth_extract_key(NULL, host->dhchap_secret,
-					       strlen(host->dhchap_secret));
-	if (IS_ERR(ctrl->host_key)) {
-		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
-		ctrl->host_key = NULL;
-		goto out_free_hash;
+	key = key_get(host->dhchap_key);
+	if (!key) {
+		pr_warn("%s: host key %08x not found\n",
+			 __func__, key_serial(host->dhchap_key));
+		goto out_unlock;
 	}
-	host_hash = nvme_dhchap_psk_hash(ctrl->host_key);
-	pr_debug("%s: using hash %s key %u\n", __func__,
-		 ctrl_hash > 0 ?
-		 nvme_auth_hmac_name(ctrl_hash) : "none",
-		 key_serial(ctrl->host_key));
-
-	key_put(ctrl->ctrl_key);
-	if (!host->dhchap_ctrl_secret) {
-		ctrl->ctrl_key = NULL;
+	down_read(&key->sem);
+	ret = key_validate(key);
+	if (!ret) {
+		if (ctrl->host_key) {
+			pr_debug("%s: drop host key %08x\n",
+				 __func__, key_serial(ctrl->host_key));
+			key_put(ctrl->host_key);
+		}
+		ctrl->host_key = key;
+	}
+	key_id = key_serial(key);
+	up_read(&key->sem);
+	if (ret) {
+		pr_debug("key id %08x invalidated\n", key_id);
+		key_put(key);
+		key = ERR_PTR(-EKEYREVOKED);
+	}
+	pr_debug("%s: using dhchap hash %s key %08x\n", __func__,
+		 nvme_auth_hmac_name(ctrl->shash_id), key_id);
+
+	if (!host->dhchap_ctrl_key) {
+		if (ctrl->ctrl_key) {
+			pr_debug("%s: drop ctrl key %08x\n",
+				 __func__, key_serial(ctrl->ctrl_key));
+			key_put(ctrl->ctrl_key);
+			ctrl->ctrl_key = NULL;
+		}
 		goto out_unlock;
 	}
 
-	ctrl->ctrl_key = nvme_auth_extract_key(NULL, host->dhchap_ctrl_secret,
-					       strlen(host->dhchap_ctrl_secret));
-	if (IS_ERR(ctrl->ctrl_key)) {
-		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
-		ctrl->ctrl_key = NULL;
-		goto out_free_hash;
+	key = key_get(host->dhchap_ctrl_key);
+	if (!key) {
+		pr_warn("%s: ctrl key %08x not found\n",
+			__func__, key_serial(host->dhchap_ctrl_key));
+		goto out_unlock;
 	}
-	ctrl_hash = nvme_dhchap_psk_hash(ctrl->ctrl_key);
-	pr_debug("%s: using ctrl hash %s key %u\n", __func__,
-		 ctrl_hash > 0 ?
-		 nvme_auth_hmac_name(ctrl_hash) : "none",
-		 key_serial(ctrl->ctrl_key));
-
-out_free_hash:
-	if (ret) {
-		if (ctrl->host_key) {
-			key_put(ctrl->host_key);
-			ctrl->host_key = NULL;
+	down_read(&key->sem);
+	ret = key_validate(key);
+	if (!ret) {
+		if (ctrl->ctrl_key) {
+			pr_debug("%s: drop ctrl key %08x\n",
+				 __func__, key_serial(ctrl->ctrl_key));
+			key_put(ctrl->ctrl_key);
 		}
-		ctrl->shash_id = 0;
+		ctrl->ctrl_key = key;
 	}
+	key_id = key_serial(key);
+	up_read(&key->sem);
+	if (ret) {
+		pr_debug("ctrl key id %08x invalidated\n", key_id);
+		key_put(key);
+		goto out_unlock;
+	}
+	pr_debug("%s: using dhchap ctrl hash %s key %08x\n", __func__,
+		 nvme_auth_hmac_name(ctrl->shash_id), key_id);
+
 out_unlock:
 	up_read(&nvmet_config_sem);
 
@@ -265,12 +309,14 @@ void nvmet_destroy_auth(struct nvmet_ctrl *ctrl)
 	ctrl->dh_key = NULL;
 
 	if (ctrl->host_key) {
-		key_revoke(ctrl->host_key);
+		pr_debug("%s: drop host key %08x\n",
+			 __func__, key_serial(ctrl->host_key));
 		key_put(ctrl->host_key);
 		ctrl->host_key = NULL;
 	}
 	if (ctrl->ctrl_key) {
-		key_revoke(ctrl->ctrl_key);
+		pr_debug("%s: drop ctrl key %08x\n",
+			 __func__, key_serial(ctrl->ctrl_key));
 		key_put(ctrl->ctrl_key);
 		ctrl->ctrl_key = NULL;
 	}
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e44ef69dffc2..3c5ccc012168 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -14,6 +14,7 @@
 #include <linux/pci-p2pdma.h>
 #ifdef CONFIG_NVME_TARGET_AUTH
 #include <linux/nvme-auth.h>
+#include <linux/key-type.h>
 #endif
 #include <linux/nvme-keyring.h>
 #include <crypto/hash.h>
@@ -2100,15 +2101,29 @@ static struct config_group nvmet_ports_group;
 static ssize_t nvmet_host_dhchap_key_show(struct config_item *item,
 		char *page)
 {
-	u8 *dhchap_secret;
+	struct nvmet_host *host = to_host(item);
+	struct key *key;
 	ssize_t ret;
 
 	down_read(&nvmet_config_sem);
-	dhchap_secret = to_host(item)->dhchap_secret;
-	if (!dhchap_secret)
-		ret = sprintf(page, "\n");
-	else
-		ret = sprintf(page, "%s\n", dhchap_secret);
+	key = key_get(host->dhchap_key);
+	if (!key) {
+		page[0] = '\0';
+		ret = 0;
+	} else {
+		down_read(&key->sem);
+		if (key_validate(key))
+			ret = sprintf(page, "<invalidated>\n");
+		else {
+			ret = key->type->read(key, page, PAGE_SIZE);
+			if (ret > 0) {
+				page[ret] = '\n';
+				ret++;
+			}
+		}
+		up_read(&key->sem);
+		key_put(key);
+	}
 	up_read(&nvmet_config_sem);
 	return ret;
 }
@@ -2117,9 +2132,21 @@ static ssize_t nvmet_host_dhchap_key_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_host *host = to_host(item);
+	u8 *keydata;
+	size_t len;
 	int ret;
 
-	ret = nvmet_auth_set_key(host, page, false);
+	len = strcspn(page, "\n");
+	if (!len)
+		return -EINVAL;
+	keydata = kstrndup(page, len, GFP_KERNEL);
+	if (!keydata)
+		return -ENOMEM;
+
+	down_write(&nvmet_config_sem);
+	ret = nvmet_auth_set_key(host, keydata, false);
+	up_write(&nvmet_config_sem);
+	kfree(keydata);
 	/*
 	 * Re-authentication is a soft state, so keep the
 	 * current authentication valid until the host
@@ -2133,15 +2160,29 @@ CONFIGFS_ATTR(nvmet_host_, dhchap_key);
 static ssize_t nvmet_host_dhchap_ctrl_key_show(struct config_item *item,
 		char *page)
 {
-	u8 *dhchap_secret = to_host(item)->dhchap_ctrl_secret;
+	struct nvmet_host *host = to_host(item);
+	struct key *key;
 	ssize_t ret;
 
 	down_read(&nvmet_config_sem);
-	dhchap_secret = to_host(item)->dhchap_ctrl_secret;
-	if (!dhchap_secret)
-		ret = sprintf(page, "\n");
-	else
-		ret = sprintf(page, "%s\n", dhchap_secret);
+	key = key_get(host->dhchap_ctrl_key);
+	if (!key) {
+		page[0] = '\0';
+		ret = 0;
+	} else {
+		down_read(&key->sem);
+		if (key_validate(key))
+			ret = sprintf(page, "<invalidated>\n");
+		else {
+			ret = key->type->read(key, page, PAGE_SIZE);
+			if (ret > 0) {
+				page[ret] = '\n';
+				ret++;
+			}
+		}
+		up_read(&key->sem);
+		key_put(key);
+	}
 	up_read(&nvmet_config_sem);
 	return ret;
 }
@@ -2150,9 +2191,20 @@ static ssize_t nvmet_host_dhchap_ctrl_key_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_host *host = to_host(item);
+	u8 *keydata;
+	size_t len;
 	int ret;
 
-	ret = nvmet_auth_set_key(host, page, true);
+	len = strcspn(page, "\n");
+	if (!len)
+		return -EINVAL;
+	keydata = kstrndup(page, len, GFP_KERNEL);
+	if (!keydata)
+		return -ENOMEM;
+
+	down_write(&nvmet_config_sem);
+	ret = nvmet_auth_set_key(host, keydata, true);
+	up_write(&nvmet_config_sem);
 	/*
 	 * Re-authentication is a soft state, so keep the
 	 * current authentication valid until the host
@@ -2233,8 +2285,8 @@ static void nvmet_host_release(struct config_item *item)
 	struct nvmet_host *host = to_host(item);
 
 #ifdef CONFIG_NVME_TARGET_AUTH
-	kfree(host->dhchap_secret);
-	kfree(host->dhchap_ctrl_secret);
+	nvmet_auth_revoke_key(host, false);
+	nvmet_auth_revoke_key(host, true);
 #endif
 	kfree(host);
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index ca6053fbaac8..409a1580afe9 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -378,10 +378,8 @@ static inline struct nvmet_subsys *namespaces_to_subsys(
 
 struct nvmet_host {
 	struct config_group	group;
-	u8			*dhchap_secret;
-	u8			*dhchap_ctrl_secret;
-	u8			dhchap_key_hash;
-	u8			dhchap_ctrl_key_hash;
+	struct key		*dhchap_key;
+	struct key		*dhchap_ctrl_key;
 	u8			dhchap_hash_id;
 	u8			dhchap_dhgroup_id;
 };
@@ -890,6 +888,7 @@ u32 nvmet_auth_send_data_len(struct nvmet_req *req);
 void nvmet_execute_auth_send(struct nvmet_req *req);
 u32 nvmet_auth_receive_data_len(struct nvmet_req *req);
 void nvmet_execute_auth_receive(struct nvmet_req *req);
+void nvmet_auth_revoke_key(struct nvmet_host *host, bool set_ctrl);
 int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl);
 int nvmet_auth_set_host_hash(struct nvmet_host *host, const char *hash);
-- 
2.35.3


