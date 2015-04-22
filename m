From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Wed, 22 Apr 2015 16:26:55 +0200
Subject: [PATCH v3 6/7] nvme: rename and expose nvme_alloc_iod
In-Reply-To: <1429712816-10336-1-git-send-email-m@bjorling.me>
References: <1429712816-10336-1-git-send-email-m@bjorling.me>
Message-ID: <1429712816-10336-7-git-send-email-m@bjorling.me>

From: Javier Gonz?lez <javier@paletta.io>

Users of the kernel interface of the NVMe driver are limited to sending
custom commands without iod's.

By renaming __nvme_alloc_iod to nvme_alloc_phys_seg_iod and expose it
through the header file, an outside translation layer such as scsi or
lightnvm can integrate commands with iod structure.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 drivers/block/nvme-core.c | 9 ++++-----
 include/linux/nvme.h      | 2 ++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e23be20..8459fa8 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -413,9 +413,8 @@ static inline void iod_init(struct nvme_iod *iod, unsigned nbytes,
 	iod->nents = 0;
 }
 
-static struct nvme_iod *
-__nvme_alloc_iod(unsigned nseg, unsigned bytes, struct nvme_dev *dev,
-		 unsigned long priv, gfp_t gfp)
+struct nvme_iod *nvme_alloc_phys_seg_iod(unsigned nseg, unsigned bytes,
+			struct nvme_dev *dev, unsigned long priv, gfp_t gfp)
 {
 	struct nvme_iod *iod = kmalloc(sizeof(struct nvme_iod) +
 				sizeof(__le64 *) * nvme_npages(bytes, dev) +
@@ -446,7 +445,7 @@ static struct nvme_iod *nvme_alloc_iod(struct request *rq, struct nvme_dev *dev,
 		return iod;
 	}
 
-	return __nvme_alloc_iod(rq->nr_phys_segments, size, dev,
+	return nvme_alloc_phys_seg_iod(rq->nr_phys_segments, size, dev,
 				(unsigned long) rq, gfp);
 }
 
@@ -1699,7 +1698,7 @@ struct nvme_iod *nvme_map_user_pages(struct nvme_dev *dev, int write,
 	}
 
 	err = -ENOMEM;
-	iod = __nvme_alloc_iod(count, length, dev, 0, GFP_KERNEL);
+	iod = nvme_alloc_phys_seg_iod(count, length, dev, 0, GFP_KERNEL);
 	if (!iod)
 		goto put_pages;
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 0adad4a..f67adb6 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -168,6 +168,8 @@ int nvme_get_features(struct nvme_dev *dev, unsigned fid, unsigned nsid,
 			dma_addr_t dma_addr, u32 *result);
 int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
 			dma_addr_t dma_addr, u32 *result);
+struct nvme_iod *nvme_alloc_phys_seg_iod(unsigned nseg, unsigned bytes,
+			struct nvme_dev *dev, unsigned long priv, gfp_t gfp);
 
 struct sg_io_hdr;
 
-- 
1.9.1
