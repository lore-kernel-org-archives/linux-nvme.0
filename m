From: keith.busch@intel.com (Keith Busch)
Date: Wed, 15 May 2019 15:33:51 -0600
Subject: [PATCH RFC] nvme: Common subsys and controller instances IDA
Message-ID: <20190515213351.22190-1-keith.busch@intel.com>

The controller char device name used to be a subset of all its
namespace block device names, but that's not true when we name block
devices for their parent subsystem. It's long been the case that the
numerals appended to our device handles are simply the first unique
number available. They do not have any more significance in relations
to other devices with simpler numeric prefixes.

However, this disconnect has led to some very unfortunate situations
where people assume the old behavior, and accidently have lost data
because they issue admin commands to the wrong device. For example,
I want to format /dev/nvme0n1 and /dev/nvme0n2, so I'll run:

  # nvme format /dev/nvme0

to hit up all namespaces attached to nvme0. The problem is that nvme0's
namespaces may not even be those desired namespaces, and now I've lost
data on devices I wished to preserve.

So here's a solution that no one will like: pull subsystem and controller
instances from the same IDA so that there won't be any namespace block
devices with a matching controller handle name. While this does nothing
to clear up device relationships, this will force the user to think
really hard about what they're doing and avoid such mistakes.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a6644a2c3ef7..1d17732267f0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -80,7 +80,6 @@ EXPORT_SYMBOL_GPL(nvme_reset_wq);
 struct workqueue_struct *nvme_delete_wq;
 EXPORT_SYMBOL_GPL(nvme_delete_wq);
 
-static DEFINE_IDA(nvme_subsystems_ida);
 static LIST_HEAD(nvme_subsystems);
 static DEFINE_MUTEX(nvme_subsystems_lock);
 
@@ -2247,7 +2246,7 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
 
 static void __nvme_release_subsystem(struct nvme_subsystem *subsys)
 {
-	ida_simple_remove(&nvme_subsystems_ida, subsys->instance);
+	ida_simple_remove(&nvme_instance_ida, subsys->instance);
 	kfree(subsys);
 }
 
@@ -2366,7 +2365,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
 	if (!subsys)
 		return -ENOMEM;
-	ret = ida_simple_get(&nvme_subsystems_ida, 0, 0, GFP_KERNEL);
+	ret = ida_simple_get(&nvme_instance_ida, 0, 0, GFP_KERNEL);
 	if (ret < 0) {
 		kfree(subsys);
 		return ret;
@@ -3958,7 +3957,6 @@ static int __init nvme_core_init(void)
 
 static void __exit nvme_core_exit(void)
 {
-	ida_destroy(&nvme_subsystems_ida);
 	class_destroy(nvme_subsys_class);
 	class_destroy(nvme_class);
 	unregister_chrdev_region(nvme_chr_devt, NVME_MINORS);
-- 
2.14.4
