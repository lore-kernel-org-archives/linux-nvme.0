From: jsmart2021@gmail.com (James Smart)
Date: Mon, 13 May 2019 15:43:14 -0700
Subject: [PATCH 7/7] lpfc: Add sysfs interface to post NVME RSCN
In-Reply-To: <20190513224314.24169-1-jsmart2021@gmail.com>
References: <20190513224314.24169-1-jsmart2021@gmail.com>
Message-ID: <20190513224314.24169-8-jsmart2021@gmail.com>

To support scenarios which aren't bound to nvmetcli add port scenarios,
which is currently where the nvmet_fc transport invokes the discovery
event callbacks, a syfs attribute is added to lpfc which can be written
to cause an RSCN to be generated for the nport.

Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
Signed-off-by: James Smart <jsmart2021 at gmail.com>
---
 drivers/scsi/lpfc/lpfc.h      |  1 +
 drivers/scsi/lpfc/lpfc_attr.c | 60 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 9246e0212a86..5ef0efb830d2 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -820,6 +820,7 @@ struct lpfc_hba {
 	uint32_t cfg_use_msi;
 	uint32_t cfg_auto_imax;
 	uint32_t cfg_fcp_imax;
+	uint32_t cfg_force_rscn;
 	uint32_t cfg_cq_poll_threshold;
 	uint32_t cfg_cq_max_proc_limit;
 	uint32_t cfg_fcp_cpu_map;
diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index ce3e541434dc..8b09e82ddfcf 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -4912,6 +4912,64 @@ static DEVICE_ATTR(lpfc_req_fw_upgrade, S_IRUGO | S_IWUSR,
 		   lpfc_request_firmware_upgrade_store);
 
 /**
+ * lpfc_force_rscn_store
+ *
+ * @dev: class device that is converted into a Scsi_host.
+ * @attr: device attribute, not used.
+ * @buf: unused string
+ * @count: unused variable.
+ *
+ * Description:
+ * Force the switch to send a RSCN to all other NPorts in our zone
+ * If we are direct connect pt2pt, build the RSCN command ourself
+ * and send to the other NPort. Not supported for private loop.
+ *
+ * Returns:
+ * 0      - on success
+ * -EIO   - if command is not sent
+ **/
+static ssize_t
+lpfc_force_rscn_store(struct device *dev, struct device_attribute *attr,
+		      const char *buf, size_t count)
+{
+	struct Scsi_Host *shost = class_to_shost(dev);
+	struct lpfc_vport *vport = (struct lpfc_vport *)shost->hostdata;
+	int i;
+
+	i = lpfc_issue_els_rscn(vport, 0);
+	if (i)
+		return -EIO;
+	return strlen(buf);
+}
+
+/*
+ * lpfc_force_rscn: Force an RSCN to be sent to all remote NPorts
+ * connected to  the HBA.
+ *
+ * Value range is any ascii value
+ */
+static int lpfc_force_rscn;
+module_param(lpfc_force_rscn, int, 0644);
+MODULE_PARM_DESC(lpfc_force_rscn,
+		 "Force an RSCN to be sent to all remote NPorts");
+lpfc_param_show(force_rscn)
+
+/**
+ * lpfc_force_rscn_init - Force an RSCN to be sent to all remote NPorts
+ * @phba: lpfc_hba pointer.
+ * @val: unused value.
+ *
+ * Returns:
+ * zero if val saved.
+ **/
+static int
+lpfc_force_rscn_init(struct lpfc_hba *phba, int val)
+{
+	return 0;
+}
+static DEVICE_ATTR_RW(lpfc_force_rscn);
+
+/**
  * lpfc_fcp_imax_store
  *
  * @dev: class device that is converted into a Scsi_host.
@@ -5911,6 +5969,7 @@ struct device_attribute *lpfc_hba_attrs[] = {
 	&dev_attr_lpfc_nvme_oas,
 	&dev_attr_lpfc_nvme_embed_cmd,
 	&dev_attr_lpfc_fcp_imax,
+	&dev_attr_lpfc_force_rscn,
 	&dev_attr_lpfc_cq_poll_threshold,
 	&dev_attr_lpfc_cq_max_proc_limit,
 	&dev_attr_lpfc_fcp_cpu_map,
@@ -6958,6 +7017,7 @@ lpfc_get_cfgparam(struct lpfc_hba *phba)
 	lpfc_nvme_oas_init(phba, lpfc_nvme_oas);
 	lpfc_nvme_embed_cmd_init(phba, lpfc_nvme_embed_cmd);
 	lpfc_fcp_imax_init(phba, lpfc_fcp_imax);
+	lpfc_force_rscn_init(phba, lpfc_force_rscn);
 	lpfc_cq_poll_threshold_init(phba, lpfc_cq_poll_threshold);
 	lpfc_cq_max_proc_limit_init(phba, lpfc_cq_max_proc_limit);
 	lpfc_fcp_cpu_map_init(phba, lpfc_fcp_cpu_map);
-- 
2.13.7
