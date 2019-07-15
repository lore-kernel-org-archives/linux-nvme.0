From: sashal@kernel.org (Sasha Levin)
Date: Mon, 15 Jul 2019 10:02:01 -0400
Subject: [PATCH AUTOSEL 5.1 120/219] nvme-pci: set the errno on ctrl state
 change error
In-Reply-To: <20190715140341.6443-1-sashal@kernel.org>
References: <20190715140341.6443-1-sashal@kernel.org>
Message-ID: <20190715140341.6443-120-sashal@kernel.org>

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

[ Upstream commit e71afda49335620e3d9adf56015676db33a3bd86 ]

This patch removes the confusing assignment of the variable result at
the time of declaration and sets the value in error cases next to the
places where the actual error is happening.

Here we also set the result value to -ENODEV when we fail at the final
ctrl state transition in nvme_reset_work(). Without this assignment
result will hold 0 from nvme_setup_io_queue() and on failure 0 will be
passed to he nvme_remove_dead_ctrl() from final state transition.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sasha Levin <sashal at kernel.org>
---
 drivers/nvme/host/pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 21a51a0ff4d7..9c956ff5344d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2504,11 +2504,13 @@ static void nvme_reset_work(struct work_struct *work)
 	struct nvme_dev *dev =
 		container_of(work, struct nvme_dev, ctrl.reset_work);
 	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
-	int result = -ENODEV;
+	int result;
 	enum nvme_ctrl_state new_state = NVME_CTRL_LIVE;
 
-	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
+	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING)) {
+		result = -ENODEV;
 		goto out;
+	}
 
 	/*
 	 * If we're called to reset a live controller first shut it down before
@@ -2606,6 +2608,7 @@ static void nvme_reset_work(struct work_struct *work)
 	if (!nvme_change_ctrl_state(&dev->ctrl, new_state)) {
 		dev_warn(dev->ctrl.device,
 			"failed to mark controller state %d\n", new_state);
+		result = -ENODEV;
 		goto out;
 	}
 
-- 
2.20.1
