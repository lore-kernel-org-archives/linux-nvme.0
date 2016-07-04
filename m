From: hch@lst.de (Christoph Hellwig)
Date: Mon,  4 Jul 2016 17:39:22 +0900
Subject: [PATCH 01/13] irq/msi: Remove unused MSI_FLAG_IDENTITY_MAP
In-Reply-To: <1467621574-8277-1-git-send-email-hch@lst.de>
References: <1467621574-8277-1-git-send-email-hch@lst.de>
Message-ID: <1467621574-8277-2-git-send-email-hch@lst.de>

From: Thomas Gleixner <tglx@linutronix.de>

No user and we definitely don't want to grow one.

Signed-off-by: Thomas Gleixner <tglx at linutronix.de>
Reviewed-by: Bart Van Assche <bart.vanassche at sandisk.com>
---
 include/linux/msi.h | 6 ++----
 kernel/irq/msi.c    | 8 ++------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 8b425c6..c33abfa 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -264,12 +264,10 @@ enum {
 	 * callbacks.
 	 */
 	MSI_FLAG_USE_DEF_CHIP_OPS	= (1 << 1),
-	/* Build identity map between hwirq and irq */
-	MSI_FLAG_IDENTITY_MAP		= (1 << 2),
 	/* Support multiple PCI MSI interrupts */
-	MSI_FLAG_MULTI_PCI_MSI		= (1 << 3),
+	MSI_FLAG_MULTI_PCI_MSI		= (1 << 2),
 	/* Support PCI MSIX interrupts */
-	MSI_FLAG_PCI_MSIX		= (1 << 4),
+	MSI_FLAG_PCI_MSIX		= (1 << 3),
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 38e89ce..eb5bf2b 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -324,7 +324,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 	struct msi_domain_ops *ops = info->ops;
 	msi_alloc_info_t arg;
 	struct msi_desc *desc;
-	int i, ret, virq = -1;
+	int i, ret, virq;
 
 	ret = msi_domain_prepare_irqs(domain, dev, nvec, &arg);
 	if (ret)
@@ -332,12 +332,8 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 
 	for_each_msi_entry(desc, dev) {
 		ops->set_desc(&arg, desc);
-		if (info->flags & MSI_FLAG_IDENTITY_MAP)
-			virq = (int)ops->get_hwirq(info, &arg);
-		else
-			virq = -1;
 
-		virq = __irq_domain_alloc_irqs(domain, virq, desc->nvec_used,
+		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
 					       dev_to_node(dev), &arg, false);
 		if (virq < 0) {
 			ret = -ENOSPC;
-- 
2.1.4
