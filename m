From: jsmart2021@gmail.com (jsmart2021@gmail.com)
Date: Fri, 21 Apr 2017 16:04:54 -0700
Subject: [PATCH v3 10/22] Fix PRLI ACC rsp for NVME
In-Reply-To: <20170421230506.925-1-jsmart2021@gmail.com>
References: <20170421230506.925-1-jsmart2021@gmail.com>
Message-ID: <20170421230506.925-11-jsmart2021@gmail.com>

From: James Smart <jsmart2021@gmail.com>

PRLI ACC from target is FCP oriented.

Word 0 was wrong. This was noticed by another nvmet-fc vendor that
was testing the lpfc nvme-fc initiator with their target.

Verified results with analyzer.

PRLI
BC B5 56 56  22 61 04 00  00 61 00 00  01 29 00 00  20 00 00 00
00 10 FF FF  00 00 00 00  20 14 00 18  28 00 00 00  00 00 00 00
00 00 00 00  00 00 00 20  00 00 00 00  9C D8 DA C9  BC 95 75 75

ACC
BC B5 56 56  23 61 00 00  00 61 04 00  01 98 00 00  30 00 00 00
00 10 00 18  00 00 00 00  02 14 00 18  28 00 01 00  00 00 00 00
00 00 00 00  00 00 00 18  00 00 00 00  B0 6B 07 57  BC B5 75 75

Signed-off-by: Dick Kennedy <dick.kennedy at broadcom.com>
Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/scsi/lpfc/lpfc_els.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_els.c b/drivers/scsi/lpfc/lpfc_els.c
index d9c61d0..d6e0f58 100644
--- a/drivers/scsi/lpfc/lpfc_els.c
+++ b/drivers/scsi/lpfc/lpfc_els.c
@@ -4403,7 +4403,7 @@ lpfc_els_rsp_prli_acc(struct lpfc_vport *vport, struct lpfc_iocbq *oldiocb,
 	pcmd = (uint8_t *) (((struct lpfc_dmabuf *) elsiocb->context2)->virt);
 	memset(pcmd, 0, cmdsize);
 
-	*((uint32_t *) (pcmd)) = (ELS_CMD_ACC | (ELS_CMD_PRLI & ~ELS_RSP_MASK));
+	*((uint32_t *)(pcmd)) = elsrspcmd;
 	pcmd += sizeof(uint32_t);
 
 	/* For PRLI, remainder of payload is PRLI parameter page */
-- 
2.9.3
