Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F6EC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 06:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FjaLBlfQacASw0kAM16OW23QBauG3n/dx7N9nTruMJE=; b=kZ9bW1ne01TsHbbVWXoz4sPE4m
	ZHrO0RIij1mCGC/RFiv6rxNdr/vK2Md3IaSnEciY29Czn7rDVnfk/eR82ECoIfLNYacwPFQp0Y066
	eDRBq2Zv/JRciUZSzUG/CT7oO6FCKkuqJYsUKPnPgpFSMLJSy1aeinBRAv9VR+FtARh9SWXT49St7
	u0NkiAXedtFq/hd6K6T6n/jVvzjAse/fotTmi2+BeObUs8YTUHXB5P6BYZrB9VZ6YxSh2vADBpdHe
	IK6Hi6Au4paPtjpjgYXy2z8kfwkHGL3R7yhQLKWT1MIiHQ9QE6YpoRzSByuTf8A4a8ihri2YfyYon
	dGBIXQvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEPQZ-000oGV-8w; Thu, 21 Jul 2022 06:12:51 +0000
Received: from [2001:4bb8:18a:6f7a:1b03:4d0e:b929:ebb2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEPHb-000djH-JS; Thu, 21 Jul 2022 06:03:36 +0000
From: Christoph Hellwig <hch@lst.de>
To: Joel Granados <j.granados@samsung.com>,
	kbusch@kernel.org,
	sagi@grimberg.me
Cc: joshi.k@samsung.com,
	linux-nvme@lists.infradead.org,
	gost.dev@samsung.com,
	k.jensen@samsung.com,
	=?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH 4/6] nvme: refactor namespace probing
Date: Thu, 21 Jul 2022 08:03:18 +0200
Message-Id: <20220721060320.1704646-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220721060320.1704646-1-hch@lst.de>
References: <20220721060320.1704646-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Change nvme_ns_scan to gather all information needed for generic
namespace setup into a nvme_ns_info structure.  This structure is filled
from the Command Set Idependent Identify Namespace data structure if
it is available or else the legacy Identify namespace structure.

With that everything related to the NVM command set (and the ZNS command
set derived from it) can be encapsulated in the nvme_update_ns_info_block
function while keeping the rest of the namespace probing generic.

The downside is that we now always issue two Identify Namespace calls for
each probed namespace instead of usually just a single one previously.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Javier González <javier.gonz@samsung.com>
---
 drivers/nvme/host/core.c | 230 +++++++++++++++++++++------------------
 1 file changed, 125 insertions(+), 105 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5ba09d010daba..6169737c233b2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -31,6 +31,14 @@
 
 #define NVME_MINORS		(1U << MINORBITS)
 
+struct nvme_ns_info {
+	struct nvme_ns_ids ids;
+	u32 nsid;
+	__le32 anagrpid;
+	bool is_shared;
+	bool is_ready;
+};
+
 unsigned int admin_timeout = 60;
 module_param(admin_timeout, uint, 0644);
 MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands");
@@ -1342,8 +1350,8 @@ static int nvme_process_ns_desc(struct nvme_ctrl *ctrl, struct nvme_ns_ids *ids,
 	}
 }
 
-static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
-		struct nvme_ns_ids *ids)
+static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl,
+		struct nvme_ns_info *info)
 {
 	struct nvme_command c = { };
 	bool csi_seen = false;
@@ -1356,7 +1364,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 		return 0;
 
 	c.identify.opcode = nvme_admin_identify;
-	c.identify.nsid = cpu_to_le32(nsid);
+	c.identify.nsid = cpu_to_le32(info->nsid);
 	c.identify.cns = NVME_ID_CNS_NS_DESC_LIST;
 
 	data = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
@@ -1368,7 +1376,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (status) {
 		dev_warn(ctrl->device,
 			"Identify Descriptors failed (nsid=%u, status=0x%x)\n",
-			nsid, status);
+			info->nsid, status);
 		goto free_data;
 	}
 
@@ -1378,7 +1386,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 		if (cur->nidl == 0)
 			break;
 
-		len = nvme_process_ns_desc(ctrl, ids, cur, &csi_seen);
+		len = nvme_process_ns_desc(ctrl, &info->ids, cur, &csi_seen);
 		if (len < 0)
 			break;
 
@@ -1387,7 +1395,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 
 	if (nvme_multi_css(ctrl) && !csi_seen) {
 		dev_warn(ctrl->device, "Command set not reported for nsid:%d\n",
-			 nsid);
+			 info->nsid);
 		status = -EINVAL;
 	}
 
@@ -1397,7 +1405,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 }
 
 static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
-			struct nvme_ns_ids *ids, struct nvme_id_ns **id)
+			struct nvme_id_ns **id)
 {
 	struct nvme_command c = { };
 	int error;
@@ -1420,51 +1428,64 @@ static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	error = NVME_SC_INVALID_NS | NVME_SC_DNR;
 	if ((*id)->ncap == 0) /* namespace not allocated or attached */
 		goto out_free_id;
+	return 0;
 
+out_free_id:
+	kfree(*id);
+	return error;
+}
 
+static int nvme_ns_info_from_identify(struct nvme_ctrl *ctrl,
+		struct nvme_ns_info *info)
+{
+	struct nvme_ns_ids *ids = &info->ids;
+	struct nvme_id_ns *id;
+	int ret;
+
+	ret = nvme_identify_ns(ctrl, info->nsid, &id);
+	if (ret)
+		return ret;
+	info->anagrpid = id->anagrpid;
+	info->is_shared = id->nmic & NVME_NS_NMIC_SHARED;
+	info->is_ready = true;
 	if (ctrl->quirks & NVME_QUIRK_BOGUS_NID) {
 		dev_info(ctrl->device,
 			 "Ignoring bogus Namespace Identifiers\n");
 	} else {
 		if (ctrl->vs >= NVME_VS(1, 1, 0) &&
 		    !memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
-			memcpy(ids->eui64, (*id)->eui64, sizeof(ids->eui64));
+			memcpy(ids->eui64, id->eui64, sizeof(ids->eui64));
 		if (ctrl->vs >= NVME_VS(1, 2, 0) &&
 		    !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
-			memcpy(ids->nguid, (*id)->nguid, sizeof(ids->nguid));
+			memcpy(ids->nguid, id->nguid, sizeof(ids->nguid));
 	}
-
+	kfree(id);
 	return 0;
-
-out_free_id:
-	kfree(*id);
-	return error;
 }
 
-static int nvme_identify_ns_cs_indep(struct nvme_ctrl *ctrl, unsigned nsid,
-			struct nvme_id_ns_cs_indep **id)
+static int nvme_ns_info_from_id_cs_indep(struct nvme_ctrl *ctrl,
+		struct nvme_ns_info *info)
 {
+	struct nvme_id_ns_cs_indep *id;
 	struct nvme_command c = {
 		.identify.opcode	= nvme_admin_identify,
-		.identify.nsid		= cpu_to_le32(nsid),
+		.identify.nsid		= cpu_to_le32(info->nsid),
 		.identify.cns		= NVME_ID_CNS_NS_CS_INDEP,
 	};
 	int ret;
 
-	*id = kmalloc(sizeof(**id), GFP_KERNEL);
-	if (!*id)
+	id = kmalloc(sizeof(*id), GFP_KERNEL);
+	if (!id)
 		return -ENOMEM;
 
-	ret = nvme_submit_sync_cmd(ctrl->admin_q, &c, *id, sizeof(**id));
-	if (ret) {
-		dev_warn(ctrl->device,
-			 "Identify namespace (CS independent) failed (%d)\n",
-			 ret);
-		kfree(*id);
-		return ret;
+	ret = nvme_submit_sync_cmd(ctrl->admin_q, &c, id, sizeof(*id));
+	if (!ret) {
+		info->anagrpid = id->anagrpid;
+		info->is_shared = id->nmic & NVME_NS_NMIC_SHARED;
+		info->is_ready = id->nstat & NVME_NSTAT_NRDY;
 	}
-
-	return 0;
+	kfree(id);
+	return ret;
 }
 
 static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
@@ -1925,12 +1946,19 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
 	blk_queue_chunk_sectors(ns->queue, iob);
 }
 
-static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
+static int nvme_update_ns_info_block(struct nvme_ns *ns,
+		struct nvme_ns_info *info)
 {
-	unsigned lbaf = nvme_lbaf_index(id->flbas);
+	struct nvme_id_ns *id;
+	unsigned lbaf;
 	int ret;
 
+	ret = nvme_identify_ns(ns->ctrl, info->nsid, &id);
+	if (ret)
+		return ret;
+
 	blk_mq_freeze_queue(ns->disk->queue);
+	lbaf = nvme_lbaf_index(id->flbas);
 	ns->lba_shift = id->lbaf[lbaf].ds;
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
 
@@ -1981,9 +2009,30 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 		set_bit(NVME_NS_READY, &ns->flags);
 		ret = 0;
 	}
+	kfree(id);
 	return ret;
 }
 
+static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
+{
+	switch (info->ids.csi) {
+	case NVME_CSI_ZNS:
+		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
+			dev_warn(ns->ctrl->device,
+	"nsid %u not supported without CONFIG_BLK_DEV_ZONED\n",
+				info->nsid);
+			return -ENODEV;
+		}
+		return nvme_update_ns_info_block(ns, info);
+	case NVME_CSI_NVM:
+		return nvme_update_ns_info_block(ns, info);
+	default:
+		dev_warn(ns->ctrl->device, "unknown csi %u for nsid %u\n",
+			info->ids.csi, info->nsid);
+		return -ENODEV;
+	}
+}
+
 static char nvme_pr_type(enum pr_type type)
 {
 	switch (type) {
@@ -3913,7 +3962,7 @@ static int nvme_add_ns_cdev(struct nvme_ns *ns)
 }
 
 static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
-		unsigned nsid, struct nvme_ns_ids *ids)
+		struct nvme_ns_info *info)
 {
 	struct nvme_ns_head *head;
 	size_t size = sizeof(*head);
@@ -3935,8 +3984,9 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	if (ret)
 		goto out_ida_remove;
 	head->subsys = ctrl->subsys;
-	head->ns_id = nsid;
-	head->ids = *ids;
+	head->ns_id = info->nsid;
+	head->ids = info->ids;
+	head->shared = info->is_shared;
 	kref_init(&head->ref);
 
 	if (head->ids.csi) {
@@ -3993,55 +4043,54 @@ static int nvme_global_check_duplicate_ids(struct nvme_subsystem *this,
 	return ret;
 }
 
-static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
-		struct nvme_ns_ids *ids, bool is_shared)
+static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	struct nvme_ns_head *head = NULL;
 	int ret;
 
-	ret = nvme_global_check_duplicate_ids(ctrl->subsys, ids);
+	ret = nvme_global_check_duplicate_ids(ctrl->subsys, &info->ids);
 	if (ret) {
 		dev_err(ctrl->device,
-			"globally duplicate IDs for nsid %d\n", nsid);
+			"globally duplicate IDs for nsid %d\n", info->nsid);
 		nvme_print_device_info(ctrl);
 		return ret;
 	}
 
 	mutex_lock(&ctrl->subsys->lock);
-	head = nvme_find_ns_head(ctrl, nsid);
+	head = nvme_find_ns_head(ctrl, info->nsid);
 	if (!head) {
-		ret = nvme_subsys_check_duplicate_ids(ctrl->subsys, ids);
+		ret = nvme_subsys_check_duplicate_ids(ctrl->subsys, &info->ids);
 		if (ret) {
 			dev_err(ctrl->device,
 				"duplicate IDs in subsystem for nsid %d\n",
-				nsid);
+				info->nsid);
 			goto out_unlock;
 		}
-		head = nvme_alloc_ns_head(ctrl, nsid, ids);
+		head = nvme_alloc_ns_head(ctrl, info);
 		if (IS_ERR(head)) {
 			ret = PTR_ERR(head);
 			goto out_unlock;
 		}
-		head->shared = is_shared;
 	} else {
 		ret = -EINVAL;
-		if (!is_shared || !head->shared) {
+		if (!info->is_shared || !head->shared) {
 			dev_err(ctrl->device,
-				"Duplicate unshared namespace %d\n", nsid);
+				"Duplicate unshared namespace %d\n",
+				info->nsid);
 			goto out_put_ns_head;
 		}
-		if (!nvme_ns_ids_equal(&head->ids, ids)) {
+		if (!nvme_ns_ids_equal(&head->ids, &info->ids)) {
 			dev_err(ctrl->device,
 				"IDs don't match for shared namespace %d\n",
-					nsid);
+					info->nsid);
 			goto out_put_ns_head;
 		}
 
 		if (!multipath && !list_empty(&head->list)) {
 			dev_warn(ctrl->device,
 				"Found shared namespace %d, but multipathing not supported.\n",
-				nsid);
+				info->nsid);
 			dev_warn_once(ctrl->device,
 				"Support for shared namespaces without CONFIG_NVME_MULTIPATH is deprecated and will be removed in Linux 6.0\n.");
 		}
@@ -4095,20 +4144,15 @@ static void nvme_ns_add_to_ctrl_list(struct nvme_ns *ns)
 	list_add(&ns->list, &ns->ctrl->namespaces);
 }
 
-static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
-		struct nvme_ns_ids *ids)
+static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 {
 	struct nvme_ns *ns;
 	struct gendisk *disk;
-	struct nvme_id_ns *id;
 	int node = ctrl->numa_node;
 
-	if (nvme_identify_ns(ctrl, nsid, ids, &id))
-		return;
-
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
-		goto out_free_id;
+		return;
 
 	disk = blk_mq_alloc_disk(ctrl->tagset, ns);
 	if (IS_ERR(disk))
@@ -4129,7 +4173,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	ns->ctrl = ctrl;
 	kref_init(&ns->kref);
 
-	if (nvme_init_ns_head(ns, nsid, ids, id->nmic & NVME_NS_NMIC_SHARED))
+	if (nvme_init_ns_head(ns, info))
 		goto out_cleanup_disk;
 
 	/*
@@ -4155,7 +4199,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 			ns->head->instance);
 	}
 
-	if (nvme_update_ns_info(ns, id))
+	if (nvme_update_ns_info(ns, info))
 		goto out_unlink_ns;
 
 	down_write(&ctrl->namespaces_rwsem);
@@ -4169,9 +4213,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_add_ns_cdev(ns);
 
-	nvme_mpath_add_disk(ns, id->anagrpid);
+	nvme_mpath_add_disk(ns, info->anagrpid);
 	nvme_fault_inject_init(&ns->fault_inject, ns->disk->disk_name);
-	kfree(id);
 
 	return;
 
@@ -4191,8 +4234,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 	blk_cleanup_disk(disk);
  out_free_ns:
 	kfree(ns);
- out_free_id:
-	kfree(id);
 }
 
 static void nvme_ns_remove(struct nvme_ns *ns)
@@ -4251,29 +4292,21 @@ static void nvme_ns_remove_by_nsid(struct nvme_ctrl *ctrl, u32 nsid)
 	}
 }
 
-static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
+static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_info *info)
 {
-	struct nvme_id_ns *id;
 	int ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
 
 	if (test_bit(NVME_NS_DEAD, &ns->flags))
 		goto out;
 
-	ret = nvme_identify_ns(ns->ctrl, ns->head->ns_id, ids, &id);
-	if (ret)
-		goto out;
-
 	ret = NVME_SC_INVALID_NS | NVME_SC_DNR;
-	if (!nvme_ns_ids_equal(&ns->head->ids, ids)) {
+	if (!nvme_ns_ids_equal(&ns->head->ids, &info->ids)) {
 		dev_err(ns->ctrl->device,
 			"identifiers changed for nsid %d\n", ns->head->ns_id);
-		goto out_free_id;
+		goto out;
 	}
 
-	ret = nvme_update_ns_info(ns, id);
-
-out_free_id:
-	kfree(id);
+	ret = nvme_update_ns_info(ns, info);
 out:
 	/*
 	 * Only remove the namespace if we got a fatal error back from the
@@ -4287,57 +4320,44 @@ static void nvme_validate_ns(struct nvme_ns *ns, struct nvme_ns_ids *ids)
 
 static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
-	struct nvme_ns_ids ids = { };
-	struct nvme_id_ns_cs_indep *id;
+	struct nvme_ns_info info = { .nsid = nsid };
 	struct nvme_ns *ns;
-	bool ready = true;
 
-	if (nvme_identify_ns_descs(ctrl, nsid, &ids))
+	if (nvme_identify_ns_descs(ctrl, &info))
 		return;
 
-	if (ids.csi != NVME_CSI_NVM && !nvme_multi_css(ctrl)) {
+	if (info.ids.csi != NVME_CSI_NVM && !nvme_multi_css(ctrl)) {
 		dev_warn(ctrl->device,
 			"command set not reported for nsid: %d\n", nsid);
 		return;
 	}
 
 	/*
-	 * Check if the namespace is ready.  If not ignore it, we will get an
-	 * AEN once it becomes ready and restart the scan.
+	 * If available try to use the Command Set Idependent Identify Namespace
+	 * data structure to find all the generic information that is needed to
+	 * set up a namespace.  If not fall back to the legacy version.
 	 */
-	if ((ctrl->cap & NVME_CAP_CRMS_CRIMS) &&
-	    !nvme_identify_ns_cs_indep(ctrl, nsid, &id)) {
-		ready = id->nstat & NVME_NSTAT_NRDY;
-		kfree(id);
+	if (ctrl->cap & NVME_CAP_CRMS_CRIMS) {
+		if (nvme_ns_info_from_id_cs_indep(ctrl, &info))
+			return;
+	} else {
+		if (nvme_ns_info_from_identify(ctrl, &info))
+			return;
 	}
 
-	if (!ready)
+	/*
+	 * Ignore the namespace if it is not ready. We will get an AEN once it
+	 * becomes ready and restart the scan.
+	 */
+	if (!info.is_ready)
 		return;
 
 	ns = nvme_find_get_ns(ctrl, nsid);
 	if (ns) {
-		nvme_validate_ns(ns, &ids);
+		nvme_validate_ns(ns, &info);
 		nvme_put_ns(ns);
-		return;
-	}
-
-	switch (ids.csi) {
-	case NVME_CSI_NVM:
-		nvme_alloc_ns(ctrl, nsid, &ids);
-		break;
-	case NVME_CSI_ZNS:
-		if (!IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
-			dev_warn(ctrl->device,
-				"nsid %u not supported without CONFIG_BLK_DEV_ZONED\n",
-				nsid);
-			break;
-		}
-		nvme_alloc_ns(ctrl, nsid, &ids);
-		break;
-	default:
-		dev_warn(ctrl->device, "unknown csi %u for nsid %u\n",
-			ids.csi, nsid);
-		break;
+	} else {
+		nvme_alloc_ns(ctrl, &info);
 	}
 }
 
-- 
2.30.2


