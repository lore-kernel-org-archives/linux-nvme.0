Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED068C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Oct 2022 08:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8i76Ng94LnMG3Ig77NzTzEY78PPjqo0ZR5mFKDUg6g0=; b=4exli1MOFjVh4g7loXZ2GrvpUH
	CjkN0o7DEMnNCQt2kAdZdC2+6U1YEc9zItrSoTxkKRuDxNFFNHeEu2LpVyJ3TEF1ppUwL0lFjsFIX
	nuxcY8OUmajgpmY91EArDmNTIclV1Bux2YHu6MSwynBjpz7YRxfyehcGalH96U6IPG0Qy8VvKyHeT
	vERwjz1SR/lUiD1vIV6AnZXPetDb2I21hERg3V7TeotFSwA6EJoW5WiO9n+JM6S16KuEptZG2P+kI
	N4wffIzAtA/3kcbi4+BXIe8j/dVpRA4kwKN7IOlEBn6rs1B5gT8R1sMwoQVrf5OBgyDYsBh2VeG9P
	2HyfBnjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol4aG-00Gd7B-Jr; Wed, 19 Oct 2022 08:37:52 +0000
Received: from [2001:4bb8:199:ad84:226d:9713:9bab:4481] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ol4aE-00Gd4s-Nw; Wed, 19 Oct 2022 08:37:51 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me,
	fancer.lancer@gmail.com,
	linux@roeck-us.net
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2] nvme-hwmon: consistently ignore errors from nvme_hwmon_init
Date: Wed, 19 Oct 2022 10:37:44 +0200
Message-Id: <20221019083744.993792-1-hch@lst.de>
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

Changes since v1:
 - switch to ignoring the errors in the caller.

 drivers/nvme/host/core.c  |  6 +++++-
 drivers/nvme/host/hwmon.c | 13 ++++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9cbe7854d4883..dc42206005855 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3262,8 +3262,12 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
 		return ret;
 
 	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl)) {
+		/*
+		 * Do not return errors unless we are in a controller reset,
+		 * the controller works perfectly fine without hwmon.
+		 */
 		ret = nvme_hwmon_init(ctrl);
-		if (ret < 0)
+		if (ret == -EINTR)
 			return ret;
 	}
 
diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 0a586d7129201..23918bb7bdca2 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -230,7 +230,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 
 	data = kzalloc(sizeof(*data), GFP_KERNEL);
 	if (!data)
-		return 0;
+		return -ENOMEM;
 
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
@@ -247,11 +246,15 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
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
+	return err;
 }
 
 void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
-- 
2.30.2


