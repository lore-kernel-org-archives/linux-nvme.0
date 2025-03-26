Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA43FC36008
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Mar 2025 10:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Date:Subject:Cc:To:From:Message-ID:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CXOxzSBc81SY9jtwgQfdy/KYkhvUkVXESNbfLq9w2L4=; b=QCIbAOArc+MU7gYIscxICY+sAC
	/gQiHr/wele0N8SLINmcj0ov4noLjK+PkIBlZNhj6IKxHeAPMKHFvMj6+PbnADqSNOAe+JgI0OFsq
	FXUAFIWAq/mlTMCIjj5oNzalA5XQ4hBzd+gpLJqTTfJxeV0CSfjGXhjAvMRjN60BkNoAzpzT7OFIk
	mxdwP8LdCY8ZxXW/rRCN4hj7GIlmLDL23z22qOA3zg6lhdtB/zE/RG8/feQSJJnH7MfOlMJ06zuGf
	jKpIecEPCLLLUxUFX8OQmZe9dCqmL//VB9XlLcAB4NS/V7Egq5hA/wQEwmvu35gN6Gi6bpJLptd+F
	JT2PATBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txNop-000000089VP-0z3F;
	Wed, 26 Mar 2025 10:17:07 +0000
Received: from xmbghk7.mail.qq.com ([43.163.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txNom-000000089UZ-23R1
	for linux-nvme@lists.infradead.org;
	Wed, 26 Mar 2025 10:17:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1742984222; bh=CXOxzSBc81SY9jtwgQfdy/KYkhvUkVXESNbfLq9w2L4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b/mlCArKV79gBP+c2XH/etJL9xbn4KfsDoNQTi0P+k0GCXSJ3HoGtp0wJt24UTkQG
	 v02K8qjVJocTdhqxykvq34U1DHzC+zDpsNiY5jzQ2fH65Vr90+ltBmV8hWHRbld+4L
	 hK2w6c+ZLVioxZkMhnDeRZ070hMewvC+/9VnKrNs=
Received: from localhost.localdomain ([116.128.244.169])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id 42821883; Wed, 26 Mar 2025 18:16:40 +0800
X-QQ-mid: xmsmtpt1742984200t5ml4h1h7
Message-ID: <tencent_10273AE37EBF4B64C7988400467673566C09@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9UdRif9mToAQRMObCgm5SPPK0FZCAWaSNErEipKDq/qJrxMW39K
	 Hf48/mxKaoCJI+ntbYnarguqxERydJLbYfn2iYg37vur+LlanSprL/7FNiwLrukYRtcgxIc/Rhhw
	 uGk7jIoUNgb7OL1kqNUG2h9IbubhvEpgykqAi3JViilsu5GqNUeRDZHV4hkUxUcNKsp+l8CVAn1Z
	 ddv6jIAauhLylInwIoWrpLjwVPgj5hixc+QCCsjpV/xO2uAjCouGzFoSXZfrYwvwWYNX5OJUk0rp
	 KHvrrOlOy1iWHNJeSi7vCe8hLibTKjwE8V2dokN20iONZ82aoSJf0VmyYcay2QSd/YLDgHoJHi7+
	 Jrkg6VD2Lxl/raKGTFtxD0LA21cyJaV6nEh7dfZFHGFQrnauQqKdJ/srNaYep/DiL/8iGePdg/jF
	 Bnp+x9f7gc3oGDtJ40CqJ1IX71tCLayXj4wWJ3U8NDuBEMB9W6L7qvOMWuWWCwzdc4T/iKjT1xlW
	 iTp2eEAeVYXhHSLUrnCDRoKmGOObEcVd4Z/oMTZghEWj7bYqRbRDP0X+OED+ldUcOcgMQV0sqDa8
	 Z25CYLprgI64CuZj2AvjGgNfXaI5UpBwuGzfVz06cGZ+vqf89VaK66xqeTalVjdh42o0q+oJkEHu
	 3VRWqi7ZDoO6mmO4d0U75IJYQgds1zhkE9wL5vIaeRBe0WrtGYvSxj850t9KW1qz8hvnGwf0+nml
	 W4i2Z6G1q3nIV1xLU5ZfzU116R2uocPAY9F+3eEeLlJyGLE+xB0foMKW6IBuKbRiq3S+5aLi0pgq
	 dl6MT2f96apYG1CL/MSUoXU2mtEkrFcXBPaN5Azqrvzl73eFwbSe+13rJ4kieHocEca5CZw7BL9G
	 lZxBH05X862IGewuvAQcii6GSzHSDjy3o/Uy0Jl9nbDVQGLi678bOQrndA1p/pGo3cfmN2X+feir
	 RN8KDwxt0JrYlP/XPpCAMdwjGFFG6HE/Pj+vlGyZ0=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Yaxiong Tian <iambestgod@qq.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Yaxiong Tian <tianyaxiong@kylinos.cn>
Subject: [PATCH 2/3] nvme: add sysfs interface for APST table updates
Date: Wed, 26 Mar 2025 18:16:38 +0800
X-OQ-MSGID: <20250326101638.1353393-1-iambestgod@qq.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <tencent_FD614E97ED4F67FE2F74C9C158AB50E7C806@qq.com>
References: <tencent_FD614E97ED4F67FE2F74C9C158AB50E7C806@qq.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250326_031704_840193_57D72394 
X-CRM114-Status: GOOD (  17.13  )
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
 drivers/nvme/host/core.c  |  4 +++-
 drivers/nvme/host/nvme.h  |  2 ++
 drivers/nvme/host/sysfs.c | 23 +++++++++++++++++++++++
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fb0404fee551..cfce433c5553 100644
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
@@ -4852,6 +4852,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
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


