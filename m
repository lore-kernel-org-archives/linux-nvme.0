From: jsmart2021@gmail.com (James Smart)
Date: Tue, 19 Sep 2017 15:13:11 -0700
Subject: [PATCH] nvmet_fc: on port remove call put outside lock
Message-ID: <20170919221311.32384-1-jsmart2021@gmail.com>

Avoid calling the put routine, as it may traverse to free routines
while holding the target lock.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/fc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index c48c83d97e30..6850672ad2a2 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2530,13 +2530,17 @@ nvmet_fc_remove_port(struct nvmet_port *port)
 {
 	struct nvmet_fc_tgtport *tgtport = port->priv;
 	unsigned long flags;
+	bool matched = false;
 
 	spin_lock_irqsave(&nvmet_fc_tgtlock, flags);
 	if (tgtport->port == port) {
-		nvmet_fc_tgtport_put(tgtport);
+		matched = true;
 		tgtport->port = NULL;
 	}
 	spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
+
+	if (matched)
+		nvmet_fc_tgtport_put(tgtport);
 }
 
 static struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
-- 
2.13.1
