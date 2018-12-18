From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Mon, 17 Dec 2018 22:42:03 -0500
Subject: [PATCH] nvme-core: add support for Write-Zeroes command
Message-ID: <20181218034203.22256-1-chaitanya.kulkarni@wdc.com>

Allow write zeroes operations (REQ_OP_WRITE_ZEROES) on the block
device, if the device supports an optional command bit set for write
zeroes. Add support to setup write zeroes command. Set maximum possible
write zeroes sectors in one write zeroes command according to
nvme write zeroes command definition.

This patch was posted as a part of block-write-zeroes support
implementation (https://patchwork.kernel.org/patch/9454859/),
but did not make into mainline kernel as it got reverted due to
failure on the Linus's machine.

In this patch in order to be more cautious, we use NVMe controller's
maximum hardware sector size which is calculated based on the
controller's MDTS (Maximum Data Transfer Size) field to calculate
the maximum sectors for the write zeroes request.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/host/core.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 136512e8ba58..ce7b246211b6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -611,6 +611,18 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	return BLK_STS_OK;
 }
 
+static inline void nvme_setup_write_zeroes(struct nvme_ns *ns,
+		struct request *req, struct nvme_command *cmnd)
+{
+	cmnd->write_zeroes.opcode = nvme_cmd_write_zeroes;
+	cmnd->write_zeroes.nsid = cpu_to_le32(ns->head->ns_id);
+	cmnd->write_zeroes.slba =
+		cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
+	cmnd->write_zeroes.length =
+		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
+	cmnd->write_zeroes.control = 0;
+}
+
 static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		struct request *req, struct nvme_command *cmnd)
 {
@@ -705,7 +717,8 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 		nvme_setup_flush(ns, cmd);
 		break;
 	case REQ_OP_WRITE_ZEROES:
-		/* currently only aliased to deallocate for a few ctrls: */
+		nvme_setup_write_zeroes(ns, req, cmd);
+		break;
 	case REQ_OP_DISCARD:
 		ret = nvme_setup_discard(ns, req, cmd);
 		break;
@@ -1481,6 +1494,37 @@ static void nvme_config_discard(struct nvme_ns *ns)
 		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
 }
 
+static inline void nvme_config_write_zeroes(struct nvme_ns *ns)
+{
+	u32 max_sectors;
+	unsigned short bs = 1 << ns->lba_shift;
+
+	if (!(ns->ctrl->oncs & NVME_CTRL_ONCS_WRITE_ZEROES))
+		return;
+	/*
+	 * Even though NVMe spec explicitly states that MDTS is not
+	 * applicable to the write-zeroes:- "The restriction does not apply to
+	 * commands that do not transfer data between the host and the
+	 * controller (e.g., Write Uncorrectable ro Write Zeroes command).".
+	 * In order to be more cautious use controller's max_hw_sectors value
+	 * to configure the maximum sectors for the write-zeroes which is
+	 * configured based on the controller's MDTS field in the
+	 * nvme_init_identify() if available.
+	 */
+	if (ns->ctrl->max_hw_sectors == UINT_MAX)
+		max_sectors = ((u32)(USHRT_MAX + 1) * bs) >> 9;
+	else
+		max_sectors = ((u32)(ns->ctrl->max_hw_sectors + 1) * bs) >> 9;
+
+	blk_queue_max_write_zeroes_sectors(ns->queue, max_sectors);
+}
+
+static inline void nvme_ns_config_oncs(struct nvme_ns *ns)
+{
+	nvme_config_discard(ns);
+	nvme_config_write_zeroes(ns);
+}
+
 static void nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
 		struct nvme_id_ns *id, struct nvme_ns_ids *ids)
 {
@@ -1534,7 +1578,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		capacity = 0;
 
 	set_capacity(disk, capacity);
-	nvme_config_discard(ns);
+	nvme_ns_config_oncs(ns);
 
 	if (id->nsattr & (1 << 0))
 		set_disk_ro(disk, true);
-- 
2.14.1
