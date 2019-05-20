From: keith.busch@intel.com (Keith Busch)
Date: Mon, 20 May 2019 11:42:06 -0600
Subject: [PATCH] nvme: copy MTFA field from identify controller
Message-ID: <20190520174206.29464-1-keith.busch@intel.com>

From: Laine Walker-Avina <laine.walker-avina@intel.com>

We use the controller's reported maximum firmware activation time as our
timeout before resetting a controller for a failed activation notice,
but this value was never being read so we could only use the default
timeout. Copy the Identify Controller MTFA field to the corresponding
nvme_ctrl's mtfa field.

Fixes: b6dccf7fae433 (?nvme: add support for FW activation without reset?).
Signed-off-by: Laine Walker-Avina <laine.walker-avina at intel.com>
[changelog, fix endian]
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7da80f375315..eb3fb561b165 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2557,6 +2557,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 
 	ctrl->oacs = le16_to_cpu(id->oacs);
 	ctrl->oncs = le16_to_cpu(id->oncs);
+	ctrl->mtfa = le16_to_cpu(id->mtfa);
 	ctrl->oaes = le32_to_cpu(id->oaes);
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
-- 
2.14.4
