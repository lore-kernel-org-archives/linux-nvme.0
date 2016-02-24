From: keith.busch@intel.com (Keith Busch)
Date: Wed, 24 Feb 2016 09:15:57 -0700
Subject: [PATCHv4-4.5 6/7] NVMe: Don't allow unsupported flags
In-Reply-To: <1456330558-819-1-git-send-email-keith.busch@intel.com>
References: <1456330558-819-1-git-send-email-keith.busch@intel.com>
Message-ID: <1456330558-819-7-git-send-email-keith.busch@intel.com>

The command flags can change the meaning of other fields in the command
that the driver is not prepared to handle. Specifically, the user could
passthrough an SGL flag, causing the controller to misinterpret the PRP
list the driver created, potentially corrupting memory or data.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Jon Derrick <jonathan.derrick at intel.com>
---
>From previous version:

  Return an error if the user requested an unsupported flag.

 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d08b7e4..9011685 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -374,6 +374,8 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 
 	if (copy_from_user(&io, uio, sizeof(io)))
 		return -EFAULT;
+	if (io.flags)
+		return -EINVAL;
 
 	switch (io.opcode) {
 	case nvme_cmd_write:
@@ -425,6 +427,8 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return -EACCES;
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
+	if (cmd.flags)
+		return -EINVAL;
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = cmd.opcode;
-- 
2.6.2.307.g37023ba
