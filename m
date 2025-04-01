Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C0EDC36018
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Apr 2025 10:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Date:Subject:Cc:To:From:Message-ID:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rHnNmt3+i6+Fmmxq3LKb4Rz5gmJ6NIMisYM0ZQcKssA=; b=UpOlEUozQeIIFSOgSMjpYYhfqK
	Hxy7UnFnvX0yoS6P6WHGzTnN4iece57UpYMxBGdD9QS5yYMuNEJW35GcEijRPDNRXAn1Rmd3DU8Gh
	xhHZ0k11E+20WsblKjIq3P6e2LM3qCkktKAcut/rfJF5wNkI9r+YLlkzO+TVKqHEB/JWkpizCh/QT
	3ETahtYw5d7/2mJK4csVzvHo1i3B4ZVk2TltXqoERzR1lBg53QzF3lQL5Qq1fFCVeRiaCKrJJIa/R
	S47m1Gqpi+9y/67ys55y6tyB77Z1fPATimWxosEN0/sYawN/BQsDt3xP/TUgOjp/HjEDryRuYhuiB
	//MyBVig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzYTp-00000002YnC-0mr0;
	Tue, 01 Apr 2025 10:04:25 +0000
Received: from out203-205-221-202.mail.qq.com ([203.205.221.202])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzXts-00000002TRu-1DB1
	for linux-nvme@lists.infradead.org;
	Tue, 01 Apr 2025 09:27:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1743499632; bh=rHnNmt3+i6+Fmmxq3LKb4Rz5gmJ6NIMisYM0ZQcKssA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UJbcK/w5Refba9AB4xii6UX7jeerlyQk8Gf7KZ0Xwaf5my5sU9v9JpJR5Vyg8QFSA
	 DQgWRlVyLn+m1ng5eEofa3Ja4K2Xv0prBeOFrb69Ndsym3YYEfiVYnocQQveilyQZP
	 E2wGr5bQRt7AHysNNyN7gnAf+Y7P43Yjb/EHZBjE=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 6C41646E; Tue, 01 Apr 2025 17:27:04 +0800
X-QQ-mid: xmsmtpt1743499624txlq3fgvi
Message-ID: <tencent_46894AB4C702852846EC72D26C273B817E09@qq.com>
X-QQ-XMAILINFO: NbgegmlEc3JuPn2KFxiEiDoj/jELAQe4blJkXPNJwF33bp2e/1jHKrg4+l/tpb
	 +FNG6swqazzHmsJ7vA8SZ0ez7lULzJc/kX1EqGyjlDD6WLwfenzEv0Tapnn2ZrzmBcL0CJOWnW/c
	 2ZJCGYFTKN7/UgvON1GePZmqSvRXki4jDPsFwvLm0Sk4wOe3giuG/WVfqcQAJGkISXVZknD3nXoC
	 X9qu3L+217VWL88XNpGXOMDx5onruI7ObrzHnGJXF64Wbve4oL1QbcjL9/XkzacxKhY2qQIXJai+
	 NXZGH2q7XQ/DmbAreNQRtr7lN3Io/NH7UNNI7L3/AQdjlLoDwd5jqI4l4x7r61kWR9VR44asJ5Va
	 6W8mjNIaDQcqQxeXy0gaiKM6O7QSCwTOJZk3mfoZmMaCm0zBP8yvubcjSnohY0jW5a0oBQPgltYC
	 0bT0tsL7qVNRDB4UxnXjEfrfajOXX1qJs0SW+icYXNymIkJRh34rXf4swG8ez7hROl96i7lgnPIX
	 Zy6xshhtYLeGsOVZ4HpEDPNB+3ur2H8K7Bx2akuPlTvRglHxL5r2TSWduWz2Ry+n3663aZ9U/eop
	 kqUDjtVmqgG3rWQwsJCfvBOAbGe1kLqjcBV2M7Qd95s/uu7EJlwqbvi/puEFxDKQbPILInN4ZvqV
	 ZplKy7AUoxPjoR/VOW1zsv8Kx64JJe1irFhpBypaHIFJb7BapReEixHPmJpVoSCQUXtouVLLksOh
	 LSBTEbp9VMDrYpHsCQHUJ/Ec9Qc2UODqdID5vIgYuHXZ30b/wlOEurkcM3BxtjlE9GMU12ldDn+8
	 ro1KNzMRPB7tz6wYc4ZacJ/koQGoLYA7cxx2wkALt7DeaTHNEe5EMSlclkGEVAJGJlrMHyfpuN1p
	 t3gtF3YHDRAyb3F761TAdy5Z10XX+lG0Wxd4p33YcUWyux1ws736wVl+EAkIoU7QbYz+8FZtML3b
	 7MHpEodAS1O2JuF3gY+WoX0m1UvP0s83Rzlq5oTfFQEgA/9YEfUQIJRbO1wbrLIkOHdkcMU5/CCn
	 kxv5nYuhsnr12eWbiU
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Yaxiong Tian <iambestgod@qq.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	chaitanyak@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v3 2/3] nvme: add sysfs interface for APST table updates
Date: Tue,  1 Apr 2025 17:27:02 +0800
X-OQ-MSGID: <20250401092702.1558230-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <tencent_4612952C8C5109058CD8E688D81276A2FD0A@qq.com>
References: <tencent_4612952C8C5109058CD8E688D81276A2FD0A@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250401_022716_629467_4628A101 
X-CRM114-Status: GOOD (  18.70  )
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

From: Yaxiong Tian <tianyaxiong@kylinos.cn>

In desktop systems, users can choose between power-saving mode and
performance mode. These two modes involve different trade-offs between
NVMe performance and power efficiency, thus requiring dynamic updates to APST.

Currently, the APST (Autonomous Power State Transition) table can only be
updated during module initialization via module parameters or indirectly
by setting QoS latency requirements. This patch adds a direct sysfs
interface to allow dynamic updates to the APST table at runtime.

The new sysfs entry is created at:
/sys/class/nvme/<controller>/apst_update

This provides more flexibility in power management tuning without
requiring module reload or QoS latency changes.

Example usage:
update nvme module parameters.
echo 1  > /sys/class/nvme/nvme0/apst_update

Signed-off-by: Yaxiong Tian  <tianyaxiong@kylinos.cn>
---
 drivers/nvme/host/core.c  |  9 +++++++--
 drivers/nvme/host/nvme.h  |  2 ++
 drivers/nvme/host/sysfs.c | 24 ++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fb0404fee551..9dea1046b8b4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2654,7 +2654,7 @@ static bool nvme_apst_get_transition_time(u64 total_latency,
  *
  * Users can set ps_max_latency_us to zero to turn off APST.
  */
-static int nvme_configure_apst(struct nvme_ctrl *ctrl)
+int nvme_configure_apst(struct nvme_ctrl *ctrl)
 {
 	struct nvme_feat_auto_pst *table;
 	unsigned apste = 0;
@@ -2778,8 +2778,11 @@ static void nvme_set_latency_tolerance(struct device *dev, s32 val)
 
 	if (ctrl->ps_max_latency_us != latency) {
 		ctrl->ps_max_latency_us = latency;
-		if (nvme_ctrl_state(ctrl) == NVME_CTRL_LIVE)
+		if (nvme_ctrl_state(ctrl) == NVME_CTRL_LIVE) {
+			mutex_lock(&ctrl->apst_lock);
 			nvme_configure_apst(ctrl);
+			mutex_unlock(&ctrl->apst_lock);
+		}
 	}
 }
 
@@ -4852,6 +4855,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->ka_cmd.common.opcode = nvme_admin_keep_alive;
 	ctrl->ka_last_check_time = jiffies;
 
+	mutex_init(&ctrl->apst_lock);
+
 	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
 			PAGE_SIZE);
 	ctrl->discard_page = alloc_page(GFP_KERNEL);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 51e078642127..7f8e10f5bf7a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -385,6 +385,7 @@ struct nvme_ctrl {
 	key_serial_t tls_pskid;
 
 	/* Power saving configuration */
+	struct mutex apst_lock;
 	u64 ps_max_latency_us;
 	bool apst_enabled;
 
@@ -828,6 +829,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
 int nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
+int nvme_configure_apst(struct nvme_ctrl *ctrl);
 
 static inline enum req_op nvme_req_op(struct nvme_command *cmd)
 {
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 6d31226f7a4f..20146eb4c671 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -684,6 +684,29 @@ static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
 	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
 #endif
 
+static ssize_t apst_update_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t size)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	bool bool_data = false;
+	int err;
+
+	err = kstrtobool(buf, &bool_data);
+
+	if (err)
+		return err;
+
+	if (bool_data && nvme_ctrl_state(ctrl) == NVME_CTRL_LIVE) {
+		mutex_lock(&ctrl->apst_lock);
+		nvme_configure_apst(ctrl);
+		mutex_unlock(&ctrl->apst_lock);
+	}
+
+	return size;
+}
+static DEVICE_ATTR_WO(apst_update);
+
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
@@ -712,6 +735,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_dhchap_ctrl_secret.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
+	&dev_attr_apst_update.attr,
 	NULL
 };
 
-- 
2.25.1


