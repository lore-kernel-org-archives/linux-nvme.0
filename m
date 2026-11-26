Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6395E606A680
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=boC/C0KG;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vky+tGai
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=xo5txbnvqTYMZSBHqc2NwkP6yDT3hL+Df/Hix28eLFg=; b=boC/C0KGD5sP50
	57OeSFbHbbHsxvPSbf99kKxhzC6LuCIu+Bmw7sCirUFKzYORZcJ7DSAswBtwfi7k11Wb6hHg9frq3
	FHTJHbngmQrV6yl+MYd3gV5SxemXQ3ddoSqXQ0nxwvvXhsSZ1Kah5wXgDpoOVw1XOHD2Uxnhkyt10
	0lIQGnjzdKiyb+JkiPoqYoOSFhwzC4B9gFR4yjSUbQI7XHxNKdkEUmUVJY4msF/+XtUP2eNZqinKI
	OEEJQQG0Mk9gLBkG1gBOVmiWQV3cuEcT8x7nrANTfw3Lk/E1JLXpmKlYiH5ptDo4Fvb22cRlgBBqG
	Mf7VQ83t/yWA3bkRVkZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaDw-0000000DUfO-05tF;
	Thu, 26 Nov 2026 14:13:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaDu-0000000DUdV-16hj
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 14:13:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A2812633E7;
	Thu, 26 Nov 2026 14:13:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03871F00ADF;
	Thu, 26 Nov 2026 14:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702396;
	bh=xo5txbnvqTYMZSBHqc2NwkP6yDT3hL+Df/Hix28eLFg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Vky+tGai9wyPsC+Va72Zcjg6szsa66QQiXJnLlXWlT7YLfSBSgwLpesbMbsVK3swZ
	 YM807NCRAbTTVBDgXlVAeQn+VunhW3JfDA9qJHY4i6uuySdTIJu/w5yY3MYMIZsE4D
	 whYMf8R1Ejki7Cx54NLBn3f2yW+RXcZbahvMyJlaIphyOPMnTwMs4xUlROAbH/uYoB
	 QgeuJHmVbAVTsKcIMkhc5mBvmSJGeTruJe0G3Cm2/ZDFNSwVxEp619419UYtsJdyiD
	 zoCLO3ups0IqyzITy/uiJ7ZJKL6cpzT+QAZo+rfrNw6MiIW2iP3es1x8LlFRJ609KD
	 VfRJthQApTtGA==
From: Hannes Reinecke <hare@kernel.org>
Date: Thu, 26 Nov 2026 15:12:26 +0100
Subject: [PATCH v7 08/14] nvmet-auth: parse dhchap key from configfs
 attribute
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-dhchap-keyring-v4-v7-8-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
In-Reply-To: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>, 
 Eric Biggers <ebiggers@kernel.org>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 keyrings@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-hardening@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702352; l=12365;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=5lspbIBB9/AQiTxwT5Ud01Y5ZU5L+Ah3y87AgbqNjQc=;
 b=oVFgFI5PL0UfMb7quVtxnAYp8BeH8ds44/xPusMq56N0u0DSDLR+gOhW/QbIaSRBsjgh+fUD7
 /mUOxRAv3IyARXRkYZ6e4dcb28WBn6kKtkABw6E7OtiJTGAe5zKhSKz
X-Developer-Key: i=hare@kernel.org; a=ed25519;
 pk=iekPF4ZZFva3sutm7d1ryPNR1G/WFfUgHaDB423JXho=
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In preparation for moving the nvmet DH-HMAC-CHAP code over
to using the kernel keyring convert the configfs interface
to use a key serial instead of storing the key data directly.
The key itself will be looked up when a controller is created
via key_lookup() to avoid having to pass around a pointer with
the actual key material.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/auth.c     | 166 ++++++++++++++++++++++++++---------------
 drivers/nvme/target/configfs.c |  80 ++++++++++++++++----
 drivers/nvme/target/nvmet.h    |   9 +--
 3 files changed, 173 insertions(+), 82 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index e1d92f5455219fd9e1845c2dca569fbb4d6450c5..ff0e8569d70675e80c1a8f18733a83317184026a 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -19,53 +19,82 @@
 
 #include "nvmet.h"
 
+static void nvmet_auth_update_key(struct nvmet_host *host, bool set_ctrl,
+				  struct key *new_key)
+{
+	key_serial_t old_key_id = 0, new_key_id = key_serial(new_key);
+	struct key *key = NULL;
+
+	if (set_ctrl) {
+		if (host->dhchap_ctrl_key) {
+			if (host->dhchap_ctrl_key == new_key_id) {
+				if (new_key)
+					key_revoke(new_key);
+				return;
+			}
+			old_key_id = host->dhchap_ctrl_key;
+		}
+		host->dhchap_ctrl_key = new_key_id;
+	} else {
+		if (host->dhchap_key) {
+			if (host->dhchap_key == new_key_id) {
+				if (new_key)
+					key_revoke(new_key);
+				return;
+			}
+			old_key_id = host->dhchap_key;
+		}
+		host->dhchap_key = new_key_id;
+	}
+	if (!old_key_id)
+		return;
+
+	key = key_lookup(old_key_id);
+	if (IS_ERR(key))
+		return;
+	pr_debug("%s: revoke %s key %08x\n", __func__,
+		 set_ctrl ? "ctrl" : "host", key_serial(key));
+	key_revoke(key);
+	key_put(key);
+}
+
+void nvmet_auth_clear_key(struct nvmet_host *host)
+{
+	nvmet_auth_update_key(host, false, NULL);
+	nvmet_auth_update_key(host, true, NULL);
+}
+
 int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl)
 {
-	unsigned char key_hash;
-	char *dhchap_secret;
-	int offset = 0;
+	struct key *key;
+	size_t len;
 
-	if (!strlen(secret)) {
+	if (!secret || !strlen(secret)) {
 		down_write(&nvmet_config_sem);
-		if (set_ctrl) {
-			kfree(host->dhchap_ctrl_secret);
-			host->dhchap_ctrl_secret = NULL;
-			host->dhchap_ctrl_key_hash = 0;
-			host->dhchap_ctrl_key_offset = 0;
-		} else {
-			kfree(host->dhchap_secret);
-			host->dhchap_secret = NULL;
-			host->dhchap_key_hash = 0;
-			host->dhchap_key_offset = 0;
-		}
+		nvmet_auth_update_key(host, set_ctrl, NULL);
 		up_write(&nvmet_config_sem);
 		return 0;
 	}
-	if (sscanf(secret, "DHHC-1:%hhd:%n", &key_hash, &offset) != 1 ||
-	    !offset)
-		return -EINVAL;
-	if (key_hash > 3) {
-		pr_warn("Invalid DH-HMAC-CHAP hash id %d\n",
-			 key_hash);
-		return -EINVAL;
-	}
-	dhchap_secret = kstrdup(secret, GFP_KERNEL);
-	if (!dhchap_secret)
-		return -ENOMEM;
+	len = strcspn(secret, "\n");
+	key = nvme_auth_extract_key(secret, len);
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
+	}
+	up_read(&key->sem);
 	down_write(&nvmet_config_sem);
-	if (set_ctrl) {
-		kfree(host->dhchap_ctrl_secret);
-		host->dhchap_ctrl_secret = strim(dhchap_secret);
-		host->dhchap_ctrl_key_hash = key_hash;
-		host->dhchap_ctrl_key_offset = offset;
-	} else {
-		kfree(host->dhchap_secret);
-		host->dhchap_secret = strim(dhchap_secret);
-		host->dhchap_key_hash = key_hash;
-		host->dhchap_key_offset = offset;
-	}
+	nvmet_auth_update_key(host, set_ctrl, key);
 	up_write(&nvmet_config_sem);
+	key_put(key);
 	return 0;
 }
 
@@ -151,9 +180,6 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
 	struct nvmet_host_link *p;
 	struct nvmet_host *host = NULL;
 	struct key *host_key, *ctrl_key = NULL;
-#ifdef CONFIG_NVME_TARGET_AUTH_DEBUG
-	u8 host_hash, ctrl_hash;
-#endif
 
 	down_read(&nvmet_config_sem);
 	if (nvmet_is_disc_subsys(ctrl->subsys))
@@ -186,22 +212,45 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
 		goto out_unlock;
 	}
 
-	if (!host->dhchap_secret) {
+	if (!host->dhchap_key) {
 		pr_debug("No authentication provided\n");
 		goto out_unlock;
 	}
 
-	host_key = nvme_auth_extract_key(host->dhchap_secret,
-					 strlen(host->dhchap_secret));
-	if (IS_ERR(host_key)) {
+	host_key = key_lookup(host->dhchap_key);
+	if (!host_key) {
+		pr_warn("%s: host key %08x not found\n",
+			__func__, host->dhchap_key);
 		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
 		goto out_unlock;
 	}
-	if (host->dhchap_ctrl_secret) {
-		ctrl_key = nvme_auth_extract_key(host->dhchap_ctrl_secret,
-						 strlen(host->dhchap_ctrl_secret));
-		if (IS_ERR(ctrl_key)) {
+	down_read(&host_key->sem);
+	ret = key_validate(host_key);
+	up_read(&host_key->sem);
+	if (ret) {
+		pr_warn("host key %08x invalidated\n",
+			host->dhchap_key);
+		key_put(host_key);
+		ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
+		goto out_unlock;
+	}
+	if (host->dhchap_ctrl_key) {
+		ctrl_key = key_lookup(host->dhchap_ctrl_key);
+		if (!ctrl_key) {
+			pr_warn("%s: ctrl key %08x not found\n",
+				__func__, host->dhchap_ctrl_key);
+			key_put(host_key);
+			ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
+			goto out_unlock;
+		}
+		down_read(&ctrl_key->sem);
+		ret = key_validate(ctrl_key);
+		up_read(&ctrl_key->sem);
+		if (ret) {
+			pr_warn("ctrl key %08x invalidated\n",
+				host->dhchap_ctrl_key);
 			key_put(host_key);
+			key_put(ctrl_key);
 			ret = NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
 			goto out_unlock;
 		}
@@ -212,18 +261,13 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, bool reset)
 	ctrl->ctrl_key = ctrl_key;
 	ctrl->shash_id = host->dhchap_hash_id;
 #ifdef CONFIG_NVME_TARGET_AUTH_DEBUG
-	host_hash = nvme_dhchap_psk_hash(ctrl->host_key);
-	pr_debug("%s: using hash %s key %u\n", __func__,
-		 ctrl_hash > 0 ?
-		 nvme_auth_hmac_name(ctrl_hash) : "none",
+	pr_debug("%s: using dhchap hash %s key %08x\n", __func__,
+		 nvme_auth_hmac_name(ctrl->shash_id),
 		 key_serial(ctrl->host_key));
-	if (ctrl->ctrl_key) {
-		ctrl_hash = nvme_dhchap_psk_hash(ctrl->ctrl_key);
-		pr_debug("%s: using ctrl hash %s key %u\n", __func__,
-			 ctrl_hash > 0 ?
-			 nvme_auth_hmac_name(ctrl_hash) : "none",
+	if (ctrl->ctrl_key)
+		pr_debug("%s: using dhchap ctrl hash %s key %08x\n", __func__,
+			 nvme_auth_hmac_name(ctrl->shash_id),
 			 key_serial(ctrl->ctrl_key));
-	}
 #endif
 out_unlock:
 	up_read(&nvmet_config_sem);
@@ -263,12 +307,14 @@ void nvmet_destroy_auth(struct nvmet_ctrl *ctrl)
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
index ff3a8d74de59966952a3991542077feebae10770..f6bfda757f076293e6e3a2db4d4245ea3a754b40 100644
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
@@ -2234,15 +2235,29 @@ static struct config_group nvmet_ports_group;
 static ssize_t nvmet_host_dhchap_key_show(struct config_item *item,
 		char *page)
 {
-	char *dhchap_secret;
+	struct nvmet_host *host = to_host(item);
+	struct key *key;
 	ssize_t ret;
 
 	down_read(&nvmet_config_sem);
-	dhchap_secret = to_host(item)->dhchap_secret;
-	if (!dhchap_secret)
-		ret = sprintf(page, "\n");
-	else
-		ret = sprintf(page, "%s\n", dhchap_secret);
+	key = key_lookup(host->dhchap_key);
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
@@ -2251,9 +2266,19 @@ static ssize_t nvmet_host_dhchap_key_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_host *host = to_host(item);
+	u8 *keydata = NULL;
+	size_t len;
 	int ret;
 
-	ret = nvmet_auth_set_key(host, page, false);
+	len = strcspn(page, "\n");
+	if (len) {
+		keydata = kstrndup(page, len, GFP_KERNEL);
+		if (!keydata)
+			return -ENOMEM;
+	}
+
+	ret = nvmet_auth_set_key(host, keydata, false);
+	kfree_sensitive(keydata);
 	/*
 	 * Re-authentication is a soft state, so keep the
 	 * current authentication valid until the host
@@ -2267,15 +2292,29 @@ CONFIGFS_ATTR(nvmet_host_, dhchap_key);
 static ssize_t nvmet_host_dhchap_ctrl_key_show(struct config_item *item,
 		char *page)
 {
-	char *dhchap_secret = to_host(item)->dhchap_ctrl_secret;
+	struct nvmet_host *host = to_host(item);
+	struct key *key;
 	ssize_t ret;
 
 	down_read(&nvmet_config_sem);
-	dhchap_secret = to_host(item)->dhchap_ctrl_secret;
-	if (!dhchap_secret)
-		ret = sprintf(page, "\n");
-	else
-		ret = sprintf(page, "%s\n", dhchap_secret);
+	key = key_lookup(host->dhchap_ctrl_key);
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
@@ -2284,9 +2323,19 @@ static ssize_t nvmet_host_dhchap_ctrl_key_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_host *host = to_host(item);
+	u8 *keydata = NULL;
+	size_t len;
 	int ret;
 
-	ret = nvmet_auth_set_key(host, page, true);
+	len = strcspn(page, "\n");
+	if (len) {
+		keydata = kstrndup(page, len, GFP_KERNEL);
+		if (!keydata)
+			return -ENOMEM;
+	}
+
+	ret = nvmet_auth_set_key(host, keydata, true);
+	kfree_sensitive(keydata);
 	/*
 	 * Re-authentication is a soft state, so keep the
 	 * current authentication valid until the host
@@ -2365,8 +2414,7 @@ static void nvmet_host_release(struct config_item *item)
 	struct nvmet_host *host = to_host(item);
 
 #ifdef CONFIG_NVME_TARGET_AUTH
-	kfree(host->dhchap_secret);
-	kfree(host->dhchap_ctrl_secret);
+	nvmet_auth_clear_key(host);
 #endif
 	kfree(host);
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 1dfdac159dab044566aac47862665784feddec0a..df84776b90f3e198f19f158e82ddddc473ee7296 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -399,12 +399,8 @@ static inline struct nvmet_subsys *namespaces_to_subsys(
 
 struct nvmet_host {
 	struct config_group	group;
-	char			*dhchap_secret;
-	char			*dhchap_ctrl_secret;
-	int			dhchap_key_offset;
-	int			dhchap_ctrl_key_offset;
-	u8			dhchap_key_hash;
-	u8			dhchap_ctrl_key_hash;
+	key_serial_t		dhchap_key;
+	key_serial_t		dhchap_ctrl_key;
 	u8			dhchap_hash_id;
 	u8			dhchap_dhgroup_id;
 };
@@ -998,6 +994,7 @@ u32 nvmet_auth_send_data_len(struct nvmet_req *req);
 void nvmet_execute_auth_send(struct nvmet_req *req);
 u32 nvmet_auth_receive_data_len(struct nvmet_req *req);
 void nvmet_execute_auth_receive(struct nvmet_req *req);
+void nvmet_auth_clear_key(struct nvmet_host *host);
 int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl);
 int nvmet_auth_set_host_hash(struct nvmet_host *host, const char *hash);

-- 
2.51.0


