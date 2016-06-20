From: m.mizuma@jp.fujitsu.com (Masayoshi Mizuma)
Date: Mon, 20 Jun 2016 09:33:17 +0900
Subject: [PATCH] nvme: avoid crashes when node 0 is memoryless node.
Message-ID: <576739CD.2010002@jp.fujitsu.com>

When CONFIG_NUMA is enabled and node 0 is memoryless, the system
crashes because nvme_probe() sets the device->numa_node to 0 by
set_dev_node(&pdev->dev, 0), so it tries to allocate memory from node 0.
To avoid the crash, we should change the 0 to first_memory_node.

Signed-off-by: Masayoshi Mizuma <m.mizuma at jp.fujitsu.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index befac5b..a14d5e0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1940,7 +1940,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	node = dev_to_node(&pdev->dev);
 	if (node == NUMA_NO_NODE)
-		set_dev_node(&pdev->dev, 0);
+		set_dev_node(&pdev->dev, first_memory_node);
 
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
 	if (!dev)
-- 
1.8.3.1
