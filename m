Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC0D606A324
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 06:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XN6sMBTw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=XKYfNdocuB1MEsGC6i70NraA/BGJPa5duw67dNLX3zc=; b=XN6sMBTwsXeAaw
	3TIlaARxxTQSm5e7Q+QMBdHJy8GzBhzf7BZz2RAjJiflHfvQ+SrRtJn/JYUkujf3Iv3aDbLrRsYn2
	2mw4P0Kz4lI3RDKJ96UnpridUjR4V65JQJ4BBSn0ECWBSRWT/LKwSGX1qOOBQWsrugJ0hohMWG3iZ
	/SpVFUXy7agmU9K885WfBsuxQ6Nol/LWO31QqUXLYQgmOB4kwhabCsRJO4gbnuf0dlUpB6gFMwCT0
	LKQjBBVXINgkhsOWLOLStHIAyPxPKO0HIoSgDTETRCQLl+SPPvjShLoFjFms5xAOjx4B96cE1FHZR
	HXQ6d+Y+Xl6TkMTkIL/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7yJ-00000001F1m-2stU;
	Tue, 03 Nov 2026 06:26:15 +0000
Received: from out28-53.mail.aliyun.com ([115.124.28.53])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7yD-00000001F0p-45SZ
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 06:26:13 +0000
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.9243626|0.09915012;CH=green;DM=|AD|false|;DS=CONTINUE|ham_system_inform|0.00862597-0.00193639-0.989438;FP=2229952610361232051|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034138;MF=liaoxuan@open-hieco.net;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.jvVZCbV_1793687148;
Received: from Ubuntu2404-XLH.hygon.cn(mailfrom:liaoxuan@open-hieco.net fp:SMTPD_---.jvVZCbV_1793687148 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 14:25:59 +0800
From: Liao Xuan <liaoxuan@open-hieco.net>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Liao Xuan <liaoxuan@open-hieco.net>,
	default avatarZheng Tan <tanzheng@kylinos.cn>
Subject: [PATCH 1/3] nvme: Add adaptive PCIe link rate switching function
Date: Tue,  3 Nov 2026 14:25:43 +0800
Message-ID: <85a11a4085d04a2823c04059702630cf34abf6d4.1790134954.git.liaoxuan@open-hieco.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790134954.git.liaoxuan@open-hieco.net>
References: <cover.1790134954.git.liaoxuan@open-hieco.net>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_222610_335251_90657B10 
X-CRM114-Status: GOOD (  28.20  )
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add support for dynamically adjusting the PCIe link rate of NVMe
devices based on I/O activity. The link is downgraded to a
configurable minimum rate during periods of low activity to save
power, and upgraded to the maximum supported rate as soon as the
workload exceeds a computed threshold, so that peak performance is
maintained under load.

The amount of transferred data is accumulated on the I/O submission
path and aggregated by a per-controller timer. The threshold is
derived from the bandwidth of the minimum and maximum rates such that
the extra time required to transfer the data at the minimum rate does
not exceed the estimated link retraining time.

The feature is currently only supported on Hygon platforms.

Signed-off-by: Liao Xuan <liaoxuan@open-hieco.net>
Signed-off-by: default avatarZheng Tan <tanzheng@kylinos.cn>
---
 drivers/nvme/host/Kconfig        |  10 +
 drivers/nvme/host/Makefile       |   1 +
 drivers/nvme/host/core.c         |   4 +
 drivers/nvme/host/nvme.h         |  42 ++++
 drivers/nvme/host/pci.c          |   4 +
 drivers/nvme/host/speed_switch.c | 367 +++++++++++++++++++++++++++++++
 drivers/pci/pcie/bwctrl.c        |   1 +
 7 files changed, 429 insertions(+)
 create mode 100644 drivers/nvme/host/speed_switch.c

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 31974c7dd20c..098ec7abba66 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -134,3 +134,13 @@ config NVME_APPLE
 
 	  To compile this driver as a module, choose M here: the
 	  module will be called nvme-apple.
+
+config NVME_SPEED_SWITCH
+	bool "NVMe adaptive PCIe link rate switching"
+	depends on BLK_DEV_NVME && X86
+	help
+	  This provides support for dynamic PCIe link rate switching for NVMe
+	  devices. When enabled, the NVMe driver can dynamically adjust the
+	  PCIe link speed and width based on workload requirement.
+
+	  If unsure, say N.
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 67563a69f7dc..02d0200fcc88 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -19,6 +19,7 @@ nvme-core-$(CONFIG_BLK_DEV_ZONED)	+= zns.o
 nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)	+= fault_inject.o
 nvme-core-$(CONFIG_NVME_HWMON)		+= hwmon.o
 nvme-core-$(CONFIG_NVME_HOST_AUTH)	+= auth.o
+nvme-core-$(CONFIG_NVME_SPEED_SWITCH)	+= speed_switch.o
 
 nvme-y					+= pci.o
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index beea23d04a70..85e0bfc4d7aa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4679,6 +4679,7 @@ static void nvme_scan_work(struct work_struct *work)
 		/* Re-read the ANA log page to not miss updates */
 		queue_work(nvme_wq, &ctrl->ana_work);
 #endif
+	nvme_speed_switch_start(ctrl);
 }
 
 /*
@@ -5103,6 +5104,7 @@ EXPORT_SYMBOL_GPL(nvme_remove_io_tag_set);
 
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
+	nvme_speed_switch_exit(ctrl);
 	nvme_mpath_stop(ctrl);
 	nvme_auth_stop(ctrl);
 	nvme_stop_failfast_work(ctrl);
@@ -5318,6 +5320,8 @@ int nvme_add_ctrl(struct nvme_ctrl *ctrl)
 	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
 	nvme_get_ctrl(ctrl);
 
+	nvme_speed_switch_init(ctrl);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nvme_add_ctrl);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2cff9fcbf740..0f27c73a99ee 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -339,6 +339,33 @@ enum nvme_ctrl_flags {
 	NVME_CTRL_FROZEN		= 6,
 };
 
+#ifdef CONFIG_NVME_SPEED_SWITCH
+struct nvme_speed_switch_stats {
+	u64 read_bytes;
+	u64 write_bytes;
+};
+
+struct nvme_speed_switch {
+	bool initialized;
+	bool enabled;
+	u8 max_speed;
+	u8 cur_speed;
+	u8 target_speed;
+	u8 min_speed;
+	u32 monitor_interval;	/* ms */
+	u32 threshold;		/* KB */
+	struct timer_list timer;
+	struct work_struct work;
+	struct nvme_speed_switch_stats __percpu *stats;
+	atomic_t timer_active;
+};
+
+enum nvme_speed_timer_state {
+	NVME_SPEED_TIMER_INACTIVE,
+	NVME_SPEED_TIMER_ACTIVE,
+};
+#endif
+
 struct nvme_ctrl {
 	bool comp_seen;
 	bool identified;
@@ -481,8 +508,23 @@ struct nvme_ctrl {
 	enum nvme_dctype dctype;
 
 	u16			awupf; /* 0's based value. */
+#ifdef CONFIG_NVME_SPEED_SWITCH
+	struct nvme_speed_switch speed_switch;
+#endif
 };
 
+#ifdef CONFIG_NVME_SPEED_SWITCH
+void nvme_update_io_stats(struct nvme_ctrl *ctrl, struct request *req);
+void nvme_speed_switch_start(struct nvme_ctrl *ctrl);
+void nvme_speed_switch_init(struct nvme_ctrl *ctrl);
+void nvme_speed_switch_exit(struct nvme_ctrl *ctrl);
+#else
+static inline void nvme_update_io_stats(struct nvme_ctrl *ctrl, struct request *req) {}
+static inline void nvme_speed_switch_start(struct nvme_ctrl *ctrl) {}
+static inline void nvme_speed_switch_init(struct nvme_ctrl *ctrl) {}
+static inline void nvme_speed_switch_exit(struct nvme_ctrl *ctrl) {}
+#endif
+
 static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
 {
 	return READ_ONCE(ctrl->state);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5440cf18b55b..dfba03409dc0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1461,6 +1461,9 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	ret = nvme_prep_rq(req);
 	if (unlikely(ret))
 		return ret;
+
+	nvme_update_io_stats(&dev->ctrl, req);
+
 	spin_lock(&nvmeq->sq_lock);
 	nvme_sq_copy_cmd(nvmeq, &iod->cmd);
 	nvme_write_sq_db(nvmeq, bd->last);
@@ -1479,6 +1482,7 @@ static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct rq_list *rqlist)
 	while ((req = rq_list_pop(rqlist))) {
 		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 
+		nvme_update_io_stats(&nvmeq->dev->ctrl, req);
 		nvme_sq_copy_cmd(nvmeq, &iod->cmd);
 	}
 	nvme_write_sq_db(nvmeq, true);
diff --git a/drivers/nvme/host/speed_switch.c b/drivers/nvme/host/speed_switch.c
new file mode 100644
index 000000000000..0a828d04885b
--- /dev/null
+++ b/drivers/nvme/host/speed_switch.c
@@ -0,0 +1,367 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVMe link speed switch driver
+ *
+ * Adjusts the PCIe link rate of NVMe devices dynamically based on the I/O
+ * workload: the link is downgraded to a configurable minimum rate during
+ * periods of low activity to save power, and upgraded to the maximum
+ * supported rate as soon as the workload requires it.
+ *
+ * Copyright (c) 2026 Chengdu Haiguang IC Design Co., Ltd.
+ * Copyright (C) 2026 Kylin Software Co., Ltd.
+ *
+ */
+
+#include <linux/blk-mq.h>
+#include <linux/math64.h>
+#include <linux/pci.h>
+#include <linux/percpu.h>
+#include <linux/processor.h>
+
+#include "nvme.h"
+
+/*
+ * PCIe link bandwidth in KB/s for each generation (rows, Gen1..Gen5) and
+ * lane width (columns, x1..x16).  The table is used to derive the I/O
+ * threshold exceed/below which the link can be upgraded/downgraded.
+ */
+static const u32 nvme_speed_table[][5] = {
+	{  312,  625, 1250, 2500, 5000 },   /* Gen1 */
+	{  625, 1250, 2500, 5000, 10000 },  /* Gen2 */
+	{ 1000, 2000, 4000, 8000, 16000 },  /* Gen3 */
+	{ 2000, 4000, 8000, 16000, 32000 }, /* Gen4 */
+	{ 4000, 8000, 16000, 32000, 64000 },/* Gen5 */
+};
+
+static int nvme_bandwidth_index(enum pcie_link_width width)
+{
+	switch (width) {
+	case PCIE_LNK_X1:
+		return 0;
+	case PCIE_LNK_X2:
+		return 1;
+	case PCIE_LNK_X4:
+		return 2;
+	case PCIE_LNK_X8:
+		return 3;
+	case PCIE_LNK_X16:
+		return 4;
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * Read the maximum supported link rate of the upstream port from the Link
+ * Capability register.
+ */
+static int nvme_get_max_link_speed(struct pci_dev *pdev)
+{
+	u16 linkcap;
+
+	pcie_capability_read_word(pdev, PCI_EXP_LNKCAP, &linkcap);
+	return linkcap & PCI_EXP_LNKCAP_SLS;
+}
+
+static enum pci_bus_speed nvme_speed_to_bus_speed(u8 gen)
+{
+	return gen + PCIE_SPEED_2_5GT - 1;
+}
+
+/*
+ * Work item that actually changes the link rate.  The queues are frozen
+ * before retraining to quiesce I/O and resumed once the switch completed.
+ */
+static void nvme_speed_switch_work(struct work_struct *work)
+{
+	struct nvme_speed_switch *sw = container_of(work, struct nvme_speed_switch, work);
+	struct nvme_ctrl *ctrl = container_of(sw, struct nvme_ctrl, speed_switch);
+	struct pci_dev *pdev = to_pci_dev(ctrl->dev);
+	struct pci_dev *bridge = pdev->bus->self;
+	u8 cur_speed = READ_ONCE(sw->cur_speed);
+	int ret;
+
+	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE)
+		return;
+
+	/* Freeze I/O to avoid timeouts during link retraining. */
+	nvme_start_freeze(ctrl);
+	nvme_wait_freeze(ctrl);
+
+	ret = pcie_set_target_speed(bridge, nvme_speed_to_bus_speed(sw->target_speed),
+				    true);
+	if (ret) {
+		dev_warn(ctrl->device,
+			 "failed to set target rate Gen%u (%d), trying rollback to Gen%u\n",
+			 sw->target_speed, ret, cur_speed);
+		ret = pcie_set_target_speed(bridge, nvme_speed_to_bus_speed(cur_speed),
+					    true);
+		if (ret) {
+			dev_err(ctrl->device,
+				"rollback to Gen%u failed (%d), disabling speed switch\n",
+				cur_speed, ret);
+			WRITE_ONCE(sw->enabled, false);
+			nvme_unfreeze(ctrl);
+			return;
+		}
+	} else {
+		WRITE_ONCE(sw->cur_speed, sw->target_speed);
+	}
+
+	nvme_unfreeze(ctrl);
+	dev_dbg(ctrl->device, "link rate changed to Gen%u\n",
+		READ_ONCE(sw->cur_speed));
+}
+
+/*
+ * Compute the I/O threshold (in KB) for a monitoring window.
+ *
+ * The threshold is derived from the following constraint: for the link
+ * speed to be upgraded, the transfer time of the data at the minimum
+ * speed must be greater than the sum of the transfer time at maximum
+ * speed and the link retraining time (100us):
+ *
+ *	data / min_bw >= data / max_bw + 100us
+ *
+ * which yields data <= min_bw * max_bw * 0.1ms / (max_bw - min_bw).
+ * The bandwidths are taken from the link capability of the upstream port
+ * and the link width capability of the device.
+ */
+static u32 nvme_calc_speed_threshold(struct nvme_speed_switch *sw,
+				     enum pcie_link_width max_width)
+{
+	struct nvme_ctrl *ctrl = container_of(sw, struct nvme_ctrl, speed_switch);
+	u64 min_bw, max_bw, x, y;
+	int bw_idx, min_gen = sw->min_speed, max_gen = sw->max_speed;
+	u32 threshold;
+
+	if (min_gen < 1 || min_gen > 5 || max_gen < 1 || max_gen > 5) {
+		dev_warn(ctrl->device,
+			 "invalid link rate range for threshold: min=Gen%d, max=Gen%d\n",
+			 min_gen, max_gen);
+		return 0;
+	}
+
+	bw_idx = nvme_bandwidth_index(max_width);
+	if (bw_idx < 0) {
+		dev_warn(ctrl->device,
+			 "unsupported link width (%d) for threshold calculation\n",
+			 max_width);
+		return 0;
+	}
+
+	min_bw = nvme_speed_table[min_gen - 1][bw_idx];
+	max_bw = nvme_speed_table[max_gen - 1][bw_idx];
+	if (min_bw >= max_bw) {
+		dev_warn(ctrl->device,
+			 "invalid bandwidth for threshold: min=%llu KB/s, max=%llu KB/s\n",
+			 min_bw, max_bw);
+		return 0;
+	}
+
+	x = min_bw * max_bw;
+	y = 10ULL * (max_bw - min_bw);
+	threshold = div64_u64(x + (y >> 1), y);
+
+	dev_dbg(ctrl->device,
+		"I/O threshold: %u KB (min=Gen%d, max=Gen%d, width=x%d)\n",
+		threshold, min_gen, max_gen, max_width);
+	return threshold;
+}
+
+/* Called on the I/O submission path to accumulate the transferred bytes. */
+void nvme_update_io_stats(struct nvme_ctrl *ctrl, struct request *req)
+{
+	struct nvme_speed_switch *sw = &ctrl->speed_switch;
+	struct nvme_speed_switch_stats *stat;
+	enum req_op op = req_op(req);
+	unsigned int bytes = blk_rq_bytes(req);
+
+	if (!READ_ONCE(sw->enabled))
+		return;
+
+	if (op != REQ_OP_READ && op != REQ_OP_WRITE)
+		return;
+
+	if (!sw->stats) {
+		dev_dbg(ctrl->device, "I/O statistics not allocated, skip accounting\n");
+		return;
+	}
+
+	stat = get_cpu_ptr(sw->stats);
+	if (op == REQ_OP_READ)
+		stat->read_bytes += bytes;
+	else
+		stat->write_bytes += bytes;
+	put_cpu_ptr(sw->stats);
+
+	if (atomic_cmpxchg(&sw->timer_active, NVME_SPEED_TIMER_INACTIVE,
+			   NVME_SPEED_TIMER_ACTIVE) != NVME_SPEED_TIMER_INACTIVE)
+		return;
+
+	/* First I/O of the activity period: compute the threshold and arm the timer. */
+	WRITE_ONCE(sw->threshold, nvme_calc_speed_threshold(sw,
+					pcie_get_width_cap(to_pci_dev(ctrl->dev))));
+	if (!READ_ONCE(sw->threshold)) {
+		dev_warn(ctrl->device,
+			 "failed to compute speed switch threshold, keeping current rate\n");
+		atomic_set(&sw->timer_active, NVME_SPEED_TIMER_INACTIVE);
+		return;
+	}
+	mod_timer(&sw->timer, jiffies + msecs_to_jiffies(READ_ONCE(sw->monitor_interval)));
+}
+EXPORT_SYMBOL_GPL(nvme_update_io_stats);
+
+static void nvme_clear_io_stats(struct nvme_speed_switch *sw)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct nvme_speed_switch_stats *stat = per_cpu_ptr(sw->stats, cpu);
+
+		stat->read_bytes = 0;
+		stat->write_bytes = 0;
+	}
+}
+
+/*
+ * Aggregate the per-CPU I/O counters of the last monitoring window and
+ * decide the target rate: the maximum rate if the window exceeded the
+ * threshold, the minimum rate otherwise.
+ */
+static int nvme_check_io_and_decide_speed(struct nvme_speed_switch *sw)
+{
+	struct nvme_ctrl *ctrl = container_of(sw, struct nvme_ctrl, speed_switch);
+	u64 read_bytes = 0, write_bytes = 0;
+	unsigned long read_kb, write_kb;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		struct nvme_speed_switch_stats *stat = per_cpu_ptr(sw->stats, cpu);
+
+		read_bytes += stat->read_bytes;
+		write_bytes += stat->write_bytes;
+		stat->read_bytes = 0;
+		stat->write_bytes = 0;
+	}
+
+	read_kb = read_bytes / 1024;
+	write_kb = write_bytes / 1024;
+	dev_dbg(ctrl->device,
+		"I/O in window: read=%lu KB, write=%lu KB, threshold=%u KB\n",
+		read_kb, write_kb, READ_ONCE(sw->threshold));
+
+	if (read_kb >= sw->threshold || write_kb >= sw->threshold)
+		return sw->max_speed;
+	return sw->min_speed;
+}
+
+static void nvme_speed_switch_timer_fn(struct timer_list *t)
+{
+	struct nvme_speed_switch *sw = container_of(t, struct nvme_speed_switch, timer);
+
+	if (!READ_ONCE(sw->enabled)) {
+		atomic_set(&sw->timer_active, NVME_SPEED_TIMER_INACTIVE);
+		return;
+	}
+
+	sw->target_speed = nvme_check_io_and_decide_speed(sw);
+	if (sw->target_speed != READ_ONCE(sw->cur_speed))
+		schedule_work(&sw->work);
+
+	mod_timer(t, jiffies + msecs_to_jiffies(READ_ONCE(sw->monitor_interval)));
+}
+
+static void nvme_speed_switch_params_init(struct nvme_speed_switch *sw)
+{
+	sw->monitor_interval = 100;
+	sw->min_speed = PCI_EXP_LNKSTA_CLS_2_5GB;
+}
+
+void nvme_speed_switch_init(struct nvme_ctrl *ctrl)
+{
+	struct nvme_speed_switch *sw = &ctrl->speed_switch;
+	struct pci_dev *pdev;
+	int max_speed;
+
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_HYGON) {
+		dev_dbg(ctrl->device,
+			"link rate switching is only supported on Hygon platforms\n");
+		return;
+	}
+
+	if (!dev_is_pci(ctrl->dev)) {
+		dev_err(ctrl->device, "link rate switching requires a PCI device\n");
+		return;
+	}
+	pdev = to_pci_dev(ctrl->dev);
+	if (!pdev->bus->self) {
+		dev_err(ctrl->device,
+			"link rate switching requires a PCIe upstream port\n");
+		return;
+	}
+
+	nvme_speed_switch_params_init(sw);
+
+	max_speed = nvme_get_max_link_speed(pdev->bus->self);
+	if (max_speed <= sw->min_speed) {
+		dev_err(ctrl->device,
+			"invalid link rate range: min=Gen%u, max=Gen%d\n",
+			sw->min_speed, max_speed);
+		return;
+	}
+	sw->max_speed = max_speed;
+
+	sw->stats = alloc_percpu(struct nvme_speed_switch_stats);
+	if (!sw->stats) {
+		dev_err(ctrl->device, "failed to allocate per-CPU I/O statistics\n");
+		return;
+	}
+	nvme_clear_io_stats(sw);
+
+	WRITE_ONCE(sw->cur_speed, sw->max_speed);
+	WRITE_ONCE(sw->threshold, nvme_calc_speed_threshold(sw, pcie_get_width_cap(pdev)));
+	if (!READ_ONCE(sw->threshold)) {
+		dev_err(ctrl->device, "failed to compute speed switch threshold\n");
+		free_percpu(sw->stats);
+		sw->stats = NULL;
+		return;
+	}
+
+	INIT_WORK(&sw->work, nvme_speed_switch_work);
+	timer_setup(&sw->timer, nvme_speed_switch_timer_fn, 0);
+	atomic_set(&sw->timer_active, NVME_SPEED_TIMER_INACTIVE);
+	WRITE_ONCE(sw->enabled, true);
+	sw->initialized = true;
+
+	dev_info(ctrl->device,
+		 "NVMe link rate switching initialized (min Gen%u, max Gen%d)\n",
+		 sw->min_speed, sw->max_speed);
+}
+
+void nvme_speed_switch_start(struct nvme_ctrl *ctrl)
+{
+	struct nvme_speed_switch *sw = &ctrl->speed_switch;
+
+	if (!READ_ONCE(sw->enabled))
+		return;
+
+	atomic_set(&sw->timer_active, NVME_SPEED_TIMER_ACTIVE);
+	mod_timer(&sw->timer, jiffies + msecs_to_jiffies(READ_ONCE(sw->monitor_interval)));
+}
+
+void nvme_speed_switch_exit(struct nvme_ctrl *ctrl)
+{
+	struct nvme_speed_switch *sw = &ctrl->speed_switch;
+
+	if (!sw->initialized)
+		return;
+
+	sw->initialized = false;
+	WRITE_ONCE(sw->enabled, false);
+	timer_delete_sync(&sw->timer);
+	cancel_work_sync(&sw->work);
+
+	free_percpu(sw->stats);
+	sw->stats = NULL;
+}
diff --git a/drivers/pci/pcie/bwctrl.c b/drivers/pci/pcie/bwctrl.c
index d48021bfd844..4b28e26f9531 100644
--- a/drivers/pci/pcie/bwctrl.c
+++ b/drivers/pci/pcie/bwctrl.c
@@ -156,6 +156,7 @@ int pcie_set_target_speed(struct pci_dev *port, enum pci_bus_speed speed_req,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(pcie_set_target_speed);
 
 static void pcie_bwnotif_enable(struct pcie_device *srv)
 {
-- 
2.43.0


