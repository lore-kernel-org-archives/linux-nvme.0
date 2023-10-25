Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3171C25B6E
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Oct 2023 08:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LUEdCgMumzrqhQ/ObehZFRJwKlGrNONgbFLKmWi/akk=; b=aWXOjJ2mrK6fvwiRPPf5e+MRTF
	FMUTd+nGfr9oJXETM0k0MxURCaBy3IqrbTvIwvQy3kSPmX1yJa5YubQpRVj3uPwHOHgl+0RQnJwDU
	KYqHvo5nth1GeFT6rZW7LeHX8p7BWf00eqyoDnfHWNpmNMQ93r0smsw+GMjRQuUY7KGqZZoPAA79k
	KIxy1LnWI7cYu0v1PdRRLh/JfK5SYKr19lMi9b6k5buTTYvnSOdPCuZbdCQQvS+EwoaMfduGqF/W0
	z+iw3lr5nKjJrHyPzX48Tjd37saqvJf7KpD2qi4YecHsZQL2YBIKGl5aANQT5UUxAbJ/D4yuCrK0E
	ekJLcsgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvZ0n-00BfoN-2Y;
	Wed, 25 Oct 2023 08:13:09 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvZ0i-00Bflj-0K
	for linux-nvme@lists.infradead.org;
	Wed, 25 Oct 2023 08:13:06 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 0366621D68;
	Wed, 25 Oct 2023 08:13:00 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id B32302D31A;
	Wed, 25 Oct 2023 08:12:59 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id DF1DA51EC480; Wed, 25 Oct 2023 10:12:59 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 2/2] nvme: keyring: fix conditional compilation
Date: Wed, 25 Oct 2023 10:12:53 +0200
Message-Id: <20231025081253.113738-3-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231025081253.113738-1-hare@suse.de>
References: <20231025081253.113738-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++
Authentication-Results: smtp-out1.suse.de;
	dkim=none;
	dmarc=none;
	spf=softfail (smtp-out1.suse.de: 149.44.160.134 is neither permitted nor denied by domain of hare@suse.de) smtp.mailfrom=hare@suse.de
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
X-Rspamd-Queue-Id: 0366621D68
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231025_011304_298155_354C2D79 
X-CRM114-Status: GOOD (  16.94  )
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

From: Arnd Bergmann <arnd@arndb.de>

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
module init/exit functions for the keyring module.

Fixes: be8e82caa6859 ("nvme-tcp: enable TLS handshake upcall")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/common/keyring.c | 9 +++++----
 drivers/nvme/host/core.c      | 9 +--------
 include/linux/nvme-keyring.h  | 8 --------
 3 files changed, 6 insertions(+), 20 deletions(-)

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
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index 6cc0696625f3..e10333d78dbb 100644
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


