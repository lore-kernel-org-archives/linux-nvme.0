From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri,  2 Aug 2019 19:49:53 -0700
Subject: [PATCH rfc v2 4/6] nvme: make nvme_report_ns_ids propagate error back
In-Reply-To: <20190803024955.29508-1-sagi@grimberg.me>
References: <20190803024955.29508-1-sagi@grimberg.me>
Message-ID: <20190803024955.29508-5-sagi@grimberg.me>

And make the callers check the return status and propagate
back accordingly.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 802d1b49ecff..b561b61b35d9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1601,9 +1601,11 @@ static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
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
@@ -1614,10 +1616,12 @@ static void nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
 		 /* Don't treat error as fatal we potentially
 		  * already have a NGUID or EUI-64
 		  */
-		if (nvme_identify_ns_descs(ctrl, nsid, ids))
+		ret = nvme_identify_ns_descs(ctrl, nsid, ids);
+		if (ret)
 			dev_warn(ctrl->device,
 				 "%s: Identify Descriptors failed\n", __func__);
 	}
+	return ret;
 }
 
 static bool nvme_ns_ids_valid(struct nvme_ns_ids *ids)
@@ -1755,7 +1759,10 @@ static int nvme_revalidate_disk(struct gendisk *disk)
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
@@ -3180,7 +3187,9 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head->ns_id = nsid;
 	kref_init(&head->ref);
 
-	nvme_report_ns_ids(ctrl, nsid, id, &head->ids);
+	ret = nvme_report_ns_ids(ctrl, nsid, id, &head->ids);
+	if (ret)
+		goto out_cleanup_srcu;
 
 	ret = __nvme_check_ids(ctrl->subsys, head);
 	if (ret) {
@@ -3228,7 +3237,10 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
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
