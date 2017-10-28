From: jsmart2021@gmail.com (James Smart)
Date: Sat, 28 Oct 2017 10:21:11 -0700
Subject: [PATCH 2/5] nvmet_fc: support transport subsystem events
In-Reply-To: <20171028172114.2045-1-jsmart2021@gmail.com>
References: <20171028172114.2045-1-jsmart2021@gmail.com>
Message-ID: <20171028172114.2045-3-jsmart2021@gmail.com>

This patch adds support for transport events to signal discovery
controller changes.

Add new lldd api for a subsystem change. The lldd is to generate the
appropriate RSCN for the FC-NVME targetport.

Add transport op for discov_chg callback from the nvmet layer.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/fc.c       | 10 ++++++++++
 include/linux/nvme-fc-driver.h |  6 ++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 58e010bdda3e..590133c35d11 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2546,6 +2546,15 @@ nvmet_fc_remove_port(struct nvmet_port *port)
 		nvmet_fc_tgtport_put(tgtport);
 }
 
+static void
+nvmet_fc_port_subsys_event(struct nvmet_port *port)
+{
+	struct nvmet_fc_tgtport *tgtport = port->priv;
+
+	if (tgtport && tgtport->ops->nvme_subsystem_change)
+		tgtport->ops->nvme_subsystem_change(&tgtport->fc_target_port);
+}
+
 static struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_FC,
@@ -2554,6 +2563,7 @@ static struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
 	.remove_port		= nvmet_fc_remove_port,
 	.queue_response		= nvmet_fc_fcp_nvme_cmd_done,
 	.delete_ctrl		= nvmet_fc_delete_ctrl,
+	.discov_chg		= nvmet_fc_port_subsys_event,
 };
 
 static int __init nvmet_fc_init_module(void)
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 2be4db353937..ac9d7f190650 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -344,6 +344,11 @@ struct nvme_fc_remote_port {
  *       indicating an FC transport Aborted status.
  *       Entrypoint is Mandatory.
  *
+ * @nvme_subsystem_change:  Called by the transport to generate FC state change
+ *       notifications to NVME initiators. The state change notifications should
+ *       cause the initiator to reconnect to the discovery controller on the
+ *       targetport to look for new discovery log records.
+ *
  * @max_hw_queues:  indicates the maximum number of hw queues the LLDD
  *       supports for cpu affinitization.
  *       Value is Mandatory. Must be at least 1.
@@ -856,6 +861,7 @@ struct nvmet_fc_target_template {
 				struct nvmefc_tgt_fcp_req *fcpreq);
 	void (*defer_rcv)(struct nvmet_fc_target_port *tgtport,
 				struct nvmefc_tgt_fcp_req *fcpreq);
+	void (*nvme_subsystem_change)(struct nvmet_fc_target_port *tgtport);
 
 	u32	max_hw_queues;
 	u16	max_sgl_segments;
-- 
2.13.1
