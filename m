From: sbradshaw@micron.com (Sam Bradshaw)
Date: Thu, 4 Dec 2014 09:43:47 -0800
Subject: [PATCH] NVMe: Remove remnants of cpu hotplug
Message-ID: <54809D53.4060404@micron.com>

This patch cleans up some code inherited from the cpu hotplug handling, 
including correcting a bug where hctx->cpumask included non-schedulable 
cpus (backtrace attached).

Signed-off-by: Selvan Mani <smani at micron.com>
Signed-off-by: Sam Bradshaw <sbradshaw at micron.com>
---
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index bcbdf83..57ed698 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -76,7 +76,6 @@ static LIST_HEAD(dev_list);
 static struct task_struct *nvme_thread;
 static struct workqueue_struct *nvme_workq;
 static wait_queue_head_t nvme_kthread_wait;
-static struct notifier_block nvme_nb;
 
 static void nvme_reset_failed_dev(struct work_struct *ws);
 static int nvme_process_cq(struct nvme_queue *nvmeq);
@@ -1981,7 +1980,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	struct pci_dev *pdev = dev->pci_dev;
 	int result, i, vecs, nr_io_queues, size;
 
-	nr_io_queues = num_possible_cpus();
+	nr_io_queues = num_online_cpus();
 	result = set_queue_count(dev, nr_io_queues);
 	if (result <= 0)
 		return result;
@@ -2878,7 +2877,6 @@ static int __init nvme_init(void)
 static void __exit nvme_exit(void)
 {
 	pci_unregister_driver(&nvme_driver);
-	unregister_hotcpu_notifier(&nvme_nb);
 	unregister_blkdev(nvme_major, "nvme");
 	destroy_workqueue(nvme_workq);
 	BUG_ON(nvme_thread && !IS_ERR(nvme_thread));
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: bt
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20141204/645d4d01/attachment-0001.ksh>
