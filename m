Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24324C433E9
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 04:47:54 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E64564DD9
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 04:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E64564DD9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ts0aFZBwaQRjW3wunp90Fc6e7lFGw7Rf8Cnetx+OeeY=; b=Qu/lbgeDKq7po1Sx+GBEaiyEi
	X2+B6i26KwQSZP08LCvpgToXu7ezALlQec3YACd/ZtQC2BzQw0ANMMfpjnsHOXOVXLb3FOivN55lT
	McJs4p2aT8F3xaj2HO6jcYe4Ne2TBCt4xvDwk0Z6/JVZfLfrtzkzte6fwnDpA8BbEoeS9LBuLhbVr
	3OZKR5JFZvNRkcGnL7aJpOfxcbmfs39UYtP9VAuiFUZ+QMVG0O36CJF69ZFycn9VY0pM5rBce4L29
	cEsFa/YNle3xfvdF8aIboKhnzJLt5WTtYj+FByiAAcSSbAJ2uq9XMFbkaprmwiWbSoozPoiXVB65X
	30Sl3CSYg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l4zDd-00026Q-NV; Thu, 28 Jan 2021 04:47:45 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l4zDX-000241-Qx
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 04:47:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1611809259; x=1643345259;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SWCTJmRNv2T9JpmyPX37nbAkKPtO6xgSUCxz+iuTR/w=;
 b=f9BAbindix4XPp2QDYDTtx2ja/wUcXOrAiTI6y9ZK9ClkVLz4uiisnXR
 VyTRFobSFuP8nlwNcI6r0ZgDHbOokWVAaford9KCfzW97GWELg05wEFog
 dtcHr/i0ymDwQx1tjMN5qa/TcUzAf61lU6B39pW3HAr+DE4E8dIXjDd22
 14LF/SgEVE9bvXRtnXIlVDgC6nJDgkWNOw0zYVujW/NjXaglZ6AG0GkpT
 cQQf7s4fqqEx62bFvlOnHm0f1NW0xxjNY8Iv60PG3z6MhIn/7TX7Z+yyw
 DZwoAyHkve1Lr3kxs9Pvuz9GI4TjaOpwzyb+Q8R2Ja2Ljwea8bz19/z6i g==;
IronPort-SDR: iPs1vM0bg1DO2wV+g07zHnv+eQCHNOy4zZKqF0ITut8O5ZLxz/GHU0FltISNOirNp6vzvei0Wj
 N8T4looQxNeBY2sSlKEExcI4JbpFmHNvqDHrhGRCfkgykBl6wXT0LA1vdJB5IATmgEXxDRKA+1
 A3rNzC/c05pWaSotUx7jeJDg9vYPKXBXHO4djzEE0Jeh224iRZOmB7lxbNvFP/NpCBPXhAcZ9F
 Hcjt4/abUbxyggTmplJxgqcpduiCxc1xaR2N9HMUrDhl8zcOafUUfGTUTnFjneCxOIwsXNYogs
 QCc=
X-IronPort-AV: E=Sophos;i="5.79,381,1602518400"; d="scan'208";a="158509622"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2021 12:47:39 +0800
IronPort-SDR: GSTqvhoSyWUeJxML9yVumDayYZV6nOyzcF28+CGzvjKkgdlZVYt8as41NWLPIs2epqFSUzqFXU
 3+kng4Zm0cyBVDrn9PDNb7G49Sal8Kyy+CP5E0iBvgBxrJGFcnszKT2Wn2wvU31SPxcrBMWPhM
 xQYP4F+kHaUAX+iss2DL9gdb3ZX7OZzwUWZBdlRg19A8mCucUJtTLZFV3vg2wpYXLb9qGBAGfW
 vwvawRymjODi0zNDHPQn2JpsV9o2I7aLVHasdCRTFwvoiVNIS8s41YiX+sycFerrr468NyD6sc
 pv68w2WxGpkR6mcZ1R4bKgvL
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2021 20:31:59 -0800
IronPort-SDR: jBNmDaXDVx8v8RZcXtnMGGqEm3shQx0PxDNLaX1rzbyNbnPEVu1t9X34NLlWClP6rF9ErVcQ0I
 RtgqajKMuXA2X2Pvk5cZESe2jSoGcHmD/P53lB4UCwpXkvhmkjIgH3V+EBlA8foqgNHTY1c7E7
 FjTIk5Nr0HKNOH4jBBO/nGekm86UgUAA1YfHnSarLNb9pZNvOBa+HDVR/zbOCxY6NY1ZP9K4yt
 pUJPoH4sN6bH+F2icZDg6pkQQGirtTTIvKgI0min0s/BwDOfZJ+pk3H8XxlirLkj8jsnmft2Ni
 3UE=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 27 Jan 2021 20:47:37 -0800
From: Damien Le Moal <damien.lemoal@wdc.com>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v4 2/8] nvme: cleanup zone information initialization
Date: Thu, 28 Jan 2021 13:47:27 +0900
Message-Id: <20210128044733.503606-3-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210128044733.503606-1-damien.lemoal@wdc.com>
References: <20210128044733.503606-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210127_234740_035343_F463DE5E 
X-CRM114-Status: GOOD (  14.66  )
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
Cc: Keith Busch <keith.busch@wdc.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For a zoned namespace, in nvme_update_ns_info(), call
nvme_update_zone_info() after executing nvme_update_disk_info() so that
the namespace queue logical and physical block size limits are set.
This allows setting the namespace queue max_zone_append_sectors limit
in nvme_update_zone_info() instead of nvme_revalidate_zones(),
simplifying this function. Also use blk_queue_set_zoned() to set the
namespace zoned model.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 drivers/nvme/host/core.c | 11 ++++++-----
 drivers/nvme/host/zns.c  | 11 +++--------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a3cdc6b1036..81a1c7f6223f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2176,17 +2176,18 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 	ns->lba_shift = id->lbaf[lbaf].ds;
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
 
+	ret = nvme_configure_metadata(ns, id);
+	if (ret)
+		goto out_unfreeze;
+	nvme_set_chunk_sectors(ns, id);
+	nvme_update_disk_info(ns->disk, ns, id);
+
 	if (ns->head->ids.csi == NVME_CSI_ZNS) {
 		ret = nvme_update_zone_info(ns, lbaf);
 		if (ret)
 			goto out_unfreeze;
 	}
 
-	ret = nvme_configure_metadata(ns, id);
-	if (ret)
-		goto out_unfreeze;
-	nvme_set_chunk_sectors(ns, id);
-	nvme_update_disk_info(ns->disk, ns, id);
 	blk_mq_unfreeze_queue(ns->disk->queue);
 
 	if (blk_queue_is_zoned(ns->queue)) {
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 1dfe9a3500e3..c7e3ec561ba0 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -9,13 +9,7 @@
 
 int nvme_revalidate_zones(struct nvme_ns *ns)
 {
-	struct request_queue *q = ns->queue;
-	int ret;
-
-	ret = blk_revalidate_disk_zones(ns->disk, NULL);
-	if (!ret)
-		blk_queue_max_zone_append_sectors(q, ns->ctrl->max_zone_append);
-	return ret;
+	return blk_revalidate_disk_zones(ns->disk, NULL);
 }
 
 static int nvme_set_max_append(struct nvme_ctrl *ctrl)
@@ -109,10 +103,11 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 		goto free_data;
 	}
 
-	q->limits.zoned = BLK_ZONED_HM;
+	blk_queue_set_zoned(ns->disk, BLK_ZONED_HM);
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
 	blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
+	blk_queue_max_zone_append_sectors(q, ns->ctrl->max_zone_append);
 free_data:
 	kfree(id);
 	return status;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
