From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu,  8 Feb 2018 21:14:01 +0900
Subject: [PATCH] nvme-cli: adjust json print according to uint format
Message-ID: <1518092041-7327-1-git-send-email-minwoo.im.dev@gmail.com>

Adjust JSON print format according to uint format which has recently been
added with no functional change.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme-print.c | 70 ++++++++++++++++++++++++++++++------------------------------
 1 file changed, 35 insertions(+), 35 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index 1f99ed1..4173256 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1710,16 +1710,16 @@ void json_print_list_items(struct list_item *list_items, unsigned len)
 		lba = 1 << list_items[i].ns.lbaf[(list_items[i].ns.flbas & 0x0f)].ds;
 		nsze = le64_to_cpu(list_items[i].ns.nsze) * lba;
 		nuse = le64_to_cpu(list_items[i].ns.nuse) * lba;
-		json_object_add_value_int(device_attrs,
+		json_object_add_value_uint(device_attrs,
 					  "UsedBytes",
 					  nuse);
-		json_object_add_value_int(device_attrs,
+		json_object_add_value_uint(device_attrs,
 					  "MaximiumLBA",
 					  le64_to_cpu(list_items[i].ns.nsze));
-		json_object_add_value_int(device_attrs,
+		json_object_add_value_uint(device_attrs,
 					  "PhysicalSize",
 					  nsze);
-		json_object_add_value_int(device_attrs,
+		json_object_add_value_uint(device_attrs,
 					  "SectorSize",
 					  lba);
 
@@ -1742,9 +1742,9 @@ void json_nvme_id_ns(struct nvme_id_ns *ns, unsigned int mode)
 
 	root = json_create_object();
 
-	json_object_add_value_int(root, "nsze", le64_to_cpu(ns->nsze));
-	json_object_add_value_int(root, "ncap", le64_to_cpu(ns->ncap));
-	json_object_add_value_int(root, "nuse", le64_to_cpu(ns->nuse));
+	json_object_add_value_uint(root, "nsze", le64_to_cpu(ns->nsze));
+	json_object_add_value_uint(root, "ncap", le64_to_cpu(ns->ncap));
+	json_object_add_value_uint(root, "nuse", le64_to_cpu(ns->nuse));
 	json_object_add_value_int(root, "nsfeat", ns->nsfeat);
 	json_object_add_value_int(root, "nlbaf", ns->nlbaf);
 	json_object_add_value_int(root, "flbas", ns->flbas);
@@ -1823,10 +1823,10 @@ void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*vs)(
 	json_object_add_value_int(root, "cmic", ctrl->cmic);
 	json_object_add_value_int(root, "mdts", ctrl->mdts);
 	json_object_add_value_int(root, "cntlid", le16_to_cpu(ctrl->cntlid));
-	json_object_add_value_int(root, "ver", le32_to_cpu(ctrl->ver));
-	json_object_add_value_int(root, "rtd3r", le32_to_cpu(ctrl->rtd3r));
-	json_object_add_value_int(root, "rtd3e", le32_to_cpu(ctrl->rtd3e));
-	json_object_add_value_int(root, "oaes", le32_to_cpu(ctrl->oaes));
+	json_object_add_value_uint(root, "ver", le32_to_cpu(ctrl->ver));
+	json_object_add_value_uint(root, "rtd3r", le32_to_cpu(ctrl->rtd3r));
+	json_object_add_value_uint(root, "rtd3e", le32_to_cpu(ctrl->rtd3e));
+	json_object_add_value_uint(root, "oaes", le32_to_cpu(ctrl->oaes));
 	json_object_add_value_int(root, "ctratt", le32_to_cpu(ctrl->ctratt));
 	json_object_add_value_int(root, "oacs", le16_to_cpu(ctrl->oacs));
 	json_object_add_value_int(root, "acl", ctrl->acl);
@@ -1840,11 +1840,11 @@ void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*vs)(
 	json_object_add_value_int(root, "wctemp", le16_to_cpu(ctrl->wctemp));
 	json_object_add_value_int(root, "cctemp", le16_to_cpu(ctrl->cctemp));
 	json_object_add_value_int(root, "mtfa", le16_to_cpu(ctrl->mtfa));
-	json_object_add_value_int(root, "hmpre", le32_to_cpu(ctrl->hmpre));
-	json_object_add_value_int(root, "hmmin", le32_to_cpu(ctrl->hmmin));
+	json_object_add_value_uint(root, "hmpre", le32_to_cpu(ctrl->hmpre));
+	json_object_add_value_uint(root, "hmmin", le32_to_cpu(ctrl->hmmin));
 	json_object_add_value_float(root, "tnvmcap", tnvmcap);
 	json_object_add_value_float(root, "unvmcap", unvmcap);
-	json_object_add_value_int(root, "rpmbs", le32_to_cpu(ctrl->rpmbs));
+	json_object_add_value_uint(root, "rpmbs", le32_to_cpu(ctrl->rpmbs));
 	json_object_add_value_int(root, "edstt", le16_to_cpu(ctrl->edstt));
 	json_object_add_value_int(root, "dsto", ctrl->dsto);
 	json_object_add_value_int(root, "fwug", ctrl->fwug);
@@ -1856,7 +1856,7 @@ void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*vs)(
 	json_object_add_value_int(root, "sqes", ctrl->sqes);
 	json_object_add_value_int(root, "cqes", ctrl->cqes);
 	json_object_add_value_int(root, "maxcmd", le16_to_cpu(ctrl->maxcmd));
-	json_object_add_value_int(root, "nn", le32_to_cpu(ctrl->nn));
+	json_object_add_value_uint(root, "nn", le32_to_cpu(ctrl->nn));
 	json_object_add_value_int(root, "oncs", le16_to_cpu(ctrl->oncs));
 	json_object_add_value_int(root, "fuses", le16_to_cpu(ctrl->fuses));
 	json_object_add_value_int(root, "fna", ctrl->fna);
@@ -1885,9 +1885,9 @@ void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode, void (*vs)(
 		json_object_add_value_int(psd, "max_power",
 			le16_to_cpu(ctrl->psd[i].max_power));
 		json_object_add_value_int(psd, "flags", ctrl->psd[i].flags);
-		json_object_add_value_int(psd, "entry_lat",
+		json_object_add_value_uint(psd, "entry_lat",
 			le32_to_cpu(ctrl->psd[i].entry_lat));
-		json_object_add_value_int(psd, "exit_lat",
+		json_object_add_value_uint(psd, "exit_lat",
 			le32_to_cpu(ctrl->psd[i].exit_lat));
 		json_object_add_value_int(psd, "read_tput", ctrl->psd[i].read_tput);
 		json_object_add_value_int(psd, "read_lat", ctrl->psd[i].read_lat);
@@ -1925,13 +1925,13 @@ void json_error_log(struct nvme_error_log_page *err_log, int entries, const char
 	for (i = 0; i < entries; i++) {
 		struct json_object *error = json_create_object();
 
-		json_object_add_value_int(error, "error_count", err_log[i].error_count);
+		json_object_add_value_uint(error, "error_count", err_log[i].error_count);
 		json_object_add_value_int(error, "sqid", err_log[i].sqid);
 		json_object_add_value_int(error, "cmdid", err_log[i].cmdid);
 		json_object_add_value_int(error, "status_field", err_log[i].status_field);
 		json_object_add_value_int(error, "parm_error_location", err_log[i].parm_error_location);
-		json_object_add_value_int(error, "lba", err_log[i].lba);
-		json_object_add_value_int(error, "nsid", err_log[i].nsid);
+		json_object_add_value_uint(error, "lba", err_log[i].lba);
+		json_object_add_value_uint(error, "nsid", err_log[i].nsid);
 		json_object_add_value_int(error, "vs", err_log[i].vs);
 		json_object_add_value_uint(error, "cs", err_log[i].cs);
 
@@ -1972,8 +1972,8 @@ void json_nvme_resv_report(struct nvme_reservation_status *status, int bytes, __
 
 			json_object_add_value_int(rc, "cntlid", le16_to_cpu(status->regctl_ds[i].cntlid));
 			json_object_add_value_int(rc, "rcsts", status->regctl_ds[i].rcsts);
-			json_object_add_value_int(rc, "hostid", (uint64_t)le64_to_cpu(status->regctl_ds[i].hostid));
-			json_object_add_value_int(rc, "rkey", (uint64_t)le64_to_cpu(status->regctl_ds[i].rkey));
+			json_object_add_value_uint(rc, "hostid", (uint64_t)le64_to_cpu(status->regctl_ds[i].hostid));
+			json_object_add_value_uint(rc, "rkey", (uint64_t)le64_to_cpu(status->regctl_ds[i].rkey));
 
 			json_array_add_value_object(rcs, rc);
 		}
@@ -1992,7 +1992,7 @@ void json_nvme_resv_report(struct nvme_reservation_status *status, int bytes, __
 
 			json_object_add_value_int(rc, "cntlid", le16_to_cpu(ext_status->regctl_eds[i].cntlid));
 			json_object_add_value_int(rc, "rcsts", ext_status->regctl_eds[i].rcsts);
-			json_object_add_value_int(rc, "rkey", (uint64_t)le64_to_cpu(ext_status->regctl_eds[i].rkey));
+			json_object_add_value_uint(rc, "rkey", (uint64_t)le64_to_cpu(ext_status->regctl_eds[i].rkey));
 			for (j = 0; j < 16; j++)
 				sprintf(hostid + j * 2, "%02x", ext_status->regctl_eds[i].hostid[j]);
 
@@ -2072,9 +2072,9 @@ void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char
 	json_object_add_value_float(root, "unsafe_shutdowns", unsafe_shutdowns);
 	json_object_add_value_float(root, "media_errors", media_errors);
 	json_object_add_value_float(root, "num_err_log_entries", num_err_log_entries);
-	json_object_add_value_int(root, "warning_temp_time",
+	json_object_add_value_uint(root, "warning_temp_time",
 			le32_to_cpu(smart->warning_temp_time));
-	json_object_add_value_int(root, "critical_comp_time",
+	json_object_add_value_uint(root, "critical_comp_time",
 			le32_to_cpu(smart->critical_comp_time));
 
 	for (c=0; c < 8; c++) {
@@ -2086,13 +2086,13 @@ void json_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char
 		json_object_add_value_int(root, key, temp);
 	}
 
-	json_object_add_value_int(root, "thm_temp1_trans_count",
+	json_object_add_value_uint(root, "thm_temp1_trans_count",
 			le32_to_cpu(smart->thm_temp1_trans_count));
-	json_object_add_value_int(root, "thm_temp2_trans_count",
+	json_object_add_value_uint(root, "thm_temp2_trans_count",
 			le32_to_cpu(smart->thm_temp2_trans_count));
-	json_object_add_value_int(root, "thm_temp1_total_time",
+	json_object_add_value_uint(root, "thm_temp1_total_time",
 			le32_to_cpu(smart->thm_temp1_total_time));
-	json_object_add_value_int(root, "thm_temp2_total_time",
+	json_object_add_value_uint(root, "thm_temp2_total_time",
 			le32_to_cpu(smart->thm_temp2_total_time));
 
 	json_print_object(root, NULL);
@@ -2112,13 +2112,13 @@ void json_effects_log(struct nvme_effects_log_page *effects_log, const char *dev
 	for (opcode = 0; opcode < 256; opcode++) {
 		sprintf(key, "ACS%d (%s)", opcode, nvme_cmd_to_string(1, opcode));
 		effect = le32_to_cpu(effects_log->acs[opcode]);
-		json_object_add_value_int(root, key, effect);
+		json_object_add_value_uint(root, key, effect);
 	}
 
 	for (opcode = 0; opcode < 256; opcode++) {
 		sprintf(key, "IOCS%d (%s)", opcode, nvme_cmd_to_string(0, opcode));
 		effect = le32_to_cpu(effects_log->iocs[opcode]);
-		json_object_add_value_int(root, key, effect);
+		json_object_add_value_uint(root, key, effect);
 	}
 
 	json_print_object(root, NULL);
@@ -2149,10 +2149,10 @@ void json_sanitize_log(struct nvme_sanitize_log_page *sanitize_log, const char *
 	json_object_add_value_string(sstat, "status", str);
 
 	json_object_add_value_object(dev, "sstat", sstat);
-	json_object_add_value_int(dev, "cdw10_info", le32_to_cpu(sanitize_log->cdw10_info));
-	json_object_add_value_int(dev, "time_over_write", le32_to_cpu(sanitize_log->est_ovrwrt_time));
-	json_object_add_value_int(dev, "time_block_erase", le32_to_cpu(sanitize_log->est_blk_erase_time));
-	json_object_add_value_int(dev, "time_crypto_erase", le32_to_cpu(sanitize_log->est_crypto_erase_time));
+	json_object_add_value_uint(dev, "cdw10_info", le32_to_cpu(sanitize_log->cdw10_info));
+	json_object_add_value_uint(dev, "time_over_write", le32_to_cpu(sanitize_log->est_ovrwrt_time));
+	json_object_add_value_uint(dev, "time_block_erase", le32_to_cpu(sanitize_log->est_blk_erase_time));
+	json_object_add_value_uint(dev, "time_crypto_erase", le32_to_cpu(sanitize_log->est_crypto_erase_time));
 
 	json_object_add_value_object(root, devname, dev);
 	json_print_object(root, NULL);
-- 
2.7.4
