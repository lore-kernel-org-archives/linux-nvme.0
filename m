From: jsmart2021@gmail.com (James Smart)
Date: Fri, 28 Jun 2019 17:26:08 -0700
Subject: [PATCH v3] nvme-fc: fix module unloads while lports still pending
Message-ID: <20190629002608.3419-1-jsmart2021@gmail.com>

Current code allows the module to be unloaded even if there are
pending data structures, such as localports and controllers on
the localports, that have yet to hit their reference counting
to remove them.

Fix by having exit entrypoint explicitly delete every controller,
which in turn will remove references on the remoteports and localports
causing them to be deleted as well. The exit entrypoint, after
initiating the deletes, will wait for the last localport to be deleted
before continuing.

Signed-off-by: James Smart <jsmart2021 at gmail.com>

---
V2:
  replaced self-module references with code that actually deletes
  the outstanding structures.
v3:
  remove spurious whitespace
  slightly rework cleanup call sequence to avoid locking calls
  use DECLARE_COMPLETION
---
 drivers/nvme/host/fc.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9b497d785ed7..24bac12b8dfd 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -204,6 +204,9 @@ static DEFINE_IDA(nvme_fc_ctrl_cnt);
 
 static struct workqueue_struct *nvme_fc_wq;
 
+static bool nvme_fc_waiting_to_unload;
+static DECLARE_COMPLETION(nvme_fc_unload_proceed);
+
 /*
  * These items are short-term. They will eventually be moved into
  * a generic FC class. See comments in module init.
@@ -229,6 +232,8 @@ nvme_fc_free_lport(struct kref *ref)
 	/* remove from transport list */
 	spin_lock_irqsave(&nvme_fc_lock, flags);
 	list_del(&lport->port_list);
+	if (nvme_fc_waiting_to_unload && list_empty(&nvme_fc_lport_list))
+		complete(&nvme_fc_unload_proceed);
 	spin_unlock_irqrestore(&nvme_fc_lock, flags);
 
 	ida_simple_remove(&nvme_fc_local_port_cnt, lport->localport.port_num);
@@ -3444,6 +3449,8 @@ static int __init nvme_fc_init_module(void)
 	if (ret)
 		goto out_destroy_device;
 
+	nvme_fc_waiting_to_unload = false;
+
 	return 0;
 
 out_destroy_device:
@@ -3456,11 +3463,51 @@ static int __init nvme_fc_init_module(void)
 	return ret;
 }
 
+static void
+nvme_fc_delete_controllers(struct nvme_fc_rport *rport)
+{
+	struct nvme_fc_ctrl *ctrl;
+
+	spin_lock(&rport->lock);
+	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
+		dev_warn(ctrl->ctrl.device,
+			"NVME-FC{%d}: transport unloading: deleting ctrl\n",
+			ctrl->cnum);
+		nvme_delete_ctrl(&ctrl->ctrl);
+	}
+	spin_unlock(&rport->lock);
+}
+
+static void
+nvme_fc_cleanup_for_unload(void)
+{
+	struct nvme_fc_lport *lport;
+	struct nvme_fc_rport *rport;
+
+	list_for_each_entry(lport, &nvme_fc_lport_list, port_list) {
+		list_for_each_entry(rport, &lport->endp_list, endp_list) {
+			nvme_fc_delete_controllers(rport);
+		}
+	}
+}
+
 static void __exit nvme_fc_exit_module(void)
 {
-	/* sanity check - all lports should be removed */
-	if (!list_empty(&nvme_fc_lport_list))
-		pr_warn("%s: localport list not empty\n", __func__);
+	unsigned long flags;
+	bool need_cleanup = false;
+
+	spin_lock_irqsave(&nvme_fc_lock, flags);
+	nvme_fc_waiting_to_unload = true;
+	if (!list_empty(&nvme_fc_lport_list)) {
+		need_cleanup = true;
+		nvme_fc_cleanup_for_unload();
+	}
+	spin_unlock_irqrestore(&nvme_fc_lock, flags);
+	if (need_cleanup) {
+		pr_info("%s: waiting for ctlr deletes\n", __func__);
+		wait_for_completion(&nvme_fc_unload_proceed);
+		pr_info("%s: ctrl deletes complete\n", __func__);
+	}
 
 	nvmf_unregister_transport(&nvme_fc_transport);
 
-- 
2.13.7
