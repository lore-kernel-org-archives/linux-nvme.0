Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93E1C3601E
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 07:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Date:Subject:Cc:To:From:Message-ID:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CQjxyMm42s533cft5gR6e75CqVkywADkjZjFWbmTt8E=; b=s9z1qE7mdEdAzVYdG0iDS615c4
	SCbjJkZChR47bFMdR0Q9CT+Q7s1YJuAlk0CRcS2/GX2ioss0Dh0pZZTMirVh/dkOzmQQ2NkyyvJ1d
	qnBaAdSbkLqD4PYl5T8NmiuVGMy0xH+eDLNGhTqxJCqa3LYuoLToiYd07qCMXgQ7pRulFbXmOi5+Z
	qLu8FkkK9wSiswV9sNfh95iMHTR0h0J1izuFIQCsLEbkjxwaWDIPVAzCy2lRvvWsJbXPSejACGYUG
	VbwpklAMR+LOdQ3NRWlXXTvovlSwWSutfbMRZMlYC9KSrag8NkM06uedZSWmXX7yU5eA7Hi9/2l/2
	wRxvDz4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0F0T-000000086sC-0yIA;
	Thu, 03 Apr 2025 07:28:57 +0000
Received: from out203-205-221-202.mail.qq.com ([203.205.221.202])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0EuY-000000085oJ-351m
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 07:22:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1743664968; bh=CQjxyMm42s533cft5gR6e75CqVkywADkjZjFWbmTt8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=y6vlUpJsdZl4Nvwp8QyaW24Y1OcNmC5hXqh8311PsHQ+hs5MtfQ6SvDH98zdfvBzo
	 mtzsP1ADXVdDHqTHbnD3Dm6nj4PrugNCdJgS1AlxonSmq4xjJ0h220vyzr3wUFvcHY
	 2TiNX9TeGbAWu5esmbrzpM2pjj7QhdnBa5vu3TF4=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrsza36-0.qq.com (NewEsmtp) with SMTP
	id 59A3AEE8; Thu, 03 Apr 2025 15:22:26 +0800
X-QQ-mid: xmsmtpt1743664946t87kxi3vy
Message-ID: <tencent_E1DB827652FCCE94848F4109798FC8E5780A@qq.com>
X-QQ-XMAILINFO: MZtEYADUG4AgKlJdiKWyCWh3m7Uj1elCf2fIuSzZhap9yIAAAEvhMbuMC+TC8Q
	 BFl3AOybv+wVMAk1baX/4zID/N9jA1gUnMKh32v7hgpuySrY8UVVEhH8ZuILPIjh5vXFHkdg2Xkm
	 eh12quqSoKwb05nRx7gtSun9Cnp229yPoq6ACvdm0BhUBT4kxkv9CDmIPtAA2NMVuKO9Rac8TBDy
	 V8iHibelb0QWTetIxXu7TFJN9aF5ZpwlW0odh334+iFLtL7sgzlZflEw7Wkd42SUOeIwrGb2Q2dN
	 9CSTcZZDngyB6Qic21PNRm6AyGg2tXjC73hpennEhYFyYdZ1h+jvAKYJ9Xs7IQjOmZryQ0fgMo8E
	 btpra4Uk0s9kdkgloSS0CkyBUVK03Mx5Ff4ngcuBp/9NUDMt+CwGOZMSKIfz/h5qaWdUDQjsricO
	 A0Hx32jhYjnGkZZUb8+JH60Rs14uPGUsA6KLwfKJY3nLI8kzxGjkk6Su8VYBoqdELF4yJfGBwyFR
	 Xe0zzl6j2q7z/vnT6eshP4gxinQ5GGwVNzNtW/oJPpccsg4P89IRSp02nsvXY/BLkRohuiI5+K+X
	 aOEK7Xo6JZvdvEO32K8ulBOjLzdVaBfsBYxU6sXbpCCmfoCOOJBlGYv2GXQxntBl0nS83CJkc9Jb
	 LASx24Kwx1ZxQxTxMhdaM2eI7zzghIR0aqpA1fMv7fr6t6oPi+lCSW1vBnHEbgmHYxkRNyh0PSyv
	 3G1iNnPrmsuROZAvAjIoV2tiwDm43RgDuuYcxGdrzUYeGZMzHUTKghR123EIZr+UcdI91QlBpJSx
	 0n55wJvEbtidd3VybjETiCEXlfCO3DSFBIQq/Y8npob+uWpJWgv8xw0I+CLFGFZx0GfSt1zrUwz7
	 JJ8C3KSCBvw3PTN6auttkmKfCGz4H62z49sxp0wwrBfDLjssNjj4A8kZfB1eUcPPUXtGUluI0k2u
	 RXpMwUu9U4+wT8i8Q+4K9MxhVbAN0ayjC6UYJimWmVLnh0i5GwnoFabpTCoLESTrmt9vw2hE0KGF
	 6OLdQshA==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Yaxiong Tian <iambestgod@qq.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	chaitanyak@nvidia.com
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v4 3/3] nvme: add per-controller sysfs interface for APST configuration
Date: Thu,  3 Apr 2025 15:22:25 +0800
X-OQ-MSGID: <20250403072225.1209213-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <tencent_A9D89C90E6484E0EBFED4F67D6EF4589F506@qq.com>
References: <tencent_A9D89C90E6484E0EBFED4F67D6EF4589F506@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_002251_092358_D492D8E7 
X-CRM114-Status: GOOD (  16.80  )
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

Currently, APST (Autonomous Power State Transition) parameters are
configured as module parameters affecting all controllers uniformly,
 This lacks flexibility for heterogeneous systems.

This patch introduces per-controller sysfs attributes under each NVMe
controller's sysfs directory:
- apst_primary_timeout_ms
- apst_secondary_timeout_ms
- apst_primary_latency_tol_us
- apst_secondary_latency_tol_us

The attributes allow runtime configuration of: Timeout values for
primary/secondary states.

The existing module parameters are retained for backward compatibility
but now only serve as default values for new controllers.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Yaxiong Tian <tianyaxiong@kylinos.cn>
---
 drivers/nvme/host/core.c  | 16 ++++++++++------
 drivers/nvme/host/nvme.h  |  4 ++++
 drivers/nvme/host/sysfs.c | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 19438da102e5..f6ef73ed88e6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2608,22 +2608,22 @@ static int nvme_configure_host_options(struct nvme_ctrl *ctrl)
  * timeout value is returned and the matching tolerance index (1 or 2) is
  * reported.
  */
-static bool nvme_apst_get_transition_time(u64 total_latency,
+static bool nvme_apst_get_transition_time(struct nvme_ctrl *ctrl, u64 total_latency,
 		u64 *transition_time, unsigned *last_index)
 {
-	if (total_latency <= apst_primary_latency_tol_us) {
+	if (total_latency <= ctrl->apst_primary_latency_tol_us) {
 		if (*last_index == 1)
 			return false;
 		*last_index = 1;
-		*transition_time = apst_primary_timeout_ms;
+		*transition_time = ctrl->apst_primary_timeout_ms;
 		return true;
 	}
 	if (apst_secondary_timeout_ms &&
-		total_latency <= apst_secondary_latency_tol_us) {
+		total_latency <= ctrl->apst_secondary_latency_tol_us) {
 		if (*last_index <= 2)
 			return false;
 		*last_index = 2;
-		*transition_time = apst_secondary_timeout_ms;
+		*transition_time = ctrl->apst_secondary_timeout_ms;
 		return true;
 	}
 	return false;
@@ -2729,7 +2729,7 @@ int nvme_configure_apst(struct nvme_ctrl *ctrl)
 		 * for higher power states.
 		 */
 		if (apst_primary_timeout_ms && apst_primary_latency_tol_us) {
-			if (!nvme_apst_get_transition_time(total_latency_us,
+			if (!nvme_apst_get_transition_time(ctrl, total_latency_us,
 					&transition_ms, &last_lt_index))
 				continue;
 		} else {
@@ -4857,6 +4857,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->ka_last_check_time = jiffies;
 
 	mutex_init(&ctrl->apst_lock);
+	ctrl->apst_primary_timeout_ms = apst_primary_timeout_ms;
+	ctrl->apst_secondary_timeout_ms = apst_secondary_timeout_ms;
+	ctrl->apst_primary_latency_tol_us = apst_primary_latency_tol_us;
+	ctrl->apst_secondary_latency_tol_us = apst_secondary_latency_tol_us;
 
 	BUILD_BUG_ON(NVME_DSM_MAX_RANGES * sizeof(struct nvme_dsm_range) >
 			PAGE_SIZE);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 7f8e10f5bf7a..ed9afc3c6781 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -387,6 +387,10 @@ struct nvme_ctrl {
 	/* Power saving configuration */
 	struct mutex apst_lock;
 	u64 ps_max_latency_us;
+	u64 apst_primary_timeout_ms;
+	u64 apst_secondary_timeout_ms;
+	u64 apst_primary_latency_tol_us;
+	u64 apst_secondary_latency_tol_us;
 	bool apst_enabled;
 
 	/* PCIe only: */
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 20146eb4c671..77912e95aff8 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -684,6 +684,39 @@ static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
 	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
 #endif
 
+#define nvme_apst_show_and_store_function(field)				\
+static ssize_t field##_show(struct device *dev,		\
+			    struct device_attribute *attr, char *buf)	\
+{									\
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);			\
+\
+	return sysfs_emit(buf, "%llu\n", ctrl->field);	\
+}									\
+									\
+static ssize_t field##_store(struct device *dev,		\
+			     struct device_attribute *attr,		\
+			     const char *buf, size_t size)		\
+{									\
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);			\
+	u64 data = 0;					\
+	int err;						\
+\
+	err = kstrtou64(buf, 0, &data);		\
+	if (err < 0)						\
+		return err;						\
+							\
+	mutex_lock(&ctrl->apst_lock);		\
+	ctrl->field = data; 	\
+	mutex_unlock(&ctrl->apst_lock);		\
+	return size;			\
+}									\
+static DEVICE_ATTR_RW(field);
+
+nvme_apst_show_and_store_function(apst_primary_timeout_ms);
+nvme_apst_show_and_store_function(apst_secondary_timeout_ms);
+nvme_apst_show_and_store_function(apst_primary_latency_tol_us);
+nvme_apst_show_and_store_function(apst_secondary_latency_tol_us);
+
 static ssize_t apst_update_store(struct device *dev,
 					      struct device_attribute *attr,
 					      const char *buf, size_t size)
@@ -735,6 +768,11 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_dhchap_ctrl_secret.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
+
+	&dev_attr_apst_primary_timeout_ms.attr,
+	&dev_attr_apst_secondary_timeout_ms.attr,
+	&dev_attr_apst_primary_latency_tol_us.attr,
+	&dev_attr_apst_secondary_latency_tol_us.attr,
 	&dev_attr_apst_update.attr,
 	NULL
 };
-- 
2.25.1


