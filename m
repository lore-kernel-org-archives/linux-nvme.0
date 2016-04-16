From: hch@lst.de (Christoph Hellwig)
Date: Fri, 15 Apr 2016 18:35:45 -0700
Subject: [PATCH 1/8] device: Add irq affinity hint cpumask pointer
In-Reply-To: <1460770552-31260-1-git-send-email-hch@lst.de>
References: <1460770552-31260-1-git-send-email-hch@lst.de>
Message-ID: <1460770552-31260-2-git-send-email-hch@lst.de>

From: Thomas Gleixner <tglx@linutronix.de>

This optional cpumask will be used by the irq core code to optimize interrupt
allocation and affinity setup for multiqueue devices.

Signed-off-by: Thomas Gleixner <tglx at linutronix.de>
---
 include/linux/device.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 002c597..0270103 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -741,6 +741,8 @@ struct device_dma_parameters {
  * @msi_list:	Hosts MSI descriptors
  * @msi_domain: The generic MSI domain this device is using.
  * @numa_node:	NUMA node this device is close to.
+ * @irq_affinity: Hint for irq affinities and descriptor allocation
+ *		  (optional).
  * @dma_mask:	Dma mask (if dma'ble device).
  * @coherent_dma_mask: Like dma_mask, but for alloc_coherent mapping as not all
  * 		hardware supports 64-bit addresses for consistent allocations
@@ -813,6 +815,8 @@ struct device {
 #ifdef CONFIG_NUMA
 	int		numa_node;	/* NUMA node this device is close to */
 #endif
+
+	struct cpumask	*irq_affinity;
 	u64		*dma_mask;	/* dma mask (if dma'able device) */
 	u64		coherent_dma_mask;/* Like dma_mask, but for
 					     alloc_coherent mappings as
-- 
2.1.4
