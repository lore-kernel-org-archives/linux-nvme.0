From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 18 Apr 2018 14:59:59 -0400
Subject: [PATCH 08/20] nvmet: configure file backed ns for sync IO
In-Reply-To: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180418190011.3973-9-chaitanya.kulkarni@wdc.com>

This patch allows file backed namespaces to use newly
introduced configfs attribute sync, when sync is set
we open the file with O_SYNC and use the work queue
to execute the NVMe read/write commands.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/core.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b7c51a5629bf..4d25038ed05c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -305,9 +305,10 @@ int nvmet_vfs_stat(const char *filename, struct kstat *stat)
 static int nvmet_ns_enable_file(struct nvmet_ns *ns)
 {
 	int ret;
-	int flags = O_RDWR | O_LARGEFILE | O_DIRECT;
+	int flags = O_RDWR | O_LARGEFILE;
 	struct kstat stat;
 
+	flags |= ns->sync ? O_SYNC : O_DIRECT;
 	ns->filp = filp_open(ns->device_path, flags, 0);
 	if (!ns->filp || IS_ERR(ns->filp)) {
 		pr_err("failed to open file %s: (%ld)\n",
@@ -323,6 +324,15 @@ static int nvmet_ns_enable_file(struct nvmet_ns *ns)
 	ns->size = stat.size;
 	ns->blksize_shift = ns->filp->f_inode->i_blkbits;
 
+	if (ns->sync) {
+		ns->file_wq = alloc_workqueue("nvmet-file",
+				WQ_UNBOUND_MAX_ACTIVE | WQ_MEM_RECLAIM, 0);
+
+		if (!ns->file_wq) {
+			ret = -1;
+			goto err;
+		}
+	}
 	return ret;
 err:
 	filp_close(ns->filp, NULL);
@@ -352,6 +362,11 @@ static void nvmet_ns_dev_disable(struct nvmet_ns *ns)
 		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
 		ns->bdev = NULL;
 	} else if (ns->filp) {
+		if (ns->sync) {
+			flush_workqueue(ns->file_wq);
+			destroy_workqueue(ns->file_wq);
+			ns->file_wq = NULL;
+		}
 		filp_close(ns->filp, NULL);
 		ns->filp = NULL;
 	} else
@@ -470,6 +485,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	ns->nsid = nsid;
 	ns->subsys = subsys;
 	uuid_gen(&ns->uuid);
+	ns->sync = false;
 
 	return ns;
 }
-- 
2.14.1
