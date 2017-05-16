From: jsmart2021@gmail.com (James Smart)
Date: Mon, 15 May 2017 17:10:24 -0700
Subject: [PATCH v2 10/10] nvme_fc: correct nvme status set on abort
In-Reply-To: <20170516001024.5281-1-jsmart2021@gmail.com>
References: <20170516001024.5281-1-jsmart2021@gmail.com>
Message-ID: <20170516001024.5281-11-jsmart2021@gmail.com>

correct nvme status set on abort. Patch that changed status to being actual
nvme status crossed in the night with the patch that added abort values.

Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 78973407430a..8dd06e97736d 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1375,9 +1375,9 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 	complete_rq = __nvme_fc_fcpop_chk_teardowns(ctrl, op);
 	if (!complete_rq) {
 		if (unlikely(op->flags & FCOP_FLAGS_TERMIO)) {
-			status = cpu_to_le16(NVME_SC_ABORT_REQ);
+			status = cpu_to_le16(NVME_SC_ABORT_REQ << 1);
 			if (blk_queue_dying(rq->q))
-				status |= cpu_to_le16(NVME_SC_DNR);
+				status |= cpu_to_le16(NVME_SC_DNR << 1);
 		}
 		nvme_end_request(rq, status, result);
 	} else
-- 
2.11.0
