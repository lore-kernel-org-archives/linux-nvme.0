Return-Path: <SRS0=1xwY=4M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0392BC11D2F
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 16:46:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC75E20637
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2020 16:46:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oAFihzsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC75E20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=b5diJYWmzBhHMQMTlPN7y6B6Go524MpIcgPHQdsy+HE=; b=oAFihzsTB41CuN
	m5Bs5OBJ5UZVibw43brTLVTygaGfCiM9sO2/Au5tZXbRe5iY5IEgRk0/zGcn0JyO5ziI5kaxo/fiC
	KoKmUcYFUsEmf3Ao6r1F+jREeOiE1CiOx0DhfnOEwEdtC2LB8Xc0Sahg6AGP9nWtH6SB0thy6Fly5
	t/tqahnyHgNdCtSCv1QpxnWIyL/ry/ZguQ5xA8iUwqgbPuzlpfv3YHQkkyQBZnAETROd26HxdZLgr
	n2SUEcMmM9N70r/5WBSLmKg5dxyrdnrjRyOhN3VkTjrcM3RGiBv1Lul3hQ7cZ+flKIoKD4FJIovAh
	kDSfXfgcEgG4QCPCxlDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j6Gry-0001UL-FM; Mon, 24 Feb 2020 16:46:10 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j6Gri-0001E5-UW
 for linux-nvme@lists.infradead.org; Mon, 24 Feb 2020 16:45:57 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 24 Feb 2020 18:45:45 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 01OGji9N013647;
 Mon, 24 Feb 2020 18:45:45 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me,
 linux-rdma@vger.kernel.org, kbusch@kernel.org, hch@lst.de,
 martin.petersen@oracle.com
Subject: [PATCH 01/19] nvme: Introduce namespace features flag
Date: Mon, 24 Feb 2020 18:45:26 +0200
Message-Id: <20200224164544.219438-3-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200224164544.219438-1-maxg@mellanox.com>
References: <20200224164544.219438-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200224_084555_384445_5C83D162 
X-CRM114-Status: GOOD (  11.64  )
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
Cc: axboe@kernel.dk, vladimirk@mellanox.com, shlomin@mellanox.com,
 israelr@mellanox.com, idanb@mellanox.com, maxg@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

Centralize all the integrity checks to one place and make the code more
readable.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
---
 drivers/nvme/host/core.c | 39 ++++++++++++++++++++++++++-------------
 drivers/nvme/host/nvme.h |  5 ++++-
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8491422..3a754e0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -209,11 +209,6 @@ static int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 	return ret;
 }
 
-static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
-{
-	return ns->pi_type && ns->ms == sizeof(struct t10_pi_tuple);
-}
-
 static blk_status_t nvme_error_status(u16 status)
 {
 	switch (status & 0x7ff) {
@@ -715,7 +710,8 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		 * namespace capacity to zero to prevent any I/O.
 		 */
 		if (!blk_integrity_rq(req)) {
-			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns)))
+			if (WARN_ON_ONCE(!(ns->features &
+					   NVME_NS_MD_CTRL_SUPPORTED)))
 				return BLK_STS_NOTSUPP;
 			control |= NVME_RW_PRINFO_PRACT;
 		}
@@ -1277,7 +1273,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	meta_len = (io.nblocks + 1) * ns->ms;
 	metadata = (void __user *)(uintptr_t)io.metadata;
 
-	if (ns->ext) {
+	if (ns->features & NVME_NS_EXT_LBAS) {
 		length += meta_len;
 		meta_len = 0;
 	} else if (meta_len) {
@@ -1807,10 +1803,10 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_queue_io_min(disk->queue, phys_bs);
 	blk_queue_io_opt(disk->queue, io_opt);
 
-	if (ns->ms && !ns->ext &&
-	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
+	if (ns->features & NVME_NS_MD_HOST_SUPPORTED)
 		nvme_init_integrity(disk, ns->ms, ns->pi_type);
-	if ((ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk)) ||
+	if ((ns->ms && !(ns->features & NVME_NS_MD_CTRL_SUPPORTED) &&
+	     !blk_get_integrity(disk)) ||
 	    ns->lba_shift > PAGE_SHIFT)
 		capacity = 0;
 
@@ -1840,12 +1836,29 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 		ns->lba_shift = 9;
 	ns->noiob = le16_to_cpu(id->noiob);
 	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
-	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
+	ns->features = 0;
 	/* the PI implementation requires metadata equal t10 pi tuple size */
-	if (ns->ms == sizeof(struct t10_pi_tuple))
+	if (ns->ms == sizeof(struct t10_pi_tuple)) {
 		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
-	else
+		if (ns->pi_type)
+			ns->features |= NVME_NS_MD_CTRL_SUPPORTED;
+	} else {
 		ns->pi_type = 0;
+	}
+
+	if (ns->ms) {
+		if (id->flbas & NVME_NS_FLBAS_META_EXT)
+			ns->features |= NVME_NS_EXT_LBAS;
+
+		/*
+		 * For PCI, Extended logical block will be generated by the
+		 * controller.
+		 */
+		if (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED) {
+			if (!(ns->features & NVME_NS_EXT_LBAS))
+				ns->features |= NVME_NS_MD_HOST_SUPPORTED;
+		}
+	}
 
 	if (ns->noiob)
 		nvme_set_chunk_size(ns);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1024fec..fea20f1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -381,8 +381,11 @@ struct nvme_ns {
 	u16 ms;
 	u16 sgs;
 	u32 sws;
-	bool ext;
 	u8 pi_type;
+	unsigned long features;
+#define NVME_NS_EXT_LBAS		(1 << 0)
+#define NVME_NS_MD_HOST_SUPPORTED	(1 << 1)
+#define NVME_NS_MD_CTRL_SUPPORTED	(1 << 2)
 	unsigned long flags;
 #define NVME_NS_REMOVING	0
 #define NVME_NS_DEAD     	1
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
