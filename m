Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B1E8C4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 14:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UBGA1w63pnkdtsxBvIfkp5Jh6YgAdvLaSyjmIuAZI+U=; b=q4/ZlewRXZlu1b47uRGxl6YP5W
	ZUjHZy38rRHtBTa2dEkGW5C2iEk35Z3SSA7BZXoTtG61+uulxp7oRc08yXoQELLoCE5Xt7swPRBP+
	9o0wfp8OVHazzKskDYasSeoJFsfNs4yCxfLnjuFCCF8E6KRPTzl0t4T7fgh2RmH09OKqRDCd/0rIP
	2UltbgZxUo7Jn20H4ncfe2GjzWJB6SUXcdcnjFeKapXr5bSbkywaewL5B3RFYrMIbpQCBX0AQwZSs
	+a5IqYew1ywHnbPNWmXY6UqYyeoIWsfFnUOnutnfKPnQ6RplybCxdqEFVUIP2qzNOvYLXYKb+yQ0i
	ArF9AzDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oko2r-007PQi-Qa; Tue, 18 Oct 2022 14:58:17 +0000
Received: from [2001:4bb8:199:ad84:3a05:173d:d0f5:e725] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oko2p-007PPw-9l; Tue, 18 Oct 2022 14:58:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me,
	fancer.lancer@gmail.com,
	linux@roeck-us.net
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-hwmon: don't return errors from nvme_hwmon_init
Date: Tue, 18 Oct 2022 16:58:08 +0200
Message-Id: <20221018145808.681327-1-hch@lst.de>
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
initialization fails.  Stop returning errors from nvme_hwmon_init to
handle this case consistently.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

This should go before the patch from Serge to document and consistently
handle the lack of initialization failure handling for hwmon.

 drivers/nvme/host/core.c  |  7 ++-----
 drivers/nvme/host/hwmon.c | 16 +++++++++-------
 drivers/nvme/host/nvme.h  |  5 ++---
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9cbe7854d4883..952768966bdcd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3261,11 +3261,8 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
 	if (ret < 0)
 		return ret;
 
-	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl)) {
-		ret = nvme_hwmon_init(ctrl);
-		if (ret < 0)
-			return ret;
-	}
+	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl))
+		nvme_hwmon_init(ctrl);
 
 	ctrl->identified = true;
 
diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 0a586d7129201..c6ddb8b46c699 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -221,7 +221,8 @@ static const struct hwmon_chip_info nvme_hwmon_chip_info = {
 	.info	= nvme_hwmon_info,
 };
 
-int nvme_hwmon_init(struct nvme_ctrl *ctrl)
+/* do not return errors - nvme works fine without hwmon registration */
+void nvme_hwmon_init(struct nvme_ctrl *ctrl)
 {
 	struct device *dev = ctrl->device;
 	struct nvme_hwmon_data *data;
@@ -230,7 +231,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
-		return 0;
+		return;
 
 	data->ctrl = ctrl;
 	mutex_init(&data->read_lock);
@@ -238,8 +239,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 	err = nvme_hwmon_get_smart_log(data);
 	if (err) {
 		dev_warn(dev, "Failed to read smart log (error %d)\n", err);
-		kfree(data);
-		return err;
+		goto out_free_data;
 	}
 
 	hwmon = hwmon_device_register_with_info(dev, "nvme",
@@ -247,11 +247,13 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 						NULL);
 	if (IS_ERR(hwmon)) {
 		dev_warn(dev, "Failed to instantiate hwmon device\n");
-		kfree(data);
-		return PTR_ERR(hwmon);
+		goto out_free_data;
 	}
 	ctrl->hwmon_device = hwmon;
-	return 0;
+	return;
+
+out_free_data:
+	kfree(data);
 }
 
 void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a29877217ee65..4cd3e00c47a2b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1000,12 +1000,11 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
 }
 
 #ifdef CONFIG_NVME_HWMON
-int nvme_hwmon_init(struct nvme_ctrl *ctrl);
+void nvme_hwmon_init(struct nvme_ctrl *ctrl);
 void nvme_hwmon_exit(struct nvme_ctrl *ctrl);
 #else
-static inline int nvme_hwmon_init(struct nvme_ctrl *ctrl)
+static inline void nvme_hwmon_init(struct nvme_ctrl *ctrl)
 {
-	return 0;
 }
 
 static inline void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
-- 
2.30.2


