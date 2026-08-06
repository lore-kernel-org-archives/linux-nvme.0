Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 865E5C55174
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 02:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bKy4c1zZaaLWeS2EwWLKSw1SEKL67SiFpj9TEYQnyU4=; b=BLfbxTI+89pv116kZG3QGcFfoV
	zIg6hJ9AhcJED2g7dVUZ8NgAYUJL86TDyzzf5My2orsYGf/f3vXN+MObAxcYrskDL3ylTCFgQJwxw
	0zlJjF3nweFZ+IKsh/Ercd0cGyY/T9RMG/d4jUN6uSOE822oYB+TSrWUu/mWbIXn7LXTa8p7A3Eaa
	4zMIESLX/efvNsvb9T7gSYVC985OLPx7utmMpfQPhcf0dL03GvTifTtueZbqCMLjZcmdEiOx0BK9k
	gJTSxh3XSQUnKYTojsarAlzlzxY47eAZloMOwZs4/udhoyaoPnDo9JIniJbI3ZVoJkO5cHBzzd5eC
	SdFmBkfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wro95-00000004q0L-0IW5;
	Thu, 06 Aug 2026 02:47:47 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wro92-00000004pyy-3E0T
	for linux-nvme@lists.infradead.org;
	Thu, 06 Aug 2026 02:47:46 +0000
X-UUID: 2cfa1882914111f1aa26b74ffac11d73-20260806
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a027dfa6-c262-417c-8cce-16ecc6c87673,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:a027dfa6-c262-417c-8cce-16ecc6c87673,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:c03467de46b45fe85e373a49bfd9b583,BulkI
	D:260806104738XNN5D7JN,BulkQuantity:0,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|136|850|865|898,TC:nil,Content:0|15|50,EDM:-3|-100,IP:-2,URL:0,File:nil
	,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,
	DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2cfa1882914111f1aa26b74ffac11d73-20260806
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 866893979; Thu, 06 Aug 2026 10:47:33 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v2 1/4] nvme: factor namespace-head queue-limit update
Date: Thu,  6 Aug 2026 10:46:55 +0800
Message-Id: <20260806024658.4193386-2-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260806024658.4193386-1-sangyao@kylinos.cn>
References: <20260806024658.4193386-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_194745_116131_03435B29 
X-CRM114-Status: GOOD (  19.21  )
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

Move the namespace head queue-limit update out of nvme_update_ns_info().
The new helper keeps the current queue_limits_stack_bdev() based behavior
intact, including zoned resource handling, write-stream assignment,
integrity setup, capacity and readonly updates, path revalidation, and
namespace-head zone revalidation.

Keep queue-limit commit failures on the existing short-circuit path so
capacity and namespace-head state are only updated after a successful
limits update.

The helper gives namespace-head queue-limit updates a single NVMe-local
entry point while keeping the namespace information refresh sequencing
unchanged.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 drivers/nvme/host/core.c | 104 +++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 48 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cb93ada4376a..e3d27c0440db 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2528,6 +2528,60 @@ static void nvme_stack_zone_resources(struct queue_limits *t,
 		min_not_zero(t->max_active_zones, b->max_active_zones);
 }
 
+static int nvme_update_ns_head_limits(struct nvme_ns *ns,
+		struct nvme_ns_info *info, bool unsupported)
+{
+	struct queue_limits *ns_lim = &ns->disk->queue->limits;
+	struct request_queue *head_q = ns->head->disk->queue;
+	struct queue_limits lim;
+	unsigned int memflags;
+	int ret;
+
+	lim = queue_limits_start_update(head_q);
+	memflags = blk_mq_freeze_queue(head_q);
+	/*
+	 * queue_limits mixes values that are the hardware limitations
+	 * for bio splitting with what is the device configuration.
+	 *
+	 * For NVMe the device configuration can change after e.g. a
+	 * Format command, and we really want to pick up the new format
+	 * value here. But we must still stack the queue limits to the
+	 * least common denominator for multipathing to split the bios
+	 * properly.
+	 *
+	 * To work around this, we explicitly set the device
+	 * configuration to those that we just queried, but only stack
+	 * the splitting limits in to make sure we still obey possibly
+	 * lower limitations of other controllers.
+	 */
+	lim.logical_block_size = ns_lim->logical_block_size;
+	lim.physical_block_size = ns_lim->physical_block_size;
+	lim.io_min = ns_lim->io_min;
+	lim.io_opt = ns_lim->io_opt;
+	queue_limits_stack_bdev(&lim, ns->disk->part0, 0,
+				ns->head->disk->disk_name);
+	if (lim.features & BLK_FEAT_ZONED)
+		nvme_stack_zone_resources(&lim, ns_lim);
+	if (unsupported)
+		ns->head->disk->flags |= GENHD_FL_HIDDEN;
+	else
+		nvme_init_integrity(ns->head, &lim, info);
+	lim.max_write_streams = ns_lim->max_write_streams;
+	lim.write_stream_granularity = ns_lim->write_stream_granularity;
+	ret = queue_limits_commit_update(head_q, &lim);
+	if (ret)
+		goto unfreeze_head_queue;
+
+	set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
+	set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
+	nvme_mpath_revalidate_paths(ns->head);
+	ret = nvme_mpath_revalidate_zones(ns->head);
+
+unfreeze_head_queue:
+	blk_mq_unfreeze_queue(head_q, memflags);
+	return ret;
+}
+
 static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 {
 	bool unsupported = false;
@@ -2566,54 +2620,8 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		ret = 0;
 	}
 
-	if (!ret && nvme_ns_head_multipath(ns->head)) {
-		struct queue_limits *ns_lim = &ns->disk->queue->limits;
-		struct queue_limits lim;
-		unsigned int memflags;
-
-		lim = queue_limits_start_update(ns->head->disk->queue);
-		memflags = blk_mq_freeze_queue(ns->head->disk->queue);
-		/*
-		 * queue_limits mixes values that are the hardware limitations
-		 * for bio splitting with what is the device configuration.
-		 *
-		 * For NVMe the device configuration can change after e.g. a
-		 * Format command, and we really want to pick up the new format
-		 * value here.  But we must still stack the queue limits to the
-		 * least common denominator for multipathing to split the bios
-		 * properly.
-		 *
-		 * To work around this, we explicitly set the device
-		 * configuration to those that we just queried, but only stack
-		 * the splitting limits in to make sure we still obey possibly
-		 * lower limitations of other controllers.
-		 */
-		lim.logical_block_size = ns_lim->logical_block_size;
-		lim.physical_block_size = ns_lim->physical_block_size;
-		lim.io_min = ns_lim->io_min;
-		lim.io_opt = ns_lim->io_opt;
-		queue_limits_stack_bdev(&lim, ns->disk->part0, 0,
-					ns->head->disk->disk_name);
-		if (lim.features & BLK_FEAT_ZONED)
-			nvme_stack_zone_resources(&lim, ns_lim);
-		if (unsupported)
-			ns->head->disk->flags |= GENHD_FL_HIDDEN;
-		else
-			nvme_init_integrity(ns->head, &lim, info);
-		lim.max_write_streams = ns_lim->max_write_streams;
-		lim.write_stream_granularity = ns_lim->write_stream_granularity;
-		ret = queue_limits_commit_update(ns->head->disk->queue, &lim);
-		if (ret)
-			goto unfreeze_head_queue;
-
-		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
-		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
-		nvme_mpath_revalidate_paths(ns->head);
-		ret = nvme_mpath_revalidate_zones(ns->head);
-
-unfreeze_head_queue:
-		blk_mq_unfreeze_queue(ns->head->disk->queue, memflags);
-	}
+	if (!ret && nvme_ns_head_multipath(ns->head))
+		ret = nvme_update_ns_head_limits(ns, info, unsupported);
 
 	return ret;
 }
-- 
2.25.1


