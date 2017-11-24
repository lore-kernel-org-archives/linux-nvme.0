From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 25 Nov 2017 03:03:00 +0900
Subject: [PATCH] nvme-pci: fix NULL pointer dereference in nvme_free_host_mem()
Message-ID: <1511546580-3165-1-git-send-email-minwoo.im.dev@gmail.com>

Following condition which will cause NULL pointer dereference will
occur in nvme_free_host_mem() when it tries to remove pci device via
nvme_remove() especially after a failure of host memory allocation for HMB.

    "(host_mem_descs == NULL) && (nr_host_mem_descs != 0)"

It's because __nr_host_mem_descs__ is not cleared to 0 unlike
__host_mem_descs__ is so.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6173747..f5800c3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1759,6 +1759,7 @@ static void nvme_free_host_mem(struct nvme_dev *dev)
 			dev->nr_host_mem_descs * sizeof(*dev->host_mem_descs),
 			dev->host_mem_descs, dev->host_mem_descs_dma);
 	dev->host_mem_descs = NULL;
+	dev->nr_host_mem_descs = 0;
 }
 
 static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
-- 
2.7.4
