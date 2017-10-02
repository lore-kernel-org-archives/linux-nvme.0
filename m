From: hare@suse.de (Hannes Reinecke)
Date: Mon,  2 Oct 2017 15:55:58 +0200
Subject: [PATCH 5/6] nvme: Export subsystems to /sys/class/nvme-subsys
In-Reply-To: <1506952559-1588-1-git-send-email-hare@suse.de>
References: <1506952559-1588-1-git-send-email-hare@suse.de>
Message-ID: <1506952559-1588-6-git-send-email-hare@suse.de>

Create a class for each subsystem to create a 'device' link
for each subsystem device.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 36 +++++++++++++++++++++++++-----------
 drivers/nvme/host/nvme.h |  2 +-
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 955fedf..1ef11ca 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -79,6 +79,7 @@
 static DEFINE_SPINLOCK(dev_list_lock);
 
 static struct class *nvme_class;
+static struct class *nvme_subsys_class;
 static const struct attribute_group nvme_ns_id_attr_group;
 
 static __le32 nvme_get_log_dw10(u8 lid, size_t size)
@@ -1905,10 +1906,10 @@ static void __nvme_free_subsystem(struct nvme_subsystem *subsys)
 	kfree(subsys);
 }
 
-static void nvme_free_subsystem(struct kref *ref)
+static void nvme_free_subsystem(struct device *dev)
 {
 	struct nvme_subsystem *subsys =
-			container_of(ref, struct nvme_subsystem, ref);
+			container_of(dev, struct nvme_subsystem, dev);
 
 	mutex_lock(&nvme_subsystems_lock);
 	list_del(&subsys->entry);
@@ -1916,11 +1917,6 @@ static void nvme_free_subsystem(struct kref *ref)
 	__nvme_free_subsystem(subsys);
 }
 
-static void nvme_put_subsystem(struct nvme_subsystem *subsys)
-{
-	kref_put(&subsys->ref, nvme_free_subsystem);
-}
-
 static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
 {
 	struct nvme_subsystem *subsys;
@@ -1930,7 +1926,7 @@ static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
 	list_for_each_entry(subsys, &nvme_subsystems, entry) {
 		if (strcmp(subsys->subnqn, subsysnqn))
 			continue;
-		if (!kref_get_unless_zero(&subsys->ref))
+		if (!get_device(&subsys->dev))
 			continue;
 		return subsys;
 	}
@@ -1953,13 +1949,17 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 
 	INIT_LIST_HEAD(&subsys->ctrls);
 	INIT_LIST_HEAD(&subsys->nsheads);
-	kref_init(&subsys->ref);
 	nvme_init_subnqn(subsys, ctrl, id);
 	memcpy(subsys->serial, id->sn, sizeof(subsys->serial));
 	memcpy(subsys->model, id->mn, sizeof(subsys->model));
 	memcpy(subsys->firmware_rev, id->fr, sizeof(subsys->firmware_rev));
 	subsys->vendor_id = le16_to_cpu(id->vid);
 	mutex_init(&subsys->lock);
+	subsys->dev.class = nvme_subsys_class;
+	subsys->dev.parent = NULL;
+	subsys->dev.release = &nvme_free_subsystem;
+	dev_set_name(&subsys->dev, "subsys%u", subsys->instance);
+	device_initialize(&subsys->dev);
 
 	mutex_lock(&nvme_subsystems_lock);
 	found = __nvme_find_get_subsystem(subsys->subnqn);
@@ -1989,6 +1989,12 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
 	mutex_unlock(&subsys->lock);
 
+	if (!found) {
+		ret = device_add(&subsys->dev);
+		if (ret)
+			dev_err(ctrl->device,
+				"failed to register subsys device\n");
+	}
 	return 0;
 out_free_subsys:
 	kfree(subsys);
@@ -2891,7 +2897,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 			ns->disk->disk_name);
 
 	if (new) {
-		add_disk(ns->head->disk);
+		device_add_disk(&ns->head->subsys->dev, ns->head->disk);
 		if (sysfs_create_group(&disk_to_dev(ns->head->disk)->kobj,
 				&nvme_ns_id_attr_group))
 			pr_warn("%s: failed to create sysfs group for identification\n",
@@ -3309,7 +3315,7 @@ static void nvme_free_ctrl(struct kref *kref)
 	ctrl->ops->free_ctrl(ctrl);
 
 	if (subsys)
-		nvme_put_subsystem(subsys);
+		put_device(&subsys->dev);
 }
 
 void nvme_put_ctrl(struct nvme_ctrl *ctrl)
@@ -3500,8 +3506,15 @@ int __init nvme_core_init(void)
 		goto unregister_chrdev;
 	}
 
+	nvme_subsys_class = class_create(THIS_MODULE, "nvme-subsys");
+	if (IS_ERR(nvme_subsys_class)) {
+		result = PTR_ERR(nvme_subsys_class);
+		goto destroy_class;
+	}
 	return 0;
 
+destroy_class:
+	class_destroy(nvme_class);
 unregister_chrdev:
 	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
 destroy_wq:
@@ -3512,6 +3525,7 @@ int __init nvme_core_init(void)
 void nvme_core_exit(void)
 {
 	ida_destroy(&nvme_subsystems_ida);
+	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
 	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
 	destroy_workqueue(nvme_wq);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1f195ff..878ca87 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -202,11 +202,11 @@ struct nvme_ctrl {
 };
 
 struct nvme_subsystem {
+	struct device		dev;
 	struct list_head	entry;
 	struct mutex		lock;
 	struct list_head	ctrls;
 	struct list_head	nsheads;
-	struct kref		ref;
 	char			subnqn[NVMF_NQN_SIZE];
 	char			serial[20];
 	char			model[40];
-- 
1.8.5.6
