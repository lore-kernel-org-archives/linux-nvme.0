Return-Path: <SRS0=Br1a=5M=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62521C2D0ED
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2020 18:30:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E5C120737
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2020 18:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F+Ybs57U";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NBwQj3Ia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E5C120737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KXup71tyISNwR5ZnYk7v78V8/EHHgc/EWJI9ZyJC6Nk=; b=F+Ybs57U0TCMK8
	qU+3ErunWCx98psNZT0P5Zpn5o0kpzUWLGS2L3RTeyleYzgQv+pTfSEg549fC9zztYNGIuvGizF3c
	2ds1Ibc7W2/8wfX6XN1lIkMkjt1TZGAjxEH92L1byyR4ZMHMgU9jcvj30vl+My0LfcsL5230+E5bT
	yFNbkiDrcWgoeMThNHicmID1y1stFeisPVXxrJZxId7U6yokbFvn3IxiFCjO6zTcId7McHhoaxWzd
	ZnNer7BQKdFYJqsUywpWhCZDGfCadpy0gtzkgOu62pMQ0yOuQdzkClwePo7AFHPQf0RfaFL1z6T7V
	6F742zrSHdrJ1iFbgJfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jHtkt-0007tW-EY; Fri, 27 Mar 2020 18:30:55 +0000
Received: from merlin.infradead.org ([205.233.59.134])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHsaO-0007wu-Br
 for linux-nvme@bombadil.infradead.org; Fri, 27 Mar 2020 17:16:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=HbBKk59avul6dmaToLsj3KwV5GNsMoniMPHOkhyWetA=; b=NBwQj3IaKdluhxTfMnuKQfpcZJ
 9JCG7ccvpANGjPKev+1oPtf4YAAZm76f/bH5cyLuidFJYJq3zkUWxTMle58ix5kC/9zJ11S5bDrOQ
 DwWFvZt1EohGf0goojD2Gw2r1+lfzrClgEEt20ZlGKwx2yMjNV59xO3+6lA5rpsqXmqgPJltrY5yq
 jGe5/jvAdhBZ9AmjzKlBa3p5Ddob9pMGXUmOfbwIv//VHrfZtV5lHFe7e4Xg0gHiyUQ4VT0OeeCFt
 NF1YvtvqdMVX7YMTfSAhXpHnesF42vx7rDD5eC4+H/JvkBDZsHzJ3D8F59VjKFGyfsccbVlUzDzE0
 OV+1aAaQ==;
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jHsaL-00081y-7y
 for linux-nvme@lists.infradead.org; Fri, 27 Mar 2020 17:15:59 +0000
Received: from Internal Mail-Server by MTLPINE2 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 27 Mar 2020 20:15:46 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx
 [10.209.102.136])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 02RHFjj4004869;
 Fri, 27 Mar 2020 20:15:46 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-nvme@lists.infradead.org, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, martin.petersen@oracle.com, jsmart2021@gmail.com,
 linux-rdma@vger.kernel.org
Subject: [PATCH 01/17] nvme: introduce namespace features flag
Date: Fri, 27 Mar 2020 20:15:29 +0300
Message-Id: <20200327171545.98970-3-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200327171545.98970-1-maxg@mellanox.com>
References: <20200327171545.98970-1-maxg@mellanox.com>
MIME-Version: 1.0
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
 israelr@mellanox.com, idanb@mellanox.com, jgg@mellanox.com, oren@mellanox.com,
 maxg@mellanox.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Israel Rukshin <israelr@mellanox.com>

Centralize all the metadata checks to one place and make the code more
readable. Introduce a new enum nvme_ns_features for that matter.
The features flag description:
 - NVME_NS_EXT_LBAS - NVMe namespace supports extended LBA format.
 - NVME_NS_MD_HOST_SUPPORTED - NVMe namespace supports getting metadata
   from host's block layer.
 - NVME_NS_MD_CTRL_SUPPORTED - NVMe namespace supports metadata actions
   by the controller (generate/strip).

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Signed-off-by: Israel Rukshin <israelr@mellanox.com>
---
 drivers/nvme/host/core.c | 42 ++++++++++++++++++++++++++++--------------
 drivers/nvme/host/nvme.h |  8 +++++++-
 2 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1cab3c6..f3a184f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -203,11 +203,6 @@ static void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 	nvme_put_ctrl(ctrl);
 }
 
-static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
-{
-	return ns->pi_type && ns->ms == sizeof(struct t10_pi_tuple);
-}
-
 static blk_status_t nvme_error_status(u16 status)
 {
 	switch (status & 0x7ff) {
@@ -706,7 +701,8 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
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
@@ -1837,11 +1833,12 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_queue_io_min(disk->queue, phys_bs);
 	blk_queue_io_opt(disk->queue, io_opt);
 
-	if (ns->ms && !ns->ext &&
-	    (ns->ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
+	if (ns->features & NVME_NS_MD_HOST_SUPPORTED)
 		nvme_init_integrity(disk, ns->ms, ns->pi_type);
-	if ((ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk)) ||
-	    ns->lba_shift > PAGE_SHIFT)
+
+	if ((ns->ms && !(ns->features & NVME_NS_MD_CTRL_SUPPORTED) &&
+	     !(ns->features & NVME_NS_MD_HOST_SUPPORTED) &&
+	     !blk_get_integrity(disk)) || ns->lba_shift > PAGE_SHIFT)
 		capacity = 0;
 
 	set_capacity(disk, capacity);
@@ -1870,12 +1867,29 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
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
index 2e04a36..83296d0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -363,6 +363,12 @@ struct nvme_ns_head {
 #endif
 };
 
+enum nvme_ns_features {
+	NVME_NS_EXT_LBAS = 1 << 0,
+	NVME_NS_MD_HOST_SUPPORTED = 1 << 1,
+	NVME_NS_MD_CTRL_SUPPORTED = 1 << 2,
+};
+
 struct nvme_ns {
 	struct list_head list;
 
@@ -382,8 +388,8 @@ struct nvme_ns {
 	u16 ms;
 	u16 sgs;
 	u32 sws;
-	bool ext;
 	u8 pi_type;
+	unsigned long features;
 	unsigned long flags;
 #define NVME_NS_REMOVING	0
 #define NVME_NS_DEAD     	1
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
