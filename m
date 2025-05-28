Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C1FC3ABB2
	for <linux-nvme@archiver.kernel.org>; Wed, 28 May 2025 14:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nY34arXoaP03X01sJXtY26QqWqrTA7InX6+ee8dOG18=; b=YAzCy0Y4c5BfB5iCs6UOLhB0En
	0muNVNvOz2PudvGce/sPMpg/ocZ7Qiq0PFcdBI5HH5wsJ05vGouStywwsPIgvk0GmNEMEveQcSWul
	Fwer9frnhtX4dSsohZLVGnHvJt4Jvc8Mak42BTSnFBRuZeTJUpki8n1A6YK4R6ZUtubbZuTrhuU1/
	6/YqrBusdpuWootfYdBVnAvr4+KaYIQqxX+xjSUzzTkxtYhCFwA09Tivs16Gh/zjTT+1JDx5hcgIp
	CHP3Oon0PrC6MZWiBteBm8jQ4zb62F1XCrL6LS4PbRQIKiitNEwyzoUAk7XWdcnWvTIhAssZ/2bLU
	bA8Qju4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKHdH-0000000DN38-0pRt;
	Wed, 28 May 2025 14:19:51 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uKHST-0000000DKQN-0nxI
	for linux-nvme@lists.infradead.org;
	Wed, 28 May 2025 14:08:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9EBFF5C5595;
	Wed, 28 May 2025 14:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F231AC4CEED;
	Wed, 28 May 2025 14:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748441320;
	bh=6HY/KwIOS0HN9KfHOsb6r9QcFpxmcg7CmGYM7iuUW+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SZgllNw1p5OCr2kAwOTzTaTgG14v8J6vDL9Q3Ai6hWZQUjvAzldUj0HIqBgatDtgU
	 Owxs7r+QbjPSMB7L6bjRpIqLN7EF3vhxMYj0Rz/qYSvfR83jZDw2diUn05ymNxmg+V
	 +GsASwo2sQg36Om8PEBf/LmOSLjvvbNoWncDTC2H6fOCijp0FD5vihepBRtPX3ty3/
	 7ywbP9TQ9S/smT/ip8nWyc9x8B/I+xSILp9248R3aLgbMOYBjmEw6h2GRIxA4b2ySL
	 yhBvzwP1BODBtEXVfBD38hVGmkxI8QhSugnDaz8yF/bG6tRNu6ddb/zLOHuTK77RMq
	 zqim1Bv+wDM1g==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 4/9] nvme: parse dhchap keys during option parsing
Date: Wed, 28 May 2025 16:05:12 +0200
Message-Id: <20250528140517.3284-5-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250528140517.3284-1-hare@kernel.org>
References: <20250528140517.3284-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250528_070841_327799_C876F1C9 
X-CRM114-Status: GOOD (  22.20  )
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
 drivers/nvme/host/auth.c    | 113 ++++++++++++++++------
 drivers/nvme/host/fabrics.c |  82 +++++++++++-----
 drivers/nvme/host/fabrics.h |   8 +-
 drivers/nvme/host/sysfs.c   | 185 ++++++++++++++++++++++++++----------
 4 files changed, 278 insertions(+), 110 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index c5be0c13e85b..0e8a5b544f63 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -532,7 +532,7 @@ static int nvme_auth_dhchap_setup_ctrl_response(struct nvme_ctrl *ctrl,
 	ret = crypto_shash_setkey(chap->shash_tfm,
 			transformed_secret, transformed_len);
 	if (ret) {
-		dev_warn(ctrl->device, "qid %d: failed to set key, error %d\n",
+		dev_warn(ctrl->device, "qid %d: failed to set ctrl key, error %d\n",
 			 chap->qid, ret);
 		goto out;
 	}
@@ -970,11 +970,6 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
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
@@ -1059,6 +1054,26 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
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
+		dev_dbg(ctrl->device, "%s: revoke%s key %08x\n",
+			__func__, is_ctrl ? " ctrl" : "",
+			key_serial(key));
+		key_revoke(key);
+		key_put(key);
+	}
+}
+
 int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dhchap_queue_context *chap;
@@ -1068,31 +1083,70 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
 	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
 	if (!ctrl->opts)
 		return 0;
-	ctrl->host_key = nvme_auth_extract_key(ctrl->opts->keyring,
-					       ctrl->opts->dhchap_secret,
-					       strlen(ctrl->opts->dhchap_secret));
-	if (IS_ERR(ctrl->host_key)) {
-		ret = PTR_ERR(ctrl->host_key);
-		ctrl->host_key = NULL;
-		return ret;
+	if (!ctrl->opts->dhchap_key) {
+		nvme_auth_clear_key(ctrl, false);
+		nvme_auth_clear_key(ctrl, true);
+		return 0;
 	}
-	ctrl->ctrl_key = nvme_auth_extract_key(ctrl->opts->keyring,
-					       ctrl->opts->dhchap_ctrl_secret,
-					       strlen(ctrl->opts->dhchap_ctrl_secret));
-	if (IS_ERR(ctrl->ctrl_key)) {
-		ret = PTR_ERR(ctrl->ctrl_key);
-		ctrl->ctrl_key = NULL;
-		goto err_free_dhchap_secret;
+
+	if (ctrl->host_key)
+		nvme_auth_clear_key(ctrl, false);
+
+	ctrl->host_key = key_get(ctrl->opts->dhchap_key);
+	if (!ctrl->host_key) {
+		dev_warn(ctrl->device,
+			 "dhchap key %08x not present\n",
+			 key_serial(ctrl->opts->dhchap_key));
+		return -ENOKEY;
+	}
+	down_read(&ctrl->host_key->sem);
+	ret = key_validate(ctrl->host_key);
+	up_read(&ctrl->host_key->sem);
+	if (ret) {
+		dev_warn(ctrl->device,
+			 "dhchap key %08x invalidated\n",
+			 key_serial(ctrl->host_key));
+		key_put(ctrl->host_key);
+		ctrl->host_key = NULL;
+		return -ENOKEY;
 	}
+	dev_dbg(ctrl->device,
+		"%s: using dhchap key %08x\n",
+		__func__, key_serial(ctrl->host_key));
 
-	if (!ctrl->opts->dhchap_secret && !ctrl->opts->dhchap_ctrl_secret)
-		return 0;
+	if (ctrl->ctrl_key)
+		nvme_auth_clear_key(ctrl, true);
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
 
 	ctrl->dhchap_ctxs = kvcalloc(ctrl_max_dhchaps(ctrl),
 				sizeof(*chap), GFP_KERNEL);
 	if (!ctrl->dhchap_ctxs) {
-		ret = -ENOMEM;
-		goto err_free_dhchap_ctrl_secret;
+		nvme_auth_clear_key(ctrl, true);
+		nvme_auth_clear_key(ctrl, false);
+		return -ENOMEM;
 	}
 
 	for (i = 0; i < ctrl_max_dhchaps(ctrl); i++) {
@@ -1104,13 +1158,6 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
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
 
@@ -1130,10 +1177,14 @@ void nvme_auth_free(struct nvme_ctrl *ctrl)
 		kfree(ctrl->dhchap_ctxs);
 	}
 	if (ctrl->host_key) {
+		dev_dbg(ctrl->device, "%s: drop host key %08x\n",
+			__func__, key_serial(ctrl->host_key));
 		key_put(ctrl->host_key);
 		ctrl->host_key = NULL;
 	}
 	if (ctrl->ctrl_key) {
+		dev_dbg(ctrl->device, "%s: drop ctrl key %08x\n",
+			__func__, key_serial(ctrl->ctrl_key));
 		key_put(ctrl->ctrl_key);
 		ctrl->ctrl_key = NULL;
 	}
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 93e9041b9657..009a6cf8a86b 100644
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
+		pr_debug("using dhchap key %08x\n", key_serial(key));
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
+		pr_debug("revoke dhchap key %08x\n",
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
index 9cf5b020adba..95a3d8ce1201 100644
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
index b3b63453df1c..8a96228ff244 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -6,6 +6,8 @@
  */
 
 #include <linux/nvme-auth.h>
+#include <linux/nvme-keyring.h>
+#include <linux/key-type.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -578,11 +580,23 @@ static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
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
@@ -590,35 +604,47 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
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
+	if (!ctrl->host_key || !strlen(buf))
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
-		key = nvme_auth_extract_key(opts->keyring, dhchap_secret, count);
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
+	key = nvme_auth_extract_key(opts->keyring,
+				    dhchap_secret, count);
+	if (IS_ERR(key)) {
 		kfree(dhchap_secret);
+		return PTR_ERR(key);
+	}
+	down_read(&key->sem);
+	ret = key_validate(key);
+	up_read(&key->sem);
+	if (ret) {
+		dev_warn(ctrl->dev, "key %08x invalidated\n", key_serial(key));
+		dev_dbg(ctrl->dev, "revoke key %08x\n", key_serial(key));
+		key_revoke(key);
+		key_put(key);
+		kfree(dhchap_secret);
+		return ret;
+	}
+	mutex_lock(&ctrl->dhchap_auth_mutex);
+	old_key = ctrl->host_key;
+	dev_dbg(ctrl->dev, "revoke key %08x\n",
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
@@ -633,11 +659,23 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_show(struct device *dev,
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
@@ -645,38 +683,46 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
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
+	if (!ctrl->ctrl_key || !strlen(buf))
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
-		key = nvme_auth_extract_key(opts->keyring,
-					    dhchap_secret, count);
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
+	key = nvme_auth_extract_key(opts->keyring,
+				    dhchap_secret, count);
+	if (IS_ERR(key)) {
 		kfree(dhchap_secret);
+		return PTR_ERR(key);
+	}
+	down_read(&key->sem);
+	ret = key_validate(key);
+	up_read(&key->sem);
+	if (ret) {
+		dev_warn(ctrl->dev, "key %08x invalidated\n", key_serial(key));
+		dev_dbg(ctrl->dev, "revoke key %08x\n", key_serial(key));
+		key_revoke(key);
+		key_put(key);
+		kfree(dhchap_secret);
+		return ret;
+	}
+	mutex_lock(&ctrl->dhchap_auth_mutex);
+	old_key = ctrl->ctrl_key;
+	dev_dbg(ctrl->dev, "revoke key %08x\n",
+		key_serial(old_key));
+	key_revoke(old_key);
+	ctrl->ctrl_key = key;
+	mutex_unlock(&ctrl->dhchap_auth_mutex);
+	key_put(old_key);
+	kfree(dhchap_secret);
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
@@ -686,6 +732,41 @@ static ssize_t nvme_ctrl_dhchap_ctrl_secret_store(struct device *dev,
 
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
@@ -714,6 +795,8 @@ static struct attribute *nvme_dev_attrs[] = {
 #ifdef CONFIG_NVME_HOST_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
+	&dev_attr_dhchap_key.attr,
+	&dev_attr_dhchap_ctrl_key.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
 	NULL
-- 
2.35.3


