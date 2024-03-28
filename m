Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 863FCC47DD9
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 00:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1rMl8FO7hDeOUrcOO8UYibThHiMpNwM1pX5IIQ85pHw=; b=yFCyMcNOMThj+ReZtT+/QHrWMu
	TnVYTNwM1w91RmfWpwdiIWDdodWLbW3iP7bFZh+zbMMqa+cr71pcJw3PRrnlqkj5i8KiFjoCsALIk
	7wo4y93kBLrIBh+jIyZfDdhuE17xb0wNlp0yo2FOB/ul6CoYwRO4lhj6uXBvSnpNPu31S4WkLKwdx
	l5FoGEn3E5aHsaU0qgd7tAGfVBTaoIa43W+t7Xi0ejkXBThnsEucPNUU35QmLH/kPEJyUbuUo459t
	px4VVhA5lRbw7ClYaufxNn16fCAEMjYOKe2rQhOTX1aEKnVTSn+HjAj31qKE9VbMBTSsXWJSnnK6j
	QL5ilhOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpduO-0000000Boge-2SZP;
	Thu, 28 Mar 2024 00:46:20 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdt5-0000000BnlM-1gP3
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 00:45:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 6146CCE1857;
	Thu, 28 Mar 2024 00:44:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780E0C433F1;
	Thu, 28 Mar 2024 00:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711586696;
	bh=9lGN8HcNOfcmbC48TC0lGJlJVU3243wN0wEL2maXvro=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=eQW0wRqTYhthe7X1QaVsV10f/zuKfjkMbB+lLmCKM0P9gcPJFRog5GEp25reBW1qH
	 8m7++H+O6fHNn+N0wX+DnT2injPsJ1cK+HYAsWqI3DBN1ukXuOrVCTzoWNhZ6/Oqdn
	 JTp9/Ykxpgbrh8poPi0JGml6xFLMjsX6QKvbFU7w/KSAsX1i+zFfBQ/qoCxVt5Mx/8
	 cox5zko3NcyvdjDgZQmQl+pScX7k0u8ohjx/6Bm5+wrPxifLZhuU5+ll7qmKhMX5Qz
	 hYVqAR/OQtqlDskAiV0UcmbwggWKR3j67k1K4S+blHCUL4gXd7sTbOwAzC6VDydHDh
	 vYBdrT/nkyzug==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 26/30] block: Move zone related debugfs attribute to blk-zoned.c
Date: Thu, 28 Mar 2024 09:44:05 +0900
Message-ID: <20240328004409.594888-27-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328004409.594888-1-dlemoal@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240327_174500_506968_6B13A61D 
X-CRM114-Status: GOOD (  18.56  )
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

block/blk-mq-debugfs-zone.c contains a single debugfs attribute
function. Defining this outside of block/blk-zoned.c does not really
help in any way, so move this zone related debugfs attribute to
block/blk-zoned.c and delete block/blk-mq-debugfs-zone.c.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/Kconfig                |  4 ----
 block/Makefile               |  1 -
 block/blk-mq-debugfs-zoned.c | 22 ----------------------
 block/blk-mq-debugfs.h       |  2 +-
 block/blk-zoned.c            | 20 ++++++++++++++++++++
 5 files changed, 21 insertions(+), 28 deletions(-)
 delete mode 100644 block/blk-mq-debugfs-zoned.c

diff --git a/block/Kconfig b/block/Kconfig
index 1de4682d48cc..9f647149fbee 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -198,10 +198,6 @@ config BLK_DEBUG_FS
 	Unless you are building a kernel for a tiny system, you should
 	say Y here.
 
-config BLK_DEBUG_FS_ZONED
-       bool
-       default BLK_DEBUG_FS && BLK_DEV_ZONED
-
 config BLK_SED_OPAL
 	bool "Logic for interfacing with Opal enabled SEDs"
 	depends on KEYS
diff --git a/block/Makefile b/block/Makefile
index 46ada9dc8bbf..168150b9c510 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -33,7 +33,6 @@ obj-$(CONFIG_BLK_MQ_VIRTIO)	+= blk-mq-virtio.o
 obj-$(CONFIG_BLK_DEV_ZONED)	+= blk-zoned.o
 obj-$(CONFIG_BLK_WBT)		+= blk-wbt.o
 obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
-obj-$(CONFIG_BLK_DEBUG_FS_ZONED)+= blk-mq-debugfs-zoned.o
 obj-$(CONFIG_BLK_SED_OPAL)	+= sed-opal.o
 obj-$(CONFIG_BLK_PM)		+= blk-pm.o
 obj-$(CONFIG_BLK_INLINE_ENCRYPTION)	+= blk-crypto.o blk-crypto-profile.o \
diff --git a/block/blk-mq-debugfs-zoned.c b/block/blk-mq-debugfs-zoned.c
deleted file mode 100644
index a77b099c34b7..000000000000
--- a/block/blk-mq-debugfs-zoned.c
+++ /dev/null
@@ -1,22 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (C) 2017 Western Digital Corporation or its affiliates.
- */
-
-#include <linux/blkdev.h>
-#include "blk-mq-debugfs.h"
-
-int queue_zone_wlock_show(void *data, struct seq_file *m)
-{
-	struct request_queue *q = data;
-	unsigned int i;
-
-	if (!q->disk->seq_zones_wlock)
-		return 0;
-
-	for (i = 0; i < q->disk->nr_zones; i++)
-		if (test_bit(i, q->disk->seq_zones_wlock))
-			seq_printf(m, "%u\n", i);
-
-	return 0;
-}
diff --git a/block/blk-mq-debugfs.h b/block/blk-mq-debugfs.h
index 9c7d4b6117d4..3ebe2c29b624 100644
--- a/block/blk-mq-debugfs.h
+++ b/block/blk-mq-debugfs.h
@@ -83,7 +83,7 @@ static inline void blk_mq_debugfs_unregister_rqos(struct rq_qos *rqos)
 }
 #endif
 
-#ifdef CONFIG_BLK_DEBUG_FS_ZONED
+#if defined(CONFIG_BLK_DEV_ZONED) && defined(CONFIG_BLK_DEBUG_FS)
 int queue_zone_wlock_show(void *data, struct seq_file *m);
 #else
 static inline int queue_zone_wlock_show(void *data, struct seq_file *m)
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index d0549b85f281..93aa994824d1 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -22,6 +22,7 @@
 
 #include "blk.h"
 #include "blk-mq-sched.h"
+#include "blk-mq-debugfs.h"
 
 #define ZONE_COND_NAME(name) [BLK_ZONE_COND_##name] = #name
 static const char *const zone_cond_name[] = {
@@ -1890,3 +1891,22 @@ int blk_revalidate_disk_zones(struct gendisk *disk)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);
+
+#ifdef CONFIG_BLK_DEBUG_FS
+
+int queue_zone_wlock_show(void *data, struct seq_file *m)
+{
+	struct request_queue *q = data;
+	unsigned int i;
+
+	if (!q->disk->seq_zones_wlock)
+		return 0;
+
+	for (i = 0; i < q->disk->nr_zones; i++)
+		if (test_bit(i, q->disk->seq_zones_wlock))
+			seq_printf(m, "%u\n", i);
+
+	return 0;
+}
+
+#endif
-- 
2.44.0


