From: keith.busch@intel.com (Keith Busch)
Date: Tue,  8 Jul 2014 11:42:39 -0600
Subject: [PATCH 2/2] NVMe: Implement WRITE_ZEROS support
In-Reply-To: <1404841359-24595-1-git-send-email-keith.busch@intel.com>
References: <1404841359-24595-1-git-send-email-keith.busch@intel.com>
Message-ID: <1404841359-24595-2-git-send-email-keith.busch@intel.com>

Adds WRITE_ZEROS block device command support if the NVMe device supports
this optional command.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   24 ++++++++++++++++++++++++
 include/uapi/linux/nvme.h |    2 ++
 2 files changed, 26 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 28aec2d..5d8664c 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -668,6 +668,26 @@ static int nvme_submit_flush(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	return 0;
 }
 
+static int nvme_submit_write_zeros(struct nvme_queue *nvmeq, struct nvme_ns *ns,
+						struct bio * bio, int cmdid)
+{
+	struct nvme_command *cmnd = &nvmeq->sq_cmds[nvmeq->sq_tail];
+
+	memset(cmnd, 0, sizeof(*cmnd));
+	cmnd->rw.opcode = nvme_cmd_write_zeros;
+	cmnd->rw.command_id = cmdid;
+	cmnd->rw.nsid = cpu_to_le32(ns->ns_id);
+	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, bio->bi_iter.bi_sector));
+	cmnd->rw.length =
+		cpu_to_le16((bio->bi_iter.bi_size >> ns->lba_shift) - 1);
+
+	if (++nvmeq->sq_tail == nvmeq->q_depth)
+		nvmeq->sq_tail = 0;
+	writel(nvmeq->sq_tail, nvmeq->q_db);
+
+	return 0;
+}
+
 static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod)
 {
 	struct bio *bio = iod->private;
@@ -685,6 +705,8 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod)
 		return nvme_submit_discard(nvmeq, ns, bio, iod, cmdid);
 	if (bio->bi_rw & REQ_FLUSH)
 		return nvme_submit_flush(nvmeq, ns, cmdid);
+	if (bio->bi_rw & REQ_WRITE_ZEROS)
+		return nvme_submit_write_zeros(nvmeq, ns, bio, cmdid);
 
 	control = 0;
 	if (bio->bi_rw & REQ_FUA)
@@ -2011,6 +2033,8 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid,
 
 	if (dev->oncs & NVME_CTRL_ONCS_DSM)
 		nvme_config_discard(ns);
+	if (dev->oncs & NVME_CTRL_ONCS_WRITE_ZEROS)
+		blk_queue_max_write_zeros_sectors(ns->queue, 0xffffffff);
 
 	return ns;
 
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index 134518b..16040b7 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -89,6 +89,7 @@ enum {
 	NVME_CTRL_ONCS_COMPARE			= 1 << 0,
 	NVME_CTRL_ONCS_WRITE_UNCORRECTABLE	= 1 << 1,
 	NVME_CTRL_ONCS_DSM			= 1 << 2,
+	NVME_CTRL_ONCS_WRITE_ZEROS		= 1 << 3,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 };
 
@@ -189,6 +190,7 @@ enum nvme_opcode {
 	nvme_cmd_read		= 0x02,
 	nvme_cmd_write_uncor	= 0x04,
 	nvme_cmd_compare	= 0x05,
+	nvme_cmd_write_zeros	= 0x08,
 	nvme_cmd_dsm		= 0x09,
 };
 
-- 
1.7.10.4
