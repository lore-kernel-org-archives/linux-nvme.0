From: zhangweiping@didichuxing.com (weiping zhang)
Date: Mon, 10 Jul 2017 18:14:13 +0800
Subject: [PATCH] nvme-pci: fix build error for commit:bc565c15a4fa
Message-ID: <20170710101413.GA22356@localhost.didichuxing.com>

fix build error for:
bc565c15a4fa nvme-pci: add module parameter for io queue depth

Signed-off-by: weiping zhang <zhangweiping at didichuxing.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8470503..48d3ed3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1912,7 +1912,8 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	dev->ctrl.cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
 
-	dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, io_queue_depth);
+	dev->q_depth = min_t(int, NVME_CAP_MQES(dev->ctrl.cap) + 1,
+				io_queue_depth);
 	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
 	dev->dbs = dev->bar + 4096;
 
-- 
2.9.4
