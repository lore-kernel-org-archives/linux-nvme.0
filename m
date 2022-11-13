Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6143C4332F
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 16:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dhw1WP1IK5Ic1WAWwJYsEpGJrCyUEi5i5Lbgx3NSKVw=; b=X0XvIfYO+oj6Nh/aTQPl+FQfqR
	ROpZzEyKP+fKWdpgIfc9EK370qOprrAk+c19AHhGDTTaLOHKElQ0iPYEM2o7wt5WQG6kr2q3JwMsd
	8rW1QcteOy7CNMhFkbnNaYkMkTUvfozipkWrzQA3PiobiJtiXWwer2GB4FikE9vapkVdNsr/tP8W5
	e2yzBrald545tDUIF34SZaPO/5u3ZIc4flfa7ZyTPaOklNPEGqaBqxc6aq/1P22yAt+i4eyuTspCo
	pMceudheCN8eqfHS/+7zsCJVZNh404Ck/i0cdO8eeAKb/x3F/Q1q2srHQCiGLcGRoo0C1hk4L35wp
	sV0A1GAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFaP-00CBsA-Vo; Sun, 13 Nov 2022 16:11:58 +0000
Received: from 213-225-8-167.nat.highway.a1.net ([213.225.8.167] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouFaL-00CBpb-Qc; Sun, 13 Nov 2022 16:11:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: [PATCH 03/13] nvme: simplify transport specific device attribute handling
Date: Sun, 13 Nov 2022 17:11:28 +0100
Message-Id: <20221113161138.883195-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221113161138.883195-1-hch@lst.de>
References: <20221113161138.883195-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Allow the transport driver to override the attribute groups for the
control device, so that the PCIe driver doesn't manually have to add a
group after device creation and keep track of it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Tested-by Gerd Bayer <gbayer@linxu.ibm.com>
---
 drivers/nvme/host/core.c |  8 ++++++--
 drivers/nvme/host/nvme.h |  2 ++
 drivers/nvme/host/pci.c  | 23 ++++++++---------------
 3 files changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index aedacf2fba69e..6040a13d3e2d1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3906,10 +3906,11 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 	return a->mode;
 }
 
-static const struct attribute_group nvme_dev_attrs_group = {
+const struct attribute_group nvme_dev_attrs_group = {
 	.attrs		= nvme_dev_attrs,
 	.is_visible	= nvme_dev_attrs_are_visible,
 };
+EXPORT_SYMBOL_GPL(nvme_dev_attrs_group);
 
 static const struct attribute_group *nvme_dev_attr_groups[] = {
 	&nvme_dev_attrs_group,
@@ -5091,7 +5092,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 			ctrl->instance);
 	ctrl->device->class = nvme_class;
 	ctrl->device->parent = ctrl->dev;
-	ctrl->device->groups = nvme_dev_attr_groups;
+	if (ops->dev_attr_groups)
+		ctrl->device->groups = ops->dev_attr_groups;
+	else
+		ctrl->device->groups = nvme_dev_attr_groups;
 	ctrl->device->release = nvme_free_ctrl;
 	dev_set_drvdata(ctrl->device, ctrl);
 	ret = dev_set_name(ctrl->device, "nvme%d", ctrl->instance);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 306a120d49ab9..924ff80d85f60 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -508,6 +508,7 @@ struct nvme_ctrl_ops {
 	unsigned int flags;
 #define NVME_F_FABRICS			(1 << 0)
 #define NVME_F_METADATA_SUPPORTED	(1 << 1)
+	const struct attribute_group **dev_attr_groups;
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
@@ -854,6 +855,7 @@ int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 extern const struct attribute_group *nvme_ns_id_attr_groups[];
 extern const struct pr_ops nvme_pr_ops;
 extern const struct block_device_operations nvme_ns_head_ops;
+extern const struct attribute_group nvme_dev_attrs_group;
 
 struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
 #ifdef CONFIG_NVME_MULTIPATH
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e4f084e12b966..c8f6ce5eee1c2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -158,8 +158,6 @@ struct nvme_dev {
 	unsigned int nr_allocated_queues;
 	unsigned int nr_write_queues;
 	unsigned int nr_poll_queues;
-
-	bool attrs_added;
 };
 
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
@@ -2234,11 +2232,17 @@ static struct attribute *nvme_pci_attrs[] = {
 	NULL,
 };
 
-static const struct attribute_group nvme_pci_attr_group = {
+static const struct attribute_group nvme_pci_dev_attrs_group = {
 	.attrs		= nvme_pci_attrs,
 	.is_visible	= nvme_pci_attrs_are_visible,
 };
 
+static const struct attribute_group *nvme_pci_dev_attr_groups[] = {
+	&nvme_dev_attrs_group,
+	&nvme_pci_dev_attrs_group,
+	NULL,
+};
+
 /*
  * nirqs is the number of interrupts available for write and read
  * queues. The core already reserved an interrupt for the admin queue.
@@ -2930,10 +2934,6 @@ static void nvme_reset_work(struct work_struct *work)
 		goto out;
 	}
 
-	if (!dev->attrs_added && !sysfs_create_group(&dev->ctrl.device->kobj,
-			&nvme_pci_attr_group))
-		dev->attrs_added = true;
-
 	nvme_start_ctrl(&dev->ctrl);
 	return;
 
@@ -3006,6 +3006,7 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.name			= "pcie",
 	.module			= THIS_MODULE,
 	.flags			= NVME_F_METADATA_SUPPORTED,
+	.dev_attr_groups	= nvme_pci_dev_attr_groups,
 	.reg_read32		= nvme_pci_reg_read32,
 	.reg_write32		= nvme_pci_reg_write32,
 	.reg_read64		= nvme_pci_reg_read64,
@@ -3204,13 +3205,6 @@ static void nvme_shutdown(struct pci_dev *pdev)
 	nvme_disable_prepare_reset(dev, true);
 }
 
-static void nvme_remove_attrs(struct nvme_dev *dev)
-{
-	if (dev->attrs_added)
-		sysfs_remove_group(&dev->ctrl.device->kobj,
-				   &nvme_pci_attr_group);
-}
-
 /*
  * The driver's remove may be called on a device in a partially initialized
  * state. This function must not have any dependencies on the device state in
@@ -3232,7 +3226,6 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_stop_ctrl(&dev->ctrl);
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_dev_disable(dev, true);
-	nvme_remove_attrs(dev);
 	nvme_free_host_mem(dev);
 	nvme_dev_remove_admin(dev);
 	nvme_free_queues(dev, 0);
-- 
2.30.2


