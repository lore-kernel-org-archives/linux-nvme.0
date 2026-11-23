Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACA4606A32E
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 12:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wBNYGMCY;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVA2J/Sv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=pJ57+d4n/+UchBaK2UPo37XoIh3mVMaJp36IhsS/t50=; b=wBNYGMCYgR7N6F
	unK9evoUAfjcpPjNhbVCvOveOHBUhlfM5GVejcB4gIjGr1tb34tfN8rmtp6sGA/qlu8ya2xANghL1
	EeMj8m0KmCj8vKud79/DHlZoQdH3WeP7VKs8669dRFMKHPKyEZhqII+OMa2RPhFGq05IfOcfLr8nO
	MQS35GplOLg2qSU0ox96K2MCAlLJ0ynw8/DO8iotAqvNqiSMDoVSqbkoUz8Fjmfl/0ilgSKevFRNE
	o7ZwADtkk46nT6lHL/b+7/no7ejpfbeGst7agtY5O2KDIO+WmT0KLT2AoE4CGJGK+bNvJtDThQDvW
	tEYaWKO5a8kCy7MJx5jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVSx2-00000003JVJ-0DvB;
	Mon, 23 Nov 2026 12:15:16 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVSx0-00000003JTb-2H4b
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 12:15:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4D83444EDA;
	Mon, 23 Nov 2026 12:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8921F00ADE;
	Mon, 23 Nov 2026 12:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795436114;
	bh=pJ57+d4n/+UchBaK2UPo37XoIh3mVMaJp36IhsS/t50=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PVA2J/SvUpbc+JWzNUlcFmbdM/1sSs3ACSz4WdbvEUMPxe2lK3Jo4zn5RbKnW74eO
	 E9eOXoKFyNiEFmLJu3QRO0UAxsT72WeNJkv9sofIfH279aMOgIi01IvYXMuLOUSUwl
	 XAGMVk0biMRXp+oaoI86W8Sie9Ibj4Ofb0E3zOC+ZQVdUeKA+cLbWaT4y6pevszrC/
	 0J9y/K71u7FRN73TL1hRK1Gvh1SKixIGv0cEMueTJuTmAx8UtPUR826k2JjTlau3if
	 d1NwxkvRm4ynYorlnJSYF27s2y9etvWYlsGrILlPH6rDjBKFr2wFLGyqQrg9OYHdvk
	 0ZsxK3/tl54wA==
From: Hannes Reinecke <hare@kernel.org>
Date: Mon, 23 Nov 2026 13:14:51 +0100
Subject: [PATCH v5 6/9] nvme: allow to pass in key description as dhchap
 secret
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-dhchap-keyring-v4-v5-6-81eefb4c0724@kernel.org>
References: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
In-Reply-To: <20261123-dhchap-keyring-v4-v5-0-81eefb4c0724@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795436094; l=18922;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=nHoHJmHSzY5c6dclx6HlWw86z94RAG6JQoT1NCahSrc=;
 b=2jkBOR29W3uEufPQD6s+N72Qb+5go6K7KBzilBT0/VQRifW5zV3l0ba/9SIe40uLvDP5TmUnT
 Bftn1CeP/LdCckQ98RajrA0gJCyW0Z5DF3QEan8w5SsHR+r2T++64zY
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
 drivers/nvme/common/auth.c     | 24 ++++++++++++----
 drivers/nvme/host/auth.c       | 19 +++++++++++--
 drivers/nvme/host/fabrics.c    | 26 ++++++++++++++----
 drivers/nvme/host/fabrics.h    |  4 +++
 drivers/nvme/host/nvme.h       |  2 ++
 drivers/nvme/host/sysfs.c      | 62 ++++++++++++++++++++++++++++--------------
 drivers/nvme/target/auth.c     | 25 +++++++++++++----
 drivers/nvme/target/configfs.c | 10 ++++---
 drivers/nvme/target/nvmet.h    |  2 ++
 include/linux/nvme-auth.h      |  2 +-
 10 files changed, 132 insertions(+), 44 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index ee26fb416ee6281ca9b101a5b00847736fd75b98..abdad41daa8fb62d8b5c656927a02f72c5403739 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -144,20 +144,32 @@ EXPORT_SYMBOL_GPL(nvme_auth_hmac_hash_len);
  * nvme_auth_extract_key - extract the DH-HMAC-CHAP key
  *
  * @keyring: keyring to be used for the resulting key
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
index 535cc433dd35d305a40604f99627e4a248262f17..98913eaeb6d6884c61bcd8ccfb838dc246e9b9f2 100644
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
@@ -1051,6 +1061,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dhchap_queue_context *chap;
 	struct key *host_key, *ctrl_key = NULL;
+	bool host_key_generated, ctrl_key_generated;
 	int i, ret;
 
 	mutex_init(&ctrl->dhchap_auth_mutex);
@@ -1080,6 +1091,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 		key_put(host_key);
 		return -ENOKEY;
 	}
+	host_key_generated = ctrl->opts->dhchap_key_generated;
 
 	if (ctrl->opts->dhchap_ctrl_key) {
 		ctrl_key = key_get(ctrl->opts->dhchap_ctrl_key);
@@ -1101,6 +1113,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 			key_put(host_key);
 			return -EKEYREVOKED;
 		}
+		ctrl_key_generated = ctrl->opts->dhchap_ctrl_key_generated;
 	}
 
 	dev_dbg(ctrl->device,
@@ -1109,6 +1122,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 	if (ctrl->host_key)
 		nvme_auth_clear_host_key(ctrl);
 	ctrl->host_key = host_key;
+	ctrl->host_key_generated = host_key_generated;
 
 	if (ctrl->ctrl_key)
 		nvme_auth_clear_ctrl_key(ctrl);
@@ -1117,6 +1131,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 			"%s: using dhchap ctrl key %08x\n",
 			__func__, key_serial(ctrl->ctrl_key));
 		ctrl->ctrl_key = ctrl_key;
+		ctrl->ctrl_key_generated = ctrl_key_generated;
 	}
 
 	ctrl->dhchap_ctxs = kvzalloc_objs(*chap, ctrl_max_dhchaps(ctrl));
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 0c09888be31f773491d4e8d2e474f8c27951340b..1277749c6e2e3012b5161a7d03589a6ced300a05 100644
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
@@ -1090,7 +1092,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 #ifdef CONFIG_NVME_HOST_AUTH
 		pr_debug("lookup host identity '%s'\n", host_secret);
 		key = nvme_auth_extract_key(opts->keyring, host_secret,
-					    strlen(host_secret));
+					    strlen(host_secret),
+					    &opts->dhchap_key_generated);
 		if (IS_ERR(key)) {
 			ret = PTR_ERR(key);
 			goto out;
@@ -1111,7 +1114,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		}
 		pr_debug("lookup ctrl identity '%s'\n", ctrl_secret);
 		key = nvme_auth_extract_key(opts->keyring, ctrl_secret,
-					    strlen(ctrl_secret));
+					    strlen(ctrl_secret),
+					    &opts->dhchap_ctrl_key_generated);
 		if (IS_ERR(key)) {
 			ret = PTR_ERR(key);
 			goto out;
@@ -1339,15 +1343,25 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
 	kfree(opts->host_traddr);
 	kfree(opts->host_iface);
 	if (opts->dhchap_key) {
-		pr_debug("revoke dhchap host key %08x\n",
+		if (opts->dhchap_key_generated) {
+			pr_debug("revoke dhchap host key %08x\n",
+				 key_serial(opts->dhchap_key));
+			key_revoke(opts->dhchap_key);
+			synchronize_rcu();
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
+			key_revoke(opts->dhchap_ctrl_key);
+			synchronize_rcu();
+		}
+		pr_debug("drop dhchap ctrl key %08x\n",
 			 key_serial(opts->dhchap_ctrl_key));
-		key_revoke(opts->dhchap_ctrl_key);
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
index e73c3ad89adc0db02e8ff1b072f4f0194e5a0999..e6d42da84e1688110eb81e59161dc7c497bd0627 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -833,13 +833,14 @@ static ssize_t dhchap_secret_show(struct device *dev,
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
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	return count;
@@ -852,6 +853,7 @@ static ssize_t dhchap_secret_store(struct device *dev,
 	struct nvmf_ctrl_options *opts = ctrl->opts;
 	struct key *key, *old_key;
 	char *dhchap_secret;
+	bool generated = false;
 	size_t len;
 	int ret;
 
@@ -865,7 +867,8 @@ static ssize_t dhchap_secret_store(struct device *dev,
 	memcpy(dhchap_secret, buf, len);
 	nvme_auth_stop(ctrl);
 
-	key = nvme_auth_extract_key(opts->keyring, dhchap_secret, count);
+	key = nvme_auth_extract_key(opts->keyring, dhchap_secret,
+				    len, &generated);
 	if (IS_ERR(key)) {
 		kfree_sensitive(dhchap_secret);
 		return PTR_ERR(key);
@@ -875,19 +878,25 @@ static ssize_t dhchap_secret_store(struct device *dev,
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
@@ -913,16 +922,18 @@ static ssize_t dhchap_ctrl_secret_show(struct device *dev,
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		return sysfs_emit(buf, "none\n");
 	}
+
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
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	return count;
@@ -935,6 +946,7 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 	struct nvmf_ctrl_options *opts = ctrl->opts;
 	struct key *key, *old_key;
 	char *dhchap_secret;
+	bool generated = false;
 	size_t len;
 	int ret;
 
@@ -947,7 +959,8 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 		return -ENOMEM;
 	memcpy(dhchap_secret, buf, len);
 	nvme_auth_stop(ctrl);
-	key = nvme_auth_extract_key(opts->keyring, dhchap_secret, count);
+	key = nvme_auth_extract_key(opts->keyring, dhchap_secret, len,
+				    &generated);
 	if (IS_ERR(key)) {
 		kfree_sensitive(dhchap_secret);
 		return PTR_ERR(key);
@@ -957,19 +970,25 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
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
@@ -1025,6 +1044,7 @@ static ssize_t dhchap_ctrl_key_show(struct device *dev,
 	}
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	return count;
+
 }
 static DEVICE_ATTR_ADMIN_RO(dhchap_ctrl_key);
 #endif
@@ -1090,9 +1110,11 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 		return 0;
 	if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
 		return 0;
-	if (a == &dev_attr_dhchap_key.attr && !ctrl->opts)
+	if (a == &dev_attr_dhchap_key.attr && !ctrl->opts &&
+	    !ctrl->host_key_generated)
 		return 0;
-	if (a == &dev_attr_dhchap_ctrl_key.attr && !ctrl->opts)
+	if (a == &dev_attr_dhchap_ctrl_key.attr && !ctrl->opts &&
+	    !ctrl->ctrl_key_generated)
 		return 0;
 #endif
 
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 8b77164512c9cb2d50ee5cdd45152b15f425ca92..7204ace149565205241b7a85ab62389dafa980b6 100644
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
index 12c093f4c8363927b5d41d0cc4445db50d8202b0..bc46d760aaa4a3316e6c62390cebf32092e5062f 100644
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
index 75e1e75e298e1c3b408ea234705edd7abf788d1d..d5fbae8fc510b08579454b992cd4286bfb8c4f48 100644
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
2.51.0


