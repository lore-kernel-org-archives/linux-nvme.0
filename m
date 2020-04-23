Return-Path: <SRS0=YD4V=6H=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EA2C2BA19
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2020 08:00:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0024F20736
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Apr 2020 08:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="C/uk9dCs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0024F20736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=didiglobal.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=O8c3IghX0eydiEziGHXtu3TR7tsqRKxYOK6DkbBPR50=; b=C/uk9dCs+aXdxJ
	/s6CvRvPpVI6jvfIPhf12H2K3Bvenm/pUIIVyJWamvfqBrsQlDZpOtopv5DyetY/SGtC270oAoXIs
	pGNFKcQ7/aZJ17raFPTaLAkwd3Ku/gurjO7eNHLRwgxAechqsBH/dc0RyyI51LZzx6mAiobYhKqv3
	r5ZufI5RFJ0j//M5FQx/6eYgotunaHtiY+2TAnwi36P894FAt3bIGKlhMXP6HBXDORe4wLyg9qtKL
	6TUPKW2cYDsLCFhyiojfabvlZ1lbM6cIu7Bb2YMi65cqGC5x7QK+b+FR5gnopXlKB5+kX2oeHYy8R
	et5yNgbbCScDZSqOkkWA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jRWmG-0005qL-Hq; Thu, 23 Apr 2020 08:00:08 +0000
Received: from mx2.didichuxing.com ([36.110.17.22] helo=bsf01.didichuxing.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1jRWmA-0004b5-EX
 for linux-nvme@lists.infradead.org; Thu, 23 Apr 2020 08:00:06 +0000
X-ASG-Debug-ID: 1587628787-0e4088442c34d4f0001-VMfPqL
Received: from mail.didiglobal.com (localhost [172.20.36.203]) by
 bsf01.didichuxing.com with ESMTP id iK081vDxRJAfZO8A;
 Thu, 23 Apr 2020 15:59:47 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 23 Apr
 2020 15:59:47 +0800
Date: Thu, 23 Apr 2020 15:59:42 +0800
From: Weiping Zhang <zhangweiping@didiglobal.com>
To: <hch@infradead.org>, <axboe@kernel.dk>, <kbusch@kernel.org>,
 <sagi@grimberg.me>, <maxg@mellanox.com>
Subject: [PATCH v2] nvme: align io queue count with allocted nvme_queue in
 nvme_probe
Message-ID: <20200423075938.GA11215@192.168.3.9>
X-ASG-Orig-Subj: [PATCH v2] nvme: align io queue count with allocted
 nvme_queue in nvme_probe
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS03.didichuxing.com (172.20.36.245) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.203]
X-Barracuda-Start-Time: 1587628787
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 8334
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No,
 SCORE=-2.02 using global scores of TAG_LEVEL=1000.0
 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81364
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------------------------
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200423_010003_302204_C5B6F4D5 
X-CRM114-Status: GOOD (  17.37  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Since the commit 147b27e4bd0 "nvme-pci: allocate device queues storage space at probe"
nvme_alloc_queue will not alloc struct nvme_queue any more.
If user change write/poll_queues to larger than the number of
allocated queue in nvme_probe, nvme_alloc_queue will touch
the memory out of boundary.

This patch add nr_allocated_queues for struct nvme_dev to record how
many queues alloctaed in nvme_probe, then nvme driver will not use
more queues than nr_allocated_queues when user update queue count
and do a controller reset.

Since global module parameter can be changed at rumtime, so it's not
safe to use these two parameter directly in the following functions:
nvme_dbbuf_dma_alloc
nvme_dbbuf_dma_free
nvme_calc_irq_sets
nvme_setup_io_queues

This patch also add nr_write_queues, nr_poll_queues for
struct nvme_dev and io_queues_reload for struct nvme_ctrl, that allow
per-controller reload module parmater when reset controller. The nvme
driver will not reload module parameter(write/poll_queues) by default
when reset controller. If user want to reload them, they should enable
it by echo 1 > /sys/block/<nvme_disk>/device/io_queues_reload.

By now, nvme pci driver allow user change io queue count for each
type(write, read, poll) within nr_allocated_queue, that's to say, if
user want to change queue dynamically by reset controller, they should
setup io queues as many as possiable when laod nvme module, and then
tune io queue count for each type.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
Changes since V1:
 * don't use module parameter nvme_dbbuf_dma_free, nvme_dbbuf_dma_alloc
	and nvme_calc_irq_sets.
 * add per-controller sysfs file io_queues_reload to enable/disable
	reload global module parameter.

 drivers/nvme/host/core.c | 29 +++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  | 55 +++++++++++++++++++++++-----------------
 3 files changed, 62 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dfb064b4334f..80172192a9d8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3357,6 +3357,34 @@ static ssize_t nvme_sysfs_show_address(struct device *dev,
 }
 static DEVICE_ATTR(address, S_IRUGO, nvme_sysfs_show_address, NULL);
 
+static ssize_t nvme_sysfs_io_queues_reload_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return snprintf(buf, PAGE_SIZE, "%d\n",
+		ctrl->io_queues_reload ? 1 : 0);
+}
+
+static ssize_t nvme_sysfs_io_queues_reload_store(struct device *dev,
+				struct device_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	bool val;
+
+	if (kstrtobool(buf, &val))
+		return -EINVAL;
+	ctrl->io_queues_reload = val;
+
+	return count;
+}
+
+static DEVICE_ATTR(io_queues_reload, S_IRUGO | S_IWUSR,
+		nvme_sysfs_io_queues_reload_show,
+		nvme_sysfs_io_queues_reload_store);
+
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
@@ -3374,6 +3402,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_sqsize.attr,
 	&dev_attr_hostnqn.attr,
 	&dev_attr_hostid.attr,
+	&dev_attr_io_queues_reload.attr,
 	NULL
 };
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f3ab17778349..50b6392b9a33 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -260,6 +260,7 @@ struct nvme_ctrl {
 	struct work_struct fw_act_work;
 	unsigned long events;
 	bool created;
+	bool io_queues_reload;
 
 #ifdef CONFIG_NVME_MULTIPATH
 	/* asymmetric namespace access: */
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4e79e412b276..00f7c93d73c9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -89,6 +89,9 @@ static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode);
  */
 struct nvme_dev {
 	struct nvme_queue *queues;
+	int nr_allocated_queue;
+	int nr_write_queues;
+	int nr_poll_queues;
 	struct blk_mq_tag_set tagset;
 	struct blk_mq_tag_set admin_tagset;
 	u32 __iomem *dbs;
@@ -209,25 +212,14 @@ struct nvme_iod {
 	struct scatterlist *sg;
 };
 
-static unsigned int max_io_queues(void)
+static inline unsigned int nvme_dbbuf_size(struct nvme_dev *dev)
 {
-	return num_possible_cpus() + write_queues + poll_queues;
-}
-
-static unsigned int max_queue_count(void)
-{
-	/* IO queues + admin queue */
-	return 1 + max_io_queues();
-}
-
-static inline unsigned int nvme_dbbuf_size(u32 stride)
-{
-	return (max_queue_count() * 8 * stride);
+	return (dev->nr_allocated_queue * 8 * dev->db_stride);
 }
 
 static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
 {
-	unsigned int mem_size = nvme_dbbuf_size(dev->db_stride);
+	unsigned int mem_size = nvme_dbbuf_size(dev);
 
 	if (dev->dbbuf_dbs)
 		return 0;
@@ -252,7 +244,7 @@ static int nvme_dbbuf_dma_alloc(struct nvme_dev *dev)
 
 static void nvme_dbbuf_dma_free(struct nvme_dev *dev)
 {
-	unsigned int mem_size = nvme_dbbuf_size(dev->db_stride);
+	unsigned int mem_size = nvme_dbbuf_size(dev);
 
 	if (dev->dbbuf_dbs) {
 		dma_free_coherent(dev->dev, mem_size,
@@ -1991,7 +1983,7 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
 static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
 {
 	struct nvme_dev *dev = affd->priv;
-	unsigned int nr_read_queues;
+	unsigned int nr_read_queues, nr_write_queues = dev->nr_write_queues;
 
 	/*
 	 * If there is no interupt available for queues, ensure that
@@ -2007,12 +1999,12 @@ static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
 	if (!nrirqs) {
 		nrirqs = 1;
 		nr_read_queues = 0;
-	} else if (nrirqs == 1 || !write_queues) {
+	} else if (nrirqs == 1 || !nr_write_queues) {
 		nr_read_queues = 0;
-	} else if (write_queues >= nrirqs) {
+	} else if (nr_write_queues >= nrirqs) {
 		nr_read_queues = 1;
 	} else {
-		nr_read_queues = nrirqs - write_queues;
+		nr_read_queues = nrirqs - nr_write_queues;
 	}
 
 	dev->io_queues[HCTX_TYPE_DEFAULT] = nrirqs - nr_read_queues;
@@ -2036,7 +2028,7 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 	 * Poll queues don't need interrupts, but we need at least one IO
 	 * queue left over for non-polled IO.
 	 */
-	this_p_queues = poll_queues;
+	this_p_queues = dev->nr_poll_queues;
 	if (this_p_queues >= nr_io_queues) {
 		this_p_queues = nr_io_queues - 1;
 		irq_queues = 1;
@@ -2073,7 +2065,17 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	int result, nr_io_queues;
 	unsigned long size;
 
-	nr_io_queues = max_io_queues();
+	/* reload io queue count from module paramters write/poll_queues */
+	if (dev->ctrl.io_queues_reload) {
+		dev->nr_write_queues = write_queues;
+		dev->nr_poll_queues = poll_queues;
+		nr_io_queues = num_possible_cpus() + dev->nr_write_queues +
+				dev->nr_poll_queues;
+		if (nr_io_queues > dev->nr_allocated_queue - 1)
+			nr_io_queues = dev->nr_allocated_queue - 1;
+	} else {
+		nr_io_queues = dev->nr_allocated_queue - 1;
+	}
 
 	/*
 	 * If tags are shared with admin queue (Apple bug), then
@@ -2742,7 +2744,7 @@ static void nvme_async_probe(void *data, async_cookie_t cookie)
 
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
-	int node, result = -ENOMEM;
+	int node, nr_queue, result = -ENOMEM;
 	struct nvme_dev *dev;
 	unsigned long quirks = id->driver_data;
 	size_t alloc_size;
@@ -2755,11 +2757,18 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!dev)
 		return -ENOMEM;
 
-	dev->queues = kcalloc_node(max_queue_count(), sizeof(struct nvme_queue),
+	dev->nr_write_queues = write_queues;
+	dev->nr_poll_queues = poll_queues;
+	/* IO queues + admin queue */
+	nr_queue = dev->nr_write_queues + dev->nr_poll_queues +
+		num_possible_cpus() + 1;
+	dev->queues = kcalloc_node(nr_queue, sizeof(struct nvme_queue),
 					GFP_KERNEL, node);
 	if (!dev->queues)
 		goto free;
 
+	dev->nr_allocated_queue = nr_queue;
+
 	dev->dev = get_device(&pdev->dev);
 	pci_set_drvdata(pdev, dev);
 
-- 
2.18.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
