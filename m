From: jsmart2021@gmail.com (James Smart)
Date: Fri,  3 Nov 2017 08:13:16 -0700
Subject: [PATCH 1/2] nvme_fc: fix localport resume using stale values
In-Reply-To: <20171103151317.16431-1-jsmart2021@gmail.com>
References: <20171103151317.16431-1-jsmart2021@gmail.com>
Message-ID: <20171103151317.16431-2-jsmart2021@gmail.com>

The localport resume was not updating the lldd ops structure. If the
lldd is unloaded and reloaded, the ops pointers will differ.

Additionally, as there are device references taken by the localport,
ensure that resume only resumes if the device matches as well.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/host/fc.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 113c30be7276..c49971d1a051 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -268,7 +268,9 @@ nvme_fc_lport_get(struct nvme_fc_lport *lport)
 
 
 static struct nvme_fc_lport *
-nvme_fc_attach_to_unreg_lport(struct nvme_fc_port_info *pinfo)
+nvme_fc_attach_to_unreg_lport(struct nvme_fc_port_info *pinfo,
+			struct nvme_fc_port_template *ops,
+			struct device *dev)
 {
 	struct nvme_fc_lport *lport;
 	unsigned long flags;
@@ -280,6 +282,11 @@ nvme_fc_attach_to_unreg_lport(struct nvme_fc_port_info *pinfo)
 		    lport->localport.port_name != pinfo->port_name)
 			continue;
 
+		if (lport->dev != dev) {
+			lport = ERR_PTR(-EXDEV);
+			goto out_done;
+		}
+
 		if (lport->localport.port_state != FC_OBJSTATE_DELETED) {
 			lport = ERR_PTR(-EEXIST);
 			goto out_done;
@@ -296,6 +303,7 @@ nvme_fc_attach_to_unreg_lport(struct nvme_fc_port_info *pinfo)
 
 		/* resume the lport */
 
+		lport->ops = ops;
 		lport->localport.port_role = pinfo->port_role;
 		lport->localport.port_id = pinfo->port_id;
 		lport->localport.port_state = FC_OBJSTATE_ONLINE;
@@ -356,7 +364,7 @@ nvme_fc_register_localport(struct nvme_fc_port_info *pinfo,
 	 * expired, we can simply re-enable the localport. Remoteports
 	 * and controller reconnections should resume naturally.
 	 */
-	newrec = nvme_fc_attach_to_unreg_lport(pinfo);
+	newrec = nvme_fc_attach_to_unreg_lport(pinfo, template, dev);
 
 	/* found an lport, but something about its state is bad */
 	if (IS_ERR(newrec)) {
-- 
2.13.1
