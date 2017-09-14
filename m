From: jsmart2021@gmail.com (James Smart)
Date: Thu, 14 Sep 2017 10:38:41 -0700
Subject: [PATCH v3 1/3] nvme_fc: create fc class and transport device
In-Reply-To: <20170914173843.3195-1-jsmart2021@gmail.com>
References: <20170914173843.3195-1-jsmart2021@gmail.com>
Message-ID: <20170914173843.3195-2-jsmart2021@gmail.com>

Added a new fc class and a device node for udev events under it.
I expect the fc class will eventually be the location where the
FC SCSI and FC NVME merge in the future. Therefore names are
kept somewhat generic.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
v3:
  Genericized udev event device name.
  Added comments about future expectations.
  Kept fc class and udev device in the nvme module due to its
     small size. in future, it can move to somewhere else.

 drivers/nvme/host/fc.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index d2e882c0f496..f9e9dddc7e92 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -213,6 +213,13 @@ static DEFINE_IDA(nvme_fc_ctrl_cnt);
 
 
 
+/*
+ * These items are short-term. They will eventually be moved into
+ * a generic FC class. See comments in module init.
+ */
+static struct class *fc_class;
+static struct device *fc_udev_device;
+
 
 /* *********************** FC-NVME Port Management ************************ */
 
@@ -2996,7 +3003,50 @@ static struct nvmf_transport_ops nvme_fc_transport = {
 
 static int __init nvme_fc_init_module(void)
 {
-	return nvmf_register_transport(&nvme_fc_transport);
+	int ret;
+
+	/*
+	 * NOTE:
+	 * It is expected that in the future the kernel will combine
+	 * the FC-isms that are currently under scsi and now being
+	 * added to by NVME into a new standalone FC class. The SCSI
+	 * and NVME protocols and their devices would be under this
+	 * new FC class.
+	 *
+	 * As we need something to post FC-specific udev events to,
+	 * specifically for nvme probe events, start by creating the
+	 * new device class.  When the new standalone FC class is
+	 * put in place, this code will move to a more generic
+	 * location for the class.
+	 */
+	fc_class = class_create(THIS_MODULE, "fc");
+	if (IS_ERR(fc_class)) {
+		pr_err("couldn't register class fc\n");
+		return PTR_ERR(fc_class);
+	}
+
+	/*
+	 * Create a device for the FC-centric udev events
+	 */
+	fc_udev_device = device_create(fc_class, NULL, MKDEV(0, 0), NULL,
+				"fc_udev_device");
+	if (IS_ERR(fc_udev_device)) {
+		pr_err("couldn't create fc_udev device!\n");
+		ret = PTR_ERR(fc_udev_device);
+		goto out_destroy_class;
+	}
+
+	ret = nvmf_register_transport(&nvme_fc_transport);
+	if (ret)
+		goto out_destroy_device;
+
+	return 0;
+
+out_destroy_device:
+	device_destroy(fc_class, MKDEV(0, 0));
+out_destroy_class:
+	class_destroy(fc_class);
+	return ret;
 }
 
 static void __exit nvme_fc_exit_module(void)
@@ -3009,6 +3059,9 @@ static void __exit nvme_fc_exit_module(void)
 
 	ida_destroy(&nvme_fc_local_port_cnt);
 	ida_destroy(&nvme_fc_ctrl_cnt);
+
+	device_destroy(fc_class, MKDEV(0, 0));
+	class_destroy(fc_class);
 }
 
 module_init(nvme_fc_init_module);
-- 
2.13.1
