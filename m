From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Oct 2015 07:58:46 +0200
Subject: [PATCH 16/18] nvme: move the call to nvme_init_identify earlier
In-Reply-To: <1444975128-8768-1-git-send-email-hch@lst.de>
References: <1444975128-8768-1-git-send-email-hch@lst.de>
Message-ID: <1444975128-8768-17-git-send-email-hch@lst.de>

We want to record the identify and CAP values even if no I/O queue
is available.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7a25d6f..adff1cb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1989,12 +1989,6 @@ static void nvme_dev_scan(struct work_struct *work)
  */
 static int nvme_dev_add(struct nvme_dev *dev)
 {
-	int res;
-
-	res = nvme_init_identify(&dev->ctrl);
-	if (res)
-		return res;
-
 	if (!dev->tagset.tags) {
 		dev->tagset.ops = &nvme_mq_ops;
 		dev->tagset.nr_hw_queues = dev->online_queues - 1;
@@ -2484,6 +2478,10 @@ static void nvme_probe_work(struct work_struct *work)
 	if (result)
 		goto disable;
 
+	result = nvme_init_identify(&dev->ctrl);
+	if (result)
+		goto free_tags;
+
 	result = nvme_setup_io_queues(dev);
 	if (result)
 		goto free_tags;
-- 
1.9.1
