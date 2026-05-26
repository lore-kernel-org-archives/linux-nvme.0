Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D826BCD5BB4
	for <linux-nvme@archiver.kernel.org>; Tue, 26 May 2026 07:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pCk/MOI1IrBrf1zS9mxmztXvWQilJ06SiMp8QUtJfdU=; b=ftHB9IxPhmX7ZS6ajyxamNMbz7
	UbfXMMoI7n7OXt/XgQiCnAE1MCDwARkHnQJ0rxBpRmf1/76FczPwSr0RWjw4iDmwoCuBqgPtyTika
	nSxtrlTYmMfKS9SIUBSjXQ3u2fHvyVDH+58oriLWkL9S5LkH7uBdgqUm5i5OGz5shAeepSV4nbBR7
	ABX6DZSYooQ71MrtXDnciJlva7DWYz3Y8ilEkh6obAUAFkTJH9KIvqPYJGGKAcA7QcZKL1EdSVqE3
	UgowJSKjMlY0kpychezK8kEUIT2Tt8yNumliEuJSIyKmk+l6fTf1vKiUIso/AZ5htyBf5xAXfEex7
	V9clgSpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRmAR-00000001GE6-1qEd;
	Tue, 26 May 2026 07:25:35 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRmAO-00000001GBw-0fPn
	for linux-nvme@lists.infradead.org;
	Tue, 26 May 2026 07:25:33 +0000
X-UUID: 08ddda6a58d411f1aa26b74ffac11d73-20260526
X-CTIC-Tags: HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_UNTRUSTED
	SA_LOWREP, SA_EXISTED, SN_UNTRUSTED, SN_LOWREP, SN_EXISTED
	SPF_NOPASS, DKIM_NOPASS, DMARC_NOPASS, CIE_BAD, CIE_GOOD
	CIE_GOOD_SPF, GTI_FG_BS, GTI_FG_IT, GTI_RG_INFO, GTI_C_BU
	AMN_T1, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:6cc670dc-552e-4ad0-bf1d-4a539b6f2528,IP:10,
	URL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:35
X-CID-INFO: VERSION:1.3.12,REQID:6cc670dc-552e-4ad0-bf1d-4a539b6f2528,IP:10,UR
	L:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:35
X-CID-META: VersionHash:e7bac3a,CLOUDID:149dc50b53c5225263ebbc15a4c95e47,BulkI
	D:260526151812YBISQN42,BulkQuantity:1,Recheck:0,SF:17|19|66|78|102|127|850
	|865|898,TC:nil,Content:0|15|50,EDM:5,IP:-2,URL:99|1,File:nil,RT:nil,Bulk:
	40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BR
	E:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_FSD,TF_CID_SPAM_ULS,TF_CID_SPAM_SNR,TF_CID_SPAM_FAS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 08ddda6a58d411f1aa26b74ffac11d73-20260526
X-User: sangyao@kylinos.cn
Received: from localhost.localdomain [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <sangyao@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 586137057; Tue, 26 May 2026 15:25:13 +0800
From: Yao Sang <sangyao@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	shinichiro.kawasaki@wdc.com,
	Yao Sang <sangyao@kylinos.cn>
Subject: [PATCH v3] nvme: refresh multipath head zoned limits from path limits
Date: Tue, 26 May 2026 15:25:29 +0800
Message-Id: <20260526072529.1086128-1-sangyao@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260526_002532_524201_EDB887B5 
X-CRM114-Status: GOOD (  10.06  )
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

queue_limits_stack_bdev() updates the multipath head limits from the
path queue, but it does not propagate max_open_zones or
max_active_zones. As a result, a zoned multipath namespace head can
keep stale 0/0 values even after a ready path reports finite zoned
resource limits.

When refreshing the head limits in nvme_update_ns_info(), update the
zoned limits directly after stacking the path queue limits. Clamp
max_open_zones and max_active_zones against the current path limits
with min_not_zero(), and clear both fields when the resulting queue is
not zoned.

This avoids advertising "no limit" on the multipath head while keeping
the zoned-limit handling local to the nvme multipath update path.

Signed-off-by: Yao Sang <sangyao@kylinos.cn>
---
Changes in v3:
- Keep the fix local to the NVMe multipath update path, as suggested
  in review
- Drop the helper and update the zoned limits directly in
  nvme_update_ns_info().
- Keep explicit clearing of both zoned-limit fields when the resulting
  queue is not zoned.

Testing:
- blktests: nvme/005, nvme/057, nvme/058
- blktests: zbd/011, zbd/012, zbd/013, block/004
- blktests on /dev/nvme0n1: zbd/001, zbd/002, zbd/003, zbd/004,
  zbd/005, zbd/006

Link to v1:
https://lore.kernel.org/r/20260520091237.392802-1-sangyao@kylinos.cn

Link to v2:
https://lore.kernel.org/all/20260522075806.3168366-1-sangyao@kylinos.cn

 drivers/nvme/host/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c3032d6ad6b1..18383a70e2c5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2549,6 +2549,15 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 		lim.io_opt = ns_lim->io_opt;
 		queue_limits_stack_bdev(&lim, ns->disk->part0, 0,
 					ns->head->disk->disk_name);
+		if (lim.features & BLK_FEAT_ZONED) {
+			lim.max_open_zones = min_not_zero(lim.max_open_zones,
+							  ns_lim->max_open_zones);
+			lim.max_active_zones = min_not_zero(lim.max_active_zones,
+							    ns_lim->max_active_zones);
+		} else {
+			lim.max_open_zones = 0;
+			lim.max_active_zones = 0;
+		}
 		if (unsupported)
 			ns->head->disk->flags |= GENHD_FL_HIDDEN;
 		else
-- 
2.25.1


