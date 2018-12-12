From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 12 Dec 2018 15:11:42 -0800
Subject: [PATCH V2 06/12] nvmet: add error log support for bdev backend
In-Reply-To: <20181212231148.4107-1-chaitanya.kulkarni@wdc.com>
References: <20181212231148.4107-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20181212231148.4107-7-chaitanya.kulkarni@wdc.com>

This patch adds the support for the block device backend to populate the
error log entries. Here we map the blk_status_t to the NVMe status.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 84 ++++++++++++++++++++++++++-----
 1 file changed, 72 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index c1cb2ed5531c..8a70c58d4246 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -44,13 +44,69 @@ void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
 	}
 }
 
+static u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
+{
+	u16 status = NVME_SC_SUCCESS;
+
+	if (likely(blk_sts == BLK_STS_OK))
+		return status;
+	/*
+	 * Right now there exists M : 1 mapping between block layer error
+	 * to the NVMe status code (see nvme_error_status()). For consistency,
+	 * when we reverse map we use most appropriate NVMe Status code from
+	 * the group of the NVMe staus codes used in the nvme_error_status().
+	 */
+	switch (blk_sts) {
+	case BLK_STS_NOSPC:
+		status = NVME_SC_CAP_EXCEEDED | NVME_SC_DNR;
+		req->error_loc = offsetof(struct nvme_rw_command, length);
+		break;
+	case BLK_STS_TARGET:
+		status = NVME_SC_LBA_RANGE | NVME_SC_DNR;
+		req->error_loc = offsetof(struct nvme_rw_command, slba);
+		break;
+	case BLK_STS_NOTSUPP:
+		req->error_loc = offsetof(struct nvme_common_command, opcode);
+		switch (req->cmd->common.opcode) {
+		case nvme_cmd_dsm:
+		case nvme_cmd_write_zeroes:
+			status = NVME_SC_ONCS_NOT_SUPPORTED | NVME_SC_DNR;
+			break;
+		default:
+			status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		}
+		break;
+	case BLK_STS_MEDIUM:
+		status = NVME_SC_ACCESS_DENIED;
+		req->error_loc = offsetof(struct nvme_rw_command, nsid);
+		break;
+	case BLK_STS_IOERR:
+		/* fallthru */
+	default:
+		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		req->error_loc = offsetof(struct nvme_common_command, opcode);
+	}
+
+	switch (req->cmd->common.opcode) {
+	case nvme_cmd_read:
+	case nvme_cmd_write:
+		req->error_slba = le64_to_cpu(req->cmd->rw.slba);
+		break;
+	case nvme_cmd_write_zeroes:
+		req->error_slba =
+			le64_to_cpu(req->cmd->write_zeroes.slba);
+		break;
+	default:
+		req->error_slba = 0;
+	}
+	return status;
+}
+
 static void nvmet_bio_done(struct bio *bio)
 {
 	struct nvmet_req *req = bio->bi_private;
 
-	nvmet_req_complete(req,
-		bio->bi_status ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
-
+	nvmet_req_complete(req, blk_to_nvme_status(req, bio->bi_status));
 	if (bio != &req->b.inline_bio)
 		bio_put(bio);
 }
@@ -137,18 +193,21 @@ u16 nvmet_bdev_flush(struct nvmet_req *req)
 	return 0;
 }
 
-static u16 nvmet_bdev_discard_range(struct nvmet_ns *ns,
+static u16 nvmet_bdev_discard_range(struct nvmet_req *req,
 		struct nvme_dsm_range *range, struct bio **bio)
 {
+	struct nvmet_ns *ns = req->ns;
 	int ret;
 
 	ret = __blkdev_issue_discard(ns->bdev,
 			le64_to_cpu(range->slba) << (ns->blksize_shift - 9),
 			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
 			GFP_KERNEL, 0, bio);
-	if (ret && ret != -EOPNOTSUPP)
-		return NVME_SC_INTERNAL | NVME_SC_DNR;
-	return 0;
+
+	if (ret)
+		req->error_slba = le64_to_cpu(range->slba);
+
+	return blk_to_nvme_status(req, errno_to_blk_status(ret));
 }
 
 static void nvmet_bdev_execute_discard(struct nvmet_req *req)
@@ -164,7 +223,7 @@ static void nvmet_bdev_execute_discard(struct nvmet_req *req)
 		if (status)
 			break;
 
-		status = nvmet_bdev_discard_range(req->ns, &range, &bio);
+		status = nvmet_bdev_discard_range(req, &range, &bio);
 		if (status)
 			break;
 	}
@@ -205,16 +264,16 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	u16 status = NVME_SC_SUCCESS;
 	sector_t sector;
 	sector_t nr_sector;
+	int ret;
 
 	sector = le64_to_cpu(write_zeroes->slba) <<
 		(req->ns->blksize_shift - 9);
 	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
 		(req->ns->blksize_shift - 9));
 
-	if (__blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
-				GFP_KERNEL, &bio, 0))
-		status = NVME_SC_INTERNAL | NVME_SC_DNR;
-
+	ret = __blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
+			GFP_KERNEL, &bio, 0);
+	status = blk_to_nvme_status(req, errno_to_blk_status(ret));
 	if (bio) {
 		bio->bi_private = req;
 		bio->bi_end_io = nvmet_bio_done;
@@ -249,6 +308,7 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 	default:
 		pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
 		       req->sq->qid);
+		req->error_loc = offsetof(struct nvme_common_command, opcode);
 		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
 }
-- 
2.17.0
