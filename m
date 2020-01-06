Return-Path: <SRS0=Zaot=23=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F05C33C8C
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2020 13:39:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F312072E
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2020 13:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RG7KuXTG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F312072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SKbsoZsE7RVPhIV12om+oD4QXouA2P5mPvRxklabiio=; b=RG7KuXTGvondy3
	/GaOHv99+xmTRWIRvbqkKZSPaK/G5m3bYln7pM6t6feVf5jaK2Zmg9bF9gmhaAnnJ9exOZllkM1tc
	4nyLh/cWmjLyyL4F/4cyDZYGCDlk8IcVDzNuevouZfAx0d2VjgnX98xh/360V4IF5XUXLomtgyJ6Y
	e3tdC8bn0FWRwI7eHtqxpHfcrXIotQLQtVK42Zu1yqitWLh4goCmUPDp80VY/C5Xb4R7ACvg23vGR
	i8w1y2K6YId5v0xfkQasRO1FPaqLMt7Le4HbXKedvm3u5DQ6BYtRSOxxRGZj1jWpASOeXz3ectj7M
	4Vrc9jHzKu9ebDi6g7tA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ioSbZ-0007FF-Ih; Mon, 06 Jan 2020 13:39:37 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ioSZp-0005aP-Kc
 for linux-nvme@lists.infradead.org; Mon, 06 Jan 2020 13:37:56 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 6 Jan 2020 15:37:38 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 006DbaFK029740;
 Mon, 6 Jan 2020 15:37:37 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, martin.petersen@oracle.com
Subject: [PATCH 09/15] nvmet: Add metadata characteristics for a namespace
Date: Mon,  6 Jan 2020 15:37:30 +0200
Message-Id: <20200106133736.123038-11-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200106133736.123038-1-maxg@mellanox.com>
References: <20200106133736.123038-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200106_053750_142434_4A443E57 
X-CRM114-Status: UNSURE (   9.97  )
X-CRM114-Notice: Please train this message.
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
Cc: axboe@kernel.dk, vladimirk@mellanox.com, shlomin@mellanox.com,
 israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com, maxg@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

Fill those namespace fields from the block device format for adding
metadata (T10-PI) over fabric support with block devices.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 22 ++++++++++++++++++++++
 drivers/nvme/target/nvmet.h       |  3 +++
 2 files changed, 25 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index b6fca0e..fb40022 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -50,6 +50,9 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 {
 	int ret;
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	struct blk_integrity *bi;
+#endif
 
 	ns->bdev = blkdev_get_by_path(ns->device_path,
 			FMODE_READ | FMODE_WRITE, NULL);
@@ -64,6 +67,25 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 	}
 	ns->size = i_size_read(ns->bdev->bd_inode);
 	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
+
+	ns->prot_type = 0;
+	ns->ms = 0;
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+	bi = bdev_get_integrity(ns->bdev);
+	if (bi) {
+		ns->ms = bi->tuple_size;
+		if (bi->profile == &t10_pi_type1_crc)
+			ns->prot_type = NVME_NS_DPS_PI_TYPE1;
+		else if (bi->profile == &t10_pi_type3_crc)
+			ns->prot_type = NVME_NS_DPS_PI_TYPE3;
+		else
+			/* Unsupported metadata type */
+			ns->ms = 0;
+	}
+
+	pr_debug("ms %d pi_type %d\n", ns->ms, ns->prot_type);
+#endif
+
 	return 0;
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 60011f3..89e0174 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -19,6 +19,7 @@
 #include <linux/rcupdate.h>
 #include <linux/blkdev.h>
 #include <linux/radix-tree.h>
+#include <linux/t10-pi.h>
 
 #define NVMET_ASYNC_EVENTS		4
 #define NVMET_ERROR_LOG_SLOTS		128
@@ -76,6 +77,8 @@ struct nvmet_ns {
 
 	int			use_p2pmem;
 	struct pci_dev		*p2p_dev;
+	int			prot_type;
+	int			ms;
 };
 
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
