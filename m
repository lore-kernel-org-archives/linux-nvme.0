Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0C0606A32A
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 11:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lV8gox7n;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lvoMVI35
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=P70Wx6lspuBJtTgJ3x0gEXL2ml82eKQFWrUrkgUYaIY=; b=lV8gox7nIJAzGw
	hoY4Ds1oJfCJfWx+tmnnvGH5iixUoZLnqLQvF7N3Tbk3lEOw0X7nChxHzHbsfaNFaYkcFj6ZE785+
	cd31jvzYE90vRxW4K9VQNGJNPBQF9xlC4LHXov8NEM8mBx6lIUvyLNKb/aAubF9IJ2sz1xdA5fVOh
	W5iTWE1k9czra2qmqZd/3hETJpc+U1CDl52fCdxm6UZxPThecJY8opyhWYbmF7DJqCkxdJ6hDuZTH
	PcwyKEUOiT7D8/c2kvmWXUtarLrEw96e4L0aC2pkfIrXTon/80M4tvCcpx5e5XIfU0n0dnuYydV+K
	rgVkaRQ5CiK6LIoLGx9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMZl-0000000Ekqk-0BWv;
	Fri, 20 Nov 2026 11:14:41 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMZf-0000000Ekli-0Fbo
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 11:14:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6FD3E628D5;
	Fri, 20 Nov 2026 11:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A0341F000E0;
	Fri, 20 Nov 2026 11:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795173274;
	bh=P70Wx6lspuBJtTgJ3x0gEXL2ml82eKQFWrUrkgUYaIY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lvoMVI35q3C48EZqbeM/aWxzcIykXOKubdNlxTMhIVZPys+yZHFs+OETLAW0aq3xC
	 7SkLYDRhBQUro2Bvw8UrQzy1fn4nt8wpaTJzqNccQiWHOp40PauC6ZIA+XNwB0U3L+
	 HQkLAezFoH3sEkaXIK0aJKORGCotGja36P/UPBJORurwXRTRmlPSv6yHhm7HqI+Kqd
	 IcsIAQ+XyRHVcN5+0we9F65dkKTEwOGLp8vItdX238e6vgK1GaXIg+xjSJnr8bcky7
	 WFt38ReGVJpEtchTdo4EPjDksdy18e9FM/BeM70wtw15vI5lfBLws1+UAfvLdPkzEX
	 EdJm3Rk1E/KBg==
From: Hannes Reinecke <hare@kernel.org>
Date: Fri, 20 Nov 2026 12:14:05 +0100
Subject: [PATCH v4 6/9] nvme: allow to pass in key description as dhchap
 secret
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-dhchap-keyring-v4-v4-6-5f8c7d9926ee@kernel.org>
References: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
In-Reply-To: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795173255; l=18687;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=OXfQnPKI/l5iPofx/VfFy9MSa3bTHRHV4cnM1HpD10g=;
 b=s5BGOIlmlVGU/Y6VqfURgzJPMnBieCGr+1NdPabnW5echmtO2uqy9DRZhVDI7Gdfhgtp0cGnR
 VYZFVMq3EAlAJNAm9iV6fIALR7bTWpEZB6VUgafNF4TeXxprG+Ek+ZI
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

In order to use pre-populated keys update 'nvme_auth_extract_key()'
to accept a key serial number as argument in addition to the currently
implemented raw key data. To mark this change rename the 'secret'
parameter of that function to 'input', and add a function description
to document the usage.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/auth.c     | 24 +++++++++----
 drivers/nvme/host/auth.c       | 17 +++++++--
 drivers/nvme/host/fabrics.c    | 24 +++++++++----
 drivers/nvme/host/fabrics.h    |  4 +++
 drivers/nvme/host/nvme.h       |  2 ++
 drivers/nvme/host/sysfs.c      | 80 ++++++++++++++++++++++++++++--------------
 drivers/nvme/target/auth.c     | 25 ++++++++++---
 drivers/nvme/target/configfs.c | 10 +++---
 drivers/nvme/target/nvmet.h    |  2 ++
 include/linux/nvme-auth.h      |  2 +-
 10 files changed, 139 insertions(+), 51 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index b7092deed9b06e6ee9bcd819dc6e58ed15069c50..c65bfafe9e3fce4b9f74a382fbf96883ccccb062 100644
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
index c189096f825eab4e3053021d7437423ecb049c79..470a6e7e436449dadec1a728581dabb3e2c3b6d3 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -1027,19 +1027,29 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
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
@@ -1071,6 +1081,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 			 key_serial(ctrl->opts->dhchap_key));
 		return -ENOKEY;
 	}
+	ctrl->host_key_generated = ctrl->opts->dhchap_key_generated;
 	down_read(&ctrl->host_key->sem);
 	ret = key_validate(ctrl->host_key);
 	up_read(&ctrl->host_key->sem);
@@ -1097,6 +1108,8 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 				 key_serial(ctrl->opts->dhchap_ctrl_key));
 			return -ENOKEY;
 		}
+		ctrl->ctrl_key_generated =
+			ctrl->opts->dhchap_ctrl_key_generated;
 		down_read(&ctrl->ctrl_key->sem);
 		ret = key_validate(ctrl->ctrl_key);
 		up_read(&ctrl->ctrl_key->sem);
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 7ed8618257ca9fadc65202261a86b7ead209df7c..cd728768a68fc41135967cae44b1c3c5b0676dd3 100644
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
@@ -1089,7 +1091,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	if (host_secret) {
 		pr_debug("lookup host identity '%s'\n", host_secret);
 		key = nvme_auth_extract_key(opts->keyring, host_secret,
-					    strlen(host_secret));
+					    strlen(host_secret),
+					    &opts->dhchap_key_generated);
 		if (IS_ERR(key)) {
 			ret = PTR_ERR(key);
 			goto out;
@@ -1104,7 +1107,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		}
 		pr_debug("lookup ctrl identity '%s'\n", ctrl_secret);
 		key = nvme_auth_extract_key(opts->keyring, ctrl_secret,
-					    strlen(ctrl_secret));
+					    strlen(ctrl_secret),
+					    &opts->dhchap_ctrl_key_generated);
 		if (IS_ERR(key)) {
 			ret = PTR_ERR(key);
 			goto out;
@@ -1327,15 +1331,23 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
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
index 786f1b4819f076ac1f133070523be1780ec4d8b7..e55276356bdab4d8c738db329fee0c3a61afd510 100644
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
index 434e3612c996a969075aa5844c51906c605e6f56..1161f94cca19b1e223ebc4e2894c6e3ae7d6779a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -464,6 +464,8 @@ struct nvme_ctrl {
 	struct key *host_key;
 	struct key *ctrl_key;
 	u16 transaction;
+	bool host_key_generated;
+	bool ctrl_key_generated;
 #endif
 	key_serial_t tls_pskid;
 
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 1311f5e29b004436e39a723242748a150e36dc68..47caed2ce39786848a5acdb1dc50e4b156694086 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -828,13 +828,14 @@ static ssize_t dhchap_secret_show(struct device *dev,
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
@@ -846,6 +847,7 @@ static ssize_t dhchap_secret_store(struct device *dev,
 	struct nvmf_ctrl_options *opts = ctrl->opts;
 	struct key *key, *old_key;
 	char *dhchap_secret;
+	bool generated = false;
 	size_t len;
 	int ret;
 
@@ -859,7 +861,8 @@ static ssize_t dhchap_secret_store(struct device *dev,
 	memcpy(dhchap_secret, buf, len);
 	nvme_auth_stop(ctrl);
 
-	key = nvme_auth_extract_key(opts->keyring, dhchap_secret, count);
+	key = nvme_auth_extract_key(opts->keyring, dhchap_secret,
+				    len, &generated);
 	if (IS_ERR(key)) {
 		kfree_sensitive(dhchap_secret);
 		return PTR_ERR(key);
@@ -869,19 +872,25 @@ static ssize_t dhchap_secret_store(struct device *dev,
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
 		kfree_sensitive(dhchap_secret);
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
 	kfree_sensitive(dhchap_secret);
@@ -906,13 +915,14 @@ static ssize_t dhchap_ctrl_secret_show(struct device *dev,
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
@@ -924,6 +934,7 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 	struct nvmf_ctrl_options *opts = ctrl->opts;
 	struct key *key, *old_key;
 	char *dhchap_secret;
+	bool generated = false;
 	size_t len;
 	int ret;
 
@@ -936,7 +947,8 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 		return -ENOMEM;
 	memcpy(dhchap_secret, buf, len);
 	nvme_auth_stop(ctrl);
-	key = nvme_auth_extract_key(opts->keyring, dhchap_secret, count);
+	key = nvme_auth_extract_key(opts->keyring, dhchap_secret, len,
+				    &generated);
 	if (IS_ERR(key)) {
 		kfree_sensitive(dhchap_secret);
 		return PTR_ERR(key);
@@ -946,19 +958,25 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
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
 		kfree_sensitive(dhchap_secret);
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
 	kfree_sensitive(dhchap_secret);
@@ -983,13 +1001,8 @@ static ssize_t dhchap_key_show(struct device *dev,
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
@@ -999,10 +1012,19 @@ static ssize_t dhchap_ctrl_key_show(struct device *dev,
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
 static DEVICE_ATTR_ADMIN_RO(dhchap_ctrl_key);
 #endif
@@ -1066,8 +1088,12 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
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
index 33b45b4b202d4b36956d2e1cf0a4036692779f22..4f2489c5d894b24f25eea8e55e26d2afa7ea40b1 100644
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
 
@@ -56,7 +68,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		return 0;
 	}
 	len = strcspn(secret, "\n");
-	key = nvme_auth_extract_key(NULL, secret, len);
+	key = nvme_auth_extract_key(NULL, secret, len, &generated);
 	if (IS_ERR(key)) {
 		pr_debug("%s: invalid key specification\n", __func__);
 		return PTR_ERR(key);
@@ -72,10 +84,13 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 	up_read(&key->sem);
 	down_write(&nvmet_config_sem);
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
 	up_write(&nvmet_config_sem);
 	return 0;
 }
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 880cf5151588a382045e83952b1f64b95a432ca8..319947aa0a40f918e15e9e2130ebf3a79e2d6efe 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -2248,13 +2248,14 @@ static ssize_t nvmet_host_dhchap_key_show(struct config_item *item,
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
@@ -2305,13 +2306,14 @@ static ssize_t nvmet_host_dhchap_ctrl_key_show(struct config_item *item,
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
index e708c80e8426f426adf4e98defaa9e77e30d9a58..c8757cedcd841742ff79c830335cfab6e9fc2401 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -400,7 +400,9 @@ static inline struct nvmet_subsys *namespaces_to_subsys(
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
index b8ea0945131d193e9343a5e9fd703f0a4ba3dfec..506d903017352782bb58e4b4e2a8b835fd56a60d 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -38,7 +38,7 @@ void nvme_auth_hmac_update(struct nvme_auth_hmac_ctx *hmac, const u8 *data,
 void nvme_auth_hmac_final(struct nvme_auth_hmac_ctx *hmac, u8 *out);
 
 struct key *nvme_auth_extract_key(struct key *keyring, const char *secret,
-				  size_t secret_len);
+				  size_t secret_len, bool *generated);
 int nvme_auth_transform_key(struct key *key, const char *nqn,
 			    u8 **transformed_secret);
 int nvme_auth_augmented_challenge(u8 hmac_id, const u8 *skey, size_t skey_len,

-- 
2.51.0


