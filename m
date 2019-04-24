From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 24 Apr 2019 11:43:23 -0700
Subject: [PATCH v2] nvmet-file: clamp-down file namespace lba_shift
Message-ID: <20190424184323.17935-1-sagi@grimberg.me>

When the backing file is a tempfile for example, the inode i_blkbits
can be 1M in size which causes problems for hosts to support as the
disk block size. Instead, expose the minimum between i_blkbits and
12 (4K sector size).

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Changes from v1:
- expose block size 4096 instead of PAGE_SIZE

 drivers/nvme/target/io-cmd-file.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index bc6ebb51b0bf..66013d8ad94b 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -49,7 +49,12 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 		goto err;
 
 	ns->size = stat.size;
-	ns->blksize_shift = file_inode(ns->file)->i_blkbits;
+	/*
+	 * inode i_blkbits can be greater than the universally accepted upper
+	 * bound so make sure we export we export a sane namespace lba_shift.
+	 */
+	ns->blksize_shift = min_t(u8,
+			file_inode(ns->file)->i_blkbits, 12);
 
 	ns->bvec_cache = kmem_cache_create("nvmet-bvec",
 			NVMET_MAX_MPOOL_BVEC * sizeof(struct bio_vec),
-- 
2.17.1
