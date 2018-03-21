From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 21 Mar 2018 17:48:35 +0200
Subject: [PATCH 1/1] nvme-rdma: Add IB event handling support
Message-ID: <1521647315-10011-1-git-send-email-maxg@mellanox.com>

From: Nitzan Carmi <nitzanc@mellanox.com>

IB devices may invoke IB events that need a special treatment
from the ib_client. For example, fatal event notification raised
to registered clients due to an invalid port/device state after EEH.
IB clients should be aware of this fatal event and not post any WR's
to the device. Draining the QP, for example, is forbidden and will
stuck forever waiting for the flushed work completions.

Signed-off-by: Nitzan Carmi <nitzanc at mellanox.com>
Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 4d84a73..dc5af97 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -45,6 +45,7 @@
 struct nvme_rdma_device {
 	struct ib_device	*dev;
 	struct ib_pd		*pd;
+	struct ib_event_handler	event_handler;
 	struct kref		ref;
 	struct list_head	entry;
 };
@@ -329,6 +330,7 @@ static void nvme_rdma_free_dev(struct kref *ref)
 	list_del(&ndev->entry);
 	mutex_unlock(&device_list_mutex);
 
+	ib_unregister_event_handler(&ndev->event_handler);
 	ib_dealloc_pd(ndev->pd);
 	kfree(ndev);
 }
@@ -343,6 +345,36 @@ static int nvme_rdma_dev_get(struct nvme_rdma_device *dev)
 	return kref_get_unless_zero(&dev->ref);
 }
 
+static void nvme_rdma_ib_event_handler(struct ib_event_handler *handler,
+				       struct ib_event *event)
+{
+	struct nvme_rdma_ctrl *ctrl;
+	int i;
+
+	pr_debug("async event %s (%d) on device %s port %d\n",
+		 ib_event_msg(event->event), event->event,
+		 event->device->name, event->element.port_num);
+
+	switch(event->event) {
+	case IB_EVENT_DEVICE_FATAL:
+		mutex_lock(&nvme_rdma_ctrl_mutex);
+		list_for_each_entry(ctrl, &nvme_rdma_ctrl_list, list) {
+			if (ctrl->device->dev != event->device)
+				continue;
+
+			for (i = 0; i < ctrl->ctrl.queue_count; i++)
+				clear_bit(NVME_RDMA_Q_LIVE,
+					  &ctrl->queues[i].flags);
+			nvme_delete_ctrl(&ctrl->ctrl);
+		}
+		mutex_unlock(&nvme_rdma_ctrl_mutex);
+		break;
+	default:
+		pr_debug("Unsupported event (%d)\n", event->event);
+		break;
+	}
+}
+
 static struct nvme_rdma_device *
 nvme_rdma_find_get_device(struct rdma_cm_id *cm_id)
 {
@@ -374,6 +406,10 @@ static int nvme_rdma_dev_get(struct nvme_rdma_device *dev)
 		goto out_free_pd;
 	}
 
+	INIT_IB_EVENT_HANDLER(&ndev->event_handler, ndev->dev,
+	                      nvme_rdma_ib_event_handler);
+	ib_register_event_handler(&ndev->event_handler);
+
 	list_add(&ndev->entry, &device_list);
 out_unlock:
 	mutex_unlock(&device_list_mutex);
-- 
1.8.3.1
