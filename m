Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B76CDB47E
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Oct 2023 12:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rhRl39D48uVvGt2pL/nTFfO+AVGVJ8p4cZXTGmCvTIk=; b=vzdA48XV5PRT+/nAG4CKbssAHx
	h36xDbGx9vjTaz9SD2ZBeanzuilx8qFHkxZtEY8Q+m88hvZ2HdCRoODscvObxzOmWJ4p9VyAEC/DU
	vhp2IXL3e2N1qLcyFl1WYZfgl1YB2q+Eb62zdwTlOwt/glUIQahCNhBc7basz1bPX5apgjNBdAu1n
	71KP5T3/qx7IZm2rs7FksqNIbp8upMAOub7zdEEDr4aJnw43kn46/JSyut/s2ndROxskYtQn8SU8V
	NC1x8tnP37BKO4gfBDyNzYOteLLmnpyi+lX2fJlQVxXUBRJ8mhrXLmLgbUDlOnzBb+KA7Qc3M5mhU
	OnMmdqFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qquiN-000xVn-32;
	Thu, 12 Oct 2023 12:22:55 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qquiJ-000xVN-35
	for linux-nvme@lists.infradead.org;
	Thu, 12 Oct 2023 12:22:53 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id F1F341F889;
	Thu, 12 Oct 2023 12:22:49 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id ABA702C9A8;
	Thu, 12 Oct 2023 12:22:49 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id C923951EBBB6; Thu, 12 Oct 2023 14:22:49 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] nvme: rework NVME_AUTH Kconfig selection
Date: Thu, 12 Oct 2023 14:22:48 +0200
Message-Id: <20231012122248.44813-1-hare@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out2.suse.de: 149.44.160.134 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [2.49 / 50.00];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 NEURAL_HAM_LONG(-3.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DMARC_NA(0.20)[suse.de];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(0.60)[~all:c];
	 RCPT_COUNT_FIVE(0.00)[6];
	 TO_MATCH_ENVRCPT_SOME(0.00)[];
	 VIOLATED_DIRECT_SPF(3.50)[];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-1.00)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
	 RCVD_NO_TLS_LAST(0.10)[];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(0.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_COUNT_TWO(0.00)[2];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: F1F341F889
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231012_052252_298986_B716F6E7 
X-CRM114-Status: GOOD (  13.25  )
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

Having a single Kconfig symbol NVME_AUTH conflates the selection
of the authentication functions from nvme/common and nvme/host,
causing kbuild robot to complain when building the nvme target
only. So introduce a Kconfig symbol NVME_HOST_AUTH for the nvme
host bits and use NVME_AUTH for the common functions only.
And move the CRYPTO selection into nvme/common to make it
easier to read.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310120733.TlPOVeJm-lkp@intel.com/
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/common/Kconfig | 9 +++++++++
 drivers/nvme/host/Kconfig   | 9 ++-------
 drivers/nvme/host/Makefile  | 2 +-
 drivers/nvme/host/core.c    | 2 +-
 drivers/nvme/host/nvme.h    | 4 ++--
 drivers/nvme/host/sysfs.c   | 6 +++---
 drivers/nvme/target/Kconfig | 7 +------
 7 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
index 641b27adb047..06c8df00d1e2 100644
--- a/drivers/nvme/common/Kconfig
+++ b/drivers/nvme/common/Kconfig
@@ -6,3 +6,12 @@ config NVME_COMMON
 config NVME_KEYRING
        bool
        select KEYS
+
+config NVME_AUTH
+	bool
+	select CRYPTO
+	select CRYPTO_HMAC
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
+	select CRYPTO_DH
+	select CRYPTO_DH_RFC7919_GROUPS
diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index a517030d7d50..48f7d72de5e9 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -107,16 +107,11 @@ config NVME_TCP_TLS
 
 	  If unsure, say N.
 
-config NVME_AUTH
+config NVME_HOST_AUTH
 	bool "NVM Express over Fabrics In-Band Authentication"
 	depends on NVME_CORE
 	select NVME_COMMON
-	select CRYPTO
-	select CRYPTO_HMAC
-	select CRYPTO_SHA256
-	select CRYPTO_SHA512
-	select CRYPTO_DH
-	select CRYPTO_DH_RFC7919_GROUPS
+	select NVME_AUTH
 	help
 	  This provides support for NVMe over Fabrics In-Band Authentication.
 
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index c7c3cf202d12..6414ec968f99 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -17,7 +17,7 @@ nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
 nvme-core-$(CONFIG_BLK_DEV_ZONED)	+= zns.o
 nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)	+= fault_inject.o
 nvme-core-$(CONFIG_NVME_HWMON)		+= hwmon.o
-nvme-core-$(CONFIG_NVME_AUTH)		+= auth.o
+nvme-core-$(CONFIG_NVME_HOST_AUTH)	+= auth.o
 
 nvme-y					+= pci.o
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 55e54ffb1003..62612f87aafa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -421,7 +421,7 @@ void nvme_complete_rq(struct request *req)
 		nvme_failover_req(req);
 		return;
 	case AUTHENTICATE:
-#ifdef CONFIG_NVME_AUTH
+#ifdef CONFIG_NVME_HOST_AUTH
 		queue_work(nvme_wq, &ctrl->dhchap_auth_work);
 		nvme_retry_req(req);
 #else
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 6fe7966f720b..39a90b7cb125 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -349,7 +349,7 @@ struct nvme_ctrl {
 	struct work_struct ana_work;
 #endif
 
-#ifdef CONFIG_NVME_AUTH
+#ifdef CONFIG_NVME_HOST_AUTH
 	struct work_struct dhchap_auth_work;
 	struct mutex dhchap_auth_mutex;
 	struct nvme_dhchap_queue_context *dhchap_ctxs;
@@ -1049,7 +1049,7 @@ static inline bool nvme_ctrl_sgl_supported(struct nvme_ctrl *ctrl)
 	return ctrl->sgls & ((1 << 0) | (1 << 1));
 }
 
-#ifdef CONFIG_NVME_AUTH
+#ifdef CONFIG_NVME_HOST_AUTH
 int __init nvme_init_auth(void);
 void __exit nvme_exit_auth(void);
 int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index d0966159981c..c6b7fbd4d34d 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -409,7 +409,7 @@ static ssize_t dctype_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(dctype);
 
-#ifdef CONFIG_NVME_AUTH
+#ifdef CONFIG_NVME_HOST_AUTH
 static ssize_t nvme_ctrl_dhchap_secret_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -563,7 +563,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_kato.attr,
 	&dev_attr_cntrltype.attr,
 	&dev_attr_dctype.attr,
-#ifdef CONFIG_NVME_AUTH
+#ifdef CONFIG_NVME_HOST_AUTH
 	&dev_attr_dhchap_secret.attr,
 	&dev_attr_dhchap_ctrl_secret.attr,
 #endif
@@ -593,7 +593,7 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 		return 0;
 	if (a == &dev_attr_fast_io_fail_tmo.attr && !ctrl->opts)
 		return 0;
-#ifdef CONFIG_NVME_AUTH
+#ifdef CONFIG_NVME_HOST_AUTH
 	if (a == &dev_attr_dhchap_secret.attr && !ctrl->opts)
 		return 0;
 	if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index c56cb1005327..fa479c9f5c3d 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -103,12 +103,7 @@ config NVME_TARGET_AUTH
 	bool "NVMe over Fabrics In-band Authentication support"
 	depends on NVME_TARGET
 	select NVME_COMMON
-	select CRYPTO
-	select CRYPTO_HMAC
-	select CRYPTO_SHA256
-	select CRYPTO_SHA512
-	select CRYPTO_DH
-	select CRYPTO_DH_RFC7919_GROUPS
+	select NVME_AUTH
 	help
 	  This enables support for NVMe over Fabrics In-band Authentication
 
-- 
2.35.3


