From: mlin@kernel.org (Ming Lin)
Date: Tue,  9 Feb 2016 16:07:52 -0800
Subject: [PATCH v2 4/5] nvme: split dev_list_lock
In-Reply-To: <1455062873-18392-1-git-send-email-mlin@kernel.org>
References: <1455062873-18392-1-git-send-email-mlin@kernel.org>
Message-ID: <1455062873-18392-5-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@ssi.samsung.com>

Split dev_list_lock into one in the core and one in the PCI driver.

Reviewed-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
---
 drivers/nvme/host/core.c | 2 +-
 drivers/nvme/host/nvme.h | 2 --
 drivers/nvme/host/pci.c  | 1 +
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1bba21f..740615b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -54,7 +54,7 @@ static int nvme_char_major;
 module_param(nvme_char_major, int, 0);
 
 static LIST_HEAD(nvme_ctrl_list);
-DEFINE_SPINLOCK(dev_list_lock);
+static DEFINE_SPINLOCK(dev_list_lock);
 
 static struct class *nvme_class;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9f77386..63ba8a5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -266,8 +266,6 @@ int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
 			dma_addr_t dma_addr, u32 *result);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
 
-extern spinlock_t dev_list_lock;
-
 struct sg_io_hdr;
 
 int nvme_sg_io(struct nvme_ns *ns, struct sg_io_hdr __user *u_hdr);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e3552d1..f7266cc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -65,6 +65,7 @@ module_param(use_cmb_sqes, bool, 0644);
 MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
 
 static LIST_HEAD(dev_list);
+static DEFINE_SPINLOCK(dev_list_lock);
 static struct task_struct *nvme_thread;
 static struct workqueue_struct *nvme_workq;
 static wait_queue_head_t nvme_kthread_wait;
-- 
1.9.1
