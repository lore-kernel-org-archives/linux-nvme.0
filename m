From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Tue, 19 Mar 2019 16:41:13 +0200
Subject: [PATCH 6/9] nvme/pci: init shadow doorbell after each reset
In-Reply-To: <20190319144116.400-1-mlevitsk@redhat.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
Message-ID: <20190319144116.400-7-mlevitsk@redhat.com>

The spec states
"The settings are not retained across a Controller Level Reset"
Therefore the driver must enable the shadow doorbell,
after each reset.

This was caught while testing the nvme driver over
upcoming nvme-mdev device

Signed-off-by: Maxim Levitsky <mlevitsk at redhat.com>
---
 drivers/nvme/host/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a188ab6ffaf8..806b551d3582 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2347,8 +2347,6 @@ static int nvme_dev_add(struct nvme_dev *dev)
 			return ret;
 		}
 		dev->ctrl.tagset = &dev->tagset;
-
-		nvme_dbbuf_set(dev);
 	} else {
 		blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);
 
@@ -2356,6 +2354,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		nvme_free_queues(dev, dev->online_queues);
 	}
 
+	nvme_dbbuf_set(dev);
 	return 0;
 }
 
-- 
2.17.2
