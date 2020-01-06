Return-Path: <SRS0=Zaot=23=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC2A1C33C8C
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2020 13:38:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8EB4B2075A
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2020 13:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jom4h0Lf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EB4B2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9SapmKfpuOYupK9Jd8ZVFX6yFB9gWxhuwu+8IJ5+Rig=; b=jom4h0LfwKOJsZ
	awB2mRKovLNiq7+yi1OQFoouvQHdKQKFrElBCgQhm8+D9rp8+MsZaREhWqybosp0HWPiEUrAziGOC
	u4+jyE9SLGj1JqSdGfe0o1U+LVq823GSXKfh08OPS8imDdXLh5IaFXLYYLmzch6zXekBqTAWa4zGB
	lfP2wlH1ZqUSrSs3jSzzuD+0J7o6ZtW1OX2wBUKY7Ti935YTKLfJ4l5gosCHf1+CtkMhXLDl5jm93
	OVd7kDQig3J/SS4uCXsvL6CthJsJ4XHlLYyTFIckY6U6fNbMBu4FXwLPOeAC//t309Cw1dxJ12Od2
	IHMKdVeSzkKLY7rSptnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ioSa1-0005pW-T2; Mon, 06 Jan 2020 13:38:01 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ioSZp-0005aM-F8
 for linux-nvme@lists.infradead.org; Mon, 06 Jan 2020 13:37:51 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 6 Jan 2020 15:37:37 +0200
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 006DbaFC029740;
 Mon, 6 Jan 2020 15:37:36 +0200
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, martin.petersen@oracle.com
Subject: [PATCH 01/15] nvme: Introduce namespace features flag
Date: Mon,  6 Jan 2020 15:37:22 +0200
Message-Id: <20200106133736.123038-3-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200106133736.123038-1-maxg@mellanox.com>
References: <20200106133736.123038-1-maxg@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200106_053749_934764_9EB63AA8 
X-CRM114-Status: GOOD (  13.03  )
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
 israelr@mellanox.com, idanb@mellanox.com, oren@mellanox.com, maxg@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

Centralize all the integrity checks to one place and make the code more
readable. Also add has_pi field to the nvme_req structure as well, so the
transport drivers could use it.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
---
 drivers/nvme/host/core.c | 40 +++++++++++++++++++++++++++-------------
 drivers/nvme/host/nvme.h |  6 +++++-
 2 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2a84e14..d98eb48 100644
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
@@ -473,6 +468,7 @@ static inline void nvme_clear_nvme_request(struct request *req)
 	if (!(req->rq_flags & RQF_DONTPREP)) {
 		nvme_req(req)->retries = 0;
 		nvme_req(req)->flags = 0;
+		nvme_req(req)->has_pi = false;
 		req->rq_flags |= RQF_DONTPREP;
 	}
 }
@@ -706,6 +702,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		nvme_assign_write_stream(ctrl, req, &control, &dsmgmt);
 
 	if (ns->ms) {
+		nvme_req(req)->has_pi = ns->features & NVME_NS_DIF_SUPPORTED;
 		/*
 		 * If formated with metadata, the block layer always provides a
 		 * metadata buffer if CONFIG_BLK_DEV_INTEGRITY is enabled.  Else
@@ -713,7 +710,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		 * namespace capacity to zero to prevent any I/O.
 		 */
 		if (!blk_integrity_rq(req)) {
-			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns)))
+			if (WARN_ON_ONCE(!nvme_req(req)->has_pi))
 				return BLK_STS_NOTSUPP;
 			control |= NVME_RW_PRINFO_PRACT;
 		}
@@ -1271,7 +1268,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	meta_len = (io.nblocks + 1) * ns->ms;
 	metadata = (void __user *)(uintptr_t)io.metadata;
 
-	if (ns->ext) {
+	if (ns->features & NVME_NS_EXT_LBAS) {
 		length += meta_len;
 		meta_len = 0;
 	} else if (meta_len) {
@@ -1801,10 +1798,10 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_queue_io_min(disk->queue, phys_bs);
 	blk_queue_io_opt(disk->queue, io_opt);
 
-	if (ns->ms && !ns->ext &&
-	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
+	if (ns->features & NVME_NS_DIX_SUPPORTED)
 		nvme_init_integrity(disk, ns->ms, ns->pi_type);
-	if ((ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk)) ||
+	if ((ns->ms && !(ns->features & NVME_NS_DIF_SUPPORTED) &&
+	     !blk_get_integrity(disk)) ||
 	    ns->lba_shift > PAGE_SHIFT)
 		capacity = 0;
 
@@ -1834,12 +1831,29 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
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
+			ns->features |= NVME_NS_DIF_SUPPORTED;
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
+				ns->features |= NVME_NS_DIX_SUPPORTED;
+		}
+	}
 
 	if (ns->noiob)
 		nvme_set_chunk_size(ns);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1024fec..7247390 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -139,6 +139,7 @@ struct nvme_request {
 	u8			flags;
 	u16			status;
 	struct nvme_ctrl	*ctrl;
+	bool			has_pi;
 };
 
 /*
@@ -381,8 +382,11 @@ struct nvme_ns {
 	u16 ms;
 	u16 sgs;
 	u32 sws;
-	bool ext;
 	u8 pi_type;
+	unsigned long features;
+#define NVME_NS_EXT_LBAS	(1 << 0)
+#define NVME_NS_DIX_SUPPORTED	(1 << 1)
+#define NVME_NS_DIF_SUPPORTED	(1 << 2)
 	unsigned long flags;
 #define NVME_NS_REMOVING	0
 #define NVME_NS_DEAD     	1
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
