Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F5FC6FA8F
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Aug 2023 14:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FQqYYIOb8vWqxiQHbz2yDg7e1e95gSKNG15/a5Zrh7U=; b=j+rB5Bs9BBvwtwMdhuTnd79ZVD
	HySjSC3Ve091bQzqnbAQVCeeYp5bVztWOHw7K75YEq+MT1eacvrjcLZ0HOqKh2+OFcctxJsu/a9Re
	9PCWiCI7hIiQ3vsB2oVXb8PONyIhlRl84DZa87Fm2veiCLrkC1nZ5xvb8AXN1US8yAfTWiS70ZFD9
	IGmM+h1W8MWPejgvphSPuruN3O7KnMUFYXJCaFRZ4h5hamZxRSzHML05ulk34QedqgXraggoow9gU
	4zNaHJR/V7pAI/rH/MkmdzK4zaRzEH5wMxgSlJudBpHJwtQSeJidFQsUTaouM98UYSadPWRGCdd6u
	Z0uzosYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qZBUo-003FKU-2N;
	Thu, 24 Aug 2023 14:39:38 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qZBUi-003FCz-0Q
	for linux-nvme@lists.infradead.org;
	Thu, 24 Aug 2023 14:39:34 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id B29D922A95;
	Thu, 24 Aug 2023 14:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692887966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQqYYIOb8vWqxiQHbz2yDg7e1e95gSKNG15/a5Zrh7U=;
	b=is9wGERyYTwyaIYJXI2PgUTxA4pCgiF5CHd8s5zdo92pMPTzFxjtTI3ENRGX9RlzEvaKHX
	88IBhnLY1uf+9x2XSELKI+CDKsOzGNPqqJgkJay62NO7omSJjJuziVscwmQ52PsIfpSfoa
	MpA6hb5aDW26Pf+njB8NPMGsy26IESY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692887966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FQqYYIOb8vWqxiQHbz2yDg7e1e95gSKNG15/a5Zrh7U=;
	b=04ZlCSRZy4mO1U+xCsNv3YMRf3OqUOZMKv/5Dq+VauPX/yO5EPxFyIrliLWbgRI68S4YcE
	hdeL6AOYjFTP+EBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id A58702C145;
	Thu, 24 Aug 2023 14:39:26 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 98E3751CB8B9; Thu, 24 Aug 2023 16:39:26 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 01/18] nvme-keyring: register '.nvme' keyring
Date: Thu, 24 Aug 2023 16:39:08 +0200
Message-Id: <20230824143925.9098-2-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230824143925.9098-1-hare@suse.de>
References: <20230824143925.9098-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230824_073932_355107_93007855 
X-CRM114-Status: GOOD (  19.93  )
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
add a new config option NVME_KEYRING.
We need a separate keyring for NVMe as the configuration is done
via individual commands (eg for configfs), and the usual per-session
or per-process keyrings can't be used.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/common/Kconfig   |  4 ++++
 drivers/nvme/common/Makefile  |  3 ++-
 drivers/nvme/common/keyring.c | 40 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c      | 10 +++++++--
 include/linux/nvme-keyring.h  | 28 ++++++++++++++++++++++++
 5 files changed, 82 insertions(+), 3 deletions(-)
 create mode 100644 drivers/nvme/common/keyring.c
 create mode 100644 include/linux/nvme-keyring.h

diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
index 4514f44362dd..641b27adb047 100644
--- a/drivers/nvme/common/Kconfig
+++ b/drivers/nvme/common/Kconfig
@@ -2,3 +2,7 @@
 
 config NVME_COMMON
        tristate
+
+config NVME_KEYRING
+       bool
+       select KEYS
diff --git a/drivers/nvme/common/Makefile b/drivers/nvme/common/Makefile
index 720c625b8a52..0cbd0b0b8d49 100644
--- a/drivers/nvme/common/Makefile
+++ b/drivers/nvme/common/Makefile
@@ -4,4 +4,5 @@ ccflags-y			+= -I$(src)
 
 obj-$(CONFIG_NVME_COMMON)	+= nvme-common.o
 
-nvme-common-y			+= auth.o
+nvme-common-$(CONFIG_NVME_AUTH)	+= auth.o
+nvme-common-$(CONFIG_NVME_KEYRING) += keyring.o
diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
new file mode 100644
index 000000000000..5cf64b278119
--- /dev/null
+++ b/drivers/nvme/common/keyring.c
@@ -0,0 +1,40 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023 Hannes Reinecke, SUSE Labs
+ */
+
+#include <linux/module.h>
+#include <linux/seq_file.h>
+#include <linux/key-type.h>
+#include <keys/user-type.h>
+#include <linux/nvme.h>
+
+static struct key *nvme_keyring;
+
+key_serial_t nvme_keyring_id(void)
+{
+	return nvme_keyring->serial;
+}
+EXPORT_SYMBOL_GPL(nvme_keyring_id);
+
+int nvme_keyring_init(void)
+{
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
index 37b6fa746662..dfc574d0f18d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -25,6 +25,7 @@
 #include "nvme.h"
 #include "fabrics.h"
 #include <linux/nvme-auth.h>
+#include <linux/nvme-keyring.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -4703,12 +4704,16 @@ static int __init nvme_core_init(void)
 		result = PTR_ERR(nvme_ns_chr_class);
 		goto unregister_generic_ns;
 	}
-
-	result = nvme_init_auth();
+	result = nvme_keyring_init();
 	if (result)
 		goto destroy_ns_chr;
+	result = nvme_init_auth();
+	if (result)
+		goto keyring_exit;
 	return 0;
 
+keyring_exit:
+	nvme_keyring_exit();
 destroy_ns_chr:
 	class_destroy(nvme_ns_chr_class);
 unregister_generic_ns:
@@ -4732,6 +4737,7 @@ static int __init nvme_core_init(void)
 static void __exit nvme_core_exit(void)
 {
 	nvme_exit_auth();
+	nvme_keyring_exit();
 	class_destroy(nvme_ns_chr_class);
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
new file mode 100644
index 000000000000..32bd264a71e6
--- /dev/null
+++ b/include/linux/nvme-keyring.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2023 Hannes Reinecke, SUSE Labs
+ */
+
+#ifndef _NVME_KEYRING_H
+#define _NVME_KEYRING_H
+
+#ifdef CONFIG_NVME_KEYRING
+
+key_serial_t nvme_keyring_id(void);
+int nvme_keyring_init(void);
+void nvme_keyring_exit(void);
+
+#else
+
+static inline key_serial_t nvme_keyring_id(void)
+{
+	return 0;
+}
+static inline int nvme_keyring_init(void)
+{
+	return 0;
+}
+static inline void nvme_keyring_exit(void) {}
+
+#endif /* !CONFIG_NVME_KEYRING */
+#endif /* _NVME_KEYRING_H */
-- 
2.35.3


