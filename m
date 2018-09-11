From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Tue, 11 Sep 2018 17:48:13 +0800
Subject: [PATCH 3/4] nvme-pci: unquiesce queues after update nr_hw_queues
In-Reply-To: <1536659294-2321-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1536659294-2321-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1536659294-2321-4-git-send-email-jianchao.w.wang@oracle.com>

updating nr_hw_queues uses bio retrieving to drain the queues, it
requires the queues to be quiesced to prevent requests from being
issued to dying hw queue, so we cannot unquiesce the queues before
that.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d668682..9e60edf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2327,11 +2327,13 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_remove_namespaces(&dev->ctrl);
 		new_state = NVME_CTRL_ADMIN_ONLY;
 	} else {
-		nvme_start_queues(&dev->ctrl);
-		nvme_wait_freeze(&dev->ctrl);
+
 		/* hit this only when allocate tagset fails */
 		if (nvme_dev_add(dev))
 			new_state = NVME_CTRL_ADMIN_ONLY;
+
+		nvme_start_queues(&dev->ctrl);
+		nvme_wait_freeze(&dev->ctrl);
 		nvme_unfreeze(&dev->ctrl);
 	}
 
-- 
2.7.4
