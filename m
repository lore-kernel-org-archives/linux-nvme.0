Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEC1C00A98
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Oct 2023 13:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vGXv66eZ0wMRoaEtzxxK0+b9veWNLthpxNxvzTx435I=; b=fUwykimNS90mO6FAMVLtX9xP/I
	n/QSOeOkUyEVDni5m0YScv7Oso2pXKJUdzdW1XB+nxAnueL5h+7E2Okpm50KYvJK0dcGHQTU9Iiud
	SUcxQsD31ABZZyDkR5Tx+KcgIByd5gCv5oyIaVNBfJ0B3KnTwkb/oU0bxi1r8Gp+bVtyhhfOSLmei
	sDOuctinKT6RyQAzNTgVgH2CSKr+vVacizXAYa2UEU6eSkSnZ2Y6TiI8OCKM0p/9l/tcqmAczRoQ5
	2o8Yn62jrzObp8g6ut6tmKikCzCS+QCORgIcZZh/0wnLSW18m18uyGJSy4g3NzG1ow9D06UW8UI4/
	Oys3ziAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtpDv-002KJp-1F;
	Fri, 20 Oct 2023 13:07:31 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtpDq-002KHa-0h
	for linux-nvme@lists.infradead.org;
	Fri, 20 Oct 2023 13:07:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 67A8C6217A;
	Fri, 20 Oct 2023 13:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE90C433C9;
	Fri, 20 Oct 2023 13:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697807245;
	bh=wNQVb7PLDPRN/789KQQ8f4+mbdFALdcAtpqplVs0G9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JpRPnE5M2ye+1dOqHuel9GcdgmwuyV5hS2C7vr04oOI1DvF7WXPXKybloPw3+mD4u
	 IRjbnZLvlFcchjX2BRjLF3i+Zw1vvLYrCfk1keITwRDF4VbaCyc1ONgJntwn4OCSWZ
	 PEcHDWpEkFcDXDFypGcTfgoVI/iCMaJChPMeQ6QQ8osUx5VDIdUZN3IujbWafwyoSJ
	 zIPzGc6+gJXS3i0W7wERZXO+RHgz+sY0AnLeg8BpHCzygUoPGRs0fmnTit3CdCeVpB
	 O2NhSYdQmPRsKmyTs6/EVyL7hWBYQAsRpMbP59+KVXL2GOTlZilJxcAHUVEjWphne+
	 Jnco2n6lpng5w==
From: Arnd Bergmann <arnd@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mike Christie <michael.christie@oracle.com>,
	Uday Shankar <ushankar@purestorage.com>,
	David Howells <dhowells@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nvme: keyring: fix conditional compilation
Date: Fri, 20 Oct 2023 15:05:37 +0200
Message-Id: <20231020130644.485649-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231020130644.485649-1-arnd@kernel.org>
References: <20231020130644.485649-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_060727_209558_5B83C011 
X-CRM114-Status: GOOD (  21.19  )
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

Address this by adding compile-time checks around the callers where
needed, based on whether the functionality is actually used for
the target and host side, respectively.

In Kconfig, this requires changing the 'select NVME_KEYRING'
since the keyring calls are done from the host core module,
which may be built-in even when the tcp front-end is in a loadable
module.

Fixes: be8e82caa6859 ("nvme-tcp: enable TLS handshake upcall")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvme/host/Kconfig      |  2 +-
 drivers/nvme/host/core.c       | 16 +++++++++++-----
 drivers/nvme/host/tcp.c        |  2 +-
 drivers/nvme/target/configfs.c |  2 +-
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 8fe2dd619e80e..2d53c23f0a483 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -2,6 +2,7 @@
 config NVME_CORE
 	tristate
 	select BLK_DEV_INTEGRITY_T10 if BLK_DEV_INTEGRITY
+	select NVME_KEYRING if NVME_TCP_TLS
 
 config BLK_DEV_NVME
 	tristate "NVM Express block device"
@@ -95,7 +96,6 @@ config NVME_TCP
 config NVME_TCP_TLS
 	bool "NVMe over Fabrics TCP TLS encryption support"
 	depends on NVME_TCP
-	select NVME_KEYRING
 	select NET_HANDSHAKE
 	select KEYS
 	help
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 62612f87aafa2..ac92534f6da90 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4724,16 +4724,20 @@ static int __init nvme_core_init(void)
 		result = PTR_ERR(nvme_ns_chr_class);
 		goto unregister_generic_ns;
 	}
-	result = nvme_keyring_init();
+	if (IS_ENABLED(CONFIG_NVME_TCP_TLS))
+		result = nvme_keyring_init();
 	if (result)
 		goto destroy_ns_chr;
-	result = nvme_init_auth();
+
+	if (IS_ENABLED(CONFIG_NVME_HOST_AUTH))
+		result = nvme_init_auth();
 	if (result)
 		goto keyring_exit;
 	return 0;
 
 keyring_exit:
-	nvme_keyring_exit();
+	if (IS_ENABLED(CONFIG_NVME_TCP_TLS))
+		nvme_keyring_exit();
 destroy_ns_chr:
 	class_destroy(nvme_ns_chr_class);
 unregister_generic_ns:
@@ -4756,8 +4760,10 @@ static int __init nvme_core_init(void)
 
 static void __exit nvme_core_exit(void)
 {
-	nvme_exit_auth();
-	nvme_keyring_exit();
+	if (IS_ENABLED(CONFIG_NVME_HOST_AUTH))
+		nvme_exit_auth();
+	if (IS_ENABLED(CONFIG_NVME_TCP_TLS))
+		nvme_keyring_exit();
 	class_destroy(nvme_ns_chr_class);
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 4714a902f4caa..e2b90789c0407 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1915,7 +1915,7 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 	int ret;
 	key_serial_t pskid = 0;
 
-	if (ctrl->opts->tls) {
+	if (IS_ENABLED(CONFIG_NVME_TCP_TLS) && ctrl->opts->tls) {
 		if (ctrl->opts->tls_key)
 			pskid = key_serial(ctrl->opts->tls_key);
 		else
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 9eed6e6765eaa..e307a044b1a1b 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1893,7 +1893,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 		return ERR_PTR(-ENOMEM);
 	}
 
-	if (nvme_keyring_id()) {
+	if (IS_ENABLED(CONFIG_NVME_TARGET_TCP_TLS) && nvme_keyring_id()) {
 		port->keyring = key_lookup(nvme_keyring_id());
 		if (IS_ERR(port->keyring)) {
 			pr_warn("NVMe keyring not available, disabling TLS\n");
-- 
2.39.2


