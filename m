From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Sat,  4 Mar 2017 09:30:37 -0800
Subject: [PATCH 17/20] lpfc: correct rdp diag portnames
In-Reply-To: <1488648640-5170-1-git-send-email-jsmart2021@gmail.com>
References: <1488648640-5170-1-git-send-email-jsmart2021@gmail.com>
Message-ID: <1488648640-5170-18-git-send-email-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

NVME merge reverted diag port names to the physical port.
They should be the vport.

Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/scsi/lpfc/lpfc_els.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index d260a13..d9c61d0 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -5177,15 +5177,15 @@ lpfc_rdp_res_speed(struct fc_rdp_port_speed_desc *desc, struct lpfc_hba *phba)
 
 static uint32_t
 lpfc_rdp_res_diag_port_names(struct fc_rdp_port_name_desc *desc,
-		struct lpfc_hba *phba)
+		struct lpfc_vport *vport)
 {
 
 	desc->tag = cpu_to_be32(RDP_PORT_NAMES_DESC_TAG);
 
-	memcpy(desc->port_names.wwnn, phba->wwnn,
+	memcpy(desc->port_names.wwnn, &vport->fc_nodename,
 			sizeof(desc->port_names.wwnn));
 
-	memcpy(desc->port_names.wwpn, phba->wwpn,
+	memcpy(desc->port_names.wwpn, &vport->fc_portname,
 			sizeof(desc->port_names.wwpn));
 
 	desc->length = cpu_to_be32(sizeof(desc->port_names));
@@ -5279,7 +5279,7 @@ lpfc_els_rdp_cmpl(struct lpfc_hba *phba, struct lpfc_rdp_context *rdp_context,
 	len += lpfc_rdp_res_link_error((struct fc_rdp_link_error_status_desc *)
 				       (len + pcmd), &rdp_context->link_stat);
 	len += lpfc_rdp_res_diag_port_names((struct fc_rdp_port_name_desc *)
-					     (len + pcmd), phba);
+					     (len + pcmd), vport);
 	len += lpfc_rdp_res_attach_port_names((struct fc_rdp_port_name_desc *)
 					(len + pcmd), vport, ndlp);
 	len += lpfc_rdp_res_fec_desc((struct fc_fec_rdp_desc *)(len + pcmd),
-- 
2.5.0
