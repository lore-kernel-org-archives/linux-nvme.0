Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1E1C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 20:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pFE90n5MyELBH4c37ZN7/rXstYc+YP7GnIgiGCcWkow=; b=KAc3yHa5fgyaoWhyW3MRWHt66B
	w80lLFa7aAe5DO+yS0Dl52ywdLEmC6eptgfb5sM6agcecOkZbL26nVzKpPpQ209l9KqTiHIg/98LU
	sodAHErIkTjF6r6/CuYo0D/1Xn9Z6Q+VocOKqQsCE/nFHqJMzOyqJTMdYewnlrWw1xI1UwGgnVqX9
	4x+GTVzZCwJhLaZ/DhAjlwse+hfXM0xfBkQnjdYsAiD/aFvHf6OIVU+GtXnp4sqoJpGeQA745i8YD
	NFUT1/QxT19TDuFI5NN5J+s7Wpptetp9wReT1rFL0Z15xu/wz9HtPr1FujqSIdrePDG6ndjyZmSAl
	ZyKKVaWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjNMu-0000000AOco-2Jzu;
	Mon, 13 Jul 2026 20:35:12 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjNMs-0000000AOcL-1lCL
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 20:35:11 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-845c92bc464so289171b3a.2
        for <linux-nvme@lists.infradead.org>; Mon, 13 Jul 2026 13:35:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783974908; x=1784579708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pFE90n5MyELBH4c37ZN7/rXstYc+YP7GnIgiGCcWkow=;
        b=Wb4SnGTaAjHV3SbF+axKViHuh8z5q5qlwTDeqDTBHNdDXwiIGRt+GF7FJhXqxDaavB
         TkIHJIM8venIE71A1RLJWDBOlbagQd1poHRjgyIPwoF5XCgBGqf/Myzd8D1dt4xaSY0g
         lJqHR/rsICegk0YtAJoIUudaQuRgX3DqaAIcrFWDi02FRQuHRbBOdx1dGHSvDED3ovCf
         nYViOAlfOC8qTPfRFVJgMWu9iMIaQXlr5rGfJk8/Ow8ZkEAadle7u8qJQjEnRR+W9lDv
         jUzdMxlqDeaasQE53kEtIs0gXGPdTCrEE1xwzv2p23xXMSGMEPgaPKAmLUUZgRQVnpYx
         2sVA==
X-Gm-Message-State: AOJu0YzMg/rmJE18RLwGY4vtHdXicdPpF4E5Rhx9x+BbfV29hjbZpoNk
	F0qK9r3CDVqGVxmC6CXo+GeRFh5mA1DERYZjwLgcX56Zr80Y2wgUmC65mBPx5vm0
X-Gm-Gg: AfdE7ckM7HczmCgbttpxBHlvs9N/4yHfcg8GrbjYB0hxv3sZZ4IVsv6dxTfTtRJFfUc
	kSELDgHR3pWHyTMAChrGSUu4VizPl9DH3ZDpOwWRqkiUD2Xrt7z7EDfL0nt96q5rbOKVBVgKE+H
	l5xNfUysshpWzbvSM6gCMCKBsmHI60THCHpcqQU7Ltxmo4GrjqibpuffRHq14wJoYA/DncVs5rL
	kmWgTgcmj9Yn86bn20UUVM0VQQtj1/Ew2ij44UKaHyAF7/Ds9uGg1PDNLu+naeB25heQQH8823C
	CjPfDTkBsMPmOHxx+/g8UxbQDLuiswvZk16IObI4NxbefMlQq9OB8J278IbAqIUWxlDZrCmhQbi
	virdW3MutlQyTx+HdrKa0Yhb+ha4UMZ2pyIcBtpkFoGENZSQQV1OSBLbAkTSpJZqkGxLGGVyXZg
	2K70LK9lz5LfkGhbPjawFV1+npN54SgLo7zSzXwFsasQeSidICTsWOEQpn8eZKXABjjlZxjl0R3
	7UpreIwo84T9dhSLLZNpzCWFXvZjQ==
X-Received: by 2002:a05:6a21:140a:b0:3c0:9c19:b27d with SMTP id adf61e73a8af0-3c110cfefa5mr11289519637.75.1783974907685;
        Mon, 13 Jul 2026 13:35:07 -0700 (PDT)
Received: from dancol.org (dancol.org. [2600:3c01:e000:3d8::1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174839f89sm73242716eec.10.2026.07.13.13.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 13:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dancol.org;
	s=x; h=MIME-Version:Message-ID:Date:Subject:To:From:Content-Type;
	bh=pFE90n5MyELBH4c37ZN7/rXstYc+YP7GnIgiGCcWkow=; b=F6zY5rgGB1exwn3WQgxTIAFDsa
	D14eHj/MfIMyC1Ht71sRsuz5tmMlTpDAzvMXIW9SBKvuG9NztwPUYjngA2omUOFpWCp9Vc6iLJsFm
	6wC1BUVlHGOXkVXlBXl/zt/7NefMJGM0owL7ZeOsRcpgJI5g/R2zS2SaJQBudl/sJAC2jiUDeae1N
	uNw3AEmrUOelfYAeBE6/w5eCsgqe12yl6k7ezKBmjA86YdwTOsSGzbLnfR7i4A+U7oL8/PXBaqHaW
	GF8AYVbEYoGGjjQ27XqpB3cOJBH6eQ9yLWtr9vBIbT3p088/HT8HBDnvDvqwfn+0aKaRPBvPLt86w
	VHRf+W+g==;
Received: from dancol by dancol.org with local (Exim 4.98.2)
	(envelope-from <dancol@dancol.org>)
	id 1wjNMn-00000000VJg-3rkE;
	Mon, 13 Jul 2026 16:35:05 -0400
From: Daniel Colascione <dancol@dancol.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Colascione <dancol@dancol.org>
Subject: [PATCH] nvme: make sending wall-clock time to NVMe opt-in
Date: Mon, 13 Jul 2026 16:34:43 -0400
Message-ID: <20260713203443.322748-1-dancol@dancol.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_133510_508278_2FBB9ECA 
X-CRM114-Status: GOOD (  29.64  )
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

Some NVMe devices maintain a persistent log, the PEL, of events like
power-on and thermal excursions. The NVMe Set Features (Timestamp)
command allows an operating system to inform the NVMe of the current
wall-clock time. Wall-clock timestamp updates are logged to the PEL
alongside other events. By correlating PEL records, an attacker can
infer a user's usage patterns and even guess at time zone changes.

This change adds a per-controller NVMe flag accessible via sysfs that
controls whether we send the device the time. The flag is always present
and does nothing if the Timestamp feature is not supported. We update
the NVMe device's wall-clock time during controller initialization (if
the flag is enabled) and whenever the flag transitions from 0 to 1 on a
live controller. The flag latches the requested value. Sending the
timestamp to the device is best-effort and warns on every failure.

The nvme_core.timestamps_enabled_default module parameter supplies the
default value of the per-controller flag. Default it to false as the
privacy-preserving choice. Users who want to provide controllers with
real-world time can set the module parameter to true or enable
the per-controller sysfs flag, perhaps via udev.

As an alternative, we could also get the timestamp updates out of the
kernel entirely and have interested users run nvme(1) to
update timestamps.

Signed-off-by: Daniel Colascione <dancol@dancol.org>
---
 Documentation/ABI/testing/sysfs-nvme | 21 ++++++++++++++++++
 MAINTAINERS                          |  2 +-
 drivers/nvme/host/core.c             | 22 +++++++++++--------
 drivers/nvme/host/nvme.h             |  2 ++
 drivers/nvme/host/sysfs.c            | 32 ++++++++++++++++++++++++++++
 5 files changed, 69 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-nvme

diff --git a/Documentation/ABI/testing/sysfs-nvme b/Documentation/ABI/testing/sysfs-nvme
new file mode 100644
index 0000000000000..bb98974f22b7f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-nvme
@@ -0,0 +1,21 @@
+What:		/sys/class/nvme/nvmeX/timestamps_enabled
+Date:		July 2026
+KernelVersion:	7.3
+Contact:	Linux NVMe mailing list <linux-nvme@lists.infradead.org>
+Description:
+		Shows or sets whether the kernel sends wall-clock time to the
+		controller using the NVMe Timestamp feature. Reading returns 1
+		(enabled) or 0 (disabled). Writing accepts a boolean value. The
+		attribute is present for every controller. On controllers that
+		do not support the Timestamp feature, the setting has no effect.
+
+		The per-controller value is initialized from
+		nvme_core.timestamps_enabled_default, which defaults to false. When
+		enabled, the kernel sends a timestamp whenever the controller
+		starts, including on controller resets and resume from suspend.
+		Changing the value from 0 to 1 on a live controller
+		sends a timestamp immediately. Disabling does not affect a
+		timestamp already sent.
+
+		Writes latch the requested value. Sending timestamps to the
+		controller is best-effort; every failure generates a warning.
diff --git a/MAINTAINERS b/MAINTAINERS
index 5bbc5b49d36a3..c6f46a4e8dd37 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19207,7 +19207,7 @@ L:	linux-nvme@lists.infradead.org
 S:	Supported
 W:	http://git.infradead.org/nvme.git
 T:	git git://git.infradead.org/nvme.git
-F:	Documentation/ABI/stable/sysfs-nvme
+F:	Documentation/ABI/*/sysfs-nvme
 F:	Documentation/admin-guide/nvme-multipath.rst
 F:	Documentation/fault-injection/nvme-fault-injection.rst
 F:	Documentation/nvme/
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index db0c8ad4628a7..a49f71563e112 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -71,6 +71,11 @@ module_param(default_ps_max_latency_us, ulong, 0644);
 MODULE_PARM_DESC(default_ps_max_latency_us,
 		 "max power saving latency for new devices; use PM QOS to change per device");
 
+static bool timestamps_enabled_default;
+module_param(timestamps_enabled_default, bool, 0644);
+MODULE_PARM_DESC(timestamps_enabled_default,
+		 "default value of the per-controller timestamps_enabled sysfs attribute");
+
 static bool force_apst;
 module_param(force_apst, bool, 0644);
 MODULE_PARM_DESC(force_apst, "allow APST for newly enumerated devices even if quirked off");
@@ -2824,21 +2829,21 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_enable_ctrl);
 
-static int nvme_configure_timestamp(struct nvme_ctrl *ctrl)
+void nvme_configure_timestamp(struct nvme_ctrl *ctrl)
 {
 	__le64 ts;
 	int ret;
 
-	if (!(ctrl->oncs & NVME_CTRL_ONCS_TIMESTAMP))
-		return 0;
+	if (!READ_ONCE(ctrl->timestamps_enabled) ||
+	    !(ctrl->oncs & NVME_CTRL_ONCS_TIMESTAMP))
+		return;
 
 	ts = cpu_to_le64(ktime_to_ms(ktime_get_real()));
 	ret = nvme_set_features(ctrl, NVME_FEAT_TIMESTAMP, 0, &ts, sizeof(ts),
 			NULL);
 	if (ret)
-		dev_warn_once(ctrl->device,
-			"could not set timestamp (%d)\n", ret);
-	return ret;
+		dev_warn(ctrl->device,
+			 "could not set timestamp (%d)\n", ret);
 }
 
 static int nvme_configure_host_options(struct nvme_ctrl *ctrl)
@@ -3771,9 +3776,7 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
 	if (ret < 0)
 		return ret;
 
-	ret = nvme_configure_timestamp(ctrl);
-	if (ret < 0)
-		return ret;
+	nvme_configure_timestamp(ctrl);
 
 	ret = nvme_configure_host_options(ctrl);
 	if (ret < 0)
@@ -5168,6 +5171,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	WRITE_ONCE(ctrl->state, NVME_CTRL_NEW);
 	ctrl->passthru_err_log_enabled = false;
+	ctrl->timestamps_enabled = READ_ONCE(timestamps_enabled_default);
 	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
 	mutex_init(&ctrl->namespaces_lock);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a679a4c61462d..47f7d6e7c5438 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -335,6 +335,7 @@ struct nvme_ctrl {
 	bool comp_seen;
 	bool identified;
 	bool passthru_err_log_enabled;
+	bool timestamps_enabled;
 	enum nvme_ctrl_state state;
 	spinlock_t lock;
 	struct mutex scan_lock;
@@ -891,6 +892,7 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
 void nvme_start_ctrl(struct nvme_ctrl *ctrl);
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended);
+void nvme_configure_timestamp(struct nvme_ctrl *ctrl);
 int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 		const struct blk_mq_ops *ops, unsigned int cmd_size);
 void nvme_remove_admin_tag_set(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index abf8edaae371b..fe62747630014 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -36,6 +36,37 @@ static ssize_t nvme_sysfs_rescan(struct device *dev,
 }
 static DEVICE_ATTR(rescan_controller, S_IWUSR, NULL, nvme_sysfs_rescan);
 
+static ssize_t timestamps_enabled_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", READ_ONCE(ctrl->timestamps_enabled));
+}
+
+static ssize_t timestamps_enabled_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	bool enabled, was_enabled;
+	int ret;
+
+	ret = kstrtobool(buf, &enabled);
+	if (ret)
+		return ret;
+
+	was_enabled = READ_ONCE(ctrl->timestamps_enabled);
+	WRITE_ONCE(ctrl->timestamps_enabled, enabled);
+
+	if (enabled && !was_enabled &&
+	    nvme_ctrl_state(ctrl) == NVME_CTRL_LIVE)
+		nvme_configure_timestamp(ctrl);
+
+	return count;
+}
+static DEVICE_ATTR_RW(timestamps_enabled);
+
 static ssize_t nvme_adm_passthru_err_log_enabled_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
@@ -929,6 +960,7 @@ static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
+	&dev_attr_timestamps_enabled.attr,
 	&dev_attr_model.attr,
 	&dev_attr_serial.attr,
 	&dev_attr_firmware_rev.attr,

base-commit: cdf9a65e80ec874b630502946d269fac38dc5de8
-- 
2.53.0


