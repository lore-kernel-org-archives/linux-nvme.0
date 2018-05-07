From: jsmart2021@gmail.com (James Smart)
Date: Mon,  7 May 2018 15:55:58 -0700
Subject: [PATCH] nvme: block ioctls if controller not in a live state
Message-ID: <20180507225558.5009-1-jsmart2021@gmail.com>

Rather than allow ioctl-based admin cmds to get intermixed on the admin
queue with commands being used to initialize a controller or io commands
to go to a controller in reconnect thus possibly hanging, reject them
if the controller isn't in the LIVE state. Reject with an -EAGAIN status
so that the app knows it could retry.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a3771c5729f5..cfa03b68d2b8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1041,6 +1041,8 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 		return -EFAULT;
 	if (io.flags)
 		return -EINVAL;
+	if (ns->ctrl->state != NVME_CTRL_LIVE)
+		return -EAGAIN;
 
 	switch (io.opcode) {
 	case nvme_cmd_write:
@@ -1174,6 +1176,8 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return -EFAULT;
 	if (cmd.flags)
 		return -EINVAL;
+	if (ctrl->state != NVME_CTRL_LIVE)
+		return -EAGAIN;
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cmd.opcode;
-- 
2.13.1
