Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119E2C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 15:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dW4W0x1V7BqJ1AVPrIghH3qmEfAYTJEN5rEyhvukn9I=; b=xCMTeGNhB1PL3WPxd8E4B55wnu
	+GeyGOorqRDXMwjhGD3w3qZi18IqyODjFF1ndz1WZysSRfwgJGEZtpTLCoaAXi2Cj9vMb13F/u73b
	YqnRkXNG8ysmntKkxpEUYD5zi6viI24DivTwH9m9p2TVQs/S9lxxwFNtTT/8KN43Q66bvEA92YIWL
	avSTuTLt0zOLYw7Fl/bi5w+cPUKe0/31wSes1gMMskzxPKOeQUhLqmpCu6sGpNEaD+OzCWes3VK8t
	Sq1oA4tOV80HYPR0HTBheZvgDLDGnkRndVzrv/TM+IYj6fhe/VqmnkpWHxeL4O4olkIER8kAzQLyJ
	E168YHAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okocF-007kD8-UP; Tue, 18 Oct 2022 15:34:51 +0000
Received: from [2001:4bb8:199:ad84:3a05:173d:d0f5:e725] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okoaE-007hzW-5E; Tue, 18 Oct 2022 15:32:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me,
	fancer.lancer@gmail.com,
	linux@roeck-us.net
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-hwmon: consistently ignore errors from nvme_hwmon_init
Date: Tue, 18 Oct 2022 17:32:40 +0200
Message-Id: <20221018153240.687073-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

An NVMe controller works perfectly fine even when the hwmon
initialization fails.  Stop returning errors that do not come from a
controller reset from nvme_hwmon_init to handle this case consistently.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/hwmon.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 0a586d7129201..0a550b82c183d 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -226,11 +226,11 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 	struct device *dev = ctrl->device;
 	struct nvme_hwmon_data *data;
 	struct device *hwmon;
-	int err;
+	int err = 0;
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
-		return 0;
+		goto err;
 
 	data->ctrl = ctrl;
 	mutex_init(&data->read_lock);
@@ -238,8 +238,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 	err = nvme_hwmon_get_smart_log(data);
 	if (err) {
 		dev_warn(dev, "Failed to read smart log (error %d)\n", err);
-		kfree(data);
-		return err;
+		goto err_free_data;
 	}
 
 	hwmon = hwmon_device_register_with_info(dev, "nvme",
@@ -247,11 +246,22 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 						NULL);
 	if (IS_ERR(hwmon)) {
 		dev_warn(dev, "Failed to instantiate hwmon device\n");
-		kfree(data);
-		return PTR_ERR(hwmon);
+		err = PTR_ERR(hwmon);
+		goto err_free_data;
 	}
 	ctrl->hwmon_device = hwmon;
 	return 0;
+
+err_free_data:
+	kfree(data);
+err:
+	/*
+	 * Do not return errors unless we are in a controller reset.
+	 * The controller works perfectly fine without the hwmon registration.
+	 */
+	if (err == -EINTR)
+		return -EINTR;
+	return 0;
 }
 
 void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
-- 
2.30.2


