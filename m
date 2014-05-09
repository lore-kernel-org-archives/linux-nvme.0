From: sbradshaw@micron.com (Sam Bradshaw)
Date: Fri, 9 May 2014 13:44:47 -0700
Subject: [PATCH] Remove redundant writes to uncached sqe memory
Message-ID: <536D3E3F.9050902@micron.com>

The memset to clear the SQE in nvme_submit_iod() is made partially 
redundant by subsequent writes.  This patch explicitly clears each 
SQE structure member in ascending order, eliminating the need for 
the memset.  With this change, our perf runs show ~1.5% less time
spent in the IO submission path and minor reduced q lock contention.

Signed-off-by: Sam Bradshaw <sbradshaw at micron.com>
---
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index cd8a8bc..a9bdcbd 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -655,11 +655,12 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod)
 		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
 
 	cmnd = &nvmeq->sq_cmds[nvmeq->sq_tail];
-	memset(cmnd, 0, sizeof(*cmnd));
 
 	cmnd->rw.opcode = bio_data_dir(bio) ? nvme_cmd_write : nvme_cmd_read;
+	cmnd->rw.flags = 0;
 	cmnd->rw.command_id = cmdid;
 	cmnd->rw.nsid = cpu_to_le32(ns->ns_id);
+	cmnd->rw.rsvd2 = 0;
 	cmnd->rw.prp1 = cpu_to_le64(sg_dma_address(iod->sg));
 	cmnd->rw.prp2 = cpu_to_le64(iod->first_dma);
 	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, bio->bi_iter.bi_sector));
@@ -667,6 +668,9 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod)
 		cpu_to_le16((bio->bi_iter.bi_size >> ns->lba_shift) - 1);
 	cmnd->rw.control = cpu_to_le16(control);
 	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
+	cmnd->rw.reftag = 0;
+	cmnd->rw.apptag = 0;
+	cmnd->rw.appmask = 0;
 
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
