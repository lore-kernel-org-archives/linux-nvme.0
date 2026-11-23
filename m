Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50280606A31E
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 11:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=P+4yA2ow;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=N4d5ceNl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=MNS9VVEkFGiFVZsN7KcZGKqfIByh9CnFOKxk5UqKT2I=; b=P+4yA2owURDCi1
	pXBdTWD+69tk+QvLB4BcW113zfFDWBDlSfpwcgLGgL5hcZT3AV+G9EBQRG9r47LI4ZjXKeLoXf49+
	3tMrBo+PxAQ7xVCHYkxZA0O/h401p0NkTT8b17b3Pmz4mXCTTl9Ayec3uAe1hB/iLjGvF/8PhChHB
	oFBSkJ3UUGDBqXnna4uvmdOdIP9+JvNgy5LywwWlTE43fYfR1reUBSzlouMwcYpgk0ed9p4qsGBua
	0EqmRo8l+VcEsJJm48m8gYnXk49CNBJnxdNC/B/4uoccj84tPsh20TuNaD4++g+brRuXc6a7c9qCZ
	JJK4KrSDUfln+rsu4i/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVS9O-000000039xr-1F8t;
	Mon, 23 Nov 2026 11:23:58 +0000
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVS9G-000000039ss-27er
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 11:23:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795433028; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=MNS9VVEkFGiFVZsN7KcZGKqfIByh9CnFOKxk5UqKT2I=;
	b=N4d5ceNlaJXIeRr7LPh3GyJDvNftJleGzka2h7ly/bZZXCIgMbwULMBKE6L9YbDwjwEp91dgQfu/D2iioTp8gBROZRpOFLXJXY0CwKU6UO2+hAuJykICRnKv9HNhkG/wNtFpnC8iIMs5+SQMUzwVv16Wr25AVKVSV8+BoOLu08Y=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XFHl61m_1795433027;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XFHl61m_1795433027 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 23 Nov 2026 19:23:47 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 1/1] nvme-hwmon: notify hwmon alarms on the SMART / Health Status AEN
Date: Mon, 23 Nov 2026 19:23:42 +0800
Message-ID: <20261123112342.2761131-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261123112342.2761131-1-kanie@linux.alibaba.com>
References: <20261123112342.2761131-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261123_032351_506039_A0FF7A1D 
X-CRM114-Status: GOOD (  23.15  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The NVMe hwmon support exposes the temperature alarm as a plain sysfs
attribute, so monitoring tools have to poll temp1_alarm to learn about
a critical temperature condition. The device does send a SMART / Health
Status asynchronous event when a critical warning is raised, but the
host never enables it in the Asynchronous Event Configuration, and the
completion path silently drops the event.

The temperature warning is configured through the SMART / Health
Critical Warnings field of the Asynchronous Event Configuration, which
mirrors the critical_warning byte of the SMART log and has no OAES
capability bit, so the subscription does not go through ctrl->oaes.
A rejection with Invalid Field in Command falls back to the
notice-only mask, so the notice events are not lost with it.

On the event, a work item embedded in nvme_ctrl re-reads the SMART log
to clear the latched event and notifies temp1_alarm through
hwmon_notify_event(), which also feeds the registered thermal zone.
The work is only queued while the controller is live and is drained
before its data is freed.  The nvme-pci transport completes
asynchronous events from interrupt context, so the completion path
only queues the work.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/core.c  | 26 +++++++++++++++++++++++++-
 drivers/nvme/host/hwmon.c | 32 ++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h  | 16 ++++++++++++++++
 3 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cd0df9b038063..d5e4cc107f36c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1792,11 +1792,29 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 	u32 result, supported_aens = ctrl->oaes & NVME_AEN_SUPPORTED;
 	int status;
 
+	if (nvme_hwmon_present(ctrl) && ctrl->ops->submit_async_event)
+		supported_aens |= NVME_SMART_CRIT_TEMPERATURE;
+
 	if (!supported_aens)
 		return;
 
 	status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT, supported_aens,
 			NULL, 0, &result);
+	/*
+	 * The SHCW bits have no capability field, so a controller
+	 * reports the lack of support as Invalid Field in Command.
+	 * Retry with the notice-only mask, so the notice events are
+	 * not lost with the subscription; other errors do not
+	 * indicate an unsupported mask.
+	 */
+	if ((status & NVME_SCT_SC_MASK) == NVME_SC_INVALID_FIELD &&
+	    (supported_aens & NVME_SMART_CRIT_TEMPERATURE)) {
+		supported_aens &= ~NVME_SMART_CRIT_TEMPERATURE;
+		if (!supported_aens)
+			return;
+		status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT,
+				supported_aens, NULL, 0, &result);
+	}
 	if (status)
 		dev_warn(ctrl->device, "Failed to configure AEN (cfg %x)\n",
 			 supported_aens);
@@ -5009,8 +5027,14 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 			nvme_handle_aer_persistent_error(ctrl);
 			return;
 		}
-		fallthrough;
+		ctrl->aen_result = result;
+		break;
 	case NVME_AER_SMART:
+		ctrl->aen_result = result;
+		if (nvme_hwmon_present(ctrl) &&
+		    nvme_ctrl_state(ctrl) == NVME_CTRL_LIVE)
+			nvme_hwmon_smart_event(ctrl);
+		break;
 	case NVME_AER_CSS:
 	case NVME_AER_VS:
 		ctrl->aen_result = result;
diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 406203d8b9adb..07c26c78596e0 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -223,6 +223,36 @@ static const struct hwmon_chip_info nvme_hwmon_chip_info = {
 	.info	= nvme_hwmon_info,
 };
 
+static void nvme_hwmon_smart_notify(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl =
+		container_of(work, struct nvme_ctrl, smart_work);
+	struct nvme_hwmon_data *data;
+	struct device *hwmon;
+	bool warn = false;
+
+	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE)
+		return;
+
+	hwmon = ctrl->hwmon_device;
+	if (!hwmon)
+		return;
+	data = dev_get_drvdata(hwmon);
+
+	mutex_lock(&data->read_lock);
+	if (!nvme_hwmon_get_smart_log(data))
+		warn = data->log->critical_warning & NVME_SMART_CRIT_TEMPERATURE;
+	mutex_unlock(&data->read_lock);
+
+	if (warn)
+		hwmon_notify_event(hwmon, hwmon_temp, hwmon_temp_alarm, 0);
+}
+
+void nvme_hwmon_smart_event(struct nvme_ctrl *ctrl)
+{
+	queue_work(nvme_wq, &ctrl->smart_work);
+}
+
 int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 {
 	struct device *dev = ctrl->device;
@@ -242,6 +272,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 
 	data->ctrl = ctrl;
 	mutex_init(&data->read_lock);
+	INIT_WORK(&ctrl->smart_work, nvme_hwmon_smart_notify);
 
 	err = nvme_hwmon_get_smart_log(data);
 	if (err) {
@@ -273,6 +304,7 @@ void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
 		struct nvme_hwmon_data *data =
 			dev_get_drvdata(ctrl->hwmon_device);
 
+		cancel_work_sync(&ctrl->smart_work);
 		hwmon_device_unregister(ctrl->hwmon_device);
 		ctrl->hwmon_device = NULL;
 		kfree(data->log);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2543e52d6358a..f22197347f099 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -379,6 +379,7 @@ struct nvme_ctrl {
 	struct device *device;	/* char device */
 #ifdef CONFIG_NVME_HWMON
 	struct device *hwmon_device;
+	struct work_struct smart_work;
 #endif
 	struct cdev cdev;
 	struct work_struct reset_work;
@@ -1276,6 +1277,12 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
 #ifdef CONFIG_NVME_HWMON
 int nvme_hwmon_init(struct nvme_ctrl *ctrl);
 void nvme_hwmon_exit(struct nvme_ctrl *ctrl);
+void nvme_hwmon_smart_event(struct nvme_ctrl *ctrl);
+
+static inline bool nvme_hwmon_present(struct nvme_ctrl *ctrl)
+{
+	return ctrl->hwmon_device != NULL;
+}
 #else
 static inline int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 {
@@ -1285,6 +1292,15 @@ static inline int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 static inline void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
 {
 }
+
+static inline void nvme_hwmon_smart_event(struct nvme_ctrl *ctrl)
+{
+}
+
+static inline bool nvme_hwmon_present(struct nvme_ctrl *ctrl)
+{
+	return false;
+}
 #endif
 
 static inline void nvme_start_request(struct request *rq)
-- 
2.43.7


