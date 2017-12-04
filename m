From: hare@suse.de (Hannes Reinecke)
Date: Mon,  4 Dec 2017 09:21:01 +0100
Subject: [PATCHv3] nvme/fc: add 'discovery' sysfs attribute to fc transport
 device
Message-ID: <1512375661-75242-1-git-send-email-hare@suse.de>

The fc transport device should allow for a rediscovery, as userspace
might have lost the events.
So add a sysfs entry 'discovery' to trigger the discover uevents.

With this patch one can add a simple udev rule like:

SUBSYSTEM!="block, GOTO="nvme_autoconnect_end"
ACTION!="add|change", GOTO="nvme_autoconnect_end"
ENV{FC_EVENT}!="nvmediscovery", GOTO="nvme_autoconnect_end"
ENV{NVMEFC_HOST_TRADDR}!="?*", GOTO="nvme_autoconnect_end"
ENV{NVMEFC_TRADDR}!="?*", GOTO="nvme_autoconnect_end"
RUN+="/usr/sbin/nvme connect-all -t fc --host-traddr=$env{NVMEFC_HOST_TRADDR} -a $env{NVMEFC_TRADDR}"
LABEL="nvme_autoconnect_end"

to facilitate autoconnect.

Signed-off-by: Hannes Reinecke <hare at suse.com>
Cc: James Smart <james.smart at broadcom.com>
Cc: Ewan Milne <emilne at redhat.com>
Cc: Johannes Thumshirn <jthumshirn at suse.com>
---
 drivers/nvme/host/fc.c | 86 ++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 77 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 0a8af4d..26ff51b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -126,6 +126,7 @@ struct nvme_fc_rport {
 	struct list_head		endp_list; /* for lport->endp_list */
 	struct list_head		ctrl_list;
 	struct list_head		ls_req_list;
+	struct list_head		disc_list;
 	struct device			*dev;	/* physical device for dma */
 	struct nvme_fc_lport		*lport;
 	spinlock_t			lock;
@@ -213,7 +214,6 @@ struct nvme_fc_ctrl {
  * These items are short-term. They will eventually be moved into
  * a generic FC class. See comments in module init.
  */
-static struct class *fc_class;
 static struct device *fc_udev_device;
 
 
@@ -510,6 +510,7 @@ static void __nvme_fc_delete_hw_queue(struct nvme_fc_ctrl *,
 	list_del(&rport->endp_list);
 	spin_unlock_irqrestore(&nvme_fc_lock, flags);
 
+	WARN_ON(!list_empty(&rport->disc_list));
 	ida_simple_remove(&lport->endp_cnt, rport->remoteport.port_num);
 
 	kfree(rport);
@@ -695,6 +696,7 @@ static void __nvme_fc_delete_hw_queue(struct nvme_fc_ctrl *,
 	INIT_LIST_HEAD(&newrec->endp_list);
 	INIT_LIST_HEAD(&newrec->ctrl_list);
 	INIT_LIST_HEAD(&newrec->ls_req_list);
+	INIT_LIST_HEAD(&newrec->disc_list);
 	kref_init(&newrec->ref);
 	atomic_set(&newrec->act_ctrl_cnt, 0);
 	spin_lock_init(&newrec->lock);
@@ -3386,6 +3388,72 @@ struct nvmet_fc_traddr {
 	.create_ctrl	= nvme_fc_create_ctrl,
 };
 
+static ssize_t nvme_fc_discovery_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t count)
+{
+	unsigned long flags;
+	LIST_HEAD(nvme_fc_disc_list);
+	struct nvme_fc_lport *lport;
+	struct nvme_fc_rport *rport, *tmp_rport;
+
+restart:
+	spin_lock_irqsave(&nvme_fc_lock, flags);
+	list_for_each_entry(lport, &nvme_fc_lport_list, port_list) {
+		list_for_each_entry(rport, &lport->endp_list, endp_list) {
+			if (!nvme_fc_lport_get(lport))
+				continue;
+			if (!nvme_fc_rport_get(rport)) {
+				/*
+				 * This really is a temporary condition,
+				 * so upon restart this node will be gone
+				 * from the list.
+				 */
+				spin_unlock_irqrestore(&nvme_fc_lock, flags);
+				nvme_fc_lport_put(lport);
+				goto restart;
+			}
+			if (list_empty(&rport->disc_list))
+				list_add_tail(&rport->disc_list,
+					      &nvme_fc_disc_list);
+		}
+	}
+	spin_unlock_irqrestore(&nvme_fc_lock, flags);
+
+	list_for_each_entry_safe(rport, tmp_rport,
+				 &nvme_fc_disc_list, disc_list) {
+		spin_lock_irqsave(&nvme_fc_lock, flags);
+		list_del_init(&rport->disc_list);
+		spin_unlock_irqrestore(&nvme_fc_lock, flags);
+		lport = rport->lport;
+		nvme_fc_signal_discovery_scan(lport, rport);
+		nvme_fc_rport_put(rport);
+		nvme_fc_lport_put(lport);
+	}
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
@@ -3404,16 +3472,16 @@ static int __init nvme_fc_init_module(void)
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
@@ -3428,9 +3496,9 @@ static int __init nvme_fc_init_module(void)
 	return 0;
 
 out_destroy_device:
-	device_destroy(fc_class, MKDEV(0, 0));
+	device_destroy(&fc_class, MKDEV(0, 0));
 out_destroy_class:
-	class_destroy(fc_class);
+	class_unregister(&fc_class);
 	return ret;
 }
 
@@ -3445,8 +3513,8 @@ static void __exit nvme_fc_exit_module(void)
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
