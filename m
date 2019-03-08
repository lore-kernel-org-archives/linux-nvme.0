From: keith.busch@intel.com (Keith Busch)
Date: Fri,  8 Mar 2019 10:40:05 -0700
Subject: [PATCH 4/5] nvme: Fail dead namespace's entered requests
In-Reply-To: <20190308174006.5032-1-keith.busch@intel.com>
References: <20190308174006.5032-1-keith.busch@intel.com>
Message-ID: <20190308174006.5032-4-keith.busch@intel.com>

End the entered requests on a quieced queue directly rather than flush
them through the low level driver's queue_rq().

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cc5d9a83d5af..7095406bb293 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -94,6 +94,13 @@ static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
 
+static bool nvme_fail_request(struct blk_mq_hw_ctx *hctx, struct request *req,
+			      void *data, bool reserved)
+{
+	blk_mq_end_request(req, BLK_STS_IOERR);
+	return true;
+}
+
 static void nvme_set_queue_dying(struct nvme_ns *ns)
 {
 	/*
@@ -104,8 +111,7 @@ static void nvme_set_queue_dying(struct nvme_ns *ns)
 		return;
 	revalidate_disk(ns->disk);
 	blk_set_queue_dying(ns->queue);
-	/* Forcibly unquiesce queues to avoid blocking dispatch */
-	blk_mq_unquiesce_queue(ns->queue);
+	blk_mq_queue_tag_busy_iter(ns->queue, nvme_fail_request, NULL);
 }
 
 static void nvme_queue_scan(struct nvme_ctrl *ctrl)
-- 
2.14.4
