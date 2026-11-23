Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558A7606A339
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 17:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=tWAiKdDM;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N9kqD+F2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=oQ00Ro+pyAE2x3TngY5j1GWplbKI+S0D/0TXG5ucQtY=; b=tWAiKdDMGQoZS7
	unn2kBjC2TcKlMNJGUY5zfArOYeYe6anYl5/dekviwFbyysu4hfkk2QUz9Dt4RU/k5Vn31z4ICCfM
	1tPGv2pQU6nILGExsGqbyydRlMZx28dhvGyA4q2+B+bnW7l7R2U9Ds20X/nO163fb8FVUxG4JT7fQ
	6rlLXAx31KrM8qMqTW5+MIZ51WjDTsREYwqvqS4JdOLsTiIYi/X8ZAfu6oTcblHNDIXQQ+84wIy8C
	1XL1GWyuK9GcUwSIfU63acB5vxTg0GSh6fmvev96SVnfI0D3F4g0WerPhyS76otBYFwT7I69u78Ef
	K6qEAsYbydY2967FjvRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXYn-00000004IwR-3wLY;
	Mon, 23 Nov 2026 17:10:33 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXYl-00000004ItC-1LsA
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 17:10:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 41AA3623BC;
	Mon, 23 Nov 2026 17:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E02C11F000E6;
	Mon, 23 Nov 2026 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795453829;
	bh=oQ00Ro+pyAE2x3TngY5j1GWplbKI+S0D/0TXG5ucQtY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=N9kqD+F2wouvClS06vZTjiug8OIb+0FERSwWkDbx66EN0pk8kyyQHKZMqJQzOu+l0
	 7Wv8Eso28bwn0KjukZe7mOxR7fFcyF/hqS5O3eSVXkmYEj7//3AzRPBgWQcRxqzJtL
	 wQWqNxd066xlpCi6W4Rp6W2TW37rNoY4rpjoNo3p+ka7F7uWnb7R0o90fW7eW7MJcn
	 U/ZoooSPqFDdaShdKYME7hrKUkU0m0iYGkfCys70Kzy06SgopZ5PMQpchjzE+BpMYi
	 yOd6Cpiyp83JvCrBlEce+mzmfK3c8Je96TkhKPl97pi9vEWGljZk+imesdfz4SYlh3
	 gRkX4iprGA0zg==
From: Hannes Reinecke <hare@kernel.org>
Date: Mon, 23 Nov 2026 18:10:06 +0100
Subject: [PATCH v6 6/9] nvme: allow to pass in key description as dhchap
 secret
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261123-dhchap-keyring-v4-v6-6-5082a49715ab@kernel.org>
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
In-Reply-To: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795453811; l=19040;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=tQngp04dHaUqycluBa+HsPttsl0bAEIhpAXbSP+WyxY=;
 b=hNs6OgEN0KnnmfJ6fYSkANNWClBuqZpgXR6mGw/qFLsu6RxNptydLpv/9HFoNqHaBFUgMGTj4
 0m8cgeUOXOjDnHvmD8mQgB8iaP2fS7twSYZ8YbBhD/M+1Z4K/+zARR/
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
 drivers/nvme/common/auth.c     | 24 ++++++++++----
 drivers/nvme/host/auth.c       | 19 +++++++++--
 drivers/nvme/host/fabrics.c    | 24 ++++++++++----
 drivers/nvme/host/fabrics.h    |  4 +++
 drivers/nvme/host/nvme.h       |  2 ++
 drivers/nvme/host/sysfs.c      | 74 ++++++++++++++++++++++++++++++------------
 drivers/nvme/target/auth.c     | 24 +++++++++++---
 drivers/nvme/target/configfs.c | 12 ++++---
 drivers/nvme/target/nvmet.h    |  2 ++
 include/linux/nvme-auth.h      |  4 +--
 10 files changed, 143 insertions(+), 46 deletions(-)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index 158c9cb886c15ef116d613bf0f6bb55960d8d3ee..8c8459501825871fe975f24800b33f4255423eb4 100644
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
index 26e8f321650e703f043763d6f5ee5ad72db234e6..2c73da4cd3c61e491d8f20300b28aada32615247 100644
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
@@ -1078,6 +1089,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 		key_put(host_key);
 		return -ENOKEY;
 	}
+	host_key_generated = ctrl->opts->dhchap_key_generated;
 
 	if (ctrl->opts->dhchap_ctrl_key) {
 		ctrl_key = key_get(ctrl->opts->dhchap_ctrl_key);
@@ -1097,6 +1109,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 			key_put(host_key);
 			return -EKEYREVOKED;
 		}
+		ctrl_key_generated = ctrl->opts->dhchap_ctrl_key_generated;
 	}
 
 	pr_debug("%s: using dhchap host key %08x\n",
@@ -1104,6 +1117,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 	if (ctrl->host_key)
 		nvme_auth_clear_host_key(ctrl);
 	ctrl->host_key = host_key;
+	ctrl->host_key_generated = host_key_generated;
 
 	if (ctrl->ctrl_key)
 		nvme_auth_clear_ctrl_key(ctrl);
@@ -1111,6 +1125,7 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 		pr_debug("%s: using dhchap ctrl key %08x\n",
 			 __func__, key_serial(ctrl_key));
 		ctrl->ctrl_key = ctrl_key;
+		ctrl->ctrl_key_generated = ctrl_key_generated;
 	}
 
 	ctrl->dhchap_ctxs = kvzalloc_objs(*chap, ctrl_max_dhchaps(ctrl));
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 704e7ec7126543cb0b816149a81b23d05e37370d..2937e5dc9ecd22fd3eb684e2dce909b41e5a6e20 100644
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
@@ -1107,7 +1110,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		}
 		pr_debug("lookup ctrl identity '%s'\n", ctrl_secret);
 		key = nvme_auth_extract_key(opts->keyring, ctrl_secret,
-					    strlen(ctrl_secret));
+					    strlen(ctrl_secret),
+					    &opts->dhchap_ctrl_key_generated);
 		if (IS_ERR(key)) {
 			ret = PTR_ERR(key);
 			goto out;
@@ -1331,15 +1335,23 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
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
+			key_revoke(opts->dhchap_ctrl_key);
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
index 6fab0d217e7496ff404af8565b6007a54bd50808..c94abb901a73c880d354d9c1223d89fe5c9b0e89 100644
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
@@ -874,22 +877,34 @@ static ssize_t dhchap_secret_store(struct device *dev,
 	ret = key_validate(key);
 	up_read(&key->sem);
 	if (ret) {
-		dev_warn(ctrl->device, "key %08x invalidated\n",
+		dev_warn(ctrl->dev, "key %08x invalidated\n",
 			 key_serial(key));
-		dev_dbg(ctrl->device, "revoke host key %08x\n",
-			key_serial(key));
-		key_revoke(key);
+		if (generated) {
+			dev_dbg(ctrl->dev, "revoke host key %08x\n",
+				key_serial(key));
+			key_revoke(key);
+		}
 		key_put(key);
 		kfree_sensitive(dhchap_secret);
 		return ret;
 	}
 	mutex_lock(&ctrl->dhchap_auth_mutex);
 	old_key = ctrl->host_key;
-	dev_dbg(ctrl->device, "revoke host key %08x\n",
-		key_serial(old_key));
-	key_revoke(old_key);
-
+	if (old_key && key_serial(old_key) == key_serial(key)) {
+		dev_warn(ctrl->device, "key %08x already present\n",
+			 key_serial(key));
+		mutex_unlock(&ctrl->dhchap_auth_mutex);
+		key_put(key);
+		kfree_sensitive(dhchap_secret);
+		return -EBUSY;
+	}
+	if (ctrl->host_key_generated) {
+		dev_dbg(ctrl->dev, "revoke host key %08x\n",
+			key_serial(old_key));
+		key_revoke(old_key);
+	}
 	ctrl->host_key = key;
+	ctrl->host_key_generated = generated;
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	key_put(old_key);
 	kfree_sensitive(dhchap_secret);
@@ -915,16 +930,18 @@ static ssize_t dhchap_ctrl_secret_show(struct device *dev,
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		return sysfs_emit(buf, "none\n");
 	}
+
 	down_read(&key->sem);
 	if (key_validate(key))
 		count = sysfs_emit(buf, "<invalidated>\n");
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
@@ -937,6 +954,7 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 	struct nvmf_ctrl_options *opts = ctrl->opts;
 	struct key *key, *old_key;
 	char *dhchap_secret;
+	bool generated = false;
 	size_t len;
 	int ret;
 
@@ -949,7 +967,8 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 		return -ENOMEM;
 	memcpy(dhchap_secret, buf, len);
 	nvme_auth_stop(ctrl);
-	key = nvme_auth_extract_key(opts->keyring, dhchap_secret, count);
+	key = nvme_auth_extract_key(opts->keyring, dhchap_secret, len,
+				    &generated);
 	if (IS_ERR(key)) {
 		kfree_sensitive(dhchap_secret);
 		return PTR_ERR(key);
@@ -960,20 +979,32 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 	if (ret) {
 		dev_warn(ctrl->device, "key %08x invalidated\n",
 			 key_serial(key));
-		dev_dbg(ctrl->device, "revoke ctrl key %08x\n",
-			key_serial(key));
-		key_revoke(key);
+		if (generated) {
+			dev_dbg(ctrl->device, "revoke ctrl key %08x\n",
+				key_serial(key));
+			key_revoke(key);
+		}
 		key_put(key);
 		kfree_sensitive(dhchap_secret);
 		return ret;
 	}
 	mutex_lock(&ctrl->dhchap_auth_mutex);
 	old_key = ctrl->ctrl_key;
-	dev_dbg(ctrl->device, "revoke ctrl key %08x\n",
-		key_serial(old_key));
-	key_revoke(old_key);
-
+	if (old_key && key_serial(old_key) == key_serial(key)) {
+		dev_warn(ctrl->device, "ctrl key %08x already present\n",
+			 key_serial(key));
+		mutex_unlock(&ctrl->dhchap_auth_mutex);
+		key_put(key);
+		kfree_sensitive(dhchap_secret);
+		return -EBUSY;
+	}
+	if (ctrl->ctrl_key_generated) {
+		dev_dbg(ctrl->dev, "revoke ctrl key %08x\n",
+			key_serial(old_key));
+		key_revoke(old_key);
+	}
 	ctrl->ctrl_key = key;
+	ctrl->ctrl_key_generated = generated;
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	key_put(old_key);
 	kfree_sensitive(dhchap_secret);
@@ -1029,6 +1060,7 @@ static ssize_t dhchap_ctrl_key_show(struct device *dev,
 	}
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
 	return count;
+
 }
 static DEVICE_ATTR_ADMIN_RO(dhchap_ctrl_key);
 #endif
diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 6348c810bd1685fc2d51364cf86785376b354983..c3fa4ab78fb94a34390e0ef9c0ce68df95392741 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -22,23 +22,33 @@
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
+		}
+		pr_debug("%s: drop %s key %08x\n",
 			 __func__, set_ctrl ? "ctrl" : "host",
 			 key_serial(key));
-		key_revoke(key);
 		key_put(key);
 	}
 }
@@ -46,6 +56,7 @@ void nvmet_auth_revoke_key(struct nvmet_host *host, bool set_ctrl)
 int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		       bool set_ctrl)
 {
+	bool generated = false;
 	struct key *key;
 	size_t len;
 
@@ -56,7 +67,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		return 0;
 	}
 	len = strcspn(secret, "\n");
-	key = nvme_auth_extract_key(NULL, secret, len);
+	key = nvme_auth_extract_key(NULL, secret, len, &generated);
 	if (IS_ERR(key)) {
 		pr_debug("%s: invalid key specification\n", __func__);
 		return PTR_ERR(key);
@@ -72,10 +83,13 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
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
index 12c093f4c8363927b5d41d0cc4445db50d8202b0..e19af764561ec4eec504f0ce4e6f301a0dded257 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -2248,13 +2248,15 @@ static ssize_t nvmet_host_dhchap_key_show(struct config_item *item,
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
+			ret = scnprintf(page, PAGE_SIZE,
+					"%s\n", key->description);
 		up_read(&key->sem);
 		key_put(key);
 	}
@@ -2305,13 +2307,15 @@ static ssize_t nvmet_host_dhchap_ctrl_key_show(struct config_item *item,
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
+			ret = scnprintf(page, PAGE_SIZE,
+					"%s\n", key->description);
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
index 75e1e75e298e1c3b408ea234705edd7abf788d1d..99400ee0fcd96b647ac6666bae0c9f6f9047e87f 100644
--- a/include/linux/nvme-auth.h
+++ b/include/linux/nvme-auth.h
@@ -31,8 +31,8 @@ void nvme_auth_hmac_update(struct nvme_auth_hmac_ctx *hmac, const u8 *data,
 			   size_t data_len);
 void nvme_auth_hmac_final(struct nvme_auth_hmac_ctx *hmac, u8 *out);
 
-struct key *nvme_auth_extract_key(struct key *keyring, const char *secret,
-				  size_t secret_len);
+struct key *nvme_auth_extract_key(struct key *keyring, const char *input,
+				  size_t input_len, bool *generated);
 int nvme_auth_transform_key(struct key *key, const char *nqn,
 			    u8 **transformed_secret);
 int nvme_auth_augmented_challenge(u8 hmac_id, const u8 *skey, size_t skey_len,

-- 
2.51.0


