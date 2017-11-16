From: jsmart2021@gmail.com (James Smart)
Date: Wed, 15 Nov 2017 17:00:21 -0800
Subject: [PATCH] nvmet_fc: fix better length checking
Message-ID: <20171116010021.12308-1-jsmart2021@gmail.com>

Reorganize nvmet_fc_handle_fcp_rqst() so that the nvmet req.transfer_len
field is set after the call nvmet_req_init(). An update to nvmet now
has nvmet_req_init() clearing the field, thus the fc transport was losing
the value.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/fc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 739b8feadc7d..664d3013f68f 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -2144,6 +2144,7 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 			struct nvmet_fc_fcp_iod *fod)
 {
 	struct nvme_fc_cmd_iu *cmdiu = &fod->cmdiubuf;
+	u32 xfrlen = be32_to_cpu(cmdiu->data_len);
 	int ret;
 
 	/*
@@ -2157,7 +2158,6 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 
 	fod->fcpreq->done = nvmet_fc_xmt_fcp_op_done;
 
-	fod->req.transfer_len = be32_to_cpu(cmdiu->data_len);
 	if (cmdiu->flags & FCNVME_CMD_FLAGS_WRITE) {
 		fod->io_dir = NVMET_FCP_WRITE;
 		if (!nvme_is_write(&cmdiu->sqe))
@@ -2168,7 +2168,7 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 			goto transport_error;
 	} else {
 		fod->io_dir = NVMET_FCP_NODATA;
-		if (fod->req.transfer_len)
+		if (xfrlen)
 			goto transport_error;
 	}
 
@@ -2192,6 +2192,8 @@ nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 		return;
 	}
 
+	fod->req.transfer_len = xfrlen;
+
 	/* keep a running counter of tail position */
 	atomic_inc(&fod->queue->sqtail);
 
-- 
2.13.1
