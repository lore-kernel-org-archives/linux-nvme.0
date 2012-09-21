From: keith.busch@intel.com (Keith Busch)
Date: Fri, 21 Sep 2012 10:49:05 -0600
Subject: [PATCH] NVMe: Set result from user admin command
Message-ID: <1348246145-17312-1-git-send-email-keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index f9ad514..c64ef67 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -1235,12 +1235,17 @@ static int nvme_user_admin_cmd(struct nvme_dev *dev,
 	if (length != cmd.data_len)
 		status = -ENOMEM;
 	else
-		status = nvme_submit_admin_cmd(dev, &c, NULL);
+		status = nvme_submit_admin_cmd(dev, &c, &cmd.result);
 
 	if (cmd.data_len) {
 		nvme_unmap_user_pages(dev, cmd.opcode & 1, iod);
 		nvme_free_iod(dev, iod);
 	}
+
+	if (!status && copy_to_user(&ucmd->result, &cmd.result,
+							sizeof(cmd.result)))
+		status = -EFAULT;
+
 	return status;
 }
 
-- 
1.7.0.4
