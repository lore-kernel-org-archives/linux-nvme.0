From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu,  4 May 2017 13:33:13 +0300
Subject: [PATCH 09/11] nvme: Move transports to use nvme-core workqueue
In-Reply-To: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
References: <1493893995-27063-1-git-send-email-sagi@grimberg.me>
Message-ID: <1493893995-27063-10-git-send-email-sagi@grimberg.me>

Instead of each transport using it's own workqueue, export
a single nvme-core workqueue and use that instead.

In the future, this will help us moving towards some unification
if controller setup/teardown flows.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c   | 15 +++++++++++++--
 drivers/nvme/host/fc.c     | 34 +++++++++-------------------------
 drivers/nvme/host/nvme.h   |  2 ++
 drivers/nvme/host/pci.c    | 18 +++---------------
 drivers/nvme/host/rdma.c   | 25 ++++++++-----------------
 drivers/nvme/target/loop.c |  8 ++++----
 6 files changed, 39 insertions(+), 63 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cfc8f8da89c8..26698e2c7380 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -65,6 +65,9 @@ static bool force_apst;
 module_param(force_apst, bool, 0644);
 MODULE_PARM_DESC(force_apst, "allow APST for newly enumerated devices even if quirked off");
 
+struct workqueue_struct *nvme_wq;
+EXPORT_SYMBOL_GPL(nvme_wq);
+
 static LIST_HEAD(nvme_ctrl_list);
 static DEFINE_SPINLOCK(dev_list_lock);
 
@@ -2517,10 +2520,15 @@ int __init nvme_core_init(void)
 {
 	int result;
 
+	nvme_wq = alloc_workqueue("nvme-wq",
+			WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_SYSFS, 0);
+	if (!nvme_wq)
+		return -ENOMEM;
+
 	result = __register_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme",
 							&nvme_dev_fops);
 	if (result < 0)
-		return result;
+		goto destroy_wq;
 	else if (result > 0)
 		nvme_char_major = result;
 
@@ -2532,8 +2540,10 @@ int __init nvme_core_init(void)
 
 	return 0;
 
- unregister_chrdev:
+unregister_chrdev:
 	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
+destroy_wq:
+	destroy_workqueue(nvme_wq);
 	return result;
 }
 
@@ -2541,6 +2551,7 @@ void nvme_core_exit(void)
 {
 	class_destroy(nvme_class);
 	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
+	destroy_workqueue(nvme_wq);
 }
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 4976db56e351..ca0cccd51292 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -218,7 +218,6 @@ static LIST_HEAD(nvme_fc_lport_list);
 static DEFINE_IDA(nvme_fc_local_port_cnt);
 static DEFINE_IDA(nvme_fc_ctrl_cnt);
 
-static struct workqueue_struct *nvme_fc_wq;
 
 
 
@@ -1763,7 +1762,7 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 		return;
 	}
 
-	if (!queue_work(nvme_fc_wq, &ctrl->reset_work))
+	if (!queue_work(nvme_wq, &ctrl->reset_work))
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: error_recovery: Failed to schedule "
 			"reset work\n", ctrl->cnum);
@@ -2550,7 +2549,7 @@ __nvme_fc_del_ctrl(struct nvme_fc_ctrl *ctrl)
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING))
 		return -EBUSY;
 
-	if (!queue_work(nvme_fc_wq, &ctrl->delete_work))
+	if (!queue_work(nvme_wq, &ctrl->delete_work))
 		return -EBUSY;
 
 	return 0;
@@ -2571,7 +2570,7 @@ nvme_fc_del_nvme_ctrl(struct nvme_ctrl *nctrl)
 	ret = __nvme_fc_del_ctrl(ctrl);
 
 	if (!ret)
-		flush_workqueue(nvme_fc_wq);
+		flush_workqueue(nvme_wq);
 
 	nvme_put_ctrl(&ctrl->ctrl);
 
@@ -2607,14 +2606,14 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 				return;
 			}
 
-			WARN_ON(!queue_work(nvme_fc_wq, &ctrl->delete_work));
+			WARN_ON(!queue_work(nvme_wq, &ctrl->delete_work));
 			return;
 		}
 
 		dev_warn(ctrl->ctrl.device,
 			"NVME-FC{%d}: Reconnect attempt in %d seconds.\n",
 			ctrl->cnum, ctrl->reconnect_delay);
-		queue_delayed_work(nvme_fc_wq, &ctrl->connect_work,
+		queue_delayed_work(nvme_wq, &ctrl->connect_work,
 				ctrl->reconnect_delay * HZ);
 	} else
 		dev_info(ctrl->ctrl.device,
@@ -2636,7 +2635,7 @@ nvme_fc_reset_nvme_ctrl(struct nvme_ctrl *nctrl)
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
 		return -EBUSY;
 
-	if (!queue_work(nvme_fc_wq, &ctrl->reset_work))
+	if (!queue_work(nvme_wq, &ctrl->reset_work))
 		return -EBUSY;
 
 	flush_work(&ctrl->reset_work);
@@ -2687,14 +2686,14 @@ nvme_fc_connect_ctrl_work(struct work_struct *work)
 				return;
 			}
 
-			WARN_ON(!queue_work(nvme_fc_wq, &ctrl->delete_work));
+			WARN_ON(!queue_work(nvme_wq, &ctrl->delete_work));
 			return;
 		}
 
 		dev_warn(ctrl->ctrl.device,
 			"NVME-FC{%d}: Reconnect attempt in %d seconds.\n",
 			ctrl->cnum, ctrl->reconnect_delay);
-		queue_delayed_work(nvme_fc_wq, &ctrl->connect_work,
+		queue_delayed_work(nvme_wq, &ctrl->connect_work,
 				ctrl->reconnect_delay * HZ);
 	} else
 		dev_info(ctrl->ctrl.device,
@@ -2969,20 +2968,7 @@ static struct nvmf_transport_ops nvme_fc_transport = {
 
 static int __init nvme_fc_init_module(void)
 {
-	int ret;
-
-	nvme_fc_wq = create_workqueue("nvme_fc_wq");
-	if (!nvme_fc_wq)
-		return -ENOMEM;
-
-	ret = nvmf_register_transport(&nvme_fc_transport);
-	if (ret)
-		goto err;
-
-	return 0;
-err:
-	destroy_workqueue(nvme_fc_wq);
-	return ret;
+	return nvmf_register_transport(&nvme_fc_transport);
 }
 
 static void __exit nvme_fc_exit_module(void)
@@ -2993,8 +2979,6 @@ static void __exit nvme_fc_exit_module(void)
 
 	nvmf_unregister_transport(&nvme_fc_transport);
 
-	destroy_workqueue(nvme_fc_wq);
-
 	ida_destroy(&nvme_fc_local_port_cnt);
 	ida_destroy(&nvme_fc_ctrl_cnt);
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 29c708ca9621..edf3ee7da553 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -33,6 +33,8 @@ extern unsigned char shutdown_timeout;
 #define NVME_DEFAULT_KATO	5
 #define NVME_KATO_GRACE		10
 
+extern struct workqueue_struct *nvme_wq;
+
 enum {
 	NVME_NS_LBA		= 0,
 	NVME_NS_LIGHTNVM	= 1,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c8541c3dcd19..923343982b41 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -66,8 +66,6 @@ static bool use_cmb_sqes = true;
 module_param(use_cmb_sqes, bool, 0644);
 MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
 
-static struct workqueue_struct *nvme_workq;
-
 struct nvme_dev;
 struct nvme_queue;
 
@@ -2010,7 +2008,7 @@ static int nvme_reset(struct nvme_dev *dev)
 		return -ENODEV;
 	if (work_busy(&dev->reset_work))
 		return -ENODEV;
-	if (!queue_work(nvme_workq, &dev->reset_work))
+	if (!queue_work(nvme_wq, &dev->reset_work))
 		return -EBUSY;
 	return 0;
 }
@@ -2136,7 +2134,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
-	queue_work(nvme_workq, &dev->reset_work);
+	queue_work(nvme_wq, &dev->reset_work);
 	return 0;
 
  release_pools:
@@ -2321,22 +2319,12 @@ static struct pci_driver nvme_driver = {
 
 static int __init nvme_init(void)
 {
-	int result;
-
-	nvme_workq = alloc_workqueue("nvme", WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
-	if (!nvme_workq)
-		return -ENOMEM;
-
-	result = pci_register_driver(&nvme_driver);
-	if (result)
-		destroy_workqueue(nvme_workq);
-	return result;
+	return pci_register_driver(&nvme_driver);
 }
 
 static void __exit nvme_exit(void)
 {
 	pci_unregister_driver(&nvme_driver);
-	destroy_workqueue(nvme_workq);
 	_nvme_check_size();
 }
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9ce56520bb1a..ae16d44f2ada 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -140,8 +140,6 @@ static DEFINE_MUTEX(device_list_mutex);
 static LIST_HEAD(nvme_rdma_ctrl_list);
 static DEFINE_MUTEX(nvme_rdma_ctrl_mutex);
 
-static struct workqueue_struct *nvme_rdma_wq;
-
 /*
  * Disabling this option makes small I/O goes faster, but is fundamentally
  * unsafe.  With it turned off we will have to register a global rkey that
@@ -712,11 +710,11 @@ static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
 	if (nvmf_should_reconnect(&ctrl->ctrl)) {
 		dev_info(ctrl->ctrl.device, "Reconnecting in %d seconds...\n",
 			ctrl->ctrl.opts->reconnect_delay);
-		queue_delayed_work(nvme_rdma_wq, &ctrl->reconnect_work,
+		queue_delayed_work(nvme_wq, &ctrl->reconnect_work,
 				ctrl->ctrl.opts->reconnect_delay * HZ);
 	} else {
 		dev_info(ctrl->ctrl.device, "Removing controller...\n");
-		queue_work(nvme_rdma_wq, &ctrl->delete_work);
+		queue_work(nvme_wq, &ctrl->delete_work);
 	}
 }
 
@@ -823,7 +821,7 @@ static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RECONNECTING))
 		return;
 
-	queue_work(nvme_rdma_wq, &ctrl->err_work);
+	queue_work(nvme_wq, &ctrl->err_work);
 }
 
 static void nvme_rdma_wr_error(struct ib_cq *cq, struct ib_wc *wc,
@@ -1667,7 +1665,7 @@ static int __nvme_rdma_del_ctrl(struct nvme_rdma_ctrl *ctrl)
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING))
 		return -EBUSY;
 
-	if (!queue_work(nvme_rdma_wq, &ctrl->delete_work))
+	if (!queue_work(nvme_wq, &ctrl->delete_work))
 		return -EBUSY;
 
 	return 0;
@@ -1743,7 +1741,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 del_dead_ctrl:
 	/* Deleting this dead controller... */
 	dev_warn(ctrl->ctrl.device, "Removing after reset failure\n");
-	WARN_ON(!queue_work(nvme_rdma_wq, &ctrl->delete_work));
+	WARN_ON(!queue_work(nvme_wq, &ctrl->delete_work));
 }
 
 static int nvme_rdma_reset_ctrl(struct nvme_ctrl *nctrl)
@@ -1753,7 +1751,7 @@ static int nvme_rdma_reset_ctrl(struct nvme_ctrl *nctrl)
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
 		return -EBUSY;
 
-	if (!queue_work(nvme_rdma_wq, &ctrl->reset_work))
+	if (!queue_work(nvme_wq, &ctrl->reset_work))
 		return -EBUSY;
 
 	flush_work(&ctrl->reset_work);
@@ -1990,7 +1988,7 @@ static void nvme_rdma_remove_one(struct ib_device *ib_device, void *client_data)
 	}
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
-	flush_workqueue(nvme_rdma_wq);
+	flush_workqueue(nvme_wq);
 }
 
 static struct ib_client nvme_rdma_ib_client = {
@@ -2003,13 +2001,9 @@ static int __init nvme_rdma_init_module(void)
 {
 	int ret;
 
-	nvme_rdma_wq = create_workqueue("nvme_rdma_wq");
-	if (!nvme_rdma_wq)
-		return -ENOMEM;
-
 	ret = ib_register_client(&nvme_rdma_ib_client);
 	if (ret)
-		goto err_destroy_wq;
+		return ret;
 
 	ret = nvmf_register_transport(&nvme_rdma_transport);
 	if (ret)
@@ -2019,8 +2013,6 @@ static int __init nvme_rdma_init_module(void)
 
 err_unreg_client:
 	ib_unregister_client(&nvme_rdma_ib_client);
-err_destroy_wq:
-	destroy_workqueue(nvme_rdma_wq);
 	return ret;
 }
 
@@ -2028,7 +2020,6 @@ static void __exit nvme_rdma_cleanup_module(void)
 {
 	nvmf_unregister_transport(&nvme_rdma_transport);
 	ib_unregister_client(&nvme_rdma_ib_client);
-	destroy_workqueue(nvme_rdma_wq);
 }
 
 module_init(nvme_rdma_init_module);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 84ae300d6498..6b90ad1216dc 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -150,7 +150,7 @@ nvme_loop_timeout(struct request *rq, bool reserved)
 	struct nvme_loop_iod *iod = blk_mq_rq_to_pdu(rq);
 
 	/* queue error recovery */
-	schedule_work(&iod->queue->ctrl->reset_work);
+	queue_work(nvme_wq, &iod->queue->ctrl->reset_work);
 
 	/* fail with DNR on admin cmd timeout */
 	nvme_req(rq)->status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
@@ -465,7 +465,7 @@ static int __nvme_loop_del_ctrl(struct nvme_loop_ctrl *ctrl)
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING))
 		return -EBUSY;
 
-	if (!schedule_work(&ctrl->delete_work))
+	if (!queue_work(nvme_wq, &ctrl->delete_work))
 		return -EBUSY;
 
 	return 0;
@@ -545,7 +545,7 @@ static int nvme_loop_reset_ctrl(struct nvme_ctrl *nctrl)
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
 		return -EBUSY;
 
-	if (!schedule_work(&ctrl->reset_work))
+	if (!queue_work(nvme_wq, &ctrl->reset_work))
 		return -EBUSY;
 
 	flush_work(&ctrl->reset_work);
@@ -762,7 +762,7 @@ static void __exit nvme_loop_cleanup_module(void)
 		__nvme_loop_del_ctrl(ctrl);
 	mutex_unlock(&nvme_loop_ctrl_mutex);
 
-	flush_scheduled_work();
+	flush_workqueue(nvme_wq);
 }
 
 module_init(nvme_loop_init_module);
-- 
2.7.4
