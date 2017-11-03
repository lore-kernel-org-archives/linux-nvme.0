From: hare@suse.de (Hannes Reinecke)
Date: Fri,  3 Nov 2017 16:19:29 +0100
Subject: [PATCH 1/1] nvme/fc: add 'discovery' sysfs attribute to fc transport
 device
In-Reply-To: <1509722369-95879-1-git-send-email-hare@suse.de>
References: <1509722369-95879-1-git-send-email-hare@suse.de>
Message-ID: <1509722369-95879-2-git-send-email-hare@suse.de>

The fc transport device should allow for a rediscovery, as userspace
might have lost the events.
So add a sysfs entry 'discovery' to trigger the discover uevents.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/fc.c | 63 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 54 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 113c30b..fb95933 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -219,7 +219,6 @@ struct nvme_fc_ctrl {
  * These items are short-term. They will eventually be moved into
  * a generic FC class. See comments in module init.
  */
-static struct class *fc_class;
 static struct device *fc_udev_device;
 
 
@@ -3275,6 +3274,52 @@ struct nvmet_fc_traddr {
 	.create_ctrl	= nvme_fc_create_ctrl,
 };
 
+static ssize_t nvme_fc_discovery_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	unsigned long flags;
+	struct nvme_fc_lport *lport;
+	struct nvme_fc_rport *rport, *tmp_rport;
+
+	spin_lock_irqsave(&nvme_fc_lock, flags);
+
+	list_for_each_entry(lport, &nvme_fc_lport_list, port_list) {
+		list_for_each_entry_safe(rport, tmp_rport,
+					 &lport->endp_list, endp_list) {
+			if (!nvme_fc_rport_get(rport))
+				continue;
+			spin_unlock_irqrestore(&nvme_fc_lock, flags);
+			nvme_fc_signal_discovery_scan(lport, rport);
+			nvme_fc_rport_put(rport);
+			spin_lock_irqsave(&nvme_fc_lock, flags);
+		}
+	}
+	spin_unlock_irqrestore(&nvme_fc_lock, flags);
+	return count;
+}
+static DEVICE_ATTR(discovery, S_IWUSR, NULL, nvme_fc_discovery_store);
+
+static struct attribute *nvme_fc_attrs[] = {
+	&dev_attr_discovery.attr,
+	NULL
+};
+
+static struct attribute_group nvme_fc_attr_group = {
+	.attrs = nvme_fc_attrs,
+};
+
+static const struct attribute_group *nvme_fc_attr_groups[] = {
+	&nvme_fc_attr_group,
+	NULL
+};
+
+static struct class fc_class = {
+	.name = "fc",
+	.dev_groups = nvme_fc_attr_groups,
+	.owner = THIS_MODULE,
+};
+
 static int __init nvme_fc_init_module(void)
 {
 	int ret;
@@ -3293,16 +3338,16 @@ static int __init nvme_fc_init_module(void)
 	 * put in place, this code will move to a more generic
 	 * location for the class.
 	 */
-	fc_class = class_create(THIS_MODULE, "fc");
-	if (IS_ERR(fc_class)) {
+	ret = class_register(&fc_class);
+	if (ret) {
 		pr_err("couldn't register class fc\n");
-		return PTR_ERR(fc_class);
+		return ret;
 	}
 
 	/*
 	 * Create a device for the FC-centric udev events
 	 */
-	fc_udev_device = device_create(fc_class, NULL, MKDEV(0, 0), NULL,
+	fc_udev_device = device_create(&fc_class, NULL, MKDEV(0, 0), NULL,
 				"fc_udev_device");
 	if (IS_ERR(fc_udev_device)) {
 		pr_err("couldn't create fc_udev device!\n");
@@ -3317,9 +3362,9 @@ static int __init nvme_fc_init_module(void)
 	return 0;
 
 out_destroy_device:
-	device_destroy(fc_class, MKDEV(0, 0));
+	device_destroy(&fc_class, MKDEV(0, 0));
 out_destroy_class:
-	class_destroy(fc_class);
+	class_unregister(&fc_class);
 	return ret;
 }
 
@@ -3334,8 +3379,8 @@ static void __exit nvme_fc_exit_module(void)
 	ida_destroy(&nvme_fc_local_port_cnt);
 	ida_destroy(&nvme_fc_ctrl_cnt);
 
-	device_destroy(fc_class, MKDEV(0, 0));
-	class_destroy(fc_class);
+	device_destroy(&fc_class, MKDEV(0, 0));
+	class_unregister(&fc_class);
 }
 
 module_init(nvme_fc_init_module);
-- 
1.8.5.6
