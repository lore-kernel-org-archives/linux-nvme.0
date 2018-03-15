From: himanshu.madhani@cavium.com (Himanshu Madhani)
Date: Wed, 14 Mar 2018 20:34:53 -0700
Subject: [PATCH v2 02/13] qla2xxx: Set IIDMA and fcport state before
 qla_nvme_register_remote()
In-Reply-To: <20180315033504.12628-1-himanshu.madhani@cavium.com>
References: <20180315033504.12628-1-himanshu.madhani@cavium.com>
Message-ID: <20180315033504.12628-3-himanshu.madhani@cavium.com>

From: Darren Trapp <darren.trapp@cavium.com>

Signed-off-by: Darren Trapp <darren.trapp at cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
---
 drivers/scsi/qla2xxx/qla_init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index cb182b102bfd..6caccc52376a 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -5110,13 +5110,14 @@ qla2x00_update_fcport(scsi_qla_host_t *vha, fc_port_t *fcport)
 	fcport->deleted = 0;
 	fcport->logout_on_delete = 1;
 
+	qla2x00_set_fcport_state(fcport, FCS_ONLINE);
+	qla2x00_iidma_fcport(vha, fcport);
+
 	if (fcport->fc4f_nvme) {
 		qla_nvme_register_remote(vha, fcport);
 		return;
 	}
 
-	qla2x00_set_fcport_state(fcport, FCS_ONLINE);
-	qla2x00_iidma_fcport(vha, fcport);
 	qla24xx_update_fcport_fcp_prio(vha, fcport);
 
 reg_port:
-- 
2.12.0
