From: keith.busch@intel.com (Keith Busch)
Date: Mon,  5 May 2014 12:03:46 -0600
Subject: [RFC PATCH] NVMe: Runtime suspend
Message-ID: <1399313026-12512-1-git-send-email-keith.busch@intel.com>

This is might be an odd idea to try for a block device, but I'll throw
it out there anyway.

NVMe defines support for low power states outside the PCI power states. By
default, this patch has this ability disabled, but maybe some use cases
may wish to take advantage of this when power reduction is paramount
above IO latency.

I'm making a new "device" here because I don't want to use the
pci_dev->dev for runtime pm. That will cause the device to go to D3,
and I don't think we want that.

This patch makes it possible to set up runtime power management to
transition to the lower power states the device supports, and allowing
the user to set the desired lower power level and auto suspend delay.
Some 1.1 compliant devices may support power states autonomously which can
be configured with the admin passthrough IOCTL, but other devices don't
have this feature, or may wish to have the driver control it instead.

One potential issue I already spotted, and the spec doesn't really make
this clear: I have runtime resume occur asynchronously when a new command
is allocated while suspended. The spec defines a "non-operational" power
state. Is the driver allowed to post a command to an IO queue while in
a non-op state and the command will be completed after the driver sets
the power state to operational, or does it need to be operational prior
to posting an IO command?
---
Usage Example:

 # Check the current runtime status

 root at keith:/sys/bus/pci/drivers/nvme/<D:B:D.f># cat nvme0/power/runtime_status
 active

 # Set the device to use power state "1" when idle

 root at keith:/sys/bus/pci/drivers/nvme/<D:B:D.f># echo 1 > nvme0/runtime_power_state

 # Set a 5 second autosuspend delay

 root at keith:/sys/bus/pci/drivers/nvme/<D:B:D.f># echo 5000 > nvme0/power/autosuspend_delay_ms

 # Check the current status after not using the device for 5 seconds

 root at keith:/sys/bus/pci/drivers/nvme/<D:B:D.f># cat nvme0/power/runtime_status
 suspended

 # Run an IO and verify device goes back to active

 root at keith:/sys/bus/pci/drivers/nvme/<D:B:D.f># dd if=/dev/nvme0n1 of=/dev/null bs=4k count=1 iflag=direct && \
 > cat nvme0/power/runtime_status
 1+0 records in
 1+0 records out
 4096 bytes (4.1 kB) copied, 0.000136335 s, 30.0 MB/s
 active



 drivers/block/nvme-core.c |   88 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h      |    4 +++
 2 files changed, 92 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index cd8a8bc7..0163809 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -34,6 +34,7 @@
 #include <linux/moduleparam.h>
 #include <linux/pci.h>
 #include <linux/percpu.h>
+#include <linux/pm_runtime.h>
 #include <linux/poison.h>
 #include <linux/ptrace.h>
 #include <linux/sched.h>
@@ -180,6 +181,10 @@ static int alloc_cmdid(struct nvme_queue *nvmeq, void *ctx,
 	info[cmdid].ctx = ctx;
 	info[cmdid].timeout = jiffies + timeout;
 	info[cmdid].aborted = 0;
+	pm_runtime_mark_last_busy(&nvmeq->dev->dev);
+	atomic_inc(&nvmeq->dev->nr_pending);
+	if (pm_runtime_suspended(&nvmeq->dev->dev))
+		pm_request_resume(&nvmeq->dev->dev);
 	return cmdid;
 }
 
@@ -254,6 +259,8 @@ static void *free_cmdid(struct nvme_queue *nvmeq, int cmdid,
 	info[cmdid].ctx = CMD_CTX_COMPLETED;
 	clear_bit(cmdid, nvmeq->cmdid_data);
 	wake_up(&nvmeq->sq_full);
+	pm_runtime_mark_last_busy(&nvmeq->dev->dev);
+	atomic_dec(&nvmeq->dev->nr_pending);
 	return ctx;
 }
 
@@ -2208,6 +2215,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	dev->oncs = le16_to_cpup(&ctrl->oncs);
 	dev->abort_limit = ctrl->acl + 1;
 	dev->vwc = ctrl->vwc;
+	dev->npss = ctrl->npss;
 	memcpy(dev->serial, ctrl->sn, sizeof(ctrl->sn));
 	memcpy(dev->model, ctrl->mn, sizeof(ctrl->mn));
 	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
@@ -2715,6 +2723,67 @@ static void nvme_reset_workfn(struct work_struct *work)
 	dev->reset_workfn(work);
 }
 
+#ifdef CONFIG_PM_RUNTIME
+static int nvme_runtime_suspend(struct device *dev)
+{
+	struct nvme_dev *ndev = container_of(dev, struct nvme_dev, dev);
+	if (atomic_read(&ndev->nr_pending))
+		return -EBUSY;
+	if (ndev->low_power)
+		nvme_set_features(ndev, NVME_FEAT_POWER_MGMT, ndev->low_power,
+								0, NULL);
+	return 0;
+}
+
+static int nvme_runtime_resume(struct device *dev)
+{
+	struct nvme_dev *ndev = container_of(dev, struct nvme_dev, dev);
+	if (ndev->low_power)
+		nvme_set_features(ndev, NVME_FEAT_POWER_MGMT, 0, 0, NULL);
+	return 0;
+}
+
+static ssize_t set_runtime_power_state(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_dev *ndev = container_of(dev, struct nvme_dev, dev);
+	u8 low_power;
+
+	if (kstrtou8(buf, 10, &low_power))
+		return count;
+	if (low_power <= ndev->npss) {
+		if (ndev->low_power && !low_power) {
+			pm_runtime_dont_use_autosuspend(dev);
+			pm_runtime_disable(dev);
+		} else if (!ndev->low_power && low_power) {
+			pm_runtime_use_autosuspend(dev);
+			pm_runtime_enable(dev);
+		}
+		ndev->low_power = low_power;
+	} else
+		return -EINVAL;
+	return count;
+}
+
+static ssize_t show_runtime_power_state(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct nvme_dev *ndev = container_of(dev, struct nvme_dev, dev);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", ndev->low_power);
+}
+static DEVICE_ATTR(runtime_power_state, S_IRUGO | S_IWUSR,
+		show_runtime_power_state, set_runtime_power_state);
+#endif
+
+const struct dev_pm_ops nvme_dev_rpm_ops = {
+	SET_PM_RUNTIME_PM_OPS(nvme_runtime_suspend, nvme_runtime_resume, NULL)
+};
+
+static struct device_driver nvme_dev_driver = {
+	.name = "nvme",
+	.pm = &nvme_dev_rpm_ops,
+};
+
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int result = -ENOMEM;
@@ -2743,6 +2812,23 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	result = nvme_set_instance(dev);
 	if (result)
 		goto free;
+	
+	device_initialize(&dev->dev);
+	dev->dev.parent = &pdev->dev;
+	dev->dev.driver = &nvme_dev_driver;
+	dev_set_name(&dev->dev, "nvme%d", dev->instance);
+	if (device_add(&dev->dev))
+		goto free;
+	get_device(&dev->dev);
+
+	pm_runtime_set_autosuspend_delay(&dev->dev, -1);
+	pm_runtime_allow(&dev->dev);
+	pm_runtime_set_active(&dev->dev);
+
+	device_enable_async_suspend(&dev->dev);
+#ifdef CONFIG_PM_RUNTIME
+	device_create_file(&dev->dev, &dev_attr_runtime_power_state);
+#endif
 
 	result = nvme_setup_prp_pools(dev);
 	if (result)
@@ -2814,6 +2900,8 @@ static void nvme_remove(struct pci_dev *pdev)
 	rcu_barrier();
 	nvme_release_instance(dev);
 	nvme_release_prp_pools(dev);
+	put_device(&dev->dev);
+	device_del(&dev->dev);
 	kref_put(&dev->kref, nvme_free_dev);
 }
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 1813cfd..a219016 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -69,6 +69,7 @@ extern unsigned char io_timeout;
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
  */
 struct nvme_dev {
+	struct device dev;
 	struct list_head node;
 	struct nvme_queue __rcu **queues;
 	unsigned short __percpu *io_queue;
@@ -95,12 +96,15 @@ struct nvme_dev {
 	char serial[20];
 	char model[40];
 	char firmware_rev[8];
+	atomic_t nr_pending;
 	u32 max_hw_sectors;
 	u32 stripe_size;
 	u16 oncs;
 	u16 abort_limit;
 	u8 vwc;
 	u8 initialized;
+	u8 low_power;
+	u8 npss;
 };
 
 /*
-- 
1.7.10.4
