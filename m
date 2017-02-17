From: jsmart2021@gmail.com (James Smart)
Date: Thu, 16 Feb 2017 17:43:46 -0800
Subject: [PATCH] nvmet: discovery controller to set ioccsz and iorcsz
Message-ID: <58a65552.zF6EjNdRTHBlXYtH%jsmart2021@gmail.com>


The discovery controller's Identify command handler never set these
fields leaving them zero. The host-side fc transport validates that
these values are appropriate and was killing the connection with the
controller as they were zero.

Change them to the minimal SQE and CQE size values.

-- james

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/discovery.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 12f39ee..6adb9e9 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -152,6 +152,11 @@ static void nvmet_execute_identify_disc_ctrl(struct nvmet_req *req)
 
 	strcpy(id->subnqn, ctrl->subsys->subsysnqn);
 
+	/* Max command capsule size is sqe */
+	id->ioccsz = cpu_to_le32(sizeof(struct nvme_command) / 16);
+	/* Max response capsule size is cqe */
+	id->iorcsz = cpu_to_le32(sizeof(struct nvme_completion) / 16);
+
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 
 	kfree(id);
-- 
2.5.0
