Return-Path: <SRS0=AJHE=Y5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D8CCC5DF60
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 16:24:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B48B72087E
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2019 16:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ORf8TAz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B48B72087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=uQDzsKUGDqfV2Ec6HeRwjrJStPaD1vSq+cU+er9olns=; b=ORf8TAz+TMP5H6
	vUgIC+sDGWl4FAEOzu93xa7j3GkA4YofDzS+L4FLmNnk0XMrbTE2+vFVFvw/UDFIYnl9fsVmLr3OY
	cX+KhIt2kAGKbr1h3iHGs/Hgqx0yzmmR/YhCnlPsFzw7v2n8bDEGmxTXfnFi9dLTjeK6RE/wUtV3k
	Fc0PeQy2J7Kd3QnLefT8JR6OWXp/eXDQTnqzfK/YIBdvR2DR8eLQHv5069NBo8PcPGas4NXs4HQci
	hq0QAP2aNtQmiE9g8OqwNV3duJrYsDdOQ120eu6MBurRgo4oNB3r9WyzrhBhqo6/bbQPrvlnxiEbn
	VrRCog5NUKwfeeuSwL+A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iS1cx-0006Z6-Mf; Tue, 05 Nov 2019 16:24:19 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iS1ZR-0003SE-N6
 for linux-nvme@lists.infradead.org; Tue, 05 Nov 2019 16:20:50 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 5 Nov 2019 18:20:27 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id xA5GKQlx013132;
 Tue, 5 Nov 2019 18:20:27 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me
Subject: [PATCH 02/15] nvme: Fail __nvme_revalidate_disk in case of a spec
 violation
Date: Tue,  5 Nov 2019 18:20:13 +0200
Message-Id: <20191105162026.183901-4-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191105162026.183901-1-maxg@mellanox.com>
References: <20191105162026.183901-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191105_082042_295518_D1A2DCAF 
X-CRM114-Status: GOOD (  11.62  )
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
Cc: vladimirk@mellanox.com, idanb@mellanox.com, israelr@mellanox.com,
 shlomin@mellanox.com, oren@mellanox.com, maxg@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

An extended LBA is a larger LBA that is created when metadata associated
with the LBA is transferred contiguously with the LBA data (AKA
interleaved). The metadata may be either transferred as part of the LBA
(creating an extended LBA) or it may be transferred as a separate
contiguous buffer of data. According to the NVMeoF spec, a fabrics ctrl
supports only an Extended LBA format. Fail revalidation in case we have a
spec violation. Also init the integrity profile for the block device for
fabrics ctrl.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
---
 drivers/nvme/host/core.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 44b247f..832b0fd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1754,9 +1754,10 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_queue_io_min(disk->queue, phys_bs);
 	blk_queue_io_opt(disk->queue, io_opt);
 
-	if (ns->ms && !ns->ext &&
-	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
-		nvme_init_integrity(disk, ns->ms, ns->pi_type);
+	if (ns->ms && (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED)) {
+		if ((ns->ctrl->opts && ns->ctrl->opts->pi_enable) || !ns->ext)
+			nvme_init_integrity(disk, ns->ms, ns->pi_type);
+	}
 	if ((ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk)) ||
 	    ns->lba_shift > PAGE_SHIFT)
 		capacity = 0;
@@ -1774,7 +1775,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_mq_unfreeze_queue(disk->queue);
 }
 
-static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
+static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 {
 	struct nvme_ns *ns = disk->private_data;
 
@@ -1788,6 +1789,16 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	ns->noiob = le16_to_cpu(id->noiob);
 	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
 	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
+
+	/*
+	 * For Fabrics, only metadata as part of extended data LBA is supported.
+	 * fail in case of a spec violation.
+	 */
+	if (ns->ms && (ns->ctrl->ops->flags & NVME_F_FABRICS)) {
+		if (WARN_ON_ONCE(!ns->ext))
+			return -EINVAL;
+	}
+
 	/* the PI implementation requires metadata equal t10 pi tuple size */
 	if (ns->ms == sizeof(struct t10_pi_tuple))
 		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
@@ -1804,6 +1815,7 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 		revalidate_disk(ns->head->disk);
 	}
 #endif
+	return 0;
 }
 
 static int nvme_revalidate_disk(struct gendisk *disk)
@@ -1828,7 +1840,10 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		goto free_id;
 	}
 
-	__nvme_revalidate_disk(disk, id);
+	ret = __nvme_revalidate_disk(disk, id);
+	if (ret)
+		goto free_id;
+
 	ret = nvme_report_ns_ids(ctrl, ns->head->ns_id, id, &ids);
 	if (ret)
 		goto free_id;
@@ -3496,7 +3511,8 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
 	ns->disk = disk;
 
-	__nvme_revalidate_disk(disk, id);
+	if (__nvme_revalidate_disk(disk, id))
+		goto out_free_disk;
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		ret = nvme_nvm_register(ns, disk_name, node);
@@ -3519,18 +3535,20 @@ static int nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	kfree(id);
 
 	return 0;
- out_put_disk:
+out_put_disk:
 	put_disk(ns->disk);
- out_unlink_ns:
+out_free_disk:
+	del_gendisk(ns->disk);
+out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
 	mutex_unlock(&ctrl->subsys->lock);
 	nvme_put_ns_head(ns->head);
- out_free_id:
+out_free_id:
 	kfree(id);
- out_free_queue:
+out_free_queue:
 	blk_cleanup_queue(ns->queue);
- out_free_ns:
+out_free_ns:
 	kfree(ns);
 	if (ret > 0)
 		ret = blk_status_to_errno(nvme_error_status(ret));
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
