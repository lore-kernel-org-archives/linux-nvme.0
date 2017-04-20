From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Wed, 19 Apr 2017 21:46:27 -0700
Subject: [PATCH-v1 08/22] Remove NULL ptr check before kfree.
In-Reply-To: <20170420044641.10657-1-jsmart2021@gmail.com>
References: <20170420044641.10657-1-jsmart2021@gmail.com>
Message-ID: <20170420044641.10657-9-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

The check for NULL ptr is not necessary, kfree will check it.

Removing NULL ptr check.

Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/scsi/lpfc/lpfc_debugfs.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
index 913eed8..76857e2 100644
--- a/drivers/scsi/lpfc/lpfc_debugfs.c
+++ b/drivers/scsi/lpfc/lpfc_debugfs.c
@@ -5700,10 +5700,8 @@ lpfc_debugfs_terminate(struct lpfc_vport *vport)
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	struct lpfc_hba   *phba = vport->phba;
 
-	if (vport->disc_trc) {
-		kfree(vport->disc_trc);
-		vport->disc_trc = NULL;
-	}
+	kfree(vport->disc_trc);
+	vport->disc_trc = NULL;
 
 	debugfs_remove(vport->debug_disc_trc); /* discovery_trace */
 	vport->debug_disc_trc = NULL;
@@ -5770,10 +5768,8 @@ lpfc_debugfs_terminate(struct lpfc_vport *vport)
 		debugfs_remove(phba->debug_readRef); /* readRef */
 		phba->debug_readRef = NULL;
 
-		if (phba->slow_ring_trc) {
-			kfree(phba->slow_ring_trc);
-			phba->slow_ring_trc = NULL;
-		}
+		kfree(phba->slow_ring_trc);
+		phba->slow_ring_trc = NULL;
 
 		/* slow_ring_trace */
 		debugfs_remove(phba->debug_slow_ring_trc);
-- 
2.1.0
