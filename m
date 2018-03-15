From: himanshu.madhani@cavium.com (Himanshu Madhani)
Date: Wed, 14 Mar 2018 20:35:00 -0700
Subject: [PATCH v2 09/13] qla2xxx: Fix retry for PRLI RJT with reason of BUSY
In-Reply-To: <20180315033504.12628-1-himanshu.madhani@cavium.com>
References: <20180315033504.12628-1-himanshu.madhani@cavium.com>
Message-ID: <20180315033504.12628-10-himanshu.madhani@cavium.com>

From: Darren Trapp <darren.trapp@cavium.com>

Signed-off-by: Darren Trapp <darren.trapp at cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
---
 drivers/scsi/qla2xxx/qla_dbg.c  |  2 +-
 drivers/scsi/qla2xxx/qla_init.c | 13 ++++++++++++-
 drivers/scsi/qla2xxx/qla_mbx.c  |  7 +++++--
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_dbg.c b/drivers/scsi/qla2xxx/qla_dbg.c
index 7e9d8f08b9d5..1abc8a9064b3 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.c
+++ b/drivers/scsi/qla2xxx/qla_dbg.c
@@ -60,7 +60,7 @@
  * |                              |                    | 0xb13c-0xb140  |
  * |                              |                    | 0xb149		|
  * | MultiQ                       |       0xc010       |		|
- * | Misc                         |       0xd302       | 0xd031-0xd0ff	|
+ * | Misc                         |       0xd303       | 0xd031-0xd0ff	|
  * |                              |                    | 0xd101-0xd1fe	|
  * |                              |                    | 0xd214-0xd2fe	|
  * | Target Mode		  |	  0xe081       |		|
diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 0805483645d7..5520477a66d9 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -875,7 +875,6 @@ qla24xx_async_prli(struct scsi_qla_host *vha, fc_port_t *fcport)
 		return rval;
 
 	if (fcport->fw_login_state == DSC_LS_PLOGI_PEND ||
-	    fcport->fw_login_state == DSC_LS_PLOGI_COMP ||
 	    fcport->fw_login_state == DSC_LS_PRLI_PEND)
 		return rval;
 
@@ -1240,6 +1239,11 @@ int qla24xx_fcport_handle_login(struct scsi_qla_host *vha, fc_port_t *fcport)
 		qla2x00_post_async_adisc_work(vha, fcport, data);
 		break;
 
+	case DSC_LOGIN_PEND:
+		if (fcport->fw_login_state == DSC_LS_PLOGI_COMP)
+			qla24xx_post_prli_work(vha, fcport);
+		break;
+
 	default:
 		break;
 	}
@@ -1643,6 +1647,13 @@ qla24xx_handle_prli_done_event(struct scsi_qla_host *vha, struct event_arg *ea)
 		qla24xx_post_gpdb_work(vha, ea->fcport, 0);
 		break;
 	default:
+		if ((ea->iop[0] == LSC_SCODE_ELS_REJECT) &&
+		    (ea->iop[1] == 0x50000)) {   /* reson 5=busy expl:0x0 */
+			set_bit(RELOGIN_NEEDED, &vha->dpc_flags);
+			ea->fcport->fw_login_state = DSC_LS_PLOGI_COMP;
+			break;
+		}
+
 		if (ea->fcport->n2n_flag) {
 			ql_dbg(ql_dbg_disc, vha, 0x2118,
 				"%s %d %8phC post fc4 prli\n",
diff --git a/drivers/scsi/qla2xxx/qla_mbx.c b/drivers/scsi/qla2xxx/qla_mbx.c
index 735079ba691c..c9a134ae0d2b 100644
--- a/drivers/scsi/qla2xxx/qla_mbx.c
+++ b/drivers/scsi/qla2xxx/qla_mbx.c
@@ -1025,9 +1025,12 @@ qla2x00_get_fw_version(scsi_qla_host_t *vha)
 		 * FW supports nvme and driver load parameter requested nvme.
 		 * BIT 26 of fw_attributes indicates NVMe support.
 		 */
-		if ((ha->fw_attributes_h & 0x400) && ql2xnvmeenable)
+		if ((ha->fw_attributes_h & 0x400) && ql2xnvmeenable) {
 			vha->flags.nvme_enabled = 1;
-
+			ql_log(ql_log_info, vha, 0xd302,
+			    "%s: FC-NVMe is Enabled (0x%x)\n",
+			     __func__, ha->fw_attributes_h);
+		}
 	}
 
 	if (IS_QLA27XX(ha)) {
-- 
2.12.0
