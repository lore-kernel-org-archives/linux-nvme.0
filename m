From: roman.penyaev@profitbricks.com (Roman Pen)
Date: Mon,  4 Jun 2018 14:29:56 +0200
Subject: [PATCH v2 1/8] nvme-rdma: use ib_client API to wrap ib_device
In-Reply-To: <20180604123003.24748-1-roman.penyaev@profitbricks.com>
References: <20180604123003.24748-1-roman.penyaev@profitbricks.com>
Message-ID: <20180604123003.24748-2-roman.penyaev@profitbricks.com>

ib_client API provides a way to wrap an ib_device with a specific ULP
structure.  Using that API local lists and mutexes can be completely
avoided and allocation/removal paths become a bit cleaner.

Signed-off-by: Roman Pen <roman.penyaev at profitbricks.de>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Steve Wise <swise at opengridcomputing.com>
Cc: Bart Van Assche <bart.vanassche at sandisk.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Doug Ledford <dledford at redhat.com>
Cc: linux-nvme at lists.infradead.org
---
 drivers/nvme/host/rdma.c | 82 ++++++++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 44 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 1eb4438a8763..dd79250c9df4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -46,7 +46,6 @@ struct nvme_rdma_device {
 	struct ib_device	*dev;
 	struct ib_pd		*pd;
 	struct kref		ref;
-	struct list_head	entry;
 };
 
 struct nvme_rdma_qe {
@@ -124,9 +123,7 @@ static inline struct nvme_rdma_ctrl *to_rdma_ctrl(struct nvme_ctrl *ctrl)
 	return container_of(ctrl, struct nvme_rdma_ctrl, ctrl);
 }
 
-static LIST_HEAD(device_list);
-static DEFINE_MUTEX(device_list_mutex);
-
+static struct ib_client nvme_rdma_ib_client;
 static LIST_HEAD(nvme_rdma_ctrl_list);
 static DEFINE_MUTEX(nvme_rdma_ctrl_mutex);
 
@@ -325,17 +322,14 @@ static void nvme_rdma_free_dev(struct kref *ref)
 	struct nvme_rdma_device *ndev =
 		container_of(ref, struct nvme_rdma_device, ref);
 
-	mutex_lock(&device_list_mutex);
-	list_del(&ndev->entry);
-	mutex_unlock(&device_list_mutex);
-
+	ib_set_client_data(ndev->dev, &nvme_rdma_ib_client, NULL);
 	ib_dealloc_pd(ndev->pd);
 	kfree(ndev);
 }
 
-static void nvme_rdma_dev_put(struct nvme_rdma_device *dev)
+static int nvme_rdma_dev_put(struct nvme_rdma_device *dev)
 {
-	kref_put(&dev->ref, nvme_rdma_free_dev);
+	return kref_put(&dev->ref, nvme_rdma_free_dev);
 }
 
 static int nvme_rdma_dev_get(struct nvme_rdma_device *dev)
@@ -348,43 +342,42 @@ nvme_rdma_find_get_device(struct rdma_cm_id *cm_id)
 {
 	struct nvme_rdma_device *ndev;
 
-	mutex_lock(&device_list_mutex);
-	list_for_each_entry(ndev, &device_list, entry) {
-		if (ndev->dev->node_guid == cm_id->device->node_guid &&
-		    nvme_rdma_dev_get(ndev))
-			goto out_unlock;
+	ndev = ib_get_client_data(cm_id->device, &nvme_rdma_ib_client);
+	if (ndev && WARN_ON(!nvme_rdma_dev_get(ndev)))
+		ndev = NULL;
+
+	return ndev;
+}
+
+static struct nvme_rdma_device *
+nvme_rdma_alloc_device(struct ib_device *device)
+{
+	struct nvme_rdma_device *ndev;
+
+	if (!(device->attrs.device_cap_flags &
+	      IB_DEVICE_MEM_MGT_EXTENSIONS)) {
+		pr_err("Memory registrations not supported.\n");
+		return NULL;
 	}
 
 	ndev = kzalloc(sizeof(*ndev), GFP_KERNEL);
-	if (!ndev)
-		goto out_err;
+	if (unlikely(!ndev))
+		return NULL;
 
-	ndev->dev = cm_id->device;
+	ndev->dev = device;
 	kref_init(&ndev->ref);
 
 	ndev->pd = ib_alloc_pd(ndev->dev,
 		register_always ? 0 : IB_PD_UNSAFE_GLOBAL_RKEY);
-	if (IS_ERR(ndev->pd))
+	if (unlikely(IS_ERR(ndev->pd)))
 		goto out_free_dev;
 
-	if (!(ndev->dev->attrs.device_cap_flags &
-	      IB_DEVICE_MEM_MGT_EXTENSIONS)) {
-		dev_err(&ndev->dev->dev,
-			"Memory registrations not supported.\n");
-		goto out_free_pd;
-	}
+	ib_set_client_data(ndev->dev, &nvme_rdma_ib_client, ndev);
 
-	list_add(&ndev->entry, &device_list);
-out_unlock:
-	mutex_unlock(&device_list_mutex);
 	return ndev;
 
-out_free_pd:
-	ib_dealloc_pd(ndev->pd);
 out_free_dev:
 	kfree(ndev);
-out_err:
-	mutex_unlock(&device_list_mutex);
 	return NULL;
 }
 
@@ -2017,22 +2010,21 @@ static struct nvmf_transport_ops nvme_rdma_transport = {
 	.create_ctrl	= nvme_rdma_create_ctrl,
 };
 
-static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
+static void nvme_rdma_add_one(struct ib_device *ib_device)
 {
-	struct nvme_rdma_ctrl *ctrl;
 	struct nvme_rdma_device *ndev;
-	bool found = false;
 
-	mutex_lock(&device_list_mutex);
-	list_for_each_entry(ndev, &device_list, entry) {
-		if (ndev->dev == ib_device) {
-			found = true;
-			break;
-		}
-	}
-	mutex_unlock(&device_list_mutex);
+	ndev = nvme_rdma_alloc_device(ib_device);
+	if (unlikely(!ndev))
+		pr_info("Allocation of a device failed.\n");
+}
+
+static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
+{
+	struct nvme_rdma_device *ndev = client_data;
+	struct nvme_rdma_ctrl *ctrl;
 
-	if (!found)
+	if (unlikely(!ndev))
 		return;
 
 	/* Delete all controllers using this device */
@@ -2045,10 +2037,12 @@ static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
 	flush_workqueue(nvme_delete_wq);
+	WARN_ON(!nvme_rdma_dev_put(ndev));
 }
 
 static struct ib_client nvme_rdma_ib_client = {
 	.name   = "nvme_rdma",
+	.add    = nvme_rdma_add_one,
 	.remove = nvme_rdma_remove_one
 };
 
-- 
2.13.1
