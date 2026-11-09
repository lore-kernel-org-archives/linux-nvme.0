Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E096606A321
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 12:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ELzIW5zo;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=ESinubqn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=HVZigtFthtK8tVIkn67IsH8na+3ofJKjPW4aH4sa1Go=; b=ELzIW5zoLUYKH5
	XhvQjD7TB4fqWZyc2bpgtg35ybDEtY+oV09dfEV+J8BN2y4yHH1r25I2dKkgh+pmi9C39ERBdNCEv
	TqsLUCi2CSQMTMVx1fFz1vA1GBk3dV2rIPYcCdgNi5XlRyoWXvQDmxTJFjB21ymiPNz1eWiFq1+PR
	QgUwTE9WP0YmREhqL0NiikiUsxCI5t0YZYX8SE7+HM6QCZtalw55bWNeXNn2UiYFD27EXuG9/Hb/6
	7xXJ9n1QfbK4aZBe4q9GwZdbGEcgBmI4pinWNo+b9+I7f5sqjiXEK3rnUdZVFKjFxpmVULVZKtwUl
	r4VHXdVsk7RL6+dpeRTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQO4x-00000000bS7-3PG2;
	Mon, 09 Nov 2026 12:02:27 +0000
Received: from out30-98.freemail.mail.aliyun.com ([115.124.30.98])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQO4r-00000000bNU-1blJ
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 12:02:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794225735; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=HVZigtFthtK8tVIkn67IsH8na+3ofJKjPW4aH4sa1Go=;
	b=ESinubqn2/w9iY6p3FNvGdyzmhvBZGI+l4/Kr4AAlJOhOTTD3T98fkrESqerlzTsiXXzVkS+TmQZVzN8zGIq7JJg8vPlp4iLouY6onWloaY9MInm/uCFei8p8JvY4Vsymval1rXLbFEPROlLis8chBUDguzSHT6RtwflXQpHBXw=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R711e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEOSQVm_1794225734;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEOSQVm_1794225734 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Nov 2026 20:02:14 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 2/2] nvme-hwmon: notify hwmon alarms on the SMART / Health Status AEN
Date: Mon,  9 Nov 2026 20:02:04 +0800
Message-ID: <20261109120207.1352165-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261109120207.1352165-1-kanie@linux.alibaba.com>
References: <20261109120207.1352165-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261109_040221_638610_020D670C 
X-CRM114-Status: GOOD (  20.06  )
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
a critical temperature or spare-block condition. The device does send
a SMART / Health Status asynchronous event when its health status
changes, but the host never subscribes to it, and the completion path
silently drops the event.

Subscribe to the SMART / Health Status event, and when it arrives,
wake up pollers on temp1_alarm. The alarm read fetches the SMART log
on demand, so no log refresh is needed in the completion path; the
notify is deferred to a work item because nvme-pci completes
asynchronous events from interrupt context, where sysfs_notify()
cannot sleep.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/core.c  |  8 ++++++--
 drivers/nvme/host/hwmon.c | 30 ++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h  |  5 +++++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cd0df9b038063..47dc9eb3ae595 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1784,7 +1784,7 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 
 #define NVME_AEN_SUPPORTED \
-	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
+	(NVME_AEN_CFG_SMART | NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | \
 	 NVME_AEN_CFG_ANA_CHANGE | NVME_AEN_CFG_DISC_CHANGE)
 
 static void nvme_enable_aen(struct nvme_ctrl *ctrl)
@@ -5009,8 +5009,12 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
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
index 406203d8b9adb..564d5cae8001b 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/hwmon.h>
+#include <linux/sysfs.h>
 #include <linux/units.h>
 #include <linux/unaligned.h>
 
@@ -14,6 +15,7 @@ struct nvme_hwmon_data {
 	struct nvme_ctrl *ctrl;
 	struct nvme_smart_log *log;
 	struct mutex read_lock;
+	struct work_struct smart_work;
 };
 
 static int nvme_get_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool under,
@@ -223,6 +225,32 @@ static const struct hwmon_chip_info nvme_hwmon_chip_info = {
 	.info	= nvme_hwmon_info,
 };
 
+/*
+ * Called from the admin completion path on a SMART / Health Status AEN.
+ * The completion context can be a hardirq, so only queue the work here;
+ * the notify itself is done in process context.  No log refresh is
+ * needed: userspace re-reads temp1_alarm, which fetches the SMART log
+ * on demand.
+ */
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
+static void nvme_hwmon_smart_notify(struct work_struct *work)
+{
+	struct nvme_hwmon_data *data =
+		container_of(work, struct nvme_hwmon_data, smart_work);
+
+	sysfs_notify(&data->ctrl->hwmon_device->kobj, NULL, "temp1_alarm");
+}
+
 int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 {
 	struct device *dev = ctrl->device;
@@ -242,6 +270,7 @@ int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 
 	data->ctrl = ctrl;
 	mutex_init(&data->read_lock);
+	INIT_WORK(&data->smart_work, nvme_hwmon_smart_notify);
 
 	err = nvme_hwmon_get_smart_log(data);
 	if (err) {
@@ -273,6 +302,7 @@ void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
 		struct nvme_hwmon_data *data =
 			dev_get_drvdata(ctrl->hwmon_device);
 
+		cancel_work_sync(&data->smart_work);
 		hwmon_device_unregister(ctrl->hwmon_device);
 		ctrl->hwmon_device = NULL;
 		kfree(data->log);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2543e52d6358a..df8a94c907655 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1276,6 +1276,7 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
 #ifdef CONFIG_NVME_HWMON
 int nvme_hwmon_init(struct nvme_ctrl *ctrl);
 void nvme_hwmon_exit(struct nvme_ctrl *ctrl);
+void nvme_hwmon_smart_event(struct nvme_ctrl *ctrl);
 #else
 static inline int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 {
@@ -1285,6 +1286,10 @@ static inline int nvme_hwmon_init(struct nvme_ctrl *ctrl)
 static inline void nvme_hwmon_exit(struct nvme_ctrl *ctrl)
 {
 }
+
+static inline void nvme_hwmon_smart_event(struct nvme_ctrl *ctrl)
+{
+}
 #endif
 
 static inline void nvme_start_request(struct request *rq)
-- 
2.43.7


