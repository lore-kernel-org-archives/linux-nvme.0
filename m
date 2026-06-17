Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448B6CD98F0
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jun 2026 11:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3nSeiE6GtbYomCjUPn1NRmBKqU6AsCRuGaB5Xcz7aYo=; b=hFRcBdD3G5mmMM+kQiWsxURXKe
	RVpgUBUgNau/SlaGJGV2oPxPo3cjm8H5w5zCH2rsrMzw3Z1YZKTU+wk+yC9B/rpnLWyusLwiB6dfp
	GqEuAS/OsDV3XmKApm532PhZrz9K3c9lwAzHg3xnRXCSBjTIZrV6tlAGkI+Q0Kw7lsY7a/VGft0an
	70ai3fUct4QP/TjvGQNbE5mTqOfvAW+x7aLfiowboVU1K2e2GqNoDX58e6rPi/gIZygzqdMdnPHPw
	G0NQYiCZ9t/FsqexAF5SPoVYsQDGmqH6jHMCE8o6oQcjWY0nsYri7KiRniAuSNB+MDSv6hzxCukrE
	YVZBBoxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZoiz-0000000HG28-0nhZ;
	Wed, 17 Jun 2026 11:46:29 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wZoiw-0000000HFyL-1ReI
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jun 2026 11:46:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781696777; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=3nSeiE6GtbYomCjUPn1NRmBKqU6AsCRuGaB5Xcz7aYo=;
	b=aGxo9+1ZeRVGCYjAOwHCsU8lxsJfcUu7RYjJ8c9/V3owXRhWZcC1cWPmMJXY97Wut2kbVQTj7I2AUPMZx3QJ8aAhAdmII0tIlO/iOaVT1jSXQ5QhQedP5N+NFUB7q91My9DDadvuOeq81jYR4xmpWvJflrKvr5SZvMS3Nfee6Dc=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X53c97Q_1781696768;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X53c97Q_1781696768 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 17 Jun 2026 19:46:12 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	onathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-nvme@lists.infradead.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/2] nvme-multipath: add service-time I/O policy
Date: Wed, 17 Jun 2026 19:45:58 +0800
Message-ID: <20260617114602.2224074-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260617114602.2224074-1-kanie@linux.alibaba.com>
References: <20260617114602.2224074-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260617_044626_990632_9478E97D 
X-CRM114-Status: GOOD (  26.08  )
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

Add a new "service-time" I/O policy for NVMe native multipath, adapted
from the DM multipath service-time path selector (dm-ps-service-time).

Unlike the existing "queue-depth" policy which only counts the number of
in-flight I/Os, service-time estimates each path's service time by
dividing the total in-flight I/O size by a configurable relative
throughput weight:

    service_time = in_flight_size / relative_throughput

This provides more accurate load balancing when I/O sizes vary
significantly across paths, and allows users to assign throughput
weights to paths with different performance characteristics.

The comparison algorithm is directly adapted from dm-ps-service-time,
using cross-multiplication to avoid division and includes overflow
protection by shifting down when in-flight sizes are large.

Per-controller state:
  - in_flight_size: total bytes of in-flight I/Os (atomic_t)
  - relative_throughput: configurable weight 0-100, default 1

Sysfs interface (per path device):
  - in_flight_bytes (ro): current in-flight byte count
  - relative_throughput (rw): path throughput weight

Paths with relative_throughput set to 0 are not selected while other
paths with positive values are available, matching DM service-time
semantics.

Usage:
  echo service-time > /sys/module/nvme_core/parameters/iopolicy
  echo 4 > /sys/block/nvmeXcYnZ/relative_throughput

Test environment:
  Two QEMU/KVM VMs connected via NVMe-oF TCP, 32 vCPU / 32G RAM each.
  Target exports a 1G RAM disk (/dev/ram0) via nvmet-tcp subsystem
  "nqn.test.nvme-st" on two ports (192.168.1.20:4420 and
  192.168.2.20:4420). Initiator connects both paths to form a native
  NVMe multipath device. VM interconnects use QEMU socket networking
  (point-to-point virtual Ethernet).

  Asymmetric bandwidth is created using tc-tbf on the target side:
    Path 1 (enp0s3): no traffic shaping (measured ~237 MiB/s)
    Path 2 (enp0s4): tc qdisc add dev enp0s4 root tbf rate 500mbit
                     burst 128kb latency 5ms (measured ~56 MiB/s)
  Bandwidth ratio is approximately 4:1.

Test 1 - Uniform 4k random read (iodepth=64, numjobs=4, 15s):

  iopolicy              IOPS   BW(MiB/s)  avg_lat(us)  lat_stddev(us)
  --------------------  -----  ---------  -----------  --------------
  round-robin           59.1k  231        4316         3109
  queue-depth           59.0k  230        4323         3046
  service-time 1:1      59.3k  232        4302         3057
  service-time 4:1      61.0k  238        4179         1294

  With uniform I/O size, service-time 1:1 performs similarly to
  queue-depth since per-byte and per-request tracking are equivalent
  for fixed-size I/Os. service-time 4:1 with correct throughput
  weights improves IOPS by 3.4% and reduces latency stddev by 57%.

Test 2 - Mixed random read 4k/128k (bssplit=4k/50:128k/50,
         iodepth=64, numjobs=4, 15s):

  iopolicy              IOPS  BW(MiB/s)  avg_lat(us)  lat_stddev(us)
  --------------------  ----  ---------  -----------  --------------
  round-robin           7689  276        33209        46817
  queue-depth           7642  276        33429        45868
  service-time 1:1      7456  269        34279        47433
  service-time 4:1      7747  277        32998        27102

  With mixed I/O sizes on asymmetric paths, queue-depth treats 128K
  and 4K requests identically when counting in-flight depth, leading
  to suboptimal load distribution. service-time tracks actual bytes
  in flight, producing significantly more consistent tail latencies.
  service-time 4:1 vs queue-depth: latency stddev -41%.

Standby path (relative_throughput=0):
  Setting a path's relative_throughput to 0 correctly excludes it
  from selection. With the slow path set to 0, all I/O is directed
  to the fast path only (IO split 118052:0), verified via diskstats.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/multipath.c | 165 +++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h      |   6 ++
 drivers/nvme/host/sysfs.c     |   5 +-
 3 files changed, 173 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 263161cb8ac0..81fff2f20d23 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -69,6 +69,7 @@ static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_NUMA]	= "numa",
 	[NVME_IOPOLICY_RR]	= "round-robin",
 	[NVME_IOPOLICY_QD]      = "queue-depth",
+	[NVME_IOPOLICY_ST]	= "service-time",
 };
 
 static int iopolicy = NVME_IOPOLICY_NUMA;
@@ -83,6 +84,8 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
 		iopolicy = NVME_IOPOLICY_RR;
 	else if (!strncmp(val, "queue-depth", 11))
 		iopolicy = NVME_IOPOLICY_QD;
+	else if (!strncmp(val, "service-time", 12))
+		iopolicy = NVME_IOPOLICY_ST;
 	else
 		return -EINVAL;
 
@@ -97,7 +100,7 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
 module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
 	&iopolicy, 0644);
 MODULE_PARM_DESC(iopolicy,
-	"Default multipath I/O policy; 'numa' (default), 'round-robin' or 'queue-depth'");
+	"Default multipath I/O policy; 'numa' (default), 'round-robin', 'queue-depth' or 'service-time'");
 
 void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
 {
@@ -168,11 +171,16 @@ void nvme_mpath_start_request(struct request *rq)
 {
 	struct nvme_ns *ns = rq->q->queuedata;
 	struct gendisk *disk = ns->head->disk;
+	int iopolicy = READ_ONCE(ns->head->subsys->iopolicy);
 
-	if ((READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) &&
+	if (iopolicy == NVME_IOPOLICY_QD &&
 	    !(nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)) {
 		atomic_inc(&ns->ctrl->nr_active);
 		nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
+	} else if (iopolicy == NVME_IOPOLICY_ST &&
+		   !(nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE_BYTES)) {
+		atomic64_add(blk_rq_bytes(rq), &ns->ctrl->in_flight_size);
+		nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE_BYTES;
 	}
 
 	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq) ||
@@ -191,6 +199,10 @@ void nvme_mpath_end_request(struct request *rq)
 
 	if (nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)
 		atomic_dec_if_positive(&ns->ctrl->nr_active);
+	if (nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE_BYTES) {
+		atomic64_sub(blk_rq_bytes(rq), &ns->ctrl->in_flight_size);
+		nvme_req(rq)->flags &= ~NVME_MPATH_CNT_ACTIVE_BYTES;
+	}
 
 	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
@@ -427,6 +439,109 @@ static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
 	return best_opt ? best_opt : best_nonopt;
 }
 
+#define ST_MAX_RELATIVE_THROUGHPUT	100
+#define ST_MAX_RELATIVE_THROUGHPUT_SHIFT	7
+#define ST_MAX_INFLIGHT_SIZE \
+	((size_t)-1 >> ST_MAX_RELATIVE_THROUGHPUT_SHIFT)
+
+/*
+ * Compare estimated service time of two paths.
+ * Returns negative if ns1 is better, positive if ns2 is better, 0 if equal.
+ *
+ * Service time = (in_flight_size + incoming) / relative_throughput
+ * Cross-multiply to avoid division.
+ */
+static int nvme_st_compare_load(struct nvme_ns *ns1, struct nvme_ns *ns2,
+				size_t incoming)
+{
+	size_t sz1, sz2, st1, st2;
+	unsigned int tp1 = ns1->ctrl->relative_throughput;
+	unsigned int tp2 = ns2->ctrl->relative_throughput;
+
+	sz1 = atomic64_read(&ns1->ctrl->in_flight_size);
+	sz2 = atomic64_read(&ns2->ctrl->in_flight_size);
+
+	/* Case 1: same throughput — compare load directly */
+	if (tp1 == tp2)
+		return sz1 - sz2;
+
+	/*
+	 * Case 2a: same load — prefer higher throughput.
+	 * Case 2b: one path has zero throughput — prefer the other.
+	 */
+	if (sz1 == sz2 || !tp1 || !tp2)
+		return tp2 - tp1;
+
+	/*
+	 * Case 3: general comparison via cross-multiplication.
+	 *   st1 = (sz1 + incoming) / tp1
+	 *   st2 = (sz2 + incoming) / tp2
+	 * Equivalent (since tp > 0):
+	 *   (sz1 + incoming) * tp2 <=> (sz2 + incoming) * tp1
+	 */
+	sz1 += incoming;
+	sz2 += incoming;
+	if (unlikely(sz1 >= ST_MAX_INFLIGHT_SIZE ||
+		     sz2 >= ST_MAX_INFLIGHT_SIZE)) {
+		sz1 >>= ST_MAX_RELATIVE_THROUGHPUT_SHIFT;
+		sz2 >>= ST_MAX_RELATIVE_THROUGHPUT_SHIFT;
+	}
+	st1 = sz1 * tp2;
+	st2 = sz2 * tp1;
+	if (st1 != st2)
+		return st1 - st2;
+
+	/* Case 4: equal service time — prefer higher throughput */
+	return tp2 - tp1;
+}
+
+static struct nvme_ns *nvme_service_time_path(struct nvme_ns_head *head)
+{
+	struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
+	struct nvme_ns *fallback_opt = NULL, *fallback_nonopt = NULL;
+
+	list_for_each_entry_srcu(ns, &head->list, siblings,
+				 srcu_read_lock_held(&head->srcu)) {
+		if (nvme_path_is_disabled(ns))
+			continue;
+
+		/*
+		 * Paths with relative_throughput == 0 are only used when no
+		 * path with a positive value is available (matching DM
+		 * service-time semantics).
+		 */
+		if (!ns->ctrl->relative_throughput) {
+			if (ns->ana_state == NVME_ANA_OPTIMIZED && !fallback_opt)
+				fallback_opt = ns;
+			else if (ns->ana_state == NVME_ANA_NONOPTIMIZED &&
+				 !fallback_nonopt)
+				fallback_nonopt = ns;
+			continue;
+		}
+
+		switch (ns->ana_state) {
+		case NVME_ANA_OPTIMIZED:
+			if (!best_opt ||
+			    nvme_st_compare_load(ns, best_opt, 0) < 0)
+				best_opt = ns;
+			break;
+		case NVME_ANA_NONOPTIMIZED:
+			if (!best_nonopt ||
+			    nvme_st_compare_load(ns, best_nonopt, 0) < 0)
+				best_nonopt = ns;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (best_opt)
+		return best_opt;
+	if (best_nonopt)
+		return best_nonopt;
+	return fallback_opt ? fallback_opt : fallback_nonopt;
+}
+
 static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 {
 	return nvme_ctrl_state(ns->ctrl) == NVME_CTRL_LIVE &&
@@ -453,6 +568,8 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 		return nvme_queue_depth_path(head);
 	case NVME_IOPOLICY_RR:
 		return nvme_round_robin_path(head);
+	case NVME_IOPOLICY_ST:
+		return nvme_service_time_path(head);
 	default:
 		return nvme_numa_path(head);
 	}
@@ -1081,6 +1198,47 @@ static ssize_t queue_depth_show(struct device *dev,
 }
 DEVICE_ATTR_RO(queue_depth);
 
+static ssize_t in_flight_bytes_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	if (ns->head->subsys->iopolicy != NVME_IOPOLICY_ST)
+		return 0;
+
+	return sysfs_emit(buf, "%lld\n", atomic64_read(&ns->ctrl->in_flight_size));
+}
+DEVICE_ATTR_RO(in_flight_bytes);
+
+static ssize_t relative_throughput_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+
+	if (ns->head->subsys->iopolicy != NVME_IOPOLICY_ST)
+		return 0;
+
+	return sysfs_emit(buf, "%u\n", ns->ctrl->relative_throughput);
+}
+
+static ssize_t relative_throughput_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+	unsigned int val;
+	int ret;
+
+	ret = kstrtouint(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+	if (val > ST_MAX_RELATIVE_THROUGHPUT)
+		return -EINVAL;
+
+	ns->ctrl->relative_throughput = val;
+	return count;
+}
+DEVICE_ATTR_RW(relative_throughput);
+
 static ssize_t numa_nodes_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
@@ -1341,6 +1499,9 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 
 	/* initialize this in the identify path to cover controller resets */
 	atomic_set(&ctrl->nr_active, 0);
+	atomic64_set(&ctrl->in_flight_size, 0);
+	if (!ctrl->relative_throughput)
+		ctrl->relative_throughput = 1;
 
 	if (!ctrl->max_namespaces ||
 	    ctrl->max_namespaces > le32_to_cpu(id->nn)) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ccd5e05dac98..2b2627e0d3ce 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -261,6 +261,7 @@ enum {
 	NVME_REQ_USERCMD		= (1 << 1),
 	NVME_MPATH_IO_STATS		= (1 << 2),
 	NVME_MPATH_CNT_ACTIVE		= (1 << 3),
+	NVME_MPATH_CNT_ACTIVE_BYTES	= (1 << 4),
 };
 
 static inline struct nvme_request *nvme_req(struct request *req)
@@ -426,6 +427,8 @@ struct nvme_ctrl {
 	struct timer_list anatt_timer;
 	struct work_struct ana_work;
 	atomic_t nr_active;
+	atomic64_t in_flight_size;
+	u8 relative_throughput;
 #endif
 
 #ifdef CONFIG_NVME_HOST_AUTH
@@ -477,6 +480,7 @@ enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
 	NVME_IOPOLICY_QD,
+	NVME_IOPOLICY_ST,
 };
 
 struct nvme_subsystem {
@@ -1059,6 +1063,8 @@ extern bool multipath;
 extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
 extern struct device_attribute dev_attr_queue_depth;
+extern struct device_attribute dev_attr_in_flight_bytes;
+extern struct device_attribute dev_attr_relative_throughput;
 extern struct device_attribute dev_attr_numa_nodes;
 extern struct device_attribute dev_attr_delayed_removal_secs;
 extern struct device_attribute subsys_attr_iopolicy;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index e59758616f27..6309af224c93 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -259,6 +259,8 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_ana_grpid.attr,
 	&dev_attr_ana_state.attr,
 	&dev_attr_queue_depth.attr,
+	&dev_attr_in_flight_bytes.attr,
+	&dev_attr_relative_throughput.attr,
 	&dev_attr_numa_nodes.attr,
 	&dev_attr_delayed_removal_secs.attr,
 #endif
@@ -293,7 +295,8 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
 			return 0;
 	}
-	if (a == &dev_attr_queue_depth.attr || a == &dev_attr_numa_nodes.attr) {
+	if (a == &dev_attr_queue_depth.attr || a == &dev_attr_in_flight_bytes.attr ||
+	    a == &dev_attr_relative_throughput.attr || a == &dev_attr_numa_nodes.attr) {
 		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
 			return 0;
 	}
-- 
2.43.7


