From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Thu,  2 May 2019 14:31:33 +0300
Subject: [PATCH 1/2] nvme/pci: init shadow doorbell after each reset
In-Reply-To: <20190502113134.20835-1-mlevitsk@redhat.com>
References: <20190502113134.20835-1-mlevitsk@redhat.com>
Message-ID: <20190502113134.20835-2-mlevitsk@redhat.com>

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
index 1f468a16efad..1c844c66ecaa 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2303,8 +2303,6 @@ static int nvme_dev_add(struct nvme_dev *dev)
 			return ret;
 		}
 		dev->ctrl.tagset = &dev->tagset;
-
-		nvme_dbbuf_set(dev);
 	} else {
 		blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);
 
@@ -2312,6 +2310,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		nvme_free_queues(dev, dev->online_queues);
 	}
 
+	nvme_dbbuf_set(dev);
 	return 0;
 }
 
-- 
2.17.2
