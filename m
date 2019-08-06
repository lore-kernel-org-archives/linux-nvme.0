From: hare@suse.de (Hannes Reinecke)
Date: Tue,  6 Aug 2019 13:10:36 +0200
Subject: [PATCH] nvme: Return BLK_STS_TARGET if the DNR bit is set
Message-ID: <20190806111036.113233-1-hare@suse.de>

If the DNR bit is set we should not retry the command, even if
the standard status evaluation indicates so.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cc09b81fc7f4..c3e9254f4757 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -279,6 +279,13 @@ void nvme_complete_rq(struct request *req)
 			return;
 		}
 	}
+	/*
+	 * Any pathing error might be retried, but the DNR bit takes
+	 * precedence. So return BLK_STS_TARGET if the DNR bit is set
+	 * to avoid retrying.
+	 */
+	if (blk_path_error(status) && nvme_req(req)->status & NVME_SC_DNR)
+		status = BLK_STS_TARGET;
 	blk_mq_end_request(req, status);
 }
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
-- 
2.16.4
