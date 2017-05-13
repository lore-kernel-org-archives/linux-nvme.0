From: jsmart2021@gmail.com (James Smart)
Date: Sat, 13 May 2017 12:05:58 -0700
Subject: [PATCH v2 1/2] nvme_fc: create fc class and transport device
In-Reply-To: <20170513190559.25484-1-jsmart2021@gmail.com>
References: <20170513190559.25484-1-jsmart2021@gmail.com>
Message-ID: <20170513190559.25484-2-jsmart2021@gmail.com>

Added a new fc class, and a device node for the nvme_fc transport
under it. I expect the fc class will eventually be the location the
SCSI and FC transports merge in the future.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
v2: cut on nvme-4.12

 drivers/nvme/host/fc.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 8dd06e97736d..4ae99d546378 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -217,6 +217,9 @@ static DEFINE_IDA(nvme_fc_ctrl_cnt);
 
 static struct workqueue_struct *nvme_fc_wq;
 
+static struct class *fc_class;
+static struct device *nvmefc_device;
+
 
 
 /* *********************** FC-NVME Port Management ************************ */
@@ -2959,17 +2962,38 @@ static int __init nvme_fc_init_module(void)
 {
 	int ret;
 
+	fc_class = class_create(THIS_MODULE, "fc");
+	if (IS_ERR(fc_class)) {
+		pr_err("couldn't register class fc\n");
+		return PTR_ERR(fc_class);
+	}
+
+	nvmefc_device = device_create(fc_class, NULL, MKDEV(0, 0), NULL,
+				"nvme_fc_transport");
+	if (IS_ERR(nvmefc_device)) {
+		pr_err("couldn't create nvme_fc device!\n");
+		ret = PTR_ERR(nvmefc_device);
+		goto out_destroy_class;
+	}
+
 	nvme_fc_wq = create_workqueue("nvme_fc_wq");
-	if (!nvme_fc_wq)
-		return -ENOMEM;
+	if (!nvme_fc_wq) {
+		ret = -ENOMEM;
+		goto out_destroy_device;
+	}
 
 	ret = nvmf_register_transport(&nvme_fc_transport);
 	if (ret)
-		goto err;
+		goto out_destroy_workqueue;
 
 	return 0;
-err:
+
+out_destroy_workqueue:
 	destroy_workqueue(nvme_fc_wq);
+out_destroy_device:
+	device_destroy(fc_class, MKDEV(0, 0));
+out_destroy_class:
+	class_destroy(fc_class);
 	return ret;
 }
 
@@ -2985,6 +3009,9 @@ static void __exit nvme_fc_exit_module(void)
 
 	ida_destroy(&nvme_fc_local_port_cnt);
 	ida_destroy(&nvme_fc_ctrl_cnt);
+
+	device_destroy(fc_class, MKDEV(0, 0));
+	class_destroy(fc_class);
 }
 
 module_init(nvme_fc_init_module);
-- 
2.11.0
