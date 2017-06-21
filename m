From: himanshu.madhani@cavium.com (Madhani, Himanshu)
Date: Wed, 21 Jun 2017 13:48:45 -0700
Subject: [PATCH v2 5/6] qla2xxx: Use FC-NMVe FC4 type for FDMI registration
In-Reply-To: <20170621204846.21663-1-himanshu.madhani@cavium.com>
References: <20170621204846.21663-1-himanshu.madhani@cavium.com>
Message-ID: <20170621204846.21663-6-himanshu.madhani@cavium.com>

From: Duane Grigsby <duane.grigsby@cavium.com>

Signed-off-by: Duane Grigsby <duane.grigsby at cavium.com>
Signed-off-by: Darren Trapp <darren.trapp at cavium.com>
Signed-off-by: Anil Gurumurthy <anil.gurumurhty at cavium.com>
Signed-off-by: Giridhar Malavali <giridhar.malavali at cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: James Smart <james.smart at broadcom.com>
---
 drivers/scsi/qla2xxx/qla_gs.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_gs.c b/drivers/scsi/qla2xxx/qla_gs.c
index c91478529b51..b323a7c71eda 100644
--- a/drivers/scsi/qla2xxx/qla_gs.c
+++ b/drivers/scsi/qla2xxx/qla_gs.c
@@ -2166,6 +2166,13 @@ qla2x00_fdmiv2_rpa(scsi_qla_host_t *vha)
 	    eiter->a.fc4_types[2],
 	    eiter->a.fc4_types[1]);
 
+	if (vha->flags.nvme_enabled) {
+		eiter->a.fc4_types[6] = 1;	/* NVMe type 28h */
+		ql_dbg(ql_dbg_disc, vha, 0x211f,
+		    "NVME FC4 Type = %02x 0x0 0x0 0x0 0x0 0x0.\n",
+		    eiter->a.fc4_types[6]);
+	}
+
 	/* Supported speed. */
 	eiter = entries + size;
 	eiter->type = cpu_to_be16(FDMI_PORT_SUPPORT_SPEED);
@@ -2363,6 +2370,15 @@ qla2x00_fdmiv2_rpa(scsi_qla_host_t *vha)
 	    "Port Active FC4 Type = %02x %02x.\n",
 	    eiter->a.port_fc4_type[2], eiter->a.port_fc4_type[1]);
 
+	if (vha->flags.nvme_enabled) {
+		eiter->a.port_fc4_type[4] = 0;
+		eiter->a.port_fc4_type[5] = 0;
+		eiter->a.port_fc4_type[6] = 1;	/* NVMe type 28h */
+		ql_dbg(ql_dbg_disc, vha, 0x2120,
+		    "NVME Port Active FC4 Type = %02x 0x0 0x0 0x0 0x0 0x0.\n",
+		    eiter->a.port_fc4_type[6]);
+	}
+
 	/* Port State */
 	eiter = entries + size;
 	eiter->type = cpu_to_be16(FDMI_PORT_STATE);
-- 
2.12.0
