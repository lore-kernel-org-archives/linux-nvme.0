From: jsmart2021@gmail.com (James Smart)
Date: Thu, 21 Dec 2017 08:43:35 -0800
Subject: [PATCH] nvmet_fc: correct broken add_port
Message-ID: <20171221164335.12400-1-jsmart2021@gmail.com>

prior patch to remove the add_port reference also removed the saving
of the port pointer, which mean any io had no port pointer thus was
rejected. Basically nothing works.

Restore the saving of the port pointer.

Signed-off-by: James Smart <james.smart at broadcom.com>

---
this restores operation but if the targetport is removed, it will no
longer be functional if it comes back. I will be submitting a more
involved patch for this shortly

 drivers/nvme/target/fc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index b652208cb37b..fc22415f84fa 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2522,6 +2522,7 @@ nvmet_fc_add_port(struct nvmet_port *port)
 	list_for_each_entry(tgtport, &nvmet_fc_target_list, tgt_list) {
 		if ((tgtport->fc_target_port.node_name == traddr.nn) &&
 		    (tgtport->fc_target_port.port_name == traddr.pn)) {
+			tgtport->port = port;
 			ret = 0;
 			break;
 		}
-- 
2.13.1
