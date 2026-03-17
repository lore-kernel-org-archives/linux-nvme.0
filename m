Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080CCFD8766
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 13:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VJhwZrzMSbwwlw8MJusdgpO2lmvYksWPR28B0KgF85w=; b=awUlN5/hbD3xLe8pS65AXhJQcH
	ykFP3FNyIuN2guHumws4x1IarSMtpWuaUmNwZLWUc5X0I28DHNsBXyCf7Uf1diu2L5Qie9VVRAZBO
	ffMSDWv68wpeNWNwmWCjCb7fv9CYMLV29dlfMxjTf5XvyhaKb6rqgk+lCR89cifw0BFOB/tMfC/NQ
	KQ6aNuNHFUIfcBMxc9pwzvxYtvHXT8bfVBodtQgRPDdIqKOZRARHuE6iibzTd4MTlXSGZB6RI6PXQ
	q0vKmobraxsi8KbynhztQfOUzlTJCQiPVk831tRX8GXpZSO5TsJy+ve9qyqaIVTUIt38bmFCoKvH1
	LChiXZhA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2U36-00000006LiO-0HGr;
	Tue, 17 Mar 2026 13:01:28 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2U33-00000006LgX-3Q3D
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 13:01:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 821D7419F6;
	Tue, 17 Mar 2026 13:01:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22399C19425;
	Tue, 17 Mar 2026 13:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773752485;
	bh=KCpkRPVmUvPOLrTyY9vzf/JeamIluZ2DV9v9ofqhnSg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gkGOPCfbkSjRUDYT1QOeNY+5IgtjY7b6IpoHCRkK+JyubfZlfr0PnXX3geO7zpIt7
	 VL9rXPXklHmVUUQKfsfDhqicKAzgJ3hcbY1eBoDZrrD1QcYiHBLjJnakMmRlL87mM8
	 tptztctgnI3uF4aE9vKGAcNF+LF4IZTZv1qSFBTBjjUimJ2s9PEJO0XcWrflg1DTcC
	 G0DSf+lpAPymbv1OhpfDmJKy7X2ZaJLCJy1m+woak5bisBbp2PyzReN6/QwOqiRlJu
	 pnidZulHi4orBraKL5tjzYTmFagqhdYQpzmsTBEUuy9D09VHbBao6OyX+02dTZL5PV
	 IItFhEUXeDOSA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 5/8] nvmet-auth: parse dhchap key from configfs attribute
Date: Tue, 17 Mar 2026 14:01:00 +0100
Message-ID: <20260317130103.107360-6-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317130103.107360-1-hare@kernel.org>
References: <20260317130103.107360-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_060125_914577_34BCA16F 
X-CRM114-Status: GOOD (  18.90  )
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

In preparation for moving the nvmet DH-HMAC-CHAP code over
to using the kernel keyring convert the configfs interface
to use 'struct key' instead of storing the key data directly.
This avoids having to pass around a pointer with the actual
key material.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/auth.c     | 176 ++++++++++++++++++++-------------
 drivers/nvme/target/configfs.c |  84 +++++++++++++---
 drivers/nvme/target/nvmet.h    |   7 +-
 3 files changed, 179 insertions(+), 88 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 3cb829df964c..4cdf85e86b1a 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -19,45 +19,61 @@
 
 #include "nvmet.h"
 
+void nvmet_auth_revoke_key(struct nvmet_host *host, bool set_ctrl)
+{
+	struct key *key = NULL;
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
+	if (key) {
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
-	unsigned char key_hash;
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
 	}
-	dhchap_secret = kstrdup(secret, GFP_KERNEL);
-	if (!dhchap_secret)
-		return -ENOMEM;
-	down_write(&nvmet_config_sem);
-	if (set_ctrl) {
-		kfree(host->dhchap_ctrl_secret);
-		host->dhchap_ctrl_secret = strim(dhchap_secret);
-		host->dhchap_ctrl_key_hash = key_hash;
-	} else {
-		kfree(host->dhchap_secret);
-		host->dhchap_secret = strim(dhchap_secret);
-		host->dhchap_key_hash = key_hash;
+	down_read(&key->sem);
+	if (key_validate(key)) {
+		pr_warn("%s: key %08x invalidated\n",
+			__func__, key_serial(key));
+		up_read(&key->sem);
+		key_put(key);
+		return -EKEYREVOKED;
 	}
-	up_write(&nvmet_config_sem);
+	up_read(&key->sem);
+	nvmet_auth_revoke_key(host, set_ctrl);
+	if (set_ctrl)
+		host->dhchap_ctrl_key = key;
+	else
+		host->dhchap_key = key;
 	return 0;
 }
 
@@ -135,7 +151,8 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
 	int ret = 0;
 	struct nvmet_host_link *p;
 	struct nvmet_host *host = NULL;
-	u8 host_hash, ctrl_hash;
+	struct key *key;
+	key_serial_t key_id;
 
 	down_read(&nvmet_config_sem);
 	if (nvmet_is_disc_subsys(ctrl->subsys))
@@ -169,7 +186,7 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
 		goto out_unlock;
 	}
 
-	if (!host->dhchap_secret) {
+	if (!host->dhchap_key) {
 		pr_debug("No authentication provided\n");
 		goto out_unlock;
 	}
@@ -181,47 +198,68 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
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
 
@@ -255,12 +293,14 @@ void nvmet_destroy_auth(struct nvmet_ctrl *ctrl)
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
index 463348c7f097..5fa1b8a19bf8 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -15,6 +15,7 @@
 #include <linux/pci-p2pdma.h>
 #ifdef CONFIG_NVME_TARGET_AUTH
 #include <linux/nvme-auth.h>
+#include <linux/key-type.h>
 #endif
 #include <linux/nvme-keyring.h>
 #include <crypto/kpp.h>
@@ -2099,15 +2100,29 @@ static struct config_group nvmet_ports_group;
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
@@ -2116,9 +2131,21 @@ static ssize_t nvmet_host_dhchap_key_store(struct config_item *item,
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
@@ -2132,15 +2159,29 @@ CONFIGFS_ATTR(nvmet_host_, dhchap_key);
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
@@ -2149,9 +2190,20 @@ static ssize_t nvmet_host_dhchap_ctrl_key_store(struct config_item *item,
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
@@ -2230,8 +2282,8 @@ static void nvmet_host_release(struct config_item *item)
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
index f9f281060ac1..9b0848948b3f 100644
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
@@ -894,6 +892,7 @@ u32 nvmet_auth_send_data_len(struct nvmet_req *req);
 void nvmet_execute_auth_send(struct nvmet_req *req);
 u32 nvmet_auth_receive_data_len(struct nvmet_req *req);
 void nvmet_execute_auth_receive(struct nvmet_req *req);
+void nvmet_auth_revoke_key(struct nvmet_host *host, bool set_ctrl);
 int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl);
 int nvmet_auth_set_host_hash(struct nvmet_host *host, const char *hash);
-- 
2.43.0


