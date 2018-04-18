From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 18 Apr 2018 14:59:55 -0400
Subject: [PATCH 04/20] nvmet: initialize file handle and req fields
In-Reply-To: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180418190011.3973-5-chaitanya.kulkarni@wdc.com>

This patch adds support to manipulate file handle and initializes
the required fields for the file backed target ns.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/core.c | 62 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5f032dc7077f..b7c51a5629bf 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -289,9 +289,61 @@ static int nvmet_ns_enable_blk(struct nvmet_ns *ns)
 	return 0;
 }
 
+int nvmet_vfs_stat(const char *filename, struct kstat *stat)
+{
+	int ret;
+	mm_segment_t old_fs = get_fs();
+
+	set_fs(KERNEL_DS);
+	ret = vfs_stat(filename, stat);
+	if (ret)
+		pr_err("vfs_stat failed %s: %d\n", filename, ret);
+	set_fs(old_fs);
+	return ret;
+}
+
+static int nvmet_ns_enable_file(struct nvmet_ns *ns)
+{
+	int ret;
+	int flags = O_RDWR | O_LARGEFILE | O_DIRECT;
+	struct kstat stat;
+
+	ns->filp = filp_open(ns->device_path, flags, 0);
+	if (!ns->filp || IS_ERR(ns->filp)) {
+		pr_err("failed to open file %s: (%ld)\n",
+				ns->device_path, PTR_ERR(ns->bdev));
+		ns->filp = NULL;
+		return -1;
+	}
+
+	ret = nvmet_vfs_stat(ns->device_path, &stat);
+	if (ret)
+		goto err;
+
+	ns->size = stat.size;
+	ns->blksize_shift = ns->filp->f_inode->i_blkbits;
+
+	return ret;
+err:
+	filp_close(ns->filp, NULL);
+	ns->size = ns->blksize_shift = 0;
+	ns->filp = NULL;
+
+	return ret;
+}
+
 static int nvmet_ns_dev_enable(struct nvmet_ns *ns)
 {
-	return nvmet_ns_enable_blk(ns);
+	int ret = 0;
+	int ret1 = 0;
+
+	ret = nvmet_ns_enable_blk(ns);
+	if (ret)
+		ret1 = nvmet_ns_enable_file(ns);
+
+	if (ret && ret1)
+		return -1;
+	return 0;
 }
 
 static void nvmet_ns_dev_disable(struct nvmet_ns *ns)
@@ -299,7 +351,11 @@ static void nvmet_ns_dev_disable(struct nvmet_ns *ns)
 	if (ns->bdev) {
 		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
 		ns->bdev = NULL;
-	}
+	} else if (ns->filp) {
+		filp_close(ns->filp, NULL);
+		ns->filp = NULL;
+	} else
+		pr_err("invalid ns handle\n.");
 }
 
 int nvmet_ns_enable(struct nvmet_ns *ns)
@@ -533,6 +589,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->transfer_len = 0;
 	req->rsp->status = 0;
 	req->ns = NULL;
+	req->bvec = NULL;
+	memset(&req->iocb, 0, sizeof(req->iocb));
 
 	/* no support for fused commands yet */
 	if (unlikely(flags & (NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND))) {
-- 
2.14.1
