From: keith.busch@intel.com (Keith Busch)
Date: Wed,  1 May 2013 13:07:51 -0600
Subject: [PATCH] NVMe: Free admin queue on request_irq error
In-Reply-To: <1367435271-15784-1-git-send-email-keith.busch@intel.com>
References: <1367435271-15784-1-git-send-email-keith.busch@intel.com>
Message-ID: <1367435271-15784-5-git-send-email-keith.busch@intel.com>

Fixes a potential memory leak if requesting the admin queue irq fails.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 2801875..c13ca5b 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1054,14 +1054,19 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 		}
 	}
 
-	if (result) {
-		nvme_free_queue_mem(nvmeq);
-		return result;
-	}
+	if (result)
+		goto free_q;
 
 	result = queue_request_irq(dev, nvmeq, "nvme admin");
+	if (result)
+		goto free_q;
+
 	dev->queues[0] = nvmeq;
 	return result;
+
+ free_q:
+	nvme_free_queue_mem(nvmeq);
+	return result;
 }
 
 struct nvme_iod *nvme_map_user_pages(struct nvme_dev *dev, int write,
-- 
1.7.0.4
