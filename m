From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed,  3 Jul 2019 11:01:36 -0600
Subject: [PATCH 2/2] nvmet-rdma: Fix use-after-free bug when a port is removed
In-Reply-To: <20190703170136.21515-1-logang@deltatee.com>
References: <20190703170136.21515-1-logang@deltatee.com>
Message-ID: <20190703170136.21515-3-logang@deltatee.com>

When a port is removed through configfs, any connected controllers
are still active and can still send commands. This causes a
use-after-free bug which is detected by KASAN for any admin command
that dereferences req->port (like in nvmet_execute_identify_ctrl).

To fix this, disconnect all active queues that use the same port
in nvme_rdma_remove_port().

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/nvme/target/rdma.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 36d906a7f70d..6db9f9586ca7 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1580,9 +1580,25 @@ static int nvmet_rdma_add_port(struct nvmet_port *port)
 static void nvmet_rdma_remove_port(struct nvmet_port *port)
 {
 	struct rdma_cm_id *cm_id = xchg(&port->priv, NULL);
+	struct nvmet_rdma_queue *queue;
 
 	if (cm_id)
 		rdma_destroy_id(cm_id);
+
+restart:
+	mutex_lock(&nvmet_rdma_queue_mutex);
+
+	list_for_each_entry(queue, &nvmet_rdma_queue_list, queue_list) {
+		if (queue->port == port) {
+			list_del_init(&queue->queue_list);
+			mutex_unlock(&nvmet_rdma_queue_mutex);
+
+			__nvmet_rdma_queue_disconnect(queue);
+			goto restart;
+		}
+	}
+
+	mutex_unlock(&nvmet_rdma_queue_mutex);
 }
 
 static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
-- 
2.20.1
