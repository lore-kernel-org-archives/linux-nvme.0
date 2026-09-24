Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 758F1C98314
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Sep 2026 06:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bTOd8smcA0xweItWsUhfajN0a9/pZPi/mmhXp8LGyUQ=; b=DNajLxKQ0uQV2jegkTAiyniLWC
	MSGgDLrJFEbJnzkQtKsc3Qezt+ZAwgEa2CbZZUg9N9YM2IFZ8AiUk5X5+K0r96l4kJY7hC3SKVq9D
	o2gC6Ma+ageQHYz7sn/LJtPQz/Jl4y5v0lFjJe5DQj5nG9JnMN38OSgFyLNJoed4TW+PbHJ20Hnp+
	ZNCRTZAJjmTncOyChKg0k0gPA4GnX3Y4HcgrE17lhycEdq09DrG52rE0IZS384OUxg7SoRlvhQYK4
	sj5PL1W+ROS8tSxIGdD5gIiBROXNH7YupGtDzqW4CCvphBmca2wMXdJLGXLinchbRVjkiXUZA1+hc
	boEN0mLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9ckF-0000000A8QP-1kAi;
	Thu, 24 Sep 2026 06:15:47 +0000
Received: from out28-2.mail.aliyun.com ([115.124.28.2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9ckC-0000000A8Mp-2egR
	for linux-nvme@lists.infradead.org;
	Thu, 24 Sep 2026 06:15:46 +0000
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.9109073|0.1356083;CH=green;DM=|AD|false|;DS=CONTINUE|ham_regular_dialog|0.0110819-0.00116182-0.987756;FP=2518774180095731379|4|2|2|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=liaoxuan@open-hieco.net;NM=1;PH=DS;RN=10;RT=10;SR=0;TI=SMTPD_---.jLtpc1n_1790230533;
Received: from Ubuntu2404-XLH.hygon.cn(mailfrom:liaoxuan@open-hieco.net fp:SMTPD_---.jLtpc1n_1790230533 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 24 Sep 2026 14:15:39 +0800
From: Liao Xuan <liaoxuan@open-hieco.net>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	ilpo.jarvinen@linux.intel.com,
	bhelgaas@google.com
Cc: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Liao Xuan <liaoxuan@open-hieco.net>
Subject: [PATCH 2/3] nvme: Add hysteresis and idle detection to link rate switching
Date: Thu, 24 Sep 2026 14:15:12 +0800
Message-ID: <de23e8b9699b5a7a77e7ee215e8e4c9f530ce5da.1790222172.git.liaoxuan@hygon.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790222172.git.liaoxuan@hygon.cn>
References: <cover.1790222172.git.liaoxuan@hygon.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_231544_939032_FD1EC434 
X-CRM114-Status: GOOD (  17.08  )
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

The rate switching decision currently toggles the link rate in every
monitoring window based on the I/O of that window alone, which can
cause excessive rate switching when the workload fluctuates around the
threshold.

Add counters that require the threshold to be exceeded for a
consecutive number of windows before the rate is upgraded, and to stay
below the threshold for a consecutive number of windows before it is
downgraded. The upgrade happens immediately (threshold 0 by default)
so that latency is not sacrificed, while the downgrade requires 10
consecutive windows.

Monitoring is stopped after 10 seconds of inactivity and is re-armed by
the next I/O.

Signed-off-by: Liao Xuan <liaoxuan@open-hieco.net>
---
 drivers/nvme/host/nvme.h         |  5 +++
 drivers/nvme/host/speed_switch.c | 52 ++++++++++++++++++++++++++++----
 2 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ff06f85d1..5d5034601 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -346,6 +346,11 @@ struct nvme_speed_switch {
 	u8 min_speed;
 	u32 monitor_interval;	/* ms */
 	u32 threshold;		/* KB */
+	u32 up_cnt;
+	u32 down_cnt;
+	u32 up_threshold;
+	u32 down_threshold;
+	u32 idle_cnt;
 	struct timer_list timer;
 	struct work_struct work;
 	struct nvme_speed_switch_stats __percpu *stats;
diff --git a/drivers/nvme/host/speed_switch.c b/drivers/nvme/host/speed_switch.c
index 88c046fcd..22f180c81 100644
--- a/drivers/nvme/host/speed_switch.c
+++ b/drivers/nvme/host/speed_switch.c
@@ -228,10 +228,15 @@ static void nvme_clear_io_stats(struct nvme_speed_switch *sw)
 
 /*
  * Aggregate the per-CPU I/O counters of the last monitoring window and
- * decide the target rate: the maximum rate if the window exceeded the
- * threshold, the minimum rate otherwise.
+ * decide the target rate.  Hysteresis counters are used to avoid
+ * excessive rate switching when the workload fluctuates around the
+ * threshold: the rate is only upgraded after the threshold was exceeded
+ * for a number of consecutive windows, and only downgraded after it
+ * stayed below the threshold for a number of consecutive windows.  When
+ * no I/O was observed for 10 seconds the monitoring is stopped.
  */
-static int nvme_check_io_and_decide_speed(struct nvme_speed_switch *sw)
+static int nvme_check_io_and_decide_speed(struct nvme_speed_switch *sw,
+					  bool *io_activity)
 {
 	struct nvme_ctrl *ctrl = container_of(sw, struct nvme_ctrl, speed_switch);
 	u64 read_bytes = 0, write_bytes = 0;
@@ -247,31 +252,62 @@ static int nvme_check_io_and_decide_speed(struct nvme_speed_switch *sw)
 		stat->write_bytes = 0;
 	}
 
+	if (read_bytes || write_bytes) {
+		*io_activity = true;
+		sw->idle_cnt = 0;
+	} else {
+		sw->idle_cnt++;
+	}
+
+	/* Stop monitoring after 10 seconds of inactivity (100 windows of 100ms). */
+	if (sw->idle_cnt >= 100)
+		*io_activity = false;
+
 	read_kb = read_bytes / 1024;
 	write_kb = write_bytes / 1024;
 	dev_dbg(ctrl->device,
 		"I/O in window: read=%lu KB, write=%lu KB, threshold=%u KB\n",
 		read_kb, write_kb, READ_ONCE(sw->threshold));
 
-	if (read_kb >= sw->threshold || write_kb >= sw->threshold)
+	if (read_kb >= sw->threshold || write_kb >= sw->threshold) {
+		sw->up_cnt++;
+		sw->down_cnt = 0;
+	} else {
+		sw->down_cnt++;
+		sw->up_cnt = 0;
+	}
+
+	if (sw->up_cnt > READ_ONCE(sw->up_threshold)) {
+		sw->up_cnt = 0;
 		return sw->max_speed;
+	}
+
+	if (sw->down_cnt > READ_ONCE(sw->down_threshold) || !*io_activity) {
+		sw->down_cnt = 0;
+		return sw->min_speed;
+	}
 
-	return sw->min_speed;
+	return READ_ONCE(sw->cur_speed);
 }
 
 static void nvme_speed_switch_timer_fn(struct timer_list *t)
 {
 	struct nvme_speed_switch *sw = container_of(t, struct nvme_speed_switch, timer);
+	bool io_activity = true;
 
 	if (!READ_ONCE(sw->enabled)) {
 		atomic_set(&sw->timer_active, NVME_SPEED_TIMER_INACTIVE);
 		return;
 	}
 
-	sw->target_speed = nvme_check_io_and_decide_speed(sw);
+	sw->target_speed = nvme_check_io_and_decide_speed(sw, &io_activity);
 	if (sw->target_speed != READ_ONCE(sw->cur_speed))
 		schedule_work(&sw->work);
 
+	if (!io_activity) {
+		atomic_set(&sw->timer_active, NVME_SPEED_TIMER_INACTIVE);
+		return;
+	}
 	mod_timer(t, jiffies + msecs_to_jiffies(READ_ONCE(sw->monitor_interval)));
 }
 
@@ -279,6 +315,10 @@ static void nvme_speed_switch_params_init(struct nvme_speed_switch *sw)
 {
 	sw->monitor_interval = 100;
 	sw->min_speed = PCI_EXP_LNKSTA_CLS_2_5GB;
+	/* Upgrade immediately once the threshold is exceeded. */
+	sw->up_threshold = 0;
+	/* Downgrade after 10 consecutive below-threshold windows. */
+	sw->down_threshold = 10;
 }
 
 void nvme_speed_switch_init(struct nvme_ctrl *ctrl)
-- 
2.43.0


