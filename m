From: logang@deltatee.com (Logan Gunthorpe)
Date: Wed,  3 Jul 2019 11:01:35 -0600
Subject: [PATCH 1/2] nvmet-loop: Fix use-after-free bug when a port is removed
In-Reply-To: <20190703170136.21515-1-logang@deltatee.com>
References: <20190703170136.21515-1-logang@deltatee.com>
Message-ID: <20190703170136.21515-2-logang@deltatee.com>

When a port is removed through configfs, any connected controllers
are still active and can still send commands. This causes
a use-after-free bug which is detected by KASAN for any admin command
that dereferences req->port (like in nvmet_execute_identify_ctrl).

To fix this, delete all active controllers for that port in
nvme_loop_remove_port().

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/nvme/target/loop.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 9e211ad6bdd3..b1bee71bee47 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -651,9 +651,20 @@ static int nvme_loop_add_port(struct nvmet_port *port)
 
 static void nvme_loop_remove_port(struct nvmet_port *port)
 {
+	struct nvme_loop_ctrl *ctrl;
+
 	mutex_lock(&nvme_loop_ports_mutex);
 	list_del_init(&port->entry);
 	mutex_unlock(&nvme_loop_ports_mutex);
+
+	mutex_lock(&nvme_loop_ctrl_mutex);
+	list_for_each_entry(ctrl, &nvme_loop_ctrl_list, list) {
+		if (ctrl->port == port)
+			nvme_delete_ctrl(&ctrl->ctrl);
+	}
+	mutex_unlock(&nvme_loop_ctrl_mutex);
+
+	flush_workqueue(nvme_delete_wq);
 }
 
 static const struct nvmet_fabrics_ops nvme_loop_ops = {
-- 
2.20.1
