Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89250C4167B
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 18:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1f0s2tRkjOdW+FyqCAcb8pokm+mQ2WhmAQoNF2H55+E=; b=oWqYFMTKElHDNyA5jYVdAd3kSG
	BpTDqGpXfTezwhodzsZd8NYi7W5/DoWiCES4Nw7ANy9U6C3k9a3b3abPolptTojGGgD5QP5LBllQe
	fukCKLVk6KHDaL1deAmN9NUY3L+vZ011bm3S5/fUReI4A7B8P3jJQDrCZR7rSQxE63+xPHz2qKVZQ
	S4dT+6YZPtphduKx25iagy3LFrVi8Xl9m0bolEKPG7dRS9uRAYZcacK2SssgIb3xwbp2GgoJjpFHH
	KKeK2n2l3QNl/bKYluXHPPG/Z1G29pB9l5F33CjOQ9tzaP8DjzTMY1O250D5WE237/5SULaAnZD+X
	1swL1KLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0QbT-002AbF-2Q;
	Tue, 07 Nov 2023 18:15:07 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0QbQ-002AaD-22
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 18:15:06 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3A7FwaC0004861
	for <linux-nvme@lists.infradead.org>; Tue, 7 Nov 2023 10:15:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=1f0s2tRkjOdW+FyqCAcb8pokm+mQ2WhmAQoNF2H55+E=;
 b=EBelEXvHMiqUABBgD+y8zK26qyFhPeDZP32M5zLf3eoa4lRsYUBwClaRtFjd4POjA+Ek
 U0ZOx5nFXaXwOXuFnjxy3KH9+1SsxdYOHAlbixjXWLFgDyxxMBW9+xVxxYqvrdVyDbR3
 PDTrmBhsgKOjatw5yuUtsl9TLhjWmr0CXtaQ0t7BZD9bHTB0XKT3lnopqNvZUsg+67zu
 9E7Q7AtodYx9t95V0lRWAvMUvR1xXZzfDx2IRZfJgOAXgQfosW4h0AK47FU3OGyPVLDs
 rE+qNHPcNNgUfIF0w5lZWRfiExaP/n4Cluea9QMphOEIdxGH+cisTxhnr5lGEV+gXXnY kQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3u7a4a6qtg-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 07 Nov 2023 10:15:03 -0800
Received: from twshared5789.02.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 10:14:59 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 11CA4215360BE; Tue,  7 Nov 2023 10:14:43 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <hare@suse.de>, <rnd@arndb.de>,
        Arnd Bergmann
	<arnd@arndb.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 2/2] nvme: keyring: fix conditional compilation
Date: Tue, 7 Nov 2023 10:14:21 -0800
Message-ID: <20231107181421.593353-3-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107181421.593353-1-kbusch@meta.com>
References: <20231107181421.593353-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8iOMSsatFaVTi7tDypbEooDLArFENo4c
X-Proofpoint-GUID: 8iOMSsatFaVTi7tDypbEooDLArFENo4c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_10,2023-11-07_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_101504_781864_CA7B62E2 
X-CRM114-Status: GOOD (  20.04  )
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

From: Hannes Reinecke <hare@suse.de>

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

Address this by moving nvme_keyring_init()/nvme_keyring_exit() into
module init/exit functions for the keyring module.

Fixes: be8e82caa6859 ("nvme-tcp: enable TLS handshake upcall")
Signed-off-by: Hannes Reinecke <hare@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/common/keyring.c | 9 +++++----
 drivers/nvme/host/core.c      | 9 +--------
 include/linux/nvme-keyring.h  | 8 --------
 3 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.=
c
index 46d7a537dbc2e..ee341b83eebaf 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -151,7 +151,7 @@ key_serial_t nvme_tls_psk_default(struct key *keyring=
,
 }
 EXPORT_SYMBOL_GPL(nvme_tls_psk_default);
=20
-int nvme_keyring_init(void)
+static int __init nvme_keyring_init(void)
 {
 	int err;
=20
@@ -171,14 +171,15 @@ int nvme_keyring_init(void)
 	}
 	return 0;
 }
-EXPORT_SYMBOL_GPL(nvme_keyring_init);
=20
-void nvme_keyring_exit(void)
+static void __exit nvme_keyring_exit(void)
 {
 	unregister_key_type(&nvme_tls_psk_key_type);
 	key_revoke(nvme_keyring);
 	key_put(nvme_keyring);
 }
-EXPORT_SYMBOL_GPL(nvme_keyring_exit);
=20
 MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Hannes Reinecke <hare@suse.de>");
+module_init(nvme_keyring_init);
+module_exit(nvme_keyring_exit);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 75a1b58a7a436..88b54cdcbd683 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -25,7 +25,6 @@
 #include "nvme.h"
 #include "fabrics.h"
 #include <linux/nvme-auth.h>
-#include <linux/nvme-keyring.h>
=20
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -4737,16 +4736,11 @@ static int __init nvme_core_init(void)
 		result =3D PTR_ERR(nvme_ns_chr_class);
 		goto unregister_generic_ns;
 	}
-	result =3D nvme_keyring_init();
-	if (result)
-		goto destroy_ns_chr;
 	result =3D nvme_init_auth();
 	if (result)
-		goto keyring_exit;
+		goto destroy_ns_chr;
 	return 0;
=20
-keyring_exit:
-	nvme_keyring_exit();
 destroy_ns_chr:
 	class_destroy(nvme_ns_chr_class);
 unregister_generic_ns:
@@ -4770,7 +4764,6 @@ static int __init nvme_core_init(void)
 static void __exit nvme_core_exit(void)
 {
 	nvme_exit_auth();
-	nvme_keyring_exit();
 	class_destroy(nvme_ns_chr_class);
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index 6cc0696625f36..e10333d78dbbe 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -12,8 +12,6 @@ key_serial_t nvme_tls_psk_default(struct key *keyring,
 		const char *hostnqn, const char *subnqn);
=20
 key_serial_t nvme_keyring_id(void);
-int nvme_keyring_init(void);
-void nvme_keyring_exit(void);
=20
 #else
=20
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
--=20
2.34.1


