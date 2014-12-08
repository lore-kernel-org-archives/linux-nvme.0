From: keith.busch@intel.com (Keith Busch)
Date: Mon,  8 Dec 2014 16:01:50 -0700
Subject: [PATCH] misc: Increase available dyanmic minors
Message-ID: <1418079710-30968-1-git-send-email-keith.busch@intel.com>

This increases the number of available miscellaneous character device
dynamic minors from 63 to the max minor, 1M.

Dynamic minor previously started at 63 and went down to zero. That's not
enough in some situations, and also eventually creates a collision with
'psaux' misc device. This patch starts minors at the last defined misc
minor (255) and works up to the max possible.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/char/misc.c |   23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/drivers/char/misc.c b/drivers/char/misc.c
index ffa97d2..229dba5 100644
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -59,8 +59,7 @@ static DEFINE_MUTEX(misc_mtx);
 /*
  * Assigned numbers, used for dynamic minors
  */
-#define DYNAMIC_MINORS 64 /* like dynamic majors */
-static DECLARE_BITMAP(misc_minors, DYNAMIC_MINORS);
+static DEFINE_IDA(misc_minors_ida);
 
 #ifdef CONFIG_PROC_FS
 static void *misc_seq_start(struct seq_file *seq, loff_t *pos)
@@ -183,15 +182,14 @@ int misc_register(struct miscdevice * misc)
 	INIT_LIST_HEAD(&misc->list);
 
 	mutex_lock(&misc_mtx);
-
 	if (misc->minor == MISC_DYNAMIC_MINOR) {
-		int i = find_first_zero_bit(misc_minors, DYNAMIC_MINORS);
-		if (i >= DYNAMIC_MINORS) {
+		int i = ida_simple_get(&misc_minors_ida, MISC_DYNAMIC_MINOR,
+						MINORMASK, GFP_KERNEL);
+		if (i < 0) {
 			err = -EBUSY;
 			goto out;
 		}
-		misc->minor = DYNAMIC_MINORS - i - 1;
-		set_bit(i, misc_minors);
+		misc->minor = i;
 	} else {
 		struct miscdevice *c;
 
@@ -208,9 +206,8 @@ int misc_register(struct miscdevice * misc)
 	misc->this_device = device_create(misc_class, misc->parent, dev,
 					  misc, "%s", misc->name);
 	if (IS_ERR(misc->this_device)) {
-		int i = DYNAMIC_MINORS - misc->minor - 1;
-		if (i < DYNAMIC_MINORS && i >= 0)
-			clear_bit(i, misc_minors);
+		if (misc->minor >= MISC_DYNAMIC_MINOR)
+			ida_simple_remove(&misc_minors_ida, misc->minor);
 		err = PTR_ERR(misc->this_device);
 		goto out;
 	}
@@ -237,16 +234,14 @@ int misc_register(struct miscdevice * misc)
 
 int misc_deregister(struct miscdevice *misc)
 {
-	int i = DYNAMIC_MINORS - misc->minor - 1;
-
 	if (WARN_ON(list_empty(&misc->list)))
 		return -EINVAL;
 
 	mutex_lock(&misc_mtx);
 	list_del(&misc->list);
 	device_destroy(misc_class, MKDEV(MISC_MAJOR, misc->minor));
-	if (i < DYNAMIC_MINORS && i >= 0)
-		clear_bit(i, misc_minors);
+	if (misc->minor >= MISC_DYNAMIC_MINOR)
+		ida_simple_remove(&misc_minors_ida, misc->minor);
 	mutex_unlock(&misc_mtx);
 	return 0;
 }
-- 
1.7.10.4
