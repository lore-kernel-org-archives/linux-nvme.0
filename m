Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98933C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jul 2022 05:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G26XSGzzaOPTteu0zgTIiU6t6G0Rbjf3WpD5Ljt25ok=; b=UUOZUajJUu/sADqLsle116L5MD
	yHnUFuX3oyTmlQpYcqiRk772K5Oq4k6JNiyUDKbJZHXJyv10T89nQuIWidF8tD1778vV/EIsODGhy
	riZ/qWDUz5meynsicVspi/00a1Yasvm538EHlW6IBbygdcrNgksrhI2D9sSlxMzhSMnLLTpTheela
	55FdxOOOdf+urt9nr4w0XlDwJpT3ZospY4Po7B9AE9DBsvK7mAWeUEsm76gjcEgx+rlnDJblojaDO
	nOT6XVdHueukvUthHz3iM1fgOuz/8MFy15QAPh1mZAm9gRKBLHpxQx4oQAghOGcSF8wHAEncIpvRs
	8HbVuYGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBVFh-000LHM-1G; Wed, 13 Jul 2022 05:49:37 +0000
Received: from ip4d15c27d.dynamic.kabel-deutschland.de ([77.21.194.125] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBVFZ-000LAy-PM; Wed, 13 Jul 2022 05:49:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joel Granados <j.granados@samsung.com>,
	kbusch@kernel.org,
	sagi@grimberg.me
Cc: joshi.k@samsung.com,
	linux-nvme@lists.infradead.org,
	gost.dev@samsung.com,
	k.jensen@samsung.com
Subject: [PATCH 4/5] nvme: factor out a nvme_ns_is_readonly helper
Date: Wed, 13 Jul 2022 07:49:13 +0200
Message-Id: <20220713054914.1888305-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220713054914.1888305-1-hch@lst.de>
References: <20220713054914.1888305-1-hch@lst.de>
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

Add a little helper to check if a namespace should be marked read-only
that uses a new is_readonly flag in the nvme_ns_info structure.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 659068f90165c..dca7580f785a8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -36,6 +36,7 @@ struct nvme_ns_info {
 	u32 nsid;
 	__le32 anagrpid;
 	bool is_shared;
+	bool is_readonly;
 	bool is_ready;
 };
 
@@ -1447,6 +1448,7 @@ static int nvme_ns_info_from_identify(struct nvme_ctrl *ctrl,
 		return ret;
 	info->anagrpid = id->anagrpid;
 	info->is_shared = id->nmic & NVME_NS_NMIC_SHARED;
+	info->is_readonly = id->nsattr & NVME_NS_ATTR_RO;
 	info->is_ready = true;
 	if (ctrl->quirks & NVME_QUIRK_BOGUS_NID) {
 		dev_info(ctrl->device,
@@ -1482,6 +1484,7 @@ static int nvme_ns_info_from_id_cs_indep(struct nvme_ctrl *ctrl,
 	if (!ret) {
 		info->anagrpid = id->anagrpid;
 		info->is_shared = id->nmic & NVME_NS_NMIC_SHARED;
+		info->is_readonly = id->nsattr & NVME_NS_ATTR_RO;
 		info->is_ready = id->nstat & NVME_NSTAT_NRDY;
 	}
 	kfree(id);
@@ -1909,6 +1912,11 @@ static void nvme_update_disk_info(struct gendisk *disk,
 					   ns->ctrl->max_zeroes_sectors);
 }
 
+static bool nvme_ns_is_readonly(struct nvme_ns *ns, struct nvme_ns_info *info)
+{
+	return info->is_readonly || test_bit(NVME_NS_FORCE_RO, &ns->flags);
+}
+
 static inline bool nvme_first_scan(struct gendisk *disk)
 {
 	/* nvme_alloc_ns() scans the disk prior to adding it */
@@ -1972,8 +1980,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 			goto out_unfreeze;
 	}
 
-	set_disk_ro(ns->disk, (id->nsattr & NVME_NS_ATTR_RO) ||
-		test_bit(NVME_NS_FORCE_RO, &ns->flags));
+	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
 	set_bit(NVME_NS_READY, &ns->flags);
 	blk_mq_unfreeze_queue(ns->disk->queue);
 
@@ -1986,9 +1993,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (nvme_ns_head_multipath(ns->head)) {
 		blk_mq_freeze_queue(ns->head->disk->queue);
 		nvme_update_disk_info(ns->head->disk, ns, id);
-		set_disk_ro(ns->head->disk,
-			    (id->nsattr & NVME_NS_ATTR_RO) ||
-				    test_bit(NVME_NS_FORCE_RO, &ns->flags));
+		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
 		nvme_mpath_revalidate_paths(ns);
 		blk_stack_limits(&ns->head->disk->queue->limits,
 				 &ns->queue->limits, 0);
-- 
2.30.2


