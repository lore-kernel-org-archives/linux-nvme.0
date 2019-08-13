From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 12 Aug 2019 23:43:01 -0700
Subject: [PATCH v6 4/7] nvme: make nvme_report_ns_ids propagate error back
In-Reply-To: <20190813064304.7344-1-sagi@grimberg.me>
References: <20190813064304.7344-1-sagi@grimberg.me>
Message-ID: <20190813064304.7344-5-sagi@grimberg.me>

And make the callers check the return status and propagate
back accordingly. Also print the return status.

Reviewed-by: Hannes Reinecke <hare at suse.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4cc21567c43f..10e237f80800 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1608,9 +1608,11 @@ static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
 	blk_queue_max_write_zeroes_sectors(disk->queue, max_sectors);
 }
 
-static void nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
+static int nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
 		struct nvme_id_ns *id, struct nvme_ns_ids *ids)
 {
+	int ret = 0;
+
 	memset(ids, 0, sizeof(*ids));
 
 	if (ctrl->vs >= NVME_VS(1, 1, 0))
@@ -1621,10 +1623,12 @@ static void nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
 		 /* Don't treat error as fatal we potentially
 		  * already have a NGUID or EUI-64
 		  */
-		if (nvme_identify_ns_descs(ctrl, nsid, ids))
+		ret = nvme_identify_ns_descs(ctrl, nsid, ids);
+		if (ret)
 			dev_warn(ctrl->device,
-				 "%s: Identify Descriptors failed\n", __func__);
+				 "Identify Descriptors failed (%d)\n", ret);
 	}
+	return ret;
 }
 
 static bool nvme_ns_ids_valid(struct nvme_ns_ids *ids)
@@ -1762,7 +1766,10 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	}
 
 	__nvme_revalidate_disk(disk, id);
-	nvme_report_ns_ids(ctrl, ns->head->ns_id, id, &ids);
+	ret = nvme_report_ns_ids(ctrl, ns->head->ns_id, id, &ids);
+	if (ret)
+		goto out;
+
 	if (!nvme_ns_ids_equal(&ns->head->ids, &ids)) {
 		dev_err(ctrl->device,
 			"identifiers changed for nsid %d\n", ns->head->ns_id);
@@ -3187,7 +3194,9 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head->ns_id = nsid;
 	kref_init(&head->ref);
 
-	nvme_report_ns_ids(ctrl, nsid, id, &head->ids);
+	ret = nvme_report_ns_ids(ctrl, nsid, id, &head->ids);
+	if (ret)
+		goto out_cleanup_srcu;
 
 	ret = __nvme_check_ids(ctrl->subsys, head);
 	if (ret) {
@@ -3235,7 +3244,10 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 	} else {
 		struct nvme_ns_ids ids;
 
-		nvme_report_ns_ids(ctrl, nsid, id, &ids);
+		ret = nvme_report_ns_ids(ctrl, nsid, id, &ids);
+		if (ret)
+			goto out_unlock;
+
 		if (!nvme_ns_ids_equal(&head->ids, &ids)) {
 			dev_err(ctrl->device,
 				"IDs don't match for shared namespace %d\n",
-- 
2.17.1
