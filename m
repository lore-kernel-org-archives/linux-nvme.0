From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 4 Apr 2018 14:59:37 +0300
Subject: [RFC PATCH 2/8] nvme-core: export existing ctrl and ns interfaces
In-Reply-To: <20180330065747.20962-3-chaitanya.kulkarni@wdc.com>
References: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
 <20180330065747.20962-3-chaitanya.kulkarni@wdc.com>
Message-ID: <02e99d9a-7c33-c853-d2b4-c68fce493eac@grimberg.me>



On 03/30/2018 09:57 AM, Chaitanya Kulkarni wrote:
> We export existing nvme ctrl and ns management APIs so that
> target passthru code can manage the nvme ctrl.
> 
> This is a preparation patch for implementing NVMe Over Fabric
> target passthru feature.

I'd only export only the passthru portion of nvme_user_cmd and use
that.

Something like the (untested):
--
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 383c4d0bc5ff..fce6b090a3a0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1162,22 +1162,14 @@ static void nvme_passthru_end(struct nvme_ctrl 
*ctrl, u32 effects)
                 nvme_queue_scan(ctrl);
  }

-static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-                       struct nvme_passthru_cmd __user *ucmd)
+int nvme_execute_passtru_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+               struct nvme_passthru_cmd *cmd)
  {
-       struct nvme_passthru_cmd cmd;
         struct nvme_command c;
         unsigned timeout = 0;
         u32 effects;
         int status;

-       if (!capable(CAP_SYS_ADMIN))
-               return -EACCES;
-       if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
-               return -EFAULT;
-       if (cmd.flags)
-               return -EINVAL;
-
         memset(&c, 0, sizeof(c));
         c.common.opcode = cmd.opcode;
         c.common.flags = cmd.flags;
@@ -1201,6 +1193,24 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, 
struct nvme_ns *ns,
                         0, &cmd.result, timeout);
         nvme_passthru_end(ctrl, effects);

+       return status;
+}
+EXPORT_SYMBOL_GPL(nvme_execute_passtru_cmd);
+
+static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+                       struct nvme_passthru_cmd __user *ucmd)
+{
+       struct nvme_passthru_cmd cmd;
+       int status;
+
+       if (!capable(CAP_SYS_ADMIN))
+               return -EACCES;
+       if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
+               return -EFAULT;
+       if (cmd.flags)
+               return -EINVAL;
+
+       status = nvme_execute_passtru_cmd(ctrl, ns, cmd);
         if (status >= 0) {
                 if (put_user(cmd.result, &ucmd->result))
                         return -EFAULT;
--
