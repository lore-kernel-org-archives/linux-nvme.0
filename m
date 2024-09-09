Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82205ECE588
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2024 20:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=R+Cv99Y/TQzMluhmR4PHWHrc4kGIetUYv4cZgBIkvSc=; b=IxB7mcPc207KrYp+E/G007/qyf
	Pim0ADDL4gJqYJmAC+W7+YRlIMAjKzBZddWlxBCQ/UIUht0FVAFWsMAkWWnBXotlFKioX/sGiaWzY
	iTGO419QDq+ZfnuxLOXeMhxzBIglpwkitNkm6NGUfBrDYWOS2drai+LHYi9AQbMdeWcOXZnUkothL
	eFWVXWyPnllnUR3zzh7vIsb5v6NQkd78FGSZNv//phD92BOLQI0NVlrFdD/ZfsnerPdhQLRp3TJN8
	GHBefWknytn0wwnXmVLnn8kAeeU9IJGlKn5DTkZrp0H6RFMi0TC5uf18pErW9kiUU9TFda1W5XZzr
	dw3+Hxzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snktS-00000003DD7-1Sqf;
	Mon, 09 Sep 2024 20:21:50 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snkt4-00000003D9G-07mZ
	for linux-nvme@lists.infradead.org;
	Mon, 09 Sep 2024 20:21:27 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E55035C05E6;
	Mon,  9 Sep 2024 20:21:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6406C4CEC5;
	Mon,  9 Sep 2024 20:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725913284;
	bh=XacvQmLHyej2ATwCXc/vBK/JKb6SROxDmmREBXVWFbQ=;
	h=From:To:Cc:Subject:Date:From;
	b=P0PhXY9yvs/DbpLEGQztlMariq5JE01WSDTNdfTRHbCi09JYGgmgUV+KiSkW3Ymuj
	 YJTLyAL3IKjsQtFeE/4YZpH+7AnQfHFr1vLx2yky5BK/Hvnv0JuDe5pG/xSwY5KgWm
	 8Yhi6QuFtV/DiJUhdNgCURJOYues4ftXSFXF7iSOXwarC/4sv2juJfPhQ+XqrrOwi1
	 riOEJYQbiReqmbrURI1LIPpKowlSj1Un1JTjqXUBIkPIvNQwImZ43a38t4mxgNZOnr
	 ea1VLXaU6qDdpGIkaf8LpujjgPNVso11LlHlY7vyiEQQwkrUKpTtt4F9j+vCVl9xN2
	 Rr0ijI7BviNFQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Kanchan Joshi <joshi.k@samsung.com>,
	"Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-tcp: fix link failure for TCP auth
Date: Mon,  9 Sep 2024 20:21:09 +0000
Message-Id: <20240909202118.811697-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_132126_352678_D1D5374B 
X-CRM114-Status: GOOD (  15.94  )
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

The nvme fabric driver calls the nvme_tls_key_lookup() function from
nvmf_parse_key() when the keyring is enabled, but this is broken in a
configuration with CONFIG_NVME_FABRICS=y and CONFIG_NVME_TCP=m because
this leads to the function definition being in a loadable module:

x86_64-linux-ld: vmlinux.o: in function `nvmf_parse_key':
fabrics.c:(.text+0xb1bdec): undefined reference to `nvme_tls_key_lookup'

Move the 'select' up to CONFIG_NVME_FABRICS itself to force this
part to be built-in as well if needed.

Fixes: 5bc46b49c828 ("nvme-tcp: check for invalidated or revoked key")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
It may alternatively be possible to rework the code so the
keyring is only referenced when CONFIG_NVME_HOST_AUTH is also
set, but this version is simpler and leaves the code unchanged.
---
 drivers/nvme/host/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 883aaab2d83e..486afe598184 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -41,6 +41,7 @@ config NVME_HWMON
 
 config NVME_FABRICS
 	select NVME_CORE
+	select NVME_KEYRING if NVME_TCP_TLS
 	tristate
 
 config NVME_RDMA
@@ -94,7 +95,6 @@ config NVME_TCP
 config NVME_TCP_TLS
 	bool "NVMe over Fabrics TCP TLS encryption support"
 	depends on NVME_TCP
-	select NVME_KEYRING
 	select NET_HANDSHAKE
 	select KEYS
 	help
-- 
2.39.2


