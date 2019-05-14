From: jsmart2021@gmail.com (James Smart)
Date: Tue, 14 May 2019 14:58:03 -0700
Subject: [PATCH v2 2/7] nvmet_fc: add transport discovery change event
 callback support
In-Reply-To: <20190514215808.10572-1-jsmart2021@gmail.com>
References: <20190514215808.10572-1-jsmart2021@gmail.com>
Message-ID: <20190514215808.10572-3-jsmart2021@gmail.com>

This patch adds support for the nvmet discovery_change transport op.
In turn, the transport adds it's own LLDD api callback discovery_event
op to request the LLDD to generate an RSCN for the discovery change.

Signed-off-by: James Smart <jsmart2021 at gmail.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/target/fc.c       | 11 +++++++++++
 include/linux/nvme-fc-driver.h |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 508661af0f50..1f252c9a953a 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2549,6 +2549,16 @@ nvmet_fc_remove_port(struct nvmet_port *port)
 	kfree(pe);
 }
 
+static void
+nvmet_fc_discovery_chg(struct nvmet_port *port)
+{
+	struct nvmet_fc_port_entry *pe = port->priv;
+	struct nvmet_fc_tgtport *tgtport = pe->tgtport;
+
+	if (tgtport && tgtport->ops->discovery_event)
+		tgtport->ops->discovery_event(&tgtport->fc_target_port);
+}
+
 static const struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
 	.owner			= THIS_MODULE,
 	.type			= NVMF_TRTYPE_FC,
@@ -2557,6 +2567,7 @@ static const struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops = {
 	.remove_port		= nvmet_fc_remove_port,
 	.queue_response		= nvmet_fc_fcp_nvme_cmd_done,
 	.delete_ctrl		= nvmet_fc_delete_ctrl,
+	.discovery_chg		= nvmet_fc_discovery_chg,
 };
 
 static int __init nvmet_fc_init_module(void)
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 2bb349035431..5bbcb7afef39 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -797,6 +797,11 @@ struct nvmet_fc_target_port {
  *       nvmefc_tgt_fcp_req.
  *       Entrypoint is Optional.
  *
+ * @discovery_event:  Called by the transport to generate an RSCN
+ *       change notifications to NVME initiators. The RSCN notifications
+ *       should cause the initiator to rescan the discovery controller
+ *       on the targetport.
+ *
  * @max_hw_queues:  indicates the maximum number of hw queues the LLDD
  *       supports for cpu affinitization.
  *       Value is Mandatory. Must be at least 1.
@@ -838,6 +843,7 @@ struct nvmet_fc_target_template {
 				struct nvmefc_tgt_fcp_req *fcpreq);
 	void (*defer_rcv)(struct nvmet_fc_target_port *tgtport,
 				struct nvmefc_tgt_fcp_req *fcpreq);
+	void (*discovery_event)(struct nvmet_fc_target_port *tgtport);
 
 	u32	max_hw_queues;
 	u16	max_sgl_segments;
-- 
2.13.7
