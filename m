Return-Path: <SRS0=U7CH=C2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EADBEC433E2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 15:50:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78642206B2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 15:50:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hg6nUNnp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QyFjgjb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78642206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cXeVbCnKaju8xJtQOLTSOWvB99dM2u/wRE/A5fDUA1o=; b=hg6nUNnpfyrw0QL1apr7H8ydQf
	eyr+6CYvrwwgX1l0pOaIHuVuXpHMvkHqs+m+Dw/gqn08WCGAyOG/UJxKqYNk1jP1uEfSZ3guUk3Mk
	jcV9ymprsnIrD3YZqlvQr79+y7JlRVbLduTi1cS8ek3J2uqY5+UY9WaOeyNRJF1YpJ/6eF3EMaa6z
	+iLft7ME/e6he0cAEfFkL/PlatqNGWCAwzyYTyOqrcMzHzkJOesrYX1f9PatKAeu8UACVR+x3yV6i
	6apnCvcXH9nDxqtcWFSol2b1TDmlV+sn9gGTaGpMEAE0KosRnipSEXXPlW+5IxMc18/XpSEzYPFqs
	lYkrOkOA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIwB9-0006uv-1H; Thu, 17 Sep 2020 15:50:35 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIwB6-0006uT-Ad
 for linux-nvme@lists.infradead.org; Thu, 17 Sep 2020 15:50:33 +0000
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 48E8B206B5;
 Thu, 17 Sep 2020 15:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600357830;
 bh=AkzMBYXMjct67XXBtgaJ98Oo+7h2dNxMQzwirW8Ukgk=;
 h=From:To:Cc:Subject:Date:From;
 b=QyFjgjb1InLAsPoXM9FZ8uABnKG0W4T/vzrrvqWG0dIXwL1/PhZ0ZKj8yUlleyW4x
 XXhyHchWj77XG0EicM15X/pcoQ6brFVP/GvEWPeDnp2Xf/NwEy18VMrcHw9Qo0BwY/
 tfGU15ZdnpiURSwfi3wcaT9jLBIinhF2oMjBYrPA=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me,
	hch@lst.de
Subject: [PATCH] nvme: return errors for hwmon init
Date: Thu, 17 Sep 2020 08:50:25 -0700
Message-Id: <20200917155025.3795801-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_115032_516686_AC418A3B 
X-CRM114-Status: GOOD (  15.61  )
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
Cc: Keith Busch <kbusch@kernel.org>, Tong Zhang <ztong0001@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Initializing the nvme hwmon retrieves a log from the controller. If the
controller is broken, we need to return the appropriate error so that
subsequent initialization doesn't attempt to continue.

Reported-by: Tong Zhang <ztong0001@gmail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c  |  7 +++++--
 drivers/nvme/host/hwmon.c | 14 ++++++--------
 drivers/nvme/host/nvme.h  |  7 +++++--
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 02acd779666c..55fbb734d500 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3239,8 +3239,11 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	if (ret < 0)
 		return ret;
 
-	if (!ctrl->identified)
-		nvme_hwmon_init(ctrl);
+	if (!ctrl->identified) {
+		ret = nvme_hwmon_init(ctrl);
+		if (ret < 0)
+			return ret;
+	}
 
 	ctrl->identified = true;
 
diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 412a6c97c0d8..552dbc04567b 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -59,12 +59,8 @@ static int nvme_set_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool under,
 
 static int nvme_hwmon_get_smart_log(struct nvme_hwmon_data *data)
 {
-	int ret;
-
-	ret = nvme_get_log(data->ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
+	return nvme_get_log(data->ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
 			   NVME_CSI_NVM, &data->log, sizeof(data->log), 0);
-
-	return ret <= 0 ? ret : -EIO;
 }
 
 static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
@@ -225,7 +221,7 @@ static const struct hwmon_chip_info nvme_hwmon_chip_info = {
 	.info	= nvme_hwmon_info,
 };
 
-void nvme_hwmon_init(struct nvme_ctrl *ctrl)
+int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 {
 	struct device *dev = ctrl->dev;
 	struct nvme_hwmon_data *data;
@@ -234,7 +230,7 @@ void nvme_hwmon_init(struct nvme_ctrl *ctrl)
 
 	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
 	if (!data)
-		return;
+		return 0;
 
 	data->ctrl = ctrl;
 	mutex_init(&data->read_lock);
@@ -244,7 +240,7 @@ void nvme_hwmon_init(struct nvme_ctrl *ctrl)
 		dev_warn(ctrl->device,
 			"Failed to read smart log (error %d)\n", err);
 		devm_kfree(dev, data);
-		return;
+		return err;
 	}
 
 	hwmon = devm_hwmon_device_register_with_info(dev, "nvme", data,
@@ -254,4 +250,6 @@ void nvme_hwmon_init(struct nvme_ctrl *ctrl)
 		dev_warn(dev, "Failed to instantiate hwmon device\n");
 		devm_kfree(dev, data);
 	}
+
+	return 0;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9fd45ff656da..2aaedfa43ed8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -827,9 +827,12 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
 }
 
 #ifdef CONFIG_NVME_HWMON
-void nvme_hwmon_init(struct nvme_ctrl *ctrl);
+int nvme_hwmon_init(struct nvme_ctrl *ctrl);
 #else
-static inline void nvme_hwmon_init(struct nvme_ctrl *ctrl) { }
+static inline int nvme_hwmon_init(struct nvme_ctrl *ctrl)
+{
+	return 0;
+}
 #endif
 
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
