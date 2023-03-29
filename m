Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CE0DC761A6
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 14:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xsnvGFRiVTP+x9xiHRNypweueLSZ3terDB3F+bhrWz8=; b=J9hIuPSxQ6qoBriblXyZ67qo8n
	CbHz9yFxXHiNU3NNvToxYbzZKxAXY2hrdhQNpJvw+jgrha74m8UPes7KT4ZS8NbvBHeTJI8km9B3V
	opBUCBoHufVHRa5tKoZCzCrmKQPibIfZnSSDxvoDQbxTDnl7GiNQtCBNhNoOR86sqlOCh/gQEKor/
	8yOoJH0ceA1oXBD4GJRsKaGXJFnb9UUR024L0Aza9NCNjX0y+vmTGTQnAvVvF+pVg55H/DnweXRR3
	QJ3UHwGY+myAttD97Qou80zc6Ag5MfnFYR0JlVxyeTtQusiChF+gJK2xjBPMllDNyLfIiGK6ZurG2
	r8xIO4jQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLL-000UpQ-0l;
	Wed, 29 Mar 2023 14:00:03 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLD-000Ugz-0t
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 13:59:57 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id A5A91219EB;
	Wed, 29 Mar 2023 13:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680098389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xsnvGFRiVTP+x9xiHRNypweueLSZ3terDB3F+bhrWz8=;
	b=kdyfxA4NPnhyObvEDULg+eIW2hxd3Dl9jGx5eR8oYyxnoVsBpKlS1Oj9QnKjxC6VluJsll
	bveqNcuVkzTn2on/gSKsEYbKpkYD51HrDhnfpeaLPuLtKiJ7/UuZJ7LgHOR6R/oJtMBdEe
	hs7K5A2xdKNLp7WbDAFDIh2hZfO5OQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680098389;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xsnvGFRiVTP+x9xiHRNypweueLSZ3terDB3F+bhrWz8=;
	b=PSFq71T52grCEXNmsN/8wx6Q4sEkHHeUbmcW+qLtBsh9XPl//A/ONytOZL4/bxoUDfQsk3
	S32a2lAXAdPFWSBQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 8941B2C16E;
	Wed, 29 Mar 2023 13:59:49 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 759F951BF374; Wed, 29 Mar 2023 15:59:49 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 01/18] nvme-keyring: register '.nvme' keyring and add CONFIG_NVME_TLS
Date: Wed, 29 Mar 2023 15:59:21 +0200
Message-Id: <20230329135938.46905-2-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329135938.46905-1-hare@suse.de>
References: <20230329135938.46905-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_065955_463322_B8E9FC13 
X-CRM114-Status: GOOD (  20.06  )
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

Register a '.nvme' keyring to hold keys for TLS and DH-HMAC-CHAP and
add a new config option NVME_TLS to enable support for NVMe-TCP/TLS.
We need a separate keyring for NVMe as the configuration is done
via individual commands (eg for configfs), and the usual per-session
or per-process keyrings can't be used.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/common/Kconfig   |  9 +++++++++
 drivers/nvme/common/Makefile  |  1 +
 drivers/nvme/common/keyring.c | 36 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c      | 19 +++++++++++++++---
 include/linux/nvme-keyring.h  | 12 ++++++++++++
 5 files changed, 74 insertions(+), 3 deletions(-)
 create mode 100644 drivers/nvme/common/keyring.c
 create mode 100644 include/linux/nvme-keyring.h

diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
index 4514f44362dd..b6fff16da1fb 100644
--- a/drivers/nvme/common/Kconfig
+++ b/drivers/nvme/common/Kconfig
@@ -2,3 +2,12 @@
 
 config NVME_COMMON
        tristate
+
+config NVME_TLS
+	bool "NVMe/TCP TLS encryption support"
+	depends on NVME_COMMON
+	select KEYS
+	help
+	  Enables TLS encryption for NVMe/TCP using the netlink handshake API.
+
+	  If unsure, say N.
diff --git a/drivers/nvme/common/Makefile b/drivers/nvme/common/Makefile
index 720c625b8a52..4bf8c08293f3 100644
--- a/drivers/nvme/common/Makefile
+++ b/drivers/nvme/common/Makefile
@@ -5,3 +5,4 @@ ccflags-y			+= -I$(src)
 obj-$(CONFIG_NVME_COMMON)	+= nvme-common.o
 
 nvme-common-y			+= auth.o
+nvme-common-$(CONFIG_NVME_TLS)	+= keyring.o
diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
new file mode 100644
index 000000000000..3a6e8a0b38e2
--- /dev/null
+++ b/drivers/nvme/common/keyring.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Hannes Reinecke, SUSE Linux
+ */
+
+#include <linux/module.h>
+#include <linux/nvme.h>
+#include <linux/seq_file.h>
+#include <linux/key-type.h>
+#include <keys/user-type.h>
+
+static struct key *nvme_keyring;
+
+int nvme_keyring_init(void)
+{
+	int err;
+
+	nvme_keyring = keyring_alloc(".nvme",
+				     GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
+				     current_cred(),
+				     (KEY_POS_ALL & ~KEY_POS_SETATTR) |
+				     (KEY_USR_ALL & ~KEY_USR_SETATTR),
+				     KEY_ALLOC_NOT_IN_QUOTA, NULL, NULL);
+	if (IS_ERR(nvme_keyring))
+		return PTR_ERR(nvme_keyring);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_keyring_init);
+
+void nvme_keyring_exit(void)
+{
+	key_revoke(nvme_keyring);
+	key_put(nvme_keyring);
+}
+EXPORT_SYMBOL_GPL(nvme_keyring_exit);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d4be525f8100..416d0a898f56 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -25,6 +25,9 @@
 #include "nvme.h"
 #include "fabrics.h"
 #include <linux/nvme-auth.h>
+#ifdef CONFIG_NVME_TLS
+#include <linux/nvme-keyring.h>
+#endif
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -3954,7 +3957,6 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 	if (a == &dev_attr_dhchap_ctrl_secret.attr && !ctrl->opts)
 		return 0;
 #endif
-
 	return a->mode;
 }
 
@@ -5414,13 +5416,21 @@ static int __init nvme_core_init(void)
 		result = PTR_ERR(nvme_ns_chr_class);
 		goto unregister_generic_ns;
 	}
-
-	result = nvme_init_auth();
+#ifdef CONFIG_NVME_TLS
+	result = nvme_keyring_init();
 	if (result)
 		goto destroy_ns_chr;
+#endif
+	result = nvme_init_auth();
+	if (result)
+		goto keyring_exit;
 	return 0;
 
+keyring_exit:
+#ifdef CONFIG_NVME_TLS
+	nvme_keyring_exit();
 destroy_ns_chr:
+#endif
 	class_destroy(nvme_ns_chr_class);
 unregister_generic_ns:
 	unregister_chrdev_region(nvme_ns_chr_devt, NVME_MINORS);
@@ -5443,6 +5453,9 @@ static int __init nvme_core_init(void)
 static void __exit nvme_core_exit(void)
 {
 	nvme_exit_auth();
+#ifdef CONFIG_NVME_TLS
+	nvme_keyring_exit();
+#endif
 	class_destroy(nvme_ns_chr_class);
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
new file mode 100644
index 000000000000..a875c06cc922
--- /dev/null
+++ b/include/linux/nvme-keyring.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2021 Hannes Reinecke, SUSE Software Solutions
+ */
+
+#ifndef _NVME_KEYRING_H
+#define _NVME_KEYRING_H
+
+int nvme_keyring_init(void);
+void nvme_keyring_exit(void);
+
+#endif
-- 
2.35.3


