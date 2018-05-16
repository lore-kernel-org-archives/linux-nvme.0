From: ming.lei@redhat.com (Ming Lei)
Date: Wed, 16 May 2018 12:03:11 +0800
Subject: [PATCH V6 09/11] nvme: pci: don't unfreeze queue until controller
 state updating succeeds
In-Reply-To: <20180516040313.13596-1-ming.lei@redhat.com>
References: <20180516040313.13596-1-ming.lei@redhat.com>
Message-ID: <20180516040313.13596-10-ming.lei@redhat.com>

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
index 634fd7f17950..4236d79e3643 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2396,6 +2396,7 @@ static int nvme_reset_dev(struct nvme_dev *dev)
 	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	int result = -ENODEV;
 	enum nvme_ctrl_state new_state = NVME_CTRL_LIVE;
+	bool unfreeze_queue = false;
 
 	lockdep_assert_held(&dev->ctrl.reset_lock);
 
@@ -2482,7 +2483,7 @@ static int nvme_reset_dev(struct nvme_dev *dev)
 		/* hit this only when allocate tagset fails */
 		if (nvme_dev_add(dev))
 			new_state = NVME_CTRL_ADMIN_ONLY;
-		nvme_unfreeze(&dev->ctrl);
+		unfreeze_queue = true;
 	}
 
 	result = -ENODEV;
@@ -2497,6 +2498,9 @@ static int nvme_reset_dev(struct nvme_dev *dev)
 	}
 
 	nvme_start_ctrl(&dev->ctrl);
+
+	if (unfreeze_queue)
+		nvme_unfreeze(&dev->ctrl);
 	return 0;
 
  out:
-- 
2.9.5
