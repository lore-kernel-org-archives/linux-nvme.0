From: rama@fastorsystems.com (Ramachandra Rao Gajula)
Date: Thu, 24 Jan 2013 08:40:11 -0800
Subject: Linux NVME Driver - Added Single MSI supoort
Message-ID: <CAKt=HwJNYbeh=0hEzHQt6GeKK-S3Hu_sWNiB3XMgrcaxP3zoUQ@mail.gmail.com>

-----
Fixes include:
1. Support for single MSI interrupt; if MSI-X fails, then a single MSI
is enabled.
 - Old code didn't enable MSI-X for the initial admin queue setup
time, and later enables it at the time of setting up all the queues.
The new code enables 1 MSI-X vector for admin queue setup time,
disables it and later enables all the vectors needed for the number of
queues at the time of setting up all the queues.; not sure if this
code is correct for MSI-X and requires some review.

2. Free all the queues before deleting thee nvme devices at the time
of driver unload/shutdown.
------

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c

------

@@ -41,10 +41,12 @@
 #include <linux/types.h>
 #include <linux/version.h>

+
 #define NVME_Q_DEPTH 1024
 #define SQ_SIZE(depth)		(depth * sizeof(struct nvme_command))
 #define CQ_SIZE(depth)		(depth * sizeof(struct nvme_completion))
 #define NVME_MINORS 64
+
 #define NVME_IO_TIMEOUT	(5 * HZ)
 #define ADMIN_TIMEOUT	(60 * HZ)

@@ -72,6 +74,8 @@ struct nvme_dev {
 	int queue_count;
 	int db_stride;
 	u32 ctrl_config;
+	u32 int_method;
+	u32 msi_messages;
 	struct msix_entry *entry;
 	struct nvme_bar __iomem *bar;
 	struct list_head namespaces;
@@ -81,6 +85,12 @@ struct nvme_dev {
 	u32 max_hw_sectors;
 };

+/*
+ * Interrupt used for this NVME device - set in int_method based on
what is available/enabled by the driver
+ */
+#define NVME_INTERRUPT_MSI_X	1
+#define NVME_INTERRUPT_MSI	2
+
 /*
  * An NVM Express namespace is equivalent to a SCSI LUN
  */
@@ -678,6 +688,27 @@ static irqreturn_t nvme_process_cq(struct
nvme_queue *nvmeq)
 	return IRQ_HANDLED;
 }

+static irqreturn_t nvme_msi(int irq, void *data)
+{
+        struct nvme_dev *dev = (struct nvme_dev *)data;
+        unsigned long flags;
+
+        spin_lock_irqsave(&dev_list_lock,flags);
+        list_for_each_entry(dev, &dev_list, node) {
+                int i;
+                for (i = 0; i < dev->queue_count; i++) {
+                        struct nvme_queue *nvmeq = dev->queues[i];
+                        if (!nvmeq)
+                                continue;
+                        spin_lock_irq(&nvmeq->q_lock);
+
+                        nvme_process_cq(nvmeq);
+                        spin_unlock_irq(&nvmeq->q_lock);
+                }
+        }
+        spin_unlock_irqrestore(&dev_list_lock, flags);
+        return IRQ_HANDLED;
+}
 static irqreturn_t nvme_irq(int irq, void *data)
 {
 	irqreturn_t result;
@@ -697,6 +728,7 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 	return IRQ_WAKE_THREAD;
 }

+
 static void nvme_abort_command(struct nvme_queue *nvmeq, int cmdid)
 {
 	spin_lock_irq(&nvmeq->q_lock);
@@ -913,8 +945,11 @@ static void nvme_free_queue(struct nvme_dev *dev, int qid)
 	nvme_cancel_ios(nvmeq, false);
 	spin_unlock_irq(&nvmeq->q_lock);

-	irq_set_affinity_hint(vector, NULL);
-	free_irq(vector, nvmeq);
+	// Free up the interrupt vector/message only when we use multiple
vectors/messages - one per queue
+	if (dev->int_method == NVME_INTERRUPT_MSI_X) {
+		irq_set_affinity_hint(vector, NULL);
+		free_irq(vector, nvmeq);
+	}

 	/* Don't tell the adapter to delete the admin queue */
 	if (qid) {
@@ -971,15 +1006,29 @@ static struct nvme_queue
*nvme_alloc_queue(struct nvme_dev *dev, int qid,
 static int queue_request_irq(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 							const char *name)
 {
-	if (use_threaded_interrupts)
-		return request_threaded_irq(dev->entry[nvmeq->cq_vector].vector,
+	int result = 0;
+
+	if (dev->int_method == NVME_INTERRUPT_MSI_X)
+	{
+		if (use_threaded_interrupts)
+			result = request_threaded_irq(dev->entry[nvmeq->cq_vector].vector,
 					nvme_irq_check, nvme_irq,
 					IRQF_DISABLED | IRQF_SHARED,
 					name, nvmeq);
-	return request_irq(dev->entry[nvmeq->cq_vector].vector, nvme_irq,
+		else
+			result = request_irq(dev->entry[nvmeq->cq_vector].vector, nvme_irq,
 				IRQF_DISABLED | IRQF_SHARED, name, nvmeq);
+	}
+	else if ((dev->int_method == NVME_INTERRUPT_MSI) && (!dev->msi_messages))
+	{
+		result = request_irq(dev->pci_dev->irq,nvme_msi,
+				IRQF_DISABLED | IRQF_SHARED,name,dev);
+		dev->msi_messages++;
+	}
+	return result;
 }

+
 static __devinit struct nvme_queue *nvme_create_queue(struct nvme_dev *dev,
 					int qid, int cq_size, int vector)
 {
@@ -1016,6 +1065,40 @@ static __devinit struct nvme_queue
*nvme_create_queue(struct nvme_dev *dev,
 	return ERR_PTR(result);
 }

+static int nvme_enable_interrupt(struct nvme_dev *dev,int *count)
+{
+	int result = 0;
+	u32	i = 0;
+
+	// first try MSI-X; if it fails, fall back to single MSI message interrupt
+	// initialize vector number table for MSI-X
+	for (i = 0; i < *count; i++)
+		dev->entry[i].entry = i;
+
+	dev->int_method = NVME_INTERRUPT_MSI_X;
+	result = pci_enable_msix(dev->pci_dev, dev->entry, *count);
+	if (result == 0)
+		return result;
+	else if (result > 0) {
+		*count = result;	// update available/allocated vectors
+		result = pci_enable_msix(dev->pci_dev, dev->entry, *count);
+		if (result == 0)
+			return result;
+		// since we were told correct count of vectors, result cannot be >
0 at this point, but can be < 0 - error case; just fall through
+	}
+
+	// Fall through here if pci_enable_msix failed (result < 0 ); try
allocating a single MSI interrupt
+	dev->int_method = NVME_INTERRUPT_MSI;
+	result = pci_enable_msi(dev->pci_dev);
+	if (result == 0)
+		return result;
+
+	dev->int_method = 0; // neither MSI/MSI-X; all we do is return queue
count as 1
+	//printk(KERN_WARN "NVME: Failed to enable MSI-X or MSI; running
without interrupts\n");
+	*count = 1;
+	return result;
+}
+
 static int __devinit nvme_configure_admin_queue(struct nvme_dev *dev)
 {
 	int result = 0;
@@ -1023,6 +1106,7 @@ static int __devinit
nvme_configure_admin_queue(struct nvme_dev *dev)
 	u64 cap;
 	unsigned long timeout;
 	struct nvme_queue *nvmeq;
+	int admin_int_count = 1;

 	dev->dbs = ((void __iomem *)dev->bar) + 4096;

@@ -1064,7 +1148,12 @@ static int __devinit
nvme_configure_admin_queue(struct nvme_dev *dev)
 		return result;
 	}

-	result = queue_request_irq(dev, nvmeq, "nvme admin");
+	result = nvme_enable_interrupt(dev,&admin_int_count);
+
+	if (result == 0) // ask for irq only msi-x/msi got enabled first
+		result = queue_request_irq(dev, nvmeq, "nvme admin");
+	//XXX: TODO: Handle errors here
+
 	dev->queues[0] = nvmeq;
 	return result;
 }
@@ -1295,6 +1384,7 @@ static int nvme_kthread(void *data)
 				struct nvme_queue *nvmeq = dev->queues[i];
 				if (!nvmeq)
 					continue;
+
 				spin_lock_irq(&nvmeq->q_lock);
 				if (nvme_process_cq(nvmeq))
 					printk("process_cq did something\n");
@@ -1415,7 +1505,7 @@ static int set_queue_count(struct nvme_dev *dev,
int count)

 static int __devinit nvme_setup_io_queues(struct nvme_dev *dev)
 {
-	int result, cpu, i, nr_io_queues, db_bar_size, q_depth;
+	int result, i, nr_io_queues, db_bar_size, q_depth;

 	nr_io_queues = num_online_cpus();
 	result = set_queue_count(dev, nr_io_queues);
@@ -1425,7 +1515,15 @@ static int __devinit
nvme_setup_io_queues(struct nvme_dev *dev)
 		nr_io_queues = result;

 	/* Deregister the admin queue's interrupt */
-	free_irq(dev->entry[0].vector, dev->queues[0]);
+	if (dev->int_method == NVME_INTERRUPT_MSI_X) {
+		free_irq(dev->entry[0].vector, dev->queues[0]);
+		pci_disable_msix(dev->pci_dev);
+	}
+	else if (dev->int_method == NVME_INTERRUPT_MSI) {
+		free_irq(dev->pci_dev->irq,dev);
+		dev->msi_messages = 0;
+		pci_disable_msi(dev->pci_dev);
+	}

 	db_bar_size = 4096 + ((nr_io_queues + 1) << (dev->db_stride + 3));
 	if (db_bar_size > 8192) {
@@ -1436,29 +1534,19 @@ static int __devinit
nvme_setup_io_queues(struct nvme_dev *dev)
 		dev->queues[0]->q_db = dev->dbs;
 	}

-	for (i = 0; i < nr_io_queues; i++)
-		dev->entry[i].entry = i;
-	for (;;) {
-		result = pci_enable_msix(dev->pci_dev, dev->entry,
-								nr_io_queues);
-		if (result == 0) {
-			break;
-		} else if (result > 0) {
-			nr_io_queues = result;
-			continue;
-		} else {
-			nr_io_queues = 1;
-			break;
-		}
-	}
+	result = nvme_enable_interrupt(dev,&nr_io_queues);

 	result = queue_request_irq(dev, dev->queues[0], "nvme admin");
+
 	/* XXX: handle failure here */

-	cpu = cpumask_first(cpu_online_mask);
-	for (i = 0; i < nr_io_queues; i++) {
-		irq_set_affinity_hint(dev->entry[i].vector, get_cpu_mask(cpu));
-		cpu = cpumask_next(cpu, cpu_online_mask);
+	if (dev->int_method == NVME_INTERRUPT_MSI_X ) {
+		// assign CPU affinity only for MSI-X interrupts!
+		int cpu = cpumask_first(cpu_online_mask);
+		for (i = 0; i < nr_io_queues; i++) {
+			irq_set_affinity_hint(dev->entry[i].vector, get_cpu_mask(cpu));
+			cpu = cpumask_next(cpu, cpu_online_mask);
+		}
 	}

 	q_depth = min_t(int, NVME_CAP_MQES(readq(&dev->bar->cap)) + 1,
@@ -1484,6 +1572,13 @@ static void nvme_free_queues(struct nvme_dev *dev)

 	for (i = dev->queue_count - 1; i >= 0; i--)
 		nvme_free_queue(dev, i);
+
+	// if MSI was used, free up the single vector after freeing up all the queues
+	if (dev->int_method == NVME_INTERRUPT_MSI)
+	{
+		free_irq(dev->pci_dev->irq, dev);
+		dev->msi_messages = 0;
+	}
 }

 static int __devinit nvme_dev_add(struct nvme_dev *dev)
@@ -1556,6 +1651,8 @@ static int nvme_dev_remove(struct nvme_dev *dev)
 {
 	struct nvme_ns *ns, *next;

+	nvme_free_queues(dev);
+
 	spin_lock(&dev_list_lock);
 	list_del(&dev->node);
 	spin_unlock(&dev_list_lock);
@@ -1566,7 +1663,7 @@ static int nvme_dev_remove(struct nvme_dev *dev)
 		nvme_ns_free(ns);
 	}

-	nvme_free_queues(dev);
+	//nvme_free_queues(dev);

 	return 0;
 }
@@ -1694,7 +1791,10 @@ static int __devinit nvme_probe(struct pci_dev *pdev,
  unmap:
 	iounmap(dev->bar);
  disable_msix:
-	pci_disable_msix(pdev);
+	if (dev->int_method == NVME_INTERRUPT_MSI_X)
+		pci_disable_msix(pdev);
+	else if (dev->int_method == NVME_INTERRUPT_MSI)
+		pci_disable_msi(pdev);
 	nvme_release_instance(dev);
 	nvme_release_prp_pools(dev);
  disable:
@@ -1711,7 +1811,12 @@ static void __devexit nvme_remove(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 	nvme_dev_remove(dev);
-	pci_disable_msix(pdev);
+
+	if (dev->int_method == NVME_INTERRUPT_MSI_X)
+		pci_disable_msix(pdev);
+	else if (dev->int_method == NVME_INTERRUPT_MSI)
+		pci_disable_msi(pdev);
+
 	iounmap(dev->bar);
 	nvme_release_instance(dev);
 	nvme_release_prp_pools(dev);
