Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B615DCFA755
	for <linux-nvme@archiver.kernel.org>; Fri,  4 Oct 2024 10:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fPncAOhSeoQRR+qidRsIJgyq/reHvHCe62rJEltWk3c=; b=CFCNRnjxrHM09DBhcZ5jOoAdUG
	nj42q8DHWGBK1Y6E4LoWlxbj1zmAML2Vi9/SlvkARgWjs9FtyiUAN2ymc/0Ch3GLRiy5fNqpWA2//
	nIHemrinH8Zf2WLXRoz1orHVgn6QaTW6FUxtN79wBQEFe/wQlr6UwcVxdIIfAdeW0PBw0CURlOBvh
	DF5YITsFp5zdzPKwWXMWVzZbyGA80eyZY/gGhByb3Y04VCn1pKhuWoJ5G7MPjhZtuIveyIG0z8EtY
	NQFRweLuK0+qJojj/hhiRv1pgPNiz8zlSJb8z2acPjC9G6gZK1W8x2KZEBmsYgSJFifegFCxORzGq
	F1X8T4lA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1swfGb-0000000BmOP-0FXP;
	Fri, 04 Oct 2024 10:10:33 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1swfGY-0000000BmNV-19fw
	for linux-nvme@lists.infradead.org;
	Fri, 04 Oct 2024 10:10:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728036630; x=1759572630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cbPszOCbBhjcg6DhE8k/CQH5gCsEbG59fQMrmoBU6Yo=;
  b=gHo35eFxlKRFJfSPX5nLzmfcWEETw/0ZBMrMos9g6w3BYpGYeTJYjCSx
   kv998Xwy9Fmm5DUMcwAKskEhb77YSzYEMNZqvkNQY+sV/LTyBW3f7Yp6M
   KSWONEL/pF/cDTsABxKe3fnQeiTee/K4w02MKLzEXdVYzQr2qVlvkPCZb
   CWFhi0gnUaBqhUr5fiE6LNmU9rCxS5m3RK7ZkSx3wbIlBrT8y3UttYNqb
   MNlrIgDoTwlK15rsdlVl30H700rRSKGBvsOTmG+lplqeelp0dFmrhQ/Qx
   JnnXcuN7T+VIsCjzYaAkr7TtouI+rNVIMKiXnv1PFNrf/2FITWUApaEDt
   g==;
X-CSE-ConnectionGUID: 4GrlHSOJQ/CXGnZ88NKAYA==
X-CSE-MsgGUID: d0HHXFUVRwCjRDYS9KRZCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="44784896"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="44784896"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 03:10:30 -0700
X-CSE-ConnectionGUID: oXfu1ehtSBCJqK2UHrEfkg==
X-CSE-MsgGUID: 1cI0wbkfQsGC4/DcQC62vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74658823"
Received: from olympicsflex1.amr.corp.intel.com (HELO tkristo-desk.intel.com) ([10.245.245.54])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 03:10:28 -0700
From: Tero Kristo <tero.kristo@linux.intel.com>
To: 
Cc: linux-kernel@vger.kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	kbusch@kernel.org
Subject: [PATCH 1/1] nvme-pci: Add CPU latency pm-qos handling
Date: Fri,  4 Oct 2024 13:09:28 +0300
Message-ID: <20241004101014.3716006-2-tero.kristo@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004101014.3716006-1-tero.kristo@linux.intel.com>
References: <20241004101014.3716006-1-tero.kristo@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241004_031030_355482_4C8857D8 
X-CRM114-Status: GOOD (  18.15  )
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

Add support for limiting CPU latency while NVME IO is running. When a
NVME IO is started, it will add a user configurable CPU latency limit
in place (if any.) The limit is removed after 3ms of inactivity.

The CPU latency limit is configurable via a sysfs parameter;
cpu_latency_us under the NVME device.

Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
---
 drivers/nvme/host/pci.c | 95 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 90 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7990c3f22ecf..de8ddc9b36de 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -21,6 +21,7 @@
 #include <linux/mutex.h>
 #include <linux/once.h>
 #include <linux/pci.h>
+#include <linux/pm_qos.h>
 #include <linux/suspend.h>
 #include <linux/t10-pi.h>
 #include <linux/types.h>
@@ -112,6 +113,14 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 static void nvme_delete_io_queues(struct nvme_dev *dev);
 static void nvme_update_attrs(struct nvme_dev *dev);
 
+#define NVME_CPU_LATENCY_TIMEOUT_MS	3
+
+struct nvme_cpu_latency_qos {
+	struct dev_pm_qos_request	req;
+	struct delayed_work		work;
+	unsigned long			active;
+};
+
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
  */
@@ -141,6 +150,8 @@ struct nvme_dev {
 	struct nvme_ctrl ctrl;
 	u32 last_ps;
 	bool hmb;
+	int cpu_latency;
+	struct nvme_cpu_latency_qos __percpu *cpu_latency_qos;
 
 	mempool_t *iod_mempool;
 
@@ -213,6 +224,7 @@ struct nvme_queue {
 	__le32 *dbbuf_cq_db;
 	__le32 *dbbuf_sq_ei;
 	__le32 *dbbuf_cq_ei;
+	const struct cpumask *irq_aff_mask;
 	struct completion delete_done;
 };
 
@@ -470,6 +482,9 @@ static void nvme_pci_map_queues(struct blk_mq_tag_set *set)
  */
 static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
 {
+	struct nvme_dev *dev;
+	int cpu;
+
 	if (!write_sq) {
 		u16 next_tail = nvmeq->sq_tail + 1;
 
@@ -483,6 +498,27 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
 			nvmeq->dbbuf_sq_db, nvmeq->dbbuf_sq_ei))
 		writel(nvmeq->sq_tail, nvmeq->q_db);
 	nvmeq->last_sq_tail = nvmeq->sq_tail;
+
+	/* Kick CPU latency while updating queue. */
+	dev = nvmeq->dev;
+	if (!dev || dev->cpu_latency < 0)
+		return;
+
+	for_each_cpu(cpu, nvmeq->irq_aff_mask) {
+		struct nvme_cpu_latency_qos *qos;
+
+		qos = per_cpu_ptr(dev->cpu_latency_qos, cpu);
+
+		qos->active = jiffies + msecs_to_jiffies(NVME_CPU_LATENCY_TIMEOUT_MS);
+
+		if (dev_pm_qos_request_active(&qos->req))
+			continue;
+
+		dev_pm_qos_add_request(get_cpu_device(cpu), &qos->req,
+				       DEV_PM_QOS_RESUME_LATENCY,
+				       dev->cpu_latency);
+		schedule_delayed_work(&qos->work, msecs_to_jiffies(NVME_CPU_LATENCY_TIMEOUT_MS));
+	}
 }
 
 static inline void nvme_sq_copy_cmd(struct nvme_queue *nvmeq,
@@ -1600,14 +1636,19 @@ static int queue_request_irq(struct nvme_queue *nvmeq)
 {
 	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
 	int nr = nvmeq->dev->ctrl.instance;
+	int ret;
 
 	if (use_threaded_interrupts) {
-		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
-				nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
+		ret = pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
+				      nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
 	} else {
-		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
-				NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
+		ret = pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
+				      NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
 	}
+
+	nvmeq->irq_aff_mask = pci_irq_get_affinity(pdev, nvmeq->cq_vector);
+
+	return ret;
 }
 
 static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
@@ -2171,6 +2212,26 @@ static ssize_t hmb_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(hmb);
 
+static ssize_t cpu_latency_us_show(struct device *dev, struct device_attribute *attr,
+				   char *buf)
+{
+	struct nvme_dev *ndev = to_nvme_dev(dev_get_drvdata(dev));
+
+	return sysfs_emit(buf, "%d\n", ndev->cpu_latency);
+}
+
+static ssize_t cpu_latency_us_store(struct device *dev, struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	struct nvme_dev *ndev = to_nvme_dev(dev_get_drvdata(dev));
+
+	if (kstrtoint(buf, 10, &ndev->cpu_latency) < 0)
+		return -EINVAL;
+
+	return count;
+}
+static DEVICE_ATTR_RW(cpu_latency_us);
+
 static umode_t nvme_pci_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
@@ -2195,6 +2256,7 @@ static struct attribute *nvme_pci_attrs[] = {
 	&dev_attr_cmbloc.attr,
 	&dev_attr_cmbsz.attr,
 	&dev_attr_hmb.attr,
+	&dev_attr_cpu_latency_us.attr,
 	NULL,
 };
 
@@ -2731,6 +2793,7 @@ static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 	nvme_free_tagset(dev);
 	put_device(dev->dev);
 	kfree(dev->queues);
+	free_percpu(dev->cpu_latency_qos);
 	kfree(dev);
 }
 
@@ -2989,6 +3052,17 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 	return 0;
 }
 
+static void nvme_cpu_latency_work(struct work_struct *work)
+{
+	struct nvme_cpu_latency_qos *qos =
+		container_of(work, struct nvme_cpu_latency_qos, work.work);
+	if (time_after(jiffies, qos->active)) {
+		dev_pm_qos_remove_request(&qos->req);
+	} else {
+		schedule_delayed_work(&qos->work, msecs_to_jiffies(NVME_CPU_LATENCY_TIMEOUT_MS));
+	}
+}
+
 static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 		const struct pci_device_id *id)
 {
@@ -2996,6 +3070,7 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	int node = dev_to_node(&pdev->dev);
 	struct nvme_dev *dev;
 	int ret = -ENOMEM;
+	int cpu;
 
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
 	if (!dev)
@@ -3003,13 +3078,21 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
 	mutex_init(&dev->shutdown_lock);
 
+	dev->cpu_latency_qos = alloc_percpu(struct nvme_cpu_latency_qos);
+	if (!dev->cpu_latency_qos)
+		goto out_free_dev;
+	for_each_possible_cpu(cpu)
+		INIT_DELAYED_WORK(per_cpu_ptr(&dev->cpu_latency_qos->work, cpu),
+				  nvme_cpu_latency_work);
+	dev->cpu_latency = -1;
+
 	dev->nr_write_queues = write_queues;
 	dev->nr_poll_queues = poll_queues;
 	dev->nr_allocated_queues = nvme_max_io_queues(dev) + 1;
 	dev->queues = kcalloc_node(dev->nr_allocated_queues,
 			sizeof(struct nvme_queue), GFP_KERNEL, node);
 	if (!dev->queues)
-		goto out_free_dev;
+		goto out_free_pm_qos;
 
 	dev->dev = get_device(&pdev->dev);
 
@@ -3055,6 +3138,8 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 out_put_device:
 	put_device(dev->dev);
 	kfree(dev->queues);
+out_free_pm_qos:
+	free_percpu(dev->cpu_latency_qos);
 out_free_dev:
 	kfree(dev);
 	return ERR_PTR(ret);
-- 
2.43.1


