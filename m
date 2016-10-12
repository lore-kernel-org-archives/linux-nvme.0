From: shan.hai@oracle.com (Shan Hai)
Date: Wed, 12 Oct 2016 15:35:05 +0800
Subject: [PATCH 1/1] drivers/nvme: provide a module parameter for setting
 number of I/O queues
In-Reply-To: <1476257705-9836-1-git-send-email-shan.hai@oracle.com>
References: <1476257705-9836-1-git-send-email-shan.hai@oracle.com>
Message-ID: <1476257705-9836-2-git-send-email-shan.hai@oracle.com>

On a system installed with multiple nvme devices the cpu hotplug fails
with below message on the console:

CPU 2 disable failed: CPU has 189 vectors assigned and there are
only 0 available.

The current NVME driver allocates I/O queue per-cpu and alloctes IRQ
per-queue for the devices, a large number of IRQs will be allotted to
the I/O queues on a large NUMA/SMP system with multiple NVME devices
installed because of this design.

It would cause failure of CPU hotplug operations on the above mentioned
system, the problem is that the CPU cores could not be hotplugged after
certain number of them are offlined because the remaining online CPU cores
have not enough IRQ vectors to accept the large number of migrated IRQs.

This patch fixes it by providing a way to reduce the NVME queue IRQs to
an acceptable number.

Signed-off-by: Shan Hai <shan.hai at oracle.com>
---
 drivers/nvme/host/pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0fc99f0..7e04266 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -64,6 +64,10 @@
 module_param(use_cmb_sqes, bool, 0644);
 MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
 
+static unsigned int nvme_io_queues = UINT_MAX;
+module_param(nvme_io_queues, uint, 0);
+MODULE_PARM_DESC(nvme_io_queues, "set number of io queues");
+
 static struct workqueue_struct *nvme_workq;
 
 struct nvme_dev;
@@ -1394,7 +1398,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int result, nr_io_queues, size;
 
-	nr_io_queues = num_online_cpus();
+	nr_io_queues = min(nvme_io_queues,  num_online_cpus());
 	result = nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
 	if (result < 0)
 		return result;
-- 
1.8.3.1
