From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Thu,  2 May 2019 14:47:52 +0300
Subject: [PATCH v2 01/10] vfio/mdev: add notifier for map events
In-Reply-To: <20190502114801.23116-1-mlevitsk@redhat.com>
References: <20190502114801.23116-1-mlevitsk@redhat.com>
Message-ID: <20190502114801.23116-2-mlevitsk@redhat.com>

Allow an VFIO mdev device to listen to map events
This will allow a mdev driver to dma map memory
as soon as it gets added to the domain

--
Signed-off-by: Maxim Levitsky <mlevitsk at redhat.com>
---
 drivers/vfio/vfio_iommu_type1.c | 97 +++++++++++++++++++++++++++++----
 include/linux/vfio.h            |  4 ++
 2 files changed, 89 insertions(+), 12 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index d0f731c9920a..393b56d78166 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -63,17 +63,22 @@ module_param_named(dma_entry_limit, dma_entry_limit, uint, 0644);
 MODULE_PARM_DESC(dma_entry_limit,
 		 "Maximum number of user DMA mappings per container (65535).");
 
+/* a container, usually one per VM*/
 struct vfio_iommu {
 	struct list_head	domain_list;
 	struct vfio_domain	*external_domain; /* domain for external user */
 	struct mutex		lock;
 	struct rb_root		dma_list;
-	struct blocking_notifier_head notifier;
+	struct blocking_notifier_head map_notifiers;
+	struct blocking_notifier_head unmap_notifiers;
 	unsigned int		dma_avail;
 	bool			v2;
 	bool			nesting;
 };
 
+/* An IOMMU domain - also usually one per VM, unless devices assigned to VM
+ * are connected via different IOMMUs
+ */
 struct vfio_domain {
 	struct iommu_domain	*domain;
 	struct list_head	next;
@@ -563,8 +568,7 @@ static int vfio_iommu_type1_pin_pages(void *iommu_data,
 
 	mutex_lock(&iommu->lock);
 
-	/* Fail if notifier list is empty */
-	if ((!iommu->external_domain) || (!iommu->notifier.head)) {
+	if (!iommu->external_domain) {
 		ret = -EINVAL;
 		goto pin_done;
 	}
@@ -967,7 +971,7 @@ static int vfio_dma_do_unmap(struct vfio_iommu *iommu,
 			 * invalidation.
 			 */
 			mutex_unlock(&iommu->lock);
-			blocking_notifier_call_chain(&iommu->notifier,
+			blocking_notifier_call_chain(&iommu->unmap_notifiers,
 						    VFIO_IOMMU_NOTIFY_DMA_UNMAP,
 						    &nb_unmap);
 			goto again;
@@ -1144,6 +1148,22 @@ static int vfio_dma_do_map(struct vfio_iommu *iommu,
 	else
 		ret = vfio_pin_map_dma(iommu, dma, size);
 
+	mutex_unlock(&iommu->lock);
+
+	/*
+	 * Notify anyone (mdev vendor drivers) that new mapping has being
+	 * created - vendor drivers can in response pin/dma map the memory
+	 */
+	ret = blocking_notifier_call_chain(&iommu->map_notifiers,
+				    VFIO_IOMMU_NOTIFY_DMA_MAP,
+				    map);
+
+	ret = notifier_to_errno(ret);
+	if (ret)
+		vfio_remove_dma(iommu, dma);
+
+	return ret;
+
 out_unlock:
 	mutex_unlock(&iommu->lock);
 	return ret;
@@ -1508,7 +1528,8 @@ static void vfio_sanity_check_pfn_list(struct vfio_iommu *iommu)
 			break;
 	}
 	/* mdev vendor driver must unregister notifier */
-	WARN_ON(iommu->notifier.head);
+	WARN_ON(iommu->map_notifiers.head);
+	WARN_ON(iommu->unmap_notifiers.head);
 }
 
 static void vfio_iommu_type1_detach_group(void *iommu_data,
@@ -1598,7 +1619,8 @@ static void *vfio_iommu_type1_open(unsigned long arg)
 	iommu->dma_list = RB_ROOT;
 	iommu->dma_avail = dma_entry_limit;
 	mutex_init(&iommu->lock);
-	BLOCKING_INIT_NOTIFIER_HEAD(&iommu->notifier);
+	BLOCKING_INIT_NOTIFIER_HEAD(&iommu->unmap_notifiers);
+	BLOCKING_INIT_NOTIFIER_HEAD(&iommu->map_notifiers);
 
 	return iommu;
 }
@@ -1738,23 +1760,74 @@ static int vfio_iommu_type1_register_notifier(void *iommu_data,
 					      struct notifier_block *nb)
 {
 	struct vfio_iommu *iommu = iommu_data;
+	struct rb_node *node;
+	int ret = 0;
+
+	if (*events == VFIO_IOMMU_NOTIFY_DMA_MAP) {
+
+		/* now register the notifier */
+		ret = blocking_notifier_chain_register(&iommu->map_notifiers,
+				nb);
 
-	/* clear known events */
-	*events &= ~VFIO_IOMMU_NOTIFY_DMA_UNMAP;
+		/* replay the mapping */
+		 node = rb_first(&iommu->dma_list);
+		while (node) {
+			struct vfio_dma *dma = rb_entry(node, struct vfio_dma,
+					node);
 
-	/* refuse to register if still events remaining */
-	if (*events)
+			struct vfio_iommu_type1_dma_map map;
+
+			map.argsz = sizeof(struct vfio_iommu_type1_dma_map);
+			map.flags = 0;
+
+			if (dma->prot & IOMMU_READ)
+				map.flags |= VFIO_DMA_MAP_FLAG_READ;
+			if (dma->prot & IOMMU_WRITE)
+				map.flags |= VFIO_DMA_MAP_FLAG_WRITE;
+
+			map.iova = dma->iova;
+			map.vaddr = dma->vaddr;
+			map.size = dma->size;
+
+			node = rb_next(node);
+
+			/* Call only the first notifier, the one that
+			 * we just registered
+			 */
+			ret = __blocking_notifier_call_chain(
+					&iommu->map_notifiers,
+					VFIO_IOMMU_NOTIFY_DMA_MAP,
+					&map, 1, NULL);
+
+			ret = notifier_to_errno(ret);
+			if (ret) {
+				blocking_notifier_chain_unregister(
+						&iommu->map_notifiers, nb);
+				return ret;
+			}
+		}
+
+	} else if (*events == VFIO_IOMMU_NOTIFY_DMA_UNMAP) {
+		ret =  blocking_notifier_chain_register(
+				&iommu->unmap_notifiers, nb);
+	} else {
 		return -EINVAL;
+	}
+	return ret;
 
-	return blocking_notifier_chain_register(&iommu->notifier, nb);
 }
 
 static int vfio_iommu_type1_unregister_notifier(void *iommu_data,
 						struct notifier_block *nb)
 {
 	struct vfio_iommu *iommu = iommu_data;
+	int ret;
 
-	return blocking_notifier_chain_unregister(&iommu->notifier, nb);
+	ret = blocking_notifier_chain_unregister(&iommu->map_notifiers, nb);
+	if (ret)
+		ret = blocking_notifier_chain_unregister(
+				&iommu->unmap_notifiers, nb);
+	return ret;
 }
 
 static const struct vfio_iommu_driver_ops vfio_iommu_driver_ops_type1 = {
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index 66741ab087c1..957f09263bfe 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -118,10 +118,14 @@ enum vfio_notify_type {
 
 /* events for VFIO_IOMMU_NOTIFY */
 #define VFIO_IOMMU_NOTIFY_DMA_UNMAP	BIT(0)
+#define VFIO_IOMMU_NOTIFY_DMA_MAP	BIT(1)
 
 /* events for VFIO_GROUP_NOTIFY */
 #define VFIO_GROUP_NOTIFY_SET_KVM	BIT(0)
 
+/* Note: currently you can only register a notifier for a single event
+ * at the time
+ */
 extern int vfio_register_notifier(struct device *dev,
 				  enum vfio_notify_type type,
 				  unsigned long *required_events,
-- 
2.17.2
