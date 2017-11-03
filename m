From: jsmart2021@gmail.com (James Smart)
Date: Fri,  3 Nov 2017 09:12:36 -0700
Subject: [PATCH] lpfc: Tie in to new dev_loss_tmo interface in nvme transport
Message-ID: <20171103161236.15127-1-jsmart2021@gmail.com>

This patch calls the new nvme transport routine for dev_loss_tmo
whenever the SCSI fc transport calls the lldd to make a dynamic
change to a remote ports dev_loss_tmo.

Signed-off-by: James Smart <james.smart at broadcom.com>

---
This lpfc patch, as dependent upon the new nvme transport
nvme_fc_set_remoteport_devloss() call, should enter via nvme-4.15
---
 drivers/scsi/lpfc/lpfc_attr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
index c17677f494af..1191a92e2dbc 100644
--- a/drivers/scsi/lpfc/lpfc_attr.c
+++ b/drivers/scsi/lpfc/lpfc_attr.c
@@ -3246,6 +3246,9 @@ lpfc_update_rport_devloss_tmo(struct lpfc_vport *vport)
 			continue;
 		if (ndlp->rport)
 			ndlp->rport->dev_loss_tmo = vport->cfg_devloss_tmo;
+		if (ndlp->nrport)
+			nvme_fc_set_remoteport_devloss(ndlp->nrport->remoteport,
+						       vport->cfg_devloss_tmo);
 	}
 	spin_unlock_irq(shost->host_lock);
 }
-- 
2.13.1
