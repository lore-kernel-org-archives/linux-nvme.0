From: roland@kernel.org (Roland Dreier)
Date: Thu, 19 Jul 2018 20:07:59 -0700
Subject: [PATCH] nvme: Fix handling of metadata_len for NVME_IOCTL_IO_CMD
Message-ID: <20180720030759.30254-1-roland@kernel.org>

From: Roland Dreier <roland@purestorage.com>

The old code in nvme_user_cmd() passed the userspace virtual address
from nvme_passthru_cmd.metadata as the length of the metadata buffer
as well as the address to nvme_submit_user_cmd().

Signed-off-by: Roland Dreier <roland at purestorage.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 46df030b2c3f..4e2a48b574cc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1218,7 +1218,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	effects = nvme_passthru_start(ctrl, ns, cmd.opcode);
 	status = nvme_submit_user_cmd(ns ? ns->queue : ctrl->admin_q, &c,
 			(void __user *)(uintptr_t)cmd.addr, cmd.data_len,
-			(void __user *)(uintptr_t)cmd.metadata, cmd.metadata,
+			(void __user *)(uintptr_t)cmd.metadata, cmd.metadata_len,
 			0, &cmd.result, timeout);
 	nvme_passthru_end(ctrl, effects);
 
-- 
2.17.1
