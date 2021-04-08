Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E37C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:15:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74C7461159
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74C7461159
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8OmKzdn2mSyF9Q725wuQYSVSr6t8PgDsxVMuvRQpwBE=; b=LrZqWbQBc3mqUaUY2LwF84G5k
	y9TrVIENIaYagodvMx5Fjv6tAUKATB9fL661ERIcnUq6hBQHH1wq7waxUg6ZWdhB3UpxgoniwLbKM
	OQRlwdu/Bu93PqhIP+52YMWBV0uZeiwhGa7VWDHEZOig44S8HRQlaRfK+Hm5legx5do8dE6sWcARN
	MuCZVgxuiq9pTiawMcJEDJLdpGiyrnZv92TzO4wVEw8qSVZx4EY1HwivaxKISogJMEiNmnGOIoqrZ
	om/4b6bxLL2p0E1VvDX3xdNOT7o3d1JFTg/WKYed0o6ST8q3XV2pJeYfxmlMJkteOwWeOtu5ymVgY
	DS5KPBu5A==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUTZH-007wYG-6Q; Thu, 08 Apr 2021 12:15:27 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTZE-007wXi-Lo
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 12:15:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=jbwvogdPlVNfuOZ+QOVPvQFHzTRdluoAD2acq6ngYeM=; b=N8+elow9+YYzqmdbdSRQS58ucE
 6cB3Pka1rQF0ItyH/Paz99SEbZW1cC8NX0am8kWc99UBq3CKrBTSZqWdzGWtOh9kFRHStKLOCfWAK
 oUOVsXtiZmCWDpHcsgZos6zOMN2hga2Zo7vi5EKH2wn827909rkiXxU5tcHLJXL0kojeYMFXB5t4j
 G2btNBekWg1eV12jpIx+hJQOq/Bv0G4Q5cT70eidLHs3Y3zR2si6f0LSFeToAbmjPSazvywX1aU0B
 j5OEfTjCr3+boNqT1ncYcp+47Buw3NvcNQC15RWURpT5PE24PLMgbGLBPFNDUjn8KnM0rjwr14mfd
 QtIfgDhw==;
Received: from 213-225-2-171.nat.highway.a1.net ([213.225.2.171]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTZA-00HAIk-MI; Thu, 08 Apr 2021 12:15:21 +0000
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: [PATCH 02/13] nvme: cleanup setting the disk name
Date: Thu,  8 Apr 2021 14:08:31 +0200
Message-Id: <20210408120842.1450092-3-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210408120842.1450092-1-hch@lst.de>
References: <20210408120842.1450092-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Return false from nvme_set_disk_name and let the caller set the
non-multipath name instead of duplicating the naming information in two
places.  Also remove the pointless local variables for the disk name
and flags and the not needed ctrl argument.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c      | 17 +++++++++++------
 drivers/nvme/host/multipath.c | 24 ++++++++++++------------
 drivers/nvme/host/nvme.h      | 14 ++++----------
 3 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4d13bca83cfefa..8c60ddc47b546d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3998,8 +3998,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	struct nvme_ns *ns;
 	struct gendisk *disk;
 	struct nvme_id_ns *id;
-	char disk_name[DISK_NAME_LEN];
-	int node = ctrl->numa_node, flags = GENHD_FL_EXT_DEVT;
+	int node = ctrl->numa_node;
 
 	if (nvme_identify_ns(ctrl, nsid, ids, &id))
 		return;
@@ -4025,7 +4024,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 
 	if (nvme_init_ns_head(ns, nsid, ids, id->nmic & NVME_NS_NMIC_SHARED))
 		goto out_free_queue;
-	nvme_set_disk_name(disk_name, ns, ctrl, &flags);
 
 	disk = alloc_disk_node(0, node);
 	if (!disk)
@@ -4034,15 +4032,22 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	disk->fops = &nvme_bdev_ops;
 	disk->private_data = ns;
 	disk->queue = ns->queue;
-	disk->flags = flags;
-	memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
+	disk->flags = GENHD_FL_EXT_DEVT;
+	/*
+	 * Without the multipath code enabled, multiple controller per
+	 * subsystems are visible as devices and thus we cannot use the
+	 * subsystem instance.
+	 */
+	if (!nvme_mpath_set_disk_name(ns, disk->disk_name, &disk->flags))
+		sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
+			ns->head->instance);
 	ns->disk = disk;
 
 	if (nvme_update_ns_info(ns, id))
 		goto out_put_disk;
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
-		if (nvme_nvm_register(ns, disk_name, node)) {
+		if (nvme_nvm_register(ns, disk->disk_name, node)) {
 			dev_warn(ctrl->device, "LightNVM init failure\n");
 			goto out_put_disk;
 		}
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f2d0ce0f4d3811..0f42b7e94ce3f3 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -50,19 +50,19 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
  * and those that have a single controller and use the controller node
  * directly.
  */
-void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
-			struct nvme_ctrl *ctrl, int *flags)
-{
-	if (!multipath) {
-		sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
-	} else if (ns->head->disk) {
-		sprintf(disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
-				ctrl->instance, ns->head->instance);
-		*flags = GENHD_FL_HIDDEN;
-	} else {
-		sprintf(disk_name, "nvme%dn%d", ctrl->subsys->instance,
-				ns->head->instance);
+bool nvme_mpath_set_disk_name(struct nvme_ns *ns, char *disk_name, int *flags)
+{
+	if (!multipath)
+		return false;
+	if (!ns->head->disk) {
+		sprintf(disk_name, "nvme%dn%d", ns->ctrl->subsys->instance,
+			ns->head->instance);
+		return true;
 	}
+	sprintf(disk_name, "nvme%dc%dn%d", ns->ctrl->subsys->instance,
+		ns->ctrl->instance, ns->head->instance);
+	*flags = GENHD_FL_HIDDEN;
+	return true;
 }
 
 void nvme_failover_req(struct request *req)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 67ff5d41e7d03b..2ef0a355fbb4ae 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -668,8 +668,7 @@ static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 void nvme_mpath_unfreeze(struct nvme_subsystem *subsys);
 void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys);
 void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
-void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
-			struct nvme_ctrl *ctrl, int *flags);
+bool nvme_mpath_set_disk_name(struct nvme_ns *ns, char *disk_name, int *flags);
 void nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
@@ -708,16 +707,11 @@ static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 {
 	return false;
 }
-/*
- * Without the multipath code enabled, multiple controller per subsystems are
- * visible as devices and thus we cannot use the subsystem instance.
- */
-static inline void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
-				      struct nvme_ctrl *ctrl, int *flags)
+static inline bool nvme_mpath_set_disk_name(struct nvme_ns *ns, char *disk_name,
+		int *flags)
 {
-	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
+	return false;
 }
-
 static inline void nvme_failover_req(struct request *req)
 {
 }
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
