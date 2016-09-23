From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Sep 2016 20:23:05 -0700
Subject: [PATCH 14/18] add missing endianess conversions in json_nvme_id_ctrl
In-Reply-To: <1474600989-16657-1-git-send-email-hch@lst.de>
References: <1474600989-16657-1-git-send-email-hch@lst.de>
Message-ID: <1474600989-16657-15-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 nvme-print.c | 57 +++++++++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index 5320951..f9a8ff6 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1198,18 +1198,18 @@ void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode)
 
 	root = json_create_object();
 
-	json_object_add_value_int(root, "vid", ctrl->vid);
-	json_object_add_value_int(root, "ssvid", ctrl->ssvid);
+	json_object_add_value_int(root, "vid", le16_to_cpu(ctrl->vid));
+	json_object_add_value_int(root, "ssvid", le16_to_cpu(ctrl->ssvid));
 	json_object_add_value_int(root, "rab", ctrl->rab);
 	json_object_add_value_int(root, "ieee", ieee);
 	json_object_add_value_int(root, "cmic", ctrl->cmic);
 	json_object_add_value_int(root, "mdts", ctrl->mdts);
-	json_object_add_value_int(root, "cntlid", ctrl->cntlid);
-	json_object_add_value_int(root, "ver", ctrl->ver);
-	json_object_add_value_int(root, "rtd3r", ctrl->rtd3r);
-	json_object_add_value_int(root, "rtd3e", ctrl->rtd3e);
-	json_object_add_value_int(root, "oaes", ctrl->oaes);
-	json_object_add_value_int(root, "oacs", ctrl->oacs);
+	json_object_add_value_int(root, "cntlid", le16_to_cpu(ctrl->cntlid));
+	json_object_add_value_int(root, "ver", le32_to_cpu(ctrl->ver));
+	json_object_add_value_int(root, "rtd3r", le32_to_cpu(ctrl->rtd3r));
+	json_object_add_value_int(root, "rtd3e", le32_to_cpu(ctrl->rtd3e));
+	json_object_add_value_int(root, "oaes", le32_to_cpu(ctrl->oaes));
+	json_object_add_value_int(root, "oacs", le16_to_cpu(ctrl->oacs));
 	json_object_add_value_int(root, "acl", ctrl->acl);
 	json_object_add_value_int(root, "aerl", ctrl->aerl);
 	json_object_add_value_int(root, "frmw", ctrl->frmw);
@@ -1218,26 +1218,26 @@ void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode)
 	json_object_add_value_int(root, "npss", ctrl->npss);
 	json_object_add_value_int(root, "avscc", ctrl->avscc);
 	json_object_add_value_int(root, "apsta", ctrl->apsta);
-	json_object_add_value_int(root, "wctemp", ctrl->wctemp);
-	json_object_add_value_int(root, "cctemp", ctrl->cctemp);
-	json_object_add_value_int(root, "mtfa", ctrl->mtfa);
-	json_object_add_value_int(root, "hmpre", ctrl->hmpre);
-	json_object_add_value_int(root, "hmmin", ctrl->hmmin);
+	json_object_add_value_int(root, "wctemp", le16_to_cpu(ctrl->wctemp));
+	json_object_add_value_int(root, "cctemp", le16_to_cpu(ctrl->cctemp));
+	json_object_add_value_int(root, "mtfa", le16_to_cpu(ctrl->mtfa));
+	json_object_add_value_int(root, "hmpre", le32_to_cpu(ctrl->hmpre));
+	json_object_add_value_int(root, "hmmin", le32_to_cpu(ctrl->hmmin));
 	json_object_add_value_float(root, "tnvmcap", tnvmcap);
 	json_object_add_value_float(root, "unvmcap", unvmcap);
-	json_object_add_value_int(root, "rpmbs", ctrl->rpmbs);
+	json_object_add_value_int(root, "rpmbs", le32_to_cpu(ctrl->rpmbs));
 	json_object_add_value_int(root, "sqes", ctrl->sqes);
 	json_object_add_value_int(root, "cqes", ctrl->cqes);
-	json_object_add_value_int(root, "nn", ctrl->nn);
-	json_object_add_value_int(root, "oncs", ctrl->oncs);
-	json_object_add_value_int(root, "fuses", ctrl->fuses);
+	json_object_add_value_int(root, "nn", le32_to_cpu(ctrl->nn));
+	json_object_add_value_int(root, "oncs", le16_to_cpu(ctrl->oncs));
+	json_object_add_value_int(root, "fuses", le16_to_cpu(ctrl->fuses));
 	json_object_add_value_int(root, "fna", ctrl->fna);
 	json_object_add_value_int(root, "vwc", ctrl->vwc);
-	json_object_add_value_int(root, "awun", ctrl->awun);
-	json_object_add_value_int(root, "awupf", ctrl->awupf);
+	json_object_add_value_int(root, "awun", le16_to_cpu(ctrl->awun));
+	json_object_add_value_int(root, "awupf", le16_to_cpu(ctrl->awupf));
 	json_object_add_value_int(root, "nvscc", ctrl->nvscc);
-	json_object_add_value_int(root, "acwu", ctrl->acwu);
-	json_object_add_value_int(root, "sgls", ctrl->sgls);
+	json_object_add_value_int(root, "acwu", le16_to_cpu(ctrl->acwu));
+	json_object_add_value_int(root, "sgls", le32_to_cpu(ctrl->sgls));
 
 	psds = json_create_array();
 	json_object_add_value_array(root, "psds", psds);
@@ -1245,17 +1245,22 @@ void json_nvme_id_ctrl(struct nvme_id_ctrl *ctrl, unsigned int mode)
 	for (i = 0; i <= ctrl->npss; i++) {
 		struct json_object *psd = json_create_object();
 
-		json_object_add_value_int(psd, "max_power", ctrl->psd[i].max_power);
+		json_object_add_value_int(psd, "max_power",
+			le16_to_cpu(ctrl->psd[i].max_power));
 		json_object_add_value_int(psd, "flags", ctrl->psd[i].flags);
-		json_object_add_value_int(psd, "entry_lat", ctrl->psd[i].entry_lat);
-		json_object_add_value_int(psd, "exit_lat", ctrl->psd[i].exit_lat);
+		json_object_add_value_int(psd, "entry_lat",
+			le32_to_cpu(ctrl->psd[i].entry_lat));
+		json_object_add_value_int(psd, "exit_lat",
+			le32_to_cpu(ctrl->psd[i].exit_lat));
 		json_object_add_value_int(psd, "read_tput", ctrl->psd[i].read_tput);
 		json_object_add_value_int(psd, "read_lat", ctrl->psd[i].read_lat);
 		json_object_add_value_int(psd, "write_tput", ctrl->psd[i].write_tput);
 		json_object_add_value_int(psd, "write_lat", ctrl->psd[i].write_lat);
-		json_object_add_value_int(psd, "idle_power", ctrl->psd[i].idle_power);
+		json_object_add_value_int(psd, "idle_power",
+			le16_to_cpu(ctrl->psd[i].idle_power));
 		json_object_add_value_int(psd, "idle_scale", ctrl->psd[i].idle_scale);
-		json_object_add_value_int(psd, "active_power", ctrl->psd[i].active_power);
+		json_object_add_value_int(psd, "active_power",
+			le16_to_cpu(ctrl->psd[i].active_power));
 		json_object_add_value_int(psd, "active_work_scale", ctrl->psd[i].active_work_scale);
 
 		json_array_add_value_object(psds, psd);
-- 
2.1.4
