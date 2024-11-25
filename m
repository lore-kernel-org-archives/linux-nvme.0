Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A3BD3B7FE
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 10:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mhx2JVixC5nC1re1UQcRIVbAzUv5mnn+1h0OxVB3UXw=; b=ShTP21/G4/nnyIgWmmu0DkcyhV
	UZPMxMvRhThb2XX4Ey/Z45lP5F+vsMjuTZ3aKt0Ddgz9zg+jFUAJJlShZ/8HbdxWIB+RZ96ia559o
	mrDiBfh8OdgfLygFwegerpeKzL7Y3tihqeriaKUm/V6MEqGkXfmi6C2cX27aKRWr86gJHhij2a3En
	SiAVbR7UFHz5w9NNfBZ2w30COjRhEN6onT94Lk7nLt5PzSYaR9NUaEUzgUnodOVx+kXVnuMc/KeLO
	ls6JD9T4xGIqQw5SKY2kI2iKetQdXAENR4UIPWYP3ldbR/i/BCz/kVufg33okV4acoJFFdv41DGTl
	ZFthd5vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFWUk-00000007mYa-355S;
	Mon, 25 Nov 2024 10:39:06 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFWUi-00000007mWf-0H2s
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 10:39:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732531141; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=mhx2JVixC5nC1re1UQcRIVbAzUv5mnn+1h0OxVB3UXw=;
	b=Tj2hd6N76f2HCIxe019SVBSsOtjkNuSm0IGnhOhA+h3NAckCCURLAqb3TkNhOmu6pRD+vs9ArFvhf+5YJM79T752JCKpjoIneFH1BgmXrrtf1+HFFgQbWxBBVGidgliLbOrlVpZa9fBmXzQR8T7JqaBXZfG23h5VE9Np1KDzdZo=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WKAdA4M_1732531134 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 25 Nov 2024 18:38:59 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v4 1/2] nvme-multipath: introduce service-time iopolicy
Date: Mon, 25 Nov 2024 18:38:47 +0800
Message-ID: <20241125103848.67212-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241125103848.67212-1-kanie@linux.alibaba.com>
References: <20241125103848.67212-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241125_023904_246623_CE05BFB8 
X-CRM114-Status: GOOD (  16.84  )
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

In scenarios with varying random I/O sizes, the different I/O sizes
being processed on each path can lead to slower processing and higher
latency on paths under heavy load.

The service-time policy can dispatch I/O to the path with the lowest
total amount of currently processed I/O, ensuring that new I/O can be
sent to less-loaded paths when some paths are overloaded, thereby
achieving lower latency and higher throughput.

Introduce a atomic64_t inflight_size to record the total I/O size
that the path is processing, and choosing a path with lowest
inflight_size to send the I/O.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/multipath.c | 53 ++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h      |  3 ++
 2 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 6a15873055b9..46df50ad1bfa 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -18,6 +18,7 @@ static const char *nvme_iopolicy_names[] = {
 	[NVME_IOPOLICY_NUMA]	= "numa",
 	[NVME_IOPOLICY_RR]	= "round-robin",
 	[NVME_IOPOLICY_QD]      = "queue-depth",
+	[NVME_IOPOLICY_ST]	= "service-time",
 };
 
 static int iopolicy = NVME_IOPOLICY_NUMA;
@@ -32,6 +33,8 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
 		iopolicy = NVME_IOPOLICY_RR;
 	else if (!strncmp(val, "queue-depth", 11))
 		iopolicy = NVME_IOPOLICY_QD;
+	else if (!strncmp(val, "service-time", 12))
+		iopolicy = NVME_IOPOLICY_ST;
 	else
 		return -EINVAL;
 
@@ -46,7 +49,7 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
 module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
 	&iopolicy, 0644);
 MODULE_PARM_DESC(iopolicy,
-	"Default multipath I/O policy; 'numa' (default), 'round-robin' or 'queue-depth'");
+	"Default multipath I/O policy; 'numa' (default), 'round-robin', 'queue-depth' or 'service-time'");
 
 void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
 {
@@ -136,6 +139,11 @@ void nvme_mpath_start_request(struct request *rq)
 		nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
 	}
 
+	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_ST) {
+		atomic64_add(blk_rq_bytes(rq), &ns->ctrl->inflight_size);
+		nvme_req(rq)->flags |= NVME_MPATH_CNT_IOSIZE;
+	}
+
 	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
 		return;
 
@@ -152,6 +160,9 @@ void nvme_mpath_end_request(struct request *rq)
 	if (nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)
 		atomic_dec_if_positive(&ns->ctrl->nr_active);
 
+	if (nvme_req(rq)->flags & NVME_MPATH_CNT_IOSIZE)
+		atomic64_sub(blk_rq_bytes(rq), &ns->ctrl->inflight_size);
+
 	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
 	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
@@ -405,9 +416,48 @@ static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
 	return ns;
 }
 
+static struct nvme_ns *nvme_service_time_path(struct nvme_ns_head *head)
+{
+	struct nvme_ns *opt = NULL, *nonopt = NULL, *ns;
+	s64 min_inflight_nonopt = S64_MAX;
+	s64 min_inflight_opt = S64_MAX;
+	s64 inflight;
+
+	list_for_each_entry_rcu(ns, &head->list, siblings) {
+		if (nvme_path_is_disabled(ns))
+			continue;
+
+		inflight = atomic64_read(&ns->ctrl->inflight_size);
+
+		switch (ns->ana_state) {
+		case NVME_ANA_OPTIMIZED:
+			if (inflight < min_inflight_opt) {
+				min_inflight_opt = inflight;
+				opt = ns;
+			}
+			break;
+		case NVME_ANA_NONOPTIMIZED:
+			if (inflight < min_inflight_nonopt) {
+				min_inflight_nonopt = inflight;
+				nonopt = ns;
+			}
+			break;
+		default:
+			break;
+		}
+
+		if (min_inflight_opt == 0)
+			return opt;
+	}
+
+	return opt ? opt : nonopt;
+}
+
 inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 {
 	switch (READ_ONCE(head->subsys->iopolicy)) {
+	case NVME_IOPOLICY_ST:
+		return nvme_service_time_path(head);
 	case NVME_IOPOLICY_QD:
 		return nvme_queue_depth_path(head);
 	case NVME_IOPOLICY_RR:
@@ -1040,6 +1090,7 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 
 	/* initialize this in the identify path to cover controller resets */
 	atomic_set(&ctrl->nr_active, 0);
+	atomic64_set(&ctrl->inflight_size, 0);
 
 	if (!ctrl->max_namespaces ||
 	    ctrl->max_namespaces > le32_to_cpu(id->nn)) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 093cb423f536..bf6c74fdc9ba 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -202,6 +202,7 @@ enum {
 	NVME_REQ_USERCMD		= (1 << 1),
 	NVME_MPATH_IO_STATS		= (1 << 2),
 	NVME_MPATH_CNT_ACTIVE		= (1 << 3),
+	NVME_MPATH_CNT_IOSIZE		= (1 << 4),
 };
 
 static inline struct nvme_request *nvme_req(struct request *req)
@@ -367,6 +368,7 @@ struct nvme_ctrl {
 	struct timer_list anatt_timer;
 	struct work_struct ana_work;
 	atomic_t nr_active;
+	atomic64_t inflight_size;
 #endif
 
 #ifdef CONFIG_NVME_HOST_AUTH
@@ -416,6 +418,7 @@ enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
 	NVME_IOPOLICY_QD,
+	NVME_IOPOLICY_ST,
 };
 
 struct nvme_subsystem {
-- 
2.43.0


