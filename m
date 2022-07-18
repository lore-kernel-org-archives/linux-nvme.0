Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBC2C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Jul 2022 05:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=k3xOlL92K/byy7M5B7fjAUth3BXP9CZH7QZzC2u8WH4=; b=f0KJddrp3GYCL4UoU4REnjpLyC
	O8pIBChNovHK9Hm+TuoL9fvTgzwLK67LPAJilqAHOXl8VRkc3cEJc8+3582TNHnkbmOw2B/k/5K8X
	0IK72xIKSa9cTwQrDgUNRU+gfD/6ORB2YTVe51rUSrzW1gGIzHepM8NWyaWTuX3lQzpEzuRTefkhn
	25yzsVC4kVFbfA+iaiSG0AHHzoYj9lERXPhWc+iugLp+V0dPIQu6r81Eqd2Le+FXAuom8f4QfY6Jg
	hfGGMCusSgSaxUBcvPcaUX++P0CTCQ4fIAqQ5fZSEPM/27tHGTV69C3WsMuHXbB6ZCEaL9+8TQ7nn
	ZVws/L4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDJ3w-00B0R3-In; Mon, 18 Jul 2022 05:12:56 +0000
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oDJ3u-00B0QO-Uo; Mon, 18 Jul 2022 05:12:55 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Cc: sagi@grimberg.me,
	kbusch@kernel.org
Subject: [PATCH] nvme: don't always build constants.o
Date: Mon, 18 Jul 2022 07:12:52 +0200
Message-Id: <20220718051252.231757-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The entire content of constants.c if guarded by an ifdef, so switch to
just building the file conditionally instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/Makefile    | 3 ++-
 drivers/nvme/host/constants.c | 2 --
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index a3e88f32f560b..e27202d22c7d9 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -10,7 +10,8 @@ obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
 obj-$(CONFIG_NVME_APPLE)		+= nvme-apple.o
 
-nvme-core-y				:= core.o ioctl.o constants.o
+nvme-core-y				+= core.o ioctl.o
+nvme-core-$(CONFIG_NVME_VERBOSE_ERRORS)	+= constants.o
 nvme-core-$(CONFIG_TRACING)		+= trace.o
 nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
 nvme-core-$(CONFIG_BLK_DEV_ZONED)	+= zns.o
diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index 4910543f00ff9..6973c2a17c13d 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -6,7 +6,6 @@
 
 #include "nvme.h"
 
-#ifdef CONFIG_NVME_VERBOSE_ERRORS
 static const char * const nvme_ops[] = {
 	[nvme_cmd_flush] = "Flush",
 	[nvme_cmd_write] = "Write",
@@ -185,4 +184,3 @@ const unsigned char *nvme_get_admin_opcode_str(u8 opcode)
 		return nvme_admin_ops[opcode];
 	return "Unknown";
 }
-#endif /* CONFIG_NVME_VERBOSE_ERRORS */
-- 
2.30.2


