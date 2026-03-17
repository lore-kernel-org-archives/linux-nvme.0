Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3ACAFD8765
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 13:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fNh0YqD7jZutivTaMNqQAzA0yWogDhL/1LiiOcMpu/c=; b=VwqiPT59oClklF285HXurfyO9d
	dk2JVj0nf9rd/oSw+IO2RCm9fZieR3to/n7mVtO52JfhvyVJQ1JVgZWij8G/+gYe4sebR6enV1NnQ
	MMn/g70Qj5zJZ3KLPtK+ybzT9efDEcTsw/hnyGMbdj+ZK+9WgC2fg/HXysxV4j1e/4CDhH0SX1Y+E
	UeDBjt3kbzrkaEPP4AbqP8UoQOTXGrWjMGwX3iZQsgCefTJ0xOHZp7gywK3myhCch9bEXVPBJIcVz
	I4rJBNWwGGeVwKcGDngOeNPOVh8NzFEdruO5YvjOBHT2+ruUM5Q0QNJrzsp3AWRXT5akFOeB4Tc3E
	DT+Trsag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2U33-00000006LgZ-2zX7;
	Tue, 17 Mar 2026 13:01:25 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2U32-00000006LfD-2Ay9
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 13:01:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D227C600CB;
	Tue, 17 Mar 2026 13:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C11C2BCB1;
	Tue, 17 Mar 2026 13:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773752483;
	bh=l+Fmc8cGtiKzMXZXyQVHXXOFojryx0Mdg15vSQbNJEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bnFyNKzGkdg66CU5M6ZkTkd18jSg1JWWbnhmxIn6PEWQ8Y4/z9cRXG4cuWZGkBliF
	 2HMXzkCV1c+y01ols7Od/D8uGFihYbSXLOwFpuYWbGeSArlHmGf9eNWBSgoTSdOj2k
	 lxq+UkBG1tuJ1AI/HrxfnFWG+7GXnkgYSBfVn9+IsxN/aKpNYRI+q0qw9Zwq6STe4S
	 AxbCK3OAwzL0d4NHkSh7cYJl/er5xM9rc8dAAKMT4gORLg4puEw6FqKlpgxRD4Grht
	 yNQn029F26GgKiMiX75/9x3a7cg/6HfVTf6SmIacU2Cd7TWwAf6VuSnKjiP3sPXbSe
	 iM0SEr6VUIQEQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 4/8] nvme: parse dhchap keys during option parsing
Date: Tue, 17 Mar 2026 14:00:59 +0100
Message-ID: <20260317130103.107360-5-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317130103.107360-1-hare@kernel.org>
References: <20260317130103.107360-1-hare@kernel.org>
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

We really should parse the dhchap keys during option parsing to avoid
having to pass around the plain dhchap secret. During options parsing
we will create a 'dhchap' key with a random UUID as description, and
store the key serial in the 'opts' structure.
This simplifies key handling as on every access the key needs to be
looked up and checked for validity before accessing the key data.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/auth.c    | 118 +++++++++++++++--------
 drivers/nvme/host/fabrics.c |  82 +++++++++++-----
 drivers/nvme/host/fabrics.h |   8 +-
 drivers/nvme/host/sysfs.c   | 185 ++++++++++++++++++++++++++----------
 4 files changed, 275 insertions(+), 118 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index e7c0ed55e2ba..5c4505a92a80 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -923,11 +923,6 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 		return -ENOKEY;
 	}
 
-	if (ctrl->opts->dhchap_ctrl_secret && !ctrl->ctrl_key) {
-		dev_warn(ctrl->device, "qid %d: invalid ctrl key\n", qid);
-		return -ENOKEY;
-	}
-
 	chap = &ctrl->dhchap_ctxs[qid];
 	cancel_work_sync(&chap->auth_work);
 	queue_work(nvme_auth_wq, &chap->auth_work);
@@ -1012,6 +1007,29 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
 	}
 }
 
+static void nvme_auth_clear_key(struct nvme_ctrl *ctrl, bool is_ctrl)
+{
+	struct key *key;
+
+	if (is_ctrl) {
+		key = ctrl->ctrl_key;
+		ctrl->ctrl_key = NULL;
+	} else {
+		key = ctrl->host_key;
+		ctrl->host_key = NULL;
+	}
+	if (key) {
+		dev_dbg(ctrl->device, "%s: revoke dhchap%s key %08x\n",
+			__func__, is_ctrl ? " ctrl" : " host",
+			key_serial(key));
+		key_revoke(key);
+		key_put(key);
+	}
+}
+
+#define nvme_auth_clear_host_key(c) nvme_auth_clear_key(c, false)
+#define nvme_auth_clear_ctrl_key(c) nvme_auth_clear_key(c, true)
+
 int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dhchap_queue_context *chap;
@@ -1021,31 +1039,68 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
 	if (!ctrl->opts)
 		return 0;
-	ctrl->host_key = nvme_auth_extract_key(ctrl->opts->keyring,
-				ctrl->opts->dhchap_secret,
-				strlen(ctrl->opts->dhchap_secret));
-	if (IS_ERR(ctrl->host_key)) {
-		ret = PTR_ERR(ctrl->host_key);
-		ctrl->host_key = NULL;
-		return ret;
+	if (!ctrl->opts->dhchap_key) {
+		nvme_auth_clear_host_key(ctrl);
+		nvme_auth_clear_ctrl_key(ctrl);
+		return 0;
 	}
+	if (!ctrl->host_key)
+		nvme_auth_clear_host_key(ctrl);
 
-	ctrl->ctrl_key = nvme_auth_extract_key(ctrl->opts->keyring,
-				ctrl->opts->dhchap_ctrl_secret,
-				strlen(ctrl->opts->dhchap_ctrl_secret));
-	if (IS_ERR(ctrl->ctrl_key)) {
-		ret = PTR_ERR(ctrl->ctrl_key);
-		ctrl->ctrl_key = NULL;
-		goto err_free_dhchap_secret;
+	ctrl->host_key = key_get(ctrl->opts->dhchap_key);
+	if (!ctrl->host_key) {
+		dev_warn(ctrl->device,
+			 "dhchap host key %08x not present\n",
+			 key_serial(ctrl->opts->dhchap_key));
+		return -ENOKEY;
 	}
+	down_read(&ctrl->host_key->sem);
+	ret = key_validate(ctrl->host_key);
+	up_read(&ctrl->host_key->sem);
+	if (ret) {
+		dev_warn(ctrl->device,
+			 "dhchap host key %08x invalidated\n",
+			 key_serial(ctrl->host_key));
+		key_put(ctrl->host_key);
+		ctrl->host_key = NULL;
+		return -ENOKEY;
+	}
+	dev_dbg(ctrl->device,
+		"%s: using dhchap host key %08x\n",
+		__func__, key_serial(ctrl->host_key));
 
-	if (!ctrl->opts->dhchap_secret && !ctrl->opts->dhchap_ctrl_secret)
-		return 0;
+	if (ctrl->ctrl_key)
+		nvme_auth_clear_ctrl_key(ctrl);
+
+	if (ctrl->opts->dhchap_ctrl_key) {
+		ctrl->ctrl_key = key_get(ctrl->opts->dhchap_ctrl_key);
+		if (!ctrl->ctrl_key) {
+			dev_warn(ctrl->device,
+				 "dhchap ctrl key %08x not present\n",
+				 key_serial(ctrl->opts->dhchap_ctrl_key));
+			return -ENOKEY;
+		}
+		down_read(&ctrl->ctrl_key->sem);
+		ret = key_validate(ctrl->ctrl_key);
+		up_read(&ctrl->ctrl_key->sem);
+		if (ret) {
+			dev_warn(ctrl->device,
+				 "dhchap ctrl key %08x invalidated\n",
+				 key_serial(ctrl->ctrl_key));
+			key_put(ctrl->ctrl_key);
+			ctrl->ctrl_key = NULL;
+			return -EKEYREVOKED;
+		}
+		dev_dbg(ctrl->device,
+			"%s: using dhchap ctrl key %08x\n",
+			__func__, key_serial(ctrl->ctrl_key));
+	}
 
 	ctrl->dhchap_ctxs = kvzalloc_objs(*chap, ctrl_max_dhchaps(ctrl));
 	if (!ctrl->dhchap_ctxs) {
-		ret = -ENOMEM;
-		goto err_free_dhchap_ctrl_secret;
+		nvme_auth_clear_ctrl_key(ctrl);
+		nvme_auth_clear_host_key(ctrl);
+		return -ENOMEM;
 	}
 
 	for (i = 0; i < ctrl_max_dhchaps(ctrl); i++) {
@@ -1057,13 +1112,6 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 	}
 
 	return 0;
-err_free_dhchap_ctrl_secret:
-	key_put(ctrl->ctrl_key);
-	ctrl->ctrl_key = NULL;
-err_free_dhchap_secret:
-	key_put(ctrl->host_key);
-	ctrl->host_key = NULL;
-	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_auth_init_ctrl);
 
@@ -1082,14 +1130,8 @@ void nvme_auth_free(struct nvme_ctrl *ctrl)
 			nvme_auth_free_dhchap(&ctrl->dhchap_ctxs[i]);
 		kvfree(ctrl->dhchap_ctxs);
 	}
-	if (ctrl->host_key) {
-		key_put(ctrl->host_key);
-		ctrl->host_key = NULL;
-	}
-	if (ctrl->ctrl_key) {
-		key_put(ctrl->ctrl_key);
-		ctrl->ctrl_key = NULL;
-	}
+	nvme_auth_clear_host_key(ctrl);
+	nvme_auth_clear_ctrl_key(ctrl);
 }
 EXPORT_SYMBOL_GPL(nvme_auth_free);
 
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5fe09e327b3d..764814df115b 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -12,6 +12,7 @@
 #include <linux/seq_file.h>
 #include "nvme.h"
 #include "fabrics.h"
+#include <linux/nvme-auth.h>
 #include <linux/nvme-keyring.h>
 
 static LIST_HEAD(nvmf_transports);
@@ -717,6 +718,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 {
 	substring_t args[MAX_OPT_ARGS];
 	char *options, *o, *p;
+	char *host_secret = NULL, *ctrl_secret = NULL;
 	int token, ret = 0;
 	size_t nqnlen  = 0;
 	int ctrl_loss_tmo = NVMF_DEF_CTRL_LOSS_TMO, key_id;
@@ -738,6 +740,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->tls_key = NULL;
 	opts->keyring = NULL;
 	opts->concat = false;
+	opts->dhchap_key = NULL;
+	opts->dhchap_ctrl_key = NULL;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -1026,13 +1030,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = -ENOMEM;
 				goto out;
 			}
-			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
-				pr_err("Invalid DH-CHAP secret %s\n", p);
-				ret = -EINVAL;
-				goto out;
-			}
-			kfree(opts->dhchap_secret);
-			opts->dhchap_secret = p;
+			kfree(host_secret);
+			host_secret = p;
 			break;
 		case NVMF_OPT_DHCHAP_CTRL_SECRET:
 			p = match_strdup(args);
@@ -1040,13 +1039,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = -ENOMEM;
 				goto out;
 			}
-			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
-				pr_err("Invalid DH-CHAP secret %s\n", p);
-				ret = -EINVAL;
-				goto out;
-			}
-			kfree(opts->dhchap_ctrl_secret);
-			opts->dhchap_ctrl_secret = p;
+			kfree(ctrl_secret);
+			ctrl_secret = p;
 			break;
 		case NVMF_OPT_TLS:
 			if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
@@ -1090,6 +1084,41 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			pr_warn("failfast tmo (%d) larger than controller loss tmo (%d)\n",
 				opts->fast_io_fail_tmo, ctrl_loss_tmo);
 	}
+
+	opts->host = nvmf_host_add(hostnqn, &hostid);
+	if (IS_ERR(opts->host)) {
+		ret = PTR_ERR(opts->host);
+		opts->host = NULL;
+		goto out;
+	}
+
+	if (host_secret) {
+		pr_debug("lookup host identity '%s'\n", host_secret);
+		key = nvme_auth_extract_key(opts->keyring, host_secret,
+					    strlen(host_secret));
+		if (IS_ERR(key)) {
+			ret = PTR_ERR(key);
+			goto out;
+		}
+		pr_debug("using dhchap host key %08x\n", key_serial(key));
+		opts->dhchap_key = key;
+	}
+	if (ctrl_secret) {
+		if (!opts->dhchap_key) {
+			ret = -EINVAL;
+			goto out;
+		}
+		pr_debug("lookup ctrl identity '%s'\n", ctrl_secret);
+		key = nvme_auth_extract_key(opts->keyring, ctrl_secret,
+					    strlen(ctrl_secret));
+		if (IS_ERR(key)) {
+			ret = PTR_ERR(key);
+			goto out;
+		}
+		pr_debug("using dhchap ctrl key %08x\n", key_serial(key));
+		opts->dhchap_ctrl_key = key;
+	}
+
 	if (opts->concat) {
 		if (opts->tls) {
 			pr_err("Secure concatenation over TLS is not supported\n");
@@ -1101,21 +1130,16 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			ret = -EINVAL;
 			goto out;
 		}
-		if (!opts->dhchap_secret) {
+		if (!opts->dhchap_key) {
 			pr_err("Need to enable DH-CHAP for secure concatenation\n");
 			ret = -EINVAL;
 			goto out;
 		}
 	}
 
-	opts->host = nvmf_host_add(hostnqn, &hostid);
-	if (IS_ERR(opts->host)) {
-		ret = PTR_ERR(opts->host);
-		opts->host = NULL;
-		goto out;
-	}
-
 out:
+	kfree(ctrl_secret);
+	kfree(host_secret);
 	kfree(options);
 	return ret;
 }
@@ -1290,8 +1314,18 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
 	kfree(opts->subsysnqn);
 	kfree(opts->host_traddr);
 	kfree(opts->host_iface);
-	kfree(opts->dhchap_secret);
-	kfree(opts->dhchap_ctrl_secret);
+	if (opts->dhchap_key) {
+		pr_debug("revoke dhchap host key %08x\n",
+			 key_serial(opts->dhchap_key));
+		key_revoke(opts->dhchap_key);
+		key_put(opts->dhchap_key);
+	}
+	if (opts->dhchap_ctrl_key) {
+		pr_debug("revoke dhchap ctrl key %08x\n",
+			 key_serial(opts->dhchap_ctrl_key));
+		key_revoke(opts->dhchap_key);
+		key_put(opts->dhchap_ctrl_key);
+	}
 	kfree(opts);
 }
 EXPORT_SYMBOL_GPL(nvmf_free_options);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index caf5503d0833..786f1b4819f0 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -96,8 +96,8 @@ enum {
  * @discovery_nqn: indicates if the subsysnqn is the well-known discovery NQN.
  * @kato:	Keep-alive timeout.
  * @host:	Virtual NVMe host, contains the NQN and Host ID.
- * @dhchap_secret: DH-HMAC-CHAP secret
- * @dhchap_ctrl_secret: DH-HMAC-CHAP controller secret for bi-directional
+ * @dhchap_key: DH-HMAC-CHAP pre-shared key
+ * @dhchap_ctrl_key: DH-HMAC-CHAP controller pre-shared key for bi-directional
  *              authentication
  * @keyring:    Keyring to use for key lookups
  * @tls_key:    TLS key for encrypted connections (TCP)
@@ -127,8 +127,8 @@ struct nvmf_ctrl_options {
 	bool			duplicate_connect;
 	unsigned int		kato;
 	struct nvmf_host	*host;
-	char			*dhchap_secret;
-	char			*dhchap_ctrl_secret;
+	struct key		*dhchap_key;
+	struct key		*dhchap_ctrl_key;
 	struct key		*keyring;
 	struct key		*tls_key;
 	bool			tls;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index f0b8156725e9..7c443b0da8ab 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -6,6 +6,8 @@
  */
 
 #include <linux/nvme-auth.h>
+#include <linux/nvme-keyring.h>
+#include <linux/key-type.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -606,11 +608,23 @@ static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
+	struct key *key = ctrl->host_key;
+	ssize_t count;
 
-	if (!opts->dhchap_secret)
+	if (!key)
 		return sysfs_emit(buf, "none\n");
-	return sysfs_emit(buf, "%s\n", opts->dhchap_secret);
+	down_read(&key->sem);
+	if (key_validate(key))
+		count = sysfs_emit(buf, "<invalidated>\n");
+	else {
+		count = key->type->read(key, buf, PAGE_SIZE);
+		if (count > 0) {
+			buf[count] = '\n';
+			count++;
+		}
+	}
+	up_read(&key->sem);
+	return count;
 }
 
 static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
@@ -618,36 +632,46 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 	struct nvmf_ctrl_options *opts = ctrl->opts;
+	struct key *key, *old_key;
 	char *dhchap_secret;
+	size_t len;
+	int ret;
 
-	if (!ctrl->opts->dhchap_secret)
-		return -EINVAL;
-	if (count < 7)
+	if (!ctrl->host_key || !count)
 		return -EINVAL;
 
-	dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
+	len = strcspn(buf, "\n");
+	dhchap_secret = kzalloc(len + 1, GFP_KERNEL);
 	if (!dhchap_secret)
 		return -ENOMEM;
-	memcpy(dhchap_secret, buf, count);
+	memcpy(dhchap_secret, buf, len);
 	nvme_auth_stop(ctrl);
-	if (strcmp(dhchap_secret, opts->dhchap_secret)) {
-		struct key *key, *host_key;
-
-		key = nvme_auth_extract_key(opts->keyring, dhchap_secret,
-					    count);
-		if (IS_ERR(key)) {
-			kfree(dhchap_secret);
-			return PTR_ERR(key);
-		}
-		kfree(opts->dhchap_secret);
-		opts->dhchap_secret = dhchap_secret;
-		host_key = ctrl->host_key;
-		mutex_lock(&ctrl->dhchap_auth_mutex);
-		ctrl->host_key = key;
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		key_put(host_key);
-	} else
+	key = nvme_auth_extract_key(opts->keyring, dhchap_secret, count);
+	if (IS_ERR(key)) {
 		kfree(dhchap_secret);
+		return PTR_ERR(key);
+	}
+	down_read(&key->sem);
+	ret = key_validate(key);
+	up_read(&key->sem);
+	if (ret) {
+		dev_warn(ctrl->dev, "key %08x invalidated\n", key_serial(key));
+		dev_dbg(ctrl->dev, "revoke host key %08x\n", key_serial(key));
+		key_revoke(key);
+		key_put(key);
+		kfree(dhchap_secret);
+		return ret;
+	}
+	mutex_lock(&ctrl->dhchap_auth_mutex);
+	old_key = ctrl->host_key;
+	dev_dbg(ctrl->dev, "revoke host key %08x\n",
+		key_serial(old_key));
+	key_revoke(old_key);
+
+	ctrl->host_key = key;
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
+	key_put(old_key);
+	kfree(dhchap_secret);
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
@@ -662,11 +686,23 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
-	struct nvmf_ctrl_options *opts = ctrl->opts;
+	struct key *key = ctrl->ctrl_key;
+	size_t count;
 
-	if (!opts->dhchap_ctrl_secret)
+	if (!key)
 		return sysfs_emit(buf, "none\n");
-	return sysfs_emit(buf, "%s\n", opts->dhchap_ctrl_secret);
+	down_read(&key->sem);
+	if (key_validate(key))
+		count = sysfs_emit(buf, "<invalidated>");
+	else {
+		count = key->type->read(key, buf, PAGE_SIZE);
+		if (count > 0) {
+			buf[count] = '\n';
+			count++;
+		}
+	}
+	up_read(&key->sem);
+	return count;
 }
 
 static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
@@ -674,38 +710,46 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 	struct nvmf_ctrl_options *opts = ctrl->opts;
+	struct key *key, *old_key;
 	char *dhchap_secret;
+	size_t len;
+	int ret;
 
-	if (!ctrl->opts->dhchap_ctrl_secret)
-		return -EINVAL;
-	if (count < 7)
-		return -EINVAL;
-	if (memcmp(buf, "DHHC-1:", 7))
+	if (!ctrl->ctrl_key || !count)
 		return -EINVAL;
 
-	dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
+	len = strcspn(buf, "\n");
+	dhchap_secret = kzalloc(len + 1, GFP_KERNEL);
 	if (!dhchap_secret)
 		return -ENOMEM;
-	memcpy(dhchap_secret, buf, count);
+	memcpy(dhchap_secret, buf, len);
 	nvme_auth_stop(ctrl);
-	if (strcmp(dhchap_secret, opts->dhchap_ctrl_secret)) {
-		struct key *key, *ctrl_key;
-
-		key = nvme_auth_extract_key(opts->keyring, dhchap_secret,
-					    count);
-		if (IS_ERR(key)) {
-			kfree(dhchap_secret);
-			return PTR_ERR(key);
-		}
-		kfree(opts->dhchap_ctrl_secret);
-		opts->dhchap_ctrl_secret = dhchap_secret;
-		ctrl_key = ctrl->ctrl_key;
-		mutex_lock(&ctrl->dhchap_auth_mutex);
-		ctrl->ctrl_key = key;
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		key_put(ctrl_key);
-	} else
+	key = nvme_auth_extract_key(opts->keyring, dhchap_secret, count);
+	if (IS_ERR(key)) {
+		kfree(dhchap_secret);
+		return PTR_ERR(key);
+	}
+	down_read(&key->sem);
+	ret = key_validate(key);
+	up_read(&key->sem);
+	if (ret) {
+		dev_warn(ctrl->dev, "key %08x invalidated\n", key_serial(key));
+		dev_dbg(ctrl->dev, "revoke ctrl key %08x\n", key_serial(key));
+		key_revoke(key);
+		key_put(key);
 		kfree(dhchap_secret);
+		return ret;
+	}
+	mutex_lock(&ctrl->dhchap_auth_mutex);
+	old_key = ctrl->ctrl_key;
+	dev_dbg(ctrl->dev, "revoke ctrl key %08x\n",
+		key_serial(old_key));
+	key_revoke(old_key);
+
+	ctrl->ctrl_key = key;
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
+	key_put(old_key);
+	kfree(dhchap_secret);
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
@@ -715,6 +759,41 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 
 static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
 	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
+
+static ssize_t dhchap_key_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct key *key = ctrl->host_key;
+	size_t count;
+
+	if (!key)
+		return 0;
+	down_read(&key->sem);
+	if (key_validate(key))
+		count = sysfs_emit(buf, "<invalidated>\n");
+	else {
+		count = key->type->read(key, buf, PAGE_SIZE);
+		if (count > 0) {
+			buf[count] = '\n';
+			count++;
+		}
+	}
+	up_read(&key->sem);
+	return count;
+}
+static DEVICE_ATTR_RO(dhchap_key);
+
+static ssize_t dhchap_ctrl_key_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	if (!ctrl->ctrl_key)
+		return 0;
+	return sysfs_emit(buf, "%08x\n", key_serial(ctrl->ctrl_key));
+}
+static DEVICE_ATTR_RO(dhchap_ctrl_key);
 #endif
 
 static struct attribute *nvme_dev_attrs[] = {
@@ -743,6 +822,8 @@ static struct attribute *nvme_dev_attrs[] = {
 #ifdef CONFIG_NVME_HOST_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
+	&dev_attr_dhchap_key.attr,
+	&dev_attr_dhchap_ctrl_key.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
 	NULL
-- 
2.43.0


