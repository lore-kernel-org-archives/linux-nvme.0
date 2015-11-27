From: ww.tao0320@gmail.com (Wenwei Tao)
Date: Fri, 27 Nov 2015 12:09:43 +0800
Subject: [PATCH v2 2/3] lightnvm: handle targets when corresponding nvm device
 exit
In-Reply-To: <1448597384-27976-1-git-send-email-ww.tao0320@gmail.com>
References: <1448597384-27976-1-git-send-email-ww.tao0320@gmail.com>
Message-ID: <1448597384-27976-3-git-send-email-ww.tao0320@gmail.com>

block creations of new targets, remove exiting targets when
underlying device was gone.

Signed-off-by: Wenwei Tao <ww.tao0320 at gmail.com>
---
 drivers/lightnvm/core.c  | 128 +++++++++++++++++++++++++++++++----------------
 include/linux/lightnvm.h |   3 ++
 2 files changed, 87 insertions(+), 44 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 071a3e4..984db2f 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -33,6 +33,17 @@ static LIST_HEAD(nvm_targets);
 static LIST_HEAD(nvm_mgrs);
 static LIST_HEAD(nvm_devices);
 static DECLARE_RWSEM(nvm_lock);
+#define NVM_EXITING	1
+
+static inline int NvmExiting(struct nvm_dev *dev)
+{
+	return ((unsigned long)dev->ppalist_pool & NVM_EXITING) != 0;
+}
+
+static inline void *ppalist_pool(struct nvm_dev *dev)
+{
+	return (void *)((unsigned long)dev->ppalist_pool & ~NVM_EXITING);
+}
 
 static struct nvm_tgt_type *nvm_find_target_type(const char *name)
 {
@@ -74,7 +85,7 @@ EXPORT_SYMBOL(nvm_unregister_target);
 void *nvm_dev_dma_alloc(struct nvm_dev *dev, gfp_t mem_flags,
 							dma_addr_t *dma_handler)
 {
-	return dev->ops->dev_dma_alloc(dev->q, dev->ppalist_pool, mem_flags,
+	return dev->ops->dev_dma_alloc(dev->q, ppalist_pool(dev), mem_flags,
 								dma_handler);
 }
 EXPORT_SYMBOL(nvm_dev_dma_alloc);
@@ -82,7 +93,7 @@ EXPORT_SYMBOL(nvm_dev_dma_alloc);
 void nvm_dev_dma_free(struct nvm_dev *dev, void *ppa_list,
 							dma_addr_t dma_handler)
 {
-	dev->ops->dev_dma_free(dev->ppalist_pool, ppa_list, dma_handler);
+	dev->ops->dev_dma_free(ppalist_pool(dev), ppa_list, dma_handler);
 }
 EXPORT_SYMBOL(nvm_dev_dma_free);
 
@@ -228,15 +239,6 @@ static int nvm_core_init(struct nvm_dev *dev)
 	return 0;
 }
 
-static void nvm_free(struct nvm_dev *dev)
-{
-	if (!dev)
-		return;
-
-	if (dev->mt)
-		dev->mt->unregister_mgr(dev);
-}
-
 static int nvm_init(struct nvm_dev *dev)
 {
 	int ret = -EINVAL;
@@ -273,6 +275,7 @@ static int nvm_init(struct nvm_dev *dev)
 	up_write(&nvm_lock);
 	if (ret < 0)
 		goto err;
+	kref_init(&dev->kref);
 	if (!ret)
 		return 0;
 
@@ -286,12 +289,48 @@ err:
 	return ret;
 }
 
-static void nvm_exit(struct nvm_dev *dev)
+static void nvm_remove_target(struct nvm_target *t)
 {
-	if (dev->ppalist_pool)
-		dev->ops->destroy_dma_pool(dev->ppalist_pool);
-	nvm_free(dev);
+	struct nvm_tgt_type *tt = t->type;
+	struct gendisk *tdisk = t->disk;
+	struct request_queue *q = tdisk->queue;
 
+	lockdep_assert_held(&nvm_lock);
+
+	del_gendisk(tdisk);
+	if (tt->exit)
+		tt->exit(tdisk->private_data);
+
+	blk_cleanup_queue(q);
+
+	put_disk(tdisk);
+
+	list_del(&t->list);
+	kfree(t);
+}
+
+static inline void nvm_remove_targets(struct nvm_dev *dev)
+{
+	struct nvm_target *t, *n;
+
+	list_for_each_entry_safe(t, n, &dev->online_targets, list)
+		nvm_remove_target(t);
+}
+
+static void nvm_exit(struct kref *kref)
+{
+	struct nvm_dev *dev;
+
+	dev = container_of(kref, struct nvm_dev, kref);
+	if (ppalist_pool(dev))
+		dev->ops->destroy_dma_pool(ppalist_pool(dev));
+
+	if (dev->mt)
+		dev->mt->unregister_mgr(dev);
+
+	if (dev->ops->dev_remove)
+		dev->ops->dev_remove(dev->q);
+	kfree(dev);
 	pr_info("nvm: successfully unloaded\n");
 }
 
@@ -354,9 +393,10 @@ void nvm_unregister(char *disk_name)
 	}
 
 	list_del(&dev->devices);
+	nvm_remove_targets(dev);
+	dev->ppalist_pool += NVM_EXITING;
 	up_write(&nvm_lock);
-	nvm_exit(dev);
-	kfree(dev);
+	kref_put(&dev->kref, nvm_exit);
 }
 EXPORT_SYMBOL(nvm_unregister);
 
@@ -376,6 +416,10 @@ static int nvm_create_target(struct nvm_dev *dev,
 	int ret = 0;
 
 	down_write(&nvm_lock);
+	if (NvmExiting(dev)) {
+		up_write(&nvm_lock);
+		return -ENODEV;
+	}
 	if (!dev->mt) {
 		ret = register_mgr(dev);
 		if (!ret)
@@ -438,10 +482,18 @@ static int nvm_create_target(struct nvm_dev *dev,
 	t->disk = tdisk;
 
 	down_write(&nvm_lock);
+	if (NvmExiting(dev)) {
+		up_write(&nvm_lock);
+		goto err_nvm_exiting;
+	}
 	list_add_tail(&t->list, &dev->online_targets);
 	up_write(&nvm_lock);
 
 	return 0;
+err_nvm_exiting:
+	del_gendisk(tdisk);
+	if (tt->exit)
+		tt->exit(tdisk->private_data);
 err_init:
 	put_disk(tdisk);
 err_queue:
@@ -451,62 +503,50 @@ err_t:
 	return -ENOMEM;
 }
 
-static void nvm_remove_target(struct nvm_target *t)
-{
-	struct nvm_tgt_type *tt = t->type;
-	struct gendisk *tdisk = t->disk;
-	struct request_queue *q = tdisk->queue;
-
-	lockdep_assert_held(&nvm_lock);
-
-	del_gendisk(tdisk);
-	blk_cleanup_queue(q);
-
-	if (tt->exit)
-		tt->exit(tdisk->private_data);
-
-	put_disk(tdisk);
-
-	list_del(&t->list);
-	kfree(t);
-}
-
 static int __nvm_configure_create(struct nvm_ioctl_create *create)
 {
 	struct nvm_dev *dev;
 	struct nvm_ioctl_create_simple *s;
+	int ret = -EINVAL;
+
 	down_write(&nvm_lock);
 	dev = nvm_find_nvm_dev(create->dev);
-	up_write(&nvm_lock);
 	if (!dev) {
 		pr_err("nvm: device not found\n");
-		return -EINVAL;
+		up_write(&nvm_lock);
+		goto out;
 	}
+	kref_get(&dev->kref);
+	up_write(&nvm_lock);
 
 	if (create->conf.type != NVM_CONFIG_TYPE_SIMPLE) {
 		pr_err("nvm: config type not valid\n");
-		return -EINVAL;
+		goto out;
 	}
 	s = &create->conf.s;
 
 	if (s->lun_begin > s->lun_end || s->lun_end > dev->nr_luns) {
 		pr_err("nvm: lun out of bound (%u:%u > %u)\n",
 			s->lun_begin, s->lun_end, dev->nr_luns);
-		return -EINVAL;
+		goto out;
 	}
 
-	return nvm_create_target(dev, create);
+	ret = nvm_create_target(dev, create);
+out:
+	if (dev)
+		kref_put(&dev->kref, nvm_exit);
+	return ret;
 }
 
 static int __nvm_configure_remove(struct nvm_ioctl_remove *remove)
 {
-	struct nvm_target *t = NULL;
+	struct nvm_target *t, *n;
 	struct nvm_dev *dev;
 	int ret = -1;
 
 	down_write(&nvm_lock);
 	list_for_each_entry(dev, &nvm_devices, devices)
-		list_for_each_entry(t, &dev->online_targets, list) {
+		list_for_each_entry_safe(t, n, &dev->online_targets, list) {
 			if (!strcmp(remove->tgtname, t->disk->disk_name)) {
 				nvm_remove_target(t);
 				ret = 0;
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 3db5552..6a365a2 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -189,6 +189,7 @@ typedef void (nvm_destroy_dma_pool_fn)(void *);
 typedef void *(nvm_dev_dma_alloc_fn)(struct request_queue *, void *, gfp_t,
 								dma_addr_t *);
 typedef void (nvm_dev_dma_free_fn)(void *, void*, dma_addr_t);
+typedef void (nvm_dev_remove_fn) (struct request_queue *);
 
 struct nvm_dev_ops {
 	nvm_id_fn		*identity;
@@ -203,6 +204,7 @@ struct nvm_dev_ops {
 	nvm_destroy_dma_pool_fn	*destroy_dma_pool;
 	nvm_dev_dma_alloc_fn	*dev_dma_alloc;
 	nvm_dev_dma_free_fn	*dev_dma_free;
+	nvm_dev_remove_fn	*dev_remove;
 
 	unsigned int		max_phys_sect;
 };
@@ -238,6 +240,7 @@ struct nvm_dev {
 
 	/* Media manager */
 	struct nvmm_type *mt;
+	struct kref kref;
 	void *mp;
 
 	/* Device information */
-- 
1.8.3.1
