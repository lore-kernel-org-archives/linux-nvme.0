From: keith.busch@intel.com (Keith Busch)
Date: Fri, 19 Apr 2013 14:11:05 -0600
Subject: [PATCH 1/2] NVMe: Clear timed out IO
In-Reply-To: <1366402266-10131-1-git-send-email-keith.busch@intel.com>
References: <1366402266-10131-1-git-send-email-keith.busch@intel.com>
Message-ID: <1366402266-10131-2-git-send-email-keith.busch@intel.com>

This cancels a timed out IO only once and clears the timeout so we
don't log the same problem every second. This may also prove useful if
we implement async events, which don't have timeouts.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 40908a0..e64beaa 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -878,9 +878,11 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 			.status = cpu_to_le16(NVME_SC_ABORT_REQ << 1),
 		};
 
-		if (timeout && !time_after(now, info[cmdid].timeout))
+		if (timeout && (!time_after(now, info[cmdid].timeout) ||
+							!info[cmdid].timeout))
 			continue;
 		dev_warn(nvmeq->q_dmadev, "Cancelling I/O %d\n", cmdid);
+		info[cmdid].timeout = 0;
 		ctx = cancel_cmdid(nvmeq, cmdid, &fn);
 		fn(nvmeq->dev, ctx, &cqe);
 	}
-- 
1.7.0.4
