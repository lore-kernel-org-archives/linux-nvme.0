Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6452EC25B67
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Oct 2023 13:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jeQGLcZ/+4kCSBhUztjv2D9e02Mh89g7FC90bDt+iTw=; b=BKpbAqp5WeNa7TH8ldFOzmQ1Vv
	Kq7IU9ph8cWYuAL3J00C1Evk01pZKaqR7pSd70pX7RigSa8ALH3n/9PvwQSjWaAJb1ljKNHiwlBGO
	g71luqx0bj6vBLmlrYcdoS228sVTHW7S5b9ZBhU7F0XF8dVH64yVWQj1c/dZ3M83a+krtMAHnAmXb
	K3dJbM8L6EalNHNCO1+tONRg4N8kKrQRX+7vrdwe7i6p+m0vtNmr+vLyIDWRRbudMAHMTXDd9OpJO
	o91mEJeMwXNRor4orTHskFBXhxKAQuWUyCxArmATG2qckELqZslsJ2JTs/eEK6fgfw7rJeAioEtVr
	BFG7TNsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qw06C-00EWKU-1S;
	Thu, 26 Oct 2023 13:08:32 +0000
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qw067-00EWIh-22
	for linux-nvme@lists.infradead.org;
	Thu, 26 Oct 2023 13:08:30 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 979B91FE44;
	Thu, 26 Oct 2023 13:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1698325701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jeQGLcZ/+4kCSBhUztjv2D9e02Mh89g7FC90bDt+iTw=;
	b=G3Q83SKxy7m56LzgZxHd+C1LBRRO/JWln0uM1/feXRYky06PFN1pAVrzjKTryWs1UmvODb
	xwgIp4Zn0vK7OMqvY4nS1E5G1seo7mPEHAt3Kiis9/zQJx2oacvBJuOeqozJCsAWG/m6PJ
	EzdvSN9r+a3cBzerTMFRpOuBQQKumok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1698325701;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jeQGLcZ/+4kCSBhUztjv2D9e02Mh89g7FC90bDt+iTw=;
	b=UywzkY3DqmzzyOBahm72//kui+TLMOeKgClSZr/Hvy+0kLzOv2n+FBPFaI4OesfzeuOR+C
	S4qKiUXtkl5vFZBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id D1C3D2D5BA;
	Thu, 26 Oct 2023 13:08:19 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id E0E8A51EC53E; Thu, 26 Oct 2023 15:08:19 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 2/2] nvme: keyring: fix conditional compilation
Date: Thu, 26 Oct 2023 15:08:04 +0200
Message-Id: <20231026130804.142586-3-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231026130804.142586-1-hare@suse.de>
References: <20231026130804.142586-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_060827_815324_9D2AE877 
X-CRM114-Status: GOOD (  18.91  )
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

The keyring and auth functions can be called from both the host and
the target side and are controlled by Kconfig options for each of the
combinations, but the declarations are controlled by #ifdef checks
on the shared Kconfig symbols.

This leads to link failures in combinations where one of the frontends
is built-in and the other one is a module, and the keyring code
ends up in a module that is not reachable from the builtin code:

ld: drivers/nvme/host/core.o: in function `nvme_core_exit':
core.c:(.exit.text+0x4): undefined reference to `nvme_keyring_exit'
ld: drivers/nvme/host/core.o: in function `nvme_core_init':
core.c:(.init.text+0x94): undefined reference to `nvme_keyring_init

ld: drivers/nvme/host/tcp.o: in function `nvme_tcp_setup_ctrl':
tcp.c:(.text+0x4c18): undefined reference to `nvme_tls_psk_default'

Address this by moving nvme_auth_init()/nvme_auth_exit() into
module init/exit functions for the keyring module and make sure
that the keyring module is always built in when one of the
dependent modules are selected.

Fixes: be8e82caa6859 ("nvme-tcp: enable TLS handshake upcall")
Signed-off-by: Hannes Reinecke <hare@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvme/common/Kconfig   | 2 +-
 drivers/nvme/common/keyring.c | 9 +++++----
 drivers/nvme/host/Kconfig     | 2 +-
 drivers/nvme/host/core.c      | 9 +--------
 drivers/nvme/target/Kconfig   | 2 +-
 include/linux/nvme-keyring.h  | 8 --------
 6 files changed, 9 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
index 244432e0b73d..96031016079f 100644
--- a/drivers/nvme/common/Kconfig
+++ b/drivers/nvme/common/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
 config NVME_KEYRING
-       tristate
+       bool
        select KEYS
 
 config NVME_AUTH
diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 46d7a537dbc2..ee341b83eeba 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -151,7 +151,7 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
 }
 EXPORT_SYMBOL_GPL(nvme_tls_psk_default);
 
-int nvme_keyring_init(void)
+static int __init nvme_keyring_init(void)
 {
 	int err;
 
@@ -171,14 +171,15 @@ int nvme_keyring_init(void)
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(nvme_keyring_init);
 
-void nvme_keyring_exit(void)
+static void __exit nvme_keyring_exit(void)
 {
 	unregister_key_type(&nvme_tls_psk_key_type);
 	key_revoke(nvme_keyring);
 	key_put(nvme_keyring);
 }
-EXPORT_SYMBOL_GPL(nvme_keyring_exit);
 
 MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Hannes Reinecke <hare@suse.de>");
+module_init(nvme_keyring_init);
+module_exit(nvme_keyring_exit);
diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 8fe2dd619e80..ff6a8af10646 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -95,7 +95,7 @@ config NVME_TCP
 config NVME_TCP_TLS
 	bool "NVMe over Fabrics TCP TLS encryption support"
 	depends on NVME_TCP
-	select NVME_KEYRING
+	select NVME_KEYRING if NVME_TCP_TLS
 	select NET_HANDSHAKE
 	select KEYS
 	help
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f48b4f735d2d..47645a219128 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -25,7 +25,6 @@
 #include "nvme.h"
 #include "fabrics.h"
 #include <linux/nvme-auth.h>
-#include <linux/nvme-keyring.h>
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -4724,16 +4723,11 @@ static int __init nvme_core_init(void)
 		result = PTR_ERR(nvme_ns_chr_class);
 		goto unregister_generic_ns;
 	}
-	result = nvme_keyring_init();
-	if (result)
-		goto destroy_ns_chr;
 	result = nvme_init_auth();
 	if (result)
-		goto keyring_exit;
+		goto destroy_ns_chr;
 	return 0;
 
-keyring_exit:
-	nvme_keyring_exit();
 destroy_ns_chr:
 	class_destroy(nvme_ns_chr_class);
 unregister_generic_ns:
@@ -4757,7 +4751,6 @@ static int __init nvme_core_init(void)
 static void __exit nvme_core_exit(void)
 {
 	nvme_exit_auth();
-	nvme_keyring_exit();
 	class_destroy(nvme_ns_chr_class);
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 31633da9427c..9fe74b771fa3 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -87,7 +87,7 @@ config NVME_TARGET_TCP
 config NVME_TARGET_TCP_TLS
 	bool "NVMe over Fabrics TCP target TLS encryption support"
 	depends on NVME_TARGET_TCP
-	select NVME_KEYRING
+	select NVME_KEYRING if NVME_TARGET_TCP_TLS
 	select NET_HANDSHAKE
 	select KEYS
 	help
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index 4efea9dd967c..2095382de103 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -12,8 +12,6 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
 		const char *hostnqn, const char *subnqn);
 
 key_serial_t nvme_keyring_id(void);
-int nvme_keyring_init(void);
-void nvme_keyring_exit(void);
 
 #else
 
@@ -26,11 +24,5 @@ static inline key_serial_t nvme_keyring_id(void)
 {
 	return 0;
 }
-static inline int nvme_keyring_init(void)
-{
-	return 0;
-}
-static inline void nvme_keyring_exit(void) {}
-
 #endif /* !CONFIG_NVME_KEYRING */
 #endif /* _NVME_KEYRING_H */
-- 
2.35.3


