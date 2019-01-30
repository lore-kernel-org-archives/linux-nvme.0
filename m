From: keith.busch@intel.com (Keith Busch)
Date: Wed, 30 Jan 2019 10:38:22 -0700
Subject: [PATCH-for-5.1] nvme: Use discard for quirked write zeroes devices
Message-ID: <20190130173822.19457-1-keith.busch@intel.com>

The current devices that set NVME_QUIRK_DEALLOCATE_ZEROES don't support
the Write Zeroes NVMe command, but the driver still sets the queue limit
that enables REQ_OP_WRITE_ZEROES. Continue using Data Set Management for
such quirked controllers instead of the preferred Write Zeroes command.

Cc: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bde341f16e50..c365f0aa9433 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -611,9 +611,12 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	return BLK_STS_OK;
 }
 
-static inline void nvme_setup_write_zeroes(struct nvme_ns *ns,
+static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 		struct request *req, struct nvme_command *cmnd)
 {
+	if (ns->ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
+		return nvme_setup_discard(ns, req, cmnd);
+
 	cmnd->write_zeroes.opcode = nvme_cmd_write_zeroes;
 	cmnd->write_zeroes.nsid = cpu_to_le32(ns->head->ns_id);
 	cmnd->write_zeroes.slba =
@@ -621,6 +624,7 @@ static inline void nvme_setup_write_zeroes(struct nvme_ns *ns,
 	cmnd->write_zeroes.length =
 		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
 	cmnd->write_zeroes.control = 0;
+	return BLK_STS_OK;
 }
 
 static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
@@ -717,7 +721,7 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 		nvme_setup_flush(ns, cmd);
 		break;
 	case REQ_OP_WRITE_ZEROES:
-		nvme_setup_write_zeroes(ns, req, cmd);
+		ret = nvme_setup_write_zeroes(ns, req, cmd);
 		break;
 	case REQ_OP_DISCARD:
 		ret = nvme_setup_discard(ns, req, cmd);
-- 
2.14.4
