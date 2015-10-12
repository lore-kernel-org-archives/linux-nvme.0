From: hch@lst.de (Christoph Hellwig)
Date: Mon, 12 Oct 2015 09:10:09 +0200
Subject: [PATCH 6/8] nvme: move the call to nvme_init_identify earlier
In-Reply-To: <1444633811-28319-1-git-send-email-hch@lst.de>
References: <1444633811-28319-1-git-send-email-hch@lst.de>
Message-ID: <1444633811-28319-7-git-send-email-hch@lst.de>

We want to record the identify and CAP values even if no I/O queue
is available.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 54868eb..dae06f4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2048,12 +2048,6 @@ static void nvme_dev_scan(struct work_struct *work)
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
@@ -2543,6 +2537,10 @@ static void nvme_probe_work(struct work_struct *work)
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
