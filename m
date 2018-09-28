From: himanshu.madhani@cavium.com (Himanshu Madhani)
Date: Fri, 28 Sep 2018 15:46:22 -0700
Subject: [PATCH v3 1/5] qla2xxx_nvmet: Add FC-NVMe Target Link Service request
 handling
In-Reply-To: <20180928224626.19777-1-himanshu.madhani@cavium.com>
References: <20180928224626.19777-1-himanshu.madhani@cavium.com>
Message-ID: <20180928224626.19777-2-himanshu.madhani@cavium.com>

From: Anil Gurumurthy <anil.gurumurthy@cavium.com>

This patch provides link service pass through feature handling
in the driver. This feature is implemented mainly by the firmware
and the same implementation is handled in the driver via an
IOCB interface.

Signed-off-by: Anil Gurumurthy <anil.gurumurthy at cavium.com>
Signed-off-by: Giridhar Malavali <giridhar.malavali at cavium.com>
Signed-off-by: Darren Trapp <darren.trapp at cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
---
 drivers/scsi/qla2xxx/qla_dbg.c    |  1 +
 drivers/scsi/qla2xxx/qla_dbg.h    |  2 ++
 drivers/scsi/qla2xxx/qla_def.h    |  3 +++
 drivers/scsi/qla2xxx/qla_gbl.h    |  7 +++++++
 drivers/scsi/qla2xxx/qla_iocb.c   |  8 +++++++-
 drivers/scsi/qla2xxx/qla_target.c | 11 +++++++++++
 6 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_dbg.c b/drivers/scsi/qla2xxx/qla_dbg.c
index c7533fa7f46e..ed9c228f7d11 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.c
+++ b/drivers/scsi/qla2xxx/qla_dbg.c
@@ -67,6 +67,7 @@
  * | Target Mode Management	  |	  0xf09b       | 0xf002		|
  * |                              |                    | 0xf046-0xf049  |
  * | Target Mode Task Management  |	  0x1000d      |		|
+ * | NVME			  |	  0x11000      |		|
  * ----------------------------------------------------------------------
  */
 
diff --git a/drivers/scsi/qla2xxx/qla_dbg.h b/drivers/scsi/qla2xxx/qla_dbg.h
index 8877aa97d829..4ad97923e40b 100644
--- a/drivers/scsi/qla2xxx/qla_dbg.h
+++ b/drivers/scsi/qla2xxx/qla_dbg.h
@@ -367,6 +367,8 @@ ql_log_qp(uint32_t, struct qla_qpair *, int32_t, const char *fmt, ...);
 #define ql_dbg_tgt_tmr	0x00001000 /* Target mode task management */
 #define ql_dbg_tgt_dif  0x00000800 /* Target mode dif */
 
+#define ql_dbg_nvme 0x00000400 /* NVME Target */
+
 extern int qla27xx_dump_mpi_ram(struct qla_hw_data *, uint32_t, uint32_t *,
 	uint32_t, void **);
 extern int qla24xx_dump_ram(struct qla_hw_data *, uint32_t, uint32_t *,
diff --git a/drivers/scsi/qla2xxx/qla_def.h b/drivers/scsi/qla2xxx/qla_def.h
index 26b93c563f92..a37a4d2261e2 100644
--- a/drivers/scsi/qla2xxx/qla_def.h
+++ b/drivers/scsi/qla2xxx/qla_def.h
@@ -515,6 +515,9 @@ struct srb_iocb {
 #define SRB_PRLI_CMD	21
 #define SRB_CTRL_VP	22
 #define SRB_PRLO_CMD	23
+#define SRB_NVME_ELS_RSP 24
+#define SRB_NVMET_LS   25
+#define SRB_NVMET_FCP  26
 
 enum {
 	TYPE_SRB,
diff --git a/drivers/scsi/qla2xxx/qla_gbl.h b/drivers/scsi/qla2xxx/qla_gbl.h
index 3673fcdb033a..2946c65812cd 100644
--- a/drivers/scsi/qla2xxx/qla_gbl.h
+++ b/drivers/scsi/qla2xxx/qla_gbl.h
@@ -119,6 +119,13 @@ void qla_do_iidma_work(struct scsi_qla_host *vha, fc_port_t *fcport);
 int qla2x00_reserve_mgmt_server_loop_id(scsi_qla_host_t *);
 void qla_rscn_replay(fc_port_t *fcport);
 
+
+/*
+ * Used by FC-NVMe Target
+ */
+int qla_nvmet_ls(srb_t *sp, void *rsp_pkt);
+int qlt_send_els_resp(srb_t *sp, void *pkt);
+
 /*
  * Global Data in qla_os.c source file.
  */
diff --git a/drivers/scsi/qla2xxx/qla_iocb.c b/drivers/scsi/qla2xxx/qla_iocb.c
index 4de910231ba6..19f8eb46f128 100644
--- a/drivers/scsi/qla2xxx/qla_iocb.c
+++ b/drivers/scsi/qla2xxx/qla_iocb.c
@@ -2113,7 +2113,7 @@ __qla2x00_alloc_iocbs(struct qla_qpair *qpair, srb_t *sp)
 	req_cnt = 1;
 	handle = 0;
 
-	if (sp && (sp->type != SRB_SCSI_CMD)) {
+	if (sp && (sp->type != SRB_SCSI_CMD) && (sp->type != SRB_NVMET_FCP)) {
 		/* Adjust entry-counts as needed. */
 		req_cnt = sp->iocbs;
 	}
@@ -3493,6 +3493,9 @@ qla2x00_start_sp(srb_t *sp)
 	case SRB_NVME_LS:
 		qla_nvme_ls(sp, pkt);
 		break;
+	case SRB_NVMET_LS:
+		qla_nvmet_ls(sp, pkt);
+		break;
 	case SRB_ABT_CMD:
 		IS_QLAFX00(ha) ?
 			qlafx00_abort_iocb(sp, pkt) :
@@ -3518,6 +3521,9 @@ qla2x00_start_sp(srb_t *sp)
 	case SRB_PRLO_CMD:
 		qla24xx_prlo_iocb(sp, pkt);
 		break;
+	case SRB_NVME_ELS_RSP:
+		qlt_send_els_resp(sp, pkt);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/scsi/qla2xxx/qla_target.c b/drivers/scsi/qla2xxx/qla_target.c
index 3015f1bbcf1a..dc680ffe2f49 100644
--- a/drivers/scsi/qla2xxx/qla_target.c
+++ b/drivers/scsi/qla2xxx/qla_target.c
@@ -445,6 +445,17 @@ static bool qlt_24xx_atio_pkt_all_vps(struct scsi_qla_host *vha,
 	return false;
 }
 
+int qlt_send_els_resp(srb_t *sp, void *pkt)
+{
+	return 0;
+}
+
+int
+qla_nvmet_ls(srb_t *sp, void *rsp_pkt)
+{
+	return 0;
+}
+
 void qlt_response_pkt_all_vps(struct scsi_qla_host *vha,
 	struct rsp_que *rsp, response_t *pkt)
 {
-- 
2.12.0
