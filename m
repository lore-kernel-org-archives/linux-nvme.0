From: keith.busch@intel.com (Keith Busch)
Date: Fri, 19 Jul 2013 12:13:35 -0600
Subject: [PATCHv2] NVMe: Async event request
Message-ID: <1374257615-19201-1-git-send-email-keith.busch@intel.com>

Submits NVMe asynchronous event requests, one event up to the controller
maximum or number of possible different event types (8), whichever is
smaller. Events successfully returned by the controller are queued on
a fifo that is emptied as a user program reads them from the character
device. Reading events may block the user program if none are available
or the user may poll completions.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v1->v2:

Drops older events from the queue if it is full as new events come in.

Limit the maximum number of event requests to have outstanding at the same
type to 8. We don't necessarilly want to use the maximum the controller
is capable of as this may exceed the number of admin submission queue
entries and 8 is the maximum number of possible events that could occur
without a reading log pages to clear events of that type anyway.

Don't bother cancelling async event requests on controller shutdown.

Rearranged code and renamed fields for clarity.

Added 'poll'.

The data returned from reading is 16 byte descriptor instead of only the
'result'.


Here's a simple example test program: 

#include <fcntl.h>
#include <stdio.h>
#include <poll.h>
#include <linux/nvme.h>

int main(int argc, char **argv)
{
	static const char *perrstr;
	struct nvme_async_completion event;
	struct pollfd poll_fd;
	int err;

	if (argc < 2) {
		fprintf(stderr, "Usage: %s </dev/nvme#>\n", argv[0]);
		return 1;
	}

	poll_fd.events = POLLIN;
	poll_fd.fd = open(argv[1], O_RDONLY);
	if (poll_fd.fd < 0)
		goto perror;

	perrstr = "poll";
	err = poll(&poll_fd, 1, -1);
	if (err < 0)
		goto perror;

	perrstr = "read";
	err = read(poll_fd.fd, &event, sizeof(event));
	if (err < 0)
		goto perror;

	printf("async event result:%x\n", event.result);
	close(poll_fd.fd);

	return 0;
 perror:
	perror(perrstr);
	return 1;
}

 drivers/block/nvme-core.c |   87 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/nvme.h      |    4 ++
 include/uapi/linux/nvme.h |    6 +++
 3 files changed, 96 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7439499..0cc9344 100644
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
@@ -236,6 +238,27 @@ void put_nvmeq(struct nvme_queue *nvmeq)
 	put_cpu();
 }
 
+static void nvme_async_completion(struct nvme_dev *dev, void *ctx,
+						struct nvme_completion *cqe)
+{
+	u32 result = le32_to_cpup(&cqe->result);
+	u16 status = le16_to_cpup(&cqe->status) >> 1;
+
+	if (status == NVME_SC_SUCCESS) {
+		struct nvme_async_completion event;
+
+		if (kfifo_is_full(&dev->event_fifo))
+			kfifo_out(&dev->event_fifo, &event, sizeof(event));
+
+		memset(&event, 0, sizeof(event));
+		event.status = status;
+		event.result = result;
+		kfifo_in(&dev->event_fifo, &event, sizeof(event));
+		wake_up(&dev->event_empty);
+		++dev->event_limit;
+	}
+}
+
 /**
  * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
  * @nvmeq: The queue to use
@@ -1011,7 +1034,8 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 
 		if (timeout && !time_after(now, info[cmdid].timeout))
 			continue;
-		if (info[cmdid].ctx == CMD_CTX_CANCELLED)
+		if (info[cmdid].ctx == CMD_CTX_CANCELLED ||
+					info[cmdid].ctx == CMD_CTX_ASYNC)
 			continue;
 		dev_warn(nvmeq->q_dmadev, "Cancelling I/O %d\n", cmdid);
 		ctx = cancel_cmdid(nvmeq, cmdid, &fn);
@@ -1508,6 +1532,22 @@ static const struct block_device_operations nvme_fops = {
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
@@ -1546,6 +1586,8 @@ static int nvme_kthread(void *data)
 				nvme_resubmit_bios(nvmeq);
 				spin_unlock_irq(&nvmeq->q_lock);
 			}
+			for (; dev->event_limit > 0; dev->event_limit--)
+				nvme_submit_async_req(dev);
 		}
 		spin_unlock(&dev_list_lock);
 		schedule_timeout(round_jiffies_relative(HZ));
@@ -1794,9 +1836,16 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		goto out;
 	}
 
+	init_waitqueue_head(&dev->event_empty);
+	res = kfifo_alloc(&dev->event_fifo,
+			16 * sizeof(struct nvme_async_completion), GFP_KERNEL);
+	if (res)
+		goto out;
+
 	ctrl = mem;
 	nn = le32_to_cpup(&ctrl->nn);
 	dev->oncs = le16_to_cpup(&ctrl->oncs);
+	dev->event_limit = min(ctrl->aerl + 1, 8);
 	memcpy(dev->serial, ctrl->sn, sizeof(ctrl->sn));
 	memcpy(dev->model, ctrl->mn, sizeof(ctrl->mn));
 	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
@@ -1908,6 +1957,7 @@ static void nvme_release_instance(struct nvme_dev *dev)
 static void nvme_free_dev(struct kref *kref)
 {
 	struct nvme_dev *dev = container_of(kref, struct nvme_dev, kref);
+	kfifo_free(&dev->event_fifo);
 	nvme_dev_remove(dev);
 	if (dev->pci_dev->msi_enabled)
 		pci_disable_msi(dev->pci_dev);
@@ -1950,10 +2000,45 @@ static long nvme_dev_ioctl(struct file *f, unsigned int cmd, unsigned long arg)
 	}
 }
 
+ssize_t nvme_dev_read(struct file *f, char __user *buf, size_t count,
+								loff_t *off)
+{
+	struct nvme_dev *dev = f->private_data;
+	unsigned int copied;
+	int ret;
+
+	if (count < sizeof(struct nvme_async_completion))
+		return -EINVAL;
+	if (f->f_flags & O_NONBLOCK && kfifo_is_empty(&dev->event_fifo))
+		return -EINVAL;
+	if (wait_event_killable(dev->event_empty,
+					!kfifo_is_empty(&dev->event_fifo)))
+		return -EINTR;
+
+	ret = kfifo_to_user(&dev->event_fifo, buf,
+					sizeof(struct nvme_async_completion),
+					&copied);
+	return ret ? ret : copied;
+}
+
+unsigned int nvme_dev_poll(struct file *f, struct poll_table_struct *wait)
+{
+	unsigned int mask = 0;
+	struct nvme_dev *dev = f->private_data;
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
index 3403c8f..e160c50 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -22,6 +22,7 @@
 #include <uapi/linux/nvme.h>
 #include <linux/pci.h>
 #include <linux/miscdevice.h>
+#include <linux/kfifo.h>
 #include <linux/kref.h>
 
 struct nvme_bar {
@@ -85,6 +86,8 @@ struct nvme_dev {
 	struct list_head namespaces;
 	struct kref kref;
 	struct miscdevice miscdev;
+	struct kfifo event_fifo;
+	wait_queue_head_t event_empty;
 	char name[12];
 	char serial[20];
 	char model[40];
@@ -92,6 +95,7 @@ struct nvme_dev {
 	u32 max_hw_sectors;
 	u32 stripe_size;
 	u16 oncs;
+	u16 event_limit;
 };
 
 /*
diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index 989c04e..3c3baad 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -474,4 +474,10 @@ struct nvme_admin_cmd {
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
