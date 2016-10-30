From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 30 Oct 2016 11:22:17 +0200
Subject: [PATCH] nvmet: Fix possible infinite loop triggered on hot namespace
 removal
Message-ID: <1477819337-31190-1-git-send-email-sagi@grimberg.me>

From: Solganik Alexander <sashas@lightbitslabs.com>

When removing a namespace we delete it from the subsystem namespaces
list with list_del_init which allows us to know if it is enabled or
not.

The problem is that list_del_init initialize the list next and does
not respect the RCU list-traversal we do on the IO path for locating
a namespace. Instead we need to use list_del_rcu which is allowed to
run concurrently with the _rcu list-traversal primitives (keeps list
next intact) and guarantees concurrent nvmet_find_naespace forward
progress.

By changing that, we cannot rely on ns->dev_link for knowing if the
namspace is enabled, so add a flags entry to nvmet_ns and use atomic
updates on NVMET_NS_ENABLED.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Solganik Alexander <sashas at lightbitslabs.com>
Cc: <stable at vger.kernel.org> # v4.8+
---
 drivers/nvme/target/core.c  | 29 +++++++++++++----------------
 drivers/nvme/target/nvmet.h |  5 +++++
 2 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index bbb6bba45e3c..efb78f23b0e7 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -261,11 +261,10 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 {
 	struct nvmet_subsys *subsys = ns->subsys;
 	struct nvmet_ctrl *ctrl;
-	int ret = 0;
+	int ret;
 
-	mutex_lock(&subsys->lock);
-	if (!list_empty(&ns->dev_link))
-		goto out_unlock;
+	if (test_and_set_bit(NVMET_NS_ENABLED, &ns->flags))
+		return 0;
 
 	ns->bdev = blkdev_get_by_path(ns->device_path, FMODE_READ | FMODE_WRITE,
 			NULL);
@@ -274,7 +273,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 			ns->device_path, PTR_ERR(ns->bdev));
 		ret = PTR_ERR(ns->bdev);
 		ns->bdev = NULL;
-		goto out_unlock;
+		goto out;
 	}
 
 	ns->size = i_size_read(ns->bdev->bd_inode);
@@ -292,6 +291,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	 * The namespaces list needs to be sorted to simplify the implementation
 	 * of the Identify Namepace List subcommand.
 	 */
+	mutex_lock(&subsys->lock);
 	if (list_empty(&subsys->namespaces)) {
 		list_add_tail_rcu(&ns->dev_link, &subsys->namespaces);
 	} else {
@@ -308,15 +308,15 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE, 0, 0);
-
-	ret = 0;
-out_unlock:
 	mutex_unlock(&subsys->lock);
-	return ret;
+
+	return 0;
+
 out_blkdev_put:
 	blkdev_put(ns->bdev, FMODE_WRITE|FMODE_READ);
 	ns->bdev = NULL;
-	goto out_unlock;
+out:
+	return ret;
 }
 
 void nvmet_ns_disable(struct nvmet_ns *ns)
@@ -324,13 +324,10 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	struct nvmet_subsys *subsys = ns->subsys;
 	struct nvmet_ctrl *ctrl;
 
-	mutex_lock(&subsys->lock);
-	if (list_empty(&ns->dev_link)) {
-		mutex_unlock(&subsys->lock);
+	if (!test_and_clear_bit(NVMET_NS_ENABLED, &ns->flags))
 		return;
-	}
-	list_del_init(&ns->dev_link);
-	mutex_unlock(&subsys->lock);
+
+	list_del_rcu(&ns->dev_link);
 
 	/*
 	 * Now that we removed the namespaces from the lookup list, we
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 76b6eedccaf9..f5db4b6a85c3 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -38,6 +38,10 @@
 #define IPO_IATTR_CONNECT_SQE(x)	\
 	(cpu_to_le32(offsetof(struct nvmf_connect_command, x)))
 
+enum nvmet_ns_flags {
+	NVMET_NS_ENABLED	= (1 << 0),
+};
+
 struct nvmet_ns {
 	struct list_head	dev_link;
 	struct percpu_ref	ref;
@@ -47,6 +51,7 @@ struct nvmet_ns {
 	loff_t			size;
 	u8			nguid[16];
 
+	unsigned long		flags;
 	struct nvmet_subsys	*subsys;
 	const char		*device_path;
 
-- 
2.7.4
