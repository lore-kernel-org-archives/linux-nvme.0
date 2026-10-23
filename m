Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AEE60A3801
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=rkuYWTXf;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=hZteDLc3;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=VpruVyvh
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=zD22UARBNeX7JJbyhczF12Ctfee8lNQxiurh9inSACI=; b=rkuYWTXf2+4Z+q
	4QOc7zZDfot8mzOPoc3J8KGvVvKKUPS6BQv6SAcN4qjZCNMHupChI9EGzCnkv+F75qbOTScDJJvW8
	HQaQbqZG5uZ5jjaZ2tc1fKb2BHPQxJP9o7vmP3DT89sHR2miyknNtKh/tOuHehJymN57KLVX+tKIE
	DK83DQ9hF0tFEfvq+RG9edPgxplITRHEugsYJUVh8b9zGlSoJEQiQ2VHvgmzYCk10psrWbC1nQCIv
	fGOk8Nl36pxfP1ZYQqpG9OhUvn2TB82IWdgRCNBemTPeT7uPPpNI0lTyak+jBahNtgnJNNevV8fgf
	Gh0aJ8534FU28JCmCAKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9JE-0000000Fhdu-3Cw8;
	Fri, 23 Oct 2026 07:03:25 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9JC-0000000FhcN-2xJJ
	for linux-nvme@bombadil.infradead.org;
	Fri, 23 Oct 2026 07:03:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=zD22UARBNeX7JJbyhczF12Ctfee8lNQxiurh9inSACI=; b=hZteDLc3HfUTjNj5bSJGYboGqL
	cdGSPXWZawwiXWpHC3GOqdJJ88OhspRW+VONosKObvYbs5bmVrsr3w/ogQav0Uw2qXciEjcx8XJQu
	dsQlhFkGr7smw6uIAvDzlqme9mYf1+Oq/yUg+sUgn2or29VnmO62TCTfvHyaeMYr9VJ/FTn0GU7tF
	RTM9wkg2uiYhp2twNEcJ32dk9toE6Qf9veXPpGbIwjkiHITlxfKYZRcbT9Si+BI8HqLaLvmuad2oR
	xPie0fEwUV+ksWLaaViJ+vcuPUvxOO859F8XBHcW/WDAlFXi65vKXDMp8SQu8A4XZHOPLWwur02AW
	xH5mclMA==;
Received: from out199-13.us.a.mail.aliyun.com ([47.90.199.13])
	by casper.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9J9-00000009wMz-1ARM
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 07:03:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792738973; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=zD22UARBNeX7JJbyhczF12Ctfee8lNQxiurh9inSACI=;
	b=VpruVyvh+OeKmTu54A4N0NLfmj2tD5xrZQ5Xn9PZ3CPpOcKJWZc1qfE3/HomeMdthgbqSCTcL2hEXRzXzCjThOnGJe4G9Zja3eDyRloUHzrVO3p8nB309SIAc9ukEXKUOepsTsfFcUYOYK72+KTjZSxalipJ2f3efMHKjmYqbjI=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDLKYIb_1792738970;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDLKYIb_1792738970 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Oct 2026 15:02:51 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 1/3] nvme-multipath: implement service-time iopolicy
Date: Fri, 23 Oct 2026 15:02:39 +0800
Message-ID: <20261023070243.2495522-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261023070243.2495522-1-kanie@linux.alibaba.com>
References: <20261023070243.2495522-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_080319_823053_910A1766 
X-CRM114-Status: GOOD (  26.09  )
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
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The queue-depth iopolicy balances paths by the number of in-flight
requests. This misjudges the load in two common cases: a 128K request
counts the same as a 4K one, and there is no way to tell the selector
that one path is simply faster than another. With mixed I/O sizes or
paths of different bandwidth, large I/Os keep piling onto the slow
path, driving up tail latencies.

Add a "service-time" iopolicy adapted from the dm-ps-service-time
path selector. It selects the path with the lowest estimated service
time, computed as in_flight_bytes / relative_throughput, so it tracks
actual bytes in flight rather than request counts, and users can
weight paths according to their throughput.

Each path keeps the total in-flight I/O size and a relative throughput
weight as controller state, exposed through two new sysfs attributes
on the path namespace devices: in_flight_bytes (read-only) reports the
tracked load, and relative_throughput (read-write, 0-100, default 1)
sets the weight. Setting relative_throughput to 0 makes the path a
standby that is only selected when no path with a positive value is
available, matching DM service-time semantics.

As in dm-ps-service-time, the path comparison cross-multiplies to
avoid division, and shifts the load counters down when they grow too
large to keep the products in range.

Failovers release the accounted bytes in nvme_failover_req() before
blk_steal_bios() clears the request data length.  The release clamps
at zero: a request requeued across a controller reset completes
against a counter that nvme_mpath_init_identify() has re-zeroed, and
a plain subtraction would underflow, the case that
atomic_dec_if_positive() guards against in the queue-depth
accounting.

Usage:
  echo service-time > /sys/module/nvme_core/parameters/iopolicy
  echo 4 > /sys/block/nvmeXcYnZ/relative_throughput

Test environment:
  Two QEMU/KVM VMs connected via NVMe-oF TCP, 32 vCPU / 32G RAM each.
  The target exports a 1G RAM disk via nvmet-tcp on two ports, and the
  initiator connects both ports to form a native NVMe multipath device.

  Asymmetric bandwidth is created by shaping the second path with
  tc-tbf (rate 500mbit, burst 128kb, latency 5ms). Measured single
  path bandwidth: ~237 MiB/s unshaped vs ~56 MiB/s shaped, a ratio
  of approximately 4:1.

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
 drivers/nvme/host/multipath.c | 189 +++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h      |   6 ++
 drivers/nvme/host/sysfs.c     |   5 +-
 3 files changed, 197 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 99ecc73393e58..3d82917846a88 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -69,6 +69,7 @@ static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_NUMA]	= "numa",
 	[NVME_IOPOLICY_RR]	= "round-robin",
 	[NVME_IOPOLICY_QD]      = "queue-depth",
+	[NVME_IOPOLICY_ST]	= "service-time",
 };
 
 static int iopolicy = NVME_IOPOLICY_NUMA;
@@ -107,7 +108,7 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
 module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
 	&iopolicy, 0644);
 MODULE_PARM_DESC(iopolicy,
-	"Default multipath I/O policy; 'numa' (default), 'round-robin' or 'queue-depth'");
+	"Default multipath I/O policy; 'numa' (default), 'round-robin', 'queue-depth' or 'service-time'");
 
 void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
 {
@@ -144,6 +145,24 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 			blk_freeze_queue_start(h->disk->queue);
 }
 
+/*
+ * Release in-flight bytes without letting the counter go negative: a
+ * request that sat in a requeue list across a controller reset is
+ * accounted against the pre-reset counter, but completes after
+ * nvme_mpath_init_identify() has zeroed it, in which case the plain
+ * subtraction would underflow.  This mirrors atomic_dec_if_positive()
+ * in the queue-depth accounting.
+ */
+static void nvme_st_release(struct nvme_ctrl *ctrl, unsigned int bytes)
+{
+	s64 old, new;
+
+	do {
+		old = atomic64_read(&ctrl->in_flight_size);
+		new = max_t(s64, 0, old - bytes);
+	} while (!atomic64_try_cmpxchg(&ctrl->in_flight_size, &old, new));
+}
+
 void nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
@@ -164,6 +183,15 @@ void nvme_failover_req(struct request *req)
 		queue_work(nvme_wq, &ns->ctrl->ana_work);
 	}
 
+	/*
+	 * blk_steal_bios() clears req->__data_len, so release the bytes
+	 * accounted by the service-time policy before stealing the bios.
+	 */
+	if (nvme_req(req)->flags & NVME_MPATH_CNT_ACTIVE_BYTES) {
+		nvme_st_release(ns->ctrl, blk_rq_bytes(req));
+		nvme_req(req)->flags &= ~NVME_MPATH_CNT_ACTIVE_BYTES;
+	}
+
 	spin_lock_irqsave(&ns->head->requeue_lock, flags);
 	for (bio = req->bio; bio; bio = bio->bi_next)
 		bio_set_dev(bio, ns->head->disk->part0);
@@ -179,11 +207,16 @@ void nvme_mpath_start_request(struct request *rq)
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
 
 	if (!blk_queue_io_stat(disk->queue) ||
@@ -205,6 +238,10 @@ void nvme_mpath_end_request(struct request *rq)
 
 	if (nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)
 		atomic_dec_if_positive(&ns->ctrl->nr_active);
+	if (nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE_BYTES) {
+		nvme_st_release(ns->ctrl, blk_rq_bytes(rq));
+		nvme_req(rq)->flags &= ~NVME_MPATH_CNT_ACTIVE_BYTES;
+	}
 
 	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
@@ -464,6 +501,109 @@ static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
 	return best_opt ? best_opt : best_nonopt;
 }
 
+#define ST_MAX_RELATIVE_THROUGHPUT	100
+#define ST_MAX_RELATIVE_THROUGHPUT_SHIFT	7
+#define ST_MAX_INFLIGHT_SIZE \
+	(U64_MAX >> ST_MAX_RELATIVE_THROUGHPUT_SHIFT)
+
+/*
+ * Compare estimated service time of two paths.
+ * Returns negative if ns1 is better, positive if ns2 is better, 0 if equal.
+ *
+ * Service time = in_flight_size / relative_throughput
+ * Cross-multiply to avoid division.
+ */
+static int nvme_st_compare_load(struct nvme_ns *ns1, struct nvme_ns *ns2)
+{
+	u64 sz1, sz2, st1, st2;
+	unsigned int tp1 = ns1->ctrl->relative_throughput;
+	unsigned int tp2 = ns2->ctrl->relative_throughput;
+
+	sz1 = atomic64_read(&ns1->ctrl->in_flight_size);
+	sz2 = atomic64_read(&ns2->ctrl->in_flight_size);
+
+	/* Case 1: same throughput — compare load directly */
+	if (tp1 == tp2)
+		return (sz1 > sz2) - (sz1 < sz2);
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
+	 *   st1 = sz1 / tp1
+	 *   st2 = sz2 / tp2
+	 * Equivalent (since tp > 0):
+	 *   sz1 * tp2 <=> sz2 * tp1
+	 *
+	 * Use comparisons instead of subtractions when returning: the
+	 * intermediate values do not fit into the int return type.
+	 */
+	if (unlikely(sz1 >= ST_MAX_INFLIGHT_SIZE ||
+		     sz2 >= ST_MAX_INFLIGHT_SIZE)) {
+		sz1 >>= ST_MAX_RELATIVE_THROUGHPUT_SHIFT;
+		sz2 >>= ST_MAX_RELATIVE_THROUGHPUT_SHIFT;
+	}
+	st1 = sz1 * tp2;
+	st2 = sz2 * tp1;
+	if (st1 != st2)
+		return (st1 > st2) - (st1 < st2);
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
+			    nvme_st_compare_load(ns, best_opt) < 0)
+				best_opt = ns;
+			break;
+		case NVME_ANA_NONOPTIMIZED:
+			if (!best_nonopt ||
+			    nvme_st_compare_load(ns, best_nonopt) < 0)
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
@@ -491,6 +631,8 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 		return nvme_queue_depth_path(head);
 	case NVME_IOPOLICY_RR:
 		return nvme_round_robin_path(head);
+	case NVME_IOPOLICY_ST:
+		return nvme_service_time_path(head);
 	default:
 		return nvme_numa_path(head);
 	}
@@ -1110,6 +1252,47 @@ static ssize_t queue_depth_show(struct device *dev,
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
@@ -1435,6 +1618,7 @@ void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl)
 	mutex_init(&ctrl->ana_lock);
 	timer_setup(&ctrl->anatt_timer, nvme_anatt_timeout, 0);
 	INIT_WORK(&ctrl->ana_work, nvme_ana_work);
+	ctrl->relative_throughput = 1;
 }
 
 int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
@@ -1450,6 +1634,7 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 
 	/* initialize this in the identify path to cover controller resets */
 	atomic_set(&ctrl->nr_active, 0);
+	atomic64_set(&ctrl->in_flight_size, 0);
 
 	if (!ctrl->max_namespaces ||
 	    ctrl->max_namespaces > le32_to_cpu(id->nn)) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a643c4723a69b..02cdd55350911 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -268,6 +268,7 @@ enum {
 	NVME_REQ_USERCMD		= (1 << 1),
 	NVME_MPATH_IO_STATS		= (1 << 2),
 	NVME_MPATH_CNT_ACTIVE		= (1 << 3),
+	NVME_MPATH_CNT_ACTIVE_BYTES	= (1 << 4),
 };
 
 static inline struct nvme_request *nvme_req(struct request *req)
@@ -438,6 +439,8 @@ struct nvme_ctrl {
 	struct timer_list anatt_timer;
 	struct work_struct ana_work;
 	atomic_t nr_active;
+	atomic64_t in_flight_size;
+	u8 relative_throughput;
 #endif
 
 #ifdef CONFIG_NVME_HOST_AUTH
@@ -491,6 +494,7 @@ enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
 	NVME_IOPOLICY_QD,
+	NVME_IOPOLICY_ST,
 };
 
 struct nvme_subsystem {
@@ -1095,6 +1099,8 @@ extern bool multipath;
 extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
 extern struct device_attribute dev_attr_queue_depth;
+extern struct device_attribute dev_attr_in_flight_bytes;
+extern struct device_attribute dev_attr_relative_throughput;
 extern struct device_attribute dev_attr_numa_nodes;
 extern struct device_attribute dev_attr_delayed_removal_secs;
 extern struct device_attribute dev_attr_multipath_failover_count;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index e1e3dcfd084be..a46e7db4934a7 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -262,6 +262,8 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_ana_grpid.attr,
 	&dev_attr_ana_state.attr,
 	&dev_attr_queue_depth.attr,
+	&dev_attr_in_flight_bytes.attr,
+	&dev_attr_relative_throughput.attr,
 	&dev_attr_numa_nodes.attr,
 	&dev_attr_delayed_removal_secs.attr,
 #endif
@@ -296,7 +298,8 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
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


