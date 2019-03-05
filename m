From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue,  5 Mar 2019 01:55:48 -0800
Subject: [PATCH] nvmet-file: clamp-down file namespace lba_shift
Message-ID: <20190305095548.14934-1-sagi@grimberg.me>

When the backing file is a tempfile for example, the inode i_blkbits
can be 1M in size which causes problems for hosts to support as the
disk block size.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
This issue was observed in I/O errors in the log running test nvme/009.

 drivers/nvme/target/io-cmd-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 517522305e5c..5008826cbd6a 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -49,7 +49,7 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 		goto err;
 
 	ns->size = stat.size;
-	ns->blksize_shift = file_inode(ns->file)->i_blkbits;
+	ns->blksize_shift = min_t(u8, file_inode(ns->file)->i_blkbits, PAGE_SHIFT);
 
 	ns->bvec_cache = kmem_cache_create("nvmet-bvec",
 			NVMET_MAX_MPOOL_BVEC * sizeof(struct bio_vec),
-- 
2.17.1
