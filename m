From: ednadols@linux.microsoft.com (Edmund Nadolski)
Date: Tue, 30 Apr 2019 13:09:04 -0700
Subject: [PATCH v2 1/2] nvme: nvme_set_queue_count should use descriptive
 macros
In-Reply-To: <20190430200905.28341-1-ednadols@linux.microsoft.com>
References: <20190430200905.28341-1-ednadols@linux.microsoft.com>
Message-ID: <20190430200905.28341-2-ednadols@linux.microsoft.com>

Implement macros to set/get the number of submission and/or completion
queues requested by the Set Features command. This replaces the bit
masking/shifting code and reflects the field names used in the spec.

Signed-off-by: Edmund Nadolski <ednadols at linux.microsoft.com>
---
 drivers/nvme/host/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3dd043aa6d1f..b3804dbdcc30 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1132,9 +1132,13 @@ static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword
 	return ret;
 }
 
+#define SET_NUMQ(nsqr, ncqr)	(((nsqr) - 1) | (((ncqr) - 1) << 16))
+#define GET_NSQA(dw)		(((dw) & 0xffff) + 1)
+#define GET_NCQA(dw)		(((dw) >> 16) + 1)
+
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 {
-	u32 q_count = (*count - 1) | ((*count - 1) << 16);
+	u32 q_count = SET_NUMQ(*count, *count);
 	u32 result;
 	int status, nr_io_queues;
 
@@ -1152,7 +1156,7 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 		dev_err(ctrl->device, "Could not set queue count (%d)\n", status);
 		*count = 0;
 	} else {
-		nr_io_queues = min(result & 0xffff, result >> 16) + 1;
+		nr_io_queues = min(GET_NSQA(result), GET_NCQA(result));
 		*count = min(*count, nr_io_queues);
 	}
 
-- 
2.20.1
