From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 18 Apr 2018 14:59:54 -0400
Subject: [PATCH 03/20] nvmet: add structure members for file I/O
In-Reply-To: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180418190011.3973-4-chaitanya.kulkarni@wdc.com>

This patch adds new members to perform I/O operations on the
file backed namespaces.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/nvmet.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 417f6c0331cc..acc61ca97198 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -26,6 +26,7 @@
 #include <linux/configfs.h>
 #include <linux/rcupdate.h>
 #include <linux/blkdev.h>
+#include <linux/fs.h>
 
 #define NVMET_ASYNC_EVENTS		4
 #define NVMET_ERROR_LOG_SLOTS		128
@@ -43,6 +44,7 @@ struct nvmet_ns {
 	struct list_head	dev_link;
 	struct percpu_ref	ref;
 	struct block_device	*bdev;
+	struct file		*filp;
 	u32			nsid;
 	u32			blksize_shift;
 	loff_t			size;
@@ -222,6 +224,8 @@ struct nvmet_req {
 	struct scatterlist	*sg;
 	struct bio		inline_bio;
 	struct bio_vec		inline_bvec[NVMET_MAX_INLINE_BIOVEC];
+	struct kiocb            iocb;
+	struct bio_vec          *bvec;
 	int			sg_cnt;
 	/* data length as parsed from the command: */
 	size_t			data_len;
-- 
2.14.1
