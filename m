Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20ADC369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 11:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LD6XE3Df7LCicCVl0lb9LkP6rsQm6WRUbSAIzXDbn0E=; b=XLL7nu8qxMHghVmc4fM7jzEzoT
	v8rH7SmldMxRT18+hB7cbm+eMzpaymKSrQCXqhSzvgJYKjUaMipND8DLaz3iMO0lNkHadoWHfFXVn
	K7BpDsxPvqzMnTtEreJYTTP7N5ObdrgsMxTf+nCotlnCqYO1Scj772wQaoNxPiN4Uxd+eiOPz76nU
	a6TDWWBj4hbSJSqSf0UmSxhPpVySazFnU/rkN8w8az8mRKciE97DarEVerF2lZxpd3/HfKrA0hVuw
	AdU6jvcqKeT647Q0Zew37BnG/Y21FqZkdUx//p0k98w52eF490Kxj6/vi/6ohZbK8wHNVHF5Gvuwx
	raBn4qFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8H0Y-0000000Gtbb-3aOb;
	Fri, 25 Apr 2025 11:14:14 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Fh2-0000000Gbuo-39Le
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 09:50:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 08BA3A4D176;
	Fri, 25 Apr 2025 09:44:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740E8C4CEEA;
	Fri, 25 Apr 2025 09:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745574599;
	bh=6oIj7sLRn3iZVv61qwsSBj4HveSH+K+sD1zGWlbn+Ok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ObUy0DY00EhbrcY1R/6PHACxE78EBQc1/NdlHAeeFC3GiI1j6PxbIM50WPD/7HmKT
	 b8RBGzBAsq2Xqh/hqM+noOARcQmrVoTNTr9PSJJmmQPVOvEXG5cif26VXlg9orNvvs
	 xDC9iYhezUHO1bCcqRY+I8ohL8/0n9I3R0xWpn664HbJ1xcgWxd9miZ5uUT28cOmWJ
	 cLBroCuk4l4ou/d4NWWhWD7tpniHut7q1/PehgkteE0xQes0Yb3vt2vLkGAc24uJaG
	 3A3V4iNvGnw4NGLNhUfqCwphKRVmGoYNWbqRywz4wrf2p/BCvIFRfd6dyWqOgvTzS7
	 3yqGSYN7rD7bQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 10/12] nvme: allow to pass in key serial number as dhchap secret
Date: Fri, 25 Apr 2025 11:49:25 +0200
Message-Id: <20250425094927.102656-11-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250425094927.102656-1-hare@kernel.org>
References: <20250425094927.102656-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_025000_933579_C6F17EB2 
X-CRM114-Status: GOOD (  18.12  )
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

In order to use pre-populated keys update the parsing for
DH-HMAC-CHAP secret to allow for a key serial number instead
of an encoded binary secret.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/auth.c     | 22 ++++++++++---
 drivers/nvme/host/auth.c       | 17 ++++++++--
 drivers/nvme/host/fabrics.c    | 24 ++++++++++----
 drivers/nvme/host/fabrics.h    |  4 +++
 drivers/nvme/host/nvme.h       |  2 ++
 drivers/nvme/host/sysfs.c      | 60 ++++++++++++++++++++++------------
 drivers/nvme/target/auth.c     | 20 ++++++++++--
 drivers/nvme/target/configfs.c | 10 +++---
 drivers/nvme/target/nvmet.h    |  2 ++
 include/linux/nvme-auth.h      |  3 +-
 10 files changed, 122 insertions(+), 42 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 8c2ccbfb9986..c47bb70b26ef 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -156,14 +156,26 @@ size_t nvme_auth_hmac_hash_len(u8 hmac_id)
 EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
 
 struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret,
-				  size_t secret_len)
+				  size_t secret_len, bool *generated)
 {
+	key_serial_t key_id;
 	struct key *key;
 
-	key = nvme_dhchap_psk_refresh(keyring, secret, secret_len);
-	if (!IS_ERR(key))
-		pr_debug("generated dhchap key %08x\n",
-			 key_serial(key));
+	if (kstrtouint(secret, 0, &key_id)) {
+		key = nvme_dhchap_psk_refresh(keyring,
+					      secret, secret_len);
+		if (!IS_ERR(key)) {
+			*generated = true;
+			pr_debug("generated dhchap key %08x\n",
+				 key_serial(key));
+		}
+	} else if (key_id > 0) {
+		key = nvme_tls_key_lookup(key_id);
+		if (!IS_ERR(key))
+			*generated = false;
+	} else {
+		key = ERR_PTR(-EINVAL);
+	}
 	return key;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_extract_key);
diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index d15ab5e98fe1..0f45261c50f8 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -1037,19 +1037,29 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
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
-		dev_dbg(ctrl->device, "%s: revoke%s key %08x\n",
+		if (generated) {
+			dev_dbg(ctrl->device, "%s: revoke%s key %08x\n",
+				__func__, is_ctrl ? " ctrl" : "",
+				key_serial(key));
+			key_revoke(key);
+		}
+		dev_dbg(ctrl->device, "%s: drop%s key %08x\n",
 			__func__, is_ctrl ? " ctrl" : "",
 			key_serial(key));
-		key_revoke(key);
 		key_put(key);
 	}
 }
@@ -1079,6 +1089,8 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 			 key_serial(ctrl->opts->dhchap_key));
 		return -ENOKEY;
 	}
+	/* Key has been generated during option parsing */
+	ctrl->host_key_generated = false;
 	down_read(&ctrl->host_key->sem);
 	ret = key_validate(ctrl->host_key);
 	up_read(&ctrl->host_key->sem);
@@ -1105,6 +1117,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 				 key_serial(ctrl->opts->dhchap_ctrl_key));
 			return -ENOKEY;
 		}
+		ctrl->ctrl_key_generated = false;
 		down_read(&ctrl->ctrl_key->sem);
 		ret = key_validate(ctrl->ctrl_key);
 		up_read(&ctrl->ctrl_key->sem);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 009a6cf8a86b..6ec94c4f6075 100644
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
-		pr_debug("revoke dhchap key %08x\n",
+		if (opts->dhchap_key_generated) {
+			pr_debug("revoke dhchap key %08x\n",
+				 key_serial(opts->dhchap_key));
+			key_revoke(opts->dhchap_key);
+		}
+		pr_debug("drop dhchap key %08x\n",
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
index 95a3d8ce1201..4b0ef3182f4c 100644
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
index 89c84220e340..c1b4ef6c5233 100644
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
index e7a635d6037e..0f0f0608d6c8 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -581,13 +581,14 @@ static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
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
+		count = sysfs_emit(buf, "%08x\n", key_serial(key));
 	up_read(&key->sem);
 	return count;
 }
@@ -599,6 +600,7 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	struct nvmf_ctrl_options *opts = ctrl->opts;
 	struct key *key, *old_key;
 	char *dhchap_secret;
+	bool generated = false;
 	size_t len;
 	int ret;
 
@@ -611,8 +613,8 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 		return -ENOMEM;
 	memcpy(dhchap_secret, buf, len);
 	nvme_auth_stop(ctrl);
-	key = nvme_auth_extract_key(opts->keyring,
-				    dhchap_secret, count);
+	key = nvme_auth_extract_key(opts->keyring, dhchap_secret, len,
+				    &generated);
 	if (IS_ERR(key)) {
 		kfree(dhchap_secret);
 		return PTR_ERR(key);
@@ -622,19 +624,25 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	up_read(&key->sem);
 	if (ret) {
 		dev_warn(ctrl->dev, "key %08x invalidated\n", key_serial(key));
-		dev_dbg(ctrl->dev, "revoke key %08x\n", key_serial(key));
-		key_revoke(key);
+		if (generated) {
+			dev_dbg(ctrl->dev, "revoke key %08x\n", key_serial(key));
+			key_revoke(key);
+			synchronize_rcu();
+		}
 		key_put(key);
 		kfree(dhchap_secret);
 		return ret;
 	}
 	mutex_lock(&ctrl->dhchap_auth_mutex);
 	old_key = ctrl->host_key;
-	dev_dbg(ctrl->dev, "revoke key %08x\n",
-		key_serial(old_key));
-	key_revoke(old_key);
-
+	if (ctrl->host_key_generated) {
+		dev_dbg(ctrl->dev, "revoke key %08x\n",
+			key_serial(old_key));
+		key_revoke(old_key);
+		synchronize_rcu();
+	}
 	ctrl->host_key = key;
+	ctrl->host_key_generated = generated;
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	key_put(old_key);
 	kfree(dhchap_secret);
@@ -660,13 +668,14 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
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
+		count = sysfs_emit(buf, "%08x\n", key_serial(key));
 	up_read(&key->sem);
 	return count;
 }
@@ -678,6 +687,7 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 	struct nvmf_ctrl_options *opts = ctrl->opts;
 	struct key *key, *old_key;
 	char *dhchap_secret;
+	bool generated = false;
 	size_t len;
 	int ret;
 
@@ -690,8 +700,8 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 		return -ENOMEM;
 	memcpy(dhchap_secret, buf, len);
 	nvme_auth_stop(ctrl);
-	key = nvme_auth_extract_key(opts->keyring,
-				    dhchap_secret, count);
+	key = nvme_auth_extract_key(opts->keyring, dhchap_secret, len,
+				    &generated);
 	if (IS_ERR(key)) {
 		kfree(dhchap_secret);
 		return PTR_ERR(key);
@@ -701,18 +711,25 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 	up_read(&key->sem);
 	if (ret) {
 		dev_warn(ctrl->dev, "key %08x invalidated\n", key_serial(key));
-		dev_dbg(ctrl->dev, "revoke key %08x\n", key_serial(key));
-		key_revoke(key);
+		if (generated) {
+			dev_dbg(ctrl->dev, "revoke key %08x\n", key_serial(key));
+			key_revoke(key);
+			synchronize_rcu();
+		}
 		key_put(key);
 		kfree(dhchap_secret);
 		return ret;
 	}
 	mutex_lock(&ctrl->dhchap_auth_mutex);
 	old_key = ctrl->ctrl_key;
-	dev_dbg(ctrl->dev, "revoke key %08x\n",
-		key_serial(old_key));
-	key_revoke(old_key);
+	if (ctrl->ctrl_key_generated) {
+		dev_dbg(ctrl->dev, "revoke key %08x\n",
+			key_serial(old_key));
+		key_revoke(old_key);
+		synchronize_rcu();
+	}
 	ctrl->ctrl_key = key;
+	ctrl->ctrl_key_generated = generated;
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	key_put(old_key);
 	kfree(dhchap_secret);
@@ -738,13 +755,14 @@ static ssize_t dhchap_key_show(struct device *dev,
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
+		count = sysfs_emit(buf, "%08x\n", key_serial(ctrl->host_key));
 	up_read(&key->sem);
 	return count;
 }
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 59394587a875..3f9fad732350 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -23,23 +23,34 @@
 void nvmet_auth_revoke_key(struct nvmet_host *host, bool set_ctrl)
 {
 	struct key *key = ERR_PTR(-ENOKEY);
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
 	if (!IS_ERR(key)) {
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
@@ -48,6 +59,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl)
 {
 	unsigned char key_hash;
+	bool generated = false;
 	struct key *key;
 	size_t len;
 
@@ -57,7 +69,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 	}
 
 	len = strcspn(secret, "\n");
-	key = nvme_auth_extract_key(NULL, secret, len);
+	key = nvme_auth_extract_key(NULL, secret, len, &generated);
 	if (IS_ERR(key)) {
 		pr_debug("%s: invalid key specification\n", __func__);
 		return PTR_ERR(key);
@@ -87,8 +99,10 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 	nvmet_auth_revoke_key(host, set_ctrl);
 	if (set_ctrl) {
 		host->dhchap_ctrl_key = key;
+		host->dhchap_ctrl_key_generated = generated;
 	} else {
 		host->dhchap_key = key;
+		host->dhchap_key_generated = generated;
 	}
 	return 0;
 }
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 1b6ca46d1a64..2f308108159c 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -2114,13 +2114,14 @@ static ssize_t nvmet_host_dhchap_key_show(struct config_item *item,
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
+			ret = sprintf(page, "%08x\n", key_serial(key));
 		up_read(&key->sem);
 		key_put(key);
 	}
@@ -2161,13 +2162,14 @@ static ssize_t nvmet_host_dhchap_ctrl_key_show(struct config_item *item,
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
+			ret = sprintf(page, "%08x\n", key_serial(key));
 		up_read(&key->sem);
 		key_put(key);
 	}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index d23f9d122777..2a1c3850a8ac 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -375,7 +375,9 @@ static inline struct nvmet_subsys *namespaces_to_subsys(
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
index 4e53ef96eea7..a9ae1d60a5f9 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -18,7 +18,8 @@ const char *nvme_auth_digest_name(u8 hmac_id);
 size_t nvme_auth_hmac_hash_len(u8 hmac_id);
 u8 nvme_auth_hmac_id(const char *hmac_name);
 
-struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret, size_t secret_len);
+struct key *nvme_auth_extract_key(struct key *keyring, const u8 *secret, size_t secret_len,
+				  bool *generated);
 int nvme_auth_transform_key(struct key *key, char *nqn,
 			    u8 **transformed_secret);
 int nvme_auth_augmented_challenge(u8 hmac_id, u8 *skey, size_t skey_len,
-- 
2.35.3


