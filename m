Return-Path: <SRS0=qSsZ=6M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75F0FC83000
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 13:13:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA76206A1
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Apr 2020 13:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aW6ovgvH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA76206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oOfq2WUJEcioj+reTEp+u9t/YskJGJ7YR3o7hp5C4R0=; b=aW6ovgvHMskomU
	zGfxDy5WDt70SApXvoCZlGjlJ0KzIQi1P1oIn9YVGdA6I+PDXy9BSHBLE/JPQR1duSOgO/K3Sjuct
	W8028dOqpPgrLX8MalB/Xay5/nQwyebvVxJsT0YcxGIxv6h6uGjTZxrK8o6C+EqFFTlIHBDJ1crEB
	Yw2R6BmHfJPKXSvOl1K9IJmzhJ5ZQFD8NQ+2BR0gNd49+Dwx1d4Sw7kv5K7VguJuZvvT+kaumnbaI
	3SVqA6aToBypIIhKr3/IVaLubTNJK2VRSLhrDpLVWgm4qf+Bta9iCnzYoSm07HjZEYS/gB1NwDlXq
	nmYYikDncnWhNt0NyGrw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jTQ2v-0004SV-Hu; Tue, 28 Apr 2020 13:13:09 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jTQ1X-0003HV-SK
 for linux-nvme@lists.infradead.org; Tue, 28 Apr 2020 13:11:48 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 28 Apr 2020 16:11:36 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 03SDBZYx028635;
 Tue, 28 Apr 2020 16:11:36 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: maxg@mellanox.com, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de, sagi@grimberg.me, martin.petersen@oracle.com,
 jsmart2021@gmail.com, axboe@kernel.dk
Subject: [PATCH 04/15] nvme: enforce extended LBA format for fabrics metadata
Date: Tue, 28 Apr 2020 16:11:24 +0300
Message-Id: <20200428131135.211521-5-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200428131135.211521-1-maxg@mellanox.com>
References: <20200428131135.211521-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200428_061144_325089_A42965BB 
X-CRM114-Status: GOOD (  12.72  )
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

An extended LBA is a larger LBA that is created when metadata associated
with the LBA is transferred contiguously with the LBA data (AKA
interleaved). The metadata may be either transferred as part of the LBA
(creating an extended LBA) or it may be transferred as a separate
contiguous buffer of data. According to the NVMeoF spec, a fabrics ctrl
supports only an Extended LBA format. Fail revalidation in case we have a
spec violation. Also add a flag that will imply on capable transports and
controllers as part of a preparation for allowing end-to-end protection
information for fabric controllers.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
---
 drivers/nvme/host/core.c | 41 +++++++++++++++++++++++++++--------------
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 40aa2be..dd59de0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1908,9 +1908,10 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_mq_unfreeze_queue(disk->queue);
 }
 
-static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
+static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 {
 	struct nvme_ns *ns = disk->private_data;
+	struct nvme_ctrl *ctrl = ns->ctrl;
 	u32 iob;
 
 	/*
@@ -1921,9 +1922,9 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ns->lba_shift == 0)
 		ns->lba_shift = 9;
 
-	if ((ns->ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) &&
-	    is_power_of_2(ns->ctrl->max_hw_sectors))
-		iob = ns->ctrl->max_hw_sectors;
+	if ((ctrl->quirks & NVME_QUIRK_STRIPE_SIZE) &&
+	    is_power_of_2(ctrl->max_hw_sectors))
+		iob = ctrl->max_hw_sectors;
 	else
 		iob = nvme_lba_to_sect(ns, le16_to_cpu(id->noiob));
 
@@ -1936,16 +1937,24 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 		ns->pi_type = 0;
 
 	if (ns->ms) {
-		if (id->flbas & NVME_NS_FLBAS_META_EXT)
-			ns->features |= NVME_NS_EXT_LBAS;
-
 		/*
-		 * For PCI, Extended logical block will be generated by the
-		 * controller. Non-extended format can be generated by the
-		 * block layer.
+		 * For PCIe only the separate metadata pointer is supported,
+		 * as the block layer supplies metadata in a separate bio_vec
+		 * chain. For Fabrics, only metadata as part of extended data
+		 * LBA is supported on the wire per the Fabrics specification,
+		 * but the HBA/HCA will do the remapping from the separate
+		 * metadata buffers for us.
 		 */
-		if (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED) {
-			if (!(ns->features & NVME_NS_EXT_LBAS))
+		if (id->flbas & NVME_NS_FLBAS_META_EXT) {
+			ns->features |= NVME_NS_EXT_LBAS;
+			if ((ctrl->ops->flags & NVME_F_FABRICS) &&
+			    (ctrl->ops->flags & NVME_F_METADATA_SUPPORTED) &&
+			    ctrl->pi_capable)
+				ns->features |= NVME_NS_METADATA_SUPPORTED;
+		} else {
+			if (WARN_ON_ONCE(ctrl->ops->flags & NVME_F_FABRICS))
+				return -EINVAL;
+			if (ctrl->ops->flags & NVME_F_METADATA_SUPPORTED)
 				ns->features |= NVME_NS_METADATA_SUPPORTED;
 		}
 	}
@@ -1960,6 +1969,7 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 		revalidate_disk(ns->head->disk);
 	}
 #endif
+	return 0;
 }
 
 static int nvme_revalidate_disk(struct gendisk *disk)
@@ -1995,7 +2005,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		goto free_id;
 	}
 
-	__nvme_revalidate_disk(disk, id);
+	ret = __nvme_revalidate_disk(disk, id);
 free_id:
 	kfree(id);
 out:
@@ -3649,7 +3659,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
 	ns->disk = disk;
 
-	__nvme_revalidate_disk(disk, id);
+	if (__nvme_revalidate_disk(disk, id))
+		goto out_free_disk;
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		ret = nvme_nvm_register(ns, disk_name, node);
@@ -3674,6 +3685,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	return;
  out_put_disk:
 	put_disk(ns->disk);
+ out_free_disk:
+	del_gendisk(ns->disk);
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0f5fa85..f60ca01 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -291,6 +291,7 @@ struct nvme_ctrl {
 	u16 icdoff;
 	u16 maxcmd;
 	int nr_reconnects;
+	bool pi_capable;
 	struct nvmf_ctrl_options *opts;
 
 	struct page *discard_page;
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
