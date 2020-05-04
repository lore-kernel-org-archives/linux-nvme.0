Return-Path: <SRS0=qmg+=6S=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF2CC3A5A9
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2020 16:01:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 274E7206D9
	for <linux-nvme@archiver.kernel.org>; Mon,  4 May 2020 16:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m6pkPmRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 274E7206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L85nHCF2imEE4KiXZI5DvPpo1sGFnj+2ph2Ox5FoQ1k=; b=m6pkPmRSon1CeW
	ROeZ4eCt2itWu/jTwnVOVN62C2s6CbAsef2GEWh6VPevU57rULHnk5R3QsEUiNt8bqt74k6KQltuL
	E9WYb+lgDwloFOWs8aO0zokrdLwoAZGm+2sZkZX7lMoQeCFsXu7NXCws/rcvHa3JiVgFhTk6q8lTR
	H4mgadPwYfI9fHTAf8bXV++TZijcFVDICZs2KNJ60GX5jsEXQ2mmrWrt7zvXwiYw2RiTSK8g8oJFY
	tn3qg1uliXH1ZZJtfHO+YrKAq6h/+/z8hOgwbo39YEDyiaGmfbSasiYLKGoY6EFFbx7rFIvmUfhtC
	Fwc4T0yyU7rEL6UCxwXA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jVdWx-0006zU-At; Mon, 04 May 2020 16:01:19 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jVdTs-00011n-Hh
 for linux-nvme@lists.infradead.org; Mon, 04 May 2020 15:58:13 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 4 May 2020 18:57:56 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 044FvtCH017882;
 Mon, 4 May 2020 18:57:55 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: maxg@mellanox.com, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
 jsmart2021@gmail.com, axboe@kernel.dk
Subject: [PATCH 05/16] nvme: introduce max_integrity_segments ctrl attribute
Date: Mon,  4 May 2020 18:57:44 +0300
Message-Id: <20200504155755.221125-6-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200504155755.221125-1-maxg@mellanox.com>
References: <20200504155755.221125-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200504_085808_984520_E4881C8B 
X-CRM114-Status: GOOD (  10.44  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: vladimirk@mellanox.com, shlomin@mellanox.com, israelr@mellanox.com,
 idanb@mellanox.com, oren@mellanox.com, nitzanc@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch doesn't change any logic, and is needed as a preparation
for adding PI support for fabrics drivers that will use an extended
LBA format for metadata and will support more than 1 integrity segment.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 11 +++++++----
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  |  6 ++++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 94d2549..89b1bfcb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1690,7 +1690,8 @@ static int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
+static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
+				u32 max_integrity_segments)
 {
 	struct blk_integrity integrity;
 
@@ -1713,10 +1714,11 @@ static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
 	}
 	integrity.tuple_size = ms;
 	blk_integrity_register(disk, &integrity);
-	blk_queue_max_integrity_segments(disk->queue, 1);
+	blk_queue_max_integrity_segments(disk->queue, max_integrity_segments);
 }
 #else
-static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
+static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type,
+				u32 max_integrity_segments)
 {
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
@@ -1892,7 +1894,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	if (ns->ms) {
 		if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
 		    (ns->features & NVME_NS_METADATA_SUPPORTED))
-			nvme_init_integrity(disk, ns->ms, ns->pi_type);
+			nvme_init_integrity(disk, ns->ms, ns->pi_type,
+					    ns->ctrl->max_integrity_segments);
 		else if (!nvme_ns_has_pi(ns))
 			capacity = 0;
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0f5fa85..6c7e76c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -229,6 +229,7 @@ struct nvme_ctrl {
 	u32 page_size;
 	u32 max_hw_sectors;
 	u32 max_segments;
+	u32 max_integrity_segments;
 	u16 crdt[3];
 	u16 oncs;
 	u16 oacs;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index eef5d6a..a9b124a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2539,6 +2539,12 @@ static void nvme_reset_work(struct work_struct *work)
 		goto out;
 	}
 
+	/*
+	 * We do not support an SGL for metadata (yet), so we are limited to a
+	 * single integrity segment for the separate metadata pointer.
+	 */
+	dev->ctrl.max_integrity_segments = 1;
+
 	result = nvme_init_identify(&dev->ctrl);
 	if (result)
 		goto out;
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
