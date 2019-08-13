From: m.malygin@yadro.com (Mikhail Malygin)
Date: Tue, 13 Aug 2019 12:31:57 +0300
Subject: [PATCH] nvmet: read device size in identify-ns command handler
Message-ID: <20190813093157.21755-1-m.malygin@yadro.com>

Currently device size is cached in ns->size field on namespace enable, so
any device size change after that can't bee seen by initiator.
This patch updates ns->size field in identify-ns command handler,
so initiator can see new device size after ns-rescan.

Signed-off-by: Mikhail Malygin <m.malygin at yadro.com>
---
 drivers/nvme/target/admin-cmd.c   |  6 ++++++
 drivers/nvme/target/io-cmd-bdev.c | 10 ++++++++--
 drivers/nvme/target/io-cmd-file.c | 32 ++++++++++++++++++++-----------
 drivers/nvme/target/nvmet.h       |  2 ++
 4 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 4dc12ea52f23..578e78628cf3 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -428,6 +428,12 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	if (!ns)
 		goto done;
 
+	if(ns->bdev)
+		nvmet_bdev_read_size(ns);
+
+	if(ns->file)
+		nvmet_file_read_size(ns);
+
 	/*
 	 * nuse = ncap = nsze isn't always true, but we have no way to find
 	 * that out from the underlying device.
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index de0bff70ebb6..1c2e3a4bb4fb 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -47,6 +47,13 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	id->nows = to0based(ql->io_opt / ql->logical_block_size);
 }
 
+int nvmet_bdev_read_size(struct nvmet_ns *ns)
+{
+	ns->size = i_size_read(ns->bdev->bd_inode);
+	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
+	return 0;
+}
+
 int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 {
 	int ret;
@@ -62,8 +69,7 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 		ns->bdev = NULL;
 		return ret;
 	}
-	ns->size = i_size_read(ns->bdev->bd_inode);
-	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
+	nvmet_bdev_read_size(ns);
 	return 0;
 }
 
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 05453f5d1448..7fd1da37b5a8 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -27,10 +27,28 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns)
 	}
 }
 
+int nvmet_file_read_size(struct nvmet_ns *ns)
+{
+	struct kstat stat;
+	int ret = vfs_getattr(&ns->file->f_path,
+                        &stat, STATX_SIZE, AT_STATX_FORCE_SYNC);
+
+	if(!ret){
+		ns->size = stat.size;
+		/*
+		 * i_blkbits can be greater than the universally accepted upper bound,
+		 * so make sure we export a sane namespace lba_shift.
+		 */
+		ns->blksize_shift = min_t(u8,
+		file_inode(ns->file)->i_blkbits, 12);
+	}
+
+	return ret;
+}
+
 int nvmet_file_ns_enable(struct nvmet_ns *ns)
 {
 	int flags = O_RDWR | O_LARGEFILE;
-	struct kstat stat;
 	int ret;
 
 	if (!ns->buffered_io)
@@ -43,19 +61,11 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 		return PTR_ERR(ns->file);
 	}
 
-	ret = vfs_getattr(&ns->file->f_path,
-			&stat, STATX_SIZE, AT_STATX_FORCE_SYNC);
+	ret = nvmet_file_read_size(ns);
+
 	if (ret)
 		goto err;
 
-	ns->size = stat.size;
-	/*
-	 * i_blkbits can be greater than the universally accepted upper bound,
-	 * so make sure we export a sane namespace lba_shift.
-	 */
-	ns->blksize_shift = min_t(u8,
-			file_inode(ns->file)->i_blkbits, 12);
-
 	ns->bvec_cache = kmem_cache_create("nvmet-bvec",
 			NVMET_MAX_MPOOL_BVEC * sizeof(struct bio_vec),
 			0, SLAB_HWCACHE_ALIGN, NULL);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6ee66c610739..19b6ac97e0c6 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -484,6 +484,8 @@ void nvmet_bdev_ns_disable(struct nvmet_ns *ns);
 void nvmet_file_ns_disable(struct nvmet_ns *ns);
 u16 nvmet_bdev_flush(struct nvmet_req *req);
 u16 nvmet_file_flush(struct nvmet_req *req);
+int nvmet_bdev_read_size(struct nvmet_ns *ns);
+int nvmet_file_read_size(struct nvmet_ns *ns);
 void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid);
 
 static inline u32 nvmet_rw_len(struct nvmet_req *req)
-- 
2.20.1
