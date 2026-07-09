Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E64F8C43458
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jul 2026 08:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TrnKzxhY1spmC0VI8iHJTvoh2I1rEbhoCuQB1efxphQ=; b=5CKC+uSopdnGwG+kUBP2PLgPYj
	kuqxflZkdVIRzvS20c3xodhyPUb2v8i4h7edCyYGt0Vdf976R8fIGRve04W+Od4BWswDbF63sljAE
	dI5uTuQNvw8fEAe5qGDJjb6Bu1DLoZAQcA6GjyNtypVyVUBHC8D0VV2ho60kxDPyG4/uYdgtHEnoG
	BCeLVZKdjqyPLC3IngKaGvm7UDgf9n9JKvEEAqFySywx5aTYV0P2bBwKDPXDoqVPaCvR5SZ8SjWuo
	9aJFPFgwmVeMvtLOcE8bp9XNU0vjJ6U6MmSP3/bKOsxCQnU6co2qIkVvfgpyxdOFFfRmtcGFNsrdL
	WmeIb+eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whkWk-00000001eIL-23qs;
	Thu, 09 Jul 2026 08:54:38 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whkS6-00000001YS6-1N6X
	for linux-nvme@bombadil.infradead.org;
	Thu, 09 Jul 2026 08:49:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=TrnKzxhY1spmC0VI8iHJTvoh2I1rEbhoCuQB1efxphQ=; b=E+EMSS3+CsEFXiHNyw4HEY0rYS
	yuzKDLFG0cWwgxhpLXc9xh4AJviLqPTDsMae8ezKdJuYZ4GJmED3RRbbHNcBgMLaI7zclHmF10PhW
	yjNGXxJdK9XnE+oqxdXYwYltfWBf3+LRxkjE7KhIto7h16KMZlKgs5ivtQAlcMS/RodWbGOplhF0G
	AmoAYR6wiEepuS/NGjCcS6lekB1VMso8HtBluEaWY3DwE8VZUe/uTrRUQbwMIc/5G8wfb0hI6n6XG
	n0aktrafkWXSlTiaegZ/K0uQ9svQcUEpvCMjfUDVXNhHSSUdN8mC84XVmhQKJ3dwTvjqFoLn4sCxp
	ZfOO4Uug==;
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1whkS0-00000008ybH-2bbo
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jul 2026 08:49:46 +0000
X-UUID: 150a3b007b7311f1aa26b74ffac11d73-20260709
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B, HR_CTT_MISS
	HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME, HR_SJ_DIGIT_LEN
	HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM, HR_SJ_PHRASE
	HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT, HR_TO_NO_NAME
	IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED, SA_EXISTED
	SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS
	CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU
	AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:f21c4681-4dee-43f4-af74-cb53fdb22c03,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:f21c4681-4dee-43f4-af74-cb53fdb22c03,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:17afc31435f40472aa0343583dbef2f8,BulkI
	D:260709162246EOG67FXZ,BulkQuantity:1,Recheck:0,SF:10|66|78|81|82|102|127|
	136|850|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:0,File:nil,RT:nil,B
	ulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:
	0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 150a3b007b7311f1aa26b74ffac11d73-20260709
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1340717855; Thu, 09 Jul 2026 16:49:22 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Yao Sang <sangyao@kylinos.cn>
Subject: [RFC PATCH v1 1/2] nvme: factor namespace-head queue-limit update
Date: Thu,  9 Jul 2026 16:48:24 +0800
Message-Id: <20260709084826.3208740-2-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260709084826.3208740-1-sangyao@kylinos.cn>
References: <20260709084826.3208740-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260709_094945_446013_83E9B610 
X-CRM114-Status: GOOD (  18.01  )
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
The new helper keeps the existing queue_limits_stack_bdev() based behavior
intact, including the current zoned resource handling, write-stream
assignment, integrity setup, capacity update, readonly update, and path
revalidation.

This is a preparatory refactor for replacing the generic stacked-device
limit update in the next patch.

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 drivers/nvme/host/core.c | 96 ++++++++++++++++++++++------------------
 1 file changed, 52 insertions(+), 44 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..b96fa993a08f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2517,6 +2517,56 @@ static void nvme_stack_zone_resources(struct queue_limits *t,
 		min_not_zero(t->max_active_zones, b->max_active_zones);
 }
 
+static int nvme_update_ns_head_limits(struct nvme_ns *ns,
+				      struct nvme_ns_info *info, bool unsupported)
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
+
+	set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
+	set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
+	nvme_mpath_revalidate_paths(ns->head);
+
+	blk_mq_unfreeze_queue(head_q, memflags);
+	return ret;
+}
+
 static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 {
 	bool unsupported = false;
@@ -2555,50 +2605,8 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
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
-
-		set_capacity_and_notify(ns->head->disk, get_capacity(ns->disk));
-		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
-		nvme_mpath_revalidate_paths(ns->head);
-
-		blk_mq_unfreeze_queue(ns->head->disk->queue, memflags);
-	}
+	if (!ret && nvme_ns_head_multipath(ns->head))
+		ret = nvme_update_ns_head_limits(ns, info, unsupported);
 
 	return ret;
 }
-- 
2.25.1


