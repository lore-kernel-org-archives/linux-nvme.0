Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2C2FA373D
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Nov 2022 11:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5NOnZet8QwtWQs4gOFXkN3d918k59qIyVcpXIdMmaVE=; b=O1dtKjkTo8LdkyBfpPPQ0kvUVU
	QSZ1aaSmR0ninBUbQA9Id7E4eanJEYtg/AAgysl3A6mci9U1oakUFwiARBbVFsVFMmDwPYt3VAMjE
	mNDYwkZn2btxegI6iJPQqa/4M/dH4+77N258BKNeXrL87ltTuoVroOyCKffsuQWajT098b39XFRQl
	3SeJ84d5LBWXTmakgTQGDXiqYH3DRDmxwqGwqV0zDEPmCexCkhaH63IkcmpaHV8zs5KgCuxcvfG5j
	R5sV/UV/eiwNo2F+Q72lR3SB16jYU4SfjLOEhGFFz8PhlJWlhDUUMmngBGb9GD/0GF1IK8CoEnyox
	WwhHm+bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oppX7-004eZ3-VU; Tue, 01 Nov 2022 11:34:17 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oppT9-004cHE-86
	for linux-nvme@lists.infradead.org; Tue, 01 Nov 2022 11:30:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id DAE04B81CCF;
	Tue,  1 Nov 2022 11:30:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B570C433C1;
	Tue,  1 Nov 2022 11:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667302208;
	bh=VADL+T6fZwdGh0W4raH+aJgABxlYJhViH1cU4JQ1Fsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IopP+7SdWLGD9COEUihbRs9DdzpJokTCeqyBzKUl4OkLgU0xxCXKqkAXDqNmOyEvg
	 rXWvfls3RGYT95rX9NhsBQysIedG2FLC7ZGbQ2DwAXA69mW2TEENs/VaAcWxq4308c
	 KA25GFRPwNd0DFPeuz71ZVAXM19Gq4frGAPvj6lC5wxdxiM7YquiYGbTLn3ukiKB3g
	 uulqvai+ZQxwqRJyiTswADMI0rYmrhkIbP5cpnbbTu9lHggc8ggcCXdA1fEoSkSmdf
	 0g2Yz8yO3o+iXbIK8JeiH2e9oozawSmgh7QTvcS+U8Eaj5yRFWyhp/cA+MVs4SITHx
	 qWNx2Gr/ALlSw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Guenter Roeck <linux@roeck-us.net>,
	Serge Semin <fancer.lancer@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 18/19] nvme-hwmon: consistently ignore errors from nvme_hwmon_init
Date: Tue,  1 Nov 2022 07:29:18 -0400
Message-Id: <20221101112919.799868-18-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221101112919.799868-1-sashal@kernel.org>
References: <20221101112919.799868-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221101_043011_465759_21C79DDA 
X-CRM114-Status: GOOD (  16.44  )
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 6b8cf94005187952f794c0c4ed3920a1e8accfa3 ]

An NVMe controller works perfectly fine even when the hwmon
initialization fails.  Stop returning errors that do not come from a
controller reset from nvme_hwmon_init to handle this case consistently.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c  |  6 +++++-
 drivers/nvme/host/hwmon.c | 13 ++++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3527a0667568..92fe67bd2457 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3088,8 +3088,12 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
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
index 0a586d712920..23918bb7bdca 100644
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
2.35.1


