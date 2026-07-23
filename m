Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1951FC531CA
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2026 12:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Mime-Version:Message-Id:
	Content-Type:Content-Transfer-Encoding:Subject:From:Date:Cc:To:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gnsfWMNADzeM7WwQ9uTN6bET2q1Wp6izUzSumTR5qhM=; b=fp7sMmGHjVkK1/uBy4U31eXoiu
	2ZhBnDxJXg846PVpaSaxPcGt3AfC+L0T3DLMLNdT1ZOo97/1/7FEzhXCvs31GB0xC4z9IWC1s5u1t
	+SFq4pST7JWVTiK+G8+9eaNq08CFFYm5Ksanpuz7YxVqQWu7RV3ByBfT6EkXFQNiX4kGNaUf1pHtf
	B88DR9QRyC0UCmBhnDZ9WfyMv5Ie3lvRCulDx6K70sF0TdQKaPVxV3J9URowemYq5Gw6SDz20X4TD
	aJVnt5n+ieCkbnIdn7U8t/iVr/GoXu6kqHraTJmR2RFoHwnL+D8HmNJ08Vfn7eaAB0XKP/sdVm7/r
	4twwLO7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmsCL-0000000ECkB-0Etx;
	Thu, 23 Jul 2026 12:06:45 +0000
Received: from va-1-112.ptr.blmpb.com ([209.127.230.112])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmsCG-0000000ECjn-0T1K
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jul 2026 12:06:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1784808389; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=gnsfWMNADzeM7WwQ9uTN6bET2q1Wp6izUzSumTR5qhM=;
 b=T90lIip1JUlJhxi+IeFpAuw8rmCmuFRm0MB4g9xs2O2RBlVkN2CRHqY2xIePWjHj66Ekv9
 ABGwiprCBKuWD2yucruIDS+Sx8NsYDO6z+56FuucPrUzRiWEG0aEZ14fR6p1ZSKs4pBOS9
 UVZoypCqyzwyFbqJX+0C1ByVLHAt90kUKAPu9CzCbnMoMiZpUKpwDedD8Yfgjfdu0viGwi
 ngbpH+uc60GNaqIMDRp7IAuaO6seufYIPDzcxgwLkWokPSou9aPKlW3MHJI6bp9AvmfQca
 6mDbppwdR88XETkfHyKMF5+gsHfkBA0t5S+LC58LS/x268lVb73pDnE7GZ7Dkg==
To: <linux-nvme@lists.infradead.org>, "Keith Busch" <kbusch@kernel.org>, 
	"Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, 
	"Sagi Grimberg" <sagi@grimberg.me>, 
	"Bart Van Assche" <bvanassche@acm.org>, 
	"Andy Shevchenko" <andriy.shevchenko@intel.com>, 
	"Thomas Gleixner" <tglx@kernel.org>, "Jun Zeng" <jun1.zeng@intel.com>, 
	"Gang Cao" <gang.cao@intel.com>, "Jun I Jin" <jun.i.jin@intel.com>, 
	"Liang A Fang" <liang.a.fang@intel.com>, "Yong Hu" <yong.hu@intel.com>
Cc: <linux-kernel@vger.kernel.org>, 
	"Fengnan Chang" <changfengnan@bytedance.com>, 
	"Guzebing" <guzebing@bytedance.com>
Date: Thu, 23 Jul 2026 20:05:56 +0800
From: "Fengnan Chang" <changfengnan@bytedance.com>
Subject: [RFC PATCH] nvme-pci: adaptively poll completions on busy queues
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+26a6203c3+b05f1e+lists.infradead.org+changfengnan@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <20260723120556.58670-1-changfengnan@bytedance.com>
Mime-Version: 1.0
X-Original-From: Fengnan Chang <changfengnan@bytedance.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_050640_652672_2C8ABBB5 
X-CRM114-Status: GOOD (  23.43  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In high-IOPS scenarios, relying on interrupts to handle I/O operations
can limit performance. This issue becomes particularly pronounced in
multi-disk environments, where performance is constrained by the CPU=E2=80=
=99s
interrupt-handling capacity.

Each Solidigm SB5PH27X038T device used for testing can deliver about 3.2M
4 KiB random-read IOPS.  Four devices therefore have about 12.8M IOPS of
aggregate capability, but interrupt-driven completion topped out at 7.81M
IOPS, or about 61% of that capability.

Add optional adaptive polling for busy interrupt-driven I/O queues.  After
an interrupt drains the CQ, use the ring distance between last_sq_tail and
cq_head as an approximate host-side inflight count.  If the count reaches
a per-controller high watermark, let the threaded handler keep draining
completions instead of returning to interrupt-driven completion right away.

The thread always checks for pending CQEs first.  When the CQ is empty, it
compares the inflight count with a per-controller low watermark and sleeps
for a configurable interval before checking again.  It returns to
interrupt-driven completion after three consecutive empty-CQ checks below
the low watermark or when the loop limit is reached.

The mode is disabled by default. It can be enabled at module load time.
The high and low watermarks, empty-CQ interval, and loop limit are
available through sysfs.  The defaults are 32 commands, 3 commands,
30 us, and 1000 iterations.

Tested with the default settings and 4 KiB random reads on four Solidigm
SB5PH27X038T devices.  With adaptive polling off and on:

  - t/io_uring, depth 1024 and four workers per device:
    7.810M and 12.780M aggregate IOPS (+63.64%).
  - fio/libaio, iodepth 1024, numjobs 4 and completion batches of 32:
    7.699M and 12.785M aggregate IOPS (+66.05%).

In a paired libaio and io_uring boundary sweep, QD8, QD16, QD32, and
QD16/numjobs=3D4 changed by -0.15% to +0.48%.  QD64 improved by 28.61% to
59.75%.

Link: https://lore.kernel.org/linux-nvme/20260720145927.GA17986@lst.de/
Signed-off-by: Guzebing <guzebing@bytedance.com>
Signed-off-by: Fengnan Chang <changfengnan@bytedance.com>
---
 Documentation/ABI/testing/sysfs-nvme |  63 +++++++
 drivers/nvme/host/pci.c              | 266 +++++++++++++++++++++++++++
 2 files changed, 329 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-nvme b/Documentation/ABI/testi=
ng/sysfs-nvme
index 499d5f843cd43..9e22a51a0f5bb 100644
--- a/Documentation/ABI/testing/sysfs-nvme
+++ b/Documentation/ABI/testing/sysfs-nvme
@@ -11,3 +11,66 @@ Description:
 		(REPLACETLSPSK) with the target. After a reauthentication
 		the value returned by tls_configured_key will be the new
 		serial.
+
+What:		/sys/class/nvme/nvmeX/adaptive_poll_inflight_high
+Date:		July 2026
+KernelVersion:	7.3
+Contact:	Linux NVMe mailing list <linux-nvme@lists.infradead.org>
+Description:
+		The number of outstanding commands at which an interrupt-driven
+		PCI I/O queue wakes its adaptive completion-drain thread. The value
+		must be greater than adaptive_poll_inflight_low and smaller than
+		the queue depth.
+
+		The default value is 32.
+
+What:		/sys/class/nvme/nvmeX/adaptive_poll_inflight_low
+Date:		July 2026
+KernelVersion:	7.3
+Contact:	Linux NVMe mailing list <linux-nvme@lists.infradead.org>
+Description:
+		The number of outstanding commands below which an adaptive
+		completion-drain thread starts counting empty-CQ checks. The
+		thread returns to interrupt-driven completion after three such
+		checks in a row. The counter is reset whenever the number of
+		outstanding commands reaches this value. The value must be nonzero
+		and smaller than adaptive_poll_inflight_high.
+
+		The default value is 3.
+
+What:		/sys/class/nvme/nvmeX/adaptive_poll_interval_us
+Date:		July 2026
+KernelVersion:	7.3
+Contact:	Linux NVMe mailing list <linux-nvme@lists.infradead.org>
+Description:
+		The number of microseconds that an adaptive completion-drain
+		thread waits before rechecking an empty CQ. The value must be
+		nonzero.
+
+		The default value is 30.
+
+What:		/sys/class/nvme/nvmeX/adaptive_poll_max_loops
+Date:		July 2026
+KernelVersion:	7.3
+Contact:	Linux NVMe mailing list <linux-nvme@lists.infradead.org>
+Description:
+		The maximum number of iterations performed each time an adaptive
+		completion-drain thread is woken. An iteration is counted whether
+		or not the CQ has pending completions. The value must be nonzero
+		and is sampled when the thread starts, so a new value applies to
+		subsequent thread activations.
+
+		The thread may exit earlier when the low-inflight condition is met.
+
+		The default value is 1000.
+
+What:		/sys/module/nvme/parameters/use_adaptive_polling
+Date:		July 2026
+KernelVersion:	7.3
+Contact:	Linux NVMe mailing list <linux-nvme@lists.infradead.org>
+Description:
+		Global module parameter for adaptive polling on PCI I/O queues.
+		Set to Y when loading the module, or on the kernel command line when
+		the driver is built in, to enable adaptive polling for all NVMe PCI
+		controllers. The default is N and the value cannot be changed after
+		the driver is loaded.
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 69932d640b537..296eadaf43199 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -9,6 +9,7 @@
 #include <linux/blkdev.h>
 #include <linux/blk-mq-dma.h>
 #include <linux/blk-integrity.h>
+#include <linux/delay.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
@@ -21,6 +22,7 @@
 #include <linux/nodemask.h>
 #include <linux/once.h>
 #include <linux/pci.h>
+#include <linux/sched.h>
 #include <linux/suspend.h>
 #include <linux/t10-pi.h>
 #include <linux/types.h>
@@ -82,6 +84,17 @@ struct quirk_entry {
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0444);
=20
+static bool use_adaptive_polling;
+module_param(use_adaptive_polling, bool, 0444);
+MODULE_PARM_DESC(use_adaptive_polling,
+		 "enable adaptive polling on busy interrupt-driven I/O queues");
+
+#define NVME_ADAPTIVE_POLL_INFLIGHT_HIGH_DEFAULT	32
+#define NVME_ADAPTIVE_POLL_INFLIGHT_LOW_DEFAULT		3
+#define NVME_ADAPTIVE_POLL_INTERVAL_US_DEFAULT	30
+#define NVME_ADAPTIVE_POLL_MAX_LOOPS_DEFAULT	1000
+#define NVME_ADAPTIVE_POLL_LOW_INFLIGHT_CHECKS	3
+
 static bool use_cmb_sqes =3D true;
 module_param(use_cmb_sqes, bool, 0444);
 MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQe=
s");
@@ -302,6 +315,11 @@ struct nvme_dev {
 	unsigned io_queues[HCTX_MAX_TYPES];
 	unsigned int num_vecs;
 	u32 q_depth;
+	unsigned int adaptive_poll_inflight_high;
+	unsigned int adaptive_poll_inflight_low;
+	unsigned int adaptive_poll_interval_us;
+	unsigned int adaptive_poll_max_loops;
+	struct mutex adaptive_poll_config_lock; /* serializes watermark updates *=
/
 	int io_sqes;
 	u32 db_stride;
 	void __iomem *bar;
@@ -386,6 +404,7 @@ struct nvme_queue {
 #define NVMEQ_SQ_CMB		1
 #define NVMEQ_DELETE_ERROR	2
 #define NVMEQ_POLLED		3
+#define NVMEQ_ADAPTIVE_POLLING	4
 	__le32 *dbbuf_sq_db;
 	__le32 *dbbuf_cq_db;
 	__le32 *dbbuf_sq_ei;
@@ -1649,6 +1668,99 @@ static irqreturn_t nvme_irq_check(int irq, void *dat=
a)
 	return IRQ_NONE;
 }
=20
+/*
+ * PCI I/O queues have one SQ and one CQ of the same depth.  last_sq_tail
+ * counts commands published to the controller while cq_head counts comman=
ds
+ * completed and consumed by the host, so their ring distance is the numbe=
r
+ * of commands that can still produce completions.
+ */
+static unsigned int nvme_adaptive_poll_inflight(struct nvme_queue *nvmeq)
+{
+	int inflight =3D READ_ONCE(nvmeq->last_sq_tail) -
+			READ_ONCE(nvmeq->cq_head);
+
+	if (inflight < 0)
+		inflight +=3D nvmeq->q_depth;
+	return inflight;
+}
+
+static void nvme_adaptive_mask_irq(struct nvme_queue *nvmeq, int irq)
+{
+	struct nvme_dev *dev =3D nvmeq->dev;
+	struct pci_dev *pdev =3D to_pci_dev(dev->dev);
+
+	if (pdev->msi_enabled) {
+		writel(BIT(nvmeq->cq_vector), dev->bar + NVME_REG_INTMS);
+		readl(dev->bar + NVME_REG_INTMS);
+	} else {
+		disable_irq_nosync(irq);
+	}
+}
+
+static void nvme_adaptive_unmask_irq(struct nvme_queue *nvmeq, int irq)
+{
+	struct nvme_dev *dev =3D nvmeq->dev;
+	struct pci_dev *pdev =3D to_pci_dev(dev->dev);
+
+	clear_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->flags);
+	if (pdev->msi_enabled) {
+		writel(BIT(nvmeq->cq_vector), dev->bar + NVME_REG_INTMC);
+		readl(dev->bar + NVME_REG_INTMS);
+	} else {
+		enable_irq(irq);
+	}
+}
+
+static irqreturn_t nvme_irq_adaptive_poll(int irq, void *data)
+{
+	struct nvme_queue *nvmeq =3D data;
+	unsigned int max_loops =3D
+		READ_ONCE(nvmeq->dev->adaptive_poll_max_loops);
+	unsigned int low_inflight_checks =3D 0;
+
+	do {
+		if (nvme_cqe_pending(nvmeq)) {
+			nvme_irq(irq, data);
+			low_inflight_checks =3D 0;
+			cond_resched();
+			continue;
+		}
+		if (nvme_adaptive_poll_inflight(nvmeq) <
+		    READ_ONCE(nvmeq->dev->adaptive_poll_inflight_low)) {
+			if (++low_inflight_checks >=3D
+			    NVME_ADAPTIVE_POLL_LOW_INFLIGHT_CHECKS)
+				break;
+		} else {
+			low_inflight_checks =3D 0;
+		}
+		fsleep(READ_ONCE(nvmeq->dev->adaptive_poll_interval_us));
+	} while (--max_loops);
+
+	nvme_adaptive_unmask_irq(nvmeq, irq);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t nvme_irq_adaptive_check(int irq, void *data)
+{
+	struct nvme_queue *nvmeq =3D data;
+	irqreturn_t ret;
+
+	if (test_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->flags))
+		return IRQ_HANDLED;
+
+	ret =3D nvme_irq(irq, data);
+	if (ret !=3D IRQ_HANDLED)
+		return ret;
+
+	if (nvme_adaptive_poll_inflight(nvmeq) <
+	    READ_ONCE(nvmeq->dev->adaptive_poll_inflight_high))
+		return ret;
+
+	set_bit(NVMEQ_ADAPTIVE_POLLING, &nvmeq->flags);
+	nvme_adaptive_mask_irq(nvmeq, irq);
+	return IRQ_WAKE_THREAD;
+}
+
 /*
  * Poll for completions for any interrupt driven queue
  * Can be called from any context.
@@ -2171,9 +2283,22 @@ static int queue_request_irq(struct nvme_queue *nvme=
q)
 	struct pci_dev *pdev =3D to_pci_dev(nvmeq->dev->dev);
 	int nr =3D nvmeq->dev->ctrl.instance;
=20
+	/*
+	 * INTMS/INTMC mask MSI vectors and only cover vectors 0-31.  They must
+	 * not be accessed while MSI-X is enabled, so mask MSI-X vectors through
+	 * the PCI IRQ chip.
+	 */
 	if (use_threaded_interrupts) {
 		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
 				nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
+	} else if (use_adaptive_polling && nvmeq->qid &&
+	    nvmeq->dev->num_vecs > 1 &&
+	    (pdev->msix_enabled ||
+	     (pdev->msi_enabled && nvmeq->cq_vector < 32))) {
+		return pci_request_irq(pdev, nvmeq->cq_vector,
+				nvme_irq_adaptive_check, nvme_irq_adaptive_poll,
+				nvmeq,
+				"nvme%dq%d", nr, nvmeq->qid);
 	} else {
 		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
 				NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
@@ -2808,6 +2933,134 @@ static ssize_t hmb_store(struct device *dev, struct=
 device_attribute *attr,
 }
 static DEVICE_ATTR_RW(hmb);
=20
+static ssize_t adaptive_poll_inflight_high_show(struct device *dev,
+						struct device_attribute *attr,
+						char *buf)
+{
+	struct nvme_dev *ndev =3D to_nvme_dev(dev_get_drvdata(dev));
+
+	return sysfs_emit(buf, "%u\n",
+			  READ_ONCE(ndev->adaptive_poll_inflight_high));
+}
+
+static ssize_t adaptive_poll_inflight_high_store(struct device *dev,
+						 struct device_attribute *attr,
+						 const char *buf, size_t count)
+{
+	struct nvme_dev *ndev =3D to_nvme_dev(dev_get_drvdata(dev));
+	unsigned int value;
+	int ret;
+
+	ret =3D kstrtouint(buf, 10, &value);
+	if (ret)
+		return ret;
+	if (!value || value >=3D ndev->q_depth)
+		return -EINVAL;
+
+	mutex_lock(&ndev->adaptive_poll_config_lock);
+	if (value <=3D READ_ONCE(ndev->adaptive_poll_inflight_low)) {
+		mutex_unlock(&ndev->adaptive_poll_config_lock);
+		return -EINVAL;
+	}
+	WRITE_ONCE(ndev->adaptive_poll_inflight_high, value);
+	mutex_unlock(&ndev->adaptive_poll_config_lock);
+	return count;
+}
+static DEVICE_ATTR_RW(adaptive_poll_inflight_high);
+
+static ssize_t adaptive_poll_inflight_low_show(struct device *dev,
+					       struct device_attribute *attr,
+					       char *buf)
+{
+	struct nvme_dev *ndev =3D to_nvme_dev(dev_get_drvdata(dev));
+
+	return sysfs_emit(buf, "%u\n",
+			  READ_ONCE(ndev->adaptive_poll_inflight_low));
+}
+
+static ssize_t adaptive_poll_inflight_low_store(struct device *dev,
+						struct device_attribute *attr,
+						const char *buf, size_t count)
+{
+	struct nvme_dev *ndev =3D to_nvme_dev(dev_get_drvdata(dev));
+	unsigned int value;
+	int ret;
+
+	ret =3D kstrtouint(buf, 10, &value);
+	if (ret)
+		return ret;
+	if (!value || value >=3D ndev->q_depth)
+		return -EINVAL;
+
+	mutex_lock(&ndev->adaptive_poll_config_lock);
+	if (value >=3D READ_ONCE(ndev->adaptive_poll_inflight_high)) {
+		mutex_unlock(&ndev->adaptive_poll_config_lock);
+		return -EINVAL;
+	}
+	WRITE_ONCE(ndev->adaptive_poll_inflight_low, value);
+	mutex_unlock(&ndev->adaptive_poll_config_lock);
+	return count;
+}
+static DEVICE_ATTR_RW(adaptive_poll_inflight_low);
+
+static ssize_t adaptive_poll_interval_us_show(struct device *dev,
+					      struct device_attribute *attr,
+					      char *buf)
+{
+	struct nvme_dev *ndev =3D to_nvme_dev(dev_get_drvdata(dev));
+
+	return sysfs_emit(buf, "%u\n",
+			  READ_ONCE(ndev->adaptive_poll_interval_us));
+}
+
+static ssize_t adaptive_poll_interval_us_store(struct device *dev,
+					       struct device_attribute *attr,
+					       const char *buf, size_t count)
+{
+	struct nvme_dev *ndev =3D to_nvme_dev(dev_get_drvdata(dev));
+	unsigned int value;
+	int ret;
+
+	ret =3D kstrtouint(buf, 10, &value);
+	if (ret)
+		return ret;
+	if (!value)
+		return -EINVAL;
+
+	WRITE_ONCE(ndev->adaptive_poll_interval_us, value);
+	return count;
+}
+static DEVICE_ATTR_RW(adaptive_poll_interval_us);
+
+static ssize_t adaptive_poll_max_loops_show(struct device *dev,
+					    struct device_attribute *attr,
+					    char *buf)
+{
+	struct nvme_dev *ndev =3D to_nvme_dev(dev_get_drvdata(dev));
+
+	return sysfs_emit(buf, "%u\n",
+			  READ_ONCE(ndev->adaptive_poll_max_loops));
+}
+
+static ssize_t adaptive_poll_max_loops_store(struct device *dev,
+					     struct device_attribute *attr,
+					     const char *buf, size_t count)
+{
+	struct nvme_dev *ndev =3D to_nvme_dev(dev_get_drvdata(dev));
+	unsigned int value;
+	int ret;
+
+	ret =3D kstrtouint(buf, 10, &value);
+	if (ret)
+		return ret;
+	if (!value)
+		return -EINVAL;
+
+	WRITE_ONCE(ndev->adaptive_poll_max_loops, value);
+	return count;
+}
+static DEVICE_ATTR_RW(adaptive_poll_max_loops);
+
 static umode_t nvme_pci_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
@@ -2832,6 +3085,10 @@ static struct attribute *nvme_pci_attrs[] =3D {
 	&dev_attr_cmbloc.attr,
 	&dev_attr_cmbsz.attr,
 	&dev_attr_hmb.attr,
+	&dev_attr_adaptive_poll_inflight_high.attr,
+	&dev_attr_adaptive_poll_inflight_low.attr,
+	&dev_attr_adaptive_poll_interval_us.attr,
+	&dev_attr_adaptive_poll_max_loops.attr,
 	NULL,
 };
=20
@@ -3685,6 +3942,15 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pc=
i_dev *pdev,
 		return ERR_PTR(-ENOMEM);
 	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
 	mutex_init(&dev->shutdown_lock);
+	mutex_init(&dev->adaptive_poll_config_lock);
+	dev->adaptive_poll_inflight_high =3D
+		NVME_ADAPTIVE_POLL_INFLIGHT_HIGH_DEFAULT;
+	dev->adaptive_poll_inflight_low =3D
+		NVME_ADAPTIVE_POLL_INFLIGHT_LOW_DEFAULT;
+	dev->adaptive_poll_interval_us =3D
+		NVME_ADAPTIVE_POLL_INTERVAL_US_DEFAULT;
+	dev->adaptive_poll_max_loops =3D
+		NVME_ADAPTIVE_POLL_MAX_LOOPS_DEFAULT;
=20
 	dev->nr_write_queues =3D write_queues;
 	dev->nr_poll_queues =3D poll_queues;
--=20
2.39.5 (Apple Git-154)

