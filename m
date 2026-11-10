Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4032606A338
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 11:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=kjbWeilK;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=n+nDic5v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=DRvbepGAX2x9jviqon0p6ikuLLImvwoJ4dXKCQ3yiHU=; b=kjbWeilKYkkQdo
	ZBO//DnYBAR1Io0vVng21r9L4ooAcT1EN9NyUKlJ0Ei42K63BPKxr1ccR8WCPsbXQGIwZe7AZ7PUn
	/U8dp6vS1KbOWTNatxuYiAvg8hvYZAm4tgRLMCmxNUuLG1wZlzXUZrZpkzIjGzxOtkR3fSIdao1AT
	aNvDaeWRJFHqY3xvN4h1InMZDaz0ijfbClfg5NQUVPxJujUXFkrrAMfBPjUj2hOYCJwbxzgIRebad
	Wp7Oi3Sx11lP9lPEc3HLsczNyrDvIfP8CMDHoKiRj6WytBheqAEgLAiMiYqgNicmQR2HId8HZBiJZ
	RhQ+rOVdwaf0LHw827dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQjhc-00000003aCE-3yRI;
	Tue, 10 Nov 2026 11:07:48 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQjha-00000003aAU-0oZq
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 11:07:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794308864; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DRvbepGAX2x9jviqon0p6ikuLLImvwoJ4dXKCQ3yiHU=;
	b=n+nDic5vWd/t0hhmZOPIgwdZWfrdFnY4Qjwy97PUxLWF7KCrrgW/UyL6f3vPfsoqcOH0yZbVb4OrTao8+jhIZkl5B3p/0xnotIcdOkiKJmX8ITfJ3i/WN/RyXb5e9Vu8f+eMUvK9TFea5EczjCNwUL/aZ7UDwbpOYZ9/Yol2EUQ=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R351e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEVF2S-_1794308863;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEVF2S-_1794308863 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 10 Nov 2026 19:07:43 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 1/1] nvme-hwmon: notify hwmon alarms on the SMART / Health Status AEN
Date: Tue, 10 Nov 2026 19:07:37 +0800
Message-ID: <20261110110737.3965373-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261110110737.3965373-1-kanie@linux.alibaba.com>
References: <20261110110737.3965373-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261110_030746_423388_1FA48209 
X-CRM114-Status: GOOD (  20.53  )
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

The temperature warning is bit 1 of the SMART / Health Critical
Warnings field of the Asynchronous Event Configuration (feature 0x0b,
command dword 11 bits 7:0), which mirrors the critical_warning byte of
the SMART log. Unlike the notice events, it has no OAES capability bit,
so the subscription does not go through ctrl->oaes.

The event stays latched until the SMART log is read with RAE cleared,
so the deferred work re-reads it before the completion path re-arms
the Asynchronous Event Request, and then calls hwmon_notify_event()
on temp1_alarm. hwmon_notify_event() also feeds the thermal zone
registered with HWMON_C_REGISTER_TZ and emits the standard hwmon
uevent, which a plain sysfs_notify() would skip.

The nvme-pci transport completes asynchronous events from interrupt
context, so the completion path only queues the work.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/core.c  | 17 ++++++++++++++++-
 drivers/nvme/host/hwmon.c | 36 ++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h  | 15 +++++++++++++++
 3 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cd0df9b038063..e932e1a7e479c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1792,6 +1792,17 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 	u32 result, supported_aens = ctrl->oaes & NVME_AEN_SUPPORTED;
 	int status;
 
+	/*
+	 * Unlike the notice events above, SMART / Health Status events have
+	 * no OAES capability bit: AEC dw11 bits 7:0 are the SMART / Health
+	 * Critical Warnings (SHCW) mask, which mirrors the critical_warning
+	 * byte of the SMART log.  Subscribe to the temperature warning
+	 * whenever the hwmon support is present, as that is the only
+	 * consumer.
+	 */
+	if (nvme_hwmon_present(ctrl))
+		supported_aens |= NVME_SMART_CRIT_TEMPERATURE;
+
 	if (!supported_aens)
 		return;
 
@@ -5009,8 +5020,12 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 			nvme_handle_aer_persistent_error(ctrl);
 			return;
 		}
-		fallthrough;
+		ctrl->aen_result = result;
+		break;
 	case NVME_AER_SMART:
+		nvme_hwmon_smart_event(ctrl);
+		ctrl->aen_result = result;
+		break;
 	case NVME_AER_CSS:
 	case NVME_AER_VS:
 		ctrl->aen_result = result;
diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 406203d8b9adb..172ef63f1180c 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -14,6 +14,7 @@ struct nvme_hwmon_data {
 	struct nvme_ctrl *ctrl;
 	struct nvme_smart_log *log;
 	struct mutex read_lock;
+	struct work_struct smart_work;
 };
 
 static int nvme_get_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool under,
@@ -223,6 +224,39 @@ static const struct hwmon_chip_info nvme_hwmon_chip_info = {
 	.info	= nvme_hwmon_info,
 };
 
+static void nvme_hwmon_smart_notify(struct work_struct *work)
+{
+	struct nvme_hwmon_data *data =
+		container_of(work, struct nvme_hwmon_data, smart_work);
+	struct nvme_ctrl *ctrl = data->ctrl;
+	int ret;
+
+	/*
+	 * The event stays latched on the controller until the SMART log
+	 * is read with RAE cleared, so re-read it here before the
+	 * completion path re-arms the Asynchronous Event Request.
+	 */
+	mutex_lock(&data->read_lock);
+	ret = nvme_hwmon_get_smart_log(data);
+	mutex_unlock(&data->read_lock);
+	if (ret)
+		return;
+
+	hwmon_notify_event(ctrl->hwmon_device, hwmon_temp,
+			   hwmon_temp_alarm, 0);
+}
+
+void nvme_hwmon_smart_event(struct nvme_ctrl *ctrl)
+{
+	struct nvme_hwmon_data *data;
+
+	if (!ctrl->hwmon_device)
+		return;
+
+	data = dev_get_drvdata(ctrl->hwmon_device);
+	queue_work(nvme_wq, &data->smart_work);
+}
+
 int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 {
 	struct device *dev = ctrl->device;
@@ -242,6 +276,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 
 	data->ctrl = ctrl;
 	mutex_init(&data->read_lock);
+	INIT_WORK(&data->smart_work, nvme_hwmon_smart_notify);
 
 	err = nvme_hwmon_get_smart_log(data);
 	if (err) {
@@ -273,6 +308,7 @@ void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
 		struct nvme_hwmon_data *data =
 			dev_get_drvdata(ctrl->hwmon_device);
 
+		cancel_work_sync(&data->smart_work);
 		hwmon_device_unregister(ctrl->hwmon_device);
 		ctrl->hwmon_device = NULL;
 		kfree(data->log);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2543e52d6358a..fe43ab17c3967 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1276,6 +1276,12 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
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
@@ -1285,6 +1291,15 @@ static inline int nvme_hwmon_init(struct nvme_ctrl *ctrl)
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


