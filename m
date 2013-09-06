From: keith.busch@intel.com (Keith Busch)
Date: Fri,  6 Sep 2013 15:13:15 -0600
Subject: [PATCH] NVMe: Provide ability to rescan namespaces
Message-ID: <1378501995-1967-1-git-send-email-keith.busch@intel.com>

There are a variety of reasons a namespace could change that would require
rescanning them to correctly use. A format may alter their block size,
or set features may toggle the hidden LBA range attribute, for example.

This patch adds a sysfs entry for each nvme controller that when written
initiates a rescan of the known namespaces for changes and add any new
ones that may be available for use so that the driver doesn't need to
be unloaded or using sysfs to remove and rescan the pci device. This
is done such that it may be reused if devices support the async event
mechanism to notify of namespace changes.

Much of this is just moving things around so we can reuse the same code
for initial namespace discovery and for rescanning.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
If a namespace needs to be removed, the request_queue queue_data is
NULLed so the driver won't accidently use the namespace after it
has been freed and any programs that have this open will get an error
instead. Question -- is -ENXIO appropriate here after the device has
been opened??

This builds on this large patch set:

http://merlin.infradead.org/pipermail/linux-nvme/2013-September/000390.html

though it doesn't have any dependencies on it if this patch looks okay
and that set above needs to be reworked for something.

The info below shows the need for such a mechanism. The user programs
came from the project at:

git.infradead.org/users/kbusch/nvme-user.git

# ./nvme_id_ns /dev/nvme0n1 
NVME Identify Namespace 1:

nsze    : 1048576
ncap    : 1048576
nuse    : 1048576
nsfeat  : 0
nlbaf   : 1
flbas   : 0
mc      : 0
dpc     : 0
dps     : 0
lbaf  0 : ms:0  ds:9  rp:0 (in use)
lbaf  1 : ms:0  ds:12 rp:0

# fdisk -l /dev/nvme0n1 
Disk /dev/nvme0n1: 536 MB, 536870912 bytes
255 heads, 63 sectors/track, 65 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000

# ./nvme_format_ns /dev/nvme0n1
LBA formats:
lbaf  0 : ms:0  ds:9  rp:0 (in use)
lbaf  1 : ms:0  ds:12 rp:0

Enter lba format index: 1
Entered 1, formatting namespace
Success formatting namespace:1

# fdisk -l /dev/nvme0n1
# ## This causes "Buffer I/O error on device nvme0n1"

# echo 1 > /sys/bus/pci/drivers/nvme/0000\:00\:04.0/rescan_namespaces
# fdisk -l /dev/nvme0n1 
Note: sector size is 4096 (not 512)

Disk /dev/nvme0n1: 536 MB, 536870912 bytes
255 heads, 63 sectors/track, 8 cylinders
Units = cylinders of 16065 * 4096 = 65802240 bytes
Sector size (logical/physical): 4096 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disk identifier: 0x00000000

 drivers/block/nvme-core.c |  209 +++++++++++++++++++++++++++++++++------------
 1 files changed, 154 insertions(+), 55 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 5ee9f61..f859723 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -798,10 +798,17 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
 static void nvme_make_request(struct request_queue *q, struct bio *bio)
 {
 	struct nvme_ns *ns = q->queuedata;
-	struct nvme_queue *nvmeq = get_nvmeq(ns->dev);
+	struct nvme_queue *nvmeq;
 	int result = -EBUSY;
 
-	if (!nvmeq) {
+	if (unlikely(!ns)) {
+		put_nvmeq(NULL);
+		bio_endio(bio, -ENXIO);
+		return;
+	}
+	
+	nvmeq = get_nvmeq(ns->dev);
+	if (unlikely(!nvmeq)) {
 		put_nvmeq(NULL);
 		bio_endio(bio, -EIO);
 		return;
@@ -1790,6 +1797,7 @@ static void nvme_ns_free(struct nvme_ns *ns)
 	int index = ns->disk->first_minor / NVME_MINORS;
 	put_disk(ns->disk);
 	nvme_put_ns_idx(index);
+	ns->queue->queuedata = NULL;
 	blk_cleanup_queue(ns->queue);
 	kfree(ns);
 }
@@ -1938,19 +1946,81 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	return result;
 }
 
+static void nvme_dev_remove(struct nvme_dev *dev)
+{
+	struct nvme_ns *ns, *next;
+
+	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
+		list_del(&ns->list);
+		del_gendisk(ns->disk);
+		nvme_ns_free(ns);
+	}
+}
+
+static struct nvme_ns *nvme_find_ns(struct nvme_dev *dev, unsigned nsid)
+{
+	struct nvme_ns *ns;
+	list_for_each_entry(ns, &dev->namespaces, list)
+		if (ns->ns_id == nsid)
+			return ns;
+	return NULL;
+}
+
+static int nvme_add_namespaces(struct nvme_dev *dev, unsigned nn,
+					dma_addr_t dma_addr, void *mem)
+{
+	unsigned int i;
+	int res = 0;
+	struct nvme_id_ns *id_ns;
+	struct nvme_ns *ns;
+
+	id_ns = mem;
+	for (i = 1; i <= nn; i++) {
+		if (nvme_find_ns(dev, i))
+			continue;
+
+		res = nvme_identify(dev, i, 0, dma_addr);
+		if (res) {
+			if (res < 0)
+				goto out;
+			continue;
+		}
+
+		if (id_ns->ncap == 0)
+			continue;
+
+		res = nvme_get_features(dev, NVME_FEAT_LBA_RANGE, i,
+							dma_addr + 4096, NULL);
+		if (res) {
+			if (res < 0)
+				goto out;
+			memset(mem + 4096, 0, 4096);
+		}
+
+		ns = nvme_alloc_ns(dev, i, mem, mem + 4096);
+		if (ns) {
+			list_add_tail(&ns->list, &dev->namespaces);
+			add_disk(ns->disk);
+		}
+	}
+	res = 0;
+ out:
+	if (res)
+		nvme_dev_remove(dev);
+	return res;
+}
+
 /*
- * Return: error value if an error occurred setting up the queues or calling
- * Identify Device.  0 if these succeeded, even if adding some of the
- * namespaces failed.  At the moment, these failures are silent.  TBD which
- * failures should be reported.
+ * Return: error value if an error occurred calling Identify Device or if no
+ * response is received for any commands.  0 if these succeeded, even if adding
+ * some of the namespaces failed.  At the moment, these failures are silent.
+ * TBD which failures should be reported.
  */
 static int nvme_dev_add(struct nvme_dev *dev)
 {
 	int res;
-	unsigned nn, i;
-	struct nvme_ns *ns, *next;
+	unsigned nn;
 	struct nvme_id_ctrl *ctrl;
-	struct nvme_id_ns *id_ns;
 	void *mem;
 	dma_addr_t dma_addr;
 	int shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
@@ -1979,40 +2049,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 			(dev->pci_dev->device == 0x0953) && ctrl->vs[3])
 		dev->stripe_size = 1 << (ctrl->vs[3] + shift);
 
-	id_ns = mem;
-	for (i = 1; i <= nn; i++) {
-		res = nvme_identify(dev, i, 0, dma_addr);
-		if (res) {
-			if (res < 0)
-				goto out_free;
-			continue;
-		}
-
-		if (id_ns->ncap == 0)
-			continue;
-
-		res = nvme_get_features(dev, NVME_FEAT_LBA_RANGE, i,
-							dma_addr + 4096, NULL);
-		if (res) {
-			if (res < 0)
-				goto out_free;
-			memset(mem + 4096, 0, 4096);
-		}
-
-		ns = nvme_alloc_ns(dev, i, mem, mem + 4096);
-		if (ns)
-			list_add_tail(&ns->list, &dev->namespaces);
-	}
-	list_for_each_entry(ns, &dev->namespaces, list)
-		add_disk(ns->disk);
-	res = 0;
-	goto out;
-
- out_free:
-	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
-		list_del(&ns->list);
-		nvme_ns_free(ns);
-	}
+	res = nvme_add_namespaces(dev, nn, dma_addr, mem);
  out:
 	dma_free_coherent(&dev->pci_dev->dev, 8192, mem, dma_addr);
 	return res;
@@ -2088,17 +2125,6 @@ static void nvme_dev_shutdown(struct nvme_dev *dev)
 	nvme_dev_unmap(dev);
 }
 
-static void nvme_dev_remove(struct nvme_dev *dev)
-{
-	struct nvme_ns *ns, *next;
-
-	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
-		list_del(&ns->list);
-		del_gendisk(ns->disk);
-		nvme_ns_free(ns);
-	}
-}
-
 static int nvme_setup_prp_pools(struct nvme_dev *dev)
 {
 	struct device *dmadev = &dev->pci_dev->dev;
@@ -2276,6 +2302,73 @@ static ssize_t nvme_reset(struct device *dev,
 }
 static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_reset);
 
+static int nvme_dev_rescan(struct nvme_dev *dev)
+{
+	struct nvme_ns *ns, *next;
+	struct nvme_id_ns *id;
+	struct nvme_lba_range_type *rt;
+	struct nvme_id_ctrl *ctrl;
+	void *mem;
+	dma_addr_t dma_addr;
+	unsigned int nn;
+	int res;
+
+	mem = dma_alloc_coherent(&dev->pci_dev->dev, 8192, &dma_addr,
+								GFP_KERNEL);
+	if (!mem)
+		return -ENOMEM;
+
+	id = mem;
+	rt = mem + 4096;
+	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
+		if (nvme_identify(dev, ns->ns_id, 0, dma_addr) ||
+							id->ncap == 0)
+			goto delete_ns;
+		if(nvme_get_features(dev, NVME_FEAT_LBA_RANGE, ns->ns_id,
+							dma_addr + 4096, NULL))
+			memset(mem + 4096, 0, 4096);
+		if (rt->attributes & NVME_LBART_ATTRIB_HIDE)
+			goto delete_ns;
+
+		ns->lba_shift = id->lbaf[id->flbas & 0xf].ds;
+		blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
+		set_capacity(ns->disk, le64_to_cpup(&id->nsze) <<
+							(ns->lba_shift - 9));
+		if (dev->oncs & NVME_CTRL_ONCS_DSM)
+			nvme_config_discard(ns);
+		continue;
+
+ delete_ns:
+		list_del(&ns->list);
+		del_gendisk(ns->disk);
+		nvme_ns_free(ns);
+	}
+
+	ctrl = mem;
+	res = nvme_identify(dev, 0, 1, dma_addr);
+	if (res) {
+		res = -EIO;
+		goto out;
+	}
+	nn = le32_to_cpup(&ctrl->nn);
+
+	res = nvme_add_namespaces(dev, nn, dma_addr, mem);
+ out:
+	dma_free_coherent(&dev->pci_dev->dev, 8192, mem, dma_addr);
+	return res;
+}
+
+static ssize_t nvme_rescan_namespaces(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct pci_dev  *pdev = container_of(dev, struct pci_dev, dev);
+	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+
+	nvme_dev_rescan(ndev);
+	return count;
+}
+static DEVICE_ATTR(rescan_namespaces, S_IWUSR, NULL, nvme_rescan_namespaces);
+
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int result = -ENOMEM;
@@ -2319,6 +2412,9 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	result = device_create_file(&pdev->dev, &dev_attr_reset_controller);
 	if (result)
 		goto remove;
+	result = device_create_file(&pdev->dev, &dev_attr_rescan_namespaces);
+	if (result)
+		goto del_sysfs;
 
 	scnprintf(dev->name, sizeof(dev->name), "nvme%d", dev->instance);
 	dev->miscdev.minor = MISC_DYNAMIC_MINOR;
@@ -2327,12 +2423,14 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev->miscdev.fops = &nvme_dev_fops;
 	result = misc_register(&dev->miscdev);
 	if (result)
-		goto del_sysfs;
+		goto del_rescan;
 
 	kref_init(&dev->kref);
 	dev->is_initialised = 1;
 	return 0;
 
+ del_rescan:
+	device_remove_file(&pdev->dev, &dev_attr_rescan_namespaces);
  del_sysfs:
 	device_remove_file(&pdev->dev, &dev_attr_reset_controller);
  remove:
@@ -2355,6 +2453,7 @@ static void nvme_remove(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 	device_remove_file(&pdev->dev, &dev_attr_reset_controller);
+	device_remove_file(&pdev->dev, &dev_attr_rescan_namespaces);
 	misc_deregister(&dev->miscdev);
 	kref_put(&dev->kref, nvme_free_dev);
 }
-- 
1.7.0.4
