Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C58C61D97
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Nov 2023 22:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qsUVpK7HlOI/alQSigdp1G103zNHyTMbEL0zYM2mhEk=; b=rrTHRLrBnRHQB0A6VhEPDF4BV6
	H0Ec9+CcEqmEOwjKDk1mV/oSvUmNNLuBJZ+mA0tJSQSFWGcLjOYIDOhDQjPigV+SVxcE1tX2jRUUY
	MFctBN0+cItJFJBvOk8yFCPy8BW0zEibDoyWKMJsaPGrgvEi8TrGQiTDBXlAyoZW1ebaBYwLWNi6H
	016gcUIHAHZWvbkcO//PZuzoWWBL0OONow+lG7k/6cUhrWXetAXSxAdNw8lIinJL0l6r3cmKdMjm+
	Hj4PipgBPAT/uMQoS7E+2cQTAGhiAWuWPKpfkYVlNWC6IGqkQgVDiSNkId1B/2W5yexKdACsclWl8
	ikOxIoxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r5w0P-003Enp-2U;
	Wed, 22 Nov 2023 22:47:37 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r5w0M-003EmK-2t
	for linux-nvme@lists.infradead.org;
	Wed, 22 Nov 2023 22:47:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id C2243B829FA;
	Wed, 22 Nov 2023 22:47:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADF4C433CA;
	Wed, 22 Nov 2023 22:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700693251;
	bh=9ZYZZkr3I5hnymOVMd0KFdtSw5PNdjLQfrciVWD6egI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g0Ll4JW9tS/EGX5GtWauX3N3e0xBMe2+rvzFXjJizYae6g08d5AOtIUQdHAYH4r3j
	 miRPhXbgooUsZmqDaFwTIzizmKrjwCvSL6EsAjpWFXVaB1JOMlqq+Id82oY9eJWD79
	 MiyaP8PV6qFHRPchKcdC0wxoXcbOutpDU85RFFRiHVckcMqOZaR93oQj4+/8yGlhP/
	 HDiEzsRWpQZ3suv0Ed6pqdU8CJ6tn0lcmC5PBh3DKwbln5NrzA5wnGi0csKYTIHb9o
	 AouSbelHAd+ju3CJkgO7Tld8h5ecegxq5WwoxE/x5v3xY0Hfw3QAobcADR+4LearDf
	 Zy7uciJ+6VNwg==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-nvme@lists.infradead.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] nvme: target: fix Kconfig select statements
Date: Wed, 22 Nov 2023 23:47:18 +0100
Message-Id: <20231122224719.4042108-3-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231122224719.4042108-1-arnd@kernel.org>
References: <20231122224719.4042108-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231122_144735_079402_6EAF21F9 
X-CRM114-Status: GOOD (  15.35  )
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

When the NVME target code is built-in but its TCP frontend is a loadable
module, enabling keyring support causes a link failure:

x86_64-linux-ld: vmlinux.o: in function `nvmet_ports_make':
configfs.c:(.text+0x100a211): undefined reference to `nvme_keyring_id'

The problem is that CONFIG_NVME_TARGET_TCP_TLS is a 'bool' symbol that
depends on the tristate CONFIG_NVME_TARGET_TCP, so any 'select' from
it inherits the state of the tristate symbol rather than the intended
CONFIG_NVME_TARGET one that contains the actual call.

The same thing is true for CONFIG_KEYS, which itself is required for
NVME_KEYRING.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/nvme/target/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 31633da9427c..e1ebc73f3e5e 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -4,6 +4,8 @@ config NVME_TARGET
 	tristate "NVMe Target support"
 	depends on BLOCK
 	depends on CONFIGFS_FS
+	select NVME_KEYRING if NVME_TARGET_TCP_TLS
+	select KEYS if NVME_TARGET_TCP_TLS
 	select BLK_DEV_INTEGRITY_T10 if BLK_DEV_INTEGRITY
 	select SGL_ALLOC
 	help
@@ -87,9 +89,7 @@ config NVME_TARGET_TCP
 config NVME_TARGET_TCP_TLS
 	bool "NVMe over Fabrics TCP target TLS encryption support"
 	depends on NVME_TARGET_TCP
-	select NVME_KEYRING
 	select NET_HANDSHAKE
-	select KEYS
 	help
 	  Enables TLS encryption for the NVMe TCP target using the netlink handshake API.
 
-- 
2.39.2


