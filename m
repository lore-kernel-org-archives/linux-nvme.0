From: jsmart2021@gmail.com (James Smart)
Date: Thu, 16 Feb 2017 18:42:20 -0800
Subject: [PATCH v2] nvmet: discovery controller to set ioccsz and iorcsz
Message-ID: <58a6630c.QwbzGsQTsh8C63rk%jsmart2021@gmail.com>


Revised the patch: add transport capsule inline size into ioccsz value

The discovery controller's Identify command handler never set these
fields leaving them zero. The host-side fc transport validates that
these values are appropriate and was killing the connection with the
controller as they were zero.

Set the controller ioccsz and iorcsz values

-- james

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/discovery.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 12f39ee..9872402 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -152,6 +152,12 @@ static void nvmet_execute_identify_disc_ctrl(struct nvmet_req *req)
 
 	strcpy(id->subnqn, ctrl->subsys->subsysnqn);
 
+	/* Max command capsule size is sqe + single page of in-capsule data */
+	id->ioccsz = cpu_to_le32((sizeof(struct nvme_command) +
+				  ctrl->ops->sqe_inline_size) / 16);
+	/* Max response capsule size is cqe */
+	id->iorcsz = cpu_to_le32(sizeof(struct nvme_completion) / 16);
+
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 
 	kfree(id);
-- 
2.5.0
