Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D77C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 14:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0D/VWTdK+geiC9T2VUl/7XiJQ730sW3zxBLeaEU2hKs=; b=qrxaSJzEINzaYE3wlP0+oEDla6
	t/q1LRO/U10gcQ94dMbHSBGAYz5uyOxCWywArJr96XM8t+cNY7FqHT1CwGnn9Q1W2axiQg7Abmh4S
	nJSFUWvNpUaKN191FFzzU4nQdZBrhliEEGjpapAS9HAWiEeuc7G8qFwqx9zfrU2QPGy/6UfpWS9GX
	V8hHyBleFN8eY48cDFow3TCU4daNpUKn/TKd8tW0aPH2LlbK8qYaWyMoBCQ/hcWrC/e6fEfvIuSOj
	mRK+gQNj+FaVnjY1fuNRJLNwCj6m2PH+kC7c6Sl14q3jbXOYD2y3dsialeEgK5ixOR3o7sU1M3/yl
	7CP6doJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU8WQ-009YU5-LC; Tue, 15 Mar 2022 14:51:38 +0000
Received: from [46.140.54.162] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU8WH-009YR8-VN; Tue, 15 Mar 2022 14:51:30 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: cleanup how disk->disk_name is assigned
Date: Tue, 15 Mar 2022 15:51:25 +0100
Message-Id: <20220315145125.2586068-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

They way how assigning the disk name and commenting on why it is done
is split over core.c and multipath.c seems to be rather confusing.

Now that ns_head->disk always exists we can do all the work in core.c
and have a single big comment explaining the issues.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c      | 22 ++++++++++++++++++----
 drivers/nvme/host/multipath.c | 24 +-----------------------
 drivers/nvme/host/nvme.h      |  8 ++------
 3 files changed, 21 insertions(+), 33 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f8084ded69e50..fd9878671d734 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3967,13 +3967,27 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 		goto out_cleanup_disk;
 
 	/*
-	 * Without the multipath code enabled, multiple controller per
-	 * subsystems are visible as devices and thus we cannot use the
-	 * subsystem instance.
+	 * If multipathing is enabled, the device name for all disks and not
+	 * just those that represent shared namespaces needs to be based on the
+	 * subsystem instance.  Using the controller instance for private
+	 * namespaces could lead to naming collisions between shared and private
+	 * namespaces if they don't use a common numbering scheme.
+	 *
+	 * If multipathing is not enabled, disk names must use the controller
+	 * instance as shared namespaces will show up as multiple block
+	 * devices.
 	 */
-	if (!nvme_mpath_set_disk_name(ns, disk->disk_name, &disk->flags))
+	if (ns->head->disk) {
+		sprintf(disk->disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
+			ctrl->instance, ns->head->instance);
+		disk->flags |= GENHD_FL_HIDDEN;
+	} else if (multipath) {
+		sprintf(disk->disk_name, "nvme%dn%d", ctrl->subsys->instance,
+			ns->head->instance);
+	} else {
 		sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
 			ns->head->instance);
+	}
 
 	if (nvme_update_ns_info(ns, id))
 		goto out_unlink_ns;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d13b81cd6225c..c97d7f843977c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -9,7 +9,7 @@
 #include <trace/events/block.h>
 #include "nvme.h"
 
-static bool multipath = true;
+bool multipath = true;
 module_param(multipath, bool, 0444);
 MODULE_PARM_DESC(multipath,
 	"turn on native support for multiple controllers per subsystem");
@@ -80,28 +80,6 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 			blk_freeze_queue_start(h->disk->queue);
 }
 
-/*
- * If multipathing is enabled we need to always use the subsystem instance
- * number for numbering our devices to avoid conflicts between subsystems that
- * have multiple controllers and thus use the multipath-aware subsystem node
- * and those that have a single controller and use the controller node
- * directly.
- */
-bool nvme_mpath_set_disk_name(struct nvme_ns *ns, char *disk_name, int *flags)
-{
-	if (!multipath)
-		return false;
-	if (!ns->head->disk) {
-		sprintf(disk_name, "nvme%dn%d", ns->ctrl->subsys->instance,
-			ns->head->instance);
-		return true;
-	}
-	sprintf(disk_name, "nvme%dc%dn%d", ns->ctrl->subsys->instance,
-		ns->ctrl->instance, ns->head->instance);
-	*flags = GENHD_FL_HIDDEN;
-	return true;
-}
-
 void nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 587d92df118b7..47badb76c654c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -770,7 +770,6 @@ void nvme_mpath_unfreeze(struct nvme_subsystem *subsys);
 void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys);
 void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
 void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys);
-bool nvme_mpath_set_disk_name(struct nvme_ns *ns, char *disk_name, int *flags);
 void nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
@@ -793,20 +792,17 @@ static inline void nvme_trace_bio_complete(struct request *req)
 		trace_block_bio_complete(ns->head->disk->queue, req->bio);
 }
 
+extern bool multipath;
 extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
 extern struct device_attribute subsys_attr_iopolicy;
 
 #else
+#define multipath false
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 {
 	return false;
 }
-static inline bool nvme_mpath_set_disk_name(struct nvme_ns *ns, char *disk_name,
-		int *flags)
-{
-	return false;
-}
 static inline void nvme_failover_req(struct request *req)
 {
 }
-- 
2.30.2


