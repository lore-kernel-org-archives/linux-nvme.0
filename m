Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3C4C3600C
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Mar 2025 01:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Date:Subject:Cc:To:From:Message-ID:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aExX0kC5Xf+cB41U+J27cfH1AIdrlolDMYa3emTpxnE=; b=TIccLCfIctVt2FWMiAK43Cf90+
	OoTo9k4Kgy5Vod4y4Fju/wvvBRuxpGfRbzq9Kk9dUv1sH28sNILCDCuSjBcxswF4kmKWiNSdcc79X
	8tUZ9nQRMb1240uNOmtza1HXoJzEp0yvN0x5uX2HLV08KnkFkTB1AIOHF1oCz6lxF1DfwxvLvy497
	nX6BB97EQ3IkY/HviL266s92uNIVqbpb45t+epBhZebhFpG7R04/Aocd9IGvwsGMFlnVRNJAl0KO9
	uWUVdIID4o9isUTAiB4QAIX3tVIxqUojS2h/zsAq9TU7jNuuaNEc4s+e3P7tFbTa5+T8vq3BKjaV/
	jmbAjgKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txyiE-0000000CMEO-3H14;
	Fri, 28 Mar 2025 01:40:46 +0000
Received: from out203-205-221-231.mail.qq.com ([203.205.221.231])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txyiB-0000000CMD1-0zPk
	for linux-nvme@lists.infradead.org;
	Fri, 28 Mar 2025 01:40:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1743126040; bh=aExX0kC5Xf+cB41U+J27cfH1AIdrlolDMYa3emTpxnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LgTVicgmB6ZRisFso4kY1iVhCnVcUC3nGeOqdICaP5pTU2WEF4b2K0tH9E2bu3Nbb
	 coJAoLsRM8s5ajZ4s70XHKwX/p6Yv0DOCJZUXwmGF8l0d72JQQ4YPML9ksmyjflO/k
	 Axjxhio2JBHLL5PE2h2JMhjKUrG7jk/hXaxUvYQQ=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id A20B4A85; Fri, 28 Mar 2025 09:40:32 +0800
X-QQ-mid: xmsmtpt1743126032tok9f6m5q
Message-ID: <tencent_29C768845246A8732C6D233A857EC74B6809@qq.com>
X-QQ-XMAILINFO: OcN56dxiYj5T37Veb2R6Gdm+66ORTSOhPQYHL55Adm1fBVLY0+VtJA5/hPDHYX
	 AdGk9n/rqz5fwOomSbagstJaOJ93dH4C+JN0HtN5/djMqiearbN4PZ83gp3eMdSC8W2aAhxop0YB
	 noxV1Z2XtpVWxP5ysxmh9GLgBPpL7AVf7F4RLh1Ple53gVILzncKWDiSfJhS58JvL8rrsydf2hpK
	 +JlZJSpWpViktMwmEp2FAX/2uwEO9OucbsJTbeiBNkW7MZr7NlLehG76TKrDkzZSUOiujxyuj9e5
	 +p+1NdIdXc6UyVjE9+gqpq9ht0PVLb9IwmC8nUsN+U+yTOcfd1OgL/Z2uDDP0ZdK6i+JZfqMJ+CG
	 K6QEqDoduJJKGyRWDsSxvijBk+tBmKve8rI4hmO2ReHkqK37LYTYAZubJv4/9z7hM6AVIsapoIru
	 wrl+WytjY0RfQEWxkUA6UkUY463K3q41W4fCbA2ctJFBMtEpYufFj8o40Jjay0qtRZFbZQo6t4XB
	 XNastaNWjNiVAJrskTtmUbkB51KU0QXFwYPc3GFWKKnrvYyYYWLkvOJpTiaktIrNM+8H552PsdLB
	 oGnwkLgN8RYpFWP1u9zUw3HGzlQRIkoZRkwxpnZdeks1+QS3D1VjNA/QPH70R8kwo+Bl7qdnJw/5
	 IeqVUoJwDZ74cJ8wJrsydw/JrgYqipj6j6H5KM9NctJG/VvQ6a3/oQQ7SgNcndmX1d+Rd358Wmwr
	 Y/rndW2WcdyUro+iJQz7ArxaRExHk9mr+MwL0ud+JiQY38m4ZJSAHD2MUPOIYdHYf+OjdRV0qhaA
	 H7td1McW+FVYQSU+PPvBVA31suj0ylPwzVJ2CKUwZzpedc2j92Fs9j7+BCeRr3jQ/hNoholKXPPZ
	 vC7zL72CMBkw13bFu+wEEGee3a+3S8WIEHa3UPJLYV7dR4oJZ6uqXn4TcOhdFVzYSeuVqV8n0WTR
	 2RsJSZ8BbnDkWbkEjyD1ykfT+ziQRti3rZ8of/p/yz2ceM6mFSopVee00JlfL0
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Yaxiong Tian <iambestgod@qq.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH v2 2/3] nvme: add sysfs interface for APST table updates
Date: Fri, 28 Mar 2025 09:40:31 +0800
X-OQ-MSGID: <20250328014031.94959-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <tencent_4A5421BA11BD9C5B5BF3CEA95FD212AB3107@qq.com>
References: <tencent_4A5421BA11BD9C5B5BF3CEA95FD212AB3107@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250327_184043_578799_80861857 
X-CRM114-Status: GOOD (  17.43  )
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
 drivers/nvme/host/sysfs.c | 23 +++++++++++++++++++++++
 3 files changed, 32 insertions(+), 2 deletions(-)

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
index 6d31226f7a4f..5003cb294d65 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -684,6 +684,28 @@ static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
 	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
 #endif
 
+static ssize_t apst_update_store(struct device *dev,
+					      struct device_attribute *attr,
+					      const char *buf, size_t size)
+{
+	int err;
+	bool bool_data = false;
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
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
@@ -712,6 +734,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_dhchap_ctrl_secret.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
+	&dev_attr_apst_update.attr,
 	NULL
 };
 
-- 
2.25.1


