Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C95C0C25B47
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Oct 2023 08:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nms7fvyHK+8juOuEXMWBGJgtw4rxsIup7ttnM3ZQPGs=; b=dG3n6Rhu3KCN+XC8HwDyPshK8H
	p2O2xGk0E4U+a1sB+HtZTziFS4ugXLUEHJnB5pjYcBWPJdguwdr+CDn3Qb2Tu5iKkCtdPCXqT+jtG
	FHo2FktysgMEhJ5Zv8tOAIAWPLvNn8Wdz7Q6sFLjMovzHGsaDi6zQKYr8rVrFMSC4ZV8Fz/rr/Qyc
	IFQyAreIeRoKUkZwGr1lpZjQuS54QVRwAN1ednHkMpnANUFf4cv7V5O+C+nyyKF6xmsKgZdNWi3YJ
	WP4mIHhzH8cWmgNVdvIZhl8CfKTAI+ETn4oTrEN3QPqfV4nPRRDLUgHxZqRmnwZdyLXlT8s+hwhVF
	Plra65vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvZ0l-00BfnQ-17;
	Wed, 25 Oct 2023 08:13:07 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvZ0i-00Bfln-0K
	for linux-nvme@lists.infradead.org;
	Wed, 25 Oct 2023 08:13:05 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 0336121D67;
	Wed, 25 Oct 2023 08:13:00 +0000 (UTC)
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id AFCAD2D319;
	Wed, 25 Oct 2023 08:12:59 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id DAE0251EC47E; Wed, 25 Oct 2023 10:12:59 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/2] nvme: common: make keyring and auth separate modules
Date: Wed, 25 Oct 2023 10:12:52 +0200
Message-Id: <20231025081253.113738-2-hare@suse.de>
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
X-Rspamd-Queue-Id: 0336121D67
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231025_011304_298339_6A82D399 
X-CRM114-Status: GOOD (  12.17  )
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

When only the keyring module is included but auth is not, modpost
complains about the lack of a module license tag:

ERROR: modpost: missing MODULE_LICENSE() in drivers/nvme/common/nvme-common.o

Address this by making both modules buildable standalone,
removing the now unnecessary CONFIG_NVME_COMMON symbol
in the process.

Fixes: 9d77eb5277849 ("nvme-keyring: register '.nvme' keyring")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/Makefile         | 2 +-
 drivers/nvme/common/Kconfig   | 7 ++-----
 drivers/nvme/common/Makefile  | 7 ++++---
 drivers/nvme/common/keyring.c | 2 ++
 drivers/nvme/host/Kconfig     | 2 --
 drivers/nvme/target/Kconfig   | 2 --
 include/linux/nvme-keyring.h  | 2 +-
 7 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/Makefile b/drivers/nvme/Makefile
index eedca8c72098..74f59ceed3d5 100644
--- a/drivers/nvme/Makefile
+++ b/drivers/nvme/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_NVME_COMMON)		+= common/
+obj-y		+= common/
 obj-y		+= host/
 obj-y		+= target/
diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
index 06c8df00d1e2..244432e0b73d 100644
--- a/drivers/nvme/common/Kconfig
+++ b/drivers/nvme/common/Kconfig
@@ -1,14 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-config NVME_COMMON
-       tristate
-
 config NVME_KEYRING
-       bool
+       tristate
        select KEYS
 
 config NVME_AUTH
-	bool
+	tristate
 	select CRYPTO
 	select CRYPTO_HMAC
 	select CRYPTO_SHA256
diff --git a/drivers/nvme/common/Makefile b/drivers/nvme/common/Makefile
index 0cbd0b0b8d49..681514cf2e2f 100644
--- a/drivers/nvme/common/Makefile
+++ b/drivers/nvme/common/Makefile
@@ -2,7 +2,8 @@
 
 ccflags-y			+= -I$(src)
 
-obj-$(CONFIG_NVME_COMMON)	+= nvme-common.o
+obj-$(CONFIG_NVME_AUTH)		+= nvme-auth.o
+obj-$(CONFIG_NVME_KEYRING)	+= nvme-keyring.o
 
-nvme-common-$(CONFIG_NVME_AUTH)	+= auth.o
-nvme-common-$(CONFIG_NVME_KEYRING) += keyring.o
+nvme-auth-y			+= auth.o
+nvme-keyring-y			+= keyring.o
diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index f8d9a208397b..46d7a537dbc2 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -180,3 +180,5 @@ void nvme_keyring_exit(void)
 	key_put(nvme_keyring);
 }
 EXPORT_SYMBOL_GPL(nvme_keyring_exit);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 48f7d72de5e9..8fe2dd619e80 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -95,7 +95,6 @@ config NVME_TCP
 config NVME_TCP_TLS
 	bool "NVMe over Fabrics TCP TLS encryption support"
 	depends on NVME_TCP
-	select NVME_COMMON
 	select NVME_KEYRING
 	select NET_HANDSHAKE
 	select KEYS
@@ -110,7 +109,6 @@ config NVME_TCP_TLS
 config NVME_HOST_AUTH
 	bool "NVM Express over Fabrics In-Band Authentication"
 	depends on NVME_CORE
-	select NVME_COMMON
 	select NVME_AUTH
 	help
 	  This provides support for NVMe over Fabrics In-Band Authentication.
diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index fa479c9f5c3d..31633da9427c 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -87,7 +87,6 @@ config NVME_TARGET_TCP
 config NVME_TARGET_TCP_TLS
 	bool "NVMe over Fabrics TCP target TLS encryption support"
 	depends on NVME_TARGET_TCP
-	select NVME_COMMON
 	select NVME_KEYRING
 	select NET_HANDSHAKE
 	select KEYS
@@ -102,7 +101,6 @@ config NVME_TARGET_TCP_TLS
 config NVME_TARGET_AUTH
 	bool "NVMe over Fabrics In-band Authentication support"
 	depends on NVME_TARGET
-	select NVME_COMMON
 	select NVME_AUTH
 	help
 	  This enables support for NVMe over Fabrics In-band Authentication
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index 4efea9dd967c..6cc0696625f3 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -6,7 +6,7 @@
 #ifndef _NVME_KEYRING_H
 #define _NVME_KEYRING_H
 
-#ifdef CONFIG_NVME_KEYRING
+#if IS_ENABLED(CONFIG_NVME_KEYRING)
 
 key_serial_t nvme_tls_psk_default(struct key *keyring,
 		const char *hostnqn, const char *subnqn);
-- 
2.35.3


