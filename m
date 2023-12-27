Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD65C46CD4
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Dec 2023 09:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zXgyGz4/8FLzx55uT/czGUK7Bhkbnsymvz2iy8LgpaE=; b=41pUKUqImzzaq4CU0GArvmnbJZ
	rUk6bTVrejJ327J6+HeVrpeeCZQo2+0Xys2zomF1kDea3XSXVeoM1pZxw2r26IEJNlqyFtFU1oohz
	Z30tNs+AnOYgy+BUIGNIqNaL30HK1k5/H6zNHndOKN6U+xEubwzemgVLuu1hZK3G4FNqEhg0Ycefv
	MmS72qDo4k+EpmtlWKIynFEnBPYXRwF1Wp5pw2xhuvj0ZdBncx+xlzHSwjZIuRxsxMU2qa44I9hS3
	eE1V2bfD45/k2TGC1ewBi26tURpyuDlyvXkfenLhtpGG1dkgjCncFxuzF1QBkp4g6rTC63fColgfr
	BNCHCm5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIPrD-00EGQQ-0z;
	Wed, 27 Dec 2023 09:05:43 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rIPr7-00EGOr-1V
	for linux-nvme@lists.infradead.org;
	Wed, 27 Dec 2023 09:05:39 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VzKYjnV_1703667925;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VzKYjnV_1703667925)
          by smtp.aliyun-inc.com;
          Wed, 27 Dec 2023 17:05:32 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH V2] nvme: introduce nvme_disk_is_ns_head helper
Date: Wed, 27 Dec 2023 17:05:25 +0800
Message-ID: <20231227090525.26662-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231227_010537_644376_8B4ED4DB 
X-CRM114-Status: GOOD (  12.54  )
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

We currently rely on gendisk's file operations (fops) to distinguish
between a namespace head (ns_head) and a regular namespace. To enhance
code readability, introduce a helper function.
Additionally, we must ensure that the device is not an ns_head before
calling nvme_get_ns_from_dev(). To enforce this, add a WARN_ON check
within the nvme_get_ns_from_dev().

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
Changes from v1 to v2:
- change helper name from nvme_gendisk_is_ns_head to
  nvme_disk_is_ns_head.
- remove redundant comment.

 drivers/nvme/host/nvme.h  | 12 +++++++++++-
 drivers/nvme/host/pr.c    |  2 +-
 drivers/nvme/host/sysfs.c |  9 +++++----
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e7411dac00f7..ceddf01b2d66 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1029,9 +1029,19 @@ static inline int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 }
 #endif
 
+static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
+{
+	if (disk->fops == &nvme_ns_head_ops)
+		return true;
+	return false;
+}
+
 static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
 {
-	return dev_to_disk(dev)->private_data;
+	struct gendisk *disk = dev_to_disk(dev);
+
+	WARN_ON(nvme_disk_is_ns_head(disk));
+	return disk->private_data;
 }
 
 #ifdef CONFIG_NVME_HWMON
diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index 391b1465ebfd..fc3eed00f9ff 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -98,7 +98,7 @@ static int nvme_send_pr_command(struct block_device *bdev,
 		struct nvme_command *c, void *data, unsigned int data_len)
 {
 	if (IS_ENABLED(CONFIG_NVME_MULTIPATH) &&
-	    bdev->bd_disk->fops == &nvme_ns_head_ops)
+	    nvme_disk_is_ns_head(bdev->bd_disk))
 		return nvme_send_ns_head_pr_command(bdev, c, data, data_len);
 
 	return nvme_send_ns_pr_command(bdev->bd_disk->private_data, c, data,
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index c6b7fbd4d34d..925042ca728b 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -39,10 +39,10 @@ static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
-	if (disk->fops == &nvme_bdev_ops)
-		return nvme_get_ns_from_dev(dev)->head;
-	else
+	if (nvme_disk_is_ns_head(disk))
 		return disk->private_data;
+	else
+		return nvme_get_ns_from_dev(dev)->head;
 }
 
 static ssize_t wwid_show(struct device *dev, struct device_attribute *attr,
@@ -148,7 +148,8 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 	}
 #ifdef CONFIG_NVME_MULTIPATH
 	if (a == &dev_attr_ana_grpid.attr || a == &dev_attr_ana_state.attr) {
-		if (dev_to_disk(dev)->fops != &nvme_bdev_ops) /* per-path attr */
+		/* per-path attr */
+		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
 			return 0;
 		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
 			return 0;
-- 
2.43.0


