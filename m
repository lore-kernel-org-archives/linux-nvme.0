From: shan.hai@oracle.com (Shan Hai)
Date: Fri, 21 Dec 2018 14:04:13 +0800
Subject: [PATCH 2/2] nvme-pci: take the io_queue_number into account when
 setting number of io queues
In-Reply-To: <1545372253-28025-1-git-send-email-shan.hai@oracle.com>
References: <1545372253-28025-1-git-send-email-shan.hai@oracle.com>
Message-ID: <1545372253-28025-2-git-send-email-shan.hai@oracle.com>

Add a wrapper around num_possible_cpus() to take the new added module
parameter account when setting number of io queues.

Signed-off-by: Shan Hai <shan.hai at oracle.com>
---
 drivers/nvme/host/pci.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0d60451..e359e90 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -219,6 +219,11 @@ struct nvme_iod {
 	struct scatterlist inline_sg[0];
 };
 
+static inline unsigned int nvme_io_queue_number(void)
+{
+	return min_t(unsigned int, io_queue_number, num_possible_cpus());
+}
+
 /*
  * Check we didin't inadvertently grow the command struct
  */
@@ -241,7 +246,7 @@ static inline void _nvme_check_size(void)
 
 static inline unsigned int nvme_dbbuf_size(u32 stride)
 {
-	return ((num_possible_cpus() + 1) * 8 * stride);
+	return ((nvme_io_queue_number() + 1) * 8 * stride);
 }
 
 static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
@@ -1923,7 +1928,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 		.pre_vectors = 1
 	};
 
-	nr_io_queues = num_possible_cpus();
+	nr_io_queues = nvme_io_queue_number();
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
 	if (result < 0)
 		return result;
@@ -2512,7 +2517,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!dev)
 		return -ENOMEM;
 
-	dev->queues = kcalloc_node(num_possible_cpus() + 1,
+	dev->queues = kcalloc_node(nvme_io_queue_number() + 1,
 			sizeof(struct nvme_queue), GFP_KERNEL, node);
 	if (!dev->queues)
 		goto free;
-- 
2.7.4
