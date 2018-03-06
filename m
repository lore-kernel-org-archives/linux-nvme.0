From: jsmart2021@gmail.com (James Smart)
Date: Mon,  5 Mar 2018 20:55:49 -0800
Subject: [PATCH] nvme_fc: on remoteport reuse, set new nport_id and role.
Message-ID: <20180306045549.3616-1-jsmart2021@gmail.com>

When reattaching to a removed remoteport that has not yet been
fully deleted as it's waiting for reconnect timeouts, be sure to
re-set the ports nport id and role.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index fc00c609c695..083d163487a6 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -590,6 +590,8 @@ nvme_fc_attach_to_suspended_rport(struct nvme_fc_lport *lport,
 			return ERR_PTR(-ESTALE);
 		}
 
+		rport->remoteport.port_role = pinfo->port_role;
+		rport->remoteport.port_id = pinfo->port_id;
 		rport->remoteport.port_state = FC_OBJSTATE_ONLINE;
 		rport->dev_loss_end = 0;
 
-- 
2.13.1
