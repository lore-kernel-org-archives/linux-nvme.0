Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFF6C54F4C
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2026 12:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=08TZYCbqGIQFgxaWi3aeV+W4mfKVq6zhCr96lytPW0c=; b=SuXnbU+G0d09YhNHCQ57Ccfd6D
	nD4gT91kaslkNCtu0Ii0y3Yf6uGxpYk9VKkU/8uM/AC4tY7O+sckWfndY/CdRiNp95T+59mgS44he
	mlsXO7m1cn7BUh8MLmIec2LJeDa0JF9FivBHvGvwPJXaYUBALHLGd5kOTgGQDg56wMPR2l426uuX3
	xMtbMtEYKOLjQirz6mjJni5eabrDclINbd8zEjNXI6kk+FqyhRG+18MSDPPWngm5oImGd6PwH1+Ov
	MkNsHCN8dp+DvM7zcH8am+yp7cnzOeUU6XV8vwDHm8Tct4/UXSLcOsaP2qzp6Xv8BjRVVz5s+30mE
	UTEb3IAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wogl4-00000005DX1-1ko6;
	Tue, 28 Jul 2026 12:18:06 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wogl2-00000005DW9-1jn0
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jul 2026 12:18:05 +0000
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-c981c2c37cbso2757445a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2026 05:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785241083; x=1785845883; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=08TZYCbqGIQFgxaWi3aeV+W4mfKVq6zhCr96lytPW0c=;
        b=crquoQ/X2t1V/DNOvY2s+xQQ1THbjL3YPLZ4+YHj0pVsL0dZ6oNu35P1BYTS9bWy9S
         rHebx/D+Hd77B5u6ayGekYuZiLhfqjoRLoTo1zZ8BSHoioOt7CfKnzIv9yvBiDQPvBO4
         8VEpGxnQOCRyBpkTZ6P4XiBr3lX/QK226e2Xh16I71sqC3RtzjPkKW0Ai/SMMDIph6iz
         YTefinGBoXXGIi8E6RzwXhVTlDiMNtBIYUJ7PkLKue3ZX0MVGCN/30zXXdgqdAg0zivW
         hB8O6ghN6MgnDRfOt1mz9rLHB7guy0IH0WH8jhZtjS0kae7Ag/d/oiNHJvszcPxTJGPG
         /xHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785241083; x=1785845883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=08TZYCbqGIQFgxaWi3aeV+W4mfKVq6zhCr96lytPW0c=;
        b=RU9kQdB0Tmf7J8JL3h0mA0ce8sUf4Wvgn2hcYMckruXlVsMj0UK7B2mEwgnvYBkSx3
         +d0nk5HZH3+d4ANvaB+2IsCjovd3W8BunwNx0l7y6PII/OLGIGswRY1dQgo0TS3cfaDW
         0E4h0jdKo23evWLReqf8+/94QCbffErzoUQqrCqFXMhMHoITznyOzuLzioHR+oTjADmn
         oN2STZZP9ylg+vCyFdqVZrdT40rg8vnEX78/QQvjw19SyzncHvJ2C/sPo2ZwP9NsxbR8
         eMPwYTY/vaX6yNGpfHXx/UXaBMX3fvaGPkGfBXWopdnxzRI+zy2l8hMYOS95kZn3p+6U
         tBMg==
X-Gm-Message-State: AOJu0YzIgOF17MrZcJLzI8vPmBRFX8Ip/l2vxqmFqpjBwIUvtqRRgb7q
	/Xj1BJ+1OC3Ywu6SQdk6lW7PeJTg4R3fq7KgbZATaJppE5mgiBdQ65GCEa8NTr/K
X-Gm-Gg: AR+sD13bp4owleMHuLtjLiAm5HacRztRUHYEx31g0x+PPrjvS5zcM0P6HXTkRELvGZD
	aaDKAX3sQJ1fxnhGSfE9sJEICkwVO6pgXUSYwWpbJ2pXX1AH4lH6yitZ33fgJtTwKrEf8KfTfJk
	v9A8S/nr+vFsEDtj9wfx662d2uAMt+Wd/fuUqK+VQR5PqX6lkbo3ik5kG/2KEp/IDCwDB8VQU4W
	TcLXFXcxfzo0FTj8z5IpQK+N23VTsry42mMJ/bSIFFcDrPxGrZiRcHZPVRYJiL1DElG6ZfRGljK
	jcgJV8OjY1ZkYD8OvJ/dyfVmoCMAu7k0hVQBkjnmlgh8VO8mxkSgQPgujOeVu8HSyoNTxxCfbui
	EcuaAZXLZJD9bq+eHhArExg3tOuDXPRUkSQJIxq50cKzDyjcDRnuoHBlYShdpzya94STmkQNju2
	QEYRrq
X-Received: by 2002:a05:6a21:9991:b0:3c3:9c4e:de3a with SMTP id adf61e73a8af0-3c8aaf8d403mr2699113637.6.1785241082932;
        Tue, 28 Jul 2026 05:18:02 -0700 (PDT)
Received: from n232-175-066.byted.org ([240e:83:200::35b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb660daf6sm4478822a12.2.2026.07.28.05.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 05:18:02 -0700 (PDT)
From: guzebing <guzebing1612@gmail.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Guzebing <guzebing@bytedance.com>
Subject: [PATCH v4] nvme: reduce firmware activation poll interval
Date: Tue, 28 Jul 2026 20:17:35 +0800
Message-Id: <20260728121735.1627370-1-guzebing1612@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_051804_471816_DBE7CA8A 
X-CRM114-Status: GOOD (  17.92  )
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

From: Guzebing <guzebing@bytedance.com>

nvme_fw_act_work() polls the controller processing-paused status every
100 ms while firmware activation is pending. Some devices can complete
online activation in only a few hundred milliseconds, so the fixed
100 ms interval can add up to 100 ms of latency before the driver
observes completion.

nvme_wait_ready() already uses a 1 to 2 ms delay between CSTS reads.
Use the same interval in nvme_fw_act_work() and factor the CSTS read,
status check, and sleep loop into a common helper for both paths. For
firmware activation, preserve the existing CC.EN check before testing
CSTS.PP.

Signed-off-by: Guzebing <guzebing@bytedance.com>
---
Changes in v4:
- Move the CSTS read, status check, and sleep loop into a common helper,
  preserving the firmware activation path's CC.EN check before CSTS.PP.

Changes in v3:
- Add a common polling delay helper for nvme_fw_act_work() and
  nvme_wait_ready().

Changes in v2:
- Drop the module parameter and use a fixed 1 to 2 ms poll interval.

v3: https://lore.kernel.org/linux-nvme/20260715114401.1084214-1-guzebing1612@gmail.com/
v2: https://lore.kernel.org/linux-nvme/20260714092846.3381169-1-guzebing1612@gmail.com/
v1: https://lore.kernel.org/linux-nvme/20260627010610.47768-1-guzebing1612@gmail.com/

Note:
The common helper combines the CSTS condition with a
firmware-activation-specific software state condition: the cached CC.EN
value in ctrl_config. This follows the suggestion to share the complete
polling loop, but makes the helper slightly less focused. Would it be
clearer and simpler to keep the loops separate, replace msleep(100) in
nvme_fw_act_work() with usleep_range(1000, 2000), and add a comment that
the interval matches nvme_wait_ready()?

 drivers/nvme/host/core.c | 78 +++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 36 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd09..d6a7e1cbd0e6f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2688,33 +2688,52 @@ const struct block_device_operations nvme_bdev_ops = {
 	.pr_ops		= &nvme_pr_ops,
 };
 
-static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
-		u32 timeout, const char *op)
+/*
+ * Poll CSTS until the requested status is reached.
+ * If exit_if_ctrl_disabled is set, check the cached CC.EN value first and
+ * stop polling when it is cleared.
+ */
+static int nvme_wait_csts(struct nvme_ctrl *ctrl, u32 mask, u32 val,
+			  unsigned long timeout, bool exit_if_ctrl_disabled,
+			  u32 *csts)
 {
-	unsigned long timeout_jiffies = jiffies + timeout * HZ;
-	u32 csts;
 	int ret;
 
-	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts)) == 0) {
-		if (csts == ~0)
+	while ((ret = ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, csts)) == 0) {
+		if (*csts == ~0)
 			return -ENODEV;
-		if ((csts & mask) == val)
-			break;
+		if (exit_if_ctrl_disabled &&
+		    !(ctrl->ctrl_config & NVME_CC_ENABLE))
+			return 0;
+		if ((*csts & mask) == val)
+			return 0;
 
 		usleep_range(1000, 2000);
 		if (fatal_signal_pending(current))
 			return -EINTR;
-		if (time_after(jiffies, timeout_jiffies)) {
-			dev_err(ctrl->device,
-				"Device not ready; aborting %s, CSTS=0x%x\n",
-				op, csts);
-			return -ENODEV;
-		}
+		if (time_after(jiffies, timeout))
+			return -ETIMEDOUT;
 	}
 
 	return ret;
 }
 
+static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
+			   u32 timeout, const char *op)
+{
+	unsigned long timeout_jiffies = jiffies + timeout * HZ;
+	u32 csts;
+	int ret;
+
+	ret = nvme_wait_csts(ctrl, mask, val, timeout_jiffies, false, &csts);
+	if (ret != -ETIMEDOUT)
+		return ret;
+
+	dev_err(ctrl->device,
+		"Device not ready; aborting %s, CSTS=0x%x\n", op, csts);
+	return -ENODEV;
+}
+
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
 	int ret;
@@ -4748,20 +4767,6 @@ static void nvme_async_event_work(struct work_struct *work)
 		ctrl->ops->submit_async_event(ctrl);
 }
 
-static bool nvme_ctrl_pp_status(struct nvme_ctrl *ctrl)
-{
-
-	u32 csts;
-
-	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts))
-		return false;
-
-	if (csts == ~0)
-		return false;
-
-	return ((ctrl->ctrl_config & NVME_CC_ENABLE) && (csts & NVME_CSTS_PP));
-}
-
 static void nvme_get_fw_slot_info(struct nvme_ctrl *ctrl)
 {
 	struct nvme_fw_slot_info_log *log;
@@ -4797,6 +4802,8 @@ static void nvme_fw_act_work(struct work_struct *work)
 	struct nvme_ctrl *ctrl = container_of(work,
 				struct nvme_ctrl, fw_act_work);
 	unsigned long fw_act_timeout;
+	u32 csts;
+	int ret;
 
 	nvme_auth_stop(ctrl);
 
@@ -4806,14 +4813,13 @@ static void nvme_fw_act_work(struct work_struct *work)
 		fw_act_timeout = jiffies + secs_to_jiffies(admin_timeout);
 
 	nvme_quiesce_io_queues(ctrl);
-	while (nvme_ctrl_pp_status(ctrl)) {
-		if (time_after(jiffies, fw_act_timeout)) {
-			dev_warn(ctrl->device,
-				"Fw activation timeout, reset controller\n");
-			nvme_try_sched_reset(ctrl);
-			return;
-		}
-		msleep(100);
+	ret = nvme_wait_csts(ctrl, NVME_CSTS_PP, 0, fw_act_timeout, true,
+			     &csts);
+	if (ret == -ETIMEDOUT) {
+		dev_warn(ctrl->device,
+			 "Fw activation timeout, reset controller\n");
+		nvme_try_sched_reset(ctrl);
+		return;
 	}
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING) ||
-- 
2.20.1

