From: roman.penyaev@profitbricks.com (Roman Pen)
Date: Mon,  4 Jun 2018 14:29:58 +0200
Subject: [PATCH v2 3/8] nvmet-rdma: use ib_client API to wrap ib_device
In-Reply-To: <20180604123003.24748-1-roman.penyaev@profitbricks.com>
References: <20180604123003.24748-1-roman.penyaev@profitbricks.com>
Message-ID: <20180604123003.24748-4-roman.penyaev@profitbricks.com>

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
 drivers/nvme/target/rdma.c | 70 ++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 37 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 4304b8d8d027..5699b544b23e 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -125,9 +125,7 @@ MODULE_PARM_DESC(use_srq, "Use shared receive queue.");
 static DEFINE_IDA(nvmet_rdma_queue_ida);
 static LIST_HEAD(nvmet_rdma_queue_list);
 static DEFINE_MUTEX(nvmet_rdma_queue_mutex);
-
-static LIST_HEAD(device_list);
-static DEFINE_MUTEX(device_list_mutex);
+static struct ib_client nvmet_rdma_ib_client;
 
 static bool nvmet_rdma_execute_command(struct nvmet_rdma_rsp *rsp);
 static void nvmet_rdma_send_done(struct ib_cq *cq, struct ib_wc *wc);
@@ -780,13 +778,9 @@ static void nvmet_rdma_free_device(struct kref *ref)
 	struct nvmet_rdma_device *ndev =
 		container_of(ref, struct nvmet_rdma_device, ref);
 
-	mutex_lock(&device_list_mutex);
-	list_del(&ndev->entry);
-	mutex_unlock(&device_list_mutex);
-
+	ib_set_client_data(ndev->device, &nvmet_rdma_ib_client, NULL);
 	nvmet_rdma_destroy_srq(ndev);
 	ib_dealloc_pd(ndev->pd);
-
 	kfree(ndev);
 }
 
@@ -804,24 +798,29 @@ static struct nvmet_rdma_device *
 nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
 {
 	struct nvmet_rdma_device *ndev;
-	int ret;
 
-	mutex_lock(&device_list_mutex);
-	list_for_each_entry(ndev, &device_list, entry) {
-		if (ndev->device->node_guid == cm_id->device->node_guid &&
-		    nvmet_rdma_dev_get(ndev))
-			goto out_unlock;
-	}
+	ndev = ib_get_client_data(cm_id->device, &nvmet_rdma_ib_client);
+	if (ndev && WARN_ON(!nvmet_rdma_dev_get(ndev)))
+		ndev = NULL;
+
+	return ndev;
+}
+
+static struct nvmet_rdma_device *
+nvmet_rdma_alloc_device(struct ib_device *device)
+{
+	struct nvmet_rdma_device *ndev;
+	int ret;
 
 	ndev = kzalloc(sizeof(*ndev), GFP_KERNEL);
-	if (!ndev)
-		goto out_err;
+	if (unlikely(!ndev))
+		return NULL;
 
-	ndev->device = cm_id->device;
+	ndev->device = device;
 	kref_init(&ndev->ref);
 
 	ndev->pd = ib_alloc_pd(ndev->device, 0);
-	if (IS_ERR(ndev->pd))
+	if (unlikely(IS_ERR(ndev->pd)))
 		goto out_free_dev;
 
 	if (nvmet_rdma_use_srq) {
@@ -829,19 +828,15 @@ nvmet_rdma_find_get_device(struct rdma_cm_id *cm_id)
 		if (ret)
 			goto out_free_pd;
 	}
-
-	list_add(&ndev->entry, &device_list);
-out_unlock:
-	mutex_unlock(&device_list_mutex);
+	ib_set_client_data(ndev->device, &nvmet_rdma_ib_client, ndev);
 	pr_debug("added %s.\n", ndev->device->name);
+
 	return ndev;
 
 out_free_pd:
 	ib_dealloc_pd(ndev->pd);
 out_free_dev:
 	kfree(ndev);
-out_err:
-	mutex_unlock(&device_list_mutex);
 	return NULL;
 }
 
@@ -1475,22 +1470,21 @@ static const struct nvmet_fabrics_ops nvmet_rdma_ops = {
 	.disc_traddr		= nvmet_rdma_disc_port_addr,
 };
 
-static void nvmet_rdma_remove_one(struct ib_device *ib_device, void *client_data)
+static void nvmet_rdma_add_one(struct ib_device *ib_device)
 {
-	struct nvmet_rdma_queue *queue, *tmp;
 	struct nvmet_rdma_device *ndev;
-	bool found = false;
 
-	mutex_lock(&device_list_mutex);
-	list_for_each_entry(ndev, &device_list, entry) {
-		if (ndev->device == ib_device) {
-			found = true;
-			break;
-		}
-	}
-	mutex_unlock(&device_list_mutex);
+	ndev = nvmet_rdma_alloc_device(ib_device);
+	if (unlikely(!ndev))
+		pr_info("Allocation of a device failed.\n");
+}
+
+static void nvmet_rdma_remove_one(struct ib_device *ib_device, void *client_data)
+{
+	struct nvmet_rdma_device *ndev = client_data;
+	struct nvmet_rdma_queue *queue, *tmp;
 
-	if (!found)
+	if (unlikely(!ndev))
 		return;
 
 	/*
@@ -1510,10 +1504,12 @@ static void nvmet_rdma_remove_one(struct ib_device *ib_device, void *client_data
 	mutex_unlock(&nvmet_rdma_queue_mutex);
 
 	flush_scheduled_work();
+	WARN_ON(!nvmet_rdma_dev_put(ndev));
 }
 
 static struct ib_client nvmet_rdma_ib_client = {
 	.name   = "nvmet_rdma",
+	.add    = nvmet_rdma_add_one,
 	.remove = nvmet_rdma_remove_one
 };
 
-- 
2.13.1
