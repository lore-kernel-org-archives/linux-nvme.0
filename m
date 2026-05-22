Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E5D6CD4F3D
	for <linux-nvme@archiver.kernel.org>; Fri, 22 May 2026 07:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lT7n/wXViAEO1Ac7U5U/W7avByNIM9gy04ZV8kV+MOI=; b=NnbmycLy13oc97kdVywBEGiYBL
	37EZN0viI8Cm3cwDXIDPZ1/InZItQnHXgZS/QryQ6hgnxvR71Q+kljSdU6LlyI4pjpqgqSAuNCUWX
	D3/M6hICdcwlazDKH1Dy4nrnCgj2J9uE8ZicwRE/mSWKZ4xifHrUIDGghh385yRjx2Mo6m4UXMmF1
	TwqGnm4bWAZtRwKHUqJDVcDZObQqRCLLeYQOpdkNJwfvCdP5vi4/HgN+hUKqgcXabcsqTOH0K6qHJ
	rYxsY+RdmKd6ZJ49GRbxKcLhy3P9xjPLm7kQJrco0G7dQq4jyy5zozgrGeASOyEYeFZzKTvQDOpKw
	fpeo4nQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQKlx-0000000A9HM-0jc2;
	Fri, 22 May 2026 07:58:21 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wQKlu-0000000A9G2-2wcB
	for linux-nvme@lists.infradead.org;
	Fri, 22 May 2026 07:58:20 +0000
X-UUID: f6aebca655b311f1aa26b74ffac11d73-20260522
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED
	SA_LOWREP, SA_EXISTED, SN_UNTRUSTED, SN_LOWREP, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_RG_INFO, GTI_C_BU, AMN_GOOD
	ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d39bd459-ff15-42e5-8c4e-e53a01940ab6,IP:20,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:45
X-CID-INFO: VERSION:1.3.12,REQID:d39bd459-ff15-42e5-8c4e-e53a01940ab6,IP:20,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:45
X-CID-META: VersionHash:e7bac3a,CLOUDID:8b1ffe647a22957ce6b633441be06aa5,BulkI
	D:260522154630DBFZ5AVH,BulkQuantity:1,Recheck:0,SF:17|19|66|78|102|127|850
	|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:
	40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f6aebca655b311f1aa26b74ffac11d73-20260522
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 894085007; Fri, 22 May 2026 15:58:05 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	shinichiro.kawasaki@wdc.com,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v2] nvme: recompute multipath zoned limits from ready paths
Date: Fri, 22 May 2026 15:58:06 +0800
Message-Id: <20260522075806.3168366-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260522_005819_057075_D046B140 
X-CRM114-Status: GOOD (  12.88  )
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

This was found while debugging a zoned NVMe multipath setup, where the
namespace head reported 0/0 for max_open_zones and max_active_zones
while the live path still reported finite limits.

These zoned resource limits are namespace-wide, but the head can retain
stale values after the ready-path set changes. Since 0 means "no limit"
for both values, stale head state can leave the multipath namespace with
bogus 0/0 limits even when the current ready path still advertises
finite limits.

Recompute max_open_zones and max_active_zones from the current
NVME_NS_READY paths when refreshing the namespace head limits, and clear
them when the resulting queue is not zoned.

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
Changes in v2:
- Address Shin'ichiro Kawasaki's feedback that the v1 generic
  block-layer approach ("block: stack zoned resource limits") could
  break the DM zone resource limit semantics behind blktests zbd/011.
- Narrow the fix to NVMe multipath, rename the patch accordingly, and
  move the CONFIG_NVME_MULTIPATH guard to the call site.
- Rewrite the changelog around the stale 0/0 head-limit symptom and
  refresh the testing summary with directly relevant passing coverage.

Testing:
- Build: CONFIG_NVME_MULTIPATH=n to cover the non-multipath call-site guard.
- blktests: nvme/005, nvme/057, nvme/058 for ready-path changes via reset,
  ANA failover/failback, and namespace remap.
- blktests: zbd/011, zbd/012, zbd/013, block/004
  to cover adjacent zoned/block-limit behavior.
- blktests on QEMU ZNS NVMe /dev/nvme0n1: zbd/001, zbd/002, zbd/003,
  zbd/004, zbd/005, zbd/006 to confirm the fix on the QEMU-backed
  zoned NVMe device used in this VM testbed.

Link: https://lore.kernel.org/r/20260520091237.392802-1-sangyao@kylinos.cn

 drivers/nvme/host/core.c | 42 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c3032d6ad6b1..41fbfbe5f970 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2483,6 +2483,44 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	return ret;
 }

+#ifdef CONFIG_NVME_MULTIPATH
+static void nvme_update_ns_head_zoned_limits(struct nvme_ns_head *head,
+					     struct queue_limits *lim)
+{
+	int srcu_idx;
+	struct nvme_ns *path;
+
+	if (!(lim->features & BLK_FEAT_ZONED)) {
+		lim->max_open_zones = 0;
+		lim->max_active_zones = 0;
+		return;
+	}
+
+	/*
+	 * Zone resource limits are namespace-wide. Recompute them from all ready
+	 * namespace paths instead of incrementally stacking stale head values.
+	 */
+	lim->max_open_zones = 0;
+	lim->max_active_zones = 0;
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	list_for_each_entry_srcu(path, &head->list, siblings,
+				 srcu_read_lock_held(&head->srcu)) {
+		struct queue_limits *path_lim;
+
+		if (!path->disk || !test_bit(NVME_NS_READY, &path->flags))
+			continue;
+
+		path_lim = &path->disk->queue->limits;
+		lim->max_open_zones = min_not_zero(lim->max_open_zones,
+						   path_lim->max_open_zones);
+		lim->max_active_zones = min_not_zero(lim->max_active_zones,
+						     path_lim->max_active_zones);
+	}
+	srcu_read_unlock(&head->srcu, srcu_idx);
+}
+#endif
+
 static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 {
 	bool unsupported = false;
@@ -2549,6 +2587,10 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		lim.io_opt = ns_lim->io_opt;
 		queue_limits_stack_bdev(&lim, ns->disk->part0, 0,
 					ns->head->disk->disk_name);
+
+#ifdef CONFIG_NVME_MULTIPATH
+		nvme_update_ns_head_zoned_limits(ns->head, &lim);
+#endif
 		if (unsupported)
 			ns->head->disk->flags |= GENHD_FL_HIDDEN;
 		else
--
2.25.1

