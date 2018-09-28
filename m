From: himanshu.madhani@cavium.com (Himanshu Madhani)
Date: Fri, 28 Sep 2018 15:46:25 -0700
Subject: [PATCH v3 4/5] qla2xxx_nvmet: Add SysFS node for FC-NVMe Target
In-Reply-To: <20180928224626.19777-1-himanshu.madhani@cavium.com>
References: <20180928224626.19777-1-himanshu.madhani@cavium.com>
Message-ID: <20180928224626.19777-5-himanshu.madhani@cavium.com>

From: Anil Gurumurthy <anil.gurumurthy@cavium.com>

This patch adds SysFS node for NVMe Target configuration

Signed-off-by: Anil Gurumurthy <anil.gurumurthy at cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
---
 drivers/scsi/qla2xxx/qla_attr.c | 33 +++++++++++++++++++++++++++++++++
 drivers/scsi/qla2xxx/qla_gs.c   |  2 +-
 drivers/scsi/qla2xxx/qla_init.c |  3 ++-
 3 files changed, 36 insertions(+), 2 deletions(-)

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
index ea55ed972eed..cfc6818952a0 100644
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
index cad8e0185a3b..fe1c1892386a 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5526,7 +5526,8 @@ qla2x00_configure_fabric(scsi_qla_host_t *vha)
 		 * will be newer than discovery_gen. */
 		qlt_do_generation_tick(vha, &discovery_gen);
 
-		if (USE_ASYNC_SCAN(ha)) {
+		if (USE_ASYNC_SCAN(ha) && !(vha->flags.nvmet_enabled)) {
+		/* If NVME target mode is enabled, go through regular scan */
 			rval = qla24xx_async_gpnft(vha, FC4_TYPE_FCP_SCSI,
 			    NULL);
 			if (rval)
-- 
2.12.0
