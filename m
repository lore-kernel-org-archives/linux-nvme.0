Return-Path: <SRS0=qSsZ=6M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2887C83000
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 13:13:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EA3E206A1
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 13:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="CSoPx/3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EA3E206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JDY1fj38SYQHXQx1fPwM3HhvBTUSIN4uBDspLVFwLOk=; b=CSoPx/3+hx8Dct
	l0JmKSRGek9v7AU2sL6/6r7c9Cg5VzCXRlEvWS9hzEr8HLTA8zuyxSgdp3yG1FMrf0FXDXkyn87nO
	gS1499HGWyGcOufA8kEeRhr7g5Q9h4ElmRJFWn5SeGp/KUevFa3VD1nc9RG5WK4k7l/IT3b0mOsnS
	ywNmrmyO+E5LJkV/0joKhNQsrxIbe1VC4aYg67KdDW+mW7iGi1ubJRtRwNMLckaxpGNiRRhiHvv4t
	6+MpKCo3rZ/PYY68nd/Vj29AchiQ4slCY1RmT77uOTHcn3WyW0cshNxPAFNuiBywYkacF6nwGGB/1
	kvVDoM2gyLrL+06iAOIg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jTQ3W-0004uU-95; Tue, 28 Apr 2020 13:13:46 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTQ1Y-0003I5-Uv
 for linux-nvme@lists.infradead.org; Tue, 28 Apr 2020 13:11:50 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 28 Apr 2020 16:11:37 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 03SDBZZ4028635;
 Tue, 28 Apr 2020 16:11:37 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: maxg@mellanox.com, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
 jsmart2021@gmail.com, axboe@kernel.dk
Subject: [PATCH 09/15] nvmet: add metadata characteristics for a namespace
Date: Tue, 28 Apr 2020 16:11:29 +0300
Message-Id: <20200428131135.211521-10-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200428131135.211521-1-maxg@mellanox.com>
References: <20200428131135.211521-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200428_061145_413995_E3233CA6 
X-CRM114-Status: UNSURE (   9.72  )
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
Cc: vladimirk@mellanox.com, shlomin@mellanox.com, israelr@mellanox.com,
 idanb@mellanox.com, oren@mellanox.com, nitzanc@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

Fill those namespace fields from the block device format for adding
metadata (T10-PI) over fabric support with block devices.

Signed-off-by: Israel Rukshin <israelr@mellanox.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 27 +++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h       |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 0427e04..b13d7b5 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -47,6 +47,28 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	id->nows = to0based(ql->io_opt / ql->logical_block_size);
 }
 
+#ifdef CONFIG_BLK_DEV_INTEGRITY
+static void nvmet_bdev_ns_enable_integrity(struct nvmet_ns *ns)
+{
+	struct blk_integrity *bi = bdev_get_integrity(ns->bdev);
+
+	if (bi) {
+		ns->metadata_size = bi->tuple_size;
+		if (bi->profile == &t10_pi_type1_crc)
+			ns->pi_type = NVME_NS_DPS_PI_TYPE1;
+		else if (bi->profile == &t10_pi_type3_crc)
+			ns->pi_type = NVME_NS_DPS_PI_TYPE3;
+		else
+			/* Unsupported metadata type */
+			ns->metadata_size = 0;
+	}
+}
+#else
+static void nvmet_bdev_ns_enable_integrity(struct nvmet_ns *ns)
+{
+}
+#endif /* CONFIG_BLK_DEV_INTEGRITY */
+
 int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 {
 	int ret;
@@ -64,6 +86,11 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 	}
 	ns->size = i_size_read(ns->bdev->bd_inode);
 	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
+
+	ns->pi_type = 0;
+	ns->metadata_size = 0;
+	nvmet_bdev_ns_enable_integrity(ns);
+
 	return 0;
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 3d981eb..b9fb57b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -19,6 +19,7 @@
 #include <linux/rcupdate.h>
 #include <linux/blkdev.h>
 #include <linux/radix-tree.h>
+#include <linux/t10-pi.h>
 
 #define NVMET_ASYNC_EVENTS		4
 #define NVMET_ERROR_LOG_SLOTS		128
@@ -77,6 +78,8 @@ struct nvmet_ns {
 
 	int			use_p2pmem;
 	struct pci_dev		*p2p_dev;
+	int			pi_type;
+	int			metadata_size;
 };
 
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
