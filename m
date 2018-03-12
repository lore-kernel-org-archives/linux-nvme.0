From: himanshu.madhani@cavium.com (Himanshu Madhani)
Date: Mon, 12 Mar 2018 11:16:43 -0700
Subject: [PATCH 06/13] qla2xxx: Fix n2n_ae flag to prevent dev_loss on PDB
 change
In-Reply-To: <20180312181650.20704-1-himanshu.madhani@cavium.com>
References: <20180312181650.20704-1-himanshu.madhani@cavium.com>
Message-ID: <20180312181650.20704-7-himanshu.madhani@cavium.com>

From: Darren Trapp <darren.trapp@cavium.com>

Signed-off-by: Darren Trapp <darren.trapp at cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
---
 drivers/scsi/qla2xxx/qla_def.h | 2 --
 drivers/scsi/qla2xxx/qla_isr.c | 3 ---
 drivers/scsi/qla2xxx/qla_mbx.c | 3 +++
 3 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 737492048d8a..745e6414b496 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -4282,8 +4282,6 @@ typedef struct scsi_qla_host {
 	struct		nvme_fc_local_port *nvme_local_port;
 	struct completion nvme_del_done;
 	struct list_head nvme_rport_list;
-	atomic_t 	nvme_active_aen_cnt;
-	uint16_t	nvme_last_rptd_aen;
 
 	uint16_t	fcoe_vlan_id;
 	uint16_t	fcoe_fcf_idx;
diff --git a/drivers/scsi/qla2xxx/qla_isr.c b/drivers/scsi/qla2xxx/qla_isr.c
index 011261a9d585..d973d0b5d8c3 100644
--- a/drivers/scsi/qla2xxx/qla_isr.c
+++ b/drivers/scsi/qla2xxx/qla_isr.c
@@ -768,7 +768,6 @@ qla2x00_async_event(scsi_qla_host_t *vha, struct rsp_que *rsp, uint16_t *mb)
 
 	case MBA_LIP_OCCURRED:		/* Loop Initialization Procedure */
 		ha->flags.lip_ae = 1;
-		ha->flags.n2n_ae = 0;
 
 		ql_dbg(ql_dbg_async, vha, 0x5009,
 		    "LIP occurred (%x).\n", mb[1]);
@@ -812,7 +811,6 @@ qla2x00_async_event(scsi_qla_host_t *vha, struct rsp_que *rsp, uint16_t *mb)
 
 	case MBA_LOOP_DOWN:		/* Loop Down Event */
 		SAVE_TOPO(ha);
-		ha->flags.n2n_ae = 0;
 		ha->flags.lip_ae = 0;
 		ha->current_topology = 0;
 
@@ -886,7 +884,6 @@ qla2x00_async_event(scsi_qla_host_t *vha, struct rsp_que *rsp, uint16_t *mb)
 	/* case MBA_DCBX_COMPLETE: */
 	case MBA_POINT_TO_POINT:	/* Point-to-Point */
 		ha->flags.lip_ae = 0;
-		ha->flags.n2n_ae = 1;
 
 		if (IS_QLA2100(ha))
 			break;
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 41b0ee47c6a1..735079ba691c 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -3747,6 +3747,7 @@ qla24xx_report_id_acquisition(scsi_qla_host_t *vha,
 	id.b.area   = rptid_entry->port_id[1];
 	id.b.al_pa  = rptid_entry->port_id[0];
 	id.b.rsvd_1 = 0;
+	ha->flags.n2n_ae = 0;
 
 	if (rptid_entry->format == 0) {
 		/* loop */
@@ -3799,6 +3800,7 @@ qla24xx_report_id_acquisition(scsi_qla_host_t *vha,
 			set_bit(N2N_LOGIN_NEEDED, &vha->dpc_flags);
 			set_bit(REGISTER_FC4_NEEDED, &vha->dpc_flags);
 			set_bit(REGISTER_FDMI_NEEDED, &vha->dpc_flags);
+			ha->flags.n2n_ae = 1;
 			return;
 		}
 
@@ -3875,6 +3877,7 @@ qla24xx_report_id_acquisition(scsi_qla_host_t *vha,
 		vha->d_id.b.area = rptid_entry->port_id[1];
 		vha->d_id.b.al_pa = rptid_entry->port_id[0];
 
+		ha->flags.n2n_ae = 1;
 		spin_lock_irqsave(&ha->vport_slock, flags);
 		qlt_update_vp_map(vha, SET_AL_PA);
 		spin_unlock_irqrestore(&ha->vport_slock, flags);
-- 
2.12.0
