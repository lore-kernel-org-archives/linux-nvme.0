Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D153D606A336
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 14:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kxv1sJdz;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TyjOilO4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=JG+kuEjcv6u1ZXCYQ+JGg8fsKvj6GKKAeXCTG9/natk=; b=kxv1sJdz89Bo+L
	SiYsdX87FeI6cjOT0/gPHxCau+EA33t4j0NZDFTOc1eu3ZXbip3gLs9OUGxSP5nw7JR+EPcRRh/N3
	JHL177wqP2EYbXXbWQHegee/VtduWCxA+KEZB2imVD4DNSJh8PCBGGNsofqadJXce91hYpDeRLN7a
	1FQXHtEaq5JaxcuRj5y36fmfug31ccIFoAqaLqUWBbPZmK/dfd6CqXzbBAzdGf2WEMS66m+mOqs3I
	jygrz6yifUBDLt5CPvSkxUpdi08nYGoM6hOi0L8QzRCVIDG4Mt20p2vDPPjqr7j2ZqSy+wmi4ma5S
	0WdlrBgG40CDZ0Yn8Z7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaER-0000000DV5p-0EPe;
	Thu, 26 Nov 2026 14:13:51 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaEE-0000000DUvZ-0X3W
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 14:13:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 937D460E7D;
	Thu, 26 Nov 2026 14:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBBF81F0156C;
	Thu, 26 Nov 2026 14:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795702416;
	bh=JG+kuEjcv6u1ZXCYQ+JGg8fsKvj6GKKAeXCTG9/natk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TyjOilO4FgnptwNj0F54HiDuvqCwbQkaPv5veE9FNYENEXipmL3XsMV4MT8xySHa/
	 Xkd+3AIlTCy/gbO/YjYmkzcfuVeDA3yrY9fpVi7VwkCKrj4tNiyolJuLkjkr2xkgRc
	 8UPchu1LDl5mm5BGsu0yy/SPqHcL6eHkR6vlttm2nswRTgCpC1oj3UMX2D1/FyHjmy
	 cZepVTDtX+un66AI37RswkPW4IgLgJSXwqAqOrDw3XqnR76yeOtSXNlFEVaIafRdwb
	 zgQT2CYuXdMlDVmA7OHjp0jlbv4b9Uzolu4YrGW3BZiCQXaHa+Kmtkap1stasjGgmz
	 Tww2Er4QQhy6Q==
From: Hannes Reinecke <hare@kernel.org>
Date: Thu, 26 Nov 2026 15:12:30 +0100
Subject: [PATCH v7 12/14] nvme-fabrics: allow to pass in keyring by name
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-dhchap-keyring-v4-v7-12-ee438ffea527@kernel.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702352; l=5266;
 i=hare@kernel.org; s=20260619; h=from:subject:message-id;
 bh=vTCtmH+06/Qwg96M3XMAMgHj7GSyiHVGOncVZ7jkUe8=;
 b=vjZ89PT7lbAUFabufIrSLb3hMj/PR96Q6wCoTKFMazVblH1qaMO+ttreWEwHdWTdMZRM9KaW7
 FeRp1Gd684eCKo8JlTYd5w6bW+21Qkt6yuERuAPA/SHrDm+OF/4wJCr
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

The current interface of passing in keyrings by serial number is very
impractical for configuration scripts, as the serial number is not
persistent across reboots, and so any configuration files will need
to be adjusted.
This patchs allows to specify the keyring by name in addition to
the serial number to simplify configuration file handling.
And the keyring fabrics option is made available to all transports
as it is no longer TCP-specific.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/fabrics.c | 31 ++++++++++++++++++++++---------
 drivers/nvme/host/sysfs.c   | 33 ++++++++++++++++++++++++++++++++-
 drivers/nvme/host/tcp.c     |  2 +-
 3 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index bba6a4848f2271beee5a4b051419fcb1e703211f..12a30ed16f9ef32c74a51a0ae6ff8ce0ea628301 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -663,8 +663,8 @@ static struct key *nvmf_parse_key(int key_id)
 {
 	struct key *key;
 
-	if (!IS_ENABLED(CONFIG_NVME_TCP_TLS)) {
-		pr_err("TLS is not supported\n");
+	if (!IS_ENABLED(CONFIG_NVME_KEYRING)) {
+		pr_err("nvme keyring is not supported\n");
 		return ERR_PTR(-EINVAL);
 	}
 
@@ -697,8 +697,10 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
 	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
 	{ NVMF_OPT_TOS,			"tos=%d"		},
+#if IS_ENABLED(CONFIG_NVME_KEYRING)
+	{ NVMF_OPT_KEYRING,		"keyring=%s"		},
+#endif
 #ifdef CONFIG_NVME_TCP_TLS
-	{ NVMF_OPT_KEYRING,		"keyring=%d"		},
 	{ NVMF_OPT_TLS_KEY,		"tls_key=%d"		},
 #endif
 	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
@@ -993,14 +995,24 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			opts->tos = token;
 			break;
 		case NVMF_OPT_KEYRING:
-			if (match_int(args, &key_id) || key_id <= 0) {
-				ret = -EINVAL;
+#if IS_ENABLED(CONFIG_NVME_KEYRING)
+			p = match_strdup(args);
+			if (!p) {
+				ret = -ENOMEM;
 				goto out;
 			}
-			key = nvmf_parse_key(key_id);
+			key = request_key(&key_type_keyring, p, NULL);
+			kfree(p);
 			if (IS_ERR(key)) {
-				ret = PTR_ERR(key);
-				goto out;
+				if (match_int(args, &key_id) || key_id <= 0) {
+					ret = -EINVAL;
+					goto out;
+				}
+				key = nvmf_parse_key(key_id);
+				if (IS_ERR(key)) {
+					ret = PTR_ERR(key);
+					goto out;
+				}
 			}
 			ret = nvme_keyring_link(opts->keyring);
 			if (ret) {
@@ -1008,6 +1020,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 				goto out;
 			}
 			opts->keyring = key;
+#endif
 			break;
 		case NVMF_OPT_TLS_KEY:
 			if (match_int(args, &key_id) || key_id <= 0) {
@@ -1376,7 +1389,7 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
 				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_DISCOVERY |\
 				 NVMF_OPT_FAIL_FAST_TMO | NVMF_OPT_DHCHAP_SECRET |\
-				 NVMF_OPT_DHCHAP_CTRL_SECRET)
+				 NVMF_OPT_DHCHAP_CTRL_SECRET | NVMF_OPT_KEYRING)
 
 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf)
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 4ebc03a8ddcaede1344988dfe816bbaf3746bb55..0ffea12fcfb6b5e79100fca4f125a655042695ca 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -1212,7 +1212,38 @@ static ssize_t tls_keyring_show(struct device *dev,
 		return sysfs_emit(buf, "%s\n", nvme_keyring_name());
 	return sysfs_emit(buf, "%s\n", keyring->description);
 }
-static DEVICE_ATTR_RO(tls_keyring);
+
+static ssize_t tls_keyring_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct key *keyring = ctrl->opts->keyring;
+	int ret;
+
+	keyring = request_key(&key_type_keyring, buf, NULL);
+	if (IS_ERR(keyring)) {
+		unsigned long keyring_id;
+
+		ret = kstrtoul(buf, 0, &keyring_id);
+		if (ret < 0)
+			return -EINVAL;
+		keyring = key_lookup(keyring_id);
+		if (IS_ERR(keyring))
+			return -EINVAL;
+	}
+	if (ctrl->opts->keyring) {
+		ret = nvme_keyring_unlink(ctrl->opts->keyring);
+		if (ret < 0) {
+			pr_warn("failed to unlink '%08X' from default keyring\n",
+				key_serial(ctrl->opts->keyring));
+			key_put(keyring);
+			return ret;
+		}
+	}
+	ctrl->opts->keyring = keyring;
+	return count;
+}
+static DEVICE_ATTR_ADMIN_RW(tls_keyring);
 
 static ssize_t tls_mode_show(struct device *dev,
 			     struct device_attribute *attr, char *buf)
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 585aba1d544518d6e712e23c7987741b130aee4d..c3149a9151f557534a7d9cb3cbe0b3c61a037833 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -3432,7 +3432,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
 			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS |
-			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY | NVMF_OPT_CONCAT,
+			  NVMF_OPT_TLS_KEY | NVMF_OPT_CONCAT,
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
 

-- 
2.51.0


