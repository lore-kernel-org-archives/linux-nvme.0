From: himanshu.madhani@cavium.com (Himanshu Madhani)
Date: Wed, 26 Sep 2018 09:25:34 -0700
Subject: [PATCH v2 4/5] qla2xxx_nvmet: Add SysFS node for FC-NVMe Target
In-Reply-To: <20180926162535.24314-1-himanshu.madhani@cavium.com>
References: <20180926162535.24314-1-himanshu.madhani@cavium.com>
Message-ID: <20180926162535.24314-5-himanshu.madhani@cavium.com>

From: Anil Gurumurthy <anil.gurumurthy@cavium.com>

This patch adds SysFS node for NVMe Target configuration

Signed-off-by: Anil Gurumurthy <anil.gurumurthy at cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
---
 drivers/scsi/qla2xxx/qla_attr.c  | 33 +++++++++++++++++++++++++++++++++
 drivers/scsi/qla2xxx/qla_gs.c    |  2 +-
 drivers/scsi/qla2xxx/qla_init.c  |  3 ++-
 drivers/scsi/qla2xxx/qla_nvmet.c |  6 +++---
 4 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_attr.c b/drivers/scsi/qla2xxx/qla_attr.c
index a31d23905753..0d2d4f33701b 100644
--- a/drivers/scsi/qla2xxx/qla_attr.c
+++ b/drivers/scsi/qla2xxx/qla_attr.c
@@ -13,6 +13,7 @@
 #include <linux/delay.h>
 
 static int qla24xx_vport_disable(struct fc_vport *, bool);
+extern void qlt_set_mode(struct scsi_qla_host *vha);
 
 /* SYSFS attributes --------------------------------------------------------- */
 
@@ -631,6 +632,37 @@ static struct bin_attribute sysfs_sfp_attr = {
 };
 
 static ssize_t
+qla2x00_sysfs_write_nvmet(struct file *filp, struct kobject *kobj,
+			struct bin_attribute *bin_attr,
+			char *buf, loff_t off, size_t count)
+{
+	struct scsi_qla_host *vha = shost_priv(dev_to_shost(container_of(kobj,
+	    struct device, kobj)));
+	struct qla_hw_data *ha = vha->hw;
+	scsi_qla_host_t *base_vha = pci_get_drvdata(ha->pdev);
+
+	ql_log(ql_log_info, vha, 0x706e,
+	    "Bringing up target mode!! vha:%p\n", vha);
+	qlt_op_target_mode = 1;
+	qlt_set_mode(base_vha);
+	set_bit(ISP_ABORT_NEEDED, &vha->dpc_flags);
+	qla2xxx_wake_dpc(vha);
+	qla2x00_wait_for_hba_online(vha);
+
+	return count;
+}
+
+static struct bin_attribute sysfs_nvmet_attr = {
+	.attr = {
+		.name = "nvmet",
+		.mode = 0200,
+	},
+	.size = 0,
+	.write = qla2x00_sysfs_write_nvmet,
+};
+
+
+static ssize_t
 qla2x00_sysfs_write_reset(struct file *filp, struct kobject *kobj,
 			struct bin_attribute *bin_attr,
 			char *buf, loff_t off, size_t count)
@@ -943,6 +975,7 @@ static struct sysfs_entry {
 	{ "issue_logo", &sysfs_issue_logo_attr, },
 	{ "xgmac_stats", &sysfs_xgmac_stats_attr, 3 },
 	{ "dcbx_tlv", &sysfs_dcbx_tlv_attr, 3 },
+	{ "nvmet", &sysfs_nvmet_attr, },
 	{ NULL },
 };
 
diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index 55dc11d91b35..ba58cfe7ff9b 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -698,7 +698,7 @@ qla2x00_rff_id(scsi_qla_host_t *vha, u8 type)
 		return (QLA_SUCCESS);
 
 	return qla_async_rffid(vha, &vha->d_id, qlt_rff_id(vha),
-	    FC4_TYPE_FCP_SCSI);
+	    type);
 }
 
 static int qla_async_rffid(scsi_qla_host_t *vha, port_id_t *d_id,
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 841541201671..01676345018f 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5523,7 +5523,8 @@ qla2x00_configure_fabric(scsi_qla_host_t *vha)
 		 * will be newer than discovery_gen. */
 		qlt_do_generation_tick(vha, &discovery_gen);
 
-		if (USE_ASYNC_SCAN(ha)) {
+		if (USE_ASYNC_SCAN(ha) && !(vha->flags.nvmet_enabled)) {
+		/* If NVME target mode is enabled, go through regular scan */
 			rval = qla24xx_async_gpnft(vha, FC4_TYPE_FCP_SCSI,
 			    NULL);
 			if (rval)
diff --git a/drivers/scsi/qla2xxx/qla_nvmet.c b/drivers/scsi/qla2xxx/qla_nvmet.c
index 5335c0618f00..cc0fb83b8f69 100644
--- a/drivers/scsi/qla2xxx/qla_nvmet.c
+++ b/drivers/scsi/qla2xxx/qla_nvmet.c
@@ -546,7 +546,7 @@ static void qla_nvmet_send_resp_ctio(struct qla_qpair *qpair,
 	case NVMET_FCOP_READDATA:
 	case NVMET_FCOP_READDATA_RSP:
 		/* Populate the CTIO resp with the SGL present in the rsp */
-		ql_log(ql_log_info, vha, 0x1100c,
+		ql_dbg(ql_dbg_nvme, vha, 0x1100c,
 			"op: %#x, ox_id=%x c_flags=%x transfer_length: %#x req_cnt: %#x, tot_dsds: %#x\n",
 			rsp_buf->op, ctio->ox_id, c_flags,
 			rsp_buf->transfer_length, req_cnt, tot_dsds);
@@ -632,7 +632,7 @@ static void qla_nvmet_send_resp_ctio(struct qla_qpair *qpair,
 
 	case NVMET_FCOP_WRITEDATA:
 		/* Send transfer rdy */
-		ql_log(ql_log_info, vha, 0x1100e,
+		ql_dbg(ql_dbg_nvme, vha, 0x1100e,
 			"FCOP_WRITE: ox_id=%x c_flags=%x transfer_length: %#x req_cnt: %#x, tot_dsds: %#x\n",
 			ctio->ox_id, c_flags, rsp_buf->transfer_length,
 			req_cnt, tot_dsds);
@@ -707,7 +707,7 @@ static void qla_nvmet_send_resp_ctio(struct qla_qpair *qpair,
 			ctio->u.nvme_status_mode1.transfer_len =
 						cpu_to_be32(ersp->xfrd_len);
 
-			ql_log(ql_log_info, vha, 0x1100f,
+			ql_dbg(ql_dbg_nvme, vha, 0x1100f,
 				"op: %#x, rsplen: %#x\n", rsp_buf->op,
 				rsp_buf->rsplen);
 		} else
-- 
2.12.0
