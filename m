From: hare@suse.de (Hannes Reinecke)
Date: Wed,  7 Aug 2019 09:12:08 +0200
Subject: [PATCHv2] nvme: Return BLK_STS_TARGET if the DNR bit is set
Message-ID: <20190807071208.101882-1-hare@suse.de>

If the DNR bit is set we should not retry the command, even if
the standard status evaluation indicates so.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cc09b81fc7f4..2c6c9460adea 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -274,6 +274,10 @@ void nvme_complete_rq(struct request *req)
 			return;
 		}
 
+		if (nvme_req(req)->status & NVME_SC_DNR) {
+			blk_mq_end_request(req, BLK_STS_TARGET);
+			return;
+		}
 		if (!blk_queue_dying(req->q)) {
 			nvme_retry_req(req);
 			return;
-- 
2.16.4
