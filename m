From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Thu,  2 May 2019 17:59:20 +0900
Subject: [PATCH 3/4] nvme-pci: add device coredump support
In-Reply-To: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
References: <1556787561-5113-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <1556787561-5113-4-git-send-email-akinobu.mita@gmail.com>

This enables to capture snapshot of controller information via device
coredump machanism.

The nvme device coredump creates the following coredump files.

- regs: NVMe controller registers, including each I/O queue doorbell
        registers, in nvme-show-regs style text format.

- sq<qid>: I/O submission queue

- cq<qid>: I/O completion queue

Cc: Johannes Berg <johannes at sipsolutions.net>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
---
 drivers/nvme/host/Kconfig |   1 +
 drivers/nvme/host/pci.c   | 221 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 222 insertions(+)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 0f345e2..c3a06af 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -5,6 +5,7 @@ config BLK_DEV_NVME
 	tristate "NVM Express block device"
 	depends on PCI && BLOCK
 	select NVME_CORE
+	select WANT_DEV_COREDUMP
 	---help---
 	  The NVM Express driver is for solid state drives directly
 	  connected to the PCI or PCI Express bus.  If you know you
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a90cf5d..7f3077c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -9,6 +9,7 @@
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-mq-pci.h>
+#include <linux/devcoredump.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -2867,6 +2868,225 @@ static int nvme_resume(struct device *dev)
 
 static SIMPLE_DEV_PM_OPS(nvme_dev_pm_ops, nvme_suspend, nvme_resume);
 
+#ifdef CONFIG_DEV_COREDUMP
+
+struct nvme_reg {
+	u32 off;
+	const char *name;
+	int bits;
+};
+
+static const struct nvme_reg nvme_regs[] = {
+	{ NVME_REG_CAP,		"cap",		64 },
+	{ NVME_REG_VS,		"version",	32 },
+	{ NVME_REG_INTMS,	"intms",	32 },
+	{ NVME_REG_INTMC,	"intmc",	32 },
+	{ NVME_REG_CC,		"cc",		32 },
+	{ NVME_REG_CSTS,	"csts",		32 },
+	{ NVME_REG_NSSR,	"nssr",		32 },
+	{ NVME_REG_AQA,		"aqa",		32 },
+	{ NVME_REG_ASQ,		"asq",		64 },
+	{ NVME_REG_ACQ,		"acq",		64 },
+	{ NVME_REG_CMBLOC,	"cmbloc",	32 },
+	{ NVME_REG_CMBSZ,	"cmbsz",	32 },
+};
+
+static int nvme_coredump_regs_padding(int num_queues)
+{
+	char name[16];
+	int padding;
+	int i;
+
+	padding = sprintf(name, "sq%dtdbl", num_queues - 1);
+
+	for (i = 0; i < ARRAY_SIZE(nvme_regs); i++)
+		padding = max_t(int, padding, strlen(nvme_regs[i].name));
+
+	return padding;
+}
+
+static int nvme_coredump_regs_buf_size(int num_queues, int padding)
+{
+	int line_size = padding + strlen(" : ffffffffffffffff\n");
+	int buf_size;
+
+	/* Max print buffer size for controller registers */
+	buf_size = line_size * ARRAY_SIZE(nvme_regs);
+
+	/* Max print buffer size for SQyTDBL and CQxHDBL registers */
+	buf_size += line_size * num_queues * 2;
+
+	return buf_size;
+}
+
+static int nvme_coredump_regs_print(void *buf, int buf_size,
+				    struct nvme_ctrl *ctrl, int padding)
+{
+	struct nvme_dev *dev = to_nvme_dev(ctrl);
+	int len = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(nvme_regs); i++) {
+		const struct nvme_reg *reg = &nvme_regs[i];
+		u64 val;
+
+		if (reg->bits == 32)
+			val = readl(dev->bar + reg->off);
+		else
+			val = readq(dev->bar + reg->off);
+
+		len += snprintf(buf + len, buf_size - len, "%-*s : %llx\n",
+				padding, reg->name, val);
+	}
+
+	for (i = 0; i < ctrl->queue_count; i++) {
+		struct nvme_queue *nvmeq = &dev->queues[i];
+		char name[16];
+
+		sprintf(name, "sq%dtdbl", i);
+		len += snprintf(buf + len, buf_size - len, "%-*s : %x\n",
+				padding, name, readl(nvmeq->q_db));
+
+		sprintf(name, "cq%dhdbl", i);
+		len += snprintf(buf + len, buf_size - len, "%-*s : %x\n",
+				padding, name,
+				readl(nvmeq->q_db + dev->db_stride));
+	}
+
+	return len;
+}
+
+static ssize_t nvme_coredump_read(char *buffer, loff_t offset, size_t count,
+				  void *data, size_t datalen)
+{
+	return memory_read_from_buffer(buffer, count, &offset, data, datalen);
+}
+
+static void nvme_coredump_free(void *data)
+{
+	kvfree(data);
+}
+
+static int nvme_coredump_regs(struct dev_coredumpm_bulk_data *data,
+			      struct nvme_ctrl *ctrl)
+{
+	int padding = nvme_coredump_regs_padding(ctrl->queue_count);
+	int buf_size = nvme_coredump_regs_buf_size(ctrl->queue_count, padding);
+	void *buf;
+
+	buf = kvzalloc(buf_size, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	data->name = kstrdup("regs", GFP_KERNEL);
+	if (!data->name) {
+		kvfree(buf);
+		return -ENOMEM;
+	}
+
+	data->data = buf;
+	data->datalen = nvme_coredump_regs_print(buf, buf_size, ctrl, padding);
+	data->read = nvme_coredump_read;
+	data->free = nvme_coredump_free;
+
+	return 0;
+}
+
+static void *kvmemdup(const void *src, size_t len, gfp_t gfp)
+{
+	void *p;
+
+	p = kvmalloc(len, gfp);
+	if (p)
+		memcpy(p, src, len);
+
+	return p;
+}
+
+static int nvme_coredump_queues(struct dev_coredumpm_bulk_data *bulk_data,
+				struct nvme_ctrl *ctrl)
+{
+	int i;
+
+	for (i = 0; i < ctrl->queue_count; i++) {
+		struct dev_coredumpm_bulk_data *data = &bulk_data[2 * i];
+		struct nvme_queue *nvmeq = &to_nvme_dev(ctrl)->queues[i];
+
+		data[0].name = kasprintf(GFP_KERNEL, "sq%d", i);
+		data[0].data = kvmemdup(nvmeq->sq_cmds,
+					SQ_SIZE(nvmeq->q_depth), GFP_KERNEL);
+		data[0].datalen = SQ_SIZE(nvmeq->q_depth);
+		data[0].read = nvme_coredump_read;
+		data[0].free = nvme_coredump_free;
+
+		data[1].name = kasprintf(GFP_KERNEL, "cq%d", i);
+		data[1].data = kvmemdup((void *)nvmeq->cqes,
+					CQ_SIZE(nvmeq->q_depth), GFP_KERNEL);
+		data[1].datalen = CQ_SIZE(nvmeq->q_depth);
+		data[1].read = nvme_coredump_read;
+		data[1].free = nvme_coredump_free;
+
+		if (!data[0].name || !data[1].name ||
+		    !data[0].data || !data[1].data)
+			goto free;
+	}
+
+	return 0;
+free:
+	for (; i >= 0; i--) {
+		struct dev_coredumpm_bulk_data *data = &bulk_data[2 * i];
+
+		kfree(data[0].name);
+		kfree(data[1].name);
+		kvfree(data[0].data);
+		kvfree(data[1].data);
+	}
+
+	return -ENOMEM;
+}
+
+static void nvme_coredump(struct device *dev)
+{
+	struct nvme_dev *ndev = dev_get_drvdata(dev);
+	struct nvme_ctrl *ctrl = &ndev->ctrl;
+	struct dev_coredumpm_bulk_data *bulk_data;
+	int ret;
+	int i;
+
+	bulk_data = kcalloc(1 + 2 * ctrl->queue_count, sizeof(*bulk_data),
+			    GFP_KERNEL);
+	if (!bulk_data)
+		return;
+
+	ret = nvme_coredump_regs(&bulk_data[0], ctrl);
+	if (ret)
+		goto free_bulk_data;
+
+	ret = nvme_coredump_queues(&bulk_data[1], ctrl);
+	if (ret)
+		goto free_bulk_data;
+
+	dev_coredumpm_bulk(dev, THIS_MODULE, GFP_KERNEL, bulk_data,
+			   1 + 2 * ctrl->queue_count);
+
+free_bulk_data:
+	for (i = 0; i < 1 + 2 * ctrl->queue_count; i++) {
+		kfree(bulk_data[i].name);
+		if (ret)
+			kvfree(bulk_data[i].data);
+	}
+
+	kfree(bulk_data);
+}
+
+#else
+
+static void nvme_coredump(struct device *dev)
+{
+}
+
+#endif /* CONFIG_DEV_COREDUMP */
+
 static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 						pci_channel_state_t state)
 {
@@ -2972,6 +3192,7 @@ static struct pci_driver nvme_driver = {
 	.shutdown	= nvme_shutdown,
 	.driver		= {
 		.pm	= &nvme_dev_pm_ops,
+		.coredump = nvme_coredump,
 	},
 	.sriov_configure = pci_sriov_configure_simple,
 	.err_handler	= &nvme_err_handler,
-- 
2.7.4
