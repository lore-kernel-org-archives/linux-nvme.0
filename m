Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEF9C44512
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Jul 2026 02:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FiQsBdCGnFbra5o6cfHwR1p7fOOmpHmVC9W4Ya1F/kc=; b=oND07Km/oOnvfUg/vndVuTItlN
	eaEaZ3cFCi5m4HxSJDCBtMGLHl8IzDjc3l8StbI+EpRL5dWr/L+XQY6vR47i4lXzlne1OaWoXIXx1
	M0yn4NYlnJdxKlhPCUkierxHWGLJzX/+YvbXPWPEQggQ/6crXnuOSAlR5nsWmN5c/T5UqdfJspYXE
	eQJx6HhNTfJ6aFyEm9P3dym83fpPn/gp1a1nyqOnDxKP0Uzca94jNDS/GfZk7TVNLx60iU6tMge7W
	CzDcrPQQPkKwaeanjmulUR3zMeNRqBPVbkQqDrdjva0l3A2fi1s6hV3B0eWmmSAnsQ3MwCWMQ31Bs
	NNLs5Hrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wldel-00000005gjS-1G9a;
	Mon, 20 Jul 2026 02:22:59 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wlded-00000005ghE-1CTJ
	for linux-nvme@lists.infradead.org;
	Mon, 20 Jul 2026 02:22:54 +0000
X-UUID: e2e6ccd483e111f1aa26b74ffac11d73-20260720
X-CTIC-Tags: HR_CC_AS_FROM, HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO
	GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:a0cbebd0-b1fc-4905-843d-347966293bea,IP:20,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:20
X-CID-INFO: VERSION:1.3.12,REQID:a0cbebd0-b1fc-4905-843d-347966293bea,IP:20,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:b8b6e8987bd82b8a3dff3c999f76997c,BulkI
	D:2607171221128WXZJTVA,BulkQuantity:2,Recheck:0,SF:10|38|66|78|81|82|102|1
	27|136|850|865|898,TC:nil,Content:0|15|50,EDM:-3,IP:-2,URL:0,File:nil,RT:n
	il,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,
	BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: e2e6ccd483e111f1aa26b74ffac11d73-20260720
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2114683733; Mon, 20 Jul 2026 10:22:42 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Cc: Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v1 1/2] nvme: factor namespace-head queue-limit update
Date: Mon, 20 Jul 2026 10:22:04 +0800
Message-Id: <20260720022205.1798805-2-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260720022205.1798805-1-sangyao@kylinos.cn>
References: <20260720022205.1798805-1-sangyao@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260719_192251_622152_FEA05E8F 
X-CRM114-Status: GOOD (  18.25  )
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

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
 drivers/nvme/host/core.c | 104 +++++++++++++++++++++------------------
 1 file changed, 56 insertions(+), 48 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b7293fe66540..e351cb615b10 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2526,6 +2526,60 @@ static void nvme_stack_zone_resources(struct queue_limits *t,
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
@@ -2564,54 +2618,8 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
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


