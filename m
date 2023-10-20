Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF3F3CDB474
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Oct 2023 13:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yUbGpYd/N96A9rz9XkioHRPlIAFKn1enm3n5voEwEg8=; b=VfC+ZUP27BWIp2dXD5M0ueRulb
	XhsZsCUOsDCsaCtm6F1lGESlaq72DMCXEs7Ky0d93SSWoZteLE/4ZC8WVEroLTA9ITW/TeTDY2sCp
	OX8kUDsYJ+XxBJtqWkzgipNXvNraXDJsNynEuHN05KRYkipH7Tn6Un/Dm9aKTpcfwRSUbCJ4s72Hp
	ljLvL4juS62Ylkqgy5Wr1lE8T9sTJAzZvmMXFVBQhw2ujclj53+hU40WTYToxnv/BfRLgJSwpJx/V
	sflI+ZAIFazlN7DNMINwvLXTvv8JZSq69mAhsdTC3/VBerbr7G0LyRYJe7L/61baXAOa5FDzT2KC8
	Lw26sjbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtpDM-002K5g-1s;
	Fri, 20 Oct 2023 13:06:56 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtpDJ-002K4B-20
	for linux-nvme@lists.infradead.org;
	Fri, 20 Oct 2023 13:06:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 454FDCE3893;
	Fri, 20 Oct 2023 13:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CE8C433C7;
	Fri, 20 Oct 2023 13:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697807210;
	bh=uIjXzeVXzA8EnjCxAvZ97JSiutk5X18H+VL0S6ZqDV4=;
	h=From:To:Cc:Subject:Date:From;
	b=XEVLCGtZK5qOvOOD/jof56nAfpYXeAiLzHwwY1703KyPZB1tWze6MJ6yK0Em7evWz
	 Yb+sh4wYLoXFF8mw4M1Jz7WhQx0YOlYltUb9gsy2gkU1eSaJz9WFZBh1I2QLyDBQla
	 d48JGh5gygM5Zvj/+K/w60sixsRAeSoT6YKHwLSBX9aNdHp1QPtKdrZb/grs63mKM3
	 kp4P1eWbv5raHvv/12p2HnN4H/20y3xZA/i9aIz1YO++GmzGDUanN9Sn+duyExl5pu
	 UHilWKqEcOu9VKO1mR2SuCmTjvAJYQ1aH4U12P+95DjmDD3xvw88eGy0Rxwi7nzYqD
	 +Njva24BcE2WA==
From: Arnd Bergmann <arnd@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvme: common: make keyring and auth separate modules
Date: Fri, 20 Oct 2023 15:05:36 +0200
Message-Id: <20231020130644.485649-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_060654_125943_580E9B79 
X-CRM114-Status: GOOD (  13.75  )
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
---
 drivers/nvme/Makefile         | 2 +-
 drivers/nvme/common/Kconfig   | 4 ++--
 drivers/nvme/common/Makefile  | 7 ++++---
 drivers/nvme/common/keyring.c | 2 ++
 drivers/nvme/host/Kconfig     | 2 --
 drivers/nvme/target/Kconfig   | 2 --
 include/linux/nvme-keyring.h  | 2 +-
 7 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/Makefile b/drivers/nvme/Makefile
index eedca8c720983..74f59ceed3d5a 100644
--- a/drivers/nvme/Makefile
+++ b/drivers/nvme/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_NVME_COMMON)		+= common/
+obj-y		+= common/
 obj-y		+= host/
 obj-y		+= target/
diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
index 06c8df00d1e21..63d4fd45999dc 100644
--- a/drivers/nvme/common/Kconfig
+++ b/drivers/nvme/common/Kconfig
@@ -4,11 +4,11 @@ config NVME_COMMON
        tristate
 
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
index 0cbd0b0b8d499..681514cf2e2f5 100644
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
index f8d9a208397b4..46d7a537dbc2e 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -180,3 +180,5 @@ void nvme_keyring_exit(void)
 	key_put(nvme_keyring);
 }
 EXPORT_SYMBOL_GPL(nvme_keyring_exit);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 48f7d72de5e9a..8fe2dd619e80e 100644
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
index fa479c9f5c3d3..31633da9427c7 100644
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
index 4efea9dd967c1..6cc0696625f36 100644
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
2.39.2


