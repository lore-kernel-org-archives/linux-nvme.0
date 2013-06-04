From: keith.busch@intel.com (Keith Busch)
Date: Tue,  4 Jun 2013 17:55:51 -0600
Subject: [PATCH] NVMe: Async event request
Message-ID: <1370390151-24681-1-git-send-email-keith.busch@intel.com>

Just taking a stab at the async event request... This follows "option 2"
of the original proposal, so if multiple openers are listening for events,
they may step on each other's toes where some reader may see an event and
another reader will miss it.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   62 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/nvme.h      |    4 +++
 2 files changed, 65 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 42abf72..04ca408 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -164,6 +164,7 @@ static int alloc_cmdid_killable(struct nvme_queue *nvmeq, void *ctx,
 #define CMD_CTX_COMPLETED	(0x310 + CMD_CTX_BASE)
 #define CMD_CTX_INVALID		(0x314 + CMD_CTX_BASE)
 #define CMD_CTX_FLUSH		(0x318 + CMD_CTX_BASE)
+#define CMD_CTX_ASYNC		(0x31C + CMD_CTX_BASE)
 
 static void special_completion(struct nvme_dev *dev, void *ctx,
 						struct nvme_completion *cqe)
@@ -234,6 +235,19 @@ void put_nvmeq(struct nvme_queue *nvmeq)
 	put_cpu();
 }
 
+static void nvme_async_completion(struct nvme_dev *dev, void *ctx,
+						struct nvme_completion *cqe)
+{
+	u32 result = le32_to_cpup(&cqe->result);
+	u16 status = le16_to_cpup(&cqe->status) >> 1;
+
+	if (status == NVME_SC_SUCCESS) {
+		kfifo_in(&dev->aer_kfifo, &result, sizeof(result));
+		wake_up(&dev->aer_empty);
+		++dev->aerl;
+	}
+}
+
 /**
  * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
  * @nvmeq: The queue to use
@@ -976,7 +990,8 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 			.status = cpu_to_le16(NVME_SC_ABORT_REQ << 1),
 		};
 
-		if (timeout && !time_after(now, info[cmdid].timeout))
+		if (timeout && (!time_after(now, info[cmdid].timeout) ||
+				info[cmdid].ctx == CMD_CTX_ASYNC))
 			continue;
 		if (info[cmdid].ctx == CMD_CTX_CANCELLED)
 			continue;
@@ -1473,6 +1488,22 @@ static const struct block_device_operations nvme_fops = {
 	.compat_ioctl	= nvme_ioctl,
 };
 
+static void nvme_submit_async_req(struct nvme_dev *dev)
+{
+	int cmdid;
+	struct nvme_command c;
+	struct nvme_queue *nvmeq = dev->queues[0];
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = nvme_admin_async_event;
+	cmdid = alloc_cmdid(nvmeq, CMD_CTX_ASYNC, nvme_async_completion, 0);
+	if (cmdid < 0)
+		return;
+
+	c.common.command_id = cmdid;
+	nvme_submit_cmd(dev->queues[0], &c);
+}
+
 static void nvme_resubmit_bios(struct nvme_queue *nvmeq)
 {
 	while (bio_list_peek(&nvmeq->sq_cong)) {
@@ -1512,6 +1543,8 @@ static int nvme_kthread(void *data)
 				nvme_resubmit_bios(nvmeq);
 				spin_unlock_irq(&nvmeq->q_lock);
 			}
+			for (; dev->aerl > 0; dev->aerl--)
+				nvme_submit_async_req(dev);
 		}
 		spin_unlock(&dev_list_lock);
 		schedule_timeout(round_jiffies_relative(HZ));
@@ -1740,8 +1773,15 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	}
 
 	ctrl = mem;
+	init_waitqueue_head(&dev->aer_empty);
+	res = kfifo_alloc(&dev->aer_kfifo, (ctrl->aerl + 1) * sizeof(u32),
+								GFP_KERNEL);
+	if (res)
+		goto out;
+
 	nn = le32_to_cpup(&ctrl->nn);
 	dev->oncs = le16_to_cpup(&ctrl->oncs);
+	dev->aerl = ctrl->aerl + 1;
 	memcpy(dev->serial, ctrl->sn, sizeof(ctrl->sn));
 	memcpy(dev->model, ctrl->mn, sizeof(ctrl->mn));
 	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
@@ -1853,6 +1893,7 @@ static void nvme_release_instance(struct nvme_dev *dev)
 static void nvme_free_dev(struct kref *kref)
 {
 	struct nvme_dev *dev = container_of(kref, struct nvme_dev, kref);
+	kfifo_free(&dev->aer_kfifo);
 	nvme_dev_remove(dev);
 	pci_disable_msix(dev->pci_dev);
 	iounmap(dev->bar);
@@ -1892,10 +1933,29 @@ static long nvme_dev_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 	}
 }
 
+ssize_t nvme_dev_read(struct file *f, char __user *buf, size_t count,
+								loff_t *off)
+{
+	int ret;
+	unsigned int copied;
+	struct nvme_dev *dev = f->private_data;
+
+	if (count < sizeof(u32))
+		return -EINVAL;
+	if (f->f_flags & O_NONBLOCK)
+		return -EINVAL;
+	if (wait_event_killable(dev->aer_empty,
+					!kfifo_is_empty(&dev->aer_kfifo)))
+		return -EINTR;
+	ret = kfifo_to_user(&dev->aer_kfifo, buf, sizeof(u32), &copied);
+	return ret ? ret : copied;
+}
+
 static const struct file_operations nvme_dev_fops = {
 	.owner		= THIS_MODULE,
 	.open		= nvme_dev_open,
 	.release	= nvme_dev_release,
+	.read		= nvme_dev_read,
 	.unlocked_ioctl	= nvme_dev_ioctl,
 	.compat_ioctl	= nvme_dev_ioctl,
 };
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index f451c8d..a61e594 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -512,6 +512,7 @@ struct nvme_admin_cmd {
 #include <linux/pci.h>
 #include <linux/miscdevice.h>
 #include <linux/kref.h>
+#include <linux/kfifo.h>
 
 #define NVME_IO_TIMEOUT	(5 * HZ)
 
@@ -534,6 +535,8 @@ struct nvme_dev {
 	struct list_head namespaces;
 	struct kref kref;
 	struct miscdevice miscdev;
+	struct kfifo aer_kfifo;
+	wait_queue_head_t aer_empty;
 	char name[12];
 	char serial[20];
 	char model[40];
@@ -541,6 +544,7 @@ struct nvme_dev {
 	u32 max_hw_sectors;
 	u32 stripe_size;
 	u16 oncs;
+	u8 aerl;
 };
 
 /*
-- 
1.7.0.4
