From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Sat,  4 Mar 2017 09:30:36 -0800
Subject: [PATCH 16/20] lpfc: remove dead sli3 nvme code
In-Reply-To: <1488648640-5170-1-git-send-email-jsmart2021@gmail.com>
References: <1488648640-5170-1-git-send-email-jsmart2021@gmail.com>
Message-ID: <1488648640-5170-17-git-send-email-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

Remove nvme teardown calls that should not be there on sli3 devices

Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/scsi/lpfc/lpfc_init.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 10c89e8..77d8840 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -10459,12 +10459,7 @@ lpfc_pci_remove_one_s3(struct pci_dev *pdev)
 	fc_remove_host(shost);
 	scsi_remove_host(shost);
 
-	/* Perform ndlp cleanup on the physical port.  The nvme and nvmet
-	 * localports are destroyed after to cleanup all transport memory.
-	 */
 	lpfc_cleanup(vport);
-	lpfc_nvmet_destroy_targetport(phba);
-	lpfc_nvme_destroy_localport(vport);
 
 	/*
 	 * Bring down the SLI Layer. This step disable all interrupts,
-- 
2.5.0
