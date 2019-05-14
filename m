From: jsmart2021@gmail.com (James Smart)
Date: Tue, 14 May 2019 14:58:04 -0700
Subject: [PATCH v2 3/7] nvme-fcloop: Add support for nvmet discovery_event op
In-Reply-To: <20190514215808.10572-1-jsmart2021@gmail.com>
References: <20190514215808.10572-1-jsmart2021@gmail.com>
Message-ID: <20190514215808.10572-4-jsmart2021@gmail.com>

Update fcloop to support the discovery_event operation and
invoke a nvme rescan. In a real fc adapter, this would generate an
RSCN, which the host would receive and convert into a nvme rescan
on the remote port specified in the rscn payload.

Signed-off-by: James Smart <jsmart2021 at gmail.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/target/fcloop.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 381b5a90c48b..6ddcd090ec07 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -231,6 +231,11 @@ struct fcloop_lsreq {
 	int				status;
 };
 
+struct fcloop_rscn {
+	struct fcloop_tport		*tport;
+	struct work_struct		work;
+};
+
 enum {
 	INI_IO_START		= 0,
 	INI_IO_ACTIVE		= 1,
@@ -348,6 +353,37 @@ fcloop_xmt_ls_rsp(struct nvmet_fc_target_port *tport,
 	return 0;
 }
 
+/*
+ * Simulate reception of RSCN and converting it to a initiator transport
+ * call to rescan a remote port.
+ */
+static void
+fcloop_tgt_rscn_work(struct work_struct *work)
+{
+	struct fcloop_rscn *tgt_rscn =
+		container_of(work, struct fcloop_rscn, work);
+	struct fcloop_tport *tport = tgt_rscn->tport;
+
+	if (tport->remoteport)
+		nvme_fc_rescan_remoteport(tport->remoteport);
+	kfree(tgt_rscn);
+}
+
+void
+fcloop_tgt_discovery_evt(struct nvmet_fc_target_port *tgtport)
+{
+	struct fcloop_rscn *tgt_rscn;
+
+	tgt_rscn = kzalloc(sizeof(*tgt_rscn), GFP_KERNEL);
+	if (!tgt_rscn)
+		return;
+
+	tgt_rscn->tport = tgtport->private;
+	INIT_WORK(&tgt_rscn->work, fcloop_tgt_rscn_work);
+
+	schedule_work(&tgt_rscn->work);
+}
+
 static void
 fcloop_tfcp_req_free(struct kref *ref)
 {
@@ -839,6 +875,7 @@ static struct nvmet_fc_target_template tgttemplate = {
 	.fcp_op			= fcloop_fcp_op,
 	.fcp_abort		= fcloop_tgt_fcp_abort,
 	.fcp_req_release	= fcloop_fcp_req_release,
+	.discovery_event	= fcloop_tgt_discovery_evt,
 	.max_hw_queues		= FCLOOP_HW_QUEUES,
 	.max_sgl_segments	= FCLOOP_SGL_SEGS,
 	.max_dif_sgl_segments	= FCLOOP_SGL_SEGS,
-- 
2.13.7
