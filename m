From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Sat,  4 Mar 2017 09:30:23 -0800
Subject: [PATCH 03/20] scsi: lpfc: don't dereference dma_buf->iocbq before
 null check
In-Reply-To: <1488648640-5170-1-git-send-email-jsmart2021@gmail.com>
References: <1488648640-5170-1-git-send-email-jsmart2021@gmail.com>
Message-ID: <1488648640-5170-4-git-send-email-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

From: Colin Ian King <colin.king@canonical.com>

dma_buf->iocbq is being dereferenced immediately before it is
being null checked, so we have a potential null pointer dereference
bug.  Fix this by only dereferencing it only once we have passed
a null check on the pointer.

Detected by CoverityScan, CID#1411652 ("Dereference before null check")

Signed-off-by: Colin Ian King <colin.king at canonical.com>
Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/scsi/lpfc/lpfc_mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_mem.c b/drivers/scsi/lpfc/lpfc_mem.c
index c61d8d6..5986c79 100644
--- a/drivers/scsi/lpfc/lpfc_mem.c
+++ b/drivers/scsi/lpfc/lpfc_mem.c
@@ -646,7 +646,6 @@ lpfc_sli4_nvmet_alloc(struct lpfc_hba *phba)
 	}
 
 	dma_buf->iocbq = lpfc_sli_get_iocbq(phba);
-	dma_buf->iocbq->iocb_flag = LPFC_IO_NVMET;
 	if (!dma_buf->iocbq) {
 		kfree(dma_buf->context);
 		pci_pool_free(phba->lpfc_drb_pool, dma_buf->dbuf.virt,
@@ -658,6 +657,7 @@ lpfc_sli4_nvmet_alloc(struct lpfc_hba *phba)
 				"2621 Ran out of nvmet iocb/WQEs\n");
 		return NULL;
 	}
+	dma_buf->iocbq->iocb_flag = LPFC_IO_NVMET;
 	nvmewqe = dma_buf->iocbq;
 	wqe = (union lpfc_wqe128 *)&nvmewqe->wqe;
 	/* Initialize WQE */
-- 
2.5.0
