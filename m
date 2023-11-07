Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CA9C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 18:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7bdVOwk21rGlnYlmcbf/g01eECC202fYkLfrKvn3ShQ=; b=fbjY7dX0MwWCCfl4RU8OMkXfHt
	1h+TzFrQXEq/1ZKAqp4RJ791r786RZ93axjggtmMlp48HIJle2x0ShQHNc+AR1hVweGeqN8d2kF3r
	hj4HVeSrbD0HeSBij0UbnejSgruusiP3oCS7PeQFHlz0CU52/NLQiWReAV3ZdruO5xmKmS0+J6n9i
	H/auoJJirwqM1yAsU8Go5jfmtv3dkl9vKjXuY8UdJ5+lekoIlGYvdy2kz4jmJTQxCd3q8WpsIsJzl
	BJdqDelaEHuGUTcINRgEmiOP0eHW8c4RdExUJoPXJkN+hnwgOC184TU7YdL1nuVMh34tnBF5eyXT6
	NLoFQYyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0QbS-002Aak-03;
	Tue, 07 Nov 2023 18:15:06 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0QbO-002AZq-2u
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 18:15:04 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3A7FwaBv004861
	for <linux-nvme@lists.infradead.org>; Tue, 7 Nov 2023 10:15:02 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=7bdVOwk21rGlnYlmcbf/g01eECC202fYkLfrKvn3ShQ=;
 b=JqAO5PKVm/a9F1Tae2UACB5JNHfehOAyXrBFbBcvL9zivAOhN0OBJWAJ9/4BMjyjfQms
 OmwsOruF+P8AVZPpC1bimnOaU5jXU0VTusWtstiKxUaDiE4V9fjNorqkLgU9nkid5TsC
 Wz6soHXvfg79LMQd0JPwF7xdkjyzzIEPmPIqp1hlWlYW/v5hryNpf7AXdV47+M0PhbYz
 6cIzAUlFJZTCy2BlS8sICN5eyQC7DNgx8Yuv2Joj/Rpqz0w7Jh9gEgUugqZ4q/lzYwAv
 UPxYewO8I7/PsS7bzmxLLpQ7qNZHryjKbN/GuYoM96uApqrUt+UuV8MZsIASDkFuCjXD Yg== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3u7a4a6qtg-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 07 Nov 2023 10:15:01 -0800
Received: from twshared5789.02.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 10:14:59 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id B07FA215360BB; Tue,  7 Nov 2023 10:14:43 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <hare@suse.de>, <rnd@arndb.de>,
        Arnd Bergmann
	<arnd@arndb.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 1/2] nvme: common: make keyring and auth separate modules
Date: Tue, 7 Nov 2023 10:14:20 -0800
Message-ID: <20231107181421.593353-2-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107181421.593353-1-kbusch@meta.com>
References: <20231107181421.593353-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: EsasV1YXA6ti-IjpxBdFIf1BzR_zcgN3
X-Proofpoint-GUID: EsasV1YXA6ti-IjpxBdFIf1BzR_zcgN3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_10,2023-11-07_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_101503_057925_8BD318B1 
X-CRM114-Status: GOOD (  17.30  )
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

ERROR: modpost: missing MODULE_LICENSE() in drivers/nvme/common/nvme-comm=
on.o

Address this by making both modules buildable standalone,
removing the now unnecessary CONFIG_NVME_COMMON symbol
in the process.

Also, now that NVME_KEYRING config symbol can be either a module or
built-in, the stubs need to check for '#if IS_ENABLED' rather than a
simple '#ifdef'.

Fixes: 9d77eb5277849 ("nvme-keyring: register '.nvme' keyring")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
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
index eedca8c720983..74f59ceed3d5a 100644
--- a/drivers/nvme/Makefile
+++ b/drivers/nvme/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
=20
-obj-$(CONFIG_NVME_COMMON)		+=3D common/
+obj-y		+=3D common/
 obj-y		+=3D host/
 obj-y		+=3D target/
diff --git a/drivers/nvme/common/Kconfig b/drivers/nvme/common/Kconfig
index 06c8df00d1e21..244432e0b73d8 100644
--- a/drivers/nvme/common/Kconfig
+++ b/drivers/nvme/common/Kconfig
@@ -1,14 +1,11 @@
 # SPDX-License-Identifier: GPL-2.0-only
=20
-config NVME_COMMON
-       tristate
-
 config NVME_KEYRING
-       bool
+       tristate
        select KEYS
=20
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
=20
 ccflags-y			+=3D -I$(src)
=20
-obj-$(CONFIG_NVME_COMMON)	+=3D nvme-common.o
+obj-$(CONFIG_NVME_AUTH)		+=3D nvme-auth.o
+obj-$(CONFIG_NVME_KEYRING)	+=3D nvme-keyring.o
=20
-nvme-common-$(CONFIG_NVME_AUTH)	+=3D auth.o
-nvme-common-$(CONFIG_NVME_KEYRING) +=3D keyring.o
+nvme-auth-y			+=3D auth.o
+nvme-keyring-y			+=3D keyring.o
diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.=
c
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
=20
-#ifdef CONFIG_NVME_KEYRING
+#if IS_ENABLED(CONFIG_NVME_KEYRING)
=20
 key_serial_t nvme_tls_psk_default(struct key *keyring,
 		const char *hostnqn, const char *subnqn);
--=20
2.34.1


