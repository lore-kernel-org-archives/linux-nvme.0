From: roman.penyaev@profitbricks.com (Roman Pen)
Date: Mon,  4 Jun 2018 14:29:57 +0200
Subject: [PATCH v2 2/8] nvmet-rdma: wrap raw kref_get/put() with corresponding
 helpers
In-Reply-To: <20180604123003.24748-1-roman.penyaev@profitbricks.com>
References: <20180604123003.24748-1-roman.penyaev@profitbricks.com>
Message-ID: <20180604123003.24748-3-roman.penyaev@profitbricks.com>

This is just a preparation patch: put kref_put() and kref_get_unless_zero()
inside helpers with more suitable names.

Signed-off-by: Roman Pen <roman.penyaev at profitbricks.de>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Steve Wise <swise at opengridcomputing.com>
Cc: Bart Van Assche <bart.vanassche at sandisk.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Doug Ledford <dledford at redhat.com>
Cc: linux-nvme at lists.infradead.org
---
 drivers/nvme/target/rdma.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 52e0c5d579a7..4304b8d8d027 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -775,7 +775,7 @@ static int nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev)
 	return ret;
 }
 
-static void nvmet_rdma_free_dev(struct kref *ref)
+static void nvmet_rdma_free_device(struct kref *ref)
 {
 	struct nvmet_rdma_device *ndev =
 		container_of(ref, struct nvmet_rdma_device, ref);
@@ -790,6 +790,16 @@ static void nvmet_rdma_free_dev(struct kref *ref)
 	kfree(ndev);
 }
 
+static int nvmet_rdma_dev_put(struct nvmet_rdma_device *dev)
+{
+	return kref_put(&dev->ref, nvmet_rdma_free_device);
+}
+
+static int nvmet_rdma_dev_get(struct nvmet_rdma_device *dev)
+{
+	return kref_get_unless_zero(&dev->ref);
+}
+
 static struct nvmet_rdma_device *
 nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
 {
@@ -799,7 +809,7 @@ nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
 	mutex_lock(&device_list_mutex);
 	list_for_each_entry(ndev, &device_list, entry) {
 		if (ndev->device->node_guid == cm_id->device->node_guid &&
-		    kref_get_unless_zero(&ndev->ref))
+		    nvmet_rdma_dev_get(ndev))
 			goto out_unlock;
 	}
 
@@ -945,8 +955,7 @@ static void nvmet_rdma_release_queue_work(struct work_struct *w)
 	struct nvmet_rdma_device *dev = queue->dev;
 
 	nvmet_rdma_free_queue(queue);
-
-	kref_put(&dev->ref, nvmet_rdma_free_dev);
+	nvmet_rdma_dev_put(dev);
 }
 
 static int
@@ -1163,7 +1172,7 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 	return 0;
 
 put_device:
-	kref_put(&ndev->ref, nvmet_rdma_free_dev);
+	nvmet_rdma_dev_put(ndev);
 
 	return ret;
 }
-- 
2.13.1
