From: hch@lst.de (Christoph Hellwig)
Date: Wed,  6 Jun 2018 16:33:05 +0200
Subject: [PATCH 04/10] nvme: remove nvme_req_needs_failover
In-Reply-To: <20180606143311.23076-1-hch@lst.de>
References: <20180606143311.23076-1-hch@lst.de>
Message-ID: <20180606143311.23076-5-hch@lst.de>

Now that we just call out to blk_path_error there isn't really any good
reason to not merge it into the only caller.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c      | 3 ++-
 drivers/nvme/host/multipath.c | 7 -------
 drivers/nvme/host/nvme.h      | 6 ------
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5e60cfeb81a9..2fb284d0f497 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -236,7 +236,8 @@ void nvme_complete_rq(struct request *req)
 	trace_nvme_complete_rq(req);
 
 	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
-		if (nvme_req_needs_failover(req, status)) {
+		if ((req->cmd_flags & REQ_NVME_MPATH) &&
+		    blk_path_error(status)) {
 			nvme_failover_req(req);
 			return;
 		}
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d7b664ae5923..7996b98befb1 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -55,13 +55,6 @@ void nvme_failover_req(struct request *req)
 	kblockd_schedule_work(&ns->head->requeue_work);
 }
 
-bool nvme_req_needs_failover(struct request *req, blk_status_t error)
-{
-	if (!(req->cmd_flags & REQ_NVME_MPATH))
-		return false;
-	return blk_path_error(error);
-}
-
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0b0a14ce0ab5..6e7f59ee79dd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -447,7 +447,6 @@ extern const struct block_device_operations nvme_ns_head_ops;
 void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 			struct nvme_ctrl *ctrl, int *flags);
 void nvme_failover_req(struct request *req);
-bool nvme_req_needs_failover(struct request *req, blk_status_t error);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns_head *head);
@@ -484,11 +483,6 @@ static inline void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 static inline void nvme_failover_req(struct request *req)
 {
 }
-static inline bool nvme_req_needs_failover(struct request *req,
-					   blk_status_t error)
-{
-	return false;
-}
 static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
 }
-- 
2.14.2
