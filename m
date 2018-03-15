From: himanshu.madhani@cavium.com (Himanshu Madhani)
Date: Wed, 14 Mar 2018 20:34:55 -0700
Subject: [PATCH v2 04/13] qla2xxx: Restore ZIO threshold setting
In-Reply-To: <20180315033504.12628-1-himanshu.madhani@cavium.com>
References: <20180315033504.12628-1-himanshu.madhani@cavium.com>
Message-ID: <20180315033504.12628-5-himanshu.madhani@cavium.com>

From: Darren Trapp <darren.trapp@cavium.com>

Signed-off-by: Darren Trapp <darren.trapp at cavium.com>
Signed-off-by: Himanshu Madhani <himanshu.madhani at cavium.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
---
 drivers/scsi/qla2xxx/qla_nvme.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_nvme.c b/drivers/scsi/qla2xxx/qla_nvme.c
index a8e81fc14c44..5ee447680ddd 100644
--- a/drivers/scsi/qla2xxx/qla_nvme.c
+++ b/drivers/scsi/qla2xxx/qla_nvme.c
@@ -464,11 +464,6 @@ static int qla2x00_start_nvme_mq(srb_t *sp)
 	/* Set chip new ring index. */
 	WRT_REG_DWORD(req->req_q_in, req->ring_index);
 
-	/* Manage unprocessed RIO/ZIO commands in response queue. */
-	if (vha->flags.process_response_queue &&
-	    rsp->ring_ptr->signature != RESPONSE_PROCESSED)
-		qla24xx_process_response_queue(vha, rsp);
-
 queuing_error:
 	spin_unlock_irqrestore(&qpair->qp_lock, flags);
 	return rval;
-- 
2.12.0
