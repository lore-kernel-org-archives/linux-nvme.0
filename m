Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0223CC4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Nov 2023 04:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pn8bVRWgc1IEKZ+kqp12XPWGp5BdNhv/nVZfqrOEwQc=; b=Svp7WU/i5+wSxypGo7oxcpdHki
	Q3g1dk8NtP1rSsD25T+mqgDYGXM3Jj9nqqnWzFXBG8XctQxyeMKrkxQKiZM3S8LvKoxngr2JIAMJ7
	J7sBVbJmcPW7wENCYdcp8RkaF+eBuaURPa4ZZYqtYB1UISmHZaA5KEWNkQ5RlU3SohTJmLds4WUc/
	NlIdWD+/Q9teVLQcK0J552NEuWDoFaiPaJ+AI9/xGgCHmxh7X9o0b8xkSt5OmQ7hLED3L5KX3plzL
	6tVs3J7OhTqSABCGD0GUTpJakASexI1wLWK/HfmgSsNTpf2ra6P4e/ZHJqriq5bAgSTYoD0rReyPk
	lfjiuZ1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r8CWS-0073Jc-1Y;
	Wed, 29 Nov 2023 04:50:04 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r8CWP-0073Iy-1f
	for linux-nvme@lists.infradead.org;
	Wed, 29 Nov 2023 04:50:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1701233402; x=1732769402;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=u8gKFMK6rNrSpsrlCQWFOzXV07XXeccFQKI9wIynHp0=;
  b=RFnvgrWCxM+gEb5yY6rFFfcA524pT4MlirBdkLkRX1dBPrn67EkGaEZD
   cGsfkd71Ja9N6+Ll+UG64xar/wjNPGxc2LtxsIqwGesdX1qq2jOZAzqIu
   1EIiEMc3RRuO0G/Vt5RA0EsFalgbEGH+HMfgYNI29i/CXMhhqG6GpdxGH
   +F6Zo+Nim5aNibMf7rIVfc2VX9XiVekFewGJCvrMNeFbXy9k3PzR7LP1o
   KHJgHKv1Vx3d136rI8uKRuaKAaP5ktdw3gWWf2GiNouP5KbvDw+OOSJbT
   hXPjT3wUbd0N/8BqYf8ncpaN7AKhD8GVWSv4C4f3SDaSUdSsc7NDZxXE/
   g==;
X-CSE-ConnectionGUID: NHEsEAgQTbmwfJXssCwxeA==
X-CSE-MsgGUID: 1dA5uKeRSe+gV3DCOXxPbA==
X-IronPort-AV: E=Sophos;i="6.04,234,1695657600"; 
   d="scan'208";a="3729058"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 29 Nov 2023 12:49:53 +0800
IronPort-SDR: HZOaABRuNo2DAPio6tHlAJ4Y1qN1BdM4cyPKYpCSNyaH3dO9ZzGSGCxgHPEpZllItnP4Gbd917
 0TymBCO0+wmg==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Nov 2023 19:55:22 -0800
IronPort-SDR: od9YXuBIqsHpYnbznTfp2rX1pamDTqlaXwNOXXhpOGlW/K0tnOUvwwpDjeMZ2HNNwlHqdJPpAK
 qlNTr7M6rDBA==
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.53.55])
  by uls-op-cesaip02.wdc.com with ESMTP; 28 Nov 2023 20:49:52 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] nvme: improve NVME_HOST_AUTH and NVME_TARGET_AUTH config descriptions
Date: Wed, 29 Nov 2023 13:49:51 +0900
Message-ID: <20231129044951.610759-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231128_205001_573886_F2FD358F 
X-CRM114-Status: UNSURE (   9.72  )
X-CRM114-Notice: Please train this message.
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

Currently two similar config options NVME_HOST_AUTH and NVME_TARGET_AUTH
have almost same descriptions. It is confusing to choose them in
menuconfig. Improve the descriptions to distinguish them.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/host/Kconfig   | 5 +++--
 drivers/nvme/target/Kconfig | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 8fe2dd619e80..b309c8be720f 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -107,11 +107,12 @@ config NVME_TCP_TLS
 	  If unsure, say N.
 
 config NVME_HOST_AUTH
-	bool "NVM Express over Fabrics In-Band Authentication"
+	bool "NVMe over Fabrics In-Band Authentication in host side"
 	depends on NVME_CORE
 	select NVME_AUTH
 	help
-	  This provides support for NVMe over Fabrics In-Band Authentication.
+	  This provides support for NVMe over Fabrics In-Band Authentication in
+	  host side.
 
 	  If unsure, say N.
 
diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index e1ebc73f3e5e..872dd1a0acd8 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -99,10 +99,11 @@ config NVME_TARGET_TCP_TLS
 	  If unsure, say N.
 
 config NVME_TARGET_AUTH
-	bool "NVMe over Fabrics In-band Authentication support"
+	bool "NVMe over Fabrics In-band Authentication in target side"
 	depends on NVME_TARGET
 	select NVME_AUTH
 	help
-	  This enables support for NVMe over Fabrics In-band Authentication
+	  This enables support for NVMe over Fabrics In-band Authentication in
+	  target side.
 
 	  If unsure, say N.
-- 
2.43.0


