Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 225A6FD8767
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 13:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z8I0C1MQzNoTAO4hBJSZbYdqaSZcohHZW/s8IawlSgM=; b=vs6rRoQXiZTJYY7RMFK0SK1zqb
	7flyGhjs93HNYTbFJGtW/eKtls1tL8nKO3VLLsW6YV3RFnwNDECz4mkq630owXnf3Cto5Khp+yYV/
	wVByRfoqcLRUucKPQWLwgmLzTWvJc4p0uKDwxWupFjHshqvbCPc6b/uWH2tMr874tR+4MAOsqU5Yr
	88KjoTZRRZgd6FCKRIxHFfYHHQbow+tskdajL5m90xA1K5OG0oVAyGCbSESIc/Dy/b4rySqFbymaP
	KIx5YM1JHRVaXjviru8Q0/4EjVy/7ecCMnggCG2gF9c5X1t0ewYdl1ORiMuBr/qsvGQY9ioZ2Rypv
	XlUZ5bQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2U37-00000006Ljl-3ICE;
	Tue, 17 Mar 2026 13:01:29 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2U35-00000006Lht-3sei
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 13:01:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3FB1844090;
	Tue, 17 Mar 2026 13:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E27C2BCAF;
	Tue, 17 Mar 2026 13:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773752487;
	bh=Rc9XjSCSlag6fQhfxLvMyprSYc8RNtqQhGZn/fMwWL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QnfJ/QA8NB2nFdx9aKbKIi+zQ/3qeQvJ+PavC3MUKFq4MOqqE4/8hTVksdngC5PxT
	 qe6W9UHjITgwkX7RxBz4KPccYuomg56aWVXmyL5TlGN6fB/jcqCusIJOu15m79Ynss
	 T7D5pPViAv2GfbwED+X+bs0t//7fXHzOhZlDB5X7BB5hq8twOTzAE08y5eITId+Pcg
	 Co+WZlI2UhtljehoE2T4AjlLKYoR3NL35W6l5det08Bp2nFrwtjEGXjlM2z9b9pMwP
	 hMe8PZoQum0HUevMf0lbd2m1MXkivkyo7aqYgZZ/Acd690t3s9kp8hdO4z5B02Llp4
	 IgXIUAk1e6B0Q==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 6/8] nvme: allow to pass in key description as dhchap secret
Date: Tue, 17 Mar 2026 14:01:01 +0100
Message-ID: <20260317130103.107360-7-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317130103.107360-1-hare@kernel.org>
References: <20260317130103.107360-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_060128_007503_CC70A2EB 
X-CRM114-Status: GOOD (  23.29  )
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

In order to use pre-populated keys update 'nvme_auth_extract_key()'
to accept a key serial number as argument in addition to the currently
implemented raw key data. To mark this change rename the 'secret'
parameter of that function to 'input', and add a function description
to document the usage.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/auth.c     | 24 +++++++---
 drivers/nvme/host/auth.c       | 17 +++++++-
 drivers/nvme/host/fabrics.c    | 24 +++++++---
 drivers/nvme/host/fabrics.h    |  4 ++
 drivers/nvme/host/nvme.h       |  2 +
 drivers/nvme/host/sysfs.c      | 80 ++++++++++++++++++++++------------
 drivers/nvme/target/auth.c     | 25 ++++++++---
 drivers/nvme/target/configfs.c | 10 +++--
 drivers/nvme/target/nvmet.h    |  2 +
 include/linux/nvme-auth.h      |  2 +-
 10 files changed, 139 insertions(+), 51 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 9879d2bee59e..2afc33f39ec5 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -143,20 +143,32 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
 /**
  * nvme_auth_extract_key - extract the DH-HMAC-CHAP key
  *
- * @secret: key data
- * @secret_len: length of @secret
+ * @input: key serial or key data
+ * @input_len: length of @input
+ * @generated: indicate whether a key has been generated
  *
- * Extracts a dhchap key from @secret.
+ * Extracts or generates a key from @input.
+ * @input can either be a key serial or raw key data; in
+ * the latter case a key is generated from @input and
+ * @generated is set to 'true'.
  *
  * Returns the dhchap key or an error pointer on failure.
  */
-struct key *nvme_auth_extract_key(struct key *keyring, const char *secret,
-				  size_t secret_len)
+struct key *nvme_auth_extract_key(struct key *keyring, const char *input,
+				  size_t input_len, bool *generated)
 {
 	struct key *key;
 
-	key = nvme_dhchap_psk_create(keyring, secret, secret_len);
+	/* Check if @input is a key serial number */
+	key = nvme_dhchap_psk_lookup(keyring, input);
 	if (!IS_ERR(key)) {
+		*generated = false;
+		return key;
+	}
+	/* Generate a key from @input data */
+	key = nvme_dhchap_psk_create(keyring, input, input_len);
+	if (!IS_ERR(key)) {
+		*generated = true;
 		pr_debug("generated dhchap key %s\n",
 			 key->description);
 	}
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 5c4505a92a80..5f636b44cc97 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -1010,19 +1010,29 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
 static void nvme_auth_clear_key(struct nvme_ctrl *ctrl, bool is_ctrl)
 {
 	struct key *key;
+	bool generated;
 
 	if (is_ctrl) {
 		key = ctrl->ctrl_key;
 		ctrl->ctrl_key = NULL;
+		generated = ctrl->ctrl_key_generated;
+		ctrl->ctrl_key_generated = false;
 	} else {
 		key = ctrl->host_key;
 		ctrl->host_key = NULL;
+		generated = ctrl->host_key_generated;
+		ctrl->host_key_generated = false;
 	}
 	if (key) {
-		dev_dbg(ctrl->device, "%s: revoke dhchap%s key %08x\n",
+		if (generated) {
+			dev_dbg(ctrl->device, "%s: revoke dhchap%s key %08x\n",
+				__func__, is_ctrl ? " ctrl" : " host",
+				key_serial(key));
+			key_revoke(key);
+		}
+		dev_dbg(ctrl->device, "%s: drop dhchap%s key %08x\n",
 			__func__, is_ctrl ? " ctrl" : " host",
 			key_serial(key));
-		key_revoke(key);
 		key_put(key);
 	}
 }
@@ -1054,6 +1064,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 			 key_serial(ctrl->opts->dhchap_key));
 		return -ENOKEY;
 	}
+	ctrl->host_key_generated = ctrl->opts->dhchap_key_generated;
 	down_read(&ctrl->host_key->sem);
 	ret = key_validate(ctrl->host_key);
 	up_read(&ctrl->host_key->sem);
@@ -1080,6 +1091,8 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 				 key_serial(ctrl->opts->dhchap_ctrl_key));
 			return -ENOKEY;
 		}
+		ctrl->ctrl_key_generated =
+			ctrl->opts->dhchap_ctrl_key_generated;
 		down_read(&ctrl->ctrl_key->sem);
 		ret = key_validate(ctrl->ctrl_key);
 		up_read(&ctrl->ctrl_key->sem);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 764814df115b..84bd2d7718db 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -741,7 +741,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->keyring = NULL;
 	opts->concat = false;
 	opts->dhchap_key = NULL;
+	opts->dhchap_key_generated = false;
 	opts->dhchap_ctrl_key = NULL;
+	opts->dhchap_ctrl_key_generated = false;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -1095,7 +1097,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	if (host_secret) {
 		pr_debug("lookup host identity '%s'\n", host_secret);
 		key = nvme_auth_extract_key(opts->keyring, host_secret,
-					    strlen(host_secret));
+					    strlen(host_secret),
+					    &opts->dhchap_key_generated);
 		if (IS_ERR(key)) {
 			ret = PTR_ERR(key);
 			goto out;
@@ -1110,7 +1113,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		}
 		pr_debug("lookup ctrl identity '%s'\n", ctrl_secret);
 		key = nvme_auth_extract_key(opts->keyring, ctrl_secret,
-					    strlen(ctrl_secret));
+					    strlen(ctrl_secret),
+					    &opts->dhchap_ctrl_key_generated);
 		if (IS_ERR(key)) {
 			ret = PTR_ERR(key);
 			goto out;
@@ -1315,15 +1319,23 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
 	kfree(opts->host_traddr);
 	kfree(opts->host_iface);
 	if (opts->dhchap_key) {
-		pr_debug("revoke dhchap host key %08x\n",
+		if (opts->dhchap_key_generated) {
+			pr_debug("revoke dhchap host key %08x\n",
+				 key_serial(opts->dhchap_key));
+			key_revoke(opts->dhchap_key);
+		}
+		pr_debug("drop dhchap host key %08x\n",
 			 key_serial(opts->dhchap_key));
-		key_revoke(opts->dhchap_key);
 		key_put(opts->dhchap_key);
 	}
 	if (opts->dhchap_ctrl_key) {
-		pr_debug("revoke dhchap ctrl key %08x\n",
+		if (opts->dhchap_ctrl_key_generated) {
+			pr_debug("revoke dhchap ctrl key %08x\n",
+				 key_serial(opts->dhchap_ctrl_key));
+			key_revoke(opts->dhchap_key);
+		}
+		pr_debug("drop dhchap ctrl key %08x\n",
 			 key_serial(opts->dhchap_ctrl_key));
-		key_revoke(opts->dhchap_key);
 		key_put(opts->dhchap_ctrl_key);
 	}
 	kfree(opts);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 786f1b4819f0..e55276356bda 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -99,6 +99,8 @@ enum {
  * @dhchap_key: DH-HMAC-CHAP pre-shared key
  * @dhchap_ctrl_key: DH-HMAC-CHAP controller pre-shared key for bi-directional
  *              authentication
+ * @dhchap_key_generated: True if the @dhchap_key has been auto-generated
+ * @dhchap_ctrl_key_generated: True if @dhchap_ctrl_key has been auto-generated
  * @keyring:    Keyring to use for key lookups
  * @tls_key:    TLS key for encrypted connections (TCP)
  * @tls:        Start TLS encrypted connections (TCP)
@@ -129,6 +131,8 @@ struct nvmf_ctrl_options {
 	struct nvmf_host	*host;
 	struct key		*dhchap_key;
 	struct key		*dhchap_ctrl_key;
+	bool			dhchap_key_generated;
+	bool			dhchap_ctrl_key_generated;
 	struct key		*keyring;
 	struct key		*tls_key;
 	bool			tls;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d16495e177cf..daaf4832c325 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -381,6 +381,8 @@ struct nvme_ctrl {
 	struct key *host_key;
 	struct key *ctrl_key;
 	u16 transaction;
+	bool host_key_generated;
+	bool ctrl_key_generated;
 #endif
 	key_serial_t tls_pskid;
 
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 7c443b0da8ab..73fd5d65adc7 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -616,13 +616,14 @@ static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 	down_read(&key->sem);
 	if (key_validate(key))
 		count = sysfs_emit(buf, "<invalidated>\n");
-	else {
+	else if (ctrl->host_key_generated) {
 		count = key->type->read(key, buf, PAGE_SIZE);
 		if (count > 0) {
 			buf[count] = '\n';
 			count++;
 		}
-	}
+	} else
+		count = sysfs_emit(buf, "%s\n", key->description);
 	up_read(&key->sem);
 	return count;
 }
@@ -634,6 +635,7 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	struct nvmf_ctrl_options *opts = ctrl->opts;
 	struct key *key, *old_key;
 	char *dhchap_secret;
+	bool generated = false;
 	size_t len;
 	int ret;
 
@@ -646,7 +648,8 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 		return -ENOMEM;
 	memcpy(dhchap_secret, buf, len);
 	nvme_auth_stop(ctrl);
-	key = nvme_auth_extract_key(opts->keyring, dhchap_secret, count);
+	key = nvme_auth_extract_key(opts->keyring, dhchap_secret, len,
+				    &generated);
 	if (IS_ERR(key)) {
 		kfree(dhchap_secret);
 		return PTR_ERR(key);
@@ -656,19 +659,25 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	up_read(&key->sem);
 	if (ret) {
 		dev_warn(ctrl->dev, "key %08x invalidated\n", key_serial(key));
-		dev_dbg(ctrl->dev, "revoke host key %08x\n", key_serial(key));
-		key_revoke(key);
+		if (generated) {
+			dev_dbg(ctrl->dev, "revoke host key %08x\n", key_serial(key));
+			key_revoke(key);
+			synchronize_rcu();
+		}
 		key_put(key);
 		kfree(dhchap_secret);
 		return ret;
 	}
 	mutex_lock(&ctrl->dhchap_auth_mutex);
 	old_key = ctrl->host_key;
-	dev_dbg(ctrl->dev, "revoke host key %08x\n",
-		key_serial(old_key));
-	key_revoke(old_key);
-
+	if (ctrl->host_key_generated) {
+		dev_dbg(ctrl->dev, "revoke host key %08x\n",
+			key_serial(old_key));
+		key_revoke(old_key);
+		synchronize_rcu();
+	}
 	ctrl->host_key = key;
+	ctrl->host_key_generated = generated;
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	key_put(old_key);
 	kfree(dhchap_secret);
@@ -694,13 +703,14 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
 	down_read(&key->sem);
 	if (key_validate(key))
 		count = sysfs_emit(buf, "<invalidated>");
-	else {
+	else if (ctrl->ctrl_key_generated) {
 		count = key->type->read(key, buf, PAGE_SIZE);
 		if (count > 0) {
 			buf[count] = '\n';
 			count++;
 		}
-	}
+	} else
+		count = sysfs_emit(buf, "%s\n", key->description);
 	up_read(&key->sem);
 	return count;
 }
@@ -712,6 +722,7 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 	struct nvmf_ctrl_options *opts = ctrl->opts;
 	struct key *key, *old_key;
 	char *dhchap_secret;
+	bool generated = false;
 	size_t len;
 	int ret;
 
@@ -724,7 +735,8 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 		return -ENOMEM;
 	memcpy(dhchap_secret, buf, len);
 	nvme_auth_stop(ctrl);
-	key = nvme_auth_extract_key(opts->keyring, dhchap_secret, count);
+	key = nvme_auth_extract_key(opts->keyring, dhchap_secret, len,
+				    &generated);
 	if (IS_ERR(key)) {
 		kfree(dhchap_secret);
 		return PTR_ERR(key);
@@ -734,19 +746,25 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 	up_read(&key->sem);
 	if (ret) {
 		dev_warn(ctrl->dev, "key %08x invalidated\n", key_serial(key));
-		dev_dbg(ctrl->dev, "revoke ctrl key %08x\n", key_serial(key));
-		key_revoke(key);
+		if (generated) {
+			dev_dbg(ctrl->dev, "revoke ctrl key %08x\n", key_serial(key));
+			key_revoke(key);
+			synchronize_rcu();
+		}
 		key_put(key);
 		kfree(dhchap_secret);
 		return ret;
 	}
 	mutex_lock(&ctrl->dhchap_auth_mutex);
 	old_key = ctrl->ctrl_key;
-	dev_dbg(ctrl->dev, "revoke ctrl key %08x\n",
-		key_serial(old_key));
-	key_revoke(old_key);
-
+	if (ctrl->ctrl_key_generated) {
+		dev_dbg(ctrl->dev, "revoke ctrl key %08x\n",
+			key_serial(old_key));
+		key_revoke(old_key);
+		synchronize_rcu();
+	}
 	ctrl->ctrl_key = key;
+	ctrl->ctrl_key_generated = generated;
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	key_put(old_key);
 	kfree(dhchap_secret);
@@ -772,13 +790,8 @@ static ssize_t dhchap_key_show(struct device *dev,
 	down_read(&key->sem);
 	if (key_validate(key))
 		count = sysfs_emit(buf, "<invalidated>\n");
-	else {
-		count = key->type->read(key, buf, PAGE_SIZE);
-		if (count > 0) {
-			buf[count] = '\n';
-			count++;
-		}
-	}
+	else
+		count = sysfs_emit(buf, "%08x\n", key_serial(key));
 	up_read(&key->sem);
 	return count;
 }
@@ -788,10 +801,19 @@ static ssize_t dhchap_ctrl_key_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct key *key = ctrl->ctrl_key;
+	size_t count;
 
-	if (!ctrl->ctrl_key)
+	if (!key)
 		return 0;
-	return sysfs_emit(buf, "%08x\n", key_serial(ctrl->ctrl_key));
+	down_read(&key->sem);
+	if (key_validate(key))
+		count = sysfs_emit(buf, "<invalidated>\n");
+	else
+		count = sysfs_emit(buf, "%08x\n", key_serial(key));
+	up_read(&key->sem);
+	return count;
+
 }
 static DEVICE_ATTR_RO(dhchap_ctrl_key);
 #endif
@@ -852,8 +874,12 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 #ifdef CONFIG_NVME_HOST_AUTH
 	if (a == &dev_attr_dhchap_secret.attr && !ctrl->opts)
 		return 0;
+	if (a == &dev_attr_dhchap_key.attr && ctrl->host_key_generated)
+		return 0;
 	if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
 		return 0;
+	if (a == &dev_attr_dhchap_ctrl_key.attr && ctrl->ctrl_key_generated)
+		return 0;
 #endif
 
 	return a->mode;
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 4cdf85e86b1a..cbb15b2024a8 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -22,23 +22,34 @@
 void nvmet_auth_revoke_key(struct nvmet_host *host, bool set_ctrl)
 {
 	struct key *key = NULL;
+	bool generated = false;
 
 	if (set_ctrl) {
 		if (host->dhchap_ctrl_key) {
 			key = host->dhchap_ctrl_key;
+			generated = host->dhchap_ctrl_key_generated;
 			host->dhchap_ctrl_key = NULL;
+			host->dhchap_ctrl_key_generated = false;
 		}
 	} else {
 		if (host->dhchap_key) {
 			key = host->dhchap_key;
+			generated = host->dhchap_key_generated;
 			host->dhchap_key = NULL;
+			host->dhchap_key_generated = false;
 		}
 	}
 	if (key) {
-		pr_debug("%s: revoke %s key %08x\n",
+		if (generated) {
+			pr_debug("%s: revoke %s key %08x\n",
+				 __func__, set_ctrl ? "ctrl" : "host",
+				 key_serial(key));
+			key_revoke(key);
+			synchronize_rcu();
+		}
+		pr_debug("%s: drop %s key %08x\n",
 			 __func__, set_ctrl ? "ctrl" : "host",
 			 key_serial(key));
-		key_revoke(key);
 		key_put(key);
 	}
 }
@@ -46,6 +57,7 @@ void nvmet_auth_revoke_key(struct nvmet_host *host, bool set_ctrl)
 int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl)
 {
+	bool generated = false;
 	struct key *key;
 	size_t len;
 
@@ -55,7 +67,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 	}
 
 	len = strcspn(secret, "\n");
-	key = nvme_auth_extract_key(NULL, secret, len);
+	key = nvme_auth_extract_key(NULL, secret, len, &generated);
 	if (IS_ERR(key)) {
 		pr_debug("%s: invalid key specification\n", __func__);
 		return PTR_ERR(key);
@@ -70,10 +82,13 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 	}
 	up_read(&key->sem);
 	nvmet_auth_revoke_key(host, set_ctrl);
-	if (set_ctrl)
+	if (set_ctrl) {
 		host->dhchap_ctrl_key = key;
-	else
+		host->dhchap_ctrl_key_generated = generated;
+	} else {
 		host->dhchap_key = key;
+		host->dhchap_key_generated = generated;
+	}
 	return 0;
 }
 
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 5fa1b8a19bf8..3dba7b3ee59b 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -2113,13 +2113,14 @@ static ssize_t nvmet_host_dhchap_key_show(struct config_item *item,
 		down_read(&key->sem);
 		if (key_validate(key))
 			ret = sprintf(page, "<invalidated>\n");
-		else {
+		else if (host->dhchap_key_generated) {
 			ret = key->type->read(key, page, PAGE_SIZE);
 			if (ret > 0) {
 				page[ret] = '\n';
 				ret++;
 			}
-		}
+		} else
+			ret = sprintf(page, "%s\n", key->description);
 		up_read(&key->sem);
 		key_put(key);
 	}
@@ -2172,13 +2173,14 @@ static ssize_t nvmet_host_dhchap_ctrl_key_show(struct config_item *item,
 		down_read(&key->sem);
 		if (key_validate(key))
 			ret = sprintf(page, "<invalidated>\n");
-		else {
+		else if (host->dhchap_ctrl_key_generated) {
 			ret = key->type->read(key, page, PAGE_SIZE);
 			if (ret > 0) {
 				page[ret] = '\n';
 				ret++;
 			}
-		}
+		} else
+			ret = sprintf(page, "%s\n", key->description);
 		up_read(&key->sem);
 		key_put(key);
 	}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 9b0848948b3f..ae7a6e74a8b4 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -379,7 +379,9 @@ static inline struct nvmet_subsys *namespaces_to_subsys(
 struct nvmet_host {
 	struct config_group	group;
 	struct key		*dhchap_key;
+	bool			dhchap_key_generated;
 	struct key		*dhchap_ctrl_key;
+	bool			dhchap_ctrl_key_generated;
 	u8			dhchap_hash_id;
 	u8			dhchap_dhgroup_id;
 };
diff --git a/include/linux/nvme-auth.h b/include/linux/nvme-auth.h
index 9dc7f520c4bd..a1c6a93c1dce 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -32,7 +32,7 @@ void nvme_auth_hmac_update(struct nvme_auth_hmac_ctx *hmac, const u8 *data,
 void nvme_auth_hmac_final(struct nvme_auth_hmac_ctx *hmac, u8 *out);
 
 struct key *nvme_auth_extract_key(struct key *keyring, const char *secret,
-				  size_t secret_len);
+				  size_t secret_len, bool *generated);
 int nvme_auth_transform_key(struct key *key, const char *nqn,
 			    u8 **transformed_secret);
 int nvme_auth_augmented_challenge(u8 hmac_id, const u8 *skey, size_t skey_len,
-- 
2.43.0


