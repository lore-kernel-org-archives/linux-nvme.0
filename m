From: keith.busch@intel.com (Keith Busch)
Date: Mon, 29 Jul 2013 14:37:32 -0600
Subject: [PATCHv3] NVMe: Async event requests
Message-ID: <1375130252-28795-1-git-send-email-keith.busch@intel.com>

This submits NVMe asynchronous event requests up to the controller maximum
or the number of possible different event types (eight), whichever is
lower. Events successfully returned by the controller are queued on
a fifo that is drained as user programs read them from the character
device.

Reading events may block the user program if none are available, or the
user may poll until an event is returned. Concurrent readers are allowed,
but only one reader will see a specific event as events are discarded
once read.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v2->v3:

Use locks to allow concurrent event reading/writing.

A reader may request multiple events with a single read. A successful
read will always return at least one event, but not necessarilly as many
events as the buffer has available.

Fixed an unchecked "__must_check" warning.

Mask off reserved and "more" bits from the status when checking if the
event was successful. The status to determine if the command failed is
the lower 11 bits of the completion entry's status field, so added a
mask value to the status enum.

On the wait queue head name 'event_empty', I've left it unchanged in this
patch. I'm not thrilled with the name either, but I believe it follows
the same semantics inferred by the only other wait_queue_head_t in this
driver, 'sq_full'.

 drivers/block/nvme-core.c |   99 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/nvme.h      |    5 ++
 include/uapi/linux/nvme.h |    9 ++++
 3 files changed, 112 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7439499..990633a 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -37,6 +37,7 @@
 #include <linux/pci.h>
 #include <linux/poison.h>
 #include <linux/ptrace.h>
+#include <linux/poll.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -166,6 +167,7 @@ static int alloc_cmdid_killable(struct nvme_queue *nvmeq, void *ctx,
 #define CMD_CTX_COMPLETED	(0x310 + CMD_CTX_BASE)
 #define CMD_CTX_INVALID		(0x314 + CMD_CTX_BASE)
 #define CMD_CTX_FLUSH		(0x318 + CMD_CTX_BASE)
+#define CMD_CTX_ASYNC		(0x31C + CMD_CTX_BASE)
 
 static void special_completion(struct nvme_dev *dev, void *ctx,
 						struct nvme_completion *cqe)
@@ -236,6 +238,29 @@ void put_nvmeq(struct nvme_queue *nvmeq)
 	put_cpu();
 }
 
+static void nvme_async_completion(struct nvme_dev *dev, void *ctx,
+						struct nvme_completion *cqe)
+{
+	u32 result = le32_to_cpup(&cqe->result);
+	u16 status = le16_to_cpup(&cqe->status) >> 1;
+
+	if ((status & NVME_SC_MASK) == NVME_SC_SUCCESS) {
+		struct nvme_async_completion event;
+
+		while (kfifo_is_full(&dev->event_fifo) &&
+					kfifo_out_spinlocked(&dev->event_fifo,
+							&event, sizeof(event),
+							&dev->event_lock));
+		memset(&event, 0, sizeof(event));
+		event.status = status << 1;
+		event.result = result;
+		kfifo_in_spinlocked(&dev->event_fifo, &event, sizeof(event),
+							&dev->event_lock);
+		wake_up(&dev->event_empty);
+		++dev->event_limit;
+	}
+}
+
 /**
  * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
  * @nvmeq: The queue to use
@@ -1011,7 +1036,8 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 
 		if (timeout && !time_after(now, info[cmdid].timeout))
 			continue;
-		if (info[cmdid].ctx == CMD_CTX_CANCELLED)
+		if (info[cmdid].ctx == CMD_CTX_CANCELLED ||
+					info[cmdid].ctx == CMD_CTX_ASYNC)
 			continue;
 		dev_warn(nvmeq->q_dmadev, "Cancelling I/O %d\n", cmdid);
 		ctx = cancel_cmdid(nvmeq, cmdid, &fn);
@@ -1508,6 +1534,22 @@ static const struct block_device_operations nvme_fops = {
 	.compat_ioctl	= nvme_ioctl,
 };
 
+static void nvme_submit_async_req(struct nvme_dev *dev)
+{
+	int cmdid;
+	struct nvme_command c;
+	struct nvme_queue *nvmeq = dev->queues[0];
+
+	cmdid = alloc_cmdid(nvmeq, CMD_CTX_ASYNC, nvme_async_completion, 0);
+	if (cmdid < 0)
+		return;
+
+	memset(&c, 0, sizeof(c));
+	c.common.opcode = nvme_admin_async_event;
+	c.common.command_id = cmdid;
+	nvme_submit_cmd(dev->queues[0], &c);
+}
+
 static void nvme_resubmit_bios(struct nvme_queue *nvmeq)
 {
 	while (bio_list_peek(&nvmeq->sq_cong)) {
@@ -1546,6 +1588,8 @@ static int nvme_kthread(void *data)
 				nvme_resubmit_bios(nvmeq);
 				spin_unlock_irq(&nvmeq->q_lock);
 			}
+			for (; dev->event_limit > 0; dev->event_limit--)
+				nvme_submit_async_req(dev);
 		}
 		spin_unlock(&dev_list_lock);
 		schedule_timeout(round_jiffies_relative(HZ));
@@ -1794,9 +1838,17 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		goto out;
 	}
 
+	init_waitqueue_head(&dev->event_empty);
+	res = kfifo_alloc(&dev->event_fifo,
+			16 * sizeof(struct nvme_async_completion), GFP_KERNEL);
+	if (res)
+		goto out;
+	spin_lock_init(&dev->event_lock);
+
 	ctrl = mem;
 	nn = le32_to_cpup(&ctrl->nn);
 	dev->oncs = le16_to_cpup(&ctrl->oncs);
+	dev->event_limit = min(ctrl->aerl + 1, 8);
 	memcpy(dev->serial, ctrl->sn, sizeof(ctrl->sn));
 	memcpy(dev->model, ctrl->mn, sizeof(ctrl->mn));
 	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
@@ -1908,6 +1960,7 @@ static void nvme_release_instance(struct nvme_dev *dev)
 static void nvme_free_dev(struct kref *kref)
 {
 	struct nvme_dev *dev = container_of(kref, struct nvme_dev, kref);
+	kfifo_free(&dev->event_fifo);
 	nvme_dev_remove(dev);
 	if (dev->pci_dev->msi_enabled)
 		pci_disable_msi(dev->pci_dev);
@@ -1950,10 +2003,54 @@ static long nvme_dev_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 	}
 }
 
+ssize_t nvme_dev_read(struct file *f, char __user *buf, size_t count,
+								loff_t *off)
+{
+	struct nvme_dev *dev = f->private_data;
+	unsigned int c, copied = 0;
+	const size_t rec_len = sizeof(struct nvme_async_completion);
+	int ret;
+
+	if (count < rec_len)
+		return -EINVAL;
+	if (f->f_flags & O_NONBLOCK && kfifo_is_empty(&dev->event_fifo))
+		return -EINVAL;
+	if (wait_event_killable(dev->event_empty,
+					!kfifo_is_empty(&dev->event_fifo)))
+		return -EINTR;
+
+	spin_lock(&dev->event_lock);
+	do {
+		ret = kfifo_to_user(&dev->event_fifo, buf, rec_len, &c);
+		if (ret)
+			break;
+		buf += c;
+		count -= c;
+		copied += c;
+	} while (count >= rec_len && !kfifo_is_empty(&dev->event_fifo));
+	spin_unlock(&dev->event_lock);
+
+	return ret ? ret : copied;
+}
+
+unsigned int nvme_dev_poll(struct file *f, struct poll_table_struct *wait)
+{
+	struct nvme_dev *dev = f->private_data;
+	unsigned int mask = 0;
+
+	poll_wait(f, &dev->event_empty, wait);
+	if (!kfifo_is_empty(&dev->event_fifo))
+		mask = POLLIN | POLLRDNORM;
+
+	return mask;
+}
+
 static const struct file_operations nvme_dev_fops = {
 	.owner		= THIS_MODULE,
 	.open		= nvme_dev_open,
 	.release	= nvme_dev_release,
+	.read		= nvme_dev_read,
+	.poll		= nvme_dev_poll,
 	.unlocked_ioctl	= nvme_dev_ioctl,
 	.compat_ioctl	= nvme_dev_ioctl,
 };
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 3403c8f..13894e2 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -22,6 +22,7 @@
 #include <uapi/linux/nvme.h>
 #include <linux/pci.h>
 #include <linux/miscdevice.h>
+#include <linux/kfifo.h>
 #include <linux/kref.h>
 
 struct nvme_bar {
@@ -85,6 +86,9 @@ struct nvme_dev {
 	struct list_head namespaces;
 	struct kref kref;
 	struct miscdevice miscdev;
+	struct kfifo event_fifo;
+	spinlock_t event_lock;
+	wait_queue_head_t event_empty;
 	char name[12];
 	char serial[20];
 	char model[40];
@@ -92,6 +96,7 @@ struct nvme_dev {
 	u32 max_hw_sectors;
 	u32 stripe_size;
 	u16 oncs;
+	u16 event_limit;
 };
 
 /*
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index 989c04e..9a4756a 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -423,6 +423,9 @@ enum {
 	NVME_SC_REFTAG_CHECK		= 0x284,
 	NVME_SC_COMPARE_FAILED		= 0x285,
 	NVME_SC_ACCESS_DENIED		= 0x286,
+	NVME_SC_MASK			= 0x3ff,
+	NVME_SC_MORE			= 0x2000,
+	NVME_SC_DNR			= 0x4000,
 };
 
 struct nvme_completion {
@@ -474,4 +477,10 @@ struct nvme_admin_cmd {
 #define NVME_IOCTL_ADMIN_CMD	_IOWR('N', 0x41, struct nvme_admin_cmd)
 #define NVME_IOCTL_SUBMIT_IO	_IOW('N', 0x42, struct nvme_user_io)
 
+struct nvme_async_completion {
+	__u32 result;
+	__u16 rsvd[5];
+	__u16 status;
+};
+
 #endif /* _UAPI_LINUX_NVME_H */
-- 
1.7.0.4
