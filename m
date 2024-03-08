Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B9AC54E4A
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Mar 2024 12:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kTobbwbzd5l0XzRr1tNO8J9zMISk5cBVcimvAFhl+No=; b=ZW2I+Cf8Ua57RyqdpDTf6p2h8r
	HZ7AVEq2hrVafC0deGYw0FVE5px7014ZACLtdPzLWvjxCsTv5yqcJulnnvz/S3ZT0rjZv+FB7CRYK
	XLVSm3Bc1crEAogzn3gEVoE9adAzn1BCbLVMsZLb6z8I0GATU4aEXUad9lT6XBZJLdkS9gtOfMz8D
	z3Y7/mO/hwv2h4QeIOnaDVnB4nEPE57iGR2cduORm6qJn3+iOUIo8fFRrPI5ayxuq/E9DyV+vEscQ
	PgKX8YlChLaM/erAg/7SIPoPQhyYfnhAnz21biER0PAzn/6UPwOalO/Iad+jUaEiaF6KzUdL3uxKV
	m4PuavXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riZ3M-000000094eq-3WnC;
	Fri, 08 Mar 2024 12:10:20 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riZ3J-000000094dP-0cmI
	for linux-nvme@lists.infradead.org;
	Fri, 08 Mar 2024 12:10:18 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A7E0061714;
	Fri,  8 Mar 2024 12:10:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBC72C433C7;
	Fri,  8 Mar 2024 12:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709899816;
	bh=2O61q7ghaWyZOOYNWSTL/h4+x3MNwmEzDbKyfghwVyY=;
	h=From:To:Cc:Subject:Date:From;
	b=TUAy9Pxds//IJFkqgS4Qs0LL/DhgATtTRZvdBI7RK50G7ZnONbU+sijkIzP7NwA1U
	 tReia/gsfw8yzeBgUg/1f/+rFHdt+I+Ah9pVKdY3f3PrcAYJI9/AsOPXILU9avmLFV
	 oHyrAysndF3AUASW37EyHtbZyWxUxPb5gI3OTz5k2klYkS1cHuTSzDnrs4U1G4JF9g
	 ADPCLIf7HYzsCJ2i5lBgMmNIl+wNeQcpFOQLdQ+G9n9NQngYjQHgXGWo0Z0S23SsBA
	 7ro79+ZRA9fq22xnYq48k1rC2YELTN4UhtaRUlV6w6Hh4pHML3l/fOqnQm+7OkfXgf
	 JR/6D6KshBbGA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme: add sysfs attribute 'tls_keyring'
Date: Fri,  8 Mar 2024 13:10:06 +0100
Message-Id: <20240308121006.69442-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240308_041017_288334_FD1D5997 
X-CRM114-Status: GOOD (  15.33  )
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

Add a sysfs attribute 'tls_keyring' to hold the contents for the
'keyring' fabrics option. This option is only meaningful if the
'tls' option has been specified; if the 'tls_key' option is specified
the key is looked up directly and the keyring setting is ignored.
So blank out the keyring value when 'tls_key' is specified.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/sysfs.c | 55 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 6c7f1d5c056f..7b65ff7426c9 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -5,11 +5,12 @@
  * Copyright (c) 2011-2014, Intel Corporation.
  */
 
-#include <linux/nvme-auth.h>
-
 #include "nvme.h"
 #include "fabrics.h"
 
+#include <linux/nvme-auth.h>
+#include <linux/nvme-keyring.h>
+
 static ssize_t nvme_sysfs_reset(struct device *dev,
 				struct device_attribute *attr, const char *buf,
 				size_t count)
@@ -677,6 +678,52 @@ static ssize_t tls_key_show(struct device *dev,
 	return sysfs_emit(buf, "%08x", key_serial(ctrl->tls_key));
 }
 static DEVICE_ATTR_RO(tls_key);
+
+static ssize_t tls_keyring_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct key *keyring;
+
+	if (!ctrl->tls_key)
+		return 0;
+	/* Do not display the keyring for user-selected keys */
+	if (ctrl->opts->tls_key)
+		return 0;
+	keyring = ctrl->opts->keyring;
+	if (!keyring) {
+		keyring = key_lookup(nvme_keyring_id());
+		if (!keyring)
+			return -EINVAL;
+	}
+	return sysfs_emit(buf, "%s", keyring->description);
+}
+
+static ssize_t tls_keyring_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	int err;
+	u32 key_id;
+	struct key *keyring;
+
+	if (!strlen(buf))
+		return -EINVAL;
+	err = kstrtou32(buf, 0, &key_id);
+	if (err)
+		return err;
+	keyring = key_lookup(key_id);
+	if (IS_ERR(keyring)) {
+		pr_err("key %08x not found\n", key_id);
+		return -EINVAL;
+	}
+	if (ctrl->opts->keyring)
+		key_put(ctrl->opts->keyring);
+	ctrl->opts->keyring = keyring;
+	return 0;
+}
+static DEVICE_ATTR(tls_keyring, S_IRUGO | S_IWUSR,
+		tls_keyring_show, tls_keyring_store);
 #endif
 
 static struct attribute *nvme_dev_attrs[] = {
@@ -708,6 +755,7 @@ static struct attribute *nvme_dev_attrs[] = {
 #endif
 #ifdef CONFIG_NVME_TCP_TLS
 	&dev_attr_tls_key.attr,
+	&dev_attr_tls_keyring.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
 	NULL
@@ -743,6 +791,9 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 	if (a == &dev_attr_tls_key.attr &&
 	    (!ctrl->opts || strcmp(ctrl->opts->transport, "tcp")))
 		return 0;
+	if (a == &dev_attr_tls_keyring.attr &&
+	    (!ctrl->opts || strcmp(ctrl->opts->transport, "tcp")))
+		return 0;
 #endif
 
 	return a->mode;
-- 
2.35.3


