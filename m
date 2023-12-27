Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C323C46CD4
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Dec 2023 07:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dH1YnKgUnqqpZjXaUXTdyQk2VTgSUnt2NJvR323YCGw=; b=yODfj+IRPJEWdjYyXYVyS6T1YY
	D7r9+zH8a4znjjq3PMpFo4tHcWwJDGDMAlaT4YWS2dWCohrN4j/ma8c7dHGqJdMfmensLSzGcSLXI
	LZ/7vqj4b2ZFVJBVpx82dZ/Se/+Jnb+eB8dMnOjHVX+OFc5hA1/fnQ/NTkJI93b59Yz6mWol3EGBT
	cw/wrYvwUsXszKEPJOvXiM3xtMu04h8npIW6FLm+G/GZaQvOOsRuZ1NLT2PQeRlJdffKhv7HjOHdX
	gsN+LqUq2QrKIatV4WGiJ5uvMs737aggAzISXZDbCyFduSQuaEv2j1LBL7So1ffmqorZYRGq2ZisB
	iabDZTTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIOgA-00EAx4-0E;
	Wed, 27 Dec 2023 07:50:14 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rIOg7-00EAwT-1i
	for linux-nvme@lists.infradead.org;
	Wed, 27 Dec 2023 07:50:12 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VzKLPwt_1703663399;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0VzKLPwt_1703663399)
          by smtp.aliyun-inc.com;
          Wed, 27 Dec 2023 15:50:04 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: introduce nvme_gendisk_is_ns_head helper
Date: Wed, 27 Dec 2023 15:49:59 +0800
Message-ID: <20231227074959.4246-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231226_235011_734110_7B82AE82 
X-CRM114-Status: GOOD (  11.93  )
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
 drivers/nvme/host/nvme.h  | 13 ++++++++++++-
 drivers/nvme/host/pr.c    |  2 +-
 drivers/nvme/host/sysfs.c |  9 +++++----
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e7411dac00f7..9b8ecac32cc0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1029,9 +1029,20 @@ static inline int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 }
 #endif
 
+/* Use gendisk's fops to distinguish ns_head from ns */
+static inline bool nvme_gendisk_is_ns_head(struct gendisk *disk)
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
+	WARN_ON(nvme_gendisk_is_ns_head(disk));
+	return disk->private_data;
 }
 
 #ifdef CONFIG_NVME_HWMON
diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index 391b1465ebfd..744d4bf959e3 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -98,7 +98,7 @@ static int nvme_send_pr_command(struct block_device *bdev,
 		struct nvme_command *c, void *data, unsigned int data_len)
 {
 	if (IS_ENABLED(CONFIG_NVME_MULTIPATH) &&
-	    bdev->bd_disk->fops == &nvme_ns_head_ops)
+	    nvme_gendisk_is_ns_head(bdev->bd_disk))
 		return nvme_send_ns_head_pr_command(bdev, c, data, data_len);
 
 	return nvme_send_ns_pr_command(bdev->bd_disk->private_data, c, data,
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index c6b7fbd4d34d..6d2ff19d54dc 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -39,10 +39,10 @@ static inline struct nvme_ns_head *dev_to_ns_head(struct device *dev)
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
-	if (disk->fops == &nvme_bdev_ops)
-		return nvme_get_ns_from_dev(dev)->head;
-	else
+	if (nvme_gendisk_is_ns_head(disk))
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
+		if (nvme_gendisk_is_ns_head(dev_to_disk(dev)))
 			return 0;
 		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
 			return 0;
-- 
2.43.0


