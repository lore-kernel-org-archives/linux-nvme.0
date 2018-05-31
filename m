From: weiyongjun1@huawei.com (Wei Yongjun)
Date: Thu, 31 May 2018 11:41:30 +0000
Subject: [PATCH -next] nvmet: fix error return code in nvmet_file_ns_enable()
Message-ID: <1527766890-72455-1-git-send-email-weiyongjun1@huawei.com>

Fix to return error code -ENOMEM from the memory alloc fail error
handling case instead of 0, as done elsewhere in this function.

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Signed-off-by: Wei Yongjun <weiyongjun1 at huawei.com>
---
 drivers/nvme/target/io-cmd-file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index ca1ccf8..e9d6ce4 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -49,14 +49,18 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 	ns->bvec_cache = kmem_cache_create("nvmet-bvec",
 			NVMET_MAX_MPOOL_BVEC * sizeof(struct bio_vec),
 			0, SLAB_HWCACHE_ALIGN, NULL);
-	if (!ns->bvec_cache)
+	if (!ns->bvec_cache) {
+		ret = -ENOMEM;
 		goto err;
+	}
 
 	ns->bvec_pool = mempool_create(NVMET_MIN_MPOOL_OBJ, mempool_alloc_slab,
 			mempool_free_slab, ns->bvec_cache);
 
-	if (!ns->bvec_pool)
+	if (!ns->bvec_pool) {
+		ret = -ENOMEM;
 		goto err;
+	}
 
 	return ret;
 err:
