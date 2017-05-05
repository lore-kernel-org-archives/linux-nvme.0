From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Fri,  5 May 2017 16:13:15 -0700
Subject: [PATCH] nvme_fc: require target or discovery role for fc-nvme targets
Message-ID: <20170505231315.31622-1-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

In order to create an association, the remoteport must be
serving either a target role or a discovery role.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9993ff8d5656..e8f4cbdb9b5f 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2712,6 +2712,12 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	unsigned long flags;
 	int ret, idx;
 
+	if (!(rport->remoteport.port_role &
+		(FC_PORT_ROLE_NVME_DISCOVERY | FC_PORT_ROLE_NVME_TARGET))) {
+		ret = -EBADR;
+		goto out_fail;
+	}
+
 	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl) {
 		ret = -ENOMEM;
-- 
2.11.0
