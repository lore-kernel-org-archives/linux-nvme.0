Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B3B606A333
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Wdz9JJwZ;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fVAD2oEN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=SJLwZwHDFpgffaVzsUHv8h13cJCOkEGkdbk799276k0=; b=Wdz9JJwZqDQ489
	Oiucr+ZobRlki8x/w9Fai2Lbv8wL5HWEdyC/d7FKGkxYmOowPUV8SKZUykX6zSIbILAoJ6G1nFG1P
	Iap0IR6lglWOpgZwacBPBMkB429kWBW5LUV3NVEBYi/jdJaplbQsTJLsnf/k0H1VH2nFwJ9Hb9IDd
	5495qRVMTsNMKODSnwh5CHzisFKTLRFVxw9S7P+3CNGD9kOH9CXsVQd4yehCnXnP/XCRrwZAhV8Kv
	/emd6OM2gz074dGTilyTJ6DZp97W0uNgidKKzYftLYCaBf/HJ36D917uwPU6ykevu/OHgtDV7vrv8
	4Vrwevo3ISSmjQHB1Hxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMZe-0000000EkkV-0P6a;
	Fri, 20 Nov 2026 11:14:34 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMZZ-0000000Ekgv-0rAL
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 11:14:30 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EF4E84398B;
	Fri, 20 Nov 2026 11:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDE11F00A19;
	Fri, 20 Nov 2026 11:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795173268;
	bh=SJLwZwHDFpgffaVzsUHv8h13cJCOkEGkdbk799276k0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fVAD2oEN5tERTg5MRfRgX1QyYDoiKPbgd3GROwrvXeI0o7FQPSgVPmiUBrDWOaSqj
	 jHN6ADrQOFT2HY7Opi/YIUJbjjyLrytYBO0DwLlw0I2LKf88Kp/m6UM45iA0A10/jC
	 /zwk/8957hBKyQjTVZSyhIfJyUYNcsWvS2UXjvflqOR5d5lvUeY6a/SOf7y+oeN+Yk
	 ZWXgX/locwnsLikC7tcy4hyF7CvAOSWo3l5G8utR5msPT8vKCcK5LfAx/X7rrV/G/h
	 HU8dvFiZ8b7vZVZRb+/aX0sHqp8NfgwPBBG+K2nWvNhi0f4kSWpzX1gTYogpIXd5P5
	 SdKTYrfybeYig==
From: Hannes Reinecke <hare@kernel.org>
Date: Fri, 20 Nov 2026 12:14:03 +0100
Subject: [PATCH v4 4/9] nvme: parse dhchap keys during option parsing
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261120-dhchap-keyring-v4-v4-4-5f8c7d9926ee@kernel.org>
References: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
In-Reply-To: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Hannes Reinecke <hare@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795173255; l=18846;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=JVXmAfpI06wexawX3v7sq+nMdDYNVwcLcIonCZNKJYc=;
 b=cQBmoNggZfjM47zlIKiqYhOUmkJYYow3/lf7MRa8qQhTW5O5FGBE3MNVDUrk0U2Odkds5mNrj
 vwXQz4kI/LYBp3rbjPg79Qq0+QN36UJLUvEIDe4NY699L1gG8NLvvLi
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

We really should parse the dhchap keys during option parsing to avoid
having to pass around the plain dhchap secret. During options parsing
we will create a 'dhchap' key with a random UUID as description, and
store the key serial in the 'opts' structure.
This simplifies key handling as on every access the key needs to be
looked up and checked for validity before accessing the key data.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/auth.c    | 118 +++++++++++++++++++---------
 drivers/nvme/host/fabrics.c |  84 +++++++++++++-------
 drivers/nvme/host/fabrics.h |   8 +-
 drivers/nvme/host/sysfs.c   | 186 +++++++++++++++++++++++++++++++-------------
 4 files changed, 276 insertions(+), 120 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 0ddf3834f4ea2bfedaf08b901db282b79df32879..c189096f825eab4e3053021d7437423ecb049c79 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -940,11 +940,6 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
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
@@ -1029,6 +1024,29 @@ static void nvme_ctrl_auth_work(struct work_struct *work)
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
@@ -1038,31 +1056,68 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
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
@@ -1074,13 +1129,6 @@ int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
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
 
@@ -1099,14 +1147,8 @@ void nvme_auth_free(struct nvme_ctrl *ctrl)
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
index 5ed91557f07065a284e664950a9c71d771614ec2..7ed8618257ca9fadc65202261a86b7ead209df7c 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -12,6 +12,7 @@
 #include <linux/seq_file.h>
 #include "nvme.h"
 #include "fabrics.h"
+#include <linux/nvme-auth.h>
 #include <linux/nvme-keyring.h>
 
 static DECLARE_RWSEM(nvmf_transports_rwsem);
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
@@ -1020,14 +1024,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = -ENOMEM;
 				goto out;
 			}
-			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
-				pr_err("Invalid DH-CHAP secret %s\n", p);
-				kfree_sensitive(p);
-				ret = -EINVAL;
-				goto out;
-			}
-			kfree_sensitive(opts->dhchap_secret);
-			opts->dhchap_secret = p;
+			kfree_sensitive(host_secret);
+			host_secret = p;
 			break;
 		case NVMF_OPT_DHCHAP_CTRL_SECRET:
 			p = match_strdup(args);
@@ -1035,14 +1033,8 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				ret = -ENOMEM;
 				goto out;
 			}
-			if (strlen(p) < 11 || strncmp(p, "DHHC-1:", 7)) {
-				pr_err("Invalid DH-CHAP secret %s\n", p);
-				kfree_sensitive(p);
-				ret = -EINVAL;
-				goto out;
-			}
-			kfree_sensitive(opts->dhchap_ctrl_secret);
-			opts->dhchap_ctrl_secret = p;
+			kfree_sensitive(ctrl_secret);
+			ctrl_secret = p;
 			break;
 		case NVMF_OPT_TLS:
 			if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
@@ -1086,6 +1078,41 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
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
@@ -1097,21 +1124,16 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
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
+	kfree_sensitive(ctrl_secret);
+	kfree_sensitive(host_secret);
 	kfree(options);
 	return ret;
 }
@@ -1304,8 +1326,18 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
 	kfree(opts->subsysnqn);
 	kfree(opts->host_traddr);
 	kfree(opts->host_iface);
-	kfree_sensitive(opts->dhchap_secret);
-	kfree_sensitive(opts->dhchap_ctrl_secret);
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
index caf5503d0833296aa03c028c0199cf92cc409edc..786f1b4819f076ac1f133070523be1780ec4d8b7 100644
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
index a5c1511e49ac275e75a70ff89958ed8f0cb2c633..1311f5e29b004436e39a723242748a150e36dc68 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -6,6 +6,8 @@
  */
 
 #include <linux/nvme-auth.h>
+#include <linux/nvme-keyring.h>
+#include <linux/key-type.h>
 #include <linux/blkdev.h>
 
 #include "nvme.h"
@@ -818,11 +820,23 @@ static ssize_t dhchap_secret_show(struct device *dev,
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
 
 static ssize_t dhchap_secret_store(struct device *dev,
@@ -830,36 +844,47 @@ static ssize_t dhchap_secret_store(struct device *dev,
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
-			kfree_sensitive(dhchap_secret);
-			return PTR_ERR(key);
-		}
-		kfree_sensitive(opts->dhchap_secret);
-		opts->dhchap_secret = dhchap_secret;
-		host_key = ctrl->host_key;
-		mutex_lock(&ctrl->dhchap_auth_mutex);
-		ctrl->host_key = key;
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		key_put(host_key);
-	} else
+
+	key = nvme_auth_extract_key(opts->keyring, dhchap_secret, count);
+	if (IS_ERR(key)) {
 		kfree_sensitive(dhchap_secret);
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
+		kfree_sensitive(dhchap_secret);
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
+	kfree_sensitive(dhchap_secret);
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
@@ -873,11 +898,23 @@ static ssize_t dhchap_ctrl_secret_show(struct device *dev,
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
 
 static ssize_t dhchap_ctrl_secret_store(struct device *dev,
@@ -885,38 +922,46 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
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
-			kfree_sensitive(dhchap_secret);
-			return PTR_ERR(key);
-		}
-		kfree_sensitive(opts->dhchap_ctrl_secret);
-		opts->dhchap_ctrl_secret = dhchap_secret;
-		ctrl_key = ctrl->ctrl_key;
-		mutex_lock(&ctrl->dhchap_auth_mutex);
-		ctrl->ctrl_key = key;
-		mutex_unlock(&ctrl->dhchap_auth_mutex);
-		key_put(ctrl_key);
-	} else
+	key = nvme_auth_extract_key(opts->keyring, dhchap_secret, count);
+	if (IS_ERR(key)) {
 		kfree_sensitive(dhchap_secret);
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
+		kfree_sensitive(dhchap_secret);
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
+	kfree_sensitive(dhchap_secret);
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
@@ -925,6 +970,41 @@ static ssize_t dhchap_ctrl_secret_store(struct device *dev,
 }
 
 static DEVICE_ATTR_ADMIN_RW(dhchap_ctrl_secret);
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
+static DEVICE_ATTR_ADMIN_RO(dhchap_key);
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
+static DEVICE_ATTR_ADMIN_RO(dhchap_ctrl_key);
 #endif
 
 static struct attribute *nvme_dev_attrs[] = {
@@ -956,6 +1036,8 @@ static struct attribute *nvme_dev_attrs[] = {
 #ifdef CONFIG_NVME_HOST_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
+	&dev_attr_dhchap_key.attr,
+	&dev_attr_dhchap_ctrl_key.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
 	NULL

-- 
2.51.0


