Return-Path: <SRS0=VC/k=MG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E2CC12002
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Jul 2021 23:39:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3488613C8
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Jul 2021 23:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3488613C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=PQGOmkSfDitZ452DunkYfQw9ug9jaHOvVsx5f5+PDp8=; b=dsZHpP6UXYsurE
	wPTmPWiZmIfCH4ndRWNVfjxxJqxCRCqRm5LjxSQp3WObHN4saUQjisE3eMgh+rkBpzR3Val4zg2iJ
	Bf69Oq1u5XpYgKI9yvP0NAYcumQ2YUVH8BNwmvuu9BevWyTPD+lWkGHT8cjK7Q6p93y0+QYzNJYIp
	YaNlbraBc7cwQ4Bj3OvKmWESWHnZonUDSr3iojSzAtVhM9ndnBcMazj+CE1PdppMFWa7ZP5vur+1h
	a3jrRMFvFO3pd5B7z/QttSmUCrCsf3gQWB4xz5j70ijz9sdbK1odDx745Slohkae0tE4LH6jnrsv9
	PFrE1p9z5KY7VNJhRTkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m3oSj-00GMGq-Pj; Wed, 14 Jul 2021 23:38:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m3m1h-00FF1X-NP
 for linux-nvme@lists.infradead.org; Wed, 14 Jul 2021 21:02:43 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A4316601FA;
 Wed, 14 Jul 2021 21:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626296561;
 bh=SlkwOpVh3LL0F/b+O/+BOLnrMNwMA13sJijLHQM5oYU=;
 h=From:To:Cc:Subject:Date:From;
 b=dmSCy8EwMzuARl+nIGatKYLRk8UoTNqjMqTbGuFQ8GFxZ1KBxmH6nGwR92E2hGvLo
 o4wlGAkpCibfdoqSyEUF3EZPEQpTO7jrgHsRvB+JAToStMDuxKWiqhAdCOKXy1+Dgm
 UeE8MeMk8FTGx3jH+blpKTByYN2jZteZBNWDk5A52OYWxzDw4VfyofsZuRe/rCMO6Q
 FGH8lSgyNAWT7t7XEk3Fr/kHUPU09mnHwQgZhKhsvvI0WFQMwchmU6DVzGogiusDgi
 +KGTTtHDvRswwLhj/rdOWqiK8DIa8qiD8/wM8Famrep58lkwk/cXWminajCbt8NeSE
 KkvkT5aHN+H2Q==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	hch@lst.de
Cc: sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/2] nvme-pci: use attribute group for cmb sysfs
Date: Wed, 14 Jul 2021 14:02:37 -0700
Message-Id: <20210714210238.1837729-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210714_140241_840789_4C3EE8CB 
X-CRM114-Status: GOOD (  17.13  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Appending sysfs files to the controller kobject is a bit clunky and
becomes a maintenance problem as more attributes are added. The
attribute group infrastructure handles this better, so use that.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 75 +++++++++++++++++++++++++++--------------
 1 file changed, 49 insertions(+), 26 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d3c5086673bc..7e816aa8407a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -153,6 +153,8 @@ struct nvme_dev {
 	unsigned int nr_allocated_queues;
 	unsigned int nr_write_queues;
 	unsigned int nr_poll_queues;
+
+	bool attrs_added;
 };
 
 static int io_queue_depth_set(const char *val, const struct kernel_param *kp)
@@ -1781,17 +1783,6 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 	return ret >= 0 ? 0 : ret;
 }
 
-static ssize_t nvme_cmb_show(struct device *dev,
-			     struct device_attribute *attr,
-			     char *buf)
-{
-	struct nvme_dev *ndev = to_nvme_dev(dev_get_drvdata(dev));
-
-	return scnprintf(buf, PAGE_SIZE, "cmbloc : x%08x\ncmbsz  : x%08x\n",
-		       ndev->cmbloc, ndev->cmbsz);
-}
-static DEVICE_ATTR(cmb, S_IRUGO, nvme_cmb_show, NULL);
-
 static u64 nvme_cmb_size_unit(struct nvme_dev *dev)
 {
 	u8 szu = (dev->cmbsz >> NVME_CMBSZ_SZU_SHIFT) & NVME_CMBSZ_SZU_MASK;
@@ -1860,20 +1851,6 @@ static void nvme_map_cmb(struct nvme_dev *dev)
 	if ((dev->cmbsz & (NVME_CMBSZ_WDS | NVME_CMBSZ_RDS)) ==
 			(NVME_CMBSZ_WDS | NVME_CMBSZ_RDS))
 		pci_p2pmem_publish(pdev, true);
-
-	if (sysfs_add_file_to_group(&dev->ctrl.device->kobj,
-				    &dev_attr_cmb.attr, NULL))
-		dev_warn(dev->ctrl.device,
-			 "failed to add sysfs attribute for CMB\n");
-}
-
-static inline void nvme_release_cmb(struct nvme_dev *dev)
-{
-	if (dev->cmb_size) {
-		sysfs_remove_file_from_group(&dev->ctrl.device->kobj,
-					     &dev_attr_cmb.attr, NULL);
-		dev->cmb_size = 0;
-	}
 }
 
 static int nvme_set_host_mem(struct nvme_dev *dev, u32 bits)
@@ -2053,6 +2030,39 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
 	return ret;
 }
 
+static ssize_t cmb_show(struct device *dev,
+			     struct device_attribute *attr,
+			     char *buf)
+{
+	struct nvme_dev *ndev = to_nvme_dev(dev_get_drvdata(dev));
+
+	return sysfs_emit(buf, "cmbloc : x%08x\ncmbsz  : x%08x\n",
+		       ndev->cmbloc, ndev->cmbsz);
+}
+static DEVICE_ATTR_RO(cmb);
+
+static umode_t nvme_pci_attrs_are_visible(struct kobject *kobj,
+		struct attribute *a, int n)
+{
+	struct nvme_dev *dev;
+
+	dev = to_nvme_dev(dev_get_drvdata(container_of(kobj, struct device, kobj)));
+	if (a == &dev_attr_cmb.attr && !dev->cmbsz)
+		return 0;
+
+	return a->mode;
+}
+
+static struct attribute *nvme_pci_attrs[] = {
+	&dev_attr_cmb.attr,
+	NULL,
+};
+
+static const struct attribute_group nvme_pci_attr_group = {
+	.attrs		= nvme_pci_attrs,
+	.is_visible	= nvme_pci_attrs_are_visible,
+};
+
 /*
  * nirqs is the number of interrupts available for write and read
  * queues. The core already reserved an interrupt for the admin queue.
@@ -2699,6 +2709,12 @@ static void nvme_reset_work(struct work_struct *work)
 		goto out;
 	}
 
+	if (!dev->attrs_added) {
+		if (!sysfs_create_group(&dev->ctrl.device->kobj,
+					&nvme_pci_attr_group))
+			dev->attrs_added = true;
+	}
+
 	nvme_start_ctrl(&dev->ctrl);
 	return;
 
@@ -2947,6 +2963,13 @@ static void nvme_shutdown(struct pci_dev *pdev)
 	nvme_disable_prepare_reset(dev, true);
 }
 
+static void nvme_remove_attrs(struct nvme_dev *dev)
+{
+	if (dev->attrs_added)
+		sysfs_remove_group(&dev->ctrl.device->kobj,
+				   &nvme_pci_attr_group);
+}
+
 /*
  * The driver's remove may be called on a device in a partially initialized
  * state. This function must not have any dependencies on the device state in
@@ -2969,7 +2992,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_stop_ctrl(&dev->ctrl);
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_dev_disable(dev, true);
-	nvme_release_cmb(dev);
+	nvme_remove_attrs(dev);
 	nvme_free_host_mem(dev);
 	nvme_dev_remove_admin(dev);
 	nvme_free_queues(dev, 0);
-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
