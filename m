From: a.dawn@samsung.com (Arnav Dawn)
Date: Fri, 10 Jun 2016 19:09:24 +0530
Subject: [PATCH] NVMe:Support for Host Memory Buffer(HMB)
Message-ID: <1465565964-7167-1-git-send-email-a.dawn@samsung.com>

 This patch adds HMB support to the driver.
 The patch adds two Module Parameters for controlling HMB
        1. set_max_hmb: This allows user to limit the
 max size (in MBs) of the buffer,HM buffer won't be created for
 any device with minimum buffer requirement more than this,
 setting this to '0' will disable HMB support, default is 512MB.
        2. set_hmb_chunk: This sets the size (in KBs) of each chunk 
 of buffer created for HMB.Setting this to '0' will disable HMB
 support. default is 1024KB.

 The function 'nvme_setup_hmb' allocates page size alligned buffer 
 in chunks of chunk_size each (controlled by set_hmb_chunk module param)
 and creates a list. This list is then passed as set feature parameter
 to the device.

 The function 'nvme_free_hmb' deallocates all the buffers created for HMB.
 The buffers are only deallocated when the device goes to a shut down 
 , other wise the buffers(and hence the data written by the device on 
 these buffers) are retained.

Signed-off-by: Arnav Dawn <a.dawn at samsung.com>
---
 drivers/nvme/host/core.c | 235 ++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  41 +++++++++
 drivers/nvme/host/pci.c  |  10 ++
 include/linux/nvme.h     |  11 ++-
 4 files changed, 294 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 684062a..0d8046d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -43,6 +43,14 @@ module_param_named(io_timeout, nvme_io_timeout, byte, 0644);
 MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
 EXPORT_SYMBOL_GPL(nvme_io_timeout);
 
+static unsigned int  set_max_hmb = 1<<9;
+module_param(set_max_hmb, uint, 0444);
+MODULE_PARM_DESC(set_max_hmb, "set max size of Host Memory Buffer supported by host in units of MB");
+
+static unsigned int  set_hmb_chunk = 1<<10;
+module_param(set_hmb_chunk, uint, 0444);
+MODULE_PARM_DESC(set_hmb_chunk, "set chunk size of Host Memory Buffer in discriptor list in KB");
+
 unsigned char shutdown_timeout = 5;
 module_param(shutdown_timeout, byte, 0644);
 MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
@@ -1153,7 +1161,8 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 			ctrl->max_hw_sectors = max_hw_sectors;
 		}
 	}
-
+	ctrl->hmb.host_mem_pre = le32_to_cpu(id->hmpre) << 2;
+	ctrl->hmb.host_mem_min = le32_to_cpu(id->hmmin) << 2;
 	nvme_set_queue_limits(ctrl, ctrl->admin_q);
 
 	kfree(id);
@@ -1161,6 +1170,230 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_init_identify);
 
+static int nvme_set_hmb_feature(struct nvme_ctrl *dev, u32 hmb_enable, u64 hmb_size)
+{
+	struct nvme_command c;
+	struct nvme_completion cqe;
+	u64 offset;
+
+	memset(&c, 0, sizeof(c));
+	offset = dev->hmb.hmb_desc_info_list.dma_addr & 0xf;
+	if (offset)
+		offset = (0x10 - offset);
+
+	c.features.opcode = nvme_admin_set_features;
+	c.features.fid = cpu_to_le32(NVME_FEAT_HMB);
+	c.features.dword11 = cpu_to_le32(hmb_enable | (dev->hmb.flags & NVME_HMB_SET_MR));
+	c.features.dword12 = cpu_to_le32(hmb_size);
+	c.features.dword13 = cpu_to_le32((dev->hmb.hmb_desc_info_list.dma_addr + offset) & 0xfffffff0);
+	c.features.dword14 = cpu_to_le32(((dev->hmb.hmb_desc_info_list.dma_addr + offset)  >> 32) & 0xffffffff);
+	c.features.dword15 = cpu_to_le32(dev->hmb.hmb_desc_info_list_count);
+
+	return __nvme_submit_sync_cmd(dev->admin_q, &c, &cqe, NULL, 0, 0);
+}
+
+int nvme_get_hmbcap(struct nvme_ctrl *dev)
+{
+	u64 max_hmb = set_max_hmb << 10;
+
+	if (!set_max_hmb || !set_hmb_chunk)
+		return -EINVAL;
+
+	if (!dev->hmb.host_mem_pre)
+		return -EINVAL;
+
+	/* Is Min Host buffer size too high */
+	if (dev->hmb.host_mem_min > max_hmb) {
+		dev->hmb.host_mem_pre = 0;
+		dev->hmb.host_mem_min = 0;
+		return -EINVAL;
+	}
+	/* Is Preffered  Host buffer size too high? set it to set_max_hmb */
+	if (dev->hmb.host_mem_pre > max_hmb)
+		dev->hmb.host_mem_pre = max_hmb;
+
+	return 0;
+}
+
+int nvme_setup_hmb(struct nvme_ctrl *dev)
+{
+	struct nvme_features feat;
+	struct hmb_descriptor *desc_list;
+	struct hmb_descriptor_info *desc_info;
+	u64 hmb_chunk_size, hmb_allocated, hmb_pre, max_desc_nent;
+	u32 page_size, page_shift = 0, nents = 0, offset;
+	int status;
+
+	page_size = dev->page_size;
+	while (page_size >>= 1)
+		page_shift++;
+
+	status = nvme_get_hmbcap(dev);
+	if (status) {
+		if (dev->hmb.flags & NVME_HMB_SET_MR) {
+			dev->hmb.flags &= ~(NVME_HMB_SET_MR);
+			nvme_free_hmb(dev);
+		}
+		return status;
+	}
+
+	/* user set hmb chunk size in KB */
+	hmb_chunk_size = set_hmb_chunk << 10;
+
+	/* check if MR flag is set */
+	if (!(dev->hmb.flags & NVME_HMB_SET_MR)) {
+
+		hmb_pre = dev->hmb.host_mem_pre << 10;
+		max_desc_nent = DIV_ROUND_UP(hmb_pre, hmb_chunk_size);
+		dev->hmb.hmb_desc_info_list.size =
+			(sizeof(struct hmb_descriptor)*max_desc_nent) + 0x10;
+		dev->hmb.hmb_desc_info_list.vaddr = dma_alloc_coherent(dev->dev,
+			dev->hmb.hmb_desc_info_list.size,
+			&dev->hmb.hmb_desc_info_list.dma_addr, GFP_KERNEL);
+
+		if (!dev->hmb.hmb_desc_info_list.vaddr)
+			return -ENOMEM;
+
+		/* check 16 byte allignment */
+		offset = dev->hmb.hmb_desc_info_list.dma_addr & 0xf;
+		if (offset)
+			offset = (0x10 - offset);
+
+		desc_list = dev->hmb.hmb_desc_info_list.vaddr + offset;
+
+		desc_info = (struct hmb_descriptor_info *)kmalloc(
+				sizeof(struct hmb_descriptor_info)*max_desc_nent,
+				GFP_ATOMIC);
+		if (!desc_info) {
+			status = -ENOMEM;
+			goto release_hmb_list;
+		}
+
+		hmb_allocated = 0;
+		while (hmb_allocated < hmb_pre) {
+			/* adjust chunk size if it crosses boundary */
+			if (hmb_chunk_size > (hmb_pre - hmb_allocated))
+				hmb_chunk_size = (hmb_pre - hmb_allocated);
+			/* allocate 1 page extra for page alligned */
+			desc_info[nents].size = hmb_chunk_size + dev->page_size;
+			desc_info[nents].vaddr = dma_alloc_coherent(dev->dev,
+						desc_info[nents].size,
+						&desc_info[nents].dma_addr,
+						GFP_KERNEL);
+			if (!desc_info[nents].vaddr) {
+				status = -ENOMEM;
+				break;
+			}
+
+			offset = desc_info[nents].dma_addr & (dev->page_size - 1);
+			if (offset)
+				offset = dev->page_size - offset;
+
+			desc_list[nents].badd = cpu_to_le64(desc_info[nents].dma_addr + offset);
+			desc_list[nents].bsize = cpu_to_le32(hmb_chunk_size >> page_shift);
+
+			hmb_allocated += hmb_chunk_size;
+			nents++;
+		}
+
+		dev->hmb.hmb_desc_info = desc_info;
+		dev->hmb.hmb_desc_info_list_count = nents;
+		if (hmb_allocated < (dev->hmb.host_mem_min << 10))
+			goto release_hmb;
+	} else {
+
+		/* HMB Memory retain is set in this cycle */
+		hmb_allocated = 0;
+		for (nents = 0; nents < dev->hmb.hmb_desc_info_list_count; nents++)
+			hmb_allocated += (dev->hmb.hmb_desc_info[nents].size - dev->page_size);
+
+		if (hmb_allocated < (dev->hmb.host_mem_min << 10)
+			|| hmb_allocated > (dev->hmb.host_mem_pre << 10)) {
+			/*HMB retained memory size out off range Set up new buffer*/
+			dev->hmb.flags &= ~(NVME_HMB_SET_MR);
+			nvme_free_hmb(dev);
+			return nvme_setup_hmb(dev);
+		}
+
+	}
+
+	dev->hmb.flags &= ~(NVME_HMB_SET_MR);/* clear MR FLAG */
+	status = nvme_set_hmb_feature(dev, NVME_HMB_ENABLE, hmb_alloc >> page_shift);
+	if (status)
+		goto release_hmb;
+
+	dev->hmb.flags |= NVME_HMB_ENABLE;
+	return status;
+
+release_hmb:
+	for (nents = 0; nents < dev->hmb.hmb_desc_info_list_count ; nents++) {
+		dma_free_coherent(dev->dev, dev->hmb.hmb_desc_info[nents].size,
+			(void *)dev->hmb.hmb_desc_info[nents].vaddr,
+			dev->hmb.hmb_desc_info[nents].dma_addr);
+	}
+
+	kfree(dev->hmb.hmb_desc_info);
+
+release_hmb_list:
+	dma_free_coherent(dev->dev, dev->hmb.hmb_desc_info_list.size,
+				dev->hmb.hmb_desc_info_list.vaddr,
+				dev->hmb.hmb_desc_info_list.dma_addr);
+
+	return status;
+}
+EXPORT_SYMBOL_GPL(nvme_setup_hmb);
+
+void nvme_free_hmb(struct nvme_ctrl *dev)
+{
+	struct nvme_features feat;
+	u64 hmb_allocated, offset;
+	u32 nents, page_shift = 0, page_size = dev->page_size;
+	u32 csts = -1;
+
+	if (!dev->hmb.host_mem_pre || !(dev->hmb.flags & NVME_HMB_ENABLE)) {
+		/* HMB was not allocated */
+		dev->hmb.flags &= ~(NVME_HMB_SET_MR);
+		return;
+	}
+
+	if (dev->hmb.flags & NVME_HMB_SET_MR) {
+		/* Retaining HM Buffer */
+		return;
+	}
+
+	while (page_size >>= 1)
+		page_shift++;
+
+	dev->ops->reg_read32(dev, NVME_REG_CSTS, &csts);
+	/*
+	 * Check if device is ok before sending disable HMB feature command
+	 * if not clean buffers anyway
+	 */
+
+	if (!(csts & NVME_CSTS_CFS) && (csts & NVME_CSTS_RDY)) {
+
+		hmb_allocated = 0;
+		for (nents = 0; nents < dev->hmb.hmb_desc_info_list_count; nents++)
+			hmb_allocated += dev->hmb.hmb_desc_info[nents].size;
+
+		nvme_set_hmb_feature(dev, NVME_HMB_DISABLE, hmb_allocated >> page_shift);
+	}
+	/* Free allocated buffers*/
+	for (nents = 0; nents < dev->hmb.hmb_desc_info_list_count; nents++) {
+		dma_free_coherent(dev->dev, dev->hmb.hmb_desc_info[nents].size,
+			(void *) dev->hmb.hmb_desc_info[nents].vaddr,
+			dev->hmb.hmb_desc_info[nents].dma_addr);
+	}
+	/*Free buffer for list of HM buffers*/
+	dma_free_coherent(dev->dev, dev->hmb.hmb_desc_info_list.size,
+				(void *)dev->hmb.hmb_desc_info_list.vaddr,
+				dev->hmb.hmb_desc_info_list.dma_addr);
+
+	kfree((void *)dev->hmb.hmb_desc_info);
+	memset(&(dev->hmb), 0, sizeof(dev->hmb));
+}
+EXPORT_SYMBOL_GPL(nvme_free_hmb);
+
 static int nvme_dev_open(struct inode *inode, struct file *file)
 {
 	struct nvme_ctrl *ctrl;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 282421f..7ccd6d5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -75,6 +75,44 @@ enum nvme_ctrl_state {
 	NVME_CTRL_DEAD,
 };
 
+enum {
+	NVME_HMB_DISABLE = 0,
+	NVME_HMB_ENABLE	= 1,
+	NVME_HMB_SET_MR = 2,
+};
+
+struct hmb_descriptor {
+	__u64   badd;
+	__u32   bsize;
+	__u32   rsvd;
+
+};
+
+struct hmb_descriptor_info {
+	u64 dma_addr;
+	u64 size;
+	void *vaddr;
+};
+
+struct hmb_info {
+	/* Array of unalligned HMB Discriptor info */
+	struct hmb_descriptor_info *hmb_desc_info;
+	/* count of entries in the list */
+	u32 hmb_desc_info_list_count;
+
+	/* HMB descriptor Info list */
+	struct hmb_descriptor_info hmb_desc_info_list;
+
+	/* preferred HMB size set by device */
+	u64 host_mem_pre;
+
+	/* min HMB size set by device */
+	u64 host_mem_min;
+
+	/* HMB flags MR,ENABLE */
+	u8 flags;
+};
+
 struct nvme_ctrl {
 	enum nvme_ctrl_state state;
 	spinlock_t lock;
@@ -89,6 +127,7 @@ struct nvme_ctrl {
 	struct device *device;	/* char device */
 	struct list_head node;
 	struct ida ns_ida;
+	struct hmb_info  hmb;
 
 	char name[12];
 	char serial[20];
@@ -218,6 +257,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
 void nvme_put_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_identify(struct nvme_ctrl *ctrl);
+int nvme_setup_hmb(struct nvme_ctrl *ctrl);
+void nvme_free_hmb(struct nvme_ctrl *ctrl);
 
 void nvme_queue_scan(struct nvme_ctrl *ctrl);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 37aa250..919066b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1691,6 +1691,12 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	del_timer_sync(&dev->watchdog_timer);
 
 	mutex_lock(&dev->shutdown_lock);
+
+	if (!shutdown)
+		dev->ctrl.hmb.flags |= NVME_HMB_SET_MR;
+
+	nvme_free_hmb(&dev->ctrl);
+
 	if (pci_is_enabled(to_pci_dev(dev->dev))) {
 		nvme_stop_queues(&dev->ctrl);
 		csts = readl(dev->bar + NVME_REG_CSTS);
@@ -1793,6 +1799,10 @@ static void nvme_reset_work(struct work_struct *work)
 	if (result)
 		goto out;
 
+	result = nvme_setup_hmb(&dev->ctrl);
+	if (result)
+		dev->ctrl.hmb.flags &= ~NVME_HMB_ENABLE;
+
 	result = nvme_setup_io_queues(dev);
 	if (result)
 		goto out;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 7d51b29..c29f514 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -119,7 +119,10 @@ struct nvme_id_ctrl {
 	__u8			apsta;
 	__le16			wctemp;
 	__le16			cctemp;
-	__u8			rsvd270[242];
+	__u8			rsvd270[2];
+	__u32			hmpre;
+	__u32			hmmin;
+	__u8			rsvd280[232];
 	__u8			sqes;
 	__u8			cqes;
 	__u8			rsvd514[2];
@@ -408,6 +411,7 @@ enum {
 	NVME_FEAT_WRITE_ATOMIC	= 0x0a,
 	NVME_FEAT_ASYNC_EVENT	= 0x0b,
 	NVME_FEAT_AUTO_PST	= 0x0c,
+	NVME_FEAT_HMB           = 0x0d,
 	NVME_FEAT_SW_PROGRESS	= 0x80,
 	NVME_FEAT_HOST_ID	= 0x81,
 	NVME_FEAT_RESV_MASK	= 0x82,
@@ -443,7 +447,10 @@ struct nvme_features {
 	__le64			prp2;
 	__le32			fid;
 	__le32			dword11;
-	__u32			rsvd12[4];
+	__le32                  dword12;
+	__le32                  dword13;
+	__le32                  dword14;
+	__le32                  dword15;
 };
 
 struct nvme_create_cq {
-- 
1.9.3
