From: ming.lei@redhat.com (Ming Lei)
Date: Fri, 11 May 2018 20:29:31 +0800
Subject: [PATCH V5 7/9] nvme: pci: don't unfreeze queue until controller state
 updating succeeds
In-Reply-To: <20180511122933.27155-1-ming.lei@redhat.com>
References: <20180511122933.27155-1-ming.lei@redhat.com>
Message-ID: <20180511122933.27155-8-ming.lei@redhat.com>

If it fails to update controller state into LIVE or ADMIN_ONLY, the
controller will be removed, so not necessary to unfreeze queue any
more.

This way will make the following patch easier to not leak the
freeze couner.

Cc: James Smart <james.smart at broadcom.com>
Cc: Jianchao Wang <jianchao.w.wang at oracle.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: linux-nvme at lists.infradead.org
Cc: Laurence Oberman <loberman at redhat.com>
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---
 drivers/nvme/host/pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d880356feee2..b79c7f016489 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2370,6 +2370,7 @@ static int nvme_reset_dev(struct nvme_dev *dev)
 	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	int result = -ENODEV;
 	enum nvme_ctrl_state new_state = NVME_CTRL_LIVE;
+	bool unfreeze_queue = false;
 
 	lockdep_assert_held(&dev->ctrl.reset_lock);
 
@@ -2456,7 +2457,7 @@ static int nvme_reset_dev(struct nvme_dev *dev)
 		/* hit this only when allocate tagset fails */
 		if (nvme_dev_add(dev))
 			new_state = NVME_CTRL_ADMIN_ONLY;
-		nvme_unfreeze(&dev->ctrl);
+		unfreeze_queue = true;
 	}
 
 	result = -ENODEV;
@@ -2471,6 +2472,9 @@ static int nvme_reset_dev(struct nvme_dev *dev)
 	}
 
 	nvme_start_ctrl(&dev->ctrl);
+
+	if (unfreeze_queue)
+		nvme_unfreeze(&dev->ctrl);
 	return 0;
 
  out:
-- 
2.9.5
